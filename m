Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83291112246
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 00:54:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C391410ED62;
	Thu,  2 Apr 2026 00:54:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="MUD0+7yA";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011063.outbound.protection.outlook.com
 [40.93.194.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F51210ED62
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 00:54:04 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=G0A9s5kjyH7vhlxy7vwO+suRUI4SsHhYEb72LwHi09MuhfjJUSTmbZMuSSLpQWS2fC4aaLuNd4+0Sj7PMh5s3mh1OqL+4soGsANu5L871/EW+YH5ilf2hNtA2WFU4Uw6qPmqSsxCXDEfbD7fAErOhE3WqYrSlSgIZSrCcMUTT4fkH2oAfnFi+bHKYpey0RAcS8xU4fA2QThIfPzQKlV7w/diTUl2zt3vyQLui+L8LDtjILnRchdgW5osfP0F+WrtDwSoVmbLs8OCXRkCJG6hdHHTbzu/uWXiyV+PQi5Do4NSxEsLzYtaK/ZjQfoisxLwx5QNM6VRkN7NsL3xG6k7aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oipwzlEG2lsJ3UEp6u2OALfoaCdehs1Ga4O0YckD2dM=;
 b=T/tYaOoXwc/eGzWc8bL3maY2AeD5gdxxrtVHPq/6Uzh94uruDZMia0JNwdOJfeRyTCauWLQbFKUS7SCaekobd/n2C7+SCFl6UEwRlbkE00xMbcvlb27SZPr0GASZZc0ts4KT/Jd/2X5/O4HKaAYBSnKNc9pWMohyAuDgNAMlA+1F/ctQU4MpzbbScSkkZOuwR7ve0y4TV59DnY4NhAbYfHQnjnUYoHMG1VsG2hdl1D55Zn0/ZyOO/6BE+tM7a4Wu9qiAamHkzl6+/nW92g4mwDGxHgYIiRl4NkfJE8i067d8vxUBAY1OTQlhvbncvCC0yJPaxZb7MybFxsop82DeIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oipwzlEG2lsJ3UEp6u2OALfoaCdehs1Ga4O0YckD2dM=;
 b=MUD0+7yAXtzEucrjo4TXrSnIek/7qyZ+jnPfWQsyH1fxwBnUN2qvUqFNGFBTLdI9g1WQ7KfL5RWzo24xXQKwxOFsDIH6rCSgn2IOVEIflEr17rM1ZxFmnx/XYkkda8f4OoESrAiYrdUqSggsi0LDCpILH1u7qMk0NdVt28NKqwM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by LV2PR12MB5798.namprd12.prod.outlook.com (2603:10b6:408:17a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 00:53:59 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%7]) with mapi id 15.20.9769.016; Thu, 2 Apr 2026
 00:53:59 +0000
Message-ID: <f7465d35-5d2a-4f1a-be6c-46321d5bb16e@amd.com>
Date: Wed, 1 Apr 2026 18:53:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/colorop: Mark interpolation properties as immutable
 and atomic
To: Pekka Paalanen <pekka.paalanen@collabora.com>,
 Melissa Wen <mwen@igalia.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 contact@emersion.fr, harry.wentland@amd.com, sebastian.wick@redhat.com,
 daniels@collabora.com, chaitanya.kumar.borah@intel.com,
 dri-devel@lists.freedesktop.org, Xaver Hugl <xaver.hugl@gmail.com>
