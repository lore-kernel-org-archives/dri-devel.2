Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFDA6E9A74F
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 09:39:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9137A10E115;
	Tue, 24 Mar 2026 09:39:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iG7W7jj3";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010046.outbound.protection.outlook.com
 [52.101.193.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2527410E110;
 Tue, 24 Mar 2026 09:39:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BVF5aPSLKDroioswS3yv4tUWXi7uYS9NTohM9Qo/gU0quL8gwCpfj/1OkRvT2HeVguSGNYDf1fd7KmfKb73mugSzCBuHe/IQfQCaGgiQj5o0cdYcT/C27Mp/SDLeP6hK6jIDmn/SBFwnvWZ64ShekA8iUeufcfgIDmBnCS6CyaZpWB8CvZt9yBVracIKPmVg7LtQoiwlyXtiGjNMuKffpaaA3/9j9jcJcEGVKkXpZu0rxl2zX2itT9jHcVLPOIablx381wUAeRrSjGpztbgWbPcwWxa58JFxxUSVxdkYX2tVyIOt3fOKez9jtIre9lKLafpr2alNIazlQThuIjUmVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oGAwENEs/CqY5BrU4arrUQu/UXHa61WDdz+Hbm/9nyI=;
 b=Ejl2J8gfkzq+v7hjJdaws3dSWt0AGsVNVl5TwBFymLC73zYk0CSSr81cDJsMxOQUc1/Tzsz8tAyrVssXYlY1ITb5FppFgSOfcLPEbYXfuO9XxJOQ6tKhHUt7EpSlMxOtgqVJE0v4IUbtHbtFhBebiAExd1Kjsg/OyDfRodx3I++KAmWa/ids7xZwhLck5/onEu9DRHMrrA+Tj6Lr3EvGVu0B+5zSfuRicaTzZ6M8GY2NfdSH7JIX9tKFmiKe8fHEPIqCji6MvfYSq4RWygcbiuHrVZbbTgdyb52mrt23TZGFoga9iCr4nXxE4Wr3MzOSkuxXiJH3QE/d5X20qY3D6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oGAwENEs/CqY5BrU4arrUQu/UXHa61WDdz+Hbm/9nyI=;
 b=iG7W7jj3BK7DAaJABiSjkfVOuoq2H6mBhAyR8jdTelyYK8w+wurkDd4wgXgxZhXAU/KAmhVAmgwGf/71t5eeGMTjPJ5TkIGTEedc4c9EyfP61nZF+DJnJw8yAcYjhqspqHl70kvKX+FdC1mhOW/OZVRpX73vkKpPPXEaIno/IHY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CY8PR12MB7492.namprd12.prod.outlook.com (2603:10b6:930:93::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 09:39:31 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9745.019; Tue, 24 Mar 2026
 09:39:31 +0000
Message-ID: <1060acb4-1a8c-4e52-add2-fbda4f2efb7d@amd.com>
Date: Tue, 24 Mar 2026 10:39:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][nexr] drm/amdgpu/mes12_1: emove extra ; from declaration
 statement
To: Colin Ian King <colin.i.king@gmail.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260323224348.343495-1-colin.i.king@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260323224348.343495-1-colin.i.king@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR03CA0019.namprd03.prod.outlook.com
 (2603:10b6:208:23a::24) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CY8PR12MB7492:EE_
X-MS-Office365-Filtering-Correlation-Id: 7204ab96-56ee-4fda-d469-08de8989402a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|22082099003|7053199007|18002099003;
X-Microsoft-Antispam-Message-Info: jYi9Lo6E0+dgaV9Jr/Rcvj26Y03TtzaK2m6WsGWNamTzR6J+AzW8cIzaHYXrGb9LlF+eNx+deIDHMbL+DnqbX/RpmgIdyV7TnPliO0c9MLgKxgzAp+H2oup5Bdz/pXiSEFea06wscX6Ghzh4pxoV6VLCG9unuXFSyRyhZ4w1VTwaOqOqrtiyXR/QmkxPtcLyt50kT+4mkPln6qOjtjI+3crcvzzRwQL6y533y6x53oTCaAteM4h/AJaRZx5TJTm97fvb8v7T2NebHLaEl/baZBYa7kQw3+8Hrm1vTg/M0Z++St+o7x3td0Cj8JvUFKp+r0+CQEbNhVW5wP9khL6rA6Xskq0PmkIGjuPoodzFqmpHpa/Vf6+G+XItHyy7UhqE19sDlVNJh+Sq7sVGbrR2JHWzM6vYAmJmT1S6l3I5MwVU4lI1lyfN5rRCEXgOwbz2iBv5b4EIuwdF2MtkSqp80CMuUTz9asFWLCcIW4TQKiuexS4FnH6Z4iud0XWINXTWA5E2XDB3RJAClZPmI9HDxSh8H8HxTGl8RgHeeYcl+krf1lJF6+9XjdNdmIxnw7cuTflg8D3pHWRntFO2Z0h/PpYZSZqhcyIcUSMIqYcT9VDQ7s0tm0/n1ZGNfDv29WsSgz6Gr6xrPIzwGd1DIhl/3osAVbvtrmQkIdrjtuJ+MzHBpGJzv1hxZru/jVoYqu4PA6cGYwEfN/BmTzqoazgBRLrYPkoPakIpvtIdkZ/gbJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(22082099003)(7053199007)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aGh0ZE8zNXY3Ly90ZlNtRXZyQ1RFSWljd2JnMEZ0RHpVZDJSTXNnTDJyNnVu?=
 =?utf-8?B?L3hNdmR2TUtudEpERzIyZFRTTzY4U3dDY3hTYzR4NWpSS2lGRkl0TUxFeUE2?=
 =?utf-8?B?NFBCeThUOXJCZ0FWRWwvS2pmQkNIcktiaXBTVU5zZ2l5SGVoQjJROHNSaEZu?=
 =?utf-8?B?WklOUkYvNW1Wa0VFd25mUGpuUGhMQmN1YVdkUTl0ZXoreEFoSFVzZUdub3pn?=
 =?utf-8?B?SXV3WWlTUGdrNkc1UFJMVkR4QlV5aExMdk1IUzV0eDlpOU5XaWJIaGJiYzV6?=
 =?utf-8?B?dkYxSTNXN2VKV3d0ZlV5NDN2cCtuczVubGpmMFBQUnRmS3VvRnBKMDlyVk8z?=
 =?utf-8?B?NjdyNGIxUEw0ZFlwemNPWDVnZ3NUZlJIOGp3dFEzczkrMVFvN3o5V1BFbktZ?=
 =?utf-8?B?WTdIN0pqTVp1Y09XV3I4dWNwWnZYSHFMQVFkbmdaajhXMlowQjVhOUJ3eXQx?=
 =?utf-8?B?Rkx1MktVZkJzN1FPRWRkWU9DK29LdVQ1KzN2OGVxc1lYMWxVMkxpNG55U21y?=
 =?utf-8?B?S0MzNEJQekMyaTJTR3M3V2t4MXRrWmMxNGFjSmhWZDlIWjdXTDd5cStCZUgv?=
 =?utf-8?B?dlZlRkVZRlhiV295QVQ1T3h0cHVPSVlpYTNKd0N2YU9HR3hJdkF0RDRuK3BN?=
 =?utf-8?B?SUJYREFoaVBmT2ZWeEcrUUZGelR6aTdwQnJXbUlKTkN4c01UcVhiTUhDRytL?=
 =?utf-8?B?N2p1RnJNQ2xIY2tLeEFQOXlCTXlhZjZLaE8rZlcveDBBbTQrUHdweFFuTVNU?=
 =?utf-8?B?QUFwR1g3QVVvRUhsSzRvNkFlcnV3cEZuWUJ4MFZ3Z3d4UzFYNEpzRkhSM0pK?=
 =?utf-8?B?Z1JybUY5aGo0d2xNUWl0dmVCcFc1MkpzVVE0YVFEMGg3eDFBOWVJRzAzV3NB?=
 =?utf-8?B?U2k1R3JtTGozRlN5V2VGWGdJVXBJRE8xaXJtNzYvTWdmY3JqNVY1TFpESTZC?=
 =?utf-8?B?K1VpNEU1emhKK3AzTFQrTkJHdFY5QStwUW5SYXQxT3EyQUs3QUZLcjJxa3BU?=
 =?utf-8?B?b0QxdGhXbTY3Y0tQY1hhSTFWTTRKQ2tPdm1iclJ1VW0rTStDZHRFWFI2dWZ5?=
 =?utf-8?B?eksxb3NCckJ0NEFtS1I3RXhkUGF6eG80bVlONVBYL0ZaOEw3Y0NGNWlPVUlF?=
 =?utf-8?B?VHVXREtlL090Q3pYalZYZWZlSHpXcFp6L3V2VFBmYVkvaUxDd0lOb1FVWk5l?=
 =?utf-8?B?Qy9JTmxzT0c5SUU2OFh3SjVURDlrelkrWTFhaGs1Vk4rZGVMWlJHS1NYaW4z?=
 =?utf-8?B?VkZhVHV3a0ZLY0ErU2gwcGdLeDNtWGhPNnQ0eWJkbWlqSElTS2dGZjZBdjh3?=
 =?utf-8?B?WjRVVXlheUxOeXA2bU5ZUmJZMHo0ZmhKei9wRkFLQ21NeGlsL25DMXkzVElJ?=
 =?utf-8?B?WDQ3VGoxRGNXUDQ2empZZGcvVEZSNUU4NFJiNVJvVk1iNC9PUk40eVpUZVEy?=
 =?utf-8?B?VVhUMXg1ankvRE5LUkZFTVNXcXlZMVhWWDF0eTU1T0cxK0NHZDZybFBDVkNE?=
 =?utf-8?B?QTdQcmRiUEVLS2tLbEtBUFladjJwOHU3SXNZZEpEdVNCSW4zVmR5UnVzS2hz?=
 =?utf-8?B?NzdRWnpzbXZxa3JoUmg3NGZkQW1DN0pad1lZclVHNWhSS0tlMERVZlorcUFx?=
 =?utf-8?B?aFNvVytJak42MUJ2cmxkeWNuVGFVSWhJK3o4L0MrMmFKMUxhT2tFTzB2ZmFp?=
 =?utf-8?B?ZENFeURLbU5nK3FEajFXRFVkeTZha0lJUE15aEZOd3FydExTYm54aGJSWE50?=
 =?utf-8?B?TjV3MmkvYnFKTkgvOFVNOUc2Z05VNW9rZU93UlZ5SHIzWkZ6QXlqUlVIQUYr?=
 =?utf-8?B?U3FER2o4b1JmcENxL0ZhSE5PcGFuck1HNHg5VWVzeWJGcWEzRGFONTJaZmFP?=
 =?utf-8?B?U1RaQUtYa05uZSs1elk1aWFEZjJpYmNiYXNvWUVkOStrOUE2djQ5YVRhOUtF?=
 =?utf-8?B?MFlqNXB4SUF1ajFjREU2OEc2QmNNdm9hRTN4ekFCS2hRUjFQN241YlozaStS?=
 =?utf-8?B?NTV0dCtXZHY4S2R6TjhNVU1LUjQ1b29NZTJFRFhyaGoranhxZVRwMkNKNFF3?=
 =?utf-8?B?YWhROFh2K3F4NzI5OWF2MzVDY0l0WkxEZkwxYU1DWmRQY2RrODAzN2hMV2Za?=
 =?utf-8?B?T2RQdTdPRnZIRWNwb2U3ZExYcjY3S3QzZ1U3ZTNLMHNyZkdFdC9mOE12RHpB?=
 =?utf-8?B?cWhuNnd5c3FPd3J4UDFWdEVzRGVDSFluaTZpM3ZiSmc2eEUyWDBwNlVxcE9l?=
 =?utf-8?B?UW4xTUVLZS9idC9pT2VuVlhHTjFGK3BkdTUxSkhVUkQwWTVHajMwdUVsUnIw?=
 =?utf-8?Q?yEw1mXL9PvUh1NJNB/?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7204ab96-56ee-4fda-d469-08de8989402a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 09:39:31.7105 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZPelhb30TPZAZLKKwZR2YeZc0mBvvfpC84vq1lyZ0Pfol6UEDouee05DpOe+Q+9h
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7492
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

On 3/23/26 23:43, Colin Ian King wrote:
> There is a declaration statement that has a ;; at the end, remove the
> extraneous ;
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/mes_v12_1.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> index 5dcc2c32644a..0e9089544769 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mes_v12_1.c
> @@ -2227,7 +2227,7 @@ static int mes_v12_1_self_test(struct amdgpu_device *adev, int xcc_id)
>  	struct amdgpu_bo *meta_bo = NULL, *ctx_bo = NULL;
>  	void *meta_ptr = NULL, *ctx_ptr = NULL;
>  	u64 meta_gpu_addr, ctx_gpu_addr;
> -	int size, i, r, pasid;;
> +	int size, i, r, pasid;
>  
>  	pasid = amdgpu_pasid_alloc(16);
>  	if (pasid < 0)

