Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1410FCD98DA
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 17:23:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 210C610E58E;
	Mon, 15 Jun 2026 17:23:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=garyguo.net header.i=@garyguo.net header.b="vjLhzZvM";
	dkim-atps=neutral
Received: from LO2P265CU024.outbound.protection.outlook.com
 (mail-uksouthazon11021098.outbound.protection.outlook.com [52.101.95.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 837D910E58E
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 17:23:54 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KbcOwdW5C104HMGyXjCNz77jOJroT4wByKTiO712JMtg/LcnuXNO1V0VfyunLCn2KS1H0J5+4jb4zs4ODqIVVEM5TqTjpiKYPfvyJGp8ZIUE1fq4ViT2oaUpDX/gS1+X8tI4ilD+cFKn7D2F/zmC7pyuEFTITysg9YO4BlFu3C7fYSnhaMlBNJQEh1j1lE2c+ageJT0q7s3JTGT8xbFlg4KPptaP2k95aiGNnX8sfFXVgpmlv28a8rdzntVwyXd2IwYEDkqqk1k+2IkMXLnu+lrUy4+T0+zVRtrv2YYX1WrzYCoLS+cWDqU5kcmjf7CWZkAwW6cMI/lJ/qxRUj0o+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J+pVoBdkvWOBp158h/vKtvr+YrWB0joOikQrhsP6vHY=;
 b=gRCQJ0m9dbi6YUBXP9pMi9NdwhqADm7gCLxFoGge31fwHJuavL5tG2ZSC2zmD92AxzDWklJqUA/7B54sv4F0IKKqk1P25xPAkaCADklyoHKWYQf422UgwXUD227mAdQE0oWn7HltAGUUnJ+PQOt+rLdEH9rIMaJWUixdjFcv+v7i1DbtSRn0Rd2I3GCqhiojPC1p3GbL19SMD5s9fSeoNBNNO/BtIfkJrfrNHOKUA4BP3UsDx+cOma9GfD9ev+8Q1LjbZYksRi+4JXdtcn3HG0LNYFxLEi62pJzGz1lL0JqhbjY+XjmTRz+nRVE3T9UMVNqus8pTaFxunDiXOFCAIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=garyguo.net; dmarc=pass action=none header.from=garyguo.net;
 dkim=pass header.d=garyguo.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=garyguo.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J+pVoBdkvWOBp158h/vKtvr+YrWB0joOikQrhsP6vHY=;
 b=vjLhzZvMEIa4QMCNX/ibSLMzHxSJt//s1ZuYZynTf8UesdI/mHqWOh5ZK/qrgFKbnWaCLep56fTvoxJKtSk6tuB4IJ68xEdDgVZIh75qIZ7E5C7e8Se8N75ESdQxLqKR2NC+8Mg6hWWsb15qQBEgyYzCp5opjQPxkPS3YU7lfI4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=garyguo.net;
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:488::16)
 by LO0P265MB3385.GBRP265.PROD.OUTLOOK.COM (2603:10a6:600:168::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 17:23:51 +0000
Received: from LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986]) by LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 ([fe80::1c3:ceba:21b4:9986%4]) with mapi id 15.21.0113.015; Mon, 15 Jun 2026
 17:23:51 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 18:23:50 +0100
Message-Id: <DJ9SQ12O99GR.3TDJ2L39P03GQ@garyguo.net>
Subject: Re: [PATCH 05/13] gpu: nova-core: gsp: keep FMC boot params DMA
 region alive during error
From: "Gary Guo" <gary@garyguo.net>
To: "Eliot Courtney" <ecourtney@nvidia.com>, "Danilo Krummrich"
 <dakr@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>, "Alice Ryhl"
 <aliceryhl@google.com>, "David Airlie" <airlied@gmail.com>, "Simona Vetter"
 <simona@ffwll.ch>, "Benno Lossin" <lossin@kernel.org>, "Gary Guo"
 <gary@garyguo.net>
Cc: "John Hubbard" <jhubbard@nvidia.com>, "Alistair Popple"
 <apopple@nvidia.com>, "Timur Tabi" <ttabi@nvidia.com>,
 <nova-gpu@lists.linux.dev>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <rust-for-linux@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260615-blackwell-fixes-v1-0-f2853e49ff7d@nvidia.com>
 <20260615-blackwell-fixes-v1-5-f2853e49ff7d@nvidia.com>
