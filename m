Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B186606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=dpnXvVfd
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4D0010E7E7;
	Thu, 26 Nov 2026 12:10:02 +0000 (UTC)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011056.outbound.protection.outlook.com [40.107.208.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC89510E7E7
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 12:09:56 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zEoG/ewkZBa4OLZMe4QoeTLy+juicfin+ZyQmOwJr6kOWP60EAkRj6FR7UyFLJv95ntndj6DCpmWqXp9eD0ooclz9MEt8PoPCt9XenaVkuO61vWfqGiq/mNMSR0KcMM4sjp2BsH2ytEGVsaRaCbJrdV0w35UOX5FKsm6aliRQlAhZPUv3mRsKahtJd2b/Qqu+tyIahRW/JOAkibfUEyMUIBQrgV60Sx9NumgC+6kEBf92EhqhpJnvBWhYD2UUWjQ7F8t7iVfBq2vRIsJbcLPFzgziUGekoHThwC7fVpecaBiOVbAC5glNAVOL5w1JF/olOdx/wsZSDS7piW46mk9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jwImIT8pBPxHLA4EpNIevSlPyM5CA8DIZeG00IRIS8Q=;
 b=AnWA2WVEkOPoWdC/cQbtavBwDqcS32gjPuJNPFUIJwvtN8ORajELdnOQstjFoiRmWRffxfI4E1W94o74PLv3oBzcecKyt3XEvFygI0htcKI+pNneAMnypUGU4/JScMQA53SySz+Zr6gylM5E88JZy7qHeXczEf36TOTsbrUb+cBAJl7E2JDv6zKqRJIEdDw5euBzqJd16FuiIl7sq7qj6lpkjNdcfY/oJh8ed7YivEHr3yA5vJVMaj8ED446QSbCvny7oIYUKK06lOT9jPDOCw+c9tVfHICwUrRaxg3xJw53f3y7MtRxofZioBwlVzHM80uAy97Y1mpuIWrJrRvj6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jwImIT8pBPxHLA4EpNIevSlPyM5CA8DIZeG00IRIS8Q=;
 b=dpnXvVfdz0zG5nR8Lf92bUX5v0AiFP1ifEIb6PfAdEPUZPLv2gpgWWZ+b1jQqk1fL9A23yGiXjXs4AWGqyw3CtsFpJN1fsDdATqxbqsheNiJMxPVHgSYO/XIPLO9rKmgBRp3Zh632RuWe5XL2zPGgvPGZokCycTubWje1gWYSzk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by DS0PR12MB6605.namprd12.prod.outlook.com (2603:10b6:8:d3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 12:09:52 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 12:09:52 +0000
Message-ID: <38563e5c-5475-4afa-bf44-fccfc1037390@amd.com>
Date: Thu, 26 Nov 2026 13:09:48 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/7] drm/syncobj: Use scoped cleanup for
 drm_syncobj_array_wait_timeout points
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, Fei Yu <fei.yu@intel.com>,
 =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>
References: <20261126111117.67342-1-tvrtko.ursulin@igalia.com>
 <20261126111117.67342-3-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261126111117.67342-3-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MN2PR04CA0015.namprd04.prod.outlook.com
 (2603:10b6:208:d4::26) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|DS0PR12MB6605:EE_
X-MS-Office365-Filtering-Correlation-Id: e01da4f6-87e0-43da-89f7-08df4bb62cc2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|261009221227099003|261009223027099003|22082099003|18002099003|11063799006|10067099003|56012099006|261102130727099003|261021123027099003|261026140227099003|261022105027099003|261026121527099003|261028144727099003|4143699003|261021121427099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: 6b2I/ItHC2o1jPfLCDcatu5nEOI3frVfcOr/uSXEn6TNGSyV83WoNKe5eONdvQ5MdHtH9LMcgXfoJZdGIW6ijqR3Y3Dg5WLEz2kZe6APxaifMrYuVKehxxSsT8BOIbrgHuL+qAxthiXV1r/ribDfkSRi59Jq5SDRZQ9mxGwKY5KXE9+HwrLFx0+y/8k/XqOzDF3dxbQ5ops7ngn7mQQnQW2DHhThI19Y9xe9ItZq0J/P+sMQDQ7KAWsxp2mswAbAu+4L0lHfOfVvdgDsQx3V5EjxXngAVrtYVhehA7cLvoSttwHtp5ty6sqBfm+7Gf7fFj3zzcvGWeyp8y1I0pBEYcq2c618cIa3ePQHQUCYXH1pCHgiAraoTZ5ztXxh1Jlrnk6cW3kePpglVnBKshbLUI6cWAzhSX8s3iZD+jK56ARsVDgPROO0DWK+1Ilry+4Tsgf2Zl8GBSa9He9v4aqfGJHZMseyhdJsKj3c7FXnnu/GD28vwX1bcDGoN8P7ywnsIXG7fSBAwCpy4Bz+TtXDPBLo+/GVNFzDvMIDXnG9OyYRHQDOavK6IpCZq/2NaWxuxAqNhfmP5nU5rgX4czEKLJwD3Ht8lW4yMPceia8wBBHUJYZzAH1YQIFLtQ7dlAQhtNfdyaVuKJTbDYCuCWV01GzPVJ0Jt+zTJrAJ9NwNrnw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(261009221227099003)(261009223027099003)(22082099003)(18002099003)(11063799006)(10067099003)(56012099006)(261102130727099003)(261021123027099003)(261026140227099003)(261022105027099003)(261026121527099003)(261028144727099003)(4143699003)(261021121427099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NE5JNnZzb1VhcnZRZ1l2cCtwL2RDNE1QdTVXSDdqMEczUUl5V1h4anpOaVRN?=
 =?utf-8?B?dlAzcUViSytkeFRkaThDU3V2TFljdURXbG5PUkNoVkdsaUFUamJPSm9mdDJw?=
 =?utf-8?B?TXFsblhVZnhPWXo3MzNBTXFSSkQvdHR2SjlRMFZncStSMVRld0p1RlVEOFFW?=
 =?utf-8?B?dW52UTNsb25sbW9BUmJNSm9kOHJ3TFVUbDZ3LzR2UmkwVDQ3YWlTOVJkUjVt?=
 =?utf-8?B?K29LeDdPZFQ5Z3FXU09Ec1BqZFZrcTRXekRZL2tNSVhaVjBXdUFwblNmYU0y?=
 =?utf-8?B?OURnVjh5dHIrS2Z5Rzd0d21LbGNseXdROE9ud0ZPZnZhNXhQOEFvSEdxWTlW?=
 =?utf-8?B?NzMzY1kvdzNYSjl6VTFibXZWVFZ6aFBwRm5uU0hmRDVmYktWQ3VIOXo3dUkw?=
 =?utf-8?B?K1dJQ2FLRDZmTEVjZGJ2UGkzaGpWMmFYNk1KRCs1UUZZK1pvTDNkVGJpT0gy?=
 =?utf-8?B?WkFiQWY3R2NkM280elB6QWY0clhzWXlSczRhNVlqUG5GNDk0TUUySXhMMlhY?=
 =?utf-8?B?QjArTk1LNS95TlZSUXczMHh4MU8xdUt1ZFdaaGRvcGpteC9RTVRnNjZKUE5z?=
 =?utf-8?B?azhLaUI5Mk53eXFiU253RldjR3poSDErZTg4Q2x1bmtORVJGRDk2RGVrcmIr?=
 =?utf-8?B?S2cycDdGREh0eTE0SllrMGQ0WTNIVEltTmVqQ21teVBSZGlOeVIvZEcvU1ph?=
 =?utf-8?B?V3FpMVBlQ0g2eUcrYmJQVjI5eWppREpjYmtXWmVwNFZCeENRT1FFd20rSFVN?=
 =?utf-8?B?RkUyRkJmQlhZRlhyekRIT1pNZTkyU2lCTDBhSUNDdGxnSm9wQUZrY2hxZEdN?=
 =?utf-8?B?Z0ZLOTNBc0hjRFZFU1NnVktlQVZFQk1HVnFBQmNnSWpmVkR6dExoY3BvRmtz?=
 =?utf-8?B?OFB3SlpUbEFBREg1WGhjY0RuamhzSzhZUnFxdUllRWg0YU41Yyt6ejhZSWlO?=
 =?utf-8?B?WjJuTUh4Q1UyWG9sRVhJb254dmxIUHBna3VpZEpSTFpPU3V1Sy9YdTB6WWtM?=
 =?utf-8?B?K1o0dWg2WEM4Vmw3Sm1SZVhtUmxGMUcxaVpocUJKUGZHZTliN0Nsb1p1SWdU?=
 =?utf-8?B?VVRPOEhiMi9FbE5QajRNdGRLZHg1TkxjWklrREg4eXhCMkpySmVPWjZpamFH?=
 =?utf-8?B?R2dZVzNYNXpHS3MwWE50TFRXZG1jOU9OTWE2S1UrWmhzTWQ0RWdGNXNzS3lo?=
 =?utf-8?B?MDArR3pJakxOa2xlc0M1RjRlWDlwNzR0c3N6QTBORy9ITEVTUWo3S2xiMmFz?=
 =?utf-8?B?SDEyMkwzQldyWTYweXNvZ0pWU3pFY2hTUG1rbjAxUEpDM0JaMSszK0xBSWFy?=
 =?utf-8?B?bk51RWJHOUdmZVoxTTVtcFdhUk43WE44K0ZmT0pHOEs0dmNFeEhkd0lPQU1I?=
 =?utf-8?B?QnlOU2ZjMk9udjNENjQ4anRZVnN4VGlxN0lMaGRLazl1a1dJTkJpYnFIZTRV?=
 =?utf-8?B?VUM0QldUb2ZadTBiNDNHcFYzbzZmMno2L2RvdWYzbHF3K3dsZy9sNVFHWmpv?=
 =?utf-8?B?aHJWQmF3OThuWTd6ZEh3eUcwMEg4WDJxTDdJeW9FOTR6M1Nna3FkMFVKZCtW?=
 =?utf-8?B?cjJDY2dOSGRTK0NIZ0pnNm9rRkQybGNSbk1aVEFoaXZOK1ZVUkZxV0xMVUoy?=
 =?utf-8?B?dGVoenJ4QjdaeFlDQ3UxbXRKZW9kaDhKTmV0emlwTFJNMU05cEg3cDJINTJ3?=
 =?utf-8?B?ZVFGKzU4WkxXZm5CYXJROHZNdEQveExINzBrMVNFWnVNM1YycU00d3lUeFNO?=
 =?utf-8?B?cXhCZGVyOTRaQnhkZkhlRVljWHhFQTVmWiszcUNhcG1zYXpCSGtBNTQ3Mkh5?=
 =?utf-8?B?VlI4cURSckpDU21EL3BlYmVxWVhyUzJqdU5WeExMSVJjMVRYTEJnSkNzNnAw?=
 =?utf-8?B?N3MyYU9sWFVvRGJ2cms4dUprTnFmMWJVSkdzQi9pTHFSYnNmODFVbDhybWM2?=
 =?utf-8?B?ZTRyK0N2V242VzB0dkVCd1YxYk9VN0tGYmlrZ3ZsWlE4TUZOdGlsSnFsY0Iy?=
 =?utf-8?B?MHJkMXZ3b3F2YlZONHY4SndLazFwMkpjYm4wVGhBMFZBbS9FTnlGbDlpd05s?=
 =?utf-8?B?M1gwaXRKWFZyS2tVWTh1YmZTbnhqNVFiRWpKNGhXZHZmWVlicFZiekh4Sk1x?=
 =?utf-8?B?bFRRc1F0d2dIYy9XN2d4RzdxaENiTHNCRE82NUxRQng3S3NBRm11VzJaR3BT?=
 =?utf-8?B?Y1NTUEJKT2s3eFZQRU9NbklWTENCM3RQaHkzMUtmYVdKbDd2NFNpbjJPVmF6?=
 =?utf-8?B?Mnkxc1dLcnB6NkJVamV1VGJYZ3gyZmNBTU9JN0lZcFk5aWVUT01DZytUVE1I?=
 =?utf-8?Q?cGrYb4ESwR8Zhp0Hng?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e01da4f6-87e0-43da-89f7-08df4bb62cc2
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 12:09:52.1179 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cEkn5x5VWUixwfLGN/W4xxXaK9U9EflIXlnqTQdA0PnrjPI797cPulHmSbD1rT0t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6605
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/26/26 12:11, Tvrtko Ursulin wrote:
> Use scoped cleanup for drm_syncobj_array_wait_timeout points array
> allocation.
> 
> This is a split out step towards converting the whole function with the
> goal of simpler error handling and easier extending with a fast path in
> the future.
> 
> Signed-off-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Fei Yu <fei.yu@intel.com>
> Cc: Maíra Canal <mcanal@igalia.com>
> ---
>  drivers/gpu/drm/drm_syncobj.c | 27 ++++++++++-----------------
>  1 file changed, 10 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 663d6cb8dbf8..bd3f9e74e678 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -193,6 +193,7 @@
>   */
>  
>  #include <linux/anon_inodes.h>
> +#include <linux/cleanup.h>
>  #include <linux/dma-fence-unwrap.h>
>  #include <linux/eventfd.h>
>  #include <linux/export.h>
> @@ -1052,8 +1053,8 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  						  ktime_t *deadline)
>  {
>  	struct syncobj_wait_entry *entries;
> +	u64 *points __free(kvfree) = NULL;
>  	struct dma_fence *fence;
> -	uint64_t *points;
>  	uint32_t signaled_count, i;
>  
>  	if (flags & (DRM_SYNCOBJ_WAIT_FLAGS_WAIT_FOR_SUBMIT |
> @@ -1063,23 +1064,18 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  	}
>  
>  	points = kvmalloc_objs(*points, count);
> -	if (points == NULL)
> +	if (!points)
>  		return -ENOMEM;
>  
> -	if (!user_points) {
> -		memset(points, 0, count * sizeof(uint64_t));
> -
> -	} else if (copy_from_user(points, user_points,
> -				  sizeof(uint64_t) * count)) {
> -		timeout = -EFAULT;
> -		goto err_free_points;
> -	}
> +	if (!user_points)
> +		memset(points, 0, count * sizeof(u64));
> +	else if (copy_from_user(points, user_points, sizeof(u64) * count))
> +		return -EFAULT;

I would go a step further here and don't even allocate points when user_points is not given.

There are only two uses of points[i] below and that can easily be replaced by a single "points ? points[i] : 0" making the additional allocation superfluous for this use case.

Regards,
Christian.

>  
>  	entries = kvzalloc_objs(*entries, count);
> -	if (!entries) {
> -		timeout = -ENOMEM;
> -		goto err_free_points;
> -	}
> +	if (!entries)
> +		return -ENOMEM;
> +
>  	/* Walk the list of sync objects and initialize entries.  We do
>  	 * this up-front so that we can properly return -EINVAL if there is
>  	 * a syncobj with a missing fence and then never have the chance of
> @@ -1198,9 +1194,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>  	}
>  	kvfree(entries);
>  
> -err_free_points:
> -	kvfree(points);
> -
>  	return timeout;
>  }
>  

