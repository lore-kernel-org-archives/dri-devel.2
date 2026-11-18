Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99559606A320
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BEsSZ/LL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 08E3210EC4F;
	Wed, 18 Nov 2026 16:06:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BBAB10FE25
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:06:06 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 111BB62755;
 Wed, 18 Nov 2026 16:06:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67D051F000C5;
 Wed, 18 Nov 2026 16:06:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795017964;
 bh=oKFR3bZi6v5pv8+3J77rAPs59izk8whRqH7B/hgm/+g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BEsSZ/LLc9TIpPGshcx6KgoMX0pl9XPhtr9ssiQDYkhcqppT9yve6scnGjYfR4p6T
 FOCyx55/f5kxgz0pBzKGCVysl7A9tRqxWzzT2YJsk16mcLG2fbCfPEiKN5Djvbh+1V
 9xWL+bACejYse/E/m2vjKyhTRLIPalwtSq14Fwde+i3fSru4GJ6pj4REMMtD7vkEcM
 p18Cw5TkVaKAgERpfFyhB+t+N9z1Tm8wbdUlIy0dBasD2pbGJ2PeThv/ihfOIdYNXV
 DzNKoCUqE08+FYzpyPj1RcIZca8s/LBRB9W+nh62obVoQ4IqzoXIqyjXYN95oypP43
 8bKLB7MQKmrbw==
Message-ID: <sashiko-outbox-221421@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/11] iio: adc: stm32-mdf: add dmic audio filter
 support
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-10-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-10-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:06:03 +0000
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

Thank you for your contribution! Sashiko AI review found 5 potential
issues to consider:
- [High] iio: adc: stm32-mdf: race updating cb and cb_priv in
  stm32_mdf_get_buff_cb()
- [Medium] iio: adc: stm32-mdf: out-of-bounds or uninitialized channel
  in stm32_mdf_audio_init()
- [Medium] iio: adc: stm32-mdf: unlocked freq reset in
  stm32_mdf_adc_write_raw()
- [Medium] iio: stm32-mdf: bad mask and bypass in
  stm32_mdf_adc_apply_filters_config()
- [Low] iio: adc: stm32-mdf: inaccurate kernel-doc Return for
  stm32_mdf_get_sub_channels_nb()
--

commit dd4cd2a4f3dd0be22589f1468dca26c3807bd280
Author: Olivier Moysan <olivier.moysan@foss.st.com>

iio: adc: stm32-mdf: add dmic audio filter support

This commit extends the STM32 MDF filter driver to support digital
microphone audio filters and adds callback and sub-channel helpers for
audio consumers.

> diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-=
adc.c
> index 97099b4adffc6..27c47bef71a42 100644
> --- a/drivers/iio/adc/stm32-mdf-adc.c
> +++ b/drivers/iio/adc/stm32-mdf-adc.c
[ ... ]
> @@ -1128,6 +1129,42 @@ static const struct iio_buffer_setup_ops stm32_mdf=
_buffer_setup_ops =3D {
>  	.predisable =3D &stm32_mdf_adc_predisable,
>  };
> =20
> +/**
> + * stm32_mdf_get_sub_channels_nb() - Get the number of MDF sub-channels
> + * @indio_dev: MDF IIO device
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */

[Severity: Low]
The Return description in the kernel-doc says this returns 0 on success or
a negative error code on failure, whereas stm32_mdf_get_sub_channels_nb()
returns an unsigned int sub-channel count (nb_interleave or 1).

> +unsigned int stm32_mdf_get_sub_channels_nb(struct iio_dev *indio_dev)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +
> +	if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave)
> +		return adc->mdf->nb_interleave;
> +
> +	return 1;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_get_sub_channels_nb);

[Severity: Medium]
Does stm32_mdf_adc_apply_filters_config() misconfigure MDF_DFLTCICR_REG and
drop rsflt_bypass on secondary interleaved filters?

