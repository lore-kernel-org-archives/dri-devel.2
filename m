Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC00C606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 23:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gM69ShwZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F5710E7F8;
	Thu, 19 Nov 2026 23:08:38 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1085110E7F8
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 23:08:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0888760D63;
 Thu, 19 Nov 2026 23:08:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FD891F000C4;
 Thu, 19 Nov 2026 23:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795129708;
 bh=rsh2KTRK/R1JV+vEauWOvFrq+yryhYrhMT+xCpZt2HQ=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=gM69ShwZ/arbn84bjIMfukFnEeCDvit8iwoVhsL9rtfJWJpEQPonZSTIjOPr7Ya21
 F0hvz7RiQ1c81y1RczT81KaXjaoq4daDW2jPrefHVVf0hqXzes5/qCdENd8fvs6dDH
 XDAE6u4ASBZSo3gWou2IQ6ftxm/Ys/DL5HaFhp2oBy7UnuGABWHO/bf7iycxKsDWzc
 vwLcIYdq7CD8kwUQgmDj9smrMLD8Azm+fMAlha7OGCT1uNiNtotdnMXayjc81RXOUY
 voHghFK3vwByKlEePns3A/8/IoIs/EuwVLQc7+dGO1pXWfBsDL1Kk3Odm3rM6e22de
 x5mFwdYnUf5Ew==
From: Thorsten Blum <blum@kernel.org>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Helge Deller <deller@gmx.de>,
 Linus Walleij <linusw@kernel.org>,
 =?UTF-8?q?Duje=20Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
 Jin Park <jinyoungp@nvidia.com>, Samuel Ortiz <sameo@linux.intel.com>
Cc: dri-devel@lists.freedesktop.org, linux-fbdev@vger.kernel.org,
 Thorsten Blum <blum@kernel.org>
Subject: [PATCH 2/3] backlight: ktd2801: Initialize properties before device
 registration
Date: Fri, 20 Nov 2026 00:07:35 +0100
Message-ID: <20261119230733.790573-5-blum@kernel.org>
X-Mailer: git-send-email 2.56.1
In-Reply-To: <20261119230733.790573-4-blum@kernel.org>
References: <20261119230733.790573-4-blum@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1959; i=blum@kernel.org;
 h=from:subject; bh=X3UfGmDdORzBTTEw5zZD1B0MnJ69uQnII8949ArZlAo=;
 b=owGbwMvMwCUWt7pQ4caZUj3G02pJDFn/Gx33q2dHlKjOLZr1N2DBni0zPNoeTymRcznadJ5tf
 Vn6rn8eHaUsDGJcDLJiiiwPZv2Y4VtaU7nJJGInzBxWJpAhDFycAjAR0w2MDHdnr3ywU3zH9Kj9
 cd09P+OvTeaLVtsrnjb5/N1AgyNn539l+Kdgu9KnTLQ/wSkw5p/Kvh9Oh1YWN91YrvXZsWj9pf6
 dZ7kB
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
registration and not to be modified afterwards. KTD2801 currently sets
it after registering the device, allowing userspace to read a maximum
brightness of 0 before the configured value is applied.

Pass the initial brightness and the maximum brightness to
devm_backlight_device_register() to set them before the sysfs attributes
become visible to userspace.

Fixes: a5554f1b5bc3 ("backlight: Add Kinetic KTD2801 Backlight support")
Signed-off-by: Thorsten Blum <blum@kernel.org>
---
 drivers/video/backlight/ktd2801-backlight.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/video/backlight/ktd2801-backlight.c b/drivers/video/backlight/ktd2801-backlight.c
index c218ee55f253..ff149de36dee 100644
--- a/drivers/video/backlight/ktd2801-backlight.c
+++ b/drivers/video/backlight/ktd2801-backlight.c
@@ -58,6 +58,9 @@ static const struct backlight_ops ktd2801_backlight_ops = {
 
 static int ktd2801_backlight_probe(struct platform_device *pdev)
 {
+	struct backlight_properties props = {
+		.type = BACKLIGHT_RAW,
+	};
 	struct device *dev = &pdev->dev;
 	struct backlight_device *bd;
 	struct ktd2801_backlight *ktd2801;
@@ -92,15 +95,15 @@ static int ktd2801_backlight_probe(struct platform_device *pdev)
 				"failed to get backlight GPIO");
 	gpiod_set_consumer_name(ktd2801->props.ctrl_gpio, dev_name(dev));
 
+	props.max_brightness = max_brightness;
+	props.brightness = brightness;
+
 	bd = devm_backlight_device_register(dev, dev_name(dev), dev, ktd2801,
-			&ktd2801_backlight_ops, NULL);
+			&ktd2801_backlight_ops, &props);
 	if (IS_ERR(bd))
 		return dev_err_probe(dev, PTR_ERR(bd),
 				"failed to register backlight");
 
-	bd->props.max_brightness = max_brightness;
-	bd->props.brightness = brightness;
-
 	ktd2801->bd = bd;
 	platform_set_drvdata(pdev, bd);
 	backlight_update_status(bd);
