Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A20621098792
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:41:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0450010EAA1;
	Fri, 20 Mar 2026 14:41:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kjK5seNn";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F1D5E10EAA1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 14:41:47 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-486fda2a389so5275125e9.1
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 07:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1774017706; x=1774622506; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QcH0uThvj0OwbtgaciluWQ94LA2SpO28hcpjq2xkeq0=;
 b=kjK5seNnEDHbcjtc2pgDwwAhw5J0IHElenmm14NnNqiXhq8S753uOUU1C1bO5iTs8v
 S9Q+1Uo34gqNpE7gN2oQDfy3TAKWy8RTEBGv9THHgfxGFAbHch10+HcaR74sFSD42ZuB
 8uvETe4gqTDsVwxbHZ9AiG2VFfls2nsfLRWOWG8rILagKMi3gOOefwisMHux2t1tXP7z
 MELG+mSwzZTssgTDny3yv5kPqrSVGHA0c5O/Kn2SwbQikswM6ykx70dATqkdK0nVEWDn
 VzpMfcH9YMua/tVN7q1ICEjFZVe9E3kndfllNvOXzARBCVAWoj7+9o3YSp6UT+Qtexsl
 pn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774017706; x=1774622506;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QcH0uThvj0OwbtgaciluWQ94LA2SpO28hcpjq2xkeq0=;
 b=Izwvnkz9o5nsNmuM9lNxYSJNW+l4e37HgGRg5D7Yl8CboKjVz7KiJ7c6s4duCVQEJO
 rnCTkIsUw9RwvnwQ249MlRNKz5a0g+EU/03Gs4GfA9lrCWMnBHsUq9Ov16ObUiVhlQ2b
 bK1YWCbzmKqDHPahWBflURIi0WlZRvm0Pq+7N1fStbppl8zDKVcbPLeHV1JNPXKaeI5f
 8bnoT782kCnEzu/0mGmWmDUH5GUrEQM2tR8s/v4pSJN1KSiryaGdyn4nhqHv+vrbX9ho
 8Pqg7gNbVS4/2G/J6qP25AHeGECE1r7JEA0zkS5W/EF6WIHSKFyUz4LzXSr1PwSc8zcM
 iaJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhfzRk9EFnQgoNr6STgJ3aWy3SCCi5r0xivTwcVnpm7mMQMw1P4yqeME6WwC02M0nCK7ExegFTkOQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YypG3dPA/G22yCH5IglRAa3C8xjFrBoW3nVOOmSEHP2SIx81DgC
 vmiGzTZcggiDkR7WT9zVSeKlgpXAFtZlQZQV2tkywQYQryphqyzH593H
X-Gm-Gg: ATEYQzzCQmXBgXtT9Q4WIFP2gt9MVPs7CqCAHkZSJx46eyD3zGYsDq0h0PQPKDDHclA
 BaRp/au/bF+fygS+9PeBPRbELTKN2qZmiuWmZPmV7JI10Fnj5J+dKc+DivWZ/I7y8FImgObp++n
 nt4/7MgluLyOz0tcA43/37zcje0fE5sPgiOMtHpGlp8JzYLr2o6Kv3osEUaycrgwfO4mtPGKeL1
 sBzSxONIDe6lWxtXm00DDGmipsbnooNFN2qOwa+PDT5NDiS02PSsFLNMzoN8cKAKg+H3GcARro1
 AcJz0mavZzzLCcRSKvU16j6Q1FRM5gFwNw6Ol+FbIsA17da4+i2zQ75dig4G9uuMiJFTam5P2c7
 YECNONzjqfRUMu73/xl7o8YnWqR4tCtWkKOKYfZbY7X8BNEdNhUXvfIkvysMJmHFPC+fyDM4550
 f3zGf1DJqFtn24CeqZYk7HfqlC0SURULZzl/c5XDfCXPtBeVzryrg03YjvAefgOAw=
X-Received: by 2002:a05:600c:5248:b0:486:fdba:f5db with SMTP id
 5b1f17b1804b1-486feb5d82emr55320655e9.0.1774017706082; 
 Fri, 20 Mar 2026 07:41:46 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-486f8b1fe65sm130648835e9.5.2026.03.20.07.41.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Mar 2026 07:41:45 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH v7 0/3] Add support for the Samsung S6E8FC0 DSI and M1906F9
 display panel
Date: Fri, 20 Mar 2026 16:41:37 +0200
Message-Id: <20260320-panel-patches-v7-0-3eaefc4b3878@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33S22rEIBAG4FcJXtdlPETNUsq+R+mFh7ErTTbbm
 IaWZd+9JnvR4EURhBG+3xnxRjJOCTM5Njcy4ZJyGi+l0E8N8Wd7eUeaQqkJB66AM0Ov9oJ92Wd
 /xkxVp0LUCMEwIMVcJ4zpe8t7fXvUE35+ldj5cUgGzNluscfmeUsV65JG6gMTRgNldLH96Wr9B
 87zwY9j/7JGO5uR+nEY0nxsguxAWWTStpEJ5dEpzZxj0mNw5STaVkGwiqxNnFOex+lnm3FhWxe
 PcbioxlkYBap1qzh0UuvYnd4Hm/rSxLAlLfxfzYtmTtkgNQuthFqLPy0Yr7UoWmEwHkAFcFhru
 dey1nK9G71z3IMX3tS63Wtd67ZojF0XteOmPFyt1V7Xn2BR66tZAZ5H0yK4vb7f778yoVBjZQI
 AAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774017703; l=3536;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=50tiwvglNxbyBlgetkc1oq4ZzZhktrOLX+44zsu45ac=;
 b=JsopaJdRW44W8oeIbtsI7vKkqeMl6iCEMEL6N6v+uTn8PqIzcMtEu1cQ3vLRaf8Vx7J9sMNdc
 ZAc6FAmLU3HD2t0DIm3blqiiyPdsam0HzDhN+d/c02SVtjrpK86HYy/
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
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
Changes in v7:
- Mark as DRM_MODE_TYPE_PREFERRED
- Link to v6: https://lore.kernel.org/r/20260318-panel-patches-v6-0-7a30c2f85e0b@gmail.com

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

