Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A716C79FB9
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 06:55:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DEE510EF16;
	Wed,  9 Sep 2026 06:55:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rtEKyPON";
	dkim-atps=neutral
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com
 [209.85.215.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BAC2C10EAE6
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:28:55 +0000 (UTC)
Received: by mail-pg1-f176.google.com with SMTP id
 41be03b00d2f7-cc1bc88a20eso5055453a12.3
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788859735; x=1789464535; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=d1MvCbfjotTiPMU9xzuQx8OmetQMTdloo3vQR2iBJfs=;
 b=rtEKyPONpHPHHZAg3ZHBdeUnmexKiPHUcZNZ4YC6HwJwQk0plNli6dZnVuGbNmuK8C
 10KeuqcI3OMVYHnWcRZM7AV6voEOm8qgwhFh+p/p3iZOs+OfvmXLuTAP9LY+HrKSIOw9
 Hz7y0D8WAFp3DyOpuj9MantV5469oUz5Evx3UJdZVLQRhgEFLKrYw4onbDc04sKMQqoH
 4Ypv6wR1jFoyZsKVeM8fPpyysb6K8jxO7FMxxIIpwlgu3LvUS9RnO6gXgZzhH7HcOM2J
 Uo1AMofITq7enzGhGDCiVRlwWp8vCsJMKHBrRBJExQGnlOuZ3rdg7Xp/PqgBaLngQNV2
 IRUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788859735; x=1789464535;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=d1MvCbfjotTiPMU9xzuQx8OmetQMTdloo3vQR2iBJfs=;
 b=fRIloUtt39Vrr1Mf0rx/ycOswwmLzZAfwQjRyxODgDzgN+3dTBjaPnCsW2ebBUne9j
 6Si+2U86MipT+G3cTZOl0I6SNIxMaQ3siPyJulQuMECdLYgstxSOnCHiLSOk9RX8Qm6I
 oFzTElHFzkf2IG91Z0tmQYh1XkSUHHBZvb/8JaFjCvTr1coFE1mRm57joKJOqaqxKUtS
 4nKOj8e1B6ipJ6WShHkE4FClA7Akmde9HIuDn0G4fpwA1pXgQCHejGxCL0KTYa831K+E
 wPGGtcEC98l5G/fUQ5Vb+8VDqfv2GdMgVulZB21VvirtbgJ/afcMVucPy5AKo7GNk3Ht
 mFHA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzM8LpAJXdhhW6Qh2vrNLZZo56v1qfA2AsTyGQA9Qe0I1/I+M/st3Q8FTssdJzPJcH5iOTNiiVis90=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lvx6OIYK1f2tCeWMokd0zjt1ij4iT0GWhgx3o0kpWvj34zIbEX
 56Tg/rLl03MVcoIqSRlbO8Mv46CFmZMq/hM6Y21TJkJzaWcuXwFpyBlK
X-Gm-Gg: AYBFou3xisII28nCqtpsGfrPmcSJALi5zYTKZmNT6CJQX3rlzQh9PFp0q6Pn+S2pA+y
 gAfZM1nxAy2Hncy8qmelCzWb/Bwd2GKwG9ywo84c0D+2xRGj3PSvr8r+Ja6x43BNJHhSnm2NsJz
 Q84hgf0tVqBQb7gmixiPCWVieF5nJt+Wora4IHuMYYMfTRX7O/swFrii4NMcwgd9JL5+clnUE3r
 /BhBEHNsjdfHqFThRchgSRr5Gct6WDreUZ37f9AW9RdKr6Z35kNP5yJkDHBPmktx4onKpXHpd75
 ZayZGJbA1eMAa+7ocG2F5s7SCRVFz4J1DJwE9wPDV0coZc0EX9kVgO0Kr8kR7B9eQ/u06yFzOoo
 aLuSWSAPHur61K+YIXmH9ndjTa5XMeosQH0W9qOQBRGQgLRorHz2DvWJ0XQw0+mY36bDWCIZraO
 RC+x5fJLZo77mlXyuGWSmRCS2uRfmlmjJ1aSLxZE0W6xTMRIQfVQ3QDaAtp/LsYpUUkm8v9bH96
 TTLplhdRmHknCGSVNU74JlUdJRWVnI+OLJXKHO3U8wQRtYZQG1eeo/3bfryTvcQ
X-Received: by 2002:a17:90b:4c52:b0:396:d27b:89b9 with SMTP id
 98e67ed59e1d1-39b2612ccddmr41681971a91.10.1788859735196; 
 Tue, 08 Sep 2026 02:28:55 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08c39227sm32109846a91.9.2026.09.08.02.28.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:28:54 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v6 2/6] drm/verisilicon: add register-level macros for DC8000
Date: Tue,  8 Sep 2026 17:28:36 +0800
Message-ID: <20260908092840.225220-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260908092840.225220-1-a0987203069@gmail.com>
References: <20260908092840.225220-1-a0987203069@gmail.com>
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

