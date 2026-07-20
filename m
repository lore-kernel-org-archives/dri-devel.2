Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE8BC4451B
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 06:27:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6111610E69A;
	Mon, 20 Jul 2026 06:27:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="J4gduUM7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83EA310E69A
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 06:27:49 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6A2EF43241;
 Mon, 20 Jul 2026 06:27:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FE681F000E9;
 Mon, 20 Jul 2026 06:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784528869;
 bh=I+aMCzQGAxTFasttRnqWh7yEQWdDO2oCsS4owmuqlz4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=J4gduUM7QTlX1b57EDHWhz+VACHVgifx+ec/VqAc7XOlHpJt4vuhMvWQPMeGsmGKk
 FyDZQ0CJE0FFhOVEZxDSfBRGd0/T5M0gMZbbYlLskHZJObwj8CkmpEti64QksBwgTI
 Z7zTaS07Atn/WEL4E3ajPYGNE+WCi3+Ji+Qf/cbilF/SaFTeO8o/aHmpgDmkZhJ00k
 231D+bglpazd4vIv8QOi4uDS0hb5GqW+WxKZudQNyw2lppEUdD+r9Ziz/N6qv4fCtf
 K7BYq8pQqtxH1fXIijct3zMTbvvC336vHaikbk5NuysPeBGH+dYTlFoVrO/YdDGqza
 I2rBz7eu8S27w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 14/15] drm/msm/dp: separate dp_display_prepare() into
 its own API
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260720-dp_mstclean-v8-14-bea261bf4e7d@oss.qualcomm.com>
References: <20260720-dp_mstclean-v8-0-bea261bf4e7d@oss.qualcomm.com>
 <20260720-dp_mstclean-v8-14-bea261bf4e7d@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 06:27:48 +0000
Message-Id: <20260720062749.2FE681F000E9@smtp.kernel.org>
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
- [High] Splitting `msm_dp_display_atomic_enable()` into `prepare` and `ena=
ble` drops the early return protection on failure paths, causing the displa=
y stream to be unconditionally enabled even if link preparation fails, lead=
ing to unclocked/unpowered hardware access and crashes.
--

--- Patch [14]: [PATCH v8 14/15] drm/msm/dp: separate dp_display_prepare() =
into its own API ---
commit b0785b0b736b2b15642aeae00b1fdb850ab52d5c
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
drm/msm/dp: separate dp_display_prepare() into its own API

This commit splits the display enable sequence into separate link preparati=
on
and stream enable functions. This allows MST link setup to run once for
multiple sinks, while the stream setup runs per-sink.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index deb21cee11830..74d885e38b8cf 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -1428,10 +1428,16 @@ void msm_dp_display_atomic_enable(struct msm_dp *=
msm_dp_display,
>  	}
> =20
>  	rc =3D msm_dp_display_prepare_link(dp);
> -	if (rc) {
> +	if (rc)
>  		DRM_ERROR("DP display prepare failed, rc=3D%d\n", rc);
> -		return;
> -	}
> +}

[Severity: High]
By splitting the function and removing this early return, the failure state=
 is
discarded. If crtc is NULL or hardware power/clocks fail to initialize in
msm_dp_display_prepare_link() (for example, if pm_runtime_resume_and_get()
fails), the caller will still proceed to the enable step.

Could this cause a crash (e.g., Synchronous External Abort) when accessing
unpowered hardware registers in the enable path?

> diff --git a/drivers/gpu/drm/msm/dp/dp_drm.c b/drivers/gpu/drm/msm/dp/dp_=
drm.c
> index aa98f101b093e..75ea52afd9f3e 100644
> --- a/drivers/gpu/drm/msm/dp/dp_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_drm.c
> @@ -55,7 +55,8 @@ static void msm_dp_bridge_atomic_enable(struct drm_brid=
ge *drm_bridge,
>  	struct msm_dp_bridge *dp_bridge =3D to_dp_bridge(drm_bridge);
>  	struct msm_dp *dp =3D dp_bridge->msm_dp_display;
> =20
> -	msm_dp_display_atomic_enable(dp, state);
> +	msm_dp_display_atomic_prepare(dp, state);
> +	msm_dp_display_atomic_enable(dp);
>  }

[Severity: High]
Since msm_dp_display_atomic_prepare() returns void, this function (and
msm_edp_bridge_atomic_enable() below) unconditionally calls
msm_dp_display_atomic_enable() regardless of preparation success.

Should msm_dp_display_atomic_prepare() return an error code so callers can =
skip
enabling the stream if preparation fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720-dp_mstclea=
n-v8-0-bea261bf4e7d@oss.qualcomm.com?part=3D14
