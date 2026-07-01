Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C154C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 10:20:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 63F3210E36A;
	Wed,  1 Jul 2026 10:20:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cuGMmNGU";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8217210E36A;
 Wed,  1 Jul 2026 10:20:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 69CE6601DE;
 Wed,  1 Jul 2026 10:20:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB7771F000E9;
 Wed,  1 Jul 2026 10:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782901223;
 bh=D5+bWR29OngXVj5rwG1+zYSN1WwMk4/7ECM6WfNh2uI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=cuGMmNGU7E65Dg68eYFJaoaIWAAXeqkJUg8FZQJgjFh+i1j9q01MpEqRw5mq7z2rO
 rkXRZR9NGSQ9sII7fZOwfSIwzleA8JRMW111/zeCE0qmHsxiY/HLQ0Dm8xGge55Nbo
 /rPxBfTmGORtHvvZPyK97uPKTZnGWvFXgU7p2RkSdlG4PEyzwi19N3lXnrYxEkZX5b
 zl9UvB9/CJ8gR1giihtd/aBTGzdpN/Ulj4oApN/i9Aqbvc2Mp6sFjuGNqa0yzOHDgG
 nR1WDpWllVqYqSGN3pkdhjkgYYrs6JaUJqiQNQpkXzrrwNWf/Am7VMbc8hwnba0Luf
 /Q1TqhzeWdoGA==
Date: Wed, 1 Jul 2026 11:20:01 +0100
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
Subject: Re: [PATCH 12/30] mm/vma: clean up anon_vma_compatible()
Message-ID: <akTpyNqkh6W1SmhI@lucifer>
References: <cover.1782735110.git.ljs@kernel.org>
 <5a7a07bd2a774989849b0fea84f758059ed914df.1782735110.git.ljs@kernel.org>
 <akPwbHbGiF1FxL6m@pedro-suse.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akPwbHbGiF1FxL6m@pedro-suse.lan>
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

On Tue, Jun 30, 2026 at 05:36:18PM +0100, Pedro Falcato wrote:
> On Mon, Jun 29, 2026 at 01:23:23PM +0100, Lorenzo Stoakes wrote:
> > Break up the existing very large conditional, add comments and use
> > vma_[start/end]_pgoff() to make clearer what we're doing here.
> >
> > No functional change intended.
> >
> > Signed-off-by: Lorenzo Stoakes <ljs@kernel.org>
> > ---
> >  mm/vma.c | 21 ++++++++++++++++-----
> >  1 file changed, 16 insertions(+), 5 deletions(-)
> >
> > diff --git a/mm/vma.c b/mm/vma.c
> > index b60375c6c5c3..6296acecf3b7 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -1967,14 +1967,25 @@ static int anon_vma_compatible(struct vm_area_struct *a, struct vm_area_struct *
> >  {
> >  	vma_flags_t diff = vma_flags_diff_pair(&a->flags, &b->flags);
> >
> > +	/* Ignore flags that mprotect() can change. */
> >  	vma_flags_clear_mask(&diff, VMA_ACCESS_FLAGS);
> > +	/* Ignore flags that do not impact merging. */
> >  	vma_flags_clear_mask(&diff, VMA_IGNORE_MERGE_FLAGS);
> >
> > -	return a->vm_end == b->vm_start &&
> > -		mpol_equal(vma_policy(a), vma_policy(b)) &&
> > -		a->vm_file == b->vm_file &&
> > -		vma_flags_empty(&diff) &&
> > -		b->vm_pgoff == a->vm_pgoff + ((b->vm_start - a->vm_start) >> PAGE_SHIFT);
> > +	/* Must be adjacent. */
> > +	if (a->vm_end != b->vm_start)
> > +		return false;
> > +	/* Must have matching policy. */
> > +	if (!mpol_equal(vma_policy(a), vma_policy(b)))
> > +		return false;
> > +	/* Must both be anon or map the same file (MAP_PRIVATE case). */
> > +	if (a->vm_file != b->vm_file)
> > +		return false;
> > +	/* Flags must be equivalent modulo mprotect(). */
> > +	if (!vma_flags_empty(&diff))
> > +		return false;
> > +	/* Page offset must align. */
> > +	return vma_end_pgoff(a) == vma_start_pgoff(b);
>
> Very nice.
>
> Reviewed-by: Pedro Falcato <pfalcato@suse.de>

Thanks :)

>
> --
> Pedro

Cheers, Lorenzo
