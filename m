Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E9660A5BFE
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 11:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=JJM6qaYf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA37E10F3FA;
	Tue, 27 Oct 2026 11:32:59 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AD510E3BA
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 11:32:53 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c43fbcb4393so565188066b.0
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 04:32:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1793100772; x=1793705572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=t4IJra9NQJkRGyVR4RCc/9Aohe97L8CkEFMWXcoToWo=;
 b=JJM6qaYfII4bnJctHbXL0HlNpHVqSWKyIFyrO8YYGJhgnQI7AAAKIfTNZlhQVRsK+d
 si6lT7lblY2jqEBTiAmG1KuMcCQ4YGyQz85m+6N3gM8lH+i/Rqu8YYoF4IOKpLxthd0B
 gy7xKbcmxNwQ5oFWPwMTp+peCgQzQM/cm0x9/dRAWNxXBLtKnjX/jgT06yqCo9AMUaHd
 Pc54HCvuodSJC7ZHw9Aop6gJHZivISRRh7bdCFX1/+QKFH55e+P7VfjxFBCBFgr3kKwW
 lGTin1eT8Wo4wlKBkSa6O4/yn7yxVP6BE17ZaM4iKzdZOvARKYeDIfEYcVMW0HNrIOqY
 Vwnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793100772; x=1793705572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=t4IJra9NQJkRGyVR4RCc/9Aohe97L8CkEFMWXcoToWo=;
 b=OASOl24zzrYD8z5V7xRU4b16Sp8lTs6LtI0FeCGiNNsyK/VEwKNGAx78BWJnV55Bae
 zBTYMo8eD3bemENp78JDg5fjCCHmEVFc0NOzzGDP5VopMTBXqf9R0Mw2xIBp4nMhnM0E
 ww0l4Ew1Jp5sUHt4akDqvfbBMrS3T9mOn5YbeoOZt9Qqa4XWWcHRFupZi5vGL7bKlXpH
 ocpKDe1dmN3RTMXupqh3HS6k9QSRhcsToQNYQvuKz/Zqss56Pl/PbATTbZqtsfZzQpJt
 SCPBuFkvYu2ctzu2PHoeKFD3MqSG5AfXcjkkzb27B/iHZ56+vdaUZHxVwBMuKgEUdazF
 ZpEg==
X-Forwarded-Encrypted: i=1;
 AKwUvBw2qz5ezqtgn2ByrZrAM7OVLbrAYyd/qlWdDj8x1Na1Gg1EuOkAbWGMt8XEGR4HVMdQWqlGebLbrUw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKT/Zw2Goblgb1cmsqiFwbwsVyVN83KF93jn7GzOhznUmiEp/hC
 0oHEyfcUXwClLjPGxor37fhD+IyVWYXfm90b9t/Fltt8xfr7ulGO8XYC
X-Gm-Gg: AYBFou071zqXCo0iHsJPP7P0YCSM1JEeHdpyDY7V+CHURUjhBZlvkLj5fTONl83E82X
 3tGVYdqBx9mR8vw3Ym+/+/kQUojeUkbEJjb0G4e5AsPSzq7q/YYQz1q7z6/KFDnm2glpJKR3+nU
 PCxLIyfNCg+tuUBjh/oI9kpYEe5OxFTMSImTwkAvAttf8SkkUFivqGIdpLf+GPnHg32ny4H3iea
 nzqXVIRVyxVTlrcCNUGxMztEJKlwtlNdGcN2p5lU3OnUl20FIwrBz0scUQXCjUzK6v5v2pkR0kE
 t91sj1S0neSDV0Xkxevj7zpmi+kugqzkGtwB5q1agR0u1EDp1O01iSARWUyRkjH+5zTDPts3oig
 tIsxn51A1cOYKCmGsO3nWB+NylazzICQ0G5CuRBUgzOKOI08vOB/boJvXreethenQ1V8iz1w87/
 qUhYIL4QMhpbA2kleqYjt/C4hSFNhKPTtKqw9Ij2XNIGtGRBbpZe0qgNWRVZFu0qGuhWxOh8VPX
 Vh3DIKduoT7s2Hxwtuj1qkDA37r5WrlkqCYvbQBxu+jcQz8Z+bQkYBtgqMeL3deFZYaY8F1v1Ij
X-Received: by 2002:a17:907:9307:b0:c29:4915:83cb with SMTP id
 a640c23a62f3a-c46bde93525mr1103423366b.39.1793100771899; 
 Tue, 27 Oct 2026 04:32:51 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c46bd4ea608sm428920566b.21.2026.10.27.04.32.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Oct 2026 04:32:51 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v5 0/4] mfd: aat2870: Convert to use OF bindings
Date: Tue, 27 Oct 2026 13:32:26 +0200
Message-ID: <20261027113230.47538-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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

