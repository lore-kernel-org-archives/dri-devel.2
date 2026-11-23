Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DAD4606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=google header.b=cMa0ZAgK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7310010F350;
	Tue, 24 Nov 2026 08:39:52 +0000 (UTC)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE0B710E7C0
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 14:53:34 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-4bb64ef5a14so35946265e9.1
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 06:53:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=suse.com; s=google; t=1795445613; x=1796050413; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lA6oYuprAkHK4elm//iRd0jX7g4QWezwyzygSAeIMm4=;
 b=cMa0ZAgKTXrz9oM7QiwSBfRikW2ozFTm2zN7v4CZereEB9dMCQa9j75KLbu3tTGdhe
 CjKgh7hJBJu0sWoc96ED+S7v8CIW8yoKWWHPtT5X2lEAhvRrDigFa5jRh+qvt+j4RE+x
 KMXl/Z9JQ6ll2PyPB12CKP1ZcCqdNgG8kJNCzmQmknWp4W4m2G9LyZgKb70KgN0+LCLb
 5zy/LCSmlUzsZ4zPBzFk9aE0wvmjZk29bp7QPdvSdXojknj2rkT8NeD8xnkhynifxKcC
 PDDSjNsenlN5fvauVgjjdhLZFYMwNKl/R2OWwr6pdQoN8ht2wwR26V25QHKMRMNvR+u3
 i9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795445613; x=1796050413;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lA6oYuprAkHK4elm//iRd0jX7g4QWezwyzygSAeIMm4=;
 b=Lib9feUUObYO4w09ZPjqwcQUWqPtXXOxszdbdiG2BQyjWIRlkedUiXi4AGUfByrMEg
 91HafslSL8tbwyDiH47rup1BMrTm0sXRRlxzkN2glBsQhxKt705rQvhxcxBvHngykSrs
 xWKvQHdN5QvTXNfYnNC8hhRAyNZVJrYTMy8XaBiae/9WDLOYJF+mfXxXKltS0NRcDcrx
 EwIc1m1/CelmmpQQchCG8lW82jBhgPeIuh28QAYjAx+JnqvOzd/02Hb+nveX8mL0uCpP
 F2NirIPuOE6OUFMnD6hGtzUC2qBhkGXL8xx0+lFifZohQttXod8pLTHIAfkdK8Pm+/5o
 ZXBw==
X-Forwarded-Encrypted: i=1;
 AL+hErEygCVMZJt2NFn+FBSXTEbTWAcN7HpzYm57t2XEmyq45IIZXIC2niNOfvd55NeEJPBAI2KfggvAYoQ=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9PSAJtYpawAcrIPX14+BqLkIWtF2mQvmHTr8POPLzOUe6Rboka
 UOt9qzg5jEkR1umCUKiDD0XqZKyAE/H6fbebp6a5wBJ6qCmYyTZ6rI5vFQ0uN46OC4c=
X-Gm-Gg: AZFdTZdLgqsj6pyrBOvh2GRToDQbAuDu2gak+063H4zG4JSIxAKHEwxjKWrlnwCae6a
 wgCF/e9iqeZEZBHn6Al2AFOIbd6CJLphxP53VBPGrYOg1VlTNdr9gi/xp3N2vuVgjFeyVnPArSb
 5yLT6wV8sHifSxQaQfDfOnIc6oJecU2tti4gqAoW9HSDqBUbp68oJIpSyP9I6in6B67Go2NFnyy
 aJOK0CMBOWpQhYkHdhArje2AhTz4EKsq0laWsoE5NsWh0V07WLzdIV+ITwNOOdzwzLlZETbnXvl
 EHtHdn6IIXybhrcHcMehL2R0JU40N3eIFmTEP3LT/PE+SffBL7AczQqx2facXMpdOpGem5unzOZ
 x1Fy4uryTGjuwZdpoUSGwN40Wb6xaZ5hU3mXHOP7n/cek8bKIQvvfmEGT1UPYpkS+TCB587tGNF
 CQV4dJdLVes78uT7Q0BCQ1p8wVD3reITpsBJveu/QnI8fkSwUs9bGdGdD9VgJIgtlLUKoFobOjB
 GkwBjcbuHEzdvMVMEAlTgbEvu8WFH11tK3k2+3wBcKNGy+oikkimMeeydkqsfODb4wfs3C9/d2h
 mXB6YztjEkyT/2jMBENthFvxyBef
