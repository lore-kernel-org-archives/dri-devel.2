Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0505606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J9pMVfA7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CFCCB10FE07;
	Wed, 18 Nov 2026 15:45:23 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF4F10E7DF
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:45:17 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C481845F23;
 Wed, 18 Nov 2026 15:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53E621F000C5;
 Wed, 18 Nov 2026 15:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016716;
 bh=2G51rEyfqi6bjd6wrXqr2TDfrIHimcl6sRFrz0Sp5Ys=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J9pMVfA7sWsDlm/DPa3FjDpqTzmRLQzYGvMTpXEzMeOjjM4kEJPcz1S2IkdVNQz7X
 SPPgoxVAFe3RDjFcmPKgb6CuoXpPQBDHOYR1N8ejDMM+mC1nbvDhxpeIJljliKwuIC
 OQeVVw/7tS1FGzzRC5muQ69B7mgalcfPHHsmIO+uGHv9ikwrHva7bT7TDVC0fDIyld
 WFt3BLj0Cisgujri2iGUml2R0OvrWY+MUraqAKPXapHWJUaQ3GvAUoBUDK4t5IwHzE
 lbxyIJ9+VnO4kDr0R8RVLmfNtwFsSiwx0SaAhT/w4MB9G8eVJ2MM07bJ1g++DO2Exa
 fyLiId2lNsPUw==
Message-ID: <sashiko-outbox-221370@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/11] iio: adc: stm32-mdf: add core registration
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-2-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:45:15 +0000
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

Thank you for your contribution! Sashiko AI review found 12 potential
issues to consider:
- [High] iio: adc: stm32-mdf: reset in stm32_mdf_core_parse_of() breaks
  regcache/probe
- [Medium] iio: adc: stm32-mdf: unchecked read and missing rollback in
  start_mdf()
- [Medium] iio: adc: stm32-mdf: lockless n_active_ch races in
  start_mdf() and stop_mdf()
- [Medium] iio: adc: stm32-mdf: unlocked regcache_cache_bypass() races
  with trigger()
- [Medium] iio: adc: stm32-mdf: missing state rollback on suspend and
  resume failure
- [Medium] iio: adc: stm32-mdf: unmapped resource 1 read in
  stm32_mdf_core_probe()
- [Low] iio: adc: stm32-mdf: unused PM callbacks when CONFIG_PM_SLEEP or
  CONFIG_PM=3Dn
- [Low] iio: adc: stm32-mdf: drvdata pointer type mismatch in
  stm32_mdf_core_probe()
- [Low] iio: adc: stm32-mdf: unchecked regmap_read() for MDF_VERR_REG
- [Low] iio: adc: stm32-mdf: guard() mixed with goto in
  stm32_mdf_core_trigger()
- [Low] iio: adc: stm32-mdf: invalid OPTION() macro in
  MDF_OR_OPTION_MASK
- [Low] iio: adc: stm32-mdf: missing header include guards in
  stm32-mdf.h
--

commit 016595fa648050f874751e37d47a5cfa33a78bde
Author: Olivier Moysan <olivier.moysan@foss.st.com>

iio: adc: stm32-mdf: add core registration

This commit adds the core driver for the STM32 multifunction digital
filter (MDF) to manage shared registers, clocks, and power resources on
STM32MP2.

