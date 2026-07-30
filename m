Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 852EEC54FCD
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 01:42:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E3BA010ECFD;
	Thu, 30 Jul 2026 01:42:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mDd57DCz";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45DA410ECFD
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Jul 2026 01:42:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id F1F3041210;
 Thu, 30 Jul 2026 01:42:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 089BE1F000E9;
 Thu, 30 Jul 2026 01:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785375777;
 bh=4+yndoO9TpigdF1QR7m/oUtzbNiuYSE7FpoLZqQTKj0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mDd57DCz/V6QpY9Ow0hEkjnem3x1gfI2kyxo3hNIXkiOYFkmdbnzoK6S+q751tmcI
 kxpWdsYNxlVs+BPCKKJWH7Ek6VvyHkAhPuOMr2gJo69PlwF0sskGxScOxBEXaDs7z1
 PVlDySw56qQP7r39forZKGJrykBKwxBqYCObU89TQg94MMWm+9DU6D45s3XTLMVdlg
 +nOAC2A0Md1aphKhNJtlTAFba/mOIibRzluQT+HI6XmRhJFzDaS9SwuWJmJPoJYa1E
 9kXr92ns4MaNcD4irrm+VjXVtnAvx3UTA+GUselrOVpbI2Ae8OL58cF1jkNcAFxHEL
 VL6o2kxApx87A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/6] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: olteanv@gmail.com, dri-devel@lists.freedesktop.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, linux-phy@lists.infradead.org
In-Reply-To: <20260730013349.51-4-kernel@airkyi.com>
References: <20260730013349.51-1-kernel@airkyi.com>
 <20260730013349.51-4-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 30 Jul 2026 01:42:56 +0000
Message-Id: <20260730014257.089BE1F000E9@smtp.kernel.org>
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
- [High] Unbalanced `of_node_put()` on the provided device node `np` leads =
to reference count underflow and potential use-after-free.
--

--- Patch [3]: [PATCH v5 3/6] drm/bridge: aux: Add drm_aux_bridge_register_=
from_node() ---
commit 73b014949499087c9b0b99c49dc18c4868428dcd
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: aux: Add drm_aux_bridge_register_from_node()
   =20
This patch introduces a new function to register an auxiliary bridge using
a specifically provided device node, instead of defaulting to the parent's
device node.

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
Does this path cause a reference count underflow on the provided device nod=
e?

When np is provided, device_set_node() simply assigns the node pointer
without taking a reference via of_node_get(). In contrast, the fallback
path device_set_of_node_from_dev() properly acquires a reference.

Both the error path below (when auxiliary_device_init() fails) and the
normal device release callback drm_aux_bridge_release() unconditionally
call of_node_put(adev->dev.of_node). This drops a reference that was never
acquired in the np !=3D NULL branch.

If the API intended to consume a reference from the caller, the error
paths appear to be structurally broken: failure in ida_alloc() does not
drop the reference, but failure in auxiliary_device_init() does, leaving
the caller unable to know if it should clean up the reference.

Should we add an of_node_get() here?

> +	else
> +		device_set_of_node_from_dev(&adev->dev, parent);
> =20
>  	ret =3D auxiliary_device_init(adev);
>  	if (ret) {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730013349.51-1=
-kernel@airkyi.com?part=3D3
