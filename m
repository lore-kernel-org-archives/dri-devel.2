Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17B03C55173
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 19:03:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F31910F3B1;
	Fri, 31 Jul 2026 19:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ay0A5eLa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EED1B10F3B1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 19:02:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DF3FD4135D;
 Fri, 31 Jul 2026 19:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E5E91F00ACA;
 Fri, 31 Jul 2026 19:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785524578;
 bh=E88JEGx69E4FBYr7wu0mC8tzEvmo6Bvv6M04Ci1tcsw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ay0A5eLa+j9zUyJHzaNFSj7UTsKN1ORSMzyEYMMZSmCEID4lhAogF4kI92Z1HPHb+
 ZIJyxQ9JscYfT9Ne54P37ZxlLL0hPrrOR4NkKrMTXd4EpWkyiaku5wU90hfVFrJdZh
 +NeYIeQEllwYofV2UqCsWYu10PywOcDoZ2kUFglx9UYV0phhgrDfmkwgFKiK6QPklN
 GtXhxKCfSbwosq6e6YtQoLLys4tMBND5gJT7tg1HkkDjIN0ai8qkvhWvU0eRwPt+6U
 UWXgYxE5dEuIr+CgGsuQ4DgVcnw9ZjbE9RQVomY51+OJUHXdl/Bt49niZRLUWO3jGj
 fF8SCNulTbIfQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 22/69] drm/display: hdmi-state-helper: Sync SCDC
 state on hotplug
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: linux-sunxi@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260731-dw-hdmi-qp-scramb-v10-22-294364b2cf15@collabora.com>
References: <20260731-dw-hdmi-qp-scramb-v10-0-294364b2cf15@collabora.com>
 <20260731-dw-hdmi-qp-scramb-v10-22-294364b2cf15@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 19:02:58 +0000
Message-Id: <20260731190258.8E5E91F00ACA@smtp.kernel.org>
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
- [High] SCDC sync fails to handle scrambler teardown on disconnect, leavin=
g the source scrambler active when swapping to a non-scrambling sink.
--

--- Patch [22]: [PATCH v10 22/69] drm/display: hdmi-state-helper: Sync SCDC=
 state on hotplug ---
commit 7cc2ce705b4793d8696717d86562fbd6c0bde231
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi-state-helper: Sync SCDC state on hotplug

This commit hooks drm_connector_hdmi_sync_scdc() into the connect and
disconnect paths in drm_atomic_helper_connector_hdmi_update() to synchronize
the SCDC status on hotplug events.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> index 4a93c279c9a76..3377ea9361209 100644
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -1205,13 +1205,16 @@ drm_atomic_helper_connector_hdmi_update(struct dr=
m_connector *connector,
>  					enum drm_connector_status status)
>  {
>  	const struct drm_edid *drm_edid;
> +	int ret =3D 0;
> =20
>  	if (status =3D=3D connector_status_disconnected) {
> -		// TODO: also handle scramber, HDMI sink disconnected.
> -		drm_connector_hdmi_audio_plugged_notify(connector, false);
> -		drm_edid_connector_update(connector, NULL);
> -		drm_connector_cec_phys_addr_invalidate(connector);
> -		return 0;
> +		ret =3D drm_connector_hdmi_sync_scdc(connector, false, ctx);

[Severity: High]
Does this call successfully tear down the scrambler on disconnect?

Looking at drm_connector_hdmi_sync_scdc() in drm_hdmi_helper.c, it seems
to return immediately if the plugged parameter is false:

int drm_connector_hdmi_sync_scdc(struct drm_connector *connector, bool plug=
ged,
                                 struct drm_modeset_acquire_ctx *ctx)
{
        ...
        if (!connector || !plugged || !ctx)
                return 0;

This would make the disconnect call a no-op, failing to disable the source
scrambler.

Additionally, if a non-scrambling sink is subsequently plugged in, the
connect path will call drm_connector_hdmi_sync_scdc() with plugged set to
true, which also bails out early:

        if (!connector->ddc || !drm_scdc_sink_supports_scrambling(connector=
))
                return 0;

Could this leave the source scrambler incorrectly enabled if a user swaps f=
rom
an HDMI 2.0 monitor to an older HDMI 1.4 monitor, resulting in broken displ=
ay
output due to mismatched hardware state?

> +		if (ret !=3D -EDEADLK) {
> +			drm_connector_hdmi_audio_plugged_notify(connector, false);
> +			drm_edid_connector_update(connector, NULL);
> +			drm_connector_cec_phys_addr_invalidate(connector);
> +		}
> +		return ret;
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731-dw-hdmi-qp=
-scramb-v10-0-294364b2cf15@collabora.com?part=3D22
