Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63FD4C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 07:21:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DBB910E443;
	Tue,  7 Jul 2026 07:21:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="NiyopKc/";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010029.outbound.protection.outlook.com [52.101.85.29])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BE68810E443
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 07:21:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcPyZRv8Qaq8g+je8e5wEBU4gFzp+R/2beLAlZlmuAqp5H82AdRrWF97aeYK2biCmkq+hXuCux79m0MGZoFt0aKmc9o3pgh9hSa6MxYCCMNCzgFw+a/1dScRCuVw1ox6dtCztMMPF/L2TUgism6P2fLAWtm1Wme9iJMC8CcHZl+XzhaZzXf0RAen3pM+8U6cFKqGyd8m5/wowpEjAmETQFxjMrKcbkX4FOydAl18DjzmramqGrkDHYl1B0rRoxe3JFGkPWr8BkIpIJaDvqiTOW9GyHXc8QWEUiNKPVux5TSosCvKNRABGXyRfDsGMPrHICp+sClYh+9BSN+u5TxMFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GtYqRsct2qHhHg9VzrPZpKyLMX+3xvHbHt0UGD9q2L8=;
 b=ZhOTct9eRnogcqeYcdVYU4yxLsodJQq/RF15cStkmQJr2bYuvFIZRy0gTD2N9OqKpmTmnrawh+6wAf1qcncZQ0k7Fr02x2bPAF2zmKFBYcy7x9aa3+15FnkxEMss0TPGe+udlrw/rTyGvQrNwFPWxH+7uM6E6KNiT79PFwZL6aPHitAvMjTmZ8JZ2rw9PHig5qporW99b7M120L1Qzu0Uu7zXpPzvJHFuf/vvralaC+nPe04DMvQOFJCdA2pX7yhS/EX6ighKXsNrcTZG8REQHtGe/IqxzKkYg3mA4J6ujpNW5QdgtF6Xzn1BsmXMrww1soDUAeFe+BiTzi19hHD5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GtYqRsct2qHhHg9VzrPZpKyLMX+3xvHbHt0UGD9q2L8=;
 b=NiyopKc/wUWL1g04Bq9LLe8IDumLSztlHTfuRG1LQLWBZpPvalxFpPUz3CNC4ay7nxBpSE3+6HFdDlqYQXD5Qoqy1g1BOCDScFEl5lu7l5pi/mz/EW9F3ZPBMokqmbI9LbJDh04SMY57LXHYD9x03rJsEkmtTJpOJyrQmFKsgAI9hTJyHsVS7oPi1vKIHjc4zzNuZ/12IXsgYItBckure6gB+0OgsP9ctUdHAvkMUPcAbIGy1zH1xrb+x8RMWMKTLZvNmcOAXNihf1mMsfFFgebOVPdFHiqqJ4ekrl3fJB0mvwQDSydAf7pgIhutYicYnWHqvMc+HresbFt44Z2BFQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB6604.namprd12.prod.outlook.com (2603:10b6:208:3a0::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 7 Jul 2026
 07:21:50 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0181.012; Tue, 7 Jul 2026
 07:21:49 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v5 00/13] gpu: nova-core: consolidate and streamline GSP
 boot process
Date: Tue, 07 Jul 2026 16:21:33 +0900
Message-Id: <20260707-nova-bootcontext-v5-0-ecad9346387f@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/4XOwU4DIRAG4FdpOIuBWcDFk+/R9MAysxYTQYGSm
 mbfXbaaWNNGj/9k5pv/xArlQIU9bk4sUwslpNiDvtswv3fxmXjAnhkIMMJIy2Nqjk8pVZ9ipWP
 lSkg0UjzQOE+sn71lmsPxTG53X7kcphfydXW+NzK9H/qv+rO2D6Wm/HEu0uQ6/eNnk1xwpaUdP
 AoHpJ9iCxjcvU+vbNUaXAgANwTogkAkN3thZo1XwnAp3OowdAGMn8ASjUh0Jaj/BNUFrQeLozJ
 WW/FLWJblE1TWvJeeAQAA
X-Change-ID: 20260619-nova-bootcontext-401d6107e8fb
To: Danilo Krummrich <dakr@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Gary Guo <gary@garyguo.net>, John Hubbard <jhubbard@nvidia.com>, 
 Alistair Popple <apopple@nvidia.com>, Timur Tabi <ttabi@nvidia.com>, 
 Eliot Courtney <ecourtney@nvidia.com>, Zhi Wang <zhiw@nvidia.com>
