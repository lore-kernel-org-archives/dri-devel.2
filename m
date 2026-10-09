Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C3ADCA6017
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 02:16:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9C9AD10E256;
	Fri,  9 Oct 2026 02:16:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="hXUGBcOH";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2906810E256;
 Fri,  9 Oct 2026 02:16:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Nanj8BgDh+kbQPEnnGhmiHgJFBRszC5lYd0ZZJbjTo/pxxNwJ4lfGpA4xWVs+5zICscA6eHZuoXZuycIobcn70BYvclavZnv7TxxsiWr0VPabVYWvo8YD/CqjBO6f/4DZ1/qp9VsjgQPn/G2t9at9kZPAlIOr8Vp0si+9MuYPMidDSEJxnz+Zz6UGlkn8FkUuVrQzwaqTJyZ2o3dPlXIhC5uV1HyXGmz4EO22KYWKFaqfimmRwX+wgiFIu36qek095Ity2jS6LS+hYOSN1vrT3IAutmpqc8yuYu4FCi1BbizDSQYN/GcWiWzdlZDFjRjf7HoS4yO3hb8aH2fkkmt9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dWhyqYYYxwuN3kR66b9YyghLTZtc96wQTOopBBDAiuI=;
 b=QJf1LxHRR1WYlUJ/xK6mWvzqOf0lYowMUKHMIh6vGD0LKiBBiI2uuR7W7GXEFUHqyNI4r+JgHAR1Te3fQofh3KQ16Hi73j3uCpQL1E299Auui3ETeaLr3jD10jMpvQnSY6wTwt9zJpq74zEAIT8uO2YgxLilUvyYIXiZ1LH8SJHjKBGkwNQmbDolLLPXeqhBpgbaMgjFB1mgJK+tIHPnfQ0XBLIVf5XN5gN5PhVexsgMjsMDVZqQgv+WRAM01Nf2K/aw7HPUikslv+o51joP2QUrOwz1bT/jSykcbP85xXwrExuB0yiFPMuxzsUVdqQiEFI4y4Z4qXwgcz3ohNq/Yg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dWhyqYYYxwuN3kR66b9YyghLTZtc96wQTOopBBDAiuI=;
 b=hXUGBcOHQVqw64KqXLAU81dQ0u/xhoCBm5A5NjTZyUhbzz/sEXdM3iSWK5kGRRGt4c4d3XO2Yr00qcTRpYYCMR8TPR6PskLc1YjuKlJf7x36j+sngIiGHZpm73fmf3NGhFB06ku+LgOk+A+Pk2KnpSNvQ4n416lW321lOGw5dIkK2xAoSNPcJ7XJobhQu2TtrA280A1wLdxk3g9ieR6VVeyG0T6tW4d4xXUWORj+nDF2gDn3i81kKDC7XflB3Mk/NNCfHDxqsUBL/08C7gtXST/PMDmumCvg1qHN8lC/aSy5FCnuSddydR3J9BM00jiXArsSxAaNcgIkkqVSkQaLxA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by PH7PR12MB9202.namprd12.prod.outlook.com (2603:10b6:510:2ef::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 02:16:30 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Fri, 9 Oct 2026
 02:16:29 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 09 Oct 2026 11:16:26 +0900
Message-Id: <DLZY2GOS5VBP.CTB65BPKURRD@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v3 7/9] gpu: nova-core: gsp: cmdq: move the RPC code
 into a sub-module
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260930-cmdq-rpc-v3-0-91613f06520b@nvidia.com>
 <20260930-cmdq-rpc-v3-7-91613f06520b@nvidia.com>
 <DLT8T5HQDV6N.30T90TO3IDNKM@nvidia.com>
In-Reply-To: <DLT8T5HQDV6N.30T90TO3IDNKM@nvidia.com>
X-ClientProxiedBy: OS7PR01CA0102.jpnprd01.prod.outlook.com
 (2603:1096:604:256::14) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|PH7PR12MB9202:EE_
