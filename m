Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E9A3C531F9
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 07:28:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CCA510F2ED;
	Fri, 24 Jul 2026 07:28:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TjpbbNHw";
	dkim-atps=neutral
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com
 [209.85.216.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3848710E5C9
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 18:45:55 +0000 (UTC)
Received: by mail-pj1-f44.google.com with SMTP id
 98e67ed59e1d1-38e071ed6aeso807748a91.0
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Jul 2026 11:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784832355; x=1785437155; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+cqQ6sQJkvsR3VtIbpEjUXStuHRs0SJj4jk7Uojzitk=;
 b=TjpbbNHwdlhaxHE/saw6j+pz6acgfEzl1OHsf1b5nkfcwBAWbygT3RSFFi1A8cwnu9
 1TL1ZoSr0jAjbcq8p3w+M1v0r/zq+4dsNE3VixAK8WOlWxCvlRbJQv3f3AYCtf/8I96m
 /2vnpOjvFXjfl9Laa5F8zbd3TwRZNmeiAha4GpwHUrHA8m5jM4H54hqR4wZDY7S0hwrd
 ejz0TI4BarS3bzYgfdJjSiyVKkgLOMfGupJK0TrDFEv9hmayhvfe9sXzStKsw/ZyrblB
 Ii7VxIuOC8b80eH1h0dZiSRGaPTrznmrfoAaGfQ4SXRZZi1kKlle78IVtFqTH7vdzrt/
 hgoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784832355; x=1785437155;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+cqQ6sQJkvsR3VtIbpEjUXStuHRs0SJj4jk7Uojzitk=;
 b=bphonrWAJyu7Q9WU/ZDZw3Tp+kKLsgm0t1nEUuSRchQr0DjdWmKbYr/PgEweuExT/h
 t+GgVwZ3TNGogb0x2ARVBPezXLzOUo8p70JFyYyZyEY3n73VI7jMcYik30kA6G8dsgIC
 mgTryPL1w+Ep22haoTP/xnZfGV9JCOzZI6oBakjtF4GHJwajL/wjeSiBGXy0UBBJV77R
 KhnQuwd1yFLxrSxpGEaouME3REozTT6NE23VvElWLaN3uD6lAGoJYEwAl8PP62rUXjEN
 JNT0c9xRRQMh0pKb6mgSpDFRKeMi7T0tCzwzXGT3VplDMCtWu4V6r7MbYJU7ZGSOC1Ac
 UIHQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr/NbUtKuUeyJSQfX8MPhxOyvPcD0CaHfC2qeiKAOsEdOgBcJaftGJ1Km9A5pVQ/MebYPcsRm7a3h0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyX3vKMpninpdMfxHXsNkwbmo/2MnL7jXy1TTjKNLpz+fSneNbL
 H3vV4aofiMwkLIRKfYv+rQO7NBkIssFqOfASJ2KNsE2MKETHwWufSBn0
X-Gm-Gg: AR+sD11KjQ8LxUGpxGnIt6yE4CkYC7DK81Q7W3DykitI9Mcghd0zwEu/rNuGHUFJcBh
 6mjUmRI2WQgwrEeKXXXoWaA9U/tQk/6en0X9ubMiBtsmJAOL190Z+SoU6sNu9Alr8FbNscUQ8fS
 l317Tmlfbawx6gldxB4YwgBivlK3qEIYeERxK65XcD5VeRVlAt0YCPiO6EW5jj1OVuoA1VKGCTn
 JdeGOsFKHAprFOmpYCVtiCrxsl6dcgebA6Dc+xDfz/GKb7ISQ2P+UF0Uui7L0zXKcpS828PBrvI
 WmP44XPnozEg8ecES6ItnZrImPMdJYDMdUm5Ur54LXkY3+nwsigRQPPs7neVqRt+QJC9N9bmpdC
 SxOjFXfQc75CCDkQb8b6DG6okI19tJrpxhQyLG5bHV0uF+ZrD5lZYZNoXN3vmj/PDoOKOkSsC
X-Received: by 2002:a17:90b:1350:b0:36d:66d4:270e with SMTP id
 98e67ed59e1d1-38ec6455120mr4430242a91.5.1784832354540; 
 Thu, 23 Jul 2026 11:45:54 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.45.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Jul 2026 11:45:53 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr, Alex Deucher <alexander.deucher@amd.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Morton <akpm@linux-foundation.org>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 Borislav Petkov <bp@alien8.de>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Daniel Lezcano <daniel.lezcano@kernel.org>,
 David Airlie <airlied@gmail.com>, "David S. Miller" <davem@davemloft.net>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Herbert Xu <herbert@gondor.apana.org.au>,
 =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jakub Kicinski <kuba@kernel.org>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Jaroslav Kysela <perex@perex.cz>, Jason Gunthorpe <jgg@ziepe.ca>,
 Jiri Pirko <jiri@resnulli.us>, "Joerg Roedel (AMD)" <joro@8bytes.org>,
 Johan Hovold <johan@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Julian Anastasov <ja@ssi.bg>, Leon Romanovsky <leon@kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Linus Walleij <linusw@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Mark Brown <broonie@kernel.org>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Matthew Sakai <msakai@redhat.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>,
 Mike Rapoport <rppt@kernel.org>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 Nicolas Palix <nicolas.palix@imag.fr>,
 Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>,
 Ping-Ke Shih <pkshih@realtek.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Sebastian Reichel <sre@kernel.org>,
 Shuah Khan <shuah@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Simon Horman <horms@verge.net.au>, Stephen Boyd <sboyd@kernel.org>,
 Steve French <sfrench@samba.org>, Takashi Iwai <tiwai@suse.com>,
 Thomas Renninger <trenn@suse.com>, Thomas Zimmermann <tzimmermann@suse.de>,
 Tony Luck <tony.luck@intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vinod Koul <vkoul@kernel.org>,
 Will Deacon <will@kernel.org>, Yazen Ghannam <Yazen.Ghannam@amd.com>
Cc: cocci@inria.fr, amd-gfx@lists.freedesktop.org, dmaengine@vger.kernel.org,
 dm-devel@lists.linux.dev, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
 iommu@lists.linux.dev, linux-cifs@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-crypto@vger.kernel.org,
 linux-edac@vger.kernel.org, linux-gpio@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-rtc@vger.kernel.org, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org,
 lvs-devel@vger.kernel.org, netdev@vger.kernel.org,
 netfilter-devel@vger.kernel.org, nouveau@lists.freedesktop.org,
 platform-driver-x86@vger.kernel.org
Subject: [PATCH 00/36] treewide: remove conditional returns with no effect
Date: Fri, 24 Jul 2026 03:45:02 +0900
Message-ID: <20260723184538.3888637-1-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 24 Jul 2026 07:28:31 +0000
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

Hello,

While reading mm/memblock, I found a conditional return where both
branches return the same value:

	err = do_something();
	if (err)
		return err;
	return err;

Such code is usually a leftover from removing a statement between
the two returns, and the tree has about a hundred of these.

Patch 1 adds a Coccinelle script that matches the pattern, including
negation and constant-comparison variants. Where a local variable is
assigned right before the check, the assignment and the two returns
turn into a single return of the assigned expression.

Patches 2-36 are generated by the script, with hand fixes to restore
unexpectedly removed comments and to fix the formatting checkpatch.pl
complained about.

The patches are grouped by subsystem instead of split per file. If
you would rather split, merge or drop your part, just let me know
and I will address it in the next version.

All patches are independent and can be applied separately, but for
everyone's convenience, it would be nice if they were merged through
a single tree.

The series is based on next-20260721.

Sang-Heon Jeon (36):
  coccinelle: misc: add cond_return_no_effect.cocci
  drm/amd: remove conditional return with no effect
  drm/radeon: remove conditional return with no effect
  dpll: zl3073x: remove conditional return with no effect
  drm/i915: remove conditional return with no effect
  drm: remove conditional return with no effect
  net: ethernet: remove conditional return with no effect
  net: remove conditional return with no effect
  net: intel: remove conditional return with no effect
  wifi: remove conditional return with no effect
  ipvs: remove conditional return with no effect
  media: remove conditional return with no effect
  ALSA: remove conditional return with no effect
  ASoC: remove conditional return with no effect
  iio: remove conditional return with no effect
  Input: remove conditional return with no effect
  clk: remove conditional return with no effect
  crypto: drivers - remove conditional return with no effect
  dmaengine: qcom_hidma: remove conditional return with no effect
  stm class: remove conditional return with no effect
  RDMA/ocrdma: remove conditional return with no effect
  iommu/s390: remove conditional return with no effect
  dm vdo: remove conditional return with no effect
  pinctrl: mediatek: remove conditional return with no effect
  platform/x86: toshiba_haps: remove conditional return with no effect
  power: supply: pm8916_lbc: remove conditional return with no effect
  RAS/AMD/ATL: remove conditional return with no effect
  regulator: wm831x-isink: remove conditional return with no effect
  rtc: pcf2127: remove conditional return with no effect
  scsi: mpt3sas: remove conditional return with no effect
  thermal/drivers/k3_bandgap: remove conditional return with no effect
  USB: serial: ch341: remove conditional return with no effect
  usb: typec: fusb302: remove conditional return with no effect
  smb: client: remove conditional return with no effect
  cpupower: remove conditional return with no effect
  memblock: remove conditional return with no effect

 drivers/clk/clk-cs2000-cp.c                   |   6 +-
 drivers/clk/clk-lmk04832.c                    |  12 +-
 .../intel/qat/qat_common/adf_gen2_config.c    |   8 +-
 .../marvell/octeontx2/otx2_cpt_mbox_common.c  |   7 +-
 drivers/dma/qcom/hidma_ll.c                   |   6 +-
 drivers/dpll/zl3073x/dpll.c                   |   6 +-
 drivers/dpll/zl3073x/out.c                    |   8 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v7_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/gfx_v9_4_3.c       |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v4_4_2.c      |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v5_2.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/sdma_v6_0.c        |   6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v4_2.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v5_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c         |   6 +-
 drivers/gpu/drm/amd/amdgpu/vce_v4_0.c         |   6 +-
 drivers/gpu/drm/amd/pm/legacy-dpm/kv_dpm.c    |  32 ++---
 drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c    |   6 +-
 drivers/gpu/drm/amd/pm/swsmu/amdgpu_smu.c     |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/arcturus_ppt.c |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/navi10_ppt.c   |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu11/smu_v11_0.c    |  19 +--
 .../gpu/drm/amd/pm/swsmu/smu11/vangogh_ppt.c  |   7 +-
 .../gpu/drm/amd/pm/swsmu/smu12/renoir_ppt.c   |   7 +-
 .../drm/amd/pm/swsmu/smu13/aldebaran_ppt.c    |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu13/smu_v13_0.c    |  19 +--
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_0_ppt.c  |   6 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_6_ppt.c  |  10 +-
 .../drm/amd/pm/swsmu/smu13/smu_v13_0_7_ppt.c  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu14/smu_v14_0.c    |  19 +--
 .../drm/amd/pm/swsmu/smu14/smu_v14_0_2_ppt.c  |   6 +-
 .../gpu/drm/amd/pm/swsmu/smu15/smu_v15_0.c    |   9 +-
 .../drm/amd/pm/swsmu/smu15/smu_v15_0_8_ppt.c  |  16 +--
 drivers/gpu/drm/i915/display/intel_hdmi.c     |   7 +-
 drivers/gpu/drm/i915/gvt/gtt.c                |   8 +-
 drivers/gpu/drm/imx/ipuv3/imx-drm-core.c      |   6 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  14 +-
 .../drm/panel/panel-osd-osd101t2587-53ts.c    |   7 +-
 drivers/gpu/drm/radeon/ci_dpm.c               |   6 +-
 drivers/gpu/drm/radeon/kv_dpm.c               |  30 ++---
 drivers/gpu/drm/radeon/si_dpm.c               |  14 +-
 drivers/gpu/drm/tilcdc/tilcdc_drv.c           |   6 +-
 drivers/hwtracing/stm/core.c                  |   8 +-
 drivers/iio/light/isl29028.c                  |   6 +-
 drivers/iio/light/tsl2583.c                   |  14 +-
 drivers/iio/magnetometer/ak8974.c             |   6 +-
 drivers/infiniband/hw/ocrdma/ocrdma_verbs.c   |   7 +-
 drivers/input/keyboard/pmic8xxx-keypad.c      |   8 +-
 drivers/input/mouse/synaptics_i2c.c           |   6 +-
 drivers/input/rmi4/rmi_smbus.c                |   7 +-
 drivers/iommu/s390-iommu.c                    |   8 +-
 drivers/md/dm-vdo/encodings.c                 |   8 +-
 drivers/media/i2c/mt9p031.c                   |   6 +-
 .../microchip/microchip-sama7g5-isc.c         |   7 +-
 .../media/platform/qcom/iris/iris_resources.c |   6 +-
 .../media/platform/qcom/venus/pm_helpers.c    |   7 +-
 drivers/media/platform/renesas/rcar-csi2.c    |   6 +-
 .../platform/samsung/s3c-camif/camif-core.c   |   7 +-
 drivers/media/usb/dvb-usb-v2/mxl111sf.c       |  12 +-
 drivers/media/usb/gspca/jl2005bcd.c           |   7 +-
 drivers/net/ethernet/amazon/ena/ena_netdev.c  |   6 +-
 .../ethernet/aquantia/atlantic/aq_macsec.c    |   6 +-
 .../ethernet/freescale/dpaa2/dpaa2-switch.c   |   6 +-
 drivers/net/ethernet/freescale/gianfar.c      |   6 +-
 drivers/net/ethernet/intel/i40e/i40e_main.c   |   8 +-
 drivers/net/ethernet/intel/igb/e1000_i210.c   |   6 +-
 drivers/net/ethernet/intel/igc/igc_phy.c      |   6 +-
 .../ethernet/qlogic/netxen/netxen_nic_hw.c    |   7 +-
 .../ethernet/qlogic/qlcnic/qlcnic_83xx_init.c |   6 +-
 drivers/net/ethernet/renesas/rtsn.c           |   7 +-
 drivers/net/phy/microchip_t1.c                |   6 +-
 drivers/net/pse-pd/tps23881.c                 |   6 +-
 drivers/net/wireless/ath/ath6kl/init.c        |   6 +-
 drivers/net/wireless/intel/iwlwifi/mvm/link.c |   6 +-
 .../wireless/realtek/rtlwifi/rtl8821ae/hw.c   |   7 +-
 drivers/net/wireless/realtek/rtw89/mac.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |   6 +-
 .../pinctrl/mediatek/pinctrl-mtk-common-v2.c  |   6 +-
 drivers/platform/x86/toshiba_haps.c           |   6 +-
 drivers/power/supply/pm8916_lbc.c             |   8 +-
 drivers/ras/amd/atl/map.c                     |   6 +-
 drivers/regulator/wm831x-isink.c              |   6 +-
 drivers/rtc/rtc-pcf2127.c                     |   7 +-
 drivers/scsi/mpt3sas/mpt3sas_base.c           |   6 +-
 drivers/thermal/k3_bandgap.c                  |   7 +-
 drivers/usb/serial/ch341.c                    |   8 +-
 drivers/usb/typec/tcpm/fusb302.c              |  14 +-
 fs/smb/client/smb1maperror.c                  |   6 +-
 mm/memblock.c                                 |   7 +-
 net/netfilter/ipvs/ip_vs_sync.c               |   7 +-
 .../misc/cond_return_no_effect.cocci          | 121 ++++++++++++++++++
 sound/pci/echoaudio/echoaudio_dsp.c           |   6 +-
 sound/pci/echoaudio/layla24_dsp.c             |   6 +-
 sound/pci/riptide/riptide.c                   |   5 +-
 sound/soc/amd/acp/acp-mach-common.c           |  11 +-
 sound/soc/intel/atom/sst-mfld-platform-pcm.c  |   7 +-
 sound/soc/samsung/smdk_spdif.c                |   8 +-
 sound/soc/sof/intel/hda-dsp.c                 |   6 +-
 sound/usb/mixer_scarlett.c                    |  26 ++--
 tools/power/cpupower/utils/powercap-info.c    |   2 -
 102 files changed, 295 insertions(+), 643 deletions(-)
 create mode 100644 scripts/coccinelle/misc/cond_return_no_effect.cocci

--
2.43.0

