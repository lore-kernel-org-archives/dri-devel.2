Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95C6606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=ZSAua1Ac;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=76odSSKy;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=AEImqxpM;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=VUxoYqgF
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 244AC10E294;
	Thu,  5 Nov 2026 14:39:30 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 84A7A10E2F3;
 Thu,  5 Nov 2026 14:39:19 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org
 [IPv6:2a07:de40:b281:104:10:150:64:97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id DB80121F3C;
 Thu,  5 Nov 2026 14:39:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793889558; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rJpyyUQDMgKqdh12KLMA9gRwcgdaMEZ473Jmw8fQziI=;
 b=ZSAua1AcIK1yop86/+6QW4s03h8pgdvbWC10Vf8XvTTvB8nyMSMspvKqzRtmed807KMN6t
 jSrtza07BLQvpoJHJpbfqhdhpyiBKBGI2eVsKRmM5qQJqvQKimhiAdKVU7Bwd8I9+/H6Om
 nqZvH/d1+gnPnRCjeBblRDBACH3gewY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793889558;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rJpyyUQDMgKqdh12KLMA9gRwcgdaMEZ473Jmw8fQziI=;
 b=76odSSKyN+ljpV7n7en0oS3kYD/O9xoLWFZdxwegYTc6d42xG4aj3dZ0s7e3lgbE845ljH
 PWg1lWRW2Id4QdAw==
Authentication-Results: smtp-out1.suse.de;
 dkim=pass header.d=suse.de header.s=susede2_rsa header.b=AEImqxpM;
 dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=VUxoYqgF
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1793889557; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rJpyyUQDMgKqdh12KLMA9gRwcgdaMEZ473Jmw8fQziI=;
 b=AEImqxpMfnK11mlhP1OdqJl7omcxMC0i+4onOHolTjrFj2pOZEBbocMeaf8FAHOzDD+kFn
 13pelAQvv+UzntUPRfgCygU/kGVXDWDVs3pv9+wv10cwy8HN+AN1ntOx0zdRuf/cmB7qZw
 8wgzJ0UQs2QQsYZBIztj0XB2/HrOdvU=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1793889557;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=rJpyyUQDMgKqdh12KLMA9gRwcgdaMEZ473Jmw8fQziI=;
 b=VUxoYqgFAPzz2Jy62pjd7O7HSCQPWA2CLfGa8hOjWGWm/qM6eYvM6zwnRDSpi6heD2AyKE
 rn57swKbNUAzxLAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 54899133F6;
 Thu,  5 Nov 2026 14:39:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id b9uAARWV7GoUMwAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Thu, 05 Nov 2026 14:39:17 +0000
Date: Thu, 5 Nov 2026 15:39:15 +0100
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
Message-ID: <20261105143915.GA896462@linux.fritz.box>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: DB80121F3C
X-Spam-Level: 
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-13.51 / 50.00]; SUSE_INTERNAL_BYPASS(-9.00)[];
 BAYES_HAM(-3.00)[100.00%]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 NEURAL_HAM_SHORT(-0.20)[-1.000]; MIME_GOOD(-0.10)[text/plain];
 MX_GOOD(-0.01)[];
 RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from]; 
 RCVD_VIA_SMTP_AUTH(0.00)[]; MISSING_XM_UA(0.00)[];
 ARC_NA(0.00)[]; RCPT_COUNT_TWELVE(0.00)[16];
 MIME_TRACE(0.00)[0:+];
 RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]; TO_DN_SOME(0.00)[];
 RCVD_TLS_ALL(0.00)[]; FROM_EQ_ENVFROM(0.00)[];
 FROM_HAS_DN(0.00)[]; FREEMAIL_TO(0.00)[gmail.com,ffwll.ch];
 RCVD_COUNT_TWO(0.00)[2]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:rdns,imap1.dmz-prg2.suse.org:helo,suse.com:url,suse.de:dkim,gitlab.freedesktop.org:url];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 DKIM_TRACE(0.00)[suse.de:+]
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

here is the PR from drm-misc-fixes for this week. I'm not sure what happened,
but it appears as if we didn't have a -fixes PR in recent weeks. So it's a bit
larger than usual.

Best regards
Thomas


drm-misc-fixes-2026-11-05:
Short summary of fixes pull:

