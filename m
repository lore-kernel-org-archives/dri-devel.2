Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E592ECD342C
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:16:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1AD910EE6E;
	Wed,  6 May 2026 19:16:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="VULiGkCh";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B856E10EE6E;
 Wed,  6 May 2026 19:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jBlAInagGvAfBYq93PrL1rNt4zsLVWjnmmgb/dRZ1bw=; b=VULiGkCh0qQ1yFrcNSsYHIVP6q
 TYiwZbC1xVIi4XXWqmLCXRoqWDFRYvruK7nryOx6jRpzMAoABqv+vgsAUMusdt5jI554zcGvPcO3a
 56KKRxObwF/ilH8yBE4zOh3OazsthJa9YNtkV2DIUpuJkhRkyGTf+QFOOGDvlDRehu4grXGsoCuVz
 qwx2Tn9IM8N6f60QYZ8FbL4WNMYL+weYLInsQ+oCEmPCqBjkqItCVTSonz15NLI6y8YkezAX8ZGnA
 lHbYDD29TSw79m58biVqoFOL44UFOUc8xtKsnXQlxPVmVMws9N7l9gKGg2o27IVXCdT7hevGXxMki
 iMfQeQrA==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKhjc-0072Pg-D0; Wed, 06 May 2026 21:16:40 +0200
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
Subject: [PATCH v2 4/5] drm/amd/display: support up to 256 samples per region
 in degamma/blend LUT
Date: Wed,  6 May 2026 16:11:51 -0300
Message-ID: <20260506191606.15022-5-mwen@igalia.com>
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

cm3_helper_translate_curve_to_degamma_hw_format() reads one tf_pts entry
per HW LUT point, limiting the number of samples per region to
NUMBER_SW_SEGMENTS (16, at seg_distr[k] = 4) - higher seg_distr[k]
underflows the increment to 0. But the next patch introduces a halving
distribution for PQ/sRGB EOTFs that requires up to 128 samples in its
upper region (seg_distr[k] = 7).

As preparation, extend the loop index by 4 bits and linearly interpolate
adjacent tf_pts entries with the new interp_tf_pts() helper, where the 4
least significant bits are weight in 1/16 increments. This raises the
cap to 256 samples per region (seg_distr[k] = 8). seg_distr[k] <= 4
paths remain unchanged: the 4 least significant bits remain zero and
interp_tf_pts() reduces to a direct lookup.

Co-developed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 32 +++++++++++++++----
 1 file changed, 25 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 0949b1dffc63..70b7bc3494a2 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -305,6 +305,22 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 
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
@@ -348,18 +364,20 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 
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

