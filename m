Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57283CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:41:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 199C710EA9C;
	Sun,  4 Oct 2026 16:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bYNrJsqJ";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C0EF510E11A
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:41:45 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49ffe281cb1so7154235e9.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:41:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791132104; x=1791736904; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8OmglYMJlZ0PFFt90eMP4sh4crhV9rDL4/VEmoOSLe8=;
 b=bYNrJsqJTD+A9UIuJEjC1KmEBKmAIevSi8pILhIFUuz9boK7w+wZxSSq1fscucGv35
 tjSlNnuKACrJAMQmkYY5XMwUMmIzMPWJzg+Sl6zCvZWYk0rxBFfeABEoRN5/zApzteu1
 3fDThh2pOf6eg/qHYswENLJ24v5yczcuEBpvnRSVMIUabmBnhJHknWul27pXelP2L854
 HEJo3UGkLE8eEGdpwOM5GYqZsUZDY2+SFheIr+STtQVtk4bcn5ffuDYuAuxiqiP4F8qP
 SHPAgLtF+AETuJj1ANjU9PNd5nhVO3YwqavGT+mxoh0tfp3r3H0TpccvPWN/M0KEJg2w
 EnSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132104; x=1791736904;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8OmglYMJlZ0PFFt90eMP4sh4crhV9rDL4/VEmoOSLe8=;
 b=RhPiibPKZQTVqMzxqlgoNJjBwfyKb4Eufo0tRqi+gVPXxOHv67fM4+Nra+u/hpox/Q
 4ZMyH27L9ELjX5ISyubw/aI9i6+JTsKYS6FvFpTubXUcG77gSPWT3pSQ1vbu04WLtGEO
 mXIJ0nE9FioPZpESQ1GFqOpr9bAkRyOJSOhJlwzIQOY8FuszA/QGYWPjNdmpNg5i5QiL
 AZ6WfolGGq09D2ordsnGJG7NFOpVfRmOedcubsRdSpLL5Ee2GPsCo+/ME/siNsi6Ydg6
 wFhwps9DCwIX5VqTJWQqI8SjQUOVLaRhrzAOWobQf5ULSiQZxI/bRYtcPgR1d8X2m+V9
 ZDEQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxP5XsYLkY0Mr2T+0d9UohVK4Tma/N/sIfhY1RfA2c8NzfbE3f9+vKAWwrcpyu1XaqCaoy/IMV037U=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lJeh9NMLOkhdmMrnJS27jU6TGk6vgxd7VZqH+3D97N7HiRDl3y
 7cxo2pVpcvN3jFroJjnlzs24XtANwuwl+i1/Nn0+UMSW5EVXQe0Flhu+
X-Gm-Gg: AYBFou2P2yZa4Q2YCQLMZcGx5R+q6rU8zO6WM6CjF4Jddz+TUHsZvs2IokC4JN47sOR
 9Fw+KXPjeNSeMi3cEFWAIp0P2EyfnwPo/nJbZ5LKByu6GBJQRZZ8sZRHKWDkq0dwFnN+Px2Ml8g
 ILO8BompT93NpcEBEahm3Aup05nOCIA9f6TlyphmkIyDXCdqNuoT+TjYB1aj/jHOVW2WgnCte0C
 ATEbuSzHoQ3jOpu5ARbPpKWjmQkeWAYYF0c5OdVjNHvilp8mzZ8emSjiI4qNhnO3/n8E3sXyxvO
 5GZHq00ayjKx8yEQ0tEZZJNAr8pH9NI9ImKio0COGAS+nynxTwar3jHJPcegyTj5QaNWW7JKWik
 hI9TVWW+MmbmTUk1QTt8W4vUGt9gdDTp31VTuPNuQwwY4XzPeGxF2s7sD97EsXq7bfnhslb0lNc
 vfrhl3GIbfqspKE4p5KNWNS8Aq4junoshWMmKGo37NLk2njOkzsX8FGl3eNL/u9Vc+p92hotN/0
 smJixTguw6kRduCen4=
X-Received: by 2002:a05:600c:6995:b0:4a0:1e53:e51f with SMTP id
 5b1f17b1804b1-4a02758572amr146705745e9.14.1791132104073; 
 Sun, 04 Oct 2026 09:41:44 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f07cdsm18765185f8f.10.2026.10.04.09.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:41:43 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 3/3] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
Date: Sun,  4 Oct 2026 19:41:21 +0300
Message-ID: <20261004164121.193514-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004164121.193514-1-clamor95@gmail.com>
References: <20261004164121.193514-1-clamor95@gmail.com>
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
index 909c14ee60323..0bd430b90bc1b 100644
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
index 8a58eb27f3f5f..a921e40ca47dd 100644
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

