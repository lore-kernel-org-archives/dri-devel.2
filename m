Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95B91109C045
	for <dri-devel@archiver.kernel.org>; Wed, 25 Mar 2026 16:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F77710E820;
	Wed, 25 Mar 2026 16:58:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="cMF01w3P";
	dkim-atps=neutral
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011010.outbound.protection.outlook.com
 [40.93.194.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8235610E820;
 Wed, 25 Mar 2026 16:58:28 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=acDw+AvDZT0zm7GTkB4mGu8qwtEHSLDnnJvE0AvY2dKn6z8DGJTUa0YR27peDeHRet5mUP5IDBb/O2lY6IjpmJ2YFRWK8YKTZiSetGA6CwjVsk0CGU5SaAGnZ9zNmKxx3IFTCNrZWZfvssEvwC8UK9HhIphJNp1zKBF1oCTTrvyPs1ONBzmu4kRRisWxxmZxsogZJIKcYC4ojLafs2ry2qPOrnGvDyLaD//Colk0VkXwmZ9sGPJBCGohYr/fOOqaWoIsvqodg4XPhRtMWQih2IrcgqZd8zvuviWL/oQvSpwQAWmqTsYAvJTykLHQDNLu3d8QTOuMT90HliE62fgODg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a8+sTUOovXwqjlom9LmHCrDE6eFoKGZpp4wxT7H9hIc=;
 b=v9tMt3TlBWLyo2Xm5HQU5jlwcSpQPp6/RNUlnsuZg6LxdwrxNttXuFVBtuKAPxjV4naVVrX/dp/7AmIwWbGnJq2sMKCF9C8NUVlKJam4K6ABQLuvZ0UfsSwkynpY+2bLSC1TOiYAXinNGFQSGpL3hUdAAJ5IO7o4jogZdtZp3SoUS038Z27Lezmobni8cAFgdIASt8fa+1yVwO2pxdqRMmj0hTWtdTA7H4i1w0M8YT7I/jwXfo6H7KotKm5fVttaEU4llK1rixFfi7d11p0hl83BvDZVzRfB0w3k06rQLg7XFvzGKsma36+acZRI2UXc/PkqmKTnT3MuWXLT3rzxng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a8+sTUOovXwqjlom9LmHCrDE6eFoKGZpp4wxT7H9hIc=;
 b=cMF01w3P68pJit0kpFztzo3tOQZzkWCTrjF+use4oXy2prEdMObOHr2a1uwnlGYWJztC9XlOM9LpMvneZLKfQvBBFEV5fDgkJd2s1hL6gjKIO3XwN6i+VdH/utev1xQ3bwmhCFYFJYYAu+hEnJZiiJKT+qUH1OOsD8IQ8WMlmuE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 25 Mar
 2026 16:58:21 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 16:58:20 +0000
Message-ID: <968daa97-55cb-4cc4-b6da-def2376ef57e@amd.com>
Date: Wed, 25 Mar 2026 12:58:15 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 00/10] CSC Colorop with COLOR_RANGE and COLOR_ENCODING
To: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>
References: <20260317160350.229028-1-harry.wentland@amd.com>
 <9fbdff81-f909-4baf-9560-1104acf36ff0@intel.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <9fbdff81-f909-4baf-9560-1104acf36ff0@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQZPR01CA0186.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:8b::6) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: ffc51049-6d6a-4774-0595-08de8a8fb7b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: XReHvNuxMDzxXsFRxCo3YMNkYnpUbZXnLrhfmo/6eSVqkWikGVaddnq5UsdbKxa3TBL7ZHMQlFb9SaFgCFpWAnXIa6VLQ+rbtpCcgjPFEXOybaQ7RiVme9opv/avijENH+78Y8CiEkwgqoYTZQFSSpQONV7LDx+6Ku4tDYt4FbayRAIYFQHrPyrLBWCWVID0yh4INAqRgyNLQ6HafhiF1HpvnodNPY0bMvv4QXHTLxxG2SAfqzvLuHo1sAY57GLm3eGENPyNjgApnD1P7FtUIOYUq3m8TQZW0QjsnrAerjKvNQG3MIbM9nACjHyVmegIa3qA+42fHFJsjFS4sQc8Sv4U6DRYKq57kW15h4EjueH+dAGKsVW9Mc3didqQKhH9keqfO2u7EJWl8CZmKs7TRv5Gh97GokyoOCwFzkYHYcObpcJSa3HSyrDUvyjL4LyWl46DJP+0ulh2/7o5+Xz6Ne2+oMa0FY6QBDxucj3xcxcxH/RZRldKGPO7JVoAdl+lq7iYgZlXHTXm1P7EEgfzjTQBlkuYuSQwQQRil6TPooR+CFIWKsUgd/dhp+y2ZeYo6v4scrRMOnNwUJvGhSUyPx9jlZnq4r+9V/it9ealI9ej9h+CTTPMs/W/H0jv3iZSoRH8y/etlJoKlgSWNfSlqFxG1HQChdr/ofHGw5av2KVwb8A9gh2Ch8oHKHzLjmOl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktJdjM5U244ck1naU9sVEhaazNaVnVkcG14MVdWNUk0d2lOcjVMK2NkS2l0?=
 =?utf-8?B?WmF1R1Nhdm5OOTRKUVZERE80blQvRElheHdQd1UyR1dlKzg1S1lXRTBaZnBi?=
 =?utf-8?B?N3lRWTZCWjd0d0NHR0czeE53S1VqZ09qSmtuUjhiRnAxZnFjdmw3NzZRc3dh?=
 =?utf-8?B?YWo4aS9zNDNrL0ZmeVlRUFhjWkl4b3FQWEs2d1A2N0hhQjJqWmZ6TWxPNWs1?=
 =?utf-8?B?cFNyUmpvTEJOV2dQL2pTT2FVZUNHODJiQXUvSW1RT3VxdVIxTUVWdTVhMjA0?=
 =?utf-8?B?VTJlVFIyeVFub2hOc3hsb2RvWTdLVjZvYno2NFRjd05JdnlHV08xU1JvK296?=
 =?utf-8?B?dndISHNwbHdxTEVReFZVbW1ocWRWUWFQSUthc3dkVzl0cE16V3JLSHlucUh4?=
 =?utf-8?B?bmFwcWVIUWpxOVZCYzd3ZFp4VXpyaUphYlpOUzJYNlhOTU1rT1lTdDBFRXdi?=
 =?utf-8?B?S1lTQ0RxOUgyVFdYMWo5em9pdjZwelk0M2ZEWDhvZ1ZxL3ZtTHJodG1oRkly?=
 =?utf-8?B?RU1mcGplM3k0eU9ub2dyaWxIYWlnY2FkMStQWDdVa2lLbXVXRnVaVk5VZCtV?=
 =?utf-8?B?ekFHblpmYWYrSFAzcHBTYmtvay9sbGZXcFZKSDZ0Wm5Qd05HenRqSFVTOVVE?=
 =?utf-8?B?aytLU1dKUm9sM0o4bHJ4OGVhTTVld1BOcGxxSzJaY3FaZFVuUEFzRlZaZHVX?=
 =?utf-8?B?cVJxbUNwUHExVlc5bThWclp0ZmNRNXp4c092ODdFWTJUK0V0T3dvU3VIUDJ1?=
 =?utf-8?B?ZUJxWTlQRlo0c1lPU1phQnVxVDNESUV5N2libTVPS3ZKdmJsTk41RHFNNFhl?=
 =?utf-8?B?cWVoWjhzWnJRWm1ick5nWEJZOXZRYjc3NVdDSFBVWG8vbkU3amY3Nlhrb0E5?=
 =?utf-8?B?NTgyY3p5dHNFdGtTQjhBQjRibDhEbkNoTi9pUmovV1BPUmpFU3ZnbVNQb0pN?=
 =?utf-8?B?Ui9OZE9GRkZhUUZDVFk3elpFYWl1TXZmS2sxd1FtQlc2MEtQMkgyZjU4VDJk?=
 =?utf-8?B?OGc2K1dITlJvV2dib1JiRW4wb2t2dTlSaXRTZnZWU1k4SzZ3SkpNTG5wNWd5?=
 =?utf-8?B?WVMwQldKLythWmJoUDUxSUlGWDJtZUh4aFkvVG9nNWtPZitwTGNHeUVwS0c0?=
 =?utf-8?B?bGNDTmdxOUNmS3ZlVHA1V2VJNmlwbzVlVUJuaVZNNmpzT0JIbUpSNnZUMGl3?=
 =?utf-8?B?M1R6S1ZXMnBGZkVZWUpXN053NkFTMlZCSXJYaXErRHZvRkVLcHdhWWpBcktm?=
 =?utf-8?B?S0FpVm5NME95aURpSklLTE55cjVmU3FkVjJESHBEV0t1b3M0a0VGZnVpU2Q2?=
 =?utf-8?B?SUZYWnJpczNZcWxzdG0rUzBnYy9Sbi8yL0hEU3RLZ25ENHlIMjQ1MlJybUJj?=
 =?utf-8?B?TXptQWl0STBQVEcyUXVxU2I2K2cxSlNOL3ZNQ29Oa0FhQU9kMzUwQW13YklQ?=
 =?utf-8?B?c2xJQllmeVpudW1EVjRnMG1PQURSUmRjWHo2eXFxYkplMllCTVdKV0VzLzVN?=
 =?utf-8?B?U0J5aWpwaEJOT0VYdVBLMzBRTVJTc3ZZcTJnc2RWdWRBWjhWL0QyT1VLSHNS?=
 =?utf-8?B?S2c3c1BYZkRHME1qYXg0ZmMwejNhbXNjVkVVeU02K3p4VWQwK0F2NldtUWc4?=
 =?utf-8?B?alBia2xzOS9ETUo5UjRxUjdwUFZqYko5dlFqa2JQcGlGNXhUTit4M0NKOGRE?=
 =?utf-8?B?a1BpT3g0Y2NEeTVHVXJXak5Wa2JjdW5xTXhZTVRYMENwT3ZwZUtrR2VCell1?=
 =?utf-8?B?MXlDaEpEYnF4MnBTOGZMVGR6SEZuTTBWcnduQVVnRllWVWdXQXZnSjZaTWVX?=
 =?utf-8?B?UjFhdWdldXJtTktSdWdNSTFjZkp5T2hOM1pnSkhHRy8rdlRVd012Mlh4ZGFI?=
 =?utf-8?B?Z0dkQVhHeTNuU254OSsyMmdRQXIrWnVvVHNyTnNUM3p1bGpMMlh0dmNlemhG?=
 =?utf-8?B?ejl3Ukp0a0RFQnNzSnE2VDE3cStqMC9acmdCYXlwL1Q0OER3NTlOZllEalBJ?=
 =?utf-8?B?ZExUdWNJQVZtakNjckltdjRrbFR2S2dnNVlaV0YxRDNBdnI1bEpTZGw2bHFo?=
 =?utf-8?B?VkhhdGp6Y3JPaWNVdDFJTWVvYkgzZ2xGLzNyT1Q1cEgrTUJuYklEUkM0bXhw?=
 =?utf-8?B?SDYyRlQ5WllaYmxRbWR6bWFhd3U5ckhYc1h4TUhFRjFldkJyRGRNT0NlQlRC?=
 =?utf-8?B?OEs1ajNMckJNSkRCSWhIUC96eko0ME54dkxHTmxQdFA4SmF6OENYelM3bHdZ?=
 =?utf-8?B?M2xGNVNmMXYrL0RyZUtSa1Z4ODJJZGtwbXhxRlRoUjBLVm1JamJxbUp3ZTJZ?=
 =?utf-8?B?N1ZsRjRVa2h5MFZSQmpZZWxzZDh5eldkcUsxVGU3R1ZnRDdIanZndz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ffc51049-6d6a-4774-0595-08de8a8fb7b6
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 16:58:20.2235 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eAu8klcqpPizjq3rvnLnpKNUAZLJFxkw9lbzHuxG7nCdFkQlvYPxT+dZ1hxoGPTvftAXnsqQORpnWonWtzQkwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
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



