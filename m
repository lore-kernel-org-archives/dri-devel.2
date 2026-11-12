Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C37EF606A321
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=epD/pGIB
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16F0C897F0;
	Thu, 12 Nov 2026 14:47:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 484D4897F0
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 14:47:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794494869;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zZkO3ck5ylqqxi0UIrlQRRScttZ5TDTGZ/TrwmDCCvM=;
 b=epD/pGIBUMPS8zjQ/M9OFPEoR70UQWV1Jl1vOdWBlhxmNGwSSK0KptMXZrYtIzz9nK+BO+
 gSCadsu9XoX71K9bLl2sE8PsMayLri5T8mW5xljmCsOTp7wPuPkQeVMzvNPwoekjxZeDj+
 jH5a5s1HSSxsxzAXjEyBXJLAmTIxzGM=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-mnY_v9Y1NwCmUimd1NnN9A-1; Thu, 12 Nov 2026 09:47:47 -0500
X-MC-Unique: mnY_v9Y1NwCmUimd1NnN9A-1
X-Mimecast-MFC-AGG-ID: mnY_v9Y1NwCmUimd1NnN9A_1794494866
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3adfb79d9acso26608721fa.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 06:47:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494866; x=1795099666;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zZkO3ck5ylqqxi0UIrlQRRScttZ5TDTGZ/TrwmDCCvM=;
 b=dXp3Mc4MKduw5cQrKgQ/7c34eOO8bkJCG7UCDkZE4G+M8G9NXIa1X/h+maESH/uRP/
 hM8JiNjEy4/EUjAZOOlnlu2c2uVn9sC/V7GkT22SjPh480mqoO227NcCVQo78uiBXW8R
 d9uB9odGTc94z6liLBno9BBWPwjgALUYx6+soNTgNxCOgAeLYt9Pkesf4+1BH/+wB6Ld
 3PPwFpjrsWC7E7exvGrODKMAGRwWmkMUvPRIw3nkOb4xALPcQfG4/7KComXAe8M04WDB
 p9vnwxDUh1i/sLskrrtavIcLkdYgLsiA698TuBGGSTbG0Xb0MGhwHTRihXtjbKWr++er
 N0Ng==
X-Forwarded-Encrypted: i=1;
 AL+hErEb6sycXT0V7beDd2ubD758Hfs7PnWVNNvzJfX7eD2t1v5QME8lYWv2EoNl1vQhMu2UCgOAfBm7U0A=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z9SaAz5BKbfzxAqyQvd7//mbdnAk62mTg4kG3zLRfV1mVFf8zGY
 tEOixy/K+6iwsaHM7za7NGu/KxL/5n5pgeXOLojg4EXqEyx3+qV0W/dHz9iRobTwVR3ggB41T43
 j9LrCZbUp3NDcyHnt/YyNVULNb8hjyUdpyZu1/l3TOH/gj50G3YB+f1xr50tLOUEJNLtb
X-Gm-Gg: AYBFou2o9tMDyVUsshcYCP+9yQ9GKxiN93CCQhSS/eYxOxsn1yFujuTEvAuUJoUcOLU
 whzw9fUL1D0Ocf4yUmOC8xgd56tK3UvZfLqNlbnqxnKsHKRQbnfv3d8sIdetlN2Es53kKfVulik
 CTIvcWmA6E3ePZaW+QIZloP1XIidvvJJS/ovl2puEuKRkav/iBZSrCQNrgwuEsu7hZPrk+kbb6i
 hJ3s1DaJhK+1sOD7ORsVE0C3utgIKoIJPEqivdZK3YLkoxBTApS88FFTGGXSoKrXjLLLv3JVaNz
 +JDPuy3DFti+Nj6pXkMArLLH9IuGC/Z8Er6jDTuFf3VclSyLukIihYP7rRXwsUqJzlVQK+HUwVd
 eB0OF6XPg56hMfFC+NaMbXjCjr5ok/CYjaG6OGvONdFg53rWVKWAGLfAlEkpWnepuwon8+2c+5Z
 4D5rkI
X-Received: by 2002:a05:6512:2524:b0:5c1:57ee:1887 with SMTP id
 2adb3069b0e04-5c15d62c702mr2219389e87.13.1794494866130; 
 Thu, 12 Nov 2026 06:47:46 -0800 (PST)
X-Received: by 2002:a05:6512:2524:b0:5c1:57ee:1887 with SMTP id
 2adb3069b0e04-5c15d62c702mr2219357e87.13.1794494865616; 
 Thu, 12 Nov 2026 06:47:45 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157bab834sm1698450e87.45.2026.11.12.06.47.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 06:47:44 -0800 (PST)
