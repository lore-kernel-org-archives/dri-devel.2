Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7003CA5FEF
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:41:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0D3DB10E1B5;
	Sun,  4 Oct 2026 16:41:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="JNpYfcNX";
	dkim-atps=neutral
Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com
 [74.125.225.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C8BC610E1B5
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:41:40 +0000 (UTC)
Received: by mail-wr2-f33.google.com with SMTP id
 ffacd0b85a97d-48c54d65743so394802f8f.1
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791132099; x=1791736899; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=hI0d17TUb2l8DVdqo6tZX+Y2V30OOpneqbxvA1IJE7k=;
 b=JNpYfcNXJOviad2LORsUo8h38kDN6j1f1niVhDqarXb0+K0s1gGRP3Gwz6Xc1n5TDo
 rPGjGQrVlJoxe4Wqhxt99biN4EzAeFo1p34uuVplCptoSIv6AMisxVIFgXe9icV9qgXP
 ZOPxo7G0yL4lGBrYIno5dJu/BpS9mb9ZgYQ6fZNDRLK3gLigYJN3VgdGjRLOMXJ6X+nk
 6EZM+bzaoHyyvom/rm8mqzhc7NT0qlbFeY5bAvv0e8B5m6HLhVL7zqcOpWzuTRzQh8Os
 /HAAHVpVHLob4Yse4UUAnKJeDxlraQ1znkhx1g0EyKG/OwfKRluXqDxH5iE6w6eXT2I7
 0PRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791132099; x=1791736899;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hI0d17TUb2l8DVdqo6tZX+Y2V30OOpneqbxvA1IJE7k=;
 b=H8wtWUITK9DwK7ID62otPRMu0o5Z3hvRwgFBA/pw76oFJMaHvdLZX2yamicnCc+Mr/
 vnaFus3zkf2KcGnRmVyQRr3Cl7KrBw8PbFuUrnKuYvIPYzMlN3JrtI/hic0WsmH3E85A
 nDiU5h4d5Zd3SpM7Cy2xziqsh6wc3SnYivm+ToRivpgvY+P7rXP5zKY55DvIPKkKOy1Q
 mAQa03n165I5PKI6s7s17jWARhtVyetVzcoanV2BFHmkdJyWJ6kR+2j+U5pzRX8MhUGf
 LI9o3rGwjAaTynnmVlM6cHFf7EtqMw51BR0+9NmPr5w426Z96VIcqRc7SqZzJZojkG2I
 BpSw==
X-Forwarded-Encrypted: i=1;
 AKwUvBys77nq5/QaB+eWoJV72KwuCkEOQj4w51hmJ93DBVIe26rnMJLu9jWtqV/aZaHha0o8GXX3KF5lf4Q=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIyEzef0x8Zq6dE499JBvXqoqwLVy0tKEHOTpzDV2ATUi8NYbmr
 y6upFiKSa1KEM+ExOvpVlMCFX9Yt4yXWGOCedla3OytLi2wha5HeK8uM
X-Gm-Gg: AYBFou1UGVFZIAVeI1C2gW6Rbxhs7dX7VzRI//2B84Ov84x6Ir9Kg9qlh/A0ELrETQt
 cdQCedgFape5WSe4ltIzyQjwJrZB9UKrYTfCkaJwsSxFe1fGVegykjiQnkdHmNiHhbaEK4zEDO0
 I2j+Id29ifXm5UKHn1msncsGAbUolduEAamnIkoD56fv3Ca9xF3yBcG5Bl7IuCxncG7/SK5wD1O
 86Ci3HUhBiF6h8zORRypIyJq1sOlGlzh8Pl/WnhRNMIaBc9/6ETtsf2SbA21ogb9ti6fR9Yc7aZ
 NukD5fIGNg5XnkqdJtei5Y00ah744dwniKJEOUMkXOdv6DSWl1SrkMrm/OfeDG4X6WeQPFkjN6/
 yvtiLW4arxcsOtjwT7hKg5kKeG44v5Tp2qMhv6A19HWMZY5sjtH03p0MIbg8Z6UgWmuZsoNhpdx
 70AdmSZ1ihHKDDv4KQOWS79Gs1T7tn6uUuYXvOkCCRbMCel/KqSYC68jpWeosIV3x3srCpU5U/2
 GbcFta57BLnO8Aqjyg=
X-Received: by 2002:a05:6000:40ce:b0:487:27f9:835 with SMTP id
 ffacd0b85a97d-48b1271ad90mr13914155f8f.42.1791132099009; 
 Sun, 04 Oct 2026 09:41:39 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b380f07cdsm18765185f8f.10.2026.10.04.09.41.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:41:38 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v2 0/3] mfd: aat2870: Convert to use OF bindings
Date: Sun,  4 Oct 2026 19:41:18 +0300
Message-ID: <20261004164121.193514-1-clamor95@gmail.com>
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
---

Svyatoslav Ryhel (3):
  dt-bindings: mfd: Document Skyworks AAT2870
  mfd: aat2870: Convert to use OF bindings
  mfd: aat2870: Add support for VIN and IN-LDO power supplies

 .../bindings/leds/skyworks,aat2870.yaml       | 127 ++++++++++++++++++
 drivers/mfd/aat2870-core.c                    | 120 +++++------------
 drivers/regulator/aat2870-regulator.c         |  77 ++++++++---
 drivers/video/backlight/aat2870_bl.c          |  55 ++++----
 include/linux/mfd/aat2870.h                   |  95 +------------
 5 files changed, 244 insertions(+), 230 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/skyworks,aat2870.yaml

-- 
2.53.0

