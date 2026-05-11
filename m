Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D769CD37B6
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BF0CC10ED03;
	Wed, 13 May 2026 07:53:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="l5CJ9j8P";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 04AFF10E1D0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 15:30:46 +0000 (UTC)
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64BEvhxD065732
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:30:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=bO0OT5HbP3xMB9H1AybFAyJkqZoplUb3t4HsCcdmo+w=; b=l5CJ9j8Pt4jd
 oo2WjP8zAaxDoOQtii5Xv4O/D6fdD0hd4ART8sIyryLJf8dOqBTz/yQ+uerxGOHZ
 KqdDkk5BUPra4La+lrsGoib67wFEHFUXUYKoT5+8hWBy9OIx+D9V8sE2QmHW+yMT
 h35Kt8l9MYRDqqlmJv0WkUYcqwdMG9jVc7x0RKu6oILOR1twr/YLgUwLpnf350vz
 +GJ1mWfeupTHI+JMhKWxRZCtBSmD+//ybC+8KUEpo8p5QU7ZNmMMdXXRB4OqZre1
 WwVJheJnIclwhharvAmggbk7AX/pj+QZFuYaS5iSYZGy3zEuDg1zR03BUoikGeZS
 XDLlFw4U2A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e2082b5dc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:30:46 -0700 (PDT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-130aab78a09so4324105c88.0
 for <dri-devel@lists.freedesktop.org>; Mon, 11 May 2026 08:30:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778513445; x=1779118245;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bO0OT5HbP3xMB9H1AybFAyJkqZoplUb3t4HsCcdmo+w=;
 b=I1ryuwCj4yXU0MCeJvBmoy+QemAxakd38O2sx2pD4xBZ5fyBFpKGy6kAQd7Bh1d0bI
 ZF1I87yXSsXUPa4UujNmVuBUBT9WqZ1YXTZcf72b5X8Cqvn7YC+hH/JRXAunlZaKMkQh
 IGaI5RgHn2MMs7lx9dwz1zcf99OR5cxts44/me7wB1TsZG3ZCghbPWVXBGz164hW/2r8
 HAaeFTdXRg3KOzQYbCeHpBelPguMpBOlVCkJ3f4YTX+dJH2XYOaAUfmyYnuPVsyfWGJB
 4168CKObKE7rmIbR11vcOT/jL0nA1BHgmnO64YbN7dRNrT3MgFQ86rco8nKN31sYbHM3
 TisA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qacQcytgbmaavbfXY3wwyuFSk8TwLOhhl/WwgVJ3XpjBncARDfs3kxVWp//fatZ8vh+4U13xcbbo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwGQEz1sYDrVfftSfh+ScdUPjkZw8d1njoXTDDR8Da5ungaHgWc
 4LfUL+3jWykIGrpKB7viYPCvFIlOAcjU9uW5KZ7/+IQniSnJmgi2JOg6UVXajRrVKZ8GFeopumQ
 gp75u64ti2fy581eNIaUrdwPjZMNs1w6mN17bsSIFzdliLpD5ZRP+E51jyWjYfRMZdUwo
X-Gm-Gg: Acq92OHZPajthSBGoGk4VSCN8iC5kK0WEXq0aYcmDzIoVgL8iQfo8LyXDnfaN7TKGkT
 6YT85NpHSI+z8SqBYMD4JNpdzWtnLkyG5RdO1wv3m5xYj9T5plxpqvk6Z26AwBLx3kTqgavGjry
 chk1wP43P7fo/7maXitROlSX5W3MQ27wd6C20FjEDe9FtHvYxcmstIA97vJVS9f6H1ploW3gg/X
 JqMhDj8SpEzRPB8kXPCaVvVzsEs6M53PFroZlKJ6jJASg4Q/S0B4mOkYql2TU21VULBQ7izozPa
 0V8cwMTo8NEHoFESmI3tBniQu9Lqu//y2WUMxK0WozQEEhm64bwcybSAVoJUBl8qiBth2nTg++Q
 9GDqg9Hp+58MDQva2vsFJeuX2
X-Received: by 2002:a05:7022:2399:b0:12d:d27f:d817 with SMTP id
 a92af1059eb24-1318550ae20mr12188184c88.19.1778513445355; 
 Mon, 11 May 2026 08:30:45 -0700 (PDT)
X-Received: by 2002:a05:7022:2399:b0:12d:d27f:d817 with SMTP id
 a92af1059eb24-1318550ae20mr12188121c88.19.1778513444549; 
 Mon, 11 May 2026 08:30:44 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327810ff4dsm14644541c88.3.2026.05.11.08.30.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 08:30:44 -0700 (PDT)
Message-ID: <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
Date: Mon, 11 May 2026 16:30:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>
Cc: Jason Gunthorpe <jgg@nvidia.com>, Alex Mastro <amastro@fb.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Mahmoud Adam <mngyadam@amazon.de>, David Matlack <dmatlack@google.com>,
 =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Kevin Tian <kevin.tian@intel.com>, Ankit Agrawal <ankita@nvidia.com>,
 Pranjal Shrivastava <praan@google.com>,
 Alistair Popple <apopple@nvidia.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linaro-mm-sig@lists.linaro.org,
 kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com> <20260426105215.GA440345@unreal>
 <20260427083644.4ee174cd@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260427083644.4ee174cd@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: lUDRjpsutTQwXl7FNQIX7QnStJ0m0IbV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDE2OCBTYWx0ZWRfX3gTSC1G+GqsB
 ndJCIAgszfl75QwxSG+5j6vDG40S3XehdaTCJ84JGhbeviPeWAMSQlCfn6deCMhJUCzDQV+j00X
 66hHGFYBmXWAM0f3bo4rr/0Rcw2TuicMtg6KCBDVz3kPxjpQ9By/huR4NuBfgi4KibkiRydWsea
 9q04QylFpPwr7PJsQGJLHRGsYMIPl9kuIANZaYeyFoFtTYRw9L0N1+32T8so7QBZS92GozOri4y
 jqvzKHUY33MaXddMEXxxeClM4PT1MKQ//lxy3qQ6EPVZihAgpPJZTiavstu+6FnmtgQzCwOw4LU
 kKSSNXGQzO4NfqPTM6ONf2ZKi/A/SzHjaQQqFif2s+fuqEeCbW2YswDj15TivXlfBJOgKRhmtY8
 Me5w1nnPCVsQ/sM5SRe7jwC78jnhbESUs6kWGylGVXfuccgtvZ6Ze+p+qTw6AGHPISyQte8SZgE
 RcyHs1n/5cZPAByAXNA==
X-Proofpoint-ORIG-GUID: lUDRjpsutTQwXl7FNQIX7QnStJ0m0IbV
X-Authority-Analysis: v=2.4 cv=RZqgzVtv c=1 sm=1 tr=0 ts=6a01f626 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=8elwO82fXORLTBIkMd32:22 a=VwQbUJbxAAAA:8
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Ikd4Dj_1AAAA:8 a=02ciemoj1X7HeLU9vPcA:9
 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_04,2026-05-08_02,2025-10-01_01
X-Mailman-Approved-At: Wed, 13 May 2026 07:53:28 +0000
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

Hi Alex, Leon,

On 27/04/2026 15:36, Alex Williamson wrote:
> 
> On Sun, 26 Apr 2026 13:52:15 +0300
> Leon Romanovsky <leon@kernel.org> wrote:
> 
>> On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:
>>> On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:
>>>> A new field is reserved in vfio_device_feature_dma_buf.flags to
>>>> request CPU-facing memory type attributes for mmap()s of the buffer.
>>>> Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
>>>> PTEs for the DMABUF's BAR region.
>>>>
>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>> ---
>>>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
>>>>   drivers/vfio/pci/vfio_pci_priv.h   |  1 +
>>>>   include/uapi/linux/vfio.h          | 12 +++++++++---
>>>>   3 files changed, 23 insertions(+), 5 deletions(-)
>>>
>>> Nice and simple
>>>
>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>    
>>>> @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
>>>>   struct vfio_device_feature_dma_buf {
>>>>   	__u32	region_index;
>>>>   	__u32	open_flags;
>>>> -	__u32   flags;
>>>> -	__u32   nr_ranges;
>>>> +	__u32	flags;
>>>> +	/* Flags sub-field reserved for attribute enum */
>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
>>>> +	__u32	nr_ranges;
>>
>> Alex,
>>
>> The TPH proposal extends the flags field in a similar way, but I suggested
>> a different approach to conserve bits. At the moment, we spend three bits
>> on a single feature, which feels wasteful.
>>
>> What do you think?
>> https://lore.kernel.org/all/20260409120415.GF86584@unreal/
> 
> I already proposed a very different interface for TPH that decouples
> the dma-buf creation from setting the TPH values:
> 
> https://lore.kernel.org/all/20260423132016.4a25e074@shazbot.org/
> 
> This is overall less intrusive than the TPH change proposed, but it
> could still make sense to align this as an operation on the dma-buf,
> that can be probed as a separate feature.  Thanks,

I'll add a VFIO_DEVICE_FEATURE_DMA_BUF_ATTRS in a v2 instead to get in 
line with the TPH work, no worries.

For the benefit of future hackers, how would you describe the criteria 
for adding flags to this existing field?  What hypothetical feature 
characteristics would be appropriate?  (Maybe it's that these attrs & 
TPH add scalar fields in several bits rather than a simple boolean.) 
Two of us have independently added something that's turned out to be 
inapproriate so some guidance would be good.

Thanks!


Matt
