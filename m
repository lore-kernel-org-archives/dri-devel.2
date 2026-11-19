Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB78606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZvPkAXLx;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=bZeabSRy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rGA9EgM/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=wM67+xNa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD7F8112479;
	Thu, 19 Nov 2026 14:22:02 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59891112492
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:21:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id AA318223EB;
 Thu, 19 Nov 2026 14:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XT6cNWyrHJaH2C7fwtB1oaRlBLqQ5gmYANIDVmnUjRg=;
 b=ZvPkAXLxHmrb3WbSq5uu4y36bQMN/4V8RIjffQfNNJxjGxVzMSOkCL9YSyBo59EmaU+CWY
 vZYGTKPKogNgcgFTR9qlqDZRvVZxpXyy3h/Sc/Efm3zzb2uwUfDDmOduRy3MJbMYkAIZfu
 eo8D+sEB0wmzvv7FwmeGhKe950aUyzg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XT6cNWyrHJaH2C7fwtB1oaRlBLqQ5gmYANIDVmnUjRg=;
 b=bZeabSRyyKtqE0Bv9+6PbhYqmZ3xTB0A8YC13O8iP5UeZUChmvp8ApVXB0xaiHwYWu1lwa
 iaMtVUPN7RwlwdBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="rGA9EgM/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=wM67+xNa
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098081; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XT6cNWyrHJaH2C7fwtB1oaRlBLqQ5gmYANIDVmnUjRg=;
 b=rGA9EgM/xvFpUsgAsfyV4vA1eRgUj0lRVveK0dnxrit/Jmo3mHfgfa1uZEpll+iFv+trD9
 9A0eVUkOH6tFuNCVv+W1Tde56Lb3JRo9ljJVKTAim4nc57WKlf1ZhwBlaWr7n/sXoqQgNy
 yE7R+o8RSRSSqhhjxj1gfepJntCE+E4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098081;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XT6cNWyrHJaH2C7fwtB1oaRlBLqQ5gmYANIDVmnUjRg=;
 b=wM67+xNa6GOJ1jSizvbYGygbddQb+bIeL+FhBElkoKvD2cqznoAGS+kgFXpp5l6lzfPBJC
 j4lfnM7v/V6qGOBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 0F2BE13507;
 Thu, 19 Nov 2026 14:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig:T3
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 02/11] drm/udl: Do not use URB completion handler for error
 cleanup
Date: Thu, 19 Nov 2026 15:02:14 +0100
Message-ID: <20261119142114.152052-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119142114.152052-1-tzimmermann@suse.de>
References: <20261119142114.152052-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: AA318223EB
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-10.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[11]; RCVD_VIA_SMTP_AUTH(0.00)[];
 TAGGED_RCPT(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -10.51
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

Call udl_put_urb() to release an URB back into the URB cache. Replace
udl_urb_completion() in error-handling code.

The URB completion handler runs in interrupt context after the USB
subsystem has processed an URB. Do not call it from udl's error-handling
logic.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.h      | 1 -
 drivers/gpu/drm/udl/udl_main.c     | 4 ++--
 drivers/gpu/drm/udl/udl_modeset.c  | 2 +-
 drivers/gpu/drm/udl/udl_transfer.c | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 9535e9c59950..68c5a5feb6f3 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -77,7 +77,6 @@ void udl_put_urb(struct urb *urb);
 
 int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len);
 void udl_sync_pending_urbs(struct udl_device *udl);
-void udl_urb_completion(struct urb *urb);
 
 int udl_init(struct udl_device *udl);
 
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 936fb6565bdb..77b0bc560422 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -147,7 +147,7 @@ int udl_select_std_channel(struct udl_device *udl)
 	return ret < 0 ? ret : 0;
 }
 
-void udl_urb_completion(struct urb *urb)
+static void udl_urb_completion(struct urb *urb)
 {
 	/* sync/async unlink faults aren't errors */
 	if (urb->status) {
@@ -312,7 +312,7 @@ int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len)
 	ret = usb_submit_urb(urb, GFP_ATOMIC);
  error:
 	if (ret) {
-		udl_urb_completion(urb); /* because no one else will */
+		udl_put_urb(urb);
 		DRM_ERROR("usb_submit_urb error %x\n", ret);
 	}
 	return ret;
diff --git a/drivers/gpu/drm/udl/udl_modeset.c b/drivers/gpu/drm/udl/udl_modeset.c
index d8a617e2d2ea..bbba1dee8e4f 100644
--- a/drivers/gpu/drm/udl/udl_modeset.c
+++ b/drivers/gpu/drm/udl/udl_modeset.c
@@ -243,7 +243,7 @@ static int udl_handle_damage(struct drm_framebuffer *fb,
 		len = cmd - (char *)urb->transfer_buffer;
 		ret = udl_submit_urb(udl, urb, len);
 	} else {
-		udl_urb_completion(urb);
+		udl_put_urb(urb);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/udl/udl_transfer.c b/drivers/gpu/drm/udl/udl_transfer.c
index 7d670b3a5293..de8e673d1efa 100644
--- a/drivers/gpu/drm/udl/udl_transfer.c
+++ b/drivers/gpu/drm/udl/udl_transfer.c
@@ -183,7 +183,7 @@ int udl_render_hline(struct udl_device *udl, int log_bpp, struct urb **urb_ptr,
 
 	if (WARN_ON(!(log_bpp == 1 || log_bpp == 2))) {
 		/* need to finish URB at error from this function */
-		udl_urb_completion(urb);
+		udl_put_urb(urb);
 		return -EINVAL;
 	}
 
-- 
2.56.0

