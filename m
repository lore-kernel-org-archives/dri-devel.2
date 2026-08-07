Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 299BBC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 10:20:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05BBC10F457;
	Fri,  7 Aug 2026 10:20:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="T8A6OW5B";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6855010F447
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 10:20:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 88EA960A86;
 Fri,  7 Aug 2026 10:20:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6BD1F000E9;
 Fri,  7 Aug 2026 10:20:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786098021;
 bh=xfwCh8X4syy3GFpEagSpNEuvld7An38yYhPLt5qwNE0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T8A6OW5Bu7+cWFf/9hwcneE4FG6gAb5J34sGnvgfhYWy9yRf4BQ9WhcArS3uXclYf
 W7ajVOJrUK0WYAu/r1krfb+FYa7yB5wmWxhJ9K92fLKGY+VoyTuPn3PHX9V/ecDg1e
 BKRTinemnI9MNSNYjmjvddrgKUlpfXxEvX/aVDnXftU7Ja1xTxEOSiusvd1NuJ//s0
 rvD5Ziw6O5T8bTiyTbB8RFwo0Ww3ulgkrOVkoaiM53ghGkGpjigC6wQ5RmtOn6UelN
 v55up9zl//kdFe2JPrAF6lFtvseLqimbn1yJKlNFYPNGD/GJKEPf3H+aevK0c5Lnb2
 yKsfEodbECCGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260807101140.1357218-5-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260807101140.1357218-1-shoubaineng@gmail.com>
 <20260807101140.1357218-5-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 10:20:20 +0000
Message-Id: <20260807102021.0B6BD1F000E9@smtp.kernel.org>
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
- [Medium] The regression test silently reports a false pass if the ioctl f=
ails for a reason other than the expected -EFAULT.
- [Low] A file descriptor is leaked on the test's failure path if the ioctl=
 unexpectedly succeeds.
--

--- Patch [4]: [PATCH v6 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAUL=
T regression test ---
commit 2ee174de4cce870677ff17aa1714b40304934392
Author: Baineng Shou <shoubaineng@gmail.com>

selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test

This commit adds a test case that verifies no file descriptor is leaked when
DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails to deliver
the fd number back to userspace. It triggers the failure by placing the ioc=
tl
argument in a private anonymous page and changing it to PROT_READ between
the copy_from_user() and copy_to_user() calls.

> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index fc9694fc4e89e..1d49df6719198 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
[ ... ]
> +	ret =3D ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
> +
> +	/* Re-allow writes so munmap can clean up */
> +	mprotect(req, page_size, PROT_READ | PROT_WRITE);
> +	munmap(req, page_size);
> +

[Severity: Low]
Does this code leak the newly allocated file descriptor if the ioctl
unexpectedly succeeds?

Since the test unmaps the req structure immediately after the ioctl, the
returned file descriptor stored in req->fd is lost. If the ioctl returned 0,
the fd cannot be read and closed before the test jumps to the error path.

> +	if (ret !=3D -1) {

[Severity: Medium]
Will this silently report a false pass if the ioctl fails for a reason other
than the expected EFAULT?

The test checks that the return value is -1, but doesn't verify that
errno =3D=3D EFAULT. If the ioctl fails early (for example, returning -EINV=
AL
or -ENOMEM) before reaching the copy_to_user() step, the fd count remains
unchanged and the test passes, even though the EFAULT path was never tested.

> +		ksft_test_result_fail("ioctl returned %d, expected -1 EFAULT\n",
> +				      ret);
> +		goto out;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260807101140.1357=
218-1-shoubaineng@gmail.com?part=3D4
