Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797A8606A321
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 00:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TSO/mj0Y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D8B2810E5E7;
	Sat, 31 Oct 2026 00:34:33 +0000 (UTC)
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com
 [74.125.82.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C50410E5E7
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 00:34:28 +0000 (UTC)
Received: by mail-dy1-f173.google.com with SMTP id
 5a478bee46e88-3282db206d3so482268eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 17:34:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793406868; x=1794011668; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=lAQsub6pmHls3bP0tt9PGyqlBwOUYsP9EC/vfE7Hwr8=;
 b=TSO/mj0Yd0DhqDM4j0lC+I+g7/2xAEx2C78SIptQwZIplcO+bVQSJ1ULrqkwcuoNYM
 4YCm1LQ91Eps+T6xE6KKxt958uuXh4x6GERPOSJOU1OGCYtRIy1Qvhs3ZxKPszUZXOvf
 YR30A/n3VypJhNB0BnOymWUnKYvy0bnbVbas4fe8kqwR7zRtIDIh9ij97MMCNFPufdEH
 0+f8WryCAFKRp5yzTPfESp2JmD+Mav9kUHbLcEIRp/8nfcEzxraPCIBUft9AtNYop5rc
 1qJfgDnsi5yI3N1MFvBki6rw4Cjs5mCND27bNGotlklyQ3ZvwcTfnubCIGnML1AwkhP+
 784Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793406868; x=1794011668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lAQsub6pmHls3bP0tt9PGyqlBwOUYsP9EC/vfE7Hwr8=;
 b=Fn1CBaH3o0lT48dXRZ8Lg5bjFFvr+tVcWPy69jyAkJMYaisWLdtNiK/RtWSQx1UMst
 C0habADGNduWwdUUHbwGVoLdvzZXce8f8YtDiEw33+WcZK28iXg5+eFkQADCJ1vkIIg5
 tqaZy7pgl5aR4HI6BO0YwdtyoJo7l7GTA75AKpqnBH43QadZpHE1sYjazg8rfxdz26nF
 meKAoVCimt7DklwZKs2+nIkSaKvL/mkP8v/jm990D39QfLBKwpuz1shQHYRUDXBkdV0h
 76YNiAHn+E0k/n1+DRpETge+I3IXzNXrydXSofMBzZ1tKBwSCB8DiXIPPUviGtkowFkk
 eI8w==
X-Forwarded-Encrypted: i=1;
 AKwUvByWvMuJeotcqgDGmpnS5n+ixxgdkHUCrKLgTKmUKzylWex+WPWHDg/dmPdBXOOAI0xpDua1C5cKhaI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIblIuYXpkl8i7OhX+LOnoeFOuFlb8CI7ozAuYnxSrwwdDC+aQE
 FCyR7zqzoUQd1z2u2ajKXa1c8kSlP+S8piDXHWyWSv+ZVB8A8SfgDQsPBCE3v5PcO14=
X-Gm-Gg: AYBFou1Vbp+cnh856f+aRWDDaHkvvS5aVT5Er/p6xMarh4kRu+BBGBvOur5QHqI9yDf
 rTdxh+yzCt6kWp1dMcb+pmERYwK1bw0qYUN3J8kgfsGr70cjmEusOkOoH3w9XuIJrIVI4YUz1ON
 OJC9k0FwSArbjbbhiKn3/l1CPHqDgUbDuH7fyuCL+JJ28pZUkHLXvB5H7Yy0v9F5NH3v9XxuPi3
 jVuX1Lx0glB+lkFQsuPBaatniN4YFWGdv4ua7FMX2EEhPrsZEP1ImSKhBBKoISW4nmXs8H0pFCb
 kOar+fM2aoZNrT4neaBoOPIbBNZAnbIlst5aNluE/l0c9PUNTAsWvIx4eeDPW+fB9cq/8irjS7y
 l4a8k4dr7/H0Fd9T2kqkVCfOfxmSl/zJguZJXpAkKahKhfyEuw0j+usb65zDYbjt1kJBy+tl1mg
 lbgXN6BNVaniFFd9MyDttjpQeRIa4/BUAW8cdligDB9SKvcMXgU7o0hd3UQkb3rXEQzBnqWofYo
 3wSA/XQWrciNXdOzmQwfAjs/zjlwooxrrrX60QSEjB1JFHLRjRcGzjYIPZ2Cs3Cn58nM+bjUvj1
 8nq01FT6MXM1O1hhJF2B4rLqpjtzUh6Qe03m6qcZeg8jlYwsnoBPjYPArTtE5eDfDELERX3jJIY
 DyQ4UToYxogG/oN62wcz3xJ018K1cqjThSePbuE8cVdq5rjsnVaaV9qRN85IVbDQwSiZBNR7Y+0
 ngYSx9mHeurk0bWQ==
X-Received: by 2002:a05:693c:639b:20b0:369:f2f4:b227 with SMTP id
 5a478bee46e88-36a4238e9e4mr5713485eec.18.1793406867364; 
 Fri, 30 Oct 2026 17:34:27 -0700 (PDT)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42669128sm11707816eec.3.2026.10.30.17.34.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2026 17:34:26 -0700 (PDT)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] fbdev: pxafb: initialize IRQ completions before requesting IRQ
