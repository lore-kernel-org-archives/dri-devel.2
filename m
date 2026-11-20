Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93A02606A336
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 11:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FR3bB6KW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8BC9112959;
	Fri, 20 Nov 2026 11:59:22 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF11F11296A
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Nov 2026 11:59:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FD60611C9;
 Fri, 20 Nov 2026 11:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 851F41F000D0;
 Fri, 20 Nov 2026 11:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795175955;
 bh=OH1Kjdkvjz9fqdqPpnQbI2QzI1uja4zHK28cDtBKYKU=;
 h=From:To:Cc:Subject:Date;
 b=FR3bB6KWE4BjcqJkT60CNrtO+1ByPfSoefzvd4fb9jnuD3eBgKMWLvg10m+oEYdBI
 1guBVutWFcwCjdSKxpIE+/bBpsZx2XJWt4OxFyjAydLX+xRmBVvEIawMMzanmAFLeY
 whvxidhn25Sb94KTbW+Gj5IQVxyC9BktxaTZ7pTm7H+nBQihIWlrT4v8mqAg/4fUVm
 +Q7jME34VLSWFb7WQl7gAhMGftZPDp182a6zm/N5K3lM5ucEWH1PclFTOGZzLQvZ6j
 W6yeYi8XaPjdHCRLaqhlh0U8i3FUcu/vZUCGYtt7STbwVM9MrpWazTMrW8BDj2fSII
 m0tNJyXqC79+g==
From: Thorsten Blum <blum@kernel.org>
To: Support Opensource <support.opensource@diasemi.com>,
 Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>
Cc: Thorsten Blum <blum@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org
Subject: [PATCH] backlight: da9052_bl: Remove redundant property assignments
Date: Fri, 20 Nov 2026 12:59:00 +0100
Message-ID: <20261120115859.814392-2-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1745; i=blum@kernel.org;
 h=from:subject; bh=wqEwl+sO+X6agGWcg/jgVhbxByRSyamnzVrmfulAPvQ=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDNkMZszM55X/HbD67P55g15Vh2RIeZxrX8j/DV7RudsNH
 qlve1jRUcrCIMbFICumyPJg1o8ZvqU1lZtMInbCzGFlAhnCwMUpABO5aczwv/4WU8MCgf7ky1M3
 msv2v4m7zhPsdMzm8RuHHT/DE7eWFTIyvMgpW2Ko8fXVQxfl2b+6XdPmhCyJzZx2oJNZJmLbwg9
 JvAA=
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

Remove the redundant assignments after registering the device and use a
designated initializer for the backlight properties instead of assigning
them separately.

Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/video/backlight/da9052_bl.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/video/backlight/da9052_bl.c b/drivers/video/backlight/da9052_bl.c
index 406c12434c44..f512b96cc500 100644
--- a/drivers/video/backlight/da9052_bl.c
+++ b/drivers/video/backlight/da9052_bl.c
@@ -104,7 +104,11 @@ static const struct backlight_ops da9052_backlight_ops = {
 static int da9052_backlight_probe(struct platform_device *pdev)
 {
 	struct backlight_device *bl;
-	struct backlight_properties props;
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+		.max_brightness = DA9052_MAX_BRIGHTNESS,
+		.brightness = 0,
+	};
 	struct da9052_bl *wleds;
 
 	wleds = devm_kzalloc_obj(&pdev->dev, struct da9052_bl);
@@ -116,10 +120,6 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 	wleds->led_reg = platform_get_device_id(pdev)->driver_data;
 	wleds->state = DA9052_WLEDS_OFF;
 
-	memset(&props, 0, sizeof(struct backlight_properties));
-	props.type = BACKLIGHT_RAW;
-	props.max_brightness = DA9052_MAX_BRIGHTNESS;
-
 	bl = devm_backlight_device_register(&pdev->dev, pdev->name,
 					wleds->da9052->dev, wleds,
 					&da9052_backlight_ops, &props);
@@ -128,8 +128,6 @@ static int da9052_backlight_probe(struct platform_device *pdev)
 		return PTR_ERR(bl);
 	}
 
-	bl->props.max_brightness = DA9052_MAX_BRIGHTNESS;
-	bl->props.brightness = 0;
 	platform_set_drvdata(pdev, bl);
 
 	return da9052_adjust_wled_brightness(wleds);
