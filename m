Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7241AC88E75
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 07:10:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5489510F1D5;
	Fri, 18 Sep 2026 07:10:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ShinfP74";
	dkim-atps=neutral
Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com
 [74.125.228.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D450210F147
 for <dri-devel@lists.freedesktop.org>; Fri, 18 Sep 2026 03:01:41 +0000 (UTC)
Received: by mail-pz2-f12.google.com with SMTP id
 41be03b00d2f7-cc4d04d740cso111130a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 17 Sep 2026 20:01:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789700501; x=1790305301; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d1MvCbfjotTiPMU9xzuQx8OmetQMTdloo3vQR2iBJfs=;
 b=ShinfP74wETUgZKnlHHmXJrdZ9t7ZSk081lK3b/ZhPeUEScSvZGZZDpFWHl8Ucczld
 qBPNV4rCbHkABNfy0U4CXJSDsu8Jr/S+jTv17b7QrGTQcWguNC0Y2AYPAqOz/H/+vzuP
 ZW142Z4g3T9K1Wqe0uyJb1s9iy7UU96urOY5EqFHSnsyxc/wi9EAaLPr2685MZ9zy56S
 rmvL6oXDg+bDOKW0lZMNUVLJYkizrjWzOTcvrQYpzrKVpkRxkjP9fmJJtoBqsJTVJhEq
 ZpF6lGU3saAzc8GYWxuy5hIDcV1uFg9cDzlLWudsyj/2tF+dlfyDBpqyZbbpj3bvhVEC
 b0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789700501; x=1790305301;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d1MvCbfjotTiPMU9xzuQx8OmetQMTdloo3vQR2iBJfs=;
 b=rooSYK52VAVYZi89DFEmu9Hvl4NRaPkkdtAYMGJo9oViTCiPoVpCUM7209KVc4ePlC
 w1znaT28jmxOQmBzFiw2FW1N02UZEW84jFR5UaPXOiCAq+bL0UokK4NVlEyxBBmt+sQ3
 M1Lx5IjAR3izSMVASM6v5jMGIvZvVnK/tQ7/CbE7DsdJercGVV24SBHdWzUuiAYXRx8Q
 7//RzW1V6Nmc0L0XKKAVxYJFBI8NWNMiZV0Pv+so3AaOXsuyEkIHQ91YWDrxWOOfhmYs
 ucVKJcb4yBsIctwwbQ67PnkM6+KOs1vcMVBYK1Xm/P62Dd9xAyObm33UZYUbZVEUH9lL
 XoOQ==
X-Forwarded-Encrypted: i=1;
 AKwUvByMcgtiYadBnN4fHkNtiZcbBkBG4SXx8cEx+y57yc60ddZyfaDU5iaUq3SCuO/7K52KEV8pyZ8J2cU=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nUXbAXx/fY3ElCaDiRjIzwcn3bSocR43pqmwZ9F3kt1S5veBS0
 JgTUAwHgTj2EhIjZyWwHSc0luj2qJZ3Q8VsY8EY+tt27F3+nvHZMyAlB
X-Gm-Gg: AYBFou19RReyHftNZENlYTcD5c4IzTpduG7DXRZ+wkK9K/0ZjCYG8zr7c7wkyYgaLI2
 o47ubyA4r0ii/aEdnx9AU9ICASNuX3b5I6F1+wFhKyOFMgNDg9RXeyN4EeCHrjBzzQ2jL1cvyo9
 4llYrRbrKLtKfBQ0OUiqH4RS/4aLFfvrAp2JKDjjmK+ap+dY2is4pA5AcnHAeLnYWpU/cNEaRTF
 mbIIpdlKLhpZMBfKJOZIO2xoD5xr7ECq0Va0sFgkq2BcnHWeDP25SUmD8aXsCkj9seMj6ghV0t8
 jMmgcQ5q4qIIdzoS2Kcq86IcnaBbfFGxSlt29VlmwF0AIN7Lz6DGpc2Rozu7DR9VeE92UrczgpW
 zFyL/cLcNCYhwpMhc0AYYut8iAqKZUhCbe7GRzCbtMlatUkzBdHn0OE+WXQ8e25EnzX6kZKAhZP
 A/UQfEQIYwK+Gh5HSAty1075rY/xTLZMPkS2uiHY77s/pe4YVFZjAI+yREgcj7uYFkKeGXp2iCG
 rn/22SPI5deR5ioOf/jw+ijqvF3u9eljnuniJXDXhN+TZ+Q2+2U/zN0MSaUzds=
X-Received: by 2002:a17:90b:17c1:b0:398:e86b:ce14 with SMTP id
 98e67ed59e1d1-39e54e3f526mr2301890a91.20.1789700501279; 
 Thu, 17 Sep 2026 20:01:41 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39e362e9402sm7969141a91.15.2026.09.17.20.01.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 20:01:40 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v7 2/7] drm/verisilicon: add register-level macros for DC8000
Date: Fri, 18 Sep 2026 11:01:20 +0800
Message-ID: <20260918030125.315978-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918030125.315978-1-a0987203069@gmail.com>
References: <20260918030125.315978-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 18 Sep 2026 07:09:59 +0000
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

Add register-level constants needed by the forthcoming DC8000 (DCUltraLite)
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
Reviewed-by: Icenowy Zheng <zhengxingda@iscas.ac.cn>
---
 drivers/gpu/drm/verisilicon/vs_crtc_regs.h          | 1 +
 drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
index c7930e817635c..d4da22b08cd5c 100644
--- a/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
+++ b/drivers/gpu/drm/verisilicon/vs_crtc_regs.h
@@ -54,6 +54,7 @@
 #define VSDC_DISP_GAMMA_DATA(n)			(0x1460 + 0x4 * (n))
 
 #define VSDC_DISP_IRQ_STA			0x147C
+#define VSDC_DISP_IRQ_VSYNC(n)			BIT(n)
 
 #define VSDC_DISP_IRQ_EN			0x1480
 
diff --git a/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h b/drivers/gpu/drm/verisilicon/vs_primary_plane_regs.h
index cbb125c46b390..67d4b00f294e2 100644
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

