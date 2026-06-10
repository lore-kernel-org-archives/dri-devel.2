Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6F0FCD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 03:52:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8B6510E6E1;
	Wed, 10 Jun 2026 03:52:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="cMwXYj54";
	dkim-atps=neutral
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012060.outbound.protection.outlook.com [52.101.53.60])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E5110E6DA;
 Wed, 10 Jun 2026 03:52:15 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ba4ACNyx0HT6um7hmYCbT7zQsJEVnES4Sb9xo8EdiDoS+lKcA6Op+vxxUdAywXO79yk1hcpaSDLF6NeirzeWxrj1KiGvLt6SUKMkYDUvU6X2hERRz1oE9UiSUInhxpG3/Fq/Z1XefQph2BdKaz1DbqcLOCqj4lNdIJJmzWbgHKj9josucTgnff+O1iJpGra6R/1P1xdeR/S2ut9rEEMuLV1/gqqSk7zn+IvmwLvLKs7dYP4iu6ZgR7cS3Roz/L0ENR396a6P3O2jXzbvXmooIL3lMhc2amImgc1Pzp53WoFpIwceRu1OL2OoP/eQ3u08CQYglBP0MRDXeR7F1OftOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zY2+pqLhi+sL6ETKjGFFrbCeN/pbwEdrnanC+r8cvB8=;
 b=UYJguHpi2YffLC7wwFawF+Iopu1BmfltDpmewgOHhMJXceCrg/q4J0oQZ54htJ9rjN4Hel48uiTrJU64RgooVQDrH1eVnYwPEAS7dLlZpODAYiKDAN+2oZYZNVpzuEh5+W9Dx2nFymIxewYLxeec/N4O0jv3B09VegLymmfSGnOnVxr1iaKvKThjLVbWuhB3fJ+6Xq7tiv5OkK8LCZ2xcMdg0ghKNwUZjLemj4hxAauCEUMwSOAkOFO1iqO+sicWXTeU9WCsfHM8Tt8lKnjmO3UkfBYqytN8bcDDBBKgyZfUArF8nSNqMQ2sTDXwoSmehVRAB1FcBWUV4wkL0HJUxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zY2+pqLhi+sL6ETKjGFFrbCeN/pbwEdrnanC+r8cvB8=;
 b=cMwXYj54AI/c+jAXM6Mjf6uSICYEkvDwoYOv9EaW10Rn3Owi4EMmYZ3lFuVc4e02mrXWViMn7s4CGxfzfzqKw4g8I1e+gQqFZlEusgOeA4+nLHAqUy83p2/8npkn/+N5xyI2wI7b1sWeWhzFVzLUhCQh8pNs+gVzojm4RCCvoNKSdBbxem6cNtHe0cJX9elTuCFZNj/X9+N+Z2931fhCr5CKzYMAeC3jyiM1ffnrHFFVZTUO43CTV1Eg9ZLZxfFsaPMVH65gQ4G0iiG5Yi04C60q9DTUH0a+8xKsuWK8rly+B30js68yGrKChjsjLPVUtqvZAi6rPiz7hCMZ7sZ6Dg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN1PR12MB2368.namprd12.prod.outlook.com (2603:10b6:802:32::23)
 by DS0PR12MB6557.namprd12.prod.outlook.com (2603:10b6:8:d3::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.14; Wed, 10 Jun 2026 03:52:09 +0000
Received: from SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42]) by SN1PR12MB2368.namprd12.prod.outlook.com
 ([fe80::281e:52ee:b18e:ad42%7]) with mapi id 15.21.0113.011; Wed, 10 Jun 2026
 03:52:09 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 10 Jun 2026 12:52:06 +0900
Message-Id: <DJ52BSFTRYBX.2ZR8NX8A5H4ML@nvidia.com>
To: "Alexandre Courbot" <acourbot@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alice Ryhl" <aliceryhl@google.com>, "David Airlie"
 <airlied@gmail.com>, "Simona Vetter" <simona@ffwll.ch>, "Benno Lossin"
 <lossin@kernel.org>, "Gary Guo" <gary@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>,
 "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
Subject: Re: [PATCH 1/4] gpu: nova-core: move GSP unload state to a pinned
 Gpu subobject
From: "Eliot Courtney" <ecourtney@nvidia.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260609-boot-vram-v1-0-d9382610507a@nvidia.com>
 <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
