Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DB44C5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 15:27:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59FDF10F077;
	Wed, 12 Aug 2026 15:27:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="Kis+09mI";
	dkim-atps=neutral
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com
 [209.85.208.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDEC110F077
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 15:27:17 +0000 (UTC)
Received: by mail-ed1-f47.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a28cbdso1882642a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 08:27:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786548436; cv=none;
 d=google.com; s=arc-20260327;
 b=NjXe175pyMA/QtRi8My4w9ynQzPB6GIc6acf1IK7Yof5VX1OJ4eX0AXBytR/6GN5eE
 6K5BuJtZjYBKFMy64xiol0JivwkA/0tRwnfAYQQs1BsdsgcKDLrZmicW7tBrgRxE6XYa
 Ff2pyPb0A9LDTqgd/DVmYiQl72DsDn9qQzwWDKSiuV9DxvjgsULAjAusSI0K3jWhuFxd
 Xfd7uuOj0/gm8C/h26+t7JlgEk9HAAinhegFT6obzjOLtMIv1G18VQC3j79pPW3kVhhY
 a7IXVq9HV0oeC6zY6FropVeKNIhwGSXGWXSOMa6bXNqiqsl9QxXbpwe9SpRvizoTGGch
 1Wxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=9HQw24hdIiiBy71zEiY+V8zJ9GZN0hXXJxvtzQE5bgc=;
 fh=eNaJcHVKhKcARnXoBZ6YvKlzCRArTa4qgN/vMxRx9ns=;
 b=VxurBI1X9TFRuI+JdIZ9LXRzep6Ix61wMd3HozKAVFDqy3AZp2MTIbxsnK6QhehawV
 4BI8oCUL0zLLauX3Wnv3wd3cfN+w/A5r9uwrGJqtdValBdVcANk8Q89s60EZHf5X/vnI
 q5lelzsw+SLn/L+wPNbT++Ap/DbiZCIqgmwoY/xy1co55sNJm6biw7AtfAf8TurRjYN5
 tUWU7UzaKTcy4SszW2ubXeY/QNrY3/yY9XVuup4aMwcxa53T09AFLqmZL2HuPxmr2cNe
 OKNo+M18Hpa0hMHZHgSE0sF+HXDsFOrWNxXvgAL0wywTT2FdTlAu6jxrvQcwi1rLcqYk
 O2Lg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1786548436; x=1787153236; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9HQw24hdIiiBy71zEiY+V8zJ9GZN0hXXJxvtzQE5bgc=;
 b=Kis+09mI9WSOyoNcJBMkYBIzkYDanQtej9zpqa6B9Nx9H4rLVjw1CQyySFVnlS0Rct
 fBONvvRJxV4UkNURCe5GJ6vbh49Jy/iSPijfSEYKEmRL6/fdp8EQVpOMHhqw87OP3Q2q
 GDmdYW2j8e0gihfBkqU92mqnvsXE66DDZCipzPoWjaZyYUV/bHToOqDIBDeiRM1TgP9d
 E+GH/45LOUr1ajkNrAEyHjHH/8wRykRX0cMfTWT8A4AQ9VAXX2dC396OrmDe9dv8IuRC
 4lrvnsWfsBoC2J47EyNqncz6GiySk59PQK/p8Y0bNBh4NGo7YHPs7G/Z9PvfSbJ3Hb2e
 tQ9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786548436; x=1787153236;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9HQw24hdIiiBy71zEiY+V8zJ9GZN0hXXJxvtzQE5bgc=;
 b=gyK+/57h2wB2v6dB5DDzvyGKSqOjgzGMt46egbc2kKK7VvbN48U8saY1vD/lUsLqOv
 TPr5gTo7GrB3EF4641gqkfsM53X0mUd7NC4Gn2FovRZKcGNhOKMuQtPKwi8P0RQb5v2F
 oWKsWgPY18VP4l0nN/BBD+nUPboiJVHIUphryJD7+Y5ZRBX7kMLGb8q86pS2f/UiZEzy
 /6ybL5UofHbTQGgP4UohJj19g5F5ERO5d4YJGMzQ+arZzkyM5p81lNo1si50leNuEjkL
 5ckVu2gS7VrTl/LgEWskF7p1VrjMiRmqz/oXt0s8T9xUWrddwlO1L6gxoIPm79vLZj71
 vNlA==
X-Forwarded-Encrypted: i=1;
 AHgh+RorVpKGcIL8hAel1CsIkdWhUU+ghG33L12lL+DuKy6vfY+uTDtNy8wn/6vg++u7tlTG49LYo64J2sk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyxcEinG7GFlOKeNwK5Ol+vmw6mRoHUetdUutqirYqDVXXERaF2
 0vKdcrjTF2OW9y3sVX5oNsYz3Qxsf/WRkoWgbxXrWXVpVHohOx75BxUEL/AYa6IQvMOSXB2uY/e
 SJG9w4BjUmEfD4jfBprsHUO0eZcAx7kLHGoEY0Q5q0A==
X-Gm-Gg: AR+sD10aTmN98nw1fq7OZrFqPn7ET4GaiTjoPmTYKmRvAbWVFj9r4X1O6Rf6SA3Du1+
 rD/xBSkw+POab8xZfEVc3lhdSV8iQsLxjONFaZY+518h/grvlc4ZnaZkNwiBd5esxnLdRM38Ztk
 yW1bwYi08x5kAESPj4Em4uXOxE+BUaTpJb5ySKeHZTOol++vBcw+5zwJXGRNtVvJOopyHbUoFQp
 H/9Gk5bBd72p9tXjGBY3qHOxhPEju1BZkt4/Ng8A3/o+VX/+SWtUr7ibnlwQ2uCZeXx3pFtzNwC
 fo9CdgZz2U2BtahEy1DFgp1GDN5TMV7TXViB4bEG7velFgcEdw+IKnqn1RpxNWg2/zyQaJX9uw=
 =
X-Received: by 2002:a17:907:f816:b0:c20:2d38:e518 with SMTP id
 a640c23a62f3a-c20f2e66a3bmr273702966b.2.1786548435676; Wed, 12 Aug 2026
 08:27:15 -0700 (PDT)
MIME-Version: 1.0
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
In-Reply-To: <20260807101140.1357218-1-shoubaineng@gmail.com>
From: Sumit Semwal <sumit.semwal@linaro.org>
Date: Wed, 12 Aug 2026 20:57:03 +0530
X-Gm-Features: AUfX_mxKHc0XJq4SFZbCVvYoj4A8ln1CqD7e7dKrGyTLzT3rZmWFByVVhkPNP5I
Message-ID: <CAO_48GHc2TQJ9baa+EYst5vR0qUYvRVj=r8F9hxMLpySWE5+QA@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] dma-buf: fix fd leak when copy_to_user() fails
 after fd_install()
