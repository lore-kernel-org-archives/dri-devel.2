Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 566EB606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 13:46:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=LuxbKQHq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AEF8410F5AE;
	Tue, 24 Nov 2026 13:46:30 +0000 (UTC)
Received: from mail-qt1-f169.google.com (mail-qt1-f169.google.com
 [209.85.160.169])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C1E310F5A6
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 13:46:24 +0000 (UTC)
Received: by mail-qt1-f169.google.com with SMTP id
 d75a77b69052e-53664b4860bso52277621cf.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 05:46:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795527983; x=1796132783; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zc7zKgD/SDYnIbkY4MVpBd0Jo9DiJTva6Dv7og4GVfM=;
 b=LuxbKQHqfT2yVC2a5kVHeRi/VSMWaDvwN7LctEcda7ykFt7wAeW4Fde0iVOoHiZmZJ
 AOvW3B1RgwZVbyOvmttMha7k+O8FQvZlZZm45zImD6CoK55vzwP9ZVoFXOR0ayTUsIc9
 3X4Dq16IcHc6xo6Jy7lUEMJ2/TGy+uY/LYeW2ZeVGVo21DfNe0AjUlyVwcwGPRY00Uq8
 LN2ptY9J/4rRX8qxyh8GyEPEofx2xAqRkw3ughgGxDhgskIMAwoN0rPcUgMhpD3BikA7
 RC9aCZid9wt3hv8E4rLlLMRx1bQ/76vwmjMXwljmSI++WpTEK8tfQPB77xztkrFPi1k8
 VJBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795527983; x=1796132783;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zc7zKgD/SDYnIbkY4MVpBd0Jo9DiJTva6Dv7og4GVfM=;
 b=rENH0vqJ+EYxAv4eBHiYvNEKu7gusdasmzz1Xwosm/sKFq+bQPPgPFj5+CuQQ0Xhtp
 eBO3l6XUL/yux0DtzwklvP6PIBRpCmDcsEVvsLrmJVFzKdXtjyUQA6DSvD2MDmxp4os+
 Xhe1cHVj53f/vJWJDk+b0rpdOaYYRH2G1FqfodK9IzZ2B/3P4XJLftC8JgGk0F7GlAYG
 plmQRJw9sMPPD3M78ohqICDyL76Uu27HCunt0YePuFkg2iK52++OhAy+vp7tC4ADztl8
 YLj7SVIkoUIq2q55Hq4a2RQltmbR7fwtGEJOHbo4vIog8GbydhvecL4M8uuKtkobCJdr
 zFrw==
X-Forwarded-Encrypted: i=1;
 AL+hErHA6XdhtR2Osl4HFjQipHu7LP7N8brKS4u63f4fX/h6c3NztrSnE16HdqX3ra8wYWQD4wbawHHB9q0=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9kqkNIKjYTxK0X9Go0pfl1yk0XVvJOtqIlBlgbVO4TaAU8kHuw
 yYPoBOvGcOw2xqfJJLBilLA7zNh12jvBtV/7PrzU2ulFvKbVJ3mU0/v5Ei6/Jjdo42A=
X-Gm-Gg: AZFdTZflGstz8/W6oNpC+cbrOky+PFPxexv7ReXp/tneP2H4WNnsmx4xxNslkuvVHhk
 71r94BZUQOrahsz/+1hFsokW14MxlrAAa6jYz3S1xGCb8a6ruEM+uQHMdFGSW/m1X1e7P+Fdt64
 Xicud5g7dOI2FRSJalKJHeb1zEfdLXW1zkgOVcd1qo/1RygT9TcYKmC0sT/qwmcjvBJZ4KoiP/E
 COVhwP0z3KTpijBUYs44nvM9jes26TLcWBbYMa67JzkM/ShAgX8ypTTVtmsSotGdYtimpN2inyL
 Iz7SEqBEnV2/y7h5uKoTsP88P42ZTaAx8xYkajCJEpCPGuXj8o1BS1dZxUKZYZsLmz2EM33UieJ
 RXdpdFHeu9vu/8M/+xg4PIa5OtntgfhkYl9GG/Z1ygnz3hWxfpbvvtz0uQYAQ7dg1AHTK3uCb2w
 DSSqcizR4oqqFq77/UNvwcJDpKps3jHVR7PRZYsOdHO5iOn1ifMfjjZKXYgjqBbZ5uVf4MLxRL7
 gZE7cuML+cwsjdtso0oboP84K9w6QSL8UnI/F5sZCvW4XB5MEiBoLFsU29eak2ed08oRR1A+Gbx
 tpuZMw==
X-Received: by 2002:a05:622a:120c:b0:535:a5f9:752e with SMTP id
 d75a77b69052e-55d76aed568mr264410241cf.77.1795527982900; 
 Tue, 24 Nov 2026 05:46:22 -0800 (PST)
Received: from ziepe.ca ([142.177.118.84]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-55d78451407sm128368371cf.2.2026.11.24.05.46.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Nov 2026 05:46:22 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVqqj-00000000QIG-3EJB;
 Tue, 24 Nov 2026 09:46:21 -0400
Date: Tue, 24 Nov 2026 09:46:21 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-coco@lists.linux.dev,
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
Message-ID: <20261124134621.GI9566@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-5-aneesh.kumar@kernel.org>
 <awQd81MwZqi55gf8@arm.com> <yq5aa4mybbmv.fsf@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5aa4mybbmv.fsf@kernel.org>
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

On Tue, Nov 24, 2026 at 07:00:00PM +0530, Aneesh Kumar K.V wrote:

> Taking Jason's feedback into account, we could have the allocator
> request compound pages and recover the actual allocation order with
> compound_order(). That would avoid passing an order to free:
> 
> void *alloc_cc_shared_node(int nid, gfp_t gfp, unsigned int order);
> void *alloc_cc_shared(gfp_t gfp, unsigned int order);
> void free_cc_shared(void *addr);

It probably shouldn't be order here, that is hard to use. Just size_t
len

And round up internally

If we ever want to do some kind of slab sharing scheme then the API is
already set up for it.

> As you noted, dma-buf would need virt_to_page() to obtain the pages for
> its scatterlist.

I think that is fine, other places working with kalloc/vmap already do
that.

Jason
