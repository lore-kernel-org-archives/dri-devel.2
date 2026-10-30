Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73B606A31A
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=o6kb7Etk
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D691211260E;
	Fri, 30 Oct 2026 02:38:09 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011067.outbound.protection.outlook.com [52.101.52.67])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3F3A411260E
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 02:38:03 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xMFOdZPNgaq3s/ZTNQ07lC6kqfAFe+95f3H+yAyBUuhxQPKgGDq8mmOBuE1vpgih6ZyaUfEDCcgLQTuVs8bo2yNQ/FWUeozdko2OOGsYd6DAjo9TmYe78k01JwrEP1f171WdaGBt2UvVz6UvFcB1JwUetyRb6Vu0r8PbF8RN4q6OWm4Cayxge3folXp22pPgDiYgF8rfcSGnUNgAf5H5OV7c0C8f2MphWjb0vWx1NgDipEL1q7mKZxUDsAaOy9Wn5En4PX9ckLS+ioeOa7eIzlkvGv7rZh3KIxvcAzAUtcd48iNSmI4nb8LzkWFYss2DaBQBOuhfHiX9otnSbb8XRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wc1eNZc+fY71rAknGBOCWvV2tYF3Dw+MSjlv5iF/Gt8=;
 b=JLGrHKtuDNApjT7yEre0O7XUxSsh3syU5fv0r1W5j0AQmMUPzqICsrdfVXTyCOJkPhvaoEa2k0VKBUE24ZjNCScPJrdkfnmysQNeZbJwBSbZWbAt4jqsEwbFXYfSMhrn2eMxG1oMW9HcqMFNk7fuMJ2rTxrGeNr45UG6WfkD16MFtk4GtCC4hG7z9knXjLBrN+3VQ7wqDRPIdWaZr3czroj9/uk9RA926FFO5U3NrdRL18XoEQApYtGa9HDGvXlQuFQRWg52aNz0h8PkCyN30sRscS+MQsVSjhAky5x66zY1+ScuVz3+vK14gGE+aOBjZedvYYkKzha0og236c2l2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wc1eNZc+fY71rAknGBOCWvV2tYF3Dw+MSjlv5iF/Gt8=;
 b=o6kb7EtkQ4tug7GcTePWNKbYExtTT5ypVe8qLqmbf+hIkaUUxv/Xd1J01dPpEcYwuizY+RTW8dmAgF6qd18N8TzRUEdmLM7C+Hvjf7JkUkSzsbk1FuRM9357OmUOkrdAMSNl2gQLdqqBtdWChZ7f8oBLLHNLu11hhPGPiCy9zPJderd6K/V2pyLk0ykQG+xPpZ9FJjhso27ffkaCRnJzlFgnXLARqFsGTXLY1SenFSD96ZsSuLwtVSmffOPva3ZCF31mhlOKg9cURiTTeEYoGGV1z0WLDe2qH3tlEh1EGgdd12lDMoaS/21qJSWoZxkS1B9kINJojYISB885X5MipQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PPFD4454CAA9.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::be5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.21; Fri, 30 Oct
 2026 02:37:59 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 02:37:58 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: linux-tegra@vger.kernel.org
Cc: Robin Murphy <robin.murphy@arm.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Heiko Stuebner <heiko@sntech.de>,
 Thierry Reding <thierry.reding@kernel.org>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Jonathan Hunter <jonathanh@nvidia.com>,
 Krishna Reddy <vdumpa@nvidia.com>, Krzysztof Kozlowski <krzk@kernel.org>,
 Jason Gunthorpe <jgg@ziepe.ca>, Peter Griffin <peter.griffin@linaro.org>,
 Alim Akhtar <alim.akhtar@samsung.com>, Chen-Yu Tsai <wens@kernel.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Yong Wu <yong.wu@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Rob Clark <robin.clark@oss.qualcomm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH v3 00/10] Make the 32-bit ARM DMA API work with normal
 IOMMU DMA default domains (+ Tegra PoC)
