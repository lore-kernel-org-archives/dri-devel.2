Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DF6360A262D
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 11:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=jannau.net header.i=@jannau.net header.a=rsa-sha256 header.s=fm1 header.b=GNfmh3hO;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=mNXXjtI9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 68CBB10EDAB;
	Mon, 26 Oct 2026 11:22:06 +0000 (UTC)
Received: from fout-a2-smtp.messagingengine.com
 (fout-a2-smtp.messagingengine.com [103.168.172.145])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B3110EE4F
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 11:21:54 +0000 (UTC)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.phl.internal (Postfix) with ESMTP id 49822EC0350
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 07:14:24 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Mon, 26 Oct 2026 07:14:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jannau.net; h=cc
 :cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1793013264;
 x=1793099664; bh=VGBLjM7SDQH++/mXaqqVJ79FQu5D+4L9GnlGy61fp3Q=; b=
 GNfmh3hOyQVax7CNbpAzK310rHceDepCZE5qTQkOkpzW+06wSBizx3o6W6Ac5nCa
 r4uRPunxJGtBD06y8zSvQAFcpm69tmVpUPhdYi6+bTgQ6ZLeS/13yen1LKEa5tfm
 73we+CV9q0rXOHrqzMwWWWO9RuKRpUjv010RBFVTE3j2uxwcNLUsWAoUmUBs6dg7
 7NBEpub01qyRGqOmRExt9JwrTA7jNsJDAbpdrf2nqUJ1o8ir/s0cEtXB3jeHfcic
 bC3gSxev+9ihsmHyhlRgNW+RzgN4rghkGwyWxEzKPseD8bzW2ry5PebJG9lFtPpT
 EfPYTKjHKLLNiNI//WN3Zg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1793013264; x=
 1793099664; bh=VGBLjM7SDQH++/mXaqqVJ79FQu5D+4L9GnlGy61fp3Q=; b=m
 NXXjtI9/hnzITJX5oriq1uk8vzza+R1ZSpMR8YcJlt6hPUrvDCX0pus3UTg0lcUR
 ZFvYt2yst/6qI/72pdycFtDmbH/wbJKYDmj7y2VMzeNdThwbuwArCqfiWsaQCe90
 6k6+8VzZXNXpgIA4XXMOELfp9YbT8AZH+6Si0IW/1u17jjueKybzuMT4bqxRw0TB
 d1OpFQRqzRhmqkwCYbgpj4CMX/ChJX0pGLg19gB/hJNIshHHPCgtiYHIwt9XUZPv
 N8AwLwEagC7Qp3ztsMDBAoXJIev82hY92kOHVlmaZdiO8KxTyWmPc+gxAFIABNUN
 kz5q6ghn9mcChWLGoljTQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=sign d=jannau.net a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1793013264; d=jannau.net; mf=PGpAamFubmF1Lm5ldD4=;
 rt=PGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmc+;
 s=fm1:rsa-sha256:jLeLZTslZhnBvaa5Y+bc/kv4ftbKFpEMyZi68DPYiQiYEPH
 swvJTtRhxZj38hppHHITUSYc1+CKovrln0rwLF09KGXU7w9o6gMkw+E6eIKjygXP
 M5sz3t1Uxf2sOxU+lZnLQKZvFNgYaOTchL+P2dedmHxkO5mzrC9tE5Ru44Oa5UE4
 dGlGN9NTdyv4/Q80FhAQ8Xa2tXGhsgbp5B4idejNCl9viadVmOfATSfF2wew20dj
 DMyRYdqYz3vlK4fQa7xFTUumr2CgQTJNyzkYmgKfLxvVUL9epVwptfq8FBgXx70E
 K0aazWWPlkgjLRgiLNpcpBb5xIaZhZy/hIVg1Jw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-07;
 repo=github.com/dkim2wg/interop; date=2026-10-18; sw=lmtpprox;
 action=mi-m=1; hc=12;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to;
Message-Instance: m=1;
 h=sha256:YSoNeyNrG4CfMl1j6hcDg/4DniAVIIZlxVahQd81k2s=:ZyvwKt18G8J5HU6pAQZZqmPmJp6gZNNhMqevnb0OmUU=;
