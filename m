Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7F64C5CFC1
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 05:14:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8C9310E3C4;
	Mon, 17 Aug 2026 05:14:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="oatvzpic";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C50910E3C4
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 05:14:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5446643BEE;
 Mon, 17 Aug 2026 05:14:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3E9B1F000E9;
 Mon, 17 Aug 2026 05:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786943674;
 bh=rM3Cfx8BELR+J9tg8oyQlRA6O4nPe1RmE6DLFRP+TtY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oatvzpicRnhL4Vi0kkyJPK+RNqMv+quaK1j/cQvTErUQh0nmm9V+2xg27Jq3z3aUx
 F83aqPaUynqIqCSX0t6W9MFoVutqTpqOY0iTYNK6yuWMOfU34JHgkrWpxfeIW/bR3x
 Frbz3fpZC7jea2aURApyTWqUCaQs4tXxa4Xcg0oV+x6CnEgs2FFTRW7ql3UAAPNN+A
 MWzZki8puJTQbG97sFT41Jsn0FJPXXUi22pUr8nIbVqZwyB/fiNt8xv3vmnCiDkedz
 MHHu3ZemURWW764WZYcq1RZxKcKawNaUKAry93RWYVNzbZ9FPCm8pUO4NAlMRjmK6H
 fq+CG6IK+8qIA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAULT
 regression test
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: media-ci@linuxtv.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260817050457.1005285-5-shoubaineng@gmail.com>
References: <CABdmKX1-0bXdU_pWKrY3LR4JmOpxC48ka9akS8PHYDBnngFqWQ@mail.gmail.com>
 <20260817050457.1005285-1-shoubaineng@gmail.com>
 <20260817050457.1005285-5-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 05:14:33 +0000
Message-Id: <20260817051433.F3E9B1F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Medium] The test does not verify that `errno =3D=3D EFAULT` when `ioctl`=
 fails, which can lead to false positives if the allocation fails for other=
 reasons.
- [Low] The return value of the first `mprotect` call is ignored.
- [Low] An unnecessary `mprotect` call is made to restore `PROT_WRITE` befo=
re `munmap`, accompanied by an inaccurate comment.
- [Low] If the `ioctl` unexpectedly succeeds, the newly allocated file desc=
riptor is leaked.
--

--- Patch [4]: [PATCH v7 4/4] selftests: dmabuf-heaps: add fd-leak-on-EFAUL=
T regression test ---
commit 1be53f13852770ff6e3074adac5bd4f146ea6110
Author: Baineng Shou <shoubaineng@gmail.com>

selftests: dmabuf-heaps: add fd-leak-on-EFAULT regression test

Add a test case that verifies no file descriptor is leaked when
DMA_HEAP_IOCTL_ALLOC succeeds internally but copy_to_user() fails
to deliver the fd number back to userspace.

> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index fc9694fc4e89e..1d49df6719198 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
[ ... ]
> @@ -390,6 +390,116 @@ static void test_alloc_errors(char *heap_name)
[ ... ]
> +static void test_alloc_no_fd_leak_on_efault(char *heap_name)
> +{
[ ... ]
> +	/*
> +	 * Make the page read-only so copy_to_user() will fault.  The
> +	 * ioctl must fail with -1; if it returns success the test setup
> +	 * is broken (mprotect is synchronous, so there is no race).
> +	 */
> +	mprotect(req, page_size, PROT_READ);

[Severity: Low]
Does this code handle the case where mprotect() fails? If it fails, the mem=
ory
would remain writable, the ioctl would succeed, and the test would fail
confusingly instead of reporting a setup failure.

> +
> +	ret =3D ioctl(heap_fd, DMA_HEAP_IOCTL_ALLOC, req);
> +
> +	/* Re-allow writes so munmap can clean up */
> +	mprotect(req, page_size, PROT_READ | PROT_WRITE);

[Severity: Low]
Is this mprotect() call necessary? munmap() manipulates the kernel's memory=
 map
directly and doesn't require the underlying memory pages to have write
permissions to be unmapped.

> +	munmap(req, page_size);
> +
> +	if (ret !=3D -1) {

[Severity: Low]
If the ioctl unexpectedly succeeds (for example if mprotect failed), does t=
his
code leak the newly allocated file descriptor? By the time success is detec=
ted,
req has been unmapped, making it impossible to read req->fd to close it.

[Severity: Medium]
Does this code verify that the failure was actually caused by the expected
EFAULT? If the ioctl fails for unrelated reasons like -ENOMEM, ret will sti=
ll
be -1, fd_before will equal fd_after, and the test will erroneously report =
PASS
even though the copy_to_user() fault path was never tested.

> +		ksft_test_result_fail("ioctl returned %d, expected -1 EFAULT\n",
> +				      ret);
> +		goto out;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817050457.1005=
285-1-shoubaineng@gmail.com?part=3D4
