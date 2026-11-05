Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C17BF606A32C
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fvX309Cp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0BAFF10E225;
	Thu,  5 Nov 2026 14:05:48 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C95610E225
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:05:41 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-48e20ed3b9dso1663039f8f.2
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:05:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793887540; x=1794492340; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ds7iJJ/yi21YzzuAvjdYkQJHWhK/UE3D72nBbDoPfLQ=;
 b=fvX309CpPeQwucgNriekSx0LaO632mQOAis4SSUbFiyUhv1cLJFB9uHC6pLiMiBoUB
 F7MeKDMCTqV+cA+vuMLFygtyoluzjX68j5Em5sG77melJ5WUZdhEHn/cmaGQ4wAd+POg
 zA2IyQmE/5zdootnaaCMiRROpcgEq+uaAKfb79Eu1tOVslkE9ttoCUjyv0lf9mgONqaW
 e2GsDE/dLOUn6AXKHbQaiLyzsfTo+RWXRuwNq23lfsNeFgwFwh6/z1GxmJaqpnhPBpsT
 Gn7AkFCWnXyo/OW20BznZGTRE0yRyXSMdU2XDJPglo2CeonJpQm9KMU8WfUIuKaV4RdH
 h1kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887540; x=1794492340;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ds7iJJ/yi21YzzuAvjdYkQJHWhK/UE3D72nBbDoPfLQ=;
 b=lx2JGybjzsF1Qu9Fgx1o03DJuSuypU9rSf7EweuZkCsKkuPXWQKfqDMI+UyD98sWAO
 KPKkZAYZauzULR/DJFQLyE91DaGTYD2RljaoscSGReJYpNBXnvpSnDkbz1zEnqOV63UW
 B7kEVqIv2CHb4xpGBJ8wrWDfPG+V3zKuxGoLkNamqO8JG276vUXZHKfVZ3VooAMKkoN5
 eHVTQWngbszqYGHRjy0zScJnlGeTQCVE1fv9POorXDxZk9I0+t9LZb1AKxoBqyqVzKPE
 L/pKK9cYsWuwGOaBjKKE4tk0IQiM6iYszSyqOog8vb5l99iYci4539lDzT5okUA3qX/L
 xLsA==
X-Gm-Message-State: APuU4Z9P/NjTp3EN9QcTnxAQRWWa+/+0gJc6Q3YzwlbvOd4CcL8r0wK1
 7ihH6ky4UGohZNPOcaUSMSIYjSlVTi7j/HBriHCStZK43dO6NVZNkpO/
X-Gm-Gg: AYBFou2kXa1YEH5BLXBtTpp8xT0Hsx0cLW2aGA5tJSYWqAgK7od+ZyTcykoCV0Lgorn
 tt2zUgaPAsd93GW2ggtRZdwoi7op2HDNq8wktt/++01wQG1xjohYiVwFek5P+gkiR8da+DjVK2/
 CAwX9SvEJin1Hnvpu8ZF4xDscLmEk+tsfwSIitzuqe8EL5rei+5EmYMx+ioyqRz9ahr0OWHEi0p
 HbVtNeAzgbQR4b61K+3a4w7F0rbDYvFRMgZHfPh7QwngUgkFGgBqaUEBG7KY5vS7QUalsplE3/G
 DvoNrNwWQN7U+ItVoYpUbzLsKg9i9lKIbj42JODhTZuzqdgrlCAdlhDzlGa31QvfsGQG0WOoSIQ
 RwpOAJMXapozAwIEx1G+bUXSShuCZaZVeOcPMTg+V0WRmNoFVy/Y/6o6HKRMNdPAIShXIhENFPZ
 iwT4Nd+IQ+B4OK2L/qC2FHEIdZXZ/UDtjIfVM07KwtNQWNLC06oOVPOCGxyBGzVxY0JVX+ij+9E
 QhgvkXTfgvS6LNCN5lN+WABep7le9/38TncDV2I6gtWqSgDPPvS3JvT8Uh1CjweNZXh9uBKbuHM
 oaLOA1C7F2YDJDMO4jI5PBkX9r6Iy/sVbQfLjFFD3jHHHdqFcx8uPjcv11VzUUbjbiPNuP8=
X-Received: by 2002:a05:6000:1866:b0:491:83e7:32bd with SMTP id
 ffacd0b85a97d-49183e7341bmr3868887f8f.50.1793887539738; 
 Thu, 05 Nov 2026 06:05:39 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed92a753sm11454111f8f.45.2026.11.05.06.05.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:05:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/10] drm/tegra: Add support for Tegra20/Tegra30 8-bit CPU
 interface
Date: Thu,  5 Nov 2026 16:05:00 +0200
Message-ID: <20261105140510.165165-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
that closely resembles the MIPI DBI Type B protocol and is referred to as
'8-bit CPU'.

Add MIPI DBI bus support along with 2 DBI Type B panels used in
LG Optimus 2X which work with the 8-bit CPU interface.

