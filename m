Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDE66606A32D
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 07:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=dSEJpRR2;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=156R02CW;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=I5yRa4ck;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=eIwsP+aH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB18110E781;
	Fri, 13 Nov 2026 07:44:54 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4ED2B10E781;
 Fri, 13 Nov 2026 07:44:43 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id AD3AF1F387;
 Fri, 13 Nov 2026 07:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794555881; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WZCdB74m6mtnGdhOfALkyhQpNzTwUxNP7Fb/hLK6Ss4=;
 b=dSEJpRR2k1JPaiV48mVyU1dVa81HSRKZam55lLaP/btMEUwKxYfly2Bgf4fsYtyYNY/uEx
 MpWVv6wVsz+FdOmdTUsQ2/x2iaZKdoSJVhfAaGSQT5iBpPdr2Yox0KBpXZtt2nrZHJS9Dq
 b4lD9F7hsfBaSI8mDF9E2FmsCcXjEfc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794555881;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WZCdB74m6mtnGdhOfALkyhQpNzTwUxNP7Fb/hLK6Ss4=;
 b=156R02CWqC3PgRfC++wbkHvwOYKd1kwu08/+CkCW2KN45/ETZrpj5RIIkFt2/UinKDTY8J
 iI7JWHeIHOuA2AAQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1794555880; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WZCdB74m6mtnGdhOfALkyhQpNzTwUxNP7Fb/hLK6Ss4=;
 b=I5yRa4ckLrcD14/dpHZqeMF013jQiNbt+GlFfthEfA9PVWvopnDs96LSTmdnuHkNVzNLk3
 GPBU5JC3OUwx9yB7zKdvEXOkNKJaAt/CWdonMM/1dDvcr1rr1IsaLBSWOUu+wPb7ts0v4X
 nbZp/fQXbPjbteNJGl8T+DiE+z9Zi7w=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1794555880;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WZCdB74m6mtnGdhOfALkyhQpNzTwUxNP7Fb/hLK6Ss4=;
 b=eIwsP+aHGE8BOA2CjxWbOx0K4p+NsmtYqYiyI9XqNI9c37lDohrRF7D/TVgzWLFZbP3HEQ
 +xc8MYJeeoOjEGAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 25BA11344A;
 Fri, 13 Nov 2026 07:44:40 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id eCXKAei/9mr4UwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 13 Nov 2026 07:44:40 +0000
Date: Fri, 13 Nov 2026 08:44:38 +0100
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
Message-ID: <20261113074438.GA14592@linux.fritz.box>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-13.30 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MIME_TRACE(0.00)[0:+]; RCVD_VIA_SMTP_AUTH(0.00)[];
 MISSING_XM_UA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 ARC_NA(0.00)[]; FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, gitlab.freedesktop.org:url,
 imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30
X-Spam-Level: 
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

this is the drm-misc-fixes PR for this week.

Best regards
Thomas

drm-misc-fixes-2026-11-13:
Short summary of fixes pull:

bridge:
- ssd2825: Fix panel enable sequence
- sii902x: validate I2S data lane values

display:
- hdmi: Fixes to SCDC

gud:
- Avoid divide error in gud_stats_debugfs

meson:
- load ENCL gamma table while ENCL is disabled

nouveau:
- disp: Set atomic functions in struct drm_mode_config_funcs
- gsp: Handle only IRQs routed to host

panfrost:
- Fixes to perfcnt

sched:
- Ensure stopped entity cannot be re-added to the run-queue

vc4:
- Fix firmware reference leak
- Hold runtime PM reference while allocating the binner BO
- Rebuild V3D interrupt mask on every power transition
- Re-enable the V3D interrupt after a GPU reset
The following changes since commit 19e67d977d3d4d0c54f03906ef578578190db9e1:

  Merge tag 'amd-drm-fixes-7.4-2026-11-05' of https://gitlab.freedesktop.org/drm/amdgpu/kernel into drm-fixes (2026-11-06 10:43:59 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-11-13

