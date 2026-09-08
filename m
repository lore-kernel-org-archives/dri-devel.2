Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9FBC79FA0
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 08:58:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13B8110E0C7;
	Tue,  8 Sep 2026 08:58:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="hXOT2xmN";
	dkim-atps=neutral
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C4A210E81A
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 08:58:03 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id
 5b1f17b1804b1-4956869750eso39137685e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 01:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788857882; x=1789462682;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1zFe5CkdviVdWpTUjRsL71ghioltrlS4PEP9q+np+JE=;
 b=hXOT2xmNkkJWt6tkoSz6nBpNH3tJi5dD779RuPmBwfGk9rl7I63qjok0hDf2zmqyNA
 7gFOwlkpSEj0gq1+v20PDjyVX0sSsJQ1AXyyvf5DBceXwYgY6iEGgAJUetMhNU+WKLvU
 ULR+nrH7Zg8ZCPfszeErZhVvDZ4ZrcsOwscIFrCU7BuD54007szorRVBBKyf32sfEkws
 jUK3CB4y5EttWdX5pS62cjKIf7C6Cz2EcUrdbtkf/5jSI4ahuJo4fCTzJtv58x2WNIfy
 7RFL0efWG5RqfmRsToJB9XFTk/OfpUuoMaeVnOWlrfKuMFs2vUKioKSLx1ro1hheqIqy
 g48Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788857882; x=1789462682;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1zFe5CkdviVdWpTUjRsL71ghioltrlS4PEP9q+np+JE=;
 b=sYnwOBtepTfelg6F4GuP1l2FWWbuiwNvBW8q/pFJADdOfs+ZFEJ1zLI6cXwKbp+GO6
 GtV+YWWRPBUzG1vX/qYm9lMD3VfsVw4HmTcTxQLuFKfzlrKab3/8TGulEbPI3mlptJky
 WWoZ3y4WFQsR8j0vhook56X+rn2KWQFYQp/I3DAZn4vctBZg9X/FPDVH6WHfQ7qnJT1M
 mUa4q88uiTvm14QPF8OhmplK7RFDx2FuMTyhPhU14AvD3hAq9jCfXIzFHk4SS6E4fQVC
 C1+4ockgvf3MyAvn3io8REneFdcHcZcjBJIq+1LnjibmoSrEk0OwWKrEM84OC/ii5NuR
 ec5g==
X-Forwarded-Encrypted: i=1;
 AKwUvBx7UsfBTe9p6WWEqtVHWFCo8/QNCM0/wVF9Cwa6mQBpweum8t6jBoYBqsr8xPkZF3wsNCV6gyGZQNs=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nkIF05nVJj8PnFGnzeGgf23YZKU5zxqGusgTdTtIf16z1zsgBK
 kBYeaMPYhWZif5F2fQHVaRu9uDAPmkvl+Ap1ArSHCILAjdEJXBVE6Sx+oidoLjhcUw==
X-Gm-Gg: AYBFou0X/fzJeJBpU0OJGPt+boyERwtOe7kITJei3+LzscXq5nOT8B5CkoHBBKmB1QG
 5i6UhyqRxvBVyxGinNZyyNCJ2qkbYcj/KiXPoBfL3mMoR/QSOx7m8NX755/4Mmr6Ily8xZNqE/w
 73+YK3KiZl6/dVHYJxX3LmsUd6evAoEDhbh1AOR7d4UOd4s+ImALO9nAs4KvhVdh411jJ7z6PDC
 z2orlQR8Cj+ra1ZJtKiXqfrxr8LeSQTNFL42dYbePohn8OdfOlxqeEyC5C12H1Bkmt9RJv4hiOB
 jI82Tn5+UXQsbHZg/pdCXh3Tu7w30e7RLSDDvhJezhLbNsJQBkQrNAY08/RcGw4N8tUbzldrGX+
 nhdamekvzxiNt55Ls0ld8gNz/QNFiYLFF1KAKcQXO756QsB6yanAvmnlyK0NKmXsm+oV1aNvTNs
 iMYRG6LrSelNnmagK9bEYrkWL6laPJZmjIAHlgRuwZVJ4eyaq8vIg8hoaP2XspE5x++FpJ7FTWN
 NW+4MgL3NREuexx4Xxupp+xP0VNLma4Vw==
