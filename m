Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE6BCD5BAC
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 14:46:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C986510F35F;
	Thu, 21 May 2026 14:46:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="yUwkDl6H";
	dkim-atps=neutral
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com
 [209.85.216.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8442510F369
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 14:46:39 +0000 (UTC)
Received: by mail-pj1-f43.google.com with SMTP id
 98e67ed59e1d1-368f25ff4c4so3284224a91.2
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 07:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779374799; x=1779979599; darn=lists.freedesktop.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=MYcMfa9UmKpbrcq2eKdzXRn9iD3DzK0oC+yU6GOGJbQ=;
 b=yUwkDl6HOIWoMw6upUWrtpygT2FUYWdVhOtnpaPRyWPQS/2uVCDAxRFuibMH21kx2s
 vnwidJXtRurhYwFJc5Ln0oRIyHUeH9JSMIRY9rBrH4xDuOcicXjZ0H1mTUbKbGvnIEuo
 rPwV07jhQADxssL2Uks7imp2r0iF0IzistJnMeqwS07gnaXh3h1soZ2eIokILsKm5oDs
 zmDqpeq7JBKZGiohHv/RBl/NS9mB1EbuUcXDsqLI4RgvoU9tonRRLbj+HKgRcKBTGUEx
 yG5XTwihBUs7uBuwxdOW6+L79SZJ3ZPsnbUXvZJ/+X6KDCF3RdLcdmbtrE3u1BG2A7AO
 UayA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779374799; x=1779979599;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MYcMfa9UmKpbrcq2eKdzXRn9iD3DzK0oC+yU6GOGJbQ=;
 b=XuDd42aIfj3YdlFXE+L4rVi5oi4eporcRQq2Ge9iVznauooZ7YOhzkjDZf/7QDitcJ
 7LhlCVlLfDXQ5C1MohJ/RA5qK4d+SMWR3Tq7Wc56+dMDqt/hGkbKYmI8CX9g4pI3KxDO
 ksL3Bn2CfA1pp8HdwnYrR2Cj6DVnOJhIDSSZeIdCOh6Pp5yZ941rK9/gPanYNw+1+vRB
 Fz4uRACPX1l0QTvV0lF3HEG4EvXTLZIHO2iI4Nmhe2Q8BrJ1TCRVLSgoNKaBDqhMwCL0
 HiFT8K54et46/jeGw+gcC5FFAonwED68+SLKRhk2ZaQ6RnnZr8NZKgHUT/RqszmpWQdv
 MuMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/AkLvrmwYz7u+7V+qSgDXQuCoKUEt4WucNqZZ3osZ7hCJ9A2IU9fDeDAv88GYP83zM3wD53TxhMnQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz/x2/p85XVk1ZJOzdhgGZ9YtYVlIfAcgkfXWe3hMzUQjFEZ5cK
 4M38F5RHQi6zg2bD5/HvilD6yTyZLsPxl5JXPnl7ZsUOOxAHbaJRLnMdRlcJiETIOqU=
X-Gm-Gg: Acq92OHERs7TB6dMrGXyEMzYVb2uP2iH47p7dOiLnsgxKHUo2k2DFtM0zXisrP0Dw7z
 r3rmKrzK6j1QAf6cI3NA0mflR2bmT8cKdnGQNeifh2c+5cTXXg0qgQb0esP+UlZiqFXFAYH7tMe
 R6+9WuaQWKI0oJMv+3crImr7+DlDdF3OjK4S+2AE1OHiorZ1SUV4N4VIuWirKCDv07C2aCfe0Kt
 UhJadt+7QS7elsHcZ27FuVBWrQNqpyebSZu4PuZpyBJ7DRVm8QfkukgSlzzggLi7+Y2t28X1lR7
 tQRPl8ny1P4xkYYhpTc39BZeZE82mId4BX5ax3KNLiRTAqZVoXpT0dOD0cGT0ZU61ISmkECqc/H
 W4SyR0zehauyE+UM9klqPeKMq9LCpr35xdN6f4h8ky3ZQqETYQDa+cdAlbWihM45J9nFvJlUgwH
 zcYN9e
X-Received: by 2002:a17:90b:578e:b0:368:6a6e:94dd with SMTP id
 98e67ed59e1d1-36a4577cf96mr3442038a91.24.1779374798897; 
 Thu, 21 May 2026 07:46:38 -0700 (PDT)
Received: from [127.0.1.1] ([2a11:3:200::109e])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-36a5bff3ef3sm476527a91.4.2026.05.21.07.46.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 May 2026 07:46:38 -0700 (PDT)
From: Jun Nie <jun.nie@linaro.org>
Subject: [PATCH v4 0/5] Add support to 2 panels in bonded-DSI mode
Date: Thu, 21 May 2026 22:46:02 +0800
Message-Id: <20260521-sm8650-7-1-bonded-dsi-v4-0-a4dd5e0850f1@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKoaD2oC/x3MQQqEMAxA0atI1gZqmTYyVxEXOknHLKxDAyIU7
 26Z5Vv8X8GkqBi8uwpFTjU9csOr7+CzLfkrqNwM3vnogh/Q9jEGh4QDrkdmYWRTpIU4rORSHAl
 a+yuS9Pp/p/m+HxErmS1nAAAA
To: Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 freedreno@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Jun Nie <jun.nie@linaro.org>, 
 Jonathan Marek <jonathan@marek.ca>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1779374785; l=2436;
 i=jun.nie@linaro.org; s=20240403; h=from:subject:message-id;
 bh=9/4X222Ffhg6qxLQzzfx1T7bWcnktGM6AwovaxbqqjY=;
 b=/WKxz3iXOXS5uf1GNcLWawLpDSfY6swFLXN24AUeDm+crBP+skomIhxxoU8jLwoiGj3q7hP1k
 OgvdCnEyzLnB6puoNidZaS2wb/hzD24i+mXd4X9wALv1DEvag78eMwX
X-Developer-Key: i=jun.nie@linaro.org; a=ed25519;
 pk=MNiBt/faLPvo+iJoP1hodyY2x6ozVXL8QMptmsKg3cc=
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

The 2 DSI interfaces may be connected to 2 independent panels in bonded-DSI
mode. Horizontal timing and DSC configuration are adjusted per individual
panel in DSI host side. Support to multiple slice per packet is added for
the device setup to test the usage case. A panel driver is included as an
use case example.

Changes vs v3:
- A panel driver is added as an use case example.
- Move dsc_slice_per_pkt to struct drm_dsc_config.
- Polish commit messages.
- Link to v3: https://lore.kernel.org/all/20250924-dsi-dual-panel-upstream-v3-0-6927284f1098@linaro.org

Changes vs v2:
- Polish commit message to describe usage case and requirements to
  panel driver.
- Remove changes in device tree and add dual_panel flag in mipi_dsi_device
  to pass information from panel to dsi host.
- Drop the register programming to DSI_VBIF_CTRL, as no issue is seen
  in latest test.
- Link to v2: https://lore.kernel.org/r/20250220-dual-dsi-v2-0-6c0038d5a2ef@linaro.org

Change vs v1:
- Add device tree binding for dual panel case in handling frame width for
  DSC to avoid breaking existing dual-DSI case.
- Leverage Marijn's patch to configure proper slice per interface in
  dsi_update_dsc_timing().
- Polish commit comments.
- Link to v1: https://lore.kernel.org/all/20240829-sm8650-v6-11-hmd-pocf-mdss-quad-upstream-8-v1-0-bdb05b4b5a2e@linaro.org/

Signed-off-by: Jun Nie <jun.nie@linaro.org>
---
Jun Nie (5):
      drm/msm/dsi: support DSC configurations with slice_per_pkt > 1
      drm/mipi-dsi: Add flag to support dual-panel configurations
      drm/msm/dsi: Support dual panel use case with single CRTC
      dt-bindings: display: Add Synaptics R63455 panel support
      drm/panel: Add driver for Synaptics R63455 DSI panel

 .../bindings/display/panel/synaptics,r63455.yaml   | 125 ++++
 drivers/gpu/drm/msm/dsi/dsi_host.c                 |  33 +-
 drivers/gpu/drm/panel/Kconfig                      |   9 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-synaptics-r63455.c     | 631 +++++++++++++++++++++
 include/drm/display/drm_dsc.h                      |   7 +
 include/drm/drm_mipi_dsi.h                         |   2 +
 7 files changed, 792 insertions(+), 16 deletions(-)
---
base-commit: 6654f8f33aa6229a90d4401519a62a2bf96cb851
change-id: 20260521-sm8650-7-1-bonded-dsi-7a7d5b70f687

Best regards,
-- 
Jun Nie <jun.nie@linaro.org>

