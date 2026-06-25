Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5BA4CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 06:21:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26B3110E17B;
	Thu, 25 Jun 2026 06:21:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FY0MN5IE";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2665E10E17B
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:21:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DD91C40DF2
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 06:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A3DA1F00A3A;
 Thu, 25 Jun 2026 06:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782368500;
 bh=1nkRKIic8g2hZC7+WqJCxijKsd6h1ZCaebvMpr8jxRk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FY0MN5IEIaD2uUpfGmBBhgAZ75nP8fFGnPPpqBWlD3YNOt1qMWW/4RVSqWaeyPCH9
 VQ5qG75VsYKqauV3TXE7dk1oqNuH/k+OnJnnaY8T0nld5ENLvPfkILZgOUJesIayen
 x28dxGq+pC3ZFbzjLHIBV1LpkBK+yawGazJpczHbIFyUt9OMhY2xUoKHgt/cGo+qUK
 uEqYKx4fp2eygDR1Ul8vXYD8xnEc+b8lZ4muB0y7w8jae6ZyAl8Edvk0z54vu0HFb/
 zZsVc/dKCYWJM9pmB/N7A7JRkgSNC1fvQGLCrfBDL+yeqFsCbzirYEilnt+XC8trIk
 /RQRZwGdPG0Sw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] udmabuf: serialize the sg_table cache under the
 reservation lock
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-b4-disp-67d1f3db-v1-1-a47fb9edab9e@proton.me>
References: <20260625-b4-disp-67d1f3db-v1-1-a47fb9edab9e@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 06:21:40 +0000
Message-Id: <20260625062140.9A3DA1F00A3A@smtp.kernel.org>
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

Pre-existing issues:
- [High] The first invocation of `begin_cpu_udmabuf` skips CPU cache synchr=
onization entirely, potentially leading to data corruption.
- [High] Reusing the cached SG table for subsequent CPU accesses with diffe=
rent directions causes a DMA API violation.
--

commit 924482c7f4134e0b3fa3b6a2fe23f17b9acba538
Author: Bryam Vargas <hexlabsecurity@proton.me>
udmabuf: serialize the sg_table cache under the reservation lock

This commit adds reservation lock serialization to begin_cpu_udmabuf() and
end_cpu_udmabuf() to protect the sg_table cache. It resolves a race conditi=
on
where concurrent SYNC ioctls could observe a NULL sg_table, leading to
permanent leaks of the sg_table and unbalanced DMA mappings. Single-threaded
callers are unaffected by this change.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d658..702ae13b97d15 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -226,6 +226,8 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>  	struct device *dev =3D ubuf->device->this_device;
>  	int ret =3D 0;
> =20
> +	dma_resv_lock(buf->resv, NULL);
> +
>  	if (!ubuf->sg) {
>  		ubuf->sg =3D get_sg_table(dev, buf, direction);
>  		if (IS_ERR(ubuf->sg)) {
>  			ret =3D PTR_ERR(ubuf->sg);
>  			ubuf->sg =3D NULL;
>  		} else {
>  			ubuf->sg_dir =3D direction;
>  		}

[Severity: High]
This isn't a bug introduced by this patch, but does the first invocation of
begin_cpu_udmabuf() skip CPU cache synchronization entirely?

Since get_sg_table() intentionally maps the SG table with the
DMA_ATTR_SKIP_CPU_SYNC attribute, and the dma_sync_sgtable_for_cpu() call
is isolated inside the else block, the freshly mapped table doesn't get
synchronized.

If an unprivileged user calls the DMA_BUF_IOCTL_SYNC ioctl with SYNC_START
on a udmabuf, it seems this could lead to data corruption where the CPU
reads stale cache lines instead of device-written data.

>  	} else {
>  		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);

[Severity: High]
This is a pre-existing issue, but might this result in syncing DMA memory
with a mismatched direction?

begin_cpu_udmabuf() lazily allocates ubuf->sg using the direction of its
very first invocation and saves it in ubuf->sg_dir. If a subsequent
DMA_BUF_IOCTL_SYNC call uses a different direction (for example, the first
sync is DMA_FROM_DEVICE, and the next is DMA_TO_DEVICE), the cached
sg_table is reused.

Here, dma_sync_sgtable_for_cpu() is called with the caller's new direction
rather than the original mapping direction stored in ubuf->sg_dir.

This can lead to incorrect cache flushes on non-coherent architectures and
trigger CONFIG_DMA_API_DEBUG warnings.

>  	}
> =20
> +	dma_resv_unlock(buf->resv);
> +
>  	return ret;
>  }

[ ... ]

> @@ -246,12 +250,18 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
>  {
>  	struct udmabuf *ubuf =3D buf->priv;
>  	struct device *dev =3D ubuf->device->this_device;
> +	int ret =3D 0;
> +
> +	dma_resv_lock(buf->resv, NULL);
> =20
>  	if (!ubuf->sg)
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +	else
> +		dma_sync_sgtable_for_device(dev, ubuf->sg, direction);

[Severity: High]
This is a pre-existing issue, but similar to the concern above, does this
sync the cached sg_table for the device using the caller's new direction
instead of the original mapping direction stored in ubuf->sg_dir?

> =20
> -	dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
> -	return 0;
> +	dma_resv_unlock(buf->resv);
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-b4-disp-67=
d1f3db-v1-1-a47fb9edab9e@proton.me?part=3D1
