Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE89B60A2616
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=FEyTbsT1;
	dkim=pass (1024-bit key) header.d=suse.com header.i=@suse.com header.a=rsa-sha256 header.s=susede1 header.b=FEyTbsT1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0083710E4FC;
	Mon, 16 Nov 2026 15:03:01 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B9A6610E4FC
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:02:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 47B8E1F7EA;
 Mon, 16 Nov 2026 15:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1794841368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvmpwtkAtSUTu+R0wghNThvO5/uYBR5Qg46tLY3spXM=;
 b=FEyTbsT1ldGgF8fsccthUHmUCSfieVaYaqXXJbK9uKW4dKSW+yMC+2bvPGtPY6Br949C8G
 6xl1EZk1KepGGbXz6sfSbpo4nr7gknqXF8kZWs+1L8Ou6E2vr0aJ1fVH1rle0U/AL2437A
 +Hoh8PwM7ZSXHhSvIjizq8f1W+czz6Q=
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.com header.s=susede1 header.b=FEyTbsT1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1794841368; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tvmpwtkAtSUTu+R0wghNThvO5/uYBR5Qg46tLY3spXM=;
 b=FEyTbsT1ldGgF8fsccthUHmUCSfieVaYaqXXJbK9uKW4dKSW+yMC+2bvPGtPY6Br949C8G
 6xl1EZk1KepGGbXz6sfSbpo4nr7gknqXF8kZWs+1L8Ou6E2vr0aJ1fVH1rle0U/AL2437A
 +Hoh8PwM7ZSXHhSvIjizq8f1W+czz6Q=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EABAB13408;
 Mon, 16 Nov 2026 15:02:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 17tqMBcb+2qAEAAAD6G6ig
 (envelope-from <jgross@suse.com>); Mon, 16 Nov 2026 15:02:47 +0000
From: Juergen Gross <jgross@suse.com>
To: linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Cc: Juergen Gross <jgross@suse.com>, Helge Deller <deller@gmx.de>,
 linux-geode@lists.infradead.org
Subject: [PATCH v6 06/12] fbdev/geode: Stop using 32-bit MSR interfaces
Date: Mon, 16 Nov 2026 16:02:02 +0100
Message-ID: <20261116150208.1572254-7-jgross@suse.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261116150208.1572254-1-jgross@suse.com>
References: <20261116150208.1572254-1-jgross@suse.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 47B8E1F7EA
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-12.01 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.com:s=susede1];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; DKIM_SIGNED(0.00)[suse.com:s=susede1];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 URIBL_BLOCKED(0.00)[suse.com:dkim,suse.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_CC(0.00)[suse.com,gmx.de,lists.infradead.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:dkim,suse.com:email];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DKIM_TRACE(0.00)[suse.com:+]; FREEMAIL_ENVRCPT(0.00)[gmx.de]
X-Spam-Score: -12.01
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
2.56.0

