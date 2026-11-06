Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FA04606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YjtAj/3l
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9106F10EC1E;
	Fri,  6 Nov 2026 13:16:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C7310EC1E
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:16:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF184601E3;
 Fri,  6 Nov 2026 13:16:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AB841F008A1;
 Fri,  6 Nov 2026 13:16:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793971001;
 bh=UeBPJJvLwdFRSRUfSHQcpFgUM3+Ba8C/KQurmFxemIY=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=YjtAj/3l0QqaBM0BE8BUlic4rcSV6BU6n/Tr42P15CFUm+/n4G97p+ZF9hhs0psCF
 1y4Yx6xJVegpmAjXbVnVMXFu3O2wd9rYpYdclssshZpluDxIEorrdSt/85AX0BALTZ
 Xp/we2+3mCy9ygWJGPbnSZSbdQ9vzSRubWdO5P59ppPad16ZwBj0UN0ZiQ2/aQuiNy
 O9f9zrMKDaYICKRewKpcP217Gvag7yoKf9qIbPAMcUS2v8HICS3Gnugtspey0v7djy
 r4b5H4cCFzB2rBsfWMY34d7VhheeSpZij58XudltStRUBKbCDm43Be9Vl5tdH/OeJb
 QENjuRUYDOnRw==
From: Maxime Ripard <mripard@kernel.org>
Date: Fri, 06 Nov 2026 14:14:46 +0100
Subject: [PATCH v8 33/39] drm/tidss: dispc: Improve mode checking logs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261106-drm-state-readout-v8-33-cbe78624e1bc@kernel.org>
References: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
In-Reply-To: <20261106-drm-state-readout-v8-0-cbe78624e1bc@kernel.org>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Jyri Sarha <jyri.sarha@iki.fi>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Devarsh Thakkar <devarsht@ti.com>, dri-devel@lists.freedesktop.org, 
 Maxime Ripard <mripard@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=4157; i=mripard@kernel.org;
 h=from:subject:message-id; bh=1Lt537oiVezMzgcneT/VJvVEPrzJqsFWDbN9MPH10NY=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFlvL+0Orfe5prvSwe3bDL2PZm01JcV3VpqGVV6+coFlW
 c5xc9/3HVNZGIQ5GWTFFFmeyISdXt6+uMrBfuUPmDmsTCBDGLg4BWAiM68w1jsqSmZ+8FVn+uAc
 cshrw6eXMe+un/18X//hWZ95042PhDE09+1Ly7N2N943fVO2nPu5XsaGe6a+23dHf5jeEeqUxVH
 yy4f14Q7T23O5Z7jo1ArqNc3nF1a62RJ9tNTMsejOhtrCpF8A
X-Developer-Key: i=mripard@kernel.org; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The dispc_vp_mode_valid() function checks whether a mode can be handled
by the display controller.

There's a whole bunch of criteria, and it's not clear when a rejection
happens why it did. Add logs on each rejection criterion to make it
clearer.

Reviewed-by: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Signed-off-by: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/tidss/tidss_dispc.c | 45 +++++++++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index e516f493d6d9..b5fb296fddcc 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1318,4 +1318,6 @@ static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
 			     unsigned long clock)
 {
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
 	unsigned long round_clock;
 
@@ -1332,6 +1334,9 @@ static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
 	 * use the same 5% check here.
 	 */
-	if (dispc_pclk_diff(clock, round_clock) > 5)
+	if (dispc_pclk_diff(clock, round_clock) > 5) {
+		drm_dbg(dev, "Pixel clock %lu differs from rounded clock %lu by more than 5%%.",
+			clock, round_clock);
 		return -EINVAL;
+	}
 
 	return 0;
@@ -1342,4 +1347,6 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 const struct drm_display_mode *mode)
 {
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
 	enum dispc_vp_bus_type bus_type;
@@ -1347,12 +1354,18 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 	bus_type = dispc->feat->vp_bus_type[hw_videoport];
 
-	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF))
+	if (WARN_ON(bus_type == DISPC_VP_TIED_OFF)) {
+		drm_dbg(dev, "Invalid bus type.");
 		return MODE_BAD;
+	}
 
-	if (mode->hdisplay > 4096)
+	if (mode->hdisplay > 4096) {
+		drm_dbg(dev, "Number of active horizontal pixels above hardware limits.");
 		return MODE_BAD;
+	}
 
-	if (mode->vdisplay > 4096)
+	if (mode->vdisplay > 4096) {
+		drm_dbg(dev, "Number of active vertical lines above hardware limits.");
 		return MODE_BAD;
+	}
 
 	if (check_pixel_clock(dispc, hw_videoport, mode->clock * 1000))
@@ -1360,6 +1373,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 
 	/* TODO: add interlace support */
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
+		drm_dbg(dev, "Interlace modes not supported.");
 		return MODE_NO_INTERLACE;
+	}
 
 	/*
@@ -1371,6 +1386,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 	 * But for simplicity we enforce that always.
 	 */
-	if ((mode->hdisplay % 2) != 0)
+	if ((mode->hdisplay % 2) != 0) {
+		drm_dbg(dev, "Number of active horizontal pixels must be even.");
 		return MODE_BAD_HVALUE;
+	}
 
 	hfp = mode->hsync_start - mode->hdisplay;
@@ -1384,10 +1401,18 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 	if (hsw < 1 || hsw > 256 ||
 	    hfp < 1 || hfp > 4096 ||
-	    hbp < 1 || hbp > 4096)
+	    hbp < 1 || hbp > 4096) {
+		drm_dbg(dev,
+			"Horizontal blanking or sync outside of hardware limits (fp: %u, sw: %u, bp: %u).",
+			hfp, hsw, hbp);
 		return MODE_BAD_HVALUE;
+	}
 
 	if (vsw < 1 || vsw > 256 ||
-	    vfp > 4095 || vbp > 4095)
+	    vfp > 4095 || vbp > 4095) {
+		drm_dbg(dev,
+			"Vertical blanking or sync outside of hardware limits (fp: %u, sw: %u, bp: %u).",
+			vfp, vsw, vbp);
 		return MODE_BAD_VVALUE;
+	}
 
 	if (dispc->memory_bandwidth_limit) {
@@ -1399,6 +1424,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 		bandwidth = div_u64(bandwidth, mode->htotal * mode->vtotal);
 
-		if (dispc->memory_bandwidth_limit < bandwidth)
+		if (dispc->memory_bandwidth_limit < bandwidth) {
+			drm_dbg(dev, "Required memory bandwidth outside of hardware limits.");
 			return MODE_BAD;
+		}
 	}
 

-- 
2.55.0

