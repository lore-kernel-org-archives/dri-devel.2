Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 418DFF36C58
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:11:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C5BD10E563;
	Mon, 20 Apr 2026 12:11:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="yAVRMNgS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p2VxAAdP";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="yAVRMNgS";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="p2VxAAdP";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE45610E563
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:11:37 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 45E586A7DC;
 Mon, 20 Apr 2026 12:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776687094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hJjKnRHrF/ZENb27xNWlk1BUc3yEzEhLMXS0gAYTmtU=;
 b=yAVRMNgSbbaM9wPeQU8r2HX45ztIMJdVakTNJBbL7p2Q3DT89A73SPJZzv9VgKMTYtB+sk
 Sa6sDs8RyoQk5x0AT8mnldK0RqCTsXYxqqdNAOGuGgCxM+LSB/Dj7OUqltmJN86TQaV9R0
 jfjMKWJdFy5imL9z8CGgV7rE2Exy/YA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776687094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hJjKnRHrF/ZENb27xNWlk1BUc3yEzEhLMXS0gAYTmtU=;
 b=p2VxAAdPtj84MRaiq8SjvGYyDDOP4A0oF3KZfg9Q2TZbih2W+FF0G9kNq66S0ulAE8Fq1D
 oztzxt7Chjg6PWCg==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=yAVRMNgS;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=p2VxAAdP
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1776687094; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hJjKnRHrF/ZENb27xNWlk1BUc3yEzEhLMXS0gAYTmtU=;
 b=yAVRMNgSbbaM9wPeQU8r2HX45ztIMJdVakTNJBbL7p2Q3DT89A73SPJZzv9VgKMTYtB+sk
 Sa6sDs8RyoQk5x0AT8mnldK0RqCTsXYxqqdNAOGuGgCxM+LSB/Dj7OUqltmJN86TQaV9R0
 jfjMKWJdFy5imL9z8CGgV7rE2Exy/YA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1776687094;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=hJjKnRHrF/ZENb27xNWlk1BUc3yEzEhLMXS0gAYTmtU=;
 b=p2VxAAdPtj84MRaiq8SjvGYyDDOP4A0oF3KZfg9Q2TZbih2W+FF0G9kNq66S0ulAE8Fq1D
 oztzxt7Chjg6PWCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id E35D3593AE;
 Mon, 20 Apr 2026 12:11:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 5ySkNfUX5mkGZQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Mon, 20 Apr 2026 12:11:33 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: xinliang.liu@linaro.org, tiantao6@hisilicon.com,
 kong.kongxinwei@hisilicon.com, sumit.semwal@linaro.org,
 yongqin.liu@linaro.org, jstultz@google.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@gmail.com,
 simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v2 0/4] drm/hibmc: Fix plane helpers and convert to gem-shmem
Date: Mon, 20 Apr 2026 14:09:56 +0200
Message-ID: <20260420121130.200133-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Spamd-Result: default: False [-3.01 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 FREEMAIL_TO(0.00)[linaro.org,hisilicon.com,google.com,linux.intel.com,kernel.org,gmail.com,ffwll.ch];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 RCPT_COUNT_TWELVE(0.00)[12];
 SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 MIME_TRACE(0.00)[0:+]; RCVD_COUNT_TWO(0.00)[2];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_VIA_SMTP_AUTH(0.00)[];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:106:10:150:64:167:received,2a07:de40:b281:104:10:150:64:97:from];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns,suse.de:dkim,suse.de:mid];
 FROM_EQ_ENVFROM(0.00)[]; DKIM_TRACE(0.00)[suse.de:+];
 FROM_HAS_DN(0.00)[]; RCVD_TLS_ALL(0.00)[]; TO_DN_SOME(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Rspamd-Queue-Id: 45E586A7DC
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

v2:
- extend commit message of patch 2 (Yongbang)
- so not select TTM any longer

Thomas Zimmermann (4):
  drm/hibmc: Use drm_atomic_helper_check_plane_state()
  drm/hibmc: Fix list of formats on the primary plane
  drm/hibmc: Do not use cpp from struct drm_format_info
  drm/hibmc: Use gem-shmem with shadow-plane helpers for memory
    management

 drivers/gpu/drm/drm_gem_shmem_helper.c        |  17 ++-
 drivers/gpu/drm/hisilicon/hibmc/Kconfig       |   4 +-
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_de.c    | 110 +++++++++---------
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   |  62 +++++++---
 .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h   |   5 +
 include/drm/drm_gem_shmem_helper.h            |   5 +
 6 files changed, 128 insertions(+), 75 deletions(-)

-- 
2.53.0

