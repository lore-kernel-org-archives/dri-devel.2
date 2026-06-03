Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34134CD6E55
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 19:23:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 903971122CF;
	Wed,  3 Jun 2026 19:23:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="X40Bdnvy";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013071.outbound.protection.outlook.com
 [40.93.196.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A90151122CE;
 Wed,  3 Jun 2026 19:23:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2mE41xKrDWl9Fd4L9t9IdjKb4KSg3/t8S8FLBFOvTLZ09GObbFKSeizLNxYkfBkaVBZkZeSQW4BvKuKnDBypKqe0loezhBnDly1wa2R8IfCSDE/4RIDpZGPHLmSBRIMKqvUtJKu2bcMO5VOVh1XswpgD0mBLF33jHVzJd6yGy4DhrlcRqHh1QaEsFaPkvDdwlpP2tR4df8s+ateEtfiyk8OJ01kU5q7/Ynt3LHKtoFLIMdh1/brd8FqY5a5rn/YowbWr7vGbQY/HDG7axgXI0tlBRsQ3sXf3ExQ2HyOg2C+SOHcsyrKvC8Qp8ERB6IbZJXW0BKvHWbr67fCr99StA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j0hl9rU8rXEOGy6WatPA8Dp2Dw0HNKZkIsRFjIB56LM=;
 b=l7/DkA9Bs6im/23GpDXqDfzuVE3kP51GuNLrA+DCMrj/zAtMqWUpvhVlIiyY82A7xkxUncaMXwm7IcSTFpO7IFKW27hJb3Q63jDrBpPu6cHfjLeCkBz1DEOKcjy+kv3SpI0FXVLUrFK+HnQgAmp2uYnnHysoYXIYMBqaniT9ZLRHUfX1qlC9WUaMon2iLjtF90o4BsvlC8DHuys2p1k5J9bwL7THFvF/eJtWzbdZfc2dDII+ZH52qx7pfSG0M7h70l02r8j9Ssb4FJMHHY/cD8JGKVEFxoAfvx97nXCcI3g8MV60EkSlF00vFxOtP/0oFlR4nbiXAhIQ+4TIdGNTdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j0hl9rU8rXEOGy6WatPA8Dp2Dw0HNKZkIsRFjIB56LM=;
 b=X40BdnvylD43p8R3L5Kvbf4bOLODudCy14u0fFVJVVtHuSg70nlb41tc8nfynLAre7loEeHo0Is2o+RkcvvLMxqhQLEvc9XhqCuEQfjT9RpR0QzmhLw8T4FLSsjEDmdXb9NOU27pGqsxW20bn+jejHdHLdWOJPodpqKCK3/mSlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.15; Wed, 3 Jun 2026
 19:23:32 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 19:23:32 +0000
Message-ID: <d4cfb50b-3b70-4393-9d95-04566767c778@amd.com>
Date: Wed, 3 Jun 2026 14:23:30 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/amd/display: Avoid using zero AC/DC brightness levels
Content-Language: en-US
To: edson drosdeck <edson.drosdeck@gmail.com>
Cc: harry.wentland@amd.com, sunpeng.li@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, alex.hung@amd.com, Wayne.Lin@amd.com,
 timur.kristof@gmail.com, superm1@kernel.org, aurabindo.pillai@amd.com,
 ivan.lipski@amd.com, chen-yu.chen@amd.com, amd-gfx@lists.freedesktop.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260526210048.1162477-1-edson.drosdeck@gmail.com>
 <4ebe7f6b-aa32-4441-84db-1b09cc69c075@amd.com>
 <CAMSsBRw16QVwXCWWq0aeoKcqe9soBF9x_un6fGj5A4P+iVCv-Q@mail.gmail.com>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <CAMSsBRw16QVwXCWWq0aeoKcqe9soBF9x_un6fGj5A4P+iVCv-Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SA1P222CA0058.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:806:2c1::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 227d270c-fe85-4116-a06d-08dec1a599a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|18002099003|6133799003|11063799006|4143699003|56012099006|22082099003;
X-Microsoft-Antispam-Message-Info: Qo4KGChGpCReaV85QWFpFbdC+9oDN/2PVmQaNzqH4mgUYQGhtTEtmkvA8JCcXOgXvAOWFWV685BzM+Q29ndtbU41rm+IB6HOUETJmcRN6Osmdgqa6B9oaXbltgkOj5kZo8Lu5TAPsvJSMXfpiVaU4Eh8O78FiEL3cfjorXFUuWPWVLWuSc6WazkZ2TM5tKR7OyrrTPWr+nVoXs6rUs2Feof6pkKnX+6de/SH+jFlA2LbQdd1D5RnmZv1FJ4/0/+Geg7ZUUPSjW8LMS9zqOzbIqbNy1LtBAVbNPS4D9TPa9Z/hRHtcnGsArc6ElDW8BGQyAhJG+fs7h3DkmCH9J0qAVmM2J17yaWW4HLt5bqiTBEYN8Efxg5VTGVsWjVwdg66yraNYYP++SlmmqC6ichZ4TA6UuxjSyRwiLm4QE6/fFfglWWz8zBBdRl7sXB5LGuYm3/YVUlAkKUT+W1ijCDz5fdyyCt61vjXDuHiIktwmPoD+aWZU0Z1FgO7+DxFIZtBbaPWWt7FdMzB1Ocn6UVwFskpqXU47a+xsOA3g2bebkRMRk6GwZIsIKSgqWt/IFIbKgpwqTpH/iP954yX8Y06cDvss999VSJs94Odwx7nfqfG0lgu9trw6XmVQND2E6zs4+6iYOUCua8uHKRydHRgnQx18C/XzlmOkdpFea3ER1XRIcdaeO+aeCI8gbMIfgV+
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR12MB6914.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(18002099003)(6133799003)(11063799006)(4143699003)(56012099006)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Vm5mWkdLeHIrTjdwNjZRaG82R3BVS3RNRHlSc0V1eXEvME84VGZBeU1NNkNy?=
 =?utf-8?B?ajB4Z3BGa2hzS1dQZHYzTlpwNkhsMjRkNFd2bzNuWkZqTTFURDZCTDhWUmdh?=
 =?utf-8?B?aE4wMCtYeHMwR0ZnUzlvdUVHRDd6Wi84OGNJWTVEa2NtZFZnZnNKMHFuRmV2?=
 =?utf-8?B?YVJhV0ZMbmF0TzdiRjdrZk45OTl5Z3ZRRWtNWHpFYzlwQnRkUHBoRktiU2Jp?=
 =?utf-8?B?R09WVkw4NE45K1paem4vYnorMCtyNzF4TjVDeXRjR0p0bm05cTNCNUlGZ3dX?=
 =?utf-8?B?UnN6N2NQMWZZbHVSUENRdVZYcVE0NFVMKzRpNndvMnc4bCt4QzRLWnhQR3dw?=
 =?utf-8?B?YTA2Vld1NE5ZYXNoUTh5Z3F3dlNockxkYllzdGN4RkRmUHVuZUZrOWE0OUFC?=
 =?utf-8?B?QXllZnRzY0J2T2l6VnFSTEJEdjlPNjVTSjUrN0piejAyK3E2MTEwRWZSQjVn?=
 =?utf-8?B?UUNEQWdsRE16YzNpU3ZkOS9LOXpITHZCUDRMaWg3ZnhwZzdMbG5SZ0o3Vmtw?=
 =?utf-8?B?Ri92UlpBRVJkUEFQVFlwaVQyWGxBbW1nTDNXc2lRY3hVd0dXUFJWTkpyTkVa?=
 =?utf-8?B?dUo4aVJTYVNHdThEVG9PY2RPMk9DcWNUMnQxcEZOUnk3enVoNFlFbHY1cmJz?=
 =?utf-8?B?WmF3VUhKcDBnbkp6Y3dFa0VoTVRFUnZvYVB4QU1WeGdlZmV2QUxCR1dWbjhH?=
 =?utf-8?B?aXIrTisrSXM1UkYwYWRYQmxjVTVDcDhlUHpuZkFRaVdYMXNEMVBrWWdadTFl?=
 =?utf-8?B?dytsQW91WTFOL2tCNXhlci9HbHdjM0VxK2doaFNxWll4M1VlNlZmT1NyM1NR?=
 =?utf-8?B?TnJoR3d4cGdyRlNMbmlGY3BVbTYyYlY5ak5ya3ZIclczcXQ1ajdzYVNvMUR2?=
 =?utf-8?B?UUVhUUg1U3k0SU5FOUV1U3BabTBZcEtRSnlKOTU1NStiMTdGdi9Pd3dCSWp5?=
 =?utf-8?B?Vk42SlowQVVpazBnVFFhSlBCZWgyR2FibmJZNTEyN2Fqei85ZnR5dFhrajFk?=
 =?utf-8?B?N3lhZVgzYmJxVXdPYkxKb3B5ZC9nclZiM1V3NkZmditRaDdwQUlGK1pMcVJs?=
 =?utf-8?B?SjRrenhqM1IwUkMyMStVUkgwZWtBcDZPT2ZxNnlDdUZRTCtFazdVQ2RZS2Rh?=
 =?utf-8?B?TTR1MXNTRmZ4eWVOVGJielpSV1cxV2R4eTlwS3NWQjRQM2VXZTZRYVdyUFBS?=
 =?utf-8?B?bzg2RzJNVjdWZnJCY2JYV2IyeXZXL1dpQ2p2RkFsZ3NjTCtPYnNEM2F2a3l5?=
 =?utf-8?B?U0gwZ1dnVmQySWNNcjNER0NoT3pRN1ZoeVRMRFVoWWR4SjEwQjR5NjduemV5?=
 =?utf-8?B?U3M1NlE2azFsTER5VlhGSVJtQWdLaGhoZ1NmR2RuWUd4b1RlUmFJdWRYMkow?=
 =?utf-8?B?Vk9kc3hZNklmZytUV3h0TTNuUU5Jc3kydHFlaElScjV4YWVXL3hCeWtQWDJ5?=
 =?utf-8?B?MTdhL2hPNExBcG5hWTY3MU5aUE1zTG1DMFpDWVVWeFlkRndZVXlLTDdZZjcr?=
 =?utf-8?B?VDJWRWk4NGpOWVhIMGhpZzVyOUVCWXg1cVkzenBpeEt5dWoxZXUzSytKSTI3?=
 =?utf-8?B?RThXNEFRTDIyelh1WWZNTFpVN0RKeWx0S0UybTRWSDh6ZVNkejFZUFNVd2hp?=
 =?utf-8?B?czdCTTBhUUI4VE5FOW9RSzd1dHhJTFc4RXBhaS8zM0hvaTlaT04vcjhSNlU4?=
 =?utf-8?B?TEcvZkhPMnBEbzN0NEVGdjM5SzA5SVlXUWRrTU1XWHFzNDFDck93aXhBaFFN?=
 =?utf-8?B?NjdLUWVoRUZrQXlpYkNIOGF0Rjd3YjArWi9tN24vVzlLalBHYk9aYk1IQW44?=
 =?utf-8?B?N2tHVExCc1IwTW15S3pMcHdSRjdCWFFqY1orU002dFdpYXZqVERBNW52Tmda?=
 =?utf-8?B?ZWdSUVBYNEF6QTNFbGJDdkpHV2NObmM0MTc3R0FDUnV3ZytJNnVKUzRsN0tx?=
 =?utf-8?B?RHJWdi9wM05MeVN4d3l3YVlDL2JlMnUxR0VJV3huZ2E4U0J6Ry9lVWJOTllD?=
 =?utf-8?B?SmxKdFdET3JRNElNNWdFR2Y0RE5pNWE5Y1Q0S1MyeWoyZVZYY0RpczBzU2xr?=
 =?utf-8?B?SEI4KzN2aGlDbk9pRjRDMzVIVkhrOTVrRkZrRjJVenFrTjVnVDNBeHRJVlEz?=
 =?utf-8?B?anVoNmJicHBNK2RTMEpxQ1ZhQWE3RVEyRHNGaGhTTzh2YjBLZm1xMHZMbVRy?=
 =?utf-8?B?RjNmV1E1eCt0a21ET1dBRFJuMnhtS09WMnpySndNWHIzeWxNV2N1UTFOU2lL?=
 =?utf-8?B?UlRsaGl3SEdsMGVvOTA2Z2F3YkxxanVKdjVLVVlhSVZIemwzZk41NlhUVkpO?=
 =?utf-8?Q?op7NWRswaRF/ZTAXj2?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 227d270c-fe85-4116-a06d-08dec1a599a8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 19:23:32.7367 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6xB+0fwz22n7epo3j3fZCRXRL4S2OXZK6BCzBv+MHShI6EHKvF+AffsUhrhh6eKSy61ZS2ivxip3ylp34z+iZw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524
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



On 5/29/26 14:13, edson drosdeck wrote:
> Hi,
> 
> Please find attached the requested ACPI dump and EDID files:
> 
> acpidump.txt
> edid.txt
> 
> Thanks for taking a look.

Sorry for my delay.  I looked through your acpidump and you don't have 
an ATIF method (which would indicate preferred brightness values for AC 
and DC).

I had expected this case is handled by 
amdgpu_dm_update_backlight_caps(), but it appears that only sets min/max 
not ac/dc default levels.

Can you see if this helps?

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c 
b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 832223c06b3f5..e2831bf48eaab 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -5213,6 +5213,8 @@ static void amdgpu_dm_update_backlight_caps(struct 
amdgpu_display_manager *dm,
         if (!caps->caps_valid) {
                 caps->min_input_signal = AMDGPU_DM_DEFAULT_MIN_BACKLIGHT;
                 caps->max_input_signal = AMDGPU_DM_DEFAULT_MAX_BACKLIGHT;
+               caps->ac_level = 50;
+               caps->dc_level = 50;
                 caps->caps_valid = true;
         }
  #else


