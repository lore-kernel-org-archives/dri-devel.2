Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C28CA5FF1
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 10:53:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8039810E553;
	Wed,  7 Oct 2026 10:53:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="pvkd/8zq";
	dkim-atps=neutral
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012024.outbound.protection.outlook.com [52.101.43.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D022B10E1A0
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 10:53:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QVO8fr5qqDF0sGN4fp8WGuBMh30ytBKEDgAKsxiA8jspiefX+eBKqMMkfNuJPdl3NOQeu6iBsUL5w0jfRXFPB6c34tSHOq8e9F8oMcRMi2RRK7D+qMrIcXtaS/uGC9wt6C65GH7J9+RbUEzlesQatS8+Nz5+XehZdy9n9mlA74hhV6Hofs/jQD4KM3n1F00o919KMymtusf5MmFkGUy5JXBZQC2r1d4Fj7RbKAVKTQhYdzaYbHaxHU2sRZ32HlBiMz3nTDUxr7xlrUPDR6SBZH7ZNdzfkICVvDJvm9cUpVYUzOq3wShBrqKWPwhl9BxsoKhx3DnaALvYeISWKlYv3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZcT2XfApKGeLvQtJP5AKPLt/DnmFNFIHa+rUJ9hvYXQ=;
 b=hkFncSH+pyyVIH5/55act1mkKbqgZcTXZYC5fA5b9sk2MZ24rGHbk1+3bRdb7rEinhjw3FcU3Ei1pe/x6+pJyqv9jqOPbS078nFew58iSPGc4BoQB2+porB6dOTSayJ2AADP1TykjwXx25KZCsPSkfD6iUv++HR1ejLOjR9wH9iHPljpJ1kdXPv9w3mJHm4aEAQFc1dkiiPkTrNKetSJLQhThYW4j+2pVDyFFtO23JqG2xNZm39ZEzqxU8n1gYVC9GZUtXr6R8DPkyOaPNJ815/lrccscuLWw0NRMKjuokSdDarIuFyPeniHCPs5abCRKw0woM9lM4Ud5912GfBY9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZcT2XfApKGeLvQtJP5AKPLt/DnmFNFIHa+rUJ9hvYXQ=;
 b=pvkd/8zqvQjkA9V2L9M73Axs7MeiFP3f1KHlRHGVXOEe4mkvvxu3w+H+5pjU4h8TOGm8w6ruOnwXPqjudSkHWtEHuEkek9uJFf2A3ylnH2cV9W4OwMEEKzV4qWZFRHW8u+3887oKmmOD035yNw0pOv5MbyJsW+J3W2FVrW3FEdeclQYrTBk0HqiP483yXt8IBl+RQX3rpAIx4BnNmEnv+eEuyaeTwktYIC6K2E9JaG7i47a2gHvC12r+iluQePsZ7jFsSwb0IGAQyuCPY6M4eDbbL+S0NlYn1mYsdeA27crOznhrhfa+2X49GLBIPvcqgKGTv152m4tb3CKaF7aVvg==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MW4PR12MB6873.namprd12.prod.outlook.com (2603:10b6:303:20c::17)
 by CH0PR12MB8580.namprd12.prod.outlook.com (2603:10b6:610:192::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Wed, 7 Oct
 2026 10:53:48 +0000
Received: from MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1]) by MW4PR12MB6873.namprd12.prod.outlook.com
 ([fe80::a338:bd2c:3a38:ece1%5]) with mapi id 15.21.0472.016; Wed, 7 Oct 2026
 10:53:47 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 07 Oct 2026 19:53:44 +0900
Message-Id: <DLYJTG5QTTLF.1LPXNI4K9UU87@nvidia.com>
To: "Eliot Courtney" <ecourtney@nvidia.com>
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
Subject: Re: [PATCH v3 8/8] gpu: nova-core: add NVKV GSP_INIT schemas
From: "Alexandre Courbot" <acourbot@nvidia.com>
References: <20260928-b4-nvkv-v3-0-f04504c262c2@nvidia.com>
 <20260928-b4-nvkv-v3-8-f04504c262c2@nvidia.com>
