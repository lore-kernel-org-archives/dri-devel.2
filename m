Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC9E606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 21 Oct 2026 06:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jWtw7PzE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 581DB10F974;
	Wed, 21 Oct 2026 06:31:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0D3BF10F974
 for <dri-devel@lists.freedesktop.org>; Wed, 21 Oct 2026 06:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792564257;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tRPKYkaZWE3FxBj2IxPUzKLdAP5rCGDFaBUV6kgkyzE=;
 b=jWtw7PzEJcvxTA0mmnxfsQQ8S2zfKYUwzcPTg4eBBNUcOAgiyxnOnSe6+t3SWBQWvonHfk
 CNKR6nxDcLClvFLwfZJlXFok4AL+sIkYKrBi5E81Z5lk5udTsHNGWgBlSibdosfQUJQ1+c
 Hs5xyh2yvplPrgmrzQaxv2Ix4QJHnJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-eEqtb6RMMViOmjEhV7c5kQ-1; Wed, 21 Oct 2026 06:30:54 +0000
X-MC-Unique: eEqtb6RMMViOmjEhV7c5kQ-1
X-Mimecast-MFC-AGG-ID: eEqtb6RMMViOmjEhV7c5kQ_1792564253
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-48e0389d6f9so164754f8f.1
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 23:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792564253; x=1793169053;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tRPKYkaZWE3FxBj2IxPUzKLdAP5rCGDFaBUV6kgkyzE=;
 b=xUaMhyIeetkcIqYgqa+AOmZsSq2P5t+06kceGNz4bPsGHyUJ9OBJ41+L828UrxHvq6
 jWTOhkBG0J7c6tc6TIc3VUztU8Lgo5xp9qLSl9BSWWGZ+xHy2JOGJajddF+sD7PhcKyg
 Xsog+C+BqIrCRN2YicsAibGA9KuKzem9T0KO8HjRL5FjoIfQ6Dr21m2a0Uwzx/Sl1sa0
 vL68Z56ARTjK89DCbjjYhfhEvMhMH5koWesA/xT17dmIm6lqqaEwD4LCOHLxBP+D88St
 fuYjHwCWn1B2+3dUwh6yPK0cRPVfFNQcLiGCWKjbbTVGQsuEr6hd9ijrJn01/U42NgvD
 re/w==
X-Gm-Message-State: AFq9FYIQ13j0WqqjS7yOdRKXlJFSVvgeOSO8mC7eR2+jrCM9kLVRm138
 2rDg1gg4oGL+LqDqF/G36i86XL6YH6b62qDcjLMDcRT8lw8pUb3j4Pi0mq/qE0N5YdhoL4T7DJK
 FykkQg/9Vu/JKuHfWJRF0aV0R1xw0T2E+isr0btK8MknKe6F6QeS5rbjHQIQfuH8cSnSV
X-Gm-Gg: AYBFou0EY7Eyv0UoQtjWbI/mVm7MKOISPf/Jo3y54hHY4+7iKUkWsQhz73PbIXBU1d3
 +IrHvrcMJDW5Ti46d4ueJZ/qmi8CA1/2af0viKyAKMBzs1NBQ9mX6jhYyVDWGFnctH69qnGXvSr
 gWc0jP2YOlqk99nCqZB6SL5p05Xg4K+qrehttJaaaRR6Iigb6B0sxkBLl+GHo/s7supqKZSnCQS
 J/ZoulbwHAyQPThx8ir6qaGmldsCSh+9AvvZBF4T7RjkqXknWOxN+MjLVGjX79qMvJrEJcN8MJL
 d8dAEnurXLIR9fEi1jBPRQiVCf72EFa2hwpj+nKtZFTp7rZf+jaZxXmQt3JO2BuYOy9RMvZAOnL
 sYma96VQ/SxxdaJjxd2ust4k0PQS2s2w=
X-Received: by 2002:a05:6000:40db:b0:488:8ab9:f74c with SMTP id
 ffacd0b85a97d-48e2644ef10mr2173419f8f.3.1792564252715; 
 Tue, 20 Oct 2026 23:30:52 -0700 (PDT)
X-Received: by 2002:a05:6000:40db:b0:488:8ab9:f74c with SMTP id
 ffacd0b85a97d-48e2644ef10mr2173368f8f.3.1792564252246; 
 Tue, 20 Oct 2026 23:30:52 -0700 (PDT)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e25828e72sm3174366f8f.26.2026.10.20.23.30.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Oct 2026 23:30:51 -0700 (PDT)
Message-ID: <7b534ff3-699a-4c38-b6d5-b044383d956e@redhat.com>
Date: Wed, 21 Oct 2026 09:30:49 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v16 09/12] mm: enable device page migration from HMM
 pagewalk
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
References: <20261021060506.2377545-1-mpenttil@redhat.com>
 <20261021060506.2377545-10-mpenttil@redhat.com>
 <7c8c663f-cf31-40ff-bce4-784726f42a0b@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <7c8c663f-cf31-40ff-bce4-784726f42a0b@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: i-I5TBG1wkBZoanp4JAJSPWkxXm1z-Sk4hGI9adXFkc_1792564253
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/21/26 09:19, Balbir Singh wrote:

> On 10/21/26 5:05 PM, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> HMM pagewalk has now the machinery to do the first phase of
>> device page migration, collecting the pfns and installing
>> migration ptes.
>>
>> Enable migration in hmm_range_fault(), and change migrate_vma_setup()
>> to use HMM pagewalk path. Two new flags, MIGRATE_VMA_FAULT and
>> MIGRATE_VMA_WRITE are introduced for migrate_vma_setup(),
>> to request for faulting missing pages, and requesting write
>> access.
>>
>> Also, the migrate_vma_collect*() based paths are now unused,
>> so delete them.
>>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Jason Gunthorpe <jgg@nvidia.com>
>> Cc: Leon Romanovsky <leonro@nvidia.com>
>> Cc: Alistair Popple <apopple@nvidia.com>
>> Cc: Balbir Singh <balbirs@nvidia.com>
>> Cc: Zi Yan <ziy@nvidia.com>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Suggested-by: Alistair Popple <apopple@nvidia.com>
>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>> ---
>>  include/linux/migrate.h |  10 +-
>>  mm/hmm.c                |  33 ++-
>>  mm/migrate_device.c     | 562 ++++------------------------------------
>>  3 files changed, 83 insertions(+), 522 deletions(-)
>>
> I got a conflict applying this patch on the latest mm-everything with
> mm: avoid use of VMA_SPECIAL_FLAGS in migrate_vma_setup(), quite a simple fixup
>
> Balbir

Ah okay - yes this is on drm-tip

--Mika

