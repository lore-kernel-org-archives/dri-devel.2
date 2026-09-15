Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23BCAC88E7D
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 18:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2781A10E292;
	Tue, 15 Sep 2026 18:57:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="f6t5Y1CO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08E0F10E28C;
 Tue, 15 Sep 2026 18:57:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E459A43616;
 Tue, 15 Sep 2026 18:57:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDD061F00893;
 Tue, 15 Sep 2026 18:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789498624;
 bh=eSb0eDaEDYPgjzl7eRqRrnQQKmrtt8kbpYF42zOmOCs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=f6t5Y1COxfIl4J6EVf2lsJatX0/Im9SN4hqKWRc5RdTz6nZDMg1B8XbYqP1Ehgg+M
 9KoZhMONLCzTrKJfn+z9vq06QRYYkMXOQfceUz3/ZHl6W4eRCtVgzcE+W3sdlHyzaB
 MZ1ewG9vVM/NR5vZC59aOj+7OAzhRcktFU+4iUk5tDm//FxCMkTwXNfgvPUZr/F22i
 FvK9PrE6nysV4zlZn4ea+f5cB0PmR26QTVUUro9B5D8OZE7uWA+MV52jQ91QlphMRc
 pdZgNrm6qhUhQpnHkhTsU3zcxRFR0wHrOWwmgB61O8H9cDojQYFPivzW88AM6QpWNQ
 f3F/G0vNirOmA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 14/18] drm/i915/alpm: Replace is_edp() with
 alpm_is_possible()
To: "Animesh Manna" <animesh.manna@intel.com>
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
In-Reply-To: <20260915180449.277933-15-animesh.manna@intel.com>
References: <20260915180449.277933-1-animesh.manna@intel.com>
 <20260915180449.277933-15-animesh.manna@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 15 Sep 2026 18:57:02 +0000
Message-Id: <20260915185703.DDD061F00893@smtp.kernel.org>
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
- [High] drm/i915/alpm: invalid DPCD capability checks in intel_alpm_is_pos=
sible()
- [High] drm/i915/alpm: ALPM_CTL left enabled on hot-unplug due to dynamic =
capability checks
--

commit f95070b21da14e9f299aa7eaa97682597723ecc9
Author: Animesh Manna <animesh.manna@intel.com>
Subject: drm/i915/alpm: Replace is_edp() with alpm_is_possible()

This commit introduces a separate intel_alpm_is_possible() function to
check for ALPM capability from DPCD information, replacing earlier checks
that relied solely on the panel being eDP.

> diff --git a/drivers/gpu/drm/i915/display/intel_alpm.c b/drivers/gpu/drm/=
i915/display/intel_alpm.c
> index 06c1a59aa2c51..29a93a252fe9b 100644
> --- a/drivers/gpu/drm/i915/display/intel_alpm.c
> +++ b/drivers/gpu/drm/i915/display/intel_alpm.c

[ ... ]

> @@ -69,6 +69,13 @@ void intel_alpm_init(struct intel_dp *intel_dp)
>  	mutex_init(&intel_dp->alpm.lock);
>  }
> =20
> +bool intel_alpm_is_possible(struct intel_dp *intel_dp)
> +{
> +	return (intel_dp->alpm_dpcd ||
> +		intel_dp->lttpr_common_caps[DP_LTTPR_ALPM_CAPABILITIES -
> +					    DP_LT_TUNABLE_PHY_REPEATER_FIELD_DATA_STRUCTURE_REV]);
> +}

[Severity: High]
Does this logic correctly enforce DP requirements for ALPM?

It looks like this uses a logical OR instead of requiring both the sink and
LTTPR to support ALPM. Additionally, this seems to access the raw capability
byte without masking the specific ALPM capability bit, which could mean
reserved bits will be evaluated as true.=20

Can this break standard DP link training invariants when connecting a displ=
ay
with LTTPRs that support ALPM while the sink does not, or when a sink has
reserved bits set but no ALPM support?

[ ... ]

> @@ -832,7 +839,7 @@ void intel_alpm_lobf_disable(const struct intel_crtc_=
state *new_crtc_state)
> =20
>  		intel_dp =3D enc_to_intel_dp(encoder);
> =20
> -		if (!intel_dp_is_edp(intel_dp))
> +		if (!intel_alpm_is_possible(intel_dp))
>  			continue;
> =20
>  		mutex_lock(&intel_dp->alpm.lock);

[Severity: High]
Could this dynamic capability check cause ALPM_CTL to be left enabled during
a hot-unplug event?

During a hot-unplug event, the cached DPCD capabilities like alpm_dpcd can
be cleared before the teardown hooks execute. Because this teardown function
checks these dynamic capabilities via intel_alpm_is_possible() instead of
the old hardware state, it might return early and fail to clear the ALPM_CTL
hardware register.

Would this leave the transcoder with ALPM enabled when it is supposed to be
disabled, potentially causing state mismatches on subsequent modesets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260915180449.2779=
33-1-animesh.manna@intel.com?part=3D14
