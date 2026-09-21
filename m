Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C98EBC982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 09:19:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2D5A710E4E9;
	Mon, 21 Sep 2026 09:19:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=amd.com header.i=@amd.com header.b="WeVj8K+y";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011027.outbound.protection.outlook.com [52.101.52.27])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AC34910E30F;
 Mon, 21 Sep 2026 09:19:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SdoM9KjY9zczFgntUcNXOXHIU+IVRdhrWDpSamuvHsw4DxsubPVuGAOaLW5wS9Ikld8hEr8pmqQEYUSPkz/w2ud7pVSdgtHjpqjvtbKvkOeHq0bjte2n+SOP5hfPkXqZV5fN/DNxcITlNyJ3tyw34vToh03di0MZM7ft4buG8OYkAcLUdnmjQM3MiRsaZYznHlowFNTZpnwQJhRLSJ0jEvTSFbA/OJtE6sIOZjH9rRebmxGelNEIaD3bNUlH3wY+l62oHcorAx1Kle+1LC9NeKpigZnxBTZgJ3AiOFDhrktwC6wlBNLlVMu/FxVaYtml53PpxGQtHFb1uLkz0UGPkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V64/QqjARKTagelFmImKLQiuUEynnP1besOQ03oDse0=;
 b=Ce1lrIWU7XKCYRWcfSe7aZO8tnN536ytHXcuKol4np0/LENrh76yQ7MF8MWVjrlbzAtX1MHLInsFICxq+Bsj6aALzTAcgZOHpVVnlFRFU3gb4NKQzvaQHXSZeH5zY/Ha8Jl+YRWeWSp7BWqHBADfmYF6L6eOVZOxlkQ3/4QenORWJH3QYc5UaZs9aWP73A43DTRq+pcHkM7lEkQn4hN9rd+iJICy6QHHNw9koozyhIpGJG4gfENQeLr2cvwMGCipQfOmAmqapmHOQmrOIQ1O7a9X91EczlB05GGqOPpHLq6hXHzSPmHXjwilZ/eiAY48MKcQOM1UHD+rGJvORdLx4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V64/QqjARKTagelFmImKLQiuUEynnP1besOQ03oDse0=;
 b=WeVj8K+ysxxsALJpkRk866yP9xKJZMp6KGHPgfMOBxdfwSQsuYCBQxTnQ28YdprHceMXcnp8LtsiMkNzc8mJXSzkXOoNt5pqDf/fH6rz4ERcuGNy89SD/EZsOjNJhN2Nt6UYbkW8DEj/9Uboiig9gaWgrogFVIdgRQEOFbEXhbw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH7PR12MB5685.namprd12.prod.outlook.com (2603:10b6:510:13c::22)
 by MW4PR12MB7144.namprd12.prod.outlook.com (2603:10b6:303:21b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 09:19:12 +0000
Received: from PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c]) by PH7PR12MB5685.namprd12.prod.outlook.com
 ([fe80::ce69:cfae:774d:a65c%3]) with mapi id 15.21.0428.011; Mon, 21 Sep 2026
 09:19:11 +0000
Message-ID: <5e0949d4-85a2-4519-9e3e-a1b01ae58f46@amd.com>
Date: Mon, 21 Sep 2026 11:19:07 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 0/2] DRM standardized memory stats
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>,
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Ludovico de Nittis <ludovico.denittis@collabora.com>,
 Alex Deucher <alexander.deucher@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
