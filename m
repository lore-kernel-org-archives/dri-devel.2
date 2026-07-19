Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B5F3C4451B
	for <dri-devel@archiver.kernel.org>; Sun, 19 Jul 2026 15:57:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDF4D10E05E;
	Sun, 19 Jul 2026 15:57:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="bHE4uSUM";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="OPr9Puwh";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6113F10E05C
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:57 +0000 (UTC)
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66JDwB6B3631889
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 aGcb4eMd9z/a0/rXiO0nptznlsb6DIrZY2TrTCZVVB4=; b=bHE4uSUMwlJDV5CY
 EZ38/QJqFUMYh1ds4U7kpsmVOWCa9B5e0gdZTMoWsJQExKKElgJZt4X5j7FsfN5/
 pRnKE9MlfTp+NfMMLATIxE0/f0dg0gYKIOZcFXAxLNkmBRtDeTyRCfYSTkHTgGXi
 mpi2RbIf59xAK72lV8m/v7JSJkB3ZfZhA1xz6SfAFaXUjFAmSZ7RTu/fPoLWKoDq
 SC21DKuGuIK9ApSxFjFlzRupkIFz12CSCG89KM5zsJIQDMjqwujHl7tWETg0VatE
 k2q+mUQZ7oefchnE1+xhv7xtOkutTztEcpv6qArAlvgFPv04+weeFtps3O6L4dxd
 yHuXyw==
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fg2chk0j2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 15:57:55 +0000 (GMT)
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cf4b8ea6f1so4342845ad.2
 for <dri-devel@lists.freedesktop.org>; Sun, 19 Jul 2026 08:57:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784476675; x=1785081475;
 darn=lists.freedesktop.org; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aGcb4eMd9z/a0/rXiO0nptznlsb6DIrZY2TrTCZVVB4=;
 b=OPr9PuwhEhaaF06deYePl5Ep66aaNIMZgzFESW7YrWfRhM/wL91moc+OuIQ95bKSMQ
 HrT20ppCyzk7WuTYQm08/rMIAq3KSU2DHLKB8rn8OTOMnuVaD+hCGgoYR5/vsQl6p41+
 V1yEzlMt5HGiLj2/PB42CFjg5ZdNwX1TjRiA02i7DXMj0VJ8rXIGn7LDyVBSUlBuLrL6
 cJonJiaSxkcdmxROM42QMwc4l8ygbI65k9hIZlifdyvLJQI/4iqS1sm0rjmZNkkJi6Ng
 QhUPepH6nDGJvEkW9IsUWpN7EniK4x8L+tlDgPreaAzPGLreWIAupCWOkN2Cy9slZKat
 fACQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784476675; x=1785081475;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=aGcb4eMd9z/a0/rXiO0nptznlsb6DIrZY2TrTCZVVB4=;
 b=RxuzTI17osOpAwjrapmKGYbEyRGnijvRipoaBHlD0bWG2FXU2E8JXxn6b0nqKKeoai
 IbjcmUCoP5Ye0+I0nbykcH13H/hxO9NZ9u/4gnRnZDA9h+4CsfU/SrwqPjng236fFmeY
 xfPRo6dD8Jz6rjqd8+KAupq2RZBGzG75R//DogN+UFAhbQg7EyKlY7AURKZbdO0BcwBC
 NU6rshM1c8MpWAqQxHpdgCwqrYl4Go7PWsFCyE1mwMMdGZWX4kq9lVx3kR6R72Vu/Tk9
 D3VNa1zzdmluo39a2A6NS2CuDceDy1zAXKRC/Y6Q4hsp1/aYJulq9bPPgQRQo4L9pPHf
 MlTg==
X-Gm-Message-State: AOJu0YwA9+AORKE1/nBr1px3uBFKvCMfftL9bMXQSQNa018WB+rwuFmX
 03CK33brO1pZa/WAh+uXYzPSh86MPGraPAc1vfmU2R4oV2vS2Se1NMb2ymDlfnXcA6DeSiSWw1y
 w9mH9IyC5dpBnHZSnPU3brGW1PKhoPO6g9FUcAAshvA3jN8BD9i1HdRMZ3yBMkmKpadDtsVw8Vw
 9VSbs=
