Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E445FC43458
	for <dri-devel@archiver.kernel.org>; Mon, 29 Jun 2026 13:30:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3784410E8B7;
	Mon, 29 Jun 2026 13:30:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.b="Ci0b3MAL";
	dkim-atps=neutral
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010008.outbound.protection.outlook.com [52.101.56.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DED010E8B0
 for <dri-devel@lists.freedesktop.org>; Mon, 29 Jun 2026 13:30:00 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sy94m9ox+HtqGwj9fiXzwcP3w1wcorB1zl2euu/l3/vlnZ0KAXeRAJBDHnmifSzTJafAy605cNhCNy5ho5fuQ+rSL9+DNbXwMifmoyqQDDJTbJvulGm1QInba1Eq7lMVwp9mjkAOqqF6TS2m6dw5yojnMdHDgYv5K1Mpw6GYOgri1VCpwMVGeJF4e490pUQC3gAiP8ZmynJ2X3A24Uy8kHZ8XsYe1A8mPOVo4aMJ9XVzD74bO/JbX/opRUYoNlqCP+cKP/INOunsYOftqt/nHcQNYRE2CthgynNOLQrT4X35g7NC1rEKan8QmTxZ6BXsiasWrxirX2gzMOYNNiP6Mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHLv91GeQtLEOKjGLUFADwlxm11L5onapilZI5dC9vw=;
 b=loDF+Z3KdkiQWP53+JoiOwhn6IPS2ejlLU5k73EiLmudxcWMXaMWQUysbgRPIOB64QpqTRpR6YE4z///8Xi+uT6sBSJ5ZH2V58Tv49D3LwLOpmZR/pTesOHu2hpvkvIGlKLQR4TAaMHVVW8/SnwWxTO2y6MWJDJm2Pa5b2jAw7T94ItqK/+IImroGecBjg2JoU+YAV3DrxGpKYMjjYnNAFvhN3+ms6Cj2RbX5Ey2NMfHQMzqMcEKC85Ebl75qpMVWyQZlNEjE4q53GRFFdFXzLJHv4nXLwDeSBie7Kh4ImI74BzuPWD4/qidNrvisqc/j3A0iCyYOTAqckljDPjhUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHLv91GeQtLEOKjGLUFADwlxm11L5onapilZI5dC9vw=;
 b=Ci0b3MAL7eylT5ZSxOU4M/Z4ydkzlX3klayECoNpOvBIfnmWSXSuB0/gWR059fX0ctWo3WRRO1dljZVRKVWBmJfILglC9SWvcLVaQaWP5sDUmfHg9/6VZHMJxV4UQ8vdg8TEVltZ0pA3s79Wb/qwAaejGeQFOz8cpqFRCP7EnxWuCSf6H1lI5zGJnu7SHvGYcyXizCso+/ejMyIzDFh9n6Pg3bVH899swKIaadjMANW5hzmLlyhBR9Xs57P7iCzgTSTVl75GYAiOOJrgcTkx5iKNsDIPt3II3nhGyZpUu1yxOOhU/4rtnwjpATsICjwcoGfXlA6Ka3pxzd6bJpchSQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH0PR12MB8488.namprd12.prod.outlook.com (2603:10b6:610:18d::18)
 by SA1PR12MB8721.namprd12.prod.outlook.com (2603:10b6:806:38d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 13:29:50 +0000
Received: from CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315]) by CH0PR12MB8488.namprd12.prod.outlook.com
 ([fe80::c565:c0e5:2c8b:c315%5]) with mapi id 15.21.0159.018; Mon, 29 Jun 2026
 13:29:50 +0000
