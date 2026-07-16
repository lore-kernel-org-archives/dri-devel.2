Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9186AC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:21:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0085C10E16D;
	Thu, 16 Jul 2026 13:21:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="VWzDH6HK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B2C810E16D
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 13:21:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DF435600AF;
 Thu, 16 Jul 2026 13:21:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94B151F00A3A;
 Thu, 16 Jul 2026 13:21:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784208073;
 bh=5+PTVvtbxISQHBh7RDfP9RhXJiuh9DQQG1Am4RdSHNo=;
 h=From:To:Cc:Subject:Date;
 b=VWzDH6HKO66dhqFPwZt4Mw2z+IwI9naF9ychftoED8XY5nqveyqmvIIE1OxYfYjiC
 zIveTkz/zovHhdcc/Ze9mz6hxbhVM6jcHPyYzU/9YkdfciE+1KS63V9mJX1qkrIrFr
 g/bMeNYFs62QI2x9erMnZ6toFGpV418L/v3umUf4ngDuelbgYVeP1R7hzGZv+IP3IH
 3AF+ReY6nlu3H2KM3bm/WSVBWpQ5/vRCahO4KgcXtdL/bFWNzMkZSQQ7D7/n0u5oc3
 v5FHeD/PhQWpi9YWNel+OP3lyV3q2qvqrF5y9PTdOQR/d+A8XtY29Rw7pXTVACUx0D
 1u3Vt0daJz5pg==
Received: from johan by xi.lan with local (Exim 4.99.4)
 (envelope-from <johan@kernel.org>) id 1wkM1X-00000006Z8A-22kw;
 Thu, 16 Jul 2026 15:21:11 +0200
From: Johan Hovold <johan@kernel.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>
Subject: [PATCH] drm/mediatek: mtk_hdmi_common: take i2c adapter module
 reference
Date: Thu, 16 Jul 2026 15:21:03 +0200
Message-ID: <20260716132103.1564995-1-johan@kernel.org>
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
 drivers/gpu/drm/mediatek/mtk_hdmi_common.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
index a049489daa2d..042b98e5a519 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_common.c
@@ -290,6 +290,13 @@ static int mtk_hdmi_get_cec_dev(struct mtk_hdmi *hdmi, struct device *dev, struc
 	return 0;
 }
 
+static void mtk_hdmi_put_adapter(void *_adap)
+{
+	struct i2c_adapter *adap = _adap;
+
+	i2c_put_adapter(adap);
+}
+
 static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device *pdev,
 				   const char * const *clk_names, size_t num_clocks)
 {
@@ -328,12 +335,12 @@ static int mtk_hdmi_dt_parse_pdata(struct mtk_hdmi *hdmi, struct platform_device
 	if (!i2c_np)
 		return dev_err_probe(dev, -EINVAL, "No ddc-i2c-bus in connector\n");
 
-	hdmi->ddc_adpt = of_find_i2c_adapter_by_node(i2c_np);
+	hdmi->ddc_adpt = of_get_i2c_adapter_by_node(i2c_np);
 	of_node_put(i2c_np);
 	if (!hdmi->ddc_adpt)
 		return dev_err_probe(dev, -EPROBE_DEFER, "Failed to get ddc i2c adapter by node\n");
 
-	ret = devm_add_action_or_reset(dev, mtk_hdmi_put_device, &hdmi->ddc_adpt->dev);
+	ret = devm_add_action_or_reset(dev, mtk_hdmi_put_adapter, hdmi->ddc_adpt);
 	if (ret)
 		return ret;
 
-- 
2.54.0

