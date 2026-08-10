Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CAEC5AD4E
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 08:40:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B46A10E727;
	Mon, 10 Aug 2026 08:40:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JKo9vEdD";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9623A10E727;
 Mon, 10 Aug 2026 08:40:21 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4969543BC1;
 Mon, 10 Aug 2026 08:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B481F000E9;
 Mon, 10 Aug 2026 08:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786351221;
 bh=pqefW5WYGaVGXBp1EcWnADXqL4SSTTp93r2Me4s4EHs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=JKo9vEdDRY9kEpH19pzoxMjPpB+BwegkZ/hk4gIse31W3/UahgMnQa9xh4JjiQFgo
 vyAT1sLy2fN77hi3ktVZitRAApigE7usTNwPtrxSB+xZCKedho76MmsOO/kaNwnbCG
 G3vVVXUDdlBbR1BRn+wmJtYxwXZyV17hCm0IC+Cr7LvHqWPryov+rSycK1U6Sf07Q1
 a7K8Tx1IL6pcLFaXbOdwrOnccNyiajONZXrnTfr9FsiSjC5tGcxHcAlw+KE9+lCQDw
 I5B2NwM1a16Nkb4aClNBGjXSL3P4mApb8jLLnQeWlG5EA6ipQr7F/Z059iZBFNYRbF
 tXXNVEkrpiKjA==
Date: Mon, 10 Aug 2026 09:39:47 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Michal Hocko <mhocko@suse.com>, 
 Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
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
Subject: Re: [PATCH v4 03/20] mm: introduce linear_anon_page_index()
Message-ID: <anmNojqwGzdiLkIm@lucifer>
References: <20260806-b4-scalable-cow-virt-pgoff-v4-0-ab318a350404@kernel.org>
 <20260806-b4-scalable-cow-virt-pgoff-v4-3-ab318a350404@kernel.org>
 <CAJuCfpGjE66Duhw0r8H0GKBFDExjroRar6n5MgVOOQjz4ZfTuA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpGjE66Duhw0r8H0GKBFDExjroRar6n5MgVOOQjz4ZfTuA@mail.gmail.com>
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

On Sat, Aug 08, 2026 at 05:49:48PM -0700, Suren Baghdasaryan wrote:
> On Thu, Aug 6, 2026 at 1:23 PM Lorenzo Stoakes (ARM) <ljs@kernel.org> wrote:
> >
> > This function provides the anonymous equivalent of linear_page_index(),
> > instead offsetting based on the anonymous page offset of the VMA.
> >
> > It is valid only for anonymous or MAP_PRIVATE file-backed mappings, in
> > other words CoW mappings.
> >
> > For pure anon VMAs, this will be equal to linear_page_index().
> >
> > Assert that both of these invariants are true In linear_anon_page_index()
>
> s/In/in

Ack. I ran these patches through claude several times and it didn't get this ;)
the machines are not taking over just yet...

Andrew - could you change this in-place? Thanks!

> > diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
> > index c6fc783aaee5..0adfa6605653 100644
> > --- a/include/linux/pagemap.h
> > +++ b/include/linux/pagemap.h
> > @@ -1094,10 +1094,44 @@ static inline pgoff_t linear_page_delta(const struct vm_area_struct *vma,
> >  static inline pgoff_t linear_page_index(const struct vm_area_struct *vma,
> >                                         const unsigned long address)
> >  {
> > -       pgoff_t pgoff;
> > +       return linear_page_delta(vma, address) + vma_start_pgoff(vma);
> > +}
> > +
> > +static inline pgoff_t __linear_anon_page_index(const struct vm_area_struct *vma,
> > +               const unsigned long address)
> > +{
> > +       return linear_page_delta(vma, address) + vma_start_anon_pgoff(vma);
> > +}
> > +
> > +/**
> > + * linear_anon_page_index() - Determine the absolute anonymous page offset of
> > + * @address within @vma.
> > + * @vma: An anonymous or MAP_PRIVATE file-backed VMA in which @address resides.
> > + * @address: The address whose absolute page offset is required.
> > + *
> > + * This returns the anonymous page offset of @address, which is the page offset
> > + * the address possessed at the time the VMA was first faulted.
> > + *
> > + * For anonymous mappings, this returns the same value as linear_page_index().
> > + *
> > + * For MAP_PRIVATE file-backed mappings, this returns the anonymous page offset
> > + * of @address, which is the page offset the address possessed at the time the
> > + * VMA was first faulted.
> > + *
> > + * It is not valid to call this function for shared file-backed mappings.
> > + *
> > + * Returns: The absolute anonymous page offset of @address within @vma.
> > + */
> > +static inline pgoff_t linear_anon_page_index(const struct vm_area_struct *vma,
> > +               const unsigned long address)
> > +{
> > +       const pgoff_t pgoff = __linear_anon_page_index(vma, address);
> > +
> > +       VM_WARN_ON_ONCE(!vma_is_cow_mapping(vma));
>
> As discussed off the list, this assertion works even for read-only
> anon mappings because, as you said, "there's no such thing as a pure
> anon mapping that is !VMA_MAYWRITE_BIT, there is no way to achieve
> that."
> It took me some time to see that after reading your discussion with
> David at [1] and [2], and I don't think it's very intuitive. Could you
> please add a comment explaining that? Maybe add a comment at
> vma_is_cow_mapping() definition since you are using the same assertion
> in another patch of this series?

Sure will do! It is very confusing stuff (and I was duly confused also at
first).

To save a respin (unless there's more stuff I need to address) I will probably
reply to the relevant patch with a proposed new comment.

>
> [1] https://lore.kernel.org/linux-mm/anBjpdMicqaGADr-@lucifer/
> [2] https://lore.kernel.org/linux-mm/anLyhaI6kW-EWk13@lucifer/

--
Cheers, Lorenzo