Date: Mon, 29 Jun 2026 15:29:44 +0200
From: Thierry Reding <treding@nvidia.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
Cc: javierm@redhat.com, maarten.lankhorst@linux.intel.com, 
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch,
 neil.armstrong@linaro.org, 
 jesszhan0024@gmail.com, rayyan@ansari.sh, dri-devel@lists.freedesktop.org, 
 sashiko-reviews@lists.linux.dev
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
Message-ID: <akJy4h5QTF6S1AwB@orome>
X-NVConfidentiality: public
References: <20260625094509.157581-1-tzimmermann@suse.de>
 <20260625094509.157581-7-tzimmermann@suse.de>
 <akJg5_5UeNJQi8Zn@orome>
 <439dcefd-87dd-46b2-9501-486e136c1b7b@suse.de>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="gzp3hunpx3jx5f4p"
Content-Disposition: inline
In-Reply-To: <439dcefd-87dd-46b2-9501-486e136c1b7b@suse.de>
X-ClientProxiedBy: VE1PR03CA0042.eurprd03.prod.outlook.com
 (2603:10a6:803:118::31) To CH0PR12MB8488.namprd12.prod.outlook.com
 (2603:10b6:610:18d::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR12MB8488:EE_|SA1PR12MB8721:EE_
X-MS-Office365-Filtering-Correlation-Id: 51242aca-5bd1-4935-fd52-08ded5e27f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|366016|23010399003|6049299003|10070799003|1800799024|4013099003|4053099003|6133799003|4143699003|3023799007|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: QzIbssZJhmhmbW4HJgEUfufWdkWUyjUEiJasMRbPlJpPvPb2kTJVaP4LFgg1O8Os3LjbKQ/vIhgeCwH2J8IQRNgBkBrczjHTghT7eRtvCIz8sB7f6T0MRyWS9MGcqQDP/INrdkoImJH3FbxelTqVY3WseBBTHeK6shVdh98uP/PvxQ7QVQYqYBhGncIJQ3MP7lQFebMORMjiUNNoJ3nXejcaEDX1ae4lj0meKNF86HthxcQDueZuq2oeFumrbzPU8Vmui88Mbt2P0oYUrZ/A2W1lSH3xpOW9eFA/3wcVxwTlqTqIhgfVY8ynB9FjAA9ehKFQ/Qe3fXjsZrdruILKDJia2uDhFeh1rismq5A8GWVISlgVAfiNk9VInQIWg9JNKte8cU5GFF+/aTYLazogvx6AfaYYba1hp7cPkm+12m8r8OYOCGBpprLzuur9a2g5NtHAHAjkqJ+SZsca5XOcgbEV3euiuhsl+pmzR/GVOyIoRhm+c0JdiqUQcbquAbL4dgzFm0J84KCTPmeGK3P1+TE53LSmcVaYvzDGSfJoEcgHFSOJ8H7i4TyGOpyl6SIqOw+hDIsJJC+ilCTN60af74IyWt/CPsYrGct86kHxKP4+7I6O7uPf1Rl0b7j8iFm7NezBH4fI0oWBuRSmBWX35YAKJkaJmYPEiHHOjOgShQ4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR12MB8488.namprd12.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(366016)(23010399003)(6049299003)(10070799003)(1800799024)(4013099003)(4053099003)(6133799003)(4143699003)(3023799007)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MVdUUDlVQk15dlErK1BYYTh4dEEzNHdWeHRmRXVEMTE1T2pqVmhoUUZCTFkv?=
 =?utf-8?B?b2JjcndDS3N2aFhOSnhCVDhlUEVFQXlJVVkyN0ZLejFydmhmNTNhejlCblVm?=
 =?utf-8?B?ZkR6QS9JVUptVTdCWXFvekxBNjllcnV0K0o5YzMxb2tmRVVqV2huaXRIZWht?=
 =?utf-8?B?eFJyaG9XR1o1VElzYjFSSzRISzMvZzJuUjAyV3BETGhhY2ZWN0tGWWpOM01V?=
 =?utf-8?B?bG5lWElPY1MwUnFQWW95WHN2NXdGK0p3YjNaejlySjlFNjhvc2tDWFlZMXBr?=
 =?utf-8?B?b2d4NlRmNFMzd1BpdmdDZGEyMkxEOFRoalRlOXU5SStXbkd2Rzg0SFArUFhN?=
 =?utf-8?B?WGZ5eHU0ZmFSVHllT042UDR5Zjc0OU1iUFVScGdrVXNaWkxBOXVzSGV0VTRr?=
 =?utf-8?B?eUkweGhPb0hjVFk0cTBjejdtWldwTy93UkIvUERQTVkrZnI3bVA2SlVYeFlk?=
 =?utf-8?B?R1dpZXdST2wrRXBVOE10NDJ5OGVvKzJiRUVhVUtzcWxyL3NHSnNWYXZreG5V?=
 =?utf-8?B?RGxBUk5yZ1VvdUJwKzdMcDc3QkxENWtoUlF0RkZkWGs2NEtrQXBFQjVZN0FF?=
 =?utf-8?B?VjRCeDNzNXl3OHRJeG4wQzR5TFNSL2lxdXFtWFQyNzRTaVFKN0dDMS9IVDRW?=
 =?utf-8?B?K3NvbkF5RWFESWM4Vktkckl6OFVEQklFeXlYL2tKS2Y5V1J1elF3Z0lFZ0Yw?=
 =?utf-8?B?OG5VaFZUVkpMVWNIZFJuaUZET3BoaGdER2lnbzZvN0kxZTRvODRoc3lYQ0NN?=
 =?utf-8?B?TDJsanh2ZU1FbWFzVHFrNHFvd01jSWhNYTNXRUpPSlBYdFpQZVpBSzQwZHFj?=
 =?utf-8?B?aUVoWFo5T05qb2FDUXRjdWpOV09FSzg0aEIvbElGNUVDZmkyam5HQUp2Si9Q?=
 =?utf-8?B?ck5SQWdTREJOcE5VbEI4YUJGRm9uaHhzeGpxelRkQXNTc2JiVnR4b3FpTnh5?=
 =?utf-8?B?ZUkxQXpiQWpUeWJYcGpobjBtT3c3b2VMamsvc0FTWUJLWGpsakVHb1VxZ2Mw?=
 =?utf-8?B?OXNTekN5OGhYQ0JZWUFPaE50WnNMV0JYeko2bDNNdDlnTEdaYnVnS1lxcWdt?=
 =?utf-8?B?VDBEalJMVlFvMWkyMTRybE85NGVYa1hFSDFhYlVrbVpvb0t5MkYvelJ3Z3JY?=
 =?utf-8?B?Q0YzcUV3YkdXYk1rMHhES2x6cEVrdExVS1VhbmpTdVE5dExUa1BOOG9aUUM1?=
 =?utf-8?B?Y3ZnTkhMVGZMMDVOdFBFTzZpRG96SWRkZjN2R01RNUNzNXNaajB4S21nMitJ?=
 =?utf-8?B?RkNLOFZLRkNPZmFGSnZDUjVtSVZ6WDYvOVRxdG5UQjZRNGJjdk9hY1pXR0Jj?=
 =?utf-8?B?Tm1udmtKM3JiTmIxY0tiY2hNK1NsQlJvcjh4T0RBQlRLdkgveXNhZzRUWXdZ?=
 =?utf-8?B?TkhKbnl3MmwrWC9mSjhMcGNzeXRkSHVweDhxdGUvQ1o4Znd1RjFhMEQxQWk1?=
 =?utf-8?B?V2VTdVk0eWtvb0VxTWtwZkRxeXczOWkzaVpmTGpya3dhTnVQTG9LbkpLbmNx?=
 =?utf-8?B?MVQwMnRkbWszT3ptZEJYWGgvbFMxZTJCZ3ltY2FFay95eE0yNnJkNjlRSnQ2?=
 =?utf-8?B?VmV5dnlXK1B5VDdGT1lRc0pSd3RwNThaOVdnUGJDVmVFUzZtdE1NTUNWZ3Zu?=
 =?utf-8?B?TUYvQ2cwMVFiU3lSQ0k1RFZQbUl6NS9OS1VHQlNFSXFaR29ib1NXR280ZUhX?=
 =?utf-8?B?L2JWVndoSlpaNHVML3hZUHE2MnpZb1Y4cTlxZDZSMGdKMUNBNUJRQUo5Smgr?=
 =?utf-8?B?SGRUeUIyRmFIQTJyMndWTDNLeFB4cmlacWpxR25VS3ZCZ2wwUGNmMmtXM1ZC?=
 =?utf-8?B?L3Z6blkycDZFNUlEUzMrRnc0dzhqc2gxelVMRnIvVk8zaDhRejdxUnJ3c24z?=
 =?utf-8?B?TE1OUmRldmsrWDR3TXB2d2k4Z0FYbGxRdmVEbDVLbGpJQTNKNU1jUEtPZXhO?=
 =?utf-8?B?a3JKTFJ6QmN1K202bU1nRGpzRWRzRW80R1Bzb0dKZ0Y4ZG51L0p2clhXSnNQ?=
 =?utf-8?B?MGpSUUV0ZzlscGU5dVExVDVyV3J6WGRpN0d0Z1B0MU9RQm83Wm9oTWVXVHFv?=
 =?utf-8?B?TW9DSlc3Y3lQZEtuaGRFVnRydEZTNlNKU2lPZitQWVg2SGxsYUlEZzFIcDFG?=
 =?utf-8?B?NFJQQ2dSWXFiK3h5eUhNbThyNVVYMytkcDhaVSticW1rSnpLOUlkL1l5ZTBX?=
 =?utf-8?B?Mi9aSVU3LzNUa1p1VGVkQk5EaVpHclZ1Um1BNzVrRGNwRjFDdm9MOG92dzFI?=
 =?utf-8?B?Vng1MndLK0lsWmNlS3h1STNscFJoL0djTWJ6VFdFUDh6bkszYVZyTTBHNEhD?=
 =?utf-8?B?WSsrUy9pQ0VpQ1dhN2x2eW05UEpYVER5bld1L3Qva09JLzZMU09EM2NySlVp?=
 =?utf-8?Q?kXDrbSmufFlp0Edvhk0qaiYL4NSu5WleHrKea0gL1+Jn8?=
X-MS-Exchange-AntiSpam-MessageData-1: jv20ys81ZmRYig==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 51242aca-5bd1-4935-fd52-08ded5e27f04
X-MS-Exchange-CrossTenant-AuthSource: CH0PR12MB8488.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 13:29:50.6141 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nxjtWWGZ3lWmRuOcMHHrehFOEcxys8g30vn7wUzi9I2NYuTaGiUCsChRedDCR4XtkKGyNoZm85IH/0+adirOMA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8721
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

--gzp3hunpx3jx5f4p
Content-Type: multipart/mixed; protected-headers=v1;
	boundary="5zi5gr5vww6wvxqy"
Content-Disposition: inline
Subject: Re: [PATCH v3 6/7] drm/of: Implement drm_of_get_panel_orientation()
MIME-Version: 1.0


--5zi5gr5vww6wvxqy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

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
>=20
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

Here's the updated patch with all the modified drivers build-tested and
checked that the build covers all of them.

Thierry

--5zi5gr5vww6wvxqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom 31901850ebf521afc0b24bc90e97dd4af660df9b Mon Sep 17 00:00:00 2001
=46rom: Thierry Reding <treding@nvidia.com>
Date: Mon, 29 Jun 2026 14:23:27 +0200
Subject: [PATCH v2] drm/panel: Use drm_of_get_panel_orientation()

The old of_drm_get_panel_orientation() function was replaced by the
drm_of_get_panel_orientation() in the core DRM OF helpers. Replace all
uses of the old helper and remove it.

Changes in v2:
- include drm_of.h in all drivers to make sure the new symbol is defined

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/drm_panel.c                   | 20 -------------------
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  |  3 ++-
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  3 ++-
 .../gpu/drm/panel/panel-chipwealth-ch13726a.c |  3 ++-
 drivers/gpu/drm/panel/panel-edp.c             |  3 ++-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  |  3 ++-
 .../gpu/drm/panel/panel-focaltech-ota7290b.c  |  3 ++-
 drivers/gpu/drm/panel/panel-himax-hx83102.c   |  3 ++-
 drivers/gpu/drm/panel/panel-himax-hx8394.c    |  3 ++-
 .../gpu/drm/panel/panel-ilitek-ili9806e-dsi.c |  3 ++-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  3 ++-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  3 ++-
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  |  2 +-
 drivers/gpu/drm/panel/panel-lvds.c            |  2 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c |  3 ++-
 drivers/gpu/drm/panel/panel-simple.c          |  2 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c |  3 ++-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c |  3 ++-
 .../gpu/drm/panel/panel-sitronix-st7789v.c    |  3 ++-
 include/drm/drm_panel.h                       |  8 --------
 20 files changed, 33 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index eddd13a34c03..d7c6f4824b2d 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -492,26 +492,6 @@ struct drm_panel *of_drm_find_panel(const struct devic=
e_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 EXPORT_SYMBOL(of_drm_find_panel);
-
-/**
- * of_drm_get_panel_orientation - look up the orientation of the panel thr=
ough
- * the "rotation" binding from a device tree node
- * @np: device tree node of the panel
- * @orientation: orientation enum to be filled in
- *
- * Looks up the rotation of a panel in the device tree. The orientation of=
 the
- * panel is expressed as a property name "rotation" in the device tree. The
- * rotation in the device tree is counter clockwise.
- *
- * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or t=
he
- * rotation property doesn't exist. Return a negative error code on failur=
e.
- */
-int of_drm_get_panel_orientation(const struct device_node *np,
-				 enum drm_panel_orientation *orientation)
-{
-	return drm_of_get_panel_orientation(np, orientation);
-}
-EXPORT_SYMBOL(of_drm_get_panel_orientation);
 #endif
=20
 /* Find panel by fwnode. This should be identical to of_drm_find_panel(). =
*/
diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers=
/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 01b4458e55ad..a70a2e58f88c 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -15,6 +15,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
=20
@@ -380,7 +381,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi=
_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Failed to get reset GPIO\n");
=20
-	ret =3D of_drm_get_panel_orientation(dsi->dev.of_node,
+	ret =3D drm_of_get_panel_orientation(dsi->dev.of_node,
 					   &ctx->orientation);
 	if (ret)
 		return dev_err_probe(&dsi->dev, ret,
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/d=
rm/panel/panel-boe-tv101wum-nl6.c
index 658ce64c71eb..150dff3ab6c3 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -13,6 +13,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #include <video/mipi_display.h>
@@ -1722,7 +1723,7 @@ static int boe_panel_add(struct boe_panel *boe)
=20
 	boe->base.prepare_prev_first =3D true;
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &boe->orientation);
 	if (err < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gp=
u/drm/panel/panel-chipwealth-ch13726a.c
index be76bc825c3f..562dc573528d 100644
--- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
+++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
@@ -13,6 +13,7 @@
=20
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #include <video/mipi_display.h>
@@ -268,7 +269,7 @@ static int ch13726a_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset-gpios\n");
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/pane=
l-edp.c
index aa27d6cd932e..3d3865329ece 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -40,6 +40,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 /**
@@ -865,7 +866,7 @@ static int panel_edp_probe(struct device *dev, const st=
ruct panel_desc *desc,
 		return dev_err_probe(dev, PTR_ERR(panel->enable_gpio),
 				     "failed to request GPIO\n");
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
 	if (err) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm=
/panel/panel-elida-kd35t133.c
index 1f177834d629..d23002b5a2d7 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -21,6 +21,7 @@
=20
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 /* Manufacturer specific Commands send via DSI */
@@ -233,7 +234,7 @@ static int kd35t133_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu=
/drm/panel/panel-focaltech-ota7290b.c
index ed02a8daf96f..bbc870b8fda8 100644
--- a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
+++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
@@ -17,6 +17,7 @@
=20
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
=20
@@ -181,7 +182,7 @@ static int ota7290b_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->vdd),
 					"Couldn't get our VDD supply\n");
=20
-	ret =3D of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret) {
 		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
 			dsi->dev.of_node, ret);
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/=
panel/panel-himax-hx83102.c
index d7e5664a5838..6a0851ccf9bb 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -17,6 +17,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #include <video/mipi_display.h>
@@ -1264,7 +1265,7 @@ static int hx83102_panel_add(struct hx83102 *ctx)
=20
 	ctx->base.prepare_prev_first =3D true;
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (err < 0)
 		return dev_err_probe(dev, err, "failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/p=
anel/panel-himax-hx8394.c
index bf80354567df..b57ccce38cf8 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -22,6 +22,7 @@
=20
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #define DRV_NAME "panel-himax-hx8394"
@@ -992,7 +993,7 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset gpio\n");
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gp=
u/drm/panel/panel-ilitek-ili9806e-dsi.c
index ecdbed8d4a3a..47b79fac1562 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -10,6 +10,7 @@
=20
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
=20
@@ -132,7 +133,7 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *d=
si)
 	dsi->format =3D ctx->desc->format;
 	dsi->lanes =3D ctx->desc->lanes;
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/dr=
m/panel/panel-ilitek-ili9881c.c
index 0652cdb57d11..3abdd0870e83 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -16,6 +16,7 @@
=20
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #include <video/mipi_display.h>
@@ -2571,7 +2572,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device =
*dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Couldn't get our reset GPIO\n");
=20
-	ret =3D of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret) {
 		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
 			dsi->dev.of_node, ret);
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/dr=
m/panel/panel-ilitek-ili9882t.c
index 5f4e0d82ee67..6d07fe901357 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -13,6 +13,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #include <video/mipi_display.h>
@@ -795,7 +796,7 @@ static int ili9882t_add(struct ili9882t *ili)
=20
 	gpiod_set_value_cansleep(ili->enable_gpio, 0);
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &ili->orientation);
 	if (err < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu=
/drm/panel/panel-jadard-jd9365da-h3.c
index f6b04de1182e..67ef9e0fea03 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -2992,7 +2992,7 @@ static int jadard_dsi_probe(struct mipi_dsi_device *d=
si)
 		return dev_err_probe(&dsi->dev, PTR_ERR(jadard->vccio),
 				"failed to get vccio regulator\n");
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &jadard->orientation);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/pan=
el-lvds.c
index 46b07f38559f..37f7498449ec 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -126,7 +126,7 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	struct device_node *np =3D lvds->dev->of_node;
 	int ret;
