Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC6D606A8AB
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aWr6K2YH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C551110E9F7;
	Mon, 16 Nov 2026 13:59:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0D910E9F7
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:59:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9C9A143076;
 Mon, 16 Nov 2026 13:59:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15DFD1F000C9;
 Mon, 16 Nov 2026 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794837543;
 bh=lgfzmSZN2nQ6JXjZlO2C+3pfQzKvR/nXPua0MzMaI+M=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date;
 b=aWr6K2YHdoXcwe5G15aCFhZ9sJlbcxn9bWbL4b781difDMlYQzJSng+FnIzKjYXQa
 kP8L94t8V3QaOcUvH9XQps+7mTljEEvhwDEaEIbQk2lBBXHEAmFq74yJz2F1y0izik
 u7hYsvyWRMV4KIAfnowrzgMKyriFTaH/dDaSLnzEhkJbQkgp0wnSWqvw+bp3KeFxIV
 je+SE20GH3FBOaebGv8YoBP7i7rGDsnBvJef2R5uPw9+ffHl9acZ1qRXRLVUeW23aX
 32ckSphdHr/1uOXnvGZxo3CxKWliFJWYH+GIZ+IN7iN5aUgy2a+eAqRSZm6JJpymr1
 5Op7/OQosYq4w==
X-Mailer: emacs 31.1 (via feedmail 11-beta-1 I)
From: Aneesh Kumar K.V <aneesh.kumar@kernel.org>
To: Fuad Tabba <fuad.tabba@linux.dev>
Cc: linux-coco@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian =?utf-8?Q?K=C3=B6nig?= <christian.koenig@amd.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
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
 Haiyang Zhang <haiyangz@microsoft.com>, Wei Liu <wei.liu@kernel.org>,
 Dexuan Cui <decui@microsoft.com>, Long Li <longli@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linaro-mm-sig@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org,
 kvmarm@lists.linux.dev, patches@lists.linux.dev,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v10 02/13] mm: Zero memory during shared memory transitions
In-Reply-To: <CA+EHjTw7QzzkQYKV3jyvW5mqZQMenTfm=kus9i87tYqACDOv0Q@mail.gmail.com>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-3-aneesh.kumar@kernel.org>
 <CA+EHjTw7QzzkQYKV3jyvW5mqZQMenTfm=kus9i87tYqACDOv0Q@mail.gmail.com>
Date: Mon, 16 Nov 2026 19:28:42 +0530
Message-ID: <yq5ah5hgyj1p.fsf@kernel.org>
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

Fuad Tabba <fuad.tabba@linux.dev> writes:

> Hi Aneesh,
>
> On Mon, 16 Nov 2026 at 09:12, Aneesh Kumar K.V (Arm)
> <aneesh.kumar@kernel.org> wrote:
> [...]
>> Keep allocations on platforms without memory encryption on the ordinary page
>> allocator path so the original GFP constraints, including __GFP_ZERO, remain
>> intact. Remove post-transition memset() calls that are now redundant and
>> explicitly clear allocations on paths where no transition occurs.
>>
>> This intentionally makes every private-to-shared transition destructive;
>> callers can no longer use set_memory_decrypted() to preserve existing contents.
>
> pKVM shares memory in place, and a guest has to be able to share
> memory it has already set up, as Vincent pointed out [1]. That was one
> of the primary reasons for in-place conversion in guest_memfd.
>
> Cheers,
> /fuad
>
> [1] https://lore.kernel.org/all/avro44jUWOARFzul@google.com/


Thanks for catching this. We discussed it before, but I reached the
opposite conclusion:

https://lore.kernel.org/all/yq5a5wzw2ree.fsf@kernel.org

My mistake. How do you suggest we handle this? We want to avoid zeroing
pages multiple times with different CoCo configurations. For example, to
allocate a zeroed page, we currently do:

alloc_pages(__GFP_ZERO)
set_memory_decrypted()
memset(0, PAGE_SIZE)

Should we do something like 

https://lore.kernel.org/all/yq5aa4p82sqt.fsf@kernel.org/

-anees
