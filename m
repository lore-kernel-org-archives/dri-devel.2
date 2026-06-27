Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27F76C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:41:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9083B10F759;
	Sat, 27 Jun 2026 03:41:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Jf7VEHHA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 18BF610F759
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:41:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FD39600AA;
 Sat, 27 Jun 2026 03:41:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 118811F000E9;
 Sat, 27 Jun 2026 03:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531706;
 bh=HaOQbPMk8eHRbcyj0d9yq5Y/ROhzO3epG6TOoy2q0vc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Jf7VEHHAMzXzLyMMm5XqLg/B9zBFkvQp/HeMhME4UV/uf0j73+LHfXcBdm5GbwRYO
 hnz1AQ3CWlcrlYeD73uomQUkKE8Dbta39AJHyDJEcvK1fGC02bOC6acIjhGOwj5eul
 0n1ZVR0fFCQKMYnR/WWTBJm21aI0/k3hC7H/vhZl/jYUa6NKwnd5juEMDrR5VhbPS+
 cDB3g7lxHyiZzeA24jUN1j+ZqSLhSH1RNWH8Hi8hY8Sh6vb6bJ8kj05prPZdxLLwmL
 L/dbM/WbmoQ527qiVASCUYiKtjNyvOSP8qwYTDyYwqOwwz/jRKJwaK8o4PAbebC9M2
 6V/gIespjj0kQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/38] drm/vkms: Add error handling in plane config
 creation
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-8-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-8-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:41:45 +0000
Message-Id: <20260627034146.118811F000E9@smtp.kernel.org>
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
- [Low] The `__must_check` attribute was added to the function definition b=
ut omitted from the function declaration in the header file.
--

commit b58f544faddd7341ba3d5a39105fac34d6c709cf
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Add error handling in plane config creation

This commit updates vkms_config_create_plane() to return proper error codes
using ERR_PTR instead of returning NULL on failure. It also adds the
__must_check attribute to the function definition.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index 5a654d6dead84..1fd2ed1167c54 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -384,13 +384,16 @@ void vkms_config_register_debugfs(struct vkms_devic=
e *vkms_device)
>  			      ARRAY_SIZE(vkms_config_debugfs_list));
>  }
> =20
> -struct vkms_config_plane *vkms_config_create_plane(struct vkms_config *c=
onfig)
> +struct vkms_config_plane __must_check *vkms_config_create_plane(struct v=
kms_config *config)

[Severity: Low]
Does the __must_check attribute also need to be added to the function
declaration in drivers/gpu/drm/vkms/vkms_config.h?

Since the attribute is only present on the definition here in vkms_config.c,
callers in other translation units won't see it. The compiler will not emit
a warning if the return value is ignored by external callers.

>  {
>  	struct vkms_config_plane *plane_cfg;
> +	int ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D8
