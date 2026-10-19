Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74307CCF2E5
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 14:29:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A89510EDFA;
	Mon, 19 Oct 2026 14:29:48 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012068.outbound.protection.outlook.com
 [40.93.195.68])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C741110EE3E
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 14:29:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF7+9WqIDWbnzg4+taWxeMJI7mqoDFRN1RrKl1oCVy1EA6jZJpKICbenDBORCq88Aa7E69gGCQd4U4wwICTH1ZaSNs3oY8Q9T4b6YaxOZzrevg06pe68h8zotyz24eDCyS19VxPBgtMcDwv6KE+hsVydK7gwona7KIH4YG6cU1Jzaa59PGrN0FP/aNLoee6QfWpj78aZ2DSVdPHL9zSXy/ag3iOFdX/lAVXOhlB3xvb6aiMWm8fXeBEN9TsAbpIpwOsEs4MCl4RQ2ogEEzjC+QMUMXHt3s+XebcZAB1SpTDI0BL5U8CGw+PUxSJcRzQD+bxArt5dYfZo0Bi5xUjPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aumD0BoZdVLl0GaSpbHjAyXDhIoUoKofDCxJZkx+g4g=;
 b=sETVopaYvFN+sbr6vTHFL4cRGOGWEFe0fi0pv4cXzI3NPP0l7LgLkeX3kM4vjczRYhIYycPfesrRNMnaRTmi5o7Y2UJSYM8A7IEUPL3CnMGmjzGwjVKcCAhf9ohNLG+FgCfypRXEWSuY5X7+ItiE06PQDwSRTnuYYLRJ7j0K8jBXAEuUanuigvgUt4eurwGcx9s2rOebCDX0Q9nolwVpoUiO98iPDbRy86N+0BvbjVa/ZQfibO2VlNbRgarq9Kyf6LPxMlcFdFE42uWohkELG9ZkeKgj/godzKkTbQbO3JjG50A010tQaXRf1gyxyME/1oHoPMuEmjzGMzumIkUREA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aumD0BoZdVLl0GaSpbHjAyXDhIoUoKofDCxJZkx+g4g=;
 b=O7WyprEpdMQkojn32MW1jepSN+7KIkhK7gaPqIfx0x8HcPjQEfKJe2axBST0hW4SfNQA4WawGXOFf5kjZWoHP4elj90YVy6PkOq9rXym0evpe6TnGZNOT8DDIW/GXPT1lKE99RQiZTs4MJ8EbY6onfahFU9LrOIB9iHONb29nNc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by SA1PR12MB8141.namprd12.prod.outlook.com (2603:10b6:806:339::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 14:29:38 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 14:29:38 +0000
Message-ID: <8d50e095-0aa1-482c-b638-679232c8eb17@amd.com>
Date: Mon, 19 Oct 2026 16:29:35 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] drm: Log recovery method with wedged event
To: Raag Jadav <raag.jadav@intel.com>, dri-devel@lists.freedesktop.org
Cc: riana.tauro@intel.com, mallesh.koujalagi@intel.com,
 matthew.brost@intel.com, rodrigo.vivi@intel.com, andrealmeid@igalia.com
