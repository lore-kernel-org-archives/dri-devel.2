Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEEE7C79FB5
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 03:05:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3966710EE5D;
	Wed,  9 Sep 2026 03:05:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="nPWX1RYM";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010006.outbound.protection.outlook.com [52.101.61.6])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B79BE10E1D8;
 Wed,  9 Sep 2026 03:05:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hCUKCRJDNzxalF9a6d24eVEkpxxQ58RsHSJ/Sf858nPsv9147Y909TFQDHbJKcLBNGE5aCt8I6AewlNpgHoAw8xXdnfiyaxlXvFEzDjtlgLLP67kMvFHTu2xueVZVBaI7voU2HYCWk3XIp8rUsN9tl1QgczazbFZUo8C2BBFH4aEzZtA0RdhsxEEj0cyJJVNU2TJrA2vsIOJRxXFtSWa+Kzn5dFpSeBi6WDFxn81/Cyz4ZJ5Yp7gpSoV4xXefjW+oFuT9z34ajPgRcyPMcOn4QI6mjVXJucrXsOb+EmaTVahwFy9m2trntkmPVdSKu7o9T6Hqhq3tejDZ9GrM75s4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cE7XgqHQ6QSed6woJLAYZrsE9KbIhdZ4pKJhLki/YGQ=;
 b=P35MWYeDZJ3L/FqcsaIrWbF1zjAdkLBMfwdAUhWoY9Dd69tN82CItjToSgz019leNfxyzd8RBs/WfqkIGM6LTal9H4vrwOVmtXeGltIm1LpAv8sHRymLTQ9DBQQ1ZYuerbPzWjdFtlHg5KBfL4c5C1YDm+XcNY2tEXqTBYYw4LilQ/LTaK9yoijy74tKV7cD6JXf+nyaBfrXysK3E5LRamRRJsCcKhQT0UWFZmlR4hfQyvOYD/bOT7sgXB0slBP8EhhByn5M7DzgUAA1F7lBZab5bbP+xKDRad+pcT5FH/QuydnEX4GEGUXdJ8eJsFeesphO12yLxRfX31TQhBJkFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cE7XgqHQ6QSed6woJLAYZrsE9KbIhdZ4pKJhLki/YGQ=;
 b=nPWX1RYMxUDTi7svskghbC1okysFADkrIVUZkryAZe6m+ceypwQJ/uroLzgDJ8nz0o2P4NceHlTN0MU6H9MxSZRqyBHA0izW97Z7PkKpxTADFQ9TW/u5+BfvRxMpZaEllKlV0MllNiBR9U9dvUImbbU6As5Bu2YzknhJroPqvHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB8199.namprd12.prod.outlook.com (2603:10b6:8:de::20) by
 SA3PR12MB9089.namprd12.prod.outlook.com (2603:10b6:806:39f::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.7; Wed, 9 Sep 2026 03:04:59 +0000
Received: from DS0PR12MB8199.namprd12.prod.outlook.com
 ([fe80::fdd3:ff85:ce0b:7c27]) by DS0PR12MB8199.namprd12.prod.outlook.com
 ([fe80::fdd3:ff85:ce0b:7c27%6]) with mapi id 15.21.0406.005; Wed, 9 Sep 2026
 03:04:59 +0000
Message-ID: <c3fa041e-9da4-4ac7-93c5-c5514f78acdb@amd.com>
Date: Wed, 9 Sep 2026 08:34:53 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 3/3] drm/xe: Convert xe_user_fence to drm_user_fence
To: Matthew Brost <matthew.brost@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, Mika Kuoppala
 <mika.kuoppala@linux.intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
References: <20260908084627.352535-1-srinivasan.shanmugam@amd.com>
 <20260908084627.352535-4-srinivasan.shanmugam@amd.com>
 <aqBufwAli0Krw+s3@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: SRINIVASAN SHANMUGAM <srinivasan.shanmugam@amd.com>
