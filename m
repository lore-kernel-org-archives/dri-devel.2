Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF97C5DF81
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 19:14:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C1B7010E199;
	Thu, 20 Aug 2026 19:14:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aSNpafkj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5122510E199
 for <dri-devel@lists.freedesktop.org>; Thu, 20 Aug 2026 19:14:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B157541FF6;
 Thu, 20 Aug 2026 19:14:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F74A1F000E9;
 Thu, 20 Aug 2026 19:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787253296;
 bh=GksDckRPCfSI0r90Er844KOGKMIzVoEbRo0LhkbSMiI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aSNpafkjkqp2PqBRoansSxOdgAz7qpu7sMQJNZKrSbWUWf6nshDUXA6u4QxjjW9kw
 +qVliwBrKbt+3rrDxUKsIvpzZKpk9cZlN2T/9T/CvMrE64PBwogn0n+rQe2Y4KmFFv
 ZA0jsb6gAdNmXMJQsOzUw4xWU8Yb++tphnalj/X0F6QgNelGzlH8Xukg51yMqWEkZ8
 NaQEzY8z9D2JDaghJoZzu64ObYHQVEf2WRqKkB9wuoV6a3KD7lg3rzwPpIoG9Bnrai
 Ut85/NSIcY9Sgb0CdmGuGlCA4CUXJm8IH1wZ37VTefAd2vOtncfvsKYF4SNIBvWUU2
 BbfpV3rIlM0MA==
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH] dma-buf: add a generic reclaim-priority hint
To: "Ferran Duarri" <ferran.duarri@me.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20260820190838.221435-1-ferran.duarri@me.com>
References: <20260820190838.221435-1-ferran.duarri@me.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 19:14:55 +0000
Message-Id: <20260820191456.5F74A1F000E9@smtp.kernel.org>
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
- [Medium] UAPI extensibility flaw: DMA_BUF_IOCTL_GET_PRIORITY is defined a=
s _IOR and does not validate the 'pad' field on input.
--

--- Patch [1]: [RFC PATCH] dma-buf: add a generic reclaim-priority hint ---
commit be79050598dd83ece044d5037692f147154efbe0
Author: Ferran Duarri <ferran.duarri@me.com>

dma-buf: add a generic reclaim-priority hint

This commit introduces a priority hint to dma-buf backing memory to help
subsystems decide eviction order under memory pressure. It adds the hint
field to struct dma_buf along with GET and SET ioctls to manage it from
userspace.

> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
[ ... ]
> @@ -580,6 +614,21 @@ static long dma_buf_ioctl(struct file *file,
>  	case DMA_BUF_SET_NAME_B:
>  		return dma_buf_set_name(dmabuf, (const char __user *)arg);
> =20
> +	case DMA_BUF_IOCTL_SET_PRIORITY:
> +		if (copy_from_user(&prio, (void __user *)arg, sizeof(prio)))
> +			return -EFAULT;
> +		if (prio.pad || prio.priority > DMA_BUF_PRIORITY_MAX)
> +			return -EINVAL;
> +		dma_buf_set_priority(dmabuf, prio.priority);
> +		return 0;
> +
> +	case DMA_BUF_IOCTL_GET_PRIORITY:
> +		memset(&prio, 0, sizeof(prio));
> +		prio.priority =3D dma_buf_get_priority(dmabuf);
> +		if (copy_to_user((void __user *)arg, &prio, sizeof(prio)))
> +			return -EFAULT;
> +		return 0;

[Severity: Medium]
Since the pad field in struct dma_buf_priority is documented as "must be
zero, reserved for future use", should we validate it in the GET ioctl as
well?

Because dma_buf_ioctl() does a memset() and copy_to_user() without first
calling copy_from_user() to check if the pad is zero, userspace isn't
forced to initialize it.

If we ever want to use the pad field for input flags or modifiers in the
future, we won't be able to do so without breaking existing userspace
applications that might be leaving it uninitialized.

> diff --git a/include/uapi/linux/dma-buf.h b/include/uapi/linux/dma-buf.h
> --- a/include/uapi/linux/dma-buf.h
> +++ b/include/uapi/linux/dma-buf.h
[ ... ]
> @@ -179,5 +210,7 @@ struct dma_buf_import_sync_file {
>  #define DMA_BUF_SET_NAME_B	_IOW(DMA_BUF_BASE, 1, __u64)
>  #define DMA_BUF_IOCTL_EXPORT_SYNC_FILE	_IOWR(DMA_BUF_BASE, 2, struct dma=
_buf_export_sync_file)
>  #define DMA_BUF_IOCTL_IMPORT_SYNC_FILE	_IOW(DMA_BUF_BASE, 3, struct dma_=
buf_import_sync_file)
> +#define DMA_BUF_IOCTL_SET_PRIORITY	_IOW(DMA_BUF_BASE, 4, struct dma_buf_=
priority)
> +#define DMA_BUF_IOCTL_GET_PRIORITY	_IOR(DMA_BUF_BASE, 5, struct dma_buf_=
priority)

[Severity: Medium]
If we want to validate the pad field as an input parameter to preserve futu=
re
extensibility, should this ioctl be defined as _IOWR instead of _IOR?

Using _IOR signifies an output-only operation, which dictates the ioctl
number and structurally discourages the kernel from reading inputs from the
structure.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820190838.2214=
35-1-ferran.duarri@me.com?part=3D1
