Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB2A2C5AD2C
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 00:50:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 754E710E0BC;
	Sun,  9 Aug 2026 00:50:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="kIqao121";
	dkim-atps=neutral
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com
 [209.85.160.171])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0FA3010E355
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 00:50:02 +0000 (UTC)
Received: by mail-qt1-f171.google.com with SMTP id
 d75a77b69052e-51c15a5b265so178111cf.0
 for <dri-devel@lists.freedesktop.org>; Sat, 08 Aug 2026 17:50:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786236601; cv=none;
 d=google.com; s=arc-20260327;
 b=Kd6jursfhiGcdRZBzTBp9k3Mar1oFQzj1SLRABRc5fK0YyIhfAm20k/tjF6yzqc2P6
 GbciFabOzoaJFXQItUu/j7b8ix3MA14T+fsJPSSYYg2dgRgaq4VxhXGerYTyDcmBYij6
 2/b8Eq2rM0Q37koGjjEc2yGswJmm1jy5dEaq7LuIeiXYdANn7O5ydhQc5Gb8syE7UhtT
 40ENijBtvf5cU2jQDSGop1FiW6wySCeVM6EMSNVpcNuHQzMtSjh6VL9W4+6AJrEKe5Y8
 4OjTwXuL9ph7UpFM9ZPRjbtGIVUron/AdHjr6VCHu7wKAH9pr/8lNKyPS7u/+RiccfAx
 fM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=glHudYQR7Sx8Ip0RwDHznG86gS5ZxNzd6JiJvbqbi6Y=;
 fh=j6aEvUOfPa/+MYpXklZuGu9vaAgE9Gf74jG55Lw+hTc=;
 b=pKzjRXUrHln2oKYyFGxVWlsLXVQArUzwiWKp0DsQyZixKhfVCqWCuE5v6ELf0OCZF+
 morlQtEJVbASaMOVOd1Bwd4aHUSULXzJCoSl7SyLRblnPyQ5u6gLxZ7vU1sCzVkygF5J
 i8s7mI5M7EKmzibaLEdsP4N2SVRE3Ut1328Gu7zRzrlMumENG/LEHVEiv955jKR86PA1
 YzcJ0GxOvNgGMrOrGSkGOv6SP+ri0/H5dwlersFJgbR6Vdt/b7ArVV38MKjGxVzl17X0
 9Cs1rtImz7Dq18C8jjkma+Gk0zrbGhb6BAh5zdP/c0/JpmzA07ncOmo/aKQYCoSiVnFN
 ytug==; darn=lists.freedesktop.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786236601; x=1786841401;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=glHudYQR7Sx8Ip0RwDHznG86gS5ZxNzd6JiJvbqbi6Y=;
 b=kIqao121XodBEGi30viH5tfAILvCJ/ziPgvnYex1TOvCfhfJOWYgvM38hfKmTBSPWm
 HSqa3s1d9QngV819iwVu+usEKe/rtQ0JbiCLBKEd4UryYsgXAZQr+Iw2VBNkIbLhTs0u
 8WpGTejP4dV9WKRLoTWnIRkyffwNNGndrrDDGfCUvdwetRV1nXTPW42JXr/JOsecMuDn
 DK2kC8bFvLL1c0V2j7aouzMn+CM+fbeBMT8eCXGojG5k0Z7dq4GMCHn9VY+2qy/8h8zK
 8VkxBVe6Nde1Jz2n1MMRDQBs7xzuomCFc2uILvZRPcJVcAMxQGPD1Yj8qaMxT09StqyC
 OTxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786236601; x=1786841401;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=glHudYQR7Sx8Ip0RwDHznG86gS5ZxNzd6JiJvbqbi6Y=;
 b=TfoaNWDMGD+3jUDWUdL7fRcXsFTYJ4ePKMbC0538lby8fg//1bY4ImDu8LWTsaw01x
 Jf2AqO7CjVPUueF56iOv9Dkz8YcwduYEuSJ4kgTAcqxVte40vrKnHCcQY6E60LmzBOyn
 WI8XVUsDIN/BkZ9F4cjhezFkBs4dIaALnCCFEpDvJBC0+6pMmilb/m6Ih7xh+HPvliKv
 6I6YIaA4tbcZb9AQQ9Yl7IrUgKPcfdp01AizOnX/dBdfNOuFVxvl1wPnYekEB6Z6jlLa
 l4FVM8iLmimmmAyZFC3/XICWwuhAXoYl4hCUtfyaWXShhL/5rQ1KNUOY9q0NPOpNpD2K
 FhQg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro/2HO3iEf+CaPSBHPr5wNxMiaXGRzrLRJRKpws7KSDoTbvPdyfqsT2wL3Kb7Xp4jS+9j60LYJRId8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzXacQ+I5GWleXiLw5OLc9506dFuguuDAa2xwqTfKXKf5oDLoTD
 LNysFsfYbv4HZ2a9oeZAqs9IrdzD3N9zTwCE3qpmu9fAmVSM2Q0V2jqvFrPOCY87T11uAy40ZZp
 QHUYGOA//lIobKlPUfAs2JyxpWh7ImIpzZYhvAGg4
