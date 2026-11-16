Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AFD606A32A
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 14:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=USa/GFbD
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1611A10E6F0;
	Mon, 16 Nov 2026 14:03:12 +0000 (UTC)
Received: from mail-yx1-f42.google.com (mail-yx1-f42.google.com
 [74.125.224.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D977610E6F0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 14:03:05 +0000 (UTC)
Received: by mail-yx1-f42.google.com with SMTP id
 956f58d0204a3-67db23d8892so1451375d50.2
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 06:03:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1794837784; x=1795442584; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8htNjDuwhthg5uXuXp42Sb+r8eU4x+ykq7/WcmWSjZg=;
 b=USa/GFbDf+wuSurOXuq+R99zmrXeHwqKWgQW3+BwKUUmSk/0mOUVmZXgeD6veni5ko
 5zQKFKQfjwfHidgRrYFsYye2qEbA/DtJmLsEU259XUnanhxGred0e17+lQ5XGbdsv7MB
 ybWO+YHgLEfWx6qLbcZFojDMCzueWWefI0FSzhi2P3q5LmBYGBSQj1uc+eqj33rrFbQi
 hiJG/tINvieZEyjP3Fi9il2RJkbeZy74jNxPZtwnVZLQ772UAqk7AV7AP1GAEizv9JMl
 TKBsSgPn3jRV5kQkJdmhSoAA2bcVvZnYp/4rOuXK7PvHB8t3wk/vcRwhE+yCfxQ3xj4R
 UItA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794837784; x=1795442584;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8htNjDuwhthg5uXuXp42Sb+r8eU4x+ykq7/WcmWSjZg=;
 b=wO/14P2n7rsocEtFVkp+tNtoVcPvlokc+iDIXHV/LzuK/Gf30dTJiYzI1biwJriKjL
 6ktTWyjfQ1OdGPRfRnIgyvqRRSG7G8H7+v7w1Z/EXbc9cU8fLmPWoYFH8GyHYdT0TWhd
 sPvjQp2mwAzUhyqaVUVdSp2k7n1GWmMOhbZSYRkrup5bvjqOYg7nwaDj43zT45orwXBf
 AFQwhFJzhybGDI32NeUa7wv9mBROMlz6hxgbHwArI/BdlAGZSXMfoDopn7QDC+IwiRs/
 yX9HjDf/+GpdJmcdVbYfocOtALivoyU58eqgPocotkusv6/Bi/oCh2cnmBKD/Th5M32a
 Qwxw==
X-Forwarded-Encrypted: i=1;
 AL+hErH2y8sUZJcvspMk8mUlU4jseDSlkp4tJ3s+xViBSH6ZivszHThgBcxWzuO4NB+aIsOUh21UymCIXcE=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9lNCVz0vywgohrF+ajnoAyRSD0EU6l9Qbla9Re5ByoJlMZ2BNf
 /Ms/Yigw5GSNx9fnJeJ7JfbGVjhy3ObvqWxbHazGMksIRjWVXkG8YnsvgoBa0DfNe9E=
X-Gm-Gg: AZFdTZfeljNdNVOM1RXVVlRp+Xem4xtM2QFUUZ7aI5ZtONo6jaOlvEFZvC5plSlfObs
 wcGKNTGXcnapLrZD5u9gxkfWDj+FBaSV7LSxXpQiaEUbYxVOQ95DyaE4vRIdI/y7kHUnsRqTbF4
 3PPm/hvCQQ/7ZBByT1DYrlmznpU4jYvIhnAPPls2d+qYe+ScQeJfLfoGyif1oPVcTXD/o3pHe7m
 SglUDb0ScWbvgw6wN3GpDJq8oZ0dOZ3RrBWK9nMlfanr8KVAvxd8bBozdov9brz4CUqJWsgsMSa
 6NhRF/LD7FFa+AlJVKKdUWzb6jZkJoHj6KJyNIJSSAchKXw8CKYDiZob2WdkQ92PJSfWoeYhe9g
 /MgekJ0bMdmQ6JBO9uYiOnufIQCfA3U/NkTbiFwXw+yt1VLE6XG1OPUtVp5Dbb3eSulULs3zIbn
 wnpXJsx3Mx2a43o78SBSzVluPCbNd6zLIrfhb+v6da5+/VgO+1zXjZnbk37ObhEupxuHqsICS9t
 VRK4LDP1y9HgQHCsSw3f75TchbgVF49M9PwP2pZ6dXFKvLefhZ93nTNpQBpr6BTW2advK6cJcYy
 AKY1et/5p8S7fpLUeO4rB8QHat8=
X-Received: by 2002:a53:ccc7:0:b0:67b:f935:8639 with SMTP id
 956f58d0204a3-67d89787ecdmr4996887d50.63.1794837784278; 
 Mon, 16 Nov 2026 06:03:04 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9494c8b889csm858426085a.32.2026.11.16.06.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 06:03:00 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xSxIR-00000009Q2N-0sq0;
 Mon, 16 Nov 2026 10:02:59 -0400
Date: Mon, 16 Nov 2026 10:02:59 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Fuad Tabba <fuad.tabba@linux.dev>, linux-coco@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
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
 linux-mm@kvack.org, kvmarm@lists.linux.dev, patches@lists.linux.dev,
 Vincent Donnefort <vdonnefort@google.com>
Subject: Re: [PATCH v10 02/13] mm: Zero memory during shared memory transitions
Message-ID: <20261116140259.GL2532299@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-3-aneesh.kumar@kernel.org>
 <CA+EHjTw7QzzkQYKV3jyvW5mqZQMenTfm=kus9i87tYqACDOv0Q@mail.gmail.com>
 <yq5ah5hgyj1p.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5ah5hgyj1p.fsf@kernel.org>
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Nov 16, 2026 at 07:28:42PM +0530, Aneesh Kumar K.V wrote:
> Fuad Tabba <fuad.tabba@linux.dev> writes:
> 
> > Hi Aneesh,
> >
> > On Mon, 16 Nov 2026 at 09:12, Aneesh Kumar K.V (Arm)
> > <aneesh.kumar@kernel.org> wrote:
> > [...]
> >> Keep allocations on platforms without memory encryption on the ordinary page
> >> allocator path so the original GFP constraints, including __GFP_ZERO, remain
> >> intact. Remove post-transition memset() calls that are now redundant and
> >> explicitly clear allocations on paths where no transition occurs.
> >>
> >> This intentionally makes every private-to-shared transition destructive;
> >> callers can no longer use set_memory_decrypted() to preserve existing contents.
> >
> > pKVM shares memory in place, and a guest has to be able to share
> > memory it has already set up, as Vincent pointed out [1]. That was one
> > of the primary reasons for in-place conversion in guest_memfd.
> >
> > Cheers,
> > /fuad
> >
> > [1] https://lore.kernel.org/all/avro44jUWOARFzul@google.com/
> 
> 
> Thanks for catching this. We discussed it before, but I reached the
> opposite conclusion:
> 
> https://lore.kernel.org/all/yq5a5wzw2ree.fsf@kernel.org
> 
> My mistake. How do you suggest we handle this? We want to avoid zeroing
> pages multiple times with different CoCo configurations. For example, to
> allocate a zeroed page, we currently do:
> 
> alloc_pages(__GFP_ZERO)
> set_memory_decrypted()
> memset(0, PAGE_SIZE)

Just like you are wrapping set_memory_decrypted() in an allocator API
the user that wants to have the no-change sharing needs its own
special API too.

Then you can bury a special implementation for pkvm there.

Where is this special user in the kernel anyhow?

Jason
