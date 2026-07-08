Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCFEDC43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:23:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 398CF10E54F;
	Wed,  8 Jul 2026 06:23:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LGtbx85v";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F202F10E54F
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:23:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E50BC6001A;
 Wed,  8 Jul 2026 06:23:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90C7C1F000E9;
 Wed,  8 Jul 2026 06:22:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783491780;
 bh=WhJE5OuUUHCm7qpu+pDY+GZ63fKdVTQlvI+ddyPOyH8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LGtbx85v1aFTEcg8MP7ZNBwXODbxJUrGK5XMbNxHZthj1bawnpu/7anqV9DlZTTID
 otNtVvtpsO3VoicTwuOXqdziXuAyCM/og2X2BfPcxS/E1GoE3iuuGH9nMR8ELGeFxb
 XUP5XadBQwvxvwWx5VDeEWn4FKwW/DsRv71/lQ6OUo5vQTsj8Jp39fOqO0XAr/8Ayq
 h13iuJHwp8S8xP/Lo5nTx7lqfuav2YlDWI81VHSVMQ88VcSNXzoTk2T10wby+OVF51
 wjdgFe40bLWn9Amg6fgATfiCLi1Hp5Vjd0jvqtFYEtkpQNgJ5MAZS4fnhDnBUeUB3R
 Y9Zv/zyiYnJoA==
Date: Wed, 8 Jul 2026 09:22:40 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>, Thierry Reding <thierry.reding@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
 Vlastimil Babka <vbabka@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 "T.J. Mercier" <tjmercier@google.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-trace-kernel@vger.kernel.org,
 Thierry Reding <treding@nvidia.com>, Chun Ng <chunn@nvidia.com>
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
Message-ID: <ak3ssP3_gDIwu1VG@kernel.org>
References: <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
 <akYs91INHMXMTI-t@willie-the-truck> <akZkuwktaXFTrASP@orome>
 <akaSJ5D98w2cHqb6@orome> <akftuw9NyRy36fXA@willie-the-truck>
 <akuvyu1Pq0ZVMZV0@orome> <akzikTrmhMsvkNVY@willie-the-truck>
 <b0a1bdd7-46ab-4025-8775-c9273892444e@arm.com>
 <ak0A6eLp0Pw8iKK0@kernel.org>
 <f6e8b4d4-8b50-4cc7-b264-ae39929c619a@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f6e8b4d4-8b50-4cc7-b264-ae39929c619a@arm.com>
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

On Tue, Jul 07, 2026 at 03:15:24PM +0100, Robin Murphy wrote:
> On 07/07/2026 2:36 pm, Mike Rapoport wrote:
> > On Tue, Jul 07, 2026 at 02:17:29PM +0100, Robin Murphy wrote:
> > > 
> > > Given the precedent of memblock_mark_nomap(), as long as the reusable
> > > reserved-memory regions also get split into distinct memblocks, then it
> > > seems like in principle we ought to be able to give them a new
> > > MEMBLOCK_PTEMAP (or whatever) flag which could then be picked up in
> > > map_mem() without needing to override force_pte_mapping() globally?
> > 
> > Please don't. _nomap() caused enough pain.
> 
> Indeed I was there for pretty much the whole pfn_valid() saga :)
> 
> Bad example maybe - in this case the only actual similarity to nomap would
> be the fact that it would also be set by the of_reserved_mem code based on
> what it finds in DT; in all other aspects it should be functionally closer
> to something like MEMBLOCK_RSRV_NOINIT, i.e. just carrying information
> through the mm init phase, then ceasing to matter at all once the linear
> mapping is done.

Sounds simpler than nomap indeed :)

Although I'm not sure it won't be required after mm init in some way. There
is already a suggestion to allow collapsing PTE mappings into PMD in the
linear map [1] and it already adds a use-case for runtime check for
MEMBLOCK_PTEMAP.

That said, I don't hate the idea. The only thing is that such flag would be
very much arm64 specific. 
I've been thinking for a while about splitting memblock flags to generic
and arch-specific parts and if you decide to take a memblock flag route it
seems like a good use case for memblock_{set,clear}_arch_flags().

[1] https://lore.kernel.org/linux-mm/20260611130144.1385343-7-abarnas@google.com/
 
> Cheers,
> Robin.

-- 
Sincerely yours,
Mike.
