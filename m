Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A287C561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:52:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF3DD10E2C3;
	Thu,  6 Aug 2026 08:52:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l5xi+l5T";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C6910E2C3
 for <dri-devel@lists.freedesktop.org>; Thu,  6 Aug 2026 08:52:33 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47debaa89cfso144560f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 06 Aug 2026 01:52:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786006351; x=1786611151; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7S3jJC+DP/AnGr5qI74fY2tvCMpx6q3cXdfEjvlQVLM=;
 b=l5xi+l5TgK7S900g23guaoryepGn9/zfVf3XhFMp44LOwnPue3oe9ffiegEZT1bFIj
 4OwQ56oF6Y68gZiH2ehmhncVWfVSAX3E+UQmb81Ip9tRBTioJtJV0znvd4ZQ/2jhkukm
 NanqTJOt/vQT3qb9DXtpvpIrAXNVr5bEBTm4FH07wBSlYJVMGoEKeGsAW1TABUM+mJmC
 b3tiQVIpKWbJBhbVFfWW6UniTv94XnLDYzCq9ywQhu1mrG+kLRKT0gqNhLo/iyP5+OTH
 ZnOiGKTLMvcC0pNzXFM7wWUzmu2YP4ZUfh8Tw6P/5QtATialWIVB3oTZuA7tljUtJZNb
 sS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786006351; x=1786611151;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7S3jJC+DP/AnGr5qI74fY2tvCMpx6q3cXdfEjvlQVLM=;
 b=FiReVMya/FQF1mnab3plCYheKEwCjIrzOyro1poB9itmkPNXKZIOpEebWNt2NljKdR
 s8lzly4RB1Ta1xLL1qT+kHHnSklcWmtyMJMO73Neu4n/d9gZ7DDFUnaQ33+xd/Hney6S
 EBSZHFFsUv/e8agHPEJGwNbnHRPcxOJhwJmHrOcH2f4MR4V+pnBF/aizsp1ceez7o1/P
 xhBC69/Ro3j5v4HtjB9TmlSheejLlihEDtJDJizYaxscr0ufJf4NI1Zo+1mF7mTI1sf8
 uHCRUBvwmmCUYApMHPlBxnlH1hBlbwITnuSC/4RSI0vHX6DDUHb8SJDdzW7uQiAEsYz5
 O5YQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoihwWLYUVPGKcMiDNFryTxgPyg6Ethgaj0P5bGKnmlSXhccbbM6VyX9wOuNJx3bloiY2BxT/YbcZU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFUYVdBjuimG8NCDcNPQuWpThT++WR56OJRgLqzX/LG3GgoREn
 EaWpbaQXtuHQobriEC01nUasCDX+yHa+0M2r68nG8eH4d+E3n2wOTt3G
X-Gm-Gg: AR+sD10Q0wkZ3qc/7F2KuWGgb787pAqFlFw66w+9DwXK/z9otEfYAM6O6320oBSR2lY
 b4i6WxckT3TWFVKb3LO20PuO1gDod7uHNrQIh//cJl9TeDmWYeYJ+6zPgMjZnI8FAskxkFy8Mjc
 UgDr+vcTKrTF5EUfcnGZNstezc2Mexd8Raj8dYPmiYtS2+vk6vm+RJK69cBl+FegDT5G4l+qthq
 54GlW2lWZ7XJAU/ZceNIRDlMcRBlZT36rL/B4NHfNNCculKRYTyQvqaqfAPTB0epvfHeriYvrNf
 rxJc3dRwH5DenKVP0IYGphv+MfOwtKMP7eZw27cmRnR31LKrz2QVcaFhTxo8z8ZWF7WTA9NdcMM
 fF0CVaBWnf7J3KWGYkcd3PQj+FXgYzCInaZnedNcxPAtePu6cGKlzvPck3j25uG4vyh8In+J4I3
 tdrnA0kbqK6OKjYxA1su6bLH/GVIhJo76Yzx3kAhEOF555U+pn2hwT5T2hbnW6Fltg1VdTa4fL/
 1En6gOnJ/M04n7OrUqHnVEq8+XNiFj0BpqA3EKfh5SwlrszodAYKxo=
