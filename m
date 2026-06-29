Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1DCC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:19:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ABB1110E0AB;
	Mon, 29 Jun 2026 13:19:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="h2HmLMNu";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDC7210E0AB
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:19:31 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TCCRorufxwKrnqRahKSsMGHS1/Kn863lmzCtsI1+FDXpC1kAn7K75HzVJyvwuvezWrCGzlyerEkfSfHZm/9gyMzQ1eONwl9EPntE1YXnl/H02kMuxDLrlNQvWWSGXKsLx5hA4N/SFnNsUv8h8QDo++B5dOv6DIA66/ByEI3NJ7u2I2UpCSerPHKzmudmE/mzvx5ZsBiJ+VSseUEPljUH4cOWY44F9/mIoCsDsKdn307WhSRUwDkHqJc/yPsVA1gerBTriWUVCH73qfEM8OIstPyNneX3UQn9LOHlTzWzBaXZyz2Gx2Yy6qUUP3UZdZYdb/ZHorFZMJP/8Gt1MgdTtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hUXwNkSFSkfadOhoGI+2Mn0LzlrRWsp4qoGeOIz1bww=;
 b=wXhKteJWGgjbr0mvCPfvTupJE2k3cnvNBtX9MHlNBzwY0aSt0BGmX5F9bqaswv1CLvNNU7MaGJxCok1/Hr7ABhVUthrOQ78y0Neq04CJjdiyk2gbVyi1/yhrBF4VIKdT3JOSsocMp9HKYCPFV7OyysUHq4PJKOBpkPP7GPpoWdzshNZG5U9vrVlTGoyqbgXnDNSF+zb50gXdzir9T5y7FpFKlFc7bwmllpZkddCUKzuSfd66AkyKCfq0WJdjF57Bon2CLkWCY4eLnFKpCwMh/Z21l3EaLh5goJO/4ne5RJw/TLbAEdCnHAlCYlMcoQoOXE1wa+MQAczgqyWXYVj2tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hUXwNkSFSkfadOhoGI+2Mn0LzlrRWsp4qoGeOIz1bww=;
 b=h2HmLMNuIFLNuI9w8wr8py7AoUHejvo82TcWfiyn3sV3+hp5gjNXN8sNliXGthqUhqXSHR2MTAwD3RD8dx6TpsUq9o0bZ1gNX88w9VtQmqTZwfaSiBI5OsVdU/Hqunnd+vOe9JAz8/tMuti3SRHxmfYfBeuAdDhjurVVvCpPcqe3mQ0W9NcYti8dza2aXU9DShKIQa7orAjQUjfL8wH5rLnP1GxpIs2sN+S77C/jHDmnui0O956lMBL7wZFsKPgQPxl7Lv2BrqJFcyUW9n3UmPzpPBOBypm3OLxrEPB8wRsKAfrMXvEp61Pkq/HcahKafNlpUqIY4JEBKaUKqUFxKw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by SN7PR12MB7787.namprd12.prod.outlook.com (2603:10b6:806:347::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.16; Mon, 29 Jun
 2026 13:19:25 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:19:25 +0000
Date: Mon, 29 Jun 2026 15:19:17 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 neil.armstrong@linaro.org, 
 jesszhan0024@gmail.com, rayyan@ansari.sh, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
Message-ID: <akJwFRLs37rfdDka@orome>
X-NVConfidentiality: public
References: <20260625094509.157581-1-tzimmermann@suse.de>
 <20260625094509.157581-7-tzimmermann@suse.de>
 <akJg5_5UeNJQi8Zn@orome>
 <439dcefd-87dd-46b2-9501-486e136c1b7b@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="tmiyjgbagxzoo6kp"
Content-Disposition: inline
In-Reply-To: <439dcefd-87dd-46b2-9501-486e136c1b7b@suse.de>
X-ClientProxiedBy: VIVP296CA0067.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:35a::6) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|SN7PR12MB7787:EE_
X-MS-Office365-Filtering-Correlation-Id: 100e6338-2828-4fad-3fc8-08ded5e10a0e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|10070799003|376014|7416014|366016|23010399003|1800799024|11063799006|56012099006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8zPcpJtv4sj8eG8Ut6MKmFmnrFMQZwfQpVvC+1vkx5oQpUjGegMwbrobtYIQvbi52yu45UFHhQyC2e4AyXPvysDxHuJY3wdncTs+ZfhVnSad686JJ3HUAcfvu7sw0tltHHudvKQysg8hc5LnZO37v5QAeE6OdSMETHXE2Trm4A4OoRPyejgLWMi8i64/argG/tqgF35B2RdJdHYbwfU5VPxF0GncKaZBvNJVITy8VfGpQtmtwECJvagrD+GKAjGDdpx6tQHcVJmowmwvVmlOjWt89s96RuXkrJHnl00xULEgk5yUQry2yhkPrPdzeY1uAqcdC9pFNyxaf6nB1tDxRIQL1vVeZ3bhj5BTmH9HAz7sx7s5mmwS4panUIzO6KeyCjL22XFfG3h8Bum72CP46+A1rV+xJUu69sOS0L2mKI2rgeFffrSzUknua5zJE7qcUl7QLZQ+QpvNzzlIy3pOAS/ZM1DqDMKM5a8kmDI/4wY9kq13e1XqNqw0GbG7eRuFL/TCTFGOYqFzp3L4PSQ+gWnFMRkpmghs/g++sIu4xRSdaep9yBS2MlDKTgEGW5CAUDwt+bt/4y64Y4+B4TUL/PLqI2fDxzD6c/k344sKDvxU+RiHUUzzQDG7YI3BOPa75rjsc2B0NqSre9ZYszLFwu8ixsTilUimGL/Z37nw1Ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(10070799003)(376014)(7416014)(366016)(23010399003)(1800799024)(11063799006)(56012099006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ci9KT29WSnpPQkR0MEZRVGdZNjU4ek82dElRNmdIaVRZTnJzNDJub0VGQjJh?=
 =?utf-8?B?NFFYSE02R3VXcmhhTHE0aU1uS3BKMk1XUVRhdUVXTlJFUFZlZnl2MUhQQ0ps?=
 =?utf-8?B?eTJmamRrQWhLSDdsMzlMQndNaTBMaTJ5VnBJT1JmNFNYRWpUWjRMRjBEZmdM?=
 =?utf-8?B?c0EvZmZKQ0hodFhNTXNxK0RZdHR1UjRpNzB3QkJzL0xyVVZRUkFIUFlRRTli?=
 =?utf-8?B?OVRsQk9DYmZQd2ZuME41UUZsY0N1MDRMNkpsYWRDcnE0Z3plN0pWTElRQjNS?=
 =?utf-8?B?VXZySzd1eG5qcmVkSkNaSk1ITFRHTkFUS0hCQWI1a1g0MVFsak9zK2YyQXdV?=
 =?utf-8?B?bHFRcjdzSFo4MjhKUFNZcVVERDlsTEx5ejJjaC9ubnorWGlWM1N3Q1FGUFgz?=
 =?utf-8?B?TnZPTzVERkxyeDNpQkhDd2VuYmZuSjN3bmZWRWJYZjlnZFp6Rk5BR00wNnJF?=
 =?utf-8?B?ZWFHVDZrRGhPZmRZczRWVTErVEV1YWZHQ00xYW0vN3RVVXBodmZmb2d2LzNF?=
 =?utf-8?B?SWVFeFd0ZFJ6aVZJdDBkY0ZURHoyc01NSGNvdjc5SkkyR2RkaEcyL0Z2L0Ev?=
 =?utf-8?B?TkxGZjZjdWFFbGdzN3lGNVhudWtRd0ZxdzNXMUkyV29CdmthRnNST0JONk9D?=
 =?utf-8?B?Q25sNUQ5eGtVcjQ0aHRSSk40c0gvNFBRaDdyYVRnTnZUblBzU2Q2RlhBNnhE?=
 =?utf-8?B?WWMyUmh4cHBWZitRMGh4MUtzcHpQM25QYi9HZ0R4dDltbzZ6T1JncVBRT2Nv?=
 =?utf-8?B?L3dMZmNqRkp6d0hRa0grOEhBdjRjM1YxSlZEMVI5b3AxOXFDREZnNldkSFFw?=
 =?utf-8?B?d0NzVGlzb0ZxalVNR1VUOGF3ZVVaR1Q0UHpIN0pFdCtydXA3Sm9jWkNYVmxD?=
 =?utf-8?B?S1Z6MHBFMmJ1YTVrTisydUlRM21IeG5LT283TU84VW0wQmFLdlJRQTRvN25k?=
 =?utf-8?B?ZVpicEdVeWt1ZlVEeGovRmhSMmdyN2k1YjJWTkdoenUyRWp1NEVycTdPVnlL?=
 =?utf-8?B?SnJqeHlaT1ZMbTMvajFreFYvRjA4R1lVUWprVWRwNkd1VDgvWEt3cVp2ZVRI?=
 =?utf-8?B?bWFDSmExZkVkOUNYV2JuOWlzeGNKMzdCT003QXBpQTVRSmdWeEV5Y3pock9p?=
 =?utf-8?B?MllGWmlFWkRQMFJIQmRqU3NSQmdSTUR0SnNaeGkrWVUzR0VTTXFRVndHOWgr?=
 =?utf-8?B?Qk45QVNReTVKcTdGbVVHdFRsNzJMSzZwN0VvQXlxUjlSZGRpazJsVmVod2Zo?=
 =?utf-8?B?bzA0eHhhQ0pkeDkvNjlRSmxNRHhmS3JIWGpkOXFXa090ak5uNXdESVlwUFNJ?=
 =?utf-8?B?dFNMUktBekU4aFpMOG9nRDRBYlZWSWxJRkFkdndJb2Z3NjBWc3hjODJkeFdy?=
 =?utf-8?B?YmMyd2VORTFwQWZGaU9yeGQ4NXROeldqSkxrTFp6eTBveDhrM0dSNlUvME5O?=
 =?utf-8?B?QURIYjdXMWp4SnlmTDZzeHcxb3h0bE1qcHlYVkppUnovc0xOTmh0T2FnT3VD?=
 =?utf-8?B?YkFVVUgxMi9JQ0NTN3pMbzUyVUltVlJxbXZ1TjBodFVySWNLYUxqNmVoVGdr?=
 =?utf-8?B?Nlh5a01zMjZMOWNKVnNNNS9LWVlhZkJMaWtJWWNEcmFhYzBqcU91Ky9VYVkr?=
 =?utf-8?B?SzUzaGRRMHlWb3VVR1BldyttdHNVenBkdldmNFMwRW5WTEZxK0U5MDVpUmx2?=
 =?utf-8?B?cmR5bVpGYVBySGVndzVyYi9kOVV4NDI5UXBiNFlwVyt0Y2pxN1NnaTR2NFdL?=
 =?utf-8?B?Q2JFMXNZRng2cWdsTDBEaUJBR3krRVBha2hQODQ1WUxVdDIyMnVNbTlEZGhI?=
 =?utf-8?B?a2FZSUdqM0RkTnlQaTEySlNGbkc4aFBFMDJIWlVKZFlwYndYdEJGejFEMXAw?=
 =?utf-8?B?bUNiZUxiV3R6YW9yVGpFSEc1dnJZTERya2FSM3puRnYxWDhwRk55d2EyMnJM?=
 =?utf-8?B?WlBKV2dqTnRRa3ZWNWJlNW5kaklZckRYUFVXUDF4dWxUWm54aXcxRERxNDJT?=
 =?utf-8?B?ZlZXZ21uZklsVlZpZVhWaEwxSW5haUs1MklDNk92dGJkRGxwWEJqemNUZGtP?=
 =?utf-8?B?UUx1blhZa3A5c2JrYmZOUlZwQ2w1V1ppMU1oMDZTWWVCNjF5dnhDeDQ4RHZM?=
 =?utf-8?B?OXM4anRaVHBkcUUwNktjUXRxSVlFR25YV240eW9JVXJzeEhRdVZtWHFBQytk?=
 =?utf-8?B?djJndE8ybTRSSjNDR3gyVjlXcGM1OW5tb0FZQU10UmxpWEJ3SE54QkZYM3d5?=
 =?utf-8?B?QitlQ3BjV1BnUkNSa1NScVlzcFNvWGNEV1c3Rll1aCtxbWJEanpTWno2SVFO?=
 =?utf-8?B?TWcyTU1qeE5yTmdEaElDRVdwM3hNeE1GUnhzdHVjdnFId2RzZldmanNheEJY?=
 =?utf-8?Q?aFdN1Gk//1ZGkZpVrf5HOwqa0MmQjia4lkDfEpBTk68Cg?=
X-MS-Exchange-AntiSpam-MessageData-1: +FSFe+zuAB8nfQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 100e6338-2828-4fad-3fc8-08ded5e10a0e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:19:24.9130 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qP14Rh1flPL8HwTen1hJLxOdqppfk64utm4seG1noTpB8TlQ6zFmxfVjCkY/VihmErqbOkqDeAdGo+52TfnGIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7787
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

--tmiyjgbagxzoo6kp
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
MIME-Version: 1.0

On Mon, Jun 29, 2026 at 02:44:57PM +0200, Thomas Zimmermann wrote:
> Hi
>=20
> Am 29.06.26 um 14:27 schrieb Thierry Reding:
> > On Thu, Jun 25, 2026 at 11:39:38AM +0200, Thomas Zimmermann wrote:
> > > Implement drm_of_get_panel_orientation() to retrieve a panel's
> > > rotation property as enum drm_panel_orientation. The code has
> > > been taken from of_drm_get_panel_orientation(), so convert that
> > > helper over. Callers of the old helper can be converted as well.
> > >=20
> > > Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
> > > ---
> > >   drivers/gpu/drm/drm_of.c    | 44 ++++++++++++++++++++++++++++++++++=
+++
> > >   drivers/gpu/drm/drm_panel.c | 26 ++--------------------
> > >   include/drm/drm_of.h        | 11 ++++++++++
> > >   3 files changed, 57 insertions(+), 24 deletions(-)
> > So you're effectively renaming of_drm_get_panel_orientation() to
> > drm_of_get_panel_orientation(), while moving it to drm_of.c,  and then
> > you keep of_drm_get_panel_orientation() as an alias.
> >=20
> > I don't understand the use of this. Maybe if we really need to move this
> > out of drm_panel.c to make it more widely available, fine. Maybe we also
> > want the drm_of_ prefix instead of of_drm_, also fine, I suppose. But in
> > that case we should just go ahead and update all callers of the old
> > helper and get rid of it while we're at it. No use in keeping around
> > aliases/duplicates.
>=20
> I'm all for it. i though this would be a different issue.

Yeah, understandably. Can't always do everything within one series. In
this case it seems fairly simple to do and we're early in the release
cycle, so there shouldn't be too much in terms of conflicts or new users
yet, so seems like an opportune time.

> >=20
> > I've attached a patch to do just that. Feel free to integrate it into
> > the series, or we can apply after your series is merged.
>=20
> Thanks.
>=20
> Let me split of the=C2=A0 first 5 patches in series and merge them. They =
are the
> fixes and hardening patches and seem ready to be merged. I'll prepare a
> separate series for the panel orientation with your changes and it can go=
 in
> separately. If we touch all the panel drivers, we should make sure that t=
he
> panel maintainers get another chance of looking over it.

I think I'll need to send a new version which explicitly includes
drm_of.h for all the panels that use the new function. My build tests
were missing some drivers and others include the file implicitly via
some other headers.

Not sure if maintainers really need to look at these since it's
literally just switching out the of_drm prefix for drm_of, but yeah,
can't hurt to send out a series for review.

Thierry

--tmiyjgbagxzoo6kp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpCcNIACgkQ3SOs138+
s6G9rg//Yiu3iPXqR4iYYcSXS9kqneo4A5tXOwsDKcX0a7S3HXdm2kJnvQwIZHkJ
pCR/ffL6QbGu17X9+HCKb23Tl67nOmyyAQfs/6FmgGLYvmR1UcookhCrM2K7n4Bl
ykjfv95IN/3q8Zkist4Xsf72eoCmzf8ryAGHGatGU3z2A98EWEFgRo8ua2BbZMFW
SUcTWJ/5eF5Gikhh/x/5F7MdoGbXXDY41hkUJc2jm6RTe7aQH7Vf1zNSogR5I4ks
zOKO6s95DWsC5GvLYPffvo9OQy7fKrUZrAfIp/eBTccZR9nEugiWsnqjjXqQKL7N
mS5iBUv+A8C06Kp8gnXhDEOpCgILKHM2ekY427GX8Xr3Q3yRunnf7ZHRxjTQUUmm
hBjZ8XiibDH1UTo3hxks+p4qE8iBzK55oLJivtcJ05PQHPMord6wNINAPupOtPue
U84+dzHzOINJuTvejrnse5wZYuCe5kafCjIphAUxO8p7IEWfJbDjYxXMeFqxEij+
GLpv8gYvutwq8aSPqbdqvyJ5p7pSzjwVWfv7AdsM27T8qajXhfwm5PbUPkY2ad0v
wVJoqrH6wKVYHGImSbOnv3yxmKzvmraLT+ur0XSmKwaPjJWCGCiviGAoF5yC1efV
b/CiS7ySGTuc3mKX/sgb3HzvGNPwxEV4F2eXijEGm6Z76ngmerk=
=AtFa
-----END PGP SIGNATURE-----

--tmiyjgbagxzoo6kp--
