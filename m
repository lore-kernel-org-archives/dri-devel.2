Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92DFE60A2607
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 11:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w0urtUim
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB4F1122B0;
	Thu, 19 Nov 2026 11:19:07 +0000 (UTC)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com
 [209.85.167.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC8E91122B0
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 11:19:00 +0000 (UTC)
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-5be4fea434bso790486e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 03:19:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795087139; x=1795691939; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Zgs6SyHjUqs1Qm+T+oyA24Ly2fWRmc8rFy/5dpxwQdQ=;
 b=w0urtUime7RkVv8Qg7jr1P/CJDG/e7EYwmFISRtez/Qfhd4c3e9Ec+pX7F4E/4mdDq
 wmvUhuTxGQR1qRys21Wq5VgVXqKUisCQ8UnRsfSmK9iFMNrT3ENjhO2I7G6bMAZhdVCn
 +N9Q8+aZojRry5/oRTpZPCAXSwrd0CWZxNngTpypeW3qmoNBRpo80ZU6do7x1u0qrb28
 2slBX4Hb9SXhpHgDE2P0shy8dsWSWngCFq7xrnXiCE7Zbv8TKuMusLa80f2Nhk+P06yv
 ZylFwkceo5jSFMYirZDIUeXEUBPMk/n2LljcCw85dHvJJeL84bNX5wGVIvCB5d2C3TfN
 2hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795087139; x=1795691939;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Zgs6SyHjUqs1Qm+T+oyA24Ly2fWRmc8rFy/5dpxwQdQ=;
 b=mDp0+ov5TrZQ88DTLlRMgGJ60VcBsHuZe+HVbuwXcL8iY6sXk+qJN1JmjlfKf3XNQU
 g1/jPWcbCH8odqfH815NmqFiNIV5r59xpZPok1qAX34C4McPk3GzMUsxpGgSpK1StT1N
 VfcJomqBHHMCpFjqP44Xu68TbHM35lXmSEovQ+mJEV7epDpB1vrdZg4QG8WJiUy0BbW3
 IVvHCCvYMZvXaaKZxGvEAgrjQ6Efs57kO8IhNWp1PUM57VQJyptMWxJ+Qnuqw99WtukW
 QnYpaUtMvU5HMK3sOLn2d0HiYqSFyrhzNnpn7QDF0FahekZ2Lb+VLjzBvE9FiuHXebd3
 rq0A==
X-Forwarded-Encrypted: i=1;
 AL+hErFMQNIvhVA8Ht9EPZkUU46h4ySRcLLqDc3wENy/7oiPEc1PN9XEv7+Zly0cG812DF+rqJTCnVl+XR4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+V9wekb0XG5uQq7Q45Aiu4OIKeUCOh7881aJ8mKn0jHxO6FqIE
 qz17LKnTmX0bZSCUQtkBX7pkD4zcpMFVwVB5D6q2piYxQW7Zd9r/c6oo
X-Gm-Gg: AYBFou3RM0PhM6/17yd8j9nl/gX0AmlszHN/x85uaTGZKbZTBTzbVI7DZB/gPTVh7rZ
 sV2qYJJ8FBJjLy4tq8/96eJljO1dyxSahpeFQFdmp37UXbSKq6BX5wSQkYdcF7x5YAutAGdZ6BW
 Sza3dJ7zedq+82hWIk39idETdLCoemnEqmkpDJXNzWCyteW9W4jiMtPklLQGHp36ufozlgo+wxn
 uq9Cf81dMP67ZdXmxFjJ5OinMYxLwut+shZ3qrGISuuFW2NmU0Jb+zGQSRbGldnk5lhEMHOiFlg
 GgM6d9vX2xmzNeatMPfoD3j//MaqM5/yMQU0MXg+lH2Hsf1a5BLRkKCxagAemEPafz1zkqZCAKz
 W0ddtYE1rCPvwRx1a8CjSpQpzzswLmYFpfzIpyW6YZ3tE7i8gShO1XNYlebXGRsaqUVjXcEayxa
 pzXxGQMqalcc83KE9tCIPrgeotNPJhkgqXWhpsAo8T0tJlGcgVdnotLkRnSeaJLrrLTTHJK8G3A
 MeTlWTRpu6E3H1pw6YulIsaty/49TrfHHk4H1vTM8RRDVO5FOUGgEdkuFKa59jpTKdS7NdTlOGB
 LkABfaHN26ZlcG86iTFRxjS+CTvCemMMTsd+
X-Received: by 2002:a05:6512:2354:b0:5c1:56e4:c705 with SMTP id
 2adb3069b0e04-5c1b79fd08amr335267e87.3.1795087138391; 
 Thu, 19 Nov 2026 03:18:58 -0800 (PST)
Received: from archlinux ([194.28.181.64]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1aa8b3c86sm1376278e87.83.2026.11.19.03.18.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Nov 2026 03:18:57 -0800 (PST)
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <jfern@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2] rust: gpu: buddy: store the allocator inside the Mutex
Date: Thu, 19 Nov 2026 13:18:50 +0200
Message-ID: <20261119111850.33270-1-mbkchelofficialdev@gmail.com>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

GpuBuddyInner keeps the C gpu_buddy structure next to a separate
Mutex<()>, so nothing in the type system ties the data to the lock.
A TODO asked to replace Mutex<()> with Mutex<Opaque<..>> once
Mutex::new() accepts a fallible initializer.

That is now possible, so put the Opaque<gpu_buddy> directly inside the
Mutex. The allocator can then only be reached through the lock guard,
which lets the compiler enforce that the lock is held. This also
removes the now unneeded `inner` field from GpuBuddyGuard.

Update the safety comments that referred to the removed `inner` field.

Signed-off-by: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
---
Changes in v2:
  - Dropped patch 1/2 ("rust: sync: lock: allow fallible initializers
    in Lock::new"): the same change is already in linux-next
    (Philipp Stanner's "rust: sync: Accept errors for Lock payload
    data"), as Gary pointed out. This patch now depends on it.
  - Rebased on next-20261118.
  - Fixed the indentation of the new_mutex!() initializer.
  - Build-tested on x86_64 (defconfig with CONFIG_RUST=y,
    CONFIG_GPU_BUDDY=y and CONFIG_NOVA_CORE=y). Not
    tested at runtime.

v1: https://lore.kernel.org/rust-for-linux/20261114200703.33229-1-mbkchelofficialdev@gmail.com/

 rust/kernel/gpu/buddy.rs | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
index 691bb4062..a85530895 100644
--- a/rust/kernel/gpu/buddy.rs
+++ b/rust/kernel/gpu/buddy.rs
@@ -313,16 +313,11 @@ pub struct GpuBuddyParams {
 ///
 /// # Invariants
 ///
-/// The inner [`Opaque`] contains an initialized buddy allocator.
+/// The `lock` field contains an initialized buddy allocator wrapped in `Opaque`.
 #[pin_data(PinnedDrop)]
 struct GpuBuddyInner {
     #[pin]
-    inner: Opaque<bindings::gpu_buddy>,
-
-    // TODO: Replace `Mutex<()>` with `Mutex<Opaque<..>>` once `Mutex::new()`
-    // accepts `impl PinInit<T>`.
-    #[pin]
-    lock: Mutex<()>,
+    lock: Mutex<Opaque<bindings::gpu_buddy>>,
     /// Cached creation parameters (do not change after init).
     params: GpuBuddyParams,
 }
@@ -338,14 +333,13 @@ fn new(params: GpuBuddyParams) -> impl PinInit<Self, Error> {
         // `gpu_buddy_*` APIs. `try_pin_init!` only completes if all fields succeed,
         // so the invariant holds when construction finishes.
         try_pin_init!(Self {
-            inner <- Opaque::try_ffi_init(|ptr| {
+            lock <- new_mutex!(Opaque::try_ffi_init(|ptr| {
                 // SAFETY: `ptr` points to valid uninitialized memory from the pin-init
                 // infrastructure. `gpu_buddy_init` will initialize the structure.
                 to_result(unsafe {
                     bindings::gpu_buddy_init(ptr, size, chunk_size.as_usize() as u64)
                 })
-            }),
-            lock <- new_mutex!(()),
+            })),
             params,
         })
     }
@@ -353,7 +347,6 @@ fn new(params: GpuBuddyParams) -> impl PinInit<Self, Error> {
     /// Lock the mutex and return a guard for accessing the allocator.
     fn lock(&self) -> GpuBuddyGuard<'_> {
         GpuBuddyGuard {
-            inner: self,
             _guard: self.lock.lock(),
         }
     }
@@ -364,7 +357,7 @@ impl PinnedDrop for GpuBuddyInner {
     fn drop(self: Pin<&mut Self>) {
         let guard = self.lock();
 
-        // SAFETY: Per the type invariant, `inner` contains an initialized
+        // SAFETY: Per the type invariant, `lock` contains an initialized
         // allocator. `guard` provides exclusive access.
         unsafe { bindings::gpu_buddy_fini(guard.as_raw()) };
     }
@@ -381,14 +374,13 @@ unsafe impl Sync for GpuBuddyInner {}
 ///
 /// The `_guard` holds the lock for the duration of this guard's lifetime.
 struct GpuBuddyGuard<'a> {
-    inner: &'a GpuBuddyInner,
-    _guard: MutexGuard<'a, ()>,
+    _guard: MutexGuard<'a, Opaque<bindings::gpu_buddy>>,
 }
 
 impl GpuBuddyGuard<'_> {
     /// Get a raw pointer to the underlying C `gpu_buddy` structure.
     fn as_raw(&self) -> *mut bindings::gpu_buddy {
-        self.inner.inner.get()
+        self._guard.get()
     }
 }
 
@@ -428,7 +420,7 @@ pub fn size(&self) -> u64 {
     pub fn avail(&self) -> u64 {
         let guard = self.0.lock();
 
-        // SAFETY: Per the type invariant, `inner` contains an initialized allocator.
+        // SAFETY: Per the type invariant, `lock` contains an initialized allocator.
         // `guard` provides exclusive access.
         unsafe { (*guard.as_raw()).avail }
     }
@@ -463,7 +455,7 @@ pub fn alloc_blocks(
                 // Lock while allocating to serialize with concurrent frees.
                 let guard = buddy.lock();
 
-                // SAFETY: Per the type invariant, `inner` contains an initialized
+                // SAFETY: Per the type invariant, `lock` contains an initialized
                 // allocator. `guard` provides exclusive access.
                 to_result(unsafe {
                     bindings::gpu_buddy_alloc_blocks(
-- 
2.56.1

