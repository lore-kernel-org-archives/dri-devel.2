Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CD2FC79FB8
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:56:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 151F810EF49;
	Wed,  9 Sep 2026 06:55:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="XRCclNhH";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50D2110EAE6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:28:48 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3856d6fbcb3so3553935a91.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:28:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788859728; x=1789464528; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1cMT7fKgP+zuYY8ESvwdYk2VGfHp7bRIw/gwcfnHbX4=;
 b=XRCclNhHy/oUW/Qy02BOJsfSo85RwAxwgE+bzx2W06sqZWj4XSq0y/4bhvTwoFgjZb
 eg9Aa1I5Z6tUIrR7xCnjPhftJkACm2BaPle3pr28oU0VaWwPwrtfqsEBFgNIdOXoFZJ0
 tx4V6nW8v1AyKdP6uMrKaASgnYcaCejS8HCpRiBCIZAjq24AInPoxgqzdFaSGPjaAeIs
 DojTyANvP11AF5za/lOE1U5gT86XD6NTfV/DG4f5uZ7AkXHmWfuXFltpoe8EasCGhij0
 bkKGr5Mth2yTZ4HXYsVcY0Z2a/gpKntwq0bliF0CFKzJ7Fj9wHUfIYd3WF5Fu6BMyIBa
 2xoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859728; x=1789464528;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1cMT7fKgP+zuYY8ESvwdYk2VGfHp7bRIw/gwcfnHbX4=;
 b=qr0mPqu56w2RsCIyZCMQYqk41lZsjeGKMyGa+ZhcEcBfeUir8J6zbrFut6xvld2zH2
 +u/ulSeqFKNjW6OFnDeZeRqvBIk0hjdnTldu5hZAkTl5t33AHGImPsbwdo4gLaKngaO2
 d93sz7uh9P2lEV5NjV8/4m2LIli1H7f90dfNsQcC6/fRyLWF73ZCW6YxdmB3YPKmoydN
 YOM8LRd93VbL81hW98wwsQZSL2dxVF2XG5DHOURc0+VTwUKNjMRVB3Rze4ABEpgXx15Q
 bJQYSairLQexBpuhM7I9Zcy1m7i6t4LqakdgSCl8NAIU1REd0M51Vff9DJ2FVRJeTW+f
 tgUQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz0NRI0iWHwKxpML+Eal5BWvxTCvXZY1ihSoed0i4eRIRiL6PoA0Q2j3AHq7Sh3JVcrWgSaoqgymao=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k7opb60xIba8S723nF3pWo45DkZbQxSusLhW5R2Zu21IVybojX
 B/SaTvO/ntn1Er2qmOy7xyrCwDLlLMeN1LZ7Nkosgw/PgAY/25/Ge/BX
X-Gm-Gg: AYBFou35WwEACjpolD51YLW20rPYlRkcyyuo2eW4nG/HBZH5Ss5xiXHWsh8QSmeZhID
 Bs5rs7PctFhtiL3i1CoNQ3J9xLQJVvbH0WAJzOgJE7UrP/TGZfU/VCNHi9q1e+4hgGb7GlVaoLZ
 V5d8x1ybRzYo3EUx7GO9xzUcm1KQl3utyh+YdvYhTPp0QZHrMYkm/+0aWhIs1PioWC2Th+i2mcy
 Xa/zTaGDqY1QR4NNY08mSFSEB7zLgOEF2SVvpMCjAfuIbo+HGDSRgs0dJvsv6T9530QhmfpnvUi
 5Le0B5NdLC5KDro8c/KCBqVK3x/Vv7xGJE4JKpwpqqgmO8aCd853VJRtbNuqP0I9dci3u9mjyeo
 Uw5mMqxmvNJQ/Ont4K2kfn1XLit5WFzhJdg0quMsFnJ/dbv8sPZxJ7xyMO7l7H+O+1T4NUQBK4Q
 sruha1IovctqCGHskvaXmMuWXR2JzGBppnCYgf7pUKZdFllUsSLbYs8pWvUADjv/WqsClZtDeNN
 yCFewXBpF5Y4OR9rerp1KsVSnnqE+NTwZERPjVh6Al0IM2iacUWDglFDKaVTiI=
X-Received: by 2002:a17:90b:394e:b0:37f:fd1f:d30f with SMTP id
 98e67ed59e1d1-39b26272d76mr43048844a91.12.1788859727665; 
 Tue, 08 Sep 2026 02:28:47 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm32109846a91.9.2026.09.08.02.28.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:28:47 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v6 0/6] drm/verisilicon: add Nuvoton MA35D1 DCU Lite support
Date: Tue,  8 Sep 2026 17:28:34 +0800
Message-ID: <20260908092840.225220-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 09 Sep 2026 06:54:46 +0000
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

This series adds support for the Verisilicon DCUltraLite display
controller as integrated in the Nuvoton MA35D1 SoC.

The Verisilicon DC driver and its DT binding were originally written by
Icenowy Zheng <zhengxingda@iscas.ac.cn> for the T-Head TH1520 SoC, which
carries a DC8200 IP block.  The present series builds on that foundation
with gratitude to Icenowy for the original work.

