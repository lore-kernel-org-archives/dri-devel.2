Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A60E2CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:10:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06D8110E713;
	Tue, 13 Oct 2026 18:09:56 +0000 (UTC)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B39310E713
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:09:50 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-48c6955a7c3so871598f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791914988; x=1792519788; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ZwqTFwjGa56BYbboUIBQ+4BPXdstI8K16QSmTD6KIFk=;
 b=d2lPg1VHN6tNaDkG5YfO5y3aw1cnxmu0QXgYYz1tjO+PILHGR+LZdvKc65nqTvHsf5
 MYKSENOo/0W/pej0jqJwaNNh91plkAQ0T0LDfbgpyCkUZb3Q+w2Vs556A59I5dqOqCQ3
 I0yv+FWIMiJ+zJ87yKHt18Y0p1QfnRm2D8uqEBoLLmvRXeNlJl6mH3I975grEkmdvZIP
 FvJFRob7cM6PKYIniVQx+AfECx3GGT8CTIKL4JMXmhdf1570ClD/W9RJLq9ADP65X5jK
 xmsGnZ52axJruLPDnu2nNjWJKfsM2cxdULyqJwgWABC5a8MWwtgIh7hiFGGMCN54JFUO
 NnWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791914988; x=1792519788;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ZwqTFwjGa56BYbboUIBQ+4BPXdstI8K16QSmTD6KIFk=;
 b=NTznWLIJkJ3PQrXQF/ya9mZZuIFLMFs4E04xNjWadt6twrimnPc/Nb8tqrY2Rqh7Oa
 fZ3KCTUAZMIRrfyHeUugmQG2LGW1ItVJdZSq0zxdEaOpWG8dpDOeNjXbo2Ju+RL7XjsU
 3M4CvqeaWi1NAPuukIb8KjawlklxFrP4zJ81Q7jGorgGRDtaZvul/ZkXZMIxc8A/H7rv
 V0P/qSJw2JyVBRTnZHpOW1t9pUYh4vfGlhZ6LBixbudHPGSFXo9TE8Nt8+Y+zdM9JjV4
 dt20AjOesNs7M56+Tkdvy/Wo54aGKU9Lqcp4Sa6agJS0raCyYkDEHZZPl4ZR2UPhwNcF
 sf0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxY1C6QLbSZbRNAljoJiQ2vo2opLeNHbvekjysAhJU+lkY+raFCFjj/VPejQWdk+ukwyYhrL7XheY4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIO5uRhNLTJD1WUHO8Di/11ZNCqGtSH+8h2yPoVYNA5gGu1LkiW
 D93M4F8a+xn+nHVfkdSL2dJ6v++3c1dgGHkPVxYAUalBh8QM7OnAv3y+
X-Gm-Gg: AYBFou0ZYd1OApz4YjhDdkAVOL4uNF0Vws9AWfyi8agcn3endeD81fNA3wPiR5PrDSB
 GbT7dhLKpRqyWwPsdeNYNtfG0eLFE4gYOnlXgiSyZAoHoH1DHfEiNlBYwRHzEleLwHbzZrUAcWI
 seWAtrhT3hNCI55xl+Q+AzORTCBBKwsDUhnNUYbytPXZBg4lWsCWm/UCB2whB+aaDmM6wTaw6Oi
 JnbP/OpeueoAntrgXuCF2UjOdxglC2bAhuCMxiN/tIOJKVAqxKZ6WHAsNhl0HRNuye2/BMlr1xF
 F323Lfqp0oJZOAtx0Qa7O4zmq+rYo0zbQBDg8nuAYEoDLGfhCV3pW894xq17sZdbYHlkM2b9dCz
 vi7+bCtbjFtL0BQyDqr5DnForqWR9rqvZ/xkyXQmef1Us56G5zPPSwjWH2fOF1yF/bs7Ze1cKLt
 u51WmYkQQcOGtV3fltPTTnMpfgNnXCQWkssxomIm6l5UvXInDvN79vZpz0WrP3RfvQW35FQUgYl
 XmlkVB7lHanSbI7fO8=
X-Received: by 2002:a05:6000:481b:b0:48b:11ee:de66 with SMTP id
 ffacd0b85a97d-48dbad1217fmr23545543f8f.34.1791914988401; 
 Tue, 13 Oct 2026 11:09:48 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaaebsm6854498f8f.14.2026.10.13.11.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 11:09:47 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3 2/4] mfd: aat2870: Derive brightness steps from max current
Date: Tue, 13 Oct 2026 21:09:31 +0300
Message-ID: <20261013180933.487013-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013180933.487013-1-clamor95@gmail.com>
References: <20261013180933.487013-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The AAT2870 allows only 32 steps of brightness, with this amount defined
by the maximum supported current. Remove the need for max_brightness by
calculating the allowed number of steps from the maximum current.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/aat2870_bl.c | 30 ++++++++++------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 8b790df1e842b..eb686e315921d 100644
--- a/drivers/video/backlight/aat2870_bl.c
+++ b/drivers/video/backlight/aat2870_bl.c
@@ -24,18 +24,6 @@ struct aat2870_bl_driver_data {
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
@@ -69,10 +57,11 @@ static int aat2870_bl_update_status(struct backlight_device *bd)
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
@@ -150,10 +139,11 @@ static int aat2870_bl_probe(struct platform_device *pdev)
 	else
 		aat2870_bl->max_current = AAT2870_CURRENT_27_9;
 
-	if (pdata->max_brightness > 0)
-		bd->props.max_brightness = pdata->max_brightness;
-	else
-		bd->props.max_brightness = 255;
+	/*
+	 * The maximum number of brightness steps is determined by the max current.
+	 * The aat2870_current enum maps directly to the allowed brightness steps.
+	 */
+	bd->props.max_brightness = pdata->max_current;
 
 	aat2870_bl->brightness = 0;
 	bd->props.power = BACKLIGHT_POWER_ON;
-- 
2.53.0

