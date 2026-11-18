Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788EB60A2600
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 16:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iXamzbMt
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D500A10E0F6;
	Wed, 18 Nov 2026 16:09:03 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A784B10E0F6
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 16:08:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6061E4016C;
 Wed, 18 Nov 2026 16:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAADD1F000C4;
 Wed, 18 Nov 2026 16:08:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795018137;
 bh=Q/4w059UF8AfVKJqVmLzXM8ozDPCMJbMNmkCPBpCX28=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=iXamzbMtZKYt1Q1yTYBkq+Tw9c1abfJ4WFUueghaBf8xVLqJgt04wtP/UKf0S6S2e
 LC8FLWnQ3AgtdpA/JIXGIeONA2VopIsKV8VYGJ8pXf3cfdapdP6PqonOfDsWKAjtHC
 J7hyHwpCE/g4JI294U8idwvjxBrkcEe9A/YpOtSaX4wbeFUhH5UDfq/EWZMqM4Dy+X
 LKYe8y8GvNItrALQ4BdHBrFa63rzKlsJJvM8o56I0saW9P+tWA8dGTimzknw3wgpvl
 /uN4V9+QwkcLWQWDQapsjYiTREfBzSa7XYzWYde8DICQTdIgEgp+h9q4rABojO4F+0
 4eJNa45AYF2Cw==
Message-ID: <sashiko-outbox-221427@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/11] ASoC: stm32: add mdf dai support
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-11-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-11-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 16:08:56 +0000
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
- [High] ASoC: stm32: amdf: wrong S16_LE source offset on wrap in
  stm32_afsdm_pcm_cb()
- [High] ASoC: stm32: amdf: broken period elapsed condition in
  stm32_afsdm_pcm_cb()
- [High] ASoC: stm32: amdf: broken watermark and channel limits in
  interleaved mode
- [High] ASoC: stm32: amdf: unsynchronized DMA callback registration,
  stop, and pos update
- [Medium] ASoC: stm32: amdf: SNDRV_PCM_INFO_PAUSE set without pause
  trigger handling
- [Low] ASoC: stm32: amdf: invalid %pK format in dev_dbg() in
  stm32_afsdm_pcm_cb()
- [Low] ASoC: stm32: amdf: missing period_bytes_min in stm32_amdf_pcm_hw
--

commit 2a312f0d863bc42aba2f6fceb749066af9dab645
Author: Olivier Moysan <olivier.moysan@foss.st.com>

ASoC: stm32: add mdf dai support

This commit adds an ASoC DAI and platform driver for PDM digital
microphones connected to the STM32 Multi-function Digital Filter (MDF)
IP via the IIO consumer buffer interface.

> diff --git a/sound/soc/stm/stm32_amdf.c b/sound/soc/stm/stm32_amdf.c
> new file mode 100644
> index 0000000000000..a733a7a2997fa
> --- /dev/null
> +++ b/sound/soc/stm/stm32_amdf.c
> @@ -0,0 +1,375 @@

[ ... ]

> +static const struct snd_pcm_hardware stm32_amdf_pcm_hw =3D {
> +	.info =3D SNDRV_PCM_INFO_INTERLEAVED | SNDRV_PCM_INFO_BLOCK_TRANSFER |
> +		SNDRV_PCM_INFO_MMAP | SNDRV_PCM_INFO_PAUSE,
> +	.formats =3D SNDRV_PCM_FMTBIT_S16_LE | SNDRV_PCM_FMTBIT_S32_LE,
> +
> +	.channels_min =3D 1,
> +	.channels_max =3D 1,
> +
> +	.periods_min =3D 2,
> +	.periods_max =3D MDF_MAX_PERIODS,
> +
> +	.period_bytes_max =3D MDF_MAX_PERIOD_SIZE,
> +	.buffer_bytes_max =3D MDF_MAX_PERIODS * MDF_MAX_PERIOD_SIZE
> +};

[Severity: Low]
Should stm32_amdf_pcm_hw define .period_bytes_min?

Without .period_bytes_min, SNDRV_PCM_HW_PARAM_PERIOD_BYTES has a minimum
of 0.  An unconstrained hw_params request can then fail during interval
refinement with -EINVAL, or userspace can configure a 1-frame period and
set the IIO watermark to 1, generating a DMA interrupt on every frame.

[ ... ]

