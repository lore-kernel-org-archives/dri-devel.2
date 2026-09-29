Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F46ACA5FA1
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 04:58:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8968210ECDF;
	Tue, 29 Sep 2026 04:58:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FhjYfdTn";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E6DE10ECDF
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 04:58:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 56AFB60210;
 Tue, 29 Sep 2026 04:58:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8AB71F000FF;
 Tue, 29 Sep 2026 04:58:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790657893;
 bh=MO06xLiSpzGbL5fLzBKqumFS/bVvicQQKFcJPBc7ZoU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=FhjYfdTn8V28WnLmWW4Qul1uo5tQ4B1aAM8Mks+n7RCPMdX7yYBmbU3gP6V6gC6Jp
 ggFo6xNMruGudg9gvlfp6oqrh3Wv6KcTVlKz30JpvlEfEkXqZLXrA1QyRvBJVr4oM4
 CHL3dWUpCO2KiZD2D15O7V/Kze2ClNGYuSDYT6XYBZVj+CAqioVM148N3NkGmHAzSy
 EkqtuFTffBZWNaOkUkvljPfHjgJ+nUs1nXxL+h7tkwg6KoLVmXAXNvEUkuFZJPEjqi
 LkUyKnz2MY5b7YSIe+RkKGlWMhBx9dzI3M/eJCJjSEnA1ZqmWKCzsV6FphNIdevAyi
 CGYdRaeVAKxCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 30/35] drm/msm/dp: enable MST on capable sinks
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260929-msm-dp-mst-v7-30-4b81473185e7@oss.qualcomm.com>
References: <20260929-msm-dp-mst-v7-0-4b81473185e7@oss.qualcomm.com>
 <20260929-msm-dp-mst-v7-30-4b81473185e7@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 04:58:12 +0000
Message-Id: <20260929045812.D8AB71F000FF@smtp.kernel.org>
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
- [High] drm/msm/dp: DP_LINK_STATUS_CHANGED is ignored during MST, preventi=
ng link retrain
- [High] drm/msm/dp: lockless MST state modification races with unplug hand=
ling
- [Medium] drm/msm/dp: silent failure in MST enablement leaves display brok=
en
--

commit 5689eb36d7ddcd812bb006fabf494a8f3a19f970
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>
Subject: drm/msm/dp: enable MST on capable sinks

This commit enables Multi-Stream Transport (MST) on DP sinks that
advertise MST capability. It activates the MST topology manager on
connect and disables it on disconnect. It also updates handlers to
manage the MST state lifecycle.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c

[ ... ]

> @@ -269,10 +270,34 @@ static int msm_dp_display_lttpr_init(struct msm_dp_=
display_private *dp, u8 *dpcd
>  	return lttpr_count;
>  }
> =20
> +static void msm_dp_display_mst_enable(struct msm_dp_display_private *dp)
> +{
> +	struct msm_dp *msm_dp =3D &dp->msm_dp_display;
> +	int ret;
> +
> +	/* Clear any pre-existing MST state before enabling MST. */
> +	ret =3D drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL, 0);
> +	if (ret < 0) {
> +		DRM_ERROR("failed to clear DP_MSTM_CTRL, ret=3D%d\n", ret);
> +		return;
> +	}
> +
> +	ret =3D drm_dp_dpcd_write_byte(dp->aux, DP_MSTM_CTRL,
> +				     DP_MST_EN | DP_UP_REQ_EN | DP_UPSTREAM_IS_SRC);

[Severity: High]
Does this DPCD write violate MST helper ordering? Calling this here appears
to prematurely enable the hardware, since drm_dp_mst_topology_mgr_set_mst()
internally manages this exact write when setting the state to true.

> +	if (ret < 0) {
> +		DRM_ERROR("sink MST enablement failed\n");
> +		return;
> +	}

[Severity: Medium]
If drm_dp_dpcd_write_byte() fails, this returns early without propagating
the error to the caller, leaving mst_active as false.

> +
> +	msm_dp->mst_active =3D true;
> +	msm_dp_mst_display_set_mgr_state(msm_dp, true);
> +}

[Severity: High]
Are these MST state variables safe to modify locklessly here?

When called in response to an IRQ, this can race concurrently with the
teardown sequence in msm_dp_hpd_unplug_handle() which modifies the same
state under the plugged_lock. Can this lead to topology manager corruption
or leaked resources?

[ ... ]

> @@ -316,6 +346,9 @@ static int msm_dp_display_process_hpd_high(struct msm=
_dp_display_private *dp)
>  	 */
>  	msm_dp_link_psm_config(dp->link, &dp->link->link_caps, false);
> =20
> +	if (mst_mode =3D=3D DRM_DP_MST)
> +		msm_dp_display_mst_enable(dp);
> +

[Severity: Medium]
If msm_dp_display_mst_enable() fails, the failure is ignored here. The
function returns rc =3D 0, assuming success, but the fallback SST EDID read
has been bypassed. Could this leave the display in a broken state with no
active topology or EDID after a hardware error?

>  	msm_dp_link_reset_phy_params_vx_px(dp->link);
> =20
>  end:

[ ... ]

> @@ -499,6 +532,11 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_di=
splay_private *dp)
>  						 dp->panel->dpcd,
>  						 dp->panel->downstream_ports);
> =20
> +	if (dp->msm_dp_display.mst_active) {
> +		msm_dp_mst_display_set_mgr_state(&dp->msm_dp_display, false);
> +		dp->msm_dp_display.mst_active =3D false;
> +	}

[Severity: High]
This modifies the mst_active state under dp->plugged_lock. Does the
lockless initialization in msm_dp_display_mst_enable() create a data race
with this sequence?

[ ... ]

> diff --git a/drivers/gpu/drm/msm/dp/dp_mst_drm.c b/drivers/gpu/drm/msm/dp=
/dp_mst_drm.c
> --- a/drivers/gpu/drm/msm/dp/dp_mst_drm.c
> +++ b/drivers/gpu/drm/msm/dp/dp_mst_drm.c

[ ... ]

> @@ -361,6 +361,21 @@ int msm_dp_mst_attach_encoder(struct msm_dp *dp_disp=
lay, unsigned int stream_id,
>  	return 0;
>  }
> =20
> +void msm_dp_mst_display_hpd_irq(struct msm_dp *dp_display)
> +{
> +	int rc;

[ ... ]

> +		rc =3D drm_dp_mst_hpd_irq_handle_event(&mst->mst_mgr, esi, ack, &handl=
ed);
> +		if (!handled)
> +			break;
> +
> +		rc =3D drm_dp_dpcd_write_byte(mst->dp_aux, esi_res, ack[1]);

[Severity: High]
If drm_dp_mst_hpd_irq_handle_event() receives a non-MST event like
LINK_STATUS_CHANGED, it sets handled to false. This breaks out of the loop
without acking the ESI.

Furthermore, the caller msm_dp_irq_hpd_handle() completely bypasses standard
link processing for MST:

msm_dp_irq_hpd_handle() {
    if (msm_dp_display->mst_active) {
        msm_dp_mst_display_hpd_irq(&dp->msm_dp_display);
        return 0;
    }
    ...
}

Does this prevent the driver from detecting link degradation and retraining
the link, potentially causing a permanent loss of display output?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-msm-dp-mst=
-v7-0-4b81473185e7@oss.qualcomm.com?part=3D30
