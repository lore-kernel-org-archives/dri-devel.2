Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26346C5CFCF
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:49:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5897A10F3D4;
	Fri, 14 Aug 2026 07:49:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="ux7ANZ8U";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB2E010F3D4;
 Fri, 14 Aug 2026 07:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dJ684Q/DuIhatJgijqtDrYVkm0KjfWLRKW8uMc39jrKwFY56zOYP213Az2BqE7mSmk9FxLckch00tQoBcOkd6/31BWdNeWRSS0kOM7yJ2fA0j0Fu2mJWYQl3Knp47wQkU3OttpCRn8fBZ3boRA+I6D3Veq/GhuHfQ4WoCnvw53elSDVB1NkU+UUFumfFe9Iny1NN71ZLiZsEw/hNB81oMFt3U6+rvpPSex5W9YDkHvtbBeCAyPmuJYh0GDao3pbthKY6wTjNXn6JwAgWFbuGxunhx6r7AnjOVDIe1bxDqjjGGASJ7L2VRPCjLkjQkQR04MSJlszyG9m2uOIxI2bm1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/T0tK2eQ94kj5x3abwhBs3IZJ/oxLJXpnfej+WpSrHY=;
 b=h/QmHu94BhHGFVpUwiLJF8t77JTLboRPpwUcCoEX6deKaTnyRXIZqWw7E+IKA55ew/dMKadCv3Qi8wj7PUYhiA5FHZ5rj0yIDOpPLU0Fw/LIowwx9UJDVt5zCcHZQ9YSnaUk9BiLQYXZLparRd6izgXmN5GbZbMwmwF5CcTv3ZiCsJh1hSmT5JKDlFJPbWGQqMqwfazw0/Ub0NkG2atiYDgRSC0A9r0aldkKGGuo/fpIT3oR5iLHXK1FlfgW8rkJ2lktaXsLgGuqsjuK+A8aWmoT+F0RzK1cDK6h/t+ay2iOrjGnML3RjEZOtw/+JSWd1JaZoSnEoX26sslPYQnfBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/T0tK2eQ94kj5x3abwhBs3IZJ/oxLJXpnfej+WpSrHY=;
 b=ux7ANZ8UJBLJX+nvrPsdryFlAOfgDh8aWmVvkpHJ0twYwArpa7XoVBZQ509FA0GabksWb4n5u6PmfwMn0iAh7b2TalgCGm1GHXglU1yGRMDgjAg2xGcG+3uF5xPlfknlm5e4GKoK4XOQT+ql+KmbY2y+GOgrRDU+3xrOdyiprKg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 07:49:37 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Fri, 14 Aug 2026
 07:49:36 +0000
