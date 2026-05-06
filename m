Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8BFCD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A427D10F01B;
	Thu,  7 May 2026 10:13:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="LVK6U0wJ";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AB8310EE17
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 16:42:46 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6464pVee3763303
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 09:42:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=KvzelPFNcl7MU+TM0miXboxQSsRGRRlAbQLX3lQgau0=; b=LVK6U0wJ9iIb
 vlscmhtMH1uiKx6GtvkvD3PFd3zgD6F0pJGalLirUzyn7txEkM7B87H6hJ3gBB/R
 xy6LpmR0MAd+x0ZIqp8r0Hyc0y1/04XFD7dLYOiSF6fGh+E8tNIVi/vB/zavG3F8
 8TN42shcv5hTMVXNvb74VYPbCsICbn9zU0M4AXi1sq9f+h9zZCOy9fgdkWE+OWLN
 jvoNlSSljZ+OfTzxu3364d0Kvicl9FDoxbDiiEVrSaNxol0u2vIUnHyNPLDd0Ix5
 f5o4c4x9PCLCIVbSwzFZPTO6tjK7i7qWftyIVCUjJ+tCPZ9EmmMKHs9roWgbBdAX
 UkgXxMdO6A==
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx2wdx1tf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 09:42:45 -0700 (PDT)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso80781565e9.1
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 09:42:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778085765; x=1778690565;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KvzelPFNcl7MU+TM0miXboxQSsRGRRlAbQLX3lQgau0=;
 b=MLu/7lwMx72EQEMN58Fgmtm0gmoLL1L8be1SKML98XMuqqeOPEEWNhrw039MTzkjUT
 HgFwKD5fib1+xClsicpVHb86Pas4tDD9fhbE0wv4D3PNhBdowYaYghex2Ugj0GnKGtLI
 WSYz4zoBTxyWDZN63+sbm8k6IqfD+HZA7pUcrf2yG87fP4R0DpPlO4LRDA7AlOkph2BC
 QqCCyyOrQFUR1IT2gMTzqJNaKWGtDf6Va/arQ4orU46HkQGnC4jawLPvDzTDBObEopuc
 6DC3LRNSwikbtMY7FTvp1gJaCIfP4egnqFbxOFsjDoKI9rJKa5tO7RRu2e0/854HR1cD
 WaUw==
X-Forwarded-Encrypted: i=1;
 AFNElJ//qZQEtZWbAsvqCtwT8VHZaHnLZs4LM7cpxGqzx/DxcZChfrkDYaJFjzBeiMW32yi8pHip+7a7Gg8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwkS4vaXAl0mshY7lqEpHgOsXGQx9Vm2NSgnL80HInve2H40zd3
 eGju0g3FmJNE31Rty/6uoUXWkqWXbheVtVta1wDxVflhTT3/aThgMHukd7SMTt7WgRXeYPwPHfQ
 tghjCJd+xkXTrYcL0q1UWkd8thFf4VVTgP05YLSAxl1TGryRcrZAUBwOPsnjhhqVWGHpj
X-Gm-Gg: AeBDiesUDnunYFaDV5TDnRNRT1Ddhua643QYO+Re/bH5Lxkzyx9/ZmBNByXEYaitxk7
 0/VXKlT9INMVbqW1C36CZieF4Asf7+RmihiYEC7PKgLcLxxmMS0Z6eUfr0J+uoWxJ4H+ZHNgQIi
 570Tv6CILMDz6c+xWXIotqrWu8nY88UOKoJLG8kbs9vcVO59wqfv/roObQx6T/Djz+qPtH1GYjP
 RXeiVVPKHmUpiV5Gm0WNZl23/cmM95QTaUqAx5N4w1cqnEgDcEV47tOzkC5MwQXUmidSDN8J7Rd
 hHup5Zql8QNaTlx4Q7Mc/8XXfaqGi8gbBnnmJtaIbloB9Z3OoWjsPg+wXlOV6oymo55FCcppIur
 wJqpSa2j3DQDJ9RsBfaBSXBQ+L/hrSnBWwuDEKUrNSpmwxZbaOjI2oCScZqSKKZyAPbyI/C4Aur
 Oqnv9QclX3WkjfQ/1ydHbhAObrS6nTxUN+JGiwprQTD0cjgDEK8tnMLMVw/UXXlRHoLD21U/LHV
 4S7I1NAtX/bYDVQPAfLifrG1rx3yIoJ7Q==
X-Received: by 2002:a05:600c:2ed3:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48e51f427b3mr46111965e9.15.1778085764711; 
 Wed, 06 May 2026 09:42:44 -0700 (PDT)
X-Received: by 2002:a05:600c:2ed3:b0:488:d6eb:e63c with SMTP id
 5b1f17b1804b1-48e51f427b3mr46111525e9.15.1778085764222; 
 Wed, 06 May 2026 09:42:44 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb1a7sm113622555e9.9.2026.05.06.09.42.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 09:42:43 -0700 (PDT)
