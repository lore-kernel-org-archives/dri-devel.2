Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD8ECA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 15:16:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EF5210F6D9;
	Thu,  1 Oct 2026 15:16:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fnuR1zgV";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C5AB710F6D9
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 15:16:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4847240648;
 Thu,  1 Oct 2026 15:16:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F39CD1F000FF;
 Thu,  1 Oct 2026 15:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790867811;
 bh=RUjEDmZnwRB1ypBhZCH/z/8Ofg8faxkU2peSdfOzHwE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fnuR1zgVNn9nNtHIqYHtR25YRCcmQeWogveQ6dkdsxCHDf2jjhVwu+DEZqNaXnkS2
 z9B1Cvc+h24fNVVgv2DJpakV5lx+IUrhYBNzI5dzVWQgdZE4umhCTe9zZaZfZW3XPF
 xGAJNof5w/+qZ8iaEy4O6rFIQ6yCuw3EcIxCDymW1KnVrNC6Rt/RZybh3e73pG/5Oc
 ZfCy4wxLiAW8Z4bJkPHA9TcGVnSqBj85X3bWmvz35oCzf6+ZPmwuxN21nnkCesPOh/
 lMp1TKoaLNrdkfRjqaSxXMyUMXjjacCW2O3SU9pL90IY2A6I8wp5SYVkJBmyCZ1fgr
 38qeqy0c5TXrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] iio: adc: add stm32 mdf support
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: dri-devel@lists.freedesktop.org, media-ci@linuxtv.org
In-Reply-To: <20261001145702.2628429-3-olivier.moysan@foss.st.com>
References: <20261001145702.2628429-1-olivier.moysan@foss.st.com>
 <20261001145702.2628429-3-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 15:16:50 +0000
Message-Id: <20261001151650.F39CD1F000FF@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 20 potential issue=
(s) to consider:
- [High] mm: memory leak of adc->buffer on teardown
- [High] stm32-mdf: race condition in MDF core startup and clock locking
- [High] iio: adc: heap overflow in adc->channels allocation
- [High] iio: adc: triggered buffer resources leaked on removal
- [High] iio: adc: misaligned cyclic DMA buffer size causes OOB read
- [High] iio: adc: unbalanced iio_device_unregister on error path
- [High] stm32-mdf: UAF in IRQ from unprotected list_for_each_entry
- [High] stm32-mdf: dangling sitf pointer on unbind (Use-After-Free)
- [High] stm32-mdf-core: lockless RMW corrupts hardware state in clk_cckx_g=
ate_endisable
- [High] iio: adc: TOCTOU race on adc->cb causes NULL pointer deref
- [High] stm32-mdf: interleaved SITFs fail to start
- [Medium] of: resource leak of fwnode references
- [Medium] iio: adc: uninitialized channels exposed to subsystem
- [Medium] stm32-mdf-serial: clock reference leak on unbind
- [Medium] iio: adc: off-by-one error leaks first backend on error path
- [Medium] iio: adc: 32-bit overflow when computing settling time discard c=
ount
- [Medium] stm32-mdf-core: rigid gcd() restricts cckdiv to powers of 2
- [Medium] stm32-mdf-core: clk_rate_exclusive_get error ignored
- [Low] kconfig: selecting non-existent COMMON_CLK_REGMAP
- [Low] pm: missing pm_ptr() macro wrapper causes dead code
--

commit b396898f85019ba218650a01b961b3f92e6b164b
Author: Olivier Moysan <olivier.moysan@foss.st.com>
Subject: iio: adc: add stm32 mdf support

This commit introduces the STM32 Multi-function Digital Filter (MDF) core,
serial interface, and digital filter drivers. It supports converting bitstr=
eams
from sigma-delta modulators or digital microphones into samples via IIO.

> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
[ ... ]
> +config STM32_MDF_ADC
> +	tristate "STMicroelectronics STM32 MDF adc"
> +	depends on (ARCH_STM32 && OF) || COMPILE_TEST
> +	select STM32_MDF_CORE
> +	select COMMON_CLK_REGMAP

[Severity: Low]
This isn't a bug, but COMMON_CLK_REGMAP does not appear to exist in the
kernel tree. Does selecting an undeclared config symbol cause unmet depende=
ncy
issues during build?

> diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-=
adc.c
[ ... ]
> +static int mdf_adc_set_samp_freq(struct iio_dev *indio_dev)
> +{
[ ... ]
> +	adc->nbdis =3D DIV_ROUND_UP(adc->stu * sample_freq, 1000000);

[Severity: Medium]
Could this multiplication overflow on 32-bit architectures? Both variables
are 32-bit types, so a large settling time (e.g., 100ms) and sample frequen=
cy
(48kHz) might exceed U32_MAX before the division.

[ ... ]
> +static int stm32_mdf_adc_start_conv(struct iio_dev *indio_dev)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D stm32_mdf_sitf_start(adc->sitf);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D stm32_mdf_adc_start_filter(adc);

[Severity: High]
Are the serial interfaces for interleaved instances omitted here? The start
process cascades to interleaved filters via stm32_mdf_adc_start_filter(),
but it seems we only ever call stm32_mdf_sitf_start() on the primary
adc->sitf.

[ ... ]
> +static void stm32_mdf_adc_dma_buffer_done(void *data)
> +{
> +	struct iio_dev *indio_dev =3D data;
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	int available =3D stm32_mdf_adc_dma_residue(adc);
> +	size_t old_pos;
[ ... ]
> +	while (available >=3D indio_dev->scan_bytes) {
> +		s32 *buffer =3D (s32 *)&adc->rx_buf[adc->bufi];
> +
> +		adc->bufi +=3D indio_dev->scan_bytes;
> +		if (adc->bufi >=3D adc->buf_sz) {

[Severity: High]
Is it possible for adc->bufi to overshoot adc->buf_sz without hitting it
exactly? Since adc->buf_sz in stm32_mdf_set_watermark() is calculated
based on sizeof(u32), if scan_bytes is not a multiple of sizeof(u32), this
loop might read out of bounds of the physical allocation before wrapping
around.

> +			if (adc->cb)
> +				adc->cb(&adc->rx_buf[old_pos], adc->buf_sz - old_pos, adc->cb_priv);

[Severity: High]
Is this vulnerable to a race condition? If an external consumer concurrently
calls stm32_mdf_release_buff_cb() and clears adc->cb and adc->cb_priv
without locks, the callback might be evaluated as non-NULL but executed as
NULL, or executed with a NULL cb_priv.

[ ... ]
> +static irqreturn_t stm32_mdf_irq(int irq, void *arg)
> +{
[ ... ]
> +	if (flags & MDF_DFLTISR_FTHF_MASK) {
> +		/* Reading the data register clear the IRQ status */
> +		regmap_read(regmap, MDF_DFLTDR_REG, ptr++);
> +
> +		if (MDF_IS_FILTER0(adc))
> +			list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry)

[Severity: High]
Could this list traversal crash the kernel if the list is mutated
concurrently? The interrupt handler iterates adc->mdf->filter_list while
stm32_mdf_adc_remove() performs list_del(&adc->entry) without locks or
RCU primitives.

[ ... ]
> +static int stm32_mdf_get_sitf(struct device *dev, struct stm32_mdf_adc *=
adc,
> +			      struct fwnode_handle *sitf_node)
> +{
> +	struct stm32_mdf_sitf *sitf;
> +
> +	/* Look for sitf interface from node handle */
> +	list_for_each_entry(sitf, &adc->mdf->sitf_list, entry) {
> +		if (sitf->node =3D=3D sitf_node) {
> +			adc->sitf =3D sitf;
> +			break;
> +		}
> +	}

[Severity: High]
Is there a risk of a Use-After-Free if the sibling sitf device is unbound?
The ADC driver stores a raw pointer to sitf (allocated via devm_kzalloc
by the sibling device) without establishing a device link or reference coun=
t.

[ ... ]
> +static int stm32_mdf_adc_postenable(struct iio_dev *indio_dev)
> +{
[ ... ]
> +	while (adc->channels[i].backend && i < indio_dev->num_channels) {
> +		ret =3D iio_backend_enable(adc->channels[i].backend);
> +		if (ret < 0) {
> +			while (--i > 0)
> +				iio_backend_disable(adc->channels[i].backend);

[Severity: Medium]
Does this loop completely miss disabling the backend at index 0? If
iio_backend_enable() fails when i =3D 1, the decrement evaluates to 0,
stopping the loop before it can disable adc->channels[0].backend.

[ ... ]
> +static int stm32_mdf_audio_init(struct device *dev, struct iio_dev *indi=
o_dev)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	struct iio_chan_spec *ch;
> +	int ret;
> +
> +	ch =3D devm_kzalloc(&indio_dev->dev, sizeof(*ch), GFP_KERNEL);
> +	if (!ch)
> +		return -ENOMEM;
> +
> +	adc->channels =3D devm_kzalloc(&indio_dev->dev, sizeof(*adc->channels),=
 GFP_KERNEL);
> +	if (!adc->channels)
> +		return -ENOMEM;
> +
> +	ret =3D stm32_mdf_adc_chan_init(indio_dev, ch);

[Severity: High]
Can this cause a heap overflow? The ch and adc->channels arrays are
allocated with exactly one element, but stm32_mdf_adc_chan_init() iterates
over all child nodes lacking a "compatible" string. If more than one such
node exists in the device tree, it will write out of bounds.

[ ... ]
> +static int stm32_mdf_adc_init(struct device *dev, struct iio_dev *indio_=
dev)
> +{
[ ... ]
> +	indio_dev->num_channels =3D num_ch;
> +	indio_dev->channels =3D ch;

[Severity: Medium]
Are we exposing uninitialized trailing channels here? While num_ch is the
total count of child nodes, stm32_mdf_adc_chan_init() skips nodes containing
a "compatible" string, resulting in fewer initialized channels than num_ch.

[ ... ]
> +	ret =3D iio_triggered_buffer_setup(indio_dev,
> +					 &iio_pollfunc_store_time, NULL,
> +					 &stm32_mdf_buffer_setup_ops);

[Severity: High]
Does this leak the triggered buffer and pollfunc on unbind? The manual
setup here lacks a corresponding iio_triggered_buffer_cleanup() call in
stm32_mdf_adc_remove(). Using devm_iio_triggered_buffer_setup() might
resolve this.

[ ... ]
> +static int stm32_mdf_adc_parse_of(struct platform_device *pdev, struct s=
tm32_mdf_adc *adc)
> +{
[ ... ]
> +	if (device_property_present(&pdev->dev, "st,sync")) {
> +		filt_node =3D fwnode_find_reference(dev_fwnode(dev), "st,sync", 0);
[ ... ]
> +	adc->buffer =3D kcalloc(buf_size, sizeof(u32), GFP_KERNEL);
> +	if (!adc->buffer)
> +		return -ENOMEM;
> +
> +	/* Retrieve serial interface */
> +	ret =3D fwnode_property_get_reference_args(dev_fwnode(dev), "st,sitf", =
NULL, 1, 0, &args);

[Severity: High]
Are the memory for adc->buffer and the fwnode references leaked on teardown?
The buffer is allocated with a non-managed kcalloc and never released in
stm32_mdf_adc_remove().

[Severity: Medium]
Additionally, both fwnode_find_reference() and
fwnode_property_get_reference_args() increment the node reference counts,
but they appear to be discarded without a corresponding fwnode_handle_put()
anywhere.

[ ... ]
> +static int stm32_mdf_adc_probe(struct platform_device *pdev)
> +{
[ ... ]
> +	if (dev_data->type =3D=3D STM32_MDF_AUDIO) {
> +		ret =3D of_platform_populate(node, NULL, NULL, dev);
> +		if (ret < 0) {
> +			dev_err_probe(dev, ret, "Failed to find an audio DAI\n");
> +			goto err_unregister;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_unregister:
> +	iio_device_unregister(iio);

[Severity: High]
Could this lead to an unbalanced unregister call? Interleaved filters
(other than 0) intentionally bypass iio_device_register(), so jumping to
err_unregister here would call iio_device_unregister() on a device that
was never registered.

[ ... ]
> +static struct platform_driver stm32_mdf_adc_driver =3D {
> +	.driver =3D {
> +		.name =3D "stm32-mdf-adc",
> +		.of_match_table =3D stm32_mdf_adc_match,
> +		.pm =3D &stm32_mdf_adc_pm_ops,
> +	},

[Severity: Low]
Should the PM ops be wrapped with the pm_ptr() macro? Unconditional
assignment leads to the PM structure and callbacks becoming dead code when
CONFIG_PM is disabled. This pattern is also present in stm32_mdf_driver and
stm32_mdf_sitf_driver.

> diff --git a/drivers/iio/adc/stm32-mdf-core.c b/drivers/iio/adc/stm32-mdf=
-core.c
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

[Severity: High]
Is this vulnerable to a race condition? If there are concurrent callers,
the first one enters the block to power on the hardware, but the second one
skips the block (since the atomic counter is > 1) and will return
immediately, potentially accessing powered-off hardware before the first
caller finishes.

[ ... ]
> +		if (!priv->exclusive_flg) {
> +			clk_rate_exclusive_get(priv->kclk);
> +			priv->exclusive_flg =3D true;
> +		}

[Severity: Medium]
Should the return value of clk_rate_exclusive_get() be checked? If the lock
fails but priv->exclusive_flg is set to true, a subsequent
clk_rate_exclusive_put() could lead to an unbalanced clock rate lock.

[ ... ]
> +int stm32_mdf_core_stop_mdf(struct stm32_mdf *mdf)
> +{
> +	struct stm32_mdf_priv *priv =3D to_stm32_mdf_priv(mdf);
> +	int ret =3D 0;
> +
> +	if (atomic_dec_and_test(&priv->n_active_ch)) {

[Severity: High]
Similar to the start function, does this need locking to prevent racing
with concurrent starts?

[ ... ]
> +static int stm32_mdf_core_cck_divider_set_rate(struct platform_device *p=
dev,
> +					       struct stm32_mdf_priv *priv,
> +					       unsigned long parent_rate)
> +{
[ ... ]
> +	cckdiv =3D gcd(ratio, MDF_CKG_CCKDIV_MAX);
> +	procdiv =3D ratio / cckdiv;

[Severity: Medium]
Because MDF_CKG_CCKDIV_MAX (16) is a power of 2, doesn't gcd(ratio, 16)
erroneously restrict the resulting cckdiv strictly to powers of 2 (1, 2,
4, 8, 16)? If a valid clock configuration actually required cckdiv to be 9,
this would compute 1 instead and could unnecessarily overflow procdiv.

[ ... ]
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

[Severity: High]
Is gate->lock ever initialized? Since clk_cck0 and clk_cck1 statically
zero-initialize their contents, gate->lock is NULL and this falls back to
the empty __acquire annotation. This causes a non-atomic read-modify-write
on MDF_CKGCR_REG that bypasses regmap's internal locking and will corrupt
concurrent updates from regmap_set_bits().

[ ... ]
> +static int stm32_mdf_core_parse_of(struct platform_device *pdev, struct =
stm32_mdf_priv *priv)
> +{
[ ... ]
> +		for (i =3D 0; i < count; i++) {
> +			handle =3D fwnode_find_reference(fwnode, "st,interleave", i);
> +			if (IS_ERR(handle)) {
> +				dev_err(dev, "Failed to read filter handle: %ld\n",
> +					PTR_ERR(handle));
> +				return PTR_ERR(handle);
> +			}
> +			priv->mdf.fh_interleave[i] =3D handle;
> +		}

[Severity: Medium]
These fwnode references are stored in the fh_interleave array, but they
don't seem to be released with fwnode_handle_put() anywhere on the
teardown path, which leads to reference leaks.

> diff --git a/drivers/iio/adc/stm32-mdf-serial.c b/drivers/iio/adc/stm32-m=
df-serial.c
[ ... ]
> +static int stm32_mdf_sitf_get_clk(struct device *dev, struct stm32_mdf_s=
itf *sitf)
> +{
> +	struct clk *sck;
> +
> +	/* Optional clock. Clock not needed in Manchester mode */
> +	sck =3D clk_get_optional(sitf->dev, 0);

[Severity: Medium]
Does this leak the clock reference on unbind? The reference is acquired
manually with clk_get_optional() but there is no corresponding clk_put() in
stm32_mdf_sitf_remove(). Switching to devm_clk_get_optional() could
prevent this.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001145702.2628=
429-1-olivier.moysan@foss.st.com?part=3D2