On 2026-03-24 13:01, Borah, Chaitanya Kumar wrote:
> Hello Harry,
> 
> Few thoughts on the series from Intel perspective.
> 
> On 3/17/2026 9:33 PM, Harry Wentland wrote:
>> When we merged the drm_plane color pipeline API the major gap
>> that existed was the lack of a color-space conversion colorop.
>> We deprecated any legacy drm_plane color properties, which
>> means that the COLOR_RANGE and COLOR_ENCODING properties can't
>> be used with the COLOR_PIPELINE property on a drm_plane. In
>> practice this means that we can't use a COLOR_PIPELINE on
>> YCbCr encoded framebuffers.
>>
>> This patchset adds a CSC colorop with the COLOR_RANGE and
>> COLOR_ENCODING properties and implements support in VKMS and
>> amdgpu.
>>
> 
> AFAIU, while COLOR_RANGE and COLOR_ENCODING were plane properties, they were more representative of how the framebuffer provided to the plane should be interpreted, rather than selecting a transformation. So using them to define CSC behavior is bit of a semantic drift.
> 

I guess CSC is misleading for this colorop. YUV conversion would
describe it better.

> From, Intel's HW perspective we could re-use this CSC colorop but it would be
> preferable to introduce new enums like "YCbCr709 to RGB", "YCbCr601 to RGB" as discussed in [1]. That way we can still represent the "RGB709 to RGB2020" conversion that Intel's fixed matrix CSC supports (instead of inventing a new colorop). We might need to change the name of colorop to something like Fixed Matrix to be inclusive of both YCbCr to RGB conversion and Primary conversion.
> 

