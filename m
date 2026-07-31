Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D86AC5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A628310F237;
	Fri, 31 Jul 2026 11:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RvdgTJc2";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4BB1610F22E
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:37:21 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-472326ca506so612294f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497840; x=1786102640; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=h0eE6D17SL5fIygwG8Kw0xWT8mg9cqKbwl7rsTtSWgs=;
 b=RvdgTJc2AO6EqN4buWpxLwbNVoUvMhFhTixnPK8t6Ow4StjKLpA++m2TmVetgUDd3h
 lTJJAXWrsw/6MIgdHrvd5FZ09dG2I6PwcJZgZJpniKy87O4J/neq+PMnK3+CmRwCKKww
 7oTWFlitvm5waRX/Aj9t8GM3f5nkcGiIVSG3y1iTStQ+iHTFQOqGzsAENqz6j9NzjPDJ
 cRu1cZ8KhpnZzva9/FTUf5OcISB2zMuLhWMwZwIzTqB3XpQN5q1DM6Io4NRq6oxzAXFh
 WAb7vEoGDwAvyM7q49QMvienchrCACX9UR0xrStzJcmAyqDwd4tCqhI3MoLHpD46EGUG
 M+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497840; x=1786102640;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=h0eE6D17SL5fIygwG8Kw0xWT8mg9cqKbwl7rsTtSWgs=;
 b=D+bCGltuG9tKVfqVNTJpH51mN/thG8JgXsogX+hjtVSX93fIHLWgoJjiPoQwXsoO6V
 PUM+W2IyohTPskG/C3BnxGIsbLsBrtvmDb8jB2Fa6R4yMDQl+UiiobkSrvKmcDFQF/aL
 +/mJG4Hnj3JEocif1WPFSQUvwjHCpIwWfBK2OIP/no7DdlNEzCzvSafgmBUZbM4vrqvp
 A6LuSZaKr9JFziovpnnbkDb7pDfBePuUKUnbP9U6jLtFeJCGqHxC+ahdiqlD/sU+2OOG
 P2YnqK+nkcTyMKcqpO+fcppxo6XlhT4mxFBU2BA4TEBMxCzSeLkv32fF1s9zHMsEsqb0
 6VWA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqkKZ5FoiwWOyaE/fUD5+3iD6woFF5KYuZ/PKiwFz85GA/fQgSyJCbSYD5nlIAlpUAhbnFZyGc6HVA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0ktffZBYjalVxXgK8KGcvpUjEXNCBuOJWrWO/ZGiTktX67lz7
 jLC0MGx0UlItndtqppBiYb2vm57EleTp5/ZlgtW7Sgu9i5UQRtNKc23Z
X-Gm-Gg: AR+sD13MGA8MVkomDpcdHGyG/fjpIeyCIYyBtvE/JsjKDsk0cPrfZYQ+C9+wzgBRGLy
 anRDIa/NXGlOiB4BFxlrif6Y9Ub/qhC0NEOTs+0xX8xm/BgA7ogyoJAKt+tkWKHUdJLZLu7JsoF
 6rnt0Fh7npVV0eGtnW/FSIftMvjbPoBurW7Ru7lahw4TJo1BqLGGC+Ao/zjtJF9mwtkiQ8KtD0E
 cwXkqb7d5UbxhKMWj6p8NALGZW1cES00qJhaHGZWJOfsoIbm7LGRPAwfyt4tXENrtje/qoRvWUw
 h6MX8v8ygtpA5pnNelBFnnG9xsRy62tWPA2MJu1CACcZcaR8J6gr2GubNSIgr8rBNvFYu4mRzX2
 fb4CTgarohTK3ltzGmjdsV9SF+u4wIrez3Zdir0ZOLkcrF31S762vp+GfBHgfL566jCILZ0rmfF
 vPUbtyGRkYpEfG0wAAxVM9Njwx1e6w9/2Jl6GAUYhjuItviiJt2afwH57CoxPF1ht6wyzZncQEX
 rb3GFGJrQ==
X-Received: by 2002:a05:6000:184f:b0:47f:9760:4d25 with SMTP id
 ffacd0b85a97d-47fd2ac97a4mr4103846f8f.14.1785497839657; 
 Fri, 31 Jul 2026 04:37:19 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:37:18 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: [PATCH v6 12/14] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
Date: Fri, 31 Jul 2026 14:36:30 +0300
Message-ID: <20260731113632.158440-13-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 2e31a79628d6b..666213cab667a 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -36,6 +36,7 @@ struct lm3533_bl {
 	u32 pwm;
 
 	bool have_als;
+	bool linear;
 };
 
 
@@ -230,8 +231,14 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), bl->linear);
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -285,6 +292,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
 	props.brightness = default_brightness;
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
-- 
2.53.0

