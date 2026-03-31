Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8CA310F92E6
	for <dri-devel@archiver.kernel.org>; Tue, 31 Mar 2026 17:50:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 228C110E127;
	Tue, 31 Mar 2026 17:50:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="p9M69+N1";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011001.outbound.protection.outlook.com [40.107.208.1])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7911410E127;
 Tue, 31 Mar 2026 17:50:35 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rNZISi5AF1HelT7pIkw85yDYy810LOl4ma8Vc7pEIHoFYoqitG0d5/fyRCvVoVVYWzlwnAYg9hXd33ieXglhX2c9UIDPxPCWKbBEs1ZGN0ARatCWulRS/NrMcwvJD44xPFdROsD0qSclxNAk2FX/CSIGcPlq8Ksg/kuxCnGIulOj8cWn8AhYkEPDY5sdnB2gFR/KNaaozGpEVQI9e77ewatYfJqF5jeZLCTtNtXo4Nage3OvWXHXXFPOpqTfk7TIodpf0i1ZbAKNbp47OyUzbetVOdRccJixRUA9n1hUzWYVSBkqZBYo3hvzwKc7TSak+dXCrj19M8I4xKMkNKHUWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WhHOuKJe5cBUtABQGGvSmxfaX/HP3dV+/apY2K7zv8c=;
 b=pFOLuMgBrQuK2Wi0hwwc47X2FJo5DEpT6FHR8L/TS9sb5L4VuJB9pi9OtY2XlALXJxHO5OIAf5MJ+3jvrMW+Ztq0i4diBpZn2D/SlRXZ/lanNEQlRhAdSQq0DaMbp9y0KQT2wf8XVLSH12aJJoEwa6hjgi+Wp6UKeoK/MgH34MA7F0JhPnSJUkbqsBS9i09wey3vhjTk6w4D8zbbdjrSrVxTy48es0DpZ+kELPBdb6tbuht3CKYS90+ZzsIanFgQSyCcg0E/FTCR+dOy0EI0ZOoWfYC6Pd4Cw86Girx8BkHL1wwClt/6uI5c02h46l2QAMrl6OGIiLy7iASElLfIqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WhHOuKJe5cBUtABQGGvSmxfaX/HP3dV+/apY2K7zv8c=;
 b=p9M69+N1Y9lzjZpPYEdwUmJBL3ts1gh3S4444YfidzdFzSvTn3j01aB2e6PUwbVfqYds392/6si2UX5kilfxOgzZECfc9Ys4YLXwxwLIEWprplx1AwhUpcFmd3NTP/Zw+xKUaEb9Wpn33eWNCip3G+RVO1AcNBZ1B/E3OxC/yaI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5126.namprd12.prod.outlook.com (2603:10b6:208:312::8)
 by CY8PR12MB8067.namprd12.prod.outlook.com (2603:10b6:930:74::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Tue, 31 Mar
 2026 17:50:28 +0000
Received: from BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe]) by BL1PR12MB5126.namprd12.prod.outlook.com
 ([fe80::c3e7:1bc5:2b91:1cfe%6]) with mapi id 15.20.9769.015; Tue, 31 Mar 2026
 17:50:28 +0000
