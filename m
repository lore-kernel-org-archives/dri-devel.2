Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 811BDCA5FCE
	for <dri-devel@archiver.kernel.org>; Sun,  4 Oct 2026 16:31:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A3E4910E13D;
	Sun,  4 Oct 2026 16:31:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UXnGQf2c";
	dkim-atps=neutral
Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com
 [74.125.225.141])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB32010E13D
 for <dri-devel@lists.freedesktop.org>; Sun,  4 Oct 2026 16:31:29 +0000 (UTC)
Received: by mail-wm2-f13.google.com with SMTP id
 5b1f17b1804b1-49d1fb0cf5eso9515955e9.3
 for <dri-devel@lists.freedesktop.org>; Sun, 04 Oct 2026 09:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791131488; x=1791736288; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4K1u7HAUlwlZgokElVxrzMuDxi7Yuc8MTskvjYgWwtc=;
 b=UXnGQf2cqcc647rrxWkmXQq8tL2zNePOiJdFdx33LjWnWSSYaqjZerjMd6YY+KKnmE
 NWskaNn+Cb3+/OvMFGLsHTzVArr82p+Trpo0dtwFPtobjfSNzqodMOaOHWdHYd4woJDk
 r3Nff84XiCYftfR8D1VhPmoOTXG/pFc7XAnofdzZBb/Jo37/nLuVFaGmqXyHs5XkMGex
 kRGKsMPu/ez+SfOJ4vRzDGqHwrFH6eBUubdclqRzqL+/sfaPjNrj1oI8I/cDgHi8BGF/
 L2DgGaLPNk3WFySK8TXrI0vPU2/xOYbG6x2cs7ia9Q3xzuTtOm+lOcXeHXnVnNe4fz+x
 Ws9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791131488; x=1791736288;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4K1u7HAUlwlZgokElVxrzMuDxi7Yuc8MTskvjYgWwtc=;
 b=TiqzSLejVFG14LFIQ8hMNdliYvdpH1GxQYGXGyw5RoXZBVTHayClz/DyS/tUQp6tnD
 qDuh98AofytvdlZQheT5mY3Evrz/XP2O8InoAvp9Kh0nFs+EuaeilwSsA4SjpvJH+Nzp
 dgXtVEm0z0ThbmQXWRDRIW8Xs6Sr1SXXzx2y3IJM44rK5IECFN1XXXhnH/kw54sDdFNb
 EzaPowGHEN6rultKCICnyVPPhVCbpB0MIPU6X87wkcugVn5hI8BRX+Jz6+2NdOCegkou
 P/SbbKW9K1x0hHSbkxcz6IIaLAoC+wpOUvys6tl8gKnXJLKWFbYmXaWmiBqRjuWaaX2o
 Qgpw==
X-Gm-Message-State: AFuF++meOI8JaeMaE9sreYAdPUkQOoR16qhT21H3mEChdfWFbTPnWSlt
 7gVgYFpEWuhidkCiBhWSXU/0vJC+k0om3ywlq/4pwGLRawk57RVIm+zk
X-Gm-Gg: AYBFou1nYZwfBd/Ho6JhBY+wN7RhKjmfJ1VZmCnBCA1IuusXYxgHbIv2lXVBorFEkq6
 2COyGCiB5CktnagmRi0RuOduGwtUUjSGFPJ7gFsa3PhREMpcq0pHves3qsdm1FLYf+ti0AMTGqH
 0D3KHwxkpMGh08cctLaghbr+ciZ45OulvIFegSXe7o3zRS0ATsVKs0UapFSjqIZPa1G0kxzkyIG
 VfP6kGuYk3vBYOGviYnrFc5XDn7h2cQphMPBddQTh2G4ttFwgpn3nzlJC47EIpWky0NTlLlB7g/
 zIoDbFRozDbzRNSCZWnDWl0uQ3T7ufbjfr5gvvs4NR9DbB9xR4CS3EraE4nHRziwW58lSAcOAcU
 qtCkEjHQnlKWsO2EoXEG3RR5DEhWhqa4RT/Oz56Qit3W78tgFcScMCqXz6RI6UX2wy8RCSJxhjA
 8B1vnCzVFYQknSlgL9WBs/OrXCmFKIQCRG4KDEnIsvPbKPd0JV0CI2awQpeaCDvrTHx35xJMSUI
 kMXdmAm/eIMj+eFO+A=
X-Received: by 2002:a05:600c:a011:b0:49d:17d4:aff2 with SMTP id
 5b1f17b1804b1-4a0275107e2mr140690815e9.1.1791131487995; 
 Sun, 04 Oct 2026 09:31:27 -0700 (PDT)
Received: from xeon ([188.163.112.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0316b2524sm315365035e9.1.2026.10.04.09.31.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 04 Oct 2026 09:31:27 -0700 (PDT)
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
Subject: [PATCH v2 0/7] drm/tegra: Add support for Tegra20/Tegra30 8-bit CPU
 interface
Date: Sun,  4 Oct 2026 19:31:07 +0300
Message-ID: <20261004163114.181800-1-clamor95@gmail.com>
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

---
Changes in v2:
- convert enums in the dc header into definitions list
- add check in RGB if bridge_state is not NULL, if yes, use default flags
- inverted FLAG_PIXDATA_SAMPLE flag setup logic since default value is set to
  be on NEGEDGE while v1 set default to be on POSEDGE
- 8bit-cpu schema renamed to dbi, removed compaible and set as DC child
- expanded list of required properties
- 8bit-cpu bridge remodelled into dbi interface as DC child
- improve gpio handling
- rework attach to get drvdata from parent
- add panel supplies description
- split panel driver into per-panel drivers
- get DBI interface from the patent directly

I have deliberately left GPIO parsing from device tree since it seems to
be the most convenient and mainstream method of working with GPIOs.
---

Svyatoslav Ryhel (7):
  drm/tegra: dc: Expand available registers layouts
  drm/tegra: rgb: Parameterize configuration based on bus flags
  dt-bindings: display: tegra: Document 8-bit CPU parallel interface
  drm/tegra: Add support for 8-bit CPU interface
  dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and LG
    LH400WV3 panels
  drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver
  drm/panel: Add LG LH400WV3-SD04 MIPI DBI Type B panel driver

 .../display/panel/hit,tx10d07vm0baa.yaml      |  58 +++
 .../display/tegra/nvidia,tegra-dbi.yaml       | 143 ++++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |   3 +
 drivers/gpu/drm/panel/Kconfig                 |  27 ++
 drivers/gpu/drm/panel/Makefile                |   2 +
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 297 +++++++++++++
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c     | 236 ++++++++++
 drivers/gpu/drm/tegra/Kconfig                 |   7 +
 drivers/gpu/drm/tegra/Makefile                |   1 +
 drivers/gpu/drm/tegra/dbi.c                   | 416 ++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c                    |  24 +-
 drivers/gpu/drm/tegra/dc.h                    |  50 ++-
 drivers/gpu/drm/tegra/rgb.c                   |  41 +-
 13 files changed, 1293 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
 create mode 100644 drivers/gpu/drm/panel/panel-lg-lh400wv3.c
 create mode 100644 drivers/gpu/drm/tegra/dbi.c

-- 
2.53.0

