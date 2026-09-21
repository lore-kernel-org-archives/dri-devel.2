Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6B9C982E6
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 07:05:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8E610E2F3;
	Mon, 21 Sep 2026 07:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="fB9xn9tM";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012048.outbound.protection.outlook.com
 [40.107.200.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A7B1810E2F3
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 07:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=to60itcYmRM8K3FpkUBuBCsp3Nu4I9RhJ2EUdXFzIcOrUmls1pAUBYbD6kqN9a8Vm//xA89a7r36nO9lb5ru6nqtT2S5a3TWEzo7jUtMgQUZVqjbhd2BxmIy3J4PxYut6IR/CAQ29qOcA/E5wVO+Ws0UVcFdYylauGZ6BiC0rbJmJ0YcltFI3xY0II0VQ9GjdVcpptB65taOpsA0woFJ2GwzTyatKmP/NrMi80x6mGSImOqE+hSOvPHLwNJaoyF39gbc5QeuH4Po9FoEQeMqotuyXYlWKf4cReVPGofswx6sW3ZVBSi/EF1wpnPRF1IGi/FgmsOMRMDWYrbOqGjAng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mzyL/orf6SDKeDsRNShJa/u+EPgj4oxjHYBzILRS0rs=;
 b=iMxr7EJX3nBHaJUDtUOv1aLUdCwvB3WBWjBvNAMw5a8c/80MOFUyw0JN1F3ruaE5SPXcsDvl9RDEdfSF7ekSNo+Vj262OfUNvm76hXCj8Vrmq076NBQdMLj9/7bxpGf72Aq0j1XFmOq+LcqcziwLdHAPnv1RnmJ4gHTdA/7iAAvPy3X8Vbe8pTVWXw7whWZBzdClS9Gphvk0uqyT3FTrQ7pTFTWdXaojEtgxNavCuYxB8DNEnhStLcN+HTrWT6xAW44WhiFwctU/dc8YmVWi37sIreEzaFTpkfcJkh3IoT9Nts5bY+y7+iNwiR8zI3FIs0CQqbBHfhtPuBz8U5uzfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mzyL/orf6SDKeDsRNShJa/u+EPgj4oxjHYBzILRS0rs=;
 b=fB9xn9tMN5wyJDdJtpUmKxHxmU4135qZsab0ktzOmOCgsBLDGxFPgxRbBdLcGatEAv2wYvD7z3Pm2ac/xHrmFNbdckGUldNavMGfoBJ3cWrYAgrIBD2bNW575M+vn9sJVSzBc9TjhS05s+o8Pxh9UUSB55eKBNQAmFgPbNbxjYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by PH7PR12MB5734.namprd12.prod.outlook.com (2603:10b6:510:1e1::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 07:04:59 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 07:04:59 +0000
Message-ID: <77b5fa08-6c95-4f9d-a12e-5ddca3c1c1e0@amd.com>
Date: Mon, 21 Sep 2026 09:04:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] udmabuf: Add mlock accounting for udmabuf
 pages/folios
To: Vivek Kasireddy <vivek.kasireddy@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Robert Mader <robert.mader@collabora.com>, Xaver Hugl <xaver.hugl@kde.org>
References: <20260831060210.1713177-1-vivek.kasireddy@intel.com>
 <20260831060210.1713177-3-vivek.kasireddy@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260831060210.1713177-3-vivek.kasireddy@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FRYP281CA0008.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::18)
 To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|PH7PR12MB5734:EE_
