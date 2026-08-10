Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D63FC5AD55
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 13:34:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 783C610E86C;
	Mon, 10 Aug 2026 13:34:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="LkCEXbtR";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010059.outbound.protection.outlook.com [52.101.56.59])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 290E610E841;
 Mon, 10 Aug 2026 13:34:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j3FiubGTzKPRAPtAxPklFiH/HsB5DTBVFAGcqPa5EXUFN8pn5cP8lQ6zVZk74ipGlo5bPk6kZdt4DchfZSoytSlGrS6fPg/XNU/oQMKBEEuJrvdPkJySWANtlblmwhqa8/VZ2J1TheM1BsxZiKtEi6vYJYccJIs5LoWLpzMbWYpSlbGfSSfZ+OyWahzjlSk7KOfzcN3zMN+xqcjdwXH2/27PmvDsh56gLb5ZALHSdox5vqyxhVgk7AoaWDTTX3VRwK+juGMyAeCGooOcHW7oAgj1GLCk/dGoefG4WArvBdx/VWyWVxK1HP0dVVsRD0CLywfu+Zs9FRFp4p+dxn8ZvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yKpV/cFthI8BRwqnvUu9hjqweMjBk1wbJwdrpqtbVG8=;
 b=SCcUvRJLST2XdW7rrowoELo5h+h/OA+sjqIazIi0uMwSDGRy3EqkEnEmvTMorGLe6kyxClI8sg/f924ccVtoC7GSEG8XZ+iNKJQuGep5Nc8zxb6lnYwJx2sk+xYda4fvgEDzYPN9SYK7lOeEn69UecWuRKCrRkaluVkxDXSiN7SnxOvgkMo3vuNWYyNdslWDc/U8oi0AnbIVRVBHcCOrd1W8wpiLz6PnanGHwA64SBl9mHpuf2T6XV9g6q1NCN7Zsck8AjUmqg0/fS8oFXOLU9Mw/9CN+ken1IybbuEeGiP5A9QePOVxWzOlsFDjYcLGe9kCZ5MjA4Qz6tswyPo09w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yKpV/cFthI8BRwqnvUu9hjqweMjBk1wbJwdrpqtbVG8=;
 b=LkCEXbtRtCpFRrCXWLZLVSmu5OMG8dg0SxKS91p36SngpXENE0+MWmVJ0iQRg27vV2zE7RwhV6AcknsIKlDGuAoOwzyepyKeu2g+Ev2+VcwtkH3+sGIXSVdKavfISUQs4tGlMt4C96t6tSOnRphA8nnMpIAM9emMEJF3mjwzbOE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DSVPR12MB999285.namprd12.prod.outlook.com (2603:10b6:8:41f::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:34:35 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%5]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:34:35 +0000
Message-ID: <eaba2132-a4ad-4634-b00b-6728364a792c@amd.com>
Date: Mon, 10 Aug 2026 15:34:26 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] drm/amdgpu: Use drm_timeout_abs_to_jiffies()
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
 <20260809-drm-timeout-helpers-v1-3-2de67405a145@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260809-drm-timeout-helpers-v1-3-2de67405a145@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL0PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:208:91::34) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DSVPR12MB999285:EE_
