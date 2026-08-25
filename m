Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B9C7C61DBD
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 11:11:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64BAC10E5CD;
	Tue, 25 Aug 2026 11:11:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="k5MfwmOs";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010048.outbound.protection.outlook.com [52.101.85.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F398910E5CD;
 Tue, 25 Aug 2026 11:11:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oDuLskV3NWDzZzx4MfIMz4FkhRI/zS6zdmF3H3SfPbE1oZj4s6YLaL0DxhsdgQElL66YFPCRiTQSCYJnvWEtac1cDLgnZcYSzeO8k5ah87t+CS5S0Rx6kdLu8jn34t0xWfqdedC13oWbCAsqNyNf4ZKPT7Vw1vdl6Pr47D8YeWnEP6MdtfXe9O7NfL1WYSA/HMnS2OdNYDm6RzNFFuUb3VNEfrUpR/J7ghKAALBbe8VNG1+ctEDigRNsRzwkXBWmhRhicj6mdfhyPgPaX669w82BQCMWCgv2RnXkb369Cpl3CgteYtz9ICW2quIuS8qA4arPl1nSsu1yf0HMe8O7eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JERNgLWXfID9wELxbqz7/2q4reUP4rdsWSgv6OXnFec=;
 b=uhaXD2H0uUOgpNOtiHJpFCBXZcaMXRRv/k5B0voS8AXeF1Cd3RkaQY+fSAfnfGEUUv+oBFgM1FDdC8AP7GexqL1/W3R6wjjrKzIfny7kbouRQGOPiYqw7dE24xRIij/QB2EtacBDKmPmmpM7YZALacY4umFUUWagRyoEvWrGpa6pLC3OBBAzqd7T/oO2Cf+aMeJzQReeyCQhJ2VgICJfLiTJ6aRG2pqeFWhuGp0ZxhMksaMWTAk7EXMT1YXeV3kBut8gjzELUnLdFoktjHZFwOxq/erHhSeuwSi1DrASnsDUaBDi1Hah1ZVKXtGB2YNb2j2SXxFwjqIOqjyNnPnh8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JERNgLWXfID9wELxbqz7/2q4reUP4rdsWSgv6OXnFec=;
 b=k5MfwmOsdbRLji7WxR0DMygu6976RxxL+50G/OLSq+RqEMDGLXgf6zfuAW/u2DblS4e4qM6aUpNqJeMtNa20vCPagmcT3J9wmbMtOmaRObXSVa/Z9BlmZCAO438+y6yraWUDFe30ghsZwMamYQBmjm2SxyUN1IWsarZeradRRN2WEkFqgIOjlvYVlrQ3DGrh4cV7XbxVkcdBrLel6LgR5okj6iBBsMN4NrQio/m4wddD4ukNuEqMJbDTxnyFKdi9TkIPRz5s4d9DnN1hJdMJ2j1IJ24EfQ+BLTKYEjziwxHt31NmY8qjhgThW/0AjgjlusMcR0zEfs4qN+v0+GW2lw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from IA1PR12MB6411.namprd12.prod.outlook.com (2603:10b6:208:388::18)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Tue, 25 Aug
 2026 11:11:04 +0000
Received: from IA1PR12MB6411.namprd12.prod.outlook.com
 ([fe80::b29f:6f15:4ece:5b5e]) by IA1PR12MB6411.namprd12.prod.outlook.com
 ([fe80::b29f:6f15:4ece:5b5e%4]) with mapi id 15.21.0360.005; Tue, 25 Aug 2026
 11:10:58 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 25 Aug 2026 20:10:54 +0900
Message-Id: <DKXZ9607IET4.3HNWMX2KULKIC@nvidia.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>, "dri-devel"
 <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH v7 03/10] rust: num: add nz! macro for compile time
 NonZero values
From: "Eliot Courtney" <ecourtney@nvidia.com>
To: "Gary Guo" <gary@garyguo.net>, "Eliot Courtney" <ecourtney@nvidia.com>,
 "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>,
 "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-3-a5872e64d8f4@nvidia.com>
 <DKT6WNPI2OA5.3RCBNYHHAFAD9@garyguo.net>
