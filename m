Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11BF8C982D8
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 14:40:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 509F910EFC2;
	Fri, 18 Sep 2026 14:40:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="1PxKRDr3";
	dkim-atps=neutral
Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com
 [74.125.228.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56FA510EFC2
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 14:40:10 +0000 (UTC)
Received: by mail-ej2-f12.google.com with SMTP id
 a640c23a62f3a-c254f9f7dbeso98864666b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 07:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1789742408; x=1790347208; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=LkU3ODIuhAAsu4O/XI/NDvqsvZfMhywu2ET0wE91o6o=;
 b=1PxKRDr3m1qhG1iFSIB3nrrq92OXP3M8nRoyim5TuogiMKvweA4sN8EeRkTietvYMU
 7TQBtibsxnyAdTwzPNkiYLCGgue1ybZauU9JO+sMkakw500AXJ3E+5VeDkyhP8k4Du/C
 J22pZfNM5ws8b+6tF38JAajo3skyLjiNRFqU0ziJLeaOV1qtpc0PxS6xBF1Tyl76qx0E
 jcEVZIQj5uqUMKNb3RSYicaXK0qoU1aJsb4ahdmzWjb0bkQVQzpQWliqQD24nWSMxleL
 kdt2loWgu7rPUR6c+CPU5DYvIn1tA+wZEocHfE5Qg/G4NoNBayK9J0A8nFdqabMRar9W
 O9ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789742408; x=1790347208;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=LkU3ODIuhAAsu4O/XI/NDvqsvZfMhywu2ET0wE91o6o=;
 b=cnwAkeBZ+1nwZPB8KLGoUtLF/csN6hGgzjm43v5uxRzRFGPFXgvd/YBn39t85Glc7d
 GIK5ilah7Fk878vaQUNJg/UjH1iymaQGiyoeT8k67L4ebrntbIm+56f9Ou95p8Zo/dDO
 NQ/OD3cNTa6u8tjrFCUkwgMbzFGc2hsoCfYOqIhGlRMyQngm39mUB4XntsY0IK3T32h+
 whmUYEe9AqhqAiNRg2daAQdHIWCdzvmgreafIs2W3ySTRfHBcfk80hQeLN/+/RNpuioF
 KGDbR79QnAuuFpiOb1KZ29zJ7UUQN6jZziEFoc3Tq9f9IwxiL0LtZV+kpg1HZJZvbbI7
 5ydA==
X-Forwarded-Encrypted: i=1;
 AKwUvBwbkHM3X2B2/TbasggbQtxk8pz0bqRxkcb6hzBXXSJ4SBwgFLom36tz6kCdDCVFLJsqSI9oHl48X+s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nlW47s8piAYSnX0dYmoKUbgsXeW/B/czmDOIhEXapNeeYOnmwr
 QNrdsI+K4SyF6G3IE8WI9TbK375kI4uiw1oSRoEnOBlYS93GxjpKWnZQcU+ksUdjdoM=
X-Gm-Gg: AYBFou0eoAsNKUYgi5Y1cWoDPMknsOCUOVYXFuNCsCYo5/JQbJ8oEzFE6dvR4Z5bLEv
 1O/qLTJYz7IOcf6rrfBnGdarIseXMWwIz14to4wO8zBPCiuicauKxECAekZjXnOLdVAuYA8BGCR
 bufGoz7o5BBSwhFEqGwyWTcoqPgzNhxgE0HBWo40OmcggN5FyAxH7aOXsIavVyJWAv77IkuK+AX
 XOU5hY/RKHBcTcwoOt/Vh9ZBJZInxbpl7TYFT8+1gfWHRmMiyn73wvH0h5Vq2ah14rw59Pm99HR
 ZwKsZrtt2RJCK8RhVucxlf+Dyde9tgCQH/hf58wZnUcqevmKJABcQLnq0sJ9aOBXFB5NQzxiIfQ
 kDk19S6DQ97VDWsuecx7AV85r8drlMMBACYSssp/ynGdb7DUBz3Iqwx45FngQ9QET9OAQR1TFcW
 2rMRWzbun3HTB1e02viv9ucHuAZJyWdaRjmy+5zCgkqBPaPoG/7LruZKHATobcveKbuunir6y+g
 IZkMJLU/WMJutRDQZph3T8tUAEXBmq1rdknO2QyMym3oO/f4grRtA==
X-Received: by 2002:a17:907:c0c:b0:c24:b11c:6c05 with SMTP id
 a640c23a62f3a-c2a156d58bemr272513366b.14.1789742408589; 
 Fri, 18 Sep 2026 07:40:08 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-138.static.ef-service.nl.
 [144.178.202.138]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2a1b7a369esm64244966b.9.2026.09.18.07.40.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Sep 2026 07:40:08 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/4] Add Novatek NT37705 panel driver for Fairphone (Gen. 6)
Date: Fri, 18 Sep 2026 16:40:03 +0200
Message-Id: <20260918-fp6-panel-v2-0-6695c4008920@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22OQQ6CMBBFr0Jm7ZAWBC0r72FYlDJIjbbYFqIh3
 N0CLl2+5M2bP4Mnp8lDlczgaNJeWxMhOySgemluhLqNDBnLSlYwjt1Q4iANPTBv80IJIdqzOEL
 0B0edfm+ta72zH5s7qbAGfoaj1xifhF2DRnpCZZ9PHapkOqU5OpXDet1rH6z7bMMmvsl/NkwcG
 RITqmFFWXClLp3UbuitoTRmoV6W5QtDUYv85AAAAA==
X-Change-ID: 20260501-fp6-panel-3d35c999d894
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789742407; l=1177;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=LnOCLi1t8Bj2U3X4K5t0uslhmFfyG1Xu8O7lRIkja+8=;
 b=tfhs+1QCTPakQSMArYo3Qc5awfvXxVAu3VGhjGKoN6x8OFEeUZqKsENV2eUvrbAJa1KfOq2xd
 HzlZhifolmUDnRaQt/+PIUiu+kBtH7aTfKxlNwGmF/x7J+aPtz4RCd8
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=
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

Add bindings and a panel driver for the NT37705, and then enable display
on the Fairphone (Gen. 6).

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Fix kconfig dependencies of panel driver
- Pick up tags
- Link to v1: https://patch.msgid.link/20260501-fp6-panel-v1-0-e09cb05651cc@fairphone.com

---
Luca Weiss (4):
      dt-bindings: display: panel: Add Novatek NT37705
      drm/panel: Add driver for Novatek NT37705 panel
      arm64: defconfig: Enable Novatek NT37705 panel
      arm64: dts: qcom: milos-fairphone-fp6: Enable display

 .../bindings/display/panel/novatek,nt37705.yaml    |  72 ++++
 arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts   |  64 ++++
 arch/arm64/configs/defconfig                       |   1 +
 drivers/gpu/drm/panel/Kconfig                      |  12 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-novatek-nt37705.c      | 413 +++++++++++++++++++++
 6 files changed, 563 insertions(+)
---
base-commit: c2cd463d6ee7d55a3ec0719d93c49ff99022d58f
change-id: 20260501-fp6-panel-3d35c999d894

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

