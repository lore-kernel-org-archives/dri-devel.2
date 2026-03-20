Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 393EEFB5EA9
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 04:10:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 76A8510E886;
	Fri, 20 Mar 2026 04:10:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="GalKF6Lu";
	dkim-atps=neutral
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010071.outbound.protection.outlook.com [52.101.201.71])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 954A110E886
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 04:10:43 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FavovoqRGMRGsL0KrtHURMyKUd2wdHuA77GScPVPY0BB4ky2ByBvck9AqQx6uJQX7K62W1ZsNAfYssxjzW8GKSkVQ5t2jYdeds/QIGn2KBygdiQ07wlJ987EJFpmrGks/rnvCV4B3u8i93vJ+Kbyu5TT0835dFJDVRMzkYV0XCByHmY+jP86JEzCjQXtaRIFk32pK8IDjrLL49zOg/1B5TlXALaV19+w6oEDASLFt9vOuwXRsNSbj2mC64s+u0GVd14DAkwqqh7EmY+RE/4SHSkRAtQAfMFG0ct9oxv9N8VHDVSuxmgGQYjwZ7R+WRoUQsDW7z7e2Kz6Ap9d+O0lhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+9YvMde8sXatxT6zD9eZWw3RCV2CJJzBbxJhpVh3tzk=;
 b=CaIDo26FuyjaKU/YegQ53ZwcUuQrWZiEO4uvf5sHO8fFs+Xt0Xpz3mFJw9o06DUbwpbGX76qeVMygJOopa08aWVaKtL280BTEfd+GkMSl+IMkjKGINkb/iz+7mn2ZOV3vULKnJo/qf1fddTkWufufj6E2rNnG/t2u0HurxOEpX/ldg2nkmKaW2bNntnLLciWllIVUBh6Dy3/lWlwZZs9gWEHj6/fEAGZeKEYV2+++KNNQVKxjw5lZsU9xW2WqWCG3VgXicBUY9TuApkdW/IM46MhBLPaIP7fKA1+hqX/xOqaMLnfn29P0xLgy46d8AhIP72IJbTVJ+cFAaGQT2+Yzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+9YvMde8sXatxT6zD9eZWw3RCV2CJJzBbxJhpVh3tzk=;
 b=GalKF6Lu4w3bPWyIDuK1RpviyOxNEHzZot5yWPag8LEdwm6hcC8av/UgKGxak2IfT+IA/RNZjgGaYgdLh3KoTRMlHUkg6KR+W/cOssPAQqbmuxwM0rUAifPY9DS5TIktcDgfhQ6v4HK3Ps626c3udRMKb8U3C7GkYql9wZ22ZCFQFAbGRrw7Z57MNiuAjXlvHO7dOt1ebZL4Nd8GWg7JpNv/6bVYujGanpd196EGfGw3+axFqEoSJSJv6cNWhxDWiD74R9/lEs8V4HSQLzTWVjdKCko4jW4M2BPvWB7TjCieIzsycd9XJEH2pXAL/9heZ3lWH8mgikIxpMwsSrIUKQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS0PR12MB7726.namprd12.prod.outlook.com (2603:10b6:8:130::6) by
 PH7PR12MB6717.namprd12.prod.outlook.com (2603:10b6:510:1b0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Fri, 20 Mar
 2026 04:10:40 +0000
Received: from DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0]) by DS0PR12MB7726.namprd12.prod.outlook.com
 ([fe80::5807:8e24:69b0:f6c0%4]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 04:10:40 +0000
Date: Fri, 20 Mar 2026 15:10:34 +1100
From: Alistair Popple <apopple@nvidia.com>
To: Eliot Courtney <ecourtney@nvidia.com>
Cc: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, John Hubbard <jhubbard@nvidia.com>, 
 Joel Fernandes <joelagnelf@nvidia.com>, Timur Tabi <ttabi@nvidia.com>,
 rust-for-linux@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/9] gpu: nova-core: gsp: add NV_STATUS error code
 bindings
