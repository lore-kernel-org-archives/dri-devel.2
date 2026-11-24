Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8789E606A330
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 07:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=goldelico.com header.i=@goldelico.com header.a=rsa-sha256 header.s=strato-dkim-0002 header.b=EBSkkM5y;
	dkim=fail reason="signature verification failed" header.d=goldelico.com header.i=@goldelico.com header.a=ed25519-sha256 header.s=strato-dkim-0003 header.b=6IXrjucF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9095510E213;
	Tue, 24 Nov 2026 07:26:53 +0000 (UTC)
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de
 [81.169.146.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25EA510E213
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 07:26:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1795505186; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=AS9oXN5tsyXXd3U9WEVXr3jzIoOIwhGyA+Z5/H/QsuJvocdfDLuNXt+lF4dw5TOo6f
 3oU+qAlrpxFceh8q5rI3/8HKdKKzMmwTxzQqxsP6lbpMrQHfROrfOkdFQkAx+KU6yYQq
 HsruygDtVofAZIZLz+aBLt+0BC9du+UlPNOITeVBWb69McMV8679NdJl5h8br8Ulvmgq
 yxeJ4nw8Vq9KrkptCchbQ6aABrJdDpZM3ETLE0K8bEZToAl0yBYpLT6NClQkCN9kPI9y
 H+Hl0P5aXv/Yu9CEypS80Rla0aQji6t/IN4kgKEnLUDtQ9ZxKVuzVteE2F0G8XDnYoSP
 geFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505186;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=d/XWg+z+3driH60oKg1jDoiUHNLVCm4AplbKyR0sUbM=;
 b=C7GFpg4fmQ8v+KL0rIqMa6Nisk74GQZFmY6acThHF1MMiutn8d7c4+ULnreDYGGIJj
 TvRLC2rpFyAliI1p8RlaMr5RqQoDPxRNjoyloJZ2aUFFfm3r3PpopvEjKFPo9cIt9GlW
 AgmkbwGOGxOSTSTk8fBXE68ELTDNoeEyC0rjhWaEQw7IjFH5TOFyI/gG+biUJsxrQV7H
 uqrYguv7f39dbC/TIIMKfqxoMMLHT9/u4co/2wvODDFUSQMkCa4MOmFej0Oizb1o5fO+
 pIpbQg6KwlyewCpxDk4olHujyDtuUH+v4kz0s5qqqrVDIX/07qeYvMNu4TApf86VC9TX
 l6Lg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1795505186;
 s=strato-dkim-0002; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=d/XWg+z+3driH60oKg1jDoiUHNLVCm4AplbKyR0sUbM=;
 b=EBSkkM5yKvYGwF2v1DFNuZHwdJwTR9rFIneuFbamTLUnlgeVnphMAmt6XWXTUNrEe3
 Z1zR7NSAt4ZnzG4L83roOk/IT0OlwIUu+fkR2xO74KzNUDO3t2JEZyaL89vtXNMfqCWl
 m8Uxoy9uc29ryTZcK9Rfq8MFCRTWUvGUMdJIUG+deKrw4Zj/ZBjTeMXzHhaodV2hMBDL
 ayzgKzYnsJA3Q1BAfHdaLfOpalg5oJ8yktV5WPtE79DXaEcUjJyXGtTvoHHlSG5BjdOD
 xedjmZ5ScSNtg/sBVgwJXRmY8lOVqQExHW9ytB5AR0viCqy45lzPSltq2V8bNeiiZErQ
 1uRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1795505186;
 s=strato-dkim-0003; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=d/XWg+z+3driH60oKg1jDoiUHNLVCm4AplbKyR0sUbM=;
 b=6IXrjucF3IPHUcmaUIJSpxa5icjMafAAhdlobGZrizciH/X1yYPtp+Xu5LzOElTpA/
 RszQ9kCHh4ZnvWZvHIBQ==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrV3poLlciNVTQoM6kVxzKyrKzkpjcAwdDfiN49"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.6.3 AUTH)
 with ESMTPSA id Qb56a22AO7QO1HX
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Tue, 24 Nov 2026 08:26:24 +0100 (CET)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <brgl@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
 Pavel Machek <pavel@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
 Helge Deller <deller@gmx.de>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, Peter Ujfalusi <peter.ujfalusi@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>
Cc: Jessica Zhang <jessica.zhang@oss.qualcomm.com>, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-omap@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-pwm@vger.kernel.org,
 linux-fbdev@vger.kernel.org, letux-kernel@openphoenux.org,
 kernel@pyra-handheld.com, "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: [PATCH v2 19/20] backlight: Remove legacy Pandora driver
Date: Tue, 24 Nov 2026 08:25:59 +0100
Message-ID: <41a3bded8cc0a65d90c7ca6f41438f5c78ee3586.1795505160.git.hns@goldelico.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <cover.1795505160.git.hns@goldelico.com>
References: <cover.1795505160.git.hns@goldelico.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF8
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
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Remove the Pandora-specific backlight platform driver after its
functionality has been replaced by the TWL4030 PWM provider and the
generic pwm-backlight driver described in the device tree.

Remove its Kconfig and Makefile entries and the obsolete
omap2plus_defconfig selection.

Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---

Notes:
    Changes against V1:
    - Daniel Thompson gave Reviewed-by for the V1 removal of
      pandora_bl. V2 additionally removes the stale defconfig option;
      the old Reviewed-by is documented here, not carried as a tag.
    - Explain replacement by generic pwm-backlight and removal of the defconfig selection.
    - Commit-message review assisted by ChatGPT.

 arch/arm/configs/omap2plus_defconfig |   1 -
 drivers/video/backlight/Kconfig      |   7 --
 drivers/video/backlight/Makefile     |   1 -
 drivers/video/backlight/pandora_bl.c | 159 ---------------------------
 4 files changed, 168 deletions(-)
 delete mode 100644 drivers/video/backlight/pandora_bl.c

diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
index 5791953b75fff..ef5e8d1bf9da1 100644
--- a/arch/arm/configs/omap2plus_defconfig
+++ b/arch/arm/configs/omap2plus_defconfig
@@ -517,7 +517,6 @@ CONFIG_LCD_CLASS_DEVICE=y
 CONFIG_LCD_PLATFORM=y
 CONFIG_BACKLIGHT_CLASS_DEVICE=y
 CONFIG_BACKLIGHT_PWM=m
-CONFIG_BACKLIGHT_PANDORA=m
 CONFIG_BACKLIGHT_GPIO=m
 CONFIG_BACKLIGHT_LED=m
 CONFIG_FRAMEBUFFER_CONSOLE=y
diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
index dbf4ca23a9b6d..040e6cc7e5a29 100644
--- a/drivers/video/backlight/Kconfig
+++ b/drivers/video/backlight/Kconfig
@@ -459,13 +459,6 @@ config BACKLIGHT_MP3309C
 	  To compile this driver as a module, choose M here: the module will
 	  be called mp3309c.
 
-config BACKLIGHT_PANDORA
-	tristate "Backlight driver for Pandora console"
-	depends on TWL4030_CORE
-	help
-	  If you have a Pandora console, say Y to enable the
-	  backlight driver.
-
 config BACKLIGHT_SKY81452
 	tristate "Backlight driver for SKY81452"
 	depends on MFD_SKY81452
diff --git a/drivers/video/backlight/Makefile b/drivers/video/backlight/Makefile
index 34469711c6cd9..c62c920e64b96 100644
--- a/drivers/video/backlight/Makefile
+++ b/drivers/video/backlight/Makefile
@@ -52,7 +52,6 @@ obj-$(CONFIG_BACKLIGHT_MAX8925)		+= max8925_bl.o
 obj-$(CONFIG_BACKLIGHT_MP3309C)		+= mp3309c.o
 obj-$(CONFIG_BACKLIGHT_MT6370)		+= mt6370-backlight.o
 obj-$(CONFIG_BACKLIGHT_OMAP1)		+= omap1_bl.o
-obj-$(CONFIG_BACKLIGHT_PANDORA)		+= pandora_bl.o
 obj-$(CONFIG_BACKLIGHT_PWM)		+= pwm_bl.o
 obj-$(CONFIG_BACKLIGHT_QCOM_WLED)	+= qcom-wled.o
 obj-$(CONFIG_BACKLIGHT_RT4831)		+= rt4831-backlight.o
diff --git a/drivers/video/backlight/pandora_bl.c b/drivers/video/backlight/pandora_bl.c
deleted file mode 100644
index e6889e2ac55e1..0000000000000
--- a/drivers/video/backlight/pandora_bl.c
+++ /dev/null
@@ -1,159 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * Backlight driver for Pandora handheld.
- * Pandora uses TWL4030 PWM0 -> TPS61161 combo for control backlight.
- * Based on pwm_bl.c
- *
- * Copyright 2009,2012 Gražvydas Ignotas <notasas@gmail.com>
- */
-
-#include <linux/module.h>
-#include <linux/kernel.h>
-#include <linux/platform_device.h>
-#include <linux/delay.h>
-#include <linux/backlight.h>
-#include <linux/mfd/twl.h>
-#include <linux/err.h>
-
-#define TWL_PWM0_ON		0x00
-#define TWL_PWM0_OFF		0x01
-
-#define TWL_INTBR_GPBR1		0x0c
-#define TWL_INTBR_PMBR1		0x0d
-
-#define TWL_PMBR1_PWM0_MUXMASK	0x0c
-#define TWL_PMBR1_PWM0		0x04
-#define PWM0_CLK_ENABLE		BIT(0)
-#define PWM0_ENABLE		BIT(2)
-
-/* range accepted by hardware */
-#define MIN_VALUE 9
-#define MAX_VALUE 63
-#define MAX_USER_VALUE (MAX_VALUE - MIN_VALUE)
-
-struct pandora_private {
-	unsigned old_state;
-#define PANDORABL_WAS_OFF 1
-};
-
-static int pandora_backlight_update_status(struct backlight_device *bl)
-{
-	int brightness = bl->props.brightness;
-	struct pandora_private *priv = bl_get_data(bl);
-	u8 r;
-
-	if (bl->props.power != BACKLIGHT_POWER_ON)
-		brightness = 0;
-	if (bl->props.state & BL_CORE_FBBLANK)
-		brightness = 0;
-	if (bl->props.state & BL_CORE_SUSPENDED)
-		brightness = 0;
-
-	if ((unsigned int)brightness > MAX_USER_VALUE)
-		brightness = MAX_USER_VALUE;
-
-	if (brightness == 0) {
-		if (priv->old_state == PANDORABL_WAS_OFF)
-			goto done;
-
-		/* first disable PWM0 output, then clock */
-		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_GPBR1);
-		r &= ~PWM0_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-		r &= ~PWM0_CLK_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-
-		goto done;
-	}
-
-	if (priv->old_state == PANDORABL_WAS_OFF) {
-		/*
-		 * set PWM duty cycle to max. TPS61161 seems to use this
-		 * to calibrate it's PWM sensitivity when it starts.
-		 */
-		twl_i2c_write_u8(TWL_MODULE_PWM, MAX_VALUE, TWL_PWM0_OFF);
-
-		/* first enable clock, then PWM0 out */
-		twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_GPBR1);
-		r &= ~PWM0_ENABLE;
-		r |= PWM0_CLK_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-		r |= PWM0_ENABLE;
-		twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_GPBR1);
-
-		/*
-		 * TI made it very easy to enable digital control, so easy that
-		 * it often triggers unintentionally and disabes PWM control,
-		 * so wait until 1 wire mode detection window ends.
-		 */
-		usleep_range(2000, 10000);
-	}
-
-	twl_i2c_write_u8(TWL_MODULE_PWM, MIN_VALUE + brightness, TWL_PWM0_OFF);
-
-done:
-	if (brightness != 0)
-		priv->old_state = 0;
-	else
-		priv->old_state = PANDORABL_WAS_OFF;
-
-	return 0;
-}
-
-static const struct backlight_ops pandora_backlight_ops = {
-	.options	= BL_CORE_SUSPENDRESUME,
-	.update_status	= pandora_backlight_update_status,
-};
-
-static int pandora_backlight_probe(struct platform_device *pdev)
-{
-	struct backlight_properties props;
-	struct backlight_device *bl;
-	struct pandora_private *priv;
-	u8 r;
-
-	priv = devm_kmalloc_obj(&pdev->dev, *priv);
-	if (!priv)
-		return -ENOMEM;
-
-	memset(&props, 0, sizeof(props));
-	props.max_brightness = MAX_USER_VALUE;
-	props.type = BACKLIGHT_RAW;
-	bl = devm_backlight_device_register(&pdev->dev, pdev->name, &pdev->dev,
-					priv, &pandora_backlight_ops, &props);
-	if (IS_ERR(bl)) {
-		dev_err(&pdev->dev, "failed to register backlight\n");
-		return PTR_ERR(bl);
-	}
-
-	platform_set_drvdata(pdev, bl);
-
-	/* 64 cycle period, ON position 0 */
-	twl_i2c_write_u8(TWL_MODULE_PWM, 0x80, TWL_PWM0_ON);
-
-	priv->old_state = PANDORABL_WAS_OFF;
-	bl->props.brightness = MAX_USER_VALUE;
-	backlight_update_status(bl);
-
-	/* enable PWM function in pin mux */
-	twl_i2c_read_u8(TWL4030_MODULE_INTBR, &r, TWL_INTBR_PMBR1);
-	r &= ~TWL_PMBR1_PWM0_MUXMASK;
-	r |= TWL_PMBR1_PWM0;
-	twl_i2c_write_u8(TWL4030_MODULE_INTBR, r, TWL_INTBR_PMBR1);
-
-	return 0;
-}
-
-static struct platform_driver pandora_backlight_driver = {
-	.driver		= {
-		.name	= "pandora-backlight",
-	},
-	.probe		= pandora_backlight_probe,
-};
-
-module_platform_driver(pandora_backlight_driver);
-
-MODULE_AUTHOR("Gražvydas Ignotas <notasas@gmail.com>");
-MODULE_DESCRIPTION("Pandora Backlight Driver");
-MODULE_LICENSE("GPL");
-MODULE_ALIAS("platform:pandora-backlight");
-- 
2.56.0

