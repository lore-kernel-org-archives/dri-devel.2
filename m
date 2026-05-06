Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24F8CD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B54010EFCF;
	Thu,  7 May 2026 10:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="V5KJ2Qsv";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38BC810EDED
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 15:55:32 +0000 (UTC)
Received: from pps.filterd (m0109331.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6462VgGs1025377
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 08:55:31 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=Utn027AUC8UDDUJXMpqeQ33wB0VHRXSGiBE+zdS1lww=; b=V5KJ2QsvDqXI
 jsaAHALFGR6sjzWQOy2R8fDT1m2z8Vp+BEzdkIo2E0PzKZT3MoRqQ2oxFN/cf+RI
 zNdxXgZ/yC9TXtV3oASmSQ58occoBlUXUmIfLY3rEyKedGP+G26q9XfNbpy/cyyL
 ATxSfUlKU+0cbiv5isn7bvGMH98bzLSc6Cor0iZ7DZsrSsJL5Y4HlAHYbDQh47an
 JgHWaoOdPrg/9kinsjy7I1FZDdWBQ1dYEjz8FgwQ2xDR3PrtkNygxgXG3PaHOc5k
 UAwldnK7l+6FDmkB2j0Yjq5S7uSzqNd6Utnc2cINNmewbNDHUuno2cDWgkWZsFdm
 9itz8d4OIQ==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwf37935j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 08:55:31 -0700 (PDT)
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-441243ba35fso6478235f8f.0
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 08:55:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778082930; x=1778687730;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Utn027AUC8UDDUJXMpqeQ33wB0VHRXSGiBE+zdS1lww=;
 b=CyytcIN2tm1Ha6xsA9TqhfD+2FUeX5TWyjweqXiElySrw+Yks3SUKpUGAVU1AZLZuy
 PFhShpvP4XusSr1S3EFdcP4PU+sD77EnIyipmdwnRmZUhzM56mHtppLQHkDkilY6HBBQ
 gMsE2jnSbRZHwltLQkq9u6M7xzDETw0+IpiFYibp85zYyTzidSMKC8VrsAwVf3OEQlDX
 QfX9Rmv6sQpqHppBue9OmRfki90WHHGHmD888Rs2Ituc+JuZv+9HsT9lJDLu4Dz3dh6b
 iqitEw6q6mnuLTktmD2K2Wplhdxlxyjs/AiHoEeO48MwaQWAgrAYG9b8NXq3VntHJkko
 92dA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LmFNPoMk10Nbb+JBuwFPBBFNGZY6XXFvDju2vT45N/8PvLC1WEQTu98eDA6JH4zEl+ED39pXgiJw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwzZs+fomVW9cX8C8LR5OATbm0NGsxB6QkcSRFFYy+IUg6dfMKc
 TOr8aUfaEm75pgYovkQVi1zscI9u3WaflhjAYMrr1ypkqhbhGT9n+veG6xccBQ9ARbnT5SCfUBt
 dw/NzJrDQXrm4JcbMDZq9bXwAzqGj74OVXhNT4mNMvJ9B3MQIruusAGx0cC1MnP9KPKcA
X-Gm-Gg: AeBDietaCXV2VkiangtCprXV0Q7vV9Gex3Ar67RAXjO4ByJnua0KFtQC30hxIyhRQuU
 BPk6iTZcFnwluzZUQ1SO+DUEl0FjYHOVUBRGBcjAv8ITtztnO1IAj/6hLyYZVelAi71aLSV45sZ
 yEnawG6ygeoo70cTMey//5cH8zOH9G9TRj7uHx7vJWxLjQ1EIk70/n9ohQiy5L2LANQVMmChHos
 +aeziWwqKVqg6SYI+dMXOvMCZxfnWyEevkgm7mG7Yh8BKBpVvBrlNxXdJN8PUN0qMhJk1DAdF23
 8s1g89EU+3ufKQGlgBrcqhadhiK7uXWJV8jqQ9F1KBXANuj+wM3ZUIVllXssS8khJbHXrEi+ZjX
 MMhHG+fvm9vA2g+xXUAvRnPTcEWzVHNC9vh+uHN9ndQSnm4qaGmz1s5uk/4Rr7Una1XhqeWCfFE
 YE35+tH4cA1MBWN7fwL966Md5k4dc5W9DTP324cli+fb6xpHZTLpVmBhsUUrepCEzb37seFvjUP
 71z4JDxKhFM4HsqaB4FvPYFXnY2Z4wyjg==
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id
 ffacd0b85a97d-4515da967c3mr6651393f8f.37.1778082929995; 
 Wed, 06 May 2026 08:55:29 -0700 (PDT)
X-Received: by 2002:a05:6000:2082:b0:441:1c18:f779 with SMTP id
 ffacd0b85a97d-4515da967c3mr6651329f8f.37.1778082929442; 
 Wed, 06 May 2026 08:55:29 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052483166sm13251331f8f.7.2026.05.06.08.55.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 08:55:28 -0700 (PDT)
Message-ID: <c0bd0e23-712c-483e-a809-47126ab6e9e9@meta.com>
Date: Wed, 6 May 2026 16:55:27 +0100
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
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260506152937.GJ11063@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE1NiBTYWx0ZWRfX7ELpglwcdEUx
 aOa+YrxgfVbc/ocfnCWYOKufj9iJs9CRuE+A7cXSFBpW2ubXGL6ZjT+huDMWe5Oc0/Dkx7QrSJZ
 1DWqsvEf81e8VIwvwB2t45rXlsKyjuNMkn/36nyn9ceI3JOAcj9WYCZ5LU22TM/c2A/3Yi/hMnD
 t5lpw84yb+cGGaDFJ6rTUjHA7/ezwTMJLY9ds/Ix3J70fqa+BLFIApWsoT7GndIqjKDKb/T8pJp
 EjxB5GaS0ZOY4W8vzuJ6haVq7S84Njra4WSavElzJ9YvniE/kmW2OpmD6DeOO6Uc2m++Rq3Iibt
 ztoo+MnX5wbzQfH3cQAbWtz/HNw5YcP0pw7SO49kzAtzNcryfmaSR9jPuIesQSK3E8OcOKa+lKR
 p66STsKX1tr2PollJGs5lXcABNqV+avExmsReyT7cfhsXqYVz8H6UTH7b5Yn5QAQC2UuVHhrWdX
 6EfC43Cr62r9VRy+ZQw==
X-Proofpoint-GUID: bjZFnehGAyTWS_Npt0jQj64xAN2tKM0b
X-Authority-Analysis: v=2.4 cv=GKs41ONK c=1 sm=1 tr=0 ts=69fb6473 cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=wpfVPzegXHpEFt3DAXn9:22 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VabnemYjAAAA:8 a=bm6tUXqWTanbjDFH1akA:9 a=QEXdDO2ut3YA:10
 a=F7q00xkr9EfWfQvbdVXI:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: bjZFnehGAyTWS_Npt0jQj64xAN2tKM0b
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

On 06/05/2026 16:29, Leon Romanovsky wrote:
> 
> On Wed, May 06, 2026 at 02:53:31PM +0100, Matt Evans wrote:
>> Hi Alex,
>>
>> On 01/05/2026 20:12, Alex Williamson wrote:
>>>
>>> On Thu, 16 Apr 2026 06:17:44 -0700
>>> Matt Evans <mattev@meta.com> wrote:
>>>
>>>> vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
>>>> revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
>>>> the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
>>>> second/underflowing kref_put() then wait_for_completion() on a
>>>> completion that never fires.  Fixed by predicating on revocation
>>>> status.
>>>>
>>>> This could happen if PCI_COMMAND_MEMORY is cleared before closing the
>>>> device fd (but the scenario is more likely to hit when future commits
>>>> add more methods to revoke DMABUFs).
>>>>
>>>> Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>> ---
>>>>
>>>> (Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
>>>> and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
>>>> context, so including in this series.)
>>>
>>> We really need a fix for this split out from this series, It's already
>>> been shown[1] that this is trivially reachable.  Carlos proposed[2] a
>>> similar solution to the one below.  I was concurrently working on the
>>> issued and suggested an alternative[3].  Let's pick a solution for
>>> 7.1-rc.  Thanks,
>>
>> It looks like [3] is progressing, so I'll drop this one when I can rebase
>> onto it.
>>
>> I noticed [3] removes the dma_resv_lock(priv->dmabuf->resv) around the
>> priv->vdev = NULL, and this series' vfio_pci_mmap_huge_fault() relies on
>> vdev only changing whilst resv is held to resolve a race between a fault and
>> cleanup (see patch 7 of this series).  The handler takes resv so that it can
>> stably test vdev in order to take memory_lock.
> 
> I think that you should rely on priv->revoked and not on priv->vdev.

Needs both unfortunately, as the fault handler ultimately needs to take
vdev->memory_lock.


Matt

> 
> Thanks
> 
>>
>> Must your fix change vdev outside of holding resv?  I'm still sketching
>> alternatives; at first glance perhaps the fault handler could rely on vdev
>> being valid if !revoked, which can be tested holding [only] resv.
>>
>>
>> Thanks,
>>
>> Matt
>>
>>>
>>> Alex
>>>
>>> [1]https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
>>> [2]https://lore.kernel.org/all/20260429182736.409323-2-clopez@suse.de/
>>> [3]https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/
>>>
>>>> drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++--
>>>>    1 file changed, 7 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> index 281ba7d69567..04478b7415a0 100644
>>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>>> @@ -395,20 +395,25 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>>>>    	down_write(&vdev->memory_lock);
>>>>    	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>>>> +		bool was_revoked;
>>>> +
>>>>    		if (!get_file_active(&priv->dmabuf->file))
>>>>    			continue;
>>>>    		dma_resv_lock(priv->dmabuf->resv, NULL);
>>>>    		list_del_init(&priv->dmabufs_elm);
>>>>    		priv->vdev = NULL;
>>>> +		was_revoked = priv->revoked;
>>>>    		priv->revoked = true;
>>>>    		dma_buf_invalidate_mappings(priv->dmabuf);
>>>>    		dma_resv_wait_timeout(priv->dmabuf->resv,
>>>>    				      DMA_RESV_USAGE_BOOKKEEP, false,
>>>>    				      MAX_SCHEDULE_TIMEOUT);
>>>>    		dma_resv_unlock(priv->dmabuf->resv);
>>>> -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
>>>> -		wait_for_completion(&priv->comp);
>>>> +		if (!was_revoked) {
>>>> +			kref_put(&priv->kref, vfio_pci_dma_buf_done);
>>>> +			wait_for_completion(&priv->comp);
>>>> +		}
>>>>    		vfio_device_put_registration(&vdev->vdev);
>>>>    		fput(priv->dmabuf->file);
>>>>    	}
>>>
>>

