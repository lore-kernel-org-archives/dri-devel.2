Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DF6606A323
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 03:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cpAmYN3X
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E1D10E417;
	Thu, 12 Nov 2026 03:58:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A0B10E417
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 03:58:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DA1F8458C7;
 Thu, 12 Nov 2026 03:58:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D44E1F00A05;
 Thu, 12 Nov 2026 03:58:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794455912;
 bh=D+ZUcvHnxjfWcLta5xUDFb/W3TFG3jo/LzfOHtlwMiA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cpAmYN3X+qUPt9XVKAfaOAR29MXT1RgI9bUhCReQJjCIsgbkYba7ar2ORbbCiScGj
 /vFfo2QsvbxjtKeUUjer5XlqyuLU5TIQzkog58IWXOCTy1syONjDE7RbL5r1mP0Yyr
 MHtC9k+p7euuAu3oa9s3LqRhWITkyxNTQNmtYberlbcZD/qj9kbi7CcYHI7JI6D0MW
 iklhz7Oaqm5ZWJret7xISVe6CEDJm44O3K4PII4kIKQKMk0/LXbAKwUvUzDFG4MMQ5
 D3cnLRZ9W5XKKcn/+za/JCixIHVMyJQctGhdBewU3y2jsxPgFZIX9RUmJx9Ei0qUXl
 N41xVcAyG4KKw==
Message-ID: <sashiko-outbox-210305@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] drm/fl2000: Add ITE IT66121 HDMI transmitter
 support
To: "Angel Gabriel Crispin Valdivia" <angelcrispinvaldivia@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261111-fl2000-upstream-v2-2-201f87708cb0@gmail.com>
References: <20261111-fl2000-upstream-v2-0-201f87708cb0@gmail.com>
 <20261111-fl2000-upstream-v2-2-201f87708cb0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 03:58:32 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/fl2000: duplicate IT66121 driver and unbound devres in
  it66121_create()
- [Medium] drm/fl2000: commit message claims EDID caching not in
  it66121_bridge_edid_read()
- [Medium] drm/fl2000: use-after-free of priv->client in
  it66121_bridge_detect()
--

commit a3c9c50f6dcb635240f532485f69c80008aed756
Author: Angel Gabriel Crispin Valdivia <angelcrispinvaldivia@gmail.com>

drm/fl2000: Add ITE IT66121 HDMI transmitter support

This commit adds a DRM bridge driver for the ITE IT66121 HDMI transmitter
on the FL2000 I2C bus and wires its creation and destruction into the USB
driver probe and disconnect paths.

> diff --git a/drivers/gpu/drm/fl2000/fl2000_it66121.c b/drivers/gpu/drm/fl=
2000/fl2000_it66121.c
> new file mode 100644
> index 0000000000000..7235317b0ceb7
> --- /dev/null
> +++ b/drivers/gpu/drm/fl2000/fl2000_it66121.c
[ ... ]
> +int it66121_hpd_connected(struct drm_bridge *bridge)
> +{
> +	struct it66121_priv *priv =3D container_of(bridge, struct it66121_priv,=
 bridge);
> +	unsigned int val;
> +	int idx, ret;
> +
> +	if (!drm_bridge_enter(bridge, &idx))
> +		return -ENODEV;
> +
> +	ret =3D regmap_field_read(priv->hpd, &val);
> +	drm_bridge_exit(idx);
> +	if (ret)
> +		return ret;
> +
> +	return !!val;
> +}
[ ... ]
> +static enum drm_connector_status it66121_bridge_detect(struct drm_bridge=
 *bridge,
> +						       struct drm_connector *connector)
> +{
> +	struct it66121_priv *priv =3D container_of(bridge, struct it66121_priv,=
 bridge);
> +	int ret =3D it66121_hpd_connected(bridge);
> +
> +	if (ret > 0)
> +		return connector_status_connected;
> +
> +	/* Gone with the USB device */
> +	if (ret =3D=3D -ENODEV)
> +		return connector_status_disconnected;
> +
> +	if (ret < 0) {
> +		/* Not bridge->dev: the chip, not the DRM device, failed to answer */
> +		dev_err_ratelimited(&priv->client->dev, "Cannot get monitor status (%d=
)\n", ret);
> +		return connector_status_unknown;
> +	}
> +
> +	return connector_status_disconnected;
> +}

[Severity: Medium]
Can it66121_bridge_detect() cause a use-after-free on priv->client if the
USB device is unplugged while regmap_field_read() is in flight?

When a USB control transfer fails during disconnect, fl2000_i2c_dword()
maps the error to -EIO:

drivers/gpu/drm/fl2000/fl2000_registers.c:fl2000_i2c_dword() {
    ...
	ret =3D regmap_write_bits(regmap, FL2000_VGA_I2C_SC_REG, mask, val);
	if (ret)
		return -EIO;
    ...
}

