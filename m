Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F0CACD5BC9
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 03:10:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9229D10E44B;
	Tue, 26 May 2026 03:10:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="PV3ODrNS";
	dkim-atps=neutral
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012015.outbound.protection.outlook.com [52.101.48.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9944C10E448;
 Tue, 26 May 2026 03:10:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqnOnGWWRGcBZtuyeRFcMH/52A7DR6FgQV+SKR8tUbcFg2F1INqY/jPB3Ghe6G0sb/3+TvyfFAW9jNYDfn5lQ085p5ayD7pNBzmtS15byEHUwu/gw7jiZWEZ446f5UZGRxYQNdIfq8pBxqZjBM3X3jZ3WSQgmMIQHoXxdEFqt7XzkN/DhHM5ngfsGQhl1E3nSwrKY4nDXV8G8u5xrCzuNfrzogSa2B83mDgQQO5YaA2Fj0J5j7/z9cs8VN4HSplEPLngdbsMnMnw2Kapp2pXUMJN/IXqHVERS3ZvmMVrLdC4E07myFJMC01TJl3esRDNZKDs0Q2ucAwwnz3/R5XMnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ohi9g3ox2YWhB8QJZiRYVTJbzBs5AOvCZKP7nKaNKrk=;
 b=mYgtuiYDXwW89Y2CYXSSREiMzU3jSuhX5Kh5eB6pIJQeFTUArFIsju6o07RLmSXgKznhvxXdaGy1a6gDi5yswOdqrNCUVxjbOFWEvz1z1raGgmFsylwcOI8LTHC4rDNjb/QDrYeWEurIIx0iKT/ZswY294ZNJe1d46AFth0Og87+l6mc9MSDYYHcGZ65fBQkBnfmDQ5TdTHb4CfryTisJBU28nHcWsVVP02UcY8U427ap4AVlLG3mnHxRaBs7jKhp1XBcrW8Dw434oEOTsFE0q9wUX9/B/BGLHILHv5dD0JI5icdgw+KHN9Rk9PK9FDCHXyMOIkkxeuq3JVf4Qc/VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ohi9g3ox2YWhB8QJZiRYVTJbzBs5AOvCZKP7nKaNKrk=;
 b=PV3ODrNSLmMhpsIZL1wpkQKwTE60sBxToBbpdeOAA9TTyIG9/Ls8dC4v3y+tSjSCPp73eGuWpKt/bDRJunsFa+5+ABPGbzcsMMWPpE8KSaI89AYzSzYynANuCVVQ4sVTU8IZ2iJTeLx2F2WldiaZZkvDVQEGFejcEs3NO0s80hA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 by DM4PR12MB5987.namprd12.prod.outlook.com (2603:10b6:8:6a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Tue, 26 May
 2026 03:10:00 +0000
Received: from CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96]) by CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96%4]) with mapi id 15.21.0048.019; Tue, 26 May 2026
 03:10:00 +0000
Message-ID: <d2516fce-bb18-4384-9864-51c246669614@amd.com>
Date: Tue, 26 May 2026 11:09:52 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] drm/amd/display: use DisplayID panel type in
 dm_set_panel_type
To: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>,
 Jani Nikula <jani.nikula@intel.com>
