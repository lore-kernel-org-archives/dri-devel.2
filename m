Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CCC2EDB7E7
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:02:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B6C2C10E3AA;
	Tue,  7 Apr 2026 10:02:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="gDdDbIXf";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012071.outbound.protection.outlook.com [52.101.43.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A115710E2EF;
 Tue,  7 Apr 2026 10:02:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lm0gp/55BdF3LQrpLBRsyIB02t8YR0cQI5XP0aozn6hw+/WJjjxBOJUORaTcSLij+NEC5uVq0dzDrOTOd6S8V+Lp0AinkUuGNtJfWK/pCIp3LBrwqzYJpfaiH7xLHMq/+Z7s5OoPd7dKcYDuxDSUov0K8Lg+F1ohKppBN7vot0IxsJLotDTCwaqbVhecevfVqv8kvuQ25pMc+chVNH8ebE2EvjehNUUiXEmBJ2hlAj7LSFRAw8347vC6zKJo5M8K0j2LSdb6fDb0gfOYWtBuQn7mtqNdnayiyNUxPji3cEahgC/ZU332jRdDu6olk0/tSj5uii35Wy72y78ovMDBvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=83DdijxWhf6DYNRx5YcpRkgwySt1NQK5qMf10vBd3Dk=;
 b=m13RiAmsnWmQb2WiZZ5YkGq2ii/JpAvnN3BELumzJkHZevJiaH+GBJpHjOah/M8MGnI9NB5U2ueCfEbxq57VCLzokbbFJz21qx5+NsiUU365jZkk+GfQpSouC0Q18AkOyv9+5az4sDiZRVSjPhZ4tzxq6GsNPxS9+lYH8jU52JpE3P26m/MQ0ATOdez7PWKZoOMC6CuZPSNALVvN/5yiSVYWZBrTfusqHEWPpBD5fgaBrJWiWjgsbN2n7RbPzY1h7J98S8nQVIGxFhIA1xk1Kbz9TvmxD3iIfAtRdeDaMUPfapqkuUwXBbywuGZNaM9mZUh5hCUYZLmdSc3lTPK9Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=83DdijxWhf6DYNRx5YcpRkgwySt1NQK5qMf10vBd3Dk=;
 b=gDdDbIXfF8SqtvTbDSNrebHkLT5/WOmloG21cVy0DOya0UmUKteWDyJf4ek+jlu9Pzswy9ctFvhq5TakCxNuWact4CT61rnNAPZIDzrHQMPcKlcJ3/EgtBqWqLYgR1tBiNzkTgARcQPaa/ZZo1IacHcf1D8MfXsHQB+A1ymorbY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by BL1PR12MB5804.namprd12.prod.outlook.com (2603:10b6:208:394::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Tue, 7 Apr
 2026 10:02:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 10:02:03 +0000
Message-ID: <47526037-5058-4491-9e84-42cf68191605@amd.com>
Date: Tue, 7 Apr 2026 12:01:59 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/7] drm/amdgpu: create multiple clear/move ttm entities
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-3-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260403083602.1771-3-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0198.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e5::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|BL1PR12MB5804:EE_
X-MS-Office365-Filtering-Correlation-Id: b2310916-d077-4cf3-a381-08de948cb7ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 6IHju74vfGXvWpXa1Yr44OI+wDzimvH4I3r18gWNqR7n1MEJ+Jca0JKt+ZvvuDzSSFCLlNr3i/FytSWBn2P0U6QltRcdqT2+InXnfaKyYyMN2qV5ZAUhGgpnZNynr6ZG/qev8zQJSCkOtRL7rkbtUhCGwtimo7HOQSO5WQSLuLtEdY014tfYhFNt/Q8DN/NVpFD3Dk10TtdnkWK1R+ubA4yaNn4p0gd06Ck8QK+GPrDDRNEb5hRf+6jwNIHWSTvndhFGgBhbOehb0wG/ug+0cBZOEYpEpTjvMb/d0vkv7xbswFnQRN8gSlcdyMptYdX3ewl7FS0e0IYGcksqI27e44/gmVTL0e4E/iCXJN5GfxYAe3CQ+8b/c4yrQ82dhf0SKj/uM1WuuWvysYLrw8W1ME0iscOestDAeMKw+1GJs5CE3gOzt/JLUQ1DJnoS89Xx1uC7KhSTcpaYow0U9ZBcBn9+ICcj6HA6uZ9fqL2QpjugNMDL2rqY8UT14tNd/DeN67iYaUKNMsUa+kOzGtLBbJDbNJAi435/JWvczaPLYuvqeOCB9ZktROfDGn6koID8QY/56dQZ+J/2Wjdhu3WTznWSEzWMAQHuSGpu+2K4pAfIxYpDw5P9pjQ/f2H171UOjHzizKYG6314xMt2jNcvDHX/T1l8jVh/gyXPskXMG6tyOdtSoWj1LVI6ASqIgVX7pP9zRY7CcXy233O1fftrjnBbsOuTD6t7EcTrPdY4IEU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlB6bkdyZ1IrZGgvMkhNcERMU25EVXpxbVVJSWI0L2xGWkY1Q2plZVFmNlBI?=
 =?utf-8?B?ZGtpZUpBRDh4TzJQSiswSGc4ZDJUQ09UN0dlbVBCYzFjRi9BZVgrYXYycnhv?=
 =?utf-8?B?RzFUV2J4bE5DZy9RTDdPaXVzR1dGeGRHRnNuVjhrNXBrMjYyRFVLM0pzM0ds?=
 =?utf-8?B?MEpzODIwRVdrb2hXS1ZHUExZN3QxdXk0QWJKdXV1NXp0TmJDMEN6MGZUSzEx?=
 =?utf-8?B?ZzU1UWtnd1pWY0h4cWJLRWpOdlR2YzBtTzNjSVR4bDg2a0lOSVZSOWswN0cw?=
 =?utf-8?B?QWpIWjJqcUhRRWZEd1FIcURKNi8rYnNDTlFnbmVLUERzTDRnY2ZHWjI1alRB?=
 =?utf-8?B?QklDS1RTdnNIdTlGd2JYSDlBenZqSlZveHdSdU16WlpVV09tWGtWdCsweklo?=
 =?utf-8?B?cFlGbDZtWmU0QUVJY295SUIrU2NEdVVGekxxKzVMNUxtL2dhbklYNDNWbXpI?=
 =?utf-8?B?N09YWGs1MDVpZExvcmFyazN1ZTdPK2ZuRzU3S210Z0d6UW1ENmY1N3FmYkY0?=
 =?utf-8?B?MjlwWVdjTEF5OTQzT2x1TnVVeXN6M29LSlRnL0xoNGt4Q2NJQ3VRdGRxamZs?=
 =?utf-8?B?dXpxeFBZTTdUVzd6MkZ6OUlMS1JrODcwMVBMbzV0Q2h0Z0J6czVsL0JBSnlH?=
 =?utf-8?B?OEc1M0p3aWZaYmlQL1F0dytlYlpjckZLRHo5TmtnU0xNNHNoWkI2akV4WVhW?=
 =?utf-8?B?ME1YaFVmVjEwcW5BbzNLV1BFUXJFUE5VVksxQXpKTXhSVFh6Nk9DaC9VMVBF?=
 =?utf-8?B?UStJRDJoVkdqaGMvNWZSblpFSXRlM2tMSVRsZWFHOWJpZVllbWNGcGg5eG52?=
 =?utf-8?B?MXFnb2lkUEpDWTBRZ3h0WDBIRTlmV0FSOFNqajE3U3Bsb1RhalJKWmlxQS9q?=
 =?utf-8?B?VW9iOUhoUnlWa29DUXZTUElGT3JpY1ZUN0RMY2Q4ZVVURGhQdXJId0F2ZDBT?=
 =?utf-8?B?YW8rQlBUVG5JOWhadVBWOWI1Umt6WGRXYVZsUVptVVZZZkdPdmJNZVAyaFl1?=
 =?utf-8?B?REVTZ0Q2bHphMG5OSHV0K2tMdTUrbTY1Nmx0N2czRFZsd2pKVGQ2eFZ1Yy9W?=
 =?utf-8?B?ZXhOZkNpOTIrY0pSRUlENG8vNHdydHJRS0NzSklraVh1OXZWZFV2QzVNVXhU?=
 =?utf-8?B?RmJ0WHZtREJPZ1ZHaEFiQ1NYaVlpWFE0VW94WjdrQVhVaUtKRG5UR1JPOWNO?=
 =?utf-8?B?VXBKNHBWbkNPd1FMMWdCVENac3VtNHNSazhaSTUwRVJHSDVPclFKQzRaWU0r?=
 =?utf-8?B?dFFNbHRNS0NlZVNNWlZNNmo4UlJiYW12RituUGdnenRST1QyazlIemxBVkpq?=
 =?utf-8?B?VDRuU21lZDE3NHNNUU1UcUJ5OGF1TVl0OWpONWpRdExjZWlnSTc3bWsyV3BH?=
 =?utf-8?B?citCUjRzNmVvMU8vZE5LYjlPWHRSbm9GOFUxUURNWjZZM0thenZlUmZHWWxH?=
 =?utf-8?B?emVQZDV2aXdCMTV4SGdpV2kyV2I0OTVLTDZMNEU1RGIraFdjR1BGUTNUWm5p?=
 =?utf-8?B?UmlHNjNKTFU2RUFXVDBvdFVTbjBtdEZhMnhYK0lHMGxsRDhKQmtIVVNMbTBs?=
 =?utf-8?B?NThqcnZabHRMY3JVNXpKei8zT0cxT05pUTg2cnJab1VLRUZ1amwwUGM5ZnZy?=
 =?utf-8?B?VmZNTm1kczEyaGY1LzBSY2JLOVJxR2IyczhBWXQ5VUU4LzNjUlNQbjdFV0kx?=
 =?utf-8?B?ZUVZdC9STDFmU1RGRGt5MTYzYWtVSGFOU25YektFNGRNNG1CQVVMK3V3NTJD?=
 =?utf-8?B?YkZKWE92NHFZdzhZYzg3a2IzUDc5K2JWSmVISUVpY0VJSGZXT0dGVVhBYjF1?=
 =?utf-8?B?MDhab3gvbEJUSUloZ3k5WjltRzRsZU5CSHJVWHh5ZnMwU0dCVVFIa0JHcWJQ?=
 =?utf-8?B?Vlkza3U3UXlGdzV0UG05bUw3ZkcrNUxhUkRvOVF3cTZIS0UvR0JzZllLVUVV?=
 =?utf-8?B?MmdRU1RvU0NjV1kzNnBrOEF4Z090OGFlOGVkbmRzbUhKM0hlVkZuWEppZCt0?=
 =?utf-8?B?enhtZHN4c28zL0Y3WlltUndOaG1BUlRZYnJDOWNSR0tmMlBEU2s1VFVRdm9E?=
 =?utf-8?B?N2R5SHozNkl1WGViTWhLcnJpVmUwS0s4U0NhZ2g1QlhwTGNUMUY5dEs0Znpz?=
 =?utf-8?B?aS9TdlB6aHREOUQxZXlwLzVXdnlRYlluSlNEQW8xeWlOeG4rNVhYWHNJK3FQ?=
 =?utf-8?B?VUlkWWJLemZHZGl2allOZWlhcTkxRUw0Zk9ib1IrcDB6MTNJSlBob0IzNVBM?=
 =?utf-8?B?SnFVSDVQTXJUWktVS0xuSjFaajJlbnlIb21DWkxqZ1Z4MDF1SkN1Y3RZWm9m?=
 =?utf-8?Q?vaS5LrePdnGn1+tvED?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b2310916-d077-4cf3-a381-08de948cb7ef
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:02:03.7591 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H5FOxhZsDLFrGBYgeMtMrMc6km/w9hqGCUPfmqhiKbKBskcxuy6IPcS1IZe3nPri
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5804
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

On 4/3/26 10:35, Pierre-Eric Pelloux-Prayer wrote:
> This enables parallelism of operations.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index bd32113292ec..83f6d00dc3a0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2356,8 +2356,8 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>  			return;
>  		}
>  
> -		num_clear_entities = 1;
> -		num_move_entities = 1;
> +		num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
> +		num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
>  		sched = adev->mman.buffer_funcs_scheds[0];
>  		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
>  						  &adev->mman.default_entity,

