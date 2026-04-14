Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CFCAF9D0FB
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 22:03:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C0C810E0E1;
	Tue, 14 Apr 2026 22:03:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="CYPgFuXq";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CF78A10E0E1;
 Tue, 14 Apr 2026 22:03:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EqyUkYch0UQ/+YG1mWx1oNsAhcmteeJIGF6Y71R0Fk4=; b=CYPgFuXqIK09i3muXfr+SCPvbi
 vGpBdfs+80IOfy4bx9l90iP1mBpiqnEwTNBTq4HEUiWT0gluObrUSpQYBmwDIEJL7fKmnMl+q++1d
 /FrPQRP2SgRWm6fhTfPF/6mljej2l8ozUjGhbTR3/s+WqOQ6utAkgDMt7lVDOExUHWkDrUncKb7N+
 amybldvAk17lg12Sth4PHNPcuZ5Y/ifOh5+sNVJSWJ4PXADeISpTlrrQF5lvj/q8R1xp+3kcQZfmA
 TvMoolc8pXAHZ/mIyJ+L0N1H8OMS3xPx/mqAFB2DuUDWjGSGh8eDkr/WYErRRzVQAUcHtnypcLapU
 wp/CzN9A==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wClqd-00G60j-FC; Wed, 15 Apr 2026 00:03:08 +0200
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
Subject: [PATCH 3/4] drm/amd/display: support up to 256 samples per region
Date: Tue, 14 Apr 2026 18:55:02 -0300
Message-ID: <20260414220237.184289-4-mwen@igalia.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260414220237.184289-1-mwen@igalia.com>
References: <20260414220237.184289-1-mwen@igalia.com>
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

Next commit makes degamma PQ and SRGB EOTF halving distribute points per
region which fits better the perceptually uniform shape of inputs, with
9 regions, and a region needs up to 128 samples from TF points (from 2^0
to 2^7). As a preparation, enable up to 256 samples per region (instead
of 16). Create a function to linearly interpolate between neighboring TF
points for readability.

Co-developed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 32 +++++++++++++++----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index a439bb6c5e56..b5cb2cd312ba 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -303,6 +303,22 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 
 #define NUM_DEGAMMA_REGIONS    12
 
+/* Linear interpolation of tf_pts entries, where (i >> 4) is the integer tf_pts
+ * index, (i & 0xf) is the 1/16 sub-position.
+ */
+static struct fixed31_32 interp_tf_pts(const struct fixed31_32 *output_tf_channel, int i)
+{
+	struct fixed31_32 in_plus_one, in, value;
+	uint32_t t = i & 0xf;
+
+	in_plus_one = output_tf_channel[(i >> 4) + 1];
+	in = output_tf_channel[i >> 4];
+	value = dc_fixpt_sub(in_plus_one, in);
+	value = dc_fixpt_shr(dc_fixpt_mul_int(value, t), 4);
+	value = dc_fixpt_add(in, value);
+
+	return value;
+}
 
 bool cm3_helper_translate_curve_to_degamma_hw_format(
 				const struct dc_transfer_func *output_tf,
@@ -346,18 +362,20 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 
 	j = 0;
 	for (k = 0; k < (region_end - region_start); k++) {
-		increment = NUMBER_SW_SEGMENTS / (1 << seg_distr[k]);
+		increment = (NUMBER_SW_SEGMENTS << 4) / (1 << seg_distr[k]);
 		start_index = (region_start + k + MAX_LOW_POINT) *
 				NUMBER_SW_SEGMENTS;
-		for (i = start_index; i < start_index + NUMBER_SW_SEGMENTS;
-				i += increment) {
+		for (i = (start_index << 4);
+		     i < (start_index << 4) + (NUMBER_SW_SEGMENTS << 4);
+		     i += increment) {
 			if (j == hw_points - 1)
 				break;
-			if (i >= TRANSFER_FUNC_POINTS)
+			if ((i >> 4) + 1 >= TRANSFER_FUNC_POINTS)
 				return false;
-			rgb_resulted[j].red = output_tf->tf_pts.red[i];
-			rgb_resulted[j].green = output_tf->tf_pts.green[i];
-			rgb_resulted[j].blue = output_tf->tf_pts.blue[i];
+
+			rgb_resulted[j].red = interp_tf_pts(output_tf->tf_pts.red, i);
+			rgb_resulted[j].green = interp_tf_pts(output_tf->tf_pts.green, i);
+			rgb_resulted[j].blue = interp_tf_pts(output_tf->tf_pts.blue, i);
 			j++;
 		}
 	}
-- 
2.53.0

