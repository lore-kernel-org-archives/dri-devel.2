Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E466CCD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:14:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D84A710E898;
	Wed, 10 Jun 2026 10:14:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="tt6mIVXz";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022096.outbound.protection.outlook.com [52.101.101.96])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F35EB10E896
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 10:14:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q4VYLSaDU2fWdXELHKlgAY5HM+GhpMixPiPuDZrbqgINO6UFZNGDI4KG4Cdoff5fKMuS7uHxd8lVOykJ61aIEaRwuM7/7WUBPNigrWf3ZR3rhpYO6IwTcU+aWThpq8YuPTanqnje0eY9K+Jsa7PnztFaucZvQ8doFr6fJ+yIyTOYYoDI2/jJo66KdxWZjYWGgHVvNh6wFgyOxB1kwlhcnUq4aFRAiETfgRS8V0Fay5g4cqi1+2kjuzXLMgRulo9BODeBVvixVwOzwnZU192XXQskzH3dWEBDqQAxISWhPr4HOigzWy3EoW1J2y9lcFkRTP9XyCyD8JMY7npZUzxg8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0ix17F10bRJG4v9FVeSbRuZTMmtjt/MNYScE5U3WEEs=;
 b=zSKE06JfUrgGbOXOPh3CIPGp5I5kG3ZdxGwYqndZefKPVOJU5Ms8peqlEWGbkOqfzk6d67lPb+odVjtUCJKpwvMqEvhB+DiR4YGeN29OL3ngoU+QHud+8DZco/hO01eOD89HfWAYJc2YuITC3jI/QecyvsifKdzS7jLiKyBrQv8UUNPOypO1z3eGzn2WDfoghBW2iqNrfWNruxnuqs64tLHr3TBSrKcXs2/nyIjFWmtyxd8H+N893Ceyq0um1ZAaPfCRIgV6sIH51QIOkK6BeDz6JrAaBjdpd5gSAY/kp9AOBxivoZ2+6OaYV7yn068AR5GeMLW6UuC9GtXhI63N7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0ix17F10bRJG4v9FVeSbRuZTMmtjt/MNYScE5U3WEEs=;
 b=tt6mIVXzkNCa1bCfLEMvujGAnhQ5Pk3uyB44Pt+WLBgJxbQQUWD8aNjq8UJZ2x1bVNv5p+dkyIuAfXwPJfNpoMni3YI2pDt4qFvSV0F5z/tbquMNfk1skTHax5DINqHZn9c9sGeJxe51dWpxnPVPNYZYaqw/SwsSNWQ2kzWhu2Y=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:27c::13)
 by CWLP265MB2209.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:6d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.11; Wed, 10 Jun
 2026 10:14:04 +0000
