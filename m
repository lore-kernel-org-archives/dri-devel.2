Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C23A8CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 13:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E198E10FF80;
	Wed, 14 Oct 2026 13:56:09 +0000 (UTC)
X-Greylist: delayed 2167 seconds by postgrey-1.36 at gabe;
 Wed, 14 Oct 2026 13:56:03 UTC
Received: from mta0.migadu.com (out-86.mta0.migadu.com [91.218.175.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CABF810FE5F
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 13:56:03 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=m7HcPUAMizid1DX3lRG9Tzw1zddlCTzU8zWnOAtnnRg=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791986162; v=1; x=1792590962;
 b=SNRwg6mSbgiIwzfgRWFuiG1wmjcecZShKXNvaFUTq3pfaFpIY3f6lITDhh8rIapMMgG3mD6T
 yxLofI9u6NjpoGn9dQMtj7Z3zm/XTzJsuFHqXfiCtI4TgjSnEclUA0ZCxBlcgEVOHYj2L3tEslW
 qZGK9kjTTW5iekApvI48K3co=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id b774b44408666da9;
 Wed, 14 Oct 2026 13:19:54 +0000
X-Mizu-Trace-ID: b774b44408666da9
X-Migadu-Flow: FLOW_OUT
Message-ID: <58e8d79b-f7c3-4ded-9272-07c309917055@linux.dev>
Date: Wed, 14 Oct 2026 21:19:42 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/huge_memory: recheck a special PMD under the lock in
 copy_huge_pmd()
Content-Language: en-US
To: Konstantin Khorenko <khorenko@virtuozzo.com>
Cc: Alex Williamson <alex@shazbot.org>, David Hildenbrand <david@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>,
 Ryan Roberts <ryan.roberts@arm.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 Nico Pache <nico.pache@linux.dev>, Zi Yan <ziy@nvidia.com>,
 "Liam R. Howlett" <liam@infradead.org>, dri-devel@lists.freedesktop.org,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Usama Arif <usama.arif@linux.dev>, Barry Song <baohua@kernel.org>,
 Dev Jain <dev.jain@arm.com>, linux-mm@kvack.org, Peter Xu
 <peterx@redhat.com>, linux-kernel@vger.kernel.org,
 Jason Gunthorpe <jgg@ziepe.ca>, stable@vger.kernel.org,
 Kiryl Shutsemau <kas@kernel.org>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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



On 2026/10/14 19:57, Konstantin Khorenko wrote:
[...]
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 1e5d68acf62a5..fcea98f0d8865 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -1965,13 +1965,22 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>   		src_ptl = pmd_lockptr(src_mm, src_pmd);
>   		spin_lock_nested(src_ptl, SINGLE_DEPTH_NESTING);
>   		/*
> -		 * No need to recheck the pmd, it can't change with write
> -		 * mmap lock held here.
> -		 *
> -		 * Meanwhile, making sure it's not a CoW VMA with writable
> -		 * mapping, otherwise it means either the anon page wrongly
> -		 * applied special bit, or we made the PRIVATE mapping be
> -		 * able to wrongly write to the backend MMIO.
> +		 * The mmap and VMA write locks of the source keep faults
> +		 * out, but unmap_mapping_range() does not take the mmap
> +		 * lock and may have cleared the pmd since the lockless
> +		 * read. Let copy_pmd_range() skip it then.
> +		 */
> +		pmd = pmdp_get(src_pmd);
> +		if (unlikely(!pmd_present(pmd) || !pmd_special(pmd))) {

Why not just check pmd_none(pmd) here? We're holding the source mmap/VMA
write locks, so the PMD either stays special or gets cleared, right?

Cheers, Lance

> +			spin_unlock(src_ptl);
> +			spin_unlock(dst_ptl);
> +			return -EAGAIN;
> +		}
> +		/*
> +		 * Make sure it's not a CoW VMA with writable mapping,
> +		 * otherwise it means either the anon page wrongly applied
> +		 * special bit, or we made the PRIVATE mapping be able to
> +		 * wrongly write to the backend MMIO.
>   		 */
>   		VM_WARN_ON_ONCE(vma_is_cow_mapping(src_vma) && pmd_write(pmd));
>   		goto set_pmd;
> 
> ---
> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
> change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2
> 
> Best regards,
> --
> Konstantin Khorenko <khorenko@virtuozzo.com>
> 

