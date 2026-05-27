Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C52CCD4F54
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 19:10:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A37B610E2B0;
	Wed, 27 May 2026 19:10:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="b4ZQgk5E";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D33C810E2B0
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 19:10:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779909051;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fOfRGPugae13jAxurJtrxuSo8jWBso3MtJfxNQrI0Jc=;
 b=b4ZQgk5Egri2qBcCLwD0wfI5Hca+TXi0+3VBEQb66VWRp4itMv287UQdYbacd/1X+lj9Qi
 xB0tNnbqbpfCVs/2IPiNeeYj7GIyFGt9s8y+vHd8Y6aM5afZ2Bjcb7pqmSSrjrvKZsd0lL
 6flqPYrUL7Pt/mKfQK6f/alE+Xy3t1w=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-326-r_88i058Nvqu1oNrzQO06A-1; Wed, 27 May 2026 15:10:50 -0400
X-MC-Unique: r_88i058Nvqu1oNrzQO06A-1
X-Mimecast-MFC-AGG-ID: r_88i058Nvqu1oNrzQO06A_1779909050
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-516d51ffb59so37121441cf.3
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 12:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779909049; x=1780513849;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fOfRGPugae13jAxurJtrxuSo8jWBso3MtJfxNQrI0Jc=;
 b=FmdITrIIJoGlGIIEvzCxADO9Czt7+zMrds4zu+XgWvLHHGeoyz+ihBPjj6bPntTchX
 pzeLr5+B2mkmc0lDTtpbxT2WGaWoS5DJ/zpbIRIoBtF+yoBkZRpGXfLm5py39Jlircgs
 zNC0RtudYHeGiAP1JrgNElfw5EYBJEk4jk9HbD0KP9tNOYwPr6k4QdJsUy+zZmU0N0/v
 phYbPKW8bYQg9sMp0mgBzaEMb0skLcqRRj5YHr8g9spiZeplBirS431ZB3mc6BJByRD4
 nmURcIVZTWTCBIzhEhJjcRxdGyMk6upxiUuARi/ePGYsY5Uip7AX1XZs0WZiq12N63nR
 xhdA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9e797QgCVcUnbbd7j9ARLBHXWJ7JSrRx7CDyNqSm4/eVIe/jlJDCfNJYgnEF/o+VgYXte9XUvzclc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzvNfvAyvUb8IqDKCJ0PQsWEDKxoFixExRXwC4XfA4ZWAdSYcPK
 40WpIhRc6EFtfgRD1nCoC4rRBYXQF+x4ZH/iQ30a99QyUh3rE9lyMbGUS29abwaCMktSGwCepaM
 Ub2Yld9gzQT+Oq0o5aeGUOYIcKv26ivdLKlEjR5hj0Mre1lV1P6vo66dW8yE76WEbTR1gEw==
X-Gm-Gg: Acq92OGD3j4vQkNNZn31cWAPkTdkvvUxwJawNfpNICu5Ptsd1oWwySxgXRtWMJ48jVf
 CyFZZKELwAXmN2oyzAE0eTW2Ui+nothQEPNESFEeq6vYem6L+SExoREZGotV2A3ObyRYj2q8yEP
 nHLMeJG8QfGdzmcl7W3hMjzM4vu15G+KEl7RFZd5IuNXXa9OE+MCbi/yyfXtDQkGe4zrm3+VddG
 GVVBTcTqoh+o6kyV7deBD0Za96UITP6FXRbj5NIIHgHblnL2pF4OZnUfsY62AZ0obFY5BTOOaDR
 yY0iw6Hd22k3hIgSoGE2tsxINKiXErIwGd9gNNIoM3oKWP2el1QpQ1KGPX3PEKvOnDvhELM/jhN
 5QfhFmYcf860cwIhwGmTpQL0KlWk6koiMZ+qUmug8qpHalykwhcuEQ38q4bmmHtixBPEEv/JrVj
 dc
X-Received: by 2002:a05:622a:2d5:b0:516:4fc0:27ac with SMTP id
 d75a77b69052e-516d43e4561mr348875281cf.50.1779909049440; 
 Wed, 27 May 2026 12:10:49 -0700 (PDT)
X-Received: by 2002:a05:622a:2d5:b0:516:4fc0:27ac with SMTP id
 d75a77b69052e-516d43e4561mr348874431cf.50.1779909048607; 
 Wed, 27 May 2026 12:10:48 -0700 (PDT)
Received: from localhost (pool-100-17-21-205.bstnma.fios.verizon.net.
 [100.17.21.205]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-51706adc8f3sm51751971cf.18.2026.05.27.12.10.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 May 2026 12:10:47 -0700 (PDT)
Date: Wed, 27 May 2026 15:10:47 -0400
From: Eric Chanudet <echanude@redhat.com>
To: Shakeel Butt <shakeel.butt@linux.dev>
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
Message-ID: <ahWfypvuTVsB-pHQ@x1nano>
References: <20260519-cgroup-dmem-memcg-double-charge-v2-0-db4d1407062b@redhat.com>
 <20260519-cgroup-dmem-memcg-double-charge-v2-1-db4d1407062b@redhat.com>
 <ahB7pCu_G4vuswc0@linux.dev>
MIME-Version: 1.0
In-Reply-To: <ahB7pCu_G4vuswc0@linux.dev>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: VS4XzHE5Zu0qAQqp6XVJ0KG4MCCEounT5qHe11EKr4I_1779909050
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Sorry, I misunderstood Johannes' comment. I am not sure what to use
here. Since these are called from dmem.c, they don't have access to what
was allocated.

Looking at zswap, it uses obj_cgroup. I thought of resolving the
obj_cgroup from dmem_cgroup_try_charge and keep it in the
dmem_cgroup_pool_state, but that made me realize there is a catch with
this patch set, with something like:
A: +memory{max:32M}/+dmem
A/B: +memory{max:16M}

It gets the CSS from the dmem's cgroup with
  cgroup_get_e_css(cgrp, &memory_cgrp_subsys);
  mem_cgroup_from_css(mem_css);

Which would resolve to A's memcg and not enforce the memory.max limit
set in B when dmem.memcg is set for that region.

-- 
Eric Chanudet

