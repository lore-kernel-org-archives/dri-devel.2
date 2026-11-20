Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4F3606A320
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 08:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=qHj63Ygz;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=8Ci/8ssJ;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=S6zK4dt2;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=JOAwInU+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A47D1121DB;
	Fri, 20 Nov 2026 08:09:20 +0000 (UTC)
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B987710EDE2;
 Fri, 20 Nov 2026 08:09:08 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 5352B1F849;
 Fri, 20 Nov 2026 08:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795162147; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zC2p19q+ddPWqeKe0VI7DOCr5lxbNH/oqn3dQkp8Ahc=;
 b=qHj63YgzbqDQz4OB4HABRn4s9uxHIPzkMqWwetAPoNiWaeiw1ynrw1qS4CXZlIMOC69OYj
 BK1HbQyRdMX+V1iZblNjIRfRGQ4pjHRJJmSzGQrluHG3xFAG4sVEfPridMjrVC1DQuVErX
 ggIbzE2+x5EMwZUET+2CUS9eb+2i5XM=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795162147;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zC2p19q+ddPWqeKe0VI7DOCr5lxbNH/oqn3dQkp8Ahc=;
 b=8Ci/8ssJ2UrU+ic5ruoW/U4mgVarfpnnpPhiwnVqUlOlqUXSdcqZYqE/lPzRtTO/3DfBiv
 XtVYPDlXCjHffCAg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1795162145; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zC2p19q+ddPWqeKe0VI7DOCr5lxbNH/oqn3dQkp8Ahc=;
 b=S6zK4dt2o0HSYvpsCCuYAN2AjMiBjuzwg2ghYxqcpfl1J/ys0udQMC/pE+3E/+rHKuJhf2
 jEUgkU8lholPNEum7X0neGxNTEjN83o3ttU5Pm/svO2JZ5Q0Gpkk2UyUwTUYk19bBhchcW
 CSWNBspygGaIrKMFsaQqe2Yply5nn6Y=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1795162145;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zC2p19q+ddPWqeKe0VI7DOCr5lxbNH/oqn3dQkp8Ahc=;
 b=JOAwInU+yJaMAZzmWKq4otoQ1437zB/n7vr6sZf1kNOi7kql5nZ10fdwNuHpgrz5QRuzCv
 +TgqC11UD6Zt4yBw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id B05651348F;
 Fri, 20 Nov 2026 08:09:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id Rmd3FyAAAGsqJgAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Fri, 20 Nov 2026 08:09:04 +0000
Date: Fri, 20 Nov 2026 09:09:03 +0100
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
Message-ID: <20261120080903.GA18643@linux.fritz.box>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Level: 
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
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:url, imap1.dmz-prg2.suse.org:helo,
 gitlab.freedesktop.org:url]
X-Spam-Score: -13.30
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

here's the weekly drm-misc-fixes update. People let their LLMs loose
on out tree and the resulting PR is rather large this week. Apart from
the driver fixes, there are several changes to MAINTAINERS.

Best regards
Thomas

drm-misc-fixes-2026-11-20:
Short summary of fixes pull:

core:
- syncobj: Limit allocations
- vblank: Resolve deadlock in timer

imagination:
- Use correct function for polling non-iomem

ivpu:
- Fix race condition in recovery

nouveau:
- Fix instmem io_mapping faults and slowdowns

omap:
- dss: Fix handling deferrals

qaic:
- Harden ioctl checks

rocket:
- Many fixes throughout driver

tilcdc:
- Fix drvdata in suspend/resume

vc4:
- Many fixes throughout driver

vmwgfx:
- Many fixes throughout driver
The following changes since commit bafda823590ddf7031ecb765d673572fae7ab44a:

  drm/vc4: Re-enable the V3D interrupt after a GPU reset (2026-11-12 08:47:36 -0300)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-11-20

for you to fetch changes up to af1cf92e8617a7f7aa24b415596cbf64b76a12e7:

  drm/vc4: Clear the slice caches before resetting a stalled GPU (2026-11-19 10:40:54 -0300)

----------------------------------------------------------------
Short summary of fixes pull:

core:
- syncobj: Limit allocations
- vblank: Resolve deadlock in timer

imagination:
- Use correct function for polling non-iomem

ivpu:
- Fix race condition in recovery

