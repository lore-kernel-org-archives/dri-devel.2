Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78CE9C44502
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:57:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D19EF10ED42;
	Tue,  7 Jul 2026 13:57:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="gwrIWvSb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JaOr5OOU";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gwrIWvSb";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JaOr5OOU";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D17610ED4C
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:57:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id F3D8075D04;
 Tue,  7 Jul 2026 13:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783432652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x/nwzHNwjl8rMP4EbLKJeAYZwQtIsLNzIZ+tShXfVU=;
 b=gwrIWvSbB0dBhtqTXpMOt16G9QZl0JFYpjc84JOc6tPoorjJQQZZTPYO9GD3txyAKtv0TB
 TaysjjMGtuaMO5SYGhCdLPZLirYYlzBikl9A2k9s5O9nZ4gOcD/TGI+rUcUQcjspsRhv4c
 9KYaEkQdgJ/mTsnt8TJi9wThmTjIM+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783432652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x/nwzHNwjl8rMP4EbLKJeAYZwQtIsLNzIZ+tShXfVU=;
 b=JaOr5OOUXCxV/nN0qgSMZvs6InUBJSt9KBSbeSquxaL/DGJu8ANB1HtteWBkeJ8Xgpu9v6
 oGMMGUffNiyDhHAA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=gwrIWvSb;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=JaOr5OOU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783432652; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x/nwzHNwjl8rMP4EbLKJeAYZwQtIsLNzIZ+tShXfVU=;
 b=gwrIWvSbB0dBhtqTXpMOt16G9QZl0JFYpjc84JOc6tPoorjJQQZZTPYO9GD3txyAKtv0TB
 TaysjjMGtuaMO5SYGhCdLPZLirYYlzBikl9A2k9s5O9nZ4gOcD/TGI+rUcUQcjspsRhv4c
 9KYaEkQdgJ/mTsnt8TJi9wThmTjIM+w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783432652;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3x/nwzHNwjl8rMP4EbLKJeAYZwQtIsLNzIZ+tShXfVU=;
 b=JaOr5OOUXCxV/nN0qgSMZvs6InUBJSt9KBSbeSquxaL/DGJu8ANB1HtteWBkeJ8Xgpu9v6
 oGMMGUffNiyDhHAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 6D9BB779AE;
 Tue,  7 Jul 2026 13:57:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YG1kGcsFTWoFSgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 07 Jul 2026 13:57:31 +0000
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
Subject: [PATCH 04/10] vga_switcheroo: Add post_switch callback to client ops
Date: Tue,  7 Jul 2026 15:38:11 +0200
Message-ID: <20260707135724.247562-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707135724.247562-1-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: F3D8075D04
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-0.998]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCPT_COUNT_TWELVE(0.00)[22];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLgosu6qu4h11rje89ht7rjgg5)];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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
index d2ce30d8b6f7..38047fe6ea60 100644
--- a/include/linux/vga_switcheroo.h
+++ b/include/linux/vga_switcheroo.h
@@ -128,21 +128,22 @@ struct vga_switcheroo_handler {
  * 	Mandatory. This should not cut power to the discrete GPU,
  * 	which is the job of the handler
  * @gpu_bound: Optional. Called before switching the outputs to the device.
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
@@ -150,6 +151,7 @@ struct vga_switcheroo_client_ops {
 	void (*reprobe)(struct pci_dev *dev);
 	bool (*can_switch)(struct pci_dev *dev);
 	void (*pre_switch)(struct pci_dev *dev);
+	void (*post_switch)(struct pci_dev *dev);
 	void (*gpu_bound)(struct pci_dev *dev, enum vga_switcheroo_client_id);
 };
 
-- 
2.54.0

