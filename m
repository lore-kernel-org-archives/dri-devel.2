Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57091C43458
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 18:45:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC94F10E641;
	Mon, 13 Jul 2026 18:45:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d5IvSLT/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E28210E641;
 Mon, 13 Jul 2026 18:45:19 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CD25960120;
 Mon, 13 Jul 2026 18:45:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A9AB1F000E9;
 Mon, 13 Jul 2026 18:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783968318;
 bh=3TSC+KUdH5M4xCMXy9wz487OBFA6h8jcvMXeHdaql+w=;
 h=Date:Cc:To:From:Subject:References:In-Reply-To;
 b=d5IvSLT/rz/829HpPPFjo+XOrJDmLVod1rZITHILzsDv4EcLo3fYShqoayG8n7Yuj
 /B2iKHULn7/VJZdzCe1wFTZsxMq/RjerO7eK2rvC1ZZ6dhtE23MY1pBM+vPWyjPVWK
 rCbLmMnTW7Bn6ywp859cpd/qCQxpgxp51szycmQdrQ2+50YYdLFxden7OmLAS4fl8r
 SECz7Lruw9T+HR5Jp2AdLueN3Jn9SZIIHZ0rOuJyN0kOKW6eXghpqBkwaVCWGDLOhh
 g6OpQuIYkadq9oAJD8pawXfbQJMNX2xRrfseAFQT7k9FRWNGylIDrRVT4qCi7SrNuv
 Xs+H1wopc266Q==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 13 Jul 2026 20:45:13 +0200
Message-Id: <DJXNZLE3L756.K5DYSTKM1UHT@kernel.org>
Cc: "Maximilian Luz" <luzmaximilian@gmail.com>, "Hans de Goede"
 <hansg@kernel.org>, =?utf-8?q?Ilpo_J=C3=A4rvinen?=
 <ilpo.jarvinen@linux.intel.com>, "Matthew Brost" <matthew.brost@intel.com>,
 =?utf-8?q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 "Rodrigo Vivi" <rodrigo.vivi@intel.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, <brgl@kernel.org>,
 <platform-driver-x86@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <driver-core@lists.linux.dev>
To: "Bartosz Golaszewski" <bartosz.golaszewski@oss.qualcomm.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v7 3/4] driver core: platform: unify release path
References: <20260713-swnode-remove-on-dev-unreg-v7-0-6d6bc448427a@oss.qualcomm.com>
 <20260713-swnode-remove-on-dev-unreg-v7-3-6d6bc448427a@oss.qualcomm.com>
In-Reply-To: <20260713-swnode-remove-on-dev-unreg-v7-3-6d6bc448427a@oss.qualcomm.com>
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Mon Jul 13, 2026 at 5:11 PM CEST, Bartosz Golaszewski wrote:
> @@ -599,6 +599,7 @@ static void platform_device_release(struct device *de=
v)
>  	struct platform_object *pa =3D container_of(dev, struct platform_object=
,
>  						  pdev.dev);
> =20
> +	device_remove_software_node(dev);
>  	fwnode_handle_put(pa->pdev.dev.fwnode);

This technically changes the semantics of platform_device_set_fwnode():

Previously it took an additional reference count for the fwnode pointer pas=
sed
to it. But now, *iff* the fwnode is a software node it consumes the callers
reference count, which for obvious reasons isn't great.

Now, platform_device_set_fwnode() is unused now, so we could just get rid o=
f it,
which also gets us rid of its asymmetric semantics.

However, couldn't we also just move the if (is_software_node(pdevinfo->fwno=
de))
conditional up here, such that we have:

	device_remove_software_node(dev);
	if (!is_software_node(dev->fwnode))
	    fwnode_handle_put(pa->pdev.dev.fwnode);

This way, the swnode special case would go away. Well, at least the "two
reference counts" special case.

Another special case I just noticed still remains, but is independent of th=
is
change:

If platform_device_set_fwnode() or platform_device_set_of_node() is called =
for a
device that already has a swnode set, we only call fwnode_handle_put(), but
software_node_notify_remove() etc. isn't called.

Of course that never happens, but it is an inconsistency in the API. Now, i=
t
seems that neither platform_device_set_fwnode() (which we should remove any=
way),
nor platform_device_set_of_node() is ever called with a fwnode already set.

So, either we have to special case platform_device_set_of_node() too (for t=
he
case that a swnode is set already), or just require that the function must =
only
be called when no node has been set, as all users already do; I'd go for th=
e
latter.

If my proposal about moving the is_software_node() check into
platform_device_release() holds, it would probably be good to just add thos=
e
patches in a subsequent version, otherwise I'm happy to pull this in as is =
and
address the other stuff subsequently.

>  	kfree(pa->pdev.dev.platform_data);
>  	kfree(pa->pdev.mfd_cell);
> @@ -606,12 +607,6 @@ static void platform_device_release(struct device *d=
ev)
>  	kfree(pa);
>  }
> =20
> -static void platform_device_release_full(struct device *dev)
> -{
> -	device_remove_software_node(dev);
> -	platform_device_release(dev);
> -}
> -
>  /**
>   * platform_device_alloc - create a platform device
>   * @name: base name of the device we're adding
> @@ -933,6 +928,16 @@ struct platform_device *platform_device_register_ful=
l(const struct platform_devi
>  		pdev->dev.coherent_dma_mask =3D pdevinfo->dma_mask;
>  	}
> =20
> +	/*
> +	 * If the primary firmware node is a software node and there's no
> +	 * secondary firmware node, the primary will be affected by the call
> +	 * to device_remove_software_node() in platform_device_release() and
> +	 * its reference count will be dropped by one. Take another reference
> +	 * here to make it have no effect.
> +	 */
> +	if (is_software_node(pdevinfo->fwnode))
> +		fwnode_handle_get(pdevinfo->fwnode);
> +
>  	ret =3D platform_device_add_resources(pdev, pdevinfo->res, pdevinfo->nu=
m_res);
>  	if (ret)
>  		goto err;
> @@ -945,8 +950,6 @@ struct platform_device *platform_device_register_full=
(const struct platform_devi
>  		ret =3D device_add_software_node(&pdev->dev, pdevinfo->swnode);
>  		if (ret)
>  			goto err;
> -
> -		pdev->dev.release =3D platform_device_release_full;
>  	} else if (pdevinfo->properties) {
>  		ret =3D device_create_managed_software_node(&pdev->dev,
>  							  pdevinfo->properties, NULL);
>
> --=20
> 2.47.3

