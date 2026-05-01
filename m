Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4442FF8864
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 07:15:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77FDE10E1A9;
	Fri,  1 May 2026 07:15:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=fairphone.com header.i=@fairphone.com header.b="D76o9oL/";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B8E710E1A9
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 07:15:24 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso14135625e9.3
 for <dri-devel@lists.freedesktop.org>; Fri, 01 May 2026 00:15:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fairphone.com; s=fair; t=1777619722; x=1778224522; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sI6xBikbSzlLlr8+nu1EBDSADrRpoTvBTYV2Ibu2fTc=;
 b=D76o9oL/PoQtnNFLrahEZCUspXXoMQwh87LrXPMCFQuyHUlyZcEwtPFzbYRkaEkZkg
 JD9cwpmh56s+Bd5WLidYO5N6PuvBgjx73rZN/AYz9WMesB6h6+ADiI4F6vEDkhnUne1A
 qeqKT/lEuQrtaR49Ypfpu2DNxTiyJL/sG0SY7Y0WsAJ0Ywd+2J7r2hOskNqfir7u0fmF
 0FzkKbzYesv/grE0Jd45atj6+O1Wfhbo+g2L1IDjJnk1w4r3s2v5I4ez6oqmojqnWpsW
 +zmn3MkOGmAeY6xz7UEg/TcihQUhmotGh3LALZw4tTGDmPpRzx+L+Be0JFEY7XI/9vDB
 +YNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777619722; x=1778224522;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sI6xBikbSzlLlr8+nu1EBDSADrRpoTvBTYV2Ibu2fTc=;
 b=WxO7sAQc1BV1rgkjLnaadosUQEWnF+VG0JgBtaug2NH0ERREfTlGb41NTrKXmmSbnL
 vJsJQLI7s/eOa9VCB+VXtBWBIIwR1ms31HM0VaGl/EifzWFpDhM9//D4Vj3K80ZTotwY
 88Q0A98V0mqgr8LR8zzXCPBXy13x9Rmc2txaqMjYBfS8u8oyS7Qpomilfepum4+EjOFu
 EpNjV9y2ntAHYsVOeBcaR5SpatTF9Tubd39TY4+/PheHr3lEalpTe8mGWWoMNYOHI65y
 NAKBxFdJo4g7ekRZCqunTaylJukFYAMOjtcSgRgbiE6l0ytHJhjdysRMlUJ+FOObGa2W
 D+Iw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Xs4zAFh2KULvpaqMaU3NN/fL7MA8V9Dbvlbj8EfQYPgYVVv9qSu/EOeHPCqBh66/Bh5t3jaVsnoI=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy4C5vc7Lo7L1/PcaUW9Jkx1Y8XE7q7t5i1sw9atl8z6BSoTEoW
 RdygE5YHl7HJQtl8fRCWa91F5kb+uEb4ShEFv1wDVjYb9Nhl/+O/LAewqkDyIz6dvOI=
X-Gm-Gg: AeBDietOqTs0oI7Gx7BjPgxObiF9iFhTTYFdcKwbhsjPJfVk8Twp9kFnov8IfbOJV6J
 JDOp3rJ5r6fBWvqzdWY7KKsf9UpGAg26DnKrusnLEadmOY0w8CobmO4BKC+ObKk4B08Bkb+Vbmj
 342TiJ8CHcQLuI5q29laAbHB1kVLs+EnJKSvZwYumHduvLligaYnAlhgut3gHgzAlDQeAzMQsEt
 ZWLNx4anvE2wHKz/KOdp6DJqlxnsx5svnG6khXsbBhZBFVJ+TrmzgGpfAXO8fYcTWUM91mLjsDL
 KRDBtkgRWTkYrONXllyHhvZUoZq5R9BTXsI7CajAdZ5iCbzTJyBmXY98iFfguo4pTFC8UdPlGgd
 E876B3ltTK2o/PpElEc2ZIL3W+wVtiFhlDfjcUUSyVpgqEsb2e3Wa0E16q/vgNhqbPjzTw6Z+H2
 SMT+NBhmPhrpH24rlM+/BpWxdiSobOatuWo2EvNSDlr7Fs8wP85UZ+LsVJEL7Lcy9WYMRhOxnbi
 cT9xNYJ
X-Received: by 2002:a05:600c:16c9:b0:48a:906a:9050 with SMTP id
 5b1f17b1804b1-48a906a912cmr8140525e9.10.1777619722469; 
 Fri, 01 May 2026 00:15:22 -0700 (PDT)
Received: from [192.168.178.36] (046124199213.public.t-mobile.at.
 [46.124.199.213]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a8eba8487sm29668085e9.11.2026.05.01.00.15.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 May 2026 00:15:22 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Subject: [PATCH v3 0/9] MDSS / DPU bringup for Milos
Date: Fri, 01 May 2026 09:14:42 +0200
Message-Id: <20260501-milos-mdss-v3-0-58bfc58c0e13@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Pyw6CMBBFf4V0bU0ftBVW/odxUWAqkwjFthKM8
 d+tGBcal/dOzsmdO4kQECKpizsJMGNEP+YgNwVpezuegGKXMxFMKC54RQc8+0iHLkbqLDNa6ko
 ao0gGpgAOl1V2OObcY0w+3Fb3zF/tX83MKaOlksZWXDedq/bOYph6P8K29QN5qWbxwTWTwnzhI
 uNNq3Za76RTrf3FH+9pAS7X/F567yONjUDzfcBUFyMsia7yUrJMPJ7h1v/1GAEAAA==
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1777619720; l=2542;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=u4AOHqSTtzBSQJ6HpCIkCjUSJffdHCdBxVASoG0gP9M=;
 b=GgAn3RCm2XTRW5OjQ+9yxLpcVCl8ULnaPfWJ+XpSU7o4jODj3CqRfHbV30ApXcp5M9nxIWxiw
 kAlD0wRlopCAlpDgkQ4p7NOWIyErcqyzn9fo1la+zMw9s7OPySz6Ezj
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
Changes in v3:
- Use "contains" for mdss-dsi-ctrl matching
- Fix dt_binding_check for qcom,milos-mdss.yaml
- Pick up tags
- Link to v2: https://patch.msgid.link/20260327-milos-mdss-v2-0-bc586683f5ca@fairphone.com

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
 .../bindings/display/msm/qcom,milos-mdss.yaml      | 286 +++++++++++++++++++++
 .../bindings/display/msm/qcom,sm8650-dpu.yaml      |   1 +
 .../devicetree/bindings/phy/qcom,dsi-phy-7nm.yaml  |   1 +
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
 14 files changed, 852 insertions(+), 2 deletions(-)
---
base-commit: c9bd03db3e792a99e9789fde20e91898e3a29e8a
change-id: 20251219-milos-mdss-fa0763693775

Best regards,
--  
Luca Weiss <luca.weiss@fairphone.com>

