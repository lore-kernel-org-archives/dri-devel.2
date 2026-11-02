Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E724460A380E
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 15:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=5DT9ck43
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 22D9910EFD9;
	Mon,  2 Nov 2026 15:21:42 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010004.outbound.protection.outlook.com
 [52.101.193.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B8F210EFDB;
 Mon,  2 Nov 2026 15:21:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W+721BV4pH8903xXyW0pf8axg4AC7udfBnW6Bur4eD6vl6YYm+LG3o4PC+fj+1DtFJ+sggTccBm4sw/Lc/MnKV+bOWQXUPlxZDSkjCFqWj0h7ebhuIq2RgAqbMcvBvHBN6/lJXzrhdlqENk/OvVuib5rVXUr0rndnOE5f82SDxWyzF0HyswRc3C2keYRXUzI5Frte1ux0L5NQqqV3k+aPZZBIquIsJnP2uCtzNXQsxPBPvqsryb9iUayY5ZUJo3uKU/uZlFRaIo2VnBbtf5zbp0u8JPKMpm2K6tflOHeSeqfKSgaXatv1J0AtFEXUGxRv0NRG4EARMgXAToq2GvQgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bz+NuWhU8KNDEhh5Q3MfihAvFvN9hl74SCMY7Woah3g=;
 b=VvCPqmH+UueNKhbtG14pQLJPQgtsdqAY5Xry47myxCuXj2Arx7tR/6+z19G0Rn15IkaM83XOczbd1+fS1WFbrPiZUFhqoteZKu54rUjZ7e301wo3Jv8nrNG0ZWY4atSxZr+LwPUZPhLYm8CaFBjsv7tKZaf4q0wrPuwtbbQSo6PZiW7bMtHhwzA9nQGX7Hz8b1Zlb4K89+2WLaVeW53YbZBGfVoEltzPsvI2JFnOENllBb4URaJ3aEYHn6mT0OLFIvZFFooSqe8jP+3GC15qqAq/xEKkZPgMNjLNdLIsnNwDJKZ03K2Uge+sqjTVBO4KaCJq2kzUFDJlHnJuxtaoNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bz+NuWhU8KNDEhh5Q3MfihAvFvN9hl74SCMY7Woah3g=;
 b=5DT9ck43dIjljqIVaMO4vZi5ZkblVnphWczWmgSmZdOqkDDByuxfy5d0wAT+smZ2Jq4vC7EhRZQAruNilRC8yvDs8y+AXShipTNTf9o9zZN9xzW3Rl5vdWkRgHZMun4LLF4zDDPOyWnQCj9ZjHQDUXzIUf5D1pHjuaJkrjw5kF0=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SJ0PR12MB6688.namprd12.prod.outlook.com (2603:10b6:a03:47d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 15:21:23 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 15:21:22 +0000
Message-ID: <3fde1d35-3ef8-4c5b-abf0-d0960da805dd@amd.com>
Date: Mon, 2 Nov 2026 16:21:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] drm/amdgpu: add gpu_recovery_enabled flag to
 amdgpu_device
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20261029152000.22001-1-pierre-eric.pelloux-prayer@amd.com>
 <20261029152000.22001-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261029152000.22001-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0221.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:ac::17) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SJ0PR12MB6688:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa67c17-7368-40ca-48ee-08df38f4f3f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|261021121427099003|261021123027099003|261022105027099003|261022075727099003|261009220027099003|261009221727099003|261009221227099003|261009223027099003|261009223327099003|261026140227099003|261026121527099003|261028144727099003|11063799006|4143699003|56012099006|260925022911599003|260925021311599003|260925021911599003|18002099003|22082099003|261102123227099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: 7VfoyAatTFKEH4AvSsRnV/KK1JypjRruz9ZNehlDPrJPfMQtavskFGCwfp+Q3sBD8DMPJvEpnZYCg0Mb5iAqGuDqChv2e/LnNpok/BwSxAeVr0royeTqsvO1BdXjA55QFqygLgWLUvCXxXb0TnCFUXMSoRB18D3eHZzWy6qYtycZB5fchgai5GtpxNTRFod8dNDkHxiiziLK6QTAoA/yEO+RMSvmlrGhLUbJ3m7pa+ggrtAjTBayBItRqtfZezofy5/OiRTa4adGPQbkWsrWcMuq6zbqZaz4ItUgTkufPSdUcF2nUdlKB0jxVsAUWIa5yNAEkN0IIZIKCYbebMmDebVo3RVERJGKUCWVcLboxdNczjuF1lRlZTaInmleWRgrENSNV19xIB+bnmOjxtuC3kQ1a9qN/PqwlvK7ipRXDahO9WeuoSfI59OL66WSn/h5bkmWugzVfpZgJhv6VSZZfSb8fEJNiXFOEAGIaupNx3nZcVilNMPQ8ZmTHMSxrY/sVcpzCE61pKdfRZiAqrpYr8RWmPyidEMlSQRVpKr94dW1jsM9fDr+5kysgik6nDVT/jabDsmPbb9snyOvVZ0CIpDp5MQGeESaR8mZqbv8yAlOgdj0xFmGzdfVyiqKvcTInJeHrflx08rdF5AfVSxqoA4OYpyqlMAIFKRC5JpjyeU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(261009220027099003)(261009221727099003)(261009221227099003)(261009223027099003)(261009223327099003)(261026140227099003)(261026121527099003)(261028144727099003)(11063799006)(4143699003)(56012099006)(260925022911599003)(260925021311599003)(260925021911599003)(18002099003)(22082099003)(261102123227099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UHpLYlBBS1REMnpPL2VYSTF4WHpFdGd4bTh5bFNZdm1mWGZQdTZqbnQrVkgx?=
 =?utf-8?B?WEU2SkhoM0EydTVXSTBGSUZiRFcxejFYK0lkNnFxd2pMQ3U2SFhxM2x1ZDZj?=
 =?utf-8?B?U25YL0dXSUdYdldGelNwemgwZkRaMXR4a1pnbUZmbVlJQmovRFExdFBZeUFy?=
 =?utf-8?B?OGJnWW1IcXdMSDMyRjEzTXcybXQ3UFNLTi91S2NUcVNlV1EyMzFaZmRvMTN2?=
 =?utf-8?B?YnhJS3VWcXVtSzVobFFRMnorcG9zbWdQUFhzY1VnZkpGUVNBNTg5Wm54RTlG?=
 =?utf-8?B?QVRWNFdxZHFnekduY0JVeU05aHl3eTMwYkR1NUlaZXhGclFwSURkMkVTSGI2?=
 =?utf-8?B?NHNpK21tbGg2cGlqeGNickVDZzJHWWdmZFBLK1NKN3JtNGdCdUxKZi8yMlB4?=
 =?utf-8?B?MVJadE5DV2xxYlhLbHp6bWJudzhwejhQdmcxczVoRTBwRStnamU5VFRMYWho?=
 =?utf-8?B?bjgrRnpPM1RONkMzZnhZejFxN1gwK3ozelFJcmcrTjJZUXdlZFRTME0wWDdt?=
 =?utf-8?B?WmFDcXVSOHhHWk8xSjZSeEs3WUp6SnRBRGtFQ1pwczVSTnVkRkcwbmFpZ05t?=
 =?utf-8?B?YmJNNWNWcVFqU3VMRHBxOUI5ekVESlNiNlZqSndRb3krZjF0N2FFT2t6Q3o1?=
 =?utf-8?B?MW91bGF6U2lqMkZMbkhFYk10VkJEak02TksyQnJrTWhPSEFOMVJEUlJPQTlu?=
 =?utf-8?B?Qi8raXV5enJXdXlscXFNa29qZWxkS0pPT2lSYnlmQTdYbkhlQXBlZnUxTmpi?=
 =?utf-8?B?QnA0RGFmQ0lXZnhwY2xtajFDSXFtQzRFS0xlM3NLYzhNbDV2c3V3YUZiZWV6?=
 =?utf-8?B?S05TUDFGZzlJTFRZSi9sMmFkeDk3Y3JjbVo2eU91OTJJQU01RmxxU3JXNzVX?=
 =?utf-8?B?SFA1OFl3UnNKOC9KeXZLUDdoanFUV1FYcmVJaWVXNEdEYjdmOTgrY0ZXYWx5?=
 =?utf-8?B?cDlWL1UrNHBWK2hWWVh6eUdENTdXTFAvZk9HWkQyYWFOQVF4bExQK1BFTEk2?=
 =?utf-8?B?Qk13V2h6dTZYRjlUeTlQb0JIWWtYTWxlMUlKSlRiQjU1S0xWOHBGTTBJN3Nx?=
 =?utf-8?B?UE1EZUdOMkxQZmFtdHJMVG5hWDVwSFhnOEw1c2llWXhhOWRlTWdEU29QUkZY?=
 =?utf-8?B?K25KQUpiODFuVDV6NTdlUmVFbVFhVzNDeDhHTEhldlQ5L3M3a2M3cmFoTzgx?=
 =?utf-8?B?V1VzNHRtNllndTFveTRSeXFnYXozTnlWOVlJYW90SlRMTWx2a3Nwd01OM1Fm?=
 =?utf-8?B?MWNDWUxHcXpyTFVMR2xOdXc4dlA0czI4T0RmMGZ0V1JJVmhwcEI4ZE5iOWFG?=
 =?utf-8?B?Yi9yQWpRUTlIcWtkZWU0NzErbE0xN2lob1dJYW9lTWVIMCtjTHBPVFQ2Snlk?=
 =?utf-8?B?bXlnYldQUDZzd2NKNll0aFoyUFQ0TC9GUXhJN1FlaGRSZlYzTGk0QXVLRzFL?=
 =?utf-8?B?RUF1aTh6eStnN0t6UXFSc2lQVUF0NkhmcVhCTE5MbmpVT2J3M0o5MkZsWUJp?=
 =?utf-8?B?ZWFBb2tSOVF1b3VRU1lTWi83MzVwa1FjYncxcXNXVnRMZVVxeEZoNGFQTUhS?=
 =?utf-8?B?MTcxRGlFbVFHU0UzWHNGZnhPT2hqY0VvUGxyMzViZnIyQU5ValhUSE5NcGwv?=
 =?utf-8?B?bnlVbm42c0F4ZmNUdW1SbkdtN2Vqa3hJRS83elNTSzJ5WFp4bXdWd2lMcjFO?=
 =?utf-8?B?KzA0c1VZV3Z0Z1hTaytqaFlweHhNR3FRUlpIeU4yMUhvZThPVE1jUnkwc3RH?=
 =?utf-8?B?RXAyM0pqc2lGRFp3VzRydklkN3BHbXB6d0l5UGdXcDVsY3JZbUI1ODlRWnRN?=
 =?utf-8?B?a0xVSFBCQXR4SGpFQnllU2NjTGg5OFh6UkhPZTRSQmJpMU1tKzBGZkV5YzIw?=
 =?utf-8?B?WWZxeitIRk5FaWVEbnh2dExTVnJ0UjFQME90N0VzSEJUcWlkbitXR3FEeGd5?=
 =?utf-8?B?cERiUUJBWnQ2eXBodm1OVE53R2xNTFV3bUtYM2NhSEdSSmpkK0xPTGM3OFRB?=
 =?utf-8?B?UnI2dFE1YzlEVVBUdk1wTVVvVUZicDUrZ2pkSE1MaEdIMDR1K1cyQXNBVkxG?=
 =?utf-8?B?WkdZcmhkRVVUSmhVMjRraEtiQXRLWkFCaU5vcWxUaEg4RzJXVlk2dGM4eDlN?=
 =?utf-8?B?OUZYMkdiVE1aaWtZQ1N4eHNKTEdFYkpma1AyWXdlWGJqckVISzJ6MWxGckpz?=
 =?utf-8?B?ZlVPRis0elpSV3JneG9aUGhHWHJodVJyWVc1bWxCU1RseDVmWUk2ZmhjYVN0?=
 =?utf-8?B?MytncVZxQlcvYWNxQ3liMjY2NTFhM1BUQnlJOXEyd1FpbWpBZjVjbXhoOEFp?=
 =?utf-8?Q?KOw3y3cPqDeLNfQ85G?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa67c17-7368-40ca-48ee-08df38f4f3f1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 15:21:22.8017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yvh7n24Q/oF9RaY08y6n4Z6dUb57+uYQQwOufaL7EhMS4ojprOmD7XCp22cq7gwo
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6688
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

On 10/29/26 16:19, Pierre-Eric Pelloux-Prayer wrote:
> Add a per-device boolean to control whether GPU recovery is attempted
> on a hang, independently of the global amdgpu.gpu_recovery module
> parameter. It defaults to true and is exposed as a write to the
> existing amdgpu_gpu_recover debugfs file, so a single device can have
> auto-recovery disabled without affecting every other GPU in the
> system.
> 
> amdgpu_device_should_recover_gpu() now takes this flag into account.
> 
> Assisted-by: LLM
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Why add a new flag? Having the recovery method as "NONE" should be handled with wedge events.

I think we really need to get away from this approach that we don't recover at and leave dma_fences unsignaled for debugging.

Regards,
Christian.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |  7 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c |  5 +++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c  | 21 +++++++++++++++++----
>  3 files changed, 29 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu.h b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> index 5a32b54b1e9b..34bbb30b6f0c 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu.h
> @@ -982,6 +982,13 @@ struct amdgpu_device {
>  
>  	struct amdgpu_uma_carveout_info uma_info;
>  
> +	/* Whether this device can attempt GPU recovery on a hang.
> +	 * Defaults to true; can be turned off per-device (e.g. via the
> +	 * amdgpu_gpu_recover debugfs file) independently of the global
> +	 * amdgpu.gpu_recovery module parameter.
> +	 */
> +	bool gpu_recovery_enabled;
> +
>  	/* KFD
>  	 * Must be last --ends in a flexible-array member.
>  	 */
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 5069042b5279..ec2514079919 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -4109,6 +4109,8 @@ int amdgpu_device_init(struct amdgpu_device *adev,
>  		}
>  	}
>  
> +	adev->gpu_recovery_enabled = true;
> +
>  fence_driver_init:
>  	/* Fence driver */
>  	r = amdgpu_fence_driver_sw_init(adev);
> @@ -4908,6 +4910,9 @@ bool amdgpu_device_should_recover_gpu(struct amdgpu_device *adev)
>  	if (amdgpu_gpu_recovery == 0)
>  		goto disabled;
>  
> +	if (!adev->gpu_recovery_enabled)
> +		goto disabled;
> +
>  	/* Skip soft reset check in fatal error mode */
>  	if (!amdgpu_ras_is_poison_mode_supported(adev))
>  		return true;
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_fence.c
> index bff2d38f3571..c54ff34572b0 100644
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
> +	adev->gpu_recovery_enabled = !!val;
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
>  	}
>  #endif