atomic:
- Fix CRTC dma-fence handling

bridge:
- nwl-dsi: Fix LCDIF handling

dma-buf:
- Fix IOVA offset
- Restore the scatter-list entry count before freeing

dp:
- Keep MOT set between messages when no_zero_sized is set

etnaviv:
- Fix NULL dereference in etnaviv_unbind()
- Flush the tile status cache through both the PE and BLT

imagination:
- Align rogue_fwif_hwrtdata to 64 bytes

loongson:
- Fix BO handling in several places

nouveau:
- Map Kepler video engine contexts non-privileged
- Clear use.enabled when subdev init fails
- Avoid running VBIOS twice
- Fix CE channel creation on pre-Kepler GPUs

panel:
- visionox-r66451: Set brightness MSB first; Increase reset waiting time

panic:
- Fix display loop
- Fix line parsing

sched:
- Fix out of bounds entity priority check
- Adjust run-queue when changing priority at runtime

v3d:
- Initialize job timedout_batches
- Fix cache_clean_lock

vc4:
- Move output fence and BO unreserve out of job_lock
- Power down PYH when output is disabled
- hdmi: Fix scrambling
The following changes since commit c347fef5f8f8927985bd67835331ce4cf7ff43a4:

  drm/panthor: fix immortalis condition (2026-10-14 16:57:52 +0100)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/misc/kernel.git tags/drm-misc-fixes-2026-11-05

for you to fetch changes up to 75709a35da45bc67f94c9ceb91bf8871fdfe4d9e:

  drm/sched: Adjust run-queue when changing priority at runtime (2026-11-05 14:35:33 +0100)

----------------------------------------------------------------
Short summary of fixes pull:

atomic:
- Fix CRTC dma-fence handling

bridge:
- nwl-dsi: Fix LCDIF handling

dma-buf:
- Fix IOVA offset
- Restore the scatter-list entry count before freeing

dp:
- Keep MOT set between messages when no_zero_sized is set

etnaviv:
- Fix NULL dereference in etnaviv_unbind()
- Flush the tile status cache through both the PE and BLT

imagination:
- Align rogue_fwif_hwrtdata to 64 bytes

loongson:
- Fix BO handling in several places

nouveau:
- Map Kepler video engine contexts non-privileged
- Clear use.enabled when subdev init fails
- Avoid running VBIOS twice
- Fix CE channel creation on pre-Kepler GPUs

panel:
- visionox-r66451: Set brightness MSB first; Increase reset waiting time

panic:
- Fix display loop
- Fix line parsing

sched:
- Fix out of bounds entity priority check
- Adjust run-queue when changing priority at runtime

v3d:
- Initialize job timedout_batches
- Fix cache_clean_lock

vc4:
- Move output fence and BO unreserve out of job_lock
- Power down PYH when output is disabled
- hdmi: Fix scrambling

----------------------------------------------------------------
André Draszik (2):
      drm/drm_crtc: ensure dma_fence_ops remain valid during device unbind
      drm/drm_crtc: fix race with dma_fence_signal() in ::get_driver_name()

Christian Gmeiner (2):
      drm/etnaviv: Fix NULL dereference on unbind without PPU flop reset
      drm/etnaviv: Flush the tile status cache through both the PE and BLT

Davidlohr Bueso (1):
      dma-buf: validate the attachment before asserting its reservation lock

Devin Wittmayer (2):
      drm/panic: Fix kmsg screen hang on a long log line
      drm/panic: Accept a trailing newline in panic_screen

Dom Cobley (1):
      drm/vc4: hdmi: power down the BCM2712 PHY when the output is disabled

Esben Haabendal (2):
      drm/bridge: nwl-dsi: Cleanup endpoint mux control selection
      drm/bridge: nwl-dsi: Limit LCDIF specific sync override

Evanshenf (3):
      drm/loongson: Fix framebuffer selection in async cursor updates
      drm/loongson: Fix double free on BO initialization failure
      drm/loongson: Handle buffer mapping failures when clearing a BO

Finn Zeruhn (1):
      drm/dp: keep MOT set between messages when no_zero_sized is set

Ilia Mirkin (1):
      drm/nouveau/devinit/gf100-: try to avoid double-running vbios scripts

