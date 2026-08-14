Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6B0DC5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 14:18:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 598EA10E558;
	Fri, 14 Aug 2026 14:18:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RiQ8xRd3";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90A9510E558
 for <dri-devel@lists.freedesktop.org>; Fri, 14 Aug 2026 14:18:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 715E0413E4;
 Fri, 14 Aug 2026 14:18:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A1E21F000E9;
 Fri, 14 Aug 2026 14:18:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786717107;
 bh=RF+PbDlvO8uyzmyAIDU6Am3QCb8dXWbZzxoPbJa1vJQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RiQ8xRd3lN7WasdGcxJidKIpWRUhv5fOYX5L0sYo8pHYA4TOOlj6LjIrOfzUCX28T
 EELr/CQaOK46lHV/7esCiPEwOR6xSw+IX7/vcw+JmTj3GZiOEuT81Ro/0AUTeaELeu
 WOC4ZBlFqnFmktdg0HyHJQ+N/QZda3eJQVx6nfJTyG4BOdSvd5Mc+qrsEiSk4KYsIj
 TY/AHDvE3Ju5arxG+WYAkX6CeRqFfrkJ4Hw6kZgHYV1w/lgeUFIdcWOqBR4qOfVXFS
 +2Z27feRABcY3JC3QEPETuQKCrAJTJ73i90/0i/5GlAo0Aw8tTdrLLkBw4ibYXXr2Z
 Fu34pNkS8kvKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/11] drm/bridge: fsl-ldb: don't create a panel_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260814-drm-bridge-every-panel-v1-10-19cd5277cc8d@bootlin.com>
References: <20260814-drm-bridge-every-panel-v1-0-19cd5277cc8d@bootlin.com>
 <20260814-drm-bridge-every-panel-v1-10-19cd5277cc8d@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 14 Aug 2026 14:18:26 +0000
Message-Id: <20260814141827.2A1E21F000E9@smtp.kernel.org>
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
- [High] Returning `-ENODEV` instead of `-EPROBE_DEFER` when the downstream=
 bridge is not found permanently breaks probe deferral.
--

--- Patch [10]: [PATCH 10/11] drm/bridge: fsl-ldb: don't create a panel_bri=
dge ---
commit cea029e41728150133bf916d81ee3178f44b5540
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
drm/bridge: fsl-ldb: don't create a panel_bridge

This commit simplifies fsl_ldb_probe() by retrieving an existing bridge via
of_drm_find_and_get_bridge() rather than unconditionally creating a second
panel_bridge for the same panel. It also ensures the refcounted bridge is
properly managed.

> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fs=
l-ldb.c
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c
[ ... ]
> @@ -298,7 +297,6 @@ static int fsl_ldb_probe(struct platform_device *pdev)
[ ... ]
> -	panel =3D of_drm_find_panel(panel_node);
> -	of_node_put(panel_node);
> -	if (IS_ERR(panel))
> -		return PTR_ERR(panel);
> -
>  	if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"=
))
>  		fsl_ldb->use_termination_resistor =3D true;
> =20
> -	fsl_ldb->panel_bridge =3D devm_drm_panel_bridge_add(dev, panel);
> -	drm_panel_put(panel);
> -	if (IS_ERR(fsl_ldb->panel_bridge))
> -		return PTR_ERR(fsl_ldb->panel_bridge);
> -
> +	fsl_ldb->bridge.next_bridge =3D of_drm_find_and_get_bridge(panel_node);
> +	of_node_put(panel_node);
> +	if (!fsl_ldb->bridge.next_bridge)
> +		return -ENODEV;

[Severity: High]
Does this change break probe deferral when the downstream driver loads late=
r?

Previously, if the downstream panel driver hadn't loaded yet,=20
of_drm_find_panel() returned -EPROBE_DEFER, which was propagated back to=20
allow fsl_ldb_probe() to try again later.

With the updated code, if of_drm_find_and_get_bridge() returns NULL because=
=20
the downstream bridge driver hasn't successfully probed yet, this returns a=
=20
hard -ENODEV error. Could this permanently fail the display pipeline=20
initialization depending on module load order? Should this return=20
-EPROBE_DEFER instead?

> =20
>  	if (fsl_ldb_is_dual(fsl_ldb)) {
>  		struct device_node *port1, *port2;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260814-drm-bridge=
-every-panel-v1-0-19cd5277cc8d@bootlin.com?part=3D10
