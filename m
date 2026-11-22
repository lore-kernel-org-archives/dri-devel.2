Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D101606A320
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 07:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jJVnspds
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFAE510E22E;
	Sun, 22 Nov 2026 07:20:26 +0000 (UTC)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com
 [209.85.208.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6CED310E22E
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 07:20:20 +0000 (UTC)
Received: by mail-lj1-f175.google.com with SMTP id
 38308e7fff4ca-3adef977ad9so17434221fa.1
 for <dri-devel@lists.freedesktop.org>; Sat, 21 Nov 2026 23:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795332018; x=1795936818; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=o8re6EZDSI55b5voUbfOtCkCAeZWYZ3ND/N+XRqjIEk=;
 b=jJVnspdsOBvFlG5oKlw4RY0VsOJW1lQ2R6eTk56QzQFwO6TGdt2/VYP+vhMp8PYXtb
 L172S65tt3tdtvSJb3tRsssiRqupDAE8GknDB21DVEXysfIrK+7uWx/ZzhKGr3Lu1emu
 2QOhrtVHzH2Zc+Y5zRAgX4PLMhPSwAHJVnsToifLrdEz8bIS+CmYBFZHb4cXYqqcAdvT
 sjvDpwQ8HJcxOxzsaJLlJrL5T3ATIU58C0M/UAS1disTs4NT7AqX4wRlslUdYqnwpanV
 SyYuwU6umDuY9TIIzzNqmC/aLEv6swT5fwI+fn2siTukJJitQUeETaN7v+Plq9/LKuDV
 8hOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795332018; x=1795936818;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=o8re6EZDSI55b5voUbfOtCkCAeZWYZ3ND/N+XRqjIEk=;
 b=E5x8T8CqgOwavSZWVXpqleFn2HxfD4NB5rFBy4dw5YY+08t5Dlr/dwyWiOqFsyb9yq
 syk/q8KhWBoeSL5rKSH53Zh4lMsU7slvnsouthjusIXxG9H9GpE7OxRPdDbulnI3Nhkc
 Z/3gLId670Jp1P/So4RJWp5XAXHck/seebGRulwnMVM1Sj3al4pXKLQ8VorN7PSPCv8G
 d3l5n5rEIG4JEABUaNidIFbQSdWn2b3EDq5SEY6Ls9FVlQpyy2WvS38qBJm2U1mfH+k8
 qXEHw0AryU245WtAtT7+/permGbxK3kj2MocELzpZI7zywWbWcLZVU5/tUUjQUQ+e3eI
 esZQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF6Q2GOi1ofLLWqQmdxlwOJmUPx6P0wH7kVzvUcqrbYywc1qh9P4Hriq08tANpDpsTatXIAmVrvQgs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+llzkwxm5OcIovpeVmDTTL3zJeRfSKCWMc/4hZjgfJS73aSp4W
 oekwH4tdgdFRvhkuEXdef9YqA4hRZlDq8E99JGFEANd0Kqk69bnrrzU+
X-Gm-Gg: AZFdTZcRcoszjpBIbpoe7DAy4GbWgrF9CSMHj60m1c5XvN9W10ADfmEA7HlO+fmY/A9
 C45Vj6lVvZtTqZ+NHqJAbztGnnNhzZWwBMyhTmqJsTCY39JwgL/oTtxCY8QVZtkldZQ9DSLamYI
 anLNdwMLGg9hMI7mdp5H3h5mIdbT05xKAK4gyBS/RwlZ3avnEM4yU/YYFg84v+HVtGB/3JqZeLM
 2xJDNpAAw94vm/oTJo82sdubrmYliad+bFf73zunQ/YEg+arjdjYREIFAMmhVyOrNhlaaKG8XKa
 1Il+uMasw+4ZA52ca+bHTVzTJYk+eFEEnAqvC5BNbpCqCxPrY0jRVa2CrbtCd2llsCOlSHbDjqJ
 AYvZelbV1KQUVq+TgpMBEW2IQ7lyei2irtDGRdBz7iGWZ01jC+xJLm80Aahv3GYXzsRF6Bv1J89
 KS2wQr9oN/NNT5XfLAKhw1ckwkB8e/YHZOtz2XsrnfMbdrw5MRoRLYL0l6rwmUlhyZyzailrbge
 sI9H/su9ujvmQXClLl2I7IgdEtr08eNBxB64kjO9DU+aXI8KkqGiyqVH9G+i6tN+u3H2qDUe8Q6
 e15yHjaqObXd5cpKW9p2QyyPEJI/lHP/IS3oXcQ3PjzRuPXkkOgqej/Rng==
X-Received: by 2002:a05:651c:b28:b0:39c:624d:82b9 with SMTP id
 38308e7fff4ca-3ae7f9a073amr23677191fa.4.1795332017916; 
 Sat, 21 Nov 2026 23:20:17 -0800 (PST)
Received: from archlinux ([194.28.181.64]) by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae804ee2bfsm21914051fa.9.2026.11.21.23.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 21 Nov 2026 23:20:17 -0800 (PST)
From: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
To: rust-for-linux@vger.kernel.org
Cc: Joel Fernandes <jfern@kernel.org>, Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>,
 Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
 Gary Guo <gary@garyguo.net>,
 =?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>,
 Trevor Gross <tmgross@umich.edu>,
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>,
 =?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3] rust: gpu: buddy: store the allocator inside the Mutex
