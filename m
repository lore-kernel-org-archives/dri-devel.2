Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63E3ECD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 00:57:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9FCD810E182;
	Thu, 21 May 2026 00:57:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ULCnDYDl";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011030.outbound.protection.outlook.com [52.101.57.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8889510E182
 for <dri-devel@lists.freedesktop.org>; Thu, 21 May 2026 00:57:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cOZ2zM3K/Zv4V4d18symak51Pm5mTzs10HXfy1IFuTZ2cKVFyXBTyKhYaarfK/74FvrQ2bnp8RpzoaHhWTCQW7HFMEnTNOZjFsbqMIZQF0giGEsz5z3JTnUJiqmN4KkO8Ro5xL+xJ299rt+q8cDPo7vbJLtA4JZNvYBlUuYx7V5owH7rnq88UsiKwve8ZCZ/jCBurS2RUuSMeHwe5kgij2gzRFyyVax8ePS3bVSCo0mpELiKLUXA4ficZkWyCRxDbJiAR6S2SYNmMhFScVNS5Q1CZJAOo8hF3tWsf0HuSltvps2ZO1io6h7lnevSIhiwgTcduttmIqYIbn4Mi0roNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zHFVTzJCLHEQlQBQCgymBeAy1H6Ub5vIIRSjoPM6iZQ=;
 b=JX08gruZcNQUivoHCsiWrhxMTQyuTY0t+g4gB51Dg330XVQ+Gz5p29IP2DdBIbbr0UwcSr72ogOqyofqnF+dpPdnQzTyPM66lrbZQXvcPsbqeMO86yUUpklY7f4a5w6CXJNxWVrOOREtK7TvBBZg0DMD7LZ13u3JGQhZ/3eDRoo+y0N/bH3dkd2H1hoy2+sjkZzANlLob77zC7Vi3XaG8v/BB7TUEN9X0JCm1Xi3bgGsoiast7dmrPzGT2K7MaJmaA86gdXcVpc1alnQyjNPTUau07xcLWmstxJKNw7smHAksbFui0f0s+NA0wKLR1GyoLoAcoPYaewz2yfVGg1Pdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zHFVTzJCLHEQlQBQCgymBeAy1H6Ub5vIIRSjoPM6iZQ=;
 b=ULCnDYDl7rG01GIp+10hpVpMFf8JodJT+q2qUVG+y01TNGJfFvEnYAzSUhGo3mqk0XiaduXjU3JvLf36pa/HUlNyVXJYBXgyT3E50AdpAPZETO1WoSz3l2ie/iGRNNS41oqwHM0dJ/Z+wxhtqK7CgZIKqVQUEjxbReUYoIlgza8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DSVPR12MB999147.namprd12.prod.outlook.com (2603:10b6:8:38b::11)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.16; Thu, 21 May 2026 00:57:06 +0000
Received: from DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445]) by DSVPR12MB999147.namprd12.prod.outlook.com
 ([fe80::98c5:8206:6a4:c445%3]) with mapi id 15.20.9870.023; Thu, 21 May 2026
 00:57:06 +0000
Message-ID: <c0018792-7867-4fc6-b64d-7e0fb8717f08@amd.com>
Date: Wed, 20 May 2026 19:57:03 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V1] accel/amdxdna: Block running when IOMMU is off
Content-Language: en-US
To: Lizhi Hou <lizhi.hou@amd.com>, ogabbay@kernel.org,
 quic_jhugo@quicinc.com, dri-devel@lists.freedesktop.org,
 karol.wachowski@linux.intel.com
