Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77CB4F436BE
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 16:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA16F10E9FC;
	Fri, 17 Apr 2026 16:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="k8wVoqOQ";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3B1A10E9FC
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 16:55:04 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-488a8ca4aadso11039065e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 09:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776444903; x=1777049703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=w3d2BGP9irgdfdO8KFh82k9rWglwq3WmMsGPehw78ns=;
 b=k8wVoqOQ1vQ8JtKzUjg+DYOltvBzgI7Fmnt/jcMrJEWCVRHQ1r7KLv1h3CgwOP3zdF
 fON8iOMXavrYwomGspiOx1o8fvSl3eL/2peoT4tmFPE0ZkkEaOXbvogggP6ihPTYc6LR
 qIMjB/vPPLwkBexrkf4hl1r2DhCOlcHJx5/auhRlqDqku/Sk/dJtqyasQzI0LpA/uLuf
 cj+FDOaCskiNBRVVWlTDPImZw6aCJFh1Y/tOqmli0ajFyNhqnD54s5VnpIDOlYq3TNYv
 B1VzGTKK1Vd0TAnbnNJm2aegbdCT006sR8K8P8xDAOfCPX0Efpvnbz8TfincrBeIkMk/
 L+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776444903; x=1777049703;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w3d2BGP9irgdfdO8KFh82k9rWglwq3WmMsGPehw78ns=;
 b=gUEOkFf+cXVv1BGvM73s4CM7X3TcE/BxROGj6wkdbKV1s0676dopFPiBoMqg1WImsX
 aM77bjleB/mRKOSIkhADQi9TrGFJWMClIW2dF66g1oL5HfQLsTQ83NWkpf2lnIRgolJI
 ZDrFmDKC7iJvcRPawP8Q85D/4OcOVT9ksSN1avrQDPLYqFKHzLzJ4Pxgyj24hSBQz91v
 gCI5fl1atR1BaWRfGRWNUfCN9+KJ45kJ+Amm4rJEOl73zIzqHJKtNYQz3Doe2NOhTJoA
 mg/26EnSndToW1pwXUeTgEyOqpL4AqGjy+2gUClRZdf/bUNHb8BVCBQPK2Z+00iyOale
 Axlg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ojrlOU5TZCKnc3MyEi5QnO+nQEH6kbRwXwljddMiwaZuFNwrJJ2C4VGD3CmIxDbWKIwBNwiRmH1A=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxfz5VAkdDOIn4Z4lDSZv0aizZLlBqui0SvDHbEP1emcO34hluq
 JW+0iGRDztfjBiakcbJJxdGYXB304SgqjF95YNaemwTDrP439iPl/QzT
X-Gm-Gg: AeBDietIi7/9Nmso8axl9sEBfjdiEsSFQqlTVFpfUPtP1RHczXP7QB6D7WqB3xqVvLe
 H35TcOa+kxKL9M/T5YThyoyIOP3gAbuq9Gy7+pvTWAmYxy7vIyK92uX1mEbi6/3sGauhwG0HU7z
 Cbah0sLW4D+J2abnnwYh20TcdkMHpItraA01mqXQQvoRZYiPgpCOdyWPVJ3hJgpnLYOW/J01CTe
 cpXCszb5JCTtdqU5pA2eDS435WGecBIF0C2qmBfl+YGjKHPsZzD9r/XLmXOPQ8eT27uOTDrjaX6
 zKewVkGT85hMhaapECTikjpmOgCJHENZtgAaIBvKIY8skoczQErbgo4hslzIpdZZ2bKGU/ew2Kd
 sQ1+nR6bobXC5I1ODuhlQQE7XamdukbwPQBuTRUF7Y7iKmD3gwvXOX4wQizzzFSeJOlqsdAjA9F
 X+H/HTg+FwlLn7gP6ZXtEwuiL+fS5tJwKdf2ihDNQM
X-Received: by 2002:a05:600c:31a9:b0:489:95:3dd2 with SMTP id
 5b1f17b1804b1-48900953e9bmr183645e9.8.1776444903017; 
 Fri, 17 Apr 2026 09:55:03 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:528c:590:5bef:9bc8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc189f2esm95735645e9.7.2026.04.17.09.55.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 09:55:02 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Liu Ying <victor.liu@nxp.com>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v3] drm/bridge: ite-it6263: Support power cycle in runtime
Date: Fri, 17 Apr 2026 17:54:58 +0100
Message-ID: <20260417165501.213681-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

On the RZ/G3L SMARC EVK using PSCI, suspend to RAM powers down the ITE
IT6263 chip. The display controller driver's system PM callbacks invoke
drm_mode_config_helper_{suspend,resume}, which in turn call the bridge's
atomic_{disable,enable} callbacks can handle suspend/resume for the
bridge without dedicated PM ops.

Switch from devm_regulator_bulk_get_enable() to devm_regulator_bulk_get()
so that regulators can be explicitly enabled and disabled across power
cycles. Move reset_gpio and regulator state into the it6263 struct so they
are accessible beyond probe time.

Move it6263_supplies[] to the top of the file, before the it6263 struct
definition, as it is now referenced by ARRAY_SIZE() within the struct.

Add reset, I2C address configuration, and LVDS/HDMI initialisation to the
atomic_enable callback so that the hardware is fully reinitialised after
each power cycle. Correspondingly, remove these steps from probe, since
they are no longer needed there.

