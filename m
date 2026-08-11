Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80186C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:09:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 99AAB10E31F;
	Tue, 11 Aug 2026 12:09:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="M8Ed2EC0";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013062.outbound.protection.outlook.com
 [40.107.201.62])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D674E10E31F;
 Tue, 11 Aug 2026 12:09:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/L+3jt+3PVjwg4KvHvVtESawUH+GzR2Avsl0knzMPTxkGZzQtgNJPJnHZdONWCZeJoRRsNPDhlywWdzPs/IlsmUYkqQU6HEk+9HWveqy9g+pmNqZt850PGHtd7D1qabDH+FnXYnkJzGKTOoaVX7r1MD2iid81LvStsEJzgH5dX7nPZY0uSbIVa7EjuWMIlB2mgmOJEjIAxLUMAoEJZWowDh8J1/RpYVe8nPW/yyDwYXGDuO3Dv0MfY88zK5bD9m9ioe419npIOV0xxi/z/7oYKJZkI7ar93TQQIeQQ4TA0gXQwhi3BGNDNLSjDcuHW3XMcPT1EDKsYu6w66NwmS2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+3RhzQj1ouwoOocv3QYNikSv1qMjEICw5Awa8u8A2Y=;
 b=I9XSTpzYV9XDu8WRfvJiZer5CgUJgCfY9OFSDjA/OD6WvT75tjaGDRFTQMUusIsFlIFTmtyfQmq1vcYkYtiPwrdDEX4NMvRHRimAYI06hsDTQyfMoLxBtVnXMh+g7OaKpQrqsS5N/KKUG9HWqAakyo2Z1E6+aNlNoJD6vJG7uw/EioguCLD+wt8fzoLdkf1FSfjH3fA0E0oHIyD84b/UKFFZpjzEMpTWLi8Dzi0/Q2Ex8meI36bi/OcbzUtEU7Lgb9O8oFi4luSulseZFgwcvjE0TE7wEQB8l9YfmYUmlDCrip+SIRMNb1/gwRV/Qt+i2h1co449sKDVF0wpV0tHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+3RhzQj1ouwoOocv3QYNikSv1qMjEICw5Awa8u8A2Y=;
 b=M8Ed2EC0eMT3ljfeo1qW+I5MeyFFNGbzhyS4LQY7B9I5lC/6zvvdm8iblAqvs9EgYvQBQh3HrJQ4e+GRuAjoHy9Oi8hsZM9S0xtZ3FDKHQC9kmv83WpUdQ+N87G7CFS4aiR1NTrqL9BDtGt5vW0/WytD8cjAem/0v8xtzs+lJqU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB5039.namprd12.prod.outlook.com (2603:10b6:5:38a::18)
 by IA1PR12MB8192.namprd12.prod.outlook.com (2603:10b6:208:3f9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Tue, 11 Aug
 2026 12:09:28 +0000
Received: from DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d]) by DM4PR12MB5039.namprd12.prod.outlook.com
 ([fe80::762:6408:ca99:701d%3]) with mapi id 15.21.0292.024; Tue, 11 Aug 2026
 12:09:28 +0000
Message-ID: <241984ef-1b3a-4e52-8192-168a1489ee7f@amd.com>
Date: Tue, 11 Aug 2026 17:39:22 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] gpu/tests/buddy: add dirty tracker performance
 KUnit test
To: Matthew Auld <matthew.auld@intel.com>, christian.koenig@amd.com,
 dri-devel@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: alexander.deucher@amd.com
References: <20260731070741.2654251-1-Arunpravin.PaneerSelvam@amd.com>
 <20260731070741.2654251-2-Arunpravin.PaneerSelvam@amd.com>
 <2526801e-1fdf-4386-8f48-99afb5f083a6@intel.com>
