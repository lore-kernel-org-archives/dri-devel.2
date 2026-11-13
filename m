Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B9A9606A321
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Bbcq+flr
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CA9B10E79E;
	Fri, 13 Nov 2026 09:12:10 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3AF6810EC0B
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 09:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794561123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=l9qjP3EolVZNhFJ6yU6oKwddBCb6NF0vJywntTMZ9kE=;
 b=Bbcq+flrN8v/wCVVGVAvLeQHYqeHKGAKvnYn2qguXzBp3Y11tHYrehbqA7hrqEWLYmYbrs
 Apvgyz+aHNgkFzXQSGg1f8nGbrsPSFLeLE/5lUlURaaFZ4825exN9Zg83Fic8FRjtdHuoo
 0PepzX+FKVqKyn7WLblblOXgl6J96iQ=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-vXuiFP_7O2qtzbLkJsSc-A-1; Fri, 13 Nov 2026 04:12:01 -0500
X-MC-Unique: vXuiFP_7O2qtzbLkJsSc-A-1
X-Mimecast-MFC-AGG-ID: vXuiFP_7O2qtzbLkJsSc-A_1794561120
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-3ad36e654f1so7373751fa.3
 for <dri-devel@lists.freedesktop.org>; Fri, 13 Nov 2026 01:12:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794561120; x=1795165920;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=l9qjP3EolVZNhFJ6yU6oKwddBCb6NF0vJywntTMZ9kE=;
 b=jhDMgGxp870h7lpzAyLDKImQcmbv2CblwZzflZQiFc+SO3ZBu06XBXBOCvwGffsQXY
 D6x61wt+r5UWmNEGyDfhhBN9f0VDvd6mz+96RZ/elqiI448meSYL8BnEeSjzpRuwyUdE
 D+w3lwuRkGCPiHtrVClbRPkV9bTFoSxmCvFD7Il7ltY/+p2aTNGBzeD43nHmOhMRx7bd
 YQu7T6oPyr5JyV5pyZy/ltXvawOP++AdCgmePI+Z3ClgSGIP7nGXV9U9Dg1wW+8qn1ZU
 8stlKQO2O3Ayd1ZO01nhYG91O/Q3TGkqJbP40YKg/ro28X9XlsWJjWk34RGjHugGyiDk
 ywRQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGnJaqlEpnt939haZ4c90gX10Ug0RPej95ZbBQ+zM2FclCFtVQpybID15Pk7QPduhmTNKIaOZQ5OIM=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+K/8GBsllV/ScsW20I9Kv26ITmU7WKQgXVB3bLLE4D1HYKq/5e
 YszjByB1vmSRCTldHwZrzN/bRMLfXZFQUVd2Wu1iocr+DQSWBk6HxjzexwD3AcA01eK8xTkW2dc
 v2ReZTDDovoQ/DhxEjE8L0fjIuwD+fcAQRGXIRUQ0BKelcy0HmFwbIQn6Zt/BQSjVNPFF
X-Gm-Gg: AYBFou0LXaEvOf0YgmiKYATmwkrIwjJuEynq+BdFP1lWRyrCxYGH/ST38SO6WeCKqHb
 5+2KkHAcxyg1zYtU3oLhK2f4E2Mkts39tlUz5ZOr/La9H1rNsmtNK2CvRUyApN6z51wBDLNWcO8
 vWRlQup1Hw3sFoUDqTEXgqSS1R0H0I5zvODMZOFtPZGhdaFAtQoX7OBIGsK27FneaC3SN1BoCEH
 qXJsyaDNDLx/czN43kPaiWZ766cUrVyZ1fubkFi4IPZrI/R0GOnMTod/O+ARmwyYqLKghoovdUP
 u0Gw6Kmko5iG9lKmp1ivuHMjyzcKBuehekEm7oAKksAK9J+VZ9/2UiPhPTGPrmPWcChmBmKdMxF
 64uoKpsiPKTDH8qCnVZhZ16VhRWch4fg99GTfZTnwG98w9SDwuNXWjj76wuNE9RN1qNM83vasMD
 VnznrG
X-Received: by 2002:a05:651c:a347:b0:3ad:f8cc:390 with SMTP id
 38308e7fff4ca-3ae2b4bc3f1mr7065991fa.11.1794561120259; 
 Fri, 13 Nov 2026 01:12:00 -0800 (PST)
X-Received: by 2002:a05:651c:a347:b0:3ad:f8cc:390 with SMTP id
 38308e7fff4ca-3ae2b4bc3f1mr7065831fa.11.1794561119826; 
 Fri, 13 Nov 2026 01:11:59 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae2b76a91fsm6490801fa.8.2026.11.13.01.11.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 01:11:58 -0800 (PST)
