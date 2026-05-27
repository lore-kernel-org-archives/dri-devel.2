Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48F35CD5BD0
	for <dri-devel@archiver.kernel.org>; Wed, 27 May 2026 17:13:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD92C10E292;
	Wed, 27 May 2026 17:13:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="kbPRowui";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8B28F10E292
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 17:13:33 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64R9uFVd3561044
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 10:13:32 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=mF5ddP6Uato8c/uzw9iXykGIYPHqrtpIex8OCXzcenM=; b=kbPRowui4ML0
 YT114Vj1aVyNdnJJnjW848sZsqDgsQYxXf2af4lfe3yF9FH23tSklBFjrFv+o1wO
 ucJMCKwm9TylaOZQY0BhdJmQkngp6DAyA55R8lVRUQsexRgIwmUgj+H/mCR04y4k
 /GAEdHJqvYT6gQSouuHInLdwLedo/MVWAuYOky/jMujuavyWL/YFHal9G71FuvZm
 tUxMcxI1AwosqBr40clgGXAGZXRDcjjOD1Jq/WacVJpLsQehhEaY4Ed2cuHf56jB
 IOS9EOaVolYK/24AqeQ1zfm7jhCYBImKoLNKwH7NA+wFXFoDOJcUcF7lf4ehsFGn
 OeD1ICtoLg==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4edxdxtd6d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 10:13:32 -0700 (PDT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-1353a6f29deso12826551c88.1
 for <dri-devel@lists.freedesktop.org>; Wed, 27 May 2026 10:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779902011; x=1780506811;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mF5ddP6Uato8c/uzw9iXykGIYPHqrtpIex8OCXzcenM=;
 b=Zu57sRPyTyeInwgv4ai5aYrwTnPxqsKWz/8i/tTsIqQAJgctWXlLZtnjWZdh8xkFjb
 Qo6M+uCg9zfQA0nkcBogWaKvBaG5qeeT1/+sXphXLKi10+FCEEBMrGwmYCSwE4B+FypX
 +BMjaL7Dy7YFa3F3ChWjQvoNbu2hDbf3AkDOJd9YaqoAqTUAh64J6RNnW4Mk7Tggm5+F
 PrM98xSAiBcA6ADeinQYCmPnwk3Ng8x54iimOvxWnUb6lVy6YbDZ+CLmIa6h56J7oFbH
 4Kje0EBjuuRaToAKiQelajlINcCdTVLju+X9QWm3rXg+oSFu3LRp1uk/M4sJUmQ/20ie
 ot6Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WoXkjJ8dGBBjGAal3Lr1EvGyeCDI7fbraZ4/Mgd9pJyXkr2nGMifDDZqVSLSy3i2PfIC0tUO6e0k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzx1Hs1a9ekGD0Wigq4taKGgcrbf9kpFxxDxXSJLOla4cLKZ/4L
 BEmFNAnf7CGi4Q/ypOjj7Uy40SHtqDEdiFz3XxNDXsizQ57QdpcveRBXoLdHzxz005VXgu/KOxq
 /3YKzKbIRFxGMswsWyym6Gp7fkvDri5IY9uBF6gwYCTOIIRmfkQPLXIjWRCarKpdXcoWL
X-Gm-Gg: Acq92OGRsx7ZZiJG5fF0mt07hgybT/9ic8FHppfCPRwPBet+6LJvquNlX7sgcR+RqLB
 HI23Mk+RzfCZNj2ogA7dvWPl8WKWWGuW7CMi5dkuxsD2MwKDboorp1wJjg15FTqSzhkRs8TmOMj
 t70Ipwr/s8Q0adRX6wsEaNkegtgw06MTaxgSgpjPceMbI00XJaPKWwDK2vnPAUWCosDJn/xS4MR
 vCrElntD656XG6OCPzE3hiDE0jh+Z7jLYzQm7HMyYjif+Ncdx7dq5MB0HH6IkMveuBkuDpOnSSy
 K7yeavp5vCr6HKkbaJ5H3SgYTM/6ZAl7cm0xZaGn5cNF1VPuv1DKyIV5zhV0vwqqCqJ9ECBwDfS
 lwOEkWhdbFpSHQwhUpKDYWQWdA7290Pn8Z0o=
X-Received: by 2002:a05:7022:913:b0:135:e814:d03f with SMTP id
 a92af1059eb24-1365fc7d7e9mr8777513c88.36.1779902011322; 
 Wed, 27 May 2026 10:13:31 -0700 (PDT)
X-Received: by 2002:a05:7022:913:b0:135:e814:d03f with SMTP id
 a92af1059eb24-1365fc7d7e9mr8777489c88.36.1779902010729; 
 Wed, 27 May 2026 10:13:30 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-136b3706ad6sm9223289c88.13.2026.05.27.10.13.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 May 2026 10:13:30 -0700 (PDT)
Message-ID: <1f1b9967-7182-401c-ac30-373b73216e81@meta.com>
Date: Wed, 27 May 2026 18:13:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] PCI/P2PDMA: Add CONFIG_PCI_P2PDMA_CORE
Content-Language: en-GB
To: Logan Gunthorpe <logang@deltatee.com>, Alex Williamson <alex@shazbot.org>,
 Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Bjorn Helgaas <bhelgaas@google.com>