X-Received: by 2002:a05:600c:3487:b0:499:52d5:8c14 with SMTP id
 5b1f17b1804b1-49952d58cc4mr36792715e9.1.1786006350885; 
 Thu, 06 Aug 2026 01:52:30 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4995420cb4esm45985355e9.2.2026.08.06.01.52.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2026 01:52:30 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] drm/nouveau: nv04 FIFO cleanup + recovery for Tesla
Date: Thu,  6 Aug 2026 10:52:25 +0200
Message-ID: <20260806085228.1848994-1-mczernohous@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Marek Czernohous <marek@czernohous.de>

v1 of this series is here:

  https://lore.kernel.org/nouveau/20260513175014.96599-1-marek@czernohous.de/

Please do not apply v1. While running it on the reference machine I found
three defects in my own patch, one of which is a guaranteed kernel panic on
exactly the hardware the series targets. v2 fixes all three and adds one new
patch as a prerequisite.

What went wrong in v1, and how v2 addresses it:

1) NULL pointer dereference in interrupt context (fixed in 3/3)

   v1 called nvkm_chan_error(chan, true). nv50 and g84 channels have no
   .preempt callback, and the call in nvkm_chan_error() is guarded only by
   the preempt argument and not by a NULL check, so preempt=true dereferences
   a NULL function pointer under chan->lock in interrupt context.

   This is not theoretical. On 2026-06-02 it fired on the reference machine
   (then running 7.0.10-p1) during a deliberate VRAM stress test, captured
   over netconsole:

     fifo: CACHE_ERROR - ch 2 [labwc[3950]] subc 3 mthd 0f00 data 0000007b
     nv04_fifo_intr_cache_error+0x111
      -> nv04_fifo_recover+0x80
      -> nvkm_chan_error+0x99
     RIP: 0010:0x0

   The oops escalated to a full panic because nouveau's drm_panic scanout
   path ioremaps in panic context:

     nv50_wndw_get_scanout_buffer -> nouveau_bo_map -> ttm_bo_kmap
      -> __ioremap_caller -> __get_vm_area_node
     kernel BUG at mm/vmalloc.c:3212

   That is a separate, pre-existing problem which I have not yet reported;
   I will do so on its own. The hardware watchdog then reset the machine.
   v2 uses preempt=false, which is what the existing caller in
   nvkm_runl_rc() does as well.

2) Killing the channel on the first fault is wrong (fixed in 3/3)

   v1 killed the channel on every fault. But there is a single PFIFO cache
   puller, and on a fault it names the channel that is *resident*, not
   necessarily the one that caused the fault; nv04_fifo_pause() documents
   this ("incorrect instance offsets to PGRAPH"). On the reference machine
   this killed the Wayland compositor twice for somebody else's fault, on
   2026-06-02 and again on 2026-07-22.

   v2 keeps mainline behaviour for the first faults (skip the method or drop
   the push segment and resume) and only escalates to the kill once the same
   channel object has faulted NVKM_FIFO_KILL_COUNT times inside
   NVKM_FIFO_KILL_WINDOW_MS. The streak is keyed on the channel object
   pointer as an identity token, never dereferenced, and dropped in
   nvkm_chan_del() so a reused channel id cannot inherit it.

