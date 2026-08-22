Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EC9EC5DF97
	for <dri-devel@archiver.kernel.org>; Sat, 22 Aug 2026 17:02:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C0DA310E2A4;
	Sat, 22 Aug 2026 17:02:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="SsIEwaQ+";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="dXTbv6QL";
	dkim-atps=neutral
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com
 [205.220.168.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 502D310E2A4
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 17:02:03 +0000 (UTC)
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67MEMBmC1462801
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 17:02:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EvEoH/3oHs3xYQcDiodHL5lIC/LNDWn/MU4ePGt/zCU=; b=SsIEwaQ+ltfGsSKI
 TmW38GbnKmGyLCcNEHI2SI2y39tJdp9tlK6EGjNtGfbiOx4JtMP5gVrsyjpe9HoW
 HTaBaC9LgVo6GQ+1jetj6Z8poB5tkm7brnmcTXaMq2jkyN0eUwXYMwnPFaAIneEL
 WM0UcrFm2Rm7BjsLatajj1J11ItDa3vRQCjAIvkI/OJ/z90mtF9l1mSowaSgI27B
 +7w+gasIr8KsCrJ5f8xWLZygA8TFgEFSPktwp2b+2bw1zSa7Sq1A3ge1uQa21XvU
 xqh4NWThaHMrLtzI5W/bPHbwc0+VPNB0algoxGTs4AQyEds5Ga2IUETXMp71bg+5
 WpqS1g==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74399mte-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 17:02:02 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc7ea29141so7023555ad.1
 for <dri-devel@lists.freedesktop.org>; Sat, 22 Aug 2026 10:02:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787418122; x=1788022922;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EvEoH/3oHs3xYQcDiodHL5lIC/LNDWn/MU4ePGt/zCU=;
 b=dXTbv6QLIm4/eYELF+T5jrr/iZeBqlpLVTKvFh0lYwkBDM3kIaXEz97kvZIbB1koT5
 1E+3V7I46XX1+1Df2SeJGUtOCpGj+2yp36/jLXDl1YI0XRPDKn9vfF1iaL1GeOepQP0P
 ZBZKOKVsLzSgq/uT9l2tURyFJ17nVGxFSaqsx2cXY1i/y6MbPfiqgM0uGy/Ngek1Tq2i
 /65ukOwY1TA1daAqcTfqFuzeJfnE+U+g0TxtumZwRyx1iMMf0mlqLK5IOoFpMUTq7xp5
 FB65QhVKWd/GU4RgOYkg8BaGIM371uY3ffSPoaUXvk1CaBorlwqrmujIOfVqUHPfaeqT
 X1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787418122; x=1788022922;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=EvEoH/3oHs3xYQcDiodHL5lIC/LNDWn/MU4ePGt/zCU=;
 b=Pr14qYpNTqco0Dup0TqOd8qclyAkFDz5MhH1c8ripdwCa0zoL9Vwm92XW22Zho+w18
 ReMenDlrNg4vlaEl47AYf735pXeMXDrSzPTF2uhYAofqCCAh2g2Kuk3g3y+mAYQxoB+R
 BkvAeElc/VtrI8wTHtTVWvK8PkcpAj6SuPWbwTFrNMsSLwEOakKnSxzbA9xk1tuMy2kO
 ztSmOpsQ9RR4FLVJxucwhPf+4msL9mZgEaE7Ec0V3dRLY2p4vHWYUTJlub/FoSJtW2Id
 phRXYKBwLJdXNnHqdmKn4IosJIu4fhZHtXNyIqOoMuxORmDPbEZOjHJV5hy7auqEAd5g
 pGeg==
X-Gm-Message-State: AFuF++mfCT5I4GKBz9mFTORgdXenc/N82CaIF+Pvi8aKqijBToBdbAHQ
 +KyedQh+t/g2AKRFXv/IVZ3Oal0Z4WNMJqCKOwc+D3Wo4gaX7A+Pc4pIyPCDBBvZAcvh8KA/YXZ
 Kx64d09p7GSqh52NUl59/s0UjMGeiGAGmjUD3EeEC6b6XER1goHI3lU3XFJj/kMbtu1KEu+8=
X-Gm-Gg: AR+sD11ZEU8VDC9CcFb/jGxrooMRmXPnDc8PPZQwgHHRQdgSM6lI92vYZCwB7kkrCl+
 I9OLWFlArLogEb8+zlnYv4x/w68IiuBGPdj8FKXQsVwN3M6AoTK7CiHIlTTZQ8z45HHpfmADZ/E
 1Ga/WvsHJfhxFxkDeRDgs7iBdMl/DXqrcP4AHjAcSOlREhxm3Sy0J/0gVQgHbnrMKVZ56Sa7OC+
 16xKqrwAK1sCCiKRrQ83t8jKDbRuKq0JIYmXJ50/i0OaqSwkE119pxRlR5zJTYk6QIXjUKXiAZP
 Vy+GMsi/78AZN86HcC828FtifbQwYb+3FmKcHxezFe8DoHqteY2MJqLebbhN18eTfAS9E4QeKOK
 PDci8SA9ihkojXHleQl/qnaGzwH1Tdu/by/FCqOviCVEnpaHs0diW4/zX0L23ewmbWBBP/4yRQ6
 9KbfFDvu5ReESsA3zwmymQ
X-Received: by 2002:a17:902:e945:b0:2d5:cbd3:8eb1 with SMTP id
 d9443c01a7336-2d64b162c6dmr134572675ad.3.1787418121428; 
 Sat, 22 Aug 2026 10:02:01 -0700 (PDT)
X-Received: by 2002:a17:902:e945:b0:2d5:cbd3:8eb1 with SMTP id
 d9443c01a7336-2d64b162c6dmr134572015ad.3.1787418120740; 
 Sat, 22 Aug 2026 10:02:00 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-327f9099ce7sm7760562eec.5.2026.08.22.10.01.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 22 Aug 2026 10:02:00 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Sat, 22 Aug 2026 22:31:34 +0530
Subject: [PATCH v7 2/2] drm/bridge: add support for lontium lt9211c bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-add-lt9211c-bridge-v7-2-7dcf567d57c4@oss.qualcomm.com>
References: <20260822-add-lt9211c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com>
In-Reply-To: <20260822-add-lt9211c-bridge-v7-0-7dcf567d57c4@oss.qualcomm.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Marek Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>,
 Nilesh Laad <nilesh.laad@oss.qualcomm.com>,
 Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>,
 Vishnu Saini <vishnu.saini@oss.qualcomm.com>,
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787418096; l=27304;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=XJDhulgWOumyfTXIC18fQ8+yd7Ir9WKc8wHP09KXZac=;
 b=iiRi2Spp+VnWwjg2KQBBnqQQP/eot4IY0ESr59hlr9AIaWsua1PxCVzlTsKjozXeE3+XHIUxq
 C77MvmnvHnHBFzbrUqq0KJz8XbLy89QEs7merJOPf1k2bcQGHUVOsgl
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIyMDE0MiBTYWx0ZWRfX5/5KnsYWgJ+N
 HLmT5iEauvwntr89qbULXHwkDWdvVUKHsWVPgddM8Veyb6pSb+4nFYaj7fadPEc2FAdZr2n3Tui
 KyjgvVYa9IlKMtwBgR4W4c0l2vB2RIo2cpEwk47S11iH606vRLab3X9pS79ixewRlrDrsBGB8hg
 S8KVPvpCcRXhhMytRuZPTOulSUk/tKZhmRDy4dIIbscU8T8mK3Pnxpsvyzb9u065Vdt/H7+SMNB
 0l1R6OGxSp/YZeeWGyYsY5Qh8d0S9qBoWTUtczHDg8xVXSmVzBj7pkpYiusTMa+rHs3sIQ5raqa
 /vk+cIJ9/XvKom9RGe72pdHFGHHXYBzcmyh7DETomiVdRcdJBX2T7N654N3la65zH+SLVLPBf5F
 MOICfeeFa+gHX/0+PfJ8NvpqXFikUObBrcQNwwQXibLrKt0s8ERMBQKn6pmSx/i8b2qAYEB8HBR
 WVnPS+CXSj+/va+kwOA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIyMDE0MiBTYWx0ZWRfX4WJlxLDLAnXL
 AiIich4U6s6FXAesf+Ewe/p2x/8CcgoA5B91GzzYjXC0KtxRNDWUcuciu7jc18uW1QSVe50qEJu
 UnkjDO5uEKvLWQF5JUhcPF6sHC6tGY4=
X-Proofpoint-GUID: aUA0SQMcNCDg3_Y4-tUm_a3M82PyIOq5
X-Proofpoint-ORIG-GUID: aUA0SQMcNCDg3_Y4-tUm_a3M82PyIOq5
X-Authority-Analysis: v=2.4 cv=e402j6p/ c=1 sm=1 tr=0 ts=6a89d60a cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=eLr6wqWVy7P3MxeJIX8A:9 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-22_05,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 adultscore=0 suspectscore=0 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608220142
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

From: Yi Zhang <zhanyi@qti.qualcomm.com>

LT9211C is a Single/Dual-Link DSI/LVDS or Single DPI input to
Single-Link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
Extend the existing lontium-lt9211 driver to support DSI-to-LVDS
bridge configuration by detecting and handling both LT9211 and LT9211C
variants from a single driver.

Chip detection in lt9211_read_chipid() is extended to identify the
LT9211C by its distinct chip ID registers.

Add LT9211C-specific regmap support and use lt9211_chip_data with
i2c_get_match_data() to provide per-chip configuration.

Five new functions implement the LT9211C DSI-to-LVDS initialisation
sequence: lt9211c_configure_rx(), lt9211c_autodetect_rx(),
lt9211c_configure_timing(), lt9211c_configure_plls() and
lt9211c_configure_tx().

Defer the remaining LT9211C initialization to a delayed work item
scheduled from atomic_enable(), since RX auto-detection requires an
active DSI stream.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
---
 drivers/gpu/drm/bridge/lontium-lt9211.c | 838 ++++++++++++++++++++++++++++++--
 1 file changed, 805 insertions(+), 33 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index 23682384daf4..d26789b610c1 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -8,6 +8,7 @@
  *   1xDSI -> 1xLVDS
  *
  * Copyright (C) 2022 Marek Vasut <marex@denx.de>
+ * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
  */
 
 #include <linux/bits.h>
@@ -19,6 +20,7 @@
 #include <linux/of_graph.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -27,6 +29,7 @@
 #include <drm/drm_panel.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
+#include <drm/drm_vblank.h>
 
 #define REG_PAGE_CONTROL			0xff
 #define REG_CHIPID0				0x8100
@@ -36,10 +39,28 @@
 #define REG_CHIPID2				0x8102
 #define REG_CHIPID2_VALUE			0xe3
 
+/* LT9211C chip ID values */
+#define REG_CHIPID0_LT9211C_VALUE		0x21
+#define REG_CHIPID1_LT9211C_VALUE		0x03
+#define REG_CHIPID2_LT9211C_VALUE		0xe1
+
 #define REG_DSI_LANE				0xd000
 /* DSI lane count - 0 means 4 lanes ; 1, 2, 3 means 1, 2, 3 lanes. */
 #define REG_DSI_LANE_COUNT(n)			((n) & 3)
 
+/* Chip type enum */
+enum lt9211_chip_type {
+	LT9211,
+	LT9211C,
+};
+
+struct lt9211_chip_data {
+	enum lt9211_chip_type		chip_type;
+	const struct regmap_config	*regmap_config;
+	const char			*dsi_type;
+	unsigned long			dsi_mode_flags;
+};
+
 struct lt9211 {
 	struct drm_bridge		bridge;
 	struct device			*dev;
@@ -50,6 +71,15 @@ struct lt9211 {
 	struct regulator		*vccio;
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
+	const struct lt9211_chip_data	*chip_data;
+	/* LT9211C specific fields */
+	struct workqueue_struct		*wq;
+	struct delayed_work		lt9211_dw;
+	struct drm_crtc			*lt9211c_crtc;
+	struct drm_display_mode	lt9211c_mode;
+	bool				lt9211c_bpp24;
+	bool				lt9211c_jeida;
+	bool				lt9211c_de_high;
 };
 
 static const struct regmap_range lt9211_rw_ranges[] = {
@@ -93,6 +123,65 @@ static const struct regmap_config lt9211_regmap_config = {
 	.max_register = 0xda00,
 };
 
+static const struct regmap_range lt9211c_rw_ranges[] = {
+	regmap_reg_range(0xff, 0xff),
+	regmap_reg_range(0x8100, 0x8182),
+	regmap_reg_range(0x8200, 0x82aa),
+	regmap_reg_range(0x8500, 0x85ff),
+	regmap_reg_range(0x8600, 0x86a0),
+	regmap_reg_range(0x8700, 0x8746),
+	regmap_reg_range(0xd000, 0xd0a7),
+	regmap_reg_range(0xd400, 0xd42c),
+	regmap_reg_range(0xd800, 0xd838),
+	regmap_reg_range(0xd9c0, 0xd9d5),
+};
+
+static const struct regmap_access_table lt9211c_rw_table = {
+	.yes_ranges = lt9211c_rw_ranges,
+	.n_yes_ranges = ARRAY_SIZE(lt9211c_rw_ranges),
+};
+
+static const struct regmap_range_cfg lt9211c_range = {
+	.name = "lt9211c",
+	.range_min = 0x0000,
+	.range_max = 0xda00,
+	.selector_reg = REG_PAGE_CONTROL,
+	.selector_mask = 0xff,
+	.selector_shift = 0,
+	.window_start = 0,
+	.window_len = 0x100,
+};
+
+static const struct regmap_config lt9211c_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.rd_table = &lt9211c_rw_table,
+	.wr_table = &lt9211c_rw_table,
+	.volatile_table = &lt9211c_rw_table,
+	.ranges = &lt9211c_range,
+	.num_ranges = 1,
+	.cache_type = REGCACHE_NONE,
+	.max_register = 0xda00,
+};
+
+static const struct lt9211_chip_data lt9211_chip_data = {
+	.chip_type = LT9211,
+	.regmap_config = &lt9211_regmap_config,
+	.dsi_type = "lt9211",
+	.dsi_mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+		MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
+		MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
+		MIPI_DSI_MODE_NO_EOT_PACKET,
+};
+
+static const struct lt9211_chip_data lt9211c_chip_data = {
+	.chip_type = LT9211C,
+	.regmap_config = &lt9211c_regmap_config,
+	.dsi_type = "lt9211c",
+	.dsi_mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		MIPI_DSI_MODE_LPM,
+};
+
 static struct lt9211 *bridge_to_lt9211(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct lt9211, bridge);
@@ -120,14 +209,23 @@ static int lt9211_read_chipid(struct lt9211 *ctx)
 		return ret;
 	}
 
-	/* Test for known Chip ID. */
-	if (chipid[0] != REG_CHIPID0_VALUE || chipid[1] != REG_CHIPID1_VALUE) {
-		dev_err(ctx->dev, "Unknown Chip ID: 0x%02x 0x%02x 0x%02x\n",
-			chipid[0], chipid[1], chipid[2]);
-		return -EINVAL;
+	/* Test for LT9211 Chip ID. */
+	if (chipid[0] == REG_CHIPID0_VALUE && chipid[1] == REG_CHIPID1_VALUE) {
+		dev_dbg(ctx->dev, "Detected LT9211 chip\n");
+		return 0;
 	}
 
-	return 0;
+	/* Test for LT9211C Chip ID. */
+	if (chipid[0] == REG_CHIPID0_LT9211C_VALUE &&
+	    chipid[1] == REG_CHIPID1_LT9211C_VALUE &&
+	    chipid[2] == REG_CHIPID2_LT9211C_VALUE) {
+		dev_dbg(ctx->dev, "Detected LT9211C chip\n");
+		return 0;
+	}
+
+	dev_err(ctx->dev, "Unknown Chip ID: 0x%02x 0x%02x 0x%02x\n",
+		chipid[0], chipid[1], chipid[2]);
+	return -EINVAL;
 }
 
 static int lt9211_system_init(struct lt9211 *ctx)
@@ -454,6 +552,657 @@ static int lt9211_configure_tx(struct lt9211 *ctx, bool jeida,
 	return 0;
 }
 
+static int lt9211c_configure_rx(struct lt9211 *ctx)
+{
+	unsigned int pval;
+
+	const struct reg_sequence lt9211c_rx_phy_seq[] = {
+		{ REG_DSI_LANE, REG_DSI_LANE_COUNT(ctx->dsi->lanes) },
+		{ 0x8201, 0x11 },
+		{ 0x8218, 0x48 },
+		{ 0x8201, 0x91 },
+		{ 0x8202, 0x00 },
+		{ 0x8203, 0xee },
+		{ 0x8209, 0x21 },
+		{ 0x8204, 0x44 },
+		{ 0x8205, 0xc4 },
+		{ 0x8206, 0x44 },
+		{ 0x8213, 0x0c },
+
+		{ 0xd001, 0x00 },
+		{ 0xd002, 0x0e },
+		{ 0xd005, 0x00 },
+		{ 0xd00a, 0x59 },
+		{ 0xd00b, 0x20 },
+	};
+
+	const struct reg_sequence lt9211c_rx_phy_reset_seq[] = {
+		{ 0x8109, 0xde },
+		{ 0x8109, 0xdf },
+	};
+
+	const struct reg_sequence lt9211c_rx_clk_sel_seq[] = {
+		{ 0x85e9, 0x88 },
+		{ 0x8180, 0x51 },
+		{ 0x8181, 0x10 },
+		{ 0x8632, 0x03 },
+	};
+
+	const struct reg_sequence lt9211c_rx_input_sel_seq[] = {
+		{ 0xd004, 0x00 },
+		{ 0xd021, 0x46 },
+	};
+
+	const struct reg_sequence lt9211c_rx_dig_seq[] = {
+		{ 0x853f, 0x08 },
+		{ 0x8540, 0x04 },
+		{ 0x8541, 0x03 },
+		{ 0x8542, 0x02 },
+		{ 0x8543, 0x01 },
+		{ 0x8545, 0x04 },
+		{ 0x8546, 0x03 },
+		{ 0x8547, 0x02 },
+		{ 0x8548, 0x01 },
+		{ 0x8544, 0x00 },
+		{ 0x8549, 0x00 },
+	};
+
+	int ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_seq,
+				     ARRAY_SIZE(lt9211c_rx_phy_seq));
+	if (ret) {
+		dev_err(ctx->dev, "RX: phy_seq write failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_reset_seq,
+				     ARRAY_SIZE(lt9211c_rx_phy_reset_seq));
+	if (ret) {
+		dev_err(ctx->dev, "RX: phy_reset_seq write failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_clk_sel_seq,
+				     ARRAY_SIZE(lt9211c_rx_clk_sel_seq));
+	if (ret) {
+		dev_err(ctx->dev, "RX: clk_sel_seq write failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_write_bits(ctx->regmap, 0x8180, 0x3, 0x3);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(ctx->regmap, 0x8680, &pval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x863f, (pval & 0xf8));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x863f, 0x05);
+	if (ret)
+		return ret;
+
+	ret = regmap_write_bits(ctx->regmap, 0x8530, 0x17, 0x11);
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_input_sel_seq,
+				     ARRAY_SIZE(lt9211c_rx_input_sel_seq));
+	if (ret) {
+		dev_err(ctx->dev, "RX: input_sel_seq write failed: %d\n", ret);
+		return ret;
+	}
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_dig_seq,
+				     ARRAY_SIZE(lt9211c_rx_dig_seq));
+	if (ret) {
+		dev_err(ctx->dev, "RX: dig_seq write failed: %d\n", ret);
+		return ret;
+	}
+
+	/* Give the chip time to lock onto RX stream. */
+	msleep(100);
+
+	return 0;
+}
+
+static int lt9211c_autodetect_rx(struct lt9211 *ctx,
+				 const struct drm_display_mode *mode)
+{
+	u16 width, height;
+	u8 buf[5];
+	u8 format;
+	u8 sot[8];
+	u8 hs_settle;
+	int ret;
+
+	/* Read the SOT from the chip. */
+	ret = regmap_bulk_read(ctx->regmap, 0xd088, sot, sizeof(sot));
+	if (ret) {
+		dev_err(ctx->dev, "RX: failed to read SOT (0xd088): %d\n", ret);
+		return ret;
+	}
+
+	dev_dbg(ctx->dev, "Sot Num = 0x%02x, 0x%02x, 0x%02x, 0x%02x\n",
+		sot[0], sot[2], sot[4], sot[6]);
+
+	dev_dbg(ctx->dev, "Sot Data = 0x%02x, 0x%02x, 0x%02x, 0x%02x\n",
+		sot[1], sot[3], sot[5], sot[7]);
+
+	/* HS Settle Set */
+	hs_settle = (sot[0] > 0x10 && sot[0] < 0x50) ? sot[0] - 5 : 0x08;
+	ret = regmap_write(ctx->regmap, 0xd002, hs_settle);
+	if (ret)
+		return ret;
+
+	/* Width/Height/Format Auto-detection */
+	ret = regmap_bulk_read(ctx->regmap, 0xd082, buf, sizeof(buf));
+	if (ret)
+		return ret;
+
+	width = (buf[0] << 8) | buf[1];
+	height = (buf[3] << 8) | buf[4];
+	format = buf[2] & 0xf;
+
+	if (format == 0x3) { /* YUV422 16bit */
+		width /= 2;
+	} else if (format == 0xa) { /* RGB888 24bit */
+		width /= 3;
+	} else {
+		dev_err(ctx->dev,
+			"Unsupported DSI format 0x%01x (0xd082=%02x %02x %02x %02x %02x)\n",
+			format, buf[0], buf[1], buf[2], buf[3], buf[4]);
+		return -EINVAL;
+	}
+
+	if (width != mode->hdisplay) {
+		dev_err(ctx->dev,
+			"RX: Detected DSI width (%d) does not match mode hdisplay (%d)\n",
+			width, mode->hdisplay);
+		return -EINVAL;
+	}
+
+	if (height != mode->vdisplay) {
+		dev_err(ctx->dev,
+			"RX: Detected DSI height (%d) does not match mode vdisplay (%d)\n",
+			height, mode->vdisplay);
+		return -EINVAL;
+	}
+
+	dev_dbg(ctx->dev, "RX: %dx%d format=0x%01x\n", width, height, format);
+
+	return 0;
+}
+
+static int lt9211c_configure_timing(struct lt9211 *ctx,
+				    const struct drm_display_mode *mode)
+{
+	int ret;
+
+	ret = lt9211_configure_timing(ctx, mode);
+	if (ret < 0)
+		return ret;
+
+	return regmap_write(ctx->regmap, 0xd04c,
+			    ((mode->hsync_end - mode->hsync_start) >> 8) & 0xff);
+}
+
+static int lt9211c_configure_plls(struct lt9211 *ctx,
+				  const struct drm_display_mode *mode)
+{
+	const struct reg_sequence lt9211c_dessc_pll_reset[] = {
+		{ 0x8103, 0xfe, 2000 },
+		{ 0x8103, 0xff, 0 },
+	};
+
+	const struct reg_sequence lt9211c_pcr_cali_seq[] = {
+		{ 0xd00a, 0x5f },
+		{ 0xd01e, 0x51 },
+		{ 0xd023, 0x80 },
+		{ 0xd024, 0x70 },
+		{ 0xd025, 0x80 },
+		{ 0xd02a, 0x10 },
+		{ 0xd021, 0x4f },
+		{ 0xd022, 0xf0 },
+		{ 0xd038, 0x04 },
+		{ 0xd039, 0x08 },
+		{ 0xd03a, 0x10 },
+		{ 0xd03b, 0x20 },
+		{ 0xd03f, 0x04 },
+		{ 0xd040, 0x08 },
+		{ 0xd041, 0x10 },
+		{ 0xd042, 0x20 },
+		{ 0xd02b, 0xa0 },
+	};
+
+	const struct reg_sequence lt9211c_pcr_reset_seq[] = {
+		{ 0xd009, 0xdb },
+		{ 0xd009, 0xdf },
+		{ 0xd008, 0x80 },
+		{ 0xd008, 0x00 },
+	};
+
+	unsigned int pval;
+	unsigned int val;
+	int ret;
+	u8 div;
+	u32 pcr_m;
+	u32 pcr_k;
+	u32 pcr_up;
+	u32 pcr_down;
+
+	/* DeSSC PLL reference clock is 25 MHz XTal. */
+	ret = regmap_write(ctx->regmap, 0x8226, 0x20);
+	if (ret)
+		return ret;
+
+	/* Prediv = 0 */
+	ret = regmap_write(ctx->regmap, 0x8227, 0x40);
+	if (ret)
+		return ret;
+
+	if (mode->clock < 44000) {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x07);
+		div = 16;
+	} else if (mode->clock < 88000) {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x06);
+		div = 8;
+	} else if (mode->clock < 176000) {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x05);
+		div = 4;
+	} else {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x04);
+		div = 2;
+	}
+
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x822c, mode->clock < 22000 ? 0x01 : 0x00);
+	if (ret)
+		return ret;
+
+	pcr_m = (mode->clock * div) / 25;
+	pcr_k = pcr_m % 1000;
+	pcr_m /= 1000;
+
+	pcr_up = pcr_m + 1;
+	pcr_down = pcr_m - 1;
+
+	pcr_k <<= 14;
+
+	ret = regmap_write(ctx->regmap, 0xd008, 0x00);
+	if (ret < 0)
+		return ret;
+
+	/* 0xd026: pcr_m */
+	ret = regmap_write(ctx->regmap, 0xd026, (u8)pcr_m & 0x7f);
+	if (ret < 0)
+		return ret;
+
+	/* 0xd027 0xd028 0xd029: pcr_k */
+	ret = regmap_write(ctx->regmap, 0xd027, (pcr_k >> 16) & 0xff);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0xd028, (pcr_k >> 8) & 0xff);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0xd029, pcr_k & 0xff);
+	if (ret < 0)
+		return ret;
+
+	/* 0xd02d: pcr_m overflow limit setting */
+	ret = regmap_write(ctx->regmap, 0xd02d, pcr_up);
+	if (ret < 0)
+		return ret;
+
+	/* 0xd031: pcr_m underflow limit setting */
+	ret = regmap_write(ctx->regmap, 0xd031, pcr_down);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_dessc_pll_reset,
+				     ARRAY_SIZE(lt9211c_dessc_pll_reset));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_pcr_cali_seq,
+				     ARRAY_SIZE(lt9211c_pcr_cali_seq));
+	if (ret)
+		return ret;
+
+	if (mode->clock < 44000)
+		val = 0x60;
+	else
+		val = 0x40;
+	ret = regmap_write(ctx->regmap, 0xd00c, val);
+	if (ret)
+		return ret;
+	ret = regmap_write(ctx->regmap, 0xd01b, 0x00);
+	if (ret)
+		return ret;
+	ret = regmap_write(ctx->regmap, 0xd01c, val);
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_pcr_reset_seq,
+				     ARRAY_SIZE(lt9211c_pcr_reset_seq));
+	if (ret)
+		return ret;
+
+	/* PCR stability test takes seconds. */
+	ret = regmap_read_poll_timeout(ctx->regmap, 0xd087, pval,
+				       ((pval & 0x18) == 0x18), 20000, 3000000);
+	if (ret)
+		dev_err(ctx->dev, "PCR unstable, ret=%i\n", ret);
+
+	ret = regmap_write(ctx->regmap, 0x8180, 0x51);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x863f, 0x00);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x863f, 0x01);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(ctx->regmap, 0x8640, pval,
+				       ((pval & 0x01) == 0x01), 50000, 250000);
+	if (ret)
+		dev_err(ctx->dev, "Video check not stable, ret=%i\n", ret);
+
+	return ret;
+}
+
+static int lt9211c_configure_tx(struct lt9211 *ctx, bool jeida, bool bpp24,
+				bool de, const struct drm_display_mode *mode)
+{
+	const struct reg_sequence lt9211c_tx_phy_off_seq[] = {
+		{ 0x8236, 0x00 },
+		{ 0x8237, 0x00 },
+		{ 0x8108, 0x6f },
+		{ 0x8103, 0xbf },
+	};
+
+	const struct reg_sequence lt9211c_tx_phy_seq[] = {
+		{ 0x8236, 0x03 },
+		{ 0x8237, 0x44 },
+		{ 0x8238, 0x14 },
+		{ 0x8239, 0x31 },
+		{ 0x823a, 0xc8 },
+		{ 0x823b, 0x00 },
+		{ 0x823c, 0x0f },
+		{ 0x8246, 0x40 },
+		{ 0x8247, 0x40 },
+		{ 0x8248, 0x40 },
+		{ 0x8249, 0x40 },
+		{ 0x824a, 0x40 },
+		{ 0x824b, 0x40 },
+		{ 0x824c, 0x40 },
+		{ 0x824d, 0x40 },
+		{ 0x824e, 0x40 },
+		{ 0x824f, 0x40 },
+		{ 0x8250, 0x40 },
+		{ 0x8251, 0x40 },
+	};
+
+	const struct reg_sequence lt9211c_tx_mltx_reset[] = {
+		{ 0x8103, 0xbf },
+		{ 0x8103, 0xff },
+	};
+
+	const struct reg_sequence lt9211c_tx_dig_seq[] = {
+		{ 0x854a, 0x01 },
+		{ 0x854b, 0x00 },
+		{ 0x854c, 0x10 },
+		{ 0x854d, 0x20 },
+		{ 0x854e, 0x50 },
+		{ 0x854f, 0x30 },
+		{ 0x8550, 0x46 },
+		{ 0x8551, 0x10 },
+		{ 0x8552, 0x20 },
+		{ 0x8553, 0x50 },
+		{ 0x8554, 0x30 },
+		{ 0x8555, 0x00 },
+		{ 0x8556, 0x20 },
+
+		{ 0x8568, 0x00 },
+		{ 0x856e, 0x10 | (de ? BIT(6) : 0) },
+		{ 0x856f, 0x81 | (jeida ? BIT(6) : 0) |
+				  (ctx->lvds_dual_link ? BIT(4) : 0) |
+				  (bpp24 ? BIT(2) : 0) },
+	};
+
+	const struct reg_sequence lt9211c_tx_ssc_seq[] = {
+		{ 0x8234, 0x00 },
+		{ 0x856e, 0x10 },
+		{ 0x8181, 0x15 },
+		{ 0x871e, 0x00 },
+		{ 0x8717, 0x02 },
+		{ 0x8718, 0x04 },
+		{ 0x8719, 0xd4 },
+		{ 0x871a, 0x00 },
+		{ 0x871b, 0x12 },
+		{ 0x871c, 0x00 },
+		{ 0x871d, 0x24 },
+		{ 0x871f, 0x1c },
+		{ 0x8720, 0x00 },
+		{ 0x8721, 0x00 },
+		{ 0x871e, 0x02 },
+	};
+
+	const struct reg_sequence lt9211c_tx_pll_reset_seq[] = {
+		{ 0x810c, 0xfe, 2000 },
+		{ 0x810c, 0xff, 0 },
+	};
+
+	const struct reg_sequence lt9211c_tx_sw_reset_seq[] = {
+		{ 0x8108, 0x6f, 2000 },
+		{ 0x8108, 0x7f, 0 },
+	};
+
+	unsigned int pval;
+	int ret;
+	u32 phy_clk;
+	u8 pixclk_div;
+	u8 pre_div;
+	u8 div_set;
+	u8 sericlk_div;
+	u8 val;
+
+	dev_dbg(ctx->dev,
+		"dual_link=%d,even_odd_swap=%d,bpp24=%d,jeida=%d,de=%d\n",
+		ctx->lvds_dual_link, ctx->lvds_dual_link_even_odd_swap,
+		bpp24, jeida, de);
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_phy_off_seq,
+				     ARRAY_SIZE(lt9211c_tx_phy_off_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_write_bits(ctx->regmap, 0x8530, 0xc0, 0x40);
+	if (ret)
+		return ret;
+
+	/* [7]0:txpll normal work; txpll ref clk sel pix clk */
+	ret = regmap_write(ctx->regmap, 0x8230, 0x00);
+	if (ret)
+		return ret;
+
+	if (ctx->lvds_dual_link)
+		phy_clk = (u32)(mode->clock * 7 / 2);
+	else
+		phy_clk = (u32)(mode->clock * 7);
+
+	/* 0x8231: prediv sel */
+	if (mode->clock < 40000) {
+		val = 0x28;
+		pre_div = 1;
+	} else if (mode->clock < 80000) {
+		val = 0x29;
+		pre_div = 2;
+	} else if (mode->clock < 160000) {
+		val = 0x2a;
+		pre_div = 4;
+	} else if (mode->clock < 320000) {
+		val = 0x2b;
+		pre_div = 8;
+	} else {
+		val = 0x2f;
+		pre_div = 16;
+	}
+	ret = regmap_write(ctx->regmap, 0x8231, val);
+	if (ret < 0)
+		return ret;
+
+	/* 0x8232: serickdiv sel */
+	if (phy_clk < 80000) {
+		val = 0x32;
+		sericlk_div = 16;
+	} else if (phy_clk < 160000) {
+		val = 0x22;
+		sericlk_div = 8;
+	} else if (phy_clk < 320000) {
+		val = 0x12;
+		sericlk_div = 4;
+	} else if (phy_clk < 640000) {
+		val = 0x02;
+		sericlk_div = 2;
+	} else {
+		val = 0x42;
+		sericlk_div = 1;
+	}
+	ret = regmap_write(ctx->regmap, 0x8232, val);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * 0x8233: pix_mux sel & pix_div sel
+	 * To avoid floating point operations, The pixclk_div is enlarged by 10 times
+	 */
+	if (mode->clock > 150000) {
+		val = 0x04;
+		pixclk_div = 35;
+	} else {
+		pixclk_div =
+			(u8)((phy_clk * sericlk_div * 10) / (mode->clock * 7));
+		if (pixclk_div <= 10)
+			val = 0x00;
+		else if (pixclk_div <= 20)
+			val = 0x01;
+		else if (pixclk_div <= 40)
+			val = 0x02;
+		else
+			val = 0x03;
+	}
+	ret = regmap_write(ctx->regmap, 0x8233, val);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x8234, 0x01);
+	if (ret < 0)
+		return ret;
+
+	/* 0x8235: div set */
+	div_set = (u8)(phy_clk * sericlk_div / mode->clock / pre_div);
+	ret = regmap_write(ctx->regmap, 0x8235, div_set);
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_ssc_seq,
+				     ARRAY_SIZE(lt9211c_tx_ssc_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_pll_reset_seq,
+				     ARRAY_SIZE(lt9211c_tx_pll_reset_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(ctx->regmap, 0x8739, pval, pval & 0x04,
+				       10000, 1000000);
+	if (ret) {
+		dev_err(ctx->dev, "TX PLL unstable, ret=%i\n", ret);
+		return ret;
+	}
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_phy_seq,
+				     ARRAY_SIZE(lt9211c_tx_phy_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_mltx_reset,
+				     ARRAY_SIZE(lt9211c_tx_mltx_reset));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_dig_seq,
+				     ARRAY_SIZE(lt9211c_tx_dig_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_sw_reset_seq,
+				     ARRAY_SIZE(lt9211c_tx_sw_reset_seq));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static void lt9211_delayed_work_func(struct work_struct *work)
+{
+	struct delayed_work *dw = to_delayed_work(work);
+	struct lt9211 *ctx = container_of(dw, struct lt9211, lt9211_dw);
+	const struct drm_display_mode *mode = &ctx->lt9211c_mode;
+	int ret;
+
+	/* wait for vblank irq to correctly configure bridge and autodetect stream */
+	ret = drm_crtc_wait_one_vblank(ctx->lt9211c_crtc);
+	if (ret) {
+		dev_err(ctx->dev, "LT9211C: wait for vblank failed: %d\n", ret);
+		return;
+	}
+
+	ret = lt9211c_configure_rx(ctx);
+	if (ret) {
+		dev_err(ctx->dev, "LT9211C: configure_rx failed: %d\n", ret);
+		return;
+	}
+
+	ret = lt9211c_autodetect_rx(ctx, mode);
+	if (ret) {
+		dev_err(ctx->dev, "LT9211C: autodetect_rx failed: %d\n", ret);
+		return;
+	}
+
+	ret = lt9211c_configure_timing(ctx, mode);
+	if (ret) {
+		dev_err(ctx->dev, "LT9211C: configure_timing failed: %d\n", ret);
+		return;
+	}
+
+	ret = lt9211c_configure_plls(ctx, mode);
+	if (ret) {
+		dev_err(ctx->dev, "LT9211C: configure_plls failed: %d\n", ret);
+		return;
+	}
+
+	ret = lt9211c_configure_tx(ctx, ctx->lt9211c_jeida, ctx->lt9211c_bpp24,
+				   ctx->lt9211c_de_high, mode);
+	if (ret) {
+		dev_err(ctx->dev, "LT9211C: configure_tx failed: %d\n", ret);
+		return;
+	}
+}
+
 static void lt9211_atomic_enable(struct drm_bridge *bridge,
 				 struct drm_atomic_commit *state)
 {
@@ -523,6 +1272,21 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
 	if (ret)
 		return;
 
+	if (ctx->chip_data->chip_type == LT9211C) {
+		drm_mode_copy(&ctx->lt9211c_mode, mode);
+		ctx->lt9211c_bpp24 = lvds_format_24bpp;
+		ctx->lt9211c_jeida = lvds_format_jeida;
+		ctx->lt9211c_de_high = !!(bus_flags & DRM_BUS_FLAG_DE_HIGH);
+		ctx->lt9211c_crtc = crtc;
+
+		/*
+		 * Needs a live DSI stream to auto-detect RX resolution/format;
+		 * defer bridge configuration until after vblank.
+		 */
+		queue_delayed_work(ctx->wq, &ctx->lt9211_dw, 0);
+		return;
+	}
+
 	ret = lt9211_system_init(ctx);
 	if (ret)
 		return;
@@ -557,6 +1321,9 @@ static void lt9211_atomic_disable(struct drm_bridge *bridge,
 	struct lt9211 *ctx = bridge_to_lt9211(bridge);
 	int ret;
 
+	if (ctx->chip_data->chip_type == LT9211C)
+		cancel_delayed_work_sync(&ctx->lt9211_dw);
+
 	/*
 	 * Put the chip in reset, pull nRST line low,
 	 * and assure lengthy 10ms reset low timing.
@@ -672,14 +1439,13 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
 
 static int lt9211_host_attach(struct lt9211 *ctx)
 {
-	const struct mipi_dsi_device_info info = {
-		.type = "lt9211",
-		.channel = 0,
-		.node = NULL,
-	};
 	struct device *dev = ctx->dev;
 	struct device_node *host_node;
 	struct device_node *endpoint;
+	struct mipi_dsi_device_info info = {
+		.channel = 0,
+		.node = NULL,
+	};
 	struct mipi_dsi_device *dsi;
 	struct mipi_dsi_host *host;
 	int dsi_lanes;
@@ -698,6 +1464,7 @@ static int lt9211_host_attach(struct lt9211 *ctx)
 	if (dsi_lanes < 0)
 		return dsi_lanes;
 
+	strscpy(info.type, ctx->chip_data->dsi_type, sizeof(info.type));
 	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
 	if (IS_ERR(dsi))
 		return dev_err_probe(dev, PTR_ERR(dsi),
@@ -707,10 +1474,7 @@ static int lt9211_host_attach(struct lt9211 *ctx)
 
 	dsi->lanes = dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
-			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
-			  MIPI_DSI_MODE_NO_EOT_PACKET;
+	dsi->mode_flags = ctx->chip_data->dsi_mode_flags;
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
@@ -721,6 +1485,11 @@ static int lt9211_host_attach(struct lt9211 *ctx)
 	return 0;
 }
 
+static void lt9211_destroy_wq(void *data)
+{
+	destroy_workqueue(data);
+}
+
 static int lt9211_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -748,45 +1517,48 @@ static int lt9211_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ctx->regmap = devm_regmap_init_i2c(client, &lt9211_regmap_config);
+	ctx->chip_data = i2c_get_match_data(client);
+	if (!ctx->chip_data)
+		return -ENODEV;
+
+	ctx->regmap = devm_regmap_init_i2c(client, ctx->chip_data->regmap_config);
 	if (IS_ERR(ctx->regmap))
 		return PTR_ERR(ctx->regmap);
 
-	dev_set_drvdata(dev, ctx);
-	i2c_set_clientdata(client, ctx);
+	if (ctx->chip_data->chip_type == LT9211C) {
+		ctx->wq = create_workqueue("lt9211_work");
+		if (!ctx->wq)
+			return -ENOMEM;
+		ret = devm_add_action_or_reset(dev, lt9211_destroy_wq, ctx->wq);
+		if (ret)
+			return ret;
+		INIT_DELAYED_WORK(&ctx->lt9211_dw, lt9211_delayed_work_func);
+	}
 
 	ctx->bridge.of_node = dev->of_node;
-	drm_bridge_add(&ctx->bridge);
-
-	ret = lt9211_host_attach(ctx);
+	ret = devm_drm_bridge_add(dev, &ctx->bridge);
 	if (ret)
-		drm_bridge_remove(&ctx->bridge);
-
-	return ret;
-}
-
-static void lt9211_remove(struct i2c_client *client)
-{
-	struct lt9211 *ctx = i2c_get_clientdata(client);
+		return ret;
 
-	drm_bridge_remove(&ctx->bridge);
+	return lt9211_host_attach(ctx);
 }
 
 static const struct i2c_device_id lt9211_id[] = {
-	{ .name = "lontium,lt9211" },
+	{ .name = "lontium,lt9211", .driver_data = (kernel_ulong_t)&lt9211_chip_data },
+	{ .name = "lontium,lt9211c", .driver_data = (kernel_ulong_t)&lt9211c_chip_data },
 	{ }
 };
 MODULE_DEVICE_TABLE(i2c, lt9211_id);
 
 static const struct of_device_id lt9211_match_table[] = {
-	{ .compatible = "lontium,lt9211" },
+	{ .compatible = "lontium,lt9211", .data = &lt9211_chip_data },
+	{ .compatible = "lontium,lt9211c", .data = &lt9211c_chip_data },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lt9211_match_table);
 
 static struct i2c_driver lt9211_driver = {
 	.probe = lt9211_probe,
-	.remove = lt9211_remove,
 	.id_table = lt9211_id,
 	.driver = {
 		.name = "lt9211",

-- 
2.34.1

