Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D618606D803
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 06:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=gGKfqd5U
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4FBC410E774;
	Tue,  3 Nov 2026 06:54:41 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010055.outbound.protection.outlook.com
 [52.101.193.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7D8A10E774
 for <dri-devel@lists.freedesktop.org>; Tue,  3 Nov 2026 06:54:34 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCsRDn1M5KPsTXi10d09q9VLCFNi11RwRh8lNGmkD9y34LY6e0GUJKM6EnztTivisPcL9i8XpoZlty2Ya8123gsmsQ0zVcLrXJpJC0ZMOUu+PLUCGcjZ0eUyoOVSZu8MHOT5A53y3YpXxXId7/MfO6d9KpRi6v+BbIN0jpxA0wMWT7bB74bNkqbuov7RbE8Sd5erqUKlRsQvYpvSnep4eX9DiqxVCngUg3tmBmd2rofON2pqzJy5EMgBYPct0LqmA3YI9+0EP6DdGRGhtbdV2AjOOHJ+JiY+NreLdtMRIqZdMXtRKxV9U3RD0TFuwPVoydLCL79g88K4KSe8GkAhpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKG2iqLqM3JLVKJgw2zromkuXZ5Jm69NX+odaXvVfzo=;
 b=xLC31KDWOxN+C3kgVIlFztjJpdj8eNZZzQ/enPqoEVqKCpNYbA7KYRi+TlHCuWY/8iIfXg18m2gu0wyuBciRT3s4CvsuvBPZwmMmFDCmGO/nUlaxXMru79Q0C83eRwS4ngOR9yb/I7II5f/T8HiyDt9vbnDW1LmuMpYUQzhRVXNUf9xyjWBT+5fUXTKqzn3XimazGzZ2Tl7YevnkEG1c0TlEao8xtsqDqgljxH0uksSUVeb7nosycFTFC3fZMWTxHOevEA0bVS3YLnVhtamaj/809f3Y8vAcc76z0vg/PEuF2U0+YeQDBCJo2jdGvA86oxEYbp0UhM13ukAQ5XYeAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKG2iqLqM3JLVKJgw2zromkuXZ5Jm69NX+odaXvVfzo=;
 b=gGKfqd5UQiPUnLtLjeUpd7EYJS68Yyd1Ziscd3Sidiih4IfCU1rnPI5t5+li8sWgBzm+p02XAuPHerfLycALpl+uOHhTKkGd5OmmZvNVveTRfoFnhn8wzC4Aup7etw+WMoBDgaPLirE+bUvfJUeYc21oDIhrxW73gZFu2CCoq+ErUx4JzpJn80QSsS0mKfdbma/QIrRzGfRxRFGtW4MUdk0LksmkdFlqKLb+7fl3v/l0eZkhm15Q09dBTkDuq8H6Vu1E0qDeetXly/Z1i4dcKUocfoDY6Bj2aqlN0OIUdT82zs5xh9V4OVJBTu/Lwh/wQ8le7G9EA5oM7X47kev9cQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB7838.namprd12.prod.outlook.com (2603:10b6:510:287::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 06:54:29 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.011; Tue, 3 Nov 2026
 06:54:28 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v5 11/11] drm/tegra: Add support for 8-bit CPU interface
Date: Tue, 03 Nov 2026 15:10:05 +0900
Message-ID: <weWUeY3nRGCfNVcl2RuY5g@nvidia.com>
In-Reply-To: <20261029152909.234584-12-clamor95@gmail.com>
References: <20261029152909.234584-1-clamor95@gmail.com>
 <20261029152909.234584-12-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0056.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:36b::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB7838:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aa9af92-84ba-4d4d-b056-08df39774e40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|366016|1800799024|376014|23010399003|10070799003|6133799003|22082099003|18002099003|56012099006|261102123227099003|3023799007|10067099003|261009223027099003|921020|261022115727099003|261022105027099003|261022113327099003|261021121427099003|261021123027099003|261021130227099003|261021133027099003|261021135927099003|261022075727099003|4143699003|11063799006|261026130827099003|261028144727099003|261026135527099003|261026140227099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: nobVRYUznYuYXrsWAZ90BjRWwpBL9lNSFMiTIK5VzIXxtrbZrlVOU8Oqar7dVYgaIbDo1CtP2wyDm+uNhFzIlwmsAQE6jnGXw/EQ/lo5P11v5s5xPSfiw+vRTkuZwHlptMz4cAbM9XpvZY9WatZRB5GKmWGtS6LBXIyBiBddPCzW9V5KiSkQRCdHObtsF1TaPLieGeFQHNQpshuKWqC7P3boeJozwVOF6y9yLaaMg/WSLNB/sJix/IXdSwKeGv3QTl2Lsa8JMZ95yghY4ocJdQ2tHBzFnbYqrH53YiINtiGH8vmwjX4ROWde2DKj6ONGD2S0e9iezdnVqwrvF5F1xfuERDfPXmLo3zTcrnCi+PZ7Iv8pcV4WyYdVFrEeFGoF2nE2is6dlrpozg4Xmus86MpWc2dcLCAXwDxP+U+pPLwoYikfnAMOV6Il0zrSTbhpuEEFm+ttltkjQoOW4920R/i7Ual2/LnrxS3G+sXS7FnB3dU7dFjNnzffPmyy6bt7xg2L15ter9ZoGJ+/vVPNjMZam9eT05fFHLIZGN2P3Re0e0mFNt3eN0mIIB4grSQ7IKUlZj3iMbSZXqFor2grX5eduJ7wChagPhqCJ909ZM4f1lEvXZzU6r67mfCxjZEI9ZSxORSOD2s1uADOrI4PH5Ky8O7BjtLbdoHtu3J3ODvlV2NCGyzGX26RDYijweWCzQNlKJVTmDvCY5hh71G4yw==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(366016)(1800799024)(376014)(23010399003)(10070799003)(6133799003)(22082099003)(18002099003)(56012099006)(261102123227099003)(3023799007)(10067099003)(261009223027099003)(921020)(261022115727099003)(261022105027099003)(261022113327099003)(261021121427099003)(261021123027099003)(261021130227099003)(261021133027099003)(261021135927099003)(261022075727099003)(4143699003)(11063799006)(261026130827099003)(261028144727099003)(261026135527099003)(261026140227099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eDNib0dCTUkxRStyVUVnMGd4UVNJMUlQRzlYZ3RuQlhyYXlzN2JzSzBIUTFH?=
 =?utf-8?B?c3ZnMDhPOS9pZzJDblY1T1RYMWlmT2lVOXZIb3RlMjFIZG13YW43ZFBHeU1C?=
 =?utf-8?B?NEZKUDEzU1BPMXVNSGYrSlhkWXhpdjBkWkJuQXgwSkxtZzd6SXhuUUtGMWxI?=
 =?utf-8?B?NlQwVEd5bDE3eEhYT2k5c1dLUnJWMnQwN3ZFRVFMZ3FwTVF0TTlNdnYwVUZT?=
 =?utf-8?B?cmxmbTVPZENlVVBUSnFCMHE1SHdBTGlyNUNGQ2VBakttZ0dXR0xRWnhzdmVv?=
 =?utf-8?B?dnNUdGM5RHJCbTZ3RjlPK1poamF0d00xNlB3L1VVYUhLdzhGaTBFUzVURy9u?=
 =?utf-8?B?SWxqV1BKTFpLbUZUSzRhMU5WYkQ2bFJhV2tSbFlHWFdRb0pLbGlyeUtjZjhG?=
 =?utf-8?B?WUNSM3gzMWpHcTUvUU5NQ0s2L2VkM1ZuOWlUVGFyK09ielYyOTJEOUxHa29N?=
 =?utf-8?B?d1pmN0MwTnE0aWxZeDNaRlJDTm91TVhRQ05HL3AwZ3d0ZjRReHU1aEN2cGJG?=
 =?utf-8?B?ZE1zakw4anhhSmlzc0RSMnFRQldpb09BZUlzcDBrQjgzYXZVSEpMYXg5VExY?=
 =?utf-8?B?bDNVUEhjUWQwakREQ3JDK1JGd0Z2OTdwcVVqemhSNm50UDI3WGUvTzJSaW5Z?=
 =?utf-8?B?MngvWVZQUXhuRzMrOG5jK2M4Wit3b05vYVpaVlVweklJUHFrMC8zL1hMcDJp?=
 =?utf-8?B?QnZMT3ArSklvWUR1R1VJSWpCaEtoNVlTaGhPUXh5WXVTVGtXVy9ERlMzZlpu?=
 =?utf-8?B?cEFIUzlrT1c0RzBxb3JDS0trSGJ3OWdnZFBhUVVoSmJqZlRjRTZ5VGtuT21o?=
 =?utf-8?B?a2tDVTIyQXcyanlCZFMwYm01SFEvb3NjcVM2ZEd6NS9remVDZS9hRktBYzkv?=
 =?utf-8?B?bitpelFpZDZ6dWdFZEU1SkZlN00wbC9VcWUwVEZlbVgxQUxjcHdaeTZhOUY4?=
 =?utf-8?B?VmwzNzc0NlQwbkgyT3lyNGxSYXZIS2kwVG1uc1M2VXZJd2ZxaEFoMlJlV0xw?=
 =?utf-8?B?NFlDTHFLUWMvcmU1WGdyZlVxRkRmZWY1K3EwS3FjeDBhSm5aVldZUW9FYkZU?=
 =?utf-8?B?OEZaMHRIa1Jnd3g2TFhrSXh1TUFyZFpIbWM4Y0dKTW5yYk01RGUrN1cydmZK?=
 =?utf-8?B?eWs5ZGF3VWkzQWFYY2JxM0VZaHllaVZ3bG1rWmNPVlltQnVrbjkyZTNWQlNu?=
 =?utf-8?B?YkF3YkNsUzVpUk9uSnZSUFBIVWtTbzg2MXdXOGtXaElXZko0cGhVdVBncGE3?=
 =?utf-8?B?ZmlVYlhYL0FJQkEyNERqdzQydWRqckdVWjFjNXA3UElOdWJ3MmNodVROTXJa?=
 =?utf-8?B?RTgybkRPbDE0NS96WldCaXB3N243ZTdlc3hISngvaG1kUS9FakFubXRQTXpQ?=
 =?utf-8?B?ejVIRGZsSTUzM0RuYWxQT2xoQXpLUjdhK1JMS2lpTVhpZENaTmZGS3R4RWFa?=
 =?utf-8?B?cVA4VGcvTGZmTnRrSmNRRTVKbllEdTdkMzRSL3lwL09LZHhOOHAyUTdmK2pn?=
 =?utf-8?B?VmZvRHdWZmhpTmw2ZkVBZmxjVmtZVlFKYjc1Tk1JcTZqS3N1d05XVURkZ1FW?=
 =?utf-8?B?WlpyWG43VnZPK1YvcWN6NWxnTnplVldhYlJWWHhMSGg1eThsWjdUMVlVMnFt?=
 =?utf-8?B?V2R1cHltaGFVODNaMkxKaGpSNFg3dVd3ckJsMnpRY0RMeER2SnFKL0dlRFBi?=
 =?utf-8?B?V09RUUxKcFpRMzkxVng5ZWVDNjNiVElvSGFOQ2QwNEJiUk02Y3l0WTZRNDNo?=
 =?utf-8?B?OXFpajhLM3NxK05FVHBJZ2ZBRkVOZkwrNFFQWkw3U3g3NU5hOUtldUgrRW1y?=
 =?utf-8?B?Z1dJWE5vbVAyOFZucVNGaEJtQ3hiUlMvcmZ0TkZ4MkRzdmJIT3VHUDZibTE5?=
 =?utf-8?B?UUZ4ZE5kSUkzajRxUWFqTXV2a3owNzcyNUVidEEzZmJtTmVDRnN2S3ZiNlBD?=
 =?utf-8?B?azl2em1OQlBxV0g4UWlrNDQ2YklucGI0WG1WU1lOVk5ic2krSExOdWUvcTVN?=
 =?utf-8?B?VjJpWkVDaXFxa2RMRVpKZ3lhOGVWRVlwZm5RQVlDY2E5ZStKUjFkZ1Vybng3?=
 =?utf-8?B?L3pYSk5JWmh2UVlQdkZMZmJZdVR6NkE0ajZvUkIvQnBwVWVmVnhnNkI2V2VS?=
 =?utf-8?B?RlREMHprUThSTEFBRGZlanc4ajRpS0FZdzNDNVlWMzNwUlIyejJLUjk1TzZn?=
 =?utf-8?B?YUMySUk0MTdoS003S2crcEZldkpGQjhjQ2dMSkQwZDltdjJ5VTNOeWd0THpY?=
 =?utf-8?B?WGVLaitkY0Q4cG9kZTEyeVdKcXg2TEVZaXUvQkIyZ3VlQkk3N1pybWRJeXg5?=
 =?utf-8?B?SWF5azZOTk03bXhFWDlIRVMycWlpSkVBd1VzbENmSS9aOFc2R2tYbzE4VHEx?=
 =?utf-8?Q?20yVRBOfITpW55kQEGuyRDPcLuGLtWczapkNbbsOuUVUV?=
X-MS-Exchange-AntiSpam-MessageData-1: 73YWrOJs6zISlA==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa9af92-84ba-4d4d-b056-08df39774e40
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 06:54:28.8959 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5h9F8YX0hYZlZaVueMA/k6Fv0RxAIEwWSQ8lppk8ZRJzxIzW90gBbf1gfgxr9bfLhx4w8UE8ZDQ2bKEZHN3wuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7838
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
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,UNWANTED_LANGUAGE_BODY autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Friday, October 30, 2026 12:29=E2=80=AFAM Svyatoslav Ryhel wrote:
> The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
> that closely resembles the MIPI DBI Type B protocol and is referred to as
> '8-bit CPU'. Each display controller provides two such interfaces, which
> can be used to send MIPI DCS commands to initialize and control the panel
> while image data is transmitted via 16/18/24-line RGB.
>=20
> The '8-bit CPU', although being the DC interface, is modeled using a
> bridge framework for flexibility and convenience. This implementation doe=
s
> not change the existing codebase besides registering the bus.
>=20
> Suggested-by: Mikko Perttunen <mperttunen@nvidia.com> # DC command transf=
er
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/Makefile |   1 +
>  drivers/gpu/drm/tegra/dbi.c    | 632 +++++++++++++++++++++++++++++++++
>  drivers/gpu/drm/tegra/dc.c     |   4 +
>  drivers/gpu/drm/tegra/dc.h     |   3 +
>  4 files changed, 640 insertions(+)
>  create mode 100644 drivers/gpu/drm/tegra/dbi.c
>=20
> diff --git a/drivers/gpu/drm/tegra/Makefile b/drivers/gpu/drm/tegra/Makef=
ile
> index e399b40d64a1d..ae7fccb3d6421 100644
> --- a/drivers/gpu/drm/tegra/Makefile
> +++ b/drivers/gpu/drm/tegra/Makefile
> @@ -18,6 +18,7 @@ tegra-drm-y :=3D \
>  	hdmi.o \
>  	mipi-phy.o \
>  	dsi.o \
> +	dbi.o \
>  	sor.o \
>  	dpaux.o \
>  	gr2d.o \
> diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
> new file mode 100644
> index 0000000000000..e129be0f21da5
> --- /dev/null
> +++ b/drivers/gpu/drm/tegra/dbi.c
> @@ -0,0 +1,632 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Nvidia Tegra20/30 MIPI-DBI Type B host driver
> + *
> + * Copyright (C) 2026 Svyatoslav Ryhel <clamor95@gmail.com>
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/cleanup.h>
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/kernel.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/of_platform.h>
> +#include <linux/property.h>
> +#include <linux/platform_device.h>
> +#include <linux/string.h>
> +
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_drv.h>
> +#include <drm/drm_mipi_dbi.h>
> +#include <drm/drm_mipi_dbi_bus.h>
> +#include <drm/drm_of.h>
> +
> +#include <video/mipi_display.h>
> +
> +#include "dc.h"
> +
> +enum tegra_dbi_dc_signal {
> +	TEGRA_DBI_COMMAND,
> +	TEGRA_DBI_DATA
> +};
> +
> +#define TEGRA_DBI_DATA_PINS_MAX			8
> +#define TEGRA_DBI_INTERFACE_MAX			2
> +
> +struct reg_entry {
> +	u32 offset;
> +	u32 value;
> +};
> +
> +static const struct reg_entry com_pin_output[] =3D {
> +	{ DC_COM_PIN_OUTPUT_ENABLE(0),   0 },
> +	{ DC_COM_PIN_OUTPUT_ENABLE(1),   0 },
> +	{ DC_COM_PIN_OUTPUT_ENABLE(2),   0 },
> +	{ DC_COM_PIN_OUTPUT_ENABLE(3),   0 },
> +	{ DC_COM_PIN_OUTPUT_POLARITY(0), 0 },
> +	{ DC_COM_PIN_OUTPUT_POLARITY(1), 0 },
> +	{ DC_COM_PIN_OUTPUT_POLARITY(2), 0 },
> +	{ DC_COM_PIN_OUTPUT_POLARITY(3), 0 },
> +	{ DC_COM_PIN_OUTPUT_DATA(0),     0 },
> +	{ DC_COM_PIN_OUTPUT_DATA(1),     0 },
> +	{ DC_COM_PIN_OUTPUT_DATA(2),     0 },
> +	{ DC_COM_PIN_OUTPUT_DATA(3),     0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(0),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(1),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(2),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(3),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(4),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(5),   0 },
> +	{ DC_COM_PIN_OUTPUT_SELECT(6),   0 },
> +};

Instead of this table with unused repeated zero values, I think it would=20
be cleaner to have just the register offsets:

  static const u32 tegra_dbi_pin_regs[] =3D {
  	DC_COM_PIN_OUTPUT_ENABLE(0),
  	// ...
  };

> +
> +struct tegra_dbi_priv {
> +	struct device *dev;
> +	struct tegra_dc *dc;
> +
> +	struct mipi_dbi dbi;
> +	struct mipi_dbi_host dbi_host;
> +
> +	struct drm_bridge bridge;
> +	struct drm_bridge *next_bridge;
> +
> +	const struct tegra_dbi_interface *index;

'index' implies an integer, can you rename this to 'interface'.

> +	struct reg_entry com_pin_backup[ARRAY_SIZE(com_pin_output)];
> +
> +	u32 bus_width;
> +	u32 reg;
> +	bool active;
> +};
> +
> +struct pin {
> +	u32 reg;
> +	u32 pos;
> +};

Can you rename this to struct tegra_dbi_pin?

> +
> +struct tegra_dbi_interface {
> +	struct pin dc;
> +	struct pin rw;
> +	struct pin cs;
> +	struct pin data[TEGRA_DBI_DATA_PINS_MAX];
> +};
> +
> +static const struct tegra_dbi_interface tegra_dbi_idx[TEGRA_DBI_INTERFAC=
E_MAX] =3D {
> +	/* Nvidia Primary 8-bit CPU interface configuration */
> +	{
> +		.dc =3D { DC_COM_PIN_OUTPUT_DATA(3), PIN_LDC  },
> +		.rw =3D { DC_COM_PIN_OUTPUT_DATA(1), PIN_LSC0 },
> +		.cs =3D { DC_COM_PIN_OUTPUT_DATA(3), PIN_LCSN },
> +		.data =3D {
> +			{ DC_COM_PIN_OUTPUT_DATA(0), PIN_LD0 },
> +			{ DC_COM_PIN_OUTPUT_DATA(0), PIN_LD1 },
> +			{ DC_COM_PIN_OUTPUT_DATA(0), PIN_LD2 },
> +			{ DC_COM_PIN_OUTPUT_DATA(0), PIN_LD3 },
> +			{ DC_COM_PIN_OUTPUT_DATA(0), PIN_LD4 },
> +			{ DC_COM_PIN_OUTPUT_DATA(0), PIN_LD5 },
> +			{ DC_COM_PIN_OUTPUT_DATA(0), PIN_LD6 },
> +			{ DC_COM_PIN_OUTPUT_DATA(0), PIN_LD7 },
> +		},
> +	},
> +	/* Nvidia Secondary 8-bit CPU interface configuration */
> +	{
> +		.dc =3D { DC_COM_PIN_OUTPUT_DATA(2), PIN_LVP0 },
> +		.rw =3D { DC_COM_PIN_OUTPUT_DATA(1), PIN_LSC1 },
> +		.cs =3D { DC_COM_PIN_OUTPUT_DATA(2), PIN_LM0  },
> +		.data =3D {
> +			{ DC_COM_PIN_OUTPUT_DATA(2), PIN_LHP1 },
> +			{ DC_COM_PIN_OUTPUT_DATA(2), PIN_LM1  },
> +			{ DC_COM_PIN_OUTPUT_DATA(2), PIN_LDI  },
> +			{ DC_COM_PIN_OUTPUT_DATA(2), PIN_LPP  },
> +			{ DC_COM_PIN_OUTPUT_DATA(1), PIN_LPW0 },
> +			{ DC_COM_PIN_OUTPUT_DATA(1), PIN_LPW2 },
> +			{ DC_COM_PIN_OUTPUT_DATA(2), PIN_LVP1 },
> +			{ DC_COM_PIN_OUTPUT_DATA(2), PIN_LHP0 },
> +		},
> +	},
> +};

If we include the information needed by init_primary/init_secondary in=20
the tegra_dbi_interface tables as well, we can get rid of the 'reg'=20
field.

> +
> +static inline struct tegra_dbi_priv *mipi_dbi_to_tegra_dbi(struct mipi_d=
bi *dbi)
> +{
> +	return container_of(dbi, struct tegra_dbi_priv, dbi);
> +}
> +
> +static inline struct tegra_dbi_priv *dbi_host_to_tegra_dbi(struct mipi_d=
bi_host *host)
> +{
> +	return container_of(host, struct tegra_dbi_priv, dbi_host);
> +}
> +
> +static inline struct tegra_dbi_priv *bridge_to_tegra_dbi(struct drm_brid=
ge *bridge)
> +{
> +	return container_of(bridge, struct tegra_dbi_priv, bridge);
> +}
> +
> +static void tegra_dbi_pin_set(struct tegra_dc *dc, const struct pin *pin=
, bool value)
> +{
> +	u32 val =3D BIT(pin->pos + 1); /* unmask is 1 bit above position */
> +
> +	if (value)
> +		val |=3D BIT(pin->pos);
> +
> +	tegra_dc_writel(dc, val, pin->reg);
> +}
> +
> +static void tegra_dbi_write(struct tegra_dbi_priv *priv,
> +			    enum tegra_dbi_dc_signal signal, u8 value)
> +{
> +	struct tegra_dc *dc =3D priv->dc;
> +	const struct tegra_dbi_interface *idx =3D priv->index;
> +
> +	tegra_dbi_pin_set(dc, &idx->dc, signal);
> +
> +	tegra_dbi_pin_set(dc, &idx->cs, 0);
> +	tegra_dbi_pin_set(dc, &idx->rw, 0);
> +
> +	for (int i =3D 0; i < TEGRA_DBI_DATA_PINS_MAX; i++)
> +		tegra_dbi_pin_set(dc, &idx->data[i], field_get(BIT(i), value));
> +
> +	tegra_dbi_pin_set(dc, &idx->cs, 1);
> +	tegra_dbi_pin_set(dc, &idx->rw, 1);
> +
> +	udelay(10);
> +}
> +
> +static int tegra_dbi_dbi_command(struct mipi_dbi *dbi, u8 *cmd, u8 *para=
m, size_t num)
> +{
> +	struct tegra_dbi_priv *priv =3D mipi_dbi_to_tegra_dbi(dbi);
> +	u8 command =3D *cmd;
> +
> +	/* Blocks all commands when interface is not active */
> +	if (!priv->active)
> +		return -ENODEV;
> +
> +	tegra_dbi_write(priv, TEGRA_DBI_COMMAND, command);
> +
> +	for (int i =3D 0; i < num; i++)
> +		tegra_dbi_write(priv, TEGRA_DBI_DATA, param[i]);
> +
> +	return 0;
> +}
> +
> +static int tegra_dbi_host_attach(struct mipi_dbi_host *host, struct mipi=
_dbi_device *dbidev)
> +{
> +	struct tegra_dbi_priv *priv =3D dbi_host_to_tegra_dbi(host);
> +	struct device *dev =3D priv->dev;
> +	struct drm_bridge *bridge;
> +	struct device_node *ep;
> +	int ret;
> +
> +	bridge =3D of_drm_get_bridge_by_endpoint(dev_of_node(dev), 1, -1);
> +	if (IS_ERR(bridge))
> +		return PTR_ERR(bridge);
> +
> +	bridge->type =3D DRM_MODE_CONNECTOR_DPI;
> +	priv->next_bridge =3D bridge;
> +
> +	/* get input ep (port0/endpoint0) */
> +	ret =3D -EINVAL;
> +	ep =3D of_graph_get_endpoint_by_regs(dev_of_node(dev), 0, 0);
> +	if (ep) {
> +		ret =3D of_property_read_u32(ep, "bus-width", &priv->bus_width);
> +		of_node_put(ep);
> +	}
> +
> +	if (ret)
> +		priv->bus_width =3D 24;

I think this would look a bit cleaner like ..

  priv->bus_width =3D 24;

  ep =3D of_graph_get_endpoint_by_regs(dev_of_node(dev), 0, 0);
  if (ep) {
    of_property_read_u32(ep, "bus-width", &priv->bus_width);
    of_node_put(ep);
  }

> +
> +	return devm_drm_bridge_add(dev, &priv->bridge);
> +}
> +
> +static void tegra_dbi_host_detach(struct mipi_dbi_host *host, struct mip=
i_dbi_device *dbidev)
> +{
> +	struct tegra_dbi_priv *priv =3D dbi_host_to_tegra_dbi(host);
> +
> +	drm_bridge_remove(&priv->bridge);

The above calls devm_drm_bridge_add, so I believe drm_bridge_remove will=20
happen automatically.

> +	drm_bridge_put(priv->next_bridge);
> +}
> +
> +static const struct mipi_dbi_host_ops tegra_dbi_host_ops =3D {
> +	.attach =3D tegra_dbi_host_attach,
> +	.detach =3D tegra_dbi_host_detach,
> +};
> +
> +static void tegra_dbi_init_primary_interface(struct tegra_dbi_priv *priv=
)
> +{
> +	struct tegra_dc *dc =3D priv->dc;
> +	u32 value;
> +
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_ENABLE(3));
> +	value &=3D ~(BIT(PIN_LCSN) | BIT(PIN_LDC));
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_ENABLE(3));
> +
> +	/* Set LSC0/LCSN/LDC output polarity HIGH */
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_POLARITY(1));
> +	value &=3D ~BIT(PIN_LSC0);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
> +
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_POLARITY(3));
> +	value &=3D ~(BIT(PIN_LCSN) | BIT(PIN_LDC));
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_POLARITY(3));
> +
> +	value =3D PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LD0) |
> +		PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LD1) |
> +		PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LD2) |
> +		PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LD3) |
> +		PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LD4) |
> +		PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LD5) |
> +		PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LD6) |
> +		PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LD7);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(0));
> +
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(3));
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LSC0);
> +	value |=3D PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LSC0);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(3));
> +
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LCSN);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LDC);
> +	value |=3D PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LCSN) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LDC);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
> +}
> +
> +static void tegra_dbi_init_secondary_interface(struct tegra_dbi_priv *pr=
iv)
> +{
> +	struct tegra_dc *dc =3D priv->dc;
> +	u32 value;
> +
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_ENABLE(2));
> +	value &=3D ~(BIT(PIN_LDI) | BIT(PIN_LPP));
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_ENABLE(2));
> +
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(3));
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LPW0);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LPW2);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LSC1);
> +	value |=3D PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LPW0) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LPW2) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LSC1);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(3));
> +
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(4));
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LHP0);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LHP1);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LVP0);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LVP1);
> +	value |=3D PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LHP0) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LHP1) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LVP0) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LVP1);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(4));
> +
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(5));
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LM0);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LM1);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LDI);
> +	value &=3D ~PIN_OUTPUT_SELECT_MASK(PIN_OUTPUT_SELECT_LPP);
> +	value |=3D PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LM0) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LM1) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LDI) |
> +		 PIN_OUTPUT_SELECT_OUT(PIN_OUTPUT_SELECT_LPP);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(5));
> +}
> +
> +static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
> +				    struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct drm_bridge *next_bridge =3D priv->next_bridge;
> +	struct tegra_dc *dc =3D priv->dc;
> +	u32 value;
> +
> +	value =3D tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
> +	value &=3D ~DISP_CTRL_MODE_MASK;
> +	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
> +
> +	/* Disable all options except cursor if enabled */
> +	value =3D tegra_dc_readl(dc, DC_DISP_DISP_WIN_OPTIONS);
> +	value &=3D CURSOR_ENABLE;
> +	tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
> +
> +	tegra_dc_commit(dc);
> +
> +	tegra_dc_writel(dc, V_PULSE1_ENABLE, DC_DISP_DISP_SIGNAL_OPTIONS0);
> +	tegra_dc_writel(dc, PULSE_POLARITY_LOW, DC_DISP_V_PULSE1_CONTROL);
> +
> +	tegra_dc_writel(dc, PULSE_END(1), DC_DISP_V_PULSE1_POSITION_A);
> +	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_B);
> +	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_C);
> +
> +	value =3D 1 << FRAME_INIT_SEQ_CYCLES_SHIFT |
> +		DC_SIGNAL_VPULSE1 << INIT_SEQ_DC_SIGNAL_SHIFT |
> +		INIT_SEQUENCE_MODE_PLCD | SEND_INIT_SEQUENCE;
> +	tegra_dc_writel(dc, value, DC_DISP_INIT_SEQ_CONTROL);
> +
> +	 /* Init cycle 1: WRITE_MEMORY_START, set LCD_PCLK and COMMAND */