nouveau:
- Fix instmem io_mapping faults and slowdowns

omap:
- dss: Fix handling deferrals

qaic:
- Harden ioctl checks

rocket:
- Many fixes throughout driver

tilcdc:
- Fix drvdata in suspend/resume

vc4:
- Many fixes throughout driver

vmwgfx:
- Many fixes throughout driver

----------------------------------------------------------------
Aldo Ariel Panzardo (3):
      drm/vmwgfx: return an error when a shared GB surface has no backup buffer
      drm/vmwgfx: close TOCTOU on guest_memory_bo in surface reference ioctl
      drm/vmwgfx: do not hand the embedded sg_table to the PRIME core

Andreas Kemnade (1):
      drm/omap: dss: fix handling deferrals

Chaoyi Chen (1):
      accel/rocket: Fix the extra iommu_group_get call in rocket_job_handle_irq

Dan Carpenter (1):
      drm/vmwgfx: Fix NULL vs error pointer bug in vmw_prime_import_sg_table()

Fei Yu (1):
      drm/syncobj: Limit the number of handles and use kvmalloc for user-sized arrays

Guangshuo Li (1):
      accel/rocket: put IOMMU domain on BO creation failure

Gyeyoung Baek (1):
      accel/rocket: Fix drm_mm UAF on close vs in-flight job

Haoming Gao (1):
      accel/rocket: publish read fences for input buffers

Heiko Stuebner (1):
      MAINTAINERS: Add two reviewers to the Rockchip DRM entry

Henry Zhang (2):
      drm/vc4: dsi: Register the PHY clock provider with devm
      drm/vc4: dsi: Set the transfer result before completing the transfer

Ian Forbes (2):
      drm/vmwgfx: Never destroy STDU zero's Screen Target
      drm/vmwgfx: Check whether CRTC is active when updating planes

Igor Paunovic (3):
      accel/rocket: release the shared device's devres on teardown
      accel/rocket: number the cores by devicetree position, not bind order
      accel/rocket: request the core clocks by name

Jaeyeong Lee (1):
      drm/vmwgfx: Erase the detached resource entry on resource release

Jiaxing Hu (3):
      accel/rocket: take the completion register writes under job_lock
      accel/rocket: wait for a running IRQ handler before resetting a core
      accel/rocket: let the core suspend after a reset

Karol Wachowski (1):
      accel/ivpu: Defer recovery until probe completes

Luigi Santivetti (1):
      drm/imagination: use appropriate poll function for non-iomem

Markus Schneider-Pargmann (TI) (1):
      drm/tilcdc: Fix suspend/resume drvdata

Maxime Ripard (7):
      MAINTAINERS: Move armada DRM under drm-misc
      MAINTAINERS: Move Keem Bay DRM under drm-misc
      MAINTAINERS: Move Tegra DRM under drm-misc
      MAINTAINERS: Remove Jonas Karlman from bridge reviewers
      MAINTAINERS: Remove Andrzej Hajda from bridge maintainers
      MAINTAINERS: Remove myself for VC4 DRM driver
      MAINTAINERS: Add Dmitry Baryshkov as bridge maintainer

Maíra Canal (7):
      drm/vc4: Drop BO usecnt before releasing the old FB
      drm/vc4: Complete async page flips from an ordered workqueue
      drm/vc4: Look up the async page flip fence before committing the flip
      drm/vc4: Fix off-by-one in the shader record BO handle check
      drm/vc4: Check for a validated shader before reading its thread mode
      drm/vc4: Start shader code at varying offsets in its BO
      drm/vc4: Clear the slice caches before resetting a stalled GPU

Mohamed Ahmed (3):
      drm/nouveau: do not return early from a synchronous VM_BIND
      drm/nouveau/bar: take the GSP-RM flush pointer from the BAR2 io_mapping
      drm/nouveau/instmem: map only the part of BAR2 that is used

Ruben Wauters (1):
      MAINTAINERS: Update Ruben Wauters email address

Thomas Zimmermann (2):
      drm/vblank: timer: Do not block within critical section
      drm/vblank: Cancel vblank timer outside of critical section

Tomas M (1):
      drm/vmwgfx: include legacy hotspots in GB-only cursor images

Tomeu Vizoso (1):
      accel/rocket: Fix up sched array handling on open and close

