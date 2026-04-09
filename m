Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADB56EA3C4E
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 12:18:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1D62A10E7E5;
	Thu,  9 Apr 2026 12:18:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tvzN9WBE";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011050.outbound.protection.outlook.com
 [40.93.194.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 104A810E7E4;
 Thu,  9 Apr 2026 12:18:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A/NbIOvLmmgDHgn/Gl6QXlJmv6/6cyLTUNr45/YXOjyh0YqfbVp5x51rz0mdKZj80beREOihjTbQlxqk2N9vH5tyd1V+UKhm6hVwA3UKHG8Mzohs6wvNy/UzmhZy0YknGEWyse+nt4sbY4b/dU4BL1pqgLaCpWqoHkoAiY9EI5ZoYlKaxSX/HQmcJDfOSJHzI9+HOSAnMmOlYuhRlYwui3d+3/8GqHRGbURozGAwLqnaZ103Mko2wbLL1Ej9xr18pDLtAEcHH7BLxct49cMCMvdfQ4KwVYTT9H5AyUZeYoSQuMU2Z/EPcXxLHnfrdXkugLOvWOuib5wt4SqTNEdHng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLI1lG4bhD9d9Es4DDYkgeHQFX8G09/+uWJ62/nOhpY=;
 b=aVYe4Ukf1LzCRqw8UGbVuCdUYlfU8azTY0bR3I3vvkQ8d+wvQ3IWPGQYtgDzZA90IIppxYfanK5OPkuwWbx5JV+w+i854gxKc4n3sk/oxns5n6QUuU4hamVlLleg8TuYisjezRuaMpXw3OPIdGNfCYfwTHI8pHCJU74E3bHeNlWsk8VwtIXGEBXNUAf+HMHeZ8DEs1D9gM7IK3vfif7CCWiSCI+AEIYSdrieWhlvOVSnACb7inKh+lWygWq20dwQQS4N53QrdK16F8pjfA2oBJjJ3YkrubhhGEwta/6/GFXT6sJC0rWXupnZnmvO/eWNXYt9yxP9dgBchu0OStTasw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WLI1lG4bhD9d9Es4DDYkgeHQFX8G09/+uWJ62/nOhpY=;
 b=tvzN9WBE2aHYoooBGJmsJ+j3jmASnn88SnA09H1iLZ3LO4+SkKS10DYTKNwLBp7LTDueIMhS2ffN8cinzGtKPPBPMxBjbHo+61nwmqRn3CXW+2WjXZKvkBwbU7A/bChnUde9oUyirhjQYgzHsmAzGQ5Kd7VhxYHbfEr7DCpu9e4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by IA1PR12MB6115.namprd12.prod.outlook.com (2603:10b6:208:3e9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9791.32; Thu, 9 Apr
 2026 12:18:17 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 12:18:17 +0000
Message-ID: <5d4f532f-e8fa-45f0-923a-d148e609b663@amd.com>
Date: Thu, 9 Apr 2026 14:18:11 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/ttm/tests: fix lru_count ASSERT
To: Matthew Auld <matthew.auld@intel.com>, intel-xe@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org, Matthew Brost <matthew.brost@intel.com>, 
 Dave Airlie <airlied@redhat.com>
References: <20260409111032.72141-2-matthew.auld@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260409111032.72141-2-matthew.auld@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR2P281CA0152.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|IA1PR12MB6115:EE_
X-MS-Office365-Filtering-Correlation-Id: f8fe83be-e558-4b5a-fdf3-08de9632145c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 2TCNkhBN6GsBR/7bAUOOozRMmRuGK3v9KG33EWe0rLCTRF/K2ZkWEndmSerLB9zNBwaT5LNDOudPpMhVhE7k3va18lWzZKV9mfFwSuTLMQ0H8roTRFalo3ap91HGORsiuvOp6VHCOKh297NJ0afAkeZh3+Z09NSOWE7Pf1DeqO3PRyAsQMi2Uw/0zqtZvBve1dp3mElGlg7trsRHyivbPg4IvP1eZXkh0f49VFzWJuOZhozWSyOL9pOEf/8C9cW8ly2oHcV8khsWnwthERSGnpUwvK0+I8f0DRpF6LVd0qF4SaHIyzUkNC/NhshA+KvIl/kAc6bgI4prGFvQ6RN/Pr3Dmu7crBoomnFVUmjPOHLC0qWrp1IaYZIsoLmbrDuVDkebhMbTCkg7A29mDE37/g/p2VHajeCoqJZ4BrzMjraWWYE049oCqUyO8uFNcl7oOqipbJ0N7AfvM+u9VPBR583b4HxU9f3Bi7TswIj74gWR1Sq7G4orRgXy/SlqHyl/Ja+NxmdTcGGEL+TzQwFjiFPe3ok1R7ghffulTYmUtVRMa0v6Aefh90b2SU+eyMdHbkDocBgiLXkKgfZH4ixZOGDNjyJCK1kYD49yxQ63UYrG4FZK8idjtlNImfxAnr+fTbb/LbdG9XRg1GoLc4I7Lp0C15R5AXimG+VdasTnytDB3RJkx4uY/BE1/pjs5I8PUG80G/QX0+TAtrMwV78IOSB5nRFrATKKiUhAweHsqY4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RWI3RnVUYU9GRUtpTlA4eXdhRzMyQkFsb0RqTFQvS1RkZncxcHphVURlN3FS?=
 =?utf-8?B?TVpoc05TOWg0NFpHNVNsejEvaXFxbitETDhRZkdJRDFSOG1aUFE1eUkvVXdE?=
 =?utf-8?B?UWYwK2l0SVU4RkFseE1EYVcyR08yUnVWOW9ITEFQQitUVVZNdXVDaEpWeTZ0?=
 =?utf-8?B?c3lSZlg3Tm0xd1VEVDRnb05FMjZTc2ZnaHVGTCtGdkZicDdSNnk1U3RGSzVV?=
 =?utf-8?B?SVlremMxSUd1dGpQUE5FQ3c1V3Y0elkzb2drakJhY0dtTUpOMXJxUnZyeVU4?=
 =?utf-8?B?QjA4c3JaelR6QnkycjZtMklkYSt3MjZ2d3V6VzVCVkRIY2NKSzlSL2U4a1JS?=
 =?utf-8?B?R2xRbUt5NVovRnVYOFZiVjVsaVA0VEVWSktHRVlXN25sbDdWMDREbC9ldmhi?=
 =?utf-8?B?L09PRzVYMUxHYUhJZlB0akg2b3Z5a0Foc2tKbkVxdGFoM01sUkpWVkpFaUoy?=
 =?utf-8?B?ZnpVNmkyUXFiYkZQR3ZObVhNZFBDQytOZHgvUTRXYlFPQVhRRWZKRS96SDNB?=
 =?utf-8?B?MGd0YWZqMThXT2dXeG5SRjJXTk5mQnYwNmphYjhJcjBRb3FzS0JQZnpZSDVv?=
 =?utf-8?B?anlzYlJNaGtRbVlkWnN5S2Q5Z1NKOGoxeFpRYTAyNzh4bVdlT1NnRnZoN203?=
 =?utf-8?B?SmxjUnh6bWh5b0xWdVBUVHN4bkQzcUJBdndTbkxJeG5PeGd5ZXBwWUUrK2hY?=
 =?utf-8?B?dHIwUDNKNThVbllKek12QnVjTU9JUDVkQUlXMGtPc0c3VzBYU2JRblVYdWR6?=
 =?utf-8?B?c09oZ1Z1S1NwMXgraGlxWHcrNVVkZTR5NWtiZlVjSTh4TnBzaGtSWk9vTWRm?=
 =?utf-8?B?VDhDWGhGOGJ5NkRlRlRKWnRiS01PMEZLTnBkd2JyRk9ZQlVHa1kwV0M1NWlz?=
 =?utf-8?B?aFpPNWY0S09OMGpsTXdjSGFQd2Vjbkh2MFN1dHNTYlQ0bTJmSnRmWFR0WFpI?=
 =?utf-8?B?cUdlRDZVNnZFQkRRMVFDSGdaeWowTUlIelJGQXEwbXZscS8zUXlLN3BOa25I?=
 =?utf-8?B?RHVydUp3M1l5OFltUkNDbGJKRnhzaE5TTDJSdUZoRmxPM2xNZXV5Y2hzcDJR?=
 =?utf-8?B?QUlqRTRtTGswWWh0NFFuSk5JdVlRRS9wV2d3UHVNQ29HOG9aYTArRWQ2SkxD?=
 =?utf-8?B?akFCNFdmU2pWcnJhRlV2S2NBZmRsVUVTem40cmE5UCswK2NFMHVyakZnQmZp?=
 =?utf-8?B?Z045R0JReC9OUUJISmlReHpxZmg5aEk5TTBhdGZlZzVITDRoVWswZUlHYXRN?=
 =?utf-8?B?d1dxajB1NFhyN0tqMUVoSjBlWlMxbU1nQmtaNks1ZDNWVzRlbmxzeExJUWFr?=
 =?utf-8?B?M3hkZUNzOU1LWkVCNnVBQTdFakQzTkxQeVpCSWNUTkV1RGhaMndiR29IL1Fu?=
 =?utf-8?B?MGpjOGNFRjd3WjJEUUd6RTZRU2c2WVBsU0R4c3NyY3VuQkFQbmxKNkRWM21u?=
 =?utf-8?B?TCtFMklSaGVjR3ZTT1hMajNUa2NLVnd5VEdIWEljSXRTeVRyZkRGdmVmVDNT?=
 =?utf-8?B?b2FiVDdaYzF4OGViWmhOTTZCTnpBbDRLeFYxc1Bxb2VudFJwUlRTVGZaTVg5?=
 =?utf-8?B?ckhpd29SQlMxMUgxOGtpb2VKYUpjVnBTdGxTellKYjM1cVpwWm92UG1KUDZo?=
 =?utf-8?B?bDFMV3JBU3pkaVJ5V3VyV2pIVzNYV2lhdGwxcC9WMzZUNzZWZ3RPbnFUVG1V?=
 =?utf-8?B?bFRkMEpuMlhvRU9Ec2RoOWRxQ0lTUUM5ekdLRDN1MDdrWiszSkw0c0JQM0E4?=
 =?utf-8?B?aW54T2t6QkYySWZXbk1zTXZaYXlLTHRJUkVqUnBXS1Nra3Q3OC9rTkltY0Fk?=
 =?utf-8?B?d1pTTm11ZWxyVHFVU3VQZjBqemMwNXhEeFNSNmZwYU9aYU9WOGNIemc2K1ZO?=
 =?utf-8?B?ZDk1UWxaRmo3RTVDcEhwR0FObmpHVnBrenRNUVZncTZYS3AwK00vZk1uSlFY?=
 =?utf-8?B?cUpXT05LMXgwcThqMUtGMWc0aTlHVDNxVlJ0QTBkNHBLRU5ZbU5CTWxmb2pZ?=
 =?utf-8?B?SklJRkhsS2pydHk2MzJnVUtIck8zRWFDZEpwejRJbzkyWEdjamE1anJCVkNr?=
 =?utf-8?B?SnY0dkNFMFVTc3ltK2JvY3BqT1JzelVzekFQWXlURFpVZThpUGFJbFIxc1Nl?=
 =?utf-8?B?OE9pcGVRbEljb2NvMVlaOCtRd00wNHFJcExRY0h6OWFMaFVCSDVMZ2Y1VkZD?=
 =?utf-8?B?cG82Zm0vWSt3cHViVmk1bmpBU0gyMlM5WDNoRUxXdW1oVEplMG0zYTB0QlUx?=
 =?utf-8?B?ZEw4RnlNa2lQcWFOeEJHNUwwNWV5Y0tyZ3V1SnF6aWlpWnl4S0hENUVDbGNn?=
 =?utf-8?Q?45lkCOpnKRJY66N92p?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8fe83be-e558-4b5a-fdf3-08de9632145c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 12:18:17.0475 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9yjnlDvsLfgz2UCtndCtb4CEqAtfDayU76kCVwNlYkM/ItR+jm5U3+U9DxBK/2IK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6115
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

On 4/9/26 13:10, Matthew Auld wrote:
> On pool init we should expect the lru_count for each node to be zeroed
> as per __list_lru_init -> init_one_lru, but here we are asserting the
> opposite.
> 
> Currently our CI is blowing up with:
> 
> 10:23:33] # ttm_device_init_pools: ASSERTION FAILED at drivers/gpu/drm/ttm/tests/ttm_device_test.c:178
> [10:23:33] Expected !list_lru_count(&pt.pages) to be false, but is true
> [10:23:33] [FAILED] DMA allocations, DMA32 required
> [10:23:33] [PASSED] No DMA allocations, DMA32 required
> [10:23:33]     # ttm_device_init_pools: ASSERTION FAILED at drivers/gpu/drm/ttm/tests/ttm_device_test.c:178
> [10:23:33]     Expected !list_lru_count(&pt.pages) to be false, but is true
> 
> Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
> Signed-off-by: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Christian Koenig <christian.koenig@amd.com>
> Cc: Dave Airlie <airlied@redhat.com>

Acked-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/ttm/tests/ttm_device_test.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/ttm/tests/ttm_device_test.c b/drivers/gpu/drm/ttm/tests/ttm_device_test.c
> index db4b4a09a73f..8bcac84e9846 100644
> --- a/drivers/gpu/drm/ttm/tests/ttm_device_test.c
> +++ b/drivers/gpu/drm/ttm/tests/ttm_device_test.c
> @@ -176,7 +176,7 @@ static void ttm_device_init_pools(struct kunit *test)
>  
>  				if (ttm_pool_uses_dma_alloc(pool))
>  					KUNIT_ASSERT_FALSE(test,
> -							   !list_lru_count(&pt.pages));
> +							   list_lru_count(&pt.pages));
>  			}
>  		}
>  	}

