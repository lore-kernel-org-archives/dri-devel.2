Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E36DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:32:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2AB510E905;
	Mon, 13 Jul 2026 11:32:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="R74e1uH0";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 258AC10E905
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 11:32:17 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-848882fdb18so2129538b3a.0
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 04:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783942337; x=1784547137; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bQ5YkObDJn3q5yEXBMbpydhpxp/loGCG/PfQF+sLSPI=;
 b=R74e1uH0KeBQtNG/YabQOSd3yU00aplrZ4eIOAI6Jjo/IPk4afLBqnL5zaicm9rMAQ
 i+YQO7CF5aQVV+Q/uZF9Ze7/lZPjgRzpucYnxiCVX0+O9RxOn9KULZaMIcWcUTW+CzoR
 kOozIkJsIlzlkKzmvordxVMhmqjtuJ+I/Y9cVLuNBcclOQOH4XMNkBigoj792CBH0ypC
 olvLvIkEiU/b8KS5IW4AenYRffsPPSJxEC93UHY9Smz+xqdkCcWOpnNOeBZJby9PpKVq
 QrPWtvIPVWlzRevh974fttlDidGZ0wAKhHzePYqvTxLAKkAtziez3JPC3mUskHd6GXI9
 Dc9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783942337; x=1784547137;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bQ5YkObDJn3q5yEXBMbpydhpxp/loGCG/PfQF+sLSPI=;
 b=aIKEXGx6CwdWLMDdfNjqQ+WcnWxZlgu37GkdWYBhT8jCYy63LKVu72JXipcIDxTzwj
 q9LXlXYcfsLmqZNlrAP4+auP25Ipisx9Q2hoNArTlJno4Bu1qScOH9ex+ugfoWHR+7Jl
 vvT32hppAj/t/rGsph1/wQqd5GBEAoyOrxKtunlnWSMVq/2ftT29nz3WsrJU4U58aPZy
 qohBMS9MUOfLClrL4V6eR1m/Zkj3vIZ3ohM2NDjy8TjQUscumXCb/MshMQGUEYpuose/
 y4N5oapNe905JFD8q28Qb85BQYJ7SxFTgQWp3ZuSwAvhWn1oqrUl1rz0ASxm4hS/sMs0
 LcNg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrkBu7musB7OERQOeQ7TIVOOosrT6vcxNPI+xQEbDO7a0IbeKKGPjcZBBMF6VNxoEiF48XqdzqSg/o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxRHPqnRTiTxBKlwd1QF66EJPUT1U/YrOwfmoBkr+o2isdhDiOl
 aU4usU2qpccN9pdKEO2oHoBYKy34AF8/LI7F7SZ29GPesuqeS1jcWU9o
X-Gm-Gg: AfdE7ckeeGZuhcb3AKWSN7xiF3dQfHw6ABFgcPHjGp2A/hiiIbY28Y6p7awhkcW589c
 /AiVVGlcpmWDRibe3+7vHyMabj31oZxcR8PNbdxDQnjFmqB5ikz9ImzjXgJSrfDG7t9gh9FxPQG
 aQzgru5wlEsfusq916SaoANXeoWvhT/N3BgHo5hehNjNai/b5nnBI443ukf+fYfquI1RFDnSiON
 T2bYo9IbRf2GHSKIcySVRUzVlgvhvEBBFFzAuLXymRbzcvyEQq8N+RHpdXx8Lt9d++KQjT7BQE8
 5VOWCEV90V5We9PlohV6jBs0SM/+wyLLBu47jcFYrlUx+eKH155qi02spDDBwEyDkaIjLs5T9Uw
 Rb1NTqiwvWu8ej08cByntkkFFHFnN/c3mzbyztj/3Vkve9KmhZFJ+9OJDRR5V8EhewzYe8rg=
X-Received: by 2002:a05:6a00:18aa:b0:845:d286:1fa8 with SMTP id
 d2e1a72fcca58-84889768958mr8641367b3a.55.1783942336528; 
 Mon, 13 Jul 2026 04:32:16 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84880a4abf1sm4318802b3a.16.2026.07.13.04.32.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 04:32:16 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>,
 Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>,
 dri-devel@lists.freedesktop.org, linux-mediatek@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Johan Hovold <johan@kernel.org>, Guangshuo Li <lgs201920130244@gmail.com>,
 stable@vger.kernel.org
Subject: [PATCH v3] drm/mediatek: mtk_hdmi: Fix DDC adapter double put in v2
Date: Mon, 13 Jul 2026 19:29:57 +0800
Message-ID: <20260713112957.884640-1-lgs201920130244@gmail.com>
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
Reviewed-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v3:
  - Add Reviewed-by tag from Johan Hovold.
  - No code changes.

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

