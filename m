Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 981C1105D9B9
	for <dri-devel@archiver.kernel.org>; Wed,  8 Apr 2026 14:11:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0186210E67C;
	Wed,  8 Apr 2026 14:11:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="tDhB47YZ";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011024.outbound.protection.outlook.com [52.101.57.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3224010E679;
 Wed,  8 Apr 2026 14:11:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IVlKPcj+DcopiXHWHQxMzZQzuvi8CLxB9lLrrp5KF2bQDUZaXnjQ0X3NXaunjCSSMFg/pW23b5EPLSVD3ARILBRRsfx6Ngbr7U95EUyuCqbXQfpFzvgFRg0mfsVeE0Rb9WfW5qNPegs+hd41r4x+QopxPH6saJoWoqHpuzx+79/FbFwtGKWSrbnqsVNg5F9BodfJbn6ooPi4/16d97hFTnXSBdVDUIUpQhHWten+0zUH1Bc4zvYTLsi1ydTR/BinXDX7C8H2rSKeqFCo4r30jGNs5+dv6qOI+kDpdM09jpihL2Z5+DMI8xRDUdwKhewqSQ7wMb7zThVmhSuK3JKxpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLyst2ovUuDd3u6boxYOp6WjbYcNAHM0jr3MQSXjeG8=;
 b=zVbN21rjA/hPOS8cr+t2ahyHUrRH91LrJHYo4oD4Ny3vHaWn6Ycs5OGPl8XGBM9dwGPNQ4JWjQpB7Q5bufzeaog9tts4sJ86HmEkBqWzqIclHYqpcuGtJekbyDx45nUDIG/m8ERkaLfP64ZUxgufLeqVYM09SnzhPyepEzYuG5ed+rNiuXqKnR8Gwd1BDOXNzxkd6iPtt5lUMzfiuyvUCiJUDRTpT7QjcZGp+kKAYh97QyIkeWReBHQ2iQGj71FNmNhe7sl5OuwD1k/kxZt24Y2JXWIu2Yhsvr2RqQIPQGFw9Shp819JJQd613c9/lpitHrMCddYIG4b8y3Sbgnu0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLyst2ovUuDd3u6boxYOp6WjbYcNAHM0jr3MQSXjeG8=;
 b=tDhB47YZBfDP2CtepM9Adl49xC1I235Nnv7UlAQPdOPd/bwbmtgR+a2G/fyMOlgTKrNdnuIi1SUBLM1jSM2KpTJ8r0hUl7vL8yl/NivlTPw76cqaGr9X5kYAzvPC9sUQvezqt4V2fQKWUZbxOz1YUXfpiS1acBpPR5Q/dLYABvo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7473.namprd12.prod.outlook.com (2603:10b6:a03:48d::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Wed, 8 Apr
 2026 14:11:25 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Wed, 8 Apr 2026
 14:11:25 +0000
Message-ID: <ab9a3cff-a9e0-4528-b35c-e79da7058860@amd.com>
Date: Wed, 8 Apr 2026 16:11:18 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] drm/amdgpu: use DRM_SCHED_PRIORITY_KERNEL for all
 ttm entities
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260408100327.1372-1-pierre-eric.pelloux-prayer@amd.com>
 <20260408100327.1372-8-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260408100327.1372-8-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0173.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::16) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7473:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e0a3ba9-3f4e-465f-3fe3-08de9578b815
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: PwfzTNxsd9JOgqQgnOGeWnxFU7n0IwNebaI3XednA7DZXzTrlNQs7tppt3jlGSPp27tMr+M2I4g2ygZTyeYZ/YKFVR8rxj30hLeZVCtwJAG4QCadxZqdaiBQGjcSvAoNCxHLRl9yBY2dKYyOzLGZA+RnePg8adbGLeGrRb2tifkQ4y3AA3yvyL9xKv+6jB/KCy9xHEtX1ra7wd1rvcZW+2tnBOwHWEse6pqspzVpi4Nhzo25DeVzS+6N/c5iTNQdRI6m9DycBbwaoIhFDZ5e9lFXxMdpm5v81DRakKdjFmFD3tOFPJ9/Z67mvhIyLdRYh4DdHjzZqyqCHhGFzjwU7BBP2xEkyAZpwMRH+UbUI+Tc3+G5WL4oJ9ZP3Ezj71p2ph0DZxjI/o7b1Aua3B1n8c3emVZqRLNLvtyMuka7Z3Ucd1nSpsvUVMYPnshlMQSMdHygle0liGko03pEfPCUT5UamzPy1MACIhkAWQqwJ1iWjy/aGKZKiYNdFd8ITPSYnQt/7Rqq7qd2neFLPFUof9LkMvcUkejQXS4LZp4pO7cfzzWQIUNzo1Dqs7poi7gXighFt1hMoqGkY5qo1dApHSTAzSaOKcL16Bb+gxVnP0kgONy0m789gv86J/3nIs8m65g+23phJ0inDgAg9h/3pO/34Rh0v8rmrhTOSQA/2tjduH+/YhEcYLpXOCuXbGy9Lxa9peZe//84KW3GmxxFhWihYUKExBSboBTSj8TlNUA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWtUY2RnMWFTQWRJOHdhM3hPRG91ZUUzNXVhelRqSDdXcnp3QjRuaFZwOWh2?=
 =?utf-8?B?YnhtT0RSSjhaU2RHcDhsODZBb0FWaXFQeldpbFFxYWxrNlg3eHRkdlRsQjha?=
 =?utf-8?B?K1p3OGRWMnlQcE5hQW9JTGgxSVMvU0Vsc0ZRMTYwajdIMmY0TkRkNTZPbVJ6?=
 =?utf-8?B?VDRwL21aOGErLzN6VmxIUlE3U21oYWRLZXErODNPQkdwUm80SDZzTFhYb2t0?=
 =?utf-8?B?WnROWlJRRmxrWXowNEMySDU2bXJqMjBpNnhzenp5eDdHQ1dpR0dyL0FzTHkv?=
 =?utf-8?B?L3J3ZlprMlhmV3cvVEdUeWZ5TEZGRDhMRXBMUkVZUmVoMjJiSC9VZ0FoSWln?=
 =?utf-8?B?eXEwcVAvNjZ4OUcxQ3B3N01FNUw2QWc4Ykk5cUdUcU5TOXhYNTA4TXBkQjNv?=
 =?utf-8?B?NXRpSC9UYVlxTXVoNTBCalRaWkZSK0k3MzVIVmlEaTBDUVM4VlFQKzFGVVk3?=
 =?utf-8?B?K05Yc1J6Ri9BWUdpbHNJY1dQS0tJSVlLL0g5ZnlkSmlKcHJXRVpQQ09KalJt?=
 =?utf-8?B?TGNONm4vOGxzYVQ0NS9VcXRyb056blZURldMemZ0RnplRW14eS9vcVBlUlJ5?=
 =?utf-8?B?aWphUHQrMjBOQWY5bjNubHJLYWNIU2FMWWFFNUlTR1h1NVBYQ3g1cHhGQlFx?=
 =?utf-8?B?UGdBR3locXJ0QWF3RGo0SE5rU0NNanU5Q1BUaGRCeUtpRnRQSjQzY21IOVBR?=
 =?utf-8?B?RXBoNytDdVlVMHRodmU5VVlEOGNvVmUxU1pWK293YmJnOURYV3cxcytPVEh2?=
 =?utf-8?B?cml0cnpZemtSd1NGcGZwTkl5YkdUUGZEZDFuS1g1cjNWcVpkcmNuZlJyWHQx?=
 =?utf-8?B?YXZWZzliS1AyV0FOUDRBMVFFemhtMWVreHdLekU4MklmbWJWUlgyZ3VhV3JB?=
 =?utf-8?B?VHBXQVBNWXFiWHY3M1gyektvUzFoZ1JFKy95d25hS1ZFOUxBd05tNmRWK2lV?=
 =?utf-8?B?WUZ4RFV4M2g4UGdjYU9MUWNQVzdsVU5hVTVreG51WHZKMzBzbzRMd2tuaStV?=
 =?utf-8?B?SEFLVVVYVmRhTmxnZGhISE5BWVdjNmk0cStld1RWMWdHVzJNYWU3RmJnZVRz?=
 =?utf-8?B?RmpPNlQ0WEYzRjFYYVd3aGltUlhWYWN6eEJUMWVqS05jRVQ2b3FqR0FHSE56?=
 =?utf-8?B?bVlKQnFvc21rNGNRZjRFOGtnRjNRVkswazlmcitGMkczSGNXQndHSlhtNlV3?=
 =?utf-8?B?bDU1WXorbyt5Ync3MkJaMEJ1RGtkV0xiOURDOFg0RnZ6RHNKcWJnQlBRczN6?=
 =?utf-8?B?NnloU2FuUWtNSktydVFoVTZrVlZrckszbVI0RnlnbmdmNnA5RE5rajRCcCtV?=
 =?utf-8?B?MW9EZS91VzUzTThVMjF1ZlU5TE1VNitsNDFBOHlJV1lrQys4SVI5UWNpY0o0?=
 =?utf-8?B?ZENITTlLZFkrVE1MdHZpQzNiampmOFkvZFIvN0h3WDNTZTVZajl5ZXJtZWs0?=
 =?utf-8?B?SHRoMFB2ZW13bU5vNlJMSGVUckF5LzFlN20razBSRk8vbDNaUi8wNERVZ1pG?=
 =?utf-8?B?NWVtdm1iRkdJZE05TFN4ZC9PREFGNHhJOVNLRXJJNVZWeHk1Y2tBdERYbU5j?=
 =?utf-8?B?L1psMm9kTmxQTUFGSXRoQlQxUVdZT0JGZUhybEhoZkI5a0I0MHZmNWRWM0Zy?=
 =?utf-8?B?cktGUWNwR1hnaFZyRmQ3N1pXZlN6VlNkTzkveUdsVjB4MnlsbDgrZkM1NVRP?=
 =?utf-8?B?UWNVZmtrV2VlY084elJuT3cvQmM4UGZ5U3Y5UUR4T2ppZmV3VkhqODRITlB0?=
 =?utf-8?B?cmU2bWhGenZsZVE1bzNXODNsSTFXZjk5SDB3Y0hjdytFeDVkZVY5eXJnRFBk?=
 =?utf-8?B?ZTRMT2lkY0RKdUFqWExpRkd2V1RoVlBqcmhZT2RqcHRMS2tLdVppUTVMM0F0?=
 =?utf-8?B?azZyYjVUeEIrWkZQUXFpQkhTQzd3S3picDFhSFpwMWpzaWFHUk4xVThrYkVi?=
 =?utf-8?B?dHpabjJMak5acFd4SXlDWndzUFdVbUhFVnFiYnlXSU1lLzI5NXhRck5WUklQ?=
 =?utf-8?B?dTJXVTAvSkpDWUJNTjNYbzE4MUdDR1creU0wcUtUb25wRHNlL0dFRlRndEEz?=
 =?utf-8?B?dExVWDczUytoMGVVOUtBMndaWjdpREpweGFUR1pwMjBnZVNhZkNTT2hBalFZ?=
 =?utf-8?B?c01vRGUzS1NibDFrMTNCMWVDcS9nODkrVTFMa1I2OFRYZVFUSGFvOGErK3JN?=
 =?utf-8?B?MHNac2tFYmRQSVpCNThNU3BaYjRqVnltdUhsdDZJYUs0NFRkZDVRVGQ1bXpQ?=
 =?utf-8?B?eVYyd2NwRjA3OU1Sd3QrMnVXbWpBUmkxeGd4UFY3QXEwZkcrcnF3OTNMem1D?=
 =?utf-8?Q?E6GVnbgsU2jiY29FFo?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e0a3ba9-3f4e-465f-3fe3-08de9578b815
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 14:11:25.3423 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xLSLiFCcYyEXHhYbyFWn8zNStiuuSJs44rMgxAUQZZoYfjkCNmf1DyIE3HaqxtFB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7473
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

On 4/8/26 12:03, Pierre-Eric Pelloux-Prayer wrote:
> ttm jobs must have higher priority than any userspace jobs.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 000f66452b10..1f9423556ab3 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2378,7 +2378,7 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
>  		r = amdgpu_ttm_buffer_entity_init(
>  			&adev->mman.gtt_mgr,
>  			&adev->mman.clear_entities[i],
> -			DRM_SCHED_PRIORITY_NORMAL,
> +			DRM_SCHED_PRIORITY_KERNEL,
>  			adev->mman.buffer_funcs_scheds,
>  			adev->mman.num_buffer_funcs_scheds, 1);
>  
> @@ -2398,7 +2398,7 @@ void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
>  		r = amdgpu_ttm_buffer_entity_init(
>  			&adev->mman.gtt_mgr,
>  			&adev->mman.move_entities[i],
> -			DRM_SCHED_PRIORITY_NORMAL,
> +			DRM_SCHED_PRIORITY_KERNEL,
>  			adev->mman.buffer_funcs_scheds,
>  			adev->mman.num_buffer_funcs_scheds, 2);
>  

