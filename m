Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89663606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=T9K4hvgD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 06E8D10FDF8;
	Wed, 18 Nov 2026 15:50:56 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F00510E541
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:50:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 169014326A;
 Wed, 18 Nov 2026 15:50:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 956AB1F000C4;
 Wed, 18 Nov 2026 15:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795017049;
 bh=AAxkzsVjNf3VWOtfUEfVk1uLjjf+4Yk6/cUJKimpQdk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=T9K4hvgDd9ZQGLThsicHDQKNuslJIxOKpTFNvQV1oIPlCQgcbi2OP1voq/N+nUFfp
 Tw2OgFyOgIHgXIBfzvz7HccJc2Kpnj6zWW/o2XTAyPUm78tGJGoMuvx4dlNnudsfhx
 Oyvgz7CeIjzXY64xyeSV/q2pGwYso7LMnJlaFC8jGW8ECtC4goFoI9u4YY6Hwu/aUV
 lZ0G3lBmoQIbWFR2Ohma0P1VBgTVzmG9AQCytamvj+DigPioodJVWSy9QR+7pEQvNN
 td/GucPTT2Vx62OfoOm+UfA4N0dHGFX5VUG/q9g/NuugxxERuzwGkJdL861mHvxDje
 /8S1HG3h0Hf/g==
Message-ID: <sashiko-outbox-221378@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/11] iio: adc: stm32-mdf: add cck clocks provider
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-3-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-3-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:50:48 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] iio: adc: stm32-mdf: premature rounding in
  stm32_mdf_core_cck_determine_rate()
- [High] iio: adc: stm32-mdf: ABBA deadlock between CCF enable_lock and
  regmap spinlock
- [High] iio: adc: stm32-mdf: broken onecell indexing and __counted_by
  in clock provider
- [Medium] iio: adc: stm32-mdf: unlocked RMW and unchecked read in
  clk_cckx_gate_ops
- [Medium] iio: adc: stm32-mdf: static global clk_hw structs and stack
  init data in probe
- [Medium] iio: adc: stm32-mdf: unbalanced kclk exclusivity in
  lock/unlock_kclk_rate()
--

commit aeca8d3955d2508e74c0c672d9e5746542fb1914
Author: Olivier Moysan <olivier.moysan@foss.st.com>

iio: adc: stm32-mdf: add cck clocks provider

This commit registers the MDF CCK0 and CCK1 clock outputs with the common
clock framework and adds helpers to lock, unlock, query and restore the
clock rate.

