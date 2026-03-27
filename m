Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 726D810F284B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 16:12:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92CD710EF0C;
	Fri, 27 Mar 2026 16:12:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="pnVcDU1j";
	dkim-atps=neutral
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com
 [209.85.208.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C43610EF0C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 16:12:32 +0000 (UTC)
Received: by mail-ed1-f49.google.com with SMTP id
 4fb4d7f45d1cf-66b0f489f3aso2634365a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 09:12:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1774627951; x=1775232751; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uI4iVL61EfDlecebQOI7GUlddKXIvzUTtydmWf5G7Iw=;
 b=pnVcDU1j6xLNQEVBb/b6hA99yGltP7WK/GvH4c/1XdEP9be+8yG8v2qtnExEuYgy/+
 InVU9O7N+xGFj0Y6xeluIRKx2uqCLwJKve6KD4Pk+izgbhM+ZnrCUibt24wJ2wDCDdXO
 BQK/70sGd4+fIy/fsLBoJ+ik+et+YVlBz9bi4R1JQL1k/GixNMPTZKpn+RIsr/wOflZl
 3Op7SRp9nHBpx4g9WXY0A1AXsGMWowpnharo5P3PptKaW7/3CP1SIkR3aVM3yvp8RKO2
 OQiPNKIjet456Y22btB+XztcPG+meCOPRIVhoy2xR4rKu/I+52SU+v/529CBGIWVuPdE
 lIhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774627951; x=1775232751;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uI4iVL61EfDlecebQOI7GUlddKXIvzUTtydmWf5G7Iw=;
 b=Bl9K9/yXOVCwgniFc7/2r/8AM3bsyvqN8N2sk3YwPtELa13TpFx7LOEUHBKpl+3stx
 ou9+uVJsy9a3ZyB9WHoPtM/wuAFjZbfcYWHcwCkwheixGZSOzIIwWnm6o/dpeUbs/gVW
 ZVJLh7EDMqtKhJEJsNXf/hFnv5xaE6FqyVxxx0HuFMANeck9lY6lidQrdy6siIGZ1ivi
 IqWzVt5X4QTYfZmDSQkgbvCtLlgu36Ys9Qb2K7LCbqsx5cpVO5HDI2SvQIvKPHfylU+U
 YpuXHFDurTB7FP+rSHAH74YB14k63koY8B8bHezzFR9UecuFTbzn0UYkyL5TO1A8Gdbb
 TyQw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUdl7vljc/vzsUcZ9f2DoIWE39dV3ThQV1R1lHkZeVRX4nILLFbdrAISpHy6+M8PFShhN0+f39RJeg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTsEsmMJiepDjVwRL/0gxysYCrRECC5DtClFfQrujLuKRlkPds
 ALlg1RoUOd/N4F/kt7/ve/0YqqpnA/V95bG0U4lYxg4MGWjbNJzDXtE9Mt7VwB7dQ1U=
X-Gm-Gg: ATEYQzzZ/q7bn4t/HGRuPwlptkpnjNfjsx9wbTcb2fvrVRWNPi3J8+ahXQgG6r994Xy
 +C0g8KJODtTRr+RxHvZLbL/rVNtbmtEYyTrkxxmp5DlRxoW2G7qoNFxyQKEAgZ7vczIrpS6Ky6s
 DFsW/M23E98AmOYrviYY8e24niDfuCScHxJWeYl8h+De+IX5jUYJwKuHExgHBWV/j4H6Wu5c1uu
 VLN6Kk4wyXbgMf8RUgUn7qHBP777EiDb2mmh3Y/rmGaA8O9H/QXuRCNpOhzp5vU08Yt/FEIU82V
 2X83jRPg/y8oFNdJFK7SwTdJmnbermvX3yyVcl0/ZOvG2VAEJapV+06LXO09SMQ6afG4O3Yd7QG
 lsZVKwtLiatgvkeCu0y4M0SGMb//B2AyEME08vXAiDdG4dKSH9+F/rVr6Kl7hHYvsKxsTPZyoqb
 3ebVDm+9BWWGCFfth7z2q4PFMy8I4hHmuf1CswvL1PUkhyhKEcqR2dMomth6DUnM+W5WMm9AA/H
 u8xOw==
X-Received: by 2002:a17:907:3e96:b0:b9b:171e:baf0 with SMTP id
 a640c23a62f3a-b9b50175870mr202321266b.7.1774627950599; 
 Fri, 27 Mar 2026 09:12:30 -0700 (PDT)
Received: from [172.16.220.101] (144-178-202-139.static.ef-service.nl.
 [144.178.202.139]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b9b20265cc0sm273518366b.15.2026.03.27.09.12.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Mar 2026 09:12:30 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v2 0/9] MDSS / DPU bringup for Milos
Date: Fri, 27 Mar 2026 17:12:19 +0100
Message-Id: <20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Oyw6DIBBFf8WwLg2PCqGr/kfjAnWokxSxQI2N8
 d9LddvluZN77qwkQURI5FqtJMKMCcNYQJwq0g12fADFvjARTNRccEM9PkOivk+JOsu0kspIrWt
 SClMEh8suuzeFB0w5xM/unvkv/auZOWX0UkttDVdt78zNWYzTEEY4d8GTZjvcEV7v8l8+BkhrE
 9By95iv1QhLpkWumBSqNLYvpfHBp9kAAAA=
X-Change-ID: 20251219-milos-mdss-fa0763693775
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Jonathan Marek <jonathan@marek.ca>, 
 Krishna Manikandan <quic_mkrishn@quicinc.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Alexander Koskovich <akoskovich@pm.me>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
 devicetree@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774627949; l=2322;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=10yPF8/VWMN/hc4QFl8Moeagof4tQyNFqpgYHI7SJQU=;
 b=9oPXoqG3XMqtp6BcyU4qHCegc+zNhFN7LJjx6NEN8RDodef5FFJKVS7qu7kmGmCyixaAYds8A
 jouuE+dbgNYAHi1BR1KXXYSNBeUJP8ywnCngw658VW+7vzKQ26JukT2
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

This series adds display support for the Milos SoC.

This is tested on the Fairphone (Gen. 6) using the SM7635 SoC (8bit DSC
cmd mode), and the Nothing Phone (3a) has also been reported to work by
Alexander Koskovich.

The panel driver for Fairphone (Gen. 6) and devicetree enablement will
be sent later.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
Changes in v2:
- Address comments from RFC v1 where it wasn't confirmed working yet
- Pick up some tags
- Add dt-binding patches
- Drop fp6 dts patch, that'll come later
- Link to v1: https://lore.kernel.org/r/20251219-milos-mdss-v1-0-4537a916bdf9@fairphone.com

---
Luca Weiss (9):
      dt-bindings: display: msm-dsi-phy-7nm: document the Milos DSI PHY
      dt-bindings: display: msm-dsi-controller-main: document the Milos DSI Controller
      dt-bindings: display: msm: document the Milos DPU
      dt-bindings: display: msm: document the Milos Mobile Display Subsystem
      soc: qcom: ubwc: Add config for Milos
      drm/msm/dsi: add support for DSI-PHY on Milos
      drm/msm: mdss: Add Milos support
      drm/msm/dpu: Add Milos support
      arm64: dts: qcom: milos: Add display (MDSS)

 .../bindings/display/msm/dsi-controller-main.yaml  |   2 +
 .../bindings/display/msm/dsi-phy-7nm.yaml          |   1 +
 .../bindings/display/msm/qcom,milos-mdss.yaml      | 283 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   1 +
 arch/arm64/boot/dts/qcom/milos.dtsi                | 211 ++++++++++++++-
 .../gpu/drm/msm/disp/dpu1/catalog/dpu_10_2_milos.h | 279 ++++++++++++++++++++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.c     |  29 +++
 drivers/gpu/drm/msm/disp/dpu1/dpu_hw_catalog.h     |   1 +
 drivers/gpu/drm/msm/disp/dpu1/dpu_kms.c            |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.c              |   2 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy.h              |   1 +
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_7nm.c          |  23 ++
 drivers/gpu/drm/msm/msm_mdss.c                     |   5 +
 drivers/soc/qcom/ubwc_config.c                     |  12 +
 14 files changed, 849 insertions(+), 2 deletions(-)
---
base-commit: 50f91f877c695c7ce6cabc3df6a892ab7abc6c3b
change-id: 20251219-milos-mdss-fa0763693775

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

