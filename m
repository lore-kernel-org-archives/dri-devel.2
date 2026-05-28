Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37CD4CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 23:13:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98CF110F6E2;
	Thu, 28 May 2026 23:13:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="DYKNmtfX";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012066.outbound.protection.outlook.com [52.101.43.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D9A910F6E2;
 Thu, 28 May 2026 23:13:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HD9Wtd8XPlDprxIQhPsW/Lg9oACNM3AhyLR7N1JS3YaCX57I4DYBCl3EZK/I2dkH8BHh+PQxO7xag8mXXo5gNcI13X4FdcXx/1S5M5E6SKDM0SS6pQU/L83GphZ/Z+1HIwaIzuFi0IjXYIAflj0DCJ78cc0+XoFGeBxGsWSoRbEFhtvrZ/60ZslzaKcZb/L8jBI+OVhZFnyPVq0sJsVqLzCESwlHgdijoCIlz072FM0kYrXcgZ8BSdsSdi0G2nnoogMd3ckahKxS7x7O/3iVW0Qsrm06D7xNiTlpS8OQ55nkFaY/+dKfBfnpmoDQ/sxN0ESitN9/pW2KJk6TeghikA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ado9ctj6dv7im+e1zH6aSB1B4EbGdFYq8k9s2M5CGNQ=;
 b=DaqfUABZHzDfx2QnarJ9+Gsj8w//UWmSnBVpXF1tIxT8q0lVwSnRndrAj+VxXKZrmh0PY46B6ZOQ+lnVLYqvAVpnEb+1oif7TzINmA6WhncDl8cIHkfaY6hHq7gWjbB4bb/n7EbBHnp/L7qm83hMiRyIRQ7qDEkIeWxcP1MZMLhhbGdKLx50qHxsNb0B5SZHyj7xLmbfFFGPDZx1bNVSBJUW2AzY3cPmGBrP6/TejgV4DUXNWjxwED92pnwwvqF+VMOGo4u8BQ4J6eh2ee656vz003o1g8qa+0TU9j6Ppmaak9YgOrhVd3+nfzbnTsYXWaAXEwIMfZx3UTC0+Z3iMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ado9ctj6dv7im+e1zH6aSB1B4EbGdFYq8k9s2M5CGNQ=;
 b=DYKNmtfXr8Ae/1wH3EgHxBuTwkSmHbYdtmBrFY2DaJ6Zjb18ViuljjHcNe9SEVDmSC18R6O8SyvTmoMDdHQuS7gWWxkCDKgzrKdeQYalZEl7MUh06t/X0cH8BcgcOqWFVen1TjyLOw3AKCUOKONGKdDUXVLDmo11OGvKcGcU2Ww=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY5PR12MB6321.namprd12.prod.outlook.com (2603:10b6:930:22::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Thu, 28 May
 2026 23:13:09 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0071.011; Thu, 28 May 2026
 23:13:08 +0000
Message-ID: <4ebe7f6b-aa32-4441-84db-1b09cc69c075@amd.com>
Date: Thu, 28 May 2026 22:17:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Avoid using zero AC/DC brightness levels
Content-Language: en-US
To: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>, harry.wentland@amd.com
Cc: sunpeng.li@amd.com, siqueira@igalia.com, alexander.deucher@amd.com,
 christian.koenig@amd.com, airlied@gmail.com, simona@ffwll.ch,
 alex.hung@amd.com, Wayne.Lin@amd.com, timur.kristof@gmail.com,
 superm1@kernel.org, aurabindo.pillai@amd.com, ivan.lipski@amd.com,
 chen-yu.chen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260526210048.1162477-1-edson.drosdeck@gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20260526210048.1162477-1-edson.drosdeck@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0141.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:377::19) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY5PR12MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 78ad6d15-ab3e-4568-aa95-08debd0eae66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|18002099003|22082099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: Fc0CW0kMhpmBZ+bLhwc9vFzCHwWl3kVGlE34/Kwo9tTelUCqi0ctIT+vjAgCyvG6GtITxp19UzVcjAyO01MSRoRIWYYtmwHJsmDFSbcywf+cmGpUDr8gLSyxosNP7bkU1jKqn93AfU8s3N1AFrb/bKQ86DVIswQ55vJ9yRbOc1ymkzrgrLaSt0TPCdP7gAfTtJg202qkisaG4mAYVD5f7U/UtLiXwoFIo9jB8blduTZp6mUlSi+yCDMZHWt5m84L6jt7jBL3em2+hhYBSTMq6oUWtgOBCJ8eRJUhfdtL67mv65Ca5srBqbPDP/etlO9jDbAst+8XuIERJVScqO2Y3xz0r0H6kb3UD18Lp045lsBq51ilAQ0/ZW+aiOX34Tdmy9WjCus2/RzvwONZ2+PF/beMVDGKQc5q3sm3on4at4Md6EJ3+lcSKp2l+BT9i4vKhvcM0fmuXFqtI1q0/Jsoj4eO/OENqGJwIY9zY8b3DZoLzbMvTJJLMGL9FgX/QFzlBQXN3aeBvpkiV+udyGaWqVvHEcVMkatkW3sUCZWzBbCNiW7phrJsGbs4pto+r1zjnDHvqXHL789kteNZkWy9ONa1uUNg7RugTAYuARxfP9U2ccbgtr5n0tJ3iKu5BQppE3uOc0EA1dR+8BtQs2Td+Fegoyi/BVifFx+VIzGUve++uQIENtUdRZzDvqVX8m+D
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(18002099003)(22082099003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkIrVmExcGQrT1ArYldZM1dxY0ZFVFVleVRVU2wreDR6eVhCbC92Mys5YlBR?=
 =?utf-8?B?U1ZEZVB4WEFZNzdHaWh1TTRXTzFQblZiQzE2c0NuN1llTFJpbVo3VUcyRUgr?=
 =?utf-8?B?YXRVMFBGQjZ6VjFMZzQ5NzRtVjlGMlk1LzYvczRnMm1qTTJvVldYamxmTmI1?=
 =?utf-8?B?MmU4QnBYdzFFTWlXL0g1aWdFeWo1WFEvbkF4MzBYNDhsS3JrREc3cG0yQ0Y1?=
 =?utf-8?B?Q1VFZ2lKcmt3UXJXeDlCU2U3V3dSeE1EKy91REFEcTY2azdNcnNxQzRKUGQ4?=
 =?utf-8?B?QjFaOTVSdkdWSTN3V0hnTmJpUHVnc2srYlB2eFNQMXY4OHkvbjJMcjA5ZDRM?=
 =?utf-8?B?Q1BHYzlRZHNpTW1RSkdBWjN4UXcxSUk0ZXdSNklYSUY2V1RVaWRCNlBJVXFV?=
 =?utf-8?B?QjdHR2xqcGFCcDJmN0R5Z3hGZHBGNHJLT3FxdHVJUzJOdjFOTklRUzRJNnpj?=
 =?utf-8?B?TDlaWDlLamczaE1NQkwxRlJYZTZ5YkQ4YTA0NkZSVTdMcE4zUVROdWhJRjFB?=
 =?utf-8?B?Uk1VRjlrSUIydlpHM0JYdkQ2MGlPRWxpMjhmTXhlMXdIUGkycG9CM204S0ov?=
 =?utf-8?B?K25pSXVEeGtNNjgwVWVHdEdwcDUxZzRmdTVNZXBxSXp3UnhzUmc1MTJWUzA4?=
 =?utf-8?B?Tm1QTmh4MGR3MUlJQnRSZ1p5NG1MNGMzeitZbXI1Nkx3OHhrTmE4SEE0bFpv?=
 =?utf-8?B?YjhXaE5wakJhRkgzT3h3Q21ESDlscXR1REFaOGJTZjBiVnFVcjVFRy83dHI0?=
 =?utf-8?B?VXdMclZ0dnZLdE9WY3VMdG5kdGFZeWJiZUdkazdBNEF2aDM3d05sWVI4SjEx?=
 =?utf-8?B?ZUdlVVBPSkp2K1N6bzlOamxwYitTOUV5dEh6Nyt6RmxSWDRzeExQc3dPN1JJ?=
 =?utf-8?B?REpCMy9lN0ZOK3lvQ1JjWklDRkNmNGtkT3NYTHdZUTJQVHNrUG1zcytUOTFj?=
 =?utf-8?B?WFMzODBhVTFmWmVaQVdEenVHTCtFRXJoTWlkZDhkcWx0SUVhdmxlS1NrY05Z?=
 =?utf-8?B?OUdvS1MrNUpKZE81dUZtUEVxRDBDb1c5UEdLOEY3WGlBZEJ0eExYRWhxK3NW?=
 =?utf-8?B?eGtEOUVUTXlQUk9mTVZ5bFF6RkZNN3U1SjAyK2taM1IvbzNEQ1NzVUJNV1Jr?=
 =?utf-8?B?a1oxMlZVWlBzTTBNTTZ2dWgraE5JNFlFVDc2NnJ3SmRTZmgybTN4UmQrZytj?=
 =?utf-8?B?RzRnL3dFS255U0puVHZWQWk0SDROdUcyR1ozbVVSNlR4bU9aTHdXbG5mYlJV?=
 =?utf-8?B?UVFRMy9oa2pscy9JaVgrbEpTSkNPeHJHUDFCcXBxM25CQmJZdjVVM25SemdG?=
 =?utf-8?B?Slk3NkowdnNRRTk1ZHVvMHo5M2ZSYjRvbVhSeTBoSzhkbFhVbWJXVmdCV1Rq?=
 =?utf-8?B?UC96U0tURFZTUld6YTVIUDhnMUhvMzlzSUZYQWtyQU1FdEVFV0ZUaWxLNkpQ?=
 =?utf-8?B?cnNTeEk0RmlUUW1ZTWNWYk9JUnhzTDdQVGRqMlFoNjVhOEFOVFQ2SFo2Uit1?=
 =?utf-8?B?UEQxTEZHQXBtRXlScDd3K1dKSHVRVXdqTm9mNFo4akxyNURIamhVOTBVVzRJ?=
 =?utf-8?B?SjBrMjI0d0p5TnFGa05aL2ZSY2xFTzFpckRnekE2K2xjQUpQYW5iTGxNcllH?=
 =?utf-8?B?enE1UmlNTjMzRldsdEM4U1haZkowZGszNVhyS2UrSzNqMjRjb3lISEJSb2RJ?=
 =?utf-8?B?NDRUY1VHNFlJWm85RzZFVWRpR05EZVpkRzk1ZVRlTnE4RURaa01lcEZvWkZC?=
 =?utf-8?B?R2ZiRk80VUZqRmtRSHgrb3JRam53T3FhL3NUUjZ2U2lIQXA5UWp3Y0N5dHM0?=
 =?utf-8?B?QXFSWU1FR0gzK3lmOWtGbXJRVjRsOXFrUnFNb0l2UW02YU0vTUZaelJzcnRx?=
 =?utf-8?B?YnhwSWk3eVhOblNQcWpraXc5UktPUFd0TGNKb3hqcEVia1pKS0dJNWUzKzNI?=
 =?utf-8?B?UzFXQVgvM2c1UnlGNmsreGdFSlczWHhlKzhWU04wOWJTYW1UV0xwamVPRDFi?=
 =?utf-8?B?Y3VPNHNhWFBQbi9LTFNOaktvRjZKT0U3dkJzeDdjUjVjRUFUbXZpZlp1SGgx?=
 =?utf-8?B?UkZhNTUwV1N5YVkvMXhhWHF5K0ZCY2hQbkNaVE5zMGttaW1OM09hNVFZbVZB?=
 =?utf-8?B?RlRsYkpGb3lZb0l5dnFReHpWM3JQQXV3dUd2YW9SejBURnVCOEFHdGkrb2Jq?=
 =?utf-8?B?ako3VVNQR2dKZ3RHcFhGdk5QSk9vYXN1UDJERWkzQXd1dEpqU3VMaVFpZVpJ?=
 =?utf-8?B?ZmhTcjdtU1diR01XcXVWR2oyeVlMRjJQclF6TzFlM0VhTUdJSGkzOE1uNE5I?=
 =?utf-8?Q?rQcDzHe2/kgRgyxXRO?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78ad6d15-ab3e-4568-aa95-08debd0eae66
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 May 2026 23:13:08.7875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tv9taUufS4omQWeS3skyhFBF1D+v0KHCukIV/0l8XQp0q/qO7hROE56VFuO/nj7I0d0f52OVx80wRiwcFMsRoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6321
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



On 5/26/26 22:00, Edson Juliano Drosdeck wrote:
> Some systems report zero AC/DC brightness levels during
> backlight initialization, causing the panel brightness to
> start at the minimum level on boot.
> 
> Only use the firmware brightness levels when both AC and DC
> values are non-zero
> 
> Signed-off-by: Edson Juliano Drosdeck <edson.drosdeck@gmail.com>

Can you please share an acpidump and an EDID into a bug report to look at?

> ---
>   drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index 5fc5d5608506..f947ce2a8625 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -5380,7 +5380,9 @@ amdgpu_dm_register_backlight_device(struct amdgpu_dm_connector *aconnector)
>   	}
>   
>   	caps = &dm->backlight_caps[aconnector->bl_idx];
> -	if (get_brightness_range(caps, &min, &max)) {
> +	if (get_brightness_range(caps, &min, &max) &&
> +	    caps->ac_level > 0 &&
> +	    caps->dc_level > 0) {
>   		if (power_supply_is_system_supplied() > 0)
>   			props.brightness = DIV_ROUND_CLOSEST((max - min) * caps->ac_level, 100);
>   		else

