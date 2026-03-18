Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 644981077612
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 19:50:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F095C10E7AD;
	Wed, 18 Mar 2026 19:50:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hDBz41K+";
	dkim-atps=neutral
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com
 [209.85.128.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3275B10E040
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 16:05:15 +0000 (UTC)
Received: by mail-wm1-f54.google.com with SMTP id
 5b1f17b1804b1-4856cd3f1ffso8595e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Mar 2026 09:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773849914; x=1774454714; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=48rofo6CJOo6vDXyvqVZcV6FKGqYI4Brbiz5qO2aiTw=;
 b=hDBz41K+zv6EUJoQ/YPmkNOPepG6OAzyGD5h5LXTodSHmUrjEyKgPiq3RXQyCZWqoo
 ShH9kQ7lQF0TZ89E7Gt4QpxgNmE2Ks26W9geEAZosG0fbhhE9OJ7fm7HF5h64LOhwLPu
 pvL63kb/ZWfa5opn0u3Y/aHakVv0mGUDZpY2oOTMSRPCtTzQXemBFpXl1sTW6Ew9/49a
 /PZ/pUhP3ZCOim9iz6jd5e7OExOwJj33715G98BnJR46nESXz2BA2JvfM+mUKgYR7H//
 tZUjWqtZp+XsXpC3XFmZGz3Ks536/4Oln92SLLJVQsZE3PDO0UvrZNazbUwOwmB2So8B
 tNxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773849914; x=1774454714;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=48rofo6CJOo6vDXyvqVZcV6FKGqYI4Brbiz5qO2aiTw=;
 b=TrBNCAonJMtlhycs7kCdO4NZAFQGpKcx8YJNcOsDnXzYjvnMYdb6XvsFrd+iMNiivw
 nkEYbt85eZbp0Xkus2Clz+OWjkDMO8nYpps0qcJWU5reESlrE/qNqyLUNNL7D1tnT+DT
 UQLGmUtuLr6dJ/KdaUhV5L90zEfeTaSedE4OBJbH1e+Ar21FMRQswufiI/Xno8ciLRhk
 ZFBLDLU+mgxhX4VKSfS8G99FwQ1G1CvXaqtkv7BLze1nY3/f10Ojs/o+simDJQa6Pqlr
 2lyYPhzgROzaB9ntvlcMS/LUKrTzPSH56XBnP3JV8tSxeXtMZdvEoaNW/LdMKcvD57zn
 eUWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX8G4943vA/x4Zo42of/tvxbHZPXMdYEWS9IO5ZMu/CLRZKOmHWgPCueSIaTJPZOqYgq5SCEk/U+/Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzCWetLOJ0yEUb59ZtEGBjGXfZDNItXDj8V/UGs26Re8pOIv05+
 zIURow40ZQnI0Kg/sZcG24PAbwYRH0SIC5QX1i+0gUE+wRLrQTgtf1tZ
X-Gm-Gg: ATEYQzzx05/D4wqRLOXIWdliMrjxfoGFas0M0NAXSiNAVupR2mOYCvzgLM89pgTHk+W
 wtWa2GsfcCUTZnuAVOHKfg09vzov0TWekNWsmBwnbSdlsE7yJYOGCeyZO3yRM7CBOylq/XUNi/p
 cAjkzQZ0cnCI12cLtFcWVc9ScVOW9EeXuf4Meo8/cU7/JnlOmmlbk1GD5qblxT4/Gb/GQKcvAYU
 b7uJmVrbWKDz/Ih0tWAyq/lNqchMrj4v/GGJ1RaWC87KCXa93mXDITXOlls6qY74rXu8kbXm0Wx
 QRtmyuEz+sIyHPG9BfegxQtgfzlr3h04tTuYedBU1EovnYp1kmYCgWtGcVbR7zhp7NR7Bu9oQHH
 z3mWMtwUxE6jdUBSXvU7/27wHWdvfqXUdCD/wPvYwZwClfisz38AVMc3IxBt71WC4w7MPljFkqr
 qGo+3ph84GuOQ8N5RuSU2lkkKH6rFEWiPXgXrcq6o0podfTE/LSHSw/N9Br3NTNH8=
X-Received: by 2002:a05:600c:3e08:b0:485:5812:bb9e with SMTP id
 5b1f17b1804b1-486f42018dcmr69488495e9.0.1773849913198; 
 Wed, 18 Mar 2026 09:05:13 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8baec5csm2282225e9.15.2026.03.18.09.05.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 09:05:12 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH v6 0/3] Add support for the Samsung S6E8FC0 DSI and M1906F9
 display panel