X-MS-Office365-Filtering-Correlation-Id: 116ba247-60ab-4725-0c19-08df17aea5fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|5023799004|22082099003|18002099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 4K7xbUeQlSV4hRE5chKV+m6aBbO2mUeYlpmgZHqUF6h+fNm4cMMsVGlIvWhE1CPRgoxXCJbxSPArmDB4jtTvzaZQOlHitRZNGklGv6nVe3gJKMwFxgww2A+Orv+LtoVz6otIOf4jl5z+U5/oDwW2o7CzyM7PrxwqBsnECxyk/y4DquUHG3DVUs8BoAxPgGoOIzF248o3d5glE7EkTtR1drpwgNHyQpG+frhOt1FHFr2nstJkKbq/pifwwJ3X/h8amXXgGAcMwmRMICRs8R2qRfqtC1cXf8a1CZufi+SFbBv4m2RpRprdc+NCb5MtYAnGMF1IbPcYudGfpIP5EVKiZK0parYqqrzyU17XrCF3G//2ZyTHDwD5xqfW4Z6QwTTl6bJHYFlbtYWzhd64AbQP4ULFUvCwwKNlPdRvnEMejAq3NRvQuI3PYPVtctpWUOrbgUSfU83h+hIEP0Wsnlf3HF/VkvarbHcqQYFh4N5/p8W+6L4Uw1nzK59RS2kGkfYclI4YJKhodY0FSiO9NyAoy71j68EbrQ1xKszxyuMEP202wS25uXfBJTJyRjvbSWpbbMMlC2HqGuZu5UL5ILOjfvT/x/3LP4cqoVPQ/ktQn9UE8iYz3+sPgVajrkKP4xQQxa6yB6rsug9pqUvKsGD8j8BH/d4hpvE4wcVkRkgOCvM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(5023799004)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RVdSaHVlcGxHdDJ5dk5pc0xuQ1AvODRkL1NjSW1GVzc5eExyUm1MWlJzVXNZ?=
 =?utf-8?B?YkRkVGJnTGhtcWszZXJ2ZmNpVEIwd2g0b0FwbTd0MlRHU3h4NWRhV0N5aVpV?=
 =?utf-8?B?UEpNS1hOS1YyWFRDTjAweFV4L21rSE1JQWhMaHhYdjYwbWpUUGJzQzZ3Mkxk?=
 =?utf-8?B?aDAwMFZTbG45WlZ1SDUzYUVBVDJnbGd1cnM4Yjc4SDBnRmlzTjVLbFBQSW1F?=
 =?utf-8?B?YlU4S1VKNUR1SGNINVNNOWpKM1hQZGF1TWNoa2ZXQXB3UWFqNnJDSkdOYnAr?=
 =?utf-8?B?eVA5emJmYjFRLzQ4anFKc0VINytrQnlqTkQ5eUNveDM5K2dwMlByR2pDdWRq?=
 =?utf-8?B?MWlzb1M0eDBjcWtEVGMvSVZ6Q05RZ3BRKzNKVGNmb0ZXVm9ZNzU2ZGN2R1lG?=
 =?utf-8?B?WHhxdGlEVmhtSmQrQTFLWm1mSWY2OHMxamFpTmQ0b2NteHV6ejJ0enYyT25N?=
 =?utf-8?B?YVFtNm15UUg0ckw2ekVtR0xMSldaemlNdzRNWGhybyttejgwakkvVmRWUGJ2?=
 =?utf-8?B?bDRsdytDWnB0U2xWZEUxTGxrOGg4MVlxNitKNUo1ek8rU01JQ0ZJaG9QVWFS?=
 =?utf-8?B?ZG9Ja0I3bGFNOC9qRlRNQlBTN0dUWTAxNXBzNkNrY3ppQ3BOeHhaR1ZVRS9v?=
 =?utf-8?B?cXd4UVdvTDdxSHUzUUJmVE8wUkpVT1pQM3RIcTZyVlZ0M1JVTHpoS2lRQlE2?=
 =?utf-8?B?T2s4MWFteVM2R1UwUkdqVHRGVGtvU1kzcjBrSGlYTzN5TGQvWUU2THdnNlJD?=
 =?utf-8?B?R29vUTI4ZDRQOTB6NjczMFV0NGg2MXVUVEpqZ0JVcnFrOTNRU3VvWmt3c3VW?=
 =?utf-8?B?QjBReGVlUlJYQ1FJWDBxMU4zVW1KQXc4d3BCRm1YY0hsdFRPaHA4aERhR08w?=
 =?utf-8?B?WFZlY01MRkVYczEycUJFOExsMWlsSUhBZmpZSkJieTRxeXE4REljOVRGOUVp?=
 =?utf-8?B?Ny9mNXlGcEpobzNRd1U0emgxdGFROVl2TEZuRHI5eUh0ZDliazdyd3YrSmNW?=
 =?utf-8?B?c2VZRzAvcC80NW5Ub1YwN01CMkdwSENGcGdyeSs5NW9qSjFTQzRaekxQOElF?=
 =?utf-8?B?cVB4Y2VIUWNtUkVGZWI4UXQ3RTVTWTFwbnBxbzBBL0JIQjRCM2ZGQkZLWS9a?=
 =?utf-8?B?cWdPdHFielU4UXVFYUJBZndTVTZNSzFxd1NXQjd5d2JGV0IzcExQY1RxNkli?=
 =?utf-8?B?RDdOOTR4VEgxWkFOamovZFRROHVnTGVmSENQcWh5d0phbENVeDhTZ3FmcFQv?=
 =?utf-8?B?eDhUNXl1R25lQzZVOFNWNVRUTkExZkNkMXpqUjVUYXZGTnV3Ump0MTlzYUlD?=
 =?utf-8?B?b2xDd0xVMnRWcFZCdWd3MHBwa0k4VGtQWEZoamtYR2F2MjMvRitxdGUrL1Bj?=
 =?utf-8?B?Wmx3Z09kYTBjbm40bTJhaWNDcnBlS0h4OGtCeVRmbmdCWUNMaXJvVlo2R1Bp?=
 =?utf-8?B?c1RXQXlkbGpoYkZrWUJtb2tMQmE0YjQ3YXRoQmhlSzdzV1ZGdTRJbFpNMTEz?=
 =?utf-8?B?UUJjMS9wZHpPMGRDM2VzdTBHMUZXbS9FMWU4aUovOTR0c1VHQndycjFYUDla?=
 =?utf-8?B?VXRCc1RWRmNYaG94eTlIb2xtaDBCdE9uQlJ5KzV5aUJ2SDIwUFZ4VXQ2ZTh0?=
 =?utf-8?B?NW9YdEdseCtWSEd5TmJPUTRIZm9qeG5xRytXRTkycTQrRUdIVGZKWWd4dzBD?=
 =?utf-8?B?SGxnRFprVUpWWVJTejJ2U1F1T0tMZVppYkVuRGw5QWNTSkZwMjBGdjFEeTRa?=
 =?utf-8?B?Q2xQRTFvckgrTXVNVTFVY1g5aUsxM1N6UzZadkZTODVuWXI2MGIrL3I0VHFX?=
 =?utf-8?B?Q205bGdLejRiQlZ0b2U0Vi8xR25LVUlxV2x5ZksyNmxCVFIyRVM4Y0NUcGVa?=
 =?utf-8?B?eFN6cktKT25qS3BoNlV5TEFKcHFHOEoyTnluQS9wZ21OWWR4MjloZHhjSjhV?=
 =?utf-8?B?NXE3dTV3cVpZT3RxYVdSSzl6anNBK1BxcWY2OTdPWkpERGs2K29ieXpsdjVS?=
 =?utf-8?B?QzhrME5HSTZKVXlVTzg2ZHJ4QlBXeDhlQTJITERFVmlNczBqRWh3MTdMRzkx?=
 =?utf-8?B?dzFmYjV4NFBCaXh4SGlld3BiSk40SzkxVHgrcmo3U1NvdlNiQ2FwUzJ1L0NK?=
 =?utf-8?B?VEZwR25kNll2QXNqV211cWQ2ZnovRUFhdy9WME4xeTJMUDZxbjgrTGlMR2ZY?=
 =?utf-8?B?NUdQcWR5RG4vZ3E5UVExTWtSaVZ6V2pwSDl5ZXh2TjY1YzRnbEMvUzg0UVBE?=
 =?utf-8?B?ZHRtUFNxVVBSR1hkV250TWdBUVZQNjFBWXY4V1BpMDMvQ3NGSnExbWlxMU96?=
 =?utf-8?Q?Uqs3LFBBMqqL8pJqBp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 116ba247-60ab-4725-0c19-08df17aea5fd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 07:04:58.8751 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wa/z6BgYObBFVgzsUQOvdqoD9tQOmVgFrUhdRtf88DWRRlKXi0nkbO1NKWeBe666
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5734
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

