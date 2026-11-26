Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6548860A260D
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QgnQHuAm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CF5610E639;
	Thu, 26 Nov 2026 16:31:47 +0000 (UTC)
Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com
 [74.125.224.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADFE210E639
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 16:31:40 +0000 (UTC)
Received: by mail-yx1-f54.google.com with SMTP id
 956f58d0204a3-67c0bd676eeso5085028d50.3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 08:31:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795710699; x=1796315499; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=mKMGXbvF/sfX9s9vl5jaq/5p/tKCIj66clg+e7onQEc=;
 b=QgnQHuAmpFJXuv4qTn1YU1fKdNH1VAcgwODG408QMO+YN9XCgCJeMtERhEtfzeKw03
 9jrYL8mA0/D60X2zkNY61EOM8Ccoe+PZq8ooGlh8eVDb6unRfjAkPsYx6kEyQGzq0yGU
 1WiAfOAtqrHdy3eTDo1NYcl/v9PBeoWWNjhbja+W5rbFSkiRBNOrV6WSWIMl6WoYEOzU
 lfscuLSR5kWC2BOemYls1Wmxon06B9j27bVvTJ5KrDMpw/eXX16AmZ6otPYFJr2Q/23S
 IMjMedbEb/t7Ww8N6rDclxkq4OLepxwwAY++YfKcnF1urmDwFrB5i2eWSz8BbFsxSx4K
 ISrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795710699; x=1796315499;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=mKMGXbvF/sfX9s9vl5jaq/5p/tKCIj66clg+e7onQEc=;
 b=D0g5NBQADVrc4zDP4h9XGfwMlisPdu7HbH1XvI7TTQrADeEjMq/SqaqCdpJBaWUmZX
 zh+ehS/trHlm/mhg5xxM9Z8Qs24l4Gk/q99tPRldwcUygS86iuXWAzR2pwQnEhQgIW5n
 Ht24vzPw7z2cLn5gGEuDWRYV6wb/gPdShBWs5hBHcq9VbyL2quE3d9EzsTmMAoiQDm0l
 ZkFJUbfAhGq5W7UK0iJX/QKGca2LbkcUia/wUU9fJT/qTz/1XGk0WZOb0UZKAFGdVX25
 gLGm6do1Zx0HjG29UXCras8ZWTG0Yv+jVCLssdoLh2K1hhilQHWsKxZbNWXVgZII50E8
 TmNg==
X-Forwarded-Encrypted: i=1;
 AL+hErG/75AR+v+yT7hmRstG9C6Z30S4F2QDuWvsOf1VoRwL9UQcnxK6BS2gjNBjbw9S86JmarZBBxnAVtY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9+Pu8wB9gSrbdw+bUcMWpmHLMWA+zNR9bYZphbyBUvgE+pI79J
 DCH23NsB75ImHdnmMRdtG4dHNUz9Z+8zm0KxX3gtqMGT9ClPysfmwtVcXM1hF2QWO0U=
X-Gm-Gg: AZFdTZchxUA8bRX2V9LQ1qM21XoyR3OvW1jLVKI6TEv8mZpSWBq5XwzWel9GIPmGgou
 Y6lLfGxcjwHZE8kcfFSYPA4+aVfz0YqNe6O+4xaOVOKJN6PQoKaBoh43/AH54fKkJt4pyj+nPPK
 E21idUpFwH3n5tHSaW3aewWCtzWi2gqMw8e0hARjsnLP99sVsRyIl6LdvZENu8DcXo6D4KWHjNj
 O7zf1/SQJhoXVjBPiT/jXWvyACDNf3TNyc113j+dv7C059M3zlFLmUJOjm1SFCUastPsxvqXeu+
 3W+a0LO8yOnfITRS7k4KlTH35Rbqlz12QNJv2isYeNRm18fjPucK7MOXV2I6Yhlk43n7dUnkGaN
 2mOM6Z1ez88RFJgBST1ipy5ADmbdKK9BJUqa2jc6Dfxp95e9ZZEUOFFUSpVg6tlbHtPqW9K+oQb
 ebDFEIp86E7up0aVqNbedKVcxnvtJ+hP2KsxX3zPm/EnPlN85PHVZ/5JcCetBLDm3JeBDZAOuAT
 vh4/ajxnyfTQ/U1lQYCksWVzjpM69U9pllacYnVLvSWlAjaFp45Y+UsxdVK+Z1RfGqCPyFhbdWB
 yIpQ/Q==
X-Received: by 2002:a05:690e:13cb:b0:66f:c1be:a64f with SMTP id
 956f58d0204a3-67df4444c30mr10219064d50.65.1795710699306; 
 Thu, 26 Nov 2026 08:31:39 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a15b99sm192865986d6.38.2026.11.26.08.31.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 08:31:38 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xWcNl-00000004WQW-3ltS;
 Thu, 26 Nov 2026 12:31:37 -0400
Date: Thu, 26 Nov 2026 12:31:37 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, linux-coco@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Christian K?nig <christian.koenig@amd.com>,
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
 linux-mm@kvack.org, kvmarm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v10 04/13] irqchip/gic-v3-its: Allocate shared tables
 using CoCo shared memory allocator
Message-ID: <20261126163137.GQ246011@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-5-aneesh.kumar@kernel.org>
 <awQd81MwZqi55gf8@arm.com> <yq5aa4mybbmv.fsf@kernel.org>
 <20261124134621.GI9566@ziepe.ca> <awhVoDXluqpncgcd@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awhVoDXluqpncgcd@arm.com>
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

On Thu, Nov 26, 2026 at 03:52:00PM +0000, Catalin Marinas wrote:
> On Tue, Nov 24, 2026 at 09:46:21AM -0400, Jason Gunthorpe wrote:
> > On Tue, Nov 24, 2026 at 07:00:00PM +0530, Aneesh Kumar K.V wrote:
> > 
> > > Taking Jason's feedback into account, we could have the allocator
> > > request compound pages and recover the actual allocation order with
> > > compound_order(). That would avoid passing an order to free:
> > > 
> > > void *alloc_cc_shared_node(int nid, gfp_t gfp, unsigned int order);
> > > void *alloc_cc_shared(gfp_t gfp, unsigned int order);
> > > void free_cc_shared(void *addr);
> > 
> > It probably shouldn't be order here, that is hard to use. Just size_t
> > len
> > 
> > And round up internally
> 
> Minor point in favour of keeping the '_pages' naming and order is that
> it makes it more obvious what alignment is returned for code that needs
> it like the ITS. Otherwise we can just document it, I don't have a
> strong opinion either way (only that it's simpler than what was proposed
> earlier).

All our allocators return things aligned to their size, does ITS need
higher alignment than that?

Jason
