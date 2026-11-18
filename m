Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87AA0606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VtEc1rXG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFB0710E538;
	Wed, 18 Nov 2026 15:42:17 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E2F3310E538
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:42:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AED494386A;
 Wed, 18 Nov 2026 15:42:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CB8B1F000C5;
 Wed, 18 Nov 2026 15:42:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016530;
 bh=RohgLBAexgLmQgnocxGNiSi0y1sBJm0zvNG/HBAbkDI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=VtEc1rXGOBygt6PrHOHw5Tzy8cphLduSMMqPvR97JUHaHhuCVb1WHRW/9K2qj+aBJ
 CVCtxJJYO1TUF1b5D2okY3YK8MB9MrF0nidJFjpjwJtkUAZN6caoGM6UfS1ZSaEn+c
 qJYxGSUN6oqnT1h/+BhLOFps4cUTtxl0fOM1Wn/tvzw3eI1Otd1rxj7Ep81+wGjbNo
 vcetSnJb6ueAwRxDYWyhyZKN7w+BCgyELLrIrkYANd5JD5/ZfSAm33oo5k1ash851k
 1BV4F3uZQPQlgUhOXOmeL/hmUZYK4YiUPIOKqJ+VxWaGKaM2EiY9xEXtG/9xCHpcV1
 jfA9a6eI/+i5w==
Message-ID: <sashiko-outbox-221361@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/11] iio: adc: stm32-mdf: add serial interfaces
 support
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-4-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-4-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:42:09 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential
issues to consider:
- [High] iio: adc: stm32-mdf: NULL pointer dereference in
  stm32_mdf_sitf_get_clk()
- [Medium] iio: adc: stm32-mdf: off-by-one and underflow in
  stm32_mdf_sitf_parse()
- [Medium] iio: adc: stm32-mdf: invalid SCKSRC and bit update in
  stm32_mdf_sitf_parse()
- [Medium] iio: adc: stm32-mdf: missing max_register_is_0 and name in
  sitf regmap_config
- [Medium] iio: adc: stm32-mdf: unbalanced kclk prepare count on
  suspend/resume errors
- [Low] iio: adc: stm32-mdf: module self-pinning in
  stm32_mdf_sitf_get_clk()
- [Low] iio: adc: stm32-mdf: unused base member in struct stm32_mdf_sitf
--

commit a885a42b631244af337425ef9681fd1c4db1960e
Author: Olivier Moysan <olivier.moysan@foss.st.com>

iio: adc: stm32-mdf: add serial interfaces support

This commit adds support for the STM32 MDF serial interfaces (SPI and
Manchester modes), including Device Tree parsing, clock selection,
suspend/resume handling, and reference-counted start and stop helpers.

> diff --git a/drivers/iio/adc/stm32-mdf-core.c b/drivers/iio/adc/stm32-mdf=
-core.c
> index 4e462c6c42bc8..5b5d2d4cbb5c5 100644
> --- a/drivers/iio/adc/stm32-mdf-core.c
> +++ b/drivers/iio/adc/stm32-mdf-core.c
[ ... ]
> @@ -794,7 +806,9 @@ static int stm32_mdf_core_suspend(struct device *dev)
>  	regcache_cache_only(priv->regmap, true);
>  	regcache_mark_dirty(priv->regmap);
> =20
> -	/* Balance regmap_mmio_attach_clk() clk_prepare() */
> +	/* Balance regmap_mmio_attach_clk() for the SITFs and the core. */
> +	list_for_each_entry(sitf, &mdf->sitf_list, entry)
> +		clk_unprepare(priv->kclk);
>  	clk_unprepare(priv->kclk);
> =20
>  	return pinctrl_pm_select_sleep_state(dev);
> @@ -804,6 +818,8 @@ static int stm32_mdf_core_resume(struct device *dev)
>  {
>  	struct stm32_mdf *mdf =3D dev_get_drvdata(dev);
>  	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +	struct stm32_mdf_sitf *sitf;
> +	unsigned int prepared =3D 0;
>  	int ret;
> =20
>  	ret =3D pinctrl_pm_select_default_state(dev);
> @@ -825,8 +841,24 @@ static int stm32_mdf_core_resume(struct device *dev)
>  		goto err_cache;
>  	}
> =20
> +	list_for_each_entry(sitf, &mdf->sitf_list, entry) {
> +		ret =3D clk_prepare(priv->kclk);
> +		if (ret)
> +			goto err_sitf;
> +		prepared++;
> +
> +		ret =3D regmap_write(sitf->regmap, MDF_SITFCR_REG, sitf->sitfcr);
> +		if (ret)
> +			goto err_sitf;
> +	}
> +
>  	return pm_runtime_force_resume(dev);
> =20
> +err_sitf:
> +	while (prepared) {
> +		clk_unprepare(priv->kclk);
> +		prepared--;
> +	}
>  err_cache:
>  	clk_unprepare(priv->kclk);
>  err_clk:

