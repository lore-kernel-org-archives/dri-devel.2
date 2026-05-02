Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FA5DCD13DA
	for <dri-devel@archiver.kernel.org>; Sat,  2 May 2026 15:41:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5567E10E0B7;
	Sat,  2 May 2026 15:41:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="exwKbhGT";
	dkim-atps=neutral
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010036.outbound.protection.outlook.com [52.101.85.36])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BC3710E0B7
 for <dri-devel@lists.freedesktop.org>; Sat,  2 May 2026 15:41:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bDU9wSH4y8F87wFIw3IhU9YguGIZFCCXB9gr1Nxp0x8U8XP1mCKBND+m4SFhogzdUc+JaBMSqLivmFjzIHWW9+uzPPxALJR1T89TkAyczv/DcmaPnIl0hcQBoNRuEmXTBTK263NSeApYJxz7bvqmGVuh5o8DgBLew1jmcoww0jMdOq2XA9WHBc5UJA9vriu3qnSZo9qSxXXMMl03NyLBpPx7g38z/Ft34/xQ99Qsoz6I2xNfLzj9jl3U2GpfxH4Uk7MPnP0Y0b4cFeMqaiQTkWnaVnjRAmiytfEACiydASBm3dAaC8lG+/iDsnHaa8y7yEVy8hi5zWrMiQMLbwu2Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dw4UC/cfNyGNlsoT2lHqwhogMOrmOzlCwYyQ6coYgX4=;
 b=Of52JAMw4L/0Awu3Frz+LBA3+gKOAgTuuPbnwzp6DYEHCYcbwgct64zkGYJvrQrFMx/Gg4lkmkU5pOntKjOccZwQUZe0G0aSEVygMHPOSjwUHsEghlRcwCbUtF0cMnqm1+TsIx+DSbiXp1l1bbS2QgjSI5asR3A2Je5O0Ui7qVqaGUwOHslhNuPn1tyblTeeNk8J6HFlVQmiyxkUH6XzTbVQQDHXahvprDrf2wzqLYB8vCi/Hk7O+00aWYsyRBJX2nlpCzM//M7km/tkI18bgubDUSCGijS+/Cl8iPxYDFeas8HjTpUlFFzGui8FVWwUu62ORCI5xJs9mQJrE38kJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dw4UC/cfNyGNlsoT2lHqwhogMOrmOzlCwYyQ6coYgX4=;
 b=exwKbhGT1ezlvbjUGeMlaVAMAfxUxcWlzuSphBohxiGBFv7/hXv0lEc94qsOhpzrdaHJacg3SquChyuLSPDP80L19cVmM4KS4kb9jnMoaBMWOaJP02Z/oiTcWsvLCpNSGJvSD+o1rnfaR3YQl8tekZhGtGdm+t+ZdmLjDixh8kaiAIo2MfArktec3VFIk9i7/r52njLPOy4T/Y+nef+hE6VD/+VuQCeEo1SXumCMVMQAVwEFSnWzgtObr2WPs0evnRo/2vBkSnrtUIbYHaNxtoIR5FLHgNkz/DUk+h1pxTB6NHgtXaDKKQiyXhtyzdHqYuz0nKOLT9rMYVP+TdGm5g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by DS2PR12MB9591.namprd12.prod.outlook.com (2603:10b6:8:27c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.22; Sat, 2 May
 2026 15:41:26 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%4]) with mapi id 15.20.9870.022; Sat, 2 May 2026
 15:41:26 +0000
