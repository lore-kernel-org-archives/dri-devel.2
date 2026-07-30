Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC0AC531D0
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 06:38:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0F5510EDC1;
	Thu, 30 Jul 2026 06:38:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LeZxcG1R";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 15B4210EDC1
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 06:38:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 955A840214;
 Thu, 30 Jul 2026 06:38:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533641F000E9;
 Thu, 30 Jul 2026 06:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785393498;
 bh=vDFiwAdrjyYSfn1m5sLuFWpx/1DlXlOhpOyJ1fBQeMo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LeZxcG1RTxhZm+Om62j0dgSqzorgCsajTNk7bRPg9Aa8qT9u9wH1418IPa8Hg1koP
 Wx5kXUN7qvSaKX1p32OVfEzsZ3RNYqZ3SnmL1mb0myD0zvGA6EBbr1oGe+bQKf8KXf
 eshM41KFsDIvuo9pM2Es4MxbjMPAxfGsKzM/Dv2Wvw5TgFtwBJkklHt6xutLA+iX3w
 rld5p3/wkzXbe1RQT5nvrIkjBQQ6UwaFmT7QEa0Gjf+3Kvu9YFMA45jev7eYFFWwe/
 PVdyvOP15QVDH4rpSEPEEc3P0ZDTLKcVWS3O70JkPTD5vYMtfoNMp2/wqx2N+2YYXv
 awoR8NjxvPZYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260730062645.233148-5-shoubaineng@gmail.com>
References: <CAO_48GGxJj6AU6vsu-Y18WKtL_9RT=zsXWp3L+ifZdLM7CgGtw@mail.gmail.com>
 <20260730062645.233148-1-shoubaineng@gmail.com>
 <20260730062645.233148-5-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 06:38:17 +0000
Message-Id: <20260730063818.533641F000E9@smtp.kernel.org>
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
- [Medium] Missing `errno` preservation leads to potential clobbering befor=
e evaluation.
- [Medium] Unconditional unmapping of `req` causes a file descriptor leak i=
f `ioctl` unexpectedly succeeds.
--

--- Patch [4]: [PATCH v5 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAUL=
T regression test ---
commit 43e605bb1fee2426e027813c0311f1910f7ea15e
Author: Baineng Shou <shoubaineng@gmail.com>

selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test

Add a test case that verifies no file descriptor is leaked when
DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails
to deliver the fd number back to userspace.

> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index fc9694fc4e89e..bd58e5b06c8b6 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c

[ ... ]

> +static void test_alloc_no_fd_leak_on_efault(char *heap_name)
> +{

[ ... ]

> +	/*
> +	 * Make the page read-only: copy_from_user() in the kernel will
> +	 * still succeed (it already ran), but copy_to_user() that writes
> +	 * the fd number back will fault.
> +	 */
> +	mprotect(req, page_size, PROT_READ);
> +
> +	ret =3D ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
> +
> +	/* Re-allow writes so munmap can clean up */
> +	mprotect(req, page_size, PROT_READ | PROT_WRITE);
> +	munmap(req, page_size);
> +
> +	if (ret !=3D -1 || errno !=3D EFAULT) {

[Severity: Medium]
Will this evaluate the correct errno from the ioctl call?

The errno variable is checked after executing mprotect and munmap. If eithe=
r of
these functions modify errno (for example, if they fail), the test will
evaluate the wrong errno and incorrectly skip with a misleading message ins=
tead
of reporting a failure or success properly.

[Severity: Medium]
Also, could this leak the newly allocated file descriptor in the test proce=
ss
if the ioctl call unexpectedly succeeds?

If the ioctl call successfully allocates a file descriptor (for instance, if
the initial mprotect fails to make the page read-only or due to a kernel bu=
g),
the new file descriptor is written to req->fd.

Since the test unconditionally calls munmap(req) immediately after, it dest=
roys
the only reference to the allocated file descriptor. The test then detects
unexpected success, skips, and leaks the file descriptor in the test proces=
s.

> +		/*
> +		 * If the ioctl didn't fail with EFAULT, either the kernel
> +		 * handled it differently or mprotect raced.  Skip rather
> +		 * than giving a false pass/fail.
> +		 */
> +		ksft_test_result_skip(
> +			"ioctl did not return EFAULT (ret=3D%d errno=3D%d), skipping\n",
> +			ret, errno);
> +		goto out;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730062645.2331=
48-1-shoubaineng@gmail.com?part=3D4
