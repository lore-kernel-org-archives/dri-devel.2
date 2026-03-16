Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD76F506D2
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 14:03:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAD5710E3CE;
	Mon, 16 Mar 2026 14:03:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="mZcnJdEP";
	dkim-atps=neutral
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020129.outbound.protection.outlook.com [52.101.195.129])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D774410E3CE;
 Mon, 16 Mar 2026 14:02:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=epeyZpezJM9aIOybkzTJnyfn3cJFxTIN2TUc+206gNX9tWn2qSobwjn2CvpY3NGiToRCgslTf3JOA+/r8zDsfAdohJVur0aCSEehHZ2rM9wpTQcqA1UU71GC93MVuqkT+62WRyhpTsW/VVVar7hngYce10mcHNvw3RMbwRqIknyMe7LmYPJtIr6jUmo/TkA+nv7VRDhrCS9GsW1uRlAufp3SIvgh7/S+DGdikyQR0qiaI4QsPHLhLf0+wb2lmZx4nH5/mqnYktoYeSIXcfZ/lYD5e2af51yBr1gQ/gLovDd9BSvrw8oz2KMu0Aq2wsWjybB9hS8lElcuwHUn4/bYJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qwY2wRj4MwU5ZXhJeyHzV7siFWCD4ysu8Ry7xXLJ0b8=;
 b=YeRMVo/iEqZuZ4ZbJ8JMEWwfz3k3MWDHGRjvGgbdDN0LYbikV9T7fsNbcz8iahzPVF4e4xiB/ZVyypXfhznp5T1NBD9vg1wKXTjZxNV76jQX2ksuANOaHdBzJoGp3xk6STso+7L5DbTiG4aFlQj3Jxo3ttLOFlfFN2R/PFBT3fDUIX1Ejnk6wfRThFuCPCvnG+j371nN1SyRcJCTz3yG6VaHzLnvZiw41QdwHOvKT96GNOn3l/yoSyTvheF/ZRGBBSbNhfzYTPMk6v03iAQKiskihC/jt/Ur5BaAVhh065uHbLelFOE6C2a8OzkoKb9cjVY/WCre4cOCMckPSZJrEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qwY2wRj4MwU5ZXhJeyHzV7siFWCD4ysu8Ry7xXLJ0b8=;
 b=mZcnJdEPt+lGM4FmvPbZClmmnvhKdXZMPdGgsL9CvTRE501RUT4EW99Qi0QfD3l8kBuSYtG3p5PR7IkxDxAUAcgGjxGOVt7knF+C2P991R5bFrj49//Wp6tAFV3PUPNhNg3l89Py0Xv7uiutm2USlNeNbR2bP9VGNtiSaPPndYY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO2P265MB3467.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:1b6::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.24; Mon, 16 Mar
 2026 14:02:54 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%5]) with mapi id 15.20.9700.022; Mon, 16 Mar 2026
 14:02:54 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 16 Mar 2026 14:02:53 +0000
Message-Id: <DH49GL8J7NAF.37ZFNZDOEZZQG@garyguo.net>
Cc: <nouveau@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, "Ching-Chun Huang"
 <jserv@ccns.ncku.edu.tw>, "Chia-Ping Tsai" <chia7712@gmail.com>, "Timur
 Tabi" <ttabi@nvidia.com>
Subject: Re: [PATCH v2 1/2] gpu: nova: rename drivers to use kebab-case
 convention
From: "Gary Guo" <gary@garyguo.net>
To: "Cheng-Yang Chou" <yphbchou0911@gmail.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Alexandre Courbot"
 <acourbot@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Gary Guo" <gary@garyguo.net>, "John Hubbard"
 <jhubbard@nvidia.com>
X-Mailer: aerc 0.21.0
References: <20260316120820.2117081-1-yphbchou0911@gmail.com>
 <20260316120820.2117081-2-yphbchou0911@gmail.com>
