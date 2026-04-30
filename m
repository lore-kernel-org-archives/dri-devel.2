Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D7F0FF886F
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 06:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE5710E038;
	Thu, 30 Apr 2026 06:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="I7QJZ7xW";
	dkim-atps=neutral
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011038.outbound.protection.outlook.com [40.107.208.38])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A889D10E038
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 06:23:24 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=It5mWtgBqZ86uRaMbv0kNalOSlZxgoS9XXYSwpzl2RJBMCoFwApAFAmz0rjbjanogjZ3LLpUuYe6k5RoW7PIh7v8yKm4goGXftz71niSKK86lRw+uk8kBbXyMpzg5K8bsoRTDuwYxc3zEkIPO4RhaGEUJ7WHPLx43rZKL06wp42V7UxZNBw5/E8965Fz/mb3RmITrXxgMf4qY/2iMB0sqrTOOM0vzC0+OKV2Mq8EMj4jONSVSQ64Yu8dqAcJHr0mkdtch3WFkf9jzUbGxCDAQA3hW4ZHB1++YNX4D/MjJwBAGZd0bpvxP9p6Ypnqqi+A6yaosPQ8yLB3W2fF2eIvxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFsCPe6jAWYAsqP+wBYhlmoBNppSZ6W88RoeSy9J0Fw=;
 b=GCT4jrSMedeH5D9smXrvEO5GtBKl4Wp2KHCsv8yFiN7e9zjxWYEx8/Vlf22raafEpOgU/Th4py3hPygZ8N+8X1sP2rv1HiVka5o8T3PtEqjTh+CyGBvBls3zKzrJ8pMzIRwM+KORcsR6/l7D63OubCHe81EAhB9RxaWxAglk/Rg13uTSegquFc6Wtz+Oi0yH9jADc971xevBkzBxa+blFTQd3vwn87aame5HNybHRTa+fia7bDENnWXUbbQ3csML3bZVARAqXaGTzZ9Gww6K2JjnZVGZVWfZ68PY+BUEpqA0UTRfpSA/L0MIAUco1/E8LgX5SOlbUFfc+hvbbTieLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFsCPe6jAWYAsqP+wBYhlmoBNppSZ6W88RoeSy9J0Fw=;
 b=I7QJZ7xWPkbs1KtNi1a6pI0/Ldx1FoyRoIEQZAvUDEtewp516pC4iYfGiVlE5iKwJLNnAMVZyfnHM6j4TRQxzP6WK/yH6Fnc6qeN+auVFtMep7nQ7PAnBRBwammNsMfld2W/ICbpUy9T9Q33FjZFp1yu7BHMk63rrU0K4YHdaiT9OEPMzHE7dmm9GRvs0z6p2Qnx5L+gE3H0X1lkJ2vkhjl4egYku1GiowPGq203CSy8FKo3wNlpDM6mr/UNQv0sGwVxOaSiAyNzRGMJ9ZDET3IVRUiub8IRA5ZDLc8oOmfthCk4HWQpo/UV/ZfD9RyWN9C9ZfE8OyYNuwIXa8fbJA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by PH0PR12MB5677.namprd12.prod.outlook.com (2603:10b6:510:14d::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 06:23:20 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 06:23:20 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Ion Agorria <ion@agorria.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm/tegra: gr2d/gr3d: Move pm_runtime_enable to
 gr*d_probe
Date: Thu, 30 Apr 2026 15:23:14 +0900
Message-ID: <SGKRjIZyS4mU2gPAiUbKJg@nvidia.com>
In-Reply-To: <CAPVz0n0q77SVN7=47fEQR9ASQUnLoEgaGh3tJihxLSe9UhrPaw@mail.gmail.com>
References: <20260427075856.85208-1-clamor95@gmail.com>
 <gUUml1BmSZiZjQ7gY5A_cg@nvidia.com>
 <CAPVz0n0q77SVN7=47fEQR9ASQUnLoEgaGh3tJihxLSe9UhrPaw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: OS0PR01CA0148.jpnprd01.prod.outlook.com
 (2603:1096:604:27::23) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|PH0PR12MB5677:EE_
X-MS-Office365-Filtering-Correlation-Id: a0113f5e-7373-49d2-9727-08dea680f93f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: ejpbwU9lyfqXsfYgKn91RKXJP1hySOT1zL/1ySE2UCeK0oAh7qtHMEOF+7jxXsDbH1CV6nG1bUXSBpSqcM0PwKsHGxe8pbkpw55mCyG9Db0B5Mq+jXQ3UAIsxCohceJNmwkIC7DdHT1kA+0jMTzLErBzzQaEl5GRqCjP0vuLicqoB9X6wtTtiXEb25aAy780fWnpIdp5jJl5yB079/FjM6DnAODOzIMlszY8IMEO1E/9H0osdecExi1RrNIwaNYS6VryhnYGCWXo4AbOLrcOi649AE/3vA6Q41e9oJ64mTZSgXnvljL58MjwjAUV7zsx/fXJeXRho21/RC6MbWqmBOFglhhAEtiXgNQAmXU10LrF9DfZ6As4sMeAzb52+RLUyxxa13pc+BWzZz4f4KABWCQ2MR+eVjHtKkem4cyGI6zwLUBTeVoGvREvdAI1VU451q81oatUcfkponvZ+dw20s7RWNcKjGOKE1jiOk9vnEUiuaXcnquOakInGEWDJctE0uTu5xONuQrHPB/pSg1H9ixh8eXd+6T4GmUgsco+Uo7eiWzl/drMEjJz6PhChCpMYnfREaCdYSgjidf10Kn20UhlkZVrPSfxDrZ/yPAAcCUjLhOR6eun6QV2xwo0GSP5ZOUC9Ve32Cgjs2H5NxbweeUBAm1NiTBKYIT3eETG71JcW4wp6kUWKFmusem/Uky8GHkrGY8IK5/eMlBqS2hw1TEy7GBpVtfGsBObuVTlY24=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cUF0djNpRkhmVExCQVYvVENiU1lxbUxrMzlLalBnU3JvWVhYNkQwaDY1cG0y?=
 =?utf-8?B?WVI1Zk9yOUJDNFpTb1Bpb1NtNkthNzBTN1BxZWdMTmpVNm1GekxzTlNVc3Ny?=
 =?utf-8?B?QnpXemxmWXgwcVpadzN5WlFvaTI3UEF2Z1FtODRGR0xwaEV3aFBtRXNxTkxr?=
 =?utf-8?B?US9UQXFlQ25YR0xHblh3TkFqRXFKd3JtOFVkOGFXeS9uL2hZMzBzbkNXUUpB?=
 =?utf-8?B?ZXNVd0FpZDl0cVBkSG1BbExBL2pQa1IrOWxKS25jdWV6Z3diYWFYb2JuakpC?=
 =?utf-8?B?NUVaRUdpbmNTMzZCMDAyMVVwblIvbnAwazhjNFRkOWxuVllHb2RFU3FxajFK?=
 =?utf-8?B?ZVA2a00ra1VRNUJGaEVOekNHSU9mSDBBT3pLa2lSUDdBQjlIT1RYcG1wK1RH?=
 =?utf-8?B?YnMyaklqNXh2bjhlOGlmaXhBWUN0R0lSV0FCdm5iL0g1bytSbGJMOG1uSFkx?=
 =?utf-8?B?T2dKUmx5NnVNTFlIRzhQM2c0b1ZHUERjODZJc3lOSE5jdmljcWhFQjBlUVJQ?=
 =?utf-8?B?eGVHYTR1YXZxVi9LQVdtNm1aNkJINHFvb20zVk10RTV4VjUvblo5YnZkNmlC?=
 =?utf-8?B?NTAyU2gwdHJ1NHVHWlhCdWRKSm1wRVVRTDFaY2RUY1lBVU9DNFFjVVh5L1Jz?=
 =?utf-8?B?OVg1enpUU3ROZzdhb3Q5Y01KaGRxVzBwNUhvalR3RDQyOFVHMzA5YnV0N3d5?=
 =?utf-8?B?QmtVdFdXUGhrMFFlQk5yWVZ6QlcwejFpZzBGd3E3eTZrc1NIakVwZkNqVW5U?=
 =?utf-8?B?LzQ3bkdVWEVidnVOOUxJRDBBejU0NVZTNXFNTDRnRXFYRXZXVVlyTGc5NUtF?=
 =?utf-8?B?dHkydnl0eHF1dVRGdmxsVTJnUEZQWXdJb0J0aFBFUEhaUCsyWGhGNUNjOGwr?=
 =?utf-8?B?L2JRcmExcjJlcEFtY2psRXhRR3Z6OFozK0UzcTVZSnBpYmszTWsxRXlDV1FY?=
 =?utf-8?B?WVB1OFFOM2ZzdUJNS3VxUlpVSFhoZTc2OXJEdmhMMnlOQmpIUTZTenRvb2xR?=
 =?utf-8?B?V3A1K1dnSE8xT3hKMXRSQzZXMitabjlodVl5aWxzOVFpNVVSbmRERXJVMm9W?=
 =?utf-8?B?TUcyRzh2WmVIYXhYQ0dCR3FoQUdQQ0wyekR2aDZpY3FxUDQ2NTB3MWJQN09X?=
 =?utf-8?B?cFlCVEZ3Z05QRzVWRUVzdE91c0lMZ0VEazlwdXpJT245MEtVQXJoeFJwUGl3?=
 =?utf-8?B?cjYvVU5VeEg4b25PWmlLMlJ0WFg0NFd5OS83MjRCSHhQSnNUVnc0ZzBhY1dY?=
 =?utf-8?B?eFdjcndvM0dtLzBtbUpnWU5YSXdxV2tZZ2luYnY1SnlEQ1RsZERPUkN1SHhV?=
 =?utf-8?B?TlBPRmxSNVJHdm9EMGxwMCtFbnQ2eWlkOVpQQy9YY2lEa09GV3BZa0VUS3A5?=
 =?utf-8?B?YnpCdjhtc2dDOS8vbnBzb3VidjdyMmJsUkZOMFBHVmdQZE9zUVNjS0tVckJX?=
 =?utf-8?B?a0gyTWhQZUZLRTlYK3BNRHE2cmQ2RUR6ZHBEdWxDbGF6cWFmamIzMWZyRGND?=
 =?utf-8?B?dkJjeGhSYVhyV1VwRTFMdENUV0YzZXI4VDJOVlJMZDJtbzhDb29naEw5T1Mv?=
 =?utf-8?B?Lyt4VUtDTzMzclJHOENhZUU5Rm1HclRjME5lREpNZDdHQXhDNkJzdVZFK0Rp?=
 =?utf-8?B?eW1Td3BjUHNReTdzNG1DSk1PRU5UcXBaTDN0WjdIMHNhL0g1QVpJSHB5cUZh?=
 =?utf-8?B?aTd2M3B5cXY5UWg2TXlWeU9RakNDOERaSEFQWDB5UTE3U2ZNbGIyMVd3V09o?=
 =?utf-8?B?SXh6UjQ4L1cydWdXM3dqTXFoUmkwa21LS0NrUzNuUURQU3lxRnBZNjdySG5B?=
 =?utf-8?B?UzdOaU56UGtUQzVSN2dZOFhlSXcrbGVPaXRGT0RsUW8rR09kU0NhaDI1Yjh5?=
 =?utf-8?B?WEs5VlBUTTFYcndyUEhQRWFEZ2FIT0FRd3h5OHVkRnRDSVlibGNyd2FiSjBp?=
 =?utf-8?B?ZXExZVgraERZTWJYcHZOQjg5a1BzY2ZZUXJPWmYvbldoV2Z3WFMzb0Z4VE5W?=
 =?utf-8?B?STdBSG1XS1FlamhLZXZhRmV2WU9aWVJPRzVyZWFMZW8xMmxlaEYxcEVhSS9u?=
 =?utf-8?B?Q2x2Kzcvdm1kVU5qWU5xR2xITUlkeGV5aG1QSVdjWkVXTGJZK1hPSnZPWWN2?=
 =?utf-8?B?QkRDTHBKamNOSTVmL2FSWlphampEWW5KYU81Ynh1WTNiWHZqYjNlSkhiWlhk?=
 =?utf-8?B?b3FPZ2drMkxaVHdGV05BeWJjM3BLUTl1YmxETkFHaXRKUzVKLzhqRDZVUkVi?=
 =?utf-8?B?enRJQ1Q3bm9LcUd5R2t0MWdTL2JkeGxBNUtXMytmUnlNWHNobHBxdWl1d3Fh?=
 =?utf-8?B?aWZTSmZDMm56cEZSbXBvVUI1NVN6TUpQV1VEV1pFdkRkNzRQYVErZGpaejM3?=
 =?utf-8?Q?NCCfqVwYO2o11J1KSEgtroo4cdMmIwXGEIGcSSbZZ8d6L?=
X-MS-Exchange-AntiSpam-MessageData-1: hhykhcMfuSB1jw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a0113f5e-7373-49d2-9727-08dea680f93f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 06:23:20.3640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ieNF4xsjS8CFh9zb69aufL7dGt2/PLApHKpurgheBOXRGEG+nzZ+9KeMB+IraDM0CnezuE2zpAZWLsZ/HRX+3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5677
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

On Tuesday, April 28, 2026 1:57=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D0=B2=D1=82, 28 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 04=
:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Monday, April 27, 2026 4:58=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > From: Ion Agorria <ion@agorria.com>
> > >
> > > The gr*d_remove() has pm_runtime_disable, this indicates it should be
> > > paired with pm_runtime_enable in the probe instead of being inside
> > > gr*d_runtime_resume().
> > >
> > > Signed-off-by: Ion Agorria <ion@agorria.com>
> > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
> > >  drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
> > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2=
d.c
> > > index 21f4dd0fa6af..71f092d59d65 100644
> > > --- a/drivers/gpu/drm/tegra/gr2d.c
> > > +++ b/drivers/gpu/drm/tegra/gr2d.c
> > > @@ -286,6 +286,10 @@ static int gr2d_probe(struct platform_device *pd=
ev)
> > >       for (i =3D 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
> > >               set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
> > >
> > > +     pm_runtime_enable(dev);
> > > +     pm_runtime_use_autosuspend(dev);
> > > +     pm_runtime_set_autosuspend_delay(dev, 500);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -367,10 +371,6 @@ static int __maybe_unused gr2d_runtime_resume(st=
ruct device *dev)
> > >               goto disable_clk;
> > >       }
> > >
> > > -     pm_runtime_enable(dev);
> > > -     pm_runtime_use_autosuspend(dev);
> > > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > > -
> > >       return 0;
> > >
> > >  disable_clk:
> > > diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3=
d.c
> > > index 42e9656ab80c..33e88ca4d4c5 100644
> > > --- a/drivers/gpu/drm/tegra/gr3d.c
> > > +++ b/drivers/gpu/drm/tegra/gr3d.c
> > > @@ -517,6 +517,10 @@ static int gr3d_probe(struct platform_device *pd=
ev)
> > >       for (i =3D 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
> > >               set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
> > >
> > > +     pm_runtime_enable(&pdev->dev);
> > > +     pm_runtime_use_autosuspend(&pdev->dev);
> > > +     pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> > > +
> > >       return 0;
> > >  }
> > >
> > > @@ -578,10 +582,6 @@ static int __maybe_unused gr3d_runtime_resume(st=
ruct device *dev)
> > >               goto disable_clk;
> > >       }
> > >
> > > -     pm_runtime_enable(dev);
> > > -     pm_runtime_use_autosuspend(dev);
> > > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > > -
> > >       return 0;
> > >
> > >  disable_clk:
> > > --
> > > 2.51.0
> > >
> > >
> >
> > Oof, looks like I had managed to really bungle this with my earlier
> > patch. Thanks for fixing it!
> >
>=20
> Hello Mikko!
>=20
> Thank you for taking time and looking into this patch. Don't be so
> harsh to yourself, PM is easy to mess and hard to set properly. This
> patch does fix gr*d access but it does not resolve the issue itself.
> PM should be set in the init/exit rather then probe/remove. I have v2
> which fixes this and one more minor issue and I will send them later
> on.

Thanks! Why do you think it's necessary to enable runtime PM in init?
If you look at the commit I referenced below (in 'Fixes'), we've had
some issues in the past with doing pm_runtime_enable outside of probe,
where the engine's power domain would be left enabled even when it is
idle.

gr2d/gr3d I suppose wouldn't be in practice affected by that issue
though given they aren't in their own power domains.

Cheers
Mikko

>=20
> So for now this patch should not be picked.
>=20
> Best regards,
> Svyatoslav R.
>=20
> > FWIW, I've been working on adding some nightly testing for Host1x/
> > TegraDRM, so hopefully we'll be able to catch such things easier
> > in the future.
> >
> > Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> > Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> >
> >
> >




