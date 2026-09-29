Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72D95C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:44:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D635310ECC6;
	Tue, 29 Sep 2026 04:44:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nHiAZq0Y";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ACFDC10ECC6
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:44:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9635A41AD5;
 Tue, 29 Sep 2026 04:44:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58BBD1F000FF;
 Tue, 29 Sep 2026 04:44:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657090;
 bh=doEWOzNhluIsNiJqhaTZ9ZqM30wYoBgELlElBRB9MEw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nHiAZq0YtGLcN2t+1h0KW18Isdb21Oo2b9x73yJgQky0H4zso2PnlW+HIZcQ6lJVv
 CMt83Y8x2+tjJahOR3EeWSvBMpBrs6VKpidiODMnnqbPSBaD6D9VFqTXHLps9E4hh0
 890qKo3VgZiru8Mw+aLIbTqBtQrUavpwi3vnsJgpbc7Rgym/tX98ZnxS4jf43/MFA2
 TyAx8kTH5VQEX2MFQAnS/mfWYAKXVi32JrxCFAjT0jwNMe1HHmJGOrWbRDnHPWU9cv
 nPx81u+zk4xIwCO5AqJMzZ24+OEuur5JkUrtcOEtuEBXnNnJn/ogMqzy/rYmO1tLwt
 ccNjUypN070Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 04/35] drm/msm/dp: introduce stream_id for each DP panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-4-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-4-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:44:49 +0000
Message-Id: <20260929044450.58BBD1F000FF@smtp.kernel.org>
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
- [Medium] drm/msm/dp: recoverable warning converted to fatal error in pixe=
l clk enable
- [Low] drm/msm/dp: debug logs hardcode DP_STREAM_0 for stream_clks status
--

commit 7e53604a5503e211e31129f82d37f5fe82b91f63
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

    drm/msm/dp: introduce stream_id for each DP panel
   =20
    With MST, each DP controller can handle multiple streams. There shall be
    one dp_panel for each stream but the dp_display object shall be shared
    among them. To represent this abstraction, add a stream_id field to
    struct msm_dp_panel and introduce the msm_dp_stream_id enum. For SST,
    the field is initialized to DP_STREAM_0.

> diff --git a/drivers/gpu/drm/msm/dp/dp_ctrl.c b/drivers/gpu/drm/msm/dp/dp=
_ctrl.c
> index e7bb9558c0b41..67f1da46b973f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_ctrl.c
> +++ b/drivers/gpu/drm/msm/dp/dp_ctrl.c
> @@ -1750,7 +1751,7 @@ int msm_dp_ctrl_core_clk_enable(struct msm_dp_ctrl =
*msm_dp_ctrl)
> =20
>  	drm_dbg_dp(ctrl->drm_dev, "enable core clocks \n");
>  	drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
> -		   str_on_off(ctrl->stream_clks_on),
> +		   str_on_off(ctrl->stream_clks_on[DP_STREAM_0]),

[Severity: Low]
Will hardcoding DP_STREAM_0 here obscure the state of streams 1 through 3 in
MST topologies?

Since the core clocks are shared, printing only the stream 0 state could be
misleading when multiple streams might be active.=20

>  		   str_on_off(ctrl->link_clks_on),
>  		   str_on_off(ctrl->core_clks_on));
> =20

[ ... ]

> @@ -1800,7 +1801,7 @@ static int msm_dp_ctrl_link_clk_enable(struct msm_d=
p_ctrl *msm_dp_ctrl)
> =20
>  	drm_dbg_dp(ctrl->drm_dev, "enable link clocks\n");
>  	drm_dbg_dp(ctrl->drm_dev, "stream_clks:%s link_clks:%s core_clks:%s\n",
> -		   str_on_off(ctrl->stream_clks_on),
> +		   str_on_off(ctrl->stream_clks_on[DP_STREAM_0]),

[Severity: Low]
Does this similarly hide the status of the other stream clocks when enabling
the link clocks?=20

>  		   str_on_off(ctrl->link_clks_on),
>  		   str_on_off(ctrl->core_clks_on));
> =20

[ ... ]

> @@ -2190,38 +2191,39 @@ static bool msm_dp_ctrl_send_phy_test_pattern(str=
uct msm_dp_ctrl_private *ctrl)
>  	return success;
>  }
> =20
> -static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, un=
signed long pixel_rate)
> +static int msm_dp_ctrl_on_pixel_clk(struct msm_dp_ctrl_private *ctrl, un=
signed long pixel_rate,
> +				    enum msm_dp_stream_id stream_id)
>  {
>  	int ret;
> =20
> -	ret =3D clk_set_rate(ctrl->pixel_clk, pixel_rate * 1000);
> +	ret =3D clk_set_rate(ctrl->pixel_clk[stream_id], pixel_rate * 1000);
>  	if (ret) {
>  		DRM_ERROR("Failed to set pixel clock rate. ret=3D%d\n", ret);
>  		return ret;
>  	}
> =20
> -	if (WARN_ON_ONCE(ctrl->stream_clks_on))
> -		return 0;
> +	if (WARN_ON_ONCE(ctrl->stream_clks_on[stream_id]))
> +		return -EINVAL;

[Severity: Medium]
Does returning -EINVAL instead of 0 here turn a recoverable state mismatch=
=20
into a hard failure?

Previously in msm_dp_ctrl_on_pixel_clk(), if the stream clock was already o=
n,
it would trigger a warning but return 0, allowing the driver to skip the=20
enable step and proceed. By returning -EINVAL, the initialization sequence
now aborts, potentially leaving the display blank if the internal state gets
desynced.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D4
