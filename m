Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EE1ECD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:55:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2A88710F3BE;
	Fri,  8 May 2026 07:55:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="qL/Obi5d";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8EDB10E598
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 16:56:15 +0000 (UTC)
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646LQtSf1018365
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 09:56:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=AStKs7gIf+H7qi7ZzQdIOFiCgW57yK3MpNAkRUF2is0=; b=qL/Obi5dvBwt
 i9c2sv9SNtqXpLw63YE0iVFyLwL6b4BaMhACgc6cvxDCuo+iXEgY5AqcK8DYXOfG
 Oy2Cy3R2kU+21KVGKEdcKnO+JORfiteK8SES7tlFIxyrNJzXgNQnK5HgJvFp3gp9
 ZnR3EfXRenjXlRDNZApwgtgRy4IabZdUKVivNibPvjxRcMi9IvB0Db0W3LQCsLet
 oDdCWe82S8Q9Od6e/B0LJxAkBUtfBo3NK8J9ZB1phV+Om3BTlNLhHQh4kwQdPjrt
 Yeq/XkO+njD2M7PWY6DdNkD4qHPoIjFPhOFiwolRaAFuyZWZzKXpW4t5P5TGgTnF
 1qzC6F8MXg==
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwec799v4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:56:15 -0700 (PDT)
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-48d104d1d8aso5959145e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 09:56:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778172973; x=1778777773;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AStKs7gIf+H7qi7ZzQdIOFiCgW57yK3MpNAkRUF2is0=;
 b=LdY9bkbuotvcu+gmqjDqH4C2twHgtGDwQfS9neeHZS4Bdi2tg78/Zz2LH8DkzFLDUR
 ce/vcW/DYrBkg4R/vqifKnXf0fLxq6CDGZVRLRhJSUYc+0s7/WIZmaipgq87e1aUria/
 pFXsepR9fxsM0Hf2LTGeH1Vqt5cHIFnUz03kKVuNmfXyV0zGNOKAnOpPLibJ5J+rwoo6
 dPYud47ZZoCuyyVoPqwl5UnliDDIX0n0SCbpV270h2Q9prXuuY4VjWkUT/z4O/tzprVk
 nOsVJLFyLcsrN6jVfA5zfa5LwgxmIi43so+SUwq274wmAn9Q63tS2yDG06KuZE8jxh/T
 VcYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+mlZHvYKyYR6uvfRW6juYge8Fv0wQuaHbNPqjqIC2FZp35hmIn4Nfl3i0YK54fSJWIAlyV71+0EL8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxhk762Tmmx0kLeOirykDwzWxOVyRBwyTBHLDcmwCuoELpTAAdo
 XkU/Hdtwdx3Ftq3vcOTlmyQ5yR16Zqq8hpgjRpZHV9SGdq/IZoIWaTko5fLedMz6ZlKjtaC0sbB
 amx/AbXe8AeFlNx6GRL2jI2fuKjWsD55Ik6jMIEB5LGVxLwC20Ucu0akdgwBuib/JEP61
X-Gm-Gg: AeBDiev+2LT56CpUGVNlgIx76j4fBCFWOtYyCHWwDi24cezQgVWnbrNGrO/0wdr+XpH
 DQX4Rbt6xX8vfwSrcRv/T8MN1qwA1hhNPLC2im7/HJ0NAhf7mhEpndSKgjNi30yxgadaq8qZNnn
 y9isX//slZKTgO39pCLMyOlanFstKe0rXPYg3QG6ReFmJFuqVfooMOstbpj2J1ow+51nxUjSqju
 WLtbO5RksuN4zGZHUbg+pR8+q3hrU5ZGr3pgGsUevvP3lOwt6oCIC7z3WHXeNst+szn4+Xz+jY+
 1D7a0PKIZ5iuqtph+U9ZVIsWB2CkE5P/m3JF069kVVjpwO4D+BQN1xpEr2a7PypsuMm4gQOB0ic
 XEhkMMd4UXDyEFm9uyj46ywbsv8ejuvnzUo9NVtoLXb7sHhBBmO3bRi/4lWQmYX3HITHxCM0Y6p
 LG0bZmQueQqI9WnLyEZqIWLWHPW0uR/x1V0LizcdnII5WFkic6LC9E9DzE52V0qdHKKIqrqJ6d0
 TX2MyrUE4h7iDT13y8cDOY=
X-Received: by 2002:a05:600c:4e0c:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48e51e16e58mr154922995e9.9.1778172973430; 
 Thu, 07 May 2026 09:56:13 -0700 (PDT)
X-Received: by 2002:a05:600c:4e0c:b0:48a:55d8:7882 with SMTP id
 5b1f17b1804b1-48e51e16e58mr154922585e9.9.1778172973017; 
 Thu, 07 May 2026 09:56:13 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e642f8d32sm369175e9.25.2026.05.07.09.56.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 09:56:12 -0700 (PDT)
