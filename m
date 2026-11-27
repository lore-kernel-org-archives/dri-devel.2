Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A639606A31F
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 09:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=CVAUuiT3
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 556EA10E545;
	Sat, 28 Nov 2026 09:41:02 +0000 (UTC)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8B9710E3C0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:18:41 +0000 (UTC)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-4a358881793so4240433f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795781920; x=1796386720; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=M3+53CL9E7t0kgo4XELs9bJ+0tvf7YuCDNZDOGzql0s=;
 b=CVAUuiT3lKpapneTcEE5YDeP53QT1M+rc1iIpbZSQY0jl8B8qdSwkXPMywabC2zOD3
 sXW6KtJK+lQ9IaSgqKgm5hM2MtFMbAdkaZjykhjcVaFGEHrMawIoAtMxedK7ZOGXidkE
 UABUL1KMKB4npGEV6d1YCYyfKlKN4IrcBoR0z8viuiBVw2E8W6unSjjp+GICMgdNMYad
 WT7F8TKg995hXirEKBbacNZ8Eu2TrXevddKBp+gVEYw4msGo7Nfrb53E1w3qjPxNuGCN
 NKrygTPUDp2yFhZy77qhFBdbvtGa7omgfemi+wZPLmvZVBN/iOsv9dJlKaz1GGzfx7QQ
 lhiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795781920; x=1796386720;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=M3+53CL9E7t0kgo4XELs9bJ+0tvf7YuCDNZDOGzql0s=;
 b=B6QljjuY02CEDFePI3M6tR4BJzs7SdcVh6zyCSLh82k+2FOHL31AjsbGDWQP9KoOav
 P9gHNH9rM9QfkMxFuRjJ+SRZ6gIO5z1Htqyel25ErxB2z9kUQZ0E0B4M2r2bDHUWDF4e
 V+Wnh4ZCU9UMN2y73Llni+S5kB4fKQBLIujlemqQppXK+rp41caLJdUvk9QVPLSC57kW
 nx5Rc9vBoOGOK8Yg0S9kEngyzUrAux2p0JNI5p5Fx9r8bfleO0RD1t++eDK+4WE8TzIV
 mfm7MUxo3x+ev7UN/mV+oclaQDPcawp+O+kgad2Fcd7wEOgUOZKkOsRl9GKYZMCy6yZB
 W/uw==
X-Forwarded-Encrypted: i=1;
 AL+hErGJ64f6c50GCd6MHUJ4p+O1z0FcPiT7XsS/n8OY2Ubpnk5MvwuzisfaivUy7P2Sd0nzukR3t9m9VP0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9Yci44NlPHnd4U2ULCYmjRhEM31gAmxjLsqbWfHfPDSGiDugBh
 8x9EFh1OKogwYTXRiJGOrdGHFVtrMXPrGejFT6dTcPvSG90YB4MF67dm1thYWIwjD/I=
X-Gm-Gg: AZFdTZdVb3a9n/veA6/NGBMni9lJQeaFxwEifHmwUKm5SRqoYB7g+5Hm3GAdgEUq4o8
 iALko3FyKxva5UsgUXllx1AP9GjGGOSnBkLR1L3jjqV6FQ+dxQS/Fj7hvRej1r15f6O6G+SAW00
 MAERffE2/fAY0tz7l1qqMkj00CrNR6GiRdsZlaZB6rYxm4OtglaxESOYpzY4sMnXkbZWWVGbfZ6
 rZ1l654I/30NcFC9U8c20XdSXPHrc/+aqdesHfb4tMBi/4LWefBmukOVhyXNPaafu9BpDfDdjZ0
 KLWCkLz14XISaUcn8DUxAfypdoGCVCjqHIaojju669/8PlObuVLrKdo7HFb7Y0/4YUTP0sNYNdX
 j+hdWNAQtwvcIbiIx+aPXOmS3SW5pwCFT1YThTgYwoAZbM848yyCX1FYYDXoutJpbMf9Oou7MM/
 lDjM8gobVkYlx5BKJqdqdXLZ33abRHuvcu6IssBRWgf7srfEd2hMObAXLfwgSBZ2EiyCx2udK0r
 iUeei1GUx4Kaxv9ru6uWqov+ZO1YBX0sLj1V2OREpuBDQgP0647Es4w/pIYZbAqrpbVmdS0oBW+
 f35cQR1J1TrAOto02yho1+7t/1K3Tq4bry8mjG2cyevinRgbNg==
