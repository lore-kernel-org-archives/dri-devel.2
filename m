Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCBB60A6F50
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Z0KbooQo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D174410E3BA;
	Tue, 27 Oct 2026 11:33:04 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AEE5C10F3EE
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:32:57 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c43373ae89aso609006366b.3
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793100776; x=1793705576; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X+1ypqBjQvXyuz22Lalxe1uAPyrX+1OBJd94rnYYxRo=;
 b=Z0KbooQo+khyEybW6Z0YmkrR11Zxo6dt0TaGjDMLY6imNridBiMoS7s4HCixhOi5+d
 Ox978NXsSI2ZolImB8jUEbbn0S8v8ifN26ZaRQCP06MIi/l48yGNSh2cHdgw9TmW90/4
 +6xZRPzlal4uhFp4bUThBF4nL259KLk8FqO8ErLc8edVadj1AE/Yt9g8uIsiOpLOhl72
 zUmeDCI/RmHiqTUPdn4oPur7oRBes0RKR9ZqKDC1IpmoNfvJzkukVI/cfwfscpsrebyx
 s3DZBPVNIDFJGTYDFkp/62xAFVXxa9rhWSLY839cmjLsDAXCzSakIPQRlzgnqKOpzr+e
 5FIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100776; x=1793705576;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X+1ypqBjQvXyuz22Lalxe1uAPyrX+1OBJd94rnYYxRo=;
 b=v/yKLdoz8Azdx/34CwKyYf6Kly5crV/dHQ9Ck7KnNMQtjfStEo5/q0Lz7VYuF1W+40
 0x1/A2x27LSXqnm3cC4uFvY+sLWluluBUFCoVX/ICK7zDX2ZKy48yCkILI1+BHl14QOv
 YX/7FUAsQgHTZl9LnspMLbpOGgnfntb/Efqm+qFFubxNgMqCR8SmMVMI5m3pmaVPtW3I
 UXhVutbdm2oeRM3hmF9Biob0l6CFWqLFErgSTow5P2uePBqIxCcre0bQscLjXCcVXI+m
 iqSFfmIC3+Z4OMr2zR7MXEkQqtduB+qEw3oE9rm4ZNxFunZ5TpnsnvVUlxy/GznDGlCn
 X5gg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxC8SMRHouiew+zDmPT++j4O692HMifPL3IZh2V3gZn68oMwEbija0nd8kJC/Sgo765aBNp0/+dCh0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLoB1yiuD2HZPJ/fuilGk3uCekP865UaqebK3fPFD0sifPyqz+n
 EUsBIh21qhr3TvcyrosP48n95Sn1RbLPHQXBKnJU55oXNTDqOYQHePB8
X-Gm-Gg: AYBFou0yRwdjyDtoCPs9foKlWzO2FobJpujWp98jJcXJUwRFAf4klAGVQ2ciDakMGON
 mJCAnhYYngwZPiRHU8csh5MWVm9AtEeBuYKY8NNRVonN4wsyUr1RctCtg6iXN8m8FCFxhS3Rxv0
 5f8jFW55INsTti6e6W3MoOLgLvcRB3npIZq5w2wB5Zb3dAAc7cOBcgp+vR/ZZXTe8ZPUKOkxKcP
 YpRTby5ZNi80ol1qDV9w23AfQ0vx5OejbvSbpFK+C8c0p+o5IOQjYJ400iYgOkOKc53N+h7PdzL
 neebd2b79ow7Y6mDv1qWOXOzY909wMyHTkLOFvxR5+S7HvOq8etnZVLXY7HSNPVJJmwfu4gbvVt
 aDlr2pCdFesY4dTvlmpQN/+Jp8aanIgbkjX9l6NJk5Dg8aVmBiU0Gz71l661gx3NpKTJDQu4WtP
 pQGGTdqWKo3ITgSL8VidokbWl0cBaT/R6gKMABmTeplZNRCRMVUNgdpgQthEZsX5v0kAUpGA3H1
 1tgDtozohl0MGe7ewqy8ol3Wiw19L9JV7sot/da9Gt6lSvt5MjLHbHwwoHZ9CNoNg2+uzS4mmcI
X-Received: by 2002:a17:907:720f:b0:c46:7fa4:922c with SMTP id
 a640c23a62f3a-c46bde3211bmr1016964866b.24.1793100775923; 
 Tue, 27 Oct 2026 04:32:55 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea608sm428920566b.21.2026.10.27.04.32.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:32:55 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v5 2/4] backlight: aat2870: Derive brightness steps from max
 current
Date: Tue, 27 Oct 2026 13:32:28 +0200
Message-ID: <20261027113230.47538-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027113230.47538-1-clamor95@gmail.com>
References: <20261027113230.47538-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The AAT2870 allows only 32 steps of brightness, with this amount defined
by the maximum supported current. Remove the need for max_brightness by
calculating the allowed number of steps from the maximum current.

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/aat2870_bl.c | 35 +++++++++-------------------
 1 file changed, 11 insertions(+), 24 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 8b790df1e842b..e85f2b4d81068 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -20,22 +20,9 @@ struct aat2870_bl_driver_data {
 	struct backlight_device *bd;
 
 	int channels;
-	int max_current;
 	int brightness; /* current brightness */
 };
 
-static inline int aat2870_brightness(struct aat2870_bl_driver_data *aat2870_bl,
-				     int brightness)
-{
-	struct backlight_device *bd = aat2870_bl->bd;
-	int val;
-
-	val = brightness * (aat2870_bl->max_current - 1);
-	val /= bd->props.max_brightness;
-
-	return val;
-}
-
 static inline int aat2870_bl_enable(struct aat2870_bl_driver_data *aat2870_bl)
 {
 	struct aat2870_data *aat2870
@@ -69,10 +56,11 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
 	dev_dbg(&bd->dev, "brightness=%d, power=%d, state=%d\n",
 		 bd->props.brightness, bd->props.power, bd->props.state);
 
-	ret = aat2870->write(aat2870, AAT2870_BLM,
-			     (u8)aat2870_brightness(aat2870_bl, brightness));
-	if (ret < 0)
-		return ret;
+	if (brightness) {
+		ret = aat2870->write(aat2870, AAT2870_BLM, (u8)brightness - 1);
+		if (ret < 0)
+			return ret;
+	}
 
 	if (brightness == 0) {
 		ret = aat2870_bl_disable(aat2870_bl);
@@ -145,15 +133,14 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 	else
 		aat2870_bl->channels = AAT2870_BL_CH_ALL;
 
+	/*
+	 * The maximum number of brightness steps is determined by the max current.
+	 * The aat2870_current enum maps directly to the allowed brightness steps.
+	 */
 	if (pdata->max_current > 0)
-		aat2870_bl->max_current = pdata->max_current;
-	else
-		aat2870_bl->max_current = AAT2870_CURRENT_27_9;
-
-	if (pdata->max_brightness > 0)
-		bd->props.max_brightness = pdata->max_brightness;
+		bd->props.max_brightness = pdata->max_current;
 	else
-		bd->props.max_brightness = 255;
+		bd->props.max_brightness = AAT2870_CURRENT_27_9;
 
 	aat2870_bl->brightness = 0;
 	bd->props.power = BACKLIGHT_POWER_ON;
-- 
2.53.0

