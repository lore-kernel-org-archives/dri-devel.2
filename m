Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9382F606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 10:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Ojnc055T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D803210E080;
	Sat,  7 Nov 2026 10:47:26 +0000 (UTC)
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B40E710E080
 for <dri-devel@lists.freedesktop.org>; Sat,  7 Nov 2026 10:47:20 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-49134c8509fso1201583f8f.1
 for <dri-devel@lists.freedesktop.org>; Sat, 07 Nov 2026 02:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794048439; x=1794653239; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+OU4gePN1TbrZEx6lkd5UF6PxGqdlcQqr6Ot6rmKywQ=;
 b=Ojnc055T0ia0h+8WbmYULIfTZvpXPNAShJkJWvNu9SIP3UcjFmk+UjbAn6AZ/v9rHb
 ikNmq1K0t9bhaQvkDPntqAzka1Tq5DUKX95BVCXHSQ5izOcrkWN75uzszxHGdJFPtk3i
 FcaTpgcyDM8MBUMOHm9zSKBuUs0hbBV3bi3pLTYNntOnl6NoOkOrUEB4uw7y3vvFhw0J
 xko7bC+z4tNs79zIzsD2BuqxzJCJMCBI+eecq02gA+4x/YO2MYrNNgvhz3My5nK/B6J+
 nVLtEgGkE5WDI/R3NlNgD4ICiq/mOOdUpusOQjLebN2YP1kdz38M8bXJMX2HF64Qw5Y6
 BVEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794048439; x=1794653239;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=+OU4gePN1TbrZEx6lkd5UF6PxGqdlcQqr6Ot6rmKywQ=;
 b=OI305iwDUmXc9HfRm8BBdkvJ4S7fpFzE2QR3+EJffrOnyQwLIU32bCC0SAFg9ezxU1
 ykff9aOGa7z2ftmqkF/kIITPgUKkZY1Nk5ZwgOysw6prm+AfuuFR+5VsZRL+8l5yQbeX
 TbPhranh0UhUEN4s0E+mGGkp4X16cyXzW6DT5Oyj+t+ehtP5DfFYv0l0U5UTIm/P+pKp
 DKLaKazHoaOfZWo4fnLjgTCM+iTHjxh9G5PDlUgtp7/lRN3Bgc+0jAZR0XGpM/5Rkxex
 PDNzF25Xtvp0U0dhtqk5IGagQCSGNexfsqpAa+S708FvdS5CqAc948nTr3GnAm7AUfHV
 /ALg==
X-Forwarded-Encrypted: i=1;
 AKwUvByGQ5DNBgbYTeBf/BtZuZ1nkk/8POnJldWqOBGJcjQEK8Cm51ePnBelUr7Diqdn2YBDQZKKPFGgwEs=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8PyIpNlmVDY3mDcg1scy5DGzP6cP/2XV537bGWkNygeeT0cQBo
 1/cTyQLhrPCcqNw2rjq1tHKKy4EzscZtIq6mbH00e+M5sZDszNBaHOt5
X-Gm-Gg: AYBFou1HGgz4d+8+/9ofijbxn+Dw92YYLNM+gSs3i67WqJSe+ADAGjCcjfPU+cGbYmA
 /XZuwfCkmxQ23lftzbuB8vXqJlnQVvMyHlJ3f7q88Ulugo+M+QBLVZ/vDWcl1+KxT3gG08+Uhvv
 okPlod/uCDpJAy7tGCnpl9pLfhyFkpFAlQWhtVgX4dOwvxHoGeGTPUfMY3SXFVSm68yc2QsTIAR
 eRgCNR7mJvEthy70rVwTpgFAZMlb00UTd+pGfcTRAje4hJLl7fFvaidfAu1zbfMKsDnWH+3lDLZ
 M/ZU/xYe9fVNJ1BpxT9G+spBJSZGYJgPoKVW62BYed0kNl7U0Lh57rve9k4xeOidNTQxsxC9ErG
 xe+HXdEGKFMxFn4YjRm7BRYv+xnh0PSkOUnmrews6OsskQFE/Lu2v3/seqo/KFKvSQlx+MH9wQw
 5x0E+YdM+ujxlzsAEgoMzzrm7GRlkdoEadF6Ojk2aXmhKstYUhemNFJFUfqAWJ7y+oI2j1oAaQv
 We2/1Js5Wzd6t1hHdgHzc4//f7j1MPQQ+y3DyQZlnjFtB9sOQaUMZ8WN6FT2g5I8qwqptoNR55u
 gpmKkZmN4DpxaYsfQcdLPi/FlU6LoHgX3IYwEWjC9JxbsW7SW7sYMoSZcfnHB5Qz0ENzR/VXsWX
 yuvhiQAHGr2T/LUZSOtxc2UBzCTolYjt8O3K3tGfnKgpH2Hf8eSWTaytdxgg22MVC3nCMId3S5S
 TobsG74wZwbCXEl2RAssi3zLnDdNRJT7+pwCz8
X-Received: by 2002:a05:600c:3e0b:b0:4aa:2339:a375 with SMTP id
 5b1f17b1804b1-4b6ded4ac6fmr78413885e9.13.1794048438783; 
 Sat, 07 Nov 2026 02:47:18 -0800 (PST)
