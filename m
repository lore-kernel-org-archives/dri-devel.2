Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8638CCD6E52
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35197112B7B;
	Sun, 31 May 2026 13:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=pm.me header.i=@pm.me header.b="UrglIUm3";
	dkim-atps=neutral
Received: from mail-244102.protonmail.ch (mail-244102.protonmail.ch
 [109.224.244.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5894112A86
 for <dri-devel@lists.freedesktop.org>; Sun, 31 May 2026 05:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
 s=protonmail3; t=1780203549; x=1780462749;
 bh=K+8OFb6m2BhuUAkJ/JJ3Js3mjRVZ001+PKPq5jYUsxY=;
 h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=UrglIUm3HCGYFcIczw/PZS14z0l01yf2anJsDfMMFCo58kFXJ7ZIukZCCU9pj40Xu
 oEm8QvfTowjrUzDAemaT1r/GKv2aDRjT73LWi5z5uYC8nvF7lymhICbpSPYgymbq8V
 eTzF2d43tUqMO140BkiLRwbjGjhB4Qc/HOO6wBFE+Ep5n9RX8OS6AKlrAiP5WxEj7L
 oDJsmDJ9aXOkJ2jNxL6GFhF+MKDreK+Bpwahuj1alEUYl/7b7O0xNAxtZV2CQ1bO2J
 0qPmtGSYeH7L1O73TMlNwW7NWcNsf3rtAeTsBzLTX9Hw/Gj+IbKNJcsHYNVdmGINvH
 fw/BeXLLPEIQg==
Date: Sun, 31 May 2026 04:59:04 +0000
To: dri-devel@lists.freedesktop.org
From: =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Cc: airlied@gmail.com, simona@ffwll.ch, alexander.deucher@amd.com,
 christian.koenig@amd.com, harry.wentland@amd.com, corbet@lwn.net,
 amd-gfx@lists.freedesktop.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?utf-8?Q?Gustavo_Kenji_Mendon=C3=A7a_Kaneko?= <kaneko.dev@pm.me>
Subject: [PATCH 1/2] drm: fix spelling mistakes in comments and documentation
Message-ID: <20260531045852.41849-1-kaneko.dev@pm.me>
Feedback-ID: 165279626:user:proton
X-Pm-Message-ID: afb4c42cef220faf058e256e353ae6c0ff2e2bf2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

Fix multiple spelling mistakes across the DRM subsystem:

- 'occured' -> 'occurred' in:
  - drm_debugfs_crc.h
  - amdgpu_ctx.c
  - amdgpu_ids.c (x2)
  - amdgpu_job.h
  - radeon_fence.c (x2)

- 'fucntions' -> 'functions' in Documentation/gpu/todo.rst
- 'doesn't exists' -> 'doesn't exist' in amdgpu_gmc.h

Signed-off-by: Gustavo Kenji Mendon=C3=A7a Kaneko <kaneko.dev@pm.me>
---
 Documentation/gpu/todo.rst              | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h | 2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 ++--
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.h | 2 +-
 drivers/gpu/drm/radeon/radeon_fence.c   | 4 ++--
 include/drm/drm_debugfs_crc.h           | 2 +-
 7 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/Documentation/gpu/todo.rst b/Documentation/gpu/todo.rst
index bc9f14c8a2ec..841e4e986c48 100644
--- a/Documentation/gpu/todo.rst
+++ b/Documentation/gpu/todo.rst
@@ -55,7 +55,7 @@ There are still drivers that use drm_simple_display_pipe.=
 The task here is to
 convert them to use regular atomic helpers. Search for a driver that calls
 drm_simple_display_pipe_init() and inline all helpers from drm_simple_kms_=
helper.c
 into the driver, such that no simple-KMS interfaces are required. Please a=
lso
-rename all inlined fucntions according to driver conventions.
+rename all inlined functions according to driver conventions.
=20
 Contact: Thomas Zimmermann, respective driver maintainer
=20
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ctx.c
index 7af86a32c0c5..e5884bb4d63a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ctx.c
@@ -564,7 +564,7 @@ static int amdgpu_ctx_query(struct amdgpu_device *adev,
 =09out->state.flags =3D 0x0;
 =09out->state.hangs =3D 0x0;
=20
-=09/* determine if a GPU reset has occured since the last call */
+=09/* determine if a GPU reset has occurred since the last call */
 =09reset_counter =3D atomic_read(&adev->gpu_reset_counter);
 =09/* TODO: this should ideally return NO, GUILTY, or INNOCENT. */
 =09if (ctx->reset_counter_query =3D=3D reset_counter)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_gmc.h
index 6ab4c1e297fc..85a0d9bcba16 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gmc.h
@@ -39,7 +39,7 @@
 =09=09=09=090xff00000000000000ULL : 0xffff800000000000ULL)
=20
 /*
- * Hardware is programmed as if the hole doesn't exists with start and end
+ * Hardware is programmed as if the hole doesn't exist with start and end
  * address values.
  *
  * This mask is used to remove the upper 16bits of the VA and so come up w=
ith
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_ids.c
index 124fb38eb465..095ab609623f 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
@@ -161,12 +161,12 @@ void amdgpu_pasid_free_delayed(struct dma_resv *resv,
  */
=20
 /**
- * amdgpu_vmid_had_gpu_reset - check if reset occured since last use
+ * amdgpu_vmid_had_gpu_reset - check if reset occurred since last use
  *
  * @adev: amdgpu_device pointer
  * @id: VMID structure
  *
- * Check if GPU reset occured since last use of the VMID.
+ * Check if GPU reset occurred since last use of the VMID.
  */
 bool amdgpu_vmid_had_gpu_reset(struct amdgpu_device *adev,
 =09=09=09       struct amdgpu_vmid *id)
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h b/drivers/gpu/drm/amd/=
amdgpu/amdgpu_job.h
index 56a88e14a044..bc011b4639f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.h
@@ -31,7 +31,7 @@
 #define AMDGPU_PREAMBLE_IB_PRESENT          (1 << 0)
 /* bit set means preamble IB is first presented in belonging context */
 #define AMDGPU_PREAMBLE_IB_PRESENT_FIRST    (1 << 1)
-/* bit set means context switch occured */
+/* bit set means context switch occurred */
 #define AMDGPU_HAVE_CTX_SWITCH              (1 << 2)
 /* bit set means IB is preempted */
 #define AMDGPU_IB_PREEMPTED                 (1 << 3)
diff --git a/drivers/gpu/drm/radeon/radeon_fence.c b/drivers/gpu/drm/radeon=
/radeon_fence.c
index 02a40e4750c7..943861b62ee9 100644
--- a/drivers/gpu/drm/radeon/radeon_fence.c
+++ b/drivers/gpu/drm/radeon/radeon_fence.c
@@ -191,7 +191,7 @@ static int radeon_fence_check_signaled(wait_queue_entry=
_t *wait,
  * @ring: ring index the fence is associated with
  *
  * Checks the current fence value and calculates the last
- * signalled fence value. Returns true if activity occured
+ * signalled fence value. Returns true if activity occurred
  * on the ring, and the fence_queue should be waken up.
  */
 static bool radeon_fence_activity(struct radeon_device *rdev, int ring)
@@ -262,7 +262,7 @@ static bool radeon_fence_activity(struct radeon_device =
*rdev, int ring)
  * @work: delayed work item
  *
  * Checks for fence activity and if there is none probe
- * the hardware if a lockup occured.
+ * the hardware if a lockup occurred.
  */
 static void radeon_fence_check_lockup(struct work_struct *work)
 {
diff --git a/include/drm/drm_debugfs_crc.h b/include/drm/drm_debugfs_crc.h
index 1b4c98c2f838..d7da666b50ca 100644
--- a/include/drm/drm_debugfs_crc.h
+++ b/include/drm/drm_debugfs_crc.h
@@ -49,7 +49,7 @@ struct drm_crtc_crc_entry {
  * @lock: protects the fields in this struct
  * @source: name of the currently configured source of CRCs
  * @opened: whether userspace has opened the data file for reading
- * @overflow: whether an overflow occured.
+ * @overflow: whether an overflow occurred.
  * @entries: array of entries, with size of %DRM_CRC_ENTRIES_NR
  * @head: head of circular queue
  * @tail: tail of circular queue
--=20
2.54.0