Cc: linux-kernel@vger.kernel.org, max.zhen@amd.com, sonal.santan@amd.com
References: <20260520223531.1403302-1-lizhi.hou@amd.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260520223531.1403302-1-lizhi.hou@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0053.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2d0::27) To DSVPR12MB999147.namprd12.prod.outlook.com
 (2603:10b6:8:38b::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DSVPR12MB999147:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 273f73be-95a0-4ac6-3956-08deb6d3e0ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|56012099003;
X-Microsoft-Antispam-Message-Info: s8lDzIrjStGQU4sRh61mWCLL4lVASkOSgID6sB3hUMYU6iE7Vk83Fg+S5yHMB8EJ/Ku62ZvSpu2DSXsULSKNAJh8sYJeATYg0SlfkmgN16DNcN2+HmqF37o4Rq1Piyes3pMl3wr4RZIY/HLG6U7yQmcpQhhAh63p1gpSmjCcVU4ySqzRXFfvs3KwnvSpk0xOj8X8kOwFmEqUSYdYP//DSxDeYVN1Kt5FlXuOdT9CeqVpa8qhbkm9tyQkR9C0xL9FDPeIiCUHNWikigUdKxU96HjO4Hk/e0u+ikXaamHQfHiGG+eddfMFC4MLJuV96J+4d1IWjnh4VSW6fZrDxjj08+AABiFMejV8MjvEQQo6KV17L5fhfXdgB/FGqlV9tfzAqzpc52mbWhNwKwgD8hrFIrzkiYPGCIMjUNuGzTeVENdIZ1xUkQrFVTvlWTlVx8OiM1OqO69x+3xL0LMIcBhyYTOAAAIFrqCbqHtxZp83bmPT8pDqvEJ0YLQnF6fI+JzfLq/81bo8KA48IFlW28IJlyYzdQbqhi4b14+xlBm0p8TJ+iF95eC7pnZOXrojWSTpTdm+YqDCB2/i8jSFNdctWbYhQsqO8rqyq3uxNrp9m7v1T9csYnlifcBT/Qm1EPQZKNH2qMojSbw+z6IBFf/Tag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DSVPR12MB999147.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUdVVUdQRmEwTm54NUxHaWZPSDcwWWtzK05zQnFQenAyaFQxWjFmWFpVR0hS?=
 =?utf-8?B?cVNyQWJoYWd3ZnlTQUduenhueFRZa2p2RHlXL0hKMkY3YXlTMnlGd3RrcXF4?=
 =?utf-8?B?MThvbWJEYnEyNkRGK1duY1B0QjNFVFpkOUVyRzl4TTFnTEp3d2RhRkU0RkF4?=
 =?utf-8?B?RUJHeEtpeHFqRHlZSExNcDJCSldGc1k2bWN2aElwYytwUCs3a3g0L1A5Wml3?=
 =?utf-8?B?QXVRKzlBWmlYV3h1bFNnZHZ2cUdFVENmV2FZekJKUHgwVmlsUkNxNC9pQnRl?=
 =?utf-8?B?Z1ZWUm9LZDJodlpWMmJ1cDFEZXNFbTFYbjJvV21NaVFIWnZPempqSjJCakVn?=
 =?utf-8?B?bzRPYUgyTHg3TkhOaGZLSGVVQkhGRjF5N0dLMGJOR1lGeHhYV3NHUWg2c25x?=
 =?utf-8?B?aDJhWnVKc0dhejVMKzNGc1RXd1JXRmEzZDJKVkRHR2REZUYxNXYrU1Btc2VC?=
 =?utf-8?B?Sm1JSm0vTmdUdklqVHZCVGVHbDIrVmQwWi9ubmFCQ2hNYis5eTNCdVNHUkpB?=
 =?utf-8?B?T1phL2FNRGQwY29xU2E0a2ViUmRDeXV6RWN3TldUWXRYWUI2YzQzcEdUNy9E?=
 =?utf-8?B?UXY4cTJVd2pxUjY4cWZQYW4yejRXWFJlamg4T05wcTN3dTNlUTZvNWRYUnlt?=
 =?utf-8?B?SlhIWUUxdjdaY2hRazNjVFdxcjUwL29JdHVUdDdjUmZVOFdIeE9QQzRDOE9N?=
 =?utf-8?B?WlFqRmxZL20xTTVnRXNpV0xsblptZW5WajFoeUxlSlR0VTYrM1A0UVNsMjda?=
 =?utf-8?B?dVdYNndZYUxoOGRlRi9HbC9OcWhTd0xReVdmTkdibkhURk5lQ1pMckNGQ0pv?=
 =?utf-8?B?Ti9tb0tKM21UZXRkcitRWEh0aHFCU01JNkZ1RVYraUlkeXVGODRLcDRMaE9n?=
 =?utf-8?B?ZkVNWmZRQlQ1allVdE4wVGxoTEcxbHBKc2pIUVpxYU1pVzhTNG1wb2RTZlFO?=
 =?utf-8?B?R3dubWU1bkNWY1JWSk1rTHpGc1FqT1FSR2JsdGkvMFNGMHgzTzFqQm1BVExu?=
 =?utf-8?B?c1FyeGZUOVFLbkhEY214cHhISFVaYllDYzcxbC9tWTVFR2lSdmx0NDUreFdt?=
 =?utf-8?B?MXdEVyt3WVo2Z3RJTk4xcllpSDNhZWkrZjdaSDNHYnJRdjNqamh2UjVnSVg1?=
 =?utf-8?B?SEdaMHg4YVBoWUM4azkwTWJ4SGRxNWpuRkZ0aXBZNEk5RUU4L2F6MEJEK2lH?=
 =?utf-8?B?TE9ZVlhwQTBXR3JhcDAyeVpKdW5ZQkhKd1ZJakd5RloyRDRFSHRKWHhPSi9t?=
 =?utf-8?B?TjlPekUvWkt5ejc5TG5kVVBuQUt0WGtseDBTS1ZhSDEvcWY0cnJ5M2pxaFpX?=
 =?utf-8?B?amdud2NvVEJmN3BuVzM3YXIzN2FmWEhaWStaYm94WkRtMWFlZmJEYlRHNTg2?=
 =?utf-8?B?U3RGOTZxZFdVS3RFaC9WUTVyb2FNRHV3a0cyODVORVNOTmFjNG5Hc3dBKzlv?=
 =?utf-8?B?VFVhNWtldnVEMUhPeTNPbHVwMmZRdFhZNzJjL1ZwOGlzNU5NZU1EV3p4UDQr?=
 =?utf-8?B?SUNpNnBjUjhiZ3pnTXh4QkpOQkFFQnN0aEpaTzVUOENlYzBMdURZMUFmZkF2?=
 =?utf-8?B?MEJOMlZtRnh2Lzc2NzNGak1tZlFKSFoyTnU1dzEyNEZEOFlvOHhEclFsUXdD?=
 =?utf-8?B?V3pRcElDY2VNOWE0eGxROHFTWjhhbjBVT0tLNlYySmJwbmhMTk9Dd3cvWS9T?=
 =?utf-8?B?emJvOFIxUW5pQUMrdUE0eWhDZHBOaDE2MThBSDA3NjFxUUk5QUxBdUZ6bita?=
 =?utf-8?B?YlU3dE9lZFkyQXR3QzJNU1dyUjdibit0ZXViM3NjVi9sdlk3dXpCbEFDdk9n?=
 =?utf-8?B?MTU0Y3VwRlpmRzJNZWxPL1dNdUtRVExUM1J2ZklScFQ0TUZzakx6am9uRlRC?=
 =?utf-8?B?bGJpTHIwZ1RlU1IzalgrNGxJQThpV1g4VGpzeWdkcFlGTkJYZ0dxY2FidHd4?=
 =?utf-8?B?UHFTTk5TT29lZmpBRFFaQ3ZFaTBVZkJoU2Y0aU1rSzNEVGYvR09qR2I3Vms1?=
 =?utf-8?B?aUJVMWJXSHk1RWl6aHJWTG9LaXdOQTB2ODhhbmt2Q2RUd2JzSDRxdlluOWpS?=
 =?utf-8?B?TzNON0s4eVpURTlPNnZpZXdmRHZIY3IrQXZTZlBpZ3dISEFab3lOSDEreTFv?=
 =?utf-8?B?OUkzeitqTEZSeVVhRnVYWEZaMXM3d3poZVcwSGZjVTNxZW9vTC9aWTNpVDhW?=
 =?utf-8?B?L1h2bzNMUlM0VzVORGtUYjZWT1ZmK1pzc0tNSUxFcXJGdmFWdkQ4Ly9maXBR?=
 =?utf-8?B?MVZVV3lQbjZQNmJ6ZDZiRnNuYWFvSnI4bTAvM3ZDSDYwSHl2Y3lQRXZTK3JI?=
 =?utf-8?Q?yDTGnBu/ALFcbauTKJ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273f73be-95a0-4ac6-3956-08deb6d3e0ba
X-MS-Exchange-CrossTenant-AuthSource: DSVPR12MB999147.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 00:57:06.0357 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KSoWl4AZhS4zgDyLaXcL1eQ4RNz6onErNvwjuZ59L/wesyMuoRS57rS3CeiEK346HGrt6c0opf01nHftCWhu5g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
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



On 5/20/26 17:35, Lizhi Hou wrote:
> The AIE2 device firmware requires IOMMU on.
> 
> Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5319
> Signed-off-by: Lizhi Hou <lizhi.hou@amd.com>
> ---
>   drivers/accel/amdxdna/aie2_pci.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/accel/amdxdna/aie2_pci.c b/drivers/accel/amdxdna/aie2_pci.c
> index c4d345d4c76b..22f66c7f534d 100644
> --- a/drivers/accel/amdxdna/aie2_pci.c
> +++ b/drivers/accel/amdxdna/aie2_pci.c
> @@ -490,6 +490,11 @@ static int aie2_init(struct amdxdna_dev *xdna)
>   		return -EINVAL;
>   	}
>   
> +	if (!xdna->group) {
> +		XDNA_ERR(xdna, "Running without IOMMU not supported");
> +		return -EINVAL;
> +	}
> +
>   	ndev = drmm_kzalloc(&xdna->ddev, sizeof(*ndev), GFP_KERNEL);
>   	if (!ndev)
>   		return -ENOMEM;

I think it would be better to change the return for amdxdna_iommu_init().

This has a check that lets !xdna->group pass; which can be turned into 
an error code instead.
