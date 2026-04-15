Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C547CF43847
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:26:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C9E810E703;
	Wed, 15 Apr 2026 15:26:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="LXNwvnA7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AOTliAWM";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="LXNwvnA7";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AOTliAWM";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A31710E706
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:26:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 0E26A5BE25;
 Wed, 15 Apr 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOeA3mtPY9PUI1JXm8eNhkawhpHaHwfJaPIT2+2Txn0=;
 b=LXNwvnA7aafGRsTADgmFPEuGrjRsoovEHSKw/VAGKayn9j3Lueg2v6LAdapgIIKyLmrNBB
 a0d5S6viim9jpPxtROWxsB/aVOnVTgdKoy2iqv2aSE9SZlG7Zw+9kS2+jbUlcbyc4lqamc
 B4fufUqA7jRnTJAMMKouFYBJmh31l5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOeA3mtPY9PUI1JXm8eNhkawhpHaHwfJaPIT2+2Txn0=;
 b=AOTliAWMXtnW07Q2vFWZ3p8WkoHKEdfpAm2Dv5T6mzIwQ/CI++062H4po3jfDGIge+xMxH
 GcZ1IzOyya6XLPDg==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=LXNwvnA7;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AOTliAWM
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOeA3mtPY9PUI1JXm8eNhkawhpHaHwfJaPIT2+2Txn0=;
 b=LXNwvnA7aafGRsTADgmFPEuGrjRsoovEHSKw/VAGKayn9j3Lueg2v6LAdapgIIKyLmrNBB
 a0d5S6viim9jpPxtROWxsB/aVOnVTgdKoy2iqv2aSE9SZlG7Zw+9kS2+jbUlcbyc4lqamc
 B4fufUqA7jRnTJAMMKouFYBJmh31l5M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OOeA3mtPY9PUI1JXm8eNhkawhpHaHwfJaPIT2+2Txn0=;
 b=AOTliAWMXtnW07Q2vFWZ3p8WkoHKEdfpAm2Dv5T6mzIwQ/CI++062H4po3jfDGIge+xMxH
 GcZ1IzOyya6XLPDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id CA05B4BA97;
 Wed, 15 Apr 2026 15:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id cN4hMCmu32nXWQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Apr 2026 15:26:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 2/6] drm/mgag200: Set scale from DRM format
Date: Wed, 15 Apr 2026 17:23:36 +0200
Message-ID: <20260415152625.101710-3-tzimmermann@suse.de>
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
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[]; TO_DN_SOME(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:mid,suse.de:dkim,suse.de:email];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 0E26A5BE25
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
format's 4CC code when setting the scale value in CRTCEXT3. While at it,
remove the scale variable and add a mask constant.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mgag200/mgag200_mode.c | 30 +++++++++++++++-----------
 drivers/gpu/drm/mgag200/mgag200_reg.h  |  1 +
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_mode.c b/drivers/gpu/drm/mgag200/mgag200_mode.c
index 316413d814ae..5b526aebaeb8 100644
--- a/drivers/gpu/drm/mgag200/mgag200_mode.c
+++ b/drivers/gpu/drm/mgag200/mgag200_mode.c
@@ -343,24 +343,31 @@ static void mgag200_set_offset(struct mga_device *mdev,
 
 void mgag200_set_format_regs(struct mga_device *mdev, const struct drm_format_info *format)
 {
-	unsigned int bpp, bppshift, scale;
 	u8 xmulctrl = 0;
 	u8 crtcext3;
 
-	bpp = format->cpp[0] * 8;
+	RREG_ECRT(3, crtcext3);
 
-	bppshift = mgag200_get_bpp_shift(format);
-	switch (bpp) {
-	case 24:
-		scale = ((1 << bppshift) * 3) - 1;
+	switch (format->format) {
+	case DRM_FORMAT_C8:
+		crtcext3 &= ~MGAREG_CRTCEXT3_SCALE_MASK;
+		crtcext3 |= 0x0;
 		break;
-	default:
-		scale = (1 << bppshift) - 1;
+	case DRM_FORMAT_XRGB1555:
+	case DRM_FORMAT_RGB565:
+		crtcext3 &= ~MGAREG_CRTCEXT3_SCALE_MASK;
+		crtcext3 |= 0x01;
+		break;
+	case DRM_FORMAT_RGB888:
+		crtcext3 &= ~MGAREG_CRTCEXT3_SCALE_MASK;
+		crtcext3 |= 0x02;
+		break;
+	case DRM_FORMAT_XRGB8888:
+		crtcext3 &= ~MGAREG_CRTCEXT3_SCALE_MASK;
+		crtcext3 |= 0x03;
 		break;
 	}
 
-	RREG_ECRT(3, crtcext3);
-
 	switch (format->format) {
 	case DRM_FORMAT_C8:
 		xmulctrl = MGA1064_MUL_CTL_8bits;
@@ -379,9 +386,6 @@ void mgag200_set_format_regs(struct mga_device *mdev, const struct drm_format_in
 		break;
 	}
 
-	crtcext3 &= ~GENMASK(2, 0);
-	crtcext3 |= scale;
-
 	WREG_DAC(MGA1064_MUL_CTL, xmulctrl);
 
 	WREG_GFX(0, 0x00);
diff --git a/drivers/gpu/drm/mgag200/mgag200_reg.h b/drivers/gpu/drm/mgag200/mgag200_reg.h
index d4fef8f25871..088b6c16f7f6 100644
--- a/drivers/gpu/drm/mgag200/mgag200_reg.h
+++ b/drivers/gpu/drm/mgag200/mgag200_reg.h
@@ -265,6 +265,7 @@
 #define MGAREG_CRTCEXT1_HRSTEN		BIT(3)
 
 #define MGAREG_CRTCEXT3_MGAMODE		BIT(7)
+#define MGAREG_CRTCEXT3_SCALE_MASK	GENMASK(2, 0)
 
 /* Cursor X and Y position */
 #define MGA_CURPOSXL 0x3c0c
-- 
2.53.0