Extra space here before '/*'

> +	tegra_dc_writel(dc, MIPI_DCS_WRITE_MEMORY_START, DC_DISP_SPI_INIT_SEQ_D=
ATA_A);
> +	tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_B);
> +	tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_C);
> +	tegra_dc_writel(dc, BIT(12) | BIT(14), DC_DISP_SPI_INIT_SEQ_DATA_D);
> +
> +	value =3D SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
> +		SC0_V_QUALIFIER(SC_V_QUALIFIER_VACTIVE) |
> +		SC0_H_QUALIFIER(SC_H_QUALIFIER_HACTIVE);
> +	tegra_dc_writel(dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
> +
> +	value =3D tegra_dc_readl(dc, DC_DISP_DISP_COLOR_CONTROL);
> +	value &=3D ~BASE_COLOR_SIZE_MASK;
> +
> +	switch (priv->bus_width) {
> +	case 16:
> +		value |=3D BASE_COLOR_SIZE_565;
> +		break;
> +	case 18:
> +		value |=3D BASE_COLOR_SIZE_666;
> +		break;
> +	case 24:
> +	default:

Why the default case? My assumption would be that if the bus width is=20
not something that's expected, that's an error.

> +		value |=3D BASE_COLOR_SIZE_888;
> +		break;
> +	}
> +
> +	tegra_dc_writel(dc, value, DC_DISP_DISP_COLOR_CONTROL);
> +
> +	/*
> +	 * Backup registers before unshadowing since actual register values
> +	 * may differ and their state backed up now is the correct one.
> +	 */
> +	for (int i =3D 0; i < ARRAY_SIZE(com_pin_output); i++)
> +		priv->com_pin_backup[i].value =3D tegra_dc_readl(dc,
> +			priv->com_pin_backup[i].offset);
> +
> +	/* Unshadow to set up command and data pins */
> +	tegra_dc_writel(dc, WRITE_MUX | READ_MUX, DC_CMD_STATE_ACCESS);
> +
> +	if (priv->reg)
> +		tegra_dbi_init_secondary_interface(priv);
> +	else
> +		tegra_dbi_init_primary_interface(priv);
> +
> +	priv->active =3D true;
> +
> +	/*
> +	 * DBI requires that the next bridge be enabled here in order to
> +	 * send DCS commands, since the interface pins will subsequently be
> +	 * reconfigured for video data.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_enable)
> +		next_bridge->funcs->atomic_enable(next_bridge, state);

Instead of hijacking the flow, could we move the panel init commands=20
into the prepare callback, and deinit into the unprepare callback?=20
Command mode would then stay active until this function (host-side=20
atomic_enable) is called, and again become active at the end of=20
atomic_disable. AFAICT that should allow for a normal lifecycle.

> +
> +	tegra_dbi_pin_set(dc, &priv->index->cs, 0);
> +
> +	priv->active =3D false;
> +
> +	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> +
> +	for (int i =3D 0; i <  ARRAY_SIZE(com_pin_output); i++)
> +		tegra_dc_writel(dc, priv->com_pin_backup[i].value,
> +				priv->com_pin_backup[i].offset);
> +
> +	tegra_dc_commit(dc);
> +
> +	/* Set LDC pin to V Pulse 1 */
> +	value =3D tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
> +	value |=3D PIN_OUTPUT_SELECT_F4(PIN_OUTPUT_SELECT_LDC);
> +	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
> +
> +	value =3D tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
> +	value &=3D ~DISP_CTRL_MODE_MASK;
> +	value |=3D DISP_CTRL_MODE_C_DISPLAY;
> +	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
> +}
> +
> +static void tegra_dbi_atomic_disable(struct drm_bridge *bridge,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct drm_bridge *next_bridge =3D priv->next_bridge;
> +	struct tegra_dc *dc =3D priv->dc;
> +
> +	for (int i =3D 0; i < ARRAY_SIZE(com_pin_output); i++)
> +		priv->com_pin_backup[i].value =3D tegra_dc_readl(dc,
> +			priv->com_pin_backup[i].offset);
> +
> +	tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);
> +
> +	if (priv->reg)
> +		tegra_dbi_init_secondary_interface(priv);
> +	else
> +		tegra_dbi_init_primary_interface(priv);
> +
> +	priv->active =3D true;
> +
> +	/*
> +	 * DBI requires that the next bridge be disabled here in order to
> +	 * send DCS commands, since the interface pins will subsequently be
> +	 * reconfigured for video data.
> +	 */
> +	if (next_bridge->funcs && next_bridge->funcs->atomic_disable)
> +		next_bridge->funcs->atomic_disable(next_bridge, state);
> +
> +	priv->active =3D false;
> +
> +	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
> +
> +	for (int i =3D 0; i <  ARRAY_SIZE(com_pin_output); i++)
> +		tegra_dc_writel(dc, priv->com_pin_backup[i].value,
> +				priv->com_pin_backup[i].offset);
> +
> +	tegra_dc_commit(dc);
> +}
> +
> +static int tegra_dbi_atomic_check(struct drm_bridge *bridge,
> +				  struct drm_bridge_state *bridge_state,
> +				  struct drm_crtc_state *crtc_state,
> +				  struct drm_connector_state *conn_state)
> +{
> +	struct drm_display_mode *adjusted_mode =3D &crtc_state->adjusted_mode;
> +
> +	/* Set safe default bus flags if panel does not specify them */
> +	if (!bridge_state->input_bus_cfg.flags)
> +		bridge_state->input_bus_cfg.flags =3D bridge->timings->input_bus_flags=
;
> +
> +	/* Default to positive sync */
> +	if (!(adjusted_mode->flags &
> +	      (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC)))
> +		adjusted_mode->flags |=3D DRM_MODE_FLAG_PHSYNC;
> +
> +	if (!(adjusted_mode->flags &
> +	      (DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC)))
> +		adjusted_mode->flags |=3D DRM_MODE_FLAG_PVSYNC;
> +
> +	return 0;
> +}
> +
> +static int tegra_dbi_attach(struct drm_bridge *bridge,
> +			    struct drm_encoder *encoder,
> +			    enum drm_bridge_attach_flags flags)
> +{
> +	struct tegra_dbi_priv *priv =3D bridge_to_tegra_dbi(bridge);
> +	struct device *dev =3D priv->dev;
> +
> +	priv->dc =3D dev_get_drvdata(dev->parent);
> +	if (!priv->dc)
> +		return -ENODEV;
> +
> +	return drm_bridge_attach(bridge->encoder, priv->next_bridge, bridge,
> +				 flags);
> +}
> +
> +static enum drm_mode_status tegra_dbi_mode_valid(struct drm_bridge *brid=
ge,
> +						 const struct drm_display_info *info,
> +						 const struct drm_display_mode *mode)
> +{
> +	if (mode->hdisplay > 800)
> +		return MODE_H_ILLEGAL;
> +
> +	if (mode->vdisplay > 800)
> +		return MODE_V_ILLEGAL;

Is there a source for the 800x800 limit?

> +
> +	return MODE_OK;
> +}
> +
> +static const struct drm_bridge_funcs tegra_dbi_funcs =3D {
> +	.attach =3D tegra_dbi_attach,
> +	.mode_valid =3D tegra_dbi_mode_valid,
> +
> +	.atomic_enable =3D tegra_dbi_atomic_enable,
> +	.atomic_disable =3D tegra_dbi_atomic_disable,
> +	.atomic_check =3D tegra_dbi_atomic_check,
> +
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +};
> +
> +static const struct drm_bridge_timings default_tegra_dbi_timings =3D {
> +	.input_bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
> +			   DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
> +			   DRM_BUS_FLAG_DE_HIGH,
> +};
> +
> +static int tegra_dbi_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct mipi_dbi_device *dbidev;
> +	struct tegra_dbi_priv *priv;
> +	struct device_node *np;
> +	int ret;
> +
> +	priv =3D devm_drm_bridge_alloc(dev, struct tegra_dbi_priv, bridge,
> +				     &tegra_dbi_funcs);
> +	if (IS_ERR(priv))
> +		return PTR_ERR(priv);
> +
> +	priv->dev =3D dev;
> +
> +	/* Default to primaty */

