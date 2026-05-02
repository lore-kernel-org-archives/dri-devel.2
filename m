Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FD42CD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:42:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F062E10E299;
	Sat,  2 May 2026 15:42:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="stoNY0Y6";
	dkim-atps=neutral
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010026.outbound.protection.outlook.com
 [52.101.193.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F0A2010E299
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:42:23 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QG1EORFH6mQnV5oxcHck7w7jY725xEfIjoelDmr6eOGzHy1x1PZbGmzGli5+9MIfiwY3NJqeaFsy/Mx3eIl59khVAsYl73zdNQckFXHUHfwvVF3KhCnFXWKWOjEfVzf/57JfcxYx6jZADCWp4EoZtGtL1Fd9HsOw7YdfWmiAhf1Lnl/V3RYENRDgZTLEUNbPXhWWmbxRoBVQEM6fSwxGGALANJ2ZX7sOZPYd5yfOmXNImBZnLtLrj1xZDZQaQtiIZk6F9LS9dFG2etPea2pVQiRAArrAyaHAuU3klmBFPBCCm64wOr+x9pgiyzKgpyvL6xa7JAtNk6/YB3oG4YFUOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rmEoMjaGPhMrDDlQ+KmAWFOZ+ZVmnylI3QiGKMXfQRc=;
 b=K3z/4p5G3N89Mvs3TdZZtl9bHytH6hUW04jceZXHXTJz3bNkKa5xZQrqctKcIHOTHX6gYkOGq5lk3NZ6nBNnTBNh3t/QaJS1MemlmFH8oI37KhyiJcUEooCeWEMu4NnBGjwNrPuX4cjYr3MRy6AqSIf8ZH6xOyIxagTWO/9SSJFMlUcN1rlJEtScCyqo5TS6mCQaNoPBufZvTBcJCktukWVMSuPF0JmUIMipbHcFJKfoT2N3AqpU7k5SwDU9zLBZP4X8xitZzJVM9zc5rWCMdNfrKAoTu7ijs050f699+oA3h6ZSTHuiLRqmTU/rSHFBiPmNuiX7B0apiTQPQTnyvg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rmEoMjaGPhMrDDlQ+KmAWFOZ+ZVmnylI3QiGKMXfQRc=;
 b=stoNY0Y6Ufol7XsnHQATGJE2if8LkvF1U3rV+ZOYxjONtNM3LnnIYPrDn42jtnIctx3J72/3+5sjW3Hf1q9i0BZ0YA1nUjBxTeJZCp0B+v7LCiDnrKvTNAh79NEbQw/tsHe/zXzUAHvTGBe0LY0CxcLYeEHfiaDNAm4PTRkg1tljKN+vsc7Wqnq+GOH4IIJPu+VLh2qB4afO631zm9ocgky8nnwHJJoJmHJmgL9HV90N17UKh2fQ6/nk9OXI/Hy8G9udl8C/od8yyJMR44aIAEYWXtzbc90Khw7RbmBNKMu/zpnT6Memeaf6QfoB9Yt7xRhgR4H21NsB6dfcxt1/nw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:42:17 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:42:17 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:42:13 +0900
Message-Id: <DI8B094FNUYM.3MA4K3VXN53NV@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 09/22] gpu: nova-core: mm: Add common types for all
 page table formats
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-10-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-10-joelagnelf@nvidia.com>
X-ClientProxiedBy: TY4PR01CA0051.jpnprd01.prod.outlook.com
 (2603:1096:405:372::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 3691eec4-9bbb-4472-72f9-08dea86163ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Pl4qxNcPulGR9JriVSycoOXQvgcbElZMtE9wSYkkQtL86ISeVwTIfSaJiHFxyMXoCNbPincLJSF5TGe3kYyfDyv9NoCf24obg2NnGhyp6qtLUI2N3hDN2hhlG0phE8H4Lu6IxzZ2hiY3qKbKzBS+55YLObRW3uEdiOJc06PgTQaaI31/vT3KiALSfZZkYfcb5YAl5V9DhLgfZpWbCwlcaNp1yId5aG27840QJJVe9x960uI/nOox1pVcVxGZQGAjPhpFWmw81MQPET2Zes6fEYQFpNgCWoFHQop9+6VhsvqWIc5p+oYS2wNr/oH8EiW4zK+MyzQB9IUCj9LRnRdyGIZ7K3/ewUEUOeac1DVEXAL+477RvSm3L5MICagSWRWuxqSxzahK50Vq6VupKnkqSFpuw9Ayaqkyxd9NeLCAKreDMon/KJiTW1JIUenkk0G2Q9kRVVkPIcHZ1en8u5PwmdTRhWr6jSMoMnCE2fcrVmFoLPEKmvd/6Xrmthc8Wgn0vnQT8+cjneJ/yvmk721DV5+u153RMlovM43EHJ3BS0jwkxMat86mvPdNLUhOARtPUcZxWY2XVpiMV2IlET2CQ8aCErY3lQWbkX5+Ks80S9pISDqoN9Q8Fr7O5vZ3kS+hDuckVHnh4YWuUYGSc/VeqxQSqe3vWZiEAJUG5g//XPESrlK03f24uF39JIAEIw1j
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clVnSTAvSW9PVUxZMjczM0dYdDB1VHkzUWFYYlUveExLY2FHWUsxZU1WQ0x5?=
 =?utf-8?B?aUpZcVUvZGJMQTNDN3B6REthMUtLZWQyb3NTekU0VG1HalZ2U3djZXFydktI?=
 =?utf-8?B?Vmx2Tk9tZ090cjVhTCtISlR4VTZOTWZtVzhMMGxqOXFHYzFzUHo5ZmwzS2pu?=
 =?utf-8?B?WlFxUFo3R0V1QWF3ZHg0cFd4ZHNwYU9zZS9xZmZkS3R5bXBZRElqTDhCbko5?=
 =?utf-8?B?VFdSTXRDZ1hQQ0gyK2lRZnlzUkdBUzhlMFJpTFlsUWoyVmVReGs4cmw3UjV2?=
 =?utf-8?B?bnFnRm81aUxnVDU4dEFGNFBxbFBJeVczWHdyVWxtZ2pzbDNKWjQyWTdPQThi?=
 =?utf-8?B?VWhiYTZjVUxVVllUVEJVU2RDRGRZaWdxTFIzczJMdkt1VjJEK2FBYnRxN2ty?=
 =?utf-8?B?QWdyQW9UU0RqcndOV3NEcFZQNlZZanhVekp0YW1sRTY4WGw5MU1TMU5EWGlx?=
 =?utf-8?B?VGthcnBwOEtEd1NqNCtEbFlrejZpWTVYWUtLbkNHQnIrN3pGT0ZUdHZmdHRv?=
 =?utf-8?B?S1ZrU2dvUm52VjZ2b2R4UGkwUUJKRUFNN0tjakRVeklFV1N1ZmtqckVMUVpC?=
 =?utf-8?B?bStHaHV0L2g3eVR5VlV4ZWxwcnl2N1E5ditYUkxXSkNWN0Z5blp1dXNQeE5W?=
 =?utf-8?B?Ky9qTFUvM01MZGlOZitaNTc4VVI1dHRET08rMDUzeTJDLzkrQTBKSVFVL3pR?=
 =?utf-8?B?bUNOVjBUY0dzKzRkUkdmU0ZDMTh0dXJnQlJSSnl1d293c1JyY3ZqSVFlUDJm?=
 =?utf-8?B?bUZGN3RTQkFDVWFDWXR1VUY0cU1CRkN0aFdMRjRsa3FObk8vMkpOVWVsbmFm?=
 =?utf-8?B?Q1d6QlhmMDcrdlFOdVpycG1ncm5FcWY4b2ozV3Jlc2t3ZWl1QStlUnBSSTNY?=
 =?utf-8?B?ZnJHOXRvSXJTK0hiWjN2T1JNSGpwSjZXU05OdGhyc3grMVpQYzhVS0pFaDdL?=
 =?utf-8?B?cUR2NzE0c01jUUZ1WGZjRlRZNGJEUWI4YVlBKzhSbjE1RWZVc1lPcnZTT0lR?=
 =?utf-8?B?bHVuSUpNVGU3Z2JkTHhCWlNuR1hSQ2MweE83SHJOOHNzZThTSHh2T3dTeUQr?=
 =?utf-8?B?eXpabCsxWGJSbi9HaU01QUZKY2tLSG9SeTU4TTh6ekNOV24zT2J5WSsralFC?=
 =?utf-8?B?TlQzZ0VMNU1weE5JMFpBS053c0R4cGdaVUdZV2lOTE52bVd3ak9VcHBmWDhC?=
 =?utf-8?B?OXE2ZmtyNDdzbDR2bjdMb3hGaExNc1VzZDA2WVovSzVXcXoxZlFxYVpQamxk?=
 =?utf-8?B?VXBuMkNUbHVzcmFlaWdhOTFJQzdLNkpJMUZXVTNTNjVCOFdKRVNSR3N3bitX?=
 =?utf-8?B?cUZuSUkrZ0Z4TXRQZ0ZzWVpiZ0I3NDJJRysycGorY0lqVllPeGVHWWFNdlBH?=
 =?utf-8?B?dEhyWEtiU3RPNGFpU0U5OTF4YmZVMlN0VmhmYlFsL0JVanBOQmk0Q3hxbFRW?=
 =?utf-8?B?SStYR243alM2aDZMcTVWQUkwN01HVHQ3T2VXQ1pLYkJsVkV2TzVsNHg2bVdo?=
 =?utf-8?B?QmUzU1BYaDFWVk4vYUVTTnpOcE50end0MmYvdVk2S09MdGxLM0JoQTJnVHNF?=
 =?utf-8?B?TXZEZ1djNG1Sci8xZkwzNmhrbG5oL3FJNEx0a2J2eGtDRDBnQ3FLUkptYnpz?=
 =?utf-8?B?Rld1eHNnbHp1UzI1b0pqT2lNK3RYei80empGYkhNdnBPMFpLQTlLK1dldm1Y?=
 =?utf-8?B?TU16a2liOXBKZW9ENXArRWdnV25wVmdlbmtVT3dETVFkdGRHeGpUaEFVQUpX?=
 =?utf-8?B?bkhyMHp3WUgyYnk5SWhJZkROQUhCU3RhSFNodDlJSFdwT0hqRXYzTnduQzVw?=
 =?utf-8?B?L3FEK0UyOUQ3bTRycEpIQkUxRjAwWFlRS01KWWFiNWN1K3lYOXFWQmRMVlps?=
 =?utf-8?B?b25CM09jR2dsQWtubU9TRFhmV2R6QTNQd3V0RTVyMlVmT0gxZDlnVm5kODJw?=
 =?utf-8?B?R2wrWCtsRk1PR21PR1ZMcHU2a0U0dEwzcEVDOFdSZ0MvZFVIZEg4anhlQnFk?=
 =?utf-8?B?NHNoOGpZNGNKSUpGVGlwZmxSaU5lc1M2QUNLN3NYdWY2TThSL0pTWUhGQXpE?=
 =?utf-8?B?WmlnZVpGN2hmc1lDSE9zVmdWMHZZeFVEVHJvNTNyWTg0MnM2NjJ0YlVlc1pJ?=
 =?utf-8?B?VG44WnN4MWdtOWd3TmtpMjI0OVdsVW41K2tlanJaVnVQZHdnQXArRHNPUUkv?=
 =?utf-8?B?dytTNlNMNVU5ZFNqU3JHNndjOE5NR05HMDlBRFVHNzhKcmNkZStBUmVUdU0z?=
 =?utf-8?B?T1ZjRktlYjEvWlNWbjYxT25TZWs3UHcwRDYySzIwNDZBUnB5dGoyZTB2MHRR?=
 =?utf-8?B?MGlhaWp4ejJKMkphMXc0YjRieFlBVXI0VzhzUU4rWGZuOSt3RnY3QVRnWWRi?=
 =?utf-8?Q?mTKOE7TP4+mv+gDg/tE1d7BQmc4zg3IGPJxUYzzuwMkrg?=
X-MS-Exchange-AntiSpam-MessageData-1: YqIv57injsbZ4g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3691eec4-9bbb-4472-72f9-08dea86163ac
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:42:17.2743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vzdDskPeHrkeh6qSjJVQGOlQ5Bdswll9BmcA8AGlJEKOt5JS6F9+FP2XQjreazb/UY4mdSMHTmKWobdoO7hKeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
> Add common page table types shared between MMU v2 and v3. These types
> are hardware-agnostic and used by both MMU versions.
>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/mm.rs           |   1 +
>  drivers/gpu/nova-core/mm/pagetable.rs | 157 ++++++++++++++++++++++++++
>  2 files changed, 158 insertions(+)
>  create mode 100644 drivers/gpu/nova-core/mm/pagetable.rs
>
> diff --git a/drivers/gpu/nova-core/mm.rs b/drivers/gpu/nova-core/mm.rs
> index 8b8a86980bb6..045e35c92b78 100644
> --- a/drivers/gpu/nova-core/mm.rs
> +++ b/drivers/gpu/nova-core/mm.rs
> @@ -32,6 +32,7 @@ macro_rules! impl_pfn_bounded {
>      };
>  }
> =20
> +pub(super) mod pagetable;
>  pub(crate) mod pramin;
>  pub(super) mod tlb;
> =20
> diff --git a/drivers/gpu/nova-core/mm/pagetable.rs b/drivers/gpu/nova-cor=
e/mm/pagetable.rs
> new file mode 100644
> index 000000000000..637ff43ea83a
> --- /dev/null
> +++ b/drivers/gpu/nova-core/mm/pagetable.rs
> @@ -0,0 +1,157 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +//! Common page table types shared between MMU v2 and v3.
> +//!
> +//! This module provides foundational types used by both MMU versions:
> +//! - Page table level hierarchy
> +//! - Memory aperture types for PDEs and PTEs
> +
> +#![expect(dead_code)]
> +
> +use kernel::num::Bounded;
> +
> +use crate::gpu::Architecture;
> +
> +/// Extracts the page table index at a given level from a virtual addres=
s.
> +pub(super) trait VaLevelIndex {
> +    /// Return the page table index at `level` for this virtual address.
> +    fn level_index(&self, level: u64) -> u64;
> +}
> +
> +/// MMU version enumeration.
> +#[derive(Debug, Clone, Copy, PartialEq, Eq)]
> +pub(crate) enum MmuVersion {
> +    /// MMU v2 for Turing/Ampere/Ada.
> +    V2,
> +    /// MMU v3 for Hopper and later.
> +    V3,
> +}
> +
> +impl From<Architecture> for MmuVersion {
> +    fn from(arch: Architecture) -> Self {
> +        match arch {
> +            Architecture::Turing | Architecture::Ampere | Architecture::=
Ada =3D> Self::V2,
> +            // In the future, uncomment the following to support V3.
> +            // _ =3D> Self::V3,

The architecture definitions for Blackwell are now in `drm-rust-next`,
so I think the next iteration can handle this.

Which reminds me: is V3 working? I remember some fixup by Eliot
wandering around, have you integrated it to the series?