Date: Wed, 18 Mar 2026 18:04:47 +0200
Message-Id: <20260318-panel-patches-v6-0-7a30c2f85e0b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33QS2rDMBAG4KsYrasweliSQyi5R+lCj1Eiasep5
 ZqWkLtXdhYNWhSBYAa+XzO6kYxTwkz2zY1MuKScxksp1EtD/NleTkhTKDXhwBVwZujVXrAv9+z
 PmKnqVIgaIRgGpJjrhDF9b3lv7496ws+vEjs/mmTAnO0Wu28OW6pYjzRS75gwGiiji+2PV+s/c
 J53fhz71zXa2YzUj8OQ5n0TZAfKIpO2jUwoj05p5hyTHoMrnWhbBcEqsg5xTnkep59tx4VtUzz
 W4aJaZ2EUqNat4tBJrWN3PA029WWIYUta+L+aF82cskFqFloJtRZ/WjBea1G0wmA8gArgsNbyW
 ctay/Vt9M5xD154U+v2Wetat0Vj7LqoHTfl4571/X7/BSAeNrknAgAA
X-Change-ID: 20260218-panel-patches-696df7e0d810
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Kamil_Go=C5=82da?= <kamil.golda@protonmail.com>, 
 Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Yedaya Katsman <yedaya.ka@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 David Heidelberg <david@ixit.cz>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773849909; l=3391;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=jXMA/dCk6GfYrs/V5on0Asyipeqpdixm75EBXPhISag=;
 b=TOPaPwp4HkIzKfP0Z/7KdEVCQZt1ENxA6P4rIZ70bOfbJ1izYjskptI21MjXpuNlci9qsaLxn
 S4uXQcjZfbwARVhc7DLz6EYtxZ9hQnorQQFmDiHOutRZ+NJ5k3xDRWt
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Wed, 18 Mar 2026 19:50:21 +0000
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

This adds a driver to support the Samsung S6E8FC0 DSI controller with the
M1906F9 display panel found in Xiaomi Mi A3 (xiaomi-laurel). The driver is
generated using linux-mdss-dsi-panel-driver-generator[0].

The mdss reset dependency makes the screen work more reliably.

[0]: https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
Original tree with patches: https://gitlab.postmarketos.org/SzczurekYT/linux/-/tree/laurel

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
Changes in v6:
- Rename some identifiers to be more panel generic like David asked
- Link to v5: https://lore.kernel.org/r/20260317-panel-patches-v5-0-ef99f7b280da@gmail.com

Changes in v5:
- Fix typo in panel name, s6e8fco -> s6e8fc0 (zero -> O). Was like this in
  downstream, but in samsung website it ends with a 0 [1]. Found in [2]
- Link to v4: https://lore.kernel.org/r/20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com

[1] https://semiconductor.samsung.com/display-ic/mobile-ddi/part-number/s6e8fc0/
[2] https://sashiko.dev/#/patchset/20260314-panel-patches-v4-0-1ecbb2c0c3c8%40gmail.com

Changes in v4:
- Use exisiting binding instead of creating a new one
- Mention dsi phy power source in commit message
- Mention only DSI controller, not panel where it makes sense
- Remove VIDEOMODE_HELPERS selection
- Collect trailers
- Link to v3: https://lore.kernel.org/r/20260312-panel-patches-v3-0-6ed8c006d0be@gmail.com

Changes in v3:
- Make driver, bindings, compatible specific to M1906F9 panel
- Adjust brightness scale and default
- de-mystify some dsi writes
- move pinctrl for mdss into panel node
- Rename regulator nodes and names according to schematic
- Treat vreg_l9a as input to vddi regulator
- Add myself to copyright header, remove years
- Link to v2: https://lore.kernel.org/r/20260223-panel-patches-v2-0-1b6ad471d540@gmail.com

Changes in v2:
- Changed commit title like Dmitry asked
- Fixed copyright header years
- Link to v1: https://lore.kernel.org/r/20260223-panel-patches-v1-0-7756209477f9@gmail.com

---
Yedaya Katsman (3):
      dt-bindings: display: panel: Add Samsung S6E8FC0-M1906F9
      drm: panel: Add Samsung S6E8FC0 DSI controller for M1906F9 panel
      arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Enable MDSS and add panel

 .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       |   5 +-
 MAINTAINERS                                        |   5 +
 .../boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts  |  94 +++++++
 drivers/gpu/drm/panel/Kconfig                      |  13 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 .../gpu/drm/panel/panel-samsung-s6e8fc0-m1906f9.c  | 301 +++++++++++++++++++++
 6 files changed, 418 insertions(+), 1 deletion(-)
---
base-commit: d4906ae14a5f136ceb671bb14cedbf13fa560da6
change-id: 20260218-panel-patches-696df7e0d810
prerequisite-message-id: <20260303034847.13870-1-val@packett.cool>
prerequisite-patch-id: 3fba84f11111406e0d530013fd45ad0eb389786b
prerequisite-patch-id: 81440b7f28f9101d3dc5d4bad6dc86e39b81a026
prerequisite-patch-id: 53469d8c9810169d058f1bfd27ac8399038aae74
prerequisite-patch-id: 80809bee71eb6434f6699d5e5f8c7f9d4bcd1ca7
prerequisite-patch-id: 0269e01c9c54a37bb92983635cd516342189aee5
prerequisite-patch-id: e2bbf7c452d4da6d71b1a5194e0d7ce46584e113

Best regards,
-- 
Yedaya Katsman <yedaya.ka@gmail.com>

