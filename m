Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3107C982DF
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 17:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 053C210E734;
	Fri, 18 Sep 2026 17:57:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ddAvyPKl";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF74010E215
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 17:57:52 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48434392b02so795679f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 10:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789754271; x=1790359071; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4ylMW2foaHNEjV+ZwE7Us38p2iYChzzws4mregGYupM=;
 b=ddAvyPKlL2sov8J9codcLqCtzEWFM1ECK+O8iy328d5uAvGPI6qxAg4d7IiDg7zGFF
 i3c9/IgtBUEjwdMOKGOMttZsU8v2pe9pPVUlUjJcQFrFb0BPwGpvSTbScpsvo6ta7Y2J
 DWbjSOjmdExPVSpP0nzhg9LiVn47418V3r5tqrNuEVrTjU0z7xOdGv1fFqpMA9pQRxxw
 Gzr7/pGNvzvFdgW2DO3R7qix9CXi3d0FDSsvoYxT/unzNT07asjWllxlhWMktk4mVVNZ
 T6dRdjNo5FiFP4S1FjTjeeQS39DfEiWtr7l03ZLAOWn4EOfdVQeDmMhrNZpKwBvjTeaQ
 Pa3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789754271; x=1790359071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=4ylMW2foaHNEjV+ZwE7Us38p2iYChzzws4mregGYupM=;
 b=V4q7nDmOMHpOPahROYdCW3Yy7WbSWyPTbkSIqF1LaFRej2BYytvGKp0UmHIqZQQ9AI
 s7N5uZaN3Oz7zCCfkkBQjVzry2FIdXbFvEesANlrwf3xjcH5/bQ3pJ9zMwk/2shqJOVp
 7Xsg4yvvOBFo3bPnldN0TuxN8t5/a6vmIr8XuRN2bNAo9xeLIwSzIDwz/z/B3Djk1Oih
 lBMcpvxQU3qDs31SuUv1sY7IfrWSTBYcn71o61frp5xM8kvzBpL2KrezTkggtffVrL5C
 tHE/ysB2+pEP/9IQ5De7d6kwflLRTaNmQtF5EgcaTcjo3FBFtDpkoP7/kyRL5ah9FCOh
 V+Aw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxwQGWqanCkR0mxwiADf3OF/s6dtloxS7A17EBLnc9EcCBz8S4I/+Q+rNGrIxACItD4XJzcKyzYVK4=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kca0tkEptFwL0EGO0z8ICtg0wJ06Svgn3IWCCiMEj4ajVi0A4q
 e+aFYg41OWLFbwJyAZON5+9YfzWycZ4lbYFWcq3Gnzw4nhtsivMC3sxw
X-Gm-Gg: AYBFou3c8F+T5/jf5RP+O9ihzMEefkeemIC0P7cDtwzEMPyycuyyAMB6t1MXlD6DkjC
 hCAj6j/ysJtnkL9LjHmDntevkMN8MazYGZD8VDcE5qLPYObq/jhohIlbHGF5KJwgq7qP9VRorKS
 cQT/4pNvBVK44ekGcdKlhM7OgHzY4Nohwz6opA2js15GBFDHkPFb80YwwMCQxNiz8gAO/4vtQ9J
 TFFhQdIyerZL76xAYffm7NpcwNL1Ra21tk/B++mF4Fm1pa2ow07nbT1z4M6yAyrxctfp4vnIcv1
 kE6ncRn6iaR5iDlEl01Tf6FEcS3RRQRg2v+WotFSbsFFif9iXRLT69B3EnF6Sl1dyy9V+xHtyBT
 /wM+0cXEhrSATiBjcN/w+de6IY51AAPoRZnS7yTkFIZSdvapT5jNdiKxcaA/Bq84a2n5WUlp7Ux
 lpGYWcLHP9MXUA8whhH7/r0fMSLvchhL8LzLjEqU6EPz6LRs+M0MNeROuHp8rVJRKIqLc=
X-Received: by 2002:a5d:584c:0:b0:486:f45a:57a7 with SMTP id
 ffacd0b85a97d-4871e264829mr7609614f8f.16.1789754271218; 
 Fri, 18 Sep 2026 10:57:51 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48724562aebsm268461f8f.14.2026.09.18.10.57.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 10:57:50 -0700 (PDT)
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
Subject: [PATCH 3/4] soc: mediatek: mt8167-mmsys: add routes for all display
 paths
Date: Fri, 18 Sep 2026 19:55:27 +0200
Message-ID: <20260918175736.355305-4-l.scorcia@gmail.com>
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

