Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87C24606EE80
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 13:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KAl0WPlB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5013112DB3;
	Fri,  6 Nov 2026 13:56:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 56B85112DAC
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 13:56:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 10EC14379F;
 Fri,  6 Nov 2026 13:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65B481F008A3;
 Fri,  6 Nov 2026 13:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793973382;
 bh=0tuVHt6IugmTLSqrR8kmpMpjcLPQlDkTodDmg4T/FfU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KAl0WPlBy7cje0tmYGjsxbd12WOsqAnJXQOTdvqYgYKjh0KE85IvzLMK8INqKOOwQ
 0yywHJM421i0ZuS/kzPrI9ecYNnsnuH+jYeFsEZS8HDhCCybITn7MNStoNR+2COG1j
 ZdocQhxqSXK+jeVy4b0614NE18Zuu/ukFs5gBdATrrrFREGzfN7bJAgr4/d8VSXnN8
 cE8NxhXU2xY/C5Y4o0j8gTat9VfcvQ4WweXmrWbANNVXQ5mqawWiFThhj13qBmtkjQ
 w/0ipwuyGh5/LXNSJWPHq4FYMxY/hMrGK1q51sqqhm5RXgzGKYXzYJQia6Tg78yk6O
 Y+leCF1sfCpow==
Date: Fri, 6 Nov 2026 14:56:19 +0100
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
Subject: Re: [PATCH v6 04/10] drm/tegra: dc: Refactor and expand header
Message-ID: <au3X8tpU9KWas9ZM@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-5-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="rc2hc4wbfwun3tgx"
Content-Disposition: inline
In-Reply-To: <20261105140510.165165-5-clamor95@gmail.com>
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


--rc2hc4wbfwun3tgx
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 04/10] drm/tegra: dc: Refactor and expand header
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:05:04PM +0200, Svyatoslav Ryhel wrote:
> Refactor and expand existing DC register definitions with additional
> fields in preparation for adding the 8-bit CPU interface.
>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c  |  11 +-
>  drivers/gpu/drm/tegra/dc.h  | 856 +++++++++++++++++++++---------------
>  drivers/gpu/drm/tegra/rgb.c |   8 +-
>  3 files changed, 514 insertions(+), 361 deletions(-)

This is impossible to review. Please split this up into refactor and
expand patches. Each should be a separate change.

Also, a lot of the "refactor" is just pointless whitespace changes that
are just not necessary. Please keep the changes to a minimum.

> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
[...]
> @@ -2384,7 +2384,8 @@ static void tegra_crtc_atomic_enable(struct drm_crt=
c *crtc,
> =20
>  	if (dc->rgb) {
>  		/* XXX: parameterize? */
> -		value =3D SC0_H_QUALIFIER_NONE | SC1_H_QUALIFIER_NONE;
> +		value =3D SC0_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
> +			SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE);

This type of change seems entirely useless to me. It's neither more
readable nor shorter.

[...]
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 0cb0515968b35..2b87bb675d4cf 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -178,9 +178,11 @@ int tegra_dc_rgb_init(struct drm_device *drm, struct=
 tegra_dc *dc);
>  int tegra_dc_rgb_exit(struct tegra_dc *dc);
> =20
>  #define DC_CMD_GENERAL_INCR_SYNCPT		0x000
> +
>  #define DC_CMD_GENERAL_INCR_SYNCPT_CNTRL	0x001
> -#define  SYNCPT_CNTRL_NO_STALL   (1 << 8)
> -#define  SYNCPT_CNTRL_SOFT_RESET (1 << 0)
> +#define  SYNCPT_CNTRL_NO_STALL			BIT(8)
> +#define  SYNCPT_CNTRL_SOFT_RESET		BIT(0)

The whitespace changes here are completely arbitrary, it's changing one
preference for another. You're actually changing the contents in this
case, so it's not that bad. Still unnecessary, though.

> -#define DISP_CTRL_MODE_STOP (0 << 5)
> -#define DISP_CTRL_MODE_C_DISPLAY (1 << 5)
> -#define DISP_CTRL_MODE_NC_DISPLAY (2 << 5)
> -#define DISP_CTRL_MODE_MASK (3 << 5)
> +#define  DISP_CTRL_MODE_STOP			(0 << 5)
> +#define  DISP_CTRL_MODE_C_DISPLAY		(1 << 5)
> +#define  DISP_CTRL_MODE_NC_DISPLAY		(2 << 5)
> +#define  DISP_CTRL_MODE_MASK			(3 << 5)

These are purely whitespace changes. Please don't do that.

>  #define DC_COM_CRC_CONTROL			0x300
> -#define  DC_COM_CRC_CONTROL_ALWAYS (1 << 3)
> -#define  DC_COM_CRC_CONTROL_FULL_FRAME  (0 << 2)
> -#define  DC_COM_CRC_CONTROL_ACTIVE_DATA (1 << 2)
> -#define  DC_COM_CRC_CONTROL_WAIT (1 << 1)
> -#define  DC_COM_CRC_CONTROL_ENABLE (1 << 0)
> +#define  DC_COM_CRC_CONTROL_ALWAYS		BIT(3)
> +#define  DC_COM_CRC_CONTROL_FULL_FRAME		(0 << 2)
> +#define  DC_COM_CRC_CONTROL_ACTIVE_DATA		BIT(2)
> +#define  DC_COM_CRC_CONTROL_WAIT		BIT(1)
> +#define  DC_COM_CRC_CONTROL_ENABLE		BIT(0)

FULL_FRAME and ACTIVE_DATA were previously consistent, now it just looks
weird. Either use proper GENMASK() definitions where applicable, along
with modifications in the driver to use FIELD_PREP() and FIELD_GET(), or
just don't change it at all.

> +
>  #define DC_COM_CRC_CHECKSUM			0x301
> -#define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
> -#define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
> -#define LVS_OUTPUT_POLARITY_LOW (1 << 28)
> -#define LHS_OUTPUT_POLARITY_LOW (1 << 30)
> -#define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
> -#define DC_COM_PIN_INPUT_ENABLE(x) (0x30e + (x))
> -#define DC_COM_PIN_INPUT_DATA(x) (0x312 + (x))
> -#define DC_COM_PIN_OUTPUT_SELECT(x) (0x314 + (x))
> +
> +/* Defines in PIN_OUTPUT/INPUT_* describe pin position, not state */

This comment is completely confusing to me. The registers themselves
define the state and bit positions within them seem to indicate the pin
positions.

> +#define DC_COM_PIN_OUTPUT_ENABLE(x)		(0x302 + (x))
> +#define DC_COM_PIN_OUTPUT_POLARITY(x)		(0x306 + (x))
> +#define DC_COM_PIN_OUTPUT_DATA(x)		(0x30a + (x))
> +#define  PIN_UNMASK(x)				BIT((x) + 1)

Given that pin positions are in steps of two for all registers, does
that PIN_UNMASK apply to all of them or just PIN_OUTPUT_DATA?

> +#define DC_COM_PIN_INPUT_ENABLE(x)		(0x30e + (x))
> +
[...]
> +/* DC_COM_PIN_OUTPUT/INPUT_*_3 */
> +#define PIN_LSCK				0
> +#define PIN_LSDA				2
> +#define PIN_LCSN				4
> +#define PIN_LDC					6
> +#define PIN_LSPI				8
> +#define PIN_LSDI				10
> +
> +#define DC_COM_PIN_INPUT_DATA(x)		(0x312 + (x))

It's not clear that PIN_INPUT_DATA_* can take any of those PIN_*
defines. Given that there are only two PIN_INPUT_DATA registers that's
probably not true, so I think it'd be good to somehow specify how that
works here.

> +#define DC_COM_PIN_OUTPUT_SELECT(x)		(0x314 + (x))
> +#define  PIN_OUTPUT_SELECT_MASK(x)		(0x7 << (x))
> +#define  PIN_OUTPUT_SELECT_PRIM(x)		(0 << (x))
> +#define  PIN_OUTPUT_SELECT_OUT(x)		(1 << (x))
> +#define  PIN_OUTPUT_SELECT_F2(x)		(2 << (x))
> +#define  PIN_OUTPUT_SELECT_F3(x)		(3 << (x))
> +#define  PIN_OUTPUT_SELECT_F4(x)		(4 << (x))
> +#define  PIN_OUTPUT_SELECT_F5(x)		(5 << (x))
> +#define  PIN_OUTPUT_SELECT_F6(x)		(6 << (x))
> +#define  PIN_OUTPUT_SELECT_F7(x)		(7 << (x))
> +
> +/* DC_COM_PIN_OUTPUT_SELECT0 */
> +#define PIN_OUTPUT_SELECT_LD0			0
> +#define PIN_OUTPUT_SELECT_LD1			4
> +#define PIN_OUTPUT_SELECT_LD2			8
> +#define PIN_OUTPUT_SELECT_LD3			12
> +#define PIN_OUTPUT_SELECT_LD4			16
> +#define PIN_OUTPUT_SELECT_LD5			20
> +#define PIN_OUTPUT_SELECT_LD6			24
> +#define PIN_OUTPUT_SELECT_LD7			28
> +
> +/* DC_COM_PIN_OUTPUT_SELECT1 */
> +#define PIN_OUTPUT_SELECT_LD8			0
> +#define PIN_OUTPUT_SELECT_LD9			4
> +#define PIN_OUTPUT_SELECT_LD10			8
> +#define PIN_OUTPUT_SELECT_LD11			12
> +#define PIN_OUTPUT_SELECT_LD12			16
> +#define PIN_OUTPUT_SELECT_LD13			20
> +#define PIN_OUTPUT_SELECT_LD14			24
> +#define PIN_OUTPUT_SELECT_LD15			28
> +
> +/* DC_COM_PIN_OUTPUT_SELECT2 */
> +#define PIN_OUTPUT_SELECT_LD16			0
> +#define PIN_OUTPUT_SELECT_LD17			4
> +
> +/* DC_COM_PIN_OUTPUT_SELECT3 */
> +#define PIN_OUTPUT_SELECT_LPW0			0
> +#define PIN_OUTPUT_SELECT_LPW1			4
> +#define PIN_OUTPUT_SELECT_LPW2			8
> +#define PIN_OUTPUT_SELECT_LSC0			16
> +#define PIN_OUTPUT_SELECT_LSC1			20
> +#define PIN_OUTPUT_SELECT_LVS			24
> +#define PIN_OUTPUT_SELECT_LHS			28
> +
> +/* DC_COM_PIN_OUTPUT_SELECT4 */
> +#define PIN_OUTPUT_SELECT_LHP0			0
> +#define PIN_OUTPUT_SELECT_LHP1			4
> +#define PIN_OUTPUT_SELECT_LHP2			8
> +#define PIN_OUTPUT_SELECT_LVP0			16
> +#define PIN_OUTPUT_SELECT_LVP1			20
> +
> +/* DC_COM_PIN_OUTPUT_SELECT5 */
> +#define PIN_OUTPUT_SELECT_LM0			0
> +#define PIN_OUTPUT_SELECT_LM1			4
> +#define PIN_OUTPUT_SELECT_LDI			8
> +#define PIN_OUTPUT_SELECT_LPP			12
> +
> +/* DC_COM_PIN_OUTPUT_SELECT6 */
> +#define PIN_OUTPUT_SELECT_LSCK			0
> +#define PIN_OUTPUT_SELECT_LSDA			4
> +#define PIN_OUTPUT_SELECT_LCSN			8
> +#define PIN_OUTPUT_SELECT_LDC			12
> +#define PIN_OUTPUT_SELECT_LSPI			16
> +#define PIN_OUTPUT_SELECT_LSDI			20
> =20
>  #define DC_COM_PIN_MISC_CONTROL			0x31b

If there's only one PIN_MISC_CONTROL register, does that take these same
PIN_* values as bit indices?

Thierry

--rc2hc4wbfwun3tgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt3H8ACgkQ3SOs138+
s6Eawg//fb7MsJNQ3AzGo0VwehFF5urNwd+gNHtrrFdGXhYJuGdWiYytyrZ5W6qX
GMLLJmAdrv+iez6rDoG6vAbxYDB8gRqx7miJ4aUW/JNAwk8ym5z/EXx25LH09vcm
9UKu3rmSuY0UIw02b+dsMUYYIPNspLRmUzBp9XIOqaUWH5gTKTLVbdiaU+UHGOux
w+xkrNwan+GiEYAats9zFPrElJUBDp4hYPCPsdQd++XKb4n0wQtYnEQl8hkB5NgA
8FrPLufBvP5k2xQ/wxk8DJ+3hcSPj5V6Sx3WVoTGpL6S5pHGTwiR1KZQAvD51jzp
TX5C96MiPqqDVOE0NIgn3p8mtpL9zFxHfGZVGDT6fyxbPAo829DJKS8PgyOeeu7n
sV1432QC3/Hz/GwzKQKdcVfvZ0PQ62C8tw6tHBhEnNVqAjhw5SniTer6ptAgNBqo
jVxiTinPOY7rCMYmYgfInL7eccaUv5F1cMcfrbXyWhpkJia5kLvXjvQKnjaCdx2g
bkwJlZdYV8zeP4GjhOtL2F0h00EpSPBOIi4oFLgJU57Mlz+cqHx9KIE3gduXc4oK
oMnbVnI65ej9s4BwLmzsSf5IRqFC3g1sFUAC1ZZIQYGxUKMEFMt0e9WkIN81VA01
gRv+vUpafvirRbhUJ+oFFaK9JwwU1CjiGXs5CT8JkwKJUj5uq0c=
=ogZo
-----END PGP SIGNATURE-----

--rc2hc4wbfwun3tgx--
