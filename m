Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ADEC5DF94
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 15:23:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE77710E285;
	Fri, 21 Aug 2026 15:23:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WKDWFe+z";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C860D10E285
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 15:23:05 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-c15b51ba80dso10834666b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787325784; x=1787930584; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:cc
 :to:subject:date:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Wt70YXWaIggScCHa2VlJmb1FulxNMTZ4XUn6wxtJEjg=;
 b=WKDWFe+znQBoUFd9BORfLDT+tEIoRUF+noRxN294KS9lW5pxDUTh9ftYV+eJlI/8wE
 T6IRreLW8fFFlOiZMdeLd2CiyJGRVZ+qSvRG0EAiXYR2AAx07zHcUstQfGdlqA7LqOp2
 tjKEU6eTjWCzdkHJsb4Gwqb2AMDoBVkByzdjsFgCmUQqGR+hi3jZUpXNXGUXAsZB77E0
 XBbCr4ISni6LLaR8UFMriGEFxhRk0x1V2+i/yo1zCItuYPEF67xjjEzhMJ6jV4LGwy9r
 SOC3g9m/6OtcnLw/L8085NsZkj92x1tnMXeT8cIKrd6tKssPAhaFNfzTk4WqhH+VJOUd
 8dqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787325784; x=1787930584;
 h=content-transfer-encoding:content-type:mime-version:message-id:cc
 :to:subject:date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Wt70YXWaIggScCHa2VlJmb1FulxNMTZ4XUn6wxtJEjg=;
 b=N0N6RpDDt8Yy5pPVVZ6xgukOGBMFSgXdz0Z33TWbmFX7Dtm6gzQdFmMvanfCTVJCtu
 pc0BW/JcVJQM7XzjkWuaUVWlsR8paUQtklZ2yA2qPk8cMpp/rgJ362hGikV9+LTPXcA9
 7ip7TV1o6QkfYLElGwDkotWL2p9aUc1KtIEwfFSC4AA/ZLIsX1pdB/2BImNI0tmbPn2D
 VVsyXw0mJkxJ4XTVIYygPpOcM1MfPr/s257j40tkmT72BuxVYMBQiQsAmfR5yTHLP85G
 gy1+aKYzIvU736x9kjm9VnTG1SfKn85O04lXpeOMZoRavr1nALT8fnb5667JW/t+B9VA
 mezQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RooOY1XLozmZryMBMmTav3NB7cFvppSvHkgYctfOz/RVpxdsVdLH5D4gBMFIBpE0J3oq/Rpwx6EkHA=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kcmt3FKbJnBUXF58bTg8CFlvxafMdL1rxRoZHxu8Zsol2/c7WN
 fQrMuxMUkAQPeJeFHXomzTvr/9wG/8l2pqKyvPH04sUTQ5HI+C908gLe
X-Gm-Gg: AR+sD12ObdN5+GB8oDBJrHVZgwuZvXzd/0RGqIuVYFWzEXiDK3tN/LNKL7toQjOKIQ/
 tiXMUgG6K+piVHRmEnOzFGkHrOdpT9p19f7WV87zJv0YW7i0NnLY9RfhL2GziIO2G0lLgZNYsws
 g2Hg2iw/NxH1GsTINNwW40KpbhAneQ1TApahcSBZMi4obcAzyLhAByvviGju4SfT87b2ZInMggw
 Tg/SHq4E+wak9aZUH2046QGA9GXAeoyPVCZdX4IMniUwlD8z2j5JhSTPAUaDJFMU8YcUr2hXmT3
 9JrjvyrcDjzXaFTYiOxiWFQxOG39rJI0rdk5KEucQBNVjO7Q/hSKP37wglLaJpl/qP1wG0sU955
 6smUpwxZ21bm+Bh9w3WGCIMSYgfEg9MMpGaz07h/v5QNnm6R5J/VaN+QW8H+d//j+82hvSPqjM9
 2mPClnVbS6zOC/JeTgvb6gWSFGYSaAjaKh8FYg7pz0DKNz2SXMyvNjPFSd7l4MknViI29mDG70s
 wIodave2aC+j8Qlau21E8YZNWnmhkLA3foSSgETxH0/fO4DZVAnX1Ak9ZeMyWpX
X-Received: by 2002:a17:907:97c1:b0:c21:764c:9417 with SMTP id
 a640c23a62f3a-c246a2eb944mr404614866b.1.1787325783909; 
 Fri, 21 Aug 2026 08:23:03 -0700 (PDT)
