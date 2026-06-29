Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2FAAC43327
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 07:37:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DD6110E737;
	Mon, 29 Jun 2026 07:37:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="LJ2Xf1tH";
	dkim-atps=neutral
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012018.outbound.protection.outlook.com
 [40.107.200.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCB5210E72E
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 07:37:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q3Xc8ogqDgOgwNllmGFi4skNGzsrZOD2642X4HagjqX/8exJPmh0itKcDjSc31CgCWNx/WnzR84uAB6lNoZyGMNiNvWYZgs6DPsl6GkK1rlnfvbdiZztEg48t+n8fP7SIK/YLiBz/6iKQljJTRM1EtWJBlJHNavWtqMi+INGLdl13YfhKiesVFOU6lEmRGGyrbnpnXCw6mBm6nD7s0Ip0S9qn3jeDdWDYP0eDR1dX+XUX7MoetlOgBgIvqzbRZ4F9Dk4Ob1dLekimduInBIHB5iFaaKvdTph7T8A2PiNMIZ81Ym4pLmPCNRV90iBqmB4j8AZgX2wJrZ8+LlhwaAYEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hjeoBFDxo64/UMnywcPePEk0o0Sqjtlw4iQCm2hkV6w=;
 b=uFcXH50wJj3h9s6RX6iFMuBmJ67DSYwE2nFYr46EQcZyH02A7x/99D6yMxNOUJKRPIJ8fUJAsD+cVgPG8y3fnSTAOm81CpDbP+fmUPh8vrmgArFPr94gTaNUhiyirpQYdColuuyxMgQqIGTvlliSXcdYWIZ5onpZ5apAalbsPhSonJPw0yT0vi9XZ2YTfN2urA0/nDcSTk7UqRLCRHBGXUuidt2S6Zbikk1vQQNYtXBGuv8rvjJpNvlfmbkx211tzdVpYhmZ4KDsew4E5Y+i6L4EKmjOU4SxJ6OAcfyJS1VHkyhKlem4TuKhA58uFevfIMMwRhT4g5n+isqH0sO+lg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hjeoBFDxo64/UMnywcPePEk0o0Sqjtlw4iQCm2hkV6w=;
 b=LJ2Xf1tH/D/VtlXhPxYB/eip1Qsx5g4UnigWRO+Fqa49QrDZlOsy2tzj8kBwGMU1lgXcGtiAK7r59AN01rSA+t6FAd/JFXz6BAkknqd4+s+tQ9UM2pPTxoUFsH5aDNG8LnRjYNg9WusSZrE1a7XHnDYQxFdZvRJdjEpixj+G1xzPSAeDfRDkhJh0bz6IK0qNC6j1TOT05bXbg+O3HEv+4GLYN2B6UhB5XIRJymF87B5PTM3PomQqQWwJOjFv9UM5RMiQ5RL2otml+yukDlqiLCq1rHNzAQT1SgB2gSfTp5fZWEF+OS0cPLgKVCM1FfipuZPTzwZtO3ZoZj42d2cUPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by PH8PR12MB7328.namprd12.prod.outlook.com (2603:10b6:510:214::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 07:37:02 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 07:37:02 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 29 Jun 2026 16:36:58 +0900
Message-Id: <DJLD0BCHI6LK.20SNCG6M3E1D1@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, =?utf-8?q?Nicol=C3=A1s_Antinori?=
 <nico.antinori.7@gmail.com>, "David Airlie" <airlied@gmail.com>, "Shuah
 Khan" <skhan@linuxfoundation.org>, "Simona Vetter" <simona@ffwll.ch>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>,
 "Tamir Duberstein" <tamird@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Pedro Yudi Honda" <niyudi.honda@usp.br>, "SeungJong Ha"
 <engineer.jjhama@gmail.com>, <linux-kernel@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <nova-gpu@lists.linux.de>
Subject: Re: [PATCH 1/1] nova-core: Update firmware bindings to use zerocopy
 traits
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Alistair Popple" <apopple@nvidia.com>, "Miguel Ojeda" <ojeda@kernel.org>
References: <20260629025220.1935622-1-apopple@nvidia.com>
 <20260629025220.1935622-2-apopple@nvidia.com>
In-Reply-To: <20260629025220.1935622-2-apopple@nvidia.com>
X-ClientProxiedBy: TY6P286CA0009.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b8::7) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|PH8PR12MB7328:EE_
X-MS-Office365-Filtering-Correlation-Id: ff413ac6-6b1c-4b52-2963-08ded5b13579
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|10070799003|376014|7416014|56012099006|6133799003|3023799007|4143699003|22082099003|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: Wia4pyAh/z8QTIED9ZirSVp7EUkLLBfhBIB7iB4FjueL/tYC+kJmkRp1IISXFpPG8P3cQWLbP5FZbAq/vL0wtCreVvzykjy7DG6Et8UUNUkTuS1CCr0BOoUCQMdqlsB78HWVP1vKvCawnM9t3+6HKf6VifRgETRGbrGKmP9tP5AKOVRZO+iPomP8gI5DFI47Yobk6NineHd2ulbCuT8FWa+I8zvI3S/j7qyOr0LgC3GCsb27qJOhU1nM4atrChsinQ++0mOrsGYkvslvPZkZJ7fdjMbe7tBoE0SigeojUjXMpR9LHnncCrj81QNrReYZzVk3YFqrJ6Z2ayH2u09bL2F8oPwk18OvnasU1+NE9IyE2Z9WN6EC4rJ6/hsnEpQoq+nf1ia/RP3g4DAZLJsVvuqxIpo316FxSg7XUedsw7H4cqk45mfwOdN/YGp/z7rajvEl5u/PaqBp1MCEPK92thtCMpW65RB+8/F4B0qBd6sJ4yNNslLNlPdWnnOhJzREFk9IjqVXMB5vhQyA2NG/9CcRK6eiCdWuOW56jcCneuUpWnfHJfHaoit0ai9jal67YRFDMKfisGH5WJGXzO29DsJ02l9rIr/b84Sp3Kx7tl1hSlwE2UO8y6IvYODx9x0O9xcCJ3EeZn48f424fMGHtXdrGvyXewqQPdIpR5pzCP8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(10070799003)(376014)(7416014)(56012099006)(6133799003)(3023799007)(4143699003)(22082099003)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rkt0cmpMdUlPQ25nU2pXellnd2xyK2tuRnJEdlBSMzdWc3R2M0tGdEJqeXpw?=
 =?utf-8?B?ZnhXYXhjbGdnVUtjNkhtQVBYdzVQWWlNbHJUYUliMjV6NWRLaHF5Y2hXS0ZF?=
 =?utf-8?B?cnZ0Q05sS3ZpTW5FNjNaRXlNdE55MUpmdjFOZk9ZbG5VdGlydHdwYlIrYmJa?=
 =?utf-8?B?R2Q2OVpzdVBCZHorNk5GNVhMVDQ4TUk1OHlLbldLVHRzSTdHQUxWU242RWF6?=
 =?utf-8?B?NUhBOWl5OVlJa2cweXZYUDdraitET1ZZMnU2L2tVRTdVVVY2TGZxSHpzU3p4?=
 =?utf-8?B?OWIvSFRJYkRsbit6ZXZNZzJmK1F0Mkk5bEYzV3B3V2xvcFZla0VqNFFYR1gw?=
 =?utf-8?B?SnV6TDhvbkgybWptVEIvME1lNllONXpPcisydWlIbnJPOGRzTm1pZ1FRVGpX?=
 =?utf-8?B?NnJ6SjhpQkd3b2kyN1NXN0F0YW9vb2pKeTh2M0NHZmhxdGNVTkE3RlllY3Q1?=
 =?utf-8?B?aERlU051TG54NGtjWUF5TE9KNWFZc1kxN0VuSzBLWWpNRGhvN1NvaHk4RGRh?=
 =?utf-8?B?S3czamR5QUJBZzZjZkhjSThJZTRobUh4WEU5ajlWV2lWSkZNR0c3WTY1cEpV?=
 =?utf-8?B?R3lxQmk3TEpMTitKWjBja0IvYTIvRnNwdWNMWXQ0ZDNzdkpEV09CWGpmU1JS?=
 =?utf-8?B?a3RvbW1XZ1VQOWdMV0UwZTEwZVJnZmhQL2d0bGlZZ0Z0ZGdkV3ZMVHUyMG51?=
 =?utf-8?B?cWNxNzNQb01ZTUdJZzFCVHdsVWpmRjR5U2dwREVQSlJ0ejBXdGsrUExpYVlZ?=
 =?utf-8?B?Q25iRHlKYWNZbnB2Y05udFZpQXdwQlJNdGVsVVBhRHlPZ3NEMnBFZTh1TlZP?=
 =?utf-8?B?YS9JWTl1Vi9HUHBHYVBaNDY1SmgvaFdqZ0tUV3BLV2Qrb213VzFpNjNoOWs3?=
 =?utf-8?B?NmNWWVRHUEVoK3hCeG1QV1hZclJSVUZwY1lrRTROYStOMW5EdVQ2Z1VxMDJE?=
 =?utf-8?B?dHdCNERIKytUWXQxUkRZN3V0STRQTGVXYXA5UVdqUVU4VEhzdWdNZ1JvbG5V?=
 =?utf-8?B?WHV3eWhTS21ocnVieWxqS2ZDeW1vc09FRjJzUDFCNVdCclUrOXhENnMwWGoy?=
 =?utf-8?B?NjFsdWh2QnFZWHNNb3JsUkJFVmMwWFN6VVhvS3pONkN3MTdIaHAzdEtxT2g4?=
 =?utf-8?B?UGdLUWtQZ01pcjduK3BZQjlPWHA0dk1QUlRxMUZhN2hobG5PbWgyRXFjU2dU?=
 =?utf-8?B?UitXMjFrRmpsbWUyczRVbE1aS1Nnakx4KzEyTlBUV0JsR0hJVHh4WmFvM1JK?=
 =?utf-8?B?MXlLQ2Y5d3h3NVl6MDBVWnAxdXZURHVPbWxobXJ5N0Q2VXhNTlYyOVQzNzVv?=
 =?utf-8?B?SjBpbTBKZXY2VDNubThqKzR1UUEvSlV3SzFrV1BPdkljVmJJSXpXcjVSQ0Zk?=
 =?utf-8?B?Vk5Tbk9DdktwVit4b20zaWo0dW5qTkV3QXZDU25raGF3NVZjY2F3Z1M3d2RU?=
 =?utf-8?B?eUowdFFjMXMyYjhHRjRuYlFjSXFWT2ZGaU9TWWE5K0c4aEtKeThUODlrLzU5?=
 =?utf-8?B?Yjlxc3J1bWpwSWR0V3NkYVVMUlRhMnRDTUhTUGRBem5LL3p6Ly9vVHBiUllG?=
 =?utf-8?B?SXB5Y3JnUERiQ0cxWW5QN3FEQ3VqQkFQMUJpcytvb2g1NEVPK0txcndPS3Qx?=
 =?utf-8?B?d25KcUp4Ny9McWIyd1RlNjVjYkhnVUt3TmJicFpteDVYeDNielBTQUlWWjgy?=
 =?utf-8?B?Ny9SeHlVMndnOTdZQ01HQVY3b0xOT3ZubGx2aVlSL2hZOENDcmc4Q1FsZG5n?=
 =?utf-8?B?WDU4cWtRbmZwWWdTcTNsOGpIb3hUMnQ4V2pIWUJUN0tuRXBNZGM5V0EyeDdG?=
 =?utf-8?B?d0JhM21aN3lkVjIrNk1URFdTRXloS3htZXZqL1NkdHg0UTJ1K2ZGV0ozbzgr?=
 =?utf-8?B?L3k4dlh0UVlyWHdyU0V1R1U3VGRuZUdrQ3FTblpOU0dPNlpkVkRUOEFSekp1?=
 =?utf-8?B?SXRxaXZPTE93Q0pUWitKVlhmS0ZQZ21lRktMZEpBa3dMSVNGWCtFQVAwbVBT?=
 =?utf-8?B?aXhKaEYrZ0FCbi9BTDUzcC96MVh3WThiM0N0SVdpT2VuM3J6eXdDUHdaZ3pY?=
 =?utf-8?B?V1huSnZ3WlFzaXZaL3NhOTFXd0dHb1ZQbkpiWllrRm5xUmFyZXdXcldBNHIr?=
 =?utf-8?B?WE5zRWtQOE9kRTBxR2hROVMvK3pKMmhMSjMyRUpLd0lJWjZNak5EQXRMZ0lp?=
 =?utf-8?B?cGJNaG1qQXVBYjZLc2I4TEtpOUUvNUcrMk1sZC9UZ3FmWDlPTlRxQ1dYb3Nw?=
 =?utf-8?B?b3NlaHVZZW83cTNBNWFZVTVOYVd3ZU1KREYxdGllczZ2U0tDQ1VSdTFiWThY?=
 =?utf-8?B?MWQwMWRXWDBnQ0lGTVlMUnQrdHVycWRmQkxuVDNhVkxjNDBKMFQxZVJPQTZj?=
 =?utf-8?Q?Tfwc4WIYIc09CEZzf9kwGjfgJnOj2m6KtAg++pIaI2Gxz?=
X-MS-Exchange-AntiSpam-MessageData-1: G5Je8WxKR9lKzA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ff413ac6-6b1c-4b52-2963-08ded5b13579
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 07:37:02.0772 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /50IcJhah18aE70gBqc9OegOCptTkHWydx20IeyXV2c28Z+l9umcfAB4vqdyU/oU5C4XIz2+dLzho92sQi3WMg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7328
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

On Mon Jun 29, 2026 at 11:52 AM JST, Alistair Popple wrote:
> Currently most of nova-core uses unsafe implementations of AsBytes and
> FromBytes in order to read and write GSP commands using the generated
> bindings. Whilst this is generally safe in practice there is nothing
> that actually guarantees or checks this.
>
> This is exactly what the zerocopy library was introduced to do - provide
> compile-time checks ensuring From/AsBytes is safe. Make use of these
> checks by converting all our generated bindings to derive the required
> traits for the zerocopy checks, removing many unsafe implementations in
> the process.
>
> Note this does require the use of an unstable feature - trivial_bounds
> - as some bindings end up needing to derive zerocopy::Unaligned.
> A work-around is also required in the bindings to make some of the
> __IncompleteArrayField<T> ZSTs monomorphic as the check macro can not
> prove a generic type is aligned and thus forces T to derive
> zerocopy::Unaligned, which is not satisfied by all types.
>
> Signed-off-by: Alistair Popple <apopple@nvidia.com>

I have counted and this removes 28 unsafe statements. :) (it also adds
2 tbf)

