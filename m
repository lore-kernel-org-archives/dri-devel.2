Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01C6606A336
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qq4W8QR0
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 266C410E824;
	Wed, 18 Nov 2026 15:51:47 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCF1110FDD0
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:51:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id BEDEE43BBC;
 Wed, 18 Nov 2026 15:51:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6EE1F000C7;
 Wed, 18 Nov 2026 15:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795017100;
 bh=Aex+3gN0Z3NwJ0XBJSl1rpMND+szMKApjxoJ1G/Dzz8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Qq4W8QR0E2vaCBoQa/UHqg/0iW4qCLpmKMn3k8fCKBP/840IBxEbacxQUWsmuzYpL
 OH8K5zZHKjBtOPq9vl0vHbVpa4tUdM/XqRnOvkWgExQWV8+TaIHugGuyf0Tf9X2HET
 0apZ8dmMoR89m+0l9MNhNDTeeh2I8PEDUg+Z+4ihcMngJ5M9YjLrTW1i+7QnSz/SUJ
 hSZ5PPIQGwJz81LvOYQwa5RfDHiVTc3l4vXkCf8k3dEPJyeAnpNp6fUUshYa8aFvRw
 7LcO1z4KVXbw1uHMEuBSyKiy4Jaib4foKNwcLWfv5721NW+W3D6OAyHEzFkyOPcoAA
 DzplNHzNk6qcQ==
Message-ID: <sashiko-outbox-221382@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/11] iio: adc: stm32-mdf: add direct iio conversion
 support
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-7-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-7-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:51:39 +0000
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

Thank you for your contribution! Sashiko AI review found 15 potential
issues to consider:
- [High] iio: adc: stm32-mdf: divide by zero in stm32_mdf_adc_read_raw()
  on scale read
- [High] iio: adc: stm32-mdf: unshifted raw sample in
  stm32_mdf_adc_single_conv()
- [High] iio: adc: stm32-mdf: divide by zero in
  stm32_mdf_adc_check_clock_config()
- [High] iio: adc: stm32-mdf: wrong regmap and filter order in
  stm32_mdf_irq()
- [High] iio: adc: stm32-mdf: wrong consumer device in
  stm32_mdf_channel_parse_of()
- [Medium] iio: adc: stm32-mdf: W1C status bits not cleared in
  stm32_mdf_irq()
- [Medium] iio: adc: stm32-mdf: divide by zero in
  mdf_adc_set_samp_freq() on bad rate
- [Medium] iio: adc: stm32-mdf: out-of-bounds buffer read in
  stm32_mdf_adc_single_conv()
- [Medium] iio: adc: stm32-mdf: premature IRQ registration in
  stm32_mdf_adc_probe()
- [Medium] iio: adc: stm32-mdf: missing error handling in
  stm32_mdf_adc_start_filter()
- [Medium] iio: adc: stm32-mdf: channel count mismatch in
  stm32_mdf_adc_init()
- [Medium] iio: adc: stm32-mdf: unlocked requested_sample_freq reset in
  write_raw()
- [Medium] iio: adc: stm32-mdf: kclk exclusivity and n_active_ch race
  across filters
- [Medium] iio: adc: stm32-mdf: unsynchronized mdf->filter_list access
  and removal
- [Medium] iio: adc: stm32-mdf: wrong bitmask for datsrc in
  apply_filters_config()
--

commit 2d5ac177e0b4a7ad327bdcde3015713c0361e50e
Author: Olivier Moysan <olivier.moysan@foss.st.com>

iio: adc: stm32-mdf: add direct iio conversion support

This commit adds single-shot IIO direct conversion support, channel and
backend initialization, interrupt handling, and raw/scale/offset/frequency
sysfs accessors to the STM32 MDF ADC driver.

> diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-=
adc.c
> index eae7a4fa14851..7361ce6182bec 100644
> --- a/drivers/iio/adc/stm32-mdf-adc.c
> +++ b/drivers/iio/adc/stm32-mdf-adc.c
> @@ -329,6 +329,79 @@ static struct stm32_mdf_adc *stm32_mdf_get_filter_by=
_handle(struct stm32_mdf *md
>  	return NULL;
>  }
> =20
> +static int stm32_mdf_adc_start_filter(struct stm32_mdf_adc *adc)
> +{
> +	struct stm32_mdf_adc *adc_inter;
> +	struct stm32_mdf *mdf =3D adc->mdf;
> +	u32 val;
> +
> +	if (MDF_IS_FILTER0(adc))
> +		list_for_each_entry(adc_inter, &mdf->filter_list, entry)
> +			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
> +				stm32_mdf_adc_start_filter(adc_inter);
> +
> +	/* Check filter status. Bypass cache to access volatile MDF_DFLTCR_ACTI=
VE bit */
> +	regcache_cache_bypass(adc->regmap, true);
> +	regmap_read(adc->regmap, MDF_DFLTCR_REG, &val);
> +	regcache_cache_bypass(adc->regmap, false);
> +	if (val & MDF_DFLTCR_ACTIVE) {
> +		dev_err(adc->dev, "Filter [%d] is already running\n", adc->fl_id);
> +		return -EBUSY;
> +	}
> +
> +	return regmap_set_bits(adc->regmap, MDF_DFLTCR_REG, MDF_DFLTCR_DFLTEN);
> +}

[Severity: Medium]
Does stm32_mdf_adc_start_filter() ignore errors from starting interleaved
filters and leave already-started sibling filters enabled if filter 0 is
busy?

When stm32_mdf_adc_start_conv() sees an error from
stm32_mdf_adc_start_filter(), it jumps to stop_sitf without stopping any
secondary interleaved filters that were just enabled.
stm32_mdf_adc_filter_set_mode() and its caller stm32_mdf_adc_single_conv()
similarly ignore errors when configuring the filter acquisition mode.

> @@ -606,7 +679,7 @@ static int stm32_mdf_adc_check_clock_config(struct st=
m32_mdf_adc *adc, unsigned
>  	return ret;
>  }
> =20
> -static int __maybe_unused mdf_adc_set_samp_freq(struct iio_dev *indio_de=
v)
> +static int mdf_adc_set_samp_freq(struct iio_dev *indio_dev)
>  {
>  	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
>  	struct device *dev =3D &indio_dev->dev;
> @@ -675,6 +748,483 @@ static int __maybe_unused mdf_adc_set_samp_freq(str=
uct iio_dev *indio_dev)
>  	return ret;
>  }
> =20
> +static int stm32_mdf_adc_start_mdf(struct iio_dev *indio_dev)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	ret =3D clk_prepare_enable(adc->sitf->sck);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Failed to enable clock %s\n",
> +			__clk_get_name(adc->sitf->sck));
> +		return ret;
> +	}
> +
> +	ret =3D mdf_adc_set_samp_freq(indio_dev);

[Severity: High]
Does calling mdf_adc_set_samp_freq() divide by zero in
stm32_mdf_adc_check_clock_config() on the first conversion or sampling
frequency write?

mdf_adc_set_samp_freq() calls stm32_mdf_adc_check_clock_config() before
stm32_mdf_adc_set_filters_config() initializes adc->decim_cic:

drivers/iio/adc/stm32-mdf-adc.c:stm32_mdf_adc_check_clock_config() {
    ...
	/* RSFLT enabled: check Fproc > 24 * Fsck / (MCICD+1) */
	cic_ratio =3D DIV_ROUND_CLOSEST(24, adc->decim_cic);
    ...
}

On the first call after probe, adc->decim_cic is still 0, triggering a
divide by zero; on later rate changes, stm32_mdf_adc_check_clock_config()
checks against the previous stale adc->decim_cic value.

In addition, stm32_mdf_adc_apply_filters_config() (called via
mdf_adc_set_samp_freq() -> stm32_mdf_adc_set_filters_config()) uses
MDF_SITFCR_SCKSRC_MASK (GENMASK(2, 1)) instead of MDF_DFLTCICR_DATSRC_MASK
(GENMASK(1, 0)) when programming adc->datsrc into MDF_DFLTCICR_REG:

drivers/iio/adc/stm32-mdf-adc.c:stm32_mdf_adc_apply_filters_config() {
    ...
	/* Configure CICR */
	msk =3D MDF_SITFCR_SCKSRC_MASK | MDF_DFLTCICR_CICMOD_MASK |
	      MDF_DFLTCICR_MCICD_MASK | MDF_DFLTCICR_SCALE_MASK;
	val =3D FIELD_PREP(MDF_SITFCR_SCKSRC_MASK, adc->datsrc) |
    ...
}

This shifts datsrc into bits [2:1] and leaves bit 0 unmasked.

[ ... ]

