Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B2E8C5CFDB
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 21:47:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDFA10F55E;
	Thu, 13 Aug 2026 21:47:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="brrUxo0v";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E38A210F55D
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 21:46:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 92D9A40719;
 Thu, 13 Aug 2026 21:46:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C6661F000E9;
 Thu, 13 Aug 2026 21:46:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786657619;
 bh=FMgecS2GqDxyMUEHuwAhOUr5Oh8jmURkgviWWGEkRno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=brrUxo0vT5UzXloUwdK/46KVWhNAT52Gd3s8TNkgAho1DD0hYaIih7Ymz728cygz8
 f/iUmRWUqFamu2cUc9VZm4H9Yvo4ROR5tbMbdh2Aj8qmYXwUlHyUKCt4xFxi/7H38u
 Ec1VsTxwyUT99jNOkWurnnyb9hihvTr2DGLgeLLWM9V7lJI12OoJoSBu9rXcOSffc9
 Z4sqclb+QTXOkJr1fJRxA2RLXnAAmf7jBKI0j86QV56raCy38zam2ATOuMVhAMFsY9
 wDhyKmtHSkAgFUqOJAQHGNwWDnj/FqncyeGT71dZLsAJJu9jhnjPwaBBOhAV+a32LQ
 2YdAbzN9/X0iA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 03/10] drm/msm/dp: Read DPCD and sink count in bridge
 detect()
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260314-hpd-refactor-v5-3-0c8450737d64@oss.qualcomm.com>
References: <20260314-hpd-refactor-v5-3-0c8450737d64@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 21:46:54 +0000
Message-Id: <20260813214659.4C6661F000E9@smtp.kernel.org>
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
- [High] msm_dp_bridge_detect disables AUX transfers globally on a transien=
t runtime PM resume failure, breaking future transfers permanently.
- [High] Transient AUX errors or PM resume failures incorrectly cause the d=
isplay to be reported as disconnected, tearing down the display.
--

--- Patch [3]: [PATCH v5 03/10] drm/msm/dp: Read DPCD and sink count in bri=
dge detect() ---
commit 80bf1779215b888b4022742b582789f295f77790
Author: Jessica Zhang <jesszhan0024@gmail.com>

drm/msm/dp: Read DPCD and sink count in bridge detect()

Instead of relying on the link_ready flag to specify if DP is connected,
read the DPCD bits and get the sink count to accurately detect if DP is
connected.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 5997cd28ba11f..a05144de3b93f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -1151,6 +1151,66 @@ static int msm_dp_hpd_event_thread_start(struct ms=
m_dp_display_private *msm_dp_p
[ ... ]
> +enum drm_connector_status msm_dp_bridge_detect(struct drm_bridge *bridge,
> +					       struct drm_connector *connector)
> +{
[ ... ]
> +	if (!dp->link_ready)
> +		return status;
> +
> +	msm_dp_aux_enable_xfers(priv->aux, true);
> +
> +	ret =3D pm_runtime_resume_and_get(&dp->pdev->dev);
> +	if (ret) {
> +		DRM_ERROR("failed to pm_runtime_resume\n");
> +		msm_dp_aux_enable_xfers(priv->aux, false);

[Severity: High]
If pm_runtime_resume_and_get() fails here, is it correct to call
msm_dp_aux_enable_xfers(priv->aux, false)?

Since enable_xfers is otherwise managed by HPD interrupt handlers (which
don't fire without physical hotplug events), setting it to false on a
transient PM resume failure seems like it would permanently disable the
AUX channel for subsequent transfers (like link training or EDID reads).
Could this render the display unusable until a physical cable replug?

> +		return status;
> +	}
> +
> +	ret =3D msm_dp_aux_is_link_connected(priv->aux);
> +	if (dp->internal_hpd && !ret)
> +		goto end;
> +
> +	ret =3D drm_dp_read_dpcd_caps(priv->aux, dpcd);
> +	if (ret)
> +		goto end;
> +
> +	ret =3D drm_dp_read_desc(priv->aux, &desc, drm_dp_is_branch(dpcd));
> +	if (ret)
> +		goto end;

[Severity: High]
Does returning connector_status_disconnected on transient AUX failures
cause problems?

If drm_dp_read_dpcd_caps() or drm_dp_read_desc() fail due to a transient
error (such as an I2C/AUX timeout), the code jumps to the end and returns
the disconnected status. This could cause userspace to receive a false
display disconnection event and tear down the display modeset abruptly.

> +
> +	status =3D connector_status_connected;
> +	if (drm_dp_read_sink_count_cap(connector, dpcd, &desc)) {
> +		int sink_count =3D drm_dp_read_sink_count(priv->aux);
> +
> +		drm_dbg_dp(dp->drm_dev, "sink_count =3D %d\n", sink_count);
> +
> +		if (sink_count <=3D 0)

[Severity: High]
Since drm_dp_read_sink_count() can return a negative error code (like
-ETIMEDOUT) on failure, this check evaluates to true for errors.

Would a transient read failure here also result in a false disconnection
status being reported?

> +			status =3D connector_status_disconnected;
> +	}
> +
> +end:
> +	pm_runtime_put_sync(&dp->pdev->dev);
> +	return status;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260314-hpd-refact=
or-v5-0-0c8450737d64@oss.qualcomm.com?part=3D3
