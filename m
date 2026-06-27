Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BD01C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 11:08:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F4A110E4A9;
	Sat, 27 Jun 2026 11:08:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MlxxCRj/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8E44510E4A9
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 11:08:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9877B600AB;
 Sat, 27 Jun 2026 11:08:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6871F000E9;
 Sat, 27 Jun 2026 11:08:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782558502;
 bh=vPjMtFajz1wsaBX7WlNynax4mJ2c6+Iec41FkRSfkR8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MlxxCRj/qB3YOJGOpDdcogpMY2+v2Xm8Zz+y07k88SGejkxpORcrExBI81BrzpIjc
 v62mc4mx3bFIKL/p9bmOSKQhzeOHnvKXWicw4ZZSkt9s1mYLZIjyQj5eRYqUJFSUUw
 7AklZeeFR/e4fAGe845LxBHdZV3sgPttRAy78NCi+q6uBFEIsz/vHmRNejcpGjVJb8
 sCjV73lvDxZ5+WO3b3aVbkDPRRGnJk0BSjcemf9oJAVlklYWovrCBpx707rXlCoC0E
 JiIPoLvvJRgESQTHIgwGs0oeh3mp+cGhN9LHsTSaKrGTlYnvY0hg/XH/MUDrW3s9I2
 W7e/MOTWxNhvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] udmabuf: Ensure to perform cache synchronisation in
 begin_cpu_udmabuf()
To: "Robert Mader" <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627105725.9083-1-robert.mader@collabora.com>
References: <20260627105725.9083-1-robert.mader@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 11:08:20 +0000
Message-Id: <20260627110821.7F6871F000E9@smtp.kernel.org>
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
- [Critical] Unprotected concurrent accesses to `ubuf->sg` allow memory and=
 DMA mapping leaks, and expose a TOCTOU race condition that can trigger a k=
ernel panic via an invalid pointer dereference.
- [High] Mismatch between the initial DMA mapping direction and the cache s=
ynchronization direction for subsequent CPU accesses violates the DMA API c=
ontract.
--

commit aa38d7b2c22ba17dc9edaf6a59e4f9a1d76a592b
Author: Robert Mader <robert.mader@collabora.com>

udmabuf: Ensure to perform cache synchronisation in begin_cpu_udmabuf()

The message of commit 504e2b4ab97a ("dma-buf/udmabuf: skip redundant cpu sy=
nc to
fix cacheline EEXIST warning") says:

> The CPU sync at map/unmap time is also redundant for udmabuf:
> begin_cpu_udmabuf() and end_cpu_udmabuf() already perform explicit
> cache synchronization via dma_sync_sgtable_for_cpu/device() when CPU
> access is requested through the dma-buf interface.

This, however, does not apply to the first time begin_cpu_udmabuf() is
called on an udmabuf, in which case the implementation previously relied on
get_sg_table() to perform the cache synchronisation.

Ensure to call dma_sync_sgtable_for_cpu() in that case as well.

> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index bced421c0d658..08f57bc1294df 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -224,21 +224,22 @@ static int begin_cpu_udmabuf(struct dma_buf *buf,
>  {
>  	struct udmabuf *ubuf =3D buf->priv;
>  	struct device *dev =3D ubuf->device->this_device;
> -	int ret =3D 0;
> =20
>  	if (!ubuf->sg) {
>  		ubuf->sg =3D get_sg_table(dev, buf, direction);
>  		if (IS_ERR(ubuf->sg)) {
> +			int ret;
> +
>  			ret =3D PTR_ERR(ubuf->sg);
>  			ubuf->sg =3D NULL;
> +			return ret;
>  		} else {
>  			ubuf->sg_dir =3D direction;
>  		}
> -	} else {
> -		dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);
>  	}

[Severity: Critical]
This is a pre-existing issue, but does this lack of synchronization allow
concurrent threads to see a transient error pointer?

If multiple threads invoke the sync ioctl concurrently, they can race
on the !ubuf->sg check.  If the first thread fails to allocate the
sg_table, it temporarily assigns an error pointer to ubuf->sg before
setting it back to null:

Thread 1:
	if (!ubuf->sg) {
		ubuf->sg =3D get_sg_table(dev, buf, direction);

Thread 2 could observe ubuf->sg as an error pointer, bypass the null
check, and pass the error pointer to dma_sync_sgtable_for_cpu() further
down, triggering a kernel panic when dereferenced.

Alternatively, if both threads see !ubuf->sg as true, they could both
allocate sg_table structures, leaking one and its dma mapping.

> =20
> -	return ret;
> +	dma_sync_sgtable_for_cpu(dev, ubuf->sg, direction);

[Severity: High]
This is a pre-existing issue, but does this allow syncing with a different
direction than the original mapping?

If a user issues a sync ioctl with one direction to establish the
sg_table mapping, and then issues a subsequent sync with a different
direction, dma_sync_sgtable_for_cpu() and dma_sync_sgtable_for_device()
will be called using the new direction.

Since the dma mapping rules require sync and map directions to exactly
match unless the mapping is bidirectional, could this lead to incorrect
cache maintenance operations?

> +	return 0;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627105725.9083=
-1-robert.mader@collabora.com?part=3D1
