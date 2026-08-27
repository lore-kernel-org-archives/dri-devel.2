Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE448C61DC4
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 19:36:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0270010F190;
	Thu, 27 Aug 2026 19:36:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="2fYO/S9A";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010015.outbound.protection.outlook.com [52.101.201.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C80C210E32E;
 Thu, 27 Aug 2026 19:36:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCfY6WA+Js6DJEz5aoDWIiYmJilQvsFKUyXOWK+/twHPv+1FaWnWutRmLZTLxlME+1UlQcfOOmHrdzRP0Ll82nE1hn0ISkmhpnnbxCIydobxiHuAEl5bRgDHrKge3Wj/Hss/MWntaXMOW1S6TgZRo73IiLDY3akFQla5H3GGrbw7dtIcwOnXGVojSxpvyR+0ICB3/940c6KDp3DOkicrsG3fAXcwbbbYYvxkwh1ZBRqNREsMdsGlb24qrFB7cFZzUmoZcCIyUUqCgnxHr8w5Jr1MNTwLCbbZP+n0XbeHrJpi9VmMYm0zUn+ulke/E0rnYxPyiNgmJtHhxipxLEtFCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oovognHdVmjxvepUYbjteMHbwPmWIByk4cmMZrQcc28=;
 b=etHbV3y+igRPqvQ4nfx5NsHpZWWFnFTYLkSXCmtF4Ap097kNzIhIUi79MXgOA/TyKrL4GElAQ5ZtmwDzlepLTOtegUIErI58T6NmNH6dvRLZEbEUcwv6RU08uFyKVihpPskh2lYhjE0aicn/oWFntkEnd6XqEVyQlmkAwO4GVGbYy7Frpkkg9j2Vjn1yQjon5QOL0LvJ0mZCERErBz/6MPQ7HoWe+D7L6VunuQa7i+tXvvfprt66zv6vVe/2RsU0ko1P7YvYvpH6nbX4dIaa7g9j7SiomKVoWfjNw6YETytnyqoWF0gqtNRxz6WrWReMQu73YtGzX/Plx5rrNnexdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oovognHdVmjxvepUYbjteMHbwPmWIByk4cmMZrQcc28=;
 b=2fYO/S9AiHF/cR8YbGPA0FtQT+HEuQdLAX16G9I/S092vfsgAqo58mWvvcMAShHRkKQTsc0zDOchcO0EYVSdSSYbx3XXhAuCY//fMOzJioaUP18frng21A84uv84AHkxE4HRmQPdnUVoIq0tVyrDJkvgt8iLaS3eVoA/A5yhVVg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com (2603:10b6:a03:486::8)
 by PH8PR12MB6841.namprd12.prod.outlook.com (2603:10b6:510:1c8::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Thu, 27 Aug
 2026 19:36:37 +0000
Received: from SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a]) by SJ0PR12MB7007.namprd12.prod.outlook.com
 ([fe80::6f95:c4a2:894d:9e8a%5]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 19:36:37 +0000
Message-ID: <2a94bf2b-dd59-4b43-8e77-a116fd6502b5@amd.com>
Date: Thu, 27 Aug 2026 15:36:33 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 00/10] YUV conversion colorop with amdgpu and VKMS
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Cc: Alex Hung <alex.hung@amd.com>, Daniel Stone <daniels@collabora.com>,
 Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
 Uma Shankar <uma.shankar@intel.com>,
 Louis Chauvet <louis.chauvet@bootlin.com>, Melissa Wen <mwen@igalia.com>,
 Simon Ser <contact@emersion.fr>, Robert Mader <robert.mader@collabora.com>
