Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34424C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:20:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9053F10E3C3;
	Mon, 17 Aug 2026 05:20:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c19eMyp4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D8DEA10E3C3
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:20:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8D8814035D;
 Mon, 17 Aug 2026 05:20:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47E851F000E9;
 Mon, 17 Aug 2026 05:20:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786944026;
 bh=z54b1mZ+B87i7QnrfIkVbMQ6tydgrFl+u9gbTzdSuaY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c19eMyp4DegHQbgTF6RXz5pb21U1cqSZ3ovCuS3hpiy2GMHvbFfnQtjPLsHl4/7UE
 IyFfLKilS4WfCVLaOb+kNOpBkOHcvzG3XR1cw4xXmlArErm8pSlomts/MnH2c5CzEL
 UrHZKM/8tlkScjMbFxP00VfkUubZh4wOxF4Cyn27lucttLfa/E6jHXLG3Mko44x/V7
 8nBl614mV81Dmu5yS/uB3HJDFpLbFca7sAq0tppIK+pptuUFsxKRRy4U6Uj8kcO98Y
 tIK/lpYJbzTJNtqLra6Ai8qZ4/7wCkaSsH+f/4X/GF8hiR9U7ZNsrAgGsj5QaYwlJ3
 6gtJNvBob5iqg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 2/4] misc: fastrpc: don't publish fd before
 copy_to_user() succeeds
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817050457.1005285-3-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260817050457.1005285-1-shoubaineng@gmail.com>
 <20260817050457.1005285-3-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 05:20:25 +0000
Message-Id: <20260817052026.47E851F000E9@smtp.kernel.org>
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
- [Critical] Exported DMA buffers maintain a raw pointer to `fastrpc_user` =
(`buf->fl`) without holding a reference, leading to a Use-After-Free if the=
 DMA buffer outlives the fastrpc device descriptor.
--

--- Patch [2]: [PATCH v7 2/4] misc: fastrpc: don't publish fd before copy_t=
o_user() succeeds ---
commit f5005f3a9100abf2f83ab45f3bc5e948d9e97e67
Author: Baineng Shou <shoubaineng@gmail.com>

misc: fastrpc: don't publish fd before copy_to_user() succeeds

This commit fixes an issue where a DMA buffer file descriptor is installed
into the fd table before successfully copying the fd number back to
userspace. It updates the allocation path to reserve the fd first, attempt
the user copy, and only publish the fd upon success to prevent leaking
access to the fd on failure.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -1709,24 +1709,20 @@ static int fastrpc_dmabuf_alloc(struct fastrpc_us=
er *fl, char __user *argp)
>  		return err;
>  	}
> =20
> -	bp.fd =3D dma_buf_fd(buf->dmabuf, O_ACCMODE);
> +	bp.fd =3D get_unused_fd_flags(O_ACCMODE);
>  	if (bp.fd < 0) {
>  		dma_buf_put(buf->dmabuf);
> -		return -EINVAL;
> +		return bp.fd;
>  	}
> =20
>  	if (copy_to_user(argp, &bp, sizeof(bp))) {
> -		/*
> -		 * The usercopy failed, but we can't do much about it, as
> -		 * dma_buf_fd() already called fd_install() and made the
> -		 * file descriptor accessible for the current process. It
> -		 * might already be closed and dmabuf no longer valid when
> -		 * we reach this point. Therefore "leak" the fd and rely on
> -		 * the process exit path to do any required cleanup.
> -		 */
> +		put_unused_fd(bp.fd);
> +		dma_buf_put(buf->dmabuf);
>  		return -EFAULT;
>  	}
> =20
> +	dma_buf_fd_install(buf->dmabuf, bp.fd);

[Severity: Critical]
This is a pre-existing issue, but does exporting this dma-buf introduce a
use-after-free risk if the dma-buf fd outlives the fastrpc device fd?

When the fastrpc device fd is closed, the fastrpc_user struct (fl) is
released. However, the exported dma-buf maintains a raw pointer to it via
buf->fl without holding a reference.

If an unprivileged user allocates a dma-buf here, closes the fastrpc device
fd, and then calls close() or mmap() on the dma-buf fd, it triggers
dma_buf_put() or mmap(). Those paths call into fastrpc_buf_free() or
fastrpc_mmap(), which dereference the dangling buf->fl pointer:

fastrpc_buf_free()
    fastrpc_ipa_to_dma_addr(buf->fl->cctx, buf->dma_addr)

Is there a missing reference count increment on fastrpc_user when exporting
the buffer, or should the dma-buf release operations handle the device
teardown differently?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817050457.1005=
285-1-shoubaineng@gmail.com?part=3D2
