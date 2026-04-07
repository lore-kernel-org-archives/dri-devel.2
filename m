Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177E1EDB7EE
	for <dri-devel@archiver.kernel.org>; Tue,  7 Apr 2026 10:24:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BDBD10E3C1;
	Tue,  7 Apr 2026 10:24:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="Anqh7UmA";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010067.outbound.protection.outlook.com
 [52.101.193.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0AC410E3C1;
 Tue,  7 Apr 2026 10:24:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cwV2LrjHUxnYcbUG4yUujKMbPum+ar6L6bWSNM+brEWdqQBBfWFOGniShHtoIKzRAhKyUGuie1wMrenNsE/TibTSV2ENwFDNidCIYIh7zH2gSoOxJ5YRbAg5/uvfD30T+w5ryPTMam12wY7CL23JNUsxwuagxi2gFgCAQsCS+wa5QMavBNq1Ga0QzROfvCZ2/+TbQlXeRjICx9eijT6BIzgLudJ9hkbqPV/FF8KpVufXH60Y823tdN9pL8mwa7WZYFykhTFk2/SYtsWixj45f1VgBFKiSX7/GkQOJgG57hcLdiyrSQ0ddvBPrMtHUi/bUSuWrWx74epn3weCvmavag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JSXkC4JqQ/EWciykyNBshEI8N9PVtBu46hcqsDxyUec=;
 b=w9CMiauFQ3QtRTRpeI9T9YO+UyLAzStiL5Wk745TlvtBFzsGb/2kc/Nnz2BZnS1F/f1NJ6BS6ZvPwgnh0lz0WPF4j/WRODqxCUeyr8s444XHdLyjn5zyZDWqKB4yA/eT++zelVCyAS0uAWSJSosU/YK/ovLnFV22UFZmsu5FEOI2RHj9pjAZzCz5S0QaSwgXiN088hFOGDivDozdBMkveGoR1piGX7dkbLHjvQGplxsizJ+gyQYvxhoYdWhF06cZmrHB0xo83zTIMXRBVUV6ZrBCprUiJ/KjaADH98i9xsxhEfDdYjN6QCWzkQqPGLXbPe8rlICT6McfcIr167UULg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JSXkC4JqQ/EWciykyNBshEI8N9PVtBu46hcqsDxyUec=;
 b=Anqh7UmAEF39OiuYZa22HrhfKiZ8iGppy2o66BvBVUee1bdMtyGs1TOlYU2+fIKrOlvjV44COE9jOrQTtTmPFWj3gFG3SVSTH3sreWCvCWR9LtPV3uEgYUSvAKhi20wUT0m+rwKnNmV1heMaAWOW0oi7AoP59ObiBAnFt9c2Z2I=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW6PR12MB9017.namprd12.prod.outlook.com (2603:10b6:303:23b::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 7 Apr
 2026 10:24:27 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.20.9769.016; Tue, 7 Apr 2026
 10:24:27 +0000
Message-ID: <d9248003-3661-4247-9b1f-3bee1f3d8b39@amd.com>
Date: Tue, 7 Apr 2026 12:24:21 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] drm/amdgpu: split
 amdgpu_ttm_set_buffer_funcs_status in 2 funcs
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260403083602.1771-1-pierre-eric.pelloux-prayer@amd.com>
 <20260403083602.1771-7-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260403083602.1771-7-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1P222CA0014.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::19) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW6PR12MB9017:EE_
