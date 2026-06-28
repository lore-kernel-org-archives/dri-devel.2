Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BE0DC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:07:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D2BDF10E6F1;
	Mon, 29 Jun 2026 07:07:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="em954CgF";
	dkim-atps=neutral
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com
 [209.85.160.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB9FF10E62F
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 15:46:35 +0000 (UTC)
Received: by mail-oa1-f41.google.com with SMTP id
 586e51a60fabf-44856d185bcso757863fac.3
 for <dri-devel@lists.freedesktop.org>; Sun, 28 Jun 2026 08:46:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782661595; cv=none;
 d=google.com; s=arc-20260327;
 b=aAtY8XcKQMVNmUfvmzXdz8n6mxGkjKz2X9ddtiKdRzmKwO+D+qRAqDVMqb6d7FC5ii
 2vAUZngbGuBITzwwkrukGJ/USCVk2amgoUd7MXr5NVETrb7QKovSkg2X4w6r2xTDGmM6
 JheX9j4PQdgy+coKvXBeiPYEobX4LoXdY4x25ecuCryeyh/G8TYABTmgsZ+VsCl98uTr
 /9+ghlIgoRE/6Ice0ia0GbgsvmlaJj//WDLmFNJPh8NMbppPiO5VonBmjsl2B10Md+g+
 IqBWngvVzztYAHcJfQlr54GZme4OAI6PPwZxaylivR6r6xoTgkiCkzrPucPEZeWcrPFO
 SE7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TwK/D+sxvlgb/lYLKarrnyvpZOyu6UoNhP89AnfQs5Y=;
 fh=HOjZ+MVT2QnpLsevz1kQ8fPu0Fc6l4vWJvH03BoCaTs=;
 b=n/DPGMoLfXRDMoTZflxDhUKHqVJ8lKAIFCdJRr+xSX/wMPFHRFcGawQ+70XqUsB/li
 SSpJEi/JcaiZWRcfPvqYQB6JfeglVJUVdpYT4VMuaFsSMx9v9qq8dqQaM2BbeUulK575
 4CP2UoXVXmT8Uzl8wfS6x6Ruz4HyHY+OiCf1LFyUl9JyNGWxLTV96mu5hOvYEfygdj0G
 c1xPvCw33fc8YmqckM9WHzNpFhNCC/lkZppTVKdq2t7we6dTnvohClaYkJ5nVDK557rQ
 zRXGBeA/imqm2IlnuIDUKiuQGH58z1bMo1H0z5zXX0LKDz8GZlDTuGjNZiaVunrwXwe7
 MMJA==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782661595; x=1783266395; darn=lists.freedesktop.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TwK/D+sxvlgb/lYLKarrnyvpZOyu6UoNhP89AnfQs5Y=;
 b=em954CgFQWl+Tj7Ym8B9DUxWN1uO/YT8+d+9upODwKdufj7DR18NrTPQxgl2jIB/wV
 o7Lnq5bD09nkibtxHff82VbfVUOPtnQepqvkGM8tUNdKKxd3rbIFEtbkjv7FXVPAbZ+O
 qNE+zbClbo1iHZ6daZij+I2OKTfVpaMlts3hUzGcgNl6ps5QJ6RCl9lK8w69sGIFP/mX
 X7R9cj3Byyp1+vnkOLSNU37HlBrl7ZVytk1EbPhe51HtbSNeFb6Vad35uhqleJxdLVp9
 bDt+TxwfuM+/HcolY5jnpAW84BzdPrKRgO9bBMw5IwEfrstKZMKqyGAjZ5/ZmVL4g4eK
 /BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782661595; x=1783266395;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TwK/D+sxvlgb/lYLKarrnyvpZOyu6UoNhP89AnfQs5Y=;
 b=lN/eH0JVTKv+RuF6e2THuSn7S7GQx1Hjg0+svrik832x9IPBUKtKeep+OAeBGysQhl
 XohphjygoBBxA//9mocG6UrTpAmCgID0lr3fnTdZ6TFHz+9HTssmyqcramUUoOuEwqEa
 n4JH+fs0jHph8gdOnMHQgu4tVJaM+BQiv9vLYb7vtGTBeHuNepacCS/bu34dm4IGhgQs
 qrnRFYcOr7buoDAnu0r46sz+8pAoImtKz58qEEpKhfb2mLetBCfRztmm+nTL+oSg24ix
 P761X2DTPG+XCu/LWXQNFafWz2VdneWkN5R3iQnQ6dPcb8aRwgepHTcRrG4s7ZzB/bKs
 BxBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpddeHHrVw+aJOCqq+N3ImEeFu1AxVojor4RKPL/uU0wsUQMOGLfFG5+hXWBtPO9LCUJlcygMUh76o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxCeWNrSg9T5VEAiqsu4uGWYuPKHiwZjE58WtqjJqeTDUPzgJWX
 /B/qhtnIRTGPFEjCgqOxC1KPFRbVTc1BQQjFvVNpSOkNIZVIO4sy6mfARow7tcfZoVkh49gWnFb
 EIlcWHmL9fOqOeK7S0A4dW3hKCpzvQHQ=
X-Gm-Gg: AfdE7cl7hQqCWCCedKZj0aeiRia5sug8plm/SAFLyNImWoihbVhZghkO/AjgWptJh2t
 1xnVt8dzIkkpHhGWgW3o/QOpMNi8P9Up4+5+48Ip7oMU63zLx+8VNf0k4EbwggTuA/F032enVZY
 fswWywkwqoXUsNmSNNDQoCAdoEcHQnggzJnRXv2D1aVNrFGM6zeswixQI1+ITz8LZ9EdkcEbySn
 0KQ7dPeQycrSb1s6XlMjz0C06R4nyYULw50jOYmDIAgw5YZ5craORsWzapRmKQbAAon4RhmWe+e
 rVkz7pxd41kyVaL0uEzkNHNev3pTlp4gTUN0
X-Received: by 2002:a05:6870:658e:b0:448:5591:15d9 with SMTP id
 586e51a60fabf-448559126f7mr4849762fac.37.1782661594757; Sun, 28 Jun 2026
 08:46:34 -0700 (PDT)
MIME-Version: 1.0
References: <20260628154051.232214-1-megia.oscar@gmail.com>
In-Reply-To: <20260628154051.232214-1-megia.oscar@gmail.com>
From: David Kahurani <k.kahurani@gmail.com>
Date: Sun, 28 Jun 2026 18:46:23 +0300
X-Gm-Features: AVVi8CeTf6DizADkLm61AypxDKstCAaBxgLYQTdLkrxOaMXxh3_00Jp7bzgcmN8
Message-ID: <CAAZOf24EO8Aiu=nOzzKCPBzgwvJ+Kw=PaWNyOPP4L1A8PfduMg@mail.gmail.com>
Subject: Re: [PATCH v2] Memory leak error in qxl unbind
To: =?UTF-8?B?w5NzY2FyIE1lZ8OtYSBMw7NwZXo=?= <megia.oscar@gmail.com>
Cc: Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 dri-devel@lists.freedesktop.org, linux-kernel-mentees@lists.linux.dev, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Mailman-Approved-At: Mon, 29 Jun 2026 07:07:39 +0000
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

On Sun, Jun 28, 2026 at 6:41=E2=80=AFPM =C3=93scar Meg=C3=ADa L=C3=B3pez <m=
egia.oscar@gmail.com> wrote:
>
> I discovered OOM after run script below around two hours in my computer:
>
> while :; do
>     echo [pci qxl id] > /sys/bus/pci/drivers/qxl/unbind
>     echo [pci qxl id] > /sys/bus/pci/drivers/qxl/bind
> done
>
> If you run 10000 times above script kmemleak does not report any
> memory leak, but if you run above script about two hours several
> OOM ocurs and at the end kernel panic.
>
> The OOM isn't just a simple leak; it's a refcount corruption that renders
> the list_lru fix dead code after the first mid-init failure.
>
> Here's the chain:
>
> Bug 1: ttm_global_init ignores ttm_pool_mgr_init() return
> If shrinker_alloc() fails under memory pressure, ttm_pool_mgr_init
> returns -ENOMEM with pool types already initialized (64 list_lru_init
> calls done). ttm_global_init ignored this and returned 0, leaving orphane=
d
> pool types with a NULL mm_shrinker.
>
> Fix: Check ret from ttm_pool_mgr_init; if non-zero, goto out cleans up
> refcount + debugfs.
>
> Bug 2: ttm_pool_mgr_init leaks pool types on shrinker_alloc failure
> If shrinker_alloc fails after all 64 pool types were list_lru_init'd,
> the function returned -ENOMEM without undoing them. With Bug 1 now
> triggering proper error handling, this undo is necessary.
>
> Fix: err_shrinker: label that finalizes + destroys all 64 pool types
> before returning.
>
> You must apply the patch from the link "[PATCH v2] drm/qxl: fix
> use-after-free to qxl_irq_handler in PCI mode" before testing.
> If you don't apply this patch, you will get a UAF error when running
> the script above.
>
> Assisted-by: OpenCode:1.17.8-Big Pickle
> Link: https://lore.kernel.org/virtualization/20260627105445.89827-2-megia=
.oscar@gmail.com/T/#u
> Signed-off-by: =C3=93scar Meg=C3=ADa L=C3=B3pez <megia.oscar@gmail.com>
> ---
>  drivers/gpu/drm/ttm/ttm_device.c |  5 ++++-
>  drivers/gpu/drm/ttm/ttm_pool.c   | 37 ++++++++++++++++++++++++++------
>  include/drm/ttm/ttm_pool.h       |  2 ++
>  3 files changed, 37 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/gpu/drm/ttm/ttm_device.c b/drivers/gpu/drm/ttm/ttm_d=
evice.c
> index d3bfb9a696a7..c880a0430363 100644
> --- a/drivers/gpu/drm/ttm/ttm_device.c
> +++ b/drivers/gpu/drm/ttm/ttm_device.c
> @@ -96,7 +96,10 @@ static int ttm_global_init(void)
>                 >> PAGE_SHIFT;
>         num_dma32 =3D min(num_dma32, 2UL << (30 - PAGE_SHIFT));
>
> -       ttm_pool_mgr_init(num_pages);
> +       ret =3D ttm_pool_mgr_init(num_pages);
> +       if (ret)
> +               goto out;
> +
>         ttm_tt_mgr_init(num_pages, num_dma32);
>
>         glob->dummy_read_page =3D alloc_page(__GFP_ZERO | GFP_DMA32 |
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_poo=
l.c
> index 278bbe7a11ad..e0c82804a07d 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -1198,6 +1198,17 @@ void ttm_pool_fini(struct ttm_pool *pool)
>          * that no shrinker is concurrently freeing pages from the pool.
>          */
>         ttm_pool_synchronize_shrinkers();
> +
> +       for (i =3D 0; i < TTM_NUM_CACHING_TYPES; ++i) {
> +               for (j =3D 0; j < NR_PAGE_ORDERS; ++j) {
> +                       struct ttm_pool_type *pt;
> +
> +                       pt =3D ttm_pool_select_type(pool, i, j);
> +                       if (pt !=3D &pool->caching[i].orders[j])
> +                               continue;
> +                       list_lru_destroy(&pt->pages);
> +               }
> +       }
>  }
>  EXPORT_SYMBOL(ttm_pool_fini);
>
> @@ -1386,6 +1397,7 @@ static inline u64 ttm_get_node_memory_size(int nid)
>  int ttm_pool_mgr_init(unsigned long num_pages)
>  {
>         unsigned int i;
> +       int ret =3D 0;
>
>         int nid;
>         for_each_node(nid) {
> @@ -1423,8 +1435,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>  #endif
>
>         mm_shrinker =3D shrinker_alloc(SHRINKER_NUMA_AWARE, "drm-ttm_pool=
");
> -       if (!mm_shrinker)
> -               return -ENOMEM;
> +       if (!mm_shrinker) {
> +               ret =3D -ENOMEM;
> +               goto err_shrinker;
> +       }
>
>         mm_shrinker->count_objects =3D ttm_pool_shrinker_count;
>         mm_shrinker->scan_objects =3D ttm_pool_shrinker_scan;
> @@ -1434,6 +1448,10 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>         shrinker_register(mm_shrinker);
>
>         return 0;
> +
> +err_shrinker:
> +       ttm_pool_type_fini_and_list_lru_destroy();
> +       return ret;
>  }
>
>  /**
> @@ -1442,17 +1460,24 @@ int ttm_pool_mgr_init(unsigned long num_pages)
>   * Cleanup the global pools and unregister the MM shrinker.
>   */
>  void ttm_pool_mgr_fini(void)
> +{
> +       shrinker_free(mm_shrinker);
> +       ttm_pool_type_fini_and_list_lru_destroy();
> +       WARN_ON(!list_empty(&shrinker_list));
> +}
> +
> +void ttm_pool_type_fini_and_list_lru_destroy(void)
>  {
>         unsigned int i;
>
>         for (i =3D 0; i < NR_PAGE_ORDERS; ++i) {
>                 ttm_pool_type_fini(&global_write_combined[i]);
> +               list_lru_destroy(&global_write_combined[i].pages);
>                 ttm_pool_type_fini(&global_uncached[i]);
> -
> +               list_lru_destroy(&global_uncached[i].pages);
>                 ttm_pool_type_fini(&global_dma32_write_combined[i]);
> +               list_lru_destroy(&global_dma32_write_combined[i].pages);
>                 ttm_pool_type_fini(&global_dma32_uncached[i]);
> +               list_lru_destroy(&global_dma32_uncached[i].pages);
>         }
> -
> -       shrinker_free(mm_shrinker);
> -       WARN_ON(!list_empty(&shrinker_list));
>  }
> diff --git a/include/drm/ttm/ttm_pool.h b/include/drm/ttm/ttm_pool.h
> index 26ee592e1994..bda8e816a206 100644
> --- a/include/drm/ttm/ttm_pool.h
> +++ b/include/drm/ttm/ttm_pool.h
> @@ -97,4 +97,6 @@ int ttm_pool_restore_and_alloc(struct ttm_pool *pool, s=
truct ttm_tt *tt,
>  int ttm_pool_mgr_init(unsigned long num_pages);
>  void ttm_pool_mgr_fini(void);
>
> +void ttm_pool_type_fini_and_list_lru_destroy(void);
> +
>  #endif
> --
> 2.54.0
>
>

This bug is specific so Qemu, so...
