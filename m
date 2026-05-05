Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F846FF885A
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 13:29:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E95F10E43F;
	Tue,  5 May 2026 13:29:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="qFNXguNt";
	dkim-atps=neutral
Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com
 [209.85.221.73])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2102910E43F
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 13:29:56 +0000 (UTC)
Received: by mail-wr1-f73.google.com with SMTP id
 ffacd0b85a97d-44bf1ac8893so3107917f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 06:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1777987794; x=1778592594;
 darn=lists.freedesktop.org; 
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:from:to:cc:subject:date:message-id:reply-to;
 bh=h2RGX6Vwv6i9Ia+V/bXwK0J5Boae0O+Cfqmb25x4+UY=;
 b=qFNXguNtpFRwFaMViIsPb17LDXkd5+mJUUSOoEsnYGwbyDvpitFi/ezJawtjQgcacC
 FPHHZ2ZfdE57fxj1cEr6hdy/yO1CAyv2ImPJROSrEO77oySV47AYPam511I1fdr5MYmG
 Kvaz2D8kVvsgel8SY1KXLg/85Kln2BM9OZdXlOLgFhVJ/IYWzHQqb8ZP2eEaYNbIKd8i
 xAKzNdBPINBtJ4hXFm7Y10AxVrsWgPKvcaWQSBc5cFVjTZdFLO9eQFdq23tcO4wKtgbz
 H4FX/zqVQDBLsRXoErnCJU5c2KF/BawMp40IFJDpE+CyUiuJyjWbfbdEKtUV1bjHKsOb
 TSLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777987794; x=1778592594;
 h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h2RGX6Vwv6i9Ia+V/bXwK0J5Boae0O+Cfqmb25x4+UY=;
 b=YPQ7Ot5BaESXAEQit3IUbQ7Ao4VpSayaHatBJgEfqQdnOQFI2YkTDg7uSre0LsgRAB
 5yoJOS+RUEVkAOYGBGuSf25jfz+apb7z4N8c4Hx/DtLItu7SSEFQUNPLgEQLHx5gK2wP
 Vp3Zfji8UJKUFc65lozLcM7QzmpA0rLWthNpN1llE/FCncOAzGi9yZbdQgrAmuaGs5pT
 pMjj3KEnL2u69EzIm9xluBYqpmnzJUmCaTBoiHTocwMfMBBQITFZ2o41amupr2au1rsr
 g6/B8TMaAUBCmGelah9J5bj/5zHkD4EL71OPHFTINwYbVd++eakLFxbYexXC9MKWzvtU
 Df6A==
X-Forwarded-Encrypted: i=1;
 AFNElJ+PnnXVn9rOCGlSVlOfgs73+q+R5Mb0V+l0GCO4cqFLDOEIugwNhuUGGIJqA6xE71WbmGbE1VMktL8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwB1nb5c4K8/Yxhip/FxeBTJ/icFGfOctlSB3TTKI95alZ0sbjP
 zW1b5y0lC9lB6ItFenjmwFEEolgr+MoGxXQO7oc1XyTwpCfivLDhSy7kjOLahRmr28BWdBfyEGS
 YyaH/FPHsKP8T8uL64Q==
X-Received: from wrbes25.prod.google.com
 ([2002:a05:6000:44d9:b0:44a:70d3:31fd])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a5d:444c:0:b0:44b:d58b:6a01 with SMTP id
 ffacd0b85a97d-44bd59aada4mr15775676f8f.1.1777987793893; 
 Tue, 05 May 2026 06:29:53 -0700 (PDT)
Date: Tue, 05 May 2026 13:29:37 +0000
In-Reply-To: <20260505-gpuvm-drm-exec-v1-0-958306ded36e@google.com>
Mime-Version: 1.0
References: <20260505-gpuvm-drm-exec-v1-0-958306ded36e@google.com>
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=6284; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=D38IP4eDNtMMI0IcGktFlp2eQ3DhTGlCsra4pFAIzVw=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBp+fDNU9ynbvS3XqymbWEIFFSYVxq4nVooOCqAz
 8ojvGQzQrSJAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCafnwzQAKCRAEWL7uWMY5
 RhxWEACUfl0Spaz0xAbL0EstZcKnvjGq70NJR0uHyy/8h4gZQYldwrE+tFVx9pa6WzyND2y5gbL
 +29uPSTOfRxUfwtkr/WVnPlBvxGxJWZ6YWd6VV8cLqmy7hZwUSI3SyD6zTVsTKfC8J64OkcoTCK
 aQRz7zUqG0aFmaL55YE0pZB4L5pAeyM64FL6NTLJ9KK5kWt9MVfmJARTrjNYuo4x0cGHWQG76c/
 ftxOTAjFr1EFv/+dQYO7Jau+YFAgywBT+AO+aaWQcOOE2YOphCykKAxv2X7Ll0bR+D1JijF9Snb
 mn2RCFCU2VAA4v2Rr6c7DoRxY1bEaZl4ovdMo0dEvKqT1xOK8i5qIMmpUXN1TyS7/tRMixWlxyR
 b+EzeVH/TjKWDo8i3W6kcXXm2wRG6or/q1YFNQLgowdcy0nFuQDTYr52FAw5NoWftLY/mNIjVSI
 jeVI2lsO3Xm1YCIERvFheCpBFOiwx6mtsNMH2LmSdeI4DalQDf0eaoW1ACHsI1g7NqjBmyxXTjl
 X2mt6gmE8/Z/JAF/itemiWpj4TRo/tF9FoxhGh0KYmPpTzlJVprRCl+4EEazKwbHwuUxLnEg8RN
 AKgpGFxsO+YpgrytwrriLKkSPAMmFoobSQNe6P7fNu1v0W7hgNvwe0VMgTMXC8zd8Cloj/GtzeC
 STnjuONyxsqk9QQ==
