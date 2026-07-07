Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB101C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 10:35:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 084DE10E48F;
	Tue,  7 Jul 2026 10:35:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="muEHhNZS";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45A0510E48F;
 Tue,  7 Jul 2026 10:35:52 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C8A77411A4;
 Tue,  7 Jul 2026 10:35:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF751F000E9;
 Tue,  7 Jul 2026 10:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783420551;
 bh=ZIdJ2kWnZSzaIc2VKvx3tV02RUSZsKP0aF813USpRQY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=muEHhNZSQ0LSJO5dQUblRtk+3KNiW1Sexx9P7JyID1p9Hp3xGv0J4UbRG+fY5Nk5k
 lfNOH48QJc7HVhAUIDSaP4FNnIxe1mCFgX523zuLO4ghOrfTq4nTYzyBZzGlQjIANh
 G5dVcytVLi1Y4Go7lt7Hi1xf1O/iRDFx8vFh8b1fkkLSr//7hIoyAOX0XNg3mhaHuE
 /MZdzFdyC5bAY2+EfgYmdAJYL+l14uqVN6YBlzzFherZX3IvuvVVB4464w8KwAKHFR
 Cb6iDTk1N1p2T8kQle7lANNppyIF7SnaCJrLWMjV2fVD3A9nrBk/dbzE9PoWVE/mTu
 kXgj2SJWBNUbA==
Date: Tue, 7 Jul 2026 11:35:27 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>, 
 Simon Schuster <schuster.simon@siemens-energy.com>, 
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, 
 Jarkko Sakkinen <jarkko@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Ian Abbott <abbotti@mev.co.uk>, 
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov <lumag@kernel.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Ankit Agrawal <ankita@nvidia.com>, 
 Alex Williamson <alex@shazbot.org>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Dan Williams <djbw@kernel.org>, 
 Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 David Hildenbrand <david@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 "Liam R . Howlett" <liam@infradead.org>, Matthew Wilcox <willy@infradead.org>, 
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>, 
 Arnaldo Carvalho de Melo <acme@kernel.org>, Namhyung Kim <namhyung@kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Oleg Nesterov <oleg@redhat.com>, 
 Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, 
 Hugh Dickins <hughd@google.com>, Mike Rapoport <rppt@kernel.org>,
 Kees Cook <kees@kernel.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-sgx@vger.kernel.org, 
 etnaviv@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, 
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, 
 linux-fsdevel@vger.kernel.org, nvdimm@lists.linux.dev, linux-mm@kvack.org, 
 iommu@lists.linux.dev, linux-perf-users@vger.kernel.org, 
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, 
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH 25/30] mm/vma: update vmg_adjust_set_range() to offset
 pgoff instead
Message-ID: <akzVxx6vIeiXO-cV@lucifer>
References: <cover.1782735110.git.ljs@kernel.org>
 <910f7b5be78232304dc7ca01cd57c6f5ca8f3d13.1782735110.git.ljs@kernel.org>
 <akZLhkjsJ_3sGdox@pedro-suse.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akZLhkjsJ_3sGdox@pedro-suse.lan>
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

On Thu, Jul 02, 2026 at 12:29:54PM +0100, Pedro Falcato wrote:
> On Mon, Jun 29, 2026 at 01:23:36PM +0100, Lorenzo Stoakes wrote:
> > We are calculating the pgoff as an offset, since we have vma_add_pgoff()
> > and vma_sub_pgoff() available, just offset this value directly and use
> > __vma_set_range() for vma->vm_[start, end] values.
> >
> > We take care to update the range before offsetting the page offset, so the
> > adjusted VMA's vm_start and vm_pgoff are mutually consistent at the point
> > the page offset helpers operate - this matters once vma_set_pgoff() comes
> > to assert invariants which relate the two.
> >
> > Doing so lays the foundation for future work which allows for use of
> > virtual page offsets for MAP_PRIVATE-file backed mappings.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> >  mm/vma.c | 15 ++++-----------
> >  1 file changed, 4 insertions(+), 11 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index e3355eab11f2..0579fc8c9bd5 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -714,9 +714,6 @@ void validate_mm(struct mm_struct *mm)
> >   */
> >  static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
> >  {
> > -	struct vm_area_struct *adjust;
> > -	pgoff_t pgoff;
> > -
> >  	if (vmg->__adjust_middle_start) {
> >  		/*
> >  		 * vmg->start    vmg->end
> > @@ -735,8 +732,8 @@ static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
> >  		struct vm_area_struct *middle = vmg->middle;
> >  		const unsigned long delta = vmg->end - middle->vm_start;
> >
> > -		pgoff = vma_start_pgoff(middle) + (delta >> PAGE_SHIFT);
> > -		adjust = middle;
> > +		__vma_set_range(middle, vmg->end, middle->vm_end);
> > +		vma_add_pgoff(middle, delta >> PAGE_SHIFT);
> >  	} else if (vmg->__adjust_next_start) {
> >  		/*
> >  		 *                Originally:
> > @@ -764,13 +761,9 @@ static void vmg_adjust_set_range(struct vma_merge_struct *vmg)
> >  		struct vm_area_struct *next = vmg->next;
> >  		const unsigned long delta = next->vm_start - vmg->end;
> >
> > -		pgoff = vma_start_pgoff(next) - (delta >> PAGE_SHIFT);
> > -		adjust = next;
> > -	} else {
> > -		return;
> > +		__vma_set_range(next, vmg->end, next->vm_end);
> > +		vma_sub_pgoff(next, delta >> PAGE_SHIFT);
> >  	}
> > -
> > -	vma_set_range(adjust, vmg->end, adjust->vm_end, pgoff);
> >  }
>
> Maybe this should be squashed with That Other Patch that touches this.

Ah this separation makes more sense from the point of view of the virt pgoff
stuff in the RFC (see [0]).

And would rather keep as vaguely bitesized as possible :>)

>
> Anyway,
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks!

>
> --
> Pedro

Cheers, Lorenzo

[0]:https://lore.kernel.org/linux-mm/cover.1782745153.git.ljs@kernel.org/
