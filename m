Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E417C5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:26:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A4F7310E863;
	Mon, 10 Aug 2026 13:26:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="sIPPiHRG";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012031.outbound.protection.outlook.com [52.101.48.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C4C0B10E866;
 Mon, 10 Aug 2026 13:26:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qr8AhMZDhVDTJsnoE503vGYBQ7EkDiHtLoLNorgyFYEFoH+iNLK3i6kzs9/z4qN3S6C+K9RzKCWLL55ezhse5ohjFLE4wAJ8S9/NjcOC78Oif5yhUZmT7bXm8idacRO5C/n1qDV0EUrxLZ7T42o2WqE783KPAVgKv+KF4ZQ783JdhRtQpaQs2flNLR0cTCr2rkPlnpVZmw0kt1sUb4CHxp0Y/C5e0Cxdcy4AXLTcdaCmGHxgwSBq1HOeb3aH853AXGc53a2Q749HDWv9+rPwSv8cugJ3rpBe0ynNDDQpAiFqhDsKYeLnje8I3EPmCiHhoDoUiHJgbgdzHUtL0rmfkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aM6tz8UVWEntY4tr7+Ws8EZBzwLCEYFT/DEuTsUCAPY=;
 b=uk3KVTZ6DtwGf74fUpp/dmKXmli1MC3QRF/pgxTm4nMw2bkDkCrQ0/HYLcLalPjiL/5TZy9bGqG2yv8g6lT6fGRgajk0tUTLJBBQvzk5e57XjDTHEhMA4F7sut0W6gZE0EeLcxbC79N4/MIdNLfI7zS4IdVx/WCvixB77ADXBhdk1cMHF3pPEJ2LY4N6mPU45vsbDWAPibURXMzoDfRlN7vHhS/OedPq6nVnqElR/PyA4vuRQJ4Xw4PE2DOi0DmNidfeK/WNMNiQPha5cI0vJP8N6yFhtyJTVmJN7oN+zn6VI9wzVZzwxNTYtO9DcPiUGz2qVPeYCz4gt6RUWTyibw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aM6tz8UVWEntY4tr7+Ws8EZBzwLCEYFT/DEuTsUCAPY=;
 b=sIPPiHRGC60bCbVn0uCEdanYW++mgitfllmBHfAN6ttPCs+okzcIrfIjZsVmMgoRXiAWkomf0BpvL7oL+UdvAJLrSVNHPEayEOjvD239GlvSNVZcChW2uo9SfJfv2AfxqKkHTdau7+XBREjoVh8rubgopuXeUGQL2an+BCn9JMc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS2PR12MB9568.namprd12.prod.outlook.com (2603:10b6:8:27c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:26:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:26:38 +0000
Message-ID: <1a95107e-3d56-4776-95d9-af2ee8a10cb3@amd.com>
Date: Mon, 10 Aug 2026 15:26:28 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] drm: Add drm_timeout_rel_to_jiffies()
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
References: <20260809-drm-timeout-helpers-v1-0-2de67405a145@igalia.com>
 <20260809-drm-timeout-helpers-v1-2-2de67405a145@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260809-drm-timeout-helpers-v1-2-2de67405a145@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:208:91::37) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS2PR12MB9568:EE_