Because it66121_hpd_connected() calls drm_bridge_exit() before returning
that -EIO to it66121_bridge_detect(), a concurrent USB disconnect can
finish drm_bridge_unplug() and free priv->client before
dev_err_ratelimited() runs:

CPU0                                  CPU1
it66121_bridge_detect()
  it66121_hpd_connected()
    drm_bridge_enter()
    regmap_field_read() -> -EIO
    drm_bridge_exit()
                                      fl2000_disconnect()
                                        it66121_destroy()
                                          drm_bridge_unplug()
                                          i2c_unregister_device(priv->clien=
t)
  dev_err_ratelimited(&priv->client->dev, ...)
    <-- use-after-free

> +static const struct drm_edid *it66121_bridge_edid_read(struct drm_bridge=
 *bridge,
> +						       struct drm_connector *connector)
> +{
> +	struct it66121_priv *priv =3D container_of(bridge, struct it66121_priv,=
 bridge);
> +	const struct drm_edid *drm_edid;
> +	int idx, ret;
> +
> +	if (!drm_bridge_enter(bridge, &idx))
> +		return NULL;
> +
> +	if (priv->ddc_held) {
> +		/* Not fatal: the read tells whether the bus is free */
> +		ret =3D it66121_release_ddc(priv);
> +		if (ret)
> +			dev_dbg(&priv->client->dev, "Cannot release the DDC bus (%d)\n", ret);
> +		priv->ddc_held =3D false;
> +	}
> +
> +	drm_edid =3D drm_edid_read_custom(connector, it66121_get_edid_block, pr=
iv);
> +	if (!drm_edid)
> +		dev_warn(&priv->client->dev, "EDID read failed, using fallback modes\n=
");
> +
> +	drm_bridge_exit(idx);
> +
> +	return drm_edid;
> +}

[Severity: Medium]
The commit message says "The EDID is kept while the monitor stays, since
reading it over USB takes about a second", but does
it66121_bridge_edid_read() actually cache the EDID?

struct it66121_priv has no field to store the EDID, and
drm_bridge_connector_get_modes_edid() frees the struct drm_edid returned by
drm_bridge_edid_read() on each call, so every get_modes() call reads the
EDID over USB again.

[ ... ]

> +static struct i2c_client *it66121_i2c_init(struct i2c_adapter *adapter)
> +{
> +	/*
> +	 * Not "it66121": that name would make the ite-it66121 driver, if built,
> +	 * try to bind this client and release our devres when its probe fails.
> +	 */
> +	struct i2c_board_info board_info =3D { I2C_BOARD_INFO("fl2000-it66121",=
 0) };
> +
> +	/* According to datasheet IT66121 addresses are 0x98 or 0x9A including =
cmd */
> +	const unsigned short it66121_addr[] =3D { (0x98 >> 1), (0x9A >> 1), I2C=
_CLIENT_END };
> +	struct i2c_client *client;
> +
> +	/* The chip may still be waking up when the USB device has just enumera=
ted */
> +	for (int i =3D 0; i < IT66121_DETECT_TRIES; i++) {
> +		if (i)
> +			msleep(IT66121_DETECT_DELAY_MS);
> +
> +		client =3D i2c_new_scanned_device(adapter, &board_info, it66121_addr,
> +						it66121_i2c_probe);
> +		if (!IS_ERR(client))
> +			break;
> +	}
> +
> +	return client;
> +}
[ ... ]
> +struct drm_bridge *it66121_create(struct i2c_adapter *adapter)
> +{
> +	int ret;
> +	struct it66121_priv *priv;
> +	struct i2c_client *client;
> +
> +	client =3D it66121_i2c_init(adapter);
> +	if (IS_ERR(client)) {
> +		dev_err(&adapter->dev, "No IT66121 found (%pe): adapters without one a=
re not supported\n",
> +			client);
> +		return ERR_CAST(client);
> +	}
> +
> +	/*
> +	 * DRM core takes references on the bridge, so it must be allocated with
> +	 * devm_drm_bridge_alloc(). Freeing happens automatically when the last
> +	 * reference is dropped after i2c_unregister_device().
> +	 */
> +	priv =3D devm_drm_bridge_alloc(&client->dev, struct it66121_priv, bridg=
e,
> +				     &it66121_bridge_funcs);

[Severity: Medium]
Why add a second driver for the ITE IT66121 instead of extending
drivers/gpu/drm/bridge/ite-it66121.c, and is it valid to attach devm
resources to an unbound i2c_client?

To keep the existing ite-it66121 driver from binding the client,
it66121_i2c_init() registers a dummy "fl2000-it66121" device with no driver
and attaches devm_drm_bridge_alloc(), devm_regmap_init_i2c() and
devm_regmap_field_alloc() to &client->dev outside of any driver probe.
The driver core treats devres entries on an unbound device as a bug in
really_probe() ("Resources present before probing").

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261111-fl2000-ups=
tream-v2-0-201f87708cb0@gmail.com?part=3D2