In-Reply-To: <aqBufwAli0Krw+s3@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0146.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d7::6) To DS0PR12MB8199.namprd12.prod.outlook.com
 (2603:10b6:8:de::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB8199:EE_|SA3PR12MB9089:EE_
X-MS-Office365-Filtering-Correlation-Id: 327cf9ab-ac31-46e4-7055-08df0e1f227b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|6133799003|10067099003|4143699003|5023799004|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rJUBW7xRuRZEffBG3IH6fpO9AXwUyNMEeokHhr0zn5mfP2XJ2RiQl1FNUQV3CmjXlf2LHdDesabowQrhrGfwC2rpE/IiwAKRA6W8KtA3XEblTgTgxNg2kxphpC7ZTJQWt7dorg62tAU0a+t1bN1IfjmrKZs90Cw4kHFFjLsUfGxpB5qOrO4wFuGn8FXCbwq3qRmhiE4GhRyJu8AgDUXLm/r5DbLOjhkDA2SyavxB9GAs2xwWr5pw7FMWLjbTMCiaO62pymVTaoQ/lKLUUkW7AWqhOVPJ+8JUka4um1KOAYVE1fQbr+Og+bUgBEu4ZB58T4/epgt298y8itraABgDnb8i081g5b3ZyN5MnSxzV61bfpf3HEC0KDtW7/3njsIoE4g+MKlZ+K/lsWtY/CRKTTnLDOen51t0rfs2hl67/O0D76OL9tIDpZ4wzDBZSFMDMhMAjzT9+Q8w+9Q7Mf/HAnHZREHn/LZnq0LsetjWcZ/PscxbovPjI9b5dtsUOW/APIg9679USM3BFrcWUV2CnHBLriGM+fQmZVmz5MhaV70amq0amC7uWrb1XiDiDynuTY7MwVTcz1MfvNTgThJY0bOJEGH5nzUSwEtCtuONGyznszHcxcOGWDGXyafYnv/B2vIUj70lH7hJs7ajPgaMgxdGAJ6+bPoTyan7xwjuWkY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB8199.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(6133799003)(10067099003)(4143699003)(5023799004)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEtFY3VpWEFzZ1UzRlZlU1Z5cDVDWHVFZzg0NU1PTXRzMml5aFZxQWd6aFBt?=
 =?utf-8?B?M0VQTU8wZ25pQnpqc2NnVmtmOEhPR3JCMkc1eDY4Y3dOMHFpUlR6eGhlekpS?=
 =?utf-8?B?OFdFRFQxd0pwQ2FTVmkybnlBUTU2ZjliKzFQaHYwQk1hcUJaR0xIU2VsRnRJ?=
 =?utf-8?B?d05OemhEbjdhZEo3YTNHNnp6MzVTbitvOWtyYjlNVUJYaTl3ejl1a0k4aWc2?=
 =?utf-8?B?UnNrc05yWElheXRDQkt5d0xramdXREtOMTFDR3kyeDkzVFdlcHpGKzJ2Rk90?=
 =?utf-8?B?Y0dLZmZqQmZlZTZsSndHbzdyaVJhb1ZFTmJSTUkrZG81NjZWVmFQa1crcGZ2?=
 =?utf-8?B?b0ZyTkpUU2hTVUNUek9lY1M4Wjd6Tk9BM2ZKeFJjMHJPT0wzVm1PbUJPYWZk?=
 =?utf-8?B?SU90MnRuSnFmeFA2eEFLWDl3SVMvZDRQbDhoT3FCc005VlpwbHFYblA0aXZD?=
 =?utf-8?B?alF4LzYzNlRRTlZ4OVVlUVg2Y0V6OGR4UkVyaC9hczU4bk1QZFFsTVJzM3ZL?=
 =?utf-8?B?SlhsRWNhcjlWcnhTVmNTRWN2ZE5uVDhKVkU5VVNmR0U1K0VjcWlCaE9FRFMv?=
 =?utf-8?B?R3lRbGIwWklya2NndTByYUxGQUtETUhlVW8vZENkcHBXOGdXZVQ4bzUxVHd6?=
 =?utf-8?B?L2NGNFhvUlZZQ0JTL29tN1hsUVZDcC9GZEFldFpzTUJBa0FWT2hVUEl5dDlo?=
 =?utf-8?B?eE52ZHkrU2NFN2p2K1VraFp4UUV6c1BocjdtNVhQdENaRXRQM2I5Y0NQalp2?=
 =?utf-8?B?VlN0WlRwZ2NXT0RJZFZ4SlJ1dnlSQnJEQlVrczZ2Um44RE4vRDVzYWJnZjd5?=
 =?utf-8?B?eHp4RDEyMk9EVmtoTDhrTDAxektEMUlvUVQ1YkxyTTNzeFNRZHZpT2YvdGdK?=
 =?utf-8?B?WWpDTDEwcFY3N2lyM3pjU2ZCZGRsdlVEZkZlM0xJNHFYK3hNVFFlRHBxSEZQ?=
 =?utf-8?B?c3B1NGJOOVJIYnNuOWpORnZRNnl3RkxWLy8vSzhYMVMreG1CUmVQaXYrTkQz?=
 =?utf-8?B?ZGJjbFJWTmVvbmIyeGI1cko2VnlVRlVzQXlYb1RvbTFMLytGaUR6MjVlUS9X?=
 =?utf-8?B?YUNMYVN4UExWYTFZKy84YXJkTFhSaEJPOGNZMTdLaUkyeDd2VVJxbXN1KzZE?=
 =?utf-8?B?U0luSEJzSXRGWDNZSStOQklQUjJnZmJqUncrUXgrMkp0Mzc2aU91K0FTanVX?=
 =?utf-8?B?TmtGam9xbGw4T1lUa2ZLa2ZsSHRkOWxkZmtCM3kzZGwwb2pxZVdEWFRrTEZH?=
 =?utf-8?B?VVE0a2JydWhWd3V6TVdSZWVyRXJFS0RWUGtoZ09QTEVHdFVud3poYi9MV3Zm?=
 =?utf-8?B?UWEyV2x4UFhMWWlBZVFIQzBEQ1lEYXRPdWovLzBZV3BsRGR4K0krVkYveitW?=
 =?utf-8?B?RnlaQkcrYUR3RTF4ODJXYUM1ZVhPWjNjVWxIbmNOQ3F3TFk3Z0JxVGZ4cVZj?=
 =?utf-8?B?b2hiSy9jWUxUK1R2N2pJaE1yWithNmJyK2V6Smc5YjdLTnhINnFyek5sWmtv?=
 =?utf-8?B?T2hFbjBhckVFM0NLOTIvU3V2SmN2MzZXd3RMa2xXY2JPSTlFTFMweXgrbHNw?=
 =?utf-8?B?QUNEcHlUeHZEZWQvRlExbVdxYmRTekhwS3RkbllibmdOeVdaNFFKOWNmdE5y?=
 =?utf-8?B?UWtqdm1xSTZRcHlqRlhoTkl4My84Ykt4eVF6TitTU3UxN3ZBeU8zb2hCUm9m?=
 =?utf-8?B?UDI4ZWJCenJId1c2aThDMVBUeUo0Sk1DRmhiQ25Ja0ZKM2hZOFc0Y3pSYTBB?=
 =?utf-8?B?OTFlYzRnbDVIVFV4ZW1nRlRCTHRtV01xN3h1Mk9nZmJrQ0xISUovNE9KVEl2?=
 =?utf-8?B?Z1puYTVFSmhMV3BUOVBtanBhcWtaR1lMaUZvS2JvYkNZa1g2RVR1UHNHU0My?=
 =?utf-8?B?M3c0S09RZkVVNVhYRTRDbWxTQnFPclpIV28xM0RiSGYzblBpdWJ2RTJOM2RV?=
 =?utf-8?B?SkVFYktJK2VoR3hQL2FqRXFUV3dPRFZKeFF2S3hlSkN0bDdoQTR2VWJUQ2U4?=
 =?utf-8?B?bVEwdElYOHBWckVMVVVteFpNTHZ4RTE5OUZhS0pqQ3RXek05dzdNRyszVjdV?=
 =?utf-8?B?KzVOdEdjWmppcGlOKzlnSmxOZXBCZ3MyZUVKV1pjSE1jQmlieEdvcmRJVVVC?=
 =?utf-8?B?YVRCNWorSFhybXhXeVBzUVFzZmhjOGdBVVFjQ0hVVjNWQUg4WFpGMnN0b2xu?=
 =?utf-8?B?NHA3N05oRjFIaWhsTXJSZWVYa2JVWHAyNFF4aUFtMzdTRGZtUmlEMHpzN0U0?=
 =?utf-8?B?ckI4ZzU0bHhLRExubDdRYjRpbS9WaWtLbmlxUHJtNUpuRWtsMkttVFVjaHpm?=
 =?utf-8?Q?aWXx8BRyL0Oh+dkbpA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 327cf9ab-ac31-46e4-7055-08df0e1f227b
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB8199.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Sep 2026 03:04:59.6359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pX3Wgkhb9FRYn76jPexGQ9nuQ9F4pPv6+N4rYW6waghRZ2UujIC0wTUMM3SXbtGP9rfCb/GGVqRFMPtTWfUZqQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9089
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


On 9/9/2026 1:52 AM, Matthew Brost wrote:
> On Tue, Sep 08, 2026 at 02:16:27PM +0530, Srinivasan Shanmugam wrote:
>> Replace the open-coded user fence implementation in xe_sync.c with the
>> new common drm_user_fence helper.
>>
>> struct xe_user_fence now embeds struct drm_user_fence as its base.
>> XE-specific fields (xe_device pointer for the ufence_wq wake-up,
>> userspace VA, expected value, signalled flag) remain in the wrapper.
>>
>> The local user_fence_destroy/get/put/worker/kick_ufence/user_fence_cb
>> functions are removed. Their logic moves to xe_ufence_ops.writeback and
>> xe_ufence_ops.destroy, which are called by the drm_user_fence helper.
>>
>> Cc: Matthew Brost <matthew.brost@intel.com>
>> Cc: Mika Kuoppala <mika.kuoppala@linux.intel.com>
>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Cc: dri-devel@lists.freedesktop.org
>> Cc: intel-xe@lists.freedesktop.org
>> Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
>> ---
>> v8:
>> - Fix xe_ufence_worker ordering: WRITE_ONCE(signalled, 1) before
>>    copy_to_user(), add smp_wmb() before wake_up_all() (Matt,
>>    mirrors upstream fix 8ae04fe9ffc93)
>> - Rename .worker → .writeback in xe_ufence_ops (Matt)
>> - Update commit message: xe_ufence_ops.writeback (not .worker)
>>
>>   drivers/gpu/drm/xe/xe_sync.c       | 154 ++++++++++++++++-------------
>>   drivers/gpu/drm/xe/xe_sync.h       |   2 +
>>   drivers/gpu/drm/xe/xe_sync_types.h |   1 -
>>   drivers/gpu/drm/xe/xe_vm.c         |   1 +
>>   4 files changed, 89 insertions(+), 69 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_sync.c b/drivers/gpu/drm/xe/xe_sync.c
>> index 37866768d64c..c0e720cf579a 100644
>> --- a/drivers/gpu/drm/xe/xe_sync.c
>> +++ b/drivers/gpu/drm/xe/xe_sync.c
>> @@ -6,12 +6,11 @@
>>   #include "xe_sync.h"
>>   
>>   #include <linux/dma-fence-array.h>
>> -#include <linux/kthread.h>
>> -#include <linux/sched/mm.h>
>>   #include <linux/uaccess.h>
>>   
>>   #include <drm/drm_print.h>
>>   #include <drm/drm_syncobj.h>
>> +#include <drm/drm_user_fence.h>
>>   #include <uapi/drm/xe_drm.h>
>>   
>>   #include "xe_device.h"
>> @@ -19,36 +18,65 @@
>>   #include "xe_macros.h"
>>   #include "xe_sched_job_types.h"
>>   
>> +/*
>> + * xe_user_fence wraps drm_user_fence with XE-specific fields.
>> + * The drm_user_fence base handles MM borrowing and work-item lifetime.
>> + */
>>   struct xe_user_fence {
>> -	struct xe_device *xe;
>> -	struct kref refcount;
>> -	struct dma_fence_cb cb;
>> -	struct work_struct worker;
>> -	struct mm_struct *mm;
>> -	u64 __user *addr;
>> -	u64 value;
>> -	int signalled;
>> +	struct drm_user_fence base;
>> +	struct xe_device     *xe;
>> +	u64 __user           *addr;
>> +	u64                   value;
>> +	int                   signalled;
>>   };
>>   
>> -static void user_fence_destroy(struct kref *kref)
>> +static void xe_ufence_worker(struct drm_user_fence *base, bool mm_ok)
>>   {
>> -	struct xe_user_fence *ufence = container_of(kref, struct xe_user_fence,
>> -						 refcount);
>> +	struct xe_user_fence *ufence = container_of(base, struct xe_user_fence, base);
>>   
>> -	mmdrop(ufence->mm);
>> -	kfree(ufence);
>> -}
>> +	/*
>> +	 * Mark signalled before the userspace write so that if userspace
>> +	 * observes the written value and immediately issues a VM unmap,
>> +	 * check_ufence() will see signalled=1 and not return -EBUSY.
>> +	 *
>> +	 * NOTE: copy_to_user() may block if userspace backs the address with
>> +	 * userfaultfd or FUSE. Drivers requiring non-blocking semantics should
>> +	 * use a dedicated workqueue instead of xe->ordered_wq.
>> +	 */
>> +	WRITE_ONCE(ufence->signalled, 1);
>>   
>> -static void user_fence_get(struct xe_user_fence *ufence)
>> -{
>> -	kref_get(&ufence->refcount);
>> +	if (mm_ok) {
>> +		if (copy_to_user(ufence->addr, &ufence->value,
>> +				 sizeof(ufence->value)))
>> +			drm_dbg(&ufence->xe->drm,
>> +				"copy_to_user failed, user fence wasn't signaled\n");
>> +	} else {
>> +		drm_dbg(&ufence->xe->drm,
>> +			"mmget_not_zero() failed, ufence wasn't signaled\n");
>> +	}
>> +
>> +	/*
>> +	 * Ensure both signalled=1 and the fence value written by copy_to_user()
>> +	 * are visible to all CPUs before wake_up_all() wakes waiters. Without
>> +	 * this barrier, weakly ordered architectures (e.g. ARM64) may allow
>> +	 * waiters to observe the wakeup before seeing the updated values.
>> +	 */
>> +	smp_wmb();
>> +	wake_up_all(&ufence->xe->ufence_wq);
>>   }
>>   
>> -static void user_fence_put(struct xe_user_fence *ufence)
>> +static void xe_ufence_destroy(struct drm_user_fence *base)
>>   {
>> -	kref_put(&ufence->refcount, user_fence_destroy);
>> +	struct xe_user_fence *ufence = container_of(base, struct xe_user_fence, base);
>> +
>> +	kfree(ufence);
>>   }
>>   
>> +static const struct drm_user_fence_ops xe_ufence_ops = {
>> +	.writeback = xe_ufence_worker,
>> +	.destroy   = xe_ufence_destroy,
>> +};
>> +
>>   static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
>>   					       u64 value)
>>   {
>> @@ -63,51 +91,22 @@ static struct xe_user_fence *user_fence_create(struct xe_device *xe, u64 addr,
>>   	if (!ufence)
>>   		return ERR_PTR(-ENOMEM);
>>   
>> -	ufence->xe = xe;
>> -	kref_init(&ufence->refcount);
>> -	ufence->addr = ptr;
>> +	ufence->xe    = xe;
>> +	ufence->addr  = ptr;
>>   	ufence->value = value;
>> -	ufence->mm = current->mm;
>> -	mmgrab(ufence->mm);
>> +	drm_user_fence_init(&ufence->base, xe->ordered_wq, &xe_ufence_ops);
>>   
>>   	return ufence;
>>   }
>>   
>> -static void user_fence_worker(struct work_struct *w)
>> -{
>> -	struct xe_user_fence *ufence = container_of(w, struct xe_user_fence, worker);
>> -
>> -	WRITE_ONCE(ufence->signalled, 1);
>> -	if (mmget_not_zero(ufence->mm)) {
>> -		kthread_use_mm(ufence->mm);
>> -		if (copy_to_user(ufence->addr, &ufence->value, sizeof(ufence->value)))
>> -			XE_WARN_ON("Copy to user failed");
>> -		kthread_unuse_mm(ufence->mm);
>> -		mmput(ufence->mm);
>> -	} else {
>> -		drm_dbg(&ufence->xe->drm, "mmget_not_zero() failed, ufence wasn't signaled\n");
>> -	}
>> -
>> -	/*
>> -	 * Wake up waiters only after updating the ufence state, allowing the UMD
>> -	 * to safely reuse the same ufence without encountering -EBUSY errors.
>> -	 */
>> -	wake_up_all(&ufence->xe->ufence_wq);
>> -	user_fence_put(ufence);
>> -}
>> -
>> -static void kick_ufence(struct xe_user_fence *ufence, struct dma_fence *fence)
>> +static void user_fence_get(struct xe_user_fence *ufence)
>>   {
>> -	INIT_WORK(&ufence->worker, user_fence_worker);
>> -	queue_work(ufence->xe->ordered_wq, &ufence->worker);
>> -	dma_fence_put(fence);
>> +	drm_user_fence_get(&ufence->base);
>>   }
>>   
>> -static void user_fence_cb(struct dma_fence *fence, struct dma_fence_cb *cb)
>> +static void user_fence_put(struct xe_user_fence *ufence)
>>   {
>> -	struct xe_user_fence *ufence = container_of(cb, struct xe_user_fence, cb);
>> -
>> -	kick_ufence(ufence, fence);
>> +	drm_user_fence_put(&ufence->base);
>>   }
>>   
>>   int xe_sync_entry_parse(struct xe_device *xe, struct xe_file *xef,
>> @@ -282,24 +281,15 @@ void xe_sync_entry_signal(struct xe_sync_entry *sync, struct dma_fence *fence)
>>   	} else if (sync->syncobj) {
>>   		drm_syncobj_replace_fence(sync->syncobj, fence);
>>   	} else if (sync->ufence) {
>> -		int err;
>> -
>>   		drm_syncobj_add_point(sync->ufence_syncobj,
>>   				      sync->ufence_chain_fence,
>>   				      fence, sync->ufence_timeline_value);
>>   		sync->ufence_chain_fence = NULL;
>>   
>>   		fence = drm_syncobj_fence_get(sync->ufence_syncobj);
>> -		user_fence_get(sync->ufence);
>> -		err = dma_fence_add_callback(fence, &sync->ufence->cb,
>> -					     user_fence_cb);
>> -		if (err == -ENOENT) {
>> -			kick_ufence(sync->ufence, fence);
>> -		} else if (err) {
>> +		if (drm_user_fence_add_callback(&sync->ufence->base, fence))
>>   			XE_WARN_ON("failed to add user fence");
>> -			user_fence_put(sync->ufence);
>> -			dma_fence_put(fence);
>> -		}
>> +		/* fence ref consumed by drm_user_fence_add_callback */
>>   	}
>>   }
>>   
>> @@ -434,6 +424,34 @@ void xe_sync_ufence_put(struct xe_user_fence *ufence)
>>   	user_fence_put(ufence);
>>   }
>>   
>> +/**
>> + * xe_sync_ufence_cancel() - Non-blocking cancel of user fence callback
>> + * @ufence: user fence reference
>> + *
>> + * Attempts to cancel the pending callback without waiting for the worker.
>> + * Safe to call while holding dma_resv_lock or vm->lock. If the callback
>> + * has already fired, the worker runs independently — xe_ufence_worker
>> + * only accesses device-level and userspace resources, both safe after
>> + * VMA teardown.
>> + */
>> +void xe_sync_ufence_cancel(struct xe_user_fence *ufence)
>> +{
>> +	drm_user_fence_cancel(&ufence->base);
>> +}
>> +
>> +/**
>> + * xe_sync_ufence_cancel_sync() - Cancel user fence callback and wait for worker
>> + * @ufence: user fence reference
>> + *
>> + * Cancels any pending dma-fence callback and waits for the worker to fully
>> + * complete before returning. Must be called during teardown before freeing
>> + * any resources accessed by the worker.
>> + */
>> +void xe_sync_ufence_cancel_sync(struct xe_user_fence *ufence)
>> +{
>> +	drm_user_fence_cancel_sync(&ufence->base);
>> +}
> This is unused in this patch.

