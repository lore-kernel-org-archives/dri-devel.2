Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A038CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 12:08:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D94FE10EA7E;
	Tue, 12 May 2026 12:08:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="fOgjKmYQ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8CD9510EA7D
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 12:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778587705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dXH5HtvUwwvubt7XZZtwSLlnbyrqCuGNkjWnyw6B3Tw=;
 b=fOgjKmYQzyaKUCAJ2UfHXSZJyQ54ALvWtsIL0ExDvOhToBSrFQZO5wM9OmJrCGxH9X7s0U
 0rHg7shJqhzyUE1XB/e4i/z8UNeQWVMAXgHUH8LS4AAfnqq5Yb/cIXYmkX+1ClpBbhVEkv
 Ol3PBl2+znQ4kOAFsp9UQp62BshlmJo=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-378-zWSkWvANOoSX40LyxIe5nA-1; Tue, 12 May 2026 08:08:24 -0400
X-MC-Unique: zWSkWvANOoSX40LyxIe5nA-1
X-Mimecast-MFC-AGG-ID: zWSkWvANOoSX40LyxIe5nA_1778587702
Received: by mail-lf1-f71.google.com with SMTP id
 2adb3069b0e04-5a8a57bad37so2201623e87.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 05:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778587702; x=1779192502;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=dXH5HtvUwwvubt7XZZtwSLlnbyrqCuGNkjWnyw6B3Tw=;
 b=XcezvAFVFqF/ktgCSksHBriMYGeM6BcerR3s7Nu9eFxlAwH/GCvbexLRGh+1pzJFc9
 /MbWxAVxlYEzezeQzCdDbiwmYi51fORmkODIq8hMDz4R7iUsobV/XM9jq2At29ytXqdg
 lr6IJOGk4UTzGF3S2hL3M6MKOJ0ATUV93iUXtVdYWkEUFFdQv04ozHkHayhRnhXr4t+V
 QuYckHQe1yZdoXceHmPXJhexs5msYoO1YHLIcvErHkkB3NojEmsztC0B9bYb5kPfy+lx
 uguinUwS3mbsjwgRK64bYFm0QjdocrZZwBYZ2pu1cNrW02GLtCWNst814cp/gkYRz+xy
 3BJA==
X-Gm-Message-State: AOJu0YyUayq1Nzovgct7P7JjP3f04LDfIWzVGMcb+nZmv+y+gNW/5g5J
 yz3z83bMOejLmkVWcFxtYnxkGQFXZEqfNQMc6z7zrI2gpvCAIaCpruMUPuxxQn7ZWg+fFGSxoW3
 aHwEsdzgbESvgD34T8FP40qad3LZ10leBDjnxge8cmGRNU5Z+tjQLF9lBotm+tS0OFg+z
X-Gm-Gg: Acq92OF5cNsCDld3fmx4NWVwzsBFL3N9FYHO7e4cJLsjoHdExS/lrm4puqsei9p2y0b
 q3BOZb9SlrF/l5J1ebhvPXLlhfckCkFhQm8w7WmJ0/bO3Rbz4m/kCWtfz6DRfpoGut4GEs2vCwb
 /s58JMi08XmuK6pb9WsWCjSywRQ46rMnpV1GGbFqinqhrOYFLnpch+r3L8XKkvWH7+4BxKNDyIL
 l2qVKPxqIQv9yj5zcumvnhfa9cy1JYidYfWSUTd1z8MZJ17aUI/grDOp8SYiLJMrlSbV5EtAmj0
 n4ftLWCeqA/LcniWdqSv6Okg5tFJAdJJcbOXICRhWXKSC11P4N8NtQZe0JNLbmFV9b/vBIDmacG
 V1tUEcc5sfP1VDRaiU0vwx91KeOu3N35UniTSofaJ9wGVeww=
X-Received: by 2002:a05:6512:1281:b0:5a8:cdd8:1eb0 with SMTP id
 2adb3069b0e04-5a8cdd81ed5mr2576299e87.1.1778587702199; 
 Tue, 12 May 2026 05:08:22 -0700 (PDT)
X-Received: by 2002:a05:6512:1281:b0:5a8:cdd8:1eb0 with SMTP id
 2adb3069b0e04-5a8cdd81ed5mr2576269e87.1.1778587701675; 
 Tue, 12 May 2026 05:08:21 -0700 (PDT)
