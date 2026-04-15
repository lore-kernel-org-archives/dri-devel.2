Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7BF8F43847
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:26:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1608210E704;
	Wed, 15 Apr 2026 15:26:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="AukfXY3y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6ErlyXnu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="AukfXY3y";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="6ErlyXnu";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 71F0F10E70F
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:26:39 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id C3AD95BDF5;
 Wed, 15 Apr 2026 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xd+5W+fiufGz6aGuhF+BHhZqxMj+KI/bk+Xw/L96Sk4=;
 b=AukfXY3yWnI/baTpbkE1IhdEedC4gVqaeW7ppygIhzTFVmuqy+Wxoss/ZKxpPg9BfafuXt
 kt0usaXehH5XIjgxt4hEWRwZNzNnqfoOZHhMXmT5dSq65U54rmljdTGqkSzWPVla0RgMgR
 QJxqZl+qf6uKEc2s9exbn7a7E/zbKZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xd+5W+fiufGz6aGuhF+BHhZqxMj+KI/bk+Xw/L96Sk4=;
 b=6ErlyXnuxb5h67HMDrztovjjpqwilb/nzN8pl0J3xSe4G3kMWZlFQ/iGzR8Z0UppsPZzSg
 fUfy766dXnovUrBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xd+5W+fiufGz6aGuhF+BHhZqxMj+KI/bk+Xw/L96Sk4=;
 b=AukfXY3yWnI/baTpbkE1IhdEedC4gVqaeW7ppygIhzTFVmuqy+Wxoss/ZKxpPg9BfafuXt
 kt0usaXehH5XIjgxt4hEWRwZNzNnqfoOZHhMXmT5dSq65U54rmljdTGqkSzWPVla0RgMgR
 QJxqZl+qf6uKEc2s9exbn7a7E/zbKZU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xd+5W+fiufGz6aGuhF+BHhZqxMj+KI/bk+Xw/L96Sk4=;
 b=6ErlyXnuxb5h67HMDrztovjjpqwilb/nzN8pl0J3xSe4G3kMWZlFQ/iGzR8Z0UppsPZzSg
 fUfy766dXnovUrBg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 88A034BA99;
 Wed, 15 Apr 2026 15:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 4AUsICmu32nXWQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Apr 2026 15:26:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 1/6] drm/mgag200: Set xmulctrl from DRM format
Date: Wed, 15 Apr 2026 17:23:35 +0200
Message-ID: <20260415152625.101710-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415152625.101710-1-tzimmermann@suse.de>
References: <20260415152625.101710-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.994];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:email,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[8];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com];
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

Replace the deprecated cpp value from struct drm_format_info with the
format's 4CC code when setting the depth value in the XMULCTRL register.
Split the 16-bit case into XRGB1555 and RGB565. The default branch cannot
be taken, so remove it.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 8894a063b1a1..316413d814ae 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -343,9 +343,9 @@ static void mgag200_set_offset(struct mga_device *mdev,
 
 void mgag200_set_format_regs(struct mga_device *mdev, const struct drm_format_info *format)
 {
-	struct drm_device *dev = &mdev->base;
 	unsigned int bpp, bppshift, scale;
-	u8 crtcext3, xmulctrl;
+	u8 xmulctrl = 0;
+	u8 crtcext3;
 
 	bpp = format->cpp[0] * 8;
 
@@ -361,26 +361,22 @@ void mgag200_set_format_regs(struct mga_device *mdev, const struct drm_format_in
 
 	RREG_ECRT(3, crtcext3);
 
-	switch (bpp) {
-	case 8:
+	switch (format->format) {
+	case DRM_FORMAT_C8:
 		xmulctrl = MGA1064_MUL_CTL_8bits;
 		break;
-	case 16:
-		if (format->depth == 15)
-			xmulctrl = MGA1064_MUL_CTL_15bits;
-		else
-			xmulctrl = MGA1064_MUL_CTL_16bits;
+	case DRM_FORMAT_XRGB1555:
+		xmulctrl = MGA1064_MUL_CTL_15bits;
 		break;
-	case 24:
+	case DRM_FORMAT_RGB565:
+		xmulctrl = MGA1064_MUL_CTL_16bits;
+		break;
+	case DRM_FORMAT_RGB888:
 		xmulctrl = MGA1064_MUL_CTL_24bits;
 		break;
-	case 32:
+	case DRM_FORMAT_XRGB8888:
 		xmulctrl = MGA1064_MUL_CTL_32_24bits;
 		break;
-	default:
-		/* BUG: We should have caught this problem already. */
-		drm_WARN_ON(dev, "invalid format depth\n");
-		return;
 	}
 
 	crtcext3 &= ~GENMASK(2, 0);
-- 
2.53.0

