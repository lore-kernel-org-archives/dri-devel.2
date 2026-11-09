Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1ADA606A31C
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 02:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=CrRq2jhG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 141AE10EDE2;
	Mon,  9 Nov 2026 02:48:27 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010033.outbound.protection.outlook.com [52.101.61.33])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7FF1110EDE2
 for <dri-devel@lists.freedesktop.org>; Mon,  9 Nov 2026 02:48:20 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J266XlPeH2Jjj0AHrVRka3RlGIeAO2/7x6l245NP5A1Wvay97jzPmto+xi07VzfGRMkO3w+/34lcQ245vxEtoDuvsUhcpJEcqrc20RrjNdiwWk6XBImvfqEjnZ1OyEm0jJntvrPP5CcMs3hcfuj2XZg2gZVPSop2Hk2bTuSSTg1zeFjUJ9d+brNiv1EjoB2jQlX97/WKPBYbaJR7Uo4zWhEeViEROtLYg6fwxKzzAd10FfyfKue/BoaeHwaQ03+32EEYIZ4xiKRXXBAXAjnvkdtV8WalSFHrn/FopZpGk12hfuWxmCCcNZRze6qd8uypsSEKFEMcaW1MD1QyRzT9RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDANcuBRw5lzxlgqqohzXqLlRT8h/sIxH3xYAfFsnP0=;
 b=lxc/uVLVgzObPll4n/JBsy8YncYKsJeSEMam5NfQ89xaTwjXerN1lj1ireTMcmY+zR8GE3B/i8PK/iZxhq5JLK7c4wg1LZqtIjQdzbUAAdA+rUKcybziX95ptgTXCjcRmZzBuncxY8Z9H7UjtKRn2kGbJ48I13z881/8j8eRXeve0Z62U//jT7c3VXHPUqB0c2nBfk6bmiYUQB4+hgWSELSdoFA5NaWXqfGsxakkyy7fgtSGupoeGwmWWjblQVn9Tc8hNXg5Dl+Z17f9iVP8+Jyq+k3ksYih43t6EqaOfPBi2TrtzjOEqqTnnXgdqWhRGsujTW/efMpHnFHxN2q99A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDANcuBRw5lzxlgqqohzXqLlRT8h/sIxH3xYAfFsnP0=;
 b=CrRq2jhGTdTVvz35z4qpZkr/mfapBXuwZFILNVJDpoIfiz53Pe49LkIbzAyarRbw0iqUJurSr5huU/A01Wb3xQiDiZbt6xl1iyhAxsIRT9XE8eqLbzCxgdhFaANNNoRamgQYHbr2Z4vOXSFWIESpqaHKmTvFA224xFkAfll1wphRLTQy/lHKlKV4r8AFAuWrg8gXkjiRzhmlcKhV4H3x1iHRkjvZdVFZFynqxpkqAXzNbbcrsNM8+3B9/aNMpXEtZDmdgoiyuKgr6b77wPdUf4Y17wap+ENy9cFAT52o6fR91/a9eHopQHK/TuwOFB24euzt0vuCWth3iC/Hnbo/SA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by BN5PR12MB9488.namprd12.prod.outlook.com (2603:10b6:408:2a9::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Mon, 9 Nov
 2026 02:48:16 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0592.010; Mon, 9 Nov 2026
 02:48:16 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, devicetree@vger.kernel.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org, Svyatoslav Ryhel <clamor95@gmail.com>
Subject: Re: [PATCH v6 04/10] drm/tegra: dc: Refactor and expand header
Date: Mon, 09 Nov 2026 11:48:13 +0900
Message-ID: <5pUU1zRdQouqOutBEn_R4Q@nvidia.com>
In-Reply-To: <CAPVz0n1h8SS09Nt9fw4q806ktEM59fQRXTqdP053E7+2onzmYA@mail.gmail.com>
References: <20261105140510.165165-1-clamor95@gmail.com>
 <au3X8tpU9KWas9ZM@orome>
 <CAPVz0n1h8SS09Nt9fw4q806ktEM59fQRXTqdP053E7+2onzmYA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0003.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:26c::10) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|BN5PR12MB9488:EE_
