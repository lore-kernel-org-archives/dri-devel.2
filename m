Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EB9C5DF7D
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 08:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1BD8B10F268;
	Fri, 21 Aug 2026 08:11:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="DJ5GWRfp";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010022.outbound.protection.outlook.com [52.101.46.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D248310F266
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 08:11:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=siu/A/fBj796phG8kXrHSNbZrCHeTtSFO2DSb9gMJ2578v9XZsN63Gi1+UkL1QSO0qziR2hqSwlD4Q7gsxOtmZjRnecG9uxU4cOxe5lq9cA7tKJaK6pCKb7AEKFv2irUvnZpLRhPcZ+w3q5bn0NaYH0Kh7H9gHTUxlyvF4a8rTtd8eFDm/CwHkXa5CC5fRz5NiWmaVmxE+sZknMFsM83xUbuR+VZimivvv2eqQXZgJEuDz9KhTzLqdzecq3moX0Ik4SvFvQNZSb3xcbog4FS7FFFZ7xnAzxAaqVvcia81pNIJtH36TpV+02jn7UiNvzvhEGJ7snFosoYhfQsV+OKUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qiKguAKvMFAeU83Zns19hRJqM0KSjm5S9tEoCpu3ZjI=;
 b=tVEHognoFopmJonQYEY918fs82ga8Mq6XNKiG3bjmiC+ytX6u4lwBJSI6Pxipc5chkzymPPspnEVlnI6+IzaTZvklgnU9SsjK7FaaMERQiuTeJdBGdWmE5DNBEanbhPx+PSAhGl39r4ho/bYaidoffniu9JiXoVu0oJzb2gfF2/BFqhsgdhtC7MSCVgll6aEANSpZTUxwlo18/o/7rUOakhE4gF3pF3ccZXNJLBvOeISd8UG2tdcr0yltVgUeTAuPBlCFNlf/2GgfYhzkTc2uz+VTNvP4D3l89mMMgFBxDX9JYZjwFs1Uv96aTmvSwVSZMmSE/P5X3HFOL7gHzuckQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qiKguAKvMFAeU83Zns19hRJqM0KSjm5S9tEoCpu3ZjI=;
 b=DJ5GWRfpU4JF2xwh8TTqfUm5AKJQAj78mtZtTzNa1pMtl9Lru+fsmSj00weAaZosRgY0pR0gzLH7J1IZ5xGEDobxgfJq6kbFjXcX8/dHoBzW4I+NpsF7+GuYaXw2ATWcrLf5PSdgqroIGS0CVI2Tpl49ODxpZBjEa6YNVcY9jr84hxUAYuw8nSDvkV8sjSVvRQTiaPmmGq+C5Sp4+VQqQlIJgT6X+/crdlSuYjvvr0uODHDB2mWI9uv4jqC+WF+oyO+rQ2gaphJIhtPIADI8it0W1z9vTQsbZSUJbf4xxkKixAUJpTZ9OVpetf4KDlHwcu+dGf92sTEzMjvqPvSMNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by SJ2PR12MB8011.namprd12.prod.outlook.com (2603:10b6:a03:4c8::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 08:11:12 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0339.007; Fri, 21 Aug 2026
 08:11:12 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 21 Aug 2026 17:11:08 +0900
Message-Id: <DKUGXCFA0Q77.36Q64A1AN6FX5@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
Cc: "Alice Ryhl" <aliceryhl@google.com>, "Burak Emir"
 <burak.emir@gmail.com>, "Yury Norov" <yury.norov@gmail.com>, "Miguel Ojeda"
 <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary Guo"
 <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Danilo Krummrich" <dakr@kernel.org>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v7 05/10] rust: bitmap: add contiguous area operations
From: "Alexandre Courbot" <acourbot@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260817-chid-v7-0-a5872e64d8f4@nvidia.com>
 <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
In-Reply-To: <20260817-chid-v7-5-a5872e64d8f4@nvidia.com>
X-ClientProxiedBy: TYCP301CA0068.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:7d::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|SJ2PR12MB8011:EE_
X-MS-Office365-Filtering-Correlation-Id: 58a1bdc6-1462-4ef9-7510-08deff5bc36f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|366016|376014|7416014|1800799024|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: xcTiklwY1CB8X8gTbgL1wHhLPIkM35UEyXXwC3JZP57UrsB66V6wOlWYlATprT/OFXtCQNZ40FogghLrNBSiWfOtkrwYUJ6juEmabiChcnxIkxcOjuCLNQl2cK9Gymb5SFWNeYO6Oog2OoXC+J+WcZtB7QalulimStXf13bSXgtUBbmKGwNmQ2Z7mlLw+jgt4qyyOHNSli1Rp+9ibmfBF6QhA8ZhfdtpoN9Efa4OB/V2mBXtrQ7wozUUJFnaJ5NN2XAj+55Ca4OGImTMbA7YcV6yDEPnMCRDtVofPZ2Ejx8sOA7c8Kd0BNj3KwJMX2SYoLSNSePjr+Pk+4GNzv6fhPQ4bVsVjAkeKwdIE6nIobe2PhGWUwO+JJ8kfiwaEFfFLkpa2clxQlNHdmP0yxivggmB3CD2S+18CKieoWAlZUWikfv5fSEj6ZKxp/scAc11OQofu3fk2oRJgO+PysXktnKRE9LvKKanKAG/iZ/oRHD6TauvPred6pTcWjKPqFa++9qkqHKGZIBUCrXr6vuJssJxVdCtzkc88pZPPMG64pnc3pSfM1WJF81ca/P9TtG+frFBzAG6yZHp/LV6BaDS2Hstm97HMTs1G2mqeo76enwVO9HEjM7X5El5UOXzigK+gFHzBPAPrWGqxXVA9TbsBf9XhXz7eG+knv47/eZCfJE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(366016)(376014)(7416014)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bVJzZWxJMHVLaEROaXNzUk5pYUJ2OERBcGQvWXZpaW5BZUxGNlIwam9BWExT?=
 =?utf-8?B?ZGVReGJ3a203RGZ5RHN3RjNxZFNiR01ra2tucTkxa2t2WVhRVUNjR0tjK2VN?=
 =?utf-8?B?ZnlKSXRybUg1a1pueVJqRGc2SEd4cHlnK1hjNjkvMmQ4ZFpNdGxEamFmNHE2?=
 =?utf-8?B?d3czZEduRVlSQVFGSWlyWXh6YUdiYUluT3l6SVZCK2p5NkZneGNpSm04Rlo5?=
 =?utf-8?B?Mng0YmZXZ2tvL1ZHSFpuc3YyMGRoY0gxREJOekQrb3RtZC9TMTAwNnBTL3VK?=
 =?utf-8?B?cmRuSEh3OG5RcWJ5am5JVWRtOGFZL2VMZDZMWThtb25TM3RkemxJVzA0c0lj?=
 =?utf-8?B?Z20rblRnWUdXLzVaSWF6djR3OHhQYmk2Z25MRzlsbXFrTGUwcmRTaTJ5c3JS?=
 =?utf-8?B?cXBkckg0QmlMTkcvYURwQXIxZ25Qb1BpcmgxL0R2VDNXRllnWDBzb3JJcndO?=
 =?utf-8?B?R2dTZkM2aDVFL2VoZWpCL01EaUJ4NXdxYUJyTFdqM3d1M3Erc1VSKys5MGNZ?=
 =?utf-8?B?aDdrSUlhaGdRcU0yL1pUZTc5SklDUDhjeXNoaStzeTY2d2dFT1hQak03TXFi?=
 =?utf-8?B?ZVplcENxUkpIdHZmV1NmbTc0cHMrdENKZGpFVW11Q09qdVRzaTRGRWJMTysz?=
 =?utf-8?B?S1FUcTR0NlpIaXJRRXpCbk1lSlVVUkpaTk9LY0Zxd3VWZnhJdlFPQ095RWlU?=
 =?utf-8?B?Ym04RU54bm5JTzZJK24yVGxTM1ZPTjJHT0xGN0ZKYWJ1WGR4Zmx2QUl1WnE0?=
 =?utf-8?B?cGdNOHR1bktoc2YwMERTNC9obWN4dHovOGRXeXBlb3hldnR5eFlFOG4wak5z?=
 =?utf-8?B?RUh0TWU1WXJNd1BoT2EyRVg0d1ltRlpsYlNyaGVqdjUvRFN1elQvcTUyL2k4?=
 =?utf-8?B?RzRIU3orbmpjVktyNlNQWHh2OFJqU2NCNUwraW1zYzhmUTE1TWI0NXRvSmQv?=
 =?utf-8?B?R3p4ak4rcnBQbC9lWmNDdkJxd3lhZ1dlVnpCWmFWNStrM2RPVlFselQvSW5Z?=
 =?utf-8?B?cUExcHNWSldPYTgwVzhjMmRhSXo2UzJTUHZwWVNLTzIwOHdWbTN3dVZlak9B?=
 =?utf-8?B?aFVNWVZtWVkyVE4wRDBpUzU0WExrZUNRZXFVb1gxOGxnMDFBWU16eEhqZlZF?=
 =?utf-8?B?T2RqcTdWR0dhdVpTWnVvdlpHNGlaZDl4RHVwalFGTFVBTjcxSkZDYlJBblY1?=
 =?utf-8?B?cHhQMTZ6TW9VTHU5cUFpYXZoUkplSklHUGF2Y3V6NW1lMEtSb2xWSHdYS1BM?=
 =?utf-8?B?WjAxUVN0V3kxL1BjZUpPV2tDa3ZDNEd6eStzOUVVdTA0ekNqaUZGaFl0U1Bh?=
 =?utf-8?B?YmE5T1ZnZVQ5TC9xOUJvU2pxTGRvd1dJM2ppMHJtc3BNUmtJZDFlOXZueENu?=
 =?utf-8?B?NDRWODA2NHFpYTh6cFNkZjhzK1psOXFMTVlyNy9VNjdwdlQ5dmlqSi9WN0tw?=
 =?utf-8?B?SDRHYzhNc0I0WVR3RlYvTGFET2lyMGtjejNpZG9COVF4MUdDaU5Fbmt5alJz?=
 =?utf-8?B?VUx6dnZQM3VUNDI4cFIxQWxEYUZGdE53YjlPVGxMUElyVXQ4bm11SGRqZkVv?=
 =?utf-8?B?YllvbTFYNlQ1ZXdOcFVuR3BoK1VlOWM4bkZSeldDaTNtdVg1WW9zYWYzRzBt?=
 =?utf-8?B?TWxCYWZqTUQwOHJsajRMdG8zQVZGS3A2Nm1PWWpJRlE5OUU0S2VTWVJFaDRr?=
 =?utf-8?B?eFo5MC9yZjFRTlNVYmx2TGFzZDN0bkVwZHlHaDhsNU9vdE5FSUErczRFa3g3?=
 =?utf-8?B?dDVyUVF0cUJaN2RIRkpQd3VONUNLNzZaRUVaVVFQanNqOGZtck1xUTd2MFVE?=
 =?utf-8?B?ZkczUXdKVjZsN0NEWmpaRWlPcFBlSnlhL0dQRXMwSm9WSFVObXhZaWJLWE9N?=
 =?utf-8?B?VVdNbGMxVDdUbW90ZHdxb3k5RGdXWTlRR245N1VrM0Ewa3RiUmRCVEZWbGNX?=
 =?utf-8?B?bjBTazFPKytjOUZnZE1CSnM3Nyt1bWVpZkI3a1lEQjVkU243bEFFWlFqblhs?=
 =?utf-8?B?dlVTeENDQzV5dEp6SlJFSnhtMmlnL1pQS0dna1dscjhSalhFQ21rTHY5YU1L?=
 =?utf-8?B?TEFZam1IMWEvVk9ha0ZRam8wUXBEa25jTVpuenBtalU0TzdzWFJRYzlsbGdE?=
 =?utf-8?B?WWh5L3BOM2lZUWdXSE5BUG1PbjhWZ2xIYVdMOEUwalNMQXFra2tCdjEyMDlJ?=
 =?utf-8?B?UHZpYTYyNXpyciswVERwWGdSRS9QMVdQcGdVQjhKNkt0NXYycFAzTlQzOHlP?=
 =?utf-8?B?dTdxSjlRNUJDcS9VVUxKSHVBV0UvUU5teVkwZHJqUlFIKytaSSt6MTFxRlE4?=
 =?utf-8?B?bE5PMDRDWWF3OXRCUFhGWmtJS0JQK3ZzcHVUc1NKdForM0dpVDA1MG9HVWt3?=
 =?utf-8?Q?s29X1ou0lcNNWPcB7YyjYxFA2K8JVzYllit06PpD94Guu?=
X-MS-Exchange-AntiSpam-MessageData-1: OdW9qO60KgiLzQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58a1bdc6-1462-4ef9-7510-08deff5bc36f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 08:11:12.0738 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qhnrCdbQHSImqTKHAh1WEYXoHfZ2DSi2gEH6utBhJmRXlsTTrdta8byCuXPTtrsCzgbWL7aLCp0/aZY8ySMfHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8011
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

On Mon Aug 17, 2026 at 4:04 PM JST, Eliot Courtney wrote:
> Add bindings for area operations on bitmaps. Each one is
> made safe by adding some extra checks compared to the underlying C code
> (for example, checking bounds) and with additional checks to catch
> likely erroneous usage if `CONFIG_RUST_BITMAP_HARDENED` is on.
>
> Add tests demonstrating the edge cases.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/bitmap.rs | 242 ++++++++++++++++++++++++++++++++++++++++++++=
+++++-
>  1 file changed, 240 insertions(+), 2 deletions(-)
>
> diff --git a/rust/kernel/bitmap.rs b/rust/kernel/bitmap.rs
> index fdcfc0409773..a4997022ff0f 100644
> --- a/rust/kernel/bitmap.rs
> +++ b/rust/kernel/bitmap.rs
> @@ -10,7 +10,11 @@
>  use crate::bindings;
>  #[cfg(not(CONFIG_RUST_BITMAP_HARDENED))]
>  use crate::pr_err;
> -use core::ptr::NonNull;
> +use crate::ptr::Alignment;
> +use core::{
> +    num::NonZero,
> +    ptr::NonNull, //
> +};
> =20
>  /// Represents a C bitmap. Wraps underlying C bitmap API.
>  ///
> @@ -523,13 +527,160 @@ pub fn next_zero_bit(&self, start: usize) -> Optio=
n<usize> {
>              Some(index)
>          }
>      }
> +
> +    /// Finds a contiguous area of `nbits` zero bits at or after `start`=
, where the area plus
> +    /// `align_offset` is aligned to `align`.
> +    ///
> +    /// Returns the bit index of the start of the area, or [`None`] if n=
o such area fitting in
> +    /// the bitmap exists.
> +    ///
> +    /// The returned index plus `align_offset` is a multiple of `align`.
> +    ///
> +    /// # Panics
> +    ///
> +    /// Panics if CONFIG_RUST_BITMAP_HARDENED is enabled and `start` is =
out of bounds.
> +    #[inline]
> +    pub fn next_zero_area_off(
> +        &self,
> +        start: usize,
> +        nbits: NonZero<usize>,
> +        align: Alignment,
> +        align_offset: usize,
> +    ) -> Option<usize> {
> +        bitmap_assert!(
> +            start < self.len(),
> +            "`start` must be < {}, was {}",
> +            self.len(),
> +            start
> +        );

Do we need to potentially panic here if `start >=3D self.len()`? The
question "is there an area of `nbits` bits after my bounds" can be
answered by "there is `None`" without semantically sounding weird; and
this test doesn't cover `start + nbits >=3D self.len()`, which should
logically also be considered to be consistent. It seems like the C API
also tolerates this, so as this is not a safety issue I guess the Rust
one should do the same?

If anything I'd say we should remove these tests from
`next_bit`/`next_zero_bit` as well.

Mutating methods should definitely keep that check, but for querying
this looks like a legitimate way to use the API.

> +
> +        let nr =3D u32::try_from(nbits.get()).ok()?;
> +        let align_mask =3D align.as_usize() - 1;
> +
> +        // The C alignment and end arithmetic must not overflow, or it c=
an read out of bounds.
> +        // Overflow is only possible on 32-bit.
> +        #[cfg(not(CONFIG_64BIT))]
> +        align_mask
> +            .checked_add(self.len())?
> +            .checked_add(nbits.get())?;

Is it ok to not consider `align_offset` here? The C code adds it, and
the result could overflow on large values, even on 64-bit.
