Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921D0C56201
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 10:43:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B866910EDDB;
	Wed,  5 Aug 2026 10:43:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="vTGmYkHB";
	dkim-atps=neutral
Received: from LO3P265CU004.outbound.protection.outlook.com
 (mail-uksouthazon11020135.outbound.protection.outlook.com [52.101.196.135])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9076610EDE0
 for <dri-devel@lists.freedesktop.org>; Wed,  5 Aug 2026 10:43:13 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Dk3kz15lZ3cyDl2ZKTLATVaWYHA4Yfp1V42Uvm6OdZcHctmFH98QutqcFJXl3A5N+7wzPxhFZOX4rUlJvv/7UNcakU32ISDHmKPfoCSFxNPUdlu60i6MxF6RzEqSn/6x1a8U0KG8YEoNmJ4tbXHFcpVEYW7CUk+KxfwrU6qNq6vcg4jHf71qJpz/xCr6SmLdf8DCNL8zggspqT3d4Cs1P8eBYzzWWMZLLhvxgnmqdhzlnbjSgEpv/XPlHtEGMh24JlKumjz1fHly5x7BNwLwypiTYzC/18tFq+04Hs+dtVsKTMROkjdnveQSDyCXEbq4dneGesTS2qh7XcI6CGeUJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+CNTMZs7UmLYoxVAwaorCR59krU5bZFAf/HHxWZEp1c=;
 b=SEi/WxqhqbyVwpjHursRc9edihRgTAJ/kr3FMOZb9De9ya/CxYYh+5pMtbssY3ZGlyfhRAWzBC/mbUxJ6VZt3Guc6YFn9bzebyikkNoqGqKlxVc0eBhsdbJ7Zz7PKEPQEG9qtJHtfHEe3HpL+WEg9BARwzoDK3rJdAysRFHBYkQ8Ksv+9WTB8eb4yLgT3vZB0ELmP9We773KBV9iE3AVyyWoZyF/v82iJGX38VKKglqhLz6O0eJnYQEyVCaQi7GIXEWK+b6Z7sETuYHv1nlFK+SpVYZRSByu8Vx2+o/qSdKUaH5DaKVmifw+DxNylGiJckN1+KeVH72eAOt+XAZhiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+CNTMZs7UmLYoxVAwaorCR59krU5bZFAf/HHxWZEp1c=;
 b=vTGmYkHBPvgbTe2vnIzIIUoH3yCoQnp9IE4VWcIw1mZhZOmLaPPu2NXT2WRwH73uWj6JcCY5zGgaE6qOK3CPXBCNRFTXNjt92MHfmZHRAORkPlJ+BoUpUvppyCvLiTXI7OSUcsBGDKhsSBo0UkTHnNiqa543ykWyE1EKQTxxV+o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:4b4::24)
 by LOAP265MB9175.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:498::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 5 Aug
 2026 10:43:09 +0000
Received: from LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a]) by LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 ([fe80::c07d:488c:d4aa:2a4a%4]) with mapi id 15.21.0270.017; Wed, 5 Aug 2026
 10:43:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Aug 2026 11:43:08 +0100
Message-Id: <DKGY508IDAS4.9E9983YWQ2F5@garyguo.net>
Subject: Re: [PATCH 01/12] rust: io: add Region::try_subregion
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Miguel Ojeda" <ojeda@kernel.org>, "Boqun
 Feng" <boqun@kernel.org>, "Gary Guo" <gary@garyguo.net>,
 =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, "Benno Lossin"
 <lossin@kernel.org>, "Andreas Hindborg" <a.hindborg@kernel.org>, "Trevor
 Gross" <tmgross@umich.edu>, "Tamir Duberstein" <tamird@kernel.org>,
 "Alexandre Courbot" <acourbot@nvidia.com>, =?utf-8?q?Onur_=C3=96zkan?=
 <work@onurozkan.dev>, "Yury Norov" <yury.norov@gmail.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, "Maxime Ripard" <mripard@kernel.org>,
 "Thomas Zimmermann" <tzimmermann@suse.de>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>
Cc: <driver-core@lists.linux.dev>, <rust-for-linux@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nova-gpu@lists.linux.dev>,
 <dri-devel@lists.freedesktop.org>, <linux-doc@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260805-pramin-split-v1-0-ff3e84a75dac@nvidia.com>
 <20260805-pramin-split-v1-1-ff3e84a75dac@nvidia.com>