> ---
>  drivers/gpu/nova-core/Makefile                |   4 +
>  drivers/gpu/nova-core/gsp/cmdq.rs             |  21 +-
>  .../gpu/nova-core/gsp/cmdq/continuation.rs    |  16 +-
>  drivers/gpu/nova-core/gsp/commands.rs         |  19 +-
>  drivers/gpu/nova-core/gsp/fw.rs               |  54 +----
>  drivers/gpu/nova-core/gsp/fw/commands.rs      |  50 ++---
>  drivers/gpu/nova-core/gsp/fw/r570_144.rs      |  41 ++++
>  .../gpu/nova-core/gsp/fw/r570_144/bindings.rs | 185 ++++++++++++------
>  drivers/gpu/nova-core/gsp/sequencer.rs        |   5 +-
>  scripts/Makefile.build                        |   4 +-
>  10 files changed, 223 insertions(+), 176 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/Makefile b/drivers/gpu/nova-core/Makef=
ile
> index 4ae544f808f4..27a5752c4cf9 100644
> --- a/drivers/gpu/nova-core/Makefile
> +++ b/drivers/gpu/nova-core/Makefile
> @@ -1,4 +1,8 @@
>  # SPDX-License-Identifier: GPL-2.0
> =20
> +# The GSP firmware bindings derive zerocopy's `IntoBytes` on `#[repr(C)]=
`
> +# unions, which is gated behind the `zerocopy_derive_union_into_bytes` c=
fg.
> +rustflags-y +=3D --cfg zerocopy_derive_union_into_bytes
> +
>  obj-$(CONFIG_NOVA_CORE) +=3D nova-core.o
>  nova-core-y :=3D nova_core.o
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 0671ee8a9960..6e79ec688983 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -29,6 +29,14 @@
>      },
>  };
> =20
> +// TODO: Remove `as` once FromBytes is removed completely
> +use zerocopy::{
> +    FromBytes as ZCFromBytes,

Since zerocopy's `FromBytes` is the one we will keep long-term, should
we rather rename the one from `transmute`?

<...>
> --- a/drivers/gpu/nova-core/gsp/fw/r570_144.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/r570_144.rs
> @@ -23,9 +23,50 @@
>  )]
>  use kernel::ffi;
>  use pin_init::MaybeZeroable;
> +use zerocopy_derive::{
> +    FromBytes,
> +    Immutable,
> +    IntoBytes,
> +    KnownLayout, //
> +};
> =20
>  include!("r570_144/bindings.rs");
> =20
>  // SAFETY: This type has a size of zero, so its inclusion into another t=
ype should not affect their
>  // ability to implement `Zeroable`.
>  unsafe impl<T> kernel::prelude::Zeroable for __IncompleteArrayField<T> {=
}
> +
> +/// Monomorphic version of [`__IncompleteArrayField<PACKED_REGISTRY_ENTR=
Y>`].
> +///
> +/// zerocopy's `IntoBytes` derive can only run its compile-time no-paddi=
ng check
> +/// on a concrete type; for the generic `__IncompleteArrayField<T>` it f=
alls back
> +/// to requiring every field be `Unaligned`, which `PACKED_REGISTRY_ENTR=
Y`
> +/// does not satisfy. Specializing to a concrete type lets the derive su=
cceed.
> +#[repr(C)]
> +#[derive(Debug, Default, FromBytes, Immutable, IntoBytes, KnownLayout, M=
aybeZeroable)]
> +pub struct __IncompletePackedRegistryEntry(
> +    ::core::marker::PhantomData<PACKED_REGISTRY_ENTRY>,
> +    [PACKED_REGISTRY_ENTRY; 0],
> +);
> +impl __IncompletePackedRegistryEntry {
> +    #[inline]
> +    pub const fn new() -> Self {
> +        __IncompletePackedRegistryEntry(::core::marker::PhantomData, [])
> +    }
> +    #[inline]
> +    pub fn as_ptr(&self) -> *const PACKED_REGISTRY_ENTRY {
> +        self as *const _ as *const PACKED_REGISTRY_ENTRY
> +    }
> +    #[inline]
> +    pub fn as_mut_ptr(&mut self) -> *mut PACKED_REGISTRY_ENTRY {
> +        self as *mut _ as *mut PACKED_REGISTRY_ENTRY
> +    }
> +    #[inline]
> +    pub unsafe fn as_slice(&self, len: usize) -> &[PACKED_REGISTRY_ENTRY=
] {
> +        ::core::slice::from_raw_parts(self.as_ptr(), len)
> +    }
> +    #[inline]
> +    pub unsafe fn as_mut_slice(&mut self, len: usize) -> &mut [PACKED_RE=
GISTRY_ENTRY] {
> +        ::core::slice::from_raw_parts_mut(self.as_mut_ptr(), len)
> +    }
> +}

Yikes, this is a one-shot so I guess we can live with that if neeeded.

> diff --git a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs b/drivers/=
gpu/nova-core/gsp/fw/r570_144/bindings.rs
> index ea350f9b2cc4..9c85c93f6eee 100644
> --- a/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/r570_144/bindings.rs
> @@ -1,7 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0
> =20
>  #[repr(C)]
> -#[derive(Default)]
> +#[derive(Default, FromBytes, IntoBytes, Immutable, KnownLayout)]

This is the part my other email [1] was about: are we going, long-term,
to replace this with a `#[derive(zerocopy_derive::most_traits)]`? If the
Nova's bindings generator program can take care of producing the correct
traits for each generated type then maybe that's even better, but at the
same time I am wondering whether the kernel's bindgen invocation isn't
going to automatically derive `most_traits` on all generated types. In
this case, we could end up with duplicate implementations.

