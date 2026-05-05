Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6653CD13DA
	for <dri-devel@archiver.kernel.org>; Tue,  5 May 2026 07:18:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E968B10E99D;
	Tue,  5 May 2026 07:18:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="PSEuGZYl";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80A7C10E9A4
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 07:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777965500;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U8Okzffkmp0X0il5ChdwD7WwCI7y675UlHMmtZ9sMKU=;
 b=PSEuGZYlHwpT8hLpSia8/GXY4GxsJNjQMH0/dd2Jna2bM2g2zR9QsucxdbN74K7w2H4pqS
 UIcq4IMXGxFCjg8eo/yR6w5mrfzA9nmSsWIp5LdPdHk09JCrv0nhcEgf/0xYx4SaIyObXq
 +NubJsIkL94Pkh1s9q6yACQPp81d6dY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-Vye4wC1zMVmZ64MorJOH9A-1; Tue, 05 May 2026 03:18:17 -0400
X-MC-Unique: Vye4wC1zMVmZ64MorJOH9A-1
X-Mimecast-MFC-AGG-ID: Vye4wC1zMVmZ64MorJOH9A_1777965496
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-5a407fad7e0so2420404e87.0
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 00:18:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777965496; x=1778570296;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=U8Okzffkmp0X0il5ChdwD7WwCI7y675UlHMmtZ9sMKU=;
 b=D0z7sWBrRpYuott1MrzBYWbGmPTAEeiMO0GKGv6TCuW1KhDe5jdFQRgccRt1n2HpKG
 r9Zg3COmfWh9k4rzZb3IyEtOjk4UhP7nXAcTBrudJll9zh0QMkI8D+/z9szZZvDsFwMP
 4Zz7d2sWsPBVir30zx14jUdBVBIQzJaMUVDTR33zeAE/iQp69hU3EKweHnwCUOwZZnPZ
 IyBO09Hs5DcbpFGk/fXaqafpcy533VL6OiD2fe8KwUvAGs4+BxqaXaRlM/8Lci0ojuuG
 Oce8C8m6vxLompwgylTyVZvDvmtkfIWfm+MPXZ2ae9uic02wguJxWseue+E5u8L157yN
 hf0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ87vld67XrixNGB2/p1z2QEGlOw32oFqZ5d+yMI5YP2x71aX4X8rWq9cR6A0iGqdNivuFj50UOCJcc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx+Unqbkodsvg0wMgW48C9l11Dir5kK3oWxEVhVKEs8iC+dHtxb
 DTJMVNcW1d+RqDIt35wGgQSYodN0lMCdbWjgE+ZtR5mdiR6vGH6lZaHJOSfKtH8vB9a5FOC0C8N
 5h2rSdE5dxR82EhcJQ6FWNivtuknHmcladzigCpGVIoNqomlb1Kr/apA6IEMB3FMxwFdH
X-Gm-Gg: AeBDieuv8f+MEsMNRFJ8dpfiQS0Vt9zvplMLbNYYh+Yzo6/686CYepu50qd6u7VMS/m
 vArx7tDnqIdFVhq5u1/cf80NGEl+bYGQiDveqbtK3+0rXq/mHul7nSt9/iKuGMiL35cakw47jqD
 cRKBUTxs2HwAXOx0vgDGDX+zhIEWfShBr+/DrHy4IDzqrqXlHdHRrTikN1sNi5XkEmrUkL949aB
 /+HHOdPQReNoeVbNPeKe2vi75oKswVb2WIrifh/nj9TCrgbyVjyzRfAE2HYUV2Fu+nOVZ3fuiD4
 3h+vT+H5gyAPI3JKYieQia01mimUZHenZajMIm9T1Zbz2vNogvt3CdXO8l4KrLA+Txsgv9Az10R
 3cv8v4eI/rfVRFkbTdHD5AWk8Nt68jmm/oDwA+WKlLT73LsK7woJadnLY9A==
X-Received: by 2002:a05:6512:2527:b0:5a8:64cd:4d7d with SMTP id
 2adb3069b0e04-5a864cd4d86mr4224308e87.37.1777965496062; 
 Tue, 05 May 2026 00:18:16 -0700 (PDT)