In-Reply-To: <20260805-pramin-split-v1-1-ff3e84a75dac@nvidia.com>
X-ClientProxiedBy: LO4P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::23) To LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:4b4::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOZP265MB8551:EE_|LOAP265MB9175:EE_
X-MS-Office365-Filtering-Correlation-Id: cb81b229-c20e-4f23-a5e2-08def2de5702
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|23010399003|1800799024|376014|7416014|366016|921020|6133799003|4143699003|10067099003|18002099003|22082099003|56012099006;
X-Microsoft-Antispam-Message-Info: 7/JvGy/8gZSsafNXq5C+rXAygIsSTKOBlAQ7gM9bRMqfRpjeHNZ+uBH98vrK2p/7rjVZh2+4Qr487AOGnozZWVzc9sZ/Aebazk55ReC9V2P3ENm71qwHlPq7rEwJ6WLb5cIOkWsxsSfYGzVKjS958H0/AbwvFCdoWSvMwMIl9eSZu+x63BGsoFsZzPlvzk9U+08RuzOMVkGOWBsG6A+/9Q+oO7n94odblkbwWrUbvxcDk2L7dy22qnTwTi7ZZL3StEyQGImHjy6npXeGtNJDKARTc6yJmJOYrCIou6pCpZ/zFp2MynsUVVVP2zkt4PiIZjQOFFo81ZuIDoJGIkR8K9o8ZEhIACxXLk4eK3yjGvlOcnLjBWItOKoi+XKq5Iqa8gww51hSCPP1HNw2LkqS0O4dUYoJqmO9fMmS2VNT0pVEdvh9ZRXgNwsYX5eigmyaTb8a1fgREn+o5wBBbSSLnX5AK5Wa529ulBI6vM2yaVJ2UA63UNxWHg1EyPXjjR/WuZO09rfxTCBkMvfefIY4rowHwfbaUQcRwlp4r5uuWw7WIJra7IjJzH3cVEP6hGspwWP+6tFZMC2c2SsCHLUcO7nlBox8yC85PkWVjNMC7XwyYODnpQ2onnzXl75hlVXt5oLNJVNf0HCzgKk/9BNW0UM7Kv/2gc3jb4Vvfgj+5eqU83gPec7uIaNJGGidUBVECoxsY8iXaREMDetW1Kgdfw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(23010399003)(1800799024)(376014)(7416014)(366016)(921020)(6133799003)(4143699003)(10067099003)(18002099003)(22082099003)(56012099006);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlJiUXR4N2lVNEZvUHRJQ0JuSGdXQ2oxbXVvZWVvZGVSdHk2MmZ3MFlKUjhU?=
 =?utf-8?B?c1FIc3hwdmRZcFFzS2xiVmZrRkNKeXJJUDVUb1BWT0tjVXJ6ZEZod0RkWkNU?=
 =?utf-8?B?VW1ldHBCVi9jTk4wbmR2Qk1DbXFVNlcyeWpVOFRLVGxtWlNkcmkvenFSdjRQ?=
 =?utf-8?B?U2x1Z3F6ekFzeUVGOWVGbFhZa1V3Q3NCbnBOOGlrYmxKTEF6UjgxbG1qdnlx?=
 =?utf-8?B?QWtYSGZsYkk0NklqSk91T1JDc1VBL3dFeklCRFhiYXoxK2hnZEM3VktMREhv?=
 =?utf-8?B?YmxQdnFmY0xRTWNtNllKYzhMS3lKeGljdFg1R1gvcllnSlNFTmhHcmdRelA0?=
 =?utf-8?B?cW9vRisxT2RkZTVPbE11MnlJSC94STNKZmVJc3JUYnpOVktrTFJMVHZvMGdj?=
 =?utf-8?B?YTk3eVBJRlA4Sm5nbVlHUGpKOVFyaXMxNm9pM05iODIzb25xU2hMZWF5elZi?=
 =?utf-8?B?eWVOWlZjKzBzTEIwSFppVnloNlozTk80K0lQTi9zbHhKREhLTXQzVmwzY3lS?=
 =?utf-8?B?SHl5TEc3OTI5Qmw2OStLMWJFbjlKV3lPZ0tnUlh2b3RuMkJ3VHNQWkprWHZL?=
 =?utf-8?B?SGsvUmhRUFh1Z1ZMQkdhbTFCbDU5MVdkUWJibDU2c21rZGpibW1ZVFkza2pP?=
 =?utf-8?B?dURaOXhaRHU4K1V1Y09JeHA3Tks0UXE5VU1QbUFWVWM3UEJsTjdDYUg5d2xH?=
 =?utf-8?B?VXc1bEdweCtoZnJqTExxTFVIUkdkclFqaFlaWE5jRUZuM09iRitWNDc1NzhO?=
 =?utf-8?B?ckdqdmdRamxabGJIVEsxYW15dFhSY0kwTmxFWk5IZmZIb0NJTmN0R2xNSWJI?=
 =?utf-8?B?SVo0S3ZBLzBVc2ZzSW1ySThCQUN0V3hJeWl5Znl4cjZhSnRBUG1zM0s3N1dW?=
 =?utf-8?B?NXJZeFI1b1lwd0hDSWlyYXFaRDNTS1RxbGdvUndDYkhHMERmTmJ6S1dWNUF0?=
 =?utf-8?B?aFhrZlRTV25ZL3BkTHFwMW1BdmFhZ1BGeEtuYzNsRVU0aDh2Y1ArUWJoaHA2?=
 =?utf-8?B?TUFSeENGV0tiSmc0MGxydmhZdXBTbVZUaWJnSW5XUXl0cUNSNzFTNExRSHdL?=
 =?utf-8?B?TjlMSkZJVFcrSXN4N3VnQjBkck1yS3loQ3hOQ1VPT2pBV25ubDBTN1R2Z2di?=
 =?utf-8?B?S2NqbGQ4SWV1YWd0TjVSc1pMbFVHUWYzTGxMUHJTejAyd2FKejJwaUFtclNC?=
 =?utf-8?B?QmJLQ2RmNG1mNUxrdkVjbVBMTXNGZjVtdkladW1pdmhjRnJFejV2TkszR2RW?=
 =?utf-8?B?c3k4NFJ0SU1uNXB3UkNkcFpDOUd4SGtXSytOUi9xc1BKd1JjQjRiR0NHSVl3?=
 =?utf-8?B?Q2U5ZHhET2NWMHF1TTdOV3ZWeDZJc1Zjb1dBcHJxU29rS3RzV0pGNUxvL1hI?=
 =?utf-8?B?UnpaWGVScnlCcDdvVUI4a3BIKzhYdjlzNFY5QWUzejFkNEdvNnhGbDNDazlx?=
 =?utf-8?B?Ym5SWTAzSUMwckdNb1NIZlFYUDQ4RXY3aVJiU05SRVR1N3V5QnFJRlFlQmpq?=
 =?utf-8?B?cm1DUUV0NVZFT3VhMUxOTGlBaXBnNFh5ZlI1M3FlMDkxSDFFZy9BbjE0RVRH?=
 =?utf-8?B?TnA4cWdEVy9MckxSSWNIV3pUN0pLclBSTzh0OEFJSjVRZERGK1MxcU5rYmxD?=
 =?utf-8?B?SEJqaFNoeVdveEtSN1pJSnV0OUFidlF0clhCMm1MQkd3Q21VUkt1KzFYLy9Z?=
 =?utf-8?B?emxESGhOQXJSOWlKWFJwWXVySUkva1RJN0gxdkhYYXZWWmhkMUhLc3NBSCtF?=
 =?utf-8?B?bGU3NktFb2lFN2RJRVV1WW1UYzU3QWlCTjJlcVRoTitFZHpqMUlsNG1QbUhp?=
 =?utf-8?B?MEs4VjJmTUNTS0NTS2tTRmRZdnQrcU53YlNNN2Zua0U2TTQrQUI4NnpGYUZq?=
 =?utf-8?B?SWt6SENxbWVobTR3bnd1RDhXYlJ4YSs5MCtPd1ovR292eVhpSG9Ka0t5MGpz?=
 =?utf-8?B?TGtkejNXRDhibW50dVdFbmNYYVNsN1hGUkVmemhnc3A3L01mdTR6RFR1YWNv?=
 =?utf-8?B?NFFYUXlldklSM1BjS0xyS0ZuRjRaTktiUjFreDNOWW5DVmxndXh4elJnbmdF?=
 =?utf-8?B?ZWVjK0Y3eWg2M3dhc2Y1bU5yd05sL010b1I1WkVKZkx6UDMyc05iaUNGR0xN?=
 =?utf-8?B?ZDhzV2MzZnptQTF2YlNXTkFCY0QydE9DSzhSbUJ5SlZmdW4wR21vTDRxRnFB?=
 =?utf-8?B?Y1c2SFRyN0dOWnFVN202MGxyRHVhUkhQb2RZdUNHa1czWGFPd1JFYzN5eGk3?=
 =?utf-8?B?WXBTQWh6UXNzY3NveURBczF2UDZYUWZFczhwTzQ1RXR1ZG8xWWZVcnlnb3Vn?=
 =?utf-8?B?T1ZIeHJzak5LYWFEdnFnTkpsalY5VTlFM0tzbVhKbFlTRHJNeGVNQT09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: cb81b229-c20e-4f23-a5e2-08def2de5702
