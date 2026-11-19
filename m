Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF452606A325
	for <dri-devel@archiver.kernel.org>; Thu, 19 Nov 2026 02:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=zLjIsjpE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2BDE210E09B;
	Thu, 19 Nov 2026 02:23:14 +0000 (UTC)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022076.outbound.protection.outlook.com [52.101.101.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E560010E09B
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Nov 2026 02:23:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqSyF+ZMVwxYDFyndq+7+bRKwuCQEIMWRq4kR4QXxaDYVvRdhe8z1sUeqnjcdVlupiMhQEwqjWvhC9ro4N1vrRVuRJO2yGNKY3dEVT3CA26LJwDvNHC3Om3BlRTYz83pU+35h2WGiagb1o9eNJqdDZNnpCc0aDp5fqntgCaIwBFTQWFX9azp8C1qVXZFanXKifL+rL1cCzsRYUoFLbuN0UxWWKRppNpH/temZnX7QMYMsW8c+++UPKabT0aFWkfF/dib7m7pKvBI2Df9fjaYu3fwH/IeYuKRsCdJdB8TxeEd8F4w/OOjk84Rr/IW9jyBZNlCblluApQxb7NMXqU4sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uc6Y1E8C0U6LojG8JQ1LU3RAt77CkUXXcFJBwN3DZ1s=;
 b=rP/n3kcUIn8r3VGdYbfhDmTAoZx9Fs9IUbOT+czi3oMi1RK55OKlJh06U1DvSXlcCqH2zk+VX/UrIwzFrUg4A+aRoz8NkB7mG280DI5vLzs6FX4nhl+D5O7wSgO+Gg0OmS3lSDTOyM4zZxyOESXsUSXB8xwzLV8VzAQs6i/FAAIFxfXqDyigtHov7rv7EYw2BVBlyT1wEKcEmHXBvtnBxuUIoxu+iLr7fO0cyAwt80WQYmproi7H/08RS3AR2m8swwVb6YU9D2GmMtAE/1oOVqX71sA6x7Uznflt68aPqUk4rN4rMMssps/Oae8GQW27Cn20OMnf+QVdnZfl2/QwVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uc6Y1E8C0U6LojG8JQ1LU3RAt77CkUXXcFJBwN3DZ1s=;
 b=zLjIsjpEvBMFnqoGHsVgxG8vjWVndmdvQQeV4sXH+FMvqWusQajtAkBntB0RDpKRotrE3nmWPuDLLMC4nvMxj/U6NPpnql8Xx4UgilhIJSgjt1ExzXjs07Yh2zdSuZ/zRPbb7ygnQko45fgvzBuzGoas3MfTRyTtFaB/wmpNnZA=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by LO6P265MB6751.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:302::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 02:23:03 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.015; Thu, 19 Nov 2026
 02:23:03 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 19 Nov 2026 02:23:03 +0000
Message-Id: <DMYTVUY54BWF.3LB7RP624VBRB@garyguo.net>
Cc: <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/4] rust: pin-init: internal: suppress
 multiple_bound_locations
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <aliceryhl@google.com>,
 <daniel.almeida@collabora.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <bjorn3_gh@protonmail.com>, <a.hindborg@kernel.org>,
 <tmgross@umich.edu>, <tamird@kernel.org>, <acourbot@nvidia.com>,
 <work@onurozkan.dev>
X-Mailer: aerc 0.22.0
References: <20261118233727.3147222-1-dakr@kernel.org>
 <20261118233727.3147222-3-dakr@kernel.org>
