Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6980606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 16:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LRiuSpiz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22B5210F049;
	Mon, 26 Oct 2026 16:41:55 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E799610F047
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 16:41:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A2CF4444FE;
 Mon, 26 Oct 2026 16:41:16 +0000 (UTC)
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
 t=1793032876;
 b=ndkuH2qDvAwdXtrbVARyKR6fsgWu0ugY8nYOsnBACZVME+lZgBFUrZCzB5PRibPUKeeM
 Lr0h53uygflXiYq/9aGmbbRDbPHHOvIAN0cZtjfn8JAU3Q2mFAXV8CdTA1vYNpOYG/IiN
 V1f/1Fp2k1IABKrJiSpyB7kOk782kMf4x5qMFpuU4vMTNAS/+BjkkyqVJ7HNO3NiTjUGX
 mnqUcQu6nhLUTekUUsMmSzivVcdddTuIucHHM4dQf7MxfvsNUXYOuxQoWCztnyJbKf2Pa
 KIuMEz7S1FDJXNn3/6kzf05YJHGpeiDaV2QNl4T9i/whXSCSYk37eDC+7T96jIxTU9w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
 c=relaxed/relaxed; t=1793032876;
 h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
 X-Mailer:X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
 X-Original-From:Reply-To;
 bh=GXUuCKtgp0cGhSwy/ojXyLE/iLRzYAr1n22ymcMALbs=;
 b=cXF+BvNRSvleTE5jxEPeyPOIi+nT+pOJ1kl/izXZUj+p4FOT8nf8XpJhM+vz2yBE4Uxz
 r69D7+jUmnQmpbzkBtvyUQFgnwCcSLSb2LmeZN1qf/o8nP0iznr9LneOT15AeI7UjdSEe
 nZKX3mtIfZIGFc2banHs5Pl9LHKc91+1sc+NdYR2w5pJCbT3SpKgU3+fbtT28PHtj7tgv
 jHGvef+67MQl6VT6LOuKZAe/fbXDaXaDivn3BppcKhMa/ngADsHhuiOfYHhPRoOxG+Dao
 H9ZCTkPbsdtplDW0f/2z0OhO7t1z/+eik+n7Rdh2he5qXcq0WncDzWiVYC4AvWAFQgQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
 arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
 (No client certificate requested)
 by smtp.kernel.org (Postfix) with ESMTPS id 24DD21F01828;
 Mon, 26 Oct 2026 16:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793032876;
 bh=GXUuCKtgp0cGhSwy/ojXyLE/iLRzYAr1n22ymcMALbs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
 b=LRiuSpizN8a5oB14DEeRYUaN8/DvfVlZlt0yxXg63L7mgmSHw6P/s8ZZVqhWOOkXx
 cQafkDQykJ6v9t0oJVEmBOosjQNV7nhgMKmj6RRGoDHn/IK+IKFJVcOMl18KBq6nf/
 a9RkAhz01Yf8lBx2Tjm1ZDyegmIxIOHV0K1GjYFSQ69+aoKogOOYjodOFKBlfqMo7b
 luuA16EMLJ1I3UlW9uOWNN8Sd62bSCa55lU5nQwbt70mLKdBeS724N2gZvQdFXvp6y
 vzE+m9TDShZGQswWZIhHGXaZleae4ab4WBT4DQszTuqqYIHXisdNgy38ZRsaQa/Ae6
 9ruPTCEdF7a3Q==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
 by lkml.kernel.org (Postfix) with ESMTP id B92D044DED;
 Mon, 26 Oct 2026 16:41:12 +0000 (UTC)
From: Ke Sun via B4 Relay <devnull+sunke.kylinos.cn@kernel.org>
Date: Tue, 27 Oct 2026 00:41:04 +0800
Subject: [PATCH v5 11/11] drm/tyr: gem: map cached BOs for
 DRM_PANTHOR_BO_WB_MMAP
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261027-tyr-ioctls-v5-11-59dfe98cb003@kylinos.cn>
References: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
In-Reply-To: <20261027-tyr-ioctls-v5-0-59dfe98cb003@kylinos.cn>
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
 Lorenzo Stoakes <ljs@kernel.org>, Lyude Paul <lyude@redhat.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sami Tolvanen <samitolvanen@google.com>, rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev, 
 Ke Sun <sunke@kylinos.cn>, Alvin Sun <alvin.sun@linux.dev>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793032870; l=4490;
 i=sunke@kylinos.cn; s=20260317; h=from:subject:message-id;
 bh=xSP6p7C7nG8SAdUfnGBh8hvRVeMZVo3JIuOGc55Xvp4=;
 b=7PYLAEGZJRQp7FGT4ZQff97+LUj+o5osxzNqaB1SFjZyzZkZh61cpNNRFmMJ9Gg/WpzyWhvPM
 ZIwEyaiSoGrB1xE2+2syZLDmBzMjrUmA2gqPoJp09A9O2GMktSBfkDz
X-Developer-Key: i=sunke@kylinos.cn; a=ed25519;
 pk=CHcwQp8GSoj25V/L1ZWNSQjWp9eSIb0s9LKr0Nm3WuE=
