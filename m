Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9EE1CD4F3C
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 07:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 34D6210F23F;
	Thu, 21 May 2026 07:53:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="xhTIw633";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 40C1510F23F
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:52:58 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id A4BFC42AE0;
 Thu, 21 May 2026 07:52:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7A06FC2BCB9;
 Thu, 21 May 2026 07:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux.dev; s=korg;
 t=1779349977; bh=g5lNOWZdFZ078Eg8FihJThI93jDxzsjGBAigjw8fo38=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=xhTIw633sN19LCBdjB1HTf9dSgzdyM88djd03g3BpnZHdUyCCkbcKfy36L1S7zUB3
 hwfBhn5IG72NrMEjIvZwX/q0t4z3l9jlJ/GykCpm20eLuBbUblip4QWbimYlbDI7JB
 b+IP+0hfTs0YUy63TXNSrCWCoc6HEQ7tal7tCB6o=
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org
 (localhost.localdomain [127.0.0.1])
 by smtp.lore.kernel.org (Postfix) with ESMTP id 59F92CD4F5E;
 Thu, 21 May 2026 07:52:57 +0000 (UTC)
From: Alvin Sun <alvin.sun@linux.dev>
Date: Thu, 21 May 2026 15:52:53 +0800
Subject: [PATCH v2 1/7] rust: module: add `THIS_MODULE` const to
 `ModuleMetadata` trait
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260521-fix-fops-owner-v2-1-fd99079c5a04@linux.dev>
References: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
In-Reply-To: <20260521-fix-fops-owner-v2-0-fd99079c5a04@linux.dev>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
 Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
 Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Arnd Bergmann <arnd@arndb.de>, Brendan Higgins <brendan.higgins@linux.dev>, 
 David Gow <david@davidgow.net>, Rae Moar <raemoar63@gmail.com>, 
 Breno Leitao <leitao@debian.org>, Jens Axboe <axboe@kernel.dk>
Cc: rust-for-linux@vger.kernel.org, linux-modules@vger.kernel.org, 
 driver-core@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 nova-gpu@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 kunit-dev@googlegroups.com, linux-block@vger.kernel.org, 
 Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779349975; l=3841;
 i=alvin.sun@linux.dev; s=20260317; h=from:subject:message-id;
 bh=g5lNOWZdFZ078Eg8FihJThI93jDxzsjGBAigjw8fo38=;
 b=FhGtAlbF3396Z+dQAsyxXzU2I9Oz+YJMiNSCAigLuceECR4JjS9R0/Tvaps4sBC+ytD60pqQZ
 Arr+EzySJNWBLxRc55m2GilIMFF4U2MTiMxCo80BR4hrhjbfpnj+i/w
X-Developer-Key: i=alvin.sun@linux.dev; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for alvin.sun@linux.dev/20260317 with
 auth_id=684
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Add a `THIS_MODULE` const to the `ModuleMetadata` trait so that
modules can provide their `ThisModule` pointer usable in const
contexts such as static file_operations.

Move the `THIS_MODULE` static from the `module!` macro into the
`ModuleMetadata` impl, and update `__init` to use
`LocalModule::THIS_MODULE` instead.

Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 rust/kernel/lib.rs    |  3 +++
 rust/macros/module.rs | 34 +++++++++++++++++-----------------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
index b72b2fbe046d6..f0cf0705d9697 100644
--- a/rust/kernel/lib.rs
+++ b/rust/kernel/lib.rs
@@ -184,6 +184,9 @@ fn init(module: &'static ThisModule) -> impl pin_init::PinInit<Self, error::Erro
 pub trait ModuleMetadata {
     /// The name of the module as specified in the `module!` macro.
     const NAME: &'static crate::str::CStr;
+
+    /// The module's `THIS_MODULE` pointer.
+    const THIS_MODULE: ThisModule;
 }
 
 /// Equivalent to `THIS_MODULE` in the C API.
diff --git a/rust/macros/module.rs b/rust/macros/module.rs
index 06c18e2075083..b6d7b3299fbf9 100644
--- a/rust/macros/module.rs
+++ b/rust/macros/module.rs
@@ -497,28 +497,28 @@ pub(crate) fn module(info: ModuleInfo) -> Result<TokenStream> {
         /// Used by the printing macros, e.g. [`info!`].
         const __LOG_PREFIX: &[u8] = #name_cstr.to_bytes_with_nul();
 
-        // SAFETY: `__this_module` is constructed by the kernel at load time and will not be
-        // freed until the module is unloaded.
-        #[cfg(MODULE)]
-        static THIS_MODULE: ::kernel::ThisModule = unsafe {
-            extern "C" {
-                static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
-            };
-
-            ::kernel::ThisModule::from_ptr(__this_module.get())
-        };
-
-        #[cfg(not(MODULE))]
-        static THIS_MODULE: ::kernel::ThisModule = unsafe {
-            ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
-        };
-
         /// The `LocalModule` type is the type of the module created by `module!`,
         /// `module_pci_driver!`, `module_platform_driver!`, etc.
         type LocalModule = #type_;
 
         impl ::kernel::ModuleMetadata for #type_ {
             const NAME: &'static ::kernel::str::CStr = #name_cstr;
+
+            #[cfg(MODULE)]
+            const THIS_MODULE: ::kernel::ThisModule = {
+                extern "C" {
+                    static __this_module: ::kernel::types::Opaque<::kernel::bindings::module>;
+                }
+
+                // SAFETY: `__this_module` is constructed by the kernel at load time
+                // and lives until the module is unloaded.
+                unsafe { ::kernel::ThisModule::from_ptr(__this_module.get()) }
+            };
+
+            #[cfg(not(MODULE))]
+            const THIS_MODULE: ::kernel::ThisModule = unsafe {
+                ::kernel::ThisModule::from_ptr(::core::ptr::null_mut())
+            };
         }
 
         // Double nested modules, since then nobody can access the public items inside.
@@ -616,7 +616,7 @@ pub extern "C" fn #ident_exit() {
                 /// This function must only be called once.
                 unsafe fn __init() -> ::kernel::ffi::c_int {
                     let initer = <super::super::LocalModule as ::kernel::InPlaceModule>::init(
-                        &super::super::THIS_MODULE
+                        &<super::super::LocalModule as ::kernel::ModuleMetadata>::THIS_MODULE
                     );
                     // SAFETY: No data race, since `__MOD` can only be accessed by this module
                     // and there only `__init` and `__exit` access it. These functions are only

-- 
2.43.0


