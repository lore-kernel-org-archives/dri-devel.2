Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33208C531CB
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:06:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 805D010F061;
	Thu, 23 Jul 2026 10:06:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hjCf5psD";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B7CF910F061
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 10:06:17 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-49554ebb87dso5135255e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 03:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784801176; x=1785405976; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BcGqlv2rED4NMS/3uzjzLmpezgSMOIuZyea8FmG7iIE=;
 b=hjCf5psD/Vzu+OKZVqlIv8op7DXVle1z5LnGTHlm722U8KpyrUa/tWNwyfIIwWwrDq
 7KM+oHbu+sFEFLlXThEI2FOF7vyh4xXiIh4siih+ryBmV3V40Ab7LfiMRDjZGkqfUQ7A
 IVlCKVdeqIoymNZlAmcEyawl4E4CJIyV9xVj3O9CuOxCwY3qErNLhxwAb3iZMhANevyl
 xEtRY818iVcgUWZie/DYpgwb1NElw2rOJw2qy+z0ZW9QbEL7Ln1a9xzm679zYhi4Hey8
 O4dMyx0bYs2iZOeLefI+19Gj/q/Oo4ZwhSlWZkl8H//J0jHVN7sXGsUH7iG+uwj2otwZ
 gNZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784801176; x=1785405976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BcGqlv2rED4NMS/3uzjzLmpezgSMOIuZyea8FmG7iIE=;
 b=B+N7kh1nY6NlWzRFzKce9CkCziebI8m3qf0ZcgmA5h9aR9w/BxNhRcAAmLDmO9zff9
 0I327kcIRxTxMEGQjPislOjuclBClKNecu0hRX/KuloHqW/sPdcV8gT+Ozd65BAouGD+
 d2gYcxFti7td5YLiMk7QhGgZ2n8Z1d7Ut6eQpGEXNhfV8qm7i7yfyohnESjhqOh7p+K+
 t6Ck3Y4D/E2eyGoStZLbfCo6v3m4pdddId5qX5HFzwDhrU2SALqNCGhBIKVOlHZ49LcC
 fN4FpxzAEZ9WCxGLRSGBPz/bcZrycBMxTXARkBbOuiPmbczl31P+3Td9AVbW+JZgol6M
 99iw==
X-Forwarded-Encrypted: i=1;
 AHgh+RozjM0LLfIn8MFMG+UXOcNzTPtByrB6yPZAnrJadE7zk211ggjjMeThvzjR9PAAPRM6ovmpBHp0gM8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2DsuPQcdoH7IlayslbQEC2krpmToP42CWeWPYSW/xZreCRCDJ
 qEKYwDmTvwqsasfe7KNA8MG4vNuqCIbZog1Oyg78KBWQxhNzCKxeWlMs
X-Gm-Gg: AR+sD13pXgbiH4CBrwJXL7FOvRqJcZUMgFYRoy9EhJsWu2unPGfY/8Yhdqw7t/+ZNet
 aSEENxd4jbupA4ralnXaLnZXHEw6bfKriAslAXktTF7ct/HaI8Yz03Pm+i8JUV+lS+7b3dxnS1j
 m+RDDMwC14Ir24Dqot2zvkpCNmbfM9j3aMLgb1CulWLxasrDEirIVJHEZf9rDDKOgzL9jVGdyAV
 AyGJ7awOBY0gtZOhR9VNsvOvmX4j/jj+BKaFkB/GoLEg46I5c2Zw4rSNqH5B8SB0qk7+t4lWmD4
 /VjvZ+EKMaJXcGEKrVsAK+YY11MJmDMm0OXawrMpIB7X266dp4yATyKV7P6PytS05o0eLlrGHsN
 BXob9opSqy0IvZvd12gg6CiQwYzUgaBLcVfWZstwJFVu7VpxUiYG6tP9jZhO3tucoGep3LbcW3Q
 haQPCn6wUeFsOA+VrmV8IJjC/Y3iFOiFznrcyQGy49G4yj
X-Received: by 2002:a05:600c:1914:b0:495:4d00:2fc0 with SMTP id
 5b1f17b1804b1-49573ccb598mr27399575e9.12.1784801175908; 
 Thu, 23 Jul 2026 03:06:15 -0700 (PDT)
Received: from localhost.localdomain ([86.126.27.145])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a60asm14212163f8f.3.2026.07.23.03.06.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 03:06:15 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 linux-omap@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH v4 0/4] dt-bindings: Convert TI TPS65217 to DT schema
Date: Thu, 23 Jul 2026 10:05:58 +0000
Message-ID: <20260723100605.628882-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
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

This series converts the Texas Instruments TPS65217 PMIC bindings to DT
schema.

Changes in v4:
- Removed the regulator/tps65217.txt binding. It documented the same
  'ti,tps65217' compatible and is now fully covered by the new schema.

Link to v3:
https://lore.kernel.org/all/20260721112133.70382-1-egbostina@gmail.com/

The binding covers the whole PMIC, so leds/backlight/ may not be the best
location. I can move it to mfd/ or regulator/ if preferred.

Eduard Bostina (4):
  ARM: dts: ti: am335x-guardian: Drop unused isink-en property
  ARM: dts: Rename the TPS65217 regulator nodes
  dt-bindings: input: Convert TI TPS65217 power button to DT schema
  dt-bindings: leds: backlight: Convert TPS65217 to DT schema

 .../bindings/input/ti,tps65217-pwrbutton.yaml |  42 +++++
 .../bindings/input/tps65218-pwrbutton.txt     |  30 ----
 .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ---
 .../bindings/regulator/tps65217.txt           |  78 --------
 .../boot/dts/ti/omap/am335x-bone-common.dtsi  |  14 +-
 .../arm/boot/dts/ti/omap/am335x-chilisom.dtsi |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts |  17 +-
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     |  14 +-
 .../dts/ti/omap/am335x-osd335x-common.dtsi    |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-shc.dts      |  31 +---
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts     |  14 +-
 arch/arm/boot/dts/tps65217.dtsi               |  31 +---
 14 files changed, 275 insertions(+), 235 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps65217.txt

-- 
2.43.0

