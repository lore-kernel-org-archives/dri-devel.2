Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED75C9830E
	for <dri-devel@archiver.kernel.org>; Fri, 25 Sep 2026 07:31:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7F04D10F914;
	Fri, 25 Sep 2026 07:30:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="lk4iTPb2";
	dkim-atps=neutral
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by gabe.freedesktop.org (Postfix) with ESMTP id 80A3110E945
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 16:29:07 +0000 (UTC)
Received: from [10.4.158.9] (unknown [4.194.122.162])
 by linux.microsoft.com (Postfix) with ESMTPSA id C049D20B7167;
 Wed, 23 Sep 2026 09:28:09 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C049D20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1790180898;
 bh=zRx/KbW622lc9oNGjU0HBG2ucuK06pk04r2BRU2Rs4k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lk4iTPb2Y7uutncKN/+j8ht7tPnRTZ6o43sCv1igw+EdAbkap5LleY6qa51nPpFa6
 oFrn4wb6BHxvCgReQsk80Yv5Gq+s/5rQRHwDalOdArIoH0GTefNuq6TyY2rgXsVOhS
 gNMu/nMv3dX8EIbRcFZTUFCIb4A9JF6t3XJZs7Dw=
Message-ID: <5cbe0bde-47d8-41ca-b244-bc0329d0d066@linux.microsoft.com>
Date: Wed, 23 Sep 2026 09:28:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
To: Jason Gunthorpe <jgg@ziepe.ca>, "Aneesh Kumar K.V"
 <aneesh.kumar@kernel.org>, mhklinux@outlook.com
Cc: Catalin Marinas <catalin.marinas@arm.com>, linux-coco@lists.linux.dev,
 kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, christian.koenig@amd.com,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>, Thomas Gleixner
 <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org> <arKsFofudnTYpXj1@arm.com>
 <yq5aik3w344o.fsf@kernel.org> <arOfD6syXOgQhZYA@arm.com>
 <yq5a5wzw2ree.fsf@kernel.org> <arOspFxWZ1DjgcAr@arm.com>
 <20260923130611.GF1540250@ziepe.ca> <yq5atsng10b2.fsf@kernel.org>
 <20260923152124.GG1540250@ziepe.ca>
Content-Language: en-US
From: Kameron Carr <kameroncarr@linux.microsoft.com>
In-Reply-To: <20260923152124.GG1540250@ziepe.ca>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Mailman-Approved-At: Fri, 25 Sep 2026 07:30:44 +0000
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

On 9/23/2026 8:21 AM, Jason Gunthorpe wrote:
> On Wed, Sep 23, 2026 at 08:28:57PM +0530, Aneesh Kumar K.V wrote:
> 
>> I'm also considering requiring the address passed to cc_make_shared() to
>> be in the linear map. This is currently required by both TDX and CCA,
>> while AMD SNP appears to support vmalloc addresses. The only user of
>> that vmalloc support is Hyper-V VMBus GPADL setup
>> (vmbus_establish_gpadl()). How should the generic CoCo shared-memory
>> allocator handle this?
> 
> vmbus_establish_gpadl() is the the same wrong abstraction as the arch
> code. Get rid of it and use vmbus_establish_gpadl_caller_decrypted():
> 
> 		pdata->recv_buf = vzalloc(RECV_BUFFER_SIZE);
> 		if (!pdata->recv_buf) {
> 			ret = -ENOMEM;
> 			goto fail_free_ring;
> 		}
> 
> 		ret = vmbus_establish_gpadl(channel, pdata->recv_buf,
> 					    RECV_BUFFER_SIZE, &pdata->recv_gpadl);
> 
> 
> So you made an allocator that returns folios, now you just need to
> use that allocator to implement a kvzalloc wrapper. ARM can call vmap
> on decrypted memory with pgprot_decrypted(), right?
> 
> Or maybe this can use vmbus_alloc_buffer(), it already does it.

Michael Kelley recently proposed [1] moving all ring buffer allocations
to use vmbus_alloc_buffer(). If we move forward with this, it should
remove the dependency on vmalloc support.


[1] https://lore.kernel.org/all/SN6PR02MB4157B71CAC1433B04B92B700D4832@SN6PR02MB4157.namprd02.prod.outlook.com/

Kameron