Received: from [127.0.0.1] (ip-109-193-028-127.um39.pools.vodafone-ip.de.
 [109.193.28.127]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c24591dc662sm506198566b.42.2026.08.21.08.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 08:23:03 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
X-Google-Original-From: Marek Czernohous <marek@czernohous.de>
Date: Fri, 21 Aug 2026 17:23:01 +0200
Subject: [PATCH v4 0/3] drm/nouveau: channel-kill event ordering fixes,
 and lower the gate to NV50
To: nouveau@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Ben Skeggs <bskeggs@redhat.com>
Message-ID: <178732578167.167481.5619512544301226563@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This is v4. v3 is here:

  https://lore.kernel.org/all/20260812231330.705425-1-mczernohous@gmail.com/

Thank you for the review. Changes since v3:

1/3 unchanged, and now carries Lyude's Reviewed-by.

2/3 rewritten. v3 moved the subscription behind context_new(), which
    traded a half-built fence context for a missed kill. Lyude pointed out
    that the subscription does not have to move at all: give the fence
    context a flag and have the two sides hand the kill over.

3/3 is v3's 4/4, unchanged in code. Lyude asked what testing this has had
    on Tesla and said it will need input from others; the testing question
    is answered under Testing below. It is last in the series so it can be
    dropped without disturbing the two fixes, and I am happy for it to
    wait for that input rather than go with them.

Withdrawn since v3

  v3 carried a patch that demoted one specific CACHE_ERROR to debug
  level and attributed it to a Mesa bind probe. I am withdrawing it,
  because that attribution does not survive a look at the tree. Method
  0x0060 on this class is SET_CONTEXT_DMA_SEMAPHORE
  (nvhw/class/cl826f.h), and the writer is the kernel itself,
  nv84_fence_emit32() and nv84_fence_sync32(), on subchannel 0
  (nvif/push006c.h). The data is the VRAM ctxdma handle that Mesa picks
  (nouveau_screen.c, .vram = 0xbeef0201) and the kernel binds at channel
  creation. All 99 logged occurrences behind that patch read "subc 0
  mthd 0060 data beef0201". Mesa's NV50 Gallium never writes on
  subchannel 0. So this is the driver's own semaphore-context rebind
  being rejected by the puller now and then, and I have not established
  why. I will look at it separately rather than carry it here.

On 2/3, and the two places where it differs from the sketch

  The sketch checks chan->killed before setting ->ready, but each side
  has to store its own flag before loading the other's, or one
  interleaving loses the kill even under sequential consistency;
  swapped, with smp_mb() on both sides, it is the store-buffering
  pattern. And the kill side cannot take fctx->lock, because that lock
  is exactly what must not be touched before the context is built, so
  ->ready is a plain bool read outside the lock, published with release
  and read with acquire. The commit message has the full argument.

On the aside about writing the respin without Claude

  This work is AI assisted, as the Assisted-by trailers say.

  The advice is right, and I would rather say so than let it pass. The
  honest position, though, is that I doubt I would have got to these
  bugs at all without the assistance.

Testing

  Reference hardware: Apple Mac mini Late 2009, MCP79 / GeForce 9400M
  (NVAC), Core 2 Duo, Wayland (labwc).

  Build. Built against the base commit named at the end of this mail.
  The nouveau module compiles and links with W=1 and no new warnings.
  checkpatch.pl --strict is clean on all three patches.

  Deliberate channel kills on Tesla, which is Lyude's question on 3/3.

  The kill path on this hardware has been exercised on purpose, not only
  observed, and under a real 3D workload. A local debug patch, which is
  not part of this series, synthesises a CACHE_ERROR on a nominated
  channel. The victim was SuperTuxKart, with its channel live under
  load. Verbatim, timestamps and unrelated lines elided:

    nouveau 0000:02:00.0: fifo: inject:   ch   2 [labwc[5670]] errored 0
    nouveau 0000:02:00.0: fifo: inject:   ch   3 [labwc[5670]] errored 0
    nouveau 0000:02:00.0: fifo: inject:   ch   4 [Xwayland[242990]] errored 0
    nouveau 0000:02:00.0: fifo: inject:   ch   5 [supertuxkart[1181685]] errored 0
    [...]
    nouveau 0000:02:00.0: fifo: ch 5 fault 1/3 in 10000ms window, skipping method and resuming (Tier-0)
    nouveau 0000:02:00.0: fifo: ch 5 fault 2/3 in 10000ms window, skipping method and resuming (Tier-0)
    nouveau 0000:02:00.0: fifo:000000:0005:0005:[supertuxkart[1181685]] errored - disabling channel
    nouveau 0000:02:00.0: Xwayland[242990]: channel 5 killed!
    supertuxkart[1181685]: segfault at 560800000000 ip 00007f617c0d5ba6 [...] in libgallium

  So on NVAC, with 3/3 in place, the ERRORED event is delivered, the
  handler runs, the fence context is killed, and the compositor is
  unaffected.

  Two limits on what that proves. The escalation that disabled the
  channel is local and not in this series; what this series contributes
  is that the event reaches a subscriber at all instead of being dropped
  into an empty notifier list. And the victim did not survive its own
  channel being killed: it segfaulted inside Mesa rather than handling
  the -ENODEV fences. Without the subscription it would have hung
  instead.

  Games and sustained 3D. glxgears without vsync for ten minutes, and
  SuperTuxKart for a full race, ten and a half minutes, both with 3/3 in
  place. In both runs everything the kernel said came at window creation
  and was the known benign gr DATA_ERROR trap: 71 of those for glxgears,
  three for SuperTuxKart, and none at all once either was running. No
  wedge, no unexpected kill, and the session came through both
  unchanged.

  Soak. Code equivalent to 1/3 and 3/3 has been running on this machine
  since 2026-07-25, across the kernel bumps 7.1.5 through 7.1.8, with no
  regression.

  The 2/3 in this posting has NOT been soaked. What has been running
  since 2026-08-06 is the v3 form of it, which moved the subscription;
  the handover in this version is new as of today. I will report back
  once it has run.

  What the soak does not show, stated plainly: that tree carries local
  patches this series does not, including a cap on the plane-fence wait
  in the nonblocking commit tail. So the soak says these changes do not
  misbehave in daily use. It is not an independent demonstration of the
  failure modes above.

  1/3 and 2/3 are ordering fixes for windows I have not managed to hit
  deliberately; the reasoning is from the source.

Marek Czernohous (3):
  drm/nouveau: unsubscribe the channel-kill event before the fence
    context
  drm/nouveau: don't kill a fence context that is not ready yet
  drm/nouveau: subscribe to channel-kill events on NV50 and newer

 drivers/gpu/drm/nouveau/nouveau_chan.c  | 30 ++++++++++++++++++++-----
 drivers/gpu/drm/nouveau/nouveau_fence.c | 19 ++++++++++++++++
 drivers/gpu/drm/nouveau/nouveau_fence.h |  8 +++++++
 3 files changed, 52 insertions(+), 5 deletions(-)


base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.54.0


