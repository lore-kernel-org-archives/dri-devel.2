Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D869C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 12:32:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98B3210E85C;
	Mon, 29 Jun 2026 12:32:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="SfT0z10s";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010021.outbound.protection.outlook.com [52.101.46.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 739E710E85C
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 12:32:02 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zA4mmfCiY2kNrGjc8Y53/uD+DFYcHLpJXAbQc+0njA1UZVOM6TfKbweteBQ5gMfXXj2y8A6JZ9J47mX0R6pGWKHGwbR/fdM7rCbuWk0W+vAET+cDgRg8QNLgVb6UHrDDFddeO1iOe31HqQqPedjOe8x3coUVGEbRFjRqbx0Nm7aI98FpbIhXXgkbTvNqmgBhi/gZ9YIe+wG9+9+cevlSigTpEVnRXuwTB58HGe1TiW5omg3tPfSc0KzQy0KBBmlWbPbErGBdidHvDWSz5bjhO5bdcKByvkqKI4xWU7JGA8Ff1ggk7Hh8ZzH78yCAiHN7i3wxV7RBD5LX/6PSc02Vjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WQHPwyYjJYQ2t5n4CEsXY4OYhXplVV5q0R6sPrpP4YM=;
 b=ZtI+nRKPNjqtuKGvnqr/14078edHQmQp4VIlQisrfCSUWQ46byqHVGA6sBBsAeKClHv0zQn99YOjfyer6cxYyGPbiqReIqi2B0L7TlL2mVqsGxvMPyonBa22Nc87kA4P+sQJ/AfdB+pnAmygn9Z90RUvHNOvYJpiQ7V4lHg97RfkEJ2bJ86ZmpckZlgujsHiWpdyx+L8wx06ZiFU5cjP6jQj+Hst0f+4oqnN+Y7dMC4JZj5FqVtg5qHrncYQLMyk5/NNAYTXoG81wHqEUuO0qcvKujbywzQ9hGH8KkjMTN7h1o1qrPEXQO0kqM44WsUoDvjVT2Jh5aj5nNmiGeIuUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WQHPwyYjJYQ2t5n4CEsXY4OYhXplVV5q0R6sPrpP4YM=;
 b=SfT0z10spcbmHVtu9dbajFKLDU0cgtD9347W0HL7YQBU1ZwyHb/GlgKXfNCrw8dsrY/RpmzdohENHmZSjI5tRJeJdUVHMkON9TBXTfkTPT82LQBEQ1uYOvDNAlqhWCZWzuez9RB7DgbccaAscrYY4/z8y1Te8CNOjCN7cUPx/bLKqra+cP7D2xOnPGEJnSQPtNpomdnHhFlg9tr7c8iiWyQ3uN9axNI5k8HTqJy0wenv3p+ZHKu6fZ+WwQyDoQa3uiF7hCVyLThcXQHCHANaEcydBN07ZbDc42JeOqt0irUT3yY1GLFRe0zE4NoN3cASVV0p1+mAk1h11OehRdB34g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by IA1PR12MB8311.namprd12.prod.outlook.com (2603:10b6:208:3fa::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 12:31:55 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 12:31:55 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v3 00/12] gpu: nova-core: consolidate and streamline GSP
 boot process
Date: Mon, 29 Jun 2026 21:31:43 +0900
Message-Id: <20260629-nova-bootcontext-v3-0-26cb29ee8dee@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OQQ7CIBAF0Ks0rMUAbdG68h7GBYXBYiIoUFLT9
 O7SaqImxuWf/HkzIwrgDQS0K0bkIZlgnM2hXBVIdsKeABuVM2KEccJpg61LArfORelshCHiilD
 FKdnAVrcor109aDMs5OH4zKFvzyDj7LwaHm59vhXftc6E6Px9eSTRefrnZqKY4KqmTSkVEQzqv
 U1GGbGW7oJmLbEPgbEfAssCUQqEloTrWn0J0zQ9AKQysd8aAQAA
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
X-ClientProxiedBy: TYCP286CA0043.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::14) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|IA1PR12MB8311:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bf9d0ea-0cd0-428f-284c-08ded5da67ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10070799003|921020|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: 4xR8HQIhDJhmGqsmiLpnUKPcJ1D6MmJf9lGnRD3YS9KCNnuQmvTJAouWIQGXTSdk+iE2EnYUFYdmGvPSe+JyOjg3+E1/zM619zu6aarlPZXcqirDteS4wKN0eFqB+Bd0XBebFz7GKaNG8jaHLdstxGFRZfhJw4Kcic38R0l2KTvoD0KoVBzkXOt5o7tfzJfjAHSNT3WIzt0miqnogPbBrdcCplm1m9RyJ/mdr08yeyg3eXIWKZUgSgQbZKJKyceEjElHXKjETD8MbX49xfH0M5+Yy9uB4roOXfgf7A+t21KfUxYwVinP2Ai7fx1akBQ7KbVuD7VJHuYYZ9V3H064hdFGqU7kJd5MXA8khfiokXxOlerpABdGEaGmiPJXvoVmg/MN74WJs8RTaKO6crEhSY97P/M4A5dFix5IWeyZxWnq8DZDuS3zj01zfIWIZG+JzXTzAvXqwcpXh5y0Ri1BFyveJ0Biop1JatdeZJNjSyXHiWMY90ziAoDQlz7uuyWBlz9BYqITEugc2HF/FtZ0VtxCuyFnzgs330p82gZv80Iwv6fElvgpXO3OaFykDjCKstyQw1awH6GHmYK/tb/Mtsy6pqgfnf6OTz61cwPX8pvOjOXc9lMkCJQn+whnTruvDFbmGyumOB9nvFpBDhQoNms1W436kSYWY+nXLFlm787vxHpSsEcQBS6MA0KEe2qVGZF29rGdYkxYWe8qycE7GQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10070799003)(921020)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TlBhWWxVT3YrWmlYckxDOTlCbzRxY2RGaHVaOTFOdmVZZ09oU3hrbUZ4alQx?=
 =?utf-8?B?NzhEWnQrOXRiZXVtTTBybzBRY3NxS0ZVQlRCMUtvTERtV1JQanlodU5xTGF5?=
 =?utf-8?B?RXpxRS9EbklQeHRMUko1cU12c3FnMytEbGRMZXpDRUZLRVpwcVM2YjVrbWtW?=
 =?utf-8?B?dVV1eFp3OFF4bExEK1FJaG82U2NyN1czbnBybFY1UnIzRWhHNGlwa0FsVi8y?=
 =?utf-8?B?VFcxa0NTSERoK1lSM1lNSjdXM2YxeGhJUzFmOU9veER6RGlkRzlBS1Y1UTZ0?=
 =?utf-8?B?NCtmYUphQ2h4TWZHVnlteDZyMTNoOUxuU3QxQmlyOUc1bUJqTjdrSHBWeFd2?=
 =?utf-8?B?dXdCa1pSOENFdGxHOXdic3h5NVhscXZKaFFXTTBDS2c4ZGdSZXg5Q0k1S3F4?=
 =?utf-8?B?dDRrMGRLcXEwMEVqTWROdFlKN1FsdjRDOUVtOWFnNCtZWWxSL2UyQjJKTmdl?=
 =?utf-8?B?RnpOM0VFdTFtRVczRUxFRmt6aXpRZTBKWmVPUkFPUk52UWZVZUVZZVNMNFAw?=
 =?utf-8?B?UXBlOTl5NkRVRllnQ1NKZEF4dkpxY0dBVDl2NDVBb0dXVDFJQ3pNcjBHeU1D?=
 =?utf-8?B?anNvbE5LclNaaWlrTEswMjVSQ1VsSXRvamE2VlJVVHlFT2Q4eGJBTkFPK2xG?=
 =?utf-8?B?OWsxeHlkQjQzWmpkK1gyTWkrT0VyNzFtUGc3QlE1b1Q0Q2RVYjkrcUcyQjNM?=
 =?utf-8?B?YTdEV1dOMkFKTnZiMGpqNWYyYXRFczZtVXRqMWNVRVF6TDZaRTFWcjNQZWoz?=
 =?utf-8?B?VlNucjFoSXBlVWJwZDdMVTBtSlAzS21IUkJJbUE5S2RGTEE5QzRBbnk4cHBt?=
 =?utf-8?B?Z2FHUXFtMkhraDVDWjVPR2ZvRkpWWmYwSy9KUnNhMEsrR1pSWmJIbTFGTDNx?=
 =?utf-8?B?Y0t6R0xPdisySnZ3My9rbWRzcVhHOWhKYzA3Q20zL0ZDUVlCK0J4dVVOSGlM?=
 =?utf-8?B?SlJXSElrWi9mdXROS2h1cTdjUDNmTm5jdmh5aVNMOXpScEpaOG1KZWtHbjQv?=
 =?utf-8?B?NmUreDJQZUVMSjJKWWhuWHRBVXh6M1ZOQUNEVnlTeXRTVGJFUklTb1pZNVRV?=
 =?utf-8?B?ZE91S1ZlZHN6Tzd3OHhtMGx1VkR4NGM5SEt5V0IvVW5qR0dEMXp0c0FET1NW?=
 =?utf-8?B?eWdmcm9tSlFRVTZYTDFUUDFwYnFya3Z4RGpScnhGQ0Y3bVJ4aGptYmY4UDBM?=
 =?utf-8?B?MUl4S2VxVWkrU1VyMHB2dnRORm42Vllka2dGUU0vZEVwWXcyaFRyVFEwWC8z?=
 =?utf-8?B?VTUyejFQcXpFUzFiaDlQMkdkQk5RL0lXYTZocFB2N1JYYVpNZ3daekF0YU9L?=
 =?utf-8?B?Wi9nc3h2c29OTU40SnoxdER2bnI2NWttcmhRRUl0M21qQkpsQWV0bjZjMGl2?=
 =?utf-8?B?WU41NERuak83ZlBCT1JCeXF2ODZRNFhhZGUrMDVQQVJ5MFpwVmh0WlBCZWtU?=
 =?utf-8?B?MHRXdXZEUTdEbEJZYXpwL1dNM3Y1UDIvdXRUR1FvelhMbFplWDhLUEU1N2xy?=
 =?utf-8?B?TXJXeDZwYXhGdVVkN3haT1pVQm1MY3NpcTdGYlRpV1UvZWtiMm84TGx2TGpz?=
 =?utf-8?B?VE42RTZPR3d6bWR3cXFWMi9TZlJuWGo0TDRuOTR2M0lrQ1ZhbTFodlN6WGc0?=
 =?utf-8?B?eHRsYWJHYWxkcVNxYTVDbHVyODI1TEdBd0hKREVCNitCNVpPZlhGWjA5SG1I?=
 =?utf-8?B?Z205NkpDOTdnT1QvbTR3RFVCcG10bjROeXpLcGNVSEFtNjRGQng5R0dqU1BK?=
 =?utf-8?B?cis3UDhucXppMDQ2U3dDd3J5eHBHZi92My8yTUk3Rk1Yd3NjS1hJRThGZEs5?=
 =?utf-8?B?clZKZHBWdmRQS1hyRnBHbjkyVnhqUjhmK3JoZW5XVW5RNFBUZDczK2xGNWt0?=
 =?utf-8?B?STBoNGg5T1d0QVVGeWxzR2RPcVBJOXRnT0sxVXJncDdPbjQwZVY3Vm9PbVRa?=
 =?utf-8?B?a0hiUkR2blpCaXIvSVdxWHB1TFhWaWt1ZXk1N1AzdjFERi90RWI2VW5adm8r?=
 =?utf-8?B?c2k2Tkk4OG9VRXdXdkI4NlFzbVZ3VUNHZ2VPcnVacHBnUVZxYlVrMmF3eGpW?=
 =?utf-8?B?YS9kcFNZbFppblF0bkdLQTgxbkViL29pMi9laDZGeGc1L1RzeWpFb3ZXeTFj?=
 =?utf-8?B?R1R0Y0Z3OHBScDdkYndMUElhMFJ5MHF6UHpJMzBkQkZKUnVINzgrYnJqNTVC?=
 =?utf-8?B?NkJMaGVMdVVLZ2UvcGQxZXZWVDZMMUlvNzhRc25XYXdyUXQ2MUhaNFlaa2g0?=
 =?utf-8?B?R1JiZ0xxczJHcU8xck9VK3VjTUR3YUdVcnQzTjJGd3F3VzdFeC9DYkdJYTVt?=
 =?utf-8?B?dlpTUFRkNmNScmFqUjZud0p2bS84WGI3eWRaSnVJd1NjMWtaajdIQWJpRXdh?=
 =?utf-8?Q?4K9k/kSAiW9nkwV3I8/Ii351hTgyDaWTZnGLH5UEJv3yR?=