> diff --git a/drivers/iio/adc/stm32-mdf-core.c b/drivers/iio/adc/stm32-mdf=
-core.c
> index ca50ce566a435..4e462c6c42bc8 100644
> --- a/drivers/iio/adc/stm32-mdf-core.c
> +++ b/drivers/iio/adc/stm32-mdf-core.c
[ ... ]
> @@ -194,6 +210,96 @@ int stm32_mdf_core_trigger(struct stm32_mdf *mdf)
[ ... ]
> +int stm32_mdf_core_lock_kclk_rate(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +	struct device *dev =3D &priv->pdev->dev;
> +	int ret;
> +
> +	if (!atomic_read(&priv->n_active_ch)) {
> +		/* Request rate exclusivity on kernel clock right now */
> +		ret =3D clk_rate_exclusive_get(priv->kclk);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to get exclusive rate on kernel clock: [%d]\n", =
ret);
> +			return ret;
> +		}
> +
> +		priv->exclusive_flg =3D true;
> +	}
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_core_lock_kclk_rate);
> +
> +/**
> + * stm32_mdf_core_unlock_kclk_rate() - Release the MDF kernel clock rate=
 lock
> + * @mdf: MDF instance
> + *
> + * Release an exclusive rate acquired by stm32_mdf_core_lock_kclk_rate()=
 when
> + * no MDF channels are active. The lock is retained while channels are a=
ctive.
> + */
> +void stm32_mdf_core_unlock_kclk_rate(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +
> +	if (!atomic_read(&priv->n_active_ch)) {
> +		clk_rate_exclusive_put(priv->kclk);
> +		priv->exclusive_flg =3D false;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_core_unlock_kclk_rate);

[Severity: Medium]
Can concurrent calls across sibling MDF filter devices unbalance
clk_rate_exclusive_get() and clk_rate_exclusive_put() on priv->kclk?

Neither stm32_mdf_core_lock_kclk_rate() nor
stm32_mdf_core_unlock_kclk_rate() takes a lock or checks
priv->exclusive_flg:

CPU0 (Filter A)                   CPU1 (Filter B)
stm32_mdf_core_start_mdf()
  n_active_ch becomes 1
  clk_rate_exclusive_get()
  priv->exclusive_flg =3D true
                                  stm32_mdf_core_lock_kclk_rate()
                                    /* n_active_ch !=3D 0: does nothing */
stm32_mdf_core_stop_mdf()
  n_active_ch becomes 0
  clk_rate_exclusive_put()
  priv->exclusive_flg =3D false
                                  stm32_mdf_core_unlock_kclk_rate()
                                    /* n_active_ch =3D=3D 0 */
                                    clk_rate_exclusive_put()  <-- underflow

That extra put triggers WARN_ON(clk->exclusive_count <=3D 0) in
clk_rate_exclusive_put().  Conversely, if two idle filter devices call
stm32_mdf_core_lock_kclk_rate() while n_active_ch is 0,
clk_rate_exclusive_get() runs twice while priv->exclusive_flg only records
a single boolean; if a channel starts before they unlock,
stm32_mdf_core_stop_mdf() only puts once and leaks an exclusive reference,
causing later clk_set_rate() calls in stm32_mdf_core_restore_cck() to fail.

[ ... ]

> @@ -223,11 +329,301 @@ int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf)
>  }
>  EXPORT_SYMBOL_GPL(stm32_mdf_core_stop_mdf);
> =20
> +static int stm32_mdf_core_cck_divider_set_rate(struct platform_device *p=
dev,
> +					       struct stm32_mdf_priv *priv,
> +					       unsigned long rate,
> +					       unsigned long parent_rate)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	unsigned long ratio, delta, delta_ppm, procdiv;
> +	unsigned int cckdiv;
> +	int ret;
> +
> +	if (!rate || rate > STM32_MDF_MAX_CCK_RATE || !parent_rate)
> +		return -EINVAL;
> +
> +	ratio =3D DIV_ROUND_CLOSEST(parent_rate, rate);
> +	if (!ratio) {
> +		dev_err(dev, "CCK frequency above kernel frequency\n");
> +		return -EINVAL;
> +	}
> +
> +	delta =3D abs(parent_rate - (ratio * rate));
> +
> +	delta_ppm =3D (1000000 * delta) / parent_rate;
> +	if (delta_ppm > 1000) {
> +		/* If frequency deviation is higher than 1000 ppm return error */
> +		dev_dbg(dev, "CCK clock deviation [%lu] ppm too large: [%lu] vs [%lu] =
Hz\n",
> +			delta_ppm, DIV_ROUND_CLOSEST(parent_rate, ratio), rate);
> +		return -EINVAL;
> +	} else if (delta_ppm) {
> +		dev_dbg(dev, "CCK clock frequency not accurate: [%lu] ppm deviation\n"=
, delta_ppm);
> +	}
> +
> +	/*
> +	 * The total divider ratio must be split between proc divider and
> +	 * cck divider. Try to maximize cck divider first, to help fulfilling
> +	 * frequency ratio requirements between fproc and fcck.
> +	 */
> +	cckdiv =3D min_t(unsigned long, ratio, MDF_CKG_CCKDIV_MAX);
> +	while (ratio % cckdiv)
> +		cckdiv--;
> +	procdiv =3D ratio / cckdiv;
> +
> +	if (procdiv > MDF_PROCDIV_MAX) {
> +		dev_err(dev, "Proc divider out of range: %lu > %lu\n", procdiv,
> +			MDF_PROCDIV_MAX);
> +		return -EINVAL;
> +	}
> +
> +	priv->mdf.fproc =3D DIV_ROUND_CLOSEST(parent_rate, procdiv);
> +
> +	/* Configure CKGCR register */
> +	dev_dbg(dev, "Set MDF dividers: CCKDIV [%u], PROCDIV [%lu]\n", cckdiv, =
procdiv);
> +	ret =3D regmap_update_bits(priv->regmap, MDF_CKGCR_REG,
> +				 MDF_CKG_CCKDIV_MASK | MDF_CKG_PROCDIV_MASK,
> +				 FIELD_PREP(MDF_CKG_CCKDIV_MASK, cckdiv - 1) |
> +				 FIELD_PREP(MDF_CKG_PROCDIV_MASK, procdiv - 1));
> +	if (!ret)
> +		priv->cck_freq_actual =3D DIV_ROUND_CLOSEST(parent_rate, ratio);
> +
> +	return ret;
> +}
> +
> +static int stm32_mdf_core_cck_set_rate(struct clk_hw *hw, unsigned long =
rate,
> +				       unsigned long parent_rate)
> +{
> +	struct clk_mdf_cck *clk =3D to_clk_mdf_cck(hw);
> +	struct stm32_mdf_priv *priv =3D clk->priv;
> +
> +	return stm32_mdf_core_cck_divider_set_rate(priv->pdev, priv, rate, pare=
nt_rate);
> +}
> +
> +static int stm32_mdf_core_cck_determine_rate(struct clk_hw *hw,
> +					     struct clk_rate_request *req)
> +{
> +	struct clk_mdf_cck *clk =3D to_clk_mdf_cck(hw);
> +	struct stm32_mdf_priv *priv =3D clk->priv;
> +	struct platform_device *pdev =3D priv->pdev;
> +	unsigned long ratio;
> +
> +	if (!req->rate || req->rate > STM32_MDF_MAX_CCK_RATE || !req->best_pare=
nt_rate)
> +		return -EINVAL;
> +
> +	ratio =3D DIV_ROUND_CLOSEST(req->best_parent_rate, req->rate);
> +	if (!ratio) {
> +		dev_err(&pdev->dev, "CCK frequency above kernel frequency\n");
> +		return -EINVAL;
> +	}
> +
> +	req->rate =3D DIV_ROUND_CLOSEST(req->best_parent_rate, ratio);
> +
> +	return 0;
> +}

