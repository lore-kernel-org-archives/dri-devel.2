Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 371FA606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S8C2G8yN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E47110FFF0;
	Thu, 29 Oct 2026 07:37:11 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADE1010FFEA
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 07:36:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 967FC408A0;
 Thu, 29 Oct 2026 07:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81001F031E0;
 Thu, 29 Oct 2026 07:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793259373;
 bh=pWYehB7F2AvgnO/NSfXax94B1lAU+p/pyvoOBPwn//o=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc;
 b=S8C2G8yNudmYHTrp8HMfKnybXTQqd4FS51xQGxyV9Hl5nkxTMgo/Gvu7hjsMbY3iv
 tBiF9t5wWCZLKag3KnKcoI4Ya2cTANi4M3525DiRQWfruKlBo1DaWFWD/KRv7Y0UH8
 1XfokDYO+xWZUF93j/nRLbtsjs8enq5mK4I/XKmxe/BtASOSLBGJLTp5Zrms0Dw5AH
 8xQ5mc+MFZ5edsPVpWFWbKb7OqzKuDiTgxvErNiCA145vWIYIlkzr9Ojn8fliy+9VU
 bi3ZuMnGpktSYnJzHOzHKoXgUb9hATqeTZuVORd8J2w+SsMVRagQx6dhOFveUTRBas
 gLukrat2PhkCw==
From: Maxime Ripard <mripard@kernel.org>
Date: Thu, 29 Oct 2026 08:34:20 +0100
Subject: [PATCH v7 30/34] drm/tidss: dispc: Improve mode checking logs
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261029-drm-state-readout-v7-30-25e5163d75c3@kernel.org>
References: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
In-Reply-To: <20261029-drm-state-readout-v7-0-25e5163d75c3@kernel.org>
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
 h=from:subject:message-id; bh=fO4TgHTsBREDTK8sYykcw0CQSVNmm8hXV/lPu01XX9E=;
 b=owGbwMvMwCmsHn9OcpHtvjLG02pJDFmPvv30kzN82Rb9sMn+swqDjram4+GWH8LLDWvecnIX7
 ri38Wd3x1QWBmFOBlkxRZYnMmGnl7cvrnKwX/kDZg4rE8gQBi5OAZjI7HeMDX8v26ntb7srUbdL
 qPnjedOU4wtvzfkQ1m8nNvuCY6jz/VMnG5LUcwvZ/vM/u6sza/l1AcaGKR3Tqspr2Pb/uOt0LiA
 y76jcwVRxJ/bbAasP7xYKu9819ZGxrNWtD5e1+//FO8W3cy0FAA==
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
index 2a0ec11a6c90..5943a5f25432 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -1305,4 +1305,6 @@ static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
 			     unsigned long clock)
 {
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
 	unsigned long round_clock;
 
@@ -1319,6 +1321,9 @@ static int check_pixel_clock(struct dispc_device *dispc, u32 hw_videoport,
 	 * use the same 5% check here.
 	 */
-	if (dispc_pclk_diff(clock, round_clock) > 5)
+	if (dispc_pclk_diff(clock, round_clock) > 5) {
+		drm_dbg(dev, "Pixel clock %lu differs from rounded clock %lu by more than 5%%.",
+			clock, round_clock);
 		return -EINVAL;
+	}
 
 	return 0;
@@ -1329,4 +1334,6 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 					 const struct drm_display_mode *mode)
 {
+	struct tidss_device *tidss = dispc->tidss;
+	struct drm_device *dev = &tidss->ddev;
 	u32 hsw, hfp, hbp, vsw, vfp, vbp;
 	enum dispc_vp_bus_type bus_type;
@@ -1334,12 +1341,18 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
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
@@ -1347,6 +1360,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 
 	/* TODO: add interlace support */
-	if (mode->flags & DRM_MODE_FLAG_INTERLACE)
+	if (mode->flags & DRM_MODE_FLAG_INTERLACE) {
+		drm_dbg(dev, "Interlace modes not supported.");
 		return MODE_NO_INTERLACE;
+	}
 
 	/*
@@ -1358,6 +1373,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 	 * But for simplicity we enforce that always.
 	 */
-	if ((mode->hdisplay % 2) != 0)
+	if ((mode->hdisplay % 2) != 0) {
+		drm_dbg(dev, "Number of active horizontal pixels must be even.");
 		return MODE_BAD_HVALUE;
+	}
 
 	hfp = mode->hsync_start - mode->hdisplay;
@@ -1371,10 +1388,18 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
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
@@ -1386,6 +1411,8 @@ enum drm_mode_status dispc_vp_mode_valid(struct dispc_device *dispc,
 		bandwidth = div_u64(bandwidth, mode->htotal * mode->vtotal);
 
-		if (dispc->memory_bandwidth_limit < bandwidth)
+		if (dispc->memory_bandwidth_limit < bandwidth) {
+			drm_dbg(dev, "Required memory bandwidth outside of hardware limits.");
 			return MODE_BAD;
+		}
 	}
 

-- 
2.55.0

