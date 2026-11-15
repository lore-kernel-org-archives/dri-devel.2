Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569A6606A337
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 08:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OxwBSr13
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8B55710E1BA;
	Sun, 15 Nov 2026 08:59:02 +0000 (UTC)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E09210E1BA
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 08:58:46 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c4cdc606b47so441721466b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 00:58:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794733125; x=1795337925; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yu1iUE5tUZZVSrKcPtur6Bk4ggWxQJ9hvoe00qeVCog=;
 b=OxwBSr134wQEfW2emvGUyuPGQ/KAFh8kUbCuQU/WFfqVR1B4as7GGEFLW2LzUhclgY
 33lPImj+q0GQQazCNyCe94SH14kjdoBaliNHNDJdPpIgg+FMLLsWC5CjzaPWC6wvmn9C
 p1g/s8SwqjTgWeYqqPsZcW8CDVHREXF6mgswOLP3HjVqjWfrJQIbKSGfwvkMnyP4VCKC
 RLW/4rduClgFVT947wI2lmTJsOitRV3trzwQ5kjFxMPMcmaK70BQFt1yGAsFaMUKeYlS
 hW+rs0aJuPSvRUA70gZ/qvee5fbKfgxzmLvZYOKHEa4TgiCavQ4Pl+gak97oquEsw+2m
 fg7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794733125; x=1795337925;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yu1iUE5tUZZVSrKcPtur6Bk4ggWxQJ9hvoe00qeVCog=;
 b=1MqlK+/X9RruS8P5H29cbasKvMqu6BRI32XhbWxpcxapEC0vY9saSPDUd0bFDCfOl4
 krg9Brxqfx+nTIkbCMgXntp397QEipVTM4S1ybPXcwpQVQEYEK4AgrX1VS2y/CTcpQHj
 /sW4SjvMWd7NDu7fHpqgipjG642dSRruXb6MLei6qln5XXDjsBkqUO1m1oG/7f5xbQQf
 KiG1yJR650UbNxTj1M+PoYthxsinxTJcWAY+F2PuiGio68C1JZM3pxa1M1d/YCgOdkDA
 /3Dr/FRVLNq3xvy4N4m4LmB389KWBZnyv4o7i8oizegHBRHD60mmiAnrDGcgimMTuuiY
 8AWQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHNaRhIg60rTCppUmgeDh7mjciDzb2Qs7FkVYK1IasEMl8oMTPUyqyM6IROnAqA2ff+TR+AEHU8gQ0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/jNpkdauUbMZJWzMMzT46apXryP0n6jlG1/q8wj8MDjyHRkqC8
 kEjyj5uZIAuFIUF4UXNVIAiZDNJ+QQOl+bRCsnqOPeYJSWvAx8072uUD
X-Gm-Gg: AYBFou3R0sxecFFL/pCTuPRArxmOmd306/LDiuJhjyNWGwihZ14GYFVHqkW+7QrFea4
 yWuvt50NfZp9gnXmJayYcM6CIQ3NR2PKW2z2iW9StNiHZRDAFF+zhRomICyYB2n1mF+28bUgYRu
 m47pRRluo+k+E46gkwMG4fAJxQYPBESuKMudDIeS7bEoF5DITZj3y0YuesC6V1nbtVY6aI1UEcS
 51O9KUh5F7dAw4a//f2n8kE2dG8sIpkgF3ZC/KUTTVNHiX7QAYHrH0GkjprtXtTsJy0clRpHgbk
 xiM4Z808E7g0HHWutJ7k+qKPaPkOtk6I5pZe84aoGlcoHunQM/rJee2D0E0qBDQ9g96xYSRvkXQ
 wFRVd/m7OUShJ/A49t0duzgxN4DWvtQBGJrXZ1D2ORBIqX/kN6PRSQeiUX0NdDCEj9eF8U9FSpD
 YXZgCWSLMMwBfHnGdc0qKxye9zMMAhXBJmwLkC3UgKM+RDXVcWsAESJORTmicFRGucwJJxZ9mnt
 pNoMY9KH2Y0Y1Nxwyk7CvWxv0Z2sh9Z3iDM1hEBPr8zow4w+qNLjDxB6MfZ2KplQXwlOX7K1wT9
 GwaBoqWKAZ1kKemcoMJHOnI2MsMqRLLXEW2iZzRHufk5mbEDqAskVR7yeCnQC/i7dlk7n27ByR1
 XENHRGVn+aQ==
X-Received: by 2002:a17:907:5cb:b0:c50:95b7:d189 with SMTP id
 a640c23a62f3a-c5095dd72f4mr610171066b.0.1794733124625; 
 Sun, 15 Nov 2026 00:58:44 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095a5c4b7sm287613266b.1.2026.11.15.00.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 00:58:43 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Griffin Kroah-Hartman <griffin@kroah.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v7 4/4] mfd: aat2870: Add support for VIN and IN-LDO power
 supplies
Date: Sun, 15 Nov 2026 10:58:25 +0200
Message-ID: <20261115085826.89641-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115085826.89641-1-clamor95@gmail.com>
References: <20261115085826.89641-1-clamor95@gmail.com>
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
index f5409dd91efb3..9017960ee73b1 100644
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
@@ -307,6 +308,10 @@ static int aat2870_i2c_probe(struct i2c_client *client)
 
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