In-Reply-To: <20261118233727.3147222-3-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0145.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:188::6) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|LO6P265MB6751:EE_
X-MS-Office365-Filtering-Correlation-Id: 2625424d-5a54-4022-daac-08df45e40a3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|1800799024|7416014|376014|18002099003|22082099003|6133799003|3023799007|261009223027099003|921020|4143699003|56012099006|261026121527099003|261026140227099003|261021130227099003|261102123227099003|261028144727099003|261021121427099003|261021123027099003|261022113327099003|261022115727099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: dMAnaN+yZAraBUsobOiygkaKcFpZQ9B164mEpTKL5ffzQGIwoJeJNQUbdp7UbuIf0Sx2z2Rp77Fv2Ve7YW6pmLcXFkGhLWjD+6cMO6J6qazlOfAOBgOqm/cnYX12alozOhPKliPUwd6AxX/hG/tfG0HC5EcakJW3/IfaZ2ltDtdmjw8rhUl4IBa03S4n7/5QVlsHp74ucRa5G91KXz+zDwIuSBbwNdLOpLV3Lf8BpuDq6nWhJhSx9jFMLYTLp4XxicdgLu2DTRb4FNHpI2GuqlLKiD1Kr6SCEa9bP7v2WyCA1r7vO1QIz5C4TLUe/VTECxJkg3r/UZwOM7ikAq29PiNhpEH76N2wkUelmJn3KGIRSiWAVBzzxpSPzwzgCFg5P8aMry+238hy+yN+5/mAeHFdA3Yg+rxrGHByp/Ir7APtvrK+/Z8W8tiU/CmlW6V96oRcrWAokQAREOqrUcZZWuF2x29pcj+vgiZt1FVlnccL7elr8VIQ/3SA4bKhaj0vE/g2pdLPocRPFHjyTRtKaTa4SJqVwWiwI/i5FCPIHlLSIKJaK77jLW/6TMoMo+4z6tiL86YtJHFRGRIUJw+vxAsXqzQxJqKgyeMlrloF6/fa05V762TPR1sYprQbAbpHKY76SweRBSIwj+yKvddUwsV5P9llKSDJAqLMrLAuoqnORKoC4XO+3+f6NdWaCh/MHDkhXjG5dbhN6R2yO0CupA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(1800799024)(7416014)(376014)(18002099003)(22082099003)(6133799003)(3023799007)(261009223027099003)(921020)(4143699003)(56012099006)(261026121527099003)(261026140227099003)(261021130227099003)(261102123227099003)(261028144727099003)(261021121427099003)(261021123027099003)(261022113327099003)(261022115727099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ejd4WUdPRGZVT29vcVpFUDVRR3JiVVlvYmh4MUphbmJXam95N1M0NVdIRnJa?=
 =?utf-8?B?ckE4cFRSdWNGdzVpRUNJQXF1ZnhqaWtzNmc4Nm1LMEhYQnVSbVNFdi9vSzFL?=
 =?utf-8?B?Tmpuam9ENURQazhaVUNTK0JXOTA3TmtITURUUnJpQXBPenhpSGVxNGpINTdi?=
 =?utf-8?B?ZkpucnZCR3p2L2wxZWVzMThEK3llTExDY0xtQW1ZNE9JTDNGa0d6emZzaFEv?=
 =?utf-8?B?NWpxVTdjZ2pKNm1YN1cxdkpTSUt4eEdaY2tjbER5VFRvQzVudFRtR21RSGw1?=
 =?utf-8?B?cllkQ21xTUlySlo1cEsyWENSRitpRjUxR1pPek5Ma3EzRExNdHE0eDRBVUdM?=
 =?utf-8?B?elZrMHIyMDdzNkhjOGFrWUduSnRjazRwWmpmam9zVU9RZGJtUURIUVVwMjFK?=
 =?utf-8?B?OXAxaXpMMmFBMUNTUUVMOGw4NmltNFNxK0VRRGx5ME53MWhJcW1GQ09wQ3R5?=
 =?utf-8?B?N3RUdHVzZU9pTkhsajRXdFNRQjlTTUUyUkpVcjZoNlNROGJjZWVITUxqRlIr?=
 =?utf-8?B?bEdhcGZ5bCtMeTRDSXFsM1lyaDNsWXFIRlFwZFdYam9WbEpIbktlOU9zSEdB?=
 =?utf-8?B?TU1SaXVEQ1h5L3JRbGFpU3dxY0ZSZ2xjMEFWd0lzZjdnWHhaTlJmdk1zTzVv?=
 =?utf-8?B?bUh5L2JJMmVMZzllUnN3WHNENWs2eEdHc3VSS3NFcTkxSXdHUmJ1NmUxZ2E1?=
 =?utf-8?B?cnEyRkw2N3Mveit5QWd2VW9RVzFhcnlmREw4TmNDYmpBMW1hNG9NQTBhUHE0?=
 =?utf-8?B?aU9IMGo5ZkhWL21jZEd0MHlrOUF2bVoxWXlReSsvbUIvQy9DRkU1Q01NL3dK?=
 =?utf-8?B?Z1RsZkpxc3YwZW1iVzdsVnJicjd5MkxxU1hJcG50ZjdEc0tpUTBaeUZqZHly?=
 =?utf-8?B?SklUblVjWUtabHphYlFyZFVMeFlsMUhVdktheXRDb2JTNXhxcm5aZ0VRNjJw?=
 =?utf-8?B?cEw5YXQ4K3NndkphblNwRWVtQTI1TnJidTdsVzlxQ2pEU3dOVnVPaEdzL016?=
 =?utf-8?B?RUl2ZENLZEgvZ1QxRlRsdFNTbnk5T2lTL3Q1cDA5SHVqT0U2L0FhVTkyVkZa?=
 =?utf-8?B?U1NVV01pNVFGaDUrNHR6NVU0Z0FXV0lrOHRzTVNTVnhLL2EyZXh4T1JCdElV?=
 =?utf-8?B?Y1I4WUVQcWNaMFd6ZkxLTHRob3dZUjFYMjRub1lUSXI3ZGY0ZEloTEFZaGJF?=
 =?utf-8?B?QmtHbjZ4QThFcVdtanc4aS9yR0NoK0tsU09YcUNPakpFdTZVQzhaTXdZc2J2?=
 =?utf-8?B?WHJTYWdRWWZreGhhM1lKU1kvQlNKQjFPUWx1aWs3MmlEYU1IUVFETllMeFM3?=
 =?utf-8?B?SWZsQWVENVJJSU8xRS8zaTBQMVVldDloTnVkdGtCdFZVd3R4NnlsQmtvWHBm?=
 =?utf-8?B?anRxaUlXM3dEK2I4K2NmRWxzWWdlVzhnbjZ1SUxpMDdTRitQQTYvL3o3T3Zw?=
 =?utf-8?B?bit4dFROZ1ZjZ1BWVzVGNlpOQi85UFpneEVWZXFzMVpCWUE1TDJyVUJZQ1hw?=
 =?utf-8?B?eTNmbnIvWnZvanRjcHNlcjJsbDJIUjNGcG15aFhXUm80MUpnVUZjTUpVZVIv?=
 =?utf-8?B?ckdwU2tDOGVJYldFckQ0QTI0N0QydHRNa0orcUorRkxXMGZvSW42ejljT08z?=
 =?utf-8?B?Z2NRL0xZUTFXYUd6cDhvL1BGZVFtVS9mQUlyTzBZdk4xS1A4VU45amp3QllE?=
 =?utf-8?B?Y0pJVW9yOHdPRzRuNEcrbndXeThEaWNZSE53SVFoU08wUHhnTFg3a1NYdTVp?=
 =?utf-8?B?d2t2OVNESW9GUW5CWndSanVLTFlZVG01NlZ0Y3JzM094VDd1UUJQREVCc1Y3?=
 =?utf-8?B?eDNFYkJSV3lmcVpyc3MwaEZvRVBJUVR2VXV0a0txbjk2Vzd4a282QnN4QVV1?=
 =?utf-8?B?c0J2a2s4NWhYSlV0cElQdGN5TjIxejRaQ1JTQVFZZHFpdkFnQ0N2MXJMTXV6?=
 =?utf-8?B?T0lmUWNSdXJRbUdxd2R4d3krM1FTNVRvOEtsaHFBTTVGMFNqZkJIZ1JzZHFI?=
 =?utf-8?B?azV0ZlZ6Vm9ZQWFQRGg0TW4wTGJQUlJoKzBISm1wRnA4cWZwSDFwcW4yTXU0?=
 =?utf-8?B?UGNiZUNGbFdVRTR4b0M4eWkvLzZ4SEFuVncrS2dEcCt0encrQ08zWGJ5bmxo?=
 =?utf-8?B?VStyQ2hTWGRCOXVuTE9md0lwRGVVSGp2KzVCQmJsZnN4NHlJKzVsNzlsa2Np?=
 =?utf-8?B?bnNyZlJjQmhSSW8vSTU0VWNEZm04eFphRmk4dkhkUnhDZHkxSnpueThBTmRH?=
 =?utf-8?B?NHJqL1YyUGN4RmJkLzlENzRCM1VKM3Y3OS9tNjVxTFdjSVlVNEhJbUlicUhX?=
 =?utf-8?B?MXYxZnphdUJZRjJNN200QTQyZ216NURNa0l3amFxVzFDaVF5WUZLQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 2625424d-5a54-4022-daac-08df45e40a3c
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 02:23:03.7592 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vfhJLwz1QsnJrghZoaJaWH3pZ0WCsDN2Cwls/i3i333utBU5VTeb1DNZpkvXH31PdhrbeX+5ub0NbAZv7XbZeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO6P265MB6751
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

On Wed Nov 18, 2026 at 11:37 PM GMT, Danilo Krummrich wrote:
> The generated __drop_order_check() combines existential lifetime bounds
> with inferred field outlives bounds.
>
> For instance, for Tyr's Firmware, this places 'res: 'fw in the generic
> parameter list and 'res: 'vm in the where clause, triggering Clippy's
> multiple_bound_locations lint at the struct declaration.

This paragraph is sloppy. It is not helpful at all without context (and als=
o
doesn't describe the issue properly even with context).

Anyway, this issue is known and I ran into it in drm jobqueue myself. That =
said,
I plan to fix it with proper spans rather than band-aiding it with an allow=
 (I
also cannot take it as is without a UI test case to catch regression). I'd
recommend putting a `#![allow(clippy::multiple_bound_locations)]` for now.

Best,
Gary

> Allow this style lint on the generated drop-order check. This preserves
> all generated bounds and leaves the lint enabled for user-written code.
>
> Cc: Gary Guo <gary@garyguo.net>
> Fixes: 73cf61724648 ("rust: pin-init: internal: pin_data: support existen=
tial lifetimes")
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  rust/pin-init/internal/src/pin_data.rs | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/rust/pin-init/internal/src/pin_data.rs b/rust/pin-init/inter=
nal/src/pin_data.rs
> index 08e11128d353..b3c487999270 100644
> --- a/rust/pin-init/internal/src/pin_data.rs
> +++ b/rust/pin-init/internal/src/pin_data.rs
> @@ -1246,7 +1246,8 @@ fn generate_drop_order_check(dcx: &mut DiagCtxt, in=
fo: &StructInfo) -> TokenStre
> =20
>      let struct_span =3D struct_name.span().resolved_at(Span::mixed_site(=
));
>      quote_spanned! {struct_span =3D>
> -        #[allow(non_snake_case, unused)]
> +        // Generated bounds can appear both on lifetime parameters and i=
n the where clause.
> +        #[allow(non_snake_case, unused, clippy::multiple_bound_locations=
)]
>          fn __drop_order_check #impl_generics_with_field_lt (
>              // This must be present so the function can *assume* the imp=
lied bounds on the erased
>              // struct. For example, if the struct has `&'a T`, Rust will=
 infer `T: 'a`; we still


