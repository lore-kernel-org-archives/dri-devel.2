Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A97606A326
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 12:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=ImjH9EAm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7CDEB10F249;
	Mon,  9 Nov 2026 12:37:06 +0000 (UTC)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 400E710E23A
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 12:37:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l71ydot825KCRZOZN+YEChodgLNaztn/A3yDQXdafOs91fkWlyiYnpAUsDGwtTjNusqD3Jge/6vnJ6tWIrFWVtkdu5mwMgU94kMgBac7D/7THcRxJCPwj+DQk1LAO1tGBsDSTc9mbndeuPcDbgNDjwQjTYCUifCSnCMa8vAmwzmuPyb1q1Z50x7kALTtp9e3MbcDEudETMU4Zq+BlKaKK1fwoQOPewJtAUeB0mRGn6d2p+oePGkFvfa2smOd3qr9AKlVOG6g3OB1F5qk4puVXOV1Zi4cxPSB4WuNhlL2TaVJu/agGW3NXO+qcUV1ezIOj4OBsMT81HddiyKTfgYWcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5m26hNla8AA5a0v99z0TJqne9KvBHvpo9h3CD9oTpO8=;
 b=oreasm6X+GJrRLp6X9M77BiRLkqL96HlBBvpPqKHZlO12lk6JYhxY4pRA9wTiKnpwCOGGtdYNHXI1IrMVS5piUI1Tz7jnhygHNNxt5AQ1TRGaLl5E89N0YIjd9Rv36Kp1UYp2r/6wVZuaEeemQh7FZnX/6we0jBXM6c8SsE2fZrRuAfibHA4EXiugYqOCPOoA6tYKBEHJ2pb4VWM3v38BEw7lnDR1Z05F2RThwF9schYeMwvV0lnTcxxl1drDz1PoTXnFi+ZJWAIZQRWInUBa0uVSeoAdDj7Rb4z1GbiMf52YPdQmDDi2u+xiodD0MVjj2SxWBw/LkToVfEAQ6FTIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5m26hNla8AA5a0v99z0TJqne9KvBHvpo9h3CD9oTpO8=;
 b=ImjH9EAmZZ1etVlPUYd7i8sf+q+qFtB+hC5r058OspYMDqvPiU934Ql0xuvidOglIgeYWyJtLvFHdPa5s0K3UyMA25Dlcw8vPbKyJIZOZcGMJTJyOp3498EpP1CP0UNNY/oZJbPqm7EwE+U56COidxwtgnv469PPiURAWd4/sjI=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO7P265MB8937.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ea::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 12:36:55 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 12:36:55 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 09 Nov 2026 12:36:54 +0000
Message-Id: <DMQOOESYWNCC.2SKYV8O6YSYOA@garyguo.net>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "John Hubbard"
 <jhubbard@nvidia.com>, "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi"
 <ttabi@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v11 4/5] rust: id_pool: do not round capacity up to
 BitmapVec::MAX_INLINE_LEN
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "Burak Emir" <burak.emir@gmail.com>, "Yury Norov"
 <yury.norov@gmail.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Danilo Krummrich" <dakr@kernel.org>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, "Tamir Duberstein"
 <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>
X-Mailer: aerc 0.22.0
References: <20261109-chid-v11-0-082aa9bf5a91@nvidia.com>
 <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
