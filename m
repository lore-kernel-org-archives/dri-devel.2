Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9DA606A33E
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=VHIObIa0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05ACF10E8B7;
	Wed,  4 Nov 2026 12:37:32 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E297110E8B7
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 12:37:25 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso525063f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 04 Nov 2026 04:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793795844; x=1794400644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=74V3jje9GT/TZJsW05wIZrY30Lopn0gs+JfNYxexip8=;
 b=VHIObIa0FE4RWlXL4NYrkeXjysPwkxmvv63m47401gCAf0+NYHORp1FlZUDffM70ii
 bqA83W1iQTYispRCoQl9AuCDuERp6lguimh3JBgGawE7NedSs7CEMIjHPpqpBkXLAe3o
 fVKgZWaiHchCXTwWhoS9QFE03CcSxs/FuS2NLn/AdZF2S0r5V33RTSUQ0PG10kdHbQLE
 Kh0VYPWwaa9FPL34Qx262do1GoOgAoMLraRba/sK3qKaelwDGbSdtPbmsRgEHoM8EvrW
 8pnENROwiUHjbB+Dli3etxrVNIDGfB4zv7xPjScc52jhix8VruPCaw3+e3YUNEubkCk3
 629A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793795844; x=1794400644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=74V3jje9GT/TZJsW05wIZrY30Lopn0gs+JfNYxexip8=;
 b=dn5qSaGbZm0m63KmPW0zc9k2gZGC4fEDvYDD4gW6dRtdC2wkFJUMMa3ViQLeWuOiHT
 rwsHqmqvZ+kqRnBttTFuu774el8FNsblban45TixAR6R4vwi1N0QDIqA4K3rjrmynCLv
 6vLMKQPxBcwF2n83d4FpzPqpBbMiM1iU/VS/oyJSu/Kx8fQ+tpw2NVEddATvnC6XC/EV
 Ql4fxAf/daQpQ8ot+3STBZJP5w+cmLOsbavGmM6oHGmavgZWCdcHdxOOC1x35euWOdaw
 +ZC6idusbv+NBFcLfe95yN6G0ZJsBHefmQryi4xAxBF+VHa7CiSUEQjvYZT36g9TIyiK
 Ecgg==
X-Forwarded-Encrypted: i=1;
 AKwUvByHYFer5MnYNhJmawlSUx+MwABEfGGw6JFsPg2FzX/eNq4MGIbzsbGFy+FegUdMAN2FBD/T0nBgcfk=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z85kas9IARnDI3iJjGd1pf8S/5nDIuTZBQzVTNIMkRxO/jhpRGU
 I3s0TdzgkLvFFF5gfm8bq13t8PLlcydbNdglBNOT/VIPrHqnGjyzoOcB
X-Gm-Gg: AYBFou3d7Hca0ITzscRn+qSlM76OlIsgvYe+JkugVLIDmHfZ+znRwKYz4xmlnefI6Lf
 zqLeVulDGI1Qwq6MWkGpfhE033c+dCnyh+sh+cjLxXOBxcd8kzyoUlaXrUjSKb3cy7WyFwtUtSR
 emtnRpcO45W9+wHjGOrhw+V5fUeoet7ds3J+ZnNq+/xicZOvS+2IW+10m4wqQjotlSiBYLA4HKC
 gs2ReIxrHeQmWAkNBRxu7jJCLmevf/5RDGe/mwfg/kk4XNYAzwRDjySn8H4TxKeDvCBT+kpKnrO
 LTXpUJPAvCovjSsW7gi9guQtTWgl3Gm3SBKWAByaNFEkTsd8SRwfcHmIDEd+5+tqayFX5FWk/+e
 xYWY1SLXXHHLcCJxzehcrcAkmrKJG7gv0hA6eyO1a6O6rNLYumM/rtb5slKfpJxQLR95nyRq0JL
 Pzq3wU2seOGoqaQuMwUN1ku4WAJL8APUig9y89KEyw35aXSyRHaS2b+zdPz7XW9mLqkwBCSkVFB
 dan0PB86e9blNNOTVTvPjb1UJ39PAxMNbIBY7pyf3HyKVnWydouqLbCDFyJAn7qRhOUfczJQDp7
 dvOsL+04Co4nTb6mp4ioxu8ivIwToemh9vTwGL7B0Uu1HTKU5w==
X-Received: by 2002:a05:6000:2c09:b0:48d:ff06:c626 with SMTP id
 ffacd0b85a97d-48e6e50089emr35262303f8f.35.1793795843957; 
 Wed, 04 Nov 2026 04:37:23 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed553441sm3386155f8f.43.2026.11.04.04.37.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Nov 2026 04:37:22 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, mfd@lists.linux.dev,
 dri-devel@lists.freedesktop.org
Subject: [PATCH v6 0/4] mfd: aat2870: Convert to use OF bindings
Date: Wed,  4 Nov 2026 14:37:10 +0200
Message-ID: <20261104123714.234634-1-clamor95@gmail.com>
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

