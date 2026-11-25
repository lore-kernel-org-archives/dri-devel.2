Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CCE606A32E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=Y3MSIUBR
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 350D410E90F;
	Wed, 25 Nov 2026 16:52:56 +0000 (UTC)
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021111.outbound.protection.outlook.com [52.101.100.111])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E6BCD10E956
 for <dri-devel@lists.freedesktop.org>; Wed, 25 Nov 2026 16:52:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CcJ24QpLJU7dDOeARVF0iOIZbvjJv/hEPVG0wKho4rI/OzuF04GmEeYFePYsyJNSqdkPtjjFCM2MF4JoInwTD4ot3i/7yo2h7DWRzan9AErO0iuUGnB5diRsOnIjglgHqkawev665kzcxSNU3WfzhPQ2UyPxIz1GKj1A5gxg8T26bUPFDmXP3buFK7nIeSfYmCJOmBJhd3RxBu84bsEsfaHcpqe+d5noNhJRZoLQ9vHJGhqijG3Kec/OsSGL8oiPX3kPukwF4NgRcY+VFWVegwD996/w3ofe5uX13gHevgvvijD44SLi+PDXdIWGeqw5Z2gTxQXDHc46AIlskpZarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YlKLU0VlLoONcPrBYzI3MeVizQ+VpbPatQ1gnO2yy90=;
 b=isxJrwXsN9CJfaIAxhPitpOGGS46kGoQVTVosk6XY/sFAvq3kG8YCOA7xseAz/a3cxD7nAy4VyAu/TIxDwf5m6YRgpTbluwuLOWFiBg0N8brjusyWVxka8wz1/oxlc0lMYn1DpzJfvQpdVDYHNdpfW/9p/pkMSNMvG8RrC0agKVEi+PhuR6PRvEHtUKn4TGdyvCshJeGh2LTDp/D1QG9HUFacdBm1smNY4WIKg4GiEcJp30sOGZU5U1dgI0Vp/gEz6nnHXqalAmsx8OgPXKlNoHlDOIzEA5bln1GYFBY6BGJMGqMeLgAgk3wRrVRvUjJsioPzZV3RSBEY+TQzGnFoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YlKLU0VlLoONcPrBYzI3MeVizQ+VpbPatQ1gnO2yy90=;
 b=Y3MSIUBRmxSvb4IHnX8xyk+pGjG9/k9cYBlmlKeJi7DbIvQCS87fIfTTnUwloYmpnfUXtwARz9rcvJ9ojbQC64ptx8RgPfxtST9D/zKfpmNJJU6OGioY6dxCw5I1dyJEV6F9L6SGNEN/fAjIvr9ORaTMNxb4EkiBUTyN8ilr8aM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CWLP265MB6198.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:184::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Wed, 25 Nov
 2026 16:52:39 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0662.004; Wed, 25 Nov 2026
 16:52:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 25 Nov 2026 16:52:38 +0000
Message-Id: <DN4G4XXREV0V.23XPC66L6P5L3@garyguo.net>
Cc: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-media@vger.kernel.org>
Subject: Re: [PATCH v2 07/10] rust: DmaFence: Replace is_signaled() with
 status()
From: "Gary Guo" <gary@garyguo.net>
To: "Philipp Stanner" <phasta@kernel.org>, "Matthew Brost"
 <matthew.brost@intel.com>, "Danilo Krummrich" <dakr@kernel.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>, "Alice
 Ryhl" <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona
 Vetter" <simona@ffwll.ch>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Sumit Semwal" <sumit.semwal@linaro.org>, "Tvrtko
 Ursulin" <tvrtko.ursulin@igalia.com>, "Paul E . McKenney"
 <paulmck@kernel.org>
X-Mailer: aerc 0.22.0
References: <20261124122951.878199-2-phasta@kernel.org>
 <20261124122951.878199-9-phasta@kernel.org>
