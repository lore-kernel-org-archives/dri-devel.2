Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE15C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 23:49:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5EE5C10EA13;
	Wed,  8 Jul 2026 23:49:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="bpip4e72";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 093DC10E3EA
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 23:49:47 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493b8d92a4eso10935e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 08 Jul 2026 16:49:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783554585; cv=none;
 d=google.com; s=arc-20260327;
 b=oF96Fpa3/ypDJ42s3s84cGt0cHfkLbAIdnH4Qo3TMxgdrUOIZ9qDkw5yYDXt6y+jyP
 7ED7q46pN9yaQy1MM6vHFal6SplT7S3RsRBoI8obLo3UZgEdWLS+nwm7gJP1I7g9l02Z
 4ATRNXkTIjGRJ4k4BeIkXIR9WjsMcnsmhc3SzcQ9aB2+Z6lP1tk4Hl7wIjiAj30eYnUi
 FBokBfXwRm41VcVMcLJZVDAeJJqHQwANMFpKlOaaViVFgJ13j2GIHk3oFYON4qTrmKce
 ORc/kqrrkD+i/iVEMDjx7sxiOgyEMxG/RZfcn7siXojogI4eC7BlFBiAfCHXwkLF3g18
 cPDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=rib4ibu+dts9p9/XbnX7ZcTmfXYVT7n2/w0qnalOJkU=;
 fh=SgEdHSfHUF/ftT4I6IYYPvRgoMXXlSNpqMsfjSSW6Hw=;
 b=Iy5nsPJIGFjdX/jXSgOhjXtcXkQ4FWF6aB2Xeqx/lA3DGHmhOUgLNVMtqha5pU5DOY
 UBeD1/zbnqYovgDS1CMtGv4VwqHOiqgTF3chzfrFPcX3i5bxgLW38wuo8TYgZAmg2RST
 T1Xsfst6fFZnASEOTBf8D+DdOr6/jaXTEBZSOWUspiS9YgJ12BDvwikfvr/1baslqq8c
 BFh5+dNY58WTSNq7aUGJM6UMPjsjRgMYnAuLbunzTWD4IEKkf6vsc38J6BtW9irulXiP
 EZsmZfwEUcH1Qv+N5iLiGGRukaKeb+byg6DB5/ITFcZ9nah9Px3I2vgiCqi33JoHFN60
 TIAg==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1783554585; x=1784159385;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=rib4ibu+dts9p9/XbnX7ZcTmfXYVT7n2/w0qnalOJkU=;
 b=bpip4e72x9+yINN4MQEkr5tawB7wWM5Sxqz0GL1mxPDYrmINVyp7ryoXQueOx5bZY4
 fxIVzMI6gikIU4MeVqYrdcaqFDcDyR4LYj/gGcb6VjZGiCngBA1NfPuLypxzBaWV59iC
 gKRsQINYjLGpb8B2ZLrJl/dLKv5h6olDbaMHokoeSwEkGnLg3kRQDHHI8naz0argiZVm
 Ctu/iVFiRqoyggf92V6m7eYy8oWGZXyjd3uxyuiJldqc608dCoq4THzMTxGn1l49UkJD
 jCTJE0iEx0YZ9Dq7f1wO5mE8si0KrBUSpHFxkUQQSR3JmnJ3LbMlrBCm5U1xxBTzGMG1
 P+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783554585; x=1784159385;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rib4ibu+dts9p9/XbnX7ZcTmfXYVT7n2/w0qnalOJkU=;
 b=lu+ZMWGt3wnnfgNgjWxPCQOfHeTanmdK2mKglEwhBY2bWA2YmlQeOMzGBLUx19fYTa
 ArfNQejm409r6f7oMuJWX5RWgoOFgdToQOyMNi3OeD3iWdlTuA2I5/anwSNw1SHeW8KD
 nbW+/iOF9xfBXVEnvpui+qIxIrOqSdE19vBoeM9KdITpWxtwqvbZVl0d/MVFT7ygLOaf
 OONe7tsr9J3LOuaQUVs5has6AobZ8EfsvhFIHX9QAjKr4Q4BId9w9e3wqnXRA+ffO5ZN
 9WziSTMhcWm8SovWWDKBn2dawOpJ9jldJERKAEvPuZTNGZptcq9aSYNlB0KxAVfrBvZY
 jkQA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlRC5qHJPC6WgqEh5XPWQymPKAeA09vlpBBgvbpBH+MS7dEfgvAbRNAaGdZ9xZIdKayVeJ5yjY9pU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyD6+jTTFjXu7GDgH88MFbVtGjDCydLlMJZ4+ahDrdd/bSP3Rb9
 e9XV5nreGVi1OAakcSjLfrsW/n6H8iE7fWu2FFdzE9sDJQStaJy/3wB4WLGlq9iT/LW10Krw4Du
 Z/LwpPOusl0VyaHDs12ZraYqGamutpEnzYK68b22O
