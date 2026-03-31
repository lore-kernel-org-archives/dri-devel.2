Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84A1E1061B37
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 12:28:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9317E10EB1E;
	Tue, 31 Mar 2026 12:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="hQkqJ1Tr";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010003.outbound.protection.outlook.com [52.101.46.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F4310EB1E;
 Tue, 31 Mar 2026 12:28:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aUbIGc7fyKGXDaw18s67AkvAQOl977wUTFNmaD5nLRNK/vd5zsrUwFr5XZCh1hbqtdZw6exKMChxqFxQHxnla9OJS2QeQ3yf2qdTaqJzqw5UW46mrp/G5FtrO+cfBJXD1k6lIwt7tNLWFY2sBieFW94D4wL6K7Yhb/UhvfB1JUVRfG7pazPLAPrUHuGIuZF4dkGkhHGEg7c8w/Za8mc/S2ghD9LFWTh00vJTJ0NaDqa13bE7af7q04jup6C4+tqRxcByy0PUlw4C0EB2gW7i8YZgxI4CSKtP76Fk5+R4vQxwTy6pSQSKvLtzlvs1CPwluOlNYueqNdOVEOJD5oylJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7+QqYTyjus+TIR8TiNScOtXwEEXBtWN4u8nDWBFfbc=;
 b=KV1SLqaQ6NKNWd8Q0lsAXKkyF2sOrN6dgUke+wV/RnfINDEfIA7KxClODIh0VMLGeUCgXDaNOA91wd8xUfTyITCSv2hYf3kKfHWE7M7+jBEGwctNiCHfJnX3IOERRdDJr7FsldOoLRbrYSAEegtcW25RQF1nH9PwihIQqfRSvD7rTfOiHDMrxify9cBm12+ye+TjJhOsVqMjEZNvqFrYNaVY1xwEDnZYapdXXhHu9aavW5YsNpAwSLaA8X1Hf79WD9MKkvzqi+3nklu8WKBH8yc1jogCt1Pw0mzXsUBR9pMJFKy3zUdJaytjiA+oAXO8pdB3gyDfPkZvIDwW3Mmfhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7+QqYTyjus+TIR8TiNScOtXwEEXBtWN4u8nDWBFfbc=;
 b=hQkqJ1TrdQDJE3abBXjKR2ma4Fqu8tjy1TmMu3BhbY0ktFkHUuZtj8ODx3+1+j+unYIuGnDg2UXn4TrN7NOKILVZiF0eTshicvjH6O/bPhaoKwR8c1kxW/PA01Ad1FH5aFWVCcqvZr/KtDU+tMxKk7sNkFUZVxkYJTz4eUXUiM4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH1PR12MB9694.namprd12.prod.outlook.com (2603:10b6:610:2af::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 12:28:29 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.014; Tue, 31 Mar 2026
 12:28:29 +0000
Message-ID: <2fb67e0c-c7a2-46d6-af24-d67f704cac6d@amd.com>
Date: Tue, 31 Mar 2026 14:28:23 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6] drm/amdgpu: replace PASID IDR with XArray
To: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: lijo.lazar@amd.com, Eric Huang <jinhuieric.huang@amd.com>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20260331111808.16578-1-mikhail.v.gavrilov@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260331111808.16578-1-mikhail.v.gavrilov@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN0PR05CA0006.namprd05.prod.outlook.com
 (2603:10b6:208:52c::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH1PR12MB9694:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c4b3e89-abc6-4021-342b-08de8f21035d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: rLVzywH+b9ShRjm8aWgw6i/ufL5H7lcB+13MYifAQSLPCiXF4MCdGnv2gyNDLq1abWqg5Ax2Sb7aPfzESE3JdY12aNXdr0o+Frad8nurS05MWNkppYngvtQK2yU41i04D56znzkVrw8EDie5H0eDPFQE93lTuCpyM9CfvJ1l9w+YNtimo3rcrhizhAnIQaGejYFFC8lfToa8OADJgyzSlzXenJZpvMkuMVcx46c1eQXCwg/9OaJG/p303TY4FUlA2TpbEgfCMtamIrBX4uxpVuXN5ZsaHWWcdOSzoyddzjWnV9QzfDED8szC0ZLBBdqQcSchz0i3gbGNB/O8bqzYFPA+5Xgez5oLbLgXIHYLVuHIOMwEJ1Yg0MKxam9tWdL78PYT1P6t5wsGX7k+owXMBAh2Y8v1D1TLLfdtupBoL+loHAU6NcrzxuO/r79OxAgVcK+O7TKCyLNP4Ez1idebwTMxaFEsPmqQ4/57ixfVRozgKr+BnRHgv2z22BzqyncipRnvPKmo+EHpjpVkgNFqEZjAkkJE3mnvem/7hGnXLQaI2yBJ+WPfuNCwnwbVr19drZVSLDPK2DARBCl47QIk82D+7/YIwEPHNN9S0DLRVs2bwpC+ROQ7M4iD6UxkCvjMg6PWXEatZeg4pPlWC9in553kBjKUBHsSkNpBc1Z5QeGWdE+ydLk/14fcUP1nU+x9z7mrYXUljrcL6kQ0qIpozFpw4E4cfH6MB1jNTFjZ4lD/8aw+v0YhhsfOD5d90GeH
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aklhVUVEL2wzS0NCaVA4NUJzZDJyZXhMT25WVnprZldSdnJPY3B2cS9UNjRl?=
 =?utf-8?B?dnc4d3ZRclovTkFJZzJETExLY3FFREx3aEplRlVVd21nL1BtWWZXM1REb0Yv?=
 =?utf-8?B?WFJGVktzUE9ZOXpBUHRHRitlUVV3MXpnRWplYWRscjIyc2VaWG1TbmU1NFlt?=
 =?utf-8?B?VDZ1ejg2NDhqOUIzczQxYW5RSGJ5MXduSU1Mc0FtSXVBeUJ5OVhPMzNPR1JY?=
 =?utf-8?B?VGhuVzRQUkhKcXRNMDBBMG1Lc09Qc29lK2srU2NaanpwYVFPK1hMNHhabTRp?=
 =?utf-8?B?NmFPVTVhc2l4SEtuZjNqS1ZFbnNxSEgzbWhXSDY4Tk9mQldHeHVIaTN0enh4?=
 =?utf-8?B?SHBSODNXcGZ0UmpMM0hjbTZ4K3JXd0NGd3hLSnVXa0gyWmlvVWlVWnZGSkhk?=
 =?utf-8?B?RnBiRXBPTUs1bGRlaGsxZnA2bzBpditLVHM2K3RiOUM4ZWZkZkVvc05Ka2th?=
 =?utf-8?B?aHEvcGF4enAzdml1U2tBVzd2Ty93V2grK3BWSWtqeUUwbDVYL3RkcVU2bE5K?=
 =?utf-8?B?Skp6MDJQOW9vVXFvenZ2dmNOaWdoOC9ZUmlnRy9uZmt1WktSWDJabmhHRkRB?=
 =?utf-8?B?UEJ3YlU2QkRiaE4wVzRvWk12R2tRNTZWWC9NSTEzZTl5ckxvNEtuWklDdlps?=
 =?utf-8?B?WTAzQ1BheFU0K0cvRUNkZ3ZSTVFRbkJmdm1vV3NLbFI5aWgzb2pRQmp4eDN2?=
 =?utf-8?B?K216VzFwRDBKVFNVaTRCRXZaSDZZTGoybGhlTHZORm5hR3FwZ2EyWG8yUEpi?=
 =?utf-8?B?NzhWUDN3cU9NdnRzQ3JVaUtLcWcxRndsK1N1VjBaMHlzVUQ1eFkxZGsxeDh2?=
 =?utf-8?B?eGZvNEk0bmtxU285QzZmZlZjMGVwRnYzbWVXYy9xdjduYkNLT2lTVkMxd25J?=
 =?utf-8?B?RTV6UmxQR3N6cDVtbTdSbXEzODRWZ3lNUVo2S2xmU1FpZkFVdDQrYnY2eTZj?=
 =?utf-8?B?OUVCN1Y0SHNhbWZuRzlOeDRQRTY4Ri9uRDBVV3Vmam9SNk5HRjdwRDB2Slhm?=
 =?utf-8?B?OVpZaUlOL1dRNUdJWE9BQmx6N3B3UlMwWCt3YzNlSG9ZTWovYUVPUXp1cFVm?=
 =?utf-8?B?bE81VzV1ZWdkeFlrRTZUOU1pR1gwZXRXVWRIbm1EQjNBLzB3cHZBSGI2Ykhl?=
 =?utf-8?B?YzdaeGd1V0Y0Q2hBUGczbTRxM1lsRW9TZTNzZW1kdkRUaUtKc3krbkQxaHZK?=
 =?utf-8?B?Q3kwcWNMT1dJZjI4VERUODZYcGhjUUpZSHdLQmNtdjVBSGlBdStMU05jTDVB?=
 =?utf-8?B?SVI5V2p3SmNSY2lKakRTNkgwK240OHJSaXNPRzlOR29kVStNQW5TOFZGTklr?=
 =?utf-8?B?aDg4OWVEaGVPbU5hNkNrbkhiRVRqZmZpR3dmaGVrREtGWHRuNU0vd2dHY2Uz?=
 =?utf-8?B?eHFoMm9UUkw5L3ZjUVBMSXB6ZkY3R3ZRcmNUOHpHVDRjWllaSXNCQ3A4MEl2?=
 =?utf-8?B?cDdmdlRTT2krelNTQkFoRGFiQXlpdExTVE1BL1dUUFN5WnBsRXQ2dHlpeGs1?=
 =?utf-8?B?Z1h6ZlRjaHpvUTlRTkZpeFRpakpMdDhnWlhVYnk3djcwVUpxb0l4MjBiOUh4?=
 =?utf-8?B?cGIwR2hXcDFpaFBEOGJwWHczeVZiYmRKSHNwa0pkUmpkSGFSRzExOFNEaTFW?=
 =?utf-8?B?NU1OV0JaQWN5UUxSVzFjc1hLTkx5L290QkJ0L0dTaTFOcWNobWt5UzRzV3M3?=
 =?utf-8?B?bS9sRVRoc3ViVkFUYWlGUkJvUVRiT295Q0V3dVpRWmFKVEJHQ0FZbExQRGhs?=
 =?utf-8?B?M290YTYyVG9nWTFuUmNuV1Q0bDQwRlVQNTh6NDdLUHZUeEg5WVFRdFBPd0JN?=
 =?utf-8?B?azBRWFFIYitENWNlY1g3eGl3cFRrajUrQzRnNVhkaEZZdzR4aWx5RXErMk9G?=
 =?utf-8?B?emJTd2lHc2NNemY5RGtzSFVEMER6SFRQbFVsWGRIYzl4NzdpcnJaTjZQZ0l1?=
 =?utf-8?B?NitJazRZMWd4ckFVaEtBYzVWNVR1QnZCU2NHd0JYUDJBYS8xSU81aTdQNlo1?=
 =?utf-8?B?bFZTbXZFN0ZSbFA2UExnVVNCSGZ3ZXlyU3l6QVhzWTNEbmVYV01lKzFVUVEx?=
 =?utf-8?B?S3JIY09aUXJjTlpSN2phRTY1RFhjVjVQa3JOY0w4QkYzNXZkNTQ3cDFvcyty?=
 =?utf-8?B?ZXo1U2tOVVRNRzlKQU5OV2g4ZjVENTZ1ekVvdVNiRHlyME5qaVFBYm5lT2I4?=
 =?utf-8?B?alVaVUlUK0JtWkFnd1NDNEhJUUJwZUlsQ0MreTg5bkY1WThiZEVKcjk3Vklt?=
 =?utf-8?B?VTVyOU1LTUR3Z0JiZFBZTnRVS0FiQlFZcmxVSE1EN09WS3UxMmdORDByT202?=
 =?utf-8?Q?c4Ifg4x0ibA6QGxPIK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c4b3e89-abc6-4021-342b-08de8f21035d
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 12:28:28.8833 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9x3ON5dRWtjymWHAfDy/hD15AgNDXQSzazvt7UuNUtXbeiDM19Sf5QwfAtOZ9ySp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9694
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

On 3/31/26 13:17, Mikhail Gavrilov wrote:
> Commit 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")
> converted the global PASID allocator from IDA to IDR with a spinlock
> for cyclic allocation, but introduced two locking bugs:
> 
> 1) idr_alloc_cyclic() is called with GFP_KERNEL under spin_lock(),
>    which can sleep.
> 
> 2) amdgpu_pasid_free() can be called from hardirq context via the
>    fence signal path (amdgpu_pasid_free_cb), but the lock is taken
>    with plain spin_lock() in process context, creating a potential
>    deadlock:
> 
>      CPU0
>      ----
>      spin_lock(&amdgpu_pasid_idr_lock)   // process context, IRQs on
>      <Interrupt>
>        spin_lock(&amdgpu_pasid_idr_lock) // deadlock
> 
>    The hardirq call chain is:
> 
>      sdma_v6_0_process_trap_irq
>       -> amdgpu_fence_process
>        -> dma_fence_signal
>         -> drm_sched_job_done
>          -> dma_fence_signal
>           -> amdgpu_pasid_free_cb
>            -> amdgpu_pasid_free
> 
>    This was observed on an RX 7900 XTX when exiting a Vulkan game
>    running under Proton/Wine, which triggers the fence callback path
>    during VM teardown.
> 
> Replace the IDR + spinlock with XArray using XA_FLAGS_LOCK_IRQ (all
> xa operations use IRQ-safe locking internally) and XA_FLAGS_ALLOC1
> (zero is not a valid PASID).  Both xa_alloc_cyclic() and xa_erase()
> then handle locking consistently, fixing both bugs.
> 
> Suggested-by: Lijo Lazar <lijo.lazar@amd.com>

