Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 826E5C5AC7C
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:11:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96B2410F408;
	Fri,  7 Aug 2026 10:11:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="DYhehowW";
	dkim-atps=neutral
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com
 [209.85.210.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABC1210F408
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:11:52 +0000 (UTC)
Received: by mail-pf1-f176.google.com with SMTP id
 d2e1a72fcca58-8485ef63b68so4727481b3a.1
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 03:11:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786097512; x=1786702312; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
 b=DYhehowWC1LGU4+/1WM84M6c/azg0JI8haypPdp1k0fjrJcSULw10M5mtwCjADHlAJ
 XtfG7EZUDGtYtftY+lwzA8iJFC4dtSoIut99m/n+dqgB75HaR51420Td7tXUAP9gSPWK
 QyfFg2r1Pm0CSoPxSYxjEDlzY2Ro5Q9Ks3Jny64jCKRyPhxV2QqWRkH2XGtI7OuRwMGY
 1/UYe1uJz8OD+ZiAqG1tSEahCM9Y0xG+x3cQLDwDLFgpGvNSv6RREQN18sbH3Qq/q7H3
 6b+6dnvjdpSqujEvxdLerWpWu9ORse3Qlk0Mx0PLpeoObD+PhT/foCJEHlk7yi4kb0oF
 XpRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786097512; x=1786702312;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MQciLaflxhQrAIWokNvSZ9sUyM0S9LcjwfcEZLUvgpA=;
 b=s9Wu/NYXLMN6pbUzlY1JGE3brksBuQc3czj9B5qKrX84y9oKjRSpCULxc5budaVsIc
 8BEK0V5TiWiupkQ+ASDHO4DfXwWx6FBGulZgevhJmEoP8r5F9UkWan93MMPUMND2asia
 vwQyHPLMm4eJDFJjVNYZ9VlzQ/dWt1L+5IbVpTn2TQz3ka9fHCkwqw4S5MHRIHkgni+O
 eTqXaVeGN8ozBiKEStzLyyEYhLKn123EqYPxNhyiYWmqGxebvFjcS2RslmdvitQmgylJ
 wksI+WcNgfoEmxijnqU6bVL3mBUulxaNDmYpYZxkdGPiop1bkg4xex9dUclQSRnuPcP2
 FCHw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpKXcYr317VunS1zbIrL2fzwIzFoCDsxZP1YIaHHh4qTvCR9vED0BqBxRIDeYhO0A6hyimCbJrNjKU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw7a01z10oR1O+qsA6TcVaTek1JJifqQgPq+FJmWVKUXKMRDBi/
 wAnDTyu1IHz+VPS7hGmLudPllMK0zhR7WoEECQolr4Rk7oD78U2im+nc
X-Gm-Gg: AR+sD10yfENPW05owK8j+I1KMbrTgLKn2PIz7tdXxWMykEcaPYCKuKguQ4t6OIWD+iY
 JRhIjSCkuKO9a3+BjIVrdq2SkU8De91wPd8Pxjnr3H+hYTgpB+eacvbIu+BxwU3wwPiIDsiKewY
 l8NB39h03oPt+s+4FnlnQ4xQqAQ/OQ5M+RWPamHT1h+g83CBQPywRN35dY+twVFUuNy7ocMcsnb
 RD/OIsIW9NlxkI/DUVK0p+CmTXYfJAFvxSXXukNgAe5OJ3uCQ9kDjUHelIlIXNrkR6Uj7LW0yxz
 SpUar/j8kxvFJbneEevySF1bxB72ZOuir8xQbgjqj7w/OrbSkB2drOyKilJ05HnmMHeAZj7O8/h
 gqhyNHtAONg/SuYPnN1y0nOF+dvqRlwRpNUhAhm1+N4ssmRgUf5pMnHmgV1WvCQLTydBIC1ET8W
 EmAgsk/+ZfxRxMhhjBgmZWnogWlc128/eGbkX0hgM+CV0u4yhXt714BpAbmQAF7h7k
X-Received: by 2002:a05:6a00:2999:b0:848:67ca:bfd with SMTP id
 d2e1a72fcca58-84f2dff1913mr26379534b3a.16.1786097512040; 
 Fri, 07 Aug 2026 03:11:52 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84f5a5528adsm797510b3a.45.2026.08.07.03.11.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 03:11:50 -0700 (PDT)
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
Date: Fri,  7 Aug 2026 18:11:36 +0800
Message-Id: <20260807101140.1357218-1-shoubaineng@gmail.com>
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