References: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
Content-Language: en-US
From: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
In-Reply-To: <20260917120444.86471-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BL1PR13CA0026.namprd13.prod.outlook.com
 (2603:10b6:208:256::31) To PH7PR12MB5685.namprd12.prod.outlook.com
 (2603:10b6:510:13c::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR12MB5685:EE_|MW4PR12MB7144:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f723f46-1b43-4976-0b91-08df17c16607
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: i++nsqZF90kd2BYOyKvkPvMvhKxq+FqcgpjdY+aTrfz4lrw8xctFYXwxAtgC7vv0u4rl5O7tp2tuu/EYmtLOG7hhBlzLzpjCMbXT153VQhblXNo8t/KSVbseWb83gCGpogMssY/z65dNNEHhuxrmlWJ275LpBuQwU4IPFSdLKKCF3eu+UtD9njGQPEhehlr+j1+29lVAQrFFhAuMP6NxA/vdd8jjJ7iZFnPB/dFsBTOOu2C9cZPmH4FXSPZtzSNWLr7zGwm9qwdaZ53kqTRue8mglTd+R9zYoqBURVrMOypgg6Ti7JLiRrCb4SCmTYixwvtcod5sE0ag14W3Hbi38FMpziFDKcXU6GPKW2ECnCVL1vkTtfWIP6/5IzKVCeRtFG291B0SKaEJAJJ1SdFst5TFU8XleR1JaTqoFWrEJeIolFKBy3oxTF7oVD2m8as9+3Vk9x/Q0M1uibNL51hylD4X472XBZOdXSOjZMFkHv/eDdYLnPRNvHgmKlgq3cfwCoeWqL4J81zPHXh/HD6AhZGn7utM4NPJN+CoGN1WEHP8bOTLfj8O4V6Dbzf7/DHpoRdd7eBdQYat3fZ/jeOMrtRBCezGTQOHGTlLk0jj144VnsoxLOrgeJKfl5nU0c0/clRu/0Rlvt05qJVkTv35738gNssGTUccib3VKn4m+0Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR12MB5685.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VUl0Z00xczVmY3djQTFLQ3V5a3pBeGxnZTdpQ0YvclNUdzk5bkpxVnY1UnU5?=
 =?utf-8?B?YXE4WnhobmhXbUZaMksvRElHQllVck1lM29kMG9ManFxRVRCWk5LZW5LMllQ?=
 =?utf-8?B?ZUowTGdoaEtMd3JnRjBGdW9JL1FGN2d6R1piQXUvNmxUdmoxUFBTVWZRMzFI?=
 =?utf-8?B?NHlVNmYzODJxTzYrWjhJb2tpcy9aeDJPSVFiWTZEaHpzRWVtR1JXeGwwNW9h?=
 =?utf-8?B?Q3hxZTl3d2VjWGVBdE5kSjgraTdJelRZcVVaMVUySWRnQ0ZXSGMvTzJrL2xR?=
 =?utf-8?B?NDhwTmhyWHdHbjZBUzliM3l1M3lIL2FHbmpQUjBXbkhiVDd4MFUxVHlsdUph?=
 =?utf-8?B?dlpwUXB0dTl5bkVWVThNZUdKM2N0dVNuajlSYWI3UkF4VXdGWmF3WC9UUEFo?=
 =?utf-8?B?bExGRWxXSjhHc253NlVpRWM1alprcnFoeHpPV1FSNVFoQ0pEYTgrSG1GTEVQ?=
 =?utf-8?B?eXozYmw2bm1jNWJ2YmNzb1lEUjFNT1NJcDBwa0x0cFhYaTVITW5VTVZPcVln?=
 =?utf-8?B?amxwSVg5ODB4UnVaTjV4aldwVDF1RFczVHRxMllkOVhybFNCcDhFZUYyd3Vo?=
 =?utf-8?B?SVlsT2ZIWXhISmhoUGI2WkRYUUgxRVoxYVE0aTZNRHZ5d3VNVi83YUwxTU5K?=
 =?utf-8?B?UVdHNGQ5MytwajkzQnMwbDkwbHRVeTZrMnVTb0dpbzNaZ2F5UDlrSGVtQmR6?=
 =?utf-8?B?WHZvSVJST3F0czRpbU9PYUkwSmoza3NwTDN2dVRYQlFrbzcraTdrZE5aVzky?=
 =?utf-8?B?Y1hrNmw2a1VxY0gxaTd1eXlPZmlVQ05hZVRwMHlkam1PeUUyQUdWY3NvcmtW?=
 =?utf-8?B?dmtPNWQxUWxMSEFoa0wwL3NoMFpQSEd6ZW44VXZDMVZ2NzgwSUpmMkhaUjBh?=
 =?utf-8?B?djdhVU9jSGU2Njl1Yy9oZ1VJMHM3UVFvaXRCMnRjQVpVZDBQT2N3ZEVOUDNU?=
 =?utf-8?B?SEtpNFFaSDhBQ0JLOGdlaVlxdzgvWUNBZmM5dWFIM1p0bDVJK0tSRzRJL2Fv?=
 =?utf-8?B?OVYxVzhONDRXZlNadmFBL2xDZzZ0MGZSbEw2cXk5bmpCNFZiZ01KTkRIQ2Va?=
 =?utf-8?B?UEw5QVZydFNqQk5zSjlKZ0xiWGYremh0SFdWUVUwamlBMFZMNFpRbHZzZDQz?=
 =?utf-8?B?MHp2OGlqQ2l5ejY3TTRSRlBwalFOY1BJeG41SDNNMVlwV2t6V01kQzF5Q2NQ?=
 =?utf-8?B?RXZDaXVjdklEUVh1TEdIWUNFbU9RcTZzcWdnS0MyQzZCdVNMcUp6cXhtUG5i?=
 =?utf-8?B?SjJYa3R5NzZQRmpNbGNRUS9odkR2MU44S2NjN3g4S0lvbHNmdDRYdUNUWnpY?=
 =?utf-8?B?SjdvaGVQeWl3MlhuMkN6TGo0T054UktoY0VoMjBSdXdwcE1FSWtVRnFYd1Fa?=
 =?utf-8?B?THptVGI1Vlg4VDhwM1A1OVY5WldzQmZtSU8wbWxYOWl4ckZYdlVVM2FCYXNa?=
 =?utf-8?B?VTJHYzh5NDZpS0E3MldUSE5Ubng3Z3YwWHpKbWtOaDNJZElTOFFUN1VHODZr?=
 =?utf-8?B?QzVmdXkxZEVKbmJtOFhUL1psRlpTekZ1RjJNRVFqeE5lN2pHVFZta2ZMUlhp?=
 =?utf-8?B?QVVXak0rbEVYdFZTdndJSkErV0t5c0gxMUlXbGY1NndodmcrYjd6UzhYeUZ5?=
 =?utf-8?B?eUs5ZG9NNXVNZ0hLZ1lGblk1SVg2QW1JZGtlcVBhVGZMYVNWZnk3WCt2WVBI?=
 =?utf-8?B?TnVsSXVyVUp2b3B4ZEt0cEdlNnBBS1lUTXl5VjN4RTF0TElYU0dWbEVpNDAv?=
 =?utf-8?B?YmZtK282Wmg5K3FDMENoVkpsc3YyTzFqSVJhNkxqaFdoQ1B3b2oxclM1V1Rj?=
 =?utf-8?B?OVp2aEdHaEROU2hwaFNGZDU2OWYySmlYUlJYd3ZTQUVqNFNZeGxoVWpjZ2RU?=
 =?utf-8?B?T1hBdFQwOTl4QkNxYXJqK2xsMzBUVzZXYTZaaDlKZytVc0NyUjRUZUwyVzJS?=
 =?utf-8?B?ZTF3SGpVMDVIUE5rS1J5ZVhtVXlCOE5LVEprRDZUcGJIbEZBdG5SZ2tTcW0x?=
 =?utf-8?B?TGpkWmRUU3l1cTh5VXNJTTNhWWJRRGo0MzBxWkhMZTMxL2NPRythblU5UUpM?=
 =?utf-8?B?MmRPTXFUOStHdEVRM25TcTNscW5BOWxSNmlRZ2loVHlIREdXZ1YyQm1DbXl1?=
 =?utf-8?B?dUVvNEkwaFd1ck90cDhuckFVT2hwMmxpMld1a1ZnR3lKczFLWmRZUElGcDEw?=
 =?utf-8?B?NVE4bk00YTZueUlqQmVjR2hJcXZkQmtNTjNtVXJWTmxjSDVsNmhXQk1jMWtr?=
 =?utf-8?B?WUhCTUVMVnhabHZ2WFprVzhjREVaRG9GdXNGT0N5MmFpbHpvSTRabUJJcGJs?=
 =?utf-8?Q?Wqj9uCfGs8XYWgK2n8?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f723f46-1b43-4976-0b91-08df17c16607
X-MS-Exchange-CrossTenant-AuthSource: PH7PR12MB5685.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 09:19:11.9159 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NUkw4Q5QqhzZHZQRa4nrtbP4WLfmFbk6hMN4thwNB1+U1X2CJWw5DieLBUEedMot
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7144
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

On 9/17/26 14:04, Tvrtko Ursulin wrote:
> Re-floating a simple idea (this time with more Cc) born from an user interest to
> be able to correctly size the swap space during OS installation, based on the
> size of the VRAM a discrete GPU might have. And to be able to do it in a vendor
> agnostic way.
> 
> Idea is to expose a standardized scheme in sysfs, under the DRM class card, and
> under a new 'memstat' directory. Such as, example from amdgpu:
> 
> /sys/class/drm/card1/memstat/
> ├── gtt
> │   ├── total_mb
> │   └── used_mb
> └── vram
>     ├── total_mb
>     └── used_mb
> 
> Or with concrete numbers:
> 
> $ grep -Hr . /sys/class/drm/card1/memstat/
> /sys/class/drm/card1/memstat/vram/total_mb:1024
> /sys/class/drm/card1/memstat/vram/used_mb:445
> /sys/class/drm/card1/memstat/gtt/total_mb:7394
> /sys/class/drm/card1/memstat/gtt/used_mb:71
> 
> Drivers need to implement a simple DRM driver level callback which needs to
> report a stable list of interesting memory regions and their respective stats.
> The region names then become sub-directory names under the new 'memstat'
> directory, with each region exposing the total size and the current usage.
> 
> Similar data can already be queried if the dmem cgroup controller is enabled,
> also only for the participating drivers, by querying the root cgroup. But
> perhaps sysfs is easier, or perhaps it is too much code for too little benefit.
> I am curious to hear any opinions.

The implementation can be polished a bit but I seriously like the idea to standardize that.

amdgpu already exposes the information as non-standard sysfs files and adds a bit more, e.g. CPU visible VRAM size, VRAM vendor etc...

I'm wondering if those shouldn't be added as well and the existing sysfs files then implemented as symlinks.

Regards,
Christian.

> 
> Cc: Maíra Canal <mcanal@igalia.com>
> Cc: Ludovico de Nittis <ludovico.denittis@collabora.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> 
> Tvrtko Ursulin (2):
>   drm: Allow drivers to report standardized memory stats
>   drm/amdgpu: Wire up DRM memory stats reporting
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu.h        |   6 +
>  drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_fdinfo.c |  40 +++++--
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c    |  37 +++++++
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h    |   3 +
>  drivers/gpu/drm/drm_drv.c                  |  10 ++
>  drivers/gpu/drm/drm_sysfs.c                | 123 +++++++++++++++++++++
>  include/drm/drm_device.h                   |  19 ++++
>  include/drm/drm_drv.h                      |   8 ++
>  include/drm/drm_file.h                     |   9 ++
>  include/drm/drm_sysfs.h                    |   4 +
>  11 files changed, 248 insertions(+), 13 deletions(-)
> 

