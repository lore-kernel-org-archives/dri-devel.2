Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52AAACA9ED8
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:47:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A0DE10EC87;
	Mon, 12 Oct 2026 04:47:37 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD6B910E3EA;
 Mon, 12 Oct 2026 04:47:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id DD542601FA;
 Mon, 12 Oct 2026 04:47:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D7F01F0089B;
 Mon, 12 Oct 2026 04:47:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791780449;
 bh=zI3rhu57Kdp+EqB5KP5HRJfu0lpVTV/5n3g+QbfnOxo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=itDCLLNZeMHwSn+KbnTmG/uc1H+n2gsU4TqVVhFMm+UHlXs31m2ep/EUdX5DeHXKY
 7CmL9YiYNqagXlTAHQFy0IJEZwVCet9TR2Q+BstFLFzwaX8GBEZih9Dw3hsLdpK8O2
 H3zfNMBsGKNwO8aNY3S5QyrvZgZvTncLXco39eCAss95iHQlCZri2Niwcv/SEBCX6g
 Otr9xIXDx3ciocL5JobSrF7fgdGdYaLxVnKYsgh6lz9bVULTd+ibhxPyxKzMusfhFq
 PbU+RxHiK+C/IgLNRU+a/PNuOzqbxMOfhultfIeI4Njumppa3g/8MWoRUN58TmCqHk
 e8BeHPhvllzRw==
Message-ID: <sashiko-outbox-167626@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 16/56] drm/i915/hdmi: Reduce FRL rate cap on rate
 change during training
To: "Ankit Nautiyal" <ankit.k.nautiyal@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20261012035806.3361439-17-ankit.k.nautiyal@intel.com>
References: <20261012035806.3361439-1-ankit.k.nautiyal@intel.com>
 <20261012035806.3361439-17-ankit.k.nautiyal@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 04:47:28 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] drm/i915/hdmi: FRL training infinite retry loop on rate change at =
9 Gbps
- [High] drm/i915/hdmi: Sleeping function read_poll_timeout called in atomi=
c encoder enable callback
--

commit 3ebcdfcc6e404185a2b52af7506a3997a1901b79
Author: Ankit Nautiyal <ankit.k.nautiyal@intel.com>

drm/i915/hdmi: Reduce FRL rate cap on rate change during training

If the sink requests a rate change during FRL Link training, reduce
frl.rate_cap to the next lower FRL rate. The next mode compute then
uses this lower rate cap, so we do not attempt the failing rate again.

> diff --git a/drivers/gpu/drm/i915/display/intel_hdmi.c b/drivers/gpu/drm/=
i915/display/intel_hdmi.c
> index fa4e5f0f567b0..11b4554e87bd6 100644
> --- a/drivers/gpu/drm/i915/display/intel_hdmi.c
> +++ b/drivers/gpu/drm/i915/display/intel_hdmi.c
[ ... ]
> @@ -3779,6 +3791,7 @@ int intel_hdmi_start_frl(struct intel_encoder *enco=
der,
>  	int req_rate =3D crtc_state->frl.required_lanes * crtc_state->frl.requi=
red_rate;
>  	int ffe_level =3D get_ffe_level(req_rate);
>  	enum frl_lt_status status;
> +	int next_rate =3D -EINVAL;
> =20
>  	if (!crtc_state->frl.enable)
>  		return 0;

[Severity: High]
Does this code call sleeping functions from an atomic context?

The DRM subsystem guide explicitly defines encoder atomic enable/disable
callbacks as executing in an atomic context where sleeping is forbidden. Th=
is
patch modifies intel_hdmi_start_frl() which is wired into the atomic encoder
enable callback path later in this patch series.

intel_hdmi_start_frl() relies on frl_train_complete_ltsp() and
intel_hdmi_frl_train_lts3() which both use the read_poll_timeout() macro
with a sleep_us parameter of 1000:

frl_train_complete_ltsp():
	ret =3D read_poll_timeout(get_frl_update_flags, update_flags,
				update_flags < 0 ||
				(update_flags & (SCDC_FRL_START | SCDC_FLT_UPDATE)),
				1000, FLT_UPDATE_TIMEOUT_MS * USEC_PER_MSEC,
				false, encoder);

intel_hdmi_frl_train_lts3():
	read_poll_timeout(intel_hdmi_train_lanes, status,
			  done,
			  1000, FLT_TIMEOUT_MS * USEC_PER_MSEC,
			  false, encoder, crtc_state, ffe_level);

Providing a non-zero sleep parameter causes the macro to use usleep_range()
internally, which sleeps. Executing usleep_range() in this atomic context
violates subsystem guidelines and causes kernel warnings and potential
deadlocks.

[ ... ]
> @@ -3812,10 +3825,22 @@ int intel_hdmi_start_frl(struct intel_encoder *en=
coder,
>  			    connector->base.id, connector->name,
>  			    intel_hdmi->frl.rate_gbps);
>  		return 0;
> -	default:
> +	case FRL_TRAIN_STOP:
> +		next_rate =3D 0;
> +		break;
> +	case FRL_CHANGE_RATE:
> +		next_rate =3D get_next_frl_rate(req_rate);
>  		break;
> +	case FRL_TRAIN_RETRAIN:
> +		fallthrough;
> +	default:
> +		goto ltsl_tmds_mode;
>  	}
> =20
> +	if (next_rate >=3D 0)
> +		intel_hdmi->frl.rate_cap =3D next_rate;

[Severity: High]
Can this result in an infinite retry loop when the rate change happens at
9 Gbps?

If the current rate is already the minimum valid FRL rate (9 Gbps),
get_next_frl_rate(9) returns -EINVAL. In intel_hdmi_start_frl(), next_rate
becomes -EINVAL (< 0), causing the code to skip updating
intel_hdmi->frl.rate_cap, leaving it at 9 Gbps.

Because the rate cap was not lowered to 0 (which is required to disable FRL
and force a TMDS fallback, as correctly handled for FRL_TRAIN_STOP), the ne=
xt
mode compute will see the exact same 9 Gbps rate cap and attempt FRL
training at 9 Gbps again, leading to an infinite retry loop.

> +
> +ltsl_tmds_mode:
>  	if (crtc_state->frl.enable && !intel_hdmi->frl.trained)
>  		drm_err(display->drm,
>  			"[CONNECTOR:%d:%s] FRL Training Failed with rate=3D%d\n",

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261012035806.3361=
439-1-ankit.k.nautiyal@intel.com?part=3D16
