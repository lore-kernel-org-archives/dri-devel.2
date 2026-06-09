Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FCC2CD8CA4
	for <dri-devel@archiver.kernel.org>; Tue,  9 Jun 2026 10:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9BCDF10E219;
	Tue,  9 Jun 2026 10:04:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mck+vYof";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99BBC10E21A
 for <dri-devel@lists.freedesktop.org>; Tue,  9 Jun 2026 10:04:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8233541E65;
 Tue,  9 Jun 2026 10:04:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320161F00893;
 Tue,  9 Jun 2026 10:04:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780999492;
 bh=unrAPjqP9St+GSljxLUJJHFxaIWiRAuzpF6eNjJ1b48=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mck+vYof3AuvLE0Lq2uAolD6wUg6NqAyYawSLw4C5YI2NMjH3Apelq5f+LWDeHZp/
 ss3PA9ZMYafbUOEPkVNZXmnWvnHf3KTmz0oRVqk6s8BDNCTRi8Vmf75xTGpxtXvX+r
 8uV0xxkX/KuzcGaipRrcSmohjkfq6Ki/5cg39Hz6H+7qWLO8uBsE73C3G9E0xnnt0g
 VZPcsnd0OTj8CmwYa16KVWHrnYiST8JRD+at+BPaupfe19/86BJ8t1QqPyGRDac3DC
 TI3aKw66Xfplq5vEquxec3AyJOZQmX7Noa4qeZB98v/BAy8jWBII1aBsXgIUBvhYWj
 N48U0VLglzwng==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 01/15] drm/msm/dp: remove cached drm_edid from panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260609-dp_mstclean-v7-1-ea04113e8233@oss.qualcomm.com>
References: <20260609-dp_mstclean-v7-1-ea04113e8233@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jun 2026 10:04:51 +0000
Message-Id: <20260609100452.320161F00893@smtp.kernel.org>
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
- [Critical] Unsynchronized updates to connector->edid_blob_ptr and connect=
or->display_info leading to data races and potential Use-After-Free.
--

commit 6f73beae4d0acbc00f38ca7b1a881d309a66701f
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: remove cached drm_edid from panel

This commit simplifies the EDID handling in the MSM DP driver by removing t=
he
cached drm_edid from the panel structure. It uses the drm_edid pointer
directly in the plug stage instead and updates the connector accordingly.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index dc6f33809ca5f..bce165bac106b 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -276,10 +277,20 @@ static int msm_dp_display_process_hpd_high(struct m=
sm_dp_display_private *dp)
> =20
>  	dp->link->lttpr_count =3D msm_dp_display_lttpr_init(dp, dpcd);
> =20
> -	rc =3D msm_dp_panel_read_sink_caps(dp->panel, connector);
> +	rc =3D msm_dp_panel_read_link_caps(dp->panel, connector);
>  	if (rc)
>  		goto end;
> =20
> +	drm_edid =3D drm_edid_read_ddc(connector, &dp->aux->ddc);
> +	drm_edid_connector_update(connector, drm_edid);

[Severity: Critical]
This is a pre-existing issue, but does msm_dp_display_process_hpd_high()
need to hold drm_mode_config.mutex before calling
drm_edid_connector_update()?

Looking at the DRM core guidelines, connector->edid_blob_ptr and
connector->display_info are protected by drm_mode_config.mutex.

Since this runs from an unprotected IRQ worker context upon hotplug, could
an unsynchronized update cause a use-after-free? If userspace concurrently
invokes a DRM_IOCTL_MODE_GETCONNECTOR request, it might read the old blob
while it is being replaced and freed here.

> +
> +	if (!drm_edid) {
> +		DRM_ERROR("panel edid read failed\n");

[ ... ]

> @@ -453,7 +465,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_dis=
play_private *dp)
> =20
>  	/* Don't forget modes for eDP */
>  	if (!dp->msm_dp_display.is_edp)
> -		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
> +		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);

[Severity: Critical]
This is a pre-existing issue, but does msm_dp_hpd_unplug_handle() similarly
need synchronization?

Clearing the EDID property without the mode config mutex might race with
other readers of the connector state.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260609-dp_mstclea=
n-v7-0-ea04113e8233@oss.qualcomm.com?part=3D1
