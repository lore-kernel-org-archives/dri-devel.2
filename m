Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C30F606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 16:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mIAvKWrp
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CCB4710EE9F;
	Mon, 16 Nov 2026 16:39:13 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 51BB110EE9F
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 16:39:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 82966601D4;
 Mon, 16 Nov 2026 16:39:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD0A1F000C4;
 Mon, 16 Nov 2026 16:38:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794847146;
 bh=lMR9qDrcuTjHQIrjpgVj0zhPv473ZEqMMWfCbIqm3Q0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mIAvKWrpblygY2gORXGuS+vgNMSQVSMyYMGIWMZc/H6+A5K1SRoMSSKhPXBmNJgcL
 mHah2e2gLJCrS2rxFDDsqYQDQN2FxJ5htDLRKrxn2bLKgTVEqpump37b2SIHvTGsNQ
 Ku5hQP3825SFJhmREJktFIa1+uNR3LVV36d53y4Pua2UL+tsbROoDeiW2EWcsiQjF8
 tMV5yx4cwz+87l8OdaVp1F+SRVxQXher8R55izBUPgHi/4VmsjOC/E29z/2iAVxVRe
 y35CyYf1mPlNrWcbpNKBstQFgnObG4iv555rXzHuoT41V85m42mMchmbA63X97Xt6w
 Q/i7Lj/aLTTvg==
Date: Mon, 16 Nov 2026 17:38:50 +0100
From: Lorenzo Pieralisi <lpieralisi@kernel.org>
To: Steven Price <steven.price@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Marc Zyngier <maz@kernel.org>, linux-coco@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>,
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
Message-ID: <avsxmk815rlqNstc@red-moon>
References: <20261104164555.3555725-1-aneesh.kumar@kernel.org>
 <20261104164555.3555725-15-aneesh.kumar@kernel.org>
 <86zevn1c9a.wl-maz@kernel.org> <yq5ah5huoteu.fsf@kernel.org>
 <87ld6x8zb7.wl-maz@kernel.org> <yq5apkw5xpnz.fsf@kernel.org>
 <avrgNBXDFMGL6dqO@red-moon>
 <f2e47b68-1aee-4d17-8b63-e67075e7a42e@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f2e47b68-1aee-4d17-8b63-e67075e7a42e@arm.com>
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

On Mon, Nov 16, 2026 at 03:32:25PM +0000, Steven Price wrote:

[...]

> >> Thanks for confirming. Can we handle the ITS platform-device conversion
> >> and the switch to DMA allocations in a separate series?
> >>
> >> The existing VPE L1 allocation path calls set_memory_decrypted() from
> >> the non-sleepable CPU-starting callback, even though
> >> set_memory_decrypted() can sleep. This issue predates the shared-granule
> >> allocator changes.
> > 
> > If I may ask, why does the existing code ends up calling set_memory_decrypt(),
> > or reworded, why does the VPE L1 allocation path goes through the ITS specific
> > allocation function rather than using alloc_pages() (as it was before
> > b08e2f42e86b5) ?
> 
> Because it needs to be accessible to the GIC "hardware". In this case
> the GIC is emulated by the hypervisor and the hypervisor for a realm can
> only see the unprotected memory.
> 
> Now I agree this is a little academic in practise because Linux (as a
> hypervisor) will not expose RVPEID - so allocate_vpe_l1_table() will
> early out. IIUC this would only actually be relevant in the case of
> nested virtualisation within a realm guest - which is a long way off if
> it ever happens.

That's what I was actually getting at.

> > Why did b08e2f42e86b5 patched allocate_vpe_l1_table() allocation and moved
> > it to using its_alloc_pages() ?
> 
> In that commit I simply changed all the allocation paths which were
> allocating memory to be visible to the GIC to use the new allocator. As
> we "know" that the GIC can only access "decrypted" memory. Admittedly
> that could easily change in the future - but my expectation is that it
> will only change with the switch to GICv5.

Yes. I just wanted to understand whether, for VPE tables, this is,
currently, a requirement.

> Of course what I missed was that this specific allocation uses
> GFP_ATOMIC and that set_memory_decrypted() can sleep. This wouldn't have
> shown up on any testing because of the early exit:
> 
>         if (!gic_rdists->has_rvpeid)
>                 return 0;

Understood, see above.

Thanks,
Lorenzo
