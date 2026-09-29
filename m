Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE073C9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 62DF610EB1D;
	Tue, 29 Sep 2026 04:39:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cI982weW";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8877110EB1D
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:39:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 21BB343ADD;
 Tue, 29 Sep 2026 04:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC5281F000FF;
 Tue, 29 Sep 2026 04:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790656767;
 bh=P6zppT/pnCjkGH79TNSRKmhR9MpdWzjao5yoP44TRW8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cI982weWpjllFqMuF18I7Fey6eAaT9NARf8QwaV5ijySkM0oHvVBjQp+w1PCDE114
 R7tpeMqxVI5DL3LxP/m5+w5z7eQoJhGlgeiwBSrb7VA9NsL81rZRNDblbyeezvCb1d
 tiaz1aRfKuwqbThSVX/6VvomutO/A/k2FxIb4zU1TU8ufdBLfQ9CEp/6K3BzXclBfP
 owsON/tPxHlt9JzeHWQj+Jh53UVuhCc3tQoYjnmXwJMJKldqbc6Tpnxm48n3AJqwtq
 zYHoqfw9410W24fPNKMiC7/1aLdF/XKNPS5A9AZV6Q8VnNYU++yK3xQFhC17hVYH9B
 nyP+Q2KrgIp7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 16/35] drm/msm/dp: add link_ready to manage
 link-level operations
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-16-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-16-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:39:26 +0000
Message-Id: <20260929043926.CC5281F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: active_stream_cnt integer underflow on link preparatio=
n failure
- [High] drm/msm/dp: PM runtime and PHY resource leak on failed link prepar=
ation
- [Low] drm/msm/dp: misleading debug message in unprepare path
--

commit 76ccdbadef8f1f0f27aff459380cb7a38f3abbd5
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: add link_ready to manage link-level operations

In MST mode, multiple streams share the same DP link. Track a link_ready
state so msm_dp_display_prepare_link() runs only once per link and
repeated calls are skipped.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 49a718f4e4649..487c76e0f990d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -1501,14 +1509,16 @@ void msm_dp_display_enable_helper(struct msm_dp *=
msm_dp_display,
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

[Severity: High]
If msm_dp_display_prepare_link() failed (e.g., sink_count =3D=3D 0), link_r=
eady
is false and we skip calling msm_dp_display_enable(). This means
active_stream_cnt is never incremented.

However, during atomic teardown, msm_dp_display_atomic_post_disable_helper()
unconditionally calls msm_dp_display_disable(), which will decrement the
counter regardless:

msm_dp_display_disable() {
    ...
    msm_dp_display->active_stream_cnt--;
    ...
}

Can this cause active_stream_cnt to underflow to 0xFFFFFFFF?

If it underflows, a subsequent call to msm_dp_display_prepare_link() would
fail to initialize the PHY because it checks:

    if (!msm_dp_display->active_stream_cnt) {
        msm_dp_display_host_phy_init(dp);
        ...

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
> @@ -1565,6 +1575,11 @@ void msm_dp_display_unprepare(struct msm_dp *msm_d=
p_display)
> =20
>  	dp =3D container_of(msm_dp_display, struct msm_dp_display_private, msm_=
dp_display);
> =20
> +	if (!msm_dp_display->link_ready) {
> +		drm_dbg_dp(dp->drm_dev, "Link already setup, return\n");

[Severity: Low]
Does this debug message contradict the check? It says "Link already setup",
but it is printed when link_ready is false.

[Severity: High]
If msm_dp_display_prepare_link() failed after successfully calling
pm_runtime_resume_and_get(), link_ready remains false. For example:

msm_dp_display_prepare_link() {
    ...
    rc =3D pm_runtime_resume_and_get(&msm_dp_display->pdev->dev);
    ...
    if (dp->link->sink_count =3D=3D 0)
        return -ENOTCONN;
    ...
}

When msm_dp_display_unprepare() is later called, this new early return
will cause us to skip the cleanup code:

    msm_dp_display_host_phy_exit(dp);
    pm_runtime_put_sync(&msm_dp_display->pdev->dev);

Will this result in leaking the PM runtime reference and leaving the PHY
initialized?

> +		return;
> +	}
> +
>  	if (msm_dp_display->active_stream_cnt) {
>  		drm_dbg_dp(dp->drm_dev, "stream still active, return\n");
>  		return;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D16
