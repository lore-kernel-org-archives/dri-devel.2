Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF129C98310
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 08:39:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2569910F3BC;
	Thu, 24 Sep 2026 08:39:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="IRWCsEqM";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="xbXgvQXh";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="12H+XQiK";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="HUdc27WQ";
	dkim-atps=neutral
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 919FA10F3BA;
 Thu, 24 Sep 2026 08:39:27 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 5B09721DFA;
 Thu, 24 Sep 2026 08:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790239161; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l1vrjQOtjrbkZdrXJlaqGMy73rF/8GUwCbUIvNm0hts=;
 b=IRWCsEqMp0SR/w9NqDy29C3Sz/buIjo6fiSHKTH+D0KC5N8r/smSiABizy67/D+jitIJmE
 mZkIOzCamc0p5Kj0B4HoJGeEp6immoH1CPrVVe7kyhdkmASUVxVdcVRh/yO7jRTS6EEjrM
 zYjVVxfK94qhQJG/KF9sCf9/zFHF7So=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790239161;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l1vrjQOtjrbkZdrXJlaqGMy73rF/8GUwCbUIvNm0hts=;
 b=xbXgvQXhWOQqQBwKw4sa6MXcZpxdjpxXrArJVq12VfBYfBZDnvMrBmU4QX8PJ2hDO0dBdK
 B0dCg1im25NlSbCg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1790239157; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l1vrjQOtjrbkZdrXJlaqGMy73rF/8GUwCbUIvNm0hts=;
 b=12H+XQiKMOMrNombudfcCo2dn961Ow45fRwpqQe2NnHFJE91OJEbfQjci9ujLf/21R9WR+
 Qo0b7yzkfaaBO3WVQBuSXbIVF9AHPdDcJn/wP16RXOiy64yr29JBL21JKleo5ijUzwBu9b
 zrLzxGG+M4sS4FkQq+h6Qn9KYfWyRuQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1790239157;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=l1vrjQOtjrbkZdrXJlaqGMy73rF/8GUwCbUIvNm0hts=;
 b=HUdc27WQokx7qAvfFoTqzl6t+7TMLFET4u71br+XMrASMuPc4ihtPwRsulNwcypsvxnSjz
 yUhbFbalUHcT3CBA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id C209513354;
 Thu, 24 Sep 2026 08:39:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id lk9kGbThtGqVZQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 24 Sep 2026 08:39:16 +0000
Date: Thu, 24 Sep 2026 10:39:15 +0200
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
Subject: [PULL] drm-misc-next
Message-ID: <20260924083915.GA22476@2a02-2455-9062-2500-675c-79c-d0b9-221d.dyn6.pyur.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-4.30 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 NEURAL_HAM_LONG(-1.00)[-1.000];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 ARC_NA(0.00)[]; MISSING_XM_UA(0.00)[]; MIME_TRACE(0.00)[0:+];
 RCVD_VIA_SMTP_AUTH(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 FREEMAIL_ENVRCPT(0.00)[gmail.com];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FROM_EQ_ENVFROM(0.00)[]; FROM_HAS_DN(0.00)[];
 TO_DN_SOME(0.00)[]; RCVD_TLS_ALL(0.00)[];
 TO_MATCH_ENVRCPT_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo, suse.com:url,
 gitlab.freedesktop.org:url]
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

here's the drm-misc-next PR for this week. Besides the usual list of
fixes, there's quite some work in the display helpers for better support
of HDMI 2.0. TTM maintainers change.

Best regards
Thomas

drm-misc-next-2026-09-24:
drm-misc-next for v7.4:

Core Changes:

display:
- hdmi: rework SCDC for better HDMI 2.0 support

sched:
- fix run-queue cleanup

ttm:
- changes to MAINTAINERS

Driver Changes:

amdxdna:
- fix buffer-object handling

imagination:
- add job type to pvr_job_submit_fw trace event

mali-dp:
- fix runtime-PM leak

omapdrm:
- dsi: use dev_err()

panel:
- edp: Support CSOT MNE007QB1-1

panthor:
- export scheduling information via debugfs

v3d:
- improve job handling under perfmon

v4:
- reliably reset V3D
- drop brcm,vc4-v3d compatible

