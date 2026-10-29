Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65A0D60A2601
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 15:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=uD+NLRMV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA3BD1123D2;
	Thu, 29 Oct 2026 15:29:39 +0000 (UTC)
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 55C631123D2
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 15:29:33 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-c4203bbb1e9so369342366b.3
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 08:29:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793287772; x=1793892572; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Xz/KjQxYIkaGqYRbTjczSZcjaGYHruf6qA2IzRiuJ9c=;
 b=uD+NLRMV2hO4Fym+U3gzRnphZjpGl++v+o88Z5MVQoPkdBCIE9uIYbRdZzwQ83iuem
 NeowzK9tKwhUdaP/060ftwLMnxaYD42P6u/s7tKLG2jaWSYd06KS9c9opuzskZz1DBus
 R1DITmFp7jDy5iJG9fjQDUMDWK0viz0QQLIOcaCQf+x5IAM06Kz9JyMsWvik78/j+Mjg
 +yzWIfUSPB5owDIenrEFIlZiPPHrbIFAY4DGT1oZT1Sj+mwcV3s6RRhAWZacIMuwegp2
 zks5UcM9Bp7nRFceoZyuNTaxeT3NKFX0Xa4ShubsdzVeHks3wgQUQYnDbIogg1MI2guE
 sSLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793287772; x=1793892572;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xz/KjQxYIkaGqYRbTjczSZcjaGYHruf6qA2IzRiuJ9c=;
 b=nMwAqN1UkGx1jmvLfQYJESaS199e1015GBqyFqvrq4Ip7v77NcW7OyjASsVV3UIr5+
 5IZcBn9mzr/bAMx0YxJcYRh97lJs0a99AgnkfpGuXyogcX9LcTOkxmtSlnV6V7f0Tmmc
 qjowM4l77U/ZgJzpBFODU+IvqjpgJEkAKdaPdOoVfXK9khfI9RZAG10qn8XkHBN64K/5
 qyPiog8yFJTM7zzE+9BBQQ3evDlc62UxY6irf6lqik/uYbrZxfqB/3h2HSeDVG356a1o
 Wut524LCRCfVDmw128eU16wSFfh3r8tOJmDfjCd4TvpOplv4/Y2+MUG4wEoo099fQehP
 nu/w==
X-Gm-Message-State: AFq9FYLpdlVRklb8xz4pgnmpiM+h7pB/ZPsYlJm50+Lw+mTC2V9gbZiz
 fW17vQwV9azMpEyDtOlP14eoefpvOXdNRD07iKq836NJcdpLm1JFiaCw
X-Gm-Gg: AYBFou0mZm+j1TaZxmk0WPl01/ByPDHtXSc23lIdEWFa0Ezx4+s4GEeF7tXue9vAY//
 Bk1+IjIfToHPK6jO9HLnZt1dLOnesrJzBjGRnoDV+ZrrijF9nXH7/X93G6QjLMXaSrCR0StafeC
 S6l8bRguPXpO9EfKbT+MNB8701pX92wLTSQ0zqjffIIxPkGf2XBUG+8TBlIdqvhU8TxX/pGlSaN
 qcWHm2SMkmaPrCtwsFrpocWTYZY2haD2Cg8epyb7Xo0EDNq6eRj7LOqzn4Kb5Gq/73/zQ7cJxZp
 FkXNGv1/rX7EC1mFXT2wvsoluIZTHo9AeO73QSLudPH0cqY1TTd/zrKJsaZyCj4UPPFDwTrouVX
 HZHJgevZWmxH/1RajdB4zyLd1S6WxIt5DJw7ebBPHl7fwskRB0Xkq7dG/AVF7Q+wGopW5AFlN3k
 b7swcNn0PlaDZmIA+8EOaERz2jTwf6OZYt+BWSdIQRE8dZ5YPHg/5vECkJr26uLa+7ANcTByNkQ
 lTsbc8QgUyGBigOl32VYebbZKVLo2nUucwk/ce7OmNadkB/FUAugu65pp/3uVfsJ7nfA89wjW36
 ECRzItOKeMZX75H3vByeTyPUX9XtQln4GIpHV2XG7Z+5R68wJw==
X-Received: by 2002:a17:907:a88e:b0:c40:36ca:9d1b with SMTP id
 a640c23a62f3a-c49be0398aemr530750766b.40.1793287771423; 
 Thu, 29 Oct 2026 08:29:31 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c4ca27984f8sm1252166b.80.2026.10.29.08.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 08:29:30 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v5 00/11] drm/tegra: Add support for Tegra20/Tegra30 8-bit CPU
 interface
Date: Thu, 29 Oct 2026 17:28:58 +0200
Message-ID: <20261029152909.234584-1-clamor95@gmail.com>
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
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
---

Mikko Perttunen (1):
  drm: Add MIPI DBI bus support

Svyatoslav Ryhel (10):
  dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and LG
    LH400WV3 panels
  drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver
  drm/panel: Add LG LH400WV3-SD04 MIPI DBI Type B panel driver
  drm/tegra: dc: Refactor and expand header
  dt-bindings: display: tegra: Document Tegra20 DSI port
  drm/tegra: Make panel parsing by tegra_output_probe() optional
  drm/tegra: Convert to use atomic versions of drm_encoder_helper_funcs
  drm/tegra: rgb: Parameterize configuration based on bus flags
  dt-bindings: display: tegra: Document 8-bit CPU parallel interface
  drm/tegra: Add support for 8-bit CPU interface

 .../display/panel/hit,tx10d07vm0baa.yaml      |  58 ++
 .../display/tegra/nvidia,tegra20-dbi.yaml     | 113 +++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  22 +
 .../display/tegra/nvidia,tegra20-dsi.yaml     |   6 +
 drivers/gpu/drm/Makefile                      |   2 +-
 drivers/gpu/drm/drm_mipi_dbi_bus.c            | 232 +++++
 drivers/gpu/drm/panel/Kconfig                 |  27 +
 drivers/gpu/drm/panel/Makefile                |   2 +
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 294 ++++++
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c     | 233 +++++
 drivers/gpu/drm/tegra/Makefile                |   1 +
 drivers/gpu/drm/tegra/dbi.c                   | 632 +++++++++++++
 drivers/gpu/drm/tegra/dc.c                    |  15 +-
 drivers/gpu/drm/tegra/dc.h                    | 859 +++++++++++-------
 drivers/gpu/drm/tegra/drm.h                   |   2 +-
 drivers/gpu/drm/tegra/dsi.c                   |  22 +-
 drivers/gpu/drm/tegra/hdmi.c                  |  22 +-
 drivers/gpu/drm/tegra/output.c                |  52 +-
 drivers/gpu/drm/tegra/rgb.c                   |  72 +-
 drivers/gpu/drm/tegra/sor.c                   |  20 +-
 include/drm/drm_mipi_dbi_bus.h                | 103 +++
 21 files changed, 2372 insertions(+), 417 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
 create mode 100644 drivers/gpu/drm/drm_mipi_dbi_bus.c
 create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
 create mode 100644 drivers/gpu/drm/panel/panel-lg-lh400wv3.c
 create mode 100644 drivers/gpu/drm/tegra/dbi.c
 create mode 100644 include/drm/drm_mipi_dbi_bus.h

-- 
2.53.0