mt8167 display output pipeline can be configured in many different ways.
Add support for additional routes according to the SoC data sheet and
Android sources. There's a few inconsistencies between those two, but
assume the Android sources are correct since they are required to drive
HDMI output via DPI1.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/soc/mediatek/mt8167-mmsys.h | 183 ++++++++++++++++++++++++++--
 1 file changed, 174 insertions(+), 9 deletions(-)

diff --git a/drivers/soc/mediatek/mt8167-mmsys.h b/drivers/soc/mediatek/mt8167-mmsys.h
index 001379373507..aab1774152c5 100644
--- a/drivers/soc/mediatek/mt8167-mmsys.h
+++ b/drivers/soc/mediatek/mt8167-mmsys.h
@@ -5,35 +5,200 @@
 
 #define MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN	0x030
 #define MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN	0x038
+#define MT8167_DISP_REG_CONFIG_DISP_UFOE_MOUT_EN	0x03c
 #define MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN	0x058
+#define MT8167_DISP_REG_CONFIG_DISP_WDMA0_SEL_IN	0x05c
+#define MT8167_DISP_REG_CONFIG_DISP_UFOE_SEL_IN		0x060
 #define MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN		0x064
+#define MT8167_DISP_REG_CONFIG_DISP_DPI0_SEL_IN		0x068
 #define MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN	0x06c
+#define MT8167_DISP_REG_CONFIG_DISP_RDMA1_SOUT_SEL_IN	0x070
+#define MT8167_DISP_REG_CONFIG_DISP_DPI1_SEL_IN		0x074
+
+#define MT8167_OVL0_MOUT_EN_COLOR0			0x1
+#define MT8167_OVL0_MOUT_EN_WDMA0			0x2
+#define MT8167_OVL0_MOUT_EN_MASK			0x3
 
 #define MT8167_DITHER_MOUT_EN_RDMA0			0x1
+#define MT8167_DITHER_MOUT_EN_UFOE			0x2
+#define MT8167_DITHER_MOUT_EN_WDMA0			0x4
 #define MT8167_DITHER_MOUT_EN_MASK			0x7
 
-#define MT8167_RDMA0_SOUT_DSI0				0x2
-#define MT8167_RDMA0_SOUT_MASK				0x3
+#define MT8167_UFOE_MOUT_EN_DSI0			0x1
+#define MT8167_UFOE_MOUT_EN_DPI0			0x2
+/*
+ * For some reason Android sources and the data sheet don't agree here,
+ * the data sheet has UFOE_MOUT_EN_WDMA0 as 0x4 and does not mention DPI1.
+ */
+#define MT8167_UFOE_MOUT_EN_DPI1			0x4
+#define MT8167_UFOE_MOUT_EN_WDMA0			0x8
+#define MT8167_UFOE_MOUT_EN_MASK			0xF
+
+#define MT8167_COLOR0_SEL_IN_RDMA0			0x0
+#define MT8167_COLOR0_SEL_IN_OVL0			0x1
+#define MT8167_COLOR0_SEL_IN_MASK			0x1
+
+#define MT8167_WDMA0_SEL_IN_OVL0			0x0
+#define MT8167_WDMA0_SEL_IN_DITHER			0x1
+#define MT8167_WDMA0_SEL_IN_UFOE			0x2
+#define MT8167_WDMA0_SEL_IN_MASK			0x3
+
+#define MT8167_UFOE_SEL_IN_RDMA0			0x0
+#define MT8167_UFOE_SEL_IN_DITHER			0x1
+#define MT8167_UFOE_SEL_IN_MASK				0x1
 
+#define MT8167_DSI0_SEL_IN_UFOE				0x0
 #define MT8167_DSI0_SEL_IN_RDMA0			0x1
+#define MT8167_DSI0_SEL_IN_RDMA1			0x2
 #define MT8167_DSI0_SEL_IN_MASK				0x3
 