On 8/31/26 08:00, Vivek Kasireddy wrote:
> Since udmabuf allows users to pin pages in memory, which is a vital
> resource, we need to ensure that unprivileged users cannot abuse
> this feature to exhaust system memory. To address this, introduce
> mlock accounting for udmabuf pages/folios. This change ensures that
> the number of pages/folios pinned by udmabuf is tracked and limited
> based on the user's mlock limits.
> 
> If an unprivileged user/process exceeds their mlock limit, no pages
> are pinned and EPERM is returned to the user. Note that, privileged
> users/processes (CAP_IPC_LOCK capable) are exempt from this limit,
> allowing them to pin pages without any restriction.
> 
> Earlier, there was a 64 MB default limit on the size of udmabuf
> allocations, but it was removed in commit 44e9eb5a7621
> ("dma-buf/udmabuf: Disable the size limit by default") which left
> open the possibility that unpriviledged users could pin unbounded
> amount of memory. This change makes the limit dynamic, by invoking
> user_shm_lock() to check the mlock limit for unprivileged users.

That makes no sense at all and would create a massive problems.

The mlock limit is per process, but udmabuf is represented by a file descriptor which can move between processes.

So this here can be trivially abused to account the allocation to one process while accounting the free to another process and overflowing the mlock housekeeping.

