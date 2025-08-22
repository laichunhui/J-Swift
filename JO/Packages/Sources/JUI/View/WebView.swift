//
//  File.swift
//  Packages
//
//  Created by work on 17/12/24.
//

import SwiftUI
import WebKit

/// SwiftUI web view wrapper for `WKWebView`.
public struct WebView: UIViewRepresentable {
    var url: URL
    @Binding var isLoading: Bool
    @Binding var title: String?
    @Binding var error: Error?
    
    public init(url: URL, isLoading: Binding<Bool>, title: Binding<String?>, error: Binding<Error?>) {
        self.url = url
        self._isLoading = isLoading
        self._title = title
        self._error = error
    }

    public func makeCoordinator() -> Coordinator {
        Coordinator(
            webView: self,
            isLoading: $isLoading,
            title: $title,
            error: $error
        )
    }

    public func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView(frame: CGRect.zero)
        webView.navigationDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.isScrollEnabled = true
        webView.load(URLRequest(url: url))
        return webView.withAccessibilityIdentifier(identifier: "WKWebView")
    }

    public func updateUIView(_ webView: WKWebView, context: Context) {
        // We don't need handling updates of the view at the moment.
    }

    public class Coordinator: NSObject, WKNavigationDelegate {
        var parent: WebView
        var isLoading: Binding<Bool>
        var title: Binding<String?>
        var error: Binding<Error?>

        init(
            webView: WebView,
            isLoading: Binding<Bool>,
            title: Binding<String?>,
            error: Binding<Error?>
        ) {
            parent = webView
            self.isLoading = isLoading
            self.title = title
            self.error = error
        }

        public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            isLoading.wrappedValue = true
        }

        public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            isLoading.wrappedValue = false

            webView.evaluateJavaScript("document.title") { data, _ in
                if let title = data as? String, !title.isEmpty {
                    self.title.wrappedValue = title
                }
            }
        }

        public func webView(
            _ webView: WKWebView,
            didFailProvisionalNavigation navigation: WKNavigation!,
            withError error: Error
        ) {
            isLoading.wrappedValue = false
            self.error.wrappedValue = error
        }

        public func webView(
            _ webView: WKWebView,
            didFail navigation: WKNavigation!,
            withError error: Error
        ) {
            isLoading.wrappedValue = false
            self.error.wrappedValue = error
        }
    }
}

extension UIView {
    func withAccessibilityIdentifier(identifier: String) -> Self {
        accessibilityIdentifier = identifier
        return self
    }
}

//struct WebView: UIViewRepresentable {
//    let url: URL
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        return webView
//    }
//
//    func updateUIView(_ webView: WKWebView, context: Context) {
//        let request = URLRequest(url: url)
//        webView.load(request)
//    }
//
//    func makeCoordinator() -> Coordinator {
//        Coordinator()
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
//            print("WebView error: \(error.localizedDescription)")
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            print("WebView finished loading")
//        }
//    }
//}
