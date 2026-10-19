Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C62A2CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 10:09:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E096910E96E;
	Mon, 19 Oct 2026 10:09:48 +0000 (UTC)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2F4510E96E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 10:09:42 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-48e0d1c095dso933153f8f.1
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 03:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792404581; x=1793009381; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2k1+XdFZpFLCHbc15Fx/KjwLwLdvrI4ZxyGFOBKUCSU=;
 b=n9brp4qQVn7S2rQxQrEXru4K0DhsVgjCvPU6jNmWWtitF5ZLdsX1ygdpufaBhP6XRV
 rJFchBDTAig6n/da8atNU1KZHj+IfWhFgBRYZ/+NS8E8vzjqqCrW0LG3UOMJBB7Pq9RV
 x0uUXHz0yD+wpBvGzdF7tUpsFFrHxIfim2L/qzpVA2MTUfW+2cezzgZ243FsrrXmym7P
 S9ATQB6RX5gAJ7v3/Vwc1fiOGsN7q1Y4tAxW4pBvsLy7wc1HFyseZTIkZdRVVq9fc3Ur
 6c1ji/vwLEPwMFi0hzkkLJyiwxXOM6FlqBghSlZnOUHwYaAGHshUB0jO1bcxNF49ezbe
 ttIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792404581; x=1793009381;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2k1+XdFZpFLCHbc15Fx/KjwLwLdvrI4ZxyGFOBKUCSU=;
 b=W8366W08K8uEsU8lx96xcGTSqXi679+vmpiOrOWRFiTsoYpX+at4/uFJHIjnozv4rY
 pV1FZf6dOUTY/v9+m1HoM5iHPygnWrOYvZIBXm3YpYsLiYLF1YP1oTyHgI7MONgTApiZ
 NivYqah/kb6RpHpI8Hdn/dWCLFY9Ftnh4yisi6WiI2QDtrbrqVmxcL4ypAQo/wd+gplt
 iBkhiUMs9NOWlX+KoeQC7TDloe+yi4zPUuHj2RcGIXqwHIlWt0FFC9gsML1hcHBknofT
 xJfgdl7zoGE9bkipj2YRpRKTWzCWDmDFp6KUY48/k+2tklPWTAsYE9ov7QbkewS7+uB3
 KIfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwK367ADVqa1Og3KXB/jIsv/kExB+BJ0wD/u+c40bBgdYxzl5M6pf3GlqMqFIL2B/TMMvbdATNmlO4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYI2Tffkys7FHseIuVqVtxPqHR3mrbBndpHMFXTcB8PQir0HvMAt
 9e3kU4z2DvZBL/71Y0dje1sCI/4C/tt0wR+hSEynh0/5DXUYdOvFyif7
X-Gm-Gg: AYBFou29GNwsDS1V6tKaJJY4dJHssVtKvV2jrJXDKODpSZ0kIeJsdL2cLxXgT4FTBLO
 5PQBK4aNM2NCy6qgHuRjKvF3S0giyUyiKgdYC2Zs/HL9T8p2suAjetlRB58UvNLCev5SdSl3XfL
 j7jkE817Gf8BjzhWWeVFnktY8AfVeKYCwM8wKAbENrTVYnl1mWYGSTGWlUXlETFAfLdH3XjtjU+
 MzheqolOrSOpqi6MVmtP53gYvLIZ2Drq40sqVkwM5tXaS3n0NV0aDEl8QcC0D56GIyeiLgIw0nX
 psuSCzMfJm4wyqWfostGhEAlBGBle5UPWYbTQ8TTXK9jjlIIj3xbvq0PhrtOJH+Ri+c7qQt49p/
 p3GyZhkuRwe0uUpEu5cUdx/kSr1HbuCDSO2yhiuX7qys73VpmopyTJK527R9yRw5PYTk8ckF9Zd
 hiaD4QmrY3dihxr5KVAlZgC4dpHy9GhssrrTqKbjPXPWwlxyAwMMp1vhxLpRU45fONP9mV2/qW0
 ydKJOs1LJ+PVN0VVvM=
X-Received: by 2002:a05:600c:4e8a:b0:4a1:8961:78dd with SMTP id
 5b1f17b1804b1-4a1d7616464mr162248185e9.27.1792404580998; 
 Mon, 19 Oct 2026 03:09:40 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1c8a81587sm510533485e9.1.2026.10.19.03.09.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 03:09:40 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v4 0/4] mfd: aat2870: Convert to use OF bindings
Date: Mon, 19 Oct 2026 13:09:26 +0300
Message-ID: <20261019100930.110954-1-clamor95@gmail.com>
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

Changes in v4:
- set max_brightness form aat2870_bl->max_current instead pdata->max_current
- switch gpiod_set_value() > gpiod_set_value_cansleep()
- constify aat2870_regulators
- max_current in bl switched from int to u32
---

Svyatoslav Ryhel (4):
  dt-bindings: mfd: Document Skyworks AAT2870
  mfd: aat2870: Derive brightness steps from max current
  mfd: aat2870: Convert to use OF bindings
  mfd: aat2870: Add support for VIN and IN-LDO power supplies

 .../bindings/leds/skyworks,aat2870.yaml       | 124 ++++++++++++++
 drivers/mfd/aat2870-core.c                    | 120 ++++---------
 drivers/regulator/aat2870-regulator.c         | 160 ++++++++----------
 drivers/video/backlight/aat2870_bl.c          |  79 ++++-----
 include/linux/mfd/aat2870.h                   |  95 +----------
 5 files changed, 260 insertions(+), 318 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml

-- 
2.53.0

