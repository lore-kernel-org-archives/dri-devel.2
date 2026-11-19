Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A817606A326
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CapQc7Of;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=B6I4W2Lx;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=CapQc7Of;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=B6I4W2Lx
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 38A4D112494;
	Thu, 19 Nov 2026 14:23:27 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4DBC51124B1
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:23:16 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 66E601FC24;
 Thu, 19 Nov 2026 14:21:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zd36v0W7RDUUNGlk2vNLhydp34CBLuE2PR0HuI7Gx+0=;
 b=CapQc7Of9y/4XAKr4J40p/uRR4MfsQNRo1Nykw4sg7XXQNjaIyPggqEkWsJ3CJgCYabIkK
 4BLF1TFD4dt6Um/m8dPZS6UpXtoW3paHtigztXT88jeWyBWIocWxikuoTtNnxTtnQTeNrS
 koxItTdMaXRnCgJk/S8IBpZ89x2GaAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zd36v0W7RDUUNGlk2vNLhydp34CBLuE2PR0HuI7Gx+0=;
 b=B6I4W2LxauqqU7FaGeLXS7B05xEwkapo2/M9ENwPIdJOFg2yoTxTITTVteQsTlRfjtFgSa
 awpq42+MvnwDioCw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CapQc7Of;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=B6I4W2Lx
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zd36v0W7RDUUNGlk2vNLhydp34CBLuE2PR0HuI7Gx+0=;
 b=CapQc7Of9y/4XAKr4J40p/uRR4MfsQNRo1Nykw4sg7XXQNjaIyPggqEkWsJ3CJgCYabIkK
 4BLF1TFD4dt6Um/m8dPZS6UpXtoW3paHtigztXT88jeWyBWIocWxikuoTtNnxTtnQTeNrS
 koxItTdMaXRnCgJk/S8IBpZ89x2GaAo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Zd36v0W7RDUUNGlk2vNLhydp34CBLuE2PR0HuI7Gx+0=;
 b=B6I4W2LxauqqU7FaGeLXS7B05xEwkapo2/M9ENwPIdJOFg2yoTxTITTVteQsTlRfjtFgSa
 awpq42+MvnwDioCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id F2BEF13646;
 Thu, 19 Nov 2026 14:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig:T11
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 10/11] drm/udl: Allocate URBs on demand
Date: Thu, 19 Nov 2026 15:02:22 +0100
Message-ID: <20261119142114.152052-11-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119142114.152052-1-tzimmermann@suse.de>
References: <20261119142114.152052-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 66E601FC24
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
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+];
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

Remove the limit on the number of URBs in flight. Allocate URBs as
needed. Keep once-allocated URBs in a list for reuse at later frames.
Also remove some bogus debug output from the affected code.

The existing synchronization in atomic_begin() guarantees that udl
does not send a frame over the USB before the previous frame has been
transferred. This avoids overloading the USB. If the USB is saturated,
page flips delay and the compositor reduces the update frequency.

The allocated URBs remain in the cache until the driver is being removed
from the device. In a later update, a regular worker or a shrinker could
free the URB cache when needed.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.h  |   1 -
 drivers/gpu/drm/udl/udl_main.c | 123 ++++++++++++---------------------
 2 files changed, 44 insertions(+), 80 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 420166bdc4bc..68bcf0222764 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -45,7 +45,6 @@ struct urb_list {
 	spinlock_t lock;
 	wait_queue_head_t sleep;
 	unsigned int in_flight;
-	int count;
 };
 
 struct udl_device {
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index d0195bd4213d..adddcf4b3451 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -25,13 +25,10 @@
 #define NR_USB_REQUEST_CHANNEL 0x12
 
 #define MAX_TRANSFER (PAGE_SIZE*16 - BULK_SIZE)
-#define WRITES_IN_FLIGHT (20)
 #define MAX_VENDOR_DESCRIPTOR_SIZE 256
 
 #define UDL_SKU_PIXEL_LIMIT_DEFAULT	2080000
 
-static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout);
-
 /*
  * Try to make sense of whatever we parse. Therefore return @end on
  * errors, but don't fail hard.
@@ -216,25 +213,41 @@ static struct urb *udl_alloc_bulk_urb(struct udl_device *udl, size_t size)
 	return ERR_PTR(ret);
 }
 
+static struct urb *__udl_get_cached_urb_locked(struct udl_device *udl)
+{
+	struct urb_node *unode;
+
+	assert_spin_locked(&udl->urbs.lock);
+
+	if (list_empty(&udl->urbs.list))
+		return NULL;
+
+	unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
+	list_del_init(&unode->entry);
+
+	return unode->urb;
+}
+
 static void udl_free_urb_list(struct udl_device *udl)
 {
+	struct drm_device *drm = &udl->drm;
 	struct urb *urb;
 
-	DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
+	drm_dbg(drm, "Waiting for completes and freeing all render URBs\n");
 
-	/* keep waiting and freeing, until we've got 'em all */
-	while (udl->urbs.count) {
-		spin_lock_irq(&udl->urbs.lock);
-		urb = udl_get_urb_locked(udl, MAX_SCHEDULE_TIMEOUT);
-		udl->urbs.count--;
-		spin_unlock_irq(&udl->urbs.lock);
-		if (WARN_ON(!urb))
-			break;
-		/* Free each separately allocated piece */
-		udl_free_bulk_urb(urb);
+	/* keep waiting until we've got 'em all */
+	scoped_guard(spinlock_irq, &udl->urbs.lock) {
+		wait_event_lock_irq(udl->urbs.sleep, !udl->urbs.in_flight, udl->urbs.lock);
+
+		urb = __udl_get_cached_urb_locked(udl);
 	}
 
-	wake_up_all(&udl->urbs.sleep);
+	while (urb) {
+		udl_free_bulk_urb(urb);
+
+		scoped_guard(spinlock_irq, &udl->urbs.lock)
+			urb = __udl_get_cached_urb_locked(udl);
+	}
 }
 
 static void udl_urb_list_release(void *data)
