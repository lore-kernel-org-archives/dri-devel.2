Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0D5CC44501
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:57:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B753210F907;
	Fri, 10 Jul 2026 13:56:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="zJR9QopJ";
	dkim-atps=neutral
Received: from mail-4327.protonmail.ch (mail-4327.protonmail.ch [185.70.43.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 504FB10F905
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 13:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1783691644; x=1783950844;
 bh=QPBm4NG7A+HSGHSOUZg6VDUd6exXx8y8wk5CPF99Uq0=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=zJR9QopJuppwUbax7CpUW+5h93k0j8tPvkGBPUu/Rynu3RYWXsJ6txfN8EAxico0/
 5hTXlGz2XxGslmEFWow4yxmqx08GixIyiVb9D3Jx6MsYh4je+bCV4BPekVPD25u/6S
 7pFsT6PnzR4AOci6PS+rAFNBhZAgLhUfyG2hOwY14fzGDG+Fs4rOf6bHz5HNM61LEj
 x5yWrRJNicmMf52Xcrbj0gwmcQqwGYmicHOHbNpbaBIKLDXPh/h1jnmhK/5HqA+E7s
 SPVXUrWkNmt+ZXsp/C5ugITh9FcrAuhjsUlsm0xucd2n7fbKsFeXVX6Sfljg3zBPcA
 CHQli/BuWyw6Q==
X-Pm-Submission-Id: 4gxYGL0zlQz1DFTR
From: Esben Haabendal <esben@geanix.com>
Date: Fri, 10 Jul 2026 15:53:52 +0200
Subject: [PATCH 2/3] drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-nwl-dsi-fixes-v1-2-927d918a86ad@geanix.com>
References: <20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com>
In-Reply-To: <20260710-nwl-dsi-fixes-v1-0-927d918a86ad@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Esben Haabendal <esben@geanix.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1783691637; l=1428;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=MlnAnk3D6X3Xr53pwTpcKxu0eo4On3ljZI9uhBncg4s=;
 b=IT0mbu8pnP+y/tsfpkauoEaPAC/3UFDy0lGcNDQ6YOE0ZBDqNfaQBScT6ZoqiR0nVMTJhw3Tw
 2Y08Sp7dXP5BIEjJBr8jurY2ei9p5vjeQYJY8VmkF08Yq0N4LJUTejO
X-Developer-Key: i=esben@geanix.com; a=ed25519;
 pk=PbXoezm+CERhtgVeF/QAgXtEzSkDIahcWfC7RIXNdEk=
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

From: Robert Chiras <robert.chiras@nxp.com>

In order to respect the DSI protocol, make sure that auto-insert EOTP is
enabled according to the NO_EOT_PACKET flag instead of the
CLOCK_NON_CONTINUOUS flag.

Signed-off-by: Esben Haabendal <esben@geanix.com>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 915e1bdc73c8..c9af6a3d47e1 100644
--- a/drivers/gpu/drm/bridge/nwl-dsi.c
+++ b/drivers/gpu/drm/bridge/nwl-dsi.c
@@ -222,13 +222,15 @@ static int nwl_dsi_config_host(struct nwl_dsi *dsi)
 	DRM_DEV_DEBUG_DRIVER(dsi->dev, "DSI Lanes %d\n", dsi->lanes);
 	nwl_dsi_write(dsi, NWL_DSI_CFG_NUM_LANES, dsi->lanes - 1);
 
-	if (dsi->dsi_mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS) {
+	if (dsi->dsi_mode_flags & MIPI_DSI_CLOCK_NON_CONTINUOUS)
 		nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK, 0x01);
-		nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, 0x01);
-	} else {
+	else
 		nwl_dsi_write(dsi, NWL_DSI_CFG_NONCONTINUOUS_CLK, 0x00);
+
+	if (dsi->dsi_mode_flags & MIPI_DSI_MODE_NO_EOT_PACKET)
 		nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, 0x00);
-	}
+	else
+		nwl_dsi_write(dsi, NWL_DSI_CFG_AUTOINSERT_EOTP, 0x01);
 
 	/* values in byte clock cycles */
 	cycles = ui2bc(cfg->clk_pre);

-- 
2.55.0

