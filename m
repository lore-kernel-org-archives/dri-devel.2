Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A1C9C5DF8C
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 20:44:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E859E10E327;
	Fri, 21 Aug 2026 20:44:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="vqpPNAUq";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0F64810E327
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 20:44:56 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-4956869750eso9757815e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1787345094; x=1787949894;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QzsO6bXfVkXRG/aUxfAmIkKsE+Fa964GVFQS62WZABw=;
 b=vqpPNAUq4SEmW5hMTWxZ9b3P6b3NiGZjPcq7gUuxfmVzjQRFrFFBHuCPV7RLcphHzJ
 pZvLwXOJvi3z9gX+/tIBU7uQ+8qU9p5H2yr4kHVy5xXk33ZXfQ9y6DKLm/ofdlf+qLi6
 HpRPypOr0y78qt+QddqhFGCWBljfjr5NMAXT09Hin0FmRyRV7Ce5lY9cVMrUypzBqsIV
 T3iYxFowUCO1taw6mt/K2Y6SQbyJHTVZb+bCM5sEBAIjvEJZRqvvadUepTt41/PMh6RW
 JoXOeZFRVZnwmwIZ2PiJwSb8aBydgv9s73+G27P3VpybMDDE2aAZ/f9Y39MDMCySkOQl
 CQVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787345094; x=1787949894;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QzsO6bXfVkXRG/aUxfAmIkKsE+Fa964GVFQS62WZABw=;
 b=glc5DFekh33eE/wWXKo9Bdze6E5nxEG3uaJxfmf7Es0QFDHm0VOwSe60kk0iEeZrFm
 Vb2zKFvvi1DCDkZg+m54PO4BFZo97frp20cRjnq8q1ei3KXzJVxSfHK/1GRyiENqfQYh
 7WLZSfbi/edpZh3RdsaXgdbyfEuZK3dOmYn3KerTl8TKGcACLsGvIbsLegxtp1i6jjGp
 ja2WMWCw/WP/rrv1QKAPHAk1VK6fI0LXSiCiGJBaMo2PdhRsDVWNY7vbPVZJGEM6WigC
 LrWyJGJbKQbvh4HrdgweQqY3jkKJTbJTqP/TvJEqcjb1x3OLZCI2IeQKJ/SshLzK8XRa
 jolg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqn7xYb4QufDM0EkHXXuYGNPE5tlrMFvxpyPHzFLAOeN2yC6Bc9g3seloh5YWgjT5WlASRUGFM5kPo=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l+MXGvEuvsWVuZ9z3LicQNyfDOIWvYk5EemtPJM5qb8Mffky3i
 mkZeJE1MQ2iMsz11Zxpfs8Ow71iUrjcXDgIjXxLAlnOdLZfKpiVFmI+5zF4aVq8g4Q==
X-Gm-Gg: AR+sD11hnPOS9rPgGBvCox8+Cz2xeCxcw4gso26Ko5KK/xyAAHn1eXhN6rGzyDaUXcX
 kjzrV7hyB1ULcNyLqsXsKFDi2Cb+DHaT6heuBFGazDF5/QvMLdWnzGsgNNEJZVdq0w0sgPdi4vC
 9MyHc3PvtnDsQvz9p+k1ak1YKFkd9TMgBl+Ntsf9g6Vme+W79I1ufqZ7YAtNJopFgiM9qOSrqFr
 7OGDwCLHQllVrXzrjA2CJQWdyVXCHpARb8OlV5qKRF50mu5Mh0N8+ufSKff5XumwmEqAf6gmq/g
 IvItgFNq1xOyo1YwmXhwbvVsyG+HUxynIScjnxLpmc6IXC506fgf60dm9fw1encThNVnv0l5yiV
 SI8IeXwmuOb8GA4a+7hoNK/JUwXReDdjERn8pcz9gFV0lfwBBoDAsRkIYr0GrZvl7OwH5WvxvRE
 eeO9xRDkeEmhqnrVQJDvdoWnkBIhL3yO2QFZi1nNCUMzrFyU6Z5yjUBMnYz7I9gF3OoxwiaU5Fr
 wm8ilNTkfk5sdeZ5zLEegtdsoYll/lD
