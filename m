Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BE6CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:17:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 293DB10F227;
	Thu, 25 Jun 2026 10:17:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jYxaoRRA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D16DB10F224
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:17:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 49EF7600C3;
 Thu, 25 Jun 2026 10:17:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 952B11F00A3D;
 Thu, 25 Jun 2026 10:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782382620;
 bh=+v8tXru/D0w0PKV+e5hV801eQgcBm9LlNDFLEctuGws=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=jYxaoRRANa1V9m1Udg0IJYabnSuaCxetxr/YmRrom5K1twHlGQtaKL1531OIV7wAY
 pzwOh1YRvOHiKYfTdxkjLQA/CLlySN8LOBGgo+3PloSsKinE32HQNSyHvYY4WOqIVu
 c3sQ4A6CaesjKsG+X3b8AP+jyZ5qfRgCVtRReY7aU5xTdLouWWDtH2V1oYU9AEscTl
 zbknBtLBODE8kn/+r8HmDWoxKlQXYHI7/lVcR4xHzFUsAi2nlFzSvmugykgRXAf5sT
 GbTf9AIUdsiupJjfIL6iCoTjxE7Lx6X+TnbOmaiUE14O0SwEGS+XJvlnxLM4161bD3
 WR1CCy3HrouxQ==
From: Andreas Hindborg <a.hindborg@kernel.org>
Date: Thu, 25 Jun 2026 12:15:05 +0200
Subject: [PATCH v18 3/8] rust: implement `ForeignOwnable` for `Owned`
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-unique-ref-v18-3-4e06b5896d47@kernel.org>
References: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
In-Reply-To: <20260625-unique-ref-v18-0-4e06b5896d47@kernel.org>
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
 Dave Ertman <david.m.ertman@intel.com>, Ira Weiny <ira.weiny@intel.com>, 
 Leon Romanovsky <leon@kernel.org>, Paul Moore <paul@paul-moore.com>, 
 Serge Hallyn <sergeh@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Jan Kara <jack@suse.cz>, Igor Korotin <igor.korotin@linux.dev>, 
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Stephen Boyd <sboyd@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Pavel Tikhomirov <ptikhomirov@virtuozzo.com>, 
 Michal Wilczynski <m.wilczynski@samsung.com>
Cc: Andreas Hindborg <a.hindborg@kernel.org>, 
 Philipp Stanner <phasta@kernel.org>, rust-for-linux@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 driver-core@lists.linux.dev, linux-block@vger.kernel.org, 
 linux-security-module@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-fsdevel@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-pci@vger.kernel.org, linux-pwm@vger.kernel.org
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2740; i=a.hindborg@kernel.org; 
 h=from:subject:message-id;
 bh=D+6ZIO4nHj4bYi8QyWJ7VF+q64oBcwqsig25+zf52rU=; 
 b=owEBbQKS/ZANAwAKAfpQKQiqxb3QAcsmYgBqPP/A588eWpq8cK1DRyaFAdMoB9e5cPLUYXExs
 SGI+rLwcwyJAjMEAAEKAB0WIQRXitnI2WZ2JirAaob6UCkIqsW90AUCajz/wAAKCRD6UCkIqsW9
 0NM9EACAfry4mvmz0WEAXt3dU0TCMRWt9+gIJhpWptZYdwb8WMOAwcNnme8eSmq2p2U0gfzP8VE
 2VsVzmYEAzMBqZuzatO9TfGSJT1jnY+0EC+wvlaf+FlAv4FxEHcMjbCOLYBcj5wu/GiTkXqw4ma
 NTtWKRmxYdxOkvu0ldB7OXQOfizUkoFDPfsNK28vZQW/5Hk/DTd8Msi4uUlHLUS061XqyJccspU
 HawCI/kZVOBYQV0glwtnKomLlYFNAXS6C78fH+AyBogljYuxFEl4S4edRrqC3yI7osArfqs6nf7
 T6H1UlTJVArV+EO44OmgxFS7zg6K4wJurHCnAxl/eXFDMwdEqkozukWftb4xYqJ7gNCCnojyysX
 +61K1axqWU4I5JhBp0IRuchOfPgthzXXI8tnz4eUXQx76i2LAykcJzC72ciMfaURzB07tOxLtEc
 T2COSqW5+dmQ8lzmcovWSH6agGSWValKC+jg4dZjbm25rGXTEcb+p5mFOpprvuKEvIHgbjOEP4E
 g1A4zLfJYeg3gFKKJIOqWqqn1r+Hj/Sa5UuATYbyW7DP0tIhRyQeCjeWYyrxhgSv8/ZFz2Cq5uO
 J/fOcUhnmrLBlZBvDM1EidMhai6Sx/tccPxmFEKgs1afbTBeLEcNJNspDYEviwoNF7/I6IOnPrn
 COk4sGbslMpyd8w==
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
---
 rust/kernel/owned.rs | 53 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/rust/kernel/owned.rs b/rust/kernel/owned.rs
index 7fe9ec3e55126..9c92d4a83cc1b 100644
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
@@ -186,3 +188,54 @@ fn drop(&mut self) {
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
+        let ptr = self.ptr.as_ptr().cast();
+        core::mem::forget(self);
+        ptr
+    }
+
+    #[inline]
+    unsafe fn from_foreign(ptr: *mut kernel::ffi::c_void) -> Self {
+        // INVARIANT: By the function safety contract, `ptr` was returned by `into_foreign`, which
+        // gave up exclusive ownership of a valid, pinned `T`; we retake that ownership here.
+        Self {
+            // SAFETY: By function safety contract, `ptr` came from
+            // `into_foreign` and cannot be null.
+            ptr: unsafe { NonNull::new_unchecked(ptr.cast()) },
+        }
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


