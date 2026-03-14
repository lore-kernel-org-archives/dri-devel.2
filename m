Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57A00D58B1B
	for <dri-devel@archiver.kernel.org>; Sun, 15 Mar 2026 11:21:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E134A10E555;
	Sun, 15 Mar 2026 11:21:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="U+/n8gh+";
	dkim-atps=neutral
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com
 [209.85.128.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3330E10E18E
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 21:46:28 +0000 (UTC)
Received: by mail-wm1-f47.google.com with SMTP id
 5b1f17b1804b1-4855dbfc129so10811795e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Mar 2026 14:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773524786; x=1774129586; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Bh7FZS1WHQ+R8ev12RVDamAIZTNW5FHsYgbvpBRxNek=;
 b=U+/n8gh+sw/kLyvnTXdxhWfs734xIe3ADKfQmf+ypU7SemKygOn2/KxItn+IQIReDz
 Yq1l5nouYNwv+7Z5yowdaPNXyjx/LT6SYGCmwb0f9yRPsdkpEZ01AgnHQQ+XvzCZqoD1
 79LKM9JSmxNyHrJxN0Or8/O+rzpovryUW+Pm/4V6KMxAypFRhlOi252eVFh5MCSHAbM0
 xolZHX+KHhvi7U+B5o3vmx7ts1bIL4pkmO/AeuXlgc2rJH7Heu6EMtUzkYyp6U7QwWWp
 Ng4kb5TyeaLJnm5kdLb3SzYKxIKGEJWc0AMIGTfkjy8syDXHTRA/wEf8WybzkGdX2px9
 qz3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773524786; x=1774129586;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bh7FZS1WHQ+R8ev12RVDamAIZTNW5FHsYgbvpBRxNek=;
 b=R+SpSdCmWPOsXAfCQGlvmtVZM20PQ/NCIbKMnTpz6F7ceHu1CoFieiPN3knAH30ndh
 V6RBfLxotqM5rnAZgaOcQmn0sA3GwY8CYwg/aSxj+MLBSDdddQ+B8aU0urMGnzoymoxW
 hW9FnRjH0E3fvCrpg/refKYZzF63XD4XX2rp25/e911nQ1pjBXRyneHwGOZDLCKz7EsL
 986Jaf7eW4vYa7ya4NTWfd7BlOFvcPMQc17gI1qfFT+lm0Qtcxlqs9W2Z84Fq79YA5L2
 V8FQrNT4rDON9yjst5cJDuatPxWBmF6wF7VAh6fFEwF0kBK85z5LfxkNA7j+I89ByhGQ
 chWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSzI2BNLzGCwJ/pGP3YtYcmab+4ol2WUCUJA47iwvdQ+P6LkPzcPYiNVpTA6iU2X+5uFBTB072q/Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw5wr2K2gWFhgaJzwyRDwGyC61+YkUSPcm32MwlBXj+V8YQf95h
 WSAr2BPiO6ABKYQFldy7vgp2OLI+v87Rrjm5ooFG7xXfu2a3ngjWCdgl
X-Gm-Gg: ATEYQzz76FiqH++CdCOx48jw+ZD/hnY9smSF3Q4pz5kBH+ZTwqxVsJ3LOu7kjFk9Bmy
 BaTWU1Y7IG9lPXBHy3O36CUFaKQCvZOGRo/2qFMimNNMs1adzRTrsmxX5V/mSz6+xFO3BpiGWLu
 6zebSCecdPr+iD8bze4GueQow5LDD/Iw+U/ntt/9FlEQJZqsSR28Dv3R4vTCAm//ABqwNWe78wW
 om0n848Ti+neBHBU2LQqBynpiAOji+R9dEriv6zGHbyWK9hzl/1vC4PoFOTmTsQ8IZ7Mn9yWvn3
 kzDHyxi/XUfVtCXhKGkp1Mm43lrCr/F9GEM5rNNeiYXnJUlqK9Ty25r6CvMDlS9bHMksebRlAnN
 +hYZ+V3O2KyxvdIysD04djXsaiQlxYEoe9kKEsZqU/le0m65CEH5EQs0CYgvpa5lrY5JtulS+R9
 BMGNIghJT13mXP7GEnfIvQdIyQxAJgN73x1Eaa/XZ6JD5F9DPcbUUxvxd6GBH/l/zvKqA9ZExj4
 Q==
X-Received: by 2002:a05:600c:a4b:b0:485:3692:e8f7 with SMTP id
 5b1f17b1804b1-48556707ddbmr131089695e9.25.1773524786521; 
 Sat, 14 Mar 2026 14:46:26 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19aec5sm28756221f8f.4.2026.03.14.14.46.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 14 Mar 2026 14:46:26 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH v4 0/3] Add support for the Samsung S6E8FCO DSI and M1906F9
 display panel
Date: Sat, 14 Mar 2026 23:46:20 +0200
Message-Id: <20260314-panel-patches-v4-0-1ecbb2c0c3c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Py2rDMBBFf8VoXYUZSZZsU0r+o3ShxzgR9auWa
 1qC/72ys2jJoggEd+Ac7r2xRHOkxJrixmZaY4rjkIN6Kpi/2uFCPIacmQChQWDFJztQl//FXyl
 xXevQGoJQIbDMTDO18evwvb7d80wfn1m73I+sp5TsoW2K58Mq96cqZU4oKwMc+Wq782T9Oy3Ly
 Y9j97KrnU3E/dj3cWmKoGrQllDZskWpPTlt0DlUnoLLl9aWGoLVbC9xjWkZ5+9j44pHi/scIR/
 mrMiBG1NqAbUypq3Pl97GLpfoD9Mq/qVFptFpG5TBUCp4pOUvLVE80jLTmkLlAXQAR3/pbdt+A
 LTXkXCrAQAA
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
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773524783; l=2780;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=wQWIVAu3Y4jDHR5DBLOkg+dc0hKAQmR/KU3X139W63A=;
 b=kaHaVx1CkItxr7tsnvLvlHc6nISme3slmuCrzRKlt3I2KBENyh+3rgK8qjI47fQGbcrORQvCK
 cuwBDvT0pT8CYMSZEHREfM2DaP4OWtx5KPC4TDgylEoBND0mDoO5I0z
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Sun, 15 Mar 2026 11:20:58 +0000
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

This adds a driver to support the Samsung S6E8FCO DSI controller with the
M1906F9 display panel found in Xiaomi Mi A3 (xiaomi-laurel). The driver is
generated using linux-mdss-dsi-panel-driver-generator[0].

The mdss reset dependency makes the screen work more reliably.

[0]: https://github.com/msm8916-mainline/linux-mdss-dsi-panel-driver-generator
Original tree with patches: https://gitlab.postmarketos.org/SzczurekYT/linux/-/tree/laurel

Signed-off-by: Yedaya Katsman <yedaya.ka@gmail.com>
---
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
      dt-bindings: display: panel: Add Samsung S6E8FCO-M1906F9
      drm: panel: Add Samsung S6E8FCO DSI controller for M1906F9 panel
      arm64: dts: qcom: sm6125-xiaomi-laurel-sprout: Enable MDSS and add panel

 .../panel/samsung,s6e8aa5x01-ams561ra01.yaml       |   5 +-
 MAINTAINERS                                        |   5 +
 .../boot/dts/qcom/sm6125-xiaomi-laurel-sprout.dts  |  94 +++++++
 drivers/gpu/drm/panel/Kconfig                      |  13 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 .../gpu/drm/panel/panel-samsung-s6e8fco-m1906f9.c  | 301 +++++++++++++++++++++
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

