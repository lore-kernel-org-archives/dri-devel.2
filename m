Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56AABC44500
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:57:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 156A410ED2E;
	Tue,  7 Jul 2026 13:57:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="f/p74NQG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bZb6huuQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="f/p74NQG";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bZb6huuQ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0871010ED4A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:57:36 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id CE9BD741E0;
 Tue,  7 Jul 2026 13:57:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783432650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YifDnmK82gFn50n9gIPI//YYkdL4JukIrrg2Jw2g5D0=;
 b=f/p74NQGWjJ1JSiGxgZSaQ0XAuitEjQZF/i+mHFmh7OvZecl3T+YB5Y4kPEmp/A1cmc4EK
 Qhk1MZ4SSp3Au7Ra4bEGcbWO3bKRutqiXkcrcWFtRG139RbkqW8p1r1rq9UdY3BMVe0DGB
 2IKlC6svopgnTq4yGFP9I/RLF24MX9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783432650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YifDnmK82gFn50n9gIPI//YYkdL4JukIrrg2Jw2g5D0=;
 b=bZb6huuQ6ui3An99WiqPWURaeYQECZUJ7C1dkU4McVIQpyYsSugXD4k0psE5WSPsiw1TR9
 aPPX27ePEbvi8LAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783432650; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YifDnmK82gFn50n9gIPI//YYkdL4JukIrrg2Jw2g5D0=;
 b=f/p74NQGWjJ1JSiGxgZSaQ0XAuitEjQZF/i+mHFmh7OvZecl3T+YB5Y4kPEmp/A1cmc4EK
 Qhk1MZ4SSp3Au7Ra4bEGcbWO3bKRutqiXkcrcWFtRG139RbkqW8p1r1rq9UdY3BMVe0DGB
 2IKlC6svopgnTq4yGFP9I/RLF24MX9A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783432650;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YifDnmK82gFn50n9gIPI//YYkdL4JukIrrg2Jw2g5D0=;
 b=bZb6huuQ6ui3An99WiqPWURaeYQECZUJ7C1dkU4McVIQpyYsSugXD4k0psE5WSPsiw1TR9
 aPPX27ePEbvi8LAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 47BE6779AE;
 Tue,  7 Jul 2026 13:57:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6DxSEMoFTWoFSgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 07 Jul 2026 13:57:30 +0000
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
Subject: [PATCH 02/10] drm/client: Add acquire_outputs callback;
 implement for fbdev emulation
Date: Tue,  7 Jul 2026 15:38:09 +0200
Message-ID: <20260707135724.247562-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260707135724.247562-1-tzimmermann@suse.de>
References: <20260707135724.247562-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.78 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.18)[-0.920];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[22];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[wunner.de,redhat.com,amd.com,gmail.com,ffwll.ch,linux.intel.com,kernel.org,intel.com,ursulin.net,gmx.de];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com,gmx.de]
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

Add the callback acquire_outputs to drm_client_funcs to inform an internal
DRM client that vga-switcheroo is about to switch the physical outputs to
the client's device. Allows the client to prepare its internal state for
the upcoming switch.

Wire up the DRM client helpers to invoke the helper for a device's
clients.

Implement acquire_outputs for fbdev emulation. Invoke fb_switch_outputs(),
which remaps framebuffers to virtual terminals in fbcon. Currently this
is still being done by vga-switcheroo. With more DRM clients becoming
available, vga-switcheroo needs to become client agonostic.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/clients/drm_fbdev_client.c | 23 +++++++++++++++-------
 drivers/gpu/drm/drm_client_event.c         | 18 +++++++++++++++++
 include/drm/drm_client.h                   | 14 +++++++++++++
 include/drm/drm_client_event.h             |  3 +++
 4 files changed, 51 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/clients/drm_fbdev_client.c b/drivers/gpu/drm/clients/drm_fbdev_client.c
index 91d196a397cf..827f32668714 100644
--- a/drivers/gpu/drm/clients/drm_fbdev_client.c
+++ b/drivers/gpu/drm/clients/drm_fbdev_client.c
@@ -47,6 +47,14 @@ static int drm_fbdev_client_restore(struct drm_client_dev *client, bool force)
 	return 0;
 }
 
