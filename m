Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80E76C43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:09:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0F3C10E7DF;
	Mon, 29 Jun 2026 14:09:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="KnCyPGDU";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010043.outbound.protection.outlook.com [52.101.56.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E23510E7DF
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 14:09:52 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kyiyJFDRQe5rQzjM9j36VndK6ZQ/RDBf2RP92XcEFMmbSqjscrJobMEODjczSf5KHQcEhD+I3fX16SbBHTduz8JgP6ARsXa5HJEsZQ3+dvkHPpAB5RTpUZKj9dHiL8Ke+KSs0LP8CAAo//imHIN8YGkbfQv5cpHe9Jd617y6qOCLeJyrcFsWZvKs9qH55ltoo2NypWfEl2PIu2eqLG6XeEUz7c+hNjnCGGT77bXYgF7pqVZuBJlBzNvi9l++3Fn0/B5+N/33H+tLY3EJuOEyQVOMLTfYvY2Vn1xyKZEJrRBga7Zw2Ext1vhjgX2a263FxHQw3TaNamMz2hFt7CZJpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r0Lg/KAuceY6qLELoVbQFyjAkYUgf7d+Mt4btYdPeDs=;
 b=GcI0huykdyV1Cdw2vu5hp1TDUo7J4ocyollhZVdKSm7ro/1pA98DsbvIRAxshH3RPtMjQY8dIeWZsuSFtDTbMzNHVdYfh7dOUcD14w1xs+rvYWUdW1D2skKDZGT4xibBxEbGzNHir7h8b20aLOU2xsDagNfMacJg+Byj2fw87Ma6dW+MSjQId4mjrVJU3AZKLvSpIzffbicu44qW9Q1T0uygfctO9Vo/frHa22eQK6zcF784ZBDa9mOV7SFocmU+YKx9pYk+r4OBPYvEefRIWCESce9nRhBdVDEVfhLyR0QXyaP1leO5Kr+aXUgb9wgUqaExBy7dhT6lBOiYmPbOGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r0Lg/KAuceY6qLELoVbQFyjAkYUgf7d+Mt4btYdPeDs=;
 b=KnCyPGDUB4LnHMkW6FxN9bpZkWulxUVQEI4pT4uncNPhqD6ocKmPLfLdSbhjxYNy0CeakXwo52ee4vHJ7+/EJaZ3flboctO2YV4tT/BmcP4EBt+X6w6EnCA0akJeuRC23XlXr4h1u/0CK/Np0vkh0GyVJa0LnM5z8AvtNqcarpaxFxexdqmH+vC7fZNYreiuSpZmTtiYK3D5Re4OJNl26O85du3RIr0I/suR20mr7+y4Mn6vEzWR4eZkaOdFp6DdpKVtIcQfBXAz5UN5HoTXOgN7VM5HAdDuFhvtJuYMn0xDGadEcsgkWK2GHjHF/ZRDkT6bUch5+vmcTUva7xZUQw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by CYYPR12MB8654.namprd12.prod.outlook.com (2603:10b6:930:c9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 14:09:43 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 14:09:42 +0000
From: Alexandre Courbot <acourbot@nvidia.com>
Subject: [PATCH v4 00/13] gpu: nova-core: consolidate and streamline GSP
 boot process
Date: Mon, 29 Jun 2026 23:09:32 +0900
Message-Id: <20260629-nova-bootcontext-v4-0-5539d8469590@nvidia.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OQQ7CIBAF0KsY1mJg2qJ15T2MCwpTxURQoKSm6
 d2laqJG4/JPZt78gQT0BgNZzwbiMZlgnM2hnM+IOki7R2p0zgQYCCZ4Ta1LkjbOReVsxD7SknE
 tOFviqm1IPjt7bE1/J7e7Rw5dc0QVJ+e54fHS5V/xtXYwITp/vRdJfJr++Zk4ZbSseF0ozSRgt
 bHJaCMXyp3IpCV4EwB+CJAFpjXKVjHRVvpLKN6FXx2KLIBQDdSIK434IYzjeAMWEKB0XAEAAA=
 =
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
X-ClientProxiedBy: OSTPR01CA0027.jpnprd01.prod.outlook.com
 (2603:1096:604:221::17) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|CYYPR12MB8654:EE_
X-MS-Office365-Filtering-Correlation-Id: ccaf729f-3f12-4348-a21f-08ded5e80f06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|10070799003|1800799024|23010399003|56012099006|11063799006|18002099003|921020;
X-Microsoft-Antispam-Message-Info: NYZwuRcFq0OJANRTGqAb7ZES+bMjyZhel6DIsh8/xLQR6MuvQaSX2DAfio9OiiKw1HJ561+whq2D5BY9VoJ2HUTAq5Dg6M3jZgJ1E5lpzXZUWPvNnTMLPG8vMNPKMclwS5gD7OhOTvJSFuRxoH09CfD9T4Ew3vgCeBcnb77Jq9AxMmYpjDIZucwDMCFTVrOv4o5Z+qwydDxkgyFu60zCO1qDCH60Hui+2DNE8EeU23r8l3YpMsiepDP3qDgEcmS3bq+nYGi98TB3eTUBEoF54ugliHXWvJXxceRgoYBfyLU3DeETwHUHPLzNak99EV9AHfWI4vM52Pe/vNjI+A7hrmv6hTI65U1O1a1O2T5db9AluZFTOFcs/qIgJy3icqvnuqnO/XH7QWZ3b99lwSRUkprBRnfz71Bfy8Sf5iDedWyeRBWSaSya00Ucwd/QvmM7gJPnp9HoyM6Ov4OtE0OvNEYi0UpcpsHF+KR8hWf5966ufC9yvZe6zQ0sS10ecbNCJ5D501PyqLvBkbz9fdg+JtBVS8/6xHDcRxhcXTfSgADP7jvTZ8wxzEv11g7z+CpG/xVeyNMok58Bz+xXtr/IaOgS/GpE6WM8d48fT77mnU+LG25f/DOgPXOSi35OgufqBQx/3SobK618uvYfcF/QwqTYBOhcvlPoX64NIeruHgaC2j4nEhiNW7P8FJD/ip06esXCmy6DXVl3FYaGlxXi1Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(10070799003)(1800799024)(23010399003)(56012099006)(11063799006)(18002099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MUxDMGJFRisyRkJiSityN3lPeUJGTGRia0F6ckJ0RkpjeFdhZUtWU2N3dzFG?=
 =?utf-8?B?SG4rc1RGcU1OUzVGZVFWVUU2S1lER0pzbUZ2RUJzRHdPemVsNHJ3a3c0dDJV?=
 =?utf-8?B?SGRhZjJCVHhucjF0bk90VVpkRnhSSlA4anVONkM5Vm0xM20zeUlrTnpGek9a?=
 =?utf-8?B?b0hjeTJ0NDhFTkkzNmRPVTNTQ3h3bnlDbFIvVlFwS21NTU5oeVNuT1IrR0hx?=
 =?utf-8?B?bXNVQ1NDSW9MMXlIODJWVDhNejk0dk0rNzJWV1ZxZC9Ja2xrNlR1NjJuS2ww?=
 =?utf-8?B?a1REc1c4ZVphMkNpVUYyWG91bGRnTVgyd0NPQyt3d090RXljb2U2UkxwT3NB?=
 =?utf-8?B?UHdJekh4WkNJZmY2YkJBZmc0R3FZVGFXT3VEc3BmUDBIK1NrK3JKQzVRc2pS?=
 =?utf-8?B?K2h6ajQ3b0lKRFFVN2JiYWlQM01jek8vZy9nWnBna0UwRlA1dHZvOVZldWxV?=
 =?utf-8?B?cVJmUUZJbzJ5U2k4dWRZdHhCOXphUzE0RjcyWnkrczJpbm9KWlZrM3NDZjBs?=
 =?utf-8?B?b1pYM210dUxISTFHdjlPMzlsdURsaHh0ajg5RFVvQzZOSktnQWtEVzhQT3Jy?=
 =?utf-8?B?bEp4eWZXdmltR1dEUnA1SFNGRFpZUTh1dFJucFlXL0hTQTVzQ0tTTEdDZFdl?=
 =?utf-8?B?SThqZ2hyS0ZJb0pOWHloSkpKZHhJODJqYmdyUVhBRjNtMkJ4QU9xWkt6N1k3?=
 =?utf-8?B?ZWczbnQ4SStvZFZ1UFVlM3paMHpoeUxqMG1vd0pKNkJCcWdOd05hbmRjWFB2?=
 =?utf-8?B?cDM4c25JRVZ1ak5QcFJnSXBRZkNHMXNZUmtad1hmWHQzYU5XSC9SQ052ZGFV?=
 =?utf-8?B?aklxNWE4bThOclFsSlpUemRNZnUxNDFjZDNQVDNvQ3J2a01TOW5EQzU5TXZ1?=
 =?utf-8?B?WGtQeUZRZTRPb0NjRGlKQ0tSNjJ1YTE3eDZ0c2x4WEtJcjVUWS9SWjExU3Mx?=
 =?utf-8?B?WC9LZGFYSERvT3hIbW9oQU1xa0lBalcvOEkxRTRmaTZ4UmpURTJUYkdPM2Iz?=
 =?utf-8?B?d2FacEtub3J0eGw1ZE8wSFhkQ255cW9tTHNLcU5yTnVBbkFrSDNmT2kxdita?=
 =?utf-8?B?L2ZUUnFGNnlQS1NEeDZqU29XSEw1WWt0THdjNUxNNmNkS1VuS3dvWEJML3Yv?=
 =?utf-8?B?MjdhTHdHWDdRNWRvUGNKQVpNdCtwMThZb1hINlgvSzZrNWE2cXVyWE4rNWtN?=
 =?utf-8?B?dVFHcmlKcHQxaEd0ekxoaFl0bEVTNENJS2MxcGJzWlBRMzdJZk5XRVcwREdh?=
 =?utf-8?B?cEsvZXRiZmUzcnorT21keUVJQkY0OXlvNjhsRFlzZ1Mvc3o4V01GVENMZnRu?=
 =?utf-8?B?bXZLcjVDRVN3OVk4Z2lRa215MVJlZWRobjZydVdsUGZpeDExVEgxVVFaN0ZP?=
 =?utf-8?B?UmtHMFhHL2FaU09XM2VEcFk2emFGSFpUS2VWTlBmcG1OS2xKL1Y0d1Boc1BE?=
 =?utf-8?B?MFp6MDlRTTJyd1djVjQ3TEZNalVlMlVpaXVsUlZHYWg0SUxndnE0eFJ6Zng0?=
 =?utf-8?B?cUNDSWZCaEIwZ0FGbzhtazNWaGtYR25qNk1hMm4xSFRPUVdMU2lQb0JFRUZt?=
 =?utf-8?B?aFd0US9YdzJaZHVFY1BZMm5HQUN1NnQzWi8xY0FFVFJ6UkhQdEdTT21ic1ll?=
 =?utf-8?B?bDlJbVVwdkVLUGhkb25QeDUxMVVvaEdUT3p3Rk95WWVmKzlMa2ozTFdLVlVP?=
 =?utf-8?B?ZXhtOHRZY1VzM3RqcXpjYXB4bDMrZCtvSmRHditUWHR6VzBOOXVKRC8xVUJp?=
 =?utf-8?B?cU1xUlllOFNlZWh2Q0lwdTJSY2FlMTllNkFTbWtFMitHalAvcnhyMm5ZQlJN?=
 =?utf-8?B?Zk1RUDBVWjlNYzMxUy9DRjEwN0RqbDVLbzdWWDN1aTRFOXlZbEpYMUF3QkQ0?=
 =?utf-8?B?enh3U0ZtM2djQkNaNTQrRURFOVdZTy9UUm00ZzJBVElzN1kvUjU3TVhPN0g1?=
 =?utf-8?B?cExoRVNQTFgxMlVpbjhadzd2VEMzcEczQ0g0Q1lXazVCRDdXOWVrbDhHMUgw?=
 =?utf-8?B?MWFlR0dtMnZaazJsRUlINFI4L3plQzM0L1I3YmNVQ2FnNCtrTEZvKzNVMVdk?=
 =?utf-8?B?blhKdFBpZGxMU2VMNDVORmxpS0tmS0RwbzdUZi9ZTzlFeWRyUWFPaEtMVDRN?=
 =?utf-8?B?dGx2UWRBTmF2Wkg0dUhLbVdJMGtGaWVQaGFrQ093SU9GZk5jRjFaM3lybTV1?=
 =?utf-8?B?Y1J0OXZNYUNRV3I4QUoya3VqMnhKbEtiS1RuLzdONnN1K2VNaGdydTQxWU82?=
 =?utf-8?B?Z2ZCZUZBQjV5M2tseFEzY2lVRGlCRXoyVVpQRk85Vzk2ajBpaDhYcHIzMUNG?=
 =?utf-8?B?aDJFaklhbU1UYkpMOEM3REF2NEdKa2ZHdER2Wmc3NTlUdkhTbGxpYlVjd0Zl?=
 =?utf-8?Q?JkeBP0sw34zIEzcE3HkoxbgaAmT3CiTHd9+lWSdIUnzsq?=
X-MS-Exchange-AntiSpam-MessageData-1: Z18MvjZbHn3FWA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccaf729f-3f12-4348-a21f-08ded5e80f06
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 14:09:40.7717 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v5HoUxZfukWWInWa2d08HFJO2LhXbl5LYVskY/e/vFhIPrm/E2slhMubA45PmneMeenY8OONE1IqpFcFmfbaIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8654
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

This series applies on the latest `drm-rust-next`.

Since v3, `drm-rust-next` gained a change that makes `Falcon` retain
references tied to the lifetime of the bound GPU [2]. `GspBootContext`
thus needs separate lifetimes: one for these references valid as long as
the GPU is bound, and another for its own shorter borrows of the GPU's
subdevices.

The distinction becomes necessary because the final patch adds a mutable
reference to `Fsp`. Mutable references are invariant over their pointee
type, and so the compiler raises an error unless the two lifetimes are
separated.

A new patch is introduced to take care of this.

[1] https://lore.kernel.org/all/DJAZRULU1QHZ.2NSTR1ZPOQUSN@nvidia.com/
[2] https://lore.kernel.org/all/20260625-drm-bar-refactor-v2-1-9db6b890d92e@proton.me/

Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
---
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
Alexandre Courbot (13):
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
      gpu: nova-core: gsp: separate context and GPU lifetimes in GspBootContext
      gpu: nova-core: store Fsp instance in Gpu

 drivers/gpu/nova-core/firmware.rs       |  25 ++-
 drivers/gpu/nova-core/firmware/fwsec.rs |   5 +-
 drivers/gpu/nova-core/gpu.rs            |  68 ++++---
 drivers/gpu/nova-core/gsp.rs            |  63 +++++-
 drivers/gpu/nova-core/gsp/boot.rs       |  99 +++-------
 drivers/gpu/nova-core/gsp/hal.rs        |  56 +++---
 drivers/gpu/nova-core/gsp/hal/ga102.rs  |  14 ++
 drivers/gpu/nova-core/gsp/hal/gh100.rs  |  42 ++--
 drivers/gpu/nova-core/gsp/hal/tu102.rs  | 332 ++++++++++++++++----------------
 drivers/gpu/nova-core/gsp/sequencer.rs  |  71 +++----
 10 files changed, 383 insertions(+), 392 deletions(-)
---
base-commit: 23d66dbab84e8518943563df2ced14aaab28b77a
change-id: 20260619-nova-bootcontext-401d6107e8fb

Best regards,
--  
Alexandre Courbot <acourbot@nvidia.com>

