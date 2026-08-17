Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A8BC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:36:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8BEF10E873;
	Mon, 17 Aug 2026 15:36:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="RLy0T37k";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011042.outbound.protection.outlook.com [40.107.208.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 457D210E873;
 Mon, 17 Aug 2026 15:36:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WJVQ59RjhVYvSk/0z8Teb3jtFuSgfCTuoP9kTUZlV+TRrXuGF5SuUmAGfjH5YnRHZ7u79Knital+x6+W3oERwwkKE5Tip2ABP545+SHpm1UzeGY8f0AWYReKHELfzXB+HqRAtLGrNLZh4sCJxiggXoczaLc+pdvSiSppcjapJK4xDsceOyv4vpgiMFw9sjSytV3bsSZpRo6PyWCvJJucD3PFBdBmcV6l9V08vVeFQjqTcufgFeKUlFFbsagQTwrTPSfFaMmwcUnFS/TyDkW/4hf98Nrb7CBSQMWnE4vPd+b93FgwGgvW1F72UJCbZBJAzeQSmt4oYGIuddXr9fiN+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eht0E/oVuN0tyvzM9XOBkZa3ZIjd5iFemMNdaaZRdx8=;
 b=fjzA9x7JjPpHDTuLLIUn9jVBZJFf5O8jlk9kiY1pAsBDRjVcDj8AfJsp4BXETYUqWsdaK/nxDMtcoVe8VyjHafulI7q0DquV2SSajwFrchixxxZ8rMkYRY0TssUqM8jDlS5w10dIqxLD52GDwoE3Wi8kNQDp8q1LmB7qghhHGVpCZaI1MwGTGgLR2KqCpearxUIzRdh4jR4WMF/M6xyVSlOH1hKv2UXYEF+PPvQEtNmrof4S4NCQuIX4tuMlN/MYB5WYeK2S/4UObPStpbuyI43yqxvYv4aJGd0RwpKuhafy/dyCESGpHhcoNvz7s7v3fy9FLeoJtI3Vu/MHC6+3BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eht0E/oVuN0tyvzM9XOBkZa3ZIjd5iFemMNdaaZRdx8=;
 b=RLy0T37kxod8HiR3d5sPidqU61ndy3v/dhrgrgEuILdtxLuZCzrAvd+yNEC6tswAkD0dBprI8tqoU0lJ059RljhtBEB6s3e/gDW20+wGRBTjHTX7jN9+J5oPJgtrlTv3snV06nBne4dRh8oYKyoF75NXmWgHQ+yhR7LNhpk1iHg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by DM4PR12MB7671.namprd12.prod.outlook.com (2603:10b6:8:104::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 15:36:42 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 15:36:40 +0000
Message-ID: <c9e2cbd8-b488-417b-8f37-e34aa0c339e0@amd.com>
Date: Mon, 17 Aug 2026 11:36:35 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] YUV conversion colorop with amdgpu and VKMS
To: Robert Mader <robert.mader@collabora.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Dave Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
 <c0d5a2bd-eb17-4ec0-aeb7-1fa9debb8154@collabora.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <c0d5a2bd-eb17-4ec0-aeb7-1fa9debb8154@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0189.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:110::7) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|DM4PR12MB7671:EE_
