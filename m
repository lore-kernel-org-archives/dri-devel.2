Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04126CD3442
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9668110F08E;
	Thu,  7 May 2026 10:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="Z4RSZl73";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7358710E57A
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 19:03:13 +0000 (UTC)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6468nhW12796576
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 12:03:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=5ISWZb2UuFba0k6oi9EeUbt30lbvtpS4mraM2wLVkyY=; b=Z4RSZl73zxAx
 zZGJKjWbu3zTJO2Bsk7H+t9eLU0pGSMUd2EWPWWmTWTrjcXJW+t9cykPVmWT/6Na
 WhFVloj/P5riPIh99O4KiziEkw1rv5LZA/mZhy4TyD7T0ICAUcP4MGYeNRbK/nHE
 r9mAY5EM5AxyDLUb44A/sl+y/vDtcJn+m0fJvgbR80rNhdJ0BjHN943pa5tqCWng
 PbPABcZ9oR39oGQYRUmyHdfUR8kptlyAkWGNdDRXzAg9SW6Ud/2laX0vukK4dV7V
 GrqhUuFJxQOsbFydokpDYy0yIbLdkYADFwS9VzcXfG4iefkHSRTb5nZbsmrZvwQn
 GMozv0gGUA==
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dxtp2aaew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 12:03:12 -0700 (PDT)
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-488c2cc0cbaso146345e9.3
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 12:03:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778094191; x=1778698991;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5ISWZb2UuFba0k6oi9EeUbt30lbvtpS4mraM2wLVkyY=;
 b=JAv0MDufObbAPBTjaPT2QLaKmXn+50fmDgh8X4oiYqLn9dAvtDDiZLVQFm5Idj8/WD
 H38JEaKmJi8BKGWy0NaNbTnD531X8ly+R0Ri4y94SwELNJfZ7tDAzKhjgLjg3ribPWQy
 OMXUoJr+k30cqjHBQ8et8f7HvjAkdVc8kRoL6Ugd2E7S1lsXK3G8JYJkFqPoE5kiKtKd
 79xNimfVlY4zkXtQ0OOnoTGQfdk1FT9DVJB5u7dMB8RWglZldT576ESVx64UYuDL7bHR
 xnsvJSPOV6KoEX4iLt8PuodKiHJfNh6s+mJVlUi8yKvhFaPbnLtiC5Ygj7eM9rvA88jf
 ylcw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9WF4yKYqWwjbZGHx/jWiGEEt/gwdJWkhiQCRSNt52sTEOdzA0CqDkVjM3UPoettYcJxw+CwF7C2jo=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2pN/0sNQ8mOjiXtRbVRSBm8hpKpCkOstVJF704OnV1PSist5I
 TkCQYa0soYiYKBXawKNtWrrFwxQEF5/gn223BBXzOULyzSmFPuh4463PkU92ZuT+I1M5V0T3OJP
 ubXK7ubldtxmyLkh1JoiDOJcHItcU4WNOsmHRs3d+wp+dzQK6FSidOQAriwRihGTu6wJ3
X-Gm-Gg: AeBDiesgBIn2OD+D6tVbURdXTOYRF+Ziwjsu5qCU2V/QWb49/9uiwEeDsng+qJFt8dl
 Qv2WoxaZFCDknQZY7BfkQaP2iOOsb3gKwczRlKYXvIZmaj7ZnZu7mpr4o2WcrNY9YmQAEUR2KO1
 TDyKLZU/oQveqkzs26vd2flNsQYwl8IY34ywWdwYkqj4oDP99pBFyHQJmFpAt2xnkeJZv5m6lOU
 Be7Ygvrq4MvFfptfrQVzXcSg2BvKus+dM6pEsnPl7+13PfGKGSSGKvQ0fE5Y12OIEwR2+CKX+x5
 wPEd5xXIiHueryrmzmxXLgHHOqzNa9Us3aBgAdy10BNDw9W5oa5jGPSxrGIF76qkelxcsZYPVjd
 zRn2RS/cTexCirUcumOO5LyJqc+3u7+XZZ9JAcmZjm4dBFE8zC43WpF/h2QB9/JO4DCANz0kv1o
 +GiT776u1SwlF33jdQdHNB1Pw++5LaeXAt0LSYZ7KVOG4TUn7O/NqRNNMMiGMfhvDEixap8vVAu
 denZB9lu9NPpUAMFFQRDZkEbhXyrJFEew==
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48e51f183demr77118255e9.5.1778094191019; 
 Wed, 06 May 2026 12:03:11 -0700 (PDT)