> diff --git a/drivers/iio/adc/stm32-mdf-core.c b/drivers/iio/adc/stm32-mdf=
-core.c
> new file mode 100644
> index 0000000000000..ca50ce566a435
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-mdf-core.c
[ ... ]
> +int stm32_mdf_core_start_mdf(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +	struct device *dev =3D &priv->pdev->dev;
> +	int ret;
> +	u32 val;
> +
> +	if (atomic_inc_return(&priv->n_active_ch) =3D=3D 1) {
> +		ret =3D pm_runtime_resume_and_get(dev);
> +		if (ret < 0)
> +			goto err;
> +
> +		/* Enable PROCDIV and CCKDIV clock dividers */
> +		ret =3D regmap_set_bits(priv->regmap, MDF_CKGCR_REG, MDF_CKG_CKGDEN);
> +		if (ret < 0)
> +			goto pm_put;
> +
> +		/* Check clock status. Bypass cache to access volatile CKGACTIVE activ=
e bit */
> +		regcache_cache_bypass(priv->regmap, true);
> +		regmap_read(priv->regmap, MDF_CKGCR_REG, &val);
> +		regcache_cache_bypass(priv->regmap, false);
> +		if (!(val & MDF_CKG_ACTIVE)) {
> +			ret =3D -EINVAL;
> +			dev_err(dev, "MDF clock not active\n");
> +			goto pm_put;
> +		}

[Severity: Medium]
What happens if regmap_read() fails here, or if MDF_CKG_ACTIVE is not set?
The return value of regmap_read() is not checked, so a read failure tests
an uninitialized val on the stack.

In addition, jumping to pm_put when MDF_CKG_ACTIVE is not set leaves
MDF_CKG_CKGDEN set in hardware and in REGCACHE_FLAT, so subsequent
non-forced regmap_set_bits() calls will skip writing MDF_CKG_CKGDEN.

> +
> +		if (!priv->exclusive_flg) {
> +			clk_rate_exclusive_get(priv->kclk);
> +			priv->exclusive_flg =3D true;
> +		}
> +	}
> +
> +	return 0;
> +
> +pm_put:
> +	pm_runtime_put_sync(dev);
> +err:
> +	atomic_dec(&priv->n_active_ch);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_core_start_mdf);
> +
> +/**
> + * stm32_mdf_core_trigger() - Trigger MDF filters
> + * @mdf: MDF instance
> + *
> + * Trigger MDF filters via TRGO trigger.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int stm32_mdf_core_trigger(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +	int ret;
> +	u32 val;
> +
> +	guard(spinlock)(&priv->lock);
> +
> +	/* Bypass cache to access TRGO volatile bit */
> +	regcache_cache_bypass(priv->regmap, true);
> +
> +	ret =3D regmap_read(priv->regmap, MDF_GCR_REG, &val);
> +	if (ret < 0)
> +		goto err;
> +
> +	if (val & MDF_GCR_TRGO) {
> +		ret =3D -EBUSY;
> +		goto err;
> +	}
> +
> +	ret =3D regmap_set_bits(priv->regmap, MDF_GCR_REG, MDF_GCR_TRGO);
> +
> +err:
> +	regcache_cache_bypass(priv->regmap, false);
> +
> +	return ret;
> +}

[Severity: Medium]
Can regcache_cache_bypass() in stm32_mdf_core_start_mdf() race with
stm32_mdf_core_trigger()?

stm32_mdf_core_trigger() takes priv->lock before toggling map-wide
cache_bypass on priv->regmap, but stm32_mdf_core_start_mdf() and
stm32_mdf_core_stop_mdf() access priv->regmap and toggle cache_bypass
without holding priv->lock:

CPU0                                  CPU1
stm32_mdf_core_trigger()              stm32_mdf_core_start_mdf()
  guard(spinlock)(&priv->lock)
  regcache_cache_bypass(..., true)
  regmap_read(..., MDF_GCR_REG, ...)
                                        regcache_cache_bypass(..., true)
                                        regmap_read(..., MDF_CKGCR_REG, ...)
                                        regcache_cache_bypass(..., false)
  regmap_set_bits(..., MDF_GCR_TRGO)
    <-- cached in REGCACHE_FLAT

With MDF_GCR_TRGO cached in REGCACHE_FLAT, later regcache_sync() calls on
resume will re-trigger the filters.

[Severity: Low]
This isn't a bug, but stm32_mdf_core_trigger() mixes guard(spinlock) with
goto err error handling in the same function.

