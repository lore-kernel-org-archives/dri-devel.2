Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F922C5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 17:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C17E710E8A6;
	Mon, 17 Aug 2026 17:18:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=siemens.com header.i=alexander.sverdlin@siemens.com header.b="MMomg6G5";
	dkim-atps=neutral
X-Greylist: delayed 602 seconds by postgrey-1.36 at gabe;
 Mon, 17 Aug 2026 17:18:24 UTC
Received: from mta-65-225.siemens.flowmailer.net
 (mta-65-225.siemens.flowmailer.net [185.136.65.225])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C7FC310E755
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 17:18:24 +0000 (UTC)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id
 2026081717082060df25ad0700020733
 for <dri-devel@lists.freedesktop.org>;
 Mon, 17 Aug 2026 19:08:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=alexander.sverdlin@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=XOiQlDaJbPdkiK5caFg2Y3B12sCvby6hBxVy0+YU4PU=;
 b=MMomg6G5b3jiLEw6lPWorL7JT3CQFC/vEm4nI/QPDvPoDDZvCwLbXLnvrwNJjZzRuwQ7Hx
 QghWzTIMUCAGq3z4CiQaI7XvaplbYOFwwEcSVetSyuogru/VKuD3mkzPQOyGjjW2A+GsUGx7
 M0COtTQwbZfk0VBIoc4JThmksT+NljzHxY5JmKZ2X7cIgV7pAAktRO4j3sPp7GIx7GGZGwMW
 fVR1FpQ3HZV2FRLyqlQZqzCNp52KHnlNZz/bAdgZBlVooUWOBO2JG1G95OqNErrje3lohBSq
 saJZ9KUoqu8FZTczYja3GRwLojsZebEHAr1XLljCrezCBNeoP2jTVyNA==;
From: "A. Sverdlin" <alexander.sverdlin@siemens.com>
To: dri-devel@lists.freedesktop.org,
	linux-fbdev@vger.kernel.org
Cc: Alexander Sverdlin <alexander.sverdlin@siemens.com>,
 Andrew Davis <afd@ti.com>, Lee Jones <lee@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org
Subject: [PATCH 2/2] leds: lp8864: Register a backlight device
Date: Mon, 17 Aug 2026 19:08:15 +0200
Message-ID: <20260817170817.1933046-3-alexander.sverdlin@siemens.com>
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

The LP8864/LP8866 is a display-cluster LED backlight driver. Expose a
standard backlight class interface in addition to the LED class device,
so it can be used by display/panel stacks that expect a backlight.

Use the new devm_led_backlight_register() helper, which spawns a
led-backlight device driven by our LED and tied to the I2C device
lifetime. This keeps the driver a plain LED driver, requires no
device-tree changes and remains backwards compatible with existing DTs.
It is a no-op when the led-backlight support is not enabled.

Signed-off-by: Alexander Sverdlin <alexander.sverdlin@siemens.com>
---
 drivers/leds/leds-lp8864.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lp8864.c b/drivers/leds/leds-lp8864.c
index 204727f2f350e..47896dfc13c11 100644
--- a/drivers/leds/leds-lp8864.c
+++ b/drivers/leds/leds-lp8864.c
@@ -10,6 +10,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/led_bl.h>
 #include <linux/leds.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
@@ -264,9 +265,9 @@ static int lp8864_probe(struct i2c_client *client)
 
 	ret = devm_led_classdev_register_ext(&client->dev, &led->led_dev, &init_data);
 	if (ret)
-		dev_err(&client->dev, "Failed to register LED device (%pe)\n", ERR_PTR(ret));
+		return dev_err_probe(&client->dev, ret, "Failed to register LED device\n");
 
-	return ret;
+	return devm_led_backlight_register(&client->dev, &led->led_dev);
 }
 
 static const struct i2c_device_id lp8864_id[] = {
-- 
2.55.0

