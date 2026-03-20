Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D7B109878D
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 14:36:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8D3E10EAE0;
	Fri, 20 Mar 2026 14:36:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="nhOULIeT";
	dkim-atps=neutral
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011024.outbound.protection.outlook.com [52.101.62.24])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 645E910E16D;
 Fri, 20 Mar 2026 14:36:26 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dmXqyhl3x3E4i2OLQhiN0gFjuCPUTzkMpxpXIYSgjvvbrFwFJXSHgbJTDFCuzmMQdNxzJoQHaNWaLRPzxKuo6dph8SWAQ7xh80W6galriVAFuTf57xxbjoecHQgXdifgPUc9B64TkgU1iFrk6pLqCr/WP6TtkpUPlSIgA4Zw0yHXcfh44J54wnPp6tezPUYV30+mbWLgkvkd2+v1C243IuXTpKzJiyo0mLuefBVwjP5bpdeAtUV67uBU2HaZkdvzRHww8nwxMdASJQ6tSfvj2/kKFKAW03VGFy3Heg7MjnAA6KuaNwpz6HjgQvwxWAFcY153VMwAqczGqEkLbyp3bw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MsvOfB0A4/oaI05JKPzUu7JzADFiQxCYQXzL7/Bo1BU=;
 b=K1YVzFTfbUuON/ks/EXTEyIvzfq9QtqRzbOue7efPm811Ynh6m9bQM/va49QeDDynV0OGguHUrv+AdX7ZMIdZrZ22ATxd3IfX/XGmx1W1JTG59dJGx6pgaSemXSpp+EJ3Ysd1n7Hvl5eYWMU8V7EvRP3f6ayRmWQOWulIkCnf/unFa2jibdD1l7/6StS7e6V4egNy6O0uvEAqML60NgXjqA2PEVBJX95FpA3+Hz62LxgxxRAEj3rLUcWZrB0LgWoUGHQYwzwb8fdW9pFS+4J8Zur2w0XE09zED8uzFhSSVAU3jNr8Um7SSUozWy4srrOA54Z60y/2jJ4TYb5hK6Ezg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MsvOfB0A4/oaI05JKPzUu7JzADFiQxCYQXzL7/Bo1BU=;
 b=nhOULIeTUlqqNQoUesxiF2AnTTJxHXg1mO6j4mZpuOepB04vYZ76XpYJDMzdhP1T4ktrUBv8wAn8SR5nVK9tFxo/M2UK+FiP4Yjy2dgTJ3udBsEWKGJxZlJuY+aqajfDKa0bsUppbQNbTtGbUJZPiK3VxSRlD1JCUquKton35+ez4EoRhl8Qf/4gWDLynoIB89JMZEvH6TM18pp0kADwcqk71SGM4j4/2t9zKJyuAjKoAK6IK3Fq8PJk9Dsf6kpLwtGpHzR4iFgvfHI6vs3mH8ZVIpEwuSn7nmx2ls79pFIVeIcduJC72oc0VqNV6AyLF/dDrADaNzJgR8n4PEha7A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH2PR12MB3990.namprd12.prod.outlook.com (2603:10b6:610:28::18)
 by LVXPR12MB999198.namprd12.prod.outlook.com (2603:10b6:408:3dc::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Fri, 20 Mar
 2026 14:36:23 +0000
Received: from CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989]) by CH2PR12MB3990.namprd12.prod.outlook.com
 ([fe80::7de1:4fe5:8ead:5989%6]) with mapi id 15.20.9745.007; Fri, 20 Mar 2026
 14:36:23 +0000
Content-Type: text/plain; charset=UTF-8
Date: Fri, 20 Mar 2026 23:36:19 +0900
Message-Id: <DH7OODCRB8WQ.1GBKKZZHTNWC2@nvidia.com>
Cc: <aliceryhl@google.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <gary@garyguo.net>, <bjorn3_gh@protonmail.com>, <lossin@kernel.org>,
 <a.hindborg@kernel.org>, <tmgross@umich.edu>, <abdiel.janulgue@gmail.com>,
 <daniel.almeida@collabora.com>, <robin.murphy@arm.com>,
 <driver-core@lists.linux.dev>, <nouveau@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/8] gpu: nova-core: convert to new dma::Coherent API
From: "Alexandre Courbot" <acourbot@nvidia.com>
To: "Danilo Krummrich" <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
References: <20260303162314.94363-1-dakr@kernel.org>
 <20260303162314.94363-9-dakr@kernel.org>
