Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44613F327B5
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2B4F10E757;
	Tue, 21 Apr 2026 07:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="F94z7EZT";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="UwjbWBZo";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qkJO7Wt8";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="t4uG7ERH";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34C3889E1D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:36:54 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D552E6A7F6;
 Tue, 21 Apr 2026 07:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776757013; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TW/MzDOP2ENkPQEJeTMl2b4EFrH1v4tbff2C8jt/ppA=;
 b=F94z7EZTjZ+8nHWatUcTqXdpqWkEXFIiPFYVwJiVti4IJ/MAvpwpRRYSkAtIaWkEzReq4V
 bEuX93N6SrgNDGDo/ykgcDzJIXGWFd7vO64y+VKU92ZrG+ExoWuqhWrCB8IJrxhnRLgNKd
 S4iXSh6kgnZJ9Vr1fvvFo+lhMlj4ptM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776757013;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TW/MzDOP2ENkPQEJeTMl2b4EFrH1v4tbff2C8jt/ppA=;
 b=UwjbWBZoM/t2RY4NHr457lIbgfBSU06UI+3lxjxCWG9yLnVZaGC1sbh2QH/db3not/C654
 Rz08viUdSN5jr3Bg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776757012; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TW/MzDOP2ENkPQEJeTMl2b4EFrH1v4tbff2C8jt/ppA=;
 b=qkJO7Wt83pYkXMp2l6M3SWZ03ttzOvTeJ6lonfeq/D30+JpAg9+IT86esOFv+Ldaw9oqJT
 D3jmiM7PZGn2TISOcvsn/Ge3qQydl789BPSweb5iGccLch9cpW4MCLpDwovCMMt3yW76Zm
 81c6aenK9dolLkuKr9Jhh2HuDX0+E8c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776757012;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=TW/MzDOP2ENkPQEJeTMl2b4EFrH1v4tbff2C8jt/ppA=;
 b=t4uG7ERHxpDpnlOKKFuKwkfn6/+Jf+mIaOHbRYRbZJwWsArkIpX7h6BFIRd0v3+7fU86ua
 isV7D4Klce9go5Dg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E445593AF;
 Tue, 21 Apr 2026 07:36:52 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id YZCrERQp52lgMQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Tue, 21 Apr 2026 07:36:52 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: thierry.reding@gmail.com, mperttunen@nvidia.com, airlied@gmail.com,
 simona@ffwll.ch, jonathanh@nvidia.com
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/5] drm/tegra: fbdev: Use client buffers
Date: Tue, 21 Apr 2026 09:29:04 +0200
Message-ID: <20260421073646.144712-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 SUSPICIOUS_RECIPS(1.50)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 MID_CONTAINS_FROM(1.00)[]; R_MISSING_CHARSET(0.50)[];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 TAGGED_RCPT(0.00)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MIME_TRACE(0.00)[0:+];
 FREEMAIL_TO(0.00)[gmail.com,nvidia.com,ffwll.ch];
 RCPT_COUNT_SEVEN(0.00)[8];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_COUNT_TWO(0.00)[2]; FREEMAIL_ENVRCPT(0.00)[gmail.com]
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
client. Until now, tegra created an internal ad-hoc framebuffer for
its fbdev emulation, while by-passing the regular interfaces used by
user-space compositors.

Convert tegra's fbdev emulation to use client buffers. Replacing the
existing code with a client buffer allows for stream-lining tegra code
and later also the fbdev helpers. The new framebuffer will be registered
against the client's file and will support handles for GEM objects. It
is then just another framebuffer within the DRM ecosystem.

Patches 1 and 2 fix problems in the fbdev-emulation code.

Patches 3 and 4 convert fbdev emulation to shared DRM interfaces and
client buffers.

Patch 5 cleans up.

Thomas Zimmermann (5):
  drm/tegra: fbdev: Do not assign to struct drm_fb_helper.info
  drm/tegra: fbdev: Remove offset into framebuffer memory
  drm/tegra: fbdev: Calculate buffer geometry with format helpers
  drm/tegra: fbdev: Use a DRM client buffer
  drm/tegra: Make tegra_fb_alloc() an internal interface

 drivers/gpu/drm/tegra/drm.h   |  5 --
 drivers/gpu/drm/tegra/fb.c    |  1 +
 drivers/gpu/drm/tegra/fbdev.c | 88 ++++++++++++++++++-----------------
 3 files changed, 47 insertions(+), 47 deletions(-)

-- 
2.53.0

