Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F702CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CDFB10F498;
	Fri, 26 Jun 2026 07:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TnrXWh33";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A36910F1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:44:57 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2c7ebfb63c6so9456905ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:44:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782380697; x=1782985497; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Q7LZb4Oyp6MyCiFD5fuuqoWQdDcqkeN2EAojsuCFuQk=;
 b=TnrXWh33XJwbX9glLHXgerWCiXLNNk1tRtw7uIwJ3uIjYpDAZ2L9ofBWUyyV87+uvM
 Yk/zQ2XH14zBzmAHk4ZxJcwc74blSixbRM84bkNnMAgvTBtaIKyvbdXIsZbmzLTj7X0I
 WoeUIOMQXPDJy7VBd+bdYzNvw6dkMSzdsLqjdHDBKzS6aTsuEiI2WloWb+hFwAAv3xnA
 k+d4xAfyITrAkeUljyV4G10A+lMOCE0S70YezR4nj8QE/3vyWeFsGJjyHbhN47vFNLqv
 1tSvhiqJe8q7FxtNBDTINQev7OiXDeRqiBav0OoZR5BjB7v0X08sT8kPdR7yWi4FTfQx
 atxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380697; x=1782985497;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Q7LZb4Oyp6MyCiFD5fuuqoWQdDcqkeN2EAojsuCFuQk=;
 b=A6B6HQSUfABROzaDxzIrRkGkrHhgc8mqUaVUPLy+V51wG9/7dLZ/nvShedfJ1oOFy+
 9pY96bfK9DJunqRyeMbYqJfvPd3fyIGW27ZRRBEqpQ825tfmF3u2a7La5jjx+jgOvfUH
 OZF1ztoEHF6MOfJruOrmvVTvg+YBGfZPiaykt9CndAWZ3vr1S8K8i9D7j07Emjtt+LiJ
 FDPuLPUMcxtSzeSByEFAgfKDdAHebPMH4o1YTJ5bDaxsaJ/2/uKtOtn62XlxOvgX1wf2
 IFVCLrpTq4M8KRMUh92x9irBZc5G1PIaS/VzPFPn+G06/+q4ahR1JXuj2tXBwqmxgZYa
 2kNw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpr1ajFEYk3+GNkSz0E4j/NOn1P4jWyeJbKizni4OvjrFqoqIF6zo1VbdKF0Xv3ZDYenUNlxdQCelM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwtizBpvtrDrWb55rkL6TDGCB6Q3NvFzC5fPcqu1v2aEcjGW4cA
 QW0IP7BQmdSF+hpYee4xWrzngQJFQ1T6gdLLq6/JR8+v+ArIZjJJZHN3
X-Gm-Gg: AfdE7ckYWW0FpJDWtj++3ZE2VNOl2wHyN2G1qUJRcNvc2LoLaZUc5FcPqeGNZvav322
 e9ZGL1k5OfLYAXwMM2ZmA/LkUuqAFwWs4fMm8a0GbbqnHVsaugUghQye2ichJF9tuitXo17xpXU
 fTzvbUiOnoIMGei2bbha1LwcA608DafmxfHHiffkksqCdVZt+Kz4ev/KkxH3dDxbxMLWdW9oxIb
 8flYp/2uP/Ofa1cAiMkQ7AD6WAPNGRCa5z/MgCQ3X95y+Imers2GzNCQmnzCPQeu2vVjYerpZfw
 MLJR3RFHxn946OizIfOUv5fBUaTT+8n2q29hF9dvmsT4p7+s1bH86ja/Eijl+xpIBd+g4mXCbYY
 fUq0TYar4lg7doCWPv81cAkRnnrki3qJOfzKBVl7BfhbxiU52bpr6tPQ+sqpU34j3wMaHkeA4RB
 vVzdYVwGBEUsBVNCJs2hMkA03m+CCQ7CXlCnvv2Rmk61ixojEoKB7ocSI1qDxBqse0rx196qwct
 mvd3P2QJNDj
