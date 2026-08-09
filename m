Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2814C5AC67
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 00:51:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE76110E355;
	Sun,  9 Aug 2026 00:51:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="UtdosKga";
	dkim-atps=neutral
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com
 [209.85.160.177])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0A5510E355
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:51:22 +0000 (UTC)
Received: by mail-qt1-f177.google.com with SMTP id
 d75a77b69052e-51c15a5b265so178431cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 17:51:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786236682; cv=none;
 d=google.com; s=arc-20260327;
 b=TOj0t8ZwkOAnvh4LLwRR6Z2YrY37lWKZq8KObSlciGGh8Xoc3vms1c2bCRJlhxQKh0
 5VCsN+GjxAuo2MbRjIYniB2owy7+kpQ6ajB1K0wNCl6L7s+klK4mln3EzJBCDrlYztqV
 r922E3MR07W6PLjUaddNu96RrSvPMXVe792hCOynL3APAm0byt3QcihnnwXnrJFcLMZu
 EUE3JVAoNhz9pKuPTsnGnoPBTPcvnYHT6oCiKr/uCb1gn9EqP54tzGLSSJqWTHllRPk6
 GhgTygfWqmegtDG+S6wukSiU4EdFNIaU2Gb9DsyvVfjzqq7M51IsLWxjD2T+vUHmNUOF
 N44g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
 fh=shBZ0P6t/D96q2gHiTmLf4ZbmvxVBgAr4B49BtEoVBM=;
 b=FcME7YWwpd8QjxJAF+MqgCJ+jOBMs8BnjYaMNtEN43mv18fwu/1d7unNmZXy0rEPb5
 mIOKE1kUPnCpcCShB4AoWFM3BbxAMSwEzGh4poN1KSfHICe/WZA4B2278GexoA4fkNlP
 3C++q7p9heKUqHm2cR7AukwzrS5waiJBiqqOjjtFAUbX7/Gbv8YX2h2tZggDldX0wnzC
 0hBSwSr3Bcvhm45X99q9oQxwj69AWl9Zme1rIHwn1VOLYgU6JVjzbdeGU7Ms+TxqhqRi
 ZcfIxvJOgfXuLN3N4qfyTgYkP1VMzFf1VDn/QdEr1slCAvXMgBG+nHud2KCYRoKjbY4/
 w+lQ==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786236682; x=1786841482;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
 b=UtdosKgaJEa/ycrZmFSMbHmkbVI/FIeVVLnZBQfcg6LrBWg5y1Z64cqhquiShRKeCJ
 7URg6DzjfHjzBBREjpNdxNGOxrOckxoC/dFe0geS729KL0KoVw1kyi/bVHZSYIL60DSz
 qRZza1vXX/MvtoihRRrVCsx3OnsE5sGfxUmaDs8Y100iwT6SEfRFx/+lLmaJ/jvvywk3
 448bb5Ys0uVnOdRR6YBIIlKDOZYUxLCgYKR3QMQ3aoM3bcqPqQ2S9/MGFwRi0KDLBiai
 WYga7axH9kN/jPBKgD7qX6UmMzPBCzAKeYLjo59wxsIqvsRfkGShelt2Od6KNrjpAEYQ
 Qqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786236682; x=1786841482;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=5t26LPlL2x6rRQWr8/8g+glnpY16lnjlFmjLTvMppKc=;
 b=mFh6mzbs0gzOLc/GKVuTiafrYUJiqzoL+c94s/lWlSbqkwWZaavIBPCgxw5eQGLo5R
 4IU/uaCpvAIbbRJUQ5St07dYDzl72Y4VRRb/JcFprylo1oBk7JWP/4wVDnbHS7rxuYMv
 5dbxwooa0GDwXWMPAb9pM9HF8M3tVRMCGC5nijN32H6R+MfvpDSy4q1pccoCIHxzb/y4
 S/9COhAZnMmmt1zf05g2G350Zz8qG7miB9jiCzlk98WA5B1ocmaTI/WDBN0veZ6Uz+bg
 W7EfXJHPWpTwS73HbeMORb6bkWXQF1hQVAFRZ6tcQGeVfIrpz2C7zFLDiz7UTXVO5xbZ
 /vGw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp4UEUZq9JskQWRANDcgvDBgR8WHuor4EOfn4/wF07R6bXPaxeQP/NJq/sCA9x8eErBcwsZgljXV7s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxfAaq2o/kJOUXsavAqxjU71OyKmlpQBpZ0vcxXwerEYzQIA8ym
 Twro2GXgJJVDgnOIskwgoMFkUyIc4j3hPf0XgTAtlR5d9o+qbwGtLe/q14eoqYfyzMFukUNgmn9
 fhvGRvKvU3YcmX5M7bjdIH6mngf23C+WUD9Tfbxj6
