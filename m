Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C2C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 10:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ceHnuKyn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C0B111284A;
	Fri, 27 Nov 2026 10:59:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C906111284A
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 10:59:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 80A8B40846;
 Fri, 27 Nov 2026 10:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDEFC1F000C1;
 Fri, 27 Nov 2026 10:59:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795777158;
 bh=rjfHqJlYTe0ioCy7egr/57Kmw5/Ei4oflfwEw7r+Zi0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ceHnuKyn6qJBY8guf7U2epp0A+9zbXn3n2G4GBOA6jjrIIBwj3/bMCBaMC+/5BiEz
 hlNcoE1yY2vNfXFoqlPSMjUHVqkHh65r5SP1GDXFyNV6VLmX4+/rFheXeU9uivamw8
 Kw3hPU0GnvrWEvMfzbjpdFuUnNM/p1SoSFV5A+MzGIPnCZvIkeBZpEXQMjxOEh+xqe
 ay1lOHHbFb4vT8st+cWfj4yXurDenB0G/Kx+cJv1BfBK8ShsBShx8cYfzkeP7GaOOc
 fHLZ5xb7C8SpmtL04/xt1IhFPDhGni0eenGdHygMkX7Ayyh8LMLzMWPTbDDaWkvRqm
 ZvNUt3XfJi/ew==
Message-ID: <sashiko-outbox-237194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/10] drm/msm/dp: fix HPD plugged, AUX gate, and
 runtime PM tracking
To: "Gianfranco Mariotti" <gianfranco.mariotti94@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261127101417.24303-8-gianfranco.mariotti94@gmail.com>
References: <20261127101417.24303-1-gianfranco.mariotti94@gmail.com>
 <20261127101417.24303-8-gianfranco.mariotti94@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 10:59:17 +0000
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
- [High] drm/msm/dp: early return in msm_dp_hpd_plug_handle() skips
  branch sink init
- [Medium] drm/msm/dp: stale sink_count in
  msm_dp_display_is_dongle_plugged() on unplug
--

commit f7be63be5e39d6eb47128f66765be92b0a077052
Author: Gianfranco Mariotti <gianfranco.mariotti94@gmail.com>

drm/msm/dp: fix HPD plugged, AUX gate, and runtime PM tracking

This commit updates hotplug, connector detection, and link preparation in t=
he
MSM DP driver to balance dp->plugged state, AUX transfer enablement, and
runtime PM reference counting.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index 7831dd13b0674..a48f42a173657 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -408,8 +408,9 @@ static int msm_dp_display_handle_irq_hpd(struct msm_d=
p_display_private *dp)
> =20
>  static int msm_dp_hpd_plug_handle(struct msm_dp_display_private *dp)
>  {
> -	int ret;
>  	struct platform_device *pdev =3D dp->msm_dp_display.pdev;
> +	bool phy_deinit;
> +	int ret;
> =20
>  	drm_dbg_dp(dp->drm_dev, "Before, type=3D%d sink_count=3D%d\n",
>  			dp->msm_dp_display.connector_type,
> @@ -417,6 +418,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_displ=
ay_private *dp)
> =20
>  	guard(mutex)(&dp->plugged_lock);
> =20
> +	if (dp->plugged)
> +		return 0;
> +
>  	ret =3D pm_runtime_resume_and_get(&pdev->dev);
>  	if (ret) {
>  		DRM_ERROR("failed to pm_runtime_resume\n");
> @@ -425,9 +429,16 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_disp=
lay_private *dp)
> =20
>  	msm_dp_aux_enable_xfers(dp->aux, true);
> =20
> -	msm_dp_display_host_phy_init(dp);
> +	phy_deinit =3D msm_dp_display_host_phy_init(dp);
> =20
>  	ret =3D msm_dp_display_process_hpd_high(dp);
> +	if (ret && ret !=3D -ENOTCONN) {
> +		msm_dp_aux_enable_xfers(dp->aux, false);
> +		if (phy_deinit)
> +			msm_dp_display_host_phy_exit(dp);
> +		pm_runtime_put(&pdev->dev);
> +		return ret;
> +	}
> =20
>  	drm_dbg_dp(dp->drm_dev, "After, type=3D%d sink_count=3D%d\n",
>  			dp->msm_dp_display.connector_type,
> @@ -435,8 +446,8 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_displ=
ay_private *dp)
> =20
>  	dp->plugged =3D true;
> =20
> -	return ret;
> -};
> +	return 0;
> +}

