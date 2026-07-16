Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36789C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 07:40:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A5FD10E726;
	Thu, 16 Jul 2026 07:40:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="O6XBA1J2";
	dkim=pass (2048-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="hqNkAaIe";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 11C4210E724
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 07:40:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784187607;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=cXLXS6MpfQQz5wlKDJUyL4Gpupar2PP12LAqPDcnxkQ=;
 b=O6XBA1J2X/o3VGGHd5hpEqPN+CbKku4iLyjF/xy5ttlRLAw8WsESPOgNoAmsAMzHwTOLZi
 L31X2oIvNApCAOND96lAEA1OgrQap6rGkV23xpRvm1hWKaODsJUEZXxMD4M69BXF4GRIGT
 O7AA86qNlayz1G6abT8Am2z7/feZUuI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-6S3jt9fHOSuNWwvhJ6mzpQ-1; Thu, 16 Jul 2026 03:40:05 -0400
X-MC-Unique: 6S3jt9fHOSuNWwvhJ6mzpQ-1
X-Mimecast-MFC-AGG-ID: 6S3jt9fHOSuNWwvhJ6mzpQ_1784187604
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-493fa6e28a7so38911635e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 00:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784187604; x=1784792404; darn=lists.freedesktop.org;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=cXLXS6MpfQQz5wlKDJUyL4Gpupar2PP12LAqPDcnxkQ=;
 b=hqNkAaIeqIveHXZMFtDUVnzSKmWc1jGd7UgMFbpt4VDFlcoV8ySaRqh5sQaUPDoJIk
 pVlueIU1xyHkNVqO1bq4iLkHqpIhT+x274X7amh3cRlHVCP5LkfLGsjaV3jy28H/MsVY
 lTB9p1WU3pipx4pv71LndqVTdJ4mmNOYHHmgAd0ecw3KWiaVog3Biqe9sqvQvTOGFBu3
 l6YdG24PYiUFhl4L8qh5dz/NhRvyDJL7q8Ijm852D9ry0ZXlQgGddEXDBrEEOKwB4oaX
 VSgbEuBVe0EraNfvJEkGjX/450XFlFgJnizpxlCXNKabII9Iue7tMGdrnmKylGqFVrwU
 FprQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784187604; x=1784792404;
 h=content-disposition:content-type:mime-version:message-id:subject:cc
 :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cXLXS6MpfQQz5wlKDJUyL4Gpupar2PP12LAqPDcnxkQ=;
 b=ePs77KCTaPBJ4kIQvKno4rqxADIc5vgJ7pD53vK/2vBtkKHIqJqls7nwEq/IsRkvzr
 XBPTYNcR7+VntRzblg6v+E9sUXyyjrLaG9l5VJ31OLJCPIzt1dmXqOQLcPcMYTFDDmnc
 DYHTV4MPTqDBJPWZukR5eRH5AsYfycFRSZFfYFL6UyJ4aUd8ntsf94fSEtSrQmmKhuN4
 ijMVp8ssvo2NQRAx0/bVcvBTMeT5TYKVn6frLwn5bUvA9P0L+nZudxS0Gl9AnzFQFyB+
 4T8vi5LtREoZJOS5GXNiMex8EnF2mUvp9Xush1CUOhHmCj8QKSGeyNnCp1BvuU9xxxNB
 eb1g==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp6oi14bnt21wlJ5MTj0bWUTadqmqOHZSw/T/shUTNUPvgT+j3pMKVEGJUm7fE7fuQQvi2WXMEKV/s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzdlEwt2SO+2nQKsWNW9UtFsMIA1RO9IxFwjp/79v1le4toaviu
 gIaaX3WgTju+0xJtyZlP0uUY/wLHUJ/KTI7jQj6Rabl0MmAAwdoa7edXwSqKIIifNb3b58oYdB0
 wziebzW8oFhlmMmmSINAQVao7zc/8NTMNowOGpkEC10tp2rwUvS9u8ZFIwgB76KBgw2wp1w==
X-Gm-Gg: AfdE7ckffyxzGbBnafoELG57+E0b+GNk5OSiPG1NmX43zZ8irnP1d5HKSvPzUf1TJET
 97UFutcq/45yZyjeGNFsbDupeyd+23tdPnrNoRP9ZK9Ir14GZcG1UjMVUSTYmp0gKE5yd3a6MFg
 JZijHGXjTQEu61Xgm9lPA4EI4ZYhLl7BCWH4LIAC+zDmjV2xAKS7YEscuYoWAJFkySajETv7PJX
 R91Shkb7zspk2cqnekSXh8n91AAopN4OdZp2fB3Xs6trfQkKxOMaM4KJje2dTxri/gEzUc0q6wQ
 ErkNjUXplZtDfpK+JiTFAaS6cbjZa+xQdm9OeyiSPYS7eYwjbr2/gmXrzDtnQ++n6TqM78avDg=
 =
X-Received: by 2002:a05:600c:8483:b0:493:d078:796 with SMTP id
 5b1f17b1804b1-4953c16a713mr67061785e9.17.1784187603525; 
 Thu, 16 Jul 2026 00:40:03 -0700 (PDT)
X-Received: by 2002:a05:600c:8483:b0:493:d078:796 with SMTP id
 5b1f17b1804b1-4953c16a713mr67061355e9.17.1784187602961; 
 Thu, 16 Jul 2026 00:40:02 -0700 (PDT)
Received: from localhost ([2a01:e0a:a99:9822:ca7f:54ff:fe01:374c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49541e9ee07sm42127855e9.15.2026.07.16.00.40.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 00:40:02 -0700 (PDT)
Date: Thu, 16 Jul 2026 09:40:01 +0200
From: Maxime Ripard <mripard@redhat.com>
To: Dave Airlie <airlied@gmail.com>, 
	Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Matthew Brost <matthew.brost@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, 
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-next
Message-ID: <20260716-famous-pastel-ostrich-a1aaef@houat>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha384;
 protocol="application/pgp-signature"; boundary="xgbvgquebhi7dsp5"
Content-Disposition: inline
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


--xgbvgquebhi7dsp5
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: [PULL] drm-misc-next
MIME-Version: 1.0

Hi Sima, Dave,

Here's this week drm-misc-next PR.

Thanks!
Maxime

drm-misc-next-2026-07-16:
drm-misc-next for 7.3:

UAPI Changes:

Cross-subsystem Changes:

Core Changes:
- blend: allow blend mode property without PREMULTI
- bridges:
  - Rename drm_for_each_bridge_in_chain_scoped to
    drm_for_each_bridge_in_chain
  - Drop legacy bridges support

- gpusvm: Code reorganization to give drivers more flexibility

Driver Changes:
- etnaviv: Check if a reset has been successful
- nouveau: Create instmem iomapping at first use
- panthor: Remove redundant cleanup
- qxl: Convert to a simple encoder to a regular one

- bridges:
  - Convert all remaining legacy bridges to atomic
  - tc358767: clamp the reported AUX read size to the request

- panels:
  - novatek-nt37801: Use mipi_dsi_*_multi() functions
  - samsung-s6d16d0: Fix prepare error handling
The following changes since commit 671b7825dbfe9ea6e3ad3001003aeee0df48d1b5:

  drm/v3d: bound CPU-job query writes to their destination BO (2026-07-08 0=
9:15:42 -0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-202=
6-07-16

for you to fetch changes up to ec6444a00c49e6c2b5e9a507272a28126677f9ee:

  drm/bridge: tc358767: clamp the reported AUX read size to the request (20=
26-07-15 11:38:01 -0700)

----------------------------------------------------------------
drm-misc-next for 7.3:

UAPI Changes:

Cross-subsystem Changes:

Core Changes:
- blend: allow blend mode property without PREMULTI
- bridges:
  - Rename drm_for_each_bridge_in_chain_scoped to
    drm_for_each_bridge_in_chain
  - Drop legacy bridges support

- gpusvm: Code reorganization to give drivers more flexibility

Driver Changes:
- etnaviv: Check if a reset has been successful
- nouveau: Create instmem iomapping at first use
- panthor: Remove redundant cleanup
- qxl: Convert to a simple encoder to a regular one

- bridges:
  - Convert all remaining legacy bridges to atomic
  - tc358767: clamp the reported AUX read size to the request

- panels:
  - novatek-nt37801: Use mipi_dsi_*_multi() functions
  - samsung-s6d16d0: Fix prepare error handling

----------------------------------------------------------------
Ben Dooks (1):
      drm/panfrost: include panfrost_drv.h for panfrost_transparent_hugepage

Dave Airlie (1):
      nouveau/instmem: use iomapping interface for instmem handling

Diogo Silva (1):
      drm/qxl: remove dependency on DRM simple helpers

Henrik Grimler (2):
      drm/bridge: sii9234: fix some typos in comments and messages
      drm/bridge: sii9234: use dev_err_probe where applicable

Honglei Huang (5):
      drm/gpusvm: split MM state flags out of drm_gpusvm_pages_flags
      drm/gpusvm: embed struct drm_device into drm_gpusvm_pages
      drm/xe: have xe_svm_range embed one drm_gpusvm_pages
      drm/gpusvm: move struct drm_gpusvm_pages out of struct drm_gpusvm_ran=
ge
      drm/gpusvm: let the drm_gpusvm core context purely MM level

Jiri Slaby (SUSE) (2):
      drm/imx: Switch to irq_domain_create_linear()
      drm/imx: include dc-drv.h to avoid sparse warning

Laxman Acharya Padhya (1):
      drm/panel: samsung-s6d16d0: Power off on prepare failure

Leandro Ribeiro (2):
      drm/drm_blend: allow blend mode property without PREMULTI
      drm: ensure blend mode supported if pixel format with alpha exposed

Luca Ceresoli (4):
      drm: of: fix wording in comment
      drm/bridge: samsung-dsim: fix wording in comment
      drm/bridge: fix wording in comment
      drm/bridge: rename drm_for_each_bridge_in_chain_scoped() to drm_for_e=
ach_bridge_in_chain()

Lucas Stach (2):
      drm/etnaviv: check all modules for idle after reset
      drm/etnaviv: check MMUv2 status after reset

Maoyi Xie (1):
      drm/bridge: tc358767: clamp the reported AUX read size to the request

Maxime Ripard (37):
      drm/adp: mipi: Add atomic bridge state handlers
      drm/bridge: analogix-anx6345: Switch to atomic bridge callbacks
      drm/bridge: analogix-anx78xx: Switch to atomic bridge callbacks
      drm/bridge: aux-bridge: Add atomic bridge state handlers
      drm/bridge: aux-hpd-bridge: Add atomic bridge state handlers
      drm/bridge: chrontel-ch7033: Switch to atomic bridge callbacks
      drm/bridge: cros-ec-anx7688: Add atomic bridge state handlers
      drm/bridge: lontium-lt8713sx: Add atomic bridge state handlers
      drm/bridge: lontium-lt8912b: Switch to atomic bridge callbacks
      drm/bridge: lontium-lt9611uxc: Add atomic bridge state handlers
      drm/bridge: lvds-codec: Switch to atomic bridge callbacks
      drm/bridge: megachips-stdpxxxx-ge-b850v3-fw: Add atomic bridge state =
handlers
      drm/bridge: microchip-lvds: Add atomic bridge state handlers
      drm/bridge: nxp-ptn3460: Switch to atomic bridge callbacks
      drm/bridge: of-display-mode-bridge: Add atomic bridge state handlers
      drm/bridge: parade-ps8622: Switch to atomic bridge callbacks
      drm/bridge: sii9234: Add atomic bridge state handlers
      drm/bridge: sil-sii8620: Add atomic bridge state handlers
      drm/bridge: simple-bridge: Switch to atomic bridge callbacks
      drm/bridge: tc358764: Switch to atomic bridge callbacks
      drm/bridge: tda998x: Switch to atomic bridge callbacks
      drm/bridge: ti-tfp410: Switch to atomic bridge callbacks
      drm/bridge: ti-tpd12s015: Add atomic bridge state handlers
      drm/bridge: thc63lvd1024: Switch to atomic bridge callbacks
      drm/bridge: waveshare-dsi: Switch to atomic bridge callbacks
      drm/exynos: mic: Switch to atomic bridge callbacks
      drm/mcde: dsi: Add atomic bridge state handlers
      drm/mediatek: dpi: Switch to atomic bridge callbacks
      drm/msm: dsi: Switch to atomic bridge callbacks
      drm/omap: dpi: Switch to atomic bridge callbacks
      drm/omap: dsi: Switch to atomic bridge callbacks
      drm/omap: sdi: Switch to atomic bridge callbacks
      drm/omap: venc: Switch to atomic bridge callbacks
      drm/sti: dvo: Switch to atomic bridge callbacks
      drm/sti: hda: Switch to atomic bridge callbacks
      drm/sti: hdmi: Switch to atomic bridge callbacks
      drm/bridge: Remove legacy bridge callback support

Nicol=E1s Antinori (1):
      drm/panel: novatek-nt37801: Use mipi_dsi_*_multi() functions

Tvrtko Ursulin (1):
      drm/panthor: Remove redundant drm_sched_job_cleanup() from the .free_=
job callback

 .clang-format                                      |   2 +-
 drivers/gpu/drm/adp/adp-mipi.c                     |   4 +
 drivers/gpu/drm/bridge/analogix/analogix-anx6345.c |  13 +-
 drivers/gpu/drm/bridge/analogix/analogix-anx78xx.c |  13 +-
 drivers/gpu/drm/bridge/aux-bridge.c                |   4 +
 drivers/gpu/drm/bridge/aux-hpd-bridge.c            |   4 +
 drivers/gpu/drm/bridge/chrontel-ch7033.c           |  13 +-
 drivers/gpu/drm/bridge/cros-ec-anx7688.c           |   4 +
 drivers/gpu/drm/bridge/lontium-lt8713sx.c          |   4 +
 drivers/gpu/drm/bridge/lontium-lt8912b.c           |   8 +-
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c         |   3 +
 drivers/gpu/drm/bridge/lvds-codec.c                |  10 +-
 .../drm/bridge/megachips-stdpxxxx-ge-b850v3-fw.c   |   3 +
 drivers/gpu/drm/bridge/microchip-lvds.c            |   3 +
 drivers/gpu/drm/bridge/nxp-ptn3460.c               |  17 +-
 drivers/gpu/drm/bridge/of-display-mode-bridge.c    |   4 +
 drivers/gpu/drm/bridge/parade-ps8622.c             |  18 +-
 drivers/gpu/drm/bridge/samsung-dsim.c              |   2 +-
 drivers/gpu/drm/bridge/sii9234.c                   |  39 ++--
 drivers/gpu/drm/bridge/sil-sii8620.c               |   4 +
 drivers/gpu/drm/bridge/simple-bridge.c             |  13 +-
 drivers/gpu/drm/bridge/tc358764.c                  |  13 +-
 drivers/gpu/drm/bridge/tc358767.c                  |   2 +-
 drivers/gpu/drm/bridge/tda998x_drv.c               |  13 +-
 drivers/gpu/drm/bridge/thc63lvd1024.c              |  14 +-
 drivers/gpu/drm/bridge/ti-tfp410.c                 |  10 +-
 drivers/gpu/drm/bridge/ti-tpd12s015.c              |   4 +
 drivers/gpu/drm/bridge/waveshare-dsi.c             |  14 +-
 drivers/gpu/drm/display/drm_bridge_connector.c     |   4 +-
 drivers/gpu/drm/drm_atomic.c                       |   2 +-
 drivers/gpu/drm/drm_blend.c                        |  20 +-
 drivers/gpu/drm/drm_bridge.c                       |  65 ++----
 drivers/gpu/drm/drm_gpusvm.c                       | 243 ++++++++++++-----=
----
 drivers/gpu/drm/drm_mode_config.c                  |  21 ++
 drivers/gpu/drm/drm_of.c                           |   2 +-
 drivers/gpu/drm/etnaviv/etnaviv_gpu.c              |  23 +-
 drivers/gpu/drm/exynos/exynos_drm_mic.c            |  14 +-
 drivers/gpu/drm/imx/dc/dc-ic.c                     |   6 +-
 drivers/gpu/drm/mcde/mcde_dsi.c                    |   3 +
 drivers/gpu/drm/mediatek/mtk_dpi.c                 |  10 +-
 drivers/gpu/drm/msm/dsi/dsi_manager.c              |  13 +-
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/fbsr.c |   1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |  39 +++-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h |   1 +
 drivers/gpu/drm/omapdrm/dss/dpi.c                  |  14 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  |  14 +-
 drivers/gpu/drm/omapdrm/dss/sdi.c                  |  14 +-
 drivers/gpu/drm/omapdrm/dss/venc.c                 |  14 +-
 drivers/gpu/drm/panel/panel-novatek-nt37801.c      | 106 ++++-----
 drivers/gpu/drm/panel/panel-samsung-s6d16d0.c      |  10 +-
 drivers/gpu/drm/panfrost/panfrost_drv.c            |   1 +
 drivers/gpu/drm/panthor/panthor_sched.c            |   1 -
 drivers/gpu/drm/qxl/qxl_display.c                  |  12 +-
 drivers/gpu/drm/sti/sti_dvo.c                      |  20 +-
 drivers/gpu/drm/sti/sti_hda.c                      |  20 +-
 drivers/gpu/drm/sti/sti_hdmi.c                     |  20 +-
 drivers/gpu/drm/tests/drm_bridge_test.c            | 106 +--------
 drivers/gpu/drm/xe/xe_pt.c                         |   2 +-
 drivers/gpu/drm/xe/xe_svm.c                        |  66 ++++--
 drivers/gpu/drm/xe/xe_svm.h                        |  14 +-
 drivers/gpu/drm/xe/xe_userptr.c                    |   5 +-
 include/drm/drm_bridge.h                           | 114 +---------
 include/drm/drm_gpusvm.h                           |  67 ++++--
 63 files changed, 726 insertions(+), 616 deletions(-)

--xgbvgquebhi7dsp5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iJUEABMJAB0WIQTkHFbLp4ejekA/qfgnX84Zoj2+dgUCaliK0AAKCRAnX84Zoj2+
dlGlAYCxmbUnS1ujvf+N9Fh5uxx5vSyItFNKCRvR5C1vabfMYHox6Ry5ay66iTVk
8rqH5ccBgJHZii5DHfyyWdM/IPUefYaNx0wJmsgUha8lax/h+VWJqmF0kU4EI7Bm
j2BZpgXaFw==
=eEnH
-----END PGP SIGNATURE-----

--xgbvgquebhi7dsp5--

