Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF1DF606A32C
	for <dri-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:31:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iNpAtZTj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0432510E8B9;
	Sat, 31 Oct 2026 01:31:08 +0000 (UTC)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012043.outbound.protection.outlook.com [52.101.48.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2089910E056
 for <dri-devel@lists.freedesktop.org>; Sat, 31 Oct 2026 01:31:01 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j4x4JP3kqw8PMjfrGEVl5erYrCNHZ0OPq+OV8YU5/YEf7LgvtzDYQmT37FFns2d6Uq09sfegihIZ2n3jo3B7Mc2OiQltbY5GpQw/5EP+CvUZPLTv+3HZKY6uInfnw6GJ4fVWOnddNaFkry1dp5UOZ0F5yyfgt7m3NS6C1KXfoYy1/PttqNLOFLOeZDPpA4TAny30er9IkWmqcW5LZ1IcYeiWYkDtcHKr/2dklEsgYXJhCVy+yd56LuzGKA1MRAYSNLMtYze3+hgLtw2XCkd4U6Etz9RriN2p9X3y+ddCaHOEAAv66hU7L1n32nCRyZ1KOgFBERzD8O/ymTVCtRgieg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+T9AiBLS3ALrg30192Tn7xsPWVJvRyqVTsAfGqR0C0=;
 b=m0erkftMJL+lgQ9SWnaOryoIPpxpzWDR/IdoC2HR3CoxKtsVsYXg4otljjxJ2iWUY3C63V1pTULXkDuo6S8gE/Sn+8IG9ZmynviReqxtwQ+s4/uOQYEB7n7QghXHjvAbHJBFWwI+vs/yWQjcqec4zzl4oS5qAtd7LsgkiUKVowVtr4s6j4YEF3oJ+RdbcZ9s5LFo7G5d9VbI772609Hx9fdn3HXd4tGVAUsfyES5NpdEuAbm2rBq1R97fbk22kloHCiumFSE+LNpF1hXHgsvcrKoKghTHLnye7iAngfKusfOaev1yWmAM+uRIiBC1Cl8/2CG9alag4Vv9RJ95E/5/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C+T9AiBLS3ALrg30192Tn7xsPWVJvRyqVTsAfGqR0C0=;
 b=iNpAtZTjz6C4WwOeR9zyAVbyZBfmZay778ouNRcnTbzngRIWOdz0mLacAKXSgUYJ7a3q9BMdrnvS8uebV5JyEKOJU6FpM1ImiM6GGUX3OmCyXFTvijexOrxSpCKu/1YhD1lpUYs6GrotNBlLT6Le4JnHCSXpR67W9RGgSgxOQtgSu3M0C0ywac0MPYBzoyX/qW+uogIgM5wjpnd5QJ5Jjjld+REGmMUYIvQ7HHVzGg9Vmj8Q3lElRHppsMsPEdS7wsJgX6wA9iKhf02XhSMcpvh9i0lhQPcwBgyn/xjyG8zDFgp2BBuT+WzMyyt6xKDAbq6zmGpy8pPTu6SpBWFY+g==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DM6PR12MB4353.namprd12.prod.outlook.com (2603:10b6:5:2a6::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.10; Sat, 31 Oct
 2026 01:30:55 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0569.008; Sat, 31 Oct 2026
 01:30:54 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>, devicetree@vger.kernel.org
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-tegra@vger.kernel.org, Maxime Ripard <mripard@kernel.org>
Subject: Re: [PATCH v5 01/11] drm: Add MIPI DBI bus support
Date: Sat, 31 Oct 2026 10:30:49 +0900
Message-ID: <wkoWhtHcTeCIo_G2MZlRcg@nvidia.com>
In-Reply-To: <auS1aG5y3nmnDkVu@houat>
References: <20261029152909.234584-1-clamor95@gmail.com>
 <CAPVz0n3K74CZemDzVVymmjU_5GUGE9FsEKk555-AJfG0jek_hg@mail.gmail.com>
 <auS1aG5y3nmnDkVu@houat>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS7PR01CA0006.jpnprd01.prod.outlook.com
 (2603:1096:604:251::8) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DM6PR12MB4353:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a721390-3731-4666-18d4-08df36ee9af1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|10070799003|376014|7416014|4143699003|11063799006|56012099006|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261022105027099003|261022075727099003|10067099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: wJkk0PLrQlPxQYoiozW3e6gDNFPgBp1/5GO003TuUqL0gzGZhABxGoWFjcVJIo1hANYR6Feigwm/K81ModzAniLHYVsi+tQ4DQG1Cs5s7CHW8v3CCMzLroopsTP8oNAlsGbbJFtPKhC+AGWlFC4fxX28P6fmCyPFGU5A6xUvgspUvt153qfaWM9NuNuj525ioClyi9ZhIKa1nxHpyBV36+DDET3nFCCley64AQpEB5X9XrasLg9eVnHy5cjGOaXLfyon46MmepzvBVdwG3SaiWC/u2xVhE0Yfbq22ScDFiuzTRzUxJB/vQk8JzJGz7WTGknFSuasKklFysSGOvgzn8n7vNtOQ1CTnuvo7rD629JsLl2i8o8Q/kYJnC0TsOf7MO7qbLBsXCfG6uXPPjynEJV9vySVhryGYru+mUZdZSB5w4THCaOFszYcS5XSKE5FlAOdOZgog+Vc6bP5SDR09oCw3ydCImSN+WnBmXenms5ThgTKaqASNtjv6AdPWsVN/WROA5A0aTLIdpcz3iYkyd9d/MFIvVWNhgkNNY1qnpLghLRzr39Xk9Ksa2r2MNHkfAkbs4j/rii+Z7xBOf7rbNTTTI4xR1oja3+tsiD7Uhfc2PTRs74M+COmokD6RRvvw50Qdepc6YzNx5CjKScQNgnZ6DBBeVkSf20FpXuqKiY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(10070799003)(376014)(7416014)(4143699003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261022105027099003)(261022075727099003)(10067099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UG9kSXlLYU41WXB0d3NRanY4K1RGTXg0dHFXRmQyWkVyamhHampiamp5L1My?=
 =?utf-8?B?SEE2SlVUL0Y0U3NIbnpiY1pnWExtUWI0dlg5TzArWWZJRDJwbnp2NEptbExP?=
 =?utf-8?B?MmFHWmdLeTd4WiswUFhPSXE1c244UnVIbXgxWFF0VXR6T0p0blYwM1Bua3J5?=
 =?utf-8?B?OTBVL1NEVHQzUm55enZoVVVnbHBrQ2NJQm9URlV4WVZHYnpmeXBPRllmYjBr?=
 =?utf-8?B?clNPWW5lUU5KRkNab0VsZ2JTZU5zT3dsR3FEUjNiNUpjNnQ3VE5HbVN6bzI3?=
 =?utf-8?B?QXRYR0JhbkNYMUhlaXQ0NnpIdnk3WkR3a1dsOXRTZmwwYVlWdTUwVzlBT3dR?=
 =?utf-8?B?d2J6NEVyVkJqYmZ2RW1zM2FXVnN0ekJhNWVkd1REelFIaDl0Y0VoYit3Ri9M?=
 =?utf-8?B?ekNwZXIrc0RzQ01CdWV4QWNHQVJsZEpBM0hWS2l5d3YwSTJmYUJsU0JOQkcx?=
 =?utf-8?B?aDBJRWYvdlp1b1JJZWw1Wk1rUU1pdHZMdG1tWDU3cm83U2ZOKzZUK3k2ekd2?=
 =?utf-8?B?aXBGR0VSOERwQytjM1grekJCd2FGdlBJNGdML09wNm8rYzRCU2htNVNYYi9o?=
 =?utf-8?B?ZEVZamdqbUJXSmxCNWhRVkhjMVpBWTR5alhTakRDK013STBpU0Z4YjFLRkFu?=
 =?utf-8?B?MVYwRWZ1VzNmMWNQaEZ5d2lvTlZ0Y0FmdHdPaWtRYWlSQ2Frais2NUpRRHhQ?=
 =?utf-8?B?cU5EUkthSUFTazUwMEtLbm4vTFdLbnc5OHdmRGw2OVVqWVdqZ0ZDV3ZlMS9t?=
 =?utf-8?B?RUpRMnkvQnVnNkw2Q3RZaU96U1FsT3ZIRFV6cHdlMnJDK2d3TnpJUkJrTzBL?=
 =?utf-8?B?UGNPMDRPc25vQWRjc0VUVG9mb2FRTytqYWdTc2ZQaGIzejFRQmhGK3RDMlVw?=
 =?utf-8?B?T0NZZTFmajZ2TzNKMEh4LzJ2REU3YjJpMHBtSVQzRHRLOW5qRHZjRk54S0xE?=
 =?utf-8?B?UjBLM0RHZXZtRnlnTUJIM3VGak9LWTVsWlQzQjBBRVRBdDlabENLcFNuUUFz?=
 =?utf-8?B?M3lBdFVCMTUvRllMbUlnSVFjWjJ0YXphRWRCUjc1QklDZEloRlRVWGVoZ3F2?=
 =?utf-8?B?NXoyRXFwNTdHNFQ1OG01QnNVbHZ3SkZwZnJ3cVpBMHFnaFRHUjQ0WnpsRGQw?=
 =?utf-8?B?OStnbUNpKzJzWFZLUE5wL2VXeURLTC9rRDNJU0YvMnl1N1gybHpWbnhRc1N3?=
 =?utf-8?B?TkVXK1RTQWhGNTVZR1l5T3dTNjU5Ym1NUm44VERIN3NYZEJPN09ERy9VYWJH?=
 =?utf-8?B?M3NLZjdtMlZ5ODJMTU1kSzZScW5wa0FOS1Y1aTJ2SkJJdkxSdmNiVENMUDlJ?=
 =?utf-8?B?QmJQbC93Q2p2Y3RrUUtoTWcrYXVUa3dNUGthSUUzV0FIZ1Q2cWhvdnMzSmNx?=
 =?utf-8?B?WUl1ZzkrY1IycnVTZlo1aXFKQnlobmp6ZndxMHpFdDZZeXNOVkVZQTMzci80?=
 =?utf-8?B?aWFJYlBsZWVNTHFsNG0veDJFcGhJbUNyMFJCUUkweEltSmJlV294NjVVYXNT?=
 =?utf-8?B?RU5rVVZDcVNRRW11RUVtUmdBdXNoUElBNUYwT3lZM0c5S09wcTQ2QkhaUkgy?=
 =?utf-8?B?NWplTUFaRmErNlZEMVNwc3JSaXgvMlhkK3VSVjFTUCtXcWRDczJneVJIQ0NZ?=
 =?utf-8?B?THFwcCtwcUFrcG5QaXRIMXBqbmRpcmdieXZvazV4bW9TQVRGWnUycjJHbklm?=
 =?utf-8?B?WENQM0MzTXpqU2Q0ZlZ5RzFPZWNoYUJ0WUM4R1BwVHk5NzF5YloweU5vaUdu?=
 =?utf-8?B?Vk5ydHJRNitCRTl4Rk9KWjYrRXhnSDN2NWF6TjJoeml5V2FPV1VpYmVwUDJi?=
 =?utf-8?B?UGFsZ0VmU25BdVl5Nkk4MVc1YUdwMnB6dWowU1cvNG5ONUUwbUdLeUZKemZC?=
 =?utf-8?B?T3l3cVhzSlc1cWJ4dEJmT1RoUmREcm50eHpLY3hxY0p5RkVlUm1MdU9QbVhJ?=
 =?utf-8?B?R1diMHZvb3RLNjA5R01GVFFHeGFWTFVGM05lVHBlWlRLenpuZWxzSGJENmt6?=
 =?utf-8?B?N2JqeVVPaCtLSHkrb3kzb2x4ZWRac25EdFdxVDFGMlNKZERkS3lWTS9DdzNq?=
 =?utf-8?B?TTg4VitEL0lWYkFuYzBSbi9JZjBmNFY5WnlmSDBsWjJEV1NTMnJJQWJqT0Fu?=
 =?utf-8?B?UjNrSC9wbU1tcWNWSStmMzNmSFp3eHlad1I5ckkvbnVZNDNhZFlMdGI3YzFw?=
 =?utf-8?B?QW9FQkgxWW9uNDhRVG94UldjMXJHUzVsaWRXOWJjTDgzMnM5eW9rUS9wWVhI?=
 =?utf-8?B?dW9vMXNYOWJ2UFZzeTAxb1BUY2pJeEV2ZktmeEUxVzh0ckVvUGcwM3dQcXhM?=
 =?utf-8?B?bWpYMUlCQmFrTlQxT0dIMHhjT05yMUMwQ2xVWFhveG9hMUxWRnZtbGZRNmsz?=
 =?utf-8?Q?EGQ5x8ZdjTm48R+UbFG3avMUkjvBzRe8CUsy/W2DkGkm3?=
X-MS-Exchange-AntiSpam-MessageData-1: AE5L9Zd6Yb3Rwg==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a721390-3731-4666-18d4-08df36ee9af1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2026 01:30:54.0960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fGoQQv1aySaqCMs2U5TtqdIAxWxFf2kfVxzakWBTmVqAnqyF3Em699b3FOGgomqqZsLrW5gLRxBomie7eOiUYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4353
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Saturday, October 31, 2026 12:19=E2=80=AFAM Maxime Ripard wrote:
> On Fri, Oct 30, 2026 at 12:02:52PM +0200, Svyatoslav Ryhel wrote:
> > =D0=BF=D1=82, 30 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
11:51 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Fri, Oct 30, 2026 at 11:42:12AM +0200, Svyatoslav Ryhel wrote:
> > > > =D0=BF=D1=82, 30 =D0=B6=D0=BE=D0=B2=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 11:29 Maxime Ripard <mripard@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> > > > >
> > > > > On Thu, Oct 29, 2026 at 05:28:59PM +0200, Svyatoslav Ryhel wrote:
> > > > > > From: Mikko Perttunen <mperttunen@nvidia.com>
> > > > > >
> > > > > > The MIPI DBI bus allows modeling DBI hosts and peripherals usin=
g the Linux
> > > > > > driver model. DBI hosts are registered by their respective driv=
ers. During
> > > > > > registration, DBI peripherals are created from the device tree =
nodes
> > > > > > provided by the host.
> > > > > >
> > > > > > DBI hosts expose operations that can be used by peripheral driv=
ers to
> > > > > > access associated devices.
> > > > > >
> > > > > > The original code was authored by Mikko Perttunen; I have align=
ed it with
> > > > > > the existing MIPI DSI implementation.
> > > > > >
> > > > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > >
> > > > > The SoB situation isn't right here. The author is allegedly Mikko
> > > > > Perttunen, but you don't have their SoB, and yours isn't there ei=
ther.
> > > >
> > > > This is up to Mikko to decide what to do.
> > >
> > > Not only, no. When you're sending a patch you must add yours too.
> > >
> >=20
> > > > > > Co-developed-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> >=20
> > My CO dev and SoB are both present. Mikko will say their word and I
> > will update accordingly in v6
>=20
> Oh, right... I'm sorry.
>=20
> Maxime

Svyatoslav, feel free to take full authorship on this patch. You can add=20
my Suggested-by if you'd like.

Mikko



