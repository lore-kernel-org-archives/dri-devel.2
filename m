Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD63606A8AC
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=f3z7LXJb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CA6210F275;
	Mon, 16 Nov 2026 15:10:41 +0000 (UTC)
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com
 [209.85.218.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B54AA10E409
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:10:34 +0000 (UTC)
Received: by mail-ej1-f52.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so610059066b.3
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 07:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794841833; x=1795446633; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LbqgOhVybNkMwnYCeynnQ6YccVR5nx8I+2FxMfh6a2M=;
 b=f3z7LXJbCAcZpQy8+ENz2WjmjWpJxT8M93/yHKm329lCRxHpX1OGK1Bl3FF8TLhGJ7
 n0KpimkN2u2ZbjXZE4Om01UVv6MzgY84OkH+lveg+hAHqLSFZc0kQJhoLHEFvVLGJRv1
 Q7cLWHccx/r0uP+BpESkKmB5pPEqB5c2amDn+8JrKGXq5YFW/raw8nn8vgyFSS1RVlWw
 l8p38ddk5EdjezdK9c2nXlNlp5URVtAf5bjhkuf8yCn/n6BTMS84KyBV/GZck+mAbMFV
 HvDscVkDSY9aY8fw7bYqItRdVrwthl9KkzUGk5WYSjop/hyBM19FzEzaM0uy55h8tx4Q
 dKWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794841833; x=1795446633;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LbqgOhVybNkMwnYCeynnQ6YccVR5nx8I+2FxMfh6a2M=;
 b=Oyqv5/Jk4BzlqVidkEHc/l5Ycuk0VDRZPSdoQ7AI3jWrMftCKRNgmrDKoXnXe7m5KQ
 IgeRM1WvOGdB67JETPhN+5pMKBSKtG6CFGP72hOs9RJi+lQMAPyfMxx9hYqRzsQo6j8e
 wnq0oYv7NXF2Qia30jJxBxcB7sWuzQJC4xByZlKUs9CGO8CAPy1aXqSImXxGE57V3gTy
 jb8EYaLk+2RlgmJUzDjPD3a2XsAaeQ93E3fDLyZ0Lw3XgpxbD6Mx+eB0pyn2yGD1PzRL
 lWxJBB7WmLk8Yrk26ZZsODTSJJmyxEF1Sbt7DrID11375NePaHg5K+TfuCBq4YE7At3C
 Eymg==
X-Gm-Message-State: APuU4Z9lEkqHEUxRhzjz5FmEdDpjBflEXBMrJzQhtHOQTnXVL6WtR+qP
 +X0EfvMEB3Tx2sJweyWWG8nZrVl59qR2p81HV9AzHRK0rfrQ4koeePtY
X-Gm-Gg: AYBFou38p+zD7KrOx8wzVbb3UDCk2LKGgZk7N5qGzSFA7vLBSgY0pMwmxpFz3T47shv
 mYz7z5xvUefYBd2g2AagIoXBSO+kJsyDBvBigIZDKDY+3mXUIr08M8BcfzuHzvoaswGfT+1ZiuJ
 CdXfUp4xQbozq7p2xF2zDcHsGlWfTNBtGpqnW0bCVJOJ5IDfllQzfFPtBNiCbUym+BgTYTeNgN0
 9c8T1v48FCDyzghJM+mo9a/hnNUeYNSl24NOhtdQlZSCwayHxwwi1IjKa/C1ZwPNJwMccs/Jg5t
 tOSA+N16KpEpz6fBkKJkhcUK5lHtITdPlzliAOv+PV+w4Q1DIE2ARZ8dOguNyb4mvNlsK8C0mxo
 mGDcuu+G+DcpehactQVKv037dHBzrfXEiA9+AeAP4UjaHTINvgOAb9yW3Gy2nfpaByYU6EuNUT7
 +I6sRl1nkclPMDIH+Tb9jPFwMia0skXAkMbF9cA39bf0yb0Inrxnkn47rIoME5TnIBt1AJaAxA9
 o9RMc37fBDUgvYorFryN7Uc0Nwbky0wlKTui83mIy5CdMpp0TFPGhn9vdsyMeMbSOtngt3mzPpY
 qWL342sOi20Y1UCry+Jvqp0ob6oNcsO0IFTE6p+bASLo7epX/8aQF9GBGAehwXmY4aHegxCzPC8
 8FH0+m+AsNQ==
X-Received: by 2002:a17:907:3e8c:b0:c3e:ee86:d2c with SMTP id
 a640c23a62f3a-c5096343b6cmr963645466b.27.1794841831798; 
 Mon, 16 Nov 2026 07:10:31 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b93a85sm420868466b.84.2026.11.16.07.10.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 07:10:30 -0800 (PST)
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
Subject: [PATCH v7 00/12] drm/tegra: Add support for Tegra20/Tegra30 8-bit CPU
 interface
Date: Mon, 16 Nov 2026 17:10:05 +0200
Message-ID: <20261116151017.274764-1-clamor95@gmail.com>
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

Changes in v7:
- reduce changes in the panels when converting to mipi dbi
- dropped of_node_get() in devm_mipi_dbi_device_register
- remove enable()/disable() operations and add prep prev bridge flag
- drop add DC header changes, add only strictly needed by the dbi
- dropped tegra_dbi_iface and reg_entry enums
- dropped reg from struct tegra_dbi_priv, com_pin_backup converted to u32
- interface dropped from struct tegra_dbi_interface and init call added
- BIT macro converted to PIN_UNMASK in the tegra_dbi_pin_set()
- init functions and tegra_dbi_interface structure moved before probe
- tegra_dbi_atomic_enable() split into pre_enable() and enable() phases
  to squeeze interface into existing framework
- DC_CMD_STATE_ACCESS and setting active true moved into init functions
- reg reading moved before bridge allocation
- reg renamed to nvidia,interface

Please, keep in mind that this series must be applied on top of
https://gitlab.freedesktop.org/drm/misc/kernel.git (drm-misc-next)
---

Svyatoslav Ryhel (12):
  drm: Add MIPI DBI bus support for MIPI DBI Type A and B
  drm/panel: panel-hitachi-tx10d07vm0baa: Convert to use MIPI DBI bus
  drm/panel: panel-hitachi-tx10d07vm0baa: Drop redundant disable()
    operation
  drm/panel: panel-lg-lh400wv3: Convert to use MIPI DBI bus
  drm/panel: panel-lg-lh400wv3: Drop redundant disable() operation
  drm/tegra: dc: Add elements required by Tegra MIPI DBI
  dt-bindings: display: tegra: Document Tegra20 DSI port
  drm/tegra: output: Make panel parsing configurable
  drm/tegra: Convert to use atomic versions of drm_encoder_helper_funcs
  drm/tegra: rgb: Parameterize configuration based on bus flags
  dt-bindings: display: tegra: Document 8-bit CPU parallel interface
  drm/tegra: Add support for 8-bit CPU interface

 .../display/tegra/nvidia,tegra20-dbi.yaml     | 108 ++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  15 +
 .../display/tegra/nvidia,tegra20-dsi.yaml     |   6 +
 drivers/gpu/drm/Makefile                      |   2 +-
 drivers/gpu/drm/drm_mipi_dbi_bus.c            | 258 ++++++++
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   |  35 +-
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c     |  35 +-
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/Makefile                |   1 +
 drivers/gpu/drm/tegra/dbi.c                   | 551 ++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c                    |   4 +
 drivers/gpu/drm/tegra/dc.h                    | 197 ++++++-
 drivers/gpu/drm/tegra/drm.h                   |   2 +-
 drivers/gpu/drm/tegra/dsi.c                   |  22 +-
 drivers/gpu/drm/tegra/hdmi.c                  |  22 +-
 drivers/gpu/drm/tegra/output.c                |  52 +-
 drivers/gpu/drm/tegra/rgb.c                   |  64 +-
 drivers/gpu/drm/tegra/sor.c                   |  20 +-
 include/drm/drm_mipi_dbi_bus.h                | 113 ++++
 19 files changed, 1397 insertions(+), 111 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
 create mode 100644 drivers/gpu/drm/drm_mipi_dbi_bus.c
 create mode 100644 drivers/gpu/drm/tegra/dbi.c
 create mode 100644 include/drm/drm_mipi_dbi_bus.h

-- 
2.53.0