Message-ID: <29bf8059-516f-4b59-bee8-3a5af7817376@amd.com>
Date: Fri, 14 Aug 2026 09:49:32 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] drm/amdgpu: skip amdgpu_gart_unbind if the device
 is wedged
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
 <20260813170705.15745-4-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260813170705.15745-4-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0073.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::18) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 86987d35-3f58-41e1-d0a4-08def9d8964c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: qUg1LxyDE7qWyKPdbuAuyBzwPurYyXwXWo2D7LEL/D1Aoh83atcRnVIdG0GcBy6tE2nWZ4zfvaeEQdXdSTkAFOTnXLwRu/k6arJ63fm7RnfTUrtsK/1PgHXaTcEwFQtidlfELRZ1dkmtBCXp3ISaNWOaOf2o3tLaf1Ia699JH6vw/Uh8eP0Jqx6LK6nMey4XHDPgXEFirLUs8+afT+5+aQI8X8QlU0Ouvi+Mz+Tj0o/uNwNoI+FtR2fNXouYbVRFcvNhiynM3gU3dyUd30d9doubGNeG+0joDZq6t8Jyc3kpeC18qXlnWqwxHpbk25ML/xHTptWK/BkY0YVkg22k55blq5pw/x3jcm1wjRYG+SoCTCT4CuzLRFyxjtBs00MWCOzFYBe3w97o7OqC2f174VNFtDkDir++Z8ImjRbHYpLTulEy2v8uoOhtlVNUdPuoiAwtxHMUIBdUDukx1PEvctZ79isXKX/aJLvv7Nmo0jqhc+bFPS7q5HQbJFuJsBAO6JEXl4GMQluLKVD9DK+Hs6Vu5ZPvIbSD0jXPPSe5/AAkiFzu8DSOveDKUtee7YtKDkNGHV1T1Hmvu030qlrW1nxVkIgkZ6w+JL+2A8IvIIGIQzsNmuMQHGloFwm2Mk196fPMzdqlVjbML14KIBDQF2ryE7oSQNo8lKo6ZxeD6Zw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZEI2TFBxRmtSSU4wMEdJMVRodkM0OWQrQ0JERmg0NlB3Wk5wc1VNR3hORDQ0?=
 =?utf-8?B?QmpLejlwTUJLaHg4WlE2LzIzWG1YWFJiRFJqZktaTEFUWGlVd3FSV0k4TFpN?=
 =?utf-8?B?U25lZlNlSUVPb2FnM0xidXVyMU1wWGVEYTlUcXpYNmlDT3N1blJUY0lVTlg0?=
 =?utf-8?B?RGJuNVFRNHAvNGFXME1ZK0RBcGZzeEMvRWNScFVHT0xCbWdJSU10TEl6QmF1?=
 =?utf-8?B?SitCL0ZPb2cvMWlJZUcxR3p6VEExNVhsNTJ0eko4NDVjTDJqMjE0cHZvS2NY?=
 =?utf-8?B?NEMzVkNuR3JlemZqZkFtaE1LWFFFaGtxY0dtbmpTb2NJOWxRTlB4ZWU5WHdK?=
 =?utf-8?B?YTZiemUvUzBES1dRUlFUanpiUERPVStpcnZSN0c0Z1dJeEQrdU4xVDAwY3R5?=
 =?utf-8?B?ckhXSXFtc0dacDJ4a1FOUHM0dDN0UEVwUjhZNm1pTWRzVU9rdHVtOTBjcHpE?=
 =?utf-8?B?SUJteVR3SGtXRGZUY0FNTDcxLy9uQlhEZ0d6azJ2VHJHOWdJLzU4akV0K2N5?=
 =?utf-8?B?VFJOOUljRFlERk5ydWN0bFZwNkx4TXdDeFRoalJiQS9JOWdvYXFGblNSYjZx?=
 =?utf-8?B?c2tqRDBxNmFielo1UnRHcHhGbWU5UXE1QnZxWXl2WmNRRnUrWjFWRE9XVjcw?=
 =?utf-8?B?NldTdDFsazVOWUNIblFOT01FbFVzR09IOXh0RVgzOStvTXJGbzkweHlJMTlM?=
 =?utf-8?B?NFM5NUtTY0JIUnlCQ2JWcEF5cjFaQzUzRzE0bGtjM3ZOc0NyRXg3Y1YwYjFr?=
 =?utf-8?B?Sm1jeXlmUjg5aTdGM3I3bHFFL20zbnhFSGhxSWliQ2twcGIzMGNoMVVJRU9P?=
 =?utf-8?B?eXExcUZBREJkazg0UTNmYUJpZmliaUYrbThWMGFQOWc5UjRtMzJHOHlSUGRL?=
 =?utf-8?B?R2syeFZkZi9WdTM4d3hSb1czaVhKMHhRN2FKaUgxZlBaSUZlWjJGdzNXT3hr?=
 =?utf-8?B?SGhEQXZTbExaNTc3MmhiL1pyS0FFaUxhUDdPSnRoalBFVUJsZDJWelJyUmVy?=
 =?utf-8?B?STZxemRLWWRpS0pTaXJXS0dnYzNUV3FTeHJxaTFYbzk5NUpLQUZkNnkvZG1p?=
 =?utf-8?B?QXloMjdYdU9yUkZrcCtoQ2hsSEtnallwMTJJcFBmazVHSGpubUtHQXkrUHd0?=
 =?utf-8?B?eHJDUFhKZmRIdVgwT1d2S3VUNXJ5R21oUHlaSTZBSE9Ia2dGSmxhSkVuSE1S?=
 =?utf-8?B?TURid0xYRHppdW54YkFlbjlwZ2JoSjFWZCt2d3BFT1NTQVFsUHFZQjNuZEpp?=
 =?utf-8?B?dXVUVGVPK2UrT2VpTkt5dXZ0cGt4UWYzaXNHdUJzOWUwRlFZYm1zR1RIcDFF?=
 =?utf-8?B?UDdOSmFCOVkydFBqM1JDN1gybDY3QVB2YnExTWxBaFhaaHhPZVpiSjRXSHhF?=
 =?utf-8?B?eWlwOGY0bS9JR3J0TkFtSzgvMGFKVGxTbTZBYW12MHVNdDFUOHBVV0tnTjlz?=
 =?utf-8?B?V2xWdTBNcVFYc2tmZDlMRVhUQkVVckdMNHZVMlNUVFE0bUUzR1JHbVgvWWFN?=
 =?utf-8?B?OE5EM0YxVFZkWmRxWUdRTUxMQ05sUWI1b0Nrd2k4QjVScUJhdTdKNGZ0b1pi?=
 =?utf-8?B?Wkptb2VKd2VIc0FWaWlQUGVibjJ5V1RXQ0F6bkcwVXpsc3hDbFZPTllKTVN2?=
 =?utf-8?B?cXQ4VlRFTWJXS3AyYVFXR1k5cFJac3RlM1JNQklIaW9JUlFTcngvaEZqbHYx?=
 =?utf-8?B?NGRIY1FXRXNQUmVySGhWNWdlQnVWc3pBeVNDSVR1QkV3V3FxekFQd2dScTc5?=
 =?utf-8?B?MzFuOWNBeWlRaStseTN5dWNQUjRkRXVvQmlyWXJONGV3ZTZhM1FCZEFRMmg0?=
 =?utf-8?B?bjUzdVVnNSsreUcwU3ZXRWxoYldnWjdoRDNxdXJ3MW1PWU91V24wNmhmZzZh?=
 =?utf-8?B?WWEySGZLQnVML3I2MWc3L2dNeFpQbVJyckdVNG9YRzZwVTB3eUExMEp0bHho?=
 =?utf-8?B?WXBkSDZ3NzdOb0dLSTVRdytXQVZqYlQvUUZZSVhrTzNZaGVWbmFNV1oxaGdV?=
 =?utf-8?B?d1JWQVN2UDlIUngwWEdTMHVuQWRCSkFUK1BnSDAveEQrY0NsV1VvSURLVk52?=
 =?utf-8?B?bTNueFgwTitaVy9mT045WVBweTJpOWhiNFQ3b3c3OG1SVkZMYlZmSmhJRWdU?=
 =?utf-8?B?ekQxdHY5bDhEWmR0dWg5L3I5bFNrWk1UZklaUDVLejZuWE9GcnBCOHN5MUZR?=
 =?utf-8?B?SFVneWdiNVc0anNQK0RCaXhMeHJrcUVIVXJHN0lHa0E5Q2hkZ1FrbWNmZFZ4?=
 =?utf-8?B?YzVMUEpRRGpQNm11R1hFdkkwenc1SUpxRnIyMGxsOHpocGFPRktsOWdOUFo0?=
 =?utf-8?Q?Ex4cHKa/NjFm+buPH/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86987d35-3f58-41e1-d0a4-08def9d8964c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 07:49:36.4359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7K8PdgVpp86Xer5mFpemK90ITFIpPMBq9GOkIrtFUZVPR3nQQK6H3apc+4GD1he9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7803
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



On 8/13/26 19:07, Pierre-Eric Pelloux-Prayer wrote:
> This operation requires access to the GPU.
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> index c4c21dbbbdbf..09ddfccb8174 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gart.c
> @@ -315,7 +315,7 @@ void amdgpu_gart_unbind(struct amdgpu_device *adev, uint64_t offset,
>  	uint64_t flags = 0;
>  	int idx;
>  
> -	if (!adev->gart.ptr)
> +	if (!adev->gart.ptr || amdgpu_device_is_wedged(adev))

That is a good start but certainly not sufficient.

We need that on every occasion drm_dev_enter() is called in the driver.

Regards,
Christian.

>  		return;
>  
>  	if (!drm_dev_enter(adev_to_drm(adev), &idx))

