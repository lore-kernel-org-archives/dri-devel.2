Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74EC4C43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 07:19:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79D0C10EB04;
	Tue, 30 Jun 2026 07:19:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gourry.net header.i=@gourry.net header.b="XHPXI8db";
	dkim-atps=neutral
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F034E10E9D1
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 17:11:26 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-51c05dcdf49so9955021cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 10:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1782753086; x=1783357886; darn=lists.freedesktop.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=C6+KY00whvPT5nv3+mPk4rrEbELgRer0MfbyQfoaO+U=;
 b=XHPXI8dbm5oIGcyXqRWhprS4dQS112kuUYNmIgjCwnugPVjvKp6bqaNPVrBbxiMT9G
 Rjpz1AVLcqs2s1i2LD+N93uUMk2wWJPSmyiJM9LRZg9vLWOI0kDGeTG7jOj1vXEXqCyf
 xrwUJhITds5a1uyiaq7Jt5HXpIqRq9hMJV1OFGBuABzR0Gkw72/LSCCJoXdElDyb7qNe
 tiwkVslo/vFghGq5toFw/myHOrjoQuTZoCNy2jq9mWiTg4G+EYighKZ2IQHu0E8eJKl9
 +uTBJWTPI4Kc+E3cp3zzYbmnHj7afHrHc2Tcq0xpNCiTtB4oJyO7u3uOM25PXDMNW3jJ
 MfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782753086; x=1783357886;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=C6+KY00whvPT5nv3+mPk4rrEbELgRer0MfbyQfoaO+U=;
 b=Xfo0LLTf/roRf1UDxD4CgemXfh3FZX0orShbFDE1iw8vj0Ls1xmhX0EvkzYLm8EpgH
 jD37C1Ex+mKwJ23bGBD6xrdWjHPuQuiBhF1lKyWeZNxDzBZxy1zXTLXdDzp0QnNJAo3K
 Gq4wNdZzPCSLWty4QXTWMXQLq5zkLHb3NQF3/l4VwRjjl7uKIihuIXVHXlgzEUqe2kFz
 bFKxH1lT5zntfaqLJR/YPHnL+uIexrkM2dxouszUr5D0Mypij1iVTrAFptVmeN5g1i1g
 lNCBa28Mbpk4MH0k1BYoLoCb4xQ3oTYYuyggBObas/6tmXVfR3wditzrbhLllZW2OxuF
 YmkQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9wfYW3IFkDd0siMIZFYqwRQW2qpmN3jn2ry8mK4Q4P5dPAEO8ZXSI6WePBiZW8WveqIWqfc735G68=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx6PCeqzkQ8q8twozgTNmv/cbj4cQXsYYymzrNUppJ8+q4rDU4V
 fxOSbfuYwF/iHy7MPgP446isopYa+HOczK3122mtvDd50o/cN5dnafRedhZS1uGySTo=
X-Gm-Gg: AfdE7cnsWVBNPM6IOEDx8L3t7xxnone91QmlRSzTgJBtTMGWdikK98HtAaWpeZkFHno
 NS5RxP3O5ZwZ2T4z0dgwoKpv6rdLXjjmYU8jrh8JpxWOfDwp40E0fiiElK/lJNPv/16z9VVkqao
 sm4aIMm1xOPL9zhOnHWGmRLubz6DwC7Vk6w3DRu689UefqocdBwBgLr/j1Mx4aoDznSiJjtFs2U
 0U6ZTblVsKTIWVeO66SXIOFzdevWlH+nCcK4BqOMReqtsKwyTN+AGSeJJ/FORwnZCSvjYkkH12q
 RmoYYrMAblmPgGY0KTkK3X168rTqzOAhaleVNIrfob2vUg3jgck6AivFD0dP4IUUXAwPZV18v6B
 G3vvqZHxRc0ydTKZznR/s23prs5lhl+sRNSe1geu9jyViuuyxzeuUd/eERJOVvP3ijR50RjxBI8
 kGoZaC9M7REAFq16vB4ig2GA1Ydv3ZzgqwdlOsH/JZGJlYC28RgxDnbImyKq7v86+nNnL5eMY/2
 daMSwQ=
