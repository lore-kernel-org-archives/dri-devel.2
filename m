Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77C23C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 02:24:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D491B10EB13;
	Tue,  7 Jul 2026 02:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=nxp.com header.i=@nxp.com header.b="NR60oah2";
	dkim-atps=neutral
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011051.outbound.protection.outlook.com
 [40.107.130.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F1D710EB13
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 02:24:42 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KweJsYuXeeABTYQCcQpxlg7kbgNKMxEPJA/EeP3+U9telOFvoiAjuSwPmc5IGsZ743Ia7pDh6hvNk9ewbxWhDuSExd9ZzxZoeReczYF47XJ9o2tpxlZMUsdO1Se/JLYpSQJOKFH+faQG+FtWwKZeJnT/x/Y4wSGIJHSfY4vjKmYgw95a3n4dOOUS6/WHKQ6KXAh1/mU6T5UbpVxRI+Efc7SnCtw1vnafJR9iYLNh7gfTA+hKX6bX2K5H2AwYJ+6r6uY86LghUzvZbj5erX4Cla1elrefbKMlbtSiX7GttdcIMkrkgost+df+FoBnfNoMxyd11ZA6vyXJg9x4lgoIxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZnzNz2mbJT5/vwhb5017rjxk5AnsEDgbkzobgbgUkHI=;
 b=WappL+XFU2693f2bQbS8L9C4rx4+aa5DPeVhqc3KNEXT2PPBmUS/MsW0wSoBMYkapJPlvIQYL9D4vU64aqZSMtuJud9dQjj8amhSjGH7Ptnwdm4aSAlNdKT3VtsSY3Cxt4pdOCA5/6KShWr9+mSfIo6ULuUH1byMYZnarK5iXFGTk4gd7NdYLULC0g7slyUmh012pDExFjvVmS+rBGfCf8JRL3k/DyoqYUu1pYTiKqXAH0OnQYMwpEpUxRtHhZJI8SAuIwoo6cvPQgbEqIdm6myF8w/5BM0W8ztKwdk/jhiY19FsYuxqr40VRPbrBSa6Kggwch88JAD9yFtZ0TriXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZnzNz2mbJT5/vwhb5017rjxk5AnsEDgbkzobgbgUkHI=;
 b=NR60oah2MOFMWtuBWeFnohvPHI6NqEyIaVoH18r+Bwu/jAR8+BB/9n4rqBPG/gyTYRQ+mTpk4TeQ9Wp8GQrcLnn8xTp/+SjjqmmZ/brAU94fHauh54PvZ7vGgaXIjg2fv5wiPp8J6rSmjQCDYcsPAT3hT/9PPYsCeyzwkLQESGe+WoHkA1AOC85hat459V9FJRnhb4T0Q+Ji/g2ceZq07iWvGFPdzhRh+qXT/VIehBDCM3vaCiLtIxm/0A1F5RmhNVwNJfuj+fhYUhzfBaQjftNZnbDd/s8F1OZwBOEblzTL+MwjLXlRsrXhx5R9nuzPya0NlKCTEQT3Oh2H5mUKvw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com (2603:10a6:20b:4dd::8)
 by DU2PR04MB8918.eurprd04.prod.outlook.com (2603:10a6:10:2e1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Tue, 7 Jul
 2026 02:24:36 +0000
Received: from AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c]) by AS1PR04MB9287.eurprd04.prod.outlook.com
 ([fe80::6f30:763d:17d2:b79c%3]) with mapi id 15.21.0181.008; Tue, 7 Jul 2026
 02:24:36 +0000
Date: Tue, 7 Jul 2026 10:26:09 +0800
From: Liu Ying <victor.liu@nxp.com>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, marex@nabladev.com,
 daniel.baluta@nxp.com, Frank.Li@nxp.com, shawnguo@kernel.org,
 tzimmermann@suse.de, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, airlied@gmail.com, simona@ffwll.ch