Content-Type: text/plain; charset=UTF-8
Date: Sun, 03 May 2026 00:41:21 +0900
Message-Id: <DI8AZLB2610U.10MNQ0IPV6NSL@nvidia.com>
Cc: <linux-kernel@vger.kernel.org>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Boqun Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>, "Bjorn Roy
 Baron" <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Alice Ryhl"
 <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Danilo
 Krummrich" <dakr@kernel.org>, "Dave Airlie" <airlied@redhat.com>, "Daniel
 Almeida" <daniel.almeida@collabora.com>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <nova-gpu@lists.linux.dev>, "Nikola
 Djukic" <ndjukic@nvidia.com>, "David Airlie" <airlied@gmail.com>, "Boqun
 Feng" <boqun.feng@gmail.com>, "John Hubbard" <jhubbard@nvidia.com>,
 "Alistair Popple" <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 "Edwin Peer" <epeer@nvidia.com>, "Andrea Righi" <arighi@nvidia.com>, "Andy
 Ritger" <aritger@nvidia.com>, "Zhi Wang" <zhiw@nvidia.com>, "Balbir Singh"
 <balbirs@nvidia.com>, "Philipp Stanner" <phasta@kernel.org>,
 <alexeyi@nvidia.com>, "Eliot Courtney" <ecourtney@nvidia.com>,
 <joel@joelfernandes.org>, <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v12 01/22] gpu: nova-core: gsp: Return GspStaticInfo
 from boot()
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Joel Fernandes" <joelagnelf@nvidia.com>
Content-Transfer-Encoding: quoted-printable
References: <20260425211454.174696-1-joelagnelf@nvidia.com>
 <20260425211454.174696-2-joelagnelf@nvidia.com>
