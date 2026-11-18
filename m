Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA16606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 18 Nov 2026 10:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f+GR9KcG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 58C8110FAF2;
	Wed, 18 Nov 2026 10:53:34 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E134F10FAF3;
 Wed, 18 Nov 2026 10:53:28 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 429CF611D9;
 Wed, 18 Nov 2026 10:53:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B728B1F000C4;
 Wed, 18 Nov 2026 10:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794999208;
 bh=ObmCS2LpeB6sVWvFmWLETOczR6xRy+N4hpl1ULDye4k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f+GR9KcGNb08AGTd85p6YJBYX5Cu1cUPQimcZllOkArVEwyxgxpPzSg00ChQ8RkeV
 mmIlJJGRWyALHxgS6GHfBPuGu6+4NtOF0JKKTjuDbpfTSsess7dyKpeEaea3bP8RvZ
 t9Cz2EfSGJJX5IcTQlgkmqwCtPPd9WILmOHp1Fh9JoPDVgA1+68XrKQm1tEvQT/lJw
 yFX3Mzp9ghHdBGK2GIeJc+KFQ5RIbjD9H6Cm9R1OtQ8NAp58hrBsDaC+zZvkUB4vrR
 jH7E51pT4T3APFwj0ATAfaGHpuHEHl/d0BmH3CTCWlVzO7qmDLvsQ2ZDLS0Q1tl4ro
 2COloHk2cAP+w==
Message-ID: <sashiko-outbox-220759@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] drm/dp: Move eDP sink link rates reading helper out
 of i915
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261118-feat_move_i915_helper-v1-7-652177f3107a@bootlin.com>
References: <20261118-feat_move_i915_helper-v1-0-652177f3107a@bootlin.com>
 <20261118-feat_move_i915_helper-v1-7-652177f3107a@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 10:53:27 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/i915/dp: HBR2 quirk in intel_edp_set_sink_rates() skips
  fallback
--

commit b3bcea937e62f9aba672f8e2782fab0f2b184dbd
Author: Kory Maincent <kory.maincent@bootlin.com>

drm/dp: Move eDP sink link rates reading helper out of i915

This commit moves the eDP DP_SUPPORTED_LINK_RATES reading logic from i915
into a generic drm_dp_read_edp_sink_rates() helper.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 8fee2d195c944..225f6ed8c32d8 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c
> @@ -4815,56 +4815,21 @@ static void
>  intel_edp_set_sink_rates(struct intel_dp *intel_dp)
>  {
>  	struct intel_display *display =3D to_intel_display(intel_dp);
> +	int num_sink_rates;
> =20
> -	intel_dp->num_sink_rates =3D 0;
> -
> -	if (intel_dp->edp_dpcd[0] >=3D DP_EDP_14) {
> -		__le16 sink_rates[DP_MAX_SUPPORTED_RATES];
> -		int ret;
> -		int i;
> -
> -		ret =3D drm_dp_dpcd_read_data(&intel_dp->aux,
> -					    DP_SUPPORTED_LINK_RATES,
> -					    sink_rates, sizeof(sink_rates));
> -		if (ret < 0) {
> -			drm_dbg_kms(display->drm,
> -				    "Unable to read eDP supported link rates, using default rates\n"=
);
> -			memset(sink_rates, 0, sizeof(sink_rates));
> -		}
> -
> -		for (i =3D 0; i < ARRAY_SIZE(sink_rates); i++) {
> -			int rate;
> -
> -			/* Value read multiplied by 200kHz gives the per-lane
> -			 * link rate in kHz. The source rates are, however,
> -			 * stored in terms of LS_Clk kHz. The full conversion
> -			 * back to symbols is
> -			 * (val * 200kHz)*(8/10 ch. encoding)*(1/8 bit to Byte)
> -			 */
> -			rate =3D le16_to_cpu(sink_rates[i]) * 200 / 10;
> -
> -			if (rate =3D=3D 0)
> -				break;
> -
> -			/*
> -			 * Some platforms cannot reliably drive HBR3 rates due to PHY limitat=
ions,
> -			 * even if the sink advertises support. Reject any sink rates above H=
BR2 on
> -			 * the known machines for stable output.
> -			 */
> -			if (rate > 540000 &&
> -			    intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
> -				break;
> +	num_sink_rates =3D drm_dp_read_edp_sink_rates(&intel_dp->aux,
> +						    intel_dp->edp_dpcd[0],
> +						    intel_dp->sink_rates);
> +	if (num_sink_rates < 0)
> +		num_sink_rates =3D 0;
> =20
> -			intel_dp->sink_rates[i] =3D rate;
> -		}
> -		intel_dp->num_sink_rates =3D i;
> -	}
> +	intel_dp->num_sink_rates =3D num_sink_rates;
> =20
>  	/*
>  	 * Use DP_LINK_RATE_SET if DP_SUPPORTED_LINK_RATES are available,
>  	 * default to DP_MAX_LINK_RATE and DP_LINK_BW_SET otherwise.
>  	 */
> -	if (intel_dp->num_sink_rates)
> +	if (num_sink_rates)
>  		intel_dp->use_rate_select =3D true;
>  	else
>  		intel_dp_set_sink_rates(intel_dp);

[Severity: Medium]
Can this leave intel_dp->num_sink_rates as 0 on platforms with
QUIRK_EDP_LIMIT_RATE_HBR2 if DP_SUPPORTED_LINK_RATES only lists rates
above 540000 kHz?

Previously, rates above 540000 kHz were filtered out before checking
intel_dp->num_sink_rates, so an empty filtered list fell back to
intel_dp_set_sink_rates().  Now num_sink_rates is checked before the
following intel_dp_rate_limit_len() call clamps intel_dp->sink_rates:

drivers/gpu/drm/i915/display/intel_dp.c:intel_edp_set_sink_rates() {
	...
	if (num_sink_rates)
		intel_dp->use_rate_select =3D true;
	else
		intel_dp_set_sink_rates(intel_dp);
	...
	if (intel_dp->num_sink_rates && intel_has_quirk(display, QUIRK_EDP_LIMIT_R=
ATE_HBR2))
		intel_dp->num_sink_rates =3D intel_dp_rate_limit_len(intel_dp->sink_rates,
								   intel_dp->num_sink_rates,
								   540000);
}

When all entries in DP_SUPPORTED_LINK_RATES exceed 540000 kHz, this sets
intel_dp->use_rate_select to true, skips intel_dp_set_sink_rates(), and
then reduces intel_dp->num_sink_rates to 0, triggering drm_WARN_ON() in
intel_dp_get_common_rates() and breaking eDP link training.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118-feat_move_=
i915_helper-v1-0-652177f3107a@bootlin.com?part=3D7
