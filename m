Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79639C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:14:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB0210E63A;
	Mon, 17 Aug 2026 05:14:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kcroa1S2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50E2710E63A
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:14:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5ADBE6013A;
 Mon, 17 Aug 2026 05:14:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF6BE1F000E9;
 Mon, 17 Aug 2026 05:14:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786943680;
 bh=ErHt/Qdo9sj6EPcR1iNrYjspwKvhRcI/ituwVmbEiFA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kcroa1S2618Q4VV8FoNRlXGTbWa7h+afL1LqX2+E+LjbrbXmAfVvkLrAFTryZLnFJ
 IQns0m9dRDLuLbNGfok8D9+F2gNKP/VAlgZqBM0Bex4P7TAwv6QitbK4A8fjUIoRBC
 5IfSexwqEvIgFgA2ZrjecJhSr3a7dBkPfWz24Pw7kdzk37PPJhzYFEjLEzZpa7mUWX
 an5NS43aEAfPg7lT1zfN0ZQLpRd45IZlIFldc43crhEL550P/k7sozomBMfcpgyD0v
 cLo1QmKbjHz9sKmJg2+3r+urfg7nE3q/yZWUoTZJsUr1YGblgzaxxVqFJLV38qyiDi
 myM6D413ZSJJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 3/4] drm/prime: use dma_buf_fd_install() to preserve
 export tracing
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817050457.1005285-4-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260817050457.1005285-1-shoubaineng@gmail.com>
 <20260817050457.1005285-4-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 05:14:39 +0000
Message-Id: <20260817051439.CF6BE1F000E9@smtp.kernel.org>
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
- [High] The file descriptor is published to userspace before copy_to_user(=
) succeeds, violating the dma_buf_fd_install() API contract and causing a r=
esource leak on error.
--

--- Patch [3]: [PATCH v7 3/4] drm/prime: use dma_buf_fd_install() to preser=
ve export tracing ---
commit edfa3fdf8153dcc15c693c10359892f042189a1c
Author: Baineng Shou <shoubaineng@gmail.com>

drm/prime: use dma_buf_fd_install() to preserve export tracing
   =20
This commit replaces fd_install() with dma_buf_fd_install() in
drm_gem_prime_handle_to_fd() to restore tracepoint coverage for DRM PRIME
exports. It asserts that the file descriptor lifecycle is already correct.

Link: https://lore.kernel.org/dri-devel/20260714114654.3885457-2-shoubainen=
g@gmail.com/

> No functional change; the fd lifecycle (get_unused_fd_flags
> -> work -> install) is already correct.

[Severity: High]
This isn't a bug introduced by this patch, but is this claim about the fd
lifecycle being correct accurate?

The new dma_buf_fd_install() API requires that it must only be called after
all fallible work (such as copy_to_user) has succeeded.

> diff --git a/drivers/gpu/drm/drm_prime.c b/drivers/gpu/drm/drm_prime.c
> index 9b44c78cd77fc..fe3436d1235db 100644
> --- a/drivers/gpu/drm/drm_prime.c
> +++ b/drivers/gpu/drm/drm_prime.c
[ ... ]
> @@ -524,7 +524,7 @@ int drm_gem_prime_handle_to_fd(struct drm_device *dev,
>  		return PTR_ERR(dmabuf);
>  	}
> =20
> -	fd_install(fd, dmabuf->file);
> +	dma_buf_fd_install(dmabuf, fd);

[Severity: High]
This is a pre-existing issue, but by adopting the new dma_buf_fd_install()
API, doesn't this code path violate its documented contract?

Can this lead to a file descriptor leak if a userspace application calls the
DRM_IOCTL_PRIME_HANDLE_TO_FD ioctl with an invalid userspace pointer?

If drm_gem_prime_handle_to_fd() publishes the file descriptor to the
userspace fdtable here:

dma_buf_fd_install(dmabuf, fd);
*prime_fd =3D fd;
return 0;

Then the DRM core ioctl dispatcher attempts to copy the result to userspace
after the handler returns, which can fail:

drivers/gpu/drm/drm_ioctl.c:drm_ioctl() {
    ...
    retcode =3D func(dev, kdata, file_priv);
    ...
    if (copy_to_user((void __user *)arg, kdata, out_size) !=3D 0)
        retcode =3D -EFAULT;
    ...
}

Wouldn't the failed copy_to_user() return -EFAULT and leave the already
installed fd orphaned in the process's fdtable, without the application
ever receiving the fd number to close it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817050457.1005=
285-1-shoubaineng@gmail.com?part=3D3