In-Reply-To: <20260316120820.2117081-2-yphbchou0911@gmail.com>
X-ClientProxiedBy: LO4P265CA0094.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2bc::9) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO2P265MB3467:EE_
X-MS-Office365-Filtering-Correlation-Id: 85d8f36a-a49d-4b29-8913-08de8364b7da
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|376014|7416014|56012099003|18002099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info: RltVC/uCQhT6cE1ka6vk1ZO8wMFkcolKdYxzrAk26vOrod1RfFCmZIM2ZPxtzuYUWsOfCNUrAGw5fSS3PHTmXL0FsXTmxf3TLNbiXbhRj1AnkqYLHFOwvaxYkDyiU8/ynZcS4AoUhLtV3go+141jBmPiK3YYttyc7M6hTTn1nIOtVSdO1gQuZTpeOaHbNsV+yXixRfriKfJCX8rZB84ko5zM0WntMWHb4CFyGzxpnPEtVTesnKsiBmxrHwLctsU0zf6W/GfRbMW4DPYF/DLNWwijs2BhiIHeR0+7f371yvZ+bXiveDAhMDmI4CwsCs+EvOA4ZtOoTdxDfPX/vwWoDxxtcVclgVys9E/ONLd5wzJ04q2rWhBNDgukzocEET0zYQxG8BYu/VKHYjLR3mmKEyX9Kz75ifHk6dLKY0otzSaSa0RPtWK+6G/hSIK59NGsu7ivIXdGXq2QfbYQVhVdQeUNobqslR339lTLhDQwU2kmyko3/lfxWkXoCARLQGy6z+tYFs0gLtqMVy7O/aTlsJENYYAzo/9M1vO7wDJCPbTIX64bOddoCDksNT1RWghToRkgdDAAVtuY0gVyQzoO2LEe7W/rZHAwQwrYpxRl0iSctR5nHsIRf5BzRJzonhHVTFcSCZwF9Rr4jSnGSVeKk8FrqCX+FHxPvX8rVAa/rLFSAf0rPDNRUubvpnhuDgj6tV2pADgboZRTZo0r7NK+gr8hyNdmwu+7rqRSiV2pqUI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(376014)(7416014)(56012099003)(18002099003)(22082099003)(7053199007);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cDl1R2NUYWdYUU5CekdhN1g5RGZjbXI3blIwTTl3aVZta1Jud0NZTVI0MUhn?=
 =?utf-8?B?akV4Qmlqd0NJSE9ObkJNNzdzNzBUMHZnS2t5Ri9UdHVPN05tZmF2UWhiYkR2?=
 =?utf-8?B?ZXpKZC9YQXV4ekMrY29Md1owQTcxUWdRR3Vtdm8xQU0zdmMremRjcmN4elYw?=
 =?utf-8?B?V3E4Y05FSitCa0dmMDUyQkJ0V1FnZ3NLMEZYdVNkU1dSNEx5NjZKc2hOYU8r?=
 =?utf-8?B?ejJ3RU5mUEpVYVpVOW9IQVAzb09rNEF5bDlhN2VMS1BIQiswNEZ4cFBSakdH?=
 =?utf-8?B?UFdEMlRBQ1d5eDVmZWRvVS9CT0ZQaGJjYmIwRUQ0Nm1ka0FxVlN2Z1NKbmZt?=
 =?utf-8?B?eUpEQ3Ntd3JXRWI0cU5VMDdKRTB5a1N0WXZvc0huRWIxd01IM3JMWnRFcWZh?=
 =?utf-8?B?cGNRMlVHblNFSjljYnI0NTVKZ0NOMTJCY1hhZEwzRDlPR1B1dXAzWkZDQ3ox?=
 =?utf-8?B?OXl6TFQrb0VXdDlXSnZSVXFSQnBkQ2RSbWltUmZNMzV5R21KeE5ROFlFcFlV?=
 =?utf-8?B?RlVVTFlSVmZCR2ZnNVIwZmtFRHRCQkw3V25PTEtYcHh6RlBiUmZuSzRvNWRv?=
 =?utf-8?B?Y1F2bjhkNTFNTEtOakxKMkNpTGtFQWRkeUdWWmVxNUM0Y0VpU2RnMUdpNXBF?=
 =?utf-8?B?N0lmN2J0MDZJNWQ5eVVPRnJDTmpuRnFGd1VHUUx0WkRXd0o3RS9sdm5ta0Qw?=
 =?utf-8?B?VVNGeUlNclNNTm4wdUN2VlhCbHpCV3UvOEoxMitrenl2bzNoaElNU3BzbWFh?=
 =?utf-8?B?cDVRVDdjNXpUTGhhN0QyMmNYMmtscWhTNHBGenNBSFVtZ1dLdnZUL1Rsd0h1?=
 =?utf-8?B?dGl4WnJJTHhuWStHSk1Xa1R6R1RPaFJtdjh6TzdmcEJRcUVxeFZ5QStrdkdS?=
 =?utf-8?B?SGhGMXJURkRqbURETUZvMUlkVUpremduVXIzak9rdG9yTlovRldpVDNWMisr?=
 =?utf-8?B?SjBQR3gzZzJkVmp5ZkZwR21HbGFETGIvZGlXYkFNNDh6SkVpbkZxY01XczNo?=
 =?utf-8?B?dU5aUTJXVXZmd2J0dEF0VUM3NXVLMlB4SUxTbm5ieGNXZ3ZQWGNSTFV3M1dt?=
 =?utf-8?B?VjdzbysyV2huVGcwUGhYRnY2ZFkvTVptdjVqcDBPbzJQWjgweU5qNHEwZ3l5?=
 =?utf-8?B?Mk1EL2F4THUzd3ZrNFVoWW4veFV0N3FJZ1FnamxwVXlmbDFoVG9Ga2FwbW8x?=
 =?utf-8?B?Tlk4M0gva2dPU2tFVUJFSTl0L2pYQk5tVjdWVnhURWwrWjdhaS8rNWozNTFz?=
 =?utf-8?B?SlpEWWl3THY5dDNpbDYvUE1RcTFwODNTK3NRaGIrNFM3K2cwTHM1YVNpWjVz?=
 =?utf-8?B?THI2NXQrN3FpVnU1emN3M2tUNkVRL2Q1Y0toUnE2NDR0QUxadjlXRDVTOTRn?=
 =?utf-8?B?bDB2WUYyUzkxYWdRNlpQYlUyWmpOY3NSME80Z3gyWWV0VWQrVUwxcXNKVEhl?=
 =?utf-8?B?QVdKL1NHaC9PVXdzeGxEZXgzNnBHcXZJWEZRcFROMUJtNUNMZ2x0R1kzTk9y?=
 =?utf-8?B?ZW9uQy9Ibkh1NFplMXVOTGFvWFhOd3BKblRsOVBKcWtNaUpJVUFRR0JEbnk3?=
 =?utf-8?B?ZXUxMCsrUUhtMlEzZDQvSWcraWVIaDdTcjVHVzZSaTN6SkxLQktuYXdNdm9H?=
 =?utf-8?B?VnhrMFlvR3pqbGhLeWtPVmhqaHkrRmh1WUJremlHTUZPYXJYVjJNSGtxUUJu?=
 =?utf-8?B?T3Y2TlFLd0psd01rZE5DcG1CQnJkNTZGdjZldVJ3K3BCaG5PUi9TRVZQcGpC?=
 =?utf-8?B?aVE5L2duci9vVnU1REJ6N3FkWWIrbGlPS1pyZk9tN3RmTGFJUFA4M2JyY3Rw?=
 =?utf-8?B?ZzRoOWhnZnFwWTN2dmZkZmNpcitwM3E0NjVBSFRHeE1GQ0JrL2FuTnBGdzhE?=
 =?utf-8?B?Rk9QUnlncC9sWDhKNGdjWFVRNHBoKzlWUXVHUmxwWTV5UmZsamZyKzUvMGxK?=
 =?utf-8?B?ek5kSFgxbE40aTYyTzI2VEdEemRMLzlVRXhsdE5pVml6eHZKTnYreWVXSmtp?=
 =?utf-8?B?aldBRnR3cEZnSkZwejByNWhyVllWb2pvNWRneFA5RXVJcUhvTlUrTmROWFNM?=
 =?utf-8?B?N1VKYjFoek0zNVZIZWhZRXIzaGE1NlppZXdSeEJRNStqdmptMVB6TGtSUUlm?=
 =?utf-8?B?dmhuOUtlNjFKYTYwbTBIc0Z0NUFDckRyMW1kaWFSZFZ1WHBQUHF6ZnpVeVJh?=
 =?utf-8?B?UWc5ME15dHArV3NZTWxoTlNzRzdrZm9aeWFXeFV1UmJPNU1oQmVIQzRHZjJG?=
 =?utf-8?B?TVczQU1DWUdaNGZiMGk5OHZVc1g0dmk5THlCTXVpU2Z3d1B1Y2lSQ0RLVHB2?=
 =?utf-8?B?Z25WWkdoQXV3WDdqSWFMb1B4Y1kzNWNGaGtmQXpYQWFieGx5YWZGdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 85d8f36a-a49d-4b29-8913-08de8364b7da
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 14:02:53.8875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: X/W+xYOM2Bp9y2JL75FedhxEXu+xiyGdl1/OPOGXI3Rnj9x+qFOoo1YDJ4589AcHw3LUSgibUB3woa71mMKL6g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO2P265MB3467
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

On Mon Mar 16, 2026 at 12:08 PM GMT, Cheng-Yang Chou wrote:
> Rename nova-core driver from "NovaCore" to "nova-core" and nova-drm
> driver from "Nova" to "nova-drm" to follow kernel naming conventions
> before these names become UAPI (e.g. exposed via driver_override).
>=20
> Also fix the nova-drm driver description from "Nvidia Graphics" to
> "NVIDIA Graphics and Compute".
>=20
> Link: https://github.com/Rust-for-Linux/linux/issues/1228
> Signed-off-by: Cheng-Yang Chou <yphbchou0911@gmail.com>
> Acked-by: Timur Tabi <ttabi@nvidia.com>

Suggested-by: Gary Guo <gary@garyguo.net>
Reviewed-by: Gary Guo <gary@garyguo.net>

> ---
>  drivers/gpu/drm/nova/driver.rs     | 6 +++---
>  drivers/gpu/drm/nova/nova.rs       | 2 +-
>  drivers/gpu/nova-core/nova_core.rs | 2 +-
>  3 files changed, 5 insertions(+), 5 deletions(-)