Received: from CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995]) by CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 ([fe80::6c9e:93c8:10db:e995%6]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 10:14:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 11:14:03 +0100
Message-Id: <DJ5AG8OR68WR.3U4JD92SWJKPU@garyguo.net>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: move GSP unload state to a pinned
 Gpu subobject
From: "Gary Guo" <gary@garyguo.net>
X-Mailer: aerc 0.21.0
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
X-ClientProxiedBy: LO4P123CA0264.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::17) To CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:27c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CW1P265MB8877:EE_|CWLP265MB2209:EE_
X-MS-Office365-Filtering-Correlation-Id: ee01e68a-7705-4cf8-b57a-08dec6d90006
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|7416014|1800799024|10070799003|56012099006|4143699003|5023799004|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: f9ZqZViLjJkGf22XN4Hn1/dkys1elne3aWlXcYYuYxUkkxTgAYmxvMhIykqJefGuuOUZhH1ffEO3gOUF6BrbZjMoVcK0NSsR+DzBblSLOKsMIe4tw96VQzcCM6MiPtCquJMH5UosI97TvTGG8QQ6h3qaP6/I/NB4OkknTZ/ZgEFvveGl0UUYhtAXJukhcI7vAz74NsI7Q1moB7HxUCMCp9Gg/WkQ6WaqCMAdZOPnTiSVGp4DYGMtUdkVbaZWoO5eU7D8TsAgTGlJFD7+EO896yg41m3wnhSEhZwPysis+m22sRkC4K3wcC8ZUHmcvm87C9lOKxdYU7I7/RiGqp35ovilxSI1mjInMEq3jsnSJS5VdrOAt/pCBO/p7qGYyRONqHtYNvg7Q7+JOKHFePH3AIr6Jv7ZlMMnLKb3WVT2bnA1NDWumjQMif0fJaLlYACrG3oom6oyFeepwqQEnSHEf9Y4Tt8SNW2TmxKNLvjjpDbrYYWPma+akUclJanjLA+x+o8NtgLiqpG7D8C2q/uWGNrDErnpnY7v5/Rs8GD88a7M+n8E8bKEP4H5cam61Jyr0RW45AvVKz/ouqp621AoFKJKjfELaMFch40nQxU+bM1G+7qpNJoyZ5gqKM6xoleAd8+j5F0YZms9AzYezbiEAVRRGJfAdC8Cv/EK9I7kOVQvcYS/4x59XEIJEpHZQwqC
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(7416014)(1800799024)(10070799003)(56012099006)(4143699003)(5023799004)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWgzQWhUeHJ0czFoZkZRWE1pVERIbmU4aTI1cGlQOXBwKzVCdWFpYit6eWNX?=
 =?utf-8?B?S2R3SWlOQWxvcGUzMFN4NFlnY3BsbEEyOU50YTc4T3dxZ0IreTl6aG43bVd1?=
 =?utf-8?B?SmhtK1NaM1BZVTZrZUZLUFV3UE4wZWFpQ25yTHR0bjJrQklHdmg0UFA4bkla?=
 =?utf-8?B?WitENkRnN21lNE9vVUg5VkxwSmFoaHRBQkpncUNHVGhmT1FycHJrME9sOXRm?=
 =?utf-8?B?bFErTUg5VTJjbXBCc0ZjdzBnRjIrTWQ4VnRPMkhOY2RzTytmVUF3eE5MaEtV?=
 =?utf-8?B?UUNIUGN5RjM1ZXFoU0tOTjJvMjdQU24rRFo3NU9WTzZhZTQxeFFaMGczY2p4?=
 =?utf-8?B?bCsxak9jbENKeldlQVRtVk1wRDBZVThjcE5WZ2lpUnk3MXJSYkxGSDg0SjIw?=
 =?utf-8?B?a2VCL0hadmI2cDdZa1lYTzlHaFp6SG9yYTF5amNBZklQNU8wc3pSMG8wUXI3?=
 =?utf-8?B?cjkxcEVhUnFrTDBzTUIySFZpaS81TC9MdXFlWWFJZTRjNFVGdkRSMFMzRlZi?=
 =?utf-8?B?VlMxVzZ4MFJXM2tZQllmQVl1dmpUVUFVWkd0NFFreTRmOXQ3OW5MWEQzeVhJ?=
 =?utf-8?B?WTBRV3AxQ3VTMzgzQnpsY2I3bTdqZXhBUi9aNFdkNjJick9PSkpCSFdaZy82?=
 =?utf-8?B?QjdiZXViR1RjbjRaOHdkQkQyVlNuTWVsV0twM0phMXBCbkxwaEVaUk9sa0Rk?=
 =?utf-8?B?MC9FMmJiREx2cHM3bzlkdVJsZFJIRnB4K0pLc2llL3BEZDBoUW10N2R2ZlFo?=
 =?utf-8?B?S0lOTWtvTzNmS0ZWZ1JlSWZML21od0NaZTBlaDBkNi9GUkZmU2I2Z1NyT3o1?=
 =?utf-8?B?a1BkcEtaQ1ZMQklwUE9FZS9xUlJiUUdnVHVaK2J2UGtiY2xRMm5XMEw3MHdJ?=
 =?utf-8?B?RVhJWElYVEk0Q1FvZlBuQXYvM05wTUJHQ2xOWTNYdWE2SFc4TWppb1BMcDJr?=
 =?utf-8?B?WmJVcW1RNkY5VUFqNWtWWGRFSWNsalViWitDSDNHdkFBZWF3NjdsUzJXN1NV?=
 =?utf-8?B?bG9OaW5YVHYwS3Ruei90dndYb2UvaitNZFJtOTNsZzdXTDAzWmo0Sk03dzRn?=
 =?utf-8?B?OFdBbUE4Q3ZjZWsxQmRWZElYUnFQemtWdCt5bm5XSnpnejg5RXpuUzNqS3hU?=
 =?utf-8?B?MkdwVHpQK1RZbDZKL2FVK2h4anloZXFpRUlZeFZjQ29Bd0p0elJZYzdqMVg5?=
 =?utf-8?B?WEN6dXJtUFZ5ZDc2T3NOZXhNYW8yZW1tVTRsZEVCNVJhYXNBelcraU9NMHVU?=
 =?utf-8?B?RFArTk0xSjdSaCtvaWt2czFQZVJQUkFnby90akpCMGppYlVNT0NmYmdhRGhL?=
 =?utf-8?B?cjNBRWdMQXlvVFpUT2Mzalh6K0dPNVhDZ09CSy9aMFo3NnVFaVhmL1VualdL?=
 =?utf-8?B?ZWxCb2dpMTVidkNUTytJSFdTM280MHNaVmpnamVhd1BYd3F2WU05UXFtWjdZ?=
 =?utf-8?B?V0FUOHY5UUJrUDdZMy9PdWdOY0t5UUhDYW1IeVZXMHFnRTRNOE1VSGR0cG9P?=
 =?utf-8?B?ck9GanE4SjJMRGZZdWFTZmVDUUhXOUFYNS8rZUZiZUN1MGVDblZXUmtyNzdZ?=
 =?utf-8?B?U1BVYTFaemQ1Zkk2NDhYY3V3QXMzZjZwTHduYm9KejJGcEU4MEYySmdzTkNq?=
 =?utf-8?B?TjVjZVozRjY1a0RqbDd2Z3M3aWI4OVAwa2pFVDFhaDdNdGNhQzF1NEMzR015?=
 =?utf-8?B?TjBKakxXTitSZElrZC9QT0taVllVUXBTSkJTL0toVWxuZkgycEtMb1FyZTg5?=
 =?utf-8?B?WUlFUk0rQWQ3UWZkdDFmL0ZkMGNTNVNlNEpBNXNVQy95V3hlK1BKQ2t1UFBx?=
 =?utf-8?B?N1ZCU20vZlJmMFhVOFJFSml0UDZlU2IwSHdEd2JKVy9zdmpESjlsNi9xczUz?=
 =?utf-8?B?L0ppcENzdDQ1VFgyclVqT0ZmbkpZM1pIdUpKd3lEN3g2WU0zWFhXSTZIbk9J?=
 =?utf-8?B?TythNkhwRVJiMXVaOEFuZksvU2lEV3FqU0MwVDJQNkJmOXp0dTJPVnArRWh1?=
 =?utf-8?B?R1lkTkZlbElhRFp6UUoraWh6YW1QNXNtd2lVNXI2d1p1U2RPWmpxYWhIRklC?=
 =?utf-8?B?L1hzTmFiZW1kME9IMWtjKy9EQXBBTWNZMzc1VTBuRXhEV0Y3UThyeUs4WlRn?=
 =?utf-8?B?T2hFVE9tMXllRnp2c2FIbEFtVGVkNGk0aUdid2tyM2hiUzVDeU55RWh4Ritz?=
 =?utf-8?B?dlpENHU0Z0pNK3JTOW5hS01UZ3poVGFaRWxCazVJSVdJU2NYKzFyYTUrZzdT?=
 =?utf-8?B?akdpcjVOWFZtM0pJalF4NlE2WnY2WmtqZEc4MWNyNnlLQkJqM2plem0wRUg0?=
 =?utf-8?B?ZWh0YTlLb2huL3NQS1JQWWtWUGJDaUt1UWZBTmlCR1lURGw2bzdEUT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: ee01e68a-7705-4cf8-b57a-08dec6d90006
