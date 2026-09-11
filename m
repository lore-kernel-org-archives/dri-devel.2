Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1A0C88E4C
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 07:46:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F09D710F50E;
	Fri, 11 Sep 2026 07:46:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.com header.i=@suse.com header.b="fZ4vXtTn";
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.b="iaWIehR5";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BEA3B10F50E
 for <dri-devel@lists.freedesktop.org>; Fri, 11 Sep 2026 07:46:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 36FEE1FEED;
 Fri, 11 Sep 2026 07:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1789112774; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIx0j6ZqIXkpJa9WSX1877cr6uVF39zIBxCYwTN5sXc=;
 b=fZ4vXtTn6nJcX2b4YOqeiiShB4O8od71z0vEgnxpKNgCTzNPMKfMgbrKrNluGQHoalVlV0
 QKuUW1rABGz2R3AGy+8FEi7pLpVK5SGQ51SrVdaXE3A8b548MRgG7Dqs9Wf2UgegFzVXkZ
 MLP6LM2+tWDc0pLU2ufSGvkhPV6nZmM=
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1789112770; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jIx0j6ZqIXkpJa9WSX1877cr6uVF39zIBxCYwTN5sXc=;
 b=iaWIehR50qkooZ28Ae679B7GkRyHlwX+cwFwV4aWN1MjKH5bmAhKqdrYYHgbM4ysaAz6Jh
 Db16L9WNXC7WpY4LFUkqedWt2t7E8Vfq/TVB6xZ0Tjxq/0c/1Rr/xnR04H7QiMDqZnPiBq
 Io5tHH46kh+RscAoBD1oOpMTCclW13s=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DDCD913715;
 Fri, 11 Sep 2026 07:46:09 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id jxvWNMGxo2qpWQAAD6G6ig
 (envelope-from <jgross@suse.com>); Fri, 11 Sep 2026 07:46:09 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Juergen Gross <jgross@suse.com>, Helge Deller <deller@gmx.de>,
 linux-geode@lists.infradead.org
Subject: [PATCH v3 06/13] fbdev/geode: Stop using 32-bit MSR interfaces
Date: Fri, 11 Sep 2026 09:45:23 +0200
Message-ID: <20260911074530.3140830-7-jgross@suse.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260911074530.3140830-1-jgross@suse.com>
References: <20260911074530.3140830-1-jgross@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_CC(0.00)[suse.com,gmx.de,lists.infradead.org];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.com:mid,suse.com:email];
 RCVD_TLS_ALL(0.00)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 RCPT_COUNT_FIVE(0.00)[6]; FREEMAIL_ENVRCPT(0.00)[gmx.de]
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

The 32-bit MSR interfaces rdmsr() and wrmsr() are planned to be
removed. Use the related 64-bit variants instead.

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 drivers/video/fbdev/geode/display_gx.c |  8 +++---
 drivers/video/fbdev/geode/lxfb_ops.c   | 38 +++++++++++++-------------
 drivers/video/fbdev/geode/suspend_gx.c | 20 ++++++++------
 3 files changed, 34 insertions(+), 32 deletions(-)

