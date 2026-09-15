Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6B22C88E53
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 07:28:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C398510F9E5;
	Tue, 15 Sep 2026 07:28:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KrQihU5e";
	dkim-atps=neutral
Received: from mail-pj2-f1.google.com (mail-pj2-f1.google.com [74.125.227.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8514310E1DD
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 05:20:47 +0000 (UTC)
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-39e00a5b8e7so245855a91.0
 for <dri-devel@lists.freedesktop.org>; Mon, 14 Sep 2026 22:20:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789449647; x=1790054447; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rSU4R22SESbjjX3cQkBbS8lUy6Q/T1lRNgl0UnLZD5I=;
 b=KrQihU5eNuxmDK7zYJk4h8E2SDpdvG7xK2wN1zwGeSbTUH1zwVBuRXkcAV13oHzHqN
 Bbe3zhZbQnckHFwj+dy82c5imcT/LXE2lXLko2X36vFqcvRZZ7Mqe+G2SzPYd2CUmFLY
 A7nNwAXLv18Vp1WkUGmECHLkZtvN2PwO5fpui5H8ccGWV/e9cBF9qJO+DxBtIKpbUzZP
 b1+VTIeiFzAJU3zmSP94SCUKawPWmPYeLHBj0BtGgBy26RlXLaQ/nHyKF5Q8XZyubt7c
 xg4Yae3lF7DFdmsOcVFsNobb+TmbYo/iAv7H7XaOWUJSC1Xdv9e9kUVlwdpdwLPUOBUr
 FhhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789449647; x=1790054447;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rSU4R22SESbjjX3cQkBbS8lUy6Q/T1lRNgl0UnLZD5I=;
 b=aaS39uLwo8dwtt5c86UGflqvMsVAG7y5uTiD4fPQzWCa9Nj+0xuZBUxQbEMYtXt9HT
 DuIeRKxJUBx3GQ1Le6hKx01dgST4YMRyRWqN1i5bTI5RS11T+v+y5huVnph8/fxqtjfk
 Lj3XMPLZ4+K0kBiVUI+6cOTS2VlauL0YrF9twahwPM05oNTQb7sPK1L2aGlYDwn8k8i5
 5jZvMgGU6lWYTWzv7QlcTEFgzwAXDR7pSL4kYCTqKvoztecmbzXZ04zvFc/BViDTfXtz
 I1gbURupM3ppUjmnSc0FofCjESg/tXH0t+bf6JhKiA2ftSsQBfp92aZhzy2AJ575ZYl3
 tDgA==
X-Forwarded-Encrypted: i=1;
 AKwUvBx1KrRQ8H8GOqvWrIX6DRk6jpeKgmWVLGvxhFvJzF+5uMwDnYkZK516p1H2qkYp3Snmy4mggi/vbG8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kKaZjGezlBmZJIvP6O/CQX3RB03q7BuRIqwiy1a/rpATjlcHiM
 RpdHymck3mSSaGqHnYRApxO3ssaCbWkwMmaMbNRNVdYQrkAV0FZzAdw6
X-Gm-Gg: AYBFou3S+ZE2HdL0DJ1nwfoeLVsqqx3tx2+UjckKXW/d1ZdKSch/1PnwSIEfrCotRl9
 t2yruw0/JJHwW9DkIv8wfzbaYaqrHiw1boSfhYipmuhUSQsKkKaM/+qpwB1xYFoSEoVvOv6jvPB
 kTFZayQXwMuoLD/1V3e7qlIBr2shCgOMx1q4gpU5MniqTsZHZjJK2J1/KmelXESiiPncKCO1Etj
 ewPoiWGe6ZhUweQkrpx7vebbS2KEt8CgY6wx1YQ550DPDo8AFilal4ytkpabmo9rO8jzmht+M8N
 DcaBiDZmDiMANE0hH5g3qRoiW1QpuboKpV3diGWM2SqkFYSXwNt8uZTCzfjzQ7fozdWvmjKFJqI
 Kbm76kLOMrQ3b9cYHUv5CNbD94mxsk6MCwfACO7lhtVG1H7xVeoUqDlODoHQHnm1G91x0OJ85+K
 QNM7nPwB0gDCkSMfaeuqUIBrge+biupc4SGnvKCsrywyR+8P9V76vPQipj1/OtUf70Zk2mNokE2
 3QG9TxVia3pVMU6GchbcNtPPRB1hp9Q6A591gxieCJ38VJKmEZvBal8Zo8y7Ab+cXqa/UmCmK74
 R7Z8AWyXwxQv9D597hXmKwGcS7IZltY58RxiM/Vi7LHck1U8MHO1Xi7GEpxHuP2nvw==
X-Received: by 2002:a05:6a20:1609:b0:3d3:afd9:6040 with SMTP id
 adf61e73a8af0-3db40746ea8mr13353608637.27.1789449646922; 
 Mon, 14 Sep 2026 22:20:46 -0700 (PDT)
Received: from ethan-latitude5420..
 (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-33ba4f7390csm30258521eec.26.2026.09.14.22.20.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 22:20:46 -0700 (PDT)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: linux-arm-kernel@lists.infradead.org, Alex Guo <alexguo1023@gmail.com>,
 linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: Russell King <linux@armlinux.org.uk>,
 Ethan Nelson-Moore <enelsonmoore@gmail.com>, Helge Deller <deller@gmx.de>
Subject: [PATCH] video: acornfb: remove unused code for 26-bit hardware
Date: Mon, 14 Sep 2026 22:20:29 -0700
Message-ID: <20260915052038.626258-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 15 Sep 2026 07:27:57 +0000
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

The acornfb driver contains code to support machines with a MEMC chip
and without IOMD and VIDC20 chips. All 32-bit Acorn hardware has IOMD
and VIDC20 chips and does not have a MEMC chip.

Linux formerly supported 26-bit Acorn computers, but that support was
removed in commit 99eb8a550dbc ("Remove the arm26 port") because it had
bitrotted to the extent that it did not even compile.

Remove this unused code. Also take the opportunity to remove incorrect
file paths in the file headers, which are bad style regardless.

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/video/fbdev/acornfb.c | 57 +++++++++--------------------------
 drivers/video/fbdev/acornfb.h |  8 +----
 2 files changed, 15 insertions(+), 50 deletions(-)

diff --git a/drivers/video/fbdev/acornfb.c b/drivers/video/fbdev/acornfb.c
index f0600f6ca254..30781679c90a 100644
--- a/drivers/video/fbdev/acornfb.c
+++ b/drivers/video/fbdev/acornfb.c
@@ -1,7 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- *  linux/drivers/video/acornfb.c
- *
  *  Copyright (C) 1998-2001 Russell King
  *
  * Frame buffer code for Acorn platforms
@@ -94,7 +92,6 @@ static struct vidc_timing current_vidc;
 
 extern unsigned int vram_size;	/* set by setup.c */
 
-#ifdef HAS_VIDC20
 #include <mach/acornfb.h>
 
 #define MAX_SIZE	(2*1024*1024)
@@ -306,7 +303,6 @@ acornfb_setcolreg(u_int regno, u_int red, u_int green, u_int blue,
 
 	return 0;
 }
-#endif
 
 /*
  * Before selecting the timing parameters, adjust
@@ -390,7 +386,6 @@ acornfb_adjust_timing(struct fb_info *info, struct fb_var_screeninfo *var, u_int
 	/* hsync_len must be even */
 	var->hsync_len = (var->hsync_len + 1) & ~1;
 
-#if defined(HAS_VIDC20)
 	/* left_margin must be even */
 	if (var->left_margin & 1) {
 		var->left_margin += 1;
@@ -400,7 +395,6 @@ acornfb_adjust_timing(struct fb_info *info, struct fb_var_screeninfo *var, u_int
 	/* right_margin must be even */
 	if (var->right_margin & 1)
 		var->right_margin += 1;
-#endif
 
 	if (var->vsync_len < 1)
 		var->vsync_len = 1;
@@ -436,11 +430,7 @@ acornfb_update_dma(struct fb_info *info, struct fb_var_screeninfo *var)
 {
 	u_int off = var->yoffset * info->fix.line_length;
 
-#if defined(HAS_MEMC)
-	memc_write(VDMA_INIT, off >> 2);
-#elif defined(HAS_IOMD)
 	iomd_writel(info->fix.smem_start + off, IOMD_VIDINIT);
-#endif
 }
 
 static int
@@ -469,7 +459,6 @@ acornfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		var->transp.length = 0;
 		break;
 
-#ifdef HAS_VIDC20
 	case 16:
 		var->red.offset    = 0;
 		var->red.length    = 5;
@@ -491,7 +480,6 @@ acornfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 		var->transp.offset = 24;
 		var->transp.length = 4;
 		break;
-#endif
 	default:
 		return -EINVAL;
 	}
@@ -519,6 +507,9 @@ acornfb_check_var(struct fb_var_screeninfo *var, struct fb_info *info)
 
 static int acornfb_set_par(struct fb_info *info)
 {
+	unsigned long start, size;
+	u_int control;
+
 	switch (info->var.bits_per_pixel) {
 	case 1:
 		current_par.palette_size = 2;
@@ -536,7 +527,6 @@ static int acornfb_set_par(struct fb_info *info)
 		current_par.palette_size = VIDC_PALETTE_SIZE;
 		info->fix.visual = FB_VISUAL_PSEUDOCOLOR;
 		break;
-#ifdef HAS_VIDC20
 	case 16:
 		current_par.palette_size = 32;
 		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
@@ -545,41 +535,26 @@ static int acornfb_set_par(struct fb_info *info)
 		current_par.palette_size = VIDC_PALETTE_SIZE;
 		info->fix.visual = FB_VISUAL_DIRECTCOLOR;
 		break;
-#endif
 	default:
 		BUG();
 	}
 
 	info->fix.line_length	= (info->var.xres * info->var.bits_per_pixel) / 8;
 
-#if defined(HAS_MEMC)
-	{
-		unsigned long size = info->fix.smem_len - VDMA_XFERSIZE;
+	start = info->fix.smem_start;
+	size  = current_par.screen_end;
 
-		memc_write(VDMA_START, 0);
-		memc_write(VDMA_END, size >> 2);
+	if (current_par.using_vram) {
+		size -= current_par.vram_half_sam;
+		control = DMA_CR_E | (current_par.vram_half_sam / 256);
+	} else {
+		size -= 16;
+		control = DMA_CR_E | DMA_CR_D | 16;
 	}
-#elif defined(HAS_IOMD)
-	{
-		unsigned long start, size;
-		u_int control;
-
-		start = info->fix.smem_start;
-		size  = current_par.screen_end;
-
-		if (current_par.using_vram) {
-			size -= current_par.vram_half_sam;
-			control = DMA_CR_E | (current_par.vram_half_sam / 256);
-		} else {
-			size -= 16;
-			control = DMA_CR_E | DMA_CR_D | 16;
-		}
 
-		iomd_writel(start,   IOMD_VIDSTART);
-		iomd_writel(size,    IOMD_VIDEND);
-		iomd_writel(control, IOMD_VIDCR);
-	}
-#endif
+	iomd_writel(start,   IOMD_VIDSTART);
+	iomd_writel(size,    IOMD_VIDEND);
+	iomd_writel(control, IOMD_VIDCR);
 
 	acornfb_update_dma(info, &info->var);
 	acornfb_set_timing(info);
@@ -709,10 +684,8 @@ static void acornfb_init_fbinfo(void)
 	 */
 	memset(&fb_info.var, 0, sizeof(fb_info.var));
 
-#if defined(HAS_VIDC20)
 	fb_info.var.red.length	   = 8;
 	fb_info.var.transp.length  = 4;
-#endif
 	fb_info.var.green	   = fb_info.var.red;
 	fb_info.var.blue	   = fb_info.var.red;
 	fb_info.var.nonstd	   = 0;
@@ -991,7 +964,6 @@ static int acornfb_probe(struct platform_device *dev)
 
 	size = PAGE_ALIGN(size);
 
-#if defined(HAS_VIDC20)
 	if (!current_par.using_vram) {
 		dma_addr_t handle;
 		void *base;
@@ -1011,7 +983,6 @@ static int acornfb_probe(struct platform_device *dev)
 		fb_info.screen_base = base;
 		fb_info.fix.smem_start = handle;
 	}
-#endif
 	fb_info.fix.smem_len = size;
 	current_par.palette_size   = VIDC_PALETTE_SIZE;
 
diff --git a/drivers/video/fbdev/acornfb.h b/drivers/video/fbdev/acornfb.h
index e65388587f80..e33ea24ae0e1 100644
--- a/drivers/video/fbdev/acornfb.h
+++ b/drivers/video/fbdev/acornfb.h
@@ -1,16 +1,13 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- *  linux/drivers/video/acornfb.h
- *
  *  Copyright (C) 1998,1999 Russell King
  *
  *  Frame buffer code for Acorn platforms
  */
-#if defined(HAS_VIDC20)
 #include <mach/iomd.h>
+
 #define VIDC_PALETTE_SIZE	256
 #define VIDC_NAME		"VIDC20"
-#endif
 
 #define EXTEND8(x) ((x)|(x)<<8)
 #define EXTEND4(x) ((x)|(x)<<4|(x)<<8|(x)<<12)
@@ -94,7 +91,6 @@ struct modex_params {
 	const struct modey_params *modey;
 };
 
-#ifdef HAS_VIDC20
 /*
  * VIDC20 registers
  */
@@ -162,5 +158,3 @@ struct modex_params {
 #define VIDC20_DCTL_VRAM_PXCLK	(1 << 18)
 #define VIDC20_DCTL_VRAM_PXCLK2	(2 << 18)
 #define VIDC20_DCTL_VRAM_PXCLK4	(3 << 18)
-
-#endif
-- 
2.43.0

