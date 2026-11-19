Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AD8606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 14:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l1Hpj8cF;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RrwqPf4k;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=l1Hpj8cF;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=RrwqPf4k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F83211248F;
	Thu, 19 Nov 2026 14:22:33 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6001C11247B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 14:22:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 90C701FA8E;
 Thu, 19 Nov 2026 14:21:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+MnH5pycYI7zU/FQxmcXhBOEUiyHdok2Nfqy+4/XoI=;
 b=l1Hpj8cFfb0v1/P6RT5dHHZADQ/u21ZuNDvgKYUJITXIGeuJM8Z6RC4caLWL0ec4etJF0u
 y7OP2KNOhtGzMU75Rye05AajqdewBFbIMPUZ/F0vWHzRz7P8gbyuXyjvteVcg+1avZoMl8
 /fDuHlZC6kprlb9Tmrhp1zjN3bjxMvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+MnH5pycYI7zU/FQxmcXhBOEUiyHdok2Nfqy+4/XoI=;
 b=RrwqPf4kDDXllphSUiqAzeMD41jzbVlu3K0OV8IKv1VLxGrMbikWVMiFX7zkBdhy5OOg1P
 e7JlPIC3NfDCHWAQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=l1Hpj8cF;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RrwqPf4k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795098082; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+MnH5pycYI7zU/FQxmcXhBOEUiyHdok2Nfqy+4/XoI=;
 b=l1Hpj8cFfb0v1/P6RT5dHHZADQ/u21ZuNDvgKYUJITXIGeuJM8Z6RC4caLWL0ec4etJF0u
 y7OP2KNOhtGzMU75Rye05AajqdewBFbIMPUZ/F0vWHzRz7P8gbyuXyjvteVcg+1avZoMl8
 /fDuHlZC6kprlb9Tmrhp1zjN3bjxMvM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795098082;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=v+MnH5pycYI7zU/FQxmcXhBOEUiyHdok2Nfqy+4/XoI=;
 b=RrwqPf4kDDXllphSUiqAzeMD41jzbVlu3K0OV8IKv1VLxGrMbikWVMiFX7zkBdhy5OOg1P
 e7JlPIC3NfDCHWAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25A1213646;
 Thu, 19 Nov 2026 14:21:22 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id RynyAeAF/2rJfgAAD6G6ig:T6
 (envelope-from <tzimmermann@suse.de>); Thu, 19 Nov 2026 14:21:22 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: airlied@redhat.com, sean@poorly.run, tiwai@suse.com,
 patrik.r.jakobsson@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 05/11] drm/udl: Free bulk URBs in helper functions
Date: Thu, 19 Nov 2026 15:02:17 +0100
Message-ID: <20261119142114.152052-6-tzimmermann@suse.de>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261119142114.152052-1-tzimmermann@suse.de>
References: <20261119142114.152052-1-tzimmermann@suse.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90C701FA8E
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
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

Move the code for freeing an URB into a separate helper function. Use
the helper for cleaning up the URB cache.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/udl/udl_main.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/udl/udl_main.c b/drivers/gpu/drm/udl/udl_main.c
index a799d7710a7b..1c3960974a10 100644
--- a/drivers/gpu/drm/udl/udl_main.c
+++ b/drivers/gpu/drm/udl/udl_main.c
@@ -147,6 +147,15 @@ int udl_select_std_channel(struct udl_device *udl)
 	return ret < 0 ? ret : 0;
 }
 
+static void udl_free_bulk_urb(struct urb *urb)
+{
+	struct urb_node *unode = urb->context;
+
+	usb_free_coherent(urb->dev, unode->alloc_size, urb->transfer_buffer, urb->transfer_dma);
+	kfree(unode);
+	usb_free_urb(urb);
+}
+
 static void udl_urb_completion(struct urb *urb)
 {
 	/* sync/async unlink faults aren't errors */
@@ -206,7 +215,6 @@ static struct urb *udl_alloc_bulk_urb(struct udl_device *udl, size_t size)
 
 static void udl_free_urb_list(struct udl_device *udl)
 {
-	struct urb_node *unode;
 	struct urb *urb;
 
 	DRM_DEBUG("Waiting for completes and freeing all render urbs\n");
@@ -219,12 +227,8 @@ static void udl_free_urb_list(struct udl_device *udl)
 		spin_unlock_irq(&udl->urbs.lock);
 		if (WARN_ON(!urb))
 			break;
-		unode = urb->context;
 		/* Free each separately allocated piece */
-		usb_free_coherent(urb->dev, unode->alloc_size,
-				  urb->transfer_buffer, urb->transfer_dma);
-		usb_free_urb(urb);
-		kfree(unode);
+		udl_free_bulk_urb(urb);
 	}
 
 	wake_up_all(&udl->urbs.sleep);
-- 
2.56.0