+static void drm_fbdev_client_acquire_outputs(struct drm_client_dev *client)
+{
+	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
+
+	if (fb_helper->info)
+		fb_switch_outputs(fb_helper->info);
+}
+
 static int drm_fbdev_client_hotplug(struct drm_client_dev *client)
 {
 	struct drm_fb_helper *fb_helper = drm_fb_helper_from_client(client);
@@ -95,13 +103,14 @@ static int drm_fbdev_client_resume(struct drm_client_dev *client)
 }
 
 static const struct drm_client_funcs drm_fbdev_client_funcs = {
-	.owner		= THIS_MODULE,
-	.free		= drm_fbdev_client_free,
-	.unregister	= drm_fbdev_client_unregister,
-	.restore	= drm_fbdev_client_restore,
-	.hotplug	= drm_fbdev_client_hotplug,
-	.suspend	= drm_fbdev_client_suspend,
-	.resume		= drm_fbdev_client_resume,
+	.owner		 = THIS_MODULE,
+	.free		 = drm_fbdev_client_free,
+	.unregister	 = drm_fbdev_client_unregister,
+	.restore	 = drm_fbdev_client_restore,
+	.acquire_outputs = drm_fbdev_client_acquire_outputs,
+	.hotplug	 = drm_fbdev_client_hotplug,
+	.suspend	 = drm_fbdev_client_suspend,
+	.resume		 = drm_fbdev_client_resume,
 };
 
 /**
diff --git a/drivers/gpu/drm/drm_client_event.c b/drivers/gpu/drm/drm_client_event.c
index 7b3e362f7926..f0af584da23c 100644
--- a/drivers/gpu/drm/drm_client_event.c
+++ b/drivers/gpu/drm/drm_client_event.c
@@ -123,6 +123,24 @@ void drm_client_dev_restore(struct drm_device *dev, bool force)
 	mutex_unlock(&dev->clientlist_mutex);
 }
 
+void drm_client_dev_acquire_outputs(struct drm_device *dev)
+{
+	struct drm_client_dev *client;
+
+	if (!drm_core_check_feature(dev, DRIVER_MODESET))
+		return;
+
+	mutex_lock(&dev->clientlist_mutex);
+	list_for_each_entry(client, &dev->clientlist, list) {
+		if (!client->funcs || !client->funcs->acquire_outputs)
+			continue;
+
+		client->funcs->acquire_outputs(client);
+	}
+	mutex_unlock(&dev->clientlist_mutex);
+}
+EXPORT_SYMBOL(drm_client_dev_acquire_outputs);
+
 static int drm_client_suspend(struct drm_client_dev *client)
 {
 	struct drm_device *dev = client->dev;
diff --git a/include/drm/drm_client.h b/include/drm/drm_client.h
index 49a21f3dcb36..10a0cae3e48f 100644
--- a/include/drm/drm_client.h
+++ b/include/drm/drm_client.h
@@ -66,6 +66,20 @@ struct drm_client_funcs {
 	 */
 	int (*restore)(struct drm_client_dev *client, bool force);
 
+	/**
+	 * @acquire_outputs:
+	 *
+	 * Called by vga-switcheroo. Informs the client that the outputs will
+	 * be switched to its device. When @acquire_outputs runs, the outputs
+	 * have not been switched yet. The client should only prepare the software
+	 * state. After the switch happened, the client might get a hotplug
+	 * event to update the hardware state.
+	 *
+	 * This callback exists for remapping framebuffers to virtual terminals
+	 * in fbcon.
+	 */
+	void (*acquire_outputs)(struct drm_client_dev *client);
+
 	/**
 	 * @hotplug:
 	 *
diff --git a/include/drm/drm_client_event.h b/include/drm/drm_client_event.h
index 79369c755bc9..c93f404bae1d 100644
--- a/include/drm/drm_client_event.h
+++ b/include/drm/drm_client_event.h
@@ -11,6 +11,7 @@ struct drm_device;
 void drm_client_dev_unregister(struct drm_device *dev);
 void drm_client_dev_hotplug(struct drm_device *dev);
 void drm_client_dev_restore(struct drm_device *dev, bool force);
+void drm_client_dev_acquire_outputs(struct drm_device *dev);
 void drm_client_dev_suspend(struct drm_device *dev);
 void drm_client_dev_resume(struct drm_device *dev);
 #else
@@ -20,6 +21,8 @@ static inline void drm_client_dev_hotplug(struct drm_device *dev)
 { }
 static inline void drm_client_dev_restore(struct drm_device *dev, bool force)
 { }
+static inline void drm_client_dev_acquire_outputs(struct drm_device *dev)
+{ }
 static inline void drm_client_dev_suspend(struct drm_device *dev)
 { }
 static inline void drm_client_dev_resume(struct drm_device *dev)
-- 
2.54.0

