Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8511C88E48
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 09:21:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF9A710F3CC;
	Thu, 10 Sep 2026 09:21:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="ZF7w/GZG";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C008E10F3BB
 for <dri-devel@lists.freedesktop.org>; Thu, 10 Sep 2026 09:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1789032050;
 bh=wCt+fRXRNJGhOrrdM1gKT+BP+rAjTu+ESd2chmIHmIo=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ZF7w/GZGvALTAvwK3Bl4shzpTFDT6TqvPLOE8IHfJqt00JDTTyqaQmWphCJKT4jyE
 G1UJ1yMRHcFU3AXJ8mhyi4BudDKjTyxP1MMk4N5/A+CPvj4nNNRiW8aU81Xi7hcBbv
 jmCAGKt0MEdG+WRoLP+jHgBEnFb0VnfL3dO1gOcFhbGN7uCKKz4LJ2FNFFLY/lxhhu
 COMrkHNdQHFGpuuo4r+ktd6HwAztG3VWh/ErtWRw0YRG96e32f4bXarLhyjC/m5glz
 2784+oJA55EN6neNWvdRabMPDtiBMoXEW83E2TScztfFxL+i/ZdZvshXq4UyZcTJki
 RFXU4+4jj99sA==
Received: from IcarusMOD.eternityproject.eu (unknown [100.64.1.21])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested) (Authenticated sender: kholk11)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id CA0C217E0945;
 Thu, 10 Sep 2026 11:20:49 +0200 (CEST)
From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: mani@kernel.org
Cc: chunfeng.yun@mediatek.com, vkoul@kernel.org, neil.armstrong@linaro.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
 chunkuang.hu@kernel.org, p.zabel@pengutronix.de, justin.yeh@mediatek.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: [PATCH v4 09/12] phy: phy-mtk-dp: Rewrite and document default
 driving param macros
Date: Thu, 10 Sep 2026 11:20:35 +0200
Message-ID: <20260910092038.48291-10-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
References: <20260910092038.48291-1-angelogioacchino.delregno@collabora.com>
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

Use FIELD_PREP_CONST and add nicer definitions/macros to build the
default driving parameters for the PHY and, while at it, also add
comments explaining what they are supposed to set in the PHY.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/phy/mediatek/phy-mtk-dp.c | 86 +++++++++++++++----------------
 1 file changed, 41 insertions(+), 45 deletions(-)

diff --git a/drivers/phy/mediatek/phy-mtk-dp.c b/drivers/phy/mediatek/phy-mtk-dp.c
index 2f4cf52d922c..8e1fc4e16ba6 100644
--- a/drivers/phy/mediatek/phy-mtk-dp.c
+++ b/drivers/phy/mediatek/phy-mtk-dp.c
@@ -91,51 +91,47 @@
  * [2,5,8]: Swing 2 Pre1 and Swing 3 Pre0
  */
 #define PHYD_DIG_NUM_DRV_PARA_REGS	9
