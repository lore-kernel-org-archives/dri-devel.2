Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E18B0C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:00:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AFFED10E287;
	Mon, 31 Aug 2026 10:00:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ZpHLio32";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EF0510E287
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:00:50 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6D9E260120;
 Mon, 31 Aug 2026 10:00:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB23B1F000E9;
 Mon, 31 Aug 2026 10:00:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788170449;
 bh=Cha3PicDiNjk3TVaqEaXjYidzFSaUbbYy2fpNTR5Y9c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZpHLio32wXusQxrB/57LsEwqK98HjfsPHgQLnDZCKvAOBWVFeRHyMglkkQhq650c3
 u80R56z1UZ92nPVkMjxQ/Kc3QUDxJmHf89EgB2WVZ9VFitRS19gm4F0OoNKENj3bO+
 x5vXighzre9ku1yZr4oyDNQJQCJlTAuUaSfW3cDpCreET45GmBsIgVAzsfo9Q5NMvQ
 eav9W+jMm3EMwjFc7tFGrS7WG0J+AQOqi4RakOZbHa+8llH/F6uG2TJJaiIAzNk0Ah
 +wIvDo1b3XA+QVmWKTeAktOmvs5bFJJk3X3TGH3tkTOWJ8Jsy+iIts5pHEyXgOwZ+u
 tXkCLmpxGxWyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 26/29] drm/msm/dp: mark the SST bridge disconnected
 when mst is active
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-26-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-26-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:00:48 +0000
Message-Id: <20260831100048.EB23B1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] PM runtime reference leak in msm_dp_bridge_detect when called repe=
atedly while the display is already connected.
--

commit 17d7f7fedae42b8cc437cd2008aeec3429a04725
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drm/msm/dp: mark the SST bridge disconnected when mst is active

The bridge detect function is only applicable for SST. In MST mode,
connector detection is handled by MST bridges. Skip detection for the
SST bridge when MST is active, matching the behavior of other DP MST
implementations.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 22b9252774620..f350c1d03b06d 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -959,6 +959,10 @@ enum drm_connector_status msm_dp_bridge_detect(struc=
t drm_bridge *bridge,
>  	priv =3D container_of(dp, struct msm_dp_display_private, msm_dp_display=
);
> =20
>  	guard(mutex)(&priv->plugged_lock);
> +
> +	if (dp->mst_active)
> +		return status;
> +
>  	ret =3D pm_runtime_resume_and_get(&dp->pdev->dev);

[Severity: High]
This is a pre-existing issue, but is it possible that this unconditionally
acquired PM reference leaks when the display is already connected?

If userspace repeatedly polls the connector while it is already connected,
msm_dp_bridge_detect() takes a PM reference here without checking if the
driver already holds one.

>  	if (ret) {
>  		DRM_ERROR("failed to pm_runtime_resume\n");

[ ... ]

>  	status =3D connector_status_connected;
>  	priv->plugged =3D true;
> =20
>  	if (drm_dp_read_sink_count_cap(connector, dpcd, &desc)) {
>  		int sink_count =3D drm_dp_read_sink_count(priv->aux);
> =20
>  		drm_dbg_dp(dp->drm_dev, "sink_count =3D %d\n", sink_count);
> =20
>  		if (sink_count <=3D 0)
>  			status =3D connector_status_disconnected;
>  	}
> =20
>  end:
>  	/*
>  	 * If we detected the DPRX, leave the controller on so that it doesn't
>  	 * lose the state.
>  	 */
>  	if (!priv->plugged) {
>  		if (phy_deinit) {
>  			msm_dp_aux_enable_xfers(priv->aux, false);
>  			msm_dp_display_host_phy_exit(priv);
>  		}
> =20
>  		pm_runtime_put_sync(&dp->pdev->dev);
>  	}

Because pm_runtime_put_sync() is only called when priv->plugged is false,
does this mean that if priv->plugged was already true, the PM runtime usage
counter will increment on every poll and never be released?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D26