Message-ID: <2ad4f730-0656-4b2e-8cbb-4aaae44de1cd@redhat.com>
Date: Fri, 13 Nov 2026 11:11:57 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/12] migrate on fault for device pages
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>,
 Alexandru Elisei <alexandru.elisei@arm.com>, linux-mm@kvack.org,
 dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <avWpWBl1nPcRVmpQ@raptor> <79f33ab0-2e43-4efb-94d0-addaf40745ec@redhat.com>
 <avXoJSGh5xjGFgod@raptor> <20261112164752.GA3692174@nvidia.com>
 <ec4431f1-e70d-477c-b09a-eedc35d97691@redhat.com>
 <20261112162738.d689b46268e077ac06f41d91@linux-foundation.org>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <20261112162738.d689b46268e077ac06f41d91@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 78cCxZh0OVFgf7Hyn9F6aJ60V7EVm5TkV2qAxrl-qhA_1794561120
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/13/26 02:27, Andrew Morton wrote:

> On Thu, 12 Nov 2026 19:01:58 +0200 Mika Penttilä <mpenttil@redhat.com> wrote:
>
>> On 11/12/26 18:47, Jason Gunthorpe wrote:
>>> On Thu, Nov 12, 2026 at 04:24:05PM +0000, Alexandru Elisei wrote:
>>>> Hi Mika,
>>>>
>>>> On Thu, Nov 12, 2026 at 04:00:09PM +0200, Mika Penttilä wrote:
>>>>> Hi Alexandru!
>>>>>
>>>>> On 11/12/26 13:56, Alexandru Elisei wrote:
>>>>>> Hi Mika,
>>>>>>
>>>>>> I want to help getting this series merged, and I've been familiarizing myself
>>>>>> with hmm and device migration, please bare with me if the questions I'm asking
>>>>>> are obvious or downright silly.
>>>>> Thanks for the interest and willing to help! I am preparing a v18 of the
>>>>> series and plan to post it early next week.
>>>> The series is big, and as far as I can tell the MM people are hard at work
>>>> reviewing bug fixes. It might be better to wait a while, to give people a
>>>> chance to have a look? I know that if I see a series being reposted often,
>>>> I am less inclined to review the patches since probably a new iteration
>>>> will be posted soon. But I can only speak for myself, you know best.
>>> It is at v17 and it is still getting high severity sashiko errors
>> v14 was first that sashiko managed to review. There was a regression in
>> last posting, but also false potsitives, and sashiko reports same issue
>> then 3-4 times, so the reality is not that bad. 
> Pining for the days when all we had to deal with was checkpatch.  

Yeah.. running sashiko locally now. Interesting enough, refactoring the
series (end result being the same) made most of the "high errors" disappear.


> Mika, afaict the entire patchset is a performance optimization, yet you
> say "I don't have a benchmark showing a gain".

No not a performance optimization as is, in the latest cover I explain it:

"The main goal of this patchset is to provide a new feature,
migrate efficiently on fault, and not directly improve performance
of current migrate_vma_setup() (which is now routed thru
hmm_range_fault()) callers."

The "efficiently" is wrong word, I should say "in one walk".  In the
beginning of the cover, I explain the benefits of having one walk. Also,
I think it is sensible to have one implementation for it in HMM, instead
of each driver trying to do something similar.

We don't currently have in kernel the capability to do migrate on fault
in one walk, so I can't show a performance gain with a simple apples to
apples test.

Also :

"the selftests show that there is at least no regression for
current migrate_vma_setup() callers."

So the test is to show there is no regression still for current callers
(X86-64), not to show if there would be gains.

>
> Recipients look at patchsets wondering "why should I spend time on
> this", especially in these times.  It's best to answer this question
> right there in the first sentence of the [0/N].  That means numbers,
> and the better they are, the more attention the patchset will get.
>
>>  Documentation/mm/hmm.rst               |   45 +
>>  drivers/gpu/drm/nouveau/nouveau_dmem.c |  402 ++++++++-
>>  drivers/gpu/drm/nouveau/nouveau_dmem.h |   12 +
>>  drivers/gpu/drm/nouveau/nouveau_svm.c  |  155 ++--
>>  drivers/gpu/drm/nouveau/nouveau_svm.h  |    5 +
>>  include/linux/hmm.h                    |   51 +-
>>  include/linux/migrate.h                |   59 +-
>>  lib/test_hmm.c                         |  174 +++-
>>  lib/test_hmm_uapi.h                    |   21 +-
>>  mm/Kconfig                             |    1 +
>>  mm/hmm.c                               | 1075 ++++++++++++++++++++++--
>>  mm/migrate_device.c                    |  618 +++-----------
>>  tools/testing/selftests/mm/hmm-tests.c |   56 ++
>>  13 files changed, 1984 insertions(+), 690 deletions(-)
> also, yikes!

Yeah, the nouveau made the numbers bigger - but we have a real user!

--Mika


