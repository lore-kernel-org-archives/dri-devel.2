Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC82C606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 00:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=0fGc5YO2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5365010EAED;
	Fri, 27 Nov 2026 00:09:31 +0000 (UTC)
Received: from CWXP265CU008.outbound.protection.outlook.com
 (mail-ukwestazon11020120.outbound.protection.outlook.com [52.101.195.120])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB1B510EAED
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 00:09:25 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yguUEusCLVBgYRonqrOdyG8VD9nwl2TAlf6gL/ak9cNPdRqQGPW5Qw6A2OMaYX75qjAiP7zvFY80Das21t/AtrCWHOmKTQ+/3DxOSqfGemKqz6hV5wVA1GSEzlYpetrPW0lGA71uX6VO1pqiUtPEcNWhsapOri3pJm/ke7Smos9bmop/7gpGfLvCrRhYUQ+WiKpU5md6JS7qcP9Y7ra0cTQCsW/QOQFUTwZpxaQW7r39i3K3DFPp9LiEow/xVjGdFyurGnyJjxF+tXn0pUGzS28CkEKHdlYVZvXqGL80W30Kz532/kt0goKf8OmmsCDneURt7WqoJsOPjnVHNAATrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79yzjHbikM5imavsJp5NdxHJkc8vhY1gukKR1ZCLk3s=;
 b=XzmOcaxIXs+X8l3/HOSXNknxrBSeS/dqxflq0GXYdPN5/NQPZxH0+riH0pH8cBNF+FC2ghW2VcrIt1URR/amKhvMGFkJWh9/MRG37WZtSX7OHvLs5Xtp6dyfTn1C6jr5Vnv7gSYfdgdxfs+Kvp9yias8N7iGoEQaNPCthemplbkzPAwQ5lkjCEe0sXUM/uWFSvcx9CykLtcq+J+qdSuB+/UQMiIawFKnbEBSuXwXhBm4B8wWRZme+5B7qcvUXFkl5kDJ3g8Tbi16Q4RkaHOCez3Yzrc3TNPmbHmkDCD9UD4V+xWj/x6IvSEfCZyOKk5FXes3m0uUzS+N3h2HqPqXUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79yzjHbikM5imavsJp5NdxHJkc8vhY1gukKR1ZCLk3s=;
 b=0fGc5YO2dyuDtaV/uiNauQbwJGvwySiUO97agQWY3eaf2mkHrkSP5HFbjTRjnTYdgf3OhgVjCVfiVm0uQzD3pAZD8Ncpzeg30jZ0ag9BpFXfQtHvm9tbSNtLzRZrgzxgFztYYMRwTDMI7AZpH/q7n2Az9w/NeOGOr3/YxowXIYU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LOYP265MB2336.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:121::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Fri, 27 Nov
 2026 00:09:21 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 00:09:21 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 27 Nov 2026 00:09:20 +0000
Message-Id: <DN5K1U7A1D4F.SDTIDLS3S54J@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] rust: gpu: buddy: tie allocations to the allocator
 lifetime
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>, <ecourtney@nvidia.com>,
 <jhubbard@nvidia.com>, <matthew.auld@intel.com>,
 <arunpravin.paneerselvam@amd.com>, <joelagnelf@nvidia.com>
