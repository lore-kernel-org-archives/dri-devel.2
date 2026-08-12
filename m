Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D18DC5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 23:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 45DE510E0FA;
	Wed, 12 Aug 2026 23:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q8jyJrYg";
	dkim-atps=neutral
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com
 [209.85.128.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BA910E46F
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 23:13:34 +0000 (UTC)
Received: by mail-wm1-f46.google.com with SMTP id
 5b1f17b1804b1-495502852d1so1418245e9.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 16:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786576413; x=1787181213; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=knmiZOkayyU4iEwEuKGRREO2aACklWxmCXd6sObM8f4=;
 b=q8jyJrYgqWKfNEydwETbj/j3n56OjmaJaDG3tsnHk0Jt9SLEKDv1FSAcnQW/lgko6O
 OdT1LkW+5KqEnNDSYpAY4ROwcKx9mdYBPff4gIyfcq3XVpii8lfZ6yERcJzll/Za66vw
 ZVGYT0WUVZNZf3Na/h36RzjXjAho1cpifVTCx/5Fpw5k+IBLEyDbE58aGgzVZeAWxFGy
 bOq8vBlXbpCGUjf7raDM2QBiLG1BQ7V7VB+Ax08C0o89XOM2+/+ITjcVQxp17cE5aUwQ
 S4PzwD6eVh0+nB/WOUtZRMvRVN0jnfQJmT321SFZn/Mj5QMJ+G5Rz+jPhjwSY19P0fXn
 t63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786576413; x=1787181213;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=knmiZOkayyU4iEwEuKGRREO2aACklWxmCXd6sObM8f4=;
 b=YcSjkcLBuRihLyBNCc5wnfiKYd71Py7j1I23nV5/2lLqYaAH51U1+htSSVQUf7L7y+
 4qb0auJeJ+cZNGgvrYRYd2ALWPC8VOJc/1MwpBW2oVUvOkc1gEn9Gq1a1+c3W+spzyHh
 sA9LBW1e72ADfDytzCvOilBTvT/cIXQ6HDHIcc6+MOCSVXmtZSwCC/w7hcyPxTe3pefq
 6vvOq7+OorlaYZM6KxQkmu+ORvjzy9sxBJf3EfjSz3tuw8p6JISmbvMj2IEitsw5V0Wq
 rbixzIx3UeqtKrnXS0XMT9uPNGPP4EMEYKnsx0MvMnQ6NvkDW5GJhXppdak93h0V9SiQ
 0RPw==
X-Forwarded-Encrypted: i=1;
 AHgh+RoM0nT+Q+S4M38t1CCkEDtMiMnTuGzAJc3ZTWotOFJPBGsiZFR/maVc6n+XE2EVKK8g+sZLYWbtrqM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzfFhJl+/uPwGZTdB6dDpZVfNb1O2WnH6Wdor/x9oHvlaKxNkKu
 32Q8G4JfII150pgqzmdw00EAkH7gpCxXBBYen0TLWbwfeaRWthn8n4kl
X-Gm-Gg: AR+sD12sqcHEYuYjIYI/M4L9EQveXWvEbTIwDlO1Ox3VrjNvsAua8lyR4QpuvcAA4I2
 Q9Sz7ZsjQKKyyHILk2qCt1qv0M0vD/UTLU8um+oYxGEGQEej02XAerEhPbCruRpG1bYLKXt/hxd
 mCMedNCiFir2Vq08UrYCwZBXAXccMIUL1OQi6F469cUOB/1uwAtzyRsnfGHtBIzOhsDcJdFMFxf
 UoqwRjm6wntNdGKDyXIJ3Q8+UTUXqckbUedM05qhMa26siWFRfYRLdCDaBwvItmNgYOx7fsszA/
 WPdMaSAw0X8T8XfIq0xPH4LQVjtAXQo1EWfKJF2Ir3V2N1UF9ECkWjQTdURdm8PpltK2Gc8Wsoo
 RbdCG2RxhozDPvD3CNlRxIuQWIxd3nx+cxThgnBt4dZKgRfrTT2lWu3sCmWkwo8qYgeZrl9siMD
 X7W+k6nrmMyGkZ+NI5Jm/fPkF9XUFLC6gy8jvsWO/cy55vnLBLmtQVfNwIvUwepcDcmVtlAxw24
 a791m6QnMb2dFTxLJXdKRd8fC8nrpUoSdq/coJnhNr/f7oxk9+hZQ8M
X-Received: by 2002:a05:600c:19d4:b0:490:ec79:3046 with SMTP id
 5b1f17b1804b1-499821647efmr6305275e9.0.1786576412642; 
 Wed, 12 Aug 2026 16:13:32 -0700 (PDT)
Received: from Neo.taile6b6ba.ts.net
 (ip-109-193-028-127.um39.pools.vodafone-ip.de. [109.193.28.127])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49981b631c1sm44532245e9.14.2026.08.12.16.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 16:13:32 -0700 (PDT)
From: Marek Czernohous <mczernohous@gmail.com>
To: nouveau@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, Danilo Krummrich <dakr@kernel.org>,
 Lyude Paul <lyude@redhat.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ben Skeggs <bskeggs@nvidia.com>
Subject: [PATCH v3 0/4] drm/nouveau: channel-kill event ordering fixes,
 and lower the gate to NV50
Date: Thu, 13 Aug 2026 01:13:26 +0200
Message-ID: <20260812231330.705425-1-mczernohous@gmail.com>
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

This is v3 of the nv04 FIFO series, cut down to the four patches that are
ready. v2 is here:

  https://lore.kernel.org/nouveau/20260806085228.1848994-1-mczernohous@gmail.com/

The Sashiko review bot flagged three issues on that posting. It was right on
all three. Two are fixed by the new patches at the head of this series; the
third was in the Tesla recovery patch, which I have dropped from this posting.
More on that below, because the reason is not the bot's finding.

1/4 The channel-kill subscription outlives the fence context in
    nouveau_channel_del(): the context is freed first and the event is only
    dropped later, among the nvif object teardown. A kill delivered in that
    window walks a freed fence context.

2/4 The subscription is armed before the fence context exists.
    nouveau_channel_init() subscribes right after mapping userd and creates
    the context at the end of the same function, and the backends publish
    chan->fence from kzalloc() before nouveau_fence_context_new() initialises
    its lock and pending list. The NULL check in nouveau_channel_kill() does
    not cover that: the pointer is non-NULL and unusable.

Both are pre-existing. Both are unreachable below Fermi today, and on Fermi
and newer the windows are narrow, but they are real, so 1/4 and 2/4 carry
Fixes: and Cc: stable and stand on their own. I should have carried them from
the start. The v2 cover letter even described the teardown ordering and
dismissed it as "most of that window is harmless". That judgement was wrong,
and I appreciate the catch.

3/4 and 4/4 are unchanged in code apart from the rebase and one joined format
string. Both commit messages have been corrected: 3/4 no longer implies a chip
gate it does not have and no longer claims a before and after I cannot show,
and 4/4 no longer says the fences time out, because they cannot.

3/4 downgrades one specific CACHE_ERROR to debug level. Mesa's NV50 bind
probe writes a known method and data pattern that the hardware rejects,
repeatedly over the life of a session, and nouveau has been reporting it at
error level ever since. It changes no behaviour beyond the log level and is
unrelated to the two fixes above; it has simply travelled with them since
v2.

4/4 lowers the channel-kill subscription from FERMI_CHANNEL_GPFIFO to
NV50_CHANNEL_GPFIFO. On its own it changes no observable behaviour, because
nothing kills a channel on Tesla today: the only nvkm_chan_error() callers are
the Fermi and newer recovery paths. It is worth having anyway. Leaving the
ERRORED event delivered into an empty notifier list is a latent dma-fence
contract violation, and it is exactly the trap the recovery work would fall
into. Removing it before anything can fall in is the right order.

What is not in this posting, and why

  v2 carried a third patch, the recovery path for Tesla cache_error and
  dma_pusher faults, and the five-patch v3 I had prepared carried it as 5/5.
  It is not in this posting, and the bot's third finding is not the reason:
  that one was a real bug of mine and is fixed.

  I ran an adversarial review over the whole series before sending, and it
  found two defects in that patch that the bot had not flagged:

  - nv04_fifo_recover() has no chip-family guard, but nv04_fifo_intr is .intr
    for nv04, nv10, nv17, nv40, nv50, g84 and g98. On NV04 to NV40 the
    escalation would therefore fire while 4/4 deliberately installs no
    subscriber, producing exactly the dead-letter hang that 4/4 exists to
    prevent. The series would have contradicted its own reasoning, in the same
    diff.

  - The recovery path pulls the drm_device out of drvdata on every fault,
    while nouveau never clears drvdata and the only cancel_work_sync() for the
    wedge work runs in nvkm_fifo_dtor(), that is after nouveau_drm_device_del()
    has already kfree()d the nouveau_drm. A queued work reads freed memory.

  The first is a one-line guard. The second wants the wedge policy moved into
  the DRM layer rather than patched where it is, which also removes an nvkm to
  DRM layering violation I should not have introduced. That is a rework, not a
  fixup, so it goes into its own posting once it has been rebuilt and soaked.
  Sending it now would only waste reviewer time.

Testing

  Reference hardware: Apple Mac mini Late 2009, MCP79 / GeForce 9400M (NVAC),
  Core 2 Duo, Wayland (labwc).

  Build. Unlike v2, this series is built against the stated base commit: the
  nouveau module compiles and links with zero warnings and zero errors, with
  the new format strings and the lowered class gate in place. checkpatch.pl
  --strict is clean on all four patches.

  Soak. Code equivalent to 1/4, 3/4 and 4/4 has been running on that machine
  since 2026-07-25, and equivalent to 2/4 since 2026-08-06. The first spans
  the kernel bumps 7.1.5, 7.1.6, 7.1.7 and 7.1.8, the second only 7.1.7 and
  7.1.8. Since every channel now subscribes to the kill event, the interesting
  long-run question is channel churn, so the soak is ordinary daily driving
  with a browser and GL applications rather than a synthetic loop. No
  regression has shown up in that time.

  What the soak does not show, stated plainly: that tree carries local patches
  this series does not, including a cap on the plane-fence wait in the
  nonblocking commit tail. So the soak says these changes do not misbehave in
  daily use. It is not an independent demonstration of the failure modes
  described above.

  1/4 and 2/4 are ordering fixes for windows I have not managed to hit
  deliberately on this hardware; the reasoning is from the source, and the
  bot's reading of it agrees. I would rather say that plainly than claim a
  reproduction I do not have.

  3/4 filters a benign CACHE_ERROR that Mesa's NV50 bind probe triggers. The
  logs behind it are from a second, independent MCP79/MCP7A machine, not
  mine: 99 occurrences across three logs and two kernel versions, under Xorg
  and Wayland, with kwin and plasmashell named as the faulting clients. They
  were shared with me by the tester who reported the original NVAC issue. I
  have not named them and have added no Reported-by or Tested-by: we have
  not been in touch since then, so I have nobody's consent to point at. On
  my own machine the filter went in before the persistent logging did, so I
  cannot show a clean before and after from here.

AI assistance

  Lyude asked on the v1 thread whether these patches were written by a human
  and pointed at Documentation/process/coding-assistants.rst. The answer,
  repeated here for the archive: this work is AI assisted. I use Claude
  (claude-opus-4-7 for v1, claude-opus-5 since) as a coding and analysis
  assistant. Every patch carries an Assisted-by trailer accordingly, and no
  Signed-off-by is added by the tool.

  Nature of the assistance, so you can calibrate your review: the assistant did
  most of the code archaeology and drafting. I described symptoms, asked for
  the mechanism to be traced in the source rather than guessed, and asked for
  each claim to be backed by a file and line. The measurements quoted in
  earlier postings are from the machine, not model output. The assistant also
  reviewed its own earlier work adversarially, which is how the two defects in
  the dropped patch were found, and how several unsupported claims in the v2
  cover letter were caught before this posting. I reviewed the result, I
  understand the code, and I take responsibility for it.

Changes since v2

  - new 1/4: unsubscribe the channel-kill event before the fence context
  - new 2/4: subscribe to the channel-kill event after the fence context
  - both found by the Sashiko review bot on the v2 posting, confirmed against
    the source before acting on them, and now carrying Fixes: and Cc: stable
  - dropped the Tesla recovery patch, see above
  - 3/4 and 4/4 unchanged in code apart from the rebase and one joined format
    string, both commit messages corrected for accuracy
  - the series is now built against the base commit

Marek Czernohous (4):
  drm/nouveau: unsubscribe the channel-kill event before the fence
    context
  drm/nouveau: subscribe to the channel-kill event after the fence
    context
  drm/nouveau/fifo/nv04: filter benign CACHE_ERROR from Mesa NV50 bind
    probe
  drm/nouveau: subscribe to channel-kill events on NV50 and newer

 drivers/gpu/drm/nouveau/nouveau_chan.c        | 64 ++++++++++++-------
 .../gpu/drm/nouveau/nvkm/engine/fifo/nv04.c   | 26 ++++++--
 2 files changed, 61 insertions(+), 29 deletions(-)


base-commit: c21bb4193868a8de71fc4693fa741e195fdf5d86
-- 
2.54.0

