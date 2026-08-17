Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ADCAC5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:18:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCBB10E6AD;
	Mon, 17 Aug 2026 17:18:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="HONfpzuy";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Mon, 17 Aug 2026 17:18:24 UTC
Received: from mta-64-226.siemens.flowmailer.net
 (mta-64-226.siemens.flowmailer.net [185.136.64.226])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C885C10E780
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:18:24 +0000 (UTC)
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id
 20260817170820c01e7ae2150002079f
 for <dri-devel@lists.freedesktop.org>;
 Mon, 17 Aug 2026 19:08:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=WZtFRdjtUq4dQ6GfrNDN0rLs1QYiDRrW26BnNAqYuKY=;
 b=HONfpzuyeX/3OelD72snOljwUw1dKrE2bMjNryEEnhQC75Zrf0GCiB+zqx+Ff+ydxZaFfL
 T+mcEqjR69jfs3332EJAnpvnTAYOejCL0QUmU+1TkxrbJOSq5+dkIAHz6R7Tb1y5Bwmk/EC1
 D9Vo9eYG8DXeuHYoHkemfQkchfQ+ghJ78DOEH54nM9qx3O3CXwWq0PrcI0M7W4T70HIPmAgs
 /IrlsZlbzNVunvc+f+D2mYa1Pp18xAltbsx/GOQTMr2Rt3gIrutIRjN9ZQ8+q5bTTqCgDXAN
 /ji1axz5z/HpDnPGewv4ZkW8MLaf76MRX4MMYppfCVeVrCJnRiDc1S/g==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH 1/2] backlight: led_bl: Add devm_led_backlight_register()
 helper
Date: Mon, 17 Aug 2026 19:08:14 +0200
Message-ID: <20260817170817.1933046-2-alexander.sverdlin@siemens.com>
In-Reply-To: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
References: <20260817170817.1933046-1-alexander.sverdlin@siemens.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-456497:519-21489:flowmailer
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

From: Alexander Sverdlin <alexander.sverdlin@siemens.com>

The led-backlight driver could so far only be instantiated from a
device-tree node with the "led-backlight" compatible. This makes it
impossible for a self-contained LED provider (e.g. a hot-pluggable I2C
LED controller) to expose a backlight interface tied to its own
lifetime.

Factor the actual backlight registration out of the probe path into a
shared led_bl_register() helper and export devm_led_backlight_register(),
which registers a backlight class device driven by a single LED, without
device tree and bound to the caller's device lifetime. The backlight
device and the LED sysfs handover are now devres-managed, so the probe
path shrinks and the explicit .remove callback is no longer needed.

The exported helper is a no-op when the led-backlight support is not
reachable (IS_REACHABLE(CONFIG_BACKLIGHT_LED)), so callers do not need
any Kconfig plumbing and are not force-selected to build it.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 MAINTAINERS                      |   1 +
 drivers/video/backlight/led_bl.c | 130 ++++++++++++++++++++-----------
 include/linux/led_bl.h           |  20 +++++
 3 files changed, 107 insertions(+), 44 deletions(-)
 create mode 100644 include/linux/led_bl.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 8014b9f8253ed..d525a7c4043aa 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4508,6 +4508,7 @@ F:	Documentation/ABI/testing/sysfs-class-backlight
 F:	Documentation/devicetree/bindings/leds/backlight
 F:	drivers/video/backlight/
 F:	include/linux/backlight.h
+F:	include/linux/led_bl.h
 F:	include/linux/pwm_backlight.h
 
 BARCO P50 GPIO DRIVER
diff --git a/drivers/video/backlight/led_bl.c b/drivers/video/backlight/led_bl.c
index f7ab9b3607313..f87a48f74186a 100644
--- a/drivers/video/backlight/led_bl.c
+++ b/drivers/video/backlight/led_bl.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/backlight.h>
+#include <linux/led_bl.h>
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/of.h>
@@ -173,29 +174,25 @@ static int led_bl_parse_levels(struct device *dev,
 	return 0;
 }
 
-static int led_bl_probe(struct platform_device *pdev)
+static void led_bl_disable(void *data)
 {
-	struct backlight_properties props;
-	struct led_bl_data *priv;
-	int ret, i;
-
-	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
-	if (!priv)
-		return -ENOMEM;
-
-	platform_set_drvdata(pdev, priv);
+	struct led_bl_data *priv = data;
+	int i;
 
-	priv->dev = &pdev->dev;
+	led_bl_power_off(priv);
+	for (i = 0; i < priv->nb_leds; i++) {
+		mutex_lock(&priv->leds[i]->led_access);
+		led_sysfs_enable(priv->leds[i]);
+		mutex_unlock(&priv->leds[i]->led_access);
+	}
+}
 
-	ret = led_bl_get_leds(&pdev->dev, priv);
-	if (ret)
-		return ret;
+static int led_bl_register(struct device *dev, struct led_bl_data *priv)
+{
+	struct backlight_properties props;
+	int ret, i;
 
-	ret = led_bl_parse_levels(&pdev->dev, priv);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "Failed to parse DT data\n");
-		return ret;
-	}
+	priv->dev = dev;
 
 	memset(&props, 0, sizeof(struct backlight_properties));
 	props.type = BACKLIGHT_RAW;
@@ -203,24 +200,28 @@ static int led_bl_probe(struct platform_device *pdev)
 	props.brightness = priv->default_brightness;
 	props.power = (priv->default_brightness > 0) ? BACKLIGHT_POWER_OFF :
 		      BACKLIGHT_POWER_ON;
