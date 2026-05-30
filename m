Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72346CD6E5E
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 14:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2795112B88;
	Sun, 31 May 2026 13:59:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hnWJCa1U";
	dkim-atps=neutral
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com
 [209.85.214.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 28B15112742
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 09:43:37 +0000 (UTC)
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2bf008a99d4so29385725ad.2
 for <dri-devel@lists.freedesktop.org>; Sat, 30 May 2026 02:43:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780134216; x=1780739016; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5ZTtXuk8VMOe/R1MOW9+2Ia+hoeCMO0OxOU+XGlScXw=;
 b=hnWJCa1UtZq0i0b56vD6k0kbardOkOn6C2RK/JGII/Gad+KzHG2JRkpycTaxabbRct
 9nWeCe+94JBQMK8b3qv2phl9STjb8VvUzavdHZAF3DIw12rZDXx/uMz9X3v1o5ZCmHB3
 9LjWw9yWiV/UufIGrMHZos0CokNsiLXPaHD86H/QlOLSdg5rN0yFVwq9ZEVgWduvnIA8
 LWhdaweznlDj4BctpPl7vuja11Elcl/ed7AnmLozmRyvzTDOINN2nCpOw9tI+awl8hAu
 JGkPI8FIbWgKZG6Q09SAzy2NUYJre+ox8iurrX2UrXd0ABulaljb19AMYvF+QhGdZ7u/
 IIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780134216; x=1780739016;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5ZTtXuk8VMOe/R1MOW9+2Ia+hoeCMO0OxOU+XGlScXw=;
 b=bjAZLUOub9oLD8yZK7d2+K1sxzGlHRLG5e3OcFnY1IxgGxLe90s9HAPHlrz0gpGj7D
 xL98a65qZ7xbI040pG21OHgphVt4YkbQ/LNBzjYrB2gbBJ/pW/PXrwQ7AwETUE0kmWmy
 mYVA2qHIMq9wrWiLuWKpC2zTP4u3EVC7w4CK/O0kiqseV6aJHcVOB78oH7ckQ5TaOnwl
 IrDdW76Dj29BTO2qGj2gMNph98N28kBICO4caTCMMRjeT+WOs3GSIXNqnhkqaZZoVP4D
 uGWEp/gdUsWfzbcN3H64eZnP7Z0hObQ5UnSeIrJB/09pcfbVbuJ6hEiKF+Sci9G4qtrc
 DsSA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8+slCr8fp6o3TMtAoorvuLrpzG+3/KJZY/bzAvmk25EJag7aynsfdgm9PopHR3dcXPtpJj0kfqFhY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1CBne9EeoCRhtyybwMpAs5hki6b54iUmM6oAJa99PdVSZ9c0E
 1A1S9GOCRMojsYE+uEnzv6r4KPaoyEru3wQpS+hGYDz5RsGhTkEfRusn
X-Gm-Gg: Acq92OGg37VZ1pLCAT3Mk5DCjLJpmYjO5Jd9t3chWa27nwPyEczqaPHYqwQTB6SYuCn
 jKD4l+UcqhMqpLyMPyKlYcwRdFy9xrj9F8LIO1fuydmKPi5l/k/j0GLBbcFcz+u2fqGA6D+I1eX
 1cvDo7dwaBry9szcRqmjVKfaFRwxEv0MWjtCXk9BNshjXxCSr6zihIwpzdK8ntfg7kqorb6Doxe
 0dYUvChxtrbJ7+GKbTeQTEhRsaPPdTa6t/G3j8ihXqSPRH5+SOoPgS5GWiVCQBZeobpHV4eWjSt
 eZ67ogtQ2KwyY3Nm8/07LI7pkm1TspEt2mkhu2BuWqONDRanSPWsly039K72JQE9gcIQzBDj5pJ
 Kpi3oXogl2E2OxsMUNJeqUJx5j9IqirnvWS+TQEOJIy9qdJL/LBa3FKRQMKamFSR5J4Z6hnAmxG
 j40iuBMks56xiv387WQF+Khb9cvx3YRb4=
X-Received: by 2002:a17:903:46c4:b0:2c0:ab92:584c with SMTP id
 d9443c01a7336-2c0ab926140mr12404095ad.25.1780134216487; 
 Sat, 30 May 2026 02:43:36 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.191]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bf239e700csm61529945ad.10.2026.05.30.02.43.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2026 02:43:35 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Kevin Hilman <khilman@baylibre.com>,
 Jerome Brunet <jbrunet@baylibre.com>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Hans Verkuil <hverkuil@kernel.org>, Maxime Jourdan <mjourdan@baylibre.com>,
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>
Subject: [PATCH v6 0/8] media: meson: Fix memory leak in error path in vdec
Date: Sat, 30 May 2026 15:12:46 +0530
Message-ID: <20260530094326.11892-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 31 May 2026 13:58:31 +0000
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

