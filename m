Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2199606A325
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ij44ziCR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 104C010EBBE;
	Wed, 18 Nov 2026 15:34:52 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5076A10FDEA
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:34:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2112F461B4;
 Wed, 18 Nov 2026 15:34:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A32441F000C5;
 Wed, 18 Nov 2026 15:34:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016086;
 bh=BmJD8sv6AAFxv6Re5ss54Z9dNxRedpqV4XYrwTPA7fw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ij44ziCRh6fRrarjJnIwYFWMGZfJrmg9eKtOxQsL+FFRCKMyPkXeex5/wR1IpGjmi
 W8+p19OGPqNq8drX6X+wFfMBdciSmU7q9Xb00teeVTkltN1KG+JsWkb796xY0VCOGN
 pn5qRBP+qEF+zgxfdYCUTDoZJVF6bbrwMvSQXD6uQ5BrrJP7425Eqg+Ivnu49OxxMA
 pwBV0Zf0UiEOLpdSDEIh3zOlb0VEcZq3o417PFAT7Y7RatM2fTlND/SW+C6JOmvwSL
 7E8OZvBCpUY6UCSShllBxfahVLElSP6W6eLz/HFohEJ4ycF/bLQNrC5Qzot1ZW8RAq
 S8/bkEtNL1M8A==
Message-ID: <sashiko-outbox-221345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 06/11] iio: adc: stm32-mdf: configure cic filters and
 sample rates
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-6-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-6-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:34:45 +0000
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
- [High] iio: adc: stm32-mdf: division by zero in
  stm32_mdf_adc_check_clock_config()
- [High] iio: adc: stm32-mdf: division by zero when decim_ratio is 0
- [Medium] iio: adc: stm32-mdf: wrong DATSRC mask in
  stm32_mdf_adc_apply_filters_config()
- [Medium] iio: adc: stm32-mdf: wrong FastSinc scale in
  stm32_mdf_adc_set_filters_config()
- [Medium] iio: adc: stm32-mdf: missing rsflt_bypass copy for
  interleaved filters
- [Medium] iio: adc: stm32-mdf: broken ratio checks in
  stm32_mdf_adc_check_clock_config()
--

commit 76232b76e094892afbfa80eaf7eda8e245546546
Author: Olivier Moysan <olivier.moysan@foss.st.com>

iio: adc: stm32-mdf: configure cic filters and sample rates

This commit adds helper functions to compute CIC and reshape filter
decimation ratios, data scaling, and serial clock validation from a
requested sampling frequency.

> diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-=
adc.c
> index 411af78911c91..eae7a4fa14851 100644
> --- a/drivers/iio/adc/stm32-mdf-adc.c
> +++ b/drivers/iio/adc/stm32-mdf-adc.c

[ ... ]

> @@ -271,6 +329,352 @@ static struct stm32_mdf_adc *stm32_mdf_get_filter_b=
y_handle(struct stm32_mdf *md
>  	return NULL;
>  }
> =20
> +static int stm32_mdf_adc_compute_scale(struct device *dev, unsigned int =
decim,
> +				       unsigned int order, unsigned int data_size)
> +{

[ ... ]

> +	/* scale =3D 20 * ((DS - 1) * log10(2) - NF * log10(D)) */
> +	scale =3D 20 * ((data_size - 1) * stm32_mdf_log_table[0].log - order * =
logd);
> +
> +	return scale;
> +}
> +
> +static int stm32_mdf_adc_apply_filters_config(struct stm32_mdf_adc *adc,=
 unsigned int scale)
> +{
> +	struct stm32_mdf_adc *adc_inter;
> +	u32 msk, val;
> +	int ret, cnt =3D 0;
> +
> +	/* Apply conf from filter0 to interleaved filters if any */
> +	if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave) {
> +		list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry) {
> +			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter)) {
> +				adc_inter->datsrc =3D adc->datsrc;
> +				adc_inter->cicmode =3D adc->cicmode;
> +				adc_inter->decim_cic =3D adc->decim_cic;
> +				adc_inter->nbdis =3D adc->nbdis;
> +				adc_inter->hpf_cutoff =3D adc->hpf_cutoff;
> +
> +				stm32_mdf_adc_apply_filters_config(adc_inter, scale);
> +				cnt++;
> +			}
> +		}

