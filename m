Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFA77C44500
	for <dri-devel@archiver.kernel.org>; Sun,  5 Jul 2026 16:42:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99E3A10E200;
	Sun,  5 Jul 2026 16:42:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=sang-engineering.com header.i=@sang-engineering.com header.b="gI7iBxpx";
	dkim-atps=neutral
X-Greylist: delayed 401 seconds by postgrey-1.36 at gabe;
 Sun, 05 Jul 2026 16:42:41 UTC
Received: from mail.zeus03.de (zeus03.de [194.117.254.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13AA010E1F4
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Jul 2026 16:42:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 sang-engineering.com; h=from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 s=k1; bh=5/8YyUsbPTIQRr+8uek9v/lHOv+3Jinf7aV5NS16W00=; b=gI7iBx
 pxanMlK+0LFJzvmZa4x9Gynbx/Dah04Hw8rK/Nk3cxblx50wqR2FM71sCjfjS+AQ
 nQpPptEyWjcJfOBOyCiP3Lx7czHX+uLbkXZOtxAEV4SlD6g53AityhiSq4Bk9qwE
 T4IPCUMtFd0WnLq344mob9FINPuN6s4ZWE09bRrdLoRFVpWSCjLmt5qBLKH5sKzL
 Ns82UjIW1nl5MIeh2ARkIRaquAWYcS70NEsDrdsVZvKbOxnweF1WB4EVI9qriBIt
 0/xRGxn2DXMSPEN1ytH9ummB3mOIWi/gCNyQqkqLGYrL9Jfcpb5S6ykwVi+EJs7z
 gTQBdCaqtYNy2PGA==
Received: (qmail 2287370 invoked from network); 5 Jul 2026 18:35:59 +0200
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted,
 authenticated); 5 Jul 2026 18:35:59 +0200
X-UD-Smtp-Session: l3s3148p1@RaKswN9VOChtKjFj
From: Wolfram Sang <wsa+renesas@sang-engineering.com>
To: linux-kernel@vger.kernel.org
Cc: Wolfram Sang <wsa+renesas@sang-engineering.com>,
 Andy Yan <andy.yan@rock-chips.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org
Subject: [PATCH 1/3] drm/bridge: remove unneeded 'fast_io' parameter in
 regmap_config
Date: Sun,  5 Jul 2026 18:35:36 +0200
Message-ID: <20260705163536.1850-6-wsa+renesas@sang-engineering.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260705163536.1850-5-wsa+renesas@sang-engineering.com>
References: <20260705163536.1850-5-wsa+renesas@sang-engineering.com>
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

When using MMIO with regmap, fast_io is implied. No need to set it
again.

Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>
---
No dependencies, can be applied directly to the subsystem tree. Buildbot is
happy, too.

 drivers/gpu/drm/bridge/synopsys/dw-dp.c        | 1 -
 drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c | 1 -
 2 files changed, 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-dp.c b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
index 21541be094c4..d6907a97c7f5 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-dp.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-dp.c
@@ -1949,7 +1949,6 @@ static const struct regmap_config dw_dp_regmap_config = {
 	.reg_bits = 32,
 	.reg_stride = 4,
 	.val_bits = 32,
-	.fast_io = true,
 	.max_register = DW_DP_MAX_REGISTER,
 	.rd_table = &dw_dp_readable_table,
 };
diff --git a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
index b2a022d266d9..6b3de2b5ac80 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-mipi-dsi2.c
@@ -907,7 +907,6 @@ static const struct regmap_config dw_mipi_dsi2_regmap_config = {
 	.reg_bits = 32,
 	.val_bits = 32,
 	.reg_stride = 4,
-	.fast_io = true,
 };
 
 static struct dw_mipi_dsi2 *
-- 
2.51.0