The comment seems unnecessary now, as the code below will error out=20
(correctly) if the property is not present.

> +	ret =3D device_property_read_u32(dev, "reg", &priv->reg);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get reg\n");
> +
> +	if (priv->reg !=3D 0 && priv->reg !=3D 1)
> +		return dev_err_probe(dev, -EINVAL, "Wrong reg value: %d\n", priv->reg)=
;
> +
> +	priv->index =3D &tegra_dbi_idx[priv->reg];
> +	memcpy(priv->com_pin_backup, com_pin_output, sizeof(com_pin_output));
> +
> +	/* Initialize MIPI DBI interface */
> +	mutex_init(&priv->dbi.cmdlock);
> +	priv->dbi.command =3D tegra_dbi_dbi_command;
> +
> +	priv->dbi_host.dev =3D dev;
> +	priv->dbi_host.dbi =3D &priv->dbi;
> +	priv->dbi_host.ops =3D &tegra_dbi_host_ops;
> +
> +	priv->bridge.of_node =3D dev_of_node(dev);
> +	priv->bridge.timings =3D &default_tegra_dbi_timings;
> +
> +	np =3D of_graph_get_remote_node(dev_of_node(dev), 1, -1);
> +	if (!np)
> +		return -EINVAL;
> +
> +	dbidev =3D devm_mipi_dbi_device_register(dev, &priv->dbi_host, np);
> +	of_node_put(np);
> +	if (IS_ERR(dbidev))
> +		return dev_err_probe(dev, PTR_ERR(dbidev),
> +				     "Failed to register DBI device\n");
> +
> +	return 0;
> +}
> +
> +static struct platform_driver tegra_dbi_driver =3D {
> +	.driver.name =3D "tegra-dbi",
> +	.probe =3D tegra_dbi_probe,
> +};

