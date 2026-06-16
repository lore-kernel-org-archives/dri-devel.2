Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B3AFCD98E6
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:54:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F96410EB98;
	Tue, 16 Jun 2026 12:54:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MCbEV/xj";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F1A10EB98;
 Tue, 16 Jun 2026 12:54:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bdc5JhnKQSrzUnqbNA7/04j/VX9lFfaiq8ECJxPosMKh6u9ZgP4WymE4wAtKYVf1LICO40oID4gsuvwC2ZOp1EfYT55oNtBga/7hzD6z5SQeYl6IYwBBmXtsMtdgCEvjyHxenDacurWK5ZDDxgUjvyDpMKhTzuSwc5LHWIni1U5vqIpSY2XjJrN3Cx0m9IIfgBhZ0+0Z+UGwXhq4CVYbRZ3XcY1AwIPFC5o0rZ5A2mSU+HWWhdg2wp31q4TDCJDUbwyKu6MtnwO/BLJTb8X1gjFzxBt29s8tKB34hsrduXO39b0QonMc6lNWxNDgvHA4cYwBp/YpwnT0KZHQv/10+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V1MRJUWrE/I6PdwTasID8jB8STHOFuCiSCa2uDjPUR0=;
 b=bJ/+YKRXceLyb3YZOjnGgPGoSxgcXULtBZxjzuR9oi3eg4YtdYHKVlRlp/p98v3d9CT7zMzXPPJ8c36bnrIJyfEimMOfbUX209O6PIEvAkSK7cPvEz8G62FNBQI7x8XjMM+z2yEWg3FexNYR6C8xioqpNSg7hH29tZGhsUjDe8zRFR23mFWwUf/BD2ooIU0TZP89elSU9D8MOc5vtLEqn6eRhXWhyOJ7U6Rf5xhf/RVlc1scBJlILjDAVY9QC7j6xm2d/kAR97UnvSIq+sUO/aoUPISRhYiQco+853di/ls6UfYn2WnRoMIjqqPvMt8+HcMnii/Ortc9zmDzllj0jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V1MRJUWrE/I6PdwTasID8jB8STHOFuCiSCa2uDjPUR0=;
 b=MCbEV/xjDadkrm9DxdeQXPZhuNiU/auO6ISKyBwnAyGrDxc+1/IRhxraRqPUskhiIbplcjabpxvMYZIEWdBNfeUCivv2cuc4zVsXcldo2v4KWjDjQph8pd3buhf/SM/ifoXUvghnJGsfFqiKYgf+CaMhtiZx5cVFmmCedlDQ0gc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:54:04 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 12:54:04 +0000
