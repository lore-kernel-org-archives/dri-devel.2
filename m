Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEB92CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 21B6310E67E;
	Tue, 13 Oct 2026 18:10:05 +0000 (UTC)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5AAA410E67E
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:09:54 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-49ff680331aso1809335e9.3
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791914993; x=1792519793; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rIN9I4fxO+jG+4Tem3JpMlKcKCKDmfxcYWPCA9fO/20=;
 b=NbCq42ovDk7GWgrbNDEmmlHwSbksEm99Hvk2vXTE923mn0Z0ik2UNp1Ev85hHYyKDt
 MnTLCOA7Q3GI0QGK/zKYQnlTPv65uVhmuEkoouVL6XOdwHw26+Slw9ZL91cAq8Y/PHaj
 lO3A+aTFOfuO2csEFwwX3TfJ051bLVzah0V95soMAg7uwTt0kyhaJArozSrIG+mDrCSw
 UceynIx+sG24ltp+WlJB7vWmlnBYGehIwouG2qnt4RlGCBqjI2FR3quHp22SblUj3aGK
 SOLgi/8G2grHyVJYgeebB744BYEa+/PSRQ2izJPtOtG4Jw9t9hdPp+BqklUMa15i3Hwi
 D0aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791914993; x=1792519793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rIN9I4fxO+jG+4Tem3JpMlKcKCKDmfxcYWPCA9fO/20=;
 b=DJk1+lwAIF4I84CvFEB1LygXl1AD25HNZ6KrOQ3S1y2W+KBAv58sSm/owev8TwMqAh
 +YPM8JuADXYP0a6Xv5F3d5UjD6lqmxMl6321LToWSul7B9Nd7ZcQn1+fG6Al342vQCa9
 8f1HyNgkCkyqPT4ZA9l4/vCXrOP/KW6gg6flPEEoPc9Gnskmhp9RLzWL30SrI/LRcVP+
 2iqpRxl4tQTy6ujLg5CDEhbu0AeEp2O4uXkq9a8p/jv6wxXgtZYFIWPBs+tBM0Aqn9vO
 YsExopBz3ewLyCo0NY+4jIeRHMoxVH6SfdgFEug7xD/nahv3lVQoTe8xFU8rpdemTXUW
 99jg==
X-Forwarded-Encrypted: i=1;
 AKwUvBy64OEuCa5kMlqvPP5PS4xs1bhm3omoFRU93+PM4hdidFLIYkdkmMf8z1ZNYl4aMKvURE0TqP6AgFU=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJkuvOF7ouAb2fyxw/wl4zuDSiEwsuQRv0N+FZ1kQPNkxfJj8fE
 AMjejLla6BydAjuazrx3A5Yj77zopCusG8PWRamwAWVTAxZ+m1/8F/Ng
X-Gm-Gg: AYBFou3xElYU6Cqk+0vSh0lPu8Cdcu9/LtH+09R42FlbcxQXhBThOr0puUAQrQNXZZ+
 yVXqi9tEnsUs2JWQS4bDnvUllWbj3noL+TjwVs7j1S7wzGcbD42kgrvQb8PY48yKe1wj38TrvPz
 W+Qhj7G2sWIHYD2tCRgM2K2OOTzlJirNzT+qv+IuhjZ8u6YDwMwwbaqmx8OEd7HhDMCEpo0T2n5
 u0COFs1Ud5cPC03XiNWoDHuYRR/D/P2ZugE1cdm2mHAFppxzIJDvAvh7i0aK95EhHc6vyYPPtPG
 haA8oTyFj2+bs5JwnzCRMwbiAXxPYWB7yw39CSYpEecIgLrT5txKo996Qp3gG5l+ewdPeypQeh1
 PsdQSGaqQ64a4jePsOXXTIS2cNv4lQQ29VuH2bDt95Twq1G5ZXI+7/giAFBIF6kWBdK85LTANxy
 bs+HmZ5AHv5HyFs/M4PYDY8L2LD/UkFZoZcfS2Iis+n4t4ATtmufFTXCpNvr4EHwccEEHwbtVGW
 BxkPrcSvRbgoF7Wx+Q=
X-Received: by 2002:a05:600c:1549:b0:4a0:25c:8af2 with SMTP id
 5b1f17b1804b1-4a18e491051mr296577985e9.17.1791914992608; 
 Tue, 13 Oct 2026 11:09:52 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaaebsm6854498f8f.14.2026.10.13.11.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 11:09:52 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3 4/4] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
Date: Tue, 13 Oct 2026 21:09:33 +0300
Message-ID: <20261013180933.487013-5-clamor95@gmail.com>
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
index 9b8eb8df220a7..6f19b19f694fd 100644
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

