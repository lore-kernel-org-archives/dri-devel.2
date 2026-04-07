Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DA3EDB7E8
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8171410E2D9;
	Tue,  7 Apr 2026 10:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="4pa1YsdM";
	dkim-atps=neutral
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013017.outbound.protection.outlook.com
 [40.107.201.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B20A510E2D9;
 Tue,  7 Apr 2026 10:09:51 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oyU5T265/T8aaE4QYAjEKCidk84hM/3eVokmBGoycclYdPnHMdNlCrxMGW9IjWkB7b1ACNCHGY+yj4JEXdJMAHXjB4NmUsEiViTTHXM/zAJSZy1moTHQs8CzKqdgNBktvkdZZXphETQQvfCelKZtiyeNAi6ZZfYBN/NwPgPROWjD925hZITNA9vCRKcyIXldIzxbXhXFjakxIXxHbie9RejTHwM5mOg8DEkb8yO3P0J6In4LOBboePw/whXXY5XAOJMjYa1sxgxa71wXXGN5S7dNjc/x0FWE9qyksJ2mz4rJbodNeli0lTBNJzUmX7wrKq/WmbVnFEJLc3doyNWFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6A3weveVZGufy5SRmpgis7+vWEsgG1KuSzEPlEzBOBA=;
 b=Gp3rTV3BIzHYGpxUd4lBbTsCCHWYIrzz3r1zgF1JkEGiX0Hyqd7B/4TxTqf0eh7rXd2Oxc+7QIyM88kSO3qxg33OlrPK5FwycBiJfY7VNJwACrde94zLmHgraORazbVlkxuFSn7eZMQLM4CxwhTfb0cRntH2b76bLE3xBCqbmQQTae+6xiggzRcRi8bZDnz5+KcwnKCoepi6l4IdfQDhc2Vb0aN1W++NdN1rbJONybagR8IBT757qdmrxKqQwFr3gWc7sxzhd7ev1FS+/e48B/LvzjaW9pxpFCtnE9BKbWF9Si8kW9EJsL0qk7ctCLYF98OBRNVuxn/WZ/o4uk52WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6A3weveVZGufy5SRmpgis7+vWEsgG1KuSzEPlEzBOBA=;
 b=4pa1YsdMYzOX8GW+PPYGi9dExDbfTVdAUdcUFncdU1+E4f8ErJ5kI909D1hk1QUKX18O6pNe0UeajRsRgiAes1fFz31/drH7ZI77iXvNjsxXzovhgD0UY1TSuBBlE8dA9KEyEvsJnFH/gi5kz4lw0yH2+ZY3SNBC3+XbkK2VUEQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DM6PR12MB4404.namprd12.prod.outlook.com (2603:10b6:5:2a7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Tue, 7 Apr
 2026 10:09:47 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 10:09:47 +0000
Message-ID: <1b46bb85-dcaf-4eee-b5ae-110d711107db@amd.com>
Date: Tue, 7 Apr 2026 12:09:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/7] drm/amdgpu: get rid of amdgpu_ttm_clear_buffer
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Sumit Semwal <sumit.semwal@linaro.org>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
 linaro-mm-sig@lists.linaro.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-5-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260403083602.1771-5-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0314.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f6::10) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DM6PR12MB4404:EE_
