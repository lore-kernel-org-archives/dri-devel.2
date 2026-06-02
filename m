Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09714CD6E57
	for <dri-devel@archiver.kernel.org>; Tue,  2 Jun 2026 11:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6ED7810EF8D;
	Tue,  2 Jun 2026 11:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="0GRVz7t6";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="o6od7Wvz";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="CnpdZALC";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RH8H4TVU";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3199A10EF8D
 for <dri-devel@lists.freedesktop.org>; Tue,  2 Jun 2026 11:28:48 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D28816BC38;
 Tue,  2 Jun 2026 11:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780399727; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jbv4kfo8TiUpckuoHEWzvjGMhWyz1QQxUXmauN8z388=;
 b=0GRVz7t6Pc/v2Pkd/+jgwIC84M6yCaNXOu+wCPDauZ4G9GTdl/frNIsatgP4AmyDBnO/mB
 gFdrDJqyvDsCJIf9daQUaGjQc+jB9PF+69uiWyMPYOqnGD8rUXOWaY+3eO65XW7ZENm9qb
 o/bSxQ4VSoZu2Jq9c2QnK5Mu4z7+vac=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780399727;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jbv4kfo8TiUpckuoHEWzvjGMhWyz1QQxUXmauN8z388=;
 b=o6od7WvzNqLa6RODBpK9aj62LlJ5Ii6BggXVM5yYIxB56uMw8ZIaMlTQhCovqG6xt/6hl/
 rOuY/Jjgca9Y3sDw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=CnpdZALC;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RH8H4TVU
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780399726; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jbv4kfo8TiUpckuoHEWzvjGMhWyz1QQxUXmauN8z388=;
 b=CnpdZALCbV7utn6liVxyUHz91M/qO9Y5EzL0A0q7kxm42egsOv4stXSUKtQORm3mr+O80g
 C2hfGfuHC3T01CFJQZ5UxWYGo4pKcggFy+wimQRr3/1mA3UsRbsC9En7FOctOTgQVuioGN
 daut4O1ZXlec0UqHY5OpNC6FVOTUQOs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780399726;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=jbv4kfo8TiUpckuoHEWzvjGMhWyz1QQxUXmauN8z388=;
 b=RH8H4TVUKK/qyvVVH/XXcFvY7mbb6MAQfJpPpi3/mkbUPXyzMHwBnBaQJrLi+zx7hZ6i2n
 7j09B4KB8RsT2CDg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 86DD8779A7;
 Tue,  2 Jun 2026 11:28:46 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id kJGyH26+HmpgRAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 02 Jun 2026 11:28:46 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: rajat.gupta@oss.qualcomm.com, jani.nikula@linux.intel.com,
 jani.saarinen@intel.com, simona@ffwll.ch, airlied@gmail.com,
 mripard@kernel.org, maarten.lankhorst@linux.intel.com
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH] drm/dumb-buffer: Drop buffer-size limits for now
Date: Tue,  2 Jun 2026 13:24:01 +0200
Message-ID: <20260602112842.252279-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D28816BC38
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 MIME_GOOD(-0.10)[text/plain]; MX_GOOD(-0.01)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,suse.de:dkim,suse.de:email,suse.de:mid,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,qualcomm.com:email];
 ARC_NA(0.00)[]; RCVD_TLS_ALL(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; RCPT_COUNT_SEVEN(0.00)[11];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[oss.qualcomm.com,linux.intel.com,intel.com,ffwll.ch,gmail.com,kernel.org];
 RCVD_COUNT_TWO(0.00)[2]; FROM_HAS_DN(0.00)[];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+]
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

The size limits break some of the CI tests. So drop them for now. Keep
the other overflow tests from commit 5ab62dd3687b ("drm: prevent integer
overflows in dumb buffer creation helpers") in place.

There is still a pre-existing overflow check for 32-bit type limits in
drm_mode_create_dumb() that will catch the really absurd size requests.
Drivers that still do not use drm_mode_size_dumb() should be updated. The
helper calculates dumb-buffer geometry with overflow checks.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Fixes: 5ab62dd3687b ("drm: prevent integer overflows in dumb buffer creation helpers")
Reported-by: Jani Nikula <jani.nikula@linux.intel.com>
Closes: https://lore.kernel.org/dri-devel/ddf0233e50044059c85279f928661563ef6a55bf@intel.com/
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Cc: Maxime Ripard <mripard@kernel.org>
---
 drivers/gpu/drm/drm_dumb_buffers.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_dumb_buffers.c b/drivers/gpu/drm/drm_dumb_buffers.c
index e60130b2bb0c..8e9ff17538e7 100644
--- a/drivers/gpu/drm/drm_dumb_buffers.c
+++ b/drivers/gpu/drm/drm_dumb_buffers.c
@@ -201,13 +201,6 @@ int drm_mode_create_dumb(struct drm_device *dev,
 	if (!args->width || !args->height || !args->bpp)
 		return -EINVAL;
 
-	/* Reject unreasonable inputs early.  Dumb buffers are for software
-	 * rendering; nothing legitimate needs more than 8192x8192 at 32bpp.
-	 * This prevents overflows in downstream alignment helpers.
-	 */
-	if (args->width >= 8192 || args->height >= 8192 || args->bpp > 32)
-		return -EINVAL;
-
 	/* overflow checks for 32bit size calculations */
 	if (args->bpp > U32_MAX - 8)
 		return -EINVAL;

base-commit: a980196655477a8f5067112946401fe52e510664
-- 
2.54.0

