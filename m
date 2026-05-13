Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1247ECD4F21
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 17:50:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6BF7710EFB9;
	Wed, 13 May 2026 17:50:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WGdjWHHC";
	dkim-atps=neutral
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com
 [209.85.221.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C40B710EFED
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 17:50:17 +0000 (UTC)
Received: by mail-wr1-f49.google.com with SMTP id
 ffacd0b85a97d-44a7c719151so692842f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 10:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778694616; x=1779299416; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qH/V54VhhqPOZledFsLbM+R0VpSJHUS2eyEFY9ZqlwU=;
 b=WGdjWHHCH+KjBCGLaqxf35P01XmiCQNQI/DCKZQBIEjkQGMR4xKlUarPxsiw87DxaR
 czcL2lz6a5lOl275qPcNwilpH9M7HA3+BLdfGUNi4XyFVzNQs76Myd+wwh6AP7EDVQtV
 2Q5ixFpTLlJsRVTzthKzlBcQ7My9VGVuHfGTS9DOx8DGFmHKemswSkhNSm/rrx1G/Q/6
 MXw5/+2PjhIh318IoIiK81too9Oe2wYJfmTouVTylKqWDTb6IK3/RZBG+0PxWm4HSpHZ
 snSxxkqjh7E6USD6SEWKKI8c4HnEBBbbMhMVJydCrPXCE3+mQqnAdvyN3l9PKyIqX3Jb
 N6bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778694616; x=1779299416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qH/V54VhhqPOZledFsLbM+R0VpSJHUS2eyEFY9ZqlwU=;
 b=r76Brh2IR2tZ8Y6L79DkXkwzfEPUWnNEYhVusn8doZdddfcY8DZ4ibDfmOwyzHSrma
 IEvaH7MV8VDkL8IyxL0Iu75l2aThWr6d8Pr/5g7cPdo95TIfbtDEzBKBOLB3nt819w4w
 qVUHX6bPfZyOt5pSdn+3kj5ElMJ/AJcOU7ScL9QBSrFYevoRFMH+LtLDBJ7u7z+YpOUR
 9jI4aVDVdxIKOlgNhWMJvPWLo0pJHdaXf+e5YXY9HLEOmqUlUzMLNlKr+vIIFiZ8zx2Y
 pBFNWEdByZXU9Azfq/o69t9P9FCt76SDuCC/kE3U/A3jc80V32bA31pTQPPPOmRDMSPt
 SRPA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PisLbjIHkfRju7IlHwibOMl9kCggjz+57SHxmHioB13pUTmU5YbXcOR26qwKo/Afn4z0/x/bTz08=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZjdIfY5EKyaJs4AR/igiKvQOWRtC1xFKhHUX0ExOWLEyBw81L
 k73C6o76SW8uYWtQ8knsEN2rEh+3RwC8dEwP7pEZXSmYAvozoSzaGxpP
X-Gm-Gg: Acq92OGu1ZcgDcW/hnb3Ki7zfe+5/nLtbwARUux2BjNmHYK5dfyaZtTASl29U3d6Rcg
 2bfZQvOFWC/mhbGhK4rjNBHqaMXlSmWOibU469CTdmxnCYttnCXioNcEbFrzeqoVr2vMg+SiPSu
 1MVAE9KQ3vIICF8H/NUBZu25rKq69vVbK3X+iY3vi8BZ24R6l/xr2NAwwHMfOEmStt+FlzPI9zg
 lJAjidpzhJ7+1bpigAUYMnmOAtpLD83xoFv36qh9yxApYKyf7iH2zTTQSAVujqxr/My8O0eRu7g
 MSs9lgxlYCotYFLa2a8wAUMXtYxLbTrKucmfgcFw8eTkQY2YTzmHhloPf2exH+O3QZAzbVhxpKo
 pE6Ky74EKOBudlk+SeDXVtDIVrW1a7BzNb8XksfsWYZRCHTuxdvKnqH5ssum9IdKbIGGTRueMcC
 V2+K2pCR7TBYIymiNQDpWWpYTzgXVC+PqKoh9WJhg1PglsPKAjFzYb46CAHidFRl5GnRgiK5KJu
 W4f7FdmTEiLNNYO+45J37PmhQ==
X-Received: by 2002:a05:6000:29d1:b0:456:3af2:852e with SMTP id
 ffacd0b85a97d-45c58b6782cmr2147922f8f.1.1778694616038; 
 Wed, 13 May 2026 10:50:16 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-214.um39.pools.vodafone-ip.de. [109.193.28.214])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe13a7sm486730f8f.29.2026.05.13.10.50.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:50:15 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
To: nouveau@lists.freedesktop.org
Cc: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Marek Czernohous <marek@czernohous.de>
Subject: [PATCH 0/2] drm/nouveau: nv04 FIFO cleanup + recovery for Tesla
Date: Wed, 13 May 2026 19:50:11 +0200
Message-ID: <20260513175014.96599-1-marek@czernohous.de>
X-Mailer: git-send-email 2.53.0
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