At the core your CSC FF colorop and the one I'm trying to introduce are
both backed by a fixed matrix. We could even express the range via the
CSC FF colorop by introducing full and limited matrix variants for
YCbCr to RGB conversion, like "YCbCr709 limited to RGB" (which is
probably the norm for SDR/sRGB) and "YCbCr709 full to RGB" for full
range YCbCr content.

For BT.601, BT.709, BT.2020 and full and limited range that would give
us 6 enum entries, which is quite manageable.

Intel would then only advertise the full-range enums, plus the RGB-to-RGB
CSC enums (like RGB709 to RGB2020) while AMD would advertise full and
limited range YCbCr to RGB enums only, no RGB-to-RGB variants.

If this makes sense to you I'll be happy to rework my YUV conversion
patches based on that. I think that'll work fine.

> Regarding the range property, we could re-use the COLOR_RANGE property as you have done. In the case of Intel, we would only expose DRM_COLOR_YCBCR_FULL_RANGE as supported for this CSC, and use a separate colorop to perform YUV range correction. This allows userspace to still pass limited-range framebuffers. I am assuming here that it matters for user-space if the conversion was done in limited or full range.
> 

It sounds like you'd need another colorop for range conversion. I wonder if
it makes sense to also use the CSC FF block for that and introduce a
"YUV limited to YUV full" range conversion enum. In that case naming the
op named_matrix, might work better, as it can express range conversion,
YUV conversion, and color space conversions.