> +static int stm32_mdf_channel_parse_of(struct iio_dev *indio_dev, struct =
fwnode_handle *node,
> +				      struct iio_chan_spec *ch)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	struct iio_backend *backend;
> +	const char *label =3D fwnode_get_name(node);
> +	int ret;
> +	u32 stu =3D 0;
> +
> +	ret =3D fwnode_property_read_u32(node, "reg", &ch->channel);
> +	if (ret < 0) {
> +		dev_err(&indio_dev->dev, "Failed to read channel index: [%d]\n", ret);
> +		return ret;
> +	}

[ ... ]

> +	if (adc->dev_data->type =3D=3D STM32_MDF_IIO) {
> +		backend =3D devm_iio_backend_fwnode_get(&indio_dev->dev, NULL, node);
> +		if (IS_ERR(backend))
> +			return dev_err_probe(&indio_dev->dev, PTR_ERR(backend),
> +					     "Failed to get backend\n");
> +		adc->channels[ch->scan_index].backend =3D backend;
> +	}
> +
> +	return ret;
> +}

[Severity: High]
Should devm_iio_backend_fwnode_get() (and dev_err_probe(), as well as
devm_kcalloc() in stm32_mdf_adc_init()) use adc->dev (&pdev->dev) instead
of &indio_dev->dev?

Passing &indio_dev->dev attaches the DL_FLAG_AUTOREMOVE_CONSUMER
device_link and the devres release action to the unregistered, driverless
IIO struct device rather than the platform device.  If a later channel's
backend defers or probe fails before iio_device_register(),
device_links_purge(&indio_dev->dev) never runs, so the reference taken by
device_link_add() pins &indio_dev->dev at refcount 1 and leaks the IIO
device, its devres allocations, the device_link, and the backend module
reference.  Even when probe succeeds, &indio_dev->dev has no bound
device_driver, so the device link stays in DL_STATE_AVAILABLE and
unbinding the backend supplier driver fails to unbind stm32-mdf-adc and
triggers a WARN_ON in device_links_driver_cleanup().

[ ... ]

> +static int stm32_mdf_adc_single_conv(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan, int *res)
> +{

[ ... ]

> +	if (MDF_IS_INTERLEAVED_FILT(adc))
> +		*res =3D adc->buffer[chan->channel];
> +	else
> +		*res =3D adc->buffer[0];

[Severity: High]
Does stm32_mdf_adc_single_conv() return an unshifted 32-bit MDF_DFLTDR_REG
value instead of the 24-bit signed sample?

The 24-bit sample sits in bits [31:8] of MDF_DFLTDR_REG
(MDF_DFLTDR_DR_MASK), and IIO_CHAN_INFO_SCALE and IIO_CHAN_INFO_OFFSET in
stm32_mdf_adc_read_raw() are computed for a 24-bit sample (realbits =3D 24,
dflt_max).  In the IIO ABI, scan_type.shift (8) is only applied to
buffered scan elements, never to IIO_CHAN_INFO_RAW, so *res is 256 times
too large (and retains bits [7:0]) unless it is arithmetic right-shifted
by 8.

[Severity: Medium]
Can adc->buffer[chan->channel] also read out of bounds in interleaved
mode?

adc->buffer is allocated with adc->mdf->nb_interleave elements (which can
be 2), whereas chan->channel comes directly from the unvalidated DT "reg"
property (0..7) rather than chan->scan_index.  Also, passing &ch->channel
(int *) to fwnode_property_read_u32() in stm32_mdf_channel_parse_of()
passes a signed pointer where u32 * is expected.

> +
> +stop_conv:
> +	stm32_mdf_adc_stop_conv(indio_dev);
> +
> +err_conv:
> +	adc->trgo =3D save_trgo;
> +
> +	stm32_mdf_adc_stop_mdf(indio_dev);
> +
> +	return ret;
> +}
> +
> +static int stm32_mdf_adc_write_raw(struct iio_dev *indio_dev, struct iio=
_chan_spec const *chan,
> +				   int val, int val2, long mask)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	int ret =3D 0;
> +
> +	if (mask !=3D IIO_CHAN_INFO_SAMP_FREQ || !val)
> +		return -EINVAL;

[Severity: Medium]
Can writing a negative value or a frequency greater than 2 * sck_freq to
in_voltage_sampling_frequency trigger a divide by zero in
mdf_adc_set_samp_freq()?