X-MS-Exchange-CrossTenant-AuthSource: CW1P265MB8877.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 10:14:04.4585 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 49+Bkb5LRU2odp6+MpOEnE7rfgHwrQZAb+A0ik0HUyL4iDiV5b8RpQnEMTHVHurpDTEWi01Jo7NgqvLqxPYQXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CWLP265MB2209
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

On Tue Jun 9, 2026 at 9:03 AM BST, Alexandre Courbot wrote:
> `Gpu` currently owns the state needed to unload the GSP directly. This
> means that `unload_bundle` has to be the last initialized field: once GSP
> boot succeeds, any later initialization failure would leave `Gpu`
> partially initialized, and its `PinnedDrop` implementation would not run.
>
> This prevents adding fallible `Gpu` fields that need to query the GSP
> after it has booted.
>
> Move the GSP state and unload bundle into a dedicated pinned
> `GspResources` object. Once that subobject has been initialized, its
> `PinnedDrop` implementation will run even if initialization of a later
> `Gpu` field fails, ensuring that the GSP unload sequence is executed.
>
> Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
> ---
>  drivers/gpu/nova-core/gpu.rs | 86 +++++++++++++++++++++++++-------------=
------
>  1 file changed, 49 insertions(+), 37 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index b3c91731db45..6b3e02c71dee 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -262,35 +262,59 @@ fn fmt(&self, f: &mut fmt::Formatter<'_>) -> fmt::R=
esult {
>      }
>  }
> =20
> -/// Structure holding the resources required to operate the GPU.
> +/// Self-contained resources to operate and drop the GSP.
>  #[pin_data(PinnedDrop)]
> -pub(crate) struct Gpu<'gpu> {
> +struct GspResources<'gpu> {
>      /// Device owning the GPU.
>      device: &'gpu device::Device<device::Bound>,
> -    spec: Spec,
>      /// MMIO mapping of PCI BAR 0.
>      bar: Bar0<'gpu>,
> -    /// System memory page required for flushing all pending GPU-side me=
mory writes done through
> -    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memor=
y-barrier operation).
> -    sysmem_flush: SysmemFlush<'gpu>,
>      /// GSP falcon instance, used for GSP boot up and cleanup.
>      gsp_falcon: Falcon<GspFalcon>,
>      /// SEC2 falcon instance, used for GSP boot up and cleanup.
>      sec2_falcon: Falcon<Sec2Falcon>,
> -    /// GSP runtime data. Temporarily an empty placeholder.
> +    /// GSP runtime data.
>      #[pin]
>      gsp: Gsp,
>      /// GSP unload firmware bundle, if any.
>      unload_bundle: Option<gsp::UnloadBundle>,

