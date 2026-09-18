Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9A29C982DE
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:57:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 335B510E215;
	Fri, 18 Sep 2026 17:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FywDz79p";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FE0410E215
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:57:51 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48434392b02so795656f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789754269; x=1790359069; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MOpF21qwCYtkBPyOZB6nIIWOi6wwbvKg9f2XgINcd2A=;
 b=FywDz79pMvAKMTWmDToCe3/hRY8D7MhnCMq+naxrmhV/Cmp9rbBwEq8tEr3CmLx+x3
 IFe1NEBXbJWuAxP3xKK00vDTHv2sBnhTVAwiStu9e69wJYdUDk8dcxl2Cdm1TyDOBQF/
 4KSWOzMenTUoiZ9grGbhEIy44xeXtAnr6v0BulDKBMumo5Zlt/raXEfiBZ2ntL67aT2H
 qs7a0Qpc+uTR5j2QK878/r5Vtcb4qgwZPLMz2gExNirV0sx4iWYIA7zvrOoFjNis5/5H
 EeSUgHbZYRQ6jYwCAiDpLeZKuynlfiBkGe99f1KLbn7vzdyv9+NGgUq/lUyA3qwyVinr
 qAQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789754269; x=1790359069;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MOpF21qwCYtkBPyOZB6nIIWOi6wwbvKg9f2XgINcd2A=;
 b=11wENbZZUN7gJeERpVEVqoQOUJTp+GpyZ9/QWml/c64o/njiviKevUNI9HP+cF5VeS
 p78RshEWJw05MQe2bdFnwkCUV9FMEjv7hgeENGSI0E83ab52+MRDGV/vfUCvjLaJc96t
 /fRWvRyhPU41y7EGSiRYzQbhMR6el8I7+HLiBMYK0GjYPjY7mK1dpMgP4wqadeDIdUqj
 wSQ/nRZNYaCFqXiTgcdVD3pd8p3tdzip1ABhaz3WrB95To/RGU5YqjJYIgn5gHODepbs
 YmzJoYIZrT5m8wtzs3v4hwSvLYR0SLsyjKQ5SDPEmQzFPVtI/OMnP3ub0SP8fuSXS455
 u4Sg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw1p4H20bsASnMAb77RYiJ6hazvsYeNw6I4AwInhuEvLqHAJGWr7U1Zu9LstO6Ao1V8QjPFa2slJ1E=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nsXpuu3MKx7xwajy8NN96KtBIq0ZNVnc0WOYTXe9M5tFiz5kHM
 MrpWgamscIsCfRls0M1FIir9SlO6RI1MLKKLw1IaOKD34bRw0ELZnOuL
X-Gm-Gg: AYBFou19nSpzOpWOp7Erx1rfnY85CQcN+8d0396+RCZPVXpWPj5izbKAP+BeUm7RQaK
 5Le3ABCwqGF6SsVuoiLjbtWGCCaGwf3IFhJCbWpv1ohACnwWpTdWpBCxUEpQmCbBXZ6Ms0GSu0n
 StrMJOJSgrLPo2xsrWyerFHrPbdlolaRhv2abrc5Rhxa/nLuYO4NuQ/sw0K4QHiFN0l9Fv3dV4d
 c0/d3At4fJlRCwBHfSNYAODAmK3uICAaY9Px1LPsyV54ovuF5wA3KoHqJk0tpxNxlSWQYrZSwFB
 u2B0Kp8tAdk1xvvwwo/rGflzMLF2191A5uFpVgOIuqvx8iZF6D2B0msaJxG5MTL8NQUwYF50HFK
 6cEzIgSuI9JbnVdhWxVXSls2VobeifjRwviq9wbYBqYg3ubhbZaxTkRgK5FlpDafgRHhzfr106i
 fYkiRhXYi9LhMvn8WauBYdegSc5JHE4McFlTPWmI/HZVRbxom3XPpONvFjcRt8O2GSJhgYE0Yfg
 scZ1A==
