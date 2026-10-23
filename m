Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43FAB606A32E
	for <dri-devel@archiver.kernel.org>; Fri, 23 Oct 2026 14:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=S9yy8vKm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2857112B70;
	Fri, 23 Oct 2026 14:02:45 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4C9D9112B6B;
 Fri, 23 Oct 2026 14:01:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 43C9D60142;
 Fri, 23 Oct 2026 14:01:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 926BE1F01828;
 Fri, 23 Oct 2026 14:01:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792764107;
 bh=pMDvcJ/aH4HAGtBAeASTFzR8JI/KqXaCGla6OGwhCJw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S9yy8vKmxYUAwzJGuUbnEfBnkIZlgnLL3CS6p6ZgOswB7HyNr+aZplwBTLWxJN6ED
 kfoCuM8II0hutSNBT4Qob1yZgnLDhcgrFq+WV/99qBuvDXTjjTLV2eaUe61Fsqdzwm
 81pYU0NZnvdEzY2vfxl2yooxSqh65Db1P9MtAPcrp8JVyTWwarv85+Baep9gpl4pA3
 n9q7XZ8zDgQ4x/MOsozudKDcjBS03luKmxbTz9jEhV8CQJFJ9DZSTx+hK9Z92u7jog
 sJDuST7QDGPqJnzNnz6C3NIO2hTsIYKck4z3PXR2KCtLfUgez+dTiRHo2XbMDkjDbF
 9bGkxTImeA8gg==
Message-ID: <sashiko-outbox-182862@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 6/9] drm/msm/dp: don't take extra references on
 multiple plug events
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, linux-usb@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-amlogic@lists.infradead.org, neil.armstrong@linaro.org
In-Reply-To: <20261023-hpd-irq-events-v7-6-57a3aea3f09e@oss.qualcomm.com>
References: <20261023-hpd-irq-events-v7-0-57a3aea3f09e@oss.qualcomm.com>
 <20261023-hpd-irq-events-v7-6-57a3aea3f09e@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 14:01:46 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] drm/msm/dp: msm_dp_hpd_plug_handle() skips hpd_high after detect()
--

commit c63c7584ce165272a5840e2bdd5f618e2bd07d8f
Author: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

drm/msm/dp: don't take extra references on multiple plug events

This commit skips further HPD plug events in msm_dp_hpd_plug_handle() if
dp->plugged is already set, avoiding extra runtime PM references until an
unplug event is received.

> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp=
/dp_display.c
> index fa8942922b533..ce919a26fba28 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -412,6 +412,9 @@ static int msm_dp_hpd_plug_handle(struct msm_dp_displ=
ay_private *dp)
> =20
>  	guard(mutex)(&dp->plugged_lock);
> =20
> +	if (dp->plugged)
> +		return 0;

[Severity: High]
Can this cause msm_dp_display_process_hpd_high() to be skipped altogether
when msm_dp_bridge_detect() runs before msm_dp_hpd_plug_handle()?

In drivers/gpu/drm/display/drm_bridge_connector.c,
drm_bridge_connector_detect_ctx() invokes the bridge detect callback
immediately before notifying HPD:

	if (detect) {
		status =3D detect->funcs->detect(detect, connector);
		...
		drm_bridge_connector_hpd_notify(connector, status, DRM_CONNECTOR_NO_EXTRA=
_STATUS);
	}

When a DisplayPort sink is connected and drm_bridge_connector_detect_ctx()
runs (for example during boot-time connector probing, resume, or
DRM_IOCTL_MODE_GETCONNECTOR before an HPD interrupt is processed),
msm_dp_bridge_detect() reads DPCD into a local buffer and sets
priv->plugged =3D true without calling msm_dp_display_process_hpd_high():

	status =3D connector_status_connected;
	priv->plugged =3D true;

When drm_bridge_connector_hpd_notify() -> msm_dp_bridge_hpd_notify() ->
msm_dp_hpd_plug_handle() then runs, or when a subsequent HPD plug event
arrives, this new check sees dp->plugged =3D=3D true and returns early.

Because msm_dp_display_process_hpd_high() is never called, LTTPR,
dp->panel->link_info, connector EDID, dp->link->sink_count, and
dp->audio_supported remain uninitialized, causing msm_dp_bridge_get_modes()
to return 0 modes, msm_dp_display_mode_valid() to reject modes with
MODE_BAD, and msm_dp_display_prepare_link() to fail with -ENOTCONN.

Also, at the end of msm_dp_hpd_plug_handle():

	ret =3D msm_dp_display_process_hpd_high(dp);
	...
	dp->plugged =3D true;

	return ret;

dp->plugged is set to true even when msm_dp_display_process_hpd_high()
fails, which with this early return prevents subsequent HPD plug events
from retrying initialization.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-hpd-irq-ev=
ents-v7-0-57a3aea3f09e@oss.qualcomm.com?part=3D6
