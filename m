Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 936CBCD343B
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 19:16:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FEF310EE6D;
	Wed,  6 May 2026 19:16:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="MQd1Iajb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BFD410EE6D;
 Wed,  6 May 2026 19:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tZ3JzJ5JQU2GBZv6lygmD9K4XBQVXEkAzYW7c7jd/Cc=; b=MQd1IajbpBzGmXxfqVmnWgOS8H
 kXhwgGMEKW3mdY/1R3fQWaDITqE1vLyoL0H5n6mNfP32PZ69EFBtFimApz6mhy29FXyYoIcDg8gJQ
 3wCl7HJVmyFO1/FGew9SEUpgfphi+fkDa3fkUFpBt0si3Mu9thfTch810FpcqvPtrx9UlbcQ6Ldv1
 le8RzSAX3On0i9W/zMvy16dY+Lg+LxcWienwbRAeH0AR1aMYJG/ITP2B7Q4j0/eDmsdom87YBrB9x
 l79AAXCtf8jsrs6VnsFlD4BLIRc9H38lRiGZeG9uFzePc7MbehLNu7bVSDQ1ilyb9vevaJhoNS6M0
 gcm+OCLQ==;
Received: from [186.208.73.228] (helo=killbill.home)
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wKhjg-0072Pg-Qd; Wed, 06 May 2026 21:16:44 +0200
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
Subject: [PATCH v2 5/5] drm/amd/display: use halving distribution for PQ/sRGB
 linearizing LUT
Date: Wed,  6 May 2026 16:11:52 -0300
Message-ID: <20260506191606.15022-6-mwen@igalia.com>
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

When linearizing, the input is an encoded signal bounded to [0,1] and
PQ/sRGB EOTFs are steepest near 1, requiring more precision near the
bright end.

Take the 8-bit sRGB case as a reference: 256 possible inputs and 256 HW
LUT points line up, so the LUT acts as plain indexing. Float
representations don't land perfectly, but LERP-ing between two HW
entries, when input is within a small epsilon of one of them, doesn't
materially change the result.

Replace the uniform 12-region distribution (16 points each,
192 total, range [2^-12, 1]) with a 9-region halving distribution for
the PQ/sRGB pre-defined EOTF: 128 points in the top region [0.5, 1], 64
in the next, 32 in the next, and so on, down to 1 point in each of the
two darkest regions. Total samples grow from 192 to 256, with uniform
1/256 spacing across [0, 1]. The dark tail below 2^-9 is no longer
sampled separately, which is acceptable for PQ/sRGB.

Suggested-by: Krunoslav Kovac <Krunoslav.Kovac@amd.com>
Signed-off-by: Melissa Wen <mwen@igalia.com>
---
 .../amd/display/dc/dcn30/dcn30_cm_common.c    | 33 ++++++++++++++-----
 1 file changed, 24 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
index 70b7bc3494a2..66fe7f313ea3 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn30/dcn30_cm_common.c
@@ -303,8 +303,6 @@ bool cm3_helper_translate_curve_to_hw_format(struct dc_context *ctx,
 	return true;
 }
 
-#define NUM_DEGAMMA_REGIONS    12
-
 /* Linear interpolation of tf_pts entries, where (i >> 4) is the integer tf_pts
  * index, (i & 0xf) is the 1/16 sub-position.
  */
@@ -345,17 +343,34 @@ bool cm3_helper_translate_curve_to_degamma_hw_format(
 	memset(lut_params, 0, sizeof(struct pwl_params));
 	memset(seg_distr, 0, sizeof(seg_distr));
 
-	region_start = -NUM_DEGAMMA_REGIONS;
-	region_end   = 0;
+	if (output_tf->tf == TRANSFER_FUNCTION_PQ ||
+	    output_tf->tf == TRANSFER_FUNCTION_SRGB) {
+		/* 9 segments
+		 * segments are from 2^-9 to 0
+		 */
+		const uint8_t SEG_COUNT = 9;
+		seg_distr[0] = 0; // Since we only have one point in darkest region
+		for (k = 1; k < SEG_COUNT; k++)
+			seg_distr[k] = k - 1; // 2^(k-1) points per region; halves as k decreases
 
+		region_start = -SEG_COUNT;
+		region_end = 0;
+	} else {
+		/* 12 segments
+		 * segments are from 2^-12 to 2^0
+		 * There are less than 256 points, for optimization
+		 */
+		const uint8_t SEG_COUNT = 12;
+
+		for (i = 0; i < SEG_COUNT; i++)
+			seg_distr[i] = 4;
+
+		region_start = -SEG_COUNT;
+		region_end = 0;
+	}
 
 	for (i = region_end - region_start; i < MAX_REGIONS_NUMBER ; i++)
 		seg_distr[i] = -1;
-	/* 12 segments
-	 * segments are from 2^-12 to 0
-	 */
-	for (i = 0; i < NUM_DEGAMMA_REGIONS ; i++)
-		seg_distr[i] = 4;
 
 	for (k = 0; k < MAX_REGIONS_NUMBER; k++) {
 		if (seg_distr[k] != -1)
-- 
2.53.0

