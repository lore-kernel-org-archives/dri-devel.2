Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69470C5AD5A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 10:56:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E1BC10E403;
	Wed, 12 Aug 2026 10:56:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AWJWLq6v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C747B10E403
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 10:56:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD50860A7E;
 Wed, 12 Aug 2026 10:56:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39CBA1F000E9;
 Wed, 12 Aug 2026 10:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786532209;
 bh=u031abIBDZDb1SxKCQujYUv4dt3cMpEDPvK3Gpay2OY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AWJWLq6vSSeaYKRxQcdMX9c92PpJ4mKrh8ptWPlKRqnu+pFuEdsMcCzk3l0hIoa9h
 +zkSr1VBvse07C6o7jcHCc7z1Oh7WmCQMDdYdRtIbgb48xWl/n3iEkvwn2TCGENgBe
 bXoNM1HEexE0JaEWJXttAhc2ua8XIlQt11YAVe2lJV68L1U/Q5oatwY/cggP5GmDtp
 xwiTo9rHp2Ww9bk0Tc038cwtIsE4tUot7NWswU7vmPRaxqXVCIHNlsQE2MFvtQIRAn
 A2Dk1ZlmkPiY34Gqr0D7lFnPKjh8km9zMbSiqs9mfc+j1v4y8tnpbkO8n/lJvOYixa
 ljNC8hKhv9V2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/rockchip: vop2: Scale the AXI clock to the
 bandwidth the mode needs
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260812104909.6390-1-royalnet026@gmail.com>
References: <20260812104909.6390-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 10:56:48 +0000
Message-Id: <20260812105649.39CBA1F000E9@smtp.kernel.org>
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
- [High] Lockless access to `crtc->state` of unrelated CRTCs causes data ra=
ces and potential Use-After-Free during concurrent atomic commits.
--

--- Patch [1]: [PATCH] drm/rockchip: vop2: Scale the AXI clock to the bandw=
idth the mode needs ---
commit a53c1bd3571ebff2298a00e2f974ac4c2299ce6e
Author: Igor Paunovic <royalnet026@gmail.com>

drm/rockchip: vop2: Scale the AXI clock to the bandwidth the mode needs

This commit dynamically scales the AXI clock on RK3588 devices to meet the
bandwidth requirements of active video ports. It calculates the necessary
clock rate by checking the pixel rate of all active CRTCs to prevent
hardware FIFO underruns.

Link: https://lore.kernel.org/all/20260808104240.13776-1-royalnet026@gmail.=
com/
Link: https://lore.kernel.org/all/20767137.geO5KgaWL5@diego/ [1]

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 4cce3e336f5b3..5dda1fc1c8a14 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -1008,6 +1022,32 @@ static bool vop2_gamma_lut_in_use(struct vop2 *vop=
2, struct vop2_video_port *vp)
>  	return gamma_en_vp_id !=3D nr_vps && gamma_en_vp_id !=3D vp->id;
>  }
> =20
> +/*
> + * Pick the AXI clock rate that satisfies every video port that is scann=
ing
> + * out.  Taking the maximum over the active ports rather than counting t=
hem
> + * means a port being disabled can never drop the rate below what a port=
 that
> + * is still scanning needs.
> + */
> +static void vop2_update_aclk_rate(struct vop2 *vop2)
> +{
> +	unsigned long rate =3D vop2->aclk_rate_normal;
> +	struct drm_crtc *crtc;
> +
> +	if (vop2->version !=3D VOP_VERSION_RK3588)
> +		return;
> +
> +	drm_for_each_crtc(crtc, vop2->drm) {
> +		if (!crtc->state->active)
> +			continue;
> +
> +		if (crtc->state->adjusted_mode.crtc_clock > VOP2_HIGH_BW_PIXCLK_KHZ &&
> +		    rate < VOP2_ACLK_RATE_HIGH)
> +			rate =3D VOP2_ACLK_RATE_HIGH;
> +	}

[Severity: High]
Is it safe to access the state of unrelated CRTCs locklessly here?

When vop2_update_aclk_rate() is called from vop2_crtc_atomic_enable() or
vop2_crtc_atomic_disable(), the thread typically only holds the modeset
lock for the specific CRTC being committed, along with the driver-private
vop2_lock.

If userspace performs a concurrent non-blocking atomic commit on a
different CRTC, drm_atomic_helper_swap_state() could swap that CRTC's
state pointer and free the old state since it doesn't acquire the private
vop2_lock. Could this result in a use-after-free when reading
crtc->state->active or crtc->state->adjusted_mode.crtc_clock?

> +
> +	clk_set_rate(vop2->aclk, rate);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812104909.6390=
-1-royalnet026@gmail.com?part=3D1
