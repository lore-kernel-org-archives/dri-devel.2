Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA3606A32C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GXJTGz19
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18F7310FE22;
	Wed, 18 Nov 2026 15:55:33 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 249FF10E541
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:55:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0236B40DC9;
 Wed, 18 Nov 2026 15:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 868401F000C4;
 Wed, 18 Nov 2026 15:55:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795017326;
 bh=JbPTscy6XZXo8W16Ivu0imnpcVsF77/edhRp63Vu/UM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GXJTGz19LAjAtSyx2MzkxN0S/bgfvKKC1uKTGd4tN2gEOxqG5nTq9OiLJcWFVft/G
 CXWJ7oCOP24vSSfu9xNmOOIvL1r1L1OTBNFc4E5GtyVRPSq/biwqkYKwcae739iQIt
 VLy7JxHJrOFyYX6a43s4oijM1paBBrm6Rkr/cNOAq2j1c4PdaMHXkJ6OWvodx36VMy
 D0KqcM7w2ktySpaaDaw9cvYuOMCzdTahpdI81TRVlZ8Xe5ZhlB7e7c6mL0aollVSDf
 QW4VWYGPKDf+/MdXaGdpJcm+6rzPoVjBJ9ZyPLpJ3i2S0YhBaBMwG39ZJY3QnLzFq6
 vxLAWMOlUdO7A==
Message-ID: <sashiko-outbox-221387@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/11] iio: adc: stm32-mdf: add dma buffered
 acquisition support
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-8-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-8-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:55:26 +0000
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

Thank you for your contribution! Sashiko AI review found 9 potential
issues to consider:
- [High] iio: adc: stm32-mdf: no-op W1C clear in stm32_mdf_irq() causes
  IRQ storm
- [High] iio: adc: stm32-mdf: broken interleaved suspend and resume
  ordering
- [High] iio: adc: stm32-mdf: NULL thread_fn in
  devm_iio_triggered_buffer_setup()
- [Medium] iio: adc: stm32-mdf: wrong W1C clear in
  stm32_mdf_adc_postenable()
- [Medium] iio: adc: stm32-mdf: uncleaned IRQs on error in
  stm32_mdf_adc_postenable()
- [Medium] iio: adc: stm32-mdf: unbalanced kclk prepare in
  stm32_mdf_adc_suspend()
- [Medium] iio: adc: stm32-mdf: zero-size cb on wrap in
  stm32_mdf_adc_dma_buffer_done()
- [Medium] iio: adc: stm32-mdf: missing available_scan_masks for
  interleaved mode
- [Low] iio: adc: stm32-mdf: unused PM callbacks when CONFIG_PM_SLEEP is
  disabled
--

commit abc251af1764611faf8f05bc9f73b60d34b2ef36
Author: Olivier Moysan <olivier.moysan@foss.st.com>

iio: adc: stm32-mdf: add dma buffered acquisition support

This commit adds cyclic DMA buffered acquisition, watermark configuration,
and system suspend/resume support to the STM32 MDF ADC driver.

> diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-=
adc.c
> index 7361ce6182bec..046ca3943a397 100644
> --- a/drivers/iio/adc/stm32-mdf-adc.c
> +++ b/drivers/iio/adc/stm32-mdf-adc.c
> @@ -823,6 +823,243 @@ static void stm32_mdf_adc_stop_conv(struct iio_dev =
*indio_dev)
[ ... ]
> +static void stm32_mdf_adc_dma_buffer_done(void *data)
> +{
> +	struct iio_dev *indio_dev =3D data;
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	int available =3D stm32_mdf_adc_dma_residue(adc);
> +	size_t old_pos;
> +
> +	dev_dbg(&indio_dev->dev, "pos =3D %d, available =3D %d\n", adc->bufi, a=
vailable);
> +	old_pos =3D adc->bufi;
> +
> +	while (available >=3D indio_dev->scan_bytes) {
> +		s32 *buffer =3D (s32 *)&adc->rx_buf[adc->bufi];
> +
> +		adc->bufi +=3D indio_dev->scan_bytes;
> +		if (adc->bufi >=3D adc->buf_sz) {
> +			if (adc->cb)
> +				adc->cb(&adc->rx_buf[old_pos], adc->buf_sz - old_pos, adc->cb_priv);
> +			adc->bufi =3D 0;
> +			old_pos =3D 0;
> +		}
> +		if (adc->dev_data->type =3D=3D STM32_MDF_IIO)
> +			iio_push_to_buffers(indio_dev, buffer);
> +		available -=3D indio_dev->scan_bytes;
> +	}

[Severity: Medium]
In multi-channel interleaved mode on Filter 0, hardware and DMA always
transfer all num_ch 32-bit samples per scan into adc->rx_buf, but
stm32_mdf_adc_init() never sets indio_dev->available_scan_masks.  If a
user enables only a subset of channels in scan_elements, does stepping
adc->bufi by the smaller indio_dev->scan_bytes without an IIO demux table
push samples from disabled interleaved filters as if they belonged to the
enabled channel?

> +	if (adc->cb)
> +		adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos, adc->cb_priv);
> +}

[Severity: Medium]
When adc->bufi wraps around to 0 at adc->buf_sz inside the loop, both
adc->bufi and old_pos are reset to 0 after invoking adc->cb().  Does this
trailing check then call adc->cb() a second time with a size of 0 on every
buffer wrap-around (and whenever available < indio_dev->scan_bytes)?

[ ... ]

> +static int stm32_mdf_adc_postenable(struct iio_dev *indio_dev)
> +{
[ ... ]
> +	stm32_mdf_adc_filter_set_mode(adc, true);
> +
> +	regmap_clear_bits(adc->regmap, MDF_DFLTISR_REG,
> +			  MDF_DFLTISR_DOVRF_MASK | MDF_DFLTISR_SATF_MASK);

[Severity: Medium]
Status flags in MDF_DFLTISR_REG are write-1-to-clear (rc_w1).  Because
MDF_DFLTISR_REG is volatile, regmap_clear_bits() reads the register and
writes back the value with MDF_DFLTISR_DOVRF_MASK | MDF_DFLTISR_SATF_MASK
masked to 0.  Does this leave pending DOVRF and SATF flags asserted right
before enabling their interrupts, while inadvertently writing 1 to clear
any other asserted status flags in MDF_DFLTISR_REG?  Clearing DOVRF and
SATF requires regmap_write().

> +
> +	regmap_set_bits(adc->regmap, MDF_DFLTIER_REG,
> +			MDF_DFLTIER_DOVRIE_MASK | MDF_DFLTIER_SATIE_MASK);

[Severity: High]
Enabling MDF_DFLTIER_DOVRIE_MASK and MDF_DFLTIER_SATIE_MASK here makes the
overflow and saturation handlers in stm32_mdf_irq() reachable:

drivers/iio/adc/stm32-mdf-adc.c:stm32_mdf_irq() {
    ...
	if (flags & MDF_DFLTISR_DOVRF_MASK) {
		dev_warn(&indio_dev->dev, "Data overflow detected\n");
		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_DOVRF_MASK);
	}
    ...
	if (flags & MDF_DFLTISR_SATF_MASK) {
		dev_warn(&indio_dev->dev, "Saturation detected\n");
		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_SATF_MASK);
    ...
}

Because MDF_DFLTISR_REG is volatile and regmap_set_bits() passes
force =3D false, _regmap_update_bits() reads MDF_DFLTISR_REG, sees the
status bit is already 1, and skips the bus write.  If a data overflow
occurs during DMA acquisition, will MDF_DFLTISR_DOVRF_MASK remain set
while MDF_DFLTIER_DOVRIE_MASK stays enabled, causing an infinite hardirq
storm?

