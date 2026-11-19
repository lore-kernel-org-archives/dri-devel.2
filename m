Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C3BC606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0keLFOqf;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6X6z4JZn;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=0keLFOqf;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=6X6z4JZn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B315E10E772;
	Thu, 19 Nov 2026 14:21:50 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 94F8F112498
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:21:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 39ED61F808;
 Thu, 19 Nov 2026 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDitDNQr2Qy5Wy9Z9Zm6/kDAU+Gzv5SFn8YC0NcqW8A=;
 b=0keLFOqfhzvVIAP1EWlNPlaZVOZM+LyqNWw0ShQN/BN34jIs7m8Rb/2JfIBbU+vNLPB51E
 MDhi/ln4n6vdQ2f2a1t2XDu2qf/N+m48kJQOmR+mXsdB5op8GROpxtfbiPpnnv/E+6uu5e
 ZO3ZCIK1vpZrNyiyklVze6HiS3jUabI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDitDNQr2Qy5Wy9Z9Zm6/kDAU+Gzv5SFn8YC0NcqW8A=;
 b=6X6z4JZnYTlcE/TrqcXX+ps+92g5xidJLOiJ6+T0imeW9+MZlPNP3LSPyYG5qgS4qa831S
 rg960LGTcXputQAA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDitDNQr2Qy5Wy9Z9Zm6/kDAU+Gzv5SFn8YC0NcqW8A=;
 b=0keLFOqfhzvVIAP1EWlNPlaZVOZM+LyqNWw0ShQN/BN34jIs7m8Rb/2JfIBbU+vNLPB51E
 MDhi/ln4n6vdQ2f2a1t2XDu2qf/N+m48kJQOmR+mXsdB5op8GROpxtfbiPpnnv/E+6uu5e
 ZO3ZCIK1vpZrNyiyklVze6HiS3jUabI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDitDNQr2Qy5Wy9Z9Zm6/kDAU+Gzv5SFn8YC0NcqW8A=;
 b=6X6z4JZnYTlcE/TrqcXX+ps+92g5xidJLOiJ6+T0imeW9+MZlPNP3LSPyYG5qgS4qa831S
 rg960LGTcXputQAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 69FD013510;
 Thu, 19 Nov 2026 14:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig:T4
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 03/11] drm/udl: Store per-URB allocation length in struct
 urb_node
Date: Thu, 19 Nov 2026 15:02:15 +0100
Message-ID: <20261119142114.152052-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119142114.152052-1-tzimmermann@suse.de>
References: <20261119142114.152052-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
X-Spamd-Result: default: False [-10.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -10.30
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

Store the length of an URB's data buffer in the URB's instance of
struct urb_node. Use the value for free'ing the buffer. Remove the
obsolete size field from struct urb_list.

With the URB cache in place, all URBs have the same buffer size. At
some point we want URBs to have an individual length for their allocated
buffer. Hence, the buffer length needs to be stored separately.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.h  |  2 +-
 drivers/gpu/drm/udl/udl_main.c | 13 +++++++------
 2 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 68c5a5feb6f3..4736d83aec9a 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -37,6 +37,7 @@ struct urb_node {
 	struct list_head entry;
 	struct udl_device *dev;
 	struct urb *urb;
+	size_t alloc_size;
 };
 
 struct urb_list {
@@ -45,7 +46,6 @@ struct urb_list {
 	wait_queue_head_t sleep;
 	int available;
 	int count;
-	size_t size;
 };
 
 struct udl_device {
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 77b0bc560422..67da676f0f94 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -180,7 +180,7 @@ static void udl_free_urb_list(struct udl_device *udl)
 			break;
 		unode = urb->context;
 		/* Free each separately allocated piece */
-		usb_free_coherent(urb->dev, udl->urbs.size,
+		usb_free_coherent(urb->dev, unode->alloc_size,
 				  urb->transfer_buffer, urb->transfer_dma);
 		usb_free_urb(urb);
 		kfree(unode);
@@ -204,8 +204,6 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 	udl->urbs.available = 0;
 
 retry:
-	udl->urbs.size = size;
-
 	while (udl->urbs.count * size < wanted_size) {
 		unode = kzalloc_obj(struct urb_node);
 		if (!unode)
@@ -218,8 +216,9 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 			break;
 		}
 		unode->urb = urb;
+		unode->alloc_size = size;
 
-		buf = usb_alloc_coherent(udev, size, GFP_KERNEL,
+		buf = usb_alloc_coherent(udev, unode->alloc_size, GFP_KERNEL,
 					 &urb->transfer_dma);
 		if (!buf) {
 			kfree(unode);
@@ -290,7 +289,7 @@ void udl_put_urb(struct urb *urb)
 	struct udl_device *udl = unode->dev;
 	unsigned long flags;
 
-	urb->transfer_buffer_length = udl->urbs.size; /* reset to actual */
+	urb->transfer_buffer_length = unode->alloc_size; /* reset to actual */
 
 	spin_lock_irqsave(&udl->urbs.lock, flags);
 	list_add_tail(&unode->entry, &udl->urbs.list);
@@ -302,9 +301,11 @@ void udl_put_urb(struct urb *urb)
 
 int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len)
 {
+	struct drm_device *drm = &udl->drm;
+	struct urb_node *unode = urb->context;
 	int ret;
 
-	if (WARN_ON(len > udl->urbs.size)) {
+	if (drm_WARN_ON_ONCE(drm, len > unode->alloc_size)) {
 		ret = -EINVAL;
 		goto error;
 	}
-- 
2.56.0

