Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4F1BCD5BAB
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 21:53:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E4110E280;
	Thu, 21 May 2026 21:53:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Q3tYfAv8";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89DB410E280
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 21:52:58 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-45d96d21e82so3840767f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:52:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779400377; x=1780005177; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=FX00zXuALEFbr7xyBmRRoNDwxqBnoiY5kbgoKXwjgQ8=;
 b=Q3tYfAv8eY1NGDZFuL53iciV7Q/L77OWFnN4L2ew5quZK2kTLNpTjLhFoVpGkn+xgE
 PQqM9b/GgVhGtirBi1bqB96HAa+WNAC/EN6klm3by7WjMFOrjwG422Zd94tyWOn3DI0H
 Dxf7D0bDOZskA3qQDqiGmhf/tkckmgf5C19s/CliWxnVlBnP5UB06Wr+e8Vq/XaRmMOn
 75waC8OUJc73PgZuIdqfUIAEXhDG5YR/DLuQNAMzmM9Musxw5a+ggnA5dl3lPY7I2DwI
 +aiRqYCKSRJVK9ZOsQpeNZHEy642e09nbXFMt8FvpBjFeWKfTA2HD1656O4ZMXm2qCyk
 b2Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779400377; x=1780005177;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FX00zXuALEFbr7xyBmRRoNDwxqBnoiY5kbgoKXwjgQ8=;
 b=N/HjLeZlYiPVFqtyQhw/7Y4DtyLMSQM7lq3KlI34EK2kR+T/Xo2VkjKXeSLkuGoD25
 kuNQSvj2RVMGJB1zFmenSAY0roxlf+a9gMKReryVoyzo0JX6xuHNOvHcMScOYpWCLon0
 COxC2nybS/hWatBrIOtnnA01Gtlii1QSygjiNEL1YFuBWjOQ2Cf/qdk+1GSTabxtIUgZ
 cfm2JFf7vstsuUo65G5ONgpYH0zTU/BnFUBGs47zFirrRy05/FuwoDI0vCE9StUKFL4n
 IXAYvGBcgMl71eKZwEusipblPy2jM5Oia3Tnaj+vvAPWg2uu8K0QQk9pd0930L4yDdJg
 tieQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/JJD2eZ0SwhbhctBgOo35yjlkcPo+Kfp3C6pj99u5FdSfliftX6NnyjQqKOCX38Pz+P6bpsisC+LY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw+zz5Bop0e4YLp1MQbhrI/5ppeEPPOQtRcXa7fmfMXvsS+6B0z
 bDxXkxO9NbVtHt8cHQ8hw1PwCdheKHbs00CJtyg4ccJojAqAWVBofz/n
X-Gm-Gg: Acq92OEXbuFcl2yh8Gb5vzs99p0I7QrmebJYpooSQfV5+qlSAN1SXOAN7beUmzEuMu5
 2sudKV91S7sx5BGPVvVnpGiX/JUxszE+FlaFmtSxFKoctzV36XDCWlujRxZ3Jc+n0qh3qQMKnKc
 ldJFyIni80Pbf0svvjodiv+fpmFf/DXVjb/GGVJ0CAUuf5rLHGWhk81i2EUFtag70cYRgX1iyJn
 LZoJZBzmKwwm8VGzR0KPWKZxTnuZmNzLOPEKWk6F1Av0s0JsUBoOBB4XyjTFb5CMJA8vA8FveDe
 1fzCECGRXhJ2C14Bu6tpV+RHNYRVT3sheCWG5/hcPc2r7PFSmlCVr0PYxiJi1DC/KL1OBSrxOgI
 Y2A7Q7aWZoxcGTal7ktc0WMnrO3IIRcX91p0K9q2+NSVewllP6J6UbxtF1wPcULff5BjLzU502D
 jX3Wu8+PuH0J591Mtdwsj/2wfCN7sORVO7LsaupYtscR0BAiBgvFRJejOA
X-Received: by 2002:a05:6000:388:b0:43e:a9ba:b194 with SMTP id
 ffacd0b85a97d-45eb38acbc6mr584327f8f.34.1779400376890; 
 Thu, 21 May 2026 14:52:56 -0700 (PDT)
Received: from osama.. ([41.43.100.18]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb4ad03a6sm135136f8f.27.2026.05.21.14.52.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 14:52:56 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH 1/2] drm/bridge: tc358762: use devm for bridge registration
 and DSI attach
Date: Thu, 21 May 2026 23:52:26 +0200
Message-ID: <20260521215228.188615-1-osama.abdelkader@gmail.com>
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

Replace manual drm_bridge_remove()/mipi_dsi_detach() in remove with
devm_drm_bridge_add() and devm_mipi_dsi_attach() in probe. Also check
the return value from bridge registration.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 3d75d9cfa45e..3a021ca895f1 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -293,25 +293,17 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	ctx->bridge.of_node = dev->of_node;
 	ctx->bridge.pre_enable_prev_first = true;
 
-	drm_bridge_add(&ctx->bridge);
+	ret = devm_drm_bridge_add(dev, &ctx->bridge);
+	if (ret < 0)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_bridge_remove(&ctx->bridge);
+	ret = devm_mipi_dsi_attach(dev, dsi);
+	if (ret < 0)
 		dev_err(dev, "failed to attach dsi\n");
-	}
 
 	return ret;
 }
 
-static void tc358762_remove(struct mipi_dsi_device *dsi)
-{
-	struct tc358762 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_bridge_remove(&ctx->bridge);
-}
-
 static const struct of_device_id tc358762_of_match[] = {
 	{ .compatible = "toshiba,tc358762" },
 	{ }
@@ -320,7 +312,6 @@ MODULE_DEVICE_TABLE(of, tc358762_of_match);
 
 static struct mipi_dsi_driver tc358762_driver = {
 	.probe = tc358762_probe,
-	.remove = tc358762_remove,
 	.driver = {
 		.name = "tc358762",
 		.of_match_table = tc358762_of_match,
-- 
2.43.0