+#define MT8167_DPI0_SEL_IN_UFOE				0x0
+#define MT8167_DPI0_SEL_IN_RDMA0			0x1
+#define MT8167_DPI0_SEL_IN_RDMA1			0x2
+#define MT8167_DPI0_SEL_IN_MASK				0x3
+
+#define MT8167_DPI1_SEL_IN_UFOE				0x0
+#define MT8167_DPI1_SEL_IN_RDMA0			0x1
+#define MT8167_DPI1_SEL_IN_RDMA1			0x2
+#define MT8167_DPI1_SEL_IN_MASK				0x3
+
+#define MT8167_RDMA0_SOUT_UFOE				0x0
+#define MT8167_RDMA0_SOUT_COLOR0			0x1
+#define MT8167_RDMA0_SOUT_DSI0				0x2
+#define MT8167_RDMA0_SOUT_DPI0				0x3
+/* DPI1 is only defined in Android sources, not in the data sheet */
+#define MT8167_RDMA0_SOUT_DPI1				0x4
+#define MT8167_RDMA0_SOUT_MASK				0x7
+
+#define MT8167_RDMA1_SOUT_DSI0				0x0
+#define MT8167_RDMA1_SOUT_DPI0				0x1
+/* DPI1 is only defined in Android sources, not in the data sheet */
+#define MT8167_RDMA1_SOUT_DPI1				0x2
+#define MT8167_RDMA1_SOUT_MASK				0x3
+
 static const struct mtk_mmsys_routes mt8167_mmsys_routing_table[] = {
+	/* OVL0<->COLOR0 */
 	MMSYS_ROUTE(OVL, 0, COLOR, 0,
-		    MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, OVL0_MOUT_EN_COLOR0,
-		    OVL0_MOUT_EN_COLOR0),
+		    MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, MT8167_OVL0_MOUT_EN_MASK,
+		    MT8167_OVL0_MOUT_EN_COLOR0),
+	MMSYS_ROUTE(OVL, 0, COLOR, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN, MT8167_COLOR0_SEL_IN_MASK,
+		    MT8167_COLOR0_SEL_IN_OVL0),
+
+	/* OVL0<->WDMA0 */
+	MMSYS_ROUTE(OVL, 0, WDMA, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_OVL0_MOUT_EN, MT8167_OVL0_MOUT_EN_MASK,
+		    MT8167_OVL0_MOUT_EN_WDMA0),
+	MMSYS_ROUTE(OVL, 0, WDMA, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN, MT8167_COLOR0_SEL_IN_MASK,
+		    MT8167_WDMA0_SEL_IN_OVL0),
+
+	/* DITHER0 outputs */
 	MMSYS_ROUTE(DITHER, 0, RDMA, 0,
 		    MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN, MT8167_DITHER_MOUT_EN_MASK,
 		    MT8167_DITHER_MOUT_EN_RDMA0),
-	MMSYS_ROUTE(OVL, 0, COLOR, 0,
-		    MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN, COLOR0_SEL_IN_OVL0,
-		    COLOR0_SEL_IN_OVL0),
-	MMSYS_ROUTE(RDMA, 0, DSI, 0,
+	MMSYS_ROUTE(DITHER, 0, UFOE, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN, MT8167_DITHER_MOUT_EN_MASK,
+		    MT8167_DITHER_MOUT_EN_UFOE),
+	MMSYS_ROUTE(DITHER, 0, WDMA, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_DITHER_MOUT_EN, MT8167_DITHER_MOUT_EN_MASK,
+		    MT8167_DITHER_MOUT_EN_WDMA0),
+
+	/* UFOE<->DSI0 */
+	MMSYS_ROUTE(UFOE, 0, DSI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_UFOE_MOUT_EN, MT8167_UFOE_MOUT_EN_MASK,
+		    MT8167_UFOE_MOUT_EN_DSI0),
+	MMSYS_ROUTE(UFOE, 0, DSI, 0,
 		    MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN, MT8167_DSI0_SEL_IN_MASK,
-		    MT8167_DSI0_SEL_IN_RDMA0),
+		    MT8167_DSI0_SEL_IN_UFOE),
+
+	/* UFOE<->DPI0 */
+	MMSYS_ROUTE(UFOE, 0, DPI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_UFOE_MOUT_EN, MT8167_UFOE_MOUT_EN_MASK,
+		    MT8167_UFOE_MOUT_EN_DPI0),
+	MMSYS_ROUTE(UFOE, 0, DPI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_DPI0_SEL_IN, MT8167_DPI0_SEL_IN_MASK,
+		    MT8167_DPI0_SEL_IN_UFOE),
+
+	/* UFOE<->DPI1 */
+	MMSYS_ROUTE(UFOE, 0, DPI, 1,
+		    MT8167_DISP_REG_CONFIG_DISP_UFOE_MOUT_EN, MT8167_UFOE_MOUT_EN_MASK,
+		    MT8167_UFOE_MOUT_EN_DPI1),
+	MMSYS_ROUTE(UFOE, 0, DPI, 1,
+		    MT8167_DISP_REG_CONFIG_DISP_DPI1_SEL_IN, MT8167_DPI1_SEL_IN_MASK,
+		    MT8167_DPI1_SEL_IN_UFOE),
+
+	/* UFOE<->WDMA0 */
+	MMSYS_ROUTE(UFOE, 0, WDMA, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_UFOE_MOUT_EN, MT8167_UFOE_MOUT_EN_MASK,
+		    MT8167_UFOE_MOUT_EN_WDMA0),
+	MMSYS_ROUTE(UFOE, 0, WDMA, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_WDMA0_SEL_IN, MT8167_WDMA0_SEL_IN_MASK,
+		    MT8167_WDMA0_SEL_IN_UFOE),
+
+	/* RDMA0<->UFOE */
+	MMSYS_ROUTE(RDMA, 0, UFOE, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN, MT8167_RDMA0_SOUT_MASK,
+		    MT8167_RDMA0_SOUT_UFOE),
+	MMSYS_ROUTE(RDMA, 0, UFOE, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_UFOE_SEL_IN, MT8167_UFOE_SEL_IN_MASK,
+		    MT8167_UFOE_SEL_IN_RDMA0),
+
+	/* RDMA0->COLOR0 */
+	MMSYS_ROUTE(RDMA, 0, COLOR, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN, MT8167_RDMA0_SOUT_MASK,
+		    MT8167_RDMA0_SOUT_COLOR0),
+	MMSYS_ROUTE(RDMA, 0, COLOR, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_COLOR0_SEL_IN, MT8167_COLOR0_SEL_IN_MASK,
+		    MT8167_COLOR0_SEL_IN_RDMA0),
+
+	/* RDMA0<->DSI0 */
 	MMSYS_ROUTE(RDMA, 0, DSI, 0,
 		    MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN, MT8167_RDMA0_SOUT_MASK,
 		    MT8167_RDMA0_SOUT_DSI0),
