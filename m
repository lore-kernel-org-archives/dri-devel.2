Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE9DC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:30:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2AB010E7A8;
	Mon, 31 Aug 2026 09:30:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zkk+Yti6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="TG5RBe0F";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D6F7910E7A8
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:30:32 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 48366226D7;
 Mon, 31 Aug 2026 09:30:27 +0000 (UTC)
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788168627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7hn4dIw0/3j+RusDzouP+r/aAB2SLVKdEHFAOwHeuQ=;
 b=zkk+Yti6iVVeD/5UkgoBsufBNdE8sLIUx3t1g4X1p8P9AxUx+EpC8yhs1o2gmbeNAjw0LS
 TK0b38o5dOKl6W3vlmv6wbRrfl7icQUIMTYjatE9shYjRWfeqPrhbRasuMEvt9M9oul30D
 t+nAxGwr39J5PdVMTDFVpHGPZmSIV/s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788168627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=J7hn4dIw0/3j+RusDzouP+r/aAB2SLVKdEHFAOwHeuQ=;
 b=TG5RBe0FfEsK8TTrNVBf+7/eZ7Xj+5+8W9p2bFVxCYSBq6uFWG6rzdZdd8wxeaTDdAcf+X
 thMXUqiGD5Wo0rBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A9910136A5;
 Mon, 31 Aug 2026 09:30:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cO77J7JJlWoFUwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 31 Aug 2026 09:30:26 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, ardb@kernel.org, ilias.apalodimas@linaro.org,
 jani.nikula@linux.intel.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-efi@vger.kernel.org,
 sashiko-reviews@lists.linux.dev, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 2/3] drm/edid: Add drm_edid_get_preferred_size()
Date: Mon, 31 Aug 2026 11:27:49 +0200
Message-ID: <20260831093020.494701-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831093020.494701-1-tzimmermann@suse.de>
References: <20260831093020.494701-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 48366226D7
X-Rspamd-Pre-Result: action=no action; module=replies;
 Message is reply to one we originated
X-Spamd-Result: default: False [-4.00 / 50.00];
	REPLY(-4.00)[]
X-Rspamd-Action: no action
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

Add drm_edid_get_preferred_size() to extract the panel's preferred
display resolution from a given EDID. Required for DRM's panel
orientation quirks.

v2:
- handle EDID without pixel timing descriptor (Sashiko)
- fix checks for width and height pointers

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Acked-by: Ard Biesheuvel <ardb@kernel.org>
---
 drivers/gpu/drm/drm_edid.c | 46 ++++++++++++++++++++++++++++++++++++++
 include/drm/drm_edid.h     |  2 ++
 2 files changed, 48 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 9990a836d0b6..53c7eed7a73e 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -2872,6 +2872,52 @@ u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid)
 }
 EXPORT_SYMBOL(drm_edid_get_panel_id);
 
+/**
+ * drm_edid_get_preferred_size - Get a panel's preferred size from EDID
+ * @drm_edid: EDID that contains panel ID.
+ * @width: Returns the panel's width in pixels per scanline, if given
+ * @height: Returns the panel's height in scanlines, if given
+ *
+ * This function detects the preferred size of a panel from the given
+ * EDID. There is no such information stored in the EDID block directly,
+ * but the preferred mode often corresponds to the panel's native geometry.
+ *
+ * Return: Zero on success, or a negative errno code otherwise.
+ */
+int drm_edid_get_preferred_size(const struct drm_edid *drm_edid,
+				unsigned int *width, unsigned int *height)
+{
+	const struct edid *edid = drm_edid->edid;
+	const struct detailed_timing *dt;
+	const struct detailed_pixel_timing *pt;
+
+	if (drm_edid->size < EDID_LENGTH)
+		return -EINVAL;
+
+	/*
+	 * Use display mode from the Preferred Timing Descriptor. For old
+	 * and obscure displays, we might need better heuristics.
+	 */
+
+	if (edid->revision < 4 && !(edid->features & DRM_EDID_FEATURE_PREFERRED_TIMING))
+		return -EINVAL; /* no Preferred Timing Descriptor */
+
+	dt = &edid->detailed_timings[0];
+
+	if (!le16_to_cpu(dt->pixel_clock))
+		return -EINVAL;
+
+	pt = &dt->data.pixel_data;
+
+	if (width)
+		*width = (pt->hactive_hblank_hi & 0xf0) << 4 | pt->hactive_lo;
+	if (height)
+		*height = (pt->vactive_vblank_hi & 0xf0) << 4 | pt->vactive_lo;
+
+	return 0;
+}
+EXPORT_SYMBOL(drm_edid_get_preferred_size);
+
 /**
  * drm_edid_read_base_block - Get a panel's EDID base block
  * @adapter: I2C adapter to use for DDC
diff --git a/include/drm/drm_edid.h b/include/drm/drm_edid.h
index 04f7a7f1f108..981aeeb6ddf9 100644
--- a/include/drm/drm_edid.h
+++ b/include/drm/drm_edid.h
@@ -487,6 +487,8 @@ void drm_edid_get_product_id(const struct drm_edid *drm_edid,
 void drm_edid_print_product_id(struct drm_printer *p,
 			       const struct drm_edid_product_id *id, bool raw);
 u32 drm_edid_get_panel_id(const struct drm_edid *drm_edid);
+int drm_edid_get_preferred_size(const struct drm_edid *drm_edid,
+				unsigned int *width, unsigned int *height);
 bool drm_edid_match(const struct drm_edid *drm_edid,
 		    const struct drm_edid_ident *ident);
 bool drm_edid_has_quirk(struct drm_connector *connector, enum drm_edid_quirk quirk);
-- 
2.55.0

