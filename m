Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A586B606A323
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 11:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=Fgl9iXXq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C546E10E3FD;
	Mon, 16 Nov 2026 11:40:23 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD55A10E3FD
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 11:40:16 +0000 (UTC)
Received: from [IPv6:2a0a:edc0:0:900:1d::4e] (lupine.office.stw.pengutronix.de
 [IPv6:2a0a:edc0:0:900:1d::4e])
 (Authenticated sender: pza@pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 4D001200878;
 Mon, 16 Nov 2026 12:40:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
 s=20260414; t=1794829215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2oXKqz/r9qPT6+iKuD1Ip8m1/c7yFb8927lBXvGA8hA=;
 b=Fgl9iXXqEG8HmHOZXwioSQDsgm1BYx+lLsTqbIlEjcd6MtiA4JqYxcyxupz9zAhu3sKg/6
 x1nKHjbcCtQ5XW+Bdr9Pr47jADK+ho8IVivTdDGLoM82wStc9lHbfSeV1WmKs+RugqX08e
 rdEF5szcLMyXC0aS25+q0GDt/QYXHak1viZdSBYMnJpxWq0C+J/mPknflts6V4jg/AxGJD
 Oa5JJzJ5O5ihUsbujzPm/xmpqtNzequlx0d9YXfbweZU4RbMyI5/lIvAJILGMAe67VEjBV
 fYNYtR9Rg9G9o7quceWmefOOjYDMJmtpHWwmV9VdF16hJWDBWvI0m8DNXgbC3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de; 
 s=20260414; t=1794829215;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2oXKqz/r9qPT6+iKuD1Ip8m1/c7yFb8927lBXvGA8hA=;
 b=BFSI63XcNrkivdny+VeJZSRfz5C7NEWRCaXLb7AW1tGVFRJ/sfAYz59r30yiUrokbjzEWI
 UiLHYkK+VOWJFH8jJeyiLUR+pAeEtjn/zj3ibegCHsjEPB+qHXbGquDe0lqLZitBeOOiPN
 uSPWXSJtQcykSHVAvKnD3GY01hbtWhAEsm9XHkwlEgfN36VuxcnTWYOwLMtJ+JYNiuS/Ii
 4Mf095/MuR0M3BrT52+rf6eWLxFiONOvNqok5hwdB7GmeIQW+n5gQ/3hZ0O21uuFbfuav8
 eImE/sFGY7LNQB1achJ9UvOFFi+MofLLMZSkI3MvxPnHvF47F6s3/8af2m2lMg==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794829215; a=rsa-sha256;
 cv=none;
 b=XLJEWZY9kaISKuiQXxBUzC7Pn52tc/PO/dsV9hgWkrfss1iBMacWsUIlBq2+RUMdUZldyK
 x+WsRB7CNhMt/IOn+JXZqwD6t32kIq9aIKdxGbNQhT1EGX+eqqvaWDlLdyrZeyz2WJvBgh
 t0JC7YSxAPGEPARrCV7BDkA4zDUJmtu0YINxRDOmywGd5QRbDRFuVSEwJ6LJ1L5EFtQTbm
 G2s0zeBPE0/pC/nifiHQt4TcheSoFFJjMLrPLFkTl1fl33mADCsuWwP9TVR2V3ZAbILJ2X
 +0yMkJZG3d3L1Ae02qgXHf7UnZGFjllHMjN1iFHm1ON8HjZHxxZkIJxUyUWNqA==
ARC-Authentication-Results: i=1; ORIGINATING;
 auth=pass smtp.auth=pza@pengutronix.de smtp.mailfrom=p.zabel@pengutronix.de
Message-ID: <2f3a7b2b5f92ea38141a2dfc15605aaf4a8c512a.camel@pengutronix.de>
Subject: Re: [PATCH v2 12/64] drm/imx/ipuv3: Switch to
 drm_mode_config_create_initial_state
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Maxime Ripard <mripard@kernel.org>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>,  David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, Fabio Estevam <festevam@gmail.com>, 
 Frank Li <Frank.Li@nxp.com>, Pengutronix Kernel Team
 <kernel@pengutronix.de>, Sascha Hauer	 <s.hauer@pengutronix.de>,
 imx@lists.linux.dev
Date: Mon, 16 Nov 2026 12:40:15 +0100
In-Reply-To: <20261116-drm-no-more-config-reset-v2-12-0bb471f4d1e0@kernel.org>
References: <20261116-drm-no-more-config-reset-v2-0-0bb471f4d1e0@kernel.org>
 <20261116-drm-no-more-config-reset-v2-12-0bb471f4d1e0@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mo, 2026-11-16 at 11:30 +0100, Maxime Ripard wrote:
> drm_mode_config_reset() has a dual role: it creates the initial KMS
> state at probe time, and resets hardware and software state during
> suspend/resume cycles.
>=20
> Since the two roles need different behaviors (notably for objects like
> drm_private_obj that must persist across suspend/resume),
> drm_mode_config_create_initial_state() was introduced to handle only
> the initial state creation at probe time.
>=20
> Switch to drm_mode_config_create_initial_state().
>=20
> Signed-off-by: Maxime Ripard <mripard@kernel.org>
> ---
> Cc: Fabio Estevam <festevam@gmail.com>
> Cc: Frank Li <Frank.Li@nxp.com>
> Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
> Cc: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: imx@lists.linux.dev
> ---
>  drivers/gpu/drm/imx/ipuv3/imx-drm-core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c b/drivers/gpu/drm/i=
mx/ipuv3/imx-drm-core.c
> index 51a0ec043248..b7b6ae8f9578 100644
> --- a/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> +++ b/drivers/gpu/drm/imx/ipuv3/imx-drm-core.c
> @@ -242,11 +242,13 @@ static int imx_drm_bind(struct device *dev)
>  	/* Now try and bind all our sub-components */
>  	ret =3D component_bind_all(dev, drm);
>  	if (ret)
>  		goto err_kms;
> =20
> -	drm_mode_config_reset(drm);
> +	ret =3D drm_mode_config_create_initial_state(drm);
> +	if (ret)
> +		goto err_poll_fini;

This is ok because drm_kms_helper_poll_fini() just returns when
drm_kms_helper_poll_init() hasn't been called yet.

Still, I think it would be clearer to add a err_mode_config goto target
between drm_kms_helper_poll_fini() and component_unbind_all().

>  	/*
>  	 * All components are now initialised, so setup the fb helper.
>  	 * The fb helper takes copies of key hardware information, so the
>  	 * crtcs/connectors/encoders must not change after this point.

Either way,

Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>

regards
Philipp
