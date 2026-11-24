Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1800B606A688
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 08:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kPGNsxVu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4D83710FA24;
	Wed, 25 Nov 2026 08:43:16 +0000 (UTC)
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3206610F037
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 19:18:33 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so48762335e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 11:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795547911; x=1796152711; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=btIIoQSK3yJVM75CjWoJylr23lyCewWzNYbOJNHPOoM=;
 b=kPGNsxVuILrLgcxMUayYYywLmscWpUIwcqRoxGsj19w5x8/fx82B1aY/d3gRFNg8UL
 IrESdoptaaVGacptKt0n+UysU5b59iFMQUKpHezBOURDaAuiv3lbIPuLVCYlbVSdaRvQ
 tmyzT+RKLwIkEGXbQsdFNn75Vx9w2UCUGx6lBSPJLB56zKbKVn3EdhihpL5+sV91nv58
 cbXB0Rfrg4sSpsqRnUBr9vSAzrzk9GTIIdy89Y86jxPh8CwmTsjLQmrNcQDFkbn5Z45q
 Bo9us6KahUwnuXbuSrqX3RljJirb375X2auZ06zwLapzfhq6ifTsAT/vpeTSgxE3duL1
 bN4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795547911; x=1796152711;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=btIIoQSK3yJVM75CjWoJylr23lyCewWzNYbOJNHPOoM=;
 b=2OVZ8TJtz3Q56ygsWqVbXd3LEs2dWOf2aAsyX6kRQ+tkVa9Dlph+5avU3FC7vPYBwV
 vDYMgBomYKNp/nlT1tH+HgjQYmhxu2mPNE7nK1+ZwJPd7iNDHJe1LLGzbnwYyUz3cJo3
 oMpofvxqWB8P90Zsl8qx200saPWMQPhN8wCUumG72VM0u/Qjqxhlw3GWjlSIYUz9l7lK
 FlvoVURZQbTiGVuIxjaDqJCr/vQB/KUdoeSIePVb9JKa2I6653Ho9rDntN1zmb1PsQGG
 MYFM7FuiqX2C9A5xLy8iycEtIZMYUrHuoOeiIfl+bFbtTkZYzpPVhbd9gUk0bHLY9d73
 Gvxw==
X-Gm-Message-State: APuU4Z8yl5GoAqMPhgPmFNePgc61o5900Rfsm5kPlcrJ4x9COt7G/WnE
 /COOwXLNd4zHr8mO8781ZQFY2Gf9FSIul4nuQraN+1Px+PFeq5aOeLM=
X-Gm-Gg: AZFdTZcBuR9gTNCkebCR/nNHna1un5SKFH4Ga9f0VWF05qUeOdW8b5Z6s3D5Ic4xov5
 Ln2PXiyRGXQh29YJjfqpV+7Ez4oQXDfmMap/2f3S0secsR/qJfuSYi7/f9UM51Xh0tLH6wUy970
 0U8gP7jIs0v2EMx3tkxYberowHtnEPzIh5xDUg/7aE+3KQVsbH52orTLwDCS3657SgLJYdYnmif
 ws1ivNd/pdRkpdMXEEyHTkRk9qF3l2/7HsMCmFJIJqBqjJgOgHOx3s7+aNfp3aCmkaw/8QdbthF
 emnUSOz/LEI42fNqT1Uz777PdQekmgoHhIyG+rMmPWMgUgoJpTy/odi98RKBS+pXB7d6/zTCXkZ
 cAlxrmRFi8Y6HNNvarD3X3pcpSPNWIEaiOjVJKNBBftmgtjRvtSYX192pDHQR81V1NfLivqH/5+
 5cPP1nm11jwMZbb/tTVhrbQkWPRHoe5EmYb1VTrrGYXS94ZjANruJFHm7VzJq1eCl9DnktqV9Lw
 jgs+9VaohTae1Y6qWXucOYVTdSA05ncSaS82JKK0iHiNmPPJnmYY1lIdltinauMzh3xAKJmntMN
 5aMpOEURLF5yllKeGmP48qUbmsLGSPBTX6U2AtuzrKmfWGQ8IImY
X-Received: by 2002:a05:600c:a08b:b0:4bb:6651:9eda with SMTP id
 5b1f17b1804b1-4bb88922ca4mr301151895e9.14.1795547911130; 
 Tue, 24 Nov 2026 11:18:31 -0800 (PST)
Received: from localhost.localdomain ([93.145.31.94])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884c3063sm463320985e9.15.2026.11.24.11.18.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 11:18:30 -0800 (PST)
From: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Dmitry Baryshkov <lumag@kernel.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
Subject: [PATCH 2/2] drm/bridge: Add Lontium LT9721 HDMI to eDP bridge driver
Date: Tue, 24 Nov 2026 20:18:03 +0100
Message-Id: <20261124191803.283266-3-gianfranco.mariotti94@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261124191803.283266-1-gianfranco.mariotti94@gmail.com>
References: <20261124191803.283266-1-gianfranco.mariotti94@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 25 Nov 2026 08:41:18 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a DRM bridge driver for the Lontium LT9721 HDMI 1.4 to 1/2/4-lane
eDP 1.4 bridge chip.

The driver supports:
- Atomic DRM bridge chain integration (DRM_BRIDGE_ATTACH_NO_CONNECTOR)
- DP AUX channel registration (Native AUX for DPCD and I2C-over-AUX for
  EDID) with DP AUX bus panel population via
  devm_of_dp_aux_populate_bus()
- 1-, 2-, and 4-lane eDP 1.4 link training at RBR (1.62 Gbps) and HBR
  (2.7 Gbps) with per-lane voltage swing and pre-emphasis adjustment
- HDMI 1.4 RX CDR, adaptive equalization, PLL lock, and RGB/YCbCr
  format handling
- Standard OF graph data-lanes and lane-polarities remapping on RX and
  TX ports, plus power supply and reset sequencing

Signed-off-by: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>
---
 MAINTAINERS                             |    1 +
 drivers/gpu/drm/bridge/Kconfig          |   16 +
 drivers/gpu/drm/bridge/Makefile         |    1 +
 drivers/gpu/drm/bridge/lontium-lt9721.c | 1640 +++++++++++++++++++++++
 4 files changed, 1658 insertions(+)
 create mode 100644 drivers/gpu/drm/bridge/lontium-lt9721.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 707cd862d4fc4..02c09f82ef829 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15796,6 +15796,7 @@ L:	dri-devel@lists.freedesktop.org
 S:	Maintained
 T:	git https://gitlab.freedesktop.org/drm/misc/kernel.git
 F:	Documentation/devicetree/bindings/display/bridge/lontium,lt9721.yaml
+F:	drivers/gpu/drm/bridge/lontium-lt9721.c
 
 LOONGARCH
 M:	Huacai Chen <chenhuacai@kernel.org>
diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index c7da6b02d7b6b..ed35dacbb740b 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -191,6 +191,22 @@ config DRM_LONTIUM_LT9611UXC
 	  HDMI signals
 	  Please say Y if you have such hardware.
 
+config DRM_LONTIUM_LT9721
+	tristate "Lontium LT9721 HDMI/eDP bridge"
+	depends on OF
+	select DRM_DISPLAY_DP_AUX_BUS
+	select DRM_DISPLAY_DP_HELPER
+	select DRM_DISPLAY_HELPER
+	select DRM_KMS_HELPER
+	select DRM_PANEL_BRIDGE
+	select REGMAP_I2C
+	help
+	  Driver for Lontium LT9721 HDMI 1.4 to eDP 1.4 bridge chip.
+	  Please say Y if you have such hardware.
+
+	  Say M here if you want to support this hardware as a module.
+	  The module will be named "lontium-lt9721".
+
 config DRM_LONTIUM_LT8713SX
 	tristate "Lontium LT8713SX DP MST bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 15cc821d85b7e..b23d6e3c76fa0 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -17,6 +17,7 @@ obj-$(CONFIG_DRM_LONTIUM_LT8912B) += lontium-lt8912b.o
 obj-$(CONFIG_DRM_LONTIUM_LT9211) += lontium-lt9211.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611) += lontium-lt9611.o
 obj-$(CONFIG_DRM_LONTIUM_LT9611UXC) += lontium-lt9611uxc.o
+obj-$(CONFIG_DRM_LONTIUM_LT9721) += lontium-lt9721.o
 obj-$(CONFIG_DRM_LONTIUM_LT8713SX) += lontium-lt8713sx.o
 obj-$(CONFIG_DRM_LVDS_CODEC) += lvds-codec.o
 obj-$(CONFIG_DRM_MEGACHIPS_STDPXXXX_GE_B850V3_FW) += megachips-stdpxxxx-ge-b850v3-fw.o
