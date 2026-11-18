Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82CB160A262C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IQL1hrLA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AB8BE10E7DE;
	Wed, 18 Nov 2026 15:38:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 370BF10E7DE
 for <dri-devel@lists.freedesktop.org>; Wed, 18 Nov 2026 15:37:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 209E4462FC;
 Wed, 18 Nov 2026 15:37:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B5C1F000C5;
 Wed, 18 Nov 2026 15:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795016274;
 bh=uYDwVl6WgEztGK/K6YA4WjnFs33A5/iiD4AppXIep7I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IQL1hrLArtFSbgncixMpZuIxsfMPUuFcRqFZieXJ5M9Z8mPlHZsuESOkieyW6iEGg
 GFp4qrFDN4l3tUg0k8mhtlvbwGzilTMHUq59gAo38DqeXKynK2zOwfORAHlLf/7sLt
 NhU6vw05YSdQe040fHejJNewnIVdj+Ac0AbJIzzaYUidsLunYmmMBr79vxWuj+qQtY
 83CNxsZ43tetdAN651wTVy4t7RchKWW2k9+5vuV2HlpPUTQaF+Mi7746W2npAUn6EB
 Lb6uwV4efTFJMNB3tSjdryhjnr/iGVasQ0xI1nDmdKQlc6eB7rd7J9d9/L5h90l3iC
 y1PMOeP6QYFpg==
Message-ID: <sashiko-outbox-221349@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/11] iio: adc: stm32-mdf: add external timer
 trigger support
To: "Olivier Moysan" <olivier.moysan@foss.st.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-sound@vger.kernel.org, robh@kernel.org, conor+dt@kernel.org,
 media-ci@linuxtv.org
In-Reply-To: <20261118-upstream_mdf_v2-v2-9-7939d3c3720a@foss.st.com>
References: <20261118-upstream_mdf_v2-v2-0-7939d3c3720a@foss.st.com>
 <20261118-upstream_mdf_v2-v2-9-7939d3c3720a@foss.st.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 15:37:53 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [High] iio: adc: stm32-mdf: non-zero return in
  stm32_mdf_adc_get_trig() rejects trig
- [High] iio: adc: stm32-mdf: unassigned trgsrc in
  stm32_mdf_adc_filter_set_trig()
- [Medium] iio: adc: stm32-mdf: unpropagated trigger in
  stm32_mdf_adc_filter_set_trig()
--

commit 2310fd550deab336f6cec980952473a0c65d6371
Author: Olivier Moysan <olivier.moysan@foss.st.com>

iio: adc: stm32-mdf: add external timer trigger support

This commit adds STM32 timer and low-power timer trigger definitions, a
trigger validation callback, and filter trigger source and polarity
configuration for the STM32 MDF ADC driver.

> diff --git a/drivers/iio/adc/stm32-mdf-adc.c b/drivers/iio/adc/stm32-mdf-=
adc.c
> index 046ca3943a397..97099b4adffc6 100644
> --- a/drivers/iio/adc/stm32-mdf-adc.c
> +++ b/drivers/iio/adc/stm32-mdf-adc.c
[ ... ]
> @@ -365,9 +405,63 @@ static void stm32_mdf_adc_stop_filter(struct stm32_m=
df_adc *adc)
>  				stm32_mdf_adc_stop_filter(adc_inter);
>  }
> =20
> +static int stm32_mdf_adc_get_trig(struct iio_dev *indio_dev, struct iio_=
trigger *trig)
> +{
> +	int i;
> +
> +	/* lookup triggers registered by stm32 timer trigger driver */
> +	for (i =3D 0; stm32_mdf_trigs[i].name; i++) {
> +		/**
> +		 * Checking both stm32 timer trigger type and trig name
> +		 * should be safe against arbitrary trigger names.
> +		 */
> +		if ((is_stm32_timer_trigger(trig) ||
> +		     is_stm32_lptim_trigger(trig)) &&
> +		     !strcmp(stm32_mdf_trigs[i].name, trig->name)) {
> +			dev_dbg(&indio_dev->dev, "Trigger [%d] found\n", i);
> +			return stm32_mdf_trigs[i].trgsrc;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int stm32_mdf_adc_filter_set_trig(struct iio_dev *indio_dev)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +	struct iio_trigger *trig =3D indio_dev->trig;
> +	u32 trgsrc =3D 0;
> +	/* set trigger polarity to rising edge by default */
> +	u32 trgsens =3D STM32_MDF_TRGSENS_RISING_EDGE;
> +	int ret;
> +
> +	if (trig) {
> +		ret =3D stm32_mdf_adc_get_trig(indio_dev, trig);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	dev_dbg(adc->dev, "Set trigger source [%d] on filter [%d]\n", trgsrc, a=
dc->fl_id);
> +
> +	return regmap_update_bits(adc->regmap, MDF_DFLTCR_REG,
> +				  MDF_DFLTCR_TRGSRC_MASK | MDF_DFLTCR_TRGSENS,
> +				 FIELD_PREP(MDF_DFLTCR_TRGSRC_MASK, trgsrc) |
> +				 FIELD_PREP(MDF_DFLTCR_TRGSENS, trgsens));
> +}

[Severity: High]
Does stm32_mdf_adc_filter_set_trig() leave trgsrc at 0 when a trigger is
attached?  The return value of stm32_mdf_adc_get_trig() is checked in ret
but never assigned to trgsrc, so MDF_DFLTCR_REG is always programmed with
trigger source 0 (TRGO) instead of the selected external timer trigger.

> +
> +static void stm32_mdf_adc_filter_clear_trig(struct iio_dev *indio_dev)
> +{
> +	struct stm32_mdf_adc *adc =3D iio_priv(indio_dev);
> +
> +	regmap_update_bits(adc->regmap, MDF_DFLTCR_REG,
> +			   MDF_DFLTCR_TRGSRC_MASK | MDF_DFLTCR_TRGSENS, 0);
> +}

[Severity: Medium]
In interleaved mode, should stm32_mdf_adc_filter_set_trig() and
stm32_mdf_adc_filter_clear_trig() also update the secondary interleaved
filters in adc->mdf->filter_list, and should stm32_mdf_adc_start_conv()
skip pulsing MDF_GCR_TRGO when indio_dev->trig is set?

Unlike stm32_mdf_adc_filter_set_mode(), these helpers only write filter 0's
MDF_DFLTCR_REG, leaving secondary interleaved filters configured for
TRGSRC =3D 0 (TRGO).  Because adc->trgo is set at probe time for interleaved
and synchronized master filters, stm32_mdf_adc_start_conv() still calls
stm32_mdf_core_trigger(adc->mdf) during buffer enable, starting the
TRGO-triggered filters immediately while filter 0 waits for the external
timer edge.

[ ... ]

> @@ -1377,6 +1479,7 @@ static const struct iio_info stm32_mdf_info_adc =3D=
 {
>  	.write_raw =3D stm32_mdf_adc_write_raw,
>  	.read_raw =3D stm32_mdf_adc_read_raw,
>  	.read_label =3D stm32_mdf_adc_read_label,
> +	.validate_trigger =3D stm32_mdf_adc_get_trig,
>  };

[Severity: High]
Will wiring stm32_mdf_adc_get_trig() directly as .validate_trigger reject
every valid trigger?  stm32_mdf_adc_get_trig() returns a positive trgsrc
value (0x2..0xc) on match, whereas current_trigger_store() in
drivers/iio/industrialio-trigger.c treats any non-zero return from
validate_trigger() as an error and aborts assigning indio_dev->trig.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-upstream_m=
df_v2-v2-0-7939d3c3720a@foss.st.com?part=3D9
