Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3264D606A33D
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 16:46:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dcDm54N8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BB5A11222E;
	Thu, 12 Nov 2026 16:46:20 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 765A411220F
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 16:45:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794501938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=W0tJRUuqq9I/mLQynKz/Dyg/O4hVratqHBUQ/E2JNFQ=;
 b=dcDm54N8oNIZUUpihKuMBjvNyY1HBzE2sv+P14h9su74laA/ct5DMyFHAjWTykedLUJ4Ey
 NIJ/W7BJkOLaHK0QNFYuMxdQbriakWGS5NZMfjhlTUT5Xe9eIKOeEISJVUSSO2Wqe/afwt
 fk9Bp9lRANi+502EdrJWBJi4XRkNEmQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-6jgU2dsDPciKbbUSmlacTw-1; Thu, 12 Nov 2026 11:44:26 -0500
X-MC-Unique: 6jgU2dsDPciKbbUSmlacTw-1
X-Mimecast-MFC-AGG-ID: 6jgU2dsDPciKbbUSmlacTw_1794501865
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5c168d27233so542966e87.1
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 08:44:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794501865; x=1795106665;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=W0tJRUuqq9I/mLQynKz/Dyg/O4hVratqHBUQ/E2JNFQ=;
 b=snuwt42W4N4goSUIl5IpGDOFl7JkH3lgezyGeox43q19uWlRqvccVCON8+q6czy27p
 DiV/kL13ffsov8sT1ifpd+ZDz/PLmNbBDBsJuhRXDRsySDBZYITSY6+4O7coaTsDXjMV
 ef3HlTjPGCquzCgUKJGlc44znQCDoNIg+WexJJIlUV6AQCpPSvbPRvJKiCcaXEB1Qzds
 8oLQUS9XhEDJAYqe+cK8gayc77UnlNMqfBA2LWHgihYdC9J/DdOgfcgX+82xM07rgEFC
 EckRN5QI6wMdDDHuWd0Gu0UZ3xBKxj+jU15dNrG2kukYilUbp0gCRz79lXcA/VivhwH1
 /viQ==
X-Forwarded-Encrypted: i=1;
 AL+hErHEbC8gNChk68KR2kXqa26OSOd9xEJPzoGcjwX3FKqmEnoQZor09N2AkBrvVVmn206oGB+MxmzzvpY=@lists.freedesktop.org
X-Gm-Message-State: APuU4Z+gr0P+i9OkCweFhZeBO18cpA8wVREVB6AreIZRCiCCC2cji37q
 4lHsAz8bdA9MfH+P7itVZCkaee6HG1Nc+eNjQdym9nb9kEQSXq0n8kFLOqkrPIT10/Wn/QkO9Pq
 tnIrdI9juDi2TGFxeISAIylPO083pWQ7K0pCPiiRQY4DPKsopOkfPs13spkMI37sHTMN/gmfVS2
 tq2Mo=
X-Gm-Gg: AYBFou1cxWn23XRBJ/7koRHxGp/qyBpZoBml3p4GKeUQaUbHY1puTSZcgUCM+ZiYyZ8
 bgjXDza5ZJ7KWkcmv9UMyK9oPw4lXfdRLwvccNEPmk+uaLcve4roD9DZPs47ihrkSg4SxDGdJP5
 4mMxAPumOt63rdGqwL5P7Vnl/6PMxo7KqOywnXeJUfL1q7Oey7SKW5j6QqE7j2PkFGkjFTok31W
 NM8S0wsBSQyyB9/L/U+8LqokTeqrSJw8qiWjGO96MRCR3Ih2bruOM9jSRVKxJNVJqiWU4zpZOTj
 qvbEhhkdt99/i0D89plUBpliepQ/CRrgaM+0Pm4JETttVBWihw6K3XVQb6YkaAAltxdcZVhht/2
 Sd9s2z0is9UC7bgep4mGpPjljjPbp4fKkI0nXy6nXFQNsDGfY8mIVtZg7HMy+EGasNx9SqICRF4
 xoaBlA
X-Received: by 2002:a05:6512:2303:b0:5bf:ca51:e2a6 with SMTP id
 2adb3069b0e04-5c164ece630mr1090712e87.40.1794501864883; 
 Thu, 12 Nov 2026 08:44:24 -0800 (PST)
X-Received: by 2002:a05:6512:2303:b0:5bf:ca51:e2a6 with SMTP id
 2adb3069b0e04-5c164ece630mr1090706e87.40.1794501864387; 
 Thu, 12 Nov 2026 08:44:24 -0800 (PST)
Received: from [192.168.1.86] (89-27-86-246.bb.dnainternet.fi. [89.27.86.246])
 by smtp.gmail.com with ESMTPSA id
 38308e7fff4ca-3ae2b780c49sm183231fa.19.2026.11.12.08.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Nov 2026 08:44:23 -0800 (PST)
Message-ID: <61e5e0ac-dfe2-4a5a-afee-873523df18e5@redhat.com>
Date: Thu, 12 Nov 2026 18:44:23 +0200
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 00/12] migrate on fault for device pages
To: Zi Yan <ziy@nvidia.com>, Alexandru Elisei <alexandru.elisei@arm.com>
Cc: linux-mm@kvack.org, dri-devel@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 David Hildenbrand <david@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Leon Romanovsky <leonro@nvidia.com>, Alistair Popple <apopple@nvidia.com>,
 Balbir Singh <balbirs@nvidia.com>, Matthew Brost <matthew.brost@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@suse.cz>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Lyude Paul <lyude@redhat.com>,
 Danilo Krummrich <dakr@kernel.org>
References: <20261103061629.972669-1-mpenttil@redhat.com>
 <avWpWBl1nPcRVmpQ@raptor> <79f33ab0-2e43-4efb-94d0-addaf40745ec@redhat.com>
 <avXoJSGh5xjGFgod@raptor> <3A5BEC5A-BAFA-4541-8ACA-43E57C7DBCFD@nvidia.com>
From: =?UTF-8?Q?Mika_Penttil=C3=A4?= <mpenttil@redhat.com>
In-Reply-To: <3A5BEC5A-BAFA-4541-8ACA-43E57C7DBCFD@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 2qZCK0QOJnkHfGV6zw4yHv_enOqXwwb016lfBwLVZBE_1794501865
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


On 11/12/26 18:33, Zi Yan wrote:
> On 12 Nov 2026, at 11:24, Alexandru Elisei wrote:
>
>> Hi Mika,
>>
>> On Thu, Nov 12, 2026 at 04:00:09PM +0200, Mika Penttilä wrote:
>>> Hi Alexandru!
>>>
>>> On 11/12/26 13:56, Alexandru Elisei wrote:
>>>> Hi Mika,
>>>>
>>>> I want to help getting this series merged, and I've been familiarizing myself
>>>> with hmm and device migration, please bare with me if the questions I'm asking
>>>> are obvious or downright silly.
>>> Thanks for the interest and willing to help! I am preparing a v18 of the
>>> series and plan to post it early next week.
>> The series is big, and as far as I can tell the MM people are hard at work
>> reviewing bug fixes. It might be better to wait a while, to give people a
>> chance to have a look? I know that if I see a series being reposted often,
>> I am less inclined to review the patches since probably a new iteration
>> will be posted soon. But I can only speak for myself, you know best.
> Totally agree. It is better to wait until MM people finish the bug fixes.

I was going to send fix series to few regressions by earlier posting -
no new features or anything - with the mindset that it is better then to
review a fixed series than known buggy. 


>
> Thanks.
>
>
> Best Regards,

Thanks,

--Mika


> Yan, Zi
>