X-Received: by 2002:a05:6000:40c8:b0:487:403:f2eb with SMTP id
 ffacd0b85a97d-4871e263f5dmr9591011f8f.17.1789754269490; 
 Fri, 18 Sep 2026 10:57:49 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724562aebsm268461f8f.14.2026.09.18.10.57.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 10:57:49 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 CK Hu <ck.hu@mediatek.com>, Jitao shi <jitao.shi@mediatek.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH 2/4] drm/mediatek: Add support for mt8167 Digital Parallel
 Interface
Date: Fri, 18 Sep 2026 19:55:26 +0200
Message-ID: <20260918175736.355305-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918175736.355305-1-l.scorcia@gmail.com>
References: <20260918175736.355305-1-l.scorcia@gmail.com>
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

Add support for the two DPI blocks found in the mt8167 SoCs. One of them
can be routed to a DPI connector and another is directly connected to the
HDMI IP.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/gpu/drm/mediatek/mtk_dpi.c     | 23 +++++++++++++++++++++++
 drivers/gpu/drm/mediatek/mtk_drm_drv.c |  2 ++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/mediatek/mtk_dpi.c b/drivers/gpu/drm/mediatek/mtk_dpi.c
index 0e4f430de983..9012adeb63d0 100644
--- a/drivers/gpu/drm/mediatek/mtk_dpi.c
+++ b/drivers/gpu/drm/mediatek/mtk_dpi.c
@@ -1114,6 +1114,10 @@ static const struct mtk_dpi_factor dpi_factor_mt2701[] = {
 	{ 64000, 4 }, { 128000, 2 }, { U32_MAX, 1 }
 };
 
+static const struct mtk_dpi_factor dpi_factor_mt8167[] = {
+	{ 64000, 16 }, { 74250, 8 }, { 160000, 4 }, { U32_MAX, 2 }
+};
+
 static const struct mtk_dpi_factor dpi_factor_mt8173[] = {
 	{ 27000, 48 }, { 84000, 24 }, { 167000, 12 }, { U32_MAX, 6 }
 };
@@ -1163,6 +1167,24 @@ static const struct mtk_dpi_conf mt2701_conf = {
 	.csc_enable_bit = CSC_ENABLE,
 };
 
+static const struct mtk_dpi_conf mt8167_conf = {
+	.dpi_factor = dpi_factor_mt8167,
+	.num_dpi_factor = ARRAY_SIZE(dpi_factor_mt8167),
+	.reg_h_fre_con = 0xe0,
+	.max_clock_khz = 150000,
+	.output_fmts = mt8173_output_fmts,
+	.num_output_fmts = ARRAY_SIZE(mt8173_output_fmts),
+	.pixels_per_iter = 1,
+	.is_ck_de_pol = true,
+	.swap_input_support = true,
+	.support_direct_pin = true,
+	.dimension_mask = HPW_MASK,
+	.hvsize_mask = HSIZE_MASK,
+	.channel_swap_shift = CH_SWAP,
+	.yuv422_en_bit = YUV422_EN,
+	.csc_enable_bit = CSC_ENABLE,
+};
+
 static const struct mtk_dpi_conf mt8183_conf = {
 	.dpi_factor = dpi_factor_mt8183,
 	.num_dpi_factor = ARRAY_SIZE(dpi_factor_mt8183),
@@ -1342,6 +1364,7 @@ static void mtk_dpi_remove(struct platform_device *pdev)
 
 static const struct of_device_id mtk_dpi_of_ids[] = {
 	{ .compatible = "mediatek,mt2701-dpi", .data = &mt2701_conf },
+	{ .compatible = "mediatek,mt8167-dpi", .data = &mt8167_conf },
 	{ .compatible = "mediatek,mt8173-dpi", .data = &mt8173_conf },
 	{ .compatible = "mediatek,mt8183-dpi", .data = &mt8183_conf },
 	{ .compatible = "mediatek,mt8186-dpi", .data = &mt8186_conf },
diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index c86a3f54f35b..64c87221d931 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -802,6 +802,8 @@ static const struct of_device_id mtk_ddp_comp_dt_ids[] = {
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8167-dsi",
 	  .data = (void *)MTK_DSI },
+	{ .compatible = "mediatek,mt8167-dpi",
+	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8173-dpi",
 	  .data = (void *)MTK_DPI },
 	{ .compatible = "mediatek,mt8183-dpi",
-- 
2.43.0

