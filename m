Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A20E606A329
	for <dri-devel@archiver.kernel.org>; Sat, 28 Nov 2026 01:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=j999Tdlc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D6B2310EAF8;
	Sat, 28 Nov 2026 01:29:01 +0000 (UTC)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012013.outbound.protection.outlook.com [52.101.53.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5829010EAF8
 for <dri-devel@lists.freedesktop.org>; Sat, 28 Nov 2026 01:28:55 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZZnVRLIX7PZQB5Rf9xj0DEDw2JLAd+c5LxKYvNFWScZNg4x/eQlADCi3o+rDn4PY0Qz76iLpYgWzmz1s8Q/v+IfXIMdBfpI/0GzJqrP/d8HHxVcZP+Mxh1ooUFoNDWMdJN5l1szn9AJiGMTqmqwbk1w8KveTibSH09QbopTaUcEFTdbZG+2CXk9+2LvplAKy4ziYMSaeP1vd4ip9+U0FTlcJRvpHzuSh6PV8OvG5WVnjiiuZdvvt4OrMLowXIxGsLD1pfGR72K5Wj/pjEs+Hfzjn3q31k0uTc16wUj8jwN5ETmcQKt7CMA2pS1yxRCtoTMAP7CO6GWVMxSI5noFn6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zGOwSFxN0edfQj/G4mEegGtWrcAmhol3Bgb5It8TljE=;
 b=PTYakuKHA49y1Q1Nn56jff9oRgelxRZlOmwAdUzhe/By7crUMTi4i5/BerAXwd0+lazYsAmhcdaevPrT8b0kdeSjEGqo8IJtQ+uKL13b+kEE5wCzludBsuHTH+8cBTfXZtAhYUP7ltL+iypsVSPlMzAI26csNFGCNkH5eTSsCZUtUCiL8JCOEJ0xCymwf9GezwujF0nxTpL6VplMFAqNl7uYEY5KuDA3IWLg1o543GrQsdAr9pS/6dkBLCqelku21RWUnuNzMmRKh+pAuZOeILFj0cqjAzSBbxpUGxPvcnpab/TDwRITNBXTeDA9YRDVxFTbUjY2qNC89HKRO7wkNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zGOwSFxN0edfQj/G4mEegGtWrcAmhol3Bgb5It8TljE=;
 b=j999TdlcdpLjU+/Nsh9Re5i8zDJUnO8iqX/GA1fcc9Tb+2KyW4FDNq3kQZWsRvwJetpNl040n3GRuRU6izTMBVpve/ndNTTg6BBEacDC6pZJPP46VACk8pPW2h7ShjbV8pz/LCuVUui6ZDvfYNP1ED6eKT7RoAwMFMimsSl4Ya9j2fz7Sqgw4c6Fh2cnMf4zvnsi1ELcPnMXhsBwCzMMKowWKgfjIlB7F1W29+kjsMieV6eqN9QhsGwV19GWfriC8fJDjWM13Jhi4WtN7yanSqgXvbjtrJgb6Xt40YG5LP/XPiGdDzxVLKmGBPHRE9eRuHHjTp2DBsa84LdlNrs4vw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BL3PR12MB6377.namprd12.prod.outlook.com (2603:10b6:208:3b0::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.10; Sat, 28 Nov
 2026 01:28:50 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Sat, 28 Nov 2026
 01:28:50 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: devicetree@vger.kernel.org
Cc: devicetree@vger.kernel.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
Date: Sat, 28 Nov 2026 10:28:46 +0900
Message-ID: <TYDAsh0fQ52x0yM4_wAp5A@nvidia.com>
In-Reply-To: <CAPVz0n2xxEG5vR4X_dZeyQfN9TVSCBn+2uW1wY7Z+P3N8BhNqQ@mail.gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <QEeSnm4uTjq24quMQBzlfQ@nvidia.com>
 <CAPVz0n2xxEG5vR4X_dZeyQfN9TVSCBn+2uW1wY7Z+P3N8BhNqQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0028.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:263::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BL3PR12MB6377:EE_
X-MS-Office365-Filtering-Correlation-Id: f54bf2aa-d375-4a42-b428-08df4ceef4c5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|7416014|366016|10070799003|4143699003|6133799003|22082099003|18002099003|3023799007|11063799006|10067099003|56012099006|261026140227099003|261026121527099003|261028144727099003|261021123027099003|261021121427099003|261022105027099003|261022075727099003|261102123227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: Cp75Qhlf6dN7cL3b1wxu/njg7estD8hQBz9iffb+pdjJ6MaMxLu8FUt8ALMAdpGdbCe3Kepv3dFLdQ7XJXNeJRNbWXmDl1o3BHmM9gV8DENBDTgjgk3yAKRQdd2kFltrcwzvhUXZy+lESy1SHNXvzTkeKeg6LVV9zd+B/g7422h74A1c0jwxQTznwqboPI4q+LJk8t2RyMavVUdcY5hRoMtnWiMfPfdBgiWUHy0A8K/HK7TnEkYn2qTwzFPrM/VKFF+RZVp9yOnix73e3VrpfuML593opTDvY03oyZgeygLDETzQx5h7YRxx065F0beQsseOFe9Lxspy2pXLc3BMeL9XyEtubPVIJ6ZPbOh0PpyZo++13B5/s3GKeYF5NWRbc5a0/dqr4+FvDJcHfpg5yyM1ON1xPEoG+66+tvOJkQw8OOBIuWsXZa/Il1C/wG4DglQwisriZef3BqvdAtFOWA6bfmKEP7D8xJ+gk+KfLR8p9Vq7zTLdIZkVEueKVOIKCT4nbwu5CpXMIafM8EyybTfNewFHHxm4q72FMC8WJtgUw0fhu1m4IqwVCag/lwrG84id23yCvI94ZXIV6TAGcNGPnwoALF+O1hsEdWzy2KjhnLvHincHdFISb1JR1wXVxj1kV3/dXAU1rv1+fVaPZkw5M1OIn+igE62RYs7i6UU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(7416014)(366016)(10070799003)(4143699003)(6133799003)(22082099003)(18002099003)(3023799007)(11063799006)(10067099003)(56012099006)(261026140227099003)(261026121527099003)(261028144727099003)(261021123027099003)(261021121427099003)(261022105027099003)(261022075727099003)(261102123227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RHAzMWlRZExKbFhna0p3SFVCTU5MRDc0NVNTN2syMzNwbzMwVnpzQVVoNVcw?=
 =?utf-8?B?NkFndVVFQ3cvR293WW1jWGJzZnV6UklSVDZlWTc0K1NqZE5JNkpIMlNnUDdI?=
 =?utf-8?B?aE95Q2t0c3ZaL000TmFyWnZFcGpwdmNaWlJDKzZUKy93L1RCeEdLbUlWbWZl?=
 =?utf-8?B?K2l1TVo1Q0kzdXNKdHV4N2p0UlU2a3BNamNlc2FjdEM1RGdMZzVCUkpFQVY3?=
 =?utf-8?B?VGY5bVRuWFVNcWsrVjhIVllsUSt6ZUVnUWRCSHFYUUk1Q0JDcnpSdW8ycFlX?=
 =?utf-8?B?V1YwclZucjFBekM3R0tDTSt5MU9kNGgxa3NkRGVkM1pZVjJ6bXY4eC8wVG5E?=
 =?utf-8?B?QVAzcHJwandGejJpMk8zNWp0Q0hsYTRFdFFCR0RBUzVSbkJGMEVMYXNhVzVJ?=
 =?utf-8?B?VGZNcVJQNk1oekR1VHJOMGFIUnNhNHJudm5Ec25pOG0zWmpsamtBVWI0YTZz?=
 =?utf-8?B?UlRJRy9hY1lSYndxZGJndVhtNGo0RWpUUlFiWkNVd1dyclJJVUpMWWh6Z2U5?=
 =?utf-8?B?aWVYaGlobSthVy9XNUNVcEE1SlJWdlpWYWhNcXBJS0JCeDk4Wk9vR0pRTnVl?=
 =?utf-8?B?a09BQzZQVHhxU3FpR2pHeXl6VklsaThRZ1ZoOWhVUUd2RGNvOXlaUHNGS0pJ?=
 =?utf-8?B?RTZQNmY4U1IyMXV5NjdTMnlMWVZ0UXYrVWJSbGtuWEZoWDNaa29MUEFqZjRp?=
 =?utf-8?B?dStIYVJRSStFUHJaTW9OR0xYeld2RHpMM1c0Y29zQTVTbzNUUGx6VmkxS3pG?=
 =?utf-8?B?V3pOcEg0OFdQd1pBMVZpN3cwU2YvT3hCT29yVzQzVkE4dVBGdVQ5SEJWeUl2?=
 =?utf-8?B?Q0RjaDZtYWduYnhTTE04WlB1ZUZsUDcwZVY1S096VVVxSFB4S2tlYTJMR3ZP?=
 =?utf-8?B?a2x3T2YxNlZoaW9OU2hnWndIYnFCY25IL3pheGdhWEluejJ1OFJMQzVtbzJB?=
 =?utf-8?B?TEhnbFF0V1ArVzQyNDU4SnZXMGtEVDR0OGt3dXhnaHZmME1sQlQzRGJyNTlK?=
 =?utf-8?B?eWVaMW1acWpEMlNnWWYxTTNHODE5bk41U0FrazVKWnVzYjdFQ0svYzh0dVNn?=
 =?utf-8?B?bzl3V2gwb1ZUQVg1V3ZMb2Y3SG1lUlVjN3I4SVhvQkZDMTZTVG4vZWp3Zkhi?=
 =?utf-8?B?cTV2OTJ5Q3RWWTlSR1lqUGZNdzV5NnZTWS9PRWhDUTQxSHhSVWltM1YwdnBC?=
 =?utf-8?B?WmQ4bkg0SW1PN1dpeGtQdnBBMXlNSDB6YVFVM3RmOHUyWUl1RFpnUHBETncv?=
 =?utf-8?B?RXdZWVMza1pGYi9ZZEpMMVYzK24yMm84N0pyWDlLZlFJTFFlcGpBN21zRytw?=
 =?utf-8?B?MTBkWnBqRVptNjVFdTROaU54QkVCTFJ1Q05LM1dVL0R1VmY3RGVYQmtLeGI1?=
 =?utf-8?B?K005cm4veEdlSkE0ZkNtaTRtM1p1T2tXdm5maXRFYzdNWXFad1BpT00zY3py?=
 =?utf-8?B?QVpHNU51ellYem5JRkhWd1dPV2ZRK3VPNjhwQnZhU2hPcjZKT1F5aWVQL0RW?=
 =?utf-8?B?dnJEaFNwVFNVWFN4WWg2RzRLUzAzakxsdng5ZlU1cFB0R1BadnZCVWZNWVkr?=
 =?utf-8?B?eE9oMUtMbFdYSy9jQzJaZnZkdWRCM0MwdWI0Z3RsZmN0YjNqMmVZK3JEVDhV?=
 =?utf-8?B?QUVKN09WS3FuQ2ZGSWVaSmI3SWNvYVc3R3RBbEVvN2Z0aFRndjBoSktOUHBE?=
 =?utf-8?B?V1UrZm9NTmZ0UVJMSmh2YlowRTIxRjlHUENadkRyams2Y2RlbG9adDVORi9x?=
 =?utf-8?B?NVdhR3l6alBXSUpRdVdXRzlON0tXYWVnejRjRytZdHBpcTc2VjJhTklZWmZ4?=
 =?utf-8?B?ZFBXcEhGMktDUlJQbHJxK2dRNHBHb0JMSnFkWEsxM2J3YnlCdXhtMStTcHV3?=
 =?utf-8?B?WmdHQmtZTjVTL0c3T0JGWjlyelAxWWxmTlEyYmJiV0g0QVV2WnRkR01MczNn?=
 =?utf-8?B?YlNvY0puSkVZUlBhUFIxbUkzTVc4MmR4ZWdaNWV2eXFRTWwyT0grVG1GWU5x?=
 =?utf-8?B?Y2JTdUcycTVlYjBqU2Y0T2t1VDFHUkJDbkYvalV5YkNsRS8yVnE0ZXRvRkF5?=
 =?utf-8?B?SW16WTUvR1Z4K0hxaVRFSnpqaTVVWGZWNi8xT0kxaWk1M1FaNHZoM3lzTkJV?=
 =?utf-8?B?dm1ka09KZUt4N3RjemxtRG05a01mVUdqdDNCVStRREZrVGdXeW02SWhobkY4?=
 =?utf-8?B?aldLNE5WTzNZZW5lZnBoRmhVRjBDSHAxM2lmN0RPTTBSdzk4ajRsazlkYmR3?=
 =?utf-8?B?NnRrOTM4US8wMHVNWTlMSEs1UUdTQXBUUGFoZStYSXFHT2RiZVJWT0NWekgw?=
 =?utf-8?B?TGd4TFkxM2RNdG5paFkvNitmWEZkcFI1TStWU2pyeEdJTWp4UWZ5VFVQL1NM?=
 =?utf-8?Q?KeI3B9nBqn+Hy1wiv8IzlWl4UzzquNZbzUBe5k53IbRGJ?=
X-MS-Exchange-AntiSpam-MessageData-1: MingsDkVl+r21w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f54bf2aa-d375-4a42-b428-08df4ceef4c5
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2026 01:28:50.3967 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 66ZgphdK8ZiFdkXYOIL9rNp7oedNqGhbtQe1oTtRWzBU5QedO69CIo+OcFtVgGI85Xy4tuOdfU3BFubs33D31A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6377
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

On Friday, November 27, 2026 10:21=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 14=
:35 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Friday, November 27, 2026 6:21=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 08:22 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote=
:
> > > > > Parameterize configuration based on bus flags passed from the bri=
dge or
> > > > > panel. The list of supported flags includes now pixel clock polar=
ity,
> > > > > display enable (DE) polarity, and data alignment.
> > > > >
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/tegra/rgb.c | 39 +++++++++++++++++++++++++++++++=
++----
> > > > >  1 file changed, 35 insertions(+), 4 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/tegra/rgb.c b/drivers/gpu/drm/tegra/=
rgb.c
> > > > > index d48d498068ac8..faecd6f94359f 100644
> > > > > --- a/drivers/gpu/drm/tegra/rgb.c
> > > > > +++ b/drivers/gpu/drm/tegra/rgb.c
> > > > > @@ -5,6 +5,7 @@
> > > > >   */
> > > > >
> > > > >  #include <linux/clk.h>
> > > > > +#include <linux/media-bus-format.h>
> > > > >  #include <linux/of.h>
> > > > >
> > > > >  #include <drm/drm_atomic_helper.h>
> > > > > @@ -106,6 +107,7 @@ static void tegra_rgb_encoder_enable(struct d=
rm_encoder *encoder,
> > > > >       struct tegra_output *output =3D encoder_to_output(encoder);
> > > > >       struct tegra_rgb *rgb =3D to_rgb(output);
> > > > >       struct drm_connector_state *conn_state;
> > > > > +     struct drm_bridge_state *bridge_state;
> > > > >       struct drm_crtc_state *crtc_state;
> > > > >       struct drm_connector *connector;
> > > > >       struct drm_display_mode *mode;
> > > > > @@ -117,12 +119,21 @@ static void tegra_rgb_encoder_enable(struct=
 drm_encoder *encoder,
> > > > >       crtc_state =3D drm_atomic_get_new_crtc_state(state, conn_st=
ate->crtc);
> > > > >       mode =3D &crtc_state->adjusted_mode;
> > > > >
> > > > > +     /* Get but flags from the bridge state. */
> > > >
> > > > s/but/bus/
> > > >
> > > > > +     bridge_state =3D drm_atomic_get_new_bridge_state(state, out=
put->bridge);
> > > > > +     if (bridge_state)
> > > > > +             bus_flags =3D bridge_state->input_bus_cfg.flags;
> > > > > +     else
> > > > > +             bus_flags =3D DRM_BUS_FLAG_PIXDATA_SAMPLE_NEGEDGE |
> > > > > +                         DRM_BUS_FLAG_DE_HIGH |
> > > > > +                         DRM_BUS_FLAG_DATA_MSB_TO_LSB;
> > > > > +
> > > > >       tegra_dc_write_regs(rgb->dc, rgb_enable, ARRAY_SIZE(rgb_ena=
ble));
> > > > >
> > > > >       value =3D DE_SELECT_ACTIVE | DE_CONTROL_NORMAL;
> > > > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DATA_ENABLE_OPTIONS=
);
> > > > >
> > > > > -     /* configure H- and V-sync signal polarities */
> > > > > +     /* configure H- and V-sync and pixel clock signal polaritie=
s */
> > > > >       value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARIT=
Y(1));
> > > > >
> > > > >       if (mode->flags & DRM_MODE_FLAG_NHSYNC)
> > > > > @@ -135,11 +146,31 @@ static void tegra_rgb_encoder_enable(struct=
 drm_encoder *encoder,
> > > > >       else
> > > > >               value &=3D ~LVS_OUTPUT_POLARITY_LOW;
> > > > >
> > > > > +     if (bus_flags & DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE)
> > > > > +             value &=3D ~BIT(PIN_LSC0);
> > > > > +     else
> > > > > +             value |=3D BIT(PIN_LSC0);
> > > >
> > > > I think this is the wrong way around: SAMPLE_POSEDGE means that the
> > > > pixel data is sampled on a rising edge. That is, it should be drive=
n on
> > > > the low edge so it's ready for sampling in time for the rising edge=
.
> > > >
> > > > LSC0_OUTPUT_POLARITY says that the value "LOW" (a bit confusingly, =
1)
> > > > corresponds to a data transition on the falling edge, i.e. sampling=
 on
> > > > the rising edge.
> > > >
> > > > Section 31.9.6 states this a bit more clearly: "an active low pixel
> > > > clock means that the data changes on the falling edge of the clock,=
 to
> > > > be latched on the rising edge".
> > > >
> > >
> > > DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE =3D DRM_BUS_FLAG_PIXDATA_DRIVE_NE=
GEDGE
> > >
> > > Should I replace with DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE?
> >
> > No -- with the current code, let's say
> > DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE is set. I.e. the panel tells us tha=
t
> > it will be sampling pixel data on the positive (rising) edge.
> >
> > LSC0_OUTPUT_POLARITY will be set to 0. The TRM documents the value 0 as
> > "active high", and "means that rising edge coincides with data
> > transition". That is, the display controller will change the output pin
> > state to color data on the rising edge. So the SoC pins will change
> > state at the rising edge, and the panel will sample at the rising edge.
> >
> > But the pins will take some time to take their new values, so this migh=
t
> > not work or could be unreliable depending on all kinds of timing
> > factors. So if the panel is sampling as the rising edge, the SoC should
> > be driving the pins at the falling edge, that way there is time for the
> > pins to settle before the panel samples them.
> >
> > So the value written to LSC0_OUTPUT_POLARITY should be the opposite of
> > what it's now. If that breaks the panel, either it's reporting the
> > incorrect DRM_BUS_FLAG_PIXDATA_SAMPLE_* value or something else is
> > incorrect.
> >
>=20
> This may/will cause regressions across multiple panels and devices.

Looking at the panels we have, if we retain the previous behavior when=20
neither PIXDATA_SAMPLE_POSEDGE nor PIXDATA_SAMPLE_NEGEDGE is set, then=20
we'll retain the same programming as we've had before.

Actually, from what I can tell, the change in this patch will change the=20
programmed polarity compared to before the patch for the panels/bridges=20
on the Colibri/Apalis/TF700T boards, which do specify SAMPLE_POSEDGE.

So if we flip the logic around, and default to SAMPLE_POSEDGE if neither=20
is specified, we should retain previous programming for existing panels.

>=20
> > >
> > > > > +
> > > > >       tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(=
1));
> > > > >
> > > > > -     /* XXX: parameterize? */
> > > > > -     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ALIGNMENT_MSB |
> > > > > -             DISP_ORDER_RED_BLUE;
> > > > > +     /* configure DE signal polarities */
> > > > > +     value =3D tegra_dc_readl(rgb->dc, DC_COM_PIN_OUTPUT_POLARIT=
Y(3));
> > > > > +
> > > > > +     if (bus_flags & DRM_BUS_FLAG_DE_LOW)
> > > > > +             value |=3D BIT(PIN_LSPI);
> > > > > +     else
> > > > > +             value &=3D ~BIT(PIN_LSPI);
> > > > > +
> > > > > +     tegra_dc_writel(rgb->dc, value, DC_COM_PIN_OUTPUT_POLARITY(=
3));
> > > > > +
> > > > > +     /* configure DATA order and alignment */
> > > > > +     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
> > > > > +
> > > > > +     if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> > > > > +             value |=3D DISP_ALIGNMENT_LSB;
> > > > > +     else
> > > > > +             value &=3D ~DISP_ALIGNMENT_LSB;
> > > >
> > > > DRM_BUS_FLAG_DATA_LSB_TO_MSB does not seem the correct thing to che=
ck
> > > > here. According to the TRM, DISP_ALIGNMENT doesn't swap between LSB=
/MSB
> > > > bit ordering in a classical way, instead:
> > > >
> > > >   // DISP_DATA_ALIGNMENT =3D 0 (MSB)
> > > >   LD[23:0] =3D {R[1:0], G[1:0], B[1:0],
> > > >               R[7:2], G[7:2], B[7:2]};
> > > >
> > > >   // DISP_DATA_ALIGNMENT =3D 1 (LSB)
> > > >   LD[23:0] =3D {R[7:0], G[7:0], B[7:0]};
> > > >
> > > > I suppose MSB is more natural for 18-bit panels and LSB for 24-bit
> > > > panels depending on the layout. So the correct value depends on how=
 the
> > > > panel is wired to the SoC on the board. Hence, I think we should
> > > > describe this with a new property in device tree under rgb/dbi or
> > > > endpoint node. Something like 'nvidia,rgb888-wiring' for LSB? And
> > > > document that this means the above kind of wiring - not all RGB888
> > > > panels use it.
> > > >
> > >
> > > Ugh, why is this so confusing...
> > >
> > > > > +
> > > > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONT=
ROL);
> > > > >
> > > > >       tegra_dc_commit(rgb->dc);
> > > > > --
> > > > > 2.53.0
> > > > >
> >
> >
> >
> >




