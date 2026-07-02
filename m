Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D342DC43327
	for <dri-devel@archiver.kernel.org>; Thu,  2 Jul 2026 15:04:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4374A10E507;
	Thu,  2 Jul 2026 15:04:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QxSDMbJ7";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A72F910E507
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Jul 2026 15:04:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5A9964388F;
 Thu,  2 Jul 2026 15:04:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279CA1F00A3A;
 Thu,  2 Jul 2026 15:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783004662;
 bh=evSRWzqo4pWmVvqNvHXOheQZVSMX6xY8qz3TGktbu4g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QxSDMbJ7XH8vUVsSvMnC1FGjNzQJcco+3LVKffChExLNkg8yZa2XeltEpBxdfBYSg
 8QA3Hcm4d4UAq1RSj09fwEpR3jKDZtNuGrpw/x89WROHKdraxxQp2BtH4VEIC7CpTE
 0qHDB6XhC89CyzSKxfpQDeeKEhF0hwrYKvxB+zTIlkrggU+6TMVdFDcsYDHdhblnVL
 7LAomGSatVa9o5Gld56YPpRzo6uB+4JQwATUQVeVm8gZKVo1TpZPDOo/FXRSoBdnb6
 FsgaeVbykS2GiUsoknP+V9v6L18ZJ7sYKRsP/rkvHoTpMVuWWjX744/BK+H+9++6Hs
 6l6vruuE/Yo4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 10/39] drm/display: hdmi-state-helper: Sync SCDC
 state on hotplug
To: "Cristian Ciocaltea" <cristian.ciocaltea@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260702-dw-hdmi-qp-scramb-v8-10-d79890d00b6a@collabora.com>
References: <20260702-dw-hdmi-qp-scramb-v8-0-d79890d00b6a@collabora.com>
 <20260702-dw-hdmi-qp-scramb-v8-10-d79890d00b6a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 02 Jul 2026 15:04:21 +0000
Message-Id: <20260702150422.279CA1F00A3A@smtp.kernel.org>
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

New issues:
- [Medium] State mutations (audio and CEC notifications) are applied even w=
hen SCDC sync fails with a WW mutex backoff (-EDEADLK).

Pre-existing issues:
- [High] The disconnect path replaces a TODO with a no-op function call, le=
aving the scrambler state potentially inconsistent on hotplug.
--

commit 079e249ec8df03c559fb868b6a5035e1328d0d31
Author: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>

drm/display: hdmi-state-helper: Sync SCDC state on hotplug

This commit hooks drm_connector_hdmi_sync_scdc() into both the connect
and disconnect paths of drm_atomic_helper_connector_hdmi_update() to
synchronize SCDC status on hotplug events. It also adds a context argument
to propagate lock contention errors like -EDEADLK.

> diff --git a/drivers/gpu/drm/display/drm_hdmi_state_helper.c b/drivers/gp=
u/drm/display/drm_hdmi_state_helper.c
> --- a/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> +++ b/drivers/gpu/drm/display/drm_hdmi_state_helper.c
> @@ -1198,18 +1198,20 @@ drm_atomic_helper_connector_hdmi_clear_audio_info=
frame(struct drm_connector *con
[ ... ]
> -static void
> +static int
>  drm_atomic_helper_connector_hdmi_update(struct drm_connector *connector,
> -					enum drm_connector_status status)
> +					enum drm_connector_status status,
> +					struct drm_modeset_acquire_ctx *ctx)
>  {
>  	const struct drm_edid *drm_edid;
> +	int ret =3D 0;
> =20
>  	if (status =3D=3D connector_status_disconnected) {
> -		// TODO: also handle scramber, HDMI sink disconnected.
> +		ret =3D drm_connector_hdmi_sync_scdc(connector, false, ctx);

[Severity: High]
This is a pre-existing issue, but the patch actively replaces the TODO with
a function call that appears to be a no-op on disconnect.

Looking at drm_connector_hdmi_sync_scdc() in drm_hdmi_helper.c, it
immediately returns 0 when the plugged parameter is false:

int drm_connector_hdmi_sync_scdc(...)
{
        if (!connector || !plugged || !ctx)
                return 0;
        ...
}

Will this leave the scrambler state potentially inconsistent if a user
unplugs an SCDC-enabled sink and plugs in a non-SCDC sink without an
active modeset? Should the scrambler be explicitly disabled here instead
of silently returning?

>  		drm_connector_hdmi_audio_plugged_notify(connector, false);
>  		drm_edid_connector_update(connector, NULL);
>  		drm_connector_cec_phys_addr_invalidate(connector);
> -		return;
> +		return ret;
>  	}
> =20
[ ... ]
> @@ -1222,24 +1224,32 @@ drm_atomic_helper_connector_hdmi_update(struct dr=
m_connector *connector,
>  	drm_edid_free(drm_edid);
> =20
>  	if (status =3D=3D connector_status_connected) {
> -		// TODO: also handle scramber, HDMI sink is now connected.
> +		ret =3D drm_connector_hdmi_sync_scdc(connector, true, ctx);
>  		drm_connector_hdmi_audio_plugged_notify(connector, true);
>  		drm_connector_cec_phys_addr_set(connector);
>  	}
> +
> +	return ret;

[Severity: Medium]
If drm_connector_hdmi_sync_scdc() encounters lock contention and returns
-EDEADLK, should we proceed with applying state mutations?

Because ret is captured but not checked before calling
drm_connector_hdmi_audio_plugged_notify() and
drm_connector_cec_phys_addr_set(), this leaks the plugged state to the audio
and CEC subsystems before the WW mutex backoff is completed.

Could we add an error check here to return early on -EDEADLK before mutating
the audio and CEC states?

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260702-dw-hdmi-qp=
-scramb-v8-0-d79890d00b6a@collabora.com?part=3D10
