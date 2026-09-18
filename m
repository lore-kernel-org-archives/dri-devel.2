Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C48DDC982D9
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 076EC10F201;
	Fri, 18 Sep 2026 07:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kIjC6MBP";
	dkim-atps=neutral
Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com
 [74.125.227.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCFC910F147
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:01:34 +0000 (UTC)
Received: by mail-pj2-f43.google.com with SMTP id
 98e67ed59e1d1-396ccc02279so229022a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789700494; x=1790305294; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bdKFcHr+t1P8kB1M0oZWW1CebC16dNbe38DihNTmLO8=;
 b=kIjC6MBPZj90lwSdZo0m5+MVWUXHGoaPiC5b85nblCyzx9s4yem3Rwhw4ubN2qQXmy
 GsSckB729VrX4wmB8P8pscwo/u5GsQLuP8wmTYG+viactg2p6e+48Z/Q/mkGqVhZxKyl
 wSsgjyTlPA3yFvB7iHvpBXQ+hNWiu4wzKqVPLxSYtCquik5VMKbaa/EfpolkKPZ1BmLO
 rbEBTIa4/w0dwXFqIBqzNFh2Bb97/TrVPTteAXCFOp/CaIFZ2IhsMRgKoV60AyFD+SWU
 Ntith+BuJC6Rlz5RKdIKe4QVvn4+Ycn8JD5OA/fO8OG04HxLn2ajB07Yx8wfmyXWSPQv
 T+qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789700494; x=1790305294;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bdKFcHr+t1P8kB1M0oZWW1CebC16dNbe38DihNTmLO8=;
 b=TaWqoAR4HPK7EnYfZBgjXDFswOjQcpt19BCWFr7I6xheIACF+cqEwsqIjMrJ6H0XHb
 BIqzC+WBREC1VC1oRTZ1lfWvbZOLUPr9PaOXD0Ygaq7KaGtx5yOHPUgY0JPkIApz1Gd+
 MVRwkbCPgHw98iEo+Nv/n6KysWHnr3E7+IV/bwkYSAB3xgq8rpCos2Tmq7PXUAdm8ikh
 KipzT6F6EVBB0aSBgPykRK+sd+i3WDF/P4N53a7yQsIVnqunt9Ic0xB4AwgKLLNCtMT3
 eAnI6CKBxUCqhGqkgNz4L8BsSTEDRBXpSQU78tcB01teVcwpy//ouxbTTnvDyctTSBr8
 CvIQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBynLTSzmZczSP4eh02qH7ysV0QzweskKBU4DxioBbVVnlldgzh0t8zQNlLxItGuXdmrXk9C8XpGYzY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mh+l+xs5+Unfv+kAaxkmkko6e4ZO1mqf+8HOgtrc5DafT38VgR
 1lZGOgIU3NmQonbhscPcWyk5PQtn4FC/8SrIljUqJaofgtDA4J1DOxLw
X-Gm-Gg: AYBFou0dc3dQX+LGdyd8s/ymH94fTa1nBJLLFr7DSNrGbgX7PH7a602QgLZVsSrmjfU
 sJMko/y3/iczKR9UzspB5WhNsxE1YBwLHdVMcshgBUTcwLlkLK9oxzzhfL9HMBI4mhHz7VFeU+L
 eUpRWUfTgS3j1+oH9mUKZr92n3/hxICLJZgOtJsmSeJe6I5UaZEwnGRbo4uhlnVIM0XWbGlBoCO
 GZIWmE8qGKzNXVWM5rwc0VDrlY0zWLBhFT5LMnHOIppsLAqt+6+ZZtCFKzkgDGIL01tpQWf2oHu
 Utg22W84QCqitb2igrFbSnKdvUbsp1lPAzYQBOywMMW8X4QOCGL578cmNhNOtG91mVJAc2BHEAp
 bFDGSzm76Wqo2wckS/lUlfePQTFu26QuZyc29hVAz2FcYNPLm1DnrtDQe9XI8WLF8w0N6ZoEbqh
 QySoZTS91OEXnd2efoKayp4IUC9M0jIS0aFWf6h0+a3IuVo+iLyxcvjGO6qs8FmwhLrc0qoLb8P
 wCRicjt/S7ePEmhrxjScmwaeeGfp+V2mp/8AE8Kc5nQzy+jieXlRpc8VoQVR5U=
X-Received: by 2002:a17:90b:4c50:b0:39e:4c7e:f03f with SMTP id
 98e67ed59e1d1-39e54f6a423mr2356087a91.28.1789700494073; 
 Thu, 17 Sep 2026 20:01:34 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e362e9402sm7969141a91.15.2026.09.17.20.01.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:01:32 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v7 0/7] drm/verisilicon: add Nuvoton MA35D1 DCU Lite support
Date: Fri, 18 Sep 2026 11:01:18 +0800
Message-ID: <20260918030125.315978-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:10:00 +0000
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

Patch 7 fixes a pre-existing DC8200 bug in the primary plane disable
path that Icenowy spotted while reviewing patch 3.

All patches have been tested on Nuvoton MA35D1 hardware.

Changes from v6:
  - [dt-bindings] Added a "port@1: false" / "required: port@0"
    restriction to the nuvoton,ma35d1-dcu allOf/if block, since the
    DCUltraLite only has a single output port.
  - [driver] Fixed 3 "alignment should match open parenthesis"
    checkpatch --strict issues introduced by patch 3:
    vs_crtc_atomic_begin() and vs_crtc_atomic_flush() continuation
    lines in vs_crtc.c, and vs_dc8200_primary_plane_update_ex()'s
    continuation line in vs_dc8200.c.
  - [driver] Added patch 7 to fix the pre-existing DC8200 FB_EN
    regmap_set_bits()/regmap_clear_bits() bug in
    vs_dc8200_primary_plane_disable_ex(), carried over unchanged since
    commit dbf21777caa8 ("drm: verisilicon: add a driver for
    Verisilicon display controllers").

Joey Lu (7):
  dt-bindings: display: verisilicon,dc: add support for
    nuvoton,ma35d1-dcu
  drm/verisilicon: add register-level macros for DC8000
  drm/verisilicon: introduce per-variant hardware ops table
  drm/verisilicon: add DC8000 (DCUltraLite) display controller support
  drm/verisilicon: add DCUltraLite chip identity to HWDB
  drm/verisilicon: extend Kconfig to support ARCH_MA35 platforms
  drm/verisilicon: fix DC8200 primary plane disable clearing FB_EN

 .../bindings/display/verisilicon,dc.yaml      |  51 ++++++++
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
 16 files changed, 382 insertions(+), 55 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c

-- 
2.43.0

