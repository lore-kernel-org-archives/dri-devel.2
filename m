Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B3A1CD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:11:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1E5A10EE6C;
	Wed, 13 May 2026 13:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VFYmAyl7";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A4A2A10EE66
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:53 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 78535298B;
 Wed, 13 May 2026 15:10:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677844;
 bh=XvsqVsDW6S2WDPtP071eSFQrkacimLhumBGM03sDkEA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=VFYmAyl7Xpsq0hMN/m+VidHSnK/I6HQmPiZX47x5sB9hoYd2ngG1qANs5usOrz58F
 BWltZWR+q2/c/UqYNMnt7F1anoafFfmZkEh/XYzkNaPrldEbfu/DHIsM2IQfLiYd1s
 FiHpVTiBA0nSswRfvPKlGv16ggJmKB+QDo3c1yig=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:21 +0300
Subject: [PATCH v3 12/13] drm/bridge: tc358762: Set DE_POL and DCLK_POL
 properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-12-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
In-Reply-To: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=XvsqVsDW6S2WDPtP071eSFQrkacimLhumBGM03sDkEA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhOQoknu92qEo0aPYelFm0JTttRResRS3HCK
 /08iOmebeGJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4TgAKCRD6PaqMvJYe
 9T6qEACVNETPGw1buaLaTcORCWh4BtYLfyFVJ6A6af8GL+F9TQ5YP0FlWZjDnKRsKQJSkpj+pMj
 GXJU1PEqPA0QpWCyYsMYCTEiLdyWugOvh9EFWuYaf3jp1oMfaXaTE5GrXXUIpNt6MgSGPqTRMkN
 lfeoZ/4st2GzPSD3EXGqtdmhboV8z4QcIRBTZS2W7EoJyKmNvGCx/TOyuIsAr6X2FW0bpmQROjl
 ZTMZzDafn6/HDYlY3sy+3vYSiivfPymlyi2gcDAxluLgRTaWXIHdhK72AzWBzz2EnXj6JAnTQKy
 DgTKCT9WrvxkCxIdVaM9nncumxNVDxr0oCUITqD7edrLzoMiAIhdwCAHPeT+VYETXPkUFw7a5C8
 iAvaOz1vs4CTHU8cTFknUggFJJCxqXy08C9L9KwyCH5UX1Fyo9jYZXW5HEstzUYyGCqOz9O25BX
 HudNmEEDrzAU+n0GgmRCkTfXJuXwfACqNq9HOxb/s6j6pBbQDAhFvO8URC9ZGeGZJZXo7X86/DJ
 CjUn4OpfIc18dYGkl+/GbTHUGdg1KpMJ+n4AsdUA/LalAZOiPr6fUBxpdn9Jp0VYf4ri9kVjjtp
 EJQd9hmeCaiYXvns1aOmiipy+vCSsiMoZtwJ8HTBxS/SE1TNuVu/t48HjWd9F3uCV9MbFtNF2GP
 38b4qh69QTBm02g==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

The driver hardcodes LCDCTRL_DCLK_POL and ~DE_POL, ignoring what the
panel actuall wants. Fix this by looking at the
bridge_state->output_bus_cfg.flags, and set the polarities correctly.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 47ae706de4cb..92e7e2ade942 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -187,12 +187,15 @@ static void tc358762_enable(struct drm_bridge *bridge,
 {
 	struct tc358762 *ctx = bridge_to_tc358762(bridge);
 	struct drm_connector_state *conn_state;
+	struct drm_bridge_state *bridge_state;
 	struct drm_crtc_state *crtc_state;
 	struct drm_connector *connector;
 	struct drm_display_mode *mode;
 	u32 lcdctrl;
 	int ret;
 
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
 	conn_state = drm_atomic_get_new_connector_state(state, connector);
 	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
@@ -244,7 +247,9 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	if (ctx->use_vtg)
 		lcdctrl |= LCDCTRL_VTGEN;
 
-	lcdctrl |= LCDCTRL_DCLK_POL;
+	/* Note: DCLK_POL affects pixdata, de and syncs */
+	if (bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
+		lcdctrl |= LCDCTRL_DCLK_POL;
 
 	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
 		lcdctrl |= LCDCTRL_HSYNC_POL;
@@ -252,6 +257,9 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		lcdctrl |= LCDCTRL_VSYNC_POL;
 
+	if (bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_DE_LOW)
+		lcdctrl |= LCDCTRL_DE_POL;
+
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
 
 	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);

-- 
2.43.0

