Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164BACD98F6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:58:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5EA10F607;
	Fri, 19 Jun 2026 13:58:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="MIAIiJE4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qqt/T56s";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MIAIiJE4";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="Qqt/T56s";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C5F310F607
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:58:53 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id E13D66DA47;
 Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9qv+xb1q6svfoY5gNhzU7plWDsaV+m9gcc6UwdED8w=;
 b=MIAIiJE4U3tYmE3zdLt+JPAj5vkjkSXZOlqvsmelQMbIuF1fWtrsDl7obedUPVOifSEa8L
 rCgWljevmugMKiAgbxvIAhaDSMDwoCGwthCexWBh3qu8QcVfcmuGWXNW95uaQ2Lqbf50GX
 A56RpBT0ouZTeTHVhaAKzYwOvL/9V1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781877531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9qv+xb1q6svfoY5gNhzU7plWDsaV+m9gcc6UwdED8w=;
 b=Qqt/T56sbepgO/LDGn3s+J7iLmaiG6EZenmNIWfy8S2I7QPZ2uztvS35XQjxYSHpHoPc9d
 uvuB6M4V0HoR4rBw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=MIAIiJE4;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="Qqt/T56s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9qv+xb1q6svfoY5gNhzU7plWDsaV+m9gcc6UwdED8w=;
 b=MIAIiJE4U3tYmE3zdLt+JPAj5vkjkSXZOlqvsmelQMbIuF1fWtrsDl7obedUPVOifSEa8L
 rCgWljevmugMKiAgbxvIAhaDSMDwoCGwthCexWBh3qu8QcVfcmuGWXNW95uaQ2Lqbf50GX
 A56RpBT0ouZTeTHVhaAKzYwOvL/9V1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781877531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g9qv+xb1q6svfoY5gNhzU7plWDsaV+m9gcc6UwdED8w=;
 b=Qqt/T56sbepgO/LDGn3s+J7iLmaiG6EZenmNIWfy8S2I7QPZ2uztvS35XQjxYSHpHoPc9d
 uvuB6M4V0HoR4rBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A489C779AB;
 Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cEjzJhtLNWpvfwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 19 Jun 2026 13:58:51 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 3/3] drm/sysfb: simpledrm: Read panel orientation from DT node
Date: Fri, 19 Jun 2026 15:56:36 +0200
Message-ID: <20260619135847.309664-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619135847.309664-1-tzimmermann@suse.de>
References: <20260619135847.309664-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:email,suse.de:dkim,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 RCPT_COUNT_SEVEN(0.00)[9];
 DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: E13D66DA47
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

A DeviceTree panel node can specify the panel's rotation in steps
of 90 degrees. Set the DRM connector orientation from the field.
Do nothing if the field is missing or invalid.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 32 +++++++++++++++++++++++++++++--
 1 file changed, 30 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 5c1db0785d92..a84d4284b814 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -229,6 +229,33 @@ simplefb_get_panel_height_mm_of(struct drm_device *dev, struct device_node *of_p
 	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
 }
 
+static enum drm_panel_orientation
+simplefb_get_panel_orientation_of(struct drm_device *dev, struct device_node *of_panel_node)
+{
+	int ret;
+	u32 rotation;
+
+	ret = of_property_read_u32(of_panel_node, "rotation", &rotation);
+	if (ret) {
+		drm_dbg(dev, "simplefb: cannot parse panel rotation: error %d\n", ret);
+		return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+	}
+
+	switch (rotation) {
+	case 0:
+		return DRM_MODE_PANEL_ORIENTATION_NORMAL;
+	case 90:
+		return DRM_MODE_PANEL_ORIENTATION_RIGHT_UP;
+	case 180:
+		return DRM_MODE_PANEL_ORIENTATION_BOTTOM_UP;
+	case 270:
+		return DRM_MODE_PANEL_ORIENTATION_LEFT_UP;
+	default:
+		drm_dbg(dev, "simplefb: cannot parse panel rotation: value %u\n", rotation);
+		return DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
+	}
+}
+
 /*
  * Simple Framebuffer device
  */
@@ -632,6 +659,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	int width, height, stride;
 	u16 width_mm = 0, height_mm = 0;
 	struct device_node *panel_node;
+	enum drm_panel_orientation orientation = DRM_MODE_PANEL_ORIENTATION_UNKNOWN;
 	const struct drm_format_info *format;
 	struct resource *res, *mem = NULL;
 	struct drm_plane *primary_plane;
@@ -696,6 +724,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 		if (panel_node) {
 			width_mm = simplefb_get_panel_width_mm_of(dev, panel_node);
 			height_mm = simplefb_get_panel_height_mm_of(dev, panel_node);
+			orientation = simplefb_get_panel_orientation_of(dev, panel_node);
 			of_node_put(panel_node);
 		}
 	} else {
@@ -831,8 +860,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
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

