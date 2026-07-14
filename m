Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DCC9C43458
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 13:45:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A490610E067;
	Tue, 14 Jul 2026 13:45:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QU1UHXT/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B393C10E067
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Jul 2026 13:45:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0FBB2601ED;
 Tue, 14 Jul 2026 13:45:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8851F000E9;
 Tue, 14 Jul 2026 13:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784036749;
 bh=Olf8cuYbrQKCftg/VPBSjdnUMUdAeP3FuWNEBQBL/Jo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QU1UHXT/tSxEVlFdVvfSmPy5lAZpHf2PEDfPjfZC4Znzy3P48gzCcenIMwggu0cj2
 zdGuBI87ahD9WBB6OVTVVbBlHB5LBb4Ymu3YnvYZHER3wJCjzzeycm7DIBwjk2Xgb4
 Pw33SPw7b09EQ0RiN0GClKnIUCjU0UP8XSY1OXKgrhMTXHUF1XfE3zUvleI76lHuMv
 tKx/tmqYg3Ac66wvUFN9wnAL0zR2d2qwLDqR4HwfRlNOc8i08D+VeG6VuAcaCYWeF3
 mw9JtwgmRDwDNSQRNJRaaHB26rrAn7NlxT6g5RANi60B77g8qJFR1JMC2E8PMDJvjK
 uCwuuAosq+H1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/prime: use dma_buf_fd_install() to preserve
 export tracing
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260714132727.200995-1-shoubaineng@gmail.com>
References: <4ccf4ae5-ccd7-4bec-836a-fcebfa271c96@amd.com>
 <20260714132727.200995-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 13:45:49 +0000
Message-Id: <20260714134549.8F8851F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Build failure due to missing dependency `dma_buf_fd_install`.

Pre-existing issues:
- [High] Permanent file descriptor and dmabuf leak if copy_to_user() fails =
in drm_ioctl.
--

--- Patch [1]: [PATCH v3] drm/prime: use dma_buf_fd_install() to preserve e=
xport tracing ---
commit 0d84b19a88b6c4fa09505ca93169d721f3560e20
Author: Baineng Shou <shoubaineng@gmail.com>

drm/prime: use dma_buf_fd_install() to preserve export tracing

This commit replaces fd_install() with dma_buf_fd_install() in
drm_gem_prime_handle_to_fd() to ensure DMA_BUF_TRACE() is called when
exporting a PRIME handle. It notes a dependency on a separate patch
for the new helper.

Link: https://lore.kernel.org/dri-devel/20260714114654.3885457-2-shoubainen=
g@gmail.com/

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
[Severity: High]
Is dma_buf_fd_install() defined in the current tree?

The commit message notes a dependency on a patch that introduces this
function, but without it present in the branch, won't this cause a build
failure due to an implicit function declaration and undefined symbol?

[Severity: High]
This is a pre-existing issue, but can this leak the fd and dmabuf if
copy_to_user() fails later in drm_ioctl()?

If userspace calls the DRM_IOCTL_PRIME_HANDLE_TO_FD ioctl with a read-only
memory mapping for the argument pointer, drm_gem_prime_handle_to_fd() insta=
lls
the fd:

drivers/gpu/drm/drm_prime.c:drm_gem_prime_handle_to_fd() {
    ...
    dma_buf_fd_install(dmabuf, fd);
    ...
}

Afterward, the generic ioctl dispatcher attempts to write the resulting fd
back to userspace:

drivers/gpu/drm/drm_ioctl.c:drm_ioctl() {
    ...
    if (copy_to_user((void __user *)arg, kdata, out_size) !=3D 0)
        retcode =3D -EFAULT;
    ...
}

If this copy fails, the ioctl returns -EFAULT and the user application never
receives the fd number to close it. Will the fd remain open in the process,
permanently leaking the dma_buf and associated GEM object until the process
exits?

>  	*prime_fd =3D fd;
>  	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714132727.2009=
95-1-shoubaineng@gmail.com?part=3D1