drivers/iio/adc/stm32-mdf-adc.c:stm32_mdf_adc_apply_filters_config() {
	if (MDF_IS_FILTER0(adc) && adc->mdf->nb_interleave) {
		list_for_each_entry(adc_inter, &adc->mdf->filter_list, entry) {
			if (MDF_IS_INTERLEAVED_FILT_NOT_0(adc_inter)) {
				adc_inter->datsrc =3D adc->datsrc;
				adc_inter->cicmode =3D adc->cicmode;
				adc_inter->decim_cic =3D adc->decim_cic;
				adc_inter->nbdis =3D adc->nbdis;
				adc_inter->hpf_cutoff =3D adc->hpf_cutoff;

				stm32_mdf_adc_apply_filters_config(adc_inter, scale);
				cnt++;
			}
		}
    ...
	/* Configure CICR */
	msk =3D MDF_SITFCR_SCKSRC_MASK | MDF_DFLTCICR_CICMOD_MASK |
	      MDF_DFLTCICR_MCICD_MASK | MDF_DFLTCICR_SCALE_MASK;
	val =3D FIELD_PREP(MDF_SITFCR_SCKSRC_MASK, adc->datsrc) |
	      FIELD_PREP(MDF_DFLTCICR_CICMOD_MASK, adc->cicmode) |
	      FIELD_PREP(MDF_DFLTCICR_MCICD_MASK, adc->decim_cic - 1) |
	      FIELD_PREP(MDF_DFLTCICR_SCALE_MASK, scale);

	ret =3D regmap_update_bits(adc->regmap, MDF_DFLTCICR_REG, msk, val);
}

When programming MDF_DFLTCICR_REG, msk and val use MDF_SITFCR_SCKSRC_MASK
(GENMASK(2, 1)) instead of MDF_DFLTCICR_DATSRC_MASK (GENMASK(1, 0)), which
shifts adc->datsrc into bits [2:1] and leaves bit 0 untouched.  In
addition, the interleaved filter loop does not copy adc->rsflt_bypass to
adc_inter->rsflt_bypass, leaving the reshape filter enabled on secondary
interleaved filters when filter 0 has st,rs-filter-bypass set.

[ ... ]

> @@ -1474,6 +1514,13 @@ static int stm32_mdf_adc_read_label(struct iio_dev=
 *indio_dev, const struct iio_
>  	return sysfs_emit(label, "%s\n", name);
>  }
> =20
> +static const struct iio_info stm32_mdf_info_audio =3D {
> +	.hwfifo_set_watermark =3D stm32_mdf_set_watermark,
> +	.write_raw =3D stm32_mdf_adc_write_raw,
> +	.read_raw =3D stm32_mdf_adc_read_raw,
> +	.read_label =3D stm32_mdf_adc_read_label,
> +};

[Severity: Medium]
Does stm32_mdf_adc_write_raw() reset adc->requested_sample_freq outside
the direct-mode lock on error?

drivers/iio/adc/stm32-mdf-adc.c:stm32_mdf_adc_write_raw() {
    ...
	{
		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
		if (IIO_DEV_ACQUIRE_FAILED(claim))
			return -EBUSY;

		/* Set requested_sample_freq right now, as used by mdf_adc_set_samp_freq(=
) */
		adc->requested_sample_freq =3D val;

		if (adc->dev_data->type =3D=3D STM32_MDF_IIO) {
			ret =3D stm32_mdf_core_lock_kclk_rate(adc->mdf);
			if (!ret) {
				ret =3D mdf_adc_set_samp_freq(indio_dev);

				stm32_mdf_core_unlock_kclk_rate(adc->mdf);
			}
		}
	}

	if (ret)
		adc->requested_sample_freq =3D 0;
    ...
}

The IIO_DEV_ACQUIRE_DIRECT_MODE() guard releases direct mode at the end of
the inner block, before adc->requested_sample_freq is cleared.  If
stm32_mdf_core_lock_kclk_rate() or mdf_adc_set_samp_freq() fails, a
concurrent direct-mode writer or buffer enable can observe the failed
frequency or have its own valid update overwritten by 0.

> @@ -1530,6 +1577,38 @@ static irqreturn_t stm32_mdf_irq(int irq, void *ar=
g)
>  	return IRQ_HANDLED;
>  }
> =20
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
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Channels init failed\n");
> +
> +	indio_dev->num_channels =3D 1;
> +	indio_dev->channels =3D ch;

