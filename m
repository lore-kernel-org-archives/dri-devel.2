Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203C6C982DE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 03:49:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 36B6910E1B8;
	Mon, 21 Sep 2026 03:49:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="N9usyesI";
	dkim-atps=neutral
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013014.outbound.protection.outlook.com
 [40.93.196.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B3C8410E1B8
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 03:49:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMKi54UfRtyV3F70KtwQgM+/M90MaQCdo3ipiFWeOE8vayt/X2WJDxO9Ce+TRQkCV/NHSr2VxixRTf1cpXV0igP3GG6/qZOAv8pxovFSIKSouCxvCr7I2mOouSTecXEPmc59elVj4uRorTJOBaK+j+2I3G7Ymh70XhNeHfBnrzONIk2fpwckZNF4dEtQTZHNbO48e9kMDuVTVyfirm+xI5Z7XAdzNZTqQhzDkrwBA8bnT67kmlpVZaiav4gCq/Xp4SbveZv4gEBDKVJIrXLSpCOZrCN/f7ACSFTWwOWzerYTD9yrLi4+na36QU9mDywpnKf5C0y8rgOYXftsAN2PUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eJWmTCkrntGjFW3Ic4fja/afXjLTV95OQADUpUAqnI=;
 b=hJ8kXULb3RY19XeRXge4InJyATfTN8DrzK1iXl5MNs81UqWIDaA0hlYaFjptvgyxu6BHLcXT+n3YTQmm1VMFb4MlCfz5YqUjvB+/rlDwccMNGy5Bomqc0y87+MP2YdHYXoKYoL9vv+ovsAqVzu+BZTJQZ/LfciwTo7Ala+Q6sTw76BXmeHhMOV8chdyG4juAaD/w34C1PBNuduV3uN3OuL4KpEGQPVgVm7Yt5KtCUFzST4KjsDgNYe4WFvh4nUig/qa77ZKlWi6IrPZJ/CF0f05UC+zpPtx25J+gcuNis8thcD15VV7iVn5KVz6u+iJR9bd2MAd366qPZcd2P58glw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eJWmTCkrntGjFW3Ic4fja/afXjLTV95OQADUpUAqnI=;
 b=N9usyesIGKeQVqyFYOzCBzwSma9XCxyqIM++kTqjUqotwlRnMFFAQmHiUYvv6uskqbgBm5PBjuKdBqKDvjMFVCA/f/50Sl2iVi649f/LXCSqlARCw7+kvcBxZir5PVKTxTZzFLILD4/3yXio166mWlxglSbosWMr+DaVQAJqgvfL/cG2+byGq7kTDq/C8AFOJ+3wv7pH8uxGD9lzHJriPyLa2f3CpVHhXSkcTm24/6j8MxRjyIZ4//Mg+ZMjegtyxFyBuPM5dchLJOsnncwurgB8SafVOo230DG23KghvVfvYSdHb5DPvCQrHoOCZ0wMxXeWTLTLqSsG8G/92sGY/A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9067.namprd12.prod.outlook.com (2603:10b6:510:1f5::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 03:48:56 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 03:48:56 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
To: dakr@kernel.org, Matteo Kloiber <kernel@matt3o12.de>
Cc: aliceryhl@google.com, ojeda@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 abdiel.janulgue@gmail.com, daniel.almeida@collabora.com, robin.murphy@arm.com,
 a.hindborg@kernel.org, nova-gpu@lists.linux.dev,
 dri-devel@lists.freedesktop.org, driver-core@lists.linux.dev,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260913210828.125655-2-kernel@matt3o12.de>
References: <20260913210828.125655-2-kernel@matt3o12.de>
Subject: Re: [PATCH v2 1/2] gpu: nova-core: declare unlimited DMA max segment
 size
Message-Id: <178996228310.999062.10377951387828615492.b4-ty@b4>
Date: Mon, 21 Sep 2026 12:44:43 +0900
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: OS3P301CA0034.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:604:21e::9) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9067:EE_
X-MS-Office365-Filtering-Correlation-Id: 97456bf0-8d1e-46c4-d94b-08df179342e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|7416014|1800799024|10070799003|376014|6133799003|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: dascAdnAWI+tLznWhgLwYyXNgMZdV3tEEXMJ7EU5qVanlDyhXG945fe1RmoTeCP1lwX3RQzX0g00qeqR2s0TqRlQOGugXlNz8C1DxSZvvR5JSno8bE8/nLBWfqpBMTLwEvh6+305q949JP7PQBx9pXtqboaXw9qveD8fNGsWkeyDi7jfjZlH7Ci69CTqsD+1MTPEGP5DVe/fbKANiNe+XpORZP87JirnJYuPjJo1C2D5/2qZIxtekXLAJDBDGm3Yt69oQkcR3dk0iqhECPqXarNB6C2ULSoS4OWwvUegXVHy4D9Ov1P6dUK6Q6gy7yQ1sfqKKvnGHoINTBTIp3cpmddhRA8MDkL4eAmDER/Lw4ToGe3aC3p8fLM0fJELRDBDqLg5rUNIoBKF7a1uYkvxNzljzbVRrbvZg28MQL0Wl65fiZQdE/o8Kq6In18XALbwvSjB2oMvfnGfqacf9pd+FZgBydQYO+k7D16vPUE2rXK3bRoUhTN/BitQfWahD9DWZskMiSDY/z+HBS7tgrF1uUP/lykzQYBve5idZDmPmWVYOcb4063m4YkubTFzeBwTUHpoglk031YJ8NZ/+8TcXiyDvrsPZC9OGWJl0VRHw/tiF3r8oNiap9pruiFKU/NdOiZwcGXPlkC6Jfg0Sbq1x9PtLd6Kb7m0/navlyA/AbE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(7416014)(1800799024)(10070799003)(376014)(6133799003)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MlhlNkpvaTdvQXZnVjhYMkYxc2JMK0NVRlQvODQ3TmlkcUdDZDJuaitBNVFq?=
 =?utf-8?B?b1RYTDQrYlozSVhHZVp0K0ppVnhlbkYxeXJySXVIajdLSUUrREdmZmhlZW1n?=
 =?utf-8?B?amZzU3NIbDdjOUVBeGhIZ1o4bW9hZDVSSklHREJyVm9GZ25ORTZrRW93TExP?=
 =?utf-8?B?VzFkY241RUIyMlRRSlBONlhVZTI4TWtqaXRueGVOcFRRUGFIc25pbmtxL1Jj?=
 =?utf-8?B?ekczOXZ5T0ttU0hsa3BuOVBlTC8zelZvK1diTGppSTdyV3M3NDZaSDFDWERX?=
 =?utf-8?B?anIvbXJFbmJ5b0lnRTcyajhybVJHbm9QMWpPektPOEFOLzl2dnYzOTNlNU1a?=
 =?utf-8?B?OHkvRzFKYUJLTk42N1hwZHVpN1VMcDRJSC9HN2xVemUrSVZzZW1yOW1LaUJI?=
 =?utf-8?B?T2xwMzIrdHJGSmhoMzUwU0dMSUxWY2dnSzNOdm44RmMwOUtnQVc4N1ZQRGFF?=
 =?utf-8?B?V2ZDeEZROGpRY2w0bDk1MWx3eU5NWnBxRi9PQVN5dXFEZDRLN0dKZHdxNFI0?=
 =?utf-8?B?QkQ0MTNJU0hpTkM4ZTdabFJqbmdmMFBlTGhlQmJ0VCtPSjVVeGVMTnZHcEM4?=
 =?utf-8?B?Wktmb2NhUzdIdUl4L2lVeS96NGJ0TkxYb2M2RUkrcnErMWVJNEZUN3lyb25M?=
 =?utf-8?B?YllITjM5aTRHL2VyM0Qreml4QUQ0eE5KMmUzOTlPc1Q3clZxSGZHd0dCUFJB?=
 =?utf-8?B?cGJoc2h1TmpQWFJFclJ2elQxNENxak82Wm5jRW9Kb25qbjRQbDZQZUtkdEFY?=
 =?utf-8?B?OUxuMlJ5a2xuUFVHOWQvaUFlQjNLVFBWTG9MTUJTaFZWbzhicElOU2hCajNS?=
 =?utf-8?B?UTA1c0JESXV3TndKaDdJOFNIVWJqUk1oTXQyUlpTc3hleXgySitadlh0TTEx?=
 =?utf-8?B?MW53ZEx0MlNZeld1WFRvYjdnUFdWZzB6WkxyNEVjc3IvRUM1Rjc4aCtVeWJn?=
 =?utf-8?B?K1RYRjhMQ3Uzb0kxejJsZkVncEZ1L1VqQ2JxSWVqcWVHSnZnY2ZGOVltWVlj?=
 =?utf-8?B?bUpaODkxZzkwS0V3QTFEL0d6TklhTmR2Mm9lWlFKS0NVZDRSSU1WcHlFNExE?=
 =?utf-8?B?RmhkM2hPZmFkbmwxb3kvMW5ubStCaXdLUU50ZzJyZEtNOWhmazRHRHEzN1Nr?=
 =?utf-8?B?b1lEMTlSQytMUEJrTDlMYTRESTErRFVlbGZYT1k1UjVxZlF0eEErM1M2OUlm?=
 =?utf-8?B?VCtOWXRDb01LeW8wUjU2YTNDMDFCV3MwSHlieXI4elhtMGVBeGd4QmJXYVlT?=
 =?utf-8?B?UklxTTJURkNpeHI2NERSRmxLWTRBdjVzdGdldnk3U0VMa0FrVUE2VnhRSm9u?=
 =?utf-8?B?TGRQTXJTTWFodDduUUdzZFdOSWtkTzlBVFRtKy83cWJJbnRiaVFYSlh0ZGF1?=
 =?utf-8?B?K0cxbjkxbDk4bWFPRFM1OURabGZRNFVXNjVJSU1xWGVHUnBrTlViRUVKWG55?=
 =?utf-8?B?Z3JkWllkZ1BQY1FEVWJ4MjE0b2VJVFhZVTJnTjRKRm1RR0VrRlFtMGZLV21y?=
 =?utf-8?B?MFQ3cWtDUDZmRjJrbnVFVUVFS294UWoxOTVpTitwWldYaHpzU2p3QXhzRlBC?=
 =?utf-8?B?QnhBNjl3TTBjazg5c25vbWxLTkVVQ0MvRFFMSGVMTE95RGdDL1FmdWcreUJw?=
 =?utf-8?B?T3E4aml0Yys5aVh1Um8zeWllaWVheW4xYlZxaWtCOGdMeHp1OGxCMmxpMS9T?=
 =?utf-8?B?ekdYN0RjTWtZZHJGYVRWU1ovM3UrWnJtSUw2V0drSGI0Q295Q2swK2FoNVlk?=
 =?utf-8?B?TlIvZS9JY0IzVEdDTU9sOHJ0YitrT1dzVWZCb2dYd0kwb1JjSVFpbGdWaEt4?=
 =?utf-8?B?R2Zad3NuN3N2WHdIOEQzU0Z6RXUrR3ZQRlg0OHJDZzNFWkkyM2RmOEtFTWlO?=
 =?utf-8?B?MFRlV2tkR2wvL2txUFlZTzZnQUd2dDV6V2JrWWdGNnp2RERQVnVSRlRjVGFH?=
 =?utf-8?B?S044eWFEMENISTJkY3l0dlltY3lJNmxicXJ6UXIyQUVvOXQ1bzd2NUVURURP?=
 =?utf-8?B?eFZzRUxTcmRndk1La2VsNzNSZWFJa0pwNldoaGVrUHZqNGRTWXdObXVEUkxD?=
 =?utf-8?B?YmtSclQyNWxVSDRJWG5BUWlyYldqemtKdUttaFdxMDc0YmVYZjBOZG85NkZs?=
 =?utf-8?B?cGlXVVRpeS9XU0JWVzQ0Njh6N2dYYWlYck9nNEdsdElJVXMxSXh2WDJnWHRF?=
 =?utf-8?B?RHJlOVNaZ2UwSitSNGZORW1ZWHlIZ3o2bnM4bTZXSVliVjJwV051dUswZUwx?=
 =?utf-8?B?a2tPVnVONFVEYjlQQ2UyMFhyeGdSUno2ZFF4aXc1QWJQZVBaT1hLYTc5a0Zl?=
 =?utf-8?B?TUdrdXBOSm0wTmJURk81R2hLVDcwV2diZmc4MWc0SzJ5VE95UEltUmRNVk9x?=
 =?utf-8?Q?PhtJD2zwrmtl4z4cRAM8/6F1bvBMUSUcTcYmWgtGPjvFe?=
X-MS-Exchange-AntiSpam-MessageData-1: Refz71kNDjNlpg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97456bf0-8d1e-46c4-d94b-08df179342e9
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 03:48:56.1525 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKqOw9x6ohJyU/2Xy1qDG/qBgeof2DfiL2ViqRzIdEwAMeD4Z5oDmyfI0CF7LLIb9R10MO4T2Tt+PX5IvIG83g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9067
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

On Sun, 13 Sep 2026 23:08:27 +0200, Matteo Kloiber wrote:
> The PCI default max_seg_size is 64 KiB. nova-core never raises it, so
> mapping the GSP firmware image (~60 MiB) as a scatter-gather table
> triggers a DMA-API debug warning when contiguous pages coalesce into
> segments that exceed the default:
> 
>   DMA-API: nova-core 0000:00:03.0: mapping sg segment longer than
>   device claims to support [len=62914560] [max=65536]
> 
> [...]

Applied to drm-rust-next, thanks and congrats on your first kernel patch! :)

[1/2] gpu: nova-core: declare unlimited DMA max segment size
      commit: 6bd5eaeb9827ca7ba953b68fb27948fdb3e40630

Patch 2 has triggered more discussion as hoped, so let's see where this goes
first.
