Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FEEBCCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:10:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A249810E989;
	Mon, 19 Oct 2026 10:10:02 +0000 (UTC)
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 771D310E97C
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:09:49 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-4a180fbeef5so14724035e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:09:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792404588; x=1793009388; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aOBCTDJ4Zly3dd28/nrymNa+BhMmBCq2pAK/siAAt/A=;
 b=iRY4ItY0cFThsIYdVZXoazgd7yXkFIwgR8pVTtHQiLTnUMAGuzPjEf8Hnh4sWTyz1t
 72+PZusBm3ZRcDLjCRCEpfrnqD8m9+zmjgPNZWjTb3nuY4iRb0Re1jOOtYvP8zQ0lPK6
 jEo/X8tXiiYIPAbyNBwGQDHNVChan2NPIwbg8ma6X/tt/ivIjfAOn5+HAa9QnO8fjw8r
 yaSKJVHYwHolJQtkCXvcaabGTTRros35R+nFSeA/K+LGpmhpUHu5l3tCemekDWu+8isG
 w81VwVseDiTP402Ihp8VbClpLk8PbXYcsXLFYIddxzZO9lxhMhi3YkDSKc0qR8wH/oxR
 H+Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792404588; x=1793009388;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=aOBCTDJ4Zly3dd28/nrymNa+BhMmBCq2pAK/siAAt/A=;
 b=XK/KDPFWlxyE8bK9S0KSK9N7zS6Kh8mxl9kjjZWAO8X4ONh/dkES7CYdjE6b+MdJW6
 1okTXoK9NcVWKdRHDeu/PlbwkaP3H5tnKrqlxjKGzLlni20+sU6+31pNTCc54ZsxiG7g
 ESNdLfjBnJluS+ohKnlmKUoBITg73DqQWUwS1M9li0LN14yqDc7oTMPCbx7//C46Ua9V
 fGPQxef2zh+boWZUIZJK+RX33LAOK478PxIwgRdV6E1vOmrxsbXpY2ShJpo6Q9XrJskh
 OsD99hAzoQ4kVMC4zgmyY3U+jxS2xUP6OBMyJppGqO7VuUsa3icMtUs2vhakaGeSWDfP
 Cb0g==
X-Forwarded-Encrypted: i=1;
 AKwUvBywF7ANioSu0KNnFvyRtI43P/7N+CR9fK3KbjaCWnBeK5OXCd55/vTL1JL4AEax8ZU2TH7TpdTRtq0=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLX642KKqwWc9nD9eeMy93FMlbPxp+0+hY1tH+qy6tLr2IehADO
 QGOaSlMGaE4+cHN6r/62A5lOiAgPc7oJ4X0ULKP2Lvq8DCJI49XC+QGS
X-Gm-Gg: AYBFou0vjScJxoc4cQ0FjH2qHagrFAPeVGZNIthLiidyvL4oripA8Fl0KDtoi5VFIEn
 I8MDUSiHyx/YdmGAJlyw0Nsh3L3dzmkZJJpYJzl+jQBOpj2juywWcOyIvKZ2Fw/Zb5zuBkelVaX
 jotsM4mKatNSZeyOG8a79PeTll5WMxxGxgbYbjg4rbbb7C5zX8DWPJCeD6deQNvksPnTZi+h1DX
 Grrof1R2E2fy2lkR1UJFr8sJhQCYjKIMzpIPlOTZeH5+1Y0uc5cZyRmr9Amgpkl+nuME3dviqnw
 Ezxqg8NbuM41jvaY0dNICRDIT1QVSR6E9znNS8kKErK3rqbGKDVdxttcMIhAXi5M1DOiA5drAco
 3NUTEXbLQVLsfzpcfhmfW/0T0Czj11Wn8SfREPbcxZipIYeZUKiewEN6WASlGpWz7l8/uzZwkYY
 KwxvLeByv9uiatdZ0uKPg8r7zM7t3XF9DSmNXui4tfFXYAeX5nvaVvApgrte3Dov6N6nTJavxZL
 Upi3UQumG9pE0zp6nTgwI/mUt1VXw==
X-Received: by 2002:a05:600c:3e0a:b0:4a1:ef9d:1b68 with SMTP id
 5b1f17b1804b1-4a1ef9d1bcemr8412035e9.10.1792404587670; 
 Mon, 19 Oct 2026 03:09:47 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm510533485e9.1.2026.10.19.03.09.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:09:46 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 4/4] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
Date: Mon, 19 Oct 2026 13:09:30 +0300
Message-ID: <20261019100930.110954-5-clamor95@gmail.com>
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
index fe43ef675f257..0284c5fa8fb54 100644
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

