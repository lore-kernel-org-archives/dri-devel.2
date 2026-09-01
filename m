Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E657C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 12:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8426C10E7D7;
	Tue,  1 Sep 2026 12:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="U6jOc/Vg";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="zLFlewVl";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="w4DMk6j/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="0RDXPt/J";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2986F10E7D7
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 12:27:46 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 6882822780;
 Tue,  1 Sep 2026 12:27:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788265660; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DEuLE0BgQA8LZ20x0JkYmbROZW9RhG/RMzIm2/7GesQ=;
 b=U6jOc/VgE3cHi6Z80nxckF1JXjV4p2AzrBaJKHcEoYVGhn5K03ogrwDviweAd/Ll+kCZqj
 ysLIlhheZP40xRlLzHQU7m3Dz27y23IYY1j+6OltXy/fghTaJlq5ZDcmdofLZi7wffhjJl
 KQOTPuCUSi1FrqIPgRgd8nmr42PdcWk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788265660;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DEuLE0BgQA8LZ20x0JkYmbROZW9RhG/RMzIm2/7GesQ=;
 b=zLFlewVleg3IVEXDRJjWsKtRo2DGwrOfWvo5zaqzlngA0gzf4tPanZH8Y5umU/ZrVcG0Pp
 SOqb+60MeofuwkBA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b="w4DMk6j/";
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b="0RDXPt/J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1788265656; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DEuLE0BgQA8LZ20x0JkYmbROZW9RhG/RMzIm2/7GesQ=;
 b=w4DMk6j/9xdV5uiGKoBopU/CLkKZmAvi2blcq/eZHHos/vmw8NaSPhdChm9jx/BtbGuSJo
 oVqNN7u+EFJF5uei1/oS2prpGxkShnOHBDMfw+NBHYz4D2AsbTBNDx6aSYmCYYnYxN0wZ6
 mBTB7UBZrF53W240eKQOV7UjWcoHsrw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1788265656;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=DEuLE0BgQA8LZ20x0JkYmbROZW9RhG/RMzIm2/7GesQ=;
 b=0RDXPt/JzZbW/218XCXeh15YyQ1hZDxARBEuRFort4fL10dZbGy6xmqokbFcsKkD7YpX0g
 e3xnnmLpzuCWimAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 07CA7136A2;
 Tue,  1 Sep 2026 12:27:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xOqkALjElmq2dgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 01 Sep 2026 12:27:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch, daniels@collabora.com, leandro.ribeiro@collabora.com,
 pekka.paalanen@collabora.com, lowry.li@arm.com
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/atomic: Set plane-state pixel_blend_mode to default
Date: Tue,  1 Sep 2026 14:25:26 +0200
Message-ID: <20260901122731.83854-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 6882822780
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_TO(0.00)[linux.intel.com,kernel.org,gmail.com,ffwll.ch,collabora.com,arm.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[collabora.com:email,suse.de:dkim,suse.de:email,suse.de:mid,intel.com:email,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_SEVEN(0.00)[11];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
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

Initialize the plane state's pixel_blend_mode value to the plane
property's default value. Resolves an inconsistency on planes that
do not support PREMULTI.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 860e748bddcc ("drm: ensure blend mode supported if pixel format with alpha exposed")
Cc: Leandro Ribeiro <leandro.ribeiro@collabora.com>
Cc: Pekka Paalanen <pekka.paalanen@collabora.com>
Cc: Daniel Stone <daniels@collabora.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
---
It's not clear what Fixes should point to, so I picked the commit that
introduced the stricter validation of the blend-mode property.
---
 drivers/gpu/drm/drm_atomic_state_helper.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/drm_atomic_state_helper.c
index d90d1d7c9cf9..0325caee528a 100644
--- a/drivers/gpu/drm/drm_atomic_state_helper.c
+++ b/drivers/gpu/drm/drm_atomic_state_helper.c
@@ -278,7 +278,13 @@ void __drm_atomic_helper_plane_state_init(struct drm_plane_state *plane_state,
 	plane_state->rotation = DRM_MODE_ROTATE_0;
 
 	plane_state->alpha = DRM_BLEND_ALPHA_OPAQUE;
-	plane_state->pixel_blend_mode = DRM_MODE_BLEND_PREMULTI;
+
+	if (plane->blend_mode_property) {
+		if (!drm_object_property_get_default_value(&plane->base,
+							   plane->blend_mode_property,
+							   &val))
+			plane_state->pixel_blend_mode = val;
+	}
 
 	if (plane->color_encoding_property) {
 		if (!drm_object_property_get_default_value(&plane->base,
-- 
2.55.0

