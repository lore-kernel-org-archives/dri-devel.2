Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA7BB606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 09:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=f5ZbK5np
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29CCF10E106;
	Tue, 10 Nov 2026 09:07:58 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8BFAE10E106;
 Tue, 10 Nov 2026 09:07:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OtWQS51GGUZ8kx75pzfB8SZdO5MWTFgFSSP9AjCByDNNrDA7RMjNFfP6wYJ/sGl+Ji8Zq58CIuWThJD8o4lNWUMj2oxlEc9nxAqrwzdKCI46G5Kl75grwqeB9ZbMcVnSyhZcDWvQbX8PxlsG2aBx+49lozt0eBSlHCzaDAKt6lGbCc/Gn3Y+l1W71io1nGhmKuGcDqcVCHJS/lVOXe//uJF8W1+uPJP7EakhmXcn2wr1rFUf/LQfkjgTk5m4I+d3zZ1tSCUaFr3utcN8REVo3zSSbrz4neim63eEpAvmwvUhDI6tzBo09CpfewT9j8Dp2af1Rxe4rP2X5qIQtyDR8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLFOyYGhahOEWDXF4x4CfmEVP4CeiGmopVhYSf5X6SY=;
 b=OzAojobKJKxqhEehdOYzYhybQx+SEmX1TQn0DTmfnzBJg5npUKVGd0CK4tjI2MkOMSG2QHHiE65+ng+rxRiw6Y9Xurz+K2BDYHapUPKrTouf1oRGCjIeXToYddyM/at+4FBNrqpT7D0/0VN6uOYnYMkmxxE7hXjgDXPSPFTofUfonTbUTG/3IOyG/ON1ORxc04Aapxivtnps0yGIFSPXzThe1oNUcTvV8paoIxeQTTaSoQt/877i++Tsd91NXyGVCApZuMzSOOFgka7agOimHZY05d+FCZM1X7OpwJ09AokOFDnsrkM4HYgoCjYlblQ8yOjMwzxmbMv//sFl2ynCNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLFOyYGhahOEWDXF4x4CfmEVP4CeiGmopVhYSf5X6SY=;
 b=f5ZbK5npqAu0fvR1f0wPfmdyGkRYo3T8fPFuksK9fnXzbQt7DrG2RFuNwW4g0pSoX56bubKKq7G3hv7kSdRdlPsb6tDKGgcopQxEGmmFY9cPYtBRlM7RbCWwZ/FZmGswSUyww7J6HjoHMq62tBrLTe2SASB3F3wHqzSn8NW2Jtg=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS4PR12MB077728.namprd12.prod.outlook.com (2603:10b6:8:506::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Tue, 10 Nov
 2026 09:07:50 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0615.007; Tue, 10 Nov 2026
 09:07:50 +0000
Message-ID: <21061e43-992f-42e4-a030-a2bf243ee70e@amd.com>
Date: Tue, 10 Nov 2026 10:07:46 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/6] drm/amdgpu: handle gpu_recovery per device
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Felix Kuehling <Felix.Kuehling@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261109171333.4329-1-pierre-eric.pelloux-prayer@amd.com>
 <20261109171333.4329-4-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261109171333.4329-4-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0078.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9a::20) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS4PR12MB077728:EE_
