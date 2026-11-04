Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BBA606A328
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XwhaCqVo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23FA410FBA8;
	Wed,  4 Nov 2026 12:37:47 +0000 (UTC)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1864410FBAC
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:37:41 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so1114433f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 04:37:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793795859; x=1794400659; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IlABjifCqSqzPKHch40gU1r/EoFeoTHIM67lGBUV2nM=;
 b=XwhaCqVo5FYymdx9VSCBE9Hcg/6Es8esEFyVYRblbc5k9CzMEzq2VThcUNniFkPTnR
 kiORu51rUc/rCdCskR/yDzH4J+0HRwFWynnaW5BhN/RJ8yPvoShVY4Ib9B3H0ApHkkQs
 q2GsfPueym1AQJ0qxW7I47CwrUBf/E+V5fTHqW+dT23Sc2doIprSqShOYY/U58YExDec
 vo3nLCnGtKHLhvQIi1ZXwvmPMUKmd5ziwWGNFJc/iS6dnOr5aSWZqHWjpif//deQioMW
 z8cJqasekMr2UhskuiJIy8a4d+owTOhlNZ5sKi3jKOCKUADKeh9o9ePLtHB/7KhCBNjO
 3FGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795859; x=1794400659;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IlABjifCqSqzPKHch40gU1r/EoFeoTHIM67lGBUV2nM=;
 b=E2/6lWbCudVe+8UfPMunGXawKq3Rm/WyuvKl26nXCpeCKYuiYJ/36jNkDIEQmErrHW
 LVpvi8bnL+CA/tB37LNTaFnsGjzAI1uMBIgLmFTpPvVj6FdHeQvnSwoyeNK2ZbMJbC49
 5eMDUf78vuYDyH1zxZkYuWZ/bMrzLVVCh8gmjPwfZz+29IOWaHnf9l38M1AEz+ZL8GIG
 nJDxFOSqttJ9teuJyCmR2FdHYaXCKzObEPmMRnCUzzFLh5Q8Nv714y7mVMQtN+NWgbP0
 TaivvikKy6zg1fKHBg2SuBU4L7DwNw5TkyEEqYHg+K6cxaQRR20nNe15LJGNKXcrndtE
 hkAA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwB/KBQ5/+TQb6bzxrmu3nbAKSc6tbFdGRAk/Ia7dcqxDw19JaY5b+iFgHtuqyChCkRBPs6jGvGPDM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8Rgs6M5NQwz6QJSVdv6h8Qt+1raqdrpzzvJ8OrWgZboIlUTgbf
 k8aLVKgh5GVmvKrTcO3ETLzSvrkkhVwIVoitlC39dGRqbA+O92xZPzvU
X-Gm-Gg: AYBFou12SqsswkVbARQUjB8YegjGurx2QZGSD8IHQf9M8I5M+z+R0y6y3654YrCrEnJ
 fmYLWEKdIeRK80QIFjor8ZlwWNR5Ntu/LsoyDA1MOvJlEnHQoHhw7VodpszFS/UQDvL8W4c/dtQ
 qiQYuVQ9AtxJYMmR17DnVayjnd8UG95e2Tn6fGlC0++XL4R0z9es/YjrX4GS4HSCxuY0qrYnOEk
 vtevPeYerqn0Ei7ueWtAnAchRecTsK1nqQ9mKu2EyllBqCD+ZXwQ/YfiPtm7uYL5yaW0X3Bm2EH
 hhsC8uWo7vc+a+3bCmRCwxGp9Hf01JOJNqbrQDI176XQ8CM67EeND72NpKb0cPtQV63t83Pg4TK
 k2T9OaiHHgARtaTg9uy4C4i8Lrhq+w3ajkdorVLGwK3E/qjRtwmDmjFcq+ZPLRKkI2cAdHpePun
 k9In5ZEQcS0IvU3MqYX+XG8oUxSwIyAzQZNUZPSrV70W7ovM4Z+vWYgDdi/sviHd/hj/TJytSQH
 IiuHwN/W8WdZfkJZcAHPqBmVpnyhKKAgJL534QKIC4k9g1/zRyikj01QG/NMLkOy+e/sOd8R7yD
 RxJCCj7BoF60L2qbqBWFyxI6jeKw72qbEqzqmyZi/I5h2E6LBw==
X-Received: by 2002:a05:6000:1843:b0:48f:c595:d51 with SMTP id
 ffacd0b85a97d-48fc5950db8mr5312034f8f.14.1793795859436; 
 Wed, 04 Nov 2026 04:37:39 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed553441sm3386155f8f.43.2026.11.04.04.37.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:37:35 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 4/4] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
Date: Wed,  4 Nov 2026 14:37:14 +0200
Message-ID: <20261104123714.234634-5-clamor95@gmail.com>
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
index 6b1040c65373f..657ccbb9a9dc5 100644
--- a/drivers/mfd/aat2870-core.c
+++ b/drivers/mfd/aat2870-core.c
@@ -14,6 +14,7 @@
 #include <linux/kernel.h>
 #include <linux/mfd/aat2870.h>
 #include <linux/of_platform.h>
+#include <linux/regulator/consumer.h>
 #include <linux/regulator/machine.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -308,6 +309,10 @@ static int aat2870_i2c_probe(struct i2c_client *client)
 
 	aat2870->reg_cache = aat2870_regs;
 
+	ret = devm_regulator_get_enable(&client->dev, "vin");
+	if (ret)
+		return dev_err_probe(&client->dev, ret, "Failed to enable regulator\n");
+
 	aat2870->en_pin = devm_gpiod_get_optional(&client->dev, "enable",
 						  GPIOD_OUT_HIGH);
 	if (IS_ERR(aat2870->en_pin))
diff --git a/drivers/regulator/aat2870-regulator.c b/drivers/regulator/aat2870-regulator.c
index 73b6d06858cff..896f39e345379 100644
--- a/drivers/regulator/aat2870-regulator.c
+++ b/drivers/regulator/aat2870-regulator.c
@@ -105,6 +105,7 @@ static const unsigned int aat2870_ldo_voltages[] = {
 #define AAT2870_LDO(ids, match, vsel, vmask) {		\
 	.name = #ids,					\
 	.of_match = (match),				\
+	.supply_name = "in-ldo",			\
 	.id = AAT2870_ID_##ids,				\
 	.n_voltages = ARRAY_SIZE(aat2870_ldo_voltages),	\
 	.volt_table = aat2870_ldo_voltages,		\
-- 
2.53.0

