Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4C2606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=LM3TbVUo
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B0C610E84C;
	Fri, 27 Nov 2026 12:26:44 +0000 (UTC)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011011.outbound.protection.outlook.com [52.101.52.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3779A10E84C
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:26:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wQYx43AUjCT/XtNUi9DFdSOeccW+wDOjGlEp2pxErGBizjKgqZsd/IwL2gBo8FwKuH0CZxtIuFKu5XioCwJYPE6WnvOVEtArNUX4Da3Z7tyeJpa/5IotJiG2Xl0bK0pXOS+4VGQOxHfvtWuPXFLUj/VjShtZyMMjD3CDdgCO8xe6QR96+634ZwXJUB1sXnnfY/Fsxyh3D5J5D9ZQVRru4J0oi7i9Dk5CnqyRJc+pRWV34RCNfSYspbzMX+QgkLJMGYSc8DcKoxfPkd3SqTc3eBqEeQoGA7dyWPKN4SMX4ESEk27jY4j8Fo48kKWDWHDfCgh8r2ddAkCvy6c6RYDnqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWjhJ60jVRGf/66/XDSbcWr0uLMGOs5GIgCdqJwlPH4=;
 b=PN+K+/nYdazEL09iR+CMvy5D4IKW859AIWSO6X31jQdnfqNeHP3hDjwCyMQSC7QOgRDldxFYNQfY4pUk/wTgdWlaPeqraiPyKCE1+7E3XYW78EAWVB8lNMkM1f3jG2QhfFHt/dM1ADFFoTyMEBsUBjynob9AIUjIgqSc58NPa/eBVT+n5c6nAJyTUBen6j5BTUl1xpGtgBKztkhD+c3FuFFXaR2mxynhgcSUxgbmDLQRtWWz/z7BX9q/ZYn2S/8PNAGbhrTmiLYZ9nCjkqdGhuZrxUanSNZcWF8vzhaxcJa7e80V+mJPmclbqAwTz5att5O914gmeie3rbQOhhs6yA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWjhJ60jVRGf/66/XDSbcWr0uLMGOs5GIgCdqJwlPH4=;
 b=LM3TbVUoFSquuqBjDdtm4Hpg1Nb+LpR04yD7B2GPhmlaT9JLx6Vx1eEDAMUP9JkGXej8TBQoxhwEWrlEcuh6rez5sR/LTc7FkORiJhwpRu5SIaQQu4//iRzt1QrQlTJs/6mnsdrhRp2VtjvF92T/tFWPjpPASF1r3eQ9kuL97E+I2O5J28ZW4BkyEIkw6m/Qyef88UbMlJ5fLBxL7mGeLKSt23H1n6JB/hG8cRY+R8AVGw1MnFnJlYxho/5HM+X1qLm88a7bjPXDv7czlbdPUFe/3DRI9+rkCftkhcCoQHc5XrONwT6Q/DPwYYh+7Z7IDTv++piY6H3NC84uHmdX6w==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS6PR12MB765380.namprd12.prod.outlook.com (2603:10b6:8:411::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.11; Fri, 27 Nov
 2026 12:26:33 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:26:32 +0000
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
Subject: Re: [PATCH v8 10/12] drm/tegra: rgb: Parameterize configuration based
 on bus flags
Date: Fri, 27 Nov 2026 21:26:28 +0900
Message-ID: <kaWzD58LSXePk8E_XcD28g@nvidia.com>
In-Reply-To: <CAPVz0n1xeNP=rv3qDMG06aSWRLTVvCfuo5tFyt9fz7KDTySV0A@mail.gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <CAPVz0n3YEoq5dg4+sHfd74rT8x_R9DEv1eTzW7UHVKEABGa-BQ@mail.gmail.com>
 <CAPVz0n1xeNP=rv3qDMG06aSWRLTVvCfuo5tFyt9fz7KDTySV0A@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P301CA0011.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:3be::15) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS6PR12MB765380:EE_
