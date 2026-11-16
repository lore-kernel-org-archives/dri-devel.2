Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47DB606A335
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 15:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AfXgnQgs
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C6BE10E374;
	Mon, 16 Nov 2026 15:29:00 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3378D10E374
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 15:28:53 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4FBFF62D4D;
 Mon, 16 Nov 2026 15:28:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B24AC1F000C5;
 Mon, 16 Nov 2026 15:28:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794842932;
 bh=tZhTnQbYIbjZhKfBc+r2nUv/hvc2DSlcksaKfjVwbLI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AfXgnQgsSq7B9ou/mtG1XQdx8whk2api9zifwMwnxWl2OY8PiWgf8+FE/1+0zgNtf
 eW97ox9l1YRcHXOXymZdAUOAmlb3yHDlpD2o3f6njn1Z7H3bCIALhdrEDx0c/SZGMJ
 X1CJAxtufCJvgGjCSwPFvlol845Q3Wu4EgNT1OfpymQnht46RngT3Y80PB608AMnP8
 VymQHcOmJQdSBAD9wGzNkBORKVCsI0iuyf2jXL9UfMBJAID+Ld0p+2D0OVL3LDqcVE
 SmKvuljPRQqc5d4qoEUSwOhyJ660RxZab3aNG0loEAPvY9xdqkg2InIxhLJhr18N19
 PJLtPJ5QuUQ3Q==
Message-ID: <sashiko-outbox-217274@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/12] drm: Add MIPI DBI bus support for MIPI DBI
 Type A and B
To: "Svyatoslav Ryhel" <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261116151017.274764-2-clamor95@gmail.com>
References: <20261116151017.274764-1-clamor95@gmail.com>
 <20261116151017.274764-2-clamor95@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 15:28:51 +0000
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
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm: unbalanced of_node_put() in mipi_dbi_device_release()
- [Low] drm: mismatched Return kernel-doc in drm_mipi_dbi_bus.c
--

commit 3fe40d87109b802b6b8c4ac15ef288e1fecb74a0
Author: Svyatoslav Ryhel <clamor95@gmail.com>

drm: Add MIPI DBI bus support for MIPI DBI Type A and B

This commit introduces a MIPI DBI bus and driver model infrastructure to
support MIPI DBI Type A and Type B hosts and peripheral devices.

> diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/drm_mip=
i_dbi_bus.c
> new file mode 100644
> index 0000000000000..fa8cd748d7b3c
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_mipi_dbi_bus.c

[ ... ]

> +static void mipi_dbi_device_release(struct device *dev)
> +{
> +	of_node_put(dev->of_node);
> +	kfree(to_mipi_dbi_device(dev));
> +}
> +
> +static void mipi_dbi_device_unregister(void *data)
> +{
> +	struct device *dev =3D data;
> +
> +	of_node_clear_flag(dev->of_node, OF_POPULATED);
> +	device_unregister(dev);
> +}
> +
> +/**
> + * devm_mipi_dbi_device_register() - create a managed peripheral MIPI DBI
> + *				     Type A or B device.
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
> +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_host *=
host,
> +			      struct device_node *np)
> +{
> +	struct mipi_dbi_device *dbidev;
> +	int ret;
> +
> +	if (!host || !host->dev || !host->dbi || !host->dbi->command ||
> +	    !host->ops || !host->ops->attach || !host->ops->detach || !np)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!of_device_is_available(np))
> +		return ERR_PTR(-ENODEV);
> +
> +	dbidev =3D kzalloc_obj(*dbidev);
> +	if (!dbidev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_node_test_and_set_flag(np, OF_POPULATED)) {
> +		kfree(dbidev);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	dbidev->host =3D host;
> +	dbidev->dbi =3D host->dbi;
> +	device_initialize(&dbidev->dev);
> +	dbidev->dev.parent =3D host->dev;
> +	dbidev->dev.bus =3D &mipi_dbi_bus_type;
> +	dbidev->dev.release =3D mipi_dbi_device_release;
> +	device_set_node(&dbidev->dev, of_fwnode_handle(np));
> +
> +	ret =3D dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev), np->fu=
ll_name);
> +	if (ret)
> +		goto put_device;
> +
> +	ret =3D device_add(&dbidev->dev);
> +	if (ret)
> +		goto put_device;
> +
> +	ret =3D devm_add_action_or_reset(dev, mipi_dbi_device_unregister,
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

[Severity: High]
Does mipi_dbi_device_release() drop a reference on dev->of_node that
devm_mipi_dbi_device_register() never acquired?

device_set_node(&dbidev->dev, of_fwnode_handle(np)) does not call
of_node_get(np), and callers are documented as still owning their reference
to np.  When put_device() runs on error unwind or when
mipi_dbi_device_unregister() later unregisters the device,
mipi_dbi_device_release() calls of_node_put(dev->of_node) and underflows the
device_node refcount.  Should devm_mipi_dbi_device_register() call
of_node_get(np) when associating np with dbidev->dev?

[ ... ]

> +/**
> + * devm_mipi_dbi_attach() - managed attach of peripheral DBI device to i=
ts MIPI
> + *			    DBI Type A or B devices.
> + * @dev: device to tie the MIPI-DBI device lifetime to
> + * @dbidev: DBI peripheral
> + */
> +int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device *dbi=
dev)

[ ... ]

> +/**
> + * mipi_dbi_driver_unregister() - unregister a driver for MIPI DBI Type =
A or B devices.
> + * @drv: DBI driver structure
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv)

[ ... ]

> diff --git a/include/drm/drm_mipi_dbi_bus.h b/include/drm/drm_mipi_dbi_bu=
s.h
> new file mode 100644
> index 0000000000000..886f175a80cb9
> --- /dev/null
> +++ b/include/drm/drm_mipi_dbi_bus.h

[ ... ]

> +/**
> + * struct mipi_dbi_device - DBI peripheral device for MIPI DBI Type A an=
d B.
> + *			    This structure describes a peripheral DBI device,
> + *			    an endpoint for DSC commands and video data, and must
> + *			    be paired with a DBI host device for MIPI DBI Type A
> + *			    and B. This layout is built to closely resemble
> + *			    the DSI framework.
> + *
> + *			    If your device is MIPI DBI Type C (with an SPI
> + *			    control bus) and incorporates DBI within, you
> + *			    should use the mipi_dbi_dev structure and Type C
> + *			    framework from drm_mipi_dbi.c.
> + * @dev: driver model device node for this peripheral
> + * @dbi: MIPI DBI interface
> + * @host: DBI host for this peripheral
> + * @attached: the DBI device has been successfully attached
> + */
> +struct mipi_dbi_device {

[Severity: Low]
This isn't a bug, but the Return: kernel-doc line on
mipi_dbi_driver_unregister() (which returns void) looks like it belongs on
devm_mipi_dbi_attach(), which returns int and has no Return: section.  Also,
in struct mipi_dbi_device, the extended description paragraphs appear before
the @member entries without a blank comment line after the one-line summary.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116151017.2747=
64-1-clamor95@gmail.com?part=3D1
