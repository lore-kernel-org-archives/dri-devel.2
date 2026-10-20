Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B59C6606A32F
	for <dri-devel@archiver.kernel.org>; Tue, 20 Oct 2026 06:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=N70gl0Nc
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2958D10F24B;
	Tue, 20 Oct 2026 06:33:42 +0000 (UTC)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013026.outbound.protection.outlook.com
 [40.93.196.26])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1105510F247
 for <dri-devel@lists.freedesktop.org>; Tue, 20 Oct 2026 06:33:36 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rzVFZ5CCSLZHOXwNXoI4PlXaFKp2D5Bbmj2fcVZQ5Y4lcq7cF8akD+AJOfoxMTMDunbjlgDp8MGrsgK3T2ytPzCn/s2ZSj/wTr2s1RyddK7jYIxeSmhqJhIg3s6O33980W1e3SOnSOxYDNWIPf7uZH8TjH0dhR6zGsurRYBLMKGi1ce2iHGNpoYOjso++vFgAU9ljqGdaji8Kd5b/eUXEMKMP66mjEwbMUQamNAwMJCk33Pfmn/0zw3GsYLUSh2KzRmgX8EMHQ/hx89Ov/FfmqfbS3acrOYlMoyMMCxwp3feolTgJN2Px8bhbzCPyX6NEijTpe24SaIi79Rc5XWtJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KKeWkmD2ouOduM0yZatQ+T3v16WnDdxAV2w9E4alQoY=;
 b=S7M4S31EHOqbG4BxLl6AVP+MBRc/iA6llWAP4AZH6txf4bZoqdF/x6yctC5pE82qScginaO5TWLgtA8CV9KomDb9c1kHHkwppq5KSAamUJKeC1vdnOIS5l/DE/vrrUfNPrFT5poC5wZp32CiR/I38DEHu7Z0fLJKw47HnVYg0HSboBqx+rp/SokEYt19L0U7u4t0ebfMWIi293HlCybPD+DaIkP31LOtGYx6yAWu20Q+h0b7e8pSDdwhZnvkv7EJKg8oF+giIiUVT1BceMXjsqQpekCLl5GfMe2hD1hxsgnQDp64Tshh5bmfB458jg/RkL4OUl2n/X8akq3LoonWMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KKeWkmD2ouOduM0yZatQ+T3v16WnDdxAV2w9E4alQoY=;
 b=N70gl0Ncqm7RYIefFr2BCx8P9s2d/GZSed9HhhvLN1pW2RI7IQtP7veF2nUEO0MKZc1VcZhigDxzh7aeviLyA+tEZU40eVqRBXltRyR/r9HOnNSnMQxCGs2Mj7/TYuNnSWHigKL16wAJBMDlIaOo/ZQTPV61FnK7NA6hSg9aShK0Jq2YDxr/7qrUyIsW1VCfPEJO2aL9irNU11C+T8hfdyBMZzhGKnmbLYIfcGGapRfiduH0fHMi7NRmMsqXpqpVc7gNbn4rMR0sHIfMp/f8yHfmXxz8UsGkG1fxMi4l9OA8tUEVh5BYbSg2N3TYEIurUdODqrBDRuVyaZgU6M19uA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20)
 by DSVPR12MB803185.namprd12.prod.outlook.com (2603:10b6:8:3ea::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Tue, 20 Oct
 2026 06:33:32 +0000
Received: from SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017]) by SJ2PR12MB9161.namprd12.prod.outlook.com
 ([fe80::d9d1:8c49:a703:b017%5]) with mapi id 15.21.0546.012; Tue, 20 Oct 2026
 06:33:32 +0000
