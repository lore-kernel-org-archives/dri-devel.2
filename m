Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CE86606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F53/0xTQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D10310E25C;
	Thu, 19 Nov 2026 23:08:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE33B10ECCE
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:08:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 85F5046355;
 Thu, 19 Nov 2026 23:08:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA5B1F000CA;
 Thu, 19 Nov 2026 23:08:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795129705;
 bh=BmejuJqQk1LKC4c2xj88W9TXrHdHdf5/PDc/zgOa/LU=;
 h=From:To:Cc:Subject:Date;
 b=F53/0xTQ1j0y4T6PYC35h/6uVrH5WC13zbOZv/IgUKR4i1AkStM6Pdeu1X0Bt0beo
 zMRxsJdjU7wFy3bkP8cWM3DEZhP6UvC9/xfUn0SxDJQtd0Mz1cK/ZMjIkxLwjAliPI
 LOKEFwZgT0PMuoau5A11r1vKOGawDbLJjreopqkXOgbdlB5wGqJ/CorAlaqdZx3f/Z
 L+kTBzAd/jsvYKwx/7FhnziTHqFK4oARdcQMP8mNq03NkKFFlaPKHkFm7N2IoV5yUA
 tHegfdxJY+MyzIIitm6uHMbJfcUeB6XskC85MW7AQtRttDIWNWOxYfbBYEZN5HxRlF
 sJSM7RiQv4G9g==
From: Thorsten Blum <blum@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Linus Walleij <linusw@kernel.org>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Jin Park <jinyoungp@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thorsten Blum <blum@kernel.org>
Subject: [PATCH 1/3] backlight: ktd253: Initialize properties before device
 registration
Date: Fri, 20 Nov 2026 00:07:34 +0100
Message-ID: <20261119230733.790573-4-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2199; i=blum@kernel.org;
 h=from:subject; bh=kc5+O90pUjknLmYeQlBUB9W5BSzJMr1ZVMWcsFX/mfI=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn/G03j/6tXP774e908h9d5Cn0SfH3n/XkWmoWsr3f79
 3qFzCfdjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIzM0M/1SVO60a0+Tez+2M
 /zatNrBBdVUIU/TEyx3MPnX7f0su2szwv67I5W7xopqTZb/nfovf6M6+eJFAn+vlhSZFHLveyRm
 xsQIA
X-Developer-Key: i=blum@kernel.org; a=openpgp;
 fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The backlight API requires max_brightness to be supplied at device
registration and not to be modified afterwards. KTD253 currently sets it
after registering the device, allowing userspace to read a maximum
brightness of 0 before the configured value is applied.

Pass the initial brightness, maximum brightness, and power state to
devm_backlight_device_register() to set them before the sysfs attributes
become visible to userspace.

Fixes: 5317f37e48b9 ("backlight: Add Kinetic KTD253 backlight driver")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/video/backlight/ktd253-backlight.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/video/backlight/ktd253-backlight.c b/drivers/video/backlight/ktd253-backlight.c
index 8091c7e085e8..5fc29c858a4b 100644
--- a/drivers/video/backlight/ktd253-backlight.c
+++ b/drivers/video/backlight/ktd253-backlight.c
@@ -141,6 +141,9 @@ static const struct backlight_ops ktd253_backlight_ops = {
 
 static int ktd253_backlight_probe(struct platform_device *pdev)
 {
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+	};
 	struct device *dev = &pdev->dev;
 	struct backlight_device *bl;
 	struct ktd253_backlight *ktd253;
@@ -179,21 +182,16 @@ static int ktd253_backlight_probe(struct platform_device *pdev)
 	/* Bring backlight to a known off state */
 	msleep(KTD253_T_OFF_MS);
 
+	props.max_brightness = max_brightness;
+	props.brightness = brightness;
+	props.power = brightness ? BACKLIGHT_POWER_ON : BACKLIGHT_POWER_OFF;
+
 	bl = devm_backlight_device_register(dev, dev_name(dev), dev, ktd253,
-					    &ktd253_backlight_ops, NULL);
+					    &ktd253_backlight_ops, &props);
 	if (IS_ERR(bl)) {
 		dev_err(dev, "failed to register backlight\n");
 		return PTR_ERR(bl);
 	}
-	bl->props.max_brightness = max_brightness;
-	/* When we just enable the GPIO line we set max brightness */
-	if (brightness) {
-		bl->props.brightness = brightness;
-		bl->props.power = BACKLIGHT_POWER_ON;
-	} else {
-		bl->props.brightness = 0;
-		bl->props.power = BACKLIGHT_POWER_OFF;
-	}
 
 	ktd253->bl = bl;
 	platform_set_drvdata(pdev, bl);
