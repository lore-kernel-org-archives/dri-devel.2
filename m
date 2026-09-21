Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EC6CC982E1
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:10:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F60810E4FA;
	Mon, 21 Sep 2026 07:10:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YNHGhFM0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DB17A10E4B0;
 Mon, 21 Sep 2026 07:10:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 24276600D1;
 Mon, 21 Sep 2026 07:10:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B6FD1F00893;
 Mon, 21 Sep 2026 07:10:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789974606;
 bh=zU7DwviVV4w3gwqIINq2ovAtABCjJKgf5MhOd5b/D5M=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YNHGhFM0bncMEhIEHjABrsq3T4VEho0aZsjFm+nZqmj4V4DtHe6qLZKRVJBvkl4Qb
 fNt8huUnjUSUJMImniVocyIBrMTeYlSLXYtQSbs0vaRTEnqPen8/0RuFU25Dt5wy1X
 H1139uaRkB32gIBuqsISvJ6SOfXnTtZ6+i2G+XeM1bqle6Gczg9gRuWCxqWzwuHEZb
 FIrk/8fNIe4hZsFblt4j+X+7+VKHyJdHsHcCTPY1VPukhb4ZJ+v8JEQl6MPsUwhPoQ
 tEOMVLvf7sX/OhESfHJ0El57pZaP+f3rhVkdiuHUiz6Rf/PUKwhhi/2oop6+wKpY6J
 CElVsQHXfUJnA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/i915/display: Replace bw_constrained with
 max_link_bpp_x16
To: "George Karagounis" <taterraster@gmail.com>
Cc: intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260919161927.98829-1-mail@taterr.org>
References: <20260919161927.98829-1-mail@taterr.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 07:10:06 +0000
Message-Id: <20260921071006.9B6FD1F00893@smtp.kernel.org>
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
- [Low] drm/i915/display: incomplete cleanup of bw_constrained flag
--

commit f4c7087cb31d33cb453437886f7788a5ffe134a2
Author: George Karagounis <taterraster@gmail.com>

drm/i915/display: Replace bw_constrained with max_link_bpp_x16

This commit replaces the legacy bw_constrained boolean flag checks with
direct comparisons against the max_link_bpp_x16 fixed-point API in both
intel_crt.c and intel_lvds.c.

> diff --git a/drivers/gpu/drm/i915/display/intel_lvds.c b/drivers/gpu/drm/=
i915/display/intel_lvds.c
> index 872753478cf21..6bbd13ab5da7b 100644
> --- a/drivers/gpu/drm/i915/display/intel_lvds.c
> +++ b/drivers/gpu/drm/i915/display/intel_lvds.c
[ ... ]
> @@ -443,10 +443,10 @@ static int intel_lvds_compute_config(struct intel_a=
tomic_state *state,
>  	else
>  		lvds_bpp =3D 6*3;
> =20
> -	/* TODO: Check crtc_state->max_link_bpp_x16 instead of bw_constrained */
> -	if (lvds_bpp !=3D crtc_state->pipe_bpp && !crtc_state->bw_constrained) {
> +	if (lvds_bpp !=3D crtc_state->pipe_bpp &&
> +	    crtc_state->max_link_bpp_x16 >=3D fxp_q4_from_int(lvds_bpp)) {

[Severity: Low]
Does this commit intentionally leave the bw_constrained flag definition and
other writes intact?

While this patch removes the readers of bw_constrained, the flag remains
defined in struct intel_crtc_state:

drivers/gpu/drm/i915/display/intel_display_types.h:struct intel_crtc_state {
...
	bool bw_constrained;
...
}

It also still appears to be stored whenever crtc_state->pipe_bpp >=20
fxp_q4_to_int(crtc_state->max_link_bpp_x16) during mode setting:

drivers/gpu/drm/i915/display/intel_display.c:intel_modeset_pipe_config() {
...
	crtc_state->bw_constrained =3D true;
...
}

Because the readers were removed, this causes unnecessary code complexity a=
nd
leaves behind a dead store. Is there a plan to remove the flag entirely, or
was this an oversight?

>  		drm_dbg_kms(display->drm,
> -			    "forcing display bpp (was %d) to LVDS (%d)\n",
> +			   "forcing display bpp (was %d) to LVDS (%d)\n",
>  			    crtc_state->pipe_bpp, lvds_bpp);
>  		crtc_state->pipe_bpp =3D lvds_bpp;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260919161927.9882=
9-1-mail@taterr.org?part=3D1
