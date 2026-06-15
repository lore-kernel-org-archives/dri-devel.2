Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3915CD98D6
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DA610E22B;
	Mon, 15 Jun 2026 07:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lRlWeVky";
	dkim-atps=neutral
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90BD810E1FB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:50:11 +0000 (UTC)
Received: by mail-dl1-f42.google.com with SMTP id
 a92af1059eb24-137d464c47eso2221372c88.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781506211; x=1782111011; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=su7U2CceZXD6mEz8ItmrZ6WCGP9Vn5IoVvW2JAEM0p0=;
 b=lRlWeVkyxM+cgHhxy1odx59Q0AES3ewGFDWdeG6qDTZQgYugM7PSb9YA1TFYml3yxY
 ZwNYRz6RDTcfjt8kVTdMTRBbhuM/4VowBGN26xzabBJ1XYoLbv2lfiJaPWCrWM2hhU5J
 pGIqrjmC2r4WfxS+7WsCxQTMJR5psh9izaSI7o3M9OFrhcCEPAZP9Eo5Y7ki86tkbD81
 MEWys/LTBxrrJszs/fW+ridINEoDnbhSwKxKDqtaeE8iYHV790+na13LSWOH1+FILFHR
 fAIX56lpAymB9YGwCDXwtxL5djcn0yj4bRJ34/KekwfmXAfYWXUrSPGrYJ9gGXuXOrRD
 NULg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506211; x=1782111011;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=su7U2CceZXD6mEz8ItmrZ6WCGP9Vn5IoVvW2JAEM0p0=;
 b=RROfq6a1mLxcGSmwfwQPboHT+i3Y2J9QscMHKY9UmqhVCOn6FPCrkOoTooFnR10zt/
 60Txw34n0MSYv+UJNOFmETe9zwbet2KiIxhvklhwgUGByszfeVoQN/WCf2ZU04RpE8v+
 QLTk8itVudliDvsMRnMNSG7pEyUEQX1OSLH8+/NCi7AocnnJAmUhsZ8GVjcM0V9GpPs2
 RwcT5Ld2UOqddCACMQiSW0b6HzNSD8D1dscp1HYloMPleTyLe3cfPmgwDHSXQBWwQcjT
 niRLFFmObXvi+Yac5bwxIc33NS1BNVowk/5alXGYXZTx5QwtAAmL/XatyGUN0T6sD3zB
 dI+A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dcrpu8Dw3/h/VgKF97Z3dfPRxo7hFPkW2GioZWv924X+NJuKAmflmD/zVXQpdnR23+c0gTVBtw2k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwEI8eXQtxhBRkey+dfYNazKnggp0iPzmI7Vo4njB+bjU3C8Ub0
 Dj0cAlvGPAwS2R9bAvNY0k03ouoLJRefFWE8DlRXVvUzHAbuVaY1pxCG
X-Gm-Gg: Acq92OEOf0tF1wV37ApYCDU9jyNaJEklnKtXbtfPaFUvC5469ULaJwS/518dqwt3lCI
 cZcHK2SLOrPUfuo/BjdmFnNiY2LQt/ycAShDYzkjGILPiuDUiNDJmaVF1X4jXHldb6DXiaKJBNz
 kcirM37L0LPj149vIwzw7TKGwdZ7sdb8PuYeKUuvuDt//H+bSvbgubN23xiYrCkV4U/k5GZQxBo
 BVO6PJRaCUFhV4ZPYrgnNDYK1PgBjJgq6WMFPPZA9nqsF08kO+x0ybOT86UdukLuLM6ZArCP0pL
 Q8pZYGECXkBfvuaLWbP73KGZizSrW4gvjy10cmSRQnXDWwYP6MfyKXod/FXgTtOtzy5Z6TqMEoe
 O1MijXnEi2uM8OiGok2SwFK50PZ2CdTNaMEoJwn6K40dLWhZww/HTDFeO5L/nQSZyL64Vr3YQjC
 NvQfppH/j/HTZxh+SLIAugGtySlQ2p+MQaxTywFAE99N2u+4vDwpAp3W8fIycHTY2olD930OXYY
 4DOGe0ZrVbQ
