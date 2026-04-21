Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7621F89251
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 10:53:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC49010EC19;
	Tue, 21 Apr 2026 10:53:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qumoYve3";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3813310EC19
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:53:39 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso15618355e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 03:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776768818; x=1777373618; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YaPuNs+tJR3dOut9FEswGyzi6MZaKkaW/JljGXmpchI=;
 b=qumoYve3JZbbBkJPx8NDJEfhU4UUWJH8psu88Vg+F8jpnXjVmtsBYtcj7DYOrR4jGI
 +0AWzRdN2bfMObz+6tqzX8d7w6KX6PgkQJSOLu4f59royiwvOprATkj0bc+atQMtz6ne
 eYYB00jpcILzau4U8TFyCmeyBHrGjqf4PHr/lMzYodPsVUDrq217X8bRxpBLmYMiqcGN
 JVwejAw+dLulzkSl1GMF0UB+Kadsh7MHTmm37pptoEROC/LuaLDyyotO6AlTD9Y4OLAD
 XSRQEB1FIF9Wogd+17xk/G2vDIfcTInvk82uGWBtNRSoF/JsOGrrYT7oRvliiWElHBIf
 C/TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776768818; x=1777373618;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YaPuNs+tJR3dOut9FEswGyzi6MZaKkaW/JljGXmpchI=;
 b=pc3DC+dlJOjoS9Aic+LPrm56vlf7qEcf2a5M9m2xHrgsgqXpcN+xZ7I1ZeSw+KLq4e
 im5p6/RUsiR/fxjTXsJdoMRaPfM9kphicch4pyZFqyH0x2VkVyUz1eGCqP2nELVXD5Md
 qwaeDMEAUcVjvLBvWZtvcsDnNcWyuKwsmefsRzi6EHRLvVVjwZWE9VuIp+osUAADatE1
 /YwXXt0KiZQ4fI7R8RlJ+GxIze0fqEdaJyUlvZvqdW3g3uwwr22Jp7CgfAw9q2cO1i/C
 jIEGPT8omDwyDjH6rGJMAjz/4KcPL8R2sAXYaht8bsPZIAZbCDvgqICkM2sfiDPUCiYO
 s8kQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0yxepJxqJZR8bZy+a/JTVT7rTqDROKz4xAcGxlngY7yrZAfyxzzOYaRUdbWtI0Atj97P631WmiKk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw/QEriuRkgwuj9GlbElXCw0riuZV1TRo6VgxmQCH8D+PKnfUiY
 +SqqXB4URYiP16d/AwuVMahm8xurfs+3h6JSMDiSYiYI3N2Z3Wre8npQ
X-Gm-Gg: AeBDiev23tkVh2r9ClOH87BLy3SLyxQc4de/58DerNVGgPViuZmp0q/xYqNgql2YGTd
 NMqqszEt8FHNZo153NM594OiXLaTMeLB6fjO3QIe0+Kirtbes3o9l57a9LJ+24Wfq7L+PSjB+aP
 0WcJ4lduJBudjl8EamCVEx8AvT7AonYsJ1R2QoraNQ8n6SNxq80XPBpCHuz3ZsH5iYLJk94DZpR
 v9wTsQAchOdk4WiN4P8fXQDvGd6DZ1wQGIYeFw3x8moLkcLr4n1VNmO3UZrL1tLRqjVcZPRXQmk
 aLpR0063V+W/n9kh5ym8xvFBIw8bYsr5s7uIDgSUeVQgfVIpzlCOD2de/cFVtP0VA2NE6zWrLJg
 lkXulFqoZ5HFGMKo8GVDuPx7Fw3JcuLb+9kOukQ3V2GqkYDok0/yFUdV7Y0eLDjL4yqJRXwZD9y
 vcD9aPnPgSRe1kMV+FDXGRAncOUYhmQFSMsrryye+yONqU4jcZXCULrKZasEM=
