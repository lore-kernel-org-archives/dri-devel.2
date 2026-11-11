Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43C2C606A31C
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=garyguo.net header.i=@garyguo.net header.a=rsa-sha256 header.s=selector1 header.b=mOIrxnoW
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98C2A10E276;
	Wed, 11 Nov 2026 08:49:47 +0000 (UTC)
Received: from CWXP265CU010.outbound.protection.outlook.com
 (mail-ukwestazon11022075.outbound.protection.outlook.com [52.101.101.75])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F55B10E276
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 08:49:40 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X6BXxkTletct+SQ9exl9JrbQq/98MWDS0V3d+OEbneIRp4pOgIoInBaE9RJ1OGwFNXly5V+OJpcUBnz8s3ncwliBb/f7MuD0vVWTDp02Fb7cEZPatGRo+R3oFLOFfL9/riolJ49T0EuOzq0iPhKuIPdF7rLEDZ+Qq7OVX6xa1P/fWdkhtw5t1IiZzu5faahCQBaghD65DNvRf4hs8CqWZXDaBaVtrvirsQc2taC+M87gFRLc0FNdFIo9PXufIYAv2baG20iUBsqHtzi6SHNAr/9cajACrdN9i6FQ033E+xM4n0oZtfxlgI6+eqAc9RiTuxpXTElc/Bh/bxIDUfCvow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tt3Gy0Gp+SEYq5BNaddIUYYKIoWBeacf+f280L4dEwA=;
 b=rCkb3fN0r2haq+ApSHQmYYA6Oeu6INxT98yxC9AcpITBdxiQZoyYeKwYA4dqHtaj/rlBtJ9btSdJkb4EzeImC+JvQahaQSGrGA4xM3Mx+LaRDhruUOUhP7wWqHQ3aclYMIsywjQa/BcMuTumyu9dTmvZ1YWnl0rfSVZU6XUMyLVIWcAsgTOUXDghJgZMA2s/2FiXS/0vH7GkafTKtmXwvFJQe9J6tiAczngE7F8zDvk0yz2KAZ3NixXXp4cy/Xezh3++2igiYdlE+vpxrSaZ0YEdL/FffDzR/9RPeo/9ucf6eLLB+iiKVW/ZZIeH5qoRvv8wGwYVLLi8Z7I0KbXoFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tt3Gy0Gp+SEYq5BNaddIUYYKIoWBeacf+f280L4dEwA=;
 b=mOIrxnoWym1CO3EuDdslks+VHVnMTZH/dj6ACBVioblAfkPZsWQX1ey6macrUzxd2SpveSb1oRDEOnQcVFUMt+q7ZvqPNt3kI9WsBIWHio+bVa+Nt/0q5UT3JMtcrI0nUnhc96b6R1sIJ8ppbMZlbAYphBTuizecD0k2q39mO0U=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:1cb::9)
 by CW1P265MB7868.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:203::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 08:49:36 +0000
Received: from CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3]) by CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 ([fe80::55f6:f98b:7fad:c6e3%2]) with mapi id 15.21.0615.008; Wed, 11 Nov 2026
 08:49:35 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 11 Nov 2026 08:49:34 +0000
Message-Id: <DMS93G8MYB71.3HF96QRH1AUN@garyguo.net>
Cc: <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <rust-for-linux@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] gpu: nova-core: use pin-init self-referential support
From: "Gary Guo" <gary@garyguo.net>
To: "Danilo Krummrich" <dakr@kernel.org>, <acourbot@nvidia.com>,
 <aliceryhl@google.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <lossin@kernel.org>, <gary@garyguo.net>
