Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32B6FC44507
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:22:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72CFF10F4A4;
	Thu,  9 Jul 2026 09:22:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="vMdq6UX5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gYK/tQ6n";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vMdq6UX5";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="gYK/tQ6n";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E42F10F4A4
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 09:22:45 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id BC3F275DDE;
 Thu,  9 Jul 2026 09:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783588943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61tqgj47tXno87n5CLTjPvjoV/e/gW/vZ/ttrviqTMc=;
 b=vMdq6UX51wZMrbUXKc3lP9eGNPL+dWXc4tg4oO+X8BPR14h8e6lAXKBvtSLlgBvKxcChLr
 gTy1JbRQHy7pHHBbfY7I4tChOjhOzqIUvy9aZsuhxvFeX04KckXOmTHN38+3107fJVYOdb
 X/yB1nDXF1GxzDvRlfDAx9ayGKG173M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783588943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61tqgj47tXno87n5CLTjPvjoV/e/gW/vZ/ttrviqTMc=;
 b=gYK/tQ6nEWhgYsoJwN2wawEg4/VsMDL63ux0FFkcOd9+aqq6Jsy37LGn4tsuOZl2UEOXA0
 aq+r8N6HFi0XBiDw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vMdq6UX5;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="gYK/tQ6n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783588943; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61tqgj47tXno87n5CLTjPvjoV/e/gW/vZ/ttrviqTMc=;
 b=vMdq6UX51wZMrbUXKc3lP9eGNPL+dWXc4tg4oO+X8BPR14h8e6lAXKBvtSLlgBvKxcChLr
 gTy1JbRQHy7pHHBbfY7I4tChOjhOzqIUvy9aZsuhxvFeX04KckXOmTHN38+3107fJVYOdb
 X/yB1nDXF1GxzDvRlfDAx9ayGKG173M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783588943;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=61tqgj47tXno87n5CLTjPvjoV/e/gW/vZ/ttrviqTMc=;
 b=gYK/tQ6nEWhgYsoJwN2wawEg4/VsMDL63ux0FFkcOd9+aqq6Jsy37LGn4tsuOZl2UEOXA0
 aq+r8N6HFi0XBiDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 334AC779AA;
 Thu,  9 Jul 2026 09:22:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id ILk+C09oT2q6OQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 09 Jul 2026 09:22:23 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: lukas@wunner.de, jfalempe@redhat.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 jani.nikula@linux.intel.com, joonas.lahtinen@linux.intel.com,
 rodrigo.vivi@intel.com, tursulin@ursulin.net, lyude@redhat.com,
 dakr@kernel.org, deller@gmx.de
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 linux-fbdev@vger.kernel.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 4/7] vga_switcheroo: Add post_switch callback to client ops
Date: Thu,  9 Jul 2026 11:16:00 +0200
Message-ID: <20260709092215.168172-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709092215.168172-1-tzimmermann@suse.de>
References: <20260709092215.168172-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_TWELVE(0.00)[22]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim,suse.de:mid,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLgosu6qu4h11rje89ht7rjgg5)];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: BC3F275DDE
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

Add post_switch to struct vga_switcheroo_client_ops to inform the
switcheroo client about a completed switch of the output.

This callback is intended to replace the reprobe client op. It is a
rename of reprobe for consistency with pre_switch.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/vga/vga_switcheroo.c |  4 +++-
 include/linux/vga_switcheroo.h   | 12 +++++++-----
 2 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index bdf1e56ae891..7b0af4a8aa7d 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -746,7 +746,9 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
 	if (ret)
 		return ret;
 
-	if (new_client->ops->reprobe)
+	if (new_client->ops->post_switch)
+		new_client->ops->post_switch(new_client->pdev);
+	else if (new_client->ops->reprobe)
 		new_client->ops->reprobe(new_client->pdev);
 
 	if (vga_switcheroo_pwr_state(active) == VGA_SWITCHEROO_ON)
diff --git a/include/linux/vga_switcheroo.h b/include/linux/vga_switcheroo.h
index 4422daca9ceb..51851831d4c1 100644
--- a/include/linux/vga_switcheroo.h
+++ b/include/linux/vga_switcheroo.h
@@ -127,21 +127,22 @@ struct vga_switcheroo_handler {
  * @set_gpu_state: do the equivalent of suspend/resume for the card.
  * 	Mandatory. This should not cut power to the discrete GPU,
  * 	which is the job of the handler
- * @reprobe: poll outputs.
- * 	Optional. This gets called after waking the GPU and switching
- * 	the outputs to it
+ * @reprobe: deprecated
  * @can_switch: check if the device is in a position to switch now.
  * 	Mandatory. The client should return false if a user space process
  * 	has one of its device files open
  * @pre_switch: prepare switch
  *	Optional. This gets called before switching the outputs to the
  *	GPU. Allows drivers to prepare for the switch.
+ * @post_switch: completes switch
+ *	Optional. This gets called after waking the GPU and switching
+ *	the outputs to it. Allows drivers to poll the switched outputs.
  * @gpu_bound: notify the client id to audio client when the GPU is bound.
  *
  * Client callbacks. A client can be either a GPU or an audio device on a GPU.
  * The @set_gpu_state and @can_switch methods are mandatory, @pre_switch and
- * @reprobe may be set to NULL. For audio clients, the @pre_switch and
- * @reprobe members are bogus. OTOH, @gpu_bound is only for audio clients,
+ * @post_switch may be set to NULL. For audio clients, the @pre_switch and
+ * @post_switch members are bogus. OTOH, @gpu_bound is only for audio clients,
  * and not used for GPU clients.
  */
 struct vga_switcheroo_client_ops {
@@ -149,6 +150,7 @@ struct vga_switcheroo_client_ops {
 	void (*reprobe)(struct pci_dev *dev);
 	bool (*can_switch)(struct pci_dev *dev);
 	void (*pre_switch)(struct pci_dev *dev);
+	void (*post_switch)(struct pci_dev *dev);
 	void (*gpu_bound)(struct pci_dev *dev, enum vga_switcheroo_client_id);
 };
 
-- 
2.54.0

