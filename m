Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C250ECD8C8E
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 07:17:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FE310EE16;
	Mon,  8 Jun 2026 07:17:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="B10j8/Wb";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE95C10EE14
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 07:17:30 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1A939600AE;
 Mon,  8 Jun 2026 07:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F12911F00898;
 Mon,  8 Jun 2026 07:17:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780903049;
 bh=qkwwLnOCKE+A1gdvjXF1qeS2vXC+2jnKOFu+V0Uz5UQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=B10j8/WbgHUCyRSLpENIvzg2mrU4QUq8M1fSI0o9LYE2TdhiIfY3aeZ4y2hRogzct
 lhQyjY+sF5IBWrAmZ7jI1xfdy34exUihb6KY3VTvXkyXcXgkdEDnfzMsYKzvmTY8ES
 NhBOdWg2bcZ9AeghBBM+84wqEHbVNPUcElDwkd6mWnF3td5gqFSrPUVXxyb8xivCYo
 InFemCH+fITIVSs+XfxyQ5CJecOGyIfWcZ/AIygxj49HCaNhfHaxj/ADAPYgg0bDQV
 9RE56JlZzmA4BjaxQZ2jaslWIXkb8DZmmII9U3p1ZQrKyMG6tpsto5Xka7bSObfQkD
 lhsvJVaeSMdwg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/5] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org, linux-phy@lists.infradead.org,
 dri-devel@lists.freedesktop.org, olteanv@gmail.com
In-Reply-To: <20260608070805.88-3-kernel@airkyi.com>
References: <20260608070805.88-3-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 07:17:28 +0000
Message-Id: <20260608071728.F12911F00898@smtp.kernel.org>
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
- [High] Missing `of_node_get()` on `np` causes an OF node reference count =
underflow when the device is unregistered or fails initialization.
--

commit cb36f8cc044a8e4dcecbd3dd967a5ee3d94e60aa
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: aux: Add drm_aux_bridge_register_from_node()

This patch introduces drm_aux_bridge_register_from_node() to allow
registering an aux bridge with a specific device node pointer. It refactors
drm_aux_bridge_register() to call this new function.

> diff --git a/drivers/gpu/drm/bridge/aux-bridge.c b/drivers/gpu/drm/bridge=
/aux-bridge.c
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
> +	else
> +		device_set_of_node_from_dev(&adev->dev, parent);
> =20
>  	ret =3D auxiliary_device_init(adev);
>  	if (ret) {
>  		of_node_put(adev->dev.of_node);

[Severity: High]
Does this code introduce an OF node refcount underflow when np is provided?

When np is not NULL, device_set_node() is called, which simply assigns the
pointer without acquiring a reference. However, the else branch calls
device_set_of_node_from_dev(), which explicitly calls of_node_get().

If auxiliary_device_init() fails, the error path shown above unconditionally
calls of_node_put(adev->dev.of_node).

Similarly, when the device is destroyed, drm_aux_bridge_release() performs:

drivers/gpu/drm/bridge/aux-bridge.c:drm_aux_bridge_release() {
	struct auxiliary_device *adev =3D to_auxiliary_dev(dev);

	of_node_put(dev->of_node);
	...
}

Will this lead to an unbalanced of_node_put() dropping a reference that was
never acquired when a specific device node pointer is passed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608070805.88-1=
-kernel@airkyi.com?part=3D2