In-Reply-To: <20261109-chid-v11-4-082aa9bf5a91@nvidia.com>
X-ClientProxiedBy: LO4P123CA0113.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:192::10) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO7P265MB8937:EE_
X-MS-Office365-Filtering-Correlation-Id: b0f3e5d6-b8cf-49eb-a69d-08df3e5e2346
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|7416014|376014|366016|1800799024|18002099003|22082099003|10067099003|921020|4143699003|56012099006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Dup4aDr3NL1tkSVLzQYco0ZzWDbXhqSy926arjDAZ7ttfgny0EWoPHFBpdbT2+brJJiWoOpd5VzteB9O6OEwsfhgXHSjTFZ/Rbbts/BwpQd5J58ZxVBxrbh7smaVOmRSUD2MwuHZ0XjC090Qb6ahFd8YK+YkIEiVYvMSU+CThy3kVNWZVj3Hy7nRC87jHqSZS59+CgWxHQI9l7ekqayLM2p0wEvxQ9i+i6tDj9bxca9IIRmrt6Vdpk3ao8knaYZyFairaw5m/kDnekdOJZLWlhPfzdFS1DolONEEvMwgyyP0MIZwCTTKIeuzHMdW5X53StoWaUjfqKKWTbB45W+RwmFQnOnF1lcUr2mPE7v+yxP1KWzXZtbCGRK0tQOjuJGFshMsbnyoh4tQtpyjZ9SItqnH8K9cA2JHjaDJ6ICekWG8+iURX4hD+Xdi8nMQEEmAP/iVcUCKon8gsm/rBwMhN8CG/44kg4y9Qfo7Lo99iEmq7QEe0IJCi4maQIcGgz3bTgKmWnvZspAkQ3PmIjRVhEUX+mlWMum3lkV2N+kaN+vieUCiw+XYy3da9Ml/iUo+jsDhF468Xe3/OJJwvgLr0C7/5t5SEZbTyjnqMjBlqzG0NfjL0T7eSFOh6tvZQSLI5D6UulMewCCOKgz4+DLEdTR6X0COo3bcaSn+OQBK99C5Vw7dGQc1kDPxMuFRY/9pKgOuDoDFRJDQZkh2pFOYPg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(7416014)(376014)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(921020)(4143699003)(56012099006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bjdUYUgwSGNmdWNYcG1GdmhuNktmRnZyL1JIN2lEdnllZlNEcG5XakdNTU5i?=
 =?utf-8?B?eXI0QXhjQ0lvSklmbWR5ZTB2eXphaUpaalFicnJzcTFDbE9FdXZTdnhsRzNl?=
 =?utf-8?B?ckpGMVhKbnpneGZleGdQb010U3pDWmZZQnRKNnhKWENiQkJGOXh6VnhxV2lP?=
 =?utf-8?B?SDVjT09zWGJ6a2ZjMjU3THhRWFV0SlozUWNkMXJpSXp0WEFqMU9ueFR2K0RS?=
 =?utf-8?B?NjRiNEszUzM4M3FqcTFyU01hYlk5Z3VmNjNuQkhJeWZCRmora0RYVzVVeEhZ?=
 =?utf-8?B?R1VlOFhxRm9pSXZueThjeFFTL1g4OVR3T2YwNXlIN0xYZWxLZnVFVzlDaklz?=
 =?utf-8?B?d3lQNTJieUMvaTVNSUs1QVo5VzhtblhGd011aGxIOEVVVHZ0VHpFNVNxY0lq?=
 =?utf-8?B?OVpQLy9uSExIK3IxZ1Y2T1ZyQWQrZ0ZZb1o5V3ZtancwRjc1T3RsQ1R3REw4?=
 =?utf-8?B?RDJndkFqNUd3WE5VVStWMGVFcmNzQ1hKekpyb3FwQ0lzREdDWjh1OFVFS1NJ?=
 =?utf-8?B?d0tiOTRabmdnYlErYTJDbE15QVB2QXpoa0tIMnhGSm4xRXdqYjFUalZKdjNh?=
 =?utf-8?B?eDk3bkZlbG9vNlZzeHBUcGtQdjJTUHNYV0d1M0dJdk1TL0ExNDhOdTNYR01n?=
 =?utf-8?B?MGVZWkRDNExZNGRTRDdmazBjZzJPdGRScENSYmwwSFJIWk5yVEg3b2J6UGFB?=
 =?utf-8?B?NDBoU05GaFRhMUpTTnM5SjdIeHovTUdCaFp0ZW1BMXJ2L2hHejNQNFlpY3NB?=
 =?utf-8?B?emlyWFJ5THlESTZQQTl4b2U1K0pTdG5UTmc5aTZwSlN6aWQxUzFHNDdaaEZo?=
 =?utf-8?B?SEJCc0s5RDZsQTNNSXdQd3NvLzN2VGVsaVRCT29tMkxMUGRtZ0FmMkp1bkZr?=
 =?utf-8?B?aVZNcUpseEREN3hoTFI5anlvaUV0aHZMWlU3MEE4dGpGa2ZIYnFXRlR2WUlZ?=
 =?utf-8?B?eUdNWWYyVHBJR1QyTVpuMmI1UWJSMzdxWWlRY2xVYXVoenNDQ2NOSDd0Uisr?=
 =?utf-8?B?SWVHYWtzeFVmTFVqenN6aURldU53M1hhV0ZDcnRVZFFwNlhlWjcveERoYnB5?=
 =?utf-8?B?emw5emloTDg2eUFkdlFlYndhd0VYUzF3SGNMTDUxeHJ3VjliWC9lZFhNNzlM?=
 =?utf-8?B?SXEzajVZU1owOXAxUnYyaSt6WUdkeG1pVk9Kem5pZElBZXlVM2NpWUdPZEwv?=
 =?utf-8?B?THZxT2Zub1U4eXdUejNSZEtUWVRSemR3bEl3UmFlR2ljYXErdXN3elhPYnRT?=
 =?utf-8?B?YTA2MEMwS3ZsUVFGNzZnL1BrZ3BkV24wcDhkSFE5MDUrNno4dTNRSUQrU2ND?=
 =?utf-8?B?Si9tb0dvdnRlNHU5K0dlMGpCOWMxT3ExNkZad3B0ckJKWFZrdXVyM2tXVG1x?=
 =?utf-8?B?NXprRmxMQnRUZ2xTV0lBUVlJUGxxdExQbEU3TG5icFNadXhFejErWWt4UDBo?=
 =?utf-8?B?RGdEWDhzNk4vYWNIczhaZzhKNFJPOEpidDFHTWxab1owYXhWUEp3ZjlkalJx?=
 =?utf-8?B?azQ3Qk5wb2JETEdzQ1VVZ1RoQ0dJV05zNll6ME1uU05OSjluTCtZSlJXQTQy?=
 =?utf-8?B?eHJrTVdSZHFPNTBSZ0M0YUJDeThOa0N0emZTVkUrTmxaMGZMcEo3WXdBOHRw?=
 =?utf-8?B?RUNMendSSmJBQUZrc3FVekl3TmdBYjJ1b2VmZ3BSamlldkFVRktrakhrRk53?=
 =?utf-8?B?ckw4aVA0ZjVTSGFIcUJSdlYvWTRwRnhlYTZ5bm5rNnM4ZEFKdzJROUxYaDFa?=
 =?utf-8?B?QWNkNUdHODIrOG43dnNIaCtYUFVtYjcxbDZZM2pkb2VzckVRRkpvVFcxelVO?=
 =?utf-8?B?NGlNL1BCY0sxVzNxTWc2MCsvNU02Q3huYWt1QUlkZ1YrWTlSbnBmUCszSk9l?=
 =?utf-8?B?L3ovSFdBQTFtbGZnQnkwT0FJQU1mTG5TdDZjRnpTczZHZU5YbmE1U2phQjFo?=
 =?utf-8?B?ZU1kY0pVZHc3bDFrdWgxdStRemthanByeHA2S1pyNTZ5blBFd2MwNy9mVUh4?=
 =?utf-8?B?WThvRkFoMkN5ZVh0ckNDaHhVRFhiZFhNRWFWMDlCeFMzVGMwTDlpRE50Rlh5?=
 =?utf-8?B?QzkvSmJLMmU3OVlTRGkxUkd6dElRZnB1MDN5VnRydUJBb0tvL3BEbUtQbFZ0?=
 =?utf-8?B?OTFxUCtpSlZlUEdEUHZSeWllWnZ2UDdFWkJGd2xmK2g5MG10YklONDVvbGgy?=
 =?utf-8?B?RHVZdE9HNXBYTTIrYW5WajlBTjVxMmR4QzgrSUFLTmd4b2lkNzUrSHg5d0R5?=
 =?utf-8?B?SUZGMVpnTXZuL1BUTko2OVBnNTBCYUhLeHJFS0dmbVZQU0RRd1RGaTFxNE5P?=
 =?utf-8?B?bm9ONDhBSkNaSkxFLzBuSG9QVENwTWx3VVNNcTBZN2V0TFFBNitrUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: b0f3e5d6-b8cf-49eb-a69d-08df3e5e2346
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 12:36:55.1451 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0GubjrCeqFk0G51+pNo+F0fSoNAuUs5qYI/6hGVvmN+6HkTvHjuGJrae5Y2da6kf4JbLg5WKY8CIpL+4IqQCDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO7P265MB8937
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

On Mon Nov 9, 2026 at 8:32 AM GMT, Eliot Courtney wrote:
> Current code in IdPool::with_capacity rounds the capacity up to
> BitmapVec::MAX_INLINE_LEN, but BitmapVec::new works fine with values
> smaller than this and still uses an inline representation. Remove this
> behaviour.
>
> This allows specifying a real capacity of 0, which was not previously
> possible. This breaks `grow_request` in this case, so change it to grow
> to at least `BitmapVec::MAX_INLINE_LEN`, mirroring the capacity floor in
> `shrink_request`.
>
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Burak Emir <burak.emir@gmail.com>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/id_pool.rs | 38 ++++++++++++++++++++++++++++++++------
>  1 file changed, 32 insertions(+), 6 deletions(-)
>
> diff --git a/rust/kernel/id_pool.rs b/rust/kernel/id_pool.rs
> index 92eeb7caa243..f77bd90325ff 100644
> --- a/rust/kernel/id_pool.rs
> +++ b/rust/kernel/id_pool.rs
> @@ -112,13 +112,8 @@ pub fn new() -> Self {
>      }
> =20
>      /// Constructs a new [`IdPool`] with space for a specific number of =
bits.
> -    ///
> -    /// A capacity below [`MAX_INLINE_LEN`] is adjusted to [`MAX_INLINE_=
LEN`].
> -    ///
> -    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>      #[inline]
>      pub fn with_capacity(num_ids: usize, flags: Flags) -> Result<Self, A=
llocError> {
> -        let num_ids =3D usize::max(num_ids, BitmapVec::MAX_INLINE_LEN);
>          let map =3D BitmapVec::new(num_ids, flags)?;
>          Ok(Self { map })
>      }
> @@ -152,6 +147,13 @@ pub fn capacity(&self) -> usize {
>      /// let resizer =3D alloc_request.realloc(GFP_KERNEL)?;
>      /// pool.shrink(resizer);
>      /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
> +    ///
> +    /// // A pool at the `MAX_INLINE_LEN` floor cannot shrink further.
> +    /// assert!(pool.shrink_request().is_none());
> +    ///
> +    /// // Neither can a pool with a capacity below `MAX_INLINE_LEN`.
> +    /// let small =3D IdPool::with_capacity(8, GFP_KERNEL)?;
> +    /// assert!(small.shrink_request().is_none());
>      /// # Ok::<(), AllocError>(())
>      /// ```
>      #[inline]
> @@ -198,12 +200,36 @@ pub fn shrink(&mut self, mut resizer: PoolResizer) =
{
> =20
>      /// Returns a [`ReallocRequest`] for growing this [`IdPool`], if pos=
sible.
>      ///
> +    /// Grows to at least [`MAX_INLINE_LEN`].
>      /// The capacity of an [`IdPool`] cannot be grown above [`MAX_LEN`].
>      ///
> +    /// [`MAX_INLINE_LEN`]: BitmapVec::MAX_INLINE_LEN
>      /// [`MAX_LEN`]: BitmapVec::MAX_LEN
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use kernel::{
> +    ///     alloc::AllocError,
> +    ///     bitmap::BitmapVec,
> +    ///     id_pool::IdPool, //
> +    /// };
> +    ///
> +    /// // Grow goes to at least BitmapVec::MAX_INLINE_LEN.
> +    /// let mut pool =3D IdPool::with_capacity(1, GFP_KERNEL)?;
> +    /// let resizer =3D pool.grow_request().ok_or(AllocError)?.realloc(G=
FP_KERNEL)?;
> +    /// pool.grow(resizer);
> +    /// assert_eq!(pool.capacity(), BitmapVec::MAX_INLINE_LEN);
> +    ///
> +    /// // Grow doubles if at least BitmapVec::MAX_INLINE_LEN.
> +    /// let resizer =3D pool.grow_request().ok_or(AllocError)?.realloc(G=
FP_KERNEL)?;
> +    /// pool.grow(resizer);
> +    /// assert_eq!(pool.capacity(), 2 * BitmapVec::MAX_INLINE_LEN);
> +    /// # Ok::<(), AllocError>(())
> +    /// ```
>      #[inline]
>      pub fn grow_request(&self) -> Option<ReallocRequest> {
> -        let num_ids =3D self.capacity() * 2;
> +        let num_ids =3D usize::max(BitmapVec::MAX_INLINE_LEN, self.capac=
ity() * 2);

It looks like your want the `IdPool` have a controlled capacity. However, a=
s
soon as `grow_request` is used, the capacity becomes uncontrolled.

It feels that this actually means that there are two use cases here: unboun=
ded
IdPool (where capacity just means the _current_ capacity) and bounded IdPoo=
l
(where capacity means the _max_ capacity).

This is more similar to a difference between `len()` and `capacity()`. It f=
eels
to me that you're merrging `Vec<bool>` and `Box<[bool]>` into a single type
where it shouldn't.

Best,
Gary

