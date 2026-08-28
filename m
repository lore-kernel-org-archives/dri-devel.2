Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFD68C61DB9
	for <dri-devel@archiver.kernel.org>; Fri, 28 Aug 2026 08:57:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A9E910E0E1;
	Fri, 28 Aug 2026 08:57:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="eGfDZNQk";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A311510E0E1
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 08:57:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 574A941713;
 Fri, 28 Aug 2026 08:57:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755DA1F000E9;
 Fri, 28 Aug 2026 08:57:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787907441;
 bh=ENG5w0g3G7lGNkD5zTbR8/bu8fyRwvNz7f3KSXqkEu8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=eGfDZNQk5AHUQnQK4Dtq4a7H6kVXCNOVQ4oiR6CwdTQm1x9S92F0a6LiZX+jogC2+
 woXXujUia/BUuA6pEC2c6Jq9oBE6Ajv9d6e0wb86dciiFEqdxPp0hxsH2YR2QVrCBp
 l0iJZnC+SL6GyLFRM7Aw8CBAzpi9ENezI64LKZMViI70IgejCmVygwBp80xUR/Cxr8
 YW09En+kFPoWTLf86211sgpmdpfAD8R2iCuxdWrlrt/9AFQV4cI/QrB192RK5PDVyw
 uwjcknjIoyhA9BMC9doFANUhqXwn2/ZjmHU7enoe/ERDd4K/AWj5fcwtRyS9lFwsSN
 qMl+ZUrM55+pA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 4/7] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, vkoul@kernel.org,
 linux-phy@lists.infradead.org, olteanv@gmail.com, neil.armstrong@linaro.org
In-Reply-To: <20260828084737.565-5-kernel@airkyi.com>
References: <20260828084737.565-1-kernel@airkyi.com>
 <20260828084737.565-5-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 28 Aug 2026 08:57:20 +0000
Message-Id: <20260828085720.755DA1F000E9@smtp.kernel.org>
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
- [High] Missing OF node reference acquisition for explicitly provided devi=
ce_node `np`, leading to a reference count underflow when the device is des=
troyed or initialization fails.
--

commit e57ae2f012dd4cdc820d51259b2a37d588d5c31d
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: aux: Add drm_aux_bridge_register_from_node()

This commit adds a new function, drm_aux_bridge_register_from_node(),
which allows specifying the of_node corresponding to the bridge when
creating a simple DRM bridge device.

> diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge=
/aux-bridge.c
> index 1ed21a8713bfd..06a1466f49bd2 100644
> --- a/drivers/gpu/drm/bridge/aux-bridge.c
> +++ b/drivers/gpu/drm/bridge/aux-bridge.c
[ ... ]
> @@ -62,7 +63,10 @@ int drm_aux_bridge_register(struct device *parent)
>  	adev->dev.parent =3D parent;
>  	adev->dev.release =3D drm_aux_bridge_release;
> =20
> -	device_set_of_node_from_dev(&adev->dev, parent);
> +	if (np)
> +		device_set_node(&adev->dev, of_fwnode_handle(np));

[Severity: High]
Does this miss a reference increment for the device node?

Looking at drivers/base/core.c, device_set_node() simply assigns the
pointer without taking a reference, whereas device_set_of_node_from_dev()
internally calls of_node_get(dev2->of_node).

> +	else
> +		device_set_of_node_from_dev(&adev->dev, parent);
> =20
>  	ret =3D auxiliary_device_init(adev);
>  	if (ret) {
> 		of_node_put(adev->dev.of_node);

[Severity: High]
If np was provided and auxiliary_device_init() fails, won't this drop a
reference that was never acquired?

The same reference count underflow appears to happen during normal teardown
in drm_aux_bridge_release(), which will also unconditionally call
of_node_put() on a node that didn't have its reference count incremented
here. Should an explicit of_node_get(np) be used before assigning it?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260828084737.565-=
1-kernel@airkyi.com?part=3D4
