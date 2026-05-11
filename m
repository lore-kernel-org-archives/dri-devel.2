Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27942CD37AC
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 11:55:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3405610E6A5;
	Mon, 11 May 2026 11:55:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="gfI92xOp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cPijFBaQ";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="gfI92xOp";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cPijFBaQ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A3CC510E546
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 11:55:44 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 0CBB961CB9;
 Mon, 11 May 2026 11:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778500543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mIJRUigLZj/PD78y2FOxyIs4tzN0VAc/QZ4+NqxfINQ=;
 b=gfI92xOpOtrAYu1ELiDF7lc4TUTvel09bPLyyaR1vT+eOM+mZhppVDl0omQY3pwv6/Cbtw
 nCAiUzla/4jTVdOPR8u/bS/7aeCH5066cgUZM96xkMc9F8d1/iNlIT2kqLyHtKoUT2IVQd
 eSYYMVe/tEChntPZILPPzVRzUJNiRBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778500543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mIJRUigLZj/PD78y2FOxyIs4tzN0VAc/QZ4+NqxfINQ=;
 b=cPijFBaQQc7Wv+3sRRRSGvJhjaV6PbBopyki9roFMJjklviLefpgKh0LEJb9zm0Bnmw7OE
 xyYYwpjbM0qOzLCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778500543; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mIJRUigLZj/PD78y2FOxyIs4tzN0VAc/QZ4+NqxfINQ=;
 b=gfI92xOpOtrAYu1ELiDF7lc4TUTvel09bPLyyaR1vT+eOM+mZhppVDl0omQY3pwv6/Cbtw
 nCAiUzla/4jTVdOPR8u/bS/7aeCH5066cgUZM96xkMc9F8d1/iNlIT2kqLyHtKoUT2IVQd
 eSYYMVe/tEChntPZILPPzVRzUJNiRBY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778500543;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=mIJRUigLZj/PD78y2FOxyIs4tzN0VAc/QZ4+NqxfINQ=;
 b=cPijFBaQQc7Wv+3sRRRSGvJhjaV6PbBopyki9roFMJjklviLefpgKh0LEJb9zm0Bnmw7OE
 xyYYwpjbM0qOzLCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BAA88593A3;
 Mon, 11 May 2026 11:55:42 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id xtleLL7DAWoERgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 11 May 2026 11:55:42 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 m.szyprowski@samsung.com, wens@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v3 0/5] drm/exynos: fbdev: Use client buffers
Date: Mon, 11 May 2026 13:54:30 +0200
Message-ID: <20260511115538.57884-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[samsung.com,kernel.org,gmail.com,ffwll.ch];
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

A client buffer holds the DRM framebuffer for an in-kernel DRM
client. Until now, exynos created an internal ad-hoc framebuffer for
its fbdev emulation, while by-passing the regular interfaces used by
user-space compositors.

Convert exynos' fbdev emulation to use client buffers. Replacing the
existing code with a client buffer allows for stream-lining exynos code
and later also the fbdev helpers. The new framebuffer will be registered
against the client's file and will support handles for GEM objects. It
is then just another framebuffer within the DRM ecosystem.

If all driver's fbdev-emulation helpers can be converted to use client
buffers, the emulation's framebuffer handling as a whole can possibly be
moved into shared helpers.

Patch 1 first fixes a long-standing bug.

Patches 2 to 4 convert exynos' fbdev emulation to client buffers. It
still allocates a GEM object buffer tailored towards fbdev emulation,
but size calculations now use common DRM helpers.

Patch 5 cleans up symbol visibility in exynos' fb code.

v3:
- add error checks to geometry calculation
v2:
- clean up exynos fb header (Chen-Yu)

Thomas Zimmermann (5):
  drm/exynos: fbdev: Remove offset into screen_buffer
  drm/exynos: fbdev: Inline exynos_drm_fbdev_update()
  drm/exynos: fbdev: Calculate buffer geometry with format helpers
  drm/exynos: fbdev: Use a DRM client buffer
  drm/exynos: Make exynos_drm_framebuffer_init() an internal interface

 drivers/gpu/drm/exynos/exynos_drm_fb.c    |   3 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.h    |  10 +-
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 111 +++++++++++-----------
 3 files changed, 62 insertions(+), 62 deletions(-)


base-commit: 680a4832a8182b13ac5d55ab0c03c54ebc2baadd
-- 
2.54.0

