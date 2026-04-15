Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C36E5F43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:26:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B62910E707;
	Wed, 15 Apr 2026 15:26:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="fmVf4JWU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tH/9lvs9";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="fmVf4JWU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tH/9lvs9";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6DE7210E708
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:26:47 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4DB165BE2A;
 Wed, 15 Apr 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FITxdEDDv2kLwrqvXU4DMOG15Sxlh59SAvqvABfYTNo=;
 b=fmVf4JWUAKjVXRu+O1OtKgoDhx3DLQb389i9r2x3RlJEki54nFxL9wu+fN+RpSDqCZYMtc
 dAC7yiPPaB+Nx7tsmrWqjhv/9l2+J7KC2yckglmZzYCjJdN7L5woXKOMD7BM2c7CDYJeFW
 FqrM/vFkYXYmHCbQvdP4uMUSKY5dyY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FITxdEDDv2kLwrqvXU4DMOG15Sxlh59SAvqvABfYTNo=;
 b=tH/9lvs9HAPTi5JUYwGlh2WEib4Vb1dOInz9nOPe32+ORvEUdykWI43ny/rqL1mnPyWa0d
 DaouWomnTsSdYeCA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=fmVf4JWU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="tH/9lvs9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FITxdEDDv2kLwrqvXU4DMOG15Sxlh59SAvqvABfYTNo=;
 b=fmVf4JWUAKjVXRu+O1OtKgoDhx3DLQb389i9r2x3RlJEki54nFxL9wu+fN+RpSDqCZYMtc
 dAC7yiPPaB+Nx7tsmrWqjhv/9l2+J7KC2yckglmZzYCjJdN7L5woXKOMD7BM2c7CDYJeFW
 FqrM/vFkYXYmHCbQvdP4uMUSKY5dyY4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FITxdEDDv2kLwrqvXU4DMOG15Sxlh59SAvqvABfYTNo=;
 b=tH/9lvs9HAPTi5JUYwGlh2WEib4Vb1dOInz9nOPe32+ORvEUdykWI43ny/rqL1mnPyWa0d
 DaouWomnTsSdYeCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 136444BA99;
 Wed, 15 Apr 2026 15:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mAOJAyqu32nXWQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Apr 2026 15:26:34 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/6] drm/mgag200: Simplify offset calculation
Date: Wed, 15 Apr 2026 17:23:37 +0200
Message-ID: <20260415152625.101710-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415152625.101710-1-tzimmermann@suse.de>
References: <20260415152625.101710-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 4DB165BE2A
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

The offset value sets the distance in bytes between two consecutive
scanlines. Reduce the calculation to the minimum.

According to the Matrox programming manual, Sec 4.6.5, the offset
is the scanline pitch in bits divided by 128. The field pitches[0] in
struct drm_framebuffer stores the scanline pitch in bytes, so we have
to divide by 16 only. Reducing the existing bpp-shift look-up and
offset calculations also returns exactly this for all formats.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 28 +-------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 5b526aebaeb8..57c9f731a4bf 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -298,37 +298,11 @@ void mgag200_set_mode_regs(struct mga_device *mdev, const struct drm_display_mod
 	WREG8(MGA_MISC_OUT, misc);
 }
 
-static u8 mgag200_get_bpp_shift(const struct drm_format_info *format)
-{
-	static const u8 bpp_shift[] = {0, 1, 0, 2};
-
-	return bpp_shift[format->cpp[0] - 1];
-}
-
-/*
- * Calculates the HW offset value from the framebuffer's pitch. The
- * offset is a multiple of the pixel size and depends on the display
- * format.
- */
-static u32 mgag200_calculate_offset(struct mga_device *mdev,
-				    const struct drm_framebuffer *fb)
-{
-	u32 offset = fb->pitches[0] / fb->format->cpp[0];
-	u8 bppshift = mgag200_get_bpp_shift(fb->format);
-
-	if (fb->format->cpp[0] * 8 == 24)
-		offset = (offset * 3) >> (4 - bppshift);
-	else
-		offset = offset >> (4 - bppshift);
-
-	return offset;
-}
-
 static void mgag200_set_offset(struct mga_device *mdev,
 			       const struct drm_framebuffer *fb)
 {
 	u8 crtc13, crtcext0;
-	u32 offset = mgag200_calculate_offset(mdev, fb);
+	u32 offset = fb->pitches[0] / 16;
 
 	RREG_ECRT(0, crtcext0);
 
-- 
2.53.0