References: <20260814211816.1219597-1-harry.wentland@amd.com>
Content-Language: en-US
From: Harry Wentland <harry.wentland@amd.com>
In-Reply-To: <20260814211816.1219597-1-harry.wentland@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: YT4PR01CA0449.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:10d::21) To SJ0PR12MB7007.namprd12.prod.outlook.com
 (2603:10b6:a03:486::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR12MB7007:EE_|PH8PR12MB6841:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d3c2e42-143b-4710-3fa2-08df04728232
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10067099003|6133799003|56012099006|18002099003|22082099003|11063799006|3023799007;
X-Microsoft-Antispam-Message-Info: /8250KmQdmBx93A8KhtpQezkLfnEOaiYmMUR+mGH0Kl+QGHCTLKvySASg7UfQJSIqxZq7YSLXEFaHU2hossDViu/oNdta/TpwP4MZEag8HIaxZXzlXdmPZELpqntjD8jo5wdy+R9NY6oLPupt9v5A7FXAeC28427qpPdq8sB0coPEui+yLKRfwV/AsOhDex0L6AontLAS5sWfUEWGgq8WKuHMb/O+lZ4HiQu2Ks1XTzxVn3kyhk/L5+5ffJ6eaWUitV/UIgBsOHUYKmPvbjlCtdpteTV+q3+3Hxfb/P8Ukm7xKSS9s1FXi/fi0Kjo72tnxSTGhnHULHKFUExPaPZ432JV8eeD7IkFqVWT76UQZQDaPLLoCINuVz6ne1hxh9yuS/Upw1lXcVxrO55skTR375RMLfanOBJZG1mxiMdlChIXdsoKIid1lLhgZs6OmapqzwNMvHzD9+veauP8ceHstw6KBX0fn60Y5m4cO8wcFd5egEJ1MvVftzJahGGzaoCOqXhk3zxcfWjARu8/j3kh7cJL+YM8NTLnnns+m611oP4V8md8QAO7WSXm/ymHaL7v/V4YGdWPYEopRSWryoAx4u7YtLa77jr4Gm0LAY09f8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR12MB7007.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10067099003)(6133799003)(56012099006)(18002099003)(22082099003)(11063799006)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?blZ2OVlyVTlMNW9FSXNkeHdQbElxL01yUVFYS2NxUGs3Vnl4Nit4OFRHaUxh?=
 =?utf-8?B?eUlYUEV0YnJITzdqaXhSVHcvVmdmeGxtTzJ2MVIrTVdDODZ1S3NDTWUzTFkv?=
 =?utf-8?B?L3ZnRVVvZEdFNm8rWnpEdHgyeDhJUnhHMXp1RGJqOXdCaUwrNm1uYnJhZDI5?=
 =?utf-8?B?OFZwSmRFT1lUTi9KT3NaaUc1eFg0bWN3TlhiY2g4Zy9WMmtsVXFIMDFNSFZx?=
 =?utf-8?B?N3NmWi9hOGF4enBEaHk5OWtibHpLa0FuS2FPWHEwNGxEdzdsbGRvb2YvMUxJ?=
 =?utf-8?B?K1dVZUdGaDlBRG9qd3p3Wk9NV1N0aXkrc05MdHR5NW5qNklRWHRIWkVkM3Er?=
 =?utf-8?B?dzRpQk1lV1BkWjE0QjdzbEEwajRFc2hrZVg3Zk8xbXhKRnFuLzY5amowNzha?=
 =?utf-8?B?ZDNFVkhyUklRa0dDL2ZlbVJHalVLNzMyaVZtUTczVzFzeVNKQjl6ZG95TEt5?=
 =?utf-8?B?RDZTNUR3TUtVNmVsR2h6Yjcrbk5DU3QxR2g1WkpuSFcxWjZOOGFyOTBqZTlz?=
 =?utf-8?B?dklPZm5hK0JQZUNlRXhFVWdLTlhrTlNwZzdoSkxCOWREUXdwM1h3MU5LQld5?=
 =?utf-8?B?bUlzczBrZzZjWFVXTlV0RTRlL25CUEN0U3VRc0JnZElKaUR0NUlCRndQdm53?=
 =?utf-8?B?dWhNMGZiUXRLOGpIVTlDV3djR3g1QnhUbGVmTDZQWVRDWXlMa1d1N2VORWFP?=
 =?utf-8?B?dnJOVjM4VnRDc2JDUE5HazBXVnorS1AvZWE5NHFwZUtxZGpDNkkxdGs5NWdD?=
 =?utf-8?B?emZrZkxOOWdqTnhRTktWOW9JTzRkR2hOUlBCK3M1QnJnVnl3Y3pqYUVIMUU3?=
 =?utf-8?B?UE91OWIrMUI2M0FQR3VPTVA1cWF0WUJkTS9jbXZXdDQ4UHFiUkNYdmdXN3Ja?=
 =?utf-8?B?WFVVSENqTThFd1gzKzZQVUdsNHpaMkttODYxbnRUSTgwdk90WG1rRDN1eURm?=
 =?utf-8?B?MEhtTTV0WjB6OE1EWjlBMHZacnR0dVhPOEI5ZG0ycm1kTFYvYXJZTDcrcDF6?=
 =?utf-8?B?VGZEZGVDUkRjN2EyMkpONi9sUFI0L0NCK0prYnpTWG1KeitUYm4vYmVlNkZX?=
 =?utf-8?B?K2RJRnhzV250dFNrckxRdWFUV3ZEdHhhL0g2WXhVMlNCa0dpR2kvQzk2K3VB?=
 =?utf-8?B?NkNkdS9mbFI5OEtQcXFkRWExcDN4YnNqaEF6ZWViUzJlNnVQYUQ3bWZYTmUw?=
 =?utf-8?B?TVQxaEpld3RVclAxYkRlMThJSHR6cWYwOHkwVko3VFcyRmlUeGt3Vk81VzhF?=
 =?utf-8?B?cHQ0QlM0OWF2Y0U3b3FtU1lhNjV0ZkhEd0I5Z0lVWlBHWitmVjdKZmlTT1hz?=
 =?utf-8?B?azA5MWsxUUJ1WklqNFB3TDlVcVdSenpFeDdkQmZHRjdnNTJsMXZzaG5MejlT?=
 =?utf-8?B?dU1DdFB4c2YwejBKb1hlNGk3MnU4ZGZXaTBWNmRPZENEdk9IeHljaVlKSjNB?=
 =?utf-8?B?SzZydnlKMGZTL2hGZ3ZNTUZJM0V4ZkNVNlNTS3dMTnVpMk13ZmpVQ2E0S0xG?=
 =?utf-8?B?Rzl1ZHk5YzFxZXA5S3M2bDY4cHZKRW51eERxKzBqWWZPUm42YS9KVTcxaWNI?=
 =?utf-8?B?dHZnSE9YWmpQd0lwcmttOFJsK21HUVVsVE4xaklPVDRRWmhyYmwvUnYzRVp6?=
 =?utf-8?B?QVZZbFF4S3gwaHptOGlxcXViMGI0WTdqRlB1OG1JME5RNlJUYU9XbWNzQ1U1?=
 =?utf-8?B?U3ZSL3FNd0puQ2JzK2d4bW9oUzBNcVAvZHRWUXM1UlREQmN6enMweUg3T00z?=
 =?utf-8?B?aG9XRjBhTDVMYm95VUMwNk10MXA3K3pWcThWMTJwRFlseG5lY254WU9ROG11?=
 =?utf-8?B?bHFoU0pZb0dIeFpySG05ZG4yTEVNWk8wa0FzWlBQeityQklxeG9ORWgyQTNU?=
 =?utf-8?B?VTRoM1hBdFI0SytabzMrY0h5bGZsTDFUNXM5REkrK0Z3d1NVR0JSK0QyRUJU?=
 =?utf-8?B?Q0xjT3BnT0NOSUdRS1NpRUpCek44VUE2OHlQNjJKR0tMbis0Z2JuQkJWWEpZ?=
 =?utf-8?B?VityNW1MQmxERGxBSWg3d015Zi9zS2cySVNtU1JkK1BCMkErUVNPQzFHcXF2?=
 =?utf-8?B?OUlYZmNTV1VYa3VXTEFzTUtlUGRjRnp6ZmJsU3JPRTA2R2RHU1FSbjRTSWtS?=
 =?utf-8?B?Q09YYjZlK2pYc1Jyb2pUaUlYT3hVdloxYzM2ZE94SHVlbE9FMGo3dEMvcWZN?=
 =?utf-8?B?dXk5WElXTW9acGFwajZ0MVFucWYwbDN6ci92OFZKYWVPakxzSVIvZnRIbGZp?=
 =?utf-8?B?MEU4QmE3ZWpRb1VpQWxmR2lSeU8raktOYVlkT0JTQUgvYzdLUlFlYVlCellU?=
 =?utf-8?B?dEg2V1pqaFBRRjFLTCtKSzlJY2ZLRDVmeW5ZdGxIWFMyWitXc0g1UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d3c2e42-143b-4710-3fa2-08df04728232
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR12MB7007.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 19:36:36.9293 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1FEpZK5a697n7QsEIIubgrjYrFCTYRJPm9LlWMCSYouZRZpWezzg5P2qpcjEoJFzPBX2RnxYHn60gz6E0odtg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6841
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

