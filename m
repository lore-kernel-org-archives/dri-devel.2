Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05880C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:11:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 27DD510E6BC;
	Wed,  1 Jul 2026 12:11:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="oxtWj4aj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABEkaHSS";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oxtWj4aj";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="ABEkaHSS";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D52A10E6BC
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:11:11 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id A7AD47601C;
 Wed,  1 Jul 2026 12:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782907862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6AyUyrxH7l3Y4feKVBxdHZqTM9MAU2pGTylgoARibM=;
 b=oxtWj4ajjB5iwYI+5yOSCtp/MWFyKkrPLPU9a6ii7PuA65dQP1RygG89OfoTw5432liAVE
 bzb0PtZi3FHL5VS3fcSJLg5IDO0xqSngdKz5apDXyFpLVBe5tv1eXZ5OXbo7yJEXqtOQ2Q
 Sy2l4hROfjN6HNJPDnw9Oili0NiyurI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782907862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6AyUyrxH7l3Y4feKVBxdHZqTM9MAU2pGTylgoARibM=;
 b=ABEkaHSS437pA/YAXa7pCg1uRygIRc/xqTCy2x0DKjBQaw7nHCa48CnO8RZic7yI+s6d6a
 Mb8keP3sH+viWiAw==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=oxtWj4aj;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=ABEkaHSS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782907862; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6AyUyrxH7l3Y4feKVBxdHZqTM9MAU2pGTylgoARibM=;
 b=oxtWj4ajjB5iwYI+5yOSCtp/MWFyKkrPLPU9a6ii7PuA65dQP1RygG89OfoTw5432liAVE
 bzb0PtZi3FHL5VS3fcSJLg5IDO0xqSngdKz5apDXyFpLVBe5tv1eXZ5OXbo7yJEXqtOQ2Q
 Sy2l4hROfjN6HNJPDnw9Oili0NiyurI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782907862;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O6AyUyrxH7l3Y4feKVBxdHZqTM9MAU2pGTylgoARibM=;
 b=ABEkaHSS437pA/YAXa7pCg1uRygIRc/xqTCy2x0DKjBQaw7nHCa48CnO8RZic7yI+s6d6a
 Mb8keP3sH+viWiAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2D0EC779AA;
 Wed,  1 Jul 2026 12:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id CDRMCdYDRWozOQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Jul 2026 12:11:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: treding@nvidia.com, javierm@redhat.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, dianders@chromium.org, megi@xff.cz,
 igor@reznichenko.net, mwalle@kernel.org,
 dario.binacchi@amarulasolutions.com, jagan@edgeble.ai,
 laurent.pinchart@ideasonboard.com, lujianhua000@gmail.com, agx@sigxcpu.org,
 kernel@puri.sm, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 2/3] drm/sysfb: simpledrm: Read panel orientation from DT
 node
Date: Wed,  1 Jul 2026 14:03:19 +0200
Message-ID: <20260701121055.192475-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701121055.192475-1-tzimmermann@suse.de>
References: <20260701121055.192475-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: A7AD47601C
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[21];
 FREEMAIL_TO(0.00)[nvidia.com,redhat.com,linaro.org,gmail.com,chromium.org,xff.cz,reznichenko.net,kernel.org,amarulasolutions.com,edgeble.ai,ideasonboard.com,sigxcpu.org,puri.sm,linux.intel.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DKIM_TRACE(0.00)[suse.de:+]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,nvidia.com:email];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
 R_RATELIMIT(0.00)[to_ip_from(RL579wqeubg1zrmib5eo1wpfcd)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

A device-tree panel node can specify the panel's rotation in steps
of 90 degrees. Set the DRM connector orientation accordingly. Use
UNKNOWN for the orientation if the field is missing or invalid.

v3:
- read the orientation with drm_of_get_panel_orientation() (Thierry)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Reviewed-by: Thierry Reding <treding@nvidia.com>
Reviewed-by: Maxime Ripard <mripard@kernel.org>
Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
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

