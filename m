Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF245C61DC2
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 14:09:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D5BC10F073;
	Thu, 27 Aug 2026 14:09:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="TY41AP2W";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="+mLxFLnr";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="RC0rTaNW";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QbEbq5TR";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BCBB110F074
 for <dri-devel@lists.freedesktop.org>; Thu, 27 Aug 2026 14:09:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 532641F823;
 Thu, 27 Aug 2026 14:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787839657; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNDPN8NI1JaW8Mx2aTEM89mZKoEqJ+MN0jG4L9FVoiw=;
 b=TY41AP2WFQLiCH5c3xI3QDPrKVcQ6UrvWXlSGwM7OZi5DhknFxfc5ZmPek/S03Wg/zhvnX
 gOJed8Pb29ayahmpLwBSuaVEeRAGkrPIi3NFw2v3wH77I6oevNd0/xWunihZjK0K4QGzFY
 xTThj3lvyrjRptebzwR666sFmloJmRQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787839657;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNDPN8NI1JaW8Mx2aTEM89mZKoEqJ+MN0jG4L9FVoiw=;
 b=+mLxFLnrM8zmUTKfNykhrKdRSe5x5gz8pJNK0CyTZDgZDQ67QcRaqv9dUNwEayu7FeinTN
 D/KlfGE0aHZa90CQ==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=RC0rTaNW;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QbEbq5TR
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1787839653; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNDPN8NI1JaW8Mx2aTEM89mZKoEqJ+MN0jG4L9FVoiw=;
 b=RC0rTaNWezcjcHQ6GUv+JUH/Wbsp3c71d2b/wzCAWE3La+vUmnYA260vBci7A/E17asJV6
 WIxoKjWonSuLQ1e0hGZmsMPHCI73jbAqVzyDdeemPrYRsRRkU/PyuDb/1Dm2O15a/E47zL
 JBJWxtEIbr+kJlhxt/lb7R6qKPDCq78=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1787839653;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UNDPN8NI1JaW8Mx2aTEM89mZKoEqJ+MN0jG4L9FVoiw=;
 b=QbEbq5TRW2rOmFntjoj0gFjey0ZZcbnM5tCbQHLkz8pgrGMbx9HWHKmrs0vT8L/NUF9y/P
 VFo7m3RHAEN8zEBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id EDFF813533;
 Thu, 27 Aug 2026 14:07:32 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id gH7DOKREkGp0FQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 27 Aug 2026 14:07:32 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, ardb@kernel.org, ilias.apalodimas@linaro.org,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/3] drm/sysfb: Use preferred panel size for panel orientation
 quirks
Date: Thu, 27 Aug 2026 16:01:38 +0200
Message-ID: <20260827140726.420734-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260827140726.420734-1-tzimmermann@suse.de>
References: <20260827140726.420734-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 532641F823
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[12];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_TO(0.00)[redhat.com,kernel.org,linaro.org,linux.intel.com,ffwll.ch,gmail.com];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.de:dkim,suse.de:email,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

Sysfb drivers currently use the given display mode for looking up the
panel orientation. But the look-up table stores the native geometry of
the panels, so the lookup fails if the current mode sizes differs.

Get the panel's native geometry with drm_edid_get_preferred_size() from
the EDID and use it for looking up the panel orientation.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/sysfb/efidrm.c  | 17 ++++++++++++++++-
 drivers/gpu/drm/sysfb/ofdrm.c   | 16 +++++++++++++++-
 drivers/gpu/drm/sysfb/vesadrm.c | 17 ++++++++++++++++-
 3 files changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 3f9cd5d03efb..7a7d12003304 100644
--- a/drivers/gpu/drm/sysfb/efidrm.c
+++ b/drivers/gpu/drm/sysfb/efidrm.c
@@ -152,6 +152,7 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
+	unsigned int panel_width, panel_height;
 	s64 vsize;
 	u64 mem_flags;
 	struct resource resbuf;
@@ -217,6 +218,20 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	if (drm_edid_header_is_valid(dpy->edid.dummy) == 8)
 		sysfb->edid = dpy->edid.dummy;
 #endif
