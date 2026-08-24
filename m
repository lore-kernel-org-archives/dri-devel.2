Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC050C5DF81
	for <dri-devel@archiver.kernel.org>; Mon, 24 Aug 2026 11:19:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14E0B10E72A;
	Mon, 24 Aug 2026 11:19:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="k4gAMO5B";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C1AD10E72A
 for <dri-devel@lists.freedesktop.org>; Mon, 24 Aug 2026 11:19:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 51F8843B16;
 Mon, 24 Aug 2026 11:19:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CACAD1F000E9;
 Mon, 24 Aug 2026 11:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787570378;
 bh=FUl4cpxwoEAMk39ePpTbKQbCsCUQnhH3/2ILTsycWVk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=k4gAMO5BvwRCt6he2XnMfQcxhipMLBwDNolB13eUen1E2wn7fAu3MBJqkfNdJr30p
 KtBtxAdupxFiZDW1l3khlIZo5i166WHgK9Pn+A7sa/vSe0+LeDbm8p0/efMQ/maOqb
 hFezxfgre2Rzvka0kHj7n6QCtLOkxvS1Bhg8inibr4T+JjjYrvDkZMTqYAfmi3k8j6
 4oZ3KfuTIluGjYRLDL3kpp5vQXxd0TrKsfEdrDg/46DEbmuJqIMh5WqnKUbNs6hYOp
 zCXrqyY2xBjvOlklJqNgAt31S5TnrB+Usy8srISghFadNqdqLbUUZaoejrbb6VneEk
 HBGz5hSJfgoxA==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Mon, 24 Aug 2026 13:17:55 +0200
Subject: [PATCH v20 3/8] rust: implement `ForeignOwnable` for `Owned`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260824-unique-ref-v20-3-490735672187@kernel.org>
References: <20260824-unique-ref-v20-0-490735672187@kernel.org>
In-Reply-To: <20260824-unique-ref-v20-0-490735672187@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 Vlastimil Babka <vbabka@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Uladzislau Rezki <urezki@gmail.com>, Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 Lyude Paul <lyude@redhat.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 =?utf-8?q?Arve_Hj=C3=B8nnev=C3=A5g?= <arve@android.com>, 
 Todd Kjos <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, 
 Carlos Llamas <cmllamas@google.com>, 
 "Rafael J. Wysocki" <rafael@kernel.org>, 
 Dave Ertman <david.m.ertman@intel.com>, Leon Romanovsky <leon@kernel.org>, 
 Paul Moore <paul@paul-moore.com>, Serge Hallyn <sergeh@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Igor Korotin <igor.korotin@linux.dev>, Viresh Kumar <vireshk@kernel.org>, 
 Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>, Ira Weiny <iweiny@kernel.org>, 
 Ira Weiny <iweiny@kernel.org>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-usb@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2774; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=2rKgaZ9YnwK1gJkiYXVWR75zXX3xU5rSz64pVhI43qg=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqjCiCraxhcJ+w4vvZV1SY4iZnHh7vyhYoBDHKn
 QKMW9sWhP+JAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCaowoggAKCRD6UCkIqsW9
 0B6WD/96ff4wxEK2+JhzJICtEMa7fDp5dNRnYJUPIXjrv2eWMvj/7PONFiDRsfxAKSkZRZMmnB9
 O8A0AaNhAuNv8rwfY1LPeVRWoOiCTsp1FtojPmOmZ8dURwpe5dEv+/YqdstPb2rvHEig/phd/z5
 NCWuo+l2Xrvz1UlV0ptcV1qvzkuHDDb9C4gdkt8O/or/0CzdFXUOvC7/ur8ccqxXbWjF2IbURHF
 oMHferZlysAgx2DAbuQvX83sEfBBqNF5bRU5mfV6ggL3IrKaybaJfh68KWrqtqIZilPrQvRgBap
 OWErwdXMZDQeb577fnBxvQw4QdwJmJ5yw/Wpv1USJjvFeaUoYn8NTL4nDhOIyv2k2J1f5a23npA
 PFFqRK9rTt1ZeDkkXVMwlw31/NUmu10MiiyLigWpyvfNrLfhNrDQ3QPxLtst2VmNQPIwlQgJTDi
 4lgouA4IUoJ1/4cU8GMhSBGKiZYBLOZpa7FRvBOSz7fsmYljgCaD7lv30wlzIsMNnyBs7iXj5qU
 HUf5FqukUr9Mb/8kinmk7pIsCIaUEtRk9+rP7VO7tiZAbTp5Sn7fHOELtHTTWMLaNvbvqC0tYjT
 RMDYuRxK7Mjj/sV7REuFDiPZVGd5wZseUkzphLtK8XVVo0kHdyhHjWzqqaR0WCiSV7grNLz1RdX
 m9njpTvrY5w7MyA==