virtio:
- fix damage handling
The following changes since commit b0a3a811634aa7422f8a92196db47a06a70bda16:

  Backmerge tag 'v7.3-rc4' into drm-next (2026-09-22 18:35:06 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-next-2026-09-24

for you to fetch changes up to 6e375de99d0c420169481fcd36064177ab55b09d:

  drm/v3d: Skip perfmon serialization while a global perfmon is set (2026-09-23 14:28:57 -0300)

----------------------------------------------------------------
drm-misc-next for v7.4:

Core Changes:

display:
- hdmi: rework SCDC for better HDMI 2.0 support

sched:
- fix run-queue cleanup

ttm:
- changes to MAINTAINERS

Driver Changes:

amdxdna:
- fix buffer-object handling

imagination:
- add job type to pvr_job_submit_fw trace event

mali-dp:
- fix runtime-PM leak

omapdrm:
- dsi: use dev_err()

panel:
- edp: Support CSOT MNE007QB1-1

panthor:
- export scheduling information via debugfs

v3d:
- improve job handling under perfmon

v4:
- reliably reset V3D
- drop brcm,vc4-v3d compatible

virtio:
- fix damage handling

----------------------------------------------------------------
Andreas Kemnade (1):
      drm/omap: dsi: print errors with device prefix

Brajesh Gupta (1):
      drm/imagination: Add job type info to pvr_job_submit_fw trace event

Christian Hergert (2):
      drm/virtio: preserve damage clips for rendered resources
      drm/virtio: Recalculate ignore_damage_clips on every update

Christian König (1):
      MAINTAINERS: change TTM maintainers to Natalie and Arun

Cristian Ciocaltea (22):
      video/hdmi: Introduce HDMI version enum
      drm/connector: hdmi: Handle reset() state allocation failure
      drm/display: hdmi: Rename drmm_connector_hdmi_init() to *_ini2()
      drm/connector: Add drmm_connector_hdmi_init() with new signature
      drm/display: bridge_connector: Convert to drmm_connector_hdmi_init()
      drm/probe-helper: Introduce .force_ctx() connector callback
      drm/connector: Add HDMI 2.0 scrambler infrastructure
      drm/display: scdc-helper: Add macro for connector-prefixed debug messages
      drm/display: scdc-helper: Add helper to set SCDC version information
      drm/display: hdmi: Add HDMI 2.0 scrambling management helpers
      drm/display: hdmi: Advertise SCDC source version when scrambling
      drm/bridge: Remove redundant error check in drm_bridge_helper_reset_crtc()
      drm/bridge: Add bridge ops for source-side HDMI 2.0 scrambling
      drm/display: bridge_connector: Use cached connector status in .get_modes()
      drm/display: bridge_connector: Switch to .detect_ctx() connector helper
      drm/display: bridge_connector: Wire up HDMI 2.0 scrambler callbacks
      drm/display: hdmi-state-helper: Add source TMDS rate validation
      drm/display: hdmi-state-helper: Pass acquire ctx to hotplug helpers
      drm/display: hdmi-state-helper: Add drm_atomic_helper_connector_hdmi_force_ctx()
      drm/display: hdmi-state-helper: Sync SCDC state on hotplug
      drm/display: hdmi-state-helper: Set HDMI scrambling requirement
      drm/display: bridge_connector: Switch to .force_ctx() connector helper

Donggeun Yoo (1):
      drm/sched: Free the run queues at the end of drm_sched_fini()

Erick Karanja (1):
      drm/v3d: Restrict v3d_perfmon_stop_locked() to v3d_perfmon.c

Eva Crystal (1):
      accel/amdxdna: clear the mailbox channel pointer when starting it fails

Julia Lawall (1):
      drm/nouveau/bios/init: drop unneeded semicolon

Lizhi Hou (3):
      accel/amdxdna: Fully initialize map structure before registering notifier
      accel/amdxdna: Fix race between unmap and free BO
      accel/amdxdna: Set HMM_PFN_REQ_WRITE for writable BO faults

Maíra Canal (6):
      drm/vc4: Drop the undocumented brcm,vc4-v3d compatible
      dt-bindings: display: bcm2835-v3d: Add an optional reset line
      drm/vc4: Use the reset controller to recover from a GPU hang
      ARM: dts: bcm2835: Add the V3D reset line
      drm/v3d: Skip perfmon serialization while the device has no perfmon
      drm/v3d: Skip perfmon serialization while a global perfmon is set

Nicolas Frattaroli (1):
      drm/panthor: Display priorities of panthor groups over debugfs

Srinivas Kandagatla (1):
      drm/panel-edp: add CSOT MNE007QB1-1 entry

Taimuraz Kaitmazov (2):
      accel/amdxdna: do not warn when a sync request is rejected
      accel/amdxdna: do not fail a sync for a BO with no debug context

Thomas Zimmermann (1):
      Merge drm/drm-next into drm-misc-next

Wentao Liang (1):
      drm/mali-dp: Fix runtime PM leak in malidp_crtc_atomic_enable()

liupeng (1):
      drm/nouveau: Fix typos in comments

 .../bindings/display/brcm,bcm2835-v3d.yaml         |   3 +
 MAINTAINERS                                        |   5 +-
 arch/arm/boot/dts/broadcom/bcm2835-common.dtsi     |   1 +
 drivers/accel/amdxdna/aie2_message.c               |   1 +
 drivers/accel/amdxdna/amdxdna_gem.c                | 122 ++++-----
 drivers/accel/amdxdna/amdxdna_gem.h                |   3 +-
 drivers/gpu/drm/arm/malidp_crtc.c                  |   1 +
 drivers/gpu/drm/display/drm_bridge_connector.c     | 183 ++++++++-----
 drivers/gpu/drm/display/drm_hdmi_helper.c          | 304 +++++++++++++++++++++
 drivers/gpu/drm/display/drm_hdmi_state_helper.c    |  83 +++++-
 drivers/gpu/drm/display/drm_scdc_helper.c          |  74 +++--
 drivers/gpu/drm/drm_bridge.c                       |   6 +-
 drivers/gpu/drm/drm_bridge_helper.c                |   2 -
 drivers/gpu/drm/drm_connector.c                    | 153 ++++++++++-
 drivers/gpu/drm/drm_probe_helper.c                 |  15 +-
 drivers/gpu/drm/imagination/pvr_trace.h            |  14 +-
 drivers/gpu/drm/nouveau/nouveau_bios.c             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_dp.c               |   2 +-
 drivers/gpu/drm/nouveau/nouveau_exec.c             |   2 +-
 drivers/gpu/drm/nouveau/nouveau_led.c              |   2 +-
 drivers/gpu/drm/nouveau/nvkm/subdev/bios/init.c    |   2 +-
 drivers/gpu/drm/omapdrm/dss/dsi.c                  | 301 ++++++++++----------
 drivers/gpu/drm/panel/panel-edp.c                  |   1 +
 drivers/gpu/drm/panthor/panthor_drv.c              |   1 +
 drivers/gpu/drm/panthor/panthor_sched.c            |  73 +++++
 drivers/gpu/drm/panthor/panthor_sched.h            |   5 +
 drivers/gpu/drm/scheduler/sched_main.c             |   6 +-
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c             |   2 +-
 drivers/gpu/drm/tests/drm_connector_test.c         |  42 +--
 drivers/gpu/drm/tests/drm_hdmi_state_helper_test.c |   2 +-
 drivers/gpu/drm/v3d/v3d_drv.h                      |  16 +-
 drivers/gpu/drm/v3d/v3d_perfmon.c                  |  13 +-
 drivers/gpu/drm/v3d/v3d_submit.c                   |  19 +-
 drivers/gpu/drm/vc4/vc4_drv.c                      |   1 -
 drivers/gpu/drm/vc4/vc4_drv.h                      |  13 +-
 drivers/gpu/drm/vc4/vc4_gem.c                      |  40 +--
 drivers/gpu/drm/vc4/vc4_hdmi.c                     |   4 +-
 drivers/gpu/drm/vc4/vc4_irq.c                      |   7 +-
 drivers/gpu/drm/vc4/vc4_v3d.c                      |  37 +--
 drivers/gpu/drm/virtio/virtgpu_plane.c             |  10 +-
 include/drm/display/drm_hdmi_helper.h              |  15 +
 include/drm/display/drm_hdmi_state_helper.h        |   8 +-
 include/drm/display/drm_scdc_helper.h              |   2 +
 include/drm/drm_bridge.h                           |  49 ++++
 include/drm/drm_connector.h                        | 147 +++++++++-
 include/drm/drm_modeset_helper_vtables.h           |  28 ++
 include/linux/hdmi.h                               |  12 +
 47 files changed, 1407 insertions(+), 427 deletions(-)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