X-MS-Office365-Filtering-Correlation-Id: 19afe060-a3ed-4919-8971-08de948fd8d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: VKkJ0iyPlo+6emMIohlKDI3mImkP+pLxFbPVRolh9PImoHyz23QySI7psZL4gYFkeq8+LAwxrLuaGijwQDcfg8T2k316NgK7b204yxcu12qRuGbjSwyfABoHE3soOt3WLRxLe0fm5WmhjyK3rN4xoFaHyq2Xtbag7+2034/JVTNUIlXq6Ervray+/7A1jJU+zS9uHiqnrSaygTVVgvq6zJu7AYy3MEobL2M+VLXpkSSnO3GxphsIhckimv9uV/7Ke0R3koiA0d0iYahkVDFqm/2DEUd/Csh5SE8JMlEmoBVnDCJMK6oib6k9rqAEdF6sAgCFp6DkeS+TEH/3kMTUrUAZyXO8HYOH6M1pYS9q4lvlP0yg+uWTdLPhjtt1Ag6RUYqq1gk9gl7jeWhCTDWr0DXB99fUZprBEco+KKIw45wJghBCKmNxpGtj0QSF11h12+K9Dg1jTszvvZQCcRj5n5JI/2khNf21QNaIMSgko8wMvgB/yhn/c5DJk9qwrzPoV4EpjWjEccy7l8U+l5mLowoIN1Fc+HnAdYbFpt/NzqlCu49taP4mE0yTFVaxLguGB6ZicEUlzi1abCX+4g4tzv4rJPk8wNJ37VzPvhQ1JrIVFbQ/9FMjaI5XeKAJqcDyD0fFLC1EfQDo65JXaYQ7j/n3EJumDG3pjlg+coVr4xy/o82jEUhelPWYUIhlSdeiF0emKpBDHzdrjZdHf6fOKhKUKjSZe2tNCbSdGVnw/90=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TWRKSW5hanRqWlhENFBsVUFZTlVkRTlLUHFlelFKK01oUTFOUzJRc0NibUlQ?=
 =?utf-8?B?SGlmZ1g3Nk9UUjRDZGQ0SkpaRHczbEh5Z3g5MlI1eWhmSS9RT2R2Z3ZYTnBX?=
 =?utf-8?B?RGVZYy9WUk5SRHA4MWJHc0Z6WFd3Z2ZuZ24zZWc3bnZJdjdwQXZiYXNRMkYz?=
 =?utf-8?B?QWxxSnVDRGNUbTdGRjdZR2tKNFk0ZFo4cVk1Y1lESmtJazJ0d1pxSUJiTFFW?=
 =?utf-8?B?dXhFaDNoQnFkZHlEWVIzbFFua1ZCL3hPWm1aMFpwSUFtL2wrRGR1WU1SalFR?=
 =?utf-8?B?TFBORU5tZ0RMSUloeWJ3M1A0RXRyMDczb04rT3dXMkRlejRKM2trNk5ITzBV?=
 =?utf-8?B?UDFTYWdzRld3TDJOK0F1QW9ySkhtR2IvUEd4ZmVoTG93dE5EY2N3QzFma3dG?=
 =?utf-8?B?OUt6a2tEUHlTZ01xK25TV0NCa2Eza2hFNkFSZ1pUTjNNRCswWU52VjIyZW8x?=
 =?utf-8?B?YjRjaG5lZHRGamNxbVdYOXdlNVZRcnQyN0NxeGc2dlhPKzZTUXZRODltVWpD?=
 =?utf-8?B?VnlMTmFMT1NweGxaaGljY1lWbzJHN2Zkb0lOWDM3VWRlcnZCN1AxaVoyZVJa?=
 =?utf-8?B?aS8xL2k5dHB0ZFFvemhQeUNKY0VSM1VtRCtkWWpYaWcwQzNzdG1rY3A0bVM5?=
 =?utf-8?B?MmZLazhPM01nRllRalVkZ1FUZ0NlMStYeVd4VC9SSmhqdlZXcTVLZllhdHJ3?=
 =?utf-8?B?T0hHQkRiRnByZXlHL1hMMWx0Ukd6WkphRDVTbklsckFZRENiSGt3QjUyVS9H?=
 =?utf-8?B?RTNRRnhUYkhJcEdVYk05dXdjMEFJdlhaM3R4dndRVTV2U3lDWTNLeXlNUzgz?=
 =?utf-8?B?bURCNCtTSEplTmwxRk4xYXNJc3lDZXRQcTNsSFhQVzVFTDMyUTdiQ1hhSEgv?=
 =?utf-8?B?U1lSaHY1ZjhUa2lrTFgzVExCWmMyOE4ycWcwcWVLaEJWRWlyK0dzaHJ6YzBB?=
 =?utf-8?B?eUEwK0FtOHZ2WjVUN2UxNWFpNHJ5QVYzSDRlQXExVVQzV3E3WWpPTmhMQ01O?=
 =?utf-8?B?dElZL2NiUHVkbEx1c0JJSDMrZWE0V3hQd05xUDUxbitwQlVzUmxNQ3d2R2R1?=
 =?utf-8?B?VDZ3QjYwSStaeitKMWtPd1FkcEUyUVVuSVZFcTdva1JOTTNJbndLRmNvSHVJ?=
 =?utf-8?B?c1YwbXZ1ck0raVI1aVM5S2t3UW8vR1lYTzRPdlVJc2tRY0JObGtwUUViaGVX?=
 =?utf-8?B?Nnh5Z0JFOEsvNFE3OWpmcE1QaU9oUzI1MlBHTHJ6cUNQeS9BaURUbTBDTFFw?=
 =?utf-8?B?S3U0akZtelVkbHM0Wnhvc0tjYnVxbWMyME1nWko2S1lCQ3RuOFZwR3BZbm9i?=
 =?utf-8?B?YUFVT1YrSmVFWHRUVWdsZmVVSHBrODRjVTJTNUFvZ1hwZndPeGxaVDZNb3pJ?=
 =?utf-8?B?VXZmZm1jZ1g3RTZPdTFMRkhhYWRBdlZmam1OdVB5ejlOZTg3SUNGSGlYcDgw?=
 =?utf-8?B?T1ZiV0VCVCtzbUx5YjkvQ1FxWFhWQ1FEZEhTakNhRHdmNWpOR2pnb0ZheTdz?=
 =?utf-8?B?RVhzaVM0bEI1ekxuVzhwZUVsc0RYMENvOW5xS1pnUWI4eXdXeHYzZUEvRWJs?=
 =?utf-8?B?bEdlcmQwb2FkMVgrb1pscWpteHI5dWJiMGlBZzlCMGZ0eGVjWURuZGhJNDJG?=
 =?utf-8?B?Nm1vNXJ5QlVzMDNVSGhubktYWVBlUkJyQ0FrQkh1bTZWT3VldmNkMDRCTVQz?=
 =?utf-8?B?ODFMRDJaZFBONTJtQkt3clE5cGdSMUJTdHBKQzg4dnZEV1FrdkhTSmNVYmNB?=
 =?utf-8?B?ZWsyaDZjNnhDY1R2b3pRQzI3Szc3dVZWV0JQdmxxZE85MzJTcVVFTFJIbXU2?=
 =?utf-8?B?MWp0Uk01S0FCR25RckM0Rk9BcWFXZGtzUVkyeWx3cHArVU1CZm8zRGY4dlRC?=
 =?utf-8?B?Z0UyUTJvQU5yRVY0Wi9hS1Q0UEdxbFJ4eUVnd1VCSzBsVERYbXhoT05RZW5a?=
 =?utf-8?B?aFhHVlhieGN5VjNlcjNBWm9GdlJUU3g4OWlyZ2J5WTlqOGd2YWR3RHNzalRH?=
 =?utf-8?B?a2hINWhpaVpvSVZRK2w3dUFVcWlzaStudzhGVUhTT1IwL2dCc2JLeDZKQVp4?=
 =?utf-8?B?c3R0UFV3bytpck1lN2tXSWVGU3dHbEcwN1d1RTlJSElQL3BiaUZQZ21DMlp3?=
 =?utf-8?B?SmRvdHI1dkNEYy8zbUE2Mm1tUjc3VWFlQWw5WU9ScGVkNVIrNlBkOHVWT1FU?=
 =?utf-8?B?cURBRksyNllwa25hV0xrN3JwYWQvSElsaTllQU9CS0JCbHhOQ2tYVlBUcUx0?=
 =?utf-8?B?MXpzblBBOHBYeEZGd1ZXZTdkTkhqelJiSGRqaERWZjlwWkR3Z0RQNit2dTUx?=
 =?utf-8?Q?4DKb41GTuicY7NXrxy?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19afe060-a3ed-4919-8971-08de948fd8d8
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:24:27.4496 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5TqIW4Y6vjeD62uQBb9c9re4iaDqAsbRp8wQNbKaiQjX9es9uNHJPbnZKLgAPtlQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9017
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
> Makes a code slightly clearer and reduces indentation.
> 
> ---
> v5: use amdgpu_in_reset in amdgpu_ttm_disable_buffer_funcs
> ---
> 
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> Suggested-by: Christian König <christian.koenig@amd.com>