diff --git a/drivers/gpu/drm/bridge/lontium-lt9721.c b/drivers/gpu/drm/bridge/lontium-lt9721.c
new file mode 100644
index 0000000000000..582e9e59dfb4d
--- /dev/null
+++ b/drivers/gpu/drm/bridge/lontium-lt9721.c
@@ -0,0 +1,1640 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 SECO S.p.A.
+ *
+ * Lontium LT9721 HDMI 1.4 to eDP 1.4 bridge driver
+ */
+
+#include <linux/bits.h>
+#include <linux/delay.h>
+#include <linux/gpio/consumer.h>
+#include <linux/i2c.h>
+#include <linux/iopoll.h>
+#include <linux/media-bus-format.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+
+#include <drm/display/drm_dp_aux_bus.h>
+#include <drm/display/drm_dp_helper.h>
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_atomic_state_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_connector.h>
+#include <drm/drm_crtc.h>
+#include <drm/drm_edid.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_print.h>
+#include <drm/drm_probe_helper.h>
+
+#define LT9721_REG_PAGE_CONTROL		0xff
+
+/* Page 0x60: Chip ID, Clock Gating & Soft Resets */
+#define LT9721_REG_CHIP_ID0		0x6000
+#define LT9721_CHIP_ID0			0x16
+#define LT9721_REG_CHIP_ID1		0x6001
+#define LT9721_CHIP_ID1			0x06
+#define LT9721_REG_CLK_EN3		0x6007
+#define LT9721_REG_SW_RST_RX0		0x601b
+#define LT9721_REG_SW_RST_RX1		0x601c
+#define LT9721_REG_SW_RST_RX2		0x601d
+#define LT9721_REG_SW_RST_TXPLL		0x601e
+#define LT9721_REG_SW_RST_FIFO		0x601f
+
+/* Page 0x70: Analog HDMI RX PHY, TX PLL, DP TX PHY & AUX PHY */
+#define LT9721_REG_RXPLL_CTRL0		0x7016
+#define LT9721_REG_RXPLL_CTRL2		0x7018
+#define LT9721_REG_RXPLL_CTRL3		0x7019
+#define LT9721_REG_RXPLL_CTRL4		0x701a
+
+#define LT9721_REG_TXPLL_ANA0		0x701c
+#define LT9721_REG_TXPLL_ANA1		0x701d
+#define LT9721_REG_TXPLL_ANA2		0x701e
+#define LT9721_REG_TXPLL_ANA3		0x701f
+
+#define LT9721_REG_DPTX_PHY_EN		0x7021
+#define LT9721_REG_DPTX_LANE01_CTRL	0x7022
+#define LT9721_REG_DPTX_LANE23_CTRL	0x7023
+#define LT9721_REG_DPTX_SWING(phy)	(0x7024 + 2 * (phy))
+#define LT9721_REG_DPTX_PREEMPH(phy)	(0x7025 + 2 * (phy))
+#define LT9721_REG_DPTX_RTERM_CAL	0x702c
+
+#define LT9721_REG_DPAUX_PHY0		0x702f
+#define LT9721_REG_DPAUX_PHY1		0x7030
+#define LT9721_REG_DPAUX_PHY2		0x7031
+#define LT9721_REG_GPIO_PU_PD		0x7042
+#define LT9721_REG_GPIO_MODE		0x7044
+#define LT9721_GPIO7_MODE_BIT		BIT(7)
+#define LT9721_REG_TYPEC_PHY_MODE	0x7048
+
+/* Page 0x80: Link Config, Interrupts, DP AUX & GPIO */
+#define LT9721_REG_LINK_BW		0x8002
+#define LT9721_REG_LINK_LANE_CNT	0x8003
+#define LT9721_LINK_SCRAMBLER_DIS	BIT(7)
+#define LT9721_LINK_TRAIN_SOFT_EN	BIT(6)
+#define LT9721_REG_LINK_ENHANCED	0x8004
+#define LT9721_LINK_ENHANCED_FRAME	BIT(4)
+#define LT9721_REG_LINK_PTN_TYPE	0x8005
+
+#define LT9721_REG_INT_FLAG0		0x8008
+#define LT9721_INT0_AUX_NAT_DONE	BIT(7)
+#define LT9721_INT0_AUX_TIMEOUT		BIT(4)
+#define LT9721_REG_INT_MSK0		0x8010
+#define LT9721_REG_INT_CLR0		0x8018
+
+#define LT9721_REG_AUX_STATUS		0x8025
+#define LT9721_AUX_REPLY_DET		BIT(3)
+#define LT9721_AUX_REP_NAT_ACK		BIT(2)
+#define LT9721_AUX_REP_NAT_NACK		BIT(1)
+#define LT9721_AUX_REP_NAT_DEFER	BIT(0)
+#define LT9721_REG_AUX_TIMEOUT		0x8026
+#define LT9721_AUX_TIMEOUT_FLAG		BIT(7)
+#define LT9721_REG_AUX_SOFT_MODE	0x802a
+#define LT9721_AUX_SOFT_EN		BIT(0)
+#define LT9721_REG_AUX_SOFT_FIFO	0x802b
+#define LT9721_REG_AUX_SOFT_SEND	0x802c
+#define LT9721_REG_AUX_NAT_RDATA	0x802d
+#define LT9721_REG_AUX_RX_CNT		0x802f
+#define LT9721_AUX_RX_BUF_CNT_MASK	GENMASK(4, 0)
+#define LT9721_REG_AUX_CLK_DIV		0x8030
+#define LT9721_REG_AUX_NAT_ADDR_L	0x8033
+#define LT9721_REG_AUX_NAT_ADDR_M	0x8034
+#define LT9721_REG_AUX_NAT_ADDR_H	0x8035
+#define LT9721_REG_AUX_NAT_CTRL		0x8036
+#define LT9721_AUX_NAT_READ		BIT(7)
+#define LT9721_AUX_NAT_WRBUF_CLR	BIT(5)
+#define LT9721_REG_AUX_NAT_WDATA	0x8037
+#define LT9721_REG_AUX_NAT_SEND		0x8038
+
+#define LT9721_REG_TXPLL_DIG0		0x8040
+#define LT9721_REG_TXPLL_DIG1		0x8041
+#define LT9721_REG_TXPLL_DIG2		0x8042
+#define LT9721_REG_TXPLL_DIG3		0x8043
+#define LT9721_REG_TXPLL_DIG4		0x8044
+#define LT9721_REG_TXPLL_DIG5		0x8045
+#define LT9721_REG_TXPLL_DIG6		0x8046
+#define LT9721_REG_TXPLL_DIG8		0x8048
+#define LT9721_REG_TXPLL_DIG10		0x804a
+#define LT9721_REG_TXPLL_DIG11		0x804b
+
+#define LT9721_REG_HPD_STATUS		0x80b0
+#define LT9721_EDP_HPD_STATUS		BIT(3)
+#define LT9721_REG_GPIO_OUT		0x80d1
+#define LT9721_GPIO7_OUT_BIT		BIT(7)
+#define LT9721_REG_GPIO2_MUX		0x80d3
+#define LT9721_REG_CSC_Y2R		0x80eb
+
+/* Page 0x84: DP Main Link Control */
+#define LT9721_REG_ML_CTRL0		0x8400
+#define LT9721_REG_ML_TRAIN_CTRL	0x8414
+#define LT9721_ML_RDISP_RST_N		BIT(7)
+#define LT9721_ML_NORMAL_TRANS_EN	BIT(6)
+#define LT9721_ML_TPS2_TRANS_EN		BIT(2)
+#define LT9721_ML_TPS1_TRANS_EN		BIT(0)
+#define LT9721_REG_ML_LANE_SWAP		0x8415
+#define LT9721_REG_ML_POL_FIFO		0x8416
+#define LT9721_ML_FIFO_SOFT_RSTZ	GENMASK(3, 0)
+
+/* Page 0x88: Video Processor, MSA & Video Check */
+#define LT9721_REG_VID_PROC0		0x8800
+#define LT9721_REG_VID_HTOTAL_H		0x8805
+#define LT9721_REG_VID_HSTART_H		0x8807
+#define LT9721_REG_VID_HSW_H		0x8809
+#define LT9721_VID_SYNC_ACTIVE_LOW	BIT(15)
+#define LT9721_REG_VID_HWIDTH_H		0x880b
+#define LT9721_REG_VID_VTOTAL_H		0x880d
+#define LT9721_REG_VID_VSTART_H		0x8811
+#define LT9721_REG_VID_VSW_H		0x8813
+#define LT9721_REG_VID_VHEIGHT_H	0x8815
+#define LT9721_REG_VID_PIX_FMT		0x8817
+#define LT9721_REG_VID_MISC0		0x8818
+#define LT9721_REG_VID_MISC1		0x8819
+#define LT9721_REG_VID_MSA_POL_B19	0x881a
+#define LT9721_MSA_SDP_SOFT		BIT(7)
+#define LT9721_MSA_VSPOL_LOW		BIT(5)
+#define LT9721_MSA_HSPOL_LOW		BIT(4)
+#define LT9721_REG_VID_BYTE_LINE_M	0x881b
+#define LT9721_REG_VID_BYTE_LINE_L	0x881c
+#define LT9721_REG_VID_RD_PIXELS	0x881d
+#define LT9721_REG_VID_READY_CTRL	0x881e
+#define LT9721_VID_RDY_SOFT		BIT(5)
+#define LT9721_VID_READY		BIT(4)
+#define LT9721_REG_VID_FIFO_THRESH	0x881f
+#define LT9721_REG_VID_OUT_BYTES	0x8820
+#define LT9721_REG_VID_TU_SIZE		0x8821
+#define LT9721_REG_VID_IDLE_VBID	0x8822
+#define LT9721_REG_VID_TEST_MUX		0x8823
+#define LT9721_REG_CHK_HS_ACT_H		0x8833
+#define LT9721_REG_CHK_SYNC_POL		0x8845
+#define LT9721_CHK_HS_POL_HIGH		BIT(1)
+#define LT9721_CHK_VS_POL_HIGH		BIT(0)
+#define LT9721_REG_VID_SRC_CTRL		0x884b
+#define LT9721_VID_VSYNC_POL_HIGH	BIT(1)
+#define LT9721_REG_VID_BOT_VTOTAL_H	0x884c
+#define LT9721_REG_VID_BOT_VTOTAL_L	0x884d
+
+/* Page 0x90: HDMI RX Digital, CDR, EQ & Packet Status */
+#define LT9721_REG_HMRX_CDR_CFG		0x9005
+#define LT9721_HMRX_CDR_PN_SWAP		BIT(7)
+#define LT9721_REG_HMRX_HPD_CTRL	0x9006
+#define LT9721_HMRX_SOFT_RX_HPD		BIT(3)
+#define LT9721_REG_HMRX_SIG_STAT	0x9013
+#define LT9721_HMRX_HSYNC_DET		BIT(0)
+#define LT9721_REG_HMRX_TMDS_DET	0x9043
+#define LT9721_HMRX_TMDS_CLK_DET	BIT(7)
+#define LT9721_REG_HMRX_TMDS_FREQ_H	0x9044
+#define LT9721_REG_HMRX_AVI_FMT		0x9071
+#define LT9721_HMRX_COLORSPACE_MASK	GENMASK(6, 5)
+#define LT9721_HMRX_CS_RGB		0x00
+#define LT9721_HMRX_CS_YCBCR422		0x20
+#define LT9721_HMRX_CS_YCBCR444		0x40
+
+#define LT9721_MAX_HDMI_CLOCK_KHZ	340000U
+#define LT9721_MIN_HDMI_CLOCK_KHZ	20000U
+#define LT9721_MAX_LANES		4U
+#define LT9721_MAX_CR_TRIES		10
+#define LT9721_MAX_EQ_TRIES		5
+
+/*
+ * On the QFN64 LT9721 package, physical output pins D0..D3 map to internal
+ * DP TX die PHYs {2, 0, 3, 1}.
+ */
+static const u8 lt9721_qfn64_pin_to_phy[LT9721_MAX_LANES] = { 2, 0, 3, 1 };
+
+struct lt9721_drive_cfg {
+	u8 swing;
+	u8 pre_emph;
+};
+
+/* Indexed by [voltage_swing_level 0..3][pre_emphasis_level 0..3] */
+static const struct lt9721_drive_cfg lt9721_drive_table[4][4] = {
+	/* 400 mV */
+	{ { 0x36, 0x00 }, { 0x44, 0x11 }, { 0x51, 0x22 }, { 0x6c, 0x44 } },
+	/* 600 mV */
+	{ { 0x51, 0x00 }, { 0x66, 0x19 }, { 0x7a, 0x33 }, { 0x7a, 0x33 } },
+	/* 800 mV */
+	{ { 0x6c, 0x00 }, { 0x88, 0x22 }, { 0xff, 0x6a }, { 0xff, 0x6a } },
+	/* 1200 mV */
+	{ { 0xa3, 0x00 }, { 0xa3, 0x00 }, { 0xa3, 0x00 }, { 0xa3, 0x00 } },
+};
+
+struct lt9721 {
+	struct device *dev;
+	struct i2c_client *client;
+	struct regmap *regmap;
+
+	struct regulator *vcc;
+	struct regulator *vdd;
+	struct gpio_desc *reset_gpio;
+
+	struct mutex aux_lock; /* Serializes paged AUX register access */
+	struct drm_dp_aux aux;
+
+	struct drm_bridge bridge;
+	bool is_panel;
+
+	u8 data_lanes;
+	u8 active_lanes;
+	u8 link_bw;
+	u8 tx_lane_swap;
+	u8 tx_pol_swap;
+	bool rx_pn_swap;
+};
+
+static const struct regmap_range lt9721_rd_ranges[] = {
+	regmap_reg_range(0xff, 0xff),
+	regmap_reg_range(0x6000, 0x600b),
+	regmap_reg_range(0x6010, 0x6012),
+	regmap_reg_range(0x6019, 0x6020),
+	regmap_reg_range(0x7000, 0x7045),
+	regmap_reg_range(0x7048, 0x7048),
+	regmap_reg_range(0x8002, 0x801f),
+	regmap_reg_range(0x8024, 0x804b),
+	regmap_reg_range(0x8050, 0x806f),
+	regmap_reg_range(0x8074, 0x8089),
+	regmap_reg_range(0x808b, 0x80a5),
+	regmap_reg_range(0x80ab, 0x80c3),
+	regmap_reg_range(0x80c8, 0x80da),
+	regmap_reg_range(0x80e9, 0x80ef),
+	regmap_reg_range(0x8400, 0x8424),
+	regmap_reg_range(0x8500, 0x8509),
+	regmap_reg_range(0x850f, 0x8532),
+	regmap_reg_range(0x8800, 0x8827),
+	regmap_reg_range(0x882c, 0x8845),
+	regmap_reg_range(0x884a, 0x884d),
+	regmap_reg_range(0x8c00, 0x8c0f),
+	regmap_reg_range(0x8c15, 0x8c32),
+	regmap_reg_range(0x8c34, 0x8c34),
+	regmap_reg_range(0x8c36, 0x8c3a),
+	regmap_reg_range(0x8c3e, 0x8c5b),
+	regmap_reg_range(0x8c60, 0x8c65),
+	regmap_reg_range(0x8c67, 0x8c68),
+	regmap_reg_range(0x8c6e, 0x8c6e),
+	regmap_reg_range(0x8c70, 0x8c7b),
+	regmap_reg_range(0x8c80, 0x8c8c),
+	regmap_reg_range(0x8c90, 0x8c90),
+	regmap_reg_range(0x8c94, 0x8c95),
+	regmap_reg_range(0x8ca0, 0x8cbf),
+	regmap_reg_range(0x9000, 0x905a),
+	regmap_reg_range(0x905c, 0x907b),
+	regmap_reg_range(0x907e, 0x908d),
+	regmap_reg_range(0x90a0, 0x90bd),
+	regmap_reg_range(0x90c0, 0x90cf),
+	regmap_reg_range(0x90d2, 0x90fe),
+	regmap_reg_range(0xa001, 0xa005),
+	regmap_reg_range(0xa007, 0xa00c),
+	regmap_reg_range(0xa00e, 0xa00f),
+	regmap_reg_range(0xa016, 0xa017),
+	regmap_reg_range(0xa01a, 0xa02a),
+	regmap_reg_range(0xa02c, 0xa02c),
+	regmap_reg_range(0xa02f, 0xa036),
+	regmap_reg_range(0xa039, 0xa055),
+	regmap_reg_range(0xa060, 0xa078),
+	regmap_reg_range(0xa080, 0xa098),
+};
+
+static const struct regmap_range lt9721_rw_ranges[] = {
+	regmap_reg_range(0xff, 0xff),
+	regmap_reg_range(0x6003, 0x600b),
+	regmap_reg_range(0x6010, 0x6012),
+	regmap_reg_range(0x6019, 0x6020),
+	regmap_reg_range(0x7000, 0x7014),
+	regmap_reg_range(0x7016, 0x702d),
+	regmap_reg_range(0x702f, 0x7045),
+	regmap_reg_range(0x7048, 0x7048),
+	regmap_reg_range(0x8002, 0x8007),
+	regmap_reg_range(0x8010, 0x801f),
+	regmap_reg_range(0x8024, 0x8024),
+	regmap_reg_range(0x8027, 0x802c),
+	regmap_reg_range(0x8030, 0x8038),
+	regmap_reg_range(0x803a, 0x804b),
+	regmap_reg_range(0x8051, 0x806f),
+	regmap_reg_range(0x8074, 0x8076),
+	regmap_reg_range(0x8078, 0x8089),
+	regmap_reg_range(0x808f, 0x8092),
+	regmap_reg_range(0x8094, 0x809f),
+	regmap_reg_range(0x80a1, 0x80a5),
+	regmap_reg_range(0x80ab, 0x80af),
+	regmap_reg_range(0x80c8, 0x80ce),
+	regmap_reg_range(0x80d0, 0x80d4),
+	regmap_reg_range(0x80ea, 0x80ef),
+	regmap_reg_range(0x8400, 0x8424),
+	regmap_reg_range(0x8800, 0x8823),
+	regmap_reg_range(0x8825, 0x8827),
+	regmap_reg_range(0x882c, 0x882d),
+	regmap_reg_range(0x883a, 0x883d),
+	regmap_reg_range(0x884a, 0x884d),
+	regmap_reg_range(0x8c00, 0x8c0f),
+	regmap_reg_range(0x8c15, 0x8c32),
+	regmap_reg_range(0x8c34, 0x8c34),
+	regmap_reg_range(0x8c36, 0x8c3a),
+	regmap_reg_range(0x8c3e, 0x8c5b),
+	regmap_reg_range(0x8ca0, 0x8cbf),
+	regmap_reg_range(0x9005, 0x900e),
+	regmap_reg_range(0x901b, 0x902f),
+	regmap_reg_range(0x9047, 0x905a),
+	regmap_reg_range(0x905c, 0x9062),
+	regmap_reg_range(0x9080, 0x9086),
+	regmap_reg_range(0x90a0, 0x90bd),
+	regmap_reg_range(0x90e4, 0x90fe),
+	regmap_reg_range(0xa001, 0xa005),
+	regmap_reg_range(0xa007, 0xa00c),
+	regmap_reg_range(0xa00e, 0xa00f),
+	regmap_reg_range(0xa016, 0xa017),
+	regmap_reg_range(0xa01a, 0xa02a),
+	regmap_reg_range(0xa02c, 0xa02c),
+	regmap_reg_range(0xa02f, 0xa036),
+	regmap_reg_range(0xa039, 0xa055),
+	regmap_reg_range(0xa060, 0xa078),
+};
+
+static const struct regmap_access_table lt9721_rd_table = {
+	.yes_ranges = lt9721_rd_ranges,
+	.n_yes_ranges = ARRAY_SIZE(lt9721_rd_ranges),
+};
+
+static const struct regmap_access_table lt9721_rw_table = {
+	.yes_ranges = lt9721_rw_ranges,
+	.n_yes_ranges = ARRAY_SIZE(lt9721_rw_ranges),
+};
+
+static const struct regmap_range_cfg lt9721_ranges[] = {
+	{
+		.name = "lt9721-pages",
+		.range_min = 0x0000,
+		.range_max = 0xa098,
+		.selector_reg = LT9721_REG_PAGE_CONTROL,
+		.selector_mask = 0xff,
+		.selector_shift = 0,
+		.window_start = 0x00,
+		.window_len = 0x100,
+	},
+};
+
+static const struct regmap_config lt9721_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &lt9721_rd_table,
+	.wr_table = &lt9721_rw_table,
+	.ranges = lt9721_ranges,
+	.num_ranges = ARRAY_SIZE(lt9721_ranges),
+	.max_register = 0xa098,
+	.cache_type = REGCACHE_NONE,
+};
+
+static inline struct lt9721 *bridge_to_lt9721(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct lt9721, bridge);
+}
+
+static inline struct lt9721 *aux_to_lt9721(struct drm_dp_aux *aux)
+{
+	return container_of(aux, struct lt9721, aux);
+}
+
+static int lt9721_write_u16(struct lt9721 *lt9721, unsigned int reg, u16 val)
+{
+	u8 buf[2] = { val >> 8, val & 0xff };
+
+	return regmap_bulk_write(lt9721->regmap, reg, buf, sizeof(buf));
+}
+
+static void lt9721_hpd_ctrl(struct lt9721 *lt9721, bool assert_hpd)
+{
+	regmap_update_bits(lt9721->regmap, LT9721_REG_GPIO_MODE,
+			   LT9721_GPIO7_MODE_BIT, LT9721_GPIO7_MODE_BIT);
+	regmap_write(lt9721->regmap, LT9721_REG_GPIO_PU_PD, 0x71);
+
+	regmap_update_bits(lt9721->regmap, LT9721_REG_HMRX_HPD_CTRL,
+			   LT9721_HMRX_SOFT_RX_HPD,
+			   assert_hpd ? LT9721_HMRX_SOFT_RX_HPD : 0);
+	regmap_update_bits(lt9721->regmap, LT9721_REG_GPIO_OUT,
+			   LT9721_GPIO7_OUT_BIT,
+			   assert_hpd ? LT9721_GPIO7_OUT_BIT : 0);
+}
+
+static int lt9721_aux_phy_init(struct lt9721 *lt9721)
+{
+	static const struct reg_sequence aux_init_seq[] = {
+		{ LT9721_REG_TYPEC_PHY_MODE, 0x00 },
+		{ LT9721_REG_GPIO2_MUX, 0x00 },
+		{ LT9721_REG_DPAUX_PHY0, 0x70 },
+		{ LT9721_REG_DPAUX_PHY1, 0x24 },
+		{ LT9721_REG_DPAUX_PHY2, 0xfc },
+		{ LT9721_REG_AUX_CLK_DIV, 0x0e },
+		{ LT9721_REG_INT_MSK0, 0x0f },
+	};
+
+	return regmap_multi_reg_write(lt9721->regmap, aux_init_seq,
+				      ARRAY_SIZE(aux_init_seq));
+}
+
+static ssize_t lt9721_aux_transfer_native(struct lt9721 *lt9721,
+					  struct drm_dp_aux_msg *msg)
+{
+	bool is_read = (msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_NATIVE_READ;
+	unsigned int status = 0, timeout = 0, irq_flag = 0, val;
+	u8 *buf = msg->buffer;
+	size_t i;
+	int ret;
+
+	if (msg->size == 0) {
+		msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+		return 0;
+	}
+
+	ret = regmap_write(lt9721->regmap, LT9721_REG_AUX_SOFT_MODE, 0x00);
+	if (ret)
+		return ret;
+
+	/* Clear interrupt latches for Native AUX done / timeout */
+	regmap_write(lt9721->regmap, LT9721_REG_INT_CLR0, 0x0f);
+	regmap_write(lt9721->regmap, LT9721_REG_INT_CLR0, 0xff);
+
+	regmap_write(lt9721->regmap, LT9721_REG_AUX_NAT_ADDR_L,
+		     msg->address & 0xff);
+	regmap_write(lt9721->regmap, LT9721_REG_AUX_NAT_ADDR_M,
+		     (msg->address >> 8) & 0xff);
+	regmap_write(lt9721->regmap, LT9721_REG_AUX_NAT_ADDR_H,
+		     (msg->address >> 16) & 0x0f);
+
+	if (is_read) {
+		regmap_write(lt9721->regmap, LT9721_REG_AUX_NAT_CTRL,
+			     LT9721_AUX_NAT_READ | ((msg->size - 1) & 0x0f));
+	} else {
+		regmap_write(lt9721->regmap, LT9721_REG_AUX_NAT_CTRL,
+			     LT9721_AUX_NAT_WRBUF_CLR);
+		regmap_write(lt9721->regmap, LT9721_REG_AUX_NAT_CTRL,
+			     (msg->size - 1) & 0x0f);
+		for (i = 0; i < msg->size; i++)
+			regmap_write(lt9721->regmap, LT9721_REG_AUX_NAT_WDATA,
+				     buf[i]);
+	}
+
+	ret = regmap_write(lt9721->regmap, LT9721_REG_AUX_NAT_SEND, 0x00);
+	if (ret)
+		return ret;
+
+	fsleep(400);
+
+	for (i = 0; i < 25; i++) {
+		regmap_read(lt9721->regmap, LT9721_REG_INT_FLAG0, &irq_flag);
+		regmap_read(lt9721->regmap, LT9721_REG_AUX_STATUS, &status);
+		regmap_read(lt9721->regmap, LT9721_REG_AUX_TIMEOUT, &timeout);
+
+		if ((irq_flag & (LT9721_INT0_AUX_NAT_DONE |
+				 LT9721_INT0_AUX_TIMEOUT)) ||
+		    (status & LT9721_AUX_REPLY_DET) ||
+		    (timeout & LT9721_AUX_TIMEOUT_FLAG))
+			break;
+
+		fsleep(250);
+	}
+
+	if ((timeout & LT9721_AUX_TIMEOUT_FLAG) ||
+	    (irq_flag & LT9721_INT0_AUX_TIMEOUT))
+		return -ETIMEDOUT;
+
+	if (!(status & LT9721_AUX_REPLY_DET) &&
+	    !(irq_flag & LT9721_INT0_AUX_NAT_DONE))
+		return -ETIMEDOUT;
+
+	if (status & LT9721_AUX_REP_NAT_NACK) {
+		msg->reply = DP_AUX_NATIVE_REPLY_NACK;
+		return 0;
+	}
+
+	if (status & LT9721_AUX_REP_NAT_DEFER) {
+		msg->reply = DP_AUX_NATIVE_REPLY_DEFER;
+		return 0;
+	}
+
+	msg->reply = DP_AUX_NATIVE_REPLY_ACK;
+
+	if (is_read) {
+		for (i = 0; i < msg->size; i++) {
+			ret = regmap_read(lt9721->regmap,
+					  LT9721_REG_AUX_NAT_RDATA, &val);
+			if (ret)
+				return ret;
+			buf[i] = val;
+		}
+	}
+
+	return msg->size;
+}
+
+static void lt9721_aux_drain_soft_fifo(struct lt9721 *lt9721)
+{
+	unsigned int cnt = 0, dummy;
+	int guard = 32;
+
+	while (guard-- > 0) {
+		if (regmap_read(lt9721->regmap, LT9721_REG_AUX_RX_CNT, &cnt))
+			break;
+		cnt &= LT9721_AUX_RX_BUF_CNT_MASK;
+		if (!cnt)
+			break;
+		regmap_read(lt9721->regmap, LT9721_REG_AUX_SOFT_FIFO, &dummy);
+	}
+}
+
+static ssize_t lt9721_aux_transfer_i2c(struct lt9721 *lt9721,
+				       struct drm_dp_aux_msg *msg)
+{
+	bool is_read = (msg->request & ~DP_AUX_I2C_MOT) == DP_AUX_I2C_READ;
+	unsigned int rx_cnt = 0, timeout = 0, val;
+	u8 *buf = msg->buffer;
+	u8 hdr[4];
+	size_t hdr_len, i, data_len;
+	ssize_t ret;
+
+	ret = regmap_write(lt9721->regmap, LT9721_REG_AUX_SOFT_MODE,
+			   LT9721_AUX_SOFT_EN);
+	if (ret)
+		return ret;
+
+	lt9721_aux_drain_soft_fifo(lt9721);
+
+	regmap_write(lt9721->regmap, LT9721_REG_INT_CLR0, 0x0f);
+	regmap_write(lt9721->regmap, LT9721_REG_INT_CLR0, 0xff);
+
+	hdr[0] = (msg->request << 4) | ((msg->address >> 16) & 0x0f);
+	hdr[1] = (msg->address >> 8) & 0xff;
+	hdr[2] = msg->address & 0xff;
+	if (msg->size > 0) {
+		hdr[3] = (msg->size - 1) & 0x0f;
+		hdr_len = 4;
+	} else {
+		hdr_len = 3;
+	}
+
+	for (i = 0; i < hdr_len; i++)
+		regmap_write(lt9721->regmap, LT9721_REG_AUX_SOFT_FIFO, hdr[i]);
+
+	if (!is_read) {
+		for (i = 0; i < msg->size; i++)
+			regmap_write(lt9721->regmap, LT9721_REG_AUX_SOFT_FIFO,
+				     buf[i]);
+	}
+
+	ret = regmap_write(lt9721->regmap, LT9721_REG_AUX_SOFT_SEND, 0x00);
+	if (ret)
+		goto out_disable_soft;
+
+	/* Allow full 1 Mbps Manchester packet + reply turnaround time */
+	fsleep(600);
+
+	for (i = 0; i < 30; i++) {
+		regmap_read(lt9721->regmap, LT9721_REG_AUX_RX_CNT, &rx_cnt);
+		rx_cnt &= LT9721_AUX_RX_BUF_CNT_MASK;
+		regmap_read(lt9721->regmap, LT9721_REG_AUX_TIMEOUT, &timeout);
+
+		if (timeout & LT9721_AUX_TIMEOUT_FLAG)
+			break;
+
+		if (rx_cnt > 0) {
+			if (is_read && msg->size > 0 &&
+			    rx_cnt < msg->size + 1) {
+				fsleep(250);
+				regmap_read(lt9721->regmap,
+					    LT9721_REG_AUX_RX_CNT, &rx_cnt);
+				rx_cnt &= LT9721_AUX_RX_BUF_CNT_MASK;
+			}
+			break;
+		}
+
+		fsleep(300);
+	}
+
+	if ((timeout & LT9721_AUX_TIMEOUT_FLAG) || rx_cnt == 0) {
+		ret = -ETIMEDOUT;
+		goto out_drain;
+	}
+
+	ret = regmap_read(lt9721->regmap, LT9721_REG_AUX_SOFT_FIFO, &val);
+	if (ret)
+		goto out_drain;
+
+	msg->reply = (val >> 4) & 0x0f;
+	if (msg->reply != (DP_AUX_NATIVE_REPLY_ACK | DP_AUX_I2C_REPLY_ACK)) {
+		ret = 0;
+		goto out_drain;
+	}
+
+	if (is_read) {
+		data_len = min_t(size_t, msg->size, rx_cnt - 1);
+		for (i = 0; i < data_len; i++) {
+			ret = regmap_read(lt9721->regmap,
+					  LT9721_REG_AUX_SOFT_FIFO, &val);
+			if (ret)
+				goto out_drain;
+			buf[i] = val;
+		}
+		ret = data_len;
+	} else if (rx_cnt > 1) {
+		/* Partial write: sink returned count M (M + 1 bytes written) */
+		ret = regmap_read(lt9721->regmap, LT9721_REG_AUX_SOFT_FIFO,
+				  &val);
+		if (ret == 0)
+			ret = min_t(size_t, msg->size, val + 1);
+	} else {
+		ret = msg->size;
+	}
+
+out_drain:
+	lt9721_aux_drain_soft_fifo(lt9721);
+out_disable_soft:
+	regmap_write(lt9721->regmap, LT9721_REG_AUX_SOFT_MODE, 0x00);
+	return ret;
+}
+
+static ssize_t lt9721_aux_transfer(struct drm_dp_aux *aux,
+				   struct drm_dp_aux_msg *msg)
+{
+	struct lt9721 *lt9721 = aux_to_lt9721(aux);
+	ssize_t ret;
+
+	if (msg->size > DP_AUX_MAX_PAYLOAD_BYTES)
+		return -EINVAL;
+
+	mutex_lock(&lt9721->aux_lock);
+
+	switch (msg->request & ~DP_AUX_I2C_MOT) {
+	case DP_AUX_NATIVE_WRITE:
+	case DP_AUX_NATIVE_READ:
+		ret = lt9721_aux_transfer_native(lt9721, msg);
+		break;
+	case DP_AUX_I2C_WRITE:
+	case DP_AUX_I2C_READ:
+	case DP_AUX_I2C_WRITE_STATUS_UPDATE:
+		ret = lt9721_aux_transfer_i2c(lt9721, msg);
+		break;
+	default:
+		ret = -EINVAL;
+		break;
+	}
+
+	mutex_unlock(&lt9721->aux_lock);
+
+	return ret;
+}
+
+static int lt9721_power_on(struct lt9721 *lt9721)
+{
+	int ret;
+
+	gpiod_set_value_cansleep(lt9721->reset_gpio, 1);
+
+	/* Datasheet Fig. 8.6.1: VCC (3.3V) -> >1ms -> VDD (1.8V) -> RST_N */
+	ret = regulator_enable(lt9721->vcc);
+	if (ret)
+		return dev_err_probe(lt9721->dev, ret,
+				     "failed to enable vcc supply\n");
+
+	fsleep(2000);
+
+	ret = regulator_enable(lt9721->vdd);
+	if (ret) {
+		regulator_disable(lt9721->vcc);
+		return dev_err_probe(lt9721->dev, ret,
+				     "failed to enable vdd supply\n");
+	}
+
+	fsleep(20000);
+	gpiod_set_value_cansleep(lt9721->reset_gpio, 0);
+	msleep(100);
+
+	return 0;
+}
+
+static void lt9721_power_off(void *data)
+{
+	struct lt9721 *lt9721 = data;
+
+	lt9721_hpd_ctrl(lt9721, false);
+	gpiod_set_value_cansleep(lt9721->reset_gpio, 1);
+	regulator_disable(lt9721->vdd);
+	fsleep(2000);
+	regulator_disable(lt9721->vcc);
+}
+
+static int lt9721_read_chipid(struct lt9721 *lt9721)
+{
+	u8 chipid[2];
+	int ret;
+
+	ret = regmap_bulk_read(lt9721->regmap, LT9721_REG_CHIP_ID0,
+			       chipid, sizeof(chipid));
+	if (ret < 0)
+		return dev_err_probe(lt9721->dev, ret,
+				     "failed to read Chip ID\n");
+
+	if (chipid[0] != LT9721_CHIP_ID0 || chipid[1] != LT9721_CHIP_ID1) {
+		dev_err(lt9721->dev, "unexpected Chip ID: 0x%02x 0x%02x\n",
+			chipid[0], chipid[1]);
+		return -ENODEV;
+	}
+
+	return 0;
+}
+
+static void lt9721_tx_pll_setup(struct lt9721 *lt9721, u8 link_bw)
+{
+	bool is_rbr = (link_bw == DP_LINK_BW_1_62);
+
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG0, 0x22);
+
+	if (is_rbr) {
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG1, 0x20);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG2, 0x99);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG3, 0x99);
+	} else {
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG1, 0x36);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG2, 0x00);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG3, 0x80);
+	}
+
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_ANA0, 0x18);
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_ANA1, 0x42);
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_ANA2, 0x00);
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_ANA2, 0x01);
+	if (!is_rbr)
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_ANA3, 0x3b);
+
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG10, 0x0e);
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG11, 0x10);
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG5, 0x83);
+
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_TXPLL, 0xbf);
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_TXPLL, 0xff);
+
+	if (is_rbr) {
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_ANA3, 0x19);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_ANA3, 0x1b);
+	} else {
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_ANA3, 0x3b);
+	}
+
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG4, 0x41);
+	if (is_rbr) {
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG5, 0x83);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG6, 0x06);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG8, 0x06);
+	} else {
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG5, 0x03);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG6, 0x0a);
+		regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG8, 0x0a);
+	}
+
+	regmap_write(lt9721->regmap, LT9721_REG_TXPLL_DIG0, 0x22);
+}
+
+static void lt9721_tx_phy_setup(struct lt9721 *lt9721)
+{
+	static const struct reg_sequence txphy_seq[] = {
+		{ LT9721_REG_TYPEC_PHY_MODE, 0x00 },
+		{ LT9721_REG_DPTX_PHY_EN, 0x0d },
+		{ LT9721_REG_DPTX_PHY_EN, 0x0f },
+		{ LT9721_REG_DPTX_LANE01_CTRL, 0x77 },
+		{ LT9721_REG_DPTX_LANE23_CTRL, 0x77 },
+		{ LT9721_REG_DPTX_SWING(0), 0x80 },
+		{ LT9721_REG_DPTX_PREEMPH(0), 0x00 },
+		{ LT9721_REG_DPTX_SWING(1), 0x80 },
+		{ LT9721_REG_DPTX_PREEMPH(1), 0x00 },
+		{ LT9721_REG_DPTX_SWING(2), 0x80 },
+		{ LT9721_REG_DPTX_PREEMPH(2), 0x00 },
+		{ LT9721_REG_DPTX_SWING(3), 0x80 },
+		{ LT9721_REG_DPTX_PREEMPH(3), 0x00 },
+		{ LT9721_REG_DPTX_RTERM_CAL, 0xb0 },
+		{ LT9721_REG_DPTX_RTERM_CAL, 0xf0 },
+	};
+
+	regmap_multi_reg_write(lt9721->regmap, txphy_seq, ARRAY_SIZE(txphy_seq));
+	lt9721_aux_phy_init(lt9721);
+
+	regmap_write(lt9721->regmap, LT9721_REG_ML_CTRL0, 0x00);
+	regmap_write(lt9721->regmap, LT9721_REG_ML_LANE_SWAP,
+		     lt9721->tx_lane_swap);
+	regmap_write(lt9721->regmap, LT9721_REG_ML_POL_FIFO,
+		     (lt9721->tx_pol_swap << 4) | LT9721_ML_FIFO_SOFT_RSTZ);
+
+	regmap_write(lt9721->regmap, LT9721_REG_DPTX_PHY_EN, 0x0d);
+	regmap_write(lt9721->regmap, LT9721_REG_DPTX_PHY_EN, 0x0f);
+}
+
+static void lt9721_video_processor_setup(struct lt9721 *lt9721,
+					 const struct drm_display_mode *mode)
+{
+	u16 hstart = mode->htotal - mode->hsync_start;
+	u16 hsw = mode->hsync_end - mode->hsync_start;
+	u16 vstart = mode->vtotal - mode->vsync_start;
+	u16 vsw = mode->vsync_end - mode->vsync_start;
+	u32 total_byte_line;
+
+	if (!(mode->flags & DRM_MODE_FLAG_PHSYNC))
+		hsw |= LT9721_VID_SYNC_ACTIVE_LOW;
+	if (!(mode->flags & DRM_MODE_FLAG_PVSYNC))
+		vsw |= LT9721_VID_SYNC_ACTIVE_LOW;
+
+	regmap_write(lt9721->regmap, LT9721_REG_VID_PROC0, 0x4a);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_PROC0 + 1, 0x02);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_PROC0 + 2, 0x10);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_PROC0 + 3, 0x01);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_PROC0 + 4, 0xff);
+
+	lt9721_write_u16(lt9721, LT9721_REG_VID_HTOTAL_H, mode->htotal);
+	lt9721_write_u16(lt9721, LT9721_REG_VID_HSTART_H, hstart);
+	lt9721_write_u16(lt9721, LT9721_REG_VID_HSW_H, hsw);
+	lt9721_write_u16(lt9721, LT9721_REG_VID_HWIDTH_H, mode->hdisplay);
+
+	lt9721_write_u16(lt9721, LT9721_REG_VID_VTOTAL_H, mode->vtotal);
+	lt9721_write_u16(lt9721, LT9721_REG_VID_VSTART_H, vstart);
+	lt9721_write_u16(lt9721, LT9721_REG_VID_VSW_H, vsw);
+	lt9721_write_u16(lt9721, LT9721_REG_VID_VHEIGHT_H, mode->vdisplay);
+
+	/* Default to 8bpc RGB888; refined after HDMI RX packet check */
+	regmap_write(lt9721->regmap, LT9721_REG_VID_PIX_FMT, 0x08);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_MISC0, 0x20);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_MISC1, 0x00);
+
+	total_byte_line = DIV_ROUND_UP(mode->hdisplay * 3U,
+				       lt9721->active_lanes);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_MSA_POL_B19,
+		     LT9721_MSA_SDP_SOFT | ((total_byte_line >> 16) & 0x0f));
+	regmap_write(lt9721->regmap, LT9721_REG_VID_BYTE_LINE_M,
+		     (total_byte_line >> 8) & 0xff);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_BYTE_LINE_L,
+		     total_byte_line & 0xff);
+
+	regmap_write(lt9721->regmap, LT9721_REG_VID_RD_PIXELS, 0x36);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_FIFO_THRESH, 0x4e);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_OUT_BYTES, 0x66);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_TU_SIZE, 0x1b);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_IDLE_VBID, 0x09);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_TEST_MUX, 0xff);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_BOT_VTOTAL_H, 0x00);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_BOT_VTOTAL_L, 0x00);
+}
+
+static int lt9721_apply_adjust_request(struct lt9721 *lt9721,
+				       const u8 link_status[DP_LINK_STATUS_SIZE],
+				       u8 train_set[LT9721_MAX_LANES])
+{
+	unsigned int lane;
+
+	for (lane = 0; lane < lt9721->active_lanes; lane++) {
+		u8 v = drm_dp_get_adjust_request_voltage(link_status, lane) >>
+		       DP_TRAIN_VOLTAGE_SWING_SHIFT;
+		u8 p = drm_dp_get_adjust_request_pre_emphasis(link_status, lane) >>
+		       DP_TRAIN_PRE_EMPHASIS_SHIFT;
+		const struct lt9721_drive_cfg *cfg = &lt9721_drive_table[v & 3][p & 3];
+		unsigned int phy;
+
+		for (phy = 0; phy < LT9721_MAX_LANES; phy++) {
+			if (((lt9721->tx_lane_swap >> (2 * phy)) & 0x3) == lane) {
+				regmap_write(lt9721->regmap,
+					     LT9721_REG_DPTX_SWING(phy),
+					     cfg->swing);
+				regmap_write(lt9721->regmap,
+					     LT9721_REG_DPTX_PREEMPH(phy),
+					     cfg->pre_emph);
+			}
+		}
+
+		train_set[lane] = (v << DP_TRAIN_VOLTAGE_SWING_SHIFT) |
+				  (p << DP_TRAIN_PRE_EMPHASIS_SHIFT);
+		if (v >= 3)
+			train_set[lane] |= DP_TRAIN_MAX_SWING_REACHED;
+		if (p >= 3)
+			train_set[lane] |= DP_TRAIN_MAX_PRE_EMPHASIS_REACHED;
+	}
+
+	return drm_dp_dpcd_write(&lt9721->aux, DP_TRAINING_LANE0_SET,
+				 train_set, lt9721->active_lanes);
+}
+
+static int lt9721_dp_link_train(struct lt9721 *lt9721)
+{
+	u8 link_status[DP_LINK_STATUS_SIZE] = { 0 };
+	u8 train_set[LT9721_MAX_LANES] = { 0 };
+	u8 dpcd[DP_RECEIVER_CAP_SIZE] = { 0 };
+	u8 link_cfg[2];
+	int tries, ret;
+
+	regmap_write(lt9721->regmap, LT9721_REG_CLK_EN3, 0xc7);
+
+	lt9721->link_bw = DP_LINK_BW_2_7;
+	lt9721->active_lanes = lt9721->data_lanes;
+
+	ret = drm_dp_read_dpcd_caps(&lt9721->aux, dpcd);
+	if (!ret) {
+		int max_rate = drm_dp_max_link_rate(dpcd);
+		int max_lanes = drm_dp_max_lane_count(dpcd);
+
+		if (max_rate > 0 && max_rate < 270000)
+			lt9721->link_bw = DP_LINK_BW_1_62;
+		if (max_lanes == 1 || max_lanes == 2 || max_lanes == 4)
+			lt9721->active_lanes = min_t(u8, lt9721->data_lanes,
+						     max_lanes);
+	}
+
+	lt9721_tx_pll_setup(lt9721, lt9721->link_bw);
+
+	/* Internal link configuration */
+	regmap_write(lt9721->regmap, LT9721_REG_LINK_BW, lt9721->link_bw);
+	regmap_write(lt9721->regmap, LT9721_REG_LINK_LANE_CNT,
+		     LT9721_LINK_SCRAMBLER_DIS | LT9721_LINK_TRAIN_SOFT_EN |
+		     lt9721->active_lanes);
+	regmap_write(lt9721->regmap, LT9721_REG_LINK_ENHANCED,
+		     LT9721_LINK_ENHANCED_FRAME);
+	regmap_write(lt9721->regmap, LT9721_REG_LINK_PTN_TYPE, 0x00);
+
+	/* Wake sink and configure link BW, lane count, downspread & coding */
+	drm_dp_dpcd_writeb(&lt9721->aux, DP_SET_POWER, DP_SET_POWER_D0);
+	fsleep(1500);
+
+	link_cfg[0] = lt9721->link_bw;
+	link_cfg[1] = lt9721->active_lanes | DP_LANE_COUNT_ENHANCED_FRAME_EN;
+	drm_dp_dpcd_write(&lt9721->aux, DP_LINK_BW_SET, link_cfg,
+			  sizeof(link_cfg));
+	drm_dp_dpcd_writeb(&lt9721->aux, DP_DOWNSPREAD_CTRL, 0x00);
+	drm_dp_dpcd_writeb(&lt9721->aux, DP_MAIN_LINK_CHANNEL_CODING_SET,
+			   DP_SET_ANSI_8B10B);
+
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_FIFO, 0xf0);
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_FIFO, 0xff);
+
+	/* Phase 1: Clock Recovery (TPS1) */
+	regmap_write(lt9721->regmap, LT9721_REG_ML_TRAIN_CTRL,
+		     LT9721_ML_RDISP_RST_N | LT9721_ML_TPS1_TRANS_EN);
+	drm_dp_dpcd_writeb(&lt9721->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_1 | DP_LINK_SCRAMBLING_DISABLE);
+	drm_dp_dpcd_write(&lt9721->aux, DP_TRAINING_LANE0_SET, train_set,
+			  lt9721->active_lanes);
+
+	for (tries = 0; tries < LT9721_MAX_CR_TRIES; tries++) {
+		drm_dp_link_train_clock_recovery_delay(&lt9721->aux, dpcd);
+
+		ret = drm_dp_dpcd_read_link_status(&lt9721->aux, link_status);
+		if (ret < 0)
+			break;
+
+		if (drm_dp_clock_recovery_ok(link_status, lt9721->active_lanes))
+			break;
+
+		lt9721_apply_adjust_request(lt9721, link_status, train_set);
+	}
+
+	if (!drm_dp_clock_recovery_ok(link_status, lt9721->active_lanes))
+		dev_warn(lt9721->dev, "DP clock recovery incomplete (0x%02x 0x%02x)\n",
+			 link_status[0], link_status[1]);
+
+	/* Phase 2: Channel Equalization (TPS2) */
+	regmap_write(lt9721->regmap, LT9721_REG_LINK_LANE_CNT,
+		     LT9721_LINK_TRAIN_SOFT_EN | lt9721->active_lanes);
+	regmap_write(lt9721->regmap, LT9721_REG_ML_TRAIN_CTRL,
+		     LT9721_ML_RDISP_RST_N | LT9721_ML_TPS2_TRANS_EN);
+	drm_dp_dpcd_writeb(&lt9721->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_2 | DP_LINK_SCRAMBLING_DISABLE);
+
+	for (tries = 0; tries < LT9721_MAX_EQ_TRIES; tries++) {
+		drm_dp_link_train_channel_eq_delay(&lt9721->aux, dpcd);
+
+		ret = drm_dp_dpcd_read_link_status(&lt9721->aux, link_status);
+		if (ret < 0)
+			break;
+
+		if (drm_dp_channel_eq_ok(link_status, lt9721->active_lanes))
+			break;
+
+		lt9721_apply_adjust_request(lt9721, link_status, train_set);
+	}
+
+	if (!drm_dp_channel_eq_ok(link_status, lt9721->active_lanes))
+		dev_warn(lt9721->dev, "DP channel EQ incomplete (0x%02x 0x%02x)\n",
+			 link_status[0], link_status[1]);
+
+	regmap_write(lt9721->regmap, LT9721_REG_CLK_EN3, 0xff);
+	fsleep(5000);
+
+	/* End training and enable main video stream */
+	drm_dp_dpcd_writeb(&lt9721->aux, DP_TRAINING_PATTERN_SET,
+			   DP_TRAINING_PATTERN_DISABLE);
+	fsleep(5000);
+	regmap_write(lt9721->regmap, LT9721_REG_ML_TRAIN_CTRL,
+		     LT9721_ML_RDISP_RST_N);
+	regmap_write(lt9721->regmap, LT9721_REG_ML_TRAIN_CTRL,
+		     LT9721_ML_RDISP_RST_N | LT9721_ML_NORMAL_TRANS_EN);
+
+	return 0;
+}
+
+static void lt9721_hdmi_rx_cdr_eq_setup(struct lt9721 *lt9721)
+{
+	static const struct reg_sequence cdr_eq_seq[] = {
+		{ 0x901d, 0x04 }, { 0x901e, 0x1f }, { 0x901f, 0x20 },
+		{ 0x9024, 0xe0 }, { 0x9025, 0xf0 }, { 0x9027, 0x01 },
+		{ 0x902b, 0x40 }, { 0x902c, 0x65 },
+		/* Adaptive EQ calibration table */
+		{ 0x902a, 0x0f }, { 0x9028, 0x14 },
+		{ 0x9028, 0xf4 }, { 0x9029, 0x00 }, { 0x902b, 0xf1 },
+		{ 0x9028, 0xf7 }, { 0x9029, 0x00 }, { 0x902b, 0xf2 },
+		{ 0x9028, 0xf0 }, { 0x9029, 0x70 }, { 0x902b, 0xf3 },
+		{ 0x9028, 0xf3 }, { 0x9029, 0x70 }, { 0x902b, 0xf4 },
+		{ 0x9028, 0xf6 }, { 0x9029, 0x70 }, { 0x902b, 0xf5 },
+		{ 0x9028, 0xf0 }, { 0x9029, 0xa0 }, { 0x902b, 0xf6 },
+		{ 0x9028, 0xf3 }, { 0x9029, 0xa0 }, { 0x902b, 0xf7 },
+		{ 0x9028, 0xf7 }, { 0x9029, 0xa0 }, { 0x902b, 0xf8 },
+		{ 0x9028, 0xf0 }, { 0x9029, 0xaa }, { 0x902b, 0xf9 },
+		{ 0x9028, 0xf4 }, { 0x9029, 0xaa }, { 0x902b, 0xfa },
+		{ 0x9028, 0xff }, { 0x9029, 0xaa }, { 0x902b, 0xfb },
+		{ 0x9028, 0xff }, { 0x9029, 0x00 }, { 0x902b, 0xfc },
+		{ 0x9028, 0xf1 }, { 0x9029, 0x70 }, { 0x902b, 0xfd },
+		{ 0x9028, 0xf4 }, { 0x9029, 0x70 }, { 0x902b, 0xfe },
+		{ 0x9028, 0xf5 }, { 0x9029, 0x70 }, { 0x902b, 0xff },
+		{ 0x9028, 0xf0 }, { 0x9029, 0x00 }, { 0x902b, 0xf0 },
+		{ 0x901d, 0x04 }, { 0x901e, 0x1f }, { 0x901f, 0x20 },
+		{ 0x9024, 0xe0 }, { 0x9025, 0xf0 }, { 0x9027, 0x01 },
+		{ 0x902b, 0x40 }, { 0x902c, 0x25 },
+		{ 0x902d, 0x01 }, { 0x902e, 0x01 }, { 0x902f, 0x01 },
+		{ 0x9047, 0x24 },
+		/* HDMI RX PLL from TMDS clock */
+		{ LT9721_REG_RXPLL_CTRL0, 0x30 },
+		{ LT9721_REG_RXPLL_CTRL2, 0x03 },
+		{ LT9721_REG_RXPLL_CTRL3, 0x1e },
+		{ LT9721_REG_RXPLL_CTRL4, 0x24 },
+	};
+
+	regmap_write(lt9721->regmap, LT9721_REG_HMRX_CDR_CFG,
+		     lt9721->rx_pn_swap ? LT9721_HMRX_CDR_PN_SWAP : 0x00);
+	regmap_multi_reg_write(lt9721->regmap, cdr_eq_seq,
+			       ARRAY_SIZE(cdr_eq_seq));
+}
+
+static void lt9721_hdmi_format_setup(struct lt9721 *lt9721,
+				     const struct drm_display_mode *mode)
+{
+	unsigned int avi_val = 0, pol_val = 0;
+	u8 hs_act_buf[2] = { 0 };
+	u8 msa_pol = 0, vid_src = 0xe0;
+	u32 hact, total_byte_line;
+	u8 colorspace;
+
+	regmap_read(lt9721->regmap, LT9721_REG_HMRX_AVI_FMT, &avi_val);
+	colorspace = avi_val & LT9721_HMRX_COLORSPACE_MASK;
+
+	regmap_read(lt9721->regmap, LT9721_REG_CHK_SYNC_POL, &pol_val);
+	if (!(pol_val & LT9721_CHK_VS_POL_HIGH))
+		msa_pol |= LT9721_MSA_VSPOL_LOW;
+	else
+		vid_src |= LT9721_VID_VSYNC_POL_HIGH;
+
+	if (!(pol_val & LT9721_CHK_HS_POL_HIGH))
+		msa_pol |= LT9721_MSA_HSPOL_LOW;
+
+	regmap_bulk_read(lt9721->regmap, LT9721_REG_CHK_HS_ACT_H,
+			 hs_act_buf, sizeof(hs_act_buf));
+	hact = (hs_act_buf[0] << 8) | hs_act_buf[1];
+	if (!hact)
+		hact = mode->hdisplay;
+
+	total_byte_line = DIV_ROUND_UP(hact * 3U, lt9721->active_lanes);
+
+	regmap_write(lt9721->regmap, LT9721_REG_VID_MSA_POL_B19,
+		     msa_pol | ((total_byte_line >> 16) & 0x0f));
+	regmap_write(lt9721->regmap, LT9721_REG_VID_SRC_CTRL, vid_src);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_BYTE_LINE_M,
+		     (total_byte_line >> 8) & 0xff);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_BYTE_LINE_L,
+		     total_byte_line & 0xff);
+
+	switch (colorspace) {
+	case LT9721_HMRX_CS_YCBCR422:
+		regmap_write(lt9721->regmap, LT9721_REG_VID_PIX_FMT, 0x48);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_MISC0, 0x22);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_RD_PIXELS, 0x34);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_FIFO_THRESH, 0x2e);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_OUT_BYTES, 0x44);
+		break;
+	case LT9721_HMRX_CS_YCBCR444:
+		regmap_write(lt9721->regmap, LT9721_REG_VID_PIX_FMT, 0x88);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_MISC0, 0x24);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_RD_PIXELS, 0x36);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_FIFO_THRESH, 0x4e);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_OUT_BYTES, 0x66);
+		regmap_write(lt9721->regmap, LT9721_REG_CSC_Y2R, 0x40);
+		break;
+	case LT9721_HMRX_CS_RGB:
+	default:
+		regmap_write(lt9721->regmap, LT9721_REG_VID_PIX_FMT, 0x08);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_MISC0, 0x20);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_RD_PIXELS, 0x36);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_FIFO_THRESH, 0x4e);
+		regmap_write(lt9721->regmap, LT9721_REG_VID_OUT_BYTES, 0x66);
+		regmap_write(lt9721->regmap, LT9721_REG_CSC_Y2R, 0x00);
+		break;
+	}
+}
+
+static const struct drm_display_mode *
+lt9721_get_adjusted_mode(struct drm_bridge *bridge,
+			 const struct drm_atomic_commit *state)
+{
+	const struct drm_connector_state *conn_state;
+	const struct drm_crtc_state *crtc_state;
+	struct drm_connector *connector;
+
+	connector = drm_atomic_get_new_connector_for_encoder(state,
+							     bridge->encoder);
+	if (!connector)
+		return NULL;
+
+	conn_state = drm_atomic_get_new_connector_state(state, connector);
+	if (!conn_state || !conn_state->crtc)
+		return NULL;
+
+	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
+	if (!crtc_state)
+		return NULL;
+
+	return &crtc_state->adjusted_mode;
+}
+
+static int lt9721_bridge_attach(struct drm_bridge *bridge,
+				struct drm_encoder *encoder,
+				enum drm_bridge_attach_flags flags)
+{
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+	int ret;
+
+	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR)) {
+		dev_err(lt9721->dev, "connector creation is not supported\n");
+		return -EINVAL;
+	}
+
+	lt9721->aux.drm_dev = bridge->dev;
+	ret = drm_dp_aux_register(&lt9721->aux);
+	if (ret) {
+		dev_err(lt9721->dev, "failed to register DP AUX channel: %d\n",
+			ret);
+		return ret;
+	}
+
+	ret = drm_bridge_attach(encoder, lt9721->bridge.next_bridge,
+				bridge, flags);
+	if (ret) {
+		drm_dp_aux_unregister(&lt9721->aux);
+		return ret;
+	}
+
+	return 0;
+}
+
+static void lt9721_bridge_detach(struct drm_bridge *bridge)
+{
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+
+	drm_dp_aux_unregister(&lt9721->aux);
+}
+
+static enum drm_mode_status
+lt9721_bridge_mode_valid(struct drm_bridge *bridge,
+			 const struct drm_display_info *info,
+			 const struct drm_display_mode *mode)
+{
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+	unsigned int max_clock_khz;
+
+	if (mode->flags & (DRM_MODE_FLAG_INTERLACE | DRM_MODE_FLAG_DBLCLK))
+		return MODE_BAD;
+
+	if (mode->clock < LT9721_MIN_HDMI_CLOCK_KHZ)
+		return MODE_CLOCK_LOW;
+
+	/* Max 24bpp pixel clock bounded by HDMI 1.4 RX (340 MHz) and DP HBR */
+	max_clock_khz = min(LT9721_MAX_HDMI_CLOCK_KHZ,
+			    lt9721->data_lanes * 270000U / 3U);
+	if (mode->clock > max_clock_khz)
+		return MODE_CLOCK_HIGH;
+
+	return MODE_OK;
+}
+
+static u32 *
+lt9721_bridge_atomic_get_input_bus_fmts(struct drm_bridge *bridge,
+					struct drm_bridge_state *bridge_state,
+					struct drm_crtc_state *crtc_state,
+					struct drm_connector_state *conn_state,
+					u32 output_fmt,
+					unsigned int *num_input_fmts)
+{
+	u32 *input_fmts;
+
+	*num_input_fmts = 0;
+
+	input_fmts = kmalloc_obj(*input_fmts);
+	if (!input_fmts)
+		return NULL;
+
+	input_fmts[0] = MEDIA_BUS_FMT_RGB888_1X24;
+	*num_input_fmts = 1;
+
+	return input_fmts;
+}
+
+static void lt9721_bridge_atomic_pre_enable(struct drm_bridge *bridge,
+					    struct drm_atomic_commit *state)
+{
+	const struct drm_display_mode *mode = lt9721_get_adjusted_mode(bridge,
+								       state);
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+
+	if (!mode)
+		return;
+
+	regmap_write(lt9721->regmap, LT9721_REG_VID_READY_CTRL,
+		     LT9721_VID_RDY_SOFT);
+
+	lt9721_tx_phy_setup(lt9721);
+	lt9721_dp_link_train(lt9721);
+	lt9721_video_processor_setup(lt9721, mode);
+	lt9721_hpd_ctrl(lt9721, true);
+}
+
+static void lt9721_bridge_atomic_enable(struct drm_bridge *bridge,
+					struct drm_atomic_commit *state)
+{
+	const struct drm_display_mode *mode = lt9721_get_adjusted_mode(bridge,
+								       state);
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+	unsigned int val = 0;
+	u8 tmds_freq[3] = { 0 };
+	u8 hs_act_buf[2];
+	int i, ret;
+
+	if (!mode)
+		return;
+
+	/* Wait for upstream HDMI TX TMDS clock */
+	ret = regmap_read_poll_timeout(lt9721->regmap, LT9721_REG_HMRX_TMDS_DET,
+				       val, val & LT9721_HMRX_TMDS_CLK_DET,
+				       5000, 100000);
+	if (ret)
+		dev_warn(lt9721->dev, "timed out waiting for HDMI TMDS clock\n");
+
+	if (!regmap_bulk_read(lt9721->regmap, LT9721_REG_HMRX_TMDS_FREQ_H,
+			      tmds_freq, sizeof(tmds_freq))) {
+		u32 khz = ((tmds_freq[0] & 0x07) << 16) |
+			  (tmds_freq[1] << 8) | tmds_freq[2];
+		dev_dbg(lt9721->dev, "HDMI TMDS clock: %u kHz\n", khz);
+	}
+
+	lt9721_hdmi_rx_cdr_eq_setup(lt9721);
+
+	/* Reset HDMI RX digital / video check blocks after PLL/EQ setup */
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_RX1, 0x00);
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_RX0, 0x00);
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_RX2, 0x00);
+	fsleep(4000);
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_RX1, 0xff);
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_RX0, 0xff);
+	regmap_write(lt9721->regmap, LT9721_REG_SW_RST_RX2, 0xff);
+
+	/* Poll until HDMI RX video check locks onto active horizontal width */
+	for (i = 0; i < 20; i++) {
+		msleep(20);
+		regmap_read(lt9721->regmap, LT9721_REG_HMRX_SIG_STAT, &val);
+		if (!(val & LT9721_HMRX_HSYNC_DET))
+			continue;
+
+		if (!regmap_bulk_read(lt9721->regmap, LT9721_REG_CHK_HS_ACT_H,
+				      hs_act_buf, sizeof(hs_act_buf))) {
+			u16 hact = (hs_act_buf[0] << 8) | hs_act_buf[1];
+
+			if (hact == mode->hdisplay)
+				break;
+		}
+	}
+
+	/* Allow AVI infoframe / sync polarity detectors one frame to settle */
+	msleep(20);
+
+	lt9721_hdmi_format_setup(lt9721, mode);
+	regmap_write(lt9721->regmap, LT9721_REG_VID_READY_CTRL,
+		     LT9721_VID_RDY_SOFT | LT9721_VID_READY);
+}
+
+static void lt9721_bridge_atomic_disable(struct drm_bridge *bridge,
+					 struct drm_atomic_commit *state)
+{
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+
+	regmap_write(lt9721->regmap, LT9721_REG_VID_READY_CTRL,
+		     LT9721_VID_RDY_SOFT);
+	regmap_write(lt9721->regmap, LT9721_REG_ML_TRAIN_CTRL,
+		     LT9721_ML_RDISP_RST_N);
+}
+
+static void lt9721_bridge_atomic_post_disable(struct drm_bridge *bridge,
+					      struct drm_atomic_commit *state)
+{
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+
+	drm_dp_dpcd_writeb(&lt9721->aux, DP_SET_POWER, DP_SET_POWER_D3);
+	regmap_write(lt9721->regmap, LT9721_REG_DPTX_LANE01_CTRL, 0x00);
+	regmap_write(lt9721->regmap, LT9721_REG_DPTX_LANE23_CTRL, 0x00);
+	regmap_write(lt9721->regmap, LT9721_REG_DPTX_PHY_EN, 0x00);
+}
+
+static enum drm_connector_status
+lt9721_bridge_detect(struct drm_bridge *bridge,
+		     struct drm_connector *connector)
+{
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+	unsigned int val = 0;
+
+	if (lt9721->is_panel)
+		return connector_status_connected;
+
+	if (regmap_read(lt9721->regmap, LT9721_REG_HPD_STATUS, &val))
+		return connector_status_unknown;
+
+	return (val & LT9721_EDP_HPD_STATUS) ?
+		connector_status_connected : connector_status_disconnected;
+}
+
+static const struct drm_edid *
+lt9721_bridge_edid_read(struct drm_bridge *bridge,
+			struct drm_connector *connector)
+{
+	struct lt9721 *lt9721 = bridge_to_lt9721(bridge);
+
+	return drm_edid_read_ddc(connector, &lt9721->aux.ddc);
+}
+
+static const struct drm_bridge_funcs lt9721_bridge_funcs = {
+	.attach = lt9721_bridge_attach,
+	.detach = lt9721_bridge_detach,
+	.mode_valid = lt9721_bridge_mode_valid,
+	.atomic_pre_enable = lt9721_bridge_atomic_pre_enable,
+	.atomic_enable = lt9721_bridge_atomic_enable,
+	.atomic_disable = lt9721_bridge_atomic_disable,
+	.atomic_post_disable = lt9721_bridge_atomic_post_disable,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+	.atomic_get_input_bus_fmts = lt9721_bridge_atomic_get_input_bus_fmts,
+	.detect = lt9721_bridge_detect,
+	.edid_read = lt9721_bridge_edid_read,
+};
+
+static int lt9721_parse_rx_ep(struct lt9721 *lt9721)
+{
+	u32 polarities[LT9721_MAX_LANES];
+	struct device_node *ep;
+	int count, i;
+
+	ep = of_graph_get_endpoint_by_regs(lt9721->dev->of_node, 0, -1);
+	if (!ep)
+		return 0;
+
+	count = of_property_count_u32_elems(ep, "lane-polarities");
+	if (count > 0) {
+		if (count > LT9721_MAX_LANES) {
+			of_node_put(ep);
+			return -EINVAL;
+		}
+
+		of_property_read_u32_array(ep, "lane-polarities", polarities,
+					   count);
+		for (i = 1; i < count; i++) {
+			if (!!polarities[i] != !!polarities[0]) {
+				dev_err(lt9721->dev,
+					"HDMI RX lane-polarities must match across all pairs\n");
+				of_node_put(ep);
+				return -EINVAL;
+			}
+		}
+
+		lt9721->rx_pn_swap = !!polarities[0];
+	}
+
+	of_node_put(ep);
+	return 0;
+}
+
+static int lt9721_parse_tx_ep(struct lt9721 *lt9721)
+{
+	u32 lanes[LT9721_MAX_LANES] = { 0, 1, 2, 3 };
+	u32 polarities[LT9721_MAX_LANES] = { 0 };
+	bool pin_used[LT9721_MAX_LANES] = { false };
+	struct device_node *ep;
+	unsigned int next_pin = 0;
+	int count, pol_cnt, i;
+
+	lt9721->data_lanes = LT9721_MAX_LANES;
+
+	ep = of_graph_get_endpoint_by_regs(lt9721->dev->of_node, 1, -1);
+	if (ep) {
+		count = of_property_count_u32_elems(ep, "data-lanes");
+		if (count > 0) {
+			if (count != 1 && count != 2 && count != 4) {
+				dev_err(lt9721->dev,
+					"unsupported eDP data-lanes count: %d\n",
+					count);
+				of_node_put(ep);
+				return -EINVAL;
+			}
+
+			of_property_read_u32_array(ep, "data-lanes", lanes,
+						   count);
+			lt9721->data_lanes = count;
+		}
+
+		pol_cnt = of_property_count_u32_elems(ep, "lane-polarities");
+		if (pol_cnt > 0) {
+			if (pol_cnt > lt9721->data_lanes) {
+				of_node_put(ep);
+				return -EINVAL;
+			}
+			of_property_read_u32_array(ep, "lane-polarities",
+						   polarities, pol_cnt);
+		}
+
+		of_node_put(ep);
+	}
+
+	lt9721->tx_lane_swap = 0;
+	lt9721->tx_pol_swap = 0;
+
+	for (i = 0; i < lt9721->data_lanes; i++) {
+		u32 pin = lanes[i];
+		u8 phy;
+
+		if (pin >= LT9721_MAX_LANES || pin_used[pin]) {
+			dev_err(lt9721->dev, "invalid eDP data-lanes entry %u\n",
+				pin);
+			return -EINVAL;
+		}
+
+		pin_used[pin] = true;
+		phy = lt9721_qfn64_pin_to_phy[pin];
+		lt9721->tx_lane_swap |= (i & 0x3) << (2 * phy);
+		if (polarities[i])
+			lt9721->tx_pol_swap |= BIT(i);
+	}
+
+	/* Assign remaining unused logical lanes to unused die PHYs */
+	for (i = lt9721->data_lanes; i < LT9721_MAX_LANES; i++) {
+		u8 phy;
+
+		while (next_pin < LT9721_MAX_LANES && pin_used[next_pin])
+			next_pin++;
+		if (next_pin >= LT9721_MAX_LANES)
+			break;
+
+		pin_used[next_pin] = true;
+		phy = lt9721_qfn64_pin_to_phy[next_pin];
+		lt9721->tx_lane_swap |= (i & 0x3) << (2 * phy);
+	}
+
+	lt9721->active_lanes = lt9721->data_lanes;
+
+	return 0;
+}
+
+static int lt9721_link_panel(struct drm_dp_aux *aux)
+{
+	struct lt9721 *lt9721 = aux_to_lt9721(aux);
+	struct device *dev = lt9721->dev;
+	struct drm_bridge *next_bridge;
+
+	next_bridge = devm_drm_of_get_bridge(dev, dev->of_node, 1, 0);
+	if (IS_ERR(next_bridge))
+		return PTR_ERR(next_bridge);
+
+	if (drm_bridge_is_panel(next_bridge))
+		lt9721->is_panel = true;
+	else
+		lt9721->bridge.ops = DRM_BRIDGE_OP_DETECT | DRM_BRIDGE_OP_EDID;
+
+	lt9721->bridge.next_bridge = next_bridge;
+
+	return devm_drm_bridge_add(dev, &lt9721->bridge);
+}
+
+static int lt9721_probe(struct i2c_client *client)
+{
+	struct device *dev = &client->dev;
+	struct lt9721 *lt9721;
+	int ret;
+
+	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
+		return -ENODEV;
+
+	lt9721 = devm_drm_bridge_alloc(dev, struct lt9721, bridge,
+				       &lt9721_bridge_funcs);
+	if (IS_ERR(lt9721))
+		return PTR_ERR(lt9721);
+
+	lt9721->dev = dev;
+	lt9721->client = client;
+	mutex_init(&lt9721->aux_lock);
+	i2c_set_clientdata(client, lt9721);
+
+	ret = lt9721_parse_rx_ep(lt9721);
+	if (ret)
+		return ret;
+
+	ret = lt9721_parse_tx_ep(lt9721);
+	if (ret)
+		return ret;
+
+	lt9721->vcc = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(lt9721->vcc))
+		return dev_err_probe(dev, PTR_ERR(lt9721->vcc),
+				     "failed to get vcc regulator\n");
+
+	lt9721->vdd = devm_regulator_get(dev, "vdd");
+	if (IS_ERR(lt9721->vdd))
+		return dev_err_probe(dev, PTR_ERR(lt9721->vdd),
+				     "failed to get vdd regulator\n");
+
+	lt9721->reset_gpio = devm_gpiod_get_optional(dev, "reset",
+						     GPIOD_OUT_HIGH);
+	if (IS_ERR(lt9721->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(lt9721->reset_gpio),
+				     "failed to acquire reset gpio\n");
+
+	lt9721->regmap = devm_regmap_init_i2c(client, &lt9721_regmap_config);
+	if (IS_ERR(lt9721->regmap))
+		return dev_err_probe(dev, PTR_ERR(lt9721->regmap),
+				     "failed to initialize regmap\n");
+
+	ret = lt9721_power_on(lt9721);
+	if (ret)
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, lt9721_power_off, lt9721);
+	if (ret)
+		return ret;
+
+	ret = lt9721_read_chipid(lt9721);
+	if (ret)
+		return ret;
+
+	ret = lt9721_aux_phy_init(lt9721);
+	if (ret)
+		return ret;
+
+	lt9721_hpd_ctrl(lt9721, true);
+
+	lt9721->bridge.of_node = dev->of_node;
+	lt9721->bridge.type = DRM_MODE_CONNECTOR_eDP;
+	lt9721->bridge.vendor = "Lontium";
+	lt9721->bridge.product = "LT9721";
+
+	lt9721->aux.name = "lt9721-dp-aux";
+	lt9721->aux.dev = dev;
+	lt9721->aux.transfer = lt9721_aux_transfer;
+	drm_dp_aux_init(&lt9721->aux);
+
+	ret = devm_of_dp_aux_populate_bus(&lt9721->aux, lt9721_link_panel);
+	if (ret == -ENODEV)
+		return lt9721_link_panel(&lt9721->aux);
+
+	return ret;
+}
+
+static const struct i2c_device_id lt9721_i2c_ids[] = {
+	{ "lt9721" },
+	{ }
+};
+MODULE_DEVICE_TABLE(i2c, lt9721_i2c_ids);
+
+static const struct of_device_id lt9721_of_ids[] = {
+	{ .compatible = "lontium,lt9721" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lt9721_of_ids);
+
+static struct i2c_driver lt9721_driver = {
+	.driver = {
+		.name = "lontium-lt9721",
+		.of_match_table = lt9721_of_ids,
+	},
+	.id_table = lt9721_i2c_ids,
+	.probe = lt9721_probe,
+};
+module_i2c_driver(lt9721_driver);
+
+MODULE_AUTHOR("Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>");
+MODULE_DESCRIPTION("Lontium LT9721 HDMI to eDP bridge driver");
+MODULE_LICENSE("GPL");
-- 
2.25.1

