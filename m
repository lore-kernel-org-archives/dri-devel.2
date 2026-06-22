Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0414ACDB46B
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 07:10:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6A82C10E4AD;
	Mon, 22 Jun 2026 07:10:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="PJAEg/32";
	dkim-atps=neutral
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010003.outbound.protection.outlook.com
 [40.93.198.3])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9FFD10E4AD
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 07:10:46 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TQQphavYEPiSN77A7BiIMptUQymwkboqvE2va1Ct8SrP732fsXCwvY19V4adiPKg7GnpiP89KFsL7G5bd6MSFICGy8XLLEfrg82EkZGbcJn+QG8Z+qML5q1baBHAQyAGyMhfWwLZKWiMaOYk4gLLtnnvuCOB4phi2tUL2VO+bKkMfghHMeCfYXXCvsz5t45ipzF+Qt4d0l6W6E5e4yoAdFqAr6zHIkMs4l5Q5mq4FkEQt6i4SBU5ddeJbxf+DLDwnMxSMGIeT2zmHMNZh6vfVrUpGY69xdyJexRQygXncWbfgyvmh738k8mLNPLtDxnrYMKugRF4w8PAqvJJbcEJ6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Eny1ggdGwUcd6SYYimi0tlrMqfa06G2GNj2E5FLlOSY=;
 b=K3R0oLKvhJKlN0HvuShAJ5LGeD1ysq8rJukIW5pRho3G9PEivRkjEGQkrlOnkq1Zqk8f8dMXPA/Efe071ZAG77owOaemJFql36ArnbajX5m/uvUiWWUgQfR4ucEp7dkRIPRcq888fs6MMzN7y6n3f9pR2FMnqxXae6OjFa5R2V51vRNXyMvmgEbgW5kbiAzrh2rUKKrC3MUhyCAC0jSK7RfAFIDA9HJP9QmxFhugajKKKfxDgQwu/c/GunX2c1ZCvQgc/XzZ4nW+CIzpqXNW9rYm6MU1B88aJI+k9XUzOY+GUS0iIL/s+MhYoCl0FFsLQB8nX/flYsJH7HxPpsOtRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Eny1ggdGwUcd6SYYimi0tlrMqfa06G2GNj2E5FLlOSY=;
 b=PJAEg/322/f8Y8DXN8B6RznjcgSrEynoZYplHu2UKFJgkWJ/1S/1Dag9S25Vuupp6QifVO2CtlcKhBXVieysknQkZpoeJjA7qQfDk1qdNtI71CUOwiC96hl8zLLzNix6ludDBt20cyaxWg11HTBXHaWsQP/TKqfLq2NQ+en5FYXQn65Kc6SkHen+nUz+BsizZpTIniOk2dOrf4lqbeMmfy4lgmp90+RshHqfB/STLMqsXgqkWdirxAwh3RUPt+G57BR2SW37u54+HZE1tuczbjdwdCNXmORYuZJ7oRHyX84mLQxf/1kToDpu8oH9pqa21Wy/J3QimqItLjMGPVLgVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3997.namprd12.prod.outlook.com (2603:10b6:208:161::11)
 by PH8PR12MB6700.namprd12.prod.outlook.com (2603:10b6:510:1cf::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.18; Mon, 22 Jun
 2026 07:10:40 +0000
Received: from MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf]) by MN2PR12MB3997.namprd12.prod.outlook.com
 ([fe80::73c6:e479:9b75:b2cf%6]) with mapi id 15.21.0139.018; Mon, 22 Jun 2026
 07:10:40 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v2 00/13] gpu: nova-core: consolidate and streamline GSP
 boot process
Date: Mon, 22 Jun 2026 16:10:22 +0900
Message-Id: <20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Oyw6CMBBFf4XM2pq2Aj5W/odhUdpBxsRW29JgC
 P9uQRN3Ls/NfU0Q0BMGOBUTeEwUyNkMclOA7pW9IiOTGSSXNa/FkVmXFGudi9rZiGNkJRemFny
 Ph66FHHt47GhcKy/Nh8PQ3lDHpefr8Pgc8lb82XoK0fnXeiSJRf2zmQTjrKzEcacNVxKrs01kS
 G21u0Mzz/Mb4zR/vdgAAAA=
