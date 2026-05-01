Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF3EFF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 06:12:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3046010E13E;
	Fri,  1 May 2026 06:12:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Sh5hkdcB";
	dkim-atps=neutral
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 326F210E13E
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 06:12:05 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-44a74032ff8so296347f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 23:12:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1777615924; x=1778220724; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W4g2jwDnU6jYGeU1BTs0Zin0/2ggkSyypEmuOjuJt9s=;
 b=Sh5hkdcBZ1r5+cGYPZc0/0A7fgeZ9Rp1G12UJwLbboj/eLv7xInw8Yg5cBdgY8g1Va
 8wW89g00LztpsYSxYe32bLtpN9r4am3VY/ukxAxlIRSOxZwS1uv6Rr1sQRZKxtsNcJ5i
 tA9+T8jp0y7Goj3eeOg1uncy11iaBQEiYaHQXnQZXzw/JhBzDiFwBW9aj6ijJQLSIeqD
 dS7OJlJNKUS5C9JdLERmKyJb69lhhIfA/PF7K56/FNjm9ow51YvroJa77Tn7p0Cf+SwD
 KBYV+jjW+XYV1s5r2EL1xXsmqJTb4641WBCSr9Kdyv+IikKDob5x1aak9khzzjihJcxH
 Q4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777615924; x=1778220724;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W4g2jwDnU6jYGeU1BTs0Zin0/2ggkSyypEmuOjuJt9s=;
 b=g3l3DjNjhutuFkVjRvoHRml+HGOwulIDI9VfVGhJgW3Zpw6+pP9UqzvHNQMmaBo/Oq
 b9UScCZpSaF5Mnr52oPdPOugGf1bXrrw798xNtnKwC8vIStHPJj9u6O8UtmO8HwcP6xS
 IoWsRbJ/895n5jz9YgkDKoJTTSnwGjXqPQAuzE8CBzq0ZGbvlDjAf1NQ4hVu1YujcyEn
 O4eZNnjXW8CrZgd53St/6ZMcK/ObJHBwEli/3dDrTuqJs2FZsNRKFyALzd0oGB/4YwIP
 Zi+V8b16lxPBJoFW3DX6ju1yhJLQFsQsTE2QvqPDdxAj3J/rS2x1FcOMGHChB+C74Ehg
 1PRA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8hxB0ELl4sOnCZfVrhNzf/WAsRUiy2Nho8+RhOrE4O8CUkAah2yKEIE+44GFzr+Ueu/SbHlt7WDic=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzN3DRB9ccNj7mWZmM+6aJTbPWqHL4mKs+pRoyigvMj9lWHflwa
 p9mZVeUl9LVKSDABVE8gTH2UiTJCFz8GvahRllm5TdWukAFfEXOwW/BL
X-Gm-Gg: AeBDievZmL5OssjtHP/UexTsNxtt0E4o9RCSY/JQTopPAir/LHdjfkSgUOI65CN9mM8
 GC7vbuGwF/+EQNbWKDJnkN4S+CQPvJdFWy2Lg2Up71eh1Fq9ZnY9B6u473QjQ4i2XYUtUsVa4pA
 cvikIkCzEeQkBz8CFIfu+ztQ8DMHMSS9Wh3pgQbxLjtQoz18rmrDNBZlmDDicSXx3RJRyLGjnkL
 PlMap/btz+ZdQogr5vxCKtJINxaLY3CsCoYyxlHXoX5KNpDOR6D2Q2TSlVQ2B3EVZNr0DwGfrZi
 HG9YZe+kAqwinpJ6CFsytwOf7mHBKLVuVdyRse++UF4XfBmHgmVL4BFFEi5wBOTuS+YZYvVkkuu
 muzDmwlRspyT9VMOmNT6qPrGEnZZs18/oLbWv1U/lRBAUhRqhp/IEJcLOTnrHcPQh3336xuUDW0
 kOnIxd6sbioIrR0ogG2hY6QvpXF8AXoASy8yO3nXsCwTBhsWHj0qTNiavljFA=
X-Received: by 2002:a05:6000:1a8f:b0:441:202e:3d2d with SMTP id
 ffacd0b85a97d-4493d5fea69mr9958384f8f.19.1777615923505; 
 Thu, 30 Apr 2026 23:12:03 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:11a0:4ba9:d261:6902])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-44a8ea7d035sm2796454f8f.5.2026.04.30.23.12.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 23:12:03 -0700 (PDT)
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
Subject: [PATCH v4] drm/bridge: ite-it6263: Move chip initialization code from
 probe to atomic_enable
Date: Fri,  1 May 2026 07:11:58 +0100
Message-ID: <20260501061200.20129-1-biju.das.jz@bp.renesas.com>
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
v3->v4:
 * Updated commit header.
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
index 2ea49245e700..4a8268d0eac2 100644
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
@@ -838,7 +848,6 @@ static const struct drm_bridge_funcs it6263_bridge_funcs = {
 static int it6263_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
-	struct gpio_desc *reset_gpio;
 	struct it6263 *it;
 	int ret;
 
@@ -856,9 +865,9 @@ static int it6263_probe(struct i2c_client *client)
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
@@ -870,12 +879,6 @@ static int it6263_probe(struct i2c_client *client)
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
@@ -888,9 +891,6 @@ static int it6263_probe(struct i2c_client *client)
 		return dev_err_probe(dev, PTR_ERR(it->lvds_regmap),
 				     "failed to init I2C regmap for LVDS\n");
 
-	it6263_lvds_config(it);
-	it6263_hdmi_config(it);
-
 	i2c_set_clientdata(client, it);
 
 	it->bridge.of_node = dev->of_node;
-- 
2.43.0