X-MS-Office365-Filtering-Correlation-Id: 58c2a3dc-662b-4a79-d840-08df25ab545d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|10070799003|7416014|376014|22082099003|18002099003|10067099003|3023799007|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: GXglDe7PczYZORzkp7HHv/bXCKzasR1QPgN7aUbgHkcfLq42gRt9I4//NQ+o/y9o8ui0ixNc08Tl5lBWXG1n1MFAMGqjrXTNnwQ/nBMFrD2rZVWI87NmTmNhnDDUSS5EOW41aosFxBymVoSJVQ08/N8N2L3E0fzgqL+ilBt5K8eIQW4myX6CLH3gGmZngQ3Kks3Tm5dd4uuY7AhpeNB9yZVX/nv33onTG3Cr2yXhU8HQdST2UNcrv6DIPtlLQ72fFb6OLX8xOb58z4KfIex2D3T5ycySbriO+IEVLRX3wjTF1AUmHACc6kCm9Elr4eN6WP1BCgOCRGS1Rm+dbWdD+dXJwQXGXYw0K4mQgsR9B9KeCLPVreIDbgexDIBpwrFvr/bQ3kLVx8ALhO7eeNcWb6nrLnl1uOO4RT/RTTZ3bZHO57epW95Jr5g0rFkknrL33MmLhtPDRHy5WEMYpFHicBZdvBrSaJ7djO5kAmHxqtB4HFKmlhvR6zyZ4cdn64m1dY8rbHd91zN8hDqB2erpV+RwV0+okIYGeVFG5eODzpEmaOi105zXRKlriWQ+rmqokwwNnUFDkdn3YeipKvjy+neeSFxrAUFzxdz4nCV65qgc6rLmT4Aj27Vu6bDq7uq+w9wvOGNxs17lZZWotJvbag==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(10070799003)(7416014)(376014)(22082099003)(18002099003)(10067099003)(3023799007)(4143699003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1lRMkhYNE5HSkNoM0poYUJ0YzNaS29Wa2hmdEVhTTZEOStzR0dreDNzL0Nr?=
 =?utf-8?B?UHg5MklIYnQycndzZ0xXV0hLNDFBVUZnSTRBRThYZVNxNkljK3BmZGRIdDQx?=
 =?utf-8?B?QkV1TzFJUUZ2MnpTQzJZai81Zm9oN3M5N1luMk9ydytteGxQY1o0SjBXN0Va?=
 =?utf-8?B?VWxPRHRTS0NrcUUrVSt2VW4yYkhpTElSUXgvd0xwMVdFczhva1h1TDl1STVZ?=
 =?utf-8?B?N0JNdjZ6T2JsSEE1alUwUVpXM2FCemlvdmM2Rk1LbnNBTXVUcmFZQlFwayt0?=
 =?utf-8?B?NnEzVU51ckxkQVdvOTdIMlZsTnJ6bGlBbCtOaVVRem95M2FtV0VwS1pDQU0z?=
 =?utf-8?B?WDcyNUFDbUFIdEdLWWFtbmwvU2VWbnlHVlZzWmt3bHFySDB1dmpLNm9oTmo5?=
 =?utf-8?B?V0R1a2ZmTWxKdHduQmR4SVZVaExTRkRUaEx3dE05cVJsOEJpcWNtYUMwZGg0?=
 =?utf-8?B?ZmJKL29rZ29MMlpuM1hOcDVSUmUvMExwSnNpVVQ4L1A5UnRNdnNrY3BPL3BN?=
 =?utf-8?B?MHJsUERjQlVMa1hQY211MWdsWEx3MTZCVXpxN0IvcWEzV2N5Y1loV1lvTkd5?=
 =?utf-8?B?ZW0vUWYrVTBGeTRIRm4xb2tYRDZ5L0Z5c1NYSXA3UitPL3RFZDVxMWViZUVL?=
 =?utf-8?B?K0F0bE5wTkptTDl5S0orQlA5ZEN3V25aUkI3TGNiMTZOQnpheG8xS2hWTWFt?=
 =?utf-8?B?SDFnQnBBd2dISkZLUmJGMG9JSmpHNVFiYnZCd0FzaTNWUVVSQnQzUGlUSk9Z?=
 =?utf-8?B?dmtGR2dCQWR5WnMxT054eDVTbCtuRXdrZjI4TEZQdytDM3JyMDRKejMvZXdj?=
 =?utf-8?B?T1VBNVcrUDNwYldrYzNkNXIzNnZiV2tXaWY2TUxsZElhSG5oR01FNWhxdGVU?=
 =?utf-8?B?d2xEalA2eGY2YTRaQWQxZmJTUjlQd3JWa3gyVk5vbHVCem5JeXBlNllXZG05?=
 =?utf-8?B?SUxUelRYcjEyNGp2azNJVlBPQkJyYWZTaUFBUUs1WjBMdU02bGlUL0ZxLzhJ?=
 =?utf-8?B?NUdBcjBsYkMvNitJcnEwRDZVSHhBTUREU2xDWmcwUHp4R1ZnQ2t6dmd1STN1?=
 =?utf-8?B?RDBPY3g2c3ZQaUU1T0lqWW9Xd2p3L2J2YTdENWJUZzhnOU5vdWZpVGgvUlRr?=
 =?utf-8?B?OFZwWHZGdEowN2N6U3IzYzVRNUpnWktCUVNDMWZCNTF4ZlYrRWRvelU1Smxo?=
 =?utf-8?B?OGxHbEtlTzZram5XSGhIWjF6cERoSCtzaFdGNUZ1N3VvSzFkYm13Qmhjd1Rs?=
 =?utf-8?B?YW1ydVRNVUF3NDRmOVZsa1FWbldBdDFFeDVJckd3bm9FbExqS3RJVnE2dEFI?=
 =?utf-8?B?V3dFOXZwc1FIcktHMC9IazJ1ZiswZVBtckhZTFgrWE95Smc5RUtUNER6MjR3?=
 =?utf-8?B?SXUxZ0tXRVJLUmtUUjZZRENhdzFkNFRzLy9BNlJsZFhFbjlzQ3JzUXBVWWRr?=
 =?utf-8?B?d0t0TUhiUk9HaXluSys5NWZ2UVV4N0hsUEk3a09FaXMzdDE1Q0w3cWo1REh1?=
 =?utf-8?B?WEgvdzY5eHlVNHpnWHgza045UW5UcU1Cdm16M1psOHFMbGdFempaQWNDZGUv?=
 =?utf-8?B?eDMvMlRjU1hybjdldzNMd0dDUzArZFVuSXNMcXducHpyZTZUcWFGdHpQM1Z2?=
 =?utf-8?B?TFNkTExaT0JZc3hKZlkwNzRJNmNwczlQKzZ3M2YxRnlBaS9qeEd0ZVllM3Bz?=
 =?utf-8?B?SHRseFlDbVdLNVIyazEwU3k3V1dKVmJLMUs2dll6d2tyVG9ObzAvVzJDOVJL?=
 =?utf-8?B?MVpwQjNWbXdzS2d6dVZ1Q3dvUWFtenJJdXF0Mmd5WVJWSXdIOCtSVVAxdFpV?=
 =?utf-8?B?V1VZeTBMUUZJTVZTVEROSnZ5TlY0Qk9VTWNLNnhFODBOQkNBNGFKeWJjTG5Y?=
 =?utf-8?B?TTE5aWNaV0NMek5GcWhOR2dCMGFOczhGOUNPNmRsTFUvcDJoeFE1UE05SWRj?=
 =?utf-8?B?Vm1BMmp5cnREemdVT2ppTTZtYVdra1pmUWdoVmxKZVkwdXd4L1NFR3JrcEtG?=
 =?utf-8?B?dTBzNGU0U3B3VnhXS0NrcHlxK01vZy9ONUdaT01EYzlXRmtCTzFLanlUblVs?=
 =?utf-8?B?cHhqSy9xREVEbjRzQWcxSVl2bGpjMnZWakt2YzRwa0N4aFJsTDBHd0pFa2Fa?=
 =?utf-8?B?VERDcUpKdzlsQ21PN1BVclBlZ2FJSTE2Wm5pVVJPTFpqUVBsME9wUnN2QjBn?=
 =?utf-8?B?VHZlOVFTcGFlcldjWVJYTnBIaUhqZ0w2LzhZSlBZYjVKcHd1Q0pXaHFlOWtH?=
 =?utf-8?B?YzNUU2NMNVR0eUQ1Q2ZlVGVWcU5mY012UEw2UjN0aVZnTEFUcDFCVDh2MmJO?=
 =?utf-8?B?dGU2OHQ5czgvWjB2NmVrYS9wenhIRVgzWm9Ceno3V0x5UzhPMVNhSWV3Nkhv?=
 =?utf-8?Q?NaEcEqeO4EN8OAm9HZU7fSapLz9w2L7loPTEbPVNTXRtL?=