X-Change-ID: 20260619-nova-bootcontext-401d6107e8fb
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>
Cc: John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>, 
 nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYWPR01CA0007.jpnprd01.prod.outlook.com
 (2603:1096:400:a9::12) To BY5PR12MB3986.namprd12.prod.outlook.com
 (2603:10b6:a03:195::27)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR12MB3997:EE_|PH8PR12MB6700:EE_
X-MS-Office365-Filtering-Correlation-Id: 53a1a58e-51a2-4e15-bb69-08ded02d5d06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|10070799003|18002099003|11063799006|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info: 2pLn3O9tGVUvfxuRKlBAPKF4FwQOJkL/3/i/qtlrFb1djxjy/e1u8lV4KRhAngWxgNePe6JqM/QKuAIJ4Tb/P0OI2laV3rKc9zLzMMASNia5zi4AvBTb4bgkqjvvMps8C65jyd+G7bQCen0OGF3bBYfio2v/JjUcOPjJLsU51JatYIpITBq5AKO9KB7XnxNcrn9RH80MrsfFE3j2s/1VS3Kk6Emrx1lu+CHVI6vo/N08DO45cSiinKQElaU3oS6gycYx1GkGxAiWKOWFlTN5ZYhzRawMLTIacpNHSepK+XLippfLnrgpc9hWyelwVvEVAbYGz0Z15xg1BVhivIagbNzvEmsMw8r3vmoFid8zVz3gh12XTFCisJ1JxUEQO+LKHfHQDYgB114090sYtySP3RBd0eQEAj6TF/OJKCZN4io9Byub9HjDjAbCuq+q5wNN1L3nLd0PNOHni70e1hQrvBQy34QM4NRZ5vb7l/uGMiVoBTlx947C3QyTzHk8/TsMzaPva7p2dzCnXJ2/hkHMFSCBGAWEmHYttjzFmDvw95JDmV2KMQ8T+66dCnW1eIZmR7bw4hh7a/wWPY8+59bacR+Aa+C7IjnNsOMg7GNkob9Lsriw/CfOj14a0TqAvpJUdL9USbP0M669EdMT8ucEiRNvN4ItUEGBV8hS3tpE4Ms=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN2PR12MB3997.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(10070799003)(18002099003)(11063799006)(6133799003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aWlMbUJPbEgyV1lmMkJ2VGdjc1FabW1NakRXU0tLN0FXdy90SjZkMFBiUUNC?=
 =?utf-8?B?V05FcUJZSFNTd1hkN1Y1eitnQktLUzh5aGRYOXczaTVpZ1FoQXdZTXd5M202?=
 =?utf-8?B?eHFqQVovUFFWT2N4NWZZdmkrMmtYVTU3VXR1Zkt6OVZZY1pWdmk1b09VQS8w?=
 =?utf-8?B?NlA0RzRyOFp0eDVIbjNmL1pLRVd1Tlh2UlhyWHlrTkF6SVNZVEp0SFgrY0tn?=
 =?utf-8?B?cFpKZzNTTGF4SmQzeVV4ZnJ4YzZZbmpjNG1tRUpPQWhWSlM0UEo2eWpCSjdn?=
 =?utf-8?B?V3NyNHFIZGkvTW9FSExMYnRDRkN0L01GNDFxT2ZVRTdqaTRhT3JLOC9LcDlm?=
 =?utf-8?B?QXFjQ3ZLb3VGbWhBcmtGMVdtb3ZZZW1xdGNhWEwyY3d0ZW1YNFJzMTFHTU4y?=
 =?utf-8?B?dTZCTkhXa0dFQnRZSi90VFZpQStJdmsyN1NvLzZnQ29HQnlGZHlRTzRqMTll?=
 =?utf-8?B?ZFlEWW1iTzhsejF5UUtmcCtFdGNCcWpNL0lBSkgraTd0TWRlY0U5ZWJhT1NF?=
 =?utf-8?B?VmNxZHpFbHl4ankrQ2xkUkdSU1Boakk3MmtOdisrUkMrV05zWW1VUGJlbHN6?=
 =?utf-8?B?RCt5bG1Vdk80SE9HOURqK2xCQlZheVA5M2RtbHhlU1F0S2hpTTlWWjBqQnBX?=
 =?utf-8?B?MFBvTWZGWHg2UE10UkhuVFRiODdVTWN2UHdxa05sUFIvTEJHZnE3UTl6c3ow?=
 =?utf-8?B?TWJzc08zWlhQZ0dOOWxpMk1yYlF5akdjVzlYQ3B1RHl1UnZyLysyb3lsV1Bj?=
 =?utf-8?B?ME9VSzhIRFBaNDdXWFVrS2dXeWp0Q01KWUQxUHA5Lzg0K0t6dGZoVkJFaTU3?=
 =?utf-8?B?SUtNVzk3Y2F6YUZFdlNlUFY3RFJyZWlNQndaUVIrVVh3OWoxb2VmOGtubWtk?=
 =?utf-8?B?U1I1anpxV2x0YUwvNVFOblJYcUU0Yzg3bmFvL1ZvTldoSjJ0eXBGM0pjcktM?=
 =?utf-8?B?MitBckw5aFZmZ2RqN0VyVkNjcWFsUmtQS1FlL2xXdEZibTFib01ML2pLRkdl?=
 =?utf-8?B?OXVGT0RmNTVnakU1OXdYbkMwTlVHSFIrTjBIT3R4dUw4RXZBR21xWEZVMEo0?=
 =?utf-8?B?ZXMvcUJCcGFvR1k1RGRWK01MSmROUFFDcHJLbzJVTHJGZEhMYzAzdjdxSVFZ?=
 =?utf-8?B?UFVCWWI0VUtVcGkwaWpQcTZKeVdNQTdKejNZY2RwTXczL1RTWmRTb1d0MXd0?=
 =?utf-8?B?QWNzYWpaMEZNdGRUam55ZDgwUWY3M2JvYmVpZUJ1alhVMWt3Q0UrSGNUSnFm?=
 =?utf-8?B?QVFoOWdVczJHK0dzcGcyQi9ONmlVa2t4eUNISWt1K3J1MzBqNTNSNEs2VUFF?=
 =?utf-8?B?YUx4aC8vTVZaRXUyaTJ3Z3ptQ2RiUWwvTlRMZUtGZnczcmtoZ25PZWJFNEtS?=
 =?utf-8?B?SHlyUC80R2VIMHZHc1hHdWhmeEZzTXZ3eW1STXNwODVjUDNsZUkvaVpHMWNO?=
 =?utf-8?B?ZkxtSk5WQ3hlMVRNOENuMTRKMm5CL0dkU1NOaVpuakpzUDQwa1JhRHZvWWVQ?=
 =?utf-8?B?aXN0Sld3bzR1end3QkZWV0JlU08zeUd0aXMrcFErL2VCMUNoYlpML2tPNjA3?=
 =?utf-8?B?MTBqMDhXb3lubkJvVGJkSVZkTk1kbVZ4eTVSTVJ5RXRvNHp2aEowYVJCZHYw?=
 =?utf-8?B?c2dkSmpnTnoxbjVYVVBBeFM0anNLVnNHd05KUnorbVRoTDVwSjJBUFNybU5l?=
 =?utf-8?B?eDBLWDNnU2FvT2VjQkYvV29GZ2FPYlpxOEQ0OGsrR3ZGb2J3b0w3Ym43cjEx?=
 =?utf-8?B?bjVLVk1aMzdMNUJBaE5Qc1YwNWtMcUZ4bjhlbkZWUWpsTzZsQzZOL3Y1RGhH?=
 =?utf-8?B?cmhUMEhyRWpvaXRoNXFyZ0d5cDJBMDNEeFpFbEhuaGI2TWZnVW5aay91Z01s?=
 =?utf-8?B?eUhPREVJN2gyWkJEVUR4YmVaWkVoVjRtVGFid2tVZHR3ZzJwU2JVZU5zMFQv?=
 =?utf-8?B?U3QwSlQ2elVONFkyeXZKYThnZHp5UHIrZWVGSE9ETnpnR0d6dmV1bmd3QTVD?=
 =?utf-8?B?QVBoM3pidllPSjllNXdXV3J3elZ2NVRQS2pUQWFwMVhWYXZTV3M1a2F3NHI2?=
 =?utf-8?B?K1hnVmpVTjVkZ2o1QzA2UXVoZy81ckdvZnJOQlJUWTduN21WYVA2ZDlRYXRQ?=
 =?utf-8?B?KzJ3Rk5xTkNKdU9MTVhDcnY1SFFIRjR5aUMzOFgxL3MvZTVoaDhPdm03Qmxn?=
 =?utf-8?B?b1RVbXBaMmRKNWJTRUhWMDlIbDU4TUNJRWlKWmN2QUhBRlVHVFpsYXJ1MU5C?=
 =?utf-8?B?N2NHL1J3dVVmNFI5WUI0b0pBQ0xxZHhCMnlTL3J1eG50UjBkU0N4SE56YXlv?=
 =?utf-8?B?bHVWemora0dCVWU2em1LZnB5L1dKVW1kZGl0SVVWWldzaHMvRDkrZCt4UG9M?=
 =?utf-8?Q?QLIxTx9L4Mn+7l4xd9pxP/sSVpE610A5aWAX2hhw1zy57?=
X-MS-Exchange-AntiSpam-MessageData-1: G6V9IbauG8nLSQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 53a1a58e-51a2-4e15-bb69-08ded02d5d06
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB3986.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:10:40.4433 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bMyClYt2G0JFEgP1sqotVn2D751RMHJSMukQdUsHv1bvGav37JqqJxJRg0x5Vc29mY7Fflm81eJ/SU3PsbvX1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6700
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

The recently introduced `GspBootContext` is useful in at least two
other places:

- As a replacement for the sequencer's `GspSequencerParams`,
- As the main parameter of `Gsp::unload`, for symmetry with `Gsp::boot`.

This symmetry can be further exploited to make `Gsp::boot` and
`Gsp::unload` generic over the exact boot context required for the
current chip. Doing so requires some more preliminary work that goes
beyond this series, but this groundwork is needed regardless.

Another cleanup that can be performed as a consequence is the removal of
the `BootUnloadGuard`. This type is cumbersome as it holds extra
references to the boot context, making it difficult to make some of
these references mutable (as we want to do with the `Falcon`s that
should require exclusive access to load and run firmware). Furthermore,
it is only needed a single time in `Gsp::boot`.

By running the boot process in a local closure, we can catch errors and
call `Gsp::unload` on the unload bundle just as efficiently, and with
less code.

Building on this, the series also introduces a proper type for
identifying the GSP boot method, and moves the `Fsp` instance to `Gpu`
to make it available outside of the GSP boot process. This will be
notably useful for vGPU support [1].

This series applies on `drm-rust-next`.

[1] https://lore.kernel.org/all/DJAZRULU1QHZ.2NSTR1ZPOQUSN@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v2:
- Replace nonexistent `ENODATA` with the more appropriate `EAGAIN`.
- Add patches introducing `GspBootMethod`.
- Add patches moving `Fsp` to `Gpu`.
- Link to v1: https://patch.msgid.link/20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com

---
Alexandre Courbot (13):
      gpu: nova-core: gsp: sequencer: use GspBootContext
      gpu: nova-core: gsp: sequencer: do not store sequence into GspSequencer
      gpu: nova-core: gsp: move boot code into local closure
      gpu: nova-core: gsp: replace BootUnloadGuard with local handler
      gpu: nova-core: gsp: move unload bundle error handling to Gsp::boot
      gpu: nova-core: gsp: make unload take GspBootContext
      gpu: nova-core: gsp: fold TU102 unload bundle construction into HAL method
      gpu: nova-core: gsp: turn FWSEC execution into HAL method
      gpu: nova-core: gsp: make use of FWSEC bootloader a property of the TU102 HAL
      gpu: nova-core: introduce GspBootMethod
      gpu: nova-core: avoid repeated calls to pci::Device::as_ref
      gpu: nova-core: gsp: pass GspBootContext mutably
      gpu: nova-core: store Fsp instance in Gpu

 drivers/gpu/nova-core/firmware.rs       |  25 ++-
 drivers/gpu/nova-core/firmware/fwsec.rs |   5 +-
 drivers/gpu/nova-core/gpu.rs            |  68 +++---
 drivers/gpu/nova-core/gsp.rs            |  44 +++-
 drivers/gpu/nova-core/gsp/boot.rs       | 142 +++++-------
 drivers/gpu/nova-core/gsp/hal.rs        |  63 +++---
 drivers/gpu/nova-core/gsp/hal/ga102.rs  |  14 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs  |  62 +++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs  | 385 +++++++++++++++-----------------
 drivers/gpu/nova-core/gsp/sequencer.rs  |  71 +++---
 10 files changed, 436 insertions(+), 443 deletions(-)
---
base-commit: f0c1bb8ead8a9790e7d0339354598b50a9c6789a
change-id: 20260619-nova-bootcontext-401d6107e8fb

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

