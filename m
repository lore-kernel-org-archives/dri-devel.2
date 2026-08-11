Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B080C5CFD9
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 08:41:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D05910EAC9;
	Tue, 11 Aug 2026 08:41:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HneO5wKc";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 551CC10E2B3;
 Tue, 11 Aug 2026 08:41:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7477F600AE;
 Tue, 11 Aug 2026 08:41:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8E21F000E9;
 Tue, 11 Aug 2026 08:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786437685;
 bh=B9oyw8VGrdnmKGUbtduBgbxCRdwpvdeLqgkhrCXDNKQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=HneO5wKcZdSzCZgiPL7O6y0hkp8NxpOysOwjQ1/0p5DZJDgbHmr8oIIto+qbUqUP8
 QSncbqQais7NDR31QFmgQ7SJeueG1RlsaCn/ugXce/uqztMKctFvKx1+vcfyXCvqNZ
 VJEHlmRInootV9fshr8tYk5LG1afiv/E+UOYl58uNgPRApc4UGU+ngmdh3PqQBdarD
 Za9aH05yjKoWK0cBkN69Xhhb9cMAk62gCUKpXkd+IC3tlRx4y1qZ5QJ3SYz3eWJwWJ
 /V1P5kbBwkgzwAFtJUA4uuFpLGZnK495BJYq41HQc15Y/yGaMH9StOXlfO1t3CLsMy
 Wo0bc8EiRjuEw==
Date: Tue, 11 Aug 2026 09:40:50 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
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
 Byungchul Park <byungchul@sk.com>, 
 Gregory Price <gourry@gourry.net>, Ying Huang <ying.huang@linux.alibaba.com>, 
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, 
 Chengming Zhou <chengming.zhou@linux.dev>, Arnd Bergmann <arnd@arndb.de>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Alex Deucher <alexander.deucher@amd.com>, 
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>, 
 Liviu Dudau <liviu.dudau@arm.com>, Huang Rui <ray.huang@amd.com>, 
 Matthew Auld <matthew.auld@intel.com>, 
 Thomas =?utf-8?Q?Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>, 
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>, 
 Adrian Hunter <adrian.hunter@intel.com>, James Clark <james.clark@linaro.org>, 
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Chris Li <chrisl@kernel.org>, 
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>, 
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>, 
 Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org,
 kvm@vger.kernel.org, 
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-perf-users@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/20] mm: provide vma_[flags_]is_cow_mapping() and
 remove is_cow_mapping()
Message-ID: <anrfA56ZIL7QQqvk@lucifer>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-2-ab318a350404@kernel.org>
 <ann-vS6MYT9kuXqu@lucifer>
 <20260810151007.c1cfbcf46d498d2f8ce566f9@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260810151007.c1cfbcf46d498d2f8ce566f9@linux-foundation.org>
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

On Mon, Aug 10, 2026 at 03:10:07PM -0700, Andrew Morton wrote:
> On Mon, 10 Aug 2026 18:59:34 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > Hi Andrew - would it be possible to insert the comments added below? Trying
> > to avoid a respin if possible :)
>
> np, like this?

Great thanks!

Just one minor edit below (being pedantic here but kinda what the comment
needs I think :)

>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm-provide-vma_is_cow_mapping-and-remove-is_cow_mapping-fix
> Date: Mon Aug 10 03:07:02 PM PDT 2026
>
> add comments, per Lorenzo
>
> Link: https://lore.kernel.org/ann-vS6MYT9kuXqu@lucifer
> Cc: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
>  include/linux/mm.h |   57 +++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 57 insertions(+)
>
> --- a/include/linux/mm.h~mm-provide-vma_is_cow_mapping-and-remove-is_cow_mapping-fix
> +++ a/include/linux/mm.h
> @@ -2271,17 +2271,74 @@ void unpin_user_pages(struct page **page
>  void unpin_user_folio(struct folio *folio, unsigned long npages);
>  void unpin_folios(struct folio **folios, unsigned long nfolios);
>
> +/**
> + * vma_flags_is_cow_mapping() - Do these VMA flags imply a CoW mapping?
> + * @flags: The VMA flags to check.
> + *
> + * Mappings which could be CoW'd (subject to Copy-On-Write faults) are
> + * described as CoW mappings.
> + *
> + * All mappings backed by anonymous folios (all anonymous mappings and most
> + * MAP_PRIVATE-file backed ranges) are CoW mappings.
> + *
> + * All other mappings (including all writable MAP_SHARED mappings) are
> + * non-CoW.

I ummed and ahhed over how to put this but now I think this could cause
confusion so could you replace the paragraph with:

 * All other mappings (including all MAP_SHARED mappings) are non-CoW.

It's _all_ MAP_SHARED mappings not just writable, I thought people would
automatically assume read-only wasn't included plus drivers could in theory
do crazy things (I have a pending series to fix that though) but it's
clearer just to say all.

> + *
> + * The criteria are !VMA_SHARED_BIT, VMA_MAYWRITE_BIT.
> + *
> + * VMA_MAYWRITE_BIT is checked instead of VMA_WRITE_BIT to account for both
> + * future mprotect() calls which can render a read-only mapping writable, and
> + * GUP with FOLL_FORCE (e.g. ptrace) which can CoW a read-only mapping.
> + *
> + * - No anonymous mapping can ever clear VMA_MAYWRITE_BIT.
> + *
> + * - Writes to anonymous mappings do not immediately result in CoW faults but
> + *   may do so after the process is forked or if a read is followed by a
> + *   write.
> + *
> + * - Writes to MAP_PRIVATE file-backed mappings result in CoW faults and may
> + *   do so again after fork.
> + *
> + * - MAP_SHARED mappings of a file opened read-only are transformed into
> + *   VMA_MAYSHARE_BIT, !VMA_SHARED_BIT, !VMA_MAYWRITE_BIT mappings, so remain
> + *   non-CoW.
> + *
> + * - Drivers may clear VMA_MAYWRITE_BIT but do so at mmap() time and cannot
> + *   mark themselves anonymous. Having cleared this flag it is not valid for
> + *   them to leave the VMA_WRITE_BIT flag set.
> + *
> + * As a consequence, the anonymous reverse mapping only tracks CoW mappings.
> + *
> + * Returns: true if the flags indicate a CoW mapping, otherwise false.
> + */
>  static inline bool vma_flags_is_cow_mapping(const vma_flags_t *flags)
>  {
>  	return vma_flags_test(flags, VMA_MAYWRITE_BIT) &&
>  		!vma_flags_test(flags, VMA_SHARED_BIT);
>  }
>
> +/**
> + * vma_is_cow_mapping() - Is this VMA a CoW mapping?
> + * @desc: The VMA to check.
> + *
> + * See vma_flags_is_cow_mapping() for details.
> + *
> + * Returns: true if the VMA is a CoW mapping, otherwise false.
> + */
>  static inline bool vma_is_cow_mapping(const struct vm_area_struct *vma)
>  {
>  	return vma_flags_is_cow_mapping(&vma->flags);
>  }
>
> +/**
> + * vma_desc_is_cow_mapping() - Is this VMA descriptor a CoW mapping?
> + * @desc: The VMA descriptor to check.
> + *
> + * See vma_flags_is_cow_mapping() for details.
> + *
> + * Returns: true if the VMA descriptor describes a CoW mapping, otherwise
> + * false.
> + */
>  static inline bool vma_desc_is_cow_mapping(struct vm_area_desc *desc)
>  {
>  	return vma_flags_is_cow_mapping(&desc->vma_flags);
> _
>

--
Cheers, Lorenzo
