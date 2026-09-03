Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8790AC624A4
	for <dri-devel@archiver.kernel.org>; Thu,  3 Sep 2026 15:42:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D73EF10E12F;
	Thu,  3 Sep 2026 15:42:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="gsnJWsyi";
	dkim-atps=neutral
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022107.outbound.protection.outlook.com [52.101.101.107])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D5A9E10E12F
 for <dri-devel@lists.freedesktop.org>; Thu,  3 Sep 2026 15:42:08 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pZDdVISVO/bOjEIS+RJMx1skbnevi5UcvatIVC78pcQklZroBJk14s4zh1Dr2HgHGUIuA7IiTWzDWAKMYHc5VXO2ZpAlqmV3+lG/AtxC1xy7h05K5b31cvXjbgEMOWBfn9HuEHIKSiUzj3IFBUfpWQDE/QXR+BZ75b2zTW90xx3iJOC12L5loXi7Vdac8i1iuIw2uDA6V1l1ov0GVg2bTIKZ0HeSS9kM7D75H9SF5MKHE6Ju+6K6w9MsiBgx7usjIsmH4HY6LzREltx7ysw/JMPRPOTN0q5koIChtO+maYaR5WRC+TUi0VmP8+VhAwJ6SEVTZ+W2CL9oL1bvpur1ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1DqoLJ9M/9Ciea7D9Y7BTBDatoxUr3knQkh8dJhV/yw=;
 b=BYe9T++xqAIaFuuJsGiwA2H/YhpVQe5uQl0btE8/uQn394oIUrYNRYeAz9V6kBV6wzqqgHJmpW9iWDWPEK+QCscU/FGpU/F65DkHQ/B6MfwK4lsAXOYfW7N+RjKAL9URhtUykKyTOwdY29ibAR7y+nRElcuzEY4dIXwQU6BVGu28gvwObv8nmXVbiK2qwh9z4BMCqbO/b97YEyO0OaL8/0DQwWGHQiFAu7w0GXIxOB/SGQCpIE2FwwYEH/pDWV+aQJ3Z7a7aKp/9zOrdqTLypa1wVXmWMQrYkjl0Z9OUoVbw8dfuE9tberry3sT+ThBECz/98LLoI6Bl2njV//a4Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1DqoLJ9M/9Ciea7D9Y7BTBDatoxUr3knQkh8dJhV/yw=;
 b=gsnJWsyiqrvkn4FzqsVCnzyPAKaFlH9kWzLL47lDwAzbskE1gRw4M7KJhJRHDDbOLASjZJiA0AVQJNoCi8VlQeKW6eb6cnd3JR3Q8ZmR8083L/duy/VqEzAhCILQdHVyFpoC2b9aFrZDL7KJluM/thJj8DATwsnVgz47TElUShI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4ab::19)
 by LO9P265MB7430.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:3a0::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 15:42:04 +0000