> +EXPORT_SYMBOL_GPL(stm32_mdf_core_trigger);
> +
> +/**
> + * stm32_mdf_core_stop_mdf() - Stop an MDF channel
> + * @mdf: MDF instance
> + *
> + * Drop one active-channel reference. When the last channel stops, relea=
se the
> + * exclusive kernel clock rate and disable the MDF clock.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +	int ret =3D 0;
> +
> +	if (atomic_dec_and_test(&priv->n_active_ch)) {
> +		if (priv->exclusive_flg) {
> +			clk_rate_exclusive_put(priv->kclk);
> +			priv->exclusive_flg =3D false;
> +		}
> +
> +		ret =3D regmap_clear_bits(priv->regmap, MDF_CKGCR_REG, MDF_CKG_CKGDEN);
> +
> +		pm_runtime_put_sync(&priv->pdev->dev);
> +	}
> +
> +	return ret;
> +}

[Severity: Medium]
Can concurrent calls to stm32_mdf_core_start_mdf() and
stm32_mdf_core_stop_mdf() race on priv->n_active_ch?

Only the atomic counter update is serialized, not the hardware startup and
teardown sequences gated by the 0->1 and 1->0 transitions:

CPU0                                  CPU1
stm32_mdf_core_start_mdf()            stm32_mdf_core_start_mdf()
  atomic_inc_return() =3D=3D 1
                                        atomic_inc_return() =3D=3D 2
                                        return 0  <-- clocks not enabled yet
  pm_runtime_resume_and_get()
  ...

A similar race occurs when one channel calls stm32_mdf_core_stop_mdf()
(decrementing n_active_ch from 1 to 0) concurrently with another channel
calling stm32_mdf_core_start_mdf() (incrementing n_active_ch from 0 to 1),
allowing stm32_mdf_core_stop_mdf() to clear MDF_CKG_CKGDEN and call
pm_runtime_put_sync() after the new channel has started.  Using a mutex to
serialize start and stop would avoid both races.

[ ... ]
> +static int stm32_mdf_core_parse_of(struct platform_device *pdev, struct =
stm32_mdf_priv *priv)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct reset_control *rst;
> +	struct device *dev =3D &pdev->dev;
> +	u32 count;
> +	int ret;
> +
> +	if (!node)
> +		return -EINVAL;
> +
> +	rst =3D devm_reset_control_get_optional_exclusive(&pdev->dev, NULL);
> +	if (IS_ERR(rst))
> +		return dev_err_probe(dev, PTR_ERR(rst), "Failed to get reset controlle=
r\n");
> +
> +	ret =3D reset_control_reset(rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to reset MDF\n");

[Severity: High]
Does reset_control_reset() fail with -ENOTSUPP on STM32MP25 when resets is
present in the device tree?

The STM32 RCC reset controller driver only implements .assert, .deassert,
and .status:

drivers/clk/stm32/reset-stm32.c:
static const struct reset_control_ops stm32_reset_ops =3D {
	.assert		=3D stm32_reset_assert,
	.deassert	=3D stm32_reset_deassert,
	.status		=3D stm32_reset_status,
};

Because .reset is NULL, reset_control_reset() returns -ENOTSUPP and aborts
probe.

In addition, stm32_mdf_core_probe() calls stm32_mdf_regmap_init() and
stm32_mdf_core_identification() before stm32_mdf_core_parse_of() resets
the hardware.  Reading identification registers and populating
REGCACHE_FLAT before deasserting reset reads registers while the block may
still be in reset, and resetting afterward clears hardware registers behind
the initialized cache.

[ ... ]
> +static int stm32_mdf_core_identification(struct platform_device *pdev, s=
truct stm32_mdf_priv *priv)
> +{
> +	struct stm32_mdf *mdf =3D &priv->mdf;
> +	u32 val;
> +	int ret;
> +
> +	/* If filter number is explicitly defined, don't check identification r=
egisters */
> +	mdf->nbf =3D ((unsigned long)device_get_match_data(&pdev->dev));
> +	if (mdf->nbf)
> +		return 0;
> +
> +	ret =3D regmap_read(priv->regmap, MDF_IPIDR_REG, &val);
> +	if (ret)
> +		return ret;
> +
> +	if (val =3D=3D STM32MP25_MDF_IPIDR_NUMBER) {
> +		ret =3D regmap_read(priv->regmap, MDF_HWCFGR_REG, &val);
> +		if (ret)
> +			return ret;
> +
> +		mdf->nbf =3D FIELD_GET(MDF_HWCFGR_NBF_MASK, val);
> +
> +		ret =3D regmap_read(priv->regmap, MDF_VERR_REG, &val);
> +
> +		dev_dbg(&pdev->dev, "MDF version: %lu.%lu\n", FIELD_GET(MDF_VERR_MAJRE=
V_MASK, val),
> +			FIELD_GET(MDF_VERR_MINREV_MASK, val));

[Severity: Low]
Should ret be checked after reading MDF_VERR_REG?  Right now ret is
assigned and ignored, so a failed read logs stale bits from MDF_HWCFGR_REG
and returns 0.

[ ... ]
> +static int stm32_mdf_core_probe(struct platform_device *pdev)
> +{
> +	struct stm32_mdf_priv *priv;
> +	struct resource *res;
> +	int ret;
> +
> +	priv =3D devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
> +	if (!priv)
> +		return -ENOMEM;
> +	priv->pdev =3D pdev;
> +	spin_lock_init(&priv->lock);
> +
> +	priv->base =3D devm_platform_get_and_ioremap_resource(pdev, 0, &res);
> +	if (IS_ERR(priv->base))
> +		return PTR_ERR(priv->base);
> +	priv->phys_base =3D res->start;
> +
> +	priv->kclk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(priv->kclk))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(priv->kclk),
> +				     "Failed to get kernel clock\n");
> +	priv->mdf.kclk =3D priv->kclk;
> +
> +	priv->regmap =3D stm32_mdf_regmap_init(&pdev->dev, priv->kclk, priv->ba=
se,
> +					     &stm32_mdf_regmap_cfg);