In-Reply-To: <20260615-blackwell-fixes-v1-5-f2853e49ff7d@nvidia.com>
X-ClientProxiedBy: LO4P123CA0089.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:190::22) To LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:488::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LOVP265MB8871:EE_|LO0P265MB3385:EE_
X-MS-Office365-Filtering-Correlation-Id: 0befd37d-df3c-4a03-a493-08decb02de37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|7416014|1800799024|23010399003|10070799003|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: zpAqHyR5fuw58biCAJ8wYKuY7ItmQHoAF3jGJQFCggAE/3BAtFG0+IdOyWPvT+6lgOdremjSu237uG7cWB8AGwsjrehENmQkpwQiUuix4Hh2gYucrB9EMujLFWUPpSTDjiz4ZcBv3PbTXyGGIOS5uD+/u8qRWXP4KBUgzwJT+eg5MeEWhYZXhrQYrKzaFcQ+cJtuDo204/L+OE5e2oSqVKu+oWAMYZACXBaSV76Nu6b+ijNWuQtnX4A99jhQo0iJ1O5O7NoWlIpeoHvtPn3kuBJOrW6AOHZS/zFKR3a5EBlPwV9X/+QQ5FsQtIys33KQu2gTLItng9Nh4x07ArkmH89P5mT2dYsyDZ1wI4GutDQT4rnITibelyqiiHWfG+wdE2ZwphwHmRbXo8jbT9/lNmJTlSmQFUj1UdtniGWHRnxbJn/qbMLXlMOktAbBc2edMY4oNyhK+raVpWCELZKSlx6YbCvr632VQTpl3Jo6t40JFqncovHS4CV+SD+RlTcdUQ4c+xHSg3HfYWW8w4xKTSs1jgpo5+/Jqe+q6tk9aSKht9PGqVL9Um+Jj98K4zScjNNEPia6SOptv3pt3WUVf+a2TwATlzpw4Wu/5SY5fGmnRr9W2wkVjEnVKmUptQKfmLvSuMBPLkAq5kptcL59wCn7hCiwlbycANi5yCki244+X7p/vNIMfAJmiDSdrv3T
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(7416014)(1800799024)(23010399003)(10070799003)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a29JVjk5dmVNRVBlbWlHOXd1TDNEMG5iN1ZXdGdNR0JsdlpYN3NwODBhUlhO?=
 =?utf-8?B?VTVJVzE2QkpWejJreHUyejR2ZnllTGF3WmJ4bkJ2aW5sNWZDNFpNMWo3M3Iz?=
 =?utf-8?B?eFNWSTc2ZU5wNjVMUWNLK1QxQjFrYVo1MkZMK0MzL2lpTFNxVDdLV1dRVXZO?=
 =?utf-8?B?dWRtZWlxNFdqeXRPamJ4ZXZHVUxKYXZTWnp3M0pZanU3cVBlWWgwVGpsc3RZ?=
 =?utf-8?B?Q0tzdkdBeEFMb1BsOHFBVkdzalJTN1BDY2tEYloyZkwrMnIrbDVhQXFtUm0w?=
 =?utf-8?B?SVlwUUlJY3V0TDJQeW5qekRHWE5UWjFVYzFGRldvdkF4UFIrQmJnR0tKV0ZM?=
 =?utf-8?B?czMzdFJMUEpRZkRSZ0J4REllUTRKNXF6dDE1R3lZU044dlN5TXNiSlNHVk1I?=
 =?utf-8?B?K08reWN4cklyaGdaOHFpeVR5ajRHekdLTVkrazU3eHJpeGwyQ1RsZmZPbkUz?=
 =?utf-8?B?Y3h1T3NaaFZCYi92QmRWcUlOY3pERlFGL1k2dzh2Z3hEWVNrbnM0Qml4TTZv?=
 =?utf-8?B?Ylg5VWpIVTlnV0dIc01kNEpVazVnV0VBMlNOZEZrYUZ6UlhKenhwY09ZNVIw?=
 =?utf-8?B?N0MvN0tERE5VQjk1dnZmQkljT2lyOU5KbkdwS3RYMlZFV2JEaEoreFZDMGxB?=
 =?utf-8?B?NkZId3labk16emY2YzZ1UFB6NTBkQlhETjl1VFRwTUF4SEVQSW4yMXV5eXBi?=
 =?utf-8?B?cEtpckFKRS9yVXZNaEU0YlpSU2x1V2lteU5keVhYb0Q5SVEyTUV6cFhaTjZ5?=
 =?utf-8?B?UnE2WS8wN0k4bFBNQ2NaME9UMWc1eU9BZ3pjczZzYTByZlFjK083N0EvRDEr?=
 =?utf-8?B?SmVwMXo0RDR5RjBtdDE5cm82bkVlaUFiTE9jWjR2eTFBLzc4VFhEUVVvdGJF?=
 =?utf-8?B?VVRuN0FNY0cwcHBXYW9DQm81VGxDbEpTVmQvdnJscEZPbjNSWFRTbEMwcUVr?=
 =?utf-8?B?T2hZVkVha0tGRy8zVHdHRUE0WDlNZ0NYNW55K2F5aVZDcU1wRFllczdmdzBx?=
 =?utf-8?B?VlBZMUpoTXNQSE5wL1NzNHk5T0lzOXBISmVPUUtjRDFVejdRY2RhQmgwUnh4?=
 =?utf-8?B?QTRyYXFoWUtGaUlYYzZRWUMwVHJLZ011bnlHK1JTMGU0R2JVS2p6NGhLNDI5?=
 =?utf-8?B?OXBWemgxL1UxVG9ZOG1TcGdVcllxOTFoWFIwRVptS2F6S3YyU3REdEgxanVm?=
 =?utf-8?B?dTJZMTg3dytwVEduMmtyK0NpRFd4OEh0Z0RmeTh4TTFNYTBwQmNGZjFiYW96?=
 =?utf-8?B?RzFVcm0vTVB2aHNTNWVJVEVlZVZJRHN5bW1ET216dENFaURhV3BjT0pNd1lu?=
 =?utf-8?B?SW5lTmRRWUhIcGdhL0JUTmhIN3AzYmxMa1dTdXYrTTdrK3NyWTlNZzhnV29Y?=
 =?utf-8?B?R3FsTUZpUDRXakNhd2lEZTdWK3JnQzhyOE5jbERERXVoRS9PdVF4dXNZdUN3?=
 =?utf-8?B?NWI3bEdzanhlTm9RVGJTaHBSZngwV2Y1dytWNzdSenBMMTdrZHFhK3RnSnJO?=
 =?utf-8?B?QVZ1cGsxRjRGVzZPQWwreXJsUnkwSkpTVlB1SU9NMTFZZmlPeVpkMEovSzMx?=
 =?utf-8?B?Y04wS0J0enNhZFdWL25ZWnl3YjJYM0xlNXZrT3ZKYWVBanJFVHdYeTRTbGhk?=
 =?utf-8?B?d3VxUWNwS3hLQUtEQ1AzL1hNRHpDZWJiM1RrSEdidzZBM09mdnM5a0VWOHpH?=
 =?utf-8?B?Q0JkVDBYdngydXBPU3pBM0FsMC9LWnlHOXRVdVk3OGFhZ0hJbVRMWjVmanVC?=
 =?utf-8?B?NnVSVnF3L0JIYTZwT21aMm1NKzN1UkdYeXVTV3o0Z0FtL0RhN0RTSFlnYjFN?=
 =?utf-8?B?SjdyWGVldjJPeE5POFNHdFZ2dTdoZW1yUFY1VmZaWVpTU0NlTU1KbHNjWlps?=
 =?utf-8?B?RjV2SVMyYmtER1NHcFh0bUhJWTduVVpoTnJWakNkTG9XVDZHMjkycGtiTkll?=
 =?utf-8?B?ZTkwK1E1SGM5T29NMUVnalIycHY2NjBIek9URUhwSFVqYVpHNWx6MFZNcmFy?=
 =?utf-8?B?ZmJaUTZrNFpZQkhsK3NwMXl4RTlZdTZtci8wbFE4Y0VVbmFMWVFHRFFxQ3BH?=
 =?utf-8?B?WnlPN2ZLa1hhVG9GcjNmVE9kdSsxdWgwcXdtNDV1QjFmM2psa3kwcW9TR25Q?=
 =?utf-8?B?OGZKeUt4elBrS0c5TmVNSktnUHlSbGozVjYrQS9yalNhTWZyak9ZajFZZHJ4?=
 =?utf-8?B?SVNvOGs1MURIZXl5V25lV1cvcGdlRjdmK1RZVy9QSDNNY0tDU1NLdmUyNjFK?=
 =?utf-8?B?cUxDcnRLN2diMEQ3czd2c3gzM3kyaDlQUzl0NW13QmtkMVRtYlJGNUphN01C?=
 =?utf-8?B?WVpwc1FSOEpHRWRTZmJEZ0NWY21uRFY5MGlHMEwyMkJhQ0tDYTRydz09?=
