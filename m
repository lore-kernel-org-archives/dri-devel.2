Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55C7DC98321
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 19:33:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AAD3410E1EA;
	Thu, 24 Sep 2026 19:33:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aQfhE700";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1E25510E1EA
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 19:33:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E314A412AF;
 Thu, 24 Sep 2026 19:33:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B7991F000FF;
 Thu, 24 Sep 2026 19:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790278405;
 bh=fqPqjInbuKAaGUr+Ky8UHyqK3cPMpFewnL91Gdp2nFc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aQfhE700ZThUDHHDERMdgq6qfkG0EkLowUvXfwk00JCaDyFc5xhzv0Fyd3H5TsnG1
 Xvlp3huSeCh8muMmKWqwdxUPWuMCe1856KcFif7DpZclTBl63s4px//DkLeVX40KOo
 0QQzi7MZ+YixrLF200ZExeYoPXCOYJ58Re2DkhUVfyC/THeT6oqzI2/MUKpjw4mD6l
 b71G+yhzTqrBE6+GNf0W+rqUbYwrJIzmLm1/huldK6q5/3nApij+ANH8xWTMo2ridP
 s7PuVtjantYWOoBnv1n7JAold+CD2dqfilsSYcZjwcHzvalPSttUKVzXgPil3XS0vf
 MZDKI3MMO0SiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/appletbdrm: Add suspend and resume support
To: "Vasilij Markin" <vasilij.kernel@tototo.si>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260924-appletbdrm-pm-v1-1-0e5432132161@tototo.si>
References: <20260924-appletbdrm-pm-v1-1-0e5432132161@tototo.si>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 19:33:24 +0000
Message-Id: <20260924193325.9B7991F000FF@smtp.kernel.org>
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
- [Medium] drm/appletbdrm: Memory leak of suspend_state on reset_resume err=
or
--

commit 60e19da684ddfb4bbf66c6f0c2624ed415d96f12
Author: Vasilij Markin <vasilij.kernel@tototo.si>
Subject: drm/appletbdrm: Add suspend and resume support

This commit introduces suspend and resume support for the appletbdrm driver.
It uses drm_mode_config_helper_suspend() and drm_mode_config_helper_resume()
to keep the device registered across cycles. In case the device was reset w=
hile
suspended, it repeats the probe-time handshake.

> diff --git a/drivers/gpu/drm/tiny/appletbdrm.c b/drivers/gpu/drm/tiny/app=
letbdrm.c
> index 4297d9c1125e4..024ad8bf6e1c4 100644
> --- a/drivers/gpu/drm/tiny/appletbdrm.c
> +++ b/drivers/gpu/drm/tiny/appletbdrm.c
[ ... ]
> @@ -821,6 +822,45 @@ static void appletbdrm_shutdown(struct usb_interface=
 *intf)
>  	drm_atomic_helper_shutdown(&adev->drm);
>  }
> =20
> +static int appletbdrm_suspend(struct usb_interface *intf, pm_message_t m=
essage)
> +{
> +	struct appletbdrm_device *adev =3D usb_get_intfdata(intf);
> +
> +	return drm_mode_config_helper_suspend(&adev->drm);
> +}
> +
> +static int appletbdrm_resume(struct usb_interface *intf)
> +{
> +	struct appletbdrm_device *adev =3D usb_get_intfdata(intf);
> +
> +	return drm_mode_config_helper_resume(&adev->drm);
> +}
> +
> +static int appletbdrm_reset_resume(struct usb_interface *intf)
> +{
> +	struct appletbdrm_device *adev =3D usb_get_intfdata(intf);
> +	struct drm_device *drm =3D &adev->drm;
> +	int ret;
> +
> +	/*
> +	 * A reset puts the device back into its initial state, where it
> +	 * expects the same handshake as during probe
> +	 */
> +	ret =3D appletbdrm_get_information(adev);
> +	if (ret) {
> +		drm_err(drm, "Failed to get display information\n");
> +		return ret;

[Severity: Medium]
During system suspend, drm_mode_config_helper_suspend() duplicates the atom=
ic
commit state and stores it in dev->mode_config.suspend_state.

If appletbdrm_get_information() fails here, we return early and bypass the =
call
to drm_mode_config_helper_resume(). Does this leak the suspend_state and its
associated DRM object references, since they never get freed or put by
drm_atomic_state_put()?

> +	}
> +
> +	ret =3D appletbdrm_signal_readiness(adev);
> +	if (ret) {
> +		drm_err(drm, "Failed to signal readiness\n");
> +		return ret;

[Severity: Medium]
Similar to the issue above, if appletbdrm_signal_readiness() fails, does
returning early without calling drm_mode_config_helper_resume() leak the at=
omic
commit state stored in dev->mode_config.suspend_state?

> +	}
> +
> +	return drm_mode_config_helper_resume(drm);
> +}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924-appletbdrm=
-pm-v1-1-0e5432132161@tototo.si?part=3D1
