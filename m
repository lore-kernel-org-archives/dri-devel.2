Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91818606A31D
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 08:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v1fpz/0h
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F197C896E9;
	Sun, 15 Nov 2026 08:52:13 +0000 (UTC)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 32474886A4
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 08:52:07 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6b70880c0a4so2986823a12.2
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 00:52:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794732725; x=1795337525; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cVjBt24AZadG8lfyxs4mRXI5N5Rh1ABfAQ7ljq9C298=;
 b=v1fpz/0hSTQUWXAsMxRPYxMit8y5vuw11sr/PDLmuf3UgGYfJWD3Ta0rZr1LOj1cWM
 9Sgkxp4cvt4b6AmpvLaiLcKvcKegvg73PAOPOF6Jr6kYFG+ANKWrrbVUw96MbCZi6E5d
 JYT8gVZb97DYgFIgNmbTdOW+m0LzIOy7gu9IpVW8lQy36d7Edt+8+kWicMkQuQtzVMBD
 P3brib05ezQ+Kn5H/M700x/0ZXgCTlzhBoCF/mxLzKfIEOIvBCYAyW2ZI0HDEWCVxiOf
 WKwC4gfxY2pPcInjksSEhcexNVJz2SJJ43zU8V6Sff/B3GMMT5zqeMvYQeRWHetaoupN
 /0zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794732725; x=1795337525;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cVjBt24AZadG8lfyxs4mRXI5N5Rh1ABfAQ7ljq9C298=;
 b=COsxfIs5bbwi761OVW+UOBu06hg0bj6nN8OnV2jE3gZ7qBaf/IESZP0Y7c/QtgI0i9
 bsYE6Q5Zi0lMbNNIO4bsHnksD6ioi3X3LRizfaYVgcWKSmovjoSBiK0Yf9UiHzlebDNa
 HDlFXxLopVAENoK3H7lYbhI2XOmwyUhqQEnh+fTBivwn2fGmHU4+cVLsHih9Uwcm/1Gm
 O28uVWQ/juCqVDJp/5LiSMIovtmOeIUVbJ8U09FTqCxWG5Kud5lAQRaSiX/HE0YxAHWJ
 e/3ISfbNGYx1qS1YTIihq/4m0oXu0ndb/h++kxSTJ2i7yffkAj6AD8mxw3mbLyWcqxaX
 PORw==
X-Gm-Message-State: APuU4Z92W5TJI2Z3eJ5RD2QWctZwJBpXocoY/Qyc7S3dx35MSWtDwKBx
 Z0SUN2q+0Q0txv8dJ3i26HgMeIrxuQUi1NIh1mGLUHZ3dm7Y1Qar2iE3
X-Gm-Gg: AYBFou1aedKOSbtuZFbIIXdxHV6gE0ZTKVfLhmWnoUv0FYikidBf8WaOQ5yVi7BTxw9
 vWdQzwj/4vlXbDCevWLKcS02BFcPFlinleMp+gTS1GdFgu7gtJia8um+NqfwCnSB+vAwLv7qmhS
 VMME/BnkUTLWcWbqbiiItKTe5vU/9wgXzx9MX7bc0NaXBvCzAhDf6eiylkZWePPMDEhi6MjPkVL
 8+grI6dOnh5un/uiDvDjZqpIgaqJ8ydlG9AtkKYFScmXTrGWj3I/hxPf0Zk5Q9Y5V+y6njRWWxf
 Df0SmEdQE0sFGEIiCztOcg1Yh/BY2JlDI8gavvT81e7A0Lyfr02XyvOi56jrLSe27rUwMhMoL7K
 pK7iOsl1hcxq7jQq2rBjRZp3osIZsBW8BslizAJBS/7q2UQrQ99rCCZoq6awpkIKZ6kv50R2Afd
 AQklKwmld95OsO2FVX7MzSW/5waYDwzaRk2vMVSWrlk7BxZfC+tgGE6m0+NMsDH75JZsZYmZ7Bc
 BrrMsql/07u6z247m2w6H5BNOmmWvyqCMjJZYq6oZ1CI1mQ1UGtDQ4i1Ug/voLnhPvi1r/8Tdcy
 wvVmB9Y0im3y0fH0o6Y7U1FUbzMny35M7AwSnbMGiI8NxAueb19W8GE5A46fDch7N+OncA+ApaI
 ZhSLSCfMQxg==
X-Received: by 2002:a05:6402:42c7:b0:6b7:eda4:e136 with SMTP id
 4fb4d7f45d1cf-6b7eda4e281mr1999786a12.41.1794732725246; 
 Sun, 15 Nov 2026 00:52:05 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b7c23c672asm3090610a12.15.2026.11.15.00.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 00:52:04 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v3] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Date: Sun, 15 Nov 2026 10:51:55 +0200
Message-ID: <20261115085155.80043-1-clamor95@gmail.com>
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

Changes in v3:
- leds part moved into a separate patchset
- switched to dev_err_probe()
- for loop moved out of if condition
---
 drivers/video/backlight/lm3533_bl.c | 44 +++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index fd6e7f4f1f61c..cb9df6ff73001 100644
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
 
+	for (int i = 0; i < bl->num_leds; i++) {
+		if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
+			continue;
+
+		output_cfg_val |= ctrlbank << bl->led_strings[i];
+		output_cfg_mask |= BIT(bl->led_strings[i]);
+	}
+
+	if (bl->num_leds) {
+		ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask, output_cfg_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -320,6 +342,28 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
+		return dev_err_probe(&pdev->dev, -EINVAL,
+				     "num of LED sources %d exceeds max %d\n",
+				     bl->num_leds, LM3533_HVCTRLBANK_COUNT);
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