Received: from localhost.localdomain
 (dynamic-2a02-3100-b149-1401-90c6-65b4-035d-1e3d.310.pool.telefonica.de.
 [2a02:3100:b149:1401:90c6:65b4:35d:1e3d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4b795024730sm47935635e9.4.2026.11.07.02.47.17
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Nov 2026 02:47:18 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Tomasz Figa <tfiga@chromium.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 Hans de Goede <hansg@kernel.org>, Hans Verkuil <hverkuil@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Nicolas Dufresne <nicolas@ndufresne.ca>,
 Sumit Semwal <sumit.semwal@linaro.org>, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/3] media: synchronize CPU access to imported DMA-BUFs
Date: Sat,  7 Nov 2026 11:47:00 +0100
Message-Id: <20261107104703.44111-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

uvcvideo and vivid (when using vb2-vmalloc) access imported DMA-BUFs
through a kernel vmap without cache synchronization. When a non-coherent
importer such as V3D maps the same DMA-BUF persistently, captured data
remains in the CPU cache while physical RAM holds stale bytes.

Add an opt-in uses_cpu_access queue flag for vb2-vmalloc queues to
bracket the interval from buf_prepare() through buf_finish() with
dma_buf_begin_cpu_access() and dma_buf_end_cpu_access(). Keep this
opt-in because some vb2-vmalloc drivers pass imported buffers to
hardware, and end CPU access in process context because DMA-BUF
callbacks may sleep.

This follows the per-queue flag proposed here:
https://lore.kernel.org/r/CAAFQd5Am5jBev5P1HmsdeHoJfROZat3bi1W=UsN7wpVqw-XUQQ@mail.gmail.com/

Based on Linux 7.4-rc1 with prerequisite patch "media: videobuf2: finish
prepared buffers in VIDIOC_REMOVE_BUFS":
https://lore.kernel.org/r/20261026071735.37220-1-kmehltretter@gmail.com/

Changes in v2:
- Split patch 1 of v1 into the standalone VIDIOC_REMOVE_BUFS patch above
  and use its __vb2_buf_cancel() helper so queue cancellation and
  VIDIOC_REMOVE_BUFS share the finish path (Tomasz).
- Scope uses_cpu_access to vb2-vmalloc queues and drop the attach_dmabuf
  dma_dir parameter from vb2_mem_ops, videobuf2-dma-contig,
  videobuf2-dma-sg and videobuf2-vmalloc (Tomasz).
- Enable uses_cpu_access in vivid only when vivid uses
  vb2_vmalloc_memops (Tomasz).

Link to v1:
  https://lore.kernel.org/r/cover.1792392288.git.kmehltretter@gmail.com/

Testing:

- Raspberry Pi 500+ (6.18.34+rpt-rpi-2712, aarch64, 16 KiB pages,
  Sunplus UVC camera 1bcf:2701 and Broadcom V3D 7.1 GPU), backport of
  the prerequisite patch plus patches 1 and 2: eight 640x480 YUYV frames
  (614,400 B) captured into DMA-BUFs pre-seeded with 0xA5 and imported
  into persistent EGL_LINUX_DMA_BUF_EXT textures before VIDIOC_STREAMON,
  then copied by V3D 7.1 immediately after VIDIOC_DQBUF:

  Heap                        Baseline stale      Patched v2 stale
  /dev/dma_heap/linux,cma     8/8 (329,890 B)        0/8 (0 B)
  /dev/dma_heap/system        8/8 (509,818 B)        0/8 (0 B)

- QEMU virt (arm64, Linux 7.4-rc1 with the prerequisite patch and
  patches 1-3, VIDEO_ADV_DEBUG=y, DEBUG_ATOMIC_SLEEP=y): six vivid
  lifecycle cases (stream, streamoff-queued, prepare-reqbufs0,
  prepare-remove, close-streaming, replace-dmabuf) across single-planar
  and multi-planar queues with kprobe counters on
  dma_buf_begin_cpu_access() and dma_buf_end_cpu_access():

  Queue                        begin/end calls   Unbalanced   Warnings
  vivid vb2-vmalloc (SP)           34 / 34            0           0
  vivid vb2-vmalloc (MP)           34 / 34            0           0
  vivid vb2-dma-contig (SP)         0 / 0             0           0
  vivid vb2-dma-contig (MP)         0 / 0             0           0
  20x prepare-remove (vmalloc)     20 / 20            0           0

Assisted by an LLM for code changes, test harnesses and commit message
drafting.

Karl Mehltretter (3):
  media: videobuf2: add opt-in DMA-BUF CPU access
  media: uvcvideo: synchronize imported DMA-BUFs for CPU access
  media: vivid: synchronize imported DMA-BUFs for CPU access

 .../media/common/videobuf2/videobuf2-core.c   | 76 +++++++++++++++++++
 drivers/media/test-drivers/vivid/vivid-core.c |  4 +-
 drivers/media/usb/uvc/uvc_queue.c             |  1 +
 include/media/videobuf2-core.h                |  5 ++
 4 files changed, 85 insertions(+), 1 deletion(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
prerequisite-patch-id: aa99d5c3c27082cbe003ed94a195e3de415777c9
-- 
2.39.5 (Apple Git-154)
