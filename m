Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00FB4CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 11:53:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B02F10EC77;
	Tue, 19 May 2026 11:53:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="DuxGoxc2";
	dkim-atps=neutral
Received: from LO0P265CU003.outbound.protection.outlook.com
 (mail-uksouthazon11022118.outbound.protection.outlook.com [52.101.96.118])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6980010EC77
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 11:53:45 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uxT+eDSNgV40Imzkb+zVfKufByeeYIHCGYxvwR1NycXUN1reGxcu05Wr62jiKLgANT8NQV1Ih14HmcSPCKPFspk96ZofZDJiLpYt57TrKmGxXZ1ICxbJtSYH7TtsZqkFvCmkDBAQjI9WHf2x+zH46fT7eivKD5R6trgJofqS17JTnUCYmdX1jVGz7SsfYes7grt0if3ZxpI30XginnMogLx6RTQOHev3UUG33WQYeq5cJtlcXGzOq2wG3TKmJWgE4blQ4SKbMrepr0RFNd/6wl3b0YsJIjQFrkU2VHWN/bF98qxRnfImsZOTZPwFz69zVbEgRAj3IdZWkvVvhmc4tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pTXRZxVmvWAHOpHXacaNrioiukQw1U5/hBLvbyA75tM=;
 b=xZ+veUYGcqmZ5duLDgV16ws7hxsTTgHa0sPy8/wHHHw7UCxlYT7vcuFu6DfDlrAqs4cFZxARJE25r5CY2AAPSeKfO5NQSeVLOwalrVlShGZobFTQV84+3Gx84AqL3V8SogG4fPFWPqIfFuzUjT1ofjNZrsaj/E2ag9HucRzQdpaYJuWqU59vFGjwQwoZHE8IWBdnQ7DtxzbomiRHmpL12Xx6QhtYQRAg6FPQEIf7QgW/5xxA/IuqS5DxdXTXZj2yPfQglnwrcnLnSEs+wGdhS+rA3m4Mj4ji5QhNmzGzJGEylsnDVSXgl9SXxcJNsui3K19/O7QnttUttsMSEGyO3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pTXRZxVmvWAHOpHXacaNrioiukQw1U5/hBLvbyA75tM=;
 b=DuxGoxc23mOFNZ8M3x9P/iW94u9v1r+iGKV3A42zB9Tneqx6gvq63U80TLOo9x8wfot2gYfCA7eEuaGsSBUL8veEn6W68eDjsXeUPyGlffWQy8B5NnrC4zj/aRodCsK5giKVhA2/vFxtHDtANQHphh5iHDe2lwyKjcTiHeC5xbE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LOBP265MB9378.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4bb::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 11:53:41 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0025.023; Tue, 19 May 2026
 11:53:41 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 May 2026 12:53:41 +0100
Message-Id: <DIMMSJ6GO6XE.2D3RYBTZ45EW1@garyguo.net>
Cc: <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-modules@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <nova-gpu@lists.linux.dev>
Subject: Re: [PATCH 2/8] rust: driver: make `DriverModule` struct pub(crate)
 in `module_driver!`
From: "Gary Guo" <gary@garyguo.net>
To: "Alvin Sun" <alvin.sun@linux.dev>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Luis Chamberlain" <mcgrof@kernel.org>, "Petr
 Pavlu" <petr.pavlu@suse.com>, "Daniel Gomez" <da.gomez@kernel.org>, "Sami
 Tolvanen" <samitolvanen@google.com>, "Aaron Tomlin" <atomlin@atomlin.com>,
 "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Daniel Almeida" <daniel.almeida@collabora.com>, "Arnd
 Bergmann" <arnd@arndb.de>
X-Mailer: aerc 0.21.0
References: <20260519-fix-fops-owner-v1-0-2ded9830da14@linux.dev>
 <20260519-fix-fops-owner-v1-2-2ded9830da14@linux.dev>
