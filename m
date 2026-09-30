Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6A89CA5FCF
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 19:20:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E821210F4A4;
	Wed, 30 Sep 2026 19:20:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="W03PUm6v";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7125110F494;
 Wed, 30 Sep 2026 19:20:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TXae2BxC4APIVeEm4+p8xMVCzXQCZ8qRBVCP2/SHfpKNsqfeZe4MiJf3d/k6apprXn2+0qDxIlqeUgcJLo/KxP4HB0saij4cUa6RbGSx4gzqHRA/bR/D95tU1MMTC/P0CF6t3ovnEZe6k+X3cFX9ETYDiXaP+ImwuPtKXUJdvwqzuormUAuxCIrw+QQJaAIQxS6qB7q25WoEfXg5vgZz3mucZtyIVMPVzHMcqLkyeeiF+9uC2XnBCfpkUvHu/sWu4tRUcxgAa36lK80m7l98zE/YfSL0Bek5n3Wh215ov5wIJMF2LxA4/Xf0clj7lG4+mwd3T7jO28inVjHSSgCs7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eyv1GdO86GPvc8orRqvzcLNz83XqvebYYKMbqcVS8zQ=;
 b=Qu1xOIzZNMUZRH4/KaN8l87jbcHBf1K390zOb7u0AFXMqndJymiipMCvbcBFC5OyQKfj/5AYDJdoGy/gfpo+iEcQ5bn9A/evUQwZdIYmOiuyuwRBNUizCDr8Vj/ZjmqHHXLC4LJjagyjgKOW7W+ZVQNTzJyxuyR+Ie7gH1Z2/WdsqZyTNGno587CnEIXZ7DN4aE4wWZ0qoGQ+9Hql/TJouPqsbCEOwudn2mRCRrrX2PtDgO9Dr4itnArHtWdmY5M2QI9dxqGW33fUZY0WR6lD8XheyiGLQilinwvIjpfFEvVG6LyLbPzQlOoRAw9YBbv6ZYvSD2EFEenuIyznvMZXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eyv1GdO86GPvc8orRqvzcLNz83XqvebYYKMbqcVS8zQ=;
 b=W03PUm6vrcIQ+Gn/l+whHrKYlBdx0RrDQPyAOeWVJy2XzdNNQEAefG8DewCbhzvsZ04VCwdrYFph6HqJq2nITtp/VUvALejAk5G7LZpwcy73fv/9Ts6VSJIRpQb0XoNcrYgsgXMvXQLqF5g1C3SX1fL0cHEMk9X5mGdagXgkQRc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by LV3PR12MB9260.namprd12.prod.outlook.com (2603:10b6:408:1b4::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 19:20:21 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%3]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 19:20:20 +0000
Message-ID: <4b923f65-139b-4a29-a7ec-babd0f662317@amd.com>
Date: Wed, 30 Sep 2026 15:20:07 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 03/11] drm/atomic: duplicate state of all colorops
To: Melissa Wen <mwen@igalia.com>, airlied@gmail.com,
 alexander.deucher@amd.com, alex.hung@amd.com, aurabindo.pillai@amd.com,
 christian.koenig@amd.com, contact@emersion.fr, daniels@collabora.com,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, sebastian.wick@redhat.com, simona@ffwll.ch,
 siqueira@igalia.com, sunpeng.li@amd.com, tzimmermann@suse.de
Cc: Uma Shankar <uma.shankar@intel.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Xaver Hugl <xaver.hugl@kde.org>,
 Pekka Paalanen <pekka.paalanen@collabora.com>,
 Matthew Schwartz <matthew.schwartz@linux.dev>,
 amd-gfx@lists.freedesktop.org, kernel-dev@igalia.com,
 Rob Clark <robin.clark@oss.qualcomm.com>, Dmitry Baryshkov
 <lumag@kernel.org>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, intel-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
References: <20260811171011.184964-1-mwen@igalia.com>
 <20260811171011.184964-4-mwen@igalia.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260811171011.184964-4-mwen@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0393.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:108::26) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|LV3PR12MB9260:EE_