X-Gm-Gg: AfdE7cls+vubI0gjWrq3a23I4dRHbYP0fh3fM1Ir+tJzM/x27WcAVsCOuzaIU4ZPSy7
 0WVbGVWm2eVcEfgNmVQmVDwyaHvlAPrrK96/LEhNz27uJswaxR420c8h5R3jL83zSlwCRuag5i/
 qUQ7eShYv2n3Kr654fmYXvG03oK5D2Fh8ci3qiKDG66arKKcwexxEvPlHUUeOi9jP6CL6H4hBdc
 thL1rDxE7sqPXOqU/tmlMfQCXwKKF7Klkukrw29iZcwbBYOBOZbxWXQdC0MEDnzK4CHn/RzZpKl
 POOIy3Tf9AW3OLt8jeE+dG9BIoO9P4n+Z+NxNICwUNaLZ06oDptGLDNhNA==
X-Received: by 2002:a05:600d:644a:10b0:490:b3cd:fc4d with SMTP id
 5b1f17b1804b1-493ec91fb9cmr44975e9.9.1783554584679; Wed, 08 Jul 2026 16:49:44
 -0700 (PDT)
MIME-Version: 1.0
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
In-Reply-To: <20260701-tegra-vpr-v3-6-d80f7b871bb4@nvidia.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Wed, 8 Jul 2026 16:49:31 -0700
X-Gm-Features: AUfX_mzOMAhQgIZCGlz9_znmnioZkDYwZn81U0HlPggiFRGlpgF5nj0v4x5iIA0
Message-ID: <CABdmKX2i_vxs3EgJgydEbXoTxqWe9g9pj=hqPKuwf0ge0SjZuQ@mail.gmail.com>
Subject: Re: [PATCH v3 06/11] mm/cma: Allow dynamically creating CMA areas
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Yury Norov <yury.norov@gmail.com>, Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>, 
 Will Deacon <will@kernel.org>, Thierry Reding <thierry.reding@gmail.com>,
 devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
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

On Wed, Jul 1, 2026 at 9:09=E2=80=AFAM Thierry Reding <thierry.reding@kerne=
l.org> wrote:
>
> From: Thierry Reding <treding@nvidia.com>
>
> There is no technical reason why there should be a limited number of CMA
> regions, so extract some code into helpers and use them to create extra
> functions (cma_create() and cma_free()) that allow creating and freeing,
> respectively, CMA regions dynamically at runtime.
>
> The static array of CMA areas cannot be replaced by dynamically created
> areas because for many of them, allocation must not fail and some cases
> may need to initialize them before the slab allocator is even available.
> To account for this, keep these "early" areas in a separate list and
> track the dynamic areas in a separate list.

Hi, It looks like you'll also need to update the CMA dma-buf heap's
add_cma_heaps init function so that it adds all the CMA areas, not
just the early ones.