Date: Sun, 22 Nov 2026 09:20:07 +0200
Message-ID: <20261122072007.14685-1-mbkchelofficialdev@gmail.com>
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

Signed-off-by: Ivan Tverdokhleb <mbkchelofficialdev@gmail.com>
Reviewed-by: Joel Fernandes <jfern@kernel.org>
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

Changes in v3:
  - Kept the name `inner` for the mutex field instead of renaming it
    to `lock`. (Danilo)
  - The SAFETY comment updates from v2 are gone, as the field keeps its
    original name.
  - Collected Reviewed-by from Joel.

v1: https://lore.kernel.org/rust-for-linux/20261114200703.33229-1-mbkchelofficialdev@gmail.com/
v2: https://lore.kernel.org/rust-for-linux/20261119111850.33270-1-mbkchelofficialdev@gmail.com/

 rust/kernel/gpu/buddy.rs | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/rust/kernel/gpu/buddy.rs b/rust/kernel/gpu/buddy.rs
index 691bb4062..4e08ec319 100644
--- a/rust/kernel/gpu/buddy.rs
+++ b/rust/kernel/gpu/buddy.rs
@@ -313,16 +313,11 @@ pub struct GpuBuddyParams {
 ///
 /// # Invariants
 ///
-/// The inner [`Opaque`] contains an initialized buddy allocator.
+/// The `inner` field contains an initialized buddy allocator wrapped in `Opaque`.
 #[pin_data(PinnedDrop)]
 struct GpuBuddyInner {
     #[pin]
-    inner: Opaque<bindings::gpu_buddy>,
-
-    // TODO: Replace `Mutex<()>` with `Mutex<Opaque<..>>` once `Mutex::new()`
-    // accepts `impl PinInit<T>`.
-    #[pin]
-    lock: Mutex<()>,
+    inner: Mutex<Opaque<bindings::gpu_buddy>>,
     /// Cached creation parameters (do not change after init).
     params: GpuBuddyParams,
 }
@@ -338,14 +333,13 @@ fn new(params: GpuBuddyParams) -> impl PinInit<Self, Error> {
         // `gpu_buddy_*` APIs. `try_pin_init!` only completes if all fields succeed,
         // so the invariant holds when construction finishes.
         try_pin_init!(Self {
-            inner <- Opaque::try_ffi_init(|ptr| {
+            inner <- new_mutex!(Opaque::try_ffi_init(|ptr| {
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
@@ -353,8 +347,7 @@ fn new(params: GpuBuddyParams) -> impl PinInit<Self, Error> {
     /// Lock the mutex and return a guard for accessing the allocator.
     fn lock(&self) -> GpuBuddyGuard<'_> {
         GpuBuddyGuard {
-            inner: self,
-            _guard: self.lock.lock(),
+            _guard: self.inner.lock(),
         }
     }
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
 
-- 
2.56.1