> +static void stm32_memcpy_32to16(void *dest, const void *src, size_t n)
> +{
> +	unsigned int i =3D 0;
> +	u16 *d =3D (u16 *)dest, *s =3D (u16 *)src;
> +
> +	s++;
> +	for (i =3D n >> 1; i > 0; i--) {
> +		*d++ =3D *s++;
> +		s++;
> +	}
> +}
> +
> +static int stm32_afsdm_pcm_cb(const void *data, size_t size, void *priva=
te)
> +{
> +	struct stm32_amdf_priv *priv =3D private;
> +	struct snd_soc_pcm_runtime *rtd =3D snd_soc_substream_to_rtd(priv->subs=
tream);
> +	u8 *pcm_buff =3D priv->pcm_buff;
> +	u8 *src_buff =3D (u8 *)data;
> +	unsigned int old_pos =3D priv->pos;
> +	size_t buff_size =3D snd_pcm_lib_buffer_bytes(priv->substream);
> +	size_t period_size =3D snd_pcm_lib_period_bytes(priv->substream);
> +	size_t cur_size, src_size =3D size;
> +	snd_pcm_format_t format =3D priv->substream->runtime->format;
> +
> +	if (format =3D=3D SNDRV_PCM_FORMAT_S16_LE)
> +		src_size >>=3D 1;
> +	cur_size =3D src_size;
> +
> +	dev_dbg(rtd->dev, "%s: buff_add :%pK, pos =3D %d, size =3D %zu\n",
> +		__func__, &pcm_buff[priv->pos], priv->pos, src_size);

[Severity: Low]
Does %pK work in stm32_afsdm_pcm_cb()?

This callback runs from the DMA completion handler in softirq or hardirq
context, where %pK prints "pK-error" when kptr_restrict is 1; commit
4db4ce15706d ("ASoC: stm32: dfsdm: don't use %pK through printk")
switched the same debug print in stm32_adfsdm.c to %p.

> +
> +	if ((priv->pos + src_size) > buff_size) {
> +		if (format =3D=3D SNDRV_PCM_FORMAT_S16_LE)
> +			stm32_memcpy_32to16(&pcm_buff[priv->pos], src_buff, buff_size - priv-=
>pos);
> +		else
> +			memcpy(&pcm_buff[priv->pos], src_buff, buff_size - priv->pos);
> +		cur_size -=3D buff_size - priv->pos;
> +		priv->pos =3D 0;
> +	}
> +
> +	if (format =3D=3D SNDRV_PCM_FORMAT_S16_LE)
> +		stm32_memcpy_32to16(&pcm_buff[priv->pos], &src_buff[src_size - cur_siz=
e], cur_size);
> +	else
> +		memcpy(&pcm_buff[priv->pos], &src_buff[src_size - cur_size], cur_size);

[Severity: High]
Does the second stm32_memcpy_32to16() call read from the wrong offset in
src_buff when the ring buffer wraps in SNDRV_PCM_FORMAT_S16_LE mode?

When format is SNDRV_PCM_FORMAT_S16_LE, src_size and cur_size are halved
to measure 16-bit destination bytes, while src_buff holds 32-bit samples
and stm32_memcpy_32to16() consumes 2 * n source bytes to write n
destination bytes.  After the first copy writes buff_size - priv->pos
destination bytes, indexing &src_buff[src_size - cur_size] advances
src_buff by only half the consumed source bytes instead of
2 * (src_size - cur_size), re-copying earlier samples and misaligning
the 16-bit word offset whenever an odd number of samples was copied
before the wrap.

> +
> +	priv->pos =3D (priv->pos + cur_size) % buff_size;
> +
> +	if (cur_size !=3D src_size || (old_pos && (old_pos % period_size < size=
)))
> +		snd_pcm_period_elapsed(priv->substream);
> +
> +	return 0;
> +}

[Severity: High]
Does this skip snd_pcm_period_elapsed() whenever old_pos is 0?

At stream start (and at the start of every new buffer cycle when
buff_size is a multiple of period_size), old_pos is 0 and cur_size
equals src_size, so the condition evaluates to false and drops the first
period notification of every buffer cycle.  When old_pos is non-zero,
old_pos % period_size < size also compares the pre-copy PCM byte offset
against the unscaled 32-bit DMA size (which is twice the PCM byte count
in S16_LE mode) rather than checking whether advancing by src_size bytes
crossed a period boundary.

> +
> +static int stm32_amdf_trigger(struct snd_soc_component *component,
> +			      struct snd_pcm_substream *substream, int cmd)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D snd_soc_substream_to_rtd(substream);
> +	struct stm32_amdf_priv *priv =3D
> +		snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
> +
> +	switch (cmd) {
> +	case SNDRV_PCM_TRIGGER_START:
> +	case SNDRV_PCM_TRIGGER_RESUME:
> +		priv->pos =3D 0;
> +		return stm32_mdf_get_buff_cb(priv->iio_ch->indio_dev, stm32_afsdm_pcm_=
cb, priv);
> +	case SNDRV_PCM_TRIGGER_SUSPEND:
> +	case SNDRV_PCM_TRIGGER_STOP:
> +		return stm32_mdf_release_buff_cb(priv->iio_ch->indio_dev);
> +	}
> +
> +	return -EINVAL;
> +}

