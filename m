Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 855F1C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 10:26:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BDBF210E275;
	Mon, 31 Aug 2026 10:26:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="l8ugxv/C";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60A8B10E275
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 10:26:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0CFDC40BC9;
 Mon, 31 Aug 2026 10:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C24721F000E9;
 Mon, 31 Aug 2026 10:26:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788171989;
 bh=i0tI3Ht5lzN3mKKT/rhQxmsl4UpzdxmO2i032QHYBws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=l8ugxv/C+OxM3aZ4Wttfvb5FFatvv6pjpXSaEMMIrD2RDkzW0zwba0vrZ436KqOrY
 PK7Zi7qXa9VsYetjA6XFatlPSNi1ZN9KmpOuXmsKKih2Ba/cNYf2oht0Swl3EGJFBl
 aL1zrdtA6sDHs5CuBxHk82+ii5Vu8sMx/PUtS+gdkHsCiUb4wx6SkWcH1CgLzwnbc+
 aH4ILC/LzSNA9Q/+nXecCFA8CAjYey8Y0cUWrD5up6B0YosTgyLGxAmmy4YWIO2UqI
 3t4P3WLHYO9tY4A0FlO2tYHwVGjPCH9nuFe6u/enA6KP1EfN++xy16dkHQGBuS7AdQ
 qZ2VLu/FWo08Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 28/29] drm/msm/dp: mark the SST bridge disconnected
 when an MST-capable sink is present
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-msm-dp-mst-v6-28-c91d35d6fb9e@oss.qualcomm.com>
References: <20260831-msm-dp-mst-v6-0-c91d35d6fb9e@oss.qualcomm.com>
 <20260831-msm-dp-mst-v6-28-c91d35d6fb9e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:26:29 +0000
Message-Id: <20260831102629.C24721F000E9@smtp.kernel.org>
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

New issues:
- [High] Implicit boolean evaluation of drm_dp_read_mst_cap() enum return b=
reaks SST sinks with sideband messaging capability.
- [High] Returning disconnected for MST sinks at boot permanently prevents =
the MST topology manager from initializing.

Pre-existing issues:
- [High] Unbalanced PM runtime usage count leak on repeated detect calls wh=
en the device is plugged in.
--

commit ac2f3880eed108e9f4e8a766ece65af66ffa5cf7
Author: Abhinav Kumar <quic_abhinavk@quicinc.com>

drm/msm/dp: mark the SST bridge disconnected when an MST-capable sink is pr=
esent

When a DP cable is already attached at boot, msm_dp_bridge_detect()
runs from the connector notify path before MST has been activated on
the sink. This commit forces a disconnected status for SST bridges if
the sink supports MST.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index dbc0e82d333a5..d2b2c7141db0f 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1052,6 +1052,10 @@ enum drm_connector_status msm_dp_bridge_detect(str=
uct drm_bridge *bridge,
>  			status =3D connector_status_disconnected;
>  	}
> =20
> +	/* Mark SST connector as disconnected in DP boot-up case*/
> +	if (msm_dp_ctrl_get_stream_cnt(priv->ctrl) > 1 && drm_dp_read_mst_cap(p=
riv->aux, dpcd))

[Severity: High]
Does evaluating drm_dp_read_mst_cap() as a boolean prevent SST sinks that
support single-stream sideband messaging from being detected?

drm_dp_read_mst_cap() returns an enum drm_dp_mst_mode. If a sink returns
DRM_DP_SST_SIDEBAND_MSG (which is 2), this condition evaluates to true,
taking the MST disconnection path for an SST sink. Could this cause these
displays to fail detection and remain blank?

[Severity: High]
Does returning connector_status_disconnected at boot prevent the MST
topology manager from initializing?

When msm_dp_bridge_detect() returns connector_status_disconnected for MST
sinks, the DRM core invokes the driver's .hpd_notify with disconnected.
The driver's msm_dp_bridge_hpd_notify() ignores disconnected events if it
thinks it is already disconnected, and skips calling
msm_dp_hpd_plug_handle().

Since msm_dp_hpd_plug_handle() is skipped, msm_dp_display_mst_enable() is
never reached and the MST topology manager is not initialized until a
physical replug generates an HPD interrupt. Could this result in MST
displays connected at boot remaining undetected?

> +		status =3D connector_status_disconnected;
> +
>  end:
>  	/*
>  	 * If we detected the DPRX, leave the controller on so that it doesn't

[Severity: High]
This isn't a bug introduced by this patch, but does this function leak PM
runtime usage counts on repeated detect calls when the device is plugged in?

A PM runtime reference is acquired unconditionally at the start of the
function:

    ret =3D pm_runtime_resume_and_get(&dp->pdev->dev);

However, if the link is connected, priv->plugged is set to true, which
bypasses the pm_runtime_put_sync() call at the end:

    if (!priv->plugged) {
        ...
        pm_runtime_put_sync(&dp->pdev->dev);
    }

If userspace continuously polls (e.g., via DRM_IOCTL_MODE_GETCONNECTOR)
while the device is plugged in, won't this repeatedly leak references,
eventually preventing suspend? Unplugging would only drop one reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-msm-dp-mst=
-v6-0-c91d35d6fb9e@oss.qualcomm.com?part=3D28