Date: Sat, 31 Oct 2026 08:34:24 +0800
Message-ID: <20261031003424.1796478-1-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pxafb_handle_irq() may run before smart-panel and overlay setup.
Completion objects are uninitialized, and completing them can panic.

Move completion setup into a helper called from pxafb_init_fbinfo()
before devm_request_irq(). Drop the later initialization now that every
completion is initialized before the handler can run.

An early interrupt can also leave a completion count without a waiter.
Reset command_done and branch_done immediately before starting their
hardware transactions, so stale counts cannot make later waits succeed
early.

Tested an early interrupt through the real handler on ARM QEMU: the
unpatched path panics in complete(), while the patched path completes
normally with early=0. A stale-credit replay incorrectly returned
flush_ret=0 before this change and now returns -ETIMEDOUT twice.
Normal smart-panel init/flush/timeout/work controls also pass. Main,
no-smart and genuine-overlay ARM builds pass; strict checkpatch passes.
---
 drivers/video/fbdev/pxafb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index 1b2a16590999..84ef5baaf087 100644
--- a/drivers/video/fbdev/pxafb.c
+++ b/drivers/video/fbdev/pxafb.c
@@ -642,6 +642,7 @@ static void overlay1fb_disable(struct pxafb_layer *ofb)
 
 	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(1));
 	lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(1));
+	reinit_completion(&ofb->branch_done);
 	lcd_writel(ofb->fbi, FBR1, ofb->fbi->fdadr[DMA_OV1] | 0x3);
 
 	if (wait_for_completion_timeout(&ofb->branch_done, 1 * HZ) == 0)
@@ -705,6 +706,7 @@ static void overlay2fb_disable(struct pxafb_layer *ofb)
 
 	lcd_writel(ofb->fbi, LCSR1, LCSR1_BS(2));
 	lcd_writel(ofb->fbi, LCCR5, lccr5 & ~LCSR1_BS(2));
+	reinit_completion(&ofb->branch_done);
 	lcd_writel(ofb->fbi, FBR2, ofb->fbi->fdadr[DMA_OV2_Y]  | 0x3);
 	lcd_writel(ofb->fbi, FBR3, ofb->fbi->fdadr[DMA_OV2_Cb] | 0x3);
 	lcd_writel(ofb->fbi, FBR4, ofb->fbi->fdadr[DMA_OV2_Cr] | 0x3);
@@ -894,7 +896,6 @@ static void init_pxafb_overlay(struct pxafb_info *fbi, struct pxafb_layer *ofb,
 	ofb->ops = &ofb_ops[id];
 	ofb->usage = 0;
 	ofb->fbi = fbi;
-	init_completion(&ofb->branch_done);
 }
 
 static inline int pxafb_overlay_supported(void)
@@ -1170,6 +1171,7 @@ int pxafb_smart_flush(struct fb_info *info)
 	lcd_writel(fbi, FDADR6, fbi->fdadr[6]);
 
 	/* begin sending */
+	reinit_completion(&fbi->command_done);
 	lcd_writel(fbi, LCCR0, fbi->reg_lccr0 | LCCR0_ENB);
 
 	if (wait_for_completion_timeout(&fbi->command_done, HZ/2) == 0) {
@@ -1277,9 +1279,6 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 	fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
 	fbi->n_smart_cmds = 0;
 
-	init_completion(&fbi->command_done);
-	init_completion(&fbi->refresh_done);
-
 	if (!fbi->inf->smart_update)
 		return -EINVAL;
 
@@ -1775,6 +1774,23 @@ static void pxafb_decode_mach_info(struct pxafb_info *fbi,
 		fbi->video_mem_size = video_mem_size;
 }
 
+static void pxafb_init_completions(struct pxafb_info *fbi)
+{
+#ifdef CONFIG_FB_PXA_OVERLAY
+	int i;
+#endif
+
+	init_completion(&fbi->disable_done);
+#ifdef CONFIG_FB_PXA_SMARTPANEL
+	init_completion(&fbi->command_done);
+	init_completion(&fbi->refresh_done);
+#endif
+#ifdef CONFIG_FB_PXA_OVERLAY
+	for (i = 0; i < 2; i++)
+		init_completion(&fbi->overlay[i].branch_done);
+#endif
+}
+
 static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
 					    struct pxafb_mach_info *inf)
 {
@@ -1831,7 +1847,7 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task);
 	mutex_init(&fbi->ctrlr_lock);
-	init_completion(&fbi->disable_done);
+	pxafb_init_completions(fbi);
 
 	return fbi;
 }
-- 
2.56.0

