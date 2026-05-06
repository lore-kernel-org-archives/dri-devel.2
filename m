Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BFFFCD3427
	for <dri-devel@archiver.kernel.org>; Thu,  7 May 2026 10:13:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7231410F088;
	Thu,  7 May 2026 10:13:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=meta.com header.i=@meta.com header.b="gW3xmhO/";
	dkim-atps=neutral
Received: from mx0b-00082601.pphosted.com (mx0b-00082601.pphosted.com
 [67.231.153.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 011A010E9D1
 for <dri-devel@lists.freedesktop.org>; Wed,  6 May 2026 13:53:36 +0000 (UTC)
Received: from pps.filterd (m0528004.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 646ACgrS2628813
 for <dri-devel@lists.freedesktop.org>; Wed, 6 May 2026 06:53:36 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=s2048-2025-q2;
 bh=Wr10VTJN3duBxSrKADAl6R/6nUDyzwk22GvJwJKGKOw=; b=gW3xmhO/sRQz
 XJqsiB30MPqABfSYdPyLP0Gn/OezmfyWpq/Qzqjhz2ze7SQRMEXSQHa99g+b7Iir
 gFzVLc2FOh5mAKnK8IvSBVns4QA0YXbcRl87u0f1pieyGY90bP6vERpbS+L7g+P9
 DHCWf4PcInhjkxO+Gm7vkvPJ6GVW5B0TpH8Jp8xFidA4r6Hlogd/JJy3L8saGMRk
 15ap4MCtUXuicSVe2/hcNksNiN8B1EbtQCmsjgszWsFwGMWCoArp5Upp87gHiWGn
 78NOQtEVTH4koE76G93+00BqHzW9i4PIfjFdjf47b5lVOIeDazmu1SVOr2EArvRI
 msxzNEBCAw==
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4dx2wdvq1d-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 06:53:35 -0700 (PDT)
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-67c414217ccso4390469a12.3
 for <dri-devel@lists.freedesktop.org>; Wed, 06 May 2026 06:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778075614; x=1778680414;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Wr10VTJN3duBxSrKADAl6R/6nUDyzwk22GvJwJKGKOw=;
 b=n1CGiPxftOTKe/0Ifpf2KLV97MPrNj+6lYmpFzjnefNfIsPR5K/QJBlH+EDJl8zMNe
 3JFOzzupSzHE1b7Dn7PDFPtCTt3pMZKquFwyBZBjBKsm13H+MklaQlei3oUdR/7r6il1
 clLf9dKRe1Gak/Uv24iB6aKHO+Xk3hevVZEXJ8DFfjMupPqWi9mOSJBYxLGJddZGWW3Q
 P8ahJm7mbrdFhfeU9BimtdIbiPbwGwc8ZbInCJW4xJzofmJv+4oGbF/kdUAQVwlRCxnR
 fAsC+QrRJkXqnoecSACUo+/LohEsUyecANK03ecKzxhFTrITdFVWdoCP+88xiNSFM1Dv
 DHDw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9jlQ/KIqkGZB8MppwLsCzdVrhrmpIPWIct3R2OWYj7b9dllO2arDbEo3W3CqvxZrilmt1/oRVqH/E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwMJUE/ewdILKRiaDkdbonOFd+HcS5pKRWjYL9fZLS5EnX5xtG6
 fv4bPK1LYj/tn22US/bYHwm3R1v9nlkvzQNlDAvbbmkgKyg235K18EStKNS9Trogye7xhR+tAks
 mjuyq9L/lcvxaxINTbxyyWF4kl0roAmgWhv+7cAyMBqECtMIWxsYeUyuIXzpRNRda01JW
X-Gm-Gg: AeBDieuRBl66rvyXwMlYkoYxAoOoGoAipsnI+7MnRQDaFrTwP1egLofc+ITFkYF1whF
 FXRvdV4wV9kKGqWdKWSXJQUh2IS82AqDrd37G3B/mlHxdGz9Fsp2HTEyTuJJ7Cqxk4Kv+1mM/EQ
 g0xOoPy+V+V2UGWJfz2XbcCv7Pc60VOnAG6FhRjee2tv+UaXdO02LmRdalQgbXKpI8958pZ/XhZ
 4gRDPbDBk2wnTfs72Ma11Pa3B9k4DMkmjV8CFiR8/0wDDKDs+TH2yBmy58Jd81A35kCL68w15EO
 CKKB4sadZvyMi2pQGF8H1ixtqR/PCt3HPRK2Ch8tadDpCBHrobhj9dcdaSTB388HHqGuZjQpYPO
 v5GzU+eIpnlHGmXgFzyA7F/bPa12PJWR9LUfC31gxpEQtvYsOoY1kixzYN7Iz/6pUjvU5PIoNwQ
 ExzqwOAZ8Anr+/FdTatzc2q86SECL7stN7F0xMnXKKexmaYBeaK5KztAIkz9B0Z7opeVtCqCHOO
 VLgG+ON3i488GmlUXV75AWck7pMjf/6JA==
X-Received: by 2002:a05:6402:3788:b0:674:b1b1:d039 with SMTP id
 4fb4d7f45d1cf-67d63db380emr1617960a12.11.1778075614602; 
 Wed, 06 May 2026 06:53:34 -0700 (PDT)
X-Received: by 2002:a05:6402:3788:b0:674:b1b1:d039 with SMTP id
 4fb4d7f45d1cf-67d63db380emr1617931a12.11.1778075614040; 
 Wed, 06 May 2026 06:53:34 -0700 (PDT)
Received: from ?IPV6:2001:8b0:8b6:13d4:102e:f2af:e074:5cde?
 (e.d.c.5.4.7.0.e.f.a.2.f.e.2.0.1.4.d.3.1.6.b.8.0.0.b.8.0.1.0.0.2.ip6.arpa.
 [2001:8b0:8b6:13d4:102e:f2af:e074:5cde])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-67cd904fe68sm1337174a12.0.2026.05.06.06.53.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:53:33 -0700 (PDT)
Message-ID: <9304aada-ee84-4cf2-a1d7-82313eda07aa@meta.com>
Date: Wed, 6 May 2026 14:53:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/9] vfio/pci: Fix vfio_pci_dma_buf_cleanup() double-put
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
 kvm@vger.kernel.org, =?UTF-8?Q?Carlos_L=C3=B3pez?= <clopez@suse.de>
References: <20260416131815.2729131-1-mattev@meta.com>
 <20260416131815.2729131-2-mattev@meta.com>
 <20260501131236.278ac431@shazbot.org>
From: Matt Evans <mattev@meta.com>
In-Reply-To: <20260501131236.278ac431@shazbot.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=fLsJG5ae c=1 sm=1 tr=0 ts=69fb47df cx=c_pps
 a=Tczdrg5if7+wQeIJmxD/XA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=7x6HtfJdh03M6CCDgxCd:22
 a=GbPsI2Ihf5RTnMjR_gZv:22 a=VwQbUJbxAAAA:8 a=UqCG9HQmAAAA:8 a=Ikd4Dj_1AAAA:8
 a=VabnemYjAAAA:8 a=CQcdbiei6IkXp1Z0tZsA:9 a=QEXdDO2ut3YA:10
 a=1oAhN8tkTtOBK6_UvoHx:22 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-GUID: C8dIqpts_GquiHIxHU7T7PVoJ8VERgOj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA2MDEzNiBTYWx0ZWRfXxHBy5BjBPiZp
 wwLmVH1ANoxD4dHILbhXdOlY+8XCHEMGo1bEtR6oq4PZVtzmymAZI1aK1r2hifs0NTZK8kE2H8d
 Zggqg80FIG4okho4pjOlLo7xO5PbaZUFhBJfBYXB+InE9RXCqTbgq6paiH1/R0ygY/Vgo57lvKo
 TCds4Yd4v+8M67uV7FX6Oek20Ggy9CrFjpuwT5wnooBraac7ZKl7McEXVhtfQqZdOBxsDamaHyv
 iwLYS6Pc1m44lorIlZuO3qUivncIb9JYses8Z5eEVabrBPTZI3RlapgYnQylOKIMZ5Ltt7LhNFS
 Wy2hY+of2V9TYygvqMzMhhLkjeM3hEMAPA8H4+F0vM00u0qerQM4XWNcyMaPgWnE7/5mqeNErUg
 HH4pMYDzksonWIHLdVNp8nt0ZmzZIycSj4kFyyTYwR2PuAjJx4Nf5+PSp2HxMguT2iDZk1iqNZw
 wQPhMLQorovuVqLJhsw==
X-Proofpoint-ORIG-GUID: C8dIqpts_GquiHIxHU7T7PVoJ8VERgOj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-05_03,2026-05-06_01,2025-10-01_01
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

Hi Alex,

On 01/05/2026 20:12, Alex Williamson wrote:
> 
> On Thu, 16 Apr 2026 06:17:44 -0700
> Matt Evans <mattev@meta.com> wrote:
> 
>> vfio_pci_dma_buf_cleanup() assumed all VFIO device DMABUFs need to be
>> revoked.  However, if vfio_pci_dma_buf_move() revokes DMABUFs before
>> the fd/device closes, then vfio_pci_dma_buf_cleanup() would do a
>> second/underflowing kref_put() then wait_for_completion() on a
>> completion that never fires.  Fixed by predicating on revocation
>> status.
>>
>> This could happen if PCI_COMMAND_MEMORY is cleared before closing the
>> device fd (but the scenario is more likely to hit when future commits
>> add more methods to revoke DMABUFs).
>>
>> Fixes: 1a8a5227f2299 ("vfio: Wait for dma-buf invalidation to complete")
>> Signed-off-by: Matt Evans <mattev@meta.com>
>> ---
>>
>> (Just a fix, but later "vfio/pci: Convert BAR mmap() to use a DMABUF"
>> and "vfio/pci: Permanently revoke a DMABUF on request" depend on this
>> context, so including in this series.)
> 
> We really need a fix for this split out from this series, It's already
> been shown[1] that this is trivially reachable.  Carlos proposed[2] a
> similar solution to the one below.  I was concurrently working on the
> issued and suggested an alternative[3].  Let's pick a solution for
> 7.1-rc.  Thanks,

It looks like [3] is progressing, so I'll drop this one when I can 
rebase onto it.

I noticed [3] removes the dma_resv_lock(priv->dmabuf->resv) around the 
priv->vdev = NULL, and this series' vfio_pci_mmap_huge_fault() relies on 
vdev only changing whilst resv is held to resolve a race between a fault 
and cleanup (see patch 7 of this series).  The handler takes resv so 
that it can stably test vdev in order to take memory_lock.

Must your fix change vdev outside of holding resv?  I'm still sketching 
alternatives; at first glance perhaps the fault handler could rely on 
vdev being valid if !revoked, which can be tested holding [only] resv.


Thanks,

Matt

> 
> Alex
> 
> [1]https://lore.kernel.org/all/GVXPR02MB12019AA6014F27EF5D773E89BFB372@GVXPR02MB12019.eurprd02.prod.outlook.com/
> [2]https://lore.kernel.org/all/20260429182736.409323-2-clopez@suse.de/
> [3]https://lore.kernel.org/all/20260429142242.70f746b4@nvidia.com/
> 
>   
>> drivers/vfio/pci/vfio_pci_dmabuf.c | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/vfio/pci/vfio_pci_dmabuf.c b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> index 281ba7d69567..04478b7415a0 100644
>> --- a/drivers/vfio/pci/vfio_pci_dmabuf.c
>> +++ b/drivers/vfio/pci/vfio_pci_dmabuf.c
>> @@ -395,20 +395,25 @@ void vfio_pci_dma_buf_cleanup(struct vfio_pci_core_device *vdev)
>>   
>>   	down_write(&vdev->memory_lock);
>>   	list_for_each_entry_safe(priv, tmp, &vdev->dmabufs, dmabufs_elm) {
>> +		bool was_revoked;
>> +
>>   		if (!get_file_active(&priv->dmabuf->file))
>>   			continue;
>>   
>>   		dma_resv_lock(priv->dmabuf->resv, NULL);
>>   		list_del_init(&priv->dmabufs_elm);
>>   		priv->vdev = NULL;
>> +		was_revoked = priv->revoked;
>>   		priv->revoked = true;
>>   		dma_buf_invalidate_mappings(priv->dmabuf);
>>   		dma_resv_wait_timeout(priv->dmabuf->resv,
>>   				      DMA_RESV_USAGE_BOOKKEEP, false,
>>   				      MAX_SCHEDULE_TIMEOUT);
>>   		dma_resv_unlock(priv->dmabuf->resv);
>> -		kref_put(&priv->kref, vfio_pci_dma_buf_done);
>> -		wait_for_completion(&priv->comp);
>> +		if (!was_revoked) {
>> +			kref_put(&priv->kref, vfio_pci_dma_buf_done);
>> +			wait_for_completion(&priv->comp);
>> +		}
>>   		vfio_device_put_registration(&vdev->vdev);
>>   		fput(priv->dmabuf->file);
>>   	}
> 

