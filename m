Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC6CDC43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:08:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 503AA10E940;
	Mon, 13 Jul 2026 12:08:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="nwe9Pq0S";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C01610E940
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 12:08:50 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2cad4170e8eso33530165ad.3
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Jul 2026 05:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783944530; x=1784549330; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FR0HREIu+ElJTqYD8DnR97TKZwOpP6adDHM14P7pQGE=;
 b=nwe9Pq0SPspyAxzWVsOSKQJKf2NksdbsbN3X+dWExDTNESkShDnNL7pZ+VB31LC63V
 vMXd9/J8QUjGNVvehFTj5sGMm5lFoXTnpHjp5ro1qKM+LDw6jVpk8/WlR1ji9LwgvtwR
 DqyTaRLcIv7Rehu0CiE06rUFTzApOWg4XxIGmUKJqWVV5xhkfylhUSIN7TWTa9xQ/qri
 09AXyjSRB4cN85z96HOKkx6wZffPkjAmFwOquMQXzuv2V3SowJLAIcz5GjmfMGnvekMD
 cYa0cw21bEP+nMLkVY8K0xQ1k5j4a/zwYGJwsOUs5/UNwFt+GzSKbflsaHZvfvKHjSHW
 s7DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944530; x=1784549330;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FR0HREIu+ElJTqYD8DnR97TKZwOpP6adDHM14P7pQGE=;
 b=RPj0lKP5eGo5+G0yHPXISpzUrTA/P+zdhC1N4mNYlawxLFMpYaBk8VF7UvqeeXdhss
 xDJYcELFYID5SR31uKEGK7foQQHzcyzXis35/xorDjuwR2d7MV5yf+lmYwEsG/PXT9NW
 U+T4ZDzbb4kHfEI9phU6KE73mqtzFd5fU8waI9H1d22E9kK/Mtc7tlad+VUDj8jqWV6P
 8cUYSSW+XOFC9xXUUto7uVSltASZBZd7DC12CaP2yyhA2LIrII/R6UTSnotRe4oIorpz
 7RJuwf0ZJYZEdiPYvaf2FtoY9/RXSD/Id3VxbPrNw25yIoWXCNJHpyBgls6EyFvL5KVp
 j3Ew==
X-Forwarded-Encrypted: i=1;
 AHgh+RqQ6IZODJKKEhr4OL+fyvhWA/WZf2qcjh9lCzsc3sqWfbu44GjFwu8dVmaQ2L9HS3fFsRkRtLFfkgs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyUx46mjD5VdEtz55fVt1LA4mPuCS2oB3ZDmUfu0U0pJsCbwpSW
 7rLPWr1LfUBR8p5hpEqmAy9Wsu2Bcgf4cNdRhD/kcXZKs7t2Z5ISDnKd
X-Gm-Gg: AfdE7cmHYQSJujZNxXHAReTP3NRMLxSUhtXQHaTiD55uW6Eo+hn2J9lvibS28qDXy70
 90JUByaX7fvD91upgtiiRcNPzYvvfUz3MPLuH1wCt/QJhQr0apHEL3SGCQXrwiZKE7ybP1mUBSx
 XNFCtiCBJi7I6YtUnSBIeHkBmjSHY7hVg4Ql5OxHyjK/4XW8BuSKg5h7ayL5TSpN3LdWmpPf+kL
 9xLTHBrrfghIVBDw+z13rN5l2SDFh/9q8NSUbJWy3IOCR0RCBC03Yb6CEPv1CBXRSCB+FwXuz5j
 XsjgVefYsW7zI95Qsra+1AgUh6MeR90Ppo1Hskwng5O2G5dcQsJlRyNE2QlJa++rCh8opolk/0V
 twfipcIzLMY7JLaf7l3x8/EiAuBqENXTpDwJUK2ICSySAEUmP/gs6g35KOd/0pMpbo3rO/7yVB7
 C/jP61mP65rymdf5LbLfEWrskzVGsU7aU=
X-Received: by 2002:a17:90a:d64c:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-38dc7296c33mr7622430a91.0.1783944529816; 
 Mon, 13 Jul 2026 05:08:49 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.180]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-311747f7293sm67756935eec.3.2026.07.13.05.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jul 2026 05:08:49 -0700 (PDT)
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
 dri-devel@lists.freedesktop.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-amlogic@lists.infradead.org (open list:DRM DRIVERS FOR AMLOGIC SOCS),
 linux-arm-kernel@lists.infradead.org (moderated list:ARM/Amlogic Meson SoC
 support), linux-kernel@vger.kernel.org (open list),
 linux-media@vger.kernel.org (open list:MESON VIDEO DECODER DRIVER FOR AMLOGIC
 SOCS), linux-staging@lists.linux.dev (open list:STAGING SUBSYSTEM)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: [PATCH v7 00/19] media: meson: vdec: Fix lifecycles, race conditions,
 and stability bugs
