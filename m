Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDE1CFF8875
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 08:38:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C5F810E418;
	Thu, 30 Apr 2026 08:38:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="tG/Zh8Ez";
	dkim-atps=neutral
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011043.outbound.protection.outlook.com [52.101.52.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BF4010E418
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 08:38:38 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rXxS3hq5DeWzOe9LMDlWv717tgRd5Ge39Mvp+9gtH1X3jRnfoJndC6EwrlJ0hW4s0SvWS5SCyvRd/BBRKD0RTuxkj9SWO3NiHHgY/PoFcII9343lDjhuba4aPsWrcZP7MXZNca2MatrKKgMGXiE4vphGPvD4RxC+CDQwUBf/nRQyfGaMzJIoVIOXOyUbe5DAWGK/Plc3d+0rFUuWQgzifVoqFDggW/3y5P2xSynrjRdxIUM7CjMVIdsOuWE/E0kFLfxOTGiRYKhX1nOHK4qZhU/yoY4hNF3FSH3Neb0hbYmUgeh03kc8kaghCX4mcHzL8hn0N12GZT+YLceCMLIIJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AbZArEKi2F+Ir6HbtZqOUx/DtAWM/rMSCUdRr5LwQH0=;
 b=ad8MBKY+6tu5YiHku0V3MyzhJOcrNkoro/JYVaprKisGUndDtBuWMYRNoUYhPlKpYeak6dyyCNW+VCjsj9yTISXya++CVkOU+RTFhEFMegVFF/R02mKvbhRK/HDB47BMvOqqWviVb+aYEuTmrX5woZmoUJgMT4pxLE6Uj+vdnOJZAz+f5jNghDwHgRX8ytl5tTSbYxTDtkXjivmK/YX1WzYqXzmkGquapbNv/QlxFFDB7npWoGBj3eIl6RbRDC+ExSo2eaZPjus+lMl5pwjHSLhIPLYKpDMdXUh8mzRNsVNUN+pm4VASuZeKdSNscuytlaZuMiQRAm/VBbnj6lo7OQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AbZArEKi2F+Ir6HbtZqOUx/DtAWM/rMSCUdRr5LwQH0=;
 b=tG/Zh8EzT+5Stod4I1RMDS4tOSsK2qtPAdO6Otw4o2zpGSimGpq16Z3NJbks9UQtZhokClPdUHjU71SE/ArEFU22ONvU28Zc2C9AQEk6qcaTcQv3ZsaRn/HyQB+D5Tcco+I49fdXpl6HbELYQJMPp6KReXXFiHbQ9+FgGHIc4Dn4KeyvpvNcYwVC+lwy5CednuuRO55WhzZGfZh50GlEPsqrhckpm9P6Fgp0GcMwQWRPKxeW9rPDvUnEjGkyN6aTWxKVXOZZEksO/wFr9gdbPVfufFc4Jn9SJqUsyLGRocsdPmejKqdShbKr9lNE3o6ZMITeh6MWZKzoYWS6eWAJmQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by CY5PR12MB6228.namprd12.prod.outlook.com (2603:10b6:930:20::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Thu, 30 Apr
 2026 08:38:32 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%4]) with mapi id 15.20.9870.020; Thu, 30 Apr 2026
 08:38:32 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, Ion Agorria <ion@agorria.com>,
 dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/1] drm/tegra: gr2d/gr3d: Move pm_runtime_enable to
 gr*d_probe