diff --git a/drivers/video/fbdev/geode/display_gx.c b/drivers/video/fbdev/geode/display_gx.c
index 099322cefce0..b93aa21a1d2b 100644
--- a/drivers/video/fbdev/geode/display_gx.c
+++ b/drivers/video/fbdev/geode/display_gx.c
@@ -23,15 +23,15 @@ unsigned int gx_frame_buffer_size(void)
 	unsigned int val;
 
 	if (!cs5535_has_vsa2()) {
-		uint32_t hi, lo;
+		struct msr msr;
 
 		/* The number of pages is (PMAX - PMIN)+1 */
-		rdmsr(MSR_GLIU_P2D_RO0, lo, hi);
+		rdmsrq(MSR_GLIU_P2D_RO0, msr.q);
 
 		/* PMAX */
-		val = ((hi & 0xff) << 12) | ((lo & 0xfff00000) >> 20);
+		val = ((msr.h & 0xff) << 12) | ((msr.l & 0xfff00000) >> 20);
 		/* PMIN */
-		val -= (lo & 0x000fffff);
+		val -= (msr.l & 0x000fffff);
 		val += 1;
 
 		/* The page size is 4k */
diff --git a/drivers/video/fbdev/geode/lxfb_ops.c b/drivers/video/fbdev/geode/lxfb_ops.c
index 2e33da9849b0..f5f1134cae9a 100644
--- a/drivers/video/fbdev/geode/lxfb_ops.c
+++ b/drivers/video/fbdev/geode/lxfb_ops.c
@@ -124,19 +124,19 @@ static const struct {
 
 static void lx_set_dotpll(u32 pllval)
 {
-	u32 dotpll_lo, dotpll_hi;
+	struct msr dotpll;
 	int i;
 
-	rdmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	rdmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 
-	if ((dotpll_lo & MSR_GLCP_DOTPLL_LOCK) && (dotpll_hi == pllval))
+	if ((dotpll.l & MSR_GLCP_DOTPLL_LOCK) && (dotpll.h == pllval))
 		return;
 
-	dotpll_hi = pllval;
-	dotpll_lo &= ~(MSR_GLCP_DOTPLL_BYPASS | MSR_GLCP_DOTPLL_HALFPIX);
-	dotpll_lo |= MSR_GLCP_DOTPLL_DOTRESET;
+	dotpll.h = pllval;
+	dotpll.l &= ~(MSR_GLCP_DOTPLL_BYPASS | MSR_GLCP_DOTPLL_HALFPIX);
+	dotpll.l |= MSR_GLCP_DOTPLL_DOTRESET;
 
-	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 
 	/* Wait 100us for the PLL to lock */
 
@@ -145,15 +145,15 @@ static void lx_set_dotpll(u32 pllval)
 	/* Now, loop for the lock bit */
 
 	for (i = 0; i < 1000; i++) {
-		rdmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
-		if (dotpll_lo & MSR_GLCP_DOTPLL_LOCK)
+		rdmsrq(MSR_GLCP_DOTPLL, dotpll.q);
+		if (dotpll.l & MSR_GLCP_DOTPLL_LOCK)
 			break;
 	}
 
 	/* Clear the reset bit */
 
-	dotpll_lo &= ~MSR_GLCP_DOTPLL_DOTRESET;
-	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	dotpll.l &= ~MSR_GLCP_DOTPLL_DOTRESET;
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 }
 
 /* Set the clock based on the frequency specified by the current mode */
@@ -268,7 +268,7 @@ static void lx_graphics_enable(struct fb_info *info)
 		config |= VP_DCFG_CRT_VSYNC_POL;
 
 	if (par->output & OUTPUT_PANEL) {
-		u32 msrlo, msrhi;
+		struct msr val;
 
 		write_fp(par, FP_PT1, 0);
 		temp = FP_PT2_SCRC;
@@ -282,10 +282,10 @@ static void lx_graphics_enable(struct fb_info *info)
 		write_fp(par, FP_PT2, temp);
 		write_fp(par, FP_DFC, FP_DFC_BC);
 
-		msrlo = MSR_LX_MSR_PADSEL_TFT_SEL_LOW;
-		msrhi = MSR_LX_MSR_PADSEL_TFT_SEL_HIGH;
+		val.l = MSR_LX_MSR_PADSEL_TFT_SEL_LOW;
+		val.h = MSR_LX_MSR_PADSEL_TFT_SEL_HIGH;
 
-		wrmsr(MSR_LX_MSR_PADSEL, msrlo, msrhi);
+		wrmsrq(MSR_LX_MSR_PADSEL, val.q);
 	}
 
 	if (par->output & OUTPUT_CRT) {
@@ -313,15 +313,15 @@ unsigned int lx_framebuffer_size(void)
 	unsigned int val;
 
 	if (!cs5535_has_vsa2()) {
-		uint32_t hi, lo;
+		struct msr msr;
 
 		/* The number of pages is (PMAX - PMIN)+1 */
-		rdmsr(MSR_GLIU_P2D_RO0, lo, hi);
+		rdmsrq(MSR_GLIU_P2D_RO0, msr.q);
 
 		/* PMAX */
-		val = ((hi & 0xff) << 12) | ((lo & 0xfff00000) >> 20);
+		val = ((msr.h & 0xff) << 12) | ((msr.l & 0xfff00000) >> 20);
 		/* PMIN */
-		val -= (lo & 0x000fffff);
+		val -= (msr.l & 0x000fffff);
 		val += 1;
 
 		/* The page size is 4k */
diff --git a/drivers/video/fbdev/geode/suspend_gx.c b/drivers/video/fbdev/geode/suspend_gx.c
index 73307f42e343..6c0a526ee8a2 100644
--- a/drivers/video/fbdev/geode/suspend_gx.c
+++ b/drivers/video/fbdev/geode/suspend_gx.c
@@ -40,25 +40,27 @@ static void gx_save_regs(struct gxfb_par *par)
 
 static void gx_set_dotpll(uint32_t dotpll_hi)
 {
-	uint32_t dotpll_lo;
+	struct msr dotpll;
 	int i;
 
-	rdmsrq(MSR_GLCP_DOTPLL, dotpll_lo);
-	dotpll_lo |= MSR_GLCP_DOTPLL_DOTRESET;
-	dotpll_lo &= ~MSR_GLCP_DOTPLL_BYPASS;
-	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	rdmsrq(MSR_GLCP_DOTPLL, dotpll.q);
+	dotpll.l |= MSR_GLCP_DOTPLL_DOTRESET;
+	dotpll.l &= ~MSR_GLCP_DOTPLL_BYPASS;
+	dotpll.h = dotpll_hi;
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 
 	/* wait for the PLL to lock */
 	for (i = 0; i < 200; i++) {
-		rdmsrq(MSR_GLCP_DOTPLL, dotpll_lo);
-		if (dotpll_lo & MSR_GLCP_DOTPLL_LOCK)
+		rdmsrq(MSR_GLCP_DOTPLL, dotpll.q);
+		if (dotpll.l & MSR_GLCP_DOTPLL_LOCK)
 			break;
 		udelay(1);
 	}
 
 	/* PLL set, unlock */
-	dotpll_lo &= ~MSR_GLCP_DOTPLL_DOTRESET;
-	wrmsr(MSR_GLCP_DOTPLL, dotpll_lo, dotpll_hi);
+	dotpll.l &= ~MSR_GLCP_DOTPLL_DOTRESET;
+	dotpll.h = dotpll_hi;
+	wrmsrq(MSR_GLCP_DOTPLL, dotpll.q);
 }
 
 static void gx_restore_gfx_proc(struct gxfb_par *par)
-- 
2.55.0