Jose Maria Casanova Crespo (1):
      drm/v3d: Initialize timedout_batches when running a CSD job

Karl Mehltretter (1):
      dma-buf: keep the DMA flags in the DMABUF_DEBUG copy

Konstantin Sinyuk (1):
      MAINTAINERS: Update habanalabs maintainer contacts and status

Leon Romanovsky (1):
      dma-buf: Restore the scatterlist entry count before freeing

Lucas Tanure (2):
      drm/vc4: hdmi: always cancel the scrambling work synchronously
      drm/vc4: hdmi: enable scrambling before the TMDS clock starts

Maíra Canal (3):
      drm/vc4: Publish the output fence outside of job_lock
      drm/vc4: Drop the BO reservations outside of job_lock
      drm/v3d: Widen cache_clean_lock over the whole L2TCACTL sequence

Michal Wilczynski (1):
      drm/imagination: Align rogue_fwif_hwrtdata to 64 bytes

Munique Feitoza (1):
      drm/nouveau: Fix CE channel creation on pre-Kepler GPUs

Rosen Penev (2):
      drm/nouveau/fifo: map Kepler video engine contexts non-privileged
      drm/nouveau/nvkm: clear use.enabled when subdev init fails

Tvrtko Ursulin (2):
      drm/sched: Fix out of bounds entity priority check
      drm/sched: Adjust run-queue when changing priority at runtime

Vladimir Zapolskiy (2):
      drm/panel: visionox-r66451: Send the brightness value MSB first
      drm/panel: visionox-r66451: Wait longer after the panel reset

Yili Zhang (1):
      dma-buf: Fix IOVA offset when linking phys vecs to sgt

luyuantao (1):
      drm/panic: Fix the loop that causes kmsg to not display correctly

 .mailmap                                           |  2 ++
 MAINTAINERS                                        |  6 ++--
 drivers/dma-buf/dma-buf-mapping.c                  |  8 +++--
 drivers/dma-buf/dma-buf.c                          |  4 +++
 drivers/gpu/drm/bridge/nwl-dsi.c                   | 17 +++++----
 drivers/gpu/drm/display/drm_dp_helper.c            |  3 +-
 drivers/gpu/drm/drm_crtc.c                         | 18 ++++++----
 drivers/gpu/drm/drm_panic.c                        | 12 +++++--
 drivers/gpu/drm/etnaviv/etnaviv_buffer.c           | 40 ++++++++++------------
 drivers/gpu/drm/etnaviv/etnaviv_drv.c              |  6 ++--
 drivers/gpu/drm/imagination/pvr_rogue_fwif.h       |  2 +-
 drivers/gpu/drm/loongson/lsdc_gem.c                | 14 +++++---
 drivers/gpu/drm/loongson/lsdc_plane.c              |  2 +-
 drivers/gpu/drm/loongson/lsdc_ttm.c                | 14 +++++---
 drivers/gpu/drm/loongson/lsdc_ttm.h                |  2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c              |  7 +++-
 drivers/gpu/drm/nouveau/nvkm/core/subdev.c         |  1 +
 drivers/gpu/drm/nouveau/nvkm/engine/fifo/gk104.c   | 13 +++++++
 .../gpu/drm/nouveau/nvkm/subdev/devinit/gf100.c    | 20 +++++++++++
 drivers/gpu/drm/panel/panel-visionox-r66451.c      |  4 +--
 drivers/gpu/drm/scheduler/sched_entity.c           | 29 ++++++++--------
 drivers/gpu/drm/v3d/v3d_gem.c                      |  5 ++-
 drivers/gpu/drm/v3d/v3d_sched.c                    |  2 ++
 drivers/gpu/drm/vc4/vc4_gem.c                      | 14 ++++++--
 drivers/gpu/drm/vc4/vc4_hdmi.c                     | 10 +++---
 drivers/gpu/drm/vc4/vc4_hdmi_phy.c                 |  5 +++
 26 files changed, 172 insertions(+), 88 deletions(-)

-- 
Thomas Zimmermann
Graphics Driver Developer
SUSE Software Solutions Germany GmbH
Frankenstr. 146, 90461 Nürnberg, Germany, www.suse.com
GF: Stefan Gaiser, Jochen Jaser, Abhinav Puri, (HRB 36809, AG Nürnberg)
