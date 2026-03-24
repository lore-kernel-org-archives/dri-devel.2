Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBA2E9A779
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 12:01:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 283A010E656;
	Tue, 24 Mar 2026 12:01:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="J7YDnvZX";
	dkim-atps=neutral
Received: from mail-ot1-f44.google.com (mail-ot1-f44.google.com
 [209.85.210.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0496710E4AE
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 12:01:00 +0000 (UTC)
Received: by mail-ot1-f44.google.com with SMTP id
 46e09a7af769-7d7f9285560so1746934a34.1
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Mar 2026 05:01:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1774353660; x=1774958460; darn=lists.freedesktop.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=6xGeDSaplrfa0s0FkTnYgpWTfeJHarWr6HfnS+Tx8gc=;
 b=J7YDnvZXJKK7is9so5VhzfY9Z+2I3PjoR/yTHbSUSdpUgeaSEFVaHJ3y8AKYW9sV6t
 tQIr88r+gAnc6RaTTzQkOndzba8320CVYBtHIm3axDl/wC2JNdptWmmxt8MRRJPYDEZT
 +nPErmjAj7T8uICnfRSYfbxwkpKtQJnKz6t2azp8SKVBKDjqQJc9g4unWfWEDb385egZ
 NaEnHqUoSMXoeTMPXpDLkn2vyZE6X+dwlKT4VvAeBkZcV+MN1/OSFylWPqjGidh8HZsE
 yml6OQ22L3OQ+MbMAqIvgYFLJ59SUWddetzvivtrzbCYNNxJniNcM1seNi5JpmkxcNuW
 +01Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774353660; x=1774958460;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6xGeDSaplrfa0s0FkTnYgpWTfeJHarWr6HfnS+Tx8gc=;
 b=NF0A2eeiLGNfNTnUwgA/AdHRutmDFPJwltS7audcs4tYfBPeVTJSUaMzk4IjLZFBsx
 X/ufrwBuUe1mHgN3/CjGJwvm34UN/0TpDbV4DmuSgXZcuf8wKIwNwhwPZ+PrHcbQz1RS
 /36NMCkayonLVga0XoPxGcjZVzR0OGyfNJSPPRIro9KTPJXai4jyLR9zi/nHisUna7tz
 rSUkS32oIpHMbhbTIBjDmYYUaXLqgzRerx/qpGvgnEcGRyIStAdoUg9P3/BziUTzQsNv
 VgbbFdDt/QXASt/9CtAXmAFHA+o0RCug3/wpP3RTiu3YolVHSIXFqeejDhR15BBPI0lX
 vCOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVL0AE0zgGpC2y2G2nJ8s1nhTUDkQJFMPgV0G4CWiinv9mLsutMWaf/3MwkltcTbH8H47Ukn2w5Hds=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx8hY5b5DqXXiQ2YCqet8Ey4tOOyAS0fh5jmZBspyjO70QWDK0u
 N4IAQWjzYe48f87dO8n6M8IoEcSm331gTeR6g0bAAE8BMBDXFFdDTplILmyQpgvihE4=
X-Gm-Gg: ATEYQzzKcyCg8+IgQBVC2/K+51E3wWdB0b8yRwx/GbWo2GXYdtd3Td7rRli1Iolm6TG
 MTOQCU3Jar/EuQk4It1ThbXLWpRsl5MV+sKzbJKPRvDlq4Js1oYuxVYlsSZ/Ru9SBReQjJ9XOPZ
 RP3zxZ/aDEfx4GrCSYVRfRu/kGikgRIVFCSYx3prgPMvV2Ie/zWD7kCMD+JW6tfv4/XtJekxrF4
 l7BzhpUZztVhQkcl9Jynzt2RrXjENCNzh8h69h+5y5+3nzMh//W+B68wqvQWppvpwR6uxCVkcf/
 0B3SMm2oiFU8HZsgTPyr4wQ/2tUzlDOl8km42L1kVxoVpYbzPpd/LO7XCPbz2RbJhLRZbY3tcIH
 xu/jhdj6d/wYSZ7HCrPVLvMMaIcDb1twfJKSM05FThElN+Q5psCrwSDBAiSDeN0+0mmRdIPy/gN
 luD8Z6yJg+AWQHuU+ialP0X9mJzkms+A7piD7T24RihfjrcOM8b66xIyr0VT9WPm1f7dC2Gv8Gl
 KnQ4Buy
X-Received: by 2002:a05:6820:174b:b0:67d:f88f:d83d with SMTP id
 006d021491bc7-67df88fef36mr1271317eaf.29.1774353659590; 
 Tue, 24 Mar 2026 05:00:59 -0700 (PDT)
Received: from ziepe.ca
 (mctnnbsa70w-159-2-73-22.dhcp-dynamic.fibreop.nb.bellaliant.net.
 [159.2.73.22]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89c85335402sm138526236d6.25.2026.03.24.05.00.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 05:00:58 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1w50RN-00000000GV5-3aCE;
 Tue, 24 Mar 2026 09:00:57 -0300
Date: Tue, 24 Mar 2026 09:00:57 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Mostafa Saleh <smostafa@google.com>
Cc: Jiri Pirko <jiri@resnulli.us>, dri-devel@lists.freedesktop.org,
 linaro-mm-sig@lists.linaro.org, iommu@lists.linux.dev,
 linux-media@vger.kernel.org, sumit.semwal@linaro.org,
 benjamin.gaignard@collabora.com, Brian.Starkey@arm.com,
 jstultz@google.com, tjmercier@google.com, christian.koenig@amd.com,
 m.szyprowski@samsung.com, robin.murphy@arm.com, leon@kernel.org,
 sean.anderson@linux.dev, ptesarik@suse.com, catalin.marinas@arm.com,
 aneesh.kumar@kernel.org, suzuki.poulose@arm.com,
 steven.price@arm.com, thomas.lendacky@amd.com, john.allen@amd.com,
 ashish.kalra@amd.com, suravee.suthikulpanit@amd.com,
 linux-coco@lists.linux.dev
Subject: Re: [PATCH net-next v3 0/2] dma-buf: heaps: system: add an option to
 allocate explicitly decrypted memory
Message-ID: <20260324120057.GC8437@ziepe.ca>
References: <20260305123641.164164-1-jiri@resnulli.us>
 <ablV_f_l7wD2m63E@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ablV_f_l7wD2m63E@google.com>
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On Tue, Mar 17, 2026 at 01:24:13PM +0000, Mostafa Saleh wrote:

> On the other hand, for restricted-dma, the memory decryption is deep
> in the DMA direct memory allocation and the DMA API callers (for ex
> virtio drivers) are clueless about it and can’t pass any attrs.
> My proposal was specific to restricted-dma and won’t work for your case.

How is this any different from CC?

If the device cannot dma to "encrypted" memory, whatever that means
for you, then the DMA API:
 - Makes dma alloc coherent return "decrypted" memory, and the built
   in mapping of coherent memory knows about this
 - Makes dma_map_xxx use SWIOTLB to bounce to decrypted memory

There is no need for something like virtio drivers to be aware of
any of this.

On the other hand if the driver deliberately allocates decrypted
memory without using DMA API alloc coherent then it knows it did it
and can pass the flag to map it.

> I am wondering if the kernel should have a more solid, unified method
> for identifying already-decrypted memory instead. Perhaps we need a
> way for the DMA API to natively recognize the encryption state of a
> physical page (working alongside force_dma_unencrypted(dev)), rather
> than relying on caller-provided attributes?

Definately not, we do not want the DMA API inspecting things like
this.

Jason
