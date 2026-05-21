Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DDB9CD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 21:25:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A270410F400;
	Thu, 21 May 2026 21:25:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hB5IMtnp";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8D6F10E25E
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 21:25:37 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-48ff4f8ef0dso71260275e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779398736; x=1780003536; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=NihLJqzLuBSbswhwjypE1RCzmcHTDYxTHDH3suJunDY=;
 b=hB5IMtnpAblUt7Sf6D9MHBUEc4u8DPFZUXYK/Nz4lYN6KE7O4Jd0KGVSc1xBFy+8cO
 Xz2SjTtJ8y6nRSTgcrBh0IJk/fr66gZuK3OkXoNN2cSwY88pwf5yeevl2YdyPg0pzDmt
 XWyBQzhaEmmVZqfEVd6nRRK59rUjhvC9uauieWkDVJ1prCCTreFR/deVsZARjW+wQTfh
 SL16VgIOAo5de9gZgyyMXA5IY19FtSYgURgf6L/PdDhOO2wLsh/oWda0FNS7RKq7N5Pg
 TUfPpXqCN970YAsXGAWPmFg22keB98rBX6W+YTMGBChOwErkvQQKX2hHy4/vcvsV4TAB
 O58g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779398736; x=1780003536;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NihLJqzLuBSbswhwjypE1RCzmcHTDYxTHDH3suJunDY=;
 b=J2LVIuaDACA0JWS6u2lJoULe8jONmq4taA1QjiWWZMcxdeZfAZ1g9mOc9SEKqE2e3x
 PZsW5yq4W5z7ysbAHvMoEMvhiQcj8wwPpRdazrrjXE/VEVTuTVtJBahvSRzh4xN0TOLR
 3ACHXthjYeDw95cA7rlfrPv66TeeiuocuN3/vQFQOkAaLZ6HGElAck5v9TTm9xGbjPLb
 BMD0R4DjeriyhoEhaCGMdnCj98fqqBdvE2MYnJNCWkDTGX4/lCZBlca6PT3VzGJ8aquF
 fHKo86K9gggsNi6i0RNu6RIv0V6YIcN3YzFcOhpx36UvRrlOt8r0GOuR6jMucHyLVQDA
 InrQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+C0k7biJn3wkYCBLzNCxhI2YTydit3qA0JK7F/87IK8C3ZsjZWNr9lSp6zjD3P2dhpUxaT4oX3bFk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypsGsiQipvWSzcCReHgVakMTnIVKJvYSebE8vwVL88XVAoioMO
 ZFWfA1E5VfWyQYFJu6b1ZmPPh74LHxwlWOFwqk/tdONUHwabyqqaAPQv
X-Gm-Gg: Acq92OG/ktTJm8n6IIIr7mzwnlDYwwLZyrM49GS+sDeeBLuMclgk+l6MYLNsgaceilL
 KfPsJNGtMXXeM7ESjL2S0YGNbiDxidonxRr4ucaG6bo3ulFp5ma97qpmhYAGe0iCCrwlsmtbDO0
 0u5SIXOsrptZysk4D6NdeM0Ymg19RKJBD4l1PVy3Ch4HUdIJjyB2cnHJ3Fox96rupSHutaj4QPm
 LgSZowM2COMjUBeLSgQAgKI3iqDcWH8MRZzREMht1a1SyccX0PggBz+h4jHYTCLV1Gw58TWzT8o
 n/CbhF69X4/3C0CmHJhQ0mlwLAsYIbxwTA5Ssy2gBz1YljXuIxQRpROQ9zDmhnkdo0P4WGGYFSD
 tSGyJEn5hxi5kxpubVV0rJ2JOJFbTJRuyeFJQbW2RWAqwU+QXR8YD7nhv6F61wNrBK89M656neV
 kFXdTcXd4xm2bAClPNX7v20WyRehpNFLY2rqS404SQLw0DIl+tD9iU/Lw6
X-Received: by 2002:a05:600c:4e43:b0:48f:e230:2a1d with SMTP id
 5b1f17b1804b1-49042ae77b4mr6364855e9.32.1779398736015; 
 Thu, 21 May 2026 14:25:36 -0700 (PDT)
Received: from osama.. ([41.43.100.18]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49033d52c8bsm97086515e9.8.2026.05.21.14.25.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 14:25:35 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Jagan Teki <jagan@amarulasolutions.com>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH] drm/bridge: chipone-icn6211: use devm_mipi_dsi_attach
Date: Thu, 21 May 2026 23:25:28 +0200
Message-ID: <20260521212529.151493-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Follow up on the previous devm_drm_bridge_add() conversion by
converting the remaining manual cleanup in chipone-icn6211 to the
managed helper.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/bridge/chipone-icn6211.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/bridge/chipone-icn6211.c b/drivers/gpu/drm/bridge/chipone-icn6211.c
index e5957917ad88..d51d770060b6 100644
--- a/drivers/gpu/drm/bridge/chipone-icn6211.c
+++ b/drivers/gpu/drm/bridge/chipone-icn6211.c
@@ -531,7 +531,7 @@ static int chipone_dsi_attach(struct chipone *icn)
 	dsi->hs_rate = 500000000;
 	dsi->lp_rate = 16000000;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0)
 		dev_err(icn->dev, "failed to attach dsi\n");
 
@@ -761,11 +761,6 @@ static int chipone_i2c_probe(struct i2c_client *client)
 	return chipone_dsi_host_attach(icn);
 }
 
-static void chipone_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	mipi_dsi_detach(dsi);
-}
-
 static const struct of_device_id chipone_of_match[] = {
 	{ .compatible = "chipone,icn6211", },
 	{ /* sentinel */ }
@@ -774,7 +769,6 @@ MODULE_DEVICE_TABLE(of, chipone_of_match);
 
 static struct mipi_dsi_driver chipone_dsi_driver = {
 	.probe = chipone_dsi_probe,
-	.remove = chipone_dsi_remove,
 	.driver = {
 		.name = "chipone-icn6211",
 		.of_match_table = chipone_of_match,
-- 
2.43.0