X-Received: by 2002:a05:622a:420b:b0:517:58f6:29c3 with SMTP id
 d75a77b69052e-51c107f633bmr2561751cf.32.1782753085667; 
 Mon, 29 Jun 2026 10:11:25 -0700 (PDT)
Received: from gourry-fedora-PF4VCD3F
 (pool-173-79-60-52.washdc.fios.verizon.net. [173.79.60.52])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51c1080d4dcsm934601cf.5.2026.06.29.10.11.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 10:11:25 -0700 (PDT)
Date: Mon, 29 Jun 2026 13:11:19 -0400
From: Gregory Price <gourry@gourry.net>
To: Lorenzo Stoakes <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@armlinux.org.uk>, Dinh Nguyen <dinguyen@kernel.org>,
 Simon Schuster <schuster.simon@siemens-energy.com>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 Helge Deller <deller@gmx.de>, Jarkko Sakkinen <jarkko@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 Ian Abbott <abbotti@mev.co.uk>,
 H Hartley Sweeten <hsweeten@visionengravers.com>,
 Lucas Stach <l.stach@pengutronix.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Patrik Jakobsson <patrik.r.jakobsson@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Dmitry Baryshkov <lumag@kernel.org>,
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
 Thierry Reding <thierry.reding@kernel.org>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Christian Koenig <christian.koenig@amd.com>,
 Huang Rui <ray.huang@amd.com>, Ankit Agrawal <ankita@nvidia.com>,
 Alex Williamson <alex@shazbot.org>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>,
 Dan Williams <djbw@kernel.org>, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, David Hildenbrand <david@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 "Liam R . Howlett" <liam@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Namhyung Kim <namhyung@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 Oleg Nesterov <oleg@redhat.com>,
 Steven Rostedt <rostedt@goodmis.org>, SeongJae Park <sj@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>, Hugh Dickins <hughd@google.com>,
 Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-parisc@vger.kernel.org,
 linux-sgx@vger.kernel.org, etnaviv@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 kvm@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 nvdimm@lists.linux.dev, linux-mm@kvack.org, iommu@lists.linux.dev,
 linux-perf-users@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
 damon@lists.linux.dev, Pedro Falcato <pfalcato@suse.de>,
 Rik van Riel <riel@surriel.com>, Harry Yoo <harry@kernel.org>,
 Jann Horn <jannh@google.com>
Subject: Re: [PATCH 05/30] mm/rmap: update mm/interval_tree.c comments
Message-ID: <akKnNy64lhNqPtLL@gourry-fedora-PF4VCD3F>
References: <cover.1782735110.git.ljs@kernel.org>
 <80d482a927b2e9862487b812e0ab48ebc1289a70.1782735110.git.ljs@kernel.org>
 <akKWvnU2Ua-8ceSb@gourry-fedora-PF4VCD3F>
 <akKfAl-wdIAbexNR@lucifer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akKfAl-wdIAbexNR@lucifer>
X-Mailman-Approved-At: Tue, 30 Jun 2026 07:19:13 +0000
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

On Mon, Jun 29, 2026 at 05:41:16PM +0100, Lorenzo Stoakes wrote:
> On Mon, Jun 29, 2026 at 12:01:02PM -0400, Gregory Price wrote:
> > On Mon, Jun 29, 2026 at 01:23:16PM +0100, Lorenzo Stoakes wrote:
> > > Update the file comment to clarify that both file-backed and anonymous
> > > interval trees are provided, referencing the relevant data types for
> > > clarity.
> > >
> >
> > Isn't this self-evident by nature of the function definitions?
> > (one takes a vm_area_struct, the other takes an anon_vma_chain)
> 
> Well you see you're already hitting up on issues there, they both take an
> rb_root_cached and the vma_*() ones do not instantly scream 'file-backed' do
> they? As VMAs are obviously used for buth anon and file-backed...
> 
> But later patches fix this stuff :)
> 
> And I feel it's hard visually to see where one set of definitions end and
> another begins, which was really the motive for this, as trivial as it is!
> 

Fair enough, I scanned the rest initially but trying to wrap my head
around everything as i go through one by one.  Generally this really
screams "fix the apis" not "comment the bad ones" - but i suppose that's
the whole point here.

It's definitely an improvement either way.

Reviewed-by: Gregory Price <gourry@gourry.net>

~Gregory