Cc: Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, linux-pci@vger.kernel.org
References: <20260527102319.100128-1-mattev@meta.com>
 <20260527102319.100128-2-mattev@meta.com>
 <843e8525-5927-45b5-a3e2-a5ec16234398@deltatee.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <843e8525-5927-45b5-a3e2-a5ec16234398@deltatee.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: mlUnBecxUdsEYhsMDv4vC73wDzxioRcx
X-Proofpoint-GUID: mlUnBecxUdsEYhsMDv4vC73wDzxioRcx
X-Authority-Analysis: v=2.4 cv=JKILdcKb c=1 sm=1 tr=0 ts=6a17263c cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8
 a=gXLdhW2jAAAA:8 a=1nsJja_hzN5yKYYIz30A:9 a=QEXdDO2ut3YA:10
 a=Kq8ClHjjuc5pcCNDwlU0:22 a=gKebqoRLp9LExxC7YDUY:22 a=Dn9eIPSr_RzuO0KTJioD:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI3MDE3MiBTYWx0ZWRfX/yn7vD2TFL0i
 J8IExPvE/5aJe5ozJriIPNGbEx+b6TAHhjDoRgWeD5qCZHMeReufyJ5WjaXAwCZ63Ftar8k8o64
 jtJn988eQt9GvkZ4d1CCMwa2MRUxmTCMzjut87XQn72WrDqrSI8U1UIRgZbRB895srMcBl/jgrh
 hSHLwpJKBMLIX7BaxVAmC4qD/7Ng3K8EvhZmJNR37YY8X8Nr0Rp5drCPtBSmYpniDxBExSYR2hU
 +42avR+o7W9+sT8veV7P9J+Tb+zoe+zFRNDPYxEc5xCxJS6iLDuauPAOzEx95s4hoZcTylxbguR
 3hnZfy5OPxjEerOnPGi+kKkhjfxXVPsw+4zUESrc1V3CnWHKUvYepgEZFaiC5WS4AuHhoaBR5W6
 bq6r64ltQFnkjKjxK/QPRTQ/xpxn3eXrXgeXnB2/cWSMc0JreSzz556oukKKlKuav146bGRsyg0
 Fv+sFjFzm4Uerl7Rv/w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-27_03,2026-05-26_03,2025-10-01_01
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

Hi Logan,

On 27/05/2026 17:07, Logan Gunthorpe wrote:
> 
> On 2026-05-27 04:23, Matt Evans wrote:
>> The P2PDMA code currently provides two features under the same
>> CONFIG_PCI_P2PDMA option:
>>
>>   1.  Locate providers via pcim_p2pdma_provider()
>>   2.  Manage actual P2P DMA
>>
>> Other code (such as vfio-pci) depends on 1, without having a hard
>> dependency on 2.
>>
>> A future commit expands the use of DMABUF in vfio-pci for non-P2P
>> scenarios, relying on pcim_p2pdma_provider() always being present.  If
>> that depended on CONFIG_PCI_P2PDMA, it would make vfio-pci only
>> available if CONFIG_ZONE_DEVICE is present (e.g. 64-bit systems), even
>> when P2P is not needed.
>>
>> To resolve this, introduce CONFIG_PCI_P2PDMA_CORE which contains the
>> basic provider functionality to make it available even if the
>> CONFIG_PCI_P2PDMA feature is disabled or unavailable due to
>> !CONFIG_ZONE_DEVICE.  Users such as vfio-pci can enable their own P2P
>> features based off the original CONFIG_PCI_P2PDMA (available when
>> CONFIG_ZONE_DEVICE is set).
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
> 
> Largely this looks good to me. I have one minor nit below that you can
> apply or not. Either way, feel free to add:
> 
> Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
> 
> 
>>   static void pci_p2pdma_release(void *data)
>>   {
>>   	struct pci_dev *pdev = data;
>> @@ -241,11 +251,13 @@ static void pci_p2pdma_release(void *data)
>>   		synchronize_rcu();
>>   	xa_destroy(&p2pdma->map_types);
>>   
>> +#ifdef CONFIG_PCI_P2PDMA
>>   	if (!p2pdma->pool)
>>   		return;
>>   
>>   	gen_pool_destroy(p2pdma->pool);
>>   	sysfs_remove_group(&pdev->dev.kobj, &p2pmem_group);
>> +#endif
>>   }
> 
> I'm personally not a fan of adding #ifdefs inside functions like this.
> This instance is small and easy to understand, but it can quickly become
> a bit of a mess if we start adding more features. I probably would have
> created a pci_p2pdma_release_pool() helper which does the inverse of
> pci_p2pdma_setup_pool(), it would be called in pci_p2pdma_release() and
> an empty implementation would be provided in the case where
> CONFIG_PCI_P2PDMA is not set.

That's cleaner, I'll do that.  Thanks for the review.


Matt

