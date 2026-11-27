Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DF1606A336
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eccrOlce
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C284610E3C0;
	Fri, 27 Nov 2026 12:20:59 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A30DD10E598
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:20:49 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oioaLbKtw8qhsigFOHostIg+WS9vZmP8LKsrHPO3WiMNzLfl7X4xf0nVdpODSdZlPwedYedvHYLmdnrPg0HLSBX79Kt4rgdqYlcSq+ZTps/vXI3ZyvLFCjEvqDfmJTqCSDkRFpQ3thA2M4vfCg7aL8aNNdH5ccI9cHAmKCguML1gBxYPECOqR7mtZBNhK2AGokJf3gXokaBPGQOe1UTljeEpCfOq4xOZvawsMOhsbWoxkEoq1CC5eh+2nVk5O7emrH0SNKC59FOBZuauwv+v7iAKFq2ZBLH0RPkNvAd81j372JTO/BW6njQKLrSgU7oiIEImXnhaWxh+k0KXhvkzbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iZaJlBxklrKrbntWwCEFd67ugxTK9ihbgeLxzUI1ixw=;
 b=j0WaIGdD48SQFVJ5QWSjv7Bdqv8O368uV4nATak3OONptI3ocgqcIOXJ2HVloj6wVgmMrCfPwsQ3GH8DfVSsPY9KpiwY4YyXZM7Y7f0tUtM2sK73hysDXutbY83cMKrtHPlDBnpe/ogV/p5d8XdLuQ3IKVrWlR8DX0lRnvM2P3wCnSoIijBzlhULs7+4rGE2DotiGKsHP7fmCzF4NOAYAirnNoZWlln2rRjDaCDL0bP0R21pYZs8uWiHnXQfLM6kc+diG7ARl8fHUVL5pZOxER/GrJ2ZHHFtSxSVM4b+f+WTNb1un74rSFDEhiFX38mbu/BOTXw0icsyWlJS2aCpYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iZaJlBxklrKrbntWwCEFd67ugxTK9ihbgeLxzUI1ixw=;
 b=eccrOlcejzvp6avlY3zp3FgRuGu2EIu8i9/O9NFe6kTUUQ/bIWBKNjn845F7R969NBJqrfv+oG0+uLaabydge/K4fvM+TU5PN6X6goh5yydyFvaHOb7/GW6c95DJ6//cDU9pMcqR8xO+KZq9XX8aTXG+5zmQ+DIHzR/YF4eDCYy+f4NptT7c/LxSJA5iF7GLC7uvBlI7o2cqBTulWZWj7mhFGdlTumXl4x8QwuE2ZwXSYGShcadA7k8cgfPdK7y/qoZpi1FVLjY1L42l2kTWFnYA8Xo7skg17pmtbkeh7gyWNJbswnHuu2wf632EIJmaJumZ6EXhAiTOVCynCQen2g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 12:20:43 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:20:42 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: devicetree@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v8 02/12] drm/panel: panel-hitachi-tx10d07vm0baa: Convert
 to use MIPI DBI bus