[Severity: High]
Does the early return when dp->plugged is true skip downstream sink
initialization when a monitor is later plugged into an already-attached emp=
ty
branch device?

When an empty branch dongle is connected first, msm_dp_panel_read_link_caps=
()
sets dp->link->sink_count =3D 0 and returns -ENOTCONN before reading EDID, =
and
msm_dp_hpd_plug_handle() sets dp->plugged =3D true.  When a downstream moni=
tor
is connected afterward and msm_dp_bridge_hpd_notify() calls
msm_dp_hpd_plug_handle() (for example on external Type-C HPD where
hpd_link_status is ISR_DISCONNECTED, or via drm_bridge_connector_detect()),
msm_dp_hpd_plug_handle() returns early without running
msm_dp_display_process_hpd_high().  Because msm_dp_bridge_detect() only rea=
ds
DP_SINK_COUNT into a local variable, dp->link->sink_count stays 0, EDID is
never read, and msm_dp_display_prepare_link() fails with -ENOTCONN.

[ ... ]

> @@ -1598,6 +1603,22 @@ void msm_dp_bridge_hpd_disable(struct drm_bridge *=
bridge)
>  	pm_runtime_put_sync(&msm_dp_display->pdev->dev);
>  }
> =20
> +static bool msm_dp_display_is_dongle_plugged(struct msm_dp_display_priva=
te *dp,
> +					     u32 hpd_link_status)
> +{
> +	u8 rev;
> +
> +	guard(mutex)(&dp->plugged_lock);
> +
> +	if (!dp->plugged || !dp->link->has_sink_count || dp->link->sink_count)
> +		return false;
> +
> +	if (hpd_link_status !=3D ISR_DISCONNECTED)
> +		return true;
> +
> +	return !drm_dp_dpcd_read_byte(dp->aux, DP_DPCD_REV, &rev);
> +}
> +
>  void msm_dp_bridge_hpd_notify(struct drm_bridge *bridge,
>  			      struct drm_connector *connector,
>  			      enum drm_connector_status status)
> @@ -1626,7 +1647,7 @@ void msm_dp_bridge_hpd_notify(struct drm_bridge *br=
idge,
>  		} else {
>  			msm_dp_hpd_plug_handle(dp);
>  		}
> -	} else {
> +	} else if (!msm_dp_display_is_dongle_plugged(dp, hpd_link_status)) {
>  		msm_dp_hpd_unplug_handle(dp);
>  	}

[Severity: Medium]
Can msm_dp_display_is_dongle_plugged() see a stale non-zero
dp->link->sink_count when a downstream monitor is unplugged from an attached
branch dongle?

When a downstream monitor is disconnected and detection runs through
drm_bridge_connector_detect() -> msm_dp_bridge_detect() without a prior
native IRQ_HPD pulse updating dp->link->sink_count, msm_dp_bridge_detect()
reads DP_SINK_COUNT =3D=3D 0 into a local variable and returns
connector_status_disconnected while dp->link->sink_count remains >=3D 1.
msm_dp_display_is_dongle_plugged() then returns false and
msm_dp_bridge_hpd_notify() calls msm_dp_hpd_unplug_handle(), tearing down
dp->plugged, AUX transfers, and runtime PM for the still-attached dongle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127101417.2430=
3-1-gianfranco.mariotti94@gmail.com?part=3D7
