Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68839FF8868
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:03:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD32210E7A6;
	Mon, 27 Apr 2026 15:03:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="IKLq2LAR";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="1RQtv4hC";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bgOOopsY";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Syreb9oE";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CB7D10E7AB
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:03:09 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 88AC55BCCB;
 Mon, 27 Apr 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777302175; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlgIRhMdhESmpQR8vUMZK/LBpcx/oPqaXUJiiL5XOjU=;
 b=IKLq2LARHclQNU+bh3GKoZC2KtDk/UdiubeTzbsb1D1jiYSmaBnuRT/rbnFYjQBPR8OYvo
 cYyc3Xj4ZuzTTzoIIXdjeLnxVe3KZglGr8AXj9487VKTxQ33fqYAQQOYoFRUuvOX8hJKZI
 uuc6A1WpSdVxfI6PIcGoV5sGfSMVeGM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777302175;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlgIRhMdhESmpQR8vUMZK/LBpcx/oPqaXUJiiL5XOjU=;
 b=1RQtv4hCAne2Ki5ry5BYln0gpBZT1xKawfQv5I53BLSnPJPNvrOC/1J/gzkDC3HozKehhW
 8zC6GEIbuCF8EzCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777302174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlgIRhMdhESmpQR8vUMZK/LBpcx/oPqaXUJiiL5XOjU=;
 b=bgOOopsYNRnDvJ/f1pGJVFeYKE5p8jKGmvEXZztM4kNVOlNcrpS7pPACxzvM8EmA1MZZGe
 FGy2MFFFWqyBS1B3CSTSolpgcl0pqGrLZGkZsmodOw+XojwOzKw72rfFqLHdwM41Rg7Xe+
 f9qIpH+GJCqGbGgv8mpLINps5AoNfDw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777302174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nlgIRhMdhESmpQR8vUMZK/LBpcx/oPqaXUJiiL5XOjU=;
 b=Syreb9oE+ZHUsyL2KEl8GQZD8D5mtbkR2euNRWhlpbGzVVyIXqlefjeTXtbmB/bk/Q9Tdq
 Lnv+ThSYOp0cf/DA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 56ACC593B1;
 Mon, 27 Apr 2026 15:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id iLirE55672k9OQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 15:02:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 1/3] drm/vmwgfx: Determine lock-waiting timeout from vblank
 state
Date: Mon, 27 Apr 2026 17:00:38 +0200
Message-ID: <20260427150250.699768-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260427150250.699768-1-tzimmermann@suse.de>
References: <20260427150250.699768-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[99.99%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_DN_SOME(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; RCPT_COUNT_FIVE(0.00)[6];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid,suse.de:email];
 RCVD_TLS_ALL(0.00)[]
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

Use the calculated duration of a frame as stored in the vblank state
for the lock-waiting timeout. Decouples the waiting from the details
of the vblank implementation. Both values should be equal.

This will be helpful for replacing vmwgfx's vblank timer with DRM's
common implementation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
index 5abd7f5ad2db..7862f6972512 100644
--- a/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
+++ b/drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c
@@ -516,9 +516,13 @@ vmw_vkms_set_crc_surface(struct drm_crtc *crtc,
 static inline u64
 vmw_vkms_lock_max_wait_ns(struct vmw_display_unit *du)
 {
-	s64 nsecs = ktime_to_ns(du->vkms.period_ns);
+	struct drm_crtc *crtc = &du->crtc;
+	struct drm_vblank_crtc *vblank = drm_crtc_vblank_crtc(crtc);
+
+	if (!vblank || !vblank->framedur_ns)
+		return NSEC_PER_SEC / 60; /* disabled; assume 60 Hz */
 
-	return  (nsecs > 0) ? nsecs : 16666666;
+	return vblank->framedur_ns;
 }
 
 /**
-- 
2.54.0