=20
-	ret =3D of_drm_get_panel_orientation(np, &lvds->orientation);
+	ret =3D drm_of_get_panel_orientation(np, &lvds->orientation);
 	if (ret < 0) {
 		dev_err(lvds->dev, "%pOF: failed to get orientation %d\n", np, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/dr=
m/panel/panel-novatek-nt36523.c
index 226d91daf8c7..34b9123d3fd7 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -19,6 +19,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #define DSI_NUM_MIN 1
@@ -1206,7 +1207,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 	pinfo->dsi[0] =3D dsi;
 	mipi_dsi_set_drvdata(dsi, pinfo);
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &pinfo->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &pinfo->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/p=
anel-simple.c
index c09bf3db5e78..5c169fdf265c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -693,7 +693,7 @@ static struct panel_simple *panel_simple_probe(struct d=
evice *dev)
 		return dev_err_cast_probe(dev, panel->enable_gpio,
 					  "failed to request GPIO\n");
=20
-	err =3D of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	err =3D drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
 	if (err) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return ERR_PTR(err);
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/dr=
m/panel/panel-sitronix-st7701.c
index 2f79ec4a2063..f16e0de1ea60 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -7,6 +7,7 @@
 #include <drm/drm_mipi_dbi.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #include <linux/bitfield.h>
@@ -1296,7 +1297,7 @@ static int st7701_probe(struct device *dev, int conne=
ctor_type)
 		return PTR_ERR(st7701->reset);
 	}
=20
-	ret =3D of_drm_get_panel_orientation(dev->of_node, &st7701->orientation);
+	ret =3D drm_of_get_panel_orientation(dev->of_node, &st7701->orientation);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/dr=
m/panel/panel-sitronix-st7703.c
index 6c348fe28955..9916036630b7 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -21,6 +21,7 @@
=20
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #define DRV_NAME "panel-sitronix-st7703"
@@ -874,7 +875,7 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
 				     "Failed to request iovcc regulator\n");
