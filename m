Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E15CD343F
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 01:53:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BFDEA10E386;
	Tue, 19 May 2026 01:53:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="lPx0CQ1T";
	dkim-atps=neutral
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 25D4710E073;
 Tue, 19 May 2026 01:53:22 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOpj3L7sH5Y2LE0UoLjOK3YhHi6zJC51ZWIc6i8pvIwxKOcm87qxD72SjAZEbxXnb2MjucEgWE3iJp7n+Pa+3/kS/iWwB5MfjDRroqufySWQdSCmpzrM5p3po/6Lryxg5+iAFi+dJCr+5PBHsRoY1lin5Bg5IfPTuWQxMj8bjk0SGGIpBotVi5lF++NCxkiA0ikznTlBNwR/AsQD2k0xJ/FyHDiLUj5XLPZzTuxfcHJGYdqBdy0fRELbfN77gGcN6aX234+vpOSACtwJHsY/Zptv1ffNfU7oxHmW6I2CGLUY/NrTFrgyFBq0wdgSvBn7cSyjT2AZSIpmJKutOVhU7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sD/g3eYq5ENRlFvQjCe39izNqFeehlQFBE3Z5TGGpTw=;
 b=ZRFi47V1Gn93+2vBYqwoP8YXwhWLG11OpLKmexy/oklSJN/exkruR0qakmVwE/mcRoP1AGVK4cI2AlGDXZnC+BzSLoA8S3ulBaldBIurj9egIGkQLwt9WElTlrZIOOo3EiGpMDYdmahyUgVxRSd4dD5KDXCoCiZ/DFxkzOMQ5oqh2bOenBA8wFgjAdTf9geLw84mweL54zd+XotfHWc0R9zNkQ/dyvA/6P9pN2PZfMpaXHN0q4M3S73NxUxLWWyPhDZ1314BPHmAZ97bSaQjjt5bSjpb3IzpwiSVrBg54LrN56iLYfwx+j9ny0KYlTW1anwQSMfyvq0L2plOuvQz+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sD/g3eYq5ENRlFvQjCe39izNqFeehlQFBE3Z5TGGpTw=;
 b=lPx0CQ1TdQyfSclOe7OEMlBXw7mEhf4MOS93IXJwhcphaPMHP5utDw+z12mfRWR81pASviY72jRQj2yAwAXXv9W7HaohSSLmKUGvPSBhHmRRHseC86vtNSJJDunuKNM6TGJmBsEokOpoATiwuwqsaYsx7ind3oxarEgniPoTZSQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from CYYPR12MB8892.namprd12.prod.outlook.com (2603:10b6:930:be::12)
 by DS0PR12MB9324.namprd12.prod.outlook.com (2603:10b6:8:1b6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.23; Tue, 19 May
 2026 01:53:18 +0000
Received: from CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96]) by CYYPR12MB8892.namprd12.prod.outlook.com
 ([fe80::62b0:b284:c9c6:c96%4]) with mapi id 15.21.0025.020; Tue, 19 May 2026
 01:53:18 +0000
Message-ID: <9ede5b2c-ee6f-40c8-8607-3dcba90a5d08@amd.com>
Date: Tue, 19 May 2026 09:53:09 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/edid: parse panel type from DisplayID 2.x Display
 Parameters block
Content-Language: en-US
To: Leo Li <sunpeng.li@amd.com>, Jani Nikula <jani.nikula@intel.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Ray Wu <Ray.Wu@amd.com>,
 Limonciello Mario <Mario.Limonciello@amd.com>
