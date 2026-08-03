Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 923FBC55184
	for <dri-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:56:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD93610E6BA;
	Mon,  3 Aug 2026 14:56:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=geanix.com header.i=@geanix.com header.b="Q3oykL5o";
	dkim-atps=neutral
Received: from mail-106112.protonmail.ch (mail-106112.protonmail.ch
 [79.135.106.112])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887E110E6EA
 for <dri-devel@lists.freedesktop.org>; Mon,  3 Aug 2026 14:56:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=geanix.com;
 s=protonmail3; t=1785768997; x=1786028197;
 bh=QPBm4NG7A+HSGHSOUZg6VDUd6exXx8y8wk5CPF99Uq0=;
 h=From:Date:Subject:Message-Id:References:In-Reply-To:To:Cc:From:To:
 Cc:Date:Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=Q3oykL5o6e9h7yAA9/PJO+Cl6fCRwfCcAuyd/wE540gLfafKXRdhl10Oh4Tf9i5Bz
 DOnxbM1IupdevPznUTfiFEKmf2/7ViXSa1iWyKeJ2ZH36Bj5PAg2De56oVD5a2ZyGU
 yJP/C2jdOPhIo0tIy+yENL/HLbJpbeledx/Zgxfw1CpXKEayW1i4VC1+Zq0urXIMw4
 2+c9qGIrBAgVHqhJFCc38HtXXjftzkirXo+ivay4qYNRDFwH5zotoYggdWnz/V+rmm
 fxiFEldgxhPUf71xJp4P3VcHhP1NZHHHNNU0NKYmf9YffGG9m6lJ27Fsp/Bxj6+FsA
 ZAm2lnQtcBmLw==
X-Pm-Submission-Id: 4hDKWS61vGz2Sd49
From: Esben Haabendal <esben@geanix.com>
Date: Mon, 03 Aug 2026 16:56:20 +0200
Subject: [PATCH v2 2/4] drm/bridge: nwl-dsi: Correct auto-insert EOTP behavior
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260803-nwl-dsi-fixes-v2-2-1809a0ac453f@geanix.com>
References: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
In-Reply-To: <20260803-nwl-dsi-fixes-v2-0-1809a0ac453f@geanix.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Esben Haabendal <esben@geanix.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, Robert Chiras <robert.chiras@nxp.com>, 
 Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1785768991; l=1428;
 i=esben@geanix.com; s=20240523; h=from:subject:message-id;
 bh=MlnAnk3D6X3Xr53pwTpcKxu0eo4On3ljZI9uhBncg4s=;
 b=z3Jf9W6nXyVo8zGhXIdad7r6BjnrXxZBxPVxtH64DgqHWCLyfKHg8GIvHFABmn0o443//Porl
 X7oJvA/lNBpCvWeGuGJ4pZIKpQFr42Mz/523QQiiPNf6ZRwBwSdItHk
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