In-Reply-To: <20260425211454.174696-2-joelagnelf@nvidia.com>
X-ClientProxiedBy: TYCP301CA0044.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:400:380::6) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|DS2PR12MB9591:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be84d9f-0b5c-44cb-fa6f-08dea86144f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|7416014|366016|1800799024|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: IVCO2A8+HFHtRny2Sy9ggXrAOFMqR3udpOVTM/Z1VcX2V2lSgM+xbgdnwF50tfVXchHX78Y7D15ZvZxTso7WG8V6LpmPLSSkIUO074CG211mvAtdkgVL5T0ODi3Hm4IpkhvAaEVcczl3gIeZCRJDUN5sC1dc+UIEm9UbpmsDqPg/7o4W+F7rvp37WegUT4ksC8AE8/kJW/xDMo19a6hxbaL1pbHMbSIjjIvqHB2TKYFCW6gF+/1AyIa1oTI15skqlGxthoHe8NVS3lYd+xzxmO4V3cyZUavdyUm6aDbAly+d3cdjJk3K864HjKWVtAwch/ovp1DL/VZW3XcYbNeAtFbeTHQbritaNQmN2XQDjJcLx+EhBYqaiRx2p0DRpNwb4FuLUKBaw2DoOoTe1kqDwTY/kmaTErhsIJwcBgySvKzWlP2qFQXdSeO8gfWmClxeJftEif/R/VClRtI/omEUYDlrbU/N7j07+9RXTUZ1NXEjeFLklLMQ9GBHbKfor/xyQGR8i70FAygRsa4zK6LOBary9vcb332UFk6MsA2PUv/4wR8wbAoyFDY5iZz2wQwlX1+xixNLoA838ddMDTt90e42IzELDjy01PjAOkCBVFvp5uxpdjOqXq7urM1ZtUqVWX4IyoavzM93BU0zwMAjb/arPKjq23P1kYpSnJHPgCbtTRziPyCB0BZ4Cajj6E6H
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(7416014)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aE1yS09uZ2grMy9kd2ppYWh4Yzl1eVFkbDJSaUdrOXVQVXEwOG4yZzR1ajRn?=
 =?utf-8?B?VThzb2ZXbHAyUjVLUzdmZGcwZVBUcXNQWWxDRVAzUUZEZUJTOWhRM3JxaUZR?=
 =?utf-8?B?ZjAweHVNWDdQV0xzeWN1TEhLUXVUektxNDVhem5MNVlnZHU4N0ZqVThyVXc2?=
 =?utf-8?B?Q2FpWkZKcHlWK1piMjl3TXN3T281TU5DelZsZlo2UFhJY0E0RmFCdkIxbFg1?=
 =?utf-8?B?VHA3OU1KbVkzWWNtNU1iMUh4Nmo1TVNucS9xQWNhZFJBV1FwdGtRem95U3Bh?=
 =?utf-8?B?SWRyeTkrN2FBeWpSM256NHpsU2h4anNxTllvOTJmb0Jpc0ZnVjhjRnh0RTRz?=
 =?utf-8?B?cnNCd2lFenBkSHVVWmhqVEZvR1FEcWRsWFFhMVY4eUZBQnlZbjlDZzdoVTZM?=
 =?utf-8?B?N1diajUrSHZacmJRZGl6MW5vcnVFMjNMcDlJQTBoQ2xRR3FxMUlmeXdBY3JU?=
 =?utf-8?B?N1JXL1hCdTlqM2NCR0p0S0dHUEpuWFg1anN1RUhIVHg2TGppb0JTSXp5UTRj?=
 =?utf-8?B?ZHVGQk1SamlGRWxoekFQenpVMUpWRDI5VDdUMllIekh4S0VtcXVwcTZDaHh1?=
 =?utf-8?B?S0ZJeklhQUNDcHFocCtjZnZ1RkpSTG1EZldRWU9qNDg0YXZDRExRRGtPd1Jk?=
 =?utf-8?B?bHN2ZHMvdGI1bytPUkxQOC9RbDRZeVRjWGNHRWl2VnI3d1R5YjM1N2tlbkRS?=
 =?utf-8?B?aXNjcXphY2Q5RlhzNm1sTlZuaWpBUUo5ekV4elFNcTI2UTVudTZqTzhlTnA3?=
 =?utf-8?B?OHphdXdIRCt3NXd2d0ljTlpCZVZsK2pRQ01hZ2c1dEhZbGkxUVEveDZta2pL?=
 =?utf-8?B?OVBTTUFGaWQzd2xIbmZEd3JnVW16c1FDYVVHd2xXSDJwNklIZ1YvWTRVY3VY?=
 =?utf-8?B?dVJZZXhuRC83dzhodFFqeUk5RnlET3laQURWdGlBWlUzczdhZTFCTnFCWkE5?=
 =?utf-8?B?UWt3bmkwcjBYYy9DU0ZXYVd3dnhjbmpyN2w3TCt1Sk54UmNpbytPRUNpT29V?=
 =?utf-8?B?allhaHlYR3c0NDJnODc2Zzd0NllJZEhEdm12REhPVGVVUkVmaE1MQkoxbVE5?=
 =?utf-8?B?VWh4WGd1UkkraWRzcEJCdzlXaWlhQ1JQVlVMWkFVRnJCMVFjNGVIeUJoM1p5?=
 =?utf-8?B?dzBRRXZveGROd0pieTJ4Y2gxS05pT0Q1VmUrQ2dOT0dQOW94NFRKajd2K001?=
 =?utf-8?B?UjJ5alZxU2NrbWs3bWhHN0xvek8wUEU5T2N1QTVUZWJkY0JBL0lNT3NubE1U?=
 =?utf-8?B?czgreXFHM0dsV1E4MThwMWlmdWx5NnB3RmszaTM2SlkwemlaMmJjNmloUGti?=
 =?utf-8?B?L3VkYkptRGgvblNzcEdSNnhDQndIcUlMQlpkSzROaldMazdsMHR2MkZJR2R3?=
 =?utf-8?B?dCtzMVJHUDlta2F5R2RvdXh6WWdFdnNPVGFtT0ROT3VUVW5oR2JoY2IzNE5D?=
 =?utf-8?B?R0lIUUwwMHFYMEZDY0pJdnU4SGhBV0l6MXp1TEpnM2NPWTZyTTlONE1aQWhN?=
 =?utf-8?B?Y1U3YUpCSFJaaFBERGpYY3AydVViSHVhL3pBUXhBNjVVTUQyM3Y5WDk0MUNq?=
 =?utf-8?B?b3l2TTRjSWlDOVl5dDVxUnljUEdvL1lSbXNSVEsrZlNvaDU5VkhqQTRONmV6?=
 =?utf-8?B?OXpsaUlsMEU5Q1J3OGVqd0JndDZoVldtd3VjbUthY0xTdzhEMVB2anhtcDNL?=
 =?utf-8?B?UEpBN2hHaGQ2ZjdNa0pBNzZlMGlBQ1I5UEVLbzUrcUNqcnJocWh6dHJ3dFNw?=
 =?utf-8?B?S256b0xmSnRNNkFwQmxHUWRHbDlLbStyZGE3aDU3bCt4eElRc0VDZERvOFlu?=
 =?utf-8?B?VXpGN0hrSXR2UFBXNFRWL1dTcE1FYVg2TDBRaFUwTWhjMlNPYjVvTW5EMVFu?=
 =?utf-8?B?eS9vNkMvYWlKYU4vUDBic3padUo3ZG1ENVhYU2NOZXZWckdUZzQyZUlKVzBz?=
 =?utf-8?B?b3ArT09xU0RyMFZtZXEvNnp2aTZQb3RJWENlZ1k1MnFESFpwUnEwajVPY0ls?=
 =?utf-8?B?d3VENUs0VE8rdHJVY3NsNnU0Mi9MMDFzNDV0QVBsc2ZMdUxDUmtrckJ1UzZW?=
 =?utf-8?B?bWVyd0dDZDFnYnVTeXVwWTdWSTBXM0ZtT1NJUzZnMnFXTUhselJBNFpaZ2dK?=
 =?utf-8?B?Z0h4eDExdjJuMlhkWWdkMnU3Sk02cXIra0l6NXJpUlIyNXVWNi9ZY3FjOHZY?=
 =?utf-8?B?NEVwZlorVXFZaCtLbC9Ha2FOZTl6NTRpREF5MGNUcWhwL1gwVC9PdmZTNk1P?=
 =?utf-8?B?cklKdzhkcGEwYmsyTXdkV2VUVlZDeFh1QzQ2UUlQV0NTN3JqYTNqU0xENjFC?=
 =?utf-8?B?clh2d1lzU0t1ZGc0aEFXVEk1bXd4T1E4YndIZGpRcjlQQU9vSFptcXYxclNJ?=
 =?utf-8?Q?DosLWmrEPtg+yrcw0jETHBCKJAU2TYE4aLsIbw4ZSkztS?=