[Severity: Medium]
Does stm32_amdf_trigger() fail with -EINVAL on pause requests despite
stm32_amdf_pcm_hw advertising SNDRV_PCM_INFO_PAUSE?

SNDRV_PCM_TRIGGER_PAUSE_PUSH and SNDRV_PCM_TRIGGER_PAUSE_RELEASE are not
handled in the switch and fall through to return -EINVAL.  In addition,
SNDRV_PCM_TRIGGER_RESUME resets priv->pos to 0 instead of preserving the
buffer position across suspend/resume.

[Severity: High]
Can stm32_amdf_trigger() race with an active DMA completion callback in
stm32_mdf_adc_dma_buffer_done()?

stm32_amdf_dai_prepare() starts cyclic IIO DMA via
iio_channel_start_all_cb() before trigger() is called, and DMA continues
running until stm32_amdf_shutdown().  While DMA callbacks are firing,
stm32_mdf_get_buff_cb() and stm32_mdf_release_buff_cb() set or clear
adc->cb and adc->cb_priv without locking or stopping DMA:

drivers/iio/adc/stm32-mdf-adc.c:stm32_mdf_adc_dma_buffer_done() {
    ...
		if (adc->bufi >=3D adc->buf_sz) {
			if (adc->cb)
				adc->cb(&adc->rx_buf[old_pos], adc->buf_sz - old_pos, adc->cb_priv);
			adc->bufi =3D 0;
			old_pos =3D 0;
		}
		if (adc->dev_data->type =3D=3D STM32_MDF_IIO)
			iio_push_to_buffers(indio_dev, buffer);
		available -=3D indio_dev->scan_bytes;
	}
	if (adc->cb)
		adc->cb(&adc->rx_buf[old_pos], adc->bufi - old_pos, adc->cb_priv);
}

CPU0                                      CPU1 (<softirq>)
stm32_amdf_trigger(..., STOP)
  stm32_mdf_release_buff_cb()
                                          stm32_mdf_adc_dma_buffer_done()
                                            if (adc->cb)
    adc->cb =3D NULL;
    adc->cb_priv =3D NULL;
                                              adc->cb(..., adc->cb_priv)
                                                <-- NULL deref

The same NULL dereference can happen on a single CPU if
snd_pcm_period_elapsed() during the first adc->cb() call in
stm32_mdf_adc_dma_buffer_done() triggers an XRUN stop before the second
adc->cb() call, or on START if CPU1 observes adc->cb before adc->cb_priv
is written.  Because STOP does not wait for in-flight callbacks to
finish, stm32_afsdm_pcm_cb() can also keep writing to priv->pcm_buff
after hw_free, and setting priv->pos =3D 0 mid-copy in stm32_afsdm_pcm_cb()
exposes a transient 0 offset to concurrent lockless
stm32_amdf_pcm_pointer() readers.

[ ... ]

> +static int stm32_amdf_pcm_hw_params(struct snd_soc_component *component,
> +				    struct snd_pcm_substream *substream,
> +				    struct snd_pcm_hw_params *params)
> +{
> +	struct snd_soc_pcm_runtime *rtd =3D snd_soc_substream_to_rtd(substream);
> +	struct stm32_amdf_priv *priv =3D
> +		snd_soc_dai_get_drvdata(snd_soc_rtd_to_cpu(rtd, 0));
> +
> +	priv->pcm_buff =3D substream->runtime->dma_area;
> +
> +	return iio_channel_cb_set_buffer_watermark(priv->iio_cb,
> +						   params_period_size(params));
> +}

[ ... ]

> +static int stm32_amdf_probe(struct platform_device *pdev)
> +{

[ ... ]

> +	channels_max =3D stm32_mdf_get_sub_channels_nb(priv->iio_ch->indio_dev);
> +	priv->dai_drv.capture.channels_max =3D channels_max;

[Severity: High]
Does multi-channel interleaved capture misconfigure the IIO watermark and
channel constraints when channels_max > 1?

In stm32_mdf_audio_init(), the audio IIO device always sets
indio_dev->num_channels =3D 1 with 32-bit storage, so indio_dev->scan_bytes
is 4 bytes (one sample) rather than a multi-channel frame:

drivers/iio/adc/stm32-mdf-adc.c:stm32_mdf_set_watermark() {
    ...
	watermark =3D min(val, MDF_DMA_BUFFER_SIZE / (2 * scan_bytes));
	adc->buf_sz =3D 2 * watermark * scan_bytes;
}

Passing params_period_size(params) (in frames) instead of
params_period_size(params) * params_channels(params) sizes each DMA
period to 1 / channels of the ALSA period.  Also, stm32_amdf_pcm_hw
keeps .channels_max =3D 1 (overriding the DAI's channels_max in
stm32_amdf_pcm_open()), and priv->dai_drv.capture.channels_min is left
at 1 even though the MDF hardware always interleaves all channels_max
filters into the DMA stream.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D11