Message-ID: <7d370a5d-3730-42f0-8656-14ad9c0da682@meta.com>
Date: Thu, 7 May 2026 17:56:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] vfio/pci: Provide a user-facing name for BAR mappings
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
 <20260416131815.2729131-6-mattev@meta.com>
 <20260501164430.5d3ea683@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260501164430.5d3ea683@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Vc3H+lp9 c=1 sm=1 tr=0 ts=69fcc42f cx=c_pps
 a=Ech0Gv1thIkdqUNjVc2Ehg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=03ozwUkBphtHgyqjj1sw:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=L20xLjZDwgROH_O_AugA:9 a=QEXdDO2ut3YA:10 a=cZgK7WzY9ta9U-6s7oqD:22
 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: guIV4H4g5GNZ47VAG1ub2Zs5xHWvG0dQ
X-Proofpoint-ORIG-GUID: guIV4H4g5GNZ47VAG1ub2Zs5xHWvG0dQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3MCBTYWx0ZWRfX1NoCpjnMywIY
 lBF0GMf1SAbxA8AyJFTuguzvpG+83Cp2l9c+Tk+fKVqDBi7moLJnnuZrA4O+rrOZd+F/2T7A2Kp
 gNbRJSkvyDiIi2nyp0sn6x1afLVa0kbmPxCVfYxA3Q6Ad0KuvnFuFr/1Lc+AleuM8RDCmBymPI/
 kBxLlvXHE8ITg/7i9K/aDFiClK5TUondEuh4/aqC+rL+euaD+9B4l/l5Kl5ijrLeSxUjfxwSB/2
 Y6If5DWJB0xQCn1YI6vfjNuXfgBTJknkKWsrkqszpg7EKRgKD2fnQnCPiiljc5T4/IIAp7DQbFs
 ITKmfQlQZYPIvI2NOvEiTrmvi/eDslBM5XEbV/WW52UCaKsHH6JJWIFMo1dTtusQUUcUE7Q9VCE
 jzMPbClAkdSyQmGhHIAkfJ/yGDWTOgYclEMLrzOx23+JVvFhHtApBcaxWCvPCq+EAXsm4byCsqt
 vr0qviZeYJl4yBrkBmA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Mailman-Approved-At: Fri, 08 May 2026 07:55:51 +0000
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

On 01/05/2026 23:44, Alex Williamson wrote:
> 
> On Thu, 16 Apr 2026 06:17:48 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> Since converting BAR mmap()s to using DMABUFs, we lose the original
>> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
>> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
>>
>> This applies only to BAR mappings via the VFIO device fd, as
>> explicitly-exported DMABUFs are named by userspace via the
>> DMA_BUF_SET_NAME ioctl.
>>
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 27 +++++++++++++++++++++++++--
>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index a12432825e5e..04c7733fe712 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -4,6 +4,7 @@
>>   #include <linux/dma-buf-mapping.h>
>>   #include <linux/pci-p2pdma.h>
>>   #include <linux/dma-resv.h>
>> +#include <uapi/linux/dma-buf.h>
>>   
>>   #include "vfio_pci_priv.h"
>>   
>> @@ -467,6 +468,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>   {
>>   	struct vfio_pci_dma_buf *priv;
>>   	const unsigned int nr_ranges = 1;
>> +	char *bufname;
>>   	int ret;
>>   
>>   	priv = kzalloc_obj(*priv);
>> @@ -479,6 +481,20 @@ int vfio_pci_core_mmap_prep_dmabuf(struct vfio_pci_core_device *vdev,
>>   		goto err_free_priv;
>>   	}
>>   
>> +	bufname = kzalloc(DMA_BUF_NAME_LEN, GFP_KERNEL);
>> +	if (!bufname) {
>> +		ret = -ENOMEM;
>> +		goto err_free_phys;
>> +	}
>> +
>> +	/*
>> +	 * Maximum size of the friendly debug name is
>> +	 * vfio1234567890:ffff:ff:3f.7-9 = 30, which fits within
>> +	 * DMA_BUF_NAME_LEN.
>> +	 */
>> +	snprintf(bufname, DMA_BUF_NAME_LEN, "%s:%s/%x",
>> +		 dev_name(&vdev->vdev.device), pci_name(vdev->pdev), res_index);
> 
> Comment suggests 9 is the max res_index that can be printed, but mmap
> only directly supports standard BARs 0-5.  Comment also uses a '-'
> while the code uses a '/'.  Thanks,

Right you are.  Fixed, but, since...
https://lore.kernel.org/kvm/52162da4-e1cc-4f90-a95a-218d6089cd71@meta.com/

...I'm keeping the resource index encoded in the vm_pgoffs and as that's
in /proc/<pid>/maps it doesn't need to be in the name. I.e., an example
mapping of BAR 2 looks like:

ffffa9330000-ffffad300000 rw-s 20000030000 00:0b 12 /dmabuf:vfio0:0000:00:03.0

Thanks,

Matt
