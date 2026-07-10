Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F1BBC43458
	for <dri-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:06:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62C6510F84E;
	Fri, 10 Jul 2026 11:06:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CDFxasrY";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D27910F84E
 for <dri-devel@lists.freedesktop.org>; Fri, 10 Jul 2026 11:06:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 73AE7601D9;
 Fri, 10 Jul 2026 11:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079DC1F000E9;
 Fri, 10 Jul 2026 11:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783681605;
 bh=LLnpx3F0q+bb/I/r3TrHv/agpib+v8Sdqof6EzGVHlg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CDFxasrY95VKMpjFPApQ/JcYwECFCa1+mWGrHUEqkmvGCBiJX9S6oslYyZjuBMwBI
 tqGzsDT7SiSvOhXiRzzS7l+f3hyf7DJr5uWXQOZsDxEWySCK0Ipzc5BgTFsLi60bh6
 4vAfOfMy0C3ckrlK92w4tMMe9drEMYhSgXq/wpgiHt4oDFnxcAorYQsgiX8beCUtr5
 RTMWhq57ZF1H0QaJVy5Zbh6ZEJxixwWUsFVMPIqWBk0RwO6fOsqMU8dGuuIkswLUAU
 aezfrX/m4Co38UzYIckXGj7AylI1uZnIn5uIs/e5eg2WdoP+iM8WLrCfMweV0sIp3h
 6zK0TgNQgjQ7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] dma-buf: dma-heap: don't publish fd before
 copy_to_user() succeeds
To: "Baineng Shou" <shoubaineng@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260710105740.3080070-1-shoubaineng@gmail.com>
References: <20260703080922.1838362-1-shoubaineng@gmail.com>
 <20260710105740.3080070-1-shoubaineng@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:06:44 +0000
Message-Id: <20260710110645.079DC1F000E9@smtp.kernel.org>
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
- [Medium] Bypassing the standard dma_buf_fd() API skips the emission of th=
e trace_dma_buf_fd tracepoint.
--

--- Patch [1]: [PATCH v2] dma-buf: dma-heap: don't publish fd before copy_t=
o_user() succeeds ---
commit 869904722955c74d0c6e8c974d3c64c6befabac6
Author: Baineng Shou <shoubaineng@gmail.com>

dma-buf: dma-heap: don't publish fd before copy_to_user() succeeds

This commit restructures DMA_HEAP_IOCTL_ALLOC to delay publishing the
file descriptor until after copy_to_user() succeeds. It open-codes the
fd allocation and installation steps instead of using dma_buf_fd() to
prevent an fd leak on copy_to_user() failure.

Link: https://lore.kernel.org/dri-devel/175e98de-f414-47d7-81c1-c0fe0a8f7f6=
2@amd.com/

> diff --git a/drivers/dma-buf/dma-heap.c b/drivers/dma-buf/dma-heap.c
> index 3937dd41bb0f6..983dee947c851 100644
> --- a/drivers/dma-buf/dma-heap.c
> +++ b/drivers/dma-buf/dma-heap.c
[ ... ]
> @@ -175,15 +162,28 @@ static long dma_heap_ioctl(struct file *file, unsig=
ned int ucmd,
> =20
>  	switch (kcmd) {
>  	case DMA_HEAP_IOCTL_ALLOC:
> -		ret =3D dma_heap_ioctl_allocate(file, kdata);
> +		dmabuf =3D dma_heap_ioctl_allocate(file, kdata);
> +
> +		if (IS_ERR(dmabuf)) {
> +			ret =3D PTR_ERR(dmabuf);
> +			break;
> +		}
> +
> +		fd =3D ((struct dma_heap_allocation_data *)kdata)->fd;
> +		if (copy_to_user((void __user *)arg, kdata, out_size) !=3D 0) {
> +			put_unused_fd(fd);
> +			dma_buf_put(dmabuf);
> +			ret =3D -EFAULT;
> +		} else {
> +			fd_install(fd, dmabuf->file);

[Severity: Medium]
By open-coding the fd reservation and installation here instead of using
dma_buf_fd(), does this skip the emission of the trace_dma_buf_fd tracepoin=
t?

If so, observability tools, BPF scripts, and perf tracing relying on
trace_dma_buf_fd to map dmabufs to file descriptors will silently miss all
allocations originating from the dma-heap subsystem.

> +		}
> +
>  		break;
>  	default:
>  		ret =3D -ENOTTY;
>  		goto err;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710105740.3080=
070-1-shoubaineng@gmail.com?part=3D1
