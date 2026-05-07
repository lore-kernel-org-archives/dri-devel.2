Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8081CD342F
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 07:55:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7D7D810F3B6;
	Fri,  8 May 2026 07:55:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="Qg6qXUNE";
	dkim-atps=neutral
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com
 [67.231.145.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD9BF10F7E0
 for <dri-devel@lists.freedesktop.org>; Thu,  7 May 2026 17:17:57 +0000 (UTC)
Received: from pps.filterd (m0044012.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646NEqf62142025
 for <dri-devel@lists.freedesktop.org>; Thu, 7 May 2026 10:17:57 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=2hseHusJHq4MxssvE9ph720WJzKkL0PdIQg2ntbbJzc=; b=Qg6qXUNE89L6
 +1ES/JHEoLIWulvpYZjGL9eLFRE+al8XgZoQ8YL/vXchbQbFrgU8ECcnx8vgaMhB
 GTxqwgWBviFZw2PcYYNaT1rfZofblWJNgGXEXTjDIybxE43ZtWQSvsNvmlX7vFO/
 0go7Uor9MuOCWiXaIbGZ2PKGWUYx60XssWozr1TyEmBZvoY/X8vkn1lSceRGZPfQ
 Su8oMk6xG+FtN054DdH+1h2blHvZqaHvayI8GoSnX83+ToBjab/+284lAwtmgqEG
 07naHNI1aSQw11PSjpb1QTqodKmpaVbNohVKeOsctRjkWzSfSxiMMguFRx/xw9th
 HExpZMTmKg==
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dwey09e6s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 10:17:57 -0700 (PDT)
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-43efc93e4f6so763768f8f.3
 for <dri-devel@lists.freedesktop.org>; Thu, 07 May 2026 10:17:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778174275; x=1778779075;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2hseHusJHq4MxssvE9ph720WJzKkL0PdIQg2ntbbJzc=;
 b=r5T3z51vMNkoG8HjZdf6C2IUJhwPuMOP4ZImhQWHUDBlMHZvKVrwA2w6hNU3N4dXla
 o+J5Hcl1A19TVQKHOzB4ocz0CAbOtxeIOXHsWJEd9tcS7vg6QNtYhPpIL7hjc3IB9JDL
 V/Cg37wO5urpNwUN1EYbJF7YkQ7pp2QpljvEKicAj7tUisPZLfUP7KjbAiRprSYEO9A+
 yoD1nKLzQvQojZOpv/wzKVp7zgJ4XsGujRH/byaXFikc+WIvfNZjrBckIVK+ZETShfBp
 btJl3PUvzMzCH0Dspl7icvfbsszXEUSgIIx2ueABiBBHGYIkmevY66FZ8Fc2GUeKWkaN
 0tCQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9skI9bxrk6hT87QMiFwMjZt90XpCuush8HX0UJHezrgV8nq1MRC8cCI4QJl0LghxU8UZmjYZIvoRs=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyF5BsECv6q7L4KkqaIG4JQphtMxWAE+HYOx96NEL08GTI68r5f
 YxF9oAI57RJvO5TTkjWF3wgKIM+4VGAYNDwH647k6U9Ti24z0XfyqdLPmN+t3WQbU8+QcKrFgGz
 QTq+0N+gte0HEeVdwng0GcvL+Il13ms0cHIPWX3g9fLYx+keaGZneN2YCOLI1jZlisPA5
X-Gm-Gg: Acq92OGsoh40NDmaHcg1PnCDZfqlfnKKSGl93OSXucXNQyAr5WJ1rer02Vxts7uB5I6
 V/CLqsLUin7VFvRfiYbgHTr1ftFFNyExfHcQVrMHEJqQzCghYgqz7pqiJe5wlvfVenqqjVW6eEm
 Q95J2g0s3APcnefgal2EJrKJaSBpqNXDZQATbFFyTEG8d0aZkLyEyK7NEXz7hlAXPaAJgh1CUwe
 JuUnRtB/jnt39Gm6PYi7yinRImr3oQQpkO1YEBV+F/5X6fviS+M2mZIeljlUA10CKoH40haTSFn
 +Ubv0LudPz1JdmifIKLNnDkMp6pPHnMyfvG4xxO/r26b9gcMULTUxZSsx2Bu0MFUKlYnTDn1qVf
 5WvaS+BxEnLMH4KpNmbT6gh9oCUooMLQFN68VGgMLuVD1avb9BxoXDO4WySv6iMLIuuHTN4ACEv
 s/1J4yWPFB8bAsOvnHal2pv26VqxoWKAfIPEJDZ9RTIuGB8GJaU6xlUtwpst64xvnMCCHVSrQ8z
 cUYC7C6iBKMbNK5doI2c1Ihcx3ijJ26Pg==
X-Received: by 2002:a05:6000:2903:b0:43d:242:b9bb with SMTP id
 ffacd0b85a97d-4515b9f322fmr14370571f8f.18.1778174275493; 
 Thu, 07 May 2026 10:17:55 -0700 (PDT)
X-Received: by 2002:a05:6000:2903:b0:43d:242:b9bb with SMTP id
 ffacd0b85a97d-4515b9f322fmr14370521f8f.18.1778174275013; 
 Thu, 07 May 2026 10:17:55 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4541282046esm408713f8f.8.2026.05.07.10.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 10:17:54 -0700 (PDT)
Message-ID: <afd17112-5d59-4a68-88ac-903616ed7dfd@meta.com>
Date: Thu, 7 May 2026 18:17:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] vfio/pci: Provide a user-facing name for BAR mappings
From: Matt Evans <mattev@meta.com>
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
 <7d370a5d-3730-42f0-8656-14ad9c0da682@meta.com>
Content-Language: en-GB
In-Reply-To: <7d370a5d-3730-42f0-8656-14ad9c0da682@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: GlYrICvgVa_0eXIxP517QiYmKsx5IFzw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDE3MyBTYWx0ZWRfX4VdhmJCYNasj
 dmOyKVr6JprrIqVm9RCLEKT66ehrEyucu6ymtYhXB1XcCX4NgQlgfwbsIpkdI1HJ25xUn3+8bEQ
 KUdluK4hsevYZByhi7HqnLTY2LhqCJayuTfBbbEyPGHaKcTIEmBxoBD9pKFS1QWA/dbQveS2a8k
 EOCjX/gMRxHUw85Iew2MeJu0d4UMsce1dKJxPGvEux8Vqa0/OutqnneBBpfCn7EOiCBJOY5sVQp
 r5oqETk5nn35mB0qIMjubpYSzirD/nd8R+wurYKUj4wDMo6GtIQ/nWDJuvzq7wvW7pH101HYyNO
 acFda8rVoMEz4DaGCfC67thk8m7UBpJroNwd+4o97/zT1DcAGQt7QKz9kiRP28mPDMlIuy/mH/s
 vKjrkpjKD/YJ3QfDoul5jJoswupHGnWxEbX9I/JVrjfSykb4O7Zdhm9CLfqjpSG2w7L1o5uoM/9
 JvN86cmCr9OTEakWKww==
X-Proofpoint-ORIG-GUID: GlYrICvgVa_0eXIxP517QiYmKsx5IFzw
X-Authority-Analysis: v=2.4 cv=Zcwt8MVA c=1 sm=1 tr=0 ts=69fcc945 cx=c_pps
 a=CsXZvLRfiTx/ye2xXAwb9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=PAz_-FQ8hEVmOPYdF0yf:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=gEb6E3g4VIbv0AVgNvMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=F7q00xkr9EfWfQvbdVXI:22 a=gKebqoRLp9LExxC7YDUY:22
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

Sent too soon, :|

On 07/05/2026 17:56, Matt Evans wrote:
> Hi Alex,
> 
> On 01/05/2026 23:44, Alex Williamson wrote:
>>
>> On Thu, 16 Apr 2026 06:17:48 -0700
>> Matt Evans <mattev@meta.com> wrote:
>>
>>> Since converting BAR mmap()s to using DMABUFs, we lose the original
>>> device path in /proc/<pid>/maps, lsof, etc.  Generate a debug-oriented
>>> synthetic 'filename' based on the cdev, plus BDF, plus resource index.
>>>
>>> This applies only to BAR mappings via the VFIO device fd, as
>>> explicitly-exported DMABUFs are named by userspace via the
>>> DMA_BUF_SET_NAME ioctl.
>>>
>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>> ---
>>>   drivers/vfio/pci/vfio_pci_dmabuf.c | 27 +++++++++++++++++++++++++--
>>>   1 file changed, 25 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/ 
>>> vfio_pci_dmabuf.c
>>> index a12432825e5e..04c7733fe712 100644
>>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>>> @@ -4,6 +4,7 @@
>>>   #include <linux/dma-buf-mapping.h>
>>>   #include <linux/pci-p2pdma.h>
>>>   #include <linux/dma-resv.h>
>>> +#include <uapi/linux/dma-buf.h>
>>>   #include "vfio_pci_priv.h"
>>> @@ -467,6 +468,7 @@ int vfio_pci_core_mmap_prep_dmabuf(struct 
>>> vfio_pci_core_device *vdev,
>>>   {
>>>       struct vfio_pci_dma_buf *priv;
>>>       const unsigned int nr_ranges = 1;
>>> +    char *bufname;
>>>       int ret;
>>>       priv = kzalloc_obj(*priv);
>>> @@ -479,6 +481,20 @@ int vfio_pci_core_mmap_prep_dmabuf(struct 
>>> vfio_pci_core_device *vdev,
>>>           goto err_free_priv;
>>>       }
>>> +    bufname = kzalloc(DMA_BUF_NAME_LEN, GFP_KERNEL);
>>> +    if (!bufname) {
>>> +        ret = -ENOMEM;
>>> +        goto err_free_phys;
>>> +    }
>>> +
>>> +    /*
>>> +     * Maximum size of the friendly debug name is
>>> +     * vfio1234567890:ffff:ff:3f.7-9 = 30, which fits within
>>> +     * DMA_BUF_NAME_LEN.
>>> +     */
>>> +    snprintf(bufname, DMA_BUF_NAME_LEN, "%s:%s/%x",
>>> +         dev_name(&vdev->vdev.device), pci_name(vdev->pdev), 
>>> res_index);
>>
>> Comment suggests 9 is the max res_index that can be printed, but mmap
>> only directly supports standard BARs 0-5.  Comment also uses a '-'
>> while the code uses a '/'.  Thanks,
> 
> Right you are.  Fixed, but, since...
> https://lore.kernel.org/kvm/52162da4-e1cc-4f90-a95a-218d6089cd71@meta.com/
> 
> ...I'm keeping the resource index encoded in the vm_pgoffs and as that's
> in /proc/<pid>/maps it doesn't need to be in the name. I.e., an example
> mapping of BAR 2 looks like:
> 
> ffffa9330000-ffffad300000 rw-s 20000030000 00:0b 12 / 
> dmabuf:vfio0:0000:00:03.0

BUT, the name's visible via paths other than just /proc/<pid>/maps, e.g.
/sys/kernel/debug/dma_buf/bufinfo or /proc/<pid>/map_files which don't 
have the vm_offs, and so back to plan A.  Just made the comment consistent.

Matt
