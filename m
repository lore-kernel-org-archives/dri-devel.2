Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED070FF8860
	for <dri-devel@archiver.kernel.org>; Mon, 27 Apr 2026 15:02:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 034CC10E0F9;
	Mon, 27 Apr 2026 15:02:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="MDzN59Nu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9drm2045";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="MDzN59Nu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="9drm2045";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 95C3B10E0F9
 for <dri-devel@lists.freedesktop.org>; Mon, 27 Apr 2026 15:02:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 4F0126A83E;
 Mon, 27 Apr 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777302174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KJWjDYp7JX2A2m5US/AAGHHAbWfTbe04Pz0h9NEKBEA=;
 b=MDzN59NufzyQSo1nu4bVnJih0YMrz4kFQ5NgHmEA/BstocexEMA0QAt6O+y8ceAsDFBJA3
 6jV1Knq9y3JvcND/n48iEe+gnYE4Eh7oA6AtXwhW4zPZYT/fLuODrYwJeFaYSO/hhTz1pO
 fqXZwh6JAtHq3tT6bKsCUm7GJKRl8SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777302174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KJWjDYp7JX2A2m5US/AAGHHAbWfTbe04Pz0h9NEKBEA=;
 b=9drm2045w8v4YnGe5EBArSOhwG4xPjnfYn9T53a1c6l8pR0y/XgHXBGv5ek3dZRnyZaROo
 pc9RiObhNZgIgyDQ==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1777302174; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KJWjDYp7JX2A2m5US/AAGHHAbWfTbe04Pz0h9NEKBEA=;
 b=MDzN59NufzyQSo1nu4bVnJih0YMrz4kFQ5NgHmEA/BstocexEMA0QAt6O+y8ceAsDFBJA3
 6jV1Knq9y3JvcND/n48iEe+gnYE4Eh7oA6AtXwhW4zPZYT/fLuODrYwJeFaYSO/hhTz1pO
 fqXZwh6JAtHq3tT6bKsCUm7GJKRl8SA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1777302174;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=KJWjDYp7JX2A2m5US/AAGHHAbWfTbe04Pz0h9NEKBEA=;
 b=9drm2045w8v4YnGe5EBArSOhwG4xPjnfYn9T53a1c6l8pR0y/XgHXBGv5ek3dZRnyZaROo
 pc9RiObhNZgIgyDQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 1BFB3593B0;
 Mon, 27 Apr 2026 15:02:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id +wKhBZ5672k9OQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 27 Apr 2026 15:02:54 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: zack.rusin@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/3] drm/vmwgfx: Use DRM's vblank timer
Date: Mon, 27 Apr 2026 17:00:37 +0200
Message-ID: <20260427150250.699768-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_FIVE(0.00)[6]; RCVD_TLS_ALL(0.00)[]
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

Replace vmwgfx's vblank timer with DRM's shared implementation. The
common code is mostly equivalent, but provides additional protection
against concurrent changes to the vblank counter.

Patches 1 and 2 align vmwgfx with the shared code, so that it can be
converted easily.

The conversion is in patch 3. It replaces vmwgfx's custom timer with
calls to DRM's vblank interfaces. Initialization happens internally.

This series should get some more testing.

v2:
- patch 3: fix vblank cancalling in CRTC cleanup (Zack)
- patch 2: mention timer restart in commit message (Zack)

Thomas Zimmermann (3):
  drm/vmwgfx: Determine lock-waiting timeout from vblank state
  drm/vmwgfx: Move vblank handling into separate helper
  drm/vmwgfx: Convert to DRM vblank timers

 drivers/gpu/drm/vmwgfx/vmwgfx_kms.h  |  2 -
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c  |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c |  1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c | 70 ++++++++--------------------
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.h |  2 +-
 6 files changed, 24 insertions(+), 53 deletions(-)

-- 
2.54.0

