Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16BE4C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:51:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 816CF10E7D6;
	Mon, 20 Jul 2026 07:51:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="SD9h6Asn";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACF5410E7C4
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 07:50:59 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 045F04E40E7D;
 Mon, 20 Jul 2026 07:50:58 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id CB91460360;
 Mon, 20 Jul 2026 07:50:57 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF47E11BD1242; 
 Mon, 20 Jul 2026 09:50:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1784533856; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 in-reply-to:references; bh=ydvv0GJEFh8kqpKPQ9tLSbZDdHAlONu2QYbeL0hro3c=;
 b=SD9h6AsnI3dv3EtNGQ8+98dzTFvdrMTsJgGUKjd+0gz66ahYx6WOP5GOpb21amTo6fi9jH
 CtZ8W0J8QNdT5z6mn/876KhcSf6rRhbHrs0zqe54IwzBJ3NFjVTsn4hBmqgCTXpzYqIEc0
 m107NOxsQ52/3Jp2Yl+kUbk8QueVoAdLB/1WpszTqZjAqA+q2gWHdsyIuQ4i52OfsdKJ+R
 jhzyzszXJfIzMM+J8IddoNSdxXS54XQhFOPJUGEgv5tJoBYlBQJqE+DzTq/TexDg1fMoAx
 KrdhVlRrZKwfeu7oSusjIY8jTOmQVc+t+IWJ87yDPhM+QXv+u8eoK8VzBxBfww==
From: Romain Gantois <romain.gantois@bootlin.com>
To: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZyAoVGhlIENhcGFibGUgSHViKQ==?=
 <u.kleine-koenig@baylibre.com>
Cc: Srinivas Kandagatla <srini@kernel.org>,
 Ekansh Gupta <ekansh.gupta@oss.qualcomm.com>,
 John Stultz <jstultz@google.com>, Eric Piel <eric.piel@tremplin-utc.net>,
 Danilo Krummrich <dakr@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
 Takashi Sakamoto <o-takashi@sakamocchi.jp>, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 11/12] misc: Unify style of of_device_id arrays
Date: Mon, 20 Jul 2026 09:50:48 +0200
Message-ID: <Nl9yKsP2RmuG2RLCMfrvew@bootlin.com>
In-Reply-To: <fbf51b8f413c516977e2c8a81896221795df77e4.1784299069.git.u.kleine-koenig@baylibre.com>
References: <cover.1784299069.git.u.kleine-koenig@baylibre.com>
 <fbf51b8f413c516977e2c8a81896221795df77e4.1784299069.git.u.kleine-koenig@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPartDe8xp2AFRBWqMINRDKbRPw";
 micalg="pgp-sha512"; protocol="application/pgp-signature"
X-Last-TLS-Session-Version: TLSv1.3
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

--nextPartDe8xp2AFRBWqMINRDKbRPw
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"; protected-headers="v1"
From: Romain Gantois <romain.gantois@bootlin.com>
Subject: Re: [PATCH v2 11/12] misc: Unify style of of_device_id arrays
Date: Mon, 20 Jul 2026 09:50:48 +0200
Message-ID: <Nl9yKsP2RmuG2RLCMfrvew@bootlin.com>
MIME-Version: 1.0

Hi Uwe,

