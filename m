Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F029606A324
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 19:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZhRf/PJh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C7B3710E19B;
	Tue,  3 Nov 2026 19:41:10 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3280210E19B
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 19:41:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F036E42470;
 Tue,  3 Nov 2026 19:41:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5F541F000C1;
 Tue,  3 Nov 2026 19:41:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793734864;
 bh=UOdYDrYyRY0LccO/94vexEVA1I70e8DdZB1uhTRTLNY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ZhRf/PJh+4RNZx7/LFhRUYrKEF2XZmxd92gIPyqYDmyar4AEmPW7jDeuzoJ8cbFRx
 fL3nZpx4NvIaMoO43OX+VYc6DAY71A5AM2sYzc5fxfCreMb6fizrU2H5MTKgmBelzr
 cSMWgY4FcIKLgSfKLhpUJsY13GffWDzwjiwXjdyZBTBi5WZ/FCmMs3PMdfU8/3fH2M
 OWTk4MS+yLNMZ/kRwfH8AHjsAY+Wy7TqG5XBJMa6z4xAZio1czPguLHevMwpn1x+rM
 JFXsEseS4tNLx09cTUmUcOxHN2X+0Hnvqfn8zyaI6DMVVowedrJ5O9mgckIhEz6+w7
 FMjK14wLrRSCA==
Message-ID: <sashiko-outbox-195931@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/nouveau/kms/nv50-: don't drive outputs at 0 bpc
To: "David R. Hedges" <linuxdev844@thelittleman.net>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261103-nouveau-dp-fixes-v1-4-892f4bd357cd@thelittleman.net>
References: <20261103-nouveau-dp-fixes-v1-0-892f4bd357cd@thelittleman.net>
 <20261103-nouveau-dp-fixes-v1-4-892f4bd357cd@thelittleman.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 03 Nov 2026 19:41:04 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] drm/nouveau/kms/nv50-: 8 bpc fallback in nv50_outp_atomic_check(=
) breaks 6 bpc eDP and LVDS
--

commit 7d97154d2ddf364be90f072cc11c87de1735db87
Author: David R. Hedges <linuxdev844@thelittleman.net>

drm/nouveau/kms/nv50-: don't drive outputs at 0 bpc

This commit falls back to 8 bpc in nv50_outp_atomic_check() and
nv50_msto_atomic_check() when connector->display_info.bpc is 0 so that outp=
uts
are not driven at 0 bpc if a modeset happens after a probe clears or resets
display_info.bpc before ->get_modes() runs.

Link: https://gitlab.freedesktop.org/drm/nouveau/-/work_items/515

> diff --git a/drivers/gpu/drm/nouveau/dispnv50/disp.c b/drivers/gpu/drm/no=
uveau/dispnv50/disp.c
> index 2c66e480b5116..a265fd971c99c 100644
> --- a/drivers/gpu/drm/nouveau/dispnv50/disp.c
> +++ b/drivers/gpu/drm/nouveau/dispnv50/disp.c
> @@ -418,8 +418,11 @@ nv50_outp_atomic_check(struct drm_encoder *encoder,
>  	if (ret)
>  		return ret;
> =20
> +	/* display_info.bpc is reset to 0 when a probe loses the EDID, and
> +	 * isn't given a default again until ->get_modes() runs.
> +	 */
>  	if (crtc_state->mode_changed || crtc_state->connectors_changed)
> -		asyh->or.bpc =3D connector->display_info.bpc;
> +		asyh->or.bpc =3D connector->display_info.bpc ?: 8;

[Severity: Medium]
Could unconditionally defaulting asyh->or.bpc to 8 here break 6 bpc eDP and
18-bit (6 bpc) LVDS panels?

Whenever nouveau_connector_detect() or nouveau_connector_detect_lvds() runs
without a subsequent ->get_modes() call, drm_connector_update_edid_property=
()
calls drm_edid_connector_update() -> update_display_info() ->
drm_reset_display_info(), which resets connector->display_info.bpc to 0.
For example, on system or runtime resume, nouveau_display_hpd_resume()
schedules nouveau_display_hpd_work() which calls drm_helper_probe_detect() =
on
every connector; when an eDP or LVDS panel stays connected, its epoch_count=
er
does not change, so no hotplug event is sent and ->get_modes() does not run.
For EDID 1.3 panels (standard on LVDS and Apple eDP panels), EDID 1.4 panels
with undefined depth, or failed EDID reads, display_info.bpc remains 0 after
->detect().

In drivers/gpu/drm/nouveau/nouveau_connector.c,
nouveau_connector_detect_depth() defaults eDP and LVDS to 6 bpc (unless LVDS
VBIOS flags specify 24-bit):

	/* EDID 1.4 is *supposed* to be supported on eDP, but, Apple... */
	if (nv_connector->type =3D=3D DCB_CONNECTOR_eDP) {
		connector->display_info.bpc =3D 6;
		return;
	}

	/* we're out of options unless we're LVDS, default to 8bpc */
	if (nv_encoder->dcb->type !=3D DCB_OUTPUT_LVDS) {
		connector->display_info.bpc =3D 8;
		return;
	}

	connector->display_info.bpc =3D 6;

When a modeset is committed while display_info.bpc is 0, setting asyh->or.b=
pc
to 8 in nv50_outp_atomic_check() causes nv50_sor_atomic_enable() in
drivers/gpu/drm/nouveau/dispnv50/disp.c to override
bios->fp.strapless_is_24bit and force 24-bit LVDS mode on 18-bit LVDS panel=
s:

			if (lvds_dual) {
				if (bios->fp.strapless_is_24bit & 2)
					lvds_8bpc =3D true;
			} else {
				if (bios->fp.strapless_is_24bit & 1)
					lvds_8bpc =3D true;
			}

			if (asyh->or.bpc =3D=3D 8)
				lvds_8bpc =3D true;
		}

		nvif_outp_lvds(&nv_encoder->outp, lvds_dual, lvds_8bpc);

It also causes eDP links to be trained and driven at 8 bpc instead of 6 bpc,
and prevents nv50_head_atomic_check_dither() in
drivers/gpu/drm/nouveau/dispnv50/head.c from enabling 6 bpc dithering on
24-bit framebuffers:

		if (asyc->dither.mode =3D=3D DITHERING_MODE_AUTO) {
			if (asyh->base.depth > asyh->or.bpc * 3)
				mode =3D DITHERING_MODE_DYNAMIC2X2;
		} else {
			mode =3D asyc->dither.mode;
		}

		if (asyc->dither.depth =3D=3D DITHERING_DEPTH_AUTO) {
			if (asyh->or.bpc >=3D 8)
				mode |=3D DITHERING_DEPTH_8BPC;
		}

Should the fallback in nv50_outp_atomic_check() account for eDP and LVDS
connectors, or should nouveau_connector_detect_depth() also be invoked once
nv_connector->native_mode is available?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261103-nouveau-dp=
-fixes-v1-0-892f4bd357cd@thelittleman.net?part=3D4