X-Received: by 2002:a05:6512:2527:b0:5a8:64cd:4d7d with SMTP id
 2adb3069b0e04-5a864cd4d86mr4224268e87.37.1777965495404; 
 Tue, 05 May 2026 00:18:15 -0700 (PDT)
Received: from [192.168.1.86] (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a87791b4a2sm1029451e87.1.2026.05.05.00.18.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 00:18:14 -0700 (PDT)
Message-ID: <ecd81b6b-62ef-4dab-a93e-e65598d64841@redhat.com>
Date: Tue, 5 May 2026 10:18:14 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 0/5] Migrate on fault for device pages
To: Alistair Popple <apopple@nvidia.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260505051658.2219537-1-mpenttil@redhat.com>
 <afmXIq8VY_vs1GPo@nvdebian.thelocal>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <afmXIq8VY_vs1GPo@nvdebian.thelocal>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: CzVMQgrDHWHWoBinuf6kq0dnkGDlyHFsZUOc8lL6EGQ_1777965496
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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


On 5/5/26 10:09, Alistair Popple wrote:

> Thanks for doing this work Mika. I've been meaning to take a look at this series
> for a while. I'm currently at LSFMM but will try and take a look this week or
> next as it sounds quite useful.
>
>  - Alistair

Thanks Alistair and no problem, appreciate your insights whenever you have time.

--Mika