Reviewed-by: Christian König <christian.koenig@amd.com>

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  14 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    | 186 +++++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |   4 +-
>  3 files changed, 108 insertions(+), 96 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 4da8de34be3d..a24f52e71850 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2463,7 +2463,7 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	if (r)
>  		goto init_failed;
>  
> -	amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +	amdgpu_ttm_enable_buffer_funcs(adev);
>  
>  	/* Don't init kfd if whole hive need to be reset during init */
>  	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
> @@ -3147,7 +3147,7 @@ static int amdgpu_device_ip_suspend(struct amdgpu_device *adev)
>  		amdgpu_virt_request_full_gpu(adev, false);
>  	}
>  
> -	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +	amdgpu_ttm_disable_buffer_funcs(adev);
>  
>  	r = amdgpu_device_ip_suspend_phase1(adev);
>  	if (r)
> @@ -3362,7 +3362,7 @@ static int amdgpu_device_ip_resume(struct amdgpu_device *adev)
>  
>  	r = amdgpu_device_ip_resume_phase2(adev);
>  
> -	amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +	amdgpu_ttm_enable_buffer_funcs(adev);
>  
>  	if (r)
>  		return r;
> @@ -4215,7 +4215,7 @@ void amdgpu_device_fini_hw(struct amdgpu_device *adev)
>  	/* disable ras feature must before hw fini */
>  	amdgpu_ras_pre_fini(adev);
>  
> -	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +	amdgpu_ttm_disable_buffer_funcs(adev);
>  
>  	/*
>  	 * device went through surprise hotplug; we need to destroy topology
> @@ -4482,7 +4482,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	if (r)
>  		goto unwind_userq;
>  
> -	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +	amdgpu_ttm_disable_buffer_funcs(adev);
>  
>  	amdgpu_fence_driver_hw_fini(adev);
>  
> @@ -4496,7 +4496,7 @@ int amdgpu_device_suspend(struct drm_device *dev, bool notify_clients)
>  	return 0;
>  
>  unwind_evict:
> -	amdgpu_ttm_set_buffer_funcs_status(adev, true);
> +	amdgpu_ttm_enable_buffer_funcs(adev);
>  	amdgpu_fence_driver_hw_init(adev);
>  
>  unwind_userq:
> @@ -5230,7 +5230,7 @@ int amdgpu_device_reinit_after_reset(struct amdgpu_reset_context *reset_context)
>  				if (r)
>  					goto out;
>  
> -				amdgpu_ttm_set_buffer_funcs_status(tmp_adev, true);
> +				amdgpu_ttm_enable_buffer_funcs(tmp_adev);
>  
>  				r = amdgpu_device_ip_resume_phase3(tmp_adev);
>  				if (r)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> index e74f9f8a88dc..9bbd8149ffd2 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> @@ -2100,7 +2100,7 @@ int amdgpu_ttm_init(struct amdgpu_device *adev)
>  	}
>  
>  	/* Change the size here instead of the init above so only lpfn is affected */
> -	amdgpu_ttm_set_buffer_funcs_status(adev, false);
> +	amdgpu_ttm_disable_buffer_funcs(adev);
>  #ifdef CONFIG_64BIT
>  #ifdef CONFIG_X86
>  	if (adev->gmc.xgmi.connected_to_cpu)
> @@ -2329,115 +2329,91 @@ void amdgpu_ttm_fini(struct amdgpu_device *adev)
>  }
>  
>  /**
> - * amdgpu_ttm_set_buffer_funcs_status - enable/disable use of buffer functions
> + * amdgpu_ttm_enable_buffer_funcs - enable use of buffer functions
>   *
>   * @adev: amdgpu_device pointer
> - * @enable: true when we can use buffer functions.
>   *
> - * Enable/disable use of buffer functions during suspend/resume. This should
> + * Enable use of buffer functions during suspend/resume. This should
>   * only be called at bootup or when userspace isn't running.
>   */
> -void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
> +void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev)
>  {
>  	struct ttm_resource_manager *man = ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
>  	u32 num_clear_entities, num_move_entities;
> -	uint64_t size;
>  	int r, i, j;
>  
>  	if (!adev->mman.initialized || amdgpu_in_reset(adev) ||
> -	    adev->mman.buffer_funcs_enabled == enable || adev->gmc.is_app_apu)
> +	    adev->mman.buffer_funcs_enabled || adev->gmc.is_app_apu)
>  		return;
>  
> -	if (enable) {
> -		if (!adev->mman.num_buffer_funcs_scheds) {
> -			dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
> -			return;
> -		}
> +	if (!adev->mman.num_buffer_funcs_scheds) {
> +		dev_warn(adev->dev, "Not enabling DMA transfers for in kernel use");
> +		return;
> +	}
> +
> +	r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
> +						&adev->mman.default_entity,
> +						DRM_SCHED_PRIORITY_KERNEL,
> +						adev->mman.buffer_funcs_scheds, 1, 0);
> +	if (r < 0) {
> +		dev_err(adev->dev,
> +			"Failed setting up TTM entity (%d)\n", r);
> +		return;
> +	}
> +
> +	num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
> +	num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
> +
> +	adev->mman.clear_entities = kcalloc(num_clear_entities,
> +						sizeof(struct amdgpu_ttm_buffer_entity),
> +						GFP_KERNEL);
> +	atomic_set(&adev->mman.next_clear_entity, 0);
> +	if (!adev->mman.clear_entities)
> +		goto error_free_default_entity;
> +
> +	adev->mman.num_clear_entities = num_clear_entities;
> +
> +	for (i = 0; i < num_clear_entities; i++) {
> +		r = amdgpu_ttm_buffer_entity_init(
> +			&adev->mman.gtt_mgr,
> +			&adev->mman.clear_entities[i],
> +			DRM_SCHED_PRIORITY_NORMAL,
> +			adev->mman.buffer_funcs_scheds,
> +			adev->mman.num_buffer_funcs_scheds, 1);
>  
> -		num_clear_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
> -		num_move_entities = MIN(adev->mman.num_buffer_funcs_scheds, TTM_NUM_MOVE_FENCES);
> -		r = amdgpu_ttm_buffer_entity_init(&adev->mman.gtt_mgr,
> -						  &adev->mman.default_entity,
> -						  DRM_SCHED_PRIORITY_KERNEL,
> -						  adev->mman.buffer_funcs_scheds, 1, 0);
>  		if (r < 0) {
> -			dev_err(adev->dev,
> -				"Failed setting up TTM entity (%d)\n", r);
> -			return;
> -		}
> -
> -		adev->mman.clear_entities = kcalloc(num_clear_entities,
> -						    sizeof(struct amdgpu_ttm_buffer_entity),
> -						    GFP_KERNEL);
> -		atomic_set(&adev->mman.next_clear_entity, 0);
> -		if (!adev->mman.clear_entities)
> +			for (j = 0; j < i; j++)
> +				amdgpu_ttm_buffer_entity_fini(
> +					&adev->mman.gtt_mgr, &adev->mman.clear_entities[j]);
> +			adev->mman.num_clear_entities = 0;
> +			kfree(adev->mman.clear_entities);
>  			goto error_free_default_entity;
> -
> -		adev->mman.num_clear_entities = num_clear_entities;
> -
> -		for (i = 0; i < num_clear_entities; i++) {
> -			r = amdgpu_ttm_buffer_entity_init(
> -				&adev->mman.gtt_mgr,
> -				&adev->mman.clear_entities[i],
> -				DRM_SCHED_PRIORITY_NORMAL,
> -				adev->mman.buffer_funcs_scheds,
> -				adev->mman.num_buffer_funcs_scheds, 1);
> -
> -			if (r < 0) {
> -				for (j = 0; j < i; j++)
> -					amdgpu_ttm_buffer_entity_fini(
> -						&adev->mman.gtt_mgr, &adev->mman.clear_entities[j]);
> -				kfree(adev->mman.clear_entities);
> -				adev->mman.num_clear_entities = 0;
> -				adev->mman.clear_entities = NULL;
> -				goto error_free_default_entity;
> -			}
>  		}
> +	}
>  
> -		adev->mman.num_move_entities = num_move_entities;
> -		atomic_set(&adev->mman.next_move_entity, 0);
> -		for (i = 0; i < num_move_entities; i++) {
> -			r = amdgpu_ttm_buffer_entity_init(
> -				&adev->mman.gtt_mgr,
> -				&adev->mman.move_entities[i],
> -				DRM_SCHED_PRIORITY_NORMAL,
> -				adev->mman.buffer_funcs_scheds,
> -				adev->mman.num_buffer_funcs_scheds, 2);
> +	adev->mman.num_move_entities = num_move_entities;
> +	atomic_set(&adev->mman.next_move_entity, 0);
> +	for (i = 0; i < num_move_entities; i++) {
> +		r = amdgpu_ttm_buffer_entity_init(
> +			&adev->mman.gtt_mgr,
> +			&adev->mman.move_entities[i],
> +			DRM_SCHED_PRIORITY_NORMAL,
> +			adev->mman.buffer_funcs_scheds,
> +			adev->mman.num_buffer_funcs_scheds, 2);
>  
> -			if (r < 0) {
> -				for (j = 0; j < i; j++)
> -					amdgpu_ttm_buffer_entity_fini(
> -						&adev->mman.gtt_mgr, &adev->mman.move_entities[j]);
> -				adev->mman.num_move_entities = 0;
> -				goto error_free_clear_entities;
> -			}
> +		if (r < 0) {
> +			for (j = 0; j < i; j++)
> +				amdgpu_ttm_buffer_entity_fini(
> +					&adev->mman.gtt_mgr,
> +					&adev->mman.move_entities[j]);
> +			adev->mman.num_move_entities = 0;
> +			goto error_free_clear_entities;
>  		}
> -	} else {
> -		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> -					      &adev->mman.default_entity);
> -		for (i = 0; i < adev->mman.num_clear_entities; i++)
> -			amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> -						      &adev->mman.clear_entities[i]);
> -		for (i = 0; i < adev->mman.num_move_entities; i++)
> -			amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> -						      &adev->mman.move_entities[i]);
> -		/* Drop all the old fences since re-creating the scheduler entities
> -		 * will allocate new contexts.
> -		 */
> -		ttm_resource_manager_cleanup(man);
> -		kfree(adev->mman.clear_entities);
> -		adev->mman.clear_entities = NULL;
> -		adev->mman.num_clear_entities = 0;
> -		adev->mman.num_move_entities = 0;
>  	}
>  
>  	/* this just adjusts TTM size idea, which sets lpfn to the correct value */
> -	if (enable)
> -		size = adev->gmc.real_vram_size;
> -	else
> -		size = adev->gmc.visible_vram_size;
> -	man->size = size;
> -	adev->mman.buffer_funcs_enabled = enable;
> +	man->size = adev->gmc.real_vram_size;
> +	adev->mman.buffer_funcs_enabled = true;
>  
>  	return;
>  
> @@ -2453,6 +2429,42 @@ void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev, bool enable)
>  				      &adev->mman.default_entity);
>  }
>  
> +/**
> + * amdgpu_ttm_disable_buffer_funcs - disable use of buffer functions
> + *
> + * @adev: amdgpu_device pointer
> + */
> +void amdgpu_ttm_disable_buffer_funcs(struct amdgpu_device *adev)
> +{
> +	struct ttm_resource_manager *man =
> +		ttm_manager_type(&adev->mman.bdev, TTM_PL_VRAM);
> +	int i;
> +
> +	if (!adev->mman.buffer_funcs_enabled || amdgpu_in_reset(adev))
> +		return;
> +
> +	amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> +				      &adev->mman.default_entity);
> +	for (i = 0; i < adev->mman.num_move_entities; i++)
> +		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> +					      &adev->mman.move_entities[i]);
> +	for (i = 0; i < adev->mman.num_clear_entities; i++)
> +		amdgpu_ttm_buffer_entity_fini(&adev->mman.gtt_mgr,
> +					      &adev->mman.clear_entities[i]);
> +	/* Drop all the old fences since re-creating the scheduler entities
> +	 * will allocate new contexts.
> +	 */
> +	ttm_resource_manager_cleanup(man);
> +
> +	kfree(adev->mman.clear_entities);
> +	adev->mman.clear_entities = NULL;
> +	adev->mman.num_clear_entities = 0;
> +	adev->mman.num_move_entities = 0;
> +
> +	man->size = adev->gmc.visible_vram_size;
> +	adev->mman.buffer_funcs_enabled = false;
> +}
> +
>  static int amdgpu_ttm_prepare_job(struct amdgpu_device *adev,
>  				  struct amdgpu_ttm_buffer_entity *entity,
>  				  unsigned int num_dw,
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> index d7b14d5cac77..8a5f34aaabac 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> @@ -178,8 +178,8 @@ bool amdgpu_res_cpu_visible(struct amdgpu_device *adev,
>  
>  int amdgpu_ttm_init(struct amdgpu_device *adev);
>  void amdgpu_ttm_fini(struct amdgpu_device *adev);
> -void amdgpu_ttm_set_buffer_funcs_status(struct amdgpu_device *adev,
> -					bool enable);
> +void amdgpu_ttm_enable_buffer_funcs(struct amdgpu_device *adev);
> +void amdgpu_ttm_disable_buffer_funcs(struct amdgpu_device *adev);
>  int amdgpu_copy_buffer(struct amdgpu_device *adev,
>  		       struct amdgpu_ttm_buffer_entity *entity,
>  		       uint64_t src_offset,

