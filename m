Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCE7ACDB471
	for <dri-devel@archiver.kernel.org>; Wed, 24 Jun 2026 12:24:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2FB5210E074;
	Wed, 24 Jun 2026 12:24:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="nycyjDHj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A85A210E074
 for <dri-devel@lists.freedesktop.org>; Wed, 24 Jun 2026 12:24:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 729F4444B1;
 Wed, 24 Jun 2026 12:24:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2FAA81F000E9;
 Wed, 24 Jun 2026 12:24:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782303875;
 bh=uedtJ28eaeDMnwsan7By07cwA+HscIRGd3VPvG9IPjQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nycyjDHj2wqlsSc1Ck4EN4Uu757Zh/2Cj3o2LllYYEvQ9H4c3wkDauM1vx0WzaYXT
 vgmtFHn95SmIoFZmTXpWNdrKPjuVZpkmu7as9p0xe831eY4W+2ZrZTBvD31RreGtNU
 /Fb0xBNSAsKoJicWEHRD3gjsy0MGLmsnVy+hmfcWCeFhTgEkvzuiIROGDdJ7KkSxMJ
 6fuuP+39SgFIRnZIi3wN2wZ8d16+jdjdx4SAbqcHimTF1LxZQhRlsOQzURr0rDdvgl
 I0K9tBtOuU77df4nJPK2qcik0JPI6OvDLII2o489P8a6eX2V+kq74OVxZC/Mh2Zc/b
 dkAVqlCGT1y5g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/4] drm/bridge: tc358767: do not open-code
 devm_drm_of_get_bridge in DSI path
To: "Alexander Stein" <alexander.stein@ew.tq-group.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260624121515.2301219-4-alexander.stein@ew.tq-group.com>
References: <20260624121515.2301219-1-alexander.stein@ew.tq-group.com>
 <20260624121515.2301219-4-alexander.stein@ew.tq-group.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 12:24:34 +0000
Message-Id: <20260624122435.2FAA81F000E9@smtp.kernel.org>
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
- [High] Probe fails with -ENODEV when port 2 has no downstream panel or br=
idge defined, breaking DisplayPort output.
--

commit 70b94894718399f191075561feb4f2f4f31b4aa9
Author: Alexander Stein <alexander.stein@ew.tq-group.com>

drm/bridge: tc358767: do not open-code devm_drm_of_get_bridge in DSI path

This commit replaces the open-coded panel/bridge discovery logic
with devm_drm_of_get_bridge() to simplify the probing code path
in the tc358767 bridge driver.

> diff --git a/drivers/gpu/drm/bridge/tc358767.c b/drivers/gpu/drm/bridge/t=
c358767.c
> --- a/drivers/gpu/drm/bridge/tc358767.c
> +++ b/drivers/gpu/drm/bridge/tc358767.c
[ ... ]
> @@ -2341,28 +2341,22 @@ static int tc_probe_edp_bridge_endpoint(struct tc=
_data *tc)
>  {
>  	struct device *dev =3D tc->dev;
>  	struct drm_bridge *bridge;
> -	struct drm_panel *panel;
>  	int ret;
> =20
>  	/* port@2 is the output port */
> -	ret =3D drm_of_find_panel_or_bridge(dev->of_node, 2, 0, &panel, &bridge=
);
> -	if (ret && ret !=3D -ENODEV)
> -		return dev_err_probe(dev, ret,
> -				     "Could not find DSI panel or bridge\n");
> -
> -	if (panel) {
> -		struct drm_bridge *panel_bridge;
> -
> -		panel_bridge =3D devm_drm_panel_bridge_add(dev, panel);
> -		if (IS_ERR(panel_bridge))
> -			return PTR_ERR(panel_bridge);
> -
> -		tc->panel_bridge =3D panel_bridge;
> -		tc->bridge.type =3D DRM_MODE_CONNECTOR_eDP;
> -	} else {
> -		tc->bridge.type =3D DRM_MODE_CONNECTOR_DisplayPort;
> +	bridge =3D devm_drm_of_get_bridge(dev, dev->of_node, 2, 0);
> +	if (IS_ERR(bridge)) {
> +		ret =3D PTR_ERR(bridge);
> +		if (ret !=3D -ENODEV)
> +			return dev_err_probe(dev, ret,
> +					     "Could not find DSI panel or bridge\n");
> +		else
> +			return ret;

[Severity: High]
Does this break the probe sequence for DisplayPort configurations?

The previous code in tc_probe_edp_bridge_endpoint() allowed -ENODEV
to bypass the early return, falling back to setting the bridge type to
DRM_MODE_CONNECTOR_DisplayPort when no panel or bridge was found.

By explicitly returning ret when it equals -ENODEV, probe is now aborted
if the downstream device isn't fixed in the device tree. Could this cause
the DisplayPort/eDP bridge driver to fail to load on valid hardware setups?

>  	}
> =20
> +	tc->panel_bridge =3D bridge;
> +	tc->bridge.type =3D bridge->type;
> +
>  	if (tc->hpd_pin >=3D 0)
>  		tc->bridge.ops |=3D DRM_BRIDGE_OP_DETECT;
>  	tc->bridge.ops |=3D DRM_BRIDGE_OP_EDID;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624121515.2301=
219-1-alexander.stein@ew.tq-group.com?part=3D4
