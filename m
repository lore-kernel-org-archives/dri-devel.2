Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E20060A380C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R5V2AQU9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D506D112399;
	Thu, 26 Nov 2026 11:48:07 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0A4210E99D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:48:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8925640BE5;
 Thu, 26 Nov 2026 11:48:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C8CC1F000CF;
 Thu, 26 Nov 2026 11:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693681;
 bh=bOZbDz+e1i9vaNGKeWWiWffK1s4+IIe44nmfG8ekOqE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R5V2AQU9CBBOFms1YJQOsAh59J6qvwiBQWC5X90Z8wuhEbQrAM0GZ0Fe4P0eWCSkq
 5nlhrq8MMpQXK4TPIISY+x2bZX/w0EDGnqQ9x94QpQWx2ZnQu25EtE8rY7RkJV5g2G
 osLUV/ZVvJkGOD2d1qoshQlpS12SHIR1qUr60H5Ld4FOvwS4VWKk47tmYi9uELgPPZ
 e8lzUgLksyQMyOuUHxIhOQizksrnr77B0juIPYmqY+gCkAI6t0cOmY9+e2R91aCw3Q
 qjsu6fL5NkgYaIvuLIyzoUekoHqyaNQ6J/+nhF6g/RwkUxU9a/jhRtvCO6AqDuI/uy
 VF9n8uSXhKRZQ==
Message-ID: <sashiko-outbox-235419@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 17/43] drm/vkms: Introduce config for plane name
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-17-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-17-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:48:00 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/vkms: missing rcu_barrier() on module exit after
  call_rcu() in destroy
- [Low] drm/vkms: missing @name_len in vkms_config_plane_set_name()
  kernel-doc
- [Low] drm/vkms: duplicate include of vkms_config.h in vkms_plane.c
--

commit f9614f6973483389b18d752f2c6d793287063437
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane name

This commit adds plane name configuration support to vkms_config_plane and
passes the configured name to drmm_universal_plane_alloc() during plane
initialization.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index e2b6567238987..56ab9ea6e1410 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c

[ ... ]

> @@ -436,25 +439,57 @@ struct vkms_config_plane __must_check *vkms_config_=
create_plane(struct vkms_conf

[ ... ]

> +static void vkms_config_plane_rcu_free(struct rcu_head *head)
> +{
> +	struct vkms_config_plane *plane_cfg =3D
> +		container_of(head, struct vkms_config_plane, rcu);
> +
> +	kfree(plane_cfg->name);
> +	kfree(plane_cfg);
> +}
> +
>  void vkms_config_destroy_plane(struct vkms_config_plane *plane_cfg)
>  {
>  	xa_destroy(&plane_cfg->possible_crtcs);
>  	list_del_rcu(&plane_cfg->link);
> -	kfree_rcu(plane_cfg, rcu);
> +	call_rcu(&plane_cfg->rcu, vkms_config_plane_rcu_free);
>  }
>  EXPORT_SYMBOL_IF_KUNIT(vkms_config_destroy_plane);

[Severity: Medium]
Can vkms_config_plane_rcu_free() run after the vkms module is unloaded?

Replacing kfree_rcu() with call_rcu() queues a callback located in the
vkms module text.  When the module is unloaded, vkms_exit() drops the
last reference to default_config:

drivers/gpu/drm/vkms/vkms_drv.c:vkms_exit() {
    ...
	vkms_destroy(default_config);
	vkms_config_put(default_config);
}

vkms_config_put() -> vkms_config_release() -> vkms_config_destroy_plane()
queues vkms_config_plane_rcu_free() right before vkms_exit() returns,
without an rcu_barrier() to wait for pending callbacks before module text
is unmapped.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.h b/drivers/gpu/drm/vkms/vk=
ms_config.h
> index 8f038562afd4d..e428946cb70ea 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.h
> +++ b/drivers/gpu/drm/vkms/vkms_config.h

[ ... ]

> @@ -368,6 +370,26 @@ vkms_config_plane_set_default_pipeline(struct vkms_c=
onfig_plane *plane_cfg,
>  	plane_cfg->default_pipeline =3D default_pipeline;
>  }
> =20
> +/**
> + * vkms_config_plane_set_name() - Set the plane name
> + * @plane_cfg: Plane to set the name to
> + * @name: New plane name. The name is copied.
> + *
> + * Returns: -ENOMEM if the memory allocation failed, 0 in case of success
> + */
> +int __must_check vkms_config_plane_set_name(struct vkms_config_plane *pl=
ane_cfg,
> +					    const char *name, size_t name_len);

[Severity: Low]
The kernel-doc comment for vkms_config_plane_set_name() is missing an
entry for @name_len.

> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index fd3d34dcf0fe5..35aabec85b332 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -12,6 +12,7 @@
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_print.h>
> =20
> +#include "vkms_config.h"
>  #include "vkms_drv.h"
>  #include "vkms_formats.h"

[Severity: Low]
This isn't a bug, but vkms_plane.c already includes "vkms_config.h" at
the top of the file.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D17