X-MS-Exchange-AntiSpam-MessageData-1: Kf4OIlSPfPa6TA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bf9d0ea-0cd0-428f-284c-08ded5da67ae
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 12:31:55.4380 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F7uciVvT9S6E7VUCXwKes/HgZVGHM4vHsjKjElHYkk3wmD5tI2QhfnSAdRs65WwdgFg/pNjEPvE19AGbudk2LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8311
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
it is only needed a single time in `Gsp::boot`, and inadequate to handle
errors occurring in HALs.

Building on this, the series also introduces a proper type for
identifying the GSP boot method, and moves the `Fsp` instance to `Gpu`
to make it available outside of the GSP boot process. This will be
notably useful for vGPU support [1].

This series applies on `drm-rust-next`.

[1] https://lore.kernel.org/all/DJAZRULU1QHZ.2NSTR1ZPOQUSN@nvidia.com/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
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
      gpu: nova-core: introduce GspBootMethod
      gpu: nova-core: avoid repeated calls to pci::Device::as_ref
      gpu: nova-core: gsp: pass GspBootContext mutably
      gpu: nova-core: store Fsp instance in Gpu

 drivers/gpu/nova-core/firmware.rs       |  25 ++-
 drivers/gpu/nova-core/firmware/fwsec.rs |   5 +-
 drivers/gpu/nova-core/gpu.rs            |  68 ++++---
 drivers/gpu/nova-core/gsp.rs            |  44 ++++-
 drivers/gpu/nova-core/gsp/boot.rs       |  99 +++-------
 drivers/gpu/nova-core/gsp/hal.rs        |  56 +++---
 drivers/gpu/nova-core/gsp/hal/ga102.rs  |  14 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs  |  40 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs  | 335 +++++++++++++++-----------------
 drivers/gpu/nova-core/gsp/sequencer.rs  |  71 +++----
 10 files changed, 369 insertions(+), 388 deletions(-)
---
base-commit: f1bd7119ac4c98fc2f0ddf5a6d851de66bc5f62f
change-id: 20260619-nova-bootcontext-401d6107e8fb

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

