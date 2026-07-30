Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8BA4C531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:27:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0F58610E105;
	Thu, 30 Jul 2026 06:27:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="UFLYfRpb";
	dkim-atps=neutral
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com
 [209.85.210.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0DDBF10E105
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:27:11 +0000 (UTC)
Received: by mail-pf1-f173.google.com with SMTP id
 d2e1a72fcca58-848595b338cso2189712b3a.0
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 23:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785392830; x=1785997630; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=lC5eDEn/dzL9Eec299VWkBRGUg0dXbB9NQvY7s3O+kI=;
 b=UFLYfRpbHvaQO5zmRLWIGZqS11A/wjIWdfetHAw06NzdL/83KPWqd9ZmS5HpQ3gquu
 TljpzmOYZStob60VzvTugPKKAxqNxets9GxLVGA+Sp/oY3/ciXBESMTJSMYPuPIP3uvu
 KMqO30NQ7rVsb0A7G8rsvhepH56Vq6NTWP1BFZocn7BboMdS8/LPr5SxICn9hppdcpO9
 AFrlL7dqnzqMKL2OQXuJS9j+jmuJQOCM5vMbZ2045n71B6b2o+wD/+qkobb0kO76W24X
 AciB2D90Ud6gcJU618g1P+7lLRJHpqZw7jQR0JSwx3WCufLZwDJV1LWVWt+nNr/xIaPD
 ikSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785392830; x=1785997630;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=lC5eDEn/dzL9Eec299VWkBRGUg0dXbB9NQvY7s3O+kI=;
 b=Bb8GqrZoysthPe1/A4WzeR6LMreJrXwq3BiIRSq3utDOmuKz7/g7U/1mhVn6TrsSxB
 gyoCWfoPPbfJ9CLugm45zAq8Ro3gTU3QESZz3LYXwuxzHE8tZs7FNLx2KAuQaeCW5RPS
 g0Al3YV4Yl6s5v8KiAT5thR85SEP+L3TgcmbNTpDdj0pNTZt2JdLkk5tnzD77sPVNQXV
 5euppGuS+yHrd4rV0lBvZu+25scC0pF8dsXKztSTS0rJJYrPIwlyF7XCUiooyPUuUABg
 yLYCduyaX+l+KjqLlfjYiC0oepixJCweLsSlbM4rBdNNIRWoB6N5Ii67yA5VWpmZeahj
 Qu/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RqsbJQQhLZ3+hooR3GB1iDdZSJ6//MYmaZow9DpnvrGoziESdZbK51q8abRwCEsTipm/osiNHXX86Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyyiJQZOmg626n7/bP4oh0yM3x6Lx1iL2NstdHPru7bjyRBK3+l
 P5p860Fy12sFYCJmlKaEuAnfSSyAfMFsJFU8kg9Wyft7fi0BPuvvrysX
X-Gm-Gg: AR+sD12bWY1yp4GeTNU3YUhYi5gLMP648z8K9rUOhpknivTOYsdgh1/v5QJWIOXHHgR
 wVuAx/wkC9xRQG//KEhk6hvGqzlju0j3FUq0jwybEsFILXO+GNiK/+puXXuMozj8sT5FI/Ai1iv
 Hw4SBvL37LtOV+aB7PYRjq+IjitYXIRQzHKTMHyLxpENtmHuAVhRffQLHwHuNH0xxDhmB4zv7oQ
 mGvH5HtC3TMEYAYnx0yyicpSDAv95BxDlBA0bh8yW4nWKdrLnzb1+iYZkzgJVF3U7GnBY5CQSHf
 uMS8V3JReo++lSfV045gQlDgJ2WvQuUXXBRWtWE+ZPHlGpW8TYHyhUf+KouRH2LmX/T7HE3k1tb
 eUXaZTz29GzoWfWbpmzV6UzP8YbSrgvtcOokSmJy0D9FUkyfJiqMA/RXwidCpLujX2b8+VVmb0v
 XxNRKAIOs0P+iHSNexbaydfVFLqaCaRoE+QNMHCv1qvbbeCR5acRyjQMU3NX3DTOYQ4O7Z6UuZf
 +s=
X-Received: by 2002:a05:6a00:b44:b0:845:e8f3:bdd0 with SMTP id
 d2e1a72fcca58-84ebc2623b1mr1371121b3a.33.1785392821527; 
 Wed, 29 Jul 2026 23:27:01 -0700 (PDT)
Received: from baineng-pc.. ([117.133.183.252])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-84ea00507b0sm2503229b3a.14.2026.07.29.23.26.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 23:27:01 -0700 (PDT)
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
Date: Thu, 30 Jul 2026 14:26:41 +0800
Message-Id: <20260730062645.233148-1-shoubaineng@gmail.com>
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

