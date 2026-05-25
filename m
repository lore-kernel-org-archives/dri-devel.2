Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F06BDCD5BB1
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 14:06:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5219710E39D;
	Mon, 25 May 2026 14:06:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="f/3yjqRn";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010066.outbound.protection.outlook.com [52.101.46.66])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76E9210E136;
 Mon, 25 May 2026 14:06:47 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CYnR4OnBXzTfhs+7G3erI+C0jcdfKzUB5IS+ppncQ/lpqKnoRQyEHz+GljG/B9unNaymdrOcXrruSUlurVF9fmY92SFy3wgXC0IFBaVy87xnkWIOzF7DmnZ3g2ahlcn+O4BRqPOMuDfUw424VD0YeQPLtSqugSAKOxArz6Wr3ga0BhsXAI67cj+GOtyGhyEI4/lgq7iR453JpNqDWzZV5mgGTIAHgvYqt+ebOtNAk3MZHNiIJyNTgkEIQgO1sWeC04tbxlRz41q3IdzMmLDBf8TM2PRyvK4h6m5j0J04yIvd/4StAmFImSik6MRBI4vEIfLNylG/WxiJbLMnYwqmsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e3Gb+M32EjIMyVynwBxRhl6JNd26/EyCHKqvyzaFX+g=;
 b=VHeC+0WrusCqbsipIQJlvf3W9o0p6l+hHh8bFtyzwtFY2bpQqHQrRfqZ/VzGBCBMtuvMdxDHdatbzPS98A4y1GePz9dYVQ1BVMZ6yE6eb0iaxYOOlDg1RlTe2RfX8Skn0jEt0oiXCuL+cdoy5enk8lfYCS0GQ2Uvz5ZyqbDa96UWyOhgk6r47KIiYSw0lfxpNfgWyzDQNKlBVvEvUcxDUp7IHbuK7FJazmaI96iGsZlRXB24r65YoRIRtWL2ICMEsiuqTRBYTAtfr0GtDjtFctmwIrVCrA/rEbhAA+szo0FWa18Se6YbBHM0Zln3QDjwDFJuW8ntOOQsEFXuIPu/Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e3Gb+M32EjIMyVynwBxRhl6JNd26/EyCHKqvyzaFX+g=;
 b=f/3yjqRnlwpirNTcIulMjEMguXPdOENaYA4RqTKXW8XrWXPVeKsoeAQV7z8lMC3pgotfFmg6cSNRzjTU0Td7+4cyMBDHh+AmBNLxWpgGXxWErDeRRalWPozdF7CRqmD5tUcXM5idnVE4S1c2ZmOoTLL++w22h/0y/bWiBV9jCjg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:06:44 +0000
