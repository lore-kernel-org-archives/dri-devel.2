Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03D70CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BE5F10ED13;
	Wed, 13 May 2026 07:54:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PXFv/Kyc";
	dkim-atps=neutral
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com
 [209.85.210.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B006810E0F6
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 07:51:50 +0000 (UTC)
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so2810519b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 00:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778485910; x=1779090710; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=8qQ0ZL0QLxICeDqID+huefvNgUTc9prsoWIoKknFrC8=;
 b=PXFv/Kyc7p+F+0feBeN5L5yopQ1hJZsnpL7L/oDNiH27yX09yFyZ+3j9boixwSkNUg
 XTXLNiRQKvvc1VSBNb7zErUTyhhLlze1fzno8y93OhSK6PL3npRU7XIM5PL5+2Amida7
 D+LeAgcF+fwmnf+iASWjRxg8C8h27JoEGCl6ppx/pUg21YdI56hOiBGw7eyxzdevSPmi
 soG+oBQ/aoNM8q+sYCmwjsALLA94mGLBBcHeM73lLuDcv/TtH5eEkJEt6ywpg3DQMF0L
 9qlx3R4c7fxp9I7Wl62nkyYdkhSTxcrpUkwTSV99ozxQ1bhRv/1mUmQ5GIUaH2ScrO34
 Wbog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778485910; x=1779090710;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8qQ0ZL0QLxICeDqID+huefvNgUTc9prsoWIoKknFrC8=;
 b=eRvR/3M75SjitSBi5w0VsJOsPax5fXJ4npgQQIlF7znMtI5iajaGKUGYdMBckbvJnu
 +6BrxtIUsco7cC0TBNFN28tNqvY3GdqIOBS5cjauEE9motxozPWxQqOLlGAKYGRG4JnR
 GWq5VZwU44MhgqZ+2LACYlSDg0ZIab/kWE/BFMJv84O3J1TFPdRu/IQJmQi94XmD1f8W
 99WHLke8NDk6zbVSevPGCjxzDgtRQvrEf7cWrCRNiozj3RgoKWuW53+WtTVWSHGkA2aO
 Ivm3j6bewwIDBs6BYOnNqGhizklDp/URVu8G1UFYTmLfcVejNjeg36j2ruVNhuzoBYRB
 eEyQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/monuAjOocDHqjLI3tj40sVMfHlBZ9ozzKEw1gHtulNE1KHk9E/qFCVOW+s+bg+RD/mN0gH+qKT64=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzuR1X5SizIu1aKMblM7SGqwM/YDhmX4tFk3rG74cbmkyVXd3Sa
 kYfVLcVnmvel5vshuOvWkbVkEpWeI6aQVBQr816QRWEGkQRst0+Axe1R
X-Gm-Gg: Acq92OGWcTngMLED5dap7yIltqkyv+uRC4+aobA417Xmlc7eWaJNMFikRas577LslO8
 puiORBbin3ooj3iG+Bz4ey9YAcI+BWMRNHVW7izLFLyQNzvXRbkMohHbnQ5kGJyo/FEXZpXMAUK
 h4C1A6mb42Jhd9ZfG/cDhdj2gwXxFkON8wcW0Y4wZaivoMzB9LggtZvvPz3+SdekhmxrF/o+7Ua
 P/5+LZSG+8jJI+jy0nb6nWbS+k8GLjHmcFVNCHffPTenUTvTNOq3xUgg6182mbcuzd4PKyFpfZG
 9nkoo+mZyGMxXOesvxeIvI6HNjWLCHnp02p4066viPsPG+PJV3xTU54S/oM4RdZ+e/yjYb0jLTJ
 8ElyWi+8j0CBdpZdplmQs8nfaSelEt4rh9qQIzL971Iy92zsLBXl/Op+TQ/qhrUaKTo72kqGHBi
 oObZGIWBugkS+uxyQAB3CnS3SvQRLl6MwKKCPDJaAlFJU4PxxYBer8OkoRa3dJ2obVy77ZOG1SR
 6QOs6j7pM8z
X-Received: by 2002:a05:6a00:3016:b0:82f:a89e:e16f with SMTP id
 d2e1a72fcca58-83a5c2be01cmr21310489b3a.14.1778485909975; 
 Mon, 11 May 2026 00:51:49 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83965d36a12sm17694642b3a.27.2026.05.11.00.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 00:51:49 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH 0/2] drm/verisilicon: add Nuvoton MA35D1 DCUltra Lite support
