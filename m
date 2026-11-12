Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C70A606AB1B
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=etbSi3Ma
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BEC112204;
	Thu, 12 Nov 2026 16:35:40 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C6193112208
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:35:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794501332;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zidr50P/tGTG0fyue72d2UJbI2Rv5djOGtCARdBGkgo=;
 b=etbSi3MaBKlhM2H6U1bFd6byZAOcdmMUnrFPq/YTRuWRbxQgFEFw4G1zldn7iLorC2LLfy
 BIk8t3PLGvMI1XjiP82BuHFwk8qb7Di7i+lR8CD1pASAvI6x2+xnX8UAPSOmZbzCrEJbHz
 uiTS2dxAW7S42S0y4bkf9X/IoghziW0=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-nsZFgOuXM5ifaPwZC10OmA-1; Thu, 12 Nov 2026 11:35:29 -0500
X-MC-Unique: nsZFgOuXM5ifaPwZC10OmA-1
X-Mimecast-MFC-AGG-ID: nsZFgOuXM5ifaPwZC10OmA_1794501328
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5c159755becso1604299e87.3
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:35:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794501328; x=1795106128;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zidr50P/tGTG0fyue72d2UJbI2Rv5djOGtCARdBGkgo=;
 b=BxvW61++QF57uFBVkcnofm1b5Zb9JyV9eYnaM6RNgeRBmvkfhtschFIfo5OogVGu9h
 WzSuvBTXULR6ZC5hm8PtF5FNxOUSrml7ldJDOwD0it7X/nFgmKhm3RzTLgNZd/mcWKrY
 +WUaMqvSaQVoqewghrkfZ3bILDAbApLODLiubVnGAizJI5Zx8Mf8WxN/HwkOrj14c+4G
 wi685lBqO/q66bqiRjZPm/nFZx3W7tsORH+56ViSA/ibCE14TsdgodGKZGULCns4C+kd
 liAhGzPm+13ksQs34BjHqUbzfMV3g//mx9IIItkT4qRPOsPhclY4xve3OFSvc7vriHgQ
 1LnA==
X-Forwarded-Encrypted: i=1;
 AL+hErFQDM9LzcJu5xZd5sN+XqwV2UuiHWC90pN+hauXmx35GhCCsP4ufx2uc11JOWJvl6WUZvCni35DOb4=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+dWBumBHUKELAK1xlsiNQRDV9pxqyW/A16KETrHyZuwOWy2Doz
 JWTHGJPDlg8CoAtA8OwCeSYxA+IhOQaOZIiPPvENu04O99RFKdXjsewO5tMqtgRzECyvJBpeHPw
 CYU2u6f4Hb+bG3bXD5GCpSstP0NX3p1OX+IItYAjjE0HTzdgI0m/i10mAQQuoZ/bQ3MbyKBStq6
 YlUkk=
X-Gm-Gg: AYBFou1WaF93HZbiV/hdIIoHNWvhRlYr3oaTAX3tUE6kxa0u/9Tlzzs89CknGVbaTR4
 q9bJP/qE/tihqbgW9R53geKWjLN5ADzit6N7foLReHyEAhgw9m7gIo2IlXbKwqP3o1/XoBge7aT
 juljyoUGreXj+owCJ0aluQge79nNohC7jRQIqhzirKGo11ceT1idKOKH3UTUTQfIlOI2wCdHbyU
 apUBZuQPKQEFHKCMAxM30XiQK1kS6yg495DxZDcgu5c3lQl0HWgLMQjwXQgiq3MWlC3q4jtp9kv
 iNgqvj/AE3n86B5WSWTeQQhyrEhTYBvvsUMtWnCm082cH8NjtVgV3ts2qa1Bp+dSIwkVhoQ/+5i
 9NLSWt4jYqKUiQ77piESbCdMql5eROj9i6X9oxTMJqaiNVtTp/WfDcpnDCqUd8VvRx/yBHA+2kD
 OuCb8f
X-Received: by 2002:a05:6512:402a:b0:5c1:5be5:a543 with SMTP id
 2adb3069b0e04-5c15d5a80b2mr2335288e87.9.1794501327761; 
 Thu, 12 Nov 2026 08:35:27 -0800 (PST)
X-Received: by 2002:a05:6512:402a:b0:5c1:5be5:a543 with SMTP id
 2adb3069b0e04-5c15d5a80b2mr2335272e87.9.1794501327252; 
 Thu, 12 Nov 2026 08:35:27 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5c157bab721sm1785202e87.40.2026.11.12.08.35.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 08:35:26 -0800 (PST)
Message-ID: <968f4667-ace0-49bf-a628-845c5fd577e4@redhat.com>
Date: Thu, 12 Nov 2026 18:35:25 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/12] migrate on fault for device pages
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
 <avXoJSGh5xjGFgod@raptor>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <avXoJSGh5xjGFgod@raptor>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: -DLxHyBLEno-7WkEs0eDyrAiYPJWne3H7lzvEtAKv2Y_1794501328
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


On 11/12/26 18:24, Alexandru Elisei wrote:
> Hi Mika,
>
> On Thu, Nov 12, 2026 at 04:00:09PM +0200, Mika Penttilä wrote:
>> Hi Alexandru!
>>
>> On 11/12/26 13:56, Alexandru Elisei wrote:
>>> Hi Mika,
>>>
>>> I want to help getting this series merged, and I've been familiarizing myself
>>> with hmm and device migration, please bare with me if the questions I'm asking
>>> are obvious or downright silly.
>> Thanks for the interest and willing to help! I am preparing a v18 of the
>> series and plan to post it early next week.
> The series is big, and as far as I can tell the MM people are hard at work
> reviewing bug fixes. It might be better to wait a while, to give people a
> chance to have a look? I know that if I see a series being reposted often,
> I am less inclined to review the patches since probably a new iteration
> will be posted soon. But I can only speak for myself, you know best.
True, my motivation for quickish repost is to address sashiko concerns,
and after that give time to reviewers.
>
>> I try to answer your questions, there are quite a bunch of them!
> Thanks for your replies, it's going to take me a while to digest them.
> Despite the silence, I'm working on it!
Appreciate it!
>
> Thanks,


Thanks,
--Mika


> Alex
>