X-Gm-Gg: AR+sD104LLJQX+1PIlhS/IX8QpWdvDz9aR8tVJqcov9BnzbcdN/DaHLlMhOfhVb0fW3
 rPhep8pnZ/+pu6Xdb/W/FL2ND9BSqFAcagaqMcn+pmSYjsVKd/uIxUrdz9jP4OwUUG/PxWhc9uC
 hEHqZXJ6Z3k5ihtWQ8NzFm2FM3+7iOE/u3LhZ7ZRcUwa9Bj5HvIHEahd5TWUPK6ZIRMejzM4mZ0
 WI/SoCtqko0YnZhPg9ro/nB52fZzCpRPXLTVbQWBfnIKQhOCr5hSJgj1Dd29Ak6WQJKgl2HlaLQ
 srArSWh+a61vCodvgS75btm5Q+EYrhtsNin5CIczOAo=
X-Received: by 2002:ac8:7f4f:0:b0:52b:4ec6:52ba with SMTP id
 d75a77b69052e-52d23c37702mr15746931cf.6.1786236600065; Sat, 08 Aug 2026
 17:50:00 -0700 (PDT)
MIME-Version: 1.0
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-3-ab318a350404@kernel.org>
In-Reply-To: <20260806-b4-scalable-cow-virt-pgoff-v4-3-ab318a350404@kernel.org>
From: Suren Baghdasaryan <surenb@google.com>
Date: Sat, 8 Aug 2026 17:49:48 -0700
X-Gm-Features: AUfX_mw1Q82W2dZ-6X55NWg9zTGU5sEbnBW6U_FzEZzOIU5ZiJmeQXvgECKsKPA
Message-ID: <CAJuCfpGjE66Duhw0r8H0GKBFDExjroRar6n5MgVOOQjz4ZfTuA@mail.gmail.com>
Subject: Re: [PATCH v4 03/20] mm: introduce linear_anon_page_index()
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

On Thu, Aug 6, 2026 at 1:23=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> This function provides the anonymous equivalent of linear_page_index(),
> instead offsetting based on the anonymous page offset of the VMA.
>
> It is valid only for anonymous or MAP_PRIVATE file-backed mappings, in
> other words CoW mappings.
>
> For pure anon VMAs, this will be equal to linear_page_index().
>
> Assert that both of these invariants are true In linear_anon_page_index()

s/In/in

