Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7B3CCD5BD0
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 03:09:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1156710E44A;
	Tue, 26 May 2026 03:09:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="EhlosBvB";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012054.outbound.protection.outlook.com [52.101.48.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 09CFA10E449;
 Tue, 26 May 2026 03:09:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e7Dgb9cR3eqgks9QBLF+GfUa/t3Tm4YKVJwTFK5N6fMLvu2SgnIYxOFfkFMF6H1DTDuH7JhDKM2o7SkE5WM8ghTQtj2j8OM0qN8S7C52donY6o59tEc+I0QYQKlx0K7SxQCAb4kuD/3KU4QXVCb12xR/Xd+mBKgfaiqE3x6HlxX7bfviz5tfpICUZyYGVG5R5+jAjxvYhK4UqjPQGCs9HRhcWo5SqnI3Tv9SBKBYanVafGWEBcWfMjonqf/MTW/a9KxsBUjZJS6YHAmqkVdck3ITDISRknNp00qIs3d6z3SirJfgL1TWRk2vv8/dP/S9X+NrdXg5d9eN7XhSpRKiQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qP4QFh8B+LbKBUkWOuIjhJzAQEBdBNLslFRhm15mnrA=;
 b=BfsIJNq6NCy8tn/QIgOtzqxZxTiHe/WgXbtsm2Fovx0kuiPtJUfeGIN+ooVnpgwMvKypiIm+G4WVX2EdOiPVHb/3pvDgfZxf+qXKuSvq8nwj2CC16jw7c1ffBT4sVTX/9kzswsC/z0GzALhvPUS/Qd+JbdHEc81TyI0L5R2kfONOAVMRpehEdlEgTRBNwt8b/f3PCBfRokzQvbtWxFo0Qqg01qoJhz/5le0DZLAlPphiGRgrqx7/ZAUW2h7N+9XYReASGXSpNmdfY3BkceOiRIMCjFQaALLDF2MvNrzhqUNYl5La3u6ODOJ14q10boQ0bz9uH9dhXFdhYTxUkK46Kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qP4QFh8B+LbKBUkWOuIjhJzAQEBdBNLslFRhm15mnrA=;
 b=EhlosBvBRe/5s+xtAXwZvjIOlWZcPb0VyEKmpo1ugjXKYZBnAK3vmYXKOTzSS4hARsZD4hbQAeG2OF4Dc1mJ6mOCFIdTHlyX6BAHnnxOC9tetvmHNiP2qGJJDgbKyamOCbpXwzc7ncPZCs7OV5UaYtV4ofTyH2SEB9fkGD3nJxg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 03:09:40 +0000
Received: from CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96]) by CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 03:09:40 +0000
Message-ID: <dcfcdeda-0592-42e8-b6bc-34e797fca21e@amd.com>
Date: Tue, 26 May 2026 11:09:32 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] drm/edid: parse panel type from DisplayID 2.x
 Display Parameters
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>,
 Jani Nikula <jani.nikula@intel.com>