X-MS-Office365-Filtering-Correlation-Id: cb79a553-fc70-4090-e49f-08df4c81ab92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|10070799003|366016|1800799024|376014|261102123227099003|261028144727099003|261022105027099003|261022075727099003|261021121427099003|261026140227099003|261026121527099003|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ViInzIFgbFH39Ea1qxpu2NXJnPn+zGsweMdcnhwJbpViufsOgjDYzyMQavCBr5wB/ev4S+cHdJomcbD0S8rP1hJokKFGG5uRMZavrmIOWN/FSHPTJH/U4gg5PYHjR883mLm5J91Kcdw0lBWgjAT+pa0rXg7iDTfwW5o5jE4vPlvRQHiGBhpNs10zuAqYrFfnZ+w7S9R6iHjPmUU4ikW5FcFzGGyOHWpXAGX8ffdjcz2QP7xuFL3l3bObDe8psSZzqprqrK0C9/4i05lqDMuFaspGSeBtiHebonOzvvOWlHuaglKhPaR5I0hRrLKH2gvOLFbyu4KM3LG2MEmwhlYrjGqac72TVKBqk0ocacFWfVMZHvossI+eAETP25UQf9I1Ko5ftJByme3FZjJlphvZsVCmSxqxOiYUhC1CSFbJgkeIPOm8QOlIOBMLle0d1vIcrE+ErRKyet8D9uwAN2TT0c6WGrnOrLyXCOW19nYW0bzlO9WooFimyT/F5/3QpIMxTxYQKkxVSLKH7Aj3opkHFu6el4lOaFbQrgaEFiF7NqfNvocT8SUMQ0BTEySfngSlO9tTdrGRJh6eJDrikPRIJZ7nmLXppcTtpeMapy81P8n0uGTYdVR3lev8m/3YwBRO16wooEUEJR3S7OIGERMhPNjRgvlDa7DRpxnFVUsEPMs=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(10070799003)(366016)(1800799024)(376014)(261102123227099003)(261028144727099003)(261022105027099003)(261022075727099003)(261021121427099003)(261026140227099003)(261026121527099003)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnkwK2VWY04yU05mSVkyRjhaWFRCcnIvTjFCNVR4WDU5RlJZNFFDb3BjZ2w5?=
 =?utf-8?B?TEhtR1VDUW9SNFFWODlZdjR0bjZvWE1qN2dSbEhVSExaQWgxcjMrS0o4WStH?=
 =?utf-8?B?SEZHVmg1dUlFM25MUjN2Y2JZTjVNdWYyd0tKYTI5a0ZVNEkvNVE3V1daRzRj?=
 =?utf-8?B?dnJTRjMrSTlmNW1iUks4eTVPUGptYlRSaUpZcTU5bUJFV2lENDZ5dm9wTmRH?=
 =?utf-8?B?SkVkb3h4eTM0RjVMaEtlRzMwaFo4bXdabWhNNW5sOXVab3BXaDc2bEFZUVl0?=
 =?utf-8?B?ekxVcDRGTlRac2Y0bDZKWVZXdHVNdC9mUmNDRVFib08xbHNwRWJndWF3WE5v?=
 =?utf-8?B?eEpPL05VWnZOU2t2MzI1enl1TzFsUTBvYXg2UHRZSHdQRHVoNGhBRnNtbjZY?=
 =?utf-8?B?VmxpbHdLUWM1Z3FQLzZsbTJCaDFJY0EvQnQ0ZVZnWk83RFlaVzRJcytaZXIr?=
 =?utf-8?B?R0FkQXBaT2JMZDFoR1hCeStqcmFTaFJMN3c2NS9Wc3pWNm1sZEZZOXJyYUFm?=
 =?utf-8?B?VWV1MTc3c05uWmxmT29MblJzRk5KaW45OXQvb083WjF5Qi95T1Rvd1FmSUxx?=
 =?utf-8?B?MlFZblF4SHRWTzE0NmdxMjgxS0t5WDFLMVY3NkUrNmZ3NklkMjdsOTdIT3M3?=
 =?utf-8?B?YmdQSWpBU1ZaMUF4Z1NWYUlhMU5uNjZBQ3BPbGIrcmxXMGNZdFlpaHRFd2s4?=
 =?utf-8?B?V1E3ckdBQytGUHJyRkg2ZDRucFJyZ2dxc1NHcnBMLzJrbVZrRklJeW1qb1Z3?=
 =?utf-8?B?WXhPT1ExZUtyWGlQYzRRY3dWY0ZyMkRUQ3MrMUVpZjlLWUYzL3ZvbFJwTE9E?=
 =?utf-8?B?WGlSNUZEa2sySkNOUDNZeUdDOXpVNTFaazBwWjVPdXpZWkZXVmpCZzlpV3dk?=
 =?utf-8?B?UUxlWUU4NUxkc0pGVU5nSEZhZmdHRTRvWWxNelA4Vk5vNGYwMmZJdDI1OVlG?=
 =?utf-8?B?NWhXNkxxMHZZUC9GelJVU1ZOQisvalVIV2ZxMUJ5V2hkenFjWGR2WVRiNXNU?=
 =?utf-8?B?UXJVT3BXNWJQWXR2cGFJK2cwQnpzbERYZVJ0U0YyejJmaVhyWTYvK1pEZG9K?=
 =?utf-8?B?d2FOQi91dE1sb2ZITHQwRnFaRTEwb3RQSW9lN0N6d2VxNU9EbkdGTzJWUndw?=
 =?utf-8?B?QXk4QTJzQnlMUGVmSWxmYVhTbTVwOXAwb0NQeThwaUVrQ2lGUnkzRTY4cWhL?=
 =?utf-8?B?bjgyOEdWeFJUd1NNbVNBUUVLOXhwb1EyYUZIeXM5citibS8xdU9TZkorTERQ?=
 =?utf-8?B?c1kzNUpucTJSdjlLSThBL3BMSTh4N3VqaW5pZXVycWVvdmRKNXRxb3owYWU3?=
 =?utf-8?B?b0dGOWNHektUT3JHN2ZlMkp3RGpGSjlIanNFWmZ2UEF3alh3TmQwclBSUUlk?=
 =?utf-8?B?RG03aWZvalVwN3lQVXV4a25DQjVuNXZ4a3V6RmRtaDk0RmJiK09SNmxrbTB4?=
 =?utf-8?B?RklyL04yRkNqZW5wTm84bER2bGhBQ0hYQkNvbjFXdTI5SnFtT0FPRWo5Y1dB?=
 =?utf-8?B?Y3pwSnhzbjYxTWFoNjFXeXVzYzRMeW0vODlybzlnYjBFSFhET0tTRmdrSUpT?=
 =?utf-8?B?S2hyRitBc3M5WHBpeUMySXh6WE0yRGJ3U0g3MXdXZlYvazY2dW83L0tkdkpT?=
 =?utf-8?B?dG42R0VDMFJpS2V0OXJIRVRNOW9acDNtNDlXenlvNEVJUFBiaUFobGtKcHd4?=
 =?utf-8?B?ZGhVN2tUMFd2OFQ2QU43RGVBSVRDNHFVcERiaUVjdjVKYW4wMmxtWldsZVV3?=
 =?utf-8?B?SkMzZk9zMklEWndITWtkalMvYmhPelZKbi9TVXl5OGMvbVFXSU5MaU9MdkFE?=
 =?utf-8?B?SHc1VjZYUDlsbjc0RHgzU2RKNGR4eXRraTZmejNleEp0OC9KaU1JWEJQWlor?=
 =?utf-8?B?blVGL2pYQU1rT2FRbnMxcjFJSktYejZEdG9panZyVktOcFZtd0RRbTNkclZV?=
 =?utf-8?B?RU8rM0dkeDN5RDhqdUExU0NSa0FIeUFCYlJQcktRQUZOV3Y0ZTk3LzU2SzFz?=
 =?utf-8?B?NmZ5aDBhMjNPU1RDSE51YjBoL1JMWmlTMk9qaXdjQjIxZ215SmlFbE1OMnJ2?=
 =?utf-8?B?Qkl5aVZLVUFyNHlOV1JsbkowenBKK001ZXhLa1AwOUo4NTJrRkpQbFVJN2VU?=
 =?utf-8?B?M0VuYjNLZVpQTll0QnEzNFI1K2ZGUlkyTkFiOEo0OFQ2VVVOYUg5eHM1VFVx?=
 =?utf-8?B?aUltSVcrMU9OSjF2SGNsUEJxTW9hMkFUZjhLRFZETTMxbkRTZGk2RTNLTDVY?=
 =?utf-8?B?WnVZL3p1c1lVUUwzNkw2UFk1eExQVWZFQ0kxYXlRL054UHpMR0E2T0JiZk03?=
 =?utf-8?B?YmNtYTh3L3NxTit0Y1hzYnRXcEdIWmZaZlRMSzBqTlpJQnNBSGZvMU1XU0N1?=
 =?utf-8?Q?DMaeP5gAxnul3AzZuRq6K5ExPHhSJiTAu4aLljQgrDGn1?=
