Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F58ED7B91
	for <dri-devel@archiver.kernel.org>; Tue, 14 Apr 2026 09:27:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6309A10E5AC;
	Tue, 14 Apr 2026 09:27:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="YbHpVNbo";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012049.outbound.protection.outlook.com [52.101.43.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A4010E4F7;
 Tue, 14 Apr 2026 09:26:58 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6O1lSF03mmYoS2b0XkHCnGlUSWo2VixItQSNU9t7hrOVYrZ4S7eG/7O/Q4ANcoiEXGIfaQCPkBtBNR8OGkLrDk2/35cI47DyfS2XZZBYjLkO8HGHdlVYFK+Q4bIPUVe0IvE7JE7YOzRueuaVS2ZyDlydm/6fAQNBnBhxr/PxTL+lG7Imf7A89bzuJf4MqAdoQW+MiwsiaIPaAYyjaoC+SxdQXWR5qGlZk+Hh7ef14T1EUe/3hPqNIaxG7CPhLrYDc6CgKoJH3o7VY9/tWJr+nweeagTmSqTE27+8HVt9xVJ9YWJMq1B3ZVYXl3TiQsS2a7hP3c7yLAcTowZqczkkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g6nbRIkQZkKbdUmnkpz/jmBDhH3KBKl65n2U4hn9/gc=;
 b=rVD7tuAmzRdGZIF7NupfkuAcizWFE0YW2KMjMsstXL2ET4H6s2QZvKxgj5O50tQAJ72DRXBFLKbM5DYFhWrWhcYw3z4mWEZHRkWtnutVkqpvzxG/s9GEZydD7sMYgJYBsJSd3QPAQKkIbMDZsA/Ev4wSR1Lwsz8dJgXDC3FeXxRwjAKGlLQvc8YyGFAc9iB2mLn/9DfPsvh78oNaEag1Dk9b3ssUWmBOJe82owk6UEgQEYQetlXykfdQb68JaI1ioy2aNJR9X7VthQIgzLi6oL6fw8xz19yEN+09EQnYpKGAEzaxktz7fL1W/45R+zmnqyMRohg6lV4ls6KwaFUeLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g6nbRIkQZkKbdUmnkpz/jmBDhH3KBKl65n2U4hn9/gc=;
 b=YbHpVNboyf3MgBUKPgykUu4eyKawTCJjQKoFcXcYzMGLHX2M9yaTkuyZ3wOzolaJNNT+BaF2r6jfYF6p8MgArMQuaSy9nL9a6R4MTicWU0exgimk+wfeBV/ebJ7mk3dRUP6kH0g3sJvsMAOpAATD+EEyMLv0oA4mMboOsntESZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB7459.namprd12.prod.outlook.com (2603:10b6:a03:48d::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Tue, 14 Apr
 2026 09:26:53 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9818.017; Tue, 14 Apr 2026
 09:26:53 +0000
Message-ID: <8892f093-a98b-481e-b01e-4e640d2edc54@amd.com>
Date: Tue, 14 Apr 2026 11:26:47 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/amdgpu: fix integer overflow in
 amdgpu_gem_align_pitch()
To: Werner Kasselman <werner@verivus.ai>,
 Alex Deucher <alexander.deucher@amd.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20260406225008.2787532-2-werner@verivus.com>
 <20260414050840.244705-1-werner@verivus.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260414050840.244705-1-werner@verivus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN0PR03CA0034.namprd03.prod.outlook.com
 (2603:10b6:408:e7::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB7459:EE_
X-MS-Office365-Filtering-Correlation-Id: a124f0c2-eb83-49b8-b615-08de9a07f72e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: TBqI2UAxNIlAJeIaAOAHLdUPcLQ4YLVsL/ul1gwyh6Ac1/57+3e3LaQpBuwe0znzsVBTMKloyp85OXO3NhpuQuxKYPQ/MqeRGpl+cNybl3G2WIIU4PgXhXCpODA+fn8t0SbRzLScEyDqorzkD4/vyzA7baz8ds2uur4bXsVu8W2/N2FOq/9+n3T0HBn272SdOaXAg7pYtwPZP1LynVW9Upxmp8Uvo9y35eVHrmqFQ8Wz9i2zWJmOOXlmu4J5Yu+WsyIgNPkZzizx+yOFaue5p/2IL81Dk97jpl1uTJ32UE8xhMas4hNGktab9RrymvAHCLttoyG8RX7cr5PXxSYsna0/4op/kf06ZrAsTTtIVx9UG42WtBjpQlYCQ3Se7C3v5zy6lk6UQEXvKqfQWhF9MuWiNZMpW2BSn9skKKOgU44FZDniafXyD+eeyc0eKt0JLePB7HZuJiSZ4lce/25v9OJy6Ymgty72Bf0ccyUPJSGW7htdnGChQp5lq9zqGfcBQc3bKLT9vLJfaHST+PNPDkxYaghTaPuxxgJTx9WtPGRTjKyh/Nd27mLrs800g0M7p3NBFgOtbAsIMyAbTIwOrm2FYoNBUs/iObqTCgwtIoDxaBvGjru4a4P7BrDQAD043FTW0e8avcTsSxaR8dO0sf3x3+/wCrEUOJeK1m3AZJ0lbQJ5EEBriJwyiRhI8RjjojoLans7pPQKD1La+LnFozPqm4IlLrWvr2S47LSbB/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RGEwZkpPcUx4UElZeVdxVjNHUEk4c0ErbjMyanBSbUZBMmQwNk9aeXpWK2Zs?=
 =?utf-8?B?dnJCQi9EL0ZhTmU3NXBpdTdhUkErRi9uYTJXWUNUZ2c4aVE5WURhbFdCUDRq?=
 =?utf-8?B?Y1pBYzg5b1BHYmludGZlUnp3Z2tiSUxrODNuZVN5YmhxVkxpd2FnVytwazAx?=
 =?utf-8?B?S2IrL3FvakljZms3MURSWDVxYVhabnZkdHFaTWZsaG5hSTJoK1lWMTR6REdY?=
 =?utf-8?B?RWZhVHhJR01rSlgvTWVKUkJRNmJRN0U3LzhpckZiOFJaVExrSEwzVHRzUnJH?=
 =?utf-8?B?UkY3eU5mMlRIMlB4YWd1R081MVd6MHhQZnhJYzBQOEtGS25oMFlVMExlRmdF?=
 =?utf-8?B?VksxUjhiWG9jMC9UYk00ekhUelhCU3EvN3BIWHlMV0g0TXdoVElEdHFBNzJF?=
 =?utf-8?B?QUhlc0xyV0hPZkJ0RFFUZ1QvUEdIMy9YbmQyN1FMMUY0L1hmS2I4TmpXTDNR?=
 =?utf-8?B?R1BPOVk4eEVRNnE2cmgyM0ZocmtHQm9ZcUlIR0NRWG9zLzFpOStpM0RSMStQ?=
 =?utf-8?B?RmRFR0FYTEtQZXFFVVpnMmhaMzBMZnk5c1E2bDNPczJXTnhiNjVUVGx1NE5R?=
 =?utf-8?B?ZlVOYXMwa0IwWFdKVjBKbmRFY1BTNytMcGZXYTY0emdxSWcxdVNoblRtM1NB?=
 =?utf-8?B?eWNPRDJXdTVxdEhSYW9FbFVzUzQ2WS9qdUlwQWdkeDl3U2JibkNzSGdidTl5?=
 =?utf-8?B?ZFdWa0VrK0UyLzBZS2J3M3ZOV05pQkN4U1NSb0ZuN3BSQnM2ZEkwcEJkalhZ?=
 =?utf-8?B?TzhnVE8zb29McDgyTVRWWkFnWjgxaTd4M2xWY1J2QUUyM1krUmkvcGJyQk9L?=
 =?utf-8?B?RmVIaTlhQmpvMllSQm9DM0NxdHBqbEFYZDE5bU9mM2tCSHNYc1RpWWI2dk9P?=
 =?utf-8?B?NlJZL21uTUZuWFNHMVI2emIxbzBkV0RwK1B2NVhPOWljb3NJbDM0VHB0c05Q?=
 =?utf-8?B?TFc3UUM1K2NGUWtuSXNtVyswaEpOSnZQWU9zNXR3Z1hSYk5uaUY1dTBYc0VX?=
 =?utf-8?B?Tyswb3VNSFRYeFhqU05QSE1VZnpDOU1qd1ZCUlJyaVdiaER2MHZSOEJNRzc0?=
 =?utf-8?B?RUlncS9abTJYZmgyRjd3NGpVOXhKV0M0RXc2MHlhYWZBb0hQOFdOMG81d0VY?=
 =?utf-8?B?MGpEVnVhZ2pCZ1lJT2JaRURYNHIzN0x0bGtpUloxZHZZbE4xUHI3RmF5bUU5?=
 =?utf-8?B?amk4b3dVOTcva29UUXh4RSsxT0tMeVkzS21tSlREWGhWSzIyUHNtbzF2Y1ZM?=
 =?utf-8?B?MFVXd3V6SjNiQlQ1Y0NONlFLVXhQSVJaQUNEZ0taeUVmUFFSMEhCUjBoYnZi?=
 =?utf-8?B?S0orNDkyM1BIT3h3d2xxV1BzdjVqcTFUSHE1SE9lWnN3WVVUVFg3Q0xzZm9t?=
 =?utf-8?B?bFJKZTNDZ3dvdjVITHpGNTg3U0pnaUp1ZUtCYWRRRUpaQXU0ZnJxR0FtOE9I?=
 =?utf-8?B?UXRQUzB5bVZpRGRwVGd0REJvVlArZUNTOFFPd2V4NjBUSnEzcW5iNDhZV0J6?=
 =?utf-8?B?Y1JqdmxLSnpxQUw3SndlVlFSTERsS0ZOQlFtRUkxUld4UzFHWFpsdEQ2cWJI?=
 =?utf-8?B?UkM2TUU4Q0wrVHV5NmNMV3NqWlg4bDJZVHdGanNES0lJN0VOejErRFE4ZlFC?=
 =?utf-8?B?VUtET0d3ZUpjTW84M253K1BaQ3BwZUVzY2dVUmhoTzc1L2hwMVVibEp5cjdC?=
 =?utf-8?B?ckp5YXQ2enh6dDk0eHRORHc2bGhjL01EVlRJWHZhbnhURVAxdE1mbFNTbzZx?=
 =?utf-8?B?K1hxN3ZGRVNrcEVoZXkzN1hJTm84clBYSXAzL3p4SjlJSjhmUVB2aCtwYk8y?=
 =?utf-8?B?K2tSRHhRT2pybnFWTm5ROEV5NS9VNUNyNC9jYVNGWDcwTWZGU0hERUZoYmlo?=
 =?utf-8?B?RnAzRFRYSExDM0VjWkl4MXZRMFh0L2xmSHhudUFDR05KM0p0SnF5T1RCdFpy?=
 =?utf-8?B?VFkwcGMzTDRaaHlwUmM1QjlCWXk4MWQ1Q3BsWmVieG9xNFUrQUZ4L1FzN1B3?=
 =?utf-8?B?YVJxVkc3ZC93S2tzRWhUb0dQbW9ZREoxQXprQU9rSldKa0FyY0ZFalpwcm9t?=
 =?utf-8?B?anV5K1JUWWR3YngrakNPa2pWbnpIY0kxL1lvVzVGWU9SZjE1d2dvZkVBVXM5?=
 =?utf-8?B?UFlUUk4zZEZ4OUpaOU1FMkRDT3hFc1NiaDJpbSt6YktOc0dnNGwzTWNiZXc1?=
 =?utf-8?B?N2lBbUZubGRjendST3luL1lnanBXam4vOHZ2V043TnRrK3hCclJVbWlWMnBu?=
 =?utf-8?B?aERvRzVQbDhhTklQaU0yRkRoQTZaTlNmbml0SlZwclVhMVhYbUJjamZMdmNT?=
 =?utf-8?Q?+oQvQkOPP7zCRBHr20?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a124f0c2-eb83-49b8-b615-08de9a07f72e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2026 09:26:53.6847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iGDu5b8JiD/HwBiwx1i9CRA0vzg9a8FkHOdfSDfR4Ff5aJAOZvCsKQdF3Um2Bb/5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7459
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

On 4/14/26 07:08, Werner Kasselman wrote:
> amdgpu_gem_align_pitch() is passed u32 width and cpp from dumb buffer
> creation but uses signed int internally.  The round-up add and the
> aligned * cpp multiplication can overflow, returning zero or a negative
> pitch.  A zero pitch propagates to a zero-sized GEM object allocation
> that reaches userspace via DRM_IOCTL_MODE_CREATE_DUMB.
> 
> Switch the helper to unsigned int and use check_add_overflow() /
> check_mul_overflow() so wraparound returns zero.  Reject a zero pitch
> or size in amdgpu_mode_dumb_create() rather than allocating a zero-
> byte BO.
> 
> Fixes: 8e911ab770f7 ("drm: amdgpu: Replace drm_fb_get_bpp_depth() with drm_format_plane_cpp()")
> Cc: stable@vger.kernel.org

The patch looks valid to me, but I think we can drop this CC: stable.

Since dump buffers are a kernel only interface the fix has no practical relevance and is only of cosmetic nature.

Regards,
Christian.

> Signed-off-by: Werner Kasselman <werner@verivus.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 25 +++++++++++++++++--------
>  1 file changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index a6107109a2b8..0d9309f792a4 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -27,6 +27,7 @@
>   */
>  #include <linux/ktime.h>
>  #include <linux/module.h>
> +#include <linux/overflow.h>
>  #include <linux/pagemap.h>
>  #include <linux/pci.h>
>  #include <linux/dma-buf.h>
> @@ -1223,13 +1224,14 @@ int amdgpu_gem_list_handles_ioctl(struct drm_device *dev, void *data,
>  	return ret;
>  }
>  
> -static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
> -				  int width,
> -				  int cpp,
> -				  bool tiled)
> +static unsigned int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
> +					   unsigned int width,
> +					   unsigned int cpp,
> +					   bool tiled)
>  {
> -	int aligned = width;
> -	int pitch_mask = 0;
> +	unsigned int aligned = width;
> +	unsigned int pitch_mask = 0;
> +	unsigned int pitch;
>  
>  	switch (cpp) {
>  	case 1:
> @@ -1244,9 +1246,12 @@ static int amdgpu_gem_align_pitch(struct amdgpu_device *adev,
>  		break;
>  	}
>  
> -	aligned += pitch_mask;
> +	if (check_add_overflow(aligned, pitch_mask, &aligned))
> +		return 0;
>  	aligned &= ~pitch_mask;
> -	return aligned * cpp;
> +	if (check_mul_overflow(aligned, cpp, &pitch))
> +		return 0;
> +	return pitch;
>  }
>  
>  int amdgpu_mode_dumb_create(struct drm_file *file_priv,
> @@ -1273,8 +1278,12 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
>  
>  	args->pitch = amdgpu_gem_align_pitch(adev, args->width,
>  					     DIV_ROUND_UP(args->bpp, 8), 0);
> +	if (!args->pitch)
> +		return -EINVAL;
>  	args->size = (u64)args->pitch * args->height;
>  	args->size = ALIGN(args->size, PAGE_SIZE);
> +	if (!args->size)
> +		return -EINVAL;
>  	domain = amdgpu_bo_get_preferred_domain(adev,
>  				amdgpu_display_supported_domains(adev, flags));
>  	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,

