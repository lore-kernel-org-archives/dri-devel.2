Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECFCBCD4F58
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AA7A10EAA5;
	Tue, 19 May 2026 07:13:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=disroot.org header.i=@disroot.org header.b="OKe4E2pV";
	dkim-atps=neutral
X-Greylist: delayed 523 seconds by postgrey-1.36 at gabe;
 Tue, 19 May 2026 03:16:04 UTC
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 24BD110EA34;
 Tue, 19 May 2026 03:16:04 +0000 (UTC)
Received: from mail01.disroot.lan (localhost [127.0.0.1])
 by disroot.org (Postfix) with ESMTP id AE478276BE;
 Tue, 19 May 2026 05:07:49 +0200 (CEST)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id cyM_6Bqaj2tO; Tue, 19 May 2026 05:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
 t=1779160068; bh=l1Lwu2wAfeB+q1/AjeKi7nRw2gGLCVwN+HXESaGK9F4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=OKe4E2pV0setWCwlGizluv+AFL/0GbO8yPJb/f+BHC0Ljx4HLC1fEHh8oi2yfAkJM
 fXq+J84ArGspMhdBJn9pztVRVuFRT3PFikpptQBwwPAas4w10RbAvN8C3AmfIJSUXb
 uCN2AKqkz6krmMJ2WxRCIRnN5n+tcIAq1YsYk4wV8nQX6jIuCRnzfw+cutOGQTEXzF
 SQXd3lsCC/TvABcnW3ghXsxaI+ccTorJXFJ98hM030OPlY0hNnxA6FYkUF+PPaTlWL
 wY465H+OPMQ8gZKywx7Xomkl3hdmwy/e7gveMevCZDzk4kHC3EL2lFvE3BVRnKlYmA
 8Lyis58mxZRBw==
From: Leorize <leorize+oss@disroot.org>
To: linux-kernel@vger.kernel.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Rodrigo Siqueira <siqueira@igalia.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 Leorize <leorize+oss@disroot.org>
Subject: [PATCH 1/1] drm/amd/display: set MSA MISC1 bit 6 when using VSC SDP
 for DCE 11.x
Date: Mon, 18 May 2026 20:06:19 -0700
Message-ID: <20260519030624.51613-2-leorize+oss@disroot.org>
In-Reply-To: <20260519030624.51613-1-leorize+oss@disroot.org>
References: <20260519030624.51613-1-leorize+oss@disroot.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

When BT.2020 colorimetry is selected, the driver sends information using
VSC SDP but does not set "ignore MSA colorimetry" bit on older GPUs with
DCE-based IPs. This causes certain sinks to prefer colorimetry
information in DP MSA, resulting in terrible color rendering ("dull"
colors) when HDR is enabled.

This commit wires up the MISC1 bit 6 for GPUs with DCE 11.x based IPs to
correctly configure sinks to ignore colorimetry information in MSA,
resolving the color rendering issue.

Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/4849
Assisted-by: oh-my-pi:GPT-5.5
Signed-off-by: Leorize <leorize+oss@disroot.org>
---
 .../drm/amd/display/dc/dce/dce_stream_encoder.c   | 15 ++++++++++++++-
 .../drm/amd/display/dc/dce/dce_stream_encoder.h   |  3 ++-
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
index ed407e779c12..2c3a20d35fe9 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.c
@@ -271,7 +271,6 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	bool use_vsc_sdp_for_colorimetry,
 	uint32_t enable_sdp_splitting)
 {
-	(void)use_vsc_sdp_for_colorimetry;
 	(void)enable_sdp_splitting;
 	uint32_t h_active_start;
 	uint32_t v_active_start;
@@ -334,6 +333,16 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 	if (REG(DP_MSA_MISC))
 		misc1 = REG_READ(DP_MSA_MISC);
 
+	/* For YCbCr420 and BT2020 Colorimetry Formats, VSC SDP shall be used.
+	 * When MISC1, bit 6, is Set to 1, a Source device uses a VSC SDP to indicate the
+	 * Pixel Encoding/Colorimetry Format and that a Sink device shall ignore MISC1, bit 7,
+	 * and MISC0, bits 7:1 (MISC1, bit 7, and MISC0, bits 7:1, become "don't care").
+	 */
+	if (use_vsc_sdp_for_colorimetry)
+		misc1 = misc1 | 0x40;
+	else
+		misc1 = misc1 & ~0x40;
+
 	/* set color depth */
 
 	switch (hw_crtc_timing.display_color_depth) {
@@ -499,6 +508,10 @@ static void dce110_stream_encoder_dp_set_stream_attribute(
 				hw_crtc_timing.h_addressable + hw_crtc_timing.h_border_right,
 				DP_MSA_VHEIGHT, hw_crtc_timing.v_border_top +
 				hw_crtc_timing.v_addressable + hw_crtc_timing.v_border_bottom);
+	} else {
+		/* DCE-only path */
+		if (REG(DP_MSA_MISC))
+			REG_WRITE(DP_MSA_MISC, misc1);   /* MSA_MISC1 */
 	}
 }
 
diff --git a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
index 342c0afe6a94..88d6044904d1 100644
--- a/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
+++ b/drivers/gpu/drm/amd/display/dc/dce/dce_stream_encoder.h
@@ -96,7 +96,8 @@
 
 #define SE_COMMON_REG_LIST(id)\
 	SE_COMMON_REG_LIST_DCE_BASE(id), \
-	SRI(AFMT_CNTL, DIG, id)
+	SRI(AFMT_CNTL, DIG, id), \
+	SRI(DP_MSA_MISC, DP, id)
 
 #define SE_DCN_REG_LIST(id)\
 	SE_COMMON_REG_LIST_BASE(id),\
-- 
2.54.0