Add regulator_bulk_disable() to the atomic_disable callback to power down
the supplies on bridge disable, completing the power cycle support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 Tested s2idle, s2ram and hotplug on Renesas RZ/G3L SMARC EVK platform.
v2->v3:
 * Updated commit header and description.
 * Moved it6263_supplies above struct it6263.
 * Replaced *supplies with supplies[] in struct it6263 and removed the
   num_supplies variable from struct it6263, as ARRAY_SIZE already
   provides this information.
 * Dropped it6263_bridge_{init,uninit}().
 * Added reset, I2C address configuration, and LVDS/HDMI initialisation to
   the atomic_enable callback so that the hardware is fully reinitialised
   after each power cycle. Correspondingly, remove these steps from probe,
   since they are no longer needed there.
 * Dropped the remove callback as it is not needed.
 * Dropped the variable powered from struct it6263.
v1->v2:
 * Dropped system PM callbacks instead using bridge's
   atomic_{disable,enable} callbacks to handle suspend/resume.
---
 drivers/gpu/drm/bridge/ite-it6263.c | 49 +++++++++++++++++------------
 1 file changed, 29 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 4f3ebb7af4d4..10bf4cc89eb6 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -192,6 +192,11 @@
  */
 #define MAX_HDMI_TMDS_CHAR_RATE_HZ	225000000
 
+static const char * const it6263_supplies[] = {
+	"ivdd", "ovdd", "txavcc18", "txavcc33", "pvcc1", "pvcc2",
+	"avcc", "anvdd", "apvdd"
+};
+
 struct it6263 {
 	struct device *dev;
 	struct i2c_client *hdmi_i2c;
@@ -200,6 +205,8 @@ struct it6263 {
 	struct regmap *lvds_regmap;
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
+	struct gpio_desc *reset_gpio;
+	struct regulator_bulk_data supplies[ARRAY_SIZE(it6263_supplies)];
 	int lvds_data_mapping;
 	bool lvds_dual_link;
 	bool lvds_link12_swap;
@@ -344,11 +351,6 @@ static const struct regmap_config it6263_lvds_regmap_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
-static const char * const it6263_supplies[] = {
-	"ivdd", "ovdd", "txavcc18", "txavcc33", "pvcc1", "pvcc2",
-	"avcc", "anvdd", "apvdd"
-};
-
 static int it6263_parse_dt(struct it6263 *it)
 {
 	struct device *dev = it->dev;
@@ -587,6 +589,8 @@ static void it6263_bridge_atomic_disable(struct drm_bridge *bridge,
 	regmap_write(it->hdmi_regmap, HDMI_REG_PKT_GENERAL_CTRL, 0);
 	regmap_write(it->hdmi_regmap, HDMI_REG_AFE_DRV_CTRL,
 		     AFE_DRV_RST | AFE_DRV_PWD);
+
+	regulator_bulk_disable(ARRAY_SIZE(it->supplies), it->supplies);
 }
 
 static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
@@ -603,6 +607,19 @@ static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
 	bool pclk_high;
 	int i, ret;
 
+	ret = regulator_bulk_enable(ARRAY_SIZE(it->supplies), it->supplies);
+	if (ret)
+		dev_err(it->dev, "failed to enable power supplies\n");
+
+	it6263_hw_reset(it->reset_gpio);
+
+	ret = it6263_lvds_set_i2c_addr(it);
+	if (ret)
+		dev_err(it->dev, "failed to set I2C addr\n");
+
+	it6263_lvds_config(it);
+	it6263_hdmi_config(it);
+
 	connector = drm_atomic_get_new_connector_for_encoder(state,
 							     bridge->encoder);
 	crtc = drm_atomic_get_new_connector_state(state, connector)->crtc;
@@ -840,7 +857,6 @@ static const struct drm_bridge_funcs it6263_bridge_funcs = {
 static int it6263_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct gpio_desc *reset_gpio;
 	struct it6263 *it;
 	int ret;
 
@@ -858,13 +874,15 @@ static int it6263_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(it->hdmi_regmap),
 				     "failed to init I2C regmap for HDMI\n");
 
-	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(reset_gpio))
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+	it->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(it->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(it->reset_gpio),
 				     "failed to get reset gpio\n");
 
-	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it6263_supplies),
-					     it6263_supplies);
+	for (unsigned int i = 0; i < ARRAY_SIZE(it->supplies); i++)
+		it->supplies[i].supply = it6263_supplies[i];
+
+	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(it->supplies), it->supplies);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get power supplies\n");
 
@@ -872,12 +890,6 @@ static int it6263_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
-	it6263_hw_reset(reset_gpio);
-
-	ret = it6263_lvds_set_i2c_addr(it);
-	if (ret)
-		return dev_err_probe(dev, ret, "failed to set I2C addr\n");
-
 	it->lvds_i2c = devm_i2c_new_dummy_device(dev, client->adapter,
 						 LVDS_INPUT_CTRL_I2C_ADDR);
 	if (IS_ERR(it->lvds_i2c))
@@ -890,9 +902,6 @@ static int it6263_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(it->lvds_regmap),
 				     "failed to init I2C regmap for LVDS\n");
 
-	it6263_lvds_config(it);
-	it6263_hdmi_config(it);
-
 	i2c_set_clientdata(client, it);
 
 	it->bridge.of_node = dev->of_node;
-- 
2.43.0

