Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF2FF99363
	for <dri-devel@archiver.kernel.org>; Thu, 23 Apr 2026 09:45:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C40510F02E;
	Thu, 23 Apr 2026 09:45:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="vuXZb/if";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bwuyMxM0";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vuXZb/if";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bwuyMxM0";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3861B10F00F
 for <dri-devel@lists.freedesktop.org>; Thu, 23 Apr 2026 09:45:04 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 418AA6A83C;
 Thu, 23 Apr 2026 09:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776937499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7tAxn2A+LM9bwTEoO62qUH48d+Pb0dLfk/f5159Clc=;
 b=vuXZb/ifT0L6JPhznT2uYlWCWcouL0v8ZMj7PzDqL5UhavaqRgCc6gK/wUKDLxCMssvajt
 PkK1O7FwtWkAwTDTcCdN7tpVlCApVmDuFr8tymkoM780CpHFpU1v/YHQJL2GSFPlhYu+Bg
 WDN7/83RfQ0gu98hxjPbgSnRQhCP6Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776937499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7tAxn2A+LM9bwTEoO62qUH48d+Pb0dLfk/f5159Clc=;
 b=bwuyMxM0mZ2ukdmtGwqy8Try3bpjq5wCSK+YsNdhMPIA2NcodYKH7pGShTfjC1qcHjvDUr
 tijw12SiRxMuvhDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776937499; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7tAxn2A+LM9bwTEoO62qUH48d+Pb0dLfk/f5159Clc=;
 b=vuXZb/ifT0L6JPhznT2uYlWCWcouL0v8ZMj7PzDqL5UhavaqRgCc6gK/wUKDLxCMssvajt
 PkK1O7FwtWkAwTDTcCdN7tpVlCApVmDuFr8tymkoM780CpHFpU1v/YHQJL2GSFPlhYu+Bg
 WDN7/83RfQ0gu98hxjPbgSnRQhCP6Lc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776937499;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7tAxn2A+LM9bwTEoO62qUH48d+Pb0dLfk/f5159Clc=;
 b=bwuyMxM0mZ2ukdmtGwqy8Try3bpjq5wCSK+YsNdhMPIA2NcodYKH7pGShTfjC1qcHjvDUr
 tijw12SiRxMuvhDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EB95D593B0;
 Thu, 23 Apr 2026 09:44:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cFMdOBrq6Wk+QwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 23 Apr 2026 09:44:58 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 airlied@gmail.com, simona@ffwll.ch, dri-devel@lists.freedesktop.org
Cc: linux-samsung-soc@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 linux-arm-kernel@lists.infradead.org, stable@vger.kernel.org
Subject: [PATCH 1/5] drm/exynos: fbdev: Remove offset into screen_buffer
Date: Thu, 23 Apr 2026 11:37:46 +0200
Message-ID: <20260423094452.32665-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423094452.32665-1-tzimmermann@suse.de>
References: <20260423094452.32665-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[samsung.com,gmail.com,ffwll.ch,lists.freedesktop.org];
 RCVD_TLS_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 RCPT_COUNT_SEVEN(0.00)[10];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email,infradead.org:email];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

The screen_buffer field in struct fb_info contains the kernel address
of the first byte of framebuffer memory. Do not add the display offset.
This offset only describes scrolling during scanout.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 19c8b8343d9c ("drm/exynos: fixed overlay data updating.")
Cc: dri-devel@lists.freedesktop.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: <stable@vger.kernel.org> # v3.2+
---
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
index 637927818dfe..d283ded266d5 100644
--- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
+++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
@@ -61,17 +61,13 @@ static int exynos_drm_fbdev_update(struct drm_fb_helper *helper,
 	struct fb_info *fbi = helper->info;
 	struct drm_framebuffer *fb = helper->fb;
 	unsigned int size = fb->width * fb->height * fb->format->cpp[0];
-	unsigned long offset;
 
 	fbi->fbops = &exynos_drm_fb_ops;
 
 	drm_fb_helper_fill_info(fbi, helper, sizes);
 
-	offset = fbi->var.xoffset * fb->format->cpp[0];
-	offset += fbi->var.yoffset * fb->pitches[0];
-
 	fbi->flags |= FBINFO_VIRTFB;
-	fbi->screen_buffer = exynos_gem->kvaddr + offset;
+	fbi->screen_buffer = exynos_gem->kvaddr;
 	fbi->screen_size = size;
 	fbi->fix.smem_len = size;
 
-- 
2.53.0

