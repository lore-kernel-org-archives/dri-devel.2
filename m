Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95C4CC44539
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 10:00:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D590610E443;
	Wed, 22 Jul 2026 10:00:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IQ+oCUb3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E8D9B10E443
 for <dri-devel@lists.freedesktop.org>; Wed, 22 Jul 2026 10:00:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6DF33436B0;
 Wed, 22 Jul 2026 10:00:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C861F000E9;
 Wed, 22 Jul 2026 10:00:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784714429;
 bh=62y4DhReDWLr4ngRi123NQUAigiqelJixt8nEbtXc9o=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IQ+oCUb3e+zGZ4cGTV9PxAmOLMET5Mkh6Qqu1fXCsT5PnV2stYcBGAaICCBk9eqWI
 mByYHfe1e1OSjURl2rpdFzT7neoiPcg4/QpvRZUamOmrrsQt7Rr/tnD/7mA1tAF8mz
 pm/gn3NQYFMkBWlAtx0psUSs6wvX29gB+IoyRv+uLoHb0qYzMkeF4FhzvWoBszqNeH
 CjjkGQoVuwud9jHFSHjhfwIswtPWwERhjtZHMmpTP6Wn5KNdfXxEHOAZLE5tjhDzQV
 C+Vh+UBuay9iKDKJYhvB/NqcKcIuPlc5kHnFL4kj1+vmuaYv4RMvsoQueJw6VEoe4W
 ezqHB7TBdM0LA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/2] drm/logicvc: Avoid use-after-free with
 devm_kzalloc()
To: "Romain Gantois" <romain.gantois@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260722-logicvc-uaf-v3-1-f3b2319d58a6@bootlin.com>
References: <20260722-logicvc-uaf-v3-0-f3b2319d58a6@bootlin.com>
 <20260722-logicvc-uaf-v3-1-f3b2319d58a6@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 10:00:28 +0000
Message-Id: <20260722100029.27C861F000E9@smtp.kernel.org>
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
- [High] The local variable `bridge` is passed to `drm_of_find_panel_or_bri=
dge()` without initialization, leading to a crash when the function returns=
 an error without setting it.
--

--- Patch [1]: [PATCH v3 1/2] drm/logicvc: Avoid use-after-free with devm_k=
zalloc() ---
commit 95ef468f51e9bfed648e230bd616663ec7bac106
Author: Romain Gantois <romain.gantois@bootlin.com>

drm/logicvc: Avoid use-after-free with devm_kzalloc()

This commit transitions the panel, CRTC, and encoder objects to DRM-managed
allocations. It removes devm_kzalloc usages in order to fix a use-after-free
bug.

> diff --git a/drivers/gpu/drm/logicvc/logicvc_interface.c b/drivers/gpu/dr=
m/logicvc/logicvc_interface.c
> --- a/drivers/gpu/drm/logicvc/logicvc_interface.c
> +++ b/drivers/gpu/drm/logicvc/logicvc_interface.c
> @@ -147,36 +143,35 @@ int logicvc_interface_init(struct logicvc_drm *logi=
cvc)
>  	int encoder_type =3D logicvc_interface_encoder_type(logicvc);
>  	int connector_type =3D logicvc_interface_connector_type(logicvc);
>  	bool native_connector =3D logicvc_interface_native_connector(logicvc);
> +	struct drm_bridge *bridge;
> +	struct drm_panel *panel;
>  	int ret;
> =20
> -	interface =3D devm_kzalloc(dev, sizeof(*interface), GFP_KERNEL);
> -	if (!interface) {
> -		ret =3D -ENOMEM;
> -		goto error_early;
> -	}
> -
> -	ret =3D drm_of_find_panel_or_bridge(of_node, 0, 0, &interface->drm_pane=
l,
> -					  &interface->drm_bridge);
> +	ret =3D drm_of_find_panel_or_bridge(of_node, 0, 0, &panel,
> +					  &bridge);
>  	if (ret =3D=3D -EPROBE_DEFER)
> -		goto error_early;

[Severity: High]
Are panel and bridge guaranteed to be initialized if this call fails?

When drm_of_find_panel_or_bridge() returns an error like -ENODEV (which
is valid for native DVI connectors without an OF graph), it might not
initialize these variables. Previously, interface was allocated with
devm_kzalloc(), so they were safely initialized to NULL. Now, they are
uninitialized stack variables.

> -	ret =3D drm_encoder_init(drm_dev, &interface->drm_encoder,
> -			       &logicvc_encoder_funcs, encoder_type, NULL);
> -	if (ret) {
> +	interface =3D drmm_encoder_alloc(drm_dev, struct logicvc_interface, drm=
_encoder,
> +				       NULL, encoder_type, NULL);
> +	if (IS_ERR(interface)) {
>  		drm_err(drm_dev, "Failed to initialize encoder\n");
> -		goto error_early;
> +		return PTR_ERR(interface);
>  	}
> =20
> +	interface->drm_panel =3D panel;
> +	interface->drm_bridge =3D bridge;

[Severity: High]
Could this assignment cause a crash later during driver initialization?

If drm_of_find_panel_or_bridge() returned -ENODEV, bridge will contain
stack garbage. Later in logicvc_interface_init(), the code evaluates
if (interface->drm_bridge) and calls drm_bridge_attach(), which would
dereference this uninitialized pointer and trigger a kernel panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722-logicvc-ua=
f-v3-0-f3b2319d58a6@bootlin.com?part=3D1
