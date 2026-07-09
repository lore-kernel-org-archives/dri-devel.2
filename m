Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B1B5C44506
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 09:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E17410E6BD;
	Thu,  9 Jul 2026 09:22:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="efeOr88G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iS0kW0MX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="efeOr88G";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="iS0kW0MX";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC64210F498
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 09:22:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 7CA27760B8;
 Thu,  9 Jul 2026 09:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783588945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THxQs3avqOGdD8iUhPjo+TCcdB4M5SSExs3S0bxU1Gg=;
 b=efeOr88GTwKxp095zlshZ5OOCF81coC1huEVp2GqSKeg7D6JGuK3n1nbHVEbFUo4c2w7wy
 LN7+gFwzxegmPsdfjC5kt+hT6bIQeG4XWr2Gx4NmibJ80/OOGU/753J1E5V6nOQGF3M4JU
 1HmcJhPI3GJboPJjCNcHIBXSkROSV+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783588945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THxQs3avqOGdD8iUhPjo+TCcdB4M5SSExs3S0bxU1Gg=;
 b=iS0kW0MXWVNsrHUI+Pfmv6d1TLMO1mr1Ekvhh39Umow2q1F50LvL9tzwaVT8z4SYrdKDnl
 vpeJTa+rcFZw4EBA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1783588945; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THxQs3avqOGdD8iUhPjo+TCcdB4M5SSExs3S0bxU1Gg=;
 b=efeOr88GTwKxp095zlshZ5OOCF81coC1huEVp2GqSKeg7D6JGuK3n1nbHVEbFUo4c2w7wy
 LN7+gFwzxegmPsdfjC5kt+hT6bIQeG4XWr2Gx4NmibJ80/OOGU/753J1E5V6nOQGF3M4JU
 1HmcJhPI3GJboPJjCNcHIBXSkROSV+Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1783588945;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=THxQs3avqOGdD8iUhPjo+TCcdB4M5SSExs3S0bxU1Gg=;
 b=iS0kW0MXWVNsrHUI+Pfmv6d1TLMO1mr1Ekvhh39Umow2q1F50LvL9tzwaVT8z4SYrdKDnl
 vpeJTa+rcFZw4EBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EAC99779AC;
 Thu,  9 Jul 2026 09:22:24 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id mCMWOFBoT2q6OQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 09 Jul 2026 09:22:24 +0000
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
Subject: [PATCH v2 7/7] vga-switcheroo: Remove unused interfaces
Date: Thu,  9 Jul 2026 11:16:03 +0200
Message-ID: <20260709092215.168172-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260709092215.168172-1-tzimmermann@suse.de>
References: <20260709092215.168172-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
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

Remove all unused interfaces that used to implement the functionality
of pre_switch and post_switch.

For pre_switch, remove vga_switcheroo_client_fb_set(). This further
allows for removing all symbols and data structures that refer to
fbdev; such as fb_info and fb_switch_outputs().

For post_switch, remove the reprobe callback from the client ops.

v2:
- move changes to fbcon and drivers into other patches

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/vga/vga_switcheroo.c | 37 ++++----------------------------
 include/linux/vga_switcheroo.h   | 12 +++++------
 2 files changed, 9 insertions(+), 40 deletions(-)

diff --git a/drivers/gpu/vga/vga_switcheroo.c b/drivers/gpu/vga/vga_switcheroo.c
index 7b0af4a8aa7d..9431d83b38a9 100644
--- a/drivers/gpu/vga/vga_switcheroo.c
+++ b/drivers/gpu/vga/vga_switcheroo.c
@@ -32,9 +32,9 @@
 
 #include <linux/apple-gmux.h>
 #include <linux/debugfs.h>
-#include <linux/fb.h>
+#include <linux/export.h>
 #include <linux/fs.h>
-#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pci.h>
 #include <linux/pm_domain.h>
 #include <linux/pm_runtime.h>
@@ -90,7 +90,6 @@
 /**
  * struct vga_switcheroo_client - registered client
  * @pdev: client pci device
- * @fb_info: framebuffer to which console is remapped on switching
  * @pwr_state: current power state if manual power control is used.
  *	For driver power control, call vga_switcheroo_pwr_state().
  * @ops: client callbacks
@@ -105,12 +104,11 @@
  * @vga_dev: pci device, indicate which GPU is bound to current audio client
  *
  * Registered client. A client can be either a GPU or an audio device on a GPU.
- * For audio clients, the @fb_info and @active members are bogus. For GPU
- * clients, the @vga_dev is bogus.
+ * For audio clients, the @active member is bogus. For GPU clients, the @vga_dev
+ * is bogus.
  */
 struct vga_switcheroo_client {
 	struct pci_dev *pdev;
-	struct fb_info *fb_info;
 	enum vga_switcheroo_state pwr_state;
 	const struct vga_switcheroo_client_ops *ops;
 	enum vga_switcheroo_client_id id;
@@ -514,27 +512,6 @@ void vga_switcheroo_unregister_client(struct pci_dev *pdev)
 }
 EXPORT_SYMBOL(vga_switcheroo_unregister_client);
 
