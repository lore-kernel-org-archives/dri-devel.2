Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A641CF43832
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 15:26:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DEA710E705;
	Wed, 15 Apr 2026 15:26:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="0o98aBIU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RBru4U+3";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="0o98aBIU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RBru4U+3";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D94C010E703
 for <dri-devel@lists.freedesktop.org>; Wed, 15 Apr 2026 15:26:34 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 83C085BD82;
 Wed, 15 Apr 2026 15:26:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=49+Ifrw0Vq8ooG7FfqB4eAWqhlrwPtBT5XMOgy8rs6w=;
 b=0o98aBIU069UDHUcuz3MuaulrG56A7yZaUBL/At+DZlRG34mS3vGa474lPK9bsALcz3w3f
 Wmt/zhJkpDNDElppHFx3GPl0MBEpBg1cD7aKFjCxi+Hr7tGDeK+iudi7bGN9GJGh7jQw+z
 uegC+3Ks17OYSZuzEYXOqIDJN5PIN+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=49+Ifrw0Vq8ooG7FfqB4eAWqhlrwPtBT5XMOgy8rs6w=;
 b=RBru4U+3MK/LY5n4qsYhJxM8UQzOws22agP9Kn0rKIksq6bpaFCQXvai9uuDlpomZ6o+xJ
 nD2kbhFxTVNI8+BA==
Authentication-Results: smtp-out2.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=0o98aBIU;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=RBru4U+3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776266793; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=49+Ifrw0Vq8ooG7FfqB4eAWqhlrwPtBT5XMOgy8rs6w=;
 b=0o98aBIU069UDHUcuz3MuaulrG56A7yZaUBL/At+DZlRG34mS3vGa474lPK9bsALcz3w3f
 Wmt/zhJkpDNDElppHFx3GPl0MBEpBg1cD7aKFjCxi+Hr7tGDeK+iudi7bGN9GJGh7jQw+z
 uegC+3Ks17OYSZuzEYXOqIDJN5PIN+Q=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776266793;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=49+Ifrw0Vq8ooG7FfqB4eAWqhlrwPtBT5XMOgy8rs6w=;
 b=RBru4U+3MK/LY5n4qsYhJxM8UQzOws22agP9Kn0rKIksq6bpaFCQXvai9uuDlpomZ6o+xJ
 nD2kbhFxTVNI8+BA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 3D8BF4BA97;
 Wed, 15 Apr 2026 15:26:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 0DGVDSmu32nXWQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 15 Apr 2026 15:26:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, airlied@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, simona@ffwll.ch, airlied@gmail.com
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/6] drm/mgag200: Fix color formats
Date: Wed, 15 Apr 2026 17:23:34 +0200
Message-ID: <20260415152625.101710-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,ffwll.ch,gmail.com];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; MIME_TRACE(0.00)[0:+];
 ARC_NA(0.00)[]; TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; FROM_HAS_DN(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 RCPT_COUNT_SEVEN(0.00)[8];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 83C085BD82
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

Fix various issues with mgag200's handlign of color formats. Remove
the deprecated cpp field, simplify the code and add missing formats.

Tested on a G200 card by running the framebuffer console and Xorg
with the different color formats; as far as they support them.

Thomas Zimmermann (6):
  drm/mgag200: Set xmulctrl from DRM format
  drm/mgag200: Set scale from DRM format
  drm/mgag200: Simplify offset calculation
  drm/mgag200: g200se: Set hiprilvl from DRM format
  drm/mgag200: Enable DRM_FORMAT_C8 on the primary plane
  drm/mgag200: Enable DRM_FORMAT_XRGB1555 on the primary plane

 drivers/gpu/drm/mgag200/mgag200_g200se.c | 13 +++-
 drivers/gpu/drm/mgag200/mgag200_mode.c   | 99 +++++++++++-------------
 drivers/gpu/drm/mgag200/mgag200_reg.h    |  1 +
 3 files changed, 55 insertions(+), 58 deletions(-)

-- 
2.53.0

