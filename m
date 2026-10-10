Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78053CA9EBE
	for <dri-devel@archiver.kernel.org>; Sat, 10 Oct 2026 11:56:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D074210E5AD;
	Sat, 10 Oct 2026 11:55:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="X+OgdG3S";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79D9C10E5AD
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 11:55:58 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48c4d870d54so311280f8f.2
 for <dri-devel@lists.freedesktop.org>; Sat, 10 Oct 2026 04:55:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791633357; x=1792238157; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=43ruj8IeJ4ezmcyRP7zHp0NyJpifJG+F6EwmlXQyVkw=;
 b=X+OgdG3SCDPx+JDC3dueylxzbRNBy9cIJRrU4Nl6Z/qH6JbA8BAlUc/kqx42JQTjS1
 AmAlQ+372NcZp/zI5dAVLKa+XOgmlexH2gcIqrYVWYaMxRBVecXxyCFBta0OLqIhOguB
 68iEA656FQD1ZlDTLAHMPNtMXIt2b36Ji4pxtBRDwC65RZ8tupIzCRNXm36Gl9LXDRgz
 kwXJM34fmiAvICFtKD8TVa2YoqqHVk38CiuXPUDL775evvIHpFx7hNev+Bu/UOaQ3Z+C
 XJCkIATUG4wzrf3ZEiaeGKJ5Qit20rMT/jJLch9Qt06NUPoCgWdpVJp/sHsSdcKrJaey
 Ga4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791633357; x=1792238157;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=43ruj8IeJ4ezmcyRP7zHp0NyJpifJG+F6EwmlXQyVkw=;
 b=pwFbsau5SzGtIUBTClSS2Px2xklVoZZ7lyb9gJQ288uO+fkZkTJLm4tJ1LZdHFnPai
 eIS8nRO8rPCRHbRDLm8vLraJbKU1/+WNrWnVBckLvZpiMwayluvLSdLwQDWP75SV7CLw
 yTeUnUlTuEHLSIvoaYelpViuTF1D357iWWFVy2KqbTZfHfqyfoMoXiPMIcuAYPgXnHy3
 HmgHGXGseCoy/KHRI/PPqtsSJTL4dWVmfF7F/fXjJN80zv7N9d1buS2WspNW20oepBL9
 +7SD0irdnNLHLarSsaz9BWZ/SHViw+2XHrka6FQHd1obNoXoI65tcoPEOSBuXp7DCzxn
 sXzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxcXfEk7mc09l53R6p2Pdemn2DQ7Peb8SrmySztasL9343JBy2SSy8sfWloLiAJTVD3iAYIFgTIwO0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKHtKtKL9qmfhlXKh0xTMyRK34vNmjAwdEg6ODhKaBCO7Z+H5L3
 orTTIjQzpkcg8X6lcDCHnANDuVswUTJn59Upj2dPTDXRL/8rw4EltkK/
X-Gm-Gg: AYBFou2QNsiEH2Fi5mVZOe13PZJCSL14kOziNsTDI+UdSR7fsgsLpZMag+5LTPYJF6P
 mYb+6PD9lOvEO5qE4Vnyk110IjDeogUd40WNppapEMQJKTZcQUH8swi+cP1MGJvC9JMEkSgbzd6
 x6BPVxrGotoobx9pJgYpDorOZNdj4wTWzzqv7jpZoXNQXyEMWxP/x1n5wgwS1r+lep+nxMOJJof
 v3uk/aTzaldLI8Hfm/ksrNNWtmvV3WJCBrPqunRJ0JFEx7i3IB/fM2Plo21ahM/9OTbDCtscTn+
 LqjTIMQa8/16PQOMCI/BsvhE7rnnn68DxtXjkBung+hPPIgT7B/NNM04PqTcHQo05TfiInPOAn3
 hsTeooVP1Lq5imDWKbee6Ti3TMFmog5IfFrFPm7uNiS1juhoNtoa4xNgkrCMIi4lpggYgTTuIt5
 eVm8H7vhgQadVGlGR5Pco66f01Cd58w4dcqDuGxMyd/yYsYEUSkJ82RQ8fJY2/ZiOE1g==
