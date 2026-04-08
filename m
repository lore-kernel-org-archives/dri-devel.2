Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30F801073CA4
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:07:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9421710E629;
	Wed,  8 Apr 2026 12:07:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="wnmezMh3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="phjJJUkG";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="wnmezMh3";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="phjJJUkG";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C81FC10E625
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:07:33 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D6E574E9AB;
 Wed,  8 Apr 2026 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775650047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmWCFGUXK4Lw1cuEBJ7XjzirZa4cTbKICQOs/wn/XpM=;
 b=wnmezMh3JA5nXdY/5pAnWu55C5JGy3AN6fQ1NUGFHgGL3LuX0yEewWx9S4JvUibktMbvCz
 JVAQNMpuWw+oTRekxlg5loe80OuN3kPBA0sVwNU9cDuVWi1fPUWgNHefbjOdJS+4R5brDU
 idyAZ8JgLiJkWRfGAeHJ+4LdYpCnL2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775650047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmWCFGUXK4Lw1cuEBJ7XjzirZa4cTbKICQOs/wn/XpM=;
 b=phjJJUkG8c64hwfrxuXokFdnYo1kyXuCl76aZjn4ebuN7GdRciphPaz2zbMwY2wEddr3iy
 3NUAPumQUNG5sZAQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775650047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmWCFGUXK4Lw1cuEBJ7XjzirZa4cTbKICQOs/wn/XpM=;
 b=wnmezMh3JA5nXdY/5pAnWu55C5JGy3AN6fQ1NUGFHgGL3LuX0yEewWx9S4JvUibktMbvCz
 JVAQNMpuWw+oTRekxlg5loe80OuN3kPBA0sVwNU9cDuVWi1fPUWgNHefbjOdJS+4R5brDU
 idyAZ8JgLiJkWRfGAeHJ+4LdYpCnL2g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775650047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EmWCFGUXK4Lw1cuEBJ7XjzirZa4cTbKICQOs/wn/XpM=;
 b=phjJJUkG8c64hwfrxuXokFdnYo1kyXuCl76aZjn4ebuN7GdRciphPaz2zbMwY2wEddr3iy
 3NUAPumQUNG5sZAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A37E04A0B4;
 Wed,  8 Apr 2026 12:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UGK4Jv9E1mlkUgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Apr 2026 12:07:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/5] drm/sysfb: ofdrm: Support power management
Date: Wed,  8 Apr 2026 14:03:16 +0200
Message-ID: <20260408120722.328769-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408120722.328769-1-tzimmermann@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.79 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.19)[-0.931];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[7];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Set PM ops for the ofdrm driver. Suspend and resume the DRM state
on systems that support it.

Many systems lose the hardware's framebuffer settings on suspend,
hence resuming doesn't work there. Yet some systems, most notably
emulators, keep the hardware state across suspend/resume cycles.
There, DRM's suspend and resume helpers bring back the display on
resume.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/sysfb/ofdrm.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
index d38ba70f4e0d..8822ebcbc081 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -4,6 +4,7 @@
 #include <linux/of_address.h>
 #include <linux/pci.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic.h>
@@ -20,6 +21,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -1095,6 +1097,22 @@ static struct drm_driver ofdrm_driver = {
  * Platform driver
  */
 
+static int ofdrm_pm_suspend(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_suspend(drm);
+}
+
+static int ofdrm_pm_resume(struct device *dev)
+{
+	struct drm_device *drm = dev_get_drvdata(dev);
+
+	return drm_mode_config_helper_resume(drm);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(ofdrm_pm_ops, ofdrm_pm_suspend, ofdrm_pm_resume);
+
 static int ofdrm_probe(struct platform_device *pdev)
 {
 	struct ofdrm_device *odev;
@@ -1134,6 +1152,7 @@ static struct platform_driver ofdrm_platform_driver = {
 	.driver = {
 		.name = "of-display",
 		.of_match_table = ofdrm_of_match_display,
+		.pm = pm_sleep_ptr(&ofdrm_pm_ops),
 	},
 	.probe = ofdrm_probe,
 	.remove = ofdrm_remove,
-- 
2.53.0

