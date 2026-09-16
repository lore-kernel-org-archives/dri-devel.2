Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB99C88E5C
	for <dri-devel@archiver.kernel.org>; Wed, 16 Sep 2026 12:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E59CA10E38D;
	Wed, 16 Sep 2026 12:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="y0zDYFMG";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011065.outbound.protection.outlook.com [40.107.208.65])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C687B10E151;
 Wed, 16 Sep 2026 12:22:32 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mWaFjbJ4I+ABgcHksfLneAQfAjjJJPf0taca05wDZSrSJcSwe2/oev+7j7rzXt3WlFG0+UTeoKX08cmfp6AeTj1ZqnUA5QmKnLkjb4CSU4tsZUrPABgddWg4EvrAwsqurc5wRZ1agvBoCMrVYcfoNTPOZoPS2eDpG2TtVBAdcqAuuG6liQNEtnKGWdS2ySJt+S6qHmCOOg8Dn4fGr8WeVpJpsgkOnufOjSKKClQPG9C+FLPcLMhtnA6cyjg2Y1GIxNc+ERFWhgPn5Vlw6ooUQ8TO0YsrZ0cOyArHVk7YUd1buJOmn3h8BpbcLGPH587EwhU/eJZHcox22D5zjmNopg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8jMAPNct1VDdv0UxLayAxOuHRKQk6WO64zDZsviwsGI=;
 b=ZbyfztRqK9MCbVNKZ9dwNfzykkPvsOsSKoP18t1NndLo67/ycQ24ErsmSuBzKR+07NmJSOI4vaYulSoUISDqM8DkA2x/H+mheTg0thUIeK79FCdNmbmCp7x73zBFrJMfP9ZAQq4DmDIcF5mWYgjKr6PFB02jiyqpttcTcJMODbtrZSq1PCVhaAYgTHzZAdIylca9u8TebZ1QTWEbX1bZOpH/dtgzPsbrwwbwc30nXdyV+njsgiWFxpOmcyyXTOlBbMwsfGzESnyDTPnW0aReSf+nNGTLA9sk2JkEF8NBZAHeEp3UEE6RVK9ygD+uMt4HB0gan5UUxghiCsSImbb0Lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8jMAPNct1VDdv0UxLayAxOuHRKQk6WO64zDZsviwsGI=;
 b=y0zDYFMG1it+vr9tTfwXgYKJPFJ7R4hz3/gezRB9dVodC4jzIy6W1Vqma/uJh9SvLXta4Rn5OMLYWBqAiok7YAVErUoBN/LQt2sSaQe6I0IU9xvRMwO7hZip6vNJciKZw5P7wts6BchuJqiZ6pp+J6mM0pDXDGAw5v6wNOjbjm0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB5613.namprd12.prod.outlook.com (2603:10b6:806:22b::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Wed, 16 Sep
 2026 12:22:28 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.008; Wed, 16 Sep 2026
 12:22:27 +0000
Message-ID: <3baa8af9-208f-4b3e-b538-6e91fa81a253@amd.com>
Date: Wed, 16 Sep 2026 14:22:22 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] drm: Consolidate the wait timeout conversion
 helpers
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>, Melissa Wen <mwen@igalia.com>,
 Iago Toral <itoral@igalia.com>, Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260915-drm-timeout-helpers-v3-0-f2ae987d861f@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB5613:EE_