X-MS-Office365-Filtering-Correlation-Id: 025dadf1-385d-4081-6776-08defc7554e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|7416014|376014|6133799003|4143699003|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: q62VaaNaD6e9ByNPVQ1+GBJBFrZuXpC8distj9W5hdeoicfXcUEZa+wcB6RU/ktjE1eGc5bzUvmRkWwoh7iix43ID48KAzStbngEkftiMhJwHWPgrWkxA6U4+uVGBvzf7PhIg2X9UTeUPfB3wK6BzbrmrqUB6SQtNWd4x2Pmtcq/cDemhDdvnNI5D+SYXKgUwhbryfAszo9hYDWugPU+uluMn+4V2rvfTdMlFHUEeuBFyhQzbggL1qvZChtC5zJrM3OGKOSsFYIPHAG/ZgTnpVvWGIAd+BU8uATKy2C2CdAyMXNHnhT+5GG88oFXqWRmQkKsxep2zdaM98lfdiEskAxwX27lWpXWQZy178d/6CBIY6XLNYKy9RD0zj0cZ6FceBJ1Wi/y+BQBWRhIfzVk2gSTXscLQH2Q+2oGGZcUvlr61IoBIbEIMEmP4GFgnFWEMOx0wA5YkK97rfeD881JbAJi1L/WCq+t/AS7fKhplYgqMwLJtGdh/eZiUYDEqRlMfhDZg9Yqv5ImQgjjBpjuh/5UsmbJHsKKPWqmqs/vPJRkEWi9JOSmSUWJe/AB2xp6XfSoaupPvt4KGvC7ZmmlfwwUylltwRYyjGgRB2e9rYQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(7416014)(376014)(6133799003)(4143699003)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG94OCt1OWRFQ2xUakN6L1dSRmNvdkNkblR1U1RjMzgrN0g0cXdkWkpNTktL?=
 =?utf-8?B?d2NlOUpTV2lxazh5UnZVOFBWb2NRcEdNRnBqb05CcDA2RmM0ZkFvWVlPWlpj?=
 =?utf-8?B?Tjd1NXU3anFDWEVlRnU0M1N5RXBBV0thS1hpZW9IamJmUGRrdy9weERqTTlN?=
 =?utf-8?B?dlBuM3RwdTFrOGszVVUrdldPQXg1Y1VyQ0x2OUJFMkRxVGpHWHNuU2N3VHdn?=
 =?utf-8?B?Qzc4ZzAySlBBSVdHdVZZcy91WWR3TUR2NFBZNmM3V3NiSGZzbnAzRzRmb0ht?=
 =?utf-8?B?WEpyZVVMaFA4RzRQRjVJMHFzVWdKWnpodFhENG9VaDlnTnpVSWpyaGFCZVRs?=
 =?utf-8?B?R0FNUGp3djdpa0pnYU9PbTBHMmxFNGlJMlE4N0M0YmMvRmVXZ2plaEQ2YmFP?=
 =?utf-8?B?NmJUZWlXaTdkVVlZcHIybFpyaktXWm9NNlNVQm84aDFiSVlKZ3g1WHVJY2c4?=
 =?utf-8?B?aVAxMFJ0RTVKV1lmUW8zajllR0RtaEVic1lkNlhJbEZBcTFSM3VzdlovbGtx?=
 =?utf-8?B?SkpSZ0tEK3liUDdVbDZuTW1VWCtJYTRPeXM3ZzVsYWNuaDg5OHhQc1JJRjls?=
 =?utf-8?B?eWl1bW40ZUtUSnE1OUJvVU8xZDE3NnEzZXRlbWJlRk9Hc1BlNGZ6OG9hVWlm?=
 =?utf-8?B?UktiMTNsZ2U0ZUJGd1FnYlJkNWxRNW9KSmJiek10bUl2Mkw0eVNvVG1HNFhM?=
 =?utf-8?B?S3Z0SmphT0UwdzlRQk54SzBBTTFpWHYrWTMzZWY4enRhWlRYREVuNW1WNEVT?=
 =?utf-8?B?RXltRE1GM3ZFRk8zMWQ3dWlWWk1PVnpRUko5RGJHMEpva1AwOHJzSkhGeSs4?=
 =?utf-8?B?R1BoeW14U2FNSEhsYWxLOEVNK0RYZXZOb3JaSG0zUURaaVNvaFZxYzZWaytS?=
 =?utf-8?B?WVdBRFZJeXNpeG1tcno1a3k4R3g4eS9kZ3g1VEpRVGZQVDZNWkRIcFN0TGk5?=
 =?utf-8?B?VHh1YnBqalZ2Wnl0WjluSnM3VkR1a2pNZGtqakN6RWNqVWFJNlYwOHBjbTZm?=
 =?utf-8?B?VDZJdjlaZndMQTZCRUc1elAzSC9CS0k3YWRlUDJzOUZ5ZUNEL0dBN1lRSjJ6?=
 =?utf-8?B?clozbFQ4ZUgxK1NYWXVFY1piWUp3UUc2dGRxMGlLM2hWZFNxc2Q0WWx5V1RR?=
 =?utf-8?B?TFo3Nm1NN2JkVXVieFhkdUxrYWRRaTBtZ2tpUytCLzlOczJjVXBzU01jN1Ri?=
 =?utf-8?B?MUpRdTVYSEZKY09WZVRaRHlXaFc0WjZIWlUzQnhGWGRZTWJma2J5S21lYm4y?=
 =?utf-8?B?YmtBMjl0U1c4WjFKK0t6ZnFNT2VnQ0xQMk05ci9vNG91YjNDRnY5Y0FTd3h6?=
 =?utf-8?B?R0FoS0lFZEdBRGpDQittZVNvY0kzYzZMSzBRdEgxOXdkOVNUMCtOWmZiZUQ0?=
 =?utf-8?B?MFU4OUxnYmhWU1VDcXNtNXU2NXUxUmgxZzFMeDBlZXdLdFYzVGxQWVdYRzJF?=
 =?utf-8?B?QU5NOWZjcldqMG1YTFpHSW5QYk9Sd254UzROR3h0OU43ZWZVUjgyWDl6cUFL?=
 =?utf-8?B?anYzdkl4UWlId3J3YWp3TXRZcDVhamJmY041RFBlc1pXM2tYMUlKSHZ5Wlov?=
 =?utf-8?B?WUkxWndNWnVQdmlTSnBxL25OdzBJcUVGRmYrdnhjQjB1NTROREJxbC9KeXFX?=
 =?utf-8?B?cVo4YW5SWTBaYXZBeno5eTB3bklISTUzZE11bEZNMzBKSHZEZXZEdkdxdzZn?=
 =?utf-8?B?MkhJSHBCeXg2YnB1eTRab08zQktxRUtmcUNpTHRhbmVFY1FNbUhmRHhvOHBa?=
 =?utf-8?B?a3VZSlVkRkRYUnp2SThpSCs1M0pFUHNFY1VtY0lvbUd6dmZPUFhMYkFSV1pt?=
 =?utf-8?B?NGpnRDl6bVBNSGIrdXVQQzJuSFdlbnFlYkt3YWFnSE4xM3UvdERkNXdlV3pI?=
 =?utf-8?B?TytacE1ISllmYms0WUsySkNIQ1RmcGpQTDl2Yk5iT0ZyZWQ3UnFSNUhkcURY?=
 =?utf-8?B?RHFQY3FXUlpaSkorcWlrTmhLZlRxdVRoQ2pXV0p1K2VsbVJjcGFOTzlEbzNP?=
 =?utf-8?B?Z1lRTU14M0RsbkY5bEtRR2xkL1pLcm1BRTNNNkw4czhWY0Q2WXNZQkVlY1lt?=
 =?utf-8?B?VzdUdWpZRHc3Nk4yYXlLdmlqQzNSalpJalh6SUdRTit2K0t4aWtEWFN2NHc4?=
 =?utf-8?B?MHVyelZpaWVRRG8wVUhzeGhrL09UTU5CNUVBVmRiUjBhU3haS010aHI2dE9y?=
 =?utf-8?B?OVhWVGFnbjk0RmN4eTV6eVYyWnVhV29NQWkzNHJJNHpHd3NQRjdWOGFSUGlW?=
 =?utf-8?B?NG9RM0ZVNHBwTm5LTHF4aVRLUGFHWS95Z2JRQzltaDNEdjRubWdsZjd0ZzVv?=
 =?utf-8?B?alY2N2xGVzRtS1MxZUt6RFM5UzU1Uk0zWHZJaHVzSFdxbW5wQlN6QT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 025dadf1-385d-4081-6776-08defc7554e8
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 15:36:40.0340 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MBYlsJFc94ZXf8ljd9ADsBysGFSaB+f80lwJ12PsWN04lGdW9RM/Mq5+JsoR2nJvTOL84jF+zJNuBU/hpxyt/Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7671
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