X-Received: by 2002:a05:600c:8b04:b0:47e:e2eb:bc22 with SMTP id
 5b1f17b1804b1-48e51f183demr77117815e9.5.1778094190534; 
 Wed, 06 May 2026 12:03:10 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e538fb19csm62944065e9.11.2026.05.06.12.03.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 12:03:09 -0700 (PDT)
Message-ID: <52162da4-e1cc-4f90-a95a-218d6089cd71@meta.com>
Date: Wed, 6 May 2026 20:03:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/9] vfio/pci: Add a helper to create a DMABUF for a
 BAR-map VMA
From: Matt Evans <mattev@meta.com>
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
 <2d0eb275-64ef-4710-806b-36f6b32f7122@meta.com>
Content-Language: en-GB
In-Reply-To: <2d0eb275-64ef-4710-806b-36f6b32f7122@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: TQhm6dlmAru9KDaCOhMKjOT_RT4y9_d9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDE4NyBTYWx0ZWRfX1/VLNqB6VS+l
 +COSmlOT50nHeE1kiAcuXGbh2k3GAdP0W5AbQlKdqU7ag1yLXLjsBtnwASoAR1Da6VrhwHfYP/W
 HQWBWe3TrSf8OLrm1Y7RP7RQRYn6SvM/kZL0A+VwGhzMTEOVh1N9iF9I/mqnSpHalTraBzaXeXp
 FGWmwwQK4kxymMIIgHkNjWnFIIKUR/g6iacFGZMpL0zwBKUqvp/uAdBMlmtAnluGPf2EHO6Pe2E
 YYYYaGo+0nH2zCshhZx303x+2QaPvLq77dcqEve9CQSEEHyrAOSrBfCP8SbFupr//AULOv8uY6J
 c2oGEum7Lk7tOQ2VTTB3ZDMl6wddnbL09+/gPo9MLWLK9aGksN7kJTt1HMIH468aol00wlW8kwA
 PxZMsllquW5Jo6LmSAKkrPOooh4++++vyeSKiqrNkqwjD4BeSeEHOQBS39/XCMUWSbG3mNjKCqg
 In5WYn3i3Y1gaMeV5+w==
X-Authority-Analysis: v=2.4 cv=SsmgLvO0 c=1 sm=1 tr=0 ts=69fb9070 cx=c_pps
 a=ocXdEHcuFBd2kx0v6vcWqw==:117 a=Dv35txUGz5gI0hTa:21 a=xqWC_Br6kY4A:10
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=JnKecZnUtZousrUlYMGU:22 a=lFmndaL0naqy_eS1C0EA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=XRP02QYyWapGEjE7oHHB:22
X-Proofpoint-GUID: TQhm6dlmAru9KDaCOhMKjOT_RT4y9_d9
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

Hi again Jason,

