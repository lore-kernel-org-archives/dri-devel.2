Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4AE7CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63A2610F48B;
	Fri, 26 Jun 2026 07:53:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RrbZBANT";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9ABC910F1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:45:04 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-37e00ef16ccso124338a91.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782380704; x=1782985504; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zG+ncOED8kJvI4v12/W3LY0+BgurY5fCH2pouNtIlDQ=;
 b=RrbZBANTrhilRvTB4x2dgcBdPQtGT4jarVMvxFsX8jhzkuKgbfB1JM0FoQVIA26nml
 6bArjpI4olDTMLO5vNL6lfkfZL2WRP4jOz/wpz7yPLQzSOI5EjEcPLMYuuN/2/r+muFe
 Fn/w6y9/jPmjnNvccD+jWv7C0m2Y8JN8nF5g5Q70GoeN+tcyzQFFtzilnUFqbtLmRsj0
 UbAH6fWLCwrE7bgp+z57Mrcz96382UIkPubIN/VBKYpiKqJ9tehgfVICH5iMi+m7ERx9
 imDMi5JjBdjazbQQG0eSTNMtzagYuXtgXpa3dfPGgXO+MI3QXmgavqHwKKOr0DaSpQO6
 lDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380704; x=1782985504;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zG+ncOED8kJvI4v12/W3LY0+BgurY5fCH2pouNtIlDQ=;
 b=sKRarb2GjWK7XzDARArk4OHvPMPIgdXCDAfLbCFCoOHRh1FLOxpz12evXoPFLJISz+
 8SW5VBr7athAvxDRiqih5MiSNp7Wp8I6HiOHa/EbPacPjrPvHdyWebB1rMlusYWHbBGi
 hpuJfKRjaxSp8ygF4DH3VP2bQuDOvfBGX+6EvDP94e6NNdjYaun8n8M4SiRKVLoV2Wkb
 FxKE5ct5q0NAyCpODW9WrCrITT46sAruM/U5xotX+/eQWkpHZOwjwOpoET7j2D3U10Vo
 1BUQt73xPOuOsiSJ50id08foCimaXru0Jwpcf+ThaCIBYl7Wilh67ffBR+Mrpf0yVd7z
 jUcA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrj1CKCeuvEZ2h+UyJHs365oOaPwbEKUBUxCG/CoVKydi7QVskrgmYXC0sow0SR+a7HJ8IrMOsR+Q8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxvP/L3nvRRm8pZy7bRV0ULTsr6XRkvkijhPpf4QGjc2KErwUyq
 TfFXQFfm0udKJplp11kiIXhJEBkXuwlpWTaBbwr2tFVoDH7y4a34lIas
X-Gm-Gg: AfdE7clwHIc4mynyXD3w1w6q6qzGGPFfo1uS++48CYHIYemPHpWTQMc5wXN0XNLLato
 XuvinaLDNPX8Gr1EhvywUkIJI1lbYL220XjVZYDORer5Nr7lPRhcvZUsuIQturc3yBGCtHV/HjL
 zUh7k6/G6MsgHZaHYQcaYFqu8YBfegrszYZHMZvT8mxSXzXYo/GL6ezxdT8l4oEZpSC225KwWvo
 8NP7uD3dH1VLlM7sV2oadRbSxaHQgvEqIyJQ1SImS1mv+X0U6Uy0jiFQYAWmPNRLMkb27uwwNwS
 D4Q1kBFwNcAfZf5LvJaBTtXjRX3Z/m6lAkHI4kfrilRF/7ZzYPJx/jYKuQBCViO6v+9vzCUQ7fr
 BtMA/30yaQST3ZE6wIegPITJUQz0Xg0ystQ4rG8OxDnugi8xrfhGHBN9Se1RvxkOKIixeVx9H2w
 TWpyaSzPmkkrmFTB6RDA/FnDjq8MDHR3lwMYCtyA4TBWbfIUNtANHsdbfiRphe8cuoH0ebg2cfk
 w==
X-Received: by 2002:a17:902:fc4b:b0:2c7:e318:1d86 with SMTP id
 d9443c01a7336-2c7fc6545f7mr18443535ad.1.1782380704007; 
 Thu, 25 Jun 2026 02:45:04 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8c26sm16614995ad.1.2026.06.25.02.45.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:45:03 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 2/7] drm/verisilicon: add register-level macros for DC8000
Date: Thu, 25 Jun 2026 17:44:44 +0800
Message-ID: <20260625094449.708386-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625094449.708386-1-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
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

