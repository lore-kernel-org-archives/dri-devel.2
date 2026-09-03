Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BCC3C624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 13:20:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A2E8910E0F4;
	Thu,  3 Sep 2026 13:20:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="FlSXLSdA";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022097.outbound.protection.outlook.com [52.101.101.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6E8B910E0F4
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 13:20:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eY7fiWpox0F3wO9B1D1/74ewHuQzK9L3hcfWQg7bbnmtMrBrbEYpdKt+ZXN2KCeZ3m1GTFaiK5b0SNYJ2iUiENfWcEdDKaGGhkyYYTxHtwadEV9qyKh4KnkyHFW7E146owm0TUT1nBDgqNbZRNAYzpFkko0n7URKZWovru2l/+5wT6d0nbshOWelYOMjwevtNVzRSTFfcd6esDYiWt4buF6WmT3mldHMSpH2PLFDQZhY3FGRSdQ/ovsm9VoRzoAw5vjM5K4qAyyU8KAuMpavfQo+wcuYGkijNti1aSIutMiOM1gKWJBcpb0vY7dmiLwFM5apmuWoSzkX3blsqJl9ZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNt/ZMNK+dNwL6z11Icp8owVsswPcfZIlfm1I/ZBpkU=;
 b=Y1ZiefTXATcLfQ8gv27J+bhfGlEEzMn+kvinNNT5apcNE180kzigZEwMJiK7+BfSJiO1IqBTsd4/aOXgeyOVP1uctc7VjH6haW1gnD7VW1H7k+6kFu1wPzShQtu6O0Bd2GC1u00jVyZJmGitUg4MZchon0hy7/4TOx5aH8EyOVK33HDfrWrQ9G9sdLiWrqJKX7JeYD+byMX+R30Esb6MFTLLt/zNZh2pTmAqFFynLlwkDyWNfNPITacYe+ZDTdUq1j2jvDbVt2YvXnKwEvXQLNbARN9aYPHGTzSt0PABNEmvvZAXT7aKRb9Lmw0EHLcnoTKCWP5yQpV7jqYY8wl3xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNt/ZMNK+dNwL6z11Icp8owVsswPcfZIlfm1I/ZBpkU=;
 b=FlSXLSdALuISrmUWIEG50DZOE2ttU9vljGf++6wtsZXLbUoVsZkPn6Yj2/yOr5p+Mb8RY1e0N6NDGZqI3QST8Uh7yJpTuXJrqgP2llcmcRaya9V5Fi1FNwTXCXze+YHqojgeNuY8oJBYBCgg0XEFwpPdoAKvpL22vwnR5DB/rlc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by CW1P265MB7925.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:212::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:20:08 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:20:07 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 14:20:07 +0100
Message-Id: <DL5PMZZO1S7X.3BMZVKVUMYVM0@garyguo.net>
Cc: <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 4/4] rust: dma: tie Coherent and CoherentBox to the
 device's bound lifetime
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <a.hindborg@kernel.org>, <gregkh@linuxfoundation.org>, <rafael@kernel.org>,
 <aliceryhl@google.com>, <acourbot@nvidia.com>, <ojeda@kernel.org>,
 <boqun@kernel.org>, <gary@garyguo.net>, <bjorn3_gh@protonmail.com>,
 <lossin@kernel.org>, <tmgross@umich.edu>, <tamird@kernel.org>,
 <work@onurozkan.dev>, <mmaurer@google.com>