>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v3:
> - rebase on top of recent linux-next, update kernel/dma/contiguous.c
> - use kzalloc_obj() instead of kzalloc() with sizeof()
>
> Changes in v2:
> - rename fixed number of CMA areas to reflect their main use
> - account for pages in dynamically allocated regions
> ---
>  arch/arm/mm/dma-mapping.c |   2 +-
>  arch/s390/mm/init.c       |   2 +-
>  include/linux/cma.h       |   8 +-
>  kernel/dma/contiguous.c   |   2 +-
>  mm/cma.c                  | 187 +++++++++++++++++++++++++++++++++++++---=
------
>  mm/cma.h                  |   5 +-
>  6 files changed, 165 insertions(+), 41 deletions(-)
>
> diff --git a/arch/arm/mm/dma-mapping.c b/arch/arm/mm/dma-mapping.c
> index f9bc53b60f99..934952ab2102 100644
> --- a/arch/arm/mm/dma-mapping.c
> +++ b/arch/arm/mm/dma-mapping.c
> @@ -254,7 +254,7 @@ struct dma_contig_early_reserve {
>         unsigned long size;
>  };
>
> -static struct dma_contig_early_reserve dma_mmu_remap[MAX_CMA_AREAS] __in=
itdata;
> +static struct dma_contig_early_reserve dma_mmu_remap[MAX_EARLY_CMA_AREAS=
] __initdata;
>
>  static int dma_mmu_remap_num __initdata;
>
> diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> index f07168a0d3dd..f8f78f1434ea 100644
> --- a/arch/s390/mm/init.c
> +++ b/arch/s390/mm/init.c
> @@ -241,7 +241,7 @@ static int s390_cma_mem_notifier(struct notifier_bloc=
k *nb,
>         mem_data.start =3D arg->start_pfn << PAGE_SHIFT;
>         mem_data.end =3D mem_data.start + (arg->nr_pages << PAGE_SHIFT);
>         if (action =3D=3D MEM_GOING_OFFLINE)
> -               rc =3D cma_for_each_area(s390_cma_check_range, &mem_data)=
;
> +               rc =3D cma_for_each_early_area(s390_cma_check_range, &mem=
_data);
>         return notifier_from_errno(rc);
>  }
>
> diff --git a/include/linux/cma.h b/include/linux/cma.h
> index 8555d38a97b1..fb7a4923c3ba 100644
> --- a/include/linux/cma.h
> +++ b/include/linux/cma.h
> @@ -7,7 +7,7 @@
>  #include <linux/numa.h>
>
>  #ifdef CONFIG_CMA_AREAS
> -#define MAX_CMA_AREAS  CONFIG_CMA_AREAS
> +#define MAX_EARLY_CMA_AREAS    CONFIG_CMA_AREAS
>  #endif
>
>  #define CMA_MAX_NAME 64
> @@ -57,8 +57,14 @@ struct page *cma_alloc_frozen_compound(struct cma *cma=
, unsigned int order);
>  bool cma_release_frozen(struct cma *cma, const struct page *pages,
>                 unsigned long count);
>
> +extern int cma_for_each_early_area(int (*it)(struct cma *cma, void *data=
), void *data);
>  extern int cma_for_each_area(int (*it)(struct cma *cma, void *data), voi=
d *data);
>  extern bool cma_intersects(struct cma *cma, unsigned long start, unsigne=
d long end);
>
>  extern void cma_reserve_pages_on_error(struct cma *cma);
> +
> +extern struct cma *cma_create(phys_addr_t base, phys_addr_t size,
> +                             unsigned int order_per_bit, const char *nam=
e);
> +extern void cma_free(struct cma *cma);
> +
>  #endif
> diff --git a/kernel/dma/contiguous.c b/kernel/dma/contiguous.c
> index f754079a287d..7975551f69b3 100644
> --- a/kernel/dma/contiguous.c
> +++ b/kernel/dma/contiguous.c
> @@ -52,7 +52,7 @@
>  #define CMA_SIZE_MBYTES 0
>  #endif
>
> -static struct cma *dma_contiguous_areas[MAX_CMA_AREAS];
> +static struct cma *dma_contiguous_areas[MAX_EARLY_CMA_AREAS];
>  static unsigned int dma_contiguous_areas_num;
>
>  static int dma_contiguous_insert_area(struct cma *cma)
> diff --git a/mm/cma.c b/mm/cma.c
> index a13ce4999b39..f989e2e98594 100644
> --- a/mm/cma.c
> +++ b/mm/cma.c
> @@ -34,7 +34,12 @@
>  #include "internal.h"
>  #include "cma.h"
>
> -struct cma cma_areas[MAX_CMA_AREAS];
> +static DEFINE_MUTEX(cma_lock);
> +
> +struct cma cma_early_areas[MAX_EARLY_CMA_AREAS];
> +unsigned int cma_early_area_count;
> +
> +static LIST_HEAD(cma_areas);
>  unsigned int cma_area_count;
>
>  phys_addr_t cma_get_base(const struct cma *cma)
> @@ -198,7 +203,6 @@ static void __init cma_activate_area(struct cma *cma)
>                                 free_reserved_page(pfn_to_page(pfn));
>                 }
>         }
> -       totalcma_pages -=3D cma->count;
>         cma->available_count =3D cma->count =3D 0;
>         pr_err("CMA area %s could not be activated\n", cma->name);
>  }
> @@ -207,8 +211,8 @@ static int __init cma_init_reserved_areas(void)
>  {
>         int i;
>
> -       for (i =3D 0; i < cma_area_count; i++)
> -               cma_activate_area(&cma_areas[i]);
> +       for (i =3D 0; i < cma_early_area_count; i++)
> +               cma_activate_area(&cma_early_areas[i]);
>
>         return 0;
>  }
> @@ -219,41 +223,77 @@ void __init cma_reserve_pages_on_error(struct cma *=
cma)
>         set_bit(CMA_RESERVE_PAGES_ON_ERROR, &cma->flags);
>  }
>
> +static void __init cma_init_area(struct cma *cma, const char *name,
> +                                phys_addr_t size, unsigned int order_per=
_bit)
> +{
> +       if (name)
> +               strscpy(cma->name, name);
> +       else
> +               snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_co=
unt);
> +
> +       cma->available_count =3D cma->count =3D size >> PAGE_SHIFT;
> +       cma->order_per_bit =3D order_per_bit;
> +
> +       INIT_LIST_HEAD(&cma->node);
> +}
> +
>  static int __init cma_new_area(const char *name, phys_addr_t size,
>                                unsigned int order_per_bit,
>                                struct cma **res_cma)
>  {
>         struct cma *cma;
>
> -       if (cma_area_count =3D=3D ARRAY_SIZE(cma_areas)) {
> +       if (cma_early_area_count =3D=3D ARRAY_SIZE(cma_early_areas)) {
>                 pr_err("Not enough slots for CMA reserved regions!\n");
>                 return -ENOSPC;
>         }
>
> +       mutex_lock(&cma_lock);
> +
>         /*
>          * Each reserved area must be initialised later, when more kernel
>          * subsystems (like slab allocator) are available.
>          */
> -       cma =3D &cma_areas[cma_area_count];
> -       cma_area_count++;
> +       cma =3D &cma_early_areas[cma_early_area_count];
> +       cma_early_area_count++;
>
> -       if (name)
> -               strscpy(cma->name, name);
> -       else
> -               snprintf(cma->name, CMA_MAX_NAME,  "cma%d\n", cma_area_co=
unt);
> +       cma_init_area(cma, name, size, order_per_bit);
>
> -       cma->available_count =3D cma->count =3D size >> PAGE_SHIFT;
> -       cma->order_per_bit =3D order_per_bit;
> -       *res_cma =3D cma;
>         totalcma_pages +=3D cma->count;
> +       *res_cma =3D cma;
> +
> +       mutex_unlock(&cma_lock);
>
>         return 0;
>  }
>
>  static void __init cma_drop_area(struct cma *cma)
>  {
> +       mutex_lock(&cma_lock);
>         totalcma_pages -=3D cma->count;
> -       cma_area_count--;
> +       cma_early_area_count--;
> +       mutex_unlock(&cma_lock);
> +}
> +
> +static int __init cma_check_memory(phys_addr_t base, phys_addr_t size)
> +{
> +       if (!size || !memblock_is_region_reserved(base, size))
> +               return -EINVAL;
> +
> +       /*
> +        * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement whic=
h
> +        * needs pageblock_order to be initialized. Let's enforce it.
> +        */
> +       if (!pageblock_order) {
> +               pr_err("pageblock_order not yet initialized. Called durin=
g early boot?\n");
> +               return -EINVAL;
> +       }
> +
> +       /* ensure minimal alignment required by mm core */
> +       if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
> +               return -EINVAL;
> +
> +       return 0;
>  }
>
>  /**
> @@ -276,22 +316,9 @@ int __init cma_init_reserved_mem(phys_addr_t base, p=
hys_addr_t size,
>         struct cma *cma;
>         int ret;
>
> -       /* Sanity checks */
> -       if (!size || !memblock_is_region_reserved(base, size))
> -               return -EINVAL;
> -
> -       /*
> -        * CMA uses CMA_MIN_ALIGNMENT_BYTES as alignment requirement whic=
h
> -        * needs pageblock_order to be initialized. Let's enforce it.
> -        */
> -       if (!pageblock_order) {
> -               pr_err("pageblock_order not yet initialized. Called durin=
g early boot?\n");
> -               return -EINVAL;
> -       }
> -
> -       /* ensure minimal alignment required by mm core */
> -       if (!IS_ALIGNED(base | size, CMA_MIN_ALIGNMENT_BYTES))
> -               return -EINVAL;
> +       ret =3D cma_check_memory(base, size);
> +       if (ret < 0)
> +               return ret;
>
>         ret =3D cma_new_area(name, size, order_per_bit, &cma);
>         if (ret !=3D 0)
> @@ -444,7 +471,7 @@ static int __init __cma_declare_contiguous_nid(phys_a=
ddr_t *basep,
>         pr_debug("%s(size %pa, base %pa, limit %pa alignment %pa)\n",
>                 __func__, &size, &base, &limit, &alignment);
>
> -       if (cma_area_count =3D=3D ARRAY_SIZE(cma_areas)) {
> +       if (cma_early_area_count =3D=3D ARRAY_SIZE(cma_early_areas)) {
>                 pr_err("Not enough slots for CMA reserved regions!\n");
>                 return -ENOSPC;
>         }
> @@ -1051,12 +1078,12 @@ bool cma_release_frozen(struct cma *cma, const st=
ruct page *pages,
>         return true;
>  }
>
> -int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data=
)
> +int cma_for_each_early_area(int (*it)(struct cma *cma, void *data), void=
 *data)
>  {
>         int i;
>
> -       for (i =3D 0; i < cma_area_count; i++) {
> -               int ret =3D it(&cma_areas[i], data);
> +       for (i =3D 0; i < cma_early_area_count; i++) {
> +               int ret =3D it(&cma_early_areas[i], data);
>
>                 if (ret)
>                         return ret;
> @@ -1065,6 +1092,25 @@ int cma_for_each_area(int (*it)(struct cma *cma, v=
oid *data), void *data)
>         return 0;
>  }
>
> +int cma_for_each_area(int (*it)(struct cma *cma, void *data), void *data=
)
> +{
> +       struct cma *cma;
> +
> +       mutex_lock(&cma_lock);
> +
> +       list_for_each_entry(cma, &cma_areas, node) {
> +               int ret =3D it(cma, data);
> +
> +               if (ret) {
> +                       mutex_unlock(&cma_lock);
> +                       return ret;
> +               }
> +       }
> +
> +       mutex_unlock(&cma_lock);
> +       return 0;
> +}
> +
>  bool cma_intersects(struct cma *cma, unsigned long start, unsigned long =
end)
>  {
>         int r;
> @@ -1147,3 +1193,74 @@ void __init *cma_reserve_early(struct cma *cma, un=
signed long size)
>
>         return ret;
>  }
> +
> +struct cma *__init cma_create(phys_addr_t base, phys_addr_t size,
> +                             unsigned int order_per_bit, const char *nam=
e)
> +{
> +       struct cma *cma;
> +       int ret;
> +
> +       ret =3D cma_check_memory(base, size);
> +       if (ret < 0)
> +               return ERR_PTR(ret);
> +
> +       cma =3D kzalloc_obj(*cma, GFP_KERNEL);
> +       if (!cma)
> +               return ERR_PTR(-ENOMEM);
> +
> +       cma_init_area(cma, name, size, order_per_bit);
> +       cma->ranges[0].base_pfn =3D PFN_DOWN(base);
> +       cma->ranges[0].early_pfn =3D PFN_DOWN(base);
> +       cma->ranges[0].count =3D cma->count;
> +       cma->nranges =3D 1;
> +
> +       cma_activate_area(cma);
> +
> +       mutex_lock(&cma_lock);
> +       list_add_tail(&cma->node, &cma_areas);
> +       totalcma_pages +=3D cma->count;
> +       cma_area_count++;
> +       mutex_unlock(&cma_lock);
> +
> +       return cma;
> +}
> +
> +void cma_free(struct cma *cma)
> +{
> +       unsigned int i;
> +
> +       /*
> +        * Safety check to prevent a CMA with active allocations from bei=
ng
> +        * released.
> +        */
> +       for (i =3D 0; i < cma->nranges; i++) {
> +               unsigned long nbits =3D cma_bitmap_maxno(cma, &cma->range=
s[i]);
> +
> +               if (!bitmap_empty(cma->ranges[i].bitmap, nbits)) {
> +                       WARN(1, "%s: range %u not empty\n", cma->name, i)=
;
> +                       return;
> +               }
> +       }
> +
> +       /* free reserved pages and the bitmap */
> +       for (i =3D 0; i < cma->nranges; i++) {
> +               struct cma_memrange *cmr =3D &cma->ranges[i];
> +               unsigned long end_pfn, pfn;
> +
> +               end_pfn =3D cmr->base_pfn + cmr->count;
> +               for (pfn =3D cmr->base_pfn; pfn < end_pfn; pfn++)
> +                       free_reserved_page(pfn_to_page(pfn));
> +
> +               bitmap_free(cmr->bitmap);
> +       }
> +
> +       mutex_destroy(&cma->alloc_mutex);
> +
> +       mutex_lock(&cma_lock);
> +       totalcma_pages -=3D cma->count;
> +       list_del(&cma->node);
> +       cma_area_count--;
> +       mutex_unlock(&cma_lock);
> +
> +       kfree(cma);
> +}
> diff --git a/mm/cma.h b/mm/cma.h
> index c70180c36559..ae4db9819e38 100644
> --- a/mm/cma.h
> +++ b/mm/cma.h
> @@ -41,6 +41,7 @@ struct cma {
>         unsigned long   available_count;
>         unsigned int order_per_bit; /* Order of pages represented by one =
bit */
>         spinlock_t      lock;
> +       struct list_head node;
>         struct mutex alloc_mutex;
>  #ifdef CONFIG_CMA_DEBUGFS
>         struct hlist_head mem_head;
> @@ -71,8 +72,8 @@ enum cma_flags {
>         CMA_ACTIVATED,
>  };
>
> -extern struct cma cma_areas[MAX_CMA_AREAS];
> -extern unsigned int cma_area_count;
> +extern struct cma cma_early_areas[MAX_EARLY_CMA_AREAS];
> +extern unsigned int cma_early_area_count;
>
>  static inline unsigned long cma_bitmap_maxno(struct cma *cma,
>                 struct cma_memrange *cmr)
>
> --
> 2.54.0
>