X-ME-Sender: <xms:EDbfau2CUKQvRED9eFZ_ULwK5T8gXVQkSOl5kLvtaXjGgdf6zr7AoA>
 <xme:EDbfalD0jlL3JbwU9Bqobl2_An9iZZMwT_W7_TWy_g_nZJFODEiAmRlrdjZ4KCp9b
 sT4CAxBbq3s9r0YLvAbyVAtjaNQdBAyQVJyFUh_D3HKwRL4oQNXFD2m>
X-ME-Received: <xmr:EDbfavYl23gw061ekfOrChr6yWr3yEIOhIq7ffLi63-uhxhehMYm9hkc7lXTQX5ya-zRrzz3Vi7ZKc5SD3nFxSHygHCf8VU7dIU>
X-ME-Proxy-Cause: dmFkZTGTFujyhpQRn/Z7T0xOelb7xJXAv8ylCTHqF+8T/0TsZvej1Jr2T9JvpNAc5ENmEo
 8Sh2lU1+NtJ3tgHLUyq1wL8KSK1OIfK6IQOkQhFd0B59bqDNtvn8whox8aFArwFkZQynLk
 qujVyJ9fDqClnzSDEqraV9VZVP4Har4RVkBpA0pliSBoQ7UMTCEIoC18ZQg3OFZNWMeX3B
 qJe0qdmp7PswF+x1hxdzfZ5BKSvQpcDY5VXbVwEVOG2zQFMZVb5mrEq8fhqkPgcLU/mtvi
 d+zZ9I+hhHvon2WZmpIdvh0XWOGgJi3fpD3hFJP2B9MVSTK8ntcc/trrGuCmuol7UhInmE
 g9dPM+t45CyVWsGXNaD6ryVxz+lLK60J3pNaD/DoFRylf+YgLaTYsgz8eTcPZq3gG0RzfF
 tOIkDeKTdbfKjbjUGO9RCucKbKEF55UefbkgJcSMyJ2M0IqVz1MFeGJLJDbBxdteMc/NvR
 GFIQkppdtppEndIzpL6Weffaza+w2t7jUoeNGB4CapTtA4x0MFp3UKBIWlbBD7OKtehAev
 tttMkqmWlnlQ0qaLf+pB+m2dZrdfje3sZNRNe09gUDJ3kEgabaKTSb7kLMOT1kYPWOnSkl
 XOcj+RWr2hg3WNArwZq5mSqpTie8mkPV1xmNQk1KxHjFg80VpI/RcXMAPuwA
X-ME-Proxy: <xmx:EDbfapY-Dh4Dz5j15TyJ5Eyi8QTRjwmw1CI-kSuSzhM166TpXWlrcg>
 <xmx:EDbfaom8Wy3PAqCvRQX4mUlglcFBp0oojLC8VTKcEthfsTkTQfXyIQ>
 <xmx:EDbfajRuB1cop1alm2hmhiz0TasDuWSHoiF6LweDsPjuAu1Bwbe-eA>
 <xmx:EDbfalXKDbu8tJbhvFG8s5fc0BfBG-DWWz5ErGn1I1IA_2tKsaJV9g>
 <xmx:EDbfag3Zv6PH65Q2_uP61VDUfgdACXgmaCLq7ZB0jrKb-AHsD9cpwE5A>
Feedback-ID: i47b949f6:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Oct 2026 07:14:23 -0400 (EDT)
From: Janne Grunau <j@jannau.net>
Date: Mon, 26 Oct 2026 12:14:08 +0100
Subject: [PATCH 1/3] rust: drm: gem: shmem: implement gem_create_object for
 prime imports
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261026-rust-drm-gem-shmem-imported-sgt-v1-1-36f15ace04b1@jannau.net>
References: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
In-Reply-To: <20261026-rust-drm-gem-shmem-imported-sgt-v1-0-36f15ace04b1@jannau.net>
To: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
 Gary Guo <gary@garyguo.net>, 
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, 
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, 
 Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, 
 Danilo Krummrich <dakr@kernel.org>, 
 Daniel Almeida <daniel.almeida@collabora.com>, 
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>, 
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Janne Grunau <j@jananu.net>, Sami Tolvanen <samitolvanen@google.com>, 
 Lyude Paul <lyude@redhat.com>
