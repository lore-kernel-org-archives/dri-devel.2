Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F71606A320
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 08:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=doZF8mA1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB033112197;
	Thu, 19 Nov 2026 08:46:13 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2217B112197
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 08:46:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E7A864735F;
 Thu, 19 Nov 2026 08:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A43FB1F000C4;
 Thu, 19 Nov 2026 08:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795077966;
 bh=gjXfApZMfyDSREVxQkjXfj+N3W1cuJxYu3IOVxSSvLM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=doZF8mA1SI5yrvVILId6g/mf9m6aV06PRMCXSjA2L9mM1Lqw1aqKbG5b6ZYigef4k
 gAwYB49xJK6fPimI0sEpfR4gTkgJm9LeQw6XygpQ7KKnMp9zjuF5DPH9ZwbahG9w8d
 4rGZ//W8j2TDd/uGjhmPoiS8I8vIVWaQEegpCtqx/wCr2TPws8Cufflt2Bgy3p9SKA
 jd2kOOPCfuuogRfO/bX4TRtjzKYa71Lo8jVooiU+mAl9qY+q/f4B2oYYHNn4wZen5u
 wHXHQjya4boUq1sO43ouODXZxhPeXqEK95IB2IESSK21KUq4BmXN3zfk8MUq0M3qD8
 Vl593yoPUBRdQ==
Message-ID: <sashiko-outbox-222707@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 23/29] drm/msm/dp: mark the SST bridge disconnected
 when mst is active
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261119-msm-dp-mst-v9-23-ca61be4edfc3@oss.qualcomm.com>
References: <20261119-msm-dp-mst-v9-0-ca61be4edfc3@oss.qualcomm.com>
 <20261119-msm-dp-mst-v9-23-ca61be4edfc3@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 08:46:05 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] drm/msm/dp: unlocked mst_active check in
  msm_dp_bridge_detect()
--

commit 1b5162231829036e89b5c051fc2a3d4cb1ae0463
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: mark the SST bridge disconnected when mst is active

This commit skips SST bridge detection in msm_dp_bridge_detect() and returns
connector_status_disconnected when dp->mst_active is set.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 75eaf739b86f0..17487a7900d00 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -976,7 +976,11 @@ enum drm_connector_status msm_dp_bridge_detect(struc=
t drm_bridge *bridge,
> =20
>  	priv =3D container_of(dp, struct msm_dp_display_private, msm_dp_display=
);
> =20
> +	if (dp->mst_active)
> +		return status;
> +
>  	guard(mutex)(&priv->plugged_lock);
> +
>  	ret =3D pm_runtime_resume_and_get(&dp->pdev->dev);
>  	if (ret) {
>  		DRM_ERROR("failed to pm_runtime_resume\n");

[Severity: Medium]
Should dp->mst_active be checked after acquiring priv->plugged_lock, as
msm_dp_irq_hpd_handle() does?

drm_bridge_connector_handle_hpd() invokes drm_bridge_connector_hpd_notify()
without holding dev->mode_config.mutex, so priv->plugged_lock is the only
lock serializing HPD plug handling against concurrent connector probing:

CPU0                                  CPU1
msm_dp_hpd_plug_handle()
  lock(&priv->plugged_lock)
  ...
                                      msm_dp_bridge_detect()
                                        if (dp->mst_active) // false
                                        lock(&priv->plugged_lock) // blocks
    dp->mst_active =3D true
    priv->plugged =3D true
  unlock(&priv->plugged_lock)
                                        pm_runtime_resume_and_get(...)
                                        ...  <-- runs SST detect in MST mode

When CPU1 enters the SST detection path after MST is enabled, a successful
DPCD read leaves an extra runtime PM reference leaked (because priv->plugged
is true at the end label and msm_dp_hpd_unplug_handle() only drops one
reference), while a transient AUX read failure resets priv->plugged to false
and causes a subsequent unplug to return early without tearing down the MST
topology manager.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119-msm-dp-mst=
-v9-0-ca61be4edfc3@oss.qualcomm.com?part=3D23