> and implement the algorithm in __linear_anon_page_index().
>
> Note that MAP_PRIVATE-/dev/zero mappings will satisfy vma_is_anonymous()
> but not fulfill this invariant, so when asserting this we check
> vma->vm_file to account for this.
>
> We do not update callsites yet, so no functional change intended.
>
> Also const-ify vma_is_anonymous() to make it compatible with the
> const-ified linear_anon_page_index().
>
> While we're here, update linear_page_index() to be more succinct.
>
> VMA userland tests are also updated accordingly.
>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  include/linux/mm.h              |  2 +-
>  include/linux/pagemap.h         | 40 +++++++++++++++++++++++++++++++++++=
++---
>  tools/testing/vma/include/dup.h | 25 ++++++++++++++++++++++++-
>  3 files changed, 62 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index a3368c542947..da36a6cc907c 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -1556,7 +1556,7 @@ static inline void vma_desc_set_anonymous(struct vm=
_area_desc *desc)
>         desc->vm_ops =3D NULL;
>  }
>
> -static inline bool vma_is_anonymous(struct vm_area_struct *vma)
> +static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
>  {
>         return !vma->vm_ops;
>  }
> diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> index c6fc783aaee5..0adfa6605653 100644
> --- a/include/linux/pagemap.h
> +++ b/include/linux/pagemap.h
> @@ -1094,10 +1094,44 @@ static inline pgoff_t linear_page_delta(const str=
uct vm_area_struct *vma,
>  static inline pgoff_t linear_page_index(const struct vm_area_struct *vma=
,
>                                         const unsigned long address)
>  {
> -       pgoff_t pgoff;
> +       return linear_page_delta(vma, address) + vma_start_pgoff(vma);
> +}
> +
> +static inline pgoff_t __linear_anon_page_index(const struct vm_area_stru=
ct *vma,
> +               const unsigned long address)
> +{
> +       return linear_page_delta(vma, address) + vma_start_anon_pgoff(vma=
);
> +}
> +
> +/**
> + * linear_anon_page_index() - Determine the absolute anonymous page offs=
et of
> + * @address within @vma.
> + * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @address r=
esides.
> + * @address: The address whose absolute page offset is required.
> + *
> + * This returns the anonymous page offset of @address, which is the page=
 offset
> + * the address possessed at the time the VMA was first faulted.
> + *
> + * For anonymous mappings, this returns the same value as linear_page_in=
dex().
> + *
> + * For MAP_PRIVATE file-backed mappings, this returns the anonymous page=
 offset
> + * of @address, which is the page offset the address possessed at the ti=
me the
> + * VMA was first faulted.
> + *
> + * It is not valid to call this function for shared file-backed mappings=
.
> + *
> + * Returns: The absolute anonymous page offset of @address within @vma.
> + */
> +static inline pgoff_t linear_anon_page_index(const struct vm_area_struct=
 *vma,
> +               const unsigned long address)
> +{
> +       const pgoff_t pgoff =3D __linear_anon_page_index(vma, address);
> +
> +       VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));

As discussed off the list, this assertion works even for read-only
anon mappings because, as you said, "there's no such thing as a pure
anon mapping that is !VMA_MAYWRITE_BIT, there is no way to achieve
that."
It took me some time to see that after reading your discussion with
David at [1] and [2], and I don't think it's very intuitive. Could you
please add a comment explaining that? Maybe add a comment at
vma_is_cow_mapping() definition since you are using the same assertion
in another patch of this series?

[1] https://lore.kernel.org/linux-mm/anBjpdMicqaGADr-@lucifer/
[2] https://lore.kernel.org/linux-mm/anLyhaI6kW-EWk13@lucifer/



> +       /* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous=
. */
> +       if (vma_is_anonymous(vma) && !vma->vm_file)
> +               VM_WARN_ON_ONCE(pgoff !=3D linear_page_index(vma, address=
));
>
> -       pgoff =3D linear_page_delta(vma, address);
> -       pgoff +=3D vma_start_pgoff(vma);
>         return pgoff;
>  }
>
> diff --git a/tools/testing/vma/include/dup.h b/tools/testing/vma/include/=
dup.h
> index 40ad83936b28..4c58487b764e 100644
> --- a/tools/testing/vma/include/dup.h
> +++ b/tools/testing/vma/include/dup.h
> @@ -1428,7 +1428,7 @@ static inline void vma_iter_set(struct vma_iterator=
 *vmi, unsigned long addr)
>         mas_set(&vmi->mas, addr);
>  }
>
> -static inline bool vma_is_anonymous(struct vm_area_struct *vma)
> +static inline bool vma_is_anonymous(const struct vm_area_struct *vma)
>  {
>         return !vma->vm_ops;
>  }
> @@ -1621,3 +1621,26 @@ static inline pgprot_t vma_get_page_prot(const str=
uct vm_area_struct *vma)
>  {
>         return vma_flags_to_page_prot(vma->flags);
>  }
> +
> +static inline pgoff_t __linear_anon_page_index(const struct vm_area_stru=
ct *vma,
> +                                              const unsigned long addres=
s)
> +{
> +       pgoff_t pgoff;
> +
> +       pgoff =3D linear_page_delta(vma, address);
> +       pgoff +=3D vma_start_anon_pgoff(vma);
> +       return pgoff;
> +}
> +
> +static inline pgoff_t linear_anon_page_index(const struct vm_area_struct=
 *vma,
> +               const unsigned long address)
> +{
> +       const pgoff_t pgoff =3D __linear_anon_page_index(vma, address);
> +
> +       VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
> +       /* Account for MAP_PRIVATE-/dev/zero which is only semi-anonymous=
. */
> +       if (vma_is_anonymous(vma) && !vma->vm_file)
> +               VM_WARN_ON_ONCE(pgoff !=3D linear_page_index(vma, address=
));
> +
> +       return pgoff;
> +}
>
> --
> 2.55.0
>