References: <20260327003946.3458610-1-alex.hung@amd.com>
 <3aa6e599-b741-4d6c-95d9-43544423bf32@igalia.com>
 <20260331151919.21f972cb@fluorite>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260331151919.21f972cb@fluorite>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0007.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::12) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|LV2PR12MB5798:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b793c71-f44b-42c8-71c7-08de905252df
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: LYHBx/YPTlmgqYttklOZDcXFqGyZO4J/urdttgLoNWzEveyz4H4D+xmq3wjHbkVkfmHKDReyd8nBmO2HIic9m0wiakG5Qnx+K/cp6IoJpK5uzCmZ6hk3uHApMvvDunKnAhdVJvAOvCnA8eFZv7Vc/NXvZAksYFk/ewO0y86J9sSuOLNShrjGsb+IZLRkFN6fJP2wK2lfctSWgWz8idVTALLiWm/JXo5/r54ZCRFznTYovYAfD+pDCQHdaFlrehT/S6RMJPjKrhxzJxlVAb7GRWdeKMwBYU9Enx52aiaAEeNOVQWWSJAobkUE3cLbtwgDudixUu92MpYLtv3dAizIeJdVPYJTNjR3Thtu02NKi40g0SVHN1Zps9QJwi6APzBPuhsneIH194AWQ87A5mOqEph4UfxUEi+t6ymknZzW8bGaT9fWkGX+zH4KMD1Mk6/lc2DcYcW2cBS+39WGRvfoZ8CselFuGd4ARL7gKYdzJrK5CT6WMTkh//Si/WyVmCCWgIMmV5CdPnABnufqWrWy0OjCp19VYvlT/BuYo7BRFX7yePvmnmeFB/0RG1vWqugzbLkWZM8iWGMP9BPuPuD4M51ximlPebfB55HRW6R8CkM4Yrjaazo/1lUSMDOQcTLV14DjKsZHeXKOZ0Oo0ub4Hjzz9n9EHhOAvSvvRV94EiqcgKnLldRYuzq5x2+FVskd+UueQOOmGxP9lGWcBk/DkA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM4PR12MB8476.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WnRwdzJyTlZSNmkwYmFZQ1dySUpjc0NnWnU5SW1GN3o2M1FMMjVQMjREdkNs?=
 =?utf-8?B?c0srNWJDQWRxZGpmWFBvUy9ObzZ6NW1sOG43Wk81VkZ0Y29pUVFDdGdvQnpJ?=
 =?utf-8?B?T2k5SFVOaEVNZ09QbTFRdXo2N05SczNhVG1ZQm5ZRm4zVmQrOXhvWmMvSkxn?=
 =?utf-8?B?Qm9zcTVMd1dPb1NiZk5mR0p1cTcySkhmNHFOZGt4aERNMER0TWdMdkx6dS9v?=
 =?utf-8?B?QlIwNVoxVHQ2YUhuT2s3ajJjcDJML1pLdFdydGhxcGtOMmVCWE9YNC85d3BL?=
 =?utf-8?B?MWVIdjF5YkJnMkt6RGtIeUdxV05ZOS9PWmpuYmFkWnhlVWNxeW9iSSswb29i?=
 =?utf-8?B?NnNKcFBpZVBkS3p2a1JWYTkwZFhjSVZ0aVFuYjBpT1hBNS9XWTBaOUVEL3FU?=
 =?utf-8?B?RFZqYm5iQ0FZdVU5d0llNFZneU81UVFNWFZPSW1wVUU5N21hMzZTRDlJN0dT?=
 =?utf-8?B?SUJJYzZMZGhnS3M4eldKVFhNVnd2T25rODZGT0o3RnRQNXdhVGFwSmdIeVRX?=
 =?utf-8?B?NDVHWElib3hKd0tZOUhSTGZNRzdoZ2R3clF1YmZhcTFxVnpjWFRTdmpQWjdM?=
 =?utf-8?B?aXJ0ZUdVbGNObGlXcHpqZkprNkp5aEUvSFRDaGdqUGJwajNTUkc4R0UraFNS?=
 =?utf-8?B?MzYvSC91L3BEalhEdkp1YmdVVnhFaHNId09tREQ3Q0E2N2liQmZNTXIreDE5?=
 =?utf-8?B?VktMMTBHNTJKT0lUL0hBR2hLbm81WXBpN25EWndhQnlqRGtDNGtUM0ZmOWFo?=
 =?utf-8?B?eVNjWEpzNVNWQWs5eGcwTG5WejBocW0zRkwzQ1JWOVZkZERLdnpVcmVzUHhw?=
 =?utf-8?B?NjRkTVAvNzlmT2Z1YUR0bjRIYmZxZytyb2o1N1BqT0xnUnJyR3Q5dlljQTUw?=
 =?utf-8?B?S0Nwc21lOWF4U01VblcwbGt6d1V1eUVtcFJKc251eE1Hc2RYMzYvV2F3dCt3?=
 =?utf-8?B?bGhaRmNtWHVpY1ZtcE9ycktDMTlSdnZUOTA4b2xwTm54dmIwSVFyT0FZSW5M?=
 =?utf-8?B?eDBtUFFxeWM5VTlXbUJNbDVjNWN6RFhaSGx1c3M4ZERTTVNFSE5rQ0JzV1dT?=
 =?utf-8?B?OERQb05KVlNjbjJzRkxYQzRta1plQThqZUgvVEVpVVFETVcyQmpoQndWTGZ5?=
 =?utf-8?B?c0o3b3hDekI5Smg4MFRDeDhvYkZycVA0QXh4R2lWNlBZZzFjRlZyeWxLS3RW?=
 =?utf-8?B?L0hIaUg3OU1rNDFaSjYzTTU0MHFac3RTMXZuYWMxWCtFTVM3K2VsTGZ0UlR5?=
 =?utf-8?B?V0pIc0l1YjlxMFRMeEF3Q1B0ZERHYkJvSnVLOVQxMkhnZDJtWkhqZ2c1eWRh?=
 =?utf-8?B?L1I4Z3BWV2tWd0tSbXdQMkJIcTgrZWl2TmpLZ0thaDJLYk9YVVJOdytJWEcr?=
 =?utf-8?B?aE96bmwwUGdUSHl5Y1dEWUNBaXN2dy8rSUFVYXRtaGR5NG5hWDBFUE53MnFK?=
 =?utf-8?B?cXNFVnUvRXFPOXNmOS8reStrOGZ0NUR5SEp4b1A0NUJ1Z0syZXppK0RiZ2RC?=
 =?utf-8?B?QkNzL2dOUUhyOXg3UlVqNzhiN2FYMDFCdnFrczJsa1NNL0pISjh5TWNORk9M?=
 =?utf-8?B?R08wOVlCbzZPamVMa2E3Ny9OT0Z4MVFiYzhZVTZuQTc0NjZjMDVCMytzaUNW?=
 =?utf-8?B?cWgxSjdnR2s2RkVaaXB0L2xHU1lDcU1NbXU1ckZUSzVCMEdlaGJvaFpQc1lP?=
 =?utf-8?B?by93N0lPajgvOXJnRHlGaTdmdmQ2dmloeTR2V3dYRWNGUVVGSVZvNCtTekRk?=
 =?utf-8?B?VGExOWJmR3htOEhJWlpoM3Zzc1VMQ3BqMStIV3VsZkR0eXMrdVk5UGJLOUVo?=
 =?utf-8?B?MXRTM1BhQU5EWEtDUUtyNnk4eGN4WlBDTlhFRjRISGhxcVkwVG82UjFmT2N3?=
 =?utf-8?B?U3RBWTAzSUZPa0g3ak9zanhKVU8yZGdwUHJ6N0FTdXZscHBUeGs1a2IwM1FQ?=
 =?utf-8?B?M1lZcC9GWkRuY0ppUkd2UlN5VWFEQ213eE14eENuSlBWM3pvbzVVcHRJb3Jj?=
 =?utf-8?B?ZEpLeVpkNURMc252VGZraXlUL3Q2eGJNQVBzZXdiVzlFdStzcDhONGg5a2RU?=
 =?utf-8?B?VzFYYjAvcmM5cHFpQkZVTTBWMFhuQU04RlR4clJja2Rzb25hNGdzM1ovVGdR?=
 =?utf-8?B?WDhwUmNBMFlzLzNQRXlIbnc3WUJ0c1paMnhQeVdEYVJ2WGs4RUFLWWN4cy85?=
 =?utf-8?B?NzFqZ0ZOazg3VE5WQnA0ZGhyNlhIVVlHbFBqbjljUGtQbndpOGRXUTlKWjJR?=
 =?utf-8?B?M2VwenVWalVqcnhIZlpUZ0NYRk9VOFFFN3NQR04zT2g0Q01VMzFFNWpEbUlS?=
 =?utf-8?B?VytXajdQZFMvc2ExRXQ2TVJ3djFEeGQxWTNpTUpaa21qL2JaT1BGUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b793c71-f44b-42c8-71c7-08de905252df
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 00:53:58.8028 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eOlMwGp/zrC7/1sbd2jIuGB1ZXUfSWZ1ZuLKe2LKzWzjbRur54Q0L3BIdd5PCgrqbe6r/pyjREtxRnkdcfs7rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5798
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