The DCUltraLite is a different variant in the DC IP family.  While the two
IPs share a broadly similar register layout, a number of differences
prevent the existing driver from working on the MA35D1 without
modification:

  - No CONFIG_EX commit path: the DC8200 staging registers
    (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT, FB_BLEND_CONFIG,
    PANEL_CONFIG_EX) are absent.  The DCUltraLite uses enable (bit 0) and
    reset (bit 4) bits in FB_CONFIG for direct framebuffer updates, and
    requires a per-frame VALID bit toggle (FB_CONFIG bit 3) to latch
    configuration changes.

  - No PANEL_START register: panel output begins when
    PANEL_CONFIG.RUNNING is set; the DC8200 multi-display sync start
    register at 0x1CCC does not exist.

  - Different IRQ registers: DISP_IRQ_STA at 0x147C / DISP_IRQ_EN at
    0x1480, versus the DC8200's TOP_IRQ_ACK at 0x0010 / TOP_IRQ_EN at
    0x0014.

  - Simpler clock topology: the MA35D1 clock controller gates the core,
    AXI and AHB clocks with a single bit, so the devicetree supplies the
    same clock phandle for all three; only the pixel clock is distinct.
    No second output port is present, so no pix1 clock is needed either.

  - Single display output: no per-output indexing beyond index 0 is
    needed.

  - Hardware-discoverable identity: the DCUltraLite exposes chip identity
    registers whose model field reads 0x0 (revision 0x5560,
    customer_id 0x305), allowing the existing vs_fill_chip_identity()
    path to identify the variant purely through register reads.

Patch 1 adds the nuvoton,ma35d1-dcu compatible to the verisilicon,dc DT
binding and relaxes the top-level clock/reset item counts so per-variant
allOf/if blocks can constrain each compatible's actual topology.

Patch 2 adds the register-level macros needed by the DC8000 ops.

Patches 3-4 introduce the driver changes in two logical steps: the
vs_dc_funcs hardware ops vtable with DC8200 ops extracted into
vs_dc8200.c, and the DC8000 ops in vs_dc8000.c.  Patch 5 adds the
DCUltraLite HWDB entry that gates hardware recognition once all support
is in place.

Patch 6 adds the Kconfig dependency on ARCH_MA35, placed last because it
is only meaningful after the HWDB entry is added.

All patches have been tested on Nuvoton MA35D1 hardware.

Changes from v5:
  - [dt-bindings] Renamed the patch from "generalize for single-output
    variants" to "add support for nuvoton,ma35d1-dcu", since the binding
    topology itself isn't being generalised, only a new compatible is
    being added.
  - [dt-bindings] Moved clocks/clock-names minItems to 4 and
    resets/reset-names minItems to 1 at the top level (the lowest count
    any variant needs), instead of overriding both minItems and maxItems
    redundantly inside each allOf/if block.
  - [dt-bindings] Kept the thead,th1520-dc8200 allOf/if block, tightening
    it back up to minItems: 5 (clocks) / minItems: 3 (resets), since the
    outer constraint is now looser than what that compatible requires.
  - [dt-bindings] Dropped the nuvoton,ma35d1-dcu clock-names/reset-names
    item overrides entirely: the devicetree will supply all four clocks
    (core, axi, ahb, pix0) and the one core reset in the same order the
    top-level schema already expects, so only maxItems: 4 / maxItems: 1
    are needed to cap the count.
  - [dt-bindings] Dropped the redundant "required: resets/reset-names"
    sub-blocks, now that resets/reset-names are unconditionally required
    at the top level (landed separately by Icenowy Zheng).
  - [driver] Dropped "make axi and ahb clocks optional" entirely: since
    the devicetree will always supply distinct axi/ahb clock properties
    (sharing the core clock's phandle), vs_dc_probe() keeps treating them
    as mandatory via devm_clk_get_enabled(), same as core and pix0.
  - [driver] Added drm_WARN_ONCE() in both vs_dc8200_irq_ack() and
    vs_dc8000_irq_ack() to flag any hardware IRQ bit that doesn't
    translate to a known VSDC_IRQ_* definition.

Joey Lu (6):
  dt-bindings: display: verisilicon,dc: add support for
    nuvoton,ma35d1-dcu
  drm/verisilicon: add register-level macros for DC8000
  drm/verisilicon: introduce per-variant hardware ops table
  drm/verisilicon: add DC8000 (DCUltraLite) display controller support
  drm/verisilicon: add DCUltraLite chip identity to HWDB
  drm/verisilicon: extend Kconfig to support ARCH_MA35 platforms

 .../bindings/display/verisilicon,dc.yaml      |  44 +++++++
 drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
 drivers/gpu/drm/verisilicon/Makefile          |   2 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c       |  20 +--
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  38 +++++-
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h    |   1 +
 drivers/gpu/drm/verisilicon/vs_dc.c           |   9 +-
 drivers/gpu/drm/verisilicon/vs_dc.h           |  33 +++++
 drivers/gpu/drm/verisilicon/vs_dc8000.c       |  92 +++++++++++++
 drivers/gpu/drm/verisilicon/vs_dc8200.c       | 121 ++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_drm.c          |   5 +-
 drivers/gpu/drm/verisilicon/vs_drm.h          |   8 ++
 drivers/gpu/drm/verisilicon/vs_hwdb.c         |  14 ++
 drivers/gpu/drm/verisilicon/vs_hwdb.h         |   6 +
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  32 +----
 .../drm/verisilicon/vs_primary_plane_regs.h   |   3 +
 16 files changed, 375 insertions(+), 55 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c

-- 
2.43.0

