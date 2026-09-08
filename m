Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21BCEC79FA1
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 09:11:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2DB2110EAC4;
	Tue,  8 Sep 2026 09:11:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.b="SgPXJTy+";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6170510EAC4
 for <dri-devel@lists.freedesktop.org>; Tue,  8 Sep 2026 09:11:02 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-49d036e0e99so16242365e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 08 Sep 2026 02:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1788858660; x=1789463460;
 darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=jO5c4Bt3ZAdytp/EWde+NVli4TynjxjjAsIpB98Fp84=;
 b=SgPXJTy+WHaToLoSrw4CgXz/1k/qfOOqWcFV/sMM67zfNVeW/umCM5nGDOGlO+dHjc
 gJzplKwltDAunEFcSMgVQus8wa0/yZdDd0N9JKmCa+55iecgaQlhV4hIuMiwZn2FP1Vp
 pjIo22FNazZlhsxOExQUsSgz2x/XqAVYqNrOxN3AvCfZjzZ5w4VBsfdVyrJ3JreTvGcs
 Y5I3HcrYMzOrsMW9594UoJ50kVx0fhP8IJr/mqs9+kzSfPDh+LquyzEezulGtgLTpR3t
 g907VINA3YaOH40rInZcAK8vTKSw36MbZ+VpNdSgwjykHbdTHSyrwmR1xKx0ONelf9ZN
 nFJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788858660; x=1789463460;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jO5c4Bt3ZAdytp/EWde+NVli4TynjxjjAsIpB98Fp84=;
 b=LmSdc2TtKoq6jTHcU3F0klK5zdjpsch0rMVBMTsQGrSS/FaOYHV7ojxPg/aSVK4FCt
 lEfitbOyCOW0SDK0PQIRm6byaeOJOiJul6pEIA8yjtWN9dG2Y60v2Xs1Ds7SyGopRWB3
 9cO2aQjO4IHqfPS9ywkw6U41aYZqltbY5sbtJ/pWBidq5vW/4cddvvbnFpajp4lkUIqc
 OhL3LUdm7qtuEBZNSttcCwIKd8w6HmqiD9Rg5ub1/WUIEXWk0RBoRKhNCJfvlEnTcP+k
 vu5GXf843jxTIu1C9p+oaGuzQyfl/9/efncEsbue/jjQ5eQn3vYgs8NYa+/0YwTl/5Ya
 QwiA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz58aBPXfA0px+iCUND+F4KwNLxHz97i5a/mqomXYaSlRY+6qf8nJ4TVZeAe22+IpiaqfWLe437RT8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nroC9yDxgNoPgp3zvHgVgbqWiU7EZMXOtBBxq2NXhXU2STmb+C
 HdvDFr3DLBpO8X6dQaw0qvIRmUXEHjyNw+7QzZ4/Slqrm4ENM5meocN6x5JSJy9hvQ==
X-Gm-Gg: AYBFou0ZsHwuXR0TXEx9hJ8heYRKzNQdI+yGdyfQw5NxARwDTbDIQzM2DucCnydrvH2
 aYDWaw8D2fTu86E+mrzZOfU5luHykERNzIn3EyEMhaIVGjshkm8ncYqnNhZMc5Um82vF+/RL+IA
 W7cE0hqQwK2ZaCKixbDuaYN/jtBUV/Xrw8PkFukK2vzrnBb8w9jaeN0mGzTLoNHR7ZbHK7o0qE6
 iQsGPVSe3YlxjwEd4Ckey4Q6aUYeKL5y1/Sgv92h7L3fdsnzERqooUaSj5W23YmfbuclKRxUS0q
 7sxVPLTESoeB8uaswWRCU0Pbzis+1O/EA9KY11k1iQgBkHbcvGZO+FxgA0s2o1fDjyaolaKbaqf
 5y9rPHxjId3c1oxhCWtilE1yOM/zAqbhha99XhPkAWsx8yGlWVPs+JZAGSTijF+2XQlelzefll4
 Li3cLO8urzruer5+AOKc00PRw/vDR/bLgRIGO9xNu0tQ/ceb4BZfjDGPIgbDg8UhhaZutWU9i4B
 FBcAnrkqPVok7/hPw9tus224l2qIBBb0Mw6MsAbmE0=
X-Received: by 2002:a05:600c:1549:b0:499:a5fc:2087 with SMTP id
 5b1f17b1804b1-49cf81f47e6mr290181665e9.6.1788858659472; 
 Tue, 08 Sep 2026 02:10:59 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com.
 [104.155.91.135]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49cfd3f815bsm279081265e9.4.2026.09.08.02.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 02:10:58 -0700 (PDT)
