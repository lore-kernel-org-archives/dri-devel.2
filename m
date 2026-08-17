Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1799C5DF6E
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:05:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EB5DE10E2A3;
	Mon, 17 Aug 2026 05:05:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aF1Tme4d";
	dkim-atps=neutral
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com
 [209.85.210.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00CC410E2A3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:05:07 +0000 (UTC)
Received: by mail-pf1-f171.google.com with SMTP id
 d2e1a72fcca58-84874b52eabso3966215b3a.0
 for <dri-devel@lists.freedesktop.org>; Sun, 16 Aug 2026 22:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786943107; x=1787547907; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=2tRymJVpfolTktQlDrFjsDnKawKa4L89cQfWtz9noeM=;
 b=aF1Tme4dPybnyMzzHg8Iy5C/tINeuQNm9sAHeIykXVby5VdiKcBaDsr2Uh72bJk/C5
 sd3vcm+0e/F2MdBf6vxw/cF+HPfQXXXGwUce7py5tPSU2sj7J1NE4D5yQdkCiyZvMEI3
 4pKKTz85TA9pbSCkSTPRu0TcqI8Ul2aTPG/pF7Op5V7L1PBN1a5fxcri6nPUMDjOiEQx
 txsT55moS6r7qZdImWGlBIX2yFiZKr6M4e4I/0/Tunq5mvhYVrFf7rXDkC1HnhNFJUH5
 mAE2S01lfxrd1mId//fTn4jZrCd6dJ+trngfv0pbA2GFeMx0o1ZX476QcPMoVa04+WuU
 MyDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786943107; x=1787547907;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=2tRymJVpfolTktQlDrFjsDnKawKa4L89cQfWtz9noeM=;
 b=E+eG1o7kuxhYjwm7FeihNTe5CLyL9ipkGUUnva/7CYpc2zWEXFaGdlnEosp1S+Hf6X
 +X7FTHO9KPbrZxO3n0NPT6TF3iRaOzs3dADCaRnyrg27a4SX0gO+OfXFKD/oMFUS8zlA
 6tZiZAVvijs3FPhPYuIhiCdsh4i3x4aD64al4QJLHlmkVwEWE7dsHdP0PxenkQUlSZ51
 YWLyD5Z+uUsoiqa7MT/owj7e0uyKjHVFa2Juc/kwvTPmbcHEmbph1jFL1iPKBSbVdd/a
 UZV8eeoc98Z79/062P2lph3xnTUctUpeFBSEEmeECq2IbEyyvFIGhbKonkmFZLxOA20S
 zgKw==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUAwGe6fs+CVyT2FMLBaL94OjbTegxZzTuWk+/2XI9HktaV4VHKiBh4qrxffrcI+zsIGElSRIHU9c=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YylKhGBVupJcmCTVxrqhO8HrlyUhEsjQMEtyKH7t9pDk8VVlwcg
 YHfzGWrI3Ct0hDMU8kxKGOLCiCBelAhD7COvGPoa3AhosdlBcw1gsW0Q
X-Gm-Gg: AR+sD13VIt+JHqsMTSq1Hm7JEfZmgfio8ikwmxlVikgb8HOm3CSjPyLOmUvmNxr2mqF
 tI8FAD6PrC+yzezoe1EyQRa4/MyMw7PK2PNe6Hxho3JVEMI2xD4oKK2rSlot2kH51iDhRk3wpGw
 WSxJIIYe6OToA6fdOwawmfWdZq2v88RnkYcUzW7idI6IC+FxrK0tTS40H8hjyLAgtt7T0AEFqzp
 wT5eA6Tg6DmnVtJHgrVvTRQjKolpkekfW7kbA+6UlC+lnypa7zwTOkMa5vkBhluh7N3gMrwoJJ+
 Blo6HTg3BW7gqt1f7bZczbUxsZeZnkKnZ4kk7OWpFqi6YHE+RdsqLTh8qDd55vsm/+fhl7beND4
 HsQ/4J3x6bCEek8WctR008WVsy10lE59iwuQWhC76PiQP3NncAf118X1cirm1wlV2Ire0Mm3juF
 OvSXkhuIuO4UvbXa1koQM2U+gCVmTyWmmrbRShKAFrHmw+7ssKAF22R2IOdil07AqS
X-Received: by 2002:a05:6a00:a91:b0:847:893f:2d0c with SMTP id
 d2e1a72fcca58-84fddf924fbmr20940617b3a.5.1786943107383; 
 Sun, 16 Aug 2026 22:05:07 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8517d267310sm2131036b3a.53.2026.08.16.22.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Aug 2026 22:05:06 -0700 (PDT)
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
Subject: [PATCH v7 0/4] dma-buf: fix fd leak when copy_to_user() fails after
 fd_install()
Date: Mon, 17 Aug 2026 13:04:53 +0800
Message-Id: <20260817050457.1005285-1-shoubaineng@gmail.com>
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
v2: https://lore.kernel.org/dri-devel/20260710105740.3080070-1-shoubaineng@gmail.com/
v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubaineng@gmail.com/
v5: https://lore.kernel.org/dri-devel/20260730062645.233148-1-shoubaineng@gmail.com/
v6: https://lore.kernel.org/dri-devel/20260807101140.1357218-1-shoubaineng@gmail.com/

Changes in v7:
 - Add Reviewed-by: T.J. Mercier to patch 4 (selftest).
 - Add Acked-by: Sumit Semwal to the whole series.

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

