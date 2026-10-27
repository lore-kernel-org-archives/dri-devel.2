Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7355760A261D
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EQxXLkvt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E178A10F3F0;
	Tue, 27 Oct 2026 11:33:09 +0000 (UTC)
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2EC410F3F0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:33:00 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-c445c95d553so525793266b.1
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793100779; x=1793705579; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IlABjifCqSqzPKHch40gU1r/EoFeoTHIM67lGBUV2nM=;
 b=EQxXLkvtjEBq8tzlsqeuJWEkaEpEc8vIZZPUTJyw1ntcbUrzEKLTHRrUC3YsCXyOx9
 igUHxvociOxlhus4lPPBmuJZJpKhD8O5kG3ZPgw9ilz2tlf34vOaHluOQDuS10xWdbdU
 ML0Bnmhq69Q6tXMznjB9gREGgJZW9jc7gY5X18smgfRZwgg/w2NL9R2ltebNIPupCu9Y
 9jTSUZ1bLgr9XJpwHwUflGx44TiMKbj8y9/OGgqcoekeXQtYw3NLsndGqhSj02eJNAzv
 AddYAprtz9pbSBYavsaC6r4xp6stTnYdntH0xqOLINOlmY0Mu8QvZp6q/v2U4wBOy7Ov
 0Mbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100779; x=1793705579;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IlABjifCqSqzPKHch40gU1r/EoFeoTHIM67lGBUV2nM=;
 b=wFneej3hHjot/qAdwUe4+15I/UdbFBZfy3/CIdB6O3hxZvJIqAIu4/2slE+6TSb9BC
 bNQJdC1So4etH+cp4gI9tLL5g4HrIH9wWKEzjS8MwhbgLIXmWUwAqB9OjfLDVQEaryj0
 5ZsuSf4uBI0TuHe7maUClm8enRIhr84i5il1mwLLRm+mcR4S9JR3CQ2Odr6mEktjTqTz
 dn5apLMgdmDqo72+aORA6yY2Yt2d4MfKj4lLr8gscMaQv8DI/jRmliN88bHslltzXgji
 QWUG7bxNnyqDhyuxPUJRIfhHvbWnyh4PynWGx9avYdeYGjyruTsqqoUmydz91jjXLxYp
 FTcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzRMGPO9SMxixaV29EScUHxYF/bSFlxbOxc1JQ9Kbs4L7GFGunFyKruAQKleLapN9BJmxsZTTy9+tA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIYQ4lHaxz6+nDe2q7HyNNsQrPCcvUSdaEtY72J8zUKYmPsUvwD
 s6eSpaAUdLAAm8xZgbg1h0uKYTpK5Cs8TjtIhSJVn9nilv8RU04fyzOlU37UNQ==
X-Gm-Gg: AYBFou1vEJGWhvko6QS3/ZOxOYtm0BK6mp8EmDvrbAMOBMp/dQ3BNHoGFu89PmPB4IT
 dYXFsksWUiWq6YIAYe+mjcy+nqrplDndLBqM7URvlo6nttBf15h+k4Ay+kWWRJUhBwirNUgTzvL
 +yxCkBIwtjZ9pzQg2BgaXLJJd+wwL6bEWh6v/Na7o1lkJrUluj7Q/INU/usRU8VXSzVmOM5OEcG
 F6dnvDZ9W1dchznY6Q6+Lhlgt6qhYx3JiC58SR1+evx2pnkYlsF7Bp+WKAiWUtgrZVQo7xTxCkz
 NHocDMggUCX2V7aeso9K3MHwsUvjVbgeD3t3V/BrOA+QtFXSo39vaC1/LvSoSMH49ReU3do9/2k
 qLYpDsvBaCBjMdbBUjROcDeIx7Quzc8G8zFh/jmx/NEuoK9yXYIIg4s4TH691QTCN2a+hfUcYbR
 YjinaCSD+SUUnUzIET6uzK3LlN1U8qEfUy2iKhrsZjSdEZjhTl90RtdXuUuQ/uu/bWd4tJA8DQe
 CzJrLsU6mOBVGWatwaPRZ7VQxV/Hvvd4wmVYSXc7VrLaTZaneRYw+ZNqKcljBX+kjpFXa+Exi94
X-Received: by 2002:a17:907:6092:b0:c31:7495:e57 with SMTP id
 a640c23a62f3a-c46bde9a0eamr971176066b.44.1793100778881; 
 Tue, 27 Oct 2026 04:32:58 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea608sm428920566b.21.2026.10.27.04.32.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:32:58 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v5 4/4] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
Date: Tue, 27 Oct 2026 13:32:30 +0200
Message-ID: <20261027113230.47538-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261027113230.47538-1-clamor95@gmail.com>
References: <20261027113230.47538-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

