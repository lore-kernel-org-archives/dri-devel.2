Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 289A9606A33E
	for <dri-devel@archiver.kernel.org>; Sun, 22 Nov 2026 08:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vnQt825f
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3EDA810E1DE;
	Sun, 22 Nov 2026 08:18:43 +0000 (UTC)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 06F5B10E1DE
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 08:18:37 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-c4d28f75d62so385865066b.0
 for <dri-devel@lists.freedesktop.org>; Sun, 22 Nov 2026 00:18:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795335515; x=1795940315; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VhDJi21DzValv8EWmq82eR8h6wo5YimPj433Xh99oIs=;
 b=vnQt825fu9CBaoThVpqs9Ih/Pu5BZLcNBMoYlBRmHZLWgWdPV39buh72cCNn+YI1e1
 OXUDV1ELgZoxwjwoZ7RP4ctlR5R91c49Gd6V2YPh6yyrS/iIQeK1n7y0RGyYBwKOukQd
 a7YqJS/dauVTiGuZjmchkXIjvcdJ91l/y5RT806ygLOaTf4Sj/MSzXkEUYUqirJPmgzg
 tRYzCVVxj6wwYTz3Mw08NJsFCVTYDAs5fDJ5m/dDXHGVXl8uzG1cmZL04VUcSQyDngkX
 n9I9t/OBvZwkYVzHKlGggB4JLWCBbvesHGUIRa4eXvf6xU5WZYlHkfjlw2ftrXr2CdiS
 JmVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795335515; x=1795940315;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VhDJi21DzValv8EWmq82eR8h6wo5YimPj433Xh99oIs=;
 b=Lan899q91L5Kf5jihiGUIKMzZC+f9zPk26/1qPm/BaSuMia2qQsxvwB94LbLPsCP69
 kdrl+BMgB4nMG7pyUiFup9LlF25zjnmFqoNYQlLIMtHkLZKHkGQTAyaXgkjVg0vXF7sv
 IPjI/wSJ7eWAsq83qRtTMw6zckPv0c6t0PNNCOULk7Q2WD7m0sbXKNjbqfYaTWxo/l+O
 TWdhzim6YEmvdVN/2S/7X5xLc5M83BVTak+s3Edi0d0l+t1wfb0iq5o16ahZxz7IHTp8
 hC5GBkgIrvQ425Dpr42FzC+kEhScmAiMYqkz2u7lMEX3yrBqbegus0j+YCjE+yUkiXhM
 fbDg==
X-Gm-Message-State: APuU4Z9xFf3blMKZ8k9jiBi5PtTvTmRSJMfEJD7zS6yBwlaKlrW9V/Ln
 CDt2oXCSOpboFRoRGFgYdHMhti3/K18K6iX6bZFEbRwd7x0HY97Y8d0I
X-Gm-Gg: AZFdTZddmbQHA3K4sgXzzM1a1l/+b1ALCDUgYAT+aS+no0hyZBp8hhD+SDleO5JGA0G
 TQ1NSmLHXwlYDk6BlizCFyEjENRDsEk7U93zwc6VYmdvME2z13nC3ylD18co0biX3IYv1U8q8EF
 61M3QtQXwwcj4H5u39w+BJZrTrMh+ny6YuY4874CgUIPYaRH+/2LYLz7mbM/wZ5W2YW7zMUiMlQ
 yGwL1XKKLxivk9mQ8Rc0qOalDuQP/Rx7yi/+BnhpkoOSAAvBWPbEOnjB065dz4saTqTnldF1SKz
 ynpoIJ33EC7tLdcLjG/IbLiJeECDPg0YNUIwfqDHqUu+9SIHNKAmfn8+WEcFlpNe6G5ZO/YPE9z
 v295A5bklKMUlrO9KOQFMb7cNjR/JwenBsa6VCTF87US0alCy1rtvGJMQT/y5Nq0Eldz+J7GGO/
 P2cmEM/uRYi8w/UuuG8tXCH8juPxAUEc485g8xsKW6Ya+tM8O09VrAEKSHfTzMETbo1/Kxx8yIA
 P4B9f/CsZyiRO1XFlPHY6frvPqmcgVgz+lM2E9nM5NHFfxTH5SOL/NB3K1tSWuv+cWoZlGtp8w3
 xMkolvXq9hwnMlHUuC9v8EM/eirYXEuGgMKG8ALEam3q62Mu7UE7GR6ArQGR5hPvXh3h0h35Lvd
 ymX7yA0TH5w==
X-Received: by 2002:aa7:cd65:0:b0:6b5:823f:3462 with SMTP id
 4fb4d7f45d1cf-6ba37e83f29mr3868790a12.19.1795335515150; 
 Sun, 22 Nov 2026 00:18:35 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6ba370e8ad0sm3617167a12.18.2026.11.22.00.18.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 22 Nov 2026 00:18:33 -0800 (PST)
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
Subject: [PATCH v8 00/12] drm/tegra: Add support for Tegra20/Tegra30 8-bit CPU
 interface
Date: Sun, 22 Nov 2026 10:18:08 +0200
Message-ID: <20261122081820.53199-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
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

Changes in v8:
- return of_node_get() in devm_mipi_dbi_device_register
- add mipi_dbi_write_buffer_multi() and mipi_dbi_write_seq_multi()
- remove return doc from void function
- replace disable() removal in panel with mipi_dbi_write_seq_multi() conversion
- removed of_node_get() in tegra_dc_dbi_probe() for dbi node
- switch to drm_bridge_clear_and_put() in tegra_dbi_host_detach()
- add check if DC is idle before reconfiguring pins
- restored original tegra_dbi_atomic_disable() operation from v5
---

Svyatoslav Ryhel (12):
  drm: Add MIPI DBI bus support for MIPI DBI Type A and B
  drm/panel: panel-hitachi-tx10d07vm0baa: Convert to use MIPI DBI bus
  drm/panel: panel-hitachi-tx10d07vm0baa: Convert to
    mipi_dbi_write_seq_multi()
  drm/panel: panel-lg-lh400wv3: Convert to use MIPI DBI bus
  drm/panel: panel-lg-lh400wv3: Convert to mipi_dbi_write_seq_multi()
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
 drivers/gpu/drm/drm_mipi_dbi_bus.c            | 287 +++++++++
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 234 ++++---
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c     | 114 ++--
 drivers/gpu/drm/tegra/Kconfig                 |   1 +
 drivers/gpu/drm/tegra/Makefile                |   1 +
 drivers/gpu/drm/tegra/dbi.c                   | 592 ++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c                    |   4 +
 drivers/gpu/drm/tegra/dc.h                    | 197 +++++-
 drivers/gpu/drm/tegra/drm.h                   |   2 +-
 drivers/gpu/drm/tegra/dsi.c                   |  22 +-
 drivers/gpu/drm/tegra/hdmi.c                  |  22 +-
 drivers/gpu/drm/tegra/output.c                |  52 +-
 drivers/gpu/drm/tegra/rgb.c                   |  64 +-
 drivers/gpu/drm/tegra/sor.c                   |  20 +-
 include/drm/drm_mipi_dbi_bus.h                | 148 +++++
 19 files changed, 1638 insertions(+), 253 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
 create mode 100644 drivers/gpu/drm/drm_mipi_dbi_bus.c
 create mode 100644 drivers/gpu/drm/tegra/dbi.c
 create mode 100644 include/drm/drm_mipi_dbi_bus.h

-- 
2.53.0