X-MS-Exchange-AntiSpam-MessageData-1: 3quCdJafwzE/Cg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58c2a3dc-662b-4a79-d840-08df25ab545d
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 02:16:29.7498 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WS45aYtUmwiFCg2PSiCSWtyiTmy8ARzKzb2JHApHSehW4bP/98rtgmzuf0PrQFnNu+o0E+Pla4SgQmwwsEQKyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9202
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

On Thu Oct 1, 2026 at 2:12 PM JST, Eliot Courtney wrote:
> On Wed Sep 30, 2026 at 11:55 PM JST, Alexandre Courbot wrote:
>> Move the types and code related to sending and receiving RPC commands
>> and messages into the `rpc` sub-module. The methods are still declared
>> as members of `CmdqInner` and `Cmdq`; only they are now in their own
>> sub-module.
>>
>> This is a pure move commit, with no functional change intended.
>>
>> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
>> ---
>>  drivers/gpu/nova-core/gsp/cmdq.rs                  | 343 +-------------=
-----
>>  drivers/gpu/nova-core/gsp/cmdq/rpc.rs              | 380 ++++++++++++++=
+++++++
>>  .../nova-core/gsp/cmdq/{ =3D> rpc}/continuation.rs   |   0
>>  drivers/gpu/nova-core/gsp/commands.rs              |   6 +-
>>  drivers/gpu/nova-core/gsp/sequencer.rs             |   4 +-
>>  5 files changed, 388 insertions(+), 345 deletions(-)
>>
>> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/g=
sp/cmdq.rs
>> index 07036972dbec..06386d1ab192 100644
>> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
>> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
>> @@ -1,6 +1,7 @@
>>  // SPDX-License-Identifier: GPL-2.0
>> +// SPDX-FileCopyrightText: Copyright (c) 2025-2026 NVIDIA CORPORATION &=
 AFFILIATES. All rights reserved.
>> =20
>> -mod continuation;
>> +pub(crate) mod rpc;
>
> Should this be pub(super)?
>
> I tried to think of a way we can have a only generic (over RPC and GMC)
> receive/send path on cmdq. I think it's possible but I don't think we
> need to do it right now. It'll require some care and maybe information
> from the future w.r.t. how we handle async events etc, so maybe let's
> revisit later.

Yeah, that's also something I was considering as I wrote this, but I
also don't want to paint ourselves into a corner before r000 support is
merged. Since you seem to agree let's defer this to the point where we
have more visibility on how we receive messages.
