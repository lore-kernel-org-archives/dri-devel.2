Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A050CC6B1D
	for <dri-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:04:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8FFEE10FE94;
	Wed, 14 Oct 2026 16:04:50 +0000 (UTC)
Received: from mta0.migadu.com (out-27.mta0.migadu.com [91.218.175.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 13F2710FE88
 for <dri-devel@lists.freedesktop.org>; Wed, 14 Oct 2026 16:04:43 +0000 (UTC)
X-Envelope-To: dri-devel@lists.freedesktop.org
DKIM-Signature: a=rsa-sha256; bh=PI0fOAv5zzJ41Ji3Z2QtwoPTiCXvJem5/RFTA0ekY0U=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1791993881; v=1; x=1792598681;
 b=FB2ic1WGugcHaPbviCEivRkLZWw6rAaFPdy2BZYb5aDlbMVpLQ4QRp/EaFsTU3lA6tRJugoS
 l/P+Y1zD2kd/5w573b/aFKTNx03vEhPg5K6XeQ/2N/QhYiJ3qoDoGXWldnKvH6p88DlRCbbU0h+
 /CIC+skOEpBCvkjLuyFJijRo=
X-Envelope-To: dri-devel@lists.freedesktop.org
Received: by smtp.migadu.com with ESMTPS id 0ac52b3081cf7048;
 Wed, 14 Oct 2026 16:04:41 +0000
X-Mizu-Trace-ID: 0ac52b3081cf7048
X-Migadu-Flow: FLOW_OUT
Message-ID: <73f0dafd-5b26-42b9-a77b-90c32976942f@linux.dev>
Date: Thu, 15 Oct 2026 00:04:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/2] mm/huge_memory: fix the copy of special PMDs at
 fork
Content-Language: en-US
To: Konstantin Khorenko <khorenko@virtuozzo.com>, Zi Yan <ziy@nvidia.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>, Nico Pache <nico.pache@linux.dev>,
 Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>,
 Barry Song <baohua@kernel.org>, Usama Arif <usama.arif@linux.dev>,
 Kiryl Shutsemau <kas@kernel.org>, Peter Xu <peterx@redhat.com>,
 Alex Williamson <alex@shazbot.org>, kvm@vger.kernel.org,
 =?UTF-8?Q?Lo=C3=AFc_Molinari?= <loic.molinari@collabora.com>,
 dri-devel@lists.freedesktop.org, Madhavan Srinivasan <maddy@linux.ibm.com>,
 "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>,
 linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
References: <20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v3-0-85eaec8417f6@virtuozzo.com>
 <F6337325-E635-43BB-9E5E-DCD25F4FC951@nvidia.com>
From: Lance Yang <lance.yang@linux.dev>
In-Reply-To: <F6337325-E635-43BB-9E5E-DCD25F4FC951@nvidia.com>
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



On 2026/10/14 23:57, Zi Yan wrote:
> On 14 Oct 2026, at 11:46, Konstantin Khorenko wrote:
> 
> <snip>
> 
>>
>>
>> Signed-off-by: Konstantin Khorenko <khorenko@virtuozzo.com>
>> ---
>> Changes in v3:
>> - Patch 1: recheck the PMD with pmd_none(), as only a zap can change
>>    it and a zap leaves it none (Lance Yang).
>> - Link to v2: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v2-0-e1548488fa68@virtuozzo.com
>>
>> Changes in v2:
>> - Add patch 2, the page table deposit for ppc64 hash, reported by
>>    Sashiko.
>> - Patch 1: name panthor instead of drm_gem_shmem as the driver whose
>>    stale child mapping reaches freed pages: drm_gem_shmem keeps the
>>    pages of a purged object until the last mapping goes away.
>> - Link to v1: https://patch.msgid.link/20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-v1-1-d225c60bc316@virtuozzo.com
>>
> 
> Please stop sending new versions of a patchset repeatedly.
> Wait at least a day for others to catch up.

+1

Please slow down a bit. You don't need to respin every few
hours. That just makes everyone start over ...

Post a version, wait for feedback, then revise. Twice a week
is plenty, honestly :)

Cheers, Lance

> Thanks.
> 
>> ---
>> Konstantin Khorenko (2):
>>        mm/huge_memory: recheck a special PMD under the lock in copy_huge_pmd()
>>        mm/huge_memory: deposit a page table for a special PMD copied by fork
>>
>>   mm/huge_memory.c | 34 +++++++++++++++++++++++++++-------
>>   1 file changed, 27 insertions(+), 7 deletions(-)
>> ---
>> base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
>> change-id: 20261014-b4-prep-vstor-149847-copy_huge_pmd-recheck-special-pmd-bdf7efb612c2
>>
>> Best regards,
>> --
>> Konstantin Khorenko <khorenko@virtuozzo.com>
> 
> 
> Best Regards,
> Yan, Zi

