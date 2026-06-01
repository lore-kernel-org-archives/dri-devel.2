Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD40BCD6E66
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D99331134A4;
	Mon,  1 Jun 2026 15:19:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="efViJFox";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AC851134A8
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:19:11 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4904c1ce4c1so114801965e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780327150; x=1780931950; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MeSJxuqtwsz6jGt+YVFicWB8+6LnFt3NUvnbNkDL/mA=;
 b=efViJFox1djP3egNBgvZYgngKfTSj0P80mKGEE8vKmmj+hrjVG8hECwApp3DFbgGIZ
 X3/k7k7D8zEG/EHkUwEd1u6cBymZhyLlJ3jrYwcZlSQZVwtwTygt9Mql0Egvwf5bcP74
 y4coYuNHT6FMJmJCEmMXd4akp0k0I/AOdMsE6TGx6sB1pnlVyOA5qW+6nIpwsQCOkHxu
 Qouh2bYeDIIVUYepYCeLz+14bnspYmJQ3oHhbhj5otbvRDfyUG/jwcHZYQ3wX6PaxB7/
 TyWBfJ35cnQzmJt/eLV6dvCD0hAYf36gOtnuhUJgzpM2+mvuZReWE3g0peeMiznCyXJc
 7F3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327150; x=1780931950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MeSJxuqtwsz6jGt+YVFicWB8+6LnFt3NUvnbNkDL/mA=;
 b=eZYBI0xv4dfc+bu4UPkaV5GMFTIfJzkcq2j/fCJdqPAs7d4Zzd0rOGMCPHWANJr7Bp
 rH0SB2w95eSYqTN6O0yBBdb8DvG0ZpDU3yPccvxFyRZs0HXVACcrmFcMefxiEbNLt3dx
 mtaGNuON7MiHol6GlFngF41/FSfgiAMXL0hIdmZV9GCkkCXorABbmlMHT9GVlAJsrTCo
 wTJ6Xp6sVVjYheX8B2qvBUQOTqGyTeQNy10IleMacSszV0of1ub/aXB5pZt/Hs/tK13T
 KvZExldJipOkudUJKNVfCRL7PmV3wPo8olITOlqbeIFJAXxflWtArSYkqq4qIVEfRjXw
 NZUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ93Ac+TIyKU9cXjJouVgrZXXH5vKYCY8iA+pavB9oDceuMG5c4Jel892+ojezRDvhb4uGXmGd1yCEM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx/wY2cna7wl5flLd48scyyD0M/fn1EASD8Iqc/ZI1rgCgs3XaM
 yamVRP1z3x4GH3oMdE8eT7U7Hn11z9cjAjTHIIWiJb+0NCCyYatQ/Bxn
X-Gm-Gg: Acq92OFmmHTeQN2JBkCOL6FGzrSlWb5GcuMvx/ys0naxesDSvatlYijg477+0cbTHjO
 ldhPDAYENwv1BSKyZjiEUG2PXXNT/UB9KbJnuzhpuJwNmh6GViwxdlXzVR4iC8NNd0CYe6fyRz5
 4uP9jKVEnTnZK0DAa8UKV6EFv+2un5xw8ygWO8Wg0shnn2OrSE8RD/A1DRLVma/QWzFjHI2738m
 qQFbP47cSKQ2t8fjoABtO8xnlcOtOY7owmF4tV5KFPnwEsdewFbezGXOYd0iLD4aiqdrrH5Xa4f
 8dAm7xZR6Jz/7czBNZY2Cf18VrBZT38L2RkJ7Br1HLBeZhT56hgm2d55YfQuylwIsBKmuiFITW7
 w038yTzikghV+77tbIZvW78lUVeKGOpmjDRHQ+oVMj+AiTtX4tOTokgchpyva7Et9d6esAFTOAI
 cjSzIp5mmfVdCEZbn2XGKElAs=
X-Received: by 2002:a05:600c:4715:b0:490:7136:ad05 with SMTP id
 5b1f17b1804b1-490a29748dcmr205098165e9.31.1780327149765; 
 Mon, 01 Jun 2026 08:19:09 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:19:09 -0700 (PDT)
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
 linux-fbdev@vger.kernel.org
Subject: [PATCH v3 08/11] video: backlight: lm3533_bl: Improve linear sysfs
 logic
Date: Mon,  1 Jun 2026 18:18:28 +0300
Message-ID: <20260601151831.76350-9-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
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

Simplify the sysfs logic of the linear property by switching to a macro
and a ternary operator.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 19 ++++++-------------
 1 file changed, 6 insertions(+), 13 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index c70b8a3bb301..36e6f027613a 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -23,6 +23,7 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -136,8 +137,9 @@ static ssize_t show_linear(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
+	u8 mask = CTRLBANK_AB_BCONF_MODE(id);
 	u32 val;
-	u8 mask;
 	int linear;
 	int ret;
 
@@ -145,8 +147,6 @@ static ssize_t show_linear(struct device *dev,
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	if (val & mask)
 		linear = 1;
 	else
@@ -160,23 +160,16 @@ static ssize_t store_linear(struct device *dev,
 					const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
-	u8 val;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (linear)
-		val = mask;
-	else
-		val = 0;
-
 	ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, val);
+				 CTRLBANK_AB_BCONF_MODE(id),
+				 linear ? CTRLBANK_AB_BCONF_MODE(id) : 0);
 	if (ret)
 		return ret;
 
-- 
2.51.0