X-MS-Office365-Filtering-Correlation-Id: 0600247d-4e0e-45c2-baed-08def6e301fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|23010399003|18002099003|22082099003|921020|10067099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: Impq89wr6NnFhnqTUdhx2Hj+bliklCJf0HWHaKkF/mA7O6XoNomk7L2CnHgjRRUOMHZEDuRvd2YQFb4ZLeaf1eJlS90ekBaYMkGZYO6kJkqIQ0I/qBt3cY2AGGYUkEdz/vvrHuPqO0HDJ7FgDB66OyDs6MeIYRrM9oD96Pwo/A9kJHIN4MObWgDWH7+872OgUkgoF4WZ7tp8DeEfqwEFnIYUOLK1oLWaiVmvmQZpITf9m73VPWNCbjvM8EINoLQJ7G0NdbYrWKeJyfgs6jcP7zuep8cb66We4eYiepCHIqnzzd0qDCf1Ioml0SqIiCYFz1o3eRT8jlch1uMwbyjJgOXwyht1IYNC51KlH5qHTwhMp62zophs07DYEsCgEGZDB7cFPARFiJi44aowJms7MGBBJ1gCAs1eW4TiIM92818/SovAjG1R6y4CUV8piftdlE6HdZiASEnZrwVWmGsUpmcE0QU7nf/OALjjugtb1eNiasLyPXx/9PIZGeMGxoQg95NIYj6hB3/eGf7ziOEYpr/OL+zdxw5LW2tjH3yCGVDWCw2QnvtUD0/SPH0bgsblfnsyJJdmhNmtya6ytiI83tN60w5LkCD5NySesaPYyVMQxrHpReed2cJotJqGx/nt/SVwLBzxu2XaIHWE9sjkYlZ8zfiEcJfm89QZdzX+ZzcdxykPTiWHnwf2s13aQBKlN3PaSwXsZbm1Y7XIa2xBJQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmpGTDdYdFdJNU5WWTdEYnVaRjIvcXRWaThPT3cxeTdsK3MvNGdmVkRJZE9n?=
 =?utf-8?B?WUJmSG9DZ2ZNRUFaODBFQit0L0d3QkJPbEM1YlpFYUV2WXVRZ0RFaVF3a2Nx?=
 =?utf-8?B?R3Q4ZUxkTFNJSldmRkNtNFBpeHJHTVRsejU0Tkd1SjJGM0xUajNPZlV5TER1?=
 =?utf-8?B?RytBQlhLOXJVdjI5OWNJRVpjenlUWFZrZk9hVTFZa3diWE1yMFhCbkZRZUVi?=
 =?utf-8?B?emdacUtCTXMyUzBzTXpqZHNyOGxuVDVyc2FJVlJ4ZExzaEo1T2lETjVMUnVB?=
 =?utf-8?B?aVowTks1QXRYR01NMVJVOG8ybXUrUTRoRG1wcFpCOEZ2YjRRQ3BpOVEwZy9i?=
 =?utf-8?B?dFhHcmZPMDdva2J5VEdQRFhCb2c3RXVqL09KMlJ2TnFYQ2VHZjRidXI3eUIv?=
 =?utf-8?B?S0RqL04vSnlwNFBNQkc4T2lFTW1JSFA3dmt5bktSZ0lGK2tjbTExWEtheDlB?=
 =?utf-8?B?UWd4dnNrTkl2NnYrWllJbnNHK3hkSlYyZmFkVmdWZjdQS215cDdVbTJ3RE9n?=
 =?utf-8?B?cmYyb2FjcUw3N1lZa1pmaHJ6ZG9obUhYOEFibnF3Rmx1eUIwN05mdkdPVWM4?=
 =?utf-8?B?QXB2dHo4bERNMHA2Z0ZsWHlZcTlVMTlsRkR5OTF4UlYzUUE3bUI0QW42S2xT?=
 =?utf-8?B?WHhwYUlKMHRrVUdYWG92YjBieHc5amNGeXh0RFBtMmx3U1BabGlXd2ExNldw?=
 =?utf-8?B?K1YvOG4vYXVqRnFSV0tDM3Ixc21yaHNZdlErRmRQaU1kNmloR2tjcUJtZlpZ?=
 =?utf-8?B?TkF3VVhRdGlRaDRkQnN2QU55aXdMMGhqMDV0Rm5oS0RtZVJGb1hLaHhaTjJl?=
 =?utf-8?B?cjBTWnk3REVVWWJtN05hY1dmMWZzUHNYd3FhUlNQd215MEFHWFFuc2dLNFJR?=
 =?utf-8?B?eXNmVmVtbU1Kbk55ak5UN3lUVFcrZTAxY1FPQko0TTFkQk1MQmNoanR6Nnd6?=
 =?utf-8?B?RkFBT3Yxb2NGcmk1WVp3WkZoaUFESFJ0dFliTEdXQ0FpNFl6VU9FQlJHOWhR?=
 =?utf-8?B?NmFocWZNZGJBMkZnWjVRQWtEVll1d3VLSEVGb3lQMGUveitNUVBzays2dmlR?=
 =?utf-8?B?dUlBbjcwbEZucm1qOXVDYXJpVkd0Qit0UWRJQ3NHODZjYjJHeG1DSlJOenF5?=
 =?utf-8?B?eHZPWkpMN0VMMVhrMVBZQVJSKzVWRnZMVlRXQ01BNjdxNHVWZWoxdFVhN1ln?=
 =?utf-8?B?OUZwSk1iUlkwNkFqMXVZMjNFd0RwcWtEdGxTQWFWMTEwb3VXOG8rWUpaeEo1?=
 =?utf-8?B?c2lVdGtuMGhmYmxmM2FycVZvYi9JV01OUklXdHMyNWxGUStMS2FoZVYzU3pD?=
 =?utf-8?B?cDBXNzRXdjkrWTBPbDM2YjlyL2JIQnNjUVhVSzlYNm1Ka2w3ZC90bWpuU0JY?=
 =?utf-8?B?REFuWEdvcFkrdURtYmtpYmVrN0RSTjd0WjFkeGZMUmlualMxY25VckdBRk9T?=
 =?utf-8?B?Rm9FeW1CSUlEVFNYSDRSQjJZeFpmL0VzcTJUZXFFbE9MczQ5Z3U1YUEzWjZY?=
 =?utf-8?B?bmxlbWZvWDhQS2lJNmYxU2hSaG16RTRDTGtFUHYwWDRSTHRsN2NlVXUwenJF?=
 =?utf-8?B?WndlRFc4MEk4Rm1YSTYzL3BOZVVyY3lJN0VPTW4wb3BadFNyZ0JjejFRb1p3?=
 =?utf-8?B?NksxL25rRFB0bmN4aEw1TFZFR2dWa2dhamhKenlFTUNsVEt6SUM0d08xMWMx?=
 =?utf-8?B?a1pSYll2b0V4aFRaUmxwemRUbnhkZWlrUm4wN0NsZFBsMUdJMTlhWGFkSTBx?=
 =?utf-8?B?ZlVyUGM1cEtwbjZDVk05TDdYQ3BYNUtWSGJ6cU1hWEprNkxnMFhuWDVHTkR1?=
 =?utf-8?B?QmE3WVdBZjlDSVN3azZQVjNXcVNPOWQvYlJHUitpUGVMQTkzaVRhOGtYWXRZ?=
 =?utf-8?B?NHNYcGRsL1BHYlJyUElFbUtKclorQW9HWDF3T3ptdTdWNGJjSnhPTnYrbnM3?=
 =?utf-8?B?S1R2K3d1QktwU2IrMlphYW5RWDJvbi8wWWFFMk12UmUxd2IwL2ViRW8vQlIv?=
 =?utf-8?B?eHhHWnJwelV0QjltZGw2NDBHaTZTV0NNcFF5ZU50S2IzYWRZNmJaRGs0NkV0?=
 =?utf-8?B?OEl2Q1hjOW1aOWVGVU5CcGl2RkJlejdGUmpTZkNWaTBPaGNBVUE2eEEzRWll?=
 =?utf-8?B?cmNxejJ4ZVRYOEgxNWxLNGFxZ3p6Zk92MzN1TjJlTDlmUEJhNDlFKzJnQUJk?=
 =?utf-8?B?ZThHTjAwMGtYeVI2eVdsVms3RGN5SmV1T2lyKzdzWlM5TnNhRFFVVkJFUVBC?=
 =?utf-8?B?NGhyakJoRkpiWTkzQzIvTlM2cU5lQTZldW9iL0RzeDRyc3RndXljbjhBWXQr?=
 =?utf-8?Q?KqGF9AT65wXvr82W2y?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0600247d-4e0e-45c2-baed-08def6e301fe
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:26:38.7077 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DW4+YPjcSN5qYMcL35mE9KS1ua/GqJd5bzTlE2OorR28u9yRkZ5X/V5j3sJj9m5Q
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9568
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

