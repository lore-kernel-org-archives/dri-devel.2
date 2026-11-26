Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79399606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 14:39:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bUQ4NgE+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CD44A10EA39;
	Thu, 26 Nov 2026 14:39:41 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B6A710EA39
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 14:39:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 52DD8423D2;
 Thu, 26 Nov 2026 14:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5131F000E0;
 Thu, 26 Nov 2026 14:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795703975;
 bh=SO25TnOaz9O7v2K8b/u0nAWka9I2EYBZdsquIujm1XY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bUQ4NgE+qQ61XvnLxrc4EH8YX6rs9t85h+R6XygKIEjGNEy9k0TjPpcdvOwM6ivnb
 JWl6oU008wVSHqvhQjIJxmnQeiKMaIuUk8L2EKop0SAoxT6TRKizKdsikwyoQVXPD4
 Yx0lwYpG3R36YWUjFGCcDwyDye2j2oxCEvr2IcSM1mGxqbwucPkKvS10/v0SS99y+e
 smu71C3FiE74lKJEB50EXZekLexLn4ibFUqqI9Yl/a7zDXniWVWB6kiftuSk/aUNX5
 dcrjs+XVW9gHQo3TYUUPzMF+tx7YpYA+Jz4E/wcvWN2Njg/8K+nDeTi8PAUPuR97TF
 OgF9Xt5zKJ8jA==
Message-ID: <sashiko-outbox-235735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/msm/dp: clear AUX_TRANS_CTRL on reset and enable
 HPD_REFTIMER
To: "Robert Ijtsma" <robertijtsma@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-drm-msm-dp-aux-resume-v2-1-3324420b6770@gmail.com>
References: <20261126-drm-msm-dp-aux-resume-v2-1-3324420b6770@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 14:39:35 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/msm/dp: unreachable is_edp fallback in
  msm_dp_aux_should_reset()
- [Medium] drm/msm/dp: msm_dp_aux_transfer() skips phy_calibrate() on
  DP_AUX_ERR_TOUT
--

commit c2e9bc4891741d368936607a2c4a882af3e31c41
Author: Robert Ijtsma <robertijtsma@gmail.com>

drm/msm/dp: clear AUX_TRANS_CTRL on reset and enable HPD_REFTIMER

This commit clears REG_DP_AUX_TRANS_CTRL during AUX reset, manages
DP_DP_HPD_REFTIMER_ENABLE across msm_dp_aux_enable() and
msm_dp_aux_disable(), and resets the AUX controller on transfer errors and
DP_AUX_ERR_TOUT timeouts even when internal HPD is disabled.

> diff --git a/drivers/gpu/drm/msm/dp/dp_aux.c b/drivers/gpu/drm/msm/dp/dp_=
aux.c
> index b52393dcc0670..9a996fe7dbddb 100644
> --- a/drivers/gpu/drm/msm/dp/dp_aux.c
> +++ b/drivers/gpu/drm/msm/dp/dp_aux.c

[ ... ]

> @@ -101,11 +108,23 @@ static void msm_dp_aux_enable(struct msm_dp_aux_pri=
vate *aux)
> =20
>  static void msm_dp_aux_disable(struct msm_dp_aux_private *aux)
>  {
> -	u32 aux_ctrl;
> +	u32 aux_ctrl, reftimer;
> =20
>  	aux_ctrl =3D msm_dp_read_aux(aux, REG_DP_AUX_CTRL);
>  	aux_ctrl &=3D ~DP_AUX_CTRL_ENABLE;
>  	msm_dp_write_aux(aux, REG_DP_AUX_CTRL, aux_ctrl);
> +
> +	reftimer =3D msm_dp_read_aux(aux, REG_DP_DP_HPD_REFTIMER);
> +	reftimer &=3D ~DP_DP_HPD_REFTIMER_ENABLE;
> +	msm_dp_write_aux(aux, REG_DP_DP_HPD_REFTIMER, reftimer);
> +}
> +
> +static bool msm_dp_aux_should_reset(struct msm_dp_aux_private *aux)
> +{
> +	if (msm_dp_read_aux(aux, REG_DP_DP_HPD_CTRL) & DP_DP_HPD_CTRL_HPD_EN)
> +		return msm_dp_aux_is_link_connected(&aux->msm_dp_aux);
> +
> +	return aux->is_edp || aux->enable_xfers;
>  }

[Severity: Medium]
Can aux->is_edp ever be reached in msm_dp_aux_should_reset()?

For eDP instances, msm_dp_pm_runtime_resume() unconditionally calls
msm_dp_aux_hpd_enable(), which sets DP_DP_HPD_CTRL_HPD_EN in
REG_DP_DP_HPD_CTRL:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_pm_runtime_resume() {
	...
	msm_dp_display_host_init(dp);
	if (dp->msm_dp_display.is_edp) {
		msm_dp_aux_hpd_enable(dp->aux);
		msm_dp_display_host_phy_init(dp);
	}
	...
}

Because DP_DP_HPD_CTRL_HPD_EN is always set while eDP is active,
msm_dp_aux_should_reset() always takes the first branch and checks
msm_dp_aux_is_link_connected().  On eDP boards where the SoC internal HPD
pin is not wired (such as panels using no-hpd or GPIO HPD),
msm_dp_aux_is_link_connected() returns 0 and skips resetting the AUX
controller on transfer failures or timeouts.  Should aux->is_edp be
checked before testing DP_DP_HPD_CTRL_HPD_EN?

> @@ -412,7 +431,7 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux =
*msm_dp_aux,
>  				phy_calibrate(aux->phy);
>  		}
>  		/* reset aux if link is in connected state */
> -		if (msm_dp_aux_is_link_connected(msm_dp_aux))
> +		if (msm_dp_aux_should_reset(aux))
>  			msm_dp_aux_reset(aux);
>  	} else {
>  		aux->retry_cnt =3D 0;
> @@ -432,6 +451,8 @@ static ssize_t msm_dp_aux_transfer(struct drm_dp_aux =
*msm_dp_aux,
>  			msg->reply =3D aux->native ? DP_AUX_NATIVE_REPLY_NACK : DP_AUX_I2C_RE=
PLY_NACK;
>  			break;
>  		case DP_AUX_ERR_TOUT:
> +			if (msm_dp_aux_should_reset(aux))
> +				msm_dp_aux_reset(aux);
>  			ret =3D -ETIMEDOUT;
>  			break;
>  		}

[Severity: Medium]
Does handling DP_AUX_ERR_TOUT in the else branch bypass phy_calibrate()
across repeated AUX timeouts?

With DP_DP_HPD_REFTIMER_ENABLE now always enabled in msm_dp_aux_enable(),
wire timeouts raise DP_INTR_TIMEOUT and complete aux->comp with
aux->aux_error_num =3D DP_AUX_ERR_TOUT before the software timeout in
msm_dp_aux_cmd_fifo_tx(), so msm_dp_aux_cmd_fifo_tx() returns ret >=3D 0.
The else branch then zeroes aux->retry_cnt =3D 0 before entering
case DP_AUX_ERR_TOUT, and because msm_dp_aux_reset() now resets the
controller cleanly for the next attempt, subsequent timeouts also complete
via DP_AUX_ERR_TOUT without ever incrementing aux->retry_cnt or calling
phy_calibrate(aux->phy) every MAX_AUX_RETRIES native attempts.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-drm-msm-dp=
-aux-resume-v2-1-3324420b6770@gmail.com?part=3D1
