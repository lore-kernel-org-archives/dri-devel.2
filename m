Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46D5BCD3436
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 06:48:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E51E10F347;
	Fri,  8 May 2026 06:48:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ANmkIqsM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e07jgZVE";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="ANmkIqsM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="e07jgZVE";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 46AC310E1C0
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 06:48:51 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DCDE65CEB6;
 Fri,  8 May 2026 06:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778222929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=65S+KmzmUssjk4pJY7vbLPmVKicD/x422e6acP5deGQ=;
 b=ANmkIqsM+5g3qJ6kw8t6BMW88uwwhXYzXiJaOpZe0Vso0C8UnWs03hdMBnoiv3XynufNve
 fhgUv9sU8TS1GlHpTjh7fulDTJGbpvJJ0MXJ1n2IxsLrmtv71zupQB5ibJ3EgNfHj4C0WD
 eZAV649IM/eaaS1AgxXMPk2cURfk6fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778222929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=65S+KmzmUssjk4pJY7vbLPmVKicD/x422e6acP5deGQ=;
 b=e07jgZVEMjcw1TZYvczkAc2B2TVdT2wYecNY09uovT3UnjhSCFY2VcJ9soaQXDvMcSX7Gd
 uwDfpU/cAcT2/cAw==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1778222929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=65S+KmzmUssjk4pJY7vbLPmVKicD/x422e6acP5deGQ=;
 b=ANmkIqsM+5g3qJ6kw8t6BMW88uwwhXYzXiJaOpZe0Vso0C8UnWs03hdMBnoiv3XynufNve
 fhgUv9sU8TS1GlHpTjh7fulDTJGbpvJJ0MXJ1n2IxsLrmtv71zupQB5ibJ3EgNfHj4C0WD
 eZAV649IM/eaaS1AgxXMPk2cURfk6fo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1778222929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=65S+KmzmUssjk4pJY7vbLPmVKicD/x422e6acP5deGQ=;
 b=e07jgZVEMjcw1TZYvczkAc2B2TVdT2wYecNY09uovT3UnjhSCFY2VcJ9soaQXDvMcSX7Gd
 uwDfpU/cAcT2/cAw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 92B1B593A7;
 Fri,  8 May 2026 06:48:49 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 6/ZtIlGH/Wm1cgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 08 May 2026 06:48:49 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: inki.dae@samsung.com, sw0312.kim@samsung.com, kyungmin.park@samsung.com,
 m.szyprowski@samsung.com, wens@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, linux-samsung-soc@vger.kernel.org,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/5] drm/exynos: fbdev: Use client buffers
Date: Fri,  8 May 2026 08:46:46 +0200
Message-ID: <20260508064842.22689-1-tzimmermann@suse.de>
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo];
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

v2:
- clean up exynos fb header (Chen-Yu)

Thomas Zimmermann (5):
  drm/exynos: fbdev: Remove offset into screen_buffer
  drm/exynos: fbdev: Inline exynos_drm_fbdev_update()
  drm/exynos: fbdev: Calculate buffer geometry with format helpers
  drm/exynos: fbdev: Use a DRM client buffer
  drm/exynos: Make exynos_drm_framebuffer_init() an internal interface

 drivers/gpu/drm/exynos/exynos_drm_fb.c    |   3 +-
 drivers/gpu/drm/exynos/exynos_drm_fb.h    |  10 +--
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 101 ++++++++++------------
 3 files changed, 52 insertions(+), 62 deletions(-)


base-commit: 94d56a898a2db27f841b17f6966a81ba502fe63c
-- 
2.54.0

