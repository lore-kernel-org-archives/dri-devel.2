Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F27D606A329
	for <dri-devel@archiver.kernel.org>; Sat, 14 Nov 2026 16:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GI5hNT7U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B3D410F01D;
	Sat, 14 Nov 2026 16:25:01 +0000 (UTC)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com
 [209.85.218.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DE1E110E1EA
 for <dri-devel@lists.freedesktop.org>; Sat, 14 Nov 2026 01:43:57 +0000 (UTC)
Received: by mail-ej1-f50.google.com with SMTP id
 a640c23a62f3a-c506a231b88so266783266b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 17:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794620636; x=1795225436; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pqbc+Iv+L3kyD9FoDQGOW1amYeE8uWPjW4ipo2/GpSE=;
 b=GI5hNT7UFzx2JKPJsLeAZvpeOlXgt8mAnGnT5iXRybSpevVjOkGbDilVFLHFocOfrU
 46fLo6pcuHYwOpBYSfJ2idLLE3khLl3iNMGX1exysu9ZtLsxuyCl6z3VWBjNHFiO9hFy
 UP/3Gmqzi2YXEiQv2TcnwiaB6QMyal+RYCDC41tJYVX/4ddBELMrZzfIDixMZXhpMAnl
 PIw+E2sDrrPBBGPsAylGQlOiDNNccQ3tTx8S4iFndXjYVjtjllq+1sc4+NnEN5oo2qbS
 UuHNGT7EeE+dntd10oot32KCbadqBxud5J/SakavezW1+Yq4b4Et6S4ksHuxxZzdXX37
 2q4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794620636; x=1795225436;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pqbc+Iv+L3kyD9FoDQGOW1amYeE8uWPjW4ipo2/GpSE=;
 b=sycvs0BAeBUVVwkvkFKmCIDBvunQaxVXXqOZlWW2wj5XHCOJQVXe26lF1j5iSUzEEr
 cdjwAYNxQwBg8LVegGmUXqFKuY8e19w8mZP5cAQC3bR5THykU3EhuGGZpA5EERmZE1aK
 IDHk3IalPNWne1Wc2/uxhXOi4AOPV2E3fcRpkd/5oH37y+z4ur9/qq3/PQeVktlWiErO
 Yt3wVJdAJFQ+3F9YlB91kTTG+WCfmcOFsUzOoI4738aXFhBiW14drkBIzZsy9IZ6T/Rr
 9eQfCmfcTy8hC4yXH5KSWWC36kp+G5c8pXKVWBvWUPow4M6CJZRk6pWPDEGuC0tNHAW7
 NP/w==
X-Forwarded-Encrypted: i=1;
 AL+hErEidsNlf2jQnt9D9fFjUsM4nfVdcn+dVCaAAylypCxOIcX+GWw13IhH5J1RTAgRVdId4P+Pa231rsU=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9sajBsFqCP3Ib1hEvDr17GEU7erHGU54fC4Bh5bj6EYZLk9V+a
 rQuUNI3iTGae7aRroTgykiovypUwkDCYaPznYlPwhWBYPQhRDnDxl3rH
X-Gm-Gg: AYBFou136Q9A/gkAOqtE5oHzWv8qfzhG9BSUYuhgPsdxkoez9zGbHMkcSLwVoAumtUx
 R4hElWnmNerShinJdNk5N3kAGXnGnFWoVW0uu97l4NCnlUTBfJzh9+wvcMdB+jk9JFufHqxOqse
 tetch0iyWOMpqiBIbMwu0XOWpWkGBE6Pq1PPa9ntv3Nc86yhFFR42gd0pmvn68aF9ZqhkjDIlLN
 QCKJld38VP3X54UqosS5paBUNBBCtLVGGNioXtIE6I8G+Y5toPEzxFlI9gwzrDI3MFtVZif5E3v
 BFBuOZ8Cldt0+PPRSh2SCjtbG+O9j75MGjvFvcR1u0zONK3walSS3aYkc7QTQhp/pGNTVqxHSW2
 tq/Cp9tXxb9N+Sd6kqSyR5ZTr2LOJZyMbDw1NXnPus5+bWSRKHLcmI0mCuBk+ivQsRrGodGlZrU
 2Txj9vIyeNfP0rcr/2j7V+/dH1aXkrKzIggEqA28i6azGre16ITotXvV71BlFowdZxOQwaw6CiH
 nzOATq3XKlDgZ+4IONw4MAPM2RXXfZ33cxEOXbwCmV8Y9jeT+NVmjRYeBQULyoE/xr+h4eK3WB7
 /VYpcYqsj5wjFRbaMnvNPITQQ4sCp+vFTqPiWX4psRVYcHeO+uS6D8hF4zXiUXWHKOlphBHR80s
 3BoJUBwN0DdG1A6BK6mYHzig=
X-Received: by 2002:a17:907:1611:b0:c50:564b:c63 with SMTP id
 a640c23a62f3a-c50961d365bmr338389066b.6.1794620636011; 
 Fri, 13 Nov 2026 17:43:56 -0800 (PST)
Received: from SMOK.angora-ide.ts.net
 (mm-156-219-126-178.vitebsk.dynamic.pppoe.byfly.by. [178.126.219.156])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b5a4c1sm161402666b.48.2026.11.13.17.43.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Nov 2026 17:43:55 -0800 (PST)
From: ElXreno <elxreno@gmail.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: jani.nikula@linux.intel.com, rodrigo.vivi@intel.com,
 joonas.lahtinen@linux.intel.com, tursulin@ursulin.net,
 ville.syrjala@linux.intel.com, ankit.k.nautiyal@intel.com,
 mitulkumar.ajitkumar.golani@intel.com, airlied@gmail.com, simona@ffwll.ch,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 ElXreno <elxreno@gmail.com>
Subject: [PATCH 0/7] drm/i915: VRR with the pipe joiner
Date: Sat, 14 Nov 2026 04:43:28 +0300
Message-ID: <20261114014335.2132756-1-elxreno@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sat, 14 Nov 2026 16:24:47 +0000
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
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series allows VRR on modes that need the pipe joiner, such as
3840x2400@240 on the eDP panels of current 18" laptops. So far such
modes are kept on the fixed refresh rate timing generator.

What was missing is the sequencing of the transcoder level VRR
operations (timings, enable, disable, push) against the pipe level
updates of the joined pipes [1][2]; joiner + fixed_rr went in as the
first step [3], commit 0ec46988ae6c ("drm/i915/vrr: Allow fixed_rr
with pipe joiner"). Here the sequencing is done on the MMIO path: all
joined pipes are armed inside one vblank evasion critical section on
the primary, which then sends the push.

Tested on one machine (BOE NE180QA1-MM1 on Arrow Lake-HX, DSC, pipes
A+B) with a backport to 7.3.4. On drm-tip it is build tested only.

 - patches 1 and 2 fix two int overflows that a 2342.4 MHz pixel
   clock runs into
 - patch 3 leaves the VRR timings, enable, disable and push to the
   joiner primary
 - patches 4 and 5 arm all joined pipes inside one vblank evasion
   critical section when VRR is in use, with the push at its end
 - patch 6 makes the per pipe vblank evasion that is left look at the
   scanline counter of the primary
 - patch 7 allows VRR with the joiner and keeps such commits off the
   DSB

Why not the DSB: each pipe runs its own DSB and nothing orders them
against the push. A port that only skips the push on the secondaries
gave "DSB 0 timed out waiting for idle" on the secondary 13 times in
27 minutes, details in patch 7. I don't know whether the DSB of the
primary could write the plane registers of the other pipes, which
would allow one DSB for all joined pipes. If it can, that is the
better end state and I'd be glad to hear it.

Why one critical section: with one evasion per pipe the secondary can
latch at the vmax boundary a frame ahead of the primary. Sampling
PLANE_SURFLIVE of both pipes through MMIO, the halves of the screen
showed different frames for one frame in 9 of 20777 frames over
three runs with the per pipe sections forced.

With the series, same machine and method:

 - no such frame in 18028 frames of plain flips with VRR on, no DSB,
   vblank evasion or push errors
 - the joined critical section takes 15 us on average for the two
   pipes, against the 100 us the evasion allows; 49 of 71983 took 60
   to 188 us on a stalled MMIO write, which the per pipe sections
   without VRR show as well (patch 5)
 - the flip event follows the new surface going live by a median
   12 us, and content at a steady 240 fps is paced at 4.17 ms at p50,
   p95 and p99
 - VRR can be toggled at run time. With LUTs loaded, as here, turning
   it off is a joined commit with the colour DSBs, turning it on
   takes the per pipe sections with the vblank worker

Still on the per pipe sections with VRR and the joiner, and so still
able to latch the pipes a frame apart: modesets, the atomic fallback
of a legacy cursor update, async flips, DDB changes, and commits that
need the vblank worker for the LUT load. On the platforms with double
buffered LUTs the latter stay joined and load the LUTs of all joined
pipes with MMIO inside the critical section, which I could not
measure. LRR and DC balance are kept off with the joiner. The commit
sequence of a joined configuration without VRR and the guardband
computation are not changed.

Not tested: IGT, anything on drm-tip beyond the build (i915 and xe),
LNL and later (PSR/Panel Replay with VRR and their guardband terms,
double buffered LUTs, the always on VRR timing generator), PSR2/Panel
Replay with the joiner, the ultrajoiner, anything but eDP, a colour
update that changes the LUTs while VRR stays on, and the refresh
rate change that patch 1 fixes. Suspend/resume was only run on an
earlier version.

The base EDID range of the panel ends at 120 Hz, 240 Hz is only in
its DisplayID Adaptive-Sync block, so testing this needs "drm/edid:
Read the monitor range from the DisplayID Adaptive-Sync block", sent
separately to dri-devel [4].

On tooling, per Documentation/process/generated-content.rst: this
series was written with an LLM coding assistant (Claude Code). It did
the source and mailing list archive analysis, wrote the patches, the
changelogs and the measurement scripts, and ran the measurements on my
machine under my direction. The scripts are in [5]. I have reviewed
all of it and take responsibility for the result.

[1] https://lore.kernel.org/intel-gfx/20250224061717.1095226-14-ankit.k.nautiyal@intel.com/
[2] https://lore.kernel.org/intel-gfx/Z7N9RHhQDltsygA_@intel.com/
[3] https://lore.kernel.org/intel-gfx/Z78vx24DwelqHTc9@intel.com/
[4] https://lore.kernel.org/r/20261114010749.1949247-1-elxreno@gmail.com
[5] https://gist.github.com/ElXreno/c2e6e6f34b056efaf99c238772cf74a3

ElXreno (7):
  drm/i915/panel: Fix the pixel clock overflow in the VRR vtotal
  drm/i915/vrr: Fix the pixel clock overflow in the vmax computation
  drm/i915/vrr: Leave the transcoder to the joiner primary
  drm/i915: Split intel_update_crtc() into its stages
  drm/i915: Arm joined pipes within one vblank evasion for VRR
  drm/i915: Evade the vblank on the scanline of the joiner primary
  drm/i915/vrr: Allow VRR with the pipe joiner

 drivers/gpu/drm/i915/display/intel_color.c   |   4 +
 drivers/gpu/drm/i915/display/intel_crtc.c    |   2 +-
 drivers/gpu/drm/i915/display/intel_crtc.h    |   1 +
 drivers/gpu/drm/i915/display/intel_display.c | 189 +++++++++++++++----
 drivers/gpu/drm/i915/display/intel_panel.c   |   4 +-
 drivers/gpu/drm/i915/display/intel_vblank.c  |  12 +-
 drivers/gpu/drm/i915/display/intel_vblank.h  |   2 +-
 drivers/gpu/drm/i915/display/intel_vrr.c     |  56 ++++--
 drivers/gpu/drm/i915/display/intel_vrr.h     |   1 +
 9 files changed, 217 insertions(+), 54 deletions(-)


base-commit: f40cc5e715fe9e7a5e61f7cd44f63f68c1625f2c
prerequisite-patch-id: c7f9956bca76130b71364377ca611051a16f466c
-- 
2.56.0