v6: Changes

The previous approach had some technical issues, so this new version
takes a slightly different approach, I have fixed the DMA warnings
found during basic testing.

I have donse basic testing on the Odroid N2+ and found that
the clocks are not enabling for decoder.

It also seems some Mali GPU configurations are still missing.

You can reproduce the test case using:

mpv --hwdec=v4l2m2m Big_Buck_Bunny_1080_10s_30MB.mp4

Please let me know your feedback so we can discuss and address these
points!

Thanks
-Anand 

V5: Changes

[v5] https://lore.kernel.org/all/20260525095216.12078-2-linux.amoon@gmail.com/
 
Following chamges try to fix the memory leak reported by Sashiko

New issues:
- [High] The newly added error path in `vdec_start_streaming()` leaks
  `sess->priv` when `kthread_run()` fails.

Pre-existing issues:
- [Critical] Race condition between hardware power-on and `core->cur_sess`
   initialization leads to a NULL pointer dereference in the IRQ handler.
- [High] Returning buffers for both source and destination queues upon
    single-queue failure orphans active queue buffers.
- [High] Concurrent sessions can bypass the hardware exclusivity check,
  leading to simultaneous hardware programming.
--

V4: Changes:

v4: https://lore.kernel.org/all/20260521073449.10057-2-linux.amoon@gmail.com/

Following chamges try to fix the memory leak reported by Sashiko

Pre-existing issues:
- [Critical] The `sess->esparser_queue_work` work item is not canceled
   before freeing the session context, leading to a potential Use-After-Free
   vulnerability.
- [High] The patch attempts to fix a memory leak reported by kmemleak,
    but misdiagnoses the root cause and leaves the primary memory leak
    (the V4L2 control handler) unresolved.
- [High] The driver does not verify if `kthread_run()` returns an `ERR_PTR`,
     leading to a kernel panic when `kthread_stop()` is called.

Thanks
-Anand

Anand Moon (8):
  media: meson: vdec: Fix memory leaks and lifetime of m2m device
  media: meson: vdec: Fix concurrent STREAMON / STREAMOFF race
    conditions
  media: meson: vdec: Handle kthread failure and free codec state
  media: meson: vdec: Condition buffer flushing on queue type in
    start_streaming
  media: meson: vdec: Cancel esparser work during teardown
  media: meson: vdec: Configure DMA mask and segment size in probe
  media: meson: vdec: Fix NULL pointer dereference in ISR handlers
  gpu: drm: meson: Fix DMA max segment size for DMABUF imports

 drivers/gpu/drm/meson/meson_drv.c       |   2 +
 drivers/staging/media/meson/vdec/vdec.c | 179 +++++++++++++++++-------
 drivers/staging/media/meson/vdec/vdec.h |   4 +-
 3 files changed, 136 insertions(+), 49 deletions(-)


base-commit: f5e5d3509bffb95c6648eb9795f7f236852ae62d
-- 
2.50.1