X-Mailer: aerc 0.22.0
References: <20261126221108.3768637-1-dakr@kernel.org>
In-Reply-To: <20261126221108.3768637-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0431.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18b::22) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LOYP265MB2336:EE_
X-MS-Office365-Filtering-Correlation-Id: ebd12d1e-ea9a-4fc8-4e77-08df4c1aaf7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|10070799003|23010399003|366016|261009223027099003|18002099003|22082099003|921020|10067099003|260925022911599003|260925021911599003|260925021311599003|56012099006|261028144727099003|261102123227099003|261026140227099003|261022105027099003|261021121427099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: oeG2vB/1tuKseXmZ5EXXdhc/FA4E47oqOZMVltCrgrd4vER/gKtFbUuGM81fNo0HMwU7gRST4KTl0NE/vWKeGUOTnOpvhGuLOJDmtZu330u/dTg+ocPInyYAB+zqjGHt6YCC28riWA2wiktH6A4F11gHGRHEeJu06vWSnIZ8wA+CfuQapkNZXMhZL+G35GPvrbHK4EyEOMXWBihDFSpgmsykvzqyqm7UdImoeONZqSIxHbJZ8I1+KUZ1U7xUs7VqrIjwt6gwkCk4rO+ysFfqrlUf5HgYUHTME75jOn+EtIT2iFIvjW0C5QGkYxt61IWujzktgwuOFjIDG3caFJBIzzQVjzoop1awq6I4hnwX3qx0ylWK0cNWDnr/2bHI/rureVpagQXCmO/m7qBgUh8BxkIULgA2YWfUo+eqA1U9y7gMslJ3W3v3uCoJEZH3X1tW3PNcz+P5N3hv0FCBR6duiRfs9Db5GYCHEe/ckN1o5YtaQBmwJBOVVJVLJLGgcXyLgkGm6OyLKcE48LIPLu8i2yOfwhSbe2Xa2v/dBMPFHVNZMYeVamue0nI8XVWv8k7cwkZIYtgI2l13x4wnStCY4bm/2cRZoTh8BSOU1GDnTUcfYArHfreuouASc9ThdW2ILHpXxlijtjc3ae6A92CZmZYtW4ESFHjrvI6NMbyTTAk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(10070799003)(23010399003)(366016)(261009223027099003)(18002099003)(22082099003)(921020)(10067099003)(260925022911599003)(260925021911599003)(260925021311599003)(56012099006)(261028144727099003)(261102123227099003)(261026140227099003)(261022105027099003)(261021121427099003)(261021123027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UFJ1Qnd1YmVvVktPL21heU41Y1h1cnJLMUROMDVYMUd2Qk9WbmxZSUptVU03?=
 =?utf-8?B?WFFSZDUyS05xVS9RUUNUelpKUjdQV2JFaElsNWlxTWRhdnZteE5uZjZKd203?=
 =?utf-8?B?ZVZkOXRvLzI0OVFIWTNFMUdtck9tVkhMeVpZUUtYZFdMelAvOVcyQ2ZhUDNn?=
 =?utf-8?B?c2IveEhkYUFGdmc1TFdYVDcwZ0RhbTd4cGZmL3RnR2o4Vkpkd2JYS0Vsdzls?=
 =?utf-8?B?VHlNemtrb3JxNlFQelZLSEthTU1yUnlSNytvUFpaZFl3TFpSb1pPcEtIeGRr?=
 =?utf-8?B?c0Y0citkc09JRkQ2UStIVnJEY0lCbldza3oveThtVVNUL1VMdUp6d292ZjUz?=
 =?utf-8?B?d2VFc3lteXdoOVJnUnAwQVA3c3ZPNllKdHk2bHprcUdXaTk1dytkTDJCQ2tF?=
 =?utf-8?B?NVAyUDBtbWZORXRVNHVLc25zbG9UNnp0dnRhQmpRaVQxUFNxSXpxYWxEeWJY?=
 =?utf-8?B?L0p1anpIZCtRem56STRqQi9ubEh0Z3NyWDZNMHJLMVB1NTdBL3hJTllhc1pZ?=
 =?utf-8?B?U25ta2ltek5YZDFxQzBqN2Fya3FERk5nRnFDcDhxeG1lMnU4dUFIZ1NIanhZ?=
 =?utf-8?B?c3ZzQUc4TGZLZGdwQ0lSMElValNubXdJYTROaGh2eDROaXFEZGFBb3NYd1lx?=
 =?utf-8?B?TGNSbTQxRUJ5eFEwaTZGbFM4RXgvY240cUtOVWVqb3FjdjRqZVVlYVlzZXZ4?=
 =?utf-8?B?K2ZSS1YvRHdEcUxnbThPdWhYMWZ4L2w4UjJvOU16dUhjQTZhZGdzWHU3MURN?=
 =?utf-8?B?RnVnUCtoMEF3cVhnWXRWR3dRSFdMdmF2bnNBWENyLytNMGd6cEN1VUFSQWVm?=
 =?utf-8?B?Z040anI1emFKajhYNGtvYklvN1R2ZFZHVnlnNEYzVExOR3J6OEh4bkM0eXph?=
 =?utf-8?B?TmFNWmoyZGk3aTJuMCtZTXR3dng2TU1jOUtTSytFVHRQWDRnODNXQWo3cmNK?=
 =?utf-8?B?dFZDa1dVRFQzbTJsTzQxSU54VFRDZ3JkU1F5N0hMWjZXOWZuOFN0eThhQVZ5?=
 =?utf-8?B?SlRCdXZnRk53c2N4T3JTQmRrNG1WcXQ3Ync3R3dWS3VvalRSUExhWTd3aTIz?=
 =?utf-8?B?Z1V4SjQvUkRGbzkzSkdac3hmYlV4SE1Jb0E2SmdhUlpkSHNFM1ArVWpzUllQ?=
 =?utf-8?B?TEZrVUtkVXlLUmxlM0VDd0N0cmNDTUxTL3Q4ajVxN0NXMmVPWTljd25kOGRD?=
 =?utf-8?B?cWZ3K2ZEaDdySTQrTkJ4RGtsYzBsMEl1bHVGQjFRanoxMmtackFzd3RHZlFI?=
 =?utf-8?B?QTkzSlpuWThSYmVFdzVjNXB2VmxYMGtqd2ljeTRJTUJSVVRwUmdhMTQvYVdy?=
 =?utf-8?B?U3NtaHk0dVFaL2VoaURVUmI4bnM1YTRXWjZ2NjdQVnlGa3ZkZHk1U2MvVUN0?=
 =?utf-8?B?alVhZWlnWXpNYzA5YVVCRVBBQjFabkZQS2pEWUZ4UW82VFR0QWFWeFJlSXZi?=
 =?utf-8?B?TytsU2VPU1F1cEdyaDVpUkFQRis1OGgwR1hYdktzWjhVaEx0aWVROHpOS2du?=
 =?utf-8?B?SlV0NlZ5WWIrZWRDTkM2azU2K1M5Sm0vSUlDY1Bwa1g2dFF1ODYzeFF0QmE5?=
 =?utf-8?B?N1h2MitiYjN1UkVnc01FWno2VmFTVStpejNPN0FLWURHd0ZWTnNCczZVYU9K?=
 =?utf-8?B?L3ZVUXJHQ0N3N3NzZ0cwU1NKQlZPbCtkaXpGYlRYN2pmMzcrOVBKRDlFYTdz?=
 =?utf-8?B?Njg3a2dSMFNWU2tXcG9pVE5mL2I1ZVptVUVrN1JkcERCOWIyV2tEMmN5dWN4?=
 =?utf-8?B?R05CUXgxNFZWVGQxS1NxaEJMZi9oQ3lDT2pGWTMrLzNDTXZmWWFkT052V2dC?=
 =?utf-8?B?UWJCUyticnBaKysvSnVCTDV3L05JMlEzM3doYVlsQzRaYWhWa3dFQXd0bndv?=
 =?utf-8?B?Yzgzc0dHbDBBcUFzREd4U1ZVMFBxbzludFRzOS8zd1E5WkoxKzVjQk1xNWhv?=
 =?utf-8?B?UDVKaHVhN1poTzFZN3ZBakc2ekVQNmNQdCtlL1ZEaWttMjBoM2Q0aXNKcnFM?=
 =?utf-8?B?ZVJEQ2lGemJVT0c2UmhpVEFidWtzUFZYVVZTSE1OU1hPYk5FWjR2L3lVei91?=
 =?utf-8?B?b3J3dmI5aTNGVlNxUGpYVHhmNEVpNlhEZzk1eGhoemJUZlpkWC9nM21iL1RW?=
 =?utf-8?B?VW10akF2akxKR2lxVTc3bGRGTVlJeWNIVjdQaEVVd29hUVBkRHRmdzVRdWE0?=
 =?utf-8?B?bGdQaFBZYnZpL2swZjYyRzU4bGM5Vmx3QW1oUGwrQ09yZllmcVdxKzlkTUVK?=
 =?utf-8?B?YWJaVE5UTTlhcmp5OEhIdVhXcVhkUEFOblArdWx5YU1vTGFDcmdKcWFpQTdr?=
 =?utf-8?B?NDVFNGc0QVVtQmdpdzVOVG5Bc2szaTJWTUMwY1BaTVNHeVBnNXNSQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ebd12d1e-ea9a-4fc8-4e77-08df4c1aaf7f
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 00:09:20.9299 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MR8wBzkkWXGSCZUS4TKGoSkYrxNfbPz0GRPKhh7kaDBkRSqxNooTe1uaSxztt4Agaw7nXlkD70wg4HxlWqDLLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOYP265MB2336
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu Nov 26, 2026 at 10:11 PM GMT, Danilo Krummrich wrote:
> Let the allocator's lifetime constrain the lifetime of its allocations,
> rather than having allocations keep the allocator alive through
> reference counting.
>
> This also removes an unnecessary allocation and allows GpuBuddy to be
> embedded directly in driver private data.
>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
> Depends on [1].
>
> [1] https://lore.kernel.org/nova-gpu/20261126213652.3716162-1-dakr@kernel=
.org/
> ---
>  drivers/gpu/nova-core/driver.rs           |   2 +-
>  drivers/gpu/nova-core/gpu.rs              |  51 +++++----
>  drivers/gpu/nova-core/mm.rs               |   9 +-
>  drivers/gpu/nova-core/mm/bar_user.rs      |  20 ++--
>  drivers/gpu/nova-core/mm/pagetable/map.rs |  43 ++++----
>  drivers/gpu/nova-core/mm/vmm.rs           |  12 +-
>  rust/kernel/gpu/buddy.rs                  | 128 ++++++++++++----------
>  7 files changed, 147 insertions(+), 118 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index d6bc972d47c7..f8f5d74d2742 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -133,7 +133,7 @@ fn probe<'bound>(
> =20
>              gpu <- Gpu::new(pdev, bar, bar1).pin_chain(|_gpu| {
>                  #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
> -                _gpu.run_selftests(pdev);
> +                _gpu.as_ref().run_selftests(pdev);
>                  Ok(())
>              }),
> =20
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 2f0399100885..65290cedde11 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -1,5 +1,10 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
> +#![expect(
> +    clippy::multiple_bound_locations,
> +    reason =3D "pin_data generates additional outlives bounds for the bo=
rrowed MM field"
> +)]

Please use `allow` so it won't cause a semantic conflict in case I fix it t=
his cycle.

I'll take a look of the rest later.

Best,
Gary

> +
>  use core::ops::Range;
> =20
>  use kernel::{
> @@ -383,7 +388,11 @@ unsafe fn new(
> =20
>  /// Structure holding the resources required to operate the GPU.
>  #[pin_data]
> -pub(crate) struct Gpu<'gpu> {
> +pub(crate) struct Gpu<'gpu>
> +where
> +    // Hide the borrowed memory manager's resource lifetime so `Gpu` rem=
ains covariant.
> +    exists<'gpu_mm>: 'gpu,
> +{
>      pub(crate) spec: Spec,
>      /// GSP event interrupt registration, and the enable of its subtree.
>      ///

