Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 380D1C88E72
	for <dri-devel@archiver.kernel.org>; Mon, 14 Sep 2026 19:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2E24E10F1A4;
	Mon, 14 Sep 2026 19:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q/YFWnJF";
	dkim-atps=neutral
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E707810F1A6
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 19:35:37 +0000 (UTC)
Received: by mail-pj2-f13.google.com with SMTP id
 98e67ed59e1d1-39dbdfaef3cso2486450a91.1
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 12:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789414537; x=1790019337; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0uJt/RoMfJ8NvUHnZeb2O6VvOmnSph4gCduViChE2IE=;
 b=Q/YFWnJFB1HVFcdrxCthR2qtPE6FOSbkzb/VJQ7a+dyO7LUGWeA7v/6xBe45cc0m37
 KuZwvelIKxmtla4w4msWctFYCYnQFbTo9sh6241S/i006xX6w6Av/7MS3h4Chl9cSm2x
 F0vqQYUCe//YQ2PPt2kcaBz0bwccod8YNpDeSopBUtxmp6Uxu5nzUhQOSTipxP5XxvIa
 5SBq60PlTHWblqwhPLUbeoNj5mgcJ7wlwD4/9mSskhsLIKZSXxdR1dEj1wrUpJUBGr9j
 BRrUcb0edovvbfOxmY0ywPAiOTFv+Go9liWjId7iSCW5vRzBNnzpBG0E/Hn7mOD0ndYj
 j0OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789414537; x=1790019337;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0uJt/RoMfJ8NvUHnZeb2O6VvOmnSph4gCduViChE2IE=;
 b=D02nUxfnzPjiOBfLkimjZnHpk/6W1CySobp4s/9aC6obvruHO2rfuAYgt0k3KYKE2z
 uqCyVVLlGWJdptL6i7tNl7QXDRyOWo5HInb5levUIW/sngM4XGGPJVBEj/QqS9cXR4rQ
 EvDE1CQZJJGKI7JCMfupsVGvF15TGEIwooS3iaXlV0uSa1s7mfsupaFu4NxSvraU1EIh
 vG8ra+pJiVSy7umsyqs/sJx5wz1VIf57ZbF6pwTG1cBNZLeUzNA9KII+hYVphGuVon1s
 7SHHnMNIme4RhH2Imn8P2gU5NqwmLu49vCYZ2VrmFGTMhn15ZAobtXEqzhEG7HHn0EIW
 0fOg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxIW6yf9kIqj+9eDIvUStyEH5DQz1Yp5rIZ4mYFpSxSm2ALguqAMXjzclnDxgyDnJNbbG75wKHHmRE=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kTVhvIWT9D81yBqsKsyTdBNd8sEVIaG/Q01kfVC+cac13fHXsO
 wNwQ1W8M5XyG0+85bqfq/oNvz0begReEaT1ugTcrKKTUSHuUU9q0EjIF
X-Gm-Gg: AYBFou24+Y7W/MhuteXlsmn0L4BfD5njZJue67frmiTAGh46LHFuA2EwP8Zp9DgGSP9
 6/aYfQf0XsQ5oMZoUKX2y3ZF0Y5ZHhqkvN1vCZkLANZC7+WEEe2odKrz9ZTmhL1ZdovxHWzp6nu
 hROKvJCY8cAqcs86n7qMD8t3RGkXuPzNC4s/HrEyuXcRBx4mku2vm65urUOPbtm6AjuVSoHnxLV
 FuLFDRhfZyvxbm/zzfT1dvhpaQxsvSVqt0S6tuUoBFM7dH7C2Fwt5vumeRaRPQwVA/agT7h1d7T
 ReMv+1kndkNMomvycva0pVsKuliwU+lkXpJD/zjgAh0n8ZZS6V340P6QlZQafatYePPj0/MaIx9
 uaQzmSrnNgaiMsP/3dOqMLh1BIrE/5qjUd7dvc7SgDEDj/rxtdcSnnhXzI1Uj9Zv0glmLXZow1Q
 +SjyC/jdofuFLxRqOsLOE7Jc5ofUs4UyH2+tpG52Pp8mC9tgt7F9E9/a3wqlRh5g30YeIw0lqpD
 zk44/8qpt+VCHJipqc2pB+yr7ph/qR9Gtr7WoYwj6gwPii4f4XB3JvD
