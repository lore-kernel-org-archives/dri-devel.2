Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BF40606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 16:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BOtqLAlB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 957C4112817;
	Thu, 22 Oct 2026 16:56:32 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 00105112817;
 Thu, 22 Oct 2026 16:56:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 14F9B60098;
 Thu, 22 Oct 2026 16:56:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B7F51F01825;
 Thu, 22 Oct 2026 16:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792688185;
 bh=WJ9WUTOc9SYEePPpKga6UwFnHTJYMMeuehwBKvhyagg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=BOtqLAlBwTFPYw5dA+M7uEzWFIrnpeSTTriWx8XEvLUOvLAvs6HRJxdur+/HowMVN
 5JYyMiOTfrmgmNAteU5ZTx3GAtAZYaxsZkdQMdWXoRSnw+HJAUCeBWdWjtFPUDjaNb
 bp0lp30rBFNVdmppZx5xs2484BiE/RNMZZ/KuOSeZyIvFVmeaKBfXdj/JEjsBfCJXI
 yPO5zfDQ+yvidti53GmOJZKn+mh0EodfMqIxW5SBzFstemOgiNTxUJiUO/edCfO7VO
 bH3JX+ZUnl9ljkOCnwASm2UJAa8TSjER1SEdcXWJONCCfaASbH1Sib4O/8ZUuD3EC4
 ukT56n/wXndQA==
Message-ID: <sashiko-outbox-181834@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/8] drm: Move sink link rates reading helpers out of
 i915
To: "Kory Maincent" <kory.maincent@bootlin.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261022-feat_link_cap-v4-1-a4f3f6e8cad9@bootlin.com>
References: <20261022-feat_link_cap-v4-0-a4f3f6e8cad9@bootlin.com>
 <20261022-feat_link_cap-v4-1-a4f3f6e8cad9@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 16:56:24 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/i915/dp: HBR2 quirk in intel_edp_set_sink_rates() skips fall=
back
--

commit 0b240b52afdb3eb8ae0e254bde919dbb5abd0487
Author: Kory Maincent <kory.maincent@bootlin.com>

drm: Move sink link rates reading helpers out of i915

This commit moves the DisplayPort and eDP sink link rate reading helpers out
of the i915 driver into generic display helpers in drm_dp_helper.c, while
keeping the Intel-specific rate limit quirk handling in intel_dp.c.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp.c b/drivers/gpu/drm/i9=
15/display/intel_dp.c
> index 0cd5e6b5034cf..087afcea5395f 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp.c

[ ... ]

> @@ -4722,60 +4619,35 @@ static void
>  intel_edp_set_sink_rates(struct intel_dp *intel_dp)
>  {
>  	struct intel_display *display =3D to_intel_display(intel_dp);
> +	int num_sink_rates;
> =20
> -	intel_dp->num_sink_rates =3D 0;
> +	num_sink_rates =3D drm_dp_read_edp_sink_rates(&intel_dp->aux,
> +						    intel_dp->edp_dpcd[0],
> +						    intel_dp->sink_rates);
> +	if (num_sink_rates < 0)
> +		num_sink_rates =3D 0;
> =20
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
> -
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
> =20
> +	/*
> +	 * Some platforms cannot reliably drive HBR3 rates due to PHY limitatio=
ns,
> +	 * even if the sink advertises support. Reject any sink rates above HBR=
2 on
> +	 * the known machines for stable output.
> +	 */
> +	if (intel_dp->num_sink_rates && intel_has_quirk(display, QUIRK_EDP_LIMI=
T_RATE_HBR2))
> +		intel_dp->num_sink_rates =3D intel_dp_rate_limit_len(intel_dp->sink_ra=
tes,
> +								   intel_dp->num_sink_rates,
> +								   540000);
> +
>  	intel_edp_set_data_override_rates(intel_dp);
>  }

[Severity: Medium]
In drivers/gpu/drm/i915/display/intel_dp.c, does moving the hbr2 rate limit
check in intel_edp_set_sink_rates() after the num_sink_rates check skip the
fallback to intel_dp_set_sink_rates() when all rates read by
drm_dp_read_edp_sink_rates() exceed 540000 kHz?

Previously, intel_edp_set_sink_rates() rejected rates above 540000 kHz insi=
de
the loop before checking if intel_dp->num_sink_rates was non-zero:

    if (rate > 540000 &&
        intel_has_quirk(display, QUIRK_EDP_LIMIT_RATE_HBR2))
            break;

If all advertised rates in that table exceeded 540000 kHz,
intel_dp->num_sink_rates remained 0, intel_dp->use_rate_select stayed false,
and execution fell back to intel_dp_set_sink_rates() where max_dprx_rate()
capped the maximum link rate to 540000 kHz.

With this change, drm_dp_read_edp_sink_rates() returns the unfiltered count,
so num_sink_rates is non-zero, intel_dp->use_rate_select is set to true, and
intel_dp_set_sink_rates() is skipped. When intel_dp_rate_limit_len() then
filters out the rates above 540000 kHz, intel_dp->num_sink_rates becomes 0
while intel_dp->use_rate_select remains true.

During connector initialization via intel_dp_init_connector() ->
intel_edp_init_connector() -> intel_edp_init_dpcd() ->
intel_edp_set_sink_rates(), the subsequent call to
intel_dp_set_common_link_params() -> intel_dp_get_common_rates() will then
hit both warnings and force common_rates[0] =3D 162000:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_get_common_rates() {
    drm_WARN_ON(display->drm,
                !intel_dp->num_source_rates || !intel_dp->num_sink_rates);

    *num_common_rates =3D intersect_rates(intel_dp->source_rates,
                                        intel_dp->num_source_rates,
                                        intel_dp->sink_rates,
                                        intel_dp->num_sink_rates,
                                        common_rates);

    /* Paranoia, there should always be something in common. */
    if (drm_WARN_ON(display->drm, *num_common_rates =3D=3D 0)) {
            common_rates[0] =3D 162000;
            *num_common_rates =3D 1;
    }
}

And during modeset link computation via intel_dp_compute_rate() ->
intel_dp_rate_select(), because intel_dp->use_rate_select is true while
intel_dp->num_sink_rates is 0, intel_dp_rate_select() will fail to find the
rate, warn, and return index 0:

drivers/gpu/drm/i915/display/intel_dp.c:intel_dp_rate_select() {
    int i =3D intel_dp_rate_index(intel_dp->sink_rates,
                                intel_dp->num_sink_rates, rate);

    if (drm_WARN_ON(display->drm, i < 0))
            i =3D 0;

    return i;
}

Should intel_dp_rate_limit_len() be applied to num_sink_rates before checki=
ng
if (num_sink_rates), and applied again if it falls back to
intel_dp_set_sink_rates()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-feat_link_=
cap-v4-0-a4f3f6e8cad9@bootlin.com?part=3D1