References: <20261019025853.140747-1-raag.jadav@intel.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20261019025853.140747-1-raag.jadav@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0409.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::9) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|SA1PR12MB8141:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e682384-fe0b-432e-52a1-08df2ded67ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|56012099006|11063799006|261009223027099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: tIV8vw8r+13eNGP9A5vyXUDkNXEK3h0oEfJvSjazDBd0EFDOACZhktIhamyc90PuTwjh+Rjr/W6GusbKYWri3w/p2eH0zX5VI6qwso7Gcp2wCed/QiF9Wj9/OyS+wBLL9fY5DDM9gZ5r/1C87U7PfkY3XCuVBqvR6Oa+B384fI/E3aAAtNrCJGJyP3amcRCyHgNasg0VY4QlJWkmoHwBuf6ZLnmojKqVWhhrZvzDTmgSwNP9y6KqySv8zKgphsJidS6kW1nQtt5CgbwaqYLmb59NTAuV/b2UaSe9YOYTpa0iQyEbj6fG6n3NmsZ0hatBngKp8VFbF+lQJg6QNQv+wFHhT41/IbA3Aseu7Gs83mJMmbJMJ9bJEYbljF1zn5VjwA4lLi728C3fn5tiD2u6TXcFR5dA4DV6ioAFUp1P5FRr60MNaZvJhaW1p6UumP8VahmtRVmXR6iWHa5V9XNbgW4a4JUTbckiuwzpg47Q9xUy8QEteElfXLftufL7rwxv/e+KK8BDASAohUCcLt281iUIp8YtW43/1zcqbVHPWj43Ua15d/ykUXMO9999whPrVHa2rcPgqbKHn5PWDBF5ls0sk6yEkTZjolf74xVMkXyaX4uNZLWpd/8kAzKxklp0tBcqokSMYxAiEPUrLz5pAUqxMt+P9VJ1Ih82rbcz+20=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(56012099006)(11063799006)(261009223027099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aG43amo2YTZuNHFaYjZwU0xvRmQ1Ri9oUUFlODJhcmFvYTJyc2pHVnpySW9Y?=
 =?utf-8?B?d3NsOTdxaXJRbUkwUEJNeEY2Q0VQZVVUandCRit2c3pkbm1CeDVONk5GblB3?=
 =?utf-8?B?YnR5Z2xlNVNvZXQ4UHh4OHdHZ2s0YUFxQnNGbHpOQUxPUkVGbGw2ZEcrMkJ5?=
 =?utf-8?B?ZmlmUnYzUklkTjlicUVEUVBLd0hHL0J5cTF3bEJ2NktGbHRGRHJGeTdYaFZ5?=
 =?utf-8?B?dDNwRko4WnpQK2pYbjNLTkJ4TDRqaDhDa2t0Z0twK1VuUFliT1YyWGFEaGti?=
 =?utf-8?B?ZXYrdFJ5eHRSbHlOWlBxbXNDYzVnTVAwai8zY0NNeFJuWXJMWUd3RVdmSmZY?=
 =?utf-8?B?RWN5MVlHaE8wVVg4R281TGRvWm5XVVowZGdiaUZ2cUw4aDh1Wm4zQjFDaWpo?=
 =?utf-8?B?cHhQQS9ZTnduYzZvZnVBdUVDTFptc2Y2RWZjUXdZRThEN1hhaFZWQ3VDb1Zy?=
 =?utf-8?B?MXdtVVJZT3JZdjhxcTY1VE1oc2Y1Z3VzdEhPUUZFRVFLMS9uVjN6SVN4Wi9q?=
 =?utf-8?B?NXFzem91RXZwandBdDdlZGJWc2ZwSXp4YzNNN0ZWbzIrZ1NmMHlIVDVqa0gr?=
 =?utf-8?B?WmVpaFRDVWxoVytEVnBpcFFoRHAwNk4xamVLdE8yS0FUZitGUjFraVpkNnlT?=
 =?utf-8?B?SjVtWnlIV0NCMjJpUkdjWTFySTc1dW4ybm5RbHZtZUp5YjFiK3BHWk1wZlBT?=
 =?utf-8?B?Rm1NTENyeFFQRWltbE85bysrTkhmYzBTdkI4R01DOXU2MStMR0dCY1J3M2I1?=
 =?utf-8?B?cTlwSUpMcGREOHM3MFlVNWR6Q0c4cFEvRDk5SnE0bG9hYWl1aW54UEtkN1pU?=
 =?utf-8?B?Yk56TFIwQ3NQUHJFWHUzWlRHVmlldTIrdEJKaEg3M3dRRU13T0NybHdxZTFo?=
 =?utf-8?B?bTIvVXNMRmk0SHU5S1ZUZmlyaDhNOENMazFiemVuN0pBczc5MUFjTmE5bUxi?=
 =?utf-8?B?NjA1WGFxZFg1WGNTREZkWnpMdjUxUEdjdmc5ald5WnRCQW9PQXNJa1E2Nlpv?=
 =?utf-8?B?eVVDYWlyR29YeGEySUNrT1ZOQWlhYkNYVlFqSVJVTUFxc3pybnlnOWdDaTlq?=
 =?utf-8?B?VXh4NkUyb215VnBWbmZvbFcvNS9DU2lMMmp0VS9mWHlqSWcyV09OR0RCRzdZ?=
 =?utf-8?B?cGhpY3BNQTNjVTZsenVpQVRUR3BnMUNWSkVzeFlvRTBSa1VLSXJaSW9CZmxx?=
 =?utf-8?B?Z2srZnBROWI5ZGk4Mk95M1Q1NzRRQTAxUWdXVmN1S0sxSmhleWl5ZFNvSTJx?=
 =?utf-8?B?dlNiSC9aSWxQV2lyY1pPc3VSWVR3d0NTS2tqZWM2QVM5S3FTeWJhUGJRQ0J1?=
 =?utf-8?B?dkVaU28yT0RQbm55RjgrR2xDbHcyellpV3JhT2RUdHlmRzRTUjlZMkk0RVhI?=
 =?utf-8?B?clVkVHpsS0l4Wm1ZbjlteXR6OElBejVTaTIzMVFWNlV4ekNUaWc5KzB4eFNX?=
 =?utf-8?B?THhIM24vN1VnNXhBcU5WY1ROR0JRVE00aGRCRGdvalJzbWdVUWkwN05HWnI4?=
 =?utf-8?B?MVh5NmVaalNCWnU5WnhtZWVySFFHRVRrQ3o3eGFDNStLVkNWWmZ6eHBxcHZL?=
 =?utf-8?B?cG9JNklwR3NqN3NxQ2ZIbFV6R3NkdjZ3QksxOUNiWlp3T1ZjUkZPRXl0aTZi?=
 =?utf-8?B?eVZDLzJSUEpLSCt0SkFUUmdKNU1EVlgwck1HNkZCa3Nqd0Y3d2lTZnk0cFl2?=
 =?utf-8?B?NVNCUnFsTS9NcjBXdFE1eXRpUUYwTHFYTjVkaFdjUjBDQnc5ck43TE5yODFJ?=
 =?utf-8?B?MXhuWEhFT2E5RTVlZnFKT0xHZHk4Sk9YcWNYMTZ6UlV0cHpncGZrOEdEVVlv?=
 =?utf-8?B?aDY3dVZtSHFaaUVwVHNYU2ZuK0daQWIwNkdxS2h1aEZCSk1UMzhEcDVXdE5O?=
 =?utf-8?B?TGFtKzBmUGRTQzN3TVNQUzZmY0gxbC81d05MZHJGLzVWMGxtUngyTlNIdXRU?=
 =?utf-8?B?cFRIY0NBajBGTmdEdFNoYkNmNEVmcG5ncDhwTWQxbVA1WkVOWXhNVUx3SGlT?=
 =?utf-8?B?OFJUNkZnU3doQkF0cWV1ZTc1WUtKWllHRElWSkprbzhnVzVkR25JYy9KWFdJ?=
 =?utf-8?B?UW1KTmlIWWFjZGY0MVR6c3BXUVVhaTQzVmg1RTRza21KMHI1TDBvUTJ6dUFR?=
 =?utf-8?B?emxRdWtmK1BsdlR1SklHOU1tbUJKWTRzM1pqR2dXUk81SHprZEc0RXlUMjEz?=
 =?utf-8?B?dERTaTFLcTAvVmpwZHRrUTlncFJMRStpNTkvTXNUcjhqK2Z1NU0vNUVTSmMx?=
 =?utf-8?B?Ymh5dVV5UGxPaC9WelBZTnVtSWdRYjZuUlpZeDBvVm5qZzFTUndkT25yRHdZ?=
 =?utf-8?Q?hTIvEM0T26ccSRueXx?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e682384-fe0b-432e-52a1-08df2ded67ee
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 14:29:38.5386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dAWl41Y1Yocbc46fmjmmHbR9e5hU5yVastn9D+5DtJPTiOMCysAaOwu77NX3Yvub
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8141
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

On 10/19/26 04:58, Raag Jadav wrote:
> Currently, drm_dev_wedged_event() logs a basic message of device being
> wedged, but doesn't print the recovery method used by the caller. Log it
> for easier bug report analysis.

That sounds like a good idea to me.

> While at it, as the device wedging is a catastrophic event, raise its log
> level to drm_warn().

Device wedging is rarely something catastrophic but rather normal part of execution handling.

So I would rather object to that.

Regards,
Christian.

> 
> Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> ---
>  drivers/gpu/drm/drm_drv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> index cb53baa70995..1a1213f4235c 100644
> --- a/drivers/gpu/drm/drm_drv.c
> +++ b/drivers/gpu/drm/drm_drv.c
> @@ -598,8 +598,8 @@ int drm_dev_wedged_event(struct drm_device *dev, unsigned long method,
>  		/* Caller is unsure about recovery, do the best we can at this point. */
>  		snprintf(event_string, sizeof(event_string), "%s", "WEDGED=unknown");
>  
> -	drm_info(dev, "device wedged, %s\n", method == DRM_WEDGE_RECOVERY_NONE ?
> -		 "but no recovery needed" : "needs recovery");
> +	drm_warn(dev, "device wedged with method %#lx, %s\n", method,
> +		 method == DRM_WEDGE_RECOVERY_NONE ? "no recovery needed" : "needs recovery");
>  
>  	if (info && (info->comm[0] != '\0') && (info->pid >= 0)) {
>  		snprintf(pid_string, sizeof(pid_string), "PID=%u", info->pid);

