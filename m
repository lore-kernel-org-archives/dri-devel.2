Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3FFCD5BD2
	for <dri-devel@archiver.kernel.org>; Mon, 25 May 2026 14:06:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3E61410E3AB;
	Mon, 25 May 2026 14:06:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="N4UIHqfn";
	dkim-atps=neutral
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012024.outbound.protection.outlook.com
 [40.93.195.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50EFF10E3A7;
 Mon, 25 May 2026 14:06:11 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0Qpq5iHQi35cypXQU9SIVk6Uk5R/zSsgdPhIujy3Vdh1zFs33yFpB8whySKu4+dP1ilZsZOVtbMB2VAUXyX3WhGxnC2Eg6nF6N5afyWlA2Qi93UFIFRSgPMxBarR1qS0taTfkbc2CVe1Q3mTwBa8xsiwLQ+iJL3WY4L95/zSFwcrx2m2Qy1XXyPpaz75mSb2vY4u/9kFltl5ZpJt+8MgxiE2aRrqZYfxpTPyRfRBG/X//U/LPaCy9XkpBUGbDr+H3CrTREMkBqE80RaM8fxZscOMhsYA6LcHdoxzm4sL2VMYD2b1zP2tfxJzC+GtbPLvdbsW9jYOWXghPc0EbL8Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eMu9QV+6NBejodO29OxvdxQS4hckpW3ADuu9xvLKxzM=;
 b=LcUBxEUbgJZj7yUVYQTYg+aJpavVcgx6HIm9mL0z7F1ee1VLAMFrjqFsjFD5SXUVj9/ex9c9pyGL5Qs/aLy6GODWkgBwI/CnWQ+FBZWUooLHbipKx7CrZ31v0QA+/BhVJOY8U1m6R3CxiSeWPKwLJPiq9dzhWYEM2YQ4NwkCXJt/ivjNWg/aBkiopYBCFzsjDQZ/L8Y7iU8R8K5vaQOn3By9znw6x8VtexQqh3FZn7BcUI9owoLMuxTHdAmtH51RqwVwqPzYdpdwXRFdxZy52Y0khiwE5d4DwmYKYiFneEXInmuO1p+EGzNW4ovYfvHYheUZ5W2mlsQD2bABVU5C4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eMu9QV+6NBejodO29OxvdxQS4hckpW3ADuu9xvLKxzM=;
 b=N4UIHqfnahqX/jXSM8mxFbUZlIsXT55aSnCvuuEojMCBbGvYGLxuQlpPUDWWXDNAKeEDECrKQbis4Qgg3UxNQgAzdwn/Y0Us1qtAVo03XDOx9eK0SeSLR5e4dJ4MoAalNJAKK6qH4TqsiAKiNYXZ8HzK+oA6wRlYtf1I4tLT5ps=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA1PR12MB8887.namprd12.prod.outlook.com (2603:10b6:806:386::18)
 by PH0PR12MB5608.namprd12.prod.outlook.com (2603:10b6:510:143::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.20; Mon, 25 May
 2026 14:06:08 +0000
Received: from SA1PR12MB8887.namprd12.prod.outlook.com
 ([fe80::3fa1:8bc5:c9b3:a0ef]) by SA1PR12MB8887.namprd12.prod.outlook.com
 ([fe80::3fa1:8bc5:c9b3:a0ef%4]) with mapi id 15.21.0048.019; Mon, 25 May 2026
 14:06:07 +0000
Message-ID: <c7fd9dce-540b-4dda-8bbd-faad5c723969@amd.com>
Date: Mon, 25 May 2026 22:06:00 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] drm/edid: extract section header processing into
 helper
To: Jani Nikula <jani.nikula@intel.com>, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org
Cc: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>,
 Ray Wu <Ray.Wu@amd.com>, Limonciello Mario <Mario.Limonciello@amd.com>,
 Mario Limonciello <superm1@kernel.org>
References: <20260520021432.1301326-1-chen-yu.chen@amd.com>
 <20260520021432.1301326-2-chen-yu.chen@amd.com>
 <636d8a5c5d0b626852cee0446c2ebdaadff346c1@intel.com>
Content-Language: en-US
From: "Chen, Chen-Yu" <Chen-Yu.Chen@amd.com>
In-Reply-To: <636d8a5c5d0b626852cee0446c2ebdaadff346c1@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: JH0PR01CA0157.apcprd01.prod.exchangelabs.com
 (2603:1096:990:7::7) To SA1PR12MB8887.namprd12.prod.outlook.com
 (2603:10b6:806:386::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR12MB8887:EE_|PH0PR12MB5608:EE_
X-MS-Office365-Filtering-Correlation-Id: cdfdfd23-cdf1-4700-b408-08deba66c425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|56012099003|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: QGPmYONOzreksI9s2ZGqVs8MMyDdgb8791fEAdVocdDo7g67l9HDbVRwY3SZd1tCn204MCm3owRt+l+MbIi/LQe4/BHdrv1yCfJXrhn+waR2KQ5XniiGbG6kZF5SWThkMf7SfpWCQOD2KEm9iHFAhtWNhLjgh29AtNDGYgoakQVrLSguYtigfxC9+K3wRQo0yRHauuFKNGu1WrOshMg1fpMQDeUGoevO20+3koBthLCD8ygsdVm6Dc7QD2YB5JCVhZPbRgxiwSIzmFOjITRAeDS9+4DX1PLljoSYzcAvE0SgbhATsnYwvs26gu+5EvO4bcm3MW8czB+FgrwgG4q7xxeP3sdMBjRpLkfAWjh/uf0QNDxErXq3d1S7k0PRvrzLgylw6G4YTUmxgFaAz0GFsneGvas/WW1Mud6bMraUBE9pIz2zl/059W+Bsn//fDJpzvCt1EMrlGm6WMhfDvCmsI0DLmdkNV1PKKZutKkF/TpydHTFYc1g1vA0o6iZedwjoGhCwY831K9xCjyP4T+NhwobsosqPRw2Vn+L2mbNPh5a/Mh0F+ZesiHG1mfYfoR0fAv9n9vbfaZrpYZ9wrdyLS35+52e1tICpIpzAxs1rzPP5LpraBEr8VCX1+V1zddScO5Jrkdx6owQETQKSbiXcMSuS8uNpfe6WsakzwkFI0FPOYwzZSTEYa+ABiNYK5Ay
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SA1PR12MB8887.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(56012099003)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TU4rVzdpc0VEeHg4bjlrOUNaYkVJQitISGh3Tng2cEgvMUEwbk1VejlTSG5E?=
 =?utf-8?B?ZkxBeTBNbVZGcUtVMkdrTVNJMVF4SFUzVXlabi9kNkRBTHJFNWYrRGVyZTg4?=
 =?utf-8?B?RDY3ZzVDK1hEVUoybmRIVUdyLzEza25yN0owTUdSSWtoMkI0ZUVrcDhxcHM1?=
 =?utf-8?B?OThJTjcwcisreDNwVG9kK0Uzc2l5ZzlBcllvdEZWdzlPYms2c2dCRkUwRDJn?=
 =?utf-8?B?ZkIyS1NmaGd5UGhHM1VzR21ZR1hGMXR4RlBwSGpyUjhOMjFSdGRTZ3JsLzhm?=
 =?utf-8?B?OUtaem05RTdJd0lFSTJDTzQ5WDBNcDJpZ1pEUVNQeW5GajcxR2VNWjZ1RDNJ?=
 =?utf-8?B?V3pVS0NXaFZaa1Y0d2g2N3lpcGh1bTZMUnVJM2I5azIvbnBzeDNXY2JadWRk?=
 =?utf-8?B?YWt6QzR4RWZ6dWwvWUh4SjhFRFNobTNaK1JqRzBtOGJRd1I1NXByQkIwYVJJ?=
 =?utf-8?B?QW0ydFhMdTYySnlsMjBGRnc4ck02dmlVUGtyWitQWFhoY3JjM3BhdHBrWVdG?=
 =?utf-8?B?K1d3bDF3MDBpUXJnTDFNd3dtZTFobVRsMWgrM0E0NGR3bk0wb01lMUM0ODFU?=
 =?utf-8?B?VE5BL0IxNVFWamtkTlpnQWczbFpzOWNrbUlsdHJUVmFONHY3c1FjTHE0LzZP?=
 =?utf-8?B?QU16RU5oTFBhNklmc2VjTUhxeHZMTHF0a2dqSG81KzdBZzA0a0YvMUx1SCs3?=
 =?utf-8?B?dE8zaW1nbHVza2NoQlR2MzNKWksrYkE3TGpSSHRjcU1MUGFtVi8vaU1OdWR2?=
 =?utf-8?B?d3Z2NzFRM1U4TlgvQzYyT05KOEpLaFU1Y3pwbUJHL3hDMlJObVFoenpGTVRW?=
 =?utf-8?B?M0hLTDJIeEtZRGdsTGVtVU1QU2RKbmJmYk93eVhkd0xnaWIvUHBVTnpNcHVC?=
 =?utf-8?B?YUYydjFxRldLT1hYVGliRmNVQ3N2cVRKTFFJSWVqNGt0bkh3bWFNczFzUUZF?=
 =?utf-8?B?cXVTcmFlMThHc21UY0hmVUpFRmhJdG5uNkxIOVdxVlFnN0wyb2IwSHNRL01Z?=
 =?utf-8?B?dUdBaVFsVGZyRDg4VVBNeUVyRnp1dmlzYzMwcUlTL2tiMTFhK3F2WWdoMUpL?=
 =?utf-8?B?Vmp2Z0h2QU12SU9uRTc2cnZBS3NGU2tRUE1vWWI2d29TaytzZWR5aWdFUVdR?=
 =?utf-8?B?NDUrbExNdHZ2eG01aEdvT0U3Vlh4d2o0Qjk1TTNhNE1tUk9DTWJidlczSzVl?=
 =?utf-8?B?M2l5MU9ndWZXMVFaeWoyQTRiMzlhWHJmZkZjZG53NjVPS2tNR1VOVkczTUpt?=
 =?utf-8?B?QVYxeFVXMlVKdjBuOGhnQ1hvVWtJNmhQTWk1ZFFXcjBYVEpvdW43MmgzeVJS?=
 =?utf-8?B?UWF1MzhUczZwMGRiUGROalAwMDZiaGxIS1lYYzR3L2lwQm82WjNUK21ZYkhh?=
 =?utf-8?B?aUU4N2p6VjdmeHpCOWY0WWZjNWRyQkpLTCsvb2FVYTlXNkY3elcvYTFVMlRx?=
 =?utf-8?B?NGhvUXpVRnlnU29JUXRVbnFiNUpBWE94cEl4Qkd1RERQekM5Ty9Ta2Z6bTdm?=
 =?utf-8?B?cVZZN3BuS1c0ZjNRVkE0MGNzSHJONzVHay9EcFlpa1VzV2V4U1lML0JwenEy?=
 =?utf-8?B?Umd0RkRXTldYSnovai9ScW14bjZXRGJpRU9qWGt0K1VMOXlUUUNvVGtLUSt3?=
 =?utf-8?B?clBNM2FMa1RIR2dvSVdaL0ZKZGNmNTBRcEVkbFZiVzFwMVJrRUNJNXdiWUpv?=
 =?utf-8?B?WDBVdWlSdURnUDJhOGQ4bm9BOGpaaTlYUENqNWFEa2hSQXJ3MXBxQXlZTmQ5?=
 =?utf-8?B?ckhaQytRRHBQWW1uYWxab3FmQzNZeFZmWXRLd0xVQ2ZmTGIwUGdJdnQyQU9B?=
 =?utf-8?B?dG5naW56VUdmclJUaUJUU1E0MTdkdTYvVXVVOGRIc3crMHRpZEhXWXJQVXli?=
 =?utf-8?B?WVFZVG1leUhZN1p2OUFnak5mSEcyYytLNzNHejZjVGJFUzlubFB3RldjUENa?=
 =?utf-8?B?ZWtiWm1wRE5zNXcrQXNiRzBVSWUyeWhWVUYzVGdEbEY1enBQbnJzU29WdUI4?=
 =?utf-8?B?RWxuQS9PTkNNUGlUdXNKZU9VRXdOZUo4ZHJlcUM4THhBL1ZjNWgzclhqTkhV?=
 =?utf-8?B?ZUt1dG9yWDNiRnVXWm51cU40Lyt1Q3VlaHpGRHdpTjlkMi8wSmoyWktvQ3R4?=
 =?utf-8?B?VlhDa3hxamlKVG1YZ0ozVDh0K1Nwa1pJWjRuTHZsZ21zZGxLL2dYY3BIUEN5?=
 =?utf-8?B?OTFDampXc2c5bk40MWp6VGx6Q0lOTTl5WGVpSTFQc1FHbVd1S2QrdmhNcjNR?=
 =?utf-8?B?angzcVl3Z1laZWkxNzVzNGgrU2NpTHFYZ2JmTkh3SzR4WGpnaWVwZTY4cklS?=
 =?utf-8?Q?ejbBLREQXu3etTGco7?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cdfdfd23-cdf1-4700-b408-08deba66c425
X-MS-Exchange-CrossTenant-AuthSource: SA1PR12MB8887.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2026 14:06:07.7017 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kqe7iQYDxhNJAHerHpWf1kdfMwh9hW0RTjn69JC8XQcYXZ33r/R7dC9xSfpK9KB00Cv8FonAZTI1cAvVuNdI5g==
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



On 5/20/2026 9:10 PM, Jani Nikula wrote:
> On Wed, 20 May 2026, Chenyu Chen <chen-yu.chen@amd.com> wrote:
>> Extract the DisplayID section header logging and non_desktop
>> detection from update_displayid_info() into a dedicated helper,
>> drm_displayid_process_section_header(). Remove the break so the
>> iterator walks through all data blocks, preparing for future
>> patches that will parse additional block types within the loop.
>>
>> The helper is called only once for the base section via a
>> header_processed flag. Since version and primary_use are only
>> captured from the base section, and extension sections carry a
>> primary use of zero per spec, the non_desktop logic is unaffected.
>>
>> No functional change.
>>
>> Assisted-by: Copilot:Claude-Opus-4.6
>> Signed-off-by: Chenyu Chen <chen-yu.chen@amd.com>
>> Reviewed-by: Mario Limonciello (AMD) <superm1@kernel.org>
>> ---
>>  drivers/gpu/drm/drm_edid.c | 37 +++++++++++++++++++++----------------
>>  1 file changed, 21 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
>> index 8031f021d4d0..04878478ab78 100644
>> --- a/drivers/gpu/drm/drm_edid.c
>> +++ b/drivers/gpu/drm/drm_edid.c
>> @@ -6715,30 +6715,35 @@ static void drm_reset_display_info(struct drm_connector *connector)
>>  	memset(&info->amd_vsdb, 0, sizeof(info->amd_vsdb));
>>  }
>>  
>> +static void drm_displayid_process_section_header(struct drm_connector *connector,
>> +				  const struct displayid_iter *iter)
> 
> The name's a bit grandiose, yet loses the bit about "base section" which
> was the crucial part in the comment that gets removed below.
> 

I'll rename it to drm_displayid_process_base_section_header().

>> +{
>> +	struct drm_display_info *info = &connector->display_info;
>> +
>> +	drm_dbg_kms(connector->dev,
>> +			"[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
>> +			connector->base.id, connector->name,
>> +			displayid_version(iter),
>> +			displayid_primary_use(iter));
>> +	if (displayid_version(iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
>> +		(displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
>> +			displayid_primary_use(iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
>> +		info->non_desktop = true;
>> +}
> 
> The indent is all wrong in this function.
> 

I will fix it.

>> +
>>  static void update_displayid_info(struct drm_connector *connector,
>>  				  const struct drm_edid *drm_edid)
>>  {
>> -	struct drm_display_info *info = &connector->display_info;
>>  	const struct displayid_block *block;
>>  	struct displayid_iter iter;
>> +	bool header_processed = false;
>>  
>>  	displayid_iter_edid_begin(drm_edid, &iter);
>>  	displayid_iter_for_each(block, &iter) {
>> -		drm_dbg_kms(connector->dev,
>> -			    "[CONNECTOR:%d:%s] DisplayID extension version 0x%02x, primary use 0x%02x\n",
>> -			    connector->base.id, connector->name,
>> -			    displayid_version(&iter),
>> -			    displayid_primary_use(&iter));
>> -		if (displayid_version(&iter) == DISPLAY_ID_STRUCTURE_VER_20 &&
>> -		    (displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_VR ||
>> -		     displayid_primary_use(&iter) == PRIMARY_USE_HEAD_MOUNTED_AR))
>> -			info->non_desktop = true;
>> -
>> -		/*
>> -		 * We're only interested in the base section here, no need to
>> -		 * iterate further.
>> -		 */
>> -		break;
>> +		if (!header_processed) {
>> +			drm_displayid_process_section_header(connector, &iter);
>> +			header_processed = true;
> 
> Every DisplayID Section has a header. Every DisplayID Data Block within
> a DisplayID Section has a header. This is about handling the information
> in the Base Section header only. IMO header_processed is misleading.
> 
> BR,
> Jani.
> 

I will rename it to `bool base_section_header_processed`.

Regards,
Chenyu

>> +		}
>>  	}
>>  	displayid_iter_end(&iter);
>>  }
> 