X-Gm-Gg: AfdE7cmvJaAuAbPnvaKwRd5hf/5xjBKztbk7tTPBi3eZ48/NfUome3En1QpKPh+TNJW
 mYorIOkl4yhU3cjk/qu8YEpD6yvwFmwGufPRKhLWZnnDLtn8QB4NUCQzp28PgPfFNBn2bwtXd7s
 /w++9sfl35QgSj9S2vgh+TsInQlZBX+3RTyQ92XNmi1midzvmE1xYuhWGI5kTmRZN+Gi0v/1hw+
 qYPYcMicGUI6tsy/wCNkN/t7muuk4TyLp5WuDu8+yLiaEyWoYctdEAU7s79L0fBUJsi6RNH0yOm
 SH98X0dlQgGoHEsrijafs1llv3dPUHtKqXOKBu5aQkUCbYCvfXo9m/ICdduKZn6F+QEU3siVvit
 XlgOF+RxtbUYuY++6+qjzayGypIupph5r9OB+q3nTddVcR/pHbcPaOL8r8oaNI8j5YZeZVLpd40
 R90AcTUBM5Qw9O97ndnmS4
X-Received: by 2002:a05:6a20:9397:b0:3c3:a17c:1f70 with SMTP id
 adf61e73a8af0-3c3ad8fc609mr8466843637.3.1784476674752; 
 Sun, 19 Jul 2026 08:57:54 -0700 (PDT)
X-Received: by 2002:a05:6a20:9397:b0:3c3:a17c:1f70 with SMTP id
 adf61e73a8af0-3c3ad8fc609mr8466815637.3.1784476674215; 
 Sun, 19 Jul 2026 08:57:54 -0700 (PDT)
Received: from hu-vishsain-blr.qualcomm.com
 (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com. [103.229.18.19])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31429f9d439sm33127054eec.5.2026.07.19.08.57.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Jul 2026 08:57:53 -0700 (PDT)
From: vishnu.saini@oss.qualcomm.com
Date: Sun, 19 Jul 2026 21:27:26 +0530
Subject: [PATCH v6 2/2] drm/bridge: add support for lontium lt9211c bridge
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
References: <20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com>
In-Reply-To: <20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com>
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
 venkata.valluru@oss.qualcomm.com, Jessica Zhang <jesszhan0024@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784476650; l=25460;
 i=vishnu.saini@oss.qualcomm.com; s=20251113; h=from:subject:message-id;
 bh=CEWhuxike/xonu/LNAUiHt9/lWCj3pxLilF9Sy3kvpU=;
 b=na3/u3JfPfnPPaSl6YTkDqQy21X8tG+tJpNjl/YwaJqAlctBlVvoOtYFEoXL1kYI0tya6jRKe
 cc0dxNAX10FCnMr0a+acdKPVS2BKcpUdN6oDNeLIRbiTYVXy7nphZeT
X-Developer-Key: i=vishnu.saini@oss.qualcomm.com; a=ed25519;
 pk=8hlXlF8j/3GeOaDK3w2LYhkv9FanCQru0c7kRH/It7k=
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE5MDE3NyBTYWx0ZWRfX+bVkjv5Pr1IE
 /8VfQNAkV60qgulE11WbSGfVf/8n/N7xdTseFTamDZKy43cFHN0Lfsa2Y7pYX23DIdDocI4IFoh
 N4XiCSGd7/W+hPXvMSVDiV524x2slE4=
X-Proofpoint-GUID: vEoE0L4qTM1TUwdDmT5cBhv4PJzqZ3fI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE5MDE3NyBTYWx0ZWRfX9ryku5SPeCCG
 vR+QcBO62OZjEtofnjDnehJZIYLyzLqnvuPRztwV4RXity6+9xKnCJ2CBDGjyhkmxyXM7n/tLJ/
 HqEU8U5PZSkjXYLoqhI0gqmH8ljmEUgsEGcwk0LmQCYrrSoMxLQCyRm8UKCWxoxkgHw3cP74aLN
 bds3aiq94thCPPqY0fc/c0wzcVHRfgZ6FOwBX5LaXbkoLdZF/iXg+u/QrpWfah1MdFmIMCZPZ5I
 oq9k8LXw3oOLOMi8mUJfk2cxCFUuMt9FzfP8sZIy5PwuWMs5GUkRaBHoBe6/Nudsllp90NEn420
 TmzPfUCL0m5t7C48VMdmoyI3RC0U7ZIYOtMZtJ/9/M23aIIY1aHMfhfCPRkd5OKFeR8Kh8Bovzt
 leH7nHurlhVuE73J0LTOj9tre5D3RJTaoVngBhYEI4OYEDdKqKtn/lck4BhKWhf8FDXdqTIVEfR
 Xj8Jx3bq2570G8Qqg8A==
