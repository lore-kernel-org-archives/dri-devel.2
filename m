Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD26ECD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 21:46:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A30310E5FC;
	Thu, 14 May 2026 21:46:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="uID4L/RT";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2621610E0D2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 17:52:55 +0000 (UTC)
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64EFZDP52341409
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:52:54 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=i7CC6BqBBL9skWarpnUsM1vRDVhAGp/lgIIkSrH6DrI=; b=uID4L/RTFdpM
 ym5kuxwAZGXnMvm5RC/hAqjahIGR4X97DZNauwiy3+2qdGeLwon1A2giOFCwt250
 p2DDOFCJbt9Xw927M+aXcmNFZurvTU6m7SIy/PDM/fiVkf7NqG6TpGzja1cpG9MB
 oTwuC4fhNj9UVZMTydsFMZmhDJ/rrspbDs+/u3Ko5yH+4iTRpMG6q0zdA+yDi3Md
 tcjYwnReCHshyKmsj+AJkYVjYTAYGsJnOGhPIjZevNDHjlHO3kIJTYdOvoyyMEyt
 xMAEBJM041u78SHl6dC35/Cnr/q8/tjegsMQIjHnAXNRAxTU9Av7XNoZtpSdIjkC
 VOZpBcrPXw==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nw295mj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:52:53 -0700 (PDT)
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-44d9ace59efso5514783f8f.1
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 10:52:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778781173; x=1779385973;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i7CC6BqBBL9skWarpnUsM1vRDVhAGp/lgIIkSrH6DrI=;
 b=cPEHMBMuFf/QJqmA7AsAqm0YojVzRbMNPXrHMUPz5nua5E2myy8CBfFOkHhMtn8F0i
 7WC/1P3bWlXfHz7ty+yyZLwQFUzOBXkGiP6Yds7JgDaSJ2MRFH3lgzAaQ4nYoqLgfEz0
 otdn78mi/zVJLJxNLyEcC8SJenpl8N/4xuN0mgKNXbo4GqAcD/A9NWQu0pbvqEv1hPCU
 2/wo7BY4tGJZU89lbcc2kWu3EyGniOq9YBomypP3M5jhbgIt/FCRoxZit3IH6Y5a1s/C
 op146qIcwuSyS5NbHHdyjeB09lbCP7WVDfmKywtiUGUfUc0A2/jAnpjFTYZnCYxPPawp
 sIWA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8nOj9RPJ1PsTj7utlPfrfxWSfvbyjBlv0lB7qfooVXtBbJNljyGvKglSZMp7WSMjv9K2PIi2G8tXQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwyIfLqfAHSvyTcwSLVhWvH7bdmu6qn7EZmj61pF5M2WuleYJ/1
 YBr5r48fmInDnt7vtYiw5bTXSX3NDVd1ba97BFeWmuDV0aDuOEI3rq/Ckp+r6mILiSbfmzrW/p5
 TnybAgDhsKI1Tl0z6Or2kCzx8KuyhcwefG1M7qK+LKcduQSgwrxhly7urJZ6xg9LSpOkG
X-Gm-Gg: Acq92OH+jCOzIXYZCaWMleSn1ntAPGD4HEtlhYb4Zsf0hjY4gyyg3eaGK1QEmNglt02
 C0arcpdRPl9A/jf7LDcQmz9rGDXt85OCwPrC9b/lZQWgfK6LSfALfntb91ldQBC5CeZpRjlV5nk
 MYxcqQexy6ySJFF9li1eJ5eHTJoAWE27d+G8alRWW/nrNYYy1pVBr80oGEGMxYbY6N882oD1wIV
 H5rTeWEQMS1/EPicN0ZVtTsMAjuLUcWTKq67EovVtjhjY3rFR4om5Uswn6hCT3gKgabKUOgNrWM
 FInsa1WV7Xxk5cE8ffcFxmW8SSTjwkYNxSBfj73cxIHN46s60/PvM5zJKDdukpoHWIGkdpw1fvg
 8+HbrGC4kI5gDKlpy1/idKiBtnS1GFWbQv+IR/Cy/UN3heAN5Q/+Hu3CQH2SULArGM1RXNhdefd
 yqOqMyuwets3TuCx2MtrF4jMFwHgPHGH0GKTwMdyYVanSgSu2U9BOTLALmRdtrsqdtENpqzHxY3
 fsiXh6mI/01vWtBtj4jEZs=