On 05/05/2026 19:13, Matt Evans wrote:
> Hi Jason,
> 
> On 30/04/2026 18:11, Jason Gunthorpe wrote:
>>
>> On Thu, Apr 30, 2026 at 05:47:49PM +0100, Matt Evans wrote:
>>>> On Thu, Apr 16, 2026 at 06:17:46AM -0700, Matt Evans wrote:
>>>>> +int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>>>> +                   struct vm_area_struct *vma,
>>>>> +                   u64 phys_start, u64 req_len,
>>>>> +                   unsigned int res_index)
>>>>> +{
>>>>> +    struct vfio_pci_dma_buf *priv;
>>>>> +    const unsigned int nr_ranges = 1;
>>>>> +    int ret;
>>>>> +
>>>>> +    priv = kzalloc_obj(*priv);
>>>>> +    if (!priv)
>>>>> +        return -ENOMEM;
>>>>> +
>>>>> +    priv->phys_vec = kzalloc_obj(*priv->phys_vec);
>>>>> +    if (!priv->phys_vec) {
>>>>> +        ret = -ENOMEM;
>>>>> +        goto err_free_priv;
>>>>> +    }
>>>>> +
>>>>> +    /*
>>>>> +     * The mmap() request's vma->vm_offs might be non-zero, but
>>>>> +     * the DMABUF is created from _offset zero_ of the BAR.  The
>>>>> +     * portion between zero and the vm_offs is inaccessible
>>>>> +     * through this VMA, but this approach keeps the
>>>>> +     * /proc/<pid>/maps offset somewhat consistent with the
>>>>> +     * pre-DMABUF code.  Size includes the offset portion.
>>>>
>>>> I'm not sure I understand this comment?
>>>>
>>>> For the old path vm_pgoff for byte 0 of the bar starts at some large
>>>> offset
>>>>
>>>> For the new path vm_pgoff for byte 0 of the first range starts at 0
>>>
>>> Glad you asked.  :)
>>>
>>> This is trying to achieve keeping /proc/<pid>/maps (or similar) somewhat
>>> as informative as pre-DMABUF BAR mmap, in terms of keeping the VMA
>>> vm_offs column useful.  Before this patch, say you mmap() two slices A
>>> and B of the same BAR:
>>>
>>>   struct vfio_region_info bar_region;
>>>
>>>   vm_a = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0);
>>>   vm_b = mmap(0, 0x1000, ..., device_fd, bar_region.offset + 0x4000);
>>>
>>> ...you'd see something like this in /proc/blah/maps:
>>>
>>> fffff4000000-fffff4001000 rw-s 10000000000 00:07 148     /dev/vfio/ 
>>> devices/vfio0
>>> fffff5000000-fffff5001000 rw-s 10000004000 00:07 148     /dev/vfio/ 
>>> devices/vfio0

Looking at this again, I/we got this backwards and I mixed up two things:

The goal of this patch _is already_ to make sure the VMA's vm_pgoff 
(whether viewed in /proc/<pid>/maps or elsewhere) still matches the 
mmap()'s offset.

(For a mo, ignore the resource index encoded into the offset.  Consider 
just the offset into the BAR itself, inside the VFIO_PCI_OFFSET_MASK. 
I'll come back to the index encoded into the upper bits.)

>>> then the VMA's vm_offs would need to be thunked back down to 0 (since
>>> the fault handler then treats vm_b + 0 as the first byte of the DMABUF).
>>> That works/adds up, but then the vm_offs of both VMAs A & B both have
>>> offset 0, and it's harder to differentiate in /proc/blah/maps.
>>
>> Yes, and that would be correct.

Why?  This paragraph was outlining a hypothetical alternative 
implementation that creates the DMABUF the size of the VMA and starting 
from an offset into the BAR based on vm_pgoff, and then compensates by 
setting vma->vm_pgoff = 0 so that the fault doesn't re-apply the offset 
again.  That would make byte 0 of the VMA access correct:

   BAR_start + (vma->vm_pgoff << PAGE_SHIFT)   [1]

But it would...

>> The VMA output of lspci should show the exact pgoff passed to mmap and
>> nothing else. Do not mangle it for "debugging".
 >>>> pgoff is not to be used to show random internal FD details..

...definitely break this property, no?

This patch is supporting that property by instead creating the DMABUF so 
that the VMA's vm_pgoff (which is maintained and the same* as passed 
from mmap()!) indexes the DMABUF so that byte 0 of the VMA accesses the 
same address above in [1].  The DMABUF spans from the start of the BAR 
so the fault handler maths (which indexes the DMABUF by vm_pgoffs) is 
common for all buffers.

  a = mmap(0, 0x10000, ..., device_fd, 0x4000);

          +0           +0x4000
          +------------v------------------------------------------+
          |               BAR                                     |
          |                                                       |
          +------------^------------------------------------------+
          .            .
          .            +--------------------------+
          .            |  VMA                     |
          .            |  vma->vm_pgoff = 4       |
          .            +--------------------------+
          .            .                          .
          +------------+--------------------------+
          | invisible  |  DMABUF                  |
          |            |                          |
          +------------+--------------------------+

Same* externally-observable behaviour as the old mmap().

>>> We could possibly stash the original offset somewhere and then render it
>>> in the name string, but the name's already about the max size and using
>>> the existing vm_offs column is nicer IMO, doesn't need a new field, etc.
>>
>>> I need to work on this comment then!  What this is trying to say is that
>>> the DMABUF is made artificially larger than the part that is visible
>>> through the VMA.
>>
>> Yuk, that's another reason not to do this.
Apart from the yuk part, do we have a specific concern with the 
invisible portion?  Perhaps if one could fish out a DMABUF fd somehow 
(it's a file, but no scalar fd is returned to userspace) then the lower 
BAR addresses could get mmap()ed.  Isn't that at worst as permissive as 
a "closed" VFIO device fd which could get fished out, e.g. 
/proc/<pid>/map_files, and mmap()ed again?

I went through other approaches, but they either need special-casing in 
the fault handler or DMABUF-to-PFN helper, or as above would modify the 
vma->vm_offs.  This seemed best overall though, as ever, open to ideas.


*: Region offset:

OK, so this patch strips out the high bits of the offset early, so 
that's disappeared from /proc/<pid>/maps etc.  You're right to point out 
that the resource index could be carried such that the vma->vm_pgoff 
really is identical throughout.  I'll restore that so that the VMA's 
vm_offs is identical to that passed via mmap().

Does that seem reasonable?


Thanks,


Matt