Message-ID: <7ae16b6d-5502-4f3f-9b2a-18189166650b@amd.com>
Date: Tue, 31 Mar 2026 13:50:24 -0400
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
 <968daa97-55cb-4cc4-b6da-def2376ef57e@amd.com>
 <aaedf481-9e32-4061-b7c7-8d5425f20526@intel.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <aaedf481-9e32-4061-b7c7-8d5425f20526@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YQ1P288CA0021.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9e::27) To BL1PR12MB5126.namprd12.prod.outlook.com
 (2603:10b6:208:312::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5126:EE_|CY8PR12MB8067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e117689-0357-415b-c0ae-08de8f4dfe9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|18002099003; 
X-Microsoft-Antispam-Message-Info: 2HlA8eL24JU6E810ofntNBks0cvcGn4mud7XyIAqh/0Bb1XYFdIfXSHl8KFC/xmwVesBwV/SK0LXezvCdZI+f51b/slZD82Aw+CFhxB0lyz5tL189BYXCe3ucM/H2gc4WXkSixzTsActDcuiJThBM7KpmTOCInWIG/G1yzB+CEOkQ3x4rtG+SsqvBK8Y1tv8eb07k11IvKUzdxXQvLNUr5QuYS6M4TCuec2X4Csw21m17c7ZJ9RYj61g+kMihNOYluODg93QE17kvPEFrEXcbigNZ+0izDW5nwQN4e1dviWOywgWMQABPXdQ2U9egqcvCcnrW1Ge2CdquHsuglsZ8oVXWTSRuLL6uBkhLil4r2Sc5LDVX4RHerOje4KnO1ex/qo0uEOPZm+VusncZ3zEAC6nV5CMQViGQERlZQFutnIngB1mj0HD7PcscIOoLa0TuqiuJuzsUDuBiuEfztYBAINV8QUzzfUPhPC6eFzG8Ktdt4bB6kP7/m7Dkz41eKWlf7uwKIxOZv6450S1sDXtDV6u2y8KYxCJLsFzklHqnQHp67kJF5b/DLzQqLdCF/cUY8ql++8dWW54EDnw9zT+DkLVMMDYFQg1B+51DF0Y8k0kjOKLmVqZqBVVk+DpLQz9+feOUYiqUxABSvjM85ObSdLQDfHmW9vKoF4C7VoJIxCQlAnOjeuF13T00uIp87we
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL1PR12MB5126.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ptd3N0S0dZSnpKTmxqbVRHTFFQaDJuUHErWkh2WXBaNHdpQkhWZEZGVFh4?=
 =?utf-8?B?RE9kbk51MUhwUmUrOFVtZ09WVUI4a3dQOEhxNjJLR3FrMXhHclFPekRQNjgz?=
 =?utf-8?B?SnJPMG1iQ0ZWY1lGYWN3Wmh3NkhsdVY3OGJ2SWVPaXN2MkptbEN5cnErejl1?=
 =?utf-8?B?SFoweVpyaGNub3pTbUFvb1h1V3RsM00zdTlEbWdmZEFjMHROcXJBYkZWRzNV?=
 =?utf-8?B?MFZtZU42aDQzQVVtbUhRK2Y1aGlxbVRMRGxSc2FXdFdNc08waDY5ZWxFRC9x?=
 =?utf-8?B?bTZZVzFzZGVtcVNGdEQ5Rk1RYmc4TTRna09SeWtGNVZTbFhDYkNuWVUyaVda?=
 =?utf-8?B?S0l2R3pwdVBTWTQrMTVRekxHQmZhZkFJdkx1bzJ6dmttSHl4Um56ZDQyQXFB?=
 =?utf-8?B?QnZ5WmtRU2lTTUtWVEJaRUZaNDdxQW5hQ0RJQUJPakttNEhTZnVJMFVoa3NK?=
 =?utf-8?B?SHlDNTAzZzZleHJVUGU1VjdMdjMvVkVHdC9VZjZuM0N1MlNLYXhxSzhGTkwz?=
 =?utf-8?B?bkthU2NrRVFLSjFRVHhudW85RlNzL3A1VjMxY3BSZGFueDYvVytNdEEvUG4x?=
 =?utf-8?B?VXA0ZUl3dmpkZThrWGcycjRIUWk3N3BVMUllN01ybklOVVVHVHBEWmRyNlRm?=
 =?utf-8?B?elhCbVFXaHRTeEZNaVlnNlJKb2hwZXkrL3hOWEVqTTY4NFhvUVNlcm1CY0sw?=
 =?utf-8?B?dHBycHY1d05UQ3ZBOTJxb3JCaXFiQUJ1a0xHMnZtS3FUazBwa3g0SFR6Wll6?=
 =?utf-8?B?Rll1Y2JqMytJZkphKzBNb01MWks1VGZ5T3ZwTm8yUUdUZHRzSytHa0pQa0Y0?=
 =?utf-8?B?RlNqSjhRZ2VIY205SzArbWM3VVFDWnd3NWRqajFKYUVDby9sZXRic3plcXY4?=
 =?utf-8?B?TGF0SU81aTFwSFVJbmRXUkZCSWhJbnNpN0Q4d1hHS1hpNEkvaGtINVg5dG4w?=
 =?utf-8?B?NGtqVEU3NUo3RkpySHkreFBxRmFFT2dmbDhLL2lsWlJzVGVUNG9ZVmxDemdp?=
 =?utf-8?B?em03VHVUMjE3WjQ4UFJoWi9uL2o3WnpJUnBCcllmckFaZmhrTUN0aDFidG1o?=
 =?utf-8?B?THZLN1NjcURvbm5sVVc0MngrYk1qNy9IZElVckNOcTZxNzI1ZnlRWDdOV0Zt?=
 =?utf-8?B?MWJ6a1lLUitqTTQ2UUdON0NRN01keUxEZnVkZTRSVUZBK0hjT3R2U3UrS2ZE?=
 =?utf-8?B?azFoaitZZXJmekdVN3Y3Q0todVNRbHVZQ3VJK1hJdUxQTnJZUTREM0xxU1Ra?=
 =?utf-8?B?UGZwUmhEMDlZQnlNVjZMQTNUYTcrS1o1cjBVSnBtSjBUdjZTR0VUeU0rd3B0?=
 =?utf-8?B?Qi96YllvL3NtbytlTk1SNFB6SGFpbDBRZm11elJ1Uk5WRzhWeEVIZzIwSWpq?=
 =?utf-8?B?bWw3OVljbHhUdmZFT05XY1R2bk1CYW1jdlZtaHdyTURmbTlSTVRjU1R4N0tx?=
 =?utf-8?B?eHdlcDB5UitzMkE4R0w2RlcwRWYvNEdQNzdjVEtwd050QWt4NFk2OExJZGt4?=
 =?utf-8?B?Mng0eGpDbm52SmJZZkNmbEtva3BuVU5QNGdzMjJnQ0xvUkRtckNrSDF1NWg5?=
 =?utf-8?B?WDB2VTZIN3I2NkM3SjIwM21RQ0tXQWhpa2I2S0txRGFQaGpBaHBKclphVVc5?=
 =?utf-8?B?NTNzWDF3dG1JbVBka3pHRUVWZjdyNWQ0N256K0UrektpMU14VnozL3c5NHQ0?=
 =?utf-8?B?VmlYaGhUNUhxaVhHODRPajE2aVplOGdrQXlsQjNHdGo3Mld4YVkrVDFtck42?=
 =?utf-8?B?Mk5EWU5XUDI5b0tYdVJwN0NRYTl4K2lTUjk2L2tEeUFJOHNnS0Q4MEIvUENN?=
 =?utf-8?B?ME5wYlNBRzlYOXF0amtQUmcxZEFuZlh4NlNjVjZKNmpSSHBwRWZScE1JUUZk?=
 =?utf-8?B?MjNmek5BSVJoanZVZEhFMGhWek5Ja1B2Q2ZKaVkzamIvQlBLUlpMQ2pQa09D?=
 =?utf-8?B?SVhvUXYwWVJOdjdIZzBUN1p4MmExL2VlaSs2L1NsTU0vMzE1RmZoVXBDSTNP?=
 =?utf-8?B?RnBEMytjMWlxbFRQZldOSy9TeVRaNytOUS8rN1VRK0tvK3Z3aElNSG1nL21p?=
 =?utf-8?B?MXFzeWxKQmtkMllYUGRleUtVMlN3WkVjcW9wZmljSnF2bXB3U3JxMVJnT3Yz?=
 =?utf-8?B?S2Y3ZjF1My96YkM3MWl4WXUyaXZQNWtRRlZYNFdHQ0gxSjVCTmtHMi8vZGY4?=
 =?utf-8?B?dGQ5UTBYakEvdzc1cUZVQ3dxSThubjlnQ1hLS2x2S1FyRUY2aGZHMFJ2SU5w?=
 =?utf-8?B?UjBBL0pkN1grQ2syd2d0U3lwVVVPYVVxMlhtVGF6S0FJVzltSFBzVGFFQVBl?=
 =?utf-8?B?eGY3TnJ3L1FMWkJPVGtjd3NnU3lHaUVDTmNtUWZralE0ZnFVK20vZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e117689-0357-415b-c0ae-08de8f4dfe9c
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5126.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 17:50:28.1520 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DhAEh/Q+XDZC3Aep+imCzWJpRRjde03bj4P5yp+NmTkNYnCJ68yzOfeg/HmbyW6ZzSkByIRwlQ/PNUkequA3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8067
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

On 2026-03-31 13:31, Borah, Chaitanya Kumar wrote:
> 
> 
> On 3/25/2026 10:28 PM, Harry Wentland wrote:
>>
>>
>> On 2026-03-24 13:01, Borah, Chaitanya Kumar wrote:
>>> Hello Harry,
>>>
>>> Few thoughts on the series from Intel perspective.
>>>
>>> On 3/17/2026 9:33 PM, Harry Wentland wrote:
>>>> When we merged the drm_plane color pipeline API the major gap
>>>> that existed was the lack of a color-space conversion colorop.
>>>> We deprecated any legacy drm_plane color properties, which
>>>> means that the COLOR_RANGE and COLOR_ENCODING properties can't
>>>> be used with the COLOR_PIPELINE property on a drm_plane. In
>>>> practice this means that we can't use a COLOR_PIPELINE on
>>>> YCbCr encoded framebuffers.
>>>>
>>>> This patchset adds a CSC colorop with the COLOR_RANGE and
>>>> COLOR_ENCODING properties and implements support in VKMS and
>>>> amdgpu.
>>>>
>>>
>>> AFAIU, while COLOR_RANGE and COLOR_ENCODING were plane properties, they were more representative of how the framebuffer provided to the plane should be interpreted, rather than selecting a transformation. So using them to define CSC behavior is bit of a semantic drift.
>>>
>>
>> I guess CSC is misleading for this colorop. YUV conversion would
>> describe it better.
>>
>>> From, Intel's HW perspective we could re-use this CSC colorop but it would be
>>> preferable to introduce new enums like "YCbCr709 to RGB", "YCbCr601 to RGB" as discussed in [1]. That way we can still represent the "RGB709 to RGB2020" conversion that Intel's fixed matrix CSC supports (instead of inventing a new colorop). We might need to change the name of colorop to something like Fixed Matrix to be inclusive of both YCbCr to RGB conversion and Primary conversion.
>>>
>>
>> At the core your CSC FF colorop and the one I'm trying to introduce are
>> both backed by a fixed matrix. We could even express the range via the
>> CSC FF colorop by introducing full and limited matrix variants for
>> YCbCr to RGB conversion, like "YCbCr709 limited to RGB" (which is
>> probably the norm for SDR/sRGB) and "YCbCr709 full to RGB" for full
>> range YCbCr content.
>>
>> For BT.601, BT.709, BT.2020 and full and limited range that would give
>> us 6 enum entries, which is quite manageable.
>>
>> Intel would then only advertise the full-range enums, plus the RGB-to-RGB
>> CSC enums (like RGB709 to RGB2020) while AMD would advertise full and
>> limited range YCbCr to RGB enums only, no RGB-to-RGB variants.
>>
>> If this makes sense to you I'll be happy to rework my YUV conversion
>> patches based on that. I think that'll work fine.
>>
> 
> I see you already have floated a new version of the series with this change. It should work in principle, I will have a look. Thank you for the changes.
> 

Thanks. Looking forward to feedback.

>>> Regarding the range property, we could re-use the COLOR_RANGE property as you have done. In the case of Intel, we would only expose DRM_COLOR_YCBCR_FULL_RANGE as supported for this CSC, and use a separate colorop to perform YUV range correction. This allows userspace to still pass limited-range framebuffers. I am assuming here that it matters for user-space if the conversion was done in limited or full range.
>>>
>>
>> It sounds like you'd need another colorop for range conversion. I wonder if
>> it makes sense to also use the CSC FF block for that and introduce a
>> "YUV limited to YUV full" range conversion enum. In that case naming the
>> op named_matrix, might work better, as it can express range conversion,
>> YUV conversion, and color space conversions.
>>
> 
> Even though limited to full conversion is not strictly a matrix operation, I guess it can be re-presented as one.
> 

True. If you have a proposal for enabling range conversion
on Intel HW I'll be happy to have a look. At this point I
don't have a strong opinion on it.

Harry

> ==
> Chaitanya
> 
>> Harry
>>
>>> [1] https://lore.kernel.org/dri-devel/20260306165307.3233194-2-chaitanya.kumar.borah@intel.com/
>>>
>>> ==
>>> Chaitanya
>>>
>>>> An alternate way of possibly representing this has been proposed
>>>> here:
>>>> https://patchwork.freedesktop.org/patch/709860
>>>>
>>>> This code has been tested with IGT and an experimental KWin branch.
>>>>
>>>> IGT branch:
>>>> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/csc-colorop
>>>>
>>>> KWin branch:
>>>> https://invent.kde.org/hwentlan/kwin/-/tree/csc-3dlut
>>>>
>>>> The kernel branch containing these changes, based on drm-misc-next
>>>> can be found at:
>>>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop
>>>>
>>>> In order to successfully use this branch you might need a few
>>>> bugfixes. The kernel tree containing those fixes plus these patches
>>>> can be found at:
>>>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/csc-colorop-all
>>>>
>>>> Further background on this work can be found at:
>>>> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>>>>
>>>> Cc: Alex Hung <alex.hung@amd.com>
>>>> Cc: Daniel Stone <daniels@collabora.com>
>>>> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>>> Cc: Uma Shankar <uma.shankar@intel.com>
>>>> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
>>>> Cc: Melissa Wen <mwen@igalia.com>
>>>> Cc: Simon Ser <contact@emersion.fr>
>>>>
>>>> Harry Wentland (10):
>>>>     drm/colorop: Add CSC colorop type
>>>>     drm/colorop: Add CSC colorop initialization helper
>>>>     drm/atomic: Add CSC colorop state handling
>>>>     drm/vkms: Add CSC colorop support
>>>>     drm/vkms: Add atomic check and matrix handling for CSC colorop
>>>>     drm/amd/display: Implement CSC colorop support
>>>>     drm/amd/display: Use GAMCOR for first TF if CSC is used
>>>>     drm/amd/display: Check CSC colorop bypass before programming
>>>>     drm/amd/display: Check actual state during commit_tail
>>>>     drm/amd/display: Set color_space to plane_infos
>>>>
>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 ++-
>>>>    .../amd/display/amdgpu_dm/amdgpu_dm_color.c   | 115 +++++++++++++++++-
>>>>    .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  25 +++-
>>>>    drivers/gpu/drm/drm_atomic.c                  |   6 +
>>>>    drivers/gpu/drm/drm_atomic_uapi.c             |   8 ++
>>>>    drivers/gpu/drm/drm_colorop.c                 |  91 ++++++++++++++
>>>>    drivers/gpu/drm/vkms/vkms_colorop.c           |  64 +++++++---
>>>>    drivers/gpu/drm/vkms/vkms_composer.c          |   5 +
>>>>    drivers/gpu/drm/vkms/vkms_plane.c             |  50 +++++++-
>>>>    include/drm/drm_colorop.h                     |  39 ++++++
>>>>    include/uapi/drm/drm_mode.h                   |   1 +
>>>>    11 files changed, 388 insertions(+), 30 deletions(-)
>>>>
>>>> -- 
>>>> 2.53.0
>>>>
>>>
>>
> 