In-Reply-To: <DKT6WNPI2OA5.3RCBNYHHAFAD9@garyguo.net>
X-ClientProxiedBy: TY4P301CA0041.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::15) To IA1PR12MB6411.namprd12.prod.outlook.com
 (2603:10b6:208:388::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR12MB6411:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 701c4d62-1c30-46bd-3ab5-08df02998a05
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|7416014|10070799003|23010399003|18002099003|22082099003|11063799006|56012099006|4143699003|10067099003|921020;
X-Microsoft-Antispam-Message-Info: pxdJ71ekUlW9sbcgyGmr+ofWOzqpFIxyfrMKNIRar46DFbUd+99+9R7iHYqe7v1sKGEJ+BWRv8bE4sKfmuSG+Wk03dUVai5J54nnNtk+HveabI/peZludMkGk4NeqpY7tqU7KOZY9HrObujghsjqXxQQaAwvOLlh2sPTpchr22wgunHkder0M3ypKx8skS9CzXwTyr+qtER41NfLRlux9q0Y1JxvCaWwiSulDPjVaENPw+EafFA7Zsf9i/6iRdx4uy+1RyEB99VWtgq9mk1c1tF6c/ovsvwwk4DN6MSHvgmbe7ge9hgxt/TMyat0e17DpWUWyTCsM4BdKDCpuspwPs2djspOF295A+GZ1nn2TXvMCGO+iSTW090TVavdzReYq1mLgA7TpRtyCNmQLtE5YbOHExgxHpPyTM9Vutu6gDw772HYnBlDah2T3fHSPw+LGwJRuxToF12S315bhYInLOchobB5B1Cih49XXnpt+CPQO7SDx1O0NAPY+oeIV7AL8QM47kahfb4HyvmvK8+qPHscgZS7dUgpc1MpkTxmUN4BXCXmsMPSSYBCYcZn3jWtBeDzRyyBTwEv06aYWFHH+Io+qpp9dmDY/JyrTsrp+f+ok2uat9f6wluctMUqIaev0U6268D4ySWNBwggi3dCG+453pjqDXmHJnrvxkfk2+Jh4/4Eo3UTCkP0cvFiojFEE9dsKnjPwvhFyWinXvLztg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA1PR12MB6411.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(7416014)(10070799003)(23010399003)(18002099003)(22082099003)(11063799006)(56012099006)(4143699003)(10067099003)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QXRONVBrSWZWQmozaDZSNHp4RHBvQmZOcXlkTjRRZm92a3Q0alhHWldmLzVH?=
 =?utf-8?B?OUlsMXhUalY4T05YVHlLUVFvbEJHd0lzeDA0TkQwZGVhdlMyRzZyNmRld3Nr?=
 =?utf-8?B?Y3IwMUhrZEx1U1pSU0xiUkNHUU5EYUlLcU51OXdxU2h4U1hZNmpRRFV4aDcz?=
 =?utf-8?B?ZUcwYWlHek1hTStIQXVSYkVzSi9hempOMDN4U1Y2eFNoa0xLM1d3UE12K2s2?=
 =?utf-8?B?b1l4YU1paFFsejhqQVRIK0JweGpkNzdZbytHVVpLQzdUNlVkckJIM3FicFI5?=
 =?utf-8?B?aEZ2bngyTm9rUDJUMk5hazFBTmtXY0J4dVU2OHNJRGFKaW1sWEFXeXRtRmlD?=
 =?utf-8?B?Nkx4WDBUNUZFRmtqNk1vWDFScnJUL2dHUytKZ0lMZ0svMjk4RjA2QXVrQStl?=
 =?utf-8?B?ZEs1a2lHZG9INHQzYVlaTmpRNS9pNE9acFppRjhpd2pIM2Jqc1g0Y0JTK0Nw?=
 =?utf-8?B?VmJ4QmJuaE1RMlRwUjVNNmtyWEs2ekZpOCszcGFoNG9hd3pnNzZHSGxBT1NS?=
 =?utf-8?B?b2NWUDhrQ2pmc0hMeFZTNlU4VlIvK1B5SUV1d1hBUzFnVlNKWGNJcnJuaE5K?=
 =?utf-8?B?SlNyenRFc1VMUnJHeWNqTTZkZTM4cE5MdXAxZDBEWWNSNlYvQ2ZETVdFN1A5?=
 =?utf-8?B?MDlseWhkNE1NOVN3cjZleDhiYXBBYU10ODIvZms0SUNwQnZWMGord1N1YVV6?=
 =?utf-8?B?ZFQ1bENmY0ErYmluTjVMb2plaFY3RXAyMWdEd09CZXgvdWo4YUJKYkNycWZH?=
 =?utf-8?B?SWxFNXpwbzNNZmVOemFyWWtQbFJaaERuOVR2OHBwTUYyMm54cWZTeVNhZ1dt?=
 =?utf-8?B?ajlYZXZ0TmRKa3dRNDZMTXFmNmswd1lDbWZ0RVYvdlRzZCtXdDVUSjNMZ3VR?=
 =?utf-8?B?WlZ2Nlh6b2JQakJZTHdIOGE4UFJUNThoT2ZmQ1ZsTmFnZzNZeGszbzNKT3l0?=
 =?utf-8?B?c3JrNnYzUzlHekJzVTY0UzhPVVE2Z1NtNWlhOWsvTmNtZEl4K0V1OVdwRkJx?=
 =?utf-8?B?ZzNkOEpudkVzMDRvOWtEY3B5M0RDdG9YMmxibmFiQ0ZZSGtaRGpJc3RCNWov?=
 =?utf-8?B?d25mZXFMVTJCcnFUZitYUVhoY215TzRkSHFVQ1lhTEpRQmp5V3E0dGYvamQ4?=
 =?utf-8?B?WTJFdSt0Y0JLcHZkZGVOK2IzZWd6WEJadjlnQndHVDA5Mk1JdHU2a0didXFr?=
 =?utf-8?B?SFJ6aVJiQjlQbVFram9CV293aElqV0gzR0lRSG5iSTlJYUtxM2dwT2FWakk2?=
 =?utf-8?B?WGFUQy9zQ2VTOTNzdWtCa2FScDA0VWJIM2dBOVdsdjBsL3BSNWVEQVNTOGVy?=
 =?utf-8?B?aWJsektCdXFtdXFEeHVObVpJVzkybzI5MWtmeE9BRlpPS0VsWHZhdzg4TVkr?=
 =?utf-8?B?T01NR1U4SzBadURFRUdpQ2FYSThqbjNuUERBd3dVOVNOWnhQaXlGQ1libVhw?=
 =?utf-8?B?ZjRJOWxoOER4ZVFuR252ODlHQzFFTDNkaUsyWGE0c3Z6K1BJQWQ3V3ZIRUR6?=
 =?utf-8?B?blROU1V6L25BYTRvb2xnQVV6akxCeDErVlliYXhHcFB4S1BoS3JoUDFwdkFr?=
 =?utf-8?B?c2o3VEErdkVzeE9EVlpRdXpDSmlaakdmZmRTQUpsQUNPTEgwNG1qUjBrZlA3?=
 =?utf-8?B?blBkZjF4NkY0WEZ4SzMxeEZyb29xK3dLTVNjeEhPbkdmOWMxUEVFODBrU2p1?=
 =?utf-8?B?REtVVE5RQUhxdkJkWkd3UVVkaFloUEJkSDhtSzJYSjRPNExUSVFqMmE2U3dJ?=
 =?utf-8?B?QzlrM0RXZ1kvRDhkS2FTYVlEWEM4bzRGeWhIOTFLbys4WmhOR3V4OWpBRnoy?=
 =?utf-8?B?TWNCY0IwMHhvL045RUxqT0J4S1h2ZkYxRkREVEpnTllKQ0FxVlpyaExtakFr?=
 =?utf-8?B?KzIyWkV3T1g5UzVQN0NlQnh5ME1ETkt6ZDBjakt0YllkZ1VKVzAyS3FIcHZq?=
 =?utf-8?B?Tmg2c21FQTRrRUdwYjhhcUMxaVNIRHVJK1F2djY0OW5lUi96YVVmY2xvOUxn?=
 =?utf-8?B?eFRZVXcveUUyQXFVK0JhZlhmaFBwMjFMdElPVmk2ajg1bXJJWEpGdWZPUm5X?=
 =?utf-8?B?cGpwYkZ4OGFaQzhtbHRJR0cwK0VjUFVPN1FwMERXZjJZME5MaE9uM0xlMnFs?=
 =?utf-8?B?a2toS3JMME8wdXNDbDdqUU9IbXJ1TnhveEM3bUNmYjNkc1pGRitUaWExYmJW?=
 =?utf-8?B?aldMR2cxOCtvS3pIbU5xKzY5b0M3WXJKMTFjSnVDcEEvOGUwWXp3M2R1Y3Nx?=
 =?utf-8?B?L2c5RHJCdklwTTNZZ1BWbFRWSjJpM0xjenM2SEhOSUFrREFqMDRPU0JtQVhG?=
 =?utf-8?B?eVUvcUppUklCcjFaMnRGRlBZT0NkaHR6dUJ3eU1KSGNjL2toWG1oRjNodFJ2?=
 =?utf-8?Q?TEslmq9bH3WvZVoxm4/X6FdV5y9DIr7ck2JTxmQ8eMvO0?=
X-MS-Exchange-AntiSpam-MessageData-1: YaiaMxvS6/G0VA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 701c4d62-1c30-46bd-3ab5-08df02998a05
X-MS-Exchange-CrossTenant-AuthSource: IA1PR12MB6411.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 11:10:58.1910 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b1YZStpGYIWcCmVdYWFctVkZf1iDp9wciCU+OxZeZ+Pnmx3WgrJA5g87jr48gBlzDEUftUiNfTj0tBvmUc9JUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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

On Thu Aug 20, 2026 at 5:07 AM JST, Gary Guo wrote:
> On Mon Aug 17, 2026 at 8:04 AM BST, Eliot Courtney wrote:
>> Currently, using NonZero constants is quite verbose. It's unfortunate
>> because it disincentivizes using it in interface boundaries. Introduce a
>> macro to make it nicer to use.
>>
>> Link: https://lore.kernel.org/DKO414SNC0B2.248FUBGJGSPLU@kernel.org
>> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
>> ---
>>  rust/kernel/num.rs | 23 +++++++++++++++++++++++
>>  1 file changed, 23 insertions(+)
>>
>> diff --git a/rust/kernel/num.rs b/rust/kernel/num.rs
>> index 8532b511384c..055d23ca7fd1 100644
>> --- a/rust/kernel/num.rs
>> +++ b/rust/kernel/num.rs
>> @@ -7,6 +7,29 @@
>>  pub mod bounded;
>>  pub use bounded::*;
>> =20
>> +/// Infallibly creates a [`NonZero`] value from a constant expression.
>> +///
>> +/// [`NonZero`]: core::num::NonZero
>> +///
>> +/// # Examples
>> +///
>> +/// ```
>> +/// use core::num::NonZero;
>> +/// use kernel::nz;
>> +///
>> +/// let v: NonZero<usize> =3D nz!(8);
>> +/// assert_eq!(v.get(), 8);
>> +///
>> +/// const N: NonZero<u32> =3D nz!(0x10);
>> +/// assert_eq!(N.get(), 0x10);
>> +/// ```
>> +#[macro_export]
>> +macro_rules! nz {
>> +    ($v:expr) =3D> {
>> +        const { ::core::num::NonZero::new($v).unwrap() }
>> +    };
>> +}
>
> I wonder if if we can have a generic macro for creating types from litera=
ls,
> given that this is needed for bounded too. Something like
>
>     trait FromLiteral {
>         fn from_literal<const N: i64>() -> Self;
>     }
>
>     impl FromLiteral for NonZero<u32> {
>         #[inline]
>         fn from_literal<const N: i64>() -> Self {
>             const_assert!(N > 0 && N < u32::MAX as i64);
>             const { NonZero::new(N as u32).unwrap() }
>         }
>     }
>
>     macro_rules! lit {
>         ($x:expr) =3D> {
>             FromLiteral::from_literal::<{$x}>()
>         }
>     }
>
>     let nz: NonZero<u32> =3D lit!(1);
>     let bounded: Bounded<..> =3D lit!(1);
>
> I think the only downside is that this expression isn't const expr anymor=
e. We
> can change this to be
>
>     const trait FromLiteral {
>         fn from_literal(v: i64) -> Self;
>     }
>
> when const trait impl is stable upstream and we have MSRV bumped high eno=
ugh to
> have an impl of it.
>
> Best,
> Gary

I think this is a great idea. I would further generalise it to work on
any integer const expression (Maybe FromConst::from_const, and cv!
instead of lit! if we want to make the distinction of literals vs const
expression values). One example where only literals are not enough is in
the Bitmap tests we have nz!(usize::MAX).

We still have some usages in const contexts for Alignment so I still
think it's valuable to keep the SizeConstants on Alignment. And I think
Alignment::SZ_* is more informative than cv!(...) (or lit!(...)). But of
course we can completely replace nz! with this.