X-MS-Office365-Filtering-Correlation-Id: 94aad3ec-727f-489a-38d3-08df13ed2bfd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|23010399003|376014|921020|56012099006|11063799006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: c4L5aPA/QPNdNtmD3R3NhySSfE8ZpudpOqo7lpQisalvHQbYwJfDDWMlc/LN5tR4xDVCZRsNUrupeSW99BdOUNBU/RKZYEh5Zmol9wJbdIpWM/7x121GZK+LYraNL7sinsqulzrfGGzbs1Y/4I8LvlDAk/8+TE1b2bZTBZej2bRoawqku3wV6ewmZm/vW/Q10BfYNXhX9XKSQt9u9D5NQG9KfFBxFsQxOeOBCMYOr8giZ4n4cjDo0Ixnlf2GGGIQgNbKRJlkiqQ0gux02c9ZtQoCLkLGV4EAXJEIBnQN+BFnZ4A29WwYdts/S0lm3Cq/OfC3GDqSHqtDn+KNOeIEwscREMv0AndQM6rdmC0ocqa1UfHlGGN2AutAzOMA+/2uINSCs3KeMyRv2SQHpaJCxhb7AOOXOnW3VBroYw45AS6VzVH8ry8K8rdHkY8rNlKrD6KtS3TTQUxMi12kVWxdYcu7ao8T+exWhX6QjHO0UQCflBlHY9afRvMZqQNFxaGv6WZfTr8Ay1xn6PdBqu6oXzzhNkyN9q5sV0PLHIrqBI8tBvSn2pFOPF6VsP19hLIZFEYq1gInP3p2AHeaIu9XVsOvQEzCxG6slAg24o+N+F5pLbup2Sc9z5vnyYKohuJ7uudqI9h5To8R8PX/yKWBBmNrsp0uz6H+UFYJ8vnUf4k=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(23010399003)(376014)(921020)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NEhRU2RFN1NVd25kRU51dnJGSkczL0JCcW96Vkd3enZBZkg2NElZVlBSa3dj?=
 =?utf-8?B?Q1ZHeUtMMDg1UDdWYkJwTit4Y2lKZnR1MFU4Z2c4T0hvbTUzendOWmtXZ0lS?=
 =?utf-8?B?c2U3Y2kwUGtXSDRDYlRpRkZneWpsTWxiSWFPTkY5dHhSR1FBVnd4dTNNRjZH?=
 =?utf-8?B?VitmTWFLNFI3ZGRCQXROcEhDN3pobWoveUhQOUJ4dmphVkZ2VHRycy9sckxO?=
 =?utf-8?B?cEIxMDdySWJxVTB3Sm8zdHEzVjc2SVNCSmxCZzE2U0ZoQkFJdGdqeTBvdVBL?=
 =?utf-8?B?RDZYRFl6RW9mRnRmRDdaaXVSazV0RHl3TzlLTGlmRDJneW5xM094djZEZ1dL?=
 =?utf-8?B?d0xUeWs4QldFTmN6UU14OWxsejF2d0FhaUNLSkoyVmpyQjY3NWIzZ1BvcVc0?=
 =?utf-8?B?WVhZT2IvaXpuK2J6ZFI0MWRLQnlGYXFBUThVczNxQlZwanBNSFdOdkQ5eEtR?=
 =?utf-8?B?dUFzdGZnanEvSjRRVHoyMWRTOUJXY0dsR1EvVTk4MzVnblRXUU9nTHRxTFB6?=
 =?utf-8?B?b0RlbTdGYWxBMStoTGdSUjFkYlpyR3JGUE4wdDBJekhJQXh3M20rMFR1a3V4?=
 =?utf-8?B?NGRUUCsxMng2dHN1aTMwbUgwaER2bnVMZ2VqUlBzVGQrcGFYeGJtRWx6cS92?=
 =?utf-8?B?QWN6YjFleFRUTmtBWTJpYmJCU0RvWURlVFhHbVJrVS9Oa3NSQzEzeS80T09R?=
 =?utf-8?B?aTh5UXhxR3JHN1ZpcXZLVmNpUFh6cVcwM29MdzdlbDhkbXdob0E1ODBMaTBq?=
 =?utf-8?B?L0VPU0srRXJlL0NrcFdTZkVLZTgxZlRvSHhwTHpZOTZ6ZytETVY2UTNvS21W?=
 =?utf-8?B?R2RlZDVDZWJkUVpDOFZzY1pnZ3I2T0g4alZZTTdjQU5pTmduN3h2M3hQSk5j?=
 =?utf-8?B?Z3lVeHIyY1dkZUNNVmZSMzFsUFY0WmRKY1lXcmNyUjZGeCtVQzVIY0JlWC9q?=
 =?utf-8?B?UCtjVm1rWm5KMVRXT2FWckJUUk13WGxCWUZKcTdLbnE5bUhlTXRqUHQvK1Zv?=
 =?utf-8?B?UzM5eDVrbzB2cTFVQmpjU0phb1QxcmhXUExTMkdJendYZHZjbXJDYXVEeWYy?=
 =?utf-8?B?SmhPOVI5SjdSZjQwYWRkNFpuSVZsNEFGeEhtS1pBaDEvQnYreFB0QzhkK1dZ?=
 =?utf-8?B?UXYzZSsybVFUaThKZ0N5bFEyemJZS3lXMjZSeElLciszQ0xaRkVpUExlVEda?=
 =?utf-8?B?MGZVWStqczlhdkxIWCtuNnA3MXZlZ2F2c0VBOUF4YVllb29uTUtJZFlRenRH?=
 =?utf-8?B?QjFKUCs0ZTJ1SXZVUjdmQi80V0l6Y2FMWjB2TUQzS3ljbzFRbytkK09saGkw?=
 =?utf-8?B?MUJGczBKYVQydWlnL0dWQzhkY2xzZ0g1ZHFjUk9aR2dpUVhsRytWU0k5bStk?=
 =?utf-8?B?VnEwTUVwU3JLTkxkbTZTK1hTNWNVc08zTHVxa3E3Wktnc1pyaHRtSHRhWG83?=
 =?utf-8?B?d3RONDcyUzV0SlBUakZEYkRWV1VTUkdMZDdRYWRIcGdQTVlzT2x0Mml6ZnE3?=
 =?utf-8?B?YTNuMXhIZkFYbXcwZGlEdDBmSVRWZUwza0JlWWswZFFNTXN2R0YyNVdxRkNq?=
 =?utf-8?B?YmR5L2JMWnFxSUJVOElmK3dIYS8xcWR0Ky85WnJMbnlPOUluUFVXVkViMzIw?=
 =?utf-8?B?aTFhRHcvOEJNbjhtZ0dRWGRpTE9nUEhZTVVsbVlGdm42MW1oblI1Q0pvRUdu?=
 =?utf-8?B?enEzaXNzT0Y0TlVlS2U4V0RuYXFjK1Zkd1p0V0xNMlJvendMY2M5ZkRSRlJS?=
 =?utf-8?B?UVZrRHJCejBVaEp0b3AwdHJyVTBPbEZBYTh2WkdxYVh6dlA4a3BGY3BlMDB0?=
 =?utf-8?B?Z1Y2dUUzendsZ0lMQ1JlbnlBK1JOVVljK2VGby8vcXgxSEJjR3ZTRDBia3dW?=
 =?utf-8?B?bkpJM2JCdzlXaCt3K2FMdEtyV0NXMytKTXA0QVhwNDBHTEZwTnU5QXhDMFBy?=
 =?utf-8?B?R1B3WmVlQlJycUhMSHA4aVExdDY1SkRvcE5KSGlVaUdjdVlaODVwdDc3T2Rm?=
 =?utf-8?B?azd1a1NuYkltNmpDRkdlTXhhV3ArS1JpRmx4cHFaVmN3NlZhTFlnWkRpZkpM?=
 =?utf-8?B?K1R5eU1kQzg5VGhOdUFLQk1JTFlWUnpaTU82d040VzdOdUhvVjVFUW96WExE?=
 =?utf-8?B?M29GbVI5QVI0bVplVVJld3dYeUJaT2UvYjA2WnBHRS9FVzJxd2NwQ0RTSWxh?=
 =?utf-8?B?aGM5UmFOSnFJMnBaLzhzYU50b2dHcmhjcmNuOGJ5bkc0ZTlTZ0FhS3FFZm41?=
 =?utf-8?B?M2xHOUZNNFZXekVSTUx2d2ttMTZ4WGRiZ0t2TE04azNBTXRxSmZDN09qa2E0?=
 =?utf-8?Q?IV1RkchZUpItkG7frc?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94aad3ec-727f-489a-38d3-08df13ed2bfd
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2026 12:22:27.7912 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et7Aj9yoxntGTrZbjWYg6LNzFYz0DQtigbtwiHpcRTug0K52vNkNIMch+uPaaHrs
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5613
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

