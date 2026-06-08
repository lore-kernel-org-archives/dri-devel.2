Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBD18CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:58:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03AB110EFBC;
	Mon,  8 Jun 2026 08:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="HYrJ20Oc";
	dkim-atps=neutral
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com
 [209.85.214.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7EF0910EC3A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 02:32:44 +0000 (UTC)
Received: by mail-pl1-f176.google.com with SMTP id
 d9443c01a7336-2c0c2c7d45eso33698315ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 19:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780885964; x=1781490764; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QgcMG5nFEAs89H2OIuVhEyONVcKyhkh1xoo32LhXMAQ=;
 b=HYrJ20Oc+mgH1wRN39fT/SuOH3wjzsif93HcKfUX0EXkHy1y2wVny8qc57+TZceVnX
 O/lYhguJQ+D0/3M6x7miO2Fn1IBDPBPnIFqOXcWk/vKSW73W5yNdvqfcRqWIDaTHHRfM
 Y4IjZoz+YAdntTDFGpD44slynNDVvEa9bP6ZdewEhPTpcYX62R8THD/UZHGLEnAxBOVh
 qFektPu3d17lypLVQV3/afG8usedWJblwGN1cSbrPcuQCs9JwPvdyQjmcMZlrLEIIOcT
 Kp8cI/y6DLD5DwSNMBkT1JBxNLAuxFIfhp9RZhs91IVRfcAtaUYutL78Vt22fwPWsqBV
 q+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780885964; x=1781490764;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QgcMG5nFEAs89H2OIuVhEyONVcKyhkh1xoo32LhXMAQ=;
 b=Z58C32jPeNwIdkW3TCDH5TKTVN3HZqOqlGNoeunq98WPGjeN40chmZZ7XOYr2c6HKg
 XuRl78bXR4Ti3JB37Rc49r79DXA6Y4bHmlQktBfjp17dN03S3tJUkVxW263qlb6W0bqm
 9N8Y2mD6A5nJBQocU5pmhCRaUHy7Zt9qFOJdq+ss8rCRWEyUaaUsIrOPfMeaANoiAP1y
 xWu67NQnUWj7gNu/ZQztnAVhNrxRZBRu/D60YVuHzn6anZ6K3Kwj4i1fdPNXtaJqimqz
 a7Kq8BBa3lBWKSwRHYPqA/H+qnQOBuOl1a0LvtUhtaOsmij3Tei9im/fllwXcMrj2IFU
 Z+ig==
X-Forwarded-Encrypted: i=1;
 AFNElJ8WuspwK2bYTvbChh+BK7b7n5Kuy1eLzgal2OJi+/AILwNpG0/4c1+Gl7hYQcpnIf4ATLyV0eG7Txg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzHPccZMVt+7CmBnuppeLIqFO4wgWJuaX70cXXbkHkaCipDp/rM
 9LLsqJUrv8nb7h+RbtKai/2IUl9WAqe03t7TtYdDpSqc55XJQrwPzol0
X-Gm-Gg: Acq92OGl7DB1Pm5BPEt+NuampGfvo31uPQG2XUfjcBCuQG0D6sqzf4fHKWaq0ovExYK
 SdLkaLDUPvmLvm1oDb1gjFf70yrgEz+I0jzMPmWfebwRIr8VXPe+LEMPSvVf+/Qg75zQ13oOjXD
 4N24V+RPqrsjedonAFU9qCDXqDGNVt7Q2atpbLW4xHjvlpFiaYKwLKvUTI/oknseXJESybN2ola
 iFCdjouZ1dz8R45DQFwKZRvRsfbrITqBqvFsxl7De0gUDSQ0GCKI/GuTxGC1Tn2suFNWX6/0Pjz
 0rbeqSJntOvcF4kwS96bU2IsCCNsrGd/KZ0pinvUDrHrfFJtT+XJJ66YOp8719JHv38SvLVEyAj
 /Tkeqf/knIwvVgCTD3Em277vUgrnsmi0gyBsPprC+6PlRW0y6DvS4j3V8JkqzyTzweLayNO3fDT
 hKYvtMfoJbx0c28lxUfq2iJjMrI5+uyLXN8ISYRF9LNHR99al0XshH7yOeVhJflWzo43pSGQWM5
 QE8S7BV17fMZYZuMvAn3cI=
X-Received: by 2002:a17:902:ea0a:b0:2c1:564b:4f47 with SMTP id
 d9443c01a7336-2c1e8495453mr161310405ad.26.1780885963925; 
 Sun, 07 Jun 2026 19:32:43 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c245dd3b5dsm38143485ad.81.2026.06.07.19.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 19:32:43 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v3 0/5] drm/verisilicon: add Nuvoton MA35D1 DCU Lite support
