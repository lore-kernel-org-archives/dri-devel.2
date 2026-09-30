Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F143CA5FBB
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 07:05:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9462B10E042;
	Wed, 30 Sep 2026 07:05:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="IwfRP2uA";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 960AE10E042
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 07:05:56 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-482f63546c5so4420181f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 00:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790751955; x=1791356755; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=l4ypwwp7JTLk+2ivLn91M7UclGnNz67wo1x4IhoVtME=;
 b=IwfRP2uAUI15yZCmZTF86FbLyxtP8jlrgRf7wLOtcl4L8i6Hv1+ZBmNowjD/Nvdxnx
 12qDuvJAgLoaNKBsJcSVn8gc86fF/PaKq9JubUWgAAM3cv05OYvUEdrDwE/10m04oan6
 WV2JsnZq3JnWts9OVOYXMFFUDCGIDbQCzKi7cqNQiBaDobWj6DDfozJd9bjy1p5EGIFX
 XU+umADx/uqGCQZtCjRWNQ3K952pkr9tk+nF0egqfWH/Ka2jz9uWFiyMiC/kJXxxqzUT
 ZhWk3Tva7MNqyPCPL3ziCWuXu3dMFUOJlcUh/3hLT/2Bxl/BptjU1mbz9SBs/ojmUC0w
 WG8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790751955; x=1791356755;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l4ypwwp7JTLk+2ivLn91M7UclGnNz67wo1x4IhoVtME=;
 b=gywBD7p2BKOsZn0eZMe1IB9r6paawVowN77/0RlrpWxx49Cygj7JefQ09X15/tionQ
 OYsX+bHtMhM5hAI7izvUkqdthofFAs9lXEn9/cns20pM6+nXOd09C1faAtD8OXMKYz0k
 e+dulSNMCLala72un/2WxbmQsSBLoTPVpkuzQOFM9OPpSM7oioX7bRpns2Pjpng9tzKZ
 94rV9mb3C2qU/EscJ9DAetcknhq0js+WKKkF+q/4t0GMskioLdyL0dVMNPwuFTWthddO
 irntLe6DYWYQ28FiJXutHlOY+NMSCOGqQBRCc2yHApACd4hH5QHMH7DJrof8crlDiJOg
 t3hQ==
X-Gm-Message-State: AFq9FYIiVq+Aw0wacANLVtKLmL4rWR08RI2oT4yoWVBxhD+aLUzpkMgV
 gEkeSc0Q2ONuBVF4F6kf4Y84dw0xlbalWON5s8tvkJiLe3pBm0HpQl1+
X-Gm-Gg: AYBFou1ziPDNrm4cEtggMB4XK3xcPkQhLNBgM7Byc40o6xr0+O59GXBz7MXXtptCOvS
 +qOydWYRNs54skL3ukD/UzCjyeC2SEI92BV2wwZARLJkpBut91qltN/tTb+LkKVIsH+q/auHi1t
 hrOED+eAvVv3HWzAH4wMP3OePD9qF7ZkpDn2CuZgT8klxnUX/DgQblMugahSP7iiVF6YSlNDLb/
 pwYXpaJXO2ZQVgplfWRpR9rqeYpW7IEC2JZWjODLz+6NG05xEV/HEU/YdpKb1GUv1EGx+i9RkuG
 rHNYo5aVN6PTZEB4FPLFRldlnb7JoNFhVtBnnB2ayW3rdriivgFI0gfLDIjL07bXH0KnP1679NS
 WTtMwSfyeBIjsGWfOTj0H1Z3Zjb5Vll83V4/2TXdcWOm2WIiq/tlWCevnlsp1zKA9GazRbLBZJl
 H0OItx2vR54YqoJmprDmSlSPFs+XpZt46eAGjIe0REMxj8QnqDKyBfp+j5faYIlE2mTaY3wcI5j
 UPUZFHW3/TpwPUR9+g=
X-Received: by 2002:a05:6000:18a3:b0:488:811c:c78 with SMTP id
 ffacd0b85a97d-48b024f7a40mr1076050f8f.32.1790751954748; 
 Wed, 30 Sep 2026 00:05:54 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f5bcdsm1145150f8f.27.2026.09.30.00.05.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 00:05:54 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v1 0/6] drm/tegra: Add support for Tegra20/Tegra30 8-bit CPU
 interface
Date: Wed, 30 Sep 2026 10:05:29 +0300
Message-ID: <20260930070535.47130-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
that closely resembles the MIPI DBI Type B protocol and is referred to as
'8-bit CPU'.

Add DC parametrization options needed for fine tuning by bridges.
Add 8-bit CPU interface in form of a bridge linking to RGB port.
Add 2 DBI Type B panels used in LG Optimus 2X which work with
the 8-bit CPU interface.

Svyatoslav Ryhel (6):
  drm/tegra: dc: Expand available registers layouts
  drm/tegra: rgb: Parameterize configuration based on bus flags
  dt-bindings: display: tegra: Document 8-bit CPU parallel interface
  drm/tegra: Add support for 8-bit CPU interface
  dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and LG
    LH400WV3 panels
  drm/panel: Add Hitachi TX10D07VM0BAA and LG LH400WV3-SD04 MIPI DBI
    panel driver

 .../display/panel/hit,tx10d07vm0baa.yaml      |  55 +++
 .../display/tegra/nvidia,tegra-8bit-cpu.yaml  | 138 ++++++
 drivers/gpu/drm/panel/Kconfig                 |  14 +
 drivers/gpu/drm/panel/Makefile                |   1 +
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 396 ++++++++++++++++
 drivers/gpu/drm/tegra/Kconfig                 |   7 +
 drivers/gpu/drm/tegra/Makefile                |   1 +
 drivers/gpu/drm/tegra/cpu-bridge.c            | 427 ++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c                    |   3 +-
 drivers/gpu/drm/tegra/dc.h                    |  54 ++-
 drivers/gpu/drm/tegra/rgb.c                   |  36 +-
 11 files changed, 1121 insertions(+), 11 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-8bit-cpu.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
 create mode 100644 drivers/gpu/drm/tegra/cpu-bridge.c

-- 
2.53.0

