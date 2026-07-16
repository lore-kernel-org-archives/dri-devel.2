Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 526DDC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:20:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B44F910E353;
	Thu, 16 Jul 2026 13:20:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oRbjkQcR";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A1EF10E353
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:20:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6002640F20;
 Thu, 16 Jul 2026 13:20:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421181F000E9;
 Thu, 16 Jul 2026 13:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208006;
 bh=G9TdbDqBLIgYoXEokaUX6Znn1R65A/jD89s8AWApvkw=;
 h=From:To:Cc:Subject:Date;
 b=oRbjkQcR/w8JCQbBajwuQeUYIyWdhQjZSXtS9hdHyhYj/pAFim58GsWKiSJsWpZx2
 oDBIzUSOxNbVIHfDemBiH4VqUHwfkWsok2MK6Sax36E5yz7mMgcqdUFXbuabgkY2Ml
 KUWaTj4R18cPKEgfEHhT3JC+ICH1HullgL98MnsmlAQiJBzYtSNI6OMLRIjk6peMC8
 1FAvzSRwYXBilnt0rwQtuu0DB+ROm7J8HMTFhtWFbSziMZ+wh53xxrMzvWbyAVMnqM
 0h3nekRVyhGUIf4ETc1ZxI629+hgc/GfqBn98oCHmjvuyh7t1Xkuigzn6hixNEmTok
 x/L7CFujQMZXQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkM0S-00000006Z6m-0Dkz;
 Thu, 16 Jul 2026 15:20:04 +0200
From: Johan Hovold <johan@kernel.org>
To: Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] drm/imx/tve: take i2c adapter module reference
Date: Thu, 16 Jul 2026 15:19:37 +0200
Message-ID: <20260716131937.1564892-1-johan@kernel.org>
X-Mailer: git-send-email 2.54.0
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

The i2c subsystem currently blocks during adapter deregistration
whenever there are consumers holding a reference.

Switch to using of_get_i2c_adapter_by_node() which also takes a
reference to the adapter module so that an attempt to unload the module
while in use fails gracefully instead of blocking uninterruptibly.

Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/imx/ipuv3/imx-tve.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/imx/ipuv3/imx-tve.c b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
index e861b8b9d8fa..389f45d54faa 100644
--- a/drivers/gpu/drm/imx/ipuv3/imx-tve.c
+++ b/drivers/gpu/drm/imx/ipuv3/imx-tve.c
@@ -528,11 +528,11 @@ static const struct component_ops imx_tve_ops = {
 	.bind	= imx_tve_bind,
 };
 
-static void imx_tve_put_device(void *_dev)
+static void imx_tve_put_adapter(void *_adap)
 {
-	struct device *dev = _dev;
+	struct i2c_adapter *adap = _adap;
 
-	put_device(dev);
+	i2c_put_adapter(adap);
 }
 
 static int imx_tve_probe(struct platform_device *pdev)
@@ -554,11 +554,11 @@ static int imx_tve_probe(struct platform_device *pdev)
 
 	ddc_node = of_parse_phandle(np, "ddc-i2c-bus", 0);
 	if (ddc_node) {
-		tve->ddc = of_find_i2c_adapter_by_node(ddc_node);
+		tve->ddc = of_get_i2c_adapter_by_node(ddc_node);
 		of_node_put(ddc_node);
 		if (tve->ddc) {
-			ret = devm_add_action_or_reset(dev, imx_tve_put_device,
-						       &tve->ddc->dev);
+			ret = devm_add_action_or_reset(dev, imx_tve_put_adapter,
+						       tve->ddc);
 			if (ret)
 				return ret;
 		}
-- 
2.54.0

