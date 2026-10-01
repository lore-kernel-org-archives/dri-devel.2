Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88791CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 13:23:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D75B210E3CE;
	Thu,  1 Oct 2026 13:23:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YS0Q1KkA";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1975510E379
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 13:23:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F0280411A9;
 Thu,  1 Oct 2026 13:23:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D3521F000FF;
 Thu,  1 Oct 2026 13:23:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790861011;
 bh=1KhjO7Ve+bwC1EXPvDPnP9O0N3bQ4V/TYRMKRG3+ks4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YS0Q1KkArPuhX28FaP5MSKeMIOxhmSz/MgC7f/XUGMCYq7AKbd51rdhaYAHfeC/LE
 UTxPev2x8J0uQO4f8YvbX7ffMwCNGjP6tjZr6djv4JE81b1l+YippKo4Rh8CgfzawJ
 l9pcva8RIALWf/df7HDoZtWbbO5y9fKGLY15HmNok+lCOCU5deHuJ7O+QE7XfUDF78
 w8oJGZM7o+YZBoYiRtyg0CkzHfx/YbNcTc83dXkQFxOAkYk6qLWDH8fciv+NkgTYLK
 kADqL3fjjxVJfSdAbJYwaLWsHa6H9zUIYYCX57PtD7HsCdlx2gx0QZop5ojRJUcdcY
 nf6IaBbOzg++Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 20/24] drm/bridge: ti-sn65dsi83: implement
 .get_next_bridge
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20261001-drm-bridge-hotplug-v2-20-8e34986dcb68@bootlin.com>
References: <20261001-drm-bridge-hotplug-v2-0-8e34986dcb68@bootlin.com>
 <20261001-drm-bridge-hotplug-v2-20-8e34986dcb68@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 13:23:31 +0000
Message-Id: <20261001132331.9D3521F000FF@smtp.kernel.org>
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
- [High] drm/bridge: ti-sn65dsi83: missing refcount increment in get_next_b=
ridge
--

commit cea7189b53e4a71deaaf15ff6f56ed70a0d97448
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/bridge: ti-sn65dsi83: implement .get_next_bridge

This commit adds the get_next_bridge callback to expose the next bridge in
the chain for the ti-sn65dsi83 driver.

> diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/brid=
ge/ti-sn65dsi83.c
> index eb5b249cc43c7..76fc0ca8cd196 100644
> --- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> +++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
> @@ -295,6 +295,13 @@ static struct sn65dsi83 *bridge_to_sn65dsi83(struct =
drm_bridge *bridge)
>  	return container_of(bridge, struct sn65dsi83, bridge);
>  }
> =20
> +static struct drm_bridge *sn65dsi83_get_next_bridge(struct drm_bridge *b=
ridge)
> +{
> +	struct sn65dsi83 *ctx =3D bridge_to_sn65dsi83(bridge);
> +
> +	return ctx->panel_bridge ?: ERR_PTR(-ENODEV);
> +}

[Severity: High]
Does this need to increment the refcount of the returned panel bridge?

The API contract for the get_next_bridge callback in include/drm/drm_bridge=
.h
states that it must return a bridge with its refcount incremented, as calle=
rs
are expected to invoke drm_bridge_put() when they are done.

Since ctx->panel_bridge is returned directly without calling drm_bridge_get=
(),
could a caller traversing the chain cause a refcount underflow? This could
potentially lead to a use-after-free of the panel bridge object when the
caller drops its reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001-drm-bridge=
-hotplug-v2-0-8e34986dcb68@bootlin.com?part=3D20