From: Mikko Perttunen <mperttunen@nvidia.com>
To: linux-tegra@vger.kernel.org
Cc: Thierry Reding <thierry.reding@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Jonathan Hunter <jonathanh@nvidia.com>, dri-devel@lists.freedesktop.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 Aaron Kling <webgeek1234@gmail.com>
Subject: Re: [PATCH v2 1/2] drm/tegra: Support swapping chroma planes
Date: Tue, 20 Oct 2026 15:33:29 +0900
Message-ID: <YwDFPLEmR6OpEy_iH5qhQg@nvidia.com>
In-Reply-To: <CALHNRZ9pTTLTpsKCi7oETcjpxNbZmQxfnC+pvEx4Wezv1_zchw@mail.gmail.com>
References: <20261018-tegra-drm-yvu420-v2-0-512889103ab4@gmail.com>
 <HmrilxC8QwiAQGw2IQ1Ztw@nvidia.com>
 <CALHNRZ9pTTLTpsKCi7oETcjpxNbZmQxfnC+pvEx4Wezv1_zchw@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: TYCP286CA0084.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:2b3::14) To SJ2PR12MB9161.namprd12.prod.outlook.com
 (2603:10b6:a03:566::20)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB9161:EE_|DSVPR12MB803185:EE_
X-MS-Office365-Filtering-Correlation-Id: 991f9a30-c8c3-4fce-6793-08df2e740f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|10070799003|1800799024|23010399003|376014|56012099006|11063799006|4143699003|261009223027099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: uw+bKo5f+wu3yoeWSfsgkq3Gb+ZuecmzKL7M8TGMZpemWwPRt84/ylfd7eXTuheCYE7I1nar29SW8vjIF76GX1j4r6GyiXkOMa8LUrjrglUpj1pQZhn1h34p/IpMZiNKkwDczqLPrS5NEcuOYg+/xXrYTjHPNMpXDf9kuUwdFdbRANHiWq9Gdy9wofYK9oqw2PX30N7gz+X/QT8qnTvd0Ee2MYkRHOCwacs7WyUXBoLbtIoyu+qCdFvnJCNWX2OAMGaQ7R5DWYj8P8T/tQT0lsBhdWe5wseCFFC95Y1HDY6uOfrycYb/dKFDgQLeJ5l2GPAjqzWOwn1oMGck0pY0kKS5pHturwyZ/elqBjK1vgiOdQrhaWYxyhh/u1ajY01zYBqmp61MDTz1x3ibJK9c9FWnP61FwjLKgtIGu5MyrpkBO/WD724+3Yw79k+OFynpqoaEWjsdhaLHutM0Z3n6oHeIRUzBzhy1u/qyA2mIiOE+WjZkIDi7oOiThDxjVYMl37VFNLw2oPeGC7ueLgO3y9OdM2PUm9fy8FDmrU6x9wcSYsemjE6uw4I1BwxXxSv6njG+0yViljRc6H/FSvqUd2a1Vk5YmGJqTwM/suHCHZCnWoPeXm7wlkza244Y/5GIDmoSKqAiJV+znuqGr1xn41NcrfPFYlxwW4uYQSyUBGE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ2PR12MB9161.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(10070799003)(1800799024)(23010399003)(376014)(56012099006)(11063799006)(4143699003)(261009223027099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TDFuSTVaeFBXOGpCNURGUVpKMDJ0OHdGenpQVCtFSUx5WUhVbFAzOWJRc3k3?=
 =?utf-8?B?TDV1WnRybWRjd3NwSU1uOHpnazVxK1ErR2ZmWlVWODdmUysxSlU2NXdlN3ZC?=
 =?utf-8?B?TUhPS0VQVUxXYlNtTkRodm1nK2UzMXZQTFAxQTVHbDI5ai9GUW02c3FKZC9E?=
 =?utf-8?B?bTlNakJJUHI3MzZHMTZWc0Q3dEszQ3VoNGVBTkR5TXVnc1VxZkZtbEdFOXo1?=
 =?utf-8?B?dDd1NjZuTU42TDNML2dPZ1d4NkRhVktGaVdhb1BBSElxczFxWW5HVjExV2FY?=
 =?utf-8?B?R1dhZXZtbFdjK3hOa1AxbmVxVWgvM2ZWNjlkN1FhTXFjUGRUQXRNWm9Yblda?=
 =?utf-8?B?bWtMWHJvSktGMHE3aFFaSlNudjYvMzJnWkhIMVorYmxqZTkvYjFsMFZOSHlW?=
 =?utf-8?B?QWtMSnpFSVRiTitnQVoyS0xNenJ1K0haZmpkMzdCREdqVm9wZ3VoQlh1a25H?=
 =?utf-8?B?NFY4aGZVNjBDU3lhYXdSQXpEamZDVm9OTGxmaXlqUlJrS0h5aGovTWZraVI1?=
 =?utf-8?B?amtYVDd1Z2p5b2Y5emhxV2NjWlJQUElMMGlFUlJRN0NKWXdySjl0ZnVsZGo4?=
 =?utf-8?B?dytxLzV2VWpGbFg0cnJpMmFsUU9vbTVmaFVUYXlXaXBxcUlPYjR6aVZFNFlG?=
 =?utf-8?B?U3dvTTV5OUh5cTFRN1VFSE12aHVCRWFhTkIzV2Q3Rkp2Ri9jcDJQbk5Ba2RB?=
 =?utf-8?B?ZzAraXFLVmxoSjBoMkJwUTVtZXpwMVlDcWpsN0lVT3MwWjZxUklMdGswRUN1?=
 =?utf-8?B?WDBhM1lUcnJtbFpZVFV1RURTdXdyMm9Ja1FLNE5hT285YkxqUXU3TUNha1gw?=
 =?utf-8?B?a0I2TkNMcThMczk5WjM4TnFva2MxMkEvZm9VL0ltVEQ3OE00V1pzZjhXQzh1?=
 =?utf-8?B?TmRkbFRRelcxMk5IUFhVMWw1cFh3N2RrcVZIcEZqeTg2eWtHTlZSQ1BLZkh2?=
 =?utf-8?B?SC9LZE9oa084UDc2ZnFpb3poWlVuVWM4d0pwbXRqY1phWGRtTUlwQjdnKzFy?=
 =?utf-8?B?VDZVTnNjUUM4bkZYV1pXeUpBa2FPRFBzTGN3cHN1cjhGQ3krT0sxdk1LRGZG?=
 =?utf-8?B?R3lIWmFvNU9GV3lReHR6RTJ2VEJVSmJKQU9zSXhpd3FjaHQvU3VYaGw4YUEx?=
 =?utf-8?B?bDdWc1F1UWk2ME4xNVFjUGFjZlBzc1hFYXl5OTk1ZmtwNTRMQlVRRlJ0c0s5?=
 =?utf-8?B?UTBCZmhPRlJzNFkyNzZONTlqa1QzazNWQ1pwb1VtdEpPRUQrMUs0dGNrMjg2?=
 =?utf-8?B?Qk9zcFhFK2RjKzBkZEVjdFBad2xDTDg2WHl1MkxtUHRYdENibE9OMGxhSDU2?=
 =?utf-8?B?dnQ3K3k1OXZaUnVUclpjRVR5U1FrSUR4VDRPNEJORGpuMlNYUHIxdENnSUZj?=
 =?utf-8?B?Wkd6VHdnMVFpcHZoMFNSYXNBdEN4b1hoQi9VSzRIZ0hiMDBDbDJUcm1ZbjdE?=
 =?utf-8?B?d0lqakdpbEhUaDJVRWgxYThZeXlrdHR4eXZXVzlMZ0tiTUlNR292Z0NJT25a?=
 =?utf-8?B?dWFXVkJSUjB3STBiQkhJVVQwT0VBUVZQMkxmbVNYanpUZUszWTIrR3lDSTRI?=
 =?utf-8?B?aHYxOFhBU0lvbTVGY25nSng1djZwUjNiNnMyUituQ0RXWVBNRTBlWVJPVnpC?=
 =?utf-8?B?cHFZeGloemJtcWEyU2tRbG5JekE1NTdZNDQvQ1hkS3ZUMnE3Zmo2NGdKT3JD?=
 =?utf-8?B?OFlrdnA2S2Qxc1QvdnBDL3JrM3NYZ1VENjh6VlNKK1R2ZjF2UlBMMlk3WFNr?=
 =?utf-8?B?WDZrTG5UaUlpYkdmdW91RXcvR0VmbG54UWRBblY1bjl1RllJenh6VjVTNEhX?=
 =?utf-8?B?bUhzVVREeGpTWGVNekpkRnpSSm5NeTNiTXJreTZmcTVCbklLOGg2a0RTckZK?=
 =?utf-8?B?SUhpckV2czBlNVVubmxVaHVrZkkrNDZmSHNUTEhOTzdhdDUxUEllN1VSYTIv?=
 =?utf-8?B?eGVGNDNONUM3U3dFWUsrOEJFVVg4TVdmTWhDaEtxNFlKMFpEdU9pUTJDdkEz?=
 =?utf-8?B?MDlwZVgrcGs3eERUMWx6RmduUEtldHNveEE5V05IRmV1bzFrTTMyM2xnK1hZ?=
 =?utf-8?B?cE52bFpwK0diY3AvS1MwbFhZeVI4eUR5cFJJQjF5cElBMGFnVzM2VUNYNStH?=
 =?utf-8?B?ZHpTQzhFcGlHL05wQ3d3RXcvSStoeUlVSm81d3p2T1dGc0tCNlBZYyt1TXJJ?=
 =?utf-8?B?dGVHdTBVOWxYdGt2V2tRWVA5U1NYZUNZUFdOL0tybkVMSWFmYk5hWWdrMXQ0?=
 =?utf-8?B?MFpDdG1hS1J5N1lNRmRSUWY1ODgzM09JYjc2WE5XenZRcjNGNzQxVWZJdjJZ?=
 =?utf-8?B?RHY2dWNwemF1TmlmMG82NzBPKzhJY3RIbCtMaWZHVFZxbnFWVkFhY1VXRjEv?=
 =?utf-8?Q?taLAo3VpUF17moR+6F4YO+HyW8QMg2sCfeaC5gYmDzGgq?=
X-MS-Exchange-AntiSpam-MessageData-1: vmby4WdbPiBb1w==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 991f9a30-c8c3-4fce-6793-08df2e740f87
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB9161.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2026 06:33:32.3812 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UUgo6n2lDMCstojZmwJpvPZnTCBsmXWa7MmGp7DIuPC7JxBorNHAIboej2eCUZchlokemQuDiSmTCRb4wkOHKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB803185
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
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tuesday, October 20, 2026 2:59=E2=80=AFPM Aaron Kling wrote:
> On Tue, Oct 20, 2026 at 12:08=E2=80=AFAM Mikko Perttunen <mperttunen@nvid=
ia.com> wrote:
> >
> > On Monday, October 19, 2026 7:03=E2=80=AFAM Aaron Kling via B4 Relay wr=
ote:
> > > From: Aaron Kling <webgeek1234@gmail.com>
> > >
> > > The Tegra display controller supports some yuv types, but not their
> > > chroma swapped variants. For example, yuv420 is supported but yvu420 =
is
> > > not. This can be efficiently worked around by just passing the hardwa=
re
> > > said chroma planes backwards. Add a flag to the plane state struct an=
d
> > > handling to both tegradc and nvdisplay paths.
> > >
> > > Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> > > ---
> > >  drivers/gpu/drm/tegra/dc.c    |  6 +++++-
> > >  drivers/gpu/drm/tegra/hub.c   | 14 +++++++++-----
> > >  drivers/gpu/drm/tegra/plane.c |  5 ++++-
> > >  drivers/gpu/drm/tegra/plane.h |  3 ++-
> > >  4 files changed, 20 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
> > > index b0bfa946e6979..39c2e920d76a6 100644
> > > --- a/drivers/gpu/drm/tegra/dc.c
> > > +++ b/drivers/gpu/drm/tegra/dc.c
> > > @@ -740,7 +740,8 @@ static int tegra_plane_atomic_check(struct drm_pl=
ane *plane,
> > >
> > >       err =3D tegra_plane_format(new_plane_state->fb->format->format,
> > >                                &plane_state->format,
> > > -                              &plane_state->swap);
> > > +                              &plane_state->swap,
> > > +                              &plane_state->swap_uv);
> > >       if (err < 0)
> > >               return err;
> > >
> > > @@ -872,6 +873,9 @@ static void tegra_plane_atomic_update(struct drm_=
plane *plane,
> > >                       window.stride[i] =3D fb->pitches[i];
> > >       }
> > >
> > > +     if (tegra_plane_state->swap_uv)
> > > +             swap(window.base[1], window.base[2]);
> > > +
> > >       tegra_dc_setup_window(p, &window);
> > >  }
> > >
> > > diff --git a/drivers/gpu/drm/tegra/hub.c b/drivers/gpu/drm/tegra/hub.=
c
> > > index 448f49f3a7d7e..6427155ac4fdf 100644
> > > --- a/drivers/gpu/drm/tegra/hub.c
> > > +++ b/drivers/gpu/drm/tegra/hub.c
> > > @@ -440,7 +440,8 @@ static int tegra_shared_plane_atomic_check(struct=
 drm_plane *plane,
> > >
> > >       err =3D tegra_plane_format(new_plane_state->fb->format->format,
> > >                                &plane_state->format,
> > > -                              &plane_state->swap);
> > > +                              &plane_state->swap,
> > > +                              &plane_state->swap_uv);
> > >       if (err < 0)
> > >               return err;
> > >
> > > @@ -664,24 +665,27 @@ static void tegra_shared_plane_atomic_update(st=
ruct drm_plane *plane,
> > >       tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE);
> > >
> > >       if (yuv && planes > 1) {
> > > -             base =3D tegra_plane_state->iova[1] + fb->offsets[1];
> > > +             uint8_t u =3D tegra_plane_state->swap_uv ? 2 : 1;
> > > +             uint8_t v =3D tegra_plane_state->swap_uv ? 1 : 2;
> > > +
> > > +             base =3D tegra_plane_state->iova[u] + fb->offsets[u];
> > >               base |=3D addr_flag;
> > >
> > >               tegra_plane_writel(p, upper_32_bits(base), DC_WINBUF_ST=
ART_ADDR_HI_U);
> > >               tegra_plane_writel(p, lower_32_bits(base), DC_WINBUF_ST=
ART_ADDR_U);
> > >
> > >               if (planes > 2) {
> > > -                     base =3D tegra_plane_state->iova[2] + fb->offse=
ts[2];
> > > +                     base =3D tegra_plane_state->iova[v] + fb->offse=
ts[v];
> > >                       base |=3D addr_flag;
> > >
> > >                       tegra_plane_writel(p, upper_32_bits(base), DC_W=
INBUF_START_ADDR_HI_V);
> > >                       tegra_plane_writel(p, lower_32_bits(base), DC_W=
INBUF_START_ADDR_V);
> > >               }
> > >
> > > -             value =3D PITCH_U(fb->pitches[1]);
> > > +             value =3D PITCH_U(fb->pitches[u]);
> > >
> > >               if (planes > 2)
> > > -                     value |=3D PITCH_V(fb->pitches[2]);
> > > +                     value |=3D PITCH_V(fb->pitches[v]);
> > >
> > >               tegra_plane_writel(p, value, DC_WIN_PLANAR_STORAGE_UV);
> > >       } else {
> >
> > I noticed DC_WIN_PRECOMP_WGRP_PARAMS has a SWAP_UV bit. This is already
> > defined in dc.h. So we can use that for the hub.c implementation instea=
d
> > of manually swapping.
>=20
> Oh. I figured there had to be something like that in one of the
> generations, but my grep-fu failed me. Even more embarrassing that I
> ended up using the exact same name. I will update and verify this and
> send a new revision.
>=20
> > Otherwise everything looks good to me. We could also enable the swap_uv
> > logic for other UV formats.
>=20
> Eh, other than asking for the entire patch to be rewritten over the
> last two revisions, it looks good. :P And alright, I'll plumb yvu422
> and yvu444 in the new revision as well. However, I don't have test
> cases for those.

These are minor revisions, pretty much cosmetic! :)

