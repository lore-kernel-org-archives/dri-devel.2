Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE763E9D812
	for <dri-devel@archiver.kernel.org>; Sun,  5 Apr 2026 19:55:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 447D110E1D5;
	Sun,  5 Apr 2026 19:55:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="b3/grZ/b";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011034.outbound.protection.outlook.com [40.107.208.34])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3A12010E1D5
 for <dri-devel@lists.freedesktop.org>; Sun,  5 Apr 2026 19:55:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pW1RQPTz6+s1hViodS+NofFYrbdgTJX2Li3eYmg5n7rzUgNbQXFh9ntxfjhK3lkJ5oSTlZkb9/vHvTv3pO4glbXg4DjXeSHFt1R58uRelfLH02iQJRQnmhQ101BIwcDHNghrN/AprJuw2CFvX1y/Hrqx/b1EYO7oddOniKjFNV4GiFjeXXEK9FbUUHrt435qeG18X2AkyrU+4JHmo8RX6s4K0buQwjSjfdFzJ470loPNy1nSTvk5hMyVHChAZJhXzmyWG4Puipua+oCI+LvvUVilFhSVwoxeYOUTqE33deaHHeFRvJ+CWxxP5Fay4Q6oZ7HMuU89ztnvBpWhNZdq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uIT9Q1pJmuEpUkPm73gznmX1Da9zOKq5Clb0ydHV+R8=;
 b=bTYRXFx652I+YHGITNmza/hT7F/tunmTBr3Y5ir+bPr0SDkJzDa6SeqFmqt2gjlj5cIB5ntcvr94iC8HdEVnO6i7Eva8xf+t39kwHPpGKqGHHtcS+ZyvhDlL3tXe2DqQKE+DkPxgZAxeLXOs8sU7qAwjWL/VyUrElhZvM9hTJvNdohaz2af0YvRcHtOcuc+frFhQdklw30dClynWOGqqGMVnw7cyZRwH+5nMR187SpmKoGKslSooiLpQpRzxzlyik9yk8/pkFHX3NyE6q2e4wNHdTjBEau2XiDE64tFiZL7xQcNhjUiGgLPbXW47sCU/TJ+Q0FZO8KDdc62WUfEwyQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uIT9Q1pJmuEpUkPm73gznmX1Da9zOKq5Clb0ydHV+R8=;
 b=b3/grZ/bVyGGxPp1xjop5L9LCkIjp5v2tr792q8XXrFbw7gA3Few5BEC7u0mhD1oQ1RvOptyZcTUvgmwJIOxSvuLQsReXzbWE43aSwEjfUERxkqhUkx3MmxNK6GWLWkr14nlW43KXIooVHAznoetTi5Qk9lEHqE/8b18fyuTuMarog/c0uO18KdF4vh8Z6qMd1f/X41E+Kk128faVPep69fuAlRe8SQfAjoy5ZSgo1ndv2/DsuVFeBrJU9lUlXWStebhh893fch7ENqx3YI5cItrBIH17sjCVRCBJzPBP8BbwoyWCjWm3rJAVAIxsdqYG+0vN5kwlIVcoZD9EoJ5fg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM3PR12MB9416.namprd12.prod.outlook.com (2603:10b6:0:4b::8) by
 MN2PR12MB4440.namprd12.prod.outlook.com (2603:10b6:208:26e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Sun, 5 Apr
 2026 19:55:50 +0000
Received: from DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8]) by DM3PR12MB9416.namprd12.prod.outlook.com
 ([fe80::8cdd:504c:7d2a:59c8%5]) with mapi id 15.20.9769.020; Sun, 5 Apr 2026
 19:55:50 +0000
Message-ID: <fd010f7a-6d0d-4faf-bdea-23bac608f03e@nvidia.com>
Date: Sun, 5 Apr 2026 12:55:47 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/9] gpu: nova-core: gsp: add NV_STATUS error code
 bindings
To: Eliot Courtney <ecourtney@nvidia.com>, Danilo Krummrich
 <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>,
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: Alistair Popple <apopple@nvidia.com>,
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org
References: <20260325-rmcontrol-v3-0-f3101093484e@nvidia.com>
 <20260325-rmcontrol-v3-1-f3101093484e@nvidia.com>
