Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588AB606A33F
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jz+/4+YE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC97F10EA98;
	Wed, 11 Nov 2026 16:49:55 +0000 (UTC)
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com
 [74.125.82.176])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F68F10FC2F
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:49:49 +0000 (UTC)
Received: by mail-dy1-f176.google.com with SMTP id
 5a478bee46e88-36d1b3b9974so80536eec.2
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:49:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794415789; cv=none;
 d=google.com; s=arc-20260327;
 b=cfricdgIBrNQBi7NE12JWCcEWamaguW8axQ941x3W8rfF1SwIV0THnRh5R+Z9pTO+e
 tcH+baNgqqG5sUol4URKR2UjG487y2WwY4QdP6FAAo5sDa1KwNdlWUlDq4SM21FVFyoR
 zuZDZlYGUs/NSCVMmdO/7WwONIsc5CEnzPgDPdxQjNKg3qVzwb5A/aj9nIFSzc2ZiQuM
 2al+aS5py8E4Tl42mO8lXoPHeQtXBiHhmRbWsCG4gFkQXxvKWUIXZ8xrmsV+iasVCYXt
 AcAuSas85T/xnCYLA2qBEbvNTcKXESwPq9PVZn2zadQnycpP30RL5fySJ3QJ6AqENt4p
 doRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=3KSf5oiA7fw5PXAhjW9yvUP7uWd8t/r+AFUdm9OF7lQ=;
 fh=wR1CVfUTuTkdwTgih0OX/QWGfN066zGIFialZSJcDss=;
 b=ZbavNeGQlz/LyXtCbUa3aL+ezBGjhix9h69v7USySyq/b74/necgqWQfzOCT9zVD8q
 4MtmY65yXFJ6tgQmj7o2m9m7JLoiKwicrxn8ommQ+DBmD8uoIQ3A6mZJqL1uIDUVDvcT
 KIXiItET7tdEqM756c4KszPmXYWXHnJLapmjk1f0Iuws2tLfgc543wT2WjORXZRoR+jA
 sB+jnaZt3MSyO/+KS+DbG0G4f0xgpkcYeCAkUU6nR1eCG1WNiFhLApn+1AR/4VSf04R5
 ozaX07ovBNWzozWPOisWvU8WdG4lAApYbrH7PdccX0R0kGeidsCCjcEotVTV405oLT9J
 m0jw==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794415789; x=1795020589; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3KSf5oiA7fw5PXAhjW9yvUP7uWd8t/r+AFUdm9OF7lQ=;
 b=jz+/4+YEKdKN68vAsvlrCelY0c0B+zvqJKTgQG3LS1+m7/4Xu9L+D2Mu7bpDuyE5/i
 rEPnVGJmnqXoymerFQXrn+FiU7PqbopJ0ChkMRmNKsX1v1xr+xJgEWPZUMbG6or/GSHW
 dXvWs4guNRaNRTk0zlN4EViBLqiNEm0UdmG/Apbv/4hCO5GR8CoNBd2QdsDmdD5w2fKP
 qV82tYXfswSnt6napNfX2oNUOyGxLPHAXJnVHx2cUn9QkwWN+FoNjvYXcb7LRFopFdZQ
 Fs03W1B6rd4h0PfjeWmqHMMNy+jnS4C+jqo/58muOILYD3fCegBm5V4als0mgNN13wJE
 +35Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794415789; x=1795020589;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=3KSf5oiA7fw5PXAhjW9yvUP7uWd8t/r+AFUdm9OF7lQ=;
 b=Hjf/Dk0QDF3S3YKRCt6Sger5MaCOiCt58Uuzq63onj9DKv7ftF8rEmYoLS2BEtwHhh
 SB7W4qCcBQyIwfZZAifVQRSaCCoH3kRxLKRznbcF1Ha4KVcbG7xqm9chgZSTEtYXzid7
 rL3BUJUeahppA8iCPZsHfutxbh2Mv9asCNVuQK8H9KBZo9j4PBzZZrvRMini2MiNx8qo
 aO9Ce04pmrfciD7j9QzK3WkahJvP8r2hychA4ituWn/RNFBpA9rvb95yDZQbjnw8xvHS
 zHh8ADNOtdPVs+qGKArIehD+88LsQv1HMRwGanznxkLo8n188fC0zUA2j6l/yX7b46YQ
 a4xw==
X-Forwarded-Encrypted: i=1;
 AL+hErGoWE+KOeSG+pmq3bwl90nw04GUhV0UogZ1uPAsPP5f53LZn3rdM9YKbWO+pk3OcRyqvgeQeLZmrPA=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z/5mO0D31DdezoPyT6IPvCzdC7ooiMo+EZsh+T516wdzCKJZ3BW
 tapxeC+QjD4B88LpKP4u7+5Q3jUTaAC0TIOJJ2X9QL5t7mErd8v3e3QhRsaQT1bXSOuDWQUPZFI
 uZJ4dx7k54PFunD9FX6Wd4vbzveW1vOk=