X-Endpoint-Received: by B4 Relay for sunke@kylinos.cn/20260317 with auth_id=950
X-Original-From: Ke Sun <sunke@kylinos.cn>
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
Reply-To: sunke@kylinos.cn
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Sami Tolvanen <samitolvanen@google.com>

Userspace may request a cacheable CPU mapping for a buffer it accesses
frequently. Accept DRM_PANTHOR_BO_WB_MMAP in bo_create and map the
buffer cached when the flag is set. Coherent devices already map
cached. NO_MMAP and WB_MMAP together are rejected with EINVAL.

On non-coherent platforms userspace owns the CPU cache maintenance
around GPU access to these buffers.

Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
[ Split the BO_CREATE validation and add the WB_MMAP flag checks
  from the original. - Alvin ]
Co-developed-by: Alvin Sun <alvin.sun@linux.dev>
Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
---
 drivers/gpu/drm/tyr/file.rs | 25 +++++++++++++++++++------
 drivers/gpu/drm/tyr/gem.rs  | 18 +++++++++++-------
 2 files changed, 30 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/tyr/file.rs b/drivers/gpu/drm/tyr/file.rs
index d4d6a6742b2e1..6f4550d14bb39 100644
--- a/drivers/gpu/drm/tyr/file.rs
+++ b/drivers/gpu/drm/tyr/file.rs
@@ -258,19 +258,32 @@ pub(crate) fn bo_create(
         bocreate: &mut uapi::drm_panthor_bo_create,
         file: &TyrDrmFile,
     ) -> Result<u32> {
-        if bocreate.size == 0
-            || bocreate.pad != 0
-            || bocreate.flags & !uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP != 0
-        {
+        if bocreate.size == 0 || bocreate.pad != 0 {
             dev_dbg!(
                 ddev.as_ref(),
-                "Invalid BO_CREATE params: size={}, pad={}, flags={:#x}\n",
+                "Invalid BO_CREATE params: size={}, pad={}\n",
                 bocreate.size,
-                bocreate.pad,
+                bocreate.pad
+            );
+            return Err(EINVAL);
+        }
+
+        let no_mmap = uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_NO_MMAP;
+        let wb_mmap = uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_WB_MMAP;
+        let valid_flags = no_mmap | wb_mmap;
+
+        if bocreate.flags & !valid_flags != 0 {
+            dev_dbg!(
+                ddev.as_ref(),
+                "Invalid BO_CREATE flags: {:#x}\n",
                 bocreate.flags
             );
             return Err(EINVAL);
         }
+        if bocreate.flags & no_mmap != 0 && bocreate.flags & wb_mmap != 0 {
+            dev_dbg!(ddev.as_ref(), "BO_CREATE: NO_MMAP conflicts with WB_MMAP\n");
+            return Err(EINVAL);
+        }
 
         if bocreate.exclusive_vm_id != 0 {
             dev_dbg!(ddev.as_ref(), "BO_CREATE: exclusive_vm_id not supported\n");
diff --git a/drivers/gpu/drm/tyr/gem.rs b/drivers/gpu/drm/tyr/gem.rs
index fad0720ce7123..d3791b62d5a7b 100644
--- a/drivers/gpu/drm/tyr/gem.rs
+++ b/drivers/gpu/drm/tyr/gem.rs
@@ -17,7 +17,8 @@
     sync::{
         aref::ARef,
         Arc, //
-    }, //
+    },
+    uapi, //
 };
 
 use crate::{
@@ -63,13 +64,16 @@ fn new(_dev: &TyrDrmDevice, _size: usize, args: BoCreateArgs) -> impl PinInit<Se
 /// Type alias for Tyr GEM buffer objects.
 pub(crate) type Bo = gem::shmem::Object<BoData>;
 
-/// Returns whether a BO should be mapped write-combine given the device's
-/// DMA coherence.
-pub(crate) fn should_map_wc(coherent: bool) -> bool {
+/// Returns whether a BO should be mapped write-combine.
+pub(crate) fn should_map_wc(coherent: bool, flags: u32) -> bool {
     if coherent {
         return false;
     }
 
+    if flags & uapi::drm_panthor_bo_flags_DRM_PANTHOR_BO_WB_MMAP != 0 {
+        return false;
+    }
+
     true
 }
 
@@ -86,7 +90,7 @@ pub(crate) fn new_object(
 
     let aligned_size = size.checked_next_multiple_of(PAGE_SIZE).ok_or(EINVAL)?;
 
-    let map_wc = should_map_wc(coherent);
+    let map_wc = should_map_wc(coherent, flags);
     let bo = Bo::new(
         ddev,
         aligned_size,
@@ -116,7 +120,7 @@ pub(crate) fn new_dummy_object(ddev: &TyrDrmDevice, coherent: bool) -> Result<AR
         ddev,
         4096,
         shmem::ObjectConfig {
-            map_wc: should_map_wc(coherent),
+            map_wc: should_map_wc(coherent, 0),
             parent_resv_obj: None,
         },
         BoCreateArgs { flags: 0 },
@@ -174,7 +178,7 @@ pub(crate) fn new(
             ddev,
             bo_size,
             shmem::ObjectConfig {
-                map_wc: should_map_wc(coherent),
+                map_wc: should_map_wc(coherent, 0),
                 parent_resv_obj: None,
             },
             BoCreateArgs { flags: 0 },

-- 
2.43.0


