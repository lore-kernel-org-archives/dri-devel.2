Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59D1CC43602
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 13:25:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B3C10ECFA;
	Tue,  7 Jul 2026 13:25:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="gMIXSZ7o";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 66B4910E4D0
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 13:24:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C46E40BB4;
 Tue,  7 Jul 2026 13:24:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D7F1F000E9;
 Tue,  7 Jul 2026 13:24:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783430697;
 bh=y17LUleYEX0q9MyTF0411GvfFuGvXizEjB0O8zVFy3g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=gMIXSZ7oijkXjBZ/39Tkvqx+3XLDPUSuL5CTxoCCFL2HJBmNWqY9s7PKdsdclKkRg
 rapkueMGaBEgKKPjBXXLPeFZ15tkbtFy5CuyO8EWwGSrJBK5yrzPi88hM6NcetW1vx
 /3TbIwDvtoxj9XNs3rmqHECG0nWPJzROqOHDs6ji0TzYbBqiTtCoueFu3vaeEKqySN
 xoS5Hduos042HuQu6UarM2Qu2Lcx+VLBOP7RMWDShCGjzB1NKyoSja06FHD8NLGRmf
 qzTjf03UZbs70bSSLWacYX20b82U06O4ha67YeUKEJm2SUwbVe+Bp+fOJXHx8+UjYq
 oS2aJs6BqZgfA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/20] iommu/fsl: use platform_device_set_of_node()
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
Cc: robh@kernel.org, imx@lists.linux.dev, Frank.Li@kernel.org,
 mfd@lists.linux.dev, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org, lee@kernel.org
In-Reply-To: <20260706-pdev-fwnode-ref-v3-9-1ff028e33779@oss.qualcomm.com>
References: <20260706-pdev-fwnode-ref-v3-0-1ff028e33779@oss.qualcomm.com>
 <20260706-pdev-fwnode-ref-v3-9-1ff028e33779@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 13:24:56 +0000
Message-Id: <20260707132456.C9D7F1F000E9@smtp.kernel.org>
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
- [Medium] Mixing `goto`-based error handling with `__free()` cleanup in th=
e same function.
--

commit 59e996ccb5b78974f4d3d6c2abcfbc8e49cb4d29
Author: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

iommu/fsl: use platform_device_set_of_node()

Ahead of reworking the reference counting logic for platform devices,
encapsulate the assignment of the OF node for dynamically allocated
platform devices with the provided helper.

> diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
> index 25aa477a95a95..c83bbc3faad56 100644
> --- a/drivers/iommu/fsl_pamu.c
> +++ b/drivers/iommu/fsl_pamu.c
[ ... ]
> @@ -955,7 +955,8 @@ static __init int fsl_pamu_init(void)
>  	 * PAMU node would require significant changes to a lot of code.
>  	 */
> =20
> -	np =3D of_find_compatible_node(NULL, NULL, "fsl,pamu");
> +	struct device_node *np __free(device_node) =3D
> +			of_find_compatible_node(NULL, NULL, "fsl,pamu");
>  	if (!np) {
>  		pr_err("could not find a PAMU node\n");
>  		return -ENODEV;
> @@ -964,7 +965,7 @@ static __init int fsl_pamu_init(void)
>  	ret =3D platform_driver_register(&fsl_of_pamu_driver);
>  	if (ret) {
>  		pr_err("could not register driver (err=3D%i)\n", ret);
> -		goto error_driver_register;
> +		return ret;
>  	}
> =20
>  	pdev =3D platform_device_alloc("fsl-of-pamu", 0);
> @@ -973,7 +974,8 @@ static __init int fsl_pamu_init(void)
>  		ret =3D -ENOMEM;
>  		goto error_device_alloc;

[Severity: Medium]
Is it intentional to mix goto-based error handling with scope-based
cleanup in fsl_pamu_init()?

The cleanup helper documentation in include/linux/cleanup.h specifies that
goto and cleanup helpers should never be mixed in the same function to
prevent confusing ownership semantics.

Since pdev allocation and other initialization steps in this function still
use goto labels (like error_device_alloc and error_device_add), should they
all be converted to scope-based cleanup, or should np remain manually
managed to keep the error handling consistent?

> -	pdev->dev.of_node =3D of_node_get(np);
> +
> +	platform_device_set_of_node(pdev, np);
> =20
>  	ret =3D pamu_domain_init();
>  	if (ret)
> @@ -988,17 +990,11 @@ static __init int fsl_pamu_init(void)
>  	return 0;
> =20
>  error_device_add:
> -	of_node_put(pdev->dev.of_node);
> -	pdev->dev.of_node =3D NULL;
> -
>  	platform_device_put(pdev);
> =20
>  error_device_alloc:
>  	platform_driver_unregister(&fsl_of_pamu_driver);
> =20
> -error_driver_register:
> -	of_node_put(np);
> -
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706-pdev-fwnod=
e-ref-v3-0-1ff028e33779@oss.qualcomm.com?part=3D9