If you have access to the libdrm modetest command, you can use it to=20
test -- e.g.

sudo modetest -M tegra -s 78:1920x1080 \
      -P 44@43:896x504+40+288@YU12 \
      -P 48@43:896x504+984+288@YV12

(the ID numbers may differ) to set up a 1920x1080 mode with two overlay=20
planes one with each plane ordering.

BTW, I believe the hardware swap bit also supports packed and semiplanar=20
formats -- you can add those too if you'd like or leave them out and we=20
can add them later if needed.

Mikko

>=20
> Aaron
>=20
> > Cheers
> > Mikko
> >
> > > diff --git a/drivers/gpu/drm/tegra/plane.c b/drivers/gpu/drm/tegra/pl=
ane.c
> > > index 2148b0c59815c..757bc552809fe 100644
> > > --- a/drivers/gpu/drm/tegra/plane.c
> > > +++ b/drivers/gpu/drm/tegra/plane.c
> > > @@ -59,6 +59,7 @@ tegra_plane_atomic_duplicate_state(struct drm_plane=
 *plane)
> > >       copy->tiling =3D state->tiling;
> > >       copy->format =3D state->format;
> > >       copy->swap =3D state->swap;
> > > +     copy->swap_uv =3D state->swap_uv;
> > >       copy->reflect_x =3D state->reflect_x;
> > >       copy->reflect_y =3D state->reflect_y;
> > >       copy->opaque =3D state->opaque;
> > > @@ -319,11 +320,13 @@ int tegra_plane_state_add(struct tegra_plane *p=
lane,
> > >       return 0;
> > >  }
> > >
> > > -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap)
> > > +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swa=
p_uv)
> > >  {
> > >       /* assume no swapping of fetched data */
> > >       if (swap)
> > >               *swap =3D BYTE_SWAP_NOSWAP;
> > > +     if (swap_uv)
> > > +             *swap_uv =3D false;
> > >
> > >       switch (fourcc) {
> > >       case DRM_FORMAT_ARGB4444:
> > > diff --git a/drivers/gpu/drm/tegra/plane.h b/drivers/gpu/drm/tegra/pl=
ane.h
> > > index e33a581e6490e..dba5f1b254e98 100644
> > > --- a/drivers/gpu/drm/tegra/plane.h
> > > +++ b/drivers/gpu/drm/tegra/plane.h
> > > @@ -49,6 +49,7 @@ struct tegra_plane_state {
> > >       struct tegra_bo_tiling tiling;
> > >       u32 format;
> > >       u32 swap;
> > > +     bool swap_uv;
> > >
> > >       bool reflect_x;
> > >       bool reflect_y;
> > > @@ -88,7 +89,7 @@ void tegra_plane_cleanup_fb(struct drm_plane *plane=
,
> > >  int tegra_plane_state_add(struct tegra_plane *plane,
> > >                         struct drm_plane_state *state);
> > >
> > > -int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap);
> > > +int tegra_plane_format(u32 fourcc, u32 *format, u32 *swap, bool *swa=
p_uv);
> > >  bool tegra_plane_format_is_indexed(unsigned int format);
> > >  bool tegra_plane_format_is_yuv(unsigned int format, unsigned int *pl=
anes, unsigned int *bpc);
> > >  int tegra_plane_setup_legacy_state(struct tegra_plane *tegra,
> > >
> > > --
> > > 2.54.0
> > >
> > >
> > >
> >
> >
> >
> >