Checking !val allows negative signed int values through, which sign-extend
when assigned to unsigned long adc->requested_sample_freq.  Whenever
sample_freq > 2 * sck_freq, DIV_ROUND_CLOSEST(sck_freq, sample_freq) in
mdf_adc_set_samp_freq() evaluates to 0, and the immediately following
dev_warn() divides by decim_ratio:

drivers/iio/adc/stm32-mdf-adc.c:mdf_adc_set_samp_freq() {
    ...
	decim_ratio =3D DIV_ROUND_CLOSEST(sck_freq, sample_freq);

	delta =3D abs(sck_freq - (decim_ratio * sample_freq));
	delta_ppm =3D (1000000 * delta) / sck_freq;
	if (delta_ppm > 1000)
		dev_warn(dev, "Sample rate deviation [%lu] ppm: [%lu] vs [%lu] Hz\n",
			 delta_ppm, sck_freq / decim_ratio, sample_freq);
    ...
}

> +
> +	{
> +		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
> +		if (IIO_DEV_ACQUIRE_FAILED(claim))
> +			return -EBUSY;
> +
> +		/* Set requested_sample_freq right now, as used by mdf_adc_set_samp_fr=
eq() */
> +		adc->requested_sample_freq =3D val;
> +
> +		if (adc->dev_data->type =3D=3D STM32_MDF_IIO) {
> +			ret =3D stm32_mdf_core_lock_kclk_rate(adc->mdf);
> +			if (!ret) {
> +				ret =3D mdf_adc_set_samp_freq(indio_dev);
> +
> +				stm32_mdf_core_unlock_kclk_rate(adc->mdf);
> +			}
> +		}
> +	}
> +
> +	if (ret)
> +		adc->requested_sample_freq =3D 0;

[Severity: Medium]
Does resetting adc->requested_sample_freq =3D 0 outside the
IIO_DEV_ACQUIRE_DIRECT_MODE scope race with concurrent direct-mode callers
and discard any previously configured sampling frequency on error?

The inner block releases the direct-mode claim before if (ret) runs, so a
concurrent reader or writer can observe the failed rate or have its new
rate overwritten with 0, and any prior valid requested_sample_freq is not
restored.

[Severity: Medium]
Can concurrent operations across two filter IIO devices sharing adc->mdf
cause an unbalanced clk_rate_exclusive_put() on priv->kclk?

Each filter has its own IIO direct-mode lock, while
stm32_mdf_core_lock_kclk_rate(), stm32_mdf_core_unlock_kclk_rate(),
stm32_mdf_core_start_mdf(), and stm32_mdf_core_stop_mdf() share
priv->n_active_ch and priv->exclusive_flg without locking:

CPU0 (Filter A write_raw)         CPU1 (Filter B raw conversion)
stm32_mdf_core_lock_kclk_rate()
  /* n_active_ch =3D=3D 1: skips get */
                                  stm32_mdf_core_stop_mdf()
                                    atomic_dec_and_test(&n_active_ch)
                                    clk_rate_exclusive_put(kclk)
                                    exclusive_flg =3D false
stm32_mdf_core_unlock_kclk_rate()
  /* !atomic_read(&n_active_ch) */
  clk_rate_exclusive_put(kclk)  <-- unbalanced put

Similarly, if two filters call stm32_mdf_core_start_mdf() concurrently from
0, the second filter sees atomic_inc_return(&priv->n_active_ch) =3D=3D 2 and
returns 0 before the first filter finishes pm_runtime_resume_and_get() and
sets MDF_CKG_CKGDEN.

