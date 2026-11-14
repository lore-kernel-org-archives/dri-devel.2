Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56B38606A331
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 08:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VXO7YdLe
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DC6A10EC96;
	Mon, 16 Nov 2026 08:58:48 +0000 (UTC)
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com
 [209.85.208.172])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1B3D410E05E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 20:07:48 +0000 (UTC)
Received: by mail-lj1-f172.google.com with SMTP id
 38308e7fff4ca-3ace304021eso23247801fa.2
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 12:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794686866; x=1795291666; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h59xmQEXNiVf2Fhkdj+7iJHbOtfNt9kdz0X5y1ytH2k=;
 b=VXO7YdLe1SKKEY7TFZYU1RhMa/7lfwrlGIH/BjErhgBwORan+B6z8UTcAveHg4QS/M
 3X2q3cyQFz+S3Gq5VdgHgOTgkMwieqwj6w3RbJ/zYBceTBVYgqsyNuwj8Rt3MeZ+PQcA
 SS2cXw6/QAU3ZxwN2dd9kQ+6NPjqg1jg7Rxm9EELaZIKhWOrOA5HfGQwPowD58U1NNIH
 WV7lWO12v5dzLKBCdiyqn8pfmf/hDuHsIudN+inqqJUNbuFAaBv6XA3Iiqm/N/AA3z0G
 9p/BsNXVUbssARppuFPxD0FJ10XhTXhNDlwbfQjteT3pp2PvJTn6LtIpK7878EKWakzv
 qArg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794686866; x=1795291666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h59xmQEXNiVf2Fhkdj+7iJHbOtfNt9kdz0X5y1ytH2k=;
 b=sxY8ByLTrF7d6ZeNbdD/LHIuplf8rJTvMX0Va0b4baHIVcG0Bi45PsC/BZPx6cHsa5
 H8dk6xV0SpXea1dHIZd9pvBH5ADhVTSip0qaUPhjp9peSS5/QKN/0smHHa+s6iY9s+Br
 eIGkD/61zijdPEC+WwcV1hiV6rSPpP+VkSF2c8beEKH7z3XuPQUp+SrQ5kWPJNvOXRY3
 viMYoOnT5/VgOyfYjHfVAQFbFmJgfplbRkaub4jBNeaQHV8ful9rMwzaKovAIeo0Z35a
 jC4/yA6tPtFzFVdmHW7U40E3sDQKBw0j/lA+JgTfRYUfjyPzRksiOhT5D2I9UPcybQfa
 S9Zg==
X-Forwarded-Encrypted: i=1;
 AL+hErGWZ5CW/FyjgUEm7jvLwcIiUzXSHiCpwxp1TYLCeia44Cil1F5lKrKZfGH8ZkNP9TOehyzT7eEx1Hw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9qZbN6pa4M9q3jAD1x6ZRRM6buNOAWcMwdn8bSfhxWMkCyKr5e
 Ye1IotMnTBQtP+B9sHaiPHeN6Pt+kzYFT/TylRznrerHFxawhfGCFQBj
X-Gm-Gg: AYBFou3ACx2Uf09oefNQb6wv0QPvX1tnTK5CMdXjkXUREHKsNOj6UtoyQkPCHVZmkxW
 ZEyRB9EzaV4YU4QE5b0MvbHOvZM0Lc1NiCYTrmTF8rZlHWXSw7ESbaXGtZz9GLwmoEpk2y+RmSH
 EBU8SJ+ptALQLCCEH/ZBcGniibFljhPtglHoRdhN/wK4liRf1BaBjshGcCptkEXOiPzXom3Hh5r
 pTg1ImArc2W4HxehXKygPLR7STtd15atQIM5bFwNGGdN67TAWo1WvYSF/ZPgiM1UiTbCEDyLmps
 AyBTYgbAH0briZ78XU4bVL2aYnb5FpyPVTl2ed/BZm4HsnuZlBlWkOQm62Y3CG9L5WQfiOvTmBP
 CIbGJI2usnG4DZSWhl8/mkWei+uBmiSlBWfW4waUIrTw4v5SwfsUV+sP+nn6zQpfCMgOqm0bfQP
 vC80dHfMiZ4COHDuxyO4ua8KOQpexLoDVpVwL14khUcKKc/EP1Az2yXYMWM+Vk264eU0dp4CZY5
 fgqdm6WJlahDVKuCIJOdGGka6fsTZrix4eIOwK4MCDlBEljuIw4DSC/22JxjAwL+iYTMyXqFbwq
 CrbHA/D3p3j5cJWsxwjDYvARHLrss/CCEbBEkMw=
X-Received: by 2002:a05:651c:2204:b0:3ad:f2f4:3fb8 with SMTP id
 38308e7fff4ca-3ae2b4e899emr18932731fa.21.1794686866101; 
 Sat, 14 Nov 2026 12:07:46 -0800 (PST)
Received: from IuseArchBTW ([194.28.181.64]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c1712da125sm1891070e87.1.2026.11.14.12.07.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Nov 2026 12:07:45 -0800 (PST)
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Danilo Krummrich <dakr@kernel.org>,
 Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>,
 Lyude Paul <lyude@redhat.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] rust: gpu: buddy: store the allocator inside the Mutex
Date: Sat, 14 Nov 2026 22:07:01 +0200
Message-ID: <20261114200703.33229-3-mbkchelofficialdev@gmail.com>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261114200703.33229-1-mbkchelofficialdev@gmail.com>
References: <20261114200703.33229-1-mbkchelofficialdev@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 16 Nov 2026 08:58:46 +0000
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
 rust/kernel/gpu/buddy.rs | 38 +++++++++++++++-----------------------
 1 file changed, 15 insertions(+), 23 deletions(-)

diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
index d502ada6ebbd..3397eb584ead 100644
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
@@ -338,22 +333,20 @@ fn new(params: GpuBuddyParams) -> impl PinInit<Self, Error> {
         // `gpu_buddy_*` APIs. `try_pin_init!` only completes if all fields succeed,
         // so the invariant holds when construction finishes.
         try_pin_init!(Self {
-            inner <- Opaque::try_ffi_init(|ptr| {
-                // SAFETY: `ptr` points to valid uninitialized memory from the pin-init
-                // infrastructure. `gpu_buddy_init` will initialize the structure.
-                to_result(unsafe {
-                    bindings::gpu_buddy_init(ptr, size, chunk_size.as_usize() as u64)
-                })
-            }),
-            lock <- new_mutex!(()),
-            params,
+            lock <- new_mutex!(Opaque::try_ffi_init(|ptr| {
+            // SAFETY: `ptr` points to valid uninitialized memory from the pin-init
+            // infrastructure. `gpu_buddy_init` will initialize the structure.
+            to_result(unsafe {
+                bindings::gpu_buddy_init(ptr, size, chunk_size.as_usize() as u64)
+            })
+        })),
+         params,
         })
     }
 
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

