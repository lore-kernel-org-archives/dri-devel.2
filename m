Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17361606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UxqvMYR8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 689C910FDE8;
	Fri,  6 Nov 2026 15:19:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8038C10FDE8
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:19:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2362643B05;
 Fri,  6 Nov 2026 15:19:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 758E01F008A1;
 Fri,  6 Nov 2026 15:19:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793978380;
 bh=TjKm4iQuA3o4uEU1I1bQg4XGGc1wJZI3d+s7EI8o888=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=UxqvMYR8jFBKse3vSX1JHfmDUefXKyKFoFWGXFTOAMUEL2M1V09XvQK47Y+GKGasA
 oEYKxEgGtmRdZWrNvhzd98d8S6UuwI+ng1VlP4LhIm5X9lOdc/vSP0eQ2b69og5RSq
 LTTc/H20DTYLsX+YWmkt4X4r/aMwxhBUCTKtraLbtlX5zSWtrQd0LeOdEXzrO8DGBO
 wZWDGniulef5AJIFJWeCgwzEPOMlxM+pK31IV62u2Pr8LXhzaf19HmPiDJHxVWrN3O
 9D7hNBkNFQRqnoQowocdiz/mKYYn7lRzApjQ4bvZSxVeIL6WLqX39v6Ykrna+zHfjN
 oJbjTjXclIc7A==
Date: Fri, 6 Nov 2026 16:19:37 +0100
From: Thierry Reding <thierry.reding@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Mikko Perttunen <mperttunen@nvidia.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 01/10] drm: Add MIPI DBI bus support for MIPI DBI Type
 A and B
Message-ID: <au3telUE9A43PDWv@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-2-clamor95@gmail.com>
 <au3NWsXz-hg2LNr_@orome>
 <CAPVz0n3_oRz8aMr1W=8K7dnHhM=vuGpHjpq6+=80oXiFj5wfSg@mail.gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="n7zrqbgnjyyoeiad"
Content-Disposition: inline
In-Reply-To: <CAPVz0n3_oRz8aMr1W=8K7dnHhM=vuGpHjpq6+=80oXiFj5wfSg@mail.gmail.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--n7zrqbgnjyyoeiad
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 01/10] drm: Add MIPI DBI bus support for MIPI DBI Type
 A and B
MIME-Version: 1.0

On Fri, Nov 06, 2026 at 03:59:05PM +0200, Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:=
14 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Thu, Nov 05, 2026 at 04:05:01PM +0200, Svyatoslav Ryhel wrote:
> > [...]
> > > diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/drm=
_mipi_dbi_bus.c
> > [...]
> > > +/**
> > > + * devm_mipi_dbi_device_register() - create a managed MIPI DBI device
> > > + * @dev: device to tie the MIPI-DBI device lifetime to
> > > + * @host: DBI host to which this device is connected
> > > + * @np: device tree node associated with the panel MIPI DBI device
> > > + *
> > > + * This function is called by DBI host driver to create panel device.
> > > + * It automatically calls mipi_dbi_device_unregister() when @dev is
> > > + * unbound. It does not automatically free passed device node pointe=
r,
> > > + * it must be put manually.
> > > + *
> > > + * Returns:
> > > + * A pointer to the newly created MIPI DBI device, or, a pointer enc=
oded
> > > + * with an error.
> > > + */
> > > +struct mipi_dbi_device *
> > > +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_ho=
st *host,
> > > +                           struct device_node *np)
> > > +{
> > > +     struct mipi_dbi_device *dbidev;
> > > +     int ret;
> > > +
> > > +     if (!host || !host->dev || !host->dbi || !host->dbi->command ||
> > > +         !host->ops || !host->ops->attach || !host->ops->detach || !=
np)
> > > +             return ERR_PTR(-EINVAL);
> >
> > Do we want dev->of_node to serve as a fallback for !np?
> >
>=20
> No we don't dev->of_node is hosts node, and np is panel node.

Fair enough. The parameter name is a bit generic, but I guess if you
read the documentation it becomes clearer what it means.

> > > +
> > > +     if (!of_device_is_available(np))
> > > +             return ERR_PTR(-ENODEV);
> > > +
> > > +     dbidev =3D kzalloc_obj(*dbidev);
> > > +     if (!dbidev)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     if (of_node_test_and_set_flag(np, OF_POPULATED)) {
> > > +             kfree(dbidev);
> > > +             return ERR_PTR(-EBUSY);
> > > +     }
> > > +
> > > +     dbidev->host =3D host;
> > > +     dbidev->dbi =3D host->dbi;
> > > +     device_initialize(&dbidev->dev);
> > > +     dbidev->dev.parent =3D host->dev;
> > > +     dbidev->dev.bus =3D &mipi_dbi_bus_type;
> > > +     dbidev->dev.release =3D mipi_dbi_device_release;
> > > +     device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np))=
);
> > > +
> > > +     ret =3D dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev)=
, np->full_name);
> > > +     if (ret)
> > > +             goto put_device;
> > > +
> > > +     ret =3D device_add(&dbidev->dev);
> > > +     if (ret)
> > > +             goto put_device;
> > > +
> > > +     ret =3D devm_add_action_or_reset(dev, mipi_dbi_device_unregiste=
r,
> > > +                                    &dbidev->dev);
> > > +     if (ret)
> > > +             return ERR_PTR(ret);
> > > +
> > > +     return dbidev;
> > > +
> > > +put_device:
> > > +     of_node_clear_flag(np, OF_POPULATED);
> > > +     put_device(&dbidev->dev);
> > > +     return ERR_PTR(ret);
> > > +}
> > > +EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);
> >
> > Don't we need to of_node_put() here on failure? Otherwise we're leaking
> > the reference that we obtained inside the device_set_node() argument.
> >
>=20
> This is fully repeats device_register logic of drm_mipi_dsi.c so
> unless DSI framework has leak, this should be correct

