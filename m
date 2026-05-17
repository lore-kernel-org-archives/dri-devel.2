Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD06FCD4F3C
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 20:02:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D81F610E037;
	Sun, 17 May 2026 20:02:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dtAzgp2l";
	dkim-atps=neutral
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com
 [209.85.208.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 503EF10E037
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 20:02:30 +0000 (UTC)
Received: by mail-lj1-f179.google.com with SMTP id
 38308e7fff4ca-38e7c3a2deaso15616571fa.2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 13:02:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779048148; cv=none;
 d=google.com; s=arc-20240605;
 b=BRdqGuLR1rHJ9LlefN4x6CQRdBAiGlXBkzCH86CaUhX3PGr0SD4Y33xK2uM4sdaH31
 LHJp66N8RLhr7FbHnOkb8TAJXEVWq7i4YI7/jlVDF2goP6Sor8YbjNFqdlAGkXlKb48I
 8uDLePaNEpJBsIRrM8QwuehrASX/C1irDLTvyMaCbemNCb7Fk5DOkn5gEDjAOh85lsq4
 Ru9nscB4Gyk1+GiTzDpMrNbbL4d7Z3NHSgMpp50Km9nM9t4aHf7JqFo4bbvR8C3jvROf
 OfNosp9oF21okIMQ6oeo8YbufW6NcEhufyYA07x2w5QBunfsIGN5GG91wbKFZcRrhPBl
 2MjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Nlr2qnovcb3Be3djUSZsGiNTerFiMk2kk6Bag5mm8cQ=;
 fh=UVv3NT27pVNQVTWBj8zg+hD2rSUG2tlE0wAovHGZnFI=;
 b=aowOHhQiPLhLLp+QRn/S2ZagZVTQmfbGQo3HdswXxr6nWw7jecpOrVipdze3A/yEJe
 bwl+hmcsSwjInbLyt+9nzELtCY93+6ST/hKCL5D5juW8mbytW6azsjDSdvHvehFDVNtC
 s/2nNmpGtDTViLVv1q1ZvmWisf1B0BgVYgw/woCZ9bdux1t4wmq/ulq9qTUVb1NFnnIT
 YUM1RmBmAbsjYRngtvOgWsi20UV7rN3qNinYFrKS4CFoIYTbWCkj7GKPnsgWW6igusLI
 X2YFh3DJh/KPOkVV4zgkWGo2iduLWYSK7pl/2Yd1A7C/4X0AvFSjGuLoUFKEtBi0/FkB
 fQiQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779048148; x=1779652948; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Nlr2qnovcb3Be3djUSZsGiNTerFiMk2kk6Bag5mm8cQ=;
 b=dtAzgp2lIwNdD03V0na39JpC2AyYDFVBSpyrnrLd77/Z43c/JRw+D60EozO4CdSv7h
 R0TghfZAK8IB0AEP6vDlEVT48H/m0Tk/Dz7CsIzsP5CEaAU4VexOdRVUBVlBAgVY9oZs
 mCb+22tGf+ohCsXzvvX6dxc11ETKerz6neJIIz5Npeh8vaz80/raOX7ALPUfbad4bNnn
 +XLhTKjIqi0wPPU3KZYmNU87MF4w2WW/rgDZm+EhWt1TtfgycvYUtIBxG5kMBrgUUS7a
 5oF9fO4ddywPc3z+B2WuUIx23+6kOvAiU6Xl+CXUPcEsZjY/3HrQNPAPO3OeffR/+t1m
 jH6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779048148; x=1779652948;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Nlr2qnovcb3Be3djUSZsGiNTerFiMk2kk6Bag5mm8cQ=;
 b=Ykn1zBxWsHPfGEUIIbV/OMiG48sz/N0Glt+tC3qVxbQuN2nQqn4HxzVGIKb1lDidtW
 q9nrnbTJUo9sP1wTmOswwI5Rv0P3nb9KFya2RCGTTCsO/yNEsmaf9O9G9DEs4nD+48pH
 Qo9fKumzagbuG3Qn2va6cm77w2cfoF6zItvGVHdL2D5zGyI/i1UOMm7CZRLdeyOoM2Ke
 xQ681rBoL8KjRQhjTAaNVO5TpiGUM3lpl4zPCcu8GwLin0VOb3EJ6RLO56lx/VgpGM+7
 OgitkaiJg9Lojf5sgsDS1jF11p0LXDP2xZFu+B2aV7GsgGdpp8B1BxGJEtbw9kFnv1TY
 Geww==
X-Forwarded-Encrypted: i=1;
 AFNElJ+JasfN3Aw5gRszYRTjAQ0Yx3Komiqavm9cKN0R8/EYYm0f4Zf49nHnjzclYRoLNAX6XUOiP8o4OqY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzylYXyh+xnPbHCmCbGdiXoFMMgHQqxlshvw0MjkVHb7i2a8qQR
 ETgck9vTEvlFuh9tNRCVZLBmrRds9/W/SayCgCiY0HWFeOOSMAR/KMyIrILnIHMdi1l2ZRoyfP/
 02utSJTcx1wPkOsBeUtd8O/cD225bjLY=
X-Gm-Gg: Acq92OFgr37uVfLr++x49SVKxKOphIUd3Qpv62T5M8cYQrlHpIodwhipU+VX0IEfCnT
 UutIesPMTuQ6bVgDklZjDPAeEA3TsElZqPyA9+AlwvBouftjp9mdL2GSTc8aRo0PR1Ttp0fqUWa
 HY396L1HqJRMT2EeGEgA8xLqxP8D1YqhfGYYanPMThDSwHCh7E9OmrffCAJkPipEIwIAX6aTFLN
 YxKF86ybygLB3rNuqt5AppIXNVYFWU5L9uHsrKsU+2c9AgGJV+u7vr/srL7q6XqoU6LPQfRJR5l
 OikX8ZeGzkanjkDbZdoluj5+ihUVVazNjUdJLpa8G1XOdHeHq2JWMZ62AH7k3GYFMbXY
X-Received: by 2002:a2e:9ec1:0:b0:393:903c:2258 with SMTP id
 38308e7fff4ca-39561c3d930mr25204241fa.16.1779048148159; Sun, 17 May 2026
 13:02:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260515-host1x-bocache-leak-v1-0-a0375f68aeab@nvidia.com>
 <20260515-host1x-bocache-leak-v1-1-a0375f68aeab@nvidia.com>
In-Reply-To: <20260515-host1x-bocache-leak-v1-1-a0375f68aeab@nvidia.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Sun, 17 May 2026 15:02:16 -0500
X-Gm-Features: AVHnY4JnVJM3r5xSc7l2rPlheXstiTlhDqt50QsQvQZlFCWPse_PuhNA6GF9D0Q
Message-ID: <CALHNRZ8-UKV1aVf6z_8uKOQ5eP1aP_7SEVJAtQ0fvCuAybb37Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpu: host1x: Allow entries in BO caches to be freed
To: Mikko Perttunen <mperttunen@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Akhil R <akhilrajeev@nvidia.com>, 
 Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>, 
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Thu, May 14, 2026 at 9:35=E2=80=AFPM Mikko Perttunen <mperttunen@nvidia.=
com> wrote:
>
> When a buffer object is pinned via host1x_bo_pin() with a cache, the
> resulting mapping is kept in the cache so it can be reused on subsequent
> pins. Each mapping held a reference to the underlying host1x_bo (taken
> in tegra_bo_pin / gather_bo_pin), so as long as a mapping was cached,
> the bo itself could not be freed.
>
> However, the only way to remove the cached mapping was through the free
> path of the buffer object. This meant that if a bo got cached, it could
> never get freed again.
>
> Resolve the circularity by holding a weak reference to the bo from the
> cache side. This is done by having the .pin callbacks not bump the bo's
> refcount -- instead the common Host1x bo code does so, except for the
> cache reference.
>
> Also move the remove-cache-mapping-on-free code into a common function
> inside Host1x code. This is only called from the TegraDRM GEM buffers
> since those are the only ones that can be cached at the moment.
>
> Reported-by: Aaron Kling <webgeek1234@gmail.com>
> Fixes: 1f39b1dfa53c ("drm/tegra: Implement buffer object cache")
> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
> ---
>  drivers/gpu/drm/tegra/gem.c    | 13 ++-------
>  drivers/gpu/drm/tegra/submit.c |  3 +--
>  drivers/gpu/host1x/bus.c       | 60 ++++++++++++++++++++++++++++++++++++=
+++++-
>  include/linux/host1x.h         |  7 +++++
>  4 files changed, 69 insertions(+), 14 deletions(-)
>
> diff --git a/drivers/gpu/drm/tegra/gem.c b/drivers/gpu/drm/tegra/gem.c
> index d2bae88ad545..2377e2b76397 100644
> --- a/drivers/gpu/drm/tegra/gem.c
> +++ b/drivers/gpu/drm/tegra/gem.c
> @@ -69,7 +69,7 @@ static struct host1x_bo_mapping *tegra_bo_pin(struct de=
vice *dev, struct host1x_
>                 return ERR_PTR(-ENOMEM);
>
>         kref_init(&map->ref);
> -       map->bo =3D host1x_bo_get(bo);
> +       map->bo =3D bo;
>         map->direction =3D direction;
>         map->dev =3D dev;
>
> @@ -170,7 +170,6 @@ static void tegra_bo_unpin(struct host1x_bo_mapping *=
map)
>                 kfree(map->sgt);
>         }
>
> -       host1x_bo_put(map->bo);
>         kfree(map);
>  }
>
> @@ -509,17 +508,9 @@ static struct tegra_bo *tegra_bo_import(struct drm_d=
evice *drm,
>  void tegra_bo_free_object(struct drm_gem_object *gem)
>  {
>         struct tegra_drm *tegra =3D gem->dev->dev_private;
> -       struct host1x_bo_mapping *mapping, *tmp;
>         struct tegra_bo *bo =3D to_tegra_bo(gem);
>
> -       /* remove all mappings of this buffer object from any caches */
> -       list_for_each_entry_safe(mapping, tmp, &bo->base.mappings, list) =
{
> -               if (mapping->cache)
> -                       host1x_bo_unpin(mapping);
> -               else
> -                       dev_err(gem->dev->dev, "mapping %p stale for devi=
ce %s\n", mapping,
> -                               dev_name(mapping->dev));
> -       }
> +       host1x_bo_clear_cached_mappings(&bo->base);
>
>         if (tegra->domain) {
>                 tegra_bo_iommu_unmap(tegra, bo);
> diff --git a/drivers/gpu/drm/tegra/submit.c b/drivers/gpu/drm/tegra/submi=
t.c
> index 3009b8b9e619..e5841857c937 100644
> --- a/drivers/gpu/drm/tegra/submit.c
> +++ b/drivers/gpu/drm/tegra/submit.c
> @@ -76,7 +76,7 @@ gather_bo_pin(struct device *dev, struct host1x_bo *bo,=
 enum dma_data_direction
>                 return ERR_PTR(-ENOMEM);
>
>         kref_init(&map->ref);
> -       map->bo =3D host1x_bo_get(bo);
> +       map->bo =3D bo;
>         map->direction =3D direction;
>         map->dev =3D dev;
>
> @@ -117,7 +117,6 @@ static void gather_bo_unpin(struct host1x_bo_mapping =
*map)
>         dma_unmap_sgtable(map->dev, map->sgt, map->direction, 0);
>         sg_free_table(map->sgt);
>         kfree(map->sgt);
> -       host1x_bo_put(map->bo);
>
>         kfree(map);
>  }
> diff --git a/drivers/gpu/host1x/bus.c b/drivers/gpu/host1x/bus.c
> index f814eb4941c0..772e05a7b45b 100644
> --- a/drivers/gpu/host1x/bus.c
> +++ b/drivers/gpu/host1x/bus.c
> @@ -887,6 +887,20 @@ int host1x_client_resume(struct host1x_client *clien=
t)
>  }
>  EXPORT_SYMBOL(host1x_client_resume);
>
> +/**
> + * host1x_bo_pin() - Create a DMA mapping for the buffer object
> + * @dev: Device onto which DMA map to
> + * @bo: Buffer object to map
> + * @dir: DMA direction
> + * @cache: Cache in which to store mapping, or NULL
> + *
> + * Creates a DMA mapping pointing to @bo for @dev. The refcount of @bo i=
s incremented
> + * until host1x_bo_unpin is called.
> + *
> + * If @cache is specified, the mapping is also stored in the cache and n=
ot released
> + * until @bo is freed (refcount drops to zero). This improves performanc=
e when a buffer
> + * is pinned and unpinned frequently as in the case of display use.
> + */
>  struct host1x_bo_mapping *host1x_bo_pin(struct device *dev, struct host1=
x_bo *bo,
>                                         enum dma_data_direction dir,
>                                         struct host1x_bo_cache *cache)
> @@ -899,6 +913,7 @@ struct host1x_bo_mapping *host1x_bo_pin(struct device=
 *dev, struct host1x_bo *bo
>                 list_for_each_entry(mapping, &cache->mappings, entry) {
>                         if (mapping->bo =3D=3D bo && mapping->direction =
=3D=3D dir) {
>                                 kref_get(&mapping->ref);
> +                               host1x_bo_get(bo);
>                                 goto unlock;
>                         }
>                 }
> @@ -908,6 +923,8 @@ struct host1x_bo_mapping *host1x_bo_pin(struct device=
 *dev, struct host1x_bo *bo
>         if (IS_ERR(mapping))
>                 goto unlock;
>
> +       host1x_bo_get(bo);
> +
>         spin_lock(&mapping->bo->lock);
>         list_add_tail(&mapping->list, &bo->mappings);
>         spin_unlock(&mapping->bo->lock);
> @@ -918,7 +935,12 @@ struct host1x_bo_mapping *host1x_bo_pin(struct devic=
e *dev, struct host1x_bo *bo
>
>                 list_add_tail(&mapping->entry, &cache->mappings);
>
> -               /* bump reference count to track the copy in the cache */
> +               /*
> +                * Bump the mapping reference count to track the mapping =
in the cache,
> +                * but do not bump the BO's refcount. This allows the BO =
to still get freed,
> +                * triggering the release of the cache mapping through
> +                * host1x_bo_clear_cached_mappings.
> +                */
>                 kref_get(&mapping->ref);
>         }
>
> @@ -948,9 +970,17 @@ static void __host1x_bo_unpin(struct kref *ref)
>         mapping->bo->ops->unpin(mapping);
>  }
>
> +/**
> + * host1x_bo_unpin() - Release an established DMA mapping of a buffer ob=
ject
> + * @mapping: Mapping to release
> + *
> + * Unmaps the given @mapping, unless it is cached. Decreases the refcoun=
t on
> + * the underlying buffer object.
> + */
>  void host1x_bo_unpin(struct host1x_bo_mapping *mapping)
>  {
>         struct host1x_bo_cache *cache =3D mapping->cache;
> +       struct host1x_bo *bo =3D mapping->bo;
>
>         if (cache)
>                 mutex_lock(&cache->lock);
> @@ -959,5 +989,33 @@ void host1x_bo_unpin(struct host1x_bo_mapping *mappi=
ng)
>
>         if (cache)
>                 mutex_unlock(&cache->lock);
> +
> +       host1x_bo_put(bo);
>  }
>  EXPORT_SYMBOL(host1x_bo_unpin);
> +
> +/**
> + * host1x_bo_clear_cached_mappings() - Remove all cached mappings pointi=
ng at a bo
> + * @bo: Buffer object to release mappings of
> + *
> + * Drops references to any mappings pointing to @bo left in any caches. =
This must
> + * be called by any host1x_bo implementers that may be pinned with cachi=
ng enabled
> + * before freeing the bo.
> + */
> +void host1x_bo_clear_cached_mappings(struct host1x_bo *bo)
> +{
> +       struct host1x_bo_mapping *mapping, *tmp;
> +       struct host1x_bo_cache *cache;
> +
> +       list_for_each_entry_safe(mapping, tmp, &bo->mappings, list) {
> +               cache =3D mapping->cache;
> +               if (WARN_ON(!cache))
> +                       continue;
> +
> +               mutex_lock(&mapping->cache->lock);
> +               WARN_ON(kref_read(&mapping->ref) !=3D 1);
> +               __host1x_bo_unpin(&mapping->ref);
> +               mutex_unlock(&mapping->cache->lock);
> +       }
> +}
> +EXPORT_SYMBOL(host1x_bo_clear_cached_mappings);
> diff --git a/include/linux/host1x.h b/include/linux/host1x.h
> index 5e7a63143a4a..d8f052a85b75 100644
> --- a/include/linux/host1x.h
> +++ b/include/linux/host1x.h
> @@ -143,6 +143,12 @@ static inline struct host1x_bo_mapping *to_host1x_bo=
_mapping(struct kref *ref)
>         return container_of(ref, struct host1x_bo_mapping, ref);
>  }
>
> +/**
> + * struct host1x_bo_ops - operations implemented by a host1x_bo provider
> + *
> + * @pin: create a DMA mapping. Implementation must not touch the bo's re=
fcount.
> + * @unpin: destroy a DMA mapping. Implementation must not touch the bo's=
 refcount.
> + */
>  struct host1x_bo_ops {
>         struct host1x_bo *(*get)(struct host1x_bo *bo);
>         void (*put)(struct host1x_bo *bo);
> @@ -181,6 +187,7 @@ struct host1x_bo_mapping *host1x_bo_pin(struct device=
 *dev, struct host1x_bo *bo
>                                         enum dma_data_direction dir,
>                                         struct host1x_bo_cache *cache);
>  void host1x_bo_unpin(struct host1x_bo_mapping *map);
> +void host1x_bo_clear_cached_mappings(struct host1x_bo *bo);
>
>  static inline void *host1x_bo_mmap(struct host1x_bo *bo)
>  {
>
> --
> 2.53.0
>

I have verified this on a Jetson AGX Xavier devkit, a Jetson Xavier NX
devkit, a Jetson TX2 devkit, and a Jetson TX2 NX in a p3509 carrier.
No longer seeing allocation failures nor am I seeing any obvious
regressions. I am currently unable to boot any t210 device to Android
userspace to verify those for various preexisting reasons, and Android
recovery does not reallocate buffers to stress this issue.

Tested-by: Aaron Kling <webgeek1234@gmail.com>

Aaron
