Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA963CA9EC5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:34:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3896410E919;
	Mon, 12 Oct 2026 04:34:18 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EE41310E919;
 Mon, 12 Oct 2026 04:34:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5B313601FA;
 Mon, 12 Oct 2026 04:34:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF0B31F0089B;
 Mon, 12 Oct 2026 04:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791779651;
 bh=HOrkhh4SMY9YykuEdvG7oYrWTrVy4vas9oH7QRP8HYg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nFcmF4b+6kJ+hRRzvmAbBKQh5lSBcwVyZ9WOn9P1q98aTU8gZcPB/3k/eY+xp0Q8p
 nGbNRSje694hSOLguw5VfGUlNFATyXtEKxL30vI+XknP7iqDK9JiHb5bIfs4LoFt2Q
 P0STwoW16EXmUpZQY4eOHyzP5dgMVr+ptEYUZDLnhVwIu7J8DeO0bnJGBVXHLZUMvj
 jnGzzFKlZ9SnCuw95N3JnNoBOmNM1DStslKyadC87Yto38IJ/hPIomLUlhOzdNqHnX
 xhJz8w37kMgaD26043EhScUp5ppw/fUPXlnxZ1v3+aaDj7I2AbACuCqOZ0mQx89ed1
 yS59f5jURFL8g==
Message-ID: <sashiko-outbox-167610@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 18/56] drm/i915/hdmi: Drive per-lane TxFFE during FRL
 link training
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-19-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-19-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:34:10 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/i915/hdmi: FRL link training pattern dropped and hardware upda=
te inverted on FFE change
- [Medium] drm/i915/hdmi: FFE_Levels unconditionally advertised as 3 for al=
l FRL rates
- [Medium] drm/i915/hdmi: Premature PHY TxFFE0 programming in LTS:2 before =
FRL is enabled
--

commit 87ef0f5ae2b4f4dd3dfe980d42af7aa5011177a4
Author: Suraj Kandpal <suraj.kandpal@intel.com>

drm/i915/hdmi: Drive per-lane TxFFE during FRL link training

This commit hooks the per-lane TxFFE state into the HDMI FRL Link
Training Sequence. It configures the SCDC FFE_Levels, sets initial
TxFFE0 levels upon FRL enable, and handles sink-requested FFE
changes during LTS:3 lane training.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index 0873ecd6ef714..1aa6f71fbfce2 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> @@ -3619,7 +3620,8 @@ intel_hdmi_frl_prepare_lts2(struct intel_encoder *e=
ncoder,
>  	if (ret & SCDC_FLT_UPDATE)
>  		clear_scdc_update_flags(encoder, SCDC_FLT_UPDATE);
> =20
> -	/* #TODO: Source shall program TxFFE =3D 0 for all active lanes */
> +	/* ffe_level[] was cleared by intel_hdmi_reset_frl_config(). */
> +	encoder->set_signal_levels(encoder, crtc_state);

[Severity: Medium]
The commit message explicitly states: "On LTS:3 entry, after enabling
TRANS_HDMI_FRL_ENABLE, call encoder->set_signal_levels() so the PHY is
programmed to TxFFE0".

However, does this code call encoder->set_signal_levels() prematurely? It
appears to execute inside intel_hdmi_frl_prepare_lts2(), which runs during
the LTS:2 phase before FRL mode is actually enabled via
TRANS_HDMI_FRL_ENABLE in intel_hdmi_frl_train_lts3().

If the underlying PHY requires the transcoder to be in FRL mode to accept
or apply FRL signal levels properly, could this premature sequence cause
hardware misconfiguration?

[ ... ]
> @@ -3684,16 +3688,20 @@ intel_hdmi_train_lanes(struct intel_encoder *enco=
der,
>  		if (ltp[lane] =3D=3D SCDC_FRL_LTP3)
>  			continue;
> =20
> -		if (ltp[lane] >=3D SCDC_FRL_LTP1 && ltp[lane] <=3D SCDC_FRL_LTP8)
> +		if (ltp[lane] >=3D SCDC_FRL_LTP1 && ltp[lane] <=3D SCDC_FRL_LTP8) {
>  			write_buf |=3D TRANS_HDMI_FRL_LTP(ltp[lane], lane);
> -
> -		/* #TODO handle FFE change */
> -		else if (ltp[lane] =3D=3D SCDC_FRL_CHNG_FFE)
> -			continue;
> +		} else if (ltp[lane] =3D=3D SCDC_FRL_CHNG_FFE &&
> +			   intel_hdmi->frl.ffe_level[lane] < intel_hdmi->frl.max_ffe_level) {
> +			intel_hdmi->frl.ffe_level[lane]++;
> +			ffe_changed =3D true;
> +		}
>  	}
> =20
>  	intel_de_write(display, TRANS_HDMI_FRL_TRAIN(display, trans), write_buf=
);
> =20
> +	if (ffe_changed)
> +		encoder->set_signal_levels(encoder, crtc_state);

[Severity: High]
Does this implementation inadvertently clear the link training pattern when
the sink requests an FFE change?

When ltp[lane] =3D=3D SCDC_FRL_CHNG_FFE is evaluated, the FFE level is
incremented, but no pattern bits are preserved in write_buf for that lane.
Since write_buf is initially 0, intel_de_write() will overwrite the
TRANS_HDMI_FRL_TRAIN register with 0 (NO_LTP) for that lane, which could
break the link training sequence.

Additionally, the HDMI 2.1 specification dictates that when a sink requests
an FFE level change (0xE), the source must first update the FFE level on
the lane and then re-transmit the same Link Training Pattern. Here,
intel_de_write() is executed before the PHY FFE level update in
encoder->set_signal_levels(). Does this ordering violate the hardware
sequencing requirement?

[ ... ]
> @@ -3791,9 +3799,9 @@ static int get_next_frl_rate(int curr_rate_gbps)
>  	return -EINVAL;
>  }
> =20
> -static int get_ffe_level(int rate_gbps)
> +static int get_max_ffe_level(int rate_gbps)
>  {
> -	return 0;
> +	return 3;
>  }

[Severity: Medium]
Does unconditionally returning 3 here violate the HDMI 2.1 specification
for lower FRL rates?

The specification (Section 10.3.3.4.1) mandates that for FRL rates of 3
Gbps and 6 Gbps (total link rates of 9, 18, 24 Gbps), the source shall set
the FFE_Levels field to 0.

Advertising 3 at these lower rates is a spec violation and might lead to
unexpected sink behavior, false FFE adjustment requests, or compliance test
failures. Should this function evaluate rate_gbps before returning the max
level?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D18