Received: from SA1PR12MB8887.namprd12.prod.outlook.com
 ([fe80::3fa1:8bc5:c9b3:a0ef]) by SA1PR12MB8887.namprd12.prod.outlook.com
 ([fe80::3fa1:8bc5:c9b3:a0ef%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:06:44 +0000
Message-ID: <79368fa5-3b61-4262-b03f-d9da4beaaefb@amd.com>
Date: Mon, 25 May 2026 22:06:37 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] drm/edid: parse panel type from DisplayID 2.x
 Display Parameters
To: Jani Nikula <jani.nikula@intel.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>
References: <20260520021432.1301326-1-chen-yu.chen@amd.com>
 <20260520021432.1301326-3-chen-yu.chen@amd.com>
 <4ca47af4a86601462cf5c0e723b2055005118762@intel.com>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <4ca47af4a86601462cf5c0e723b2055005118762@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: JH0PR01CA0161.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::16) To SA1PR12MB8887.namprd12.prod.outlook.com
 (2603:10b6:806:386::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8887:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: 52129c41-5bba-42bf-9034-08deba66da05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|11063799006|3023799007|4143699003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: UglyildnKJ9E4D4rKY74Y+iW3hKf21bXiKG2H81elSkl5PpORhLdZ6XD9mSuuOG5N3FFkEzkMfcpdprj3ifn4mAS+9LPYaEidC5CYmZ8zEjwMF/f1Yy1DyRg7iYNYtC4lkaH1ERrqhk9APD6SGv9MUDmjM53XKRQVs5wVvMXUEUCmAOqUR/p69JJ9CtUHllba6RPWyrJqEQRnzzZUK6NjQxHyu8lawfg28h+/HOVE6Y3C5PgxsPqUKcIQj6qeRlXJG1/F1lTRsfnwZedHzP3PTkfUMJYMeI30lIcQwNYZ+ZcdPDA+jHHsvnlFnn9q3y+rbupmS8Phdm+2iNac7Nf3HalcBJLlO3gUb8V7mdmBIYDiJ8zis5goPv3sPloXec+HWXAra5H/V/KPpENKbLtVd1gDUmTrXqeDBvAgjrD0zA4UHWTM1h5+OYliaqAby8v+ShZ5O14sdh0Uu0XMYvL0DTTl5UqnBF3glDZ5HD7pVulM/MREgBmHqNKESYgCQfa3qrSG6efxEA0MenkErk/uxZpKDbmdIrPb0EgsWnqs2wkv1HXDnDs4OWEDFw2p5q2zNuxEXKN/XgYlsFVg6xKVubaoucNPfdNrvoVs1soifT+tIze3ryY1pANAumphbSYKwF4wmjOGTsFCOSyy6YgQ4ebXZYdJyvvweptUEm87wibYbdXjUcezlkW9dYca5Wl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8887.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(11063799006)(3023799007)(4143699003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SlU0d09PT0FwblUvMC8ram5qOVpDVzBKNkdydHRZMzd6NkxORTIvOEI0eURk?=
 =?utf-8?B?MXZhOWJWdlRjZVpMWkJFeHJqY0hWblZWSWlOMUUvenhPc2p0REtnSTFndVVH?=
 =?utf-8?B?Y25Nek1LcXM0MnNhdUpZcTAyYk9GU2o0M3ZoNWRYQWw0UXREV09NQm1mcE1T?=
 =?utf-8?B?WnZ6cE5WbDcrZ3ZkVHQrQUEwbDZBRUYvR3NmeW1zQ1ZHRnlKTGRrdHE4bXYv?=
 =?utf-8?B?WHZWZXUzMGZWeFNaemxWR1VsRC9zRHZLamlwYmlkd0pnZnFlN2dpb0NNaG1n?=
 =?utf-8?B?RE5qRjhFMjJEU2ZkL0dMUllaYm1qS0UwQU5mWjlBblEzWlZMOG9vVU9tRFR2?=
 =?utf-8?B?NzhRL1phckRxU0U4T2FUMkticTFyL3dwVEhGZFgvTFppNzlHVlZocFViYzBy?=
 =?utf-8?B?My82c2VoVENRbUxjZnk3WkRuVmJjK0VwZE1EdXZ0VjBvcWNOcVpkbGM3NThk?=
 =?utf-8?B?YjRMM2pNWlI3YVJJR0x3RThTZmQyTWZPVHdXRStjYUM1MWtXVWp6NFQ1VmxL?=
 =?utf-8?B?eFBvRTg1ZjFGZHFGQ01SZlJaSEZuQTNNdVM3S2toZ3V1Y0RjNytNTWYwWEtN?=
 =?utf-8?B?dHp1dFZ0R0IwQXNmT1I4VHdTR0svK0hvQWxTcVRiSlVkbkQ0bGJRVlE5dDNB?=
 =?utf-8?B?cE9xMHpxTU82Q2wvdlVTWGptOFhqblkzMENMQ3E2WkR0WWdqRkcvcGFUekti?=
 =?utf-8?B?Rmd6TmZiMzgvdkNGRFo4UklsNm5kTWNodTVvakYzdFJ4WDBtRnJBSVBQQjBq?=
 =?utf-8?B?L1FiZktGQ1IvQTNHL0twM2I4aThERSs3Y2w2L1VGbE0xT29WM0dvbE5nUzkr?=
 =?utf-8?B?WlVDRUVGMjRDZXFNcU9mTlpGZGN2bDdaR2lLVXVjMGx0VGI1RVdZS0MwMmc1?=
 =?utf-8?B?aW12clNodmtZZUhhZmNMc1lsbkdqOTRTK252R2cvc3h3WHozQ1JZZHpWdlFz?=
 =?utf-8?B?Sm5OT3YyV3Nwc3V3VzRWSllZNlpiUWZpQklqZHRLaWx2dml0bTA2ekw0WVRs?=
 =?utf-8?B?QUJIbnFWa2RVdUczWDBGR2dRU1Q5bC93Q3dHUHkzQ1d0Z0tvMDFldjZxSzRI?=
 =?utf-8?B?dVRBZUZyc3NVV1VJdU5uWXBuVE9CRDNQV1VIYW1yVlF1ZzVndjNTc1JKUERy?=
 =?utf-8?B?c1BraEZrdlU5cVBYZjBFYTFXMlFKOFZMejRkRTRLajlVNm05QVJXa2hsbmpx?=
 =?utf-8?B?OEFPK0hDMHd2ZEpCbGNCb0JwY1FvdkRxSjU3cVlNM3hwWTVOZ25Kb2RnSDRu?=
 =?utf-8?B?Mmx6QVFwcG9YTVhQZW4xTFFqU1V0eEFDWnBXR09tNG1lNzlQdGJtbEN0cE5C?=
 =?utf-8?B?YVF2Y3JnRjNoUDVmR3V2Y3VYTDcrVTgyVWV2SFZaVy9LdE5JL0F1UTRLdldO?=
 =?utf-8?B?bnd5elVUQUMwSk9GU2xYUFQ5VmR4RHJVc3V3ZGd5UVFOWWVvWHczMFlRZFIw?=
 =?utf-8?B?RGNxNnA5SVBObEZhTlFoTzJRYTFiNXJDa0g1TVliaGtXdGE1cXMrbC93Rko0?=
 =?utf-8?B?Yk1tV1J1SW51NEh4cFdXOE9CeXpGWmdzSlJwMllMRUVGMXdyR0R0VDJuRlJF?=
 =?utf-8?B?a1o1aG05bjhGR1I1WnpBQ2RxT0YxY0JQS3k0dEtmMTZSVFBOWEg4TTRiSFhj?=
 =?utf-8?B?MjRsWTZ2QXRHMVhYQnhyNU9HbmpWOUxTajNSVkJ1QXZ5K05hRVVZcEczY29Z?=
 =?utf-8?B?YTMvTTd4eHRVL29PT1pNbndmOG1uU0F3MGp4eWFSN0V4ZG9KekVmTm9nd2Jw?=
 =?utf-8?B?MGtHajBQZGxZeEJFQ3VyT2o3cit5UFZ4bzJXRExpZmFIbjBGWUg5WnNLVlEy?=
 =?utf-8?B?SzU0RDdBMk0vSnJ4QmpGZURrdWZVZXVQUExzU2FXSnU2TVowYVZGaE5wdXBY?=
 =?utf-8?B?Q0t2WXVtejF3TVZFV0FnQVROSXFSM3VVd2dmMnVjT2xlUlNzcTY1SklaYmlN?=
 =?utf-8?B?NVFwK21EcUtBaGpZaVNxcWp6YW5YRjV0Q3dORndDSGRhTXVmZS85aVFBWU1v?=
 =?utf-8?B?cjYzZjI1OGFqMmNuc3UzMDdMVitaV0hBNi9JVzEraHpwWG9HdFR2L3ZjMkNp?=
 =?utf-8?B?elNlVUVSVlJubFJPWEFydnlscHhOdUNDWWVNRmIzYVRKaHBEd0ZLQjV5SFQx?=
 =?utf-8?B?c2J5OHVIaGNYWlB5YlBqL0tHWm04ZUgzM3ppRzFiQ3RQaFZiVDBTZWR6ME8w?=
 =?utf-8?B?dW1TNEpld2NadUVmVksvNEF1NGJjQjZqNmN0aGxFWkVoV0xFMlZuN3A5WDYv?=
 =?utf-8?B?K1doSS9YOWxQL0FVUzdqMmUrRVdpZ2VXK25LTjNCVFpvbkZEaTlPcXlSSEJh?=
 =?utf-8?Q?YmVQe5zIvbP1uweJFZ?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52129c41-5bba-42bf-9034-08deba66da05
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8887.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:06:44.3983 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WfpGoHeQHq/xBKcq//OUSms0o4s3+pL+YWqev885uWAQ0lSUWpCX0PpAEAN6p3BXUsC9IX0bA6Kcmo1TNIcaaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5608
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



On 5/20/2026 9:30 PM, Jani Nikula wrote:
> On Wed, 20 May 2026, Chenyu Chen <chen-yu.chen@amd.com> wrote:
>> Parse the Display Parameters Data Block (tag 0x21) defined in
>> DisplayID v2.1a Section 4.2.6. Extract the Display Device Technology
>> field from payload byte 27 bits [6:4], which indicates whether the
>> panel uses LCD (001b) or OLED (010b) technology.
>>
>> Add a did_panel_type field to struct drm_display_info and populate it
>> during DisplayID iteration so downstream drivers can use it for
>> panel-type-dependent behavior. Add DRM_MODE_PANEL_TYPE_LCD to the
>> UAPI constants for use as an internal communication value between
>> DRM core and drivers.
>>
>> Assisted-by: Copilot:Claude-Opus-4.6
>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>  drivers/gpu/drm/drm_displayid_internal.h | 25 ++++++++++++++
>>  drivers/gpu/drm/drm_edid.c               | 44 ++++++++++++++++++++++++
>>  include/drm/drm_connector.h              |  6 ++++
>>  include/uapi/drm/drm_mode.h              |  1 +
>>  4 files changed, 76 insertions(+)
>>
>> diff --git a/drivers/gpu/drm/drm_displayid_internal.h b/drivers/gpu/drm/drm_displayid_internal.h
>> index 5b1b32f73516..e0f7c54d2987 100644
>> --- a/drivers/gpu/drm/drm_displayid_internal.h
>> +++ b/drivers/gpu/drm/drm_displayid_internal.h
>> @@ -142,6 +142,31 @@ struct displayid_formula_timing_block {
>>  	struct displayid_formula_timings_9 timings[];
>>  } __packed;
>>  
>> +/*
>> + * DisplayID v2.x Display Parameters Data Block (tag 0x21).
>> + *
>> + * Per VESA DisplayID v2.1a, Section 4.2.6, Table 4-14:
>> + * Offset 0x1E (payload byte 27) contains Native Color Depth and
>> + * Display Device Technology fields.
>> + *   bits [2:0] = Native Color Depth
>> + *   bit  [3]   = RESERVED
>> + *   bits [6:4] = Display Device Technology
>> + *     000b = not specified, 001b = LCD, 010b = OLED, others reserved
>> + *   bit  [7]   = Display Device Theme Preference
>> + */
> 
> Please drop the comment...
> 
>> +#define DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH	GENMASK(6, 4)
>> +
>> +struct displayid_display_params_block {
>> +	struct displayid_block base;
>> +	u8 payload[27];
>> +	u8 device_tech_byte; /* bits [6:4] = Display Device Technology */
>> +	u8 reserved;
> 
> ...and actually define the information here.
> 
> Sure, you're only interested in one thing, but don't leave the rest for
> someone who comes after you, since you clearly have access to the spec,
> and whoever reviews this also needs to have access to the spec.
> 

I will replace the block comment and the u8 payload[27] with fully named
fields per spec Table 4-7 (image size, pixel count, features, primary
colors, white point, luminance, color_depth_and_tech, gamma_eotf). 
I also add the named defines DISPLAYID_DEVICE_TECH_{UNSPECIFIED,LCD,OLED}
for the technology values.

>> +} __packed;
>> +
>> +#define DISPLAYID_DISPLAY_PARAMS_MIN_LEN	\
>> +	(sizeof(struct displayid_display_params_block) -	\
>> +	 sizeof(struct displayid_block))
> 
> Is this helpful? Do you suggest we should add the define for all of the
> blocks? What about when there's a minimum, and you can optionally have
> more?
> 

I think defining a macro for every block doesn’t make sense.
So I will remove the macro and use sizeof(*params) - sizeof(params->base)
inline instead.

>> +
>>  #define DISPLAYID_VESA_MSO_OVERLAP	GENMASK(3, 0)
>>  #define DISPLAYID_VESA_MSO_MODE		GENMASK(6, 5)
>>  
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index 04878478ab78..d1de1a398677 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -6713,6 +6713,8 @@ static void drm_reset_display_info(struct drm_connector *connector)
>>  
>>  	info->source_physical_address = CEC_PHYS_ADDR_INVALID;
>>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
>> +
>> +	info->did_panel_type = DRM_MODE_PANEL_TYPE_UNKNOWN;
>>  }
>>  
>>  static void drm_displayid_process_section_header(struct drm_connector *connector,
>> @@ -6731,6 +6733,44 @@ static void drm_displayid_process_section_header(struct drm_connector *connector
>>  		info->non_desktop = true;
>>  }
>>  
>> +static void
>> +drm_displayid_parse_display_params(struct drm_connector *connector,
>> +				   const struct displayid_block *block)
>> +{
>> +	struct drm_display_info *info = &connector->display_info;
>> +	const struct displayid_display_params_block *params =
>> +		(const struct displayid_display_params_block *)block;
>> +
> 
> Superfluous blank line.
> 

Will fix it.

>> +	u8 tech;
>> +
>> +	if (block->num_bytes < DISPLAYID_DISPLAY_PARAMS_MIN_LEN) {
>> +		drm_dbg_kms(connector->dev,
>> +			    "[CONNECTOR:%d:%s] DisplayID Display Parameters block too short (%u < %zu)\n",
>> +			    connector->base.id, connector->name,
>> +			    block->num_bytes,
>> +			    DISPLAYID_DISPLAY_PARAMS_MIN_LEN);
>> +		return;
>> +	}
>> +
>> +	tech = FIELD_GET(DISPLAYID_DISPLAY_PARAMS_DEVICE_TECH,
>> +			 params->device_tech_byte);
>> +
>> +	drm_dbg_kms(connector->dev,
>> +		    "[CONNECTOR:%d:%s] DisplayID Display Parameters: device technology %u\n",
>> +		    connector->base.id, connector->name, tech);
> 
> It would be more useful to print LCD or OLED, not the number.
> 

I will change it to print "LCD", "OLED", or "unspecified".

>> +
>> +	switch (tech) {
>> +	case 1: /* LCD */
>> +		info->did_panel_type = DRM_MODE_PANEL_TYPE_LCD;
>> +		break;
>> +	case 2: /* OLED */
> 
> The comments above are useless.
> 

I will remove the inline comments and use the named defines instead of
magic numbers in the switch cases.

>> +		info->did_panel_type = DRM_MODE_PANEL_TYPE_OLED;
>> +		break;
>> +	default:
>> +		break;
>> +	}
>> +}
>> +
>>  static void update_displayid_info(struct drm_connector *connector,
>>  				  const struct drm_edid *drm_edid)
>>  {
>> @@ -6744,6 +6784,10 @@ static void update_displayid_info(struct drm_connector *connector,
>>  			drm_displayid_process_section_header(connector, &iter);
>>  			header_processed = true;
>>  		}
>> +
>> +		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
>> +		    block->tag == DATA_BLOCK_2_DISPLAY_PARAMETERS)
>> +			drm_displayid_parse_display_params(connector, block);
>>  	}
>>  	displayid_iter_end(&iter);
>>  }
>> diff --git a/include/drm/drm_connector.h b/include/drm/drm_connector.h
>> index c398dbc68bbc..b95aec34ddb7 100644
>> --- a/include/drm/drm_connector.h
>> +++ b/include/drm/drm_connector.h
>> @@ -899,6 +899,12 @@ struct drm_display_info {
>>  	 * @amd_vsdb: AMD-specific VSDB information.
>>  	 */
>>  	struct drm_amd_vsdb_info amd_vsdb;
>> +
>> +	/**
>> +	 * @did_panel_type: Panel type from DisplayID Display Parameters
>> +	 * Data Block (tag 0x21). Uses DRM_MODE_PANEL_TYPE_* constants.
>> +	 */
>> +	u8 did_panel_type;
> 
> What does the did_ prefix give us?
> 


Good point, it doesn't add much value.

The intent was to indicate that the value is derived from DisplayID,
but I agree that encoding the data source in the field name is not
particularly helpful.

I'll rename it to "panel_type" and treat it as a generic field,
currently populated from DisplayID if available.

>>  };
>>  
>>  int drm_display_info_set_bus_formats(struct drm_display_info *info,
>> diff --git a/include/uapi/drm/drm_mode.h b/include/uapi/drm/drm_mode.h
>> index 3693d82b5279..d7ca1040b92e 100644
>> --- a/include/uapi/drm/drm_mode.h
>> +++ b/include/uapi/drm/drm_mode.h
>> @@ -169,6 +169,7 @@ extern "C" {
>>  /* Panel type property */
>>  #define DRM_MODE_PANEL_TYPE_UNKNOWN	0
>>  #define DRM_MODE_PANEL_TYPE_OLED	1
>> +#define DRM_MODE_PANEL_TYPE_LCD		2
> 
> This is a UABI header.
> 
> Should we add this to the panel type property too?
> 
> 
> BR,
> Jani.
> 
> 

Yes. I think we can expose the panel type too.

Regards,
Chenyu

>>  
>>  /*
>>   * DRM_MODE_ROTATE_<degrees>
> 