Date: Thu, 30 Apr 2026 17:38:28 +0900
Message-ID: <soBCUeXPQ72A3pDzGjjMng@nvidia.com>
In-Reply-To: <CAPVz0n16zCgCZwPXWMPg=KiYLwc3beBzVqYVB96in7zn0Wkxqw@mail.gmail.com>
References: <20260427075856.85208-1-clamor95@gmail.com>
 <SGKRjIZyS4mU2gPAiUbKJg@nvidia.com>
 <CAPVz0n16zCgCZwPXWMPg=KiYLwc3beBzVqYVB96in7zn0Wkxqw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TY4P301CA0039.JPNP301.PROD.OUTLOOK.COM
 (2603:1096:405:2be::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|CY5PR12MB6228:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f018fd1-77c3-4854-0a45-08dea693dc4c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|1800799024|376014|366016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: qMSNv/Mo/+x1nE0nvAfKe+ZAi8P0LfYcmvzFp+4QcwRllePYbqA8WShoXzCA+ZKG9ApI4tw2FauLntkNfIYjqzLYOti9LUtbtuY6Eqh5RA3GVHu496fz1/cVBDsLbTfQ8+Ear3i7tqw6YfG/xYYLYN0/r9XuTlwNLKXubOlctA+3+pNHXqidOhS2UPN6f2Y47ZhGI6Yzi2ZpuBSWfsknyVMTqRuNL+29DhQrox2jZqaR4TDdZ7CxKj+k72eX+vaToYZYMbSahFQsQN0f7SVoQlqpa9ZTZ50Ki/L200Xu8/oQvswLE6O0uH5n65dv0zUli3rUjBZjT6HtOQRzVG/WkbuQeOKkIuDVd3uRB2PGcobuyRGoeTaXL0H5bq/UAhj93nl9xgbA+PBMRX3j41xtb0DzCrdWF52QyupDzXs/ipew/E7oTMg2Wm7Ui2Vo7KRGYXU16MmUs2IA1YJ5cfrz+wBzZN5jHCgk7ACrhl16RFecq/60tNx2dm8a7elXOwgy2/EJHy9slptOgXbftwyvtWD8RmVACeVDzaMd7sqWApoRXutiCuK/hI7DlwdWmZpkvGh6LZuZoXQ294T2sRw5b/k53flWOtE7/Sw1Pb3VD311lRxpBSAK4iBd9rA409+GsEUbisMtPnYi0tZXTCZ/iPe85iKnmrz3Ib8dwlYoyNB03d2NU20Ltgy+f6o5Wx3Yq3Z9It3tEDBrON8KG0dEUAzaCogkPDccX1s5CA0SdKk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bHJ2eHVpdlcyRjJwcmVDcHFwN3VJdlE4RSs2V016RmZ1dnNXb0ZXYVRZOWVF?=
 =?utf-8?B?Z01hTDR4ZUE5Y05YUmZNbGpQTlhDQUF4Q0pjK3BxUVhSbk5kR0IzU0JhT2pM?=
 =?utf-8?B?NytROGFKNUZGSHN5OFU5V3BwT2dNWnlhdEZGLzZKOXBlQVlJU1M3YVVSQ2x4?=
 =?utf-8?B?cUsxNW9Gd3h5SmV0SWp1Ri9lVGsvUXBCU0haRlVWVWJrRjB4MVZFRVhrcWFo?=
 =?utf-8?B?cTAxSStxT21sSjR5OGg0OWluVWxUakYxQ3o3b3hHUnh6Sm41Y2xScUFiaTQ1?=
 =?utf-8?B?blVRTUF4cW12ek42Mzk3T284SW40amdNTm1Yay91S2ZBYmFqTjc5TnJMd24z?=
 =?utf-8?B?TytXcno3Qk0yTmJaVzFDaEllWDhaRkxxM25hMktNODdRSmJ6ZmhkdHJXRVNz?=
 =?utf-8?B?S2V4RW5zdThER0pZYU9hb2JYbEpveVNyczRlTDJjaFk5WU00cmRRQlNjV2xl?=
 =?utf-8?B?UFBnTzgvcWVhbGNqTExTUEdpWnNaNGZsUXBUdGYyUk13eTAzbWIweVNpUXpX?=
 =?utf-8?B?ZStYZ1JnK0NUeTJEK09tamdqTDN5bnRVcko3UHdITUlRQnBrMzM5dHBzUzBh?=
 =?utf-8?B?d3JLbjlSMHRPNkJPV3l0akFXeGhOM0JjYW53c0VDbmVpcVBpOUo0NnF6NXZy?=
 =?utf-8?B?SXAyODQ5ZGlvTnU2WHlCVzlmQWtrOWZFdjl2bTk4WHBHOW54N21RMUtSYVh1?=
 =?utf-8?B?ZnlPRlVtMUoyQURIQm55dGNlbi83Z1J0WTRNYUdZOXVJeU8zRDIzcUNZRmkx?=
 =?utf-8?B?SW9vOUtwY0xhaFlmbG5IbkNlMEdSSzhwaTVvZENMc3FZaytuVGZmV2dyU2hv?=
 =?utf-8?B?OWpXQnlhdHIvQ2lHaWx4d1hpdzFtY2hIVTNpZ0lZZ3VVRVh4YXg1YnAvTmVH?=
 =?utf-8?B?L3ZOUHgxWVJhWjNMN3JiNlA1WXlBS2hvWEx6SWFUYnd6SFJqdVdQU21MLzVS?=
 =?utf-8?B?VmlDc2tLSStkOGJlVzFQTzM5NWhuWFhZK3BURnZWMkRNVTlLZWYzRnhyVzFZ?=
 =?utf-8?B?TlBnVXJ5NWF2bU5TN3dlZDE0dlhsZE11ZmJ6Yy95SytLZ3ZqWVZ3UFVueGVF?=
 =?utf-8?B?Tk81NHQ2Y2ZQVjdpOE1udXZNak5JM2dZcEF0R3A5ek9rNXgzQUhTdHpMaWQ4?=
 =?utf-8?B?SVZwbDBIS0ZhQXBWZVhUSFpvbHRNWVpIbXlURlNtRWozU3EzRk5icHoyM1JZ?=
 =?utf-8?B?bE5zZCtvLzBEK2JZQWMzS3MxZlkrd2t2QzJ4YnNUeU5tZi9wdUFybDRaOXZh?=
 =?utf-8?B?Ym1UMGlFa1JSWW1OMkloM2ptWENzNUVKQ2N6bVJuemtlVmVUaWRQNFJkLzZp?=
 =?utf-8?B?YUV1LzlLTnhTWDAwTVNJcVJCK1RCN1FpaUJ3M1dDeXZDSHgyaGpsRGRkblZq?=
 =?utf-8?B?RjR0MTkrMVVPVUNUU25lRGQrTHRBMSs2R2pCc3NoQktMdXFIVWlqMDBHNFlk?=
 =?utf-8?B?NlJCTnJqRkJsT0tZR2pkTk5DcFE5WGlNNkc1VFZHTWRxRDNxQ0VPTlVrMzEz?=
 =?utf-8?B?azV5Mms4SGFsR0dJNzdnMXF3ZE9raFJCS2tTMU8vdCtSU1hoMWdZNnM1c09y?=
 =?utf-8?B?M2JwSjFUK1BodXFZVjVJWFcyelNLb3FUVUVTcUd3ckJZU2Y5bFNFNlhOcTdK?=
 =?utf-8?B?WVlldXpjek9PZG1RMERmYjVkMjYvOWZ2cGlVR3FncGkyaHMwYlNqN2FOamV0?=
 =?utf-8?B?azJ0TklOMTVCUzVLc1RDVjA4RUhXcXE4dGRKWXF3aXgwcEV6M1FEa3JKMkhJ?=
 =?utf-8?B?ZjBGWTRTQVViTmFxM0tlOGNXRWJaUE9YTHNGS0V0VEVLb216UTE1RTE2UVJN?=
 =?utf-8?B?Y0lvRWt3MzJqbEx0RzY5WExYUXFzU2sxVmRMQ043L1hpRW9kOE1mTTF4ek4r?=
 =?utf-8?B?b2VkN3ZncHNLRjZ1bGlhUVZVd3hjOW45alUxamN3ajNrZk9ocnVwTkFxWXVY?=
 =?utf-8?B?TWVkaThib2hqbFRoUUZCNy8zaGlhOFJqaEZnR0ZhNlVXNExDUy93RVkremsz?=
 =?utf-8?B?ZTlqdCthU3NEYnA2Mml0M2VXZWpXZm83ZmttclNGRlBEbjcvdGhQSEJDdC9I?=
 =?utf-8?B?c3c3ZDZxb1FlaS9rbmhkR2xOcUx0bUZVSTNnaTczQkFlZlE5U1Y3cUVqeTZj?=
 =?utf-8?B?TisyQUg3K0k3RGhDNEZYcThaQUU1eldJMTRoMEg5WUtNNWtuSEp1ZzZrNVkv?=
 =?utf-8?B?QUxESlNJZ1hNVzcyYUhoZ1YxalpiN0pManBwVDl1OTBXRWgwazBtYjRFalE3?=
 =?utf-8?B?MUU1K2VnZEx0SnJ5VHNSL1cwdXhudjBEUzVFZHl3NkVzb1FZd2h2d1NOYk1q?=
 =?utf-8?B?RktIOW5sMDhRWVNLZ3dBVzFPcXdzVHM4OWNTQVdnK3NVc0dIMkk4ZVBFTWZ1?=
 =?utf-8?Q?+fEG9SdrPFTIVsjUoOk5iPw4bc+mXPLgBhnycnfEaq7EC?=
X-MS-Exchange-AntiSpam-MessageData-1: StqUAF3oVsq8Ag==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f018fd1-77c3-4854-0a45-08dea693dc4c
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 08:38:32.1847 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xZ/e1bs0Keyp3+Bqy0JDMp/IoeeDVdjolCrehfkLvHaT6JNMRVTgLQM4D06D9XIKVUjezlRjoTcQ6sNsj7RbbA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6228
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

On Thursday, April 30, 2026 5:04=E2=80=AFPM Svyatoslav Ryhel wrote:
> =D1=87=D1=82, 30 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=BE 09=
:23 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >
> > On Tuesday, April 28, 2026 1:57=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > =D0=B2=D1=82, 28 =D0=BA=D0=B2=D1=96=D1=82. 2026=E2=80=AF=D1=80. =D0=
=BE 04:53 Mikko Perttunen <mperttunen@nvidia.com> =D0=BF=D0=B8=D1=88=D0=B5:
> > > >
> > > > On Monday, April 27, 2026 4:58=E2=80=AFPM Svyatoslav Ryhel wrote:
> > > > > From: Ion Agorria <ion@agorria.com>
> > > > >
> > > > > The gr*d_remove() has pm_runtime_disable, this indicates it shoul=
d be
> > > > > paired with pm_runtime_enable in the probe instead of being insid=
e
> > > > > gr*d_runtime_resume().
> > > > >
> > > > > Signed-off-by: Ion Agorria <ion@agorria.com>
> > > > > Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> > > > > ---
> > > > >  drivers/gpu/drm/tegra/gr2d.c | 8 ++++----
> > > > >  drivers/gpu/drm/tegra/gr3d.c | 8 ++++----
> > > > >  2 files changed, 8 insertions(+), 8 deletions(-)
> > > > >
> > > > > diff --git a/drivers/gpu/drm/tegra/gr2d.c b/drivers/gpu/drm/tegra=
/gr2d.c
> > > > > index 21f4dd0fa6af..71f092d59d65 100644
> > > > > --- a/drivers/gpu/drm/tegra/gr2d.c
> > > > > +++ b/drivers/gpu/drm/tegra/gr2d.c
> > > > > @@ -286,6 +286,10 @@ static int gr2d_probe(struct platform_device=
 *pdev)
> > > > >       for (i =3D 0; i < ARRAY_SIZE(gr2d_addr_regs); i++)
> > > > >               set_bit(gr2d_addr_regs[i], gr2d->addr_regs);
> > > > >
> > > > > +     pm_runtime_enable(dev);
> > > > > +     pm_runtime_use_autosuspend(dev);
> > > > > +     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > > +
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > @@ -367,10 +371,6 @@ static int __maybe_unused gr2d_runtime_resum=
e(struct device *dev)
> > > > >               goto disable_clk;
> > > > >       }
> > > > >
> > > > > -     pm_runtime_enable(dev);
> > > > > -     pm_runtime_use_autosuspend(dev);
> > > > > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > > -
> > > > >       return 0;
> > > > >
> > > > >  disable_clk:
> > > > > diff --git a/drivers/gpu/drm/tegra/gr3d.c b/drivers/gpu/drm/tegra=
/gr3d.c
> > > > > index 42e9656ab80c..33e88ca4d4c5 100644
> > > > > --- a/drivers/gpu/drm/tegra/gr3d.c
> > > > > +++ b/drivers/gpu/drm/tegra/gr3d.c
> > > > > @@ -517,6 +517,10 @@ static int gr3d_probe(struct platform_device=
 *pdev)