Cc: rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, nova-gpu@lists.linux.dev, 
 Janne Grunau <j@jannau.net>, stable+noautosel@kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=7436; i=j@jannau.net;
 s=yk2025; h=from:subject:message-id;
 bh=g9e/lpcQLdgtMlIdIOugf3Dae0H34mLBom1lmPdGbW0=;
 b=owGbwMvMwCW2UNrmdq9+ahrjabUkhqz7ZlwH4qaz7korXeTRejd51bkwm0hzFWaXls0K94rTZ
 RsYe792lLIwiHExyIopsiRpv+xgWF2jGFP7IAxmDisTyBAGLk4BmIjkJ4Z/Vjce7nzvsMH0qFhd
 YfylHG/WFCaerZc9req2eqw/eKFtHiPDGvWeGS6srfullZYt+XEwaZNc4Kr3wS5lEvvXt7GwTWf
 hBQA=
X-Developer-Key: i=j@jannau.net; a=openpgp;
 fpr=8B336A6BE4E5695E89B8532B81E806F586338419
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sami Tolvanen <samitolvanen@google.com>

For a prime-imported BO with no `gem_create_object` callback,
`__drm_gem_shmem_create()` allocates `kzalloc(sizeof(struct
drm_gem_shmem_object))`, which is smaller than the Rust `Object<T>`
wrapper. A later `container_of!()` from a `drm_gem_object` back to
`Object<T>` then runs past the allocation and corrupts the heap.

Provide a `gem_create_object` callback that allocates the full
`Object<T>` via `KBox::pin_init`. Move `obj` to the first field so the
returned pointer is at offset zero, satisfying the `kfree()` on the
init-failure path. This is now compile-checked with `const_assert!`.

Imported BOs have no userspace creation arguments, so extend
`DriverObject` with a `create_imported(dev, size)` constructor and
implement it for Tyr's `BoData`, Nova, and the in-tree KUnit driver.

Fixes: 80df573af9ef ("rust: drm: gem: shmem: Add DRM shmem helper abstraction")
Cc: <stable+noautosel@kernel.org> # no in tree users
Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
Signed-off-by: Janne Grunau <j@jannau.net>
---
 drivers/gpu/drm/nova/gem.rs  |  4 +++
 drivers/gpu/drm/tyr/gem.rs   |  4 +++
 rust/kernel/drm/gem/mod.rs   |  9 +++++++
 rust/kernel/drm/gem/shmem.rs | 58 +++++++++++++++++++++++++++++++++++++++++++-
 4 files changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/nova/gem.rs b/drivers/gpu/drm/nova/gem.rs