-	priv->bl_dev = backlight_device_register(dev_name(&pdev->dev),
-			&pdev->dev, priv, &led_bl_ops, &props);
-	if (IS_ERR(priv->bl_dev)) {
-		dev_err(&pdev->dev, "Failed to register backlight\n");
-		return PTR_ERR(priv->bl_dev);
-	}
+	priv->bl_dev = devm_backlight_device_register(dev, dev_name(dev), dev,
+						      priv, &led_bl_ops, &props);
+	if (IS_ERR(priv->bl_dev))
+		return dev_err_probe(dev, PTR_ERR(priv->bl_dev),
+				     "Failed to register backlight\n");
 
 	for (i = 0; i < priv->nb_leds; i++) {
+		struct device *supplier = priv->leds[i]->dev->parent;
 		struct device_link *link;
 
-		link = device_link_add(&pdev->dev, priv->leds[i]->dev->parent,
-				       DL_FLAG_AUTOREMOVE_CONSUMER);
-		if (!link) {
-			dev_err(&pdev->dev, "Failed to add devlink (consumer %s, supplier %s)\n",
-				dev_name(&pdev->dev), dev_name(priv->leds[i]->dev->parent));
-			backlight_device_unregister(priv->bl_dev);
-			return -EINVAL;
-		}
+		/*
+		 * BL and the LED are the same device if instantiated via
+		 * devm_led_backlight_register()
+		 */
+		if (supplier == dev)
+			continue;
+
+		link = device_link_add(dev, supplier, DL_FLAG_AUTOREMOVE_CONSUMER);
+		if (!link)
+			return dev_err_probe(dev, -EINVAL,
+					     "Failed to add devlink (consumer %s, supplier %s)\n",
+					     dev_name(dev), dev_name(supplier));
 	}
 
 	for (i = 0; i < priv->nb_leds; i++) {
@@ -229,26 +230,68 @@ static int led_bl_probe(struct platform_device *pdev)
 		mutex_unlock(&priv->leds[i]->led_access);
 	}
 
+	ret = devm_add_action_or_reset(dev, led_bl_disable, priv);
+	if (ret)
+		return ret;
+
 	backlight_update_status(priv->bl_dev);
 
 	return 0;
 }
 
-static void led_bl_remove(struct platform_device *pdev)
+static int led_bl_probe(struct platform_device *pdev)
 {
-	struct led_bl_data *priv = platform_get_drvdata(pdev);
-	struct backlight_device *bl = priv->bl_dev;
-	int i;
+	struct led_bl_data *priv;
+	int ret;
 
-	backlight_device_unregister(bl);
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
 
-	led_bl_power_off(priv);
-	for (i = 0; i < priv->nb_leds; i++) {
-		mutex_lock(&priv->leds[i]->led_access);
-		led_sysfs_enable(priv->leds[i]);
-		mutex_unlock(&priv->leds[i]->led_access);
+	ret = led_bl_get_leds(&pdev->dev, priv);
+	if (ret)
+		return ret;
+
+	ret = led_bl_parse_levels(&pdev->dev, priv);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "Failed to parse DT data\n");
+		return ret;
 	}
+
+	return led_bl_register(&pdev->dev, priv);
+}
+
+/**
+ * devm_led_backlight_register - expose a LED as a backlight device
+ * @dev: LED provider device, also the parent and lifecycle owner
+ * @led: LED class device to drive the backlight
+ *
+ * Registers a backlight class device driven by @led, without device tree and
+ * tied to the lifetime of @dev. This lets self-contained (e.g. hot-pluggable
+ * I2C) LED drivers offer a backlight interface without static platform
+ * plumbing. It is a no-op when the led-backlight support is not built in.
+ *
+ * Return: 0 on success, negative errno otherwise.
+ */
+int devm_led_backlight_register(struct device *dev, struct led_classdev *led)
+{
+	struct led_bl_data *priv;
+
+	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->leds = devm_kmalloc(dev, sizeof(*priv->leds), GFP_KERNEL);
+	if (!priv->leds)
+		return -ENOMEM;
+	priv->leds[0] = led;
+	priv->nb_leds = 1;
+	priv->max_brightness = led->max_brightness;
+	priv->default_brightness = led->brightness;
+
+	return led_bl_register(dev, priv);
 }
+EXPORT_SYMBOL_GPL(devm_led_backlight_register);
 
 static const struct of_device_id led_bl_of_match[] = {
 	{ .compatible = "led-backlight" },
@@ -263,7 +306,6 @@ static struct platform_driver led_bl_driver = {
 		.of_match_table	= led_bl_of_match,
 	},
 	.probe		= led_bl_probe,
-	.remove		= led_bl_remove,
 };
 
 module_platform_driver(led_bl_driver);
diff --git a/include/linux/led_bl.h b/include/linux/led_bl.h
new file mode 100644
index 0000000000000..e38e4d62bf653
--- /dev/null
+++ b/include/linux/led_bl.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_LED_BL_H
+#define _LINUX_LED_BL_H
+
+#include <linux/kconfig.h>
+
+struct device;
+struct led_classdev;
+
+#if IS_REACHABLE(CONFIG_BACKLIGHT_LED)
+int devm_led_backlight_register(struct device *dev, struct led_classdev *led);
+#else
+static inline int devm_led_backlight_register(struct device *dev,
+					      struct led_classdev *led)
+{
+	return 0;
+}
+#endif
+
+#endif /* _LINUX_LED_BL_H */
-- 
2.55.0