In-Reply-To: <20260609-boot-vram-v1-1-d9382610507a@nvidia.com>
X-ClientProxiedBy: TY6P301CA0038.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3ba::14) To SN1PR12MB2368.namprd12.prod.outlook.com
 (2603:10b6:802:32::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PR12MB2368:EE_|DS0PR12MB6557:EE_
X-MS-Office365-Filtering-Correlation-Id: c71126d1-68d8-4956-78de-08dec6a3a592
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|366016|7416014|376014|1800799024|11063799006|56012099006|4143699003|6133799003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: nL543erPxggRHG2r0xOiZ53lZyIrSt7hti1MGhHnegzMht7y8A0VZo2sUktOqk71AKXZ97n5R0Lm7v96793M2C/NW9jQBTt9W6ViRe23/hNG/uZLZCh2DRMjlPk9cId3/Y3pHaBI8kaLegGNuGKz6xCTmzuOJPf60BmHLXiTYsBQ0YpWg2aiqR2GhS8oWW7RAJbtDWvFz8QMfqiLiKENo4vYPTceGgKSo3Eajy33RZFZ9baxBXFJP7DrzAh8yrasSUNJI/wI91uSs9UnvOzB4vtze8dHaPSYok9D8UD13iSSGOCErLR/EUnslGeFqCa0Yxzdusb5xWkHZ0ZfEqVn3uw9IohTn/V327aIbgwGeZ+t/gOgFlSKCkc0HG7zw6GI+fDFH4HkgCYs+9zXU89FdjL1nv5YHNGfHeNI8rRQfrH/kPICpvtsmYv3Jg3prVq3XjWBy6XxRMIWdIYzzt6u90CSm/VsEHRXh/2FNeRLGZzC7Qy6mkbKBm8NKW5/+Y7tML/ApA8peJTjyKzWEltxShJKxMM+o3S7pVcMf3xwpEV9KWaUF1WYLPbxiwPa1uFzYXQwmqyhbtBDGn9vLAUKq5ZTvsEnbhR8O209E2VCsnHOxB5E9G9QGiRzaQBgN3qbO4HJ6xcpx6iiQT+cinEH36BVcr5t1GQTOTSKr9AwAFQzgLfWul4d8T5Zg16m/txB
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SN1PR12MB2368.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(366016)(7416014)(376014)(1800799024)(11063799006)(56012099006)(4143699003)(6133799003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?b01ZcTdRTVpjYXgrZjQ3MWZ2cmN6TmpYWm9rRXZHQUFJbUs1ZEFiOUQxaG5P?=
 =?utf-8?B?SC9xaXBsN1krMDlqNnp0OUpxRUVkb21leCtNQjJiT2xIYUlOZlVrMWZIQW5B?=
 =?utf-8?B?cmhyVVlJY29KdTFwdmN3K3hwNkJiTG0zdkEzOXRFT3IxdGRLR05hT0JSdVNl?=
 =?utf-8?B?OU5LamR2MkFBQ3FadDRWUGxjRlExaHhaY1FyVVUzdDdDUTU1enIwSGxtL2VL?=
 =?utf-8?B?dDFEZjMrUmdNdXJXOEtNM0p3MXh3OEE5Wm56T050ME8rYTlFaHYySk5URC9s?=
 =?utf-8?B?OHpaRW5ENklhYkRDUDk1OTRvM3NuWHllSnNVYjlMa2tnVVNoWnpBSXB6Mk1C?=
 =?utf-8?B?N3JkOGJkUzBzVENHSGhZR0lsNHJsK2VnTkJ5Q1NKa2ZrSENyUEcyeG14UnNj?=
 =?utf-8?B?WCtDcytpdDZkeUhRdnJUN0UzWWdycGxjUVJkK29ZeXkyUytMUzRaREw4RUFX?=
 =?utf-8?B?TXBhTittQmIweDNTWnhWNnZ0clhGVTA3anpnUHI0a2gyUitMZkNuMkZNejRL?=
 =?utf-8?B?bzR0Nmpha0tlMHg2d0U0QVhoM1dMMmZwbVBHUlUwcWtpSWZ5R2M4aGJ5Ry81?=
 =?utf-8?B?MlFGWnVSSFlkY3VITHpoenZPcnE1ajRhSDZHRDVjK1lWUEdQSXpqZGsyUnNT?=
 =?utf-8?B?WW5EN05nTWlhL3pheXZGM3BFM1dyd0hjMUg0T096cWs1eGRGWTgyNFM5SHE0?=
 =?utf-8?B?Sk9RWmZLK3R3T2czb1hxSzJmYjh0OGlLTnBRT0FSWFZSb1V1cjd0V0pJVzdn?=
 =?utf-8?B?RW5FZ1ZNV2dySW9RcmRJcTZ3NURaU0pnL0FkZWlsNXlwUHdjYmhQUTdBSVlG?=
 =?utf-8?B?aThNYi9BUTBVQWdWaVh0WjlPR2J1K3NrRVV5U2wvd3U2TG1GWHpGYVlDdVRI?=
 =?utf-8?B?d1dmRWpndENrbWZZVzRQcUhGWXFiR29kb0tKU1cyZGZMd1ZXZ3BWSGdqUWdE?=
 =?utf-8?B?SGZxL2RPV1ZENyswemErSm5VVytTaEFJNjJ0SGZzbmgrblpFdmxqVjlCMFRM?=
 =?utf-8?B?L1hGbEZrRzZ0RFZ4WFdjZjJXcmNQU2E1T3VBREo4TGNpWFF5KzhVWGJLWWQx?=
 =?utf-8?B?NHZ2SXNBQnFuUm1OVzU0dncrZWFqYStrODA2aHpoSGpRQ0tiOEZORlREd3dn?=
 =?utf-8?B?V0dvZjI5VDhNU3FmRXFPM1BWbnN1Rnp6UGdrQjhNMi9wZU04TG81bXpReWRQ?=
 =?utf-8?B?bGxVM1ZGeGJEak5UZk4xTnZOMU1hcGRjWUtYK1lHMmZKUFhXU1Q5SElScmhG?=
 =?utf-8?B?TFN1ZzBrblI1MndMTXkxOUs0dFBEUXllWThxRmFrMzZKeXUydkh2cW13TGJR?=
 =?utf-8?B?MXBrcWtpcWgzcm1tS0hkVVFHK1dYUk42dGs5OGt0Umg4VzhPaFpqdjFZbk9B?=
 =?utf-8?B?UzlNWlppQXgxd05IYTQxUGxrQlV3RHYyclJBQVZBVG1GTXJDQmZlVnN6UFBI?=
 =?utf-8?B?SUdzZUNIaURUNm9oK0o2RmhueU9ndFFkSVRyeFJNY212djMyRk5kSjRvQk1W?=
 =?utf-8?B?MFhqNEtubXJ1TWRhSTV1V2gxK0YrRXF2OTJMMXVSSDRIYVB3TGRhbmIyVEV5?=
 =?utf-8?B?UnZJcUZzMjN0ZVlKTlhmQUJaZmhiRk1TZjc0a2ZiV0o1aEdVR3lFSVI0RHBE?=
 =?utf-8?B?UGF3WU5iU0tiVFFoeHcwQlpZVEdIRGQ3Z0ZqTU1WU0d5STg2aEtLNE8wNVRm?=
 =?utf-8?B?RlhsNVNpM2dqMGYvSHA3ZFIvdFl1K2gyeDE4YWptQjNORXJPR0pvQWcvVWJO?=
 =?utf-8?B?VUtkRVZvam8wK2ZsNkV4YWNjdHR4MVhBQWFtbWdhbWNzY3pGbDBrbzRvRE91?=
 =?utf-8?B?ZkgxQUlPQ3l0Vi80Q29XNHZZUXBsNTNoc3c2cmFwVkpiZW1GVWJlZHdPQWpS?=
 =?utf-8?B?ZTlOb0dpRFdLb3FqWS9LM2FrRVN5M3NOaHVTYk1hbjB0STA3WExTTW5TbnU1?=
 =?utf-8?B?a0pvZVR4UmJEcjJHUmRMUzlDTE9pMWN4Y0dyY0dvVlhrdXJ4OTVnMTlCL0Rl?=
 =?utf-8?B?NnJsL0N0bWRHVCtRUHByeXNLL0tpNkh3RXRYTFJlaVhHNmdpZzU5a0xWcXFC?=
 =?utf-8?B?QTFIalhXL20vUWVTQmZEbllYRm5GWHVSRi9KMWFUcFBVQ2FQVHRVNTY3bEZJ?=
 =?utf-8?B?VnRCRmpvckEyeWV5YmR2WTB0b0ZWMlJtYVpSNWhvL0k5Z2JXZjB0MVZxN2dn?=
 =?utf-8?B?b2t0WlMyeXVscWxmdWhZNkh4UlkrbWEwdTNUMmNNenhyV09DL25YQmhVRmtH?=
 =?utf-8?B?QzE3YzJVamtYeXN2cDRvU0p2VjNablduVGIydi8vQkY1N2c5Mmc1Qm81Nnhm?=
 =?utf-8?B?Y3RQQlBXYUptb3B3V0pvMkQ2K1V5L0FYZ0taaVZRd3Nsd2FUYStNS1dCZ3pQ?=
 =?utf-8?Q?uGJQyoruexJkb41MoobGDLgCT2g9hnLM9ewgWzLPhCFfA?=
X-MS-Exchange-AntiSpam-MessageData-1: BcRCTTZfwZhjcA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c71126d1-68d8-4956-78de-08dec6a3a592
X-MS-Exchange-CrossTenant-AuthSource: SN1PR12MB2368.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 03:52:09.7411 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: EgwPV42ZMpGTiclTZuA1ilVq9C+p1+p1F+tzVr91dRdYxqrYXQ2Em9OeGmcWjgLAj7Xqixqq80vc3rhrvDaZyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6557
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

On Tue Jun 9, 2026 at 5:03 PM JST, Alexandre Courbot wrote:
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

This means sysmem_flush is dropped before unload is run. Before this
patch, PinnedDrop runs the unload bundle before sysmem_flush's drop
actually runs. But with this code it'll drop sysmem_flush first, and
that isn't allowed according to the comment in fb.rs saying that it's
needed for falcon reset. What about sysmem flush into GspResources as
well?=20

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

