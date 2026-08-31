Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F6EAC61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:04:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3FF6D10E291;
	Mon, 31 Aug 2026 10:04:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Synmpyxu";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B5B0410E291
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:04:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 99A2160120;
 Mon, 31 Aug 2026 10:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230021F000E9;
 Mon, 31 Aug 2026 10:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788170662;
 bh=RtRPPMccgQ10Egkn46IrZlhGw9RDoAq0vmtTe4a5+m4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SynmpyxuJenWnR54J7UMgqDtYJ/EQYx4esovETq1vkZa2dLcf8wSxWtCSaoFlp8zL
 DNf9lQ7OXsWp8pINiRTe8Ohcy3Zn3tQY5Ifk/ff4AJlB7fF2J4yItDW+4NjEnuG95o
 ifOlUmU+HeMN2wgWE1JbmC+6mqPdCNvqHXVWPqYc8ngLrLgE/aGBbnSO1Zb8975vS1
 gpLN9uCAPQy/Ys+gxEjw6eNgnKQwqJWZb9k5ZT6APEHGDdP9y/z29+YmzT9Ybi9ak+
 Ln5ja1IxdRB4ZKuGAl00cMJ9Og3pYv8rqthGhSlTnKQvNCPcDppiYmldAdoUEihULJ
 1sTJLF+O+LCmQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 27/29] drm/msm/dp: enable MST on capable sinks
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-27-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-27-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:04:21 +0000
Message-Id: <20260831100422.230021F000E9@smtp.kernel.org>
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
- [High] Implicit boolean evaluation of enum drm_dp_mst_mode leads to incor=
rectly enabling MST on SST-only sinks.
--

commit c042ac1b2a4e178e7b21389f0bc30a1309bea2b3
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

    drm/msm/dp: enable MST on capable sinks
   =20
    MST topology discovery requires the sink to operate in MST mode.
    Enable MST on sinks that advertise MST capability and are connected
    to a multi-stream capable DP controller.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index f350c1d03b06d..dbc0e82d333a5 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -287,14 +311,17 @@ static int msm_dp_display_process_hpd_high(struct m=
sm_dp_display_private *dp)
>  	if (rc)
>  		goto end;
> =20
> -	drm_edid =3D drm_edid_read_ddc(connector, &dp->aux->ddc);
> -	drm_edid_connector_update(connector, drm_edid);
> +	if (msm_dp_ctrl_get_stream_cnt(dp->ctrl) <=3D 1 ||
> +	    !drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd)) {
        ^^^^

[Severity: High]
Does this implicit boolean evaluation of the return value correctly handle
SST-only sinks with sideband messaging?

The drm_dp_read_mst_cap() function returns an enum drm_dp_mst_mode. If a si=
nk
returns DRM_DP_SST_SIDEBAND_MSG (which has a value of 2), the ! negation wi=
ll
evaluate to false. Will this cause the driver to incorrectly skip the neces=
sary
SST EDID read block here?

> +		drm_edid =3D drm_edid_read_ddc(connector, &dp->aux->ddc);
> +		drm_edid_connector_update(connector, drm_edid);
> =20
> -	if (!drm_edid) {
> -		DRM_ERROR("panel edid read failed\n");
> -		/* check edid read fail is due to unplug */
> -		if (!msm_dp_aux_is_link_connected(dp->aux))
> -			return -ETIMEDOUT;
> +		if (!drm_edid) {
> +			DRM_ERROR("panel edid read failed\n");
> +			/* check edid read fail is due to unplug */
> +			if (!msm_dp_aux_is_link_connected(dp->aux))
> +				return -ETIMEDOUT;
> +		}
>  	}
> =20
>  	msm_dp_link_process_request(dp->link);
> @@ -316,6 +343,10 @@ static int msm_dp_display_process_hpd_high(struct ms=
m_dp_display_private *dp)
>  	 */
>  	msm_dp_link_psm_config(dp->link, &dp->panel->link_info, false);
> =20
> +	if (msm_dp_ctrl_get_stream_cnt(dp->ctrl) > 1 &&
> +	    drm_dp_read_mst_cap(dp->aux, dp->panel->dpcd))
> +		msm_dp_display_mst_enable(dp);
        ^^^^

[Severity: High]
Similarly, will this cause DRM_DP_SST_SIDEBAND_MSG to be treated as fully
MST capable?

Since drm_dp_read_mst_cap() returns 2 for DRM_DP_SST_SIDEBAND_MSG, this
condition evaluates to true. Could this lead to incorrectly executing
msm_dp_display_mst_enable() to enable MST features on an SST sink, improper=
ly
writing DP_MST_EN to DP_MSTM_CTRL?

> +
>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
> =20
>  end:

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D27
