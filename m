Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED6E9CD6E7B
	for <dri-devel@archiver.kernel.org>; Fri,  5 Jun 2026 07:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45416112AC0;
	Fri,  5 Jun 2026 07:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="ZSIV9Lvu";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="/Y9IiZR8";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="bqGHECoE";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="QjuUPYIW";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3EB81112AC4
 for <dri-devel@lists.freedesktop.org>; Fri,  5 Jun 2026 07:26:05 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id D57146B139;
 Fri,  5 Jun 2026 07:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780644364; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0qPw1IaSk2oUHyFt9atfgvw4vgsM+o6i1yuF73ABbOw=;
 b=ZSIV9LvuE9XuWWyWr+zTptJnTD2j8IIm9fWNA/wBVBqKSNij0L1jfL0f612iA62VKSzye2
 1/Se7o3v9/JsDlob5ZiQuI7UYVgoONs+UHJUCDNhCaa+t898mwePF0JXVIBSEnxWb573jG
 ODE1xNi3E1b3zCERQOmpaPFS2OmL/e4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780644364;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0qPw1IaSk2oUHyFt9atfgvw4vgsM+o6i1yuF73ABbOw=;
 b=/Y9IiZR89aZGjQZNOAdxQUEjNWloeN4j7wOZkHHo7ii0v+hMBIDFFyc4wUhsfF3jNT85MA
 mdTOec8xiduOwoDQ==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=bqGHECoE;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=QjuUPYIW
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1780644363; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0qPw1IaSk2oUHyFt9atfgvw4vgsM+o6i1yuF73ABbOw=;
 b=bqGHECoEn9hZpzo7jsSTE3hNmjPQ7cxYU2J6ga+LlDxj0wLeOFAsqCGQ4uYWEKliaPjmhh
 1idKIWXNRpK5YVeTdhmfyT5Kd0QV/bf2TctBLhXw/lCRug4aSe+fhGRjgQzEEf2oi2Vfd6
 QRl2TFQL1vuARLNgNeW1O3zcXWAW08c=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1780644363;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=0qPw1IaSk2oUHyFt9atfgvw4vgsM+o6i1yuF73ABbOw=;
 b=QjuUPYIWnLXxU5qaL0fNKGSYpeE2/eIjUsDJWjscox9nt7QVIiB7m+TEgWxthuEhJR6jhu
 UX119Orl4fwos4BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 72EB0779A8;
 Fri,  5 Jun 2026 07:26:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id d7bfGgt6Imo2LwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 05 Jun 2026 07:26:03 +0000
Date: Fri, 5 Jun 2026 09:26:02 +0200
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
Message-ID: <20260605072602.GA268798@linux.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Rspamd-Queue-Id: D57146B139
X-Spamd-Result: default: False [-4.51 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[]; FUZZY_RATELIMITED(0.00)[rspamd.com];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch]; TO_DN_SOME(0.00)[];
 MIME_TRACE(0.00)[0:+]; MISSING_XM_UA(0.00)[]; ARC_NA(0.00)[];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url,suse.de:dkim,gitlab.freedesktop.org:url,imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
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

Hi Dave, Sima,

this is the weekly fixes PR from DRM misc.

Best regards
Thomas

drm-misc-fixes-2026-06-05:
Short summary of fixes pull:

dumb-buffer:
- remove strict limits on buffer geometry

ethosu:
- reject unsupported NPU_OP_RESIZE
- fix index of IFM region
- fix weight index
- fix overflows in DMA-size calculations
- reject DMA commands with uninitialized length
- fix OOB write in ethosu_gem_cmdstream_copy_and_validate

imx:
- fix kernel-doc warnings

ivpu:
- add overflow checks in firmware handling and get_info_ioctl

v3d:
- wait for pending L2T flush before cleaning caches
- fix leak of vaddr
- skip CSD when it has zeroed workgroups
- fix ref counting in performance monitoring
The following changes since commit 5ab62dd3687bcc2cc542b99385aabac5c996db6f:

  drm: prevent integer overflows in dumb buffer creation helpers (2026-05-29 08:30:47 +0200)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-06-05

for you to fetch changes up to c0837b9cf6eabbad8b8cbddaff1a46a6d0a2e29d:

  accel/ethosu: fix OOB write in ethosu_gem_cmdstream_copy_and_validate() (2026-06-04 22:07:59 -0500)

----------------------------------------------------------------
Short summary of fixes pull:

dumb-buffer:
- remove strict limits on buffer geometry

ethosu:
- reject unsupported NPU_OP_RESIZE
- fix index of IFM region
- fix weight index
- fix overflows in DMA-size calculations
- reject DMA commands with uninitialized length
- fix OOB write in ethosu_gem_cmdstream_copy_and_validate

imx:
- fix kernel-doc warnings

ivpu:
- add overflow checks in firmware handling and get_info_ioctl

v3d:
- wait for pending L2T flush before cleaning caches
- fix leak of vaddr
- skip CSD when it has zeroed workgroups
- fix ref counting in performance monitoring

----------------------------------------------------------------
Andrzej Kacprowski (3):
      accel/ivpu: Add bounds check for firmware runtime memory
      accel/ivpu: Add bounds checks for firmware log indices
      accel/ivpu: Add buffer overflow check in MS get_info_ioctl

Maíra Canal (4):
      drm/v3d: Wait for pending L2T flush before cleaning caches
      drm/v3d: Fix vaddr leak when indirect CSD has zeroed workgroups
      drm/v3d: Skip CSD when it has zeroed workgroups
      drm/v3d: Fix global performance monitor reference counting

Muhammad Bilal (6):
      accel/ethosu: fix IFM region index out-of-bounds in command stream parser
      accel/ethosu: reject NPU_OP_RESIZE commands from userspace
      accel/ethosu: fix wrong weight index in NPU_SET_SCALE1_LENGTH on U85
      accel/ethosu: fix arithmetic issues in dma_length()
      accel/ethosu: reject DMA commands with uninitialized length
      accel/ethosu: fix OOB write in ethosu_gem_cmdstream_copy_and_validate()

Thomas Zimmermann (1):
      drm/dumb-buffer: Drop buffer-size limits for now

Yicong Hui (1):
      drm/imx: Fix three kernel-doc warnings in dcss-scaler.c

 drivers/accel/ethosu/ethosu_gem.c      | 35 +++++++++++++++++++++++++---------
 drivers/accel/ivpu/ivpu_fw.c           | 16 ++++++++++++++++
 drivers/accel/ivpu/ivpu_fw_log.c       |  5 +++++
 drivers/accel/ivpu/ivpu_ms.c           |  7 +++++++
 drivers/gpu/drm/drm_dumb_buffers.c     |  7 -------
 drivers/gpu/drm/imx/dcss/dcss-scaler.c |  3 +++
 drivers/gpu/drm/v3d/v3d_gem.c          |  8 ++++++++
 drivers/gpu/drm/v3d/v3d_perfmon.c      | 24 ++++++++++++++++++-----
 drivers/gpu/drm/v3d/v3d_sched.c        | 17 ++++++++++++++---
 9 files changed, 98 insertions(+), 24 deletions(-)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Jochen Jaser, Andrew McDonald, Werner Knoblich, (HRB 36809, AG Nürnberg)
