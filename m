Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D21606A32E
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y8yIg0AE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F26B10E922;
	Fri,  6 Nov 2026 13:14:46 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8833410EA07
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:14:39 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2E6BA41FDA;
 Fri,  6 Nov 2026 13:14:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7694E1F0089F;
 Fri,  6 Nov 2026 13:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793970879;
 bh=wQd/1GxfqRGjuONMNO2FeyamvE0fWukXqcmiOK2zleQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y8yIg0AE5QNEjX4VYWP+MQ/Q6EvOq3BLHAn/bicgSvUSY4BIP6y/IgCyhyfU75VcC
 Sz2RRAEibULmlgBF6A65oE0KcOMc8zIH2c+AnbY5bBk5dDP6AeKX7sQdFxs5PZQVhi
 kt735/mHkkjl19/kHmIfhboGUiEAl4aTfFa3rNnR92QA3vfmthoV+88y1P21Gc/I7d
 GsdEP2JlpBkNenBpnOp00TNZ55KkFjCs+mKPdb1fOKzBe5N08B/aFKWOkMR98sOqpA
 +HNKXlbmhmY7pozDu41dx6KU95l4aq0ZVsb2CViLALyBJMMzdDaPiAnw0m+TSTF/g5
 zDi1E7vB4UX7w==
Date: Fri, 6 Nov 2026 14:14:36 +0100
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
Message-ID: <au3NWsXz-hg2LNr_@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-2-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="jmfgirtvictr6chv"
Content-Disposition: inline
In-Reply-To: <20261105140510.165165-2-clamor95@gmail.com>
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


--jmfgirtvictr6chv
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v6 01/10] drm: Add MIPI DBI bus support for MIPI DBI Type
 A and B
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:05:01PM +0200, Svyatoslav Ryhel wrote:
[...]
> diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/drm_mipi_dbi_bus.c
[...]
> +/**
> + * devm_mipi_dbi_device_register() - create a managed MIPI DBI device
> + * @dev: device to tie the MIPI-DBI device lifetime to
> + * @host: DBI host to which this device is connected
> + * @np: device tree node associated with the panel MIPI DBI device
> + *
> + * This function is called by DBI host driver to create panel device.
> + * It automatically calls mipi_dbi_device_unregister() when @dev is
> + * unbound. It does not automatically free passed device node pointer,
> + * it must be put manually.
> + *
> + * Returns:
> + * A pointer to the newly created MIPI DBI device, or, a pointer encoded
> + * with an error.
> + */
> +struct mipi_dbi_device *
> +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_host *host,
> +			      struct device_node *np)
> +{
> +	struct mipi_dbi_device *dbidev;
> +	int ret;
> +
> +	if (!host || !host->dev || !host->dbi || !host->dbi->command ||
> +	    !host->ops || !host->ops->attach || !host->ops->detach || !np)
> +		return ERR_PTR(-EINVAL);

Do we want dev->of_node to serve as a fallback for !np?

> +
> +	if (!of_device_is_available(np))
> +		return ERR_PTR(-ENODEV);
> +
> +	dbidev = kzalloc_obj(*dbidev);
> +	if (!dbidev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_node_test_and_set_flag(np, OF_POPULATED)) {
> +		kfree(dbidev);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	dbidev->host = host;
> +	dbidev->dbi = host->dbi;
> +	device_initialize(&dbidev->dev);
> +	dbidev->dev.parent = host->dev;
> +	dbidev->dev.bus = &mipi_dbi_bus_type;
> +	dbidev->dev.release = mipi_dbi_device_release;
> +	device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np)));
> +
> +	ret = dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev), np->full_name);
> +	if (ret)
> +		goto put_device;
> +
> +	ret = device_add(&dbidev->dev);
> +	if (ret)
> +		goto put_device;
> +
> +	ret = devm_add_action_or_reset(dev, mipi_dbi_device_unregister,
> +				       &dbidev->dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return dbidev;
> +
> +put_device:
> +	of_node_clear_flag(np, OF_POPULATED);
> +	put_device(&dbidev->dev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);

Don't we need to of_node_put() here on failure? Otherwise we're leaking
the reference that we obtained inside the device_set_node() argument.

> +static int mipi_dbi_drv_remove(struct device *dev)
> +{
> +	struct mipi_dbi_driver *drv = to_mipi_dbi_driver(dev->driver);
> +	struct mipi_dbi_device *dbidev = to_mipi_dbi_device(dev);
> +
> +	drv->remove(dbidev);
> +
> +	return 0;
> +}

Might as well make drv->remove() return an error and propagate that
here.

Thierry

--jmfgirtvictr6chv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt0rkACgkQ3SOs138+
s6GqSQ/8Djjroo6Enqv66xMCla9Ww7WZy+XrFpOUFb9u33ltccrv2kkVlqKln+AP
/YR8KGS64GDgYgYbdpqup7+937gAV015x50hq6W/R3mCWlRqV2kmEMRv+ujBFVg6
kKXBJMxhl3JmqX+lqw30nx//W8bC29XPCRVY8xL/N2q70NW5z6go9BKMuin8qTHr
d1xYgAH5YsWW6WiE3WmzqbmDJVl4BBMkBnihuHORk4FY+atq5T/iYSLLDnCrWhhE
YOcb0JmmXCqOZmQK+hiQA11CeWofXJ6klkehbZrKP+OcXEVnw/NS5RYwcba+3XaE
+vYTvx7/kEwaCVRQL7JN6PKSqVUonAy5Hb0lKsjfZMF5G0AnQ+A7xmJemDj4hXHc
QK1XU3ppdwpeNkY4OdYGZdoZ5OSd/o8YoqLXFmzO1FSWKossx/Ec5NHs/aBS/rV2
yiQs1u6fY7YaD7gOktNKHNJttRHQ0DiOWwti2041fYUAguUsu6XZbk8SS8RCczHq
u3r0/1gxv8a0O2Tn+9Bdfmnu9srEt1lp9zjpv0lcHFuLjkZXPyRnIKhylXk5Ujdh
efaaCN3UXDI1MpMEXN5j1XH6s7DwmlVRdWkxDkwxQw84piMKEn1MdoqReoe4j+tV
MZgXudfbhJBY2ZVwq4hR6yDBKfTCemk3UQliHwY1Kz4y1oUUIJE=
=C0s4
-----END PGP SIGNATURE-----

--jmfgirtvictr6chv--