On 8/9/26 21:23, Maíra Canal wrote:
> drm_timeout_abs_to_jiffies() covers the drivers whose wait UAPI takes an
> absolute deadline, but there is no equivalent for the drivers that
> express a wait as a duration. Drivers such as i915 and v3d convert the
> value themselves.
> 
> Converting a nanosecond duration to jiffies needs some care.
> nsecs_to_jiffies() returns unsigned long, so on 32-bit a large
> userspace-supplied timeout overflows its range and is silently truncated.
> 
> i915 already handles both cases in a local helper, which v3d has a copy
> of. Add the same conversion to the core, so that it is available to any
> driver and both copies can be dropped.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/drm_timeout.c | 29 +++++++++++++++++++++++++++++
>  include/drm/drm_utils.h       |  1 +
>  2 files changed, 30 insertions(+)
> 
> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
> index 78e9f65e5477..30ad3e8ebc92 100644
> --- a/drivers/gpu/drm/drm_timeout.c
> +++ b/drivers/gpu/drm/drm_timeout.c
> @@ -9,6 +9,7 @@
>  #include <linux/export.h>
>  #include <linux/jiffies.h>
>  #include <linux/ktime.h>
> +#include <linux/math64.h>
>  #include <linux/sched.h>
>  
>  #include <drm/drm_utils.h>
> @@ -45,3 +46,31 @@ signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
>  	return timeout_jiffies64 + 1;
>  }
>  EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> +
> +/**
> + * drm_timeout_rel_to_jiffies - calculate jiffies timeout from relative value
> + *
> + * @timeout_nsec: relative timeout in ns, 0 for poll
> + *
> + * Calculate the timeout in jiffies from a relative timeout in ns, for drivers
> + * whose UAPI expresses a wait as a duration rather than as a deadline.
> + *
> + * The result is clamped to MAX_JIFFY_OFFSET. That keeps it positive once it is
> + * converted to the signed long taken by dma_fence_wait_timeout() and friends,
> + * which matters on 32-bit, and keeps it distinct from MAX_SCHEDULE_TIMEOUT so
> + * that a finite wait is never understood as an infinite one.

Please add a comment that it is strongly discouraged to use relative timeouts in uAPIs.

The background is that relative timeouts doesn't work with restarting IOCTLs.

I think that's also part of the reason why we don't have a common helper function for that.

Regards,
Christian.

> + */
> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec)
> +{
> +	/* make 0 timeout means poll, as for the absolute variant */
> +	if (timeout_nsec == 0)
> +		return 0;
> +
> +	/* nsecs_to_jiffies64() does not guard against overflow */
> +	if ((NSEC_PER_SEC % HZ) != 0 &&
> +	    div_u64(timeout_nsec, NSEC_PER_SEC) >= MAX_JIFFY_OFFSET / HZ)
> +		return MAX_JIFFY_OFFSET;
> +
> +	return min_t(u64, MAX_JIFFY_OFFSET, nsecs_to_jiffies64(timeout_nsec) + 1);
> +}
> +EXPORT_SYMBOL(drm_timeout_rel_to_jiffies);
> diff --git a/include/drm/drm_utils.h b/include/drm/drm_utils.h
> index 6a46f755daba..8c0cc9835413 100644
> --- a/include/drm/drm_utils.h
> +++ b/include/drm/drm_utils.h
> @@ -25,5 +25,6 @@ const struct drm_panel_backlight_quirk *
>  drm_get_panel_backlight_quirk(const struct drm_edid *edid);
>  
>  signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec);
> +unsigned long drm_timeout_rel_to_jiffies(u64 timeout_nsec);
>  
>  #endif
> 

