Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A4E8CD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 13:59:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8909310F60D;
	Fri, 19 Jun 2026 13:59:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="k4Myi0Za";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JIzdBTHA";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="k4Myi0Za";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="JIzdBTHA";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B19610F60D
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 13:59:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 9EADD75D2F;
 Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpDVnK0TvHBIKhkXL855ih+LuB40KwhHQbSuYGInKMA=;
 b=k4Myi0Za8gqT0rQHGExxItBz+b3hJg/fGW16a6u/abiBcYjIHl23JoI+GE481zEYiOKSys
 8LdpalJb+HZsuuI1kMc93wlTo38p7p1fFCF31Wbtm6wxdFGnKlWAjmr69WNhupnhBsodXV
 hvCx4D/hUglcwx3axX5AQPcuBFsVHnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781877531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpDVnK0TvHBIKhkXL855ih+LuB40KwhHQbSuYGInKMA=;
 b=JIzdBTHAUw2sIqpx9TxSlCjsHs2BBU7yEjEiOvjPr0vyCG1tyOUG4nOvP8khZLtlVKdMkk
 ds+X8qZqlN/andCQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781877531; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpDVnK0TvHBIKhkXL855ih+LuB40KwhHQbSuYGInKMA=;
 b=k4Myi0Za8gqT0rQHGExxItBz+b3hJg/fGW16a6u/abiBcYjIHl23JoI+GE481zEYiOKSys
 8LdpalJb+HZsuuI1kMc93wlTo38p7p1fFCF31Wbtm6wxdFGnKlWAjmr69WNhupnhBsodXV
 hvCx4D/hUglcwx3axX5AQPcuBFsVHnY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781877531;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FpDVnK0TvHBIKhkXL855ih+LuB40KwhHQbSuYGInKMA=;
 b=JIzdBTHAUw2sIqpx9TxSlCjsHs2BBU7yEjEiOvjPr0vyCG1tyOUG4nOvP8khZLtlVKdMkk
 ds+X8qZqlN/andCQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 5791A779A8;
 Fri, 19 Jun 2026 13:58:51 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YGAcFBtLNWpvfwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 19 Jun 2026 13:58:51 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch, rayyan@ansari.sh
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: [PATCH 2/3] drm/sysfb: simpledrm: Improve panel-size validation
Date: Fri, 19 Jun 2026 15:56:35 +0200
Message-ID: <20260619135847.309664-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260619135847.309664-1-tzimmermann@suse.de>
References: <20260619135847.309664-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,ansari.sh];
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

Validate the panel size from the device-tree node against the
limitations of struct drm_display_mode. The type only stores sizes
in 16-bit fields. Fail transparently on errors; do not warn.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 2a6d731a8f16 ("drm/simpledrm: Allow physical width and height configuration via panel node")
Cc: Rayyan Ansari <rayyan@ansari.sh>
Cc: <stable@vger.kernel.org> # v6.4+
---
 drivers/gpu/drm/sysfb/simpledrm.c | 35 ++++++++++++++++++++++++++++---
 1 file changed, 32 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 03bd19fadccd..5c1db0785d92 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -200,6 +200,35 @@ simplefb_get_memory_of(struct drm_device *dev, struct device_node *of_node)
 	return res;
 }
 
+static u16
+__simplefb_get_panel_size_mm_of(struct drm_device *dev, struct device_node *of_panel_node,
+				const char *name)
+{
+	int ret;
+	u32 value;
+
+	ret = of_property_read_u32(of_panel_node, name, &value);
+	if (ret || value > U16_MAX) {
+		drm_dbg(dev, "simplefb: cannot parse panel %s: value %u, error %d\n",
+			name, value, ret);
+		return 0; /* not an error, simply ignore */
+	}
+
+	return value;
+}
+
+static u16
+simplefb_get_panel_width_mm_of(struct drm_device *dev, struct device_node *of_panel_node)
+{
+	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "width-mm");
+}
+
+static u16
+simplefb_get_panel_height_mm_of(struct drm_device *dev, struct device_node *of_panel_node)
+{
+	return __simplefb_get_panel_size_mm_of(dev, of_panel_node, "height-mm");
+}
+
 /*
  * Simple Framebuffer device
  */
@@ -601,7 +630,7 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 	struct drm_sysfb_device *sysfb;
 	struct drm_device *dev;
 	int width, height, stride;
-	int width_mm = 0, height_mm = 0;
+	u16 width_mm = 0, height_mm = 0;
 	struct device_node *panel_node;
 	const struct drm_format_info *format;
 	struct resource *res, *mem = NULL;
@@ -665,8 +694,8 @@ static struct simpledrm_device *simpledrm_device_create(struct drm_driver *drv,
 			return ERR_CAST(mem);
 		panel_node = of_parse_phandle(of_node, "panel", 0);
 		if (panel_node) {
-			simplefb_read_u32_of(dev, panel_node, "width-mm", &width_mm);
-			simplefb_read_u32_of(dev, panel_node, "height-mm", &height_mm);
+			width_mm = simplefb_get_panel_width_mm_of(dev, panel_node);
+			height_mm = simplefb_get_panel_height_mm_of(dev, panel_node);
 			of_node_put(panel_node);
 		}
 	} else {
-- 
2.54.0

