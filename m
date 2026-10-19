Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8281ECCF2DA
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 07:14:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E138E10E81B;
	Mon, 19 Oct 2026 07:14:28 +0000 (UTC)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B93D610E802
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 07:14:22 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4a01933b584so12135235e9.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 00:14:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792394061; x=1792998861; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jADCjLU3MoUpjv4xpRKfYAlD1L0XyJcyjm1DBlO63j8=;
 b=hyIKEr93siKC7xAPDBgglYdoScVtYdT3pI7AihXIOdSJW3LhM9nqPM7eAL1nmhkBz9
 0Rpovebm7+B4p5JckomaFpRP9Wr1opDXjQ8eZnCls1D70nrqtpcC9B9eaLNBbgkkUeYm
 RzbCnGr6WJ69aBDw69nIMBXg42UA6gTMiuqT0u/Xj+K1QBOMa5zuEA1OGY67nKuf1yN5
 6He3trjk9JU/R9o7fJ9Zq7ZyORVsqgT8S43LCFTuo+6mtOVQAG6Sy58arqraRGonpqiN
 nGC+B03sL3mpZ6eIFQto/qfbocQiKpPBeSP+QekzeF2tR8j2QN+1OIKQOtCaMKpNZzjZ
 qLLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792394061; x=1792998861;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=jADCjLU3MoUpjv4xpRKfYAlD1L0XyJcyjm1DBlO63j8=;
 b=rA2f4KSR+5u6HMY9CcbtaJ6RmhjmK+3F11/JZsDVzDnltw+PFaHQwc8vIhj1WPx3V7
 bIp/D6oIFsPJGToSNEZaQk6l1lyDBitnjWeltZ5L2EwIoruB1qEibvmWz8eb5IWAQv7U
 ebVeUnysJZq8p3rtZPxwXbx+tHBNmHJpaMN/hGDF24MELgaiBBvn6evc7JGB0PgG9vYu
 NJr25dtpdgYPoY0Ge6iDueMxwGWqoSMDBDR/UOxH0J6z5mD6qTI24Lo2CbMADhcPAx8b
 hiAeltaEWxcwl7+b96K6SrFoHSEADrY4726SDQCu4Q0K5zQ31pHSk1Tur0dY1VJ3Fio8
 Wndw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxUg1qXUbZX2Qm4w1QYrKysKh1GIBEteavrgYEdH2ST8uNH68U01dMgr/yDLa0Qf2jjMoBW/hUatdc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJsHr/NElZ+pBqmUPOnwKdThAhCJyiqfSv5FU378Un5KGaTp6Lk
 3ulRJcSxOt02+2EgetjVbGJvFUxNgeUoxMjA+hMQXpuzWACsvMx4tzP6
X-Gm-Gg: AYBFou2Xq59R8latZH3bLZ9plAJ0LI1jSymEYQ4L1/mvOJV18vsO7wspn5YHy79slIT
 iAyQONT2+4TuHZKHRp/G1e7J38+5tFKXdNjUssz0SbcIJqpMn8d3WuogI/okZsAW/wz2XQFMgmD
 Tao/vqckq8YyQb8Hea+Sko66W25ryUyAMEtBHmiDe/oQgah/BScrIboT01wLc3IfffgSXVMqnjq
 s7C8QfWXnuuOPuq9hX7Iciz9kuUWiuD08eQK3jOa9epcDfoU5MG7976nTa3pLN82m8SbLy1xX9P
 q3fXxZs94ePnaqkyzXbX2hWE044zmSqBWENMcFI6vYOf/s4kdFVkOVBEYWqHhReZYYiVZ3uXMQP
 GXvJhzqVo7PmYXk9PafBmQmLr7SxvLVv21T32rQKdj+bIrAM76VGaCAmSXWH9pCPZcORNPV32rM
 cr5XYvV1us6f77H+fYhNi6BialwBGaTYUlmKAGi4xwyt4fs4nrqbhiGGZVpFCdtOnJlJ94VnpAD
 fgwhzSHFc72N0Ez3KV+YLwNYpSciZJiq6W04iSwaFwtETMhCuCneTINuixZGstcIBVrCUIuuzJI
 4rCNhTEb0xvvMduSrqyD42adYMY0SxSZcKfQP5QLt482C2DBCSNNgXdrZJLHE5/KaOJ/JSXb+UF
 0
