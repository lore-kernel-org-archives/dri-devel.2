Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5016D606A33B
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 12:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=hJNEJRwu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AD80510E550;
	Fri, 27 Nov 2026 12:20:50 +0000 (UTC)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010055.outbound.protection.outlook.com [52.101.61.55])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7584410E857
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Nov 2026 12:20:44 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qrR+FemqfeO2hRs/4SlZz9Oz4Vg828ANAD3BFKDpVNWRiP0KjoVT6NB6lJ3EjD9wSwcAO5yeO4MPkDqZdI4lQAquqCwgZbxKsUPw4qY2uNpYt9KfVtIyHv2bAUePEiJLbY2Zmqe41gkFr+9NxtyPKc38HfMCXbJnIIKjiEgAheWkt1l5xI7j/CXxdaAzDrD6iC8B7FJOn84i9pbqkIyh1A/S2pIJfBbRYUqLtpHehfsA9eGOan0qOV53pQvzcKgUFa6a1R2wsi9zz4CCWf1zd+bRGmN/LlvBgBoY+LpOB9UJIJ2RmcYe2OVQbzk4YDYA3lRGhf/L53obR0FKEvMSVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=29mJJnU39JCSjJ/elAulqliM2sf2ARDECk0GrG9Bovg=;
 b=Q+rWdKRZXRlruxGWSU6ZwzkEctpexz+sl8VEr6RJ8MP1/MADIeDz6vSTOclxVRvHUn9Mc2i/DFG+8nKDZLNSH5ePUcd0tpQ3V69nfn5lGQ8CzeJD2QZHreW54Pyl+wGt5cwKC5D/DOfV5WW52qcIWHE/GUMAMLSX9CXPbNPKzOcFPC0HJoO4vxViy3fQ4eFGw1+6GeLSD4GTSLmm9XfyNal1d3hCE82gJ4I5lHQ2WqQdd4TAqY5KAte8Qz/PCUxz2IbhhpUOhx0vJMOcFBvxhI98Bi9aufY8BDy1xSsrSQ9qmN0J0z/RalR+PRCKimhzsXrV7F1c7LzxSLlL1V+WLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=29mJJnU39JCSjJ/elAulqliM2sf2ARDECk0GrG9Bovg=;
 b=hJNEJRwuYj6SyGu9K928Zzcb8AiyGgOq5kKGAvdd4JtSGgk5IyCpxBgXJCfHvvrkytI1JgkRL030VWcBI8/gN832qdTv8N+K0F0zjiZ+EE3ynSSt+P6YuSzYEXmAgbPC1he9LUTslHmbCskwIFE5PXdlIm+QyoDKDPvKWiUd2OHCHh/Gfad29TJEXNHAr/DOnQ73sxFUKR2GuvrKvSSx6SJorzwIGWZ1Tev5zVF23JgQSsLwleM8qUj31KCdOcuX9vK9sDfJldZeEK8DxKyDKdj059xEw/NPCALcWpjMnnNSXRjklPSP/cccXv8AlwS2oQtgqjKJoKIIr7kLTb2Etw==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DS5PPFB8FBD73EA.namprd12.prod.outlook.com (2603:10b6:f:fc00::65e)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.9; Fri, 27 Nov
 2026 12:20:38 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0662.004; Fri, 27 Nov 2026
 12:20:38 +0000
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
Subject: Re: [PATCH v8 01/12] drm: Add MIPI DBI bus support for MIPI DBI Type
 A and B
Date: Fri, 27 Nov 2026 21:14:55 +0900
Message-ID: <H5TrL9ZbQaiciaNOSrG3BQ@nvidia.com>
In-Reply-To: <CAPVz0n2G2Bw6xyD4zYrEWNZj-SMGXLUeUFOHU6PBy_vketU_JQ@mail.gmail.com>
References: <20261122081820.53199-1-clamor95@gmail.com>
 <tWBq0CmbQN-l5IJnxter_A@nvidia.com>
 <CAPVz0n2G2Bw6xyD4zYrEWNZj-SMGXLUeUFOHU6PBy_vketU_JQ@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY6P286CA0021.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:3b9::16) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DS5PPFB8FBD73EA:EE_