X-MS-Office365-Filtering-Correlation-Id: 6054124c-9774-4641-451f-08df1f27de27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|7416014|18002099003|22082099003|921020|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info: gJGY40rteuenFcDZ1EnGN8psqJPQq6YKhXmbXKrxI7+fm+iwO7VNdQDD5zjCMjG/C8Hwg3Y/ZO+Xh2vxzmEQQIgiuXd3cFxqdigK8iOHkeXNXsYeFcqLj3GDnNPivyx6QjBB8vjZVcrxFbEy78GaL/zJy9F4fCvvn2guOfq6cv9eWM+4FqywdWR/bEKk32rf3jV4QvMoVIHgbqormMWmAjlk4x+M80myAOpVDPzgKeg5OVKzfIIadjbfBEgIgbGHPEhUnbIcY+fP5MqFI23jJy5vtlHTb/hKMmGGJeyUrhJQHQzgoSpaf58dazijIPnmqVhdoLet7SVGXtEqA5kj2mO3jXj61cEQN6er9oF9Rt7XOGA6c09Zeuc1q3Fp752ub0n+TqBEzdf5VENezGD6VM0jBm95UKs3CuV8JddgJZz3t4rtQOrntydgkL9tZ8t1osL1NvdVppPRJ6PSN2iEesPxxOsaze+ynGceaUV2vQoLl121HN45N5MvUAQYVdIc3Ro0MslIecRfosibaRPbWpUikIQtZfFeSfP4+w03h0otwCvMCBuPH1ObU04hqUfcD1fODjkwUPTgFBX3dLQp23h/JRmR2gv4aL7zWEnWZFLGUWc64mVvZjMSm+9TGu3Ut6361kCJvxqkMy98BRQgiN1gkNDv3EG3VNVLR9ZEHC79+o1/OfDWOd/nkER5xmL0I7mLkQab9OSqVt34dpbU3Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(7416014)(18002099003)(22082099003)(921020)(4143699003)(11063799006)(10067099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b2hLcXZTRGltcXAwR2tWUkk3em5Nd2hoejlyZkk2aFdjZUpkY242TGxIUC9L?=
 =?utf-8?B?ZXk2c0JjUGtDN0ZZU0c4alg1eElVbk5sRVlZKzNtdCtyWlBwNDdIa2VPQlJa?=
 =?utf-8?B?VW1VcjVsQitlS3hZT29RQWRvZ201NU00VTJCazdiTDJHVlZaa05Gd1R4OG1L?=
 =?utf-8?B?V0hjR28yTkc1UmF2TjBkOG5PR0d0SFpKNC9JL002NTBVSFNiZDZjaVlZaVI5?=
 =?utf-8?B?eWxMUzd5NVplbWU1b3prUml4bU40OWRMQ1RkR0ppZ1FqTzMrQXpzb2M1bWxs?=
 =?utf-8?B?RWRmUGt5Q25MbVkwbWl5bkd0UEZHWTE3UUdCNitiZWZ3ZUZGKzh3eFFOdXI3?=
 =?utf-8?B?T1p5MEQ3VGhoTFA4VUdXdmd3ejNiWWJMY3daZklSenN3QnZLbG9Rc1YrNzRy?=
 =?utf-8?B?TEpZSVBaZ2JXd3kyU3ZReDFaNzY4NWlSU1k0UnVWcFljN2dhbDU1Zkt1WmVn?=
 =?utf-8?B?d2VFbGJGRVVIU3g2OENVVS9TK2hrUnJPWnlEYktkQTBuTkxIeVpQTWJKdXFu?=
 =?utf-8?B?Nmk3aHFhUnRMMzRXMWlneXlWZTZ3dDNkd3ZobGdWZUQ5dXh1bUZNaVFFVkgw?=
 =?utf-8?B?WEJXdFdnNTVmTEVvQlllQ3hnYnEvTHRoNHNhWDZSeXJORWVIdm5YRXl4QTYv?=
 =?utf-8?B?bFFneVNLald6NzBGdU00SG91eVhKaDRJNkw5QVdqelQxUHlSQkpuKzlIUE02?=
 =?utf-8?B?bmVscm50TlhQdzYvZ1VKd3J6eTVjR2c1NVlqb25NWmQrdk5KQUZzL2RvRTNN?=
 =?utf-8?B?R3pBaWp4dkdUOFZmRGd3cjBRNHd2cURSMkNidWtuY09WaUhkQU8rbmlFQnpW?=
 =?utf-8?B?UUJXTy9MSTFGSEc5TER6MUtrYTR3Q1B6NUp6amNva2UyT0xaNzNzV0FhS0NG?=
 =?utf-8?B?QlhOc1FwWnV3RURoZ0JJL1dFeXRKcHVFMXBhRCt5ZWlFa3oyZXZsWk8rSkNm?=
 =?utf-8?B?cFlQN2h2dTVETkppZ2ZESndEQ3RQVE1DNnNwQTBNaHAwUTVNS01XdkJhME5J?=
 =?utf-8?B?TUJrVnI3OWFUaGJiVkl3cUV5UlBHNmxYT3FxSXFFSEhWdFhlME9EcXF1THdZ?=
 =?utf-8?B?QU5IYVdMSE91cE1kenE5T0JhSTNqdlBpRTdQQk9saklQQkl0SDVZRStPSWp6?=
 =?utf-8?B?SFRDRzQyTjR4RjNxbmlYS215ZkhSWnB6S2Y2SG50MkE2MVRiOGczb2ZDVW9G?=
 =?utf-8?B?OHB5WFBITW1jMVZQZXV4ZGZzQ1pSS3B1aWRFb1FNM3JNOWJITHEzaGRFSms5?=
 =?utf-8?B?S29QYVd4eVdwa0l4Y0RReXhrQmc2Z29TeU5EMVRaRFZKL25NWUxRNGZucnZV?=
 =?utf-8?B?cWRkT0M2VUNQSGRVNXREYzhSS0VpRG54MjE1amNneXovTXVyZDZZRnRqazdG?=
 =?utf-8?B?Slg4R2UvbEt2YStXQ0FRaVgrOFUwandEa1JscTBjWWNQS2NXSXg0QlFsdy92?=
 =?utf-8?B?eEVSVkZiUm5XZFh4b0c4YnlNQVJWdDNSVWlGTVVJVjUyQ29Tc2hJWURUd0xV?=
 =?utf-8?B?dUcrZi9jeGk1aGpjVFNjZ3hEZGFsTHpsM0lNbkN4UUxXbnhTQnRKTHFNNDVT?=
 =?utf-8?B?MFVHNXdVcmFsM2U4b0MyYjZDQ1NPeXB1LzNjYWJyaDVjeDRJalMrOWlvWDc0?=
 =?utf-8?B?UzdJejRoa2ZmL2V3M254dW1vWVdOSGxnN2FqSGxkR3ZmN0p0WFc1M1haR3BU?=
 =?utf-8?B?VW5EdE5aY2RZWUFzTGR0L0Roa3MrYzR3K1ZKcWtFY0l0SkRGRWpwcVp0R2x3?=
 =?utf-8?B?T0FJeHhwdE51WHdKdnFlSGYvVlFKS0hOK0lEYXBRcXF4U0U4VjNzQVpJQ1g0?=
 =?utf-8?B?WnRMNGR6Y1ZwbzcrNUJ6ZlJuamROTkJhbzc3VXYxbnNCQ0o4aUhjV2x5OThk?=
 =?utf-8?B?b0kxdmJjZEp0WE1YemhzdUtSN0ZjMmVaUWpLUWJ2eTY0WWFoL0Rucy93UG1L?=
 =?utf-8?B?NDRNckNuVkNGUDNJNWV4bmh1VGI2YXI1QkgzdzdGOTBqeVFyazBmR1NIcVNC?=
 =?utf-8?B?VXRrMFlIV2sxTDU1cGJDWG5QR2NHUDByVlRMeXYxUk1MT3pLQktFdWNURmNt?=
 =?utf-8?B?MElkRUdkSUtYYm9oUU9iQnFaY0NyN0IrTlVBMjZNREd1VzA0dVdTWmVMOEd0?=
 =?utf-8?B?YXh6SXIyN21XRk9URCtobk9SM2NaNzJUSGh0Sm1LSDY2bUJJWVpFMDNheGp6?=
 =?utf-8?B?bjFIcWptb0pEVXdZcFRRaXY1a1hCMFlyUHNpcjBvN2dPeCtaSnFMR083YkF0?=
 =?utf-8?B?ZUgxUFdJeDJCZmVUb0pUR1ppYTRkN1dXdFpzOWpCbkhrN1QwR3crTG9KemlH?=
 =?utf-8?B?bkxERWJjTDFBbjdDZytEeUZBZTJXR1dROS9tSU9sQ3pScDUvRWhhZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6054124c-9774-4641-451f-08df1f27de27
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 19:20:20.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a91UbFUny2RYrEAsAivRsLGgUUszoRHs/YwgGgLEg3fAAPJguy7A0zziOXuX3qUyQYEwp6sgh9VZSC+KH44B0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9260
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

On 2026-08-11 12:45, Melissa Wen wrote:
> Userspace expects that colorop settings of an inactive color pipeline
> persist, so that, when the color pipeline is activated again, preserves
> the values they had when it was deactivated. Colorop setup is expected
> to persist even during a suspend/resume. To snapshot colorop settings
> correctly, duplicate state of all colorops in a given plane, regardless
> of whether color pipeline is active. Depends on skipping
> drm_atomic_colorop_check() for duplicated state done in previous commit.
> 
> Signed-off-by: Melissa Wen <mwen@igalia.com>

Reviewed-by: Harry Wentland <harry.wentland@amd.com>

Harry

> ---
>   drivers/gpu/drm/drm_atomic_helper.c | 9 +++------
>   1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic_helper.c b/drivers/gpu/drm/drm_atomic_helper.c
> index 917fd0594259..11c67bb808f9 100644
> --- a/drivers/gpu/drm/drm_atomic_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_helper.c
> @@ -3801,12 +3801,9 @@ drm_atomic_helper_duplicate_state(struct drm_device *dev,
>   			goto free;
>   		}
>   
> -		if (plane_state->color_pipeline) {
> -			err = drm_atomic_add_affected_colorops(state, plane);
> -			if (err)
> -				goto free;
> -		}
> -
> +		err = drm_atomic_add_affected_colorops(state, plane);
> +		if (err)
> +			goto free;
>   	}
>   
>   	drm_connector_list_iter_begin(dev, &conn_iter);

