Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 328DA606A326
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 07:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=g074xY9q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8E09210F31E;
	Wed, 11 Nov 2026 07:49:45 +0000 (UTC)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4635E10F31E;
 Wed, 11 Nov 2026 07:49:39 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IR+QA/U3vBdqPsWDjskdotTWOBl9XU94L6JG8+fO5KxGc+M3qS7JJKa5JwyyJb+ZGQLhH7reUqYRuAWihK0+8hQSHBVYYJUl/PaaCRaP3CQcI1eqjTqXOLcw0bjbul1tCklnrqdA92J9G9CObb+KEQS69gz43Uq7j94IgWlxvaSGRVgONynUPpevoc8GGNvUlIZnGhZgN+4jZKoSIHflbJZ3xGmLm1nNbUwxrQKqmb97xDwCWtHGgqRh+S404lYErd67GiFFLsHhk7yFfKdBVLp9fpGyl9iA8OS635zZpTZ/uk9zfNg+670S/gEVq0NO3vsDdA4fHg+hrlsYr8y+sA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KY870ihqrGkGfPYnr/IzXwQYUiUIbgwisZIvzfq1S/U=;
 b=Vr1RkM5Qp1ykdepboFxzD5cwgSOY9ONp5uxr4g8UCOsp4CoVWIIWdoBaoAL6PdfHpe01eebc8wUTKquyVeVtRzT8Be7I7sjo7rg0gcfHSIC/xejX112qgyu+e/4ghlnV4MBgENMdt/evUsZzVvqJ23mz9a8r+gfjwV2CWm2JZhYShkfca3FLAJ4kjOqFsuYD1nA0f1Qfo0NbrJmcE/cKDJgY9W8of5SLVdx1L/30ExBBqJIlZyWRgEAnqJ5lIBFwmXrsKP6Cp7riUaI1ZKybeeGZdQ31ZewW/jlefbPnBd30OwHE1GI4Q+gG8b9SjFKS0eat73/+7eHI58ciWB/C9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KY870ihqrGkGfPYnr/IzXwQYUiUIbgwisZIvzfq1S/U=;
 b=g074xY9qT7/YLVunO42pb6+vCf+JY8UMSMVTuOAvJyWFtgyAJca9CSc6k9MQxS3TYdGK6mGyD8Q1SNxGQhEXoE5eeDg+D/EBZyKbmwoJsHxkWU10QgEzMWInDb5PzrNdotG8zYXYcZbJRHwhUNSUEE/euclc7ABQHgvUu469Xts=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11) by DS0PR12MB7995.namprd12.prod.outlook.com
 (2603:10b6:8:14e::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:49:35 +0000
Received: from CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585]) by CHAPR12MB999225.namprd12.prod.outlook.com
 ([fe80::a4c2:82c3:da88:c585%6]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 07:49:35 +0000
Message-ID: <a071a59b-7cd5-4fe4-bdc9-4e041c45a5a8@amd.com>
Date: Wed, 11 Nov 2026 15:49:28 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC RFT 2/8] drm/amd/display: Interpolate between
 backlight LUT entries
To: Hugo Sales <hugo@hsal.es>, alexander.deucher@amd.com, sunpeng.li@amd.com, 
 harry.wentland@amd.com, siqueira@igalia.com, amd-gfx@lists.freedesktop.org
Cc: simona@ffwll.ch, alex.hung@amd.com, mario.limonciello@amd.com,
 linux-kernel@vger.kernel.org, lohita.mudimela@amd.com,
 bhawanpreet.lakha@amd.com, dri-devel@lists.freedesktop.org,
 roman.li@amd.com, airlied@gmail.com, christian.koenig@amd.com
References: <20261103-backlight-curve-rfc-v1-0-6e4813a8f2eb@hsal.es>
 <20261103-backlight-curve-rfc-v1-2-6e4813a8f2eb@hsal.es>