X-Mailer: b4 0.14.3
Message-ID: <20260505-gpuvm-drm-exec-v1-2-958306ded36e@google.com>
Subject: [PATCH 2/2] drm/gpuvm: rust: add drm_gpuvm_exec support
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Boris Brezillon <boris.brezillon@collabora.com>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>,
 Philipp Stanner <pstanner@redhat.com>
Cc: Sumit Semwal <sumit.semwal@linaro.org>, 
 "=?utf-8?q?Christian_K=C3=B6nig?=" <christian.koenig@amd.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 linux-kernel@vger.kernel.org, 
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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

This adds support for simple usage of drm_gpuvm_exec() for locking all
of the dma reservations and adding fences to them. For more complex
usage that does not involve locking all reservations, it is expected
that the ww-mutex abstractions will be used instead.

Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/bindings/bindings_helper.h |  2 ++
 rust/helpers/drm_gpuvm.c        |  6 ++++
 rust/kernel/dma_buf/mod.rs      | 17 ++++++++++
 rust/kernel/drm/gpuvm/mod.rs    | 71 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 96 insertions(+)

diff --git a/rust/bindings/bindings_helper.h b/rust/bindings/bindings_helper.h
index 1124785e210b..3978682a6f2e 100644
--- a/rust/bindings/bindings_helper.h
+++ b/rust/bindings/bindings_helper.h
@@ -151,6 +151,8 @@ const vm_flags_t RUST_CONST_HELPER_VM_MIXEDMAP = VM_MIXEDMAP;
 const vm_flags_t RUST_CONST_HELPER_VM_HUGEPAGE = VM_HUGEPAGE;
 const vm_flags_t RUST_CONST_HELPER_VM_NOHUGEPAGE = VM_NOHUGEPAGE;
 
+const u32 RUST_CONST_HELPER_DRM_EXEC_INTERRUPTIBLE_WAIT = DRM_EXEC_INTERRUPTIBLE_WAIT;
+
 #if IS_ENABLED(CONFIG_GPU_BUDDY)
 const unsigned long RUST_CONST_HELPER_GPU_BUDDY_RANGE_ALLOCATION = GPU_BUDDY_RANGE_ALLOCATION;
 const unsigned long RUST_CONST_HELPER_GPU_BUDDY_TOPDOWN_ALLOCATION = GPU_BUDDY_TOPDOWN_ALLOCATION;
diff --git a/rust/helpers/drm_gpuvm.c b/rust/helpers/drm_gpuvm.c
index 4130b6325213..30fb1777fbf2 100644
--- a/rust/helpers/drm_gpuvm.c
+++ b/rust/helpers/drm_gpuvm.c
@@ -23,4 +23,10 @@ bool rust_helper_drm_gpuvm_is_extobj(struct drm_gpuvm *gpuvm,
 	return drm_gpuvm_is_extobj(gpuvm, obj);
 }
 
+__rust_helper
+void rust_helper_drm_gpuvm_exec_unlock(struct drm_gpuvm_exec *vm_exec)
+{
+	drm_gpuvm_exec_unlock(vm_exec);
+}
+
 #endif // CONFIG_RUST_DRM_GPUVM
diff --git a/rust/kernel/dma_buf/mod.rs b/rust/kernel/dma_buf/mod.rs
index b66e747c35ad..234936ba8265 100644
--- a/rust/kernel/dma_buf/mod.rs
+++ b/rust/kernel/dma_buf/mod.rs
@@ -5,3 +5,20 @@
 pub mod dma_fence;
 
 pub use self::dma_fence::Fence;