3) A killed channel is not survivable on Tesla (new patch 2/3)

   This is the reason for the new patch, and it is the part I would most
   like reviewed.

   nouveau_channel_init() only subscribes to the channel-killed event for
   FERMI_CHANNEL_GPFIFO and newer. On Tesla the ERRORED event is therefore
   delivered into an empty notifier list, nouveau_fence_context_kill() never
   runs, and the pending fences of the killed channel are never signalled.

   Today that is harmless upstream, because nothing kills a Tesla channel.
   Patch 3/3 introduces exactly such a caller, so without 2/3 the series
   would trade a recoverable fault for an unrecoverable hang. On the
   reference machine this presented twice as a frozen desktop on a machine
   that was otherwise alive and reachable over ssh. The stacks as observed:

     kworker/u8 events_unbound: dma_fence_default_wait
       <- drm_atomic_helper_wait_for_fences <- nv50_disp_atomic_commit_tail
     12x kworker/uN ttm: dma_fence_default_wait
       <- dma_resv_wait_timeout <- ttm_bo_fini

   The ttm frame is reported as ttm_bo_fini; the wait that actually holds
   those workers is the MAX_SCHEDULE_TIMEOUT one in ttm_bo_delayed_delete,
   which is static and in the same file, so the shortened frame is
   consistent with inlining. Either way both waits are uninterruptible.
   The desktop stayed frozen for minutes until the fences timed out, after
   which a compositor respawn brought the display back; a reboot cleared it
   immediately. Leaving a fence unsignalled also violates the dma-fence
   contract, which is why I think the subscription belongs on NV50+ even
   independently of this series.

Testing

  Reference hardware: Apple Mac mini Late 2009, MCP79 / GeForce 9400M
  (NVAC), Core 2 Duo, Wayland (labwc) on Mesa 26.0.8.

  Fault injection. I restored the debugfs-style fault injector I used for the
  original validation (as a pair of write-only module parameters this time)
  and drove nv04_fifo_recover() directly on a throwaway GL process, so that
  the compositor was never the target:

    ch 5 fault 1/3 in 10000ms window, skipping method and resuming (Tier-0)
    ch 5 fault 2/3 in 10000ms window, skipping method and resuming (Tier-0)
    fifo:000000:0005:0005:[fbo-stress[13247]] errored - disabling channel
    Xwayland[4931]: channel 5 killed!

  (The last line is prefixed with the DRM client rather than the faulting
  process because the test program is an X11 GL client; NV_PRINTK names the
  client that owns the channel.)

  That covers all three defects:

  - The channel survives the first two faults and only the third one inside
    the window escalates, so an unrelated process is no longer killed for a
    fault the puller misattributed.
  - A fault 18 seconds after the previous one counted as 1/3 again, so the
    window expiry works.
  - The "channel N killed!" line is the one that never appeared before patch
    2/3. It proves the event is delivered and the fences of the killed
    channel are signalled: no kworker ended up in dma_fence_default_wait,
    no TTM worker was left in D state (there were twelve during the freeze),
    the compositor kept running, and the display commit never had to fall
    back to any timeout.
  - The victim process died with a SIGSEGV inside libgallium. That is the
    known Mesa nv50 limitation (no GL robustness on this generation), not a
    consequence of these patches.

  What the injection does not cover, to be explicit: it enters the recovery
  path from process context, where the real fault arrives in hard interrupt
  context. The locking is the same, but the context is not, so this is
  functional coverage of the recovery path rather than of the interrupt path.

  Soak. The v1 patches ran on that machine from 2026-05 onwards, which is how
  defects 1 and 2 were found. The v2 code, including the escalation ladder and
  the widened event subscription, has been running since 2026-07-25, twelve
  days as of this posting, across a kernel bump from 7.1.5 to 7.1.6 with the patch
  series unchanged. Since every channel now subscribes to the kill event, the
  interesting long-run question is channel churn, so the soak is ordinary
  daily driving with a browser and GL applications rather than a synthetic
  loop.

  One difference between the soaked code and the diff below, stated so it is
  not a surprise: downstream I carry the widened subscription behind a
  module parameter (default on) so I can fall back to the Fermi+ behaviour
  without rebuilding. Patch 2/3 as posted does it unconditionally. At the
  default the two are behaviourally identical, and that default is what ran
  for those twelve days; the parameter itself is a local debugging aid and I did
  not think it belonged upstream.

  Compile coverage, precisely: the changed translation units build clean in a
  downstream 7.1.6 tree that carries equivalent code. The series is rebased
  onto the mainline base commit below, but I have not built it there, because
  my mainline checkout is sparse. The full module, in the downstream form, is
  built and booted on the reference machine.

  A note on MAINTAINERS. Patch 3/3 adds a new file
  drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c. The change is covered
  by the existing nouveau MAINTAINERS section (drivers/gpu/drm/nouveau/),
  so no MAINTAINERS update is included. checkpatch.pl flags this as a hint;
  it is not load-bearing.

