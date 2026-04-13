Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6FFEEBFD1D
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 08:50:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B5CE10E381;
	Mon, 13 Apr 2026 08:50:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="zGdl5yhA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jxnmbHeX";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="zGdl5yhA";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="jxnmbHeX";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8666F10E381
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 08:50:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 07BE36A8BD;
 Mon, 13 Apr 2026 08:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776070242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gcm6Lhk0pWR/p2wkDvqAZ620MrcCigFGddG2kVVcyqA=;
 b=zGdl5yhAixt6mUcjN9CElMMuLh0XAXZaaZ/pzHD+gY78oj7aJBBaiXmkEW1gYaGRQrN6hz
 /5VSD15tXnL1U9nSKNtY+4VV91CX+eaLb1P4cOkx/tJx9hDgvSkaf1bDseP1Gkf5S3vxKs
 OXyT9Wb2quCTngJpylQlxlsWh/t6m5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776070242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gcm6Lhk0pWR/p2wkDvqAZ620MrcCigFGddG2kVVcyqA=;
 b=jxnmbHeXY2WauZNSnqR3IBoXvqXAwfYRl+PY4D+dp5hSK5ROYdK+cZ4UJpsTLOHIOLDbvc
 dpFfS/2R2m+OgtAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776070242; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gcm6Lhk0pWR/p2wkDvqAZ620MrcCigFGddG2kVVcyqA=;
 b=zGdl5yhAixt6mUcjN9CElMMuLh0XAXZaaZ/pzHD+gY78oj7aJBBaiXmkEW1gYaGRQrN6hz
 /5VSD15tXnL1U9nSKNtY+4VV91CX+eaLb1P4cOkx/tJx9hDgvSkaf1bDseP1Gkf5S3vxKs
 OXyT9Wb2quCTngJpylQlxlsWh/t6m5A=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776070242;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=gcm6Lhk0pWR/p2wkDvqAZ620MrcCigFGddG2kVVcyqA=;
 b=jxnmbHeXY2WauZNSnqR3IBoXvqXAwfYRl+PY4D+dp5hSK5ROYdK+cZ4UJpsTLOHIOLDbvc
 dpFfS/2R2m+OgtAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id AA1C34ADCF;
 Mon, 13 Apr 2026 08:50:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id TBRYKGGu3GkfKAAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 13 Apr 2026 08:50:41 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
 kong.kongxinwei@hisilicon.com, sumit.semwal@linaro.org,
 yongqin.liu@linaro.org, jstultz@google.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 0/4] drm/hibmc: Fix plane helpers and convert to gem-shmem
Date: Mon, 13 Apr 2026 10:40:00 +0200
Message-ID: <20260413085037.17491-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000]; MID_CONTAINS_FROM(1.00)[];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-1.000];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 ARC_NA(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 FROM_HAS_DN(0.00)[]; RCPT_COUNT_TWELVE(0.00)[12];
 MIME_TRACE(0.00)[0:+];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; FROM_EQ_ENVFROM(0.00)[];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
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

Convert hibmc's memory management from gem-vram ot gem-shmem. Fix a
number of bugs in preparation.

Patches 1 to 3 fix various bugs in the plane code.

Patch 4 replaces gem-vram with gem-shmem. The rational is that gem-vram
has corner cases on low-end devices and is limited in functionality. The
commit messages state a list of possible issues.

Switching to gem-shmem avoids these problems. It also enables buffer
sharing with dma_buf, which improves the hibmc driver's integration with
the overall graphics ecosystem.

We've done these changes on drivers for similar hardware, such as ast and
mgag200. Hibmc is the last of these drivers to not run gem-shmem. Gem-vram
instead is deprecated and hopefully can be removed in a later release.

Tested on an RH1288 v3 system.

Thomas Zimmermann (4):
  drm/hibmc: Use drm_atomic_helper_check_plane_state()
  drm/hibmc: Fix list of formats on the primary plane
  drm/hibmc: Do not use cpp from struct drm_format_info
  drm/hibmc: Use gem-shmem with shadow-plane helpers for memory
    management

 drivers/gpu/drm/drm_gem_shmem_helper.c        |  17 ++-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig       |   2 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 110 +++++++++---------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  62 +++++++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
 include/drm/drm_gem_shmem_helper.h            |   5 +
 6 files changed, 128 insertions(+), 73 deletions(-)

-- 
2.53.0

