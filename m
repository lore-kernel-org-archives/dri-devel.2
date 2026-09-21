Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658A3C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 11:39:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AE35B10E39D;
	Mon, 21 Sep 2026 11:39:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OGYYIYbr";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26CB10E39D
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 11:39:30 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49e79a408deso15980015e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 04:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789990769; x=1790595569; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h4/riDOncgRUhzR5epGdXHOZl5OnvQAmiqOQ7MptE7w=;
 b=OGYYIYbrlv334BfQARyJOoI0oJyhxNnrSOE44NjDHTQAEm9EPcDKjWH/tjZg/Q3wK7
 8D+4cwuU72RsojJeUcGafvVjRQ7EOtBw2gA12ElNlHl7gTcoxdbysGBcPdLXiEWAuBqK
 nkgk0RIcKhr2CrGbh8Ts/t0VWgBwEmJWnS77gpi67f6B9rv0/7IrUQJ24q1NYbPPgrbo
 kf+UxDPxNhAWPuHlhtHuKA33qK44fYL3vxtl8AA/E3QGidK8wIENYjxjAFIaTZhFpxmp
 TznYg9/45pn3HygLtGQsgHx4eizPQU3elXEw78gLVwQJAWkpVZH67/1FSQEZCrIk8+Y5
 Gw7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789990769; x=1790595569;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h4/riDOncgRUhzR5epGdXHOZl5OnvQAmiqOQ7MptE7w=;
 b=mxqW2RkUb+87EHzUM3DqgnaIGTW86G55MbigdmSlT/nb3R88n5inioKteW7tBWFs4M
 4uhkiBlrUIPzrYiySNfJs0Bj24vCxybpapq/9lpWJKvoFg3+dnV2rQii1sbSdRnvzEaB
 zaDAB+jRbv3ddqiZObDWUdDiZmwLJiAfTQC+56Amj6lFzT5JR02JRwXSYAEzckZ/98sU
 1IGSGB0+myILIFYIgaRRLVtvXdj6wsoVHEEpdF59hu4uJZdzvD1Be2OZGFb4V5eISGsD
 /K6rrFGLhjJY72xDT2fvYZXXXuNALy8BedP1SBCufo985mXruvNeZegBVVD1Fuf8Jwvs
 5peA==
X-Forwarded-Encrypted: i=1;
 AKwUvBy/Gc1Epg9mGL1OBSsW47OgezLoe2g4gtaShspLpiCKOoG7edF86eAeiuNMrI4K8oWS8+50tLRhKV8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k0urrj23NeCXyLov4U6V/dJhYVDygynaH9Jzxiz4uO3aY0O8yI
 lAHU9/gWX1c3ziVsgb2aRSed8fKH62uRcTAu8CV2FfZZbvAG6YgFpsw2
X-Gm-Gg: AYBFou1Rmqopstn8ELU5bUN0RpOQ1zMDTE3SD/eiWoJK+P9QjeZaYBMqpYUr8vRUPb2
 rMlocWLIfTx02yG6w6v+JsVazAdfV5Mtb9casFCiTHhp5F5b8dVxDC0MPOLY7ty0ZkXq43R4N4e
 aojADK73PZpv0e2PjZvF7CYzAU42ZMR4Q3dWyv0indE+IaDHwU4tOOrgKlROGhpnlZnhQz+3iJd
 JkYqnbVooR8mYvbDfHgn9pCvf/uGFn9DngZRohMbdUuLOqAH1wqpUkHc2NTOhgy8x5JgO+lJfiu
 u/d29AgthwBzOcbBK9TFR0G8n/67jNoOJipkYS2hdH9qVofWfdasztonnVKlsRrZ0Msv4Nqlh9D
 SioVsDE0z3IZonQ7ay5Xu5T00jb/isp/k+VvfDU1eTk9yx34AlLZT6bmPBsltVd4uxgGSVseBpB
 O6cLzU5v+27rDr+fqsiZF5Y9BEFdNcG7IBIcE9KgEWL6kgTWM0IlJctFhD4G5RlO86WfE=
X-Received: by 2002:a05:600c:46cf:b0:49c:de80:b833 with SMTP id
 5b1f17b1804b1-49fc5687b6cmr156358075e9.2.1789990769221; 
 Mon, 21 Sep 2026 04:39:29 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fc57547easm244273865e9.3.2026.09.21.04.39.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Sep 2026 04:39:28 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>, CK Hu <ck.hu@mediatek.com>,
 Jitao shi <jitao.shi@mediatek.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v2 2/4] drm/mediatek: Add support for mt8167 Digital Parallel
 Interface
Date: Mon, 21 Sep 2026 13:38:56 +0200
Message-ID: <20260921113914.779393-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921113914.779393-1-l.scorcia@gmail.com>
References: <20260921113914.779393-1-l.scorcia@gmail.com>
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
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
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

