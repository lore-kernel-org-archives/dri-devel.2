Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE0C4CD4F4A
	for <dri-devel@archiver.kernel.org>; Mon, 18 May 2026 16:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 04AAD10E110;
	Mon, 18 May 2026 16:55:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="XN8JeS87";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D3C010E110
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 16:55:00 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64I1nN6C1953892
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:55:00 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=ZLY9yfLbRBjpxy+2SZZ2QJ1skamsrrS9MpjOO7Diwus=; b=XN8JeS877jEd
 EB+ZxD27YIsRCiVSeSY3lAZcZeFfFdxQF+qfF4CTddtmCk+K2U3049kfL4nFlmH7
 SL3cBbF1DhT0/mKioDrKiQNuR8X/wF49z9HY/X3ZO25Px96ZXMmw7UGd0yozk487
 BHNo/ja8XUZxE3NcwBWwhA5pmfG/2rItk5Uheyxl/ozsVbHucAmJ+60On9h5ljfT
 gsTgOrcXmoUn6KVcUVg0XrKksIyHrs9ANc/am9s32d/a/zIvHdMsuKPx/fJ1J80A
 0nwLeVfHhVfOp9GSZfmcFsGcbp6H2Lm7tfODKhxJrvgT4pMpk4jYBf7t481ofi8A
 u89jy8cs2A==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4e7a7dxqw2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:54:59 -0700 (PDT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2ef62078ee7so3480961eec.0
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 09:54:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779123299; x=1779728099;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZLY9yfLbRBjpxy+2SZZ2QJ1skamsrrS9MpjOO7Diwus=;
 b=aU5Rbj6J/8edsPob0UCfYJpFxSwS0S4aqUpeu4no161N8bBZlakrC/3hssnORypBKM
 +GEiTIWbZbDIUQKO1WfxSeLCW5aeFFyVAATafAI7uza7m81LzHFlcrjXzJ5SC1X287I7
 VFL2FD1vlMy6LZ5iRT+06w1jxMCT0guhZy2XC7EvyhFxlklA0xRho2AbZ6nU4Y8fah5N
 pTHVWoIUVef/wLRdkBZ8S9VS0Z9yOmuo8F5y7O388UTdjcCYTBZh/2NcvxfNb3PgTsHa
 1i+gtD+uRrfgQG7PdIgI3zqsysXlAWjVupLPMdADAzfT/hSBqDPQVb2fysx2aSb1HWny
 Fung==
X-Forwarded-Encrypted: i=1;
 AFNElJ8axSQlDBdJf49yJTKuswCa5HJmwz031L5cK0QoEYupEM8q//nVRlw4CpPo26VNW8UCI+5tcttLXIk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUu0zHdE8XpEXqbnc2W7X/IzZsG+hjJwb8ixM8AYjJcBYGi9ih
 Uh8Y5sGXsBhZSXyRgObNxdke7hpQd4C7yfumTO8z42NQkChmONWVuWxAqHgBbQ1d0+8yXxnUTF1
 A6wrlPmHrS1BWlMSbxkM9Vj4twhfd8VKZkWX7oC2OSefJckKPdMa5q6iXehNZNJSxFHpZ
X-Gm-Gg: Acq92OE0C4Oj4TSLOqZupGWpqAyl4OfjYjlT8bDapGoeD/U1sJh6z7zb6Er0XaEJH8P
 +b2MSAGQbOchgduwZf6IaqPUmUvaGhv/Al924dZXMs405nvssspzfqcjZJOD9709/PaGhKykWr7
 DVzI9bRwujzKeruF+KhOZJQs35/joM1xhYABWNvIy1RwfeG0uQ53g/QG2un/5FZtvY0ToKXsJgk
 TtC44hnYfWsro4bgL33iGnRVzotdqnNLF8MjNV1kkObDqHbtuTbhWa+r7Gmvwy11oI2VSo096mK
 QlWGHvEn48JxYMX23gZ584wth29V8P6aKjs9YtqVv+WpY6qWMuoIALZUhE1rhu2efWl1eNz3Q74
 dB/bQiaI4/AxAim/xLwmh4DKsoqYBow==
X-Received: by 2002:a05:693c:2c8e:b0:2ee:f85:ec3c with SMTP id
 5a478bee46e88-303986b0490mr6401865eec.30.1779123298672; 
 Mon, 18 May 2026 09:54:58 -0700 (PDT)
X-Received: by 2002:a05:693c:2c8e:b0:2ee:f85:ec3c with SMTP id
 5a478bee46e88-303986b0490mr6401843eec.30.1779123298106; 
 Mon, 18 May 2026 09:54:58 -0700 (PDT)
Received: from [10.0.40.30] ([51.52.155.79]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6adsm15797561eec.15.2026.05.18.09.54.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 May 2026 09:54:57 -0700 (PDT)
Message-ID: <e90b20b7-3189-4395-b2a8-6391b5958936@meta.com>
Date: Mon, 18 May 2026 17:54:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/9] vfio/pci: Clean up BAR zap and revocation
Content-Language: en-GB
To: Leon Romanovsky <leon@kernel.org>, Alex Williamson <alex@shazbot.org>
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
 <20260416131815.2729131-7-mattev@meta.com>
 <20260501171919.42659174@shazbot.org> <20260505105822.GC11063@unreal>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260505105822.GC11063@unreal>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: AR9dMJGEENLZ-OLC-tloPIzbYBC6xvkZ
X-Proofpoint-GUID: AR9dMJGEENLZ-OLC-tloPIzbYBC6xvkZ
X-Authority-Analysis: v=2.4 cv=c+6bhx9l c=1 sm=1 tr=0 ts=6a0b4463 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=2UbFsIa4v//lIgRL4kGwwA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=7x6HtfJdh03M6CCDgxCd:22 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VabnemYjAAAA:8
 a=GEBLkO6eNKYXaKtmIbgA:9 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10
 a=PxkB5W3o20Ba91AHUih5:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDE2NiBTYWx0ZWRfX6WxoK+P/XWQo
 3r+d3EWNDacttLJEWxJIkV2q9hZxJEugI+1IVs1YkikZC7Ri7iuq3cQOxaAyzdSAcLRipeLY7VF
 t9f7Y6pQQtoDLfQE7bl/8X9foX/ZrsUBxKruHCCaNASevL18AumCqC2TYMQlKFuEzDvFpxyaZW5
 J4yPWbA0R1GjSkBKYeNnTmcIblSr9hNjm19ZCjEfV6UBSjHmcGeYCm+PVJEv21PLY5Gy0fT4kF7
 UPZ1SCSxbhc3yZolnlDl9sFUOq77L4EswbMUiRcTG/gWvOH2JX4lpE8bXSRKOI+1/2YfTsiOhDj
 hQp0xWWF3JdF+zYzQFTYqs9KmNhe6AaBHfcKIjxrDMOAR0ATB91IzLxypE0M2T/RJ5xYJn9Iy3N
 Ap4ExCosZlPYSnmSzxkZjj02+UCgPsVmrPudzG6O/soP1jenOiuFUfuEpn7fXDiF8tNa31sWBT/
 nu3dqd72d4GSbuq7jNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-18_01,2025-10-01_01
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

Hi Leon, Alex,

On 05/05/2026 11:58, Leon Romanovsky wrote:
> 
> On Fri, May 01, 2026 at 05:19:19PM -0600, Alex Williamson wrote:
>> On Thu, 16 Apr 2026 06:17:49 -0700
>> Matt Evans <mattev@meta.com> wrote:
>>
>>> Previously, vfio_pci_zap_bars() (and the wrapper
>>> vfio_pci_zap_and_down_write_memory_lock()) calls were paired with
>>> calls of vfio_pci_dma_buf_move().
>>>
>>> This commit replaces them a unified new function,
>>> vfio_pci_zap_revoke_bars() containing both the vfio_pci_dma_buf_move()
>>> and the unmap_mapping_range(), making it harder for callers to omit
>>> one.  It adds a wrapper, vfio_pci_lock_zap_revoke_bars(), which takes
>>> the write memory_lock before zapping, and adds a new
>>> vfio_pci_unrevoke_bars() for the re-enable path.
>>>
>>> However, as of "vfio/pci: Convert BAR mmap() to use a DMABUF" the
>>> unmap_mapping_range() to zap is entirely redundant for plain vfio-pci,
>>> since the DMABUFs used for BAR mappings already zap PTEs when the
>>> vfio_pci_dma_buf_move() occurs.
>>>
>>> One exception remains as a FIXME: in nvgrace-gpu, some BAR VMAs
>>> conditionally use custom vm_ops, which have not moved to be backed by
>>> DMABUFs.  If these BARs are mmap()ed, the vdev enables the existing
>>> behaviour of unmap_mapping_range() for the device fd address space.
>>
>> What's the plan here?  Is this a temporary FIXME or a place to prove
>> that dmabuf for mmap works beyond the core use case?

The larger picture is that I havne't converted the nvgrace-gpu driver to 
use DMABUFs for its custom mmap/fault handler code.  (It's not 
straightforward to test, so I don't want to hack that.)

This FIXME is added to vfio_pci_zap_revoke_bars(), saying that for this 
specific sub-driver (or any others that do custom mmap) they still need 
to flag so that this wrapper still performs the unmap_mapping_range().

>>> Signed-off-by: Matt Evans <mattev@meta.com>
>>> ---
>>>   drivers/vfio/pci/nvgrace-gpu/main.c |  5 +++
>>>   drivers/vfio/pci/vfio_pci_config.c  | 30 ++++++--------
>>>   drivers/vfio/pci/vfio_pci_core.c    | 62 +++++++++++++++++++----------
>>>   drivers/vfio/pci/vfio_pci_priv.h    |  3 +-
>>>   include/linux/vfio_pci_core.h       |  1 +
>>>   5 files changed, 62 insertions(+), 39 deletions(-)
>>>
>> ...
>>> @@ -1229,7 +1228,7 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>>>   	if (!vdev->reset_works)
>>>   		return -EINVAL;
>>>   
>>> -	vfio_pci_zap_and_down_write_memory_lock(vdev);
>>> +	vfio_pci_lock_zap_revoke_bars(vdev);
>>>   
>>>   	/*
>>>   	 * This function can be invoked while the power state is non-D0. If
>>> @@ -1242,10 +1241,9 @@ static int vfio_pci_ioctl_reset(struct vfio_pci_core_device *vdev,
>>>   	 */
>>>   	vfio_pci_set_power_state(vdev, PCI_D0);
>>>   
>>> -	vfio_pci_dma_buf_move(vdev, true);
>>
>> This seems subtle enough to be troublesome.  I wonder if Leon didn't
>> intentionally place the dmabuf revoke after the device is in D0 to
>> allow the driver to interact with the device.
> 
> My intention was to place vfio_pci_dma_buf_move() as close as possible to
> pci_try_reset_function(), so the device is known to be fully operational
> at that point. It looks like calling it after the transition to D0 is the
> right ordering.

Thanks for that, I had missed that need to have D0 at the time of the 
revoke.

Getting the lock in the existing place (before D0 set) but doing a 
separate vfio_zap_revoke_bars() here (replacing the bare move) seems 
right, though for the sub-drivers which still need the zap (nvgace-gpu) 
then the unmap_mapping_range() would happen after the D0 now.  I believe 
this is OK, but I wanted to flag that difference.

Many thanks,


Matt