> Fixes: 8f1de51f49be ("drm/amdgpu: prevent immediate PASID reuse case")

That should be unecessary. We already replaced GFP_KERNEL with GFP_ATOMIC in Alex fixes pull.

> Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
> ---
> 
> v6: Use DEFINE_XARRAY_FLAGS with XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1
>     so all xa operations use IRQ-safe locking internally.  Drop
>     Cc: stable since the regression was never released to any stable
>     kernel. (Christian König)
> v5: Use explicit xa_lock_irqsave/__xa_erase for amdgpu_pasid_free()
>     since xa_erase() only uses plain xa_lock() which is not safe from
>     hardirq context.
>     https://lore.kernel.org/all/20260330191120.105065-1-mikhail.v.gavrilov@gmail.com/
> v4: Use xa_alloc_cyclic/xa_erase directly instead of explicit
>     xa_lock_irqsave, as suggested by Lijo Lazar.
>     https://lore.kernel.org/all/20260330162038.25073-1-mikhail.v.gavrilov@gmail.com/
> v3: Replace IDR with XArray instead of fixing the spinlock, as
>     suggested by Lijo Lazar.
>     https://lore.kernel.org/all/20260330110346.16548-1-mikhail.v.gavrilov@gmail.com/
> v2: Added second patch fixing the {HARDIRQ-ON-W} -> {IN-HARDIRQ-W}
>     lock inconsistency (spin_lock -> spin_lock_irqsave).
>     https://lore.kernel.org/all/20260330053025.19203-1-mikhail.v.gavrilov@gmail.com/
> v1: Fixed sleeping-under-spinlock (idr_alloc_cyclic with GFP_KERNEL)
>     using idr_preload/GFP_NOWAIT.
>     https://lore.kernel.org/all/20260328213900.19255-1-mikhail.v.gavrilov@gmail.com/
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c | 43 +++++++++++--------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> index d88523568b62..9f264d439f3d 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ids.c
> @@ -22,7 +22,7 @@
>   */
>  #include "amdgpu_ids.h"
>  
> -#include <linux/idr.h>
> +#include <linux/xarray.h>
>  #include <linux/dma-fence-array.h>
>  
>  
> @@ -35,13 +35,13 @@
>   * PASIDs are global address space identifiers that can be shared
>   * between the GPU, an IOMMU and the driver. VMs on different devices
>   * may use the same PASID if they share the same address
> - * space. Therefore PASIDs are allocated using IDR cyclic allocator
> - * (similar to kernel PID allocation) which naturally delays reuse.
> - * VMs are looked up from the PASID per amdgpu_device.
> + * space. Therefore PASIDs are allocated using an XArray cyclic
> + * allocator (similar to kernel PID allocation) which naturally delays
> + * reuse. VMs are looked up from the PASID per amdgpu_device.
>   */
>  
> -static DEFINE_IDR(amdgpu_pasid_idr);
> -static DEFINE_SPINLOCK(amdgpu_pasid_idr_lock);
> +static DEFINE_XARRAY_FLAGS(amdgpu_pasid_xa, XA_FLAGS_LOCK_IRQ | XA_FLAGS_ALLOC1);
> +static u32 amdgpu_pasid_xa_next;
>  
>  /* Helper to free pasid from a fence callback */
>  struct amdgpu_pasid_cb {
> @@ -53,8 +53,7 @@ struct amdgpu_pasid_cb {
>   * amdgpu_pasid_alloc - Allocate a PASID
>   * @bits: Maximum width of the PASID in bits, must be at least 1
>   *
> - * Uses kernel's IDR cyclic allocator (same as PID allocation).
> - * Allocates sequentially with automatic wrap-around.
> + * Uses XArray cyclic allocator for sequential allocation with wrap-around.
>   *
>   * Returns a positive integer on success. Returns %-EINVAL if bits==0.
>   * Returns %-ENOSPC if no PASID was available. Returns %-ENOMEM on
> @@ -62,20 +61,22 @@ struct amdgpu_pasid_cb {
>   */
>  int amdgpu_pasid_alloc(unsigned int bits)
>  {
> -	int pasid;
> +	u32 pasid;
> +	int r;
>  
>  	if (bits == 0)
>  		return -EINVAL;
>  
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	pasid = idr_alloc_cyclic(&amdgpu_pasid_idr, NULL, 1,
> -				 1U << bits, GFP_KERNEL);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	r = xa_alloc_cyclic(&amdgpu_pasid_xa, &pasid, xa_mk_value(0),
> +			    XA_LIMIT(1, (1U << bits) - 1),
> +			    &amdgpu_pasid_xa_next, GFP_KERNEL);
>  
> -	if (pasid >= 0)
> +	if (r >= 0) {

I would turn that around, e.g. if (r < 0) return r;

Apart from that looks good to me.

Regards,
Christian.

>  		trace_amdgpu_pasid_allocated(pasid);
> +		return pasid;
> +	}
>  
> -	return pasid;
> +	return r;
>  }
>  
>  /**
> @@ -86,9 +87,7 @@ void amdgpu_pasid_free(u32 pasid)
>  {
>  	trace_amdgpu_pasid_freed(pasid);
>  
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_remove(&amdgpu_pasid_idr, pasid);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_erase(&amdgpu_pasid_xa, pasid);
>  }
>  
>  static void amdgpu_pasid_free_cb(struct dma_fence *fence,
> @@ -625,13 +624,9 @@ void amdgpu_vmid_mgr_fini(struct amdgpu_device *adev)
>  }
>  
>  /**
> - * amdgpu_pasid_mgr_cleanup - cleanup PASID manager
> - *
> - * Cleanup the IDR allocator.
> + * amdgpu_pasid_mgr_cleanup - Cleanup PASID manager
>   */
>  void amdgpu_pasid_mgr_cleanup(void)
>  {
> -	spin_lock(&amdgpu_pasid_idr_lock);
> -	idr_destroy(&amdgpu_pasid_idr);
> -	spin_unlock(&amdgpu_pasid_idr_lock);
> +	xa_destroy(&amdgpu_pasid_xa);
>  }