+
+	panel_width = width;
+	panel_height = height;
+
+	if (sysfb->edid) {
+		const struct drm_edid *drm_edid;
+
+		drm_edid = drm_edid_alloc(sysfb->edid, EDID_LENGTH);
+		if (drm_edid) {
+			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);
+			drm_edid_free(drm_edid);
+		}
+	}
+
 	sysfb->fb_mode = drm_sysfb_mode(width, height, 0, 0);
 	sysfb->fb_format = format;
 	sysfb->fb_pitch = stride;
@@ -340,7 +355,7 @@ static struct efidrm_device *efidrm_device_create(struct drm_driver *drv,
 	drm_connector_helper_add(connector, &efidrm_connector_helper_funcs);
 	drm_connector_set_panel_orientation_with_quirk(connector,
 						       DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
-						       width, height);
+						       panel_width, panel_height);
 	if (sysfb->edid)
 		drm_connector_attach_edid_property(connector);
 
diff --git a/drivers/gpu/drm/sysfb/ofdrm.c b/drivers/gpu/drm/sysfb/ofdrm.c
index 819aed466727..6cf2440d7d9e 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -827,6 +827,7 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 	enum ofdrm_model model;
 	bool big_endian;
 	int width, height, depth, linebytes;
+	unsigned int panel_width, panel_height;
 	const struct drm_format_info *format;
 	u64 address;
 	const u8 *edid;
@@ -994,6 +995,19 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 		sysfb->fb_gamma_lut_size = OFDRM_GAMMA_LUT_SIZE;
 	sysfb->edid = edid;
 
+	panel_width = width;
+	panel_height = height;
+
+	if (sysfb->edid) {
+		const struct drm_edid *drm_edid;
+
+		drm_edid = drm_edid_alloc(sysfb->edid, EDID_LENGTH);
+		if (drm_edid) {
+			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);
+			drm_edid_free(drm_edid);
+		}
+	}
+
 	drm_dbg(dev, "display mode={" DRM_MODE_FMT "}\n", DRM_MODE_ARG(&sysfb->fb_mode));
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, linebytes=%d byte\n",
 		&format->format, width, height, linebytes);
@@ -1065,7 +1079,7 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 	drm_connector_helper_add(connector, &ofdrm_connector_helper_funcs);
 	drm_connector_set_panel_orientation_with_quirk(connector,
 						       DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
-						       width, height);
+						       panel_width, panel_height);
 	if (edid)
 		drm_connector_attach_edid_property(connector);
 
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 6a67b2d2e451..8c52bbac6d2f 100644
--- a/drivers/gpu/drm/sysfb/vesadrm.c
+++ b/drivers/gpu/drm/sysfb/vesadrm.c
@@ -402,6 +402,7 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	const struct screen_info *si;
 	const struct drm_format_info *format;
 	int width, height, stride;
+	unsigned int panel_width, panel_height;
 	s64 vsize;
 	struct resource resbuf;
 	struct resource *res;
@@ -484,6 +485,20 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	if (drm_edid_header_is_valid(dpy->edid.dummy) == 8)
 		sysfb->edid = dpy->edid.dummy;
 #endif
+
+	panel_width = width;
+	panel_height = height;
+
+	if (sysfb->edid) {
+		const struct drm_edid *drm_edid;
+
+		drm_edid = drm_edid_alloc(sysfb->edid, EDID_LENGTH);
+		if (drm_edid) {
+			drm_edid_get_preferred_size(drm_edid, &panel_width, &panel_height);
+			drm_edid_free(drm_edid);
+		}
+	}
+
 	sysfb->fb_mode = drm_sysfb_mode(width, height, 0, 0);
 	sysfb->fb_format = format;
 	sysfb->fb_pitch = stride;
@@ -585,7 +600,7 @@ static struct vesadrm_device *vesadrm_device_create(struct drm_driver *drv,
 	drm_connector_helper_add(connector, &vesadrm_connector_helper_funcs);
 	drm_connector_set_panel_orientation_with_quirk(connector,
 						       DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
-						       width, height);
+						       panel_width, panel_height);
 	if (sysfb->edid)
 		drm_connector_attach_edid_property(connector);
 
-- 
2.55.0