X-MS-Office365-Filtering-Correlation-Id: 158742ed-5876-4930-66d8-08df3e0be7d8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|7416014|10070799003|366016|1800799024|18002099003|22082099003|10067099003|3023799007|4143699003|56012099006|11063799006|261028144727099003|261026140227099003|261102123227099003|261022105027099003|261021121427099003|261021123027099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 8jpGxWp6ohNIZ+yVC3Mhvd2JjSmVmmBCKmktwBTab8H9y7QaDAMcvH6c6SHN6xd/8+2u2fVVTd/OuJ4OYI16KMdQSa0ipRjIIi7nINq3ileBxySCO+HVJsEKN0RYpAGnJi73URQIpawPlCn+l9dG+iptLf5iLHsv6sTDnALN6EM5IXUFi9hnMMIW9hhsIJTGAYJWAjyZdhvzg/RWslwe6OROOu5bg+0rp2jbxYhqgG/guK/Xegw4K6+/lLqJ5x2FDl15tM46AxxJp9yytnt74OCyVPnGT6Fmpc6EfQn8ph7ZutigpXJjbRB/hGR90DCdljWNuvSVzJiNx6Qw4+CuwtLxZIydFL2JdgnK5NYFUQfYhFB9GkzYIPW4V4Ko4kMPUbHk5nBlaFgJ6R72f9Sb3/nN3bflzq7bbNttg6XAApgMwl5UHzX0kBLscaqS1Y9/qZbdMUIf/rpX2uD2jUR0vwsnn1LPXROwBFAz5Irv6kRHZxdHLS4KKiYsg1512hQvxJEGOmigeQUP3Gq0lBkekysaC5ztO7Q3P51hS9JLhcl5WoUPUwWVog378nZo9faOKRffa+xA0JbHJQKLgnHKrvL6OOm+VbWBALFQJFY8HvBlMG1E1bQ5AfU+Dp5UNfGAVJboOeF8c4CmStzw4x8KlAly/sT3B+V/gayhGSa5Wc8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(7416014)(10070799003)(366016)(1800799024)(18002099003)(22082099003)(10067099003)(3023799007)(4143699003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261102123227099003)(261022105027099003)(261021121427099003)(261021123027099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N2pQOHJKUFlld2djOHdLcElMSUk2MnljY1Jobm5QMnVLM3RqUGEzeHN5bzhi?=
 =?utf-8?B?OFcvb0Q1WWRJY0pZTFcvaWQ5SFNEZXE3RVNWMWpsY2xIaXczZXk4Z1pGKzhZ?=
 =?utf-8?B?eTk4K0lOc2ptUll1YUUyVXVESlhWQnB0NmJkMWl0SlBEMi9rN2RiN2tseHhI?=
 =?utf-8?B?MzZDV3ZIc3ljR0puaHk1ZTkyVmozYlRYVTZjQWQ1VGt3VkpWMVVnK0s0M01t?=
 =?utf-8?B?UkFxeFQrcXBHNUgzM0Y4UFVSemxSTHE0b3hER2ovWVBmTVAwRjZhc1cyZDQy?=
 =?utf-8?B?N3RvM1lKUDlzOFd1bFFncGh1bmgraitnT1M5NXhRVGJQWDU0cDdCMGYxZ3By?=
 =?utf-8?B?clZZMWJQczU3VzRCeE8yanZqcjVuTnRYcXZadEpPeEkzdDlLcndzRzBhZDcv?=
 =?utf-8?B?c0xONU5DdnZOTWxWVjFJTytaczA3OHVNcjBzYmVwcVF5bU9hajk3N29ubEMv?=
 =?utf-8?B?NmlCY0MySHE2RWdNWWducThDMkRBUVRKcGlBZVZMdVN1RE1ycFc0Vy9uRVJr?=
 =?utf-8?B?bWV5RFBiZGYySVlmaE4vVzFSSmVkalhaTEVuSnlMamtNRGg2QW1XSmZ4ZkM4?=
 =?utf-8?B?QXNIZFcxVjhhcXJleEZVbTJ6cGVyMmJoUEZLT3dLNFlQeEVaRDNFZWhkTFZv?=
 =?utf-8?B?bC9IaDdZODZJOTMxMkNabjNqTGp2UXY5VVFUeDZmanFqdnhnNVducnBPS25s?=
 =?utf-8?B?MWhURkxSbEVXYWxnU3dOamV0K2dBdmNzc08rT1gwa3Y5bHppU1JkT3kwNFZu?=
 =?utf-8?B?d1lzSmoxVkFLNlV2Y0xEVExkbEZXdVZib3pvZGF6SmNNS1lpQzFKVUs4M1pu?=
 =?utf-8?B?NnlpYnNrNG9ycnY5S09wZTQwa0xjcnBMNnpiR2lqZU83VUxiZUJPM2hYOUZ2?=
 =?utf-8?B?b2RVampENnhvVFlPdjlzTjhkZzVHRmFPS1g1Y0Q5OGtvQlNBSkY2MUQ5bkVD?=
 =?utf-8?B?Z0loZFp1WW1YdFNhWGNRV0Y0K21qZDE5WHhsV2J4K1RZdWMvZlVScE5RYVgr?=
 =?utf-8?B?S29HcnhFUkJhZVdKNXdheWFPRWVURkRrSTZwV3FxK0k2SnNvaTdERlI3eU91?=
 =?utf-8?B?MHB4YUw1TjVQMUtkUCswdllPbzBHS0RmbDFZeFRMYWJUcHlQL25OdE5pRS9r?=
 =?utf-8?B?VXJNWWdpSldlT1I3U2xTK2dMYmhyanpBRjdQUHNtdk9TdVhxMVQ5K0YvZU1z?=
 =?utf-8?B?N0Zvb0dFV0xDTC90QlV3TFRzWkIyUWl6Ym1pdmRMTDltWTU2OE15emxJczdk?=
 =?utf-8?B?d3cxRlNNdHdBSWp1WWo1N0xSRlk2WVBJQjUrMmpQZ2RpSU13VjRCNE4zRWti?=
 =?utf-8?B?OHVIUEhSWEFQekM2OFNzRTVJTUp2OURGdTZudWpldnpnNFA1cFYybDlSNGMz?=
 =?utf-8?B?T2hNRHdiVEZRRkhOSXI1QUhqRVVyajBqUVBRQ0t2Qno3ZU1NMG4xK2l1cERE?=
 =?utf-8?B?dE04ZWpJcUNLVUhJMjRFOGNiZ0ZnU1JMcEVLZEwxVlZpL0p5T2JubjNsc1Ju?=
 =?utf-8?B?K05TN2VYM0RPUXVQbm4zc1BaMVBOQXNDd3hJQjVvZ2NPTzFqL0YvQmcxL0dO?=
 =?utf-8?B?QU40TVRSK0JKWndzMWVNdklJTHVVMUF0SzN0cGh0T1QrYTJISkZkTHplQW5Z?=
 =?utf-8?B?NVg2K2RsdHQvemRPaElDOTNCMGZVOC9TSmZRazQvcXM5dzRER1lLSis0TkdL?=
 =?utf-8?B?L09JNFJQWDF3cEhnNEpZVTFHQ0JUSFdSNm1KakxjZEpmcXZaNGMvcythYzBH?=
 =?utf-8?B?YUoyU25tOWtNR1RhdmdsbUN5TWdPOUZXMkpvd2ViOGdGZDlkMVFJeU05ejR6?=
 =?utf-8?B?L3doUEtITHF1dVpUWGJCaHZZdkFnZEZGbWJFcW9SQ0p0RS8rTkVpMk4wY2ty?=
 =?utf-8?B?a2haRUM5bC9lc0pvSEVmQTEwSzY1TTV1aDBGRU82b0V4ZEZGVHBySDdpVCtV?=
 =?utf-8?B?eWszQU55ZTU2OFNxdkVTbXhPNTM5cFRQajd2TGptQitxRXNsWWora0xpTVFZ?=
 =?utf-8?B?dmUrMWVxaEtrZ0owUDBEVGVTL2xHS2xmMVUwMUFCMjQwOFA5TGtHQ3hrbFow?=
 =?utf-8?B?ZitIUkZZU29XNmdWQi9LL3BUdHZiMFovUTRETGJZMUZHRkM1VlZaYXc4dTlT?=
 =?utf-8?B?WUNNVlNac2xwejkvZTZrV2dpenorQ3I1elY0R1Y5ZFNJREhTcCsvb24rc3d6?=
 =?utf-8?B?YlMzQ09vRFRyTVNETWxrSmRyM245RXRBVyt0b3d4alRQSzBDcVFTQXorcFgy?=
 =?utf-8?B?NnUwSUtSV25UZ1RLSHlWUkpLZTM4WmNBRU14Mmw2VFJrbExpN1dLbDl6aHIr?=
 =?utf-8?B?b0RoeUJHdzdCOUV3a2pvLzk0SjdFWHh1L2FIZDZmTW9COGxFSk1kelJKNmI3?=
 =?utf-8?Q?3Y95vmmYWfvwG/EK+EI2cZg+pwV0kvVcMNCyqa0MJ3aJh?=
X-MS-Exchange-AntiSpam-MessageData-1: uJgIoPZ4sD1D+g==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158742ed-5876-4930-66d8-08df3e0be7d8
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 02:48:16.6275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sQq2i6DAyvk+vuG2fUSFy4ZEj08p3tDCJFEG9X+/50yZFxSB1Ok/PlR7J26mesB/L71YCHLHNoL6vvq01vimgQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN5PR12MB9488
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

On Friday, November 6, 2026 11:06=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 6 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 15:=
56 Thierry Reding <thierry.reding@kernel.org> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Thu, Nov 05, 2026 at 04:05:04PM +0200, Svyatoslav Ryhel wrote:
> > > Refactor and expand existing DC register definitions with additional
> > > fields in preparation for adding the 8-bit CPU interface.
> > >
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/dc.c  |  11 +-
> > >  drivers/gpu/drm/tegra/dc.h  | 856 +++++++++++++++++++++-------------=
--
> > >  drivers/gpu/drm/tegra/rgb.c |   8 +-
> > >  3 files changed, 514 insertions(+), 361 deletions(-)
> >
> > This is impossible to review. Please split this up into refactor and
> > expand patches. Each should be a separate change.
> >
> > Also, a lot of the "refactor" is just pointless whitespace changes that
> > are just not necessary. Please keep the changes to a minimum.
> >
>=20
> Well, I did what Mikko asked. It is not my problem that this header is
> a hot mess. Initially I just wanted to add fragments needed by dbi.

I found the original a bit difficult to read and thus review because of=20
the non-aligned define values, hence asking for some cleanup.

Perhaps it'd be best to just clean up the whitespace for those register=20
/ define blocks where the patch is adding or modifying values.

>=20
> > > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > [...]
> > > @@ -2384,7 +2384,8 @@ static void tegra_crtc_atomic_enable(struct drm=
_crtc *crtc,
> > >
> > >       if (dc->rgb) {
> > >               /* XXX: parameterize? */
> > > -             value =3D SC0_H_QUALIFIER_NONE | SC1_H_QUALIFIER_NONE;
> > > +             value =3D SC0_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
> > > +                     SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE);
> >
> > This type of change seems entirely useless to me. It's neither more
> > readable nor shorter.
> >
> > [...]
> > > diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
> > > index 0cb0515968b35..2b87bb675d4cf 100644
> > > --- a/drivers/gpu/drm/tegra/dc.h
> > > +++ b/drivers/gpu/drm/tegra/dc.h
> > > @@ -178,9 +178,11 @@ int tegra_dc_rgb_init(struct drm_device *drm, st=
ruct tegra_dc *dc);
> > >  int tegra_dc_rgb_exit(struct tegra_dc *dc);
> > >
> > >  #define DC_CMD_GENERAL_INCR_SYNCPT           0x000
> > > +
> > >  #define DC_CMD_GENERAL_INCR_SYNCPT_CNTRL     0x001
> > > -#define  SYNCPT_CNTRL_NO_STALL   (1 << 8)
> > > -#define  SYNCPT_CNTRL_SOFT_RESET (1 << 0)
> > > +#define  SYNCPT_CNTRL_NO_STALL                       BIT(8)
> > > +#define  SYNCPT_CNTRL_SOFT_RESET             BIT(0)
> >
> > The whitespace changes here are completely arbitrary, it's changing one
> > preference for another. You're actually changing the contents in this
> > case, so it's not that bad. Still unnecessary, though.
> >
> > > -#define DISP_CTRL_MODE_STOP (0 << 5)
> > > -#define DISP_CTRL_MODE_C_DISPLAY (1 << 5)
> > > -#define DISP_CTRL_MODE_NC_DISPLAY (2 << 5)
> > > -#define DISP_CTRL_MODE_MASK (3 << 5)
> > > +#define  DISP_CTRL_MODE_STOP                 (0 << 5)
> > > +#define  DISP_CTRL_MODE_C_DISPLAY            (1 << 5)
> > > +#define  DISP_CTRL_MODE_NC_DISPLAY           (2 << 5)
> > > +#define  DISP_CTRL_MODE_MASK                 (3 << 5)
> >
> > These are purely whitespace changes. Please don't do that.
> >
>=20
> This separates register content for register definitions
>=20
> > >  #define DC_COM_CRC_CONTROL                   0x300
> > > -#define  DC_COM_CRC_CONTROL_ALWAYS (1 << 3)
> > > -#define  DC_COM_CRC_CONTROL_FULL_FRAME  (0 << 2)
> > > -#define  DC_COM_CRC_CONTROL_ACTIVE_DATA (1 << 2)
> > > -#define  DC_COM_CRC_CONTROL_WAIT (1 << 1)
> > > -#define  DC_COM_CRC_CONTROL_ENABLE (1 << 0)
> > > +#define  DC_COM_CRC_CONTROL_ALWAYS           BIT(3)
> > > +#define  DC_COM_CRC_CONTROL_FULL_FRAME               (0 << 2)
> > > +#define  DC_COM_CRC_CONTROL_ACTIVE_DATA              BIT(2)
> > > +#define  DC_COM_CRC_CONTROL_WAIT             BIT(1)
> > > +#define  DC_COM_CRC_CONTROL_ENABLE           BIT(0)
> >
> > FULL_FRAME and ACTIVE_DATA were previously consistent, now it just look=
s
> > weird. Either use proper GENMASK() definitions where applicable, along
> > with modifications in the driver to use FIELD_PREP() and FIELD_GET(), o=
r
> > just don't change it at all.
> >
>=20
> This one seems legit, I must have missed that.
>=20
> > > +
> > >  #define DC_COM_CRC_CHECKSUM                  0x301
> > > -#define DC_COM_PIN_OUTPUT_ENABLE(x) (0x302 + (x))
> > > -#define DC_COM_PIN_OUTPUT_POLARITY(x) (0x306 + (x))
> > > -#define LVS_OUTPUT_POLARITY_LOW (1 << 28)
> > > -#define LHS_OUTPUT_POLARITY_LOW (1 << 30)
> > > -#define DC_COM_PIN_OUTPUT_DATA(x) (0x30a + (x))
> > > -#define DC_COM_PIN_INPUT_ENABLE(x) (0x30e + (x))
> > > -#define DC_COM_PIN_INPUT_DATA(x) (0x312 + (x))
> > > -#define DC_COM_PIN_OUTPUT_SELECT(x) (0x314 + (x))
> > > +
> > > +/* Defines in PIN_OUTPUT/INPUT_* describe pin position, not state */
> >
> > This comment is completely confusing to me. The registers themselves
> > define the state and bit positions within them seem to indicate the pin
> > positions.
> >
> > > +#define DC_COM_PIN_OUTPUT_ENABLE(x)          (0x302 + (x))
> > > +#define DC_COM_PIN_OUTPUT_POLARITY(x)                (0x306 + (x))
> > > +#define DC_COM_PIN_OUTPUT_DATA(x)            (0x30a + (x))
> > > +#define  PIN_UNMASK(x)                               BIT((x) + 1)
> >
> > Given that pin positions are in steps of two for all registers, does
> > that PIN_UNMASK apply to all of them or just PIN_OUTPUT_DATA?
> >
>=20
> Check TRM
>=20
> > > +#define DC_COM_PIN_INPUT_ENABLE(x)           (0x30e + (x))
> > > +
> > [...]
> > > +/* DC_COM_PIN_OUTPUT/INPUT_*_3 */
> > > +#define PIN_LSCK                             0
> > > +#define PIN_LSDA                             2
> > > +#define PIN_LCSN                             4
> > > +#define PIN_LDC                                      6
> > > +#define PIN_LSPI                             8
> > > +#define PIN_LSDI                             10
> > > +
> > > +#define DC_COM_PIN_INPUT_DATA(x)             (0x312 + (x))
> >
> > It's not clear that PIN_INPUT_DATA_* can take any of those PIN_*
> > defines. Given that there are only two PIN_INPUT_DATA registers that's
> > probably not true, so I think it'd be good to somehow specify how that
> > works here.
> >
>=20
> I do not need input data, hence this field is not populated
>=20
> > > +#define DC_COM_PIN_OUTPUT_SELECT(x)          (0x314 + (x))
> > > +#define  PIN_OUTPUT_SELECT_MASK(x)           (0x7 << (x))
> > > +#define  PIN_OUTPUT_SELECT_PRIM(x)           (0 << (x))
> > > +#define  PIN_OUTPUT_SELECT_OUT(x)            (1 << (x))
> > > +#define  PIN_OUTPUT_SELECT_F2(x)             (2 << (x))
> > > +#define  PIN_OUTPUT_SELECT_F3(x)             (3 << (x))
> > > +#define  PIN_OUTPUT_SELECT_F4(x)             (4 << (x))
> > > +#define  PIN_OUTPUT_SELECT_F5(x)             (5 << (x))
> > > +#define  PIN_OUTPUT_SELECT_F6(x)             (6 << (x))
> > > +#define  PIN_OUTPUT_SELECT_F7(x)             (7 << (x))
> > > +
> > > +/* DC_COM_PIN_OUTPUT_SELECT0 */
> > > +#define PIN_OUTPUT_SELECT_LD0                        0
> > > +#define PIN_OUTPUT_SELECT_LD1                        4
> > > +#define PIN_OUTPUT_SELECT_LD2                        8
> > > +#define PIN_OUTPUT_SELECT_LD3                        12
> > > +#define PIN_OUTPUT_SELECT_LD4                        16
> > > +#define PIN_OUTPUT_SELECT_LD5                        20
> > > +#define PIN_OUTPUT_SELECT_LD6                        24
> > > +#define PIN_OUTPUT_SELECT_LD7                        28
> > > +
> > > +/* DC_COM_PIN_OUTPUT_SELECT1 */
> > > +#define PIN_OUTPUT_SELECT_LD8                        0
> > > +#define PIN_OUTPUT_SELECT_LD9                        4
> > > +#define PIN_OUTPUT_SELECT_LD10                       8
> > > +#define PIN_OUTPUT_SELECT_LD11                       12
> > > +#define PIN_OUTPUT_SELECT_LD12                       16
> > > +#define PIN_OUTPUT_SELECT_LD13                       20
> > > +#define PIN_OUTPUT_SELECT_LD14                       24
> > > +#define PIN_OUTPUT_SELECT_LD15                       28
> > > +
> > > +/* DC_COM_PIN_OUTPUT_SELECT2 */
> > > +#define PIN_OUTPUT_SELECT_LD16                       0
> > > +#define PIN_OUTPUT_SELECT_LD17                       4
> > > +
> > > +/* DC_COM_PIN_OUTPUT_SELECT3 */
> > > +#define PIN_OUTPUT_SELECT_LPW0                       0
> > > +#define PIN_OUTPUT_SELECT_LPW1                       4
> > > +#define PIN_OUTPUT_SELECT_LPW2                       8
> > > +#define PIN_OUTPUT_SELECT_LSC0                       16
> > > +#define PIN_OUTPUT_SELECT_LSC1                       20
> > > +#define PIN_OUTPUT_SELECT_LVS                        24
> > > +#define PIN_OUTPUT_SELECT_LHS                        28
> > > +
> > > +/* DC_COM_PIN_OUTPUT_SELECT4 */
> > > +#define PIN_OUTPUT_SELECT_LHP0                       0
> > > +#define PIN_OUTPUT_SELECT_LHP1                       4
> > > +#define PIN_OUTPUT_SELECT_LHP2                       8
> > > +#define PIN_OUTPUT_SELECT_LVP0                       16
> > > +#define PIN_OUTPUT_SELECT_LVP1                       20
> > > +
> > > +/* DC_COM_PIN_OUTPUT_SELECT5 */
> > > +#define PIN_OUTPUT_SELECT_LM0                        0
> > > +#define PIN_OUTPUT_SELECT_LM1                        4
> > > +#define PIN_OUTPUT_SELECT_LDI                        8
> > > +#define PIN_OUTPUT_SELECT_LPP                        12
> > > +
> > > +/* DC_COM_PIN_OUTPUT_SELECT6 */
> > > +#define PIN_OUTPUT_SELECT_LSCK                       0
> > > +#define PIN_OUTPUT_SELECT_LSDA                       4
> > > +#define PIN_OUTPUT_SELECT_LCSN                       8
> > > +#define PIN_OUTPUT_SELECT_LDC                        12
> > > +#define PIN_OUTPUT_SELECT_LSPI                       16
> > > +#define PIN_OUTPUT_SELECT_LSDI                       20
> > >
> > >  #define DC_COM_PIN_MISC_CONTROL                      0x31b
> >
> > If there's only one PIN_MISC_CONTROL register, does that take these sam=
e
> > PIN_* values as bit indices?
> >
>=20
> Check TRM
>=20
> > Thierry