X-Mailer: aerc 0.22.0
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-5-dakr@kernel.org>
In-Reply-To: <20260830193824.471089-5-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0481.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a8::18) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|CW1P265MB7925:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aeb359e-e7f7-4f6a-bfb4-08df09be130c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|7416014|10070799003|366016|921020|4143699003|10067099003|22082099003|18002099003|3023799007|56012099006;
X-Microsoft-Antispam-Message-Info: 9E8pytqBsCQL5I2w11zwYs9mki8cJAP+g1UIou2kqHNGSHTBJ6u8KumHHh+inY5woDngmOMtDAQPJ8KgGuntQK2+z7pBFTxirhDa5NXhIzaVq9XWROkqzuxATMp44hrDPtaiw6V5+hJGHBprXO2DrdgHkBLzN4sUImheYlwJiAh3VpRIvey3FD9QGmJmQRLykIj/4JjNAm0HHhtqxV+bX17Bg68gmYBFOhiBu1LQbBGk8DDf69JYrWSHhRKxP9kDxAUPc19jSJKdUl8UMZd4wDL1CU3PAhLDRe1UdKiF9g1UjwhwYwQAqFhEVtiQPFUHqDqDXKy4pP6YVpknaCnazOVlwAbYV/GCyJOtgXc6J4Vw8SMxC1sEcCe4C/BCpxjI+kfeEZRXJb6AHp/1AfRaLctDcqWd5Jt5qdkiMxozul4RgsTuhpQe6Eegkh7Atnb1xaDQE+d/KnhyvvmJgDXNbB/BsVREMrrmNRXL5ikXlVBDWhw5qTN+Z80es0g0Si6zKx0ZnXFzNS9rgLrvBE4JXlMX8twpAsJVnQvaONyyP3oT+eO/zpXZT++7YuAr0tJjeV/ET0vnOl5EIhA4cdZGqVUGQZTXTegdL+JQWc44ttMfVcoemdYNSaFpc99rmGuilzJcgT8G8EBt0nj6bTdFykEeL7+4JtgfwsTEEqlyXnD6VGGZBq/B0SszfMo69Qf63i+LiEh480wlomLgXSdqOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(7416014)(10070799003)(366016)(921020)(4143699003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UGViTnREYkQvS08wWEtZUXVrTmRtQXpJdVFuUW5Gek9zbXNKSTY0ck41dFM0?=
 =?utf-8?B?VXFwYnZHTjBJVldFRlBhTUI1a041bXlDN09wZnk1RnRsL1RVd1N2dThzNlVH?=
 =?utf-8?B?NGowcWdPNllUQWxJNjNkbUpOZzl6MFpab3ZTU0dxQTU0WklTc2FJWGdrcUls?=
 =?utf-8?B?M2tVWGIzZ2I0SXBxdDFDa01TOFRWQW9VQUUybFF4aGFqWUtvQTl0YkszSmFO?=
 =?utf-8?B?R1hYTUpyMlVnRVJRZGhpcGxGcUpya2FBMVRvcFJFeDdYaGd0djkvaG9qQXNJ?=
 =?utf-8?B?UnhNem1pTVRLcDkwNFJDK1AzblF2ZUdWZWpmakMzUHJrYW1TZXoraFFqTE9t?=
 =?utf-8?B?T2JCbHlvc0ZyeHdBeEdzOFM2Z0xudlNhaGhnRkRpRGRUV0czcE92ZFdrckVn?=
 =?utf-8?B?K2ZSaDlBY2JZVXNON1M0NkFNdUY3aGxmUlZqbE91a1FXYVc3eExJL1VNZFlE?=
 =?utf-8?B?K0Z4bGJ5amx5YUNSUStPMWtGODJyVmIrYkR0OEZFRGhoOEZlenBhMXk3R2ty?=
 =?utf-8?B?WGRJem40NktCcDJMZUZNdTl4RWd1bjQ5blh4eTlZT05MWk82WTVzakVaM29C?=
 =?utf-8?B?ekZ6Qlp6V25pNzZFWDZOMVhFL2xWcXlhNit1NU8wOGRrbDB2RUZBakxTcDVq?=
 =?utf-8?B?SWwrMkRTTzRGRTFXT2RhZHB2bFc3NXhvSnlSRXF4S0lQUDZBVlNHajdjaEd2?=
 =?utf-8?B?eFVGUkpaRlpqdHk1YmFBeHRNTGZlVGF0YTU5dHlHeEQxbjhBZUR0U2xhczda?=
 =?utf-8?B?NkNRcjVGSWs2V2U3TVh2WUdIV3ZRdU91SmViUVdUYVRoYlpYK0RhU1RmU0xm?=
 =?utf-8?B?aG1UeS8zY3NPSHVLOFduRm9weFNIRTBadmJMZXl1b2tjWWZmYkg3RnB0MWti?=
 =?utf-8?B?UXdwUDNKcjNYeDdGYUl6d2VRL3B1MlIrSGZ2SkdxcTdzYmVWSlo3RTZ1Q3E2?=
 =?utf-8?B?Zm1pR21rK1dLSnZBNFA1MHJCNlY2VkcwQWRXRTMvR1p6MlFZSHgweXk4cEVo?=
 =?utf-8?B?ekdseS9VSlFDZlg5SkpBZHlubjNlZUsrNTI1QkdSRHRXOW1ySlhSb2ttQVg1?=
 =?utf-8?B?am1VY0k0M0NFeVNkRkVZZmR6eUp1VDV1UFFmQ2dnaU5VR1YzcFB0Nk9admFl?=
 =?utf-8?B?Y2dvTlhZdzRoRzdGN1BMS1c5bkw3ekhGVk92SEl2dlNUS1N6c1lSU1pQTlNi?=
 =?utf-8?B?L0hnR3NkVGhjK2kwaHJFT3JPelBYVTlqRlc0aVFWME4vK1pGNlRVejI5eWRK?=
 =?utf-8?B?T3BlcjN4Y3phenpsaEhvV0dHWFdPaEV2R05GSlc1WG9RLzFGU09NOXhEUjlT?=
 =?utf-8?B?YzE3eGxvOWdWUHpPSUIzMmw3dHpYVVFJdHpITHZucGQwVEZLY2RSYiszSGZj?=
 =?utf-8?B?ay9GZDVLMTh6cVlrWXkvMGkwRzc4bXRrZVhlMVRjMEd0b0RXbUZrK0ZhOVU5?=
 =?utf-8?B?N1NKSkV4d09vaDZuL1hQemxyeElqRjZoUWQraUJNalRYRXp0U1JGTFBmei9P?=
 =?utf-8?B?ckRPOVMxNzhxbml6emZ5ODV6Q0d2bWJ2dTBoSzV3SzE3MEVGUkIzQVd1YjBp?=
 =?utf-8?B?Ry8zWlo0Tzd6ZVRVcWVvZ2xDaURMQzhZSmlyWHd5Z3BTME1tRjQrL1MyTkZG?=
 =?utf-8?B?WE9SRWxzNGVnWllPNlFVeDNKQ0kwdE1UZDI5Z0VralFwdFM5dlMvd09WUzB0?=
 =?utf-8?B?d3FUK0RvdTd6YzNpTnVsSjc2UlpLMHNidEI0UytNdDZGRWN2Zmh3VU5FOHhy?=
 =?utf-8?B?eExtMGNGbml0aDhMUXIvS2Y4TFhoT0R2bDhhVklEaWR3NCtCT05nSmtTMU85?=
 =?utf-8?B?d25UbGx6R3lTd29hdE1rN3V2U1crcnlTWU13M0dna1d6WW9MQWpjZGJ6YzM1?=
 =?utf-8?B?ZzRmUlE1RzJTR3R6YVh6VzZHWTZRbUNBdDk5V2VvY1o5RlNUWDExZzJXdnAx?=
 =?utf-8?B?L21PRTdFMXNxVXRwN3QxdEJ6M1NhdStBbUNFTnMzZEZYMmZpZ0x4eWNvTkpX?=
 =?utf-8?B?Z1Mvd3BaMG5YcEZIOC9ET05KUzh3eTlJN29BSVRRbE02Q3hQR29KdXpzN3pJ?=
 =?utf-8?B?dzdFVzZIdW85aCtGSGZqaDZoUU10bTBTVm5vVnU4MnpUSmFqaEVSbXJyK0h5?=
 =?utf-8?B?RnBjTjFrb0hRVkp2UzBQZU96eTBzak9ZblJQRUhrdFc1SHJTQkttVUJtL3hL?=
 =?utf-8?B?R0JCOTU4Q1NJMW5wNzBJbXNrNkJheVpTRWxMMGFaUWRTQ1VNQzRNNzFndTFP?=
 =?utf-8?B?QU92VjFVaEN2clF2TE5QREF4RXpvMS9RaS8xM3dsQWl5UUlNbWRwVGF4c2pt?=
 =?utf-8?B?eFdQdVQ0eGx2eGtEdWRMaEtBMExlQlcwYkxkYzFSTDB5WFBvc1pzZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aeb359e-e7f7-4f6a-bfb4-08df09be130c
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 13:20:07.8787 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pc2AuZmZ2vmVrDRIBvfHKGylWgyDFP/98v992ZsUtFoGydYhRDK23IKjfGxVBK8X8w77unGVylyno7bmHZKznA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7925
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

On Sun Aug 30, 2026 at 8:37 PM BST, Danilo Krummrich wrote:
> Add a lifetime parameter to Coherent and CoherentBox that ties the DMA
> allocation to the device's bound scope, ensuring it is freed before the
> device is unbound.
>=20
> DMA allocations carry device resources (e.g. IOMMU mappings) that must
> not outlive the device's bound lifetime. Without a lifetime parameter,
> there was no compile-time enforcement that a Coherent or CoherentBox is
> dropped before the device is unbound.
>=20
> Propagate the new lifetime parameter through all users.
>=20
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

The rust/kernel code looks good to me. Haven't checked nova part in detail,=
 but
it looks like a mechanical conversion, so would be fine if it builds.

Reviewed-by: Gary Guo <gary@garyguo.net>

Sashiko points out that the `Coherent` could be leaked -- what's the implic=
ation
when that happens? I think it's not going to be as problematic like
registrations because coherent allocation carries no callbacks, so we proba=
bly
don't need this to be unsafe, but I do wonder how'd DMA subsystem handle th=
is.

Best,
Gary

> ---
>  drivers/gpu/nova-core/falcon.rs               |   2 +-
>  drivers/gpu/nova-core/fb.rs                   |   2 +-
>  drivers/gpu/nova-core/firmware/booter.rs      |   2 +-
>  drivers/gpu/nova-core/firmware/fsp.rs         |   8 +-
>  .../nova-core/firmware/fwsec/bootloader.rs    |  12 +-
>  drivers/gpu/nova-core/firmware/gsp.rs         |  14 +-
>  drivers/gpu/nova-core/firmware/riscv.rs       |   8 +-
>  drivers/gpu/nova-core/fsp.rs                  |  20 +--
>  drivers/gpu/nova-core/gpu.rs                  |   4 +-
>  drivers/gpu/nova-core/gsp.rs                  |  30 ++---
>  drivers/gpu/nova-core/gsp/boot.rs             |  10 +-
>  drivers/gpu/nova-core/gsp/cmdq.rs             |  35 +++--
>  drivers/gpu/nova-core/gsp/commands.rs         |   2 +-
>  drivers/gpu/nova-core/gsp/fw.rs               |  12 +-
>  drivers/gpu/nova-core/gsp/hal.rs              |  14 +-
>  drivers/gpu/nova-core/gsp/hal/gh100.rs        |  16 +--
>  drivers/gpu/nova-core/gsp/hal/tu102.rs        |  34 ++---
>  drivers/gpu/nova-core/gsp/sequencer.rs        |   6 +-
>  rust/kernel/dma.rs                            | 121 +++++++++---------
>  rust/kernel/uaccess.rs                        |   4 +-
>  samples/rust/rust_dma.rs                      |   4 +-
>  21 files changed, 176 insertions(+), 184 deletions(-)

