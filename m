Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75C49CD5BB3
	for <dri-devel@archiver.kernel.org>; Fri, 22 May 2026 16:04:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C694F10E344;
	Fri, 22 May 2026 16:04:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.dev header.i=@linux.dev header.b="DLLwgfn3";
	dkim-atps=neutral
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com
 [95.215.58.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D11FD10E344
 for <dri-devel@lists.freedesktop.org>; Fri, 22 May 2026 16:04:47 +0000 (UTC)
Date: Fri, 22 May 2026 08:55:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1779465367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HPSb2CFFD2Mx/U8TkBhKdYznfpouLwmrB1wpwkrvRlU=;
 b=DLLwgfn3zamt0KOTjOJsQrjCumqI5g0pw3M+sc1H23Reczm/g6BnVx6n82nqbHGNdQcw+9
 mQ6g1ovyGU9uguzlNk8c6ewC0+hWaPbb+fqRFQui1CP4pwOxfebWERMoBeUAyKOkipNQkc
 RdOJlqwu/CiIyhBmejVUjbyGNOi6Yb4=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Eric Chanudet <echanude@redhat.com>
Cc: Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
 Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>,
 Andrew Morton <akpm@linux-foundation.org>, Maarten Lankhorst <dev@lankhorst.se>,
 Maxime Ripard <mripard@kernel.org>, Natalie Vock <natalie.vock@gmx.de>,
 Tejun Heo <tj@kernel.org>, 
 Michal =?utf-8?Q?Koutn=C3=BD?= <mkoutny@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, cgroups@vger.kernel.org,
 linux-mm@kvack.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>, 
 Maxime Ripard <mripard@redhat.com>, Albert Esteve <aesteve@redhat.com>, 
 Dave Airlie <airlied@gmail.com>, linux-doc@vger.kernel.org
Subject: Re: [PATCH v2 1/2] mm/memcontrol: add dmem charge/uncharge functions
Message-ID: <ahB8OhgdPgOkzuS9@linux.dev>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
 <ahB7pCu_G4vuswc0@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ahB7pCu_G4vuswc0@linux.dev>
X-Migadu-Flow: FLOW_OUT
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

On Fri, May 22, 2026 at 08:53:10AM -0700, Shakeel Butt wrote:
> On Tue, May 19, 2026 at 11:59:01AM -0400, Eric Chanudet wrote:
> > Add mem_cgroup_dmem_charge() and mem_cgroup_dmem_uncharge() to allow
> > dmem pool allocations to optionally be double-charged against the memory
> > controller. Take the struct cgroup from the dmem pool's css as there is
> > no convenient object exported to represent these allocations. These will
> > resolve the effective memory css from that cgroup and perform the
> > charge.
> > 
> > Introduce a MEMCG_DMEM stat counter to memory.stat to make the cgroup's
> > dmem charge visible.
> > 
> > Signed-off-by: Eric Chanudet <echanude@redhat.com>
> > ---
> >  include/linux/memcontrol.h | 16 ++++++++++++
> >  mm/memcontrol.c            | 65 ++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 81 insertions(+)
> > 
> > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > index dc3fa687759b45748b2acee6d7f43da325eb50c1..8e1d49b87fb64e6114f3eb920293e14920290fe7 100644
> > --- a/include/linux/memcontrol.h
> > +++ b/include/linux/memcontrol.h
> > @@ -39,6 +39,7 @@ enum memcg_stat_item {
> >  	MEMCG_ZSWAP_B,
> >  	MEMCG_ZSWAPPED,
> >  	MEMCG_ZSWAP_INCOMP,
> > +	MEMCG_DMEM,
> >  	MEMCG_NR_STAT,
> >  };
> >  
> > @@ -1872,6 +1873,21 @@ static inline bool mem_cgroup_zswap_writeback_enabled(struct mem_cgroup *memcg)
> >  }
> >  #endif
> >  
> > +#if defined(CONFIG_MEMCG) && defined(CONFIG_CGROUP_DMEM)
> > +bool mem_cgroup_dmem_charge(struct cgroup *cgrp, unsigned int nr_pages,
> > +			    gfp_t gfp_mask);
> > +void mem_cgroup_dmem_uncharge(struct cgroup *cgrp, unsigned int nr_pages);
> > +#else
> > +static inline bool mem_cgroup_dmem_charge(struct cgroup *cgrp,
> > +					  unsigned int nr_pages, gfp_t gfp_mask)
> 
> Please follow Johannes's request to pass the actually memory object instead of
> naked numbers.
> 

Also what exactly is the backing memory here? Is it system memory? If yes, then
you need to pass struct page. For non-system memory, I am not sure memcg is the
right place to charge such memory.
