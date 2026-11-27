Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE89606A333
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 04:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Oj6YUZXS
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0DD7D10E8EC;
	Fri, 27 Nov 2026 04:16:16 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5C2B510E9A0
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 04:16:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m6kBGk+2yaUs2Uo75EP7EoeDFNg5D+1+mDXBZoB+7rj+MapXxlhM918cfBL9UPhxVZeF2mOaJ0YCGnb8Ca5I1x51b9PQOPYWPeaclo70l+syjnraQnDeh7DGS/RekymwkiYlyUMrLGSTdzfaqPEHugMhBA9JtCILHbOzW278V/1WLqPoREo+HgJg8e2i7GsuRzIZN3pXFb3T10cLyrIXpj+6SqAEdtpzUz1JU4ycbfzBEfV2CFPVpHihsju0BiyJzS9lEbty807kp2zuvKoeIdu/0qqIKuyC7LX+F2d/UeCFXlU7MWF5gaKB7CQNWTo9GFGk9wQWxTrHNy2LoCys5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dXhEJk/Jur0ZEZYH48KkkowpoRBO5sE/GD2SPVNOM/g=;
 b=kbkknUAwS9XAeY1ta+82ji9KR7gyycMHhfGRLqnzDnS311MtPVJvMphhW3MQRA7TTkKv4EkolbRxThwT9Ooau7zV7L/UZJ/eO6PzrxsxN5h5VzRKRsj7yWvf/o8lngXmZ5U2uMY6sxG4/5q8+MMH2gZQ10jh+hfCWKTPh+Pbj0BLa3PnYG+MMmCGU82c02lArImDmTw604AhMDdWD2es2XWtU6Z0TE3jBgLqAQceNekitgtmGa+LLr2HQWnRBq2FL2fyjOC5vidGGTO5C68SWPtATGEWfHPHZ1q9Tt4Sals71iwzHl4sn5WAX0nk+ZtY0yoDQZjolquegjByWIPY5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dXhEJk/Jur0ZEZYH48KkkowpoRBO5sE/GD2SPVNOM/g=;
 b=Oj6YUZXSSFdNpbnY78IhSAHH9ysYzpPPZsULix4XBvUcp1ixrA4GPcEN+1kN8BmLK4gGSzdanX5uBBA3sS80nTtBPNPa7Q02WQX7d5eDVmfsMMk0RE2IaLoWBi8dPZaaQGAU3bA63Vrjjt9uPeSsb3/oUyKc3guHc4sdWDwrqlirT3DyicQgwqdYKKULlVRQierNAeLxo/cr2qEAqAlVhmhePLeBvDkzXu3WgIp+2C+1jAaUna/6X1jtmtRvqQ7Y84McfBe9nCku64iJsIxomWZij44dB4l6flRMDqrLrTI3yHWz3rxvC9ZXrM8FVoBuQcxPTqGTzIierupGtMYJaA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CH3PR12MB8584.namprd12.prod.outlook.com (2603:10b6:610:164::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Fri, 27 Nov
 2026 04:16:04 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 04:16:04 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v8 01/12] drm: Add MIPI DBI bus support for MIPI DBI Type
 A and B