X-MS-Office365-Filtering-Correlation-Id: c48d0f29-e4a5-4717-4da5-08de948dcc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: pqDF8kmZFUhjFd4uN4xZ2Sg379BmGzw5HuGmi24uPW7BQclsXSW9T0bJH7Y5LGlVC5WP5eORPfjWveepxlsOAD5n88Cb54VbkMzJNvzhneDJTQuWNBAWxB0OR82cNFHI2iH6MYo6NzgiSqpOD/IocV50A79Nn2NIRfRLwyGG1aT9fNBsFWOmh4vmBHjkdWR6Sb5SMS7N2CCy6JGI5wEtFFSZqpCfpbFicMxklTMyF7Cs1FwZ36xiTQ6qE940yIiK1p87dT4EHgCx2HAa7dSaB2c/fNy+PyqSWky/rrxRscK/EK3osvr1NlCbRSkcsRH6cDWV9a8+Mtp3Q0QXAqy7X/DPqOEf5TaHPYCjlZU3P4aTCehZCc8JIG0EQ9JHwNmxsNQXUO54wBRHg+swbETDZcqevdvw3TI/UpEJYocOJmKs/z9o/da6I/amyVEr64fvSe2LGI3fN7gp6fbAk8a323JKbewZIEoyBCht4ASh0TAGykFHyeWoVycnawD/+U+jEPKX9eZK2SYgIpofVt5atoHjkOz14tm2v3jyDWtHkcyf73xQsKw643+ZKrNVO6v8kK+Xpw0xUO4/Xkano4p87fMtApnkrYkxzhdkma9iZ+QH5PM+upKihXawa84lmvgsgm2CYX0H3BkNXY0Bk13I+xUJ03clT2qEZiyfuKo3JzYZ+vttlnAS30mHDMurUy2Yew1hcGY7N5O/8agQ/Db/mJsFKiUKWUZEPoG1b0O+DOE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R0tweEQxMkxqa2FmVGlHdlpYRlUrNnR6b2VEWHVnbDlyQU1QM2dSbEQxcTJI?=
 =?utf-8?B?ZXNWZEhsdldaeHIzNnQrbnh6OStEdnloWWRweTJybTZadzB3WHpIM1FLRzd4?=
 =?utf-8?B?alo4azBKMFhEN2FjZTBYenphUWZYL1JPL3lKditFdW1EMlRQdWFwdlMvMWlI?=
 =?utf-8?B?Y0ZuT3VITmFBK0s3cVZaNkoreTlveUo5a0twWVhCbEF5L2FBWkxyVGYwTHU1?=
 =?utf-8?B?eGx6QUEzWHFwVjRVSXhSdk9USkZBeFpWc1IzTjhSM1Z5UDFoZ1lNeXNKanJj?=
 =?utf-8?B?VVg5V2NBaVZreFF5YjhweWFaejNjdVR6bWhwVDBhd2Q1Y0RPMXIyYnhGMU5y?=
 =?utf-8?B?b0czWkg1M01tZUsyanlySjVrMmdQdUtvL291SlRLNG5rQThOSHpwVkdsVUlr?=
 =?utf-8?B?THhnNnlFVWJmVGk2akZ5SWU0cnlYL2FodW9mZUdZcFhGVjFjZk9xL0VpWDVt?=
 =?utf-8?B?SEtCRjZsLy9RaEhVYTR5Sll6aEpvczdlNmVwTW4xNzIyVDk0NjZJZFBRK0xS?=
 =?utf-8?B?THdsbk40OUw5OWNJSkEvSjFTbVJaaUNDWEtYcUg2aE5YUEloZmpvU0Y1YUgv?=
 =?utf-8?B?Q05wMVBEYk9CLzdvK1dMUkNlUVdQS1FYaEpZNDh1eDBsSjAxbDFhSWRWZUY5?=
 =?utf-8?B?MUE1eEVFTDhxa1I5SmFGZDF2cVZNdVFlWkxnVWR6NEdIUlpnZW5OZEhsUTEy?=
 =?utf-8?B?MHdWUDhkSlFiWjNHSTNlbStlbDNsZ0lFTGlzSDJIS3F4OExqaHNUdkdCZEJX?=
 =?utf-8?B?YUwwa21GcnVFL3JIbDlFU0NTTktkeFZaaFBqcGYwVkQ4WmEzTXZWVE4rTnF0?=
 =?utf-8?B?dWpURjU2cTlKaVc0M1ZFU09TTDZYS3VzWCtySEpBaGxSeGZhandieUtyVTFJ?=
 =?utf-8?B?MUgzcHljbWJVUVFMaVBQTmZCYm1RcHZaYm02VGtIakU1cUxoLzBkWmlPQjRE?=
 =?utf-8?B?MGZIM3ZQZzYwZkpwcmlsd3BBeVg0ZnhFNm5vaGZUcXpOQVZtUFBudUFJenNQ?=
 =?utf-8?B?RitqL2xhSEZNZVltNHg3N2JhL2dmekw0aEFOWU91TldEeHFDNWkzcnY0c2c4?=
 =?utf-8?B?WDZlUEFoZ1gydjhrNGp4ditaaXRlSWJJNW51UzVpUC9wZWFCdld3SDIwbU0x?=
 =?utf-8?B?OWxyNG93S1EwUTFscHpYbEZhbzQ1NmR3bk42dXlPUlpTSWQzdng1c253eWZ2?=
 =?utf-8?B?THI2Q2p0Rnd2by9SdDFxaFBnSDF5eWNOR3ZtcUVSQlZsTHJCVjhXWm95UHpk?=
 =?utf-8?B?K1RpZmk1WkpQdVgvSlFzUlFSNUt2ZzhMVHFxRUNhalM5VUp6b1NkOVcrdisr?=
 =?utf-8?B?cXVYc29PTGUrU29LbEpWWWtQdk4rYU9HT1BmQXVsS2tFb3QxNExpaEY0VUd2?=
 =?utf-8?B?cmE2eXBuZDczV2k3Q08xdzFGQ2JXeWZ4V1Z5L0xTL2RNZHFWeWpmOTc2ekIz?=
 =?utf-8?B?eFM3aU5NOGN3TkI3eHVxNnhpM0NZUjU5ME90U1FxRnNQeVlRQmhKR0FuRytn?=
 =?utf-8?B?ODJzNi84UXhyd25lQlFaRkhmTzkxTkoxNnVEVjZsT3czKzZraXM0b1A2UVpo?=
 =?utf-8?B?bFU2MWF1R1J2QkRXOVl3ejRsSlFDaTFQQUxmWmtIeEJxNlRha09ZQWRKV1JE?=
 =?utf-8?B?RXhKS2dValBoNHM4UzNzUFdEM3cxWUU3NWZxQUxvYkVRbXYxZUthSWRwcFpW?=
 =?utf-8?B?NTloVkxBMWpWcFZxWHVQR2ZVTWR5a2lrOGJMeEUzTzhRcWZOZTA4T2V1M0Jz?=
 =?utf-8?B?dWI4YTZIaGZyUUdORENJeUY4dFllcnp6dDVtbEtoV3RQcUtpQVZPMS9Fb21P?=
 =?utf-8?B?T3dmeXNmbHdvTk13eVU4Q3ZOVHRMRkJVNnV5cVJndS9aaGxvZFMvU3RLc3Z6?=
 =?utf-8?B?QWY5aW1Kb0JhUjZMUkVOSkMyQjNkbUtIZytNS2JFTFdnc3UwVlcvUWF0YlhU?=
 =?utf-8?B?SDd1dThYTlp6Y044Q3ZzWFhUOUVzN1VxVVI3cXllT3haQWtQUG5jWjdKdWY1?=
 =?utf-8?B?N2xkNG1WRzFOTFZySTk4ZXRSOUJYNCtSb2dvalhUbnNhQjlJTTBmZlRvRi9L?=
 =?utf-8?B?UktUSzM2NFpxTURtZlA4b3lTdldhT0FSUmY3dEc0TDJSeXQ3cFVSb0RkNGpt?=
 =?utf-8?B?aFpSVkViaFFxV3JNZWVrYktFWlVyK0o1OEhvVzdraFZGUFZDNlY1bmhUTEpP?=
 =?utf-8?B?ek0zV3NyZVdJMVR6SXdvTmxJV0d0QTNZa1BjcWI3OStSZ1JHME90NlBMYzRv?=
 =?utf-8?B?UWs2cXVlMC9lUHgwVnR4eWxnL0FaV3VzMGZ4all4QWZBc2ZWREFIaWlFMXVr?=
 =?utf-8?Q?UQM+IHT9bwBDHjnFlO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c48d0f29-e4a5-4717-4da5-08de948dcc4c
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:09:47.4152 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p6xz+s22A82Q80hFFkWSFqP1rn9ZtnccdrCaYUvzI/JqDYup0b2X5meNmDjmbu7O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4404
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
> It's doing the same thing as amdgpu_fill_buffer(src_data=0), so drop it.
> 
> The only caveat is that amdgpu_res_cleared() return value is only valid
> right after allocation.
> 
> ---
> v2: introduce new "bool consider_clear_status" arg
> ---
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c | 16 ++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 88 +++++-----------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |  6 +-
>  3 files changed, 32 insertions(+), 78 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> index 66c20dd46d12..d0884bbffa75 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> @@ -717,13 +717,17 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
>  	    bo->tbo.resource->mem_type == TTM_PL_VRAM) {
>  		struct dma_fence *fence;
>  
> -		r = amdgpu_ttm_clear_buffer(bo, bo->tbo.base.resv, &fence);
> +		r = amdgpu_fill_buffer(amdgpu_ttm_next_clear_entity(adev),
> +				       bo, 0, NULL, &fence,
> +				       true, AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
>  		if (unlikely(r))
>  			goto fail_unreserve;
>  
> -		dma_resv_add_fence(bo->tbo.base.resv, fence,
> -				   DMA_RESV_USAGE_KERNEL);
> -		dma_fence_put(fence);
> +		if (fence) {
> +			dma_resv_add_fence(bo->tbo.base.resv, fence,
> +					   DMA_RESV_USAGE_KERNEL);
> +			dma_fence_put(fence);
> +		}
>  	}
>  	if (!bp->resv)
>  		amdgpu_bo_unreserve(bo);
> @@ -1326,8 +1330,8 @@ void amdgpu_bo_release_notify(struct ttm_buffer_object *bo)
>  		goto out;
>  
>  	r = amdgpu_fill_buffer(amdgpu_ttm_next_clear_entity(adev),
> -			       abo, 0, &bo->base._resv,
> -			       &fence, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
> +			       abo, 0, &bo->base._resv, &fence,
> +			       false, AMDGPU_KERNEL_JOB_ID_CLEAR_ON_RELEASE);
>  	if (WARN_ON(r))
>  		goto out;
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index 648ad344e89c..a3d0998b8cec 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -418,7 +418,7 @@ static int amdgpu_move_blit(struct ttm_buffer_object *bo,
>  	    (abo->flags & AMDGPU_GEM_CREATE_VRAM_WIPE_ON_RELEASE)) {
>  		struct dma_fence *wipe_fence = NULL;
>  		r = amdgpu_fill_buffer(entity, abo, 0, NULL, &wipe_fence,
> -				       AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
> +				       false, AMDGPU_KERNEL_JOB_ID_MOVE_BLIT);
>  		if (r) {
>  			goto error;
>  		} else if (wipe_fence) {
> @@ -2572,76 +2572,25 @@ static int amdgpu_ttm_fill_mem(struct amdgpu_device *adev,
>  }
>  
>  /**
> - * amdgpu_ttm_clear_buffer - clear memory buffers
> - * @bo: amdgpu buffer object
> - * @resv: reservation object
> - * @fence: dma_fence associated with the operation
> + * amdgpu_fill_buffer - fill a buffer with a given value
> + * @entity: entity to use
> + * @bo: the bo to fill
> + * @src_data: the value to set
> + * @resv: fences contained in this reservation will be used as dependencies.
> + * @out_fence: the fence from the last clear will be stored here. It might be
> + *             NULL if no job was run.
> + * @dependency: optional input dependency fence.
> + * @consider_clear_status: true if region reported as cleared by amdgpu_res_cleared()
> + *                         are skipped.
> + * @k_job_id: trace id
>   *
> - * Clear the memory buffer resource.
> - *
> - * Returns:
> - * 0 for success or a negative error code on failure.
>   */
> -int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
> -			    struct dma_resv *resv,
> -			    struct dma_fence **fence)
> -{
> -	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> -	struct amdgpu_ttm_buffer_entity *entity;
> -	struct amdgpu_res_cursor cursor;
> -	u64 addr;
> -	int r = 0;
> -
> -	if (!adev->mman.buffer_funcs_enabled)
> -		return -EINVAL;
> -
> -	if (!fence)
> -		return -EINVAL;
> -	entity = &adev->mman.clear_entities[0];
> -	*fence = dma_fence_get_stub();
> -
> -	amdgpu_res_first(bo->tbo.resource, 0, amdgpu_bo_size(bo), &cursor);
> -
> -	mutex_lock(&entity->lock);
> -	while (cursor.remaining) {
> -		struct dma_fence *next = NULL;
> -		u64 size;
> -
> -		if (amdgpu_res_cleared(&cursor)) {
> -			amdgpu_res_next(&cursor, cursor.size);
> -			continue;
> -		}
> -
> -		/* Never clear more than 256MiB at once to avoid timeouts */
> -		size = min(cursor.size, 256ULL << 20);
> -
> -		r = amdgpu_ttm_map_buffer(entity, &bo->tbo, bo->tbo.resource, &cursor,
> -					  0, false, &size, &addr);
> -		if (r)
> -			goto err;
> -
> -		r = amdgpu_ttm_fill_mem(adev, entity, 0, addr, size, resv,
> -					&next, true,
> -					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
> -		if (r)
> -			goto err;
> -
> -		dma_fence_put(*fence);
> -		*fence = next;
> -
> -		amdgpu_res_next(&cursor, size);
> -	}
> -err:
> -	mutex_unlock(&entity->lock);
> -
> -	return r;
> -}
> -
>  int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,

We should probably rename the function to amdgpu_ttm_clear_buffer() while doing this.

Apart from that looks good to me.

Regards,
Christian.

>  		       struct amdgpu_bo *bo,
>  		       uint32_t src_data,
>  		       struct dma_resv *resv,
> -		       struct dma_fence **f,
> +		       struct dma_fence **out_fence,
> +		       bool consider_clear_status,
>  		       u64 k_job_id)
>  {
>  	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
> @@ -2659,6 +2608,11 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  		struct dma_fence *next;
>  		uint64_t cur_size, to;
>  
> +		if (consider_clear_status && amdgpu_res_cleared(&dst)) {
> +			amdgpu_res_next(&dst, dst.size);
> +			continue;
> +		}
> +
>  		/* Never fill more than 256MiB at once to avoid timeouts */
>  		cur_size = min(dst.size, 256ULL << 20);
>  
> @@ -2680,9 +2634,7 @@ int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  	}
>  error:
>  	mutex_unlock(&entity->lock);
> -	if (f)
> -		*f = dma_fence_get(fence);
> -	dma_fence_put(fence);
> +	*out_fence = fence;
>  	return r;
>  }
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index a6249252948b..436a3e09a178 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -187,14 +187,12 @@ int amdgpu_copy_buffer(struct amdgpu_device *adev,
>  		       struct dma_resv *resv,
>  		       struct dma_fence **fence,
>  		       bool vm_needs_flush, uint32_t copy_flags);
> -int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
> -			    struct dma_resv *resv,
> -			    struct dma_fence **fence);
>  int amdgpu_fill_buffer(struct amdgpu_ttm_buffer_entity *entity,
>  		       struct amdgpu_bo *bo,
>  		       uint32_t src_data,
>  		       struct dma_resv *resv,
> -		       struct dma_fence **f,
> +		       struct dma_fence **out_fence,
> +		       bool consider_clear_status,
>  		       u64 k_job_id);
>  struct amdgpu_ttm_buffer_entity *amdgpu_ttm_next_clear_entity(struct amdgpu_device *adev);
>  

