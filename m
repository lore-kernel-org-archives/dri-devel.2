Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1ED9CD98C5
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 507BB10E25D;
	Mon, 15 Jun 2026 07:58:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="iIrLqFOv";
	dkim-atps=neutral
Received: from mail-dy1-f179.google.com (mail-dy1-f179.google.com
 [74.125.82.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C119910E200
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:50:18 +0000 (UTC)
Received: by mail-dy1-f179.google.com with SMTP id
 5a478bee46e88-304e83724bfso4118393eec.0
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781506218; x=1782111018; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VJAMcsXbQ5jLlRv6m7LlcFvxZJca/ceaoDodoBDS/Yg=;
 b=iIrLqFOvi5KCPIiJYbnRHsVuIL/vk6daYMnYAc/Mr9A84MkJaflwINiqXkwo54XomX
 63VDKz7LS6v4ejRMol9xEan/3Dykyws37858QAfy0D75Qox/qGaG1ahMg6rN2gJgT3Mb
 60znUgNyVHTer+MfDsCUAX+7suoPnlM1oMFDjniM026BTCdkeHJqBw0T4yDgGGwykoPF
 o4HAxvqvpS0txhkPVNd6UEtHcQFqqmpQQw2W4VEmVXLncKbb6dXcv6YzVgdltgVwKxCC
 Txsu29cCge12vMYLMk5oOtPqsGSYr+q61SAQuHuvCAUewUnYl3Cf6OuFUmPKk/NJha5s
 n0XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506218; x=1782111018;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VJAMcsXbQ5jLlRv6m7LlcFvxZJca/ceaoDodoBDS/Yg=;
 b=LBBVNmN8wFfXUxYuWirKJN4fxNUNczF7Apf6nQQWgE6wSK+beFkmeKiLmYqIoywBPk
 EzHX30FHFjbSK49jDPVsFzvKjAlhHuh5yNYvkE/OyMkTSZMNRnNNvKdF28hEhckScGYc
 UrTr7S0vVk2d6ocGbT7tkvkaoHsyOIODkuk6nKe/z0kX4chG61UkYewlIwfDtthwiJLr
 Wp5p2nxm3XVhetuC6xjH9J6lIrv/g/Dq4MTprQZybKhbpveSXvzWlHa8QNnEMaGS9Xhh
 mSat6vFejLUvC1zyTdZFwlUc8Nz6YZ10cy0CI6B/x3u5xDR1civXhi49DYT+50OfBV7g
 PhZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9H0IWYTDWQfAJWsv7kSQe0aBNlX9y2QzzhQIbBPFxL7QP1+ddNuNIfNrfRHCIKiHRL+BTaoIhMFak=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzzJlTe8Mtkcqpo+vvDxXwOT+RmEEBfXv9rlTyIuv52fHmbyiFT
 xptGbURkFP3sqowhsR+ZEb0GUN2l8VBtQJQoTPLvD40vAC2MkhEjaYeg
X-Gm-Gg: Acq92OGRXOgFX9DLmgO4C+AxwML9Nib9e6WT077HDxAbnk7yeHs/T2Rtyj4IQYorQa5
 V+hQvCyhX4aPypSm0gHTgNoXdiA3djFLJbCdpI70lv7Ra5wptUVcWyS/LVDFNr7OMXMHq5indZo
 ONQRJWrHTM50pKREJzl7uiy2rRpUZWyFUtf/HpvNKJLLveIJndXtNOgiXob0Xx5pK8GThSPhxdn
 hkZGmOSiQRa/MO35fNIVE/lmx3M2A1ZHwHaSKBDd/2iJ5G6J1dstNEknbOkqUSCJh5ljpJvq3mG
 JvIC9I2FLkE9VWJxn4SqJmgAQPk+eSH3lpJzPiTevngX7pAesa5rtwGoRXNYMYzAzd2xTqGwqbS
 vTUJSgAetYjGUemofaOce0T7QXRyH4ZYTy6dMcwWaUmBYtTDFXY79Ni9Pq3fpzkg+kPRROtd2eR
 Enk9wiIAvkmCiMASfhbBC8mhANbBWFR4y8jSldlMBnYJ3zq4l0b89PLZNPOrcWqUrpI5lfhypko
 BD2zczMmGYB
X-Received: by 2002:a05:7300:4348:b0:2ea:ed70:3ea8 with SMTP id
 5a478bee46e88-30820098f00mr7010291eec.29.1781506217988; 
 Sun, 14 Jun 2026 23:50:17 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb9a2e7sm13516812eec.30.2026.06.14.23.50.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 23:50:17 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v4 2/6] drm/verisilicon: add register-level macros for DC8000
Date: Mon, 15 Jun 2026 14:49:59 +0800
Message-ID: <20260615065003.76661-3-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615065003.76661-1-a0987203069@gmail.com>
References: <20260615065003.76661-1-a0987203069@gmail.com>
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