Received: from LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1]) by LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 ([fe80::f60b:1537:68d7:4fc1%4]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 15:42:04 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 03 Sep 2026 16:42:03 +0100
Message-Id: <DL5SNOAXWIPE.1WPMZGTWV7DZT@garyguo.net>
Subject: Re: [PATCH 4/4] rust: dma: tie Coherent and CoherentBox to the
 device's bound lifetime
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: <abdiel.janulgue@gmail.com>, <daniel.almeida@collabora.com>,
 <robin.murphy@arm.com>, <a.hindborg@kernel.org>,
 <gregkh@linuxfoundation.org>, <rafael@kernel.org>, <aliceryhl@google.com>,
 <acourbot@nvidia.com>, <ojeda@kernel.org>, <boqun@kernel.org>,
 <bjorn3_gh@protonmail.com>, <lossin@kernel.org>, <tmgross@umich.edu>,
 <tamird@kernel.org>, <work@onurozkan.dev>, <mmaurer@google.com>,
 <driver-core@lists.linux.dev>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.22.0
References: <20260830193824.471089-1-dakr@kernel.org>
 <20260830193824.471089-5-dakr@kernel.org>
 <DL5PMZZO1S7X.3BMZVKVUMYVM0@garyguo.net>
 <DL5S8GFKETAW.1UD50XK77ZPA6@kernel.org>
In-Reply-To: <DL5S8GFKETAW.1UD50XK77ZPA6@kernel.org>
X-ClientProxiedBy: LO4P265CA0186.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::13) To LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4ab::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOAP265MB8560:EE_|LO9P265MB7430:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d661d51-2280-49e8-b57f-08df09d1e721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|10070799003|366016|1800799024|376014|23010399003|22082099003|18002099003|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info: x+UYLVYVb8XH04Trui3EsraKpwmkPfOjkJZhsskKKJn2sDaRrMJkUDP7sxWE9VCnYRTQvJniHc+rS0RoDEAQDKRXgc+WEXR2n7oo1Gw9lvOBALH7VXnOxd5jdqXl5AXi08bVC1vSSQeK+lDvvlwlFKw58I893ql+1X8X9T8g+CABm6RlX8DSxgyvYr8U+vZOTwtwtCW+m1VP3Q6CN2qc3OWpyhPjuBIGR+xa+O8mOeiWoJ9SJFPsjNnpf5RD0OLc1vhW5D3cF4zVxMwB3FyJ+7GBW3tRsoLkzfXCF3WEpHe/jQJuXF0Yt3xc8vmxDoErkf4vLSxFkisB/LGruILryimdxnYhd0bbBdbbOx9vVdo8V7uBQDDCyVpE40kwqFkHKLTpEufnCzCu6JcJ4GXuf3mUDfoMV4BKjW3B1gQAvQ/D2NK9CXt9iDKSaz1uqSKD0VAa2DvyTsYyCnnxh1Ud/MylDhWRDUtHbDQ6cwWlYx9F5+Zn8tUZfoyqrmMNdamTvAe7g84slJmm4/CHYrPk0OhLm4OkviysdannSC+nb18Ic1mdmhJs78rroBIXlfa0okAqSbocgQdcINUIhL7+fxv/oeW3MbnvkG8lZY28YaJF3XOE4TsNttmCv3J/7EfgvC714QLvpjRWA85TqCFbAEuzHACooUmFMQPJBTLW3Rs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(10070799003)(366016)(1800799024)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(4143699003)(10067099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QkVTK1J1RGw5UVQyMWRoMjlNK3JOdFpoTTJlcnQzQmorNWdKajNjRmVpZWpw?=
 =?utf-8?B?TlRGMEN0ditBVEdXU3FPM1luMy85bjBQVitnVlpYVFFCUHRZcHMrZm85N0tI?=
 =?utf-8?B?dXQ1UzJaZjBaZzFudnJWTTVPRWxLNFdnbCtOVWxlYkJpUUlXWUc3Szlsa3M4?=
 =?utf-8?B?bUpqK1lWSWVhUEsyYUhiWUZqRFpTUUtSdmNxblRueFk2WWtpTHZQRHVjd21P?=
 =?utf-8?B?SHRacTNuZ3JxUlpoWllDcG8vZ1BzQVpsZVVqRHdyL2NtL0RXaXZlODlybVNu?=
 =?utf-8?B?QlZKY3p6MGplREVmRXZacTZYL2RIc2p1K01EdEFGZTZzV0I4OUVUcUVRbG1m?=
 =?utf-8?B?ckMyVStFcERzNENHajBmWjBJbXVMK2RUSHBJY3FOMXhXdHF5TkJscHRBZFZu?=
 =?utf-8?B?Ynh4czFIcENONFNuMXZLZEhYKzF4Sk5RdjBjOFZRT0VVcko2aG8zZC8zdDFS?=
 =?utf-8?B?a2ZQVEJ5SHZFNnVZYThtTmczSy9QSGZrMjczWG14ZFRYYWJrU1dEbWFoZ0pq?=
 =?utf-8?B?UEpNYzByNGl2dUxweGxGWWhwa1hMeXY5b2VZazMzL0UrejFsdGNONlgybk5w?=
 =?utf-8?B?bEN3bjFZeGZYbjhRcHhTdGtEem1WNElVZ29JMGxRVWVwWXVSeUd2dDNhc004?=
 =?utf-8?B?c3dQUUVMUWMzUWJ0R0RWRGNBckM3U05Mam9LeVpEN1lKYUxCL0c1TTU0emxp?=
 =?utf-8?B?THpaZmxDQWxYWnZ3eXNtZ2l0SGY4SGIxTHFlZlIraXFMeS9Na0pzRUcwd2pj?=
 =?utf-8?B?SlF0Y0E0dk5td0hOZFIwYVc1Y2t2cC9WOGFSSWxDSFJvNzk3S0NDajBoVUpK?=
 =?utf-8?B?ajEyb1I3SzdqdytiSnMyc05ycm0vazRkVmZwRXAxcmdhaElYUGpxZlNQekJr?=
 =?utf-8?B?Q3JsblFzb29KYUVRVW1sWCtkb1hoa2JvamhGZUNlaDVEeE51TVh6OFJCS1Bp?=
 =?utf-8?B?Y2VQdEhGdzJPWVhsaUVPeWh3QkNBTlp1ZUVjN2VEMUo2RUJkWHg4K1pRelMr?=
 =?utf-8?B?VUhXK0tNRVF5VzA5T1loaXRmelNNZG1aR2lNL0Y0Q1V4ZjR5bEpiWGlXS2pu?=
 =?utf-8?B?OHlmMkF2ZmU5UFJFQXJIOTJZcmwvSkZRZjcwUko1Z0NkVzV1S3lDSXpwMXdi?=
 =?utf-8?B?ZXVuZGdEMlphSmlyZFZFMFVkUUk5Y3RaT25WUXNMMmlzR2NNN1RTRXZ2RlFN?=
 =?utf-8?B?MFc5aW5qakg2VE1LSzRtcExpZ3NRZm15Wm4zQytWcWJ3RGV1SmJ1bGkxL1Ju?=
 =?utf-8?B?WjFBMHB1UTlaUHE1bDBmcXgyeUlYaXE1TFZPU1QvMVNiQktVU05DZExRVStR?=
 =?utf-8?B?cUNVTnlMK3FNWmM0U2VBd3RPVkZOajc4WkQ5VDh2OGlycmpwTGZ1SlJJWFAx?=
 =?utf-8?B?NjVlOXBIZFpwdkczakhrQUVpRjBVQWlQdzNhVmpMaG01SmpJd0gzVW0vYnpE?=
 =?utf-8?B?TURrY0N1ak9LUktmdzZGekFRS0xsMXU0M3VJb3V2OUxmZm9Db0lucVpBMkJj?=
 =?utf-8?B?b1duRUNWY1E0Snh1SHFYOVlKcHFFd0ZqQm1TMFZST2lwWXNzREsrQmw0Zi9Q?=
 =?utf-8?B?bDkrWEVVbTBaNmRIRTNwbWFTblhjc3B2aUhzampaTTFHR2I5ZTlQSmlxa1px?=
 =?utf-8?B?cVZOb1BDazY1VXNUb0VrUEppdUtPZHloVGFXclVqR2d6S1VES3g4U1JGNGhT?=
 =?utf-8?B?VDZmSHllaXY0VUhla0xKMWJTcXR1WnY2OFlvYzRWQStpTmFLWWRyZGNMS3Rz?=
 =?utf-8?B?Y294QlJmZ0lOb1Q1L2c5THdiTk5KaWowbThvUjlGVXUvTzI2QXR5dlJJMjFU?=
 =?utf-8?B?TlZKdWx6ZExlK0NOYXVwNDU1VmQyUFY0K0F1eWMvL1JSYU8rc0gvSWk0YytZ?=
 =?utf-8?B?WEltLzZVUnR6ZUl2dW5qbDlzR0ZHLytGQWt5S3ZCWnE5djR0VHBEQU5pQXNp?=
 =?utf-8?B?N2lTQUFCQXplUFZFZ25TQkhFYmxWWUNmQlJVejUwcVlxSlZPa1pWd0xaV2RL?=
 =?utf-8?B?a3JYYk5ITFNvY1AwYjNOMytObmEwb21KUHd1b1NiWVltVzY2UDlZUUJVc2E1?=
 =?utf-8?B?ZjQ0N2pzdzhMM0ZCMnJydm9hZTc2QXk2aU02cVNCQzc4THlrR1R1RVA2UjRk?=
 =?utf-8?B?M29DVTBwUUViUDR1YjliMlh4ZXUxSStaSERYdnplVXZMaCtZTXpnWTNMMHAy?=
 =?utf-8?B?a0NKUEI4TEVCL0FnTFBPSCtXZHRZUzdacW9nVWIwU05KakhaOUFMeHBPSHdV?=
 =?utf-8?B?NThtc0JPRUI3aEx1TVI4SXJ6L2QwcEQ5dGpmVHEzUlBJVlI3SHR0eGcvUGNN?=
 =?utf-8?B?bzVKTzdkS2ZKdUpqamlrZDcvNzhORldCcGQ3R05iVlhiL0Z0eTdDdz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d661d51-2280-49e8-b57f-08df09d1e721
X-MS-Exchange-CrossTenant-AuthSource: LOAP265MB8560.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 15:42:04.1765 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l9LOcFqf13sK5jrUD3yWh4/6dO2z2sTZURQzw6J0jhWi12MKG6f8XVhg++LooBATQcWyHg7aJfbVTI8OOpciGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO9P265MB7430
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

On Thu Sep 3, 2026 at 4:22 PM BST, Danilo Krummrich wrote:
> On Thu Sep 3, 2026 at 3:20 PM CEST, Gary Guo wrote:
>> The rust/kernel code looks good to me. Haven't checked nova part in deta=
il, but
>> it looks like a mechanical conversion, so would be fine if it builds.
>>
>> Reviewed-by: Gary Guo <gary@garyguo.net>
>>
>> Sashiko points out that the `Coherent` could be leaked -- what's the imp=
lication
>> when that happens? I think it's not going to be as problematic like
>> registrations because coherent allocation carries no callbacks, so we pr=
obably
>> don't need this to be unsafe, but I do wonder how'd DMA subsystem handle=
 this.
>
> The implication if leaked is the same as if it is kept alive past driver =
unbind,
> which is why I changed the TODO comment accordingly in the hunk below.
>
> If you look for a specific example, there's [1] for instance. So, it is
> problematic, which is why I added the TODO comment back then.

Right, so despite that `Coherent` itself not having callbacks, IOMMU side c=
an
have callback that associated with `Coherent` instance and thus require dev=
ice
to be bound.

>
> But, we did accept this soundness hole from the get-go for both, keeping =
a
> coherent allocation alive beyond driver unbind and for leaking it.
>
> With this patch it is now impossible to keep it alive beyond driver unbin=
d, so
> switching to unsafe now would be a bit odd. :)

