Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25283606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 07:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GMB4vBnt;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7Sgv6Jyb;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GMB4vBnt;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=7Sgv6Jyb
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 44A9B10E46E;
	Fri, 27 Nov 2026 07:44:11 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2445410E46E;
 Fri, 27 Nov 2026 07:44:00 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 463842277C;
 Fri, 27 Nov 2026 07:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795765438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=23GQcnyHFcwot/grIQyZEGZ7YRJvkIzcCqxrsOWds1A=;
 b=GMB4vBntQrHr+WySGt/LlNferPsjc6Q9ckNrzgzwCn/mJvYDe8+5C6J7QdBPDhE0ytUWTn
 0V3a3ZPg7QS5sf5QMV9+dhVXRmeVt1B8wXiLHEWI/0rQvbMknT9uAiotHmLrzCHhGZbHSb
 xBnrKruWJAhyTwq5PP1MvIS4Gf4FoIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795765438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=23GQcnyHFcwot/grIQyZEGZ7YRJvkIzcCqxrsOWds1A=;
 b=7Sgv6JybZUPA6tQOt9UjKWtnBemdEG/hr/uUWDCnYeRZuPX+gJzWleyd4aF1emVbFzdQBq
 sLOFDcAwwtZeROCA==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=GMB4vBnt;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=7Sgv6Jyb
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795765438; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=23GQcnyHFcwot/grIQyZEGZ7YRJvkIzcCqxrsOWds1A=;
 b=GMB4vBntQrHr+WySGt/LlNferPsjc6Q9ckNrzgzwCn/mJvYDe8+5C6J7QdBPDhE0ytUWTn
 0V3a3ZPg7QS5sf5QMV9+dhVXRmeVt1B8wXiLHEWI/0rQvbMknT9uAiotHmLrzCHhGZbHSb
 xBnrKruWJAhyTwq5PP1MvIS4Gf4FoIY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795765438;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=23GQcnyHFcwot/grIQyZEGZ7YRJvkIzcCqxrsOWds1A=;
 b=7Sgv6JybZUPA6tQOt9UjKWtnBemdEG/hr/uUWDCnYeRZuPX+gJzWleyd4aF1emVbFzdQBq
 sLOFDcAwwtZeROCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 8B20E13432;
 Fri, 27 Nov 2026 07:43:57 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id 179pEL00CWsEMQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 27 Nov 2026 07:43:57 +0000
Date: Fri, 27 Nov 2026 08:43:55 +0100
From: Thomas Zimmermann <tzimmermann@suse.de>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
Cc: Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Oded Gabbay <ogabbay@kernel.org>, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dim-tools@lists.freedesktop.org
Subject: [PULL] drm-misc-fixes
Message-ID: <20261127074355.GA14634@linux.fritz.box>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 463842277C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCPT_COUNT_TWELVE(0.00)[16]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 MIME_TRACE(0.00)[0:+]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; DKIM_TRACE(0.00)[suse.de:+];
 TO_DN_SOME(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 RCVD_TLS_ALL(0.00)[]; DWL_DNSWL_BLOCKED(0.00)[suse.de:dkim];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 MISSING_XM_UA(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:dkim, imap1.dmz-prg2.suse.org:rdns,
 imap1.dmz-prg2.suse.org:helo, gitlab.freedesktop.org:url, suse.com:url]
X-Spam-Score: -13.51
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Dave, Sima,

here's the drm-misc-fixes PR for this week.

Best regards
Thomas


drm-misc-fixes-2026-11-27:
Short summary of fixes pull:

ast:
- Allow disabling Write-Combine if CONFIG_RT=y

core:
- panic: Restore kmsg screen fix
- ttm: Don't leak LRU list on shutdown

dma-buf:
- dma-fence: Prevent misordering for error checks

gud:
- Fix potential divide-by-zero bug

imagination:
- Fix the value of ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP

nouveau:
- Fix double VBIOS checks

v3d:
- Fix double-free bug
The following changes since commit af1cf92e8617a7f7aa24b415596cbf64b76a12e7:

  drm/vc4: Clear the slice caches before resetting a stalled GPU (2026-11-19 10:40:54 -0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-11-27

for you to fetch changes up to bf57105b00e32d37b666c029c8c6b8708391da20:

  drm/nouveau/devinit/gf100-: fix double vbios init checks (2026-11-26 10:19:56 +1000)

----------------------------------------------------------------
Short summary of fixes pull:

ast:
- Allow disabling Write-Combine if CONFIG_RT=y

core:
- panic: Restore kmsg screen fix
- ttm: Don't leak LRU list on shutdown

dma-buf:
- dma-fence: Prevent misordering for error checks

gud:
- Fix potential divide-by-zero bug

imagination:
- Fix the value of ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP

nouveau:
- Fix double VBIOS checks

v3d:
- Fix double-free bug

----------------------------------------------------------------
Dave Airlie (1):
      drm/nouveau/devinit/gf100-: fix double vbios init checks

Devin Wittmayer (1):
      drm/panic: Bring back the kmsg screen fixes lost in a merge

Ian Forbes (1):
      ttm/pool: Don't leak LRU list on shutdown

Michał Grzelak (1):
      drm/ttm/tests: do not count pages after pool's teardown

Philipp Stanner (1):
      dma-buf/dma-fence: Prevent misordering for error checks

Ruben Wauters (1):
      drm/gud: fix potential divide error due to optimisation

Ryan Brue (1):
      drm/imagination: Fix the value of ROGUE_COMPUTE_FLAG_PREVENT_ALL_OVERLAP

Thomas Zimmermann (1):
      drm/ast: Add an option to disable Write-Combine

Xiaolei Wang (1):
      drm/v3d: Fix double free of query arrays on parse failure

 drivers/gpu/drm/ast/Kconfig                        |   9 ++
 drivers/gpu/drm/ast/ast_mm.c                       |  13 ++
 drivers/gpu/drm/drm_panic_helper.c                 |  10 +-
 drivers/gpu/drm/gud/gud_drv.c                      |   2 +-
 .../gpu/drm/imagination/pvr_rogue_fwif_client.h    |   2 +-
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c    |   4 +-
 drivers/gpu/drm/ttm/tests/ttm_pool_test.c          |   2 -
 drivers/gpu/drm/ttm/ttm_pool.c                     |   1 +
 drivers/gpu/drm/v3d/v3d_drv.h                      |   6 +-
 drivers/gpu/drm/v3d/v3d_sched.c                    |  40 +++---
 drivers/gpu/drm/v3d/v3d_submit.c                   | 142 +++++++--------------
 include/linux/dma-fence.h                          |  15 ++-
 12 files changed, 119 insertions(+), 127 deletions(-)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