Content-Language: en-US
From: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
In-Reply-To: <2526801e-1fdf-4386-8f48-99afb5f083a6@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0055.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::11) To DM4PR12MB5039.namprd12.prod.outlook.com
 (2603:10b6:5:38a::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB5039:EE_|IA1PR12MB8192:EE_
X-MS-Office365-Filtering-Correlation-Id: 514f959f-9c2d-4f1e-edd5-08def7a16485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|4143699003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: s/isGNtEQGa+35dzAW0rUftDmt2WOgGYBBds9eGL9BfIC+g5ufNzlYxDy5q83PURgeDWIvcy5dANLsrgCNKMdoFbZoWMULS/WK8PZ7IvlU5uvLhdl9Bq4ToO9XZwrHDxSWR6pZ4wOes0lX83BK9oAo6Ct2Tei+325wNA8rFuh/FAvwlYpfYuw5Thh2NdtmqoxYZbrAAt2L/G5DBtJHzvX+G/P7hJ0fC8Bh60KUYCiXVBSMO/fp03X1V1MgXTHM0Ay3JSeCA8cg730rjKnFP69NeZZGWRc9P+47Gb55cWwLriZTlxEdg5955sTywReZ4fBRWMO9wjaGaVPlULxjXXkr8CFnoCQTQBoTgQz3kOoo8GBFVdKT0SoSL1Hs39zWr+sJocvM0OyEeC6er4gz2r2+C7jhI2mVOMVliPz4lgfOgaer9Zq8uG7wemJJWJWTfSPBdgxVYaI3v1yrnWeyRzpeyAfvhMDL5GwKfDN+fib46qIKV8delrNF9kQ3vbd63VcpL9PlhICHRhXaOoplIwP0+YIsgAvq/2aU6RaTpYQvGMBMsWVTGmiEVh9c1nkkqW8Vs3DcrdIY/CwWlZw7QvtHk8JzE16cTnQ9NOKCXHUYo+ByO9QrLZb4QQPqC2xF15vVPQLKwTztwnRUiWpUJNNmfCoQdhl98hXFnk4CCGGy8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB5039.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(4143699003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNjRDBDWFZMUXgvM1VnaWRtL3FpeFMyNkg1UWxzam9TMjdyOThEcDdPUnlO?=
 =?utf-8?B?YVh6Zk4yYmZTOXROK24xQ3JuemZVNjRpOUVrRElOL2NsSGd0VTNHOTlsWjJD?=
 =?utf-8?B?VW44LzdBK2R4OVM4NjNOYklENDM4UlM0dmpBT2JHd1BSV056RkYyTHp5dXJq?=
 =?utf-8?B?Zm4wZWhFS1NQMDVaaGNubFI4NGhGVnBzTkJMeHluNVJ1UjUyNSsvYnh2aFJz?=
 =?utf-8?B?KyszV1BBSk9IZC9NTU02bERJSHYvWjQxSGxXREIyaTc5QXkwclJKcXdOa0h5?=
 =?utf-8?B?TkpOL1UrZFFWWCs1LzQyZFM2OE5oaC9nWVV4TTZHa3ZZNXV6bGl0NFJZVkll?=
 =?utf-8?B?YTNsT0ZueGtrd1UwWld4SDJMRisyV0JpSDlYRDhLWkwrdTE0Y0NvRU51elZj?=
 =?utf-8?B?ejJBYy9aNUovT1l3cjBvNjVaaGZlQU1lVFJXdXV5clkyczdvZzd6WjFRbGtU?=
 =?utf-8?B?NlVkS0JqQkxsU0hCUXRwdStGa2U5ZGdyLzlpcjBFR2prV2xjTmI3RDFtQUI4?=
 =?utf-8?B?RW5LTGVnTWlRM0svUHZYNWoxb3JVdTJjNVUzemxlN25TMEVjNzF2d1l4SWRT?=
 =?utf-8?B?VG1DczhmbXQzakdHa29idFROMEdRVmpISElIVExXRFJQUG8wOTJDOWM5d3NG?=
 =?utf-8?B?VEZTbTNMNjMzczJtMEhENXNHYWkvTys0SkxTRThQOVNyTXQ2dkFNU2paMmpD?=
 =?utf-8?B?d3lJM0lNYk8reUIrZ2VmdmV2cUpSYUJ6ZWsvdW1ZSndrZnQyOWs4NzZyOW9D?=
 =?utf-8?B?VW4rb1FPSnFqemYvZHBJb0hmaGc3NUFtZGpqeno2VGNXYUVHYVJha2hiSHZY?=
 =?utf-8?B?TC91VUZTdFhwOGorRDI0SDFzT3J3WkQyN1VDZWVaZGxjWWNLUURWUUk3Rmd1?=
 =?utf-8?B?OWxaQXlHV0pQUEhMWEs4enNqMTRmUnpVZzhEM3VSS2VacGFsRE9XZWRiN1J2?=
 =?utf-8?B?T21BOUkzbEtPd01CUTdkZ0RsMHdpaWNYZTd6Y1Zycy93R1d1Z2hNVmxuUVRK?=
 =?utf-8?B?bm5CT09SYVRPME1FeDFyR3NrRTgzalM0V043RE5zdXVBSXIwVzErcVcxM2pz?=
 =?utf-8?B?aExvSHBMQVJpY0dHNnFnN2ZUaFBHMUozOEpaMG5FRDF3U2UvditYSmNheFox?=
 =?utf-8?B?Zmd4S1hzMFBlUTFCS05xNHY0NDJBRlpZc0N4cVY5RlBDT0FNT1R1a2VidFU3?=
 =?utf-8?B?ZWxuNDhJUmFoUVpJMk5saXJKek5aOStmcC9ZbzZkM3ZOTHpVa21RcDRzTEdG?=
 =?utf-8?B?SzltQ3BMWEp0STlPQ21zU1JmRVduaEU3a08wZjVLVUp0SkNnTmNPQ0dENkY0?=
 =?utf-8?B?VXJUdzNuYkMxQjYvcGFQZlU1dlo5eHR5RW1ZME4wTndvQjBUQ3h5clNPYjFN?=
 =?utf-8?B?NHVyRjlJNDNmTWdFdDFsTFhHUWlKM0dTL0drQWl1eld1dzRNQ1F0Q1prREI0?=
 =?utf-8?B?QmNiVzN3Q3ZFQnJTQ21IWTZKanFEY1gwTVNjM25qaDlkQTJDcVlOd0dVOVJa?=
 =?utf-8?B?OC8rV0FycHlaTnJGRDM5dHJEa3BqMEozTmtHemV6RmxnVFpvc21MM1R5RWRz?=
 =?utf-8?B?K3VOeDFEbXlsZ1VvWGgySkd3bGh2UVAvWXlMZHAycmNqalRUOXNVKzhsZ3RK?=
 =?utf-8?B?WE1pZjZYOUhjTmlqSW03Wng5enVOeTFMZ01xbm91KzRlckxZQ0xKeFcwcC9i?=
 =?utf-8?B?TDQ2bVNZU2lsR1IxTlhCdHB1ZkxOb1hJUDd1ZkNKaE41VUk0UjJGUHFhU3F6?=
 =?utf-8?B?ckVpbi9wOWhuSFl4Y2o5SDVyUVVyL3JxLzI4T2pSNHdYMVVETHZLeGxWVDVW?=
 =?utf-8?B?eWdjV1JkRGxrSGdiRS81bDgrNHM0UWdZR2dtYlZOZUNYNWw5WWV2OHIvT21l?=
 =?utf-8?B?MHVGY1RaR1JEaFZMNi9CdjlBTDZIeklwVUc1M01WYlJLa3VjTmpaejZSSTE3?=
 =?utf-8?B?SUREOUFwa2hXZUExcCtTYzloMjAxejlialovYVdWUG5WUGY5bElEK3l4bEhW?=
 =?utf-8?B?QnVPQm00Mldqa2M2VWZKTWdONjVUTURsbUhwc3hwU2M4VkZFRnNnRDhUZDlE?=
 =?utf-8?B?VCt0T3d3WWlqR2NLdG9lTS9BaVlGREZMUmdSamhSTHcvdUdPTVRQRlJCcmNM?=
 =?utf-8?B?ZDdvQTVTUC9WZE93M2ozRTlzTW1GcldBTU9CSS96M3djSjRmTVdPYUpNS2Vo?=
 =?utf-8?B?Tk9yQTcwTWEveWdxUGF4WXFaNTI3TVRWeFd3SVBXYWozWGxsTE9zbllIc0d3?=
 =?utf-8?B?NzZ3ODZCVEtRQWt4L20vOUp6WjF3WkFsVWY4VWxoczBpMndDL0tFZ2lNV0l2?=
 =?utf-8?B?V003ZjZWbENDOGVha2lleXhQMEhEWUlzMkYwaVdibkYycFNZYnJZQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 514f959f-9c2d-4f1e-edd5-08def7a16485
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB5039.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 12:09:28.2541 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TrTeYflLXGKlE49UhIE56S6SeaF2AMlEYETNpX3jBylqGU3ejl7JFiy7KvN/XHl9uBYgwvuJDOaI+TD75d41Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8192
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

Hi Matthew,

On 8/6/2026 9:09 PM, Matthew Auld wrote:
> On 31/07/2026 08:07, Arunpravin Paneer Selvam wrote:
>> Add gpu_test_buddy_dirty_tracker_performance to demonstrate the key
>> advantage of the decoupled dirty-tracker design over the old dual-tree
>> / force_merge approach.
>>
>> The test runs two scenarios on a 4 GiB pool after alternating
>> clear/dirty fragmentation at 4 KiB granularity:
>>
>>    1. Contiguous 4 GiB alloc: the old design requires __force_merge()
>>       to rebuild max_order from scratch; the new design coalesces during
>>       free() so the alloc is O(log N).
>>
>>         old (force_merge) - 71 ms
>>         dirty tracker design - 17 ms
>>
>>    2. Repeated 256 KiB alloc throughput: the old design pays
>>       __force_merge() on every alloc; the new design does not.
>>
>>         old (force_merge) - 95 ms
>>         dirty tracker design - 24 ms
>>
>> Assisted-by: Claude:claude-opus-4-8
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Christian König <christian.koenig@amd.com>
>> Signed-off-by: Arunpravin Paneer Selvam 
>> <Arunpravin.PaneerSelvam@amd.com>
>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Just to clarify, is this RB for the main buddy allocator changes as well?

Regards,
Arun.