Message-ID: <b3689045-d735-451b-8cda-a29d7e79fe63@redhat.com>
Date: Thu, 12 Nov 2026 16:47:43 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/12] migrate on fault for device pages
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
To: Alexandru Elisei <alexandru.elisei@arm.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <avWpWBl1nPcRVmpQ@raptor> <79f33ab0-2e43-4efb-94d0-addaf40745ec@redhat.com>
In-Reply-To: <79f33ab0-2e43-4efb-94d0-addaf40745ec@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dzJam2lGWkSp2kmjwdP8q1FKTtcvTlYo22DUrFd7GU8_1794494866
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/12/26 16:00, Mika Penttilä wrote:
> Hi Alexandru!
>
> On 11/12/26 13:56, Alexandru Elisei wrote:
>> Hi Mika,
>>
>> I want to help getting this series merged, and I've been familiarizing myself
>> with hmm and device migration, please bare with me if the questions I'm asking
>> are obvious or downright silly.
> Thanks for the interest and willing to help! I am preparing a v18 of the
> series and plan to post it early next week.
>
> I try to answer your questions, there are quite a bunch of them!
>
>> On Tue, Nov 03, 2026 at 08:16:17AM +0200, mpenttil@redhat.com wrote:
>>> From: Mika Penttilä <mpenttil@redhat.com>
>>>
>>> Currently, the way device page faulting and migration works
>>> is not optimal, if you want to do both fault handling and
>>> migration at once.
>>>
>>> Being able to migrate not present pages (or pages mapped with incorrect
>>> permissions, eg. COW) to the GPU requires doing either of the
>>> following sequences:
>>>
>>> 1. hmm_range_fault() - fault in non-present pages with correct permissions, etc.
>>> 2. migrate_vma_*() - migrate the pages
>>>
>>> Or:
>>>
>>> 1. migrate_vma_*() - migrate present pages
>>> 2. If non-present pages detected by migrate_vma_*():
>>>    a) call hmm_range_fault() to fault pages in
>>>    b) call migrate_vma_*() again to migrate now present pages
>> Regarding both sequences, I'm trying to get a better understanding of what
>> the issue is. I assume the caller wants to fault in system memory, and then
>> migrate it to the device. Is that correct?
> Yes that's the common thing to do.
>
>
>> In my analysis I'm also not going to refer to THPs, since that would make
>> things even more complicated than they are. I think we can come back to
>> THPs later if we think it would be useful.
>>
>> For the !pte_present() case:
>>
>> Sequence 1: hmm_range_fault() -> .. -> hmm_vma_handle_pte() handles
>> !pte_present() pages in two ways: faults in swap pages and device private
>> pages belonging to a different device, and waits on migration entries. Then
>> the migrate_vma_*() flow is used to migrate the range.
>>
>> Sequence 2: migrate_vma_setup() ignores !pte_present() page table entries
>> After this, the caller follows the same steps as in sequence 1 -
>> hmm_range_fault() faults in !pte_present() pages, and migrate_vma_*() is
>> called again to migrate the pages that were faulted in/waited on by
>> hmm_range_fault().
>>
>> Now, for the CoW case that you mentioned, I'm going to assume that the
>> caller wants write permissions otherwise nothing needs to be done:
>>
>> Sequence 1: hmm_range_fault() -> hmm_vma_handle_pte() records a fault
>> (hmm_pte_need_fault() returns HMM_NEED_FAULT | HMM_NEED_WRITE_FAULT),
>> handle_mm_fault() -> .. -> do_wp_page() breaks CoW and maps an exclusive
>> folio with write permissions, then the migrate_vma_* flow will take care of
>>
>> Sequence 2, migrate_vma_setup() installs migration entries for the page,
>> then migrate_vma_finalize() replaces the migration entries with device
>> private entries.
>>
>> Looks to me that for CoW pages, all that's needed is migrate_vma_*(), and
>> the subsequent calls to hmm_range_fault() and migrate_vma_*() are not
>> necessary. Is that your conclusion too?
> For  a device fault: the driver want the data in device memory with the
> permissions the device asked for. Your !pte_present() analysis matches;
> note that pte_none() in anonymous vmas and the zero page don't need
> hmm_range_fault() at all, migrate_vma_*() populates them directly.
> That's why the common case is cheap with sequence 2, and only swap
> entries, other devices private pages and migration entries need the
> extra walks.
> For cow with write intent migrate_vma_*() alone is enough.

Is *not* enough meant to say


--Mika


