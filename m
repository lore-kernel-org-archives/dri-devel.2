Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF6A3C61DE2
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 09:26:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1E87A10E7A1;
	Mon, 31 Aug 2026 09:26:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="i3tdPs2T";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6DC110E7A1
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 09:26:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8310543620;
 Mon, 31 Aug 2026 09:26:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 441151F000E9;
 Mon, 31 Aug 2026 09:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788168387;
 bh=F0Lnl1VihcJ6ziAJfN/wXk+p0mktVpoIwDdwyRCOSjE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=i3tdPs2T6fvfuHselTfCfz9FR2j5lww6uys5u/b0R8krpsjMIR2cy34+MA5LOXHvu
 50nDaunQg0rxL6cWmkHh4X9gAEMb/dhO1Y4tdF3QPheQKlTNQRPHtmDLNo/K2uMk8m
 X08+v0OHRm6LXSvmybTY9odTE62f/YU85XdthZ+54irHiUg+ofIK6Aw+JkdJ5b3fYc
 pY0mJfVXdqobGY1KuTw3pH47QRbf2PuFsl74eVtgnoN+nrs4sGMh6/MJ98suWYmVyR
 QTXXqUiGeLy3v08neJvRXGu4/nVluErIY05M1ApGsKh170Dj2xgYKezIqixycmqmCu
 ZcrjI2uNOWTHQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 16/29] drm/msm/dp: add link_ready to manage
 link-level operations
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-16-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-16-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:26:26 +0000
Message-Id: <20260831092627.441151F000E9@smtp.kernel.org>
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
- [High] PM runtime reference and PHY state are leaked when msm_dp_display_=
prepare_link() fails after acquiring resources.
- [High] active_stream_cnt unconditionally underflows to UINT_MAX when disp=
lay disable is called after a failed link preparation.
- [Low] Logically inverted debug message for !link_ready condition.
--

commit 229804790247809bb388c425e9b3744dffd08236
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

    drm/msm/dp: add link_ready to manage link-level operations
   =20
    In MST mode, multiple streams share the same DP link. Track a link_ready
    state so msm_dp_display_prepare_link() runs only once per link and
    repeated calls are skipped.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 6103fa67f3ee9..90e3d2c4ef478 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -638,6 +638,10 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_d=
p_display)
>  	if (msm_dp_display->is_edp)
>  		msm_dp_hpd_plug_handle(dp);
> =20
> +	/* Serialized by modeset lock or mst_lock. */
> +	if (msm_dp_display->link_ready)
> +		return 0;
> +
>  	rc =3D pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
>  	if (rc) {
>  		DRM_ERROR("failed to pm_runtime_resume\n");
> @@ -659,7 +663,11 @@ int msm_dp_display_prepare_link(struct msm_dp *msm_d=
p_display)
>  		}
>  	}
> =20
> -	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_tr=
ain);
> +	rc =3D msm_dp_ctrl_prepare_stream_on(dp->ctrl, dp->panel, force_link_tr=
ain);
> +	if (!rc)
> +		msm_dp_display->link_ready =3D true;
> +
> +	return rc;
>  }

[Severity: High]
Is there a leak of the PM runtime reference here?

If msm_dp_display_prepare_link() fails after acquiring the PM reference
but before setting link_ready to true:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_prepare_link() {
    ...
	rc =3D pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
    ...
	if (dp->link->sink_count =3D=3D 0)
		return -ENOTCONN;
    ...
}

It appears the new early return in msm_dp_display_unprepare() will skip
dropping the PM reference and exiting the PHY on error paths:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_unprepare() {
    ...
	if (!msm_dp_display->link_ready) {
		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
		return;
	}
    ...
	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
    ...
}

[ ... ]

> @@ -1493,14 +1501,16 @@ void msm_dp_display_enable_helper(struct msm_dp *=
msm_dp_display, struct msm_dp_p
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> -	rc =3D msm_dp_display_enable(dp, msm_dp_panel);
> -	if (rc)
> -		DRM_ERROR("DP display enable failed, rc=3D%d\n", rc);
> +	if (msm_dp_display->link_ready) {
> +		rc =3D msm_dp_display_enable(dp, msm_dp_panel);
> +		if (rc)
> +			DRM_ERROR("DP display enable failed, rc=3D%d\n", rc);
> =20
> -	rc =3D msm_dp_display_post_enable(msm_dp_display);
> -	if (rc) {
> -		DRM_ERROR("DP display post enable failed, rc=3D%d\n", rc);
> -		msm_dp_display_disable(dp, msm_dp_panel);
> +		rc =3D msm_dp_display_post_enable(msm_dp_display);
> +		if (rc) {
> +			DRM_ERROR("DP display post enable failed, rc=3D%d\n", rc);
> +			msm_dp_display_disable(dp, msm_dp_panel);
> +		}
>  	}
> =20
>  	drm_dbg_dp(msm_dp_display->drm_dev, "type=3D%d Done\n", msm_dp_display-=
>connector_type);

[Severity: High]
Can active_stream_cnt underflow during teardown?

If msm_dp_display_prepare_link() fails, link_ready remains false. The call
to msm_dp_display_enable() above is skipped, and active_stream_cnt is not
incremented.

However, during teardown, msm_dp_display_disable() is called without checki=
ng
link_ready:

drivers/gpu/drm/msm/dp/dp_display.c:msm_dp_display_disable() {
    ...
	msm_dp_display->active_stream_cnt--;
    ...
}

Will this decrement an already zero active_stream_cnt, breaking subsequent
modesets that check if (!msm_dp_display->active_stream_cnt)?

[ ... ]

> @@ -1543,6 +1553,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_d=
p_display)
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> +	if (!msm_dp_display->link_ready) {
> +		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");
> +		return;
> +	}
> +

[Severity: Low]
Is this debug message logically inverted? It prints "Link already setup, re=
turn"
when the condition explicitly checks that the link is NOT ready
(!msm_dp_display->link_ready).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D16
