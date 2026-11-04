Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5849606A326
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RDlUC609
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C16310FB9E;
	Wed,  4 Nov 2026 12:37:39 +0000 (UTC)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F86F10FB9E
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:37:33 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4a210470b49so4730615e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 04:37:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793795852; x=1794400652; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0X4rUoAWbYYwWIlyCXzN+FfLPErCmWPcGeI3w9a2qVs=;
 b=RDlUC609/Wgt0Ch8OLY1j2/vGQBhv1t8AtjGq2438VQK0yuEZ4KBZjTl1V2s6miksx
 JOWPiGGXuJo7Rhack409hYio7jpE9shzJZefeLG0YpPi1whcGfjaTIqjY52waYX7hIgw
 GdevrCQjdWyt+j8yBG5uBDF3IF5T+OjMU6uneJXkMerea2NQhMTZ3PDz9CMxk5qzta5c
 vYIj+aXCj5jEwwJH5l86bd62/d/EMSdt6MOI4IdjoKeWW28sGNCa/9cBFPzilQszc4vW
 hj823eINNwVK5X5xV4Q8OYGkqOeUNko+Y52p9s8+osUMUIztKDT7vwTRW2qkqEFLH76g
 2Gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795852; x=1794400652;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0X4rUoAWbYYwWIlyCXzN+FfLPErCmWPcGeI3w9a2qVs=;
 b=fK5Hw2FbDS6ydrL1eVo4qmysBHs/YxvtpIdHIDxqdM2drPhTCIi1bBJR3VkwHD8W71
 zgZuaMNvY85izD0zuPAoWdrE8QLqKRe6xDnDxkf/hyV9CFe0BNZ/xn8ZUZNXz9+UUmy4
 ioc02GNWbAPaXU9ytnT6+NKTo4znAQV8XRlQnQaFBJOWx3ObBzVAVchEorGywOcke0Wl
 bJa2yVVcYC8C+OKckhHyf3+m/DmS/vkqT9xkA/c5wfO40qPGSWd2YpFuYR+0pFuU2Qch
 HuEoHhoYBRqXFKowT4Fe78Ncvlqb7SRxRw6FhCIL8YvjLzLThoAX4tcujuawAHah2YQv
 YqOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBwKcwPdYXsXCkzegrlDxAm/b+kh2Yk+pvtoRGOO1oEXOngUlfNzAHP5s00MzLaNVVOo8lsEpe30Auw=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z81rwXAScr4yXH53D7qshSSEn8fh/+m4qTUqO9LqRXcM82d2/7g
 3DGc1OJt0BsWEKHX5wmwvsl3fg1r0rVztNaji5hHMqy2O6Iyvnc0GauE
X-Gm-Gg: AYBFou3HZIhJCu+qo9Ksl3fCv/kwHQtLaVUM+UjcSKWvhH5Tn0Te/rKxN37ODnbU/ZA
 F6qw/RfnkURdjTh5DjpvXjn12dVRHNxEd+DfCCGpdchzBBo3P+PpKdb4vMcgPLhAy12CSIm4lBe
 s+/CFvF6XKrUazPss+JdltNhcVa72vmuFtX0qfSwppX/Qru2RCUm/u6YHH2j7AJeLw15GTQTerk
 g/zdhv4G8uXhmwMjirOAMwqQl7Z3PUMPsREJrLDOZUIN+LxKTjp+2ZWr9mzFjeHSIqIvD3o++1Y
 AQssAJTOROS9cOHshIylPtNXSlhndeJwHspHrVlkKBEYGGlswOh2bgu7o1qpxk7sLu57YZAm9yo
 tM3pmU49q5yKst6JMo17p1s8vYfnE8TzOS3grBJwMNGrDKpysAZh2wZne9x6MslWa3qBuP5WS5n
 IBxUb0diT+IlBzeLy0FOtPKQaJyH6iaQOELygxy2ANfPt4nuCIQfwwN/TIYJQ3WYOZb9bBntEsG
 FvOszXKxU4R74Cqqf1enw/fHypAsa7vqM/Q3iOhX463J2iibIOKCf3Bk9IQ/JyhL5/dFH/QbeMp
 jlrCxa8Yq9S/I1VDHZtJJk4tQzeQNO3KNFBtqWYOTiDxYJBvnw==
X-Received: by 2002:a05:600c:3b1a:b0:4a7:9044:a87 with SMTP id
 5b1f17b1804b1-4ac18c73df6mr367279085e9.27.1793795851589; 
 Wed, 04 Nov 2026 04:37:31 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed553441sm3386155f8f.43.2026.11.04.04.37.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:37:27 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 2/4] backlight: aat2870: Derive brightness steps from max
 current
Date: Wed,  4 Nov 2026 14:37:12 +0200
Message-ID: <20261104123714.234634-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104123714.234634-1-clamor95@gmail.com>
References: <20261104123714.234634-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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
Reviewed-by: Griffin Kroah-Hartman <griffin@kroah.com>
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