This series has been merged to drm-misc-next.

Corresponding IGT tests have been merged to the upstream IGT repo.

Harry

On 2026-08-14 17:18, Harry Wentland wrote:
> When we merged the drm_plane color pipeline API the major gap
> that existed was the lack of a YUV to RGB conversion colorop.
> We deprecated any legacy drm_plane color properties, which
> means that the COLOR_RANGE and COLOR_ENCODING properties can't
> be used with the COLOR_PIPELINE property on a drm_plane. In
> practice this means that we can't use a COLOR_PIPELINE on
> YCbCr encoded framebuffers.
> 
> This patchset expands on the Fixed Matrix colorop proposed by Chaitanya
> and adds limited range variants of the YCbCr to RGB conversions.
> 
> His full patchset can be found at
> https://patchwork.freedesktop.org/patch/709860
> 
> This code has been tested with IGT and an experimental KWin branch.
> 
> All patches are now reviewed and tested. We have a Weston and
> KWin implementation. IGT patches are missing one review. I
> deem these patches ready to merge once the last IGT patch review
> comes in.
> 
> IGT branch:
> https://gitlab.freedesktop.org/hwentland/igt-gpu-tools/-/tree/yuv-fm-colorop
> 
> KWin branch used for testing:
> https://invent.kde.org/hwentlan/kwin/-/tree/yuv-fm-colorop
> 
> The kernel branch containing these changes, based on drm-misc-next
> can be found at:
> https://gitlab.freedesktop.org/hwentland/linux/-/tree/yuv-fm-colorop
> 
> Further background on this work can be found at:
> https://hwentland.github.io/2026/03/10/plane-color-pipeline-csc-3d-lut-kwin.html
> 
> v6:
>  - Fix fill_plane_color_attributes build failure in Patch 8 when
>    building with KUNIT (Robert)
> 
> v5:
>  - Drop new VKMS kunit tests for conversion matrices
>  - Added script to show how VKMS kunit test values are computed (Pekka)
>  - Removed fixed-matrix enums for "YCbCr limtied to full" and
>    "RGB709 to RGB2020" as they're currently unused by userspace (Robert)
> 
> v4:
>  - Specify matrix entries in docs (Pekka)
>  - Squash limited-range enums into "Add FM" patch (Robert)
>  - Don't reject RGB planes with fixed matrix in VKMS as
>    we don't want or need to make a colorop dependent on
>    the framebuffer's pixel format. (Robert)
>  - Fix conversion matrices in VKMS and implement kunit
>    tests (discovered while documenting the matrices)
> 
> v3:
> - base on Chaitanya's updated patch and rename code accordingly
>   to Fixed_Matrix instead of CSC Fixed-Function
> 
> v2:
> - use Chaitanya's CSC_FF block for named matrices
> 
> Cc: Alex Hung <alex.hung@amd.com>
> Cc: Daniel Stone <daniels@collabora.com>
> Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
> Cc: Uma Shankar <uma.shankar@intel.com>
> Cc: Louis Chauvet <louis.chauvet@bootlin.com>
> Cc: Melissa Wen <mwen@igalia.com>
> Cc: Simon Ser <contact@emersion.fr>
> Cc: Robert Mader <robert.mader@collabora.com>
> 
> Chaitanya Kumar Borah (1):
>   drm/colorop: Add DRM_COLOROP_FIXED_MATRIX
> 
> Harry Wentland (9):
>   drm/vkms: Fix limited-range YCbCr to RGB conversion scaling
>   drm/vkms: Add fixed matrix colorop to color pipeline
>   drm/vkms: Add atomic check and matrix handling for fixed matrix
>     colorop
>   drm/amd/display: Add fixed matrix colorop to color pipeline
>   drm/amd/display: Implement fixed matrix colorop color space mapping
>   drm/amd/display: Use GAMCOR for first TF if YUV conversion is needed
>   drm/amd/display: Check actual state during commit_tail
>   drm/amd/display: Set color_space to plane_infos
>   drm/amd/display: Force GAMCOR for subsampled surfaces with
>     PQ/Gamma22/HLG
> 
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  14 +-
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   7 +-
>  .../amd/display/amdgpu_dm/amdgpu_dm_color.c   |  85 +++++++++++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_colorop.c |  27 +++-
>  .../amd/display/amdgpu_dm/amdgpu_dm_colorop.h |   1 +
>  .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  16 +--
>  .../amd/display/modules/color/color_gamma.c   |   3 +-
>  drivers/gpu/drm/drm_atomic.c                  |   4 +
>  drivers/gpu/drm/drm_atomic_uapi.c             |   7 +
>  drivers/gpu/drm/drm_colorop.c                 | 107 +++++++++++++++
>  .../gpu/drm/vkms/tests/gen_yuv_conversion.py  |  87 ++++++++++++
>  drivers/gpu/drm/vkms/tests/vkms_format_test.c |  40 +++---
>  drivers/gpu/drm/vkms/vkms_colorop.c           |  66 ++++++---
>  drivers/gpu/drm/vkms/vkms_composer.c          |   6 +
>  drivers/gpu/drm/vkms/vkms_formats.c           |  64 ++++++---
>  drivers/gpu/drm/vkms/vkms_formats.h           |   2 +-
>  drivers/gpu/drm/vkms/vkms_plane.c             |  55 +++++++-
>  include/drm/drm_colorop.h                     | 127 ++++++++++++++++++
>  include/uapi/drm/drm_mode.h                   |  12 ++
>  19 files changed, 651 insertions(+), 79 deletions(-)
>  create mode 100755 drivers/gpu/drm/vkms/tests/gen_yuv_conversion.py
> 
> --
> 2.55.0
> 

