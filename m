Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF77BF43847
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:26:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5ACDA10E70B;
	Wed, 15 Apr 2026 15:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="O7s6Lepo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w5GoNo7O";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="O7s6Lepo";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="w5GoNo7O";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4CCD10E703
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:26:35 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 8B8916A896;
 Wed, 15 Apr 2026 15:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0ErxS0I1OwyklsE8jp7QQUB+zhpaMj+t8f/+yJ+dpY=;
 b=O7s6LepocuMXj3DKe80by261YdJgcvNbqvpf1ZoLD4TXvxue8F/TFGFOlzTs3uUeSiZy2U
 c3E1LNRGTgUsLa6F9j0sUbYPXpH5OR4ZLDXffTOsqwZjzG3/4eV00wy/wAEBFYOT0RZSkN
 u1Up09Xk1gD3xMWZN6xdtn8H4ANju9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0ErxS0I1OwyklsE8jp7QQUB+zhpaMj+t8f/+yJ+dpY=;
 b=w5GoNo7OPpydgGu6v3cuX5YeSOPsargdUe3TwfbrOsu7yUDPI8tpQiapEJ7+rmurenmuWP
 FRls2wJ6j2QRVLAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=O7s6Lepo;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=w5GoNo7O
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266794; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0ErxS0I1OwyklsE8jp7QQUB+zhpaMj+t8f/+yJ+dpY=;
 b=O7s6LepocuMXj3DKe80by261YdJgcvNbqvpf1ZoLD4TXvxue8F/TFGFOlzTs3uUeSiZy2U
 c3E1LNRGTgUsLa6F9j0sUbYPXpH5OR4ZLDXffTOsqwZjzG3/4eV00wy/wAEBFYOT0RZSkN
 u1Up09Xk1gD3xMWZN6xdtn8H4ANju9U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266794;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Q0ErxS0I1OwyklsE8jp7QQUB+zhpaMj+t8f/+yJ+dpY=;
 b=w5GoNo7OPpydgGu6v3cuX5YeSOPsargdUe3TwfbrOsu7yUDPI8tpQiapEJ7+rmurenmuWP
 FRls2wJ6j2QRVLAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 52E044BA97;
 Wed, 15 Apr 2026 15:26:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id oIANEyqu32nXWQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Apr 2026 15:26:34 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 4/6] drm/mgag200: g200se: Set hiprilvl from DRM format
Date: Wed, 15 Apr 2026 17:23:38 +0200
Message-ID: <20260415152625.101710-5-tzimmermann@suse.de>
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
 MIME_TRACE(0.00)[0:+]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 TO_DN_SOME(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
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
X-Rspamd-Queue-Id: 8B8916A896
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

Replace the deprecated cpp field from struct drm_format_info with the
format's 4CC code when setting the hiprilvl field in CRTCEXT6.

Using a bpp of 32 for RGB888 is a bit dubious, but we keep it for now
to avoid changing behavior. Otherwise, bpp could also be retrieved by
calling drm_format_info_bpp().

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
---
 drivers/gpu/drm/mgag200/mgag200_g200se.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mgag200/mgag200_g200se.c b/drivers/gpu/drm/mgag200/mgag200_g200se.c
index a0ac19ee0353..746ce11b75fb 100644
--- a/drivers/gpu/drm/mgag200/mgag200_g200se.c
+++ b/drivers/gpu/drm/mgag200/mgag200_g200se.c
@@ -76,12 +76,18 @@ static void mgag200_g200se_set_hiprilvl(struct mga_device *mdev,
 		unsigned int bpp;
 		unsigned long mb;
 
-		if (format->cpp[0] * 8 > 16)
+		switch (format->format) {
+		case DRM_FORMAT_XRGB8888:
+		case DRM_FORMAT_RGB888:
 			bpp = 32;
-		else if (format->cpp[0] * 8 > 8)
+			break;
+		case DRM_FORMAT_RGB565:
 			bpp = 16;
-		else
+			break;
+		case DRM_FORMAT_C8:
 			bpp = 8;
+			break;
+		}
 
 		mb = (mode->clock * bpp) / 1000;
 		if (mb > 3100)
-- 
2.53.0

