Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03996C98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 09:51:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7132810E9B7;
	Thu, 24 Sep 2026 09:51:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Airun0+2";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABAB10E4BE;
 Thu, 24 Sep 2026 09:51:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E2800601DE;
 Thu, 24 Sep 2026 09:51:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5939E1F000FF;
 Thu, 24 Sep 2026 09:51:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790243493;
 bh=f3kwJnZglNAqTQJboG+Lpx0UMTRXfk6mZVk6/Cb5wVs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Airun0+2Cw8OJG8hxxO3vwTV7Re1tc5GWw1Ts77Tpd2jkN1W93VKn+OEllrIxz3EP
 dM/M90w0yhmjSIqwJTltQ6ojHbKjnq0sQwSlYBolV9yh6ofqctmxpsJKpLu5LEuxuY
 X+X0kI//kGTkLz+AC8XNX1bzqgh1Urzh6X3Z9EVggRrPoTiTNEDdPGFW3Mz5qHQ7KK
 /21+7SjiIrTiYCf76fhdEm8XlU5CEgH75m1aCSbt7UkIhr4BzeBv1v3EX/d2IZBxM3
 gjraGSFM1URkssWoCHqeUAKg27QsGoTyma9QUvzBGgjZGgJLOhIwlO1jLJuuxVtWFN
 eNDy4k2A5U2Gw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/i915/dp: fix PBN in ALLOCATE_PAYLOAD request
 to use actual video bandwidth
To: "Xiao Lu" <xiaolu.xie@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
In-Reply-To: <20260924094316.822211-2-xiaolu.xie@intel.com>
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
 <20260924094316.822211-1-xiaolu.xie@intel.com>
 <20260924094316.822211-2-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 09:51:32 +0000
Message-Id: <20260924095133.5939E1F000FF@smtp.kernel.org>
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
- [High] drm/i915/dp: DP MST VCPI timeslot mismatch and WARN_ON trigger
--

commit 2b87b995c0537aad3132b5f2622d64dea6c8fb7c
Author: Xiao Lu <xiaolu.xie@intel.com>

drm/i915/dp: fix PBN in ALLOCATE_PAYLOAD request to use actual video bandwi=
dth
   =20
This commit updates intel_dp_mtp_tu_compute_config() to separate the raw
video bandwidth PBN from the aligned hardware TU PBN. The raw PBN is now
passed to drm_dp_atomic_find_time_slots() to fix payload allocation
rejections.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
> index 6a869d0f6ffc0..4d088282df781 100644
> --- a/drivers/gpu/drm/i915/display/intel_dp_mst.c
> +++ b/drivers/gpu/drm/i915/display/intel_dp_mst.c

[ ... ]

> @@ -397,7 +398,21 @@ int intel_dp_mtp_tu_compute_config(struct intel_dp *=
intel_dp,
> =20
>  			slots =3D drm_dp_atomic_find_time_slots(state, &intel_dp->mst.mgr,
>  							      connector->mst.port,
> -							      dfixed_trunc(pbn));
> +							      raw_pbn);

[Severity: High]
Does this cause a mismatch in the programmed VCPI payload size?

By passing the unaligned raw_pbn here, the DRM core calculates an unaligned
VCPI timeslot allocation that is programmed into the downstream branch
device.=20

Since the i915 hardware transmitter still expects the lane-count aligned
remote_tu, the source hardware and branch device will now have mismatched
payload sizes. Can this mismatch break DP MST frame synchronization and
cause data drops or display corruption?

Additionally, this mismatch appears to deterministically trigger an existing
validation warning later in intel_dp_mtp_tu_compute_config():

	if (slots >=3D 0) {
		drm_WARN_ON(display->drm, slots !=3D crtc_state->dp_m_n.tu);
		break;
	}

Will this unconditionally fire during modesets where the required timeslots
are not a multiple of the lane count?

> +
> +			drm_dbg_kms(display->drm,
> +				    "MST TU %s pipe %c: clock=3D%d lanes=3D%d bpp=3D%d link_bpp=3D%d=
 fec=3D%d\n",
> +				    connector->base.name,
> +				    pipe_name(to_intel_crtc(crtc_state->uapi.crtc)->pipe),
> +				    crtc_state->port_clock, crtc_state->lane_count,
> +				    fxp_q4_to_int(bpp_x16), fxp_q4_to_int(link_bpp_x16),
> +				    crtc_state->fec_enable);
> +			drm_dbg_kms(display->drm,
> +				    "MST TU %s: overhead=3D%d raw_pbn=3D%d pbn=3D%d pbn_div=3D%d tu=
=3D%d slots=3D%d full_pbn=3D%d\n",
> +				    connector->base.name,
> +				    remote_bw_overhead, raw_pbn,
> +				    dfixed_trunc(pbn), dfixed_trunc(mst_state->pbn_div),
> +				    remote_tu, slots, connector->mst.port->full_pbn);
> =20
>  			/* TODO: Check this already in drm_dp_atomic_find_time_slots(). */
>  			if (slots > mst_state->total_avail_slots)

[Severity: High]
Does this limit check accurately reflect the required slots?

This check now validates the unaligned slots. Because the source hardware
uses remote_tu (which is aligned and thus potentially larger), could the
hardware's aligned timeslots exceed the physical 64-slot limit even if
the unaligned slots pass this check?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924094316.8222=
11-1-xiaolu.xie@intel.com?part=3D1