X-Received: by 2002:a05:600c:b90:b0:488:b99b:4177 with SMTP id
 5b1f17b1804b1-488fb78ee4emr240117025e9.25.1776768817358; 
 Tue, 21 Apr 2026 03:53:37 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:de57:c37d:677b:c772])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c773fsm403219355e9.12.2026.04.21.03.53.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 03:53:36 -0700 (PDT)
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
Date: Tue, 21 Apr 2026 11:53:32 +0100
Message-ID: <20260421105334.43411-1-biju.das.jz@bp.renesas.com>
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

On the RZ/G3L SMARC EVK, suspend to RAM powers down the ITE IT6263 chip.
The display controller driver's system PM callbacks invoke
drm_mode_config_helper_{suspend,resume}, which in turn call the bridge's
atomic_{disable,enable} callbacks to handle suspend/resume for the bridge
without dedicated PM ops.

To support proper reinitialization after power loss, move reset_gpio into
the it6263 struct so it is accessible beyond probe time. Relocate
it6263_hw_reset(), it6263_lvds_set_i2c_addr(), it6263_lvds_config() and
it6263_hdmi_config() from probe to atomic_enable, ensuring the chip is
fully reset and reconfigured on every enable, including after a
suspend/resume cycle.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
Tested s2idle, s2ram and hotplug on Renesas RZ/G3L SMARC EVK platform.
v2->v3:
 * Updated commit header and description.
 * Dropped it6263_bridge_{init,uninit}().
 * Restored regulator_bulk_enable in probe().
 * Dropped the variable powered, supplies and num_supplies from
   struct it6263.
 * Added reset, I2C address configuration, and LVDS/HDMI initialisation to
   the atomic_enable callback so that the hardware is fully reinitialised
   after each power cycle. Correspondingly, remove these steps from probe,
   since they are no longer needed there.
 * Dropped the remove callback as it is not needed.
v1->v2:
 * Dropped system PM callbacks instead using bridge's
   atomic_{disable,enable} callbacks to handle suspend/resume.
---
 drivers/gpu/drm/bridge/ite-it6263.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ite-it6263.c b/drivers/gpu/drm/bridge/ite-it6263.c
index 4f3ebb7af4d4..efb8aacef8ff 100644
--- a/drivers/gpu/drm/bridge/ite-it6263.c
+++ b/drivers/gpu/drm/bridge/ite-it6263.c
@@ -200,6 +200,7 @@ struct it6263 {
 	struct regmap *lvds_regmap;
 	struct drm_bridge bridge;
 	struct drm_bridge *next_bridge;
+	struct gpio_desc *reset_gpio;
 	int lvds_data_mapping;
 	bool lvds_dual_link;
 	bool lvds_link12_swap;
@@ -603,6 +604,15 @@ static void it6263_bridge_atomic_enable(struct drm_bridge *bridge,
 	bool pclk_high;
 	int i, ret;
 
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
@@ -840,7 +850,6 @@ static const struct drm_bridge_funcs it6263_bridge_funcs = {
 static int it6263_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct gpio_desc *reset_gpio;
 	struct it6263 *it;
 	int ret;
 
@@ -858,9 +867,9 @@ static int it6263_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(it->hdmi_regmap),
 				     "failed to init I2C regmap for HDMI\n");
 
-	reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
-	if (IS_ERR(reset_gpio))
-		return dev_err_probe(dev, PTR_ERR(reset_gpio),
+	it->reset_gpio = devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_LOW);
+	if (IS_ERR(it->reset_gpio))
+		return dev_err_probe(dev, PTR_ERR(it->reset_gpio),
 				     "failed to get reset gpio\n");
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(it6263_supplies),
@@ -872,12 +881,6 @@ static int it6263_probe(struct i2c_client *client)
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
@@ -890,9 +893,6 @@ static int it6263_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(it->lvds_regmap),
 				     "failed to init I2C regmap for LVDS\n");
 
-	it6263_lvds_config(it);
-	it6263_hdmi_config(it);
-
 	i2c_set_clientdata(client, it);
 
 	it->bridge.of_node = dev->of_node;
-- 
2.43.0

