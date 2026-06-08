Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37107CD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79BAC10EFBA;
	Mon,  8 Jun 2026 08:58:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="gqjyFZXb";
	dkim-atps=neutral
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 42F2B10EC3A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 02:32:51 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2c0b9328c4aso26168015ad.0
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 19:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780885971; x=1781490771; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p0zPEFGhfG3QKVaGDZG1h1mxGzWJiUcHgpOMB7FKbFE=;
 b=gqjyFZXbhWND4aaipsDBYWJpTzTnIw5I5DuD0h6VB2p1D9Ohsy9fz0+mGtrbhmO42B
 4oCqb9Vnyc1JzMWylxPyvRpMl4Wvdj/BOdeFQujoAEZ1gRzvabMBHnpEyvs+G4Cf1k5U
 zpxRaqQRQeZyFS9Ad53FFegKgZidhD/DswYhSJmmel1UNWmVKcYhpDXHwrdOStlFOQ6E
 /yP4Cc7dk/Yf37jBTkpwpm03CguUyqVjbEzKH8cYAPStg2QCZHg4/PKzlVFTZe7xRGi6
 MiHfWy7Ipsu8w18lN+4+DxYDWXP+Lku8BxjcSz70Pv6jsOos+9cWGVOVBC1uZ+HhrdF+
 We6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780885971; x=1781490771;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=p0zPEFGhfG3QKVaGDZG1h1mxGzWJiUcHgpOMB7FKbFE=;
 b=gc0fg8WN9y7eQNZ3k+EnRg7UVJLO04+FgiKL71W/vSUspfRIUxgbolGHcH41Un3xvr
 mJruvVRu2zaZB8zUQK4dcoGzT+NMMFjqLBLVs47GCay0yBiwHAihS3Po1v6qDDMh76L2
 xV9KRlaOHaHUmL3Bd/2hVR3iJDvFvD0fwCEfjP7jMbXqozvWbHBKdpid623Jo6JETqcd
 Ylx0AT9h6ylsfurbNe6ju81FnN0qkNpyftZ3vd4/4MsqjW1L2Jl4ClnWtwcVT0lzlY0D
 12kwogtpFlqThuhvIzf0lT350VyAxhlfwSRVJPSFayuqUAJOq9Ji0UCs3iKV+PQDflrH
 YUMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/+wJ+3mfy4Hx0LDhFtV4pxrz0EFxrQWsstn8JBFIoW9G6RujDcOcjD9Rk1RFo3wTR+FxaWbA7nD/k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyLNMmSx1CzqSb9DgEpzkyhoSUUgclapS4QlP6HhlMJwEQXZNho
 CC9hVoN/+cadT2ZJH2VfVbDjfAePrRTP0ake6wThVmXKeujvdlMLCrNx
X-Gm-Gg: Acq92OFQvlTfqwEcuyYT03QMLm+L9OkahfOtvCdrdQYhixgOT3HzoihGe5Ov5phiRFy
 nEVnibZl/7sVuCyKFgSMlx6/C+dPi8wFSyESfyC8v3oaZttiUpFpNAOCFvdtA0hjT6tGWWdl6Ol
 pcg82mFEGOsnHrpOheb6ilwvfXZCFOpzIQ7IQpm3FGASKSdu2UINNT2vbaT/M9G95fR0jTdqFrV
 oyRWvpZlMPSRltGNw+pv6do/3uaabTuhSpQmT+K5VydEj1dfBzGS+hXcYpA+tmnuoPQZ462zy2C
 ATe+Ysd0HMcBZgFACFoZ3BINZt2Z7MUVl7NJcyHUh8oAZCyVhdVxLsrsJAdrXBkigb32P5U45CC
 VkdUalN6/EjIdzxaosEDfkCGwp8JDMoJeY0Hg+6M2AF7YouqJ501jmNjGFGSZyvET/MFrAigrhO
 R/HKo+4tu05JlmUkfAHg3v9DQ3vcstpWFvarTK1Fimj9jL2RjK0GGYxuemc7knWR7CCQ011j9Zp
 SHV+veQJBrO8sFFOnyAcy4=
X-Received: by 2002:a17:902:f606:b0:2c0:ccdb:e02c with SMTP id
 d9443c01a7336-2c1e7b3fcdbmr158771995ad.7.1780885970776; 
 Sun, 07 Jun 2026 19:32:50 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c245dd3b5dsm38143485ad.81.2026.06.07.19.32.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 19:32:50 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v3 2/5] drm/verisilicon: add register-level macros for DCU Lite
Date: Mon,  8 Jun 2026 10:32:34 +0800
Message-ID: <20260608023237.305036-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608023237.305036-1-a0987203069@gmail.com>
References: <20260608023237.305036-1-a0987203069@gmail.com>
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

Add register-level constants needed by the forthcoming DCUltraLite
hardware ops:

  VSDC_DISP_IRQ_VSYNC(n) in vs_crtc_regs.h: bit mask for per-output
  VSYNC interrupt bits in DISP_IRQ_STA (0x147C) / DISP_IRQ_EN (0x1480),
  which are the IRQ registers used by DCUltraLite in place of the DC8200
  TOP_IRQ_ACK / TOP_IRQ_EN registers.

  VSDC_FB_CONFIG_ENABLE (bit 0), VSDC_FB_CONFIG_VALID (bit 3) and
  VSDC_FB_CONFIG_RESET (bit 4) in vs_primary_plane_regs.h: control bits
  in the FB_CONFIG register used by DCUltraLite for framebuffer enable
  and per-frame commit handshake.

No behaviour change for existing DC8200 platforms.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h          | 1 +
 drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
index c7930e817635..d4da22b08cd5 100644
--- a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
+++ b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
@@ -54,6 +54,7 @@
 #define VSDC_DISP_GAMMA_DATA(n)			(0x1460 + 0x4 * (n))
 
 #define VSDC_DISP_IRQ_STA			0x147C
+#define VSDC_DISP_IRQ_VSYNC(n)			BIT(n)
 
 #define VSDC_DISP_IRQ_EN			0x1480
 
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
index cbb125c46b39..67d4b00f294e 100644
--- a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
+++ b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
@@ -16,6 +16,9 @@
 #define VSDC_FB_STRIDE(n)			(0x1408 + 0x4 * (n))
 
 #define VSDC_FB_CONFIG(n)			(0x1518 + 0x4 * (n))
+#define VSDC_FB_CONFIG_ENABLE			BIT(0)
+#define VSDC_FB_CONFIG_VALID			BIT(3)
+#define VSDC_FB_CONFIG_RESET			BIT(4)
 #define VSDC_FB_CONFIG_CLEAR_EN			BIT(8)
 #define VSDC_FB_CONFIG_ROT_MASK			GENMASK(13, 11)
 #define VSDC_FB_CONFIG_ROT(v)			((v) << 11)
-- 
2.43.0

