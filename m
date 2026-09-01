Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C0FC61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:24:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 040AB10EEBC;
	Tue,  1 Sep 2026 19:24:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Thzt06dF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D4BD10EEBC
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 19:24:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AFF7D6022E;
 Tue,  1 Sep 2026 19:24:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A85C1F000E9;
 Tue,  1 Sep 2026 19:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788290654;
 bh=9hMpj1OKrtSTuUZTfUdwPHCAxZhHfQ9utZRE/Uuptxk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Thzt06dFLI+/hEMAGVHhegHxaRBahEAgTQ4RdY/P1cXvhdpIZY+nPfMlKEC87+8G7
 ovJzaMGmbS3mMmToxXT5kkf2V/dCUrMAjcs8cGZ3850EkwBjzM2RAe8dfSV1y8DlbT
 mvHLbVIN8y0L9b2cC368wMtiljLXsVOZ8uB/pa3o5rCJkc7+6xEl2muPMWpdtLAWyX
 jWlTF1KJVTDNQkxJA3W/Co8+1iW2Ba+TIGW64f5S3iXpPKeQyG1VLlrIneIKk8GiUQ
 2v8nQxqZFXsiBCWm6z3GhR3LJ4Jmfmg0iesG+s6xWggw8ge/fD635anrOKqw2sI3M8
 /s645AzbbQ2iQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 1/3] drm: Add passive_vrr properties for
 passive/desktop VRR
To: "Fangzhi Zuo" <jerry.zuo@amd.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901191251.2653684-2-jerry.zuo@amd.com>
References: <20260901191251.2653684-1-jerry.zuo@amd.com>
 <20260901191251.2653684-2-jerry.zuo@amd.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 19:24:13 +0000
Message-Id: <20260901192414.3A85C1F000E9@smtp.kernel.org>
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
- [Low] Contradictory kerneldoc for `passive_vrr_disabled` in `struct drm_c=
rtc_state` and multiple spelling errors in comments.
--

commit 870f0fcb955a90bd32f228b223d6193abfa63290
Author: Tomasz Paku=C5=82a <tomasz.pakula.oficjalny@gmail.com>
Subject: drm: Add passive_vrr properties for passive/desktop VRR

This commit adds atomic CRTC and immutable connector properties to support
passive VRR for desktop usage on HDMI sinks. This aims to avoid blanking or
flickering on VRR entry and exit by keeping the sink in a variable-refresh
state during fixed refresh use.

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 9d820a2a87ce4..c429105172b0d 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
[ ... ]
> @@ -2386,6 +2396,17 @@ EXPORT_SYMBOL(drm_mode_create_scaling_mode_propert=
y);
>   *
>   *	The driver may place further restrictions within these minimum
>   *	and maximum bounds.
> + *
> + * "PASSIVE_VRR_DISABLED":
> + *	Default &drm_crtc boolean property that notifies the driver that the
> + *	VRR singalling should be disabled in fixed refresh rate scenarios.
> + *	Functionally, psssive vrr works the same as VRR_ENABLED =3D=3D false

[Severity: Low]
This isn't a bug, but there are a couple of spelling errors in the uAPI
documentation here: "singalling" should be "signalling", and "psssive"
should be "passive".

> + *	but works around displays blanking (mainly HDMI) that do not support
> + *	seamless VRR transitions. Also helps with brightness flickering during
> + *	VRR transitions.
> + *
> + *	Passive VRR mode is not that useful for DP/eDP sinks where seamless V=
RR
> + *	transitions are enforced by the standard.
>   */
[ ... ]
> diff --git a/include/drm/drm_crtc.h b/include/drm/drm_crtc.h
> index c6dbe8b7db9ee..642a374f403e6 100644
> --- a/include/drm/drm_crtc.h
> +++ b/include/drm/drm_crtc.h
> @@ -311,6 +311,15 @@ struct drm_crtc_state {
>  	 */
>  	bool vrr_enabled;
> =20
> +	/**
> +	 * @passive_vrr_disabled:
> +	 *
> +	 * Indicates if variable refresh rate on desktop should be enabled for
> +	 * the CRTC. Support for the requested state will depend on driver and
> +	 * hardware capabiltiy - lacking support is not treated as failure.
> +	 */
> +	bool passive_vrr_disabled;
> +

[Severity: Low]
This isn't a bug, but the documentation states this field "Indicates if
variable refresh rate on desktop should be enabled", which contradicts the
variable name passive_vrr_disabled. Should this description read "disabled"
instead?

Also, there is a spelling error in "capabiltiy" (capability).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901191251.2653=
684-1-jerry.zuo@amd.com?part=3D1