Date: Fri, 27 Nov 2026 21:16:51 +0900
Message-ID: <uQ14beL2SOumMxaLqMFc4w@nvidia.com>
In-Reply-To: <CAPVz0n0Qyekm7qUyCVFMTDSuVSw=1my4x-rgiafp3+mQ_sgk3Q@mail.gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <hlO8KiQKSi62yShZAIyhpw@nvidia.com>
 <CAPVz0n0Qyekm7qUyCVFMTDSuVSw=1my4x-rgiafp3+mQ_sgk3Q@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0247.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:456::18) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 7da671f5-8676-4cc7-6f57-08df4c80db2c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|10070799003|7416014|376014|10067099003|56012099006|261022075727099003|261022105027099003|261022113327099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|261009223027099003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: p66KKkEIejSwtTCtzNc8IoyPqg9jEN/s7EFgQ5VJjxnc+GtnwbuQN9Vk8OfT7fo+PSFHNzGSpTtdQLXooDBhnim2jIvDqnD5IyviDpg6wXd4/KKMBrJtF/cfJhgj2XXU596gW1+/UtIwDQt5uNCeC5i/uBAdL2NrMskqBkfnTB8WipWXm3V7yzI6d7wdMTtNuZY1owY6WtpNq3wZdne6yd5yvcMWl8V2HSSbDYrTehsVOf1SZpkuBqpEpSwEcUm6aXk4qOrU3l28K4+ovDX1YIkXi1UZNU+9xCHvBZGgC/uuZDEuji4OOUamX2KawS5NGNAEnBVAumEAjyrSxtvZ7Xi4QDC/9f08hknXuKTI/l8jCszmRchNQWx1Hl+UkdLgaL+kYp1v2duw8jQc8ZGpL4o5scyS3arrj0JBASrPpGvf0AM0M0UwobE/WRVFEKMUhAnQXM5C8TA4SflNsPXtQUrLtU2KPgnDALzOm1R4AIg32dRou/t+WQodcMsSoOhQnY44mbWmsfQFvXPT7/MnPXwr4yKfSlkGh4uOIljtYBsaXEdjcNc9fN/c9+wilCKKscIzsiqssg80rkqJv44awfICXlQ31RrvMejN7cdPBulm39t7ntII5sjpBcbiPHoX+BOsRmzE5hH/z2i5e8AH173mZsmxqDXtV0rVzxkBIxM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(7416014)(376014)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261022113327099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkpNODhTT2hodVNEMDV5NzdRU0ZlMlovY01rcFY3alpvOXRFWmxnYkZQeEtB?=
 =?utf-8?B?SmY5bEN2SEFTWFhBNzg4UFJNQ01kc0ZkVzhzMUgyaGVzdHRtbnpYZVUwTFll?=
 =?utf-8?B?QmduaFliREQvUDIrYjZUQlZ0Q3Q2aGlSQitUM2NFbTIrYzhUQk9NMHFjVysy?=
 =?utf-8?B?MnMvUjEvTHFaempBT3hDa0xqdGhBZk9xZnRZZWFBSjR0NmZLeCt3VnZzZm13?=
 =?utf-8?B?UWY2NXprZHJyQVh0NVFLYmI2RW83bVNyelkvUUF6ZnYwbzJ4bWJHMlNPQ0gz?=
 =?utf-8?B?ZlkyN2xTWHVlN3d5RnlaeWRFK0dZZjRpWVJONFlNODBuOUoyWnFiaDBOc0FJ?=
 =?utf-8?B?elFtUmRDOG5URWNoWDNBaU8vZHJnQ0tROU40bHZRQjZYYlRPTzdZYmVSYXRE?=
 =?utf-8?B?M3l3ZlpyNXFiVmdtM0xQMkdtTVlDM3JWVDN4MUF4cmk5cTlQQ2t2cmJiRWRF?=
 =?utf-8?B?Wm9KYmNzckRpVlFRNjB4djVkRktvYkg2RVV0SzI5bHQvMDRQclR5VXRXL1dD?=
 =?utf-8?B?ZTBjS1B2NU5nYjArTXcvZnhKUm1vVjhZUU5HVWVnL2k0cDFhK1RRR1FETDU1?=
 =?utf-8?B?MkRRUTBEd1BGcCtIb2s4aFFqTmtZWnhNMmJicW5DUjZ0QXNLc3FEcVNGc3hi?=
 =?utf-8?B?ZVJyRkthcitVK1dIblBKOEhmRzZPd0tWNDF6Yk9jMHhhR2lraDVzTUNCK3VC?=
 =?utf-8?B?Z092S3B6MCtTN0NxbUpPbjJJdkhQMDFwUkNDS09CbWZlNnIvNVZFNjZmaUY5?=
 =?utf-8?B?TXJXUmhWVjgzeDhFMWFBSGtiTzlhTmxlQzdvSStkODF4Zmg0ZzQ2OEpaeVpW?=
 =?utf-8?B?aE1rQjBOOE1QUVVmc2QwNFJqR1FLRGpDZyswQ2hEcFZ4MFhWVkx6U1JDNE9w?=
 =?utf-8?B?THhCZk5JazIrOFR2YmdxV01QMHJsbDZWTmh4RU1yNXhkNTZFWUh6ZWRGd1FG?=
 =?utf-8?B?SnVjQTJ5WGdwNHlmd2hVNVNrRmV6R3hTVXNpNjFtbmNIaU5zWklZUHcwTGp3?=
 =?utf-8?B?NXdrTlVjaWlsMTI3NU1rYzY0SXp1TUhWOXJvOTMxTHdzNDFlcnNpNk9GMEdq?=
 =?utf-8?B?aW5kMDVLRjFCNTJ2a21FeWFPc3duODVlQXc1SEtxTnJNR3V2NjFWQnVyUHI1?=
 =?utf-8?B?dVJNOFRKazljUHFGbjZBSzF3M2ZjRFhBN2ExQkxWQ1JkMlYzVTZLaVBlRTRo?=
 =?utf-8?B?T21reXNxcjBKSUpwYTlSMENjQXY4OElueDFyR2phRm1DYThYa0ZMVUYyMzF0?=
 =?utf-8?B?SmpGVWlaemQ5dmxWNjl6VCtuVTBRMFQ2c0N6QzZkbk9YVEFLUk1tQ3pIamxv?=
 =?utf-8?B?UC94bE8wNEVPa3pZdVFGWi91OTNQRWZUaDJMSnpsYUpLTTVsWE43RG51Rnoz?=
 =?utf-8?B?OUxGVkdUbThMN3h1d3VUN3V4WXB3T0pBU2NEeWRWZkJGNFhCZENtNVdPT0xJ?=
 =?utf-8?B?RnF6VDZyclhQNmptRDZObUZ6eGcyT1JmaDVNMTdxRWVLSDljTTlmMnphQ3Fq?=
 =?utf-8?B?VStocXAzRmZKR0lQY2syUHQ1U0g1U3hpVWtrS3dPQUVyUFV5cDJFRmRYdjhI?=
 =?utf-8?B?SnpNVUkwQWU5RE5TL3RFNFlmWEhQbVcrK3kwSXR4Wmxpd1kxdXNQSEdxV3dW?=
 =?utf-8?B?ajJxRmlHOW5aV1Jwb1djTFc2VEFkUktDMnlKRDhiV3VIT3B6Q1ZlQWhsaTlC?=
 =?utf-8?B?Rzd0bStlOCtqYkgyNHVGa0hadCtjc0F1a1BKd3JaTU9CaURGWlNFMVdvcGNP?=
 =?utf-8?B?alUvekhEWnR6WCtjbVJYR3JVTU90Vzd2NVd4RDNLMVd6YUhvemg2OGRUcEx3?=
 =?utf-8?B?NkhZY09HR2FPTmp0QkFVNit6eVZHVEF5UEM3bERLY0NnVzVsa3I4QUtkWE1p?=
 =?utf-8?B?ZjFXc1RpQzhIZGNvaTk0THdncjQ5N0JxQS9HUzFWQjFpNEFsaWpYRVpJM0pr?=
 =?utf-8?B?cEI0bWNCdVJaSWZ4Yks0aHhvYTRsVDJESGxwd3RNTEZudVZKU2grcHl0V0Iz?=
 =?utf-8?B?UVdLNzAxRzBGWXJsLzVReEExSHRrNVp3Wm5EUC9LRzM0Q0FrcFJtcGxmWVhn?=
 =?utf-8?B?ZFdaOEhtZzhLUnplSUVieVRtU0VUcFJCL1d3bStSdVlJTDR2Ri9TTnhGalZq?=
 =?utf-8?B?MTNUTVZxa2NyYTVTZGY2eWR4K1c5VFVXUUFVNGl3TjkzRDhhWHNEZncydXRZ?=
 =?utf-8?B?Y3dMcmRFWU9xRGh6azBIU0NHL0pYK29yT3JGN1JQNTlsem96NnpIdnVZU0lD?=
 =?utf-8?B?MmdmNzVSeFVUWTJTM0xNYXBiMUtZTVAwaUZjRzkxNml4M3g3SW5jU1ZYa1Bl?=
 =?utf-8?B?dDdESHBuR0V4QzVkSGdJeGlLM1NsUmhTTVZoVFE2N3JGV21YRzk4b3g0eHBL?=
 =?utf-8?Q?S3VCsEMNiAG3HfFd84U8EncDbI1bQ7kmeqnUNNctrcdZB?=