X-Gm-Gg: AYBFou2X+cCUL4pQ+mnp28B81VEn6KKgQy9rWjx5pI7VLigvEFJVIsx4aewXXqnEmZC
 NcRJ6ySJfm9WPeHy9RyGNdeP/CZynNTlnczbq3ANMwlftzSTZaaE7JHwQCHtURlgKdDsLYiVZjr
 MgozrmTpMbNBQBw7pNwLVLlIuUrLaXRzh+vyY+30wiR9eYCAeTM3NC08Dv6kHJpz274upwKfa+P
 /1kdnyQZ0ZI4zkRBnM809yCiWEzJOkLjMMVb8DekqX78eLQQFDrnJB66ir2Hww0bLlCrg4ZZ/cd
 LYpwvoNlTzdfgPTrHmjJQWKuyFlSqDM0/z0YXNV8zWsVflJY8R7F8+I+sCccd6sHfW/lFTAQtEf
 RkHI4QuaCk8TsWxY1eR7IDZoF7Xi1prhlXNlEX3JBQOdsI70Gdw7pyouS3UYWc/TR8eiUiow1Jk
 kLjKoNjw+Twp1WKnR1n/egoEue/OZugok720mEha9yL2XWarvhyswoTCsBsWo=
X-Received: by 2002:a05:701b:2402:b0:1b3:a881:a67b with SMTP id
 a92af1059eb24-1b3c02dedc1mr4147363c88.1.1794415788453; Wed, 11 Nov 2026
 08:49:48 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261106-amdgpu-dumb-map-offset-v2-1-0abfb77a84b8@gmail.com>
In-Reply-To: <20261106-amdgpu-dumb-map-offset-v2-1-0abfb77a84b8@gmail.com>
From: Alex Deucher <alexdeucher@gmail.com>
Date: Wed, 11 Nov 2026 11:49:36 -0500
X-Gm-Features: AclHuK_GNVp6DqhleU8mNCij6RwE_xjeXa2cpadCyUXA99oBGwkzHbdnsMQTCJY
Message-ID: <CADnq5_OvGqVWG4BRi64EKO3_qEmS7VJiTuG158Og=XUPhYHJ_Q@mail.gmail.com>
Subject: Re: [PATCH v2] drm/amdgpu: use drm_gem_ttm_dumb_map_offset() for
 dumb_map_offset
To: saad <primecoder8@gmail.com>
Cc: Alex Deucher <alexander.deucher@amd.com>, 
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Reviewed and applied.  Thanks!

Alex

