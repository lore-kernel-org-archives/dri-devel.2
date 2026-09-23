Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DD0C9830B
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 17:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76CDE10E936;
	Wed, 23 Sep 2026 17:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; secure) header.d=ziepe.ca header.i=@ziepe.ca header.b="fKSzc4aP";
	dkim-atps=neutral
Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com
 [74.125.231.204])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA2F610E936
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 17:23:35 +0000 (UTC)
Received: by mail-oi2-f12.google.com with SMTP id
 5614622812f47-4b37a2c0356so798326b6e.2
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:23:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1790184215; x=1790789015; darn=lists.freedesktop.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=1FwE1NfmDw+YKo1XdhlQDW5TQG+slKv16o9ht1shLNo=;
 b=fKSzc4aPybDNS2iy7Rk0ouR//FgjkxhNmaqZRtsUSWxH22EWdLNfSScvlf4KdCmNqV
 h0ADDoWThL20nwRZ49S//d3qjr84nhZvckE79Y/1KiCNeD/YsK78UQbtRabiADkGGPJU
 bddL0Tfgt3iXhwDKoQmlJtv9VZ/kVUcrN/yg60lJoDG2vtigIrodh9eygW58eG0uMyaX
 lVNBoJzQo+Wn5gy1nV0cRL99Mx5Vs+7uTKdlQCkA0IOPgJiHOKJzCV9wryY2YlPcM0C+
 9BOD/pz4gFA05N1VNZo/aXS0SSc5YyNPrXFqdQZHKztu8Bj2lMpMX76qfPfzIEtyuKXH
 CIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790184215; x=1790789015;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=1FwE1NfmDw+YKo1XdhlQDW5TQG+slKv16o9ht1shLNo=;
 b=RQFttaYAIyblROxlVDuSeglPNRK2pO9LIPUZQOp0s2ssOFsYOrtmQ2gKfCDrAxGZNH
 8w8WPMWkfpZ/ltkw+3Skvz3UzCXxdNELikU+yhJ69LfPn2wuReHeN24MmfAvTcnUfpi3
 69ahQilrjx5j1vR76v7zKSDwUZbvpi8ocuZHGwgkGdZzvIxWQLvD7ImuT1iJn2Z0tnaJ
 t0W4MwcweDauY5u9ctAFYdNm9FidlGRl8BfuD6nIA0xtRLqkLlyehOSnfLyRSlQFw3wc
 fQbRjJ6WVsSEjTWACnyItjrR3stjBPY5/qT/yD/ffj3YQ310fUNviXXNtuM9WyZxCkvU
 HTdA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz9VSx03DGj3qEYM4TWwV1lUlM3YLuU9aTz+PNDMB+Iqf3RLT857rnqtw9agQYWpVIrs/gmtRi/z8s=@lists.freedesktop.org
X-Gm-Message-State: AFuF++m3xUZ34xLR1b/V9LGe5yZYgP8dHQlpiYt/sTT4/loZ3WmLCdtv
 jP7zg1raf/gPyw1cFQxyDoJ9cX5d32TuRLuz3X/Q0Zm6vasvHxr+zGxn0w4dd47rvx8=
X-Gm-Gg: AYBFou0DaLQIIP9T52z7C/qiXPHjLLBA0jVzrtUHPldHhIuMkO3glNGbxKy9N4fWmC2
 BQnys699D5XxPftzZaiO4yK1NoUJrvBwES+762D3qtODJ8Dtu2N/M8eQVEPkZ4B9j4+Y9gVr44/
 ItuoFeZ1HHIviU6JSMmTsMaAppltxn2N34C/NFFRxnCGmnu2QWwaz3Iuy3+sOeOldwxaCDnpOV2
 uFbWbClntKeJQqrZ7ofye7iZwpngXACV/5AAYfh9pvhB/5djQgRFzR+WfHgHh8EmVCFe+w19OZ+
 L/TJe+FVhXDhwM7wyFpo7XUlfSDAroz17A3skOkxmSXu1MFRKUtDHvZpZjY46AAe/C2H4NHezSo
 dsTeSdWAXpgAOHgCCMt0IxLpjshZxtZ62S56di52u/7bR6LFDXQv0fbF8TNRN6suoJMsftdtY1U
 7Wi0B2XkBHPILiZ3YGyTXQZydRoyB1CSSqP5iBeSIbrO1F
X-Received: by 2002:a05:6808:1313:b0:4b5:5bfd:518f with SMTP id
 5614622812f47-4d5b85af4d4mr3232472b6e.21.1790184214658; 
 Wed, 23 Sep 2026 10:23:34 -0700 (PDT)
Received: from ziepe.ca ([130.41.10.202]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4d5c522604asm2686648b6e.15.2026.09.23.10.23.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 10:23:34 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
 (envelope-from <jgg@ziepe.ca>) id 1x9Qgv-0000000E9nH-0xvE;
 Wed, 23 Sep 2026 14:23:33 -0300
Date: Wed, 23 Sep 2026 14:23:33 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Kameron Carr <kameroncarr@linux.microsoft.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, mhklinux@outlook.com,
 Catalin Marinas <catalin.marinas@arm.com>,
 linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 christian.koenig@amd.com, Joerg Roedel <joro@8bytes.org>,
 Marc Zyngier <maz@kernel.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <20260923172333.GM1540250@ziepe.ca>
References: <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com> <yq5aik3w344o.fsf@kernel.org>
 <arOfD6syXOgQhZYA@arm.com> <yq5a5wzw2ree.fsf@kernel.org>
 <arOspFxWZ1DjgcAr@arm.com> <20260923130611.GF1540250@ziepe.ca>
 <yq5atsng10b2.fsf@kernel.org> <20260923152124.GG1540250@ziepe.ca>
 <5cbe0bde-47d8-41ca-b244-bc0329d0d066@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5cbe0bde-47d8-41ca-b244-bc0329d0d066@linux.microsoft.com>
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

On Wed, Sep 23, 2026 at 09:28:54AM -0700, Kameron Carr wrote:
> On 9/23/2026 8:21 AM, Jason Gunthorpe wrote:
> > On Wed, Sep 23, 2026 at 08:28:57PM +0530, Aneesh Kumar K.V wrote:
> > 
> >> I'm also considering requiring the address passed to cc_make_shared() to
> >> be in the linear map. This is currently required by both TDX and CCA,
> >> while AMD SNP appears to support vmalloc addresses. The only user of
> >> that vmalloc support is Hyper-V VMBus GPADL setup
> >> (vmbus_establish_gpadl()). How should the generic CoCo shared-memory
> >> allocator handle this?
> > 
> > vmbus_establish_gpadl() is the the same wrong abstraction as the arch
> > code. Get rid of it and use vmbus_establish_gpadl_caller_decrypted():
> > 
> > 		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
> > 		if (!pdata->recv_buf) {
> > 			ret = -ENOMEM;
> > 			goto fail_free_ring;
> > 		}
> > 
> > 		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
> > 					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> > 
> > 
> > So you made an allocator that returns folios, now you just need to
> > use that allocator to implement a kvzalloc wrapper. ARM can call vmap
> > on decrypted memory with pgprot_decrypted(), right?
> > 
> > Or maybe this can use vmbus_alloc_buffer(), it already does it.
> 
> Michael Kelley recently proposed [1] moving all ring buffer allocations
> to use vmbus_alloc_buffer(). If we move forward with this, it should
> remove the dependency on vmalloc support.

Even better vmbus_alloc_buffer() can use the new allocator API
directly so it doesn't need to open code the set_memory_decrypted arch
call.

Lets do it!

Jaon