Date: Tue, 8 Sep 2026 10:10:55 +0100
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
Message-ID: <ap_RH4ZDE3XI0rng@google.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <apquUWgrD9C2jWQ0@willie-the-truck> <ap_HzwVp-6aOKEbJ@orome>
 <ap_OFQepcu26g88u@google.com> <ap_QJG8EevX98SXa@orome>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ap_QJG8EevX98SXa@orome>
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

On Tue, Sep 08, 2026 at 11:08:26AM +0200, Thierry Reding wrote:
> On Tue, Sep 08, 2026 at 09:57:57AM +0100, Vincent Donnefort wrote:
> > On Tue, Sep 08, 2026 at 10:39:17AM +0200, Thierry Reding wrote:
> > > On Fri, Sep 04, 2026 at 12:41:05PM +0100, Will Deacon wrote:
> > > > Hi Thierry,
> > > > 
> > > > On Fri, Sep 04, 2026 at 12:44:51PM +0200, Thierry Reding wrote:
> > > > > This series adds support for the video protection region (VPR) used on
> > > > > Tegra SoC devices. It's a special region of memory that is protected
> > > > > from accesses by the CPU and used to store DRM protected content (both
> > > > > decrypted stream data as well as decoded video frames).
> > > > > 
> > > > > Patches 1 through 3 add DT binding documentation for the VPR and add the
> > > > > VPR to the list of memory-region items for display, host1x and NVDEC.
> > > > > 
> > > > > The set_direct_map_*_noflush() functions that will be used later in this
> > > > > series are exported in patch 4 so that the drivers that use them can be
> > > > > built as a module.
> > > > > 
> > > > > Patch 5 adds bitmap_allocate(), which is like bitmap_allocate_region()
> > > > > but works on sizes that are not a power of two.
> > > > > 
> > > > > The of_node_to_nid() function is exported in patch 6 because it is used
> > > > > in a later patch adding a driver that can be built as a module.
> > > > > 
> > > > > Patch 7 introduces new APIs needed by the Tegra VPR implementation that
> > > > > allow memory to be allocated at a fixed offset within a CMA area. Tegra
> > > > > VPR needs this in order to implement its own allocator on top of CMA to
> > > > > meet the strict hardware requirements. This replaces the dynamic CMA
> > > > > area creation patch from earlier versions.
> > > > 
> > > > Did you get a chance to see how this could work with Vincent's series:
> > > > 
> > > > https://lore.kernel.org/r/20260902104712.2399797-1-vdonnefort@google.com
> > > > 
> > > > ? I think that should remove your reliance on can_set_direct_map() and
> > > > mean that you can retain block mappings for most of the linear mapping.
> > > 
> > > I'm not sure if it would help all that much. Yes, if we mark the VPR
> > > region as LLMAP (or PTE_MAP, whichever it ends up being), it should make
> > > the checks for can_set_direct_map() redundant. However, from what I can
> > > tell, Vincent's series still forces page-granularity on these regions,
> > > so it won't retain block mappings at all for them.
> > > 
> > > The block mappings can be retained for the non-VPR memory, so that's
> > > nice. It also reduces the amount of external prerequisites, but I had
> > > kind of hoped that we could go one step further and keep block mappings
> > > even for the VPR memory if the region happened to be a multiple of the
> > > block size.
> > > 
> > > The recent addition of page count to the set_direct_map_*() functions
> > > helps reduce the amount of checks that need to be run, so maybe there's
> > > not too much to be gained from removing whole block mappings at once
> > > from the linear map.
> > > 
> > > Thierry
> > 
> > I should be able to add PMD_SIZE mapping support to the series. That was
> > actually my original idea as we can easily force the CMA allocation granule to
> > be PMD_SIZE too.
> > 
> > I didn't implement it as I thought there were not much interest in the end (and
> > also as contiguous.c is always using PAGE_SIZE granularity).
> > 
> > But now as I have implemented a specific pool (and do not use contiguous.c as
> > originally planned), if you believe it is important for the VPR driver, let me
> > see if I can extend the support in a V2.
> 
> I don't think it needs to be part of a v2 and can be a follow-up. It
> should be transparent from an API point of view and merely be an
> optimisation for that specific case.
> 
> Eventually it'd be nice to have, though it might also be worth checking
> what the actually gains are.
> 
> Thierry

Ack. I'll keep it as is then and we will see later how to extend it, if it is
necessary.

-- 
Vincent
