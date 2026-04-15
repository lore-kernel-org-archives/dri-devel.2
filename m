Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DB1AF43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:26:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2A7F10E709;
	Wed, 15 Apr 2026 15:26:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="SN+R0Nt8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GmIOeALX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="SN+R0Nt8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="GmIOeALX";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1794C10E703
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:26:46 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 18D916A86C;
 Wed, 15 Apr 2026 15:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVoKaGYOMobapfYEYS/l2/lynVrtmAB2GHMH/NABZOs=;
 b=SN+R0Nt8UEeYQe5smVU8zvNPhO4okX7pFH/AvQJpfp3sPyNiaCVpjGezNr/GJMTnbbH7z0
 G9WyzCpunW4nPppbxoWxjEmWkNV3UezDQU4oHMrkPyJcXoXBMNdGjdyYMIzS7Ars68cbOc
 fnEbC5dRpFHoh7LiLhubNBxv8qP0qDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVoKaGYOMobapfYEYS/l2/lynVrtmAB2GHMH/NABZOs=;
 b=GmIOeALXA6Pkbb3Ilz8BHZz+XW3+/oYAhVhP6KXBIDL0E6HiAtQaxwDDkkq7jGXEKic18a
 Q+KqYTvPkFnTtqAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=SN+R0Nt8;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=GmIOeALX
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266795; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVoKaGYOMobapfYEYS/l2/lynVrtmAB2GHMH/NABZOs=;
 b=SN+R0Nt8UEeYQe5smVU8zvNPhO4okX7pFH/AvQJpfp3sPyNiaCVpjGezNr/GJMTnbbH7z0
 G9WyzCpunW4nPppbxoWxjEmWkNV3UezDQU4oHMrkPyJcXoXBMNdGjdyYMIzS7Ars68cbOc
 fnEbC5dRpFHoh7LiLhubNBxv8qP0qDc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266795;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jVoKaGYOMobapfYEYS/l2/lynVrtmAB2GHMH/NABZOs=;
 b=GmIOeALXA6Pkbb3Ilz8BHZz+XW3+/oYAhVhP6KXBIDL0E6HiAtQaxwDDkkq7jGXEKic18a
 Q+KqYTvPkFnTtqAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D3D1D4BA97;
 Wed, 15 Apr 2026 15:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id sNSEMiqu32nXWQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Apr 2026 15:26:34 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6/6] drm/mgag200: Enable DRM_FORMAT_XRGB1555 on the primary
 plane
Date: Wed, 15 Apr 2026 17:23:40 +0200
Message-ID: <20260415152625.101710-7-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415152625.101710-1-tzimmermann@suse.de>
References: <20260415152625.101710-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; TO_MATCH_ENVRCPT_ALL(0.00)[]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com];
 MIME_TRACE(0.00)[0:+];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 TO_DN_SOME(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 RCVD_COUNT_TWO(0.00)[2]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 R_RATELIMIT(0.00)[to_ip_from(RLqtkr6cif1ebgurukgmwdm7xc)];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 18D916A86C
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

The driver already sets the format for the depth value in the XMULCTRL
register. Add the format to the other switch statements, set the helpers
for gamma correction and export the XRGB1555 in the primary plane's
format array.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mgag200/mgag200_g200se.c | 1 +
 drivers/gpu/drm/mgag200/mgag200_mode.c   | 8 ++++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
index 746ce11b75fb..5c2185d6b707 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
@@ -82,6 +82,7 @@ static void mgag200_g200se_set_hiprilvl(struct mga_device *mdev,
 			bpp = 32;
 			break;
 		case DRM_FORMAT_RGB565:
+		case DRM_FORMAT_XRGB1555:
 			bpp = 16;
 			break;
 		case DRM_FORMAT_C8:
diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 7fe1d492083e..bd346b828773 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -59,6 +59,9 @@ void mgag200_crtc_fill_gamma(struct mga_device *mdev,
 	case DRM_FORMAT_C8:
 		drm_crtc_fill_palette_8(crtc, mgag200_set_gamma_lut);
 		break;
+	case DRM_FORMAT_XRGB1555:
+		drm_crtc_fill_gamma_555(crtc, mgag200_set_gamma_lut);
+		break;
 	case DRM_FORMAT_RGB565:
 		drm_crtc_fill_gamma_565(crtc, mgag200_set_gamma_lut);
 		break;
@@ -83,6 +86,9 @@ void mgag200_crtc_load_gamma(struct mga_device *mdev,
 	case DRM_FORMAT_C8:
 		drm_crtc_load_palette_8(crtc, lut, mgag200_set_gamma_lut);
 		break;
+	case DRM_FORMAT_XRGB1555:
+		drm_crtc_load_gamma_555_from_888(crtc, lut, mgag200_set_gamma_lut);
+		break;
 	case DRM_FORMAT_RGB565:
 		drm_crtc_load_gamma_565_from_888(crtc, lut, mgag200_set_gamma_lut);
 		break;
@@ -180,6 +186,7 @@ static void mgag200_set_datasiz(struct mga_device *mdev, u32 format)
 
 	/* Big-endian byte-swapping */
 	switch (format) {
+	case DRM_FORMAT_XRGB1555:
 	case DRM_FORMAT_RGB565:
 		opmode |= 0x10100;
 		break;
@@ -443,6 +450,7 @@ static void mgag200_handle_damage(struct mga_device *mdev, const struct iosys_ma
 const uint32_t mgag200_primary_plane_formats[] = {
 	DRM_FORMAT_XRGB8888,
 	DRM_FORMAT_RGB565,
+	DRM_FORMAT_XRGB1555,
 	DRM_FORMAT_RGB888,
 	DRM_FORMAT_C8,
 };
-- 
2.53.0

