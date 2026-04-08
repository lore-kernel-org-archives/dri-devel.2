Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DA091073CA4
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 12:07:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8A7F910E62A;
	Wed,  8 Apr 2026 12:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zuJi4leh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tLO7h9hs";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zuJi4leh";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="tLO7h9hs";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8B0310E62A
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Apr 2026 12:07:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 19BB84E9AC;
 Wed,  8 Apr 2026 12:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775650048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp9FRFK9J6DvII7efbYNbugHjPIM2JaHFRqvIJnbTSU=;
 b=zuJi4lehkzXHidID2yXt7ucknlJZj4ad5/8Qa4yjG9u99MWBgKuvfVdKqCl8Suudfu6sSU
 gWrmhsWyzQx94JPH4Ft0SuuQg4e1iYPpYaUvk2WWKfvDf3O6kZUVPcjYLvz8l82XZjmtCX
 qyzmsRjNEQZOO3i8UIxve4EjZOKKrs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775650048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp9FRFK9J6DvII7efbYNbugHjPIM2JaHFRqvIJnbTSU=;
 b=tLO7h9hsbPkOtSI0AmSaN+NZdOSKN8fu9qhj41yzHRP2i1Z8yS3RTM4eEHl+8L4dPOhanG
 P5uV0c/3Hgxi1qDw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1775650048; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp9FRFK9J6DvII7efbYNbugHjPIM2JaHFRqvIJnbTSU=;
 b=zuJi4lehkzXHidID2yXt7ucknlJZj4ad5/8Qa4yjG9u99MWBgKuvfVdKqCl8Suudfu6sSU
 gWrmhsWyzQx94JPH4Ft0SuuQg4e1iYPpYaUvk2WWKfvDf3O6kZUVPcjYLvz8l82XZjmtCX
 qyzmsRjNEQZOO3i8UIxve4EjZOKKrs4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1775650048;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Hp9FRFK9J6DvII7efbYNbugHjPIM2JaHFRqvIJnbTSU=;
 b=tLO7h9hsbPkOtSI0AmSaN+NZdOSKN8fu9qhj41yzHRP2i1Z8yS3RTM4eEHl+8L4dPOhanG
 P5uV0c/3Hgxi1qDw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id DC1D04A0B3;
 Wed,  8 Apr 2026 12:07:27 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id UK2WNP9E1mlkUgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 08 Apr 2026 12:07:27 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/5] drm/sysfb: simpledrm: Support power management
Date: Wed,  8 Apr 2026 14:03:17 +0200
Message-ID: <20260408120722.328769-5-tzimmermann@suse.de>
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

Set PM ops for the simpledrm driver. Suspend and resume the DRM
state on systems that support it.

Many systems lose the hardware's framebuffer settings on suspend,
hence resuming doesn't work there. Yet some systems, most notably
emulators, keep the hardware state across suspend/resume cycles.
There, DRM's suspend and resume helpers bring back the display on
resume.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 7a95d2dacd9d..fc168920f2c6 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -8,6 +8,7 @@
 #include <linux/of_reserved_mem.h>
 #include <linux/platform_data/simplefb.h>
 #include <linux/platform_device.h>
+#include <linux/pm.h>
 #include <linux/pm_domain.h>
 #include <linux/regulator/consumer.h>
 
@@ -24,6 +25,7 @@
 #include <drm/drm_gem_framebuffer_helper.h>
 #include <drm/drm_gem_shmem_helper.h>
 #include <drm/drm_managed.h>
+#include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
@@ -834,6 +836,24 @@ static struct drm_driver simpledrm_driver = {
  * Platform driver
  */
 
+static int simpledrm_pm_suspend(struct device *dev)
+{
+	struct simpledrm_device *sdev = dev_get_drvdata(dev);
+	struct drm_device *drm = &sdev->sysfb.dev;
+
+	return drm_mode_config_helper_suspend(drm);
+}
+
+static int simpledrm_pm_resume(struct device *dev)
+{
+	struct simpledrm_device *sdev = dev_get_drvdata(dev);
+	struct drm_device *drm = &sdev->sysfb.dev;
+
+	return drm_mode_config_helper_resume(drm);
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(simpledrm_pm_ops, simpledrm_pm_suspend, simpledrm_pm_resume);
+
 static int simpledrm_probe(struct platform_device *pdev)
 {
 	struct simpledrm_device *sdev;
@@ -874,6 +894,7 @@ static struct platform_driver simpledrm_platform_driver = {
 	.driver = {
 		.name = "simple-framebuffer", /* connect to sysfb */
 		.of_match_table = simpledrm_of_match_table,
+		.pm = pm_sleep_ptr(&simpledrm_pm_ops),
 	},
 	.probe = simpledrm_probe,
 	.remove = simpledrm_remove,
-- 
2.53.0

