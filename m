Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0757FF60EE
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:05:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0762A10E93D;
	Tue, 31 Mar 2026 09:05:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lFR9K8+1";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010045.outbound.protection.outlook.com
 [52.101.193.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F67D10E93D;
 Tue, 31 Mar 2026 09:05:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sesuHxv19SD+3aWV0sYl5/gnGzFTNbtDyPrAERt5xbHPENhqNQWBl1NCVxM1pS6MZjc0aJtuFDFqY7k8ijei8a6CcSpFXXWscGFGISDETtNAJ+nyI1btFtoJduBDHMmYbE7Ha0ecEWGA5tIoIX57XKsuBZqzBLDfnz9cfY4BgpTw8lZQELF20/+sOkSt55R+lf4D34IDLkwEq5VEK+yBaNsKhQTuGc0tWEhXZXTF8oSKmK9/hFgdGaAGSgTCXBnEHYH0pFDUDQ5Fm0dg/HVcLEcuIt4LyRdb7/9RIfaLB44INsdnpzXFmN6e5VLwUDQUMGXcdkueOrY52Wngv6RVbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7tsQv44uw1tKIt9gwK+zyAvxI89JSwJTq9KXLzENmRg=;
 b=lhaWoYGiWMuJngkMr8mGC3AyOo7c0+BmiBFfJTB+OCFp4U5oupGBAsR3wWoAmi2yUJ641D7QicIpEamHWCvP4dzlpR+ciew8nAwC2Cf9xsaNz7k9CnSciPocM9WI6MkIF3HaHwEGvYQTJ/k0+0+EYZnNyRR2NDlMwLahGyw5LYNQzugTF3GJWH3fnDXavp356ex4bFEqIkx41XTy1MUN7/+dK0f9/QrSq3q6M8YshCa+PlzgaWxwamf2kGxAVB0Ixu6GrWOAetbI41sKgysWA8hjgMLcJQDKBKNRnRJEzlBR0HRh3tNzX6zTxuxB9kQ561UMAmpmW4cK9kaFICZ3zA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7tsQv44uw1tKIt9gwK+zyAvxI89JSwJTq9KXLzENmRg=;
 b=lFR9K8+1TmfOSVMmjt6U988OJ53at/zriClGUrt3TAy7t/ipQP9bxsC30g8eFZ7I6J8XGaXGbuGLViPfIe9VricfQe2ViW8aN+mTI8gaf42dIilk2sw3EJVc7bNuqtHcIsAPbX2vkUn0+sqqpnm4LZh7bbxM8e3N0CLbpFoG2p4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8740.namprd12.prod.outlook.com (2603:10b6:a03:53f::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:05:36 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 09:05:36 +0000
Message-ID: <b25b23e8-2854-4f4d-b838-1924185fdd9b@amd.com>
Date: Tue, 31 Mar 2026 11:05:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/amdgpu: fix sleeping allocation under spinlock
 in PASID IDR
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: Eric Huang <jinhuieric.huang@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, stable@vger.kernel.org
References: <20260330053025.19203-1-mikhail.v.gavrilov@gmail.com>
 <20260330053025.19203-2-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260330053025.19203-2-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BLAPR03CA0001.namprd03.prod.outlook.com
 (2603:10b6:208:32b::6) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8740:EE_
X-MS-Office365-Filtering-Correlation-Id: 870c9eb3-b3cd-45c4-938f-08de8f04ac55
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: wsbfCpg1C19kYBwXyKoogauDP3dzneYIeK8zHcc1dS9A6U51PV9AMXdhb26rt2glk3JR0mi7kE+xIW3ydJO0Xbp1OTkmXCVfYgeB8Mw/Vmo6lBTDqn904FdjQDskMp+iAhEg8Rh87AXMw5kNbIxvvVcsh2Py9d+2jkAJG4SKFt+pAB1waYcg6G/ja7aRqiWVvco/8B6/3DjjiABx8WkSVyXgJ3sZ7UhO9m+Qg3HSUcgiwnQJrWPQuLo43mdtPgOy7ZOy3r30gJoUR8YkiDIMGvicKDFWIMVIGEzFdFWbhKHDolitXnql0RUVlj9GgvMnYCb69WYIkxBu3qoljAS9EteCNaITo/Gr9sIGAicdC98M49ywfgsEX7WdyjiPTRLH0PHX7NsS874ps8H22fiYkpbsSEqVlawUhm2yZG+bedgyOa3AFkGloz0nAQfkH0X5tRGeD/xVpG5KjkKggOKwrwlSv0pT8Ly78NMe/4PDHTm87D+Fhh1XaaAkBf/F2WJg+58C1eZ6tX8QKjR8y++KGYxpvB/KevhSk80xSeUSqAbpjQn8j5OLNCp1uKS3GzckBeo7NYnajhbME51VNtJ5Eu/GnFGkLbISzYBIiHVIErqFVTfHxTam40z5GfnNrHYmmA47RjCJp28yB9IuP/T2Igxe+m3ihotEHTgpaLWhtyM2amPyNLtW0iGA5Uq/gA6W5iRY+iN0fdGNjul+a1MGuYXojEL1aBGJq3EafKiT9mo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RjQyUEhaaXhoczVPMmp3OXVNbmR2bkN4R3pPU21SRGdkb0xyb1FhNGRQQlh2?=
 =?utf-8?B?b0JaTzl3a0VwR2ZtVnNwTmFQOXdLc1JrRkRWOU1HWkt6Q1dxZm1jVzg2UFJ3?=
 =?utf-8?B?WkNYUXRxOGphVU9vVm1VSUYvUTc2STdLK3RjYWdVcG1tamxBZGJHNCtyNTdP?=
 =?utf-8?B?QmQ2UWVDTE5mZU5VdXkxRlFmNXIzOTgrbEFHRVk4dWFQLzVJQjlCNDJPMUp1?=
 =?utf-8?B?QUZvKzdQdy9PVElDNU9wWmViN1YvbUp3WkVsWGo3RGZPOUZ5U0d4WGY1Wm5E?=
 =?utf-8?B?RnpqckFEM2tDcmZINkVob3JSa0xBRDZXeUY2VzIzdnQ0RmRmVm4xTHJ4T3pn?=
 =?utf-8?B?V0F4cTA1OW5SUWdqdVRCZ2lqQ3JOcExuQ3N0c1pUTTVlaVcrR05Ld0RmRVI4?=
 =?utf-8?B?MEMwbTBTaktiazBkOUdiNkVjb21xSVVneDdRek9aOEg0MmNNQ3hLYy8rckxO?=
 =?utf-8?B?cFc5NmoyaCtybzFGTmdBK0l4NEpWVDh5S1VncVpKNGpzZEpLVWh4WTZpM09S?=
 =?utf-8?B?N3JmYnJOZlpzenFnSlFaUzl4RzdRTVArVjZLWWQramNuTGVVaE9Bb2pVUTA3?=
 =?utf-8?B?QjJ5eTVCL2dhRHhQMHZ4TmlrSnFzUHJ2QXhTcitwUFVYZEptUVllQjdVNjZD?=
 =?utf-8?B?WFgyRlRQUExiZG94Z3N3ajBhaGFxMUZ4ZUFwdlI4blVCWVh0ZWd6WlhUTmFq?=
 =?utf-8?B?YkZlVWNQcEY2U25odlVBOTRHbGt5bnZhenYyemlWZmZLRWlhQWtUeTFDRFM1?=
 =?utf-8?B?WmRmcDZzZmtOOUtKdHVLSFgrRTRmRTR2Z0w5Q3k0VUsrdERYdnJKNlh5a0Zr?=
 =?utf-8?B?bVVsUHlKbEcwOTV6MUdCT1lIajJxZGZEamlqNi8vMExVT09WcGYyWEo0cWRT?=
 =?utf-8?B?RkdvZkZ1UGtUcm11cTVhMVMxQUsvbE11ZlAvK3BrekVCOE9xcTlDN25iYTlx?=
 =?utf-8?B?aU01MllnSzRaTkk4ZE5zdHNGTzRqK0F3NFc2blhCOU52bnl4Nm1za1lXZVhZ?=
 =?utf-8?B?OWZtbFliRExWbEYxazBsTHI0SmR1c0JlUnJ4RTNBaGhUS0JnRHZFR3NNRDEv?=
 =?utf-8?B?SWtaL29SUTVkeXdXK0IySXozU2JCc0RhSnR3bkkzWkhZK3VmdmNuU1BrbzBp?=
 =?utf-8?B?STBidUUvM3oyUXZTa3V3V01TM2VzNkREK08raDhmVy9udUJSOWVUT0pCcnlE?=
 =?utf-8?B?cFlER2c0c25Kdkc1L2NkSlMrZDY3djl6ckpVejN5T1V5dm1TVlNCV0dRUnNr?=
 =?utf-8?B?QXBDWXZXOUhUa0lpMWhmZ2doQ1lyRDc0QWFvTVpMS1VUMVE3RXlrL1hMUGxh?=
 =?utf-8?B?T25xNGhuQlhYbnZ3UGxMZDdRblBuWlhxMjBhNkNZNHBhRFg0Ykd0VUFGdVVB?=
 =?utf-8?B?U1F1WTlFNVArK0pXM2puSXg5eG1wNzVvQWNtTkoxbmxZdFpYREtYMzd6ZXpR?=
 =?utf-8?B?eUxaTlFGWmRvRk9HcmJDZGNGU2dET2NZeHZORXB0NUVFTnZTaTM5VlB2dWwz?=
 =?utf-8?B?SXhTL0YrUG5keU4xa25TcGNIcGVDUUFKUW5VZE1OcExFTTJKK2dRb3AvOGlN?=
 =?utf-8?B?N2YyN3V3amYvSGJTelNHZEZqKzhaU3dDVDhhK25XZVhoNnA1VDFObk92cHFD?=
 =?utf-8?B?REVNMDMzUkZJVnY0dzZMNm43bXZId3d5OXQ2K244QUQ2eHRnbEJpN0JEam53?=
 =?utf-8?B?V05mSng3bWtpdEorVnJYUXMzS3Y5TVpWTHBkWWpkL3pxU04rOGJhaDhGeXZx?=
 =?utf-8?B?WUppSG0rUU1wRXJ2eEE4S01tWnk4WDhac3ZMRXgvaUlzRk94V2M1cXJqc2RH?=
 =?utf-8?B?SU1CL0JTSEE4WFNZNFR6UVYyU2pSZ1p5Q0pLVktTcTFDRUhXRUM5VlZHWGlY?=
 =?utf-8?B?NWtodEV5UGZMa3VQTjQxNlpyTVBTTHRnWktxYWNFM3pTQndNK3FmZk1pcWk4?=
 =?utf-8?B?UEhpV2pzMC9vam5FZGZjUVFFSjZEczJlZnNKZ1NnRkRMNnZvYStDT2ZibG5o?=
 =?utf-8?B?TE5FOE43bnVrTkMvUFF4Q3JKVVhJenBqdWoxL3JYMGVPNm4rODZpRS9XSGxJ?=
 =?utf-8?B?WU9mMWtEbSs5THNtUk4za1pxRTQyNVlMS3pjL21sdGRoVkxBOGFpNXZSOU01?=
 =?utf-8?B?OERIQkFXTVFIdnRNYTR4SFpBNnNheHhRRFkrMzlNTko4YVljSDBOT0xHNVhw?=
 =?utf-8?B?dVpSTnBGQ3JyNk9xdGlLdXR2WU1TQktpS05GYmhSdmhudXhqVGNDVTl4c3Ax?=
 =?utf-8?B?VlVHRVdoTk83TC8yTFhKVmxzRlZjTlpjMmsveUQ5MmZPKzJnZDN0Q1lhc1Jj?=
 =?utf-8?Q?CsAs6BrjGseZ6iOCD7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 870c9eb3-b3cd-45c4-938f-08de8f04ac55
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:05:36.8230 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s/dvNfuREigghxyyU09Z6OuqrfQ0LnhjoYNK5N7ozgfZMOy4yHJBMzbtbdEazbfR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8740
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

On 3/30/26 07:30, Mikhail Gavrilov wrote:
> Commit 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
> switched from ida to idr_alloc_cyclic() protected by a spinlock, but
> passes GFP_KERNEL to the allocator.  idr_alloc_cyclic() may need to
> allocate radix-tree nodes, which with GFP_KERNEL can sleep — illegal
> under a spinlock that disables preemption.  With CONFIG_PREEMPT or
> lockdep enabled this triggers:
> 
>   BUG: sleeping function called from invalid context at
>        ./include/linux/sched/mm.h:323
>   in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 570
>   ...
>   #1: ffffffffc2cd24f8 (amdgpu_pasid_idr_lock){+.+.}-{3:3},
>       at: amdgpu_pasid_alloc+0x24/0x210 [amdgpu]
>   ...
>   kmem_cache_alloc_noprof+0x41d/0x780
>   radix_tree_node_alloc.constprop.0+0x56/0x3a0
>   idr_get_free+0x330/0x830
>   idr_alloc_u32+0x14a/0x2e0
>   idr_alloc_cyclic+0xd3/0x1d0
>   amdgpu_pasid_alloc+0x51/0x210 [amdgpu]
> 
> A mutex is not an option because amdgpu_pasid_free() is reachable from
> dma-fence callbacks (amdgpu_pasid_free_cb) which may run in IRQ context.
> 
> Use idr_preload(GFP_KERNEL) before taking the spinlock to pre-allocate
> radix-tree nodes, then pass GFP_NOWAIT inside the critical section so
> the allocator draws from the preloaded pool and never sleeps.  This is
> the standard kernel pattern for IDR allocation under a spinlock.
> 
> Fixes: 14b81abe7bdc ("drm/amdgpu: prevent immediate PASID reuse case")
> Cc: stable@vger.kernel.org

The patch introducing this was never released to any stable kernel as far as I know.

> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d88523568b62..515775eab2ef 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -67,10 +67,12 @@ int amdgpu_pasid_alloc(unsigned int bits)
>  	if (bits == 0)
>  		return -EINVAL;
>  
> +	idr_preload(GFP_KERNEL);
>  	spin_lock(&amdgpu_pasid_idr_lock);
>  	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> +				 1U << bits, GFP_NOWAIT);

That needs to be GFP_ATOMIC and not GFP_NOWAIT.

Regards,
Christian.

>  	spin_unlock(&amdgpu_pasid_idr_lock);
> +	idr_preload_end();
>  
>  	if (pasid >= 0)
>  		trace_amdgpu_pasid_allocated(pasid);