Date: Mon, 13 Jul 2026 17:36:55 +0530
Message-ID: <20260713120840.17427-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
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

This patch series addresses a collection of critical race conditions,
memory leaks, use-after-free bugs, and resource management issues
within the Amlogic Meson video decoder (meson-vdec) driver and
associated components.

The primary focus is tightening session lifecycles, safely synchronising
the V4L2 m2m framework callbacks, hardening work queue operations
(esparser_queue_work), and correcting buffer validations to prevent
stability issues like KASAN out-of-bounds errors or stream-on timeouts.

Summary of Changes:
* Race Conditions & Synchronisation: Fixes multi-threading and
  execution races across stream-on, stream-off, job abort, and
  teardown pathways.
* Memory Lifecycle: Eliminates memory leaks and use-after-free
  vulnerabilities by safely pinning, canceling, and sequencing
  device removals.
* VP9 & Buffer Hardening: Addresses payload handling bugs in the ES
  parser, properly tracks ongoing buffers via atomic counters, and
  prevents invalid memory writes.
* Platform/DMA Adjustments: Adjusts DMA segment configurations,
  canvas handling, and buffer sizes to match modern hardware demands.

Note on an outstanding issue:
An execution deadlock occurs in the driver workqueue path during high
stress or long playback sessions. This stall is triggered when the
Amlogic hardware internal video FIFO buffer becomes completely full.
When esparser_queue_all_src runs, the capacity validation check is
tripped due to a design limitation in how buffer exhaustion is handled.
This blocks progress and leaves the workqueue worker waiting indefinitely
on a core mutex lock.

The resulting hung task call trace shows the worker thread blocking
on the internal lock:

Workqueue: events esparser_queue_all_src [meson_vdec]
...
__mutex_lock
mutex_lock_nested
esparser_queue_all_src

I have tried to address this issue, but the underlying deadlock persists
under extreme conditions.

Any feedback on this new appock is welcome.

Testing was done using v4l2-compliance and active decoding pipelines
on Meson platforms (like Hardkernel ODROID-N2+ and ODROID-C4) SBCs.

The v4l2-compliance tests passed successfully via:
$ v4l2-compliance -s -v -d /dev/video0

Pipelines were validated using the following GStreamer script.

[1] https://gist.github.com/moonlinux/08295ba1f17ce7155550773f2d2cb6e5

Previous changes:
v6: https://lore.kernel.org/all/20260530094326.11892-2-linux.amoon@gmail.com/

Thanks
-Annad

Anand Moon (19):
  media: meson: vdec: Fix m2m device lifetime and cleanup path
  media: meson: vdec: Fix STREAMON / STREAMOFF race conditions and
    session teardown
  media: meson: vdec: Fix lifecycle leaks and race conditions in
    recycle_thread
  media: meson: vdec: Fix use-after-free race between teardown and ISR
    routines
  media: meson: vdec: Fix race condition and synchronize esparser IRQ
  media: meson: vdec: Fix race condition by canceling work sync
  media: meson: vdec: Refactor esparser work queue and fix teardown race
  media: meson: vdec: Fix concurrent execution races and unsafe teardown
  media: meson: vdec: Fix vp9 header update failure on invalid payloads
  media: meson: vdec: Fix race conditions and leaks in esparser pipeline
  media: meson: vdec: Update core m2m stream state during transitions
  media: meson: vdec: Coordinate m2m task execution inside async loop
  media: meson: vdec: Fix race conditions in job abort sequence
  media: meson: vdec: Correct atomic counter placement in dst_buf_done
  media: meson: vdec: Fix concurrent firmware loading race and hardware
    timeout
  media: meson: vdec: Configure DMA mask and segment size in probe
  media: meson: canvas: Fix Use-After-Free by linking canvas provider
    device
  media: meson: vdec: Increase VIFIFO buffer size to 32 MiB
  gpu: drm: meson: Fix DMA segment size limits and maximize allocation
    boundaries

 drivers/gpu/drm/meson/meson_drv.c             |   6 +
 drivers/soc/amlogic/meson-canvas.c            |  14 +-
 drivers/staging/media/meson/vdec/esparser.c   | 127 +++++--
 drivers/staging/media/meson/vdec/vdec.c       | 320 ++++++++++++++----
 drivers/staging/media/meson/vdec/vdec.h       |   8 +-
 drivers/staging/media/meson/vdec/vdec_1.c     |  16 +-
 .../staging/media/meson/vdec/vdec_helpers.c   |   3 +
 7 files changed, 388 insertions(+), 106 deletions(-)


base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.50.1

