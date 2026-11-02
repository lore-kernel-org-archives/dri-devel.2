Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81CF3606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 08:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LUFiPGZS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEBB10EBA2;
	Mon,  2 Nov 2026 08:03:49 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 288A210EBA2
 for <dri-devel@lists.freedesktop.org>; Mon,  2 Nov 2026 08:03:43 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2e946155442so23903545ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 02 Nov 2026 00:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793606623; x=1794211423; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DJARq++ZNqDTm8Q9TFtOCOzhzKAsHsjDftUFwH6EBSw=;
 b=LUFiPGZSiaTKhs+CCF/ASdJpDD1v7OThltreaFQlWreM8nmf/p4B6T1XxjDfc+3Bzr
 vEWDifGyGKdUPuvLZgHPmIL0hKsHUdLggo0p+rPAbgiOD+CjE1rmSvCby1zEhBEVT2gP
 X1AWzQQZ6bKp0Knet1Sz/N5pfj546n6HexdMlahNjOQ0uTyfIT2mTbyoqP2tJrWVdsaA
 iiIqBFI+hrYngXEhgsaFEHWxapunD+C0igA3y3XSQjZilCMZRJGtAca2XQ9um7fpPliR
 kBvxh875cx1/zBMdxm4SrWeJOJAcrrpoA4grCkQqWshySzCQA6MtolWmJWDF6ofOapaz
 3XFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793606623; x=1794211423;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=DJARq++ZNqDTm8Q9TFtOCOzhzKAsHsjDftUFwH6EBSw=;
 b=QVlFMyLwZD3sqAsmaiqWmhe1N/Qo4BrYhIq4J0/j619AydYoAPKkfrOS8mRtgdCHBf
 O1E2esFOyuuSxqY6a+FY4NTpGmMCSw/fgVDIbQOcovEJFV5/UrOgug5irLbn/2T+KMGF
 p2Y3WzmCjXemeDQ+xQ+RxXs3dOjua6JU0S1ZLSd8sewwWTiFLh7kCXaMz+BwxoCoJDjQ
 bczCK90h63b1zD/hEZI8XJQPXpzOBlTs1Vi/28vVOByPdUEfhIf1VTHWeJns+ukQa35K
 iyd6nOvHWhQYKyg6pMW8rZEHbst40QP7ciJ5EmGIwlUrDUOlI4DXaIzOx/MZgN9tL7HX
 GRzw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzTyVSvi0srV3xEORl9dz40Q8ZLOidmYGJmdD3QNTAphUnNwe9setXQGYdYPZxCRBU7q20oHnEVgyg=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8cWqXo8MLfq71rGMcIAvqcnC3K9cb9xHu8JY6B0cCkmKukif9N
 9rYbrkdbY14vdjy934q2Z8Ek8WGiAQ9Fsh3Qu9IjVng0BbMSka9csMJS
X-Gm-Gg: AYBFou26+0ghqHrA1FMmtp1ku9qetNu0iHZpp06l+wRmlpVuZ/yLwpW/Wph3ICeyqC1
 athauJbJisIO/GiwabUYxywgXSAmHcKPytJXwVBssubmOJszt/agGhVJP+mjD9IoE4HiILVFq7b
 S2djFl2AduEgTO7bfpjNzNXIDdo6CqCWSE7fnBpGU24MSXRYY/yWngZ+GwWOpae3mdQgHdHr0nQ
 hgjZnrptszri5h7w1IdfcJQOLlrta7h+q59XXRgUNsKad/tLA+1kE1BXvxWEIOg5fXReVQk7uFA
 ErLW/dWLdsY8401s7BSa0jo2f8swXwwYtL5bbzLiKO0GanL4ZRaTMmBiNoY3MK1KBLr6uQdjV40
 eMCmgC8IZ+V8A2WYE2QjLXn1+cJ/iX79pL0ykR37XDUU4Lp4kxIqffbRuFPOKC3O4P2aNh2U8dd
 6a7Zom6hwAFMdpo95uWvHxCxJtPwXsP/q8s3TJv5EO6bztGgdBgHAsp6xO07pQ4zir0I83D9avR
 Wh8CMnu2xwJjVWn7AckpxM+iZnPJqxvT4sg5PY2HiPQ617pRvYFOap9fkrdPWk0kafkjU0CbzGC
 AblRrwMYw0ZL4qBFFjbFAtjYvK7jOydNzlSBtDmfyTYGcQAkg1aJRqtcLD/GA1Aotw08bhPHLjg
 ZO2fmw7EDD5xJPhv3NY0m2as1uptk3uWhfV0E8bRQdabiV1tFf7X6IkVSUX7g2RaKfgzFmaYHcC
 0dvp6cYLBJ7l/dXXD6FHz89j9T/D4p9eNvyTE=