index 2b6fe9dc0bfa..2e17422e76f5 100644
--- a/drivers/gpu/drm/nova/gem.rs
+++ b/drivers/gpu/drm/nova/gem.rs
@@ -27,6 +27,10 @@ impl gem::DriverObject for NovaObject {
     fn new(_dev: &NovaDevice, _size: usize, _args: Self::Args) -> impl PinInit<Self, Error> {
         try_pin_init!(NovaObject {})
     }
+
+    fn create_imported(_dev: &NovaDevice, _size: usize) -> impl PinInit<Self, Error> {
+        try_pin_init!(NovaObject {})
+    }
 }
 
 impl NovaObject {
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index 3bf3787f5c3f..4b61bb04c845 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -48,6 +48,10 @@ impl gem::DriverObject for BoData {
     fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Self, Error> {
         try_pin_init!(Self { flags: args.flags })
     }
+
+    fn create_imported(_dev: &TyrDrmDevice, _size: usize) -> impl PinInit<Self, Error> {
+        try_pin_init!(Self { flags: 0 })
+    }
 }
 
 /// Type alias for Tyr GEM buffer objects.
diff --git a/rust/kernel/drm/gem/mod.rs b/rust/kernel/drm/gem/mod.rs
index e1ebad77ebe2..e01b8311dd89 100644
--- a/rust/kernel/drm/gem/mod.rs
+++ b/rust/kernel/drm/gem/mod.rs
@@ -98,6 +98,15 @@ fn new(
         args: Self::Args,
     ) -> impl PinInit<Self, Error>;
 
+    /// Create a new driver data object for a GEM object that is being imported
+    /// from another driver (e.g. via dma-buf).
+    ///
+    /// Imported objects are allocated by the importing helper, which only
+    /// provides the device and size. There is no driver-supplied
+    /// [`DriverObject::Args`], so drivers must initialize the per-object
+    /// state without those arguments.
+    fn create_imported(dev: &drm::Device<Self::Driver>, size: usize) -> impl PinInit<Self, Error>;
+
     /// Open a new handle to an existing object, associated with a File.
     fn open(_obj: &DriverAllocImpl<Self>, _file: &DriverFile<Self>) -> Result {
         Ok(())
diff --git a/rust/kernel/drm/gem/shmem.rs b/rust/kernel/drm/gem/shmem.rs
index a687d46d170d..1df3554893cc 100644
--- a/rust/kernel/drm/gem/shmem.rs
+++ b/rust/kernel/drm/gem/shmem.rs
@@ -100,6 +100,12 @@ fn default() -> Self {
 #[repr(C)]
 #[pin_data]
 pub struct Object<T: DriverObject> {
+    /// Embedded `drm_gem_shmem_object`.
+    ///
+    /// Must remain the first field so the allocation address coincides with the embedded
+    /// `drm_gem_shmem_object`. The DRM shmem helper's `__drm_gem_shmem_create()` error path calls
+    /// `kfree()` on the returned `drm_gem_object` pointer, which is only sound when it points at
+    /// the start of the allocation.
     #[pin]
     obj: Opaque<bindings::drm_gem_shmem_object>,
     /// Parent object that owns this object's DMA reservation object.
@@ -343,6 +349,49 @@ pub fn new(
         Ok(obj)
     }
 
+    /// Allocates the full [`Object<T>`] wrapper and zero-initializes the embedded shmem object.
+    /// The helper's `__drm_gem_shmem_init` fills it in after we return.
+    extern "C" fn gem_create_object_callback(
+        raw_dev: *mut bindings::drm_device,
+        size: usize,
+    ) -> *mut bindings::drm_gem_object {
+        const_assert!(
+            core::mem::offset_of!(Self, obj) == 0,
+            "Object<T>::obj must be at offset 0 so drm_gem_shmem_helper's kfree(obj) error path \
+             frees the wrapper allocation, not the middle of it"
+        );
+
+        // SAFETY: The DRM shmem helper only invokes this callback for a registered DRM device of
+        // type `T::Driver`, which is `Self`'s driver per the `AllocImpl` impl below.
+        let dev: &Device<T::Driver> = unsafe { Device::from_raw(raw_dev) };
+
+        let new: Pin<KBox<Self>> = match KBox::try_pin_init(
+            try_pin_init!(Self {
+                obj <- Opaque::init_zeroed(),
+                parent_resv_obj: None,
+                sgt_res: ManuallyDrop::new(SetOnce::new()),
+                sgt_lock <- new_mutex!(()),
+                inner <- T::create_imported(dev, size),
+            }),
+            GFP_KERNEL,
+        ) {
+            Ok(new) => new,
+            Err(e) => return e.to_ptr(),
+        };
+
+        // SAFETY: `new.as_raw()` is guaranteed to be valid by the initialization above.
+        unsafe { (*new.as_raw()).funcs = &Self::VTABLE };
+
+        // SAFETY: We never move out of `self`. Ownership of the allocation is transferred to the
+        // C side, which will run `__drm_gem_shmem_init()` next and later free us via
+        // `free_callback` (or `kfree()` on the `__drm_gem_shmem_init()` error path, matching the
+        // C kzalloc fallback contract).
+        let new = KBox::into_raw(unsafe { Pin::into_inner_unchecked(new) });
+
+        // SAFETY: `new` was just produced by `KBox::into_raw` and so is a valid pointer to an
+        // initialized `Self`. `obj.base` is the embedded `drm_gem_object` the caller expects.
+        unsafe { &raw mut (*(*new).obj.get()).base }
+    }
     /// Creates and returns an owned reference to a virtual kernel memory mapping for this object.
     #[inline]
     pub fn owned_vmap<const SIZE: usize>(&self) -> Result<VMapOwned<T, SIZE>> {
@@ -389,7 +438,7 @@ impl<T: DriverObject> driver::AllocImpl for Object<T> {
     type Driver = T::Driver;
 
     const ALLOC_OPS: driver::AllocOps = driver::AllocOps {
-        gem_create_object: None,
+        gem_create_object: Some(Self::gem_create_object_callback),
         prime_handle_to_fd: None,
         prime_fd_to_handle: None,
         gem_prime_import: None,
@@ -623,6 +672,13 @@ fn new(
         ) -> impl PinInit<Self, Error> {
             try_pin_init!(KunitObject {})
         }
+
+        fn create_imported(
+            _dev: &drm::Device<KunitDriver>,
+            _size: usize,
+        ) -> impl PinInit<Self, Error> {
+            try_pin_init!(KunitObject {})
+        }
     }
 
     #[vtable]

-- 
2.56.0