> > > > >       for (i =3D 0; i < ARRAY_SIZE(gr3d_addr_regs); i++)
> > > > >               set_bit(gr3d_addr_regs[i], gr3d->addr_regs);
> > > > >
> > > > > +     pm_runtime_enable(&pdev->dev);
> > > > > +     pm_runtime_use_autosuspend(&pdev->dev);
> > > > > +     pm_runtime_set_autosuspend_delay(&pdev->dev, 500);
> > > > > +
> > > > >       return 0;
> > > > >  }
> > > > >
> > > > > @@ -578,10 +582,6 @@ static int __maybe_unused gr3d_runtime_resum=
e(struct device *dev)
> > > > >               goto disable_clk;
> > > > >       }
> > > > >
> > > > > -     pm_runtime_enable(dev);
> > > > > -     pm_runtime_use_autosuspend(dev);
> > > > > -     pm_runtime_set_autosuspend_delay(dev, 500);
> > > > > -
> > > > >       return 0;
> > > > >
> > > > >  disable_clk:
> > > > > --
> > > > > 2.51.0
> > > > >
> > > > >
> > > >
> > > > Oof, looks like I had managed to really bungle this with my earlier
> > > > patch. Thanks for fixing it!
> > > >
> > >
> > > Hello Mikko!
> > >
> > > Thank you for taking time and looking into this patch. Don't be so
> > > harsh to yourself, PM is easy to mess and hard to set properly. This
> > > patch does fix gr*d access but it does not resolve the issue itself.
> > > PM should be set in the init/exit rather then probe/remove. I have v2
> > > which fixes this and one more minor issue and I will send them later
> > > on.
> >
> > Thanks! Why do you think it's necessary to enable runtime PM in init?
> > If you look at the commit I referenced below (in 'Fixes'), we've had
> > some issues in the past with doing pm_runtime_enable outside of probe,
> > where the engine's power domain would be left enabled even when it is
> > idle.
> >
> > gr2d/gr3d I suppose wouldn't be in practice affected by that issue
> > though given they aren't in their own power domains.
>=20
> WDYM, gr2d and gr3d have their own power domains.