On Friday, 17 July 2026 16:50:57 CEST Uwe Kleine-K=C3=B6nig (The Capable Hu=
b) wrote:
> Update the various of_device_id arrays to conform to the most used and
>=20
> generally recommended coding style. That is:
>  - No comma after the list terminator;
>  - A comma after an initializer if (and only if) the closing } is not
> =20
>    directly following;
> =20
>  - No explicit zeros in the list terminator;
>  - A space after an opening { and before a closing }, a single space in
> =20
>    the list terminator;
>=20
> Adapt the few offenders accordingly.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig (The Capable Hub)
> <u.kleine-koenig@baylibre.com> ---
>=20
>  drivers/misc/ds1682.c                  | 4 ++--
>  drivers/misc/fastrpc.c                 | 6 +++---
>  drivers/misc/hisi_hikey_usb.c          | 2 +-
>  drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 2 +-
>  drivers/misc/lis3lv02d/lis3lv02d_spi.c | 2 +-
>  drivers/misc/open-dice.c               | 2 +-
>  drivers/misc/pvpanic/pvpanic-mmio.c    | 4 ++--
>  drivers/misc/qcom-coincell.c           | 4 ++--
>  drivers/misc/sram.c                    | 2 +-
>  drivers/misc/ti_fpc202.c               | 2 +-
>  drivers/misc/vcpu_stall_detector.c     | 4 ++--
>  11 files changed, 17 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/misc/ds1682.c b/drivers/misc/ds1682.c
> index f073a5067fc8..4500d7d0ea77 100644
> --- a/drivers/misc/ds1682.c
> +++ b/drivers/misc/ds1682.c
> @@ -277,8 +277,8 @@ static const struct i2c_device_id ds1682_id[] =3D {
>=20
>  MODULE_DEVICE_TABLE(i2c, ds1682_id);
> =20
>  static const struct of_device_id ds1682_of_match[] =3D {
>=20
> -	{ .compatible =3D "dallas,ds1682", },
> -	{}
> +	{ .compatible =3D "dallas,ds1682" },
> +	{ }
>=20
>  };
>  MODULE_DEVICE_TABLE(of, ds1682_of_match);
>=20
> diff --git a/drivers/misc/fastrpc.c b/drivers/misc/fastrpc.c
> index d86e79134c68..f7b6aba8b71d 100644
> --- a/drivers/misc/fastrpc.c
> +++ b/drivers/misc/fastrpc.c
> @@ -2299,8 +2299,8 @@ static void fastrpc_cb_remove(struct platform_device
> *pdev) }
>=20
>  static const struct of_device_id fastrpc_match_table[] =3D {
>=20
> -	{ .compatible =3D "qcom,fastrpc-compute-cb", },
> -	{}
> +	{ .compatible =3D "qcom,fastrpc-compute-cb" },
> +	{ }
>=20
>  };
> =20
>  static struct platform_driver fastrpc_cb_driver =3D {
>=20
> @@ -2579,7 +2579,7 @@ static int fastrpc_rpmsg_callback(struct rpmsg_devi=
ce
> *rpdev, void *data, static const struct of_device_id
> fastrpc_rpmsg_of_match[] =3D {
>=20
>  	{ .compatible =3D "qcom,kaanapali-fastrpc", .data =3D &kaanapali_soc_da=
ta },
>  	{ .compatible =3D "qcom,fastrpc", .data =3D &default_soc_data },
>=20
> -	{ },
> +	{ }
>=20
>  };
>  MODULE_DEVICE_TABLE(of, fastrpc_rpmsg_of_match);
>=20
> diff --git a/drivers/misc/hisi_hikey_usb.c b/drivers/misc/hisi_hikey_usb.c
> index 79f06001259b..e68bc6e384d5 100644
> --- a/drivers/misc/hisi_hikey_usb.c
> +++ b/drivers/misc/hisi_hikey_usb.c
> @@ -254,7 +254,7 @@ static void hisi_hikey_usb_remove(struct platform_dev=
ice
> *pdev)
>=20
>  static const struct of_device_id id_table_hisi_hikey_usb[] =3D {
> =20
>  	{ .compatible =3D "hisilicon,usbhub" },
>=20
> -	{}
> +	{ }
>=20
>  };
>  MODULE_DEVICE_TABLE(of, id_table_hisi_hikey_usb);
>=20
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c index 36032fc125f3..7c3ca6d604d1
> 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
> @@ -95,7 +95,7 @@ static union axis_conversion lis3lv02d_axis_map =3D
>=20
>  #ifdef CONFIG_OF
>  static const struct of_device_id lis3lv02d_i2c_dt_ids[] =3D {
> =20
>  	{ .compatible =3D "st,lis3lv02d" },
>=20
> -	{}
> +	{ }
>=20
>  };
>  MODULE_DEVICE_TABLE(of, lis3lv02d_i2c_dt_ids);
>  #endif
>=20
> diff --git a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> b/drivers/misc/lis3lv02d/lis3lv02d_spi.c index 203a108b8883..5bf95176a00e
> 100644
> --- a/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> +++ b/drivers/misc/lis3lv02d/lis3lv02d_spi.c
> @@ -60,7 +60,7 @@ static union axis_conversion lis3lv02d_axis_normal =3D
>=20
>  #ifdef CONFIG_OF
>  static const struct of_device_id lis302dl_spi_dt_ids[] =3D {
> =20
>  	{ .compatible =3D "st,lis302dl-spi" },
>=20
> -	{}
> +	{ }
>=20
>  };
>  MODULE_DEVICE_TABLE(of, lis302dl_spi_dt_ids);
>  #endif
>=20
> diff --git a/drivers/misc/open-dice.c b/drivers/misc/open-dice.c
> index 45060fb4ea27..77ab0c1e83d3 100644
> --- a/drivers/misc/open-dice.c
> +++ b/drivers/misc/open-dice.c
> @@ -177,7 +177,7 @@ static void open_dice_remove(struct platform_device
> *pdev)
>=20
>  static const struct of_device_id open_dice_of_match[] =3D {
> =20
>  	{ .compatible =3D "google,open-dice" },
>=20
> -	{},
> +	{ }
>=20
>  };
> =20
>  static struct platform_driver open_dice_driver =3D {
>=20
> diff --git a/drivers/misc/pvpanic/pvpanic-mmio.c
> b/drivers/misc/pvpanic/pvpanic-mmio.c index 43a094bfdaec..724dfddf69e4
> 100644
> --- a/drivers/misc/pvpanic/pvpanic-mmio.c
> +++ b/drivers/misc/pvpanic/pvpanic-mmio.c
> @@ -51,8 +51,8 @@ static int pvpanic_mmio_probe(struct platform_device
> *pdev) }
>=20
>  static const struct of_device_id pvpanic_mmio_match[] =3D {
>=20
> -	{ .compatible =3D "qemu,pvpanic-mmio", },
> -	{}
> +	{ .compatible =3D "qemu,pvpanic-mmio" },
> +	{ }
>=20
>  };
>  MODULE_DEVICE_TABLE(of, pvpanic_mmio_match);
>=20
> diff --git a/drivers/misc/qcom-coincell.c b/drivers/misc/qcom-coincell.c
> index 3c57f7429147..b58bd34fc471 100644
> --- a/drivers/misc/qcom-coincell.c
> +++ b/drivers/misc/qcom-coincell.c
> @@ -124,8 +124,8 @@ static int qcom_coincell_probe(struct platform_device
> *pdev) }
>=20
>  static const struct of_device_id qcom_coincell_match_table[] =3D {
>=20
> -	{ .compatible =3D "qcom,pm8941-coincell", },
> -	{}
> +	{ .compatible =3D "qcom,pm8941-coincell" },
> +	{ }
>=20
>  };
> =20
>  MODULE_DEVICE_TABLE(of, qcom_coincell_match_table);
>=20
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index 1919d24c8236..c8990e83a65a 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -370,7 +370,7 @@ static const struct of_device_id sram_dt_ids[] =3D {
>=20
>  	{ .compatible =3D "nvidia,tegra186-sysram", .data =3D &tegra_sysram_con=
fig },
>  	{ .compatible =3D "nvidia,tegra194-sysram", .data =3D &tegra_sysram_con=
fig },
>  	{ .compatible =3D "nvidia,tegra234-sysram", .data =3D &tegra_sysram_con=
fig },
>=20
> -	{}
> +	{ }
>=20
>  };
> =20
>  static int sram_probe(struct platform_device *pdev)
>=20
> diff --git a/drivers/misc/ti_fpc202.c b/drivers/misc/ti_fpc202.c
> index 2aac83ec4a39..9e2d24f89457 100644
> --- a/drivers/misc/ti_fpc202.c
> +++ b/drivers/misc/ti_fpc202.c
> @@ -718,7 +718,7 @@ static void fpc202_remove(struct i2c_client *client)
>=20
>  static const struct of_device_id fpc202_of_match[] =3D {
> =20
>  	{ .compatible =3D "ti,fpc202" },
>=20
> -	{}
> +	{ }
>=20
>  };
>  MODULE_DEVICE_TABLE(of, fpc202_of_match);
>=20
> diff --git a/drivers/misc/vcpu_stall_detector.c
> b/drivers/misc/vcpu_stall_detector.c index 26166357b255..1306b2c1ef99
> 100644
> --- a/drivers/misc/vcpu_stall_detector.c
> +++ b/drivers/misc/vcpu_stall_detector.c
> @@ -224,8 +224,8 @@ static void vcpu_stall_detect_remove(struct
> platform_device *pdev) }
>=20
>  static const struct of_device_id vcpu_stall_detect_of_match[] =3D {
>=20
> -	{ .compatible =3D "qemu,vcpu-stall-detector", },
> -	{}
> +	{ .compatible =3D "qemu,vcpu-stall-detector" },
> +	{ }
>=20
>  };
> =20
>  MODULE_DEVICE_TABLE(of, vcpu_stall_detect_of_match);