Cc: nova-gpu@lists.linux.dev, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
 Alexandre Courbot <acourbot@nvidia.com>
X-Mailer: b4 0.15.2
X-ClientProxiedBy: TYCP301CA0078.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7b::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB6604:EE_
X-MS-Office365-Filtering-Correlation-Id: 71263ff2-abda-4321-b20f-08dedbf8690a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|10070799003|18002099003|921020|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: S0W9w9KL9e5ND/V1COOQwKyheTXkDkNFdU58is0byhOT9Y8HCJ5OcWi+ghF6SSw0iFaU3PzYN25aYSIkbxmJIfVxrfbCZ3Pwc4YdyRvxP0FLhBvrJITsBHwou52RlX+GomiWx9rMTKNCyQrjxoYjvpxkBmm11WthaeY3x3W7XjskW/g6tdccdv9wdDieW++GaINATp5RyDHBN8Fa6nv58XqIlwA3ikWX8WpQJc9rVqBXpDl3dM1MmzHTI+8ESYP7oPWL8ym0m0YP8pU//+lAvz7A996sh75BrGVTldxRJghUe0+LIkIXtI4cI2/DY4GFQGUaIAmx+Q0HTvfeq/h7NRZoQS9FKG2L3QgvUSMaURmP+g3mO9V/8gMIqfdwrUuW94W3IxgHY+dhoBwTP89EjS9E1gN5s8YJnH1sb76qLCv7pYJOi/m6HrIPTgM3ezo87n1SXgkMwubbzfzuz0BuvDwLXZt/I3dexcwZM+/fn2mEl73AWkq5ABZZhfijV8w0JOjC1u5ysyPIhKVbWxjLolrT7XrzFpjFjBcIagePPh12wOEY8dAAVFb4ZIdOKu1Rm7sWWq5STBgyhQCPyGkdrFTheIx6VHRqDK66r8oxtyJlCy6kRn2iXxhTxYRnd2x6jZ1iGxpiukmo620ZKlLdnw1o+uu3U+5cytHyCIEW+bl6otfN1/rUhxFSSX0IS8vsuDcgF3EB2X0LzNedPosn/A==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(10070799003)(18002099003)(921020)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ris4OC9hblMyKzlEOG82L0ZoazR5REg0UEZLdjJoMnpDWVNabmZkUU1YNDBt?=
 =?utf-8?B?MHA5OHVPNUNPNDVJRWJ1S3FmR3k4WXJSUnBGY1FxNjNpVFRNNWlwZjFyQ1R4?=
 =?utf-8?B?d2xvSmh3Rk5MNmIxQkpmVGVnRGNnWjU1RDBtaWFvS1QrNHpKeHREOVh6NGpq?=
 =?utf-8?B?SjJ1Ynk5YkQrTlNxa283UDY3Z3lKY1NhUWtTdU5ZZXhXVURzdDFOc0psbmhq?=
 =?utf-8?B?bjNwM29wTDliZVdNYXdhR1VoQk9oRFZicjVqUWRER3Q2VC9BRFRCUk5PSXdI?=
 =?utf-8?B?UW0vOXlVa3FhSGU3d1dUMCtTbXM5Zlp3MGs5bWl3ck90dy8xTWRRQWYzakto?=
 =?utf-8?B?WElHNTVWUTVpTS9PT1ROMkI5Wnc4Zy9oYkxTbktUbkVzVUI0ZlJVQ2dTaHJ4?=
 =?utf-8?B?YnVkcUN2eXNwYXN4T29JRVNCU2FTcThNRUVGTTFyTElhOFZaMHplbEdaNDJI?=
 =?utf-8?B?eUQwbUdpQmpST2Rna0NYaHZ6ZGYxQ1FKMVZ5clVIbDZENS8yVUdRcE9JL3dp?=
 =?utf-8?B?U0xtR3lIWjRKUEtYSDBlWDFvS2E2bWlmME1hYVg1dWZpQ0twNzJDcFp4N243?=
 =?utf-8?B?eFAwY3ZMdmZrYWFJcVp4Z0h1SHBPNnlienJaNWdZYmp1ZlJIZ1RxVWxtdFhB?=
 =?utf-8?B?RldBYjdIdVRTU1NKWi9ubElDZkhUblArbDIzdjN4UVE1NjVJSTA1ZEJhMTAr?=
 =?utf-8?B?WlU2TXl5Z0ZMQ2dOQmRRSGtBakMwMGx1ekZpWWRmTHRsVzlHN0YzTU9Oei9l?=
 =?utf-8?B?LzFpamFhUlhIbjU3S244Y1BSSTNad042WUV2Qy8xb01BN0xXdmYyc24xQUtK?=
 =?utf-8?B?UlFoUmdUTDNzbXBmRHFYU3EwSzZQb0tyUTBqbko5SXB5K0N2OUMvcVdhV002?=
 =?utf-8?B?bnJwcWJ4SEJmRHN6SzdUbG1icy9la1Z4cklHUEhCdnlFaWlxekVUYkdTaHQ0?=
 =?utf-8?B?aW9pWmUvcG90b01tYTRDSkZPbDg5NFJnN01GUEc0YWJma3REM3VtSW1IK1hj?=
 =?utf-8?B?OW9MeDM2Z2lwQXBJbS9aNXZIUDBZbmlpMVVBbkVxM1JXdXdSTTlDOWxjTHRB?=
 =?utf-8?B?ODdVY2M0SDJlU3lQMzhJQkwzdHM2TDZMejVueGVwQklqYzBlVldZcVBjcWpj?=
 =?utf-8?B?d2tkQmFuRWpCVXB3UFBVREFDREp3dVlBSjNiS3JlbXQ3MXE1S1FnNEJIengr?=
 =?utf-8?B?M0hCSDZUcDFFcytBTWZhR2VGS0NSbzEzNGYrMlJOb3liNWdhL2JZalVKdlh5?=
 =?utf-8?B?ZXRoREo1WFNkNmhKd3B0RjNyYWhERjhzSVVtQVZxK0lPK09BdjlyWXNoNUc0?=
 =?utf-8?B?R0V0U3h3ZVlSRk1zRzI2MzNDSlJsUFhXc1RKOHNHRnE3Z0wwbHFNQTFkeVNq?=
 =?utf-8?B?b3hHZm91WldZUGUzWk9PeHg0YkJCc0lEaWlqN1ZpQ0ZoT1NBbEg3WVBJamJq?=
 =?utf-8?B?ZDNFNHlvWG5pRUVORUEzK21VNFFCbFhUY3VNaThsUDhnNmpDcklkTzVtTytF?=
 =?utf-8?B?RWVuRDdVTlFzSjhzSUJWSlR3RU9oUkdsUU5vbFE5Z096Sm5xMEpQZDZKV2hO?=
 =?utf-8?B?L1NoWTVBQ1dsaTlFZGpDNDR6K25nSGVQOGxWRlZibGJuaElkclloRTQ5blFw?=
 =?utf-8?B?bVFVd3pYNHJoVVg4OURqUEJ2S29FTmhwWC82Ry9RUHRFbXdoTDVYTkxQRUlB?=
 =?utf-8?B?MVdzZnYzOFAvcWFGNUJVL3ZmMTd5ZlltT0pEclpadWdFVzFxSlBibHhaeGlm?=
 =?utf-8?B?M2NvZzNOZndiUzdPWXROOU1uL3NLODdqY1FrMTRwQ0pWK3l3WndRVDBKVW8x?=
 =?utf-8?B?bGhrYkdXOTdDTEJIajhYUTVaL1RwdzZVbys1T0hKMmt5ekxxSThleHJoUkw5?=
 =?utf-8?B?aXRScGVGYzBlaEtLNHdsNm8zSmZKUzVmTGlVTllIVmlsRVcyb2NabEYrK0Zp?=
 =?utf-8?B?US8vMWdBdmk0bkNWVUVMMTBXNnRMQ1FKZnZ2anBvRXh6ODJRWlhiYTBOQXhu?=
 =?utf-8?B?OFN4cUNLV3RKS2MvdEJTU3NSQTZhaXlYWEF3ckVSSHc2WmxhVExYZEN1MjZt?=
 =?utf-8?B?R2NaM2k3VEN3QW1VV0J6M3BqZ3QxQUEvaHliSVlHT2JDNm96TEtLWGM2VWh3?=
 =?utf-8?B?ZGdtOXFOdGthTTRjcTJXenpRYm1seGZrVVdBdEFxSlFGeEVhdUdYdThaRkxI?=
 =?utf-8?B?eXlBS20vcWdjVHBuOCt4SnRhK3RtaXZLaUV4WVhWeDRRZThUelh0YWtDTHVN?=
 =?utf-8?B?ajF4RHlMVW5EdTFySmZZRVllajRTNmYwRkNpRzYzbTNlZnRrUXFjUjQ2cExs?=
 =?utf-8?B?WE84RXNybUlqL0pkamgvK3VscHQ0V2F3RVE2Q1A1K0VlVzJ0emttNUVYVDN6?=
 =?utf-8?Q?8G+oeRlfMKBaFjA5keKzcMS3cMXaWeqIb2w/tz81xUGFA?=
