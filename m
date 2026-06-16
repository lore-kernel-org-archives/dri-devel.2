Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E2D8CD98E1
	for <dri-devel@archiver.kernel.org>; Tue, 16 Jun 2026 12:55:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6CAD310EB9C;
	Tue, 16 Jun 2026 12:55:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BlJ3Lzxj";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013037.outbound.protection.outlook.com
 [40.93.196.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD46F10EB9C;
 Tue, 16 Jun 2026 12:54:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OIY1myxCrVrh5YILPVCixtilgjbhKnKzWlamHGIFbGnO3oKdmy5IevHaXedMcWpIs97jIASUcmGnUfsDtwQ0ndOQBSbSNZWwKhTXou+eCLhG6JjgzaqKlU3n0XZvtugO8Lbqja5y9ZvrTdfOQO913GmWhEqxkkUElli20mp1FTTXk8XLoDZaTKZsWLp+5zseeRfFliuS6rsRdmwSOtwuhv7APw/4L25WNvV8LE9bPPN9Q8D2Bah1urwX2fyCZM063++6lYr2bbyL/520bvxc2ogYuPHzxw3ZjlKBJWyQ9C8k/7az+DjA4wFX5uf3+kpL6111SrHEwvuU608p5cjA4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCn76lx56Z6SOM1u86cpJh2vCvDLdbvFESMmspVHTy0=;
 b=zOrwKtDIr2/sPEHJnwJl6+kTVnHQFR1GFqd8yTg6MuFoqRpE7QxUfMHEdhT8CiUqlw4+q0jGZ1PAAtvvKDxdsYxhRLvsh3cpmfSnED7UHwlobObwwpX8SwWD3erO202rFh5mAufyXVH8FxxoWUUDHCyk4DDCZdWpOToMoyxZ1wY5H2jQD3Rtp2x2LHqWwRNzXWwIQaCHrHyKkMYFFF6gIeqLPEP1LUTAzlXnL+gzuKw/mfzawdq5TqW5ZNrLTOzMUPifbrtzASdHzAzT6TvqjPtYp7SC4G3CjOb9cRHAveIryiDrf/B2zD6eRtSAtzk8kCZzliEbh7h/3nKpKEb/CQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lCn76lx56Z6SOM1u86cpJh2vCvDLdbvFESMmspVHTy0=;
 b=BlJ3LzxjOwlfSG3ub2QhW4DjlYYM7azpC26F2jHI1Mgd2gpRiUDl62Qe2y/VRWwF4jLNq3cgaljjeAbBynsqYOxANf8KdBp2WyhCD3mVYQtDg9IS51YIEkEx5vID5GAnEPoq8m1pvU0HO/M9MWjlGoRnwwWnIHlbc7kV9MFDtcY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by CH2PR12MB9520.namprd12.prod.outlook.com (2603:10b6:610:280::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:54:54 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0092.006; Tue, 16 Jun 2026
 12:54:54 +0000
Message-ID: <c67ae792-0978-4c54-9ed5-a1358c30daa4@amd.com>
Date: Tue, 16 Jun 2026 14:54:50 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/amdgpu: delay ttm buffer func enablement on
 xgmi
To: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
 Alex Deucher <alexander.deucher@amd.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260616125040.9977-1-pierre-eric.pelloux-prayer@amd.com>
 <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260616125040.9977-2-pierre-eric.pelloux-prayer@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR0P281CA0042.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|CH2PR12MB9520:EE_
X-MS-Office365-Filtering-Correlation-Id: 3667f5a2-c8d1-4844-58ba-08decba67647
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|56012099006|4143699003|11063799006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: M7vYxLsmYF1Oo+srosWGK/Ddm4M9PNQ7RzmzDvfB/f2OXdKNPgamf5jza88z9a3YNLcLqI8j/zGySOBtEvHK/Rqok/DZUa4YYzQ3UwEZQj9HpgixK1f0gx1qB4LXM5vQ6lsaQzVHwpczNTYAFNeSHZFXKE+9j01G9tJcBhRiPv6vLCzDnS2E1I/9Og0EHJtnQPCECgcZR/ntEK+yL1qQqTjCgnlVA/Yfg8V0M6Wtf9Ugdthbbm2Zh28JNz3DXmeiQNgpXRO5qxlOrck8sr4FhFeEvhcMo769qDu8nUEXH0rxSzKRDnwbYoUsFIlnVIXt2XekrKt18lT1CF9uYn8b1Ae4lrLAn5pG+piwglUTq4NvjiAdJEIbW/xKuv7pIPoZJuQMdYNfEqKTEEnuAyESRZ5rYPW/ONYB8lCoZQvf2w3xe4oyw86vvQdoS2CTahjui1fF3e4FLUUBDXD2CjkFg3DJCKGWj+iWh11fgndK7Mrjy+y787Bq/SfEU7xQj+qI1iLZzD3dTp0EuRwsZM01I+cWAcXNiyDwRJ/ImarwyoarHqCmjqlqwPH8wRDCJBRX5N0ZWPiQi3GTNkNzIN3DoIwhpDkasOvr8QU6yBUjm8If/vLAIJnI8fak30qzrN0+kZCdczIUhj8127UORArXC3uEqiibLGLSbIXfBDm7MPce2QF6tdUnhzdl3trwxhOt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXJoT08xZndDRkM2Y3YzTXJtS0l1VHpIVkNBTFRXdDMvbjBGYWRYMzEvcTM0?=
 =?utf-8?B?ci84dTZ6ekRNdEdKUFp3a25BUk5UUG9wYkV5Y0tIWDVBMmw2Yms2K2pmTWd5?=
 =?utf-8?B?RkF6RGVXUmhnVmNEMFN2b2JTK2R2MmtyeUc3NHk0YlZkdlF2Z0RPNnpTMk8v?=
 =?utf-8?B?UHVPcW1INmF4bnVGc2JBWlNwSGR5a0tkdHlzMGdBYVU4WWpFZHRPVmtyS3BL?=
 =?utf-8?B?WWFXN3M0d1J1MmJPNFV3T05GQVpPTFg5VzZRQmhFbW4zRk5wc2lvSjdTa0NB?=
 =?utf-8?B?cW1aVXRpUm5QYlVVR0s0VUNrTm1SOTZEMGUreU05K1dORldSTmZCN3VKaDFF?=
 =?utf-8?B?VEtaNkl5RjJSTkpYV3BOREpRQ0tCbzVHR2o2UWtWeVhKK2dLRm9aOHZYMVM2?=
 =?utf-8?B?Mlg1MDY4QUFBMlVXZFJpalYybVYyc3VjYkVQNVBrVytESlh0UlNJanM0YXVP?=
 =?utf-8?B?SlNNTWNuNUtHOGIvV3RTQURHNG9DL0dQaTdBMVhaWGM0TTBNMFdnQ0hvVTIw?=
 =?utf-8?B?OGF6U1Q4WUxySkdaRDhERjRlRGNhMjZMZzl3ekc5ZjR4THNIR24rNURjTjNm?=
 =?utf-8?B?UG45YzNjMWhSWGNxZ243OExxZ2o0MjZpOFljcEI0NXFYM0xpekVWRVFpWnE1?=
 =?utf-8?B?QXZaTGR5RmdqS3Q2Nnlpc2VmT1IzdzQ0ZktTQ1JnOTdJWEh2Q2RjR05lSW96?=
 =?utf-8?B?emxrakpOakVzL2c1U2FOeDZ0MEM3WjFIOVZJWVA3Y080dW9oTmxuQTdHVGFG?=
 =?utf-8?B?SHd3cEVaeTErekQwRk92L0ozV3dvWS9tS1Q5M2Vrd1dYb2h4S0RRMlhkbjAy?=
 =?utf-8?B?d0ZDbS9LNUR6b01YS2o4QWxZblZ3eWIwdiswblJvSEFBMGswN0xPSVBYUW5K?=
 =?utf-8?B?ejlkcmZ5UklQSlJsWFhUQ3VUUjdzUGM4b0txWUo5alA1WU9jNkRWc0lLNzQy?=
 =?utf-8?B?RmpCM3c4QnJlbjlGTFN6MGgybXhiMk02eXdsSk52b0ticFUzR0hBbFZOTVpB?=
 =?utf-8?B?em5ZNGg1bkdUTEt5K3g5aG10MHRIL1l3WG1wemllcU02LzJ1WEFUcy9NYlkx?=
 =?utf-8?B?U0F4ZVRwYjZhR2lQQUEyS1Zrall6OFZJZ2Y5TTVoY2hwaUkxRVlwQWhFUjBH?=
 =?utf-8?B?UDBIbFlRa2M5NDhtR3N1NDRvQjd3WFU5ZU56R3h3SjZxbnV0eWZZR3JqcDN2?=
 =?utf-8?B?TXVpQ2xlbkdCZWFmS0JNRy9TYmxwY3VjcUZhOTh2amlkSU1YNTJvVXZHWUhC?=
 =?utf-8?B?QUcrbkl0QzJoRlY2cXB3RzFheFRQMGlPSTNLYTFacEVGL3BOZlRoUFZ1c0h1?=
 =?utf-8?B?YUxvQStUOG1zdkoycVE1ZDh2SlhXaVFtN1BXR1NqaWZtUERIWE82TDJLNjhj?=
 =?utf-8?B?RVNVekpYQjk1WXB3S0NJNWRCalRwY2lVRWgzLzNFalVOQXpSVkM5RkVrcDNl?=
 =?utf-8?B?SDJRbVZmdWViOFNLcjRPRzh5Z1N1T1NpU1hHWjNsTG8rZHRPNFpQOWgreVFH?=
 =?utf-8?B?VldNS05BTURHYmdKVWtDVWZLUjQ0K3FZWWU2MUpwQzFnbWhWUzNnaWRrMk5t?=
 =?utf-8?B?eDJYa1RxR3l0UitSNzV2YXlPQ1hGM1VuUzFSNGFPaWJOK1NlWFdPaE1VM1FC?=
 =?utf-8?B?MjJnQUpNVmhkZE5GRWgyQnJycGJvOWtwTU5ua0UycThyUjNwejNadHRsTy9E?=
 =?utf-8?B?ajFzQjkvaU50LzJBUEpxd05yY2FGblFuWW84WWZvSWNjN0xUbjZweWxSVHpS?=
 =?utf-8?B?QXczNWdibDdvVUI2YkhzcUNiN3pHNDBTbVNMcGdqbWZyeTRLSWJ2SUJOanpR?=
 =?utf-8?B?d1NJVFlYSURhWkZxc1ZHS002U3dVTXdpaElMcEppV3pzU2MwcWpHSTFuTkNl?=
 =?utf-8?B?bG05bWoxZjk4ZmVpOCtjZm1MWmpnOHdUeGpRcHgySXpPd2RNeXl0enRzUzV0?=
 =?utf-8?B?aWs5Z1VIajlxK3RaVXE4dDF0MHhGNXprY1FNMVI0cWZQSGUvUXcrZUcxbkJn?=
 =?utf-8?B?cFNSTzVOMG9zWnhkeWtyME42R3NiL1p1WmRzeGxZeDI2NzY5SmVBdVFEM0FE?=
 =?utf-8?B?eHhXNk1oOVRFWHhndG9FaFlNU1VrdDQrODJxUURaRjQrcFZmaGE5NmNCaTJi?=
 =?utf-8?B?bXNNNUtPaXhKMnFXckpURDlGT2pvcStNQ2taRzFrL0ZITDcwY3o3OHBLUlZQ?=
 =?utf-8?B?UkljUjc2L0hyT3NCUU9pamt4azl6cnZjeFNEb1dPVERWcXlaSVk5dG1URkhO?=
 =?utf-8?B?azVGSlVaVG12ck5mZUE5SFBrN1RiUHZsOGhhUmtCNytPUWx6MnRZZUJOdm1z?=
 =?utf-8?Q?ZNfVrQjCP4GcxZ0y8J?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3667f5a2-c8d1-4844-58ba-08decba67647
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:54:54.5454 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wJk7P8WHUAatBTWODkqYW3LhAjymPJkg1Pcqq1qrjIc4oaPfjf8XLmRpaR/QiA0Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB9520
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

On 6/16/26 14:50, Pierre-Eric Pelloux-Prayer wrote:
> When amdgpu_init_minimal_xgmi is used, SDMA engines init
> is delayed so amdgpu_ttm_enable_buffer_funcs must be
> called later.
> 
> Without this, the check for num_buffer_funcs_scheds will
> fail and using ttm buffer funcs later will fail.
> 
> Fixes: 3a5da695c8d1 ("drm/amdgpu: only use working sdma schedulers for ttm")
> Signed-off-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>

Acked-by: Christian König <christian.koenig@amd.com> but Alex should probably take a look as well.

> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c | 3 ++-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c   | 2 ++
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> index 57e10afb4714..2e8954fa5c40 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_device.c
> @@ -2479,7 +2479,8 @@ static int amdgpu_device_ip_init(struct amdgpu_device *adev)
>  	if (r)
>  		goto init_failed;
>  
> -	amdgpu_ttm_enable_buffer_funcs(adev);
> +	if (amdgpu_ip_member_of_hwini(adev, AMD_IP_BLOCK_TYPE_SDMA))
> +		amdgpu_ttm_enable_buffer_funcs(adev);
>  
>  	/* Don't init kfd if whole hive need to be reset during init */
>  	if (adev->init_lvl->level != AMDGPU_INIT_LEVEL_MINIMAL_XGMI) {
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> index faac80a8a6eb..c0dca209335e 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_xgmi.c
> @@ -1663,6 +1663,8 @@ static void amdgpu_xgmi_reset_on_init_work(struct work_struct *work)
>  		if (r && r != -EHWPOISON)
>  			dev_err(tmp_adev->dev,
>  				"error during bad page data initialization");
> +
> +		amdgpu_ttm_enable_buffer_funcs(tmp_adev);
>  	}
>  }
>  