X-Received: by 2002:a05:600c:3513:b0:49f:fd2d:23c7 with SMTP id
 5b1f17b1804b1-4a1d760e58fmr141500925e9.27.1792394060636; 
 Mon, 19 Oct 2026 00:14:20 -0700 (PDT)
Received: from localhost.localdomain
 (dynamic-2a02-3100-a4e0-4601-c43a-536a-04a3-af7d.310.pool.telefonica.de.
 [2a02:3100:a4e0:4601:c43a:536a:4a3:af7d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd540bc4sm21559338f8f.2.2026.10.19.00.14.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 19 Oct 2026 00:14:20 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: linux-media@vger.kernel.org
Cc: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Tomasz Stanislawski <t.stanislaws@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH 0/4] media: synchronize CPU access to imported DMA-BUFs
Date: Mon, 19 Oct 2026 09:14:07 +0200
Message-Id: <cover.1792392288.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

UVC and vivid access imported DMA-BUFs with the CPU without cache
synchronization. On a Pi 400, captured data remained in the CPU cache
while physical RAM was stale.

Add an opt-in queue flag to bracket CPU access from buf_prepare() through
buf_finish(). The allocator cannot imply CPU use because some vb2-vmalloc
drivers pass buffers to hardware. Patch 1 balances finish operations in
VIDIOC_REMOVE_BUFS so removing prepared buffers closes this interval.

This follows the per-queue flag proposed here:
https://lists.openwall.net/linux-kernel/2024/06/20/236

Based on Linux 7.3. Tests cover the same code on these earlier bases:

- Pi 400, 7.3-rc4, all four patches: eight 640x480 YUYV frames per run,
  imported CMA DMA-BUFs with a DRM device mapping:

  Path                          Runs   Stale frames
  UVC, vb2-vmalloc               12        0/96
  vivid, vb2-vmalloc             12        0/96
  vivid, vb2-dma-contig          12        0/96

  All six lifecycle cases passed with both vivid allocators. Read-only
  output USERPTR passed. The test added no warnings or failed CPU-access
  callbacks. A control without the DRM mapping found 4/16 stale frames.

- SAM9X75 (ARMv5), 6.18 backport of all four patches: the baseline
  PREPARE_BUF/REMOVE_BUFS imbalance was fixed. USERPTR and six lifecycle
  cases passed. All 128 vivid and 96 UVC frames matched RAM, with 100/100
  begin/end calls. The baseline was already coherent.

- BeagleV Ahead (RISC-V), 7.3-rc7, patches 1, 2 and 4: read-only USERPTR,
  six traced lifecycle cases and 60 repeats passed with balanced callbacks
  and no kernel diagnostics. A vendor 5.10 backport of patches 2 and 3
  captured 96 UVC frames without stale data, with 100/100 begin/end calls.
  Its baseline was already coherent.

Karl Mehltretter (4):
  media: videobuf2: finish prepared buffers in VIDIOC_REMOVE_BUFS
  media: videobuf2: add opt-in DMA-BUF CPU access
  media: uvcvideo: synchronize imported DMA-BUFs for CPU access
  media: vivid: synchronize imported DMA-BUFs for CPU access

 .../media/common/videobuf2/videobuf2-core.c   | 96 ++++++++++++++++++-
 .../common/videobuf2/videobuf2-dma-contig.c   |  5 +-
 .../media/common/videobuf2/videobuf2-dma-sg.c |  5 +-
 .../common/videobuf2/videobuf2-vmalloc.c      |  5 +-
 drivers/media/test-drivers/vivid/vivid-core.c |  1 +
 drivers/media/usb/uvc/uvc_queue.c             |  1 +
 include/media/videobuf2-core.h                | 12 ++-
 7 files changed, 116 insertions(+), 9 deletions(-)


base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.47.3