X-MS-Exchange-AntiSpam-MessageData-1: HSe+cEfV083heQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 71263ff2-abda-4321-b20f-08dedbf8690a
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 07:21:49.6875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BN6o5KTCxAmkgCjark5QdXPljT6qhSSCqhx43LXKZ0TUkWtGvjZ9IdFG8CW7O9NUnWxO3qd1DhhY8kptpZNRyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6604
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
it is only needed a single time in `Gsp::boot`, and is inadequate for
handling errors occurring in HALs.

Based on Eliot's feedback on v4, the series then removes the last
remnants of the boot procedure leaking outside of the HALs, and
consolidates everything within the GSP and FSP HALs.

This series applies on the latest `drm-rust-next`.

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
Changes in v5:
- Make GH100's HAL wait on both GSP lockdown release and GSP RISC-V halt
  in case of error.
- Drop `GspBootMethod` and use HAL abstractions to cover differences in
  boot procedures. (thanks Eliot!)
- Stylistic improvement in TU102 HAL.
- Convert more pdev -> dev in `gpu.rs`.
- Link to v4: https://patch.msgid.link/20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com

Changes in v4:
- Rebase on top of latest `drm-rust-next`.
- Add preparatory patch to separate the different lifetimes at play in
  `GspBootContext`.
