Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B0FCC6B0E
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 07:53:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6346610F582;
	Tue, 13 Oct 2026 07:53:05 +0000 (UTC)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8590810E510
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 17:54:00 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-48c4207ac26so2078105f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 10:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791827639; x=1792432439; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QntbKw3gaGgw4tIzgsEy78HK5tHJosqnu2qH2MEsZDc=;
 b=YsC5EpTsuVxMtGfhIhJvUjJINuta3qKTlmn98lUMljoVP4eNvBzbl+QR/SXpePy9To
 2sgAb9Pg1dPuKxtroBtXghAZ3yyyi8qE9IpyrYsuG6QLwBN6+245pSxf+/uy+WJ92zah
 iIYvlScwqjZv/87Zy8GqvjNJi1Kh5PxGHuQZ6ljF1azvNcTsYFeDUfT1ILftxPfreFA8
 G7dq6lcu6Fkqi/hjTSlrHbBq+rM/Oey+TT9vfboqAq0hJtZNSIfXLHjCdazOzqQwPJAW
 mch3fOSlHSzVl0P2zjSMQm9EJHO8Orv8AwR1U5/BmCqEzvxaLDZhF8vInYfrcZS0d+Xs
 vQ6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791827639; x=1792432439;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QntbKw3gaGgw4tIzgsEy78HK5tHJosqnu2qH2MEsZDc=;
 b=xZK1LNczkfUaV60Z5oBw9f9c2Nt5ncPLP+fNx2qRq4M2GqLCnZHC2U0PVv+LpFkzXi
 EzigYeVUmVB559AJCkwhlkOL/eKoA/1MDR1vkxmpWcUKS9uGoKxTKxlH4m7FBBtxvPaP
 gaqpFiXJ7W9BdZQZS4/3TcvUPOPhB5b9f1kACF4wPYrDSSlRUvYTogqsjLyM3a1aJSmR
 WDcafK3qtfatuSo6Gjwj3Y8qqUCpKIxT0fDBUjjKggMRC/slKxKA1mU/AGvNs1+Jur+j
 5hJtY+CwWuzx62Jxqe2egcXOn2ZOTy7pAtHTRV6BMhHtJyF8kfBm1xK+O6qKjXEDPM4Q
 UiZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxQRteNd9/VZCb0x0zXgcJ1Cjj65e9rK0u2JHgIcJEIR/UoCC09u2MNHppm1B/5h9mO/hOudYUIKtE=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLpta2edhd5IrWF8TmHfH2ZYQiuAyPTS4ZUiGabzlSwpxuFb3Nz
 C6SXF19yr+hMm1jvNxW3w19WpZHoacojEfkleG4XsePgnCb65FLzDz2h
X-Gm-Gg: AYBFou2j6sbe9hJQ1ixACordplStQ+/QcJWtOAMT5FGSpHzR8TBptnKajXBtO36B7qe
 Y+hbpiZAJGQVqfM9F3dj5XS68ECtk1ytJdIe8DpN+dvz3pzGWGp32Lz5i1Njz8Z9TXSXZtStRMa
 0j+ys7ykiqfmyANM0jrfvxkhbSB8Lwk3+OSXTxngQY10WDvPwIC6gXf/YI1yqBst4ZxV73G5nJN
 B8m5NMUcCRBDZ0qpQ1Kjbv5Ep9PUoK8i+8ioXTKwJAxuAE/Lsc2Zcrm6d3CW107Q4M+35aQue3Y
 rrU/fJ8r/11R1YlGYKzU1WriAiyI25aH1xnl0p3XJ3j3B/NEV4fR8oDfh+k9LpAOhvCbEdbYSwx
 GDKgt1mIL1uC2pLUSAFoLYlkpckb72iihHYUcuiA+u+gY5V6gdeRM595cLzhKwyGObVYhtHAJ8/
 wFBmP5AhU4C5w7+Yc0LF94zkAj4NtCtgLzE9+aK4qkKNCIELuych0hsIqCRFttH4evfBs=
X-Received: by 2002:a05:6000:26c6:b0:48b:10af:f85e with SMTP id
 ffacd0b85a97d-48dbaaee1admr18683631f8f.33.1791827638653; 
 Mon, 12 Oct 2026 10:53:58 -0700 (PDT)