+
+/// How the fences from a `dma_resv` obj are used.
+///
+/// Please see [the C-side documentation][dma_resv_usage] for more details.
+///
+/// [dma_resv_usage]: https://docs.kernel.org/driver-api/dma-buf.html#c.dma_resv_usage
+#[repr(u32)]
+pub enum DmaResvUsage {
+    /// For in kernel memory management only (e.g. copying, clearing memory).
+    Kernel = bindings::dma_resv_usage_DMA_RESV_USAGE_KERNEL,
+    /// Implicit write synchronization for userspace submissions.
+    Write = bindings::dma_resv_usage_DMA_RESV_USAGE_WRITE,
+    /// Implicit read synchronization for userspace submissions.
+    Read = bindings::dma_resv_usage_DMA_RESV_USAGE_READ,
+    /// No implicit sync (e.g. preemption fences, page table updates, TLB flushes).
+    Bookkeep = bindings::dma_resv_usage_DMA_RESV_USAGE_BOOKKEEP,
+}
diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index ae58f6f667c1..a52fb25f22ff 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -16,6 +16,7 @@
         Flags as AllocFlags, //
     },
     bindings,
+    dma_buf::{DmaResvUsage, Fence},
     drm,
     drm::gem::IntoGEMObject,
     error::to_result,
@@ -216,6 +217,30 @@ pub fn obtain(
         Ok(GpuVmBoAlloc::new(self, obj, data)?.obtain())
     }
 
+    /// Prepare this GPUVM.
+    ///
+    /// The parameter indicates how many fences to preallocate space for.
+    #[inline]
+    pub fn prepare(&self, num_fences: u32) -> impl PinInit<GpuVmExec<'_, T>, Error> {
+        try_pin_init!(GpuVmExec {
+            exec <- Opaque::try_ffi_init(|exec: *mut bindings::drm_gpuvm_exec| {
+                // SAFETY: exec is valid but unused memory, so we can write.
+                unsafe {
+                    ptr::write_bytes(exec, 0u8, 1usize);
+                    ptr::write(&raw mut (*exec).vm, self.as_raw());
+                    ptr::write(&raw mut (*exec).flags, bindings::DRM_EXEC_INTERRUPTIBLE_WAIT);
+                    ptr::write(&raw mut (*exec).num_fences, num_fences);
+                }
+
+                // SAFETY: If successful, this `struct drm_gpuvm_exec` remains valid until this is
+                // unlocked because it's pinned and unlocks it in drop. The contained pointer to
+                // `self` remains valid because `GpuVmExec` borrows from `self`.
+                to_result(unsafe { bindings::drm_gpuvm_exec_lock(exec) })
+            }),
+            _gpuvm: PhantomData,
+        })
+    }
+
     /// Clean up buffer objects that are no longer used.
     #[inline]
     pub fn deferred_cleanup(&self) {
@@ -326,3 +351,49 @@ fn deref(&self) -> &GpuVm<T> {
         &self.0
     }
 }
+
+/// The exec token for preparing the objects.
+///
+/// # Invariants
+///
+/// Owns a GPUVM exec context.
+#[pin_data(PinnedDrop)]
+pub struct GpuVmExec<'vm, T: DriverGpuVm> {
+    #[pin]
+    exec: Opaque<bindings::drm_gpuvm_exec>,
+    _gpuvm: PhantomData<&'vm mut GpuVm<T>>,
+}
+
+impl<'vm, T: DriverGpuVm> GpuVmExec<'vm, T> {
+    /// Add a fence.
+    ///
+    /// The caller must ensure that the preallocated space for fences is sufficient.
+    #[inline]
+    pub fn resv_add_fence(
+        &self,
+        fence: &Fence,
+        private_usage: DmaResvUsage,
+        extobj_usage: DmaResvUsage,
+    ) {
+        // SAFETY: This method takes a refcount on the fence, so it's only required to be valid for
+        // the duration of this method. If there is not enough space for the pre-allocated fence,
+        // then this leads to a BUG_ON() but does not trigger UB.
+        unsafe {
+            bindings::drm_gpuvm_resv_add_fence(
+                (*self.exec.get()).vm,
+                &raw mut (*self.exec.get()).exec,
+                fence.as_raw(),
+                private_usage as u32,
+                extobj_usage as u32,
+            )
+        }
+    }
+}
+
+#[pinned_drop]
+impl<'vm, T: DriverGpuVm> PinnedDrop for GpuVmExec<'vm, T> {
+    fn drop(self: Pin<&mut Self>) {
+        // SAFETY: We hold the lock, so it's safe to unlock.
+        unsafe { bindings::drm_gpuvm_exec_unlock(self.exec.get()) };
+    }
+}

-- 
2.54.0.545.g6539524ca2-goog

