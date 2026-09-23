Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C08CC982EA
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:29:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8F7D210E7F2;
	Wed, 23 Sep 2026 05:29:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="e+1vUWUJ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26A1D10EEA9
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790141390;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w2vrYuRJ8qL5kWsy9Tz/qOHqUgXc8+IhHfJ0Nm3O5oI=;
 b=e+1vUWUJzuXaZZOaj+ck6I4B8IkNdBLNwCKHCyuuWSQwx/OMMf790TE1UmDH+sawY1ciBO
 1Kk4cpwnBmL56dfJQdFv/xGXbKCrLyIMkNPsLo5rgxDJe651N4hj32KgQk+BF4GlH4nf66
 GEFnOE8Mp24Bhy5DYU7yrXZwrAlgw5w=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-eJVjNqPVP4ON8SK9xs0-kw-1; Wed, 23 Sep 2026 01:29:38 -0400
X-MC-Unique: eJVjNqPVP4ON8SK9xs0-kw-1
X-Mimecast-MFC-AGG-ID: eJVjNqPVP4ON8SK9xs0-kw_1790141377
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3a59a300bfdso2076261fa.1
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 22:29:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790141377; x=1790746177;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w2vrYuRJ8qL5kWsy9Tz/qOHqUgXc8+IhHfJ0Nm3O5oI=;
 b=T7KbAkJjNMznlXZteumBGBkH9+/LJJkGa51mfQ1N90EJ6VADNWGCvIgPNfL3RbanaR
 ZfLm64QPkrpsE1CzPdDkd7Z2P2VmmBbFeZ6OyeEp9pANyRUx8zPldLkscvRW1R56PGVL
 K75c1xLhxb2ZIjq26ikuFaFLZMwGMavNi8MLrIl9lf1CbcScea8IUjvPD1cXFVXj1MxV
 MgBYcQMrzATsuScHOwNAS4xoD0Z5v+S89ZRbgtoDZ/W5BwS0cUNO/WkrZxCvfZ7DH9SU
 LPr5OsXfb6KzPhZNdJbrhKb15Xnp3WPtIqljWEI5QgUhja1lsv3Iz+2RyUGAH2vjW+Xo
 DJyw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxyHiyXgnzGSTpFVwNBe6PJF90n4IliItO8SAolnwZQED1cwJTkWDMoNSiWolh0WuBiZ+6FaGgt9Fw=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lP1EjnX+qmZJjFEKYjnK3Ev/wuXiVDvqMvWGCnwlo0X5dX/VsJ
 yOuDdgYEM0/gNLd7ExWfh/1/zqF3snrm446hbW2D3R7P1iDuJVttMc0Ugj/oIiB/8RtYOCoG31I
 TjBaj7sTDH2+1xLIRlxAWn6VbjUIBvZod6pZLHPOYT28DUytZ1/HI/BDDaCByiCqwLsud
X-Gm-Gg: AYBFou3tKz0eas9ypRgPFEt7viu9Aga9f0a1lbjEvbbI3XdK+jse3VQw67dUX331F6/
 srROnC9VouctIm0JHs+ntGemgYztvuHEhKtZXzu0UyqWC5VTb558mUiRe51F9eyg+XJMawLchVV
 oXRYQfwIp8o0GXa/Oh8LO4ESvdJyh3xlHsz/gmYooBO+ZC49M3yetoxxTiAC2KZE0vFz/PgIg5Y
 DVhH0BFQdazVl5P7vw6446lnyJievsxPtzHjWobDg/l0M3UIvlL8zouKK3nRF++H+UJfzMZKjpW
 NdH8rOIfg9Cr/JCugnuJxhdp/7EFsjLK3MWmH39Zl1KlZJcdugsyHsXTvC2qC5NLtolTm/3gAIr
 dvI2RkMl7apANQ6b3Yi1UAuYcnSGGqKc=
X-Received: by 2002:a05:651c:2119:b0:3a1:980f:5907 with SMTP id
 38308e7fff4ca-3a63062bc97mr2957811fa.8.1790141376710; 
 Tue, 22 Sep 2026 22:29:36 -0700 (PDT)
X-Received: by 2002:a05:651c:2119:b0:3a1:980f:5907 with SMTP id
 38308e7fff4ca-3a63062bc97mr2957691fa.8.1790141376203; 
 Tue, 22 Sep 2026 22:29:36 -0700 (PDT)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f507e7bsm3916101fa.22.2026.09.22.22.29.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 22:29:35 -0700 (PDT)
Message-ID: <5b1d0fa6-d183-446e-bc52-56e0afd3f398@redhat.com>
Date: Wed, 23 Sep 2026 08:29:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] [PATCH v14 00/12] migrate on fault for device pages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922192726.90dec3c4c77b8c9063dbf218@linux-foundation.org>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20260922192726.90dec3c4c77b8c9063dbf218@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i155iiZW7bd1N__yUeNYowX9E6YBeGLsO1tx0sWns_4_1790141377
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


On 9/23/26 05:27, Andrew Morton wrote:

> On Tue, 22 Sep 2026 08:34:09 +0300 mpenttil@redhat.com wrote:
>
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
> Sounds sensible.
>
>> Tested in X86-64 VM with HMM test device, passing the selftests.
>> For performance, the migrate throughput tests from the selftests
>> show similar numbers (within error margin) as unmodified kernel.
> But no performance benefits are demonstrated?

There are no performance regressions for current tests.
Real benefits come if want to do migrate on fault.
For migrate on fault today missing pages are collected as not-present and
the caller has to fault them and re-run migrate_vma_setup(); folding 
HMM_PFN_REQ_FAULT into the collecting walk removes that extra
fault+retry round-trip, dropping two page table walks. Page table walks
are not cheap. Not to mention simplified implementation for driver.
Also, the vma looked up as part of the walk is readily available for
migration, eliminating the need for explicit vma lookup - one more
performance benefit. Net effect two saved page table walks and
one vma lookup.
This series also addresses the vanished/reborn page table while
collecting problem which can crash current implementation.

--Mika

