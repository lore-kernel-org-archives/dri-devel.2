Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA75606A324
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rY2ah/rq;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=or/Pq7Tf;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=rY2ah/rq;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=or/Pq7Tf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EFA7C10E87E;
	Thu, 19 Nov 2026 14:22:06 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83BA8112473
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:21:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 4147A1F88B;
 Thu, 19 Nov 2026 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyBKRlOJd6jf1L6j7Ln+vurEggXoLgI8eZOCQosBLOs=;
 b=rY2ah/rqlVzmRhcsR6Kes/SZ55PReIgHOTlKvWC/7TNSjzLPLpK9ZCSbmoxCsWM6YENcDR
 bV+JQeAmHO4L8UAYHl7eUzgXtCORJwrUS6skZ5nLx1H8LBKssCMzaU3w2GKqJ1aDG5ZQlH
 xBxz6ZPD0rzU/QWv1enPBNqY1NQPCqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyBKRlOJd6jf1L6j7Ln+vurEggXoLgI8eZOCQosBLOs=;
 b=or/Pq7TfU4dFZ+vH8qog+9q2ZF1wodnTw0cHAfWxkg/OKkqLsTxurifP+vEY/mAG14pVwZ
 FeRsR1yLx2iRP2DQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyBKRlOJd6jf1L6j7Ln+vurEggXoLgI8eZOCQosBLOs=;
 b=rY2ah/rqlVzmRhcsR6Kes/SZ55PReIgHOTlKvWC/7TNSjzLPLpK9ZCSbmoxCsWM6YENcDR
 bV+JQeAmHO4L8UAYHl7eUzgXtCORJwrUS6skZ5nLx1H8LBKssCMzaU3w2GKqJ1aDG5ZQlH
 xBxz6ZPD0rzU/QWv1enPBNqY1NQPCqM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CyBKRlOJd6jf1L6j7Ln+vurEggXoLgI8eZOCQosBLOs=;
 b=or/Pq7TfU4dFZ+vH8qog+9q2ZF1wodnTw0cHAfWxkg/OKkqLsTxurifP+vEY/mAG14pVwZ
 FeRsR1yLx2iRP2DQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C1E51137E0;
 Thu, 19 Nov 2026 14:21:21 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig:T5
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:21 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 04/11] drm/udl: Allocate bulk URBs in helper functions
Date: Thu, 19 Nov 2026 15:02:16 +0100
Message-ID: <20261119142114.152052-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119142114.152052-1-tzimmermann@suse.de>
References: <20261119142114.152052-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-10.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; SUSPICIOUS_RECIPS(1.50)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TAGGED_RCPT(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,poorly.run,suse.com,gmail.com,linux.intel.com,kernel.org,ffwll.ch];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo];
 RCVD_TLS_ALL(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_SEVEN(0.00)[11]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Score: -10.30
X-Spam-Level: 
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

Move the code for allocating an URB into a separate helper function. Use
the helper for initializing the URB cache.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_main.c | 74 +++++++++++++++++++++-------------
 1 file changed, 47 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index 67da676f0f94..a799d7710a7b 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -163,6 +163,47 @@ static void udl_urb_completion(struct urb *urb)
 	udl_put_urb(urb);
 }
 
+static struct urb *udl_alloc_bulk_urb(struct udl_device *udl, size_t size)
+{
+	struct usb_device *udev = udl_to_usb_device(udl);
+	struct urb_node *unode;
+	struct urb *urb;
+	char *buf;
+	int ret;
+
+	urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!urb)
+		return ERR_PTR(-ENOMEM);
+
+	unode = kzalloc_obj(struct urb_node);
+	if (!unode) {
+		ret = -ENOMEM;
+		goto err_usb_free_urb;
+	}
+	unode->dev = udl;
+	unode->urb = urb;
+
+	buf = usb_alloc_coherent(udev, size, GFP_KERNEL, &urb->transfer_dma);
+	if (!buf) {
+		ret = -ENOBUFS;
+		goto err_kfree;
+	}
+	unode->alloc_size = size;
+
+	/* urb->transfer_buffer_length set to actual before submit */
+	usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, 1), buf, unode->alloc_size,
+			  udl_urb_completion, unode);
+	urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+
+	return urb;
+
+err_kfree:
+	kfree(unode);
+err_usb_free_urb:
+	usb_free_urb(urb);
+	return ERR_PTR(ret);
+}
+
 static void udl_free_urb_list(struct udl_device *udl)
 {
 	struct urb_node *unode;
@@ -191,11 +232,7 @@ static void udl_free_urb_list(struct udl_device *udl)
 
 static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 {
-	struct urb *urb;
-	struct urb_node *unode;
-	char *buf;
 	size_t wanted_size = count * size;
-	struct usb_device *udev = udl_to_usb_device(udl);
 
 	spin_lock_init(&udl->urbs.lock);
 	INIT_LIST_HEAD(&udl->urbs.list);
@@ -205,36 +242,19 @@ static int udl_alloc_urb_list(struct udl_device *udl, int count, size_t size)
 
 retry:
 	while (udl->urbs.count * size < wanted_size) {
-		unode = kzalloc_obj(struct urb_node);
-		if (!unode)
-			break;
-		unode->dev = udl;
+		struct urb *urb;
+		struct urb_node *unode;
 
-		urb = usb_alloc_urb(0, GFP_KERNEL);
-		if (!urb) {
-			kfree(unode);
-			break;
-		}
-		unode->urb = urb;
-		unode->alloc_size = size;
-
-		buf = usb_alloc_coherent(udev, unode->alloc_size, GFP_KERNEL,
-					 &urb->transfer_dma);
-		if (!buf) {
-			kfree(unode);
-			usb_free_urb(urb);
-			if (size > PAGE_SIZE) {
+		urb = udl_alloc_bulk_urb(udl, size);
+		if (IS_ERR(urb)) {
+			if (PTR_ERR(urb) == -ENOBUFS && size > PAGE_SIZE) {
 				size /= 2;
 				udl_free_urb_list(udl);
 				goto retry;
 			}
 			break;
 		}
-
-		/* urb->transfer_buffer_length set to actual before submit */
-		usb_fill_bulk_urb(urb, udev, usb_sndbulkpipe(udev, 1),
-				  buf, size, udl_urb_completion, unode);
-		urb->transfer_flags |= URB_NO_TRANSFER_DMA_MAP;
+		unode = urb->context;
 
 		list_add_tail(&unode->entry, &udl->urbs.list);
 
-- 
2.56.0