In-Reply-To: <20261124122951.878199-9-phasta@kernel.org>
X-ClientProxiedBy: LO4P265CA0318.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:390::17) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CWLP265MB6198:EE_
X-MS-Office365-Filtering-Correlation-Id: 90a0ec6c-c28c-45db-032e-08df4b148408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|23010399003|10070799003|366016|4143699003|22082099003|6133799003|261009223027099003|18002099003|3023799007|921020|10067099003|56012099006|261026140227099003|261026121527099003|261022105027099003|261021123027099003|261021121427099003|261028144727099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: A5Pmiw3nfGgKBjsNIOyghU3DhzcKGFB6+PVeSwvk00iLv7fl47dgYiSXlgTfIADjtUYPZgjqM8b5yR04YktbWYMJtJoOEnTUttXwNutM2Ax03fEpOzUhISzq8qdfdAh2ANsqxSKwKqvjNQ+txXzaJDscEFlT9WJVsA9BTi5p71DDF/1CHYXaIx61AsTmze1zHkHruyOxi3Znw94zWV+R6mdSCJa1GymFozHzG0LurAO+2cPpdoyZETDgQz1wTAlBWdSxykpVFe10ROO3lMxvmhOnYL/HY89GK3sfu64q5tMe+IqMKqrV9GF5hz4Eij1Vzarq95LX6L/TcsKN44Sl0S4fUEhZREGZL6lWf8qfqMNF+d17qEek2dvYh7K2ddK0pht+Vho5oDn0PduLcR4QwGXPFy8DCfyGGb7YN5jmPzzy8sNqJTt9uJmXDceP2BAFgVcnsKwdgCV1jewx/hXlnTx+qtO8vCIRs31lQDktgXMu/vb+azs3FRy0xnPCy+ou3oyDZ8eQKl/CP6ouieb8Hs7LmyZA+TjuOXPmgg14nzyUKF1HAi2vHbnKjdKEpX1aOVTJPPszFESfHpPCvHkHOjXXqgwA35Idpdj/WoL3rtwEegvFMzY6QLeLhzOJLGT+NLntgt5RKKQNhx0X1T6XmuosIn1JzQAzM3+X/donIZbzl8987gxIMVGPVsMdyepccdUSBdh73BOH38+S2sWEYQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(23010399003)(10070799003)(366016)(4143699003)(22082099003)(6133799003)(261009223027099003)(18002099003)(3023799007)(921020)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261022105027099003)(261021123027099003)(261021121427099003)(261028144727099003)(261102123227099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eXVQRjBJZlMwOXlIeis5dWhqaGp0RjNqR2J3OUFmRlpoTXRYcy8yeDJzTU51?=
 =?utf-8?B?US8yeEtSUVY0bzZ2VjlTeG5TV2VSK2FEM0o4NEVqOFhxeTRnWUt0TjhNeXN1?=
 =?utf-8?B?QW1qRkxJbWZPak81NlNvNFdFOVRUVXY5ZzVub0xHK0xPYVFMVk9COERHbyth?=
 =?utf-8?B?ZTR1R0tCc3Z4Slo5dGhiUlNrWEZYdlF1K1o4ZGh3Zm1CZXVUV1NudDhGc1pq?=
 =?utf-8?B?empnTnpjNFZHcGR3Mk9DSDM2REhMZGo0NjljOGtGN2pqM3JEZ0JaRG9NQnh5?=
 =?utf-8?B?YW1jejUwa3FFenM1cVRQWklRS0tzZVBZTnZJZXpCTE9CT1M4NVlkUlY2R0xH?=
 =?utf-8?B?bjFkaFRzQjduaUNYOElXS3lja1dqcXBzNVhKanJpSTUxcFNjalBTc3c2YlhE?=
 =?utf-8?B?QXdWVVIxMkdmYnNocnVYcXMyc28rajk1MWplWEZCa3o2akZVR2tueXQrNk5w?=
 =?utf-8?B?cmNkTVpGc0ltdlRZN1lOdEF2N3JyWG5ZTm5YcWQzWGlBYzR0Ky9qRUcvcDQr?=
 =?utf-8?B?a1dOcndiYkhaSkl2VDdtTnZoSmczMHlHYnFpSm5WVXo4MlZHSkNXYWR5LzRG?=
 =?utf-8?B?MWg1Q0xtUCtiVlU3SVFoNmprSUs3M21EY2QzcW1OS2lGcCtodHEzdTdkQ0xn?=
 =?utf-8?B?cUNud0g2WGthUWl6SUZxM0k1TEh1OEM3YWhYYmljUjhPSi9OWGFrNUpLU0Q1?=
 =?utf-8?B?bi9ZVE03NnVQRk4xcThJc0ZyQXJERUpVN00wYWRZQStLbHg3UksyS3FHTExa?=
 =?utf-8?B?dGlEMUplK2tlVDFXU0xRVlBYalBkdFBsZk95R2pmck9WQ1JGSmZ1UDNSUHdn?=
 =?utf-8?B?bHBTS3RMRW93TEJLc3lhWFMydmE1VEhOK3QrbmoxUklhZUdaQ21pek9IN3Vq?=
 =?utf-8?B?SDZ3NlEwS3cvaVM3SkEzdE1Hc1Vuei85aVJZdVFOaTZYVTRya21Mbm10YTc1?=
 =?utf-8?B?cnVCNU5vZzkrWTFhcXI4enpvZFZMN3ZCaHNtK2RySnJqZXZKOE11dWNJbnZI?=
 =?utf-8?B?b0p5VGtaSndMaEx5MzZPbHBRUFRvQXdzaGdtekUybExjalZPVlpEZUxwU2xT?=
 =?utf-8?B?dTQxb3RnbDBtd1I4NElPSlFhT1dYOXVnbXRsMlVMWHRvUFVWczZoMDRqWHl3?=
 =?utf-8?B?c2xMWVh2bnIxUTkwc1RqT1JzS2s1ZXM1VTBFWlpZNVpwZGh5bFpJM0ZwQjNh?=
 =?utf-8?B?VWd6eW90K01DOXg4aVlkK004WWpSNW5JL21sVjZLRzZJWEhicm11ek5kNW9r?=
 =?utf-8?B?aHN5ZG5YalhqMjZBeDQrQThKWldvd2J3cUtkTk4xZURMVTh4S1B5TTRvV29p?=
 =?utf-8?B?VmVLMFFOVmVSVUFwQ2lzK0RCcWU4ZGV5bG54T3RxcUUrR2pIYjh1ejBOdzZi?=
 =?utf-8?B?bG1LV090QVkvdjhYL1VLTnlkWUhzajdPU1RqNFdSUjlEekFsRzJFRGlxTzJj?=
 =?utf-8?B?N3liUnZvWnI5L3NRSVdrSHBuZzlzZWRDblFHUW5STmlVQ0VrUlhJcHNSbWVx?=
 =?utf-8?B?Y09rMTZwbDh1QmJmZHk5MTVwZ1Z0R1pjdm40ekNKNnhWWFBZMjJwTEFFak1L?=
 =?utf-8?B?clRrbitBc29DQzRXZzFmOGNQZVNLd1BHYXFuRThpWlllSk01K3JaMTRSYkNz?=
 =?utf-8?B?cmNHclY1ZW5UUGp3QkhKSjlEbnhHZnZYVlhMZ3R1Qm9rTEs4eWE5Q2FoS0JW?=
 =?utf-8?B?bnM5d0pyZ0Y3dGd5L1NKd0gzTUFZT3dVRUM1ZXdQMTg2ekRlMER6UnFDbEpa?=
 =?utf-8?B?Rzc2ZGxxMy9wYS81UVNxQmlyWTg4M29ybFcwc3Q1QW1UdFFrZ05LRVBGdWdy?=
 =?utf-8?B?MFplQ0dZMU9LME9JK0VnaWlackYzK01XSlF2V2w4WjlmOHJMbFhFYUU4ZE9u?=
 =?utf-8?B?Mnk1L2hmZlpieWtUNDdXa0tOMmRab3U0Z294bkIxS2FUWlk0MHgrR1NsUERE?=
 =?utf-8?B?MXFGeUJwK2IrM09TUktWdDR3U25mTW5KVllETEtPTXBkNE42eWxDZE1aTVdn?=
 =?utf-8?B?WW42NW96RndjTUpLU2lnNjBBWTRkdVBFT0pqUHZBU3REWWhFdzdDc0FHdmJz?=
 =?utf-8?B?Y1VRSEE2UUJndnRaYW1Zd2NZMVIvQkFCaE5kQkxqYUNRU0NKa1IzT3pnd1B1?=
 =?utf-8?B?M3ByZVVTUDZtdVlaSGVXRnJGb1lNcUMrQ0pwREVjVlFtSExzTG8ySGFMNG56?=
 =?utf-8?B?NG9NYjVYR2hrMndXczM2VWhpbGFpcC9sQmoxT0swdDlyMVU4Q2xGZC90UE5H?=
 =?utf-8?B?eDJZQmtVVnhzcTk1b2RQNnFMRHEvbTJNNjFhMkFNRWdGZ3lOWDdZNm9Fek9R?=
 =?utf-8?B?VmZPRk1lSXM3Vm1XQit1NkRyRlUxOG1oa3R3STlLYmJDNGxzYi9ZUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 90a0ec6c-c28c-45db-032e-08df4b148408
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:52:39.7471 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tl67f788nFvyHf4vTK8f45XW4govf0CGGxZqQuJ3PQdnZHiLM4nopKc8KlAqJzz+xRHXROy8gXSsgjj/BuEM+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB6198
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

On Tue Nov 24, 2026 at 12:29 PM GMT, Philipp Stanner wrote:
> As it turns out, our dma_fence abstractions lack an essential feature; a
> problem which is partially inherited from the C backend:
>
> Despite it being a common pattern in the kernel, you actually should not
> just check whether a fence was signaled and call it a day - it is
> important that you also check whether a fence was signaled *with an
> error*.
>
> To make things more complicated, an error can get modified at any point
> in time before a fence gets signaled. Thus, it must be ensured that the
> signaled state is always evaluated before the error code.
>
> Since the fence status is essential information that must not be
> ignored, replace Fence::is_signaled() with Fence::status(), making it
> impossible to ignore the error code.
>
> Signed-off-by: Philipp Stanner <phasta@kernel.org>
> ---
>  rust/kernel/dma_buf/dma_fence.rs | 77 ++++++++++++++++++--------------
>  rust/kernel/dma_buf/mod.rs       |  3 +-
>  2 files changed, 46 insertions(+), 34 deletions(-)
>
> diff --git a/rust/kernel/dma_buf/dma_fence.rs b/rust/kernel/dma_buf/dma_f=
ence.rs
> index 20dadbde4eb9..09bebf9c1e4e 100644
> --- a/rust/kernel/dma_buf/dma_fence.rs
> +++ b/rust/kernel/dma_buf/dma_fence.rs
> @@ -510,40 +510,44 @@ unsafe impl Send for Fence {}
>  // SAFETY: Fences are literally designed to be shared between threads.
>  unsafe impl Sync for Fence {}
> =20
> +/// Fence-Status queried through [`Fence::status()`].
> +#[derive(Debug)]
> +pub enum FenceStatus {
> +    /// The fence is not yet signaled.
> +    Unsignaled,
> +    /// The fence is signaled. Might have been signaled with an error.
> +    Signaled(Result),
> +}

FWIW this is basically just `core::task::Poll<Result>`. A few benefits in u=
sing
it compared to define our own:

- It has `is_pending()` and `is_ready()`. So `is_signaled()` user can be si=
mply
  converted to `.status().is_ready()`.

- It has `map`/`map_ok` provided already.

- It supports `?` operator, so you can transform `Poll<Result>` into `Poll<=
()>`
  while propagating the error.

Best,
Gary

> +
>  impl Fence {
> -    /// Check whether the fence was signaled at the moment of the functi=
on call.
> +    /// Query a fence's error code and turn it into a [`Result`].
>      ///
> -    /// Note that this can return `true` for a [`Fence`] whose [`DriverF=
ence`]
> -    /// has not yet been dropped. The reason is that the fence ops callb=
acks can
> -    /// cause the fence to get signaled by the C backend.
> -    #[inline]
> -    pub fn is_signaled(&self) -> bool {
> -        // We should not use `dma_fence_is_signaled_locked()` here, beca=
use
> -        // according to the C backend's recommendations, that function i=
s
> -        // problematic and we should avoid calling that function with a =
lock
> -        // held.
> -
> -        // SAFETY: Inner `fence` is valid because `self` is valid.
> -        let ret =3D unsafe { bindings::dma_fence_is_signaled(self.as_raw=
()) };
> -
> -        // To be as robust as possible for the future we guarantee that =
an API
> -        // caller can 100% rely on the signaling being completed (i.e., =
all
> -        // fence callbacks ran), so we have to take the lock.
> -        //
> -        // The reason is that the C dma_fence backend currently does not
> -        // carefully synchronize the `dma_fence_is_signaled()` function =
with the
> -        // proper spinlock. This can lead to the function returning `tru=
e` while
> -        // fence callbacks are still being executed. This can be mitigat=
ed by
> -        // guarding the entire function with the spinlock.
> -        //
> -        // The fundamental reason is that the C backend currently does g=
uard
> -        // setting of the fence's signaled-bit with the fence's spinlock=
, but
> -        // reading is done locklessly.
> -        //
> -        // See commit c8a5d5ea3ba6a.
> -        let _ =3D self.lock();
> +    /// # Safety
> +    ///
> +    /// The caller must only call this on fences that are already signal=
ed. It
> +    /// must be ensured that this is ordered properly against checking o=
f the
> +    /// signaled status (fence->signaled bit).
> +    unsafe fn __status(&self) -> Result {
> +        // SAFETY: Safe by the function's safety requirements.
> +        let res =3D unsafe { (*self.as_raw()).error };
> +
> +        to_result(res)
> +    }
> +
> +    /// Query a fence's status at the moment of the function call.
> +    ///
> +    /// If it is signaled, return the fence's result, i.e., determine if=
 it was
> +    /// signaled with an error.
> +    pub fn status(&self) -> FenceStatus {
> +        // SAFETY: `self` is valid.
> +        if unsafe { bindings::dma_fence_is_signaled(self.as_raw()) } {
> +            // SAFETY: The fence is signaled. The C backend ensures orde=
ring.
> +            let status =3D unsafe { self.__status() };
> +
> +            return FenceStatus::Signaled(status);
> +        }
> =20
> -        ret
> +        FenceStatus::Unsignaled
>      }