On 9/15/26 21:42, Maíra Canal wrote:
> DRM wait ioctls express their timeout in one of two ways: as an absolute
> deadline in ns, or as a duration in ns. The core has a helper for the first
> form, drm_timeout_abs_to_jiffies(), which panfrost, lima, tegra, xe and
> some accel drivers use. However, there is no equivalent for the second
> form, so the drivers that take a duration convert it themselves.
> 
> For example, i915 has a local helper to handle the relative timeout case,
> and v3d carries a copy of it. This series moves that conversion into a DRM
> helper called drm_timeout_rel_to_jiffies(), next to the absolute variant,
> and converts the drivers that were open-coding either form.
> 
> This series becomes particularly relevant as the new helper will be used
> in the next version of the series "drm/vc4: Switch to DRM GPU scheduler"
> [1]. With this series, we avoid another duplication of the
> nsecs_to_jiffies_timeout() function (and thanks Tvrtko for the suggestion).
> 
> PATCH 1 moves drm_timeout_abs_to_jiffies() out of drm_syncobj.c and into a
> file of its own, so that both helpers live together. PATCH 2 adds a helper
> for the relative variant. Patches 3 to 6 convert amdgpu, v3d, i915 and vc4.
> Finally, PATCH 7 renames the drm_utils.h header to drm_panel_quirks.h to
> better express its meaning.
> 
> Let me know your thoughts about it.