> +
> +	ret =3D stm32_mdf_adc_dma_start(indio_dev);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Can't start DMA\n");
> +		goto err_dma;
> +	}
> +
> +	ret =3D stm32_mdf_adc_start_conv(indio_dev);
> +	if (ret) {
> +		dev_err(&indio_dev->dev, "Can't start conversion\n");
> +		goto err_conv;
> +	}
> +
> +	return 0;
> +
> +err_conv:
> +	stm32_mdf_adc_dma_stop(indio_dev);
> +err_dma:
> +	stm32_mdf_adc_stop_mdf(indio_dev);

[Severity: Medium]
If stm32_mdf_adc_dma_start() or stm32_mdf_adc_start_conv() fails (for
example, when adc->buf_sz is 0), does the err_dma unwind path leave
MDF_DFLTIER_DOVRIE_MASK | MDF_DFLTIER_SATIE_MASK enabled in
MDF_DFLTIER_REG?

[ ... ]

> @@ -1208,6 +1467,24 @@ static int stm32_mdf_adc_init(struct device *dev, =
struct iio_dev *indio_dev)
> =20
>  	init_completion(&adc->completion);
> =20
> +	/* Optionally request DMA */
> +	ret =3D stm32_mdf_dma_request(dev, indio_dev);
> +	if (ret) {
> +		if (ret !=3D -ENODEV)
> +			return dev_err_probe(dev, ret, "DMA channel request failed with\n");
> +
> +		dev_dbg(dev, "No DMA support\n");
> +		return 0;
> +	}
> +
> +	ret =3D devm_iio_triggered_buffer_setup(dev, indio_dev,
> +					      &iio_pollfunc_store_time, NULL,
> +					      &stm32_mdf_buffer_setup_ops);

[Severity: High]
Can attaching an IIO trigger and enabling the buffer crash or wedge the
kernel here?

devm_iio_triggered_buffer_setup() sets INDIO_BUFFER_TRIGGERED and
allocates indio_dev->pollfunc with h =3D iio_pollfunc_store_time,
thread =3D NULL, and type =3D IRQF_ONESHOT.  When a trigger is attached and
the buffer is enabled, iio_verify_update() selects INDIO_BUFFER_TRIGGERED
over INDIO_BUFFER_SOFTWARE and iio_trigger_attach_poll_func() calls
request_threaded_irq() with IRQF_ONESHOT and thread_fn =3D NULL, hitting
WARN_ON_ONCE(new->flags & IRQF_ONESHOT && !new->thread_fn) in
__setup_irq().  When the trigger fires, a nested trigger such as
iio-trig-loop dereferences NULL action->thread_fn in handle_nested_irq(),
while a non-nested trigger such as iio-trig-sysfs or iio-trig-hrtimer
returns IRQ_WAKE_THREAD with no thread_fn, hitting warn_no_thread() and
never calling iio_trigger_notify_done().

The follow-up commit "iio: adc: stm32-mdf: add external timer trigger
support" adds INDIO_HARDWARE_TRIGGERED and .validate_trigger, but keeps
devm_iio_triggered_buffer_setup() with a NULL thread_fn, so
INDIO_BUFFER_TRIGGERED is still selected whenever indio_dev->trig is set.
Since samples are pushed from the DMA callback and external triggers are
routed in hardware, should this use devm_iio_kfifo_buffer_setup() (and
select IIO_KFIFO_BUF in Kconfig) instead of
devm_iio_triggered_buffer_setup()?

[ ... ]

> @@ -1479,14 +1758,48 @@ static void stm32_mdf_adc_remove(struct platform_=
device *pdev)
[ ... ]
> +static int stm32_mdf_adc_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	if (iio_buffer_enabled(indio_dev))
> +		ret =3D stm32_mdf_adc_predisable(indio_dev);
> +
> +	regcache_cache_only(adc->regmap, true);
> +	regcache_mark_dirty(adc->regmap);\n+
> +	return ret;
> +}

