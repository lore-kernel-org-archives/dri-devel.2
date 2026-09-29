Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4E91CA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 10:51:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51EBB10EE35;
	Tue, 29 Sep 2026 10:51:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="NdIFAZyh";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B827910EE35
 for <dri-devel@lists.freedesktop.org>; Tue, 29 Sep 2026 10:51:25 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5094E439CD;
 Tue, 29 Sep 2026 10:51:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59021F000FF;
 Tue, 29 Sep 2026 10:51:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790679085;
 bh=UCYGDT2yDOhBVf3mGdvQ5gwxucliLQxv1MZclYlfDpM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=NdIFAZyh7bstaEq/Yctu3S3D75eH78/IwN/Xv84sSQ1YML17iSRVZ06jBtnVix3An
 lMaWLfqfLHzk8x8usu7kxGrcyI6YN1he1D5bOW5wG+sa9LaP9yZWncBiSOm+qASToZ
 pp1jiZYv42EgLQMHWiidhf9RXdqT+0DOXV7XLcXG1gPXdHOGyxHBhrl8IfzjhEnu4r
 yaaiu64gIJjsDejagVVAT3BT7/qe6rwlMpUZyFZKaC1eNsM29u7HywQ4XBMFY5XJai
 ggQmPGjXpzVC+xVQdZjajK5Gao1WUL/fBeMifj1Dgw4UVYCMdfAjLYaQ2ixz61cTA5
 VnRQh87Pj7IxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] drm: verisilicon: stop using deprecated
 devm_drm_of_get_bridge()
To: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org,
 wsa+renesas@sang-engineering.com
In-Reply-To: <20260929-drm-fix-of_get_bridge-build-regression-v1-2-ccb7e602daad@bootlin.com>
References: <20260929-drm-fix-of_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com>
 <20260929-drm-fix-of_get_bridge-build-regression-v1-2-ccb7e602daad@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 29 Sep 2026 10:51:24 +0000
Message-Id: <20260929105124.E59021F000FF@smtp.kernel.org>
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
- [Medium] drm/verisilicon: reference leak of next bridge when devm_drm_bri=
dge_alloc fails
--

commit 49db4512b47fdbbe2150c6b5f4f559940d0929cd
Author: Luca Ceresoli <luca.ceresoli@bootlin.com>

drm: verisilicon: stop using deprecated devm_drm_of_get_bridge()

devm_drm_of_get_bridge() is deprecated, switch to
of_drm_get_bridge_by_endpoint(). As of_drm_get_bridge_by_endpoint() returns
a refcounted bridge, ensure it is put by using bridge.next_bridge.

Link: https://lore.kernel.org/r/20260928161605.2271412-1-arnd@kernel.org

> diff --git a/drivers/gpu/drm/verisilicon/vs_bridge.c b/drivers/gpu/drm/ve=
risilicon/vs_bridge.c
> index dc7c85b07fe32..f1e8112f0ed25 100644
> --- a/drivers/gpu/drm/verisilicon/vs_bridge.c
> +++ b/drivers/gpu/drm/verisilicon/vs_bridge.c
[ ... ]
> @@ -303,8 +303,7 @@ struct vs_bridge *vs_bridge_init(struct drm_device *d=
rm_dev,
>  		return NULL;
>  	}
> =20
> -	next =3D devm_drm_of_get_bridge(drm_dev->dev, drm_dev->dev->of_node,
> -				      output, intf);
> +	next =3D of_drm_get_bridge_by_endpoint(drm_dev->dev->of_node, output, i=
ntf);
>  	if (IS_ERR(next)) {
>  		ret =3D PTR_ERR(next);
>  		if (ret !=3D -EPROBE_DEFER)

[Severity: Medium]
Will this leak the refcounted bridge next on error paths?

Since of_drm_get_bridge_by_endpoint() returns a refcounted bridge, it
appears a reference leak will happen in vs_bridge_init() if the subsequent
allocation fails:

	bridge =3D devm_drm_bridge_alloc(drm_dev->dev, struct vs_bridge, base,
				       bridge_funcs);
	if (IS_ERR(bridge))
		return ERR_PTR(PTR_ERR(bridge));

Does this error path need a call to drm_bridge_put(next) to properly release
the reference before returning?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260929-drm-fix-of=
_get_bridge-build-regression-v1-0-ccb7e602daad@bootlin.com?part=3D2
