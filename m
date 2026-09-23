Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 707ACC98309
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:27:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFC5910E88F;
	Wed, 23 Sep 2026 10:27:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=airkyi.com header.i=@airkyi.com header.b="X8gWwXOn";
	dkim-atps=neutral
Received: from bg5.exmail.qq.com (bg5.exmail.qq.com [43.154.209.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5816D10EFA3
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:27:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
 s=altu2504; t=1790159199;
 bh=XbULw6ULJcXEN7r4HzVKK0xQN1onNLhHJdUNgVvLQ2I=;
 h=From:To:Subject:Date:Message-Id;
 b=X8gWwXOnt0SQ3QQ0c5Ga5ykT4dSi9wuLYGSN6vf0X3OnO1Errblkk+aL9jgBfJ3rq
 WoSxeKYbvqhqncw80Wdd9MeINcJEsZ81fbBMqwTaGKvCsDvBqb8VgZueMZQiYH5cAm
 XBs+fhd+LwUjtt3BnMqJxbCCJDfyaB7VB135DYdk=
X-QQ-mid: zesmtpgz3t1790159191te5b87cc4
X-QQ-Originating-IP: WUrZ5XmnOzoxgdtPF6VWy10ah40RwA+e8WcsItuKrhQ=
Received: from DESKTOP-8BT1A2O.localdomain ( [61.154.14.86])
 by bizesmtp.qq.com (ESMTP) with 
 id ; Wed, 23 Sep 2026 18:26:29 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14866682389088076304
EX-QQ-RecipientCnt: 10
From: Chaoyi Chen <kernel@airkyi.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Dmitry Baryshkov <lumag@kernel.org>
Cc: Chaoyi Chen <chaoyi.chen@rock-chips.com>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Chaoyi Chen <kernel@airkyi.com>
Subject: [PATCH] drm/display/dsc: Add YCbCr 4:2:2 and 4:2:0 computation for
 DSC 1.2 RC parameters
Date: Wed, 23 Sep 2026 18:26:16 +0800
Message-Id: <20260923102616.215-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.17.1
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:airkyi.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: MX+1SEN3H+wAZ6YLcAduUSOcyRfX2CiPwqZuU1xrNgWlKgAjb/nWgmR3
 0w4kaTI2V9W9UZ84NlGyhrsSqkGborapcGHltw6MLU3bLXiSILhqrdvk46lce3wx4/7opmP
 kEM+bKpro8UU4jok5Bm/H80HsmztX3KWIt6hcFNymNWpI2HjgPT9DUHPF40GazIULCZUd0s
 0Gdmr1eAtE/waGMuVeJeBW4Enrw0FyiBe+IP3HjsRLJO9rlYe/1TCK1ynvPlPO0nOpgYPeS
 96yTL7TVpdjyWF04R/eLO29f86hW9esui9plPMCBSfR/ff1quZgDofQa/kEirEXA3P+iIg3
 94L/OCJk+AKgUOdvkifZ5xwFIRhch2c9DRCqn4D+gjekCZCwKx0S5286YcfT9C2k765kDOX
 kOqkBCQVInK3LsSzo8hv13PxAd4TTmM/br91+SfDkTPYzjuLc+v8l+AswFVxsQQGRtYzhd5
 KduY0uY/5/AdgSF408DrxjSWV6/mvm4qvjTPY72I/4+QA+MHaa5khAVZ+UyAQoeoNIb4xE1
 HRnP9gLvc6DLieKUpw6LfjZFTzvsuzTg9mZzrreacnWVf6pHw8Yz+1tK+q5Xm9mhyvgqNgW
 aKWkA0ZPQBGIZUkiDKOze7VbFDLsTetHXqHFoIYJn4jA949Tmkln8IS4hivX/qwz2E22VC/
 KgaplhNg2OmPbwyK0MmYBP1Rj5ijDV7/1KejHw96tZKjZF7oiYKK2Jf3ScdfPu2I7VBvPlc
 OPxbL1xSq20JwAKRlhh+wzAjK7yWBKVDRJJGwQiL1AcDBwBe/SxTQoOBsMhjzwdxjWpvDNK
 hFtSDTyzK+mw552W17Yhq1EoTLKlnc2oXXlJ3TzK77gSokII6wMvJJ+21ksQhT+pkHIjrl3
 VSI2pym7rf2jQfzBsfD2k1Foup0HcTyVD9aBaSIhOB2swoDgJKUdxBoiLZ1nDbA0DgK7YcE
 DBbyITccR3jo/77S5HlGpdYXyhcowzd5GnHxqBkcX8jY+UPJBWDV0145jdmeO1Ye+dvs=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0
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

drm_dsc_compute_rc_parameters() still derives the rate control
parameters that depend on native 4:2:0/4:2:2 operation using the
DSC 1.1 model.

Bring the helper in line with the latest DSC 1.2 reference
implementation (C model 20211213, version 1.67):
- Compute second_line_bpg_offset, second_line_offset_adj and
nsl_bpg_offset for native 4:2:0.
- Compute rbsMin for DSC 1.2 native 4:2:0/4:2:2 using the optimized
method of the C model.

Signed-off-by: Chaoyi Chen <kernel@airkyi.com>
---
 drivers/gpu/drm/display/drm_dsc_helper.c | 114 ++++++++++++++++++++++-
 1 file changed, 109 insertions(+), 5 deletions(-)
 mode change 100644 => 100755 drivers/gpu/drm/display/drm_dsc_helper.c

diff --git a/drivers/gpu/drm/display/drm_dsc_helper.c b/drivers/gpu/drm/display/drm_dsc_helper.c
index 05996c526a8a..90b088335997
--- a/drivers/gpu/drm/display/drm_dsc_helper.c
+++ b/drivers/gpu/drm/display/drm_dsc_helper.c
@@ -1300,6 +1300,59 @@ int drm_dsc_setup_rc_params(struct drm_dsc_config *vdsc_cfg, enum drm_dsc_params
 }
 EXPORT_SYMBOL(drm_dsc_setup_rc_params);

+/**
+ * __drm_dsc_compute_buffer_offset - Compute the rate buffer offset at a given
+ * group position within a slice, following the method of the DSC 1.2 C model.
+ *
+ * @vdsc_cfg: DSC Configuration data partially filled by driver
+ * @groups_per_line: number of groups used to code each line of a slice
+ * @grpcnt: group position to compute the offset for
+ *
+ * Return: the offset value for the group @grpcnt.
+ */
+static long
+__drm_dsc_compute_buffer_offset(const struct drm_dsc_config *vdsc_cfg,
+				unsigned long groups_per_line,
+				unsigned long grpcnt)
+{
+	unsigned long grpcnt_id = DIV_ROUND_UP(vdsc_cfg->initial_xmit_delay,
+					       DSC_RC_PIXELS_PER_GROUP);
+	long offset;
+
+	if (grpcnt <= grpcnt_id)
+		offset = DIV_ROUND_UP(grpcnt * DSC_RC_PIXELS_PER_GROUP *
+				      vdsc_cfg->bits_per_pixel, 16);
+	else
+		offset = DIV_ROUND_UP(grpcnt_id * DSC_RC_PIXELS_PER_GROUP *
+				      vdsc_cfg->bits_per_pixel, 16) -
+			 (((grpcnt - grpcnt_id) *
+			   vdsc_cfg->slice_bpg_offset) >> 11);
+
+	if (grpcnt <= groups_per_line)
+		offset += grpcnt * vdsc_cfg->first_line_bpg_offset;
+	else
+		offset += groups_per_line * vdsc_cfg->first_line_bpg_offset -
+			 (((grpcnt - groups_per_line) *
+			   vdsc_cfg->nfl_bpg_offset) >> 11);
+
+	if (vdsc_cfg->native_420) {
+		if (grpcnt <= groups_per_line)
+			offset -= (grpcnt * vdsc_cfg->nsl_bpg_offset) >> 11;
+		else if (grpcnt <= 2 * groups_per_line)
+			offset += (grpcnt - groups_per_line) *
+				   vdsc_cfg->second_line_bpg_offset -
+				 ((groups_per_line *
+				   vdsc_cfg->nsl_bpg_offset) >> 11);
+		else
+			offset += (grpcnt - groups_per_line) *
+				   vdsc_cfg->second_line_bpg_offset -
+				 (((grpcnt - groups_per_line) *
+				   vdsc_cfg->nsl_bpg_offset) >> 11);
+	}
+
+	return offset;
+}
+
 /**
  * drm_dsc_compute_rc_parameters() - Write rate control
  * parameters to the dsc configuration defined in
@@ -1391,6 +1444,36 @@ int drm_dsc_compute_rc_parameters(struct drm_dsc_config *vdsc_cfg)
 	else
 		vdsc_cfg->nfl_bpg_offset = 0;

+	/*
+	 * According to DSC 1.2 spec in Section 4.1 if native_420 is set:
+	 * -second_line_bpg_offset is 12 in general and equal to 2*(slice_height-1) if slice
+	 * height < 8.
+	 * -second_line_offset_adj is 512 as shown by emperical values to yield best chroma
+	 * preservation in second line.
+	 * -nsl_bpg_offset is calculated as second_line_offset/slice_height -1 then rounded
+	 * up to 16 fractional bits, we left shift second line offset by 11 to preserve 11
+	 * fractional bits.
+	 */
+	if (vdsc_cfg->native_420) {
+		if (vdsc_cfg->slice_height >= 8)
+			vdsc_cfg->second_line_bpg_offset = 12;
+		else
+			vdsc_cfg->second_line_bpg_offset =
+				2 * (vdsc_cfg->slice_height - 1);
+
+		vdsc_cfg->second_line_offset_adj = 512;
+	} else {
+		vdsc_cfg->second_line_bpg_offset = 0;
+		vdsc_cfg->second_line_offset_adj = 0;
+	}
+
+	if (vdsc_cfg->native_420 && vdsc_cfg->slice_height > 2)
+		vdsc_cfg->nsl_bpg_offset =
+			DIV_ROUND_UP(vdsc_cfg->second_line_bpg_offset << 11,
+				     (vdsc_cfg->slice_height - 1));
+	else
+		vdsc_cfg->nsl_bpg_offset = 0;
+
 	/* Number of groups used to code the entire slice */
 	groups_total = groups_per_line * vdsc_cfg->slice_height;

@@ -1410,7 +1493,9 @@ int drm_dsc_compute_rc_parameters(struct drm_dsc_config *vdsc_cfg)
 		vdsc_cfg->scale_increment_interval =
 				(vdsc_cfg->final_offset * (1 << 11)) /
 				((vdsc_cfg->nfl_bpg_offset +
-				vdsc_cfg->slice_bpg_offset) *
+				vdsc_cfg->slice_bpg_offset +
+				(vdsc_cfg->native_420 ?
+				 vdsc_cfg->nsl_bpg_offset : 0)) *
 				(final_scale - 9));
 	} else {
 		/*
@@ -1425,10 +1510,29 @@ int drm_dsc_compute_rc_parameters(struct drm_dsc_config *vdsc_cfg)
 	 * bits/pixel (bpp) rate that is used by the encoder,
 	 * in steps of 1/16 of a bit per pixel
 	 */
-	rbs_min = vdsc_cfg->rc_model_size - vdsc_cfg->initial_offset +
-		DIV_ROUND_UP(vdsc_cfg->initial_xmit_delay *
-			     vdsc_cfg->bits_per_pixel, 16) +
-		groups_per_line * vdsc_cfg->first_line_bpg_offset;
+	if (vdsc_cfg->dsc_version_minor == 2 &&
+	    (vdsc_cfg->native_420 || vdsc_cfg->native_422)) {
+		/* Optimized computation of rbsMin for DSC 1.2 */
+		unsigned long grpcnt_id =
+			DIV_ROUND_UP(vdsc_cfg->initial_xmit_delay,
+				     DSC_RC_PIXELS_PER_GROUP);
+		long max_offset;
+
+		max_offset = __drm_dsc_compute_buffer_offset(vdsc_cfg, groups_per_line, grpcnt_id);
+		max_offset = max(max_offset,
+				 __drm_dsc_compute_buffer_offset(vdsc_cfg, groups_per_line,
+								 groups_per_line));
+		max_offset = max(max_offset,
+				 __drm_dsc_compute_buffer_offset(vdsc_cfg, groups_per_line,
+								 2 * groups_per_line));
+
+		rbs_min = vdsc_cfg->rc_model_size - vdsc_cfg->initial_offset + max_offset;
+	} else {
+		rbs_min = vdsc_cfg->rc_model_size - vdsc_cfg->initial_offset +
+			DIV_ROUND_UP(vdsc_cfg->initial_xmit_delay *
+				     vdsc_cfg->bits_per_pixel, 16) +
+			groups_per_line * vdsc_cfg->first_line_bpg_offset;
+	}

 	hrd_delay = DIV_ROUND_UP((rbs_min * 16), vdsc_cfg->bits_per_pixel);
 	vdsc_cfg->rc_bits = (hrd_delay * vdsc_cfg->bits_per_pixel) / 16;
--
2.53.0

