Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93ADCC9832A
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 13:54:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DBAD910E111;
	Tue, 29 Sep 2026 13:54:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="H6jMg8Yu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1EF1710E111
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 13:54:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D3E5540353;
 Tue, 29 Sep 2026 13:54:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B6B21F000FF;
 Tue, 29 Sep 2026 13:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790690071;
 bh=VKPVzKnYqo0bbVCgvn/jt9QsuxNgYAd7D2WGX2Kb188=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=H6jMg8YumCyAZJjIBscffb/PQgVk7SeVKy1z9xpBVt66an2NP2FWP0d5a4+rfsawr
 8nHU+h9GaNO3Xv2JXLlpdKScNnbD14wR8Bd1Fxt7p802WsOfDCT/or9k3YmRvHUK12
 JS38rkhhntGg+UihK6nEyiv5Wpf1lq9j2h3t3ED1ACmQE4qXRs3I3g1epqO+hib+Xu
 AU70lfNsUXYtkJv9hEPgcKkUNnToVeY/vFriB0Rd4E+TZplX3R5xwpOHStU3+8keLT
 VfEIDcS+V+PfFfNZrbF57DrmS5C5+d1t8n/6D8va6KgjZ3fg+D+oJ1w7fbyU/we8vH
 /t+SS7uJqKDxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 6/7] drm/vc4: dsi: stop using deprecated
 drmm_of_get_bridge()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v2-6-6da431d8f180@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v2-6-6da431d8f180@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 13:54:31 +0000
Message-Id: <20260929135431.6B6B21F000FF@smtp.kernel.org>
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
- [Medium] drm/vc4: bridge reference leak on component bind failure or rebi=
nd
--

commit 583ab26f73be63066db6ca20da5c1de3ee1767ef
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm/vc4: dsi: stop using deprecated drmm_of_get_bridge()

This commit replaces the deprecated drmm_of_get_bridge() with
of_drm_get_bridge_by_endpoint() to acquire the DRM bridge. It assigns the
returned refcounted bridge to dsi->bridge.next_bridge to rely on automatic
cleanup upon destruction.

> diff --git a/drivers/gpu/drm/vc4/vc4_dsi.c b/drivers/gpu/drm/vc4/vc4_dsi.c
> index 0148f2befed14..30598738cfcf3 100644
> --- a/drivers/gpu/drm/vc4/vc4_dsi.c
> +++ b/drivers/gpu/drm/vc4/vc4_dsi.c

[ ... ]

> @@ -1749,9 +1747,9 @@ static int vc4_dsi_bind(struct device *dev, struct =
device *master, void *data)
>  		return ret;
>  	}
> =20
> -	dsi->out_bridge =3D drmm_of_get_bridge(drm, dev->of_node, 0, 0);
> -	if (IS_ERR(dsi->out_bridge))
> -		return PTR_ERR(dsi->out_bridge);
> +	dsi->bridge.next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node,=
 0, 0);
> +	if (IS_ERR(dsi->bridge.next_bridge))
> +		return PTR_ERR(dsi->bridge.next_bridge);
> =20
>  	/* The esc clock rate is supposed to always be 100Mhz. */
>  	ret =3D clk_set_rate(dsi->escape_clock, 100 * 1000000);

[Severity: Medium]
Does this code leak the bridge reference if vc4_dsi_bind() fails here or in
subsequent initialization steps?

Since of_drm_get_bridge_by_endpoint() returns a refcounted pointer (unlike
the previous devm-managed drmm_of_get_bridge()), if clk_set_rate() fails
just below this hunk, the function returns without putting the newly
acquired reference.

If the aggregate DRM device defers probe and retries binding components,
vc4_dsi_bind() could run again, overwriting dsi->bridge.next_bridge and
permanently leaking the previous reference. The automatic cleanup of
next_bridge only happens when dsi->bridge is destroyed, which does not
occur during component bind failures or component unbinds.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-drm-fix-of=
_get_bridge-build-regression-v2-0-6da431d8f180@bootlin.com?part=3D6