Date: Fri, 27 Nov 2026 13:16:00 +0900
Message-ID: <tWBq0CmbQN-l5IJnxter_A@nvidia.com>
In-Reply-To: <20261122081820.53199-2-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-2-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P286CA0038.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:2b2::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CH3PR12MB8584:EE_
X-MS-Office365-Filtering-Correlation-Id: 2239ff9e-e994-4248-0c08-08df4c3d2703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|10070799003|23010399003|7416014|376014|6133799003|18002099003|3023799007|22082099003|921020|56012099006|261022075727099003|4143699003|11063799006|261022113327099003|261026121527099003|261028144727099003|261021123027099003|261102123227099003|261026140227099003|261009223027099003|261021121427099003|261009221227099003|261022105027099003|261102130727099003|10067099003;
X-Microsoft-Antispam-Message-Info: cQNteqpulF4L6PTn4eoicKpyXfAo1Mzk4rKrjylqYIYdqdzcJ+0yAdCOodeNZo5PmNJ87ROVzJTXQaQC7vh14V7/YZsiCp+GaBE3UUTFNidK3tzPpvEEVP2IEfICbDFKIKu5YLnTkMVK6srolhLhrk517hmd/O2DbTKNuN0WwMtJMYlduhg/Ihck9423eYyffels3eZIVs5t8ni7RYyb+tOOQ3yxYxjTgXZcJRoQ+zO9e2pv3Y5eqlGrCDStuJhwZv73k1pAwE81BWav7Yk7UrXQW+uELLi5/hMKoCJXMHGih1xrNvWn6fu4SqufbL3A/PCCQtJXI0FcU7x7x8OWHTxKcqnalF1vZce6S49usX5qqgqnQSVEouHd4ZbI+UJToqDrsGXWE0NEWaqHJS5gI8TOZN/rBX8FGTeu0TFxqMTl4W4DdLoMZXDLDR5+1ZZUHgShcLiK+tRs1q4cGFOKNhnO4Ll1aX8QfplYLJ3zOrQ7rs4UIfgQPN86gozviJyAVdHE+DPyeHFs07Lv5UaTn7Cld11jUQZ/7TSHaUut43pdU7J2dGc2u82DI0NLukM/bXQqfqStZEPFbHzOEsUD1u4OoRoIKQHG9dXTfdkRZ5yKTl0Z3bN/8OD0AOSEIXmZXpvyR0k+2ffDhli1/weaEK35Y67uADVSD7YVpPj3xFgjFfGoARqkKyiBrAfJ7F6YH/pPIhyHTzP5l86tIoInCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(10070799003)(23010399003)(7416014)(376014)(6133799003)(18002099003)(3023799007)(22082099003)(921020)(56012099006)(261022075727099003)(4143699003)(11063799006)(261022113327099003)(261026121527099003)(261028144727099003)(261021123027099003)(261102123227099003)(261026140227099003)(261009223027099003)(261021121427099003)(261009221227099003)(261022105027099003)(261102130727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZDRhM0RhNnlVelFCSXhWTlR4U0RHZWFVT2ZWMVZEZUhMNEMxUE5FZnhJUTl3?=
 =?utf-8?B?eTlzWWxnUUVIL1JTNkVhNFJYMFJ0Ny83bWc0ZmZIbFlnUDRqazJmcG5rZnJG?=
 =?utf-8?B?RDgyYktucDNCYUpHK3h5a09FazBIb0lZWGFVOVpwVXZmZXZkRVB4M0JMMDgy?=
 =?utf-8?B?dzJyQms0NDRpY1E2Y1RVcE10WDA4a0pQVVBwaExkVWdPNkZVZHl6aDB1R0Vz?=
 =?utf-8?B?T29IUUpEVnN0clRrbWlZa25TaCtBRWJFY2FZRG50K0Fma25uSlNDRmNaUFFL?=
 =?utf-8?B?ZXVUbDh0ZzFvS2J6d3daR3F5YUtNQlhJRzhhUWI2UHQ5blA5d1Rva1ozblZO?=
 =?utf-8?B?RGE3TVRNSlg1b0o0ejlCcURqNjhFMVR1Y215MnZmSEtpcEpiTUxsNWoxT1Jo?=
 =?utf-8?B?Qnd4Zk1lb0FCMmMvRHZRU3h4OTUrdnJhM3JtRWprZFJmRXArVE1zUE5CWTRp?=
 =?utf-8?B?eUlzMjVTY2E1bFRCdGdDaXVjVDZDUisxeldVaWlublZZZXdpUFgzS1RYVjUv?=
 =?utf-8?B?TFJwSmljN2ZTRUZkZ09lRjVwZ0MwbGF5aExsMW96S3d5M2IwdWNndkZtclJr?=
 =?utf-8?B?SmxYb21MQndGSy9PbEZLOTYrbFYzRDJieVlCQXk0QnBzMEVJMFQrZy9sQnhv?=
 =?utf-8?B?bkhWeFQycng3RGQvSEhYa3Y3dVZ2TkxFUGVhZ0xRZUVsYTAwQWFBc0JSSTN3?=
 =?utf-8?B?ZjBxcjBmbWsxNUZhcFRBbERSeFljVVJyT1hPbjgzbEcvbno1Q2RJRmNibXRj?=
 =?utf-8?B?WW9ZK01oV0FVdi9LWjV4eEdBTlNoQitNaUk1NXBGb0RWU0lzZlZyNmw2VStI?=
 =?utf-8?B?eU42L2hjd3QxdlYvY1RnKy8zeXdPVWNnamJnaE9KU3MyQlF5MUdhK1J1cEo4?=
 =?utf-8?B?NHNubGI0UGNlZ1grcHRCODc2akwreXV4Y0dwblNCbU9DelUydHJXMmZHcDVV?=
 =?utf-8?B?enYyUm1wRTQ2b3hqVDdnYUU1UEFlbnJaZG5JR3RrNURUdHgwUis3VWZMNWh0?=
 =?utf-8?B?ejROTkIyVTJoVjY2UHdWYnhKUFYxbUNNRGgyVlFNS0VGWTFiVzZJenhOMGxS?=
 =?utf-8?B?VGZnSldKQzRoaGl3QVpFL0k2V1lJMlBEczAwWU0vNThBdlJmODhNVFNseEll?=
 =?utf-8?B?clNvL3gxTFNRemEzREdzREYxcWwxbDRYeGxBa1NBYm9ma0FVZ1IwN2hBY3V6?=
 =?utf-8?B?clJraU93cWFnaGh2UVVpU2hnVW1IT1Y2MEZHTW93QmlOdjhXR1pRdGc3YjBq?=
 =?utf-8?B?ZzY4aEVjZDFrMGNzampBZTdDMmk5bml1YzNwemgvb0djdGs3aUpSSXQxMFVX?=
 =?utf-8?B?TSttcXpOSmI2dWc5VU9Hd2FjZ2xzK0U4QktOOTc5Tzg3UHlNbnhVZHVoSmZr?=
 =?utf-8?B?M2h2ejNPenREanpjNFE3a1RuV2dLQk40ZFlENTdRdVh5dXc3Qmw4QmVUaWlS?=
 =?utf-8?B?T2k0MERoa3lzSHpmbEpQUVFQY2J1cnlTYkFRUm5vU1l5aXhuNHJLb2tSZUxo?=
 =?utf-8?B?T2lPV0hrUWxqT0tTb0FjQlNaRDd2SXcxZmxWcG01a1UxR3pBd2JabDJPRFQ2?=
 =?utf-8?B?TE5LQ245aHJGaXY2QjcwRTVIeTZGd3hSUEZrWTFlL3FhSGdIYU43dzBIYndC?=
 =?utf-8?B?dWp2aTZBZHRKN2ZSNFlzdHpZUTA2RkluWmFxay9VdFdWUmFBaFBwWHpDdEVC?=
 =?utf-8?B?bUdCcFRFamFhdW15SmZiTTdXa2owU2drMUZXYS9VWkxqV3dyekowdGRoZWI5?=
 =?utf-8?B?U3FHL3ptM3oxMHRYNzQyeG4rSkR3STBHblpZblNra2JvL2JzWjdlOUpsY21M?=
 =?utf-8?B?aEgwSzE2dEZOT254bGtBTW05ek85clZUNlU4elRwTjdNczJ1NVdIQ2JGN1hj?=
 =?utf-8?B?bTh5VUFkYWRIRjhVRWY0Nk1ULzlMeGJIU2l4VlFzUmFiUWdOSnhDUkFrZnlT?=
 =?utf-8?B?cmRiWWF1cFBxQlAzbVpPeDJpTGhxNEliZElBazNIWGYrT3d0WFF6YUFubHNz?=
 =?utf-8?B?enhSempCejRBRVdWWldYMG9HZGt3aElBeHRJcXJaNDQxeFpoQnZhN0xWMnNt?=
 =?utf-8?B?QlFzYjZaeUlvNDNTclpBaFE2TG5uSDlTLzl3MFMrUitFQURpeGRjV0hQVjg1?=
 =?utf-8?B?cEZhQmx5QXRmQXNmZnhOeFBxZ3IwdzhiRmlERnNjeXpsVTVvdUxRMEg1U0gv?=
 =?utf-8?B?d0VPekN3SmkyT0pUb3VjMFBOTHozTGhicnVWS2I2WEF4SXFTT2RvUG1vd0dB?=
 =?utf-8?B?WXlEMGlYQXJhUURUb0orRFNSSW81NVB0MERpcWw4aFZXNjE5MWdhQjUrRzdz?=
 =?utf-8?B?M1QvVUFjcGphbDR1QTY1RURXNVdjUmVlalZjVVJiQjY4S2NKZWVsbExDbmFs?=
 =?utf-8?Q?5noku/R5xdNUA0uRApjqAisXGeCKpuiSTfATc6urdoDzA?=
X-MS-Exchange-AntiSpam-MessageData-1: 313EXTQEkOalKQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2239ff9e-e994-4248-0c08-08df4c3d2703
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 04:16:04.2904 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kLz6lTqOjqUJjWJdM2BlZdRvdPCVtQFWhHpKbkVUgCUGoah07oyNYpCUzAzvflAMEXwMygjknIak3mwoJ3pmig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8584
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
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> The MIPI DBI bus allows modeling DBI hosts and peripherals using the Linu=
x
> driver model. DBI hosts are registered by their respective drivers. Durin=
g
> registration, DBI peripherals are created from the device tree nodes
> provided by the host.
>=20
> DBI hosts expose operations that can be used by peripheral drivers to
> access associated devices.
>=20
> This implementation adds support for MIPI DBI Type A and Type B only.
> Type C support existing in drm_mipi_dbi.c was not altered. The framework
> is modeled to closely resemble the existing MIPI DSI setup for seamless
> integration.
>=20
> Suggested-by: Mikko Perttunen <mperttunen@nvidia.com> # preliminary sketc=
h
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/Makefile           |   2 +-
>  drivers/gpu/drm/drm_mipi_dbi_bus.c | 287 +++++++++++++++++++++++++++++
>  include/drm/drm_mipi_dbi_bus.h     | 148 +++++++++++++++
>  3 files changed, 436 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/gpu/drm/drm_mipi_dbi_bus.c
>  create mode 100644 include/drm/drm_mipi_dbi_bus.h
>=20
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 2c6bc093a923a..880f0dc930b85 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -166,7 +166,7 @@ obj-$(CONFIG_DRM_KMS_HELPER) +=3D drm_kms_helper.o
> =20
>  obj-y			+=3D tests/
> =20
> -obj-$(CONFIG_DRM_MIPI_DBI) +=3D drm_mipi_dbi.o
> +obj-$(CONFIG_DRM_MIPI_DBI) +=3D drm_mipi_dbi.o drm_mipi_dbi_bus.o
>  obj-$(CONFIG_DRM_MIPI_DSI) +=3D drm_mipi_dsi.o
>  obj-y			+=3D arm/
>  obj-y			+=3D clients/
> diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/drm_mip=
i_dbi_bus.c
> new file mode 100644
> index 0000000000000..4b51de5bdf0b5
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_mipi_dbi_bus.c
> @@ -0,0 +1,287 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * MIPI DBI devices with command transport through parallel interface
> + *
> + * Copyright 2026 Mikko Perttunen <mperttunen@nvidia.com>
> + * Copyright 2026 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <linux/err.h>
> +#include <linux/init.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/slab.h>
> +
> +#include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_mipi_dbi_bus.h>
> +
> +/**
> + * DOC: overview
> + *
> + * There are three MIPI DBI implementation types:
> + *
> + * A. Motorola 6800-type parallel bus
> + *
> + * B. Intel 8080-type parallel bus
> + *
> + * C. SPI-type with three options:
> + *
> + *    1. 9-bit with the Data/Command signal as the ninth bit
> + *    2. Same as above, except it is sent as 16 bits
> + *    3. 8-bit with the Data/Command signal as a separate D/CX pin
> + *
> + * This library provides a framework for MIPI Display Bus Interface (DBI=
)
> + * compatible display controllers using Type A and Type B. This
> + * implementation closely matches existing DSI framework behavior to
> + * allow seamless integration.
> + *
> + * Type C options 1 and 3 are covered by drm_mipi_dbi.c with
> + * mipi_dbi_spi_init().
> + */
> +
> +static int mipi_dbi_match(struct device *dev, const struct device_driver=
 *driver)
> +{
> +	return of_driver_match_device(dev, driver);
> +}
> +
> +static int mipi_dbi_uevent(const struct device *dev, struct kobj_uevent_=
env *env)
> +{
> +	return of_device_uevent_modalias(dev, env);
> +}
> +
> +static const struct dev_pm_ops mipi_dbi_device_pm_ops =3D {
> +	.runtime_suspend =3D pm_generic_runtime_suspend,
> +	.runtime_resume =3D pm_generic_runtime_resume,
> +	.suspend =3D pm_generic_suspend,
> +	.resume =3D pm_generic_resume,
> +	.freeze =3D pm_generic_freeze,
> +	.thaw =3D pm_generic_thaw,
> +	.poweroff =3D pm_generic_poweroff,
> +	.restore =3D pm_generic_restore,
> +};
> +
> +static const struct bus_type mipi_dbi_bus_type =3D {
> +	.name =3D "mipi-dbi",
> +	.match =3D mipi_dbi_match,
> +	.uevent =3D mipi_dbi_uevent,

These two callbacks are just direct wrappers so I believe we should be=20
able to set them to of_driver_match_device / of_device_uevent_modalias=20
directly.

> +	.pm =3D &mipi_dbi_device_pm_ops,

I think we can drop setting .pm as well. These callbacks will fall back=20
to the same code (driver callbacks) if we don't set the bus PM ops.

> +};
> +
> +static void mipi_dbi_device_release(struct device *dev)
> +{
> +	of_node_put(dev->of_node);
> +	kfree(to_mipi_dbi_device(dev));
> +}
> +
> +static void mipi_dbi_device_unregister(void *data)
> +{
> +	struct device *dev =3D data;
> +
> +	of_node_clear_flag(dev->of_node, OF_POPULATED);
> +	device_unregister(dev);
> +}
> +
> +/**
> + * devm_mipi_dbi_device_register() - create a managed peripheral MIPI DB=
I
> + *				     Type A or B device.
> + * @dev: device to tie the MIPI-DBI device lifetime to
> + * @host: DBI host to which this device is connected
> + * @np: device tree node associated with the panel MIPI DBI device
> + *
> + * This function is called by DBI host driver to create panel device.
> + * It automatically calls mipi_dbi_device_unregister() when @dev is
> + * unbound. It does not automatically free passed device node pointer,
> + * it must be put manually.
> + *
> + * Returns:
> + * A pointer to the newly created MIPI DBI device, or, a pointer encoded
> + * with an error.

For brevity, I would just use 'an error pointer'.

> + */
> +struct mipi_dbi_device *
> +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_host *=
host,
> +			      struct device_node *np)
> +{
> +	struct mipi_dbi_device *dbidev;
> +	int ret;
> +
> +	if (!host || !host->dev || !host->dbi || !host->dbi->command ||
> +	    !host->ops || !host->ops->attach || !host->ops->detach || !np)
> +		return ERR_PTR(-EINVAL);
> +
> +	if (!of_device_is_available(np))
> +		return ERR_PTR(-ENODEV);
> +
> +	dbidev =3D kzalloc_obj(*dbidev);
> +	if (!dbidev)
> +		return ERR_PTR(-ENOMEM);
> +
> +	if (of_node_test_and_set_flag(np, OF_POPULATED)) {
> +		kfree(dbidev);
> +		return ERR_PTR(-EBUSY);
> +	}
> +
> +	dbidev->host =3D host;
> +	dbidev->dbi =3D host->dbi;
> +	device_initialize(&dbidev->dev);
> +	dbidev->dev.parent =3D host->dev;
> +	dbidev->dev.bus =3D &mipi_dbi_bus_type;
> +	dbidev->dev.release =3D mipi_dbi_device_release;
> +	device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np)));
> +
> +	ret =3D dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev), np->fu=
ll_name);
> +	if (ret)
> +		goto put_device;
> +
> +	ret =3D device_add(&dbidev->dev);
> +	if (ret)
> +		goto put_device;
> +
> +	ret =3D devm_add_action_or_reset(dev, mipi_dbi_device_unregister,
> +				       &dbidev->dev);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	return dbidev;
> +
> +put_device:
> +	of_node_clear_flag(np, OF_POPULATED);
> +	put_device(&dbidev->dev);
> +	return ERR_PTR(ret);
> +}
> +EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);
> +
> +static void mipi_dbi_detach(void *data)
> +{
> +	struct mipi_dbi_device *dbidev =3D data;
> +
> +	dbidev->host->ops->detach(dbidev->host, dbidev);
> +	dbidev->attached =3D false;
> +}
> +
> +/**
> + * devm_mipi_dbi_attach() - managed attach of peripheral DBI device to i=
ts MIPI
> + *			    DBI Type A or B devices.
> + * @dev: device to tie the MIPI-DBI device lifetime to
> + * @dbidev: DBI peripheral

Add a return value description. Otherwise inevitably someone will send=20
an autogenerated oneline fix to add it.

> + */
> +int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device *dbi=
dev)
> +{
> +	int ret;
> +
> +	if (dbidev->attached)
> +		return -EBUSY;
> +
> +	ret =3D dbidev->host->ops->attach(dbidev->host, dbidev);
> +	if (ret)
> +		return ret;
> +
> +	dbidev->attached =3D true;
> +	return devm_add_action_or_reset(dev, mipi_dbi_detach, dbidev);
> +}
> +EXPORT_SYMBOL_GPL(devm_mipi_dbi_attach);
> +
> +/**
> + * mipi_dbi_write_buffer_multi() - mipi_dbi_command() w/ accum_err but f=
or
> + *				   MIPI DBI Type A and B
> + * @ctx: context for multiple DBI transactions
> + * @cmd: command to be sent
> + * @data: buffer containing data to be transmitted
> + * @len: size of transmission buffer
> + *
> + * Acts like mipi_dbi_command() for MIPI DBI Type C but for Types A and =
B
> + * and deals with errors in a way that makes it convenient to make sever=
al
> + * calls in a row.
> + */
> +void mipi_dbi_write_buffer_multi(struct mipi_dbi_multi_context *ctx,
> +				 u8 cmd, const u8 *data, size_t len)
> +{
> +	struct mipi_dbi_device *dbidev =3D ctx->dbidev;
> +	struct device *dev =3D &dbidev->dev;
> +	ssize_t ret;

mipi_dbi_command_stackbuf returns an int, so this can be an int as well.

> +
> +	if (ctx->accum_err)
> +		return;
> +
> +	ret =3D mipi_dbi_command_stackbuf(dbidev->dbi, cmd, data, len);
> +	if (ret < 0) {
> +		ctx->accum_err =3D ret;
> +		dev_err(dev, "sending dcs data %*ph failed: %d\n",
> +			(int)len, data, ctx->accum_err);
> +	}
> +}
> +EXPORT_SYMBOL(mipi_dbi_write_buffer_multi);
> +
> +static int mipi_dbi_drv_probe(struct device *dev)
> +{
> +	struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver);
> +	struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> +
> +	return drv->probe(dbidev);
> +}
> +
> +static int mipi_dbi_drv_remove(struct device *dev)
> +{
> +	struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver);
> +	struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> +
> +	drv->remove(dbidev);
> +
> +	return 0;
> +}
> +
> +static void mipi_dbi_drv_shutdown(struct device *dev)
> +{
> +	struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver);
> +	struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> +
> +	drv->shutdown(dbidev);
> +}

