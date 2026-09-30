Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5CE6CA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:15:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DBD210F1FE;
	Wed, 30 Sep 2026 07:15:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="BFeuIG0w";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2DE9510F1FE
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:15:30 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-48434392b02so4317056f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:15:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790752528; x=1791357328; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=91UgRJj2a9cqCekJgIMfhdUvCOQ/1gwR4pNIdWvIxRc=;
 b=BFeuIG0wXmj0zCySF3sPSILlOaFkDmtNJmTD8RTl9kiynbCyEoEgukIYlAKAgUA51u
 xyv+X+NuSAnxGMaj0eSKNkqaL2/xwMy0sF6WuTcjJdx90+vomMkSFtJh6I7OyiUYqd6s
 6HXRQZ023VvVh8a80okl8olbmFw3Pe+uSRDliryTrhAly5zblt2qARARGh2ZCDL18KnP
 lTRy0a2HRnoe6jfieoohyqDPJVCPWlm7OJKo1y2ovKbz8JGKfVxO9Rb0xYbGBABAJe8l
 H7kbxuVdX3l8P4aOgcBEOybuA8i0EhHAe8sK/8k3st7HD7cxrlO+VEZQ83WoRsQGhJKZ
 roig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790752528; x=1791357328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=91UgRJj2a9cqCekJgIMfhdUvCOQ/1gwR4pNIdWvIxRc=;
 b=n0U52ctWAfdJFwCzrhqh9/LOFBmZrLZ2cMrx48LL/vNyUV63JY0H5q1hbwJX9F9m3s
 bVHS+JZ6/CVx/ZfrQVpwAdZr8MvfgWSm1wTY5JBBaIXUORk3IZpyx74hiEI3nsdOwJ2X
 NMGGzHJeo6/kWmLqVrxLLSP0hu8uPW4UvrESLTJbLk+rjhIt+9mStyKdLxoxpn5yWFHB
 U0EyadQ3bDunfjD4mCDDAF/q0Yhvoml1vM36hx9qLohNVWEUYh8WZaxGaWP8BJAnPenq
 CV5rrL7kF1EGmhUTF+5bYhLiYvRhSNcFaluPUIEFOLn/Wr+lj2jxkWvcfRMJ4KKPeotR
 M3/w==
X-Forwarded-Encrypted: i=1;
 AKwUvBw4le5OS8ME55sl/+3D9vfRP1Xu3N54sfD9X4pR/lWEdr79ec/twnxfnRgLKKnkZ+P5KP9xbmlR6sY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++n3xguEdeE09v3aItff8DP9vyaZt1/naojHAFUIG5qSpLvJIMNI
 H9ucuUqpiJicWmqFjSZpl8a+G6Lg9ymPVO+zWQeOnsdu8m5tH13YhuMK
X-Gm-Gg: AYBFou0xBxs9iBY9OynCPYoFrE7LOid2pFKH0/u4Tte2uJyIRJzYeyKLIn/2uOo/YG2
 O4ew8k30qJR+sjD4ok5mF7xMhx9Yb3OC0JW2kfSbpDNmeNk7eXUxRBbwkgEJkChbglk0dl00RVn
 3ijZVRjQQeAbkwcpaaQVjKK9uxt/F/KIduH+1LKipbi6EeqEwQzlUdYjKnZZClw07cMDkFulDTz
 gd7yiXsMs42YduxnTx+yMk+EdCgrjP5X2ztrNkl47KAP9Uoet1PUlNXMPKtpPKlsFtc96WjhB9S
 mmGAwMFtXhvjMYihout1QxHy3pEgbgiCXsI+P4dXbtpqDFK8p0ksPCG4NVKnPYevA+Bt29Hacze
 alj9T+W+ExPutzhcojVyt9lcSEM1ZwdrowRxE0ZmwVTfs8LIo1LUT0zjN2vKEqgvNDFyTM8nrgj
 HHdxR1SVUj4zrJeNexzky8J18vOAD9Z6XC7mzGNNxXCfIctD5fvav7p2ZtCPlRtJ0yeVRXpufst
 UD7s+LPkln8P+Pun38=
X-Received: by 2002:a05:600c:3b1a:b0:49f:c451:b4ab with SMTP id
 5b1f17b1804b1-4a01b12b310mr5780705e9.29.1790752528575; 
 Wed, 30 Sep 2026 00:15:28 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029be7e4sm1256979f8f.12.2026.09.30.00.15.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:15:28 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v1 3/3] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
Date: Wed, 30 Sep 2026 10:15:13 +0300
Message-ID: <20260930071513.54697-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930071513.54697-1-clamor95@gmail.com>
References: <20260930071513.54697-1-clamor95@gmail.com>
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

The AAT2870 supports a dedicated main power supply input alongside parent
power supply for its internal regulators.

Add support for retrieving and managing these supply regulators
(vin-supply and in-ldo-supply) using the regulator framework to ensure
proper power supply dependencies and power-up sequencing.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/aat2870-core.c            | 5 +++++
 drivers/regulator/aat2870-regulator.c | 1 +
 2 files changed, 6 insertions(+)

diff --git a/drivers/mfd/aat2870-core.c b/drivers/mfd/aat2870-core.c
index 8f6d7956e79b2..a9a11be373916 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -17,6 +17,7 @@
 #include <linux/mfd/core.h>
 #include <linux/mfd/aat2870.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
 
 struct aat2870_register {
@@ -309,6 +310,10 @@ static int aat2870_i2c_probe(struct i2c_client *client)
 
 	aat2870->reg_cache = aat2870_regs;
 
+	ret = devm_regulator_get_enable(&client->dev, "vin");
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to enable regulator\n");
+
 	aat2870->en_pin = devm_gpiod_get_optional(&client->dev, "enable",
 						  GPIOD_OUT_HIGH);
 	if (IS_ERR(aat2870->en_pin))
diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index 4d399d0486d19..4cbcb277ff20d 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -114,6 +114,7 @@ static const unsigned int aat2870_ldo_voltages[] = {
 	{						\
 		.desc = {				\
 			.name = #ids,			\
+			.supply_name = "in-ldo",	\
 			.id = AAT2870_ID_##ids,		\
 			.n_voltages = ARRAY_SIZE(aat2870_ldo_voltages),	\
 			.volt_table = aat2870_ldo_voltages, \
-- 
2.53.0