X-Mailer: aerc 0.22.0
References: <20261110152746.140351-1-dakr@kernel.org>
In-Reply-To: <20261110152746.140351-1-dakr@kernel.org>
X-ClientProxiedBy: LO4P123CA0553.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::7) To CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:400:1cb::9)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CWLP265MB6051:EE_|CW1P265MB7868:EE_
X-MS-Office365-Filtering-Correlation-Id: 29fbbcd6-ef6a-4808-de6d-08df3fd0b64e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|10070799003|18002099003|11062099010|22082099003|6133799003|10067099003|7136999003|56012099006|261028144727099003|261009223027099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261022075727099003|261021123027099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: QtRSqN1fUFr/5dS0MDJSBLg/tOsg0X7HhbTiDEY57Gt2ujK2RWSJsttoNhpPxqibj3JFmaGZuyG2KXs1JX6UAqaOAvM4Zu8JjT6vNp1i68+q8OtbFgj29qPEPKPXpRwBZh09dCK7uegMhF0Vf9zOvEGGdMNn3WYOUwd/KB/HlIiFZzktOgWQb2YRasU0FxSkuwX9hfbsOKF0lBMniHkRN3gmGhpsZju4cCE6xO/LFJUFeYWPqu5cRkH3j3wYuvJHQtdCn3UtzPI89D2MxUJJ3WX9lmdTw9qtlhtuS0PWxmXYhcOsV32Zbj1bmqAmvn/6dTR1dYdcbsYLSL71lL/b8oc03PlCf6NvGtAsUl94hIXhSP36ftJIVdFSThz4QuDJTWzN3RIOG+QFAurqeuA+ByVua5xNhmUjzvW7p1gF2RLEUnDKMNeW8j/6Uqi0OcncHqiAJoPvwFKgZDGRiRj5UyqIk5SJ3bWJS6HdO8U5GNBZTxaSGG3iRmhbqWL16P1UtFLc2Daiqa4hC8CHJ3jPfVwIEJdyrGoQUN6nCl2GYtks/ZedDaZQQixbKK6V55H4qjIo2yZOXaS78LDBtmnWjHkoYcji9HIj6u6AXQ+2TzI0lMhIQr4F82IrbhUdcV/f
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(10070799003)(18002099003)(11062099010)(22082099003)(6133799003)(10067099003)(7136999003)(56012099006)(261028144727099003)(261009223027099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261022075727099003)(261021123027099003)(261026121527099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UlpXQm52TVJ3V1piNjQwck5nMU9tOGh3bmxSMFRRQXd6Znd0WDB6OVFFdDVz?=
 =?utf-8?B?QVg3Z2hGTVQ3TG9qbDRVRXd6SW1PTEkzbmdMbFlwMnJ0clBEQ0diaW8zSUJv?=
 =?utf-8?B?SkZxeEVFUy9jdWNZdXdSbXFMeENiTldlb1NDUTd2UEhOdlB2bDJhNE1kV0VI?=
 =?utf-8?B?NVYveU9KMWR2Qnlsb1ZKQ0RuZUE1UEt6S0Z3SnhvY0ZVVlFFL2xKSnFZRElL?=
 =?utf-8?B?TlJBTXlDMVFmaVNXZXU0VHVOellhZVlpeG5wTDNVejN1aFVHLzlwYWZ3RU1u?=
 =?utf-8?B?anE1QXc1a2FKZHVtajFrL05laTJkMEpaVzJqcmFWSUNWZEt3YlZhNnk3aHJW?=
 =?utf-8?B?Z2pIWmFuQ1JrNVlTVi93WExaNG93eGR0aXJlck93NkVUSWo5V1A5S25maGZq?=
 =?utf-8?B?QWFRVlk0dmpUejZ2RWZqdXBkdGVySkk2M1ljYjJYVDdiRmN4eWFiYWFNcHlh?=
 =?utf-8?B?aHJ3dnVzWXpNM2ZIT3NDZWNPNUVuZ2dIV2dTek44T2dJTDZUVWRBRFRrZHFw?=
 =?utf-8?B?VzhXc3BxYlZlNFFIazJLdHhwaHlQMHJ1WnNhZ04wUWZwMDRXVi9XWTY2U1dL?=
 =?utf-8?B?cWpXMHBLa0VmTG9GMVdiZGJoSHR3QzlQMHR2cXQ5enYxSitZcUxjM2kwOFd4?=
 =?utf-8?B?T3J5aTRzd2RtNldoNU5vUnBMV0JFUzBzWm9lM0RHTk84U2lDQkdaeVBNaWZj?=
 =?utf-8?B?YW5JTVpBUEJaRjdYWi85Y2pxSzBqbTExU3dFay9zSkZDeHFCaVBodmFrUWEr?=
 =?utf-8?B?dEJxMTRCeHh1UVB0L3U5QmpkRVRGRno3VEtBeUN1a0tkZUxqNktmS2c3ZXhM?=
 =?utf-8?B?TVo0SEZWcE1QWlNjMGhYOFh2Y0tXMy9YdytDOWtXdFZIaWlXNkNxdGY0TFlD?=
 =?utf-8?B?V1hod2JhWjNSdFhTOWEvZkh1ZEJvQTNhMUxxYmU1c1pBcGwycUhrNzdOa0Nv?=
 =?utf-8?B?dFB0bkdkcEFLenJDV2ZPaldrcnpCVWVJcDBtVUU2SmNQa0tJMy9QQVBtZ3Yy?=
 =?utf-8?B?cTRzOGpQTHZzTWRHNDVKVWdJbTA5b1lrSG8xMHcxSTh4RkkvamplQkdiVWpp?=
 =?utf-8?B?aDRLSnNlR2NvNFVrT09VM3NMQ0VrS2loQzlXdUlhbGdQOEJaS1J2ZFAvVkdK?=
 =?utf-8?B?SHBzSVVxemd0aGlUeUc0aUVtSXlRSVVvRk04Vm1yaU9Hb21Pb0VadHhqSEhT?=
 =?utf-8?B?V3FOMGluTEJvK3E1QzVIVXQyYzZVb1pvcGV4QVdTVGNyUUVESkNVOWI4NnZq?=
 =?utf-8?B?Vi9lRjNvNXp2RS9kQnViTjM0Yk1nbng1YjNSTVFzSmkrWjcwblI0Y01XMGQ4?=
 =?utf-8?B?Q1cwaTJmWDVTMUh4VkQ3Z0w0cDltNDhlMzRoRWJ6bHdpY0JucU9BYmRuckk5?=
 =?utf-8?B?S2RRdEhaWUM4bjZubWJocXRIamp2UllYbnFEeHlxQWJLeVY3MW9jVmxCYk9l?=
 =?utf-8?B?TDhEZEZKaiszZ1RRUjFBOU1yakJDeEFqWDdnNWZ5c2ZWSWZyRnlUR01QTlVP?=
 =?utf-8?B?c3J6WGZwV0JwMDRSNWRoR2tMdGVlWFRuT0tHS3FXcEZQa2gvOGRWRldZYS8r?=
 =?utf-8?B?OWZJRWtzVi9sVDZJMDhvKzlJeGF0Q21qNjdiRzU4MmswdXc1RHJ0MS9MZm8r?=
 =?utf-8?B?aWNkU3NMeGdybERxMk5ZeWJuTjhVQ05ZVSs0T1kzYU02NldCMWVSbFpTWWNk?=
 =?utf-8?B?M2xiamNRTnhlNFR1UmZtV293dHd4NERxMU16Q1R6RHZPazRuRURoRnBqcVM2?=
 =?utf-8?B?M1ZhVXQ1WVBrdngwbElPd2xkTCs5MnFWRWxBaDQ0SFpRbjlCTGUrRkhtY1ZO?=
 =?utf-8?B?Vm5ZZlFoWkt6cXZ4MVFYN0VBa1hqZTJmdlcvUlA3RnpCRzlpVHVjV2F6SnA1?=
 =?utf-8?B?UTJuMGdCK25KMTVGQkdoK213Q3h6c3FHTytNRTAxY09Idlp2MWszQ1lROWd2?=
 =?utf-8?B?ek4vTjFuUlp4eGN5d1FoaWFpZDVSbTMwVGZQTXJUNGtmSXFuYTBta21mbGZV?=
 =?utf-8?B?cThaTURFd2Z0ZUV1bDVFb1NUT1FibHUxN0lWV0NpdjZoS2VUTGFWbmk5b0l3?=
 =?utf-8?B?NzdROUFsK29KUTE0Wm1lWU0xMlFXOVhiSk81WG5Oa2hGb1AyMnlaeHp5QlU1?=
 =?utf-8?B?a05jVjhTM1NOY3pWRHVrcFJOQzVsaVhYTmVYOVhIaWdGWjVwemJ3aFhTRHVL?=
 =?utf-8?B?NTlrcHo3M1ZNZ29uMjdHcmdHUEZ1SnNNUUIxamdaNmdQTThyWGhCTGZma2lo?=
 =?utf-8?B?aFdhMDJ0RzFNZTNlc3dyUHp3WGFhWm00N1BkUGNWVDl6WFkwQVFYSm1kNFIv?=
 =?utf-8?B?NTBDTDVZdnVSRmc5bmsrRnRCN0JDSTQyNmdUbzBaaXlZeFEyL2MwZz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 29fbbcd6-ef6a-4808-de6d-08df3fd0b64e
X-MS-Exchange-CrossTenant-AuthSource: CWLP265MB6051.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 08:49:35.6076 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xfDMKgYrTXsE6WUDKiiKNo7sRw3KNRGWs/JBCPuUrpXbiRYa7+XH0Fh++b9uR+Yh46izBvPuRHefIHwNitCXuw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CW1P265MB7868
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

On Tue Nov 10, 2026 at 3:27 PM GMT, Danilo Krummrich wrote:
> Express all self-referential borrows through pin-init's self-referential
> support [1], replacing unsafely derived references.
>
> Cc: Gary Guo <gary@garyguo.net>
> Link: https://lore.kernel.org/all/20261008-dev-selfref-v2-0-e280b3c8fba5@=
garyguo.net/ [1]
> Signed-off-by: Danilo Krummrich <dakr@kernel.org>

There is already
https://lore.kernel.org/nova-gpu/20261019133647.1279779-1-gary@kernel.org/

It doesn't include GspSubtree though, I suppose that is relatively new?

Best,
Gary

> ---
>  drivers/gpu/nova-core/api.rs     | 24 ++++++++++++---
>  drivers/gpu/nova-core/driver.rs  | 53 +++++++++++---------------------
>  drivers/gpu/nova-core/gpu.rs     | 32 ++++++++-----------
>  drivers/gpu/nova-core/irq/gsp.rs | 17 +++++-----
>  4 files changed, 59 insertions(+), 67 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/api.rs b/drivers/gpu/nova-core/api.rs
> index eec69aace3b2..94808af3886d 100644
> --- a/drivers/gpu/nova-core/api.rs
> +++ b/drivers/gpu/nova-core/api.rs
> @@ -22,11 +22,27 @@
>  };
> =20
>  /// API handle for the auxiliary bus child drivers to interact with nova=
-core.
> -pub struct NovaCoreApi<'bound> {
> -    pub(crate) gpu: Pin<&'bound Gpu<'bound>>,
> +#[pin_data]
> +pub struct NovaCoreApi<'bound>
> +where
> +    // `Gpu` is invariant in its resource lifetime, which outlives this =
API borrow.
> +    exists<'gpu_resources>: 'bound,
> +{
> +    #[uses('gpu_resources: invariant)]
> +    gpu: Pin<&'bound Gpu<'gpu_resources>>,
>      pub(crate) pdev: &'bound pci::Device<Bound>,
>  }
> =20
> +impl<'bound> NovaCoreApi<'bound> {
> +    /// Creates an API handle.
> +    pub(crate) fn new<'gpu: 'bound>(
> +        pdev: &'bound pci::Device<Bound>,
> +        gpu: Pin<&'bound Gpu<'gpu>>,
> +    ) -> impl PinInit<Self> + use<'bound, 'gpu> {
> +        pin_init!(Self { gpu, pdev })
> +    }
> +}
> +
>  impl NovaCoreApi<'_> {
>      /// Obtain a [`NovaCoreApi`] handle from an auxiliary device registe=
red
>      /// by nova-core.
> @@ -36,12 +52,12 @@ pub fn of(adev: &auxiliary::Device<Bound>) -> Result<=
NovaCoreApiHandle<'_>> {
> =20
>      /// Returns the GPU [`GetGspStaticInfoReply`].
>      pub fn gsp_static_info(&self) -> &GetGspStaticInfoReply {
> -        &self.gpu.gsp_static_info
> +        self.with_gpu(|gpu| &gpu.gsp_static_info)
>      }
> =20
>      /// Returns the GPU [`Spec`].
>      pub fn spec(&self) -> &Spec {
> -        &self.gpu.spec
> +        self.with_gpu(|gpu| &gpu.spec)
>      }
> =20
>      /// Returns the size of the PCIe BAR used for accessing VRAM, typica=
lly
> diff --git a/drivers/gpu/nova-core/driver.rs b/drivers/gpu/nova-core/driv=
er.rs
> index 560a70c4f5a7..ac5a9d9f8331 100644
> --- a/drivers/gpu/nova-core/driver.rs
> +++ b/drivers/gpu/nova-core/driver.rs
> @@ -33,9 +33,11 @@
>  #[pin_data]
>  pub(crate) struct NovaCore<'bound> {
>      #[allow(clippy::type_complexity)]
> -    _reg: auxiliary::Registration<'bound, ForLt!(NovaCoreApi<'_>)>,
> +    #[uses('gpu: invariant)]
> +    _reg: auxiliary::Registration<'gpu, ForLt!(NovaCoreApi<'_>)>,
>      #[pin]
> -    pub(crate) gpu: Gpu<'bound>,
> +    #[uses('bar: invariant, 'bar1)]
> +    pub(crate) gpu: Gpu<'bar>,
>      bar: pci::Bar<'bound, BAR0_SIZE>,
>      bar1: pci::Bar<'bound>,
>  }
> @@ -129,44 +131,25 @@ fn probe<'bound>(
>                  crate::irq::doorbell_test::run_selftest(pdev, bar, spec.=
chipset)?;
>              },
> =20
> -            // TODO: Use self-referential pin-init syntax once available=
.
> -            gpu <- Gpu::new(
> -                pdev,
> -                // SAFETY: `bar` is initialized above, pinned, and outli=
ves `gpu`.
> -                unsafe { &*core::ptr::from_ref(bar) },
> -                // SAFETY: `bar1` is initialized above, pinned, and outl=
ives `gpu`.
> -                unsafe { &*core::ptr::from_ref(bar1) },
> -            ).pin_chain(|_gpu| {
> +            gpu <- Gpu::new(pdev, bar, bar1).pin_chain(|_gpu| {
>                  #[cfg(CONFIG_NOVA_CORE_SELFTESTS)]
>                  _gpu.run_selftests(pdev);
>                  Ok(())
>              }),
> =20
> -            _reg: {
> -                // TODO: Use `&gpu` self-referential pin-init syntax onc=
e available.
> -                //
> -                // SAFETY: `gpu` is initialized before this expression i=
s evaluated
> -                // (`try_pin_init!()` initializes fields in initializer =
order), lives at
> -                // a pinned stable address, and is dropped after `_reg` =
(struct field
> -                // drop order).
> -                let gpu =3D unsafe {
> -                    Pin::new_unchecked(&*core::ptr::from_ref(gpu.as_ref(=
).get_ref()))
> -                };
> -
> -                // SAFETY: `NovaCore` is dropped when the device is unbo=
und;
> -                // i.e. `mem::forget()` is never called on it.
> -                unsafe {
> -                    auxiliary::Registration::new_with_lt(
> -                        pdev.as_ref(),
> -                        c"nova-drm",
> -                        // TODO[XARR]: Use XArray or perhaps IDA for pro=
per ID
> -                        // allocation/recycling. For now, use a simple a=
tomic counter that
> -                        // never recycles IDs.
> -                        AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> -                        crate::MODULE_NAME,
> -                        NovaCoreApi { gpu, pdev },
> -                    )?
> -                }
> +            // SAFETY: `NovaCore` is dropped when the device is unbound;=
 i.e. `mem::forget()` is
> +            // never called on it.
> +            _reg: unsafe {
> +                auxiliary::Registration::new_with_lt(
> +                    pdev.as_ref(),
> +                    c"nova-drm",
> +                    // TODO[XARR]: Use XArray or perhaps IDA for proper =
ID
> +                    // allocation/recycling. For now, use a simple atomi=
c counter that
> +                    // never recycles IDs.
> +                    AUXILIARY_ID_COUNTER.fetch_add(1, Relaxed),
> +                    crate::MODULE_NAME,
> +                    NovaCoreApi::new(pdev, gpu),
> +                )?
>              },
>          })
>      }
> diff --git a/drivers/gpu/nova-core/gpu.rs b/drivers/gpu/nova-core/gpu.rs
> index d185e927233f..cbd720a4d11f 100644
> --- a/drivers/gpu/nova-core/gpu.rs
> +++ b/drivers/gpu/nova-core/gpu.rs
> @@ -342,15 +342,15 @@ struct GspResources<'gpu> {
>  /// The two drop as a unit, the handler first, on the drop of [`Gpu`] an=
d on the error path of
>  /// its constructor alike, so that the subtree is disabled only after th=
e handler is freed.
>  #[pin_data]
> -struct GspSubtree<'a> {
> +struct GspSubtree<'a, 'gpu> {
>      #[pin]
> -    irq: GspIrq<'a>,
> +    irq: GspIrq<'a, 'gpu>,
>      /// Must be kept declared *after* `irq`. A handler still in flight e=
nables the subtree again
>      /// through its rearm.
>      _top: TopEnableGuard<'a>,
>  }
> =20
> -impl<'a> GspSubtree<'a> {
> +impl<'a, 'gpu: 'a> GspSubtree<'a, 'gpu> {
>      /// Returns an initializer that registers the GSP event handler and =
then enables its subtree at
>      /// `TOP`.
>      ///
> @@ -362,7 +362,7 @@ unsafe fn new(
>          pdev: &'a pci::Device<device::Bound>,
>          tree: &'a Tree<'a>,
>          falcon: &'a Falcon<'a, GspFalcon>,
> -        cmdq: &'a Cmdq<'a>,
> +        cmdq: &'a Cmdq<'gpu>,
>      ) -> impl PinInit<Self, Error> + 'a {
>          try_pin_init!(Self {
>              // SAFETY: this function's caller must not leak the `GspSubt=
ree` that owns this
> @@ -383,7 +383,8 @@ pub(crate) struct Gpu<'gpu> {
>      /// any in-flight run of it has finished, before the command queue t=
hat it drains and the
>      /// falcon that it reads are freed, and before the GSP is unloaded.
>      #[pin]
> -    _gsp_subtree: GspSubtree<'gpu>,
> +    #[uses('tree)]
> +    _gsp_subtree: GspSubtree<'gsp_resources, 'gpu>,
>      /// Static GPU information as provided by the GSP.
>      pub(crate) gsp_static_info: GetGspStaticInfoReply,
>      /// GPU memory manager owning memory management resources.
> @@ -403,9 +404,6 @@ pub(crate) struct Gpu<'gpu> {
>      /// Must be kept declared *after* `gsp_resources`, as the latter's `=
PinnedDrop` implementation
>      /// requires the sysmem flush page to be in place.
>      sysmem_flush: SysmemFlush<'gpu>,
> -    /// Borrow of `tree` that `_gsp_subtree` holds. A field that borrows=
 a sibling field is
> -    /// self-referential, which `pin_init` cannot express, so the borrow=
 is taken by hand.
> -    tree_ref: &'gpu Tree<'gpu>,
>      /// The GIN CPU interrupt tree and the PCI vectors that deliver it.
>      ///
>      /// Must be kept declared *after* `_gsp_subtree`, which holds a borr=
ow of it.
> @@ -456,10 +454,6 @@ pub(crate) fn new<'a>(
> =20
>              tree: Tree::new(pdev, bar, spec.chipset, irq::gsp::GSP_SUBTR=
EE.into())?,
> =20
> -            // SAFETY: `tree` is initialized above, is pinned at a stabl=
e address, and is dropped
> -            // after every field that uses `tree_ref` (struct field drop=
 order).
> -            tree_ref: unsafe { &*core::ptr::from_ref(tree.as_ref().get_r=
ef()) },
> -
>              _: {
>                  let dma_mask =3D hal::gpu_hal(spec.chipset).dma_mask();
> =20
> @@ -513,19 +507,17 @@ pub(crate) fn new<'a>(
>              }),
> =20
>              _: {
> -                irq::gsp::quiesce(tree_ref, &gsp_resources.gsp_falcon);
> +                irq::gsp::quiesce(tree.get_ref(), &gsp_resources.gsp_fal=
con);
>              },
> =20
> -            // SAFETY: the GSP falcon and the command queue are fields o=
f `gsp_resources`, which
> -            // is initialized above and pinned, so both references outli=
ve the registration. The
> -            // registration is a field of `Gpu` and is never leaked, so =
its `Drop` runs, and field
> -            // drop order runs it before either is freed.
> +            // SAFETY: The registration is owned by `Gpu`, which is drop=
ped when the device is
> +            // unbound, so the registration's `Drop` runs.
>              _gsp_subtree <- unsafe {
>                  GspSubtree::new(
>                      pdev,
> -                    tree_ref,
> -                    &*core::ptr::from_ref(&gsp_resources.gsp_falcon),
> -                    &*core::ptr::from_ref(&gsp_resources.gsp.cmdq),
> +                    tree.get_ref(),
> +                    &gsp_resources.get_ref().gsp_falcon,
> +                    &gsp_resources.get_ref().gsp.cmdq,
>                  )
>              },
> =20
> diff --git a/drivers/gpu/nova-core/irq/gsp.rs b/drivers/gpu/nova-core/irq=
/gsp.rs
> index 1abde8e0a405..f4fe7b5d691e 100644
> --- a/drivers/gpu/nova-core/irq/gsp.rs
> +++ b/drivers/gpu/nova-core/irq/gsp.rs
> @@ -50,15 +50,16 @@ pub(crate) fn quiesce(tree: &Tree<'_>, falcon: &Falco=
n<'_, GspFalcon>) {
>  }
> =20
>  /// Threaded IRQ handler for the GSP event.
> -pub(crate) struct GspInterrupt<'a> {
> +pub(crate) struct GspInterrupt<'a, 'gpu> {
>      falcon: &'a Falcon<'a, GspFalcon>,
> -    cmdq: &'a Cmdq<'a>,
> +    // `Cmdq` is invariant in `'gpu`; the handler borrows it for the sho=
rter `'a`.
> +    cmdq: &'a Cmdq<'gpu>,
>      tree: &'a Tree<'a>,
>      /// For logging.
>      dev: &'a device::Device,
>  }
> =20
> -impl GspInterrupt<'_> {
> +impl GspInterrupt<'_, '_> {
>      /// Clears the latch of every host-routed cause in `status` other th=
an SWGEN0, and logs them.
>      ///
>      /// Returns the causes still set after the clear. A cause driven fro=
m outside the falcon stays
> @@ -83,7 +84,7 @@ fn clear_faults(
>      }
>  }
> =20
> -impl irq::ThreadedHandler for GspInterrupt<'_> {
> +impl irq::ThreadedHandler for GspInterrupt<'_, '_> {
>      /// Top half, in hard interrupt context. Services the GSP vector onl=
y, so another vector
>      /// pending in the same leaf stays pending.
>      fn handle(&self) -> irq::ThreadedIrqReturn {
> @@ -145,13 +146,13 @@ fn handle_threaded(&self) -> irq::IrqReturn {
>  /// The declaration order is the drop order, and it is required: the vec=
tor is disabled before
>  /// `free_irq` runs. See "Enabling the GSP event" in `Documentation/gpu/=
nova/core/interrupts.rst`.
>  #[pin_data]
> -pub(crate) struct GspIrq<'a> {
> +pub(crate) struct GspIrq<'a, 'gpu> {
>      _leaf_guard: LeafEnableGuard<'a>,
>      #[pin]
> -    reg: irq::ThreadedRegistration<'a, GspInterrupt<'a>>,
> +    reg: irq::ThreadedRegistration<'a, GspInterrupt<'a, 'gpu>>,
>  }
> =20
> -impl<'a> GspIrq<'a> {
> +impl<'a, 'gpu: 'a> GspIrq<'a, 'gpu> {
>      /// Returns an initializer that registers the threaded handler and t=
hen enables the GSP
>      /// vector at its leaf.
>      ///
> @@ -171,7 +172,7 @@ pub(crate) unsafe fn new(
>          pdev: &'a pci::Device<device::Bound>,
>          tree: &'a Tree<'a>,
>          falcon: &'a Falcon<'a, GspFalcon>,
> -        cmdq: &'a Cmdq<'a>,
> +        cmdq: &'a Cmdq<'gpu>,
>      ) -> impl PinInit<Self, Error> + 'a {
>          let dev =3D pdev.as_ref();
> =20
>
> base-commit: a7cdb17ca0d7ce67e9f3a52d39edd60f03223729


