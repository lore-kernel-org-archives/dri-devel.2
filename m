Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19A7606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 16:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=mgFkhCaG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58A7E10E283;
	Thu, 19 Nov 2026 16:37:11 +0000 (UTC)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9802F10E283
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 16:37:04 +0000 (UTC)
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4ba078abd78so18417045e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:37:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1795106223; x=1795711023;
 darn=lists.freedesktop.org; 
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=VESp6hsfsBjU8MDr+X58zX9DGjPHSl10HXSvMJRGh40=;
 b=mgFkhCaGUO/KAN10kurnPLFHaJiE7TM8kkf7ZbofM1O6YAAC2NWWKNQeGtNZqQkkMb
 Z62IwrVaNPjZGFIuLVX9lOzVTb2KSuan5+Ifk6txkGzhpZ538TR6oNBc/Rg7Y/0Q0kPM
 yel08x54j/UgGS7BVHs5nfTc9b0PylYxfNP618tKme9HtYF4CHryINrzGszSePZZ38sc
 E9VHT6tN6eMQ0OEup3y0jepPBkScNEL9iyc2QV+s5pninVX220O2ecxWgaXV59TmoEMJ
 uUDYbvG7AcNYFZ+5EzCgHUHlLhzucJUhPNRpAVsHUr+np50yP+lUqU4szy4Drb8jXROa
 IIhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795106223; x=1795711023;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VESp6hsfsBjU8MDr+X58zX9DGjPHSl10HXSvMJRGh40=;
 b=mN8fAmGJNG+GbKtiWOjBOOTUHEGtaXjXo5dfGHd0vzVrIAK3XU68THQvg1TCiabsfU
 DLTgNYH/zWFdjL5VsAE9G4qKa4xTqf5tiDFi1/jGSpdJtWEyk6/UHTIhsnx86jkNDlYJ
 wUBvR3HlBQ+knvgO9jR5JNB2QMtfZ0ObqYUghwy9x4oAWECeY659SYL6RbSJjXBOGRTR
 GX7ePkZBvShjqYysfxoWIzUGSjvj7TcZZUCy2UJ4jFuGeEObzTidSVdLUb7zOyGAwzv0
 Z+q9npOu02Cf9lpJXV3qmJ+5DGBElpMOq5r2HTxKO0gpmjCPNQcLbk3VJSR6BAmB+7er
 EloA==
X-Forwarded-Encrypted: i=1;
 AL+hErEXhedux5ET9UfhClIWFo0c46dD3hFdxzf0nZiGflyY2L7H8HB6QufQEJqgIftf/y6qFBSEmLBUp1Y=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/Y8F/34GTS3TkUsOtsdR4lA1qn4NzDdlkoIE7pak+ytENZ8sNj
 2WcOJKLKr+4bqpxLvb0PJGy9X5cKAUgqTYj0diKys1OTUkWTpjk51Ga5NUCHHzP6jTeJ6q2f/SS
 rZvCiE9rAi37vJkXD5A==
X-Received: from wmsl30.prod.google.com ([2002:a05:600c:1d1e:b0:4a2:df9b:ef74])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:820c:b0:49c:d019:70c5 with SMTP id
 5b1f17b1804b1-4bb887876c0mr2867805e9.0.1795106222831; 
 Thu, 19 Nov 2026 08:37:02 -0800 (PST)
Date: Thu, 19 Nov 2026 16:36:54 +0000
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAKUl/2oC/x3MQQqAIBBG4avErBtIIaGuEi0kf20WWWhFIN09a
 fkt3iuUkQSZxqZQwi1Z9lih2oaW1cYAFldNutNGKTVwOK57Y2dPywnRbuDFG3ToB6+NododCV6
 e/znN7/sB9gx+wmMAAAA=
X-Change-Id: 20261119-gpuvm-data-rename-cf6e0e59f266
X-Developer-Key: i=aliceryhl@google.com; a=openpgp;
 fpr=49F6C1FAA74960F43A5B86A1EE7A392FDE96209F
X-Developer-Signature: v=1; a=openpgp-sha256; l=2803; i=aliceryhl@google.com; 
 h=from:subject:message-id;
 bh=9nHlV2IX0ybZW/nMkDdw/FTgCb1QJu3QEYfuNAVRj0A=; 
 b=owEBbQKS/ZANAwAKAQRYvu5YxjlGAcsmYgBq/yWoV/6pHAaJqRouM2ol6MHJianug+Bx4ROFW
 +3RUAa1s22JAjMEAAEKAB0WIQSDkqKUTWQHCvFIvbIEWL7uWMY5RgUCav8lqAAKCRAEWL7uWMY5
 RixkD/9TEsvRdSu4RFQ4gmgUKRWqfYAK20JPBM8Uy3RWetQUpwN0EKmAxE++IZVd7IALAj4yVHh
 7QZVfsVeEKA6+p968hukuRdOG2rSeXsYkltoY7d3HDV9H7K1l0D9chzC1+Sit2Hwc6P2c+KC7Zw
 zXuxCwDij9gtTdeHHgrh0gIU0F29PAvBaD2Vb3UDcFVrEzATP8XmkJqTDkrsvG+9lmpdQWGKT4l
 8hs+v/VygwdwAQf/uMa/LQ5VOZ4RW3wQrcJeLTZ14b3dLlTTnsbNAWCZrj5gP0MbVTa/juAl2Hf
 rrzzTWw/Vbn4352u+sjHziaHvHAmdBqAbgzQCI5F5KyosGOPIYYjvRzIkUDBPNNmLGggimjMTBk
 /0VF0Ev6rEFJzwhu1ybCBj/QGD79XcHhu4o2vx3ljAW2LqsqsxJcVWLxcCXAbQgR2kRN/t0HMR7
 /MyBvKSqLW4cFoXd2+nrIkOTL6NwQnYxBLmqQkKwf60LIf+8m6QKs0ZlX686VtLJCiMMNfytrKI
 0AawmoOhuZSCS3+KfM55WzY9xyPeDHqMshWIFsW6sTGhPn/sbPCjLLCknfm2KQkv2nXdTG0V8bX
 hGLtXjOULF4YiVZpbHtN5Bf6Xg+7KKPPaEW+WP+SPqJfSOfGOfu38IxFnQGQdpsfxmw4PM7VcAw
 NV94UCWU3/05N1A==