I think this point needs to be clarified before we can decide when to
merge this patch.

[1] https://lore.kernel.org/all/DJLCF3LR0KMN.1TMKMZEZWKN8O@nvidia.com/

<...>
>  #[repr(C)]
> -#[derive(Debug, Default, MaybeZeroable)]
> +#[derive(Debug, Default, MaybeZeroable, FromBytes, Immutable, KnownLayou=
t, IntoBytes)]
>  pub struct PACKED_REGISTRY_TABLE {
>      pub size: u32_,
>      pub numEntries: u32_,
> -    pub entries: __IncompleteArrayField<PACKED_REGISTRY_ENTRY>,
> +    pub entries: __IncompletePackedRegistryEntry,

This is part of the generated bindings, right? How does the generator
program know it needs to use `__IncompletePackedRegistryEntry`?

<...>
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -314,10 +314,12 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>  #   - Stable since Rust 1.89.0: `feature(generic_arg_infer)`.
>  #   - Expected to become stable: `feature(arbitrary_self_types)`.
>  #   - To be determined: `feature(used_with_arg)`.
> +#   - Required by nova-core's zerocopy firmware bindings, whose derives =
emit
> +#     trivial `where` bounds: `feature(trivial_bounds)`.
>  #
>  # Please see https://github.com/Rust-for-Linux/linux/issues/2 for detail=
s on
>  # the unstable features in use.
> -rust_allowed_features :=3D arbitrary_self_types,asm_goto,generic_arg_inf=
er,used_with_arg
> +rust_allowed_features :=3D arbitrary_self_types,asm_goto,generic_arg_inf=
er,used_with_arg,trivial_bounds

This also might be something that will land soon through the Rust tree;
Miguel, do you know what the plan is by any chance?