AI assistance

  Lyude asked on the v1 thread whether these patches were written by a human
  and pointed at Documentation/process/coding-assistants.rst. The answer,
  repeated here for the archive: this work is AI assisted. I use Claude
  (claude-opus-4-7 for v1, claude-opus-5 for v2) as a coding and analysis
  assistant. Every patch carries an Assisted-by trailer accordingly, and no
  Signed-off-by is added by the tool.

  Nature of the assistance, so you can calibrate your review: the assistant
  did most of the code archaeology and drafting. I described symptoms
  ("the desktop freezes but the machine is alive", "the compositor gets
  killed for a fault it did not cause"), asked for the mechanism to be
  traced in the source rather than guessed, and asked for each claim to be
  backed by a file and line. The register dumps, kernel stacks and the
  netconsole trace quoted above are measurements from the machine, not
  model output. The assistant also reviewed its own earlier work
  adversarially, which is how defects 2 and 3 were found. I reviewed the
  result, I understand the code, and I take responsibility for it.

  One consequence worth stating: a first draft of this cover letter
  described the fence-context teardown ordering in nouveau_channel_del() as
  a use-after-free worth its own patch. On closer inspection most of that
  window is harmless, because nouveau_fence_context_del() empties the
  pending list before the event is unsubscribed. I dropped that patch rather
  than send an overstated claim. If you would still like the reordering as a
  hardening change, I can send it separately.

Changes since v1

  - new patch 2/3 (subscribe to channel-kill events on NV50+)
  - 3/3: preempt=false instead of preempt=true
  - 3/3: escalation ladder instead of kill on first fault
  - 3/3: per-channel streak dropped in nvkm_chan_del()
  - 3/3: chan_killed tracepoint moved to the actual kill
  - 3/3: comments that had slipped through in German are now in English
  - rebased onto current mainline
  - Assisted-by trailers added, as offered on the v1 thread
  - defects 2 and 3 reproduced and their fixes verified with fault
    injection; defect 1 was reproduced organically before the fix and is
    covered here by the absence of the panic under injection

Marek Czernohous (3):
  drm/nouveau/fifo/nv04: filter benign CACHE_ERROR from Mesa NV50 bind
    probe
  drm/nouveau: subscribe to channel-kill events on NV50 and newer
  drm/nouveau/fifo: add recovery path for Tesla cache_error/dma_pusher

 .../drm/nouveau/include/nvkm/engine/fifo.h    |  31 +++
 .../include/trace/events/nouveau_fifo.h       |  58 ++++++
 drivers/gpu/drm/nouveau/nouveau_chan.c        |   2 +-
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  29 +++
 .../gpu/drm/nouveau/nvkm/engine/fifo/Kbuild   |   1 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/base.c   |   3 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/chan.c   |  14 ++
 .../gpu/drm/nouveau/nvkm/engine/fifo/nv04.c   |  29 ++-
 .../gpu/drm/nouveau/nvkm/engine/fifo/priv.h   |  10 +
 .../drm/nouveau/nvkm/engine/fifo/recover.c    | 176 ++++++++++++++++++
 10 files changed, 346 insertions(+), 7 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/include/trace/events/nouveau_fifo.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c


base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.54.0