Received: from [192.168.1.86] (85-23-51-1.bb.dnainternet.fi. [85.23.51.1])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5a8a95661aasm3290978e87.68.2026.05.12.05.08.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 05:08:21 -0700 (PDT)
Message-ID: <7e3abb7c-c57d-419a-969a-fcd150ccca99@redhat.com>
Date: Tue, 12 May 2026 15:08:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/5] mm: Add helper to convert HMM pfn to migrate pfn
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260505184421.2324798-1-mpenttil@redhat.com>
 <20260505184421.2324798-3-mpenttil@redhat.com>
 <4a9c4170-c6b7-424c-969c-19240f07e46b@kernel.org>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <4a9c4170-c6b7-424c-969c-19240f07e46b@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: st3RRW2sDB7LZSOEh3tAn_VmUF6FGyUThyvsNLiK4e4_1778587702
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
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

On 5/12/26 14:43, David Hildenbrand (Arm) wrote:

>> +
>> +/**
>> + * migrate_hmm_range_setup() - prepare to migrate a range of memory
>> + * @range: contains pointer to struct migrate_vma to be set up.
>> + *
>> + * When collecting has been done with hmm_range_fault(), this
>> + * should be called next, and completes range->migrate by
>> + * populating migrate->src[] and migrate->dst[]
>> + * using range->hmm_pfns[].
>> + * Also, migrate->cpages and migrate->npages get initialized.
>> + * After migrate_hmm_range_setup(), range->migrate is good
>> + * for the rest of the migrate_vma_* flow.
>> + */
>> +void migrate_hmm_range_setup(struct hmm_range *range)
>> +{
>> +	struct migrate_vma *migrate = range->migrate;
>> +
>> +	if (!migrate)
>> +		return;
>> +
>> +	migrate->npages = (migrate->end - migrate->start) >> PAGE_SHIFT;
>> +	migrate->cpages = 0;
>> +
>> +	for (unsigned long i = 0; i < migrate->npages; i++) {
>> +		unsigned long pfn = range->hmm_pfns[i];
>> +
>> +		/*
>> +		 * We are only interested in entries to be
>> +		 * migrated.
>> +		 */
>> +		if (!(pfn & HMM_PFN_MIGRATE)) {
>> +			migrate->src[i] = 0;
>> +			migrate->dst[i] = 0;
>> +			continue;
>> +		}
>> +
>> +		migrate->cpages++;
>> +
>> +		/* HMM_PFN_MIGRATE without HMM_PFN_VALID denotes the special zero page */
>> +		if (pfn & (HMM_PFN_VALID))
> No need for ()

ack

>
>> +			migrate->src[i] = migrate_pfn(page_to_pfn(hmm_pfn_to_page(pfn)))
> Is there no easier way to avoid going through a page?
>
> I guess you really just want "migrate_pfn(pfn & ~HMM_PFN_FLAGS)".
>
> Maybe add a hmm_pfn_to_pfn() helper that does the "pfn & ~HMM_PFN_FLAGS" ?

Basically yes. I noticed this was helpful for instance with the "separate address space for device_private"
patchset not to depend on the coding.

>
>> +				| MIGRATE_PFN_MIGRATE;
> We (MM folks) usually put the | onto the previous line to then properly indent
> the second line

Okay I will change.

>
> migrate->src[i] = migrate_pfn(page_to_pfn(hmm_pfn_to_page(pfn))) |
> 		  MIGRATE_PFN_MIGRATE;
>
>> +		else
>> +			migrate->src[i] = MIGRATE_PFN_MIGRATE;
> It might be cleaner to just set migrate->src[i] = 0; here and to unconditionally
>
> 	migrate->src[i] |= MIGRATE_PFN_MIGRATE;
>
> So you don't have the MIGRATE_PFN_MIGRATE on two paths.

Good point.

>
>> +
>> +		migrate->src[i] |= (pfn & HMM_PFN_WRITE) ? MIGRATE_PFN_WRITE : 0;
>> +		migrate->src[i] |= (pfn & HMM_PFN_COMPOUND) ? MIGRATE_PFN_COMPOUND : 0;
>> +		migrate->dst[i] = 0;
>> +	}
>> +
>> +	if (migrate->cpages)
>> +		migrate_vma_unmap(migrate);
> Can you remind me why we do this here, in the setup() phase? The function doc
> does not really describe that.

It is to be in par what migrate_vma_setup() does today after the "collect" phase.

Thanks,
Mika

>