Content-Language: en-US
From: John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20260325-rmcontrol-v3-1-f3101093484e@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0278.namprd03.prod.outlook.com
 (2603:10b6:408:f5::13) To DM3PR12MB9416.namprd12.prod.outlook.com
 (2603:10b6:0:4b::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PR12MB9416:EE_|MN2PR12MB4440:EE_
X-MS-Office365-Filtering-Correlation-Id: e3ae8923-ecec-45eb-d222-08de934d5657
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|10070799003|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: hk+PKKHHqoJU9SlYIv7okMkZaXXVe2ZBw3ajHOoghmEQdiE0vs9J7OgNnLoBPFVzy5rZqt8J4XGUeJRBKasESdvgacjs0fjb758dbmyTFmF+eFSP2Dbilj+2MoNUWOD74UuSpVnIxTpnHW1h2m09zig7H+XR0YEDylfHoHTNT0zYZ4dM+cAmHjIDjLyI5yKlg+0t8fcc7zKtsgxXeFDlzEdHB/NzCG8/3pj+VzD8XU6o7m6c16zSACoGEZBn91F9BYYDVHybwwa86pAI8jXYvGhHXkGhHSLCD4mYplfWZr8tur8rYDeRACysFsPaQy7Grg9MuKG4lEyrNT/upmEsppHiMNaecZ0tW49Igh2WKtXfggWa24E0vtV2fgAuBPC3jj6xmGoQFixWzh8rTJxYvC8y6FIlc4xdoGXDvq5hKFJyKiAHfO85ccZOE2d9jQ0hnllbNASxQ4WXm4uMdaAIGHl/M3VJvHcQRoULYlCdCmxnVojDx/TvUirFzVCpBc7UWLLPZRbrKYEzTJJkAdTHsrmriO4bDAdbpKNtp213CXJyEvrhgjkgRQIz3DqPHFwdNclFR67yB+aUh/RvE1iLdynady8DDeVZyJ1QXMWYFIRvNyaRUwiYaly9Cr3k7QIRp/ibRdI5PKeXOn7P0fcpWIto5sxryVE07IX9xHIkLJ3uGy5+GtB9QIvz1uQicyPb5o7FlSfHMGtEZNnGy3jJ4xdBWzW3yGKDi2OoCfwcsXO0mRgSPPcrGxFComlqo0xT
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DM3PR12MB9416.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(10070799003)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eEJoZXduZ3BmWjFhdy9JeXZtVG1OeC9QSWdTSXdlNnNSNDZURmlpdUhkbVV5?=
 =?utf-8?B?YU9OWlJMRmxJV3N6bCthUkNSMXFVZy9PamRscjUzV0Jja1pxV2toRGlVTHZL?=
 =?utf-8?B?MFhOaDA0UEs1UC9PblZ1aFhLZzZqOFZrV3NOTWd6NXpaQTdFczBJL0I2TG5R?=
 =?utf-8?B?MnBsbzdQUG9nNUNxaGNUUzdVOE16ZXBlTSt1MnoxbW5wdDRSS25Db2FmQUYr?=
 =?utf-8?B?S20yMTlZMGRCSWpGc0tpYjNsNlA1QUZac2crUEkrZENWVWU5MVo3L1QvbW5B?=
 =?utf-8?B?WDdSMDVpUWZYbnVoUXl4MjlmTlVrdURURjhYZjlJN0F4T1JtL2c1dFgzL3Fu?=
 =?utf-8?B?NEZOaVEzVk5ISzRoOTFnOVRBL2hXL05DUG10MHI5OTlybVJmREdDTGRnemF2?=
 =?utf-8?B?U2xneXJHMUZscnM4U2lYQUNPbVREbDFpU05qQUtUejVuNytucnhUMlFxbjNG?=
 =?utf-8?B?VFVuSG13RzFyNHhkWVRZK2RzNlg2TGYzdXB5TWZnZnVhQ2t1UnIyNTBNSVVP?=
 =?utf-8?B?aENWT3hDRXF4b1ZFNnpzcFJEM0V4dVJ5ditoTU03cHpYV1kzUkJIdjdjd0xx?=
 =?utf-8?B?TmN4bGpIcGdnQ2FzZVNCN0NUN1JSZmx4N0lhV3ZYVnZPd0NKUmlBS2RodDZz?=
 =?utf-8?B?cDM0cmI2TFpKSGMvVkE0RkUyVG80SWdxNTJqYXZ1MXdlR1JNaVVLQm5acHFU?=
 =?utf-8?B?MmZJcGxkL2gwOXJwTkZtTU1iTXN6TGloQVJwTkRyTzRvdXlOTFVrcXlOUzgv?=
 =?utf-8?B?K3VSUFBoY21QY0ttRXlWa3lqSGR6b0c2cHRMUkl4RTVVKzZEVUwzN1kxNHZV?=
 =?utf-8?B?T2pQS1ljc3k1MU1KUkVFQlR4d2RxQ0ZZUEl0cXNsN1lMaDFmc1lXVUxITmpy?=
 =?utf-8?B?VWU0V01OQURBRXI5bWIzL0diVUpNbXhpeDZFNnNVZm0zbXlLeEs4dW1vbXNW?=
 =?utf-8?B?a1l6QjFMNEo2Wkd1dE9BOGpEYkZnY1lNQzFFd3YxbFdVWE4rNnFhczc5c2l1?=
 =?utf-8?B?MVpiWWFEK09UMCtNRTdpc2lWaldBckhSYUkwVmpuVzNHYnRMai93SmJiRU1m?=
 =?utf-8?B?aWpYZUkwNGdYVk9XR3Y1dGw0eFV0VG5tZ0xYTldLclhNS0VhUVQ1RHhGcER5?=
 =?utf-8?B?dlR4L3htalZ5cW1udzFTZUNxY21SYjgyTCs5QnpabHZndTdTODdxN3diZHkw?=
 =?utf-8?B?UVlTd0lLQi9HL2tWZFhXL1V4cFdsbVIwREVxWkZWdUdncjJJUGJTeGdBZ2lq?=
 =?utf-8?B?WWowaVZSWlJCbklzemczeCtuMnJGaytmR2RYZEdodXp3Q05WOVE1Ui9jV3Er?=
 =?utf-8?B?bFN1UXQ5amcvUE01NWh1VzJxZmFyL0FNdWxnNG5BaW93YitPVm1tSTMrSmwv?=
 =?utf-8?B?T2I5S2pidWdYRHI4RVBZbU92bkRYaUZhVjdSR2U2R0lOMnRLeUJpUC82VDEx?=
 =?utf-8?B?ZXF2TWU4OVFkV01TdlZVKzZ0Q3hvb28vK0JNcGFJaUkxcGNRQmF3WHd1SUxk?=
 =?utf-8?B?M2Z6LzZKbER6UGZvZlRRdlNCU3Y4L0JXK2p3dzhnN3hvOXFtd3BxUUc2TVNU?=
 =?utf-8?B?TW5aTFNRQUhlb3JTRnh2L3VLYWxJeHN0R3NBejhsMzFlVVZTNVk4YmZiTEF1?=
 =?utf-8?B?clIvbW1weC9yeWtWdVBkb3kybEVwL3BDcVFwUUwyVDNDdHIyMXR4YjkraU1a?=
 =?utf-8?B?UVZydUdvaDRtSWVtcGNhd0VvcDJZVG1objZ3RFNTdlJacUlZU1RYS1N6aUhh?=
 =?utf-8?B?ekliVlNHSms0T2hYU2xrK2I4eHBtMWpOTlZ5c2JtbEFreFdqWXVOa2ZEQ2hU?=
 =?utf-8?B?ZkVydzJpVUxXdnRKVEdLU2VQOW81ZGdZTFlHdiszajdxMHluLzcrYy9lS25E?=
 =?utf-8?B?YUR2MTQxajcwd1dJbkdkZC9YVGt5U2k1QWl6QXFMdjA1dnVLdDRKTXY2Lzdu?=
 =?utf-8?B?UkxxN0FtK1FQZjgyZVlUZmY3OU5Ybk9FS016MnZGTWJBSXpLb0NyR3FObkJh?=
 =?utf-8?B?TndCbzR1aXpOZmNiWkZBTERoK2NrZmc5UTRRdVZWTWMrRWhhTTBHemFmRHEw?=
 =?utf-8?B?bXBOSFBGb3hVOGJXQ2o2MXlLVEN3RnR3RmlteFlqd0tvSzVXOTc0b2pqNW1W?=
 =?utf-8?B?eUF4aVJBdmlQdlZoN0cyUGloaVN2RzYyK25MdTBIVTJDTDU3UkhjbTRlUlhy?=
 =?utf-8?B?WnN1VW9YQTdzaXl0QkZ2OTV6RGIxY2gwR2dVckF5RzZQNmlBeVpTVXRiNXVN?=
 =?utf-8?B?YWpWQ3g5TC82K0RPcXlmL0J0RnN6NDFsbkJjNmdIZERYemlSUXlmV3dobzgz?=
 =?utf-8?B?ZlR0c0hwcHZDZDFZVk43MVhaNFZPdnZEemlzZTMwQ3ZVNjd3bnFOVWd6c2hl?=
 =?utf-8?Q?bka1UeYyb3RXaIGI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3ae8923-ecec-45eb-d222-08de934d5657
X-MS-Exchange-CrossTenant-AuthSource: DM3PR12MB9416.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Apr 2026 19:55:50.4828 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x0GCpYf6L+8TAh2zmhI+IpKQLIW643y1TbeIDzU9mwdY97UWBFPEbWof5on/d3GJYHrc89/RWHj7iPM1VuW5HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4440
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

On 3/25/26 5:13 AM, Eliot Courtney wrote:
> Add bindgen generated constants for NV_STATUS. This is used for RM
> control messages.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>   drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 144 ++++++++++++++++++++++
>   1 file changed, 144 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> index 334e8be5fde8..dd37a7fd58c6 100644
> --- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> @@ -379,6 +379,150 @@ pub struct NV2080_CTRL_CMD_FB_GET_FB_REGION_INFO_PARAMS {
>       pub __bindgen_padding_0: [u8; 4usize],
>       pub fbRegion: [NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO; 16usize],
>   }
> +pub const NV_OK: _bindgen_ty_4 = 0;
> +pub const NV_ERR_GENERIC: _bindgen_ty_4 = 65535;
...
> +pub const NV_ERR_RESOURCE_RETIREMENT_ERROR: _bindgen_ty_4 = 134;
> +pub const NV_WARN_HOT_SWITCH: _bindgen_ty_4 = 65537;
> +pub const NV_WARN_INCORRECT_PERFMON_DATA: _bindgen_ty_4 = 65538;

If we go with pulling these ERR_ and WARN_ items in directly
from GSP-RM, then we should also update Alistair's bindgen
helper, or my fork of it:

     https://github.com/apopple-nvidia/nova-gsp-binding-generator/commits/main/
     https://github.com/johnhubbard/nova-gsp-binding-generator/commits/main

However, the deeper problem is that the C headers define these as
#defines, so bindgen emits pub const u32 items. The hand-written
NvStatus enum in patch 2 has no compile-time relationship to them. When
Open RM adds a new code, the Rust enum silently absorbs it into
Unknown(u32) -> Err(EIO) with no compiler diagnostic.

Which brings us back to a feature that Alex Courbot and Danilo have been
asking for, and I've been treating as "nice to have, maybe next month"
for apparently too long. And that is, generating Rust bindings directly
from the GSP-RM build system.

I think it's time, yes?

> +pub const NV_WARN_MISMATCHED_SLAVE: _bindgen_ty_4 = 65539;
> +pub const NV_WARN_MISMATCHED_TARGET: _bindgen_ty_4 = 65540;
> +pub const NV_WARN_MORE_PROCESSING_REQUIRED: _bindgen_ty_4 = 65541;
> +pub const NV_WARN_NOTHING_TO_DO: _bindgen_ty_4 = 65542;
> +pub const NV_WARN_NULL_OBJECT: _bindgen_ty_4 = 65543;
> +pub const NV_WARN_OUT_OF_RANGE: _bindgen_ty_4 = 65544;
> +pub type _bindgen_ty_4 = ffi::c_uint;
>   #[repr(C)]
>   #[derive(Debug, Copy, Clone, MaybeZeroable)]
>   pub struct NV2080_CTRL_GPU_GET_GID_INFO_PARAMS {
> 

thanks,
-- 
John Hubbard

