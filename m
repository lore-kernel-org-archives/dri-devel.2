Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8382BC61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 08:31:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E6410EEEF;
	Thu, 27 Aug 2026 08:31:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1/quAHwF";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="KJbltxMw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="kmIQHo7S";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="fmkNJGJx";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E26BC10EEEF
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 08:30:59 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 40BA31F855;
 Thu, 27 Aug 2026 08:29:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787819366; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/JwlZj7dOodqj+bdciCvjxIbEJvuQ84QQuXlM2Prc0=;
 b=1/quAHwFm+0GTFcvqtBVfeczYVbq8O9zr7hSfn0e+r69ZduJN5u9WcLnUdYCzpPDCB7mcU
 L07ljqtRBDMzwUi0v0SDe1L9nWf/I71BYA1gFB+mai9+q06GS3OwdqhriTEtcdF8+pVjrQ
 1e5cGGX1Gg80G7j3dHt38B9uv+ZC4Cw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787819366;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/JwlZj7dOodqj+bdciCvjxIbEJvuQ84QQuXlM2Prc0=;
 b=KJbltxMwdP2dggup4u3eUrl6pLcHWsqmjPAEhwKGYEG5aTtrzW8fYQmRop0l8WSTTBSBnD
 NdL23nX6tmBLzcCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787819362; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/JwlZj7dOodqj+bdciCvjxIbEJvuQ84QQuXlM2Prc0=;
 b=kmIQHo7SDDbxvOlnlLqxinwe5MzTF/XvM+aSMwFQl8HrlFQSjiAbUGOIxnapav8+/iIrr8
 dxS+8zf2DK9Lq2swNCrgj9jShOb4su0DwdSrazO2V53MPA52pi+UWRm92MkghfchwuiwHf
 +DOexITJIEONXR42b0+/dW025LlK6Dw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787819362;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=y/JwlZj7dOodqj+bdciCvjxIbEJvuQ84QQuXlM2Prc0=;
 b=fmkNJGJxBgJAVhreqCGmUx7SQ9CdAhKjpeT4v2bouLg9zBDKNCCbS54vxrX3qqq0Lr9HDn
 wIT7/lXFQhLyp1Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0047713533;
 Thu, 27 Aug 2026 08:29:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 2OxBOmH1j2p4PAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 08:29:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: shiyongbang@huawei.com, kong.kongxinwei@hisilicon.com,
 tiantao6@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/2] drm/hibmc: Set up vblank event to be send on the next
 vblank
Date: Thu, 27 Aug 2026 10:23:45 +0200
Message-ID: <20260827082915.61176-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827082915.61176-1-tzimmermann@suse.de>
References: <20260827082915.61176-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-0.999]; MIME_GOOD(-0.10)[text/plain];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 FROM_HAS_DN(0.00)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; RCPT_COUNT_SEVEN(0.00)[9];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Do not send the vblank event when the page flip completes, but when
the vblank interrupt fires. Sending the vblank event at the wrong time
can break synchronization of the display update with the vblank period.

Use the vblank helper drm_crtc_vblank_atomic_flush(), which sets up
the vblank event accordingly. In case of an error, it still sends out
the vblank event immediately; thus not starving consumers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c | 16 ++--------------
 1 file changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
index b4ab53db1c08..72ce696e6d11 100644
--- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
+++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c
@@ -20,6 +20,7 @@
 #include <drm/drm_gem_atomic_helper.h>
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_vblank.h>
+#include <drm/drm_vblank_helper.h>
 
 #include "hibmc_drm_drv.h"
 #include "hibmc_drm_regs.h"
@@ -420,19 +421,6 @@ static void hibmc_crtc_atomic_begin(struct drm_crtc *crtc,
 	/* We can add more initialization as needed. */
 }
 
-static void hibmc_crtc_atomic_flush(struct drm_crtc *crtc,
-				    struct drm_atomic_commit *state)
-
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&crtc->dev->event_lock, flags);
-	if (crtc->state->event)
-		drm_crtc_send_vblank_event(crtc, crtc->state->event);
-	crtc->state->event = NULL;
-	spin_unlock_irqrestore(&crtc->dev->event_lock, flags);
-}
-
 static int hibmc_crtc_enable_vblank(struct drm_crtc *crtc)
 {
 	struct hibmc_drm_private *priv = to_hibmc_drm_private(crtc->dev);
@@ -502,7 +490,7 @@ static const struct drm_crtc_funcs hibmc_crtc_funcs = {
 static const struct drm_crtc_helper_funcs hibmc_crtc_helper_funcs = {
 	.mode_set_nofb	= hibmc_crtc_mode_set_nofb,
 	.atomic_begin	= hibmc_crtc_atomic_begin,
-	.atomic_flush	= hibmc_crtc_atomic_flush,
+	.atomic_flush	= drm_crtc_vblank_atomic_flush,
 	.atomic_enable	= hibmc_crtc_atomic_enable,
 	.atomic_disable	= hibmc_crtc_atomic_disable,
 	.mode_valid = hibmc_crtc_mode_valid,
-- 
2.55.0

