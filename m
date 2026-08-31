Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040E2C61DD3
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 18:35:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2659E10E984;
	Mon, 31 Aug 2026 18:35:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="P51k55HP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B6EE10E984
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:34:59 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8D8D9601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 18:34:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 170201F00A3D;
 Mon, 31 Aug 2026 18:34:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788201298;
 bh=RmzWUGHRpVkZnZj03o4XTs6yk719S3JFBL2YTXI2zDo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P51k55HPK5PaDMri5+KpOAJnBOL0UcnEFViESIN/v+JdnvaI/lX2T9GSac6wBSd/y
 BhNr1k/1LFWLnEQpUerCNdUza66vnnwM8gG8rgtgv3o5slzj07MUr4cRTjspBtoZuO
 XVLLXjbZnazykOF4sgS8ZzysZjQ5r5/k0jzrA65oS5w+kEqVGJZiLA6psiKL+eWG9R
 xwtmF1WTN/wvRzGC/TtSjfHpPGV22vFZ1crqPudAENKKJgPGpHRNJWdelULXFply9B
 NqS6RL4/ipeBkGyDiODGYNOzOhQT9v2m/R6t4aU2+A/zLAfW4Bc9qg3hHsmcd+nUYr
 JAbJRU89hysfg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/13] drm/crtc: Introduce hw_reset helper hook
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-1-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-1-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 18:34:57 +0000
Message-Id: <20260831183458.170201F00A3D@smtp.kernel.org>
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
- [High] Missing NULL pointer check for optional `crtc_funcs` before checki=
ng for `hw_reset`
--

commit cd389080636467064c5a9461f52395b91014fd73
Author: Maxime Ripard <mripard@kernel.org>

drm/crtc: Introduce hw_reset helper hook

This commit introduces a new hw_reset hook in struct drm_crtc_helper_funcs =
to
allow resetting hardware to a known good state without affecting software s=
tate.
It updates drm_mode_config_crtc_reset_with_create_state() to call this hook
after the software state is successfully created.

> diff --git a/drivers/gpu/drm/drm_mode_config.c b/drivers/gpu/drm/drm_mode=
_config.c
> --- a/drivers/gpu/drm/drm_mode_config.c
> +++ b/drivers/gpu/drm/drm_mode_config.c

[ ... ]

> @@ -230,12 +231,22 @@ static int drm_mode_config_crtc_create_state(struct=
 drm_crtc *crtc)
> =20
>  static int drm_mode_config_crtc_reset_with_create_state(struct drm_crtc =
*crtc)
>  {
> +	const struct drm_crtc_helper_funcs *crtc_funcs =3D crtc->helper_private;
> +	int ret;
> +
>  	if (crtc->state) {
>  		crtc->funcs->atomic_destroy_state(crtc, crtc->state);
>  		crtc->state =3D NULL;
>  	}
> =20
> -	return drm_mode_config_crtc_create_state(crtc);
> +	ret =3D drm_mode_config_crtc_create_state(crtc);
> +	if (ret)
> +		return ret;
> +
> +	if (crtc_funcs->hw_reset)
> +		crtc_funcs->hw_reset(crtc);

[Severity: High]
Could this lead to a NULL pointer dereference for drivers that do not use t=
he
CRTC helpers?

If a driver implements atomic_create_state but doesn't use the CRTC helpers,
crtc->helper_private will be NULL. When drm_mode_config_reset() iterates
over all CRTCs and calls drm_mode_config_crtc_reset_with_create_state(),
crtc_funcs will evaluate to NULL.

Since crtc_funcs is unconditionally dereferenced here to check for hw_reset,
would this cause a panic during initialization or suspend/resume paths?

Should there be an additional check to ensure crtc_funcs is valid?

	if (crtc_funcs && crtc_funcs->hw_reset)
		crtc_funcs->hw_reset(crtc);

> +
> +	return 0;
>  }
> =20
>  static int drm_mode_config_connector_create_state(struct drm_connector *=
connector)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-crtc-reset-v2-0-4500d49a337f@kernel.org?part=3D1
