Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D189BCD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1FBC210EE4E;
	Wed,  6 May 2026 19:16:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="hW5tR9oc";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BC4110E580;
 Wed,  6 May 2026 19:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HBKEFBHmojXkLnI2TZC0lWtoHlqsvj8ydgbv54vzc0o=; b=hW5tR9ocYolDU+GnIRdbf39qO2
 pzcLgk6dZ0YI7WLcSUQcsqV+W89kZvvIQ3R+L/CoHll0Sz9q0QV8dHJkBsp1BCbrnOlc+pZfMX4Hq
 vVXhLmGzolJpbt1Flh5aaP9AcidIzzuJg2EOCqP0p8TTsk4SsqUSRHZIZPFYEH3Ua3q8x05PD+31/
 Vtz78KQsk8+I+vkZFlGebN+erykGDyaTwgHkWLY/sxX5GJSuw1uOZqjmQdkFQcj2oRQNoNhz/eGbV
 I76WzoCVkUAlhI65MH814sNOzMgR3P5ICWIvQdUA7W34eqDeEWnQXRWVQ5BsmowK63galGcJf2SEu
 pMARIezw==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKhjT-0072Pg-3I; Wed, 06 May 2026 21:16:30 +0200
From: Melissa Wen <mwen@igalia.com>
To: airlied@gmail.com, alexander.deucher@amd.com, christian.koenig@amd.com,
 harry.wentland@amd.com, simona@ffwll.ch, siqueira@igalia.com,
 sunpeng.li@amd.com
Cc: Krunoslav Kovac <Krunoslav.Kovac@amd.com>,
 "Dr . David Alan Gilbert" <linux@treblig.org>,
 Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
 Alex Hung <alex.hung@amd.com>, Aurabindo Pillai <Aurabindo.Pillai@amd.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 pekka.paalanen@collabora.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, kernel-dev@igalia.com
Subject: [PATCH v2 2/5] Revert "drm/amd/display: Remove unused
 cm3_helper_translate_curve_to_degamma_hw_format"
Date: Wed,  6 May 2026 16:11:49 -0300
Message-ID: <20260506191606.15022-3-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506191606.15022-1-mwen@igalia.com>
References: <20260506191606.15022-1-mwen@igalia.com>
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

This reverts commit 8b89acc0b2baecfe331f5336e7ff1fcc5a44b062.

So that we can detach NL->L LUT programming from L->NL one, i.e., we can
use cm3_helper_translate_curve_to_degamma_hw_format for plane degamma and
blend (post-3DLUT curve) and cm3_helper_translate_curve_to_hw_format for
plane shaper (pre-3DLUT curve) and stream regamma.

Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 151 ++++++++++++++++++
 .../display/dc/dwb/dcn30/dcn30_cm_common.h    |   4 +
 2 files changed, 155 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index bfd5515c2f4f..0949b1dffc63 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -303,6 +303,157 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	return true;
 }
 