Content-Language: en-US
From: Ray Wu <ray.wu@amd.com>
In-Reply-To: <20261103-backlight-curve-rfc-v1-2-6e4813a8f2eb@hsal.es>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TPYP295CA0023.TWNP295.PROD.OUTLOOK.COM (2603:1096:7d0:a::7)
 To CHAPR12MB999225.namprd12.prod.outlook.com
 (2603:10b6:610:2fe::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CHAPR12MB999225:EE_|DS0PR12MB7995:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c9d13ab-c400-4bf6-7367-08df3fc85476
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|18002099003|22082099003|11063799006|5023799004|56012099006|261102123227099003|261009223027099003|261026121527099003|261021121427099003|261021135927099003|261021123027099003|261022075727099003|261022105027099003|10067099003|261028144727099003|4143699003|261026140227099003;
X-Microsoft-Antispam-Message-Info: /usmcd36Nk+mL6c52IYlGpNHSdZTMLyI+AaFgXdX5ntn+AeXrjqoBtPZ5Mcm/QKcvCEJhOYaUXGVvPFaJHA52dTH8/9H5hZZzqjMUxKhr2Bkmfo1N9JGzm/GCjz6azSSRRwX96RyArS9hGLdiCmOtXWhac3FTfEC59Z0rgTII0x8B9HPeDiaBDBCmSn0QTYpWPiTO/ydjiOw+B4I6bDq3OUsmc2fKPG5U7FxH9YGMpKqievsdBpYh5RtxyU33WOxJHY1rGfDIyfoa7CZEFnOt0WuKwenbvlVIKK3BsNsBvt+JjMTVZiM6a/y1nLo2FAcIN+YThTa4MsGXzh8jF6T5CBvhx6JbdzUhz3yPr7Tw5/pdub0QkN2lXPWXzkIXAMcd1cZRFHW45eYmEHVUjmdBMjZho561IV780gDBJwSJs03P6vunHsABbG7xFu3E2LgXIOuFEwmBOQvOCaTA/65qD3yvNpphckGbvgjWVyVutGIW/61J6iTi3N7Rl1qRFTU0fxI66mRiZtLap5I/BOtNPtw7VeUh+RUXaZQxWM+B//WvNN+mDlkzTS1h6xEUt0loji4KbqlbWAuQL7xumjZ9XBggAGEE9WtLKff0rKs0emcSqWdWHfL450ciJMN9lMQkCZ1xKPxNlrucmwWtf3d1EYZ68UHQ1PnVaJisDr4hag=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CHAPR12MB999225.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(18002099003)(22082099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261009223027099003)(261026121527099003)(261021121427099003)(261021135927099003)(261021123027099003)(261022075727099003)(261022105027099003)(10067099003)(261028144727099003)(4143699003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VENCMHdGbE5wb05EaktZeEZIRUJ5a2FtVHFMOTdrVS95M0JCS1JkVGxjUll5?=
 =?utf-8?B?dzdmQTJGNnhjb2JhcEtGcjVRZS9oaEsyYWszM0xkQ21NdjVyLytFVHp4Ykxx?=
 =?utf-8?B?Z09lU0xqM240OXkzVGFJUHMvb0dNRjhIdzM5dUo5TEI0Wm9vVlc5cWZ6VEJm?=
 =?utf-8?B?cCtpWS9RaUNVSzdZVE5BZXRUb0pJUStCUCttTzBEakNZWng4YmsvK2lRenBs?=
 =?utf-8?B?ejdITzFuaXVMYzFoUEcrMnMveUUvZVd5SDAveXFxUFdaUHByRkd3K2ZVL3hI?=
 =?utf-8?B?Y20yeEM2a2UwNzZPNmU3SDRNWnk3OXFkMy9mbHUrWktUK3FsdFBGUGgyeDR1?=
 =?utf-8?B?VzNIMmZYZFdhc2Y0OXpTQUtXdHkwMEdzQmtuVENrT2VpMjJnaWlkblBNWFYw?=
 =?utf-8?B?VkxMYVcvb21DL1J1VjdPdkpJeXNLVWJOWFZCQTlycjNMS1V6TksxRDBkdEk2?=
 =?utf-8?B?dXRrY2VKZDBCY1RtYm5ENnZhdXlVdm9xWDFocVU1OTJPY2hzVGtnYWh1Wllj?=
 =?utf-8?B?T3FYNk5NUFpFQm85NjBpTkZjQmRONXpiVmlhQWhTWWlnbUZYbjd4NlAva3Vm?=
 =?utf-8?B?eldMZEZmaGg0bGsxTGlWT0FXaTlUbHpTVEtHZ0ZKS2ZVNWNOdmRsbExRZzZk?=
 =?utf-8?B?R0hvUmJuQ0EzeHkyUDFrd3k0YldHU3BualhRand2VDBxRjRhWngvZWZzQTVi?=
 =?utf-8?B?QURRYk5aZXdhV3prWUdJZ29LVDcyakpmTndudkVCVnhRS3dNTUdqK3JJRlMz?=
 =?utf-8?B?cUhrcFhsa0xPRy9SSkdzTVJpZHVyRTRNd0NEZU5KMHVHL3RtanVFdklPQ1dP?=
 =?utf-8?B?WWZ4TFNVam5VRVhreDJBVDFrdGdUN3hEVEFVQngxU1FFUFpFVTdDL0NnYy9N?=
 =?utf-8?B?aWFBZUdGUWVUYitzTVZXREVMQmVnOUJ3RjZNZWxUbW5UQmoyeTY2MUFLMmVu?=
 =?utf-8?B?cVZDbUR3UnNWMGpoVXpmRWhrME9oaFUvYmpVbVk5eG1TeVNZLzBhR1pjelBD?=
 =?utf-8?B?YkdwNS9XK0UwQ05raEdka0RiRnVtQmIvdmZYUEFNakRjeThGbUVJY3pBamVK?=
 =?utf-8?B?Q1NDZnpLSllaUktBR3BmdEwwNmw4VFZvRU45NUZiVnJVeHd2ZWc1ajJsNFdp?=
 =?utf-8?B?VnFUKzN3SFVRNnVWQnFZblhTTlBzYTYxQk92dFVGeHVrNjNKTGV4ajdMU3Vx?=
 =?utf-8?B?eUlrZ0NiblZZYkpRK1ZsbEZzN0h1L0hQVkNnSWMzZWdxajZYNkM3V2RQSW9w?=
 =?utf-8?B?NEFpMHR2QXVHbnhWMUkrQjdtdHRlekFSWktjN3ZwSEFlcnRjNERmbjlCSVp4?=
 =?utf-8?B?Ym5CVWZuNXlLZmVqUTY4UTR3Zy85ZmFEOTQyc2NidGJKK0MrSERoc3paZ2tG?=
 =?utf-8?B?aTBkVEVpazFhYXFQV0VUWXZDY0NDVkxlQUhCSW93ME4wNmR0VkpQWTA3RXE4?=
 =?utf-8?B?YnljK3dHa1BOUEFrRll6QzVmVmFlUU9idm92djBIQlRVR01PQ1J1OUlEY0FQ?=
 =?utf-8?B?cUl1VXRteHptNWxlVG5mNGZ1MXMzVEVYUVNrSTZjTFlLQ1dTWjJVcUZ6eDRm?=
 =?utf-8?B?LzI4c2IxVkgxWWVyYUVxbTFMRjdiVC9tOTRtdHZGNklMejdhV2k3RjkvQkxl?=
 =?utf-8?B?TnBmUTRBclVHcXd5VGsxNExRdlpiS1ZLdmZFZVF1T3oxWWlrR2hZd09CYWtG?=
 =?utf-8?B?ZDQ1dStVcURDOGRNYTh4L1FnS3lIc3NjNDBoWkJpNjNQV1JlekNsR3RlUlZm?=
 =?utf-8?B?bjBVV2pYOW05bnBRdFhyMFp2bWZZVGlpVXoxZEhEanMvZExLWWo4SVNvZngy?=
 =?utf-8?B?SkFYbkwvRFNDcnpyT3V0STg5TjFJbitUcEFIN0lPRGNDUFM0eGZ6WCt2S0Z6?=
 =?utf-8?B?Mkc2UWpLNVkzcGNuKzlzN3lGVFd5My9LdG4rYVlvenpRck9hUGNPTzVnZ0F2?=
 =?utf-8?B?UmJmSk9qdGJETzlmaWk3WkdyclZCMGJ2bGwyRHVtVUVtQ21GK3kyWlNLYlZI?=
 =?utf-8?B?MSsyQTl4dGZFZWFRdk9YdVE5clp6cXhRZi9CYlY2ci81cnAxclF2ZHlORXha?=
 =?utf-8?B?NkV4Tjc3eWl3L05zRkkraDJHSzF0bklvdXh4RUpDdGVRckVjeHVvU1dVVlJ0?=
 =?utf-8?B?VGl2K1pERGYvQkhibFAyU2o4Znc5YkJhMVoyUE1KVUVMcTR5ZmVFc0RlLzhL?=
 =?utf-8?B?MlZHOGtzeXpNVjc0VGRoM243bzRYOGxieGRUUHdMUkdBbnFaNDhjcW1OSzIr?=
 =?utf-8?B?d0NTVk5vanBrS0hXU1UxbkV4aUlDeGVmWHhudGIxUWxzTm9ud21LenI0OVR3?=
 =?utf-8?B?OTRrdzhkTXJVS1JQM0hVMlZuby9KT0hsTkx0UDZrcndHVE1oVThJUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c9d13ab-c400-4bf6-7367-08df3fc85476
X-MS-Exchange-CrossTenant-AuthSource: CHAPR12MB999225.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:49:35.5631 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DDbXD4bWOeqXxfMMmKRKt9uB74JfUj09mSS2poEpozBU82y+t1HQ4KNSqS5tWrMm/HsSSErF39QdtLx/OPE7Yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7995
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

Reviewed-by: Ray Wu <ray.wu@amd.com>

On 11/4/2026 5:55 PM, Hugo Sales wrote:
> backlight_millipercent_to_pwm_legacy() takes the floor index into
> backlight_lut, which has one entry per percent of luminance. Any request
> between two whole percents gets the PWM of the lower one, so a PWM panel
> has at most 101 brightness levels however fine the request is
>
> Interpolate linearly between the entries on each side of the request.
> Whole percents still give the LUT entry. The result never decreases as
> the request grows, since validate_ext_backlight_caps() only accepts a
> curve whose signals and luminances strictly increase, so the LUT never
> decreases either. The linear curve bypass and the 100% case are
> unchanged
>
> Signed-off-by: Hugo Sales <hugo@hsal.es>
> ---
> amdgpu_dm only hands the power module whole percents until patch 4, so
> on its own this patch changes no PWM for it. Coming first keeps patch 4
> from dropping a level to the whole percent below
>
> With patch 4 too, on the GV301QH curve with minimum 12, the 62452 levels
> from user_min to user_max reach the panel as 57821 different PWM values.
> Without the series they give 99, and patch 4 without this patch would
> give 100. The bottom tenth of the scale goes from 18 PWM values to 5434
>
> BACKLIGHT_MILLIPERCENT_MAX is defined at the top of power_abm.c as
> 100 * 1000. mod_power_create() sets num_backlight_levels to at least
> 101 and allocates backlight_lut with that many entries, and nothing
> changes it afterwards, so index + 1 stays within the LUT. The function
> still returns early with fewer than 2 levels, as
> backlight_pwm_to_millipercent_legacy() already does
>
> KUnit: dm_test_pwm_lut_between_percents, dm_test_pwm_lut_monotonic and
> dm_test_pwm_lut_min_input_signal from patch 6 fail without this patch
> and pass with it
> ---
>   .../gpu/drm/amd/display/modules/power/power_abm.c  | 29 ++++++++++++++++++----
>   1 file changed, 24 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/gpu/drm/amd/display/modules/power/power_abm.c b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
> index 5e86889eaa841..d9c1f1401b604 100644
> --- a/drivers/gpu/drm/amd/display/modules/power/power_abm.c
> +++ b/drivers/gpu/drm/amd/display/modules/power/power_abm.c
> @@ -524,6 +524,9 @@ static unsigned int backlight_millipercent_to_pwm_legacy(
>   {
>   	unsigned int pwm = (unsigned int)-1;
>   	unsigned int index = 0;
> +	unsigned int lower, upper;
> +	unsigned long long scaled;
> +	unsigned int remainder;
>   
>   	if (core_power == NULL)
>   		return 0;
> @@ -541,17 +544,33 @@ static unsigned int backlight_millipercent_to_pwm_legacy(
>   		return pwm;
>   	}
>   
> -	if (millipercent >= (100 * 1000))
> +	if (millipercent >= BACKLIGHT_MILLIPERCENT_MAX)
>   		return core_power->bl_prop[inst].backlight_lut[core_power->bl_prop[inst].num_backlight_levels - 1];
>   
> -	/* This will give the floor index. */
> -	index = ((core_power->bl_prop[inst].num_backlight_levels - 1) *
> -						millipercent) / 100000;
>   	/* Null check otherwise eDP doesn't lightup when connected to DP1 */
>   	if (core_power->bl_prop[inst].backlight_lut == NULL)
>   		return pwm;
>   
> -	pwm = core_power->bl_prop[inst].backlight_lut[index];
> +	if (core_power->bl_prop[inst].num_backlight_levels < 2)
> +		return pwm;
> +
> +	/*
> +	 * Interpolate between the two LUT entries around millipercent.
> +	 * backlight_lut has num_backlight_levels entries, and millipercent is
> +	 * below BACKLIGHT_MILLIPERCENT_MAX here, so index + 1 stays within it
> +	 */
> +	scaled = (unsigned long long)(core_power->bl_prop[inst].num_backlight_levels - 1) *
> +		 millipercent;
> +	index = (unsigned int)div_u64_rem(scaled, BACKLIGHT_MILLIPERCENT_MAX, &remainder);
> +	lower = core_power->bl_prop[inst].backlight_lut[index];
> +	upper = core_power->bl_prop[inst].backlight_lut[index + 1];
> +
> +	if (upper <= lower)
> +		return lower;
> +
> +	pwm = lower + (unsigned int)div_u64((unsigned long long)(upper - lower) * remainder +
> +					    BACKLIGHT_MILLIPERCENT_MAX / 2,
> +					    BACKLIGHT_MILLIPERCENT_MAX);
>   
>   	return pwm;
>   }
>