Message-ID: <abzIRct2dgUZGT9E@nvdebian.thelocal>
References: <20260318-rmcontrol-v2-0-9a9fa6f1c4c3@nvidia.com>
 <20260318-rmcontrol-v2-1-9a9fa6f1c4c3@nvidia.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260318-rmcontrol-v2-1-9a9fa6f1c4c3@nvidia.com>
X-ClientProxiedBy: SYYP282CA0014.AUSP282.PROD.OUTLOOK.COM
 (2603:10c6:10:b4::24) To DS0PR12MB7726.namprd12.prod.outlook.com
 (2603:10b6:8:130::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB7726:EE_|PH7PR12MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d518599-a538-4e13-1b6c-08de8636a597
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: 0ULvkSMiYFoltPDKuoYV8r8hzgO0GXZo+nHlr8WHFN7//QiiXHwgYli/TMRgZNyzeAnF2ZCcEBVnxopOqQGKAj5YC7jOw4maIfDelLYul+Dxpw2JAOoKaGIeJn9KQftkfzx7A23kZXXdElwCMnmLdoftSOAnngY1m3Xo45gj/Ajov836FL9UZkuN9u1eZ7zM22F4I4d5bXQvuF9uFJKtU+DC6ydENP8pIoTaqMYuw+ibY0SUYLicr65ULu8NZ+n4srORTwu3zZYlXnN/Di+ZryOI5bXvJwF0methLQNXiCCyW29jODGI31LRPsn2sPzbajUEkIHqmuUoi96JCBP3gNN4QX8LFMoPPr2yRNs7iv114OZW+u/fJJ/iruYLHVKyd7QFMck0HdnpzJI+9rXt/XTnLb6t3KtsOLw6p1eXAIs/jrCLXug++P0GmwHHfHKaPhp9SQ2pNahnZYTIp1t53V7Dwt5oSFwZzyFPUQyAWUo+pq5ixOXtC9MN4MjVgBH+m1ZYe52BIiJfLxwUDiAgo0gag/Wha8U/sBsd/RSuX/Jfy33IzIF+PPNhcpmSTi13tyvbc99SRMhzRvrYcGuxcriDptuXgv07SSVeHZxmc1dV/u4LnRF9FRTWoFu6hSvBkZj/IfCEyt5bEvIHsDIZINy0OdAs+CayQk6viV6Q1/1pSTUN5ci6rPs/aW+dULocDQUHf5Iw5t0rB8VHXOZPmNQbedLCCIFZquMeu+H1Sv66llZnLbBRS1ZV+T3wIJjW
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR12MB7726.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?KQjtAJTMYeM7RYn/4h6GdTz0MfiAJtVwhSljr4oBNY3AGORTfPtqyG3owa16?=
 =?us-ascii?Q?Xra7LHEddXFq9swX3AS5k2iqBMnksaX3B0Zi+IWQTHpWiE+roRqZWsuWQ60I?=
 =?us-ascii?Q?Y7naT4ZxybaDY0WR9Owp0/NeJTj/XHAlLLzlDyZm3LgodlMyeswKvdODg3Bx?=
 =?us-ascii?Q?bMsoYbcGkvZSrMvXAgGkHsk64jdDoMvcs4ZAnMV/FVoofBvmaeXqq6ViEvG8?=
 =?us-ascii?Q?32h/pg08TJdGeBTX9RFqB89HIoJqLtfMXf+QgyPLOOBb9L8ZKgBMQRwue8LK?=
 =?us-ascii?Q?kT3WBlcjZJas3IQBOd4v3YMpRLvNhi8O1mjKnY1UQGk8bKNLfYHl9w57pZ0j?=
 =?us-ascii?Q?KnVsKILb7tLfHgsmBfAE82fcjDKVHZZxo3j3lYm7RLB7FsLNcEdTI1ParvNJ?=
 =?us-ascii?Q?vaQSJ1N+I12WstoovuK1LcMbiCc55cm7l0NrG1ANSYSndbRI+DI4Ksgn6qgk?=
 =?us-ascii?Q?nhS9g7auPv7pBIQQlY7HGPz41XhZX6uiK6KuUOle0x5hnx0MvWpF13jcSnEp?=
 =?us-ascii?Q?XZVoikGKtRhFwXqOMun+NXdM9dLzEvI0/NZQcrgDA5RDPwZCstNA128nGHZ+?=
 =?us-ascii?Q?FSrIER7XXT81lkyQSSLAhiVsw/gdsWcJTJetDnzZRbVCsd+1IOurSuygI0eG?=
 =?us-ascii?Q?DZoPZrs+pBcvW45E3q0Ib2yihEfxe1fhApoahELjd//WdrYj/ZWw1kj2zY/z?=
 =?us-ascii?Q?1wxDtNAb6yocDP5/dAt31NRSTG3oAUKbfi8PLsElK3VPJYNfovL3kxyIEnBg?=
 =?us-ascii?Q?gz1zFcmpv0ufTRZUN7E/XsEZ/uMoY5plvmbqj4tcgtSXIDZKVKk6TPTX1a38?=
 =?us-ascii?Q?RTa6FNA+ZCl/rIqYdCnX0GrF8Yp3mhjme0jtkvStldE0hBBVldWj7lZ5q5xC?=
 =?us-ascii?Q?JeLNY7Ugq8Sq0Sp6AC5xvCr60nSb2buyXozJa4S73MmIH2cXOZgrm26MFieh?=
 =?us-ascii?Q?XwfjtUw0UOwC+IV95WndzsIIp0Ef27GdSdEwKUw+xsDzyg4wBp3OMDH7qdKw?=
 =?us-ascii?Q?xkDv4G43UOOso+rHwLYTqpWU/PbMl7Frv1lfoD3ubxMKKCl1e1sqV+8ZlZq+?=
 =?us-ascii?Q?j9scT2Rdg5m8KPqQMxmPzi25aNIp0DNYlmMzYstv74eQd8J+ON4fuNU1KKbF?=
 =?us-ascii?Q?14Evn9/J18QWuXAgBMM5GPohlfdrISdAuISm4/suYDKPBGjXPQ5OSMMtuuIV?=
 =?us-ascii?Q?fLFrpdMFfBuOBbZc2MwFE67iMN60B7fsuteBBRamPVbgwtc2YT6AvV35ZZ3I?=
 =?us-ascii?Q?VCB0q0Tw7tJfEqgr/uxV+C53qOoJsOsJzblbvxc1nr1WoIUDcgllG1ZUfpTs?=
 =?us-ascii?Q?RsTGBXJcXpfBWDuOltpnrWEBKTeZYKRve7Ew069EvXNOzFRNIHg7ungudG46?=
 =?us-ascii?Q?0ZjiOT7tgR5OQeEZGwEoorffUqQwbaVsrmffE9jwucR00ZbHAsJRMhOpUVaV?=
 =?us-ascii?Q?uOmxTrOHB24zzlqFJmtKVibV6bctl6BFety51rLRP7/QEqLBsRsZMmHfIR57?=
 =?us-ascii?Q?9vh/Q6KR1HqgXzSK2NHPnoD3j40J145B4LlyS2qezVEmYr9EkTNo6/v20tsG?=
 =?us-ascii?Q?w/gKxae84SVNZYAg8JPn+7xiLshRpegjm7nensu1crmlql06YMG9D2DjEUKq?=
 =?us-ascii?Q?IH/uvM6kPlF4yMQmYfRBogGaz1QW5yYbbSG5zOoWJ/uiWRHMg+MYJFwz6xLf?=
 =?us-ascii?Q?QdAWKLGIulVbVbNZTRW/EADravgySvG17czhnylVjJM/Y6yqvYk5I52IAD0l?=
 =?us-ascii?Q?q4JVPuugfw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d518599-a538-4e13-1b6c-08de8636a597
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB7726.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 04:10:39.9788 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h7Ne8X3P3TwIDzTPdvwOLWfJ2wI+edJY+cyEdygHw6w3ci6xtF4HsqP2QDRaA3fnvW/jAUWeGsIfllXN31QLrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6717
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

The sooner bindgen goes away the better, but for now can you make sure to send a
pull request to https://github.com/apopple-nvidia/nova-gsp-binding-generator so
everyone can regenerate these if needed? Thanks!

 - Alistair

On 2026-03-18 at 18:13 +1100, Eliot Courtney <ecourtney@nvidia.com> wrote...
> Add bindgen generated constants for NV_STATUS. This is used for RM
> control messages.
> 
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs | 144 ++++++++++++++++++++++
>  1 file changed, 144 insertions(+)
> 
> diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> index 334e8be5fde8..dd37a7fd58c6 100644
> --- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> @@ -379,6 +379,150 @@ pub struct NV2080_CTRL_CMD_FB_GET_FB_REGION_INFO_PARAMS {
>      pub __bindgen_padding_0: [u8; 4usize],
>      pub fbRegion: [NV2080_CTRL_CMD_FB_GET_FB_REGION_FB_REGION_INFO; 16usize],
>  }
> +pub const NV_OK: _bindgen_ty_4 = 0;
> +pub const NV_ERR_GENERIC: _bindgen_ty_4 = 65535;
> +pub const NV_ERR_BROKEN_FB: _bindgen_ty_4 = 1;
> +pub const NV_ERR_BUFFER_TOO_SMALL: _bindgen_ty_4 = 2;
> +pub const NV_ERR_BUSY_RETRY: _bindgen_ty_4 = 3;
> +pub const NV_ERR_CALLBACK_NOT_SCHEDULED: _bindgen_ty_4 = 4;
> +pub const NV_ERR_CARD_NOT_PRESENT: _bindgen_ty_4 = 5;
> +pub const NV_ERR_CYCLE_DETECTED: _bindgen_ty_4 = 6;
> +pub const NV_ERR_DMA_IN_USE: _bindgen_ty_4 = 7;
> +pub const NV_ERR_DMA_MEM_NOT_LOCKED: _bindgen_ty_4 = 8;
> +pub const NV_ERR_DMA_MEM_NOT_UNLOCKED: _bindgen_ty_4 = 9;
> +pub const NV_ERR_DUAL_LINK_INUSE: _bindgen_ty_4 = 10;
> +pub const NV_ERR_ECC_ERROR: _bindgen_ty_4 = 11;
> +pub const NV_ERR_FIFO_BAD_ACCESS: _bindgen_ty_4 = 12;
> +pub const NV_ERR_FREQ_NOT_SUPPORTED: _bindgen_ty_4 = 13;
> +pub const NV_ERR_GPU_DMA_NOT_INITIALIZED: _bindgen_ty_4 = 14;
> +pub const NV_ERR_GPU_IS_LOST: _bindgen_ty_4 = 15;
> +pub const NV_ERR_GPU_IN_FULLCHIP_RESET: _bindgen_ty_4 = 16;
> +pub const NV_ERR_GPU_NOT_FULL_POWER: _bindgen_ty_4 = 17;
> +pub const NV_ERR_GPU_UUID_NOT_FOUND: _bindgen_ty_4 = 18;
> +pub const NV_ERR_HOT_SWITCH: _bindgen_ty_4 = 19;
> +pub const NV_ERR_I2C_ERROR: _bindgen_ty_4 = 20;
> +pub const NV_ERR_I2C_SPEED_TOO_HIGH: _bindgen_ty_4 = 21;
> +pub const NV_ERR_ILLEGAL_ACTION: _bindgen_ty_4 = 22;
> +pub const NV_ERR_IN_USE: _bindgen_ty_4 = 23;
> +pub const NV_ERR_INFLATE_COMPRESSED_DATA_FAILED: _bindgen_ty_4 = 24;
> +pub const NV_ERR_INSERT_DUPLICATE_NAME: _bindgen_ty_4 = 25;
> +pub const NV_ERR_INSUFFICIENT_RESOURCES: _bindgen_ty_4 = 26;
> +pub const NV_ERR_INSUFFICIENT_PERMISSIONS: _bindgen_ty_4 = 27;
> +pub const NV_ERR_INSUFFICIENT_POWER: _bindgen_ty_4 = 28;
> +pub const NV_ERR_INVALID_ACCESS_TYPE: _bindgen_ty_4 = 29;
> +pub const NV_ERR_INVALID_ADDRESS: _bindgen_ty_4 = 30;
> +pub const NV_ERR_INVALID_ARGUMENT: _bindgen_ty_4 = 31;
> +pub const NV_ERR_INVALID_BASE: _bindgen_ty_4 = 32;
> +pub const NV_ERR_INVALID_CHANNEL: _bindgen_ty_4 = 33;
> +pub const NV_ERR_INVALID_CLASS: _bindgen_ty_4 = 34;
> +pub const NV_ERR_INVALID_CLIENT: _bindgen_ty_4 = 35;
> +pub const NV_ERR_INVALID_COMMAND: _bindgen_ty_4 = 36;
> +pub const NV_ERR_INVALID_DATA: _bindgen_ty_4 = 37;
> +pub const NV_ERR_INVALID_DEVICE: _bindgen_ty_4 = 38;
> +pub const NV_ERR_INVALID_DMA_SPECIFIER: _bindgen_ty_4 = 39;
> +pub const NV_ERR_INVALID_EVENT: _bindgen_ty_4 = 40;
> +pub const NV_ERR_INVALID_FLAGS: _bindgen_ty_4 = 41;
> +pub const NV_ERR_INVALID_FUNCTION: _bindgen_ty_4 = 42;
> +pub const NV_ERR_INVALID_HEAP: _bindgen_ty_4 = 43;
> +pub const NV_ERR_INVALID_INDEX: _bindgen_ty_4 = 44;
> +pub const NV_ERR_INVALID_IRQ_LEVEL: _bindgen_ty_4 = 45;
> +pub const NV_ERR_INVALID_LIMIT: _bindgen_ty_4 = 46;
> +pub const NV_ERR_INVALID_LOCK_STATE: _bindgen_ty_4 = 47;
> +pub const NV_ERR_INVALID_METHOD: _bindgen_ty_4 = 48;
> +pub const NV_ERR_INVALID_OBJECT: _bindgen_ty_4 = 49;
> +pub const NV_ERR_INVALID_OBJECT_BUFFER: _bindgen_ty_4 = 50;
> +pub const NV_ERR_INVALID_OBJECT_HANDLE: _bindgen_ty_4 = 51;
> +pub const NV_ERR_INVALID_OBJECT_NEW: _bindgen_ty_4 = 52;
> +pub const NV_ERR_INVALID_OBJECT_OLD: _bindgen_ty_4 = 53;
> +pub const NV_ERR_INVALID_OBJECT_PARENT: _bindgen_ty_4 = 54;
> +pub const NV_ERR_INVALID_OFFSET: _bindgen_ty_4 = 55;
> +pub const NV_ERR_INVALID_OPERATION: _bindgen_ty_4 = 56;
> +pub const NV_ERR_INVALID_OWNER: _bindgen_ty_4 = 57;
> +pub const NV_ERR_INVALID_PARAM_STRUCT: _bindgen_ty_4 = 58;
> +pub const NV_ERR_INVALID_PARAMETER: _bindgen_ty_4 = 59;
> +pub const NV_ERR_INVALID_PATH: _bindgen_ty_4 = 60;
> +pub const NV_ERR_INVALID_POINTER: _bindgen_ty_4 = 61;
> +pub const NV_ERR_INVALID_REGISTRY_KEY: _bindgen_ty_4 = 62;
> +pub const NV_ERR_INVALID_REQUEST: _bindgen_ty_4 = 63;
> +pub const NV_ERR_INVALID_STATE: _bindgen_ty_4 = 64;
> +pub const NV_ERR_INVALID_STRING_LENGTH: _bindgen_ty_4 = 65;
> +pub const NV_ERR_INVALID_READ: _bindgen_ty_4 = 66;
> +pub const NV_ERR_INVALID_WRITE: _bindgen_ty_4 = 67;
> +pub const NV_ERR_INVALID_XLATE: _bindgen_ty_4 = 68;
> +pub const NV_ERR_IRQ_NOT_FIRING: _bindgen_ty_4 = 69;
> +pub const NV_ERR_IRQ_EDGE_TRIGGERED: _bindgen_ty_4 = 70;
> +pub const NV_ERR_MEMORY_TRAINING_FAILED: _bindgen_ty_4 = 71;
> +pub const NV_ERR_MISMATCHED_SLAVE: _bindgen_ty_4 = 72;
> +pub const NV_ERR_MISMATCHED_TARGET: _bindgen_ty_4 = 73;
> +pub const NV_ERR_MISSING_TABLE_ENTRY: _bindgen_ty_4 = 74;
> +pub const NV_ERR_MODULE_LOAD_FAILED: _bindgen_ty_4 = 75;
> +pub const NV_ERR_MORE_DATA_AVAILABLE: _bindgen_ty_4 = 76;
> +pub const NV_ERR_MORE_PROCESSING_REQUIRED: _bindgen_ty_4 = 77;
> +pub const NV_ERR_MULTIPLE_MEMORY_TYPES: _bindgen_ty_4 = 78;
> +pub const NV_ERR_NO_FREE_FIFOS: _bindgen_ty_4 = 79;
> +pub const NV_ERR_NO_INTR_PENDING: _bindgen_ty_4 = 80;
> +pub const NV_ERR_NO_MEMORY: _bindgen_ty_4 = 81;
> +pub const NV_ERR_NO_SUCH_DOMAIN: _bindgen_ty_4 = 82;
> +pub const NV_ERR_NO_VALID_PATH: _bindgen_ty_4 = 83;
> +pub const NV_ERR_NOT_COMPATIBLE: _bindgen_ty_4 = 84;
> +pub const NV_ERR_NOT_READY: _bindgen_ty_4 = 85;
> +pub const NV_ERR_NOT_SUPPORTED: _bindgen_ty_4 = 86;
> +pub const NV_ERR_OBJECT_NOT_FOUND: _bindgen_ty_4 = 87;
> +pub const NV_ERR_OBJECT_TYPE_MISMATCH: _bindgen_ty_4 = 88;
> +pub const NV_ERR_OPERATING_SYSTEM: _bindgen_ty_4 = 89;
> +pub const NV_ERR_OTHER_DEVICE_FOUND: _bindgen_ty_4 = 90;
> +pub const NV_ERR_OUT_OF_RANGE: _bindgen_ty_4 = 91;
> +pub const NV_ERR_OVERLAPPING_UVM_COMMIT: _bindgen_ty_4 = 92;
> +pub const NV_ERR_PAGE_TABLE_NOT_AVAIL: _bindgen_ty_4 = 93;
> +pub const NV_ERR_PID_NOT_FOUND: _bindgen_ty_4 = 94;
> +pub const NV_ERR_PROTECTION_FAULT: _bindgen_ty_4 = 95;
> +pub const NV_ERR_RC_ERROR: _bindgen_ty_4 = 96;
> +pub const NV_ERR_REJECTED_VBIOS: _bindgen_ty_4 = 97;
> +pub const NV_ERR_RESET_REQUIRED: _bindgen_ty_4 = 98;
> +pub const NV_ERR_STATE_IN_USE: _bindgen_ty_4 = 99;
> +pub const NV_ERR_SIGNAL_PENDING: _bindgen_ty_4 = 100;
> +pub const NV_ERR_TIMEOUT: _bindgen_ty_4 = 101;
> +pub const NV_ERR_TIMEOUT_RETRY: _bindgen_ty_4 = 102;
> +pub const NV_ERR_TOO_MANY_PRIMARIES: _bindgen_ty_4 = 103;
> +pub const NV_ERR_UVM_ADDRESS_IN_USE: _bindgen_ty_4 = 104;
> +pub const NV_ERR_MAX_SESSION_LIMIT_REACHED: _bindgen_ty_4 = 105;
> +pub const NV_ERR_LIB_RM_VERSION_MISMATCH: _bindgen_ty_4 = 106;
> +pub const NV_ERR_PRIV_SEC_VIOLATION: _bindgen_ty_4 = 107;
> +pub const NV_ERR_GPU_IN_DEBUG_MODE: _bindgen_ty_4 = 108;
> +pub const NV_ERR_FEATURE_NOT_ENABLED: _bindgen_ty_4 = 109;
> +pub const NV_ERR_RESOURCE_LOST: _bindgen_ty_4 = 110;
> +pub const NV_ERR_PMU_NOT_READY: _bindgen_ty_4 = 111;
> +pub const NV_ERR_FLCN_ERROR: _bindgen_ty_4 = 112;
> +pub const NV_ERR_FATAL_ERROR: _bindgen_ty_4 = 113;
> +pub const NV_ERR_MEMORY_ERROR: _bindgen_ty_4 = 114;
> +pub const NV_ERR_INVALID_LICENSE: _bindgen_ty_4 = 115;
> +pub const NV_ERR_NVLINK_INIT_ERROR: _bindgen_ty_4 = 116;
> +pub const NV_ERR_NVLINK_MINION_ERROR: _bindgen_ty_4 = 117;
> +pub const NV_ERR_NVLINK_CLOCK_ERROR: _bindgen_ty_4 = 118;
> +pub const NV_ERR_NVLINK_TRAINING_ERROR: _bindgen_ty_4 = 119;
> +pub const NV_ERR_NVLINK_CONFIGURATION_ERROR: _bindgen_ty_4 = 120;
> +pub const NV_ERR_RISCV_ERROR: _bindgen_ty_4 = 121;
> +pub const NV_ERR_FABRIC_MANAGER_NOT_PRESENT: _bindgen_ty_4 = 122;
> +pub const NV_ERR_ALREADY_SIGNALLED: _bindgen_ty_4 = 123;
> +pub const NV_ERR_QUEUE_TASK_SLOT_NOT_AVAILABLE: _bindgen_ty_4 = 124;
> +pub const NV_ERR_KEY_ROTATION_IN_PROGRESS: _bindgen_ty_4 = 125;
> +pub const NV_ERR_TEST_ONLY_CODE_NOT_ENABLED: _bindgen_ty_4 = 126;
> +pub const NV_ERR_SECURE_BOOT_FAILED: _bindgen_ty_4 = 127;
> +pub const NV_ERR_INSUFFICIENT_ZBC_ENTRY: _bindgen_ty_4 = 128;
> +pub const NV_ERR_NVLINK_FABRIC_NOT_READY: _bindgen_ty_4 = 129;
> +pub const NV_ERR_NVLINK_FABRIC_FAILURE: _bindgen_ty_4 = 130;
> +pub const NV_ERR_GPU_MEMORY_ONLINING_FAILURE: _bindgen_ty_4 = 131;
> +pub const NV_ERR_REDUCTION_MANAGER_NOT_AVAILABLE: _bindgen_ty_4 = 132;
> +pub const NV_ERR_RESOURCE_RETIREMENT_ERROR: _bindgen_ty_4 = 134;
> +pub const NV_WARN_HOT_SWITCH: _bindgen_ty_4 = 65537;
> +pub const NV_WARN_INCORRECT_PERFMON_DATA: _bindgen_ty_4 = 65538;
> +pub const NV_WARN_MISMATCHED_SLAVE: _bindgen_ty_4 = 65539;
> +pub const NV_WARN_MISMATCHED_TARGET: _bindgen_ty_4 = 65540;
> +pub const NV_WARN_MORE_PROCESSING_REQUIRED: _bindgen_ty_4 = 65541;
> +pub const NV_WARN_NOTHING_TO_DO: _bindgen_ty_4 = 65542;
> +pub const NV_WARN_NULL_OBJECT: _bindgen_ty_4 = 65543;
> +pub const NV_WARN_OUT_OF_RANGE: _bindgen_ty_4 = 65544;
> +pub type _bindgen_ty_4 = ffi::c_uint;
>  #[repr(C)]
>  #[derive(Debug, Copy, Clone, MaybeZeroable)]
>  pub struct NV2080_CTRL_GPU_GET_GID_INFO_PARAMS {
> 
> -- 
> 2.53.0
> 