@@ -244,71 +257,16 @@ static void udl_urb_list_release(void *data)
 	udl_free_urb_list(udl);
 }
 
-static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
+static int udl_init_urb_list(struct udl_device *udl)
 {
 	struct drm_device *drm = &udl->drm;
-	size_t wanted_size = count * size;
-	int ret;
 
 	spin_lock_init(&udl->urbs.lock);
 	INIT_LIST_HEAD(&udl->urbs.list);
 	init_waitqueue_head(&udl->urbs.sleep);
-	udl->urbs.count = 0;
 	udl->urbs.in_flight = 0;
 
-retry:
-	while (udl->urbs.count * size < wanted_size) {
-		struct urb *urb;
-		struct urb_node *unode;
-
-		urb = udl_alloc_bulk_urb(udl, size);
-		if (IS_ERR(urb)) {
-			if (PTR_ERR(urb) == -ENOBUFS && size > PAGE_SIZE) {
-				size /= 2;
-				udl_free_urb_list(udl);
-				goto retry;
-			}
-			break;
-		}
-		unode = urb->context;
-
-		list_add_tail(&unode->entry, &udl->urbs.list);
-
-		udl->urbs.count++;
-	}
-
-	if (!udl->urbs.count)
-		return -ENOMEM;
-
-	ret = devm_add_action_or_reset(drm->dev, udl_urb_list_release, udl);
-	if (ret < 0)
-		return ret;
-
-	DRM_DEBUG("allocated %d %d byte urbs\n", udl->urbs.count, (int) size);
-
-	return udl->urbs.count;
-}
-
-static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
-{
-	struct urb_node *unode;
-
-	assert_spin_locked(&udl->urbs.lock);
-
-	/* Wait for an in-flight buffer to complete and get re-queued */
-	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
-					 !udl->urbs.count ||
-					 !list_empty(&udl->urbs.list),
-					 udl->urbs.lock, timeout))
-		return NULL;
-
-	if (!udl->urbs.count)
-		return NULL;
-
-	unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
-	list_del_init(&unode->entry);
-
-	return unode->urb;
+	return devm_add_action_or_reset(drm->dev, udl_urb_list_release, udl);
 }
 
 struct urb *udl_get_urb(struct udl_device *udl)
@@ -321,9 +279,18 @@ struct urb *udl_get_urb(struct udl_device *udl)
 			return NULL;
 		++udl->urbs.in_flight;
 
-		urb = udl_get_urb_locked(udl, HZ * 2);
-		if (!urb)
-			--udl->urbs.in_flight;
+		urb = __udl_get_cached_urb_locked(udl);
+	}
+
+	if (!urb) {
+		urb = udl_alloc_bulk_urb(udl, MAX_TRANSFER);
+		if (IS_ERR(urb)) {
+			scoped_guard(spinlock_irqsave, &udl->urbs.lock) {
+				if (udl->urbs.in_flight)
+					--udl->urbs.in_flight;
+			}
+			return NULL;
+		}
 	}
 
 	return urb;
@@ -395,8 +362,6 @@ int udl_init(struct udl_device *udl)
 	int ret = -ENOMEM;
 	struct device *dma_dev;
 
-	DRM_DEBUG("\n");
-
 	dma_dev = usb_intf_get_dma_device(to_usb_interface(dev->dev));
 	if (dma_dev) {
 		drm_dev_set_dma_dev(dev, dma_dev);
@@ -419,8 +384,8 @@ int udl_init(struct udl_device *udl)
 	if (udl_select_std_channel(udl))
 		DRM_ERROR("Selecting channel failed\n");
 
-	ret = udl_alloc_urb_list(udl, WRITES_IN_FLIGHT, MAX_TRANSFER);
-	if (ret < 0)
+	ret = udl_init_urb_list(udl);
+	if (ret)
 		return ret;
 
 	ret = udl_modeset_init(udl);
-- 
2.56.0

