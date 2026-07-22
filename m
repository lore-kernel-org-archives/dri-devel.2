Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5228CC4451C
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 07:08:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9CCBE10EC91;
	Wed, 22 Jul 2026 07:08:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TmeicZaE";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5ACCD10EC91
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 07:08:36 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9E66760A67;
 Wed, 22 Jul 2026 07:08:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29E0B1F000E9;
 Wed, 22 Jul 2026 07:08:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784704115;
 bh=JrJuSQIysKBTB/GREf6cyf0kni2MpRezNaFtboNzbKA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TmeicZaE6F1QNDkMgAa3tTrT1+lH2eKdZSPMFjJEnnYTC1WEtVX7get33Eq54d7Gf
 GtY401Gn8b2g9na/XEYvehkDrdzg700ha5kKOnjpyDpnjl24JeeoUv0XYDRnnRBkuA
 DDNnhuEq/apdHqpfa4+syP60aVqcUNooIomIBOIm1I/1UtTJ+OiBGUXJpuGI+oTKoj
 rq3LVQXYTbaxmQOzvmlRZI5WiUi8z2tWYTZCMicQjw4hC07J41bhYD6dF1H12OD4Cg
 TJBaFokb4h8c079DGch3dPDEz1M3vJ9AMrQxB08hUP5DUJfInWG/sa0zCXnO6ef/O1
 jz7i2YCgpXyyQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 16/24] drm/msm/dp: remove cached drm_edid from panel
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-drm-msm-display-interface-v1-16-368c10fe62fd@oss.qualcomm.com>
References: <20260722-drm-msm-display-interface-v1-0-368c10fe62fd@oss.qualcomm.com>
 <20260722-drm-msm-display-interface-v1-16-368c10fe62fd@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 07:08:34 +0000
Message-Id: <20260722070835.29E0B1F000E9@smtp.kernel.org>
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
- [High] Lockless modification of `connector->edid_blob_ptr` in HPD handler=
s.
--

--- Patch [16]: [PATCH 16/24] drm/msm/dp: remove cached drm_edid from panel=
 ---
commit 379cd36eb86a5e848dbe71b567a862219cda4dab
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>
Subject: drm/msm/dp: remove cached drm_edid from panel

This commit removes the cached drm_edid from the DP panel structure.
Instead of caching it, the EDID is read and updated directly in the plug
stage to simplify the code.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
[ ... ]
> @@ -272,6 +272,7 @@ static int msm_dp_display_process_hpd_high(struct msm=
_dp_display_private *dp)
>  	const struct drm_display_info *info =3D &connector->display_info;
>  	int rc =3D 0;
>  	u8 dpcd[DP_RECEIVER_CAP_SIZE];
> +	const struct drm_edid *drm_edid =3D NULL;
> =20
>  	rc =3D drm_dp_read_dpcd_caps(dp->aux, dpcd);
>  	if (rc)
> @@ -279,10 +280,20 @@ static int msm_dp_display_process_hpd_high(struct m=
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

[Severity: High]
This isn't a bug introduced by this patch, but does calling
drm_edid_connector_update() here in the hotplug handler occur without holdi=
ng
drm_mode_config.mutex?

If this is called from an IRQ thread holding only the driver-local
dp->plugged_lock, drm_edid_connector_update() will replace
connector->edid_blob_ptr and decrement the old blob's reference count.

Concurrently, if userspace reads the EDID via sysfs or queries modes via
ioctl, it will acquire drm_mode_config.mutex and directly dereference the
blob. Can this lead to a Use-After-Free if the EDID blob is freed while
readers are still accessing it?

[ ... ]
> @@ -456,7 +468,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_dis=
play_private *dp)
> =20
>  	/* Don't forget modes for eDP */
>  	if (!dp->msm_dp_display.is_edp)
> -		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
> +		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);

[Severity: High]
This is a pre-existing issue, but a similar lockless update to the
connector's EDID property blob seems to happen here during an unplug event.

Does this unplug path also need to hold drm_mode_config.mutex to prevent a
potential Use-After-Free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-drm-msm-di=
splay-interface-v1-0-368c10fe62fd@oss.qualcomm.com?part=3D16
