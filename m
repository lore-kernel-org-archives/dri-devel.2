Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19507C5B572
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 20:31:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2480410E5AB;
	Fri, 14 Aug 2026 20:31:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="jEpw41E8";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011060.outbound.protection.outlook.com [52.101.57.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E54E410E5A1;
 Fri, 14 Aug 2026 20:31:37 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQLNKMtWa/LBUr89MH79v+6xE0T+2yiFPTCX9PPWBi0BnOQET48gcZmNJR94Z8NaaMl37xkn3XEbAMy5nKz/dbCGyXWh5ZB9sqa+9hFDnqPk8WAFWlzhBwsYxNsR5ftpqtdyajZTCJWYtuirSXNQTcZ3eHe8Q/iUeXCKHb98Ow7VA3TwEqWTJD4nfrEVbuTvCGbfy41FUxTX5w3b9KC+HLIUDwQs7AQg3cyrMAgcgWpvZjF2JuhTxQbP9aj2C7gJND775iW2TFYa+xzEDCzqk1RFyT2Y3PhNR8ifIdaIVNEZTrAY0WxqhTmx4fvmCrri/1QQazo7zrtRQ1d4nlFcCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UzGYElRq7M/pdrZBndGGl191YdiqIPLO3tPic86pJ10=;
 b=xfvkg2V8ZXke0p2L9I4NLpkxlhkn8Qsj/b2sPnwpw/++0+1hMKfD8YrC2uYmOXOMGRObQN+wLwUNS7NPdv1qacwqt1yUTCdWSPjaOjpBeJBW/xvQpS7Tlsrhp4+um4ZHrnI+OPFPrz1LuLCs8XiVtLhZjY/cjvgFxEwFvejsiUIGlg6TofJ41aW/MlbZp79OxRdFPcFnWbnhwGXPAOumo5QLEpqw5ucsBFvrTEZvAM9emY/HUnvNnu0r/AH6EM3CITkGywjjDeOp7IHfq6J3ksDBKbq8/yzsYnbLZobdrksXUt2MCvaBp01TjjKQ2wnxvi+WoU3EKvGOcbQC2oLWFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UzGYElRq7M/pdrZBndGGl191YdiqIPLO3tPic86pJ10=;
 b=jEpw41E8SpR0pxc0cTbAS95bGZ4tL1sc7ipNKORtUq7rTEYnYmb3/KBYyt4fqfX6CSfw9hkM9cNx30lmBVdH0oace7eTQ2Hm3DBSD/lMdFRGSPeHWeKs/0GC7ybYjL96xIEz01mDkOaJrZQqNKxDtwZHB4o/i/B5miPw3LFMkYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by MW3PR12MB4457.namprd12.prod.outlook.com (2603:10b6:303:2e::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 14 Aug
 2026 20:31:29 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 20:31:29 +0000
Message-ID: <f41d6026-0709-4ac5-bd45-5392b8a89ffb@amd.com>
Date: Fri, 14 Aug 2026 16:31:25 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/10] YUV conversion colorop with amdgpu and VKMS
To: Robert Mader <robert.mader@collabora.com>,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>
References: <20260731181521.681990-1-harry.wentland@amd.com>
 <1df8715d-5b2f-4c66-9960-635b65dd8e9c@collabora.com>
 <8615b361-d250-4fb7-b0e3-057f2ec6786a@amd.com>
 <2a5246dd-6a98-487f-852e-21423edf071e@collabora.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <2a5246dd-6a98-487f-852e-21423edf071e@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0156.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::10) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|MW3PR12MB4457:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f94ae8c-141c-4a8b-5505-08defa43051d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|18002099003|22082099003|56012099006|3023799007|11063799006|6133799003|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: AowIGNVm5XIckVBgAVfbI5KInseFIT1Y9fnAzn7wCcnQpUgcjW4DrjdiPzJT44nO9+6pOr72/QUxv9byS+U65EMGY9s4LwyH8GbQXaPKnnLGAq41xl0b866QkF/7OsJeyjenQ2hBfhWbmuxbjFmX9oJQVLdUkGus5Zr9RP+2MSte4tSMm+Cm18cxY0WFzcZ1RLPfLQPQZklyTQhcSsl+6Xb+7fUDO4kJkao0zSxPHROduEyQyQgOWzUgs/UJijhDIjVhFoUj1oGlgScVCuf+Hbd1H/H5nHqKueBgupbH70xkn+NK/F00inTLEv1liO6c4INBXYutB7kgFO4xnWjPaBRp8toVy42IpqU2bSHJthFMJSQI7q/VjIc1ybg6X9C28astMPByLqjKyJBLCE5P8Imxav0bw0vysMZf8dTW76LwSn1S/k6nAugH/7yFXYWR/OJImzwu8eaqTEyDPHQtq8IK1PDjsmtxkX40SiD7fwpXfSSY57HPPJ7DFfUh9e9eHtPNK9d/VjTeNB6ptDOyXm8B+VoryJAwuZIdpcsDm2dLyjmeO+GZoaRWU5Gcya3HqafILQjaGhscF8htoJmmEdCTY7b6bVxOEhtIR1yxTzI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(18002099003)(22082099003)(56012099006)(3023799007)(11063799006)(6133799003)(4143699003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXM5NkVUSDh4MDMzZnZjb2VSaE9KQnNuYytWWmVkNEpwaUQyUmR1aGg3WmJW?=
 =?utf-8?B?cmVZS1plby9aTkEzMUtiK25vRUZLU2MrTWkvU0N4UVYzZWljVS9SQzBaN3I2?=
 =?utf-8?B?RzBJL2YrdTFlM2VLeFVEYWF2RlRuem9GditsZ2cxK3V2d2dQMCtYVHlsR2tY?=
 =?utf-8?B?VWNuMUlYSWY2YXNIRWs3ZlVRSW9GNWh6Y3ByRDRyaXgyTHFleG9hVWRlbFpD?=
 =?utf-8?B?WHAxNkVCNUZZd2JSZ2haZXZabXphSzd0K2ZWWjZhUFd1UElMWWYwckJZT2lR?=
 =?utf-8?B?ckwwTFZ5bndCbldWNjZnYVVsT0xCZmRWWGlwS1lSeE43MEYwM3JMcXV6VGs2?=
 =?utf-8?B?UUpyWEg0SmlaZUJxNUptbGRnOFljdXc0clVja0F1NHhiQXd2dE9HNEVoWlJ3?=
 =?utf-8?B?T01Vb0hJR2tzTXpnRVBFTjk0cm9xR2FZMjMrcnlWNm84S0lDd0o3Y05qV0cx?=
 =?utf-8?B?OGZlbWkzS2hGUWZMWUM4Z1pjL0pLZmZLS0tKN3ZITGphNjZndXM1U2RJRnJt?=
 =?utf-8?B?Y1QrMnpZeDJ1dTF3TTlnazlIVnpwMmNFRDBOSlE4aWlWRXFhNi9TcGxIb1FI?=
 =?utf-8?B?Vlg0NS9SSGFkYWVRaDlidnZGWktWTlJUNzMzMDF3OHdTQk8vTUFiam5qd0xW?=
 =?utf-8?B?UkRZQ09OSUZ0SElVSi9LVlFpM3UwT1ZOa2pIRjE5UXZhY1NsbTM2TEhSZkhw?=
 =?utf-8?B?aGhlWFlTN1ZueTRubFllZWRndkNlNGMxeDFQaEE3dVRmVVB2Q1dtZTNuVWt1?=
 =?utf-8?B?dlZ1a1g4Q0FFQ3BUeDZxWXNxbW1GWDB1cndoZmRRZFVpcjdjaUVwTjh1Nk9q?=
 =?utf-8?B?TFNQYkszWFNTaEVtODQ0L3BoY0J4MzZNcmd0RG14U05scG1UM2tVaVRnUWZB?=
 =?utf-8?B?NVJzSnp5SnNaQjk1SU9uN0dwZ2JUcGh6M3lsWktFTWFWT1duamRBYTNzVW9o?=
 =?utf-8?B?cE14d1YzVDYxSzFGeUVlaE5DMzFjZlB6Z0NNQmFNaTM0WlI2ejJ4cDdhUHFi?=
 =?utf-8?B?aUY1anJrR0JFRkFDS0FldkJ5b1pLbmMrTHFuK3VHaWtaZGVSTmxJV3dFQjJr?=
 =?utf-8?B?TW5zejFUdDdLdUxMZGQ4RXh1WFE2Z0tQQXJNS2JmQVFWUzJkVFQwY0tScWFw?=
 =?utf-8?B?VUVPV2hCUzNsOUVISnpaZ2xEOE1hQUUrK0FrOXFhYnI0clpCQ0Y1aE02NXFL?=
 =?utf-8?B?Vk5heWdTa3FkUjFOUHVrOWZ6RDVqbTNMRHVvL0IvMGZVMUlaNm4rS3Nibk5J?=
 =?utf-8?B?SHhqcUJVSmxWRlJLNUphVzJ2aWNVdG14Q3YxanJrRmNHUVp5VDZ0bDBpS1Y5?=
 =?utf-8?B?T2hvWXB2MGF1eGk5dzVGK3BlT1ZwaFlhcjZZVE1xUUk1bytvaU1CWjB1SjR4?=
 =?utf-8?B?K2VVbGk0VjZCTkVpUTY1TkpNMjVtdmROREkwakhhMVhMM0xNeGxTRTNKcW9a?=
 =?utf-8?B?UXVpWWx0WDFKY2NkR1p3V0xTdndzQ0NBOE5HN2xPUkQyMGQ1blR2NHMzNmFJ?=
 =?utf-8?B?aXE1cnlKZWcya2djTUlHM20yQ1NYMk5XeWlYRmI3TFhZZnV1RnpocFhBaWdX?=
 =?utf-8?B?Nkt3ZWI3Kzc1R0dXcm4zbEs1blluY1BMRnRrSnRPbWUxNmVNRm9NNDN0eFVZ?=
 =?utf-8?B?Snh4YVNDVzFRTkh3SmRXVXlIN3RXQmpudngyUWVMdmNiS0JUV1cwZmQ2bmJi?=
 =?utf-8?B?OU13ZWo0ZmhHWFovUnFZSjkwQWh2MGNIOHJ1NnUyZEo4UDNRZ2RyVSt6cmsz?=
 =?utf-8?B?S2xTUEMrQXVwSmVYVFZrNTQvdnNqejR4OENVZXZzWGZ3TS9tUXFJSWtwam51?=
 =?utf-8?B?WHY1WDlBM1ZtcXBnSE5XUk8xTDBWalJucERvaTU0TUFWYWg5ek1KaVNuQVF6?=
 =?utf-8?B?V3Awam9qQlJGZTFnV3hJeEkzZ0tzNzFSSU1Jd0F2dXFjL0R3M2JzY0JKRFFj?=
 =?utf-8?B?eXZLbU1HRHBqSGZ5eWRMdDZtRWRFODMzUW5VUVBCUjJZMXBNcXdYN2RucURD?=
 =?utf-8?B?clRyekx4Q3lWZnY2K0tpYVVXQWpuR3lFb3hwVGkwVkNCcXdSb29uaXZiejNu?=
 =?utf-8?B?QVFvMlN3NUVKUGNZc3hKakVESnc1YTBNc0ZScmM4bENqWVZoUnZDanZlZndH?=
 =?utf-8?B?QnR3ZGNWaVc4M1U1ODR5QVlsUzFFRUs4NitaL3FoQ0Rvc0kzN3hJNzNrbUVr?=
 =?utf-8?B?RHR5Q1JRUlhOcytkMUhxZXQyWE5yZG9KOWEwbGxLUElQOUpjVGVQL2RlN3Nq?=
 =?utf-8?B?TVNBcHV6d0tnR3c0YnBxbDZaZVRubjEvREF5TG85bkxpdUFxUVJwOUxBcWJk?=
 =?utf-8?B?QU1CL3hDYXc1THFKVFl6TG1jZzVzV2NKUlpidEZFWmNlMDJvaDc0Zz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f94ae8c-141c-4a8b-5505-08defa43051d
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 20:31:29.0691 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wtx0WTTPXhqVVCfUIU9mjinslPKbtaFB7kbnVSmK4RCE/E4JRS8GubRjXPxR0imh8OES8sTYFO3jzdzB04t5CQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4457
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



On 2026-08-14 16:03, Robert Mader wrote:
> Hey Harry,
> 
> "[PATCH v5 08/10] drm/amd/display: Check actual state during commit_tail" still fails to build - it modifies fill_plane_color_attributes() in amdgpu_dm.c, but not in amdgpu_dm.h and amdgpu_dm_test.c.
> 

Ah, I didn't have KUNIT enabled for my normal builds. Will send
a v6.

Harry

> Regards
> 
> On 14.08.26 21:33, Harry Wentland wrote:
>>
>> On 2026-08-01 05:42, Robert Mader wrote:
>>> Hi Harry,
>>>
>>> On 31.07.26 20:15, Harry Wentland wrote:
>>>> When we merged the drm_plane color pipeline API the major gap
>>>> that existed was the lack of a YUV to RGB conversion colorop.
>>>> We deprecated any legacy drm_plane color properties, which
>>>> means that the COLOR_RANGE and COLOR_ENCODING properties can't
>>>> be used with the COLOR_PIPELINE property on a drm_plane. In
>>>> practice this means that we can't use a COLOR_PIPELINE on
>>>> YCbCr encoded framebuffers.
>>>>
>>>> This patchset expands on the Fixed Matrix colorop proposed by Chaitanya
>>>> and adds limited range variants of the YCbCr to RGB conversions.
>>>>
>>>> His full patchset can be found at
>>>> https://patchwork.freedesktop.org/patch/709860
>>>>
>>>> This code has been tested with IGT and an experimental KWin branch.
>>>>
>>>> All patches are now reviewed and tested. We have a Weston and
>>>> KWin implementation. IGT patches are missing one review. I
>>>> deem these patches ready to merge once the last IGT patch review
>>>> comes in.
>>>>
>>>> IGT branch:
>>>> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop
>>>>
>>>> KWin branch used for testing:
>>>> https://invent.kde.org/hwentlan/kwin/-/tree/yuv-fm-colorop
>>>>
>>>> The kernel branch containing these changes, based on drm-misc-next
>>>> can be found at:
>>>> https://gitlab.freedesktop.org/hwentland/linux/-/tree/yuv-fm-colorop
>>> I wanted to give this a quick go with the Weston implementation [1], however unfortunately the branch doesn't build for me and fails with the error below.
>>>
>> I forgot to update the series and still had a bad branch sitting on this branch.
>> I pushed the latest rebase. There should be no conflicts now.
>>
>> The rebase from v5 was trivial (what was sitting on my FDO tree was older) so
>> no need to send a v6.
>>
>> Harry
>>
>>> With that fixed I hope we can land the series - that would be awesome 🤞
>>>
>>> Regards
>>>
>>> 1: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133
>>>
>>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2987:1: error: conflicting types for ‘fill_plane_color_attributes’; have ‘int(struct drm_atomic_commit *, const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>>>   2987 | fill_plane_color_attributes(struct drm_atomic_commit *state,
>>>        | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> In file included from ./drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:87,
>>>                   from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:48:
>>> ./drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.h:1133:5: note: previous declaration of ‘fill_plane_color_attributes’ with type ‘int(const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>>>   1133 | int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> In file included from ./include/linux/linkage.h:7,
>>>                   from ./include/linux/printk.h:8,
>>>                   from ./include/asm-generic/bug.h:31,
>>>                   from ./arch/x86/include/asm/bug.h:195,
>>>                   from ./include/linux/bug.h:5,
>>>                   from ./include/linux/slab.h:15,
>>>                   from ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:30,
>>>                   from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
>>>                   from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:30:
>>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3034:17: error: conflicting types for ‘fill_plane_color_attributes’; have ‘int(struct drm_atomic_commit *, const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>>>   3034 | EXPORT_IF_KUNIT(fill_plane_color_attributes);
>>>        |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> ./include/linux/export.h:76:28: note: in definition of macro ‘__EXPORT_SYMBOL’
>>>     76 |         extern typeof(sym) sym;      \
>>>        |                            ^~~
>>> ./include/linux/export.h:89:41: note: in expansion of macro ‘_EXPORT_SYMBOL’
>>>     89 | #define EXPORT_SYMBOL(sym) _EXPORT_SYMBOL(sym, "")
>>>        |                                         ^~~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_kunit_helpers.h:12:33: note: in expansion of macro ‘EXPORT_SYMBOL’
>>>     12 | #define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
>>>        |                                 ^~~~~~~~~~~~~
>>> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3034:1: note: in expansion of macro ‘EXPORT_IF_KUNIT’
>>>   3034 | EXPORT_IF_KUNIT(fill_plane_color_attributes);
>>>        | ^~~~~~~~~~~~~~~
>>> ./drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.h:1133:5: note: previous declaration of ‘fill_plane_color_attributes’ with type ‘int(const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>>>   1133 | int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>>>        |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>
>>>
>>>> Further background on this work can be found at:
>>>> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
>>>>
>>>> v5:
>>>>    - Drop new VKMS kunit tests for conversion matrices
>>>>    - Added script to show how VKMS kunit test values are computed (Pekka)
>>>>    - Removed fixed-matrix enums for "YCbCr limtied to full" and
>>>>      "RGB709 to RGB2020" as they're currently unused by userspace (Robert)
>>>>
>>>> v4:
>>>>    - Specify matrix entries in docs (Pekka)
>>>>    - Squash limited-range enums into "Add FM" patch (Robert)
>>>>    - Don't reject RGB planes with fixed matrix in VKMS as
>>>>      we don't want or need to make a colorop dependent on
>>>>      the framebuffer's pixel format. (Robert)
>>>>    - Fix conversion matrices in VKMS and implement kunit
>>>>      tests (discovered while documenting the matrices)
>>>>
>>>> v3:
>>>> - base on Chaitanya's updated patch and rename code accordingly
>>>>     to Fixed_Matrix instead of CSC Fixed-Function
>>>>
>>>> v2:
>>>> - use Chaitanya's CSC_FF block for named matrices
>>>>
>>>> Cc: Alex Hung <alex.hung@amd.com>
>>>> Cc: Daniel Stone <daniels@collabora.com>
>>>> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
>>>> Cc: Uma Shankar <uma.shankar@intel.com>
>>>> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
>>>> Cc: Melissa Wen <mwen@igalia.com>
>>>> Cc: Simon Ser <contact@emersion.fr>
>>>> Cc: Robert Mader <robert.mader@collabora.com>
>>>>
>>>> Chaitanya Kumar Borah (1):
>>>>     drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
>>>>
>>>> Harry Wentland (9):
>>>>     drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
>>>>     drm/vkms: Add fixed matrix colorop to color pipeline
>>>>     drm/vkms: Add atomic check and matrix handling for fixed matrix
>>>>       colorop
>>>>     drm/amd/display: Add fixed matrix colorop to color pipeline
>>>>     drm/amd/display: Implement fixed matrix colorop color space mapping
>>>>     drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
>>>>     drm/amd/display: Check actual state during commit_tail
>>>>     drm/amd/display: Set color_space to plane_infos
>>>>     drm/amd/display: Force GAMCOR for subsampled surfaces with
>>>>       PQ/Gamma22/HLG
>>>>
>>>>    .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
>>>>    .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++++-
>>>>    .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 +++-
>>>>    .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>>>>    .../amd/display/modules/color/color_gamma.c   |   3 +-
>>>>    drivers/gpu/drm/drm_atomic.c                  |   4 +
>>>>    drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
>>>>    drivers/gpu/drm/drm_colorop.c                 | 107 +++++++++++++++
>>>>    .../gpu/drm/vkms/tests/gen_yuv_conversion.py  |  87 ++++++++++++
>>>>    drivers/gpu/drm/vkms/tests/vkms_format_test.c |  40 +++---
>>>>    drivers/gpu/drm/vkms/vkms_colorop.c           |  66 ++++++---
>>>>    drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>>>>    drivers/gpu/drm/vkms/vkms_formats.c           |  64 ++++++---
>>>>    drivers/gpu/drm/vkms/vkms_formats.h           |   2 +-
>>>>    drivers/gpu/drm/vkms/vkms_plane.c             |  55 +++++++-
>>>>    include/drm/drm_colorop.h                     | 127 ++++++++++++++++++
>>>>    include/uapi/drm/drm_mode.h                   |  12 ++
>>>>    17 files changed, 639 insertions(+), 68 deletions(-)
>>>>    create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
>>>>
>>>> -- 
>>>> 2.55.0
>>>>