No, I don't want this to be unsafe.

I just wonder if it could be made not unsound at all. I think in this case =
at
least it is possible with a revocation mechanism -- the `Coherent` itself i=
s
just a piece of memory and does not reference other resoruces, so the
destructing it late does not matter (unlike registration). So at least it i=
s
*possible* to close the hole.

> (The fact that we did accept this for coherent allocations is also one re=
ason
> why I was recently arguing that we can also make the forget() issue an ac=
cepted
> soundness hole for registrations.)
>

For registration because it references other resources so I think we cannot
close the hole with changes internal to each subsystem.

Best,
Gary


> [1] https://lore.kernel.org/all/6a7910da.9c11d2ce.289b96.00da.GAE@google.=
com/
>
> @@ -588,26 +587,20 @@ fn from(value: CoherentBox<T>) -> Self {
>  ///   to an allocated region of coherent memory and `dma_addr` is the DM=
A address base of the
>  ///   region.
>  /// - The size in bytes of the allocation is equal to size information v=
ia pointer.
> -// TODO
>  //
> -// DMA allocations potentially carry device resources (e.g.IOMMU mapping=
s), hence for soundness
> -// reasons DMA allocation would need to be embedded in a `Devres` contai=
ner, in order to ensure
> -// that device resources can never survive device unbind.
> -//
> -// However, it is neither desirable nor necessary to protect the allocat=
ed memory of the DMA
> -// allocation from surviving device unbind; it would require RCU read si=
de critical sections to
> -// access the memory, which may require subsequent unnecessary copies.
> -//
> -// Hence, find a way to revoke the device resources of a `Coherent`, but=
 not the
> -// entire `Coherent` including the allocated memory itself.
> -pub struct Coherent<T: KnownSize + ?Sized> {
> -    dev: ARef<device::Device>,
> +// The lifetime parameter ties DMA allocations to the device's bound sco=
pe, ensuring they are freed
> +// before the device is unbound under normal circumstances. However, if =
a `Coherent` is leaked (e.g.
> +// via `mem::forget`), device resources such as IOMMU mappings will not =
be released.  Making all
> +// constructors `unsafe` to prevent this is considered too restrictive f=
or the common case; this
> +// soundness hole is accepted for now.
> +pub struct Coherent<'a, T: KnownSize + ?Sized> {
> +    dev: &'a device::Device<Bound>,
>      dma_addr: DmaAddress,
>      cpu_addr: NonNull<T>,
>      dma_attrs: Attrs,
>  }


