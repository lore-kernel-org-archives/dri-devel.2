Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96222CD4846
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 04:07:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 98A3F10E0C2;
	Thu, 14 May 2026 04:07:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="n57Z60ar";
	dkim-atps=neutral
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010005.outbound.protection.outlook.com [52.101.46.5])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B117510E0C2
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 04:07:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lnHc98DrylmN7+Fo+CaDMS72scVvVMqCP0/NM2KNuQFCKM0rSca3M0T9geBp+zoLcI7A3XkCfL61eRNL6M9C6SaFv0Rr6jMt/FQb8fCEr07t/WdRBJMBVWjc1IfBd/xm5vnE5HQCqnbHMZxiuaBNJMaMRCIklAo7bny1ErBRbI5utg7P0a7+22NZ1JHYZqj5eSFk4jHBwgRpRk245KHpjjDBM/2vhPmy8xlqUjS9SEslH0BM+cKHRmbyWaMXaCPkaSNmphT9US0sQ00pIV7LwhyguiJJV2bbbbJtAAu7qy5lOvDZBCF/PCd8oztyZFfqD+oYpJOjKmixp96GtodiIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/PEgQVmuu7ECCBUhk2KiNmixWaxNpbPEEm6MZteOW6E=;
 b=f+GRc+xjUCuybn/9D2/uFujaUAUgX7jUqZwb/HsX1RF6Jfp5vkPMv3HLtyNns5Lnxx0BQ4lMIKl03P77mSoabVA0a9SME8pQsAGDKWq00BsxAMDUcJqyvtvmgD6BlOuBvDoZMdJ6myQ3H5/z9/JMF/XbyNQbXW0eyP3HIhzfFQq0vHVINaY4/RcAGUlMyGfR53xBIHJjX1kOc29X3z4wgl1zIG/71mVLdtmEGYTIOQMtIp+fNLxRwGJMttyg1HCgPv3trDAlxK4NzeJH9YBYBHhx/X8z3Zc5t4RgWzQibn9goIvvd6BQMerCGBYatyvfvlf5rFV+mvlcL/5odbMfhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/PEgQVmuu7ECCBUhk2KiNmixWaxNpbPEEm6MZteOW6E=;
 b=n57Z60arGGlRLSc6sN9w06dt6kw/dgKq5AQa90RnQpnbMK+nZXQEL3ujORJ/g7uYzc3h7o5RtXbbpWHMsTjojg2eHH51cWjtSeY5rVOZ+meW97p4jGySs1RiPBDp9qwCqZm/WxyuUGYZCWADI/+gV5bD0nGpxLJ0f5tASi9/D3XnHExJUKpnQ4jmj3lK7LJfnsD8gNw1o+/pGMGwYdu6qyxJL8Toda4TVDb9Out7KfhC2Hff2o0Y+gO8QFXvz7zzL2Ga/OYnEovjUVeYKRpB3fZiA+us3ZJDcYUTdPZpgdKJ36WSh9nhSdqPEQdDafscN72BF6WFnazHIvK2h99lBQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by IA0PR12MB8207.namprd12.prod.outlook.com (2603:10b6:208:401::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.12; Thu, 14 May
 2026 04:07:38 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9891.021; Thu, 14 May 2026
 04:07:38 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Ion Agorria <ion@agorria.com>,
 Thierry Reding <thierry.reding@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] drm/tegra: gr2d/gr3d: Contain PM in the
 gr*d_probe/gr*d_remove
Date: Thu, 14 May 2026 13:07:27 +0900
Message-ID: <yUGHnUTQTKW8E9_u4r6I9Q@nvidia.com>
In-Reply-To: <CAPVz0n1N4YHDPW=gsUZWZmRZbt8xQB1V8JWn6cyM75fo7H020w@mail.gmail.com>
References: <20260503163842.213489-1-clamor95@gmail.com>
 <20260503163842.213489-3-clamor95@gmail.com>
 <CAPVz0n1N4YHDPW=gsUZWZmRZbt8xQB1V8JWn6cyM75fo7H020w@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0126.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:37e::7) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|IA0PR12MB8207:EE_
