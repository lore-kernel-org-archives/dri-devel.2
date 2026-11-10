Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BA1606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QQurMtYV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBC2510EEA1;
	Tue, 10 Nov 2026 08:35:35 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AFC7310EEA1
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 08:35:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C3F5B63793;
 Tue, 10 Nov 2026 08:35:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 505F11F0089F;
 Tue, 10 Nov 2026 08:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794299728;
 bh=vOidWbFXp3Go85tvjBD6N5SkDSnezUU+YbuE0iGn30A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QQurMtYV0lrL2HlATUtXQXf9Lxn383lAPQeqHoy5yFeWAWbLQbxP5kr2JrPB63kmS
 wAW2Ukc3O0Ub2Ds8M85JopBfcXK/r1TEDugCkEjAQ1Lg83VbRVtAScDeakIaT7FzWX
 H9Hr6etf2MrHIVGKo/JU7/g8a0Y+9QVCslr5B+53Tqsax57aQ2zrlxBKfLYAddEoit
 JCoEg3Qk5kD2Vgdn2IwuvO7knpXjnWs0d7I0+01NWuPfOBgJ0tHWVx2VGsuUk5W9+z
 MgrUCIrG0ALiyn8mgI4R+hNnP/U5371/5C87qlYyVhfDSsqiAG2Ob59u2R9LnMFioF
 PHT4fgpb8d6rA==
Message-ID: <sashiko-outbox-206634@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/panel: kingdisplay-kd097d04: Use mipi_dsi_*_multi()
 functions
To: "Archit More" <architmore303@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110082535.7998-1-architmore303@gmail.com>
References: <20261110082535.7998-1-architmore303@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 08:35:27 +0000
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
- [Medium] drm/panel: state imbalance in kingdisplay_panel_unprepare()
  on DSI error
- [Medium] drm/panel: kingdisplay_panel_disable() error return leaves
  panel enabled
--

commit ce1c20733cce84cf65434f3ef6732b56a7367cda
Author: Archit More <architmore303@gmail.com>

drm/panel: kingdisplay-kd097d04: Use mipi_dsi_*_multi() functions

This commit converts the Kingdisplay KD097D04 panel driver's disable,
unprepare, and prepare callbacks to use the mipi_dsi_*_multi() helpers.

> diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers=
/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> index 893af9b167567..01f5a96f1cfbf 100644
> --- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> +++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
> @@ -180,28 +180,21 @@ struct kingdisplay_panel *to_kingdisplay_panel(stru=
ct drm_panel *panel)
>  static int kingdisplay_panel_disable(struct drm_panel *panel)
>  {
>  	struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel(panel);
> -	int err;
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D kingdisplay->link =
};
> =20
> -	err =3D mipi_dsi_dcs_set_display_off(kingdisplay->link);
> -	if (err < 0)
> -		dev_err(panel->dev, "failed to set display off: %d\n", err);
> +	mipi_dsi_dcs_set_display_off_multi(&dsi_ctx);
> =20
> -	return 0;
> +	return dsi_ctx.accum_err;
>  }

[Severity: Medium]
Should kingdisplay_panel_disable() still return 0 here?

In drm_panel_disable(), the backlight is disabled before calling
panel->funcs->disable(), and a negative return value skips clearing
panel->enabled.  If mipi_dsi_dcs_set_display_off_multi() fails,
panel->enabled remains true and the next drm_panel_enable() returns early
without re-enabling the backlight.

>  static int kingdisplay_panel_unprepare(struct drm_panel *panel)
>  {
>  	struct kingdisplay_panel *kingdisplay =3D to_kingdisplay_panel(panel);
> +	struct mipi_dsi_multi_context dsi_ctx =3D { .dsi =3D kingdisplay->link =
};
>  	int err;
> =20
> -	err =3D mipi_dsi_dcs_enter_sleep_mode(kingdisplay->link);
> -	if (err < 0) {
> -		dev_err(panel->dev, "failed to enter sleep mode: %d\n", err);
> -		return err;
> -	}
> -
> -	/* T15: 120ms */
> -	msleep(120);
> +	mipi_dsi_dcs_enter_sleep_mode_multi(&dsi_ctx);
> +	mipi_dsi_msleep(&dsi_ctx, 120);
> =20
>  	gpiod_set_value_cansleep(kingdisplay->enable_gpio, 0);
> =20
> @@ -209,12 +202,13 @@ static int kingdisplay_panel_unprepare(struct drm_p=
anel *panel)
>  	if (err < 0)
>  		return err;
> =20
> -	return 0;
> +	return dsi_ctx.accum_err;
>  }

[Severity: Medium]
Does returning dsi_ctx.accum_err after disabling kingdisplay->supply leave
panel->prepared out of sync with the hardware state?

When mipi_dsi_dcs_enter_sleep_mode_multi() fails, this function still
deasserts enable_gpio and disables kingdisplay->supply, but returns a
negative error code to drm_panel_unprepare(), which then skips setting
panel->prepared =3D false.  The next drm_panel_prepare() sees panel->prepar=
ed
as true and skips powering the panel back on, while a subsequent
drm_panel_unprepare() calls regulator_disable() a second time and
underflows the regulator enable count.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110082535.7998=
-1-architmore303@gmail.com?part=3D1