Subject: Re: [RFC] drm/imx: upstream direction for i.MX95 display support
Message-ID: <akxjwULa-p6c6IvR@raspi>
References: <20260624100326.413699-1-piyushpatle228@gmail.com>
 <aj5MNiKSCiEDvDzL@raspi>
 <CAMB+xkayaViXeC2GyMMUfeCMzA4=fh-Dq6NYOL-hzKoLfAF19w@mail.gmail.com>
 <aksVMhFr8YzedE1w@raspi>
 <CAMB+xkY2rut-sEUMyFnXqYCNmyseP4nAGj4BfreORTTM=SN8_g@mail.gmail.com>
 <akuEOT2FRa77L0Jn@raspi>
 <CAMB+xka8Fame7aFZSiWEtVcozSTXX8g9MKJu+cycU2vtiSDHmQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMB+xka8Fame7aFZSiWEtVcozSTXX8g9MKJu+cycU2vtiSDHmQ@mail.gmail.com>
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To AS1PR04MB9287.eurprd04.prod.outlook.com
 (2603:10a6:20b:4dd::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR04MB9287:EE_|DU2PR04MB8918:EE_
X-MS-Office365-Filtering-Correlation-Id: d533a114-2162-4c2d-4d33-08dedbcee37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|19092799006|23010399003|366016|18002099003|22082099003|4143699003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info: 1uNwJhW/6aGcDcI51xRdykxiPXC1Df51MdQgXTJIE6XkUL7OGLCZDXe13m2y93vxF8rqT2lljI3fk2i53oHasDz5nJ00uDSQH0cgXHstY44AAnc/oFkDb+fzQYDWOWZsEqIpY3vVQg6jJP0/5Px2SYwfg6uosDYzcrBQdvQWj3EpZOocZWzKMmPwCtIEcUfRKJDVmcmVOowa/Vwq2YQ4vqZf4geZjHF3X33IfqhyQXyh4Fgrg99neKqW2tw4ET/XhPDBDVPle6l1n9uEU2QOZ4Xr5+/R2r/mRMGE+6uzuqodkrC1OZ+SzZI0CtRIaDMe5DtLO4QjfGBMU2X+QU0SQiNOJEiaBOdrH5uH5FapXaGa0NQMdjnCilTPe76dEHXac8sz0mvAM+YxwjhGALlUMot61qbbdMeI1cZQ6lxwaFbqKtrFPur+alym4mNKeeMDOAQvEctDkDPgCTsp7trbCu5nDUN1F32UgGoh7zp7nRWL6Zcqv4wBNYx1hWy+DfRA4xIBwTsnAAPvk7pHwyV9nugsQBfiFgZn4SmmyuMYWVx9tgEeyuE1vZYPD0QS1c73/x/zG7iPoSoWH6eSJ9JSamYESCt/tFsqy5M2ac9bZXwJpg8ieBmx7XQF4nDOcvIa18UUit4GCQRrn7qMP3NCSj/6TeQeMRH8Nkx9f2Fas3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS1PR04MB9287.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(19092799006)(23010399003)(366016)(18002099003)(22082099003)(4143699003)(11063799006)(56012099006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akJzZWZsc2w2VG45bWtxRXFucHZlSkQ1K0o3a0tlV2hETjUrSVRqWXlJQWd1?=
 =?utf-8?B?N1NrcUhsYTlmM2ZkdlJrWlVRdGtQNkU2UlE5K1B6ZEFQUzhZcjJkMDc1Vkxy?=
 =?utf-8?B?Y0RHWTZYRWxDRUFtZUlMZWdzRUJZZm5saGM2ZUc4bjJ0UytlS0hXOW5SQmlR?=
 =?utf-8?B?SEhxMTJiTFYvd0pFQi9mKytQUWtXbTU4dUI1eTFTV2I2S29rb2xWSEplYzlH?=
 =?utf-8?B?ZmlaUGxieGxISjNyeDFnNFdpTHlSU2w4TzkybFZoazAyZUNmVXZ3dTdqM29U?=
 =?utf-8?B?elRWZHZHVkVSaWlsT05HRXU5U3VKdE5sY2ViM3pVSSt3c2NTNWI2Z1ZSaFQx?=
 =?utf-8?B?V2U0UmlrZWd0aGJNREs5azdPU2pMdUE5MEdjUjFJMzVaYnI1WnQwelRPbXlQ?=
 =?utf-8?B?MENVbzM2NHhqN25GU3FWcGFObWVZRjJTR0JWcUpubFBWWmc2M3lYbXBoRnMy?=
 =?utf-8?B?UlNhWGRCQmpEdmZOcUx3RWtqUWRHVFFGTFZPdWFlRTZKUDV5QjlGaGlLWncw?=
 =?utf-8?B?RlgxRCtpOGpPdmZIT0daanUwSnU5WUpkdithNXRpckt1NXl6YzNWL0VQUnZO?=
 =?utf-8?B?a1hCWlFJRmRtS1JmcGNSSFFZUlg2UWRjTW4xdUtzUHFEeGU5NS9iZmdIVC9y?=
 =?utf-8?B?Zit0cFlnTlJSU1RvelI3QklUSHN0ODVyeDRpckJQcktzeWVGQm9hbjhpYW9W?=
 =?utf-8?B?TGl0b2ROVjl5dCtXWTlYdzhxWkhmT0JYQnA4L0wyTHhGVjJTM3E5TjRtWDZB?=
 =?utf-8?B?eSthQyt2d1Nrbi9mTGNxOUZmMUNJaktCaXpxdEYrZjlERkgrZkFrYjQ3RmI0?=
 =?utf-8?B?UDh5Q0xsSlYrUlJ1bmpXTVdnNE5HZjd3ai94ZlBOcEhrQzNOejcvdkdqbjhE?=
 =?utf-8?B?SmptT3BlMENyc3I3RTA2N3dXTlBjOVNIcFNrd0p1NXdvQzNnTTBnU2ZKUy9W?=
 =?utf-8?B?bHk3SkwzQjVaU1owdkZWM1J6WitkMHZnb0dhdCs0M3d2b3ZuTXgzWkdLVlVE?=
 =?utf-8?B?Um80dDY4WHB6MTBjQkZET3dNcmRJYXZ1VXAxOXpIWXUrUTNVdThKcHlXTHF3?=
 =?utf-8?B?aXZ5ZUFHd3hCK2dLc2tOWU9laGVseUJLaFMxU04vclE4NEdXem5oWDRPSm0r?=
 =?utf-8?B?U2pCR25oMmZFbmhPS2dKZGs1azQxT1AzNHFhemFWMXpvS21TSHY4empyZG90?=
 =?utf-8?B?SkI1STNGZzFRQWhiNS85eTJIeE9pRWNsSFBXbmxPdEd2T29XcjFycGpndGdC?=
 =?utf-8?B?bE0zd1A0dEx1eUprWUVqVVVVZkhSRTJCN21RYitGR1QxQ3ZaWURSZ1J3UWE4?=
 =?utf-8?B?elE4U3pxSEs5YjVkelhEUlIxbzdHdUh3c1prYUpjTmwvb2orWTFzSkFGR1I4?=
 =?utf-8?B?ZStyQ3BTbzZWQnozY3ErWVlaTnh0cXVaMWRaUWVQMzRJL3VjeGFCb043R0hi?=
 =?utf-8?B?ZXcvankyRVNaaXVneTBpSlpDWkY0MU5BRlp5cjhVZEpoNGY1UUppclNwUmNT?=
 =?utf-8?B?b09BdmhJczR6bGNPbkFXdFlId2dsSjFlSDhCSGNjT0N2ZDRvLzJwZHZMVGxP?=
 =?utf-8?B?alZqZVExeDhXWkJNWkVnZkhma1ByaHRTanlmWnp0cFY1a2NiZUVhUEU5bmNC?=
 =?utf-8?B?RVVBVEtZQVdEa2tZcURMaWsveFd4YjM2d0M1U2pzcjBjdDYrT3Y4U0xIeGJ1?=
 =?utf-8?B?NXVYK1VXcnpHU2huNlJVWWVWU01FQVRPbWN6TVpNZ3FMbnRGdG5vOHY0eGdD?=
 =?utf-8?B?ckRiOG8vU0lZY0RhRHJnRjV1NmVYY2d5QzVLU0t2L2xJUXNGVHdXR251Tytw?=
 =?utf-8?B?Zkx5VCtENGVDTE8zMHVJb1dMNkJYV1o3Z3V3VzRDSGxmOXUrL2tjUE0vbHV0?=
 =?utf-8?B?b05zQlVGcnFnQjlnU1pKenVaekZpblBGSmQwd3BLTTU2M0Q3OFdDL3FDVU9U?=
 =?utf-8?B?WGZ2NXFPclFSbjcyOS9sTGpSbE5LRmUra1I4b3F0NkorQk5yN2p2dlZYWGNZ?=
 =?utf-8?B?bzBnK1E1akJ4RmdBY3BrQ1daVHhlT3k1bVJwZGtaYlNRSlN2Z1lZZldaMzBp?=
 =?utf-8?B?QXlYbnd4OEZYaWx5U2VDUGoxY0NRdzQrUDBSR3hWNG9sVFpMVTBnWjBlZjl4?=
 =?utf-8?B?VjZDYWkxL1RUV29jNm92RkhjRWdRQ01wZjBiMFh4K0VuZkFQZ3VzUGNwT2lr?=
 =?utf-8?B?OUV5UmpSZmI1MSt3WEpINXNLOGNWQjdyUTZHc2J1bzdOVEFreU9JY2N6ZHdT?=
 =?utf-8?B?UnhQUG55MVVNTHdld3NzT0tJZURUSFRqZXBDMjFMQVJxcEtqSXlxUlN2NXB4?=
 =?utf-8?B?TnZUeXNOUGVFVzB3S1NhdTVMdE90ellmOW51eW5WUWM1VUFydlhEQT09?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d533a114-2162-4c2d-4d33-08dedbcee37a
X-MS-Exchange-CrossTenant-AuthSource: AS1PR04MB9287.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jul 2026 02:24:36.1322 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: unf9J4JfoeJWEBCX0Sqy5NcCQNlTEirksAEhUek1R2pWVTr9ISDu18MQUDrVXp8bVGxLbJS1sZzrZq6U57Gqig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8918
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

On Mon, Jul 06, 2026 at 08:31:42PM +0530, Piyush Patle wrote:
> On Mon, Jul 6, 2026 at 4:00 PM Liu Ying <victor.liu@nxp.com> wrote:
> >
> > On Mon, Jul 06, 2026 at 03:15:24PM +0530, Piyush Patle wrote:
> > > On Mon, Jul 6, 2026 at 8:07 AM Liu Ying <victor.liu@nxp.com> wrote:
> > > >
> > > > On Sun, Jul 05, 2026 at 03:33:51AM +0530, Piyush Patle wrote:
> > > > > On Fri, Jun 26, 2026 at 3:22 PM Liu Ying <victor.liu@nxp.com> wrote:
> > > > > >
> > > > > > On Wed, Jun 24, 2026 at 03:33:18PM +0530, Piyush Patle wrote:
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > The current dc/ implementation is a multi-device component driver
> > > with one
> > > > > > > platform_driver per block bound via the component framework. The
> > > downstream
> > > > > > > i.MX95 driver is a single monolithic platform_driver mapping all
> > > blocks from
> > > > > > > one register base. Unifying appears to require reconciling two bind
> > > models,
> > > > > > > rather than only adding match_data.
> > > > > >
> > > > > > I think that upstream i.MX95 display controller driver would also be
> > > based
> > > > > > on the component helper.  That's something for sure.
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > There is also anticipated divergence which is not yet upstream
> > > (i.MX8QXP
> > > > > > > prefetch/PRG, LTS and tiling modifiers, and the downstream i.MX95
> > > blit
> > > > > > > engine), although mainline dc/ is KMS-only today.
> > > > > >
> > > > > > Just want to point out that I sent out v5 patch set[2] to add i.MX8QXP
> > > > > > prefetch engine(DPRC + PRG) support for KMS.  That changes the
> > > driver's
> > > > > > mode setting code a lot.
> > > > > >
> > > > > > [2]
> > > https://lore.kernel.org/all/20251027-imx8-dc-prefetch-v5-0-4ecb6c6d4941@nxp.com/
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > One question for Liu Ying is whether the separate-driver plus shared
> > > > > > > helper-library approach is still the preferred direction, and where
> > > the
> > > > > > > helper boundary would be drawn (which blocks/ops are shared versus
> > > > > > > implemented per driver).
> > > > > >
> > > > > > Yes, separate DRM drivers + a helper library approach is still the
> > > direction
> > > > > > I want.  I think that the drivers and library would sit in the same
> > > > > > directory drivers/gpu/drm/imx/dc/.
> > > > > >
> > > > > > The purpose to add a library is to share code to reduce overall code
> > > lines.
> > > > > > I'd assume that shared blocks or common part of slightly different
> > > blocks
> > > > > > should be covered by the library.
> > > > > >
> > > > > > [...]
> > > > > >
> > > > > > > how the component and monolithic driver models
> > > > > > > would be reconciled given the differences described above.
> > > > > >
> > > > > > Like I said above, I don't think upstream driver would be monolithic.
> > > > > >
> > > > > > --
> > > > > > Regards,
> > > > > > Liu Ying
> > > > >
> > > > > Hi Liu,
> > > >
> > > > Hi Piyush,
> > > >
> > > > >
> > > > > A quick follow-up with some progress.
> > > > > I went ahead with the refactoring we discussed and now have it working
> > > on the
> > > > > i.MX95 15x15 FRDM, following the component-based model.
> > > > > The common implementations for ConstFrame, ExtDst, LayerBlend, FrameGen
> > > and
> > > > > the FetchUnit base have been moved into shared dc-lib-* helpers, with
> > > >
> > > > Can you please share the code in a public place, like github?
> > > >
> > >
> > > Sure. I've pushed the current work-in-progress branch here:
> > > https://github.com/PiyushPatle26/linux-mecha-im95-wip/tree/imx95-dc-preview
> >
> > I gave this branch a quick look.  The major problem is that you are using
> > the same 'struct drm_driver dc_drm_driver' for i.MX95 and i.MX8QXP display
> > controllers instead of using separate DRM drivers.  From userspace's POV,
> > they should see different driver names(drm_driver.name).  From drivers'
> > POVs, they should implement different mode setting callbacks.
> 
> I've reworked it based on your feedback and updated version to the same branch
> I've split them into separate DRM drivers.
> The shared dc_drm_driver and dc-drv-common.c are gone. i.MX8QXP and i.MX95
> now each have their own struct drm_driver, component bind path, probe logic and
> mode-setting callbacks. Userspace now also sees different driver names
> for the two SoCs.

It seems that there are common stuff that can be shared between dc-drv-imx95.c
and dc-drv-imx8qxp.c.

Please don't rename driver name from "imx8-dc" to "imx8qxp-dc".  Diver name
is supposed to be stable ABI.  "imx8-dc" implies that the driver would support
both i.MX8QXP display controller and i.MX8QM display controller which have
some H/W differences but still fit into a same driver.

I'm not sure why you mention 'DC8000' in your code.  We don't have this term
internally to describe the display controllers.

Those i.MX95 clocks used by dc-drv-imx95.c are not correct.  I'd assume only
cfg/axi/ocram clocks are needed.

> 
> The mode_valid, atomic_check, atomic_begin and atomic_flush callbacks
> were already
> identical in the previous version, so I've left them as a small shared
> helper to avoid
> duplicating the same code. If they diverge later, I'll split them into
> separate implementations.

It seems that mode-setting callbacks in dc-plane.c are still shared, which
seems to be worth splitting.

> 
> >
> > It looks like it's not worth extracting common code into those dc-lib-* files.
> > Each dc-[block].c is a library itself, though I could be wrong - after all,
> > I haven't find a time slice to add i.MX95 blocks to them and see how they
> > will be.
> >
> 
> Agreed. I removed the dc-lib-* split. The shared register code is now placed
> directly inside each dc-[block].c file, so every block stays
> self-contained while
> still being reused by both drivers where needed.

Didn't look into dc-[block].c files in detail.  Maybe, things need to be
improved there too.

> 
> > The idea is to share some code between the two DRM drivers *naturally*.
> >
> > >
> > > The files you asked about are:
> > > drivers/gpu/drm/imx/dc/dc-drv-common.c
> > > drivers/gpu/drm/imx/dc/dc-lib-*.c
> > > One thing I'd like to point out is that the pixel interleaver, display pixel
> > > link, LDB and LVDS PHY drivers are ports of the existing NXP downstream
> > > drivers. The new work in this branch is mainly the DC refactoring into the
> > > component model and the shared helper library.
> > > > > SoC-specific register layouts and tables supplied as data. The per-SoC
> > > glue is
> > > > > split into dc-drv-common.c, dc-drv-imx8qxp.c and dc-drv-imx95.c, while
> > > >
> > > > Same here, just want to see how dc-drv-common.c and dc-lib-* would look
> > > like.
> > > >
> > > The files you mentioned are available under:
> > > drivers/gpu/drm/imx/dc/dc-drv-common.c
> > > drivers/gpu/drm/imx/dc/dc-lib-*.c
> > > The helper library currently contains the common implementations for
> > > ConstFrame, ExtDst, LayerBlend, FrameGen and the FetchUnit base.
> > >
> > > > > i.MX95-specific blocks such as DomainBlend, Dither, FetchEco, FetchYUV,
> > > > > HScaler and VScaler remain separate component drivers.
> > > >
> > > > i.MX8QXP display controller also has Dither, FetchEco, HScaler and
> > > Vscaler,
> > > > so they are not i.MX95-specific blocks.  To add minimal feautures at
> > > first,
> > > > we don't need to support them as of now.  i.MX95-specific FetchYUV is
> > > similar
> > > > to i.MX8QXP-specific FetchDecode, so maybe FetchYUV won't be a separate
> > > > component driver at the end of the day.  To start up small, I think the
> > > > must-have DomainBlend and Dither(for Data-Enable, HSync and VSync polarity
> > > > controls) and two FetchLayers can be enabled to support two display
> > > pipelines.
> > > >
> > >
> > > Okay, I've reduced the implementation accordingly. The current branch
> > > only keeps DomainBlend, Dither and two FetchLayers. FetchEco, FetchYUV,
> > > HScaler and VScaler have been dropped for now.
> > > > BTW, do you have the i.MX95 TRM?  If no, then it would be difficult for
> > > you
> > > > to add DT bindings for *all* blocks.  Note that the DT bindings are
> > > supposed
> > > > to be complete at the first place.
> > > >
> > >
> > > Yes, I do.
> > >
> > > > >
> > > > > The implementation is functional on the FRDM over the pipeline
> > > > > DPU -> pixel-interleaver -> pixel-link -> LDB -> LVDS PHY -> IT6263 ->
> > > HDMI
> > > >
> > > > As I said before in separate mail thread, pixel link is not used in the
> > > LVDS
> > > > display pipeline, but instead it's only used in the MIPI DSI display
> > > pipeline.
> > > >
> > >
> > > Thanks for pointing that out. After checking the TRM, I updated the DT graph
> > > so the LVDS pipeline is now:
> > >
> > > DC -> Pixel-interleaver -> LDB -> LVDS PHY -> IT6263 -> HDMI
> >
> > Yes, this pipeline is correct.
> >
> > >
> > > Removing display_pixel_link from the LVDS path also required moving the
> > > bridge
> > > format translation into the pixel interleaver driver.
> > > > >
> > > > > EDID is read successfully, the initial modeset works for all tested
> > > modes
> > > > > (1920x1080@60, 1280x720@60, 720x480 and 640x480), and Weston and sway
> > > both run.
> > > > >
> > > > > There are still two known limitations. The initial modeset works, but
> > > > > subsequent mode changes currently wedge the ExtDst content shadow load,
> > > which
> > > > > appears related to the lack of a reset path for the i.MX95 FrameGen.
> > > >
> > > > Not sure what's the cause of the issue, but FrameGen needs to be disabled
> > > and
> > > > then re-enabled if you want to do a full modeset.  I'd say that's not a
> > > reset
> > > > path.  This critical issue needs to be fixed before posting formal
> > > patches.
> > > >
> > >
> > > Understood. I'll continue investigating the modeset issue before posting the
> > > formal patch series.
> > >
> > > > > In
> > > > > addition, the DSI path is implemented on the DC side but remains
> > > unvalidated.
> > > >
> > > > It's fine to support the LVDS display pipeline first as long as it doesn't
> > > > do harm to the MIPI DSI display pipeline support.  So, maybe drop the
> > > latter
> > > > first.
> > >
> > > I've done that in the current branch. It now focuses only on the validated
> > > LVDS pipeline.
> > >
> > > >
> > > > >
> > > > > The implementation is currently based on v7.2-rc1 together with your
> > > prefetch
> > > > > v5 series.
> > > > >
> > > > > The work is now ready to be posted as patch series: Adding LVDS/DSI
> > > > > i.MX95 support.
> > > > >
> > > > >
> > > > > Regards,
> > > > > Piyush Patle
> > > >
> > > > --
> > > > Regards,
> > > > Liu Ying
> > >
> > > Thanks again for taking the time to review this.
> > >
> > > Regards,
> > > Piyush Patle
> >
> > --
> > Regards,
> > Liu Ying
> 
> framegen re-tune issue is still unresolved.
> I'll fix that before posting the formal patch series.

I need to point out that i.MX95 display controller also has 2 display engines
and 1 pixel engine, which is something missing in your code.  This makes me
think that you have no enough i.MX95 display controller documents.

Generally speaking, I'd say there is a lot to be improved before posting the
formal patch series.  Gut feeling is that maybe it's a bit too difficult
for you to get the drivers right.  As I said earlier, my original plan is to
add i.MX8QXP prefetch engine support first with the posted patch series and
then to add i.MX95 display controller support, but maybe I can try to add the
latter first - just need to find a time slot.  However, adding prefetch engine
support first would directly show a reason to people why two DRM drivers are
warranted when adding i.MX95 display controller support.

> 
> Regards,
> Piyush Patle

-- 
Regards,
Liu Ying