X-MS-Office365-Filtering-Correlation-Id: 9298bb95-8ab7-4822-fdf1-08deb16e55d1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|366016|10070799003|18002099003|22082099003|4143699003|11063799003|56012099003;
X-Microsoft-Antispam-Message-Info: 2Baf59HJDevjM6dcbqm8rCbCNtDIuHJjTeEsXKbfssBJQVguWkAvIKXkXxTEmWu6AGHvKr4TLciXnDg32/YJBgDbPiM377cIVFunqKDcUOO4dTZHOzynhHP2yMtI9aiqhhtiCnuKOs7m97j4D9XkdNiMXnHQNyBHYNAstCBQPuhatx2tWJ1rI1PrPLefFqNgOEpZdce36MO7O+cb6DLb83asKQoHPJYmnDm9NLyHF4qI/qercW3ITq5Cw+REr5L8vIy4w15qfU6MHsG87II/H+IMhIBxsTBltP1ZzOwWI5iGFJJiGb/ZT+Zw+fg+fmwej0HX4lv/UrnwAr34mnF7MvOU89iym7EykySDfzbDJ1qSqUmImHqE8sHV9eJljxhMU5fMIQTyA3U/dhu/jvZ793Edp4bPu56giwSSq27QQ33IFHqLnf+S85tkG4j76C7jCT37AKZIP8xr7y8vRn4YwlzsQOp1NJRAX0TomDlyBQZ/JiTqZ/4p2R31BIqKERv8LiYcPQh24mrrY1qE6W1xTrIBW+CJA/S2EEWs1mPJ+h7qWSM0ywLfQjHo0GqXOUZz3+sgSeCuzqDmiqSxlG6keuCY4gcSeUmjjI9j4SgHuLQ0wAvPeyzgrklBy+2ne1gYvSztpELy8L8HmJhZ+gZbPEGgwb9oBGNiEInYsVlbA2Ba3PFqNkLQVNNpZVoWGkL0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(366016)(10070799003)(18002099003)(22082099003)(4143699003)(11063799003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?djNVV0FyMkdFR25IMTFaUVN3Q1NjQ0NtTHRseFFKQkprYjgyK2xVaGpzOFgx?=
 =?utf-8?B?dExxQ1VzaWVURW5hTDMzNWJwYzVzVFV6cUJNRjcyNUNjcDdITndhL2R4UTJt?=
 =?utf-8?B?enJyckRvT2lSckVBYkUxZEEzK1ppdUQ0QWNiOW1EbG9MRFpMUm85UFg5blMy?=
 =?utf-8?B?Ukw2L1I3YnJkNXk3Q2l4T2trTWRVNkgvR3QwOE9Oak5lM0d2c2JUdTRhWWo0?=
 =?utf-8?B?bmV6VzhONzBpR25LSDdnL09FM2g2ajZ1aWNjb2tKdzJFRWd6dnFWK2xUbTlq?=
 =?utf-8?B?RENBMEFDRHMwNWd2RjUwV0VsZEYrWWlOeG90QWIzc3R2YXVWV3YzYXAzYnRI?=
 =?utf-8?B?d0dPMkVsK1BKTFZJSFBvNGJCRWZBS3UwNFE4djB4azVvd3I2MzdtMnBzZ0JI?=
 =?utf-8?B?Zkt4emRFY2tJSEhTUnlDS3k1L2ZSYWgzbUQ4TjZWQ0lYM24yU29aUW5Wc09J?=
 =?utf-8?B?Z0dLR0VZYXJiVExONERiRGkxT3FwalpXczhtUnBHYmE0WnRnWW9lWjhxRHN5?=
 =?utf-8?B?TFVySkc1NUlPcGRqRnJ2UXB4cEdoZWVNUG03TUZyYWZPeTZoZUxZTGNBTVBQ?=
 =?utf-8?B?aVlZSmJSUzk1dEN3MGEwT3RZNnZubTM5dlc5bWZPWk5Eb0tJaXNGaGl6NkNm?=
 =?utf-8?B?NjdXR2dZTk1tYStUOVVGeUhiVDhRem1adVorU3VGNExtbFk0NmNOb010dDlO?=
 =?utf-8?B?TW1iSTZOeGxmT3hCQmRselUzSFY0dVlUUTNBeFNhTkdIekxTQ0d5YnozK3JH?=
 =?utf-8?B?SjdLY1c2cXk1MFVYRVlsb0RGd1B1Wm1iYUtLeHBGUjRJUk5hdUF5TmphNjZF?=
 =?utf-8?B?QlVRbVUwd092M21WUHdXdjQxckdTUFltd3pJbm13UzdCeC9OWDFHSXhZd0lk?=
 =?utf-8?B?VjNlS09DemZKVEk5SVBJdFQ1M2QzZWdaQlZoY3p6QjJRNTVRcklHTlhLNFIx?=
 =?utf-8?B?djZnNGovd0V0QS9tejJDSUg2TWVVNThBQWVhU0lSUWJadVhPT0ZKMUZXd2lw?=
 =?utf-8?B?VWx1STAwV1BQMklNWjVLemdaWkg5Uy9QQkdjdzMzTEpuU2lGeGVKckZMV1pY?=
 =?utf-8?B?dnFtOU1CaXpZZGNUakFrTXVMN09UUm53UGJDTlZhb1pNbkowYXNSVERlU0hx?=
 =?utf-8?B?ZmZGMVYycElaa1FWSjhJOHVXQlJ1WkhrOVZJditLRGFaV3luUkcxRklzU0U1?=
 =?utf-8?B?bkM0V1A4YmVJdTh3Z2lhSUZpUVVFNVRLOXA1anhpQWkvTDZyamZvOVhXc2RR?=
 =?utf-8?B?cUxnSEt2MU5NVTlMcVd3MGt5eFlHNEFWN2Fjb0RkajNqakhpQmFMTW1tNGNH?=
 =?utf-8?B?R3UyL2RyS1ZzWldXeHdQR3pGdW5uQ0c4K3FsbzRRLzc0YXJ2OHdyK1ZwREZv?=
 =?utf-8?B?c05PL3F5UkQwVzdSKzQxRXJkQUFkTnVhbTNBai84ZVUwZFd5QlM4MlRxZWNt?=
 =?utf-8?B?ZHpTbzJNQzM5SXUyRitGQUVKKzFwVWorOG9TQ2sxd0hDcWo0VlVsbmJtVi9z?=
 =?utf-8?B?TTFMQ2V0bisxcU9KU2c0L1ZYRHlEQUxVZE1RL1lLUGE2dTJ4ZHdSZzNLZjdz?=
 =?utf-8?B?Rmw4TmllTjVEOGZzb3JQLzJSREdJeDFCc3VFL0NJSVhUUHUrNmFPb3NUTEdl?=
 =?utf-8?B?MnJ2dDNKaWN0RHJ1RHJ1U1RhZjMvRkJwa2lnY1JUZkFRR0pqOFVRa1pCc3M3?=
 =?utf-8?B?R2pDaG8ydnlIUmFuUVN4VDhiSjRVVUdvblJJcU8zdVk3K01uZzBaUFVBL2F6?=
 =?utf-8?B?eGdGd2h0KzBsb0VpWnAwaG1XNTdLaUtkeDJpOWo5ckhTRXYycFVSUzR0bGd2?=
 =?utf-8?B?TDNrTFZDcUNYL2lSa0RTUE5RNXIrUlJoV01ZNmFGK2NGOXJyN0N2SXNYVGtZ?=
 =?utf-8?B?azR2OVZZbjU5cmlUOCtSMEpkYnFTck9HblpacmdHOFN0eGM2Z0VEZmFkeDNK?=
 =?utf-8?B?RDNXOEY0YjNwRUUzRFlCZlNwSU0rdkI3QXo2Um1jZzJ4VHVjcEJoTmxEb0VI?=
 =?utf-8?B?ZFphMitwcDJNS1NIUU5RM012QzNPdkpnRmZoNUNtei9HbFBFZTlBWUQrRXFs?=
 =?utf-8?B?M08wdjZVOEhDajJYU2FpQXlmL2FpMzlHSXFHWEVsSFcwTkMxbkhGdDZaMDZM?=
 =?utf-8?B?UU1SdGJERG1XSWxGYTdjNm04RFdXTllWVzAwRG5lUHFQQ21MUitEODlTeWQ0?=
 =?utf-8?B?VkJTdGFUNisyd3NGWXRnTFErSXVaS1RVRjZLSEw2cUMvcEI3dGVYS05ReC9R?=
 =?utf-8?B?MUt1UG5WS1VNNFFzV05ONHJJSlQ5amZGRTZHUDJzTU1RaDlxQ21qcVhjQVBU?=
 =?utf-8?B?OEVZamJtSUoxUTBSY0VsbmlIQmVkbmhCSFN2UThzKytORVBvdkl5MkpFM1Jn?=
 =?utf-8?Q?shSlRKSNbEWyg0P3fgYHY4IBnw/0znW2e4cucEl56+laG?=
X-MS-Exchange-AntiSpam-MessageData-1: yxrswCJnTUInbw==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9298bb95-8ab7-4822-fdf1-08deb16e55d1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2026 04:07:37.9907 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5UZC9K469EViXXWPdt7O/aKDXTcuwx+RBrheBi5oSLRboKt6lAHwQcQPzPk796Sqrp5T+SrzqdR5a9hQK9wOoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8207
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

On Monday, May 4, 2026 3:36=E2=80=AFAM Svyatoslav Ryhel wrote:
> =D0=BD=D0=B4, 3 =D1=82=D1=80=D0=B0=D0=B2. 2026=E2=80=AF=D1=80. =D0=BE 19:=
38 Svyatoslav Ryhel <clamor95@gmail.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > From: Ion Agorria <ion@agorria.com>
> >
> > The current power management configuration causes GR2G/GR3D to malfunct=
ion
> > after resume. Reconfigure all PM actions to be handled within the GR*D
> > probe and remove operations to address this.
> >
> > Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> > Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> > Signed-off-by: Ion Agorria <ion@agorria.com>
> > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > ---
> >  drivers/gpu/drm/tegra/gr2d.c | 11 ++++-------
> >  drivers/gpu/drm/tegra/gr3d.c | 11 ++++-------
> >  2 files changed, 8 insertions(+), 14 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra/gr2d.=
c
> > index e4148b034af7..ffcd076b5831 100644
> > --- a/drivers/gpu/drm/tegra/gr2d.c
> > +++ b/drivers/gpu/drm/tegra/gr2d.c
> > @@ -100,9 +100,6 @@ static int gr2d_exit(struct host1x_client *client)
> >         if (err < 0)
> >                 return err;
> >
> > -       pm_runtime_dont_use_autosuspend(client->dev);
> > -       pm_runtime_force_suspend(client->dev);
> > -
> >         host1x_client_iommu_detach(client);
> >         host1x_syncpt_put(client->syncpts[0]);
> >         host1x_channel_put(gr2d->channel);
> > @@ -286,6 +283,10 @@ static int gr2d_probe(struct platform_device *pdev=
)
> >                 return err;
> >         }
> >
> > +       pm_runtime_enable(dev);
> > +       pm_runtime_use_autosuspend(dev);
> > +       pm_runtime_set_autosuspend_delay(dev, 500);
> > +
>=20
> Hello Mikko!