X-Received: by 2002:a05:600c:4584:b0:4a7:c366:d791 with SMTP id
 5b1f17b1804b1-4bb887e266amr473913555e9.1.1795781919627; 
 Fri, 27 Nov 2026 04:18:39 -0800 (PST)
Received: from localhost ([195.94.148.180]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb884a15absm627117115e9.9.2026.11.27.04.18.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Nov 2026 04:18:39 -0800 (PST)
From: Andrea della Porta <andrea.porta@suse.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank Li <Frank.Li@kernel.org>, dmaengine@vger.kernel.org,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 Florian Fainelli <florian.fainelli@broadcom.com>,
 Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>,
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Saenz Julienne <nsaenz@kernel.org>, Stefan Wahren <wahrenst@gmx.net>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Phil Elwell <phil@raspberrypi.com>, Dom Cobley <popcornmix@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, David Airlie <airlied@gmail.com>,
 dri-devel@lists.freedesktop.org, Jaroslav Kysela <perex@perex.cz>,
 Liam Girdwood <lgirdwood@gmail.com>, linux-mmc@vger.kernel.org,
 linux-sound@vger.kernel.org, linux-spi@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Mark Brown <broonie@kernel.org>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Simona Vetter <simona@ffwll.ch>, Takashi Iwai <tiwai@suse.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Ulf Hansson <ulfh@kernel.org>
Subject: [PATCH v4 00/28] dmaengine: bcm2835: add BCM2711 and BCM2712 40-bit
 DMA support
Date: Fri, 27 Nov 2026 13:21:50 +0100
Message-ID: <20261127122236.4976-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 28 Nov 2026 09:41:00 +0000
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The BCM2711 has 4 DMA channels with a 40-bit address range, allowing them
to access the whole memory of a Pi 4, and the BCM2712 has 6 of them. This
series adds support for them to the bcm2835-dma driver, on top of the
platform abstraction from Stefan Wahren and some features from the
downstream Raspberry Pi kernel.

The main change since v2 is the handling of the slave (peripheral)
addresses, as requested in the v1/v2 discussions [1][2][3]: instead of
hardcoding the 0x4_0000_0000 offset of the 40-bit channels and relying on
clients passing pre-translated VideoCore bus addresses, the clients now
pass CPU physical addresses and the DMA driver translates them with
dma_map_resource(). Since the conversion of dma_map_resource() to
dma_map_phys() with DMA_ATTR_MMIO, the dma-direct implementation honours
the dma-ranges of the device, which was the open question raised by
Robin in [1].

To keep old device trees working (they only describe the RAM in
dma-ranges), the driver detects at probe time whether the peripheral
window is described in dma-ranges, by looking up its own registers, and
otherwise falls back to reverting the translation given by the ranges of
the parent bus, as suggested by Dave in [3]. Addresses outside of the
ranges are passed through, so that out of tree clients still providing
bus addresses keep working with old device trees. The same fallback
works for the BCM2712 40-bit channels, whose bus maps the peripherals
1:1, while the BCM2711 40-bit channels see the peripherals 16 GiB above
their VideoCore bus address, which cannot be derived from the ranges:
they require dma-ranges, which all the device trees describing them
(the downstream ones and the one added here) provide.

Structure of the series:

  1:     coding style
  2-5:   flags of the DREQ cell (binding and header) and their support
         from downstream (per-channel flags, wide accesses, bursts)
  6-7:   generic dma-channel-mask property
  8-13:  hardware abstraction (Stefan Wahren)
  14-19: slave address translation with dma_map_resource(), conversion
         of the clients (spi, mmc, ASoC, vc4 HDMI) and dma-ranges of
         BCM283x
  20-23: BCM2711 40-bit channels
  24-26: BCM2712 40-bit channels
  27:    DMA flags for the HDMI audio of BCM283x
  28:    HDMI audio on BCM2712 through the 40-bit channels

Changes in v4:
- Drop "dmaengine: bcm2835: Fixes for dma_abort": it brought back the
  NEXTCONBK/ABORT sequence that commit 9e528c799d17 ("dmaengine: bcm2835:
  Fix abort of transactions") replaced, and it is not needed for the
  40-bit channels, which have their own abort sequence (sashiko, Frank).
- Do not add the peripheral window to the dma-ranges of the BCM2711 soc
  bus: it would raise the limit computed by of_dma_get_max_cpu_address()
  and thus the arm64 ZONE_DMA beyond the 1 GiB the legacy DMA masters
  can reach. The BCM2711 legacy controller keeps using the ranges
  fallback (sashiko).
- Map the slave FIFOs with the direction of the accesses of the DMA
  controller (DMA_TO_DEVICE for the source, DMA_FROM_DEVICE for the
  destination), they were swapped (sashiko).
- Keep the slave address translation across device_config() calls when
  the address does not change, instead of remapping it at every MMC
  request (sashiko).
- Clear the dreq of a channel when it is released, so that a later
  memcpy user does not inherit the DT flags of the previous client
  (sashiko).
- Pass the prep flags to bcm2835_dma_prepare_cb_extra() for cyclic
  transfers in the patch introducing it, which disabled the period
  interrupts until a later patch (sashiko).
- Translate the S_IGNORE/D_IGNORE bits into the IGNORE bit of the
  SRCI/DESTI registers of the 40-bit channels (sashiko).
- Add include/dt-bindings/dma/brcm,bcm2835-dma.h defining the flags of
  the DREQ cell and use it in the driver and in the device trees
  (Frank).
- Split the binding patch: the flags of the DREQ cell are now documented
  before the driver patches using them, the generic dma-channel-mask in
  a separate patch (Stefan).
- Use FIELD_PREP()/FIELD_GET() for the register fields (Frank).
- Make need_src_incr()/need_dst_incr() only consider the supported
  directions (Frank).
- Reword the deprecation warning of brcm,dma-channel-mask (Frank).
- Describe all the CS flags in the commit message of the per-channel
  flags patch, and explain that the specifier flags are never written to
  the hardware as they are (Frank).
- Fix the commit message of the first patch, the typo had already been
  fixed (sashiko).
- Document the cfg member of struct bcm2835_dmadev in the patch adding
  it.

Changes in v3:
- Drop the hardcoded addr_offset, translate slave addresses with
  dma_map_resource() in device_config() and unmap them on
  reconfiguration and when freeing the channel.
- Convert spi-bcm2835, mmc/bcm2835, bcm2835-i2s and vc4_hdmi to provide
  CPU physical addresses, and describe the peripheral window in the
  dma-ranges of the BCM283x/BCM2711 soc bus.
- Put the BCM2711 40-bit controller in its own bus, whose dma-ranges map
  the peripherals at 0x4_7c000000, instead of the scb bus, to not change
  the DMA configuration of PCIe and GENET and to avoid refactoring the
  entire DTS to fit the cell size.
- Fix the abort sequences, which were swapped between the legacy and the
  40-bit channels, breaking terminate_all on all the Raspberry Pis.
- Fix the interrupt acknowledge of the 40-bit channels, which used the
  INTEN bit of the TI register instead of the INT bit of CS.
- Make the abort sequence a platform callback, drop the CS/TI masks only
  used by it.
- Keep the period handling of bcm2835_dma_create_cb_set_length(), which
  v2 changed to flag every control block of cyclic transfers.
- Use the platform cb_append_extra() callback for every control block,
  and convert every control block address with to_cb_addr().
- Preserve the width and burst settings of SRCI/DESTI when setting the
  addresses of slave_sg transfers.
- Fix the argument order of cb_init() in the patch introducing it, to
  keep the series bisectable.
- Fix the free_irq() cookie, which did not match the request_irq() one.
- Derive the first channel of an instance from the physical register
  address instead of the ioremap()ed one, initialize all the IRQ array
  entries, and split this into its own patch.
- Refuse to probe the 40-bit channels if dma_addr_t is 32-bit wide, and
  avoid shifting dma_addr_t by 32 bits.
- Include linux/bitfield.h, fixing COMPILE_TEST builds.
- Drop the unused bcm2835_dma_count_frames_for_sg(), resurrected by a
  rebase, and the dead code and duplicated defines of the 40-bit patch.
- Split out the style changes from the 40-bit patch (Stefan), reword the
  subject of the first patch (Florian).
- dt-bindings: sort the compatibles (Krzysztof), document the flags in
  the DREQ cell (Stefan), allow the generic dma-channel-mask, constrain
  the interrupts of the new compatibles. The Acked-by of v2 has been
  dropped because of the additional changes.
- Use the generic dma-channel-mask in the new nodes (Krzysztof).
- Use the DMA specifier flags for the HDMI audio channels of BCM283x,
  so that patches 2-4 have in-tree users (Stefan)
- Describe in the platform data which channels of the DMA block use its
  programming model and ignore the others, so that nodes describing
  channels with another model under the same compatible (as the
  downstream BCM2712 device tree does) are not driven with the wrong one.
- Add BCM2712 support.

Backward compatibility with installed device trees:
- Upstream device trees without the peripheral window in dma-ranges keep
  working through the ranges fallback, which yields the same bus
  addresses the clients used to provide. This includes the BCM2711
  legacy controller with the new device trees, as its peripheral window
  is not added to dma-ranges.
- Downstream Raspberry Pi device trees already describe the peripheral
  window in dma-ranges (for both the soc and scb buses), and their
  40-bit controllers are handled through dma_map_resource().
- The node of the downstream BCM2712 device tree describing channels 0-5
  is rejected instead of being driven with the wrong programming model.
- The current upstream device trees do not describe any 40-bit DMA
  controller, so the new compatibles have no legacy to support. A
  brcm,bcm2711-dma node without dma-ranges makes the probe fail instead
  of programming wrong addresses.
- Older kernels booted with the new device trees are not affected: the
  extra dma-ranges entries do not change the DMA limits of the existing
  devices and the new nodes use compatibles unknown to them.

Not supported yet: No device tree consumer is converted to the 40-bit
channels either.

This patchset has been tested on Rpi3/4/5 with both downstream and
upstream DTBs. The upstream DTBs have been customized to allow for several
peripherals (SPI, I2S, HDMI audio, mem2mem) to be tested against dma40,
an example of which can be found in patch 28.
Future patches will convert said consumer nodes to use the new dma
controller.

This version has been prepared with the help of an AI coding assistant
(Claude Opus 5.5).

[1] https://lore.kernel.org/linux-arm-kernel/ee19a95d-fe1e-4f3f-bc81-bdef38475469@arm.com/
[2] https://lore.kernel.org/all/CAPY8ntCcz7ysTq_78Rb8ohLLETTYZeoZ3DXdPFvDLAkPc9jPWw@mail.gmail.com/
[3] https://lore.kernel.org/all/CAPY8ntByJYzSv0kTAc1kY0Dp=vwrzcA0oWiPpyg7x7_BQwGSnA@mail.gmail.com/

Previous versions:
v3: https://lore.kernel.org/all/20261123145728.29082-1-andrea.porta@suse.com/
v2: https://lore.kernel.org/all/cover.1710226514.git.andrea.porta@suse.com/
v1: https://lore.kernel.org/linux-arm-kernel/cover.1706948717.git.andrea.porta@suse.com/

Andrea della Porta (25):
  dmaengine: bcm2835: Fix coding style issues
  dt-bindings: dma: brcm,bcm2835-dma: Document the flags of the DREQ
    cell
  dt-bindings: dma: brcm,bcm2835-dma: Allow the generic dma-channel-mask
  dmaengine: bcm2835: Support common dma-channel-mask
  dmaengine: bcm2835: move CB info generation into separate function
  dmaengine: bcm2835: move CB final extra info generation into function
  dmaengine: bcm2835: make address increment platform independent
  dmaengine: bcm2835: drop info parameters
  dmaengine: bcm2835: pass dma_chan to generic functions
  dmaengine: bcm2835: introduce multi platform support
  dmaengine: bcm2835: Use dma_map_resource() to translate slave
    addresses
  spi: bcm2835: Pass the CPU physical address of the FIFO to the DMA
    engine
  mmc: bcm2835: Pass the CPU physical address of SDDATA to the DMA
    engine
  ASoC: bcm2835-i2s: Pass the CPU physical address of the FIFO to the
    DMA engine
  drm/vc4: hdmi: Pass the CPU physical address of MAI_DATA to the DMA
    engine
  ARM: dts: broadcom: Describe the peripheral window in dma-ranges
  dmaengine: bcm2835: Support channel subsets in a controller instance
  dt-bindings: dma: brcm,bcm2835-dma: Add BCM2711 40-bit DMA
  dmaengine: bcm2835: Add BCM2711 40-bit DMA support
  ARM: dts: bcm2711: Add the 40-bit DMA controller
  dt-bindings: dma: brcm,bcm2835-dma: Add BCM2712 40-bit DMA
  dmaengine: bcm2835: Add BCM2712 40-bit DMA support
  arm64: dts: broadcom: bcm2712: Add the 40-bit DMA controller
  ARM: dts: broadcom: Set the DMA flags of the HDMI audio channel on
    BCM283x
  arm64: dts: broadcom: bcm2712: Enable HDMI audio

Dom Cobley (1):
  dmaengine: bcm2835: Support dma flags for multi-beat burst

Phil Elwell (2):
  dmaengine: bcm2835: Add support for per-channel flags
  dmaengine: bcm2835: Add NO_WAIT_RESP, DMA_WIDE_SOURCE and
    DMA_WIDE_DEST flag

 .../bindings/dma/brcm,bcm2835-dma.yaml        |   89 +-
 arch/arm/boot/dts/broadcom/bcm2711.dtsi       |   32 +
 .../arm/boot/dts/broadcom/bcm2835-common.dtsi |    5 +-
 arch/arm/boot/dts/broadcom/bcm2835.dtsi       |    3 +-
 arch/arm/boot/dts/broadcom/bcm2836.dtsi       |    3 +-
 arch/arm/boot/dts/broadcom/bcm2837.dtsi       |    3 +-
 .../boot/dts/broadcom/bcm2712-d-rpi-5-b.dts   |   15 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |   31 +
 drivers/dma/bcm2835-dma.c                     | 1217 ++++++++++++++---
 drivers/gpu/drm/vc4/vc4_hdmi.c                |   16 +-
 drivers/mmc/host/bcm2835.c                    |   20 +-
 drivers/spi/spi-bcm2835.c                     |   27 +-
 include/dt-bindings/dma/brcm,bcm2835-dma.h    |   27 +
 sound/soc/bcm/bcm2835-i2s.c                   |   19 +-
 14 files changed, 1259 insertions(+), 248 deletions(-)
 create mode 100644 include/dt-bindings/dma/brcm,bcm2835-dma.h

-- 
2.51.0