[Severity: Medium]
Should this loop also copy adc->rsflt_bypass to adc_inter->rsflt_bypass
and check the return value of stm32_mdf_adc_apply_filters_config()?

Secondary interleaved filters skip filter property parsing during probe,
so adc_inter->rsflt_bypass stays false even when filter 0 bypasses the
reshape filter, leaving MDF_DFLTRSFR_RSFLTBYP unset on the secondary
filters and applying an unintended 4x decimation.  Any register update
failure on the secondary filters is also ignored.

[ ... ]

> +	/* Configure CICR */
> +	msk =3D MDF_SITFCR_SCKSRC_MASK | MDF_DFLTCICR_CICMOD_MASK |
> +	      MDF_DFLTCICR_MCICD_MASK | MDF_DFLTCICR_SCALE_MASK;
> +	val =3D FIELD_PREP(MDF_SITFCR_SCKSRC_MASK, adc->datsrc) |
> +	      FIELD_PREP(MDF_DFLTCICR_CICMOD_MASK, adc->cicmode) |
> +	      FIELD_PREP(MDF_DFLTCICR_MCICD_MASK, adc->decim_cic - 1) |
> +	      FIELD_PREP(MDF_DFLTCICR_SCALE_MASK, scale);
> +
> +	ret =3D regmap_update_bits(adc->regmap, MDF_DFLTCICR_REG, msk, val);

[Severity: Medium]
Should this use MDF_DFLTCICR_DATSRC_MASK instead of
MDF_SITFCR_SCKSRC_MASK when programming adc->datsrc into
MDF_DFLTCICR_REG?

MDF_SITFCR_SCKSRC_MASK is GENMASK(2, 1) whereas MDF_DFLTCICR_DATSRC_MASK
is GENMASK(1, 0), so adc->datsrc is shifted into bits [2:1] (where bit 2
is reserved) and bit 0 of DATSRC is left unmasked.

[ ... ]

> +static int stm32_mdf_adc_set_filters_config(struct iio_dev *indio_dev, u=
nsigned int decim)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	struct device *dev =3D &indio_dev->dev;
> +	unsigned int decim_cic, decim_rsflt =3D 1;
> +	unsigned int data_size =3D STM32_MDF_DATA_RES, order =3D adc->cicmode;

[ ... ]

> +	if (is_power_of_2(decim_cic)) {
> +		/*
> +		 * Decimation ratio is a power of 2: D =3D 2 exp n
> +		 * max scale =3D 20 * (DS - n * NF) * log10(2)
> +		 */
> +		log =3D stm32_mdf_log_table[0].log;
> +
> +		/* Compute max scale (dB) * 1000 */
> +		max_scale =3D (20 * (data_size - 1 - (order * (fls(decim_cic) - 1))) *=
 log);
> +	} else {
> +		/*
> +		 * Decimation ratio is not a power of 2
> +		 * max scale =3D 20 * ((DS - 1) * log10(2) - NF * log10(D))
> +		 */
> +		max_scale =3D stm32_mdf_adc_compute_scale(dev, decim_cic, order, data_=
size);
> +	}

[Severity: Medium]
Does the max_scale calculation handle FastSinc mode (adc->cicmode =3D=3D 0)?

As noted in the dflt_max calculation below, FastSinc has a CIC gain of
2 * D^2, but both branches here (and stm32_mdf_adc_compute_scale() above)
multiply the decimation log term by order =3D 0.  That treats the CIC gain
as 0 dB and always selects the maximum +72.2 dB scale (0x18), saturating
the filter output and overflowing the 32-bit adc->dflt_max when
decim_cic >=3D 12.

[ ... ]

> +	adc->decim_cic =3D decim_cic;

[ ... ]

