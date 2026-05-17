Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF9FCD4F25
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 07:43:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AA7510E1AE;
	Sun, 17 May 2026 07:43:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="B4BLyaGc";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79C3D10E1A2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 07:43:40 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-43d73422431so711124f8f.2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779003819; x=1779608619; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0LzbpjsuKPCXdtxH83s9qoUUdpBAxIBv3nnvj0Qfzzw=;
 b=B4BLyaGc1oEtkKrNJcxkoFwkqIawqm+0S/wk5WwS3vno5mXlxlVeZ5CXFSFlSHbf0U
 v1JEmtusnz9jgSV+PAVykWJJB9uul5gwOztfqGwijGQ8FMmE8YMtTPqvQqdQN8Y/vSIh
 59b60K0ViDQf/cYRpQhBQ9IE9OOZyQQw3PxhxkZbQAXCXhVFN62ua9xLbq8NGincHE1n
 qvpoDGO/CMjkJyrGkfmq11nvP/1ovLqmV6qtDAng+GgWbr6PJCheEAm56hmSTsXMUJZw
 bwj5QftK1VC0v7AWc/wvU+P6M7MOvtg0+S7PYZt7bkz5GEAA3f9O8CLSJNaTC+2VLRVj
 6ASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779003819; x=1779608619;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0LzbpjsuKPCXdtxH83s9qoUUdpBAxIBv3nnvj0Qfzzw=;
 b=fBDpxStHy/qoj0pz/dhaBnUdrfQ0a3CfuoDNxjkUkIJHF/1yybABBrXcUZK/Ln8I9z
 2K302K7qhRSdHexJfOxyUgS5GHgi/UHww3gG1ED3bDu3PLzil/UsapH9/J3h7s8UB+9u
 q4iSe4BgTJjppDizCMW6LGB9M+Qcy8DRB1y+HxlYRolyTwCJ3KbKmJoDWmTTdCH/G42p
 92jMmcQpbxdcSveInWlFHLPRsGH/2qCMJ6AWTxsXh+bQGkoWASc3k7taC086bxNuxTgj
 kkemp9pjDer2xZoR4FPXGM4gA1gST4IJi7M0ZPKSEChddhaBxzymIstAbXrl9TpTyN5f
 F73A==
X-Gm-Message-State: AOJu0YwewHkYQURGOQOky3bNxpxn2ZfPc65mnreJbg3pvz6P65RhgilF
 9yO05qeBgHBxheEt9t4k0SNme+tD1QFu7wv0kgHciTQTcZ8I2Vv93bmTABz3CA==
X-Gm-Gg: Acq92OHAeOAE619FNiu1DOUcQ/1D0nCfuFr6RXk2WFV+n2Fs2h5Z6PtZfKA4Hl7O8VA
 D/a5CC8FCDjydQFtqmXMuBEGdUc6nXQF2l+H/RdEy98I8DPVzxIiv2tYygy6gcuEhGYnyY306BV
 3+E1HirVhWrZooICuC1LAjuYG69kb/vdkp8k81bWwM3CXgKBwIv4lDM+d8IeweSiUr/j2lVnIjO
 M8Xs0ZDO7gVbKjTsMzmepME38Vu7/TiLLhiVXCBWaCU8FR32b9X3UkbYXd5RjBSCTJ9I4XqMJbd
 SHYR8egJ34jOqHn5HE/DDHfYgz065cQa3xtcNY2FvYt2GcWBhNdrE7f+9BhDhaYBcq3cCMHgzuZ
 wS5ikCilL0jfYgub9anO2NtT/inFUbrw8GWLZvzQN2bnS1Uuvtnv2eBPyyXtqw3KpBlAhc4Bft6
 WiqG+ZcYBGPLV8
X-Received: by 2002:a05:6000:603:b0:43d:7c6c:a0dd with SMTP id
 ffacd0b85a97d-45e5c609a1dmr15044926f8f.35.1779003818881; 
 Sun, 17 May 2026 00:43:38 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 00:43:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v1 5/6] video: backlight: lm3533_bl: Set initial mapping mode
 from DT
Date: Sun, 17 May 2026 10:43:05 +0300
Message-ID: <20260517074306.30937-6-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
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
it unconfigured. Additionally, update the linear sysfs code, which uses a
similar coding pattern.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 32 ++++++++++++++++-------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 42da652df58d..be9114b7e0ad 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -22,6 +22,7 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -32,6 +33,7 @@ struct lm3533_bl {
 
 	u32 max_current;
 	u32 pwm;
+	bool linear;
 };
 
 
@@ -135,8 +137,9 @@ static ssize_t show_linear(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
+	u8 mask = CTRLBANK_AB_BCONF_MODE(id);
 	u8 val;
-	u8 mask;
 	int linear;
 	int ret;
 
@@ -144,8 +147,6 @@ static ssize_t show_linear(struct device *dev,
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	if (val & mask)
 		linear = 1;
 	else
@@ -159,23 +160,16 @@ static ssize_t store_linear(struct device *dev,
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
-	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, val,
-									mask);
+	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+			    linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
+			    CTRLBANK_AB_BCONF_MODE(id));
 	if (ret)
 		return ret;
 
@@ -253,8 +247,15 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+			    bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
+			    CTRLBANK_AB_BCONF_MODE(id));
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -333,6 +334,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	bl->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		goto err_sysfs_remove;
-- 
2.51.0