References: <20260514065606.1151834-1-chen-yu.chen@amd.com>
 <20260514065606.1151834-2-chen-yu.chen@amd.com>
 <8e0c6356a570c55e3df54be6c2d7952dfcee2a06@intel.com>
 <020f60b5-b2c4-494a-a16d-07a700d299f4@amd.com>
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <020f60b5-b2c4-494a-a16d-07a700d299f4@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0040.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::7) To CYYPR12MB8892.namprd12.prod.outlook.com
 (2603:10b6:930:be::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR12MB8892:EE_|DS0PR12MB9324:EE_
X-MS-Office365-Filtering-Correlation-Id: 88d0127c-f426-4e70-a652-08deb54965da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|3023799003|56012099003|18002099003|11063799003|4143699003;
X-Microsoft-Antispam-Message-Info: nEQlTUnM/zsk36p92oIXcu8GH+Ax4/CyI/j27IrIm3vIugfY9H4OvU5eAKZS7lNxurldMQP4ib7y7eRgPIZ7JWJh900bYJHr4AZuqKpkS1rEXHzuB9+o8IanUlTMTNgLjhX63UG0wWK/lk/wMBMaZgRwaUwlO9pBbOIIZ3+k2bJe7F+SZzLLYiVMA7DCoh5QIQNBYU05Yfgwpm29ekXYG5MH4/t6xo4RkkVrfCCmt8QcvB7wc0Q0GCpBiakRV+e0s0D8P+YfL/N548ThiIaCwNnCxWGCKQRP2bwPBKVIDb2FzLd+9l8K8tGZuw5nemCjLp0Cwcx+Ca8eK0RV3xi/enlb816289GEiJMkaAIHnO2nE3WnfLE730nHGQCAZ9PepOYSWtXCMDIVIlwuQf/eLecYf+Sc3NfuBV5Z8Vnlb9y41iaV6IGFANHhuaaXkuvlWDV1kMZa5wW5x5KoLBxYXlDj9Eulf21gdh0kQo4Jdumh7UlezEFtY8SyyCrLOBVauU4bNSUtrK2vgHwiIpYaZV0nvaFAcor9Odv7Mv4gLbef9AZ4Fl6vbJaM1E+2/K20bIDfdSrLU4mN3q6d7ZBqVX8USmelJj/nNC64s/6IYRe+5gT/dOdYjd5fvC6EaRc/9NoIWkxpD+AHOR73ERxoakm6eXc/2ctsZRKPQEdzXFAOaEqAzPnEfaVIZ02CmEyN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR12MB8892.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(3023799003)(56012099003)(18002099003)(11063799003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkN0L3lQVmFjOGVNa096R0hiMTR2SmJ3MDdhRTk4NW1ramF6c3dVa1lrNzFk?=
 =?utf-8?B?aFo4N0tJUGRFbTFCTkxoNFVIMVVYWDFxUlBEWUs0eWlvM0VKM1hBMTR6WlFr?=
 =?utf-8?B?SmdmU1NtOUNoOGxudUVvWXZsZFg5Z0JmMlBWcmRiaXhQbGJGT2lpUVlvekE3?=
 =?utf-8?B?Q0lvTnYrbkFnSldxYTVYVXJTVFg4dlA1OGNSRU5CcGJLR2hobFpyc2JpYWtI?=
 =?utf-8?B?VmM1dzB6ODdLbTJqbm5ubkh0dGVPM2N4d0NDRTBYSjRSRVZnRkhtWTJ2dU9O?=
 =?utf-8?B?SCtIVjRxVmpOa09XU2s5Qmgwbk5ycDVtL0wxVmdsUC90dVhnYzNUeWlXNTVN?=
 =?utf-8?B?RWlGcncrNFdwY3BicXpiOEtReUlGZzhDcXlXOXhxdFdRT2pJRU9SaXhrK2pI?=
 =?utf-8?B?QUQrd0FJNi9DMkJ0RlNzbHJKMzU5Qm54cHBWTmFLT2lHMnRXYzRnUFZWOE5t?=
 =?utf-8?B?MmVBcGtsekMwZS9VclNkb0hZd1hlU1ZLaXZrbHVLa296YTNZbm5KWGN1UU0x?=
 =?utf-8?B?UWtVRnNqNGh3Rm8rMFFtL2w2QzN4UTErRXByU3ZCKytkT2lYRUlTcHJvYzZv?=
 =?utf-8?B?RmNjblk2S0pnczBzL2o1VXVodDI2Q3ZEWHVrYjVHc3k4a3FkS2RmK29xc2Qx?=
 =?utf-8?B?VGxIdmNseXUzV3kvUjhtU3BOM0FpTGtTQmZ4K1BJZHY5S05ubDk5aS9XeXIr?=
 =?utf-8?B?dFdXSkhDTk55Y3dzUDJucEtPT3hXQ3pwQU10Mzh0MXprV3Q5OEpvSzMwMFN3?=
 =?utf-8?B?YXR3MWR3VStndVI0OVc1TGozeEl0SEFYbmZ6Ym9sQVgxWDIxR0VpM2F4TTBq?=
 =?utf-8?B?bGxBUTI3dXRiN0tXVHRmWmNwOTRYK0RXaGFJbEdtZ2VEZWZQKzRpK0RRVEVN?=
 =?utf-8?B?bFdXT3hvdHJPNHUwamJvNlpBTXIxYnhOVzdxSWdFTEhxWTQ0OW5ZeXVwdG1U?=
 =?utf-8?B?aFpNZ2NTaCtvczJaVkU2aGtrYlhMR08wQ2JqczlzYjY5emhta0prWFhBNU1B?=
 =?utf-8?B?SmNXTDlQbW4vUHJxZ21ZMURic0ZzSTZrcEZ1V3kzdEZSdWdLZjVnVHBkbU5K?=
 =?utf-8?B?VEI5ZDlUd1BBRTZIV2VTeHllcmNwYXBrZlJ1S3BrVWpvQTZJZmEybE1OSUNT?=
 =?utf-8?B?Z2RzRFBUbEtJSDUralp0eG9ucEEwbEhudmUxYzNDcmltVXcvdFNMWGo4Z3Za?=
 =?utf-8?B?R0tHL01NYmxsUzlsSmE2N1dpVlZDa0JpUHp2ZUlHTmJXdG9iK3dQblpScUQw?=
 =?utf-8?B?NklkcFA2dlFIbmtuVlRyVVNRQlJjMi9zK2xINklJN2ZmNndwNkR6dnN0Q1hm?=
 =?utf-8?B?WGxSbFNTUUtJNWNEbjYwS3BFUURuV3JINEJEQTZpNFN1RTAxSVlvaWFjck9l?=
 =?utf-8?B?bFNPL1V6M2ExbXFjUXVFc0JudzhpRTZxME1jN3pweUdhMVoyRkQ1UXl0OU9o?=
 =?utf-8?B?UklFVmx3OEtFT1l1d0w3Z2psNWQ4K1hyYmVYK3JuKytoZnYwLzN5ZFpsUGxN?=
 =?utf-8?B?dnUyTFpnTFJpaFZuYktqR1RXRUFEcmc1OXk5Q3RzNjhaUVRBU2N6aG9ubFZx?=
 =?utf-8?B?NXlSSjR3NjhCT2VEeEdJZ1htZnRjS3lvNzloV1BkeXNqNW1qR1pPOEVvODha?=
 =?utf-8?B?VzZEMFJMN0N2SzBORkxFM20rTVBaM2sxeGVOb2ZabVlOVEx0dzJNZW8zT2Jz?=
 =?utf-8?B?K3N6NW83cWRHL3RTOHM0Ulg4VU1CZkdZLzFHZ0pSZWYxQUlRK2VyZVl4ZjZB?=
 =?utf-8?B?WUxWZGVkZXdPNStrdFNpVENzUWY0VEdkOHRCWTNQeWRTVFVXYWllMmtJK1Jm?=
 =?utf-8?B?bzdjL3NpVE9UNGZjem5kUFQ5WjdzbzEwQm45eU9zenhFcWQwZnNVUmYyWVh4?=
 =?utf-8?B?d3R5aFJaTTJCK3lyM21kU3BpWlVKNnFPUVRUUnRlNmRpVnl6ZVFhVkZJQW1B?=
 =?utf-8?B?SG1VWnUwdXhLNG9SSkYxa2R1LzQxZkRCb2J5d1dCQTUzcUF0eUgrWFlRMi9y?=
 =?utf-8?B?SE82aFp2UEpZLzdkVUt6WmxPVXE0emRjSi93YUFEZm53ZEZTOWRXZFhqYzVB?=
 =?utf-8?B?dVdYamZqRHlsUlhuSU5FL0xVY2NOWWZwcnJMN2lHcXFiYWRDSTA5N2VMYWlo?=
 =?utf-8?B?TkdKV090Q2toaEJrQ1lFR0F2N3RlUitnK3ZzY1JJT2xONEJnNlNmeVozWFQv?=
 =?utf-8?B?cG9SRFdyMDg3TmRwMDR2ZURRZkUvMXJJZXU2NEI3eUVFWXM4M2pEdTZYcWdJ?=
 =?utf-8?B?MHJJdVRLWjh2dUQrOURkdjdhNzZ5dnl1dkwxVmhsbXNjdkVPU0UvSnNBMTFG?=
 =?utf-8?Q?N/im1YU9rrptalQEdt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88d0127c-f426-4e70-a652-08deb54965da
X-MS-Exchange-CrossTenant-AuthSource: CYYPR12MB8892.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 01:53:18.2967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fvqGdjO5X1VUaK8OPl3F46kwwocA0n1U+5opVAHlIQTYzCk9kjr7akCp4Ar++n4pySqAXX8qltNSCXxUmsVerw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9324
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



On 5/16/2026 7:47 AM, Leo Li wrote:
> 
> 
> On 2026-05-15 04:23, Jani Nikula wrote:
>> On Thu, 14 May 2026, Chenyu Chen <chen-yu.chen@amd.com> wrote:
>>> Parse the Display Parameters Data Block (tag 0x21) defined in
>>> DisplayID v2.1a Section 4.2.6. Extract the Display Device Technology
>>> field from payload byte 27, bits [6:4], which indicates whether the
>>> panel is LCD (001b) or OLED (010b).
>>>
>>> Store the result in drm_display_info.did_panel_type so that downstream
>>> drivers can use it for panel-type-dependent behavior.
>>>
>>> Assisted-by: Copilot:Claude-Opus-4.6
>>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>>> Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>
>>> ---
>>>  drivers/gpu/drm/drm_displayid_internal.h | 25 ++++++++++
>>>  drivers/gpu/drm/drm_edid.c               | 61 +++++++++++++++++++-----
>>>  include/drm/drm_connector.h              |  6 +++
>>>  include/uapi/drm/drm_mode.h              |  1 +
>>>  4 files changed, 82 insertions(+), 11 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
>>> index 5b1b32f73516..e0f7c54d2987 100644
>>> --- a/drivers/gpu/drm/drm_displayid_internal.h
>>> +++ b/drivers/gpu/drm/drm_displayid_internal.h
>>> @@ -142,6 +142,31 @@ struct displayid_formula_timing_block {
>>>  	struct displayid_formula_timings_9 timings[];
>>>  } __packed;
>>>  
>>> +/*
>>> + * DisplayID v2.x Display Parameters Data Block (tag 0x21).
>>> + *
>>> + * Per VESA DisplayID v2.1a, Section 4.2.6, Table 4-14:
>>> + * Offset 0x1E (payload byte 27) contains Native Color Depth and
>>> + * Display Device Technology fields.
>>> + *   bits [2:0] = Native Color Depth
>>> + *   bit  [3]   = RESERVED
>>> + *   bits [6:4] = Display Device Technology
>>> + *     000b = not specified, 001b = LCD, 010b = OLED, others reserved
>>> + *   bit  [7]   = Display Device Theme Preference
>>> + */
>>> +#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)
>>> +
>>> +struct displayid_display_params_block {
>>> +	struct displayid_block base;
>>> +	u8 payload[27];
>>> +	u8 device_tech_byte; /* bits [6:4] = Display Device Technology */
>>> +	u8 reserved;
>>> +} __packed;
>>> +
>>> +#define DISPLAYID_DISPLAY_PARAMS_MIN_LEN	\
>>> +	(sizeof(struct displayid_display_params_block) -	\
>>> +	 sizeof(struct displayid_block))
>>> +
>>>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>>>  #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
>>>  
>>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>>> index 8031f021d4d0..9b160a878df4 100644
>>> --- a/drivers/gpu/drm/drm_edid.c
>>> +++ b/drivers/gpu/drm/drm_edid.c
>>> @@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
>>>  
>>>  	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
>>>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
>>> +
>>> +	info->did_panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
>>>  }
>>>  
>>>  static void update_displayid_info(struct drm_connector *connector,
>>> @@ -6721,24 +6723,61 @@ static void update_displayid_info(struct drm_connector *connector,
>>>  	struct drm_display_info *info = &connector->display_info;
>>>  	const struct displayid_block *block;
>>>  	struct displayid_iter iter;
>>> +	const u8 *section = NULL;
>>>  
>>>  	displayid_iter_edid_begin(drm_edid, &iter);
>>>  	displayid_iter_for_each(block, &iter) {
>>> +		if (section != iter.section) {
>>> +			drm_dbg_kms(connector->dev,
>>> +				    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
>>> +				    connector->base.id, connector->name,
>>> +				    displayid_version(&iter),
>>> +				    displayid_primary_use(&iter));
>>> +			if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
>>> +			    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
>>> +			     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
>>> +				info->non_desktop = true;
>>> +			section = iter.section;
>>> +		}
>>
>> What is this even supposed to do?
>>
> 
> I think the intention is to log and process the DisplayID base section header only once instead on every
> iteration. Maybe a `bool header_processed` works better?
> 
> - Leo
> 

The intention was to keep section-level drm_dbg_kms logging for better debugging visibility.

That said, I agree that this does not belong in the iterator directly and should be refactored into a helper.

>>> +
>>>  		drm_dbg_kms(connector->dev,
>>> -			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
>>> +			    "[CONNECTOR:%d:%s] DisplayID block tag 0x%02x, rev 0x%02x, size %u\n",
>>>  			    connector->base.id, connector->name,
>>> -			    displayid_version(&iter),
>>> -			    displayid_primary_use(&iter));
>>> +			    block->tag, block->rev, block->num_bytes);
>>> +
>>>  		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
>>> -		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
>>> -		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
>>> -			info->non_desktop = true;
>>> +		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS) {
>>> +			const struct displayid_display_params_block *params =
>>> +				(const struct displayid_display_params_block *)block;
>>> +			u8 tech;
>>> +
>>> +			if (block->num_bytes < DISPLAYID_DISPLAY_PARAMS_MIN_LEN) {
>>> +				drm_dbg_kms(connector->dev,
>>> +					    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
>>> +					    connector->base.id, connector->name,
>>> +					    block->num_bytes,
>>> +					    DISPLAYID_DISPLAY_PARAMS_MIN_LEN);
>>> +				continue;
>>> +			}
>>>  
>>> -		/*
>>> -		 * We're only interested in the base section here, no need to
>>> -		 * iterate further.
>>> -		 */
>>> -		break;
>>> +			tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
>>> +					 params->device_tech_byte);
>>> +
>>> +			drm_dbg_kms(connector->dev,
>>> +				    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %u\n",
>>> +				    connector->base.id, connector->name, tech);
>>> +
>>> +			switch (tech) {
>>> +			case 1: /* LCD */
>>> +				info->did_panel_type = DRM_MODE_PANEL_TYPE_LCD;
>>> +				break;
>>> +			case 2: /* OLED */
>>> +				info->did_panel_type = DRM_MODE_PANEL_TYPE_OLED;
>>> +				break;
>>> +			default:
>>> +				break;
>>> +			}
>>> +		}
>>
>> Please tell copilot to not add so much crap in the iterator block. Add
>> functions. Add the first function as a refactor for non_desktop, add
>> more stuff on top, i.e. split this into multiple patches.
>>
>> BR,
>> Jani.
>>
>>

You're right, the current patches are hard to follow due to mixing refactoring and new logic.

I will refactor the code into helper functions and split the changes into smaller patches, then resend the updated series.

Thanks for the suggestions.

Regards,
Chenyu

>>>  	}
>>>  	displayid_iter_end(&iter);
>>>  }
>>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>>> index c398dbc68bbc..b95aec34ddb7 100644
>>> --- a/include/drm/drm_connector.h
>>> +++ b/include/drm/drm_connector.h
>>> @@ -899,6 +899,12 @@ struct drm_display_info {
>>>  	 * @amd_vsdb: AMD-specific VSDB information.
>>>  	 */
>>>  	struct drm_amd_vsdb_info amd_vsdb;
>>> +
>>> +	/**
>>> +	 * @did_panel_type: Panel type from DisplayID Display Parameters
>>> +	 * Data Block (tag 0x21). Uses DRM_MODE_PANEL_TYPE_* constants.
>>> +	 */
>>> +	u8 did_panel_type;
>>>  };
>>>  
>>>  int drm_display_info_set_bus_formats(struct drm_display_info *info,
>>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>>> index 3693d82b5279..d7ca1040b92e 100644
>>> --- a/include/uapi/drm/drm_mode.h
>>> +++ b/include/uapi/drm/drm_mode.h
>>> @@ -169,6 +169,7 @@ extern "C" {
>>>  /* Panel type property */
>>>  #define DRM_MODE_PANEL_TYPE_UNKNOWN	0
>>>  #define DRM_MODE_PANEL_TYPE_OLED	1
>>> +#define DRM_MODE_PANEL_TYPE_LCD		2
>>>  
>>>  /*
>>>   * DRM_MODE_ROTATE_<degrees>
>>
> 