X-MS-Exchange-AntiSpam-MessageData-1: OW0TC1u5DQkgEw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cb79a553-fc70-4090-e49f-08df4c81ab92
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:26:32.4955 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWSQWWQ4RXzewlHexBIsvHpWz4jmSLFvhVYATytVoyLNTDt/FRvlfCP7AYQ5fThO2uTzXU/GphzL9/hA3i+Lyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB765380
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

On Friday, November 27, 2026 6:41=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 11=
:21 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE =
08:22 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > >
> > > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > Parameterize configuration based on bus flags passed from the bridg=
e or
> > > > panel. The list of supported flags includes now pixel clock polarit=
y,
> > > > display enable (DE) polarity, and data alignment.
> > > >
> > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > ---
> ...
> > > > +     /* configure DATA order and alignment */
> > > > +     value =3D DISP_DATA_FORMAT_DF1P1C | DISP_ORDER_RED_BLUE;
> > > > +
> > > > +     if (bus_flags & DRM_BUS_FLAG_DATA_LSB_TO_MSB)
> > > > +             value |=3D DISP_ALIGNMENT_LSB;
> > > > +     else
> > > > +             value &=3D ~DISP_ALIGNMENT_LSB;
> > >
> > > DRM_BUS_FLAG_DATA_LSB_TO_MSB does not seem the correct thing to check
> > > here. According to the TRM, DISP_ALIGNMENT doesn't swap between LSB/M=
SB
> > > bit ordering in a classical way, instead:
> > >
> > >   // DISP_DATA_ALIGNMENT =3D 0 (MSB)
> > >   LD[23:0] =3D {R[1:0], G[1:0], B[1:0],
> > >               R[7:2], G[7:2], B[7:2]};
> > >
> > >   // DISP_DATA_ALIGNMENT =3D 1 (LSB)
> > >   LD[23:0] =3D {R[7:0], G[7:0], B[7:0]};
> > >
> > > I suppose MSB is more natural for 18-bit panels and LSB for 24-bit
> > > panels depending on the layout. So the correct value depends on how t=
he
> > > panel is wired to the SoC on the board. Hence, I think we should
> > > describe this with a new property in device tree under rgb/dbi or
> > > endpoint node. Something like 'nvidia,rgb888-wiring' for LSB? And
> > > document that this means the above kind of wiring - not all RGB888
> > > panels use it.
> > >
> >
> > Ugh, why is this so confusing...
> >
>=20
> Using 'nvidia,rgb888-wiring' may be confusing since as you mentioned
> not all RGB888 panels use it. I can add 'nvidia,data-alignment' to rgb
> properties and set 0 to msb (default) and 1 to lsb, or directly set
> boolean `nvidia,data-alignment-lsb`. Let me know which is preferred.

data-alignment is a very ambiguous name if one isn't deeply familiar=20
with the hardware, hence I was thinking something a bit clearer would be=20
better.

I agree nvidia,rgb888-wiring isn't the best either, but I'm not sure=20
what would be the best choice here, off-hand.

>=20
> > > > +
> > > >       tegra_dc_writel(rgb->dc, value, DC_DISP_DISP_INTERFACE_CONTRO=
L);
> > > >
> > > >       tegra_dc_commit(rgb->dc);
> > > > --
> > > > 2.53.0
> > > >