X-Gm-Gg: AR+sD10m2fMIL8yyl1hJ/WvFEFM0Q3CDHdx6r/3vPVsYf7q4GZtvkI97rkTj1F3YgNA
 tNVRvisheNVVvm1bE21H+k2zWtp8+wShh8hjsvrN6uD2NviqTpUALQzUJRmZOywqOGjaAyv5t/g
 SmVP/0LW+JHmMVkTnjCWeGeKlMsaxRq5Nz4dSvrw+Qpl96M+YXc9+xwTILtXPI1YdtnGib9tY/P
 ylMlPaG8jHA2PuWEdJVB+k46XC3HlWQf39OWkgMYoVVOILr4xsLZrZ4okC5/HakNxcd2XYGd6sy
 d8NeKbIBpPhwXq+bpVflN6/FU3W+ZsVZ9MswjF8y/YE=
X-Received: by 2002:a05:622a:2c2:b0:517:5d71:84e5 with SMTP id
 d75a77b69052e-52d28104052mr10844831cf.5.1786236681095; Sat, 08 Aug 2026
 17:51:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-1-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-1-ab318a350404@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 8 Aug 2026 17:51:10 -0700
X-Gm-Features: AUfX_mwrAfErRpWaGdsaXjFbVsuLxmBdhaCS8dBRSF7bNpazo-ZM1X1L3isxLV8
Message-ID: <CAJuCfpFAA1H2pOi6EOarNtrdzLQDJyhm6QOGsfZ4SFTuM5eiLQ@mail.gmail.com>
Subject: Re: [PATCH v4 01/20] mm/vma: introduce VMA anon page offset field and
 add helpers
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, 
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, Jan Kara <jack@suse.cz>,
 Miaohe Lin <linmiaohe@huawei.com>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, Rik van Riel <riel@surriel.com>,
 Harry Yoo <harry@kernel.org>, 
 Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>,
 Zi Yan <ziy@nvidia.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <npache@redhat.com>, 
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, 
 Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>, 
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>, 
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>, 
 Ying Huang <ying.huang@linux.alibaba.com>, Alistair Popple <apopple@nvidia.com>,
 Peter Xu <peterx@redhat.com>, Xu Xin <xu.xin16@zte.com.cn>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>, 
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, 
 Vasily Gorbik <gor@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>,
 Boris Brezillon <boris.brezillon@collabora.com>, 
 Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, 
 Huang Rui <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>, 
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
 Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, 
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, 
 Ian Rogers <irogers@google.com>, Adrian Hunter <adrian.hunter@intel.com>, 
 James Clark <james.clark@linaro.org>, Jason Gunthorpe <jgg@ziepe.ca>, 
 John Hubbard <jhubbard@nvidia.com>, Muchun Song <muchun.song@linux.dev>, 
 Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, 
 Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
 Baoquan He <baoquan.he@linux.dev>, Youngjun Park <youngjun.park@lge.com>,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org, 
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org
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