X-MS-Exchange-CrossTenant-AuthSource: LOZP265MB8551.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 10:43:09.1404 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nT6FSzbf05Ubx0QdJz1on0gDHqwgzpofdiZ9JVsdcvIiw0470juIitJy1TYYUdMaLK3qVCM4C727bckmuEfdIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LOAP265MB9175
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

On Wed Aug 5, 2026 at 6:44 AM BST, Eliot Courtney wrote:
> Add a helper to get a subregion of an IO view fallibly.
>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  rust/kernel/io.rs | 31 ++++++++++++++++++++++++++++++-
>  1 file changed, 30 insertions(+), 1 deletion(-)

Looks like the case where you need this don't actually require a `Region`
(dynamically sized type) but rather a fixed size window?

In that case the next version of
https://lore.kernel.org/rust-for-linux/20260721-typed_register-v1-0-452d72b=
60262@garyguo.net/
will contain what you need.

Best,
Gary

>
> diff --git a/rust/kernel/io.rs b/rust/kernel/io.rs
> index 95f46bb75f9e..85fbdcc50c8f 100644
> --- a/rust/kernel/io.rs
> +++ b/rust/kernel/io.rs
> @@ -6,7 +6,8 @@
> =20
>  use core::{
>      marker::PhantomData,
> -    mem::MaybeUninit, //
> +    mem::MaybeUninit,
> +    ops::Range, //
>  };
> =20
>  use crate::{
> @@ -80,6 +81,34 @@ pub fn ptr_try_from_raw_parts_mut(base: *mut u8, size:=
 usize) -> Result<*mut Sel
> =20
>          Ok(Self::ptr_from_raw_parts_mut(base, size))
>      }
> +
> +    /// Try to create a subregion of `io` at the given range.
> +    ///
> +    /// Runtime checks that `range` is within this region, is at least a=
s large as the given new
> +    /// minimum size `NEW_SIZE`, and that [`Region`]'s alignment require=
ments are satisfied.
> +    #[inline]
> +    pub fn try_subregion<'a, const NEW_SIZE: usize, IO>(
> +        io: IO,
> +        range: Range<usize>,
> +    ) -> Result<<IO::Backend as IoBackend>::View<'a, Region<NEW_SIZE>>>
> +    where
> +        IO: IoBase<'a, Target =3D Self>,
> +    {
> +        let view =3D io.as_view();
> +        let ptr =3D IO::Backend::as_ptr(view);
> +
> +        let size =3D KnownSize::size(ptr);
> +        if range.start > size || range.end > size {
> +            return Err(EINVAL);
> +        }
> +        let region =3D Region::ptr_try_from_raw_parts_mut(
> +            ptr.cast::<u8>().wrapping_add(range.start),
> +            range.len(),
> +        )?;
> +
> +        // SAFETY: We have checked bounds and alignment, so this is a va=
lid projection.
> +        Ok(unsafe { IO::Backend::project_view(view, region) })
> +    }
>  }
> =20
>  impl<const SIZE: usize> KnownSize for Region<SIZE> {