[Severity: Medium]
Does stm32_mdf_regmap_init() read past the end of the ioremapped resource
0 region?

In the DT binding (Documentation/devicetree/bindings/iio/adc/st,stm32mp25-m=
df.yaml),
resource 0 is only 8 bytes (reg =3D <0x504d0000 0x8>, <0x504d0ff0 0x10>),
while the identification registers at 0xff0..0xffc are in resource 1.
stm32_mdf_core_probe() only maps resource 0, yet stm32_mdf_regmap_cfg sets
max_register =3D MDF_SIDR_REG (0xffc) with REGCACHE_FLAT, causing both
regcache_hw_init() and stm32_mdf_core_identification() to read offsets
0xff0..0xffc from priv->base without requesting or mapping resource 1.

[ ... ]
> +	INIT_LIST_HEAD(&priv->mdf.filter_list);
> +
> +	platform_set_drvdata(pdev, priv);

[Severity: Low]
Should platform_set_drvdata() pass &priv->mdf instead of priv?
stm32_mdf_core_suspend(), stm32_mdf_core_resume(), and child filter
drivers treat dev_get_drvdata() as a struct stm32_mdf * pointer and pass
it to to_stm32_mdf_priv(), which only works today because mdf happens to
be the first member of struct stm32_mdf_priv.

