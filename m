Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0485B606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=exvtVA22
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5BC8C10EED4;
	Mon, 23 Nov 2026 15:00:56 +0000 (UTC)
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com
 [209.85.219.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9726910EED5
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 15:00:45 +0000 (UTC)
Received: by mail-qv1-f53.google.com with SMTP id
 6a1803df08f44-9213f004a14so41548936d6.3
 for <dri-devel@lists.freedesktop.org>; Mon, 23 Nov 2026 07:00:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1795446044; x=1796050844; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=8YXzoVkoKKTn5S6189qRHpEA8zSaXUAPSQ685ax1F0I=;
 b=exvtVA22yer5zsKnQvX00FsV+indj4dpQbnrvCVtlMN6A4WteE/cqwuF/EWu8/uO54
 1mzYR8iT2UOK9Z6RTTu87iGFif0JVIcDD4zt9gynEZX7ufBHw44M/fvOEsXi9lkcHm26
 MhfL6jV+M6i26YrjQQYQ1DH7HmQRjEkUniKgenQCVzhb2H7/cnN0VaplxjIBtbssbfxK
 XokpD/Pd30fKCcU+2DKpE9bDkwh94pn53KdEOYn+MjFc21VJ/D8yjlEnEs3uHi35xIY4
 NNT709m4oEgozjUEUSpCwmOkXONOIv10LoFC7m8Y7SfGJfJyzZZnX7nk9BLOA58vMSzl
 KAmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795446044; x=1796050844;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=8YXzoVkoKKTn5S6189qRHpEA8zSaXUAPSQ685ax1F0I=;
 b=yEYF2qX91SsYTqx/rNJsOZweNohDP5ijFqhxklQ2hJZ4jzBdtS25vJE8goDzMxIVWP
 hfHQxw+nut9WpckOKcY+CtcRsUEARFTHoEItucCLjeZY7aoI+YVkGT2teH0sHEiJ3JYA
 Cg7IgACFRMuQIbIjveIDQQrZXRhNdQGG/tqgnz6eI+YYkoTWFuirbMCT3kbQU4iOjvAL
 y8dbd8fq9me68mYm+oBYceQP5PcqDDCwFkjTAOs2z3kKodMjVjVl5SCB2IHRBq9pB+TR
 pm5I3eO9HKCbvWrSsSU99VCdbATedgpDd+tlANr/HuyI5Ll9hWYi8ffpnmyjbNPKbf6z
 SJOg==
X-Forwarded-Encrypted: i=1;
 AL+hErFZ6JMQbK0w0RUxLWur56ZPxvN5VwEQL29kqg5jdf0ew2jrjJzca/Ol9tjReYGZZoeOJ1GBlnmBoRI=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z8pS1HsYICiQisNP5Ka465TBPpR96sTsmt37viiXyDf1rd6Y4oD
 nY4p8k8zSMZYflATZoFnPr2xRoCZya3MsPj1cFV5IyIsjJxMfnJKyd75ouYUE6HtxMg=
X-Gm-Gg: AZFdTZezxqNswhavhxkqXoExPftMI17NihAU9FotmsE4StMT0WgqC26Oagdcg3ucKPG
 NL6hN2Fxscrf1iVWKN+0KOFB4gQaD0dNCS/UkD0sPXdFOY32X2zslirKrvCB7vZs5u3LTYeG6Zi
 u9LSSrUNVI4QHzBSfC1D9XTWg86p6ZkSRRe4NBRRQ5ipipXrinYNBHqD+6XKZXgdgqmhyB48gW0
 VDVpqosXyMB9yzTFdGb6TLZHgDmDXFkcPyBcTnzHgFgp4sRNJOzhWiECAocSGCpj5WIARelAzpK
 3QGMrNSDITIhy5TSFWZHRNSOfZnoVsC4u2oGdfJ53lJHBP1u2T5Ab0/u4d7pyjtzGzQXDt+WXoS
 7SF4zVFVEdNsskO/AR0+jllGWDJo0AFPTriYutH/eTTEiopPYwzUM0vltVrlMhMMXcRWdx0tI8B
 DNPvf8UH8d79xCrSdEKr4dxKu5BW1rmL6J3SS8ZvAqX9b4glo00FEJFxUAj4+2JpQn3vH7z7aqW
 gbzMDj/rCG87RlXC62UH1ginDPS27eEfDaGH2kTg+rqqFt+44bGWe7BYMqap4BEo4NceCrewZf0
 GVKW0WWhx+pPZdAJxGoOF62+4dRtSuE76so/e6iPY4VTw9erWrnsxr+gUc9ulISsPe/VOA6A5kO
 xb6M=
X-Received: by 2002:a05:6214:4891:b0:921:27c2:3f89 with SMTP id
 6a1803df08f44-92134a3715dmr207386236d6.17.1795446043629; 
 Mon, 23 Nov 2026 07:00:43 -0800 (PST)
Received: from ziepe.ca
 (stjhnbsu6iw-159-2-142-59.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.142.59]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a16754sm107600476d6.39.2026.11.23.07.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Nov 2026 07:00:42 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1xVVX7-00000000rK9-14j4;
 Mon, 23 Nov 2026 11:00:41 -0400
Date: Mon, 23 Nov 2026 11:00:41 -0400
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
Message-ID: <20261123150041.GB179082@ziepe.ca>
References: <20261116091137.94252-1-aneesh.kumar@kernel.org>
 <20261116091137.94252-5-aneesh.kumar@kernel.org>
 <awQd81MwZqi55gf8@arm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <awQd81MwZqi55gf8@arm.com>
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

On Mon, Nov 23, 2026 at 11:05:23AM +0000, Catalin Marinas wrote:
> > -	/*
> > -	 * If set_memory_decrypted() fails then we don't know what state the
> > -	 * page is in, so we can't free it. Instead we leak it.
> > -	 * set_memory_decrypted() will already have WARNed.
> > -	 */
> > -	if (ret)
> > +	if (alloc_cc_shared_pages_node(node, gfp | gfp_flags_quirk,
> > +				       PAGE_SIZE << order, &mem))
> >  		return NULL;
> >  
> > -	return page;
> > +	return mem.page;
> 
> This part is mostly fine but I do wonder why not make this alloc
> function the same as buddy alloc_pages_node() - return a struct page
> pointer.

I'd argue we shouldn't even be returning struct page here, do many
places even use the struct page? What for?

Exposing struct page to places that just want a kernel addr means they
have to call page_address and we are back to the highmem weirdness.

> >  static void its_free_pages(void *addr, unsigned int order)
> >  {
> > -	/*
> > -	 * If the memory cannot be encrypted again then we must leak the pages.
> > -	 * set_memory_encrypted() will already have WARNed.
> > -	 */
> > -	if (set_memory_encrypted((unsigned long)addr, 1 << order))
> > +	struct cc_shared_layout layout;
> > +	struct cc_shared_pages mem;
> > +
> > +	if (WARN_ON(cc_shared_calc_layout(PAGE_SIZE << order, &layout)))
> >  		return;
> > -	free_pages((unsigned long)addr, order);
> > +
> > +	mem.page = virt_to_page(addr);
> > +	mem.shared_size = layout.shared_size;
> > +	free_cc_shared_pages(&mem);
> >  }
> 
> Here it gets weird and I don't see why we can't have just a buddy-like
> interface. The kernel-doc for alloc says that shared_size must be
> retained for the corresponding free but without reading the source code,
> you can't tell that cc_shared_calc_layout() gives you the same
> shared_size populated by alloc. We have a similar pattern in dma-buf but
> using the compound page order.

This makes sense, we should not be passing size to a free function,
make a compount page/high order folio instead if the API is going to
be struct page based.

> We can get rid of layout and mem structures (or at least not as
> part of the API). Of course, this assumes that the shared granule size
> remains constant for a guest's lifetime but I don't think that's a
> problem.

It should be encoded in the struct page meta data, as the order.

> Was there a caller you had in mind that needs the common allocator to
> share less than the whole buddy block?

If we want this it definitely needs to be a void * based API not
struct page one though..

Jason
