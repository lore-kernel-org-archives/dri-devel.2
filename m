Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFAFD606A331
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 08:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LzparLeF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5387510EB7C;
	Thu, 12 Nov 2026 08:20:15 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B4C10EB7C
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:20:09 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c50715c2757so25161966b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 00:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794471607; x=1795076407; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rU4i6XVY/9JL9bi+qmA1w92G0CtofTM34rsUqi+UGrs=;
 b=LzparLeFSd92UBWLRmA0l/bV1hw28tEKX3aoSObH7rAyaBJ1LjUGi54MrrMdZO2C4C
 PbXtZJcNZWblBl/8+qYMVA6Q2ZVwqWjytuwGQnkcEweUtXXxAmvw+W42K/ml7GuDP0zz
 tveNTChN55qwylQH2mlccoMJERbr0YB1ny8l+A5kpnwvOW8nuXb45qUwqP1dYMrJCU/W
 zbhIU+OXlbNEzFUuLAiNGEoWtylAfJ1ZOZelTtja3oIHTolFjX4PWI4SmBrJxYLYTxTb
 Dlhs6RcUIi0wNPAPn4nevLrpEMuICPOG2Y2XbEfvlGKOrNCnZnFHh8OmEI2wHEO5C8tG
 0wPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794471607; x=1795076407;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rU4i6XVY/9JL9bi+qmA1w92G0CtofTM34rsUqi+UGrs=;
 b=FNRRfIl+LiZMh5Q+3lFQdMjBQwI2N0szuyBJ+8zOW34IzUsnG6gABUE3cMHujEu9qm
 bA6p3c2PpeYp6GA9mu4B/99sKte5u0UJh6i7R1vfO6bnwU7fb7JO1RUiMqn6PoguAuGj
 0hcV8oL4lin3XEKpiI67G6LwFr6QfIK14T7DWLZTma8fh9gWdYdeln2D7FOtwiF0hhle
 N00zhImSp4MyWiml/eSYq5WZBhIexlrJ9rUd39XseNldvoobT0aiuQ1ltmOidrJp3is0
 pZ9/A7Yn4fn9eFmug3XRis84e9ZzH14PrRPex5MvBTPAtVtf5MdP3NstvDoVGl79cmz7
 ywqg==
X-Forwarded-Encrypted: i=1;
 AL+hErEWht/Ly8MEw/oD2koB02iBWkwRaTl9WDdD6Ln9fG1KeWaIeCkpS/K1uNQKQn3hveJPtoDGY/uR/Nk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8a8t1OQBuODX6/BSyrHI1r1473guJxqtinalaap5DH+GSgv8gJ
 MIxNRBz+OE9A2t0TcJmjJgVqo58THl3n8VyE7PFcKN3P1mI1aVLqq2aD
X-Gm-Gg: AYBFou1ef/+Jhq41IfWvBBnjnnqASsaMA+zVu6Q9toyAKTDexdcTgymOBMHyUR+G73J
 M/cymu9tSs/r+skttTnfOltG73mZ488/38PdcGTRGSPQyxUqfv4rUBsqrGxnxFqFacV7J+qXhx8
 zFmpD6WN7Bi8aECpLYzNJrRnSCtQEpE215cD1Ep4/NJ0uAa1uAlpt/R1CG4l91LRphYFEXKTySW
 9Xh9K25zzQCXtUVQaT+wvFRxPHYUzRgAqieQjUn4QyFy8pOjdSbLmET7g94jmBz04WshhtxiC82
 CzRq5qfmdXIV+BPgSxeCXSBPn80kYKQR7WBfgD2cLKPE41RS9d8thKuu5qsEqwI6k7KkiWQAzyU
 GQQTW1+UGkuNVaEnWy1+JDF/irDQPbPdLKH1IYUXItKZXNOM4rHpbjX3ekOzcL8I1zLkillmN7U
 JGtYvjdjKiighRtZT0jug+352gto7SWcsVf/6QiznvsjfM7s3Q6UoJPM+uqKNBwbPtn1p1Yxf7I
 nW/Hs7MJlyZxWImjjfnFBoknun4uLWnR79Tglp2ZuJzrqOnWauN3mUzRoFLfwQxp+iUMykPjEuf
 EuE/2ic+VRMm69WMuTS1X2UGsitTqxi8Uw+787iiPnN2Ks6MTOXdV46QyXDuD3XQ0z/3ADlvZ7K
 CCbnBUdh1dg==
X-Received: by 2002:a17:907:7ba3:b0:c50:4d71:a855 with SMTP id
 a640c23a62f3a-c5066ad7440mr341389866b.19.1794471607157; 
 Thu, 12 Nov 2026 00:20:07 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c504a62a91bsm312997966b.57.2026.11.12.00.20.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2026 00:20:06 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Griffin Kroah-Hartman <griffin@kroah.com>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Helge Deller <deller@gmx.de>
