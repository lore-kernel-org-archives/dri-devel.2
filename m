Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99137606A32C
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 07:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=unyLCiwH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 860CD112043;
	Thu, 29 Oct 2026 07:59:03 +0000 (UTC)
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com
 [74.125.82.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC42B10E6A7
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 16:46:14 +0000 (UTC)
Received: by mail-dy1-f177.google.com with SMTP id
 5a478bee46e88-369f33df08eso2245966eec.0
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 09:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793205974; x=1793810774; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=OLaMbaoim8E2HPY7c41mzNoySwNHbusfNb0WniQFAAE=;
 b=unyLCiwHm97Nz5IsVN+BTo3a/lhDiLqX0S4pl3uEVO/NLUS6kdYCTgZP3j/gYwk0g4
 f1seo+FYXWG+HWrOPcZGtOUTw5sDW7EUdDPgl6ivlUpRr/oV3r9kUhzxryb1+oF3nDo+
 LC8z2PpVSe6TJjAA1LE8QKXo+ggO8xmMQDo7htxOgGo8G1Ymkk7xP78UEWISt/x370ns
 BMJ+79dQnxULV0cXTN9erIUX6uv0T0IbSr0amttBl8pmheuusuZUKlXwld3iqGnU0Bax
 AhGNyQlHJu+5DLBFdQ964lc7WP/rV+js2V4Yxff/f96J4QG993IabaoAtcLL/7A6T0Q6
 LnTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793205974; x=1793810774;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OLaMbaoim8E2HPY7c41mzNoySwNHbusfNb0WniQFAAE=;
 b=Bufx4/rmxPDlpZpehJpy+Jt74/8xPuFP+UtT4d5e9N2Mx1Kgm6Vr34+H/0D5GybMDR
 BnF6XWLAJ3cORjpbPx4dsYSve08t4qg+d7ojq4AAEewoltbACFJGfToOo1c6im5TJ+RB
 PJvh0UDSDG4s2BdREvxJfkvPqEnSRcs1D4pHKYZZaHtZrs+N8kp9gYbXZh5aMAxGZ7Z6
 XmYHYnd2MyIn59Lpiqxgl2MjA6h4cIVr2ZhpYYBfLsTUa0TfzQoh42UuvPAvqAQICpIB
 tB+a3+IbY+zVzO6z6AzUJBYHdarCZbSyor5US5h3E70xPitGfx9TyCLRjCunDRK8fDu/
 S+hQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBx6dmuVYkC7ZQTOBo44hk3bfLUXC66SW9kKIgh2inZdc93ngXVC3V0PkSLjzGMHaZj6QZU8FBFDYQA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYK3ksQB75p4uEoVJMnXjkdm4ewh03150cyoCwZiwkfw8+EL/ycm
 PHZ54gOm4xp3dRpyqYDQB3NNR+MoG512DYJubmkGv4FX7m5oJEtf1uXU
X-Gm-Gg: AYBFou3TleRz3X4MT+NeCzPUgsP6b4IDHlPjLTW9IyreJZRg//xAqRkWt8U7Wk7ESrk
 8uxWog5VtjjNeJlNCWIjzd2UrOAo0j1E3nHrFW0/iZnGhzznWT8fwS2bTtaoU4PuElVGBdl4zBo
 sPV+mNGyfCRhU+aDOVcDtc38DhC7420JMSMdXgSn4Y/h9jBiJ97HAD9lc2aD7fLKA9Jr2UpFl8B
 PQ2flXDu/2ewZACmQ5XnhbCJm/PLXz/J2Y0KAKAHCwEVg1TbTypYYuvDaAmCWXnPJkiXXC6KysY
 AT9aTny3asxnPCU0zTOw6kwMaWCPze5cNtFsid2NnGtY+kDoGM/NvhbmEvRItZ4xnKhCTqVpVQK
 HDJj+1LLzuoVQXOv6UGwwM3e8JhGLVwEIpSvVe/4+CNRq5SrTBkvxf4NsDWRTSXez7lQMw/SR0I
 TD8VkOPXa+fNnz6eawYXTYiFMwT95Te6WE3GhBEzcU1eQosK//z3nWx7etOpDQmT4gudpMYwhs3
 dnD1WaOKrMC2DegwzqIHq058EYvv/Vq/zjobjiOR0ek2DnlrOgMug2rTY6v20RE+yC2raqLl9Dm
 t4D+dx2/8+GzkgjPzV/Ipep1F1qJ75bo1PypUyrh5duvOt390bZbEsbEcn3CZdMF9gBidNrHNCj
 GU6FC8NFXhU05TgQH
X-Received: by 2002:a05:693c:8803:20b0:36a:fec:d8b0 with SMTP id
 5a478bee46e88-36a2010a1bdmr4195933eec.25.1793205973745; 
 Wed, 28 Oct 2026 09:46:13 -0700 (PDT)
Received: from localhost.localdomain ([136.126.251.209])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a23908449sm7821964eec.11.2026.10.28.09.46.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 09:46:13 -0700 (PDT)
From: Henry Zhang <henryzhang62@gmail.com>
To: Maxime Ripard <mripard@kernel.org>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>
Cc: Henry Zhang <henryzhang62@gmail.com>,
 =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v4 0/5] drm/vc4: dsi: Make failed reads visible and recoverable