On 3/31/26 06:19, Pekka Paalanen wrote:
> On Mon, 30 Mar 2026 09:33:53 -0300
> Melissa Wen <mwen@igalia.com> wrote:
> 
>> On 26/03/2026 21:39, Alex Hung wrote:
>>> LUT1D_INTERPOLATION and LUT3D_INTERPOLATION are read-only properties but
>>> were missing DRM_MODE_PROP_IMMUTABLE and DRM_MODE_PROP_ATOMIC flags.
>> + Xaver
>>
>> So, I double checked previous conversation about these two interpolation
>> properties.
>> AFAIU, we agreed (?) on not making it immutable because it could become
>> mutable if a HW allows it.
>> -
>> https://lore.kernel.org/dri-devel/CAFZQkGyj7=N2UcbBnjv7Az3oHSD2LXaAx5wzccpSt_UEhH3NZw@mail.gmail.com/
> 
> Simon's rationale there makes sense to me.

Yes this makes sense and I forgot that we discussed it before. Thanks 
Melissa and pekka

> 
>> So, what's the best approach to inform userspace that they cannot change
>> this property?
>> Perhaps the driver has to reject if in the end the property is immutable (?)
> 
> If the enum is exposed with a single value only, then obviously
> userspace cannot program any other value.
> 
> Each driver needs to customize every enum for what they actually
> support, anyway.

