Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9155AC5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C423110F343;
	Fri, 14 Aug 2026 07:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="iboJklYZ";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012053.outbound.protection.outlook.com
 [40.107.200.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0652A10E0BB;
 Fri, 14 Aug 2026 07:48:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BE8haosUTwu7De5hqAdj03QSnQIhn7lLLc6IgoThvTt7KqiMWoqbptcug3p2BeInLhsE2nDnzS3yr9GzrdSujbaOdCTQxAE0caV8ecNfPeMijS4Kn3y8P7qGgBfC6nmxFiz5qo0AxKJLEdwIz3s286CPgRjWXvipab1jeCv5FenDJjNqA5h1fqfgjK2EAwJWX5vFv3ZUaI1B0rhQgSPxtGV4XkUOaH3sw/XTowxZMk2z1oHm6jOX2Dvr9xETuKDjjESJBwKfEg93zAEnZvs1AeD58M8w5uiOv4lPgLVTwczjG7VM+ZvCP4r3Ed1B6EoKcMMYQB2gzdNmBmi9XkgXsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MEfB4IG0Oti7xT9xwHJTzztYjJEGsExT7Z6bo6+Po44=;
 b=V9WqoEDi63lWrBOkYnCmwqdoNKRECDa+TfSndSPVQJuR2Js0E/FqqWZiiBk7TPVTEqxbirxJNZ1aO5Khw/Wu4OzHdHN9r9nI0nF9Y/FUPOr9ne8N8Pi7UBXyWX8RHbiqd8jmFqeocd/xqBr8bMfJDmKRfhBR32CPgx9kyfK7M28Y6Ry59WHdWayFD0zOflbx7q2kd2/SDZwxxb800bIMBRCLSa7fQgBuNbBlDwLkrmHHDVBZvfMMTMsOnu0Akp11boSt5rRQ5MWABy7Np1w30OdfTtXBQxQRQjGlb+CHMI6temwIF44wRZnLgmi+3T7+JXSPBD5dxvqsAK2RPQd4pQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MEfB4IG0Oti7xT9xwHJTzztYjJEGsExT7Z6bo6+Po44=;
 b=iboJklYZY1QTOZHwC5m7RJcbwMCp7jbH/Mlt72/tQ7OHwFRWMF94xB4NFHEPrMREzUED0zRCrrU279oZ+HF2gJ1zjv6CNOweX3n1NHZ4p/K61Tu2GqYEDDn1GDvrGLuX9+Mt9LUpAjlkhIoT5yYtWyLH/nHLGvh+min2gUA2G/w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB7803.namprd12.prod.outlook.com (2603:10b6:8:144::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.14; Fri, 14 Aug
 2026 07:47:57 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Fri, 14 Aug 2026
 07:47:50 +0000
Message-ID: <00e839d3-2fb7-4e4e-b3db-083e86c842a9@amd.com>
Date: Fri, 14 Aug 2026 09:47:46 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] drm/amdgpu: add gpu_recovery_allowed flag to
 amdgpu_device
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260813170705.15745-1-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0072.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB7803:EE_
X-MS-Office365-Filtering-Correlation-Id: 02dd34ba-462f-48cb-778e-08def9d8572e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Ux9z6X0Amym3UiUzA38S6ir+WRfqPepYc5K0Qe1JWwDAMeCKUduvhyB4Yq1zg59MIN6iERooHrkEVcwFdnnsVC3eNTXr3OPcu4ADuC4IHTUDFHrlxSaLmDXKmbP1beAPtpOjoEaBBeupqkmZHf9F8KfZXmcAFMldfGeJeFX4DgDAquQoRWeTWyuQwYv++8oEqBO1WWpqC0sJckUk061GnsX48g8MHb8T5KOZeIOwIRG/M3buOWPN3mpk0NQYMJZsj246qhrrN7a/d2/G/GQS6rJ5aaBoustFAQv8VjkcPb2yCGoiMirC+mdGVHlkLfTTTHWM0nETmAl5/A8eCOYSkOCATjLCjhwLSDJ8gP9w8qpeqBjMiv51m8y0jCj4de0zhDQtcf7PqVg/f283cX23ItbLLQXLvRW2D8rQ/jHqYKwgc4kqP4gjK1hEcY1TAlyiJRJMeExRnerR8K55S9xuGhMl4JSTSKO9N3L9pMUAElLJVTecusm4HkULB9VPKgcv+60BdT0L2rwlJz8Kl3VS6qE3hH8JoWpjhijlXVmLIlM613o2nCtSh59Or7X/wvpTbGT5I9durjlKGHgVUAm83IfDPmxmTWcPLY5oldQc/vx7V/S/nwRBwBlumFvu2n6LigcApUIptD2GAtTgWiwOQDYJzoK6NM1HxvzcR8SXLBY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UmNudThWWkR0d25JUWNRRUltZWd3VHFGa1g5YjJtZmhsMm1FM3hPUmpMaVpZ?=
 =?utf-8?B?T05OVWMyWU94RFUzK1JEeTRiNlpOMWVRSGJnSnVtTEN6QXJ3cHlQdk54NENl?=
 =?utf-8?B?djIxM1JzZE9yK2RJWU94clFYWjl3S3RVTEFYZk80TzR5Z3phV3FLQitSc2Qz?=
 =?utf-8?B?WHMwYWttWHVEQ2J1NHRrMEJIWEhGdzJlWldhK044MlJXWWc5Q0pJaEVwR2pz?=
 =?utf-8?B?ZDByeTdqTDArc200L0Q3em43VThmL1FOMkN1bURsSGg3TEJRV2FzeTY2eFlD?=
 =?utf-8?B?WVF5WnkzZzlrQTZEK3ZLclJuNlFDb0RyT251YlpxSjhLS3JUbFBoSnBqNURN?=
 =?utf-8?B?SVZsOC9VbHpGbEh6SmVEamxqMkNMMGczOGZPbjNjRVBIbCtRVDMxTE9OOVVv?=
 =?utf-8?B?ZUkrTEtjc1EzckRJdDRzK2FVVVdJaGp2VDNKcGNLdzVxd2ZndFArdytvRVhO?=
 =?utf-8?B?RFYwM2Q4c3pHcDR0UXhrMkdNbWR0Tm1pQkpITERwakIxNmNtSDlaQ2pmeUdo?=
 =?utf-8?B?YWZETVMwTzlpZmRLUmYxNUNIMVdqRlhibzZNVzNZTEdSVU9GQ3NOYlFIMkp5?=
 =?utf-8?B?b2tmOW1UMFIvNmx4NEllVnFIUnErN2V6ZlRwWE5wZ1BzYWJNM3IzRWwwOExi?=
 =?utf-8?B?RyswOXV0Q1ZUUlJ0YWxaMjlHdG92SnhLdk9MbHJveDVCclQrVWhSbFU0NDNM?=
 =?utf-8?B?Rkt5ZW1vZ1NpNkFTZDBEV25DNjIrUGVhVGM1N0s5YjhkLy9HL2JGM01abnNp?=
 =?utf-8?B?ckp0a3dUK3pOSTJGRmlJTFVZc2RGOFpQM1R3OGk0bTkyVWFrRzJ6L1diRTVl?=
 =?utf-8?B?RUdLaDJkVWljbWVHRklyNWFVeXVUZUtGZURRWGFPWnZaeTZVRy9tRFNROWdV?=
 =?utf-8?B?NlQ2TWtTdnBnejI3WTNKSHJaejdGN2VQT3FwU0NIdlF0UTd0bkwrdzY0Vm9x?=
 =?utf-8?B?cHh0clZsWEpsOWN1T0hibktLMzJuTElGYllBa0NsUW1iSWNFd1c0NjdPRUFS?=
 =?utf-8?B?LzhSY1lWUFFjRFI3a3NzOENwQUxETnRzY2R3c2d0cXRTSjlxUG9JNFJzbnFW?=
 =?utf-8?B?N3RtUmZvVzZKbjVRUmo0OEpWQlF1ZDFOMGpCR3hadnJNKzk3YUhwL2xqWXFS?=
 =?utf-8?B?Q1hTTWduVFh6dEE1Nk9TMS9QUVRZUzd5QWtsNk9MajhtSzZ4dlpQTEpUL3pE?=
 =?utf-8?B?SG5yY3d1V21rVUJJZExDR0xKS010Ni9Ic0J2dGZwNDRJYzQwS1RXQkg2c25H?=
 =?utf-8?B?YktNTGx6NXRIZUU3dnhZNGIxZm9uUXNkVzFlV0NjV1lLVlRyVG9ERlc3SjlI?=
 =?utf-8?B?eTVHS1dCcHR1RmVGUGQvZXRNcUxoYldOQ2JCMDYvSjVFYUNpMzA1Q0Q5RHZy?=
 =?utf-8?B?VXVPMWtnak5tR1VEVjZJRkdhbUxFMFY5VVUwOFhKZFpwOUJnUUVQQi9uMWds?=
 =?utf-8?B?S2hsSkhXR25va3NuL1VvM0NFOU9NdnFVMUQ1bldMNnIrRW1Fd1dFTDJ3K0lQ?=
 =?utf-8?B?NkJZZkozTHJpb0dBeWtrcitqcU9ZNHRzK3lnMVNxaEMvZHZ5QWFrMW9mZlNM?=
 =?utf-8?B?aVpBbkwrR01XRDZucndiVm9CMlkxTmlIYzhjbmdQb2RyNlh0dmRyNG5abW9V?=
 =?utf-8?B?NzE3YVczOUI3dldZZjhweTQ2SDYvaFFLWU9BMDFnSFdTaUxZaVgrYU1VbWl0?=
 =?utf-8?B?TmpNUjNlMHRXUEpmWW5QNVphT3VlMnYwWUlEQm9qZ2liSVpuN21HVll5RzJq?=
 =?utf-8?B?RmZxcHA4ekhWWkZBZkprcEZJempsTUZxVkt4WTlTOHdqWGtrUW11aVRDUnNQ?=
 =?utf-8?B?bjV3VllWRWFRUTIvQzZFM0RPNnJCbGdGa0JMVWdYRjFLOHhVc3BUM3RMTGpE?=
 =?utf-8?B?OXFhNWxIWGRtU1hGazZXenNWa3krZ0Z3MW1DNXVqRlZ3RXhtSGxZSXl1a1l1?=
 =?utf-8?B?UGJnNjBtcGRxT2pFYVN5UkJpZ2tubHhabVhKWUxTUzJiWXVsbXdZMmlwaUlS?=
 =?utf-8?B?ZEpBRm1HVTZXWUVad3VvQ2N4azd2UUwwdWQ3cXFUSVlMY1VkRXZUMDdVem5D?=
 =?utf-8?B?RldwbTFlbDdqa2s2aHUyakt5UHJ4WjBCeVUzcmZJMHNvNTkvZGxHM3E5NDdz?=
 =?utf-8?B?L1VLV1J3cWlyNkFBN2xuVTJmZHBESi9RelF1RGovcVg4bWROUjZMRTluMko5?=
 =?utf-8?B?WW4rSzNMeUI2UG4yNUxhcGxWd0VCTGE5M2ExYVo3ZEhjUHRyTlV6U1hNMkdL?=
 =?utf-8?B?cWNrR0ZndjZWVm1MeFlDd092RThYM0FkeDNrSFJmRE1ZRnNHTkNKV3QyRjZ5?=
 =?utf-8?Q?NA/N768/T/Qf446Msd?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02dd34ba-462f-48cb-778e-08def9d8572e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 07:47:50.6525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bbzGehPHRFu2ZcPBv/lQa5yuJisPHckTaN/Zw4iKhrNj34bRq5VMZFlGQ9tToZ2i
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



On 8/13/26 19:06, Pierre-Eric Pelloux-Prayer wrote:
> Add a per-device boolean to control whether GPU recovery is attempted
> on a hang, independently of the global amdgpu.gpu_recovery module
> parameter. It defaults to true and is exposed as a write to the
> existing amdgpu_gpu_recover debugfs file, so a single device can have
> auto-recovery disabled without affecting every other GPU in the
> system.
> 
> amdgpu_device_should_recover_gpu() now takes this flag into account.
> 
> Assisted-by: Claude:Sonnet 5
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 21 +++++++++++++++++----
>  3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 7974f9b7944f..21b33dc34edf 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -957,6 +957,13 @@ struct amdgpu_device {
>  
>  	struct amdgpu_uma_carveout_info uma_info;
>  
> +	/* Whether this device is allowed to attempt GPU recovery on a hang.
> +	 * Defaults to true; can be turned off per-device (e.g. via the
> +	 * amdgpu_gpu_recover debugfs file) independently of the global
> +	 * amdgpu.gpu_recovery module parameter.
> +	 */
> +	bool gpu_recovery_allowed;

The funcationality sounds sane to me, but the naming is just horrible.

We should probably use something like gpu_recovery_enabled instead.

Regards,
Christian.

> +
>  	/* KFD
>  	 * Must be last --ends in a flexible-array member.
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 964efec0d335..5578d5f64937 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4034,6 +4034,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  	}
>  
> +	adev->gpu_recovery_allowed = true;
> +
>  fence_driver_init:
>  	/* Fence driver */
>  	r = amdgpu_fence_driver_sw_init(adev);
> @@ -4834,6 +4836,9 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>  	if (amdgpu_gpu_recovery == 0)
>  		goto disabled;
>  
> +	if (!adev->gpu_recovery_allowed)
> +		goto disabled;
> +
>  	/* Skip soft reset check in fatal error mode */
>  	if (!amdgpu_ras_is_poison_mode_supported(adev))
>  		return true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index 3043ad041bb4..707e69d8bb11 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> @@ -975,9 +975,13 @@ static int amdgpu_debugfs_fence_info_show(struct seq_file *m, void *unused)
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
> @@ -1001,8 +1005,17 @@ static int gpu_recover_get(void *data, u64 *val)
>  	return 0;
>  }
>  
> +static int gpu_recover_set(void *data, u64 val)
> +{
> +	struct amdgpu_device *adev = (struct amdgpu_device *)data;
> +
> +	adev->gpu_recovery_allowed = !!val;
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
> @@ -1037,7 +1050,7 @@ void amdgpu_debugfs_fence_init(struct amdgpu_device *adev)
>  	if (!amdgpu_sriov_vf(adev)) {
>  
>  		INIT_WORK(&adev->reset_work, amdgpu_debugfs_reset_work);
> -		debugfs_create_file("amdgpu_gpu_recover", 0444, root, adev,
> +		debugfs_create_file("amdgpu_gpu_recover", 0644, root, adev,
>  				    &amdgpu_debugfs_gpu_recover_fops);
>  	}
>  #endif