Convert rgb, dsi, hdmi and sor to use atomic versions of
drm_encoder_helper_funcs needed for bridge state requesting.
Refactor and expand DC header. Add DC parametrization options
needed for fine tuning by bridges. Make panel parsing by
tegra_output_probe() optional and document optional DSI port. 
Add 8-bit CPU interface in form of a bridge linking to RGB port.

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

Changes in v4:
- reorder patches to avoid errors on checking dbi schema
- dbi schema renamed to nvidia,tegra20-dbi for consistency
- fix DC_DISP_V_PULSE0_POSITION_* > DC_DISP_V_PULSE1_POSITION_*
- add MODULE_ALIAS
- swap width and height in panels
- dropped use of init-sequence and gpios
- dbi driver reworked to use only DC to operate pins

Changes in v5:
- added commit modelling DBI bus (suggested by Mikko Perttunen)
- hitachi and lg panels converted to mipi_dbi_driver
- dc header refactored and completed
- added commit documenting DSI controller port
- added commit which converts drm_encoder_helper_funcs to use atomic
  enable/disable
- added commit which makes panel parsing in tegra_output_probe() optional
- dbi command/data converted to enum
- dc com pins are now backed up into drivers private structure
- magic numbers replaced with pin defines
- dropped tegra_dc_readl() from tegra_dbi_pin_set
- tegra_dbi_pin_set() accepts boolean third argument
- tegra_dbi_write() second argument converted to use tegra_dbi_dc_signal enum
- used field_get() to extract pin value
- extended comment regarding init sequence
- nvidia,index > generic reg property
- adjusted tegra_dbi_atomic_enable() to properly handle shadowed registers
- switched to use of_drm_get_bridge_by_endpoint() since panels are auto-wrapped
  into bridge now
- added support for mipi_dbi_host_ops
- added resource managed helper to register DBI device and provided to DC via
  header
- dbi.o built with all other tegra drm files

Changes in v6:
- improved descriptions of new framework
- mipi dbi bus commit authorship was changed with Mikko's permission
- panel commits swapped with mipi dbi panel conversion commits
- fixed tegra_output_probe() for hdmi
- added CONFIG_DRM_MIPI_DBI select into CONFIG_DRM_TEGRA
- devm_drm_bridge_add() moved into bridge probe to avoid possible issues with
  deferred panel probing
- setting LDC pin to V Pulse 1 moved before GPIO pin reconfiguration
- DC_CMD_STATE_ACCESS is set to read and write in tegra_dbi_atomic_disable()
- platform_driver_register() does not error out if driver is registered

Please, keep in mind that this series must be applied on top of
https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
---

Svyatoslav Ryhel (10):
  drm: Add MIPI DBI bus support for MIPI DBI Type A and B
  drm/panel: Convert Hitachi TX10D07VM0BAA to use MIPI DBI bus
  drm/panel: Convert LG LH400WV3-SD04 to use MIPI DBI bus
  drm/tegra: dc: Refactor and expand header
  dt-bindings: display: tegra: Document Tegra20 DSI port
  drm/tegra: Make panel parsing by tegra_output_probe() optional
  drm/tegra: Convert to use atomic versions of drm_encoder_helper_funcs
  drm/tegra: rgb: Parameterize configuration based on bus flags
  dt-bindings: display: tegra: Document 8-bit CPU parallel interface
  drm/tegra: Add support for 8-bit CPU interface

 .../display/tegra/nvidia,tegra20-dbi.yaml     | 113 +++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  22 +
 .../display/tegra/nvidia,tegra20-dsi.yaml     |   6 +
 drivers/gpu/drm/Makefile                      |   2 +-
 drivers/gpu/drm/drm_mipi_dbi_bus.c            | 256 ++++++
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 167 ++--
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c     | 103 +--
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/Makefile                |   1 +
 drivers/gpu/drm/tegra/dbi.c                   | 576 ++++++++++++
 drivers/gpu/drm/tegra/dc.c                    |  15 +-
 drivers/gpu/drm/tegra/dc.h                    | 859 +++++++++++-------
 drivers/gpu/drm/tegra/drm.h                   |   2 +-
 drivers/gpu/drm/tegra/dsi.c                   |  22 +-
 drivers/gpu/drm/tegra/hdmi.c                  |  22 +-
 drivers/gpu/drm/tegra/output.c                |  52 +-
 drivers/gpu/drm/tegra/rgb.c                   |  72 +-
 drivers/gpu/drm/tegra/sor.c                   |  20 +-
 include/drm/drm_mipi_dbi_bus.h                | 103 +++
 19 files changed, 1851 insertions(+), 563 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
 create mode 100644 drivers/gpu/drm/drm_mipi_dbi_bus.c
 create mode 100644 drivers/gpu/drm/tegra/dbi.c
 create mode 100644 include/drm/drm_mipi_dbi_bus.h

-- 
2.53.0

