Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14623C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:11:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 35DF010F440;
	Fri,  7 Aug 2026 10:11:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jzk9szBD";
	dkim-atps=neutral
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com
 [209.85.216.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 922AC10F440
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:11:17 +0000 (UTC)
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so3122481a91.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786097477; x=1786702277; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
 b=Jzk9szBDStaDMuxDPgbS+kGb8Ge9ITkzKv1VezRn15Ns/Mn2EGO5ZXBbOdMaws6cnd
 P+kWjKGyD202c8zkAfoEW5tr0oVK7N2bFV3JzlNFjFtG8qLLj5Nbbt2A1UVI69EOTt0y
 ASoCNe1wN4EODNJ/DX7G8mDSkKpbvFgZ7U1DAaiC7JR+rPbzlZW0ep0cBC8bTtrtgIr/
 kjhofL/JxMVw08pHbEItFg3pDLrcP/KUuqM6NhmbTSu2Yw241x9MvE2SuHVP2ka5qOrm
 9TjFTaiJrpdVlXp4dZeCioMi6JYSVdOVKoJYOyLCf16vkEfRmwwjYgcrhgNvgSpprBd/
 vMXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097477; x=1786702277;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
 b=VMMRmoaDB1Yk9e1UH/4WOPVki50h8UyuC8A3oaeTj5fsDEbMYqeHV3POmvGB3cSDaY
 RoMeKeGzyAUZcEAeHGdQKMJm1Ht6byP3Qjg4h4aRnMtjRKZUlsMYg1FttMr72XSdC0Vo
 IJEEJw602rwwdx+IV37bO2SC9i6dr7N0D8VKG/i/+H9Eit/F7FD4vqgdBy9o1NWIpIAU
 EbUzKhjUHmHkVUpIqXAgvqa1SkjM83/7iuhTGHeyP0d5G5qICvb92LxpWSw6QeY+0717
 Mwr1qJJFxENdNa2Dxvj/ZXpeijyIKSgBBzHkGaotiFEIYy1oDdgY22JtgZxNY37MQiOj
 tujQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp5dvNyjBroHnOEm+6D1uMtrgjSaKDrMzdlqsXeBxHpLOixVpUzKE19gZu2H6d2hYyGB4vDinaHQd8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzglBNVCjMwjh5gMIMyCWyoDbqrLuVR7V5jl/0oqcqy8+G+FCPp
 fyb3K8h4fMh6uHQtzNPQZhGDaTRV36eIthTANUjduzSScCoBgd32yMsy
X-Gm-Gg: AR+sD12zO/P2ci1YZBY0PgJavDKucoU3YFoU45LXNc/5IUiraPU67o9KxWnrsY/bVAw
 9a3FuUAud/bpPiJ/qHeyLlJTFZwTnrR9uoVLWZUlL85jWBxIkodmHl7iGIY/dvg1YRC/yv1U1iJ
 sAn26wQFD3UHWGHARd2eViUClelMDVWYmvAR6xS2vARs4R/7CCC8+LO7bVIIpc0IcVNGtT8jF9R
 n/GMrUsfeM+VQic+oPIxvmTKgHOjP+eKl9naLt+wDOgM3TOc6JAkgfVgA6bO5uA8aQlU4pQ/oaR
 7IvmBvCaf0dmbJv0DyOaCtNYAqB8QounTsqmimH/GH8KFdsFdelnMUjIJGpVtM/RKTapEKWv7e2
 Sj+PtfIRvgtE0T0BK5wH+l+jrgJ1zoSTfV+ig665gX3w1HsUG36336rN9h4AP6pYa5pNWmeTWzx
 z40I1vpwykRMGOTLjN931xIsiEIEMXIKa3pNe158JpD5bOtc6lILPoPVC1p8cAMmOXt5FGGaVNq
 UI=
X-Received: by 2002:a17:90b:4d8c:b0:381:6c5:3f63 with SMTP id
 98e67ed59e1d1-3903c544f17mr18302876a91.6.1786097476902; 
 Fri, 07 Aug 2026 03:11:16 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3925fc6c13asm1928581a91.2.2026.08.07.03.11.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:11:16 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 18:11:00 +0800
Message-Id: <20260807101104.1355464-1-shoubaineng@gmail.com>
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