for you to fetch changes up to bafda823590ddf7031ecb765d673572fae7ab44a:

  drm/vc4: Re-enable the V3D interrupt after a GPU reset (2026-11-12 08:47:36 -0300)

----------------------------------------------------------------
Short summary of fixes pull:

bridge:
- ssd2825: Fix panel enable sequence
- sii902x: validate I2S data lane values

display:
- hdmi: Fixes to SCDC

gud:
- Avoid divide error in gud_stats_debugfs

meson:
- load ENCL gamma table while ENCL is disabled

nouveau:
- disp: Set atomic functions in struct drm_mode_config_funcs
- gsp: Handle only IRQs routed to host

panfrost:
- Fixes to perfcnt

sched:
- Ensure stopped entity cannot be re-added to the run-queue

vc4:
- Fix firmware reference leak
- Hold runtime PM reference while allocating the binner BO
- Rebuild V3D interrupt mask on every power transition
- Re-enable the V3D interrupt after a GPU reset

----------------------------------------------------------------
Adrián Larumbe (1):
      drm/panfrost: Fix race when restoring reset state in perfcnt

Boris Brezillon (1):
      drm/panfrost: Enable cycle counting when perfcnt is enabled

Cristian Ciocaltea (3):
      drm/display: hdmi: Prevent NULL pointer dereference in sync_scdc()
      drm/display: hdmi: Use committed state to decide on SCDC resync
      drm/display: hdmi: Reset sink scrambling on non-scrambled modesets

Dave Airlie (1):
      drm/nouveau/disp: Set drm_mode_config_funcs.atomic_(check|commit) (attempt 2)

Hamza Mahfooz (1):
      MAINTAINERS: add myself as a maintainer for the Hyper-V DRM driver

Joe Finzel (1):
      drm/nouveau/gsp: only handle GSP interrupts routed to the host

Maíra Canal (3):
      drm/vc4: Hold a runtime PM reference while allocating the binner BO
      drm/vc4: Rebuild the V3D interrupt mask on every power transition
      drm/vc4: Re-enable the V3D interrupt after a GPU reset

Pengpeng Hou (1):
      drm/bridge: sii902x: validate I2S data lane values

Shigeaki Asai (1):
      drm/meson: encoder_dsi: load ENCL gamma table while ENCL is disabled

Svyatoslav Ryhel (1):
      drm/bridge: ssd2825: Fix panel enable sequence

Tvrtko Ursulin (1):
      drm/sched: Ensure stopped entity cannot be re-added to the run-queue

Wentao Liang (1):
      drm/vc4: Fix firmware reference leak in vc4_hvs_bind()

YuanZhe Liu (1):
      drm/gud: avoid divide error in gud_stats_debugfs

 MAINTAINERS                                        |  1 +
 drivers/gpu/drm/bridge/sii902x.c                   |  8 ++-
 drivers/gpu/drm/bridge/ssd2825.c                   |  9 +++
 drivers/gpu/drm/display/drm_hdmi_helper.c          | 65 +++++++++++++++++-----
 drivers/gpu/drm/gud/gud_drv.c                      | 13 ++++-
 drivers/gpu/drm/meson/meson_encoder_dsi.c          |  2 +-
 .../gpu/drm/nouveau/include/nvkm/engine/falcon.h   |  1 +
 drivers/gpu/drm/nouveau/nouveau_display.c          | 11 +++-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga100.c    |  1 +
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/ga102.c    |  1 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/gsp.c  |  4 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/tu102.c    |  1 +
 drivers/gpu/drm/panfrost/panfrost_gpu.c            |  7 +--
 drivers/gpu/drm/panfrost/panfrost_perfcnt.c        | 18 +++---
 drivers/gpu/drm/scheduler/sched_rq.c               |  7 +++
 drivers/gpu/drm/vc4/vc4_hvs.c                      | 18 +++---
 drivers/gpu/drm/vc4/vc4_irq.c                      | 42 +++++++-------
 drivers/gpu/drm/vc4/vc4_v3d.c                      |  8 ++-
 18 files changed, 153 insertions(+), 64 deletions(-)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