[Severity: Medium]
Does an error in pinctrl_pm_select_sleep_state() or in
stm32_mdf_core_resume() leave priv->kclk unprepared while the regmap_mmio
instances remain active?

Each regmap_mmio_attach_clk() call at probe holds a clk_prepare() reference
that regmap_mmio_free_context() releases on teardown.  If
pinctrl_pm_select_sleep_state() fails in stm32_mdf_core_suspend(), or if
stm32_mdf_core_resume() fails and unwinds clk_prepare(priv->kclk) (while
also leaving priv->regmap out of cache-only mode), later register accesses
call clk_enable() on an unprepared clock and driver removal triggers
clk_unprepare() underflow warnings.

> diff --git a/drivers/iio/adc/stm32-mdf-serial.c b/drivers/iio/adc/stm32-m=
df-serial.c
> new file mode 100644
> index 0000000000000..6ba3be0198478
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-mdf-serial.c
[ ... ]
> +static const struct regmap_config stm32_sitf_regmap_cfg =3D {
> +	.reg_bits =3D 32,
> +	.val_bits =3D 32,
> +	.reg_stride =3D sizeof(u32),
> +	.max_register =3D MDF_SITFCR_REG,
> +	.fast_io =3D true,
> +	/* Do not use regcache as it does not support single register map */
> +};

[Severity: Medium]
Should stm32_sitf_regmap_cfg set .max_register_is_0 =3D true and give each
serial interface regmap a distinct .name?

Because MDF_SITFCR_REG is 0, __regmap_init() treats .max_register as
unspecified unless .max_register_is_0 =3D true is set, which disables upper
bounds checking on the 4-byte iomapped region (and is also why regcache
rejected the single-register map).  In addition, stm32_mdf_sitf_init()
registers every sitf->regmap on the parent device with .name =3D=3D NULL, so
their debugfs entries collide with priv->regmap and with each other.

[ ... ]

> +static int stm32_mdf_sitf_get_clk(struct device *dev, struct device_node=
 *np,
> +				  struct stm32_mdf_sitf *sitf)
> +{
> +	struct clk *sck;
> +	int ret;
> +
> +	/* SITF nodes have no device to apply their assigned clock configuratio=
n. */
> +	ret =3D of_clk_set_defaults(np, false);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Can't configure serial clock for %pOF\=
n", np);
> +
> +	sitf->scksrc =3D STM32_MDF_SCKSRC_NONE;
> +	/* Optional clock. Clock not needed in Manchester mode. */
> +	if (!of_property_present(np, "clocks"))
> +		return 0;
> +
> +	sck =3D devm_get_clk_from_child(dev, np, NULL);
> +	if (IS_ERR(sck))
> +		return dev_err_probe(dev, PTR_ERR(sck), "Can't get serial clock for %p=
OF\n", np);

[Severity: Low]
When the SITF clock is one of the internal CCK0 or CCK1 clocks registered
by the same driver in stm32_mdf_core_register_clock_provider(), does
devm_get_clk_from_child() pin stm32-mdf.ko to itself?

devm_get_clk_from_child() resolves the clock through OF with a NULL
consumer owner, so clk_hw_create_clk() sees owner !=3D core->owner and calls
try_module_get() on stm32-mdf.ko, preventing rmmod until the device is
manually unbound.

> +
> +	sitf->sck =3D sck;
> +	if (!strncmp(__clk_get_name(sck), STM32_MDF_CCK0, sizeof(STM32_MDF_CCK0=
)))
> +		sitf->scksrc =3D STM32_MDF_SCKSRC_CCK0;
> +	else if (!strncmp(__clk_get_name(sck), STM32_MDF_CCK1, sizeof(STM32_MDF=
_CCK1)))
> +		sitf->scksrc =3D STM32_MDF_SCKSRC_CCK1;
> +	else
> +		sitf->scksrc =3D STM32_MDF_SCKSRC_CLK;
> +
> +	return 0;
> +}

[Severity: High]
Can sck be NULL here, causing a NULL pointer dereference in strncmp()?

In stm32_mdf_core_register_clock_provider(), clk_data->num is set to
STM32_MDF_MAX_CCK while only clocks listed in clock-output-names are
populated in clk_data->hws[]:

drivers/iio/adc/stm32-mdf-core.c:stm32_mdf_core_register_clock_provider() {
    ...
		clk_data->hws[index] =3D mdf_hw[clk_id];
    ...
		index++;
	}

	clk_data->num =3D STM32_MDF_MAX_CCK;
}

