Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93663C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 06:02:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06EBE10E71B;
	Sat, 11 Jul 2026 06:02:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=goldelico.com header.i=@goldelico.com header.b="AC5mqVJg";
	dkim=permerror (0-bit key) header.d=goldelico.com header.i=@goldelico.com header.b="+jn36CyM";
	dkim-atps=neutral
Received: from mo4-p04-ob.smtp.rzone.de (mo4-p04-ob.smtp.rzone.de
 [85.215.255.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB2A10E481
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 06:02:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; t=1783749737; cv=none;
 d=strato.com; s=strato-dkim-0002;
 b=iC0toLXH6Gq6Gbb1wbRJptb/CqlDMcjfKVE70kAJslXM0CYebLJGl+dmsWtcrUGBE9
 yGiLYIxAm+wnQ4N3zLDHtcssisr/W2dyZAVagtr2wAeh8mDKJga74qoXHDd6HKSfzwAM
 vdwBF2BXqgnsPjpFrSdKrKJHMIphQavB8W4WUwrkZ3bc4nkae5wOkUQzA1PQbF9RZ/UQ
 ImVNOmv2Y14SoVExyHf9JzPGTZX9R2QAaF40v55023I8eMfa5Pg/ozqUI716SIezvsQf
 d9xt+npKPRxPZdz02ZL7+c9vg9GwGSEICCJqDdXVFrAwJWr62kQ6yRzV4yARiQs+engn
 sbew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749737;
 s=strato-dkim-0002; d=strato.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=c2DakEhHWnDx3DdMaI7lEbd6D5ZL7hHtybFNpEKNGEY=;
 b=p3xqTKNzxP2MJOusO2HDNwJQGi+JFybPWQ/Q8v+AEvtTQds6DtK0cWHu53f5LA2/8V
 KEX/vmxJ1UQU0DeW+UMenWaDtKYkSEobm5J5SxIz+RgcsGdTxupDL/mxNKbDnB7DHpUa
 5XOpvmonYsjgv+tD86sOkgzwZyuieAsufVkd+92MU7w1y8d4+jZP9g8MPuqcCMmkWzep
 f0htsqJrbazcS6uK1F2aEjCQRyDr8Ay0oE8v91QDNJpY2qLpKo03NA9cFnR9dEFITTyd
 3AL5IhlLtYUbVbZNd+GZWMrs/hoQrRbItQAZAaX86z06YZ/dSCsnWnxYAnkAd5boyCe4
 Ijag==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo04
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1783749737;
 s=strato-dkim-0002; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=c2DakEhHWnDx3DdMaI7lEbd6D5ZL7hHtybFNpEKNGEY=;
 b=AC5mqVJgoMmhA3Zb/MSpoOfeAR1ZVSKJIcEc3MCzA3Z142xI8pEe5Db6aR194cu0YG
 dQg4sGBvsBLzcNVS30nO3nsg4A5aIkIWhaKY0cH5NPe426IyTy97+6PjNlMy2MAmThiE
 oSkncAjB3E+cDANu0EbBiwfK4POGt/e3CrAED3dWbXLCb6n1wHd5xTXYiJeuS7seljip
 a46TZb5pKbKx/saN9zIJABswzIAOD3hmh9QneQKXOUA+XHalTCN/Yqat2LLHnjaLhWLd
 zQusI0eJNMQoSNAjwWLUYKcpPaIiv7GF2K0JSSgaVbamua77vJdorFfiZT0I1UAzFhSU
 Psmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1783749737;
 s=strato-dkim-0003; d=goldelico.com;
 h=References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Cc:Date:
 From:Subject:Sender;
 bh=c2DakEhHWnDx3DdMaI7lEbd6D5ZL7hHtybFNpEKNGEY=;
 b=+jn36CyMpIt/846xR0wkPkUKOdBAInJWGBq2O5KYF6pSDWRs3pT4NMJFVBeD+fyNBz
 ekmrFK8i/KxIrSgszUAg==
X-RZG-AUTH: ":JGIXVUS7cutRB/49FwqZ7WcJeFKiMhflhwDubTJ9qVpwcQVkPW4I1HrT35oLmciNszeF4HOToVDOd6S1gdjuILE2MKVd"
Received: from iMac.fritz.box by smtp.strato.de (RZmta 55.5.6 AUTH)
 with ESMTPSA id Q4b76426B62GGht
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
 (Client did not present a certificate);
 Sat, 11 Jul 2026 08:02:16 +0200 (CEST)
From: "H. Nikolaus Schaller" <hns@goldelico.com>
To: Grond <grond66@riseup.net>, Stefan Leichter <sle85276@gmx.de>,
 "H . Nikolaus Schaller" <hns@goldelico.com>,
 Grazvydas Ignotas <notasas@gmail.com>, Tony Lindgren <tony@atomide.com>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>,
 Jarkko Nikula <jarkko.nikula@bitmer.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Andreas Kemnade <andreas@kemnade.info>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Aaro Koskinen <aaro.koskinen@iki.fi>,
 Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 Sen Wang <sen@ti.com>, Richard Fitzgerald <rf@opensource.cirrus.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>,
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
 Charles Keepax <ckeepax@opensource.cirrus.com>,
 Niranjan H Y <niranjan.hy@ti.com>
Cc: letux-kernel@openphoenux.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 kernel@pyra-handheld.com, mfd@lists.linux.dev
Subject: [PATCH 08/16] ASoC: pcm1773-codec: write a driver for the PCM1773
 chip from TI
Date: Sat, 11 Jul 2026 08:01:55 +0200
Message-ID: <7d8989813cbd750259dfdde2e1187082493279a0.1783749722.git.hns@goldelico.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1783749722.git.hns@goldelico.com>
References: <cover.1783749722.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
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

From: Grond <grond66@riseup.net>

This chip is used in the OpenPandora.

Signed-off-by: Grond <grond66@riseup.net>
Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
---
 sound/soc/codecs/Kconfig   |   5 ++
 sound/soc/codecs/pcm1773.c | 149 +++++++++++++++++++++++++++++++++++++
 2 files changed, 154 insertions(+)
 create mode 100644 sound/soc/codecs/pcm1773.c

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 252f683be3c18..3e186652fa06d 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -182,6 +182,7 @@ config SND_SOC_ALL_CODECS
 	imply SND_SOC_HDMI_CODEC
 	imply SND_SOC_PCM1681
 	imply SND_SOC_PCM1754
+	imply SND_SOC_PCM1773
 	imply SND_SOC_PCM1789_I2C
 	imply SND_SOC_PCM179X_I2C
 	imply SND_SOC_PCM179X_SPI
@@ -1541,6 +1542,10 @@ config SND_SOC_PCM1754
 	tristate "Texas Instruments PCM1754 CODEC"
 	depends on GPIOLIB
 
+config SND_SOC_PCM1773
+	tristate "Texas Instruments PCM1773 CODEC"
+	select GPIOLIB
+
 config SND_SOC_PCM1789
 	tristate
 
diff --git a/sound/soc/codecs/pcm1773.c b/sound/soc/codecs/pcm1773.c
new file mode 100644
index 0000000000000..75f9fe40a89d5
--- /dev/null
+++ b/sound/soc/codecs/pcm1773.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * pcm1773.c -- codec for the simple PCM1773 output codec from TI
+ *
+ * Shamelessly cobbled together from sound/soc/ti/omap3pandora.c and a few
+ * other codec drivers in sound/soc/codecs/
+ *
+ * Author: Grond <grond66@riseup.net>
+ */
+
+#include <linux/gpio/consumer.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regulator/consumer.h>
+#include <sound/soc.h>
+
+struct pcm1773 {
+	struct regulator *regulator;
+	struct gpio_desc *enable_gpio;
+};
+
+static int pcm1773_dac_event(struct snd_soc_dapm_widget *w,
+			     struct snd_kcontrol *k, int event)
+{
+	struct snd_soc_component *component = snd_soc_dapm_to_component(w->dapm);
+	struct pcm1773 *ctx = snd_soc_component_get_drvdata(component);
+	struct device *dev = component->dev;
+	int ret;
+
+	/*
+	 * The PCM1773 DAC datasheet requires 1ms delay between switching
+	 * VCC power on/off and /PD pin high/low
+	 */
+	if (SND_SOC_DAPM_EVENT_ON(event)) {
+		if (ctx->regulator) {
+			ret = regulator_enable(ctx->regulator);
+			if (ret) {
+				dev_err(dev, "Failed to power DAC: %d\n", ret);
+				return ret;
+			}
+			mdelay(1);
+		}
+
+		if (ctx->enable_gpio)
+			gpiod_set_value_cansleep(ctx->enable_gpio, 1);
+	} else {
+		if (ctx->enable_gpio)
+			gpiod_set_value_cansleep(ctx->enable_gpio, 0);
+
+		if (ctx->regulator) {
+			mdelay(1);
+			regulator_disable(ctx->regulator);
+		}
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_dapm_widget pcm1773_dapm_widgets[] = {
+	SND_SOC_DAPM_DAC_E("PCM1773 DAC", "HiFi Playback", SND_SOC_NOPM,
+			   0, 0, pcm1773_dac_event,
+			   SND_SOC_DAPM_POST_PMU | SND_SOC_DAPM_PRE_PMD),
+};
+
+static const struct snd_soc_dapm_route pcm1773_dapm_routes[] = {
+	/* tell DAPM that the main stream flows to the PCM1773 */
+	{"PCM1773 DAC", NULL, "PCM1773 IN"},
+};
+
+static struct snd_soc_dai_driver pcm1773_dai = {
+	.name = "pcm1773-hifi",
+	.playback = {
+		.stream_name = "PCM1773 IN",
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = SNDRV_PCM_RATE_8000_48000,
+		// [TODO] these really should be BE, per the data sheet but for
+		// some reason the omap-mcbsp driver claims only to support LE.
+		// investigate
+		.formats = SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S24_LE,
+	},
+};
+
+static int pcm1773_probe(struct snd_soc_component *component)
+{
+	struct pcm1773 *ctx = NULL;
+	struct device *dev = component->dev;
+	int ret;
+
+	ctx = devm_kzalloc(dev, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	snd_soc_component_set_drvdata(component, ctx);
+
+	ctx->enable_gpio = devm_gpiod_get_optional(dev, "enable", GPIOD_OUT_LOW);
+	if (IS_ERR(ctx->enable_gpio)) {
+		return dev_err_probe(dev, PTR_ERR(ctx->enable_gpio),
+				     "invalid GPIO specification for enable");
+	}
+	if (ctx->enable_gpio)
+		dev_dbg(dev, "got enable-gpio\n");
+	else
+		dev_warn(dev, "enable-gpio not specified\n");
+
+	ctx->regulator = devm_regulator_get(dev, "vcc");
+	if (IS_ERR(ctx->regulator)) {
+		dev_warn(dev, "cannot get regulator 'vcc'");
+		ctx->regulator = NULL;
+	}
+
+	return 0;
+}
+
+static const struct snd_soc_component_driver soc_component_dev_pcm1773 = {
+	.probe = pcm1773_probe,
+	.dapm_widgets = pcm1773_dapm_widgets,
+	.num_dapm_widgets = ARRAY_SIZE(pcm1773_dapm_widgets),
+	.dapm_routes = pcm1773_dapm_routes,
+	.num_dapm_routes = ARRAY_SIZE(pcm1773_dapm_routes),
+};
+
+static int pcm1773_codec_probe(struct platform_device *pdev)
+{
+	return devm_snd_soc_register_component(&pdev->dev,
+		&soc_component_dev_pcm1773,
+		&pcm1773_dai, 1);
+}
+
+static const struct of_device_id pcm1773_of_match[] = {
+	{
+		.compatible = "ti,pcm1773",
+	},
+	{ },
+};
+MODULE_DEVICE_TABLE(of, pcm1773_of_match);
+
+static struct platform_driver pcm1773_codec_driver = {
+	.probe = pcm1773_codec_probe,
+	.driver = {
+		.name = "pcm1773-codec",
+		.of_match_table = pcm1773_of_match,
+	},
+};
+
+module_platform_driver(pcm1773_codec_driver);
+
+MODULE_DESCRIPTION("ASoC codec driver PCM1773");
+MODULE_AUTHOR("Grond");
+MODULE_LICENSE("GPL");
-- 
2.50.1 (Apple Git-155)