X-Received: by 2002:a05:7301:9f09:b0:304:70d0:4f03 with SMTP id
 5a478bee46e88-30820c2d782mr6607439eec.6.1781506210508; 
 Sun, 14 Jun 2026 23:50:10 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb9a2e7sm13516812eec.30.2026.06.14.23.50.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 23:50:10 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v4 0/6] drm/verisilicon: add Nuvoton MA35D1 DCU Lite support
Date: Mon, 15 Jun 2026 14:49:57 +0800
Message-ID: <20260615065003.76661-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jun 2026 07:58:00 +0000
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
vs_dc8200.c; the DC8000 ops in vs_dc8000.c with the necessary
clock-optionality changes; and finally the DCUltraLite HWDB entry that
gates hardware recognition once all support is in place.

Patch 6 adds the Kconfig dependency on ARCH_MA35, placed last because it
is only meaningful after the HWDB entry is added.

All patches have been tested on Nuvoton MA35D1 hardware.

Changes from v3:
  - [dt-bindings] Reverted extra space before inline '#' comment.
  - [dt-bindings] Moved clock/reset items descriptions from the top-level
    clocks:/resets: into the per-variant allOf/if blocks; kept only
    minItems/maxItems at the top level.
  - [dt-bindings] Restored full items lists for clock-names and reset-names
    at the top level with minItems so names are still validated.
  - [dt-bindings] Added minItems: 1 to resets: in the nuvoton block.
  - [dt-bindings] Added required: [resets, reset-names] inside the then:
    block for both thead,th1520-dc8200 and nuvoton,ma35d1-dcu.
  - [dt-bindings] Added minItems: 3 to reset-names in the thead block.
  - [dt-bindings] Added maxItems: 1 to reset-names in the nuvoton block.
  - [dt-bindings] Reverted unevaluatedProperties: false back to
    additionalProperties: false.
  - [dt-bindings] Removed the second DT example for nuvoton,ma35d1-dcu
    since a difference in clocks/resets does not need a new example.
  - [ops] Renamed bridge_enable/bridge_disable to panel_enable_ex/
    panel_disable_ex.
  - [ops] Renamed irq_handler to irq_ack.
  - [ops] Renamed plane_enable_ex/disable_ex/update_ex to
    primary_plane_enable_ex/disable_ex/update_ex.
  - [ops] Renamed vs_dcu_lite.c to vs_dc8000.c, all internal functions
    from vs_dcu_lite_* to vs_dc8000_*, exported symbol from
    vs_dcu_lite_funcs to vs_dc8000_funcs; updated Makefile.
  - [kconfig] Moved ARCH_MA35 Kconfig change to a separate final commit,
    placed after the HWDB entry.

Joey Lu (6):
  dt-bindings: display: verisilicon,dc: generalize for single-output
    variants
  drm/verisilicon: add register-level macros for DC8000
  drm/verisilicon: introduce per-variant hardware ops table
  drm/verisilicon: add DC8000 (DCUltraLite) display controller support
  drm/verisilicon: add DCUltraLite chip identity to HWDB
  drm/verisilicon: extend Kconfig to support ARCH_MA35 platforms

 .../bindings/display/verisilicon,dc.yaml      |  80 +++++++++++--
 drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
 drivers/gpu/drm/verisilicon/Makefile          |   2 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c       |  20 +---
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  38 ++++++-
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h    |   1 +
 drivers/gpu/drm/verisilicon/vs_dc.c           |  13 ++-
 drivers/gpu/drm/verisilicon/vs_dc.h           |  33 ++++++
 drivers/gpu/drm/verisilicon/vs_dc8000.c       |  78 +++++++++++++
 drivers/gpu/drm/verisilicon/vs_dc8200.c       | 107 ++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_hwdb.c         |  14 +++
 drivers/gpu/drm/verisilicon/vs_hwdb.h         |   6 +
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  32 +-----
 .../drm/verisilicon/vs_primary_plane_regs.h   |   3 +
 14 files changed, 368 insertions(+), 61 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c

-- 
2.43.0