+	MMSYS_ROUTE(RDMA, 0, DSI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN, MT8167_DSI0_SEL_IN_MASK,
+		    MT8167_DSI0_SEL_IN_RDMA0),
+
+	/* RDMA0<->DPI0 */
+	MMSYS_ROUTE(RDMA, 0, DPI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN, MT8167_RDMA0_SOUT_MASK,
+		    MT8167_RDMA0_SOUT_DPI0),
+	MMSYS_ROUTE(RDMA, 0, DPI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_DPI0_SEL_IN, MT8167_DPI0_SEL_IN_MASK,
+		    MT8167_DPI0_SEL_IN_RDMA0),
+
+	/* RDMA0<->DPI1 */
+	MMSYS_ROUTE(RDMA, 0, DPI, 1,
+		    MT8167_DISP_REG_CONFIG_DISP_RDMA0_SOUT_SEL_IN, MT8167_RDMA0_SOUT_MASK,
+		    MT8167_RDMA0_SOUT_DPI1),
+	MMSYS_ROUTE(RDMA, 0, DPI, 1,
+		    MT8167_DISP_REG_CONFIG_DISP_DPI1_SEL_IN, MT8167_DPI1_SEL_IN_MASK,
+		    MT8167_DPI1_SEL_IN_RDMA0),
+
+	/* RDMA1<->DSI0 */
+	MMSYS_ROUTE(RDMA, 1, DSI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_RDMA1_SOUT_SEL_IN, MT8167_RDMA1_SOUT_MASK,
+		    MT8167_RDMA1_SOUT_DSI0),
+	MMSYS_ROUTE(RDMA, 1, DPI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_DSI0_SEL_IN, MT8167_DSI0_SEL_IN_MASK,
+		    MT8167_DPI0_SEL_IN_RDMA1),
+
+	/* RDMA1<->DPI0 */
+	MMSYS_ROUTE(RDMA, 1, DPI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_RDMA1_SOUT_SEL_IN, MT8167_RDMA1_SOUT_MASK,
+		    MT8167_RDMA1_SOUT_DPI0),
+	MMSYS_ROUTE(RDMA, 1, DPI, 0,
+		    MT8167_DISP_REG_CONFIG_DISP_DPI0_SEL_IN, MT8167_DPI0_SEL_IN_MASK,
+		    MT8167_DPI0_SEL_IN_RDMA1),
+
+	/* RDMA1<->DPI1 */
+	MMSYS_ROUTE(RDMA, 1, DPI, 1,
+		    MT8167_DISP_REG_CONFIG_DISP_RDMA1_SOUT_SEL_IN, MT8167_RDMA1_SOUT_MASK,
+		    MT8167_RDMA1_SOUT_DPI1),
+	MMSYS_ROUTE(RDMA, 1, DPI, 1,
+		    MT8167_DISP_REG_CONFIG_DISP_DPI1_SEL_IN, MT8167_DPI1_SEL_IN_MASK,
+		    MT8167_DPI1_SEL_IN_RDMA1),
 };
 
 #endif /* __SOC_MEDIATEK_MT8167_MMSYS_H */
-- 
2.43.0