Hi all,

Two-patch series for the legacy nv04_fifo path covering Tesla
(MCP77/MCP79 and G80-GT218). Daily-driven on the reference NVAC
hardware (Apple Mac mini Late 2009, GeForce 9400M) since 2026-05-05.

Patch 1 demotes a benign CACHE_ERROR that fires once per Mesa session
start on Tesla GPUs. The Mesa NV50 userspace driver issues a method-
0x0060 / data-0xbeef02xx binding probe that recovers cleanly via
nv04_fifo_swmthd(), but currently logs at error level on every X or
Wayland session, dominating dmesg noise on this hardware class. This
clears the channel for patch 2 to identify real faults from noise.

Patch 2 adds a two-tier fault-recovery path for Tesla FIFO faults:

  Tier 1 (per fault). Look up the channel via nvkm_chan_get_chid,
  call nvkm_chan_error(chan, true), fire tracepoint
  nouveau:fifo_chan_killed. Idempotent through the existing
  chan->errored short-circuit.

  Tier 2 (sliding window). When the per-fifo fault count in a
  configurable window reaches the threshold, schedule a worker that
  calls drm_dev_wedged_event(drm, DRM_WEDGE_RECOVERY_REBIND, NULL)
  and fires tracepoint nouveau:fifo_dev_wedged. Worker context is
  needed because kobject_uevent_env may sleep.

Motivation: Fermi+ gets channel-kill and device-wedge automatically
through nvkm_runl_rc; Tesla was feature-frozen before the DRM wedge
uAPI existed. Three observable consequences on the reference
hardware:

  1. Silent state corruption (channel produces wrong output after a
     fault, no notice to userspace).
  2. Observability gap (no counters, tracepoints, or wedge event,
     only dmesg).
  3. Repeated-fault loop (the log-and-reset cycle repeats forever on
     a persistently faulting channel instead of killing it).

Validation. A debugfs fault-injector (kept on a separate
DO-NOT-MERGE branch, not part of this submission) was used to drive
both Tier-1 and Tier-2 paths through their full state space. Phases
1-5 of the test plan were exercised that way. Phase 6 (no manual
injection, real workload soak) ran 2026-05-05 through 2026-05-13:
one organic DRM_WEDGE_RECOVERY_REBIND event was captured on
2026-05-05 09:08; the rest of the soak was fault-free.

Companion userland tool nouveau-pstate-daemon v0.2.0 [1] subscribes
to the WEDGED=rebind uevent in log-only mode and was used to confirm
end-to-end propagation through udev.

Module parameters:

  nouveau.fifo_wedge_count     (uint, 0..32, default 10)
  nouveau.fifo_wedge_window_ms (uint, 100..600000, default 60000)

Setting fifo_wedge_count=0 disables Tier-2 entirely while keeping
Tier-1 channel-kill active.

A note on MAINTAINERS. The series adds a new file
drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c. The change is
covered by the existing nouveau MAINTAINERS section
(drivers/gpu/drm/nouveau/), so no MAINTAINERS update is included.
checkpatch.pl flags this as a hint; it is not load-bearing.

This is a follow-up to the April 9 NVAC stability series [2], which
is still awaiting review. The two patches here are independent of
that series and apply against current Linus master.

[1] https://github.com/hibbes/nouveau-pstate-daemon (v0.2.0)
[2] https://lore.kernel.org/dri-devel/20260409-nouveau-nvac-stability-series

Marek Czernohous (2):
  drm/nouveau/fifo/nv04: filter benign CACHE_ERROR from Mesa NV50 bind
    probe
  drm/nouveau/fifo: add recovery path for Tesla cache_error/dma_pusher

 .../drm/nouveau/include/nvkm/engine/fifo.h    |  12 ++
 .../include/trace/events/nouveau_fifo.h       |  58 +++++++++
 drivers/gpu/drm/nouveau/nouveau_drm.c         |  29 +++++
 .../gpu/drm/nouveau/nvkm/engine/fifo/Kbuild   |   1 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/base.c   |   3 +
 .../gpu/drm/nouveau/nvkm/engine/fifo/nv04.c   |  29 ++++-
 .../gpu/drm/nouveau/nvkm/engine/fifo/priv.h   |  10 ++
 .../drm/nouveau/nvkm/engine/fifo/recover.c    | 121 ++++++++++++++++++
 8 files changed, 257 insertions(+), 6 deletions(-)
 create mode 100644 drivers/gpu/drm/nouveau/include/trace/events/nouveau_fifo.h
 create mode 100644 drivers/gpu/drm/nouveau/nvkm/engine/fifo/recover.c


base-commit: 1f63dd8ca0dc05a8272bb8155f643c691d29bb11
-- 
2.53.0