References: <20260526030254.1460480-1-chen-yu.chen@amd.com>
 <20260526030254.1460480-3-chen-yu.chen@amd.com>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20260526030254.1460480-3-chen-yu.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0183.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:be::8) To CYYPR12MB8892.namprd12.prod.outlook.com
 (2603:10b6:930:be::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8892:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c59fda-7da5-4643-31ef-08debad43a0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|6133799003|3023799007|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 51z5YGFee26F5pNlcfSNyKlDthC0n3c5bz9D3wSBiH6Yiw+69W/Z89jwRhBavtL+wb8jj9j26I8zddqEif9Ur5aAPPv/Lw9EwHHrEuybfZ67blowaPsPhwVFDErrtL1UY/AWovoEcB6f976oI36pdO/dWmnDJpc9Q98wjIvGZh64OAvdHnVaf10FaWRpElQyLHRWSGqjlN/aepnm2kYJAJfVpIwENTLKQOJkdmL428PkRykhKiRPaUW+aO5K3O+Dyedv7K2Dam3CjSBJqX6iaMYSaZvGJcMTTpSKKbYlK5nR1+hxbf4PrWk/qEQ4xPaCRsmbUnJ+YkwL/F0M8wsxyEjhnJDxoAmOHAdG0jCKmyLsmXhAsR5WnFFwoA8mNYFsNuhHN07EuP0izemzC8ChDSuTBkrp4wnfSbw5L6j19Io1aNt+NIOM3QU8+D9/Qdl0nLNrmGkd6CLlSJsXHCXGomt96nyeOtONrXmSaTvy23Gsw9VhG2waubaMnWgig3Zsjkdt1sTkY1k6CsJKANETAZs6V0ZafoV+27HXdgsN78ccUr0f+IAT6vWg1hQvRAP77365Y/tsSBEETtZYCjPGTs4aiP/CpaE1cAtqVSH5VKdv9wCQYW5SSxgmMwMbkS69w73K3aDd9PRVwEu/N2+yk/1KnsWf8u9MfaPNzKOT3i0sIXXOakQie/cDTA2c0MNt
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(6133799003)(3023799007)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ky9YZ3JnV2hkVS9udDNjZmtsb1crUTZPQklzckVORkQ5Z3JDdVJjQ09Hc3Fv?=
 =?utf-8?B?eXRPWjZxSVZZaWlhL2p0T0Jxa3hjaVFDT3Z0a1ZSSVhQamVMZTEyakQ5bDJP?=
 =?utf-8?B?NDVFRE9lYUJsVlNJM3phT05lcUVaVStFdXg2YTMrTTN6UXNrT2FDN1g1d294?=
 =?utf-8?B?S0RuVXlib3BmNmNsb1doV2VHSXNzZlI3Y29TY3JsczNIVFFoeXc0Z0VBTlEy?=
 =?utf-8?B?MDhpUnNLaU5QQWFJR1ViTG14K1M2bDJSMU9IQng5OFNiT1M5d05LU014Q3Fn?=
 =?utf-8?B?ang5NXFqU242K1k5MFVWVGd4dGk3US9WeTNJTXBmT2RCQnhEMmVxYkJoMFBU?=
 =?utf-8?B?YzhEdUNjSWtyV0ZrYWw5dW9Ja1dVM21WOWIrZE9Cam1Oai9UOElOYnpQNWRU?=
 =?utf-8?B?TWlZYjFOUVdlYmM3Y1NZaUtWbzhXKzNOUmF2ek9RNllsVEFaVmJ3OWVEeXFn?=
 =?utf-8?B?a0dqUHlsNVhZS21hMWJNeHV3Wit6c3dKeWNVd3V3N0JIcGpsZjVCRlhFcnpO?=
 =?utf-8?B?WGdVR3BBTm1wZ1VnU01mOHdhb3RlbUpVR1Z1eklYQVdHYzIvazRJVzd3NzVq?=
 =?utf-8?B?c0R2NEljdElubkJaamhjWHdtaDRqV3VBUEdOQUgrWWVBc0NxcHl6UlRwU2ZE?=
 =?utf-8?B?TExFRm1JcHFpY0hZNUt3OW1RaWlkM204Rk5RZWQzVFg0TjFBOXVBMGxjaDNj?=
 =?utf-8?B?a09XeUlRWGN0bVRvWlVUdVdEV25aSXZhWEVpL3N5QVU5VW5kSWhiUVNsNDNI?=
 =?utf-8?B?M1I1N3RRV0p1QmhXbm1kSFAzL2JYNUJaa1gyR080SzQrQlJUUUgxQkZPa0J1?=
 =?utf-8?B?QVZseURvUDNmSkNkYkRCdUs5WUtUNDdoMlZqczR0dkdEcUhKd2VEWSsrSkNX?=
 =?utf-8?B?VHJ2dHVaQktzL2ttYWpqS2ZLYmpFOGU3dFNybkZRV1JVQjhnczhhYktod2gy?=
 =?utf-8?B?SzdWUFptaDFiOTRCc0RUVW5IN2hZQWhCR1BmWm1QVkNCL1dRaFc1TXhjbWd6?=
 =?utf-8?B?VytqWllNNVJuZWlmd0ZwUmhaRGJpZWtxNWw3ZzladVlTVWR4S3VnaG5NeXZV?=
 =?utf-8?B?L215M3BrR001Q2g1a01BRjJQYmY4aDdBbldLQmhMNFhWQlEyclhPWm5oYURy?=
 =?utf-8?B?QmlsaXpHcDVkQ1N0UFJ2T3FFUCtsbFpKSjFNVEQvWDFINE5Pd3FwVnYvYjFN?=
 =?utf-8?B?N3BqQmlCbkUzeDRmSmlIZjFqcFVlY3RUSzdEaDNYTW91NDRoVkZReDdidXZR?=
 =?utf-8?B?ZDZHOWgzVEs3R2w4TzkyN0FCT2JXWU4zUU9ybUMyNXNSZDhIWitIUTZRdlIz?=
 =?utf-8?B?R0dEMTA4a0xEQ1lLcmFUZ0hOVXVLSW5pVjZQQ2U1Y21Vb0N2dGIxNWZJMXFm?=
 =?utf-8?B?UHgvblhsT2QwWkNHR2FvUlhqSU5FQWtIOHI2Qkx2eFFmOFAyeG9hWDZJWXB5?=
 =?utf-8?B?ekt3OWpPNnRhQ3c0MUdwVU5yS1RCdUNsNmxNTVVHL1FJWWdNTnJTTEEzOFJi?=
 =?utf-8?B?RU8rajFmRWY5QkJvZEpvd3FRcFY0OVZZMEhuTXY2S0dwMGpZdFNJS2VOTEVa?=
 =?utf-8?B?eElkby9WekNHSjFtS05OVWRsVndXQ1F1bkJWQ1pSMTVrb2dBaVZHb2pqQTNF?=
 =?utf-8?B?VFplM3pCWGxqakkzV0ZWZ1paRmVEcm5SU1NlRGtHRjJSS2hjWURlZi8zY1BG?=
 =?utf-8?B?YU1aVVVnbStYNFpJd0I1c2RVK0xuOGRKdDRMUU1ubm1RQnhvVXIrMnJYZkJY?=
 =?utf-8?B?Q1JHZUxFTTBwUStTU3VIM0F2eVg3bUtFS3VhQngxV25mWVVoTi85ZkVJWTJy?=
 =?utf-8?B?QjUxRXYycldyVXBTYmxWOWZRcWRHa3VSYWNvcFlYdmFiRi93aDdXUDY0Qi9v?=
 =?utf-8?B?bDNJanB5UXdQZ0orbmxya1gvTE5zN2RaQ2ZXWWVGSnV3WlhWeXVWSDZ6THds?=
 =?utf-8?B?MGhQdGtPUWlNU0xMbHNYeU93T3lFQWE0UlZ2MFlFWFdQWFdnekQ4RnU0a0or?=
 =?utf-8?B?S2Y1UkNNRzdmQUpjWitwK3diQ0Q2WDhPbzdhRjhOd3NDMm9VaE9LN21RcEQx?=
 =?utf-8?B?cndCN0lmVkxFNVJqU0J3MGw4L1RYdXNMWUZQTUc5bmZ1V1hvQ1lNZkJFczJY?=
 =?utf-8?B?UVBUU3Vjb0ZubG1xUEd0WWQ2THAxOE1DVWpKYUEzWHYwOFRheEVlQTduaTV2?=
 =?utf-8?B?ZzFRbTErbE8rSU9ENS9Jalc2MXV2TmVuVmd1TmlNbVVOd3l6eG4wOXhDc1dp?=
 =?utf-8?B?bmQ2TWJ3OHppK2tOM0ZoMGFYaUhxWHg1WFc3WjcxNlpybHlHam1PVkJtZGY4?=
 =?utf-8?Q?EU3W/qMyYOXIlr8ytQ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c59fda-7da5-4643-31ef-08debad43a0a
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 03:09:40.5773 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ivwwo6M9cQyj+26fr8UCAjr0OrEwEzcsodoC9qNmgdAefcaZKb01cWHaNv88nq2olB20QBiOZL8bvpTPSzgrlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5987
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

I forgot to include Mario's Reviewed-by in the commit message:

Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>

On 5/26/2026 10:59 AM, Chenyu Chen wrote:
> Parse the Display Parameters Data Block (tag 0x21) defined in
> DisplayID v2.1a Section 4.2.6. Extract the Display Device Technology
> field from the color depth and device technology byte, which indicates
> whether the panel uses LCD or OLED technology.
> 
> Add a panel_type field to struct drm_display_info and populate it
> during DisplayID iteration so downstream drivers can use it for
> panel-type-dependent behavior. Add DRM_MODE_PANEL_TYPE_LCD to the UAPI
> panel type property alongside the existing OLED value.
> 
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> ---
>  drivers/gpu/drm/drm_connector.c          |  3 +-
>  drivers/gpu/drm/drm_displayid_internal.h | 24 +++++++++++++
>  drivers/gpu/drm/drm_edid.c               | 45 ++++++++++++++++++++++++
>  include/drm/drm_connector.h              |  6 ++++
>  include/uapi/drm/drm_mode.h              |  1 +
>  5 files changed, 78 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connector.c
> index aec05adbc889..f2ac4542a7d3 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -1176,6 +1176,7 @@ static const struct drm_prop_enum_list drm_link_status_enum_list[] = {
>  static const struct drm_prop_enum_list drm_panel_type_enum_list[] = {
>  	{ DRM_MODE_PANEL_TYPE_UNKNOWN, "unknown" },
>  	{ DRM_MODE_PANEL_TYPE_OLED, "OLED" },
> +	{ DRM_MODE_PANEL_TYPE_LCD, "LCD" },
>  };
>  
>  /**
> @@ -1508,7 +1509,7 @@ EXPORT_SYMBOL(drm_hdmi_connector_get_output_format_name);
>   * 	never read back the value of "DPMS" because it can be incorrect.
>   * panel_type:
>   * 	Immutable enum property to indicate the type of connected panel.
> - * 	Possible values are "unknown" (default) and "OLED".
> + * 	Possible values are "unknown" (default), "OLED", and "LCD".
>   * PATH:
>   * 	Connector path property to identify how this sink is physically
>   * 	connected. Used by DP MST. This should be set by calling
> diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
> index 5b1b32f73516..6f431aafafcf 100644
> --- a/drivers/gpu/drm/drm_displayid_internal.h
> +++ b/drivers/gpu/drm/drm_displayid_internal.h
> @@ -142,6 +142,30 @@ struct displayid_formula_timing_block {
>  	struct displayid_formula_timings_9 timings[];
>  } __packed;
>  
> +#define DISPLAYID_DEVICE_TECH_UNSPECIFIED	0
> +#define DISPLAYID_DEVICE_TECH_LCD		1
> +#define DISPLAYID_DEVICE_TECH_OLED		2
> +
> +#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)
> +
> +struct displayid_display_params_block {
> +	struct displayid_block base;
> +	__le16 horiz_image_size;
> +	__le16 vert_image_size;
> +	__le16 horiz_pixel_count;
> +	__le16 vert_pixel_count;
> +	u8 features;
> +	u8 primary_color1[3];
> +	u8 primary_color2[3];
> +	u8 primary_color3[3];
> +	u8 white_point[3];
> +	__le16 max_luminance_full;
> +	__le16 max_luminance_10;
> +	__le16 min_luminance;
> +	u8 color_depth_and_tech;	/* [2:0] depth, [6:4] device tech, [7] theme */
> +	u8 gamma_eotf;
> +} __packed;
> +
>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>  #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
>  
> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
> index 7ad3f939dbe6..a9d480981c8f 100644
> --- a/drivers/gpu/drm/drm_edid.c
> +++ b/drivers/gpu/drm/drm_edid.c
> @@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
>  
>  	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
> +
> +	info->panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
>  }
>  
>  static void drm_displayid_process_base_section_header(struct drm_connector *connector,
> @@ -6731,6 +6733,45 @@ static void drm_displayid_process_base_section_header(struct drm_connector *conn
>  		info->non_desktop = true;
>  }
>  
> +static void
> +drm_displayid_parse_display_params(struct drm_connector *connector,
> +				   const struct displayid_block *block)
> +{
> +	struct drm_display_info *info = &connector->display_info;
> +	const struct displayid_display_params_block *params =
> +		(const struct displayid_display_params_block *)block;
> +	u8 tech;
> +
> +	if (block->num_bytes < sizeof(*params) - sizeof(params->base)) {
> +		drm_dbg_kms(connector->dev,
> +			    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
> +			    connector->base.id, connector->name,
> +			    block->num_bytes,
> +			    sizeof(*params) - sizeof(params->base));
> +		return;
> +	}
> +
> +	tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
> +			 params->color_depth_and_tech);
> +
> +	drm_dbg_kms(connector->dev,
> +		    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %s\n",
> +		    connector->base.id, connector->name,
> +		    tech == DISPLAYID_DEVICE_TECH_LCD ? "LCD" :
> +		    tech == DISPLAYID_DEVICE_TECH_OLED ? "OLED" : "unspecified");
> +
> +	switch (tech) {
> +	case DISPLAYID_DEVICE_TECH_LCD:
> +		info->panel_type = DRM_MODE_PANEL_TYPE_LCD;
> +		break;
> +	case DISPLAYID_DEVICE_TECH_OLED:
> +		info->panel_type = DRM_MODE_PANEL_TYPE_OLED;
> +		break;
> +	default:
> +		break;
> +	}
> +}
> +
>  static void update_displayid_info(struct drm_connector *connector,
>  				  const struct drm_edid *drm_edid)
>  {
> @@ -6744,6 +6785,10 @@ static void update_displayid_info(struct drm_connector *connector,
>  			drm_displayid_process_base_section_header(connector, &iter);
>  			base_section_header_processed = true;
>  		}
> +
> +		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
> +		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS)
> +			drm_displayid_parse_display_params(connector, block);
>  	}
>  	displayid_iter_end(&iter);
>  }
> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
> index c398dbc68bbc..745cd917fe40 100644
> --- a/include/drm/drm_connector.h
> +++ b/include/drm/drm_connector.h
> @@ -899,6 +899,12 @@ struct drm_display_info {
>  	 * @amd_vsdb: AMD-specific VSDB information.
>  	 */
>  	struct drm_amd_vsdb_info amd_vsdb;
> +
> +	/**
> +	 * @panel_type: Panel type from DisplayID Display Parameters
> +	 * Data Block (tag 0x21). Uses DRM_MODE_PANEL_TYPE_* constants.
> +	 */
> +	u8 panel_type;
>  };
>  
>  int drm_display_info_set_bus_formats(struct drm_display_info *info,
> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
> index 3693d82b5279..d7ca1040b92e 100644
> --- a/include/uapi/drm/drm_mode.h
> +++ b/include/uapi/drm/drm_mode.h
> @@ -169,6 +169,7 @@ extern "C" {
>  /* Panel type property */
>  #define DRM_MODE_PANEL_TYPE_UNKNOWN	0
>  #define DRM_MODE_PANEL_TYPE_OLED	1
> +#define DRM_MODE_PANEL_TYPE_LCD		2
>  
>  /*
>   * DRM_MODE_ROTATE_<degrees>