X-Received: by 2002:a05:6000:2f87:b0:452:c246:ab7a with SMTP id
 ffacd0b85a97d-45e5c5beb43mr98797f8f.14.1778781172714; 
 Thu, 14 May 2026 10:52:52 -0700 (PDT)
X-Received: by 2002:a05:6000:2f87:b0:452:c246:ab7a with SMTP id
 ffacd0b85a97d-45e5c5beb43mr98748f8f.14.1778781172259; 
 Thu, 14 May 2026 10:52:52 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da15a6449sm7910203f8f.37.2026.05.14.10.52.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 May 2026 10:52:51 -0700 (PDT)
Message-ID: <c2601b9c-9265-43da-9321-66db57446807@meta.com>
Date: Thu, 14 May 2026 18:52:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/9] vfio/pci: Convert BAR mmap() to use a DMABUF
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>,
 Jason Gunthorpe <jgg@nvidia.com>
Cc: Alex Mastro <amastro@fb.com>, =?UTF-8?Q?Christian_K=C3=B6nig?=
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
 <20260416131815.2729131-5-mattev@meta.com>
 <20260501161915.75525c15@shazbot.org> <afhNeYS174EW7RYp@nvidia.com>
 <20260505104911.GB11063@unreal> <20260505085058.74c34290@shazbot.org>
 <20260506053511.GG11063@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260506053511.GG11063@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE0MDE3OSBTYWx0ZWRfX4ZfXI3ZBS9CI
 U0uo2T0pgmZpNpq8Iz7YybOHwLu+lbgikFl3CFvj6hlzZhY+kGq03jalTOAXbzHh5dc4ZsXauni
 aTXrTDCtYscWHzNO4xfJzGyVk/F8TwwHkZ3OUpyea5rlsVXDrbSp2bh4/m5M94GGYnSdkwaijjo
 EojNDuSwzlLuv1/GFrQaWOJ0e5QcXGu4RwE2swv8bSLrFZAjJ8O8aO6gTEqY/zIZSQKAvrsatOC
 5T+9q2qjnW4Felm5HN4XjnEVKCKNQ2+LmGufLke7Y43L+2unwhLnxfXg4xXKLHGEtwni1uTl+hl
 1JMqxWu7RVqx/cCIQlPqC/9qDWBwTCwUifUqAEugc7NkFcA+ZRDgFXAM5IYxqT7rb9NxoLeIJTp
 1TzIJGpOQ0Hjrwp4VC/HAOdqxhZ135h7a4LHIhF86d6NOsMtchOKFfRN8e1x61t1DadaZJ0DCHJ
 2zg/stlSWJeMPimeUdw==
X-Proofpoint-ORIG-GUID: u6tuZx-6Zp-2teu-33heXKnieE8K6A_A
X-Proofpoint-GUID: u6tuZx-6Zp-2teu-33heXKnieE8K6A_A
X-Authority-Analysis: v=2.4 cv=MspiLWae c=1 sm=1 tr=0 ts=6a060bf5 cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=JnKecZnUtZousrUlYMGU:22 a=VwQbUJbxAAAA:8 a=QhZvmJRm3SQzdzbRGmYA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=F7q00xkr9EfWfQvbdVXI:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-14_04,2026-05-13_01,2025-10-01_01
X-Mailman-Approved-At: Thu, 14 May 2026 21:46:51 +0000
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

Hi Leon, Alex, Jason,

