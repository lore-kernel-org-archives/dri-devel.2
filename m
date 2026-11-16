Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33C02606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 10:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KKO0GtmL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F18189452;
	Mon, 16 Nov 2026 10:51:54 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D53510E3D8
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 10:51:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 22640411BC;
 Mon, 16 Nov 2026 10:51:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA0D1F000C5;
 Mon, 16 Nov 2026 10:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794826308;
 bh=rny6q4V2AlEW+9be9hzTdzBqG+gm95vTnvqQb/sLFhY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=KKO0GtmLmo3FANikUbE0i8Y6q8f05SERDvSmxDTTrvZcguvwuOPJiERRLiY3km+p9
 zo6CwRf5CpRVfMsRxBO5VC7BJ8aswdfaLrTnWNGso8MYwfkMSlZlr/JCwl7Yb0DKYI
 eBWEl8S+pydXFjwbZYHaKbLWD1FXtNqR/hU+W0ogRIXX/8Ttqui5864q8rXI5QbV1c
 R6fnfNJlYbpdNAOv54aoayBIVtR/wby4m5kxP9JLbu1/7ECYHfn8X6ZW0o2rJV/Mfu
 EVIiWUPpZlAFacz9vc7Vc16Rny5Ozfd3TgFqBoUQmnJ8ExsrAtD4LpzCw5QASx/URm
 B8JnGpBuX+mvA==
Date: Mon, 16 Nov 2026 11:51:32 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Marc Zyngier <maz@kernel.org>, linux-coco@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>,
 Benjamin Gaignard <benjamin.gaignard@collabora.com>,
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>,
 Mark Rutland <mark.rutland@arm.com>, Radu Rendec <radu@rendec.net>,
 "T.J. Mercier" <tjmercier@google.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <chleroy@kernel.org>,
 Ritesh Harjani <ritesh.list@gmail.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H . Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau <kas@kernel.org>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 "K . Y . Srinivasan" <kys@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Long Li <longli@microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, kvmarm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v9 14/14] irqchip/gic-v3-its: Preallocate VPE L1 tables
Message-ID: <avrgNBXDFMGL6dqO@red-moon>
References: <20261104164555.3555725-1-aneesh.kumar@kernel.org>
 <20261104164555.3555725-15-aneesh.kumar@kernel.org>
 <86zevn1c9a.wl-maz@kernel.org> <yq5ah5huoteu.fsf@kernel.org>
 <87ld6x8zb7.wl-maz@kernel.org> <yq5apkw5xpnz.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5apkw5xpnz.fsf@kernel.org>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 11:51:04AM +0530, Aneesh Kumar K.V wrote:
> Marc Zyngier <maz@kernel.org> writes:
> 
> > On Fri, 06 Nov 2026 15:45:29 +0000,
> > Aneesh Kumar K.V <aneesh.kumar@kernel.org> wrote:
> >> 
> >> Marc Zyngier <maz@kernel.org> writes:
> >> 
> >> > On Wed, 04 Nov 2026 16:45:55 +0000,
> >> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> wrote:
> >> >> 
> >> >> VPE L1 tables are allocated from the CPU-starting callback, where sleeping is
> >> >> not allowed.  Remove the page allocation from this atomic path.
> >> >> 
> >> >> Use a blocking allocation for the boot CPU and record the resulting table
> >> >> order.  Allocate a page of that order from the sleepable CPU hotplug prepare
> >> >> stage for each secondary CPU.  Consume the preallocated page only when the CPU
> >> >> cannot inherit an existing redistributor or ITS table.
> >> >> 
> >> >> Reclaim unused preallocations after the CPU reaches the online state, and from
> >> >> the prepare-state teardown when CPU bring-up aborts.
> >> >
> >> > No. The way to do it is to move the ITS probing out of the
> >> > non-sleepable CPU hotplug path.
> >> >
> >> > I proposed a potential hack at [1] (which I find far more palatable
> >> > than this proposal), but the real fix is to probe the ITSs as
> >> > devices.
> >> >
> >> 
> >> Could you share a bit more detail on what you have in mind?
> >> 
> >> Are you suggesting that we create a platform device for each ITS and
> >> initialize it through the driver's probe callback, while the rest of the
> >> GIC initialization stays in the existing early boot path?
> >> 
> >> Would that mean the main GIC is operational during early boot, while
> >> ITS-dependent features, such as MSI delivery and direct injection, become
> >> available after the ITS devices probe?
> >> 
> >> Is that the split you have in mind?
> >
> > Yes. Then once this is done, all the tables become normal DMA
> > allocations, for which there should already be adequate support.
> >
> 
> Thanks for confirming. Can we handle the ITS platform-device conversion
> and the switch to DMA allocations in a separate series?
> 
> The existing VPE L1 allocation path calls set_memory_decrypted() from
> the non-sleepable CPU-starting callback, even though
> set_memory_decrypted() can sleep. This issue predates the shared-granule
> allocator changes.

If I may ask, why does the existing code ends up calling set_memory_decrypt(),
or reworded, why does the VPE L1 allocation path goes through the ITS specific
allocation function rather than using alloc_pages() (as it was before
b08e2f42e86b5) ?

Why did b08e2f42e86b5 patched allocate_vpe_l1_table() allocation and moved
it to using its_alloc_pages() ?

Thanks,
Lorenzo

> 
> Since fixing this properly needs a broader ITS rework, can we handle
> that separately and drop the preallocation patch from this series?
> 
> -aneesh
