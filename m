Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7046DCD98E4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 11:29:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E9C010EFB6;
	Wed, 17 Jun 2026 11:29:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="oPfOXgYU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="amUuwIPq";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="oPfOXgYU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="amUuwIPq";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5BA8310EFB6
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 11:29:38 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 2C5916BE9D;
 Wed, 17 Jun 2026 11:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781695777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bvGNV9+UmkBe7RHunpLn8bpoR/HxeG2h0AA7dFDpGfM=;
 b=oPfOXgYU7EhjallY0uZdEdxYjBctUGylD9GSRcqmuxfnvEzjrxmVPMDCQyVinJun82LejN
 Vv17Jb3joF7uuSceuXzxLngAByvk9yqBr9AZTLlg03/TH68gvTfSS3b/CyQaEy7lVRFUnx
 y+0mQ7cp4ugAc2y5MNVXPD9bT/UFgTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781695777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bvGNV9+UmkBe7RHunpLn8bpoR/HxeG2h0AA7dFDpGfM=;
 b=amUuwIPq9rfYOmFrEF7pvsNVKFz0fI6+n28m4D3mTacie1Uvf+xtJey3bkQpVB0jx47bTZ
 /PUxxVT7UTCDRJDA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781695777; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bvGNV9+UmkBe7RHunpLn8bpoR/HxeG2h0AA7dFDpGfM=;
 b=oPfOXgYU7EhjallY0uZdEdxYjBctUGylD9GSRcqmuxfnvEzjrxmVPMDCQyVinJun82LejN
 Vv17Jb3joF7uuSceuXzxLngAByvk9yqBr9AZTLlg03/TH68gvTfSS3b/CyQaEy7lVRFUnx
 y+0mQ7cp4ugAc2y5MNVXPD9bT/UFgTE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781695777;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bvGNV9+UmkBe7RHunpLn8bpoR/HxeG2h0AA7dFDpGfM=;
 b=amUuwIPq9rfYOmFrEF7pvsNVKFz0fI6+n28m4D3mTacie1Uvf+xtJey3bkQpVB0jx47bTZ
 /PUxxVT7UTCDRJDA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id D756B779A8;
 Wed, 17 Jun 2026 11:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LyqjMiCFMmqbZAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 17 Jun 2026 11:29:36 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/2] drm/sysfb: Fix visible size and related checks
Date: Wed, 17 Jun 2026 13:27:28 +0200
Message-ID: <20260617112932.511657-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.60 / 50.00]; BAYES_HAM(-3.00)[99.99%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; MIME_GOOD(-0.10)[text/plain];
 NEURAL_HAM_SHORT(-0.00)[-0.018]; RCPT_COUNT_SEVEN(0.00)[8];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 ARC_NA(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 URIBL_BLOCKED(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
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

We need the system framebuffer's visible size in efidrm and
vesadrm. Fix the size calculation for some corner cases and
handle errors correctly.

Thomas Zimmermann (2):
  drm/sysfb: Do not page-align visible size of the framebuffer
  drm/sysfb: Return errno code from drm_sysfb_get_visible_size()

 drivers/gpu/drm/sysfb/drm_sysfb_helper.h      | 2 +-
 drivers/gpu/drm/sysfb/drm_sysfb_screen_info.c | 4 ++--
 drivers/gpu/drm/sysfb/efidrm.c                | 7 ++++---
 drivers/gpu/drm/sysfb/vesadrm.c               | 6 +++---
 4 files changed, 10 insertions(+), 9 deletions(-)


base-commit: fc59f76558703febba8056be87d1c97d14f7485e
-- 
2.54.0