-#define XTP_LN_TX_LCTXC0_SW0_PRE0_DEFAULT	BIT(4)
-#define XTP_LN_TX_LCTXC0_SW0_PRE1_DEFAULT	(BIT(10) | BIT(12))
-#define XTP_LN_TX_LCTXC0_SW0_PRE2_DEFAULT	GENMASK(20, 19)
-#define XTP_LN_TX_LCTXC0_SW0_PRE3_DEFAULT	GENMASK(29, 29)
-#define MT8195_DRIVING_PARAM_3_DEFAULT	(XTP_LN_TX_LCTXC0_SW0_PRE0_DEFAULT | \
-				 XTP_LN_TX_LCTXC0_SW0_PRE1_DEFAULT | \
-				 XTP_LN_TX_LCTXC0_SW0_PRE2_DEFAULT | \
-				 XTP_LN_TX_LCTXC0_SW0_PRE3_DEFAULT)
-
-#define XTP_LN_TX_LCTXC0_SW1_PRE0_DEFAULT	GENMASK(4, 3)
-#define XTP_LN_TX_LCTXC0_SW1_PRE1_DEFAULT	GENMASK(12, 9)
-#define XTP_LN_TX_LCTXC0_SW1_PRE2_DEFAULT	(BIT(18) | BIT(21))
-#define XTP_LN_TX_LCTXC0_SW2_PRE0_DEFAULT	GENMASK(29, 29)
-#define MT8195_DRIVING_PARAM_4_DEFAULT	(XTP_LN_TX_LCTXC0_SW1_PRE0_DEFAULT | \
-				 XTP_LN_TX_LCTXC0_SW1_PRE1_DEFAULT | \
-				 XTP_LN_TX_LCTXC0_SW1_PRE2_DEFAULT | \
-				 XTP_LN_TX_LCTXC0_SW2_PRE0_DEFAULT)
-
-#define XTP_LN_TX_LCTXC0_SW2_PRE1_DEFAULT	(BIT(3) | BIT(5))
-#define XTP_LN_TX_LCTXC0_SW3_PRE0_DEFAULT	GENMASK(13, 12)
-#define MT8195_DRIVING_PARAM_5_DEFAULT	(XTP_LN_TX_LCTXC0_SW2_PRE1_DEFAULT | \
-				 XTP_LN_TX_LCTXC0_SW3_PRE0_DEFAULT)
-
-#define XTP_LN_TX_LCTXCP1_SW0_PRE0_DEFAULT	0
-#define XTP_LN_TX_LCTXCP1_SW0_PRE1_DEFAULT	GENMASK(10, 10)
-#define XTP_LN_TX_LCTXCP1_SW0_PRE2_DEFAULT	GENMASK(19, 19)
-#define XTP_LN_TX_LCTXCP1_SW0_PRE3_DEFAULT	GENMASK(28, 28)
-#define MT8195_DRIVING_PARAM_6_DEFAULT	(XTP_LN_TX_LCTXCP1_SW0_PRE0_DEFAULT | \
-				 XTP_LN_TX_LCTXCP1_SW0_PRE1_DEFAULT | \
-				 XTP_LN_TX_LCTXCP1_SW0_PRE2_DEFAULT | \
-				 XTP_LN_TX_LCTXCP1_SW0_PRE3_DEFAULT)
-
-#define XTP_LN_TX_LCTXCP1_SW1_PRE0_DEFAULT	0
-#define XTP_LN_TX_LCTXCP1_SW1_PRE1_DEFAULT	GENMASK(10, 9)
-#define XTP_LN_TX_LCTXCP1_SW1_PRE2_DEFAULT	GENMASK(19, 18)
-#define XTP_LN_TX_LCTXCP1_SW2_PRE0_DEFAULT	0
-#define MT8195_DRIVING_PARAM_7_DEFAULT	(XTP_LN_TX_LCTXCP1_SW1_PRE0_DEFAULT | \
-				 XTP_LN_TX_LCTXCP1_SW1_PRE1_DEFAULT | \
-				 XTP_LN_TX_LCTXCP1_SW1_PRE2_DEFAULT | \
-				 XTP_LN_TX_LCTXCP1_SW2_PRE0_DEFAULT)
-
-#define XTP_LN_TX_LCTXCP1_SW2_PRE1_DEFAULT	GENMASK(3, 3)
-#define XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT	0
-#define MT8195_DRIVING_PARAM_8_DEFAULT	(XTP_LN_TX_LCTXCP1_SW2_PRE1_DEFAULT | \
-				 XTP_LN_TX_LCTXCP1_SW3_PRE0_DEFAULT)
+#define XTP_LN_TX_LCTXC_SW0_PRE0	GENMASK(5, 0)
+#define XTP_LN_TX_LCTXC_SW0_PRE1	GENMASK(13, 8)
+#define XTP_LN_TX_LCTXC_SW0_PRE2	GENMASK(21, 16)
+#define XTP_LN_TX_LCTXC_SW0_PRE3	GENMASK(29, 24)
+
+#define XTP_LN_TX_LCTXC_SW1_PRE0	GENMASK(5, 0)
+#define XTP_LN_TX_LCTXC_SW1_PRE1	GENMASK(13, 8)
+#define XTP_LN_TX_LCTXC_SW1_PRE2	GENMASK(21, 16)
+#define XTP_LN_TX_LCTXC_SW2_PRE0	GENMASK(29, 24)
+
+#define XTP_LN_TX_LCTXC_SW2_PRE1	GENMASK(5, 0)
+#define XTP_LN_TX_LCTXC_SW3_PRE0	GENMASK(13, 8)
+
+#define BUILD_DRIVING_PARAM_0(sw0_pre0, sw0_pre1, sw0_pre2, sw0_pre3) (	\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW0_PRE0, sw0_pre0) |		\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW0_PRE1, sw0_pre1) |		\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW0_PRE2, sw0_pre2) |		\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW0_PRE3, sw0_pre3)		\
+)
+
+#define BUILD_DRIVING_PARAM_12(sw1_pre0, sw1_pre1, sw1_pre2, sw2_pre0) (\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW1_PRE0, sw1_pre0) |		\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW1_PRE1, sw1_pre1) |		\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW1_PRE2, sw1_pre2) |		\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW2_PRE0, sw2_pre0)		\
+)
+
+#define BUILD_DRIVING_PARAM_23(sw2_pre1, sw3_pre0) (			\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW2_PRE1, sw2_pre1) |		\
+	FIELD_PREP_CONST(XTP_LN_TX_LCTXC_SW3_PRE0, sw3_pre0)		\
+)
+
+/* MT8195: Logic State Change Point (LC TX C) */
+#define MT8195_DRIVING_PARAM_3_DEFAULT	BUILD_DRIVING_PARAM_0( 16, 20, 24, 32)
+#define MT8195_DRIVING_PARAM_4_DEFAULT	BUILD_DRIVING_PARAM_12(24, 30, 36, 32)
+#define MT8195_DRIVING_PARAM_5_DEFAULT	BUILD_DRIVING_PARAM_23(40, 48)
+
+/* MT8195: Positive Edge (LC TX CP) */
+#define MT8195_DRIVING_PARAM_6_DEFAULT	BUILD_DRIVING_PARAM_0( 0, 4, 8, 16)
+#define MT8195_DRIVING_PARAM_7_DEFAULT	BUILD_DRIVING_PARAM_12(0, 6, 12, 0)
+#define MT8195_DRIVING_PARAM_8_DEFAULT	BUILD_DRIVING_PARAM_23(8, 0)
 
 enum mtk_dp_phya_ana_glb_regidx {
 	DP_PHYA_GLB_BIAS_GEN_0,
-- 
2.55.0

