Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A914C53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 10:37:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D08E610E876;
	Tue, 28 Jul 2026 10:37:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c8qEXsAp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12FEB10E876
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 10:37:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E0BAC40C33;
 Tue, 28 Jul 2026 10:37:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99CE61F000E9;
 Tue, 28 Jul 2026 10:37:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785235056;
 bh=RP0fiJtxkPcqJWkeSOATPDgoCu5Nfj6PfddZmiPz714=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c8qEXsApZ8D8/BUWMEVi7prAE9Z6EM0UFCeeT0e6262kIxjx4ZJ6yOxhugEJShBwL
 1DVmExBbUbhgPvxxlV4VMYf96uEmbnIgJEFWfPrG0VhaavWwZ3egAwNzlVl2W1aR4v
 ByHX7dCiHR1IUI7OEaJFg/PCZt6i8aqM5uCLcO1esQ9YXky5fuZK8FvbvJVhzx07NK
 fLajEQsCOAfQ/4reHKg0vDMBFkuWY8c5Jy05n5oLpLO6EmGnQhNXrABkEGICCUaAKt
 MXUw8uaIeQLRspK3rxHgqPbY4MupmaCKC3HaLIViy624kdvjX3Vtqy8pkH930Cbv8Y
 +hyFSZ1G+il4w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 01/14] drm/msm/dp: remove cached drm_edid from panel
To: "Yongxing Mou" <yongxing.mou@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260728-dp_mstclean-v9-1-f7779fce10f4@oss.qualcomm.com>
References: <20260728-dp_mstclean-v9-0-f7779fce10f4@oss.qualcomm.com>
 <20260728-dp_mstclean-v9-1-f7779fce10f4@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 28 Jul 2026 10:37:36 +0000
Message-Id: <20260728103736.99CE61F000E9@smtp.kernel.org>
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
- [High] Concurrent unlocked update of connector->edid_blob_ptr and display=
_info from HPD thread can race with get_modes(), causing Use-After-Free.
--

--- Patch [1]: [PATCH v9 01/14] drm/msm/dp: remove cached drm_edid from pan=
el ---
commit d2a6147547e02d308fe3444738b9bff65fc0a34d
Author: Yongxing Mou <yongxing.mou@oss.qualcomm.com>

drm/msm/dp: remove cached drm_edid from panel
   =20
The cached drm_edid seems unnecessary here. Use the drm_edid pointer
directly in the plug stage instead of caching it. Remove the cached
drm_edid and the corresponding oneliner to simplify the code.

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
> +

[Severity: High]
This is a pre-existing issue, but can this concurrent unlocked update of
connector->edid_blob_ptr and display_info from the HPD thread race with
get_modes(), causing a use-after-free?

drm_edid_connector_update() is called here from an asynchronous HPD thread
without holding connector->mutex or mode_config.mutex.

If userspace repeatedly calls DRM_IOCTL_MODE_GETCONNECTOR (which invokes
msm_dp_display_get_modes() while holding mode_config.mutex) concurrently
with an external hotplug event, the race window in
drm_property_replace_global_blob() allows the old EDID blob to be freed
before the reader dereferences it.

[ ... ]

> @@ -453,7 +465,7 @@ static int msm_dp_hpd_unplug_handle(struct msm_dp_dis=
play_private *dp)
> =20
>  	/* Don't forget modes for eDP */
>  	if (!dp->msm_dp_display.is_edp)
> -		msm_dp_panel_unplugged(dp->panel, dp->msm_dp_display.connector);
> +		drm_edid_connector_update(dp->msm_dp_display.connector, NULL);
> =20

[Severity: High]
This isn't a bug introduced by this patch, but does modifying the
edid_blob_ptr locklessly on unplug lead to the same race condition?

[ ... ]

> @@ -744,8 +753,7 @@ int msm_dp_display_get_modes(struct msm_dp *dp)
> =20
>  	msm_dp_display =3D container_of(dp, struct msm_dp_display_private, msm_=
dp_display);
> =20
> -	return msm_dp_panel_get_modes(msm_dp_display->panel,
> -		dp->connector);
> +	return drm_edid_connector_add_modes(msm_dp_display->panel->connector);
>  }

[Severity: High]
This is a pre-existing issue, but doesn't this concurrent reader path
invoked from userspace ioctls read the concurrently modified edid_blob_ptr
without adequate protection?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260728-dp_mstclea=
n-v9-0-f7779fce10f4@oss.qualcomm.com?part=3D1
