Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABCCF33807
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:11:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C966810E34E;
	Tue, 17 Mar 2026 07:11:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f63thI5r";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C33310E34C;
 Tue, 17 Mar 2026 07:11:27 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7nLgsPvyyCRhDBK0gzAVsRDxTi4NwtsacoUtkA/AIkCnNAj5ID1Htzent4iOatR5Ia7LrcrmySplW/RazaIJnr7vV0pbTopScNNg5sJO8cXAuUpEJABqxcu5/9JwJPpUcvLUkGk2mmBwSgXmBdq3a3k63ckLqEHsbFIERYYlrxeq+M+VF2QK4msTWVpXhdO0OF/yymoIA/gaCvzVKn5l3x0hKoEowmBXJ2v0K1Ijc+7QQy9rDNeoDDwbXW5oophi9JGNsFDxoK7eOusCtloi78l2PqBL+1bSSf5WhBATYahJGq0jsUZydIFqGtT5jOZqMr7X+nEl8ziVU4rrc6Wrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x0NWFChTFWjgyibdT4NQM2vbwx9Hv9q0BGp5i7uerog=;
 b=p3PWjfjCgy/gayo1tUlIKvUPma/T3xl5oC4Shm8vVDMQCASi8/BeT124z28PwthShq9EhKKvfALnCT9U/BlGL/7cwnBhnVtY3VrbUszd2UwuMzPLAgoDBRbqpXHEyIpYlzC7p3HP9Xl5LiYO3rEaeful/B5tieXoV/bIKVNmWjpKf/I0EYgNxDk/tWblJFMH5/4+xXCoXNRYQSvyrcCxrBT5bGBH6+GYxwBbD+KZqVPKM1hb/auZTx5h1d48uBr0wGqkUX0VQAOeTQHi9GOqrogJUn5e87EoKcdKVbA0bYrsEc9fYX7UDgN3qH2rWJF5iSuymcjhJRuxPgEoW5Lrew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x0NWFChTFWjgyibdT4NQM2vbwx9Hv9q0BGp5i7uerog=;
 b=f63thI5r5qTt9u5Pp0segb0vgM44jSpYr0uKmPlXzYkOQFeZ+YHjHfvnlhiMgADYOK4p7c+XjzxFPfzM0i0i7ddSGCJ8fE1AtIVpXZNUJYtPLuJD7OUUbm4YHME4zeBJij095c/lm0UuIfcZGGoEgQxv3LBod4jiDlAeKqYAlv4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MN0PR12MB6080.namprd12.prod.outlook.com (2603:10b6:208:3c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.14; Tue, 17 Mar
 2026 07:11:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9723.016; Tue, 17 Mar 2026
 07:11:23 +0000
Message-ID: <8aea894a-1dd3-48d3-b21e-23b8c2796e0b@amd.com>
Date: Tue, 17 Mar 2026 08:11:17 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amdgpu/userq: refactor MQD init into per-IP helpers
To: Junrui Luo <moonafterrain@outlook.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, "Liang, Prike" <Prike.Liang@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Markus Elfring <Markus.Elfring@web.de>
References: <SYBPR01MB7881D8124681BC48D009E222AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <SYBPR01MB7881D8124681BC48D009E222AF41A@SYBPR01MB7881.ausprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0277.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:e6::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MN0PR12MB6080:EE_
X-MS-Office365-Filtering-Correlation-Id: c864ca2f-c083-42b3-8953-08de83f46538
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|18002099003|22082099003|56012099003|7053199007;
X-Microsoft-Antispam-Message-Info: Sp4D8Wdsp4Elgrrk7rJ2p/2CjzpLisxo86MsorDpOZImtPN5CIzwTJBdBzepbRCa6Pvqn6XNOfL1gn9xOZhoEqK9kspNztbu9pNWYvQLvCn1kuHR5mIA0Aj3dWGrubTS7zkSyMlhyLX9moS4BchfukYDoMGGldKjAh0x32C1m8g9wvD3CPKEdknY6IAnQyMav3HUjyt3c7FbzO6LKaeTBRlxeumKB7TKtuBlfilOKJzP8BNBiBl8bLRXmLffTeZVFBFE+TSyKbZpArvFFJZunG9PV56XYbeqYlMKi5FrKWIXPX9RYm09iJG5N0rflOa/X6/zX4IIJht+r0LWwaklNbXms4tpNcbSu7PKy1s7jjsv+HZPw36h6DWNVziyjOxHrDPvQBYUHnGBM3eKy4D9KW5DKjdYQ/hLSX6HcRjlKEyfhs8ujhcYC0KeOCCmtZRc26WsFhncZcqFRcv7sI5xM2LlejAugqM8WvueNB96Or8MVFcH/RHLIaxDwmebki3cheAg5kMVQyfrQxCBoJ1qLpbJY0jCfq5NMsW4ebzTdnHfmExAJp0zWpChdRfN/eoDXQC4qNq9E53RUaa3kMiRcm+P1PDS6mhde5T+t62mcYhONOW4ODmEffpE7pppMQ+YjTI1YZVVJcV6bPi3xnRzOr8BzLXKw/4qfJcAayLn6JZGUMAy59AcyfkM9LcIyj0VAABQ7kzpp6SE6b8vS2JS8FMv9orj22Zn9XS0OMfn+l/eqk5/1fByAhjs5s/k1QB4
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(18002099003)(22082099003)(56012099003)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VTVlWHE1VDB4V3hzYXkrNXlHOERtQ1dPdEV2RWhTWEMyK3h6L2JjT0RxVWor?=
 =?utf-8?B?V1FMOG55OVFzNkhmQi9tb0xSNHBxSUZ1L0puMlJVNnRBNEJnZXhqWXcrVVJY?=
 =?utf-8?B?aERZVnl1Z2NENDZOdnR6YU5PM1J5Z1MxVG9CdXJuSjlsMkphZmIvb1huVkln?=
 =?utf-8?B?WmhZRmZsTUh6VXZZbDZiRWRaY0pXdnEvREY4QnJISm9EY21Qd2x3dUZlRWIw?=
 =?utf-8?B?KzYya0hUVGZ2V3dsWUMrZVU0VFBOMzk5QW1WOGpFWGltMXJHYzVEbStjQXFK?=
 =?utf-8?B?NUNwcTJPbWNlRTJFZm9lZ005MUczVjdUKzRkWGJzSk5FQlpRWXdHSm5iTUwr?=
 =?utf-8?B?UTFLNHlnUE1NTmtGUWVoOUI3YXZnaWFDemRaaGU4RjJXZTg1OWZ3QkJQSFVN?=
 =?utf-8?B?bUI4WGhwWExqbllBTTQwN1JvZFlPdVFqVXI1d1FmREpic3JEVTg1dnZFNE53?=
 =?utf-8?B?djgvZXREM21UWlJoV0pLcU15a1p1cklxNU0zcjN2QjdUZnJLZFNkV2ZzbUZq?=
 =?utf-8?B?SFQ2N2V1V0RKWitVemRnNlVBdVFLclhkeDYvMitPRGd1aGhDSnZYeTFtKzZC?=
 =?utf-8?B?TzVLWGkrb3hkUnNmaUphUEU5bjFzb252NDh0V1dxR1lZeXl3elc2T0NncFk4?=
 =?utf-8?B?NTVkelF4NlBmTG9Fb21JYkc3aFB0USt5ZE1uWGpWU2hvd29ZTDZzT0R2KzM0?=
 =?utf-8?B?YzJ0YTAvTDZXRjUxak9BaytibmJXZVd4Nk0xTkQvdTBXREllVCtmYjRqc0NT?=
 =?utf-8?B?M3VMUlJyYzVkN0FaYUw1T3Zld3NlTUhYYlZzUEUrRGQ5ekdqV29OTklOWkMz?=
 =?utf-8?B?dE9vaFViSHA4U1NoREZwTkhCeTBIYUpyc0dLTm1XaG40a1FnWnVEWTAxaDhT?=
 =?utf-8?B?RzhkUHpsdEs3NXZUem1kY1VWcFdJSTIwcC9BY2FGZUtSUU1SUU54Z2d4dnR5?=
 =?utf-8?B?czBvRkQyVEM4RzNBclh0ZmlycWlNSkJSMHFiZVRxMk9UUkxJWUhjR0RFU08v?=
 =?utf-8?B?MlVxN0JYU251N2VRdVo3bURMRTlJUFFYWlR0dW5iSUxnL3ZtNUgyb0EwUzlS?=
 =?utf-8?B?Yyswd0tNZFM0aElZVzdBcG9zaXpkekw0MGpsTGxRbDM0RlMwRk52QnpRbjF5?=
 =?utf-8?B?bXBibDdUc2dTMGxLanNLemFGYTRXajVYd3V2MDlqVzBBdExXdFF4S2IxVGZk?=
 =?utf-8?B?U1pMdnFkL1hSdWxtR3NpeC92ekd6SG9tZmFSN1RoU3JvbDlLS1RzODJmOGdM?=
 =?utf-8?B?ZmlnVHhOTTE1ZnNpT2Q5WXpDUmxkQTlOcS9rcmdCWlllRWppUUFYaCsvV0gy?=
 =?utf-8?B?NTNqVTN6MW5ucXhRV2ZCS1djRHBMaEtyZ2lFRC9HSmpqOGI2eUFldk16YVB0?=
 =?utf-8?B?ZkRTMUJLMjNsVmFHN2U1TTRIQlI2S3B4M0FBMGY2dzdyZThqZW82Y1NueWdi?=
 =?utf-8?B?bXhWcnk0NHhFbjhXb1FoUGlqQkNnb0lFSHRqUDVxSDk3SkRPeU5VY3Rua0Na?=
 =?utf-8?B?ckJ3eGVyMGNYWVpJd1VoTS9Nd3pDVkZIMU5mVU91UnBxQkovcnpYbEZMakdM?=
 =?utf-8?B?Y3VBVFZqOHgyVGowVGRjZWpBKzdwdjd5bk5zUXViNnozNjBjT1g1K1NDcHR2?=
 =?utf-8?B?WTU4VmxaS05sTVZ2N0J6K2tENWZQZG1DYjRVRDRiZnFCUWR6SFVhUVZmRGJI?=
 =?utf-8?B?Z0Z4QUcrQy9nTGRxSUx5czhmN0NoSjlCcHNjcDM3TE4zQkVpeUNHUkxCR1Vy?=
 =?utf-8?B?eEtJMWlzamt5QXZyMGF2M3ErNjhER05zWkEvTE5FM0JiMytzUFJBZ2hYVnFp?=
 =?utf-8?B?Tlg3NXQ5WCtRSyt5cUsvRU8xblBkTXg0VFFadkxDTnJja081Z29jYmFSWWh2?=
 =?utf-8?B?by9OVUFDZkpyL0xla0E1cEtIZ2d2MXVjRnRkdmFreW5JbTFtdzlzcXRybFlP?=
 =?utf-8?B?aDV5Z2h6VXZVWnpZSjQ5WXpZeTR3Zk9IdnJDeG1Ha0Q4SmJEMkh1V2EyeWV2?=
 =?utf-8?B?bHoySjBMRGpiSGJlL1RWdS92Mlo3aVh5ZUVrY0tNR2VJajBUaU05Zk5oZktY?=
 =?utf-8?B?azJ6ai9pd3pGVm9XT3NORFV6WmgrMThQTnQ2cEhwQ2E0ZDdEeFIvK1c0VGhG?=
 =?utf-8?B?S0w2V2FzNjFQdTkyVUgwMHpycENaMTZGOUpWTktDY0ErZHYrTlJpbks0ZXZV?=
 =?utf-8?B?di9YQ0lndWNIbisxQ3U3aGlPeXQ1dTBmU2tmSGJpZTBqd1huNjZ0VjlRVklD?=
 =?utf-8?B?WVRNUW9GZ3ltOHlpdXVxUTA5RDVYUDFJakhFbk9Ub3p2SWxrQ0pGRDZxelY4?=
 =?utf-8?Q?TOPGv2XV7M7Sb4IBoA?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c864ca2f-c083-42b3-8953-08de83f46538
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 07:11:22.9462 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T6sXBGOlezwu1XvjuCOyWFaCn1kvlOkQNVG6ZfrDn8MzDvwe6ZQkNaOSTU0J4Ca1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6080
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

On 3/17/26 04:14, Junrui Luo wrote:
> The three IP-type branches in mes_userq_mqd_create() share a repeated
> pattern. Extract each branch into a dedicated helper function and
> introduce mes_userq_mqd_read() to deduplicate the common
> memdup_user + size check logic.
> 
> Each helper uses __free(kfree) for cleanup of the memdup'd
> MQD struct.

Please don't that just looks absolutely messy.

__free(kfree) should only be used with kmalloc() and not like that.

Regards,
Christian.

> 
> Link: https://lore.kernel.org/all/SYBPR01MB7881A279A361F81B670CDEEAAF42A@SYBPR01MB7881.ausprd01.prod.outlook.com/
> Suggested-by: Markus Elfring <Markus.Elfring@web.de>
> Suggested-by: Prike Liang <Prike.Liang@amd.com>
> Signed-off-by: Junrui Luo <moonafterrain@outlook.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/mes_userqueue.c | 205 +++++++++++++++--------------
>  1 file changed, 108 insertions(+), 97 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> index faac21ee5739..0d7ccecf7c1e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_userqueue.c
> @@ -272,6 +272,105 @@ static int mes_userq_detect_and_reset(struct amdgpu_device *adev,
>  	return r;
>  }
>  
> +static void *mes_userq_mqd_read(struct drm_amdgpu_userq_in *mqd_user,
> +				size_t size, const char *ip_name)
> +{
> +	void *mqd;
> +
> +	if (mqd_user->mqd_size != size || !mqd_user->mqd) {
> +		DRM_ERROR("Invalid %s MQD\n", ip_name);
> +		return ERR_PTR(-EINVAL);
> +	}
> +
> +	mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), size);
> +	if (IS_ERR(mqd)) {
> +		DRM_ERROR("Failed to read %s user MQD\n", ip_name);
> +		return ERR_PTR(-ENOMEM);
> +	}
> +
> +	return mqd;
> +}
> +
> +static int mes_userq_mqd_init_compute(struct amdgpu_device *adev,
> +				      struct amdgpu_usermode_queue *queue,
> +				      struct drm_amdgpu_userq_in *mqd_user,
> +				      struct amdgpu_mqd_prop *userq_props)
> +{
> +	struct drm_amdgpu_userq_mqd_compute_gfx11 *mqd __free(kfree) =
> +		mes_userq_mqd_read(mqd_user, sizeof(*mqd), "compute");
> +	int r;
> +
> +	if (IS_ERR(mqd))
> +		return PTR_ERR(mqd);
> +
> +	r = amdgpu_userq_input_va_validate(adev, queue, mqd->eop_va, 2048);
> +	if (r)
> +		return r;
> +
> +	userq_props->eop_gpu_addr = mqd->eop_va;
> +	userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> +	userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> +	userq_props->hqd_active = false;
> +	userq_props->tmz_queue =
> +		mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> +	return 0;
> +}
> +
> +static int mes_userq_mqd_init_gfx(struct amdgpu_device *adev,
> +				  struct amdgpu_usermode_queue *queue,
> +				  struct drm_amdgpu_userq_in *mqd_user,
> +				  struct amdgpu_mqd_prop *userq_props)
> +{
> +	struct drm_amdgpu_userq_mqd_gfx11 *mqd __free(kfree) =
> +		mes_userq_mqd_read(mqd_user, sizeof(*mqd), "GFX");
> +	struct amdgpu_gfx_shadow_info shadow_info;
> +	int r;
> +
> +	if (IS_ERR(mqd))
> +		return PTR_ERR(mqd);
> +
> +	if (adev->gfx.funcs->get_gfx_shadow_info)
> +		adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
> +	else
> +		return -EINVAL;
> +
> +	userq_props->shadow_addr = mqd->shadow_va;
> +	userq_props->csa_addr = mqd->csa_va;
> +	userq_props->tmz_queue =
> +		mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> +
> +	r = amdgpu_userq_input_va_validate(adev, queue, mqd->shadow_va,
> +					   shadow_info.shadow_size);
> +	if (r)
> +		return r;
> +
> +	r = amdgpu_userq_input_va_validate(adev, queue, mqd->csa_va,
> +					   shadow_info.csa_size);
> +	if (r)
> +		return r;
> +	return 0;
> +}
> +
> +static int mes_userq_mqd_init_sdma(struct amdgpu_device *adev,
> +				   struct amdgpu_usermode_queue *queue,
> +				   struct drm_amdgpu_userq_in *mqd_user,
> +				   struct amdgpu_mqd_prop *userq_props)
> +{
> +	struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd __free(kfree) =
> +		mes_userq_mqd_read(mqd_user, sizeof(*mqd), "SDMA");
> +	int r;
> +
> +	if (IS_ERR(mqd))
> +		return PTR_ERR(mqd);
> +
> +	r = amdgpu_userq_input_va_validate(adev, queue, mqd->csa_va, 32);
> +	if (r)
> +		return r;
> +
> +	userq_props->csa_addr = mqd->csa_va;
> +	return 0;
> +}
> +
>  static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  				struct drm_amdgpu_userq_in *args_in)
>  {
> @@ -306,104 +405,16 @@ static int mes_userq_mqd_create(struct amdgpu_usermode_queue *queue,
>  	userq_props->doorbell_index = queue->doorbell_index;
>  	userq_props->fence_address = queue->fence_drv->gpu_addr;
>  
> -	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE) {
> -		struct drm_amdgpu_userq_mqd_compute_gfx11 *compute_mqd;
> -
> -		if (mqd_user->mqd_size != sizeof(*compute_mqd)) {
> -			DRM_ERROR("Invalid compute IP MQD size\n");
> -			r = -EINVAL;
> -			goto free_mqd;
> -		}
> -
> -		compute_mqd = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> -		if (IS_ERR(compute_mqd)) {
> -			DRM_ERROR("Failed to read user MQD\n");
> -			r = -ENOMEM;
> -			goto free_mqd;
> -		}
> -
> -		r = amdgpu_userq_input_va_validate(adev, queue, compute_mqd->eop_va,
> -						   2048);
> -		if (r) {
> -			kfree(compute_mqd);
> -			goto free_mqd;
> -		}
> -
> -		userq_props->eop_gpu_addr = compute_mqd->eop_va;
> -		userq_props->hqd_pipe_priority = AMDGPU_GFX_PIPE_PRIO_NORMAL;
> -		userq_props->hqd_queue_priority = AMDGPU_GFX_QUEUE_PRIORITY_MINIMUM;
> -		userq_props->hqd_active = false;
> -		userq_props->tmz_queue =
> -			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> -		kfree(compute_mqd);
> -	} else if (queue->queue_type == AMDGPU_HW_IP_GFX) {
> -		struct drm_amdgpu_userq_mqd_gfx11 *mqd_gfx_v11;
> -		struct amdgpu_gfx_shadow_info shadow_info;
> -
> -		if (adev->gfx.funcs->get_gfx_shadow_info) {
> -			adev->gfx.funcs->get_gfx_shadow_info(adev, &shadow_info, true);
> -		} else {
> -			r = -EINVAL;
> -			goto free_mqd;
> -		}
> -
> -		if (mqd_user->mqd_size != sizeof(*mqd_gfx_v11) || !mqd_user->mqd) {
> -			DRM_ERROR("Invalid GFX MQD\n");
> -			r = -EINVAL;
> -			goto free_mqd;
> -		}
> -
> -		mqd_gfx_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> -		if (IS_ERR(mqd_gfx_v11)) {
> -			DRM_ERROR("Failed to read user MQD\n");
> -			r = -ENOMEM;
> -			goto free_mqd;
> -		}
> -
> -		userq_props->shadow_addr = mqd_gfx_v11->shadow_va;
> -		userq_props->csa_addr = mqd_gfx_v11->csa_va;
> -		userq_props->tmz_queue =
> -			mqd_user->flags & AMDGPU_USERQ_CREATE_FLAGS_QUEUE_SECURE;
> -
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->shadow_va,
> -						   shadow_info.shadow_size);
> -		if (r) {
> -			kfree(mqd_gfx_v11);
> -			goto free_mqd;
> -		}
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_gfx_v11->csa_va,
> -						   shadow_info.csa_size);
> -		if (r) {
> -			kfree(mqd_gfx_v11);
> -			goto free_mqd;
> -		}
> -
> -		kfree(mqd_gfx_v11);
> -	} else if (queue->queue_type == AMDGPU_HW_IP_DMA) {
> -		struct drm_amdgpu_userq_mqd_sdma_gfx11 *mqd_sdma_v11;
> +	if (queue->queue_type == AMDGPU_HW_IP_COMPUTE)
> +		r = mes_userq_mqd_init_compute(adev, queue, mqd_user,
> +					       userq_props);
> +	else if (queue->queue_type == AMDGPU_HW_IP_GFX)
> +		r = mes_userq_mqd_init_gfx(adev, queue, mqd_user, userq_props);
> +	else if (queue->queue_type == AMDGPU_HW_IP_DMA)
> +		r = mes_userq_mqd_init_sdma(adev, queue, mqd_user, userq_props);
>  
> -		if (mqd_user->mqd_size != sizeof(*mqd_sdma_v11) || !mqd_user->mqd) {
> -			DRM_ERROR("Invalid SDMA MQD\n");
> -			r = -EINVAL;
> -			goto free_mqd;
> -		}
> -
> -		mqd_sdma_v11 = memdup_user(u64_to_user_ptr(mqd_user->mqd), mqd_user->mqd_size);
> -		if (IS_ERR(mqd_sdma_v11)) {
> -			DRM_ERROR("Failed to read sdma user MQD\n");
> -			r = -ENOMEM;
> -			goto free_mqd;
> -		}
> -		r = amdgpu_userq_input_va_validate(adev, queue, mqd_sdma_v11->csa_va,
> -						   32);
> -		if (r) {
> -			kfree(mqd_sdma_v11);
> -			goto free_mqd;
> -		}
> -
> -		userq_props->csa_addr = mqd_sdma_v11->csa_va;
> -		kfree(mqd_sdma_v11);
> -	}
> +	if (r)
> +		goto free_mqd;
>  
>  	queue->userq_prop = userq_props;
>  
> 
> ---
> base-commit: 0079dcb07e98346c0722f376ae3436cd28a71fdd
> change-id: 20260317-fixes-c80fd658c7d5
> 
> Best regards,