Ah, my bad, didn't look far enough in the device tree.

>=20
> If the master device is unbound and rebound, gr2d_init() will run again, =
but
> pm configuration is only located in this probe function which will not
> run again, while pm disable are both in exit and remove. This results
> in pm issue we are observing.
>=20
> Solution would be either do everyting in probe/remove, or init/exit.
> Probe/remove will lead to domain being turned on even if engines are
> idle. Init/exit seems to me more suitable and we have tasted this
> configuration for a quite while in the grate DRM version.

Yes, we should only do it in one place. Where are you observing the
domain being turned on when idle?

Genpd turns on the domain before probe is called, and it should turn
it off again after probe if probe had enabled runtime PM and the usage
count is zero. That's what we have currently for the newer engines like
VIC and it's working.

We used to have it in init/exit, but then we were seeing the domain
sometimes being left on at boot, which makes some sense since as probe
didn't enable runtime PM, genpd would leave the domain powered after
probe. The domain would then also never get powered off when init
enabled runtime PM. I assume the reason this only happened sometimes
was that it was dependent on if the init function or the genpd
post-probe code ran first.

Based on that we should have the runtime PM handling in probe/remove,
to ensure genpd turns off the domain after probe when there are no
users.

Mikko

>=20
> Best regards,
> Svyatoslav R.
>=20
> >
> > Cheers
> > Mikko
> >
> > >
> > > So for now this patch should not be picked.
> > >
> > > Best regards,
> > > Svyatoslav R.
> > >
> > > > FWIW, I've been working on adding some nightly testing for Host1x/
> > > > TegraDRM, so hopefully we'll be able to catch such things easier
> > > > in the future.
> > > >
> > > > Fixes: 62fa0a985e2c ("drm/tegra: Enable runtime PM during probe")
> > > > Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
> > > >
> > > >
> > > >
> >
> >
> >
> >