X-Received: by 2002:a17:90a:1181:b0:39d:eda6:8a01 with SMTP id
 98e67ed59e1d1-39deda68bc0mr5354083a91.21.1789414537178; 
 Mon, 14 Sep 2026 12:35:37 -0700 (PDT)
Received: from localhost.localdomain ([49.37.219.118])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39dfda24dcbsm916577a91.5.2026.09.14.12.35.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 12:35:36 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: amd-gfx@lists.freedesktop.org
Cc: alex.hung@amd.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 dri-devel@lists.freedesktop.org,
 Mohammed Anees <pvmohammedanees2003@gmail.com>
Subject: [PATCH v2] drm/amdgpu: pass scanout position values directly
Date: Tue, 15 Sep 2026 01:05:09 +0530
Message-ID: <20260914193509.36836-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The DC scanout position helper already returns vblank start, vblank end,
horizontal position and vertical position as separate values.

dm_crtc_get_scanoutpos() currently packs these values into the legacy
register-style vbl and position values, only for the amdgpu base driver
to unpack them again.

Change page_flip_get_scanoutpos() to return the individual values
directly. Preserve the full 32 bit scanout position values returned
by DC instead of truncating them to 13 bits through legacy packed
register representation.

For the legacy DCE implementations, keep decoding the packed hardware
register values in the backend before returning them through the common
interface. This keeps the register specific representation local to the
DCE code.

Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
Changes in v2:
- Move scanout position assignments to earlier place. 
- Restore the descriptive scanout position variable names.
- Link to v1: https://lore.kernel.org/all/20260908082045.99555-1-pvmohammedanees2003@gmail.com/

 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   | 21 ++++---
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.h   |  5 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h      |  8 ++-
 drivers/gpu/drm/amd/amdgpu/dce_v10_0.c        | 20 +++++--
 drivers/gpu/drm/amd/amdgpu/dce_v6_0.c         | 20 +++++--
 drivers/gpu/drm/amd/amdgpu/dce_v8_0.c         | 20 +++++--
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 31 +++++-----
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  3 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  | 56 ++++++++++++-------
 9 files changed, 125 insertions(+), 59 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