X-Received: by 2002:a05:600c:4e4c:b0:4b6:5dac:b61e with SMTP id
 5b1f17b1804b1-4bb88938d2dmr220141985e9.32.1795445613020; 
 Mon, 23 Nov 2026 06:53:33 -0800 (PST)
Received: from localhost ([82.192.120.76]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb9066f6e6sm142773895e9.3.2026.11.23.06.53.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 06:53:32 -0800 (PST)
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
Subject: [PATCH v3 00/28] dmaengine: bcm2835: add BCM2711 and BCM2712 40-bit
 DMA support
Date: Mon, 23 Nov 2026 15:56:38 +0100
Message-ID: <20261123145728.29082-1-andrea.porta@suse.com>
X-Mailer: git-send-email 2.51.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 24 Nov 2026 08:39:44 +0000
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

  1-5:   preparatory patches and features from downstream (per-channel
         flags, wide accesses, bursts, abort fixes)
  6-7:   generic dma-channel-mask property
  8-13:  hardware abstraction (Stefan Wahren)
  14-19: slave address translation with dma_map_resource(), conversion
         of the clients (spi, mmc, ASoC, vc4 HDMI) and dma-ranges
  20-23: BCM2711 40-bit channels
  24-26: BCM2712 40-bit channels
  27:    DMA flags for the HDMI audio of BCM283x
  28:    HDMI audio on BCM2712 through the 40-bit channels

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
  addresses the clients used to provide.
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
v2: https://lore.kernel.org/all/cover.1710226514.git.andrea.porta@suse.com/
v1: https://lore.kernel.org/linux-arm-kernel/cover.1706948717.git.andrea.porta@suse.com/

Andrea della Porta (24):
  dmaengine: bcm2835: Fix coding style issues and a typo
  dt-bindings: dma: brcm,bcm2835-dma: Document dma-channel-mask and DREQ
    flags
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

Dom Cobley (2):
  dmaengine: bcm2835: Support dma flags for multi-beat burst
  dmaengine: bcm2835: Fixes for dma_abort

Phil Elwell (2):
  dmaengine: bcm2835: Add support for per-channel flags
  dmaengine: bcm2835: Add NO_WAIT_RESP, DMA_WIDE_SOURCE and
    DMA_WIDE_DEST flag

 .../bindings/dma/brcm,bcm2835-dma.yaml        |   88 +-
 arch/arm/boot/dts/broadcom/bcm2711.dtsi       |   40 +-
 .../arm/boot/dts/broadcom/bcm2835-common.dtsi |    3 +-
 arch/arm/boot/dts/broadcom/bcm2835.dtsi       |    3 +-
 arch/arm/boot/dts/broadcom/bcm2836.dtsi       |    3 +-
 arch/arm/boot/dts/broadcom/bcm2837.dtsi       |    3 +-
 .../boot/dts/broadcom/bcm2712-d-rpi-5-b.dts   |    9 +
 arch/arm64/boot/dts/broadcom/bcm2712.dtsi     |   26 +
 drivers/dma/bcm2835-dma.c                     | 1229 ++++++++++++++---
 drivers/gpu/drm/vc4/vc4_hdmi.c                |   16 +-
 drivers/mmc/host/bcm2835.c                    |   20 +-
 drivers/spi/spi-bcm2835.c                     |   27 +-
 sound/soc/bcm/bcm2835-i2s.c                   |   19 +-
 13 files changed, 1229 insertions(+), 257 deletions(-)

-- 
2.51.0

