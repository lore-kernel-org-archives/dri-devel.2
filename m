Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C395A606A31E
	for <dri-devel@archiver.kernel.org>; Sun, 15 Nov 2026 08:58:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H/lxBbBX
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FA1A10E2B2;
	Sun, 15 Nov 2026 08:58:45 +0000 (UTC)
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A52F10E02F
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 08:58:38 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-c4d427836e9so329270666b.1
 for <dri-devel@lists.freedesktop.org>; Sun, 15 Nov 2026 00:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794733117; x=1795337917; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BfQ1qFkKsmGaWDuAf4U5BrZ/SIHnw5d+W2dmVSm0AgU=;
 b=H/lxBbBXrqld008/qXo4MBdF/IHRQFG1dr6dxriWckXpgC3Pgr5Ch4C+JjsHcR9dPJ
 tDqe3uYHjlFljChEeUBXlIuuCfvmuMogihBon0et1nnDeVkZc7V1/NQOa83oIfsqibgH
 3eGhxoe574Z3YMyDpHRN4OZZRSy6h66rRlcBL8VBTAjjOjy7akAOAnLFd/FRY3rLMB1K
 WGLjkT1hpXwqo6/0TmjgI6LP7nRkbQeViSTJlzy2WMGDEFo89Y650LVOkUaorpFVRJuo
 C+WUqLk+QsOwqi9QewUPkOQIJljH7e54ErEii1XttObbSRYPz+rLEJTmo3V2+JmMPUgY
 AdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794733117; x=1795337917;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BfQ1qFkKsmGaWDuAf4U5BrZ/SIHnw5d+W2dmVSm0AgU=;
 b=1+WopcpxGo4nd/msK8QGywVVjQLmWj6wSKwesVNxcfR4fuASv4rIpcZPx1bcjjLVVp
 EAOPXHb4wj0MelxlOjIARGpP02xhdWXwgPGxFWAc8VIUHtQtPned9eE9AhjAEMeBOJ9v
 v/gq/HBCF1IP9ZfEZoopm/wzgh3fsNUMmhIQHbeUA3rNM7QUeeHXRQjRNOhvmIfqX5cU
 IiUWD7G3w6EpRWZWPf9cabF/Zx0bF8l/XdQz+XhibOrvDpvKOUmNRi067OhAVRMIn0hu
 RSmivz9KFy0PR0k115Y/EguPeGaFTQjx1TkFsZMo3W46AuVZAfPu5+ML9cdMgbTkmq5x
 Td5w==
X-Forwarded-Encrypted: i=1;
 AL+hErEvvrAmZGKCjKOLrD7pBpVhGdHkkrpeYK2A/99aI59taX8+xVUxPcY1Gdv9uibpS+inMS5lTQwhCKk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/2RYMgsN6eo21u6BTnv+pCUvbh1A6ipBBw2kDLf4AuqC2pIPiU
 EF4PSYVXgyQroZYiseXLXRXGxK2lwudq3t8+zqLPqCR0JzP4lt8jnuAc
X-Gm-Gg: AYBFou1DPzaMqaKQG/kMS3RpYr+vh/9vHBXRPeBw2tcGbMET2oUwWvy7FcdszguCOru
 QqAhq+vlv2S5E8FblwEVVIXAsId1jwJVGz9InMN+QSRFmO2zqM1xkk+uwLrQDeSA9FQBaci3Ezz
 2RHpZJc3QKEQW/g4GqtAHOypCD2xkwNyo77eWVVXKiyUWBIFEhU/oITCEEbEXnu/Ew0t3a5AZ5Q
 t3avk2S1D/KOLa9EIttqIP7cnXhwja6jmA4+rAXqA3lf7yPtOD5isIeTMD6vfg6QOWrDw3L/BHu
 o4g6hhmUk0CJ8cguVRTb3QP3lKbxmOjOpTm4fmncwh+NYhlzxZvH1fW2b/Pefm4zTA1mK0swdO8
 upFsA2M6yKKCz+0liKF2OT7+Pin7CS9dOBzjjOvrYV51uMi2HJzWSBwzErejgqNfBRmLf64oR/M
 4gIyADsiZF0YEpIyMmVkFqFek2PqlV+4q0Y9uQchD5oU1H6tRH6gmVhzZ0W+RE5VR3JK/HOPYjO
 o43e0FA18yRvRKuZMUAKO2ICe5/BNRl0OPXM3AUDgnkDLsoljol4qh8xp7TcN7QH/QJvPEude0P
 SB9/lumfMCGocZ6vWn3XCFMQ4isd2SKKVhsN6UB2uRQHayDKBxUFURAUn/YXv7UMSYZsmRYGxvu
 3VhFPxtOdHg==
X-Received: by 2002:a17:907:3ccc:b0:c49:a235:8e0c with SMTP id
 a640c23a62f3a-c509637e31dmr585009166b.22.1794733116617; 
 Sun, 15 Nov 2026 00:58:36 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095a5c4b7sm287613266b.1.2026.11.15.00.58.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 00:58:35 -0800 (PST)
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
Subject: [PATCH v7 0/4] mfd: aat2870: Convert to use OF bindings
Date: Sun, 15 Nov 2026 10:58:21 +0200
Message-ID: <20261115085826.89641-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Document Skyworks AAT2870 into schema, convert existing driver to
use OF bindings and remove platform data, add support for
in-supplies.

---
Changes in v2:
- fixed led-max-microamp scaling
- fixed max_brightness parsing
- fixed regulator init_data and of_node passing
- of_platform_populate > devm_of_platform_populate

Changes in v3:
- removed max-brightness property
- switched from dedicated max_brightness property to dynamically
  calculating brightness steps
- update regulator registration to use mostly core regulator framework

Changes in v4:
- set max_brightness form aat2870_bl->max_current instead pdata->max_current
- switch gpiod_set_value() > gpiod_set_value_cansleep()
- constify aat2870_regulators
- max_current in bl switched from int to u32

Changes in v5:
- drop max_current from aat2870_bl_driver_data entirely
- remove legacy gpio and mfd core headers
- headers in aat2870 sorted alphabetically

Changes in v6:
- led current set to default matching driver behavior
- max_current initialized with same default value as pre conversion

Changes in v7:
- rebased to be applicable on top of devm_kzalloc_obj conversion
---

Svyatoslav Ryhel (4):
  dt-bindings: leds: Document Skyworks AAT2870
  backlight: aat2870: Derive brightness steps from max current
  mfd: aat2870: Convert to use OF bindings
  mfd: aat2870: Add support for VIN and IN-LDO power supplies

 .../bindings/leds/skyworks,aat2870.yaml       | 124 ++++++++++++++
 drivers/mfd/aat2870-core.c                    | 133 ++++-----------
 drivers/regulator/aat2870-regulator.c         | 160 ++++++++----------
 drivers/video/backlight/aat2870_bl.c          |  78 ++++-----
 include/linux/mfd/aat2870.h                   |  95 +----------
 5 files changed, 264 insertions(+), 326 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml

-- 
2.53.0

