Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A3C6C624C6
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 13:28:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BE22D10E128;
	Mon, 31 Aug 2026 13:28:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="K9Zzub1Z";
	dkim-atps=neutral
Received: from mail-244107.protonmail.ch (mail-244107.protonmail.ch
 [109.224.244.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90B4910E843
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 13:28:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail; t=1788182885; x=1788442085;
 bh=tHnO0TtSJZT3uwTmNJnMjCsYgQ5eOEaHFXCtJEWympU=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=K9Zzub1Zv7IOGRfiJhTGBQ17DTzjIBPXUQNAr7NY1lAofHTvNfuq63F+pAm0tGslJ
 3zRBAYGioljz+tzjdbRNL3ewWRDZrxNVn+HZ4uY3yRXbvwXHE+uMeQ+DPqpfFeF10e
 yzfOyUYT+AixfJzCBn4B4HXhuLPOzrpQJrP8/E+oyntf+UZuCHPPWcfs1rV8j7rSTy
 PCiHn7+1hmu0qLBAo6Ozxgrz4BZJRQuXmC65wQ4diPFH9maxaBXXzp3golHOLb/LDm
 NhW/vWp0C7ykkcD47e3BByZxRZSn0ObXhG0kkGKw3WPuk7EtlwyWyUqTxXawOG9TqN
 FmeoVmNIkTGSA==
X-Pm-Submission-Id: 4hYVDN0s33z2ScWl
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 31 Aug 2026 15:27:45 +0200
Subject: [PATCH v4 3/4] drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-nwl-dsi-fixes-v4-3-6a2a1cb23910@geanix.com>
References: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
In-Reply-To: <20260831-nwl-dsi-fixes-v4-0-6a2a1cb23910@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 =?utf-8?q?Guido_G=C3=BCnther?= <agx@sigxcpu.org>, 
 Fabio Estevam <festevam@gmail.com>, Robert Chiras <robert.chiras@nxp.com>, 
 Sam Ravnborg <sam@ravnborg.org>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788182874; l=1534;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=kKsffolI3Qs7QhM0aRcvOCyPsNNcZdkiD1A5b8xHohA=;
 b=J4LsSxC5aITLgDQB/KpUb10mwQ9+TU75DNKgkf9gtJnRagL/g2POMbhlVmoQqvkvItbnynqH2
 i5az424w6E/DhIa1tfFb3tBZQqNqn10NIkJGysG1ivPL90VWoiN3f+5
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

Fixes: 44cfc6233447 ("drm/bridge: Add NWL MIPI DSI host controller support")
Cc: stable@vger.kernel.org
Signed-off-by: Esben Haabendal <esben@geanix.com>
Cc: Robert Chiras <robert.chiras@nxp.com>
Cc: Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
---
 drivers/gpu/drm/bridge/nwl-dsi.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/bridge/nwl-dsi.c b/drivers/gpu/drm/bridge/nwl-dsi.c
index 1aab46e1a168..f3f4334136c0 100644
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

