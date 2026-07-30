Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB619C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:26:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE4BC10E09E;
	Thu, 30 Jul 2026 06:26:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pavVwJcE";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 190F810E09E
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:26:02 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2caed617615so21608675ad.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785392761; x=1785997561; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lC5eDEn/dzL9Eec299VWkBRGUg0dXbB9NQvY7s3O+kI=;
 b=pavVwJcEwvHc8C87TBwFdlCWTyjcSwBHiOCcy+yHRH2YP8aEtIJ6Yi5ZUyojxf5DLd
 Zixyq6NYZjA88Yc1mMR4xSHSa6WDNPro1LBrTvGvokPltgQel9GfsCp+oLxFnv73Niwv
 p24KCSfeUQnWChOmKl1DYEpyPZqXphqnWBtiE58Vi0MEmFrcGCADCvQBWvA6qem6ZV5Q
 cVF6pgqWCX2nhMon2WZl4hq+jHL2UaSNASuYEy9VpS+9R1XJ0r04G5MscsUdb0yIiUeu
 0wE/3R5PysPoxzJsxCdsUY4c/D3qYio16Hcr8thQcUttgg2RPjrvVgZVmlgKysJyrjay
 4YYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785392761; x=1785997561;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lC5eDEn/dzL9Eec299VWkBRGUg0dXbB9NQvY7s3O+kI=;
 b=PQ3Wlc2u9NIJL0BIaUAg4MykUq1JuuNXI3ONYITbd/tIn9/Fouu0ci3nbNIBXPZhlt
 C40VZIYyQbSHY0OnGxNLOnbwZ+HdnjRJrXab+oD/pU2qeJ2e8aNYCjhe71oPbT+xjovO
 AD+ycPbAyE8K0qDPNBliiMDEp8ppFTx90GzJHlVBtQBqFl6F3BZrMRSKpoYGtybb1S9N
 h9nRpYXwQdI287Ht0sVQn07G7C/hjlp+p8LBniBXQEqY9g3bBxt6oG1OSLOjhOmFqJSH
 EtinSqB81n2uPsNxCasWr+XjJB7L7uaDdtwOUEKpQODgMU5UjZUogoTxqaCkm7944EP4
 aEcQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpNU9N+L2u55iZ/p+L4ovztPTwmVv46I010++lTYQT8/Ah7PCKqbsl7yJUHhnx6X1PHbuKTZFk6tDg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRms9BAWcIJBZ3TAwW/q8WJuc9ybQlFRwhvEFmf6KkrTKBt2Fj
 L4JnsKA/z1vOvyTjfweKPFQO4Tymt7FB06lvgDYAZn/80HPUYckHtsPI
X-Gm-Gg: AR+sD13hjz5090qjJPNrfqVKEOWsKDCM9FDlYZ0y09AhR16gOpQ2T4OvPmATtg4UBG5
 8yzUvj1WMefyqmIhNkiVJOXHCg3Ou3uZ1KXYh5THr/SVGNZqEv9GDDBwE/eMqgYSHacEyDZlvtH
 79jTFQCFb2wOMQNJTS85ug148L23ISqFSeuAssw33H4OjzDRgy4JR+f5Vp/suTkxXrh0mRZG4wZ
 iCCMAskyNcre16dZAFx/vp6kS1DZ3HXFkXeXYHntTn8ZQny719I38rEl/AnJ4MFNghQFOveEOeo
 akA1BWKDaCvhywIQtmP31zoEHrURf1aHNGjMaFjUu0aTH1Ci9wIF1RLXYK8U9XyQay3iuiUrKEo
 Qfe8i/qXY9gsM4aVFqwdHdMr+qyEGTxiHy0ns9cHJETCiIhhkAeNc+c1+T5vXrDgvFJI0+khlSE
 RZnetdJVRcnvHEqbR5kw3WQg4Moqs7UCPl7VH+R15l5GXKyENqApPtO15/AkZDYaHZBcGmvERKy
 rI=
X-Received: by 2002:a17:903:238e:b0:2ca:e62c:9e96 with SMTP id
 d9443c01a7336-2d035c1c8abmr13935955ad.5.1785392761489; 
 Wed, 29 Jul 2026 23:26:01 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bc9bd4sm21059695ad.48.2026.07.29.23.25.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 23:26:01 -0700 (PDT)
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
Subject: [PATCH v5 0/4] dma-buf: fix fd leak when copy_to_user() fails after
 fd_install()
Date: Thu, 30 Jul 2026 14:25:44 +0800
Message-Id: <20260730062548.231239-1-shoubaineng@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
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
reproduces the fd-leak scenario (mprotect flip between copy_from_user
and copy_to_user) and verifies the fd count is unchanged after a failed
ioctl (suggested by Sumit Semwal).

v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubaineng@gmail.com/
v2: https://lore.kernel.org/dri-devel/20260710105430.3059661-1-shoubaineng@gmail.com/
v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/
v4: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/

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

 drivers/dma-buf/dma-buf.c                     |  20 +++
 drivers/dma-buf/dma-heap.c                    |  80 ++++++------
 drivers/gpu/drm/drm_prime.c                   |   2 +-
 drivers/misc/fastrpc.c                        |  16 +--
 include/linux/dma-buf.h                       |   1 +
 .../selftests/dmabuf-heaps/dmabuf-heap.c      | 115 +++++++++++++++++-
 6 files changed, 182 insertions(+), 52 deletions(-)

-- 
2.34.1

