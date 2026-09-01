Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D0E8C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 08:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C9810EBE7;
	Tue,  1 Sep 2026 08:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="JBiGzqL+";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GwZRowcw";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="p0QHMkCr";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="PdzZtdvv";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0D7110EBE7
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 08:21:28 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0F837226B7;
 Tue,  1 Sep 2026 08:21:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788250870; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6J01y5x3+VPVyGqbdQoKAHZf/LgSXoTgJdgTtvktNs=;
 b=JBiGzqL+pRfxpz/HQRXtwRCiKjI8M7lXDSPgU4irox98rDrjZKtdHIs8+dP2G315REnRko
 MvKrfr6iST1WDEQ7ZGUi1KwK4ywpSEZAckqMB5Z9K8fnmgsraHe6rdFIOYjiifVPvEHop/
 JB9jOoKRR8MT2IudNGCeMXoPHmhAI2E=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788250870;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6J01y5x3+VPVyGqbdQoKAHZf/LgSXoTgJdgTtvktNs=;
 b=GwZRowcw7Yd7MMnDOvVAzVTZfsSbTMhSjkgQElGmEYXs2UNkjXKhXrmTpwp/K02CssBF8b
 V/JFF9IMUwO6wWCQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788250866; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6J01y5x3+VPVyGqbdQoKAHZf/LgSXoTgJdgTtvktNs=;
 b=p0QHMkCrhHv3jXRD00v+69XM9EgHs6tsvvHIpdZASP90U/2Tevz21VkzdH6FCov3s/pYJR
 QkjL2x9gQDZMtGb3TiDVHrAyYULg7xQBPthgoxYhJLCbymtFHQ9yQ0/eIzTqojBL51GTl+
 njIAq1mRqMeEuzigC5mjbizkbcqNbD0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788250866;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i6J01y5x3+VPVyGqbdQoKAHZf/LgSXoTgJdgTtvktNs=;
 b=PdzZtdvvcL14GDz6k3CuOLgB1ayw1yfEyMu3qbyuVlE4AXvRrirjXlyp1zWpSQ6EVXbBs8
 yhE+nsvUJgqgOBDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 964CA136C7;
 Tue,  1 Sep 2026 08:21:05 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id AI46I/GKlmqFfAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 01 Sep 2026 08:21:05 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, ardb@kernel.org, ilias.apalodimas@linaro.org,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 3/3] drm/sysfb: Use preferred panel size for panel
 orientation quirks
Date: Tue,  1 Sep 2026 10:17:37 +0200
Message-ID: <20260901082057.37617-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260901082057.37617-1-tzimmermann@suse.de>
References: <20260901082057.37617-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain];
 FREEMAIL_TO(0.00)[redhat.com,kernel.org,linaro.org,linux.intel.com,ffwll.ch,gmail.com];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

Get the panel's native geometry with drm_edid_detect_panel_size() from
the EDID and use it for looking up the panel orientation.

v2:
- ofdrm: validate EDID header before using it (Sashiko)

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/gpu/drm/sysfb/efidrm.c  | 17 ++++++++++++++++-
 drivers/gpu/drm/sysfb/ofdrm.c   | 18 ++++++++++++++++--
 drivers/gpu/drm/sysfb/vesadrm.c | 17 ++++++++++++++++-
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/efidrm.c b/drivers/gpu/drm/sysfb/efidrm.c
index 3f9cd5d03efb..8b19f437308e 100644
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
+			drm_edid_detect_panel_size(drm_edid, &panel_width, &panel_height);
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
index 9d60db45139c..c41255569854 100644
--- a/drivers/gpu/drm/sysfb/ofdrm.c
+++ b/drivers/gpu/drm/sysfb/ofdrm.c
@@ -229,7 +229,7 @@ static const u8 *display_get_edid_of(struct drm_device *dev, struct device_node
 {
 	int ret = of_property_read_u8_array(of_node, "EDID", buf, EDID_LENGTH);
 
-	if (ret)
+	if (ret || drm_edid_header_is_valid(buf) != 8)
 		return NULL;
 	return buf;
 }
@@ -828,6 +828,7 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 	enum ofdrm_model model;
 	bool big_endian;
 	int width, height, depth, linebytes;
+	unsigned int panel_width, panel_height;
 	const struct drm_format_info *format;
 	u64 address;
 	const u8 *edid;
@@ -998,6 +999,19 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
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
+			drm_edid_detect_panel_size(drm_edid, &panel_width, &panel_height);
+			drm_edid_free(drm_edid);
+		}
+	}
+
 	drm_dbg(dev, "display mode={" DRM_MODE_FMT "}\n", DRM_MODE_ARG(&sysfb->fb_mode));
 	drm_dbg(dev, "framebuffer format=%p4cc, size=%dx%d, linebytes=%d byte\n",
 		&format->format, width, height, linebytes);
@@ -1069,7 +1083,7 @@ static struct ofdrm_device *ofdrm_device_create(struct drm_driver *drv,
 	drm_connector_helper_add(connector, &ofdrm_connector_helper_funcs);
 	drm_connector_set_panel_orientation_with_quirk(connector,
 						       DRM_MODE_PANEL_ORIENTATION_UNKNOWN,
-						       width, height);
+						       panel_width, panel_height);
 	if (edid)
 		drm_connector_attach_edid_property(connector);
 
diff --git a/drivers/gpu/drm/sysfb/vesadrm.c b/drivers/gpu/drm/sysfb/vesadrm.c
index 6a67b2d2e451..f6358a0a68bd 100644
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
+			drm_edid_detect_panel_size(drm_edid, &panel_width, &panel_height);
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

