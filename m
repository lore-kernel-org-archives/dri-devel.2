Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8803ECD4F54
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA97610EAB4;
	Tue, 19 May 2026 07:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mjaSoJnh";
	dkim-atps=neutral
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com
 [209.85.210.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9CB4510EA5B
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 05:51:58 +0000 (UTC)
Received: by mail-pf1-f177.google.com with SMTP id
 d2e1a72fcca58-8354461da74so1322752b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779169918; x=1779774718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=At2RDd/JrXkyJVQsow486779/5ZNt3HX5SfY5tKfcDY=;
 b=mjaSoJnh3O2S0f19X8UWjhHkFIdzm2i6kuc3AI+zknmpM+i55EqEI68Z1+5sHUKgVD
 xYCnhwULy2PiA83IH8w00Hhu/+mbogbXA9c1igFe/k2XzR2TrBU57jgt9pVo6D8Rx1rL
 LBaUddvM2U1jX8g+dOWBt+QS5voEKvlpJbeY/wHEVKGRsgONKUHiDf+ikXpCz30c3qyX
 mVEm1Qix8IN7A5LE09RlOptg2VH7C5jMZD2K4guECdn6UYco6EtFO8hMJ7waZ52MIzvo
 kzKnHUq3pkBwU5/hrIAdqFLnskToBVvLfI/7kKnYGV7sIwYnPRleKx02KCEGRydknckG
 IGXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779169918; x=1779774718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=At2RDd/JrXkyJVQsow486779/5ZNt3HX5SfY5tKfcDY=;
 b=pPr+Y1JfoY/NYTfJJlko/q28d6aWp7Vdc7PdrOCqnermNuu5+UqwX8f2vYwRdOLizD
 wJJFpwu/YtlWNcoF3Lv7jlaINw6Cjorlv1lY6Bm7phY4XWGvJyLcnU4GLdnvXSJw7VBg
 Sd4syMbKEnrVnLJD3/esU7DBjTIxy6oRwRAUU6kMHpkkpPNonEtobAHnIU3TqD3S7tLM
 rKwoEhPp6O1UK8FI9KlxXnkdNx7fYa9WXqetI66fFmAwWunJ3inocJ+OOl5ipCiJp7Tf
 /R6hkIFnDBYyBvlm7khDIaBPeqXsWVbQRmDVS8L5H/Er6eGix5pi9+tXy5KCXOuSe/dc
 Tlaw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9NjC9F6BaeTBJfD/eSPLCSv/t3wDHgT81EC+fA6hStvEycVxw6IzWttOF5U/6Unq4DwCb70iJXG4o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw98ouzAqAcGMdrgbdQpDF77HgktX9YrS9BO6ULLEvtur85Q4+H
 ZLfMVT7xlOKwNYLZmKjXey2GzPwpzjvcyHdHEISmOZftBYmQimsFjBws
X-Gm-Gg: Acq92OEzi4T7zxmpPvZrkqeOYwpCQYbG+rFX7y+GXlwPT+P1kVhqdKj6NsOIgimq8D6
 n77KyQbDyLCpY9/Bw+9TDKQ5CA8dWPyiep5iA/HyQ7pDkGClo7ddAisH5GS1FpDSlYXiea12ZWe
 7FZRF8AQ4sQs0ahIxkWd4dyO9kqaPAdpTDwT/p+Hn88Fcavd9NcnpD7PBThw45vEy8NMCQ9ppbb
 4aTXy/0c+ywABv3su+Zp6WU3DlgDSZDxbUuQzAFfeBuB5WBM0LixHEUWx+uzlu0ETrWfwLplKca
 TioKAMwtoAhy3WxvZcGXVMflKJ+KnX7AW1x3i3kJedgEDwElip2BxJCx+Pa4/52JVv/Or4AwyFJ
 ZlptdafRbsv1+CNTbAWov6kmohYYoXYPwt0n28j7/JmgJ8VKYw++jExB7m4Lys9lb3AL5J/xAtV
 0k37eGZb+KgOMM7jIyv5zF/xgQ6dUo6J1tKscmaq9i8D81tWvQQx9INkxNMkJRkLdigETobY1cJ
 S5Qa8C6+xpc
X-Received: by 2002:a05:6a00:1f09:b0:835:41f3:f453 with SMTP id
 d2e1a72fcca58-83f33c45ccemr17469354b3a.17.1779169917992; 
 Mon, 18 May 2026 22:51:57 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f8b9c2ea5sm2641252b3a.13.2026.05.18.22.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 22:51:57 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v2 0/4] drm/verisilicon: add Nuvoton MA35D1 DCU Lite support
