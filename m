Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6247EC44521
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:16:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6619B10E77B;
	Mon, 20 Jul 2026 07:15:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nyO9Q6Sb";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D982D10E604
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 21:56:53 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4954c0833b4so9249085e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 18 Jul 2026 14:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784411812; x=1785016612; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9u5KL9RtfMSzVJ4pDX8HPR4lAEE6w6qofkrh2nVYcFI=;
 b=nyO9Q6Sb9DEe1XEfFOJ/YJqX8c0C4o3EUZaYl/SHja+Jm6NH2xwu1pXDTwpGMo1fB4
 5/IVxcP7ys7Vob8DK3z78WKkrFLrv+b5VI8SMvZ3XQOWG509ZYLTO2bSFUfdrXjMlU2l
 TGpiDvRaHhmorAkrrMoI9vLWzUdRSx5MV+6ct5epxzH9nN9QJd8396aUP/le5/Qn5kkz
 tWN8od/7LiH6tqX9ND9cDrgW11oVBsOpOs1iH49KOI7xwyW9dGRrL5obEBwSsRqJ9kqk
 +ssKkb2CBf3s0LaxbTqNjfbgWfc/hVKy9iwGuyFa0XZJ5HeEbCPKJHCUA3aogXB0TrbI
 OMMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784411812; x=1785016612;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9u5KL9RtfMSzVJ4pDX8HPR4lAEE6w6qofkrh2nVYcFI=;
 b=RxajMSFov43SVoGh6sVupKl5GbcTAtk3I6a5Qe0oBGRGskL/eQnAaB//EEP+uKnGvU
 6ubumaMVgEvEY34UNt679JAM64WyrOXBh3lWvlIef7IynY1FuhQYnaEQ5u+jYwFaRA2f
 rQZzGwv8hXyzKti1b4c8jrfjqQJ+s6bHF75hpqwUPVfhjBdGV7EvpMADmlV7/qJ7E09S
 mX/l/F2ZQAwuRDCMUatrZ6gYZdArUdLogZAUwmBvaaKqzWUTdlCluW4I8F7BXNPsXISG
 7uInYZrsbkp8If9/r61500pzII6v7C4Vq4RhgT7Y9tjkbDJkpGadHeDARrfs7GqQwSi5
 3X7Q==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq6nxF2qlXrHV+h8IBMLJWtNqXL2sufZVseCHc3teNQwkAZekTF/JKMF1VvYboNR/bVIHaBYfFRCOo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxlnVL9dC8A+D9lflbZQuzlbPne17aUd4pxqIHakOV5kCBhX2EC
 3tfJZVrr52E5Vdx4t1oSPZ/SJr3L22RqpHMT+C0MMZiZNzc7mHvkGDF7
X-Gm-Gg: AfdE7cl7eBtD35Puns9X4C1l+webpNlxMh8UG72LYxb1gBirATy4PoSIYTMG6PaE2NN
 G10+PMxz/wGMPw05C4kRXaeVuc/RqnzL406wPxFmjlYBuYhVA8iZ7vlmLcpbvfH4td6BhybOp11
 NfHqCl1vaWiC2x08SUsvc1ApcOI7QqqVF00UzAg1AxqfGYwPK4KITH7WRgmt/DcbSjRzg6ji6ID
 S/Lg4/dkryL8SO76NNsoNRWg5XVLdiuw0R05S/7Y/HelEVX5gi1O79TviGfv0nlgsgwpkqBM1XI
 5N+6TlWXWvVGFqvct/Z1PFRtg1ycwv1oCH5B8vCsEn6S7yD7SFrw8U36PGauihBXsfdKkeFlBNn
 Z6LstJkPA/Tx1UdAhZioP5V9LgHyBX84tLV24HA18NaGui4eA1Ww2cClfJt62VvVovUCe+KTBYC
 qiOh4mQQvuKdKgh/BA92cuAk4jvQoKBhWqsXkEUxgkO1T8
X-Received: by 2002:a05:600c:3b1b:b0:495:443b:1bbb with SMTP id
 5b1f17b1804b1-4954a50c473mr78247845e9.25.1784411812179; 
 Sat, 18 Jul 2026 14:56:52 -0700 (PDT)
Received: from localhost.localdomain ([188.26.50.240])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-4954c0a81f7sm101199835e9.1.2026.07.18.14.56.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 18 Jul 2026 14:56:51 -0700 (PDT)
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
 Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>
Cc: daniel.baluta@nxp.com, simona.toaca@nxp.com, goledhruva@gmail.com,
 m-chawdhry@ti.com
Subject: [PATCH v2 0/3] dt-bindings: Convert TI TPS65217 to DT schema
Date: Sat, 18 Jul 2026 21:56:29 +0000
Message-ID: <20260718215632.3295049-1-egbostina@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 20 Jul 2026 07:15:03 +0000
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

Changes in v2:
- Set 'additionalProperties' to false and documented all child nodes
  ('regulators', 'charger', 'pwrbutton').
- Documented the 'interrupts', 'interrupt-controller', '#interrupt-cells'
  and 'ti,pmic-shutdown-controller' properties.
- Dropped 'isink-en' from the schema. It is not read by any driver, so it
  is now removed from am335x-guardian.dts instead.
- Added the power button conversion and referenced it from
  the leds schema.

Eduard Bostina (3):
  ARM: dts: ti: am335x-guardian: Drop unused isink-en property
  dt-bindings: input: Convert TI TPS65217 power button to DT schema
  dt-bindings: leds: backlight: Convert TPS65217 to DT schema

 .../bindings/input/ti,tps65217-pwrbutton.yaml |  42 ++++++
 .../bindings/input/tps65218-pwrbutton.txt     |  30 -----
 .../bindings/leds/backlight/ti,tps65217.yaml  | 123 ++++++++++++++++++
 .../leds/backlight/tps65217-backlight.txt     |  27 ----
 arch/arm/boot/dts/ti/omap/am335x-guardian.dts |   3 -
 5 files changed, 165 insertions(+), 60 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/input/ti,tps65217-pwrbutton.yaml
 delete mode 100644 Documentation/devicetree/bindings/input/tps65218-pwrbutton.txt
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,tps65217.yaml
 delete mode 100644 Documentation/devicetree/bindings/leds/backlight/tps65217-backlight.txt

-- 
2.43.0

