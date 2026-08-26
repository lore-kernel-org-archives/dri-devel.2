Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2ABF5C5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:45:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 688F310ED3B;
	Wed, 26 Aug 2026 13:45:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GCUkAh62";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD4E910ED3B
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:45:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7602441462;
 Wed, 26 Aug 2026 13:45:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87D201F000E9;
 Wed, 26 Aug 2026 13:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787751937;
 bh=rmDd62rIRYn6TIf+Bj7/wbRACHQk6VDo+E9/bAH62JY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GCUkAh62cqsmIfz3tnJr4ZnmE/EUFMjzOk0z5j/wHQaEdOrEMGbbsl4V01M4Bgzw2
 85zEK1XVmbeisuE/Jcs7dOQmHNJlXDqVupT4+F4JRb0kgP21SORvzCyp+XeS36HwXD
 sHUR4sI9Je0RodkJn7ofSyNz0tfkkwswGR0fHGZrrPAhgWrCihBceuVVjrL2CZZOPh
 sAnCPATQ4ep4K/WpFPdj6kjawUP9DCxT4xFO97CeyUT2p1n3Q4dnntuZXZ14D8tyQB
 h5iUcQE5fEDYxm8DWPY/5KUGJAyzBU25kmHVP5kbA77cbJUOmlSqTn88u006hn3rj5
 3djR7Vk47/jig==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/3] misc: fastrpc: iterate CB nodes manually instead
 of of_platform_populate
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260826-dup-sessions-v4-1-35555d2bfed4@oss.qualcomm.com>
References: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
 <20260826-dup-sessions-v4-1-35555d2bfed4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 13:45:36 +0000
Message-Id: <20260826134536.87D201F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Critical Use-After-Free and uninitialized state exposure when =
`fastrpc_rpmsg_probe` fails after prematurely registering the misc device.
- [High] Preexisting Use-After-Free in `fastrpc_rpmsg_probe()` where `rdev-=
>dma_mask` is left pointing to freed memory on error paths.
- [High] Use-After-Free of context bank devices (`sess->dev`) upon fastrpc =
channel removal due to missing device references.
--

commit e928c95aa5ca7ef57a0d4943351ae2891fcf2b1c
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

    misc: fastrpc: iterate CB nodes manually instead of of_platform_populate
   =20
    of_platform_populate() only guarantees that child devices are registere=
d,
    not that their probes have completed before it returns. This creates a
    window where fastrpc_cb_init() may not have run for all context bank
    nodes, leaving the channel context partially initialised.

> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d4fac2caca867..a153107d00853 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2363,7 +2363,7 @@ static const struct file_operations fastrpc_fops =
=3D {
>  	.compat_ioctl =3D fastrpc_device_ioctl,
>  };
> =20
> -static int fastrpc_cb_probe(struct platform_device *pdev)
> +static int fastrpc_cb_init(struct platform_device *pdev)
>  {
>  	struct fastrpc_channel_ctx *cctx;
>  	struct fastrpc_session_ctx *sess;
> @@ -2385,7 +2385,7 @@ static int fastrpc_cb_probe(struct platform_device =
*pdev)
>  	spin_lock_irqsave(&cctx->lock, flags);
>  	if (cctx->sesscount >=3D FASTRPC_MAX_SESSIONS) {
>  		spin_unlock_irqrestore(&cctx->lock, flags);
> -		dev_err(&pdev->dev, "too many sessions\n");
> +		dev_err(dev, "too many sessions\n");
>  		return -ENOSPC;
>  	}
>  	dma_bits =3D cctx->soc_data->dma_addr_bits_default;

[Severity: High]
This is a pre-existing issue, but does fastrpc_cb_init() save the child
device pointer without holding a reference to it?

If sess->dev is assigned without get_device(dev), and fastrpc_rpmsg_remove()
calls of_platform_depopulate(), the child platform devices are destroyed.

Since active file descriptors aren't revoked, could an active ioctl later
call fastrpc_dmabuf_alloc() and invoke dma_alloc_coherent() on fl->sctx->de=
v,
using the dangling pointer and leading to a use-after-free?

[ ... ]

> @@ -2642,12 +2610,29 @@ static int fastrpc_rpmsg_probe(struct rpmsg_devic=
e *rpdev)
>  	data->rpdev =3D rpdev;
>  	dev_set_drvdata(&rpdev->dev, data);
> =20
> -	err =3D of_platform_populate(rdev->of_node, NULL, NULL, rdev);
> -	if (err)
> -		goto err_deregister_fdev;
> +	of_node_set_flag(rdev->of_node, OF_POPULATED_BUS);
> +
> +	for_each_available_child_of_node_scoped(rdev->of_node, np) {
> +		struct platform_device *pdev;
> +
> +		if (!of_device_is_compatible(np, "qcom,fastrpc-compute-cb"))
> +			continue;
> +
> +		pdev =3D of_platform_device_create(np, NULL, rdev);
> +		if (!pdev) {
> +			err =3D -EINVAL;
> +			goto err_depopulate;
> +		}
> +
> +		err =3D fastrpc_cb_init(pdev);
> +		if (err)
> +			goto err_depopulate;

[Severity: Critical]
This is a pre-existing issue, but is it possible that this error path leads
to a use-after-free and uninitialized state exposure?

Earlier in fastrpc_rpmsg_probe(), fastrpc_device_register() is called, which
makes the misc device available to userspace. A userspace program can then
open the device, acquiring a reference to the data structure.

If fastrpc_cb_init() fails here, the code jumps to err_depopulate, and
eventually calls kfree(data).

Since userspace could already have an open file descriptor pointing to data,
would this kfree() result in a use-after-free when subsequent ioctls or
close() are called?

[Severity: High]
This isn't a bug introduced by this patch, but does the same error path lea=
ve
rdev->dma_mask pointing to freed memory?

Earlier in fastrpc_rpmsg_probe(), rdev->dma_mask is redirected to point
to the dynamically allocated &data->dma_mask.

If this probe function fails and frees data via kfree(data), the rpmsg
device remains in the system unbound.

Will a userspace read of /sys/devices/.../dma_mask_bits trigger a read from
freed memory through dma_mask_bits_show() since rdev->dma_mask wasn't
restored to its original value?

> +	}
> =20
>  	return 0;
> =20
> +err_depopulate:
> +	of_platform_depopulate(rdev);
>  err_deregister_fdev:
>  	if (data->fdevice)
>  		misc_deregister(&data->fdevice->miscdev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-dup-sessio=
ns-v4-0-35555d2bfed4@oss.qualcomm.com?part=3D1