Triet Hoang (2):
      accel/rocket: Check allocations before use
      accel/rocket: Keep scheduler allocation in rocket_file_priv

Vladimir Popov (1):
      drm/vmwgfx: fix NULL pointer dereference in vmw_validation_bo_fence()

Youssef Samir (1):
      accel/qaic: Harden checks in BO execute and wait IOCTLs

Zack Rusin (11):
      drm/vmwgfx: validate command body sizes before parsing
      drm/vmwgfx: validate backup buffer size in command buffer processing
      drm/vmwgfx: avoid underflow when stripping short GuestInfo replies
      drm/vmwgfx: bound MKSSTAT lengths before rounding to pages
      drm/vmwgfx: keep cursor mappings and pins with each plane state
      drm/vmwgfx: validate GB-only cursor command limits
      drm/vmwgfx: reserve dumb buffers while detaching their surfaces
      drm/vmwgfx: validate the framebuffer selected for cursor updates
      drm/vmwgfx: reserve cursor MOBs before unpinning them
      drm/vmwgfx: log missing primary planes only once
      drm/vmwgfx: log MOB limits outside the manager spinlock

 .mailmap                                           |   1 +
 MAINTAINERS                                        |  14 +-
 drivers/accel/ivpu/ivpu_pm.c                       |   9 +-
 drivers/accel/qaic/qaic_data.c                     |  16 ++
 drivers/accel/rocket/rocket_core.c                 |   4 +
 drivers/accel/rocket/rocket_core.h                 |  14 +-
 drivers/accel/rocket/rocket_drv.c                  | 104 +++++++----
 drivers/accel/rocket/rocket_drv.h                  |  14 +-
 drivers/accel/rocket/rocket_gem.c                  |  33 ++--
 drivers/accel/rocket/rocket_gem.h                  |   4 +-
 drivers/accel/rocket/rocket_job.c                  |  63 +++++--
 drivers/accel/rocket/rocket_job.h                  |   2 +-
 drivers/gpu/drm/drm_syncobj.c                      |  44 +++--
 drivers/gpu/drm/drm_vblank.c                       |  92 +++++----
 drivers/gpu/drm/drm_vblank_helper.c                |  16 ++
 drivers/gpu/drm/imagination/pvr_power.c            |   3 +-
 drivers/gpu/drm/nouveau/nouveau_sched.c            |   6 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c    |   6 +
 drivers/gpu/drm/nouveau/nvkm/subdev/bar/priv.h     |   1 +
 .../gpu/drm/nouveau/nvkm/subdev/gsp/rm/r535/bar.c  |  32 +++-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c |  19 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/instmem/priv.h |   3 +
 drivers/gpu/drm/omapdrm/dss/output.c               |   3 +
 drivers/gpu/drm/tilcdc/tilcdc_drv.c                |   6 +-
 drivers/gpu/drm/vc4/vc4_bo.c                       |  43 ++++-
 drivers/gpu/drm/vc4/vc4_crtc.c                     | 136 +++++++-------
 drivers/gpu/drm/vc4/vc4_drv.h                      |  21 ++-
 drivers/gpu/drm/vc4/vc4_dsi.c                      |   7 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |  20 +-
 drivers/gpu/drm/vc4/vc4_validate.c                 |  15 +-
 drivers/gpu/drm/vc4/vc4_validate_shaders.c         |   7 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c                 |   3 +
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.c       | 166 +++++++++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_cursor_plane.h       |   4 +
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c            | 208 +++++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c                |  17 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_gmrid_manager.c      |  55 +++---
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c                |   6 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_ldu.c                |   3 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_msg.c                |  21 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c           |   1 +
 drivers/gpu/drm/vmwgfx/vmwgfx_scrn.c               |   2 +
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c             |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_stdu.c               |  19 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_streamoutput.c       |   2 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c            |  28 ++-
 drivers/gpu/drm/vmwgfx/vmwgfx_validation.h         |  13 +-
 drivers/gpu/drm/vmwgfx/vmwgfx_vkms.c               |   2 +-
 include/drm/drm_crtc.h                             |   9 +
 include/drm/drm_vblank.h                           |  16 ++
 include/drm/drm_vblank_helper.h                    |   2 +
 51 files changed, 974 insertions(+), 363 deletions(-)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
