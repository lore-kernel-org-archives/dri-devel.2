Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1551606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 02:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQCr/pq2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2981110F997;
	Wed, 25 Nov 2026 02:20:04 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF0710F997
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 02:19:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8DE6F60A58;
 Wed, 25 Nov 2026 02:19:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFE951F000D0;
 Wed, 25 Nov 2026 02:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795573196;
 bh=l0ij/yOic9hDectS0fu622TyPXxKt6SK3y1cg6SvSho=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BQCr/pq2ipMvA/6rlUZBcJXC3HM58Rk9EoXrPLWj7cRyt0ppzRx3qBfX57L2vkbrV
 Yu3jH6/WxvaSlYWA2Vl48709kChivtUWaZUQO16CrBU57ciSJN4/0o431X2bVP8bEP
 Rnq1NtkbwXVyG/fKQ/J/2qQ7wE/5xDX3+1HW1hZ1Gzxv/BLazJQupbk3Ria9KxjmSs
 ual1T5/8sYYi8aP5S/XiONWm3k9uutIN8/q8/MFgti46T7RU4znKKOnygMneJaTOTS
 du1H1AxG3pAcxl/cFYAhoum2mqn5RFYDLJZKpQkMig7hPRDor6apxiDhUf0sYIA6T3
 rAMDDX5Hpr7hQ==
Message-ID: <sashiko-outbox-232402@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/6] backlight: add VIEWE I2C backlight driver
To: Hefei <3066883572@qq.com>, dri-devel@lists.freedesktop.org
Cc: linux-input@vger.kernel.org, devicetree@vger.kernel.org, robh@kernel.org,
 conor+dt@kernel.org, dmitry.torokhov@gmail.com
In-Reply-To: <tencent_42CFAF0E2AFDF8C8C784D5DCB700E1E65306@qq.com>
References: <20261125020944.137-1-3066883572@qq.com>
 <tencent_42CFAF0E2AFDF8C8C784D5DCB700E1E65306@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 25 Nov 2026 02:19:55 +0000
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [Medium] backlight: viewe_bl_i2c: missing DT brightness parsing in
  viewe_bl_probe()
- [Medium] backlight: viewe_bl_i2c: missing backlight_update_status() in
  viewe_bl_probe()
- [Low] backlight: viewe_bl_i2c: positional initializer in struct
  i2c_device_id table
- [Low] backlight: viewe_bl_i2c: open-coded register write in
  viewe_bl_update_status()
- [Low] backlight: viewe_bl_i2c: dead clientdata and missing
  suspend/unbind blanking
- [Low] backlight: viewe_bl_i2c: empty commit message body and
  non-standard trailer
--

commit c7c0be93ab188af721db0878f1959009280ef433
Author: Hefei <3066883572@qq.com>

> backlight: add VIEWE I2C backlight driver
>
> Signed-off-by: Hefei <3066883572@qq.com>
> Co-authored-by: Cursor <cursoragent@cursor.com>

[Severity: Low]
Could a commit message body be added to describe the hardware and rationale
for the driver?  Also, Co-authored-by: is not a standard kernel trailer and=
 is
placed after Signed-off-by:.

> diff --git a/drivers/video/backlight/viewe_bl_i2c.c b/drivers/video/backl=
ight/viewe_bl_i2c.c
> new file mode 100644
> index 0000000000000..53dcf0834dcb2
> --- /dev/null
> +++ b/drivers/video/backlight/viewe_bl_i2c.c
> @@ -0,0 +1,79 @@
[ ... ]
> +static int viewe_bl_update_status(struct backlight_device *bd)
> +{
> +	struct i2c_client *client =3D bl_get_data(bd);
> +	u8 buf[2] =3D { VIEWE_BL_REG, (u8)backlight_get_brightness(bd) };
> +	struct i2c_msg msg =3D {
> +		.addr =3D client->addr,
> +		.flags =3D 0,
> +		.len =3D sizeof(buf),
> +		.buf =3D buf,
> +	};
> +	int ret;
> +
> +	ret =3D i2c_transfer(client->adapter, &msg, 1);
> +	return ret =3D=3D 1 ? 0 : (ret < 0 ? ret : -EIO);
> +}

[Severity: Low]
Could viewe_bl_update_status() use i2c_smbus_write_byte_data(client,
VIEWE_BL_REG, backlight_get_brightness(bd)) instead of open-coding
i2c_transfer()?  Manually building struct i2c_msg drops client->flags and
prevents the driver from working on SMBus-only adapters.

> +
> +static const struct backlight_ops viewe_bl_ops =3D {
> +	.update_status =3D viewe_bl_update_status,
> +};
> +
> +static int viewe_bl_probe(struct i2c_client *client)
> +{
> +	struct backlight_properties props =3D {
> +		.type =3D BACKLIGHT_RAW,
> +		.brightness =3D VIEWE_BL_DEFAULT,
> +		.max_brightness =3D VIEWE_BL_MAX,
> +	};

[Severity: Medium]
Should viewe_bl_probe() parse default-brightness and max-brightness from
client->dev instead of hardcoding VIEWE_BL_DEFAULT and VIEWE_BL_MAX?

The companion DT binding in
Documentation/devicetree/bindings/leds/backlight/viewe,i2c-backlight.yaml
references common.yaml# and uses default-brightness in its example, but
devm_backlight_device_register() does not read firmware properties itself, =
so
any DT-configured brightness limits or defaults are ignored.

> +	struct backlight_device *bd;
> +
> +	bd =3D devm_backlight_device_register(&client->dev, "viewe_bl",
> +					   &client->dev, client, &viewe_bl_ops,
> +					   &props);
> +	if (IS_ERR(bd))
> +		return PTR_ERR(bd);
> +
> +	i2c_set_clientdata(client, bd);

[Severity: Low]
i2c_set_clientdata() stores bd, but nothing in the driver ever calls
i2c_get_clientdata(), and neither BL_CORE_SUSPENDRESUME in viewe_bl_ops nor=
 a
.remove callback is set, leaving the backlight illuminated across system
suspend (when used standalone) or driver unbind.

> +	return 0;
> +}

[Severity: Medium]
Should viewe_bl_probe() call backlight_update_status(bd) before returning?

devm_backlight_device_register() copies props into bd->props without invoki=
ng
ops->update_status(), so register 0x86 is never programmed with the initial
brightness at probe time, sysfs brightness and bl_power state start out of
sync with the hardware, and probe succeeds even if no device responds at
client->addr.

> +
> +static const struct of_device_id viewe_bl_of_match[] =3D {
> +	{ .compatible =3D "viewe,7kf82-backlight" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, viewe_bl_of_match);
> +
> +static const struct i2c_device_id viewe_bl_id[] =3D {
> +	{ "viewe_bl", 0 },
> +	{ }
> +};

[Severity: Low]
New struct i2c_device_id entries should use named initializers (for example,
{ .name =3D "7kf82-backlight" }, matching the DT compatible suffix).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_EE81D0ED29E=
97716D56BDCF1A3C5AAE35B05@qq.com?part=3D6