Hello!

>=20
> I have used same setup as in VIC. May you please take a look to sashiko's=
 check
> https://sashiko.dev/#/patchset/20260502124055.22475-1-clamor95%40gmail.co=
m
>=20
> I do agree with statement that pm_runtime_enable should be before
> host1x_client_register since this same approach is widely used in the
> media subsystem too.

Yep, I agree as well.

>=20
> But I am more interested in your thoughts regarding sashiko's
> gr2d_exit situation reasoning.

It sounds accurate to me, there is probably a real issue. I expect
there to be in general some driver unbind related issues, since it
(particularly when the device is in use) isn't really being tested.

FWIW, in an ideal world, it would probably make more sense to do the
IOMMU handling on the platform device side, since the device's memory
accesses are not related to host1x. But we can't really do that right
now.

For the time being, I don't think fixing this is particularly critical
since other things will go wrong as well if root causes .exit to happen
while the engine is executing. I can't say offhand what the proper full
solution would be.

Thanks
Mikko

>=20
> Thank you!
>=20
> >         return 0;
> >  }
> >
> > @@ -367,10 +368,6 @@ static int __maybe_unused gr2d_runtime_resume(stru=
ct device *dev)
> >                 goto disable_clk;
> >         }
> >
> > -       pm_runtime_enable(dev);
> > -       pm_runtime_use_autosuspend(dev);
> > -       pm_runtime_set_autosuspend_delay(dev, 500);
> > -
> >         return 0;
> >
> >  disable_clk:
> > diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra/gr3d.=
c
> > index 47b0c6c56bfd..cd5554e2117f 100644
> > --- a/drivers/gpu/drm/tegra/gr3d.c
> > +++ b/drivers/gpu/drm/tegra/gr3d.c
> > @@ -109,9 +109,6 @@ static int gr3d_exit(struct host1x_client *client)
> >         if (err < 0)
> >                 return err;
> >
> > -       pm_runtime_dont_use_autosuspend(client->dev);
> > -       pm_runtime_force_suspend(client->dev);
> > -
> >         host1x_client_iommu_detach(client);
> >         host1x_syncpt_put(client->syncpts[0]);
> >         host1x_channel_put(gr3d->channel);
> > @@ -517,6 +514,10 @@ static int gr3d_probe(struct platform_device *pdev=
)
> >                 return err;
> >         }
> >
> > +       pm_runtime_enable(&pdev->dev);
> > +       pm_runtime_use_autosuspend(&pdev->dev);
> > +       pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> > +
> >         return 0;
> >  }
> >
> > @@ -578,10 +579,6 @@ static int __maybe_unused gr3d_runtime_resume(stru=
ct device *dev)
> >                 goto disable_clk;
> >         }
> >
> > -       pm_runtime_enable(dev);
> > -       pm_runtime_use_autosuspend(dev);
> > -       pm_runtime_set_autosuspend_delay(dev, 500);
> > -
> >         return 0;
> >
> >  disable_clk:
> > --
> > 2.51.0
> >