Agreed — it has no caller in this patch. Will remove in v9.


>
>> +
>>   /**
>>    * xe_sync_ufence_get_status() - Get user fence status
>>    * @ufence: user fence
>> diff --git a/drivers/gpu/drm/xe/xe_sync.h b/drivers/gpu/drm/xe/xe_sync.h
>> index 6b949194acff..b5ff3387c592 100644
>> --- a/drivers/gpu/drm/xe/xe_sync.h
>> +++ b/drivers/gpu/drm/xe/xe_sync.h
>> @@ -44,6 +44,8 @@ static inline bool xe_sync_is_ufence(struct xe_sync_entry *sync)
>>   struct xe_user_fence *__xe_sync_ufence_get(struct xe_user_fence *ufence);
>>   struct xe_user_fence *xe_sync_ufence_get(struct xe_sync_entry *sync);
>>   void xe_sync_ufence_put(struct xe_user_fence *ufence);
>> +void xe_sync_ufence_cancel(struct xe_user_fence *ufence);
>> +void xe_sync_ufence_cancel_sync(struct xe_user_fence *ufence);
>>   int xe_sync_ufence_get_status(struct xe_user_fence *ufence);
>>   
>>   #endif
>> diff --git a/drivers/gpu/drm/xe/xe_sync_types.h b/drivers/gpu/drm/xe/xe_sync_types.h
>> index b88f1833e28c..67048199b070 100644
>> --- a/drivers/gpu/drm/xe/xe_sync_types.h
>> +++ b/drivers/gpu/drm/xe/xe_sync_types.h
>> @@ -12,7 +12,6 @@ struct drm_syncobj;
>>   struct dma_fence;
>>   struct dma_fence_chain;
>>   struct drm_xe_sync;
>> -struct user_fence;
>>   
>>   struct xe_sync_entry {
>>   	struct drm_syncobj *syncobj;
>> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
>> index b01f31ed4417..fbd2c28de8a6 100644
>> --- a/drivers/gpu/drm/xe/xe_vm.c
>> +++ b/drivers/gpu/drm/xe/xe_vm.c
>> @@ -1181,6 +1181,7 @@ static void xe_vma_destroy_late(struct xe_vma *vma)
>>   	struct xe_bo *bo = xe_vma_bo(vma);
>>   
>>   	if (vma->ufence) {
>> +		xe_sync_ufence_cancel(vma->ufence);
> This is a behavior change in this patch. Why is this change?

The cancel was added defensively to prevent the user fence worker from
running after VMA teardown, since the concern was that the callback
could fire during or after xe_vma_destroy_late() and access freed
resources. However, you are correct that this is unnecessary —
xe_ufence_worker only accesses device-level resources (xe->ufence_wq)
and the userspace address via copy_to_user(), and does not touch any
VMA-specific state. So the worker is safe to run after VMA teardown,
exactly as the original code allowed. Will remove the cancel call in
v9, keeping only xe_sync_ufence_put().

Srini