X-Developer-Key: i=a.hindborg@kernel.org; a=openpgp;
 fpr=3108C10F46872E248D1FB221376EB100563EF7A7
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

Implement `ForeignOwnable` for `Owned<T>`. This allows use of `Owned<T>` in
places such as the `XArray`.

Note that `T` does not need to implement `ForeignOwnable` for `Owned<T>` to
implement `ForeignOwnable`.

Signed-off-by: Andreas Hindborg <a.hindborg@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/owned.rs | 50 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 7fe9ec3e55126..93a5dfcc1e6f5 100644
--- a/rust/kernel/owned.rs
+++ b/rust/kernel/owned.rs
@@ -15,6 +15,8 @@
     ptr::NonNull, //
 };
 
+use kernel::types::ForeignOwnable;
+
 /// Types that specify their own way of performing allocation and destruction. Typically, this trait
 /// is implemented on types from the C side.
 ///
@@ -186,3 +188,51 @@ fn drop(&mut self) {
         unsafe { T::release(self.ptr) };
     }
 }
+
+// SAFETY: We derive the pointer to `T` from a valid `T`, so the returned
+// pointer satisfy alignment requirements of `T`.
+unsafe impl<T: Ownable> ForeignOwnable for Owned<T> {
+    const FOREIGN_ALIGN: usize = core::mem::align_of::<T>();
+
+    type Borrowed<'a>
+        = &'a T
+    where
+        Self: 'a;
+    type BorrowedMut<'a>
+        = Pin<&'a mut T>
+    where
+        Self: 'a;
+
+    #[inline]
+    fn into_foreign(self) -> *mut kernel::ffi::c_void {
+        Owned::into_raw(self).as_ptr().cast()
+    }
+
+    #[inline]
+    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
+        // SAFETY: By function safety contract, `ptr` came from `into_foreign` and cannot be null.
+        let ptr = unsafe { NonNull::new_unchecked(ptr.cast()) };
+
+        // SAFETY: By the function safety contract, `ptr` was returned by `into_foreign`, which gave
+        // up exclusive ownership of a valid, pinned `T`; we retake that ownership here.
+        unsafe { Owned::from_raw(ptr) }
+    }
+
+    #[inline]
+    unsafe fn borrow<'a>(ptr: *mut kernel::ffi::c_void) -> Self::Borrowed<'a> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as a
+        // reference for `'a`.
+        unsafe { &*ptr.cast() }
+    }
+
+    #[inline]
+    unsafe fn borrow_mut<'a>(ptr: *mut kernel::ffi::c_void) -> Self::BorrowedMut<'a> {
+        // SAFETY: By function safety requirements, `ptr` is valid for use as a
+        // unique reference for `'a`.
+        let inner = unsafe { &mut *ptr.cast() };
+
+        // SAFETY: We never move out of inner, and we do not hand out mutable
+        // references when `T: !Unpin`.
+        unsafe { Pin::new_unchecked(inner) }
+    }
+}

-- 
2.51.2


