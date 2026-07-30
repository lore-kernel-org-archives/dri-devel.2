Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89969C54FD2
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:40:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E52D310EDC2;
	Thu, 30 Jul 2026 06:40:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SHMpg6L4";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D20510EDC2
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:40:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16F33600B1;
 Thu, 30 Jul 2026 06:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 479471F000E9;
 Thu, 30 Jul 2026 06:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785393650;
 bh=NiIb7RqRgtKwQXxE/o903wj3h+HKjxUFji0hdxVtzM0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SHMpg6L4iQD/qLdANp6QMBKxcPeXe+4jwrd2V25X5t8nYyZgSwBlh2zGJ6EYCgHS1
 Tc7K+vRN77Owjn/wNe3n9OxwfJaueQ0wCCWGpTN5l/EUSl9m8GKXrA072WasRe9rr8
 KjuujY3zxJVaP2IZX0BbIwyMxo2jXdY+PPupk2WOlu2OakWrlPhaq56EdyxxayEPaD
 ZECQ6UQeKOam55MsuGfFtHsYv248pIP4KbX2GOmH+9rOX7eDRJaULz6wsRRZvZ31OU
 kJSafhwQ53ncb/N8i+Uxyq6EyEVzY+OdZ7Fh2drAlO8KQ1l6/sb1jkeQaVfR2zbA/P
 wzxmMNdvm7f0Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/4] drm/prime: use dma_buf_fd_install() to preserve
 export tracing
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260730062645.233148-4-shoubaineng@gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com>
 <20260730062645.233148-4-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:40:49 +0000
Message-Id: <20260730064050.479471F000E9@smtp.kernel.org>
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
- [High] The file descriptor is published to userspace before the `copy_to_=
user()` operation succeeds, leading to a leaked fd and `dma_buf` reference =
if the copy fails.
--

--- Patch [3]: [PATCH v5 3/4] drm/prime: use dma_buf_fd_install() to preser=
ve export tracing ---
commit 50a50a53aa7179af6880f9711b00fcaf6105ea33
Author: Baineng Shou <shoubaineng@gmail.com>

drm/prime: use dma_buf_fd_install() to preserve export tracing

This commit replaces the open-coded fd reservation and installation in
drm_gem_prime_handle_to_fd with dma_buf_fd_install. This restores the
trace_dma_buf_fd tracepoint coverage that was bypassed by using fd_install
directly.

Link: https://lore.kernel.org/dri-devel/20260714114654.3885457-2-shoubainen=
g@gmail.com/

> Replace the bare fd_install() with dma_buf_fd_install(), which wraps
> fd_install() together with DMA_BUF_TRACE(), restoring full tracepoint
> coverage.  No functional change; the fd lifecycle (get_unused_fd_flags
> =E2=86=92 work =E2=86=92 install) is already correct.

[Severity: High]
This is a pre-existing issue, but is the statement about the fd lifecycle
being already correct accurate?

In drm_gem_prime_handle_to_fd(), the file descriptor is published to the
process's fd table before the ioctl data is copied back to user space:

drivers/gpu/drm/drm_prime.c:drm_gem_prime_handle_to_fd() {
	...
	dma_buf_fd_install(dmabuf, fd);
	*prime_fd =3D fd;
	return 0;
}

The actual copy_to_user() happens later in the DRM ioctl wrapper:

drivers/gpu/drm/drm_ioctl.c:drm_ioctl() {
	...
	retcode =3D drm_ioctl_kernel(filp, func, kdata, ioctl->flags);
	if (copy_to_user((void __user *)arg, kdata, out_size) !=3D 0)
		retcode =3D -EFAULT;
	...
}

If a user application allocates a page, maps it as read-only, constructs
a valid drm_prime_handle payload within it, and invokes
DRM_IOCTL_PRIME_HANDLE_TO_FD, the core drm_ioctl() successfully reads the
input. The handler executes, allocates the dmabuf, and publishes the file
descriptor.

When drm_ioctl() attempts to write the result back via copy_to_user(), it
fails due to the read-only mapping, causing the ioctl to return -EFAULT.
Since the fd is already published and the userspace application does not
know the fd number to close it, does this result in a leak of the file
descriptor and dmabuf references?

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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730062645.2331=
48-1-shoubaineng@gmail.com?part=3D3
