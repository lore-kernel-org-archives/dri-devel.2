Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1741FCD0DA
	for <dri-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:28:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1317B10E743;
	Wed, 18 Mar 2026 08:28:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W9Q7UAJB";
	dkim-atps=neutral
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 01FBB10E415
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 18:50:39 +0000 (UTC)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4852a9c6309so50448985e9.0
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 11:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773773438; x=1774378238; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uA0qxfka/Y3eM0ZhGmlhGPF6D8joeTIH700meAq2tEw=;
 b=W9Q7UAJB79T+Msn4RoJKuk1jK8X2rOKTUx+ogObGsaqxss4SohxksyihyKEE1y5JWB
 3MhJ/TGvguOLeD/T3AgNWpqFWNBFHdTrPrvXA1Ay9P5KoYaL6VMNpM385zkLHyYjOjGY
 JDRhMzHNTnzQCc6b5tg+DbDLp02sImbx6xVgi3xAiPnWbEL7HZJc6zCSr6v9BfoZOnQT
 rrXZw3whVt1BVsMDAXtZIiwICCmcYQo0Y+sS6umVjOyxCy+Vpw0+LRb1F5K/jWLvgifN
 Rnuk5pz9QVa0R4/ZsFHfea2qO7oQWWtbi5IyZEH/b7rcWUd2NpD3vqO1FcOn3IeqcpH7
 8jLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773773438; x=1774378238;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uA0qxfka/Y3eM0ZhGmlhGPF6D8joeTIH700meAq2tEw=;
 b=dByFtUB4o6jpvBRXE04TscL1MubhDtqo84zo4zUitikig5bIvkEc2j5RHHGQAGmUnm
 qof6c7d0axelhNW1wkJIczONYjuCNRZ2WyrY1EvoMhLcfYz8IzOG+22BGpACSi0DyJKM
 id3Wvvxu20RayN5zvmQz/LxFkPyVddlnr1j8g1Lw7FhRp274JoYjbpjbikj1VIHulYv3
 AXgA6fZlsleCr+g+vqxg/ArZkDyefo1IuZnLhikC++I35LpZ+tA8F0pbBYvmEn2E+aSF
 LAEKg+LiffJsSkuFTSJxdK0i3zCVjJaFsn8ig/0Nb8XtSLAHwHSQ8CPZUHEK0SS4ARg+
 oshA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV+1As30zVn8X0DDMrAjoWltgMRLoc+PkRkAoyjCqHF3yjV3mnIjsyn2pm0We/OboKUJANlYOXM0xQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz9mkRHYHRhAuFKd0LaQzdzv3/zm0KvHLBAU6Jb1ggwm09r03QI
 i6QTOS1M2n2o43SmMGrV/TDhLMeCFUutN7VIDNIsnrj4n0Vzs2/b79Ol
X-Gm-Gg: ATEYQzzmGb41DMKwEnHedoMq0DT21VpUaqLm8+qs8VDyQfifvAIB+AiulAqvReXQtkK
 rXi2Fgt50SG4u+LNXaPqM2HP6N9fn9h64z8fyoic7iFqBb8IOdc+kpLEphL5inMelLruCIFcflA
 4BUerecjXjFb+4FjLhhJ/2C9tNFjHmSq3QK/kE6JRL/5m7Lt8xS6xaOTUtSVQKUThLr64RCpoJZ
 kWtEZuUK1E7i/yhbS8iWcSYDnvRAlo8CyXR5ytDwCebkMOa+Eo1nvWrof/qXL+nJlCMJbjSuVxf
 +x+ycPkxoa2pKX6GaGFCIsj9eIYt32JXBdXROjp9QSFPI7AbaZLRzD8Kn6ujJLZT1wfZmKi9mIk
 IL4sJN0ebUqgvlVFGQi1zjsW7mHucKqx+EX25awcXg2BW9NiC8XJBwIwGWAwSWfbCIT0Mq9Ufy1
 6iOivjEf+fHZcdPEMYRAMdZrJqKd4VvkytzqR6LbGgzQpoJogdzDstolKm7T5mzoSOPoK13AF9i
 w==
X-Received: by 2002:a05:600c:4ed1:b0:485:4526:ee05 with SMTP id
 5b1f17b1804b1-486f4441081mr10695865e9.19.1773773437854; 
 Tue, 17 Mar 2026 11:50:37 -0700 (PDT)
Received: from [10.100.102.17] (89-139-129-65.bb.netvision.net.il.
 [89.139.129.65]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4856ea8fb0dsm152863595e9.3.2026.03.17.11.50.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Mar 2026 11:50:37 -0700 (PDT)
From: Yedaya Katsman <yedaya.ka@gmail.com>
Subject: [PATCH v5 0/3] Add support for the Samsung S6E8FC0 DSI and M1906F9
 display panel
Date: Tue, 17 Mar 2026 20:50:28 +0200
Message-Id: <20260317-panel-patches-v5-0-ef99f7b280da@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Py2rDMBBFf8VoXYUZSZbsEEr+o3ShxzgWtePUc
 k1LyL9XthcNXhTBwAyco3vvLNEYKbFjcWcjzTHF4ZqX8qVgvrXXC/EY8s4ECA0CK36zV+rynHx
 Lietah8YQhAqBZeY2UhO/V9/b+7aP9PmVtdN2ZD2lZFftsTitVrk8VSlzQFkZ4Mhn251v1n/QN
 B38MHSvi9rZRNwPfR+nYxFUDdoSKls2KLUnpw06h8pTcPnS2FJDsJotIdqYpmH8WTvOuKbY6gi
 5qzMjB25MqQXUypimPl96G7scol9Ns/iXFplGp21QBkOpYE/LP1qi2NMy05pC5QF0AEd7Wj3Ta
 k+r5W/yzgkPXvrqmX48Hr+xJHKY6QEAAA==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1773773435; l=3212;
 i=yedaya.ka@gmail.com; s=20260113; h=from:subject:message-id;
 bh=d+erWziCMFo+IZCTJWIretx4qqOIlSPd/ntbpB1RdVI=;
 b=9WaL/1QuDAAOGVmJEXVKP0MuOnFe85n4TW5v4tp6IwboMIhZx7BbadBbgqADRzp3D3xtIoRmD
 dE6dp9a+i9yCAMdAD5N/hklvKbSBJI5WXt/oKr50gslxAHG6htMptfY
X-Developer-Key: i=yedaya.ka@gmail.com; a=ed25519;
 pk=CgNmxD3tYSws5dZfpmJfc6re/bV/f47veVijddHLytk=
X-Mailman-Approved-At: Wed, 18 Mar 2026 08:28:25 +0000
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

