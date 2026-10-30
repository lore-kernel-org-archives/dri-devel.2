Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F50606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 07:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=WwbWQ6mq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BBA110E578;
	Fri, 30 Oct 2026 07:45:43 +0000 (UTC)
Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com
 [210.118.77.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A23F610E578
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:45:36 +0000 (UTC)
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
 by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id
 20261030074534euoutp012bab26e7f352638d2d4299f4c66eb4fe~jPv10ylMx2699226992euoutp01N
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 07:45:34 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com
 20261030074534euoutp012bab26e7f352638d2d4299f4c66eb4fe~jPv10ylMx2699226992euoutp01N
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793346334;
 bh=MGbJXiJFi31yIeTwiAlfmLLlnxlqKdJgzbKeOHsVxXA=;
 h=From:To:Cc:Subject:Date:References:From;
 b=WwbWQ6mqBQvVxMpf3yQqaR6FTOUU3uCOvtekSK+ajogjymL/LjiETl8STwe49QZlL
 OReU6srtrGwcu9JFHmClyypftgdcQfLlVzkzCUhKeIrF7ZyB7Yj1qqLo0EyFPz0FFe
 nsmeuGN6POf25CoSiZlf6uZcQVYUU2tyFA/f3CD4=
Received: from eusmtip1.samsung.com (unknown [203.254.199.221]) by
 eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
 20261030074534eucas1p152cccb0576c7a59dc713845077353904~jPv1h4bJu0876108761eucas1p14;
 Fri, 30 Oct 2026 07:45:34 +0000 (GMT)
Received: from AMDC4653.digital.local (unknown [106.120.51.32]) by
 eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
 20261030074533eusmtip1e981b5adbd76f64066708854250e130a~jPv0rz1Ek0978809788eusmtip1V;
 Fri, 30 Oct 2026 07:45:33 +0000 (GMT)
From: Marek Szyprowski <m.szyprowski@samsung.com>
To: dri-devel@lists.freedesktop.org (open list:DRM DRIVERS),
 linux-arm-msm@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Andrzej Hajda
 <andrzej.hajda@intel.com>, Neil Armstrong <neil.armstrong@linaro.org>,
 Robert Foss <rfoss@kernel.org>, Laurent Pinchart
 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman <jonas@kwiboo.se>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Sam Ravnborg <sam@ravnborg.org>,
 Srinivas Kandagatla <srini@kernel.org>, Vinod Koul <vkoul@kernel.org>, Bjorn
 Andersson <andersson@kernel.org>, Hongyang Zhao
 <hongyang.zhao@thundersoft.com>
Subject: [PATCH] drm/bridge: lt9611: Don't override ADDR strap when strapped
 low
Date: Fri, 30 Oct 2026 08:45:17 +0100
Message-ID: <20261030074518.516993-1-m.szyprowski@samsung.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMS-MailID: 20261030074534eucas1p152cccb0576c7a59dc713845077353904
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20261030074534eucas1p152cccb0576c7a59dc713845077353904
X-EPHeader: CA
X-CMS-RootMailID: 20261030074534eucas1p152cccb0576c7a59dc713845077353904
References: <CGME20261030074534eucas1p152cccb0576c7a59dc713845077353904@eucas1p1.samsung.com>
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

lt9611_sleep_setup() writes 0x8023 = 0x01, which overrides the ADDR
strap and moves the chip to I2C address 0x3b, and then configures the
ADDR pin as an output (0x8157/0x8149). On boards where the pin is
strapped low (address 0x39, e.g. Thundercomm RUBIK Pi 3) the chip
becomes unreachable as soon as the bridge is disabled: all further
register accesses NACK and on resume the bridge fails with "power on
failed", leaving HDMI dead until reboot.

Skip the address override and ADDR pin setup when the device sits at
the low-strap address.

While touching this driver, also fix the misleading error messages in
atomic disable path.

Fixes: 23278bf54afe ("drm/bridge: Introduce LT9611 DSI to HDMI bridge")
Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
The issue was analyzed and the patch was prepared with LLM assistance.
The fix was tested on the real Thundercomm RubikPi3 board - the HDMI
display now comes back after system suspend/resume cycle.

Best regards
Marek Szyprowski, PhD
Samsung R&D Institute Poland
---
 drivers/gpu/drm/bridge/lontium-lt9611.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/bridge/lontium-lt9611.c b/drivers/gpu/drm/bridge/lontium-lt9611.c
index 2d1a28261037..9e4f45d9f6d3 100644
--- a/drivers/gpu/drm/bridge/lontium-lt9611.c
+++ b/drivers/gpu/drm/bridge/lontium-lt9611.c
@@ -35,6 +35,9 @@
 
 #define LT9611_4LANES	0
 
+/* I2C address with the ADDR pin strapped low */
+#define LT9611_ADDR_LOW	0x39
+
 struct lt9611 {
 	struct device *dev;
 	struct drm_bridge bridge;
@@ -440,10 +443,13 @@ static void lt9611_sleep_setup(struct lt9611 *lt9611)
 {
 	const struct reg_sequence sleep_setup[] = {
 		{ 0x8024, 0x76 },
+	};
+	const struct reg_sequence addr_pin_setup[] = {
 		{ 0x8023, 0x01 },
 		{ 0x8157, 0x03 }, /* set addr pin as output */
 		{ 0x8149, 0x0b },
-
+	};
+	const struct reg_sequence power_down[] = {
 		{ 0x8102, 0x48 }, /* MIPI Rx power down */
 		{ 0x8123, 0x80 },
 		{ 0x8130, 0x00 },
@@ -452,6 +458,18 @@ static void lt9611_sleep_setup(struct lt9611 *lt9611)
 
 	regmap_multi_reg_write(lt9611->regmap,
 			       sleep_setup, ARRAY_SIZE(sleep_setup));
+
+	/*
+	 * The ADDR pin selects the I2C address and addr_pin_setup overrides
+	 * it to high (0x8023 bit 0), which moves a chip strapped low over
+	 * to 0x3b and makes it unreachable. Skip it in that case.
+	 */
+	if (lt9611->client->addr != LT9611_ADDR_LOW)
+		regmap_multi_reg_write(lt9611->regmap, addr_pin_setup,
+				       ARRAY_SIZE(addr_pin_setup));
+
+	regmap_multi_reg_write(lt9611->regmap,
+			       power_down, ARRAY_SIZE(power_down));
 	lt9611->sleep = true;
 }
 
@@ -712,12 +730,12 @@ static void lt9611_bridge_atomic_disable(struct drm_bridge *bridge,
 	/* Disable HDMI output */
 	ret = regmap_write(lt9611->regmap, 0x8130, 0x6a);
 	if (ret) {
-		dev_err(lt9611->dev, "video on failed\n");
+		dev_err(lt9611->dev, "video off failed\n");
 		return;
 	}
 
 	if (lt9611_power_off(lt9611)) {
-		dev_err(lt9611->dev, "power on failed\n");
+		dev_err(lt9611->dev, "power off failed\n");
 		return;
 	}
 }
-- 
2.43.0

