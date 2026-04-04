Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40ECBE88D9B
	for <dri-devel@archiver.kernel.org>; Sat,  4 Apr 2026 13:06:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52F5710E3FD;
	Sat,  4 Apr 2026 13:06:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="lD3kUr+e";
	dkim-atps=neutral
Received: from CWXP265CU009.outbound.protection.outlook.com
 (mail-ukwestazon11021102.outbound.protection.outlook.com [52.101.100.102])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 68B7410E3FD
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Apr 2026 13:06:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YuBHVwYYfJVoP2tzG4Bp6qyTbpo1DB2B5UY4XCOyq35+9N7Fib+Zv+ldlIcMPJLJZXLvsEtcY/oT47qy7q6Ilgyz9+MfYsa7k332pCxvH0cjtKM6i9fEjncGN5m/hADfKWsuj9holAkPb5hruJ0c0diaaOrTUoV/yubT8ruIgi54BEnHhXM2SwZ3AShpoQj8Oj1Ww8e6TX1NYQTXx1d/1w5EDHg9Bjfnx9D8II2cVrx+FpEYnHS+dP+6GDnC1Y1DN7G6pWAXoRKjAvaAswXGa20u+yAGk7aFqapABhWNqkGQq/nTuDlCrBUnbyqo6sfET2MA2ffTCKTjrHwX6KjDaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sqb0tmJlJCHyold/ZWwzPKTkYRKPmQCQplJhTUGw4OA=;
 b=cmR1f63UXuB2/3oXBeUU+a0BMOabLpd0gmznfytMANU2pWTgYAad3G0Wy2Dk7ybIQgJQVO3HGZUgc9fXqVWHl1Er6Fwcm9kdIeBAIALms7vNFoinbt2omgT3N02nZJPi3IhlIUtAHCrauK52Y+Yy/lbZyFmuMAuH1B4Eg7mBmi6n3OnTCJK/VJaFib6v7ZI6XkMyvbI23maB3bZdnZtmMiMeH2XkkRrAKd3K10KgRsWk/gJsYQQimjeCqHDgsHRMx3aZCRTgpOOMOGwk2I+qnLF49kjYHLK+eC/zAfuDFGTA6uoReNS98AXWJSXWbqIIMJF4JXbvwp+REUM2i2FOMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sqb0tmJlJCHyold/ZWwzPKTkYRKPmQCQplJhTUGw4OA=;
 b=lD3kUr+e0yTMs5qnsZRzlaVQmaL/HO1MPyz0YjuUsk2vOdn7LjnNoPkTNSvcmx5G6LnXHAlCeWTpDZhuJt/Oi79T5zqqYOG6Ymxys8a8A3Q61bx0LVr27Jc9sGAUpa/n6+y65lTXBRykba7mywiKXM8nFvsY0xkEj2e38986yZ4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO9P265MB7417.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a0::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Sat, 4 Apr
 2026 13:06:42 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.20.9769.016; Sat, 4 Apr 2026
 13:06:42 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 04 Apr 2026 14:06:41 +0100
Message-Id: <DHKE5WW9QSVQ.31QE6KK92PU8R@garyguo.net>
Subject: Re: [PATCH v5] gpu: nova-core: gsp: fix undefined behavior in
 command queue code
From: "Gary Guo" <gary@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Alistair Popple" <apopple@nvidia.com>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Joel Fernandes"
 <joelagnelf@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>, "Zhi Wang"
 <zhiw@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <rust-for-linux@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260404-cmdq-ub-fix-v5-1-53d21f4752f5@nvidia.com>