X-MS-Office365-Filtering-Correlation-Id: 7951112d-0f8f-4a2f-2c0f-08def6e41de7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|366016|22082099003|18002099003|5023799004|11063799006|56012099006|10067099003|4143699003|921020;
X-Microsoft-Antispam-Message-Info: 2XdGYfg1Bbi5goH1wwIpNgpJje+Cyzy82YCaCIhbZUlCzi+ouIu3SvBP+FRQUjwXx56Cz1ud5jR/W+/pkZwi2KFE4ccvqzfrwMGCTW/tJxAcyP6TFTpfpOXbD4bj//8sP6npaIxTC6gyWKIhbg6kD7sa1qi7Kzl7X1puXCDnbM7WcTvPImowkptWy3QWamkuKR8BwVuXPYD0JNZ0oUR9JWBXIrXTGYu68FxldjTpUe4mqVSrXeudbdV159Hk0ZqMNrBdHn+j+KraqDSwygvELO1km+Z4gFcVwua8JoIYcvCWvnk6s4SQwp6THpgG/DQw0bMyW0/zzOJdqw7BzFxhTkqGFcRMZIy1UyqLxXfieUWh67TguzJqRyY8v1ZBoFvV4U2l0lNBdw0oEbUoufT31Jw+azlkoeJMZINQ3bgqZLPNTHs+s74h1oCAffNT9mKen0swpwDR4KRd3O0QzMlC7ZDdVdB0Y9G1E8ZCTq7WSMwz0e10DBTyg1WoSsVdfnEuSjWyuYVyH2vOWeQqNr+4Q8DO7LLwi266jg2JEiMZVNmKL8kH+MaFUuj6JH4mAwNCxoLMcZyjVB2aj+z7I6pcET9WaGH08Owjwd3rajHGSZ8dB806koTk+bBl+WRwWUdEaIRPrjagRe2PcVRwwhoP/gdZVlT/ptHgVMggb5a4Inmf1lMQ0fj2/VQeEXxOAUy6ENjOLGgPryc5niBnzKCN8g==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(366016)(22082099003)(18002099003)(5023799004)(11063799006)(56012099006)(10067099003)(4143699003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3czMElWMWxWT1RBZ1ArK2hEVktJVXVTNTBsQnVuMlRBZHk5azBLa3BsV1Ax?=
 =?utf-8?B?QWFBR1QzU2kvZ3ZFZnF2b2s3ak9zZkN5MnkrOGY5cW9CTzVIeUIwQjRjaWJR?=
 =?utf-8?B?L1dGSEI3NGRVbW5WeWsrYWRJNmlYcUVFdm1jUVFrczJxalBnZlp0ZFJsUGtk?=
 =?utf-8?B?WTBHQlpBYldabUFxRE5BWnVpRzJ4UHhqRDgxVkVaemFYK1VHTDExNHlRbFlu?=
 =?utf-8?B?b0gxUVZ6TTZTbTkySk5HZ3ZOQVdnZXkwbUtGbEZCRjNKbVIwU2srOEcxbzY0?=
 =?utf-8?B?RmM2Z0l5VHp5YnRFcWhOZS84anNHZlJ3eCt0bDBUNGFOSjMyM2l1c0p0VVFr?=
 =?utf-8?B?R2hvZjlpdDR2a1ZSNkRWUCs1KzFUTHVNWHgwa1dMNFFvT3h1MUpOL0Y2R2ZW?=
 =?utf-8?B?VmE0N282eG1DemZiM3h6S3dqektna3VCNDljUnVsWGxhejQzMEl6S0ZzUFgz?=
 =?utf-8?B?WjJPaEVCVStOQVJOb3JJdWlBOVNyaGthdkc4dzVNOVNrOFpXOGhkbjE1cWtL?=
 =?utf-8?B?WXBGNGN3R05hTzBVRnVCWThuMmJvQWZmUlRsbnF1eUR4VWwzREZXWENsOWtM?=
 =?utf-8?B?TUpoNWcvN3BmR0UyTkFvdkxqRWMyMHhGWC90cFFVdHZTTTg4QmFRUmxLUmN1?=
 =?utf-8?B?TDNxNXdiM3M5R3BBUThQWGhYSFJ6cHdpOHRYdU0rRzMwOTcwakg3eitJU2xj?=
 =?utf-8?B?bjJlNjdoRTlsY0ptSkkvRnM4a3BMclVZWlV6T2FkSXBmUVBBY3RDNW5FUW01?=
 =?utf-8?B?ZDNjTGUydzVVOTl5QVFGQkZVOFNSdjF1OTltNGZtTE1ranY3ZFN4TSt2UHE1?=
 =?utf-8?B?R3B2YzZLbFJrS2R3NjltdWJmTkZWWGVCb1NFUkRBaU1tTDBSYTFpU1gwR1JE?=
 =?utf-8?B?c2cyN0NacElPN0RtSzZSVlNNRjdLWk9nVG5IU2lYV1NEMDBmeWc1UjkxZlVr?=
 =?utf-8?B?SWdpbldsQlVsZFcrMHc3RFkwZHRSN0J0cWcxTVRweXNJWVBveHRzYlNvdHdR?=
 =?utf-8?B?T1FzdWVJeVAxRzduMDlUZzM4ZHhzN3FmOE5sWU9nSit2WWxuTUlzd00wOGF0?=
 =?utf-8?B?bzJVNC9BZzJOUWMxbVdhaFRVLzhiUlR6TGpUK2RQQjJoQ3p0Z2haVTZtUzZn?=
 =?utf-8?B?TE1jL1VuZVkraUNZa3JtY01OWjlHVFJVYTE3dHJROWRQTEY4OGF6ZzBkOTRV?=
 =?utf-8?B?T1J3by9LQmNlcHc2RjQxTUc0MGVRbWxpaTRGeUhDc01JM3B5MTMxT0JOcHRx?=
 =?utf-8?B?NlhVR2xXNjhySzVnKzFweGlBYlA1bEtlRmF0SlloemNZdXptNlNUOTg3Rzhh?=
 =?utf-8?B?eCtlQWFsOTJpSzZDVVlOZUxGUG93T0pqSkg0Y2EwRUcxM1JXeDhSa3RodWdG?=
 =?utf-8?B?dllrcExJeDlYM2ZNeU1WOGVsOXBDellmTEEzb2tlOEh4dU1wY25DNUZIR3Yr?=
 =?utf-8?B?UmRFQjE3Z1krYU04OGZRV1Rqb0ZoVHV4RXZQM25zaEVWQS9RVmx1ZGJZWUFs?=
 =?utf-8?B?ZlE2bzgza3dZVEd6RUtpd2trS3NyL2NPZkc5ZTZEYVNBc29vd0FSRFNpRnZu?=
 =?utf-8?B?QzZjTjNLYUx1S3h0ZUthT2xkL3hxUEs5UzJ0UUlnaURZMWpZYit6ekxSRlNn?=
 =?utf-8?B?NW81allQUFE4eDhsY3htTXhSK1JYbXk0SFJGajRIRXM2MnZOMHl0bkJkOGdi?=
 =?utf-8?B?RGhsYllselJTRHBvQzBFTWswcFl5RitlT1JmNHlybVFEMXhZL1pZUTcxbndL?=
 =?utf-8?B?akpEeThSMTV0TnhhbGR6V0h4Z3RyNW9EWVhYZFpDcVhmUGtYaGM4MHVJUWVJ?=
 =?utf-8?B?ZytMZkQ2aDhKNktTcFplYW9XVE5NY1dEcXlHaE1yYUVjOU04Qm1KZFQxcE9T?=
 =?utf-8?B?ZGpuQXF0eDdNeUxvK0FHQ3lMUUgzYmgvOEZjRFlmNHpWVWZQQzF5RUtjZExv?=
 =?utf-8?B?SFM4R21SSUNyaTVxRGl2bjZ1QW5LZkFFendORWVBVkxJNFJyeEIzWHd5V09S?=
 =?utf-8?B?b0tVZWxMKzVLdUFITTZkUnNDbUc4T25ua1o5azFvTUgwWVByZzZsT0k1UDlu?=
 =?utf-8?B?Und0QmhnMTMvazR1ZWU4SzFRaHpnRXIwVVZvV3Y4WjQwblpyMldnZlMxTXUw?=
 =?utf-8?B?YjhTV2hZSVBjanFhL1RrMldTLzN2N1hQRURTMU1VV2d5V0trUGd4cE0vT3U1?=
 =?utf-8?B?Wm0wUmo4RXBNQmMvSUZJaFAzcktmQ25qdjVYY3BaemZsUGtLM3crelc0WUFE?=
 =?utf-8?B?eU81Q1AyWFp4ZWxmeWtiakd5NEJxWElOeGFwTlRObkRqeVEzajV1RnBzSzBD?=
 =?utf-8?Q?cAPjiR0TDWncNhCOl6?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7951112d-0f8f-4a2f-2c0f-08def6e41de7
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:34:34.9940 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /K1ghtv51JWP9byL4iloyWXjca3M11hug8+rGHPdefSIqr1U2H/yUTHR0wPZYy/v
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB999285
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
> amdgpu_gem_timeout() converts an absolute deadline in ns into jiffies,
> which is what drm_timeout_abs_to_jiffies() already does for the other
> drivers whose wait UAPI takes a deadline. Use the shared helper and keep
> only the part that is specific to amdgpu.
> 
> Two details change along this conversion: the helper rounds up rather than
> truncating, so a deadline less than a tick away now waits for one jiffy
> instead of returning 0. It also uses nsecs_to_jiffies64(), so the
> conversion no longer truncates on 32-bit, where a large deadline could
> previously be reduced to an arbitrary shorter one.
> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> 
> ---
> 
> As a note, this patch can be merged independently to the AMD tree
> without any dependencies.
> ---
>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c | 16 ++--------------
>  1 file changed, 2 insertions(+), 14 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> index 6a0699746fbc..84b509a484b0 100644
> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> @@ -25,7 +25,6 @@
>   *          Alex Deucher
>   *          Jerome Glisse
>   */
> -#include <linux/ktime.h>
>  #include <linux/module.h>
>  #include <linux/overflow.h>
>  #include <linux/pagemap.h>
> @@ -40,6 +39,7 @@
>  #include <drm/drm_gem_ttm_helper.h>
>  #include <drm/ttm/ttm_tt.h>
>  #include <drm/drm_syncobj.h>
> +#include <drm/drm_utils.h>
>  
>  #include "amdgpu.h"
>  #include "amdgpu_display.h"
> @@ -622,23 +622,11 @@ int amdgpu_gem_mmap_ioctl(struct drm_device *dev, void *data,
>   */
>  unsigned long amdgpu_gem_timeout(uint64_t timeout_ns)

Please completely nuke that function and replace it with calls to drm_timeout_abs_to_jiffies().

>  {
> -	unsigned long timeout_jiffies;
> -	ktime_t timeout;
> -
>  	/* clamp timeout if it's to large */
>  	if (((int64_t)timeout_ns) < 0)
>  		return MAX_SCHEDULE_TIMEOUT;

That check was actually never correct at all as far as I can see.

We need to make sure that when timeout_ns is larger than represent-able in long jiffies (especially on 32bit systems) then MAX_SCHEDULE_TIMEOUT is returned by drm_timeout_abs_to_jiffies().

And I hope that drm_timeout_abs_to_jiffies() does that correctly already, if not this seriously needs fixing anyway.

Regards,
Christian.

>  
> -	timeout = ktime_sub(ns_to_ktime(timeout_ns), ktime_get());
> -	if (ktime_to_ns(timeout) < 0)
> -		return 0;
> -
> -	timeout_jiffies = nsecs_to_jiffies(ktime_to_ns(timeout));
> -	/*  clamp timeout to avoid unsigned-> signed overflow */
> -	if (timeout_jiffies > MAX_SCHEDULE_TIMEOUT)
> -		return MAX_SCHEDULE_TIMEOUT - 1;
> -
> -	return timeout_jiffies;
> +	return drm_timeout_abs_to_jiffies(timeout_ns);
>  }
>  
>  int amdgpu_gem_wait_idle_ioctl(struct drm_device *dev, void *data,
> 

