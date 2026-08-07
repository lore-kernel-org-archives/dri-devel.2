Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7569C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:23:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 058E810F447;
	Fri,  7 Aug 2026 10:23:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XcsYpQCt";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 268C710F447
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:23:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C423402C7;
 Fri,  7 Aug 2026 10:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E05211F000E9;
 Fri,  7 Aug 2026 10:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786098180;
 bh=wqcEcn87v9ICjpcIzgFgXiR5t2T1eQCUSPWVFL4tN5Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XcsYpQCt5uNb9tmgeJUJAckfKi8LOtD8USraTV6y4oawzH9YiFjeA8nKyLHJXBeAH
 PPMri8bhFmY1CnApxXpYmGitnljxvqo875B9UF8rL95G4GOFZqMMm8Hw3YHzN7uqp1
 4y0IsUdhgI9HEw+Sakc1I4yKPy6uGbSYf76Pb3INy8WLH9v0aQqROvMci8Fp4WlxsL
 heEMtDEm31sM3RfEBUoCEaDh/4DyNyHngI9iTukgwmSldc78Lq7V2+gs4aDSJvX0dc
 34yQoXy5o+tALj+or+e1cGcOl5qXX9tfs0/6SYUwQfWgVGhv2wujiojPS3RBNFKgSa
 4wAg6qyXpqwDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/4] drm/prime: use dma_buf_fd_install() to preserve
 export tracing
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260807101140.1357218-4-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
 <20260807101140.1357218-4-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:22:59 +0000
Message-Id: <20260807102259.E05211F000E9@smtp.kernel.org>
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
- [Medium] Meaningful mismatch between the commit message's claim and the a=
ctual code behavior regarding the file descriptor lifecycle.
--

--- Patch [3]: [PATCH v6 3/4] drm/prime: use dma_buf_fd_install() to preser=
ve export tracing ---
commit 33826692d4a41b387d790330b8cd37a2f20fa524
Author: Baineng Shou <shoubaineng@gmail.com>

drm/prime: use dma_buf_fd_install() to preserve export tracing

This commit replaces the open-coded fd reservation and installation in
drm_gem_prime_handle_to_fd() with dma_buf_fd_install(). The change ensures
that the DMA_BUF_TRACE() call is correctly emitted, restoring tracepoint
coverage for DRM PRIME exports.

Link: https://lore.kernel.org/dri-devel/20260714114654.3885457-2-shoubainen=
g@gmail.com/

>     Replace the bare fd_install() with dma_buf_fd_install(), which wraps
>     fd_install() together with DMA_BUF_TRACE(), restoring full tracepoint
>     coverage.  No functional change; the fd lifecycle (get_unused_fd_flags
>     =E2=86=92 work =E2=86=92 install) is already correct.

[Severity: Medium]
Is the statement about the fd lifecycle being already correct accurate?

This isn't a bug introduced by this patch, but rather a pre-existing issue.
Looking at drm_gem_prime_handle_to_fd(), the fd is irrevocably published
via dma_buf_fd_install() before returning:

drivers/gpu/drm/drm_prime.c:drm_gem_prime_handle_to_fd() {
    ...
    dma_buf_fd_install(dmabuf, fd);
    *prime_fd =3D fd;
    return 0;
}

After returning, the generic ioctl dispatcher performs a fallible copy_to_u=
ser():

drivers/gpu/drm/drm_ioctl.c:drm_ioctl() {
    ...
    if (copy_to_user((void __user *)arg, kdata, out_size) !=3D 0)
        retcode =3D -EFAULT;
    ...
}

If this copy_to_user() fails, does the fd remain permanently published, cau=
sing
a leak of the fd and dmabuf reference?

If so, the code might actually need the same delayed publication fix that w=
as
applied to dma-heap, making the commit message's claim incorrect.

> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 9b44c78cd77fc..fe3436d1235db 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
> @@ -524,7 +524,7 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>  		return PTR_ERR(dmabuf);
>  	}
> =20
> -	fd_install(fd, dmabuf->file);
> +	dma_buf_fd_install(dmabuf, fd);
>  	*prime_fd =3D fd;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807101140.1357=
218-1-shoubaineng@gmail.com?part=3D3