Date: Tue, 19 May 2026 13:51:05 +0800
Message-ID: <20260519055114.1886525-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

This series adds support for the Verisilicon DCU Lite display controller
as integrated in the Nuvoton MA35D1 SoC.

The Verisilicon DC driver and its DT binding were originally written by
Icenowy Zheng <zhengxingda@iscas.ac.cn> for the T-Head TH1520 SoC, which
carries a DC8200 IP block.  The present series builds on that foundation
with gratitude to Icenowy for the original work.

The DCU Lite is a different variant in the DC IP family.  While the two
IPs share a broadly similar register layout, a number of differences
prevent the existing driver from working on the MA35D1 without
modification:

  - No CONFIG_EX commit path: the DC8200 staging registers
    (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT, FB_BLEND_CONFIG,
    PANEL_CONFIG_EX) are absent.  The DCU Lite uses enable (bit 0) and
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

  - Hardware-discoverable identity: the DCU Lite exposes chip identity
    registers whose model field reads 0x0 (revision 0x5560,
    customer_id 0x305), allowing the existing vs_fill_chip_identity()
    path to identify the variant purely through register reads.  No
    separate OF compatible string is introduced.

Patch 1 generalises the verisilicon,dc DT binding to accommodate
variants with flexible clock/reset counts and a single output, using
allOf/if-then-else to keep per-variant constraints in-schema.

Patches 2-4 introduce the driver changes in three logical steps:
register-level constants and the DCU Lite chip identity table entry;
the vs_dc_funcs hardware ops table with DC8200 ops extracted into
vs_dc8200.c; and finally the DCU Lite ops in vs_dcu_lite.c with the
necessary Kconfig and clock-optionality changes.

All patches have been tested on Nuvoton MA35D1 hardware.

Changes from v1:
  - Corrected "DC8000" to "DC8200" throughout (the existing supported
    IP is DC8200, not DC8000).
  - Dropped the separate nuvoton,ma35d1-dcu.yaml; variant constraints
    are now expressed inline in verisilicon,dc.yaml via allOf/if-then-else.
    The MA35D1 uses the generic "verisilicon,dc" compatible string.
  - Replaced the vs_dc_info platform-data flags approach with a
    vs_dc_funcs hardware ops table, giving cleaner per-variant dispatch
    without scattering if/else branches across multiple files.
  - DCU Lite variant is identified through hardware registers rather than
    the OF match table.
  - Series split from 2 patches to 4 for clearer logical progression.
  - Renamed plane ops in vs_dc_funcs: plane_enable/disable to
    plane_enable_ex/disable_ex, plane_update_ext to plane_update_ex.

Joey Lu (4):
  dt-bindings: display: verisilicon,dc: generalize for  single-output
    variants
  drm/verisilicon: add model ID constants and DCU Lite chip identity
  drm/verisilicon: introduce per-variant hardware ops table
  drm/verisilicon: add Nuvoton MA35D1 DCU Lite display controller
    support

 .../bindings/display/verisilicon,dc.yaml      | 135 ++++++++++++++----
 drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
 drivers/gpu/drm/verisilicon/Makefile          |   2 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c       |  20 +--
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  38 ++++-
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h    |   1 +
 drivers/gpu/drm/verisilicon/vs_dc.c           |  13 +-
 drivers/gpu/drm/verisilicon/vs_dc.h           |  33 +++++
 drivers/gpu/drm/verisilicon/vs_dc8200.c       | 107 ++++++++++++++
 drivers/gpu/drm/verisilicon/vs_dcu_lite.c     |  78 ++++++++++
 drivers/gpu/drm/verisilicon/vs_hwdb.c         |  16 ++-
 drivers/gpu/drm/verisilicon/vs_hwdb.h         |   3 +
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  32 +----
 .../drm/verisilicon/vs_primary_plane_regs.h   |   3 +
 14 files changed, 398 insertions(+), 85 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8200.c
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dcu_lite.c

-- 
2.43.0

