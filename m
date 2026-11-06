Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3692606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 14:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TqzkEA0V
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10D6610E409;
	Fri,  6 Nov 2026 14:38:48 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A61110E409
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 14:38:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7B6BF602D4;
 Fri,  6 Nov 2026 14:38:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A40C71F0089F;
 Fri,  6 Nov 2026 14:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793975920;
 bh=nYqkxv6TcTaA/kjBkYOTDNrRK7O6kHO8JqG0CWPQfYc=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=TqzkEA0Vv6FiA/EyNHSGPazSRIxmze7NsRy2HS9UFnZLYngP5FU/k984j22IxxLSt
 G1mXSy3pJUZtcOX0uuCh0BGPfEtKxeqPMH7iMDq1BsZtJcBmY1BE0UVjD6CfBra6HG
 Ag+Be9z8npxA1OZxTFuN75Ezvh/jqeYPCyuiSOmri16kQEwfLaLejNUSC+x6slW0KF
 d5QZgMnG4JaXAkKum09Kqzk3Tq66QmT3NfSoU+yNr6XdAc6ce+jld5vFKHTk6MlHvd
 wjTgR+FYIcW4Gqo/TsLmp3ku1M5OmutAW9+ET0CKcI3MjvK/5ieNg8L0Aw5+JWl32a
 tAC9Z8tsKdIng==
Date: Fri, 6 Nov 2026 15:38:37 +0100
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
Subject: Re: [PATCH v6 10/10] drm/tegra: Add support for 8-bit CPU interface
Message-ID: <au3fy-xiCqgSTB49@orome>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <20261105140510.165165-11-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="bfslmjupan46ngr7"
Content-Disposition: inline
In-Reply-To: <20261105140510.165165-11-clamor95@gmail.com>
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


--bfslmjupan46ngr7
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v6 10/10] drm/tegra: Add support for 8-bit CPU interface
MIME-Version: 1.0

On Thu, Nov 05, 2026 at 04:05:10PM +0200, Svyatoslav Ryhel wrote:
> The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
> that closely resembles the MIPI DBI Type B protocol and is referred to as
> '8-bit CPU'. Each display controller provides two such interfaces, which
> can be used to send MIPI DCS commands to initialize and control the panel
> while image data is transmitted via 16/18/24-line RGB.
>=20
> The '8-bit CPU', although being the DC interface, is modeled using a
> bridge framework for flexibility and convenience. This implementation does
> not change the existing codebase besides registering the bus.
>=20
> Suggested-by: Mikko Perttunen <mperttunen@nvidia.com> # DC command transf=
er
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/Kconfig  |   1 +
>  drivers/gpu/drm/tegra/Makefile |   1 +
>  drivers/gpu/drm/tegra/dbi.c    | 576 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tegra/dc.c     |   4 +
>  drivers/gpu/drm/tegra/dc.h     |   3 +
>  5 files changed, 585 insertions(+)
>  create mode 100644 drivers/gpu/drm/tegra/dbi.c
>=20
> diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
> index 8a3b16aac5d68..6f57fd3985edc 100644
> --- a/drivers/gpu/drm/tegra/Kconfig
> +++ b/drivers/gpu/drm/tegra/Kconfig
> @@ -12,6 +12,7 @@ config DRM_TEGRA
>  	select DRM_BRIDGE_CONNECTOR
>  	select DRM_DISPLAY_DP_AUX_BUS
>  	select DRM_KMS_HELPER
> +	select DRM_MIPI_DBI
>  	select DRM_MIPI_DSI
>  	select DRM_PANEL
>  	select FB_DMAMEM_HELPERS if DRM_FBDEV_EMULATION
> diff --git a/drivers/gpu/drm/tegra/Makefile b/drivers/gpu/drm/tegra/Makef=
ile
> index e399b40d64a1d..ae7fccb3d6421 100644
> --- a/drivers/gpu/drm/tegra/Makefile
> +++ b/drivers/gpu/drm/tegra/Makefile
> @@ -18,6 +18,7 @@ tegra-drm-y :=3D \
>  	hdmi.o \
>  	mipi-phy.o \
>  	dsi.o \
> +	dbi.o \
>  	sor.o \
>  	dpaux.o \
>  	gr2d.o \
> diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> new file mode 100644
> index 0000000000000..32d390f64ddbd
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/dbi.c
> @@ -0,0 +1,576 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nvidia Tegra20/30 MIPI-DBI Type B host driver
> + *
> + * Copyright (C) 2026 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_mipi_dbi_bus.h>
> +#include <drm/drm_of.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include "dc.h"
> +
> +enum tegra_dbi_dc_signal {
> +	TEGRA_DBI_COMMAND,
> +	TEGRA_DBI_DATA
> +};