What could potentially work is to grab a reference to the cred structure of the allocating task, but that is also not the nicest thing to do.

Regards,
Christian.

> 
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Cc: Gerd Hoffmann <kraxel@redhat.com>
> Cc: "Christian König" <christian.koenig@amd.com>
> Cc: Robert Mader <robert.mader@collabora.com>
> Cc: Xaver Hugl <xaver.hugl@kde.org>
> Fixes: 44e9eb5a7621 ("dma-buf/udmabuf: Disable the size limit by default")
> ---
>  drivers/dma-buf/udmabuf.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
> index 7c4339130eff..e78947f01656 100644
> --- a/drivers/dma-buf/udmabuf.c
> +++ b/drivers/dma-buf/udmabuf.c
> @@ -203,9 +203,10 @@ static __always_inline int init_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
>  	return 0;
>  }
>  
> -static __always_inline void deinit_udmabuf(struct udmabuf *ubuf)
> +static __always_inline void deinit_udmabuf(struct udmabuf *ubuf, pgoff_t pgcnt)
>  {
>  	unpin_all_folios(ubuf);
> +	user_shm_unlock(pgcnt << PAGE_SHIFT, current_ucounts());
>  	kvfree(ubuf->pages);
>  }
>  
> @@ -217,7 +218,7 @@ static void release_udmabuf(struct dma_buf *buf)
>  	if (ubuf->sg)
>  		put_sg_table(dev, ubuf->sg, ubuf->sg_dir);
>  
> -	deinit_udmabuf(ubuf);
> +	deinit_udmabuf(ubuf, ubuf->pagecount);
>  	kfree(ubuf);
>  }
>  
> @@ -385,6 +386,15 @@ static long udmabuf_create(struct miscdevice *device,
>  	if (!pgcnt)
>  		goto err_noinit;
>  
> +	if (!user_shm_lock(pgcnt << PAGE_SHIFT, current_ucounts())) {
> +		pr_warn_once("%s: User not permitted to pin more than %lu KB "
> +			     "of memory, either increase ulimits -l, or "
> +			     "obtain CAP_IPC_LOCK capability\n", current->comm,
> +			     rlimit(RLIMIT_MEMLOCK) >> 10);
> +		ret = -EPERM;
> +		goto err_noinit;
> +	}
> +
>  	ret = init_udmabuf(ubuf, pgcnt);
>  	if (ret)
>  		goto err;
> @@ -441,7 +451,7 @@ static long udmabuf_create(struct miscdevice *device,
>  	return ret;
>  
>  err:
> -	deinit_udmabuf(ubuf);
> +	deinit_udmabuf(ubuf, pgcnt);
>  err_noinit:
>  	kfree(ubuf);
>  	kvfree(folios);