Cc: linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v2] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Date: Thu, 12 Nov 2026 10:19:41 +0200
Message-ID: <20261112081941.41363-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Add Control Bank to HVLED/LVLED muxing support based on the led-sources
defined in the device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
This was part of the original LM3533 controller DT/OF conversion patchset,
but it appears to have been accidentally separated during the final iteration.
Therefore, I am sending it as a follow-up.

Changes in v2:
- leds: switch to macros in regmap_update_bits() calls to apply 0xff mask
  since regmap writes may cause unwanted writing.
---
 drivers/leds/leds-lm3533.c          | 62 +++++++++++++++++++++++++++++
 drivers/video/backlight/lm3533_bl.c | 45 +++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index 7259097bd6a71..0612f99d3dc7d 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -26,6 +26,13 @@
 #define LM3533_ALS_CHANNEL_LV_MIN	1
 #define LM3533_ALS_CHANNEL_LV_MAX	2
 
+#define LM3533_REG_OUTPUT_CONF1			0x10
+#define   OUTPUT_CONF1_SHIFT			2
+#define   OUTPUT_LVLED_MASK			0x3
+#define   OUTPUT_CONF1_PREP(x)			(((x) << OUTPUT_CONF1_SHIFT) && 0xff)
+#define LM3533_REG_OUTPUT_CONF2			0x11
+#define   OUTPUT_CONF2_SHIFT			6
+#define   OUTPUT_CONF2_PREP(x)			(((x) >> OUTPUT_CONF2_SHIFT) && 0xff)
 #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
 #define LM3533_REG_PATTERN_ENABLE		0x28
 #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
@@ -54,6 +61,9 @@ struct lm3533_led {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 leds[LM3533_LVCTRLBANK_MAX];
+
 	bool have_als;
 };
 
@@ -622,8 +632,36 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
 static int lm3533_led_setup(struct lm3533_led *led)
 {
+	u32 output_cfg_shift = 0;
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
 	int ret;
 
+	if (led->num_leds) {
+		for (int i = 0; i < led->num_leds; i++) {
+			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
+				continue;
+
+			output_cfg_shift = led->leds[i] * 2;
+			output_cfg_val |= led->id << output_cfg_shift;
+			output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
+		}
+
+		/* LVLED1, LVLED2 and LVLED3 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
+					 OUTPUT_CONF1_PREP(output_cfg_mask),
+					 OUTPUT_CONF1_PREP(output_cfg_val));
+		if (ret)
+			return ret;
+
+		/* LVLED4 and LVLED5 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
+					 OUTPUT_CONF2_PREP(output_cfg_mask),
+					 OUTPUT_CONF2_PREP(output_cfg_val));
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
 		return ret;
@@ -698,6 +736,30 @@ static int lm3533_led_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
 
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default LVLED or is not linked to any LVLED at all.
+	 */
+	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
+		dev_err(&pdev->dev, "num of LED sources exceeds max %d: %d\n",
+			LM3533_LVCTRLBANK_MAX, led->num_leds);
+		ret = -EINVAL;
+		goto err_deregister;
+	}
+
+	if (led->num_leds < 0)
+		led->num_leds = 0;
+
+	if (led->num_leds > 0) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     led->leds, led->num_leds);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get led-sources\n");
+			goto err_deregister;
+		}
+	}
+
 	ret = lm3533_led_setup(led);
 	if (ret)
 		goto err_deregister;
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index adcd6ac7cf229..e8164c8528577 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/platform_device.h>
@@ -21,6 +22,7 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 #define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
 #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
@@ -35,6 +37,9 @@ struct lm3533_bl {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
+
 	bool have_als;
 	bool linear;
 };
@@ -236,6 +241,8 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
 	int ret;
 
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
@@ -243,6 +250,21 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
 	if (ret)
 		return ret;
 
+	if (bl->num_leds) {
+		for (int i = 0; i < bl->num_leds; i++) {
+			if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
+				continue;
+
+			output_cfg_val |= ctrlbank << bl->led_strings[i];
+			output_cfg_mask |= BIT(bl->led_strings[i]);
+		}
+
+		ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask, output_cfg_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -320,6 +342,29 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT) {
+		dev_err(&pdev->dev, "num of LED sources %d exceeds max %d\n",
+			bl->num_leds, LM3533_HVCTRLBANK_COUNT);
+		return -EINVAL;
+	}
+
+	if (bl->num_leds < 0)
+		bl->num_leds = 0;
+
+	if (bl->num_leds > 0) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     bl->led_strings,
+						     bl->num_leds);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to get led-sources\n");
+	}
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		return ret;
-- 
2.53.0

