Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 193F7C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 06:09:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 72C2810E569;
	Wed,  8 Jul 2026 06:08:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YYX6AO3h";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6FC5610E569
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 06:08:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 55B016001D;
 Wed,  8 Jul 2026 06:08:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF84F1F000E9;
 Wed,  8 Jul 2026 06:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783490937;
 bh=QXYsrdEbQvlPjl1uht/h4kWy1QyDvVCqKoZYxI/q3SI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=YYX6AO3hdEi9m/q1XH47iSD+UNkPfg4oPc3zq2g2N5gushnNghyd8YHYTWiWtfJ5F
 NoRiADuOJYEKz/EofPKj7GCMxv8t+7/V7/l4olpJLPqG3KF+vwjoADJRLlxdXzvrrL
 /XxE/W1SxQ/S8ydJoa9OHQuZEg2q8mDOrGUmdB3ZrlagsAbqt4yC6M3oYA+b66VBFH
 ZIZtDOzvoUfnAnqXVCOow0sCjT1HUi+Rl74qFn5J/LjTqbRwPbt+cCd4F9rdRA9bnf
 NF/UHneHvyejQcc3ffXfS5eLTcqAbn8QciekgMmyeq3ElnjruRKuhcPAwY5DtsVNCa
 TvEisjAEmtmcw==
Date: Wed, 8 Jul 2026 09:08:36 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
Message-ID: <ak3pZG3GFLT1SSBh@kernel.org>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
 <akYs91INHMXMTI-t@willie-the-truck> <akZkuwktaXFTrASP@orome>
 <akaSJ5D98w2cHqb6@orome> <akftuw9NyRy36fXA@willie-the-truck>
 <akuvyu1Pq0ZVMZV0@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <akuvyu1Pq0ZVMZV0@orome>
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

On Mon, Jul 06, 2026 at 03:49:24PM +0200, Thierry Reding wrote:
> On Fri, Jul 03, 2026 at 06:13:31PM +0100, Will Deacon wrote:
> > >
> > > How about if I extract a common helper and provide set_memory_p() and
> > > set_memory_np() in terms of those. Those are available on x86 and
> > > PowerPC as well, so fairly standard. I suppose at that point we're
> > > closer to set_memory_valid().
> > 
> > Why not just call set_direct_map_invalid_noflush() +
> > flush_tlb_kernel_range() for each page? We already have APIs for this.
> 
> Having a "standard" helper with a fixed and documented purposed seemed
> like a preferable approach for this particular case. We also may want to
> make the driver that uses this buildable as a module, in which case we'd
> need to export these rather low-level APIs. And then there's also the
> fact that we typically call this on a rather large region of memory
> (usually something like 512 MiB), so doing it page-by-page is rather
> suboptimal.

There are discussions about adding numpages to set_direct_map, e.g.

https://lore.kernel.org/linux-mm/20260410151746.61150-2-kalyazin@amazon.com/
 
-- 
Sincerely yours,
Mike.
