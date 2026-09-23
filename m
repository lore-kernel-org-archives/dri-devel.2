Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A8ADC98302
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 05:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6109E10EF0D;
	Wed, 23 Sep 2026 05:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=redhat.com header.i=@redhat.com header.b="jT7kGEXZ";
	dkim-atps=neutral
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAE8510EF09
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 05:42:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790142154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Owanqqlm2F+zzhHdgO4ILjDMn6+LQqunLulaO+aFb4U=;
 b=jT7kGEXZf2U/E9WQV3F5c+mhN58DiwuW8+vvMSqyeHdBWKlp4g5vsRc0KKFTItL8D7gG/R
 UaJg0PUtcSEQLw8UVsJQvs5i5+XZEnGXuX0xl3N2yiKNOWUdBxGL4ZaY4amJqcZwOfFMCa
 0Zuh3F5X+8rESi0M/4vWuRzXRn3gBlE=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-kB7Uk-VqO6OOuOooeAdOyg-1; Wed, 23 Sep 2026 01:42:31 -0400
X-MC-Unique: kB7Uk-VqO6OOuOooeAdOyg-1
X-Mimecast-MFC-AGG-ID: kB7Uk-VqO6OOuOooeAdOyg_1790142150
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-3a3395e2d7cso2385111fa.2
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 22:42:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790142150; x=1790746950;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Owanqqlm2F+zzhHdgO4ILjDMn6+LQqunLulaO+aFb4U=;
 b=IIom+ZndJFZKbSoyx3Kz3yYb/DP0tFvtI9oZZusAy5uVUCklEBAXUlEi1LHBSbk8+4
 vOCz4yjknMidbyH8NwAbmGrrw4MJVB7h2SyHzsKPBLE2bFMrPG5kg+4CxX52s5CA+b0/
 UZCJ2YU4lq2gPi3G2kzMZHdUYK0A2Y5lm1eE32B5xHPIjW8stNidoJnALvKHXlT/d+j/
 Pu8mOEbhJzhohobdNEXoHg+nkdxVMjYSRb/d9i6AsGqFT7UVBXlJWqWWqdFmRGL+wm5g
 TEQzHOfX9Dhsq5yAQ6ZBGAEb3Ozli8kUQv2upelFDTSa/HvsL/jdtgyXvlIXbyTa9nL4
 Ws2g==
X-Gm-Message-State: AFuF++mOseyeXCpi99NECrQUJ7CHO+XpJ8hzB/wEF7k5VEUbmRx+RhoA
 q7la4FCqTR4AYVyBRMLSnvXxD+2ooDadk/CbwgjV66AOUnGJdnJ+U/68KM0tokPqFDWRSAT+SJF
 ZmUx24ZPmHUOWsAHJ05ui1jLqYa/Tfg4e/tMrPfxeaOM7rcigJ2bgqCcffklNDd9L1HOj
X-Gm-Gg: AYBFou0Rsj4mDHhXeCva6sP97RdrA6A9XGBlcoi+wWioj970imryoUeoLcp9Mjw/RN7
 3Dc6oREYetXb7VJSxyEB8BdWFZG47RCXPx/g8/Kjv8h18506WXwNTNOtbbk0e/c7/GV3TuK7+Ha
 eJOSfdY3aCamXcLd0693yJpvXGkAJbmqozHrkZTKeJMWSybhjslMaesCPKkMfBk3FNnxzKbEVRg
 VNQmNYqY7TjggM6KRrzCWLKIPbu1Xt6l1VZVYqF4pxs9uM+pkbL8fyJVbV/7/zTgBZjdrIIJblx
 DLKa8asMg7Zd5wBZGxfXUxk2c+rBJjO3ytzBk/GzOdRANCO6Rygqh6HJaYLRPGYqWogZUkj+nAz
 HaB0CqrPqcBATn9Wri2kyeBWgsOC0T34=
X-Received: by 2002:a2e:bc0a:0:b0:3a5:e541:4205 with SMTP id
 38308e7fff4ca-3a630525d38mr3157951fa.0.1790142150002; 
 Tue, 22 Sep 2026 22:42:30 -0700 (PDT)
X-Received: by 2002:a2e:bc0a:0:b0:3a5:e541:4205 with SMTP id
 38308e7fff4ca-3a630525d38mr3157781fa.0.1790142149515; 
 Tue, 22 Sep 2026 22:42:29 -0700 (PDT)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3a62f4f10b0sm3956141fa.8.2026.09.22.22.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Sep 2026 22:42:28 -0700 (PDT)
Message-ID: <8523ee92-04c1-4e52-a418-a3ab110bca38@redhat.com>
Date: Wed, 23 Sep 2026 08:42:27 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 01/12] mm/Kconfig: changes for migrate on fault for
 device pages
To: Balbir Singh <balbirs@nvidia.com>, linux-mm@kvack.org
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, David Hildenbrand <david@kernel.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>,
 Alistair Popple <apopple@nvidia.com>, Zi Yan <ziy@nvidia.com>,
 Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>
References: <20260922053421.4092027-1-mpenttil@redhat.com>
 <20260922053421.4092027-2-mpenttil@redhat.com>
 <c2b28c18-3717-43d1-acba-05eaf9b1b9cf@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <c2b28c18-3717-43d1-acba-05eaf9b1b9cf@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pUDh-cpXOlCCF9OwqTUKGLcah_18s8hs1i1GpdjDHAU_1790142150
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


On 9/23/26 01:27, Balbir Singh wrote:

> On 9/22/26 3:34 PM, mpenttil@redhat.com wrote:
>> From: Mika Penttilä <mpenttil@redhat.com>
>>
>> HMM depends on MMU notifiers. With the unified HMM/migrate_device
>> page table walk migrate_device needs HMM enabled.
>> Enable them explicitly to avoid breaking random configs.
>>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: David Hildenbrand <david@kernel.org>
>> Cc: Lorenzo Stoakes <ljs@kernel.org>
>> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
>> Cc: Vlastimil Babka <vbabka@suse.cz>
>> Cc: Mike Rapoport <rppt@kernel.org>
>> Cc: Suren Baghdasaryan <surenb@google.com>
>> Cc: Michal Hocko <mhocko@suse.com>
>> Signed-off-by: Mika Penttilä <mpenttil@redhat.com>
>> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
>> ---
>>  mm/Kconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index 604c58199acb..b7a485beb9a7 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -687,6 +687,7 @@ config MIGRATION
>>  
>>  config DEVICE_MIGRATION
>>  	def_bool MIGRATION && ZONE_DEVICE
>> +	select HMM_MIRROR
>>  
>>  config ARCH_ENABLE_HUGEPAGE_MIGRATION
>>  	bool
>
> Acked-by: Balbir Singh <balbirs@nvidia.com>

Thanks Balbir!