If a sitf node references an unpopulated CCK index, of_clk_hw_onecell_get()
returns NULL and devm_get_clk_from_child() returns sck =3D NULL.  IS_ERR(sc=
k)
does not catch NULL, so __clk_get_name(sck) returns NULL and strncmp()
dereferences it.

> +
> +static int stm32_mdf_sitf_parse(struct device *dev, struct device_node *=
np,
> +				struct stm32_mdf_sitf *sitf)
> +{
> +	const char *str;
> +	int ret, mode;
> +	u32 idx, sitfcr;
> +
> +	ret =3D of_property_read_u32(np, "reg", &idx);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Could not get interface index for %pOF=
\n", np);
> +
> +	if (idx % 0x80) {
> +		dev_err(dev, "Unexpected reg property value [%x]\n", idx);
> +		return -EINVAL;
> +	}
> +
> +	idx =3D (idx >> 7) - 1;
> +	if (idx > sitf->mdf->nbf) {
> +		dev_err(dev, "Interface index [%d] exceeds maximum [%d]\n", idx, sitf-=
>mdf->nbf);
> +		return -EINVAL;
> +	}

[Severity: Medium]
Should the bounds check on the 0-based idx be idx >=3D sitf->mdf->nbf?

With nbf serial interfaces at offsets 0x80 .. 0x80 * nbf, valid 0-based
indices are 0 .. sitf->mdf->nbf - 1, so idx > sitf->mdf->nbf is off by one
and accepts idx =3D=3D sitf->mdf->nbf.  Also, if reg is 0, idx % 0x80 is 0 =
and
(idx >> 7) - 1 underflows u32 idx to U32_MAX, which %d prints as -1.

[ ... ]

> +	sitf->id =3D idx;
> +	sitf->node =3D of_fwnode_handle(np);
> +	spin_lock_init(&sitf->lock);
> +
> +	sitfcr |=3D FIELD_PREP(MDF_SITFCR_SCKSRC_MASK, sitf->scksrc);
> +
> +	return regmap_set_bits(sitf->regmap, MDF_SITFCR_REG, sitfcr);
> +}

[Severity: Medium]
Does this write the software sentinel STM32_MDF_SCKSRC_NONE into
MDF_SITFCR_SCKSRC_MASK when no clock is provided in Manchester mode, and
leave stale bits set in MDF_SITFCR_REG?

When the optional clocks property is absent, sitf->scksrc is
STM32_MDF_SCKSRC_NONE (3), which FIELD_PREP() encodes as reserved value
0b11 in SCKSRC[1:0].  Furthermore, regmap_set_bits() only sets 1-bits in
sitfcr and never clears 0-bits in MDF_SITFCR_SITFMOD_MASK |
MDF_SITFCR_SCKSRC_MASK (and performs no write at all when sitfcr is 0);
should this use regmap_update_bits() with that mask instead?

> diff --git a/drivers/iio/adc/stm32-mdf.h b/drivers/iio/adc/stm32-mdf.h
> index e3617b181e28a..fa689954d7c15 100644
> --- a/drivers/iio/adc/stm32-mdf.h
> +++ b/drivers/iio/adc/stm32-mdf.h
[ ... ]
> +struct stm32_mdf_sitf {
> +	struct list_head entry;
> +	struct device *dev;
> +	struct regmap *regmap;
> +	struct stm32_mdf *mdf;
> +	struct fwnode_handle *node;
> +	struct clk *sck;
> +	void __iomem *base;
> +	spinlock_t lock; /* Manage race conditions on sitf state */

[Severity: Low]
This isn't a bug, but base in struct stm32_mdf_sitf is never read or
written and can be dropped.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D4
