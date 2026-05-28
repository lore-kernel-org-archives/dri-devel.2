Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64D7ACD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 07:25:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD3BA10ED01;
	Thu, 28 May 2026 07:25:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lZEwKYNZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012013.outbound.protection.outlook.com
 [40.107.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA7E410ECFF
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 07:25:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jhVrfewPPqcZFNwIIfcyBFVilhrZUgmPrpBXl0RcDK2m4B1QsQobXoaTrQ4Uxyx0Z43qQkBwG4LSGzquXaa51TTDX2ZgAeDDz2OshKxO1dv7sT9Ah6LAoh5MKLIt2p5zxt7VNkBoBedScCHR/XODXbIcijScMj8Dz+pis+wWht/3n3v3nupHS6b3uWSi+TlguGpeQ4Plcr85O4LiRGQVBQj5/Jz9tgW7hQDOj3Izx2tJlUAE6VuOJmqiawYWw47nIlndK+DLnKS+rTj62WiyWTXfWjdrTNwVyZNMrwvoG4GjXrQnW18sV3oG2A0MnNHUIaykfHzwgI8OBNxO7NAhug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TSW3ztuiouxYbW4oGcTDhb0Erzw7r3UNeHnIsOQi/dM=;
 b=K5KeYZQxUprWXSvBEjcGJQxyZY+ye7ewJlaA8AUHCGfO+F3KnPVeBkHKIZTbNbtTDR4XQBmMFY/7cl52RucMePWytyzSQxykhPDERGZt7y0acqaKaCmlV9uxUv0Yt0Picgchr1XPSeeUlvyxBx4LOsUqtwBUFZ33qdXYeITaAD8uBmCV+6Q3XAcUa16L6xJW/1FE/BMczjWMYLtJHnQLGDMcBttIwBWTvGW2nwMwGUzOLodiGSFNVhwco1Bkpw2BpZOwXZBDhRpocXmJTaLfXYp6ZATce404tr5PESsJS+UNG5ZYREVpaJdz93/3CIMY2j9c+5UW5nfYxGs0zrGFEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TSW3ztuiouxYbW4oGcTDhb0Erzw7r3UNeHnIsOQi/dM=;
 b=lZEwKYNZvlRgnwssuWyCD3XHFCf6XaANGK9r/egCOquQ8lxxPfPnpNiwh/iSYYIygT072aXrSvoSYK9WDlIKHf/VAvUsQdFVH9xFZ4dEK4fdM9P7JsSSHfe09pSiNmxDo/RsaDytcgMYcF5fYW1HKDlv4GzH8S4JFjEMjwuZOk4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ2PR12MB8183.namprd12.prod.outlook.com (2603:10b6:a03:4f4::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 07:25:00 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 07:25:00 +0000
Message-ID: <cf3c13a8-1dc3-4b2a-8d37-0be289a31980@amd.com>
Date: Thu, 28 May 2026 09:24:57 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ttm/pool: Don't leak LRU list on shutdown
To: Ian Forbes <ian.forbes@broadcom.com>, dri-devel@lists.freedesktop.org
Cc: airlied@redhat.com
References: <20260527202018.1223912-1-ian.forbes@broadcom.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260527202018.1223912-1-ian.forbes@broadcom.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0259.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e8::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ2PR12MB8183:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ba867a4-c97e-4434-ed0c-08debc8a3a25
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: UVXvmiFLOXxalgAdhSDMCAV3QVrgkB1uMtb1ewHKzjv2KBqgBr8bCL5rPGi0PoOQPRPMZc7SlesEyBRonzN6UBkJUR6TMnShrcXS6w9XlYWR7gLBpq1Z0Vn5ipNitxvyWHkhISKybAZWyh8fCIx40s9KVAgV0svXnR+Yc1Fb8YpjTdxNXEwP2RLTCNFmYg1sUaDUHrs1gPIVWi9cTvRSwOYqtgc9sH/i7x2nr5zGmM4KX5tPEZvbqleQ72zoE2yDvPsx2Ye+wRnijY2DE/x9DXop1An2DWKjxIMB83Qos06wyE+NTZL5dEwtqGRtcym52Z+xD2G1OzoR/A2+76E5cUudrDJsWFMis4tGL/YL/Zsxhc8FoeSNy7LCEmqNWJDwXSp4ukd+DVxvhtevTIp71t7FLS6r3mY0bbeIvApWuajq4ZbNKhkaOaav0VnuM1BtvnY94x9t6SDiXIfEJvujR35PBw65B13pmdy6xk3P8KNK11QEWl/bMs1NeyM3VD0J3Qgx5JXbUqCYhWu1b0Y1j2D++tCBRYIIsjhOdRfs4S1gjRDsRlP/6Nb8PeYlIyQQ/C5celiNiTUwvWTYBjDGnlqh+phsH/vcU2SqRbvn/5jjE5vNcfjuXcnK/C9Xrv4rMuIKz0EgFqKMd8Q7IU6BKA0d2VFzTkO6emNvxchd6arx0HsbHtE2y2fY8w/QuY7r
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z2FoM2VpMHRKZjBWR0ZLZEFseEkrRUNlbTNmcGZ4bk4yRGZrSXJiT3dzVklL?=
 =?utf-8?B?aFVPbWJzeWwvVTlrRVo5S0R0TTg0VmdoK25lbFg1eFcvak9jZ2UzK0h2K2pz?=
 =?utf-8?B?UFplN3c1TWRkWHdpcXJjcnkzMU9qbkdOMzRNZVRKaTlmVDRSWFBrWjR3VEpp?=
 =?utf-8?B?dFVrbHFSMzVmWCtwb2luSHhPVDlRSGVHYS9NMUQ3VXQ5UjdTcXhoWSthcHYr?=
 =?utf-8?B?YkRReFZJOFZEUDh1eDZHMmtPaHdPaXdVZnFNdUhORlNWYi9TMCtSOGh4anF2?=
 =?utf-8?B?dHpCOHhJWEdnME5sYU4xbDJVbENWZmx1WTJVYmc2NC9PVmUzQ1dNSWt6cEpG?=
 =?utf-8?B?ZlhwTjlMR1Z6cC9aTkU5NXoxamRjdHo1WnlKeFgydGhiaDhYTWJnQUowZ0tI?=
 =?utf-8?B?ZkY1dHdsTCtqM3NXTFIyK3pkL1BIOU1EbU8yWi9tSFlIYlJQUXB3aUcvMzVu?=
 =?utf-8?B?RkpmR29FWm4yQWNxRmpkcHg4MmxhS0MwVjhsTW9NV2V1Z29xYjdLek9iNVdM?=
 =?utf-8?B?UVFTdmd4eGZNUk9iTnlmY1hLYXJFMXh4b09uWnorUE5yQnlvS3RROUg4U0hH?=
 =?utf-8?B?SFVmS0xJZG8rOGtkK3AzdWQrZ1ZvS0hJRVFuQmNuR2ZNRmxXWlNHV2N1b3Y1?=
 =?utf-8?B?YVR0UnFCbUZwWW82TVFSNjNaUDFENXBXYjA1Z2ZyQWVla3hvdmlNL3BnWXNL?=
 =?utf-8?B?TDJMTUxKNWVEVXl2STNZQmcvWmorZGlRZTFjMUQzZFI4R21va25OY3pvTE0v?=
 =?utf-8?B?dDVXcEluQWJkK00rWXMwN1hyUmRHMVVvdzdQaUlWeklTVGdZdWExdTdVYXV3?=
 =?utf-8?B?amhPZEtIeVRMMlJjTmdvQ1JtQmZuVVV2VE5yN1V1OEZLMGVEbC9wZDlaMTFq?=
 =?utf-8?B?RTJYNDVMdWVRL3R3R0hhL1lJOURrc1dOeFlWdnJmYkdPMGM0bFVTVVI5YWZF?=
 =?utf-8?B?VDBqK29HWDkxOHNwNWtFTVNnYkRKeS9NVkMwZXQydkRqS3hZY1BIeUdzelZB?=
 =?utf-8?B?bDRCL1BMb2xPNjF6OVNEbnVhSXZNdEdGMmlvSVc5V1ZZeHJpeDZQOUZ4NXZq?=
 =?utf-8?B?MVEyN0JIa2xYMGx5WEI5bFpoT2dxc2FkUko2NXBtMmF0OHN2NE5hdGF5UzVx?=
 =?utf-8?B?NWc5OE16RFpydmduc1ROM2d3MmtZR1ZkOGFpa0gyQVNzaDI2ZkhKY1VqelRQ?=
 =?utf-8?B?N1ljMU1nTHVNQ1QrUWNTTEJSd3ZIMW5JbHBoeGpwYldtTm1wWlZONzVvck94?=
 =?utf-8?B?U1phbml6N3VONGRYNm5GYUZVekxWTUpxM1NMV0VBbGR4NWU0K3d1bjRFYkJT?=
 =?utf-8?B?eEdxc2FBdVpQMW9qNk04SVZoZkQrWDhmbzZDaDFoYWZXRnJCQXpHU0cxVFpD?=
 =?utf-8?B?Q1lGRGthWE5Fa3lrRjVtdXdjaURIeFhnV1pRMEpMM1k4cElVc0VCYzNWcjRX?=
 =?utf-8?B?TENScjRIRW9PQlpTVWZrcWIrbCt5MCtuS1g1NE5mNVVMY1F5dEsxTG9pcklq?=
 =?utf-8?B?bGhjMXV6dXBIY3pMNXNyWndNbk1LVldjZE9Sa1dUMW1obTVkSEdkMWIwR1hP?=
 =?utf-8?B?cFpNdVFtczYyTDI5SkhhTGNpWElYUlBtaVFNRHpIdVVsNHRkMnJhMktlWG9k?=
 =?utf-8?B?SzRYRWozQVVJVGFmdS9RN0RzdDhDcUxheFBLMUNaODBnL3ZrMERNNEU4bTQv?=
 =?utf-8?B?MkNsQkFxUUNRdm5lUURhOFEzNzRidnBDUnNzKzRTL0lOaDRtMVVQTzk4NFhv?=
 =?utf-8?B?M1FacVEyMGs3OHU2NDdyckZNYkVWNktCSmQzbmxOR2VabDUyMXBBTEJmMjRN?=
 =?utf-8?B?aXduRFhXdVhLYjNSNjcwYk0wb1lYWXJOYk94K2hWQjd0TWlDdnB2M09RVmhK?=
 =?utf-8?B?RnhhRE1mVXpVZE1BWXhESDg0blR4ZjR0VkticG5ZWlQycnZobHhlK1NzY1Rt?=
 =?utf-8?B?MXd5dEVJZGRZSDhBM1oyRm5RM2M3NTVFT09aeVNQRWVaUzdVZXJuR2VTalZt?=
 =?utf-8?B?SnpCR3dNNHBaaWtXczVUSzdqMkMwT2l3MURtNmpiWGtsYXRiQWlSYldkOE9N?=
 =?utf-8?B?TEZLRXJ1SWdxdk9QczR5Z2NsYXprZWxkN0tIQ3g2S3JHd2o4T0VxY2FYRXlo?=
 =?utf-8?B?SDNScnJmYmhyVmtaN0c1K1BBQzkvdHZBbW9LcDV5Y1g1WFowOENPNkd4azZ2?=
 =?utf-8?B?dXQ1ZXRlTHNjeWxRY2dOc3VnNlVFRDJWVkVBZDk2ZVdxQ0V0R1ZVMG5uZmdr?=
 =?utf-8?B?RFJHd1ZCSTNxc2FYM2xKSExtRlF6NXExRVB6SVR1bTdKc3hmOGROZzhWR1VH?=
 =?utf-8?Q?XkB7ARQwtj7mf/INpg?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ba867a4-c97e-4434-ed0c-08debc8a3a25
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 07:25:00.3090 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOjqf9U0fGu2jvwc9r3K+RkKmpB5ThdUYuMNb7LBhFZfWY05RqIvFPgCll8wQRVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8183
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

On 5/27/26 22:20, Ian Forbes wrote:
> TTM pool was changed from a regular list to an lru list in the
> referenced fixes commit. list_lru_init allocates state and it needs to
> be freed unlike a simple list.
> 
> Found using the igt@core_hotunplug and kmemleak.
> 
> Fixes: 444e2a19d7fd ("ttm/pool: port to list_lru. (v2)")
> Signed-off-by: Ian Forbes <ian.forbes@broadcom.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/ttm/ttm_pool.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index 26a3689e5fd9..a41addbf3ddf 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -395,6 +395,7 @@ static void ttm_pool_type_fini(struct ttm_pool_type *pt)
>  
>  	list_lru_walk(&pt->pages, pool_move_to_dispose_list, &dispose, LONG_MAX);
>  	ttm_pool_dispose_list(pt, &dispose);
> +	list_lru_destroy(&pt->pages);
>  }
>  
>  /* Return the pool_type to use for the given caching and order */

