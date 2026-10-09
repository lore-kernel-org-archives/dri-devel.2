Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D4C7CA6012
	for <dri-devel@archiver.kernel.org>; Fri,  9 Oct 2026 09:00:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 659C210E570;
	Fri,  9 Oct 2026 09:00:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="bJKFCwf4";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011020.outbound.protection.outlook.com [52.101.52.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9A1A310E570
 for <dri-devel@lists.freedesktop.org>; Fri,  9 Oct 2026 09:00:07 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V1AJHVPSN0jTeW9R9FrLhsiOB1yll0EwCsaxHANuveqxuZLiJWeIgVe4aITXbCKg2yJ6DchhwzjRn7YJk91q8FxU9+ilLuJpYPd5vjiiwbyM4eS1YovucOiMLwAyI785xxgkFOEsae6MpdstvW2qHbNpRZ5rqochlfDe0dKpW5kmoq6g5f73BlLOMdvkq6AXNB6mNdyUMZnxmgaIgbgb19Ivs3lUOJs/Jx8HxYulLway6Zu/Q7t4chqFZulL61PbW0yUD1EAEzA5N9EWlpYZ+o4p1Kvp6k33tErRbT1pwyPJFmPPEUS+6N3uAiHTkieIOotTlcI8pi0j1SYL8LYFrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WKP6hWqvA1ANPoR9JseBjZcYnhWNVlAhZ2KmcjEPjZc=;
 b=S/9mbA0G4yCi2NZBtpz9PIdwDVX72IZRrb+TyIo17MtvylX7kSZGrCOtZOogiNyOL/NLg6MuzZvz4riUTAIyLj+mn/thZjuIW3zervvSelxk+JcNeOJgCHoCdOjC2bYm5Nsfn3b6cD/7UIjcxVYJHtxs4Gd1n613qltjuYdRfs168Rff1Jah7jOYMJbmvUulqJY8/11/Bwrp+v0Cpav44RNKRmzFUVWkBoIgH/hPHj8S39H++f6hgWCVf536YwdJgikH5ZkrWvA0S5BS/tLzufPcufhBmrG2iF3yh9egZjH0BzTAGUw/So+8lJu6My4QtzC+Gcxh40vIdAa395O1wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WKP6hWqvA1ANPoR9JseBjZcYnhWNVlAhZ2KmcjEPjZc=;
 b=bJKFCwf4wcbcl58lFSU8YBO6FwQgYmpxyuCRLKD0HIfa+lymWKBZNj32nbJhOisEVk+fwQLo7FCUy4EOfvIXbcGkqk6FvLdhAAGZKMeoX+dfmn7DW81cnON9BLyR0Nzwy/2KoV89Uk5/YuCaK+333koJvYC1VTeFtsbW+Umn06P3XnLDV9Om/G9o2YO28uZxCNjAV9uJg4G87LMJ6jH4S9SqUI/YF6sZJ5Yrzw9L4JubCkhGQSLQoV/gov7wV7rtyvG9DaBmPcOy8mNdzzMGlOZkWkflccTLtk1CakEsNEKg8wbqdM+et+knazdFdUS2BfZ1NqVdKAhi11Rs8F9hbw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM4PR12MB5841.namprd12.prod.outlook.com (2603:10b6:8:64::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Fri, 9 Oct
 2026 09:00:03 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 09:00:02 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, webgeek1234@gmail.com
Cc: dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH 1/2] drm/tegra: Support swapping chroma planes
Date: Fri, 09 Oct 2026 17:59:32 +0900
Message-ID: <qEporZZOT_abKwO4JObFpQ@nvidia.com>
In-Reply-To: <20261008-tegra-drm-yvu420-v1-1-dc1c443c00f3@gmail.com>
References: <20261008-tegra-drm-yvu420-v1-0-dc1c443c00f3@gmail.com>
 <20261008-tegra-drm-yvu420-v1-1-dc1c443c00f3@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6PR01CA0016.jpnprd01.prod.outlook.com
 (2603:1096:405:3bb::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM4PR12MB5841:EE_
X-MS-Office365-Filtering-Correlation-Id: d0cba699-e372-427b-e6c9-08df25e3b470
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|10070799003|366016|1800799024|11063799006|56012099006|4143699003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: M1c2t2pTppNXhEW0cAu/X+i7a3tLS/EPo2jxgmBrI4QXgroViVuxmrZGnPEf6YCT+BmmCj0do3dIP101+vjDQDpbfBSUFMceLvZfmATbStX7od3h+lcUF4sWUDjqXt1vMD5IrSF06H3ReqAhhEQ/uyeJZl2Dz0ryA8KTRYuUAZV77ax9bbFZICn2MUrWwoqJioWKM4ZW958D4ZCvDpaPDwI6iPAfF66ksaiGd9eX7YRAHpxT0c9Mr39WCr8/sL9G/hrNRL2XFDVl4Q/cj4h9zQozDRu4UP4ckeefE42QAl/cv0qw6/PqZYVlLmL/R/nPSRqqmSsSZ+RQ4MurIyyzGtAkFxFRKtI37zhjNqOzZKYRnYYEPZklj6qTKVIhw1pKBK9FysaSXqslsn0gFVB5qO5/EmhisoWj1nUNp+sEDv/FNaUsGzObCNprN5zoxGknDbLzRey//psUgSQNac6uWZnIybEhhvYmDBOp1OM7iLQZvM+CqIhvwMhumGUDl37ekoTBA/KbvAFS18s/qQx9fkhZtwHj4yt5GP59rvU1GzEn0LfWmCVsWJb91daMHFiLb2octu16dCy8JMxVDXKFTZfnGITou/pHmK9a7XNKym6uu8H6uqJbzpYWsrrIeOeaqxKrQVUTOBrZcUtBuHjKVD28rX8EqONEMQLVOEBEACw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(10070799003)(366016)(1800799024)(11063799006)(56012099006)(4143699003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UTU2aGVLUHZOZHR1WGZYV0NGNEdpTFlTUUN0MkI4Y2cvUlpyUlRzaFpGNXBq?=
 =?utf-8?B?cmVHU2VjK3ZQdHkxLzV4OFlwcWNJMUxJMWszWlhYQzdkZnR5dDl5d3VGZVhS?=
 =?utf-8?B?SEtOams2a2dxYjBMUzZrU2MxdTJzSzBZQmNWbEpFT1Q5eEpzQjJpKzVRenNY?=
 =?utf-8?B?U0M4Tm14ZW9QeklPTXFQUnJRN2c0YUNuOWRmMHVhNlNlaWNZZHZiVmZ6dUFS?=
 =?utf-8?B?cmNyUjRkMk5pMk1kRTEvdUE1WEpNamlWcXBvTDNTRGlQdnNFdk9oWmU0TnFs?=
 =?utf-8?B?a0twcUdtVjY1Vy9Mekx3MjBkRVp4eUI2d3ZOc2pjQ2NGaEJJdjRYaGEwWGNG?=
 =?utf-8?B?ZjQzZlRIcE5URG9OK1ZmWjlCY0pGTXdhWkt3ckI1WHZ0T2NoNlJ1dUFFdGsv?=
 =?utf-8?B?TGRBQ3ByalBrS0Z6R3VodzdJd2p0TnpqQUo1RmNWT1czWE9waW5FaE9STmNC?=
 =?utf-8?B?Ry9rRXk4VzFYNU9ZOWg3TGFRbDByMXdSOTRoUU9VcHBqMis4Y1RFdzVlVWRK?=
 =?utf-8?B?RXdPWjNWWXZtblJGSE1uK2o3TEpZVWRlTUlndWJhZjA1OHB5R1kvMktpZVJ5?=
 =?utf-8?B?MXE4SElVcXpSblRHM241RUdMWlorU1BBNk9CODhNWUlVY1lJdHprS1BhUkRl?=
 =?utf-8?B?NThLRk1oUDR1WCtzK0ZzSUVWNS9BWkJwMjVuakRQVVhhRUlFQm9FeFBRS3FZ?=
 =?utf-8?B?ZGovMjduUW5VQ0E2VkVmT3hmcjZNbW84MmE2N3g2cGJXRzV3c2g3bEFsSmxG?=
 =?utf-8?B?cjhiTUxvSk05eXRQeFlXTmVLZWlqcjE3cVR3eWZQaG5mcVNkWkJRaEZTSUlJ?=
 =?utf-8?B?bTFXaDNabVo0bzRnMlVoYzF3bHRFQ1ZLNlEzSElKY016c2lRY0Q5VWtsUmUy?=
 =?utf-8?B?eWxyU3dTZjN6c2JtcEZoOHBJa2x3Z3J3a3ZRbEFjaVQrTTBON3UxUXluV1dZ?=
 =?utf-8?B?WGY4a2huZEg1WHNsSm12Zm11YktvaHdTV2hETzNsSGdHbGNmRHFhOHZ5TzBv?=
 =?utf-8?B?MHBWUmZhSTVET1QrZXhJKzQvWGM5NHMyZVYvR01ud1V4UUtiS000cEoyYmtp?=
 =?utf-8?B?MzZ0MHFuQ1p2aENncTdjdmpVbWJaUEJmMHpRUmRJZnUwOFM5S2pJTjhZSHJL?=
 =?utf-8?B?N1poajFVUnlxeDVjcGtuSTV4dTUreWNCYVFYTkVOQkJSUlNJYXYyb2RHNEN0?=
 =?utf-8?B?MTc1cjZlNUl0M0JiTTIxVnJWaEpCN3ZmTTRvMnBXSjJKN09JZTdqU3BXdEhp?=
 =?utf-8?B?R1ovSlFlMStTQy9uU20rUjFubS9teHB0QWpqZTExKzJEbFQ1QWlYb2Z0SGh0?=
 =?utf-8?B?TW1taUREamxZWWpWdDVRRkVNQm1uaVAyL1pJNmlrRm1Ka1FMaHlPNUg1Vmh3?=
 =?utf-8?B?L1l4RWh5TW5tQUtRYzladS96Z05sLzZvVzFzaXEwa3lDU2E5TWljblhNdzVa?=
 =?utf-8?B?bkJWVUEybVR2aGtWUStuNTNka3hYV2VpZ3IzalBvTWJ3Y3JYM01HV3YwUnlR?=
 =?utf-8?B?Mm1EcnlDb0htaFZYQkZ1M2RNaU9TR3dlNitPaFJDazBYY3pKRXF1UHQxQW02?=
 =?utf-8?B?SEo4K2liRnRialllUitLTTdEbFRER1FMb1hraURVSW9RS2tDVHc2TDRJbUpB?=
 =?utf-8?B?TXRMM29QT3N3Q0M4Vko2UXQrQytSbzBVSU1TN0Rud3Nqc1dMS0g5bG13OTR0?=
 =?utf-8?B?M1hqRGlsQ2RSRWNRRHM2NXYzc0g3RFlVQUttdXZOb1puNmE3VzlCcWh0NUFM?=
 =?utf-8?B?VnVGU1dScGlQVXQweDhjUFMxU203ZEVWdHpVczRHTnJBOTF5TGdVZFZBWjc5?=
 =?utf-8?B?VkNONnJQb0tnNHgvaFNaSTdERmdtNjJMK1d1TXF0YUFDaW9pZDhnTU4xQTY5?=
 =?utf-8?B?cm9FeE10Znc3VUFnU1Nabk5jUTQxeFBFeUdMN1VucUhaRlNNRS85Mm0wUzVO?=
 =?utf-8?B?YU90dk5tcWJEd3VVQitRSnEvNXQveWp6V2tuUVRMVGRsNVN6MW8xdDVkM3VU?=
 =?utf-8?B?Yy9ENjNIZWFwYVBkR3ZvV1hZQlBia09qVkZPK042aG1JMDhOY09oa3pNQ1Z5?=
 =?utf-8?B?MGNyRWl6T0swcTM1WXVjV3VBaHdjYnJCbEdyWDFRaFhWQmJlckV6OHl2alFi?=
 =?utf-8?B?R3RxREhEYk15TVRENXVRUUE5TDVwYTNGUmNBd0pldUNSM2RybDZuWFRQSC9r?=
 =?utf-8?B?VjRBZTZiMzREUnZJYXo0SllVaE1ZTjNMU0pIWjdIVkl6QkU2V2VjTjNWSFFN?=
 =?utf-8?B?U2FkMituNTdvVXVuTzE0SXNKSDhBU05kR3MrcG9CNVk2UEFCUjBQdHp1ektM?=
 =?utf-8?B?dk9pb0hYOG1DRm9hSVU5WHJ2S0xRTDJzVGJZR1ZrTlBpZXdJS2IyZENMdXBZ?=
 =?utf-8?Q?zpUYsmGor3FxYWWYoBQ0vtOZzR2cVYuXCs8yuB83pNnH8?=
X-MS-Exchange-AntiSpam-MessageData-1: Nd1lJ1HupYF0eQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cba699-e372-427b-e6c9-08df25e3b470
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 09:00:02.7153 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fU3f6OjjTpFqAhFCagWuxtm9Aq1nhiAQYSv1ySfPkZbQ7YQzirTjXt2KMJDY+07esy/TmXrZliZBh8gmW595EA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5841
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

On Friday, October 9, 2026 5:57=E2=80=AFAM Aaron Kling via B4 Relay wrote:
> From: Aaron Kling <webgeek1234@gmail.com>
>=20
> The Tegra display controller supports some yuv types, but not their
> chroma swapped variants. For example, yuv420 is supported but yvu420 is
> not. This can be efficiently worked around by just passing the hardware
> said chroma planes backwards. Add a flag to the plane state struct and
> handling to both tegradc and nvdisplay paths.
>=20
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dc.c    | 17 ++++++++++++-----
>  drivers/gpu/drm/tegra/hub.c   | 14 +++++++++-----
>  drivers/gpu/drm/tegra/plane.c |  4 +++-
>  drivers/gpu/drm/tegra/plane.h |  3 ++-
>  4 files changed, 26 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index b0bfa946e6979..76d3841a17b8b 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -444,7 +444,8 @@ tegra_plane_use_vertical_filtering(struct tegra_plane=
 *plane,
>  }
> =20
>  static void tegra_dc_setup_window(struct tegra_plane *plane,
> -				  const struct tegra_dc_window *window)
> +				  const struct tegra_dc_window *window,
> +				  struct tegra_plane_state *tegra_plane_state)
>  {
>  	unsigned h_offset, v_offset, h_size, v_size, h_dda, v_dda, bpp;
>  	struct tegra_dc *dc =3D plane->dc;
> @@ -510,10 +511,13 @@ static void tegra_dc_setup_window(struct tegra_plan=
e *plane,
>  	tegra_plane_writel(plane, window->base[0], DC_WINBUF_START_ADDR);
> =20
>  	if (yuv && planes > 1) {
> -		tegra_plane_writel(plane, window->base[1], DC_WINBUF_START_ADDR_U);
> +		uint8_t u =3D tegra_plane_state->swap_uv ? 2 : 1;
> +		uint8_t v =3D tegra_plane_state->swap_uv ? 1 : 2;
> +
> +		tegra_plane_writel(plane, window->base[u], DC_WINBUF_START_ADDR_U);
> =20
>  		if (planes > 2)
> -			tegra_plane_writel(plane, window->base[2], DC_WINBUF_START_ADDR_V);
> +			tegra_plane_writel(plane, window->base[v], DC_WINBUF_START_ADDR_V);
> =20
>  		value =3D window->stride[1] << 16 | window->stride[0];
>  		tegra_plane_writel(plane, value, DC_WIN_LINE_STRIDE);
> @@ -740,7 +744,8 @@ static int tegra_plane_atomic_check(struct drm_plane =
*plane,
> =20
>  	err =3D tegra_plane_format(new_plane_state->fb->format->format,
>  				 &plane_state->format,
> -				 &plane_state->swap);
> +				 &plane_state->swap,
> +				 &plane_state->swap_uv);
>  	if (err < 0)
>  		return err;
> =20
> @@ -871,8 +876,10 @@ static void tegra_plane_atomic_update(struct drm_pla=
ne *plane,
>  		if (i < 2)
>  			window.stride[i] =3D fb->pitches[i];
>  	}
> +	if (tegra_plane_state->swap_uv)
> +		window.stride[1] =3D fb->pitches[2];

Based on the comment above, U and V have the same stride, so this
isn't required.

> =20
> -	tegra_dc_setup_window(p, &window);
> +	tegra_dc_setup_window(p, &window, tegra_plane_state);

Instead of passing the plane state, I'd just add a

  swap(window.base[1], window.base[2]);

here.

Otherwise looks good to me! I also tested on AGX Xavier.

Mikko

>  }
> =20
>  static const struct drm_plane_helper_funcs tegra_plane_helper_funcs =3D =
{
> diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.c
> index 448f49f3a7d7e..6427155ac4fdf 100644
> --- a/drivers/gpu/drm/tegra/hub.c
> +++ b/drivers/gpu/drm/tegra/hub.c
> @@ -440,7 +440,8 @@ static int tegra_shared_plane_atomic_check(struct drm=
_plane *plane,
> =20
>  	err =3D tegra_plane_format(new_plane_state->fb->format->format,
>  				 &plane_state->format,
> -				 &plane_state->swap);
> +				 &plane_state->swap,
> +				 &plane_state->swap_uv);
>  	if (err < 0)
>  		return err;
> =20
> @@ -664,24 +665,27 @@ static void tegra_shared_plane_atomic_update(struct=
 drm_plane *plane,
>  	tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE);
> =20
>  	if (yuv && planes > 1) {
> -		base =3D tegra_plane_state->iova[1] + fb->offsets[1];
> +		uint8_t u =3D tegra_plane_state->swap_uv ? 2 : 1;
> +		uint8_t v =3D tegra_plane_state->swap_uv ? 1 : 2;
> +
> +		base =3D tegra_plane_state->iova[u] + fb->offsets[u];
>  		base |=3D addr_flag;
> =20
>  		tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_START_ADDR_HI_U);
>  		tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_START_ADDR_U);
> =20
>  		if (planes > 2) {
> -			base =3D tegra_plane_state->iova[2] + fb->offsets[2];
> +			base =3D tegra_plane_state->iova[v] + fb->offsets[v];
>  			base |=3D addr_flag;
> =20
>  			tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_START_ADDR_HI_V)=
;
>  			tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_START_ADDR_V);
>  		}
> =20
> -		value =3D PITCH_U(fb->pitches[1]);
> +		value =3D PITCH_U(fb->pitches[u]);
> =20
>  		if (planes > 2)
> -			value |=3D PITCH_V(fb->pitches[2]);
> +			value |=3D PITCH_V(fb->pitches[v]);
> =20
>  		tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE_UV);
>  	} else {
> diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/plane.=
c
> index 2148b0c59815c..f4feec62ac023 100644
> --- a/drivers/gpu/drm/tegra/plane.c
> +++ b/drivers/gpu/drm/tegra/plane.c
> @@ -319,11 +319,13 @@ int tegra_plane_state_add(struct tegra_plane *plane=
,
>  	return 0;
>  }
> =20
> -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap)
> +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_uv=
)
>  {
>  	/* assume no swapping of fetched data */
>  	if (swap)
>  		*swap =3D BYTE_SWAP_NOSWAP;
> +	if (swap_uv)
> +		*swap_uv =3D false;
> =20
>  	switch (fourcc) {
>  	case DRM_FORMAT_ARGB4444:
> diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/plane.=
h
> index e33a581e6490e..dba5f1b254e98 100644
> --- a/drivers/gpu/drm/tegra/plane.h
> +++ b/drivers/gpu/drm/tegra/plane.h
> @@ -49,6 +49,7 @@ struct tegra_plane_state {
>  	struct tegra_bo_tiling tiling;
>  	u32 format;
>  	u32 swap;
> +	bool swap_uv;
> =20
>  	bool reflect_x;
>  	bool reflect_y;
> @@ -88,7 +89,7 @@ void tegra_plane_cleanup_fb(struct drm_plane *plane,
>  int tegra_plane_state_add(struct tegra_plane *plane,
>  			  struct drm_plane_state *state);
> =20
> -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
> +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swap_uv=
);
>  bool tegra_plane_format_is_indexed(unsigned int format);
>  bool tegra_plane_format_is_yuv(unsigned int format, unsigned int *planes=
, unsigned int *bpc);
>  int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
>=20
> --=20
> 2.54.0
>=20
>=20
>=20




