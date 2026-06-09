Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1784CD6E79
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 09:59:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B81510E202;
	Tue,  9 Jun 2026 09:59:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="PTK8EWRx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EE2D10E202
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 09:59:54 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D778242A21;
 Tue,  9 Jun 2026 09:59:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A1E1F00893;
 Tue,  9 Jun 2026 09:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999193;
 bh=q4UCMJu23Bb5O830kozlj92yWok+VR82qIQJ4/Z6E44=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=PTK8EWRxfUMNE15rXPdRhqIOK2H8PiseiYjH0T7Aiti6YX8yyTryMLm8/aCr4eF/g
 OZdlNPRjae2tCCA5Hq60L64bx72Q+EAYeb/PxPQT24TfnUdhCyg8NOl6AyudnVeIaq
 uRD9LmLYOG+ReYO60idPVy/hIvONRbqGW+QbR0E+Uas9KgnZrKy628qq6C2veZyuZM
 rMRnLkWrpXfdtTZK5+ReT+KDcOR4Q3MM1yTH0gQnqcxzcAYDuDI2ClPwZb01hUrr56
 RVIscb/nwdvFfQ/Pt0OSOGOIyzKVOkQsxX/oyGDPKnBahK9SQIov7GqpND1V9CgdQ9
 4zbPAMiIrC24Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 08/15] drm/msm/dp: break up dp_display_enable into
 two parts
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-8-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-8-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 09:59:50 +0000
Message-Id: <20260609095951.B0A1E1F00893@smtp.kernel.org>
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
- [Critical] Missing error return when sink_count =3D=3D 0 leads to unclock=
ed hardware accesses and kernel panic.
- [High] Missing early return when link training fails causes stream enable=
ment on a broken link.
--

commit b8a02a483af0ac409e7c1790ebfbe296067ea49d
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: break up dp_display_enable into two parts

This commit splits dp_display_enable() into two parts: prepare and
enable APIs. This allows inserting MST payload functions between enabling
stream clocks and programming the registers.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 155beefdfdef2..2cf4c984c7ca7 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -617,7 +617,40 @@ static int msm_dp_display_set_mode(struct msm_dp *ms=
m_dp_display,
>  	return 0;
>  }
> =20
> -static int msm_dp_display_enable(struct msm_dp_display_private *dp, bool=
 force_link_train)
> +static int msm_dp_display_prepare_link(struct msm_dp_display_private *dp)
> +{
> +	struct msm_dp *msm_dp_display =3D &dp->msm_dp_display;
> +	int rc =3D 0;
> +	bool force_link_train =3D false;
> +
> +	drm_dbg_dp(dp->drm_dev, "sink_count=3D%d\n", dp->link->sink_count);
> +
> +	if (msm_dp_display->is_edp)
> +		msm_dp_hpd_plug_handle(dp);
> +
> +	rc =3D pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
> +	if (rc) {
> +		DRM_ERROR("failed to pm_runtime_resume\n");
> +		return rc;
> +	}
> +
> +	if (dp->link->sink_count =3D=3D 0)
> +		return rc;

[Severity: Critical]
Does this unintentionally allow the enable sequence to continue when the
sink_count is 0?

Since pm_runtime_resume_and_get() succeeded, rc is 0 here. Returning 0
causes the caller, msm_dp_bridge_atomic_enable(), to continue directly into
msm_dp_display_enable() because the prepare step appears successful:

msm_dp_bridge_atomic_enable() {
    ...
    rc =3D msm_dp_display_prepare_link(dp);
    if (rc) {
        DRM_ERROR("DP display prepare failed, rc=3D%d\n", rc);
        return;
    }

    rc =3D msm_dp_display_enable(dp);
    ...
}

Because msm_dp_ctrl_on_link() was skipped, the DP link clocks are not
enabled. Will the subsequent call to msm_dp_ctrl_on_stream() within
msm_dp_display_enable() then perform an unclocked hardware access when
writing to REG_DP_STATE_CTRL, potentially triggering a bus stall and kernel
panic?

> +
> +	if (!msm_dp_display->power_on) {
> +		msm_dp_display_host_phy_init(dp);
> +		force_link_train =3D true;
> +	}
> +
> +	rc =3D msm_dp_ctrl_on_link(dp->ctrl);
> +	if (rc)
> +		DRM_ERROR("Failed link training (rc=3D%d)\n", rc);
> +	// TODO: schedule drm_connector_set_link_status_property()
> +
> +	return msm_dp_ctrl_prepare_stream_on(dp->ctrl, force_link_train);
> +}

[Severity: High]
If msm_dp_ctrl_on_link() fails, does this mask the failure and force the
pipeline to stream video over a broken link?

In the original code, an error from msm_dp_ctrl_on_link() would explicitly
return and abort the atomic enable sequence. Here, the error is logged, but
execution falls through to msm_dp_ctrl_prepare_stream_on(), which often
returns 0.=20

If it returns 0, the caller receives a success status and proceeds to
configure and start the video stream on an uninitialized link.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D8
