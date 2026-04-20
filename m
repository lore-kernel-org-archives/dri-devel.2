Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6BC8F588C6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 13:18:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 051E510E5EB;
	Mon, 20 Apr 2026 13:18:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="iUFqg2k5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="13F8sboR";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="iUFqg2k5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="13F8sboR";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ED5AA10E5EB
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 13:18:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 908CA6AD9D;
 Mon, 20 Apr 2026 13:18:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776691115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Wnr69w8Txx9ZWYJgRgvfRUazE1jjfo2onqmgvwftg8=;
 b=iUFqg2k5l4US5d2suXIUtIsMHp4MTF3TMZh17ksF9AVlq41PUQsQL5mRhgh8RLtRdeU1MC
 WH3Qy5MMxGGOa1tArqsJdIL1sIeet2dkYJz6+qUmmk6OXm05g22ZqgWWf9xZZIeNzjGAPH
 mkDJtppZvaILZVaNL749xJY6IV2HdjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776691115;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Wnr69w8Txx9ZWYJgRgvfRUazE1jjfo2onqmgvwftg8=;
 b=13F8sboRDeIkvoksanrOoKTN4gmJzekhtlahfx692kF3JsSUpbCNzXuIirnh0grL3TUvSj
 aVUFdlPQyv511NCQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=iUFqg2k5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=13F8sboR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776691115; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Wnr69w8Txx9ZWYJgRgvfRUazE1jjfo2onqmgvwftg8=;
 b=iUFqg2k5l4US5d2suXIUtIsMHp4MTF3TMZh17ksF9AVlq41PUQsQL5mRhgh8RLtRdeU1MC
 WH3Qy5MMxGGOa1tArqsJdIL1sIeet2dkYJz6+qUmmk6OXm05g22ZqgWWf9xZZIeNzjGAPH
 mkDJtppZvaILZVaNL749xJY6IV2HdjM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776691115;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=+Wnr69w8Txx9ZWYJgRgvfRUazE1jjfo2onqmgvwftg8=;
 b=13F8sboRDeIkvoksanrOoKTN4gmJzekhtlahfx692kF3JsSUpbCNzXuIirnh0grL3TUvSj
 aVUFdlPQyv511NCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5227E593AE;
 Mon, 20 Apr 2026 13:18:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 98qyEqsn5mklJgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Apr 2026 13:18:35 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: louis.chauvet@bootlin.com, hamohammed.sa@gmail.com, simona@ffwll.ch,
 melissa.srw@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/vkms: Clean up artifacts from old vblank timer
Date: Mon, 20 Apr 2026 15:18:08 +0200
Message-ID: <20260420131831.242882-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-1.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 FREEMAIL_TO(0.00)[bootlin.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,bootlin.com:email,lists.freedesktop.org:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[9];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCVD_COUNT_TWO(0.00)[2]; TAGGED_RCPT(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 908CA6AD9D
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

Vkms uses DRM's shared vblank timer. Do not include hrtimer.h and
fix comments referring to the original implementation. This should
have been done as part of commit 02e2681ffe1a ("drm/vkms: Convert
to DRM's vblank timer").

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 02e2681ffe1a ("drm/vkms: Convert to DRM's vblank timer")
Cc: Louis Chauvet <louis.chauvet@bootlin.com>
Cc: Haneen Mohammed <hamohammed.sa@gmail.com>
Cc: Simona Vetter <simona@ffwll.ch>
Cc: Melissa Wen <melissa.srw@gmail.com>
Cc: dri-devel@lists.freedesktop.org
---
 drivers/gpu/drm/vkms/vkms_composer.c | 4 ++--
 drivers/gpu/drm/vkms/vkms_drv.h      | 5 -----
 2 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 83d217085ad0..db940eff43d7 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -595,7 +595,7 @@ static int compose_active_planes(struct vkms_writeback_job *active_wb,
  *
  * Work handler for composing and computing CRCs. work_struct scheduled in
  * an ordered workqueue that's periodically scheduled to run by
- * vkms_vblank_simulate() and flushed at vkms_atomic_commit_tail().
+ * vkms_crtc_handle_vblank_timeout() and flushed at vkms_atomic_commit_tail().
  */
 void vkms_composer_worker(struct work_struct *work)
 {
@@ -637,7 +637,7 @@ void vkms_composer_worker(struct work_struct *work)
 	spin_unlock_irq(&out->composer_lock);
 
 	/*
-	 * We raced with the vblank hrtimer and previous work already computed
+	 * We raced with the vblank timer and previous work already computed
 	 * the crc, nothing to do.
 	 */
 	if (!crc_pending)
diff --git a/drivers/gpu/drm/vkms/vkms_drv.h b/drivers/gpu/drm/vkms/vkms_drv.h
index 0933e4ce0ff0..3b5bdf39c031 100644
--- a/drivers/gpu/drm/vkms/vkms_drv.h
+++ b/drivers/gpu/drm/vkms/vkms_drv.h
@@ -3,8 +3,6 @@
 #ifndef _VKMS_DRV_H_
 #define _VKMS_DRV_H_
 
-#include <linux/hrtimer.h>
-
 #include <drm/drm.h>
 #include <drm/drm_framebuffer.h>
 #include <drm/drm_gem.h>
@@ -205,9 +203,6 @@ struct vkms_crtc_state {
  * @encoder: DRM encoder used for this output
  * @connector: DRM connector used for this output
  * @wb_connecter: DRM writeback connector used for this output
- * @vblank_hrtimer: Timer used to trigger the vblank
- * @period_ns: vblank period, in nanoseconds, used to configure @vblank_hrtimer and to compute
- *	       vblank timestamps
  * @composer_workq: Ordered workqueue for @composer_state.composer_work.
  * @lock: Lock used to protect concurrent access to the composer
  * @composer_enabled: Protected by @lock, true when the VKMS composer is active (crc needed or
-- 
2.53.0

