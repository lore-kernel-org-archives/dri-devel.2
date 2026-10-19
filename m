Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6874CCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:57:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C80410E93D;
	Mon, 19 Oct 2026 09:57:32 +0000 (UTC)
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D3710E4D5
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:57:25 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-48b060ec084so1243753f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403844; x=1793008644; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7COsRHRwbFZs67dB0peGMQf1r+S9Yv4n+CsneXuo9SU=;
 b=pM9u/11geQeDWVXqd+1B7nBK1rbKHSzOCxv/lweyiZIA6VmEnD0yqOdVNG60oKM2J0
 XAoax2IGEIy0Cu5UY3TPZ4eF4nslKAltb6Xv+yIBTTkPL2RWnAtEZ6RLbpVV/cjCh2Cn
 p8I+Hd1Oh0SWWvViSv1e37qckqbRfSzGiGONjDZUUWQsCh15QvAMZZ6jy/XA679RVAuT
 hp6wcDZadgHKBzRGdlMYKbkJFTrpmO1B/bpoW84RY2bSREElYXTYysf59Q54KnjJ0CcH
 +maIMH6P65dHGqlGAon1Wk7uM5+nJJTunltXJcNYmHDwIQcASIpePz3V1PaPBh3NSONe
 6jZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403844; x=1793008644;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7COsRHRwbFZs67dB0peGMQf1r+S9Yv4n+CsneXuo9SU=;
 b=AKey6bm7nY6Eg3fHRkfuQk8YXTLRaOCcWSXj2v2KE2N4cIaEm+Kv3NK3Y7ZI3hwc/f
 vn7CUn/FBOPUZwfpSEewU4jnV+ndrtAL9Krg3nE+F3zclkAmZxgOio99OFadDO4hH2OS
 3sviXnuDtHlA7NdC9hDuEPYx9Ql5OODOFqrM/6gG4Wsh9MmmZxaE36YjamR2U69CWkaB
 MhA6gk8vxsbZ/Bqk3J+1KK8ceDH3bjdQNvgBRNTih4WManqDb1YScio8bbwIN2EY1QO3
 8TuxAcYfst9PPLJfn6P3i5ciHDheNKGFC+V1aDjSKuKUoucsSrZhmCtGspKbvBf/Kqs6
 02qg==
X-Gm-Message-State: AFq9FYLJ+1cv8bTxxxzKdEUMAwBJg/gJRJWhnRYfn+qdw2Mkt7YzkX+k
 YgW2jPNrnika7ZnByLlqb98SKtqtRtR/48+WhP5z7Eq/yPkpjWCGtfm8
X-Gm-Gg: AYBFou3AexfVDkEEJuwtSC+DMVD8L5PgF2UIU1+KAvi3FyfhOEHGyMZFLkqDZg0aqCE
 HFjrG7SxT6LQnejUzGahLLHvzzZgO6BmbPveL1C/IoBBWMyNnBJGJ1vKsxr9/Nd4Va2d1N7aWg4
 W0qrWuh4Ho479kfh6qWtB6mRezH4wS3QFJMyjGVOunuJsq2/Ms2FhRPLdpFrbXSaClQ1xV9trKJ
 u8pSayCMHszkJTzDkHObsO+SNqNLplkEs8SyV9kfi5e4odnznf875u6ApHD0Eteo9SO770Ngd7z
 r+3bk3waCySzlmSlK1lAsS/M90oUX9WZhaPlObbEnehB2nC5ofDBJ/MRlz7acNWu9At7/hJqcSD
 vCzNBF/RitDJWTV1ScpblHx/PXs4eRSSC/1VNQgYHuBjCn/m8NKFIF8ygAhuJnhkKzahgY2edIJ
 7daF7SezHB/niH/R2tqDqqyb5h00mLj5OutRrnDM2VvPZQxBYHmEYGvqXVWQBRmtMCwGYRsOZuY
 Lw4T7WdwgHAmHGrHfM=
X-Received: by 2002:a05:6000:468d:b0:488:80d0:873a with SMTP id
 ffacd0b85a97d-48e07978df7mr9786078f8f.5.1792403843556; 
 Mon, 19 Oct 2026 02:57:23 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd500e75sm21740089f8f.42.2026.10.19.02.57.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:57:22 -0700 (PDT)
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
Subject: [PATCH v3 0/7] drm/tegra: Add support for Tegra20/Tegra30 8-bit CPU
 interface
Date: Mon, 19 Oct 2026 12:56:58 +0300
Message-ID: <20261019095705.91062-1-clamor95@gmail.com>
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


Changes in v3:
- rgb: fix default bus_flags to match original behavior
- dbi-schema: remove compatible from required props
  remove dc@54200000 wrapper from example
  restrict dbi nodes for tegra20/tegra30 only
- dbi: remove unused idx from tegra_dbi_priv
  wrap dbi registration in dc with devm_add_action_or_reset()
  separate dbi into separate object
  export tegra_dc_commit() and trace_dc_readl()/dc_readl()
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
 .../display/tegra/nvidia,tegra-dbi.yaml       | 138 ++++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  15 +
 drivers/gpu/drm/panel/Kconfig                 |  27 ++
 drivers/gpu/drm/panel/Makefile                |   2 +
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 297 +++++++++++++
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c     | 236 ++++++++++
 drivers/gpu/drm/tegra/Kconfig                 |   7 +
 drivers/gpu/drm/tegra/Makefile                |   3 +
 drivers/gpu/drm/tegra/dbi.c                   | 415 ++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c                    |  32 +-
 drivers/gpu/drm/tegra/dc.h                    |  50 ++-
 drivers/gpu/drm/tegra/rgb.c                   |  41 +-
 drivers/gpu/drm/tegra/trace.c                 |   3 +
 14 files changed, 1312 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra-dbi.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
 create mode 100644 drivers/gpu/drm/panel/panel-lg-lh400wv3.c
 create mode 100644 drivers/gpu/drm/tegra/dbi.c

-- 
2.53.0

