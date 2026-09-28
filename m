Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33A55CA5FA7
	for <dri-devel@archiver.kernel.org>; Mon, 28 Sep 2026 08:03:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 628C410E7E6;
	Mon, 28 Sep 2026 08:03:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1ua2sRpc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="52CrCdTu";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="qAf7ExlU";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="qPraS+eD";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E80210E7F7;
 Mon, 28 Sep 2026 08:03:55 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 3F02C22261;
 Mon, 28 Sep 2026 08:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790582614; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kmYVfCKDkAd4SbCiRkHNFQwJCnqKJd6ox50FWhc42Yg=;
 b=1ua2sRpcqIDd0Oijf+IF02cBKLPxqxj5tmuxhcCEQO+s6VIGoN/tV2gKgagRDlN0zrHoU3
 LWQcHEdIufpabOYDqrUPqBZREUeBfSR6U/nzCHncp1Hv7bxfe09x68FzuJF/Haww5D9sal
 NzksfVa1fNVBtrCcTDKl+VgfASf9zuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790582614;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kmYVfCKDkAd4SbCiRkHNFQwJCnqKJd6ox50FWhc42Yg=;
 b=52CrCdTuknPBq2KMST9yyDXVP+bv0PB+Xx0tMYmfF7xfcxPDshquuGrD+r1R47U8GnV+ju
 uvj89sH0wnXlL7Cg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790582610; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kmYVfCKDkAd4SbCiRkHNFQwJCnqKJd6ox50FWhc42Yg=;
 b=qAf7ExlUyrNUcSjyDnTOUXS9apNmnZBOjeefhQD1qLdL/CcFIcXfgGxhj9qbOc4kmQifbf
 at6GqXjinwuaY3UFe5rLNcLHzEFgORFoIsOsFIM+r5OoTp82prGkxyMZfYeiY9Rv9US3rU
 jK+4Nm2G0OoqJefHqWA7RZDnuzX6nrM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790582610;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=kmYVfCKDkAd4SbCiRkHNFQwJCnqKJd6ox50FWhc42Yg=;
 b=qPraS+eD7dKSEWR2Xe0in4GJ1jZ762mYQ2OGg/nZd0KMRWaiPjOWc8fcE+hcLZzot+WvdR
 xeJ2+PejIm/4YBAQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 748EF133F1;
 Mon, 28 Sep 2026 08:03:29 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id LwPoBFEfumpBYQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 28 Sep 2026 08:03:29 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: jfalempe@redhat.com, javierm@redhat.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 jani.nikula@linux.intel.com, Alexander.Deucher@amd.com
Cc: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, linux-rockchip@lists.infradead.org,
 linux-tegra@vger.kernel.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 0/2] drm/fbdev: Move helpers to clients/ subdirectory
Date: Mon, 28 Sep 2026 10:01:23 +0200
Message-ID: <20260928080323.23909-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.999];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 FROM_HAS_DN(0.00)[]; ARC_NA(0.00)[]; MIME_TRACE(0.00)[0:+];
 TO_DN_SOME(0.00)[]; RCPT_COUNT_TWELVE(0.00)[21];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.de:mid];
 RCVD_VIA_SMTP_AUTH(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[redhat.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch,amd.com];
 RCVD_TLS_ALL(0.00)[];
 R_RATELIMIT(0.00)[to_ip_from(RLq3cifbxyhc6qbbynzfc6amns)];
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

Helpers for fbdev emulation are still linked into drm_kms_helper.ko,
which is for mode setting. Move the source and header files to the
clients/ subdirectory and link them into drm_client_lib.ko. This has
some fallout throughout drivers, but it's all trivial.

There are 3 module parameters to drm_kms_helper.ko that control fbdev
emulation. For compatibility with existing installations, leave them
in this module.

v4:
- fix the depedendencies from v3
v3:
- remove obsolete dependencies from Kconfig
v2:
- update armada and docs

Thomas Zimmermann (2):
  drm/fbdev: Move fbdev module parameters next to module init
  drm/fbdev: Move fbdev helpers into client library

 Documentation/gpu/drm-kms-helpers.rst         |  6 +--
 drivers/gpu/drm/Kconfig                       |  7 ++--
 drivers/gpu/drm/Makefile                      |  1 -
 drivers/gpu/drm/amd/amdgpu/amdgpu_display.c   |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_kms.c       |  2 +-
 drivers/gpu/drm/armada/armada_fbdev.c         |  2 +-
 drivers/gpu/drm/clients/Makefile              |  3 +-
 drivers/gpu/drm/clients/drm_fbdev_client.c    |  2 +-
 .../drm_fbdev_helper.c}                       | 34 +---------------
 drivers/gpu/drm/drm_crtc_helper_internal.h    |  9 +++++
 drivers/gpu/drm/drm_fbdev_dma.c               |  2 +-
 drivers/gpu/drm/drm_fbdev_shmem.c             |  2 +-
 drivers/gpu/drm/drm_fbdev_ttm.c               |  2 +-
 drivers/gpu/drm/drm_kms_helper_common.c       | 39 +++++++++++++++++++
 drivers/gpu/drm/exynos/exynos_drm_fbdev.c     |  2 +-
 drivers/gpu/drm/gma500/fbdev.c                |  2 +-
 drivers/gpu/drm/i915/display/intel_fbdev.c    |  2 +-
 drivers/gpu/drm/msm/msm_debugfs.c             |  2 +-
 drivers/gpu/drm/msm/msm_fbdev.c               |  2 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c       |  1 -
 drivers/gpu/drm/omapdrm/omap_debugfs.c        |  2 +-
 drivers/gpu/drm/omapdrm/omap_fbdev.c          |  2 +-
 drivers/gpu/drm/radeon/radeon_device.c        |  2 +-
 drivers/gpu/drm/radeon/radeon_fbdev.c         |  2 +-
 drivers/gpu/drm/rockchip/rockchip_drm_gem.c   |  2 +-
 drivers/gpu/drm/sitronix/st7571.c             |  1 -
 drivers/gpu/drm/tegra/fbdev.c                 |  2 +-
 drivers/gpu/drm/vboxvideo/vbox_mode.c         |  2 +-
 .../drm_fbdev_helper.h}                       |  4 +-
 29 files changed, 79 insertions(+), 64 deletions(-)
 rename drivers/gpu/drm/{drm_fb_helper.c => clients/drm_fbdev_helper.c} (97%)
 rename include/drm/{drm_fb_helper.h => clients/drm_fbdev_helper.h} (99%)


base-commit: ff831af91674990f9f1814340860e96943d5df1a
prerequisite-patch-id: c67e5d886a47b7d0266d81100837557fda34cb24
prerequisite-patch-id: a5a973e527c88a5b47053d7a72aefe0b550197cb
prerequisite-patch-id: b9adc9622920a3e70168e672c2c92795b3e3a106
prerequisite-patch-id: 5030de433a01c2e99056cadb676a8e2ba35f055a
-- 
2.55.0