In-Reply-To: <20260303162314.94363-9-dakr@kernel.org>
X-ClientProxiedBy: OS3P286CA0122.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:1f7::18) To CH2PR12MB3990.namprd12.prod.outlook.com
 (2603:10b6:610:28::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR12MB3990:EE_|LVXPR12MB999198:EE_
X-MS-Office365-Filtering-Correlation-Id: a33862d1-facc-411e-7f1a-08de868e0f4f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|10070799003|7053199007|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: sjw+gQF1mRptTMETg7VaCUl/u6a3nvBC48I6C5oXM/rVzhsCEgvzl3h0TRWzmTP//iAvb8Ze8CyKkc5oVzsTukYxn9ZfVAhPubMhdd6A6ZiKfXBnV09qkuPRSThqkLOjWR9GvG3CXU5FesO8WSmj0ZOsKmwycMiCCP4zOD45iBHTG3TlmZ9+bG2af6wI3dKhRTktVg0Xhpx9MOC/pK8g9N5cFT9bh8aYbXHloRRUyNs7DgLctuD7pkWDXc1Ga5z6OeAozU+08DLzdY3KZrOGnyozkodqIkeDWJI2fs+mMjnPrjg0fE21h2/fCsYER9Z6cQNNSwFS00PzUUC2MM0Rk0b0qxMDaYbOHNZXByLPvvoqULbd+Ab6ZekEZGmFQqfZVvjqEynuINgPwSPyWvNTSllIegBcUlIOeU5eNIUxrIX7Wi3pN2IDVT/5au6ECftv0+Vrs/u1bPNuu0lNv2HiScwWyXPyIZ4jdU95XUEtB10R530hee/69kfaFMm+7c7ExHQVVpBACtzvF2gpvuWBP/ltuGIRAldWqOfo2reWXvTrT/eYAhKKWDZsTc3gMUBvsK7BttqgWbhTgPifLt+MrMJb+/AcTF4+BskJM5ODA6Mpqh+wviXchzwwNUl40UUCOqbKoaP8PIqsnuHWq6Xwao9xeZYxhAaLWnO+96AES5arvvugbQuJYANF+5rkQYptfUkfypdPqROEezgJw0eitYaNg33F7PiFdsQnojDxF3M=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH2PR12MB3990.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(10070799003)(7053199007)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3BkNi82Ulc0ajRuSWZYUnpZYWJSd1pmWHdsbXlTOHlQWjE3QlQvVlVHQUN0?=
 =?utf-8?B?VTk5WjIwckxCVENKUDhqVlRQSDZTRUZVakc2bVREV0FJSTlnY3ZvYkZBVlBt?=
 =?utf-8?B?YVlzQkhIeXZyUEFSV2gxMHBJeDhEMysrd0lURmtqNmJqT1JTSkVmU1pCdDFP?=
 =?utf-8?B?NXRISWY0N3dCUEQwZ1RFZUtqL3ZlMTRReXJWVUQzdEd1a0xwOFFBQXF0emk2?=
 =?utf-8?B?QmpwbmlVUXM3N3FpRGt2dnNIY0VscjY5VnFXZ3h3S1ZWNVlIUjVseUdUazBJ?=
 =?utf-8?B?dzUybDU3L3dIaWJ4ZVVwb0dCOENiaXB4UjZzMC9ESU9QTUtPcWpUWEhpdE9M?=
 =?utf-8?B?QW5TSTh6K3doSzAyZlJ5VTZqNUJIYnNzY2RrM2JFZDRzZ21rZzU1NEg1S1ZL?=
 =?utf-8?B?U3o5SEhXQWpMRG1qRU9VR1l6WmFmM0J4SlBCbTlhN0htZEgrdmhaNEF1QTFO?=
 =?utf-8?B?ZEJqajIxSWVlVjMyelQ2WmpKNCtZTzJFNk53N3FZb2U3Y3I1WFJreCtudEJR?=
 =?utf-8?B?YXNwMGVCYmdCQXVJc3h6QWR2a3pJd3ptS2V4SVNublVDTWtNM1BmYnB0Z3Jz?=
 =?utf-8?B?NFpRVDYrSUh2TFZuZC9vOS93bXUybWtvcmlMYkRkRVk1ZFpsZGFYdFgxckZS?=
 =?utf-8?B?MDhFbVc3L3pnZ04xWHpoa3BvTkVGamR0YkdaSmJqYkhMVGhkczd1Zi95RUgr?=
 =?utf-8?B?MXAwaGRqakdoaVhjYU43Qk0vWHBQMHJNcFVFSWFwRjBHVTdrS2NtL2JhZm42?=
 =?utf-8?B?NW5LZjFPL1oxTjREc1FZeFhlc1pGZGZqWkhTY2FIc3JwbWxDaFNMZDJ0eHBi?=
 =?utf-8?B?eGQ0VDV2SHZvelpTNjJFcjZqc21JenM0TDNxNG5ndGFxZDZJclMvNXd0RFdB?=
 =?utf-8?B?R2JVeDcwanc5OVc4SXJCWlEzeTU4Z2Fqekp0UHNOYlFMd250MEJlTW9FZFZF?=
 =?utf-8?B?OFpNTkNvRkljTytTU1ZjZ1lmM1R2Q01UbVJxNCtCbG5TVHh6dFZIUm9lenha?=
 =?utf-8?B?bkNsSjAxZDd5VFhtUitPckU4bmdTWEFtLzFmSzMxbldmQjh2TFhPb3RBQWlU?=
 =?utf-8?B?Qm9vcUxWV1pWYkhTbmhZRkxnNTZpSU14Zm5ndk11V0QydXEyZ3JxekdTeEJs?=
 =?utf-8?B?b2lkOVRtQW5FVGxMMlJTMWFnL09RdUQ2VHM5cWdzclppSmFhY1huZVRKNUJx?=
 =?utf-8?B?TDdlQnBEczY3dTBVeUYwZjZuamxiOVg4YmFWNjMrcUo5SGRaS3hDWjhiV1Mr?=
 =?utf-8?B?aUFDa0hEb1JPTFA2NjMxekhlZXh0NG5nVmJXVENWNWVwa2RqU1NvN2VZS3pi?=
 =?utf-8?B?cU1pMEY1YTI1MEthS3hPNm5wcU00dlJqQTBOQmI4aVhXQWRKVVFqSFliV09h?=
 =?utf-8?B?VTBYSXdPTnJiSi9Wc3B5RXM1a2JINVN5eDBmTVZVSlpLcWdObHhYLzgraGp1?=
 =?utf-8?B?LytjeU1oMUFzZWc4aE45cUVxVHhFWmZqN3QxUy9MOXhrbWFuTy9hMXNvWFZI?=
 =?utf-8?B?enNQN1hnOVliYXNBTis0ZlpENGhvdWc2WDFkNzJucTdKWmJiTHBBWTdrZ3Fy?=
 =?utf-8?B?Ykw4QkRxYkNzVlhvMDU2azBDdU5xNWVWUzV2eFZCZEdkSDY4YXJEbk1DLzdD?=
 =?utf-8?B?YlJwUy9BTHNEUHlxWHFuU09RanJHMDhFTXhtQytEclk0MENUOUM0N3pXYUI5?=
 =?utf-8?B?dmJXdzhsMTNGbll3UHFyaEVnUm0zUS9LSDI1RVI4RElPa2NiQlV1NUdBY1pP?=
 =?utf-8?B?aHZvZHAvNmtmQldlYkVSeU9rdXlpbkdMa2tmSnhWekxhWE9QZU55aDVpanFw?=
 =?utf-8?B?VzQ5dGhMbWlsVVA3YkJCK1VGNXNacWphb0lnVFp0SE9BZ25Bb2ZsWkE5UjB5?=
 =?utf-8?B?ZndxSDFyQWw1WUJYdlZVZWgyTXF5UlVGY2J6TEdVOTc1TXhMRTlpMHBGa3VK?=
 =?utf-8?B?NHZTWWxETzFvY1NBdy9FQkwyTHpkU1M3eDZFdHFvaTNFVGpMK0t1Z2pDWHo4?=
 =?utf-8?B?WWRpcTJrL0Y1YTdCQVRmdHF0eUZoWEFEczFqTUg0QWpMUEZ6SnNiU0p6eE1M?=
 =?utf-8?B?UGZUWkhJMGZJZmQzbW1oYlRiTHlxQ0d5OFJrS0JrRnI3KzRoeXpMSUFSRjFZ?=
 =?utf-8?B?WkZHaUFsQm1wN2p2Q0FiR2pPaGlHaTd3MzFxUmwrOEV6VjcwekNyekhHT3Br?=
 =?utf-8?B?RFh0MXUybUtOL3FSNkR6aVVPOWltVzBFRnJDQnFDMWtjZHd1SllGQ2M4RjhW?=
 =?utf-8?B?cFVzbU5ZZ3pNVGlEcWdiMjl1QTJ2S2lpTEVWbjkzQkhCcklYT0k1Q1BTQTVx?=
 =?utf-8?B?cG9CaDJUTy9sY0FKRXd5blZPMjYzRnkrMGxuaHBsdnBsZVFpS2lxdXVnOTRQ?=
 =?utf-8?Q?1ktvgyQj3Ubs4rWYoPC09Exdl4c4RlHcswUwoAPYhQHSj?=
X-MS-Exchange-AntiSpam-MessageData-1: 8zvg/2sRPvZW1g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a33862d1-facc-411e-7f1a-08de868e0f4f
X-MS-Exchange-CrossTenant-AuthSource: CH2PR12MB3990.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2026 14:36:23.7334 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YGOh0xBUQ9IUJriweNodv6kPJtpvcBDHfQjkXpy5Ce6hEP4fcS9z40j9EOdu5jdjj6L++439iaqheFXwdIuwGg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVXPR12MB999198
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

On Wed Mar 4, 2026 at 1:22 AM JST, Danilo Krummrich wrote:
> From: Gary Guo <gary@garyguo.net>
>
> Remove all usages of dma::CoherentAllocation and use the new
> dma::Coherent type instead.
>
> Note that there are still remainders of the old dma::CoherentAllocation
> API, such as as_slice() and as_slice_mut().
>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>
> ---
>  drivers/gpu/nova-core/dma.rs      | 19 +++++------
>  drivers/gpu/nova-core/falcon.rs   |  7 ++--
>  drivers/gpu/nova-core/firmware.rs | 10 ++----
>  drivers/gpu/nova-core/gsp.rs      | 18 ++++++----
>  drivers/gpu/nova-core/gsp/cmdq.rs | 55 ++++++++++++-------------------
>  5 files changed, 46 insertions(+), 63 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/dma.rs b/drivers/gpu/nova-core/dma.rs
> index 7215398969da..3c19d5ffcfe8 100644
> --- a/drivers/gpu/nova-core/dma.rs
> +++ b/drivers/gpu/nova-core/dma.rs
> @@ -9,13 +9,13 @@
> =20
>  use kernel::{
>      device,
> -    dma::CoherentAllocation,
> +    dma::Coherent,
>      page::PAGE_SIZE,
>      prelude::*, //
>  };
> =20
>  pub(crate) struct DmaObject {
> -    dma: CoherentAllocation<u8>,
> +    dma: Coherent<[u8]>,
>  }

Actually, do we even still have a need for `DmaObject` now that
`Coherent` is available? It would be nice to check (as a follow-up
patch, I can look into it) whether we can remove that whole nova-local
`dma` module.

> =20
>  impl DmaObject {
> @@ -24,23 +24,22 @@ pub(crate) fn new(dev: &device::Device<device::Bound>=
, len: usize) -> Result<Sel
>              .map_err(|_| EINVAL)?
>              .pad_to_align()
>              .size();
> -        let dma =3D CoherentAllocation::alloc_coherent(dev, len, GFP_KER=
NEL | __GFP_ZERO)?;
> +        let dma =3D Coherent::zeroed_slice(dev, len, GFP_KERNEL)?;
> =20
>          Ok(Self { dma })
>      }
> =20
>      pub(crate) fn from_data(dev: &device::Device<device::Bound>, data: &=
[u8]) -> Result<Self> {
> -        Self::new(dev, data.len()).and_then(|mut dma_obj| {
> -            // SAFETY: We have just allocated the DMA memory, we are the=
 only users and
> -            // we haven't made the device aware of the handle yet.
> -            unsafe { dma_obj.write(data, 0)? }
> -            Ok(dma_obj)
> -        })
> +        let dma_obj =3D Self::new(dev, data.len())?;
> +        // SAFETY: We have just allocated the DMA memory, we are the onl=
y users and
> +        // we haven't made the device aware of the handle yet.
> +        unsafe { dma_obj.as_mut()[..data.len()].copy_from_slice(data) };
> +        Ok(dma_obj)
>      }
>  }
> =20
>  impl Deref for DmaObject {
> -    type Target =3D CoherentAllocation<u8>;
> +    type Target =3D Coherent<[u8]>;
> =20
>      fn deref(&self) -> &Self::Target {
>          &self.dma
> diff --git a/drivers/gpu/nova-core/falcon.rs b/drivers/gpu/nova-core/falc=
on.rs
> index 37bfee1d0949..39f5df568ddb 100644
> --- a/drivers/gpu/nova-core/falcon.rs
> +++ b/drivers/gpu/nova-core/falcon.rs
> @@ -25,10 +25,7 @@
>      driver::Bar0,
>      falcon::hal::LoadMethod,
>      gpu::Chipset,
> -    num::{
> -        FromSafeCast,
> -        IntoSafeCast, //
> -    },
> +    num::FromSafeCast,
>      regs,
>      regs::macros::RegisterBase, //
>  };
> @@ -434,7 +431,7 @@ fn dma_wr<F: FalconFirmware<Target =3D E>>(
>              }
>              FalconMem::Dmem =3D> (
>                  0,
> -                fw.dma_handle_with_offset(load_offsets.src_start.into_sa=
fe_cast())?,
> +                fw.dma_handle() + DmaAddress::from(load_offsets.src_star=
t),

Aren't we losing the bounds checking done by `dma_handle_with_offset`?

Mmm, but looking below we are checking that the end of the transfer
doesn't go beyond the object bounds, so that was probably redundant
anyway. Maybe we should do a `checked_add` still for safety.