X-Received: by 2002:a05:600c:4713:b0:49c:fa20:cc00 with SMTP id
 5b1f17b1804b1-49cfa20cd4dmr257500325e9.23.1788857881099; 
 Tue, 08 Sep 2026 01:58:01 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com.
 [104.155.91.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cee5f912esm476174585e9.4.2026.09.08.01.58.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 01:58:00 -0700 (PDT)
Date: Tue, 8 Sep 2026 09:57:57 +0100
From: Vincent Donnefort <vdonnefort@google.com>
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
 Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>,
 Saravana Kannan <saravanak@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-mm@kvack.org,
 iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 00/12] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <ap_OFQepcu26g88u@google.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <apquUWgrD9C2jWQ0@willie-the-truck> <ap_HzwVp-6aOKEbJ@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_HzwVp-6aOKEbJ@orome>
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

On Tue, Sep 08, 2026 at 10:39:17AM +0200, Thierry Reding wrote:
> On Fri, Sep 04, 2026 at 12:41:05PM +0100, Will Deacon wrote:
> > Hi Thierry,
> > 
> > On Fri, Sep 04, 2026 at 12:44:51PM +0200, Thierry Reding wrote:
> > > This series adds support for the video protection region (VPR) used on
> > > Tegra SoC devices. It's a special region of memory that is protected
> > > from accesses by the CPU and used to store DRM protected content (both
> > > decrypted stream data as well as decoded video frames).
> > > 
> > > Patches 1 through 3 add DT binding documentation for the VPR and add the
> > > VPR to the list of memory-region items for display, host1x and NVDEC.
> > > 
> > > The set_direct_map_*_noflush() functions that will be used later in this
> > > series are exported in patch 4 so that the drivers that use them can be
> > > built as a module.
> > > 
> > > Patch 5 adds bitmap_allocate(), which is like bitmap_allocate_region()
> > > but works on sizes that are not a power of two.
> > > 
> > > The of_node_to_nid() function is exported in patch 6 because it is used
> > > in a later patch adding a driver that can be built as a module.
> > > 
> > > Patch 7 introduces new APIs needed by the Tegra VPR implementation that
> > > allow memory to be allocated at a fixed offset within a CMA area. Tegra
> > > VPR needs this in order to implement its own allocator on top of CMA to
> > > meet the strict hardware requirements. This replaces the dynamic CMA
> > > area creation patch from earlier versions.
> > 
> > Did you get a chance to see how this could work with Vincent's series:
> > 
> > https://lore.kernel.org/r/20260902104712.2399797-1-vdonnefort@google.com
> > 
> > ? I think that should remove your reliance on can_set_direct_map() and
> > mean that you can retain block mappings for most of the linear mapping.
> 
> I'm not sure if it would help all that much. Yes, if we mark the VPR
> region as LLMAP (or PTE_MAP, whichever it ends up being), it should make
> the checks for can_set_direct_map() redundant. However, from what I can
> tell, Vincent's series still forces page-granularity on these regions,
> so it won't retain block mappings at all for them.
> 
> The block mappings can be retained for the non-VPR memory, so that's
> nice. It also reduces the amount of external prerequisites, but I had
> kind of hoped that we could go one step further and keep block mappings
> even for the VPR memory if the region happened to be a multiple of the
> block size.
> 
> The recent addition of page count to the set_direct_map_*() functions
> helps reduce the amount of checks that need to be run, so maybe there's
> not too much to be gained from removing whole block mappings at once
> from the linear map.
> 
> Thierry

I should be able to add PMD_SIZE mapping support to the series. That was
actually my original idea as we can easily force the CMA allocation granule to
be PMD_SIZE too.

I didn't implement it as I thought there were not much interest in the end (and
also as contiguous.c is always using PAGE_SIZE granularity).

But now as I have implemented a specific pool (and do not use contiguous.c as
originally planned), if you believe it is important for the VPR driver, let me
see if I can extend the support in a V2.

-- 
Vincent
