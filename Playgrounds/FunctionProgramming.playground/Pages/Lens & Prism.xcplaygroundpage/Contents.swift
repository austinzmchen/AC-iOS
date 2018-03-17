//: Playground - noun: a place where people can play

import Foundation

struct Lens<Whole,Part> {
    let get: (Whole) -> Part
    let set: (Part) -> (Whole) -> Whole
}

struct Prism<Whole,Part> {
    let tryGet: (Whole) -> Part?
    let inject: (Part) -> Whole
}

enum ViewState<T> {
    case empty
    case processing(String)
    case failed(Error)
    case completed(T)
}

struct LoginPage {
    var title: String
    var credendials: CredentialBox
    var buttonState: ViewState<Button>
}

struct CredentialBox {
    var usernameField: TextField
    var passwordField: TextField
}

struct TextField {
    var text: String
    var placeholder: String?
    var secureText: Bool
}

struct Button {
    var title: String
    var enabled: Bool
}

extension CredentialBox {
    enum lens {
        static let usernameField = Lens<CredentialBox,TextField>.init(
            get: { $0.usernameField },
            set: { part in
                { whole in
                    var m = whole
                    m.usernameField = part
                    return m
                }
        })
    }
}

extension ViewState {
    enum prism {
        static var processing: Prism<ViewState,String> {
            return Prism<ViewState,String>.init(
                tryGet: {
                    guard case .processing(let message) = $0 else {
                        return nil
                    }
                    return message
            },
                inject: { .processing($0) })
        }
    }
}

let initialState = (
    title: "Welcome back!",
    username: "savedUsername",
    buttonState: ViewState<Button>.completed(Button.init(
        title: "Login",
        enabled: false)))