X-Received: by 2002:a17:903:1b2c:b0:2ea:a2ea:5f62 with SMTP id
 d9443c01a7336-2eb364b8c96mr87259915ad.24.1793606622268; 
 Mon, 02 Nov 2026 00:03:42 -0800 (PST)
Received: from spider.bream-herring.ts.net ([103.6.151.236])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eb392afa5asm23573655ad.72.2026.11.02.00.03.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 00:03:41 -0800 (PST)
From: Matthias Goergens <matthias.goergens@gmail.com>
To: Helge Deller <deller@gmx.de>
Cc: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/3] fbdev: pxafb: initialize IRQ completions before
 requesting IRQ
Date: Mon,  2 Nov 2026 16:03:32 +0800
Message-ID: <20261102080332.1466689-4-matthias.goergens@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261102080332.1466689-1-matthias.goergens@gmail.com>
References: <20261102080332.1466689-1-matthias.goergens@gmail.com>
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
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

pxafb_handle_irq() completes command_done when LCSR has LCSR_CMD_INT
set, and an overlay's branch_done when LCSR1 has its branch status bit
set.  Probe requests the IRQ before it initialises either: command_done
in pxafb_smart_init(), where commit 07df1c4fea14 ("[ARM] pxafb: small
cleanup of the smart panel code") moved it, and branch_done in the
overlay setup, since the overlays were added.  If one of those status
bits is already set when the handler is installed, for example because
the bootloader left a smart panel or an overlay running, complete()
runs on an uninitialised completion.

Initialise all completions in a helper called from pxafb_init_fbinfo(),
before the IRQ is requested, and drop the later initialisation.

With the completions initialised early, such an interrupt instead
leaves a completion count with no waiter, which would let a later wait
return before its transaction has finished.  So reinitialise
command_done and branch_done just before starting the transactions they
wait for.

I have no PXA hardware.  In a test build on ARM QEMU that raises the
LCD interrupt early through the real handler, the unpatched driver
crashes in complete() and the patched one does not.  After an early
command interrupt, a later smart-panel flush returned success at once
without the reinitialisation, and timed out with it, as it should when
no further interrupt arrives.

Sashiko, the AI review bot, pointed out the early interrupt while
reviewing a pxafb cleanup.

Link: https://lore.kernel.org/all/20260722081427.413EF1F000E9@smtp.kernel.org/
Fixes: 07df1c4fea14 ("[ARM] pxafb: small cleanup of the smart panel code")
Fixes: 198fc108ee4c ("[ARM] pxafb: add support for overlay1 and overlay2 as framebuffer devices")
Signed-off-by: Matthias Goergens <matthias.goergens@gmail.com>
---
 drivers/video/fbdev/pxafb.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/pxafb.c b/drivers/video/fbdev/pxafb.c
index b889a17e7304..afdcb14f4b42 100644
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
@@ -1281,9 +1283,6 @@ static int pxafb_smart_init(struct pxafb_info *fbi)
 	fbi->smart_cmds = (uint16_t *) fbi->dma_buff->cmd_buff;
 	fbi->n_smart_cmds = 0;
 
-	init_completion(&fbi->command_done);
-	init_completion(&fbi->refresh_done);
-
 	if (!fbi->inf->smart_update)
 		return -EINVAL;
 
@@ -1779,6 +1778,23 @@ static void pxafb_decode_mach_info(struct pxafb_info *fbi,
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
@@ -1835,7 +1851,7 @@ static struct pxafb_info *pxafb_init_fbinfo(struct device *dev,
 	init_waitqueue_head(&fbi->ctrlr_wait);
 	INIT_WORK(&fbi->task, pxafb_task);
 	mutex_init(&fbi->ctrlr_lock);
-	init_completion(&fbi->disable_done);
+	pxafb_init_completions(fbi);
 
 	return fbi;
 }
-- 
2.56.0