X-MS-Office365-Filtering-Correlation-Id: 959d2c97-8e7e-4b8f-8588-08df4c80d88e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|10070799003|7416014|376014|10067099003|56012099006|261022075727099003|261022105027099003|261022113327099003|261028144727099003|261026121527099003|261026140227099003|261021121427099003|261021123027099003|261102123227099003|261102130727099003|261009223027099003|261009221227099003|22082099003|18002099003|4143699003|11063799006|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: Xy/UWntRiLWj/gR4yyFxnJE8gdkoPqbRwFHu1I8qRiik80/d39ul6QHFKa1x7Ja+6qtHEyUKgkLF0HLETqEcOJ5H5jdUBnSPngphcE8SDZrs/xym73LRxRt2uR05bx1X5RUTTsIV9NyM+2vIoueOEUXPkuKCd8UgXofmBGTqqvi5QyR3qXjBV7L1MFXG/SUkUWffVgbXeG/zU9F5/OQuRPpuWNqQIHsJ8v9admgABGRDsQpLbcNF8SqhNbo3QtIcKx8B5Kl7cjNBB4ILwETjSs8XqAP2j2sKHZsY8jQRs2erAwX1Tb9vMxK4qiduSh3OTVAfgvKMNAQh9zUOzR+wSFFUKl9rXBkoZO+Cq7KraiH9jNkHDMEcnJBDYmmMO9yLa6CaWasiaEWhMD4uymLDIC67Q1Zo3OseCZCEQKMNdkyhOm/D0P2VbURzuluaunzIRw5pOjso29QltaKHQA511BtPIyiZYSVRu9StcYRuO+q4gM1EwTv1pL7B5oH9Gved92EefDfyhyjWuoMj6lPjiW7pTK+OldYzH/3EGwsNQADmS1XbnzhETOTHTbvkK89dgpcLwb0YHzQU8qlTucUbbMTykPSY0KHSDk0tew9xzjf7OBPEY635kb63BrnKvPDYRGvoKvZg8fXcUmO1GvVW9PA+dNx6TrGOF997vHc0niQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(10070799003)(7416014)(376014)(10067099003)(56012099006)(261022075727099003)(261022105027099003)(261022113327099003)(261028144727099003)(261026121527099003)(261026140227099003)(261021121427099003)(261021123027099003)(261102123227099003)(261102130727099003)(261009223027099003)(261009221227099003)(22082099003)(18002099003)(4143699003)(11063799006)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UXBFaXhFZGY2Q0I0SmZrUkd3alNwNDM0YzVoQ1gyRW9TZGlNSDFRcW9pZ0dr?=
 =?utf-8?B?NlEwakovZTd5NXd3bDFrT3c2YnBPR1k2NGg2aGVGMnV2Z3dhOGFsTUNRZVAw?=
 =?utf-8?B?U3c4S3VKbFRoeG5laitNWWUyVzhRZVlxdlVVbFFMS3ROejhSY2FQdFNQb0h6?=
 =?utf-8?B?OTYybmZIeGFjZWdQaUJ3ZVVTWXNWNW1nZDlEUExaTEh5bXpNSG9ReG1mZjVl?=
 =?utf-8?B?WmpvVFE0azV4bjYxU1ZxL2drRFdqejhiK2NyRy91WEN2YTZ3RHdORXlFZE0x?=
 =?utf-8?B?NGNKbFlISEVpTnFIMXNHZjBZRmpCbFVUeEtaSXcyZ2NFWE5kNnVuRmdPUmpk?=
 =?utf-8?B?WDZpWHkwanZEVTZDK2h4SmdnUnQ0Y3N1WGR1Uk9yd05vekdITXlNTW9XRURX?=
 =?utf-8?B?UnQ0TElVVUxWcG9HM0ZmczRrVmc2Qk5pRlFPam5vQ0MrRnBVaERkMmZ4QmpE?=
 =?utf-8?B?bUtVaHBmQTFjMnEvMzFuNE1walRTWVV0TUJ6bUtiQjYxaWJ1SlJ3cmRNMDNW?=
 =?utf-8?B?SkNhM3I1azZiV0V6dzBLYzBUT0NkOTA5U2JTbkdMYjdUZXdKUXM1amlVci9a?=
 =?utf-8?B?TmlrZ2VRbU5zOHRGeEUyelBDOEF1N2JZeDUzU3JtRURIUEhvU01uNEdaSEx4?=
 =?utf-8?B?UkJHMmorUjMzeDRRWkdrVG9UYjNYTDNTZE9DTXllY3VtVDlVMEtjOEVDUkZ1?=
 =?utf-8?B?Q2JURGhqdkNBWkRHTnptM1ZoWWdXMm9QeFAwVEVGTUhPU0RnRm5XSlJkTnRh?=
 =?utf-8?B?eFZZQlJERTZOc1dMY3R5aVE2NE4vcjQ1ckk2VDRBcE8xdE1DRFRZWjQ3Y3JG?=
 =?utf-8?B?R3FrczF2K1NFVWRtMTY0bVJPeHdsZUlvbU5SWHZsL2M5dnloZ1hwTFA0d2JY?=
 =?utf-8?B?b0c0TE9tdnI5Wm1hbjV2bDlESDJ0Z2NRWU5GTWd4ZzE1SzZsck5tckd0TThT?=
 =?utf-8?B?Vkg1SzcxQ2U5YnMrTWsxZnhpVFM0eVp6SjdhcVhzc244K2VsNlM4Smg4RnNS?=
 =?utf-8?B?TXFEcVg5ZjZ5TjhSaDU5UTBMbGV0Sld6bGZLZHRJSHFDL3BNQ2ZXUXlKM3lE?=
 =?utf-8?B?Ny9sUFhDbzFWTzgzY2MwRTFNREluV3MzZkIrTGllWVpvc1MxRG44UlVKOUJN?=
 =?utf-8?B?Um5DMDk4QmwwYzVWbzFsYjlQTU9TU2V3TlowVG0wdlZENHVXQUY4K0VndlQ5?=
 =?utf-8?B?bFZPdTBuMFNFK01HL0FGTUdpWUlKMExPRUc4TDdmb0c0Skd1cEZHdUg3TmhQ?=
 =?utf-8?B?NGlxNnlxZFZ0ZTc1RVU4QWlROHdXM2JVTkxBNTZhRTRqQkVHU1VyK2tWejlB?=
 =?utf-8?B?VmNwVWV3cTVpNEZ6VEh2UVhudWFrMzFBN29nTnZvQjU5em9HSUhxRGpvRkp6?=
 =?utf-8?B?VGlEb25XMUtHSVpDTExkOVNablR4elNMN0h0d2wyS25EeUtJdnQxRy94QlFr?=
 =?utf-8?B?dEUwSWxhNUNyRlN2dHd0WFR6NFVmN2NkYkFFN0U3QzJaOE9ZWThLdkZiUkt4?=
 =?utf-8?B?ekd3Z2xXZW9MK1ExYUtKUlVVeHljbHcxbXZ1SGpqc3RYR01Dc3pVNVpZQnJj?=
 =?utf-8?B?U2pxb09HME5sb0RUM3JpZUw0RC83QU11WHFranZsRGxFREE3ZU9WY1dNZGpR?=
 =?utf-8?B?ZXorSTlnaDNXa1dEZU1jZFoydmsyYTJ6TVpTcjczemM4b1lIMXE5QXc2ZDNM?=
 =?utf-8?B?cTd0b21QdThHYTVQYjR5VnBPNTNUdUI5cWdzUGdEakxrU0VuT0NyQ21nd3BB?=
 =?utf-8?B?THRPSnpkOVpOalpkak9pQ0pJUTJOU0ZHYlROKzNQWno0TXlqQzYyelBXUTRq?=
 =?utf-8?B?YlpQQXZvMHo4TzJtbDY3NTh1dkRrUnlydGZmcFJFUnJ4ZlRycVlickxGa0FF?=
 =?utf-8?B?RGl4UkRWQXpWcytwY21PWjZVejQyUDgycjRFbDBzQ1V2TjJkeEsrU3ZmYUtV?=
 =?utf-8?B?ZWpuT2J3WEhTUi91cGJwb0ZjamFwVE1xS3dXMHk2Z005bXVadXgzRnJzK3hC?=
 =?utf-8?B?aURPUzc1U2ZyeG1iNjhUYUtWVURidVh2S25haldDdzRjYzhUNkRsekNWZUp2?=
 =?utf-8?B?c3pZQzEzZVdtLzRxeEo1SmFMSEQrQ21QM0hReEVxa1c3bnNNWHczT2lsWkR2?=
 =?utf-8?B?dnRzQ0RleXZ5Zktya3YwMHA4VTgyM1YzRWk2UlpyTGp0dlVjbk90bnd0MkEv?=
 =?utf-8?B?dVNsSlVKVXpnVU1MemE4STF4VDd6WVhpUEhoTWVteVZ3Wk1aVkVIWTlkT1pH?=
 =?utf-8?B?MjM5cldyNE9xVkh4L2FjdXcwbmpsMSt6eFpzc2ZrVUwwR216SFdESUhkc1hr?=
 =?utf-8?B?NWhHQnVhMVdvekVQdUl1OFMwRXBuUHcwL09JaFkraVBPZFNod0g5L0lQR3Er?=
 =?utf-8?Q?NzdudKj7rHd2pvOijkuB/KZbwRPYfHUZ3SSqYuCoUKT6b?=