X-Authority-Analysis: v=2.4 cv=T5K8ifKQ c=1 sm=1 tr=0 ts=6a5cf404 cx=c_pps
 a=IZJwPbhc+fLeJZngyXXI0A==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=tmt1WsRZ4yB1p4KVow4A:9 a=QEXdDO2ut3YA:10
 a=uG9DUKGECoFWVXl0Dc02:22
X-Proofpoint-ORIG-GUID: vEoE0L4qTM1TUwdDmT5cBhv4PJzqZ3fI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-19_05,2026-07-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607190177
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

A separate regmap configuration is introduced for LT9211C to cover
its extended register map. The chip_type field added to struct lt9211
selects the appropriate regmap and code paths at probe time using
of_device_is_compatible().

Five new functions implement the LT9211C DSI-to-LVDS initialisation
sequence: lt9211c_configure_rx(), lt9211c_autodetect_rx(),
lt9211c_configure_timing(), lt9211c_configure_plls() and
lt9211c_configure_tx(). The LT9211C requires DSI clocks to be running
before the bridge can be initialised, so lt9211_atomic_enable() queues
a delayed workqueue item for LT9211C rather than initialising
synchronously as LT9211 does.

LT9211C uses VIDEO|LPM DSI mode flags, which differ from the
sync-pulse mode used by LT9211.

Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
---
 drivers/gpu/drm/bridge/lontium-lt9211.c | 796 +++++++++++++++++++++++++++++++-
 1 file changed, 779 insertions(+), 17 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/bridge/lontium-lt9211.c