X-MS-Exchange-AntiSpam-MessageData-1: lXw6C31D5OPvYQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7da671f5-8676-4cc7-6f57-08df4c80db2c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:20:42.8627 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xo/AerZYIfmVyu155E+PsLvIKvIO8rUsV+IhxdGWQ37sByoBD7qpMQxuqLitPW7lNtllOtcnp1dl6w/HcAOANA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPFB8FBD73EA
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

On Friday, November 27, 2026 6:10=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 06=
:23 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > Switch from a generic platform driver to a dedicated MIPI DBI Type B
> > > driver.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  .../drm/panel/panel-hitachi-tx10d07vm0baa.c   | 25 +++++++++--------=
--
> > >  1 file changed, 12 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c b/dr=
ivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > index 83c2af1be9755..318ece68b7806 100644
> > > --- a/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > +++ b/drivers/gpu/drm/panel/panel-hitachi-tx10d07vm0baa.c
> > > @@ -14,6 +14,7 @@
> > >  #include <video/mipi_display.h>
> > >
> > >  #include <drm/drm_mipi_dbi.h>
> > > +#include <drm/drm_mipi_dbi_bus.h>
> > >  #include <drm/drm_modes.h>
> > >  #include <drm/drm_of.h>
> > >  #include <drm/drm_panel.h>
> >
> > You should now be able to get rid of includes of of_platform.h
> > (replacing with of.h) and platform_device.h. Agent says drm_of.h and
> > property.h are also unused.
> >
> > > @@ -25,7 +26,7 @@ static const struct regulator_bulk_data hitachi_tx1=
0d07vm0baa_supplies[] =3D {
> > >
> > >  struct hitachi_tx10d07vm0baa {
> > >       struct drm_panel panel;
> > > -     struct mipi_dbi *dbi;
> > > +     struct mipi_dbi_device *dbidev;
> > >
> > >       struct regulator_bulk_data *supplies;
> > >       struct gpio_desc *reset_gpio;
> > > @@ -40,9 +41,10 @@ static inline struct hitachi_tx10d07vm0baa *to_hit=
achi_tx10d07vm0baa(struct drm_
> > >  ({ \
> > >       const u8 d[] =3D { seq }; \
> > >       struct drm_panel *panel =3D &(priv)->panel; \
> > > +     struct mipi_dbi_device *dbidev =3D (priv)->dbidev; \
> > >       struct device *dev =3D panel->dev; \
> > >       int ret; \
> > > -     ret =3D mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SI=
ZE(d)); \
> > > +     ret =3D mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_=
SIZE(d)); \
> > >       if (ret) \
> > >               dev_err_ratelimited(dev, "error %d when sending command=
 %#02x\n", ret, cmd); \
> > >       ret; \
> > > @@ -54,10 +56,6 @@ static int hitachi_tx10d07vm0baa_prepare(struct dr=
m_panel *panel)
> > >       struct device *dev =3D panel->dev;
> > >       int ret;
> > >
> > > -     priv->dbi =3D dev_get_drvdata(dev->parent);
> > > -     if (!priv->dbi)
> > > -             return -ENODEV;
> > > -
> > >       gpiod_set_value_cansleep(priv->reset_gpio, 1);
> > >
> > >       ret =3D regulator_bulk_enable(ARRAY_SIZE(hitachi_tx10d07vm0baa_=
supplies), priv->supplies);
> > > @@ -243,9 +241,9 @@ static const struct drm_panel_funcs hitachi_tx10d=
07vm0baa_panel_funcs =3D {
> > >       .get_modes =3D hitachi_tx10d07vm0baa_get_modes,
> > >  };
> >
> > Unnecessary semicolon here.
> >
> > >
> > > -static int hitachi_tx10d07vm0baa_probe(struct platform_device *pdev)
> > > +static int hitachi_tx10d07vm0baa_probe(struct mipi_dbi_device *dbide=
v)
> > >  {
> > > -     struct device *dev =3D &pdev->dev;
> > > +     struct device *dev =3D &dbidev->dev;
> > >       struct hitachi_tx10d07vm0baa *priv;
> > >       int ret;
> > >
> > > @@ -264,6 +262,9 @@ static int hitachi_tx10d07vm0baa_probe(struct pla=
tform_device *pdev)
> > >               return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
> > >                                    "Failed to get reset gpio\n");
> > >
> > > +     priv->dbidev =3D dbidev;
> > > +     mipi_dbi_set_drvdata(dbidev, priv);
> > > +
> > >       ret =3D drm_panel_of_backlight(&priv->panel);
> > >       if (ret)
> > >               return dev_err_probe(dev, ret, "Failed to get backlight=
\n");
> > > @@ -272,9 +273,7 @@ static int hitachi_tx10d07vm0baa_probe(struct pla=
tform_device *pdev)
> > >       if (ret)
> > >               return dev_err_probe(dev, ret, "Failed to add panel\n")=
;
> > >
> > > -     platform_set_drvdata(pdev, priv);
> > > -
> > > -     return 0;
> > > +     return devm_mipi_dbi_attach(dev, dbidev);
> > >  }
> > >
> > >  static const struct of_device_id hitachi_tx10d07vm0baa_of_match[] =
=3D {
> > > @@ -283,14 +282,14 @@ static const struct of_device_id hitachi_tx10d0=
7vm0baa_of_match[] =3D {
> > >  };
> > >  MODULE_DEVICE_TABLE(of, hitachi_tx10d07vm0baa_of_match);
> > >
> > > -static struct platform_driver hitachi_tx10d07vm0baa_driver =3D {
> > > +static struct mipi_dbi_driver hitachi_tx10d07vm0baa_driver =3D {
> > >       .driver =3D {
> > >               .name =3D "panel-hitachi-tx10d07vm0baa",
> > >               .of_match_table =3D hitachi_tx10d07vm0baa_of_match,
> > >       },
> > >       .probe =3D hitachi_tx10d07vm0baa_probe,
> > >  };
> > > -module_platform_driver(hitachi_tx10d07vm0baa_driver);
> > > +module_mipi_dbi_driver(hitachi_tx10d07vm0baa_driver);
> > >
> > >  MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
> > >  MODULE_DESCRIPTION("HITACHI TX10D07VM0BAA MIPI DBI Type B panel driv=
er");
> > > --
> > > 2.53.0
> > >
> > >
>=20
> I agree that your suggestions are ok, but they are out of scope of
> this patch. They would require either dedicated commits or can be sent
> as followups later on since they do not cause bugs.

I don't see why the include changes are out of scope. The platform=20
driver was including platform includes but now it's no longer a platform=20
driver so it shouldn't include platform driver stuff. The rest are minor=20
enough that I think they can be included as well.