-/**
- * vga_switcheroo_client_fb_set() - set framebuffer of a given client
- * @pdev: client pci device
- * @info: framebuffer
- *
- * Set framebuffer of a given client. The console will be remapped to this
- * on switching.
- */
-void vga_switcheroo_client_fb_set(struct pci_dev *pdev,
-				 struct fb_info *info)
-{
-	struct vga_switcheroo_client *client;
-
-	mutex_lock(&vgasr_mutex);
-	client = find_client_from_pci(&vgasr_priv.clients, pdev);
-	if (client)
-		client->fb_info = info;
-	mutex_unlock(&vgasr_mutex);
-}
-EXPORT_SYMBOL(vga_switcheroo_client_fb_set);
-
 /**
  * vga_switcheroo_lock_ddc() - temporarily switch DDC lines to a given client
  * @pdev: client pci device
@@ -735,10 +712,6 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
 
 	if (new_client->ops->pre_switch)
 		new_client->ops->pre_switch(new_client->pdev);
-#if defined(CONFIG_FB)
-	else if (new_client->fb_info)
-		fb_switch_outputs(new_client->fb_info);
-#endif
 
 	mutex_lock(&vgasr_priv.mux_hw_lock);
 	ret = vgasr_priv.handler->switchto(new_client->id);
@@ -748,8 +721,6 @@ static int vga_switchto_stage2(struct vga_switcheroo_client *new_client)
 
 	if (new_client->ops->post_switch)
 		new_client->ops->post_switch(new_client->pdev);
-	else if (new_client->ops->reprobe)
-		new_client->ops->reprobe(new_client->pdev);
 
 	if (vga_switcheroo_pwr_state(active) == VGA_SWITCHEROO_ON)
 		vga_switchoff(active);
diff --git a/include/linux/vga_switcheroo.h b/include/linux/vga_switcheroo.h
index 51851831d4c1..d7eee65664ab 100644
--- a/include/linux/vga_switcheroo.h
+++ b/include/linux/vga_switcheroo.h
@@ -31,8 +31,12 @@
 #ifndef _LINUX_VGA_SWITCHEROO_H_
 #define _LINUX_VGA_SWITCHEROO_H_
 
-#include <linux/fb.h>
+#include <linux/errno.h>
+#include <linux/types.h>
 
+struct device;
+struct dev_pm_domain;
+struct fb_info;
 struct pci_dev;
 
 /**
@@ -127,7 +131,6 @@ struct vga_switcheroo_handler {
  * @set_gpu_state: do the equivalent of suspend/resume for the card.
  * 	Mandatory. This should not cut power to the discrete GPU,
  * 	which is the job of the handler
- * @reprobe: deprecated
  * @can_switch: check if the device is in a position to switch now.
  * 	Mandatory. The client should return false if a user space process
  * 	has one of its device files open
@@ -147,7 +150,6 @@ struct vga_switcheroo_handler {
  */
 struct vga_switcheroo_client_ops {
 	void (*set_gpu_state)(struct pci_dev *dev, enum vga_switcheroo_state);
-	void (*reprobe)(struct pci_dev *dev);
 	bool (*can_switch)(struct pci_dev *dev);
 	void (*pre_switch)(struct pci_dev *dev);
 	void (*post_switch)(struct pci_dev *dev);
@@ -163,9 +165,6 @@ int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
 					 const struct vga_switcheroo_client_ops *ops,
 					 struct pci_dev *vga_dev);
 
-void vga_switcheroo_client_fb_set(struct pci_dev *dev,
-				  struct fb_info *info);
-
 int vga_switcheroo_register_handler(const struct vga_switcheroo_handler *handler,
 				    enum vga_switcheroo_handler_flags_t handler_flags);
 void vga_switcheroo_unregister_handler(void);
@@ -185,7 +184,6 @@ void vga_switcheroo_fini_domain_pm_ops(struct device *dev);
 static inline void vga_switcheroo_unregister_client(struct pci_dev *dev) {}
 static inline int vga_switcheroo_register_client(struct pci_dev *dev,
 		const struct vga_switcheroo_client_ops *ops, bool driver_power_control) { return 0; }
-static inline void vga_switcheroo_client_fb_set(struct pci_dev *dev, struct fb_info *info) {}
 static inline int vga_switcheroo_register_handler(const struct vga_switcheroo_handler *handler,
 		enum vga_switcheroo_handler_flags_t handler_flags) { return 0; }
 static inline int vga_switcheroo_register_audio_client(struct pci_dev *pdev,
-- 
2.54.0