In-Reply-To: <20260404-cmdq-ub-fix-v5-1-53d21f4752f5@nvidia.com>
X-ClientProxiedBy: LO4P123CA0143.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO9P265MB7417:EE_
X-MS-Office365-Filtering-Correlation-Id: c19c956e-09df-44a5-88f6-08de924b03f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|10070799003|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: bLiRECxjZCnxZnrZZT5AkUMKwpEmtXyh4OJaU96vrgIUCwfegJabA0mxQ/bQi9BDoqoebYry8l6aVajJQcTWascRqLhsCp/ymvlvo/SB9K8lmEvEvmH41c1a+ySChzaji3HV7hrKz6epDzwLG8tpAH1U1ztQNVjqHgpVos8FjXf2PGxCKMqPaW4FXkoZtu0CNerILvngHHVKb1NoQkxL5vT6pC3DXntaUn9LNMAmBYk2ep8qjgo/G6886F68Aw2L8LTXKSZ8E/V6v3yzZR26Q3L4/9UEIoOkhOWt8sJGDHON3jFGcuVlD4/zxZrZ6ZYScYH2lozIEGDLiU8Mm2PvrLsZv/zUQCkT7btKsLv98Q/DLegGUEM+GWjNWqOP9rUOVOLDnUo7xOmPW+o0b0nk4Fu506XB80/HDdSG3E8qHJ1pQ0iA8n18Hz6XoZX9CXpIta690cW512mK/6w7iOqHYxSHeeHXQm0/s2YbPQfxzQLLPsiIYcaSTNgTAHlni6dsxxq6G1ALVMY4HSXj7aE1EHz2qH8JPnB+vflCaq84O+JdFVrsHjg/gRFLUvRfqdhFXNgeL359WuD0j3eGbwxOvU5aOpattRir0xwM8Qe88hjnspZ/gpcKe9mRH5c6mIM1lWxlnEFiLtaXyTmMAixDnXvIsgnfA82OTlWA1xOmnWxH1hUeS5uWj4+sXwxTCxiY
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(10070799003)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFpUYzIvcUJvN0pTWitXWCtkRHA1dnZ6QkxBMXBvOWJsbmVZOEphaS9CWFIv?=
 =?utf-8?B?ZUVNS1o3Z1FQQ01WNEdkVVlTWlpqOHVSMVBxYlBFSWM5OHpQTzJidnRhcnd4?=
 =?utf-8?B?TU9PZGVHQ1NZdmh5OXJuWUV1amFSWDdreVhQbHhkTjliN1QyT0dqb2JwWlo1?=
 =?utf-8?B?Tk1PSXJLS1VhZVBoc0c1UFg4WVBnTE9oaCtQbVUzbDJSN3BCZ2ovcGpqWGxk?=
 =?utf-8?B?cmpNLzR0MWNrcnZlMS9WdGJYTzAveVJwL0FXeC9tRURCaTBoRTNubjJIM3Nw?=
 =?utf-8?B?RWhNUjNERWhCTEtDRzJxZ3JrbUp3dFR0UmllWmdZTmc2eFlGWkY2TlFkVGY3?=
 =?utf-8?B?OUcrNExVVDk2MjlEMEFpaFJIbC85bzdIU2xHN0pxdXlORUpNTU0yVHprNXl3?=
 =?utf-8?B?eWhOa3hCMkEzZWZncUFOR3Y3RHVMR1VpV08rVkVhSjk5cTRnM05wVFdtSk5m?=
 =?utf-8?B?RUVVT0NGcHlRaGtudjQxQlUrMzhBYkVuR2F6ZVFGaVViRS9naThLVjJZcksy?=
 =?utf-8?B?NU1HZmkvL0RBM01MOFBnMlJ6WFpkSnR0dW1mRHVUWDlHRkZvTkJKRm1FWTVF?=
 =?utf-8?B?aDRhM2JoUjgweWFYV0J0bWczQUo2aDBrcjNNOEJIUGwzOXdSVGVOTm93K0Vm?=
 =?utf-8?B?RldCa0JQQnYrQmhjZHpQSHM3aFZLMTRVTFhOWk92cGk3VjkrakpUcHlnRGJu?=
 =?utf-8?B?a3hnaEtqYkFRTmNaZm04eGViM29ZNGw4QVJLOWJ0L2hpMll2dFc0eHpsTkdP?=
 =?utf-8?B?RUd2UUhTdlNqNzJxbmRBRXY2c042R0hOd0huRksyUkZMTTgweGdXTVg3QW5o?=
 =?utf-8?B?R3dBUUw0RWpZanZNaEFlNkMrTjMyS0hoWmplUEczWG1obXEzSkdhZjczeFBk?=
 =?utf-8?B?LzdQRGpHMC9sUkI4UjAyTE4wMXY2UHNaZ3ZlbVZ3cXNOZTFMUzhlNkhSeE1v?=
 =?utf-8?B?Smt5ZTdYTW1pTFRRTHBkTzRiYW5ZV1Q3Q2hCcU5zRDdWNXhTSUJXTTJLRkxF?=
 =?utf-8?B?V0dyYk1hSFR2eDBZcjArZldyanBURTBLVlVwQTUrS2R0bkFya0trbXJEVGhU?=
 =?utf-8?B?eUdJTDZxVXhXZTYxTmYyYncyeWZXWmZWYlBnQVprcHAwUlQ2YTJTL1hkOGd6?=
 =?utf-8?B?TDV6SDMxYzhsMmt3a3hzYzNndkRlQTJuZ0dXMTF2eGd2TGgwb0xvMGR3L3Zw?=
 =?utf-8?B?cDNFYlE1L29DNVVkcmZHYVkwbHZFSUhsWFl4Zml1TkZGSzVzZUJoU3JwaXJK?=
 =?utf-8?B?alRYSU93L0FTQnJ6endIQzB1cTl4V0JhQ3VKZSt3cHVYSzhxWWVsdUZEL25E?=
 =?utf-8?B?ZGNrZXZHVDQ1czdvcXpMZzNwQk92aXlleHlNK1RSL0c1cXREYTVEMlVSTmNx?=
 =?utf-8?B?eFJYbytsNDdZdjYvRU5nYWtOaXRRRWJxNWkrb1RjdGx0b0g3U2c4ZzNSOXBF?=
 =?utf-8?B?V0ZxR3BEdXU3QUpmSFE2UHkrQlEyL1dFTzJnZXpQZDI2TEMxcFBZNTh0cHd4?=
 =?utf-8?B?aUt4VWMrWXNhVzlZdGswVzIzTXNaUVBoM0VDYVl1VS96dWs3SW5mTVIyeVZP?=
 =?utf-8?B?Yi9SWUJkSWRiWkhEUjVmMWY0c1ZwcFVsZWlOTFdBaG5NdFVqc2VLTkhwS2NI?=
 =?utf-8?B?YXRMV3ZhNytBejQ3dVNBeHErQ0cxZ1duOXN0aEEzS0NoK2xnWmcwNFFkemlp?=
 =?utf-8?B?emg3aURyOEhiOERIYmpuNjlGeng5YnYzdFZxeXBwUnYyN0hTRUhSTW1ucHBq?=
 =?utf-8?B?bnRIWE5KamNPWlhza1lDcE9teUdmWGNieCswTmh5N3lldzluNFJhZGh1Wnll?=
 =?utf-8?B?Wi9wN1hOdTJ2dzFnM2IreHdzbUJ0ZWFsQUpVNjBSa2hScElHSHIxVlJUejJj?=
 =?utf-8?B?S2pIZE1vb2lYT0cwK3pKYTlBZ2xaQlRWUjNtekNJemptTisxQm9VQXJqUGU5?=
 =?utf-8?B?cStYNkxXbVltazJoa1VOSkNCdlAwOXM5QVRLNURZR3FmTFFkMkk0Zkh2WjVy?=
 =?utf-8?B?MVBnNmFXY1pvVWVFMm5UY1g1VFNyKzd5YTdremxpT2lRZlpva2pTZXdXZkxR?=
 =?utf-8?B?RE4zRXhWbVhuUzZVZ1YyWDRwMlVBb3BUZi9vTkJVeGROQmZDMS9waGt1dzB6?=
 =?utf-8?B?NGlSOThVYVJmRy84T2NtYmh4WkIyTk5yc0JVYmFSR2h1RnRtQWU0R1VmaXox?=
 =?utf-8?B?QkRyUHNnUVlwVklFOUpoV2ZFaW1QckNKc3plS1Y1b0ZmWGVMNlVOYjNpMXFY?=
 =?utf-8?B?bjZ2VWYwWmVFcGxBeiswdFJjMFJoUnM2cVlwdDZvTVhMUFdrRFYwK09GWGc2?=
 =?utf-8?B?aWFLMVJuZTN4WlZnaGlUNEU3WjFialF3anh1REM3ZlJEbjZ4Q2VLZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: c19c956e-09df-44a5-88f6-08de924b03f4
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Apr 2026 13:06:42.0503 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eHzNMaBMfMg3pUZ845jDPNFhNEcknkFb5zWugwkhJVuI9Uuy/4LbX6/+PGSOBXuhTeR0B3w8q19LhedpzHu0lw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7417
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

