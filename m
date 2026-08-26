Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2104FC5DF97
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:40:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7596010ED0F;
	Wed, 26 Aug 2026 13:40:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="BnBfpI8H";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4CA8C10ED0F
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 13:40:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1274F404AE;
 Wed, 26 Aug 2026 13:40:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A55A41F000E9;
 Wed, 26 Aug 2026 13:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787751634;
 bh=i6Vx3i8N9dEOeQyPgCLWAqdLLSmhfHzh1p08UG3R8fk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BnBfpI8HUXiIEgRS2y12RyhT3gihvJb3HzDgtaOtwsFzpbhn9vFOj2iEIs5lLme9K
 YAr9DxGln4OKWBFSE7lml6EeKokx4U33JZpP5iSNbxKhv0L4vAeGhEPE8RQkVaYNio
 t8lLWtbOr282B2dCZbKYzRDob3GLtzj2ANOWvO1IfGLmK0INzKIqcSVcyAELkXWJ/g
 n5Q3atpdVwXOUNUPmMppr06yD6zZA/RdLqwTaM/qAt/Dp7+Uj/kKHYYFJIZUivMXFJ
 S7iGjMa0OKqJG42FPmG7hmdtMlPWxKm3jahU3RimupQaEvCRPJeFpsvUnyjLXPgdi5
 l0fhac86iZOgA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/3] dt-bindings: misc: qcom,fastrpc: deprecate
 qcom,nsessions
To: "Vinayak Katoch" <vinayak.katoch@oss.qualcomm.com>
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260826-dup-sessions-v4-3-35555d2bfed4@oss.qualcomm.com>
References: <20260826-dup-sessions-v4-0-35555d2bfed4@oss.qualcomm.com>
 <20260826-dup-sessions-v4-3-35555d2bfed4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 13:40:33 +0000
Message-Id: <20260826134033.A55A41F000E9@smtp.kernel.org>
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

New issues:
- [High] Child context bank devices are never attached to their IOMMU domai=
ns, breaking DMA mapping and causing SMMU faults.

Pre-existing issues:
- [High] Unconditional `kfree(data)` on the probe error path causes a Use-A=
fter-Free if userspace opened the device.
--

commit e928c95aa5ca7ef57a0d4943351ae2891fcf2b1c
Author: Vinayak Katoch <vinayak.katoch@oss.qualcomm.com>

misc: fastrpc: iterate CB nodes manually instead of of_platform_populate

This commit replaces of_platform_populate() with manual iteration over child
device tree nodes to initialize qcom,fastrpc-compute-cb devices synchronous=
ly.
It aims to ensure all context banks are fully initialized before
fastrpc_rpmsg_probe() returns by directly calling fastrpc_cb_init().

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

[Severity: High]
By replacing driver core matching with manual of_platform_device_create()
followed by fastrpc_cb_init() in fastrpc_rpmsg_probe(), does this child
device skip the driver core's platform probe path?

It appears this manual initialization skips IOMMU and DMA configuration
logic, such as of_dma_configure(), which normally runs during probe.

Since these context bank devices are no longer bound to a platform driver,
they are never attached to their SMMU domains. Could this result in SMMU
translation faults and a failure of DSP context bank DMA operations when a
DSP invocation attempts DMA?

> +		if (err)
> +			goto err_depopulate;
> +	}
> =20
>  	return 0;
> =20
> +err_depopulate:
> +	of_platform_depopulate(rdev);
>  err_deregister_fdev:
>  	if (data->fdevice)
>  		misc_deregister(&data->fdevice->miscdev);

[Severity: High]
This is a pre-existing issue, but if fastrpc_cb_init() fails, this error pa=
th
jumps to err_depopulate and eventually reaches err_free_data in
fastrpc_rpmsg_probe():

err_free_data:
	kfree(data);
	return err;

Since fastrpc_device_register() makes the misc device available to userspace
earlier in the probe, what happens if userspace has already called open()
and incremented the data reference count via fastrpc_channel_ctx_get()?

Does this unconditional kfree(data) ignore active references held by open
file descriptors, leading to a use-after-free condition if userspace later
performs an ioctl() on the still-open file descriptor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-dup-sessio=
ns-v4-0-35555d2bfed4@oss.qualcomm.com?part=3D3
