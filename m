Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A92DC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3073D10EB0D;
	Tue, 15 Sep 2026 18:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="fCS0zLm5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E61210E4D7;
 Tue, 15 Sep 2026 18:53:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4EC3941877;
 Tue, 15 Sep 2026 18:53:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03A601F00893;
 Tue, 15 Sep 2026 18:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498434;
 bh=0RvZTwaFlsnqErVlhdUZ2rvmiqrMxTlZg0/hakrG2vU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=fCS0zLm50I8m+9tOjYKkUyw3+w4MLR57QcPFqPg0fgRal/vn2wYXZAhYBLho4/Hud
 Ov4CaFXVBHrfgwdEPBeHmW2DRFGFJVo12ekXnqXw6tSsm3HnAcAE3JrG3anjZKybUj
 /jnJST0Ms6qpBDMQzeMdIl5/3MuIQPnI6yNNk880xjVaLw3z4n9AbS8nkPaiKOXUEs
 9o2E45rnJIa7aI6yu6+8NBU7sarTyu83Uf99U6x8KGkmgVO9ldrXR6IUSVFSeHMmLP
 o51+yjRuSR/yGashlvVrCJWnuJBCkiqnic6beYQEQ2bRQlCXRAMA2FpbEsec0BTEpX
 EZvCBjZDq8UhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/18] drm/i915/alpm: Half LFPS cycle calculation
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-10-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-10-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:53:53 +0000
Message-Id: <20260915185354.03A601F00893@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] display/alpm: uninitialized stack variables used for ALPM hardware=
 programming
--

commit b718ea1f4bfa5d8848c313251d36c92815933b23
Author: Animesh Manna <animesh.manna@intel.com>

drm/i915/alpm: Half LFPS cycle calculation

This commit adds support for half LFPS cycle calculation for DP2.1 ALPM
as dependent parameters got changed.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index cb24bba801a19..14ecb27095b29 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c
[ ... ]
> +static void lnl_get_lfps_period_min_max_time(const struct intel_crtc_sta=
te *crtc_state,
> +					     int *min, int *max)
> +{
> +	if (intel_crtc_has_type(crtc_state, INTEL_OUTPUT_EDP)) {
> +		if (crtc_state->port_clock < 540000) {
> +			*min =3D 65 * LFPS_CYCLE_COUNT;
> +			*max =3D 75 * LFPS_CYCLE_COUNT;
> +		} else {
> +			*min =3D 140;
> +			*max =3D 800;
> +		}
> +	}
> +}

[Severity: High]
Does this function leave min and max completely uninitialized for
non-eDP configurations?

For instance, when connecting an external DisplayPort sink on LunarLake
with ALPM capabilities, intel_crtc_has_type(..., INTEL_OUTPUT_EDP) would
be false, and the function returns without setting these parameters.

[ ... ]
>  static int get_lfps_cycle_time(const struct intel_crtc_state *crtc_state)
>  {
>  	int tlfps_cycle_min, tlfps_cycle_max;
> =20
> -	get_lfps_cycle_min_max_time(crtc_state, &tlfps_cycle_min,
> -				    &tlfps_cycle_max);
> +	get_lfps_period_min_max_time(crtc_state, &tlfps_cycle_min,
> +				     &tlfps_cycle_max);
> =20
>  	return tlfps_cycle_min +  (tlfps_cycle_max - tlfps_cycle_min) / 2;
>  }

[Severity: High]
Can these stack variables be consumed while still uninitialized?

Because lnl_get_lfps_period_min_max_time() lacks a non-eDP fallback, it
appears tlfps_cycle_min and tlfps_cycle_max could retain their uninitialized
stack values here when called for a standard DisplayPort setup.

These garbage values would then be used in the arithmetic calculation and
subsequently programmed into hardware ALPM registers. Could this potentially
cause display link corruption, link training failures, or hardware timeouts?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D9
