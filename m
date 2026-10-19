Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3080BCCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:10:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D012410E98B;
	Mon, 19 Oct 2026 10:10:02 +0000 (UTC)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0492610E97F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:09:46 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4a171b677d2so11104685e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792404584; x=1793009384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=L/trV4jow8NDaSDq91x2ETJmC0OZjy2jDwgvKC6ameE=;
 b=g772F1HXtbP0ERVPfuVMZ/fqLt1X2xubkKcJqXxMB/vhOlJ2ejuJtMbqUIukpqqCvt
 36vqz1ew1N5jOKlDPvAgUD732ioQkM3GjMKozj3PLCixIZDMhczE7Z1nNxkMgXcqjMnR
 /j3+2F8C/r/PNKDby6lJBRREyunWvPrOyKfTsHMX73TWOG9AJ0ACm+Cj5xP+1N+n7gOp
 XQOoSZvMhogPEjPyr/SkskeE1xAhxiLDahEcNrFXacitAk8WT7yPW+FvNVlIGV0Wg1Ro
 BvNMetMizWqkW0fQIvAwQYXWzMc09CrkvQe9Hb/7b/1hQ+e97kUbgRlObHgm2xNR37ku
 xsDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792404584; x=1793009384;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=L/trV4jow8NDaSDq91x2ETJmC0OZjy2jDwgvKC6ameE=;
 b=JlzJxjLmtGt0BrXo9lRiXmuhupmMxLHjihVBJygJdqIBto1C/zCB8AaR2H+AvFa5ay
 h1tfRG2kkRld5xL6BylVp9d5Qaye6ubHteYyCAWdbOzTMaMNJCdD1zW+HhBaKmJYFPQ1
 86rhHStMwg4HEKjlrEEEoI2XhtVPnqlcGUPvF4uqRhkNdho4jxMzxwR6fuGMGprVnyBC
 63k8VNHSnUlI/MhlnvH+zyr2XqGyxAhwuhsvt+HkjWxI07z1OxzYWXGdLuefdQBO2oAl
 d4hQMHMJJMOBwrhHTdsjFgtfCB5Zs4CIuXU+ETLN1ZgHxB1Q5ZthkeZwmHyHvKuWuGcd
 jvRQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBw/6Z+MxqF3d7Gc4rhjTFJeBgzoo92bTrnsVP0lceDv4Hn60BSXNAQu9ia5jDJX8ZJYL9jMOsP8SsM=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKbpMndbFtaFNp6hRZhquvBCUimxiV8CRoGrxENnanDS3g6URPM
 dwYc69IV378e2OHYM3ITnjV0IAA0cplKbEf1c0+lvilskquyyed7A7iW
X-Gm-Gg: AYBFou3aZ4otBFL7pOqVORMz80rt9qc9r2gJ6Kdqh+eC4arqe0KO/41DSqPm0WW6jxF
 ybCHtz7T9YvTUMxshXt7qUvPgCnIKxkGXVypgO78BB1DnJly3ve+We5moqs43xdk14N7c+qeb2U
 N/TujbHMKlRWGsxHsj+jPM7UcqOhNrd9VRqVzGRWi9X7+ffOmv/jp1whJfCCeSMnUnvQvCWvd9E
 mZL+EOrsMnvrMm7GV5mEie98RSGPXjrLiV7PsgUteZLxesI/p7LslIwJvpAtLSEFVZ8MeVeT8ZJ
 ZtPxniKNcOx3UFPkkD0Z03/IjJ7CkJNOx2/ScVK0mzyGKlv/O05xUKMoDGmOZHGSxlsGjmgH4Hi
 jrJeW1ZsQCLGcELYXsxK6W/N16gOEQkk3OEI+so5n+q/Dxe2w+w7iKUYQyKypK6XW10c+++rmdN
 DWjhJcENs9+7rnnphJX+F8gHdauYvpnXQej3rV5sFAwyoKbN9De4cnzSzRTEi4WUDTEwwyQPsKY
 Hln86Z0xM+5zs0iRK0=
X-Received: by 2002:a05:600c:3b91:b0:4a1:dfaf:f43e with SMTP id
 5b1f17b1804b1-4a1dfaff680mr129256885e9.1.1792404584307; 
 Mon, 19 Oct 2026 03:09:44 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm510533485e9.1.2026.10.19.03.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:09:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 2/4] mfd: aat2870: Derive brightness steps from max current
Date: Mon, 19 Oct 2026 13:09:28 +0300
Message-ID: <20261019100930.110954-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019100930.110954-1-clamor95@gmail.com>
References: <20261019100930.110954-1-clamor95@gmail.com>
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

Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/aat2870_bl.c | 30 ++++++++++------------------
 1 file changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/video/backlight/aat2870_bl.c b/drivers/video/backlight/aat2870_bl.c
index 8b790df1e842b..c9e764a94a238 100644
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
+	bd->props.max_brightness = aat2870_bl->max_current;
 
 	aat2870_bl->brightness = 0;
 	bd->props.power = BACKLIGHT_POWER_ON;
-- 
2.53.0