X-MS-Exchange-AntiSpam-MessageData-1: srmq9pu6m3mb0A==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 959d2c97-8e7e-4b8f-8588-08df4c80d88e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 12:20:38.4376 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KsHUtoqD1oFRRTcvVo/Yv0SUGdAvqfpigMknaNPTZKXpJMq1rouoTiXEwtgFqmPaHCXcJCF6ewpshJTJZ/ebGA==
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

On Friday, November 27, 2026 6:06=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=BF=D1=82, 27 =D0=BB=D0=B8=D1=81=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 06=
:16 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Sunday, November 22, 2026 5:18=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > The MIPI DBI bus allows modeling DBI hosts and peripherals using the =
Linux
> > > driver model. DBI hosts are registered by their respective drivers. D=
uring
> > > registration, DBI peripherals are created from the device tree nodes
> > > provided by the host.
> > >
> > > DBI hosts expose operations that can be used by peripheral drivers to
> > > access associated devices.
> > >
> > > This implementation adds support for MIPI DBI Type A and Type B only.
> > > Type C support existing in drm_mipi_dbi.c was not altered. The framew=
ork
> > > is modeled to closely resemble the existing MIPI DSI setup for seamle=
ss
> > > integration.
> > >
> > > Suggested-by: Mikko Perttunen <mperttunen@nvidia.com> # preliminary s=
ketch
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/gpu/drm/Makefile           |   2 +-
> > >  drivers/gpu/drm/drm_mipi_dbi_bus.c | 287 +++++++++++++++++++++++++++=
++
> > >  include/drm/drm_mipi_dbi_bus.h     | 148 +++++++++++++++
> > >  3 files changed, 436 insertions(+), 1 deletion(-)
> > >  create mode 100644 drivers/gpu/drm/drm_mipi_dbi_bus.c
> > >  create mode 100644 include/drm/drm_mipi_dbi_bus.h
> > >
> > > diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> > > index 2c6bc093a923a..880f0dc930b85 100644
> > > --- a/drivers/gpu/drm/Makefile
> > > +++ b/drivers/gpu/drm/Makefile
> > > @@ -166,7 +166,7 @@ obj-$(CONFIG_DRM_KMS_HELPER) +=3D drm_kms_helper.=
o
> > >
> > >  obj-y                        +=3D tests/
> > >
> > > -obj-$(CONFIG_DRM_MIPI_DBI) +=3D drm_mipi_dbi.o
> > > +obj-$(CONFIG_DRM_MIPI_DBI) +=3D drm_mipi_dbi.o drm_mipi_dbi_bus.o
> > >  obj-$(CONFIG_DRM_MIPI_DSI) +=3D drm_mipi_dsi.o
> > >  obj-y                        +=3D arm/
> > >  obj-y                        +=3D clients/
> > > diff --git a/drivers/gpu/drm/drm_mipi_dbi_bus.c b/drivers/gpu/drm/drm=
_mipi_dbi_bus.c
> > > new file mode 100644
> > > index 0000000000000..4b51de5bdf0b5
> > > --- /dev/null
> > > +++ b/drivers/gpu/drm/drm_mipi_dbi_bus.c
> > > @@ -0,0 +1,287 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/*
> > > + * MIPI DBI devices with command transport through parallel interfac=
e
> > > + *
> > > + * Copyright 2026 Mikko Perttunen <mperttunen@nvidia.com>
> > > + * Copyright 2026 Svyatoslav Ryhel <clamor95@gmail.com>
> > > + */
> > > +
> > > +#include <linux/err.h>
> > > +#include <linux/init.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_device.h>
> > > +#include <linux/pm_runtime.h>
> > > +#include <linux/slab.h>
> > > +
> > > +#include <drm/drm_mipi_dbi.h>
> > > +#include <drm/drm_mipi_dbi_bus.h>
> > > +
> > > +/**
> > > + * DOC: overview
> > > + *
> > > + * There are three MIPI DBI implementation types:
> > > + *
> > > + * A. Motorola 6800-type parallel bus
> > > + *
> > > + * B. Intel 8080-type parallel bus
> > > + *
> > > + * C. SPI-type with three options:
> > > + *
> > > + *    1. 9-bit with the Data/Command signal as the ninth bit
> > > + *    2. Same as above, except it is sent as 16 bits
> > > + *    3. 8-bit with the Data/Command signal as a separate D/CX pin
> > > + *
> > > + * This library provides a framework for MIPI Display Bus Interface =
(DBI)
> > > + * compatible display controllers using Type A and Type B. This
> > > + * implementation closely matches existing DSI framework behavior to
> > > + * allow seamless integration.
> > > + *
> > > + * Type C options 1 and 3 are covered by drm_mipi_dbi.c with
> > > + * mipi_dbi_spi_init().
> > > + */
> > > +
> > > +static int mipi_dbi_match(struct device *dev, const struct device_dr=
iver *driver)
> > > +{
> > > +     return of_driver_match_device(dev, driver);
> > > +}
> > > +
> > > +static int mipi_dbi_uevent(const struct device *dev, struct kobj_uev=
ent_env *env)
> > > +{
> > > +     return of_device_uevent_modalias(dev, env);
> > > +}
> > > +
> > > +static const struct dev_pm_ops mipi_dbi_device_pm_ops =3D {
> > > +     .runtime_suspend =3D pm_generic_runtime_suspend,
> > > +     .runtime_resume =3D pm_generic_runtime_resume,
> > > +     .suspend =3D pm_generic_suspend,
> > > +     .resume =3D pm_generic_resume,
> > > +     .freeze =3D pm_generic_freeze,
> > > +     .thaw =3D pm_generic_thaw,
> > > +     .poweroff =3D pm_generic_poweroff,
> > > +     .restore =3D pm_generic_restore,
> > > +};
> > > +
> > > +static const struct bus_type mipi_dbi_bus_type =3D {
> > > +     .name =3D "mipi-dbi",
> > > +     .match =3D mipi_dbi_match,
> > > +     .uevent =3D mipi_dbi_uevent,
> >
> > These two callbacks are just direct wrappers so I believe we should be
> > able to set them to of_driver_match_device / of_device_uevent_modalias
> > directly.
> >
>=20
> May you specify a bit more please?

mipi_dbi_match just calls of_driver_match_device and mipi_dbi_uevent=20
just calls of_device_uevent_modalias. So rather than having the=20
mipi_dbi_* functions, we should be able to assign the of_* functions=20
here directly.

>=20
> > > +     .pm =3D &mipi_dbi_device_pm_ops,
> >
> > I think we can drop setting .pm as well. These callbacks will fall back
> > to the same code (driver callbacks) if we don't set the bus PM ops.
> >
>=20
> Noted.
>=20
> > > +};
> > > +
> > > +static void mipi_dbi_device_release(struct device *dev)
> > > +{
> > > +     of_node_put(dev->of_node);
> > > +     kfree(to_mipi_dbi_device(dev));
> > > +}
> > > +
> > > +static void mipi_dbi_device_unregister(void *data)
> > > +{
> > > +     struct device *dev =3D data;
> > > +
> > > +     of_node_clear_flag(dev->of_node, OF_POPULATED);
> > > +     device_unregister(dev);
> > > +}
> > > +
> > > +/**
> > > + * devm_mipi_dbi_device_register() - create a managed peripheral MIP=
I DBI
> > > + *                                Type A or B device.
> > > + * @dev: device to tie the MIPI-DBI device lifetime to
> > > + * @host: DBI host to which this device is connected
> > > + * @np: device tree node associated with the panel MIPI DBI device
> > > + *
> > > + * This function is called by DBI host driver to create panel device=
.
> > > + * It automatically calls mipi_dbi_device_unregister() when @dev is
> > > + * unbound. It does not automatically free passed device node pointe=
r,
> > > + * it must be put manually.
> > > + *
> > > + * Returns:
> > > + * A pointer to the newly created MIPI DBI device, or, a pointer enc=
oded
> > > + * with an error.
> >
> > For brevity, I would just use 'an error pointer'.
> >
>=20
> Noted
>=20
> > > + */
> > > +struct mipi_dbi_device *
> > > +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_ho=
st *host,
> > > +                           struct device_node *np)
> > > +{
> > > +     struct mipi_dbi_device *dbidev;
> > > +     int ret;
> > > +
> > > +     if (!host || !host->dev || !host->dbi || !host->dbi->command ||
> > > +         !host->ops || !host->ops->attach || !host->ops->detach || !=
np)
> > > +             return ERR_PTR(-EINVAL);
> > > +
> > > +     if (!of_device_is_available(np))
> > > +             return ERR_PTR(-ENODEV);
> > > +
> > > +     dbidev =3D kzalloc_obj(*dbidev);
> > > +     if (!dbidev)
> > > +             return ERR_PTR(-ENOMEM);
> > > +
> > > +     if (of_node_test_and_set_flag(np, OF_POPULATED)) {
> > > +             kfree(dbidev);
> > > +             return ERR_PTR(-EBUSY);
> > > +     }
> > > +
> > > +     dbidev->host =3D host;
> > > +     dbidev->dbi =3D host->dbi;
> > > +     device_initialize(&dbidev->dev);
> > > +     dbidev->dev.parent =3D host->dev;
> > > +     dbidev->dev.bus =3D &mipi_dbi_bus_type;
> > > +     dbidev->dev.release =3D mipi_dbi_device_release;
> > > +     device_set_node(&dbidev->dev, of_fwnode_handle(of_node_get(np))=
);
> > > +
> > > +     ret =3D dev_set_name(&dbidev->dev, "%s:%s", dev_name(host->dev)=
, np->full_name);
> > > +     if (ret)
> > > +             goto put_device;
> > > +
> > > +     ret =3D device_add(&dbidev->dev);
> > > +     if (ret)
> > > +             goto put_device;
> > > +
> > > +     ret =3D devm_add_action_or_reset(dev, mipi_dbi_device_unregiste=
r,
> > > +                                    &dbidev->dev);
> > > +     if (ret)
> > > +             return ERR_PTR(ret);
> > > +
> > > +     return dbidev;
> > > +
> > > +put_device:
> > > +     of_node_clear_flag(np, OF_POPULATED);
> > > +     put_device(&dbidev->dev);
> > > +     return ERR_PTR(ret);
> > > +}
> > > +EXPORT_SYMBOL_GPL(devm_mipi_dbi_device_register);
> > > +
> > > +static void mipi_dbi_detach(void *data)
> > > +{
> > > +     struct mipi_dbi_device *dbidev =3D data;
> > > +
> > > +     dbidev->host->ops->detach(dbidev->host, dbidev);
> > > +     dbidev->attached =3D false;
> > > +}
> > > +
> > > +/**
> > > + * devm_mipi_dbi_attach() - managed attach of peripheral DBI device =
to its MIPI
> > > + *                       DBI Type A or B devices.
> > > + * @dev: device to tie the MIPI-DBI device lifetime to
> > > + * @dbidev: DBI peripheral
> >
> > Add a return value description. Otherwise inevitably someone will send
> > an autogenerated oneline fix to add it.
> >
>=20
> Noted
>=20
> > > + */
> > > +int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device =
*dbidev)
> > > +{
> > > +     int ret;
> > > +
> > > +     if (dbidev->attached)
> > > +             return -EBUSY;
> > > +
> > > +     ret =3D dbidev->host->ops->attach(dbidev->host, dbidev);
> > > +     if (ret)
> > > +             return ret;
> > > +
> > > +     dbidev->attached =3D true;
> > > +     return devm_add_action_or_reset(dev, mipi_dbi_detach, dbidev);
> > > +}
> > > +EXPORT_SYMBOL_GPL(devm_mipi_dbi_attach);
> > > +
> > > +/**
> > > + * mipi_dbi_write_buffer_multi() - mipi_dbi_command() w/ accum_err b=
ut for
> > > + *                              MIPI DBI Type A and B
> > > + * @ctx: context for multiple DBI transactions
> > > + * @cmd: command to be sent
> > > + * @data: buffer containing data to be transmitted
> > > + * @len: size of transmission buffer
> > > + *
> > > + * Acts like mipi_dbi_command() for MIPI DBI Type C but for Types A =
and B
> > > + * and deals with errors in a way that makes it convenient to make s=
everal
> > > + * calls in a row.
> > > + */
> > > +void mipi_dbi_write_buffer_multi(struct mipi_dbi_multi_context *ctx,
> > > +                              u8 cmd, const u8 *data, size_t len)
> > > +{
> > > +     struct mipi_dbi_device *dbidev =3D ctx->dbidev;
> > > +     struct device *dev =3D &dbidev->dev;
> > > +     ssize_t ret;
> >
> > mipi_dbi_command_stackbuf returns an int, so this can be an int as well=
.
> >
>=20
> This is deliberately void, errors are accumulated in context. This
> repeats DSI approach.

I mean the type of the 'ret' variable.

>=20
> > > +
> > > +     if (ctx->accum_err)
> > > +             return;
> > > +
> > > +     ret =3D mipi_dbi_command_stackbuf(dbidev->dbi, cmd, data, len);
> > > +     if (ret < 0) {
> > > +             ctx->accum_err =3D ret;
> > > +             dev_err(dev, "sending dcs data %*ph failed: %d\n",
> > > +                     (int)len, data, ctx->accum_err);
> > > +     }
> > > +}
> > > +EXPORT_SYMBOL(mipi_dbi_write_buffer_multi);
> > > +
> > > +static int mipi_dbi_drv_probe(struct device *dev)
> > > +{
> > > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver)=
;
> > > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > > +
> > > +     return drv->probe(dbidev);
> > > +}
> > > +
> > > +static int mipi_dbi_drv_remove(struct device *dev)
> > > +{
> > > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver)=
;
> > > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > > +
> > > +     drv->remove(dbidev);
> > > +
> > > +     return 0;
> > > +}
> > > +
> > > +static void mipi_dbi_drv_shutdown(struct device *dev)
> > > +{
> > > +     struct mipi_dbi_driver *drv =3D to_mipi_dbi_driver(dev->driver)=
;
> > > +     struct mipi_dbi_device *dbidev =3D to_mipi_dbi_device(dev);
> > > +
> > > +     drv->shutdown(dbidev);
> > > +}
> >
> > This could be simplified slightly by making these (probe, remove,
> > shutdown) bus-level callbacks (set on mipi_dbi_bus_type). Then the
> > callback assignments in __mipi_dbi_driver_register are not needed. The
> > 'if's do have to move into the bus-level callbacks. This also cleans up
> > the remove callback return type.
> >
>=20
> I have added these to match DSI behavior as more established framework.