- Link to v3: https://patch.msgid.link/20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com

Changes in v3:
- Drop the preparatory closure-only patch.
- Use ScopeGuard for GSP boot-error cleanup.
- Keep TU102 boot-error cleanup local to the HAL.
- Avoid spurious unload-bundle warnings on early failures.
- Keep GH100 FMC boot arguments alive through lockdown release.
- Link to v2: https://patch.msgid.link/20260622-nova-bootcontext-v2-0-0ddeafc06f5d@nvidia.com

Changes in v2:
- Replace nonexistent `ENODATA` with the more appropriate `EAGAIN`.
- Add patches introducing `GspBootMethod`.
- Add patches moving `Fsp` to `Gpu`.
- Link to v1: https://patch.msgid.link/20260619-nova-bootcontext-v1-0-45193cd0a2e5@nvidia.com

---
Alexandre Courbot (12):
      gpu: nova-core: gsp: sequencer: use GspBootContext
      gpu: nova-core: gsp: sequencer: do not store sequence into GspSequencer
      gpu: nova-core: gsp: replace BootUnloadGuard with local handlers
      gpu: nova-core: gsp: pass GspBootContext to unload methods
      gpu: nova-core: gsp: centralize missing unload bundle warnings
      gpu: nova-core: gsp: fold TU102 unload bundle construction into HAL method
      gpu: nova-core: gsp: turn FWSEC execution into HAL method
      gpu: nova-core: gsp: make use of FWSEC bootloader a property of the TU102 HAL
      gpu: nova-core: avoid repeated calls to pci::Device::as_ref
      gpu: nova-core: gsp: pass GspBootContext mutably
      gpu: nova-core: gsp: separate context and GPU lifetimes in GspBootContext
      gpu: nova-core: store Fsp instance in Gpu

Eliot Courtney (1):
      gpu: nova-core: move GSP firmware files decision to GSP HAL

 drivers/gpu/nova-core/firmware.rs       |  25 ++-
 drivers/gpu/nova-core/firmware/fwsec.rs |   5 +-
 drivers/gpu/nova-core/fsp.rs            |  21 +-
 drivers/gpu/nova-core/gpu.rs            |  68 ++++---
 drivers/gpu/nova-core/gsp.rs            |  22 ++-
 drivers/gpu/nova-core/gsp/boot.rs       |  99 +++-------
 drivers/gpu/nova-core/gsp/hal.rs        |  59 +++---
 drivers/gpu/nova-core/gsp/hal/ga102.rs  |  14 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs  |  54 +++---
 drivers/gpu/nova-core/gsp/hal/tu102.rs  | 330 ++++++++++++++++----------------
 drivers/gpu/nova-core/gsp/sequencer.rs  |  71 +++----
 11 files changed, 375 insertions(+), 393 deletions(-)
---
base-commit: 78900738d981c97aad929e33620340d0d9bcfc82
change-id: 20260619-nova-bootcontext-401d6107e8fb

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

