Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701D5606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=x5ZJCMUd;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RhCdtxd3;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=W1OY3r4/;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=gRKPW0dv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 065B111247B;
	Thu, 19 Nov 2026 14:22:55 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B0AE11247B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:22:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A73C11FB6F;
 Thu, 19 Nov 2026 14:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098084; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuoOgyaODGGPox3wQj0jbhmmRkDrh8xIbsvPpNamMtQ=;
 b=x5ZJCMUdv7SaYF2k5u1OOQsc9R/bTbWSAUV/MT+JFXNyD0beiyWbj1FGRrt1+w+kh3m6Co
 RfFna2sN/0wVIxbCLCvyp/3Z6jVBapMafpn+LItMhIRKvRiIlG0rLReIme1rPmSM55OuTy
 1b8AWAYTEvtfWEP3nc8yH4VzlnCoVoQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098084;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuoOgyaODGGPox3wQj0jbhmmRkDrh8xIbsvPpNamMtQ=;
 b=RhCdtxd3CkdS4IlQPaeW+UGc8eSNHAFoC553oufOvFuikMYmfv2LuF9tGDa1MbGE7x9fMU
 1Oyi28y885PcL8AA==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098083; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuoOgyaODGGPox3wQj0jbhmmRkDrh8xIbsvPpNamMtQ=;
 b=W1OY3r4/lA3eBByGPAvFax2tTfc9Gh5RXfqL3Pk4ZW3k7twW+DxyoJ7m47EB7jEEKmGqnT
 4ykQVyc1J24fiGlod9wRNlqlWNwGjSmL112CzzUkUx8RfdRj+mZhGIicVRMsUcuzUgXrN+
 Ozq6oQYLZGXPxtEyf0GzFjB9G5Yby6k=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098083;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xuoOgyaODGGPox3wQj0jbhmmRkDrh8xIbsvPpNamMtQ=;
 b=gRKPW0dvGXm8nO68JMBwU866LKZXOqPz86ZTGvAX1YS9TGph/KKQdeQPSONLctPHwvISm1
 gjhytxz7UZhilbAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3F08513507;
 Thu, 19 Nov 2026 14:21:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig:T9
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 08/11] drm/udl: Track number of URBs in flight
Date: Thu, 19 Nov 2026 15:02:20 +0100
Message-ID: <20261119142114.152052-9-tzimmermann@suse.de>
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
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_COUNT_TWO(0.00)[2]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11];
 R_RATELIMIT(0.00)[to_ip_from(RLqirfcw6gnbcr9a9yhi49fhi6)];
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

Add a counter to track the number of URBs that are in flight. On
suspend, wait for all URBs to complete before suspending the device.
Replace the existing available counter.

Waiting on suspend used to be done by comparing the number of URBs
available to the overall number of allocated URBs in the cache. Track
the in-flight URBs instead to be flexible with the number of URBs
available.

Udl increases the in-flight counter when it takes an URB from the URB
cache and decreases the counter when the URB's completion handler puts
it back into the cache. There are overflow and underflow checks to
avoid getting out of sync.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_drv.h  |  2 +-
 drivers/gpu/drm/udl/udl_main.c | 58 +++++++++++++++++++---------------
 2 files changed, 34 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_drv.h b/drivers/gpu/drm/udl/udl_drv.h
index 2722625ab7a8..420166bdc4bc 100644
--- a/drivers/gpu/drm/udl/udl_drv.h
+++ b/drivers/gpu/drm/udl/udl_drv.h
@@ -44,7 +44,7 @@ struct urb_list {
 	struct list_head list;
 	spinlock_t lock;
 	wait_queue_head_t sleep;
-	int available;
+	unsigned int in_flight;
 	int count;
 };
 
diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 21b85d9c7d69..d0195bd4213d 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -9,9 +9,11 @@
  */
 
 #include <linux/device.h>
+#include <linux/limits.h>
 #include <linux/unaligned.h>
 
 #include <drm/drm.h>
+#include <drm/drm_drv.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -252,7 +254,7 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 	INIT_LIST_HEAD(&udl->urbs.list);
 	init_waitqueue_head(&udl->urbs.sleep);
 	udl->urbs.count = 0;
