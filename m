Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C20AD606A331
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=fDEYtA1R
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 271EF10E845;
	Tue, 24 Nov 2026 13:08:02 +0000 (UTC)
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com
 [209.85.222.179])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 404D710E864
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:07:56 +0000 (UTC)
Received: by mail-qk1-f179.google.com with SMTP id
 af79cd13be357-9497a167a6aso659104385a.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795525675; x=1796130475; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2Jqv6h2U/zwufJIWy6q7C5BzrR7eGEBWyzupif8ezko=;
 b=fDEYtA1RTcDop0db9cOxuxRUMIO6fMoQlr2uDyn/EMyDknfXYC34QuGI5m6ZQafe5N
 tDCBon+DJ/Q4Ddq9iwPCf45WCT2HpQW2TIBPBfsVP2ZQhhD0igB6055xBT3HsPQMMF8N
 MZbfpFLJFucrot3nKBCKDhc5HCIyiEq3bnhlQMVzDtaLbW+KTY7nMRwtv8+zlCjZ3+pC
 MEFGAYy91EwDmhNhWb3wqDBxFKBL1pMX8a8NyH3SDmdpz6osdPHrbAqd+zon5brQRcMJ
 de+FrMzqd7UroAI0Xa07c9emQvQjvbAlaio4Vab9Wiz/fWHcYu5L7S35iI2qfG4oqgwi
 54Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795525675; x=1796130475;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2Jqv6h2U/zwufJIWy6q7C5BzrR7eGEBWyzupif8ezko=;
 b=mYvhH5OFH2ONbfAkRjjCXVDk6F9Ad1g23UtePLARP6MN7DguiG3bprgPA83jUUY+Dm
 lEjgpeq2jI382/nZdvqUUpiAGc7/83UdzRP18TnT3cUwfu04KudKAypksBXiZXSk5Krc
 SisoFO6Z/LzalfJrSPpDsA4INcrBToqG/Koggf03lhQC+L6pgOVRqr95P/SET4tuR6pS
 WPdMcTLALwGnsP6GpPafikLpCZnKX3rCpDNOApDXQokmkk3GwHU3Y+hN8NvaG74/DMOc
 QHFwQH3c988I1yRmkzhQRv6c0Q+4Hf8D+xTlHvnDa+pCglZQQ4JjzTW6YKqsbZTocC4d
 kMLw==
X-Forwarded-Encrypted: i=1;
 AL+hErEnb9Zj6nfIEvcSUvoCfBauB+Z9SjtTO4zcc9RzQDjoRH0OD3kw+9XQj+VLwYUSi3ELVlqsyvB5uh0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9ySpDLkg1S/JKWnU6z1thhSAKBXLJFAbFKXi4Mh6aa78TXBLnM
 4tVYknwLSrNZAW/MVTXsJVAFBX9KVv0noY3zXcLXh4hSz6tEJ3SviSsK1Za+TOqjTMc=
X-Gm-Gg: AZFdTZfQmPfcoygyyf9UFmg3hthaPexFF/wZ//hpaXBEIW1b0g4bHlYb9TSagr7BFhl
 P/hfDTYTpC+mIj4trsUQ9yOjF50QDEAeJRZlSU3OGABF58BqooP6hqgSJl712lYwCez3iLzqd2Z
 SY6brSFix1FB5Wq42MZy4e4F/mBJkJ3SsMKGiLDE6vPj7M3Koxn/tYgvvAjQ/EoeMuM66/c5SVx
 9A+IEBr4Cid8EAg5xG2yTIqw/jqq1fbZxzlVArjU6IuSBg7BTL1xV7GJ+hkZfHESZlBhCMS7kdK
 GuukWdL0JzJ3sFzQ0Ww+NLExyzMkCIkMW+NLRXijRv2QFCAqxPTBOYCH+yz5266PbZn7y9toMPg
 7IhQCk8GEkZW3WCEjsUGgIXIRKi+4872r5FGG+gJJXJnKXV528ZIT3lqFbT0Xx1h98sLITIU7nZ
 HgtcpDuwRZAKEDJBK4zJv9epyx5ZAxVun+b7kyVoR3ZsNb1MWsxs+HcEAeL91TJ3v83awTB8cK6
 t3JPQRMOIgRqOh+PoUMfoNZte3zUqCOBFthyzyKYo83gX1dm4b3Pm6rK9Ja+eLZw3f1XNU6gT1K
 f9fGEA==
X-Received: by 2002:a05:620a:2705:b0:949:8ee5:6faa with SMTP id
 af79cd13be357-949ba818db4mr2224332285a.4.1795525675010; 
 Tue, 24 Nov 2026 05:07:55 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb4219c4sm1034879485a.41.2026.11.24.05.07.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:07:54 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVqFV-00000000OKe-3ac5;
 Tue, 24 Nov 2026 09:07:53 -0400
Date: Tue, 24 Nov 2026 09:07:53 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
 linux-coco@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Baoquan He <baoquan.he@linux.dev>, Mike Rapoport <rppt@kernel.org>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Pratyush Yadav <pratyush@kernel.org>,
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
 Haiyang Zhang <haiyangz@microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vitaly Kuznetsov <vkuznets@redhat.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 dri-devel@lists.freedesktop.org, iommu@lists.linux.dev,
 linaro-mm-sig@lists.linaro.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
 linux-mm@kvack.org, kvmarm@lists.linux.dev, patches@lists.linux.dev
Subject: Re: [PATCH v10 04/13] irqchip/gic-v3-its: Allocate shared tables
 using CoCo shared memory allocator
Message-ID: <20261124130753.GD9566@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-5-aneesh.kumar@kernel.org>
 <awQd81MwZqi55gf8@arm.com> <20261123150041.GB179082@ziepe.ca>
 <awSGBdS1AiFhJzZV@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <awSGBdS1AiFhJzZV@arm.com>
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

On Mon, Nov 23, 2026 at 06:29:25PM +0000, Catalin Marinas wrote:

> > Exposing struct page to places that just want a kernel addr means they
> > have to call page_address and we are back to the highmem weirdness.
> 
> dma-buf system heap needs struct page for scatterlist, so we need the
> virt_to_page() conversion if we return a VA.

Yeah, but if that is a one off I'd give it is own API..

> > > Was there a caller you had in mind that needs the common allocator to
> > > share less than the whole buddy block?
> > 
> > If we want this it definitely needs to be a void * based API not
> > struct page one though..
> 
> For whole-block sharing, either a VA or a folio works for me. If the
> allocator takes an order, the requested size and the sharing granule are
> both powers of two. Rounding up to the granule already gives a valid
> buddy block size, so there’s no need for a separate shared_size.

But you still will need the allocator to use the struct page metadata
for its own tracking information, so it shouldn't be exposed to the
caller..

Jason