I don't see the need for the separate driver and probe. You should be=20
able to just use the tegra-dc platform device. If there's some issue,=20
please point it out.

> +
> +static void tegra_dbi_release(void *pdev)
> +{
> +	platform_device_unregister(pdev);
> +	platform_driver_unregister(&tegra_dbi_driver);
> +}
> +
> +int devm_tegra_dc_dbi_init(struct device *dev)

No need to have the devm_ prefix, for driver internal initialization=20
functions it's expected that they can set up devm actions on the device.

> +{
> +	struct device_node *dbi_np __free(device_node) =3D
> +		of_get_available_child_by_name(dev_of_node(dev), "dbi");
> +	struct platform_device_info dbi_info =3D { 0 };
> +	struct platform_device *dbi;
> +	int ret;
> +
> +	/* Missing node means that DBI is not used, continue */
> +	if (!dbi_np)
> +		return 0;
> +
> +	ret =3D platform_driver_register(&tegra_dbi_driver);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "Failed to register DBI driver\n");
> +
> +	dbi_info.parent =3D dev;
> +	dbi_info.name =3D "tegra-dbi";
> +	dbi_info.id =3D PLATFORM_DEVID_AUTO;
> +	dbi_info.fwnode =3D of_fwnode_handle(dbi_np);
> +	dbi_info.of_node_reused =3D true;
> +
> +	dbi =3D platform_device_register_full(&dbi_info);
> +	if (IS_ERR(dbi)) {
> +		platform_driver_unregister(&tegra_dbi_driver);
> +		return dev_err_probe(dev, PTR_ERR(dbi),
> +				     "Failed to create DBI device\n");
> +	}
> +
> +	ret =3D devm_add_action_or_reset(dev, tegra_dbi_release, dbi);
> +	if (ret)
> +		return ret;
> +
> +	return 0;
> +}
> diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> index 5bbf2c028edd8..768cf82776632 100644
> --- a/drivers/gpu/drm/tegra/dc.c
> +++ b/drivers/gpu/drm/tegra/dc.c
> @@ -3382,6 +3382,10 @@ static int tegra_dc_probe(struct platform_device *=
pdev)
>  		}
>  	}
> =20
> +	err =3D devm_tegra_dc_dbi_init(&pdev->dev);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, err, "failed to init DBI\n");
> +
>  	err =3D tegra_dc_rgb_probe(dc);
>  	if (err < 0 && err !=3D -ENODEV)
>  		return dev_err_probe(&pdev->dev, err,
> diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> index 2b87bb675d4cf..3df49422a2bd1 100644
> --- a/drivers/gpu/drm/tegra/dc.h
> +++ b/drivers/gpu/drm/tegra/dc.h
> @@ -177,6 +177,9 @@ void tegra_dc_rgb_remove(struct tegra_dc *dc);
>  int tegra_dc_rgb_init(struct drm_device *drm, struct tegra_dc *dc);
>  int tegra_dc_rgb_exit(struct tegra_dc *dc);
> =20
> +/* from dbi.c */
> +int devm_tegra_dc_dbi_init(struct device *dev);
> +
>  #define DC_CMD_GENERAL_INCR_SYNCPT		0x000
> =20
>  #define DC_CMD_GENERAL_INCR_SYNCPT_CNTRL	0x001
> --=20
> 2.53.0
>=20
>=20