[ ... ]
> +static int stm32_mdf_core_suspend(struct device *dev)
> +{
> +	struct stm32_mdf *mdf =3D dev_get_drvdata(dev);
> +	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +	int ret;
> +
> +	ret =3D pm_runtime_force_suspend(dev);
> +	if (ret)
> +		return ret;
> +
> +	regcache_cache_only(priv->regmap, true);
> +	regcache_mark_dirty(priv->regmap);
> +
> +	/* Balance regmap_mmio_attach_clk() clk_prepare() */
> +	clk_unprepare(priv->kclk);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int stm32_mdf_core_resume(struct device *dev)
> +{
> +	struct stm32_mdf *mdf =3D dev_get_drvdata(dev);
> +	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +	int ret;
> +
> +	ret =3D pinctrl_pm_select_default_state(dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to set pins default state: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret =3D clk_prepare(priv->kclk);
> +	if (ret) {
> +		dev_err(dev, "Failed to prepare kernel clock: %d\n", ret);
> +		goto err_clk;
> +	}
> +
> +	regcache_cache_only(priv->regmap, false);
> +	ret =3D regcache_sync(priv->regmap);
> +	if (ret) {
> +		dev_err(dev, "Failed to sync cache: %d\n", ret);
> +		goto err_cache;
> +	}
> +
> +	return pm_runtime_force_resume(dev);
> +
> +err_cache:
> +	clk_unprepare(priv->kclk);
> +err_clk:
> +	pinctrl_pm_select_sleep_state(dev);
> +
> +	return ret;
> +}

[Severity: Medium]
If pinctrl_pm_select_sleep_state() fails in stm32_mdf_core_suspend(), does
the device stay in cache-only mode with priv->kclk unprepared?  When
.suspend returns an error, .resume is not called, so failing without
re-preparing priv->kclk and restoring regcache_cache_only(false) and
pm_runtime_force_resume() leaves the clock prepare count unbalanced on
teardown.

Similarly, in stm32_mdf_core_resume(), if regcache_sync() fails, err_cache
unprepares priv->kclk while leaving regcache_cache_only(priv->regmap,
false) set.

> +
> +static int stm32_mdf_core_runtime_suspend(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static int stm32_mdf_core_runtime_resume(struct device *dev)
> +{
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops stm32_mdf_core_pm_ops =3D {
> +	SET_SYSTEM_SLEEP_PM_OPS(stm32_mdf_core_suspend, stm32_mdf_core_resume)
> +	SET_RUNTIME_PM_OPS(stm32_mdf_core_runtime_suspend, stm32_mdf_core_runti=
me_resume, NULL)
> +};
> +
> +static struct platform_driver stm32_mdf_driver =3D {
> +	.probe =3D stm32_mdf_core_probe,
> +	.remove =3D stm32_mdf_core_remove,
> +	.driver =3D {
> +		.name =3D "stm32-mdf",
> +		.of_match_table =3D stm32_mdf_of_match,
> +		.pm =3D &stm32_mdf_core_pm_ops,
> +	},
> +};

[Severity: Low]
Building with CONFIG_PM_SLEEP=3Dn or CONFIG_PM=3Dn (for example under
COMPILE_TEST) will warn about unused static PM callbacks because
SET_SYSTEM_SLEEP_PM_OPS() and SET_RUNTIME_PM_OPS() compile out the
references.  Using SYSTEM_SLEEP_PM_OPS(), RUNTIME_PM_OPS(), and
pm_ptr(&stm32_mdf_core_pm_ops) allows the compiler to drop them cleanly
when PM is disabled.

> diff --git a/drivers/iio/adc/stm32-mdf.h b/drivers/iio/adc/stm32-mdf.h
> new file mode 100644
> index 0000000000000..b334769f8b175
> --- /dev/null
> +++ b/drivers/iio/adc/stm32-mdf.h
[ ... ]
> +/* MDF_OR: Option Register */
> +#define MDF_OR_OPTION_MASK OPTION(31, 0)

[Severity: Low]
Should OPTION(31, 0) be GENMASK(31, 0)?  OPTION() is not defined anywhere,
so any use of MDF_OR_OPTION_MASK will fail to build.

[ ... ]
> +struct stm32_mdf {
> +	struct list_head filter_list;
> +	struct clk *kclk;
> +	unsigned long fproc;
> +	unsigned int nbf;
> +	unsigned int nb_interleave;
> +};

[Severity: Low]
stm32-mdf.h has no #ifndef/#define/#endif include guards, so including it
more than once in a translation unit will cause redefinition errors for
struct stm32_mdf and stm32_mdf_regmap_init().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D2