> +
> +	return ret;
> +}
> +
> +static int stm32_mdf_adc_read_raw(struct iio_dev *indio_dev, struct iio_=
chan_spec const *chan,
> +				  int *val, int *val2, long mask)
> +{

[ ... ]

> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D adc->sample_freq;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		/*
> +		 * Vconv =3D (raw>>shift + offset) * scale.
> +		 * scale =3D Vref * k / 2^res (denominator is managed through FRACTION=
AL_LOG2 type)
> +		 * k correspond to the ratio between max resolution and actual filter =
maximum
> +		 * k =3D max / dflt_max
> +		 * max =3D 2^(res - 1) - 1
> +		 * max_dflt =3D D^N * gain_lin * gain_rsflt
> +		 * scale =3D Vref * max / dflt_max
> +		 */
> +		if (adc->channels[idx].backend) {
> +			ret =3D iio_backend_read_scale(adc->channels[idx].backend, chan,
> +						     &scale, NULL);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val =3D div_u64((u64)scale * max, adc->dflt_max);
> +
> +			*val2 =3D chan->scan_type.realbits;
> +			if (chan->differential)
> +				*val *=3D 2;
> +		} else {
> +			return -EPERM;
> +		}
> +
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (adc->channels[idx].backend) {
> +			ret =3D iio_backend_read_offset(adc->channels[idx].backend, chan,
> +						      &offset, NULL);
> +			if (ret < 0)
> +				return ret;
> +
> +			*val =3D offset;
> +			if (!chan->differential)
> +				*val +=3D adc->dflt_max;

[Severity: High]
Does reading IIO_CHAN_INFO_SCALE before the first raw conversion or
sampling_frequency write divide by zero because adc->dflt_max is still 0?

Neither stm32_mdf_adc_probe() nor stm32_mdf_adc_init() calls
mdf_adc_set_samp_freq() to compute the initial filter parameters, so
adc->dflt_max and adc->sample_freq remain 0 until a conversion is started
or IIO_CHAN_INFO_SAMP_FREQ is written.  Reading in_voltageX_scale right
after probe divides by adc->dflt_max =3D=3D 0, while reading
in_voltageX_offset or in_voltage_sampling_frequency uses uninitialized 0
values.

[ ... ]

> +static irqreturn_t stm32_mdf_irq(int irq, void *arg)
> +{
> +	struct iio_dev *indio_dev =3D arg;
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev), *adc_inter;
> +	struct regmap *regmap =3D adc->regmap;
> +	u32 *ptr =3D adc->buffer;
> +	u32 isr, ier, flags;
> +
> +	regmap_read(regmap, MDF_DFLTISR_REG, &isr);
> +	regmap_read(regmap, MDF_DFLTIER_REG, &ier);
> +
> +	flags =3D isr & ier;
> +	if (!flags)
> +		return IRQ_NONE;
> +
> +	if (flags & MDF_DFLTISR_FTHF_MASK) {
> +		/* Reading the data register clear the IRQ status */
> +		regmap_read(regmap, MDF_DFLTDR_REG, ptr++);
> +
> +		if (MDF_IS_FILTER0(adc))
> +			list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry)
> +				if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter))
> +					regmap_read(regmap, MDF_DFLTDR_REG, ptr++);
> +
> +		complete(&adc->completion);
> +	}

[Severity: High]
In the interleaved filter loop, shouldn't regmap_read() read from
adc_inter->regmap instead of Filter 0's regmap?

Passing regmap reads Filter 0's MDF_DFLTDR_REG repeatedly and leaves the
interleaved filters' data registers unread.  Also, because
stm32_mdf_adc_parse_of() inserts filters at the head of mdf->filter_list
with list_add(), iterating mdf->filter_list with ptr++ stores the
interleaved samples into adc->buffer in reverse probe order.

> +
> +	if (flags & MDF_DFLTISR_DOVRF_MASK) {
> +		dev_warn(&indio_dev->dev, "Data overflow detected\n");
> +		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_DOVRF_MASK);
> +	}
> +
> +	if (flags & MDF_DFLTISR_RFOVRF_MASK) {
> +		dev_warn(&indio_dev->dev, "Reshape filter overrun detected\n");
> +		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_RFOVRF_MASK);
> +	}
> +
> +	if (flags & MDF_DFLTISR_SATF_MASK) {
> +		dev_warn(&indio_dev->dev, "Saturation detected\n");
> +		regmap_set_bits(regmap, MDF_DFLTISR_REG, MDF_DFLTISR_SATF_MASK);
> +
> +		/* Notify only once */
> +		regmap_clear_bits(adc->regmap, MDF_DFLTIER_REG, MDF_DFLTIER_SATIE_MASK=
);
> +	}

[Severity: Medium]
Does regmap_set_bits() fail to clear the write-1-to-clear status flags in
MDF_DFLTISR_REG?

MDF_DFLTISR_REG is marked volatile in stm32_mdf_adc_volatile_reg(), and
regmap_set_bits() calls _regmap_update_bits() with force =3D false.  When an
interrupt status bit is already 1 in hardware, regmap reads MDF_DFLTISR_REG,
sees that the bit is already set, and skips the register write, leaving the
interrupt asserted.  Using regmap_write() with the flag mask will clear the
W1C bit without accidentally clearing other pending W1C bits via a
read-modify-write.

