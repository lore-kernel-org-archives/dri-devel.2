Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC16C5518F
	for <dri-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:22:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B4ECD10E89A;
	Tue,  4 Aug 2026 07:22:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="h+Z6LrVP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D004110E8A0
 for <dri-devel@lists.freedesktop.org>; Tue,  4 Aug 2026 07:22:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D30F160A59;
 Tue,  4 Aug 2026 07:22:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BFC71F000E9;
 Tue,  4 Aug 2026 07:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785828171;
 bh=PSpfewWeW10lw1dE3Xclc1neq3YTzepdfNkePBi8HuQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=h+Z6LrVPc+GN55cHfYXEbqkgCpBmv2hmHYdIxHoTMSGgeqYJwOad1wHzYERtUM3Ho
 eIZ2eKcSb11pCk2Afeg0wM1bQMc3GC+0f0fFIGy7NIlsVaBokwrHntqIPg/WB3pReY
 z6a/XcbTg5SANKpiWnfJiGt8D37QnTyg6/X2iR6WSsKq1gwXfs2rU3MvXjUZOTxFbV
 itveYZ6QcELsuBerAyLWypdlw/9nAxQVqxj7CIF+U5LKf4Z8Ek157UW3vlbdMH8u1/
 tSDQMsIBx8AtMMDBfBARDqgz0EQLx82oCzG18YZadQHSJd7gdLz/Y/ymyZ1+cdI/Ds
 3i1SEiVaPQEXQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/7] drm/bridge: aux: Add
 drm_aux_bridge_register_from_node()
To: "Chaoyi Chen" <kernel@airkyi.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com, vkoul@kernel.org, neil.armstrong@linaro.org
In-Reply-To: <20260804070730.68-5-kernel@airkyi.com>
References: <20260804070730.68-1-kernel@airkyi.com>
 <20260804070730.68-5-kernel@airkyi.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 07:22:50 +0000
Message-Id: <20260804072251.4BFC71F000E9@smtp.kernel.org>
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
- [High] drm_aux_bridge_register_from_node() assigns the provided device no=
de without taking a reference, leading to a reference count underflow when =
the device is released or initialization fails.
--

--- Patch [4]: [PATCH v6 4/7] drm/bridge: aux: Add drm_aux_bridge_register_=
from_node() ---
commit 589f6bc20e86e41fcd3fb17c01ef52cecefa8a82
Author: Chaoyi Chen <chaoyi.chen@rock-chips.com>

drm/bridge: aux: Add drm_aux_bridge_register_from_node()

This commit introduces drm_aux_bridge_register_from_node() to allow
specifying the of_node corresponding to the bridge, extending the
existing drm_aux_bridge_register() functionality.

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
Does this code need to take a reference on np before setting it?

Looking at device_set_of_node_from_dev(), it correctly acquires a reference
using of_node_get(). However, device_set_node() only assigns the pointer
without taking a reference.

If initialization fails, the error path unconditionally drops a reference:

	ret =3D auxiliary_device_init(adev);
	if (ret) {
		of_node_put(adev->dev.of_node);
		...

Additionally, drm_aux_bridge_release() unconditionally calls of_node_put()
when the device is released.

Could assigning the node here without of_node_get() cause a reference count
underflow and a potential use-after-free for the provided node?

> +	else
> +		device_set_of_node_from_dev(&adev->dev, parent);
> =20
>  	ret =3D auxiliary_device_init(adev);
>  	if (ret) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804070730.68-1=
-kernel@airkyi.com?part=3D4