>
> On 2026-05-05 at 15:16 +1000, mpenttil@redhat.com wrote...
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> Currently, the way device page faulting and migration works
>> is not optimal, if you want to do both fault handling and
>> migration at once.
>>
>> Being able to migrate not present pages (or pages mapped with incorrect
>> permissions, eg. COW) to the GPU requires doing either of the
>> following sequences:
>>
>> 1. hmm_range_fault() - fault in non-present pages with correct permissions, etc.
>> 2. migrate_vma_*() - migrate the pages
>>
>> Or:
>>
>> 1. migrate_vma_*() - migrate present pages
>> 2. If non-present pages detected by migrate_vma_*():
>>    a) call hmm_range_fault() to fault pages in
>>    b) call migrate_vma_*() again to migrate now present pages
>>
>> The problem with the first sequence is that you always have to do two
>> page walks even when most of the time the pages are present or zero page
>> mappings so the common case takes a performance hit.
>>
>> The second sequence is better for the common case, but far worse if
>> pages aren't present because now you have to walk the page tables three
>> times (once to find the page is not present, once so hmm_range_fault()
>> can find a non-present page to fault in and once again to setup the
>> migration). It is also tricky to code correctly. One page table walk
>> could costs over 1000 cpu cycles on X86-64, which is a significant hit.
>>
>> We should be able to walk the page table once, faulting
>> pages in as required and replacing them with migration entries if
>> requested.
>>
>> Add a new flag to HMM APIs, HMM_PFN_REQ_MIGRATE,
>> which tells to prepare for migration also during fault handling.
>> Also, for the migrate_vma_setup() call paths, a flag, MIGRATE_VMA_FAULT,
>> is added to tell to add fault handling to migrate.
>>
>> One extra benefit of migrating with hmm_range_fault() path
>> is the migrate_vma.vma gets populated, so no need to
>> retrieve that separataly.
>>
>> Tested in X86-64 VM with HMM test device, passing the selftests.
>> For performance, the migrate throughput tests from the selftests
>> show similar numbers (within error margin) as unmodified kernel.
>> Tested also rebased on the
>> "Remove device private pages from physical address space" series:
>> https://lore.kernel.org/linux-mm/20260130111050.53670-1-jniethe@nvidia.com/
>> plus a small patch to adjust with no problems.
>>
>> Changes v8-v9
>>   - rebase on drm-tip
>>   - fixed uaf around  migrate_vma_split_folio() usage
>>   - added missing pmd unlock
>>
>> Changes v7-v8
>>   - rebase on 7.0
>>   - fixed subject in two patches
>>   - enhanced commit messages
>>   - squashed patch 6 into patch 4 to fix kernel test robot warning
>>   - readded dropped Cc block from cover letter
>>   - fixed white space
>>
>> Changes v6-v7
>>   - rebase on 7.0.0-rc6
>>   - added documentation and comments
>>   - denote to be migrated zero page as HMM_PFN_MIGRATE alone
>>   - got rid of HMM_PFN_INOUT_FLAGS movement in patch 2
>>   - picked up Acked-By from David for patch 1
>>   
>> Changes v5-v6
>>   - rebase on 7.0.0-rc4
>>   - use range based TLB flushing while unmapping ptes
>>   - gate migration behind HMM_PFN_REQ_MIGRATE for fault and
>>     migrate paths
>>   - always infer migration flags from migrate->flags only
>>
>> Changes v4-v5
>>   - rebase on 6.19
>>   - fixed David's email address
>>   - fixed link issue without CONFIG_TRANSPARENT_HUGEPAGE
>>   - refactored into smaller commits
>>   - added more comments to code
>>
>> Changes v3-v4:
>>   - rebase on 6.19-rc8
>>   - fixed issues found by kernel test robot with random configs
>>   - fixed typos
>>
>> Changes v2-v3:
>>   - rebase on 6.19-rc7
>>   - fixed issues found by kernel test robot
>>   - fixed smatch issues reported by Dan Carpenter <dan.carpenter@linaro.org>
>>   - fixes to lock handling (pmd/pte) on errors
>>   - added assertions for pmd/pte lock states
>>   - other issues discovered by Matthew, thanks!
>>
>> Changes v1-v2:
>>   - rebase on 6.19-rc6
>>   - fixed issues found by kernel test robot
>>   - fixed locking (pmd/ptl) to cover handle_ and prepare_ regions
>>     parts if migrating
>>   - other issues discovered by Matthew, thanks!
>>
>> Changes RFC-v1:
>>   - rebase on 6.19-rc5
>>   - adjust for the device THP
>>   - changes from feedback
>>
>> Revisions:
>>   - RFC https://lore.kernel.org/linux-mm/20250814072045.3637192-1-mpenttil@redhat.com/
>>   - v1: https://lore.kernel.org/all/20260114091923.3950465-1-mpenttil@redhat.com/
>>   - v2: https://lore.kernel.org/all/20260119112502.645059-1-mpenttil@redhat.com/
>>   - v3: https://lore.kernel.org/all/20260126111939.1332983-2-mpenttil@redhat.com/
>>   - v4: https://lore.kernel.org/all/20260202112622.2104213-1-mpenttil@redhat.com/
>>   - v5: https://lore.kernel.org/linux-mm/20260211081301.2940672-1-mpenttil@redhat.com/
>>   - v6: https://lore.kernel.org/linux-mm/20260316062407.3354636-1-mpenttil@redhat.com/
>>   - v7: https://lore.kernel.org/linux-mm/20260330115611.347988-1-mpenttil@redhat.com/
>>   - v8: https://lore.kernel.org/linux-mm/20260414041226.1539439-1-mpenttil@redhat.com/
>>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Leon Romanovsky <leonro@nvidia.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>>
>> Mika Penttilä (5):
>>   mm/Kconfig: changes for migrate on fault for device pages
>>   mm: Add helper to convert HMM pfn to migrate pfn
>>   mm/hmm: do the plumbing for HMM to participate in migration
>>   mm: setup device page migration in HMM pagewalk
>>   lib/test_hmm:: add a new testcase for the migrate on fault
>>
>>  include/linux/hmm.h                    |  19 +-
>>  include/linux/migrate.h                |  26 +-
>>  lib/test_hmm.c                         | 101 ++-
>>  lib/test_hmm_uapi.h                    |  19 +-
>>  mm/Kconfig                             |   2 +
>>  mm/hmm.c                               | 835 +++++++++++++++++++++++--
>>  mm/migrate_device.c                    | 583 +++--------------
>>  tools/testing/selftests/mm/hmm-tests.c |  54 ++
>>  8 files changed, 1066 insertions(+), 573 deletions(-)
>>
>> drm-tip
>> base-commit: 94d56a898a2db27f841b17f6966a81ba502fe63c
>> -- 
>> 2.50.0
>>

