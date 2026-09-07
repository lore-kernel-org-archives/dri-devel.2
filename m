Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AE4DC79F89
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:28:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B60BD10E7A6;
	Mon,  7 Sep 2026 11:28:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="n8bG4hiG";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE71610E793
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:28:35 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 836754B0;
 Mon,  7 Sep 2026 13:26:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788780420;
 bh=b9e4M5MSV78pVi7NRo8tV43LAYvKMk3nxGY273xN9cQ=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=n8bG4hiGXXhl54LCKRH3pT2zEFqyzVU9QAM1DXU41YkZ8PchHBfQdjS0bPzQ1hTwn
 ITDjGXC+Prso/lAniNBwN3Al/69nPaHDePsxpWXSj+kKQ7gEDGDycIV1yOcA2mZOfo
 w8aX9otGpdmcJusc3Y4UEb73cZQzC3rjTUU7267I=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 07 Sep 2026 14:28:07 +0300
Subject: [PATCH v4 12/13] drm/bridge: tc358762: Set DE_POL and DCLK_POL
 properly
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tc358762-fixes-v4-12-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
In-Reply-To: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2009;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=b9e4M5MSV78pVi7NRo8tV43LAYvKMk3nxGY273xN9cQ=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnp/Vv7LM78sgJqO0pIjNliImgTYMTQb7mTDaf
 yMXZWtq1XmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6f1QAKCRD6PaqMvJYe
 9XUEEACyZ9Fq6wTu9bfEPErDolZSUPBcLCSdSLCmawnWsmD9vSK9as4vytViYjFf5Kvr9qZ7u79
 8M8qaI0Ftyh+H1AN6rEp2hA4wFoRIQb2j6cjad9tskucguBPqdh4ncsa90v4Rb0Vohoz5vAOPbx
 6eg3I3boUfWKRNbiGgGb8wMaeyPWz8lo3Lf8swFMCyrUc2RF7eU3oNsEExpAFcPJBTcoBtpxC7E
 91l/XI/85f+aNN2J2KMp0QJAwCASVCop0eutqsu0t7oSHfhu2yA2npil/TY6XinTzi/eO3WaKDY
 6BfalDDhIJa+AovjBWADz2sOA4Sr1uvQAkEZIEgiMaP3qq3G9p1SI4T3laZ/Yu8GEMqUHGSn0jF
 wsWrCLCdYzIqeggd+xWJPzMSgUwCs9IxAnRzjlmq+5rbcoa03QlRt1UR23A2Q2AcjuUT8uo62Ys
 RYux0VgQ5Nr/rNT2pxhlTYWcHFcjqy5PgYR0VrlWP9FdUQq/sHeMp36Ok1+jMRqufVh73cX+snv
 aBIHW/PfnkRLIwbjvOLbt9TTtmsDoPHAEiY5Zk8Wy8t+W8fFq+Sb2qaNEH2npNB5BejhshCt3S1
 XnneEbDsOj/2e59lnDWULCufamLerCshCJ5VEw4vJathOTF6eX6sSUkigmReREtOIK79ZwI2hqv
 UvfCAbKppD/n6hg==
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
index ad3a2620ce47..25b719cd66fe 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -186,12 +186,15 @@ static void tc358762_enable(struct drm_bridge *bridge,
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
@@ -243,7 +246,9 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	if (ctx->use_vtg)
 		lcdctrl |= LCDCTRL_VTGEN;
 
-	lcdctrl |= LCDCTRL_DCLK_POL;
+	/* Note: DCLK_POL affects pixdata, de and syncs */
+	if (bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE)
+		lcdctrl |= LCDCTRL_DCLK_POL;
 
 	if (mode->flags & DRM_MODE_FLAG_PHSYNC)
 		lcdctrl |= LCDCTRL_HSYNC_POL;
@@ -251,6 +256,9 @@ static void tc358762_enable(struct drm_bridge *bridge,
 	if (mode->flags & DRM_MODE_FLAG_PVSYNC)
 		lcdctrl |= LCDCTRL_VSYNC_POL;
 
+	if (bridge_state->output_bus_cfg.flags & DRM_BUS_FLAG_DE_LOW)
+		lcdctrl |= LCDCTRL_DE_POL;
+
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
 
 	tc358762_write(ctx, PPI_STARTPPI, PPI_STARTPPI_STARTPPI);

-- 
2.43.0

