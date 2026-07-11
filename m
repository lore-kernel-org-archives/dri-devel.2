Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F900C43458
	for <dri-devel@archiver.kernel.org>; Sat, 11 Jul 2026 04:29:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B73AB10E2AE;
	Sat, 11 Jul 2026 04:29:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gmUIjfcG";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 538C510E2AE
 for <dri-devel@lists.freedesktop.org>; Sat, 11 Jul 2026 04:29:38 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 740EA60051;
 Sat, 11 Jul 2026 04:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5531F000E9;
 Sat, 11 Jul 2026 04:29:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783744177;
 bh=sf4bmQq7Rv2LuhoiXK1SjGAo6fd7Y6KXCuv/h8eKNMs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gmUIjfcGOnEb1DjJNeQGe3Gq1/WHYhwepkJyV/JwnSjD4DLUIi8DVU0h99DELqVFP
 icOT3VHBIIvaiKkPgo1FzErDdD99U4LH147wEH9JVn75cnEOEdjVQ1m8JSA8Mwz7wL
 pMmABkhD88XdHJSBzGTPccdqczevv/n6UHrwWoaIXZRdJbJ3ER0x23MMTtnRU1oiTD
 CEXvDmS9/4BfSzjAHXM1o1KvLffMc1k1GGGq1f7lkRUotayH+bwrtdRVJHNJBoaFq9
 ZBpFrLV7U2GfEYbMpxWz51gVHBiyhdPGX8eRuAheyy3r2XoVz01gqyuYYiht/giMch
 S8KNNU6kzAX5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260711041455.3375292-1-shoubaineng@gmail.com>
References: <20260703080922.1838362-1-shoubaineng@gmail.com>
 <20260711041455.3375292-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 11 Jul 2026 04:29:36 +0000
Message-Id: <20260711042936.EF5531F000E9@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Pre-existing Use-After-Free in dma_buf_fd() via concurrent clo=
se() after fd installation.
--

--- Patch [1]: [PATCH v2] dma-buf: dma-heap: don't publish fd before copy_t=
o_user() succeeds ---
commit a57039a5644f218873e246c9fb9fe2f87ef4dc55
Author: Baineng Shou <shoubaineng@gmail.com>

dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds

DMA_HEAP_IOCTL_ALLOC allocates a dma-buf and installs an fd into the
caller's fd table via dma_buf_fd() -> fd_install() before
dma_heap_ioctl() copies the result back to userspace.

Link: https://lore.kernel.org/dri-devel/175e98de-f414-47d7-81c1-c0fe0a8f7f6=
2@amd.com/

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 71f37544a5c61..c2f455d028b30 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -799,6 +799,26 @@ int dma_buf_fd(struct dma_buf *dmabuf, int flags)
>  }
>  EXPORT_SYMBOL_NS_GPL(dma_buf_fd, "DMA_BUF");

[Severity: Critical]
This is a pre-existing issue, but does dma_buf_fd() have a use-after-free
if the file descriptor is closed concurrently?

Looking at dma_buf_fd() just above this diff:

    fd =3D FD_ADD(flags, dmabuf->file);
    DMA_BUF_TRACE(trace_dma_buf_fd, dmabuf, fd);

Once FD_ADD() installs the fd, it becomes visible to userspace. If a
concurrent thread guesses the fd and calls close(fd), the file's
reference count drops to zero, triggering fput() and eventually freeing
the dmabuf structure.

When the original thread continues to DMA_BUF_TRACE(), won't it
dereference the now-freed dmabuf pointer?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260711041455.3375=
292-1-shoubaineng@gmail.com?part=3D1