index 59ea338b554c..88fb9b1abed2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.c
@@ -1762,7 +1762,8 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 			int *hpos, ktime_t *stime, ktime_t *etime,
 			const struct drm_display_mode *mode)
 {
-	u32 vbl = 0, position = 0;
+	u32 scan_vbl_start = 0, scan_vbl_end = 0;
+	u32 scan_vpos = 0, scan_hpos = 0;
 	int vbl_start, vbl_end, vtotal, ret = 0;
 	bool in_vbl = true;
 
@@ -1774,8 +1775,11 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 	if (stime)
 		*stime = ktime_get();
 
-	if (amdgpu_display_page_flip_get_scanoutpos(adev, pipe, &vbl, &position) == 0)
+	if (amdgpu_display_page_flip_get_scanoutpos(adev, pipe,
+						    &scan_vbl_start, &scan_vbl_end,
+						    &scan_vpos, &scan_hpos) == 0) {
 		ret |= DRM_SCANOUTPOS_VALID;
+	}
 
 	/* Get optional system timestamp after query. */
 	if (etime)
@@ -1783,16 +1787,15 @@ int amdgpu_display_get_crtc_scanoutpos(struct drm_device *dev,
 
 	/* preempt_enable_rt() should go right here in PREEMPT_RT patchset. */
 
-	/* Decode into vertical and horizontal scanout position. */
-	*vpos = position & 0x1fff;
-	*hpos = (position >> 16) & 0x1fff;
+	*vpos = scan_vpos;
+	*hpos = scan_hpos;
 
 	/* Valid vblank area boundaries from gpu retrieved? */
-	if (vbl > 0) {
-		/* Yes: Decode. */
+	if (scan_vbl_start || scan_vbl_end) {
 		ret |= DRM_SCANOUTPOS_ACCURATE;
-		vbl_start = vbl & 0x1fff;
-		vbl_end = (vbl >> 16) & 0x1fff;
+		vbl_start = scan_vbl_start;
+		vbl_end = scan_vbl_end;
 	} else {
 		/* No: Fake something reasonable which gives at least ok results. */
 		vbl_start = mode->crtc_vdisplay;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
index 49a29bf47a37..9de1891f50f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_display.h
@@ -33,7 +33,10 @@
 #define amdgpu_display_hpd_get_gpio_reg(adev) (adev)->mode_info.funcs->hpd_get_gpio_reg((adev))
 #define amdgpu_display_bandwidth_update(adev) (adev)->mode_info.funcs->bandwidth_update((adev))
 #define amdgpu_display_page_flip(adev, crtc, base, async) (adev)->mode_info.funcs->page_flip((adev), (crtc), (base), (async))
-#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, vbl, pos) (adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc), (vbl), (pos))
+#define amdgpu_display_page_flip_get_scanoutpos(adev, crtc, v_blank_start, v_blank_end, \
+						v_position, h_position) \
+	((adev)->mode_info.funcs->page_flip_get_scanoutpos((adev), (crtc), \
+			(v_blank_start), (v_blank_end), (v_position), (h_position)))
 #define amdgpu_display_add_encoder(adev, e, s, c) (adev)->mode_info.funcs->add_encoder((adev), (e), (s), (c))
 #define amdgpu_display_add_connector(adev, ci, sd, ct, ib, coi, h, r) (adev)->mode_info.funcs->add_connector((adev), (ci), (sd), (ct), (ib), (coi), (h), (r))
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
index 7c784277396a..bb4d60698ee9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_mode.h
@@ -277,8 +277,12 @@ struct amdgpu_display_funcs {
 	/* pageflipping */
 	void (*page_flip)(struct amdgpu_device *adev,
 			  int crtc_id, u64 crtc_base, bool async);
-	int (*page_flip_get_scanoutpos)(struct amdgpu_device *adev, int crtc,
-					u32 *vbl, u32 *position);
+	int (*page_flip_get_scanoutpos)(struct amdgpu_device *adev,
+					int crtc,
+					u32 *v_blank_start,
+					u32 *v_blank_end,
+					u32 *v_position,
+					u32 *h_position);
 	/* display topology setup */
 	void (*add_encoder)(struct amdgpu_device *adev,
 			    uint32_t encoder_enum,
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
index 7de7adc8f225..cd12190fb962 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v10_0.c
@@ -256,14 +256,26 @@ static void dce_v10_0_page_flip(struct amdgpu_device *adev,
 	RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset);
 }
 
-static int dce_v10_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
-					u32 *vbl, u32 *position)
+static int dce_v10_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
+					 int crtc,
+					 u32 *v_blank_start,
+					 u32 *v_blank_end,
+					 u32 *v_position,
+					 u32 *h_position)
 {
+	u32 vbl, position;
+
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
 
-	*vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
-	*position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
+	vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
+	position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
+
+	*v_blank_start = vbl & 0x1fff;
+	*v_blank_end = (vbl >> 16) & 0x1fff;
+
+	*v_position = position & 0x1fff;
+	*h_position = (position >> 16) & 0x1fff;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
index 3c1d6901127d..f2c60074f0f4 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v6_0.c
@@ -220,14 +220,26 @@ static void dce_v6_0_page_flip(struct amdgpu_device *adev,
 	RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset);
 }
 
-static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
-					u32 *vbl, u32 *position)
+static int dce_v6_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
+					int crtc,
+					u32 *v_blank_start,
+					u32 *v_blank_end,
+					u32 *v_position,
+					u32 *h_position)
 {
+	u32 vbl, position;
+
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
 
-	*vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
-	*position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
+	vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
+	position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
+
+	*v_blank_start = vbl & 0x1fff;
+	*v_blank_end = (vbl >> 16) & 0x1fff;
+
+	*v_position = position & 0x1fff;
+	*h_position = (position >> 16) & 0x1fff;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
index a17944d5e843..5efdb5eea450 100644
--- a/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/dce_v8_0.c
@@ -204,14 +204,26 @@ static void dce_v8_0_page_flip(struct amdgpu_device *adev,
 	RREG32(mmGRPH_PRIMARY_SURFACE_ADDRESS + amdgpu_crtc->crtc_offset);
 }
 
-static int dce_v8_0_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
-					u32 *vbl, u32 *position)
+static int dce_v8_0_crtc_get_scanoutpos(struct amdgpu_device *adev,
+					int crtc,
+					u32 *v_blank_start,
+					u32 *v_blank_end,
+					u32 *v_position,
+					u32 *h_position)
 {
+	u32 vbl, position;
+
 	if ((crtc < 0) || (crtc >= adev->mode_info.num_crtc))
 		return -EINVAL;
 
-	*vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
-	*position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
+	vbl = RREG32(mmCRTC_V_BLANK_START_END + crtc_offsets[crtc]);
+	position = RREG32(mmCRTC_STATUS_POSITION + crtc_offsets[crtc]);
+
+	*v_blank_start = vbl & 0x1fff;
+	*v_blank_end = (vbl >> 16) & 0x1fff;
+
+	*v_position = position & 0x1fff;
+	*h_position = (position >> 16) & 0x1fff;
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index df649ae66de2..3e8e45756bd4 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -188,10 +188,13 @@ STATIC_IFN_KUNIT u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc)
 }
 EXPORT_IF_KUNIT(dm_vblank_get_counter);
 
-STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
-					    u32 *vbl, u32 *position)
+STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev,
+					    int crtc,
+					    u32 *v_blank_start,
+					    u32 *v_blank_end,
+					    u32 *v_position,
+					    u32 *h_position)
 {
-	u32 v_blank_start = 0, v_blank_end = 0, h_position = 0, v_position = 0;
 	struct amdgpu_crtc *acrtc = NULL;
 	struct dc *dc = adev->dm.dc;
 
@@ -209,18 +212,16 @@ STATIC_IFN_KUNIT int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc
 	if (dc && dc->caps.ips_support && dc->idle_optimizations_allowed)
 		dc_allow_idle_optimizations(dc, false);
 
-	/*
-	 * TODO rework base driver to use values directly.
-	 * for now parse it back into reg-format
-	 */
-	dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
-				 &v_blank_start,
-				 &v_blank_end,
-				 &h_position,
-				 &v_position);
-
-	*position = v_position | (h_position << 16);
-	*vbl = v_blank_start | (v_blank_end << 16);
+	if (!dc_stream_get_scanoutpos(acrtc->dm_irq_params.stream,
+				      v_blank_start,
+				      v_blank_end,
+				      h_position,
+				      v_position)) {
+		*v_blank_start = 0;
+		*v_blank_end = 0;
+		*v_position = 0;
+		*h_position = 0;
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
index c99a84bb040e..a13042951a4b 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h
@@ -1169,7 +1169,8 @@ int dm_set_powergating_state(struct amdgpu_ip_block *ip_block,
 void dm_bandwidth_update(struct amdgpu_device *adev);
 u32 dm_vblank_get_counter(struct amdgpu_device *adev, int crtc);
 int dm_crtc_get_scanoutpos(struct amdgpu_device *adev, int crtc,
-			   u32 *vbl, u32 *position);
+			   u32 *v_blank_start, u32 *v_blank_end,
+			   u32 *v_position, u32 *h_position);
 struct dm_atomic_state *dm_atomic_get_new_state(struct drm_atomic_commit *state);
 struct drm_private_state *dm_atomic_duplicate_state(struct drm_private_obj *obj);
 void dm_atomic_destroy_state(struct drm_private_obj *obj,
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
index 6335fc23e977..88d868178068 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/tests/amdgpu_dm_test.c
@@ -158,15 +158,19 @@ static void dm_test_vblank_get_counter_no_stream(struct kunit *test)
 static void dm_test_crtc_get_scanoutpos_invalid_crtc(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
-	u32 vbl = 0;
-	u32 position = 0;
+	u32 v_blank_start = 0;
+	u32 v_blank_end = 0;
+	u32 v_position = 0;
+	u32 h_position = 0;
 
 	adev->mode_info.num_crtc = 1;
 
-	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, -1, &vbl, &position),
-			-EINVAL);
-	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 1, &vbl, &position),
-			-EINVAL);
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, -1,
+						     &v_blank_start, &v_blank_end,
+						     &v_position, &h_position), -EINVAL);
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 1,
+						     &v_blank_start, &v_blank_end,
+						     &v_position, &h_position), -EINVAL);
 }
 
 /**
@@ -177,8 +181,10 @@ static void dm_test_crtc_get_scanoutpos_no_stream(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
 	struct amdgpu_crtc *acrtc;
-	u32 vbl = 0;
-	u32 position = 0;
+	u32 v_blank_start = 0;
+	u32 v_blank_end = 0;
+	u32 v_position = 0;
+	u32 h_position = 0;
 
 	acrtc = kunit_kzalloc(test, sizeof(*acrtc), GFP_KERNEL);
 	KUNIT_ASSERT_NOT_NULL(test, acrtc);
@@ -186,9 +192,13 @@ static void dm_test_crtc_get_scanoutpos_no_stream(struct kunit *test)
 	adev->mode_info.num_crtc = 1;
 	adev->mode_info.crtcs[0] = acrtc;
 
-	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
-	KUNIT_EXPECT_EQ(test, vbl, 0U);
-	KUNIT_EXPECT_EQ(test, position, 0U);
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
+						     &v_blank_start, &v_blank_end,
+						     &v_position, &h_position), 0);
+	KUNIT_EXPECT_EQ(test, v_blank_start, 0U);
+	KUNIT_EXPECT_EQ(test, v_blank_end, 0U);
+	KUNIT_EXPECT_EQ(test, v_position, 0U);
+	KUNIT_EXPECT_EQ(test, h_position, 0U);
 }
 
 /**
@@ -1324,14 +1334,20 @@ static void dm_test_crtc_get_scanoutpos_unmapped_stream(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
 	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
-	u32 vbl = 0xdeadbeef;
-	u32 position = 0xdeadbeef;
+	u32 v_blank_start = 0xdeadbeef;
+	u32 v_blank_end = 0xdeadbeef;
+	u32 v_position = 0xdeadbeef;
+	u32 h_position = 0xdeadbeef;
 
 	dm_test_crtc_with_stream(test, adev, dc);
 
-	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
-	KUNIT_EXPECT_EQ(test, vbl, 0U);
-	KUNIT_EXPECT_EQ(test, position, 0U);
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
+						     &v_blank_start, &v_blank_end,
+						     &v_position, &h_position), 0);
+	KUNIT_EXPECT_EQ(test, v_blank_start, 0U);
+	KUNIT_EXPECT_EQ(test, v_blank_end, 0U);
+	KUNIT_EXPECT_EQ(test, v_position, 0U);
+	KUNIT_EXPECT_EQ(test, h_position, 0U);
 }
 
 /**
@@ -1342,14 +1358,16 @@ static void dm_test_crtc_get_scanoutpos_exits_idle(struct kunit *test)
 {
 	struct amdgpu_device *adev = dm_kunit_alloc_adev(test);
 	struct dc *dc = dm_kunit_alloc_dc_with_ctx(test);
-	u32 vbl = 0;
-	u32 position = 0;
+	u32 v_blank_start = 0, v_blank_end = 0;
+	u32 v_position = 0, h_position = 0;
 
 	dm_test_crtc_with_stream(test, adev, dc);
 	dc->caps.ips_support = true;
 	dc->idle_optimizations_allowed = true;
 
-	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0, &vbl, &position), 0);
+	KUNIT_EXPECT_EQ(test, dm_crtc_get_scanoutpos(adev, 0,
+						     &v_blank_start, &v_blank_end,
+						     &v_position, &h_position), 0);
 }
 
 static struct drm_atomic_commit *dm_test_alloc_commit(struct kunit *test,
-- 
2.55.0

