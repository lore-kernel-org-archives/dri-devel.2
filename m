Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3B94606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 15:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZRYmaiq/
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F161D112DCE;
	Fri,  6 Nov 2026 15:30:28 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C87B112DCE
 for <dri-devel@lists.freedesktop.org>; Fri,  6 Nov 2026 15:30:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D825E411C6;
 Fri,  6 Nov 2026 15:30:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2E4D1F0089F;
 Fri,  6 Nov 2026 15:30:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793979021;
 bh=6ajX4lfiph+VivXIsw2riYK43KZT3Do0cgXxc26s8IY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=ZRYmaiq/u/SQjBF4ufiS7XCsUtIWBR8hL8WYwn3u9em1LPif/YCL7ChpmRJhgOyIX
 7IC3EXVPCAkmKpLit8fAZGhbU6zO4Vo41xdkh0y1FE4VLwuE7EJ30uktOPNCEggpHD
 MbD1RX7dmUIkjT1awTBDV15avM4RN85WC1q1el5mr5tbkabk3V6dhoZUlfF40LSpgk
 KGlR22lgb9rXJhGOGQUNnGEHkpSn3m9hgHzxauJLxhjdxnvoN5U5o3aZh72JhgeHUT
 8BdOqsA5VITYBbXwdbZ6w5prD5p1MVjT+3jhhqFtkmeHdpWI1SXbbXixdwYl6O4EkL
 ecOySiCRp0UYA==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Suzuki K Poulose <suzuki.poulose@arm.com>,
	linux-coco@lists.linux.dev
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>, Thomas Gleixner <tglx@kernel.org>,
 Will Deacon <will@kernel.org>, Russell King <linux@armlinux.org.uk>,
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
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org,
 kvmarm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v9 01/14] mm: Add an allocator for CoCo shared memory
In-Reply-To: <2e448ac1-7b4f-4d45-90db-dfe9dc5ad329@arm.com>
References: <20261104164555.3555725-1-aneesh.kumar@kernel.org>
 <20261104164555.3555725-2-aneesh.kumar@kernel.org>
 <2e448ac1-7b4f-4d45-90db-dfe9dc5ad329@arm.com>
Date: Fri, 06 Nov 2026 21:00:01 +0530
Message-ID: <yq5ald76ou4m.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
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

Suzuki K Poulose <suzuki.poulose@arm.com> writes:

> On 04/11/2026 16:45, Aneesh Kumar K.V (Arm) wrote:
>> Confidential-computing guests may require memory shared with the host to
>> be aligned and transitioned in units larger than PAGE_SIZE. Several DMA
>> users need struct page-backed allocations satisfying these requirements.
>> Provide a common allocator instead of requiring each user to open-code
>> this sequence.
>> 
>> Add alloc_cc_shared_pages() and its node-aware variant. The allocator
>> rounds the requested size to the architecture's shared granule,
>> allocates suitably aligned contiguous pages and transitions the
>> complete range to shared state. It also preserves the caller's GFP
>> policy.
>> 
>> A private-to-shared transition may alter memory contents. Mask
>> __GFP_ZERO from the underlying allocation and when requested, clear the
>> complete transitioned range after cc_make_shared() succeeds.
>
> This is not true for pKVM though. It is the other way around. i.e,
> pages must be cleared before transition (e.g., from private to shared)
> to make sure the contents don't leak into the host.
>
> Do we need to handle such cases with a pre_conversion and 
> post_conversion hook ?
>

Patch 2 does something similar.

-aneesh
