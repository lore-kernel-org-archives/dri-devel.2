Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E125ECC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 21:33:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3CF5710E1B0;
	Thu, 15 Oct 2026 21:33:04 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9594910E1B0
 for <dri-devel@lists.freedesktop.org>; Thu, 15 Oct 2026 21:32:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4C59340DF0;
 Thu, 15 Oct 2026 21:32:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD911F000C5;
 Thu, 15 Oct 2026 21:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792099978;
 bh=k/9/v7YjU0zkOamsYYyXG/oKYQjzW4ofXAgavlFUbxU=;
 h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
 b=olaGrcpHmLvMZfRawwnkSrNgKH2/0rpMplorVp9T8yz6bRZ6TxmAg5uqzNkbooAtY
 QAlJ5TjtCJqmH3Zz1H72Fy9D8b9N3HSp1lstgM+DAbiL33zE58HS3RSuE6a+aqr4Fo
 MxToTARdLGYxSnBqGn6nsuYsWHhQ4QlMtt8x4V30bXDZ/7JPmufRLGnirTbTvc+d0t
 xo5n2IoxcdTArnnNB+BL5hdgl73Hfzw1QkiiFYy9HO4+E2ZRDmGOga5zxuzMM+4V/O
 yDU0yesY/4aYT2465n6Mdx+2Y1jsol3h3jewDi6AllQUR0eKG4EJcg8pB+NluPOjk8
 k6ZXUbl/vxd0Q==
Message-ID: <sashiko-outbox-173425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/client: Probe connectors with the device's mode
 size limits
To: "Hugo Sales" <hugo@hsal.es>, dri-devel@lists.freedesktop.org
In-Reply-To: <20261015212545.1989962-2-hugo@hsal.es>
References: <20261015212545.1989962-1-hugo@hsal.es>
 <20261015212545.1989962-2-hugo@hsal.es>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 21:32:57 +0000
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
- [High] drm: NULL pointer dereference of modes[i] in drm_client_firmware_c=
onfig
- [Medium] drm: Logical bug in drm_client_target_cloned due to stale modes[=
i] values
--

commit 0e7e38749489efdbc43f11da085113315e670013
Author: Hugo Sales <hugo@hsal.es>

drm/client: Probe connectors with the device's mode size limits

This patch updates drm_client_modeset_probe() to use the device's mode
size limits rather than the client's dimensions when probing connectors.
It shifts the size validation to the mode pickers by calling
drm_mode_validate_size() to ensure the shared modes list retains larger
modes. This allows keeping panels' preferred modes even if smaller modes
are initially selected.

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/5983

> diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_c=
lient_modeset.c
> index 0080a8e9556a5..e79c7257aaa2e 100644
> --- a/drivers/gpu/drm/drm_client_modeset.c
> +++ b/drivers/gpu/drm/drm_client_modeset.c
> @@ -357,6 +370,8 @@ static bool drm_client_target_cloned(struct drm_devic=
e *dev,
>  			continue;
> =20
>  		list_for_each_entry(mode, &connectors[i]->modes, head) {
> +			if (drm_mode_validate_size(mode, width, height) !=3D MODE_OK)
> +				continue;
>  			if (drm_mode_match(mode, dmt_mode,
>  					   DRM_MODE_MATCH_TIMINGS |
>  					   DRM_MODE_MATCH_CLOCK |

[Severity: Medium]
Can this result in a stale modes[i] value being incorrectly accepted?

In drm_client_target_cloned(), the driver tries to find a matching 1024x768=
=20
mode across all connectors if command-line cloning fails.=20

If a connector doesn't have a 1024x768 mode, or if the mode is skipped=20
because it exceeds the width and height constraints added by this patch,=20
mode_replace() is bypassed:

		list_for_each_entry(mode, &connectors[i]->modes, head) {
			if (drm_mode_validate_size(mode, width, height) !=3D MODE_OK)
				continue;
			if (drm_mode_match(mode, dmt_mode, ...))
				mode_replace(dev, &modes[i], mode);
		}
		if (!modes[i])
			can_clone =3D false;

Because modes[i] is not cleared before this loop, it retains whatever value=
=20
it was assigned in the earlier command-line pass. The termination check=20
if (!modes[i]) evaluates to false, and can_clone incorrectly remains true=20
even if heterogeneous modes are present.=20

While this is a preexisting structural flaw in the function, does adding=20
the drm_mode_validate_size() check inside the 1024x768 loop trigger it by=20
making it far more likely for a 1024x768 mode to be skipped?

[ ... ]

> @@ -750,7 +767,8 @@ static bool drm_client_firmware_config(struct drm_cli=
ent_dev *client,
>  		    num_tiled_conns < connector->num_h_tile * connector->num_v_tile) {
>  			mode_type =3D "non tiled";
>  			mode_replace(dev, &modes[i],
> -				     drm_connector_fallback_non_tiled_mode(connector));
> +				     drm_connector_fallback_non_tiled_mode(connector,
> +									   width, height));
>  		}
>  		crtcs[i] =3D crtc;

[Severity: High]
Does this code risk a NULL pointer dereference in drm_client_firmware_confi=
g()?

If a connector is part of a tiled display but some tiles are missing, the=20
driver attempts to fall back to a non-tiled mode by calling=20
drm_connector_fallback_non_tiled_mode().=20

This patch modifies the fallback function to filter out any modes that exce=
ed=20
the client's width and height. If no modes fit these constraints, the funct=
ion=20
returns NULL.=20

When this happens, mode_replace() safely destroys the existing mode and=20
assigns NULL to modes[i]. However, immediately following this block,=20
drm_dbg_kms() unconditionally dereferences modes[i]->name when logging=20
the selected mode:

		crtcs[i] =3D crtc;

		drm_dbg_kms(dev, "[CONNECTOR::%d:%s] on [CRTC:%d:%s] using %s mode: %s\n",
			    connector->base.id, connector->name,
			    crtc->base.id, crtc->name,
			    mode_type, modes[i]->name);

Since the new size filter makes returning NULL far more likely, can this=20
cause a crash if modes[i] becomes NULL?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015212545.1989=
962-1-hugo@hsal.es?part=3D1
