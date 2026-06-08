Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EACBBCD8C9F
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2ECF910EE20;
	Mon,  8 Jun 2026 07:22:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="TY/M5BqF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF57510EE22
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:22:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 70C1B6001D;
 Mon,  8 Jun 2026 07:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D16521F00893;
 Mon,  8 Jun 2026 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780903372;
 bh=ziVCRKfQcwfSJt7PbRlTI6G3VcqLUslFQ59UFeIhpqM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=TY/M5BqF4GHrjOiIOFolNNGwZYlVYPa6tTB6Y9k0bFHVX1Zvg2b3ov5nNYg0B7dYE
 FAf+tPDDYOf3P2Td2T2+0PqGrTaSP5stD3Ug4YyxdE3NrFHnuOan2pybwH1pr3e5iv
 GnVl/87n5CT++3xMdY3t6vKewVOAqmOiTO2w/zs4W2CJDNeNl4FLA1X7GOHjS8Us67
 K14ahFoBTYQCJwg+G1vpFj0lzj8/4BGBN48U+ucgC0XETe6p9/Z6iZ9tsFOTCEcc5h
 gG2pQaVCMaSIv692alWkeW860AEb5ec1OKyCaEKuJ3aD+Ixh4ZEfLeiwOUDgXm0rfU
 /heRGi5lOo5LQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/rockchip: cdn-dp: Support handle lane info
 without extcon
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: olteanv@gmail.com, neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 vkoul@kernel.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20260608070805.88-5-kernel@airkyi.com>
References: <20260608070805.88-5-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:22:51 +0000
Message-Id: <20260608072251.D16521F00893@smtp.kernel.org>
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
- [High] Incorrect extcon pointer validation logic skips valid extcon devic=
es
--

commit a9e1ff8879a685d4cf4ae0348e11004c03d1dc46
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/rockchip: cdn-dp: Support handle lane info without extcon

This commit adds support for getting PHY lane info without the help of extc=
on
when the Type-C controller is present. It updates multiple functions to ver=
ify
the extcon device pointer before using it.

> diff --git a/drivers/gpu/drm/rockchip/cdn-dp-core.c b/drivers/gpu/drm/roc=
kchip/cdn-dp-core.c
> index 177e30445ee83..9068118859e21 100644
> --- a/drivers/gpu/drm/rockchip/cdn-dp-core.c
> +++ b/drivers/gpu/drm/rockchip/cdn-dp-core.c

[ ... ]

> @@ -1121,14 +1130,14 @@ static int cdn_dp_probe(struct platform_device *p=
dev)
>  		    PTR_ERR(phy) =3D=3D -EPROBE_DEFER)
>  			return -EPROBE_DEFER;
> =20
> -		if (IS_ERR(extcon) || IS_ERR(phy))
> +		if (IS_ERR(phy) || PTR_ERR(extcon) !=3D -ENODEV)
>  			continue;

[Severity: High]
Does this logic skip valid extcon devices?

When extcon_get_edev_by_phandle() returns a valid pointer, PTR_ERR(extcon)
evaluates to the pointer's memory address, which will not equal -ENODEV.

This causes the condition to evaluate to true, executing the continue
statement and bypassing initialization for boards that rely on a valid
extcon device.

> =20
>  		port =3D devm_kzalloc(dev, sizeof(*port), GFP_KERNEL);
>  		if (!port)
>  			return -ENOMEM;
> =20
> -		port->extcon =3D extcon;
> +		port->extcon =3D IS_ERR(extcon) ? NULL : extcon;
>  		port->phy =3D phy;
>  		port->dp =3D dp;
>  		port->id =3D i;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608070805.88-1=
-kernel@airkyi.com?part=3D4