Date: Mon, 11 May 2026 15:51:40 +0800
Message-ID: <20260511075142.54752-1-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

This series adds support for the Verisilicon DCUltra Lite display
controller as integrated in the Nuvoton MA35D1 SoC.

The Verisilicon DC driver and its DT binding were originally written by
Icenowy Zheng <zhengxingda@iscas.ac.cn> for the TH1520 SoC, which
carries a DC8000 IP block.  The present series builds on that foundation
with gratitude to Icenowy for the original work.

The DCUltra Lite is a previous generation of the DC8000 series.  While
the two IPs share a broadly similar register layout, a number of
differences prevent the existing driver from working on the MA35D1
without modification:

  - No chip identity registers: the DCUltra Lite does not expose
    model/revision/customer_id hardware registers, so variant detection
    must come from platform data rather than register reads.

  - No CONFIG_EX commit path: the DC8000 staging registers
    (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT, FB_BLEND_CONFIG,
    PANEL_CONFIG_EX) are absent; the DCUltra Lite uses enable and reset
    bits in FB_CONFIG (bit 0 / bit 4) for direct framebuffer updates.

  - No PANEL_START register: panel output begins when
    PANEL_CONFIG.RUNNING is set; the DC8000 multi-display sync start
    register at 0x1CCC does not exist.

  - Different IRQ registers: IRQ_STA at 0x147C / IRQ_EN at 0x1480,
    versus the DC8000's IRQ_ACK at 0x0010 / IRQ_EN at 0x0014.

  - Simpler clock/reset topology: two clocks ("core" bus gate and "pix0"
    pixel divider), no driver-managed resets.  The DC8000 requires
    core/axi/ahb clocks and three reset lines.

  - Single display output: no per-output indexing is needed.

  - Smaller register space: max_register 0x2000 vs. DC8000's 0x2544.

Patch 1 extends the verisilicon,dc DT binding to accommodate variants
with flexible clock/reset counts and adds a new sub-schema for
nuvoton,ma35d1-dcu.

Patch 2 introduces the vs_dc_info platform data structure, selects the
correct code paths based on the detected IP family, extends Kconfig for
ARCH_MA35, and wires up the "nuvoton,ma35d1-dcu" OF compatible string.

Both patches have been tested on Nuvoton MA35D1 hardware and are
functioning correctly.

Joey Lu (2):
  dt-bindings: display: verisilicon,dc: generalize for DCUltra Lite
    variant
  drm/verisilicon: add support for Nuvoton MA35D1 DCUltra Lite display
    controller

 .../bindings/display/nuvoton,ma35d1-dcu.yaml  |  94 +++++++++++++
 .../bindings/display/verisilicon,dc.yaml      |  64 +++++----
 drivers/gpu/drm/verisilicon/Kconfig           |   2 +-
 drivers/gpu/drm/verisilicon/vs_bridge.c       |  28 ++--
 drivers/gpu/drm/verisilicon/vs_crtc.c         |  13 +-
 drivers/gpu/drm/verisilicon/vs_dc.c           | 129 ++++++++++++------
 drivers/gpu/drm/verisilicon/vs_dc.h           |   1 +
 drivers/gpu/drm/verisilicon/vs_drm.c          |  16 ++-
 drivers/gpu/drm/verisilicon/vs_hwdb.c         |   2 +-
 drivers/gpu/drm/verisilicon/vs_hwdb.h         |  25 ++++
 .../gpu/drm/verisilicon/vs_primary_plane.c    |  43 +++---
 .../drm/verisilicon/vs_primary_plane_regs.h   |   2 +
 12 files changed, 318 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/nuvoton,ma35d1-dcu.yaml

-- 
2.43.0