Nobody said that drm_mipi_dsi.c is correct. I'm reviewing this patch and
it seems like it's wrong. If drm_mipi_dsi.c does the same thing it
probably is wrong, too.

> > > +static int mipi_dbi_drv_remove(struct device *dev)
> > > +{
> > > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver);
> > > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > > +
> > > +     drv->remove(dbidev);
> > > +
> > > +     return 0;
> > > +}
> >
> > Might as well make drv->remove() return an error and propagate that
> > here.
> >
>=20
> Have you even checked the code? remove() callback is and should be void.

I don't know what you're trying to say here. Yes I can see that the
remove callback returns void. My point is that device_driver.remove does
*not* return void and since this is merely a wrapper around it for DBI
it could also just return int for symmetry.

But there's also continuous work trying to convert all driver remove
callbacks to return void, so that's eventually going to get "fixed" here
anyway, so might as well leave it like this.

Thierry

--n7zrqbgnjyyoeiad
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt8AYACgkQ3SOs138+
s6HVoQ/+POh4HlRUlHe6NSx8seh6DwhH+inL91RyV3iSKS4nB3C1m4iGWUjLyp2Q
eg+OL5F6fMfhpRPwvlUvs9ADUz8dexvUm27i4kafzixOuGcTxQ9xzMqow2RkkzHC
l95B/VeBEmbCFoHDmalyCiVxLtgoZY22q6WxrL3BANzv+mNlWVtRxjnr7UEqfU4L
Y9T8afI+g36yKJNgVXQIy6/FjWupJAFnBll2fk0GC62p6r6G90TJ4MXFnCIBpl85
5Q6Nh/G7Wmz22n6coyXZGb1mDxe6Bp3OmaBOZdeMUxGsNH5+HSaCzs1NRyfrHMZV
57d0hFItwNR6XOMMtwgXCnEMIO6BmJTtt8/PwmrLkb9QKiRdSHmWsQ/q4cW5Ceqr
rQoEVS14Khr9MFtdMUtSPrhjDuNBBD7Oa1DEhbBXzQuyGEbW0BlxFMSwqD7fdqM7
X6MZ6tDkiv6ry06Qa86+i5toWK8Bon3b/vayH1YWWFhcweDahZm+EMMcc5jcFFfu
f86BVqiDBUu0iQmr+SxXHYeCgDagwS/3Wbp7Q+An51oRi10Igf418Qjj4bBcBENP
JMJJsIiRZKQz552SKSs+D7dYKQfnmwukVJRy1Nlg7VOa3tRph9Ysj/VRMmVcrd54
iO+BpszR90V2KnC6pFdsKEDa5xTfToAGxTlEA4/KaX0ukjGqALQ=
=IE6M
-----END PGP SIGNATURE-----

--n7zrqbgnjyyoeiad--