Received: from dev1.kernelcare.com ([2a01:4f8:172:1c85::2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48de0ab5af7sm667374f8f.31.2026.10.12.10.53.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Oct 2026 10:53:56 -0700 (PDT)
From: Andrey Misiurov <andrey.misyrov@gmail.com>
To: Helge Deller <deller@gmx.de>,
	Simona Vetter <simona@ffwll.ch>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Abdun Nihaal <nihaal@cse.iitm.ac.in>,
 Andrey Misiurov <andrey.misyrov@gmail.com>, stable@vger.kernel.org
Subject: [PATCH] fbdev: core: Initialize modelist in framebuffer_alloc()
Date: Mon, 12 Oct 2026 19:53:38 +0200
Message-ID: <20261012175338.2283897-1-andrey.misyrov@gmail.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 13 Oct 2026 07:52:59 +0000
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

framebuffer_alloc() returns zeroed memory, so info->modelist starts out
with NULL next and prev pointers. The list head is initialized only
later, by fb_videomode_to_modelist() or by do_register_framebuffer().

The "fix potential memory leak" commits listed below added
fb_destroy_modelist(&info->modelist) to the probe error paths of s3fb,
tdfxfb, tridentfb, i740fb and carminefb. These paths can run before
the list head is initialized:

 - s3fb, tdfxfb, tridentfb and i740fb call fb_videomode_to_modelist()
   only after a successful EDID read, and tridentfb can also hit the
   error path on an ioremap() or kmalloc() failure before that;
 - carminefb jumps to the error path when fb_find_mode() fails, before
   its fb_videomode_to_modelist() call.

fb_destroy_modelist() then dereferences the NULL head. Reproduced on
Debian 12 (6.1.180) by binding s3fb to a VGA device without EDID and
forcing fb_alloc_cmap() to fail:

  s3fb 0000:00:03.0: cannot allocate colormap
  BUG: kernel NULL pointer dereference, address: 0000000000000000
  RIP: 0010:fb_destroy_modelist+0x10/0x80
  Call Trace:
   s3_pci_probe.cold+0x12b/0x2bf [s3fb]
   local_pci_probe+0x41/0x80
   pci_device_probe+0xc3/0x240
   really_probe+0xde/0x380
   __driver_probe_device+0x84/0x150
   driver_probe_device+0x1f/0x90
   __driver_attach+0xce/0x1c0
   bus_for_each_dev+0x87/0xd0
   bus_add_driver+0x1ae/0x200
   driver_register+0x89/0xe0
   do_one_initcall+0x59/0x220
   do_init_module+0x4a/0x1f0

Initialize the list head in framebuffer_alloc(), so info->modelist is
always a valid, possibly empty, list and fb_destroy_modelist() is safe
on every error path. Keep the lazy initialization in
do_register_framebuffer(), as drivers that embed struct fb_info rather
than calling framebuffer_alloc() still depend on it.

Fixes: 3b0ed04bc852 ("fbdev: s3fb: fix potential memory leak in s3_pci_probe()")
Fixes: bb019d755366 ("fbdev: tdfxfb: fix potential memory leak in tdfxfb_probe()")
Fixes: 7a35ec619d9a ("fbdev: tridentfb: fix potential memory leak in trident_pci_probe()")
Fixes: 5936063409af ("fbdev: i740fb: fix potential memory leak in i740fb_probe()")
Fixes: 6fcca16a2b19 ("fbdev: carminefb: fix potential memory leak in alloc_carmine_fb()")
Cc: stable@vger.kernel.org
Signed-off-by: Andrey Misiurov <andrey.misyrov@gmail.com>
---
 drivers/video/fbdev/core/fb_info.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/video/fbdev/core/fb_info.c b/drivers/video/fbdev/core/fb_info.c
index 52f9bd2..05988a9 100644
--- a/drivers/video/fbdev/core/fb_info.c
+++ b/drivers/video/fbdev/core/fb_info.c
@@ -43,6 +43,7 @@ struct fb_info *framebuffer_alloc(size_t size, struct device *dev)
 	info->device = dev;
 	info->fbcon_rotate_hint = -1;
 	info->blank = FB_BLANK_UNBLANK;
+	INIT_LIST_HEAD(&info->modelist);
 
 #if IS_ENABLED(CONFIG_FB_BACKLIGHT)
 	mutex_init(&info->bl_curve_mutex);
-- 
2.43.7

