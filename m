Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 687E2C9830D
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 00:14:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8938E10E500;
	Thu, 24 Sep 2026 00:14:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="V2VbHjaN";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F22910E38B
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 00:14:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790208881;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Arg2o/O+mZYGRcJkQWOkHlb3811XT5pVkK165f7ivAA=;
 b=V2VbHjaNsdAx3H6O9wpD/Su6eRBqO1F6tAjqUooF9SimEYADmO4GshvRjtG90uP/xDcrDx
 yMFvXafX9TBKhte0HS8bHPs1362aSxz3KYWi3nNrR2igiiZbSp/d/2BiipciCwmypmOEsZ
 q26Aa0jtn71fsWZ0Am23vxwVxvRFlAc=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-586-iS0LBlwEMHyp_m7kzyrcYg-1; Wed, 23 Sep 2026 20:14:39 -0400
X-MC-Unique: iS0LBlwEMHyp_m7kzyrcYg-1
X-Mimecast-MFC-AGG-ID: iS0LBlwEMHyp_m7kzyrcYg_1790208878
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a208b764f1so6331671fa.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 17:14:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790208877; x=1790813677;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Arg2o/O+mZYGRcJkQWOkHlb3811XT5pVkK165f7ivAA=;
 b=yelih454ypBS8SdIdRYLEUHenFDF/wdU3DHCTDL/q1XCpcaGtklAoYiDh5Q75fCYTu
 PEeDLA0Je3/HR+N+noABI346J/QOdsSb+kQ1WX7+zUOmF7Yt+qq0e57RihGk3cQj2rzA
 LmKu7xedvcbJTMBE45hbb8bSoKpKcR1TKZ9slU8jejDFrSUk4vgOEo4U5D3PTxIVYwBi
 IjtUgC1bVvujEBBBBtW7ij0k+MBTg8fxOvnnfN9nWohvscds+lg6P/H38ZLwB1lcM/ue
 HHMFART91t0bNCsWLdoA9S9mHjRRNGwwPKphfnpAOjICeoi7ZxAI76+X34yOv5ZMnIKt
 iWug==
X-Forwarded-Encrypted: i=1;
 AKwUvBxaPS4ZAvbjoi/fZ7ljG/9LERi0uI4TgL+QpFkKIQo/lv+UnUIVg7blDdQqpWDY0qRn3XofsG3vQq8=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kyhdXb3rsgz4AsQ1mfYx2JBidVs1z+lXz/kn8T1+SdpNbyGWBs
 w9BpHOI7vvdY6RdjZrzTiT+8gd6B4SZWJfxV0HGSuE3Wf/jrKKIru2KFaYmGWutUYfNf+ejebnL
 VSGgL8RK0LpNTQBjQQFCh0q1XcqtTZ6Lu/FHH9O+J1uDE4DLK9cyVJY2JAtVjIxAeE4KG
X-Gm-Gg: AYBFou3DPuNJFOr3P7QMPP7nbYfuGtF9k/MHNN3ljo2vVezbDGuE/zu+3cltQ6gaPw+
 mMMWsXQdbH4mrdNJKiLW2SqiH3zpI9r0AIKf/bM58wdXmhxEugIQpScQfLi7MpPgsSw7fGEo9QE
 tBOacgw65I/eIq+KxUYwfb9EjASBoveCxq6nCrXWZovUDkxiD4iICRB7HzSczXHQKCKj2IoCZqa
 n6IP73voENJmmI9yyeqPwclWyMJijMcmIIxclpb8TKLI3CYixNW5bo+EnDLnYTrhXFBcoUBiE9Y
 deY4TfMyXuBFTCx9WfyON5fHY6I4mrJJI9wNkTU4Onhvm4wLb5euPa0cE1v+d2ex9k2nipQWhUe
 5z1BF/4XJphs/Kw2m46E+FXIuo7FUuC8=
X-Received: by 2002:a05:651c:15c4:20b0:3a3:7680:67f9 with SMTP id
 38308e7fff4ca-3a63c2edc6amr1104521fa.24.1790208877410; 
 Wed, 23 Sep 2026 17:14:37 -0700 (PDT)
X-Received: by 2002:a05:651c:15c4:20b0:3a3:7680:67f9 with SMTP id
 38308e7fff4ca-3a63c2edc6amr1104501fa.24.1790208876835; 
 Wed, 23 Sep 2026 17:14:36 -0700 (PDT)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a63bdbc5dfsm2340611fa.5.2026.09.23.17.14.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Sep 2026 17:14:36 -0700 (PDT)
Message-ID: <205181b9-9677-4fcb-873c-732a503fabd9@redhat.com>
Date: Thu, 24 Sep 2026 03:14:35 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] [PATCH v14 00/12] migrate on fault for device pages
To: Jason Gunthorpe <jgg@nvidia.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Leon Romanovsky <leonro@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Balbir Singh <balbirs@nvidia.com>,
 Zi Yan <ziy@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett"
 <Liam.Howlett@oracle.com>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922192726.90dec3c4c77b8c9063dbf218@linux-foundation.org>
 <5b1d0fa6-d183-446e-bc52-56e0afd3f398@redhat.com>
 <20260923141936.d1f9e5b85355f0bdc6a6ecd2@linux-foundation.org>
 <20260923232402.GI2545495@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20260923232402.GI2545495@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O4rYo6EJFjXP4ua-MjqglxOhYD_mWpgy2ki8CvEa9v0_1790208878
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


On 9/24/26 02:24, Jason Gunthorpe wrote:

> On Wed, Sep 23, 2026 at 02:19:36PM -0700, Andrew Morton wrote:
>> On Wed, 23 Sep 2026 08:29:34 +0300 Mika Penttilä <mpenttil@redhat.com> wrote:
>>
>>>>> migration). It is also tricky to code correctly. One page table walk
>>>>> could costs over 1000 cpu cycles on X86-64, which is a significant hit.
>>>>>
>>>>> We should be able to walk the page table once, faulting
>>>>> pages in as required and replacing them with migration entries if
>>>>> requested.
>>>> Sounds sensible.
>>>>
>>>>> Tested in X86-64 VM with HMM test device, passing the selftests.
>>>>> For performance, the migrate throughput tests from the selftests
>>>>> show similar numbers (within error margin) as unmodified kernel.
>>>> But no performance benefits are demonstrated?
>>> There are no performance regressions for current tests.
>>> Real benefits come if want to do migrate on fault.
>>> For migrate on fault today missing pages are collected as not-present and
>>> the caller has to fault them and re-run migrate_vma_setup(); folding 
>>> HMM_PFN_REQ_FAULT into the collecting walk removes that extra
>>> fault+retry round-trip, dropping two page table walks. Page table walks
>>> are not cheap. Not to mention simplified implementation for driver.
>>> Also, the vma looked up as part of the walk is readily available for
>>> migration, eliminating the need for explicit vma lookup - one more
>>> performance benefit. Net effect two saved page table walks and
>>> one vma lookup.
>> It certainly sounds that this series will result in performance
>> improvements, but have those improvements been quantified?
>>
>>> This series also addresses the vanished/reborn page table while
>>> collecting problem which can crash current implementation.
>> Oh.  I didn't get that message from the v14 changelogs, and crashes in
>> the current implementation are not what we want.  In fact, addressing
>> those is more important than speeding things up.
> Yeah, what is this about?
>
> The series still has lots of sashiko remarks, are they legit?

Some of them are legit some not. This was actually the first time sashiko
managed to apply the series. I will address all the remarks in v15 soon.

>
> Jason

--Mika


>