Date: Wed, 28 Oct 2026 09:45:25 -0700
Message-ID: <20261028164539.3471833-1-henryzhang62@gmail.com>
X-Mailer: git-send-email 2.47.3
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Thu, 29 Oct 2026 07:58:57 +0000
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
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

DSI reads on the Raspberry Pi 4 (vc4, DSI1) can fail in two ways that
the caller cannot handle:

- A peripheral that detected an error answers a read with an
  Acknowledge and Error Report. vc4 copies its two bytes into the
  caller's buffer and returns success, so the error bits look like
  register contents (patch 2). An HSTX timeout can be reported as a
  success as well (patch 1).

- After a read whose bus turnaround times out, every following DSI
  transfer times out as well, until the display is switched off and on
  (patch 5).

Patch 3 rate-limits the error interrupt messages, which patch 5 would
otherwise turn into an interrupt storm. Patch 4 serializes host
transfers against each other and against the bridge callbacks, so that
the recovery cannot reset the block under a transfer or while it is
being configured.

These patches do not prevent the timeouts. With video running, vc4
does not keep commands within vertical blanking, so a command can still
collide with active video and time out. That is a separate issue; this
series makes such failures visible to the caller and recoverable
without a modeset.

Tested on a Raspberry Pi 4 (DSI1, 2-lane video mode panel) with the
same changes backported to the Raspberry Pi 6.18 kernel:

- 5 minutes of generic long writes from 4 extra threads with video
  running: 45000 writes, 582 timed out; each timeout was followed by a
  reset and restore, and the following writes went through. The DSI
  interrupt rate stayed at 147/s.
- 50 display off/on cycles with 2 writer threads running (the case that
  locked up v2): no lock-up, no warning.
- 250 display off/on cycles without extra traffic: 245 panel inits
  succeeded; 5 failed because the data lanes did not reach LP-11 after
  power-up, which this series does not address.

Reads were tested with these patches plus a change, not part of this
series, that stops video while a command is sent: 2000 of 2000 reads
returned the expected data.

Compile-tested on drm-misc-next (arm64 defconfig, DRM_VC4=m, W=1), each
patch on its own.

Changes in v4:
- Patch 1: new, set the transfer result before completing the transfer
  on an HSTX timeout (found while reviewing v3).
- Patch 2: add Dave's Reviewed-by (unchanged from v2 1/3).
- Patch 5: keep the interrupt handler out with disable_irq() around the
  reset instead of synchronize_irq() before it: an error interrupt could
  still run during the reset (Sashiko review).
- Link to v3: https://lore.kernel.org/r/20261026191618.9430-1-henryzhang62@gmail.com

Changes in v3:
- v2 is not safe; please don't apply it. Its recovery keeps the block
  usable after a timeout, and a peripheral that leaves the data lanes in
  a bad state then raises the "data lane 0 sequence" error interrupt
  tens of thousands of times per second. Printing each one starved a
  Raspberry Pi 4 until it had to be reset.
- Patch 3 (new in v3): rate-limit the error interrupt messages.
- Patch 4 (was v2 3/3): moved before the recovery, and also taken in the
  bridge pre_enable, enable, disable and post_disable callbacks.
- Patch 5 (was v2 2/3): only recover while the block is enabled, and mask
  the interrupts while the block and its AFE are in reset.
- Link to v2: https://lore.kernel.org/r/20261019174930.7237-1-henryzhang62@gmail.com

Changes in v2:
- Patch 2: restore the registers in the same order as pre_enable, and
  call synchronize_irq() before the reset (Sashiko review)
- Patch 3: new, serialize host transfers (Sashiko review)
- Link to v1: https://lore.kernel.org/r/20261012190249.3167-1-henryzhang62@gmail.com

Henry Zhang (5):
  drm/vc4: dsi: Set the transfer result before completing the transfer
  drm/vc4: dsi: Don't return error reports as read data
  drm/vc4: dsi: Rate-limit error interrupt messages
  drm/vc4: dsi: Serialize host transfers
  drm/vc4: dsi: Recover from a timed-out transfer

 drivers/gpu/drm/vc4/vc4_dsi.c | 180 ++++++++++++++++++++++++++++++++--
 1 file changed, 170 insertions(+), 10 deletions(-)


base-commit: 650385a0fd0ea6475a17d39a20ec90470c7a4c67
-- 
2.47.3