> +static int stm32_mdf_adc_check_clock_config(struct stm32_mdf_adc *adc, u=
nsigned long *sck_freq)
> +{
> +	unsigned long cck_expected_freq;
> +	unsigned int ratio, cic_ratio;
> +	int ret, error =3D 0;

[ ... ]

> +	/*
> +	 * Mode SPI:    check Fproc >=3D 4 * Fsck
> +	 * Mode LF SPI: check Fproc >=3D 2 * Fsck
> +	 */
> +	ratio =3D DIV_ROUND_CLOSEST(adc->mdf->fproc, *sck_freq);
> +	if ((adc->sitf->mode =3D=3D STM32_MDF_MODE_SPI && ratio <=3D 4) ||
> +	    (adc->sitf->mode =3D=3D STM32_MDF_MODE_LF_SPI && ratio <=3D 2)) {
> +		dev_dbg(adc->dev, "Wrong Fproc/Fsck ratio [%d]. sitf mode [%d], RSFLT =
[%s]\n",
> +			ratio, adc->sitf->mode, adc->rsflt_bypass ? "off" : "on");
> +		error |=3D STM32_MDF_ERR_MODE_RATIO;
> +	}
> +
> +	/* RSFLT enabled: check Fproc > 24 * Fsck / (MCICD+1) */
> +	cic_ratio =3D DIV_ROUND_CLOSEST(24, adc->decim_cic);
> +	if (!adc->rsflt_bypass && ratio <=3D cic_ratio)
> +		error |=3D STM32_MDF_ERR_DECIM_RATIO;

[Severity: High]
Can DIV_ROUND_CLOSEST(24, adc->decim_cic) divide by zero here?

mdf_adc_set_samp_freq() calls stm32_mdf_adc_check_clock_config() before
calling stm32_mdf_adc_set_filters_config(), which is the only place that
sets adc->decim_cic.  On the first call adc->decim_cic is still 0,
causing a division by zero, and on later sample rate changes this check
uses the stale adc->decim_cic from the previous configuration.

> +
> +	/* If we found an error, try to restore clocks initial settings */
> +	if (error) {
> +		ret =3D stm32_mdf_core_restore_cck(adc->mdf);
> +		if (ret < 0)
> +			goto err;
> +
> +		*sck_freq =3D clk_get_rate(adc->sitf->sck);
> +		if (!*sck_freq) {
> +			ret =3D -EINVAL;
> +			goto err;
> +		}
> +	}
> +
> +	return 0;

[Severity: Medium]
Does stm32_mdf_adc_check_clock_config() accept invalid clock ratios and
reject valid boundary ratios?

The SPI mode checks above use ratio <=3D 4 and ratio <=3D 2 instead of
ratio < 4 and ratio < 2, rejecting the valid boundary ratios Fproc =3D 4 *
Fsck and Fproc =3D 2 * Fsck.  In addition, when error is non-zero, this
function calls stm32_mdf_core_restore_cck() and returns 0 without
re-checking whether the restored clock satisfies the frequency and
Fproc/Fsck ratio constraints.  Finally, mdf_adc_set_samp_freq() computes
the default sample_freq from sck_freq before calling
stm32_mdf_adc_check_clock_config(), so if *sck_freq is updated here,
sample_freq stays based on the old rate.

[ ... ]

> +static int __maybe_unused mdf_adc_set_samp_freq(struct iio_dev *indio_de=
v)
> +{

[ ... ]

> +	if (!sample_freq)
> +		sample_freq =3D sck_freq / MDF_DEFAULT_DECIM_RATIO;
> +
> +	ret =3D stm32_mdf_adc_check_clock_config(adc, &sck_freq);
> +	if (ret)
> +		goto err;
> +
> +	decim_ratio =3D DIV_ROUND_CLOSEST(sck_freq, sample_freq);
> +
> +	delta =3D abs(sck_freq - (decim_ratio * sample_freq));
> +	delta_ppm =3D (1000000 * delta) / sck_freq;
> +	if (delta_ppm > 1000)
> +		dev_warn(dev, "Sample rate deviation [%lu] ppm: [%lu] vs [%lu] Hz\n",
> +			 delta_ppm, sck_freq / decim_ratio, sample_freq);

[Severity: High]
Can sck_freq / decim_ratio divide by zero when a caller requests
sample_freq > 2 * sck_freq?

DIV_ROUND_CLOSEST(sck_freq, sample_freq) rounds decim_ratio down to 0
before stm32_mdf_adc_set_filters_config() validates the decimation range,
and delta_ppm then evaluates to 1000000, hitting sck_freq / decim_ratio
in dev_warn().  Similarly, if requested_sample_freq is 0 and
sck_freq < MDF_DEFAULT_DECIM_RATIO, sample_freq becomes 0 and
DIV_ROUND_CLOSEST(sck_freq, sample_freq) divides by zero.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D6