These look like register offsets for sending DBI commands, so maybe just
use defines for them?

> +
> +enum tegra_dbi_iface {
> +	TEGRA_DBI_INTERFACE_PRIMARY,
> +	TEGRA_DBI_INTERFACE_SECONDARY,
> +	TEGRA_DBI_INTERFACE_MAX
> +};

The only place where this seems to be used is in the definition of the
two interfaces. But in those cases PRIMARY and SECONDARY match the index
into the array and MAX is the size of the array, which can be determined
dynamically. Drop this.

> +
> +#define TEGRA_DBI_DATA_PINS_MAX			8
> +#define TEGRA_DBI_DEFAULT_BUS_WIDTH		24
> +
> +struct reg_entry {
> +	u32 offset;
> +	u32 value;
> +};
> +
> +static const u32 tegra_dbi_pin_regs[] =3D {
> +	DC_COM_PIN_OUTPUT_ENABLE(0),
> +	DC_COM_PIN_OUTPUT_ENABLE(1),
> +	DC_COM_PIN_OUTPUT_ENABLE(2),
> +	DC_COM_PIN_OUTPUT_ENABLE(3),
> +	DC_COM_PIN_OUTPUT_POLARITY(0),
> +	DC_COM_PIN_OUTPUT_POLARITY(1),
> +	DC_COM_PIN_OUTPUT_POLARITY(2),
> +	DC_COM_PIN_OUTPUT_POLARITY(3),
> +	DC_COM_PIN_OUTPUT_DATA(0),
> +	DC_COM_PIN_OUTPUT_DATA(1),
> +	DC_COM_PIN_OUTPUT_DATA(2),
> +	DC_COM_PIN_OUTPUT_DATA(3),
> +	DC_COM_PIN_OUTPUT_SELECT(0),
> +	DC_COM_PIN_OUTPUT_SELECT(1),
> +	DC_COM_PIN_OUTPUT_SELECT(2),
> +	DC_COM_PIN_OUTPUT_SELECT(3),
> +	DC_COM_PIN_OUTPUT_SELECT(4),
> +	DC_COM_PIN_OUTPUT_SELECT(5),
> +	DC_COM_PIN_OUTPUT_SELECT(6),
> +};
> +
> +struct tegra_dbi_priv {
> +	struct device *dev;
> +	struct tegra_dc *dc;
> +
> +	struct mipi_dbi dbi;
> +	struct mipi_dbi_host dbi_host;
> +
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next_bridge;
> +
> +	const struct tegra_dbi_interface *interface;
> +	struct reg_entry com_pin_backup[ARRAY_SIZE(tegra_dbi_pin_regs)];

You can just make this a u32 array since you're always iterating over
that tegra_dbi_pin_regs array anyway and can get the offset from there.
No need to duplicate that data into another set of variables.

[...]
> +static void tegra_dbi_pin_set(struct tegra_dc *dc, const struct tegra_db=
i_pin *pin, bool value)
> +{
> +	u32 val =3D BIT(pin->pos + 1); /* unmask is 1 bit above position */
> +
> +	if (value)
> +		val |=3D BIT(pin->pos);
> +
> +	tegra_dc_writel(dc, val, pin->reg);
> +}

So the PIN_UNMASK exists for all registers. In that case, the definition
should probably not be intermixed like it was in that header "refactor
and expand" patch.

> +
> +static void tegra_dbi_write(struct tegra_dbi_priv *priv,
> +			    enum tegra_dbi_dc_signal signal, u8 value)
> +{
> +	struct tegra_dc *dc =3D priv->dc;
> +	const struct tegra_dbi_interface *interface =3D priv->interface;
> +
> +	tegra_dbi_pin_set(dc, &interface->dc, signal);
> +
> +	tegra_dbi_pin_set(dc, &interface->cs, 0);
> +	tegra_dbi_pin_set(dc, &interface->rw, 0);
> +
> +	for (int i =3D 0; i < TEGRA_DBI_DATA_PINS_MAX; i++)
> +		tegra_dbi_pin_set(dc, &interface->data[i], field_get(BIT(i), value));
> +
> +	tegra_dbi_pin_set(dc, &interface->cs, 1);
> +	tegra_dbi_pin_set(dc, &interface->rw, 1);
> +
> +	udelay(10);

Umpf... I guess we're effectively bit-banging here, but a udelay() here
is potentially a lot of spinning time. If I recall correctly this can
end up being called a lot, on the order of 100 or so times during panel
initialization.

> +
> +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct drm_bridge *next_bridge =3D priv->next_bridge;
> +	struct tegra_dc *dc =3D priv->dc;
> +	u32 value;
> +
> +	value =3D tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
> +	value &=3D ~DISP_CTRL_MODE_MASK;
> +	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
> +
> +	/* Disable all options except cursor if enabled */
> +	value =3D tegra_dc_readl(dc, DC_DISP_DISP_WIN_OPTIONS);
> +	value &=3D CURSOR_ENABLE;
> +	tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
> +
> +	tegra_dc_commit(dc);
> +
> +	tegra_dc_writel(dc, V_PULSE1_ENABLE, DC_DISP_DISP_SIGNAL_OPTIONS0);
> +	tegra_dc_writel(dc, PULSE_POLARITY_LOW, DC_DISP_V_PULSE1_CONTROL);
> +
> +	tegra_dc_writel(dc, PULSE_END(1), DC_DISP_V_PULSE1_POSITION_A);
> +	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_B);
> +	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_C);
> +
> +	value =3D 1 << FRAME_INIT_SEQ_CYCLES_SHIFT |
> +		DC_SIGNAL_VPULSE1 << INIT_SEQ_DC_SIGNAL_SHIFT |
> +		INIT_SEQUENCE_MODE_PLCD | SEND_INIT_SEQUENCE;
> +	tegra_dc_writel(dc, value, DC_DISP_INIT_SEQ_CONTROL);
> +
> +	/* Init cycle 1: WRITE_MEMORY_START, set LCD_PCLK and COMMAND */
> +	tegra_dc_writel(dc, MIPI_DCS_WRITE_MEMORY_START, DC_DISP_SPI_INIT_SEQ_D=
ATA_A);
> +	tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_B);
> +	tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_C);
> +	tegra_dc_writel(dc, BIT(12) | BIT(14), DC_DISP_SPI_INIT_SEQ_DATA_D);
> +
> +	/* Set LDC pin to V Pulse 1 */
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LDC);
> +	value |=3D PIN_OUTPUT_SELECT_F4(PIN_OUTPUT_SELECT_LDC);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
> +
> +	value =3D SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
> +		SC0_V_QUALIFIER(SC_V_QUALIFIER_VACTIVE) |
> +		SC0_H_QUALIFIER(SC_H_QUALIFIER_HACTIVE);
> +	tegra_dc_writel(dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
> +
> +	value =3D tegra_dc_readl(dc, DC_DISP_DISP_COLOR_CONTROL);
> +	value &=3D ~BASE_COLOR_SIZE_MASK;
> +
> +	switch (priv->bus_width) {
> +	case 16:
> +		value |=3D BASE_COLOR_SIZE_565;
> +		break;
> +	case 18:
> +		value |=3D BASE_COLOR_SIZE_666;
> +		break;
> +	case 24:
> +		value |=3D BASE_COLOR_SIZE_888;
> +		break;
> +	default:
> +		WARN(1, "%u bus width not supported\n", priv->bus_width);
> +		value |=3D BASE_COLOR_SIZE_888;
> +		break;
> +	}
> +
> +	tegra_dc_writel(dc, value, DC_DISP_DISP_COLOR_CONTROL);
> +
> +	/*
> +	 * Backup registers before unshadowing since actual register values
> +	 * may differ and their state backed up now is the correct one.
> +	 */
> +	for (int i =3D 0; i < ARRAY_SIZE(tegra_dbi_pin_regs); i++)
> +		priv->com_pin_backup[i].value =3D tegra_dc_readl(dc,
> +			priv->com_pin_backup[i].offset);
> +
> +	/* Unshadow to set up command and data pins */
> +	tegra_dc_writel(dc, WRITE_MUX | READ_MUX, DC_CMD_STATE_ACCESS);
> +
> +	if (priv->interface->interface)
> +		tegra_dbi_init_secondary_interface(priv);
> +	else
> +		tegra_dbi_init_primary_interface(priv);

Maybe hook this into priv->interface directly using a .init() callback.
That way you don't need to branch based on interface index here.

[...]
> +int tegra_dc_dbi_probe(struct tegra_dc *dc)
> +{
> +	struct device *dev =3D dc->dev;
> +	struct device_node *dbi_np __free(device_node) =3D
> +		of_get_available_child_by_name(dev_of_node(dev), "dbi");
> +	struct mipi_dbi_device *dbidev;
> +	struct tegra_dbi_priv *priv;
> +	struct device_node *np;
> +	u32 reg;
> +	int ret;
> +
> +	/* Missing node means that DBI is not used, continue DC probe */
> +	if (!dbi_np)
> +		return 0;

Maybe this should have an extra check to see if dbi_np is available.
That would help create this node in a DTSI file and just keep it
disabled by default.

> +
> +	priv =3D devm_drm_bridge_alloc(dev, struct tegra_dbi_priv, bridge,
> +				     &tegra_dbi_funcs);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	priv->dc =3D dc;
> +	priv->dev =3D dev;
> +
> +	ret =3D of_property_read_u32(dbi_np, "reg", &reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get reg\n");
> +
> +	if (reg !=3D 0 && reg !=3D 1)
> +		return dev_err_probe(dev, -EINVAL, "Wrong reg value: %d\n", reg);

Maybe sort these before the call to devm_drm_bridge_alloc()?

Thierry

--bfslmjupan46ngr7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmrt5msACgkQ3SOs138+
s6HbVA/+Irze+1lgUBGNGoqgvX6eTzI5eAKi5CDyxwOvFOj2ceKp6ymnZ1d7jDvP
FKC/P5Oy0uizKDGpl2KLQ1vt9VwPpNIj6MsUe1wLzSyQbRoFOULt/pcJArd+peZa
N6pw+4kp91kyCVJ35aDl2BOntlDP7HltoDPkp2IkxINm43e167aQqDfOrqNycl46
3TCaCum2+AidUfE2vIYqMkpPnLO8jJVDy6dExkgX9JYTFDrBQ418R6GGAb81HlSQ
L+otESxpgz8INwiRHv0p121Bo4tCPI3N1qTgXBDQHPgLCB/SlkznF9MpHfg/7502
v6UQo/Sto4n41S+lG/8NXv8GiRh/ydZyZ3TEBQZ9+u/HT9mGmM14dKFR36CPVGbr
g9mKNrectQMVYs1Bdo6AT3U+z4NTr5u3yxQygDgSQSMotzFrp4K0B72ozq27aTw8
1kZj8OpdJ5bVwZiiluwKpVhbfGtgbbIBAg8QS8Zej4P/q0x6nRidwflWplILvFKy
eoArEGgOLnbiPHS1VNTpTrL54wou151WA2mlvvhN63V+Viqpfptk9FfyjiB89rhW
jCrk7UQgnEwHL4h4j3LY3wRlquEAFyFE7CA65CSEhhaOiqSZaqFUIIVorkKsytRk
4gsS8zUz9OslndEa0caVrPbd3rhDdMMZv9HB4fuJPOHcPpYEekM=
=vBTH
-----END PGP SIGNATURE-----

--bfslmjupan46ngr7--