On 06/05/2026 06:35, Leon Romanovsky wrote:
> 
> On Tue, May 05, 2026 at 08:50:58AM -0600, Alex Williamson wrote:
>> On Tue, 5 May 2026 13:49:11 +0300
>> Leon Romanovsky <leon@kernel.org> wrote:
>>
>>> On Mon, May 04, 2026 at 04:40:41AM -0300, Jason Gunthorpe wrote:
>>>> On Fri, May 01, 2026 at 04:19:15PM -0600, Alex Williamson wrote:
>>>>    
>>>>> Exporting dma-bufs from vfio-pci is a feature, but mmap of MMIO BARs is
>>>>> a legacy requirement.  That legacy requirement now depends on
>>>>> PCI_P2PDMA, which depends on 64BIT and ZONE_DEVICE.
>>>>
>>>> That should be split up now, Leon missed it when he added the new
>>>> APIs that didn't require ZONE_DEVICE..
>>>
>>> Sorry, what did I miss here?
>>> VFIO_DMABUF is an optional feature and is enabled only when P2P support is
>>> available. It does not affect legacy systems where P2P cannot be enabled.
>>
>> If we look at the long term view of moving exclusively to cdev/iommufd,
>> where VFIO_DMABUF becomes the mechanism for implementing P2P DMA
>> mappings, VFIO_DMABUF may be optional, but it's highly desirable for
>> legacy compatibility.  There's an argument though that providing P2P
>> compatibility on platforms that support PCI_P2PDMA is probably
>> sufficient.
>>
>> However, in providing mmap of dmabufs as a feature, this series is
>> wiring all mmaps through dmabufs and therefore that dependency becomes
>> fundamental to the use of vfio-pci.  Thus the discussion whether the
>> noted config requirements could be lifted.  Thanks,
> 
> Right, there was no need to remove ZONE_DEVICE when I added my code, and I
> left the task of cleaning it out of is_pci_p2pdma_page() for another day.
> Without ZONE_DEVICE, all pages are treated as non‑P2P.
Just checking I'm following the deps correctly...

If we remove the PCI_P2PDMA dependency on ZONE_DEVICE then (without) 
it's present with P2P hard-disabled (as Leon says).  Already 
`is_pci_p2pdma_page() == false` because folio_is_zone_device() is always 
false in that config.

The only dependency this series adds is for pcim_p2pdma_provider() (and 
support).  We can select PCI_P2PDMA for provider purposes (VFIO!) but if 
!ZONE_DEVICE there's no P2P.

Nothing in PCI_P2PDMA depends on 64BIT and that dependency can be 
removed [1].  (ZONE_DEVICE depends on 64BIT.)

That seems a path to VFIO operating unchanged on 32-bit platforms and 
others without ZONE_DEVICE.

(PCI_P2PDMA currently also depends on NEED_SG_DMA_FLAGS, which seems to 
be unnecessary if !ZONE_DEVICE is preventing P2P pages (no 
sg_dma_mark_bus_address() would happen for example), is that right?)


Then VFIO_PCI depends on a subset of PCI_P2PDMA configuation:

"Diet" PCI_P2PDMA_CORE available even when !ZONE_DEVICE:
  - Compatible with 32-bit platforms; doesn't need to depend on 64BIT
  - Returns a provider, which allows VFIO mmap(), DMABUF mmap().
  - Doesn't allow P2P DMA (eg. via DMABUFs).
  - Doesn't need to select NEED_SG_DMA_FLAGS.

"Classic" PCI_P2PDMA depending on ZONE_DEVICE:
  - Behaves as PCI_P2PDMA does today
  - If ZONE_DEVICE then PCI_P2PDMA enabled, which enables VFIO_PCI_DMABUF

Meaning:

32-bit configs (or 64-bit without ZONE_DEVICE):
  - No P2P anyway
  - VFIO mmap() works
  - VFIO_PCI_DMABUF is disabled (no point enabling DMABUF export since it
    can't be used for its original P2P purpose)

64-bit configs that support ZONE_DEVICE:
  - As today, DMABUF P2P, mmap() of BARs via VFIO or DMABUF


Just added PCI_P2PDMA_CORE and (functionally) ~no code changes are 
needed since disabling P2P just falls out of !ZONE_DEVICE.  But most of 
p2pdma.c does nothing in that config (except for pcim_p2pdma_provider() 
and its support) so benefits from some #ifdef to reduce it.  WDYT about 
a pcip2pdma_core.c containing just the provider management?


Thanks,

Matt

[1]:  The drivers/pci/Kconfig's PCI_P2PDMA states:
   # The need for the scatterlist DMA bus address flag means PCI P2PDMA
   # requires 64bit
I think this isn't quite right as AFAICT the flags are usable on 32b 
too, and actually it's ZONE_DEVICE that requires 64bit.
