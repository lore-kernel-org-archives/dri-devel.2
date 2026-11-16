Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76767606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 13:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=mj1vewlo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D9CB310E4A5;
	Mon, 16 Nov 2026 13:23:02 +0000 (UTC)
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com
 [209.85.160.173])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC0C510E9EF
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 13:22:56 +0000 (UTC)
Received: by mail-qt1-f173.google.com with SMTP id
 d75a77b69052e-5569551d19dso58960271cf.0
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Nov 2026 05:22:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1794835375; x=1795440175; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ip0og70Tt8f+28eOZ5F6oTc6DjrtMrQ1wymW+Uokrdw=;
 b=mj1vewloWZePadRBV/lkLwEKR7+xAXbV7kOMP6riiGvRfHjFRiSZ2TuDDeA2bwz3IB
 jQInEfLVp+pNZLdM/CVVLZbUojBTUUAzgK0MsNYqqxevBkEsCcLkrrpnIVEb8fBQjaM1
 V86LuYtyeuO9x70ESKZNXTB7skhKc+1mhRJBBoZyjm3x+M7W/FZ+EiRxIGz/qz4LvDBn
 vUK/9oDDnTJZDFBsPpawFadBxSqc4gRnRU9hMh5LlI0SKKCjw/jlXdTHnIx2PkotmjP1
 fQfZhco5OgLzQRNDZomdTcGbrs9YzozgoL1NwFMgG7Uq7co1AYr4cf2Bmg12etmiK9z+
 xC2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794835375; x=1795440175;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ip0og70Tt8f+28eOZ5F6oTc6DjrtMrQ1wymW+Uokrdw=;
 b=vTZ18wrCX1xXgu69ofZV6kk3cidHSbMv0qgBGc2rNsn0Lw9utnMJasD8uSyUEfXLzt
 m0p6WIgiKFjLuHbABA1j0eI7/mLUTBHjHjDvLRqQPHDeTUhWPC/qOGguf7DgWb2JhZ11
 QVdJGh3QouEtx9FuqHCg7YCIT0z3nWVMJ6HP7FTb9ho2p2HsQx+D07qeH9OphMqOBUia
 SlX+FHCdbLeM2zqcdIbJ3UoqcHGtT6QlJt/4D6sFuj8pRZsjzOkRRD1eSlWrkYX84phD
 RwNaCKmUZyT6t3VjVfDC9p1WmQR6n7ezh01T4xymSxYfSC/kC++67+1eEGag7SrNxyZQ
 JCIg==
X-Forwarded-Encrypted: i=1;
 AL+hErFOg41gm8wbeTTA6Oa/k9qEHqBiVy+8FalYvsfK82hMQbyt5Zcz6gUTbdSFJt976pJji4lW5p7I4Ik=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+3VobDIwQ0FGTY4QujTtIdHeTqZZSc8Pw/pL1AFxS3XyqYsZrP
 h1rTw5rDl0rrLIlmdN9TCg/1lPDmmeGBZtfLXPllKGtGmsL2R/pU+zRDETpD36/Xvpc=
X-Gm-Gg: AYBFou24kUeYMELm+ehCbP3NUFhMO+1z2jQRIVa8SEDdb5Wd+2CIROMDOBc1a0ghca1
 Wp2yyFz9Y6JKMGJGEwR74NXI/OfHZRkzzvAYYfCjEWRlDnimeGrwnvYpdqjNZqyq3UQKtVFDLT/
 GIv19YJVjS1CT7qtAbYaLAdWfzf48NLzBxpPW+WsPeQLYhWOl7vnLnNK7nzJRGtZct9MMiujXKt
 mNJWqWr9jFvAK2PU6kuDzvBr1hgBAVa7hgi41Rl38T6+lxWhYH06xMtdINqvTZi/I0iTvP3WW7N
 Nt4heYYY1p0GBNOFVDnC3Gs4Z55c0CAel/l2V4fUpD7wzRfiKDtlaV9OabV7jbdz/45E9sYaST8
 AFiovItpr2VudyeoNkrsCVgf3ZaYgsSVROGB6WfvneINJJko9KG1vIQdXxHFIXZVm/6yqdMPQ8x
 efWnjOlRBAnFSFlhRbAA+vm8CotpvjHJAakswt4Nn/DNPfEBS1QoWm/lr2myPp4KHR9a9Nt29or
 UpMXf03Fa+/mo/isjU1AVWpS0ZynPRAdXauu083rhdXzNXyL1x/llRAUqLRssGcWeUZLSlxZAN8
 P/Z4Kw==
X-Received: by 2002:a05:622a:e190:20b0:55b:9d8d:f29e with SMTP id
 d75a77b69052e-55b9d8df528mr93734571cf.9.1794835373441; 
 Mon, 16 Nov 2026 05:22:53 -0800 (PST)
Received: from ziepe.ca ([142.166.156.71]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55ad0f07afesm80824241cf.16.2026.11.16.05.22.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2026 05:22:52 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xSwfb-00000009Kvw-33KL;
 Mon, 16 Nov 2026 09:22:51 -0400
Date: Mon, 16 Nov 2026 09:22:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Suzuki K Poulose <suzuki.poulose@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian =?utf-8?B?S8O2bmln?= <christian.koenig@amd.com>,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
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
 Alexey Kardashevskiy <aik@amd.com>,
 Michael Roth <michael.roth@amd.com>, pankaj.gupta@amd.com
Subject: Re: [PATCH v10 00/13] coco: guest: Add a shared-granule allocator
 for host-shared memory
Message-ID: <20261116132251.GJ2532299@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <0524abf4-2306-4046-aade-c23aa7d1e0e6@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0524abf4-2306-4046-aade-c23aa7d1e0e6@arm.com>
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

On Mon, Nov 16, 2026 at 10:09:35AM +0000, Suzuki K Poulose wrote:
> Cc Michael Roth, Alexey, Pankaj Gupta
> 
> On 16/11/2026 09:11, Aneesh Kumar K.V (Arm) wrote:
> > 
> > This series tightens the alignment requirements for buffers that are shared
> > between confidential-computing guests and the host, and adds a common
> > allocator for host-shared memory.
> > 
> > When a guest runs with private memory, buffers shared with the hypervisor
> > are not only accessed by the guest. They are also accessed by the host
> > kernel, and the host may manage the corresponding shared/private state at a
> > granularity larger than the guest page size.
> > 
> > Architectures such as Arm can detect incorrect accesses to Realm physical
> > address space PFNs through GPC faults. However, relying on that as the only
> > line of defence is fragile and can still lead to kernel crashes. The risk
> > is especially visible for shared buffers that are later mmapped into
> > userspace, such as guest_memfd or dma-buf backed allocations. Once
> > userspace can access the mapping, the kernel cannot guarantee that
> > applications will only touch the intended 4K region rather than the whole
> > host page mapped into their address space. Those userspace addresses may
> > also be passed back into the kernel and accessed through the linear map,
> > resulting in a GPC fault.
> 
> IIUC, AMD SEV-SNP also has a similar requirement for other reasons, to
> align the "shared" allocations within a guest (2MB ?, as mentioned by
> David Kaplan at the LPC).
> 
> Michael, Alexey,
> 
> Please could you share your thoughts on this series ?

Yes, I think we concluded at LPC that AMD should use this series with
a 2MB setting rather than try to do their HW assisted smash/unsmash

Jason