[Severity: Medium]
Can stm32_mdf_adc_chan_init() write past ch and adc->channels or leave them
uninitialized here?

stm32_mdf_audio_init() allocates a single element for ch and adc->channels,
but stm32_mdf_adc_chan_init() loops over every child node without a
compatible property and indexes channels[chan_idx] and
adc->channels[chan_idx] without checking the count.  If a dmic node has
more than one channel child node, stm32_mdf_adc_chan_init_one() writes out
of bounds on both allocations.  If there are no channel child nodes (such
as on a secondary interleaved filter), stm32_mdf_adc_chan_init() returns 0,
leaving indio_dev->num_channels set to 1 with ch[0] and adc->channels[0]
uninitialized.

[ ... ]

> @@ -1599,11 +1678,77 @@ static const struct stm32_mdf_dev_data stm32h7_md=
f_adc_data =3D {
>  	.init =3D stm32_mdf_adc_init,
>  };
> =20
> +static const struct stm32_mdf_dev_data stm32_mdf_audio_data =3D {
> +	.type =3D STM32_MDF_AUDIO,
> +	.init =3D stm32_mdf_audio_init,
> +};
> +
> +/**
> + * stm32_mdf_get_buff_cb() - register a callback that will be called when
> + *                           DMA transfer period is achieved.
> + *
> + * @iio_dev: Handle to IIO device.
> + * @cb: Pointer to callback function:
> + *      - data: pointer to data buffer
> + *      - size: size in byte of the data buffer
> + *      - private: pointer to consumer private structure.
> + * @private: Pointer to consumer private structure.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int stm32_mdf_get_buff_cb(struct iio_dev *iio_dev,
> +			  int (*cb)(const void *data, size_t size, void *private), void *priv=
ate)
> +{
> +	struct stm32_mdf_adc *adc;
> +
> +	if (!iio_dev)
> +		return -EINVAL;
> +	adc =3D iio_priv(iio_dev);
> +
> +	if (!adc)
> +		return -EINVAL;
> +
> +	adc->cb =3D cb;
> +	adc->cb_priv =3D private;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_get_buff_cb);
> +
> +/**
> + * stm32_mdf_release_buff_cb() - Unregister the buffer callback
> + *
> + * @iio_dev: Handle to IIO device.
> + *
> + * Return: 0 on success, or a negative error code on failure.
> + */
> +int stm32_mdf_release_buff_cb(struct iio_dev *iio_dev)
> +{
> +	struct stm32_mdf_adc *adc;
> +
> +	if (!iio_dev)
> +		return -EINVAL;
> +	adc =3D iio_priv(iio_dev);
> +
> +	if (!adc)
> +		return -EINVAL;
> +
> +	adc->cb =3D NULL;
> +	adc->cb_priv =3D NULL;
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_GPL(stm32_mdf_release_buff_cb);

[Severity: High]
Can stm32_mdf_get_buff_cb() and stm32_mdf_release_buff_cb() race with
stm32_mdf_adc_dma_buffer_done() and cause a NULL pointer dereference?

In the ASoC consumer driver, iio_channel_start_all_cb() is called during
DAI prepare, which runs stm32_mdf_adc_postenable() and starts cyclic DMA
before PCM trigger start, keeping it running across trigger stop.  As a
result, the DMA completion callback stm32_mdf_adc_dma_buffer_done() is
already running when stm32_mdf_get_buff_cb() and
stm32_mdf_release_buff_cb() update adc->cb and adc->cb_priv without locking
or ordering:

CPU0                                  CPU1
stm32_mdf_get_buff_cb()
  adc->cb =3D cb;
                                      stm32_mdf_adc_dma_buffer_done()
                                        if (adc->cb)
                                          adc->cb(..., adc->cb_priv);
                                            <-- cb_priv is still NULL
  adc->cb_priv =3D private;

Similarly, stm32_mdf_release_buff_cb() clears adc->cb and adc->cb_priv
without synchronizing with stm32_mdf_adc_dma_buffer_done(), so CPU1 can
pass a cleared adc->cb_priv or jump through a NULL adc->cb after the
if (adc->cb) check.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D10
