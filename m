Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7661DC44529
	for <dri-devel@archiver.kernel.org>; Tue, 21 Jul 2026 11:42:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A898910E33C;
	Tue, 21 Jul 2026 11:42:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="i2iewtWl";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010011.outbound.protection.outlook.com [52.101.85.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C27D10E33C
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Jul 2026 11:41:59 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c1HV/1OqbkpWzTn4QNs6c/+4f5gsiZ00VXEd40imPsQbNtZGnQsl945duACzoGGpqPPmrFVeijzaGNjSCKC59T2sT8+SSYc2ZAlTlJ5lF7l6vMahBvubba3FTCNCosX1U7Tu3Sk0AN+2z6kT7Qu8hiAotvHY7tlS2hDAvLjlnDK/8kslicf+oKe7WAKeryUUdu3w2mMUn4xb4cxtqslp0v9IiYkscxUvalWuM73HsliugJfyg+NGZgmF+ff53yki0mT5Sn942oaXG/AnE/igRUgtPQB0dTOCsbV2fa0MfBDgMSqQ3cWdipu9TBt1kUUQpwRkwfZ1P7ISWcxKsL6nWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KMODG3hcoUX3esNJBCnlzYd/gPP6sl8gyPobkZ4dHkM=;
 b=nhiu5WkNNF7ngDQiMHUS0xa9OjIrtko8OEpPRcXvVSikSoRNdnPoxajtk+W9jgrUhodhpdLvPeIYIxBpEfkMbHRNMMblh6uqGWSUeD+CfSjPwJR6bTO7ezmb+0FE14dcQOjY+bvpnteN+wvxGORVe8I4oQdywgITOyt3qV0VRv8EfmouCSGoLb1AkxSmJV+Pnm/+jgBMIpzMLeH+bhPhPlZcJAyyh0i8v8L8tRzd8JI6AAxHmdK5gKTNduZSnrRqgYRzWY8I9g2BTlCNIyrX4aGWN/ROpljNtoxz5GSa3V2BsljRz9oh0dc8lkMm1F+3UjxwwZ5x3TW2XKEbhDa6Jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KMODG3hcoUX3esNJBCnlzYd/gPP6sl8gyPobkZ4dHkM=;
 b=i2iewtWlFSXGxVm7fsn76xbGMtz3tVSGlr9CUW8jh4Qy9+tmgopHVazoZx7LTMm0z+m4gUJxDqHq1qUytTjOIkGozW71M2KKvjLd2FYIVnnrZE0SCsftAcGo/AZIfjrTwCc2XhYNyChDZUa2NUI6OvtZGU3u61CB59XhvDQGbDNm7y8tE5EleV2fxk4svG87BYHzz277ZZhqY+j3D8VLprIbTrWcd6lN5P41EZUsRQjU1fqYrIB8VE1ThWLoBc5Ohl7K6TRAHt6PO6A0vI6XQFL5BtGRZem9n+3u9HZjm2yVD+jVXC61nuj4IYCvvEHLH6Q9IVqrJzc11bmDRLU80w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DM4PR12MB5771.namprd12.prod.outlook.com (2603:10b6:8:62::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.14; Tue, 21 Jul
 2026 11:41:53 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 11:41:53 +0000
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 04:41:49 -0700
Message-Id: <DK47ZRUL6UBX.1V6XG5QZ2YB8W@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Eliot Courtney"
 <ecourtney@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, "Alexandre Courbot"
 <acourbot@nvidia.com>
Subject: Re: [PATCH 4/8] rust: io: register: use path fragment in relative
 internal rules
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Daniel Almeida" <daniel.almeida@collabora.com>,
 "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng" <boqun@kernel.org>, "Gary
 Guo" <gary@garyguo.net>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Andreas
 Hindborg" <a.hindborg@kernel.org>, "Trevor Gross" <tmgross@umich.edu>,
 "Tamir Duberstein" <tamird@kernel.org>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>
Content-Transfer-Encoding: quoted-printable
References: <20260721-registers_fix-v1-0-3711b2317e1f@nvidia.com>
 <20260721-registers_fix-v1-4-3711b2317e1f@nvidia.com>
In-Reply-To: <20260721-registers_fix-v1-4-3711b2317e1f@nvidia.com>
X-ClientProxiedBy: TP0P295CA0034.TWNP295.PROD.OUTLOOK.COM
 (2603:1096:910:4::19) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DM4PR12MB5771:EE_
X-MS-Office365-Filtering-Correlation-Id: d80c63e2-a7a4-4b48-0b4f-08dee71d0f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|4143699003|10067099003|11063799006|56012099006|921020;
X-Microsoft-Antispam-Message-Info: DQSy74Ln2C7u0tGfvPRiijK0EPdUq/363ouGbfCzoZxF7nsL4pBBx6jXriuXBwT1A7z1rkR4lPwdORvTb/QmerfsZj3negIQ60xEADUepNn1D5Ux174EzdPPgIWOoCl/yGfXTV10vqkDmy945Ik5AjEqC6wX63T8OMBdePKO2x4GGRKDXzVq5/5tj0OHqJh+GY+FSWGu4LZkaIGsbD8v11kYpOpvtq9Gfjt99KxKdNPTMFdJDGKUV0RYNPsVumlY8xk6X1r6oRCEpBu0GevWlb3H91dQEIE5ySpeODUfHlVsppwQlJyp7EdpEFga3DsqfuGmNbs3KF1tvET+Ub/RT7LXGKuwkEScPA8TSUUO56iT6sMs1ZeZh4t81Ca+7m4hVIr4MdOl0kFmJwqdBFtSg7AUvxlPM3quxs3IiWFXhPll4nQbThnZF70QQ0cVOKNr1fXbbxWphXtiOdLD6h2EhnPRMoQyDAd11/LJyPlwu6r+JcvV18x4qiqpqqKxuwlhQ/617t9rSMtme2DaD53YQHuX09ofxRRopB026M+QZrSZEMkTQkKYZsjbqZf+ostUL9CvVpPaS+Y9c67FuFhZOd0KIqHmxZCou+XgLrRsw/DTAw++f6G/j8bqK+pTd3w6cN/IzgTyryKVnObKRjopXdTet23ep0ySWs++NTD5cjlJHz8NvpOCiDaA0KC2N4NCVrNqIsyuia5x45RGkERNBA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(4143699003)(10067099003)(11063799006)(56012099006)(921020);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2tFd2JaaHVuQkZSckUzcW1ZOHpORXpDQ0JrL1Z0ZXgxRDJiMDhLL1NWK1h3?=
 =?utf-8?B?UmY3eXlzK3NKR2t3VE9pT3UzbjBFdDExMU5sMUkwNmdOb0laeFJuRTdwYUFM?=
 =?utf-8?B?aUtlR25hUGx6a2RGU3dLakRhSk9OMFpJanNxbUJ3TUloekh3NjdGc2QvcUQr?=
 =?utf-8?B?OWZkbklja25mbmlBQW9oeFM2TW1JWU1tMmpiaWVScWRzeU15a3hXeEZVb2lq?=
 =?utf-8?B?RDFIV3c0amVpSXNCRkVnWkhQdjlQTDBnNFkxdHhsRXZDL2F4UmhPR3NqMUtJ?=
 =?utf-8?B?WWt3Qkx3MXo4d2o0bWI0aWFoT09FVlhUbHRBclNBZE9GZHNCRVZqRGd6QTAx?=
 =?utf-8?B?bWlYT1NoWTBoS0tiaTR2bWliYWMwRFlBZndZNnIvZjUyRWI3amZEaTdxOUxD?=
 =?utf-8?B?bWJMbWxqUzc5M1R6cTh6Tmo0OXRDSmw2TUJEQU1UQnE4ak5EYktzVlZaR2RC?=
 =?utf-8?B?ejViSFJ3SUo2Y3IwRGd5SjlDbVYwQnVkRXpQOW5ZclZVeUVjRzdFOTcydXhX?=
 =?utf-8?B?RGc0TFZnMWNYRXF0Yi9hdzZrTUQvK25mZzdBQ2hkNTVHWEEyWkdEMHVxcFBo?=
 =?utf-8?B?YTBhK3ViMEpnUmdIdlA0czF0UEFWWVdCaExzb0tnd1NjbVJOalZvYkJnc0JD?=
 =?utf-8?B?RVhweHlpQjRDZEk4VVJYRkZSSHJYVGhJalZiV09vUXFSVUtkdmg1RUZER21k?=
 =?utf-8?B?eWFJYkZXUjJqMzQ4S1BpRDlEME9oekJ0SmcxbFg2ekFLbUthdDAwZy9CZm9V?=
 =?utf-8?B?cVFaT2tDYTVNWEhoVFJHaXJmd20rZEszaWQxUDRtSi94TmluNVN0Q2FiOXg1?=
 =?utf-8?B?TmpjVTNZdlUzSDNQSVBFMnY3VU96Z2lvR2Ywc1U3WHAyUVJkMEV5a05MTnNr?=
 =?utf-8?B?V2R0UFNUNWVKQXlsUGNjb2h6dVdVRXJRaG5LaTBpMFVSZHhlWG1WRHExR0k3?=
 =?utf-8?B?K3NsVTJjUTQvMUVTVnZGRThhNVEzMkZYamhrMThrakYyY2duM0Vndkpad2JO?=
 =?utf-8?B?TkhocEJ1SzhYVFVhY0hVT1RLS1FGVUpwRVI3Y29yZUFlcGY4eDNtbVJBYzBC?=
 =?utf-8?B?dEJEZ2lJVzBRTWI0SXc2cXJjOVJ1RHhGS2xndExGVEg4L2xoblVlRXFlQU9z?=
 =?utf-8?B?aWc1dDBqOEZBbjE2YUxwbjRaRXNoVnhrTkdYM2NGcGFFckQyN3c4ZitINGhu?=
 =?utf-8?B?NDMxWHZ2cTduZnhJK1c2ZFVzQTZkUTRvZWdXWk9rbllKVUVZbS9IOE8ra255?=
 =?utf-8?B?QjVWL1pMTVpMa3hwWVZ6M1g5QTJlNlJoQkg5U0JuVDhuaDlYdmtDcFlHSlFF?=
 =?utf-8?B?eWFTTFhvNGF6d212RGlKUkxmMTFJTGFJWW1HMEhhcnBWUzR0NHprY29VaGJ4?=
 =?utf-8?B?L1R1RlNFa1lpUDlaTSsxQ25ROHZmVHhpMTVZMkx1eThTemU4YU1valNzZUdt?=
 =?utf-8?B?YnA0TDUvVWt1dDFDdUVyT0E4ZU9DVSs3WTdRVnQ5Q2RQWWg5M1BrN1FsUzho?=
 =?utf-8?B?YVNsQVd1bUZDMzBvYmo3Uzd6Wm8rYm1UcXlYaHM1dkg5WWl2Y1JHd2MrWWNX?=
 =?utf-8?B?MXA0TjhvcVU1cE5Fc0ppVjFDMW5ROGtuWXBzK0RadDJpdEowNElOUHVORUlQ?=
 =?utf-8?B?WFNmRkFFZmVydzVRMTRJQWduMEhhV0dldVB0cllOcElEYkFLV294VHI5ZGQ5?=
 =?utf-8?B?SWhmdnNOdkxjN0N1V0JUWkJMcHpZUkJYbmc1NzBvT04zQk9lY0g3czhtZDIy?=
 =?utf-8?B?L1NBNkZWbjFEeEVCZUhzVEt0Sk1WcTYyYXRGVXRPUklYamUxMS9RVC83U0s1?=
 =?utf-8?B?Wk5FVE93NUVyT2psTFdrcTlNdGNUcU1TU1N3WitVdkovOGU2d2w2VXNpTmpr?=
 =?utf-8?B?aHRxbnBzV2dNS3ZsK0cvUkN0V2ZYMGhrTWNQUVB2ZlluajNEdTVWa2NhMzRq?=
 =?utf-8?B?a25yRm9TTk8rMnJWMXNPRFdVUnFJT2lIWnJxTlNxV0VsK2dRQXNoNnlkOFJV?=
 =?utf-8?B?VDVWWnFMQlcvM25FQ2p6NGc4anFzZm1kV2REK0piNmFydkVQRlhOYkM3S3pK?=
 =?utf-8?B?S3hUYXBtQUJHeXpBaXE1M0k0Vnp0RktLTDF4Z0puZ3c1elBHQ3NZazFFUkZs?=
 =?utf-8?B?VkVJYUtvbTRWajJCZTBHRXgxaGRyYlFYN3hEMDM0QmhIY0E4clpSa295VWNz?=
 =?utf-8?B?cVhoWkV6WS9LRFUrTk5jNmhKUUZabmxIUWFZUHhRaHhVelVDZUhoZUVSSDZD?=
 =?utf-8?B?YjJZbDA4SzRVNUtqWlR1ZzJ1bGcyRXZ5Rmx3bFdWLy81TVFFS25maFBpcEJC?=
 =?utf-8?B?NDF4dCtwdHN1a3hhQXFxVDYzOEZHbFFGZW5vSlVYQlZ2RkR3aHFnQT09?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d80c63e2-a7a4-4b48-0b4f-08dee71d0f9e
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 11:41:53.8111 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 85SE3TlJM6iCXRf0wdv0yndncqoiy5BdglgMSbcThGCGI2oADw73Wwo49w5UF+kPG55DV++hD2RNpgIo5XK+kA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5771
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

On Tue Jul 21, 2026 at 4:00 AM PDT, Alexandre Courbot wrote:
> The base of a relative register is a type, but its current fragment is
> `ident`. This prevents referencing bases that are e.g. declared in
> another module.
>
> The `path` fragment is more accurate to represent relative register
> bases, but bases are currently followed by `+`, which is forbidden right
> after `path` fragments.
>
> `:` is another separator that can carry the desired semantics, and is
> legal to follow a `path` fragment. Thus, replace the `+` separator with
> `:` in the internal rules so we can change the fragment for relative
> register bases to `path`.
>
> The public rule still uses the `+` notation and an `ident` fragment, so
> there is no user-facing change yet; only a minor replumbing of the
> internals to better support the new syntax introduced in the next patch.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  rust/kernel/io/register.rs | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
>
> diff --git a/rust/kernel/io/register.rs b/rust/kernel/io/register.rs
> index 1e0e23e4233f..62208f52752a 100644
> --- a/rust/kernel/io/register.rs
> +++ b/rust/kernel/io/register.rs
> @@ -816,8 +816,8 @@ macro_rules! register {
>          $(
>          $crate::register!(
>              @reg $(#[$attr])* $vis $name ($storage) $([$size $(, stride =
=3D $stride)?])?
> -                $(@ $($base +)? $offset)?
> -                $(=3D> $alias $(+ $alias_offset)? $([$alias_idx])? )?
> +                $(@ $($base :)? $offset)?
> +                $(=3D> $alias $(: $alias_offset)? $([$alias_idx])? )?
>              { $($fields)* }
>          );
>          )*
> @@ -850,7 +850,7 @@ macro_rules! register {
> =20
>      // Creates a register at a relative offset from a base address provi=
der.
>      (
> -        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $bas=
e:ident + $offset:literal
> +        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) @ $bas=
e:path : $offset:literal
>              { $($fields:tt)* }
>      ) =3D> {
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
> @@ -860,7 +860,7 @@ macro_rules! register {
> =20
>      // Creates an alias register of relative offset register `alias` wit=
h its own fields.
>      (
> -        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) =3D> $=
base:ident + $alias:path
> +        @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) =3D> $=
base:path : $alias:path
>              { $($fields:tt)* }
>      ) =3D> {
>          $crate::register!(@bitfield $(#[$attr])* $vis struct $name($stor=
age) { $($fields)* });
> @@ -916,7 +916,7 @@ macro_rules! register {
>      (
>          @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty)
>              [ $size:expr, stride =3D $stride:expr ]
> -            @ $base:ident + $offset:literal { $($fields:tt)* }
> +            @ $base:path : $offset:literal { $($fields:tt)* }
>      ) =3D> {
>          $crate::build_assert::static_assert!(::core::mem::size_of::<$sto=
rage>() <=3D $stride);
> =20
> @@ -928,11 +928,12 @@ macro_rules! register {
>      // Shortcut for contiguous array of relative registers (stride =3D=
=3D size of element).
>      (
>          @reg $(#[$attr:meta])* $vis:vis $name:ident ($storage:ty) [ $siz=
e:expr ]
> -            @ $base:ident + $offset:literal { $($fields:tt)* }
> +            @ $base:path : $offset:literal { $($fields:tt)* }
>      ) =3D> {
>          $crate::register!(
> -            $(#[$attr])* $vis $name($storage) [ $size, stride =3D ::core=
::mem::size_of::<$storage>() ]
> -                @ $base + $offset { $($fields)* }
> +            @reg $(#[$attr])* $vis $name($storage)

Mmm looks like this `@reg` should also have been added by the first patch.
