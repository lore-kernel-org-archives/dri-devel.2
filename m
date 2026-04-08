Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6F9C1073CA4
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:07:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8EA10E625;
	Wed,  8 Apr 2026 12:07:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="vduIBHpP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FW9pI2tV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="vduIBHpP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="FW9pI2tV";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1BF4310E625
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:07:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 698CF5BCE1;
 Wed,  8 Apr 2026 12:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775650047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2T3hAxOfB0PtCEPtUAD04yipW4I8woHnqNE/rahoWY=;
 b=vduIBHpPZHownr11CGFqRXJxpXwBOesR12NmEv5RonTmhNQzZaiDgyO6zEcDrzNNl21+hH
 oXdkjy+XsFlD8ygwK9HgWfxpJj9CP92Tp+L6ZDBY5A3L0VG9SBNmdgk831HRnLQx3+/gmY
 cybM0FEkuXnvneS4HcE3QwNPRn9EhOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775650047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2T3hAxOfB0PtCEPtUAD04yipW4I8woHnqNE/rahoWY=;
 b=FW9pI2tVIIq+8FK0qB4o/9TVf1MOjPMYpEo8Y+LsRFR1FKCYx02RpsdrrRGP7oMVnvv5Bp
 k3WG7ns+V2uNCODA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=vduIBHpP;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=FW9pI2tV
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775650047; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2T3hAxOfB0PtCEPtUAD04yipW4I8woHnqNE/rahoWY=;
 b=vduIBHpPZHownr11CGFqRXJxpXwBOesR12NmEv5RonTmhNQzZaiDgyO6zEcDrzNNl21+hH
 oXdkjy+XsFlD8ygwK9HgWfxpJj9CP92Tp+L6ZDBY5A3L0VG9SBNmdgk831HRnLQx3+/gmY
 cybM0FEkuXnvneS4HcE3QwNPRn9EhOY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775650047;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q2T3hAxOfB0PtCEPtUAD04yipW4I8woHnqNE/rahoWY=;
 b=FW9pI2tVIIq+8FK0qB4o/9TVf1MOjPMYpEo8Y+LsRFR1FKCYx02RpsdrrRGP7oMVnvv5Bp
 k3WG7ns+V2uNCODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 332414A0B4;
 Wed,  8 Apr 2026 12:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id aF9LC/9E1mlkUgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Apr 2026 12:07:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/5] drm/sysfb: corebootdrm: Support power management
Date: Wed,  8 Apr 2026 14:03:14 +0200
Message-ID: <20260408120722.328769-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408120722.328769-1-tzimmermann@suse.de>
References: <20260408120722.328769-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_DN_SOME(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RCPT_COUNT_SEVEN(0.00)[7];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 698CF5BCE1
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

Set PM ops for the corebootdrm driver. Suspend and resume the DRM
state on systems that support it.

Many systems lose the hardware's framebuffer settings on suspend,
hence resuming doesn't work there. Yet some systems, most notably
emulators, keep the hardware state across suspend/resume cycles.
There, DRM's suspend and resume helpers bring back the display on
resume.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/sysfb/corebootdrm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/corebootdrm.c b/drivers/gpu/drm/sysfb/corebootdrm.c
index 5dc6f3c76f7b..853da9a609df 100644
--- a/drivers/gpu/drm/sysfb/corebootdrm.c
+++ b/drivers/gpu/drm/sysfb/corebootdrm.c
@@ -4,6 +4,7 @@
 #include <linux/coreboot.h>
 #include <linux/minmax.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 
 #include <drm/clients/drm_client_setup.h>
 #include <drm/drm_atomic.h>
@@ -18,6 +19,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -286,6 +288,24 @@ static struct drm_driver corebootdrm_drm_driver = {
  * Coreboot driver
  */
 
+static int corebootdrm_pm_suspend(struct device *dev)
+{
+	struct corebootdrm_device *cdev = dev_get_drvdata(dev);
+	struct drm_device *drm = &cdev->sysfb.dev;
+
+	return drm_mode_config_helper_suspend(drm);
+}
+
+static int corebootdrm_pm_resume(struct device *dev)
+{
+	struct corebootdrm_device *cdev = dev_get_drvdata(dev);
+	struct drm_device *drm = &cdev->sysfb.dev;
+
+	return drm_mode_config_helper_resume(drm);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(corebootdrm_pm_ops, corebootdrm_pm_suspend, corebootdrm_pm_resume);
+
 static int corebootdrm_probe(struct platform_device *pdev)
 {
 	const struct lb_framebuffer *fb = dev_get_platdata(&pdev->dev);
@@ -423,6 +443,7 @@ static void corebootdrm_remove(struct platform_device *pdev)
 static struct platform_driver corebootdrm_platform_driver = {
 	.driver = {
 		.name = "coreboot-framebuffer",
+		.pm = pm_sleep_ptr(&corebootdrm_pm_ops),
 	},
 	.probe = corebootdrm_probe,
 	.remove = corebootdrm_remove,
-- 
2.53.0