Reviewed-by: Romain Gantois <romain.gantois@bootlin.com>

--nextPartDe8xp2AFRBWqMINRDKbRPw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEIcCsAScRrtr7W0x0KCYAIARzeA4FAmpd01gACgkQKCYAIARz
eA7sXRAAmNpC3oo5PQNgDztLrDx76qRbhKQuVjiPS2kwHQN9pstvtAOZ+CzM3ixi
58dEMGMGRieZ7iFO1mSDHxXlrSR82mB/vN0VzSGsTFtPufb0n6mbNYCdg6EMGCcH
Z6W6VMIlXjgvQ+ifEwqYsZiYZMYfvGuv63nyiWfKLtOou7kwalXxGjlRW85fCV0b
tQ6fCdtTtSBhdWTIrxQ38PWRZwxACnL1CqbyWbGvvCTEYVDBov8NDlNas1m2z0lN
R8sPoj4W2EfTsNoEeN2KT6o2c9QUxK9BhTIBAtP3FH5/YyA5wgg3j4+2IgBLIxGY
Skj6daWpVNCtE7BS1iQY9kZS+uDPxBjAV98Skhil0Dim2Q4xd9ulqZa6yGXbb0Sx
yfbDsMoL4wDe5lEN5h32DVIvNevGAwMvaCwiDuLFGYTy8DTdWf9pHFsavznJBt6q
liIJKxst6X1ToedGMIBQu2QGai6DdPqDKEMwUx03npALDDPJv59ZxJE+0/Sa2K0X
vZjLLmfQgYXsMOyQ2NVeACbUQ/nW4+mCSefDdP+Ihy0AJ7iWDcuBULyE3IthaX5G
2rYtyhdYSzCu+XSxxUac+5c+dXjBADp3PZzMvKxUAHq88k84VCYzPZzwtrVP5l8I
U0fmRfro8X86bSKY3zOJHACrwzcEUo0ptk3h1yrLhFBFtN9e3/0=
=jqEB
-----END PGP SIGNATURE-----

--nextPartDe8xp2AFRBWqMINRDKbRPw--