To: Baineng Shou <shoubaineng@gmail.com>
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 "T . J . Mercier" <tjmercier@google.com>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 Sandeep Patil <sspatil@android.com>, "Andrew F . Davis" <afd@ti.com>,
 Srinivas Kandagatla <srini@kernel.org>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 stable@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

Hello Baineng,

On Fri, 7 Aug 2026 at 15:41, Baineng Shou <shoubaineng@gmail.com> wrote:
>
> Several drivers call dma_buf_fd() =E2=80=94 which internally calls fd_ins=
tall()
> =E2=80=94 before copy_to_user() returns the fd number to userspace.  If
> copy_to_user() fails, the fd is already published in the caller's fd
> table but the ioctl returns an error, so userspace never learns the fd
> number.  Worse, the window between fd_install() and copy_to_user()
> allows other threads to observe and manipulate the fd (dup, close,
> SCM_RIGHTS), making any "close it on the failure path" fix unsafe.
>
> The fix is to split the allocation into three steps: reserve an fd with
> get_unused_fd_flags() (not yet visible to other threads), do
> copy_to_user(), and only then publish the fd with fd_install() via the
> new dma_buf_fd_install() helper.  On copy_to_user() failure,
> put_unused_fd() + dma_buf_put() cleanly unwind with no user-visible
> side effects.
>
> Patch 1 introduces dma_buf_fd_install() in dma-buf.c (wrapping
> fd_install() together with the DMA_BUF_TRACE call to preserve export
> tracing) and applies the fix to dma-heap.
>
> Patch 2 applies the same fix to fastrpc, which even had a comment
> acknowledging the problem could not be fixed before.
>
> Patch 3 replaces the bare fd_install() in drm_gem_prime_handle_to_fd()
> with dma_buf_fd_install() to restore tracepoint coverage for DRM PRIME
> exports (suggested by Christian K=C3=B6nig).
>
> Patch 4 adds a selftest to tools/testing/selftests/dmabuf-heaps/ that
> reproduces the fd-leak scenario (mprotect flip before the ioctl) and
> verifies the fd count is unchanged after a failed ioctl (suggested by
> Sumit Semwal).

Thank you for the series - please feel free to add my

Acked-by: Sumit Semwal <sumit.semwal@linaro.org>

>
> v1: https://lore.kernel.org/dri-devel/20260703080922.1838362-1-shoubainen=
g@gmail.com/
> v2: https://lore.kernel.org/dri-devel/20260710105430.3059661-1-shoubainen=
g@gmail.com/
> v3: https://lore.kernel.org/dri-devel/20260714114654.3885457-1-shoubainen=
g@gmail.com/
>
> Changes in v6:
>  - Rework the selftest (patch 4) per review: extract a count_open_fds()
>    helper, fix the copy_from_user() comment, fail (not skip) when the
>    ioctl does not return -1, drop the bogus mprotect-race mention, and
>    reword the result message.
>
> Changes in v5:
>  - Add selftest (patch 4) reproducing the fd-leak scenario (Sumit Semwal)
>
> Changes in v4:
>  - Add patch 3: drm/prime: use dma_buf_fd_install() (Christian K=C3=B6nig=
)
>  - Add Acked-by: Christian K=C3=B6nig to patches 1 and 2
>
> Changes in v3:
>  - Split into two patches (dma-heap + fastrpc separately)
>  - Add dma_buf_fd_install() to preserve trace_dma_buf_fd tracepoint
>  - Add fastrpc fix using the new helper (T.J. Mercier)
>
> Baineng Shou (4):
>   dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds
>   misc: fastrpc: don't publish fd before copy_to_user() succeeds
>   drm/prime: use dma_buf_fd_install() to preserve export tracing
>   selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test
>
>  drivers/dma-buf/dma-buf.c                     |  20 ++++
>  drivers/dma-buf/dma-heap.c                    |  80 ++++++-------
>  drivers/gpu/drm/drm_prime.c                   |   2 +-
>  drivers/misc/fastrpc.c                        |  16 +--
>  include/linux/dma-buf.h                       |   1 +
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 113 +++++++++++++++++-
>  6 files changed, 180 insertions(+), 52 deletions(-)
>
> --
> 2.34.1
>

Best,
Sumit.
