Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB3ABCD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 07:53:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9FA710ECF9;
	Wed, 13 May 2026 07:53:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="EExxnns3";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 672EB10EBA7
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 17:51:48 +0000 (UTC)
Received: from pps.filterd (m0528007.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CFmXHO2060025
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 10:51:47 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=sf+Rn+/zlE/3t2At5IGAJ+WyeFpgS59mk9gpV5fg5Bg=; b=EExxnns32Xp5
 12a+7JZj4UeiKq2uMxYppv3vd0ZzsVG+jW9paFI2gTQDUpJ3vaSe7cbARrwIEwoZ
 y383o8nxsaU3WmH7xqF6yid/vBMEqlE1f5m15nEqEVIjAn6WwIRPawNhYdsH9wDC
 2ntA1fgLCD9kG5bI6KgfgDbYzqY/t+gGgGI4gjgZUuY7aUaUkfuzpY/Dfe2GXWDB
 hXZqgpCjNQuYIyEiYSUfvrBAaOCuWL5tvv0vnqMrX6RoQja+7tcx/afVV+elfC0M
 PpWIl7ehb364TmuyvB2TuJWqcyb7SkijecRSPc5SDF7Ju4Ee/PXYCRtdMQm8TSwm
 X/JaxiPHfA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e3nvktdp9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 10:51:47 -0700 (PDT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2ba9a744f7dso4703668eec.0
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 10:51:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778608307; x=1779213107;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sf+Rn+/zlE/3t2At5IGAJ+WyeFpgS59mk9gpV5fg5Bg=;
 b=jG5qFdkWqKwcuxL2rjRt1S8BgOI0W3vtyjcx0xn79njtFR3clQdsMt7hHlbyeATd/r
 Uz83zx6bg9+W+VlntOwY7ewpzDx9d+J3iJz9c2L8QDKIcQxbTxOnMaSGRYxi1umRVP07
 NYSXsOakmHpcbqjBSZ0EFny7M9BARYOEt/w69BvxmUjS5fAslobU2UdQYBmNpqbi8X7Y
 LAT0KPxexKyjVhPSWXPn6Ba+2XrjSaF/EUX7oPPr+DnqKMaxVWPsjpC5/7YquV60WXWx
 dvhx3rcNCPxRsJTGFRZb3k4pAB30VOEKJ4D+W8iRbqxgGDD9Ip9e1E34jQYNRfYBFSfn
 mWuw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8IIkW1kYPzqHba2oCCqoLxYSqN2OcoEVGUo5gYObOLcaE590SRI2QTM9IpzBczJLBYBa9jr+oEbkU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwCsoUdTkbjT0jxNwM7qc0aXFBFjQChu67QEAdsZiaNd0xzuUfV
 CbsXVnTGkBwqqXzmNPZlvDffj0bmHqCaDQBangXA/qEgj8TIapeJtnWZW0rp5n6BHh5n61sCXZh
 1+xwXz8X+Mwos+L05LM1toCaszDAMfDVHih6/413cumsbA3nZ+56pWaQeIoqN/rBYCE7Z
X-Gm-Gg: Acq92OFZXqs3gNr1wNONU2iE6gl8EgBvUE7pqxHvbeuM7u7+Ui/+bgEz6GDPd4kzhuK
 /DU1XEcvV6qhAFk5PJoWRLXQBGax5LCy1+OglGYRl8Fym9v8xckgKwAdFmLsoj6MbS2wuHOTS4i
 YfYZhwMBeV0JZ0xy8gwzK8VqhnF9IMHDV1paI0qDXz2okDhwQXXjLqoQYzbcSMRM/CBMZAnsJDv
 bFWI5ISpP/HAYEGUcAUpIgU74NDzRvFg8Osp+RT4VKeZlwLFU8mbQtI000NO6u0zBiF/3DsfGVa
 PFdUWqXyAUxG+X1KZU4XMxF9Mu6YZ6pbETh9mRq2BxQLLH4XRwhFWJRjUzmOR7wACnaxdVsxc+0
 6v4UcKDurguSRiUodN/ha6inO
X-Received: by 2002:a05:7300:ed85:b0:2f8:1f2b:bb5d with SMTP id
 5a478bee46e88-30119f6d66dmr42254eec.25.1778608306631; 
 Tue, 12 May 2026 10:51:46 -0700 (PDT)
X-Received: by 2002:a05:7300:ed85:b0:2f8:1f2b:bb5d with SMTP id
 5a478bee46e88-30119f6d66dmr42218eec.25.1778608306019; 
 Tue, 12 May 2026 10:51:46 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859e8389sm18884568eec.3.2026.05.12.10.51.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 10:51:45 -0700 (PDT)
Message-ID: <4af0c788-22cc-4fb1-9276-ab35439fb7c8@meta.com>
Date: Tue, 12 May 2026 18:51:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] vfio/pci: Add mmap() attributes to DMABUF feature
Content-Language: en-GB
To: Alex Williamson <alex@shazbot.org>
Cc: Leon Romanovsky <leon@kernel.org>, Jason Gunthorpe <jgg@nvidia.com>,
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
 <20260416131815.2729131-10-mattev@meta.com>
 <20260424183153.GJ3444440@nvidia.com> <20260426105215.GA440345@unreal>
 <20260427083644.4ee174cd@shazbot.org>
 <25a4fc45-1b4d-426b-954a-60bf21e9040f@meta.com>
 <20260511140957.25eb5d9d@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260511140957.25eb5d9d@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4NiBTYWx0ZWRfX1RiBCfMDfoa4
 1GdwwXedXu8N1SrYz02acrcHd3FFzcbWQr9tloXBWY1JmHHzctcKFiye2NFDXbM6vWIlti20TK2
 cNQv66mKJD91SroPEk7Dzculem+G3ZvG/pZY5puSyokpRsXTzA3JXT+4p7OTI1o4jVOMpZItYwC
 IttPd52V6E3YFiRTV7hepfoXe8RErnovVb8TQ1sYuNieG82k2+ntiYmh29QcG2vSxmISwwpg65o
 PQmaPIZxk5P5sHTHZg1PrOen5XulfKBPyfmyaKI4OibWM+x2tvovByXoxUbco4bF0HYW+1MApia
 eC0M4Ejp1cx3lPDc/GLjZKOeYDC84nEFSm8pIVisdVXin9Miwo6wkIvm3OPI8YPw4FjFSgiv1v8
 aixwH+JxiKrDd3rQYigPEn1a8r+vIbA5OoYdc/DwJhGNQIuOmA1wfaxhMrcyghRSlHSao06Rf7p
 SVj+tbq+L4Sq92jAXqw==
X-Proofpoint-GUID: G8R4VATeMeHxesVcUqvs3gNDFe8rhAZy
X-Authority-Analysis: v=2.4 cv=MZ1cfZ/f c=1 sm=1 tr=0 ts=6a0368b3 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=4h92JMTCafKA-fb_NiOh:22 a=VwQbUJbxAAAA:8
 a=r1p2_3pzAAAA:8 a=VabnemYjAAAA:8 a=Ikd4Dj_1AAAA:8 a=h_Mwey2iunVtOOa4NVUA:9
 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22 a=r_pkcD-q9-ctt7trBg_g:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: G8R4VATeMeHxesVcUqvs3gNDFe8rhAZy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
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

Hi Alex,

On 11/05/2026 21:09, Alex Williamson wrote:
> 
> On Mon, 11 May 2026 16:30:39 +0100
> Matt Evans <mattev@meta.com> wrote:
> 
>> Hi Alex, Leon,
>>
>> On 27/04/2026 15:36, Alex Williamson wrote:
>>>
>>> On Sun, 26 Apr 2026 13:52:15 +0300
>>> Leon Romanovsky <leon@kernel.org> wrote:
>>>    
>>>> On Fri, Apr 24, 2026 at 03:31:53PM -0300, Jason Gunthorpe wrote:
>>>>> On Thu, Apr 16, 2026 at 06:17:52AM -0700, Matt Evans wrote:
>>>>>> A new field is reserved in vfio_device_feature_dma_buf.flags to
>>>>>> request CPU-facing memory type attributes for mmap()s of the buffer.
>>>>>> Add a flag VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC, which results in WC
>>>>>> PTEs for the DMABUF's BAR region.
>>>>>>
>>>>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>>>>> ---
>>>>>>    drivers/vfio/pci/vfio_pci_dmabuf.c | 15 +++++++++++++--
>>>>>>    drivers/vfio/pci/vfio_pci_priv.h   |  1 +
>>>>>>    include/uapi/linux/vfio.h          | 12 +++++++++---
>>>>>>    3 files changed, 23 insertions(+), 5 deletions(-)
>>>>>
>>>>> Nice and simple
>>>>>
>>>>> Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
>>>>>       
>>>>>> @@ -1549,8 +1551,12 @@ struct vfio_region_dma_range {
>>>>>>    struct vfio_device_feature_dma_buf {
>>>>>>    	__u32	region_index;
>>>>>>    	__u32	open_flags;
>>>>>> -	__u32   flags;
>>>>>> -	__u32   nr_ranges;
>>>>>> +	__u32	flags;
>>>>>> +	/* Flags sub-field reserved for attribute enum */
>>>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_MASK		(0xfU << 28)
>>>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_UC		(0 << 28)
>>>>>> +#define VFIO_DEVICE_FEATURE_DMA_BUF_ATTR_WC		(1 << 28)
>>>>>> +	__u32	nr_ranges;
>>>>
>>>> Alex,
>>>>
>>>> The TPH proposal extends the flags field in a similar way, but I suggested
>>>> a different approach to conserve bits. At the moment, we spend three bits
>>>> on a single feature, which feels wasteful.
>>>>
>>>> What do you think?
>>>> https://lore.kernel.org/all/20260409120415.GF86584@unreal/
>>>
>>> I already proposed a very different interface for TPH that decouples
>>> the dma-buf creation from setting the TPH values:
>>>
>>> https://lore.kernel.org/all/20260423132016.4a25e074@shazbot.org/
>>>
>>> This is overall less intrusive than the TPH change proposed, but it
>>> could still make sense to align this as an operation on the dma-buf,
>>> that can be probed as a separate feature.  Thanks,
>>
>> I'll add a VFIO_DEVICE_FEATURE_DMA_BUF_ATTRS in a v2 instead to get in
>> line with the TPH work, no worries.
>>
>> For the benefit of future hackers, how would you describe the criteria
>> for adding flags to this existing field?  What hypothetical feature
>> characteristics would be appropriate?  (Maybe it's that these attrs &
>> TPH add scalar fields in several bits rather than a simple boolean.)
>> Two of us have independently added something that's turned out to be
>> inapproriate so some guidance would be good.
> 
> I think the question of how we actually expand an arbitrary grab bag of
> "ATTRS" is the central question in whether we should implement the
> interface. 

> If we follow the direction I suggested for TPH, maybe this
> is just a VFIO_DEVICE_FEATURE_DMA_BUF_WC, where it supports only PROBE
> and SET, with SET taking only the dma-buf fd to implement the one-way
> promotion from UC -> WC.
> 
> If we support a generic SET ATTRS feature, we really need to map out how
> flag bits are indicated as supported and how a user untangles failures
> from trying to set various attributes.  If we end up with a feature
> indicating each ATTR is available, we might as well have just
> implemented a feature for each attribute.  Thanks,

Agreed, that's key.  Alhough, the aim of this patch is for attrs to be a 
memory type enum rather than a bag of possibly-concurrent and 
possibly-conflicting boolean flags.  Maybe 'memory attributes' would be 
a better feature name.

I'm not sure about the feature-per-attribute.  Say we do a 
VFIO_DEVICE_FEATURE_DMA_BUF_WC and then later support a second, 
VFIO_DEVICE_FEATURE_DMA_BUF_UC_WEAK (like, say, Arm Device-nGRE).  Then 
we have to specify that these two VFIO feature types actually 
interact/override somehow.  I doubt we'll end up with a dozen but it's a 
bit tiresome having a few features that interact.

At least if it's a single DMA_BUF_MEMATTR feature taking an enum, we 
just encode the N different (mutually-exclusive!) valid states and done. 
  I don't feel having a new feature for each keeps things simpler.

Discovery of support for a specific future attribute is OK with a single 
ATTR too; we can take an enum attribute argument to a GET and -ENOTSUPP 
for any we don't like.

(We could also add orthogonal DMABUF flags (can't think of a good 
example...) but I'd suggest _those_ as semantically-grouped different 
features, with the same issues of specifying conflicting cases versus 
existing features.)


Cheers,


Matt