X-Mailer: b4 0.14.3
Message-ID: <20261119-gpuvm-data-rename-v1-1-8eb773435fde@google.com>
Subject: [PATCH] rust: drm: gpuvm: rename UniqueRefGpuVm data accessors
From: Alice Ryhl <aliceryhl@google.com>
To: Danilo Krummrich <dakr@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 "=?utf-8?q?Thomas_Hellstr=C3=B6m?=" <thomas.hellstrom@linux.intel.com>,
 Miguel Ojeda <ojeda@kernel.org>, 
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
 "=?utf-8?q?Bj=C3=B6rn_Roy_Baron?=" <bjorn3_gh@protonmail.com>,
 Benno Lossin <lossin@kernel.org>, 
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
 Daniel Almeida <daniel.almeida@collabora.com>,
 Tamir Duberstein <tamird@kernel.org>, 
 Alexandre Courbot <acourbot@nvidia.com>,
 "=?utf-8?q?Onur_=C3=96zkan?=" <work@onurozkan.dev>
Cc: Sami Tolvanen <samitolvanen@google.com>, dri-devel@lists.freedesktop.org, 
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Alice Ryhl <aliceryhl@google.com>
Content-Type: text/plain; charset="utf-8"
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
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

`UniqueRefGpuVm` currently names its shared and mutable data accessors
`data_ref()` and `data()`, unlike `GpuVmBo::data(&self)` and standard
Rust naming conventions. Thus, rename them to `data(&self)` and
`data_mut(&mut self)` for consistency.

Link: https://lore.kernel.org/r/20261118111653.448550-1-aliceryhl@google.com
Signed-off-by: Alice Ryhl <aliceryhl@google.com>
---
 rust/kernel/drm/gpuvm/mod.rs    | 4 ++--
 rust/kernel/drm/gpuvm/sm_ops.rs | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/rust/kernel/drm/gpuvm/mod.rs b/rust/kernel/drm/gpuvm/mod.rs
index d9d43d719761..23e73da865fb 100644
--- a/rust/kernel/drm/gpuvm/mod.rs
+++ b/rust/kernel/drm/gpuvm/mod.rs
@@ -311,14 +311,14 @@ fn sm_step_remap<'op, 'ctx>(
 impl<T: DriverGpuVm> UniqueRefGpuVm<T> {
     /// Access the data owned by this `UniqueRefGpuVm` immutably.
     #[inline]
-    pub fn data_ref(&self) -> &T {
+    pub fn data(&self) -> &T {
         // SAFETY: By the type invariants we may access `data`.
         unsafe { &*self.0.data.get() }
     }
 
     /// Access the data owned by this `UniqueRefGpuVm` mutably.
     #[inline]
-    pub fn data(&mut self) -> &mut T {
+    pub fn data_mut(&mut self) -> &mut T {
         // SAFETY: By the type invariants we may access `data`.
         unsafe { &mut *self.0.data.get() }
     }
diff --git a/rust/kernel/drm/gpuvm/sm_ops.rs b/rust/kernel/drm/gpuvm/sm_ops.rs
index 742c151b2540..9f3fe7c954fb 100644
--- a/rust/kernel/drm/gpuvm/sm_ops.rs
+++ b/rust/kernel/drm/gpuvm/sm_ops.rs
@@ -381,7 +381,7 @@ impl<T: DriverGpuVm> GpuVm<T> {
         match p
             .sm_data
             .gpuvm
-            .data()
+            .data_mut()
             .sm_step_map(op, p.sm_data.user_context)
         {
             Ok(OpMapped { .. }) => 0,
@@ -402,7 +402,7 @@ impl<T: DriverGpuVm> GpuVm<T> {
             op: unsafe { &(*op).__bindgen_anon_1.unmap },
             _invariant: PhantomData,
         };
-        match p.gpuvm.data().sm_step_unmap(op, p.user_context) {
+        match p.gpuvm.data_mut().sm_step_unmap(op, p.user_context) {
             Ok(OpUnmapped { .. }) => 0,
             Err(err) => err.to_errno(),
         }
@@ -421,7 +421,7 @@ impl<T: DriverGpuVm> GpuVm<T> {
             op: unsafe { &(*op).__bindgen_anon_1.remap },
             _invariant: PhantomData,
         };
-        match p.gpuvm.data().sm_step_remap(op, p.user_context) {
+        match p.gpuvm.data_mut().sm_step_remap(op, p.user_context) {
             Ok(OpRemapped { .. }) => 0,
             Err(err) => err.to_errno(),
         }

---
base-commit: e55a991e09e3b44f0b0d8206bb523dc57c086341
change-id: 20261119-gpuvm-data-rename-cf6e0e59f266

Best regards,
-- 
Alice Ryhl <aliceryhl@google.com>