Well, there are other established frameworks that have the bus-level=20
functions. But both approaches are pretty much equal in complexity so=20
either one is fine.

>=20
> > > +
> > > +/**
> > > + * __mipi_dbi_driver_register() - register a driver for MIPI DBI Typ=
e A or B devices.
> > > + * @drv: DBI driver structure
> > > + * @owner: owner module
> > > + *
> > > + * Return: 0 on success or a negative error code on failure.
> > > + */
> > > +int __mipi_dbi_driver_register(struct mipi_dbi_driver *drv, struct m=
odule *owner)
> > > +{
> > > +     drv->driver.bus =3D &mipi_dbi_bus_type;
> > > +     drv->driver.owner =3D owner;
> > > +
> > > +     if (drv->probe)
> > > +             drv->driver.probe =3D mipi_dbi_drv_probe;
> > > +     if (drv->remove)
> > > +             drv->driver.remove =3D mipi_dbi_drv_remove;
> > > +     if (drv->shutdown)
> > > +             drv->driver.shutdown =3D mipi_dbi_drv_shutdown;
> > > +
> > > +     return driver_register(&drv->driver);
> > > +}
> > > +EXPORT_SYMBOL_GPL(__mipi_dbi_driver_register);
> > > +
> > > +/**
> > > + * mipi_dbi_driver_unregister() - unregister a driver for MIPI DBI T=
ype A or B devices.
> > > + * @drv: DBI driver structure
> > > + */
> > > +void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv)
> > > +{
> > > +     driver_unregister(&drv->driver);
> > > +}
> > > +EXPORT_SYMBOL_GPL(mipi_dbi_driver_unregister);
> > > +
> > > +static int __init mipi_dbi_bus_init(void)
> > > +{
> > > +     return bus_register(&mipi_dbi_bus_type);
> > > +}
> > > +subsys_initcall(mipi_dbi_bus_init);
> > > +
> > > +static void __exit mipi_dbi_bus_exit(void)
> > > +{
> > > +     bus_unregister(&mipi_dbi_bus_type);
> > > +}
> > > +module_exit(mipi_dbi_bus_exit);
> > > +
> > > +MODULE_DESCRIPTION("MIPI DBI devices with command transport through =
parallel interface");
> > > +MODULE_LICENSE("GPL");
> > > diff --git a/include/drm/drm_mipi_dbi_bus.h b/include/drm/drm_mipi_db=
i_bus.h
> > > new file mode 100644
> > > index 0000000000000..6f00a8eef9c67
> > > --- /dev/null
> > > +++ b/include/drm/drm_mipi_dbi_bus.h
> > > @@ -0,0 +1,148 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-or-later */
> > > +/*
> > > + * MIPI DBI devices with command transport through parallel interfac=
e
> > > + *
> > > + * Copyright 2026 Mikko Perttunen <mperttunen@nvidia.com>
> > > + * Copyright 2026 Svyatoslav Ryhel <clamor95@gmail.com>
> > > + */
> > > +
> > > +#ifndef __DRM_MIPI_DBI_BUS_H__
> > > +#define __DRM_MIPI_DBI_BUS_H__
> > > +
> > > +#include <linux/device.h>
> > > +#include <linux/module.h>
> > > +
> > > +struct device_node;
> > > +struct mipi_dbi;
> > > +struct mipi_dbi_device;
> > > +struct mipi_dbi_host;
> > > +
> > > +/**
> > > + * struct mipi_dbi_host_ops - DBI bus operations for MIPI DBI Type A=
 and B.
> > > + * @attach: attach DBI device to DBI host
> > > + * @detach: detach DBI device from DBI host
> > > + */
> > > +struct mipi_dbi_host_ops {
> > > +     int (*attach)(struct mipi_dbi_host *host, struct mipi_dbi_devic=
e *dev);
> > > +     void (*detach)(struct mipi_dbi_host *host, struct mipi_dbi_devi=
ce *dev);
> > > +};
> > > +
> > > +/**
> > > + * struct mipi_dbi_host - DBI host device for MIPI DBI Type A and B.
> > > + * @dev: driver model device node for this DBI host
> > > + * @dbi: MIPI DBI interface
> > > + * @ops: DBI host operations
> > > + */
> > > +struct mipi_dbi_host {
> > > +     struct device *dev;
> > > +     struct mipi_dbi *dbi;
> > > +     const struct mipi_dbi_host_ops *ops;
> > > +};
> > > +
> > > +/**
> > > + * struct mipi_dbi_device - DBI peripheral device for MIPI DBI Type =
A and B.
> > > + *                       This structure describes a peripheral DBI d=
evice,
> > > + *                       an endpoint for DSC commands and video data=
, and must
> >
> > DCS commands
> >
>=20
> Nodes
>=20
> > > + *                       be paired with a DBI host device for MIPI D=
BI Type A
> > > + *                       and B. This layout is built to closely rese=
mble
> > > + *                       the DSI framework.
> > > + *
> > > + *                       If your device is MIPI DBI Type C (with an =
SPI
> > > + *                       control bus) and incorporates DBI within, y=
ou
> > > + *                       should use the mipi_dbi_dev structure and T=
ype C
> > > + *                       framework from drm_mipi_dbi.c.
> >
> > I don't think we need to talk about the DSI or Type C frameworks here.
> > drm_mipi_dbi.c already mentions it's for Type C.
> >
>=20
> I was explicit since Thierry and Maxime were very clear that
> differences are not described enough.
>=20
> > > + * @dev: driver model device node for this peripheral
> > > + * @dbi: MIPI DBI interface
> > > + * @host: DBI host for this peripheral
> > > + * @attached: the DBI device has been successfully attached
> > > + */
> > > +struct mipi_dbi_device {
> > > +     struct device dev;
> > > +     struct mipi_dbi *dbi;
> > > +     struct mipi_dbi_host *host;
> > > +     bool attached;
> > > +};
> > > +
> > > +/**
> > > + * struct mipi_dbi_multi_context - Context to call multiple MIPI DBI=
 funcs in a row
> > > + * @dbidev: Pointer to the peripheral MIPI DBI Type A and B device
> > > + * @accum_err: Storage for the accumulated error over the multiple c=
alls
> > > + *          Init to 0. If a function encounters an error then the er=
ror code
> > > + *          will be stored here. If you call a function and this poi=
nts to a
> > > + *          non-zero value then the function will be a noop. This al=
lows calling
> > > + *          a function many times in a row and just checking the err=
or at the
> > > + *          end to see if any of them failed.
> > > + */
> > > +
> > > +struct mipi_dbi_multi_context {
> > > +     struct mipi_dbi_device *dbidev;
> > > +     int accum_err;
> > > +};
> > > +
> > > +#define to_mipi_dbi_device(__dev)    container_of_const(__dev, struc=
t mipi_dbi_device, dev)
> > > +
> > > +void mipi_dbi_write_buffer_multi(struct mipi_dbi_multi_context *ctx,
> > > +                              u8 cmd, const u8 *data, size_t len);
> > > +
> > > +/**
> > > + * mipi_dbi_write_seq_multi() - transmit a command with payload
> > > + *
> > > + * This macro will print errors for you and error handling is optimi=
zed for
> > > + * callers that call this multiple times in a row.
> > > + *
> > > + * @ctx: context for multiple DBI transactions
> > > + * @cmd: command to be sent
> > > + * @seq: buffer containing data to be transmitted
> > > + */
> > > +#define mipi_dbi_write_seq_multi(ctx, cmd, seq...)                  =
         \