X-OriginatorOrg: garyguo.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 0befd37d-df3c-4a03-a493-08decb02de37
X-MS-Exchange-CrossTenant-AuthSource: LOVP265MB8871.GBRP265.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 17:23:51.2501 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: bbc898ad-b10f-4e10-8552-d9377b823d45
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PaGmBgyut9MWetX32HCy0TSxPT5+xVArc/N0aDuTWHpPUOkid2JzFYaHvTAhhNtMYG8zu9Zvl/l8+uw8IkQung==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LO0P265MB3385
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

On Mon Jun 15, 2026 at 3:40 PM BST, Eliot Courtney wrote:
> Currently, if, for example `boot_fmc` fails, `FmcBootArgs` will be
> dropped before the boot unload guard. But until everything is unloaded,
> GSP may access this memory, so make sure it doesn't get deallocated.

Hmm, this looks very weirld. `boot_fmc` only needs `&args` but it actually =
need
it for much longer?

This is hinting to me that the signature is wrong of the `boot_fmc` functio=
n is
wrong..

What is the exact lifetime requirement for GSP?

>
> Signed-off-by: Eliot Courtney <ecourtney@nvidia.com>
> ---
>  drivers/gpu/nova-core/gsp/hal/gh100.rs | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/gpu/nova-core/gsp/hal/gh100.rs b/drivers/gpu/nova-co=
re/gsp/hal/gh100.rs
> index 98f5ce197d13..b08761af89d3 100644
> --- a/drivers/gpu/nova-core/gsp/hal/gh100.rs
> +++ b/drivers/gpu/nova-core/gsp/hal/gh100.rs
> @@ -162,16 +162,6 @@ fn boot<'a>(
>      ) -> Result<BootUnloadGuard<'a>> {
>          let fsp_fw =3D FspFirmware::new(dev, chipset, FIRMWARE_VERSION)?=
;
> =20
> -        let unload_bundle =3D crate::gsp::UnloadBundle(
> -            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBu=
ndle>
> -        );
> -
> -        // Wrap the unload bundle into a drop guard so it is automatical=
ly run upon failure.
> -        let unload_guard =3D
> -            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon,=
 Some(unload_bundle));
> -
> -        let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw)=
?;
> -
>          let args =3D FmcBootArgs::new(
>              dev,
>              chipset,
> @@ -180,6 +170,16 @@ fn boot<'a>(
>              false,
>          )?;
> =20
> +        let mut fsp =3D Fsp::wait_secure_boot(dev, bar, chipset, fsp_fw)=
?;
> +
> +        let unload_bundle =3D crate::gsp::UnloadBundle(
> +            KBox::new(FspUnloadBundle, GFP_KERNEL)? as KBox<dyn UnloadBu=
ndle>
> +        );
> +
> +        // Wrap the unload bundle into a drop guard so it is automatical=
ly run upon failure.
> +        let unload_guard =3D
> +            BootUnloadGuard::new(gsp, dev, bar, gsp_falcon, sec2_falcon,=
 Some(unload_bundle));
> +

This usual "usage beyond reference lifetime" needs to be at least explicitl=
y
mentioned here.

Best,
Gary

>          fsp.boot_fmc(dev, bar, fb_layout, &args)?;
> =20
>          wait_for_gsp_lockdown_release(dev, bar, gsp_falcon, args.boot_pa=
rams_dma_handle())?;