X-MS-Office365-Filtering-Correlation-Id: f4f0b6da-744d-417a-2f1d-08df3f0a1847
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|3023799007|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261028144727099003|261009223327099003|261009223027099003|261009221727099003|261009221227099003|261009220027099003|261022105027099003|261022075727099003|261102123227099003|10067099003|11063799006|4143699003|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /g0Xv34cENdXcS77hyhVm5GW8jfPbPzd3uWAGJXvMmT6dx8+XZ3yA3Ddkaq5tAAuveQLwBA1QhCMJ2n18YrxDzI5Cv4oXMEVnCFZePPXSKtWLDvYzSfahjbpOAHKWZcccRS4t9IIEsl3giKngrdK0bbRaiNYNff8wsLSZLbMeGWyRnCp0lwiBzCGgkBhQgKh70bX6xIFC9cyqlvvCYvN9yJJ4xVD6mHgr4asrFMygytYYAI95wbt4pfgtw9z9fArV20x5Xt6pMfZjwQme1Zc0GG3el45Ala1nwEfjai6AQNxeIO489S3hQpDYOwFjI9R8ncv9xypvUJOMLhjysh/C9fOTYTg2ITnxKkgQdLPds+aJRxNU3cmR/0JtJoJCYzWAXWzE9oMFs+Sag331JDzuKERLttQJyy5LbAoWEoC6qAZwjhVR6p/yLAor6dtR1505Zr8PIR0JD9TUBS9Z8a8lkXcmf+0a32lUiiITrm1AcX3v9WMiL/ajUrZ4ZZ6RnL6E3fHxGrkLJiZ9dthbbRazdtGi0zNk3vRpq1XbWfXH19nnUfysii8kcGMikDfDLQGkue4B+Bd2+sbOlYV7t+SCthImRzBjs2cp+8+QXlE8Lxpvk5HOy4fNdEw8sy6ZNhiPTktSfURqX/hDTDiUzlbSXfSz8ACmWHi/ZmlLeSKST8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(3023799007)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261028144727099003)(261009223327099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009220027099003)(261022105027099003)(261022075727099003)(261102123227099003)(10067099003)(11063799006)(4143699003)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UkdIcjljQXdMSVFvdjluS0Q1M3hZdzFwejc4dFpWMzZ0dGpLM092cnZHT28x?=
 =?utf-8?B?eHdmclZIa2o0Vi9xbzVuZWFmVDNKQVJLanFJZWRneWlyZ281SThNaGxiQklK?=
 =?utf-8?B?Uk10enVSaGNrVEhPQUZMNXh5NTFkb0laVzhZSm8vejNiNHZrWEFJL1gxKzlJ?=
 =?utf-8?B?VWZvOXkyTHI5T3pWU05JazBmV3ZtZ0Y0RjBSeFpzNW5Xc1BPZmRPMGE1TVAz?=
 =?utf-8?B?dHByU1lwSnFVajVTTVljcUcrL0VlYk9iNldFMGhkZ2tuVU5YNGFMNTlyZWlR?=
 =?utf-8?B?TG5lRWhnR0FOTk9qQldUMzJQdnQvbDRNVlZ5WEJoRUJ5OWcrTXgwVjdpQUZP?=
 =?utf-8?B?Q2VsRjRqVnROZWxraWYzd0FLbldvd3M2c0lSNUZqUkNjKzRuSzdLSE9aN0dw?=
 =?utf-8?B?NGtla1JHQjRGTmZwSVVHcnVjUXF3TmV5MzBEc2tzUnBHQXZpR0VUNVkrVk8r?=
 =?utf-8?B?eVNPbVB2Nm1ZM0FyRGlvN1dPYkNNdmJHUVZYMFluNGdpRm5QcW1OVVR6VEV2?=
 =?utf-8?B?eE43Wmk4RjhUNzBCRHhxQzMyczlOdGxlS1B1MjFOcWxNQ2tGampLUWlJMjJr?=
 =?utf-8?B?NlliaTluQVRyTHJGcUp1QUs2UHF1WDVsQTI4UVFWUkNxYTRVS0ZQUDBsUkdY?=
 =?utf-8?B?amZtNG1hZEFwYzViVStiUnFPeE5jTVdveW9sVEUrUHNVbTB4S1M1Vnkzekor?=
 =?utf-8?B?ektYRXZtWkM3S1dXWUpzc2cvZGtidGFUS0JDa2pKdHdQOFpFK3pGWHlHeFg3?=
 =?utf-8?B?WTI3SFBLYjRQa2w4SGhjZkYvNnhMMDFYOEhTMy9QNm15a1ZhR0FPNmRhUUs4?=
 =?utf-8?B?OVJqeThpZ0VPa05xQW1vWFBqdVVHc3NtOUo1OHNETVlpMWpTd0REQVErTFpR?=
 =?utf-8?B?KzE4NzkxMmhSVUl3bE9idmVVRTJPUlN6QWNMNEphdEt6ZnVvQjF5dzBoZ1ds?=
 =?utf-8?B?SVltR2JyTDFkL0IzcGJ4aitjT3RzM2I5SU5YaUVBVGhQWkltd2xJeTNGQVRx?=
 =?utf-8?B?QkJ5VFE3bkF2dXFiYUNHKzk2THVrWUYrYWhvd0JZNFNtU0FIclY0aFRabU1o?=
 =?utf-8?B?bTJ3aFdhZjFTZkVJZHpnUjh5Mmt4S3Nqb1cxTVZxZGZNTTVOVE5lbzIzZm9x?=
 =?utf-8?B?UHE0ei90ZWgybHJiR3JyN29pMVVONFlvMXhzMGNZQjNTVi96dGRPWTFqcVBL?=
 =?utf-8?B?Vmx0U1hMZXdmZHp1TUxFRmw0bExIRC9FMEZPWE1PbXRHQ0hFd2NuSXVVbllK?=
 =?utf-8?B?bXlUVlZYQXVHZkRxRHRlaks5REdEMHRQSERpRkF2VzNOWnNBZ1JaeUpUSEtH?=
 =?utf-8?B?b1VMZGZqcVZ2aVRKZjlNWEp4TVVSNW03K0FiZkF0ajEzYW9hWnVGcVVXZVhm?=
 =?utf-8?B?T3IrMFR5d1lsZktzdHUrRE5aNkxTcC8yKzhyczVZaDFkN3JjYWJIRFZKTW1m?=
 =?utf-8?B?R0Y1elViQVU3UmY1b3EwQTZJNUtNd1ZGQWZ5STRHcXIyWnBPZzQvTmhybTFp?=
 =?utf-8?B?T3ZWbGNleWhHQkphb3FBU2RJZUZpR0o5U3NLSHlIVHdvVlNIeFNOWitsT0pU?=
 =?utf-8?B?dVR2ZnBHVVVMblMyNFRpYUVzK3J1L0g4UThmbVEwQkR2enZLSmpNczFjZnFm?=
 =?utf-8?B?YW85U3Awd3RaaUZLT2J5NkZpWGVRdUhQWTROYnVOTWRIRCtac1kwdlhaZ3A5?=
 =?utf-8?B?YTN5MTJYbXFTRkd0TUFRSHNrNnRGM0VhRndsZUhEVTJXa2o2T2hXV0hJZFZt?=
 =?utf-8?B?dDl3NThPcjNzRHBVa3RwaGhDVXN6bCs4MmVEYW1LZ1ljeFFKOTlaV3UrNnkv?=
 =?utf-8?B?Q0tkMXR5anh0ejN5R29ySkljY0gxR3l0Ym5KT2xkeHptRkhLRVlLR2JuSXVC?=
 =?utf-8?B?UEl0L1NYeG83bURhc1NGZGNLeExhdzlpK29yanpSdjZBRHJZUzd4NTV2R1RU?=
 =?utf-8?B?UTYzaFIvajhvZjZMdm5QODlnQVpQRFphc0QzUlRYK3dER01YekZBMHE5aEY5?=
 =?utf-8?B?VXRDOEpsVE5ValZaU3FoZUVwWVUyRkwwQkNUYkUvdkJCZUJoZEo2azhIeFpI?=
 =?utf-8?B?TFR2dTFjRldzeHpqbzJlSEMzcy9UWDJ1VWtjaFl1OExqMnZtK2J0RER1QkZj?=
 =?utf-8?B?TEFRQnZwTmI3ckJua3lIcXA1bUY1NlMrL2tMRjhUMVhFcHZ6cEZzbWorWndL?=
 =?utf-8?B?YjdSWjRzckM1NmFoc1dlOFp0N2hZRTNEZWw3bjA5eEs1UzF3SkxXTUZDOG5C?=
 =?utf-8?B?Z0xGRVppNjVnMWhUTmNUU2I0RDBuMGc1RDlIRkEyWHBFOWYzM2FFV0p0WHNU?=
 =?utf-8?Q?qILMevaTSGMDfJ/buf?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f4f0b6da-744d-417a-2f1d-08df3f0a1847
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2026 09:07:50.1182 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kSRcejRSdZKL6meI2P0LUyNKu8sxWpM6IQEutZNuOoHWZIyx1kupun6vojN6fCN7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB077728
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 18:13, Pierre-Eric Pelloux-Prayer wrote:
> Instead of having a module wide parameter, store gpu_recovery
> in amdgpu_device. Its initial value is based on the boot param
> and it can be overridden by writing to the existing
> amdgpu_gpu_recover debugfs file, so a single device can have
> auto-recovery disabled without affecting every other GPU in the
> system.
> 
> amdgpu_device_should_recover_gpu() now only consider this param.
> 
> Assisted-by: LLM
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h           | 11 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c    | 92 +++++++++----------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c     | 21 ++++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c       |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c       |  6 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c      |  4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c     |  4 +-
>  drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c         |  2 +-
>  drivers/gpu/drm/amd/amdgpu/soc15.c            |  2 +-
>  .../drm/amd/amdkfd/kfd_device_queue_manager.c |  6 +-
>  10 files changed, 81 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5a32b54b1e9b..a486ac746a5b 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -982,6 +982,9 @@ struct amdgpu_device {
>  
>  	struct amdgpu_uma_carveout_info uma_info;
>  
> +	/* Per device gpu_recovery setting. 0 means disabled. */
> +	unsigned int gpu_recovery;
> +
>  	/* KFD
>  	 * Must be last --ends in a flexible-array member.
>  	 */
> @@ -1195,7 +1198,6 @@ int emu_soc_asic_init(struct amdgpu_device *adev);
>  
>  /* Common functions */
>  bool amdgpu_device_has_job_running(struct amdgpu_device *adev);
> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev);
>  int amdgpu_device_gpu_recover(struct amdgpu_device *adev,
>  			      struct amdgpu_job *job,
>  			      struct amdgpu_reset_context *reset_context);
> @@ -1323,9 +1325,14 @@ int amdgpu_device_set_cg_state(struct amdgpu_device *adev,
>  int amdgpu_device_set_pg_state(struct amdgpu_device *adev,
>  			       enum amd_powergating_state state);
>  
> +static inline bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
> +{
> +	return adev->gpu_recovery != 0;
> +}
> +
>  static inline bool amdgpu_device_has_timeouts_enabled(struct amdgpu_device *adev)
>  {
> -	return amdgpu_gpu_recovery != 0 &&
> +	return amdgpu_device_should_recover_gpu(adev) &&
>  		adev->gfx_timeout != MAX_SCHEDULE_TIMEOUT &&
>  		adev->compute_timeout != MAX_SCHEDULE_TIMEOUT &&
>  		adev->sdma_timeout != MAX_SCHEDULE_TIMEOUT &&
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 730e9e93d078..a812551b353f 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -3762,6 +3762,45 @@ amdgpu_device_should_register_switcheroo(struct amdgpu_device *adev, bool px)
>  		       apple_gmux_detect(NULL, NULL)));
>  }
>  
> +static void amdgpu_device_init_gpu_recovery(struct amdgpu_device *adev)
> +{
> +	adev->gpu_recovery = 0;
> +
> +	if (amdgpu_gpu_recovery == 0)
> +		return;
> +
> +	/* Skip soft reset check in fatal error mode */
> +	if (!amdgpu_ras_is_poison_mode_supported(adev) ||
> +	    amdgpu_sriov_vf(adev)) {
> +		adev->gpu_recovery = adev->gpu_recovery > 0 ?
> +			adev->gpu_recovery :-1;
> +	} else if (amdgpu_gpu_recovery == -1) {
> +		switch (adev->asic_type) {
> +#ifdef CONFIG_DRM_AMDGPU_SI
> +		case CHIP_VERDE:
> +		case CHIP_TAHITI:
> +		case CHIP_PITCAIRN:
> +		case CHIP_OLAND:
> +		case CHIP_HAINAN:
> +#endif
> +#ifdef CONFIG_DRM_AMDGPU_CIK
> +		case CHIP_KAVERI:
> +		case CHIP_KABINI:
> +		case CHIP_MULLINS:
> +#endif
> +		case CHIP_CARRIZO:
> +		case CHIP_STONEY:
> +		case CHIP_CYAN_SKILLFISH:
> +			return;


Hui? We have recovery disabled by default for those devices?

> +		default:
> +			adev->gpu_recovery = 1;
> +			break;
> +		}
> +	} else {
> +		adev->gpu_recovery = amdgpu_gpu_recovery;
> +	}
> +}
> +
>  /**
>   * amdgpu_device_init - initialize the driver
>   *
> @@ -4109,6 +4148,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  	}
>  
> +	amdgpu_device_init_gpu_recovery(adev);
> +
>  fence_driver_init:
>  	/* Fence driver */
>  	r = amdgpu_fence_driver_sw_init(adev);
> @@ -4894,57 +4935,6 @@ bool amdgpu_device_has_job_running(struct amdgpu_device *adev)
>  	return false;
>  }
>  
> -/**
> - * amdgpu_device_should_recover_gpu - check if we should try GPU recovery
> - *
> - * @adev: amdgpu_device pointer
> - *
> - * Check amdgpu_gpu_recovery and SRIOV status to see if we should try to recover
> - * a hung GPU.
> - */
> -bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
> -{
> -
> -	if (amdgpu_gpu_recovery == 0)
> -		goto disabled;
> -
> -	/* Skip soft reset check in fatal error mode */
> -	if (!amdgpu_ras_is_poison_mode_supported(adev))
> -		return true;
> -
> -	if (amdgpu_sriov_vf(adev))
> -		return true;
> -
> -	if (amdgpu_gpu_recovery == -1) {
> -		switch (adev->asic_type) {
> -#ifdef CONFIG_DRM_AMDGPU_SI
> -		case CHIP_VERDE:
> -		case CHIP_TAHITI:
> -		case CHIP_PITCAIRN:
> -		case CHIP_OLAND:
> -		case CHIP_HAINAN:
> -#endif
> -#ifdef CONFIG_DRM_AMDGPU_CIK
> -		case CHIP_KAVERI:
> -		case CHIP_KABINI:
> -		case CHIP_MULLINS:
> -#endif
> -		case CHIP_CARRIZO:
> -		case CHIP_STONEY:
> -		case CHIP_CYAN_SKILLFISH:
> -			goto disabled;
> -		default:
> -			break;
> -		}
> -	}
> -
> -	return true;
> -
> -disabled:
> -		dev_info(adev->dev, "GPU recovery disabled.\n");
> -		return false;
> -}
> -
>  int amdgpu_device_mode1_reset(struct amdgpu_device *adev)
>  {
>  	u32 i;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index bff2d38f3571..a8e23f4e8113 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -980,9 +980,13 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
>  }
>  
>  /*
> - * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover
> + * amdgpu_debugfs_gpu_recover - manually trigger a gpu reset & recover,
> + * and control whether this device is allowed to auto-recover from a hang.
>   *
> - * Manually trigger a gpu reset at the next fence wait.
> + * Read triggers a gpu reset at the next fence wait.
> + *
> + * Write 0/1 to disable/enable auto GPU recovery for this device
> + * (equivalent to amdgpu.gpu_recovery=0, but scoped to this device only).
>   */
>  static int gpu_recover_get(void *data, u64 *val)
>  {
> @@ -1006,8 +1010,17 @@ static int gpu_recover_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> +static int gpu_recover_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
> +
> +	adev->gpu_recovery = !!val;
> +
> +	return 0;
> +}
> +
>  DEFINE_SHOW_ATTRIBUTE(amdgpu_debugfs_fence_info);
> -DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, NULL,
> +DEFINE_DEBUGFS_ATTRIBUTE(amdgpu_debugfs_gpu_recover_fops, gpu_recover_get, gpu_recover_set,
>  			 "%lld\n");
>  
>  static void amdgpu_debugfs_reset_work(struct work_struct *work)
> @@ -1042,7 +1055,7 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>  	if (!amdgpu_sriov_vf(adev)) {
>  
>  		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
> -		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
> +		debugfs_create_file("amdgpu_gpu_recover", 0644, root, adev,
>  				    &amdgpu_debugfs_gpu_recover_fops);

You can also use debugfs_create_bool() here and drop the extra recover fops.

Apart from that looks good to me,
Christian.

>  	}
>  #endif
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> index 0ae6e990c310..28f9048f806c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
> @@ -2299,7 +2299,7 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
>  {
>  	int r = 0;
>  
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return r;
>  
>  	if (adev->gfx.num_gfx_rings) {
> @@ -2319,7 +2319,7 @@ static int amdgpu_gfx_sysfs_reset_mask_init(struct amdgpu_device *adev)
>  
>  static void amdgpu_gfx_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  {
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return;
>  
>  	if (adev->gfx.num_gfx_rings)
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> index 4d363bcfb6a5..16391cc2b9a5 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
> @@ -111,7 +111,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	if (!amdgpu_sriov_vf(adev))
>  		amdgpu_job_core_dump(adev, job);
>  
> -	if (amdgpu_gpu_recovery &&
> +	if (amdgpu_device_should_recover_gpu(adev) &&
>  	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_SOFT_RECOVERY) &&
>  	    amdgpu_ring_soft_recovery(ring, job->vmid, s_job->s_fence->parent)) {
>  		dev_err(adev->dev, "ring %s timeout, but soft recovered\n",
> @@ -130,7 +130,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	}
>  
>  	/* attempt a per ring reset */
> -	if (amdgpu_gpu_recovery &&
> +	if (amdgpu_device_should_recover_gpu(adev) &&
>  	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_PER_QUEUE) &&
>  	    ring->funcs->reset) {
>  		dev_err(adev->dev, "Starting %s ring reset\n",
> @@ -152,7 +152,7 @@ static enum drm_gpu_sched_stat amdgpu_job_timedout(struct drm_sched_job *s_job)
>  	}
>  
>  	/* Attempt an IP block soft reset, if supported. */
> -	if (amdgpu_gpu_recovery &&
> +	if (amdgpu_device_should_recover_gpu(adev) &&
>  	    amdgpu_ring_is_reset_type_supported(ring, AMDGPU_RESET_TYPE_IP_BLOCK_SOFT_RESET)) {
>  		r = amdgpu_device_ip_soft_reset(ring, job->hw_fence);
>  		if (!r) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> index 87ecbd429f95..8da7c8e91e25 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c
> @@ -454,7 +454,7 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
>  {
>  	int r = 0;
>  
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return r;
>  
>  	if (adev->sdma.num_instances) {
> @@ -468,7 +468,7 @@ int amdgpu_sdma_sysfs_reset_mask_init(struct amdgpu_device *adev)
>  
>  void amdgpu_sdma_sysfs_reset_mask_fini(struct amdgpu_device *adev)
>  {
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return;
>  
>  	if (adev->dev->kobj.sd) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> index 1a2aa85c504e..64fb04ff2098 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
> @@ -101,7 +101,7 @@ static void amdgpu_userq_mgr_reset_work(struct work_struct *work)
>  	 * If GPU recovery feature is disabled system-wide,
>  	 * skip all reset detection logic
>  	 */
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return;
>  
>  	memset(&reset_context, 0, sizeof(reset_context));
> @@ -137,7 +137,7 @@ static void amdgpu_userq_hang_detect_work(struct work_struct *work)
>  	 * If GPU recovery feature is disabled system-wide,
>  	 * skip all reset detection logic
>  	 */
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return;
>  
>  	if (queue->vm && queue->vm->pasid) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> index c3293e5a658c..907f18b195ba 100644
> --- a/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/mxgpu_vi.c
> @@ -550,7 +550,7 @@ static int xgpu_vi_mailbox_rcv_irq(struct amdgpu_device *adev,
>  	int r;
>  
>  	/* trigger gpu-reset by hypervisor only if TDR disabled */
> -	if (!amdgpu_gpu_recovery) {
> +	if (!amdgpu_device_should_recover_gpu(adev)) {
>  		/* see what event we get */
>  		r = xgpu_vi_mailbox_rcv_msg(adev, IDH_FLR_NOTIFICATION);
>  
> diff --git a/drivers/gpu/drm/amd/amdgpu/soc15.c b/drivers/gpu/drm/amd/amdgpu/soc15.c
> index b2024d05aa5f..b35622e65981 100644
> --- a/drivers/gpu/drm/amd/amdgpu/soc15.c
> +++ b/drivers/gpu/drm/amd/amdgpu/soc15.c
> @@ -570,7 +570,7 @@ soc15_asic_reset_method(struct amdgpu_device *adev)
>  		 */
>  		if (adev->pcie_reset_ctx.in_link_reset)
>  			return AMD_RESET_METHOD_LINK;
> -		if (amdgpu_gpu_recovery == 4 || amdgpu_gpu_recovery == 5)
> +		if (adev->gpu_recovery == 4 || adev->gpu_recovery == 5)
>  			return AMD_RESET_METHOD_MODE2;
>  		else if (!(adev->flags & AMD_IS_APU))
>  			return AMD_RESET_METHOD_MODE1;
> diff --git a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> index ce67e56efa8c..18fa7c8cc210 100644
> --- a/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> +++ b/drivers/gpu/drm/amd/amdkfd/kfd_device_queue_manager.c
> @@ -336,7 +336,7 @@ static int remove_queue_mes_on_reset_option(struct device_queue_manager *dqm, st
>  
>  	/* remove_hw_queue failure indicates a queue hang. reset the queue */
>  	r = reset_queues_mes(dqm, q);
> -	if (r && amdgpu_gpu_recovery) {
> +	if (r && amdgpu_device_should_recover_gpu(adev)) {
>  		dev_err(adev->dev, "failed to remove queue from MES, doorbell=0x%x\n",
>  			q->properties.doorbell_off);
>  		dev_err(adev->dev, "MES might be in unrecoverable state, issue a GPU reset\n");
> @@ -494,7 +494,7 @@ static int reset_queues_mes(struct device_queue_manager *dqm, struct queue *q)
>  	if (WARN_ON(dqm->detect_hang_count > 0))
>  		return 0;
>  
> -	if (!amdgpu_gpu_recovery) {
> +	if (!amdgpu_device_should_recover_gpu(adev)) {
>  		r = -ENOTRECOVERABLE;
>  		goto fail;
>  	}
> @@ -2806,7 +2806,7 @@ static int reset_queues_on_hws_hang(struct device_queue_manager *dqm, bool is_sd
>  
>  		return -EPERM;
>  	}
> -	if (!amdgpu_gpu_recovery)
> +	if (!amdgpu_device_should_recover_gpu(adev))
>  		return -ENOTRECOVERABLE;
>  
>  	return is_sdma ? reset_hung_queues_sdma(dqm) : reset_hung_queues(dqm);

