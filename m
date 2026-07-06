Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C79D6C43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 01:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0E2C710E2BF;
	Mon,  6 Jul 2026 01:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bjst6UU9";
	dkim-atps=neutral
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com
 [209.85.210.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EFB3B10E2BF
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 01:55:50 +0000 (UTC)
Received: by mail-pf1-f179.google.com with SMTP id
 d2e1a72fcca58-847a69ba83dso1911626b3a.2
 for <dri-devel@lists.freedesktop.org>; Sun, 05 Jul 2026 18:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783302950; x=1783907750; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=hc+/IIfPHTQ5W3C46gmAKHbZoREmTGGCL3gylifCnJk=;
 b=bjst6UU9BbCIzmZK8lGeS3rTufF2qxGrTdFrQOCzTtkq5wjO/I04xgwmvVJ/YC9YPE
 btfh72T9N8PGjx4uk+DzTbMAnEoQoSqlLX0qMTxLCu14sHVLaJRudHp8FoEs3/Q4hOfa
 6LCtLB4JAkCvdf/eartkztFET6UUSzgjCLi7IrLbXrlUU0gz8nC1HEgLLgvusMCHBEmA
 rhEBz//oAqA/wEGKyEukYQCujASRx+S+jZEE3KVjVhdn5LPsOAHcKMN3S7Zp/G1mrCbp
 deoUoI04wG9vAQQwPQK25D4f6VBnOcRQgOgyk6uGpxheo+qhjNStpBPd5ISeplTSUMCs
 qf/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783302950; x=1783907750;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hc+/IIfPHTQ5W3C46gmAKHbZoREmTGGCL3gylifCnJk=;
 b=fKoj4N1GPehoWWoLPF5mUJEEmBKW8aTgoELlVEJ07u9Auc7SJyzzd3R5oTRK7Yc7Yt
 gLTn4Pt9zftkTs7nYW5EHjxLRBOgPmEkwvgIblvA1wlqwDjRLH2J6qFBUp+yzMcN19fK
 z9c5h6AjknU7e9SbpOimUsfUo9mw5h88PthY4jJfwLdrJMl7dJQLKFYit94oftzoXHoP
 PHYza4/w+T0phcse5LFwmIqIPolbx45GP1mlEDaSOAX8izCpX7X0yor4Uq4w46S4Fc85
 isUQLT4MMnPSXL0oUf+3hjsTGAIJnWKR6rOAaOoRL7QoDTKXfy4W/telKXPlFWLM8bA0
 uB9A==
X-Forwarded-Encrypted: i=1;
 AHgh+RoS2vKe4bCEZ+R+nIx5RJrGVWaFSmZDKhLDJwxi8D/Fw9dORB7/XOruN3DZI1OrVuPCZnt2VziFpbc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxFHUdtWAmPgfL/2rC29scXUoDDst8lvneTN6lxvY3vtckTY/Zg
 4IecCanfDBsQuk60tN5He9CWIjHVdTx+AhJ42OXDwjHF4GBnsx++m3go
X-Gm-Gg: AfdE7cn56gwBvh5Sq36G531YXT3DKsJ9nsB+xaViFjprWHxJXuJODLGsRB08j2QhcxV
 pflqe51hnVZyHZtcvdyxSROOHXZw56rM2IKoipkv3zE6+z/gJtGZNZdvTPn14Wd6G4YUKC+d8db
 XTVtlyjMz0f+ZZKEaUfJtUxidOHh4USG67iA3YURZ5bl/M4bSkFKuRBYqAZxEkj/t56u4wWKYt/
 CAeAHijGV5EJvxxO1kdEjvzJRGMKp26DFJFGDznFxItl99e1yPHQYpRaYGjSMT0o98QjJLYhQLI
 NEfolklRCQUEzE3GeYwWWSML7UOx5LJz88OaIVbWEtOCFbmapr+LXs63b98G77RQf1LI8bdg+mO
 kJndvAnpoSgwxcQYMnRGicYhkhnvc8GQE1QVwhwz6sW3TytgQQr0XyatZIlZ/S4mGBJ+iwwXaOZ
 1NQZI=
X-Received: by 2002:a05:6a00:2d23:b0:845:bcf0:118 with SMTP id
 d2e1a72fcca58-847f6f55a19mr7186973b3a.41.1783302950430; 
 Sun, 05 Jul 2026 18:55:50 -0700 (PDT)
Received: from lgs.. ([101.36.107.181]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-847f6b96c04sm2832348b3a.22.2026.07.05.18.55.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 05 Jul 2026 18:55:49 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2
Date: Mon,  6 Jul 2026 09:55:07 +0800
Message-ID: <20260706015507.453222-1-lgs201920130244@gmail.com>
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

mtk_hdmi_common_probe() gets the DDC adapter with
of_find_i2c_adapter_by_node() and registers a devm action to release the
adapter device reference with put_device().

The HDMI v2 remove callback also calls i2c_put_adapter() on the same DDC
adapter. This is not paired with of_find_i2c_adapter_by_node(): it drops
the adapter device reference before the devm action drops it again, and
it also puts a module reference that was never taken.

Remove the extra i2c_put_adapter() call and drop the now-empty HDMI v2
remove callback. The common devm action releases the adapter device
reference.

Fixes: 8d0f79886273 ("drm/mediatek: Introduce HDMI/DDC v2 for MT8195/MT8188")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Drop the empty remove callback, as suggested by Johan Hovold.
  - Mention that i2c_put_adapter() also drops a module reference that was
    never taken.
  - Fix the Fixes tag.
  - Add Cc stable.

 drivers/gpu/drm/mediatek/mtk_hdmi_v2.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
index 7bbf463056c9..ffe456238a2b 100644
--- a/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
+++ b/drivers/gpu/drm/mediatek/mtk_hdmi_v2.c
@@ -1499,13 +1499,6 @@ static int mtk_hdmi_v2_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static void mtk_hdmi_v2_remove(struct platform_device *pdev)
-{
-	struct mtk_hdmi *hdmi = platform_get_drvdata(pdev);
-
-	i2c_put_adapter(hdmi->ddc_adpt);
-}
-
 static const struct of_device_id mtk_drm_hdmi_v2_of_ids[] = {
 	{ .compatible = "mediatek,mt8188-hdmi-tx", .data = &mtk_hdmi_conf_mt8188 },
 	{ .compatible = "mediatek,mt8195-hdmi-tx", .data = &mtk_hdmi_conf_mt8195 },
@@ -1515,7 +1508,6 @@ MODULE_DEVICE_TABLE(of, mtk_drm_hdmi_v2_of_ids);
 
 static struct platform_driver mtk_hdmi_v2_driver = {
 	.probe = mtk_hdmi_v2_probe,
-	.remove = mtk_hdmi_v2_remove,
 	.driver = {
 		.name = "mediatek-drm-hdmi-v2",
 		.of_match_table = mtk_drm_hdmi_v2_of_ids,
-- 
2.43.0