I suppose this field is for unloading only? If so, you could just create a =
new
type that stores `device`, `bar`, `bundle` only, which works as `device` an=
d
`bar` are Copy.

struct UnloadGuard<'gpu> {
    deivce: &'gpu device::Device<device::Bound>,
    bar: Bar0<'gpu>,
    unload_bundle: Option<gsp::UnloadBundle>,
}

impl Drop for UnloadGuard {
    ...
}

This does mean that the `device` and `bar` are stored
repeatedly, but this way you get a very clean way of representing this: onc=
e
`UnloadGuard` is created unload will happen.

Best,
Gary

>  }
> =20
> +/// Structure holding the resources required to operate the GPU.
> +#[pin_data]
> +pub(crate) struct Gpu<'gpu> {
> +    spec: Spec,
> +    /// System memory page required for flushing all pending GPU-side me=
mory writes done through
> +    /// PCIE into system memory, via sysmembar (A GPU-initiated HW memor=
y-barrier operation).
> +    sysmem_flush: SysmemFlush<'gpu>,
> +    /// GSP and its resources.
> +    #[pin]
> +    gsp_resources: GspResources<'gpu>,
> +}
> +
> +#[pinned_drop]
> +impl PinnedDrop for GspResources<'_> {
> +    fn drop(self: Pin<&mut Self>) {
> +        let this =3D self.project();
> +        let device =3D *this.device;
> +        let bar =3D *this.bar;
> +        let bundle =3D this.unload_bundle.take();
> +
> +        let _ =3D this
> +            .gsp
> +            .as_ref()
> +            .get_ref()
> +            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, =
bundle)
> +            .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?=
}\n", e));
> +    }
> +}
> +
>  impl<'gpu> Gpu<'gpu> {
>      pub(crate) fn new(
>          pdev: &'gpu pci::Device<device::Core<'_>>,
>          bar: Bar0<'gpu>,
>      ) -> impl PinInit<Self, Error> + 'gpu {
>          try_pin_init!(Self {
> -            device: pdev.as_ref(),
>              spec: Spec::new(pdev.as_ref(), bar).inspect(|spec| {
>                  dev_info!(pdev,"NVIDIA ({})\n", spec);
>              })?,
> @@ -310,38 +334,26 @@ pub(crate) fn new(
> =20
>              sysmem_flush: SysmemFlush::register(pdev.as_ref(), bar, spec=
.chipset)?,
> =20
> -            gsp_falcon: Falcon::new(
> -                pdev.as_ref(),
> -                spec.chipset,
> -            )
> -            .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
> +            gsp_resources <- try_pin_init!(GspResources {
> +                device: pdev.as_ref(),
> =20
> -            sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
> +                bar,
> =20
> -            gsp <- Gsp::new(pdev),
> +                gsp_falcon: Falcon::new(
> +                    pdev.as_ref(),
> +                    spec.chipset,
> +                )
> +                .inspect(|falcon| falcon.clear_swgen0_intr(bar))?,
> =20
> -            // This member must be initialized last, so the `UnloadBundl=
e` can never be dropped from
> -            // outside of the constructed `Gpu`, ensuring that the unloa=
d sequence is properly run
> -            // in case of failure.
> -            unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_falcon,=
 sec2_falcon)?,
> -            bar,
> +                sec2_falcon: Falcon::new(pdev.as_ref(), spec.chipset)?,
> +
> +                gsp <- Gsp::new(pdev),
> +
> +                // This member must be initialized last, so the `UnloadB=
undle` can never be dropped
> +                // from outside of the constructed `GspResources`, ensur=
ing that the unload sequence
> +                // is properly run in case of failure.
> +                unload_bundle: gsp.boot(pdev, bar, spec.chipset, gsp_fal=
con, sec2_falcon)?,
> +            }),
>          })
>      }
>  }
> -
> -#[pinned_drop]
> -impl PinnedDrop for Gpu<'_> {
> -    fn drop(self: Pin<&mut Self>) {
> -        let this =3D self.project();
> -        let device =3D *this.device;
> -        let bar =3D *this.bar;
> -        let bundle =3D this.unload_bundle.take();
> -
> -        let _ =3D this
> -            .gsp
> -            .as_ref()
> -            .get_ref()
> -            .unload(device, bar, &*this.gsp_falcon, &*this.sec2_falcon, =
bundle)
> -            .inspect_err(|e| dev_err!(device, "failed to unload GSP: {:?=
}\n", e));
> -    }
> -}