Feel free to add Reviewed-by: Christian König <christian.koenig@amd.com> to patches #1-#3 and Acked-by: Christian König <christian.koenig@amd.com> to the whole set and merge the amdgpu patch through drm-misc-next.

Regards,
Christian.

> 
> [1] https://lore.kernel.org/dri-devel/20260712-vc4-drm-scheduler-v3-0-ed6dc4defa53@igalia.com/T/
> 
> Best regards,
> - Maíra
> 
> ---
> v1 -> v2: https://lore.kernel.org/r/20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com
> 
> - [2/6] Add comment discouraging the use of relative timeouts in uAPIs
>         (Christian König)
> - [3/6] Make it more explicit that any timeout that doesn't fit in a s64
>         is mapped into an infinite wait (Christian König)
> 
> v2 -> v3: https://lore.kernel.org/r/20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com
> 
> - [1/7] Move the function definitions to a new header file: drm_timeout.h
>         (Thomas Zimmermann)
> - [1/7] Add Tvrtko's R-b (Tvrtko Ursulin)
> - [1/7, 2/7] Apply adjustments to the function's kerneldoc (Thomas Zimmermann)
> - [2/7] Fixed an inadequate overflow check in drm_timeout_rel_to_jiffies(),
>         which allowed `nsecs_to_jiffies64` to wrap around on 64-bit systems.
> 	(Tvrtko Ursulin, Sashiko)
> - [7/7] Rename drm_utils.h to drm_panel_quirks.h (Thomas Zimmermann)
> 
> ---
> Maíra Canal (7):
>       drm: Move drm_timeout_abs_to_jiffies() to drm_timeout.c
>       drm: Add drm_timeout_rel_to_jiffies()
>       drm/amdgpu: Use drm_timeout_abs_to_jiffies()
>       drm/v3d: Use drm_timeout_rel_to_jiffies()
>       drm/i915: Use drm_timeout_rel_to_jiffies()
>       drm/vc4: Use drm_timeout_rel_to_jiffies()
>       drm: Rename drm_utils.h to drm_panel_quirks.h
> 
>  drivers/accel/ethosu/ethosu_drv.c                  |  2 +-
>  drivers/accel/ivpu/ivpu_gem.c                      |  2 +-
>  drivers/accel/rocket/rocket_gem.c                  |  2 +-
>  drivers/gpu/drm/Makefile                           |  1 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c            | 20 +----
>  drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  1 -
>  .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  2 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |  1 -
>  drivers/gpu/drm/drm_connector.c                    |  2 +-
>  drivers/gpu/drm/drm_panel_backlight_quirks.c       |  2 +-
>  drivers/gpu/drm/drm_panel_orientation_quirks.c     |  2 +-
>  drivers/gpu/drm/drm_syncobj.c                      | 35 +-------
>  drivers/gpu/drm/drm_timeout.c                      | 95 ++++++++++++++++++++++
>  drivers/gpu/drm/i915/gem/i915_gem_wait.c           | 17 +---
>  drivers/gpu/drm/lima/lima_gem.c                    |  2 +-
>  drivers/gpu/drm/panfrost/panfrost_drv.c            |  2 +-
>  drivers/gpu/drm/panthor/panthor_drv.c              |  1 -
>  drivers/gpu/drm/tegra/uapi.c                       |  2 +-
>  drivers/gpu/drm/v3d/v3d_bo.c                       |  3 +-
>  drivers/gpu/drm/v3d/v3d_drv.h                      | 10 ---
>  drivers/gpu/drm/vc4/vc4_gem.c                      |  3 +-
>  drivers/gpu/drm/xe/xe_wait_user_fence.c            |  2 +-
>  drivers/video/fbdev/efifb.c                        |  2 +-
>  include/drm/{drm_utils.h => drm_panel_quirks.h}    | 10 +--
>  include/drm/drm_timeout.h                          | 17 ++++
>  25 files changed, 140 insertions(+), 98 deletions(-)
> ---
> base-commit: 5363e01e4ff03a204cab85292b89cf90c2d1b101
> change-id: 20260809-drm-timeout-helpers-55473e4879d1
> 

