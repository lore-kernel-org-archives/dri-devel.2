Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5894CD98ED
	for <dri-devel@archiver.kernel.org>; Thu, 18 Jun 2026 12:31:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D96F510F2D4;
	Thu, 18 Jun 2026 12:31:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="1ynjfjJc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s7vEiTTt";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="1ynjfjJc";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="s7vEiTTt";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1D77610F2D6
 for <dri-devel@lists.freedesktop.org>; Thu, 18 Jun 2026 12:31:49 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DA7B16D350;
 Thu, 18 Jun 2026 12:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781785907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xo0aHidRb4wA5F1wXgNyr9a0GOziBVbGIPO/tKEQZic=;
 b=1ynjfjJc9+dqGE4LUrptDoTjlEWf9B1NDi0W63XQbB9A9dZZ0AVdRgLbv5pbP43muPnv14
 D4jPEf37+KASXcwCvOSp+OhC6avJxIK5gt3/FN9b2FyLZ4IQeUmAAqQ90HQAHDwQNF4QP2
 0ioB2i8XVpnQSx6+kVAOzUoBKSuncVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781785907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xo0aHidRb4wA5F1wXgNyr9a0GOziBVbGIPO/tKEQZic=;
 b=s7vEiTTt7Ei6omIViI7Mul29Sj9ZEhlFD+GeybPGCF3IIg/EM/61QFkTFk7bhQwviR3yqO
 KRsD0KMP/qYQSCAA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1781785907; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xo0aHidRb4wA5F1wXgNyr9a0GOziBVbGIPO/tKEQZic=;
 b=1ynjfjJc9+dqGE4LUrptDoTjlEWf9B1NDi0W63XQbB9A9dZZ0AVdRgLbv5pbP43muPnv14
 D4jPEf37+KASXcwCvOSp+OhC6avJxIK5gt3/FN9b2FyLZ4IQeUmAAqQ90HQAHDwQNF4QP2
 0ioB2i8XVpnQSx6+kVAOzUoBKSuncVk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1781785907;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=xo0aHidRb4wA5F1wXgNyr9a0GOziBVbGIPO/tKEQZic=;
 b=s7vEiTTt7Ei6omIViI7Mul29Sj9ZEhlFD+GeybPGCF3IIg/EM/61QFkTFk7bhQwviR3yqO
 KRsD0KMP/qYQSCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 91433779A8;
 Thu, 18 Jun 2026 12:31:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id hMZMIjPlM2rTJQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 18 Jun 2026 12:31:47 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: shiyongbang@huawei.com, tiantao6@hisilicon.com,
 kong.kongxinwei@hisilicon.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org, sashiko-reviews@lists.linux.dev,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v4 0/6] drm/hibmc: Fix plane helpers and convert to gem-shmem
Date: Thu, 18 Jun 2026 14:28:38 +0200
Message-ID: <20260618123142.92298-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.993];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,imap1.dmz-prg2.suse.org:helo];
 FROM_EQ_ENVFROM(0.00)[]; RCPT_COUNT_SEVEN(0.00)[10];
 RCVD_COUNT_TWO(0.00)[2];
 FREEMAIL_TO(0.00)[huawei.com,hisilicon.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
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

Patches 1 to 5 fix various bugs and minor issues in the plane code.

Patch 6 replaces gem-vram with gem-shmem. The rational is that gem-vram
has corner cases on low-end devices and is limited in functionality. The
commit messages state a list of possible issues.

Switching to gem-shmem avoids these problems. It also enables buffer
sharing via dma_buf, which improves the hibmc driver's integration with
the overall graphics ecosystem.

We've done these changes on drivers for similar hardware, such as ast and
mgag200. Hibmc is the last of these drivers to run on gem-shmem. Gem-vram
instead is deprecated and can hopefully be removed in a later release.

Tested on an RH1288 v3 system.

v4:
- verify framebuffer pitch aligns to 128
- store fb in local variable in atomic_update (Yongbang)
v3:
- fix coding style
- rebase on display-detection fixes
v2:
- extend commit message of patch 2 (Yongbang)
- so not select TTM any longer

Thomas Zimmermann (6):
  drm/hibmc: Use drm_atomic_helper_check_plane_state()
  drm/hibmc: Fix list of formats on the primary plane
  drm/hibmc: Store fb in variable in atomic_update
  drm/hibmc: Do not use cpp from struct drm_format_info
  drm/hibmc: Verify the framebuffer pitch to be a multiple of 128
  drm/hibmc: Use gem-shmem with shadow-plane helpers for memory
    management

 drivers/gpu/drm/drm_gem_shmem_helper.c        |  22 +++-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig       |   4 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 110 +++++++++---------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  78 ++++++++++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
 include/drm/drm_gem_shmem_helper.h            |   4 +
 6 files changed, 145 insertions(+), 78 deletions(-)

-- 
2.54.0

