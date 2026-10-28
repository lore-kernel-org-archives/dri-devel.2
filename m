Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABF0606A31A
	for <dri-devel@archiver.kernel.org>; Wed, 28 Oct 2026 01:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=cpy7tc9I
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8D16910F920;
	Wed, 28 Oct 2026 01:52:55 +0000 (UTC)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012063.outbound.protection.outlook.com [52.101.43.63])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57B7810F920
 for <dri-devel@lists.freedesktop.org>; Wed, 28 Oct 2026 01:52:48 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MTfcnb/DoKc1KvboTqG/wz7O5tsddC9QciR94L//iDR+ZlhWJUxl4tpF8wd1DzfUrgR+oxbLhjmN9e27pZhu1Hb3U6/NXBDg9YyTcZdLr6eesyKBJGgCEUmlX4FcDxbPbKUgD2Xy3hslt8qxK8Y6aGZ3guHZM71/O+a7GEbBVEs9cSiL6lKrooJEzInDgBoFmN9IVuQI1GN18ShC3Ap+0F5VlzmTcV7YfG3hIxiZ31Va7Mqxc9FVVAEJ7YmoF8J7oldyIQWzsw9eKxwVyBSRsG3moF0Jnca+iZrBQGPOqZBMs3aEfqDt1QGKikg1EtszaoO262u9o5tR1kQjYA8Shw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qtk4iKYdwaQs1Uar2/hZc29NpLBUkP5zoNKNoM1seVA=;
 b=UE59PohGnzAyajZIjOJzDqc0zRp2GwusDrSZGmPYIpdeGXZ07A5J9ooLMkGrjYhcgcf8j3wHhMbA4NDZMSeKIpaBi8NbTGOUvyFHFrbk5MRFWT6oNn+f56gfx2Uj1wD1EZuY9SSULIjaVJ6uCkPrEGJtwHzo4GZgyAilMKntp2ojIKlnpKJZee9UVDTsqIRSawPQlXT8NXjt+y68NxfuXEu4BdOU/MH+zmfgI5dkBl7ftyMhKB0Xc+R8UvYZQT845bQThgT358sci27JDawbzczLWI96hgp0yIRtJtVdS1z2NURewqjF5geDDK5nQ4xja6bfVoIfjZoMbJZUapcnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qtk4iKYdwaQs1Uar2/hZc29NpLBUkP5zoNKNoM1seVA=;
 b=cpy7tc9I4xX4XSLMNpz7zG2MzUnKQDene3fnnD5EvTiomtfY59Jp7hKlRq/lNeXTBz4H8VrgcZMnClNtAAiyFP/XiQO7ELGpDtvHxX8cYC48QNlLRLxr09nBLyzRqO4tKUAG08SSIZCIzGYsWjIZZJtkqur+DrXnyKH1Jn0Xp7piR+o17onTfLtUn3xSih2gqAzWWflSvlKaYc9SJBBHyrVATkT9fVdtaTxtHgXl+0C6rXcH2VWSyjIXHZuzpqOnRkgNXER/eyfJBH0AmNDQmllCZNJk4EaRWGyRQkQMCJBVGKmVRfz8f7H7nZ8hFjk/N8AWPDK1njkdkvK34lncqw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by LV2PR12MB5774.namprd12.prod.outlook.com (2603:10b6:408:17a::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Wed, 28 Oct
 2026 01:52:43 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.021; Wed, 28 Oct 2026
 01:52:43 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-tegra@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>,
 webgeek1234@gmail.com
Subject: Re: [PATCH v4 0/2] drm/tegra: Support YVU formats
Date: Wed, 28 Oct 2026 10:52:40 +0900
Message-ID: <EUfz2J8BT1q-ycacwPVmVA@nvidia.com>
In-Reply-To: <20261025-tegra-drm-yvu420-v4-0-30b3bb0d0752@gmail.com>
References: <20261025-tegra-drm-yvu420-v4-0-30b3bb0d0752@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0328.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:3b7::17) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|LV2PR12MB5774:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c33b4ba-0c8e-47f8-18c6-08df34962819
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|10070799003|376014|261009223027099003|261026140227099003|56012099006|11063799006|261022075727099003|261021121427099003|261021123027099003|261022105027099003|18002099003|261026121527099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: ZHKDGg1mNaI6fjQWZ/QrxuQkftfFc3b/TxWw98xkJLTx5H9kb9Lw344w6xnMKzGuORUMR6Ky3ij5zgv6detx8x4Y97/LlTRncZOsq4sUh+zad02Q3q1s+BG8CM13UEfmW3knJk8PJfoQbT0Jto8nanKpVVAVymw9tzcjXhCUUG/BmPwJK/zcvO0fnzbfUoPVO/UvSwGpNQIIQusO2lAbB4s5+Dk+H0j0C6+VEYJR14nspOXuWq1pwZ6vqatPKMTF34eX/h+gz9qk2UuPpjObYPybLVplxYWd/S58M5zmJAxQVwr99H7vRaUTnQKLdUFERD5RlA1UMa28uL9xalrDCCoWTiEhYzitAph33Zondlrvjcy0kyMrFdmc5IVoAMfE2lNbkVNPm3pWm1uMWaLOBMYWK6ucqtJSjkWDvLA1EQr2ZEGXwhlN/R4Pbs4r741uzMt9QqY5ouZtRFtKrSEtlvq3GmTOO1b3elhezqTrTc5S00j5hds+WCBYdzsNMhDipczkKerL6ETK7anku1netp5vHip+TEVOT71HIAhbnFogQmr6xoue9cJTwfeL6uFpWmHmtuETN2nW+VOtU7USknJKYY2tCwjJnituE2y0mrtivXe+NsD68JqMR8en97YuIb0wPIR/8fLSj/gePG2cNuI09lwaXXhEVe8jeZR2+ZU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(376014)(261009223027099003)(261026140227099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(18002099003)(261026121527099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVBsUFNsS214NXRlQmpCZnFmandhb1RYdlNDckVWQ0prUmorR0E4YzVFNmFi?=
 =?utf-8?B?M3AvZVdySVkrVnFmQVZMOFlQSSt0NHNzL2RpbmVnUGV6MVZ2VmkyN2tOZnMz?=
 =?utf-8?B?OW51Ymh4Q1BzTEZwTzVzQm1XMmVhRWNYZEFLUGw2eitPbTQwZEFrU295aklr?=
 =?utf-8?B?R1pva1ZUSW00dE9VcG5Wei8wVURaR0x1WDZxNEZyNjdwUzhON0ZFbUo1VnFh?=
 =?utf-8?B?ZGxSd1paaFpSWklpWWsvdk4vR3hJY0JSNEtlYktQL0VzbytCeVJzVDZkdFhw?=
 =?utf-8?B?VTZvZVVPNmUvV0h5S1ZrbTdKWEowNmlQenljSkNBWnJLeGpwb1Via0IwazBW?=
 =?utf-8?B?S2xROURxNUMyQUNZQllFaEZzTjU4Ylg3TktFQzBsQVN1R2ljZmFLRitFdTJs?=
 =?utf-8?B?ZWM0OUIzcGsvWktyOG5SN2tZYXZQa0JLalZydGpTTHBuQzhtVXl6bk9tQWdR?=
 =?utf-8?B?c2xQbC9VeDR0RFJ2Y056V241S0NsVUFiU0ZpbGtSOTczbE5ZSjN5UGJ6MTdt?=
 =?utf-8?B?cTJ2ZGlEbW1aQzRtR014ZGJwUjB0Q1JWK3VhTTFXaWczT1E5TTE5ZXRpK2NI?=
 =?utf-8?B?MkxzVXJQZlVjOEJSRXdTUmRZcjhqQ2p6Ykh5NU5mc0F4c2xNVTQwdFB4ZERJ?=
 =?utf-8?B?ckw3S2RiVEJYTjFTcEhNcTNVVjE4dWU1Uk5vLzJpVTBBK1pIMGpUeGRuL3pv?=
 =?utf-8?B?VWV3WmJIVXdSZUtsRCthVmZaUVVMVGhXeHIvRTlxVTY0MmtEeXY2VTlreXZL?=
 =?utf-8?B?R3ZQV0ZPWjlUSCsrMU1Vc0llUmUrVUhsSkRyR1RYNk1aemJCaUhUYTMraG02?=
 =?utf-8?B?RTB2dmtKVjI2YjdtQUU2VUpqZkYzc3UxM0JXTzVwOW1abGpsc0pZMTlNTDRX?=
 =?utf-8?B?MTlRejRHb3BKTHRtUk12YmVWQkdjY1ZuWkpmQndUc0pwR2hQNUVheXBTOW1F?=
 =?utf-8?B?MTFKeXIwSFlWc3UvaGh4L2J5UGVURGh0QllRb29LcnpjUjVuek1oM2xxRExW?=
 =?utf-8?B?Q3JrVTc0czRUQjRiUmljcENlQWdLZjM2LzE1MDc3encvRDF2N3MzOXlYdnFF?=
 =?utf-8?B?N3ZOMmxUM2JDQkZYdFlQbHRGUW4wMzVlSmo1eWsxdzJNZHh3a2xnOHNCV2hW?=
 =?utf-8?B?NXdmenA3Z2hmNkZLMVN4TFNuaXpCRi9iNS9IQVJXdEg2eE5iTDdYQkpiYUJm?=
 =?utf-8?B?SXlRbHpIWlNiVml1NUVCdk1RUnZNMkpEQkU0ZllkUjZiWnk0QTdEbC81Tk9P?=
 =?utf-8?B?bW5GUGdzZ2ZjbTZRaWtXWVBCWFRjRTVYMFh2cDB3MEZoRktRcjZRNHZJY2Yx?=
 =?utf-8?B?R2NRUjFjZUdHVjhtZlR5YlRDcFliWDE1M0wzT2RSMWtwV2JKZU5MRndqQ20z?=
 =?utf-8?B?QjZCK1dnWEVBSTFCQkRUOEZpSzVkdE1tbjd5NUovODlUZHZndGRkUTlyOGdC?=
 =?utf-8?B?VUROeDRoYmRhVERMQzRaQ1FhelNsdzdac204c0RTdWRLTXRKaENmU25OVnht?=
 =?utf-8?B?OTVKbnYxc1lVSldBM2lxTHRUY2hTSWRtcVdZQjNtUUQwTS9QVUQ3Mi85S1Z4?=
 =?utf-8?B?VlhkRU5TU1BPb3dYZFMrQUZoejE3UE9hVTM4aE1WVVR2YTE2Y0Q4TWdxQ1N1?=
 =?utf-8?B?aHQ5YnFQcXhTNnZRQnkzb3hmbFNFQmVxNmd4RmtVWkR0TnphYjBCc1JDYnQ0?=
 =?utf-8?B?cFgvT2djRnhCQmZ4UXUwV29pZzJnbWhFZW9CZkhlR2cyVE4yL3JxaldWN0FB?=
 =?utf-8?B?QkdSSkFlVjcraTdzUSswOGRUbWFucjIzUHlFWUt3K3ovV2QvM3pydWZ6L1M0?=
 =?utf-8?B?WEpUZC9HNUVTNHNheUNwaFgrSkZGbHRxNkp1VzcxVmpNM2o0cVhsaHphRVVT?=
 =?utf-8?B?Yy8yT05ZSVRmZ1dRbVZ4OTcweFg1STd3MTdiQ1hKU1lENjZ1VTFHTjZnWFlz?=
 =?utf-8?B?akVma1Z1QTNVdk5abTNUWGlQM21UaTNZMmU2NXFXMnpHRXV1ak1ubkVrTS9W?=
 =?utf-8?B?Z0kxZEx2SFVOdEZac0JBQ0xTaHZaMGdlNFJ4UjhaM0V4ZVhrK05VbDhPamJZ?=
 =?utf-8?B?Y2M4ZTNCTnNSMTRGdnl5OU9FOTVsQnp2MVQ0TXRwQmVUTkx4cDJkWUtMQWRv?=
 =?utf-8?B?VzBVODdGR1BQQldqKys3dDFEQm8wRm1BbzdhektOWGFjcDluenVPK1NzTis4?=
 =?utf-8?B?eEtqNHNIaDY3eWhZRmlQU3dPQWJ3LzZTR1IyRjF0MXZ4YXd5dTlRNFR3SkxR?=
 =?utf-8?B?d2hFT1FJeVRRcVdXQXhHRUJWd09tSTlFV2x3eC9jcDdOTEpiTVhFeFdqcU1m?=
 =?utf-8?B?NzlqS0o5aUdRcXgyNkRaSlJaQ213K2ZlSDBEMTZXeWFtaEJTREM2OGxNUzMr?=
 =?utf-8?Q?nQrmUbMZ+uOXkumdmKHzeXr6iG3RxKTo5W26EBdF82/NM?=
X-MS-Exchange-AntiSpam-MessageData-1: nIGdSVJgIAiSyg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c33b4ba-0c8e-47f8-18c6-08df34962819
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Oct 2026 01:52:43.3684 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JShvUuM/l2m1KnYYd762E6g2gz0yskkoqGealaJUJ4YlfBIJ9i5KlLYmY+TSBg/eix/tT6su2gpB7eySFpEszQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5774
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Monday, October 26, 2026 7:34=E2=80=AFAM Aaron Kling via B4 Relay wrote:
> This is not directly supported by the display controller hardware.
> However, this can be handled efficiently on tegradc by just passing the
> chroma planes to the hardware backwards and reporting it as the yuv
> equivalent. Nvdisplay has a hardware flag to handle the swap in
> hardware.
>=20
> YVU420 is required by AOSP for software decoded video playback among
> other things. An attempt was made to handle this in gralloc by swapping
> the chroma planes there, but it wasn't working. This kernel
> implementation is working and is more generic anyways. This has been
> verified on a SHIELD TV 2019 Pro for the tegradc path and a Jetson TX2
> NX for the nvdisplay path.
>=20
> ---
> Changes in v4:
> - Drop yvu422 from the nvdisplay path. Yuv422 is not supported and will
>   be removed separately
> - Link to v3: https://lore.kernel.org/r/20261020-tegra-drm-yvu420-v3-0-7f=
19a834ba98@gmail.com
>=20
> Changes in v3:
> - In patch 1, use the SWAP_UV window group flag instead of manually
>   swapping for nvdisplay
> - In patch 2, support the chroma swapped variants of the other yuv types
> - Link to v2: https://lore.kernel.org/r/20261018-tegra-drm-yvu420-v2-0-51=
2889103ab4@gmail.com
>=20
> Changes in v2:
> - In patch 1, simplify pre-nvdisplay path to a swap of the window base
>   address
> - In patch 1, address sashiko report about failure to copy the new
>   struct entry in duplicate_state
> - In patch 2, address sashiko report that yvu420 was missing from
>   tegra20_overlays when the targets already support yuv420.
> - Link to v1: https://lore.kernel.org/r/20261008-tegra-drm-yvu420-v1-0-dc=
1c443c00f3@gmail.com
>=20
> ---
> Aaron Kling (2):
>       drm/tegra: Support swapping chroma planes
>       drm/tegra: Support YVU formats
>=20
>  drivers/gpu/drm/tegra/dc.c    | 13 ++++++++++++-
>  drivers/gpu/drm/tegra/hub.c   |  8 ++++++--
>  drivers/gpu/drm/tegra/plane.c | 29 ++++++++++++++++++++++++++++-
>  drivers/gpu/drm/tegra/plane.h |  3 ++-
>  4 files changed, 48 insertions(+), 5 deletions(-)
> ---
> base-commit: 20a33c6b6cbe7e4805dfb6cd68816937443aa148
> change-id: 20261008-tegra-drm-yvu420-1dbb7140e54a
>=20
> Best regards,
> --=20
> Aaron Kling <webgeek1234@gmail.com>

Series,

Reviewed-by: Mikko Perttunen <mperttunen@nvidia.com>
Tested-by: Mikko Perttunen <mperttunen@nvidia.com> # Jetson AGX Xavier

Thank you!