As Melissa pointed out in the other thread, the doc said these 
properties are "Read-only" when they are not. Should we update the 
documents, such as below, to avoid confusion?

diff --git include/drm/drm_colorop.h include/drm/drm_colorop.h
index a3a32f9f918c..86d75babe30d 100644
--- include/drm/drm_colorop.h
+++ include/drm/drm_colorop.h
@@ -312,7 +312,7 @@ struct drm_colorop {
  	/**
  	 * @lut1d_interpolation_property:
  	 *
-	 * Read-only property for DRM_COLOROP_1D_LUT interpolation
+	 * Property for DRM_COLOROP_1D_LUT interpolation
  	 */
  	struct drm_property *lut1d_interpolation_property;

@@ -340,7 +340,7 @@ struct drm_colorop {
  	/**
  	 * @lut3d_interpolation_property:
  	 *
-	 * Read-only property for DRM_COLOROP_3D_LUT interpolation
+	 * Property for DRM_COLOROP_3D_LUT interpolation
  	 */
  	struct drm_property *lut3d_interpolation_property;


> 
> 
> Thanks,
> pq
> 
>>
>> Melissa
>>>
>>> Add the correct flags and remove the now-unreachable set_property
>>> handlers in drm_atomic_colorop_set_property().
>>>
>>> Link: https://lore.kernel.org/amd-gfx/dbb27ec4-cdc6-4ead-9daf-664d97e86cd0@intel.com/
>>> Fixes: 7fa3ee8c0a79 ("drm/colorop: Define LUT_1D interpolation")
>>> Fixes: db971856bbe0 ("drm/colorop: Add 3D LUT support to color pipeline")
>>> Suggested-by: Melissa Wen <mwen@igalia.com>
>>> Suggested-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>>> ---
>>>    drivers/gpu/drm/drm_atomic_uapi.c | 4 ----
>>>    drivers/gpu/drm/drm_colorop.c     | 6 ++++--
>>>    2 files changed, 4 insertions(+), 6 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/drm_atomic_uapi.c b/drivers/gpu/drm/drm_atomic_uapi.c
>>> index 713fa9e81732..e831894d5a51 100644
>>> --- a/drivers/gpu/drm/drm_atomic_uapi.c
>>> +++ b/drivers/gpu/drm/drm_atomic_uapi.c
>>> @@ -758,8 +758,6 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>>>    			state->bypass = val;
>>>    			*replaced = true;
>>>    		}
>>> -	} else if (property == colorop->lut1d_interpolation_property) {
>>> -		colorop->lut1d_interpolation = val;
>>>    	} else if (property == colorop->curve_1d_type_property) {
>>>    		if (state->curve_1d_type != val) {
>>>    			state->curve_1d_type = val;
>>> @@ -770,8 +768,6 @@ static int drm_atomic_colorop_set_property(struct drm_colorop *colorop,
>>>    			state->multiplier = val;
>>>    			*replaced = true;
>>>    		}
>>> -	} else if (property == colorop->lut3d_interpolation_property) {
>>> -		colorop->lut3d_interpolation = val;
>>>    	} else if (property == colorop->data_property) {
>>>    		return drm_atomic_color_set_data_property(colorop, state,
>>>    							  property, val,
>>> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
>>> index 398cc81ae588..34998f393f2e 100644
>>> --- a/drivers/gpu/drm/drm_colorop.c
>>> +++ b/drivers/gpu/drm/drm_colorop.c
>>> @@ -317,7 +317,8 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev, struct drm_color
>>>    	colorop->size = lut_size;
>>>    
>>>    	/* interpolation */
>>> -	prop = drm_property_create_enum(dev, 0, "LUT1D_INTERPOLATION",
>>> +	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_IMMUTABLE,
>>> +					"LUT1D_INTERPOLATION",
>>>    					drm_colorop_lut1d_interpolation_list,
>>>    					ARRAY_SIZE(drm_colorop_lut1d_interpolation_list));
>>>    	if (!prop)
>>> @@ -413,7 +414,8 @@ int drm_plane_colorop_3dlut_init(struct drm_device *dev, struct drm_colorop *col
>>>    	colorop->size = lut_size;
>>>    
>>>    	/* interpolation */
>>> -	prop = drm_property_create_enum(dev, 0, "LUT3D_INTERPOLATION",
>>> +	prop = drm_property_create_enum(dev, DRM_MODE_PROP_ATOMIC | DRM_MODE_PROP_IMMUTABLE,
>>> +					"LUT3D_INTERPOLATION",
>>>    					drm_colorop_lut3d_interpolation_list,
>>>    					ARRAY_SIZE(drm_colorop_lut3d_interpolation_list));
>>>    	if (!prop)
>>
> 