Harry

> [1] https://lore.kernel.org/dri-devel/20260306165307.3233194-2-chaitanya.kumar.borah@intel.com/
> 
> ==
> Chaitanya
> 
>> An alternate way of possibly representing this has been proposed
>> here:
>> https://patchwork.freedesktop.org/patch/709860
>>
>> This code has been tested with IGT and an experimental KWin branch.
>>
>> IGT branch:
>> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/csc-colorop
>>
>> KWin branch:
>> https://invent.kde.org/hwentlan/kwin/-/tree/csc-3dlut
>>
>> The kernel branch containing these changes, based on drm-misc-next
>> can be found at:
>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop
>>
>> In order to successfully use this branch you might need a few
>> bugfixes. The kernel tree containing those fixes plus these patches
>> can be found at:
>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop-all
>>
>> Further background on this work can be found at:
>> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>>
>> Cc: Alex Hung <alex.hung@amd.com>
>> Cc: Daniel Stone <daniels@collabora.com>
>> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> Cc: Uma Shankar <uma.shankar@intel.com>
>> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Simon Ser <contact@emersion.fr>
>>
>> Harry Wentland (10):
>>    drm/colorop: Add CSC colorop type
>>    drm/colorop: Add CSC colorop initialization helper
>>    drm/atomic: Add CSC colorop state handling
>>    drm/vkms: Add CSC colorop support
>>    drm/vkms: Add atomic check and matrix handling for CSC colorop
>>    drm/amd/display: Implement CSC colorop support
>>    drm/amd/display: Use GAMCOR for first TF if CSC is used
>>    drm/amd/display: Check CSC colorop bypass before programming
>>    drm/amd/display: Check actual state during commit_tail
>>    drm/amd/display: Set color_space to plane_infos
>>
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 115 +++++++++++++++++-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  25 +++-
>>   drivers/gpu/drm/drm_atomic.c                  |   6 +
>>   drivers/gpu/drm/drm_atomic_uapi.c             |   8 ++
>>   drivers/gpu/drm/drm_colorop.c                 |  91 ++++++++++++++
>>   drivers/gpu/drm/vkms/vkms_colorop.c           |  64 +++++++---
>>   drivers/gpu/drm/vkms/vkms_composer.c          |   5 +
>>   drivers/gpu/drm/vkms/vkms_plane.c             |  50 +++++++-
>>   include/drm/drm_colorop.h                     |  39 ++++++
>>   include/uapi/drm/drm_mode.h                   |   1 +
>>   11 files changed, 388 insertions(+), 30 deletions(-)
>>
>> -- 
>> 2.53.0
>>
> 