References: <20260526030254.1460480-1-chen-yu.chen@amd.com>
 <20260526030254.1460480-4-chen-yu.chen@amd.com>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <20260526030254.1460480-4-chen-yu.chen@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PN3PR01CA0132.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:bf::16) To CYYPR12MB8892.namprd12.prod.outlook.com
 (2603:10b6:930:be::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8892:EE_|DM4PR12MB5987:EE_
X-MS-Office365-Filtering-Correlation-Id: 9427a80f-ad65-4660-e530-08debad445ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003|6133799003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: 4jeDe4qiiBW59kr95wVhAuu1KgcNgltNzNkRc5jftg470yNqPa1qJmWRzNA/gx5g9jPrDrb7Q4SOTk7E5GhVS7pvppHmdu0jBJVF8PtCsbdLkpP75VibCiJYhhDbXrSgAIYZjbCVMlbmXWNE6kGCs550EaqRlAPv1DhPiLirjq3IOTkVeYavD+UktLdEogwLyHaXCV62j5hYhlDZ5wn+9SE234l6A7dAspzqCneQ61wqHsktes/a7IqwtUfWdJOlru4I+hgtebhldbVG9fdT6OOson5AtMlvA0AZZLPoBo2smeGTQcx7ezMf+UFyUVwiK6cR4yAhaHLgk/hrByOtNYYvHy+pu+8k2CxaNAbqisH7bKVZDWTSCcjqKoq41Akqvg6dBTJg+Wk1ABhhsVJY91TyTLtjah29Gev9/f9soGIf6SOjPVkRj4h8GTuSgEORxC4R+yJ/I0RB0JLamZWIBee0IxdI5C3vcbOuWSzd8uKz3c/syAupYJZZF/puvh6vflNhraKbesu9sxbp9LLCDq8FnXk/tclOuV67v/UunEK3gi+LMVMJi1r9LQBwoXr3X72vBcAdaOi3gYEcHOkWyKZWN5txo65kOM4TM5l04YERTqd8OC65+Ule92XeelX+kOVsAtqIzA7o4KCPIjqNGWa5NQvrAaQBRNpFnisucuUg5w63i9zBxzN3RuTwn8lR
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003)(6133799003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VVZadldsVFZKOU84TXY2Qm1ONmhZbHplTDBPSE9tekduU0dXVEhjTGcxa0lF?=
 =?utf-8?B?a01pTExOMWpSbzgwZWJTbEZZNEFScDYwbmJxcmwySm1UVUZlRWdUUVNUb3Az?=
 =?utf-8?B?VHQ0L0JzVUw4ajNYMDZhL3h6Vk5ibHhMT2V4Z2YxbzZnRzNtQ21SMTdTSUhk?=
 =?utf-8?B?OXJUZ3hFUDBBejNFMytpeFZhZnUwYmc5Y2piTmt1ZnZWV1c0Wmg3SDVDZHN1?=
 =?utf-8?B?c3NjQkxZZ0lkRzZheXJWVUVaRWY3UG02MDFRM2JyekFVd1Yva0gxTDdWUTl4?=
 =?utf-8?B?c3FFV1o1c0dpQXVEVC9ySEp2UnpqZ3JLOUZEVTBMQ0N5T3lEL1FJY3l1d1Nw?=
 =?utf-8?B?UWtTK3M4ejRKd0hBTys0Ylp5ckZ5MFhwME9QUkJlN042d3RYWWpXRWRrNFRr?=
 =?utf-8?B?UXJHb0VTTVhSNHpLR1lqdVNueEpMaDl0MlEyNzA5cDdCQWJMcmRGNTgrM2NN?=
 =?utf-8?B?NGtGRmpRbEdaRXhBS1BrZjdIcWxMOHNDVzIvdm5JSmQwWlpQbUx1V2dTZVRX?=
 =?utf-8?B?dmVSZWhFdzQzdDk0aFE1K3pBVzNDaE56NS9DYi9pSld5NXovS2UycE91YjQ4?=
 =?utf-8?B?YzZqdm5ld3VnemxXUWdDSTZ1NGlUeU0wK0d3blNjRHNTYnlrOUJCQ0xhTjF4?=
 =?utf-8?B?QmhOamNTRDN5NERxbk0rTHFEVFpTVndyVWRoc3dUZHByK1VPcExiMkRhdFph?=
 =?utf-8?B?R1BLVkFCenZmR3RVUzhZZlE5eHgrVlRwWDVDZnA2ZWdSNG9DdDAxR21xbzM0?=
 =?utf-8?B?cENhbi9EMzNMbmtqempPamszTUpnb0lJbjRRZ25DU0RadEF5SlQ5MzJhQzcw?=
 =?utf-8?B?bzk5V0s0NTBQeFNoT1F6Vk15ZG1BUjhGMTZFMUxTemlqUTVkK3QvTEVHeEh1?=
 =?utf-8?B?RDB3UzRGeVZDdjVGSFBoQi80MW15cXE3RE4vVzRydlBlSkNYa1hibzltNURQ?=
 =?utf-8?B?QjhUMVdyWjhNV3dCMmtScFM5bHlQd2ZrNGZIVlBDK1d3MkdZclgxUkI1THU0?=
 =?utf-8?B?RFFHOVpobUtoL3NaTDFKNDc1Qlp5WDJBcnRWV1NWank4ZW55MjNkYW9tc3g2?=
 =?utf-8?B?a1czWTBhQjI0S1BONkVnOTFqc001QlMwa1RMNjBnVm9NcncySTN0OVFMZFZD?=
 =?utf-8?B?QVdCS281cGpVaUN0dUppek4zVWFsbk9vdFFTa1FTMGJUYjhaTitNOUlsK3Y3?=
 =?utf-8?B?cjFuSDhVOWdIVWRkbmdvRlZ0Y290TDZDV29IaHlzQ3c3WE10YVpWMjMrbVIw?=
 =?utf-8?B?R3p6emdoUWE3VGtoWFRMK2tVdGgxYzRGYTlsblBSWEVRTWhubnFOTVBtbmlZ?=
 =?utf-8?B?RkpUZDJqQUREamFhdUpEUnFWUlZCSlo1MFlRdGxvbm9HWG5rZktyYURkN1Rz?=
 =?utf-8?B?YWtGWW9GZ2RFZFlBYlVZZ1g5MFZ5dk1jQXM3R3ZBZzhjS3lmOTZ2MHVRbWNF?=
 =?utf-8?B?S0diWHE3NFBnYlZBN1NxY2xCM2JRYnBuaTQ0MGtuNTNFS0Q1OGJxNVl6ekVp?=
 =?utf-8?B?SW1ZMkdhK1NOWmxpUW1KZjB5SWFpOGFybW5tcEV0ckVvMThKTVA4ZStJdDRk?=
 =?utf-8?B?OWhoYjRQRFhWSmpiNU1ORHhGWDNKaFBLSE1mTXd4aXVEVFdSQ3J0Qk0rTitE?=
 =?utf-8?B?YVhlNG9aRWEvcXVMMnEzZVZKcTk4V2h5ZUUxUnJZWENmUERrT08remJINXRh?=
 =?utf-8?B?ODFqMXNxUlViWk5nc004NHh6blVCRmU0NUtQbmlYbW1wc1d6Y2lSVC9mOG9U?=
 =?utf-8?B?dTBudHljOHJodklhOXJlS0VkSk9KbUZ6cmVRY09uVjlsZ0VBaUUvb3loTXR0?=
 =?utf-8?B?NEZla2xZZzBPSHRSaVlPUHlSSkdHK1Jic1c4STd3dGNxT2hudHMrcndoT09i?=
 =?utf-8?B?UG5OTU9yVzhHN2FrcU5JVzRGbEJNWEFJT3gxQkFKRkpxOEZ6REJZeWlTRmNq?=
 =?utf-8?B?WHo5UkNrcXo1RE1jQyttNU54Ky8wUnhQQUQ3eitUR2JQcjhHbjNBaHFwTGlj?=
 =?utf-8?B?T2RIdmFJaXI3WHErOHZNeTd6MlUwU2hodEhrbWpSSUdFSVBlV2VzRE1SRmVX?=
 =?utf-8?B?MXF3b2ROakVwVUhNTnpFemFOSmRwYnNlQWpZdVhCNzEwQXFFS3V2elZOT0dD?=
 =?utf-8?B?NnlEVFREVUtrUmVQdEcvK1E0VmNuc21YWnNGaURDN1JUaHU4VU1wUTRqMU5X?=
 =?utf-8?B?ajFEcnU3Wm43cDlaNVU5N2U4NVVMd0lZY3htcnphaWlnVW5ZU2FodVgwcWZw?=
 =?utf-8?B?Wk1IeWpqQkZqdG1JNnBIVzdJVXJvazNVU05nd1I2TDhwWFdCTE5FODIrTHBn?=
 =?utf-8?Q?dEGY4YZxfOU07IMyAj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9427a80f-ad65-4660-e530-08debad445ca
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 03:10:00.3186 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mtsqcDz8o8ShTo43gv4DsQVWP/WP9IMsUithKCFmmVnEjcGSi8zj3MAY2iMyaYSopvG0UykiZpLIQ5cqrZmhg==
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
> Wire up the newly parsed panel_type from drm_display_info into
> amdgpu_dm's panel type detection path. When neither the AMD VSDB
> nor DPCD determines the panel type, fall back to the DisplayID
> Display Device Technology field to set PANEL_TYPE_LCD or
> PANEL_TYPE_OLED accordingly. Also expose LCD to userspace via
> the panel_type connector property.
> 
> Assisted-by: Copilot:Claude-Opus-4.6
> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
> ---
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c    | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> index e42a5eecdf46..ccf933ed63de 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
> @@ -3944,11 +3944,13 @@ static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
>  			link->panel_type = PANEL_TYPE_OLED;
>  	}
>  
> -	/*
> -	 * TODO: get panel type from DID2 that has device technology field
> -	 * to specify if it's OLED or not. But we need to wait for DID2
> -	 * support in DC and EDID parser to be able to use it here.
> -	 */
> +	/* If VSDB and DPCD didn't determine panel type, check DID */
> +	if (link->panel_type == PANEL_TYPE_NONE) {
> +		if (display_info->panel_type == DRM_MODE_PANEL_TYPE_LCD)
> +			link->panel_type = PANEL_TYPE_LCD;
> +		else if (display_info->panel_type == DRM_MODE_PANEL_TYPE_OLED)
> +			link->panel_type = PANEL_TYPE_OLED;
> +	}
>  
>  	if (link->panel_type == PANEL_TYPE_NONE) {
>  		struct drm_amd_vsdb_info *vsdb = &display_info->amd_vsdb;
> @@ -3966,6 +3968,10 @@ static void dm_set_panel_type(struct amdgpu_dm_connector *aconnector)
>  		drm_object_property_set_value(&connector->base,
>  		    adev_to_drm(adev)->mode_config.panel_type_property,
>  		    DRM_MODE_PANEL_TYPE_OLED);
> +	else if (link->panel_type == PANEL_TYPE_LCD)
> +		drm_object_property_set_value(&connector->base,
> +		    adev_to_drm(adev)->mode_config.panel_type_property,
> +		    DRM_MODE_PANEL_TYPE_LCD);
>  	else
>  		drm_object_property_set_value(&connector->base,
>  		    adev_to_drm(adev)->mode_config.panel_type_property,
