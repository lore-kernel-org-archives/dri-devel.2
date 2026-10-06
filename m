Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85234CA5FFE
	for <dri-devel@archiver.kernel.org>; Tue,  6 Oct 2026 05:53:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D60E310E0B4;
	Tue,  6 Oct 2026 05:53:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="S+MtdqOw";
	dkim-atps=neutral
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011012.outbound.protection.outlook.com [52.101.57.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F5510E0B4
 for <dri-devel@lists.freedesktop.org>; Tue,  6 Oct 2026 05:53:05 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BjFHAE3dq/fH4uepdgu9LTLloCwzgfs4mBtvera9R0IzB9BYcgH2UzcieZmo4+bwtfJAPm0crioDexeb7lrnOvZEJ1lD5NF7FdQeLh8err/QiOBXgpwW+S1llVXVPObNKdmc4J3kcM3fSnFay7/yEqFQy+LgYRNcKUKosEynaNaD8P9Mez1VPkAE/oNFY4rxjL+OdZfc8JbYSKv9ZAax/x2C6B8ZNXcxuMT4HqOmNj2sVjeIP+E5yAPKWW8y+xZKDbxUCwOFZuBDFsLohmWL9g/D2r7NgKx9fIqmV5TY4wB5CqAizAgQB+9wGYIUzRZ0JVpNbRPdfl08r8alo7XhNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L7PLRZkyfJ0+ry5Af7xm6DwLqPiGa6yPg/PEg7za24A=;
 b=LysvjG9ASwSqBVlvTepy4Da2U9FpQo1WWzyPwYN9pJJ9eLOvBFqAjGfE2QQo9mwiaWwOmEvQZi4RJhmMMeIXQIn5XzXQV7YJGKqEmdHj4BxOvMXg1C8j9SUwZS9wXeyF+NgN+VKhtdaqK35OZkpsymPM5PTIL5KC6HuwPr1k74x/35kXTV00ugSR8a6KGDCSmIVSMWrQe4I62nYx5PK7s8QM5Xcn3uv0kKkoGlLSZCtguuqiKoNUd8j7gewnLzzdujyeebMHHqRXwV0qCpfvs2m2b46dnfnfdRHNdPO6kMRB9tKjEcuzk3BiQZkbwV06pLvwiWMy0OlTguzvL8pMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L7PLRZkyfJ0+ry5Af7xm6DwLqPiGa6yPg/PEg7za24A=;
 b=S+MtdqOwZc5FOwcmKzrmXW5JyUHE/WPQom7PYomE3Fd/DDmwqUBalPy04vAY1Q0Pkh6JPeUGH35VUhqduwY5eR5vWxaxUp7XUc5K8OyhpBaq2J8RRwzPSyBPBwLYOp5uVrA5wC/RBp1ZRFsrZSYOcgCM7QTAZk9hLptVl05EEx41+IPYfGbyhdQ+1H05gkHqM3bvkcEw8DlBgOVDghm6pPlRfM8GRQ1ja8Tm69iTFwxvuvas5kH7u/DslKdIhJbjAvLNa+piJuDRerfRRX9jmlEGMWZH9K2Exftq9LnnE2mFA/hWC+iRtuXGkh5N6HX170I9PfZ3Q912MmT3lGoPoA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by SJ2PR12MB7943.namprd12.prod.outlook.com (2603:10b6:a03:4c8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Tue, 6 Oct
 2026 05:52:59 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Tue, 6 Oct 2026
 05:52:59 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 06 Oct 2026 14:52:55 +0900
Message-Id: <DLXISL19ZQBY.1E3J1G0HKGPZJ@nvidia.com>
Cc: "Danilo Krummrich" <dakr@kernel.org>, "Lorenzo Stoakes"
 <ljs@kernel.org>, "Vlastimil Babka" <vbabka@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, "Uladzislau Rezki" <urezki@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>,
 "Trevor Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v3 1/8] rust: alloc: add Vec::try_push_init
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-1-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-1-f04504c262c2@nvidia.com>
X-ClientProxiedBy: OSTP286CA0108.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:225::10) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|SJ2PR12MB7943:EE_
X-MS-Office365-Filtering-Correlation-Id: af64823d-c689-4fc8-858c-08df236e1356
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|10070799003|7416014|366016|23010399003|22082099003|10067099003|11063799006|6133799003|56012099006|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: S58Q8xgfvU2VaXUftrSatgAGQQi+Ubnrh4nH8ToSa7OKV3XIUmKyCj1Cff9JK9nTKzeuXnyPNqERTFrwEGYUsIOYln167J7Y9YXupdtJ0+9N6gTy48agBZxSd+Ky9Petd9x+p9YGw7py8VDYGSmOewMPhlxKmxqyfWiEuH/iFr9C9p2elzbYg7iSrxp6y7D4JUcv8PMDEHRyhtt1IXVx2mozA25dJAIs6DFZXFFo5auSxXyeW0/4ChXQuzXgFDxYfsc5klZXNH1rBp1J5kKs0k4HFkCv9z3SIwO8apu1iQJ9Q9x5f7A3+vZX2LN1e0Li1tJxVGhq8q+z5j+zELqLrAf7jzgulqHQctOWoEN4cQ+3YFsVaH3YI0rkX9ji9IrEgXSlvllrngLYaAtBL2bdLIdrgs3UhdOaFMiif3MqvoLRrsYKobIhKWntiOZPto+2wnJMATYt1aKbXDOcr38n/3SvT9jrCL/llbzfh8xqiUwh1M9KtiqkMDtUQQuauLVW4iZ56pbvKnsXjaS+tlPh3kTViosYR/TBi0A7g50BqpgKPti/K/JbjQ1HwwD6BbRVVAZTxuSGqoEEYbhlCB3RnS9z2p68Y/xUF7qjhsdlEoFXKFsetpAyvURBjFHRLqrm3T5OC48QnWYWYG5c6H7dkxr5dBrIyQm9P9YlqTJuUTs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(10070799003)(7416014)(366016)(23010399003)(22082099003)(10067099003)(11063799006)(6133799003)(56012099006)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Ty9KWEFhbDNySTVjeHY5VW96alFjM0ZIQU56TFRrUUJMS25nK01qanlDRFZN?=
 =?utf-8?B?cUlnTlJiR3dwTU9HMzVjQStuTVBCU1BaUWhhLzllMEQvNlcrYzM1NDJIVHAz?=
 =?utf-8?B?UTZLZXlZTk1RSmkvZ0FyaWtNMm5nTldRVnltdkt3Rk9CVklJWjRnekR4OGEz?=
 =?utf-8?B?UmZ0dWNEUFp4ZWRtQkdueXhVbytESjlYczBWaEVzbWw5K3ZpNk8xZEY3WGxP?=
 =?utf-8?B?aGZCZ1dKbW5wekNvQ3pJajJ4c21zdmxRRGZJTEk4ZjJHb242MGIrYVN0NTZY?=
 =?utf-8?B?QlJBVlZMcThDQ0Q2RGlxMXNWTzRwY1ZSdEVyZFRkQnZqSnBQODM1SEtzdUd5?=
 =?utf-8?B?MDB1aXkvZjZKdjlqTmIvNkpYQkZHalAwZWkzMUtoc01PeEZVZWNVRFVKc0U5?=
 =?utf-8?B?dURVOGsvWWMxUUpzVVJkYTlkWTRlQVpxZzExTFRPWXArMmJTdWxpRXorM1hM?=
 =?utf-8?B?NVFxOXpJdGlUVTZqUWkrWExDbm80WjhsSE9wcjVqN3ZBMjBjanBTV3lkb0FD?=
 =?utf-8?B?Rld4SHAxa1lrOVJYOTVLcm9nczR1NVlwTC9LeG1nMVp0Z0F5ckRtSTF2eUZy?=
 =?utf-8?B?TlhiQnpSMU9FNWpPUDA0dDd0Z1FkanRnUEFRSDB2Q2FLamlYZUxjUE1PVVFv?=
 =?utf-8?B?ZG1DVytnMktIVWpMdkd0Mnd6ZGd1TndMOC9Pakh4OWJhV1hFaUtVaTNrWTVW?=
 =?utf-8?B?dm5vTThtMDVERllNQXhCQXBCK21wSzZ0NXlyNDdFUmYyMi9CWDVDbnlLdHpK?=
 =?utf-8?B?T0JCaHhBRkhkaXo2R1NiOFBMVjVIZ0pEN0Y4ZjNiZGlVMjRmWnh6cUg5SnRs?=
 =?utf-8?B?S0QvZlFTVGhOREJIa2NFajN0QWttSmpxeXBEaXVINjNZTUdvZ2JnZk9rWHdl?=
 =?utf-8?B?VGJWZ2tkSDE0NVgydVFVUlBzSmticzU2MGtKOHVDMXFUdk5zcHpLUWh1OEVQ?=
 =?utf-8?B?V3pXdGFUazlWQ2ZzSHcwdEkzUDQybVkvbVA5SjMvSzBHQWQ5L1liZlhNS2hG?=
 =?utf-8?B?MFB5bkVsQ2dheVBwc21iWEpVbExkQXBtQlVoNk5rUzIxdzJvY1ZKQ0hhRUVN?=
 =?utf-8?B?TnUvcGd5YnhndDQzRS9OUEJndmpyT0Npc1phL25DaGR0WU9ucVNObnFpRFpH?=
 =?utf-8?B?NFZLR2ZESjgzVEFpcFhSVnQ1K1NYZmtnTlB3U2FUc0RZZTcyenRHVWxhc2hS?=
 =?utf-8?B?TGo0bTQ1aXV6bUlMaDA2Wk9KQUtpY3ArQVlkTWVyMFJiZUtxaXhqMVU4dWRv?=
 =?utf-8?B?SmdZdHJ4RVhoc09pZ0pHdTYveFoySnJ2bFlHRXcyNnJUbnAzb3czay95Nmw5?=
 =?utf-8?B?Q2pMMlkzbElHaXVxNVI5Mk1LSU55c25oNVovaGFWc1VmbW5jTFZOTWU3L3ZY?=
 =?utf-8?B?Y0xOa3VjVTMzR0pGdmpWb0RUc0VvTms5ZWtlYmFLbTNmYlhnYk9PR1BtTlcy?=
 =?utf-8?B?WFdJeG41MHYweFUyUm5YUk9wMnRncWdGNDVDekliNlYvVnBuSlQ4SXR5VU1G?=
 =?utf-8?B?UW84YVY0MWVobGl3Z0VUcUVsTTRLRng1djBLNEc1M1dncDRmRkllNmpSSFFN?=
 =?utf-8?B?RVI2eHFQNmxuUVMwT0FHY3E5UTFaVSt0V291RURmd1dRbWk0SFYyVW5DYm16?=
 =?utf-8?B?OGE5VGNVOGk2OExLSVNqQTNqeTFxMEVoMUo4bkgveldUUUJsSnRrTlJOc0xW?=
 =?utf-8?B?VVY5WEhRTUQwS0xWT2pnWDlLSE0zQTJNWjBjV2JLRzlvR2tBYWZ4VjJ6SVI5?=
 =?utf-8?B?cThxQjVjSTlOcGpMQ05TZTFtM3lqQ1Z5OEdiUzJRMDlHWEpQc1pDMDFkSWJR?=
 =?utf-8?B?RHJ0WGlHbXVzZ2xIV3BDK3E1QzJ2SUpkdThNTmVQOXdPVXJFWjZVUFVSa3VF?=
 =?utf-8?B?cThwd2VUK2Rld3lhZ3RwWERUcFpiK0hHN2NabERVc2Zva2Y1OFN6SnV0UFQx?=
 =?utf-8?B?OTBDMU81SnF3SkZPUGtHQlBjR1lSNFBKUVYyR2tKaWJwTzBtYTFoRW9KV3J0?=
 =?utf-8?B?QXN5a0RUdFoxTHZ4SE5LTEZKVDVOZWYra1pEM1YzdXJxVWRqeFNBSFIxWU9J?=
 =?utf-8?B?LzY3M2pnaHpQQkhud2Z5c3lPdUdteXY3MzUyL2xJKzlWRnlUZjNtNUorYmd3?=
 =?utf-8?B?VVZ2OFYrbGZBMWcrcDJjS3M1SVhWanliUHJrSVZuQkxzMVFzb2ZDb2tVcWxq?=
 =?utf-8?B?ME9rZXNvMll1ZjQ3MkpwbUFlWVI1b0VTdlpLMnZUbk42cDVtUHE2RXh2K21E?=
 =?utf-8?B?NUM2Um5WMkdESEZIVU1yY1Y1OC9SSTRjOGhBejZISXp1Ulo2UUVwOUxtSWlm?=
 =?utf-8?B?UkN2VGZWOU5ZSWpJcUgvSklhUElRKzRQTTZaVk1hZFJVM0RONzluVi91V1lo?=
 =?utf-8?Q?ALCSb28rTntu/KnOeVdIMQkADve5PTFlGeCe7uSFjxiO3?=
X-MS-Exchange-AntiSpam-MessageData-1: fm6uB2QuJAfCvw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: af64823d-c689-4fc8-858c-08df236e1356
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2026 05:52:58.9995 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W71Yr8GGsKGiZzypW8W2mP46m19Um0BKmG2wfhvEe5O+7reCmpd8kX76hR4+JmLwgJgjU0PQrSXSAIG5mSQI5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7943
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

On Mon Sep 28, 2026 at 5:42 PM JST, Eliot Courtney wrote:
> Add `Vec::try_push_init` for fallible initializers (`impl Init<T, E>`)
> and a new sum error type `PushInitError<I, E>` that it returns. If
> allocation fails, it hands back the original initializer. A From impl

nit: missing `` around "From".

> for `Error` lets callers decay the `PushInitError<I, E>` to a regular
> Error if they want.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/alloc/kvec.rs        | 55 ++++++++++++++++++++++++++++++++++=
++++--
>  rust/kernel/alloc/kvec/errors.rs | 30 ++++++++++++++++++++++
>  2 files changed, 83 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/alloc/kvec.rs b/rust/kernel/alloc/kvec.rs
> index c7546b9da4fa..a2b72a7779d9 100644
> --- a/rust/kernel/alloc/kvec.rs
> +++ b/rust/kernel/alloc/kvec.rs
> @@ -52,10 +52,18 @@
>      }, //
>  };
> =20
> -use pin_init::Zeroable;
> +use pin_init::{
> +    Init,
> +    Zeroable, //
> +};
> =20
>  mod errors;
> -pub use self::errors::{InsertError, PushError, RemoveError};
> +pub use self::errors::{
> +    InsertError,
> +    PushError,
> +    PushInitError,
> +    RemoveError, //
> +};
> =20
>  /// Create a [`KVec`] containing the arguments.
>  ///
> @@ -359,6 +367,49 @@ pub fn push(&mut self, v: T, flags: Flags) -> Result=
<(), AllocError> {
>          Ok(())
>      }
> =20
> +    /// Appends an element to the back of the [`Vec`] instance by initia=
lizing it in place.
> +    ///
> +    /// Unlike [`Vec::push`], the initializer may be fallible. If the al=
location fails, the
> +    /// original initializer `init` is handed back in [`PushInitError::A=
llocError`]. If the
> +    /// initializer itself fails, its error is returned in [`PushInitErr=
or::InitError`].
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// struct Element {
> +    ///     buf: KVec<u8>,

It becomes a tad confusing when the element of a `KVec` is itself a
`KVec`... Can we just use primitive types inside `Element`?

> +    /// }
> +    ///
> +    /// impl Element {
> +    ///     fn new() -> impl Init<Self, Error> {
> +    ///         try_init!(Element {
> +    ///             buf: KVec::with_capacity(16, GFP_KERNEL)?,
> +    ///         }? Error)
> +    ///     }
> +    /// }
> +    ///
> +    /// let mut v: KVec<Element> =3D KVec::new();
> +    /// v.try_push_init(Element::new(), GFP_KERNEL)?;
> +    /// assert!(v[0].buf.is_empty());
> +    /// # Ok::<(), Error>(())
> +    /// ```
> +    pub fn try_push_init<I, E>(&mut self, init: I, flags: Flags) -> Resu=
lt<(), PushInitError<I, E>>
> +    where
> +        I: Init<T, E>,
> +    {
> +        if self.reserve(1, flags).is_err() {
> +            return Err(PushInitError::AllocError(init));
> +        }
> +        // SAFETY: The call to `reserve` was successful, so there is at =
least one spare slot.
> +        unsafe { init.__init(self.spare_capacity_mut().as_mut_ptr().cast=
::<T>()) }

I guess it comes down to the same but I'd feel safer if we could
explicitly index the first element using `get_unchecked_mut(0)`:

    unsafe { init.__init(self.spare_capacity_mut().get_unchecked_mut(0).as_=
mut_ptr()) }

(removing a cast is also nice I guess)
