Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87AF606A333
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 05:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=jhq3Rn4j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 53C5710E107;
	Fri, 27 Nov 2026 05:24:57 +0000 (UTC)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010064.outbound.protection.outlook.com
 [52.101.193.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801A710E107
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 05:24:50 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qDn9JV8D7/SiJUQKLHzNhhXtty7eGEgl0SjBIsDXc3M+lj5cjn1legWX8bUeGoWPjrSJhUaWduP7mo1J+Xi9rgyGStcEOAiaMDQa5GWjJTx6/6ch6my6p92ksPFmVCsG286c+AOZ4hhhK9LN4XBZLw2pO2QxFpa9BmGvbroq3V9xE9tUvuX9jxOVHzgig3ljD5PatIbnnCF0IJXAXnjfxac1CR8/vtWdNXqE1qsqBoSHVYT9RZ5TIJSX5mAjgep7TuWEMDW864vLkSmvzfIZBE2xjAJ+w6mAXxf2xaga8FL5vJZo7MZQjsaKwxlsjjw13zmzY09YJlr2Gn2fwP32Fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcW1wa8yNSPpf4GQG7xYqrDfB/Q49hlkLmnT91a1PMM=;
 b=MyRjyMfu8nSMF+sNQjggrXq9mo6UkqFMNh+QU6FTSFR8VApUIMB8bn5jPubR0a5yTK+A1yL9oRONqXKfpYTGfCVqcVV8iQ0oyNyfsbjzmkDkMWEUANyLfdsq2CiozavMulHk3Ksnq2A2QzIUdpRjhWM3Q/sv3T9KRWJhs9xp6fU5V3aO85S2padVNt1ftYVXe/JKvUWAJUDy+wE+F2UJafYWqi6IfTNqlA2GaUimL56OnB0sh/cdKGgcwHc+i16Q4k9VIvDCGeP3o1TY/BFtlf6rZXrh0mhP3ekJfDWB32Fhmh6N1MbmtwNiUDrZeQR9Ak7p/H0JmDGgMM7ksKXtFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcW1wa8yNSPpf4GQG7xYqrDfB/Q49hlkLmnT91a1PMM=;
 b=jhq3Rn4jkxgkE9nijH5SNiTAo2yUSY/58GtU9O3GcAKNw7ky8hGhN6kuZhk4ppB1sThwejbG5+D2rdDnUVfTouTGHCG/lhyYTXeiYU4l2CjxP/oqa2B8esj99EJN9wVBI57OZe9CC5BABtNyCDRSFtZTz5vWOQeL07fNnK3xTND9IopDapn/LPZn0dVLl3Z69TjnbLhSBNvY3IvdbnhBmWwy8FfDtv9AmPnOUnbbx1hbtj0S3A33ICs7evbmbG/BKsU/2N0FdfEpyamSy864qwhUeSbamcr9N/rYKYQjBanVGynFHN32kH4Cs8xUZUNOB/5bxcYnyvzXt47CFerx8A==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by MW5PR12MB5597.namprd12.prod.outlook.com (2603:10b6:303:192::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 27 Nov
 2026 05:24:45 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 05:24:45 +0000
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
Subject: Re: [PATCH v8 09/12] drm/tegra: Convert to use atomic versions of
 drm_encoder_helper_funcs
Date: Fri, 27 Nov 2026 14:24:41 +0900
Message-ID: <mxfdX1kqQz209wWYqFOofg@nvidia.com>
In-Reply-To: <20261122081820.53199-10-clamor95@gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <20261122081820.53199-10-clamor95@gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OSTPR01CA0036.jpnprd01.prod.outlook.com
 (2603:1096:604:21b::9) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|MW5PR12MB5597:EE_
X-MS-Office365-Filtering-Correlation-Id: 052e5f8b-c966-4d71-44de-08df4c46bf6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|10070799003|376014|1800799024|366016|7416014|22082099003|6133799003|10063799003|18002099003|3023799007|921020|261022075727099003|4143699003|56012099006|261028144727099003|11063799006|261009223027099003|261022105027099003|261021121427099003|261021123027099003|261026140227099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: MTnMz/Afxv1Aloj1bEg4+qIh0W7gAKvnip/sKTSk14/WDgRBp0nBgl0d27C93/ezhlnQAHqrmosKtle2nogp8EkxX3CiiLC+vtfZCiAm5W94A78mCEc17dSYCD/jt2rSCxib1gChn9GPYvJ+ANxurVmniibb8L1d1lHtARTF1J2HkWRVM165KC3g3ib+M0ECgBPIOpfJ9O9Ur5royBl0zCB5pU8QoT1ieUDh7sxUSMbo62d0S7goWL2h9lb6ob0pOfwE0gbv2exgAWxqmbNq1C5M9nBKJq7uH3I7B/SZD6IHmLKV0h8DZ2b7b2K2lsDgwbcvoYmIC7F3v1FCMBpgnwtu0lg2376oc0CZqGnashR9qo91PSHE7tAkItaVPz3vMj1RqU4YM0D6IbiNz6pUq1ZDMgTSTN1jG77504cXk3FCvT74yfwWUoCIplxb7ToS8rl+gdKoMYS47Fp31hPSYK2KUJJzYPKvV1562SQ+J9mIIa6cpRTfUjoGKAZU9Y8ZtfFbC2Uo6FjmUKx+gBz5i6loNB5/BR4bys6loOx+REuDUijZXcOThLvE22npQQ/pP38LnaOSNPxejLKd2Vd7bCGRDsM48L3XkJb5aJSe9JSqovD3usF6vVyobQOdYd4hiVKv+EPoMdXWRKo4RnLRO9d53FuWAhD+yMEOD74o8aC1Clr+TqG/dye9s+Az0xMNDTHOA9AUiERZw9irBNEVpg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(10070799003)(376014)(1800799024)(366016)(7416014)(22082099003)(6133799003)(10063799003)(18002099003)(3023799007)(921020)(261022075727099003)(4143699003)(56012099006)(261028144727099003)(11063799006)(261009223027099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026140227099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OWloT1NkVHoyVDlKWjBjWXZ6TUhVMEJxMGw2a1JhRHlDOUxSUzhFY0FXWVlM?=
 =?utf-8?B?a1VMTU1uek1ySkhnTjdlVmM5ZlFLVFlsVVBiL09EK1BrcTF0MStDUm8wNjRX?=
 =?utf-8?B?a29tVmtLZUJXcjE4b1NxVUg5RGJVd1ZoZFpOV0VnZXBrdVk4Y3kvdWd2SENu?=
 =?utf-8?B?RzhOSUdKNXJveWtjbXVQdEx0dm5SUUxRTVpmSlhKZ2hZQmlzRzZHU1hKMmdN?=
 =?utf-8?B?ZHF1amxIcURHUTc3RklNdE94WkZTRjZNaDF5Z3dDbDU0OXRLc3R2Vjl2S2ky?=
 =?utf-8?B?bk91OXI5bm04ZGZsM204akg2Y3VFU01JU0w2Z0lJWlJCQmRERGpicWdUeno4?=
 =?utf-8?B?MGpTWlB3Y3RTSzdJWC9SWnovb2pRSm1xS3V4Nm41OWJCN3FHaURFbDVKdEFk?=
 =?utf-8?B?ODV1WDBqSmNmeW1TeWZLaXVaUFA5SzYxL2c0dVZQOWlNK2I2dFhDT2ZnNUs1?=
 =?utf-8?B?bXNibm1MSmVDTEw2d1JJU05OMUxQU25oS2hnSmJGdHRTM0xXVkpYUlNnUmJ1?=
 =?utf-8?B?Qy9oM1BqZWNuMElOOW1IcVc1K2xoVlRRSzc5V3E0VTBHaHBSODJxbFAxdU9h?=
 =?utf-8?B?MWV6WGtZL1JrUHkyaDJ3K0dTUUptVWFoNzdyNW9NUUNEaTlETTd2MnJvTTE4?=
 =?utf-8?B?dzBJS0g3RWtkMlhScWdIQllxNTVYUWF3WjNRNTd5a1FMdzdzVjArZkVTZ0NU?=
 =?utf-8?B?TFpJTHVsQlFLM290RnZDODRZdzM1UUVzeXJoZ3ZtK2pIQVZyd1Z5WkY0cnBB?=
 =?utf-8?B?KytuZjc3QTdtNit3aEkram1jTkp2Z2FsUFhaMndtVFZuUmxiNDFFeVNveVE5?=
 =?utf-8?B?WlJYRldTanhFeVEwUWEzbm9jNFAxVFQ3T2t3ejY3MWVGaWxYYXdaSlREUGpz?=
 =?utf-8?B?T1R5WVV5eFBsaWtGa2ZoLzl1c3F6WTRhMnk3SktQWk1wRDF0Q05COFJnNkxh?=
 =?utf-8?B?U0xnT3EybGxuaE50RElVc1FhU3hySTl3RjBVQ1pmSnJ5RHZZaE9teGNYVmky?=
 =?utf-8?B?NEdKOFdRbHV1SEVzKzFKODRYUkxOc0hLTERwQ1kyaENzQS9RT2d0cC9Ud2I1?=
 =?utf-8?B?WHZPd05zbGFLTGt2UUd0c0JXeW95WCt0WndIRjB4R0d2NXBjaUMycjZ4ZGRp?=
 =?utf-8?B?bjlxVVVabEZpS3RnVHFuaDg4VDE0NjQ2RC9EcExSZnV5R2wxbzBmQ1pkWWF2?=
 =?utf-8?B?QXdOS0lWNllvYW1BOWJyRTlNUkdKNE11Y0crYW9GZVpzMm5RemZlWmZVTE5G?=
 =?utf-8?B?aUc1RjduSEdQZ1U2NjNPUlgyeXVQb01iZWIxUnZuWkQ0RmJrV2hsVXJBUXl5?=
 =?utf-8?B?S0hwbkN2LysrOFZXdUdZUzVjZGkrZ2xpMllqdUlnZHRWYWgwYzUyaG9MV2Yv?=
 =?utf-8?B?azFuM1MvM0lVdkhhTEo5NmlrQ3JkSjdRY3lQempERjBkVGNZRmJETit3Qmd4?=
 =?utf-8?B?Tk83Wk5CazlOcStFcHNRVEdsVnR2Nkt3c3M0VUJmZkJMeENhcDhrQUF5OUln?=
 =?utf-8?B?a3hlUVNjN3VoQ0NVWnJOT0dqV3VrQTZsdUU4d01GWkZHYmZNOHZuUml0SllU?=
 =?utf-8?B?NHVvYTdaR2ZNaXNoOHJTZ1RhV3dtSTlOR0pydklKN1pCc2o2bmpxVU42cExk?=
 =?utf-8?B?Q1FXaTljQzlDVlhPZElRZllhckE1Ly9yd3JUVkVuQmErUXlMQUV0OEE0VkNq?=
 =?utf-8?B?aDl6YzhJaHlVVFk2LzBsYjROem1LTmc3RS9GcEpUUzNWbUVTbWtvQzdEZkN4?=
 =?utf-8?B?MHJMZGQ4NXVCSWx4ZFFGSVVLNm1oNllnUzJBUFpGQzdmWTRiZXRlUnFGb2oz?=
 =?utf-8?B?SkthdGhiMG45dDNIbklVTTc4OEdOcFZTdVRvOTRwM3ZadFJjenNpZklNbE45?=
 =?utf-8?B?RUhjMWZZWjFaZWQ2L1M4YSt4cEN6QlpPZEFuL2ExY3R6Y3FBSkhvK0IvUllS?=
 =?utf-8?B?bGdiZzVGdU1iS1dwckZ1L2RJRVI1Sm1nNkN6bW5HTU1sMm5kNjRTV05aanNt?=
 =?utf-8?B?Y0JWNHpvUmMzdmdSOUZSdjZManVvbHdkVS93REE5NSs5S21yUWxqcVowZjVt?=
 =?utf-8?B?bi9BUWZUUE1ReFE0Vm5yRnd5NVZTdG8vbUhhZldqV3BXTU9LY0piSnh5MDFH?=
 =?utf-8?B?ejZLUW5HUVgxM1ZPeW14Z1MxT3B3eTZ5ek9hd3lpZlJCb1VBVTlOa2RWWS9s?=
 =?utf-8?B?WFNYb2VPdXQzQlZBSUswdFJTQURtS0VFbUROWCtGZWhXbFp3US96aHFXaG5W?=
 =?utf-8?B?OVlPSzVDMXpMU0ozbXd5K0ZIMklmU2M4OHVZQ3N4TkkwaFZGY1U2S3hwMldn?=
 =?utf-8?B?WjZKVHdJUkV2bFZZUUFmMFY1UXVlTmV5L3RnZUtXcXF6Tjhvc0pWZlF2K3JJ?=
 =?utf-8?Q?Pw+watB6yDZICcSR09MRw5s3Pa7cthZxWbwdFJ/JqUYKv?=
X-MS-Exchange-AntiSpam-MessageData-1: C22mCmioxOehYQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 052e5f8b-c966-4d71-44de-08df4c46bf6f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 05:24:45.3867 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OSOq1sAtlJFYfcA0zWLKsASZICTDhsTGPcDB7zKClbH2puu25q7pZz4HHurk5tu0I6YiZMp0f2Id3qZMDmUgng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR12MB5597
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
> Switch to using the atomic versions of the enable() and disable()
> operations.
>=20
> This is required for acquiring the next bridge state without causing
> crashes, in order to properly set up the encoder.

This is a bit vague. I'd make an explicit reference to RGB needing=20
access to the bridge state, which is not possible with the non-atomic=20
functions, and then explaining that DSI / HDMI / SOR are converted for=20
consistency.

>=20
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> ---
>  drivers/gpu/drm/tegra/dsi.c  | 20 +++++++++++++++-----
>  drivers/gpu/drm/tegra/hdmi.c | 20 +++++++++++++++-----
>  drivers/gpu/drm/tegra/rgb.c  | 23 +++++++++++++++++------
>  drivers/gpu/drm/tegra/sor.c  | 18 +++++++++++++-----
>  4 files changed, 60 insertions(+), 21 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tegra/dsi.c b/drivers/gpu/drm/tegra/dsi.c
> index 6d6adc485e51e..cd61070072beb 100644
> --- a/drivers/gpu/drm/tegra/dsi.c
> +++ b/drivers/gpu/drm/tegra/dsi.c
> @@ -855,7 +855,8 @@ static void tegra_dsi_unprepare(struct tegra_dsi *dsi=
)
>  		dev_err(dsi->dev, "failed to suspend: %d\n", err);
>  }
> =20
> -static void tegra_dsi_encoder_disable(struct drm_encoder *encoder)
> +static void tegra_dsi_encoder_disable(struct drm_encoder *encoder,
> +				      struct drm_atomic_commit *comm_state)
>  {
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> @@ -919,16 +920,25 @@ static int tegra_dsi_prepare(struct tegra_dsi *dsi)
>  	return 0;
>  }
> =20
> -static void tegra_dsi_encoder_enable(struct drm_encoder *encoder)
> +static void tegra_dsi_encoder_enable(struct drm_encoder *encoder,
> +				     struct drm_atomic_commit *comm_state)
>  {
> -	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> +	struct drm_connector_state *conn_state;
>  	struct tegra_dsi *dsi =3D to_dsi(output);
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_connector *connector;
>  	struct tegra_dsi_state *state;
> +	struct drm_display_mode *mode;
>  	u32 value;
>  	int err;
> =20
> +	connector =3D drm_atomic_get_new_connector_for_encoder(comm_state, enco=
der);
> +	conn_state =3D drm_atomic_get_new_connector_state(comm_state, connector=
);
> +	crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_state->cr=
tc);
> +	mode =3D &crtc_state->adjusted_mode;
> +
>  	err =3D tegra_dsi_prepare(dsi);
>  	if (err < 0) {
>  		dev_err(dsi->dev, "failed to prepare: %d\n", err);

The function also uses encoder->crtc and tegra_dsi_get_state. Should=20
these be changed to conn_state->crtc and to_dsi_state(conn_state)?

Similarly for HDMI / SOR.

> @@ -1059,8 +1069,8 @@ static const struct drm_encoder_funcs tegra_dsi_enc=
oder_funcs =3D {
>  };
> =20
>  static const struct drm_encoder_helper_funcs tegra_dsi_encoder_helper_fu=
ncs =3D {
> -	.disable =3D tegra_dsi_encoder_disable,
> -	.enable =3D tegra_dsi_encoder_enable,
> +	.atomic_disable =3D tegra_dsi_encoder_disable,
> +	.atomic_enable =3D tegra_dsi_encoder_enable,
>  	.atomic_check =3D tegra_dsi_encoder_atomic_check,
>  };
> =20
> diff --git a/drivers/gpu/drm/tegra/hdmi.c b/drivers/gpu/drm/tegra/hdmi.c
> index e8c4347f09e69..a78279810dd82 100644
> --- a/drivers/gpu/drm/tegra/hdmi.c
> +++ b/drivers/gpu/drm/tegra/hdmi.c
> @@ -1166,7 +1166,8 @@ tegra_hdmi_connector_helper_funcs =3D {
>  	.mode_valid =3D tegra_hdmi_connector_mode_valid,
>  };
> =20
> -static void tegra_hdmi_encoder_disable(struct drm_encoder *encoder)
> +static void tegra_hdmi_encoder_disable(struct drm_encoder *encoder,
> +				       struct drm_atomic_commit *comm_state)
>  {
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> @@ -1209,18 +1210,27 @@ static void tegra_hdmi_encoder_disable(struct drm=
_encoder *encoder)
>  		dev_err(hdmi->dev, "failed to suspend: %d\n", err);
>  }
> =20
> -static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder)
> +static void tegra_hdmi_encoder_enable(struct drm_encoder *encoder,
> +				      struct drm_atomic_commit *comm_state)
>  {
> -	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	unsigned int h_sync_width, h_front_porch, h_back_porch, i, rekey;
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
>  	struct tegra_hdmi *hdmi =3D to_hdmi(output);
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc_state *crtc_state;
>  	unsigned int pulse_start, div82;
> +	struct drm_connector *connector;
> +	struct drm_display_mode *mode;
>  	int retries =3D 1000;
>  	u32 value;
>  	int err;
> =20
> +	connector =3D drm_atomic_get_new_connector_for_encoder(comm_state, enco=
der);
> +	conn_state =3D drm_atomic_get_new_connector_state(comm_state, connector=
);
> +	crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_state->cr=
tc);
> +	mode =3D &crtc_state->adjusted_mode;
> +
>  	err =3D host1x_client_resume(&hdmi->client);
>  	if (err < 0) {
>  		dev_err(hdmi->dev, "failed to resume: %d\n", err);
> @@ -1460,8 +1470,8 @@ tegra_hdmi_encoder_atomic_check(struct drm_encoder =
*encoder,
>  }
> =20
>  static const struct drm_encoder_helper_funcs tegra_hdmi_encoder_helper_f=
uncs =3D {
> -	.disable =3D tegra_hdmi_encoder_disable,
> -	.enable =3D tegra_hdmi_encoder_enable,
> +	.atomic_disable =3D tegra_hdmi_encoder_disable,
> +	.atomic_enable =3D tegra_hdmi_encoder_enable,
>  	.atomic_check =3D tegra_hdmi_encoder_atomic_check,
>  };
> =20
> diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/rgb.c
> index 227a178f761bd..d48d498068ac8 100644
> --- a/drivers/gpu/drm/tegra/rgb.c
> +++ b/drivers/gpu/drm/tegra/rgb.c
> @@ -90,7 +90,8 @@ static void tegra_dc_write_regs(struct tegra_dc *dc,
>  		tegra_dc_writel(dc, table[i].value, table[i].offset);
>  }
> =20
> -static void tegra_rgb_encoder_disable(struct drm_encoder *encoder)
> +static void tegra_rgb_encoder_disable(struct drm_encoder *encoder,
> +				      struct drm_atomic_commit *state)
>  {
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_rgb *rgb =3D to_rgb(output);
> @@ -99,12 +100,22 @@ static void tegra_rgb_encoder_disable(struct drm_enc=
oder *encoder)
>  	tegra_dc_commit(rgb->dc);
>  }
> =20
> -static void tegra_rgb_encoder_enable(struct drm_encoder *encoder)
> +static void tegra_rgb_encoder_enable(struct drm_encoder *encoder,
> +				     struct drm_atomic_commit *state)
>  {
> -	struct drm_display_mode *mode =3D &encoder->crtc->state->adjusted_mode;
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_rgb *rgb =3D to_rgb(output);
> -	u32 value;
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_connector *connector;
> +	struct drm_display_mode *mode;
> +	u32 bus_flags, value;
> +
> +	/* Get mode flags */
> +	connector =3D drm_atomic_get_new_connector_for_encoder(state, encoder);
> +	conn_state =3D drm_atomic_get_new_connector_state(state, connector);
> +	crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_state->crtc);
> +	mode =3D &crtc_state->adjusted_mode;
> =20
>  	tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_enable));
> =20
> @@ -201,8 +212,8 @@ static const struct drm_encoder_funcs tegra_rgb_encod=
er_funcs =3D {
>  };
> =20
>  static const struct drm_encoder_helper_funcs tegra_rgb_encoder_helper_fu=
ncs =3D {
> -	.disable =3D tegra_rgb_encoder_disable,
> -	.enable =3D tegra_rgb_encoder_enable,
> +	.atomic_disable =3D tegra_rgb_encoder_disable,
> +	.atomic_enable =3D tegra_rgb_encoder_enable,
>  	.atomic_check =3D tegra_rgb_encoder_atomic_check,
>  };
> =20
> diff --git a/drivers/gpu/drm/tegra/sor.c b/drivers/gpu/drm/tegra/sor.c
> index ebac9068b670f..45a9ea94c4355 100644
> --- a/drivers/gpu/drm/tegra/sor.c
> +++ b/drivers/gpu/drm/tegra/sor.c
> @@ -2203,7 +2203,8 @@ static void tegra_sor_hdmi_scdc_start(struct tegra_=
sor *sor)
>  	}
>  }
> =20
> -static void tegra_sor_hdmi_disable(struct drm_encoder *encoder)
> +static void tegra_sor_hdmi_disable(struct drm_encoder *encoder,
> +				   struct drm_atomic_commit *comm_state)
>  {
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
> @@ -2244,13 +2245,17 @@ static void tegra_sor_hdmi_disable(struct drm_enc=
oder *encoder)
>  	host1x_client_suspend(&sor->client);
>  }
> =20
> -static void tegra_sor_hdmi_enable(struct drm_encoder *encoder)
> +static void tegra_sor_hdmi_enable(struct drm_encoder *encoder,
> +				  struct drm_atomic_commit *comm_state)
>  {
>  	struct tegra_output *output =3D encoder_to_output(encoder);
>  	unsigned int h_ref_to_sync =3D 1, pulse_start, max_ac;
>  	struct tegra_dc *dc =3D to_tegra_dc(encoder->crtc);
>  	struct tegra_sor_hdmi_settings *settings;
> +	struct drm_connector_state *conn_state;
>  	struct tegra_sor *sor =3D to_sor(output);
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_connector *connector;
>  	struct tegra_sor_state *state;
>  	struct drm_display_mode *mode;
>  	unsigned long rate, pclk;
> @@ -2259,7 +2264,10 @@ static void tegra_sor_hdmi_enable(struct drm_encod=
er *encoder)
>  	int err;
> =20
>  	state =3D to_sor_state(output->connector.state);
> -	mode =3D &encoder->crtc->state->adjusted_mode;
> +	connector =3D drm_atomic_get_new_connector_for_encoder(comm_state, enco=
der);
> +	conn_state =3D drm_atomic_get_new_connector_state(comm_state, connector=
);
> +	crtc_state =3D drm_atomic_get_new_crtc_state(comm_state, conn_state->cr=
tc);
> +	mode =3D &crtc_state->adjusted_mode;
>  	pclk =3D mode->clock * 1000;
> =20
>  	err =3D host1x_client_resume(&sor->client);
> @@ -2657,8 +2665,8 @@ static void tegra_sor_hdmi_enable(struct drm_encode=
r *encoder)
>  }
> =20
>  static const struct drm_encoder_helper_funcs tegra_sor_hdmi_helpers =3D =
{
> -	.disable =3D tegra_sor_hdmi_disable,
> -	.enable =3D tegra_sor_hdmi_enable,
> +	.atomic_disable =3D tegra_sor_hdmi_disable,
> +	.atomic_enable =3D tegra_sor_hdmi_enable,
>  	.atomic_check =3D tegra_sor_encoder_atomic_check,
>  };
> =20
> --=20
> 2.53.0
>=20
>=20




