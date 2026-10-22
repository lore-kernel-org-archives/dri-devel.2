Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10EFA606A31B
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Y3C/+Kf3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72AEE11262E;
	Thu, 22 Oct 2026 13:23:26 +0000 (UTC)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com
 [209.85.208.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCD1C10E409
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:23:20 +0000 (UTC)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-6b21cf1a580so1983756a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 06:23:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792675399; x=1793280199; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=5ZnaBjVx8QabD0XIo1C2JwLGY8gbe6s95hFqcHQRQqE=;
 b=Y3C/+Kf3unHb1RkvEmUdcm9Z848O0xMFSqnNJrV4n37txIZn47TZS2mXxL63FOwZfY
 330LyQMQ6td9VHDE8sXSRVhbTCc3RkWoCDVq4LjTpah1nJoR79MJZi7DFpjaAoWyTDH1
 xxvjA3sAo0vFmVQzp22rcAjj1vOdiGJSFqgvoG0oygWUrOAcBM1eH+uo6k0L/eijHYN2
 mkXtmLk75erhMxZQOD8xAumdTWc8MzK0PcMsYiDb9BQ8zB1b3R9ldPXpzsFKw16tK9Jo
 0+YsNm711cKcl8s1Bk3HyEs4LV9RqdbMN8qhP/QFylGSyFgqlBehq+RLJBXKLinNjXke
 qjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675399; x=1793280199;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=5ZnaBjVx8QabD0XIo1C2JwLGY8gbe6s95hFqcHQRQqE=;
 b=HtKta8jCLtSFzg6Jlf0TZ9/dcogTMLO2GnTTONSG2YJeKcRmeJnWBLuaEPt5NuIYDF
 7VexFDLb15C2mwje296H4jbcRQkmNX2wP/JCf5RvNME9xcKjPjDaoI69fBmD6MUJjitb
 z09phtlaTYAZf8JRz+B+P4mUiAVY1fSAqUTUeuSRNFEtVWz06Ju4LXE03AKDbwdZ1gUm
 Gfn8/MzRwvmdisrzzQ3SJT+ctQAwn2sPskRycKqOSi+SpgDpHMTs15rK9baFLvbyBhaB
 BfBNhKzJTLZkVppvv168V7pqb/oDvquGLa00ah996P/QQkgZqNB+YdeJ4KtwUeOSNSBQ
 8hnw==
X-Gm-Message-State: AFq9FYLoETqvjGj5GKq/qUY7XHzgrqt2lzc+0zly3Joa31FtRworAIsE
 mf+lR/ffBhbxAXYQRux+KHIWH8uwlInvXmcGWJ6sFhX6T+s0Jttuewlh
X-Gm-Gg: AYBFou2ZIUUzCHl9sMqyFBhUt9ZxLkI+CboxgrCDA150ac57RwE2g0DtznR5thRrJfN
 SgxPZ4J5uFxJw2wV9LCk8enTxhMFg9eDZt1soQUc7eqsbGbwW/38Ac6NPV9HFs9E7vGeiL1349+
 Ydou1pqHhgYjaCUP7Z23F80m2iJqvCpf/uMGXqS7O8Lj9NBPlMM6J2kNg3cmPVP9B7pFQaQG7Pl
 r8FSN0SITRnySalNrjCFqFfS/IKhLN5Ey2ULIalEGs9hl8b7l/NhCamVkfVq4Up8S3FPM26QU9g
 2IQkx4blNchnpImDoQl3wNRGfGd9KRBayNHzggZ1APBJXW95AzDYT9F26AEyLX53zTlbWBAHJWP
 nGWsORBdQpz539m5ixFoYMfBYk5HrpzoOVI9txeOcZMdgf886HJ4BM44q3e1RLT3MIhB3OheBA6
 IMhWyCRPyUvuYP2lYmACuwIpZUyL7X7Gs9xR2dorejMiwwvizA9cyGnlBmNZUkjFEdjvVq1QZsC
 m1+AmdDc1UaARvXfSzw/q7qVXWgHXFQMja47XgEKgI0yh+yJMKBd036InW+DjIbLg58vj7NaQDr
X-Received: by 2002:a05:6402:64f:b0:6b4:2aa6:2c07 with SMTP id
 4fb4d7f45d1cf-6b42aa631d2mr825748a12.14.1792675398767; 
 Thu, 22 Oct 2026 06:23:18 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b40313074esm1818061a12.27.2026.10.22.06.23.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:23:17 -0700 (PDT)
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
Subject: [PATCH v4 0/7] drm/tegra: Add support for Tegra20/Tegra30 8-bit CPU
 interface
Date: Thu, 22 Oct 2026 16:22:52 +0300
Message-ID: <20261022132259.240717-1-clamor95@gmail.com>
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

Changes in v4:
- reorder patches to avoid errors on checking dbi schema
- dbi schema renamed to nvidia,tegra20-dbi for consistency
- fix DC_DISP_V_PULSE0_POSITION_* > DC_DISP_V_PULSE1_POSITION_*
- add MODULE_ALIAS
- swap width and height in panels
- dropped use of init-sequence and gpios
- dbi driver reworked to use only DC to operate pins
---

Svyatoslav Ryhel (7):
  dt-bindings: display: panel: Document Hitachi TX10D07VM0BAA and LG
    LH400WV3 panels
  drm/panel: Add Hitachi TX10D07VM0BAA MIPI DBI Type B panel driver
  drm/panel: Add LG LH400WV3-SD04 MIPI DBI Type B panel driver
  drm/tegra: dc: Expand available registers layouts
  drm/tegra: rgb: Parameterize configuration based on bus flags
  dt-bindings: display: tegra: Document 8-bit CPU parallel interface
  drm/tegra: Add support for 8-bit CPU interface

 .../display/panel/hit,tx10d07vm0baa.yaml      |  58 ++
 .../display/tegra/nvidia,tegra20-dbi.yaml     | 108 ++++
 .../display/tegra/nvidia,tegra20-dc.yaml      |  15 +
 drivers/gpu/drm/panel/Kconfig                 |  27 +
 drivers/gpu/drm/panel/Makefile                |   2 +
 .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 297 ++++++++++
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c     | 236 ++++++++
 drivers/gpu/drm/tegra/Kconfig                 |   7 +
 drivers/gpu/drm/tegra/Makefile                |   3 +
 drivers/gpu/drm/tegra/dbi.c                   | 536 ++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c                    |  32 +-
 drivers/gpu/drm/tegra/dc.h                    |  50 +-
 drivers/gpu/drm/tegra/rgb.c                   |  41 +-
 drivers/gpu/drm/tegra/trace.c                 |   3 +
 14 files changed, 1403 insertions(+), 12 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/panel/hit,tx10d07vm0baa.yaml
 create mode 100644 Documentation/devicetree/bindings/display/tegra/nvidia,tegra20-dbi.yaml
 create mode 100644 drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
 create mode 100644 drivers/gpu/drm/panel/panel-lg-lh400wv3.c
 create mode 100644 drivers/gpu/drm/tegra/dbi.c

-- 
2.53.0