This could be simplified slightly by making these (probe, remove,=20
shutdown) bus-level callbacks (set on mipi_dbi_bus_type). Then the=20
callback assignments in __mipi_dbi_driver_register are not needed. The=20
'if's do have to move into the bus-level callbacks. This also cleans up=20
the remove callback return type.

> +
> +/**
> + * __mipi_dbi_driver_register() - register a driver for MIPI DBI Type A =
or B devices.
> + * @drv: DBI driver structure
> + * @owner: owner module
> + *
> + * Return: 0 on success or a negative error code on failure.
> + */
> +int __mipi_dbi_driver_register(struct mipi_dbi_driver *drv, struct modul=
e *owner)
> +{
> +	drv->driver.bus =3D &mipi_dbi_bus_type;
> +	drv->driver.owner =3D owner;
> +
> +	if (drv->probe)
> +		drv->driver.probe =3D mipi_dbi_drv_probe;
> +	if (drv->remove)
> +		drv->driver.remove =3D mipi_dbi_drv_remove;
> +	if (drv->shutdown)
> +		drv->driver.shutdown =3D mipi_dbi_drv_shutdown;
> +
> +	return driver_register(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(__mipi_dbi_driver_register);
> +
> +/**
> + * mipi_dbi_driver_unregister() - unregister a driver for MIPI DBI Type =
A or B devices.
> + * @drv: DBI driver structure
> + */
> +void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv)
> +{
> +	driver_unregister(&drv->driver);
> +}
> +EXPORT_SYMBOL_GPL(mipi_dbi_driver_unregister);
> +
> +static int __init mipi_dbi_bus_init(void)
> +{
> +	return bus_register(&mipi_dbi_bus_type);
> +}
> +subsys_initcall(mipi_dbi_bus_init);
> +
> +static void __exit mipi_dbi_bus_exit(void)
> +{
> +	bus_unregister(&mipi_dbi_bus_type);
> +}
> +module_exit(mipi_dbi_bus_exit);
> +
> +MODULE_DESCRIPTION("MIPI DBI devices with command transport through para=
llel interface");
> +MODULE_LICENSE("GPL");
> diff --git a/include/drm/drm_mipi_dbi_bus.h b/include/drm/drm_mipi_dbi_bu=
s.h
> new file mode 100644
> index 0000000000000..6f00a8eef9c67
> --- /dev/null
> +++ b/include/drm/drm_mipi_dbi_bus.h
> @@ -0,0 +1,148 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * MIPI DBI devices with command transport through parallel interface
> + *
> + * Copyright 2026 Mikko Perttunen <mperttunen@nvidia.com>
> + * Copyright 2026 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#ifndef __DRM_MIPI_DBI_BUS_H__
> +#define __DRM_MIPI_DBI_BUS_H__
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +
> +struct device_node;
> +struct mipi_dbi;
> +struct mipi_dbi_device;
> +struct mipi_dbi_host;
> +
> +/**
> + * struct mipi_dbi_host_ops - DBI bus operations for MIPI DBI Type A and=
 B.
> + * @attach: attach DBI device to DBI host
> + * @detach: detach DBI device from DBI host
> + */
> +struct mipi_dbi_host_ops {
> +	int (*attach)(struct mipi_dbi_host *host, struct mipi_dbi_device *dev);
> +	void (*detach)(struct mipi_dbi_host *host, struct mipi_dbi_device *dev)=
;
> +};
> +
> +/**
> + * struct mipi_dbi_host - DBI host device for MIPI DBI Type A and B.
> + * @dev: driver model device node for this DBI host
> + * @dbi: MIPI DBI interface
> + * @ops: DBI host operations
> + */
> +struct mipi_dbi_host {
> +	struct device *dev;
> +	struct mipi_dbi *dbi;
> +	const struct mipi_dbi_host_ops *ops;
> +};
> +
> +/**
> + * struct mipi_dbi_device - DBI peripheral device for MIPI DBI Type A an=
d B.
> + *			    This structure describes a peripheral DBI device,
> + *			    an endpoint for DSC commands and video data, and must

DCS commands

> + *			    be paired with a DBI host device for MIPI DBI Type A
> + *			    and B. This layout is built to closely resemble
> + *			    the DSI framework.
> + *
> + *			    If your device is MIPI DBI Type C (with an SPI
> + *			    control bus) and incorporates DBI within, you
> + *			    should use the mipi_dbi_dev structure and Type C
> + *			    framework from drm_mipi_dbi.c.

I don't think we need to talk about the DSI or Type C frameworks here.=20
drm_mipi_dbi.c already mentions it's for Type C.

> + * @dev: driver model device node for this peripheral
> + * @dbi: MIPI DBI interface
> + * @host: DBI host for this peripheral
> + * @attached: the DBI device has been successfully attached
> + */
> +struct mipi_dbi_device {
> +	struct device dev;
> +	struct mipi_dbi *dbi;
> +	struct mipi_dbi_host *host;
> +	bool attached;
> +};
> +
> +/**
> + * struct mipi_dbi_multi_context - Context to call multiple MIPI DBI fun=
cs in a row
> + * @dbidev: Pointer to the peripheral MIPI DBI Type A and B device
> + * @accum_err: Storage for the accumulated error over the multiple calls
> + *	       Init to 0. If a function encounters an error then the error co=
de
> + *	       will be stored here. If you call a function and this points to=
 a
> + *	       non-zero value then the function will be a noop. This allows c=
alling
> + *	       a function many times in a row and just checking the error at =
the
> + *	       end to see if any of them failed.
> + */
> +
> +struct mipi_dbi_multi_context {
> +	struct mipi_dbi_device *dbidev;
> +	int accum_err;
> +};
> +
> +#define to_mipi_dbi_device(__dev)	container_of_const(__dev, struct mipi_=
dbi_device, dev)
> +
> +void mipi_dbi_write_buffer_multi(struct mipi_dbi_multi_context *ctx,
> +				 u8 cmd, const u8 *data, size_t len);
> +
> +/**
> + * mipi_dbi_write_seq_multi() - transmit a command with payload
> + *
> + * This macro will print errors for you and error handling is optimized =
for
> + * callers that call this multiple times in a row.
> + *
> + * @ctx: context for multiple DBI transactions
> + * @cmd: command to be sent
> + * @seq: buffer containing data to be transmitted
> + */
> +#define mipi_dbi_write_seq_multi(ctx, cmd, seq...)				\
> +	do {									\
> +		static const u8 d[] =3D { seq };					\
> +		mipi_dbi_write_buffer_multi(ctx, cmd, d, ARRAY_SIZE(d));	\
> +	} while (0)
> +
> +struct mipi_dbi_device *
> +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_host *=
host,
> +			      struct device_node *np);
> +int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device *dbi=
dev);
> +
> +/**
> + * struct mipi_dbi_driver - DBI driver for MIPI DBI Type A and B.
> + * @driver: device driver model driver
> + * @probe: callback for device binding
> + * @remove: callback for device unbinding
> + * @shutdown: called at shutdown time to quiesce the device
> + */
> +struct mipi_dbi_driver {
> +	struct device_driver driver;
> +	int (*probe)(struct mipi_dbi_device *dbi);
> +	void (*remove)(struct mipi_dbi_device *dbi);
> +	void (*shutdown)(struct mipi_dbi_device *dbi);
> +};
> +
> +static inline struct mipi_dbi_driver *
> +to_mipi_dbi_driver(struct device_driver *driver)
> +{
> +	return container_of(driver, struct mipi_dbi_driver, driver);
> +}
> +
> +static inline void *mipi_dbi_get_drvdata(const struct mipi_dbi_device *d=
bi)
> +{
> +	return dev_get_drvdata(&dbi->dev);
> +}
> +
> +static inline void mipi_dbi_set_drvdata(struct mipi_dbi_device *dbi, voi=
d *data)
> +{
> +	dev_set_drvdata(&dbi->dev, data);
> +}
> +
> +int __mipi_dbi_driver_register(struct mipi_dbi_driver *drv, struct modul=
e *owner);
> +void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv);
> +
> +#define mipi_dbi_driver_register(driver) \
> +	__mipi_dbi_driver_register(driver, THIS_MODULE)
> +
> +#define module_mipi_dbi_driver(__mipi_dbi_driver) \
> +	module_driver(__mipi_dbi_driver, mipi_dbi_driver_register, \
> +			mipi_dbi_driver_unregister)
> +
> +#endif /* __DRM_MIPI_DBI_BUS__ */

__DRM_MIPI_DBI_BUS_H__

> --=20
> 2.53.0
>=20
>=20