Message-ID: <6efc2d90-30db-4a1b-b55d-8980b1175499@amd.com>
Date: Tue, 16 Jun 2026 14:54:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] drm/amdgpu: don't disable ttm buffer funcs on reset
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0167.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b7::8) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 264a7893-40c5-4649-faf5-08decba65867
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: AQ3wA+f36OFtoJhkseXKFfYKByIHKp0Xoe6eiDrBDu6WulFlK22cev57Q/NvW6/mZ8NZnsrH9OlrJT2rBhsEoggSu+pwFVzVoFCi2wSgpEk5JegIM+bVHnsDxYuJx8GzVAfO+n1CTiR5XkLZdBrKAwPh39sPY9Us6GG37CMauFrgz8DwMFyD56r/BBz0hInf9v8QWhijtizhre75/ioi+T6wNsGujbe19adAgdLgX0pYeZ9rRZbYAYn3eN4mGPIvFRWq77Jd1GLdL35ssHIgUwLTrHb51vwg9j6MWnaW/uDh41ooKcRM9QunI2MBwXWfWlHwFggUH2inDZ5Zm+OBW0Al2O9kkkAmxnzTDcoFYXkC/wB7GEc0pyOPQPETcKOD+a24DtKHoQQYQZXn+7BgEQBBYtawEB3Xhb1Ivbtm4wnn9Nuwf6YhcmHxW1qd2IZiqCTwCdRrkn9HFz1G4frs+raCEQEK5+jZZgydBrN81z0AtgFulLH/3HUok3+01qogP0baPdmiuZbOJbk5JdTDwKM7BwCR1INph8y/+vWgphKz0SKC3DzysPmMf554NUXh9UztgDkZWc5fSyKUDs/YpIP3qzaXp95q+9dEXx7/Xbcr/x1alME9sjRX7xW8Tp4DrBb8rArLefYRyqNc1jP1KdicMHMqgaJdasICKZ2ECs7JaayCfoRETJSlnJJurZEl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGxvNlVlVE9XOVl1NHBGZ0w4NTV4WjQzWnQ0OEdUOHZmYkRoWmh1K3RCdmlY?=
 =?utf-8?B?bnlYYzNxSlFkdWxOUFhCSnM3eE5PL3Fzam5QUkdPc09NUzRJVS9Pdk5wd2s5?=
 =?utf-8?B?cGVDdStyKzYwamdoSFZVNVJiTC9ZZGgyT2tQb053UWhSWDJQQlNVVll0RjdN?=
 =?utf-8?B?QTNGMjRxOVIvck9uT1lFclkvWENkczV1UStkSUpOclRIc0JFVmFheStPeUpD?=
 =?utf-8?B?NVpxaXRuWUdJeHZ1SXlQVFI3MldHWGtnQS9VanoyckFCUzFmZThwNi9lSENL?=
 =?utf-8?B?ekJCU05nUlh6amU3S0dxWnJGMExjK1JJSUxYZ0V1ZHpUVU13UzFDVlNyMnpz?=
 =?utf-8?B?bmpvbmVkR0JOT3ZxTjhPTWg5V2hKWUNvSm9aeEIrN0NtNDVoOGxDUGtFSXlu?=
 =?utf-8?B?ZUVXaVNkMzh0dFBOT0FHQjhiWWQ0R0VQT3RnQjMxZWtYaEN0YjJ4R0Q1L252?=
 =?utf-8?B?elloSTRHZ2ZOdS9JVjV0bnRneDJKZUlyMDY2VTlGeC9sVUVGeWxUSG0yZmFa?=
 =?utf-8?B?VFVaVmNueUdyelBlNWoyZ2hwc0FRTmtDSHVwa1l2SkdBYnFkWlc3cDN0ZFNm?=
 =?utf-8?B?QmlSMXJ4YnNWa1cvK1lUUllZbzhHSFRYN0tjYTE4MEJrMHI1WlhyYlNYM0k2?=
 =?utf-8?B?ZWExb0RPTWNxZ28vd2RoR0x3UGdBQWZraUlyK2xKUW9KOCtVSzlpN0w0RDYz?=
 =?utf-8?B?ZFBUQ2tHRVE5a2ljdjdwVFJEY0NCOWFBdk1DRGM0VVVWVjl1cy9nRkdmMDlG?=
 =?utf-8?B?RFFCa0lKb05rcnNrdlBGVW5LeklabkZtTHNVNmFMZGlSdzhDWU9mSWNOalZo?=
 =?utf-8?B?V0paRm1xaTNpTUtCYWVFa0pPWExQRE5CL0JsaWN1VEk0bU4ySFNKdGp6dk1C?=
 =?utf-8?B?NzhHaDFtRm9uVWZ5anBJZ084Tmd6aGJnaldHdXZsK2hMbzJ4VEdXSkk3UERX?=
 =?utf-8?B?cTdPZUFCa3FkK2xiRGlYaDJJWHJseDF0SGQ4RUVOME9oL2V1QlY5NVhvZUl0?=
 =?utf-8?B?QWQrc2l4bDRVaitNc0lBVVFDRWloTHpxTzJWQ0pIZmlQOXVuaGhINEhxbE1O?=
 =?utf-8?B?dCtIalRXd1JWTnhuNnZDVjJnOUFHTW9KaUd2alFUNFVGdURqNUJIQVFDZFlD?=
 =?utf-8?B?SlJtaVArRDUvRWJWczY0K0hqTmRwOVNQNFcrQ1ZXWk5hK2VaYlJocnBFN0RG?=
 =?utf-8?B?TkZTVkQzdUdmdTZXdG9xbklYdkRiSjJSeWY1ZmlleWlRRFU5TmUvSCsxc2V2?=
 =?utf-8?B?MDAwT1NYcEFjZnY4UEU5Z1R1LzkzSFVGQzNJMS9pVUJLUGpqaTNFS1hJd3dV?=
 =?utf-8?B?OWFFWE1INk9PU3JGbmU1NGpnUE03UzZXNHFXU2hMQi90ZFRJbU44WG9rTVZB?=
 =?utf-8?B?RGtwcjRsWDlOb3IwQ1JyVUpxbmlWd1AxNThPQ21VYXZPcStoeWJCeXdlaDVv?=
 =?utf-8?B?UHBXUGNWaExxdWNCOXRKdnNIZlFGd1lhMmtNb2w1Wm9uWDB1SGdjSGw2Tksv?=
 =?utf-8?B?YzkrcXhtNzVpbmRLOVFNZ3dHK3pWcjY0L2oweld3K1VpczFQa1UvUzkrdkdn?=
 =?utf-8?B?elQwOWVwWDBLUlBSYmlNbklLQ2daazc1WkhyN2NUOGZlV3phT3FoZitsaHBL?=
 =?utf-8?B?U3RCcmNyc0MzWmhwSGZNTWZKdUdKSTV2YkNUWjVTdWlwRlEyU3VKTnNGV2c4?=
 =?utf-8?B?V21yZEFYVlltbHJBSHN0bGZnSWgvcCtpeEhPbkxjMmVYamxpZkdYNjRlSmlB?=
 =?utf-8?B?dElSVk1qYnlKNGc1b0M4RzVGTGpSYkwxMWhmZ3N3b25KR3JPYUxaUU50YTFS?=
 =?utf-8?B?RENHSFFPR2tCdEZ3cmhrQ2NtUjQydGtBcTNQdzRtNmdmaEdjMUNPVE9hQ1Qr?=
 =?utf-8?B?cm8wMXVDOHhPbFRtVzBZenJtelE3QTIwZUxNWGFpTnBzVURzeHRrajd1a1l6?=
 =?utf-8?B?cXpoV0djMXdTRzNnZkdFbjdPejZGRU8wT1gwMXZaejRkRkpUVE1Cbmx1NERv?=
 =?utf-8?B?QnJmaFBmVXB1R0F0WFlWKzZYY1VXb2tCbnl2cUlwbGFUTXVueUZXWUY4Vnpw?=
 =?utf-8?B?S0NYb1BlcjRzUzBvWGI1MEN5ZmpMSktQVFFzSHBzUGkwb08vL2F3SG01RlB2?=
 =?utf-8?B?M2NqZHNpTWlxOXhwTEpVTUxMM1A3akp1UXBKSHkzOEZ5RWFGenFmN2tpSGp2?=
 =?utf-8?B?T0tlbVV5TW1WVUUvQ1JXd2x0RU9ocnoyRnNLWkxFRU81WG9xWVNnUHN5RFI3?=
 =?utf-8?B?Q1g1SEJmZjJNcGR6TndTYnd4N2ZJRVF0Mml3ODVsQVNheGx3Zm5mU1hLZEFY?=
 =?utf-8?Q?o5WI4AJEfo1n5UrnQ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 264a7893-40c5-4649-faf5-08decba65867
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:54:04.3633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JkGmverzva6WyS3op0ZwpJu2uYHWic7Wc9+D9sSx40B9v5JzjRlWs77BkI2cpzyQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

On 6/16/26 14:50, Pierre-Eric Pelloux-Prayer wrote:
> Access to hw is already suspended so there are no reasons to
> disable ttm buffer funcs.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 6608780ffef2..57e10afb4714 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3167,8 +3167,6 @@ static int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
>  		amdgpu_virt_request_full_gpu(adev, false);
>  	}
>  
> -	amdgpu_ttm_disable_buffer_funcs(adev);
> -
>  	r = amdgpu_device_ip_suspend_phase1(adev);
>  	if (r)
>  		return r;

