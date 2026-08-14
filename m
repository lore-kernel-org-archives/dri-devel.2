Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E6E1C5CFDB
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 09:45:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAF6910E294;
	Fri, 14 Aug 2026 09:45:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Y1eS4vcH";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91A7510E294;
 Fri, 14 Aug 2026 09:45:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 465BB43FA0;
 Fri, 14 Aug 2026 09:45:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25E511F000E9;
 Fri, 14 Aug 2026 09:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786700746;
 bh=5HIwgrpO1fXJmlHwW1EBASxu2Cq7Szkx1H/G3rD/398=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=Y1eS4vcHSMq+0bM/nbkCMNcnwAnFodiBa9e+itcKuVlj+6p1zLi+IiA5WuDkjYAIn
 JGpyjlk6a2Ol0t21YFqdfItFcmVwQxPSJaDWeVhtyEbiJNWokMYU/EUI38gTq4JIS4
 TsVfwKNpaRK0anYl2q2uFtRsX5aPJzgZdEl1t8ZwMqOl4rG7SM+frXo0RL/EM1S++N
 Sr4/yRe6OpOplXzFeyG3IqTVjQmhij5rCnGF0iyRtjfKyvWuhE4dkgUvf4vJGnOs+q
 3LQ/JgyfEqf+coYSTWKUIXUhoLnLGAUd1kHFdLzqa8r5jTnoEd+kLbjaCFzNe78lvi
 FLy5TqJ8Grvvg==
Date: Fri, 14 Aug 2026 12:45:15 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>,
 Pedro Falcato <pfalcato@suse.de>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 Jan Kara <jack@suse.cz>, Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, Kees Cook <kees@kernel.org>,
 Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
 Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
 Usama Arif <usama.arif@linux.dev>, Matthew Brost <matthew.brost@intel.com>,
 Joshua Hahn <joshua.hahnjy@gmail.com>, Rakie Kim <rakie.kim@sk.com>,
 Byungchul Park <byungchul@sk.com>, Gregory Price <gourry@gourry.net>,
 Ying Huang <ying.huang@linux.alibaba.com>,
 Alistair Popple <apopple@nvidia.com>, Peter Xu <peterx@redhat.com>,
 Xu Xin <xu.xin16@zte.com.cn>, Chengming Zhou <chengming.zhou@linux.dev>,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Janosch Frank <frankja@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Liviu Dudau <liviu.dudau@arm.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
 Adrian Hunter <adrian.hunter@intel.com>,
 James Clark <james.clark@linaro.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
 Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>, Kemeng Shi <shikemeng@huaweicloud.com>,
 Nhat Pham <nphamcs@gmail.com>, Baoquan He <baoquan.he@linux.dev>,
 Youngjun Park <youngjun.park@lge.com>, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, kvm@vger.kernel.org,
 linux-s390@vger.kernel.org, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-perf-users@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 syzbot@syzkaller.appspotmail.com
Subject: Re: [PATCH v5 00/16] mm/rmap: index MAP_PRIVATE file-backed folios
 by anonymous pgoff
Message-ID: <an7jq2QI6CaTgFxK@kernel.org>
References: <20260813-b4-scalable-cow-virt-pgoff-v5-0-c21581c0c3c8@kernel.org>
 <20260813115346.2aaad419a351341a4f5f3ae0@linux-foundation.org>
 <an7SkamROquJ7If0@lucifer> <an7dekaY7IMMrzID@kernel.org>
 <an7eSrKUHUqPpVGv@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <an7eSrKUHUqPpVGv@lucifer>
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

On Fri, Aug 14, 2026 at 10:23:33AM +0100, Lorenzo Stoakes (ARM) wrote:
> On Fri, Aug 14, 2026 at 12:18:50PM +0300, Mike Rapoport wrote:
> > On Fri, Aug 14, 2026 at 10:01:19AM +0100, Lorenzo Stoakes (ARM) wrote:
> > > On Thu, Aug 13, 2026 at 11:53:46AM -0700, Andrew Morton wrote:
> > > > You'll be mortified to hear that Sashiko wasn't able to find anything
> > > > to which to apply this.
> > >
> > > :))
> > >
> > > Well, when it's right it's useful, when it's wrong or suggesting unrelated
> > > what-nots it's less useful :>)
> > >
> > > I do locally put things through claude + Chris Mason's prompts a lot, I
> > > don't always invoke local sashiko as it's very slow and token-heavy or has
> > > been so far, but am planning to do that more also in future.
> > >
> > > >
> > > > Sashiko can be guided with a base-commit: tag but I'm not sure how to
> > > > tell it what tree/branch to try, or even if that's necessary.  Perhaps
> > > > someone can figure this out sometime.
> > >
> > > b4 gives a base commit, but I think because the trees are rebased it ends
> > > up being the incorrect one.
> >
> > It's not only that the tree is rebased, but also that mm-unstable carries
> > the previous version of the patches.
> 
> Yeah that's part of the issue, I can't rebase on mm-unstable as a result
> obviously.
> 
> Is hard to know what is sensible to rebase on - if I rebase on base of my old
> version of the series in mm-unstable that'll probably be a bogus commit at some
> point due to other rebasing.

If the work does not depend on other commits in mm-unstable, it's possible
to base on -rcX. But often it's not the case.

> > > Not sure what the solution is!
> > >
> > > --
> > > Cheers, Lorenzo
> >
> > --
> > Sincerely yours,
> > Mike.
> 
> --
> Cheers, Lorenzo

-- 
Sincerely yours,
Mike.