-	udl->urbs.available = 0;
+	udl->urbs.in_flight = 0;
 
 retry:
 	while (udl->urbs.count * size < wanted_size) {
@@ -273,7 +275,6 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 		list_add_tail(&unode->entry, &udl->urbs.list);
 
 		udl->urbs.count++;
-		udl->urbs.available++;
 	}
 
 	if (!udl->urbs.count)
@@ -298,29 +299,33 @@ static struct urb *udl_get_urb_locked(struct udl_device *udl, long timeout)
 	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
 					 !udl->urbs.count ||
 					 !list_empty(&udl->urbs.list),
-					 udl->urbs.lock, timeout)) {
-		DRM_INFO("wait for urb interrupted: available: %d\n",
-			 udl->urbs.available);
+					 udl->urbs.lock, timeout))
 		return NULL;
-	}
 
 	if (!udl->urbs.count)
 		return NULL;
 
 	unode = list_first_entry(&udl->urbs.list, struct urb_node, entry);
 	list_del_init(&unode->entry);
-	udl->urbs.available--;
 
 	return unode->urb;
 }
 
 struct urb *udl_get_urb(struct udl_device *udl)
 {
+	struct drm_device *drm = &udl->drm;
 	struct urb *urb;
 
-	spin_lock_irq(&udl->urbs.lock);
-	urb = udl_get_urb_locked(udl, HZ * 2);
-	spin_unlock_irq(&udl->urbs.lock);
+	scoped_guard(spinlock_irq, &udl->urbs.lock) {
+		if (drm_WARN_ON_ONCE(drm, udl->urbs.in_flight == UINT_MAX))
+			return NULL;
+		++udl->urbs.in_flight;
+
+		urb = udl_get_urb_locked(udl, HZ * 2);
+		if (!urb)
+			--udl->urbs.in_flight;
+	}
+
 	return urb;
 }
 
@@ -328,16 +333,18 @@ void udl_put_urb(struct urb *urb)
 {
 	struct urb_node *unode = urb->context;
 	struct udl_device *udl = unode->dev;
-	unsigned long flags;
+	struct drm_device *drm = &udl->drm;
 
 	urb->transfer_buffer_length = unode->alloc_size; /* reset to actual */
 
-	spin_lock_irqsave(&udl->urbs.lock, flags);
-	list_add_tail(&unode->entry, &udl->urbs.list);
-	udl->urbs.available++;
-	spin_unlock_irqrestore(&udl->urbs.lock, flags);
+	scoped_guard(spinlock_irqsave, &udl->urbs.lock) {
+		list_add_tail(&unode->entry, &udl->urbs.list);
+
+		if (!drm_WARN_ON_ONCE(drm, !udl->urbs.in_flight))
+			--udl->urbs.in_flight;
 
-	wake_up(&udl->urbs.sleep);
+		wake_up(&udl->urbs.sleep);
+	}
 }
 
 int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len)
@@ -369,16 +376,17 @@ int udl_submit_urb(struct udl_device *udl, struct urb *urb, size_t len)
 /* wait until all pending URBs have been processed */
 void udl_sync_pending_urbs(struct udl_device *udl)
 {
-	struct drm_device *dev = &udl->drm;
+	struct drm_device *drm = &udl->drm;
+	long ret;
 
-	spin_lock_irq(&udl->urbs.lock);
-	/* 2 seconds as a sane timeout */
-	if (!wait_event_lock_irq_timeout(udl->urbs.sleep,
-					 udl->urbs.available == udl->urbs.count,
-					 udl->urbs.lock,
-					 msecs_to_jiffies(2000)))
-		drm_err(dev, "Timeout for syncing pending URBs\n");
-	spin_unlock_irq(&udl->urbs.lock);
+	scoped_guard(spinlock_irq, &udl->urbs.lock) {
+		/* 2 seconds as a sane timeout */
+		ret = wait_event_lock_irq_timeout(udl->urbs.sleep, !udl->urbs.in_flight,
+						  udl->urbs.lock, msecs_to_jiffies(2000));
+	}
+
+	if (!ret)
+		drm_warn_ratelimited(drm, "Timeout for syncing pending URBs\n");
 }
 
 int udl_init(struct udl_device *udl)
-- 
2.56.0