X-MS-Exchange-AntiSpam-MessageData-1: BKcZeY7mJJNnrA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be84d9f-0b5c-44cb-fa6f-08dea86144f1
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 May 2026 15:41:26.0483 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MnSmSLhf+v1vduZ1wX08jefEvpbQ/8fmVV/5BC1xHiZAt21qyl62rQF/mg42qRv6o7NN54ud7aRrXiCabLeNg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9591
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

On Sun Apr 26, 2026 at 6:14 AM JST, Joel Fernandes wrote:
> Refactor the GSP boot function to return GetGspStaticInfoReply.
>
> This enables access required for memory management initialization to:
> - bar1_pde_base: BAR1 page directory base.
> - bar2_pde_base: BAR2 page directory base.
> - usable memory regions in video memory.
>
> Reviewed-by: Eliot Courtney <ecourtney@nvidia.com>
> Reviewed-by: John Hubbard <jhubbard@nvidia.com>
> Cc: Nikola Djukic <ndjukic@nvidia.com>
> Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs      |  8 ++++++--
>  drivers/gpu/nova-core/gsp/boot.rs | 12 ++++++++----
>  2 files changed, 14 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index 0f6fe9a1b955..f2a8915a1ff4 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -21,7 +21,10 @@
>      },
>      fb::SysmemFlush,
>      gfw,
> -    gsp::Gsp,
> +    gsp::{
> +        commands::GetGspStaticInfoReply,
> +        Gsp, //
> +    },
>      regs,
>  };
> =20
> @@ -238,6 +241,7 @@ pub(crate) struct Gpu {
>      /// GSP runtime data. Temporarily an empty placeholder.
>      #[pin]
>      gsp: Gsp,
> +    gsp_static_info: GetGspStaticInfoReply,

A short doccomment would be nice, but otherwise this looks good.