=20
-	ret =3D of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret < 0)
 		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
=20
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/d=
rm/panel/panel-sitronix-st7789v.c
index d5f821d6b23c..da6ed31d151e 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -14,6 +14,7 @@
=20
 #include <drm/drm_device.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
=20
 #define ST7789V_RAMCTRL_CMD		0xb0
@@ -646,7 +647,7 @@ static int st7789v_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
=20
-	ret =3D of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
+	ret =3D drm_of_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to get orientation\n");
=20
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 86b3f9c65c92..b87323443f49 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -337,19 +337,11 @@ int drm_panel_get_modes(struct drm_panel *panel, stru=
ct drm_connector *connector
=20
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
-int of_drm_get_panel_orientation(const struct device_node *np,
-				 enum drm_panel_orientation *orientation);
 #else
 static inline struct drm_panel *of_drm_find_panel(const struct device_node=
 *np)
 {
 	return ERR_PTR(-ENODEV);
 }
-
-static inline int of_drm_get_panel_orientation(const struct device_node *n=
p,
-					       enum drm_panel_orientation *orientation)
-{
-	return -ENODEV;
-}
 #endif
=20
 #if defined(CONFIG_DRM_PANEL)
--=20
2.54.0


--5zi5gr5vww6wvxqy--

--gzp3hunpx3jx5f4p
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEiOrDCAFJzPfAjcif3SOs138+s6EFAmpCc0UACgkQ3SOs138+
s6G8rA//YtfXxtm+91dwA43ESI6nbyaITPOxGphL8bZRAZ7rq362TdSTl39DA703
eVl598qN1wqRNx/AZ0ohfJCkCAmwJgNUWsHn1LW6F3r7kTojWb2CxK50iKOWBoDm
T+bWpKSAfWeZYMZM95SnYwx92ViMLI2N1Sle17Th90AhMsBfPQ7nak6QIr/vxhNX
hiSqQ40gOpdYONjFs6Jzjk5zzS+T/XqTFNQ1cADH4Dg1M5yWn6JgyXRmx2/9bbKK
UcGIqBaGGCklidK1ZzUOyJ5P5eic4bYmeXry1sEqZSAcu08/581usfv9X9fK99+X
IlnPdaBmq3CEQIHa3hs7ofE1xFqXHPF/bvSYtW0oypD76wyV7xa1pOlrNmiILZ9I
0FGBFcHEnu/Uu6zrgMthKZR2c4a9kP9LO1aLDH4dVdYdiXU4iiNU0Znp6mYrBLNt
D0hQU4Lag27KUO/tae2fT8202saMztmKHSIF6bv7WpfmcbireR2d3AEx2pkvYWiP
aFqxM6aax9QRFZd1WIBs2UZYA70tlcCZvUf+82hd7EkGXF9+Jv5aVc7K0XX85ToC
VF4l+VqrpnfLR96hlL6sri/rp/2aPGKEo+ffcjHboC+YNB2wYW212XmkMNEewYCI
ctY5ntJkjeBI57hW1ea9PibHPOL2lFaOGbtKKoiHxEtTFww8LgQ=
=z5m1
-----END PGP SIGNATURE-----

--gzp3hunpx3jx5f4p--