> > > +     do {                                                           =
         \
> > > +             static const u8 d[] =3D { seq };                       =
           \
> > > +             mipi_dbi_write_buffer_multi(ctx, cmd, d, ARRAY_SIZE(d))=
;        \
> > > +     } while (0)
> > > +
> > > +struct mipi_dbi_device *
> > > +devm_mipi_dbi_device_register(struct device *dev, struct mipi_dbi_ho=
st *host,
> > > +                           struct device_node *np);
> > > +int devm_mipi_dbi_attach(struct device *dev, struct mipi_dbi_device =
*dbidev);
> > > +
> > > +/**
> > > + * struct mipi_dbi_driver - DBI driver for MIPI DBI Type A and B.
> > > + * @driver: device driver model driver
> > > + * @probe: callback for device binding
> > > + * @remove: callback for device unbinding
> > > + * @shutdown: called at shutdown time to quiesce the device
> > > + */
> > > +struct mipi_dbi_driver {
> > > +     struct device_driver driver;
> > > +     int (*probe)(struct mipi_dbi_device *dbi);
> > > +     void (*remove)(struct mipi_dbi_device *dbi);
> > > +     void (*shutdown)(struct mipi_dbi_device *dbi);
> > > +};
> > > +
> > > +static inline struct mipi_dbi_driver *
> > > +to_mipi_dbi_driver(struct device_driver *driver)
> > > +{
> > > +     return container_of(driver, struct mipi_dbi_driver, driver);
> > > +}
> > > +
> > > +static inline void *mipi_dbi_get_drvdata(const struct mipi_dbi_devic=
e *dbi)
> > > +{
> > > +     return dev_get_drvdata(&dbi->dev);
> > > +}
> > > +
> > > +static inline void mipi_dbi_set_drvdata(struct mipi_dbi_device *dbi,=
 void *data)
> > > +{
> > > +     dev_set_drvdata(&dbi->dev, data);
> > > +}
> > > +
> > > +int __mipi_dbi_driver_register(struct mipi_dbi_driver *drv, struct m=
odule *owner);
> > > +void mipi_dbi_driver_unregister(struct mipi_dbi_driver *drv);
> > > +
> > > +#define mipi_dbi_driver_register(driver) \
> > > +     __mipi_dbi_driver_register(driver, THIS_MODULE)
> > > +
> > > +#define module_mipi_dbi_driver(__mipi_dbi_driver) \
> > > +     module_driver(__mipi_dbi_driver, mipi_dbi_driver_register, \
> > > +                     mipi_dbi_driver_unregister)
> > > +
> > > +#endif /* __DRM_MIPI_DBI_BUS__ */
> >
> > __DRM_MIPI_DBI_BUS_H__
> >
>=20
> Noted
>=20
> > > --
> > > 2.53.0
> > >
> > >
> >
> >
> >
> >




