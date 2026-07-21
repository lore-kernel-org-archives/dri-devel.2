Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 523D2C4452B
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 22:11:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0998B10EB90;
	Tue, 21 Jul 2026 22:11:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="FB2834tg";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B93710E23A
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:21:46 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so85567345e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 04:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784632905; x=1785237705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=y2+LKseJXzKxktbUWoc1WNBTZXl1F3xYy2w48c5tdQY=;
 b=FB2834tgYKBj7thfbR0up9JyKUqDmylai8dZZt2Y2xspYS4lGi/0WfnyDJdrK+gNsW
 eeX/GQJ1YwH8U05i2TWAi43WMOmKZTxR2bR80YLbHhYfH4OU/tFH6M4XLtupdafLrllx
 m/OsWjyPIwpaQdcYqvwAj4Og4J6bhstz1eyG6c1kMWcL5wx7JcOw3DGOzJfU0/rvmjGt
 On7UEOCBS2zl/mMfvPLD/saF0pEnTOIKR2nHg3Enb4kZHXg1v1r4GAR1SYv8B1ex2TnW
 8iYZNVfYW/nfL/a3cCSKFicJaEuxXjMWkq3kwbB6vo7P1h8COp1WIfbXu4cC7ZgNDlIf
 AVNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784632905; x=1785237705;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=y2+LKseJXzKxktbUWoc1WNBTZXl1F3xYy2w48c5tdQY=;
 b=FER6JJwYQ17nQnuMxy0/vBS/z8loRRjUN23mA9s4SajKBcU5aQMMeFFHj/1AJj+lN5
 yGPKkXou00oHltYjNFzuOWnZsMc27nd7eR5xb/axk+TvFTLaI4YCHxaN3dg4BmnhmDEb
 fvC3j16b5ciyCmjIUDzLOY9s0dbS80eacfrWMHhfnXOCgYuLzLdGYjyltYhns1TzNTq1
 T0haKwfYZfw5Bv9tcas6hO+w2AV35c3Gdhdfea4ac8kgPBNTgHQN++DSyJRRmtxeFoow
 SXGbDN+7R0cBuL5xW/IwpCrMDgwsaW3s+ka0ByhzSz75XQFcBShuvJvCshOfykbPBUAR
 BMsA==
X-Forwarded-Encrypted: i=1;
 AHgh+RrgW39ZcYUwMWIgYD7jKFX47mDWaRlQOYCOjBoWJgih41mpb8U5bG4UQkbCPphPQjvtO7ro4IlB9Fw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyJte2HNX9z/3NKSNuGXuvwB3FD552x2k3MEViYC+Ja6T/a+HEH
 iXMw4IIY5Y4JO6KCHlJUjz8tXOWHTx0JeMaTjp51XC58ZlKrLbIQ1qW+
X-Gm-Gg: AfdE7cnH+R4kdNWUf+5b+PcdZrVWjTtidm8yqJ/iAChnNP5rpKI/BABKhZilB/HZ6uY
 reniPjnjHDXeUOhPMB94+5gc82+fb8gu99nOI1aG/3rpcG2MGyHvwHL7JRAgqfXyh1exbIVPxWE
 gLRp2fCkse5YfS1/wDP1zPLOyEmy3N+XDPK2ocywe9OxUgk34gOPvP4P1JPpv3obnqITXO/Fi5H
 MGL4oaPGR4DP68q782IrxDGBm+zjFdmVTTgSczEYh1SnNkcHtoR5h75WDtajZXKtbOzYt2+dHL5
 32t1RcS12QjmGTMLs0H8Y1IE/xz7Un9bIxjuv8qHQytCD7w1L7OuicfCXflBPOEwzl3pyjGBlMk
 0QYCyfLJrKwXh2Qc57KNkrO20qo5rI4hI7dJoV8XzneNbZs06Dqr4Hmf5AH1nWhxjFE3Su6alIX
 vVr3hLdNdUYtItGtS6EkV0GDzg0BAX5FZY9gZHUADpYBhQ
X-Received: by 2002:a05:600c:4504:b0:493:c194:4e7a with SMTP id
 5b1f17b1804b1-4954a3d09c8mr194922355e9.3.1784632904451; 
 Tue, 21 Jul 2026 04:21:44 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-47f63e49ab8sm40232416f8f.5.2026.07.21.04.21.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Jul 2026 04:21:43 -0700 (PDT)
From: Eduard Bostina <egbostina@gmail.com>
To: Aaro Koskinen <aaro.koskinen@iki.fi>,
 Andreas Kemnade <andreas@kemnade.info>, Conor Dooley <conor+dt@kernel.org>,
 Daniel Thompson <danielt@kernel.org>, devicetree@vger.kernel.org,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 dri-devel@lists.freedesktop.org, Eduard Bostina <egbostina@gmail.com>,
 Jingoo Han <jingoohan1@gmail.com>, Kevin Hilman <khilman@baylibre.com>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Lee Jones <lee@kernel.org>,
 linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-leds@vger.kernel.org, linux-omap@vger.kernel.org,
 Mark Jackson <mpfj@newflow.co.uk>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH v3 0/4] dt-bindings: Convert TI TPS65217 to DT schema
Date: Tue, 21 Jul 2026 11:21:24 +0000
Message-ID: <20260721112133.70382-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 21 Jul 2026 22:11:24 +0000
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

Changes in v3:
- Added 'unevaluatedProperties' to the 'charger' and 'pwrbutton' nodes.
- Renamed the example node to 'pmic@24' and added the rest of the
  properties and nodes to it.
- Dropped 'regulator-compatible' from the schema. The property is
  deprecated, so the regulator nodes are now named after the strings the
  driver matches on and the DTS is updated accordingly.

Link to v2:
https://lore.kernel.org/all/20260718215632.3295049-1-egbostina@gmail.com/

Eduard Bostina (4):
  ARM: dts: ti: am335x-guardian: Drop unused isink-en property
  ARM: dts: Rename the TPS65217 regulator nodes
  dt-bindings: input: Convert TI TPS65217 power button to DT schema
  dt-bindings: leds: backlight: Convert TPS65217 to DT schema

 .../bindings/input/ti,tps65217-pwrbutton.yaml |  42 +++++
 .../bindings/input/tps65218-pwrbutton.txt     |  30 ----
 .../bindings/leds/backlight/ti,tps65217.yaml  | 170 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ---
 .../boot/dts/ti/omap/am335x-bone-common.dtsi  |  14 +-
 .../arm/boot/dts/ti/omap/am335x-chilisom.dtsi |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts |  17 +-
 arch/arm/boot/dts/ti/omap/am335x-nano.dts     |  14 +-
 .../dts/ti/omap/am335x-osd335x-common.dtsi    |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-pepper.dts   |  14 +-
 arch/arm/boot/dts/ti/omap/am335x-shc.dts      |  31 +---
 arch/arm/boot/dts/ti/omap/am335x-sl50.dts     |  14 +-
 arch/arm/boot/dts/tps65217.dtsi               |  31 +---
 13 files changed, 275 insertions(+), 157 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt

-- 
2.43.0

