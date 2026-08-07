Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB1DBC5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:10:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E583710F420;
	Fri,  7 Aug 2026 10:10:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="czG0sAtv";
	dkim-atps=neutral
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com
 [209.85.215.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5955610F420
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:10:54 +0000 (UTC)
Received: by mail-pg1-f180.google.com with SMTP id
 41be03b00d2f7-ca766c1c9ccso2480044a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786097454; x=1786702254; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
 b=czG0sAtvOjRCMedDy2/4x7Kud8/YpnuDR1ZU1hLQpJLopEf7NEWQBgMlFzESDGzIzb
 Qfz1H0m5XoLEqOfhTxNLezlwLas8odk4k464RYkveG87I16Biy3xt64Ltziojr4c5sin
 l/C/MoYOHmPlFw1tO/NwB7wtKNXsGfR/h4zn/Z9cetICvovAc0LAUwvi1eUSabI8AYap
 A2tiDiiT6RwaXF8OlKvredKEoQMyPIWASsOU/1saCsc8n6MJ9MWdLNoACY6AgEgQQz91
 RxZnE1IcRNlQbqMK2NAPlBrItp/qBj05988y5C4Ocvk9G81vv71uAKotQWiOZATxJT2t
 TT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097454; x=1786702254;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
 b=AFnhLSJWY7d1kZ0uOuhV0lPnn9/ArHu73exym6ieU3ueUtYN3I6Qs2mOf+CKHPcaXL
 q+iIoKQCzjSYFOSdN3LMwSNcjOCSwwzcyJO3n0qlv8bONNgwzl6EZsPlvZdjJiU0ltYT
 /8XFI8MJ3yTPKaeD2058Oc3TqpYJdk/Osu/Xyvl6PtVSHcUgMXP2Q4iWTl73ERd8WZLM
 uya/1FgcC3OU/gN4ixa5kSKaE2NC6PqWg3vlI9yVcGSQG316/3wCjDvVIPn4p2Z0Bvst
 uPWPZpoJiM/T9et5oqOXyMo04WNZ5resOSx2ThugeovVLZFMPyYdIdIis4ZissngNUdg
 4K5g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqOVYKbK4NphWOPH4IlRmyj8RjTMePeJKI70+HbzATz8kHrx6r3u2Tlop639FBbtwOIzVFAsM9i0P0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyIzJX/UewqOq0ZdBhEyfDwCBYKqo/Kar2YfKLQuKzRBazSwWYM
 kRsJQlhZr/muS12twD39I/utzMPFGRhlqWYptHmOvBbyynqExz0Ui4yF
X-Gm-Gg: AR+sD13cMXzxxTjhZMM4wkMUEkFkHbdCSYCSssU07BMlLBGr4WpNI8xS0qcFhkVMNZc
 Rje/h70qv6G710+5KIw32XRGtF/8EIYCU51153XotW13OaB8ZC9MJiODS0qaF0BM8nbKc//eD2M
 8HqY8P2QnPBcDgotTlMClYM2PYH7bzQJG285aNhtBUUvVLIvDHXWOBgLbDKZX6HawNqREfg8fw/
 Nr9+1FpXxvOaqFndl13wHJnGqyy/yAVtcEOOP2+gWsy2XoRdf3iVL1GCQjBKaI4egyx2xYNoQLZ
 VMi+askz7ao/8iQyjw0Q1nbK+efmTDfOiDH/4fOfzOcmlpZAbdXWgB1q0R69Z4IegR0y2bicPw3
 P65xEw+mJ9h2SnqvvqfXj/P4giuEPLwPXJ9UHQ8bilOaCYvUndfpHCvd5jJYpsV6wsLG942HkvE
 eIjhWkupU+W7htvVx4j72+H2zvIVH08d90JJ8dhDDHpF+vJe8GuJvz6utoxDrPZtXQib78ae1Ej
 hM=
X-Received: by 2002:a05:6a00:8084:b0:842:6a3b:60d8 with SMTP id
 d2e1a72fcca58-84f2e072867mr25591073b3a.30.1786097453818; 
 Fri, 07 Aug 2026 03:10:53 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a51e9f0sm790953b3a.28.2026.08.07.03.10.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:10:53 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 18:10:37 +0800
Message-Id: <20260807101041.1354250-1-shoubaineng@gmail.com>
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

