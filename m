Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46095CA5FF0
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 12:30:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 92E4010F298;
	Tue,  6 Oct 2026 12:30:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CgC9OJf5";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6ABC710E3AE
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 12:30:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 24B7243C77;
 Tue,  6 Oct 2026 12:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84A911F000FF;
 Tue,  6 Oct 2026 12:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791289844;
 bh=eYZ887+bbPIkK+uFPLZZOwWmb9webKDFve3kxvppxFI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CgC9OJf5jOC5cppcglD4lRmQyTlm44UpWhyEB65r9Co5KYw6D9Mn2wCBRLtPuUBqj
 SdFZs+1D8yq55jXYB6fnEzWNT+0NJ5YoeoBcmvLSA1eEstGHQdTUA7mRUPkUOlFsQE
 b/I5enG0//iiSGG2dA3/XOxsWr1jsoR0KYyq/B2vUhFPH1Hkiad6EppUukP2RwSIT0
 z0M4aLnq0+Wp5GUu85ny/H3XNph6l3+BOezuQgljZnC4MMQbyTyqeuKDbF7FAKZT4P
 RGDOskhaR7KkKgVmvYvqOd8JRgqk8Dsy8A3g3QgHQzauez8jj9Cti/KRa2h0a+v+Pz
 DKdUSyflPo1+g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/9] drm/bridge: fsl-ldb: Get the next non-panel bridge
To: "Laurentiu Palcu" <laurentiu.palcu@oss.nxp.com>
Cc: conor+dt@kernel.org, linux-clk@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Frank.Li@kernel.org,
 devicetree@vger.kernel.org, imx@lists.linux.dev, robh@kernel.org
In-Reply-To: <20261006-dcif-upstreaming-v10-2-bcfb28de0aae@oss.nxp.com>
References: <20261006-dcif-upstreaming-v10-0-bcfb28de0aae@oss.nxp.com>
 <20261006-dcif-upstreaming-v10-2-bcfb28de0aae@oss.nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 06 Oct 2026 12:30:43 +0000
Message-Id: <20261006123043.84A911F000FF@smtp.kernel.org>
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
- [Medium] commit message: code and commit message mismatch
--

commit e12c6082d93fb0f1838677a94386e1a971817862
Author: Liu Ying <victor.liu@nxp.com>

drm/bridge: fsl-ldb: Get the next non-panel bridge

This commit refactors the fsl-ldb driver to support getting either a panel
bridge or a non-panel bridge as the next bridge in the chain.

> The next bridge in bridge chain could be a panel bridge or a non-panel
> bridge.  Use devm_drm_of_get_bridge() to replace the combination
> function calls of of_drm_find_panel() and devm_drm_panel_bridge_add()
> to get either a panel bridge or a non-panel bridge, instead of getting
> a panel bridge only.

[Severity: Medium]
Is this description accurate for the changes implemented in this patch?

The commit message explicitly claims that devm_drm_of_get_bridge() was used
to replace of_drm_find_panel() and devm_drm_panel_bridge_add(). However,
looking at the diff below, the actual code replaces
of_drm_find_and_get_bridge() with of_drm_get_bridge_by_endpoint() in
fsl_ldb_probe().

Neither devm_drm_of_get_bridge() nor the combination of of_drm_find_panel()
and devm_drm_panel_bridge_add() are present in the previous code or the new
diff.

Could the commit message be updated to accurately reflect the actual API
changes being made?

> diff --git a/drivers/gpu/drm/bridge/fsl-ldb.c b/drivers/gpu/drm/bridge/fs=
l-ldb.c
> index 7ec84c81cd786..52ae7f5b63c7c 100644
> --- a/drivers/gpu/drm/bridge/fsl-ldb.c
> +++ b/drivers/gpu/drm/bridge/fsl-ldb.c

[ ... ]

> @@ -339,10 +336,14 @@ static int fsl_ldb_probe(struct platform_device *pd=
ev)
>  	if (of_property_present(dev->of_node, "nxp,enable-termination-resistor"=
))
>  		fsl_ldb->use_termination_resistor =3D true;
> =20
> -	fsl_ldb->bridge.next_bridge =3D of_drm_find_and_get_bridge(panel_node);
> -	of_node_put(panel_node);
> -	if (!fsl_ldb->bridge.next_bridge)
> -		return -ENODEV;
> +	next_bridge =3D of_drm_get_bridge_by_endpoint(dev->of_node,
> +						    fsl_ldb->ch0_enabled ? 1 : 2,
> +						    0);
> +	if (IS_ERR(next_bridge))
> +		return dev_err_probe(dev, PTR_ERR(next_bridge),
> +				     "failed to get next bridge\n");
> +
> +	fsl_ldb->bridge.next_bridge =3D next_bridge;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261006-dcif-upstr=
eaming-v10-0-bcfb28de0aae@oss.nxp.com?part=3D2
