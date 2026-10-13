Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E74CC6B1A
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 18:09:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2C5510E8B7;
	Tue, 13 Oct 2026 18:09:52 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D36C710E64F
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 18:09:46 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48af4d4e61fso2360743f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 11:09:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791914985; x=1792519785; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4Ni5fu/M2p02kW2mgvbfBzY77o7xL0dnmXboaLsv73E=;
 b=kUIUbwlJVgw/DFc+ORfo7SLDvvbqp1F6OjFEmF7uMVHEmNuyKS9n82MBQ6tjpK9JAs
 b0NTI+OGGR/KlCDlk/yL7X6JKyycs08LbKZLYPiWej50VUgqkT7chgOgWUO6Mzvqh9KJ
 NzPNy4qsZiXbEMA1lWKwGHNE1dV2MlKQdt8vb1FKn3UhRJg8TiHfyXZcGN79kN55i8ix
 NV8c0hwSRf3jvU8lMHFlrmlU0Y5Ui7jHP2bVLsA8MtGbxoHl6AIpRu0ntQqkLYmcqqpz
 yQoYlbc+UihQrWryMM3qgL6ABZP7B5gPChciq+OlczvJImlmzU7hVeSi3JNqQ+39qK3n
 Q/Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791914985; x=1792519785;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4Ni5fu/M2p02kW2mgvbfBzY77o7xL0dnmXboaLsv73E=;
 b=SHvbMPryVRWkTfc1H5smAGu1DTlpHwON4I6koKRIbNiY5P7pBlYWB0am6eNAblrxtq
 J++TIQIVzNQEHVwhouJFygiY1Ue1W1o3DddCXa2QdlK++fu8COa3bruZ5RfAyp0nQlRO
 b2a3WwrVLLmqR8+NS9VF7MoN2atgkxeywx80crWZfzuTfRIAHVqFXMJeXf9TigcMRkab
 ItB3asT88WqHVcVHqLUvqv0WrzAsBUy6VEvMIS5HhPfNUv+OniwTzFTfCQ4RuB3pbttJ
 yEEtiLLHBdrDUXpA0drry7KnNNF4KijacQpdf7aHTdKn/h1wRdCQE7PP4TB5od3JVdFX
 E9hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzqv7tCng0yBfRq1Wg1RooqPIEQcnCG0hjynp7SOwMh07UitqeQJkFe2hNN5XjQd6gZZCOOhHA+8jw=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIzNfAdRjOWEqNSgVpUpUVPd8M6plgECO20p3S4z/+KkK9Te7Yz
 1ZJqKJkdyX1Ynx81u4euc5eet0qLN2JpojhLjMYiJldDdxRU5eR2FMC4
X-Gm-Gg: AYBFou0FmkNrGMBhNSLa3S6Aqg3pNK8jr8xxRan/EeuxhbiVFMeYmIMnCE+4adM7AAz
 hb2nWn+xXFEM2DaHSaZRkf/YIe+/wzrX0ErM1mFvo4rUv0Sq4u263ClMMUIOe46tXITfqBNBzXh
 OEaMJjAvNGJo30DYRCkStPv/uZCtxBkrEN91GNRtxs5OIQRbDYyDsBIKr99uHv8XUFS1iLr0Kgo
 zkkYwrUYxjL2tqhv1AuV+T/0GaBs5b04CQKaJO12nOGcHoDFiz52i/SrIU8ZCZ27WNatQI8ci6z
 kYj/AeW00LWywMEtOHv0UgLw8rny/RdWqTltFF6zlZzQ83T34i6Imd6ZEEiU4weXq6pDmJ2DmRD
 dSmcDQLMA+ug17XwYIqG6517ivhlKF1EuQ/fG5ocmWK+XBQ7U7EjuzuoDX2yU//l+gjH1hxhrdX
 cDtXxcmrBarJ/TyCoAQD1A01ybEm8j8Y6b8rX1hpAFacuj1XCb5CyjjViN5XUVeNZAq6UXXLvjK
 uOivBtfaiJQtPXVNnMd+7aetprn+Q==
X-Received: by 2002:a5d:5545:0:b0:487:27f6:a4e5 with SMTP id
 ffacd0b85a97d-48dbad4b6d5mr19310156f8f.53.1791914985161; 
 Tue, 13 Oct 2026 11:09:45 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0aaaaebsm6854498f8f.14.2026.10.13.11.09.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 11:09:44 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v3 0/4] mfd: aat2870: Convert to use OF bindings
Date: Tue, 13 Oct 2026 21:09:29 +0300
Message-ID: <20261013180933.487013-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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
---

Svyatoslav Ryhel (4):
  dt-bindings: mfd: Document Skyworks AAT2870
  mfd: aat2870: Derive brightness steps from max current
  mfd: aat2870: Convert to use OF bindings
  mfd: aat2870: Add support for VIN and IN-LDO power supplies

 .../bindings/leds/skyworks,aat2870.yaml       | 124 ++++++++++++++
 drivers/mfd/aat2870-core.c                    | 120 ++++---------
 drivers/regulator/aat2870-regulator.c         | 160 ++++++++----------
 drivers/video/backlight/aat2870_bl.c          |  77 ++++-----
 include/linux/mfd/aat2870.h                   |  95 +----------
 5 files changed, 259 insertions(+), 317 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml

-- 
2.53.0