In-Reply-To: <20260519-fix-fops-owner-v1-2-2ded9830da14@linux.dev>
X-ClientProxiedBy: LO4P265CA0146.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::18) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LOBP265MB9378:EE_
X-MS-Office365-Filtering-Correlation-Id: 61aee033-93c5-4e41-b99d-08deb59d45b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|366016|376014|7416014|921020|22082099003|56012099003|4143699003|18002099003;
X-Microsoft-Antispam-Message-Info: 8oDYc+JC5aavX+2anCTvQ0MmIRw3luom3RGOisj801MUTwfWV4JgvucPWsxQpRRtZNeRO+FuZskEsM6ENSFWbcjF0tg0dpTAKSp3wDT+l5qIstO/fg885QiJe8kbHNes9M1Q1S1grf5h71Ig2FIdz6BWBh66Ua6BeuNbaDy/Tkn28nf9tBY/v3g1YcvjMZFHhOWCpG6HWfPgL4lnqJNAKdu0Imw2dDU7UKvyWIV7j99mVYEFVOBpfKQPHJ8j3uKGcQTXbq7GbUilRtj3XRHCLtY8RS5Y8DrcwWCPTNSHmvWJLOYn5HsM0ILZk8KftFiZc4jXF7M1TJAfqLIn3JAB/vAZlbjRLmGZ2bZ188/LzSIEL/4cD/nm+6cyVFO2tTALPDTYmX+t/2wK65EsjcNA2KENpM9/5cR1qbYP3ZCy5QOkiDlHHVN6Td7vBYnyIPXyOOW1Xo3RWFhitebvTt06ICMsYu4qtK5/KimvaaFVdfNfUXNk35JaMLB2S7ykdNFutJV3Tokkt9IcLK5JzBMNPwAPUCQfKmtCsmlzeSxR2nNqPy1Ur8bPP7slq8p0G3fTEvuIJy8ygO7yPpD/02tfwLXqRRCu1iSnAzduMhoH7ooaz3pKTcrfroR5RW7s4kbvKX+XWlC6vwW3iw360Eo1bKSljsXEnIkUMRLMXuIFg9fxEN7g7GJRDR2MDEBB4XRnSZlUSIVzXwsJTpoVOEGF3U5Di92NUokmSHKnNFfPT1g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(366016)(376014)(7416014)(921020)(22082099003)(56012099003)(4143699003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dDBndThEMHhma05WVGhCTmZUcjI2dWw4dlkveWJpV2V0a0dPUUxWQXJOVkZq?=
 =?utf-8?B?d0JRaU9QdjgxRXpkN3o4ZHhRc3E2Z1c5ZmNSRFlJN1FSeDA5WXNobHB1am5x?=
 =?utf-8?B?eXRsR09haW53dS9RNmhJQmx5Q0pCQUF2NFhBS3VSTEtIWENSV21ZQnZ6SVFy?=
 =?utf-8?B?TWJIY05HS0twTE9valVlZy9VeHQ3dzhEQUxIL1JiSzYvekI5VGdOQjdVUFk0?=
 =?utf-8?B?dEdKQnNKYkFXWVJEMkZqclY1bVVIN2Y3YWw3Y3RIVkFubjU0OFNEN2dUZFNl?=
 =?utf-8?B?TVUwRk1uQjZGdk95ajQzZkZ0RnVmOUEwU1dlMDZSSjAxTWRWRVVoaXc4NTlt?=
 =?utf-8?B?b0ZiWkhlZkxBdVhXVSs2czlVbm81MHUvVUhUNnlPaVVFVS9IVUtLY05xTHNq?=
 =?utf-8?B?QkxseGc4NVptNVFCS2Z1QURVNUV2ZWs1OXhNNUl2SUZRbFc5NjcrME9FTDEz?=
 =?utf-8?B?MlJ6akhRTGxjNDVJMnJiUEIxaVBNY0RIQ2RpSVRNMEkvWWd5VERzZm5DWDlE?=
 =?utf-8?B?cVNVNnIxSmhvRXFYT2lIaUNZRUM3TXA1aDV1K2NSdkpLNklWcFRybm55M3lB?=
 =?utf-8?B?Mk5heWVFWVh5M0ZMRFU1THpjSk5vTzI1dG5OZ0VpSFpLQ1AvalY5dzZKTFdP?=
 =?utf-8?B?RDRYclZZSFdnd3BWdk85WHBrZXJBZVQ3UDFzU09qY1pGQ2RxWTQ1TXVMMTkz?=
 =?utf-8?B?YXYyZFFuaDNLeHhGQ3JOK29xMlJsdm9MZFVsM2E3UEJSbFM5L2Y4NkJhS3Jx?=
 =?utf-8?B?RUVaZzlpVERnTE5UNmlMOE1VdStZWGFTQ1Eya1MyMlRON2k1QmsxWC95eDNj?=
 =?utf-8?B?dWxBeUExaFRoWGowajVDRjh2WGVlRm9waCtRdk1RVmxMU2ZUQlRUWWxkQ3A4?=
 =?utf-8?B?TjFVZk1CWDB2VUg0cXozVW45SkJGcXBNSDBFblAxeFRMc0EyQ0prWW5ZS2Vi?=
 =?utf-8?B?Z1dOQm1YOEZEYkh0UER0anBacytUaVhmSFM5QWlBeEovTVd3MXpVZTE4cHpz?=
 =?utf-8?B?anpNKzFVbkJ1Y21TRkgrcjBCNmtwbFhOTlNxNXlSSU9QN2F1cjN0U3VCR09G?=
 =?utf-8?B?c1hJMlN3cVcwekhuZlcveUZ2a3JwV3JybE9DY3BrTlRvT2VPQ3JCNnNJdElH?=
 =?utf-8?B?eThpMGxMMUR1clRDTXo4ck9iaGpybEdERmxzZ2IwbTNseG5QeVFpbWZONzRL?=
 =?utf-8?B?Z01ZTVZnZERqNGRZQmhZR0VsVDdyRVkyN0ZEOFpscHlpNngvRjNLQjA1Y05P?=
 =?utf-8?B?OEJVRnFZSW4xSjI1dHJmZW5nc2dJNEVwOU5xMXNER3ZKSW5zY2hkY3djLzQ1?=
 =?utf-8?B?UndRWG9vd0Z3ODI2Q1lvWmpvSENHRGRrQnhzVjhLWUZ0bkwzTzlDYytJMG5l?=
 =?utf-8?B?U2tCQVllbURuUU40NGhha0VCU09QYktjK3JxRXVGbXU2RVZWNXNYN1k5Y0JP?=
 =?utf-8?B?bVU3aGIvYUJmRnhKUTl6NVN2NDRVWElFdytSKzl5YmNDMFF0NGZNTU5aY1l2?=
 =?utf-8?B?aW5UTk1mRnFzNmNHeE9lVDZ6V0YvVEdpY2FsUHJoNVVpb0ZWNGFhV2srNEFo?=
 =?utf-8?B?a3B4L1RnNWZOZXR0UG4wclJTZ3BXQS9QZ2ZFWnQ0WmNick9tRjVBNzBjcDYv?=
 =?utf-8?B?dUQ0UkY0czg1NDNjYjZ1Y1JzQUZvSTd5aFM1SndxMmcvRktGWGpkZ1hMbkRl?=
 =?utf-8?B?YnFlMERQdmQrLzdpVEl4WEpKUjRKTVlNYjhkSTNWakEyQVZJY3c3dURjaWEz?=
 =?utf-8?B?K2IycGdhc0VldkpTQkhEWHZOSlVqYWUwWEt0TlE0U29CRCtSWmZzS204R25l?=
 =?utf-8?B?eC8weHNNNGFSampIVGJCYUJ0S2lzbWN6OS8wSHJGWWZOcDdqRElLMTNrTWs5?=
 =?utf-8?B?UU84MWRNNit1OUdZc1FMeUo4ZnZBRU04b0puSU9TblRKNG9ITE9jSmtCMHpP?=
 =?utf-8?B?RTB5aU9FMUduc0V3OHJrZ09ZMjhVL3pBcHJXMjEwWE42UUxKMU1qMHZLV3VU?=
 =?utf-8?B?anA3YytxdTdjMFNVaHRYSjhxelJTNVlQdWMxaVFPWHoxZjdTZnZwMDRDdFQ0?=
 =?utf-8?B?aTBRRHFFWUM5NURoNitXUEkyV2VRNGRDSSt0azl1akFtMmliRXZyb1htTXQy?=
 =?utf-8?B?VFEzVzNVWXM0cDAvcjlFVytGUVF4OHdVL0VndFBiVy9ZRCtVWXAwaVJLMmV6?=
 =?utf-8?B?d0ZNOElnUE85amRCNG9DeGhTeENVNURrNW9McVg3OFVrYXBlY1VFUzRKdDdp?=
 =?utf-8?B?ZlFEU2pPSDVDZ3RkTGVRajlZOThHV3kwbGdtMkkrOWJIOCtRcW5adGEwbXkw?=
 =?utf-8?B?NnJtbTl4OFQ5THRvNVZLRXNha1hyZmI4aVpad2FwTm4wUzdCL1F1dz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 61aee033-93c5-4e41-b99d-08deb59d45b2
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 11:53:41.8044 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jAreAyZdSGxs2xeHfzCBMIexwBBcafTcAYM4Awmygi6GZen6D90m+dpLRgrunqd01aPX2UsHEVTo5XnKvQWdjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOBP265MB9378
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

On Tue May 19, 2026 at 7:26 AM BST, Alvin Sun wrote:
> Expose the generated `DriverModule` struct as `pub(crate)` so that
> driver implementations can reference it via `super::DriverModule`
> for the `ThisModule` associated type.

Why is this needed? Child modules can see items super modules.

Best,
Gary

>
> Signed-off-by: Alvin Sun <alvin.sun@linux.dev>
> ---
>  rust/kernel/driver.rs | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/kernel/driver.rs b/rust/kernel/driver.rs
> index 36de8098754d0..9c7c69c4d2af0 100644
> --- a/rust/kernel/driver.rs
> +++ b/rust/kernel/driver.rs
> @@ -253,7 +253,7 @@ macro_rules! module_driver {
>          type Ops<$gen_type> =3D $driver_ops;
> =20
>          #[$crate::prelude::pin_data]
> -        struct DriverModule {
> +        pub(crate) struct DriverModule {
>              #[pin]
>              _driver: $crate::driver::Registration<Ops<$type>>,
>          }

