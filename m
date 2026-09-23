Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B17FC982FA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 10:10:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1311910E85F;
	Wed, 23 Sep 2026 10:10:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="N3sYQleb";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id CCF8110E85F
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 10:10:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A8480152B;
 Wed, 23 Sep 2026 03:10:34 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 146163F86C;
 Wed, 23 Sep 2026 03:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1790158238; bh=aJd5PwgdVPJ9tE7A7OasMy/wKrzLGbTgJY/jXplpFIQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=N3sYQlebo9JuaPrX/aY4BYXg4kl12bBh2l+dg5S1TpD/sd1OrXwH32xGOiPW5K434
 UuBzqurGcjPFaH0amX7WpALPGj4+fE2hTuRxrmfBQJcpZcj2x3NVvhpckvNi+KxnQI
 AtUULuSivZdyBUiepK0KoTPupOCiWcVRdZmElWyM=
Date: Wed, 23 Sep 2026 11:10:32 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: linux-coco@lists.linux.dev, kvmarm@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 christian.koenig@amd.com, Jason Gunthorpe <jgg@ziepe.ca>,
 Joerg Roedel <joro@8bytes.org>, Marc Zyngier <maz@kernel.org>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 Robin Murphy <robin.murphy@arm.com>, Steven Price <steven.price@arm.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Thomas Gleixner <tglx@kernel.org>, Will Deacon <will@kernel.org>,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 linux-media@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH v7 02/13] mm: Add an allocator for CoCo shared memory
Message-ID: <arOlmBBWdZTi8Xre@arm.com>
References: <20260921144847.501151-1-aneesh.kumar@kernel.org>
 <20260921144847.501151-3-aneesh.kumar@kernel.org>
 <arKsFofudnTYpXj1@arm.com> <yq5aik3w344o.fsf@kernel.org>
 <yq5afqz02wtv.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq5afqz02wtv.fsf@kernel.org>
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

On Wed, Sep 23, 2026 at 02:01:08PM +0530, Aneesh Kumar K.V wrote:
> I was pointed to this email thread:
> 
> https://lore.kernel.org/all/c25502d3-35c6-4281-a9ec-856f789fb1b4@arm.com
> 
> This makes a stronger case for having a CoCo shared memory allocator
> that captures all these restrictions. It also means that
> alloc_cc_shared_pages_node() needs:
> 
> 	if (WARN_ON_ONCE(!gfpflags_allow_blocking(gfp)))
> 		return -EINVAL;
> 
> 	might_sleep();

I think gfpflags_allow_blocking() is the wrong predicate. It checks for
__GFP_DIRECT_RECLAIM but we have callers like dma-buf which clear the
flag (see HIGH_ORDER_GFP). ITS allocations also use GFP_NOWAIT, so
they'll fail here.

I'd just keep a might_sleep() in cc_make_*() and ignore gfp flags
checking. Passing a no-blocking GFP flag doesn't necessarily mean the
caller cannot sleep. It might also happen early enough (like its_init())
not to care - __might_resched() skips the warning if SYSTEM_BOOTING.

-- 
Catalin