In-Reply-To: <20260928-b4-nvkv-v3-8-f04504c262c2@nvidia.com>
X-ClientProxiedBy: TY4P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:26f::11) To MW4PR12MB6873.namprd12.prod.outlook.com
 (2603:10b6:303:20c::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR12MB6873:EE_|CH0PR12MB8580:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e339849-9401-4acb-1b50-08df24614394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|10070799003|3023799007|13003099007|4143699003|56012099006|6133799003|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: FbQS2IH0WcLrqGPYk84JgvONccOsJP50AU3rrJ/NMKJ34OnzJacCQVsM8DFOK9EiA+yUdbgyp53cqikByQtVk+4/i02D6LCAlN16J9Z3w3Mmtl0VwyMgbW0jrxhJRfZNVsxhXdFtUNfkg9gvJjLhVjT7Wno4JAGyWZ6HiFcX/+0024C1537D1uQ+90nGTtEz2KtPZYkeBtSdtfPgESxE+pQr/xCbxkVEhHfwqavaLwyRsk02KnnEJgr4rmKxCNShzNKPZf7iXTEjVzzTXpvwjpaEggtzH/egAK/My4DkD9nIEZVuQ2BFL69smRcc4KiF47uiMXjubSXtOzOHECQEO23Vo+GNY8IUTRezsqU22kkeLjPdR7HUCw4d248YwQOtTkV7UNWoAg3tyjTWNQkUVV4iTR0cETH1ChSQr8KvtjUApLgGFZJYJfMYe7BT6zQNdl8Yliyv3XxWC6rVXEm0W9DS6hmEuDacgG+useTlgAJQHuam8YaEXwmTv0erGfEesfRnrhT5OkUtTsTjRT3KYj/76QX7JkNc7gbABSb1GB7M+XayQgRmN9m1YVcGw8DPCwL24m63Pr5x6XV72olYsfXI7dW5Sb3iadXAhW1mdkMdTDZRuLIPbz1E/tBkXJ2A98y9LqN6vGV+Uqxq4vlyt1e4lB8WAJU3ARLIWzrF1yg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW4PR12MB6873.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(10070799003)(3023799007)(13003099007)(4143699003)(56012099006)(6133799003)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RFd5NkE0dUdhcTBNaEhvdGZFbzh4SUkrUU5GOFhyZDdOOGNEUXM4YkdLZTIv?=
 =?utf-8?B?cGNLNG15dXhqSG5LN1VQSU5XUm5NMVh3WGpZWnNDV1hhVFFPTmdPYUNvMjVV?=
 =?utf-8?B?KzRodCtKS1Nla3FCeGxLTE1lOHh2M1o3MUpBQklhcDBNL1pDMzVtcTIyMndV?=
 =?utf-8?B?aUdRd2RYb0ZWZ2Q4UUdGUlNjbGQxRHJXMDhHV0VYWWt6V05JRjk4WXNWS3dT?=
 =?utf-8?B?SGhTM1pFdTZocUNOQTNlaksrSlJ0bWI5V0lLUmlzZUk2S2psUTJMY29EUTBE?=
 =?utf-8?B?SDZkUk9Ob2VHeUJ1QjNjT3B6SXlBMmhib1ViR0RubGhiS2FPUFVwZ01Ka2R6?=
 =?utf-8?B?VERHRVlIVE14OEk2K2sxWjNjMW94eUFSOEZvOWtxMGRtd05uTFQwV1FkTkpJ?=
 =?utf-8?B?ZUN5RTZMTm5yb3ozOHdvZU5lYU9GaUhLNEJzREVYMFhqVHBhSlBJdVRpVUZj?=
 =?utf-8?B?dEl0WWZUNXg4OTlvMGQ2S3dlaHV6eWpUUHNtcG4zRzY3b2tFRWJ2MmxaWVZL?=
 =?utf-8?B?NkYva25UcHBvemFaRzlMWTZDWWhjaE9Id21zVnNIeE80WGN5K0xCSWxXNXd5?=
 =?utf-8?B?QS8yUm5iWnZGZ0lxdE1laWp1enB2QkxucEduZ0RwRUtOUmUyVjZuUmZwbXVp?=
 =?utf-8?B?dkpSakZ3cDZyRFlvQm5yZnhXcHFxdFVkTzYxbFlNdzAweHRwZFFISC9jU2kw?=
 =?utf-8?B?V0FRcjNXdVA5NEhhL0Q5eHRYMHh2T2FHUGlab3MwTDVnSmt2RkY0eUQ5cks3?=
 =?utf-8?B?RmpWWDR2U01ISkFZbTc0aUhReHM1d0xFQ05oaGNlamdZdmtWTDA0NlpCSnpR?=
 =?utf-8?B?Um9WbUQ0b3U4Vngyc3o2WklLbVcydWJzR2lsWjRJRFRYT0pYRmNjY0JodGNU?=
 =?utf-8?B?TmNlV2h0VGFXekEvMktRaDFrL3FNSWRpYjg0cFBPRW55Y3M3dEdLSkxiTWgw?=
 =?utf-8?B?NkJNWURuRlE0R0ZEbzBMS2F0T29BWTNTUi8yQkNIUjU1S2JHVzRaWkV0RVp5?=
 =?utf-8?B?WU55KzlnaHhqNDRWOHlVUFdTRGIxdkszU2lKbWszUjF5djZDdmtHZkR6SUxi?=
 =?utf-8?B?WWRoMnN2ZjUyb0NVQzd2N010N1hzS1lLd1hQY2RnOW9lOUFtMFpSRnJDZ3N5?=
 =?utf-8?B?bWlhR0dCUWlkOWVmYURjWHhmTnBqb1pWbVY1U3RQOGxhTWduaG0zWTM0VGdR?=
 =?utf-8?B?WVRycmJueUh6My9QVldrNEFGUmhIY1RldDkvKytFV0Vwd25DNVdzMEx0U1N0?=
 =?utf-8?B?VXhtN2IvY3hDWlZKQmFGc200WnlSek8xUmY1WlFnWGZwVnhuU3pwTlg1dyt2?=
 =?utf-8?B?MDJVcjNqN2JlVmM1eDYvd0dnd3ppZ2JpZXV4ZVlnck9vY210M1dNM2kxODZS?=
 =?utf-8?B?VHdYVHE1Q2JkTkdOWFVWcGJBNXN5cHJmblc3dWVaVStQTTY0NzVWVU1TeTlq?=
 =?utf-8?B?VVVtWFpOOW9MSUNDUnNvVHlwNTg1RFNac05MbUNsZkZUU1dCajEwZkY2VDVx?=
 =?utf-8?B?RmxlV1Q4QnJsM1lKU1Zzb29uOWRTQVM2cDhpM2tuMXlUemFoY0hWYXcxaDJT?=
 =?utf-8?B?MjF6Z1ordGRCMDl4dmVFb1h6YkF0dmVxcW0vK0hGL0lnN0JLUzZpNEUwdmpO?=
 =?utf-8?B?RzFBUmFZaVhqRTdMYXhKZDlxdmJiRjIzTnQrZzJSd1pBSmRBM1k4TTVNZVpm?=
 =?utf-8?B?RlJPMzlaQmw0eUdkUXkyL293VlpPaExXYUZTN1lEMmc4aWQ3enZEM1BWcXJU?=
 =?utf-8?B?ZGMraHlJSWRLTDh2dDdzSi82cHNCQjYwcVEza1pyR1ZtZU1ZaGxNQnBxdVQw?=
 =?utf-8?B?Qi9NYmxvUFpoL0N5NzdGZXRSMFZGMEZsMEhDNjZPR2JOb3NmWUFhLzR6aU9m?=
 =?utf-8?B?VFlZSEhWeWIrb3VnNEx5K0NpbUJTUC9FNS91RWNTbkZJY2NTWVo0TlM3cE5y?=
 =?utf-8?B?MHJyeTFzNnNZaVRXazQ4ZVJGcTBLaTlqOXhqU3k1RTRYV01sSmZvVlR2U05X?=
 =?utf-8?B?RUswT3NXYXJFdmpZVkdzSitCZy9DRWYzTWZlUDlNNzJGVHVKOVhwZDhzajU0?=
 =?utf-8?B?Q3BiblpVL2ZaRkFHZm11QStBY3h3aGl3dnRkZExMaWwwY0xCV0c2N0xKNEpF?=
 =?utf-8?B?aytXL2VabE1jckZUN25rV29lN1dZcWZ0WnlOU3UwQlBsVDhNR2gyUU9TWlRq?=
 =?utf-8?B?aVBrTE9jTVZTYXp1b05yOGJJRWNXMmRWV24xTnBGaWZ6MTRhVjRuNDc2a1pD?=
 =?utf-8?B?ZTJNUG9qNUNmNWpZeFBUc3IycnJkcjI0amVxWTFTZ3k3Ukw3UURXYTJ3cEta?=
 =?utf-8?B?eURtQmdGZSs2SWZNeEdwZWpkOE5MWnpIVWRuK1BWV05NdUpNdUNvNExWcVJW?=
 =?utf-8?Q?WdnpVfo9a5i5vOt9S5SVcD9ZAGy7HuPHyF157x4y/jt1u?=
X-MS-Exchange-AntiSpam-MessageData-1: pAuPISGDJMOsRA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e339849-9401-4acb-1b50-08df24614394
X-MS-Exchange-CrossTenant-AuthSource: MW4PR12MB6873.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 10:53:47.6409 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nQaS892UOZY3DEXPBlLFOYyqFLp+ftJdycqa4wPP/Qi23k3D/MKDHDk4GlRfhb1xDliQa2IOaFhFP5tlxAF5Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8580
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
> Add the first user of NVKV encode/decode which is the request and
> response for GSP init. For now this is exercised via unit tests. Later
> patches will support GMCAPI in `Cmdq` and use these messages.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/fw/commands.rs | 447 +++++++++++++++++++++++++=
+++++-
>  drivers/gpu/nova-core/gsp/nvkv.rs        |   3 -
>  drivers/gpu/nova-core/gsp/nvkv/decode.rs |   1 +
>  drivers/gpu/nova-core/gsp/nvkv/encode.rs |   1 +
>  4 files changed, 448 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/fw/commands.rs b/drivers/gpu/nova-=
core/gsp/fw/commands.rs
> index 32856ff74183..02de225af917 100644
> --- a/drivers/gpu/nova-core/gsp/fw/commands.rs
> +++ b/drivers/gpu/nova-core/gsp/fw/commands.rs
> @@ -4,6 +4,8 @@
>  use core::ops::Range;
> =20
>  use kernel::{
> +    alloc::ArrayVec,
> +    bitfield,
>      device,
>      pci,
>      prelude::*,
> @@ -15,7 +17,21 @@
> =20
>  use crate::{
>      gpu::Chipset,
> -    gsp::GSP_PAGE_SIZE,
> +    gsp::{
> +        nvkv::{
> +            nvkv_decode,
> +            nvkv_encode,
> +            Accumulated,
> +            Array,
> +            DecoderValue,
> +            Encodable,
> +            Encoder,
> +            Key,
> +            KeyId,
> +            Required, //
> +        },
> +        GSP_PAGE_SIZE, //
> +    },
>      num::IntoSafeCast, //
>  };
> =20
> @@ -230,3 +246,432 @@ unsafe impl AsBytes for UnloadingGuestDriver {}
>  // SAFETY: This struct only contains integer types for which all bit pat=
terns
>  // are valid.
>  unsafe impl FromBytes for UnloadingGuestDriver {}
> +
> +/// The host CPU architecture.
> +#[derive(Clone, Copy)]
> +pub(crate) enum HostArch {
> +    None =3D 0,
> +    X86_64 =3D 1,
> +    Ppc64le =3D 2,
> +    Arm =3D 3,
> +    Aarch64 =3D 4,
> +    Riscv64 =3D 5,
> +}
> +
> +// TODO[FPRI]: This is a temporary solution to be replaced with the corr=
esponding derive macros once
> +// they land.
> +impl TryFrom<u32> for HostArch {
> +    type Error =3D Error;
> +
> +    fn try_from(value: u32) -> Result<Self> {
> +        match value {
> +            0 =3D> Ok(Self::None),
> +            1 =3D> Ok(Self::X86_64),
> +            2 =3D> Ok(Self::Ppc64le),
> +            3 =3D> Ok(Self::Arm),
> +            4 =3D> Ok(Self::Aarch64),
> +            5 =3D> Ok(Self::Riscv64),
> +            _ =3D> Err(EINVAL),
> +        }
> +    }
> +}
> +
> +impl From<HostArch> for u32 {
> +    fn from(value: HostArch) -> Self {
> +        value as u32
> +    }
> +}
> +
> +nvkv_encode! {
> +    /// A GSP registry entry.
> +    struct RegKey {
> +        key_name: Key<&'static [u8], { Self::REGKEY_NAME_KEY }>,
> +        key_value: Key<u32, { Self::REGKEY_VALUE_U32_KEY }>,
> +    }
> +}
> +
> +impl RegKey {
> +    // Define the Key IDs read/written by GSP.
> +    const REGKEY_NAME_KEY: KeyId =3D 0x3070;
> +    const REGKEY_VALUE_U32_KEY: KeyId =3D 0x3071;

I guess the `REGKEY` prefix is unneeded here since it's the name of the
wrapping type. If we want a common prefix, let's use `KEY`, e.g.
`KEY_NAME`? Although we might not even need these at all - please see my
last comment on this patch.

> +}
> +
> +impl Encodable for KVVec<RegKey> {
> +    fn encode(&self, encoder: &mut Encoder) -> Result {
> +        for regkey in self {
> +            regkey.encode(encoder)?;
> +        }
> +        Ok(())
> +    }
> +}
> +
> +nvkv_encode! {
> +    /// SR-IOV virtual function information.
> +    struct VfInfo {
> +        total_vfs: Key<u32, { Self::VF_TOTAL_VFS_KEY }>,
> +        first_vf_offset: Key<u32, { Self::VF_FIRST_VF_OFFSET_KEY }>,
> +        flags: Key<u64, { Self::VF_FLAGS_KEY }>,
> +        first_bar0_address: Key<u64, { Self::VF_FIRST_BAR0_ADDRESS_KEY }=
>,
> +        first_bar1_address: Key<u64, { Self::VF_FIRST_BAR1_ADDRESS_KEY }=
>,
> +        first_bar2_address: Key<u64, { Self::VF_FIRST_BAR2_ADDRESS_KEY }=
>,
> +    }
> +}
> +
> +impl VfInfo {
> +    // Define the Key IDs read/written by GSP.
> +    const VF_TOTAL_VFS_KEY: KeyId =3D 0x0080;
> +    const VF_FIRST_VF_OFFSET_KEY: KeyId =3D 0x0081;
> +    const VF_FLAGS_KEY: KeyId =3D 0x1003;
> +    const VF_FIRST_BAR0_ADDRESS_KEY: KeyId =3D 0x1050;
> +    const VF_FIRST_BAR1_ADDRESS_KEY: KeyId =3D 0x1051;
> +    const VF_FIRST_BAR2_ADDRESS_KEY: KeyId =3D 0x1052;
> +}

That's a bit of boilerplate. Ideally we would have this `#[nvkv(key =3D
value)]` notation (without the bidirectional feature) you mentioned in
[1] that takes the literal value and defines a constant to access it,
but I guess that's more rework than we want for now.

[1] https://lore.kernel.org/DLIHSKKUVP7V.153Z4TTEYFL3Y@nvidia.com

> +
> +nvkv_encode! {
> +    /// Payload of the `GSP_INIT` command.
> +    // TODO: expect() doesn't work here due to Self:: reference, fixed i=
n 1.97.0
> +    // https://github.com/rust-lang/rust/pull/154377
> +    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
> +    struct GspInitRequest {
> +        pci_device_id: Key<u32, { Self::PCI_DEVICE_ID_KEY }>,
> +        pci_sub_device_id: Key<u32, { Self::PCI_SUBDEVICE_ID_KEY }>,
> +        pci_revision_id: Key<u32, { Self::PCI_REVISION_ID_KEY }>,
> +        pci_config_mirror_base: Key<u32, { Self::PCI_CONFIG_MIRROR_BASE_=
KEY }>,
> +        pci_config_mirror_size: Key<u32, { Self::PCI_CONFIG_MIRROR_SIZE_=
KEY }>,
> +        host_arch: Key<HostArch, { Self::HOST_ARCH_KEY }, u32>,
> +        bus_device_func: Key<u64, { Self::NV_DOMAIN_BUS_DEVICE_FUNC_KEY =
}>,
> +        regkeys: KVVec<RegKey>,
> +        vf_info: Option<VfInfo>,
> +    }
> +}
> +
> +impl GspInitRequest {
> +    // Define the Key IDs read/written by GSP.
> +    const PCI_DEVICE_ID_KEY: KeyId =3D 0x0001;
> +    const PCI_SUBDEVICE_ID_KEY: KeyId =3D 0x0002;
> +    const PCI_REVISION_ID_KEY: KeyId =3D 0x0003;
> +    const PCI_CONFIG_MIRROR_BASE_KEY: KeyId =3D 0x0010;
> +    const PCI_CONFIG_MIRROR_SIZE_KEY: KeyId =3D 0x0011;
> +    const HOST_ARCH_KEY: KeyId =3D 0x0070;
> +    const NV_DOMAIN_BUS_DEVICE_FUNC_KEY: KeyId =3D 0x1020;
> +}
> +
> +// Decode:
> +
> +// Should decode with UnknownKeyPolicy::Ignore.
> +nvkv_decode! {
> +    /// Schema for the `GSP_INIT` response.
> +    // TODO: expect() doesn't work here due to Self:: reference, fixed i=
n 1.97.0
> +    // https://github.com/rust-lang/rust/pull/154377
> +    #[cfg_attr(not(CONFIG_KUNIT), allow(dead_code))]
> +    struct GspInitResponseSchema =3D> GspInitResponse {
> +        gpu_name:
> +            Array<u8, { GspInitResponse::MAX_GPU_NAME_LEN }, { Self::GPU=
_NAME_STRING_KEY }>,
> +        fb_regions: Accumulated<FbRegionSchema>,
> +        bar1_pde_base: Required<u64, { Self::BAR1_PDE_BASE_KEY }>,
> +        vmmu_segment_size: Key<u64, { Self::VMMU_SEGMENT_SIZE_KEY }>,

Is this ok to have `vmmu_segment_size` not `Required`?

> +    }
> +}
> +
> +impl GspInitResponseSchema {
> +    // Define the Key IDs read/written by GSP.
> +    const GPU_NAME_STRING_KEY: KeyId =3D 0x2000;
> +    const BAR1_PDE_BASE_KEY: KeyId =3D 0x1020;
> +    const VMMU_SEGMENT_SIZE_KEY: KeyId =3D 0x1050;
> +}
> +
> +/// Payload of the `GSP_INIT` response.
> +struct GspInitResponse {
> +    gpu_name: ArrayVec<u8, { Self::MAX_GPU_NAME_LEN }>,
> +    fb_regions: KVVec<FbRegion>,
> +    bar1_pde_base: u64,
> +    vmmu_segment_size: u64,
> +}
> +
> +impl GspInitResponse {
> +    const MAX_GPU_NAME_LEN: usize =3D 64;
> +}
> +
> +nvkv_decode! {
> +    /// Schema for one FB region of the `GSP_INIT` response.
> +    struct FbRegionSchema =3D> FbRegion {
> +        base: Required<u64, { Self::BASE_KEY }>,
> +        limit: Required<u64, { Self::LIMIT_KEY }>,
> +        flags: Required<FbRegionFlags, { Self::FLAGS_KEY }>,
> +        tag: Required<u32, { Self::TAG_KEY }>,
> +    }
> +}
> +
> +impl FbRegionSchema {
> +    // Define the Key IDs read/written by GSP.
> +    const BASE_KEY: KeyId =3D 0x1011;
> +    const LIMIT_KEY: KeyId =3D 0x1012;
> +    const FLAGS_KEY: KeyId =3D 0x0012;
> +    const TAG_KEY: KeyId =3D 0x0013;
> +}
> +
> +bitfield! {
> +    /// FB region attribute flags.
> +    struct FbRegionFlags(u32) {
> +        0:0 support_compressed =3D> bool;
> +        1:1 support_iso =3D> bool;
> +        2:2 protected =3D> bool;
> +    }
> +}
> +
> +impl TryFrom<DecoderValue<'_>> for FbRegionFlags {
> +    type Error =3D Error;
> +
> +    fn try_from(value: DecoderValue<'_>) -> Result<Self> {
> +        if let DecoderValue::Scalar32(v) =3D value {
> +            Ok(v.into())
> +        } else {
> +            Err(EINVAL)
> +        }
> +    }
> +}
> +
> +/// One FB memory region.
> +struct FbRegion {
> +    base: u64,
> +    limit: u64,
> +    flags: FbRegionFlags,
> +    tag: u32,
> +}
> +
> +#[kunit_tests(nova_core_fw_commands)]
> +mod tests {

These tests below mostly re-check the same things as the previous
patches, only with different data. I am not sure they bring much new
coverage, except maybe nested structs (which we could/should also cover
in the previous patches anyway). I think we would have more value (and
less code) if we covered the things newly tested to the tests of patches
4-7, and dropped the test module here altogether. Because if we follow
the pattern, then we will repeat these tests again and again for every
command we support, which is going to result in tons of redundant tests
at the end of the day.

Another incentive for not having more tests here: they are the only
other user of the key constants, outside of the `nvkv_decode` and
`nvkv_encode` macros themselves. If we can get rid of them then the
macros become the only users of these consts, and in that case why not
replace

    pci_device_id: Key<u32, { Self::PCI_DEVICE_ID_KEY }>,
    ...
    const PCI_DEVICE_ID_KEY: KeyId =3D 0x0001;

with just

    pci_device_id: Key<u32, 0x0001>,

as it is clear from that line alone that `0x0001` is the key for
`pci_device_id`. Bonus, the unsightly brackets required because we
reference `Self` can also go away.
