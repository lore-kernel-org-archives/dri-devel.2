Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 127CACD3439
	for <dri-devel@archiver.kernel.org>; Wed,  6 May 2026 07:47:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C21D10E50B;
	Wed,  6 May 2026 07:47:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="s2knLRbe";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6D1E710E13C
 for <dri-devel@lists.freedesktop.org>; Tue,  5 May 2026 18:13:57 +0000 (UTC)
Received: from pps.filterd (m0528009.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 645EFilu3822837
 for <dri-devel@lists.freedesktop.org>; Tue, 5 May 2026 11:13:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=n/8Evrp0/Cs5xE91fVKhf/YUdfmd3rQjcqs7sGTTtLk=; b=s2knLRbegq9X
 RCpDDJ/hBxKjw2pRkecpdWzz2gHGLBfGVyowgs8mooCbRWX5MHpJSEhh8YVlH6AQ
 8RJ4/8+pU0ux8fOyIJoDPGbyaMfqNNhuUfCBWb+L+6lEdCNzSvCxg1fBEoqSc2+V
 EbmQz+k9tHe0F2aoDYv3pCDhVCvsHHbhW/6qRUBFrMHrkZVXCYrRkaY7BYYwJhni
 o1DNwr+CwfydLAJE+CuHn63B/ToXKcgo18Id141iN/gmxjPmOMMEzF5gNaollCf6
 s+rXyR2Cnq0QDf7k1BVwbMqmN9WyJoH39FmoZTvdqbFOhWUbt8KRnCrHywPFKfuB
 XIvDNHkjbQ==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx315evfd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 11:13:56 -0700 (PDT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so1054216eec.1
 for <dri-devel@lists.freedesktop.org>; Tue, 05 May 2026 11:13:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778004836; x=1778609636;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=n/8Evrp0/Cs5xE91fVKhf/YUdfmd3rQjcqs7sGTTtLk=;
 b=RxvnnrUjOzct/SmWKobzOK7cyQvq/IsAawCl/eRkQl6nQEtkNBSFe673aHTAMYaGr/
 LzzHG/7SULMd/moaPS/5T5hoLggpFkAO9cle/Fg/AL1ssilbRUpttG0Zk0v/6XI6obkN
 BscVbkZCRHu07LP2gCti3Ft4HhRjHhSYfevMH6aVjg7kpI//sOC/yIJNfqS8/dHbSoFz
 uLQ2NuR4lKAXqpTSjmQ8Aersm800mAYBj/Wjy53z5IYY6flcxchheZjV5MPJ0swsSpWg
 4xt+3CJe56KMNXC5Xo4G+xv8qMdP+qRgFyJloc2y1tTgPNTP0GTMJeRtLXJeT5GCsnXt
 QLMg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8cE+zSdfhjXsYRqd63ydPgmh+XriM2hElt8ajhTjxOY6hvPxn6vAZnhzYXvHlALTHJmIeLqWKwAvg=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjROCOR3QTb+kEd0AhUSrRkye/Oa3Iy3DB5GdBtDoD9B3KqxMf
 xsAyxKtKM9X8Ny3ybZ4//KbfSpQBd2qyg6UAr2kXx2wsWHOioSzPnEPvYEUHLBbt6IdN5/Gc9vg
 CCkPeQHw+mPGYfaXUSf+iMrCO+ynDbxAfhEh4Ng9/erkRNQWa9Jzv4Z3HG9nz9wyWsnLh
X-Gm-Gg: AeBDietCcf/+4LupHQlVXdTPmYZDGo3jPEow1TDoifeKgUvpve0dyLcB1rp6SkjyGdJ
 xjIqqwigTLv8MKM9uoBDJJz+D3wVAz23CvktbtA4putgIk+V/vwlHdjye4lW78eJSNOIT0RbG+X
 v34+86CwPmU5dVcGZWTbzAH6aDYRXGATUcztj0Phjz/Fr2irdbZRUb0xIQotOeRlFi/wtoedrl4
 kroHR9sZnedht5NFen7a/MI79aiQAb5DtABoGEyoW7m82uSj46Bs9gf8fs1GPHUZrvy3v17rstD
 gTL5QSsgmXSd9N5eLco5+nsx6scjPgEVX/u4dyMw0nMXVKvL9WggW/N7S1v9hji2EM3fy2pbQhG
 o3xJz6PudAezMWntlm+TkoaL2H3E0vqe1eJkg1zMY
X-Received: by 2002:a05:693c:300b:b0:2f2:32bc:788a with SMTP id
 5a478bee46e88-2f54b465ca5mr163899eec.25.1778004836038; 
 Tue, 05 May 2026 11:13:56 -0700 (PDT)
X-Received: by 2002:a05:693c:300b:b0:2f2:32bc:788a with SMTP id
 5a478bee46e88-2f54b465ca5mr163886eec.25.1778004835478; 
 Tue, 05 May 2026 11:13:55 -0700 (PDT)
Received: from [10.0.40.29] ([51.52.155.79]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2ee3bc6a79esm25025486eec.26.2026.05.05.11.13.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2026 11:13:54 -0700 (PDT)
Message-ID: <2d0eb275-64ef-4710-806b-36f6b32f7122@meta.com>
Date: Tue, 5 May 2026 19:13:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
Content-Language: en-GB
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Williamson <alex@shazbot.org>, Leon Romanovsky <leon@kernel.org>,
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
 kvm@vger.kernel.org
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-4-mattev@meta.com>
 <20260424182426.GG3444440@nvidia.com>
 <c598a21e-ee50-42d9-98dc-2959e84ace50@meta.com>
 <20260430171106.GA6829@nvidia.com>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260430171106.GA6829@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: uDid2puwkUjXFO1GMwC4c0c9q4_kSYgH
X-Proofpoint-ORIG-GUID: uDid2puwkUjXFO1GMwC4c0c9q4_kSYgH
X-Authority-Analysis: v=2.4 cv=K4AS2SWI c=1 sm=1 tr=0 ts=69fa3364 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=Dv35txUGz5gI0hTa:21 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22 a=U_y8lYiYyhHBU5rMqhb2:22
 a=znC_9Zf_qiuKpCydwTIA:9 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA1MDE3NyBTYWx0ZWRfX8GaVy5pgn3Xf
 9YIPM7u9zDBbaa5d9hP6c9Qv/hiS6vhaapz+ed4QqbZmiaaBUYOwY9J6SZHunwJbuPD8DnvcWCc
 t5YryquKAev7+IwmCBjPwais7Z4eXMC9Bp81uoNhvb/77J2Oz3zp5tADjpUdq0vVfByiB33RyNc
 Y/5A67La0GpkTEdRzgeJ9yLBvMG3nlZ0b246pEcUDkeU9800Y2HFSvcE5UqXKCmkKnFxVQjVmGa
 Y2teTI5X9U+VlF2jQVtyHppjWaT2Qw/P73Cc9dCzpu17ZOZqeaDgzvSGVJc9Hubt7SoRNt7Wk9k
 ic5ln61TVpjQZeY8pfy+EoJNxPIylC6xL1Pauy3gCOopgtqU9ACLpD3hbSglu/LDNPXzHJ6mmb2
 nB/h1sk7pNwDbQZlpng/6aSFPCwoDttkm6Aa0QxBC72W8+veds/bnS2eEYuXLSeLqrtRDyTSys8
 bpCzQKtZ5Zq8VjGx9Nw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_02,2026-04-30_02,2025-10-01_01
X-Mailman-Approved-At: Wed, 06 May 2026 07:47:21 +0000
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

Hi Jason,

On 30/04/2026 18:11, Jason Gunthorpe wrote:
> 
> On Thu, Apr 30, 2026 at 05:47:49PM +0100, Matt Evans wrote:
>>> On Thu, Apr 16, 2026 at 06:17:46AM -0700, Matt Evans wrote:
>>>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>>> +				   struct vm_area_struct *vma,
>>>> +				   u64 phys_start, u64 req_len,
>>>> +				   unsigned int res_index)
>>>> +{
>>>> +	struct vfio_pci_dma_buf *priv;
>>>> +	const unsigned int nr_ranges = 1;
>>>> +	int ret;
>>>> +
>>>> +	priv = kzalloc_obj(*priv);
>>>> +	if (!priv)
>>>> +		return -ENOMEM;
>>>> +
>>>> +	priv->phys_vec = kzalloc_obj(*priv->phys_vec);
>>>> +	if (!priv->phys_vec) {
>>>> +		ret = -ENOMEM;
>>>> +		goto err_free_priv;
>>>> +	}
>>>> +
>>>> +	/*
>>>> +	 * The mmap() request's vma->vm_offs might be non-zero, but
>>>> +	 * the DMABUF is created from _offset zero_ of the BAR.  The
>>>> +	 * portion between zero and the vm_offs is inaccessible
>>>> +	 * through this VMA, but this approach keeps the
>>>> +	 * /proc/<pid>/maps offset somewhat consistent with the
>>>> +	 * pre-DMABUF code.  Size includes the offset portion.
>>>
>>> I'm not sure I understand this comment?
>>>
>>> For the old path vm_pgoff for byte 0 of the bar starts at some large
>>> offset
>>>
>>> For the new path vm_pgoff for byte 0 of the first range starts at 0
>>
>> Glad you asked.  :)
>>
>> This is trying to achieve keeping /proc/<pid>/maps (or similar) somewhat
>> as informative as pre-DMABUF BAR mmap, in terms of keeping the VMA
>> vm_offs column useful.  Before this patch, say you mmap() two slices A
>> and B of the same BAR:
>>
>>   struct vfio_region_info bar_region;
>>
>>   vm_a = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0);
>>   vm_b = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0x4000);
>>
>> ...you'd see something like this in /proc/blah/maps:
>>
>> fffff4000000-fffff4001000 rw-s 10000000000 00:07 148     /dev/vfio/devices/vfio0
>> fffff5000000-fffff5001000 rw-s 10000004000 00:07 148     /dev/vfio/devices/vfio0
> 
> 
>> then the VMA's vm_offs would need to be thunked back down to 0 (since
>> the fault handler then treats vm_b + 0 as the first byte of the DMABUF).
>> That works/adds up, but then the vm_offs of both VMAs A & B both have
>> offset 0, and it's harder to differentiate in /proc/blah/maps.
> 
> Yes, and that would be correct.
> 
> The VMA output of lspci should show the exact pgoff passed to mmap and
> nothing else. Do not mangle it for "debugging".
> 
> pgoff is not to be used to show random internal FD details..
> 
>> We could possibly stash the original offset somewhere and then render it
>> in the name string, but the name's already about the max size and using
>> the existing vm_offs column is nicer IMO, doesn't need a new field, etc.
> 
>> I need to work on this comment then!  What this is trying to say is that
>> the DMABUF is made artificially larger than the part that is visible
>> through the VMA.
> 
> Yuk, that's another reason not to do this.

OK, fair enough.  I'll rework this and remove this one weird trick, 
thanks for the input.

Matt