X-Received: by 2002:a17:902:e843:b0:2c1:a19:8396 with SMTP id
 d9443c01a7336-2c7fca3eeb3mr18687905ad.31.1782380696777; 
 Thu, 25 Jun 2026 02:44:56 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8c26sm16614995ad.1.2026.06.25.02.44.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:44:56 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 0/7] drm/verisilicon: add Nuvoton MA35D1 DCU Lite support
Date: Thu, 25 Jun 2026 17:44:42 +0800
Message-ID: <20260625094449.708386-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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

  - Simpler clock topology: two clocks ("core" bus gate and "pix0" pixel
    divider); no axi or ahb clocks required.

  - Single display output: no per-output indexing beyond index 0 is
    needed.

  - Hardware-discoverable identity: the DCUltraLite exposes chip identity
    registers whose model field reads 0x0 (revision 0x5560,
    customer_id 0x305), allowing the existing vs_fill_chip_identity()
    path to identify the variant purely through register reads.

Patch 1 generalises the verisilicon,dc DT binding to accommodate the
Nuvoton MA35D1 SoC-specific compatible and the variant's two-clock,
one-reset, single-port topology.

Patch 2 adds the register-level macros needed by the DC8000 ops.

Patches 3-5 introduce the driver changes in three logical steps: the
vs_dc_funcs hardware ops vtable with DC8200 ops extracted into
vs_dc8200.c; making axi/ahb clocks optional as a separate atomic change;
and the DC8000 ops in vs_dc8000.c.  Patch 6 adds the DCUltraLite HWDB
entry that gates hardware recognition once all support is in place.

Patch 7 adds the Kconfig dependency on ARCH_MA35, placed last because it
is only meaningful after the HWDB entry is added.

All patches have been tested on Nuvoton MA35D1 hardware.

Changes from v4:
  - [dt-bindings] Kept clock and reset item descriptions in the global
    clocks:/resets: properties; per-compatible sections only constrain
    minItems/maxItems and override clock-names items for nuvoton,ma35d1-dcu.
  - [dt-bindings] Dropped redundant global minItems/maxItems on clocks:
    and clock-names:.
  - [dt-bindings] Dropped the extra-space typo fix in port@0 description
    to keep the patch atomic; left for a separate patch later.
  - [ops] Renamed crtc_enable/crtc_disable hooks to crtc_enable_ex/
    crtc_disable_ex.
  - [ops] Added unified IRQ bit definitions; each irq_ack() implementation
    now translates hardware-specific bits before returning.
  - [clocks] Split the axi/ahb optional-clock change into its own patch
    for atomicity.
  - [hwdb] Simplified the commit message for patch 6.
  - [kconfig] Simplified the commit message for patch 7.

Joey Lu (7):
  dt-bindings: display: verisilicon,dc: generalize for single-output
    variants
  drm/verisilicon: add register-level macros for DC8000
  drm/verisilicon: introduce per-variant hardware ops table
  drm/verisilicon: make axi and ahb clocks optional
  drm/verisilicon: add DC8000 (DCUltraLite) display controller support
  drm/verisilicon: add DCUltraLite chip identity to HWDB
  drm/verisilicon: extend Kconfig to support ARCH_MA35 platforms

 .../bindings/display/verisilicon,dc.yaml      |  57 +++++++++
 drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
 drivers/gpu/drm/verisilicon/Makefile          |   2 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c       |  20 +--
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  38 +++++-
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h    |   1 +
 drivers/gpu/drm/verisilicon/vs_dc.c           |  13 +-
 drivers/gpu/drm/verisilicon/vs_dc.h           |  33 +++++
 drivers/gpu/drm/verisilicon/vs_dc8000.c       |  86 +++++++++++++
 drivers/gpu/drm/verisilicon/vs_dc8200.c       | 115 ++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_drm.c          |   5 +-
 drivers/gpu/drm/verisilicon/vs_drm.h          |   8 ++
 drivers/gpu/drm/verisilicon/vs_hwdb.c         |  14 +++
 drivers/gpu/drm/verisilicon/vs_hwdb.h         |   6 +
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  32 +----
 .../drm/verisilicon/vs_primary_plane_regs.h   |   3 +
 16 files changed, 378 insertions(+), 57 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c

-- 
2.43.0