index f39d83a5ae37..36c004df34fc 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9211.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
@@ -19,6 +19,7 @@
 #include <linux/of_graph.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/workqueue.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -36,10 +37,21 @@
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
 struct lt9211 {
 	struct drm_bridge		bridge;
 	struct device			*dev;
@@ -50,6 +62,14 @@ struct lt9211 {
 	struct regulator		*vccio;
 	bool				lvds_dual_link;
 	bool				lvds_dual_link_even_odd_swap;
+	/* LT9211C specific fields */
+	enum lt9211_chip_type		chip_type;
+	struct workqueue_struct		*wq;
+	struct delayed_work		lt9211_dw;
+	struct drm_display_mode		mode;
+	bool				bpp24;
+	bool				jeida;
+	bool				de;
 };
 
 static const struct regmap_range lt9211_rw_ranges[] = {
@@ -93,6 +113,49 @@ static const struct regmap_config lt9211_regmap_config = {
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
+	.cache_type = REGCACHE_RBTREE,
+	.max_register = 0xda00,
+};
+
+static void lt9211_delayed_work_func(struct work_struct *work);
+
 static struct lt9211 *bridge_to_lt9211(struct drm_bridge *bridge)
 {
 	return container_of(bridge, struct lt9211, bridge);
@@ -120,14 +183,23 @@ static int lt9211_read_chipid(struct lt9211 *ctx)
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
@@ -454,6 +526,651 @@ static int lt9211_configure_tx(struct lt9211 *ctx, bool jeida,
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
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_reset_seq,
+				     ARRAY_SIZE(lt9211c_rx_phy_reset_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_clk_sel_seq,
+				     ARRAY_SIZE(lt9211c_rx_clk_sel_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(ctx->regmap, 0x8180, &pval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x8180, ((pval & 0xfc) | 0x03));
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
+	ret = regmap_read(ctx->regmap, 0x8530, &pval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x8530, ((pval & 0xf8) | 0x11));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_input_sel_seq,
+				     ARRAY_SIZE(lt9211c_rx_input_sel_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_rx_dig_seq,
+				     ARRAY_SIZE(lt9211c_rx_dig_seq));
+	if (ret)
+		return ret;
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
+	int ret;
+
+	/* Read the SOT from the chip. */
+	ret = regmap_bulk_read(ctx->regmap, 0xd088, sot, sizeof(sot));
+	if (ret)
+		return ret;
+
+	dev_dbg(ctx->dev, "Sot Num = 0x%02x, 0x%02x, 0x%02x, 0x%02x\n", sot[0],
+		sot[2], sot[4], sot[6]);
+
+	dev_dbg(ctx->dev, "Sot Data = 0x%02x, 0x%02x, 0x%02x, 0x%02x\n", sot[1],
+		sot[3], sot[5], sot[7]);
+	/* HS Settle Set */
+	if (sot[0] > 0x10 && sot[0] < 0x50)
+		regmap_write(ctx->regmap, 0xd002, sot[0] - 5);
+	else
+		regmap_write(ctx->regmap, 0xd002, 0x08);
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
+		dev_err(ctx->dev, "Unsupported DSI format 0x%01x\n", format);
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
+	return 0;
+}
+
+static int lt9211c_configure_timing(struct lt9211 *ctx,
+				    const struct drm_display_mode *mode)
+{
+	const struct reg_sequence lt9211c_timing[] = {
+		{ 0xd00d, (mode->vtotal >> 8) & 0xff },
+		{ 0xd00e, mode->vtotal & 0xff },
+		{ 0xd00f, (mode->vdisplay >> 8) & 0xff },
+		{ 0xd010, mode->vdisplay & 0xff },
+		{ 0xd011, (mode->htotal >> 8) & 0xff },
+		{ 0xd012, mode->htotal & 0xff },
+		{ 0xd013, (mode->hdisplay >> 8) & 0xff },
+		{ 0xd014, mode->hdisplay & 0xff },
+		{ 0xd015, (mode->vsync_end - mode->vsync_start) & 0xff },
+		{ 0xd04c, ((mode->hsync_end - mode->hsync_start) >> 8) & 0xff },
+		{ 0xd016, (mode->hsync_end - mode->hsync_start) & 0xff },
+		{ 0xd017, ((mode->vsync_start - mode->vdisplay) >> 8) & 0xff },
+		{ 0xd018, (mode->vsync_start - mode->vdisplay) & 0xff },
+		{ 0xd019, ((mode->hsync_start - mode->hdisplay) >> 8) & 0xff },
+		{ 0xd01a, (mode->hsync_start - mode->hdisplay) & 0xff },
+	};
+
+	return regmap_multi_reg_write(ctx->regmap, lt9211c_timing,
+				      ARRAY_SIZE(lt9211c_timing));
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
+	if (mode->clock < 22000) {
+		ret = regmap_write(ctx->regmap, 0x822f, 0x07);
+		ret |= regmap_write(ctx->regmap, 0x822c, 0x01);
+		div = 16;
+	} else if (mode->clock < 44000) {
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
+	ret = regmap_write(ctx->regmap, 0xd026, (0x80 | (u8)pcr_m) & 0x7f);
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
+	if (mode->clock < 44000) {
+		ret = regmap_write(ctx->regmap, 0xd00c, 0x60);
+		ret |= regmap_write(ctx->regmap, 0xd01b, 0x00);
+		ret |= regmap_write(ctx->regmap, 0xd01c, 0x60);
+	} else {
+		ret = regmap_write(ctx->regmap, 0xd00c, 0x40);
+		ret |= regmap_write(ctx->regmap, 0xd01b, 0x00);
+		ret |= regmap_write(ctx->regmap, 0xd01c, 0x40);
+	}
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
+static int lt9211c_configure_tx(struct lt9211 *ctx,
+				const struct drm_display_mode *mode)
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
+		{ 0x856e, 0x10 | (ctx->de ? BIT(6) : 0) },
+		{ 0x856f, 0x81 | (ctx->jeida ? BIT(6) : 0) |
+				  (ctx->lvds_dual_link ? BIT(4) : 0) |
+				  (ctx->bpp24 ? BIT(2) : 0) },
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
+	dev_info(ctx->dev,
+		 "dual_link=%d,even_odd_swap=%d,bpp24=%d,jeida=%d,de=%d\n",
+		 ctx->lvds_dual_link, ctx->lvds_dual_link_even_odd_swap,
+		 ctx->bpp24, ctx->jeida, ctx->de);
+
+	ret = regmap_multi_reg_write(ctx->regmap, lt9211c_tx_phy_off_seq,
+				     ARRAY_SIZE(lt9211c_tx_phy_off_seq));
+	if (ret)
+		return ret;
+
+	ret = regmap_read(ctx->regmap, 0x8530, &pval);
+	if (ret)
+		return ret;
+
+	ret = regmap_write(ctx->regmap, 0x8530, ((pval & 0x3f) | 0x40));
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
+	if (mode->clock < 20000) {
+		val = 0x28;
+		pre_div = 1;
+	} else if (mode->clock < 40000) {
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
+	const struct drm_display_mode *mode = &ctx->mode;
+	int ret;
+
+	if (ctx->chip_type != LT9211C) {
+		dev_err(ctx->dev, "LT9211: Delayed work called for non-LT9211C chip\n");
+		return;
+	}
+
+	ret = lt9211c_configure_rx(ctx);
+	if (ret)
+		return;
+
+	ret = lt9211c_autodetect_rx(ctx, mode);
+	if (ret)
+		return;
+
+	ret = lt9211c_configure_timing(ctx, mode);
+	if (ret)
+		return;
+
+	ret = lt9211c_configure_plls(ctx, mode);
+	if (ret)
+		return;
+
+	ret = lt9211c_configure_tx(ctx, mode);
+	if (ret)
+		return;
+}
+
 static void lt9211_atomic_enable(struct drm_bridge *bridge,
 				 struct drm_atomic_commit *state)
 {
@@ -523,6 +1240,15 @@ static void lt9211_atomic_enable(struct drm_bridge *bridge,
 	if (ret)
 		return;
 
+	if (ctx->chip_type == LT9211C && ctx->wq) {
+		drm_mode_copy(&ctx->mode, mode);
+		/* LT9211C must enable after mipi clock enable */
+		queue_delayed_work(ctx->wq, &ctx->lt9211_dw,
+				   msecs_to_jiffies(100));
+		dev_dbg(ctx->dev, "LT9211C enabled.\n");
+		return;
+	}
+
 	ret = lt9211_system_init(ctx);
 	if (ret)
 		return;
@@ -671,11 +1397,6 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
 
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
@@ -697,7 +1418,22 @@ static int lt9211_host_attach(struct lt9211 *ctx)
 	if (dsi_lanes < 0)
 		return dsi_lanes;
 
-	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	if (ctx->chip_type == LT9211C) {
+		const struct mipi_dsi_device_info info = {
+			.type = "lt9211c",
+			.channel = 0,
+			.node = NULL,
+		};
+		dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	} else {
+		const struct mipi_dsi_device_info info = {
+			.type = "lt9211",
+			.channel = 0,
+			.node = NULL,
+		};
+		dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
+	}
+
 	if (IS_ERR(dsi))
 		return dev_err_probe(dev, PTR_ERR(dsi),
 				     "failed to create dsi device\n");
@@ -706,10 +1442,16 @@ static int lt9211_host_attach(struct lt9211 *ctx)
 
 	dsi->lanes = dsi_lanes;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
-			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
-			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
-			  MIPI_DSI_MODE_NO_EOT_PACKET;
+
+	if (ctx->chip_type == LT9211C) {
+		dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;
+	} else {
+		dsi->mode_flags =
+			MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
+			MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
+			MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
+			MIPI_DSI_MODE_NO_EOT_PACKET;
+	}
 
 	ret = devm_mipi_dsi_attach(dev, dsi);
 	if (ret < 0) {
@@ -747,10 +1489,25 @@ static int lt9211_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	ctx->regmap = devm_regmap_init_i2c(client, &lt9211_regmap_config);
+	if (of_device_is_compatible(dev->of_node, "lontium,lt9211c")) {
+		ctx->chip_type = LT9211C;
+		ctx->regmap =
+			devm_regmap_init_i2c(client, &lt9211c_regmap_config);
+	} else {
+		ctx->chip_type = LT9211;
+		ctx->regmap =
+			devm_regmap_init_i2c(client, &lt9211_regmap_config);
+	}
 	if (IS_ERR(ctx->regmap))
 		return PTR_ERR(ctx->regmap);
 
+	if (ctx->chip_type == LT9211C) {
+		ctx->wq = create_workqueue("lt9211_work");
+		if (!ctx->wq)
+			return -ENOMEM;
+		INIT_DELAYED_WORK(&ctx->lt9211_dw, lt9211_delayed_work_func);
+	}
+
 	dev_set_drvdata(dev, ctx);
 	i2c_set_clientdata(client, ctx);
 
@@ -768,17 +1525,22 @@ static void lt9211_remove(struct i2c_client *client)
 {
 	struct lt9211 *ctx = i2c_get_clientdata(client);
 
+	if (ctx->wq)
+		destroy_workqueue(ctx->wq);
+
 	drm_bridge_remove(&ctx->bridge);
 }
 
 static const struct i2c_device_id lt9211_id[] = {
 	{ "lontium,lt9211" },
+	{ "lontium,lt9211c" },
 	{},
 };
 MODULE_DEVICE_TABLE(i2c, lt9211_id);
 
 static const struct of_device_id lt9211_match_table[] = {
 	{ .compatible = "lontium,lt9211" },
+	{ .compatible = "lontium,lt9211c" },
 	{},
 };
 MODULE_DEVICE_TABLE(of, lt9211_match_table);

-- 
2.34.1