Message-ID: <9a7e51bc-351d-4ca0-8080-fd9e0265f3a0@meta.com>
Date: Wed, 6 May 2026 17:42:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] vfio/pci: Fix vfio_pci_dma_buf_cleanup() double-put
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>
Cc: Alex Williamson <alex@shazbot.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
 <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>, Alistair Popple
 <apopple@nvidia.com>, Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org, =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-2-mattev@meta.com>
 <20260501131236.278ac431@shazbot.org>
 <9304aada-ee84-4cf2-a1d7-82313eda07aa@meta.com>
 <20260506152937.GJ11063@unreal>
 <c0bd0e23-712c-483e-a809-47126ab6e9e9@meta.com>
 <20260506161441.GK11063@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260506161441.GK11063@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fLsJG5ae c=1 sm=1 tr=0 ts=69fb6f86 cx=c_pps
 a=Ech0Gv1thIkdqUNjVc2Ehg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=Ikd4Dj_1AAAA:8 a=VabnemYjAAAA:8
 a=uIBLic6oc_-Le5kNHd0A:9 a=QEXdDO2ut3YA:10 a=cZgK7WzY9ta9U-6s7oqD:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: bc6wiwRXTGFZBu_bEEJ3PY44I6_VM4FL
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE2MyBTYWx0ZWRfX0uR97ZyJxBMR
 2ALPOT+z5VSXey90WV0CR0BansDWyjT/5x2yfssZm08C6QyfhLlc6SpIPhcVxSg4dWdhHOs5spZ
 NkBZmKvUd+fXDOIEN09Sh/Rd0TsY4hwB92ydq3C1OrB2vPboxcPTsnbnV0ir/y6TI3CRBeXIY2Y
 4pY0Yvbr11kM/4OowhrkQdsHZSbHHTYK1LpkmWFyVtZkIG6W6fUG+OXUsGtRpXv8koxGgFogPpA
 HV+6a/lI6cxwv4lnAVWoODJ09nbjoV/BMH03S8pLK1NtdWZkWdHObyqbAJfTC6o+vG8DWw45ySY
 eeh2otBTRnPYVRMAw29ye4WTR839JPfHAZM+zSZiRXF8fU2atA23en/VqPASeez8AbPZSgmtfuv
 Wim140LYt9625lsaNoWhd0qSwiTEZygwv6vcub1pib2cW/9P8WTat6M0rv88lxbstzpvsO+EKLw
 iWHhzdVusE9nGP62Psw==
X-Proofpoint-ORIG-GUID: bc6wiwRXTGFZBu_bEEJ3PY44I6_VM4FL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-06_01,2026-05-06_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 07 May 2026 10:13:17 +0000
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

Hi Leon,

On 06/05/2026 17:14, Leon Romanovsky wrote:
> 
> On Wed, May 06, 2026 at 04:55:27PM +0100, Matt Evans wrote:
>> Hi Leon,
>>
>> On 06/05/2026 16:29, Leon Romanovsky wrote:
>>>
>>> On Wed, May 06, 2026 at 02:53:31PM +0100, Matt Evans wrote:
>>>> Hi Alex,
>>>>
>>>> On 01/05/2026 20:12, Alex Williamson wrote:
>>>>>
>>>>> On Thu, 16 Apr 2026 06:17:44 -0700
>>>>> Matt Evans <mattev@meta.com> wrote:
>>>>>
>>>>>> vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
>>>>>> revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
>>>>>> the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
>>>>>> second/underflowing kref_put() then wait_for_completion() on a
>>>>>> completion that never fires.  Fixed by predicating on revocation
>>>>>> status.
>>>>>>
>>>>>> This could happen if PCI_COMMAND_MEMORY is cleared before closing the
>>>>>> device fd (but the scenario is more likely to hit when future commits
>>>>>> add more methods to revoke DMABUFs).
>>>>>>
>>>>>> Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
>>>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>>>> ---
>>>>>>
>>>>>> (Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
>>>>>> and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
>>>>>> context, so including in this series.)
>>>>>
>>>>> We really need a fix for this split out from this series, It's already
>>>>> been shown[1] that this is trivially reachable.  Carlos proposed[2] a
>>>>> similar solution to the one below.  I was concurrently working on the
>>>>> issued and suggested an alternative[3].  Let's pick a solution for
>>>>> 7.1-rc.  Thanks,
>>>>
>>>> It looks like [3] is progressing, so I'll drop this one when I can rebase
>>>> onto it.
>>>>
>>>> I noticed [3] removes the dma_resv_lock(priv->dmabuf->resv) around the
>>>> priv->vdev = NULL, and this series' vfio_pci_mmap_huge_fault() relies on
>>>> vdev only changing whilst resv is held to resolve a race between a fault and
>>>> cleanup (see patch 7 of this series).  The handler takes resv so that it can
>>>> stably test vdev in order to take memory_lock.
>>>
>>> I think that you should rely on priv->revoked and not on priv->vdev.
>>
>> Needs both unfortunately, as the fault handler ultimately needs to take
>> vdev->memory_lock.
> 
> One can argue that if priv->revoked == True, all accesses to device
> should be denied and treated as priv->vdev == Null.

I agree, the handler will early-exit when a buffer is revoked.  Though 
when it _isn't_ revoked, it still needs to go through a careful set of 
steps to keep vdev around long enough to take the lock (and ensure it 
still isn't revoked, etc.).

I think the sequence in patch 7 still works (with Alex's patch in [3]), 
since the invariants still hold:

- if not-revoked then vdev is still valid (IOW, vdev = NULL only happens 
after revoked = true)
- revoke is only changed when holding priv->dmabuf->resv

OK, [3] doesn't seem to break this series (just context/rebase).  Sorry 
for the thinking out loud, it'll be good if someone sees a flaw in my 
reasoning though.

[3] was https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/


Matt
