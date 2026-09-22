Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A834FC982F1
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 09:35:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C767910E6B3;
	Tue, 22 Sep 2026 09:35:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cN9Uh1qn";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B663510E6B3;
 Tue, 22 Sep 2026 09:35:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 893CF40948;
 Tue, 22 Sep 2026 09:35:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F5F71F000FF;
 Tue, 22 Sep 2026 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790069729;
 bh=i/YmOC0ZkiWQT8Oub82T35sLAq9/nsr14gn5IuQdzJg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cN9Uh1qnZ5/OANAAqrTeFmxVMfzoKFSizom1JZ+fir1tvgE69dsjuY0Lykrjr2q1P
 u7vZ84FlN913PuuyVZhqGTYvxzpuPX7kpiadhTjLw2DNXuWWq96qtmm7ScrQQs1rMs
 10jP+oxyHrIPELdjmAYJv8jp3Mwe82TJJHmxTlkJxuYhhwfewvpZpG1/vgRzSt9Wfy
 0J79am/0+dcGQcdf55ojt2jRKqryVwxGm1OKl60anNt/7L73ShAwWefMLJ23wcxc0q
 Lev6GG14pfLglbLJX0EqArBlrT5k8A5Squaqj59RAx7nuhewnFXGa2Abf+TPqHpEQw
 SUdDtpunnWZGw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/i915/dp: fix PBN in ALLOCATE_PAYLOAD request
 to use actual video bandwidth
To: "Xiao Lu" <xiaolu.xie@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
In-Reply-To: <20260922092647.2263962-2-xiaolu.xie@intel.com>
References: <20260922092647.2263962-1-xiaolu.xie@intel.com>
 <20260922092647.2263962-2-xiaolu.xie@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 09:35:28 +0000
Message-Id: <20260922093529.4F5F71F000FF@smtp.kernel.org>
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
- [High] drm/i915/dp: Timeslot accounting mismatch and WARN_ON due to unali=
gned slots
--

commit 42ac7363ce1083ef4680462acc3e4eec1ddf8e96
Author: Xiao Lu <xiaolu.xie@intel.com>
Subject: drm/i915/dp: fix PBN in ALLOCATE_PAYLOAD request to use actual vid=
eo bandwidth

This commit modifies intel_dp_mtp_tu_compute_config() to separate the actual
video bandwidth (raw_pbn) from the aligned PBN used for hardware TU
programming. It passes raw_pbn to drm_dp_atomic_find_time_slots() so that t=
he
MST core allocates payload bandwidth reflecting true stream requirements ra=
ther
than incorporating link-rate-specific TU granularity.

> diff --git a/drivers/gpu/drm/i915/display/intel_dp_mst.c b/drivers/gpu/dr=
m/i915/display/intel_dp_mst.c
> index 0c362784afe4a..31e846aadcf6c 100644
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
Does this cause a timeslot accounting mismatch and a kernel warning?

By passing raw_pbn to drm_dp_atomic_find_time_slots() in
intel_dp_mtp_tu_compute_config(), the function calculates and returns an
unaligned VCPI timeslot allocation. However, the Intel TX hardware requires
timeslots to be aligned (e.g., to a 4-slot boundary for a 1-lane link).

Because the returned slots is unaligned, it diverges from the hardware-alig=
ned
dp_m_n.tu. This leads to two issues:

1. The boundary check immediately following this call:

    if (slots > mst_state->total_avail_slots)
        slots =3D -EINVAL;

incorrectly uses the unaligned slots value rather than checking the final
aligned remote_tu that is actually programmed into the hardware. This might
bypass the availability check for streams that exceed link capacity when
aligned.

2. The assertion further down in the function:

    drm_WARN_ON(display->drm, slots !=3D crtc_state->dp_m_n.tu);

will falsely and reliably trigger a kernel stack trace on any successful
modeset where alignment padding was applied (like on a 1-lane or 2-lane link
where 4 / lane_count alignment changes the raw TU count).

Additionally, this mismatch between the downstream branch device's DPCD
payload table (receiving the unaligned VCPI slot count) and the Intel TX
(transmitting the padded TU count) violates Bspec synchronization requireme=
nts
and risks payload corruption.

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922092647.2263=
962-1-xiaolu.xie@intel.com?part=3D1