Date: Mon,  8 Jun 2026 10:32:32 +0800
Message-ID: <20260608023237.305036-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:58:33 +0000
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

Patch 2 adds the register-level macros needed by the DCUltraLite ops.

Patches 3-5 introduce the driver changes in three logical steps: the
vs_dc_funcs hardware ops vtable with DC8200 ops extracted into
vs_dc8200.c; the DCUltraLite ops in vs_dcu_lite.c with the necessary
Kconfig and clock-optionality changes; and finally the DCUltraLite HWDB
entry that gates hardware recognition once all support is in place.

All patches have been tested on Nuvoton MA35D1 hardware.

Changes from v2:
  - [dt-bindings] Replaced standalone verisilicon,dc compatible with the
    SoC-specific nuvoton,ma35d1-dcu added to the existing enum list,
    paired with verisilicon,dc as the generic fallback; this matches the
    thead,th1520-dc8200 pattern and was explicitly requested by the
    reviewer.
  - [dt-bindings] Removed standalone 'port' property; kept 'ports' in the
    global required list; MA35D1 example now uses ports/port@0 structure,
    following reviewer feedback that a 'port' alias should not be added
    since DC8000 (single-port) also supports DP output.
  - [dt-bindings] Replaced additionalProperties with unevaluatedProperties
    to allow per-variant if/then clauses to add constraints cleanly.
  - [dt-bindings] Added separate allOf/if block for nuvoton,ma35d1-dcu
    constraining clock-names to [core, pix0] and reset-names to [core];
    the if/else structure from v2 is replaced by two independent if blocks.
  - [dt-bindings] Removed all description strings from if/then branches per
    reviewer request; descriptions remain only in the top-level properties.
  - [hwdb] Removed VSDC_MODEL_DC8200 and VSDC_MODEL_DCU_LITE macros; HWDB
    entries use literal values (0x8200, 0x0) with inline comments.
  - [hwdb] Added enum vs_dc_generation (VSDC_GEN_DC8000 / VSDC_GEN_DC8200)
    and a generation field to vs_chip_identity; funcs dispatch now uses
    generation instead of the model register value, per reviewer suggestion
    (DC8000 has model 0x8000 yet behaves like DCUltraLite with model 0x0).
  - [hwdb] Moved the DCUltraLite HWDB entry to the final patch in the
    series per reviewer request, making it a gate that is opened only
    after all supporting code is in place.
  - [ops] Split v2 patch 2 into two patches: register macros first, then
    the per-variant ops table, per reviewer suggestion.
  - [ops] Extracted DC8200-specific ops into vs_dc8200.c; DCUltraLite ops
    are in vs_dcu_lite.c; dispatch in vs_dc_probe uses generation field.

Joey Lu (5):
  dt-bindings: display: verisilicon,dc: generalize for single-output
    variants
  drm/verisilicon: add register-level macros for DCU Lite
  drm/verisilicon: introduce per-variant hardware ops table
  drm/verisilicon: add Nuvoton MA35D1 DCU Lite display controller
    support
  drm/verisilicon: add DCUltraLite chip identity to HWDB

 .../bindings/display/verisilicon,dc.yaml      | 103 ++++++++++++++---
 drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
 drivers/gpu/drm/verisilicon/Makefile          |   2 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c       |  20 +---
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  38 ++++++-
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h    |   1 +
 drivers/gpu/drm/verisilicon/vs_dc.c           |  13 ++-
 drivers/gpu/drm/verisilicon/vs_dc.h           |  33 ++++++
 drivers/gpu/drm/verisilicon/vs_dc8200.c       | 107 ++++++++++++++++++
 drivers/gpu/drm/verisilicon/vs_dcu_lite.c     |  78 +++++++++++++
 drivers/gpu/drm/verisilicon/vs_hwdb.c         |  14 +++
 drivers/gpu/drm/verisilicon/vs_hwdb.h         |   6 +
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  32 +-----
 .../drm/verisilicon/vs_primary_plane_regs.h   |   3 +
 14 files changed, 385 insertions(+), 67 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dcu_lite.c

-- 
2.43.0

