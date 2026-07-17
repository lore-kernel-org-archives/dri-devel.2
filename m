Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FAEBC44515
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 07:33:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4103B10E401;
	Fri, 17 Jul 2026 07:33:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="K41Fx4v9";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DF3D10E401
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 07:33:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2316F43935;
 Fri, 17 Jul 2026 07:33:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADB331F00A3A;
 Fri, 17 Jul 2026 07:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784273593;
 bh=mdIEkZeC84PdXzOvpRfi+ovbwMjSaaPCZZFU6v1KpG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=K41Fx4v90rb/3ei7KVNAqSIiqvElhlSDsDEX5yvOGSfSRP9739es2B73N0Ea1uNhC
 39CBRR2JOTRCMYcRLYA29Vkr1ltV1gd7HRUOeAXCly9lqINZ++KvxJeRFPu3W3tP8u
 lK97tvyjePyk8ymk+bH1YrFjMDdf0C1MSrPNcgcUCU4hfiIGk8m4tf4j62cYVfUpet
 IM3ukhMgPhnRj44dowxuDRMYYChf9VBx6tNcNpanryC67Qexv9kdv50Iwn/rOwlDX7
 YR6ydCZgITi2O8arwPNKepeoWPROvuFl9iQWV4EyqS5+y1keMw6WHxV+iIvjOEBhBJ
 HJbHujV8mtYTQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/5] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: vkoul@kernel.org, neil.armstrong@linaro.org,
 dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com
In-Reply-To: <20260717072323.96-3-kernel@airkyi.com>
References: <20260717072323.96-1-kernel@airkyi.com>
 <20260717072323.96-3-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 07:33:12 +0000
Message-Id: <20260717073312.ADB331F00A3A@smtp.kernel.org>
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
- [High] Unbalanced `of_node_put()` in `drm_aux_bridge_register_from_node()=
` and `drm_aux_bridge_release()` causes a reference count underflow for the=
 provided `device_node`.
--

--- Patch [2]: [PATCH v3 2/5] drm/bridge: aux: Add drm_aux_bridge_register_=
from_node() ---
commit b2b66972200bdc4b6541ca41f8ae44c08d81a964
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: aux: Add drm_aux_bridge_register_from_node()

The drm_aux_bridge_register() uses the device->of_node as the bridge->of_no=
de.
This patch adds drm_aux_bridge_register_from_node() to allow specifying the
of_node corresponding to the bridge.

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
Does this cause a reference count underflow for the device node?

Unlike device_set_of_node_from_dev() which safely acquires a reference to t=
he
of_node, device_set_node() just assigns the pointer without calling
of_node_get().

If auxiliary_device_init() fails, the error path below unconditionally calls
of_node_put(adev->dev.of_node). Similarly, the pre-existing
drm_aux_bridge_release() callback drops a reference when the device is
destroyed.

Could this cause of_node_put() to drop a reference that was never acquired?

> +	else
> +		device_set_of_node_from_dev(&adev->dev, parent);
> =20
>  	ret =3D auxiliary_device_init(adev);
>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260717072323.96-1=
-kernel@airkyi.com?part=3D2