X-Received: by 2002:a5d:5f89:0:b0:488:8850:50ec with SMTP id
 ffacd0b85a97d-48dbacef19fmr9267461f8f.46.1791633356722; 
 Sat, 10 Oct 2026 04:55:56 -0700 (PDT)
Received: from luca-vm.lan ([154.61.61.58]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9aca657sm8746340f8f.43.2026.10.10.04.55.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 04:55:56 -0700 (PDT)
From: Luca Leonardo Scorcia <l.scorcia@gmail.com>
To: linux-mediatek@lists.infradead.org
Cc: Luca Leonardo Scorcia <l.scorcia@gmail.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>, Vinod Koul <vkoul@kernel.org>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
 Jerome Brunet <jbrunet+clk@baylibre.com>,
 Chun-Kuang Hu <chunkuang.hu@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Chen-Yu Tsai <wenst@chromium.org>,
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Fabien Parent <fparent@baylibre.com>, CK Hu <ck.hu@mediatek.com>,
 chunhui dai <chunhui.dai@mediatek.com>,
 linux-arm-kernel@lists.infradead.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-clk@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: [PATCH 2/7] phy: mediatek: hdmi: Add support for mt8167
Date: Sat, 10 Oct 2026 13:54:02 +0200
Message-ID: <20261010115539.9237-3-l.scorcia@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261010115539.9237-1-l.scorcia@gmail.com>
References: <20261010115539.9237-1-l.scorcia@gmail.com>
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

Add support for the HDMI PHY found in MediaTek mt8167.

Signed-off-by: Luca Leonardo Scorcia <l.scorcia@gmail.com>
---
 drivers/phy/mediatek/Makefile              |   1 +
 drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c | 217 +++++++++++++++++++++
 drivers/phy/mediatek/phy-mtk-hdmi.c        |   3 +
 drivers/phy/mediatek/phy-mtk-hdmi.h        |   1 +
 4 files changed, 222 insertions(+)
 create mode 100644 drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c

diff --git a/drivers/phy/mediatek/Makefile b/drivers/phy/mediatek/Makefile
index ed0da708759b..25ede986a1f3 100644
--- a/drivers/phy/mediatek/Makefile
+++ b/drivers/phy/mediatek/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_PHY_MTK_XFI_TPHY)		+= phy-mtk-xfi-tphy.o
 
 phy-mtk-hdmi-drv-y			:= phy-mtk-hdmi.o
 phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt2701.o
+phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt8167.o
 phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt8173.o
 phy-mtk-hdmi-drv-y			+= phy-mtk-hdmi-mt8195.o
 obj-$(CONFIG_PHY_MTK_HDMI)		+= phy-mtk-hdmi-drv.o
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c b/drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c
new file mode 100644
index 000000000000..2435054d4e17
--- /dev/null
+++ b/drivers/phy/mediatek/phy-mtk-hdmi-mt8167.c
@@ -0,0 +1,217 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "phy-mtk-hdmi.h"
+#include "phy-mtk-io.h"
+
+#define HDMI_CON0	0x00
+#define RG_HDMITX_DRV_IBIAS		GENMASK(5, 0)
+#define RG_HDMITX_EN_SER		GENMASK(15, 12)
+#define RG_HDMITX_EN_SLDO		GENMASK(19, 16)
+#define RG_HDMITX_EN_PRED		GENMASK(23, 20)
+#define RG_HDMITX_EN_IMP		GENMASK(27, 24)
+#define RG_HDMITX_EN_DRV		GENMASK(31, 28)
+
+#define HDMI_CON1	0x04
+#define RG_HDMITX_PRED_IBIAS		GENMASK(21, 18)
+#define RG_HDMITX_PRED_IMP		BIT(22)
+#define RG_HDMITX_DRV_IMP		GENMASK(31, 26)
+
+#define HDMI_CON2	0x08
+#define RG_HDMITX_EN_TX_CKLDO		BIT(0)
+#define RG_HDMITX_EN_TX_POSDIV		BIT(1)
+#define RG_HDMITX_TX_POSDIV		GENMASK(4, 3)
+#define RG_HDMITX_EN_MBIAS		BIT(6)
+#define RG_HDMITX_MBIAS_LPF_EN		BIT(7)
+
+#define HDMI_CON4	0x10
+#define RG_HDMITX_D0_IMP		GENMASK(7, 0)
+#define RG_HDMITX_D1_IMP		GENMASK(15, 8)
+#define RG_HDMITX_D2_IMP		GENMASK(23, 16)
+
+#define HDMI_CON6	0x18
+#define RG_HTPLL_BR			GENMASK(1, 0)
+#define RG_HTPLL_BC			GENMASK(3, 2)
+#define RG_HTPLL_BP			GENMASK(7, 4)
+#define RG_HTPLL_IR			GENMASK(11, 8)
+#define RG_HTPLL_IC			GENMASK(15, 12)
+#define RG_HTPLL_POSDIV			GENMASK(17, 16)
+#define RG_HTPLL_PREDIV			GENMASK(19, 18)
+#define RG_HTPLL_FBKSEL			GENMASK(21, 20)
+#define RG_HTPLL_RLH_EN			BIT(22)
+#define RG_HTPLL_FBKDIV			GENMASK(30, 24)
+#define RG_HTPLL_EN			BIT(31)
+
+#define HDMI_CON7	0x1c
+#define RG_HTPLL_AUTOK_EN		BIT(23)
+#define RG_HTPLL_DIVEN			GENMASK(30, 28)
+
+static int mtk_hdmi_pll_prepare(struct clk_hw *hw)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+	void __iomem *base = hdmi_phy->regs;
+
+	mtk_phy_set_bits(base + HDMI_CON7, RG_HTPLL_AUTOK_EN);
+	mtk_phy_clear_bits(base + HDMI_CON6, RG_HTPLL_RLH_EN);
+	mtk_phy_set_bits(base + HDMI_CON6, RG_HTPLL_POSDIV);
+	mtk_phy_set_bits(base + HDMI_CON2, RG_HDMITX_EN_MBIAS);
+	usleep_range(80, 100);
+	mtk_phy_set_bits(base + HDMI_CON6, RG_HTPLL_EN);
+	mtk_phy_set_bits(base + HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
+	mtk_phy_set_bits(base + HDMI_CON0, RG_HDMITX_EN_SLDO);
+	usleep_range(80, 100);
+	mtk_phy_set_bits(base + HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
+	mtk_phy_set_bits(base + HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
+
+	return 0;
+}
+
+static void mtk_hdmi_pll_unprepare(struct clk_hw *hw)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+	void __iomem *base = hdmi_phy->regs;
+
+	mtk_phy_clear_bits(base + HDMI_CON2, RG_HDMITX_EN_TX_POSDIV);
+	mtk_phy_clear_bits(base + HDMI_CON2, RG_HDMITX_MBIAS_LPF_EN);
+	usleep_range(80, 100);
+	mtk_phy_clear_bits(base + HDMI_CON0, RG_HDMITX_EN_SLDO);
+	mtk_phy_clear_bits(base + HDMI_CON2, RG_HDMITX_EN_TX_CKLDO);
+	mtk_phy_clear_bits(base + HDMI_CON6, RG_HTPLL_EN);
+	usleep_range(80, 100);
+	mtk_phy_clear_bits(base + HDMI_CON2, RG_HDMITX_EN_MBIAS);
+	mtk_phy_clear_bits(base + HDMI_CON6, RG_HTPLL_POSDIV);
+	mtk_phy_clear_bits(base + HDMI_CON6, RG_HTPLL_RLH_EN);
+	mtk_phy_clear_bits(base + HDMI_CON7, RG_HTPLL_AUTOK_EN);
+	usleep_range(80, 100);
+}
+
+static int mtk_hdmi_pll_determine_rate(struct clk_hw *hw,
+				       struct clk_rate_request *req)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	hdmi_phy->pll_rate = req->rate;
+
+	return 0;
+}
+
+static int mtk_hdmi_pll_set_rate(struct clk_hw *hw, unsigned long rate,
+				 unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+	void __iomem *base = hdmi_phy->regs;
+	u32 pos_div;
+	u32 pre_imp_en = 0x0;
+	u32 pre_ibias = 0xd;
+	u32 imp_en = 0x0;
+	u32 imp_clk = 0x1c;
+	u32 imp_d0 = 0x1c;
+	u32 imp_d1 = 0x1c;
+	u32 imp_d2 = 0x1c;
+	u32 drv_ibias = 0xa;
+
+	if (rate <= 27000000)
+		pos_div = 3;
+	else if (rate <= 74250000)
+		pos_div = 2;
+	else
+		pos_div = 1;
+
+	mtk_phy_set_bits(base + HDMI_CON6, RG_HTPLL_PREDIV);
+	mtk_phy_set_bits(base + HDMI_CON6, RG_HTPLL_POSDIV);
+	mtk_phy_update_bits(base + HDMI_CON6,
+			    RG_HTPLL_IC | RG_HTPLL_IR,
+			    FIELD_PREP(RG_HTPLL_IC, 0x1) |
+			    FIELD_PREP(RG_HTPLL_IR, 0x1));
+	mtk_phy_update_field(base + HDMI_CON2, RG_HDMITX_TX_POSDIV, pos_div);
+	mtk_phy_update_field(base + HDMI_CON6, RG_HTPLL_FBKSEL, 1);
+	mtk_phy_update_field(base + HDMI_CON6, RG_HTPLL_FBKDIV, 19);
+	mtk_phy_update_field(base + HDMI_CON7, RG_HTPLL_DIVEN, 0x2);
+	mtk_phy_update_bits(base + HDMI_CON6,
+			    RG_HTPLL_BP | RG_HTPLL_BC | RG_HTPLL_BR,
+			    FIELD_PREP(RG_HTPLL_BP, 0xc) |
+			    FIELD_PREP(RG_HTPLL_BC, 0x2) |
+			    FIELD_PREP(RG_HTPLL_BR, 0x1));
+
+	mtk_phy_update_field(base + HDMI_CON1, RG_HDMITX_PRED_IMP, pre_imp_en);
+	mtk_phy_update_field(base + HDMI_CON1, RG_HDMITX_PRED_IBIAS, pre_ibias);
+	mtk_phy_update_field(base + HDMI_CON0, RG_HDMITX_EN_IMP, imp_en);
+	mtk_phy_update_field(base + HDMI_CON1, RG_HDMITX_DRV_IMP, imp_clk);
+	mtk_phy_update_bits(base + HDMI_CON4,
+			    RG_HDMITX_D0_IMP | RG_HDMITX_D1_IMP | RG_HDMITX_D2_IMP,
+			    FIELD_PREP(RG_HDMITX_D0_IMP, imp_d0) |
+			    FIELD_PREP(RG_HDMITX_D1_IMP, imp_d1) |
+			    FIELD_PREP(RG_HDMITX_D2_IMP, imp_d2));
+	mtk_phy_update_field(base + HDMI_CON0, RG_HDMITX_DRV_IBIAS, drv_ibias);
+
+	return 0;
+}
+
+static unsigned long mtk_hdmi_pll_recalc_rate(struct clk_hw *hw,
+					      unsigned long parent_rate)
+{
+	struct mtk_hdmi_phy *hdmi_phy = to_mtk_hdmi_phy(hw);
+
+	unsigned long out_rate, val;
+	u32 tmp;
+
+	tmp = readl(hdmi_phy->regs + HDMI_CON6);
+	val = FIELD_GET(RG_HTPLL_PREDIV, tmp);
+	switch (val) {
+	case 0x00:
+		out_rate = parent_rate;
+		break;
+	case 0x01:
+		out_rate = parent_rate / 2;
+		break;
+	default:
+		out_rate = parent_rate / 4;
+		break;
+	}
+
+	val = FIELD_GET(RG_HTPLL_FBKDIV, tmp);
+	out_rate *= (val + 1) * 2;
+
+	tmp = readl(hdmi_phy->regs + HDMI_CON2);
+	val = FIELD_GET(RG_HDMITX_TX_POSDIV, tmp);
+	out_rate >>= val;
+
+	if (tmp & RG_HDMITX_EN_TX_POSDIV)
+		out_rate /= 5;
+
+	return out_rate;
+}
+
+static const struct clk_ops mtk_hdmi_phy_pll_ops = {
+	.prepare = mtk_hdmi_pll_prepare,
+	.unprepare = mtk_hdmi_pll_unprepare,
+	.set_rate = mtk_hdmi_pll_set_rate,
+	.determine_rate = mtk_hdmi_pll_determine_rate,
+	.recalc_rate = mtk_hdmi_pll_recalc_rate,
+};
+
+static void mtk_hdmi_phy_enable_tmds(struct mtk_hdmi_phy *hdmi_phy)
+{
+	void __iomem *base = hdmi_phy->regs;
+
+	mtk_phy_set_bits(base + HDMI_CON0,
+			 RG_HDMITX_EN_DRV | RG_HDMITX_EN_PRED | RG_HDMITX_EN_SER);
+	usleep_range(80, 100);
+}
+
+static void mtk_hdmi_phy_disable_tmds(struct mtk_hdmi_phy *hdmi_phy)
+{
+	void __iomem *base = hdmi_phy->regs;
+
+	mtk_phy_clear_bits(base + HDMI_CON0,
+			   RG_HDMITX_EN_DRV | RG_HDMITX_EN_PRED | RG_HDMITX_EN_SER);
+	usleep_range(80, 100);
+}
+
+struct mtk_hdmi_phy_conf mtk_hdmi_phy_8167_conf = {
+	.flags = CLK_SET_RATE_PARENT | CLK_SET_RATE_GATE,
+	.hdmi_phy_clk_ops = &mtk_hdmi_phy_pll_ops,
+	.hdmi_phy_enable_tmds = mtk_hdmi_phy_enable_tmds,
+	.hdmi_phy_disable_tmds = mtk_hdmi_phy_disable_tmds,
+};
+
+MODULE_DESCRIPTION("MediaTek HDMI PHY Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.c b/drivers/phy/mediatek/phy-mtk-hdmi.c
index 52a7d525ff9b..4e167a421f0e 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.c
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.c
@@ -186,6 +186,9 @@ static const struct of_device_id mtk_hdmi_phy_match[] = {
 	{ .compatible = "mediatek,mt2701-hdmi-phy",
 	  .data = &mtk_hdmi_phy_2701_conf,
 	},
+	{ .compatible = "mediatek,mt8167-hdmi-phy",
+	  .data = &mtk_hdmi_phy_8167_conf,
+	},
 	{ .compatible = "mediatek,mt8173-hdmi-phy",
 	  .data = &mtk_hdmi_phy_8173_conf,
 	},
diff --git a/drivers/phy/mediatek/phy-mtk-hdmi.h b/drivers/phy/mediatek/phy-mtk-hdmi.h
index 99d917e0036a..5137d1c3345b 100644
--- a/drivers/phy/mediatek/phy-mtk-hdmi.h
+++ b/drivers/phy/mediatek/phy-mtk-hdmi.h
@@ -49,6 +49,7 @@ struct mtk_hdmi_phy {
 struct mtk_hdmi_phy *to_mtk_hdmi_phy(struct clk_hw *hw);
 
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8195_conf;
+extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8167_conf;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_8173_conf;
 extern struct mtk_hdmi_phy_conf mtk_hdmi_phy_2701_conf;
 
-- 
2.43.0