Date: Fri, 30 Oct 2026 11:37:53 +0900
Message-ID: <wbo9prdIQW6DX3kU4aWbuA@nvidia.com>
In-Reply-To: <auM2FAYVK192RzHb@infradead.org>
References: <20261026-b4-arm32-iommu-dma-cookie-v3-0-3901d74b1ff2@nvidia.com>
 <auM2FAYVK192RzHb@infradead.org>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCPR01CA0143.jpnprd01.prod.outlook.com
 (2603:1096:400:2b7::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PPFD4454CAA9:EE_
X-MS-Office365-Filtering-Correlation-Id: 410846b4-3b56-4410-3688-08df362ecedb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|366016|23010399003|7416014|376014|1800799024|18002099003|6133799003|261026121527099003|22082099003|10067099003|11063799006|56012099006|5023799004|261021130227099003|261028144727099003|261022113327099003|261022105027099003|261021135927099003|261021121427099003|261022075727099003|261026140227099003|261022115727099003|4143699003|261021123027099003|261026130827099003;
X-Microsoft-Antispam-Message-Info: XxBr/7LokCXcmaWmdjkw7yVudUcWYfo8DA50AlJCY7978V70nRqYsfCqwFS+H7kdoKxeGo7WQZ3lbv1J0kQ74pzJopDd1WyT3U/tc6JG4xDKiworoheok/QPT79vu0WJE/QB9kr45ian0Q5q6bdqXblTt2MGJsnXxc3fXVlirF2t1J6f0C9pd6sGdyX24DvucUwsXg+A3WF5MOEwDA7npkNW3vUiwSNUovLFnoswe9Bi/xi+eXpVPPMuw1mWRiK7pOu39k9gIiEvo1Bc5L0XjNHlCO8dRdAtr6Ea0ZHPq1fEc/S/YXMrXZx3YvMV7jE0JdYsFUDMSWcVnWKuIX/n/45cTJNhKMTQZigd8XKQLoqAyqO52LlFL0zCnU+NNWw6eQqQZGonYIEBShoA9/4XumgnMiu8uWlv1UH+p1eoCqf9HzTS7RRx7irFfPrHYI6s4z+yJdhWTWYqUCVxDKWjzcffBzGp3rhbSIY0UDE68jz4YF0CQxSMwtlPu7FrIKmnKAK2o97Jo+VCm0KZ6ZoC9XlG8pMHHL/YOTv7h+I5I+WSuoGq2p3vhzknrcMtcvCCeREOSgJuyYOB4LKE9WGqoUWRj3e0HpXM5gcIf8G2u3yO7D3bAY4z5B4UhX6hfwKJ9REJ9odDJ+IYswjdeL2WtMRQevogwqU8HYwqNPL9rGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(366016)(23010399003)(7416014)(376014)(1800799024)(18002099003)(6133799003)(261026121527099003)(22082099003)(10067099003)(11063799006)(56012099006)(5023799004)(261021130227099003)(261028144727099003)(261022113327099003)(261022105027099003)(261021135927099003)(261021121427099003)(261022075727099003)(261026140227099003)(261022115727099003)(4143699003)(261021123027099003)(261026130827099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cWd6U1UzVXNEU1M0SWtwN3FjNXNNQWNzQ2d0TTRBRG80MENKWUVBZ0FHOFJQ?=
 =?utf-8?B?Wi9NRDlGT1Z1eGZ3QzFTeDU2clFQT29NUElVMjEwbjdXWHk2S21hVEF2VCt3?=
 =?utf-8?B?dDR5ODljVVhBMkhJWEFPTHVoZ2NlREZ6emM2VFFNMGFoNnd1ZHJxcVJ6SU5a?=
 =?utf-8?B?NHBYNTd3RVpHN0lJVHFBZ0tHTFU2QjUxL2xXbWIrTDJGRUVNTjhrOEZESzE2?=
 =?utf-8?B?RjJxa3RVRHFGVDU4VmdWRWl3U3dBY2lKZzVUZ1Z2OTgzWkVNdzlvVG9PK2dG?=
 =?utf-8?B?N0tlU1F6cGtYcDhFR25MZnFUVTFPRGdGYTBOTWM3eEdTVG5XeGdvYW1pcXlx?=
 =?utf-8?B?Um9RT0Yrei9rQy8vZDU1WUZEcEx3bzVIczJtRXRXRlNWNTREKzVBSUtsWXo5?=
 =?utf-8?B?N1pra1NOeC95VVZLQTZrQk1sTWFmdHRwVFlZZG9uYmlpV1ZJeHUrZFM5RjdI?=
 =?utf-8?B?NEJvdDc4TDl1aVhqTFd3OWZMRDYxRXFMUFJXVjFFc0ppOFVjdmlueWk2WHQ5?=
 =?utf-8?B?MVprMS9oUjJjaGY0cU9hYmszaEc2bXdyM3dpVDRpcWR5RDBOd2ExRUlzL05P?=
 =?utf-8?B?R21JbDg3UGpKU3psYTdqNU0zZ2Q5b2pnNzdMRmhIb0QyN3owckZuRjFEM05k?=
 =?utf-8?B?dnZpajAzbWUzTHBFOTJvL1JzNFM5cjdlbmU0c3NORVRzdmplL3M0emF1TGFH?=
 =?utf-8?B?SkYxS01XWklFVkpuT1dCc3lZb0txb0srWUcyOWN5TmJEV0FlczB3ZGxRYXNM?=
 =?utf-8?B?c2lKUUR3K3pXSHNlZWdEM2hkdWkzNk5ycnZadmw3VTlQRXNSYjFjclVMV0hO?=
 =?utf-8?B?RDJQVkVhd1d3QkNuOGgxQnY2d2YwQWhXanNjWWtFTVFXZ0ZPVVZVVlJlRmpY?=
 =?utf-8?B?SzNEWjN0QzFiZEhycjl6T3VuWkZ5akd1UWZ0OTRKV0pDQjczckxnMHBINTFo?=
 =?utf-8?B?MUNLKy9JSjNKM2JDVzRLVk1CbzRLazV6SzdtK2VXa0NZelVNNkNpQVVWVFBn?=
 =?utf-8?B?TW9WU09wOWIyaXRzU3g1WlpBRnFkRE16a2FyaGE4akRVc01RRW5Ka0lLOWRO?=
 =?utf-8?B?eE43dXZBQ3Zodlh4N2ZOTi92UjVPWmFYWW5RaEYzNzZPZGxqRjc0akIvMVhH?=
 =?utf-8?B?MjBiUzd4c1lQTWhRRzJKaHppYUFIc2xWTVAvQXdCelV2TEtFUERCZXZXM1dC?=
 =?utf-8?B?WnBuQmZLTVdmQXBuUEZTeFN1K2lCbk1oUzVoMU1vWWZ2Mk5hZTVheTRub2VM?=
 =?utf-8?B?NmJuQ0RtWFZmUXoxbXV3eGt3d2hFenlRYUQ0V2c3N1J1RHFuTE96dlFubUFr?=
 =?utf-8?B?RkI3dDZETU5ERXhrR3d0Ky9iRUhILzZoMmZHQm1ndnpsenFXK3luc1ZOK20r?=
 =?utf-8?B?dHlkUkNoUDBnYkxyQ3lIY3FBTXcrQjZSbjh4RTBSK2pLeHcwWVRheS91bEpY?=
 =?utf-8?B?QnlpWElxYXRjT3RCODVOcDd2RjNraitmbDdKTnk2NEwrbWJRbnVnOVUrRktB?=
 =?utf-8?B?ZnRiSDVFREFUUXczNzVweXJDVnAwMVJCQStITXV0b2dwazdkZmRUTWIxZUI2?=
 =?utf-8?B?eEp3SjNGMXNHcnBKUWsvVUU2WlBSREZ1aWNvUEJqUjBtQUxacWFmL3QzYi9z?=
 =?utf-8?B?YVVVMEdqSGsySGxCd05tUm9VT1c5eHUrTHRaaGNQT3FINHAzeUVIZ1luZHdL?=
 =?utf-8?B?ckpaUk5sLzl6ODFaMCtvSVNRMmRaK2FqVUF4QkFUVzlWYmo3VkhkSEJKQUNu?=
 =?utf-8?B?MGJUdEJGWVFHVnRNaXI0cS9IRCtIRGhPbC9YZkFFZmlqM2RjRXdFaVdQRS82?=
 =?utf-8?B?REM3dlVLRVVuQTF2eTRoYnE0T2lLU1AxYkxBK1EzVDhYZjdBTkdzR05Cd25t?=
 =?utf-8?B?YkpkTGRqTk5RWU5QRzlQcGtacEtKT0tTZ2RjcCtFSWVwQWpyMlFqUHZ2UW5u?=
 =?utf-8?B?VEV5UHg2SE1Kd2NGNjRZNWxibVZ3NTBQZ0VxMWk0b1JnTThrV0dYZzV4b3U5?=
 =?utf-8?B?b3ozK1dqZUFIM2VtVmVUd2VxWWQxT0MyRWxMcXdNWTd5bDFlUnNhYndWS3lp?=
 =?utf-8?B?WVZLQXlmc3VSekVPMFZHaVcyRDdpbSt5R0I2RldqbWM1elYrY3NYTVdpTVh2?=
 =?utf-8?B?QlhtWG8vdGF1L0pxWDRWNlNTM3o3RGV0ZVVva21KcnVqNkZSaEw0OVNaM0s4?=
 =?utf-8?B?cFRoWkNGWDJyOVlhSWt5dkc5Vlo2Yyt2OGIrOXJpOUsvY0wwR3dzSm9vTzJI?=
 =?utf-8?B?RzZ0THlDbmh4Y0JmWnJpQ1JxTmxUWDJCNXBCUTJ4SUplVGo5NndCa3lBbk01?=
 =?utf-8?B?Z3UrVFZmRm5nUDlRUU9DVlE0UHk3dzQrWUpsYkcxdjArZGZJMUVQcWdORGx5?=
 =?utf-8?Q?olnoEmRB6hcusETnPFohlcEEpPuNFG6QW/C2Heow7tuLL?=
X-MS-Exchange-AntiSpam-MessageData-1: dhZ/qs2HuY1k6A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 410846b4-3b56-4410-3688-08df362ecedb
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 02:37:57.9195 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ubgFdf+iq7eKQ+Z1IYVvlJA0lM+UNiOn1EjaEiy18SxOA7PciZN7crfZopuRyXMc9agyzCz42nim7z0lcF0bg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFD4454CAA9
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
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thursday, October 29, 2026 9:03=E2=80=AFPM Christoph Hellwig wrote:
> On Mon, Oct 26, 2026 at 06:19:25PM +0900, Mikko Perttunen wrote:
> > Robin suggested [1] that instead of teaching the legacy path about
> > groups, we should explore modernizing the 32-bit ARM DMA code a bit by
> > making it use domain cookies and have the core code own the domains, as
> > is the case on other architectures. Still, ARM's own DMA code is kept t=
o
> > support existing drivers and APIs that expect it, and because dma-iommu
> > is considered too big and unnecessary for 32-bit ARM.
>=20
> Now that the different domain handling is gone, what speaks against
> just using the generic dma-iommu code for arm32?
>=20
>=20

Copying Robin's comment --

> TBH I rather feel like the time for converting ARM to iommu-dma has=20
> passed - there are drivers which rely on specific behaviours of the ARM=20
> IOVA allocator which iommu-dma does not match, and meanwhile iommu-dma=20
> continues to grow more server-specific features which would be nothing=20
> but bloat on ARMv7 systems with <=3D2GB of RAM and no virtualisation. At=
=20
> this point I'm inclined to treat the existing DMA ops as legacy code=20
> like with alpha/sparc/etc.

Aside the bloat, it's indeed not a switch we could do in the short term=20
given all the platforms that rely on ARM32 specific APIs or behavior.=20
This series already opts out four platforms from just the default=20
domains and sashiko implies we need to add more to that list. There=20
could be an incremental path of removing existing hacky behavior and if=20
we manage that, eventually code sharing could be considered.

Mikko



