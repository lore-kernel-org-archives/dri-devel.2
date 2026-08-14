Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D999BC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 19:33:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B30BD10E58B;
	Fri, 14 Aug 2026 19:33:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="BYIlXhx1";
	dkim-atps=neutral
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012031.outbound.protection.outlook.com [40.107.209.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC5010E0E7;
 Fri, 14 Aug 2026 19:33:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YMDlJOX+ocmw4M6OvIQzZXrKgA2I5MCzhrFGtq2c59V9RJF8NE7Zh4wQpgfPQFYjWqFbxCcQ7Wg/IKoYEnHi9z/Gq+Q2dZYE7AX/+1kd17MCAtRka/ySSOsx3cbJGWBBfZvZzDuOrdikLYs85tia44W1GAdYkkDTNmdVwWzFEHpTQGtmIZnT9nqo40CD1bO/ok8pOkIiAx5kalPPHGraATfVyAleKaTVjiNPdkZ6M/oOFoWlSt+BlwMTg62e5WVRC2BNIBxSGhkbsH1ceaanBJmMro7n/oKkXEoN2dA9ps7fLr3RAOCudeAOIkgNn8tqqOWnjwRKnhxOl9PLwARahA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CDC0dA5q8nHO+MKKZOjTKSzdbHgcWe8AIMlJQ7CxD44=;
 b=Zyc9Qlgtt27sxPF7rPjUQ0IYahQSUwz2ScVDEPLdO5mCQJVvil9cmHxfk++fk8jNan0QRKr28RtDE4lGpfNiz55K680xEKvNjQcboodWYMTB3t863l/txibIMPuZO1gUgaHFv4KgZqngLt7ZHSnX+gQ3uGeAxfBu3TcDhwlFFC26kQg2ZLlRgCx0M5bPgrBpzUg56sD9WabeupZlqyGBaAMvwUaDOIMAX19Fg5Ont8zL81UZ4Xp7cwhUhrSuOMFmiUnWj1afOEqRqqzNgZn2Jl29RZbej0uvvqNhDlOp9kDSEEErL/4DxfAWCuHVRhxn0uY0d83Tx6WpjtNNgaS9cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CDC0dA5q8nHO+MKKZOjTKSzdbHgcWe8AIMlJQ7CxD44=;
 b=BYIlXhx1ZUv+Dvvxdd2o4tpTr0ncPLetgCbklQ8AHeT+1JskuaD2TNOTfpcpx1Iet6tUH/h8EvdletKACraPf5NT7meGoy8aUwCAsczBlJCkTJWYtXcNJU8vwZ7pdjaceDYgXAUOL84AP7ZQ+/35BQ9mQDLBAeUU4V9yWNGgTmQ=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by MW4PR12MB7213.namprd12.prod.outlook.com (2603:10b6:303:22a::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Fri, 14 Aug
 2026 19:33:04 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 19:33:04 +0000
Message-ID: <8615b361-d250-4fb7-b0e3-057f2ec6786a@amd.com>
Date: Fri, 14 Aug 2026 15:33:01 -0400
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
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <1df8715d-5b2f-4c66-9960-635b65dd8e9c@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: YT4PR01CA0146.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:ac::14) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|MW4PR12MB7213:EE_
X-MS-Office365-Filtering-Correlation-Id: 991e3cba-1824-4235-06cd-08defa3adc3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|18002099003|22082099003|3023799007|56012099006|6133799003|11063799006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: 6BSnbBWUT74pjpkl3nTkGnMoaO6hplYHZ523biZ2LI+++nnXMNa2ARZGGN08bBs7tbAu6LBPwjTvVi+eO8pHZPnJQpNAswE/jRGest/97wxXzm/tEaOp7GCQ0uvKccVinS8DiAyjMGZgF0++pHpe16Neg3DNIgRl08Ys0zdekg1YBGCxNztF3IDd/jkBbSHS9uriXSTNHIHiBHpAI+0FLNLKKFRwSEEER2AhyKOOm1vc49wg0vBgutqsweb73Jy+l+44ZKLDT1iHw8Tpi/Wx2TZRYpQWn/fJVTS0IkGg3vwbMp6x/bPgpEeSXpWkSPYZySeEZUQtgNkj3EkIko3usVmDq/8ly1ebLb7YAiInirmf2v39iAx0q0ZCBUsoj0V5hTPR3MfCiymQCKmnUlccrl58f7u0Q50Se9s1bjTDgKyQRgdjVX1wFFsO4U7rBZWmlq9hrl9Va3TDMgbIECa+ZmQrrX9jjBwTJbZYFgh/A6Hi9Zh7A1u/VqF296od6s23nlacbFd8aeMDxzxfSoFhmSAJ0fJsFNypMDFMs7fnVgyVOHNNF8+3RueMipqAO4LvwEN5+i/S8U1ZsRaz1M+OVTn06b7GBKWud0sUZxXvrGs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(18002099003)(22082099003)(3023799007)(56012099006)(6133799003)(11063799006)(10067099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDZ2Z2I0SE9hQ1JzSWIvMXBQb1E1QWpwT1dPaUlqZjJqK0RWcGFSeGhTUjI3?=
 =?utf-8?B?OVBUdEFocTdWbkdxdkJqa09Ja1VaaW5sSHpXTWNDeHlKU0FZVXk1M1pnUkxr?=
 =?utf-8?B?a3JhYnBrM1dHMUliNXJPTU95MjFSb2tra1o5R3duSHpDd20vYU9VYzBtS2Mz?=
 =?utf-8?B?NXZLdEdZNk5GVGdpMnJxSGlwZGV2eVdsQTdxVTBlcUdVVHZVWDJ1ckNGekdi?=
 =?utf-8?B?ZGRCM2IxY2xSUWZmZitlV2h4M2x5OHBjeFBxUG5sZTFVQkVhZnNUTFpFV2Fq?=
 =?utf-8?B?bk5uV3FBRlRXcWZiZTdtb2YycDVZT3g3MGUzZ2tFZzExeHNjTUV3NmJkdGZm?=
 =?utf-8?B?cllNU3hnc2d1eFBZWTZwRzlqRjByVS9LSHp1R0xGaElEWndaQ0x4MkF3Vnp2?=
 =?utf-8?B?QzlzdjdIb1k1MCtobWpDbTJHUkxqc2U0UjF4bkFZV08wL25VbFpudFdmbHNW?=
 =?utf-8?B?L0hJZlN5amlQcDZ2RUttVGdxRm1lbTY0OHBXNFcrSHBBYkliaTFVQ2dGZytF?=
 =?utf-8?B?MTh2QjB0cUFncWtqQitQTlU4ZG5icE1jdUQvRUR0eHMyb21XT01oNlo2N1Jz?=
 =?utf-8?B?WGVWQU15dUNWNHB6dGZLZkVGeUxHVUw3bitqVmlwdENwNmw4TzZuRUVOTC8v?=
 =?utf-8?B?MEgwNmZqbzExcWZ2TU8zR0RIeGhWWCticlZUR0YrNk9RUnppL0xoUjlkRVZE?=
 =?utf-8?B?ZGFYSEJ4YmhLcFpXTU44NHREWHBHcmZ5U2tXUW0wS1RDQTR0bytXbjlhckxz?=
 =?utf-8?B?Y0Z3L2krbUs5bnIvcFlraDBVa2FMQy9aeVZuZXE2akFDTFpJM0ZqOE9yYytU?=
 =?utf-8?B?RlVrQjFMV0o2TnRJd2ZwYS9hQU5GZ2l0bk5zeVZ6VDBsakIvQW1aZjJmNGwr?=
 =?utf-8?B?MWZHYzRIMFZPY3JMS3Y0a20wYlBGYUxwTjd2d2gxMUpXV3lhRThNVEgxY0N2?=
 =?utf-8?B?UCtWTUlieE9LcGlJc2dEVmFSU0VGdEhPVWR5Rnp6bHJYQVNjYStkSFlvU0Rs?=
 =?utf-8?B?UmFCZ1g5NFVTdm56RVJCVFBHUjdVbi9ZQURwbUVocHp2a3V2ZU9PNW9KSlJZ?=
 =?utf-8?B?c1YxU2c1U25BOVBZWlAveFVTMlBpMlllak4wMUNYK1JzbUJhcS9ucUZHd1Zu?=
 =?utf-8?B?emJ3QlE0WGZFa3NHSWZpM3V2S1orWlJRYjJhUFVMT0daOFVnVGtFTXVmdWor?=
 =?utf-8?B?bmFoK3VRcmxLY2hZdXovYW5KN0ROSFQxZWwvSFhNQnNzTDhvUCtOaXhIeXhk?=
 =?utf-8?B?ampyNFBsYUt0M1pTZjcxemIrOEs4cVVrNVQzMG1aeFA4cWhDSHlFMnkvejVS?=
 =?utf-8?B?dklsUCt4NU9qUXd2bUxhVFJKTW0vNHk1K3hqb25QQXB3Z3dIVkFZOWNtODRh?=
 =?utf-8?B?UDNFYkNxcHFLV0RVMlY3eVFMMXFXTzN4SUg5TEZwcUdUaWo5SGM0c3psN3Nn?=
 =?utf-8?B?Z1dYSlF6T1BsY0dXQnV3M0VVcTlzQjhPa1RIOW14WTBBTGxWbWpuNlM1UE1P?=
 =?utf-8?B?NUZwMWVZdllKbisyL3IzZDNrS1pCczRwZTlZeWpsRkJCaUM1RWQ0UkU2RDNm?=
 =?utf-8?B?UVk2ZWNvMU1tUFZ4bXRuNlNsYnZmcHE1SFlaZ1c5MGRIa0Zia1lJdTFLS1dn?=
 =?utf-8?B?cEVVY1ZVSmhqR1FvVEFDT0tmdFVuZWIxbFJPVlFpOWNIRi8wN1pXOWhBajI4?=
 =?utf-8?B?bDdhTzdRRXJKZThaVXQwZGN5dXE5MDdOK3NxT2UxSFU1UmdNbmsxb1UwMjdq?=
 =?utf-8?B?UjN2OVAzaVEwVEdwbzJoVmgwZ1hPSUpSNkNQMWUwcUtNZUtmTG16U01VaWFP?=
 =?utf-8?B?eWxqSitDYjl6djZNNmxUb3BMd1JmRUpZaVdxZ1BFMjBqSTRRVXF3M25pZFBz?=
 =?utf-8?B?L29ER21wRXI3amtneXlEbmE3NW5QTEtMdGw1NkJNamppWGthdDNwMkRWdUFw?=
 =?utf-8?B?SFgrUEo5M1haTm80Z2IrZGh5eUhNMldOV0ZZKzNFdUx1cXM3UEVIb055TjZW?=
 =?utf-8?B?RGJNd25qSXFWWERKb25SSlNnb0ZqeWNhMjhJTDUrOHUyNlhESVB4NFVNcXBZ?=
 =?utf-8?B?OUdjVEEvR29pdlZpRUwyd3ZQQkdwOHMyUmpRT1pMLzRTbUQ4RXJYeEpwNE5E?=
 =?utf-8?B?WGZsNkkrdklEancvY09nUnRiWDR5eG1RdTB5RHhwSWQxTzA3ZnM2RWNYUGRW?=
 =?utf-8?B?aHZaT3g2NFJKTXpqMkJpNzhFNzBSVkdMTWxnS1BxczVMeG9seE5IV0xYU1Mr?=
 =?utf-8?B?N29KaUI1NUNsbmgreTM4eHVoeXYvVkxyTXhPandhZ2NOMVd3YW1UTnlpblhQ?=
 =?utf-8?B?V20zT2FNWmNvcDR5RUpZcnV0bElrQkRtcmRUTUYvRThkeU5uMmJPZz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991e3cba-1824-4235-06cd-08defa3adc3f
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 19:33:04.7724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vw/Xsqd4xLUHfn+5SUMev59noNAPEaWQCs3zbmRlhFLPaKKka+lTit0k/VfhzQZYuqRDfIlD1DuHyoB8emQisQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7213
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



On 2026-08-01 05:42, Robert Mader wrote:
> Hi Harry,
> 
> On 31.07.26 20:15, Harry Wentland wrote:
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
> 
> I wanted to give this a quick go with the Weston implementation [1], however unfortunately the branch doesn't build for me and fails with the error below.
> 

I forgot to update the series and still had a bad branch sitting on this branch.
I pushed the latest rebase. There should be no conflicts now.

The rebase from v5 was trivial (what was sitting on my FDO tree was older) so
no need to send a v6.

Harry

> With that fixed I hope we can land the series - that would be awesome 🤞
> 
> Regards
> 
> 1: https://gitlab.freedesktop.org/wayland/weston/-/merge_requests/2133
> 
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:2987:1: error: conflicting types for ‘fill_plane_color_attributes’; have ‘int(struct drm_atomic_commit *, const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>  2987 | fill_plane_color_attributes(struct drm_atomic_commit *state,
>       | ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./drivers/gpu/drm/amd/amdgpu/../amdgpu/amdgpu.h:87,
>                  from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:48:
> ./drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.h:1133:5: note: previous declaration of ‘fill_plane_color_attributes’ with type ‘int(const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>  1133 | int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> In file included from ./include/linux/linkage.h:7,
>                  from ./include/linux/printk.h:8,
>                  from ./include/asm-generic/bug.h:31,
>                  from ./arch/x86/include/asm/bug.h:195,
>                  from ./include/linux/bug.h:5,
>                  from ./include/linux/slab.h:15,
>                  from ./drivers/gpu/drm/amd/amdgpu/../display/dc/os_types.h:30,
>                  from ./drivers/gpu/drm/amd/amdgpu/../display/dc/dm_services_types.h:29,
>                  from drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:30:
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3034:17: error: conflicting types for ‘fill_plane_color_attributes’; have ‘int(struct drm_atomic_commit *, const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>  3034 | EXPORT_IF_KUNIT(fill_plane_color_attributes);
>       |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> ./include/linux/export.h:76:28: note: in definition of macro ‘__EXPORT_SYMBOL’
>    76 |         extern typeof(sym) sym;      \
>       |                            ^~~
> ./include/linux/export.h:89:41: note: in expansion of macro ‘_EXPORT_SYMBOL’
>    89 | #define EXPORT_SYMBOL(sym) _EXPORT_SYMBOL(sym, "")
>       |                                         ^~~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm_kunit_helpers.h:12:33: note: in expansion of macro ‘EXPORT_SYMBOL’
>    12 | #define EXPORT_IF_KUNIT(symbol) EXPORT_SYMBOL(symbol)
>       |                                 ^~~~~~~~~~~~~
> drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.c:3034:1: note: in expansion of macro ‘EXPORT_IF_KUNIT’
>  3034 | EXPORT_IF_KUNIT(fill_plane_color_attributes);
>       | ^~~~~~~~~~~~~~~
> ./drivers/gpu/drm/amd/amdgpu/../display/amdgpu_dm/amdgpu_dm.h:1133:5: note: previous declaration of ‘fill_plane_color_attributes’ with type ‘int(const struct drm_plane_state *, const enum surface_pixel_format,  enum dc_color_space *)’
>  1133 | int fill_plane_color_attributes(const struct drm_plane_state *plane_state,
>       |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> 
>>
>> Further background on this work can be found at:
>> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
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
>>   .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++++-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 +++-
>>   .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
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
>>   17 files changed, 639 insertions(+), 68 deletions(-)
>>   create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
>>
>> -- 
>> 2.55.0
>>

