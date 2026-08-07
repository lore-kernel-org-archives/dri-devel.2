Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D371C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:09:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3B9A410E3FE;
	Fri,  7 Aug 2026 10:09:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Qae7JKO1";
	dkim-atps=neutral
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com
 [209.85.215.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6D4210E3FE
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:09:57 +0000 (UTC)
Received: by mail-pg1-f175.google.com with SMTP id
 41be03b00d2f7-cbb85186d43so1746545a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786097397; x=1786702197; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
 b=Qae7JKO1i8xzRUZUp1GC1nP/k32gzmRybBY5aiP2K+64UP3N+jcQuZ0W29hoVMBpMp
 cUzRi84HrBmLY3RPwGKhbIrFT1ChJIYUEdXbvSnkablkKuT+8Jiv6BXjiTDz7jVatXxB
 LmQdGxL9akPvfQG5fa462wiMozIX+VEHuHIRt8BiE30kKVThzNAW/jKlwYKEyzSvz8Ud
 X/cZ1zNIrQIQguSTGv9eju69t5pGCij1wp8ej0kzkLccOWzPB0ET2lQHsUhgXaE7+6Sj
 Sb6QodSBvdb8P95fXtS7oI2JVIUu+jT36rX4/7r+R4znvSgkc+rW3xgXDMXXAJKGXeLC
 2JeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097397; x=1786702197;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
 b=Td1AqdYtBMIZ/qIfr5+Zit01AQ48CPhHLuhOUStmNTwAoOjCw8Qju2Fnlravildapk
 Tj3z87Pr8gE9GEzl6iWyPqN0gcwjYNfw6r4sgjM0OYkCmHeAGG1GIYhM1LQaHH0qwaRN
 oIfyjFVKexv8fg05MGRqk9KdrF8FhUE1wGcVE0ulvXFrT6Z0p0PmhOQLbxgTX4MmVqwY
 M8vdjsK0x1TUZQMWkMfHbUvCtwasqkoBoYLUia8bM+GJACxTojxeD/o6/O/SrEtHGNQF
 xeKc8JvgErlM+U6JuK4vz7inheEkN2R/vvURcyUn7aHV4APNMqhyF2nLbuB9tqA8WP3C
 15DA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqLy7j2pOo+9U3hWqv6KOnNciIz36F18MgJuCKw84S/SpEY0PzTSNOlVu/Zp3keKPBBe3ofARZRWqM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx9OVHllVajjhn1zNry7Iy+kU3pD9DYwq7uEiief0I4NRwsEJw5
 oDKO7iKxcLeGuyIKF2dTwqX0TgP4wqD79T5Qt+zVldBNGUwF/7xXZe7a
X-Gm-Gg: AR+sD13rj53RIKbmf9odNAP32Dp20UbTCI6aBQCyzmkOlaFncyVE6lXPTWEBdysGcjp
 /ZfYblsGY+qj9dRrsStlFE0UkHI5ddX008z0repGXg0QV9cjD/CHw+ZMfmZsZQsSWaPccttlpIn
 jejMZl1hz736sr4KYvV2yorIAt4Ry04Ggghf5z+w6NEvQpDSnR4VwafjlwxuVBrymN5fe+zCBdt
 jFaX/bN+k+B7f72gMDiejstrpihRrRityJoLnjzSIGTM5oJaDKekrc9UbXRHj0GAjqI9cCl2eXn
 xeTQppa7bzm8SK29Tbv3Ul4tDgHA2MAuY7x1zV2scxWuCN6bCBRWBBEI10ed6BB8jLzEIQODGLP
 +2HrwZ66Q6yA31UZqsbfqJY6/IrzUiT7TMoYLcDm6MKwuv9RH4D57R9ZqEVxAS1jindOYyHrcur
 tSJSkxvjQBauNNiiO79RLz52ANzMGeBycY5vJ3W//TmBvnGbeayIvQ7b3K/alQXYOT0K85ECcAs
 MA=
X-Received: by 2002:a17:90b:224e:b0:38e:9ef9:eb97 with SMTP id
 98e67ed59e1d1-3903c5c443dmr18527888a91.16.1786097397142; 
 Fri, 07 Aug 2026 03:09:57 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39085de8ddcsm4363444a91.6.2026.08.07.03.09.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:09:56 -0700 (PDT)
From: Baineng Shou <shoubaineng@gmail.com>
To: Sumit Semwal <sumit.semwal@linaro.org>,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: stable@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 Baineng Shou <shoubaineng@gmail.com>
Subject: [PATCH v6 0/4] dma-buf: fix fd leak when copy_to_user() fails after
 fd_install()
Date: Fri,  7 Aug 2026 18:09:37 +0800
Message-Id: <20260807100941.1351356-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
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

Several drivers call dma_buf_fd() — which internally calls fd_install()
— before copy_to_user() returns the fd number to userspace.  If
copy_to_user() fails, the fd is already published in the caller's fd
table but the ioctl returns an error, so userspace never learns the fd
number.  Worse, the window between fd_install() and copy_to_user()
allows other threads to observe and manipulate the fd (dup, close,
SCM_RIGHTS), making any "close it on the failure path" fix unsafe.

The fix is to split the allocation into three steps: reserve an fd with
get_unused_fd_flags() (not yet visible to other threads), do
copy_to_user(), and only then publish the fd with fd_install() via the
new dma_buf_fd_install() helper.  On copy_to_user() failure,
put_unused_fd() + dma_buf_put() cleanly unwind with no user-visible
side effects.

Patch 1 introduces dma_buf_fd_install() in dma-buf.c (wrapping
fd_install() together with the DMA_BUF_TRACE call to preserve export
tracing) and applies the fix to dma-heap.

Patch 2 applies the same fix to fastrpc, which even had a comment
acknowledging the problem could not be fixed before.

Patch 3 replaces the bare fd_install() in drm_gem_prime_handle_to_fd()
with dma_buf_fd_install() to restore tracepoint coverage for DRM PRIME
exports (suggested by Christian König).

Patch 4 adds a selftest to tools/testing/selftests/dmabuf-heaps/ that
reproduces the fd-leak scenario (mprotect flip before the ioctl) and
verifies the fd count is unchanged after a failed ioctl (suggested by
Sumit Semwal).

v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubaineng@gmail.com/
v2: https://lore.kernel.org/dri-devel/20260710105430.3059661-1-shoubaineng@gmail.com/
v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/

Changes in v6:
 - Rework the selftest (patch 4) per review: extract a count_open_fds()
   helper, fix the copy_from_user() comment, fail (not skip) when the
   ioctl does not return -1, drop the bogus mprotect-race mention, and
   reword the result message.

Changes in v5:
 - Add selftest (patch 4) reproducing the fd-leak scenario (Sumit Semwal)

Changes in v4:
 - Add patch 3: drm/prime: use dma_buf_fd_install() (Christian König)
 - Add Acked-by: Christian König to patches 1 and 2

Changes in v3:
 - Split into two patches (dma-heap + fastrpc separately)
 - Add dma_buf_fd_install() to preserve trace_dma_buf_fd tracepoint
 - Add fastrpc fix using the new helper (T.J. Mercier)

Baineng Shou (4):
  dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
  misc: fastrpc: don't publish fd before copy_to_user() succeeds
  drm/prime: use dma_buf_fd_install() to preserve export tracing
  selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test

 drivers/dma-buf/dma-buf.c                     |  20 ++++
 drivers/dma-buf/dma-heap.c                    |  80 ++++++-------
 drivers/gpu/drm/drm_prime.c                   |   2 +-
 drivers/misc/fastrpc.c                        |  16 +--
 include/linux/dma-buf.h                       |   1 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 113 +++++++++++++++++-
 6 files changed, 180 insertions(+), 52 deletions(-)

-- 
2.34.1

