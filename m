Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0252BCDB47F
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 09:45:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 14C7710F204;
	Thu, 25 Jun 2026 09:45:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="OeY/I4Sj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V3xPErmM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="OeY/I4Sj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="V3xPErmM";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 429E010F204
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:45:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 81F6876165;
 Thu, 25 Jun 2026 09:45:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782380720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3izCRn7O2AFtnLVnkDo0eWxGSWNVQyNUlXQA0j0tLHY=;
 b=OeY/I4Sj2TuC+1J07bjY1csqUpRO/mDN06RPgMkR+cP1ozC8XhaFdj4pAPXpZLDg8gxU60
 OdXl6KUvOkIeDKxvsOHLXNeMhEfuffQIExP2+RXOnZHNs1C5oBwwqap+jgfK258zElwzc0
 TOUfAtVBLHS5oJWozr1rhe9cLuemH1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782380720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3izCRn7O2AFtnLVnkDo0eWxGSWNVQyNUlXQA0j0tLHY=;
 b=V3xPErmMvt+77k9f6GKw+bc5lIetlECCX5OGgOQPNeGwnf/gKfGojhW+mOG3ye2Ad4iygl
 czmnY2aeLvv/hdBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782380720; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3izCRn7O2AFtnLVnkDo0eWxGSWNVQyNUlXQA0j0tLHY=;
 b=OeY/I4Sj2TuC+1J07bjY1csqUpRO/mDN06RPgMkR+cP1ozC8XhaFdj4pAPXpZLDg8gxU60
 OdXl6KUvOkIeDKxvsOHLXNeMhEfuffQIExP2+RXOnZHNs1C5oBwwqap+jgfK258zElwzc0
 TOUfAtVBLHS5oJWozr1rhe9cLuemH1I=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782380720;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3izCRn7O2AFtnLVnkDo0eWxGSWNVQyNUlXQA0j0tLHY=;
 b=V3xPErmMvt+77k9f6GKw+bc5lIetlECCX5OGgOQPNeGwnf/gKfGojhW+mOG3ye2Ad4iygl
 czmnY2aeLvv/hdBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 337EA779A8;
 Thu, 25 Jun 2026 09:45:20 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id uGNWC7D4PGqaBQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 25 Jun 2026 09:45:20 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, treding@nvidia.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 neil.armstrong@linaro.org, jesszhan0024@gmail.com, rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 7/7] drm/sysfb: simpledrm: Read panel orientation from DT
 node
Date: Thu, 25 Jun 2026 11:39:39 +0200
Message-ID: <20260625094509.157581-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260625094509.157581-1-tzimmermann@suse.de>
References: <20260625094509.157581-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-6.80 / 50.00]; REPLY(-4.00)[];
 BAYES_HAM(-3.00)[100.00%]; MID_CONTAINS_FROM(1.00)[];
 NEURAL_HAM_LONG(-1.00)[-1.000]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:email,suse.de:mid];
 RCPT_COUNT_TWELVE(0.00)[12]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 FROM_HAS_DN(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,nvidia.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,linaro.org,ansari.sh];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLof9hwn8p5zsfkob18n85cjgs)];
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

A device-tree panel node can specify the panel's rotation in steps
of 90 degrees. Set the DRM connector orientation accordingly. Use
UNKNOWN for the orientation if the field is missing or invalid.

v3:
- read the orientation with drm_of_get_panel_orientation() (Thierry)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 9e0711e0095a..21ddf4502ecc 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -28,6 +28,7 @@
 #include <drm/drm_managed.h>
 #include <drm/drm_modeset_helper.h>
 #include <drm/drm_modeset_helper_vtables.h>
+#include <drm/drm_of.h>
 #include <drm/drm_print.h>
 #include <drm/drm_probe_helper.h>
 
@@ -623,6 +624,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	int width, height, stride;
 	u16 width_mm = 0, height_mm = 0;
 	struct device_node *panel_node;
+	enum drm_panel_orientation orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
 	const struct drm_format_info *format;
 	u64 size;
 	struct resource *res, *mem = NULL;
@@ -698,6 +700,12 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 			ret = simplefb_get_panel_height_mm_of(dev, panel_node);
 			if (ret > 0)
 				height_mm = ret;
+			/*
+			 * Ignore errors from parsing the panel orientation. With
+			 * the orientation initialized to UNKNOWN, the connector
+			 * helpers will do the right thing.
+			 */
+			drm_of_get_panel_orientation(panel_node, &orientation);
 			of_node_put(panel_node);
 		}
 	} else {
@@ -861,8 +869,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	if (ret)
 		return ERR_PTR(ret);
 	drm_connector_helper_add(connector, &simpledrm_connector_helper_funcs);
-	drm_connector_set_panel_orientation_with_quirk(connector,
-						       DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
+	drm_connector_set_panel_orientation_with_quirk(connector, orientation,
 						       width, height);
 
 	ret = drm_connector_attach_encoder(connector, encoder);
-- 
2.54.0