On Sat Apr 4, 2026 at 6:04 AM BST, Alexandre Courbot wrote:
> `driver_read_area` and `driver_write_area` are internal methods that
> return slices containing the area of the command queue buffer that the
> driver has exclusive read or write access, respectively.
>
> While their returned value is correct and safe to use, internally they
> temporarily create a reference to the whole command-buffer slice,
> including GSP-owned regions. These regions can change without notice,
> and thus creating a slice to them, even if never accessed, is undefined
> behavior.
>
> Fix this by making these methods create slices to valid regions only.
>
> Fixes: 75f6b1de8133 ("gpu: nova-core: gsp: Add GSP command queue bindings=
 and handling")
> Reported-by: Danilo Krummrich <dakr@kernel.org>
> Closes: https://lore.kernel.org/all/DH47AVPEKN06.3BERUSJIB4M1R@kernel.org=
/
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
> Since we are still getting `build_error`s on some configurations, this
> revision reverts to building raw slices from computed ending indices.
> ---
> Changes in v5:
> - Eschew pointer projections with runtime-computed indices to avoid
>   spurious `build_error`s.
> - Drop `Reviewed-by` tags since the code has changed significantly.
> - Link to v4: https://patch.msgid.link/20260401-cmdq-ub-fix-v4-0-a9a9cf98=
2485@nvidia.com
>
> Changes in v4:
> - Make some methods providing the `ptr_project!` invariants inline.
> - Use code paths that preserve the invariants `ptr_project!` depends on
>   more obviously to fix these testbot build failures:
>   - https://lore.kernel.org/all/202603280326.ucDKVaf2-lkp@intel.com/
>   - https://lore.kernel.org/all/202603281331.1ESuqgfz-lkp@intel.com/
> - Improve safety comment when creating the mutable slices (thanks Danilo!=
).
> - Link to v3: https://patch.msgid.link/20260326-cmdq-ub-fix-v3-1-96af2148=
ca5c@nvidia.com
>
> Changes in v3:
> - Rebase on top of latest `drm-rust-next` (with `Coherent` patches).
> - Use pointer projections. (thanks Gary!)
> - Link to v2: https://patch.msgid.link/20260323-cmdq-ub-fix-v2-1-77d1213c=
3f7f@nvidia.com
>
> Changes in v2:
> - Use `u32_as_usize` consistently.
> - Reduce the number of `unsafe` blocks by computing the end offset of
>   the returned slices and creating them at the end, in one step.
> - Take advantage of the fact that both slices have the same start index
>   regardless of the branch chosen.
> - Improve safety comments.
> - Link to v1: https://patch.msgid.link/20260319-cmdq-ub-fix-v1-1-0f9f6e8f=
3ce3@nvidia.com
> ---
>  drivers/gpu/nova-core/gsp/cmdq.rs | 116 +++++++++++++++++++++++---------=
------
>  1 file changed, 69 insertions(+), 47 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/cmdq.rs b/drivers/gpu/nova-core/gs=
p/cmdq.rs
> index 2224896ccc89..569bb1a2501c 100644
> --- a/drivers/gpu/nova-core/gsp/cmdq.rs
> +++ b/drivers/gpu/nova-core/gsp/cmdq.rs
> @@ -17,6 +17,7 @@
>      },
>      new_mutex,
>      prelude::*,
> +    ptr,
>      sync::{
>          aref::ARef,
>          Mutex, //
> @@ -255,37 +256,46 @@ fn new(dev: &device::Device<device::Bound>) -> Resu=
lt<Self> {
>      /// As the message queue is a circular buffer, the region may be dis=
contiguous in memory. In
>      /// that case the second slice will have a non-zero length.
>      fn driver_write_area(&mut self) -> (&mut [[u8; GSP_PAGE_SIZE]], &mut=
 [[u8; GSP_PAGE_SIZE]]) {
> -        let tx =3D self.cpu_write_ptr() as usize;
> -        let rx =3D self.gsp_read_ptr() as usize;
> +        let tx =3D self.cpu_write_ptr();
> +        let rx =3D self.gsp_read_ptr();
> +
> +        // Pointer to the first entry of the CPU message queue.
> +        let data =3D ptr::project!(mut self.0.as_mut_ptr(), .cpuq.msgq.d=
ata[0]);
> +
> +        let (tail_end, wrap_end) =3D if rx =3D=3D 0 {
> +            // The write area is non-wrapping, and stops at the second-t=
o-last entry of the command
> +            // queue (to leave the last one empty).
> +            (MSGQ_NUM_PAGES - 1, 0)
> +        } else if rx <=3D tx {
> +            // The write area wraps and continues until `rx - 1`.
> +            (MSGQ_NUM_PAGES, rx - 1)
> +        } else {
> +            // The write area doesn't wrap and stops at `rx - 1`.
> +            (rx - 1, 0)
> +        };
> =20
>          // SAFETY:
> -        // - We will only access the driver-owned part of the shared mem=
ory.
> -        // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> -        let gsp_mem =3D unsafe { &mut *self.0.as_mut() };
> -        // PANIC: per the invariant of `cpu_write_ptr`, `tx` is `< MSGQ_=
NUM_PAGES`.
> -        let (before_tx, after_tx) =3D gsp_mem.cpuq.msgq.data.split_at_mu=
t(tx);
> -
> -        // The area starting at `tx` and ending at `rx - 2` modulo MSGQ_=
NUM_PAGES, inclusive,
> -        // belongs to the driver for writing.
> -
> -        if rx =3D=3D 0 {
> -            // Since `rx` is zero, leave an empty slot at end of the buf=
fer.
> -            let last =3D after_tx.len() - 1;
> -            (&mut after_tx[..last], &mut [])
> -        } else if rx <=3D tx {
> -            // The area is discontiguous and we leave an empty slot befo=
re `rx`.
> -            // PANIC:
> -            // - The index `rx - 1` is non-negative because `rx !=3D 0` =
in this branch.
> -            // - The index does not exceed `before_tx.len()` (which equa=
ls `tx`) because
> -            //   `rx <=3D tx` in this branch.
> -            (after_tx, &mut before_tx[..(rx - 1)])
> -        } else {
> -            // The area is contiguous and we leave an empty slot before =
`rx`.
> -            // PANIC:
> -            // - The index `rx - tx - 1` is non-negative because `rx > t=
x` in this branch.
> -            // - The index does not exceed `after_tx.len()` (which is `M=
SGQ_NUM_PAGES - tx`)
> -            //   because `rx < MSGQ_NUM_PAGES` by the `gsp_read_ptr` inv=
ariant.
> -            (&mut after_tx[..(rx - tx - 1)], &mut [])
> +        // - `data` was created from a valid pointer, and `rx` and `tx` =
are in the
> +        //   `0..MSGQ_NUM_PAGES` range per the invariants of `cpu_write_=
ptr` and `gsp_read_ptr`,
> +        //   thus the created slices are valid.
> +        // - The area starting at `tx` and ending at `rx - 2` modulo `MS=
GQ_NUM_PAGES`,
> +        //   inclusive, belongs to the driver for writing and is not acc=
essed concurrently by
> +        //   the GSP.
> +        // - The caller holds a reference to `self` for as long as the r=
eturned slices are live,
> +        //   meaning the CPU write pointer cannot be advanced and thus t=
hat the returned area
> +        //   remains exclusive to the CPU for the duration of the slices=
.
> +        // - The created slices point to non-overlapping sub-ranges of `=
data` in all
> +        //   branches (in the `rx <=3D tx` case, the second slice ends a=
t `rx - 1` which is strictly
> +        //   less than `tx` where the first slice starts; in the other c=
ases the second slice is
> +        //   empty), so creating two `&mut` references from them does no=
t violate aliasing rules.
> +        unsafe {
> +            (
> +                core::slice::from_raw_parts_mut(
> +                    data.add(num::u32_as_usize(tx)),

The code would be simpler if these `num::u32_as_usize` are just applied to =
`rx`
and `tx`. But other than that the code looks fine to me.

Reviewed-by: Gary Guo <gary@garyguo.net>

> +                    num::u32_as_usize(tail_end - tx),
> +                ),
> +                core::slice::from_raw_parts_mut(data, num::u32_as_usize(=
wrap_end)),
> +            )
>          }
>      }
> =20
> @@ -308,26 +318,38 @@ fn driver_write_area_size(&self) -> usize {
>      /// As the message queue is a circular buffer, the region may be dis=
contiguous in memory. In
>      /// that case the second slice will have a non-zero length.
>      fn driver_read_area(&self) -> (&[[u8; GSP_PAGE_SIZE]], &[[u8; GSP_PA=
GE_SIZE]]) {
> -        let tx =3D self.gsp_write_ptr() as usize;
> -        let rx =3D self.cpu_read_ptr() as usize;
> +        let tx =3D self.gsp_write_ptr();
> +        let rx =3D self.cpu_read_ptr();
> +
> +        // Pointer to the first entry of the GSP message queue.
> +        let data =3D ptr::project!(self.0.as_ptr(), .gspq.msgq.data[0]);
> +
> +        let (tail_end, wrap_end) =3D if rx <=3D tx {
> +            // Read area is non-wrapping and stops right before `tx`.
> +            (tx, 0)
> +        } else {
> +            // Read area is wrapping and stops right before `tx`.
> +            (MSGQ_NUM_PAGES, tx)
> +        };
> =20
>          // SAFETY:
> -        // - We will only access the driver-owned part of the shared mem=
ory.
> -        // - Per the safety statement of the function, no concurrent acc=
ess will be performed.
> -        let gsp_mem =3D unsafe { &*self.0.as_ptr() };
> -        let data =3D &gsp_mem.gspq.msgq.data;
> -
> -        // The area starting at `rx` and ending at `tx - 1` modulo MSGQ_=
NUM_PAGES, inclusive,
> -        // belongs to the driver for reading.
> -        // PANIC:
> -        // - per the invariant of `cpu_read_ptr`, `rx < MSGQ_NUM_PAGES`
> -        // - per the invariant of `gsp_write_ptr`, `tx < MSGQ_NUM_PAGES`
> -        if rx <=3D tx {
> -            // The area is contiguous.
> -            (&data[rx..tx], &[])
> -        } else {
> -            // The area is discontiguous.
> -            (&data[rx..], &data[..tx])
> +        // - `data` was created from a valid pointer, and `rx` and `tx` =
are in the
> +        //   `0..MSGQ_NUM_PAGES` range per the invariants of `gsp_write_=
ptr` and `cpu_read_ptr`,
> +        //   thus the created slices are valid.
> +        // - The area starting at `rx` and ending at `tx - 1` modulo `MS=
GQ_NUM_PAGES`,
> +        //   inclusive, belongs to the driver for reading and is not acc=
essed concurrently by
> +        //   the GSP.
> +        // - The caller holds a reference to `self` for as long as the r=
eturned slices are live,
> +        //   meaning the CPU read pointer cannot be advanced and thus th=
at the returned area
> +        //   remains exclusive to the CPU for the duration of the slices=
.
> +        unsafe {
> +            (
> +                core::slice::from_raw_parts(
> +                    data.add(num::u32_as_usize(rx)),
> +                    num::u32_as_usize(tail_end - rx),
> +                ),
> +                core::slice::from_raw_parts(data, num::u32_as_usize(wrap=
_end)),

Same here.

Best,
Gary

> +            )
>          }
>      }
> =20
>
> ---
> base-commit: 7c50d748b4a635bc39802ea3f6b120e66b1b9067
> change-id: 20260319-cmdq-ub-fix-d57b09a745b9
>
> Best regards,
> -- =20
> Alexandre Courbot <acourbot@nvidia.com>