On Thu, Aug 6, 2026 at 1:22=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Establish fields in vm_area_struct to store the anonymous page offset of
> VMAs.
>
> Initially, the anonymous page offset of a VMA is vma->vm_start >>
> PAGE_SHIFT.
>
> When a VMA is remapped to new_address its anonymous page offset is either
> updated to new_address >> PAGE_SHIFT if unfaulted or, if faulted, remains
> equal to the anonymous page offset it had when first faulted.
>
> Currently, anonymous folios belonging to CoW'd MAP_PRIVATE-mapped
> file-backed VMAs are tracked by their file offsets. By adding anonymous
> offset as a property of VMAs, we can now track them by their anonymous pa=
ge
> offset instead.
>
> By tracking this, we provide the means by which to eliminate this
> inconsistency, and more importantly lay the foundations for future work f=
or
> the scalable CoW anonymous rmap rework.
>
> This patch simply adds the fields and some simple helpers. Subsequent
> patches will update mm code to make use of these fields correctly.
>
> The fields chosen are packed in the VMA such that, for 64-bit kernel
> builds, no additional space is taken up.
>
> The first field is present on cacheline 0 containing key VMA fields, and
> the second on cacheline 3, which contains file-backed reverse mapping
> fields.
>
> Given the relative time spent accessing reverse mapping fields as well as
> updating them, there shouldn't be any performance impact here from false
> sharing.
>
> Update the VMA userland tests to account for this change.
>
> No callsites are updated yet, so no functional change intended.
>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Xu Xin <xu.xin16@zte.com.cn>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              | 59 +++++++++++++++++++++++++++++++++++=
++++++
>  include/linux/mm_types.h        | 12 +++++++++
>  mm/vma.h                        | 14 ++++++++++
>  mm/vma_init.c                   |  1 +
>  tools/testing/vma/include/dup.h | 26 ++++++++++++++++++
>  5 files changed, 112 insertions(+)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 87feaa5a2b78..df78847f5f07 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4393,6 +4393,65 @@ static inline pgoff_t vma_last_pgoff(const struct =
vm_area_struct *vma)
>         return vma_end_pgoff(vma) - 1;
>  }
>
> +/**
> + * vma_start_anon_pgoff() - Get the anonymous page offset of the start o=
f @vma
> + * @vma: The VMA whose anonymous page offset is required.
> + *
> + * If unfaulted, then this is vma->vm_start >> PAGE_SHIFT, if faulted th=
en the
> + * anonymous page offset at the time of first fault.
> + *
> + * If the VMA is anonymous, this returns the same value as vma_start_pgo=
ff().
> + *
> + * This value is used for tracking MAP_PRIVATE file-backed mappings by t=
heir
> + * anonymous page offset.

I assume this function should not be used with shared file-backed
mappings, right? If so, maybe add a comment like the one you have for
linear_anon_page_index(): "It is not valid to call this function for
shared file-backed mappings."?



> + *
> + * Returns: The anonymous page offset of the start of @vma.
> + */
> +static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *=
vma)
> +{
> +       pgoff_t pgoff =3D 0;
> +
> +#ifdef CONFIG_64BIT
> +       pgoff +=3D vma->__vm_anon_pgoff_hi;
> +       pgoff <<=3D 32;
> +#endif
> +       pgoff +=3D vma->__vm_anon_pgoff_lo;
> +       return pgoff;
> +}
> +
> +/**
> + * vma_end_anon_pgoff() - Get the anonymous page offset of the exclusive=
 end of
> + * @vma.
> + * @vma: The VMA whose end anonymous page offset is required.
> + *
> + * This returns the anonymous exclusive end page offset of @vma, which i=
s useful
> + * for expressing page offset ranges.
> + *
> + * See the description of vma_start_anon_pgoff() for a description of VM=
A
> + * anonymous page offsets.
> + *
> + * Returns: The exclusive end anonymous page offset of @vma.
> + */
> +static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vm=
a)
> +{
> +       return vma_start_anon_pgoff(vma) + vma_pages(vma);
> +}
> +
> +/**
> + * vma_last_anon_pgoff() - Get the anonymous page offset of the last pag=
e in
> + * @vma.
> + * @vma: The VMA whose last anonymous page offset is required.
> + *
> + * See the description of vma_start_anon_pgoff() for a description of VM=
A
> + * anonymous page offsets.
> + *
> + * Returns: The last anonymous page offset of @vma.
> + */
> +static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *v=
ma)
> +{
> +       return vma_end_anon_pgoff(vma) - 1;
> +}
> +
>  static inline unsigned long vma_desc_size(const struct vm_area_desc *des=
c)
>  {
>         return desc->end - desc->start;
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 939b5ea8c9e0..ebf0d912be7d 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -967,6 +967,11 @@ struct vm_area_struct {
>          */
>         unsigned int vm_lock_seq;
>  #endif
> +       /*
> +        * Low 32-bits of anonymous page offset.
> +        * See vma_start_anon_pgoff() comment for details.
> +        */
> +       unsigned int __vm_anon_pgoff_lo;
>         /*
>          * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
>          * list, after a COW of one of the file pages.  A MAP_SHARED vma
> @@ -1041,6 +1046,13 @@ struct vm_area_struct {
>  #ifdef CONFIG_DEBUG_LOCK_ALLOC
>         struct lockdep_map vmlock_dep_map;
>  #endif
> +#endif
> +#ifdef CONFIG_64BIT
> +       /*
> +        * High 32-bits of anonymous page offset.
> +        * See vma_start_anon_pgoff() comment for details.
> +        */
> +       unsigned int __vm_anon_pgoff_hi;
>  #endif
>         /*
>          * For areas with an address space and backing store,
> diff --git a/mm/vma.h b/mm/vma.h
> index 0bc7d521e976..54ed7c744e3b 100644
> --- a/mm/vma.h
> +++ b/mm/vma.h
> @@ -283,6 +283,20 @@ static inline void vma_set_pgoff(struct vm_area_stru=
ct *vma, pgoff_t pgoff)
>         vma->vm_pgoff =3D pgoff;
>  }
>
> +static inline void __vma_set_anon_pgoff(struct vm_area_struct *vma, pgof=
f_t pgoff)
> +{
> +#ifdef CONFIG_64BIT
> +       vma->__vm_anon_pgoff_hi =3D pgoff >> 32;
> +#endif
> +       vma->__vm_anon_pgoff_lo =3D pgoff & GENMASK(31, 0);
> +}
> +
> +static inline void vma_set_anon_pgoff(struct vm_area_struct *vma, pgoff_=
t pgoff)
> +{
> +       vma_assert_can_modify(vma);
> +       __vma_set_anon_pgoff(vma, pgoff);
> +}
> +
>  static inline void vma_add_pgoff(struct vm_area_struct *vma, pgoff_t del=
ta)
>  {
>         vma_assert_can_modify(vma);
> diff --git a/mm/vma_init.c b/mm/vma_init.c
> index 715feee283f0..baa7e82f47e3 100644
> --- a/mm/vma_init.c
> +++ b/mm/vma_init.c
> @@ -51,6 +51,7 @@ static void vm_area_init_from(const struct vm_area_stru=
ct *src,
>         dest->vm_end =3D src->vm_end;
>         dest->anon_vma =3D src->anon_vma;
>         dest->vm_pgoff =3D vma_start_pgoff(src);
> +       __vma_set_anon_pgoff(dest, vma_start_anon_pgoff(src));
>         dest->vm_file =3D src->vm_file;
>         dest->vm_private_data =3D src->vm_private_data;
>         vm_flags_init(dest, src->vm_flags);
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index c52b23773cd2..26d9210b1e8b 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -577,6 +577,7 @@ struct vm_area_struct {
>          */
>         unsigned int vm_lock_seq;
>  #endif
> +       unsigned int __vm_anon_pgoff_lo;
>
>         /*
>          * A file's MAP_PRIVATE vma can be in both i_mmap tree and anon_v=
ma
> @@ -612,6 +613,9 @@ struct vm_area_struct {
>  #ifdef CONFIG_PER_VMA_LOCK
>         /* Unstable RCU readers are allowed to read this. */
>         refcount_t vm_refcnt;
> +#endif
> +#ifdef CONFIG_64BIT
> +       unsigned int __vm_anon_pgoff_hi;
>  #endif
>         /*
>          * For areas with an address space and backing store,
> @@ -1320,6 +1324,28 @@ static inline pgoff_t vma_end_pgoff(const struct v=
m_area_struct *vma)
>         return vma_start_pgoff(vma) + vma_pages(vma);
>  }
>
> +static inline pgoff_t vma_start_anon_pgoff(const struct vm_area_struct *=
vma)
> +{
> +       pgoff_t pgoff =3D 0;
> +
> +#ifdef CONFIG_64BIT
> +       pgoff +=3D vma->__vm_anon_pgoff_hi;
> +       pgoff <<=3D 32;
> +#endif
> +       pgoff +=3D vma->__vm_anon_pgoff_lo;
> +       return pgoff;
> +}
> +
> +static inline pgoff_t vma_end_anon_pgoff(const struct vm_area_struct *vm=
a)
> +{
> +       return vma_start_anon_pgoff(vma) + vma_pages(vma);
> +}
> +
> +static inline pgoff_t vma_last_anon_pgoff(const struct vm_area_struct *v=
ma)
> +{
> +       return vma_end_anon_pgoff(vma) - 1;
> +}
> +
>  static inline int vfs_mmap_prepare(struct file *file, struct vm_area_des=
c *desc)
>  {
>         return file->f_op->mmap_prepare(desc);
>
> --
> 2.55.0
>