[Severity: Medium]
stm32_mdf_adc_probe() attaches adc->mdf->kclk to adc->regmap via
stm32_mdf_regmap_init() -> regmap_mmio_attach_clk(), which holds a
clk_prepare() reference on kclk.  In stm32_mdf_core_suspend(), the parent
driver unprepares kclk only for sitf_list and the core regmap, not for
filter regmaps.  Should stm32_mdf_adc_suspend() and stm32_mdf_adc_resume()
also unprepare and re-prepare adc->mdf->kclk so kclk does not stay
prepared across system suspend?

> +
> +static int stm32_mdf_adc_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev =3D dev_get_drvdata(dev);
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	regcache_cache_only(adc->regmap, false);
> +	ret =3D regcache_sync(adc->regmap);
> +
> +	if (!ret && iio_buffer_enabled(indio_dev))
> +		ret =3D stm32_mdf_adc_postenable(indio_dev);
> +
> +	return ret;
> +}

[Severity: High]
How does suspend and resume work when interleaved (or synchronized)
filters are active?

In interleaved mode, only Filter 0 registers an IIO device, so
iio_buffer_enabled() is only ever true on Filter 0, while Filter 0 starts
and stops subordinate filters (Filters 1..N-1) by iterating
mdf->filter_list.  Because child devices suspend in reverse probe order
and resume in forward probe order:

1. On suspend, Filters N-1..1 run stm32_mdf_adc_suspend() before Filter 0
   and set regcache_cache_only(adc_inter->regmap, true).  When Filter 0
   then calls stm32_mdf_adc_predisable() -> stm32_mdf_adc_stop_filter(),
   clearing MDF_DFLTCR_DFLTEN on adc_inter->regmap only updates the cache
   and does not stop Filters 1..N-1 in hardware.

2. On resume, Filter 0 runs stm32_mdf_adc_resume() ->
   stm32_mdf_adc_postenable() before Filters 1..N-1 have cleared
   cache_only on their regmaps:

drivers/iio/adc/stm32-mdf-adc.c:stm32_mdf_adc_start_filter() {
    ...
	if (MDF_IS_FILTER0(adc))
		list_for_each_entry(adc_inter, &mdf->filter_list, entry)
			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
				stm32_mdf_adc_start_filter(adc_inter);

	/* Check filter status. Bypass cache to access volatile MDF_DFLTCR_ACTIVE =
bit */
	regcache_cache_bypass(adc->regmap, true);
	regmap_read(adc->regmap, MDF_DFLTCR_REG, &val);
	regcache_cache_bypass(adc->regmap, false);
    ...
}

   Calling stm32_mdf_adc_start_filter(adc_inter) while adc_inter->regmap
   is still cache-only triggers WARN_ON(map->cache_only && enable) in
   regcache_cache_bypass(), causes regmap_read() to fail with -EBUSY
   leaving val uninitialized on the stack, traps filter configuration and
   MDF_DFLTCR_DFLTEN writes in cache, and pulses MDF_GCR_TRGO before
   subordinate interleaved (or st,sync slave) filters have resumed in
   hardware.

In addition, stm32_mdf_adc_init() requests a DMA channel, 16 KB coherent
buffer, and triggered IIO buffer even for MDF_IS_INTERLEAVED_FILT_NOT_0()
filters that never register an IIO device.

> +
> +static SIMPLE_DEV_PM_OPS(stm32_mdf_adc_pm_ops, stm32_mdf_adc_suspend, st=
m32_mdf_adc_resume);
> +
>  static struct platform_driver stm32_mdf_adc_driver =3D {
>  	.driver =3D {
>  		.name =3D "stm32-mdf-adc",
>  		.of_match_table =3D stm32_mdf_adc_match,
> +		.pm =3D &stm32_mdf_adc_pm_ops,
>  	},

[Severity: Low]
When CONFIG_PM_SLEEP is disabled, SIMPLE_DEV_PM_OPS() leaves
stm32_mdf_adc_suspend() and stm32_mdf_adc_resume() unused, producing
-Wunused-function warnings.  Could this use DEFINE_SIMPLE_DEV_PM_OPS() and
pm_sleep_ptr(&stm32_mdf_adc_pm_ops) instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D8