> +
> +	return IRQ_HANDLED;
> +}
> +
> +static int stm32_mdf_adc_init(struct device *dev, struct iio_dev *indio_=
dev)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	struct iio_chan_spec *ch =3D NULL;
> +	unsigned int num_ch;
> +	int ret;
> +
> +	num_ch =3D device_get_child_node_count(indio_dev->dev.parent);
> +	if (num_ch) {
> +		/* Filter0 may have several channels in interleaved mode */
> +		if (num_ch > 1) {
> +			if (!MDF_IS_FILTER0(adc)) {
> +				dev_err(dev, "Too many channels for filter [%d]\n", adc->fl_id);
> +				return -EINVAL;
> +			} else if (num_ch !=3D adc->mdf->nb_interleave) {
> +				dev_err(dev, "Unexpected channels number for filter0: [%d]\n",
> +					num_ch);
> +				return -EINVAL;
> +			}
> +		}
> +
> +		ch =3D devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*ch), GFP_KERNEL);
> +		if (!ch)
> +			return -ENOMEM;
> +
> +		adc->channels =3D devm_kcalloc(&indio_dev->dev, num_ch, sizeof(*adc->c=
hannels),
> +					     GFP_KERNEL);
> +		if (!adc->channels)
> +			return -ENOMEM;
> +
> +		ret =3D stm32_mdf_adc_chan_init(indio_dev, ch);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret, "Channels init failed\n");
> +	}
> +
> +	indio_dev->num_channels =3D num_ch;

[Severity: Medium]
If any child node has a "compatible" property (which
stm32_mdf_adc_chan_init() skips), does assigning indio_dev->num_channels =3D
num_ch instead of the initialized channel count returned in ret leave
uninitialized trailing entries in indio_dev->channels and adc->channels?

Also, because num_ch !=3D adc->mdf->nb_interleave is only checked when
num_ch > 1, a Filter 0 configured for interleaved mode
(adc->mdf->nb_interleave >=3D 2) with only 1 channel node is not rejected.

[ ... ]

> @@ -883,13 +1435,41 @@ static int stm32_mdf_adc_probe(struct platform_dev=
ice *pdev)
>  	if (IS_ERR(adc->regmap))
>  		return dev_err_probe(dev, PTR_ERR(adc->regmap), "Failed to init regmap=
\n");
> =20
> +	irq =3D platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return dev_err_probe(dev, irq, "Failed to get IRQ\n");
> +
> +	ret =3D devm_request_irq(dev, irq, stm32_mdf_irq, 0, pdev->name, iio);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to request IRQ\n");
> +
>  	ret =3D stm32_mdf_adc_parse_of(pdev, adc);
>  	if (ret < 0)
>  		return ret;
> =20
> +	iio->info =3D &stm32_mdf_info_adc;
> +	iio->name =3D dev_name(&pdev->dev);
> +
>  	adc->dev =3D dev;
> +	adc->dev_data =3D dev_data;
> +	ret =3D dev_data->init(dev, iio);

[Severity: Medium]
Can an interrupt firing right after devm_request_irq() dereference a NULL
adc->buffer or an uninitialized adc->completion in stm32_mdf_irq()?

adc->buffer is only allocated later in stm32_mdf_adc_parse_of(), and
init_completion(&adc->completion) is only called in dev_data->init().
Because devres releases resources in reverse order of registration,
adc->buffer is also freed before the IRQ is freed on teardown.

> +	if (ret < 0)
> +		goto err_clean_list;
> +
> +	if (!MDF_IS_INTERLEAVED_FILT_NOT_0(adc)) {
> +		ret =3D iio_device_register(iio);
> +		if (ret < 0) {
> +			dev_err_probe(dev, ret, "Failed to register IIO device: %d\n", ret);
> +			goto err_clean_list;
> +		}
> +	}
> =20
>  	return 0;
> +
> +err_clean_list:
> +	list_del(&adc->entry);
> +
> +	return ret;
>  }

[Severity: Medium]
What serializes mdf->filter_list modifications in probe/remove against
Filter 0 traversing mdf->filter_list in process and hardirq contexts?

Filter 0 registers its IIO device as soon as it probes, so conversions and
stm32_mdf_irq() on Filter 0 can traverse mdf->filter_list while a sibling
filter device is still probing (calling list_add() in
stm32_mdf_adc_parse_of() or list_del() on error) or being unbound in
stm32_mdf_adc_remove(), where the sibling's struct stm32_mdf_adc is also
freed while Filter 0 remains registered.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D7