On Fri, Nov 6, 2026 at 4:56=E2=80=AFAM saad <primecoder8@gmail.com> wrote:
>
> As part of the DRM TODO item "Remove custom dumb_map_offset
> implementations", switch amdgpu's &drm_driver.dumb_map_offset callback
> from the driver-specific amdgpu_mode_dumb_mmap() to the generic TTM
> helper drm_gem_ttm_dumb_map_offset(), for both amdgpu_kms_driver and
> amdgpu_partition_driver.
>
> amdgpu_mode_dumb_mmap() additionally rejected userptr BOs and BOs
> created with AMDGPU_GEM_CREATE_NO_CPU_ACCESS with -EPERM. Dropping
> those checks from the dumb path does not allow such BOs to be mapped:
> returning an offset does not create a mapping, and the actual mmap()
> goes through drm_gem_mmap() -> amdgpu_gem_object_mmap(), which performs
> the same two checks and still returns -EPERM. The only user-visible
> difference is that DRM_IOCTL_MODE_MAP_DUMB on such a handle now succeeds
> and the subsequent mmap() fails, instead of the ioctl failing. Dumb
> buffers created by amdgpu_mode_dumb_create() are never userptr BOs and
> always have AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED set, so they are not
> affected.
>
> With that, amdgpu_gem_mmap_ioctl() is the only remaining user of
> amdgpu_mode_dumb_mmap(), so fold it into the ioctl and drop its
> prototype from amdgpu_gem.h. DRM_IOCTL_AMDGPU_GEM_MMAP, used by
> libdrm_amdgpu and Mesa, keeps the userptr and NO_CPU_ACCESS checks
> and behaves as before.
>
> Build-tested with CONFIG_DRM_AMDGPU=3Dm (W=3D1 for amdgpu_drv.o and
> amdgpu_gem.o), no new warnings. Not runtime tested.
>
> The code change was written by hand and reviewed with the help of
> Claude (AI coding assistant); the commit message was written by Claude.
>
> Signed-off-by: saad <primecoder8@gmail.com>
> ---
> Changes in v2:
> - Fold amdgpu_mode_dumb_mmap() into amdgpu_gem_mmap_ioctl() and drop its
>   prototype, as it has no other users (Sashiko)
> - Link to v1: https://lore.kernel.org/r/20261105-amdgpu-dumb-map-offset-v=
1-1-7299d94ede11@gmail.com
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c |  5 +++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 23 +++++++++--------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h |  3 ---
>  3 files changed, 12 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_drv.c
> index 731fe8f9e..134d2fe4b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c
> @@ -27,6 +27,7 @@
>  #include <drm/drm_drv.h>
>  #include <drm/drm_fbdev_ttm.h>
>  #include <drm/drm_gem.h>
> +#include <drm/drm_gem_ttm_helper.h>
>  #include <drm/drm_managed.h>
>  #include <drm/drm_pciids.h>
>  #include <drm/drm_probe_helper.h>
> @@ -3151,7 +3152,7 @@ static const struct drm_driver amdgpu_kms_driver =
=3D {
>         .ioctls =3D amdgpu_ioctls_kms,
>         .num_ioctls =3D ARRAY_SIZE(amdgpu_ioctls_kms),
>         .dumb_create =3D amdgpu_mode_dumb_create,
> -       .dumb_map_offset =3D amdgpu_mode_dumb_mmap,
> +       .dumb_map_offset =3D drm_gem_ttm_dumb_map_offset,
>         DRM_FBDEV_TTM_DRIVER_OPS,
>         .fops =3D &amdgpu_driver_kms_fops,
>         .release =3D &amdgpu_driver_release_kms,
> @@ -3177,7 +3178,7 @@ const struct drm_driver amdgpu_partition_driver =3D=
 {
>         .ioctls =3D amdgpu_ioctls_kms,
>         .num_ioctls =3D ARRAY_SIZE(amdgpu_ioctls_kms),
>         .dumb_create =3D amdgpu_mode_dumb_create,
> -       .dumb_map_offset =3D amdgpu_mode_dumb_mmap,
> +       .dumb_map_offset =3D drm_gem_ttm_dumb_map_offset,
>         DRM_FBDEV_TTM_DRIVER_OPS,
>         .fops =3D &amdgpu_driver_kms_fops,
>         .release =3D &amdgpu_driver_release_kms,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.c
> index 4ed1706d8..2a72bdf2d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -644,13 +644,16 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev=
, void *data,
>         return r;
>  }
>
> -int amdgpu_mode_dumb_mmap(struct drm_file *filp,
> -                         struct drm_device *dev,
> -                         uint32_t handle, uint64_t *offset_p)
> +int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
> +                         struct drm_file *filp)
>  {
> +       union drm_amdgpu_gem_mmap *args =3D data;
> +       uint32_t handle =3D args->in.handle;
>         struct drm_gem_object *gobj;
>         struct amdgpu_bo *robj;
>
> +       memset(args, 0, sizeof(*args));
> +
>         gobj =3D drm_gem_object_lookup(filp, handle);
>         if (!gobj)
>                 return -ENOENT;
> @@ -661,19 +664,11 @@ int amdgpu_mode_dumb_mmap(struct drm_file *filp,
>                 drm_gem_object_put(gobj);
>                 return -EPERM;
>         }
> -       *offset_p =3D amdgpu_bo_mmap_offset(robj);
> -       drm_gem_object_put(gobj);
> -       return 0;
> -}
>
> -int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
> -                         struct drm_file *filp)
> -{
> -       union drm_amdgpu_gem_mmap *args =3D data;
> -       uint32_t handle =3D args->in.handle;
> +       args->out.addr_ptr =3D amdgpu_bo_mmap_offset(robj);
> +       drm_gem_object_put(gobj);
>
> -       memset(args, 0, sizeof(*args));
> -       return amdgpu_mode_dumb_mmap(filp, dev, handle, &args->out.addr_p=
tr);
> +       return 0;
>  }
>
>  /**
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/am=
d/amdgpu/amdgpu_gem.h
> index b558336bc..718ffe229 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> @@ -49,9 +49,6 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev=
, unsigned long size,
>  int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>                             struct drm_device *dev,
>                             struct drm_mode_create_dumb *args);
> -int amdgpu_mode_dumb_mmap(struct drm_file *filp,
> -                         struct drm_device *dev,
> -                         uint32_t handle, uint64_t *offset_p);
>
>  int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
>                             struct drm_file *filp);
>
> ---
> base-commit: 279235273fc6c0a33df863b4a1cc52ec1e73aba5
> change-id: 20261105-amdgpu-dumb-map-offset-6fa41e8d3fb5
>
> Best regards,
> --
> saad <primecoder8@gmail.com>
>