X-Received: by 2002:a05:600c:548c:b0:499:8aff:59b6 with SMTP id
 5b1f17b1804b1-499c19f514emr11324295e9.14.1787345093778; 
 Fri, 21 Aug 2026 13:44:53 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com.
 [104.155.91.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499b911584bsm40454845e9.14.2026.08.21.13.44.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 13:44:52 -0700 (PDT)
Date: Fri, 21 Aug 2026 21:44:49 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Sowjanya Komatineni <skomatineni@nvidia.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>,
 Russell King <linux@armlinux.org.uk>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-trace-kernel@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH v4 07/10] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <aoi4wZJIutMWu9Ux@google.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com>
 <an4MEI7lkc2p3nKI@google.com> <an8K2gb1pIqbDj6-@orome>
 <aoNDRTKCUkzd2n5G@google.com> <aoQ1lhZojzsSkWHQ@orome>
 <aoVy8dj8f3ll5-M4@google.com> <aobOs0ZidWzgoHut@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aobOs0ZidWzgoHut@orome>
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

[...]

> > > Interesting. I had been thinking more along the lines of adding this
> > > directly into memblock using a new entry in enum memblock_flags. None of
> > > the existing ones seem to do what we need here, though some are closely
> > > related. MEMBLOCK_SECURE or MEMBLOCK_PROTECTED are quite specific and
> > > don't necessarily mean that we need the mapping to be page-granular, so
> > > MEMBLOCK_PAGE_GRANULAR is perhaps clearer.
> > 
> > I thought it would be interesting to not have to modify memblock since it is
> > used for all architectures, while the DT is at least slightly less widespread.
> 
> This isn't something that is DT specific. On the Tegra side, I suspect
> we might need this on ACPI platforms eventually, too. And it's not an
> ARM specific feature either. Other platforms could use shared carveouts,
> too.

Agreed, and actually I have tried the memblock version and it looks quite neat!

I will share what I have after the merge-window.

> 
> > Also, cma_init_reserved_mem() could use an order 9. In that case PTE-level isn't
> > necessary and we could just use PMD-level. Extending that support would be more
> > cumbersome with a memblock flag than with a callback.
> > 
> > rmem_cma_setup() hardcoding an order 0, perhaps this isn't really a problem at
> > the moment?
> 
> How so? memblock is really just used as a way of backing the CMA. How
> CMA subdivides it doesn't really matter, right?
> 
> Or are you suggesting that if we use an entire PMD as granularity, we
> could equally well remove the entire PMD from the linear mapping instead
> of doing it page-by-page? I think that'd work really well for at least
> VPR, since it is 1 MiB aligned anyway. Using a granularity of 2 MiB is
> easily doable.

Yes, that is what I meant. We could easily force a PMD-level mapping instead of
PTE-level one. But then that means declaring another memblock flag. 

> 
> For anything that doesn't require a single contiguous area to be
> protected this might be a bit more challenging since it potentially
> wastes a lot of memory. On the other hand, a lot of this is heavily
> custom code anyway, so the entire stack could be modified to make
> efficient use of this (i.e. userspace could allocate a larger chunk
> for a pool of buffers, etc.).
> 
> > But yeah, the alternative is to create a "memblock_mark_forcepte" (it seems
> > memblock_setclr_flag does split memblocks) and let of_reserved_mem call that
> > function. Finally the arm64 mmu code can simply check for the flag before
> > calling __map_memblock. Perhaps it isn't that bad in the end?
> 
> It sounds like the right level of abstraction to me. But I'm not too
> familiar with this code, so it'd be good to hear from the MM and/or ARM
> maintainers what they think about this.
> 
> [...]
> > I had in mind to extend "shared-dma-pool" to handle
> > set_direct_map_invalid_noflush()/set_direct_map_default_noflush() based on an
> > option. But perhaps it is better to create another separate driver. And VPR
> > needing a specific dma-heap driver anyway, it could call the direct-map
> > functions there too without relying on CMA to do anything?
> 
> I think it'd be nice to have separate APIs for this case where we know
> the memory region is already page-granular (or, I suppose, PMD granular)
> and removing from (or adding back to) the linear mapping is safe. That
> way we could avoid the checks for can_set_direct_map() for each page.
> 
> It'd also be nice to have a version that can update the protection bits
> for a range of pages (would map directly to update_range_prot()) instead
> of having to manually iterate over each page in a range.
>

How about?

  /* True if can_set_direct_map() or [start, end) is mapped at PTE-level */
  can_set_direct_map_range(phys_addr_t start, phys_addr_t end); 

  /* Must check can_set_direct_map() or can_set_direct_map_range() first */
  __set_direct_map_invalid_noflush(phys_addr_t start, phys_addr_t end)
  __set_direct_map_default_noflush(phys_addr_t start, phys_addr_t end)

> A good middle-ground might be to have helpers that do the grunt work and
> they can then be called from VPR and the shared-dma-pool drivers to have
> pages removed from the linear mapping. VPR and similar can then perform
> the hardware protection bits on top of that.

I believe between the reserved-memory attribute to force the last-level mappings
and the direct map functions above, there's enough for the VPR driver?

-- 
Vincent

> 
> Thierry