[Severity: High]
Does rounding req->rate in stm32_mdf_core_cck_determine_rate() bypass the
1000 ppm accuracy check and divider validation in
stm32_mdf_core_cck_divider_set_rate()?

During clk_set_rate(), clk_calc_new_rates() calls
stm32_mdf_core_cck_determine_rate() first and stores the rounded req->rate
in core->new_rate.  clk_change_rate() then passes that already-rounded
core->new_rate (not the caller's requested rate) to
stm32_mdf_core_cck_set_rate(), and ignores the return value of
core->ops->set_rate().  As a result:

- Inside stm32_mdf_core_cck_divider_set_rate(), rate is already
  DIV_ROUND_CLOSEST(parent_rate, ratio), so delta only measures the integer
  division remainder rather than the deviation from the requested frequency,
  defeating the 1000 ppm check.
- If procdiv > MDF_PROCDIV_MAX, stm32_mdf_core_cck_divider_set_rate()
  returns -EINVAL, which clk_change_rate() ignores; clk_set_rate() returns
  0 while MDF_CKGCR_REG and priv->cck_freq_actual remain unconfigured.

Also, in stm32_mdf_core_cck_divider_set_rate(), 1000000 * delta is computed
in unsigned long and overflows on 32-bit builds when delta >=3D 4295 Hz, and
priv->mdf.fproc is updated before checking whether regmap_update_bits()
succeeded.  Should the 1000 ppm and procdiv <=3D MDF_PROCDIV_MAX checks be
performed in stm32_mdf_core_cck_determine_rate() using 64-bit arithmetic?

[ ... ]

> +static inline u32 clk_cckx_gate_readl(struct clk_cckx_gate *gate)
> +{
> +	u32 val;
> +
> +	regmap_read(gate->map, gate->map_offset, &val);
> +
> +	return val;
> +}
> +
> +static inline void clk_cckx_gate_writel(struct clk_cckx_gate *gate, u32 =
val)
> +{
> +	regmap_write(gate->map, gate->map_offset, val);
> +}
> +
> +static void clk_cckx_gate_endisable(struct clk_hw *hw, int enable)
> +{
> +	struct clk_cckx_gate *gate =3D to_clk_cckx_gate(hw);
> +	unsigned long flags =3D 0;
> +	u32 reg;
> +
> +	if (gate->lock)
> +		spin_lock_irqsave(gate->lock, flags);
> +	else
> +		__acquire(gate->lock);
> +
> +	reg =3D clk_cckx_gate_readl(gate);
> +
> +	if (enable)
> +		reg |=3D BIT(gate->bit_idx);
> +	else
> +		reg &=3D ~BIT(gate->bit_idx);
> +
> +	clk_cckx_gate_writel(gate, reg);
> +
> +	if (gate->lock)
> +		spin_unlock_irqrestore(gate->lock, flags);
> +	else
> +		__release(gate->lock);
> +}
> +
> +static int clk_cckx_gate_enable(struct clk_hw *hw)
> +{
> +	clk_cckx_gate_endisable(hw, 1);
> +
> +	return 0;
> +}
> +
> +static void clk_cckx_gate_disable(struct clk_hw *hw)
> +{
> +	clk_cckx_gate_endisable(hw, 0);
> +}
> +
> +static int clk_cckx_gate_is_enabled(struct clk_hw *hw)
> +{
> +	struct clk_cckx_gate *gate =3D to_clk_cckx_gate(hw);
> +	u32 reg;
> +
> +	reg =3D clk_cckx_gate_readl(gate);
> +
> +	reg &=3D BIT(gate->bit_idx);
> +
> +	return reg ? 1 : 0;
> +}

[Severity: High]
Can calling regmap_read() and regmap_write() on priv->regmap inside
clk_cckx_gate_ops cause an ABBA deadlock with the clock framework's
enable_lock?

priv->regmap uses .fast_io =3D true (map->spinlock) and attaches priv->kclk
via regmap_mmio_attach_clk() in stm32_mdf_regmap_init().  Every hardware
access on priv->regmap acquires map->spinlock first and then calls
clk_enable(ctx->clk) in regmap_mmio_read()/regmap_mmio_write(), which takes
the CCF global enable_lock.  Conversely, CCF calls .enable, .disable and
.is_enabled in clk_cckx_gate_ops while already holding enable_lock:

CPU0                              CPU1
----                              ----
lock(&map->spinlock)
                                  lock(&enable_lock)
                                  lock(&map->spinlock)
lock(&enable_lock)

 *** DEADLOCK ***

CPU0: stm32_mdf_core_trigger() -> regmap_read() -> regmap_mmio_read() ->
      clk_enable()
CPU1: clk_enable() -> clk_cckx_gate_enable() -> clk_cckx_gate_endisable() ->
      regmap_read()

> +static const struct clk_ops clk_cckx_gate_ops =3D {
> +	.enable =3D clk_cckx_gate_enable,
> +	.disable =3D clk_cckx_gate_disable,
> +	.is_enabled =3D clk_cckx_gate_is_enabled,
> +};
> +
> +static struct clk_cckx_gate clk_cck0 =3D {
> +	.map_offset =3D MDF_CKGCR_REG,
> +	.bit_idx =3D 1,
> +};
> +
> +static struct clk_cckx_gate clk_cck1 =3D {
> +	.map_offset =3D MDF_CKGCR_REG,
> +	.bit_idx =3D 2,
> +};

[Severity: Medium]
Does clk_cckx_gate_endisable() perform an unlocked read-modify-write on
MDF_CKGCR_REG using an unchecked regmap_read()?

clk_cck0.lock and clk_cck1.lock are never initialized, so gate->lock is
always NULL and no lock is held between clk_cckx_gate_readl() and
clk_cckx_gate_writel().  A concurrent update to MDF_CKGCR_REG in
stm32_mdf_core_start_mdf(), stm32_mdf_core_stop_mdf() or
stm32_mdf_core_cck_divider_set_rate() can be overwritten with stale bits.
In addition, clk_cckx_gate_readl() leaves val uninitialized on the stack and
ignores the return value of regmap_read(), which would write uninitialized
stack data to MDF_CKGCR_REG if the read fails.

> +static int stm32_mdf_core_register_clock_provider(struct platform_device=
 *pdev,
> +						  struct stm32_mdf_priv *priv)
> +{
> +	struct device_node *node =3D pdev->dev.of_node;
> +	struct device *dev =3D &pdev->dev;
> +	struct clk_hw_onecell_data *clk_data;
> +	struct property *prop;
> +	const char *clk_name;
> +	u32 ckgcr =3D 0;
> +	int index =3D 0, ret, clk_id;
> +	struct clk_hw *mdf_hw[] =3D { &clk_cck0.hw, &clk_cck1.hw };
> +	struct clk_cckx_gate *gate;
> +
> +	clk_cck.hw.init =3D CLK_HW_INIT_PARENTS_DATA("clk_cck", clk_cck_parent_=
data,
> +						   &clk_cck_ops, 0);
> +	clk_cck0.hw.init =3D CLK_HW_INIT_HW(STM32_MDF_CCK0, &clk_cck.hw, &clk_c=
ckx_gate_ops,
> +					  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
> +	clk_cck1.hw.init =3D CLK_HW_INIT_HW(STM32_MDF_CCK1, &clk_cck.hw, &clk_c=
ckx_gate_ops,
> +					  CLK_SET_RATE_PARENT | CLK_IGNORE_UNUSED);
> +
> +	clk_cck.priv =3D priv;
> +
> +	ret =3D devm_clk_hw_register(dev, &clk_cck.hw);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to register clk_cck");
> +
> +	clk_data =3D devm_kzalloc(dev, struct_size(clk_data, hws, STM32_MDF_MAX=
_CCK), GFP_KERNEL);
> +	if (!clk_data)
> +		return -ENOMEM;
> +
> +	of_property_for_each_string(node, "clock-output-names", prop, clk_name)=
 {
> +		if (index >=3D STM32_MDF_MAX_CCK) {
> +			dev_err(dev, "Too many cck providers defined\n");
> +			return -EINVAL;
> +		}
> +
> +		if (!strncmp(clk_name, "cck0", 4)) {
> +			clk_id =3D 0;
> +		} else if (!strncmp(clk_name, "cck1", 4)) {
> +			clk_id =3D 1;
> +		} else {
> +			dev_err(dev, "Unexpected cck clock provider name [%s]\n", clk_name);
> +			return -EINVAL;
> +		}
> +
> +		gate =3D to_clk_cckx_gate(mdf_hw[clk_id]);
> +		gate->map =3D priv->regmap;
> +
> +		ret =3D devm_clk_hw_register(dev, mdf_hw[clk_id]);

[Severity: Medium]
Can static file-scope clk_cck, clk_cck0 and clk_cck1 structures and stack
compound literals in CLK_HW_INIT_* corrupt state or dereference NULL?

- CLK_HW_INIT_PARENTS_DATA() and CLK_HW_INIT_HW() create compound literal
  struct clk_init_data objects on stm32_mdf_core_register_clock_provider()'s
  stack.  __clk_register() only clears hw->init =3D NULL for clocks that are
  registered, so when clock-output-names lists fewer than two clocks, the
  unregistered global clk_cck0.hw.init or clk_cck1.hw.init pointer is left
  dangling into expired stack memory after this function returns.
- Conversely, if clock-output-names contains duplicate names (such as
  "cck1", "cck1"), the first devm_clk_hw_register() clears
  mdf_hw[clk_id]->init =3D NULL and the second call dereferences NULL at
  hw->init->name in __clk_register().
- Because clk_cck, clk_cck0 and clk_cck1 are file-scope static globals with
  fixed clock names, probing a second MDF instance overwrites clk_cck.priv
  and gate->map of the first instance and fails registration with -EEXIST.

> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to register %s clock provider",
> +					     clk_name);
> +
> +		clk_data->hws[index] =3D mdf_hw[clk_id];
> +
> +		/* Configure the CCKx clock as output */
> +		ckgcr |=3D clk_id ? MDF_CKG_CCK1DIR : MDF_CKG_CCK0DIR;
> +
> +		index++;
> +	}
> +
> +	/*
> +	 * Set num to max number of clock. This allows any clocks indice below =
maximum
> +	 * in of_clk_hw_onecell_get, whatever the actual number of providers.
> +	 */
> +	clk_data->num =3D STM32_MDF_MAX_CCK;
> +	ret =3D devm_of_clk_add_hw_provider(dev, of_clk_hw_onecell_get, clk_dat=
a);
> +	if (ret) {
> +		dev_err(dev, "Failed to add %s clock provider: %d\n",
> +			clk_name ? clk_name : "", ret);
> +		return ret;
> +	}

[Severity: High]
Does writing clk_data->hws[index] before setting clk_data->num violate the
__counted_by(num) annotation on struct clk_hw_onecell_data and mis-index
single-clock configurations?

struct clk_hw_onecell_data declares hws[] with __counted_by(num), so
writing to clk_data->hws[index] while clk_data->num is still 0 triggers a
UBSAN bounds violation when CONFIG_UBSAN_BOUNDS is enabled; clk_data->num
must be set before accessing clk_data->hws[].

In addition:

- Indexing clk_data->hws[] by sequential loop counter index instead of
  clk_id places clk_cck1 at hws[0] when clock-output-names only contains
  "cck1", and leaves unpopulated slots in hws[] as NULL (which
  of_clk_hw_onecell_get() returns as a dummy NULL clock rather than
  ERR_PTR(-ENOENT)).
- The DT binding allows #clock-cells =3D <0> when a single CCK output is
  used, in which case of_parse_clkspec() parses 0 arguments and
  of_clk_hw_onecell_get() reads clkspec->args[0] from uninitialized stack
  memory in of_clk_get_hw().
- After of_property_for_each_string() finishes, clk_name is always NULL, so
  the dev_err() message on devm_of_clk_add_hw_provider() failure always
  prints an empty name.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D3
