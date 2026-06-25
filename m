Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67668CDB479
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 13:11:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB65A10E205;
	Thu, 25 Jun 2026 13:11:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BtyRRSC4";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1476F10E205
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:11:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D812443735
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 13:11:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510521F00A3A;
 Thu, 25 Jun 2026 13:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782393109;
 bh=b23lZTgP2wjXuE8iA9SXaPswGWC+1K4WivUkl2hD7/Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BtyRRSC4iI0hK90mjx6JKWrbG0PkDxYJJ1zgJbEHN8aNp9O/7v0oY8YKhB/hKqeVo
 ur7NshfE3NkqxN3KLuWoy5wNfWDQXr6sGmNleaJYT8xFDCa8zyMdxjG2YkS7EveUT0
 otOlkLEhHsuesHrk5wg0E41FNdVcQ9DaobwPpsCmO7BUSHDMGytTncgYRh/4oeDZBE
 rsXysslb2kzv800CItTpAcxMfRlZHjq6GVxewF4KTel9/MNQE9ahv0I8j85eDTmNWg
 MRD1dSqmfz7GD4fkhdlgeujLeZEPwWw4YNU+Y3JAFJN2vMI7GXHT/dpTdfEYcqvOn/
 N4zL358DusYDg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] udmabuf: serialize the sg_table cache under the
 reservation lock
To: "Bryam Vargas via B4 Relay" <devnull+hexlabsecurity.proton.me@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625-b4-disp-a9216ef0-v2-1-4819401e7086@proton.me>
References: <20260625-b4-disp-a9216ef0-v2-1-4819401e7086@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 13:11:48 +0000
Message-Id: <20260625131149.510521F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The use of dma_resv_lock_interruptible in end_cpu_udmabuf allows s=
ignal interruptions to permanently bypass device cache synchronization.

Pre-existing issues:
- [High] The first CPU access fails to synchronize CPU caches due to omitti=
ng the manual sync after mapping with DMA_ATTR_SKIP_CPU_SYNC.
- [High] dma_sync_sgtable_for_cpu and dma_sync_sgtable_for_device are calle=
d with a potentially mismatched DMA direction compared to the original mapp=
ing.
--

commit c61af695e850a91fed44895b4a5acba2b9e7c206
Author: Bryam Vargas <hexlabsecurity@proton.me>

udmabuf: serialize the sg_table cache under the reservation lock
   =20
begin_cpu_udmabuf() builds and caches ubuf->sg with an unserialised
check-then-set, and end_cpu_udmabuf() reads the same field unlocked. The
core invokes both cpu-access hooks without holding the reservation lock and
DMA_BUF_IOCTL_SYNC is unlocked, so concurrent SYNC ioctls on a shared
udmabuf fd race on ubuf->sg. Serialize both hooks under the buffer's
reservation lock.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d658..d6a137f0de1f5 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -226,6 +226,10 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>  	struct device *dev =3D ubuf->device->this_device;
>  	int ret =3D 0;
> =20
> +	ret =3D dma_resv_lock_interruptible(buf->resv, NULL);
> +	if (ret)
> +		return ret;
> +
>  	if (!ubuf->sg) {
>  		ubuf->sg =3D get_sg_table(dev, buf, direction);
>  		if (IS_ERR(ubuf->sg)) {
>  			ret =3D PTR_ERR(ubuf->sg);
>  			ubuf->sg =3D NULL;
>  		} else {
>  			ubuf->sg_dir =3D direction;
>  		}
>  	} else {

[Severity: High]
This is a pre-existing issue, but does this skip synchronizing CPU caches on
the first access?

Because the manual sync is isolated within the else branch, it looks like t=
he
initial mapping via get_sg_table() (which uses DMA_ATTR_SKIP_CPU_SYNC) leav=
es
the CPU to read stale cached data instead of device-written data.

>  		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);

[Severity: High]
This is a pre-existing issue, but does this violate the DMA API requirement
that sync directions must match the mapped direction?

The cached sg_table was mapped with the initial direction and stored in
ubuf->sg_dir, but subsequent calls to dma_sync_sgtable_for_cpu() blindly pa=
ss
the new user-provided direction.

>  	}
> =20
> +	dma_resv_unlock(buf->resv);
> +
>  	return ret;
>  }
> =20
> @@ -246,12 +252,20 @@ static int end_cpu_udmabuf(struct dma_buf *buf,
>  {
>  	struct udmabuf *ubuf =3D buf->priv;
>  	struct device *dev =3D ubuf->device->this_device;
> +	int ret =3D 0;
> +
> +	ret =3D dma_resv_lock_interruptible(buf->resv, NULL);
> +	if (ret)
> +		return ret;

[Severity: High]
Does this allow signal interruptions to permanently bypass device cache
synchronization?

If a signal (e.g., SIGINT) is delivered while waiting to acquire the
reservation lock, end_cpu_udmabuf() returns early.

Teardown and completion hooks generally shouldn't be bypassable by signals,
and kernel callers do not retry on -EINTR. Should this use uninterruptible
locking instead?

> =20
>  	if (!ubuf->sg)
> -		return -EINVAL;
> +		ret =3D -EINVAL;
> +	else
> +		dma_sync_sgtable_for_device(dev, ubuf->sg, direction);

[Severity: High]
This is a pre-existing issue, but can this trigger DMA API debug warnings or
IOMMU faults?

Similar to begin_cpu_udmabuf(), this calls dma_sync_sgtable_for_device() wi=
th
the user-provided direction instead of the originally mapped direction
(ubuf->sg_dir).

> =20
> -	dma_sync_sgtable_for_device(dev, ubuf->sg, direction);
> -	return 0;
> +	dma_resv_unlock(buf->resv);
> +
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625-b4-disp-a9=
216ef0-v2-1-4819401e7086@proton.me?part=3D1