On 2026-08-17 03:51, Robert Mader wrote:
> Hi Harry, thanks!
> 
> I retested the series with the Weston branch[1], both on an AMD device as well as the CI tests [2] with VKMS, and it looks all good to me. Naveen Kumar also confirmed that the corresponding Intel series works with the same Weston branch [3].
> 
> So I think we're all set, assuming we defer the discussed legacy properties helper[4] to after the uapi changes and first implementations have landed.
> 

Agree.

I'm still a bit on the fence about the value of the legacy properties helpers but might take a look again if I can find time. Happy to review patches from anyone else interested in it.

> Who's reviews/acks do we still need to get the series landed? I suppose one from Louis for the VKMS changes - and one for the uapi changes from a maintainer?
> 

Louis, want to review the VKMS patches here or are you happy with the existing reviews?

Dave, Simona, Maarten, Maxime, Thomas, would you like to review the uapi changes or are you happy with the existing reviews?

If there are no objections I think these are ready to merge this week or next.

Harry

> Best regards,
> 
> Robert
> 
> 
> 1: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133
> 
> 2: this also needs https://lore.kernel.org/dri-devel/20260709115855.53725-1-robert.mader@collabora.com/, but that's unrelated to this series
> 
> 3: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133#note_3615800
> 
> 4: https://lore.kernel.org/dri-devel/d42d5750-f3c5-4e2b-baa3-514b87e59e86@linux.intel.com/
> 
> On 14.08.26 23:18, Harry Wentland wrote:
>> When we merged the drm_plane color pipeline API the major gap
>> that existed was the lack of a YUV to RGB conversion colorop.
>> We deprecated any legacy drm_plane color properties, which
>> means that the COLOR_RANGE and COLOR_ENCODING properties can't
>> be used with the COLOR_PIPELINE property on a drm_plane. In
>> practice this means that we can't use a COLOR_PIPELINE on
>> YCbCr encoded framebuffers.
>>
>> This patchset expands on the Fixed Matrix colorop proposed by Chaitanya
>> and adds limited range variants of the YCbCr to RGB conversions.
>>
>> His full patchset can be found at
>> https://patchwork.freedesktop.org/patch/709860
>>
>> This code has been tested with IGT and an experimental KWin branch.
>>
>> All patches are now reviewed and tested. We have a Weston and
>> KWin implementation. IGT patches are missing one review. I
>> deem these patches ready to merge once the last IGT patch review
>> comes in.
>>
>> IGT branch:
>> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop
>>
>> KWin branch used for testing:
>> https://invent.kde.org/hwentlan/kwin/-/tree/yuv-fm-colorop
>>
>> The kernel branch containing these changes, based on drm-misc-next
>> can be found at:
>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/yuv-fm-colorop
>>
>> Further background on this work can be found at:
>> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>>
>> v6:
>>   - Fix fill_plane_color_attributes build failure in Patch 8 when
>>     building with KUNIT (Robert)
>>
>> v5:
>>   - Drop new VKMS kunit tests for conversion matrices
>>   - Added script to show how VKMS kunit test values are computed (Pekka)
>>   - Removed fixed-matrix enums for "YCbCr limtied to full" and
>>     "RGB709 to RGB2020" as they're currently unused by userspace (Robert)
>>
>> v4:
>>   - Specify matrix entries in docs (Pekka)
>>   - Squash limited-range enums into "Add FM" patch (Robert)
>>   - Don't reject RGB planes with fixed matrix in VKMS as
>>     we don't want or need to make a colorop dependent on
>>     the framebuffer's pixel format. (Robert)
>>   - Fix conversion matrices in VKMS and implement kunit
>>     tests (discovered while documenting the matrices)
>>
>> v3:
>> - base on Chaitanya's updated patch and rename code accordingly
>>    to Fixed_Matrix instead of CSC Fixed-Function
>>
>> v2:
>> - use Chaitanya's CSC_FF block for named matrices
>>
>> Cc: Alex Hung <alex.hung@amd.com>
>> Cc: Daniel Stone <daniels@collabora.com>
>> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>> Cc: Uma Shankar <uma.shankar@intel.com>
>> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
>> Cc: Melissa Wen <mwen@igalia.com>
>> Cc: Simon Ser <contact@emersion.fr>
>> Cc: Robert Mader <robert.mader@collabora.com>
>>
>> Chaitanya Kumar Borah (1):
>>    drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
>>
>> Harry Wentland (9):
>>    drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
>>    drm/vkms: Add fixed matrix colorop to color pipeline
>>    drm/vkms: Add atomic check and matrix handling for fixed matrix
>>      colorop
>>    drm/amd/display: Add fixed matrix colorop to color pipeline
>>    drm/amd/display: Implement fixed matrix colorop color space mapping
>>    drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
>>    drm/amd/display: Check actual state during commit_tail
>>    drm/amd/display: Set color_space to plane_infos
>>    drm/amd/display: Force GAMCOR for subsampled surfaces with
>>      PQ/Gamma22/HLG
>>
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
>>   .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++++-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 +++-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>>   .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  16 +--
>>   .../amd/display/modules/color/color_gamma.c   |   3 +-
>>   drivers/gpu/drm/drm_atomic.c                  |   4 +
>>   drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
>>   drivers/gpu/drm/drm_colorop.c                 | 107 +++++++++++++++
>>   .../gpu/drm/vkms/tests/gen_yuv_conversion.py  |  87 ++++++++++++
>>   drivers/gpu/drm/vkms/tests/vkms_format_test.c |  40 +++---
>>   drivers/gpu/drm/vkms/vkms_colorop.c           |  66 ++++++---
>>   drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>>   drivers/gpu/drm/vkms/vkms_formats.c           |  64 ++++++---
>>   drivers/gpu/drm/vkms/vkms_formats.h           |   2 +-
>>   drivers/gpu/drm/vkms/vkms_plane.c             |  55 +++++++-
>>   include/drm/drm_colorop.h                     | 127 ++++++++++++++++++
>>   include/uapi/drm/drm_mode.h                   |  12 ++
>>   19 files changed, 651 insertions(+), 79 deletions(-)
>>   create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
>>
>> -- 
>> 2.55.0
>>