+#define NUM_DEGAMMA_REGIONS    12
+
+
+bool cm3_helper_translate_curve_to_degamma_hw_format(
+				const struct dc_transfer_func *output_tf,
+				struct pwl_params *lut_params)
+{
+	struct curve_points3 *corner_points;
+	struct pwl_result_data *rgb_resulted;
+	struct pwl_result_data *rgb;
+	struct pwl_result_data *rgb_plus_1;
+
+	int32_t region_start, region_end;
+	int32_t i;
+	uint32_t j, k, seg_distr[MAX_REGIONS_NUMBER], increment, start_index, hw_points;
+
+	if (output_tf == NULL || lut_params == NULL || output_tf->type == TF_TYPE_BYPASS)
+		return false;
+
+	corner_points = lut_params->corner_points;
+	rgb_resulted = lut_params->rgb_resulted;
+	hw_points = 0;
+
+	memset(lut_params, 0, sizeof(struct pwl_params));
+	memset(seg_distr, 0, sizeof(seg_distr));
+
+	region_start = -NUM_DEGAMMA_REGIONS;
+	region_end   = 0;
+
+
+	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
+		seg_distr[i] = -1;
+	/* 12 segments
+	 * segments are from 2^-12 to 0
+	 */
+	for (i = 0; i < NUM_DEGAMMA_REGIONS ; i++)
+		seg_distr[i] = 4;
+
+	for (k = 0; k < MAX_REGIONS_NUMBER; k++) {
+		if (seg_distr[k] != -1)
+			hw_points += (1 << seg_distr[k]);
+	}
+
+	j = 0;
+	for (k = 0; k < (region_end - region_start); k++) {
+		increment = NUMBER_SW_SEGMENTS / (1 << seg_distr[k]);
+		start_index = (region_start + k + MAX_LOW_POINT) *
+				NUMBER_SW_SEGMENTS;
+		for (i = start_index; i < start_index + NUMBER_SW_SEGMENTS;
+				i += increment) {
+			if (j == hw_points - 1)
+				break;
+			if (i >= TRANSFER_FUNC_POINTS)
+				return false;
+			rgb_resulted[j].red = output_tf->tf_pts.red[i];
+			rgb_resulted[j].green = output_tf->tf_pts.green[i];
+			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
+			j++;
+		}
+	}
+
+	/* last point */
+	start_index = (region_end + MAX_LOW_POINT) * NUMBER_SW_SEGMENTS;
+	rgb_resulted[hw_points - 1].red = output_tf->tf_pts.red[start_index];
+	rgb_resulted[hw_points - 1].green = output_tf->tf_pts.green[start_index];
+	rgb_resulted[hw_points - 1].blue = output_tf->tf_pts.blue[start_index];
+
+	corner_points[0].red.x = dc_fixpt_pow(dc_fixpt_from_int(2),
+					     dc_fixpt_from_int(region_start));
+	corner_points[0].green.x = corner_points[0].red.x;
+	corner_points[0].blue.x = corner_points[0].red.x;
+	corner_points[1].red.x = dc_fixpt_pow(dc_fixpt_from_int(2),
+					     dc_fixpt_from_int(region_end));
+	corner_points[1].green.x = corner_points[1].red.x;
+	corner_points[1].blue.x = corner_points[1].red.x;
+
+	corner_points[0].red.y = rgb_resulted[0].red;
+	corner_points[0].green.y = rgb_resulted[0].green;
+	corner_points[0].blue.y = rgb_resulted[0].blue;
+
+	/* see comment above, m_arrPoints[1].y should be the Y value for the
+	 * region end (m_numOfHwPoints), not last HW point(m_numOfHwPoints - 1)
+	 */
+	corner_points[1].red.y = rgb_resulted[hw_points - 1].red;
+	corner_points[1].green.y = rgb_resulted[hw_points - 1].green;
+	corner_points[1].blue.y = rgb_resulted[hw_points - 1].blue;
+	corner_points[1].red.slope = dc_fixpt_zero;
+	corner_points[1].green.slope = dc_fixpt_zero;
+	corner_points[1].blue.slope = dc_fixpt_zero;
+
+	if (output_tf->tf == TRANSFER_FUNCTION_PQ) {
+		/* for PQ, we want to have a straight line from last HW X point,
+		 * and the slope to be such that we hit 1.0 at 10000 nits.
+		 */
+		const struct fixed31_32 end_value =
+				dc_fixpt_from_int(125);
+
+		corner_points[1].red.slope = dc_fixpt_div(
+			dc_fixpt_sub(dc_fixpt_one, corner_points[1].red.y),
+			dc_fixpt_sub(end_value, corner_points[1].red.x));
+		corner_points[1].green.slope = dc_fixpt_div(
+			dc_fixpt_sub(dc_fixpt_one, corner_points[1].green.y),
+			dc_fixpt_sub(end_value, corner_points[1].green.x));
+		corner_points[1].blue.slope = dc_fixpt_div(
+			dc_fixpt_sub(dc_fixpt_one, corner_points[1].blue.y),
+			dc_fixpt_sub(end_value, corner_points[1].blue.x));
+	}
+
+	lut_params->hw_points_num = hw_points;
+
+	k = 0;
+	for (i = 1; i < MAX_REGIONS_NUMBER; i++) {
+		if (seg_distr[k] != -1) {
+			lut_params->arr_curve_points[k].segments_num =
+					seg_distr[k];
+			lut_params->arr_curve_points[i].offset =
+					lut_params->arr_curve_points[k].offset + (1 << seg_distr[k]);
+		}
+		k++;
+	}
+
+	if (seg_distr[k] != -1)
+		lut_params->arr_curve_points[k].segments_num = seg_distr[k];
+
+	rgb = rgb_resulted;
+	rgb_plus_1 = rgb_resulted + 1;
+
+	i = 1;
+	while (i != hw_points + 1) {
+		if (dc_fixpt_lt(rgb_plus_1->red, rgb->red))
+			rgb_plus_1->red = rgb->red;
+		if (dc_fixpt_lt(rgb_plus_1->green, rgb->green))
+			rgb_plus_1->green = rgb->green;
+		if (dc_fixpt_lt(rgb_plus_1->blue, rgb->blue))
+			rgb_plus_1->blue = rgb->blue;
+
+		rgb->delta_red   = dc_fixpt_sub(rgb_plus_1->red,   rgb->red);
+		rgb->delta_green = dc_fixpt_sub(rgb_plus_1->green, rgb->green);
+		rgb->delta_blue  = dc_fixpt_sub(rgb_plus_1->blue,  rgb->blue);
+
+		++rgb_plus_1;
+		++rgb;
+		++i;
+	}
+	cm3_helper_convert_to_custom_float(rgb_resulted,
+						lut_params->corner_points,
+						hw_points, false);
+
+	return true;
+}
+
 bool cm3_helper_convert_to_custom_float(
 		struct pwl_result_data *rgb_resulted,
 		struct curve_points3 *corner_points,
diff --git a/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h
index 95f9318a54ef..c23dc1bb29bf 100644
--- a/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h
+++ b/drivers/gpu/drm/amd/display/dc/dwb/dcn30/dcn30_cm_common.h
@@ -63,6 +63,10 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	const struct dc_transfer_func *output_tf,
 	struct pwl_params *lut_params, bool fixpoint);
 
+bool cm3_helper_translate_curve_to_degamma_hw_format(
+				const struct dc_transfer_func *output_tf,
+				struct pwl_params *lut_params);
+
 bool cm3_helper_convert_to_custom_float(
 		struct pwl_result_data *rgb_resulted,
 		struct curve_points3 *corner_points,
-- 
2.53.0

