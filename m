Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25385C55822
	for <dri-devel@archiver.kernel.org>; Wed,  5 Aug 2026 09:53:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7453510EDBD;
	Wed,  5 Aug 2026 09:53:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ReVyhbvs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7AE310EDBC;
 Wed,  5 Aug 2026 09:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785923604; x=1817459604;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5P6ap4pd2YZ/3ivPEiSmkz2N+yp8L3HI1exwgTBbJOk=;
 b=ReVyhbvssFZ7gmQj6x9K0Kf5VE4Xeq2SQ61H6Mpd+xvw0rAHxvpPxQV2
 DMOYxdJ5nzLAoDp8asgLV6itgHw7m44LqXf+eb9K6ETeuXQe/q84585U+
 dmcfqG/tBNJPIm+qBznqwkl96WoEczb7wPEtS4y1MPPGhtUpb+RIIS/pH
 rhAh+VXa7fKY2Uv7tV8r+nIF5lXm/vLUoOnRKPgyE4DK7HjgjjqvA6shi
 qHcjB/7/r6SMD9NeY+HE8vQpUmo6ICPTJtYyLsqP/1wUsA+2SJPc/YTyD
 UFs+k/kWpqKyYqLOnBmhylfzu6kig4QacDjm8h0if9ReWzcHcvnMWZCgA g==;
X-CSE-ConnectionGUID: w55HXfTRQhK7JH4Y0kb1QA==
X-CSE-MsgGUID: X7qHpzw3TH22WsoqAjJpRQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="86264838"
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="86264838"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 02:53:23 -0700
X-CSE-ConnectionGUID: vdCYutBIRQeUCtqm9MBfSQ==
X-CSE-MsgGUID: U0JHQ0URSy+bPzkkemk7BQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,206,1779174000"; d="scan'208";a="260001730"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 05 Aug 2026 02:53:23 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 02:53:22 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Wed, 5 Aug 2026 02:53:22 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.1) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Wed, 5 Aug 2026 02:53:22 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMOQekR6l+vvxk75vnO8QChantuOf6Jl2qs/87AObmJvhkZa65qMv9MShmNwpH8S5BiJr/vG1UJ9g45xiIvebZeRkVTkCsqppT5Qpym3ToeIQBaCDC1pzExuR3XLSBnYwEkVSQNDz5Yi6D1HeWIvEZJnL69XIqFCkcg++DN1CWGJpIxDYs0qmYWObfPC7zjOigykkhmVxggrRw/6cjSo6QFrRouTM0/p3GmFUWjd6ZNnb7tsZVEFftTa/eGBcd/IvbgL87UAUm6dKsocyrgd4ouacygdpYv0nzjM/cOCadP8ze9Gcl8gLW+wCuu8cdChJxR7mW2SFjUE7eR23XqS8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cPLBL2AKkmeOvsH2TfVmNHd3KfzbCTQAmxCGuGOhI9g=;
 b=QN5QmhJDJ9uMI/NY9WMacXys4ezeNoZPxxcuCwGAnRlWUBoxTITmWFbM4vP6PSCkB+JHWii65/IzlNYq6WU/dCAaC1qjUYl2b0kJnGivEiTmbQY6+o8n2lgx/mpu4kwueDbyOnrZGraLRylKpAgI1FwFEN922OE3g9L4G2DTkzpYjnRg0HSk9FFZl14duHqxe2Iu2eZ/wpzIJTsescFCPPnHMVVJZi1PuafW3SyihWxJJ7yAj8okSB2wXnK6WLAredX9lhLKu7EGe01+VZ0x1z9iDurpaKSEeJzgmJyG6etBNcltj9uNoakEHEr/LoAvL3ElgtA/kxHvhHIHKWK+SA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by PH0PR11MB7615.namprd11.prod.outlook.com (2603:10b6:510:26e::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.18; Wed, 5 Aug
 2026 09:53:18 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0292.013; Wed, 5 Aug 2026
 09:53:18 +0000
Date: Wed, 5 Aug 2026 05:53:12 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Raag Jadav <raag.jadav@intel.com>
CC: Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <lijo.lazar@amd.com>, <Hawking.Zhang@amd.com>, <dev@lankhorst.se>,
 <zachary.mckevitt@oss.qualcomm.com>, <riana.tauro@intel.com>,
 <michal.wajdeczko@intel.com>, <matthew.d.roper@intel.com>,
 <mallesh.koujalagi@intel.com>
Subject: Re: [PATCH v5 2/5] drm/ras: Introduce error threshold
Message-ID: <anMICHct8ipD-u12@intel.com>
References: <20260722034228.662746-1-raag.jadav@intel.com>
 <20260722034228.662746-3-raag.jadav@intel.com>
 <amD-SVMRhA0SsW1t@intel.com> <amymMwoSOxpHhEvX@black.igk.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amymMwoSOxpHhEvX@black.igk.intel.com>
X-ClientProxiedBy: SJ0PR13CA0002.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::7) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|PH0PR11MB7615:EE_
X-MS-Office365-Filtering-Correlation-Id: e39e1bc0-b8d4-424c-ae69-08def2d76027
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|7416014|56012099006|4143699003|10067099003|11063799006|6133799003|3023799007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rNQaDlg7lKos1sKa7N075kh8sflD/+5KY8+yQMe88Y8zG0vwxciUe8uO6TfajxgyzMO+rIIfaeo4nntzzGcPJZQ3p8OKAXHT6dz6YPYq87P3f05gd72o5qTIs8iROETLKLz1uJ9vtTAxkBxOVaLLdFiNZHsUDadIMMZxfRXwW8uTdsstLzI6tOUVMtQkaCEKDpQ6yfEudq1VFRcuj6tErtbXFErOQgAmPf1dXtRPSUqVKUhlSw9IGplPnWe3+3GroKOtJe/fS6NHHWhiKO1MGXEePQjwPnqhjW6z9MMEYpmqZYlZ8jRntX2XJw86lLatxGvhMMJ7eFZxNFtfCF2zIngvs7O328kNQtuUlXZYZuStziQ4wF5jVrsUykfgQJkNisJpTgSFg24l1SwEfc89hFRwYLHEU2ulhJsDaEniqasewi/ervDMSaUVnkRvwcFu8ISFQgWnnlsi6TfDKmkJrb3F28QOOeKj8NVvyxna0o+AegAf0B8wAqpbgZeiQ7UeS3V+E+z2I4waLbVJ3OfkZxNW5l5jqfEuqAz5cUgTZswcSiew/fj1QMukYo9iLKKFdk1STTDckKt51LUi0zeCU3LY0o8idjq9nD1YA3j0o4cRFNJTlYdxOCgo4epsMF9TmF5PoQG2OeSYRVFI4MJ0u8qHBojItbYV228UaJSXF+o=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(7416014)(56012099006)(4143699003)(10067099003)(11063799006)(6133799003)(3023799007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0miLpGCCPzz/S2R2kQer8YkQYLDyGzJXm0iGQGZtTkFSJs5ZL54rUvqDTXTF?=
 =?us-ascii?Q?1Dv8RStaFMBdGrZurrpAugxUstHvb3FfdBOjSVeYDHSPWz1lifx1y0BseZy3?=
 =?us-ascii?Q?MmpO8m67wfJHsFbvOGBCPNuemLgsoHnQlK/g1kbSuPAV1NVQtwO4khy4q8do?=
 =?us-ascii?Q?yylS5BOP5DooNFAZ+MlsNHbwf8Fsd8WzasKJldkcybUAYbroTffRg+3Q+H55?=
 =?us-ascii?Q?FuT35IjZ3LRCJpDYaPiYy10b0U4EI4SstJlf1p0TqCbyftkkZ0lX+Es8iww+?=
 =?us-ascii?Q?K6+0unUPXNyVRepgy5I9jib5DAblXDjl+sinZuefX2JEbZySkcyVusi38Ipv?=
 =?us-ascii?Q?EZ5QCIXwFQSArdLgQbiXFA9zjvsfxGpmp9tSWUnEu+n2UHq2cAHEZatfgnkJ?=
 =?us-ascii?Q?tcCDfV0W4Pp3bJmSHtFQ7Aq0UgNNYq0o74VFHYWuSi4YdPNo19PStbrLvQtB?=
 =?us-ascii?Q?muX2bpVp2okerzZPloAp39b9u2LS4MGiBUtYzimg8+LXxtVq08cs6wa/yWyN?=
 =?us-ascii?Q?ohswuQDFyhuG1f7DFN/PTALtTUBW8ery+3I9mvUF4ekDD+I6Kw20JV3B9FP5?=
 =?us-ascii?Q?UDgPwUBUcZt4jf3ep9Jb8S92NOoAs41OHSpp8RKWGkQrMya7KfEtymjqCvKK?=
 =?us-ascii?Q?407yDurbvC6fLl/DIH/OS3GxRR+g2c6IW2O97H0YjiEF3Xkd1jVAqxhjKf5o?=
 =?us-ascii?Q?eO9WH6AuDXcphtb3JeA54NWg1JyLD4+VhkcRPaPgaOT4unKHwn02TABLR1ls?=
 =?us-ascii?Q?dBSdjI2HDtlBmYNgBZqb//6IBtYC9EXptJKNcDQhmyTzErgfsZSgQwbRNplb?=
 =?us-ascii?Q?J5GR88QoPolnHvy+NAVTSsLRmN071GRTTdHudVoK4elQQCXJbqfpsG6GvZtR?=
 =?us-ascii?Q?7FI1r1GphbOMUtmMmXxWeUlvjduoJWlzWOz+6ILspQk3JnYijo/pCUzxjn75?=
 =?us-ascii?Q?kYazUtWO//sj5Q2/ZtnFCqP2q2mowvG6H78S5A0K7FiSL1uDnlMG7AiHgCQP?=
 =?us-ascii?Q?kBV8rsw9/CrQl7Bgy5dnv/Fiojv//xUCNRUA/cnbDyEcIcpjn8I5QxMBbfM9?=
 =?us-ascii?Q?VOExNb4psFmdNZ0CVRNruRLgX+yRJ4fqxhhZVT713y+E3EuKtvcmCk+sa9co?=
 =?us-ascii?Q?au/vDWYz8eZwBXtjjNfADU1w4d9NrMSWw6UYj7x4Ci7hwUS69MpsKljqQ0uM?=
 =?us-ascii?Q?L2UWeq2h8HdrQxhaXo4ycUaWY0x5cHY1L6mstn6n5IvSJXxnmh+6sKOU3i8l?=
 =?us-ascii?Q?giMcF3OjUA1IM5Mkd5I16xSItAlu1zsfaWPYpyQ+1doZV+asJVdOrIz86QXa?=
 =?us-ascii?Q?TsGcGqKviIzdf4jg5kEpQs92I3v2fzzR05N7l+1zGk9Bflph+blU+rH9CAxp?=
 =?us-ascii?Q?PJP8wggQ9At3IAQxBib+vxhYBsgtdoftu43ghjEhbIrA1uhTpcBQewea/tGx?=
 =?us-ascii?Q?Mop+pYbu6XxI6PdOpgSfVzatQYuBElWtpYl8vTJMMMnrP+nBIYv8vL+4fQn3?=
 =?us-ascii?Q?+yvJYGgIGR5d4GC3F1M1+G3/plEGFSmuIOJrWmykT60gCuW56eIbdMxY7vYj?=
 =?us-ascii?Q?IoY3TyCTGTZFpvXBaDhzoLzTE0PkaOxhsv6OIIkxMNgWK2qeqp5QP3aGRsT4?=
 =?us-ascii?Q?yCkhTnKPiBv6TyPkqfAWPRuK8G1sIHOCvI3UbZvuIZtxJWv/U29eel8Gm7Pu?=
 =?us-ascii?Q?c1iKj8ZLIpUjG3lqSGhNTBu3yQIFEUxXlPk88LBR0Moy441lEo8sNKjHppyH?=
 =?us-ascii?Q?3zwO4EZffQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: SmE9DtYbSjEb7r1MiDCxD3lOUhFUPlsPKkGIUDmp/kAyB6KU3LBnmSy1e6JBVu3aiZ/dku6y/TcEuwWt6HX61YpAX60kM3g8vCBn9Q7eB1yEriz3N7JvanG+KbbbZAKqSj5FXifweJfpb9C0USG+1OZ16uTc+ofrvYtCc1xWKCtNEKCHevwy+q4+jZSmV2iTwdRT46XwV09vJMewnH9g0NkU9/zOfAjqzbfL4qGv9DqYCrCa9CBsTAH4wKuySwvHKstmm9k8over+4ijnfYWfmnGDr6DnrdNq7wuMYfpH2qHlRqGOccNduOyMJyORsKSh26IDPDRTsk38Lho+0kmEQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: e39e1bc0-b8d4-424c-ae69-08def2d76027
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Aug 2026 09:53:18.0436 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AoKz9S9I0Lca7i9e0L/IsuFcC8bbX2dnp/06VE43NfllSqw6YRijXOJg1Tz+411u2OOQyY8KTVjIVi9rrA838g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7615
X-OriginatorOrg: intel.com
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

On Fri, Jul 31, 2026 at 03:42:11PM +0200, Raag Jadav wrote:
> Hi net maintainers,
> 
> On Wed, Jul 22, 2026 at 01:30:49PM -0400, Rodrigo Vivi wrote:
> > On Wed, Jul 22, 2026 at 09:11:12AM +0530, Raag Jadav wrote:
> > > Add get-error-threshold and set-error-threshold command support which
> > > allows querying/setting error threshold of the counter. Threshold in RAS
> > > context means the number of errors the hardware is expected to accumulate
> > > before it raises them to software. This is to have a fine grained control
> > > over error notifications that are raised by the hardware.
> > > 
> > > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> > > Reviewed-by: Riana Tauro <riana.tauro@intel.com>
> > > ---
> > > v2: Document threshold definition (Riana)
> > >     Return -EOPNOTSUPP on threshold callbacks absence (Riana)
> > >     Cancel and free genlmsg on failure (Riana)
> > >     Document threshold bounds checking responsibility (Riana)
> > > v3: Move documentation from yaml to rst file (Riana)
> > >     s/value/threshold (Riana)
> > >     Use goto for error handling (Riana)
> > > v4: Clarify 0 threshold expectations (Riana)
> > >     Drop redundant wrapping (Riana)
> > > v5: Drop redundant documentation (Riana)
> > >     Aesthetic adjustment (Riana)
> > > ---
> > >  Documentation/gpu/drm-ras.rst            |  18 +++
> > >  Documentation/netlink/specs/drm_ras.yaml |  32 +++++
> > 
> > Jakub and other net maintainers, ack on getting this through drm trees?
> 
> Can you please provide guidance?

Even better, could you please ack the MAINTAINERS change [1] so we can stop
bothering you with these asks?

[1] https://lore.kernel.org/all/20260805094949.536651-2-rodrigo.vivi@intel.com/T/#u

> 
> Raag
> 
> > >  drivers/gpu/drm/drm_ras.c                | 158 +++++++++++++++++++++++
> > >  drivers/gpu/drm/drm_ras_nl.c             |  27 ++++
> > >  drivers/gpu/drm/drm_ras_nl.h             |   4 +
> > >  include/drm/drm_ras.h                    |  29 +++++
> > >  include/uapi/drm/drm_ras.h               |   3 +
> > >  7 files changed, 271 insertions(+)
> > > 
> > > diff --git a/Documentation/gpu/drm-ras.rst b/Documentation/gpu/drm-ras.rst
> > > index 83c21853b74b..2718f8aee09d 100644
> > > --- a/Documentation/gpu/drm-ras.rst
> > > +++ b/Documentation/gpu/drm-ras.rst
> > > @@ -56,6 +56,10 @@ User space tools can:
> > >    ``node-id`` and ``error-id`` as parameters.
> > >  * Clear specific error counters with the ``clear-error-counter`` command, using both
> > >    ``node-id`` and ``error-id`` as parameters.
> > > +* Query specific error counter threshold with the ``get-error-threshold`` command, using both
> > > +  ``node-id`` and ``error-id`` as parameters.
> > > +* Set specific error counter threshold with the ``set-error-threshold`` command, using
> > > +  ``node-id``, ``error-id`` and ``error-threshold`` as parameters.
> > >  
> > >  YAML-based Interface
> > >  --------------------
> > > @@ -111,3 +115,17 @@ Example: Clear an error counter for a given node
> > >  
> > >      sudo ynl --family drm_ras --do clear-error-counter --json '{"node-id":0, "error-id":1}'
> > >      None
> > > +
> > > +Example: Query error threshold of a given counter
> > > +
> > > +.. code-block:: bash
> > > +
> > > +    sudo ynl --family drm_ras --do get-error-threshold --json '{"node-id":0, "error-id":1}'
> > > +    {'error-id': 1, 'error-name': 'error_name1', 'error-threshold': 16}
> > > +
> > > +Example: Set error threshold of a given counter
> > > +
> > > +.. code-block:: bash
> > > +
> > > +    sudo ynl --family drm_ras --do set-error-threshold --json '{"node-id":0, "error-id":1, "error-threshold":8}'
> > > +    None
> > > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > > index e113056f8c01..9cf7f9cde242 100644
> > > --- a/Documentation/netlink/specs/drm_ras.yaml
> > > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > > @@ -69,6 +69,10 @@ attribute-sets:
> > >          name: error-value
> > >          type: u32
> > >          doc: Current value of the requested error counter.
> > > +      -
> > > +        name: error-threshold
> > > +        type: u32
> > > +        doc: Error threshold of the counter.
> > >  
> > >  operations:
> > >    list:
> > > @@ -124,3 +128,31 @@ operations:
> > >        do:
> > >          request:
> > >            attributes: *id-attrs
> > > +    -
> > > +      name: get-error-threshold
> > > +      doc: >-
> > > +           Retrieve error threshold of a given counter.
> > > +           The response includes the id, the name, and current threshold
> > > +           of the counter.
> > > +      attribute-set: error-counter-attrs
> > > +      flags: [admin-perm]
> > > +      do:
> > > +        request:
> > > +          attributes: *id-attrs
> > > +        reply:
> > > +          attributes:
> > > +            - error-id
> > > +            - error-name
> > > +            - error-threshold
> > > +    -
> > > +      name: set-error-threshold
> > > +      doc: >-
> > > +           Set error threshold of a given counter.
> > > +      attribute-set: error-counter-attrs
> > > +      flags: [admin-perm]
> > > +      do:
> > > +        request:
> > > +          attributes:
> > > +            - node-id
> > > +            - error-id
> > > +            - error-threshold
> > > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > > index 467a169026fc..9a7b3d2acd25 100644
> > > --- a/drivers/gpu/drm/drm_ras.c
> > > +++ b/drivers/gpu/drm/drm_ras.c
> > > @@ -41,6 +41,13 @@
> > >   *    Userspace must provide Node ID, Error ID.
> > >   *    Clears specific error counter of a node if supported.
> > >   *
> > > + * 4. GET_ERROR_THRESHOLD: Query error threshold of a given counter.
> > > + *    Userspace must provide Node ID and Error ID.
> > > + *    Returns the error threshold of a specific counter.
> > > + *
> > > + * 5. SET_ERROR_THRESHOLD: Set error threshold of a given counter.
> > > + *    Userspace must provide Node ID, Error ID and threshold to be set.
> > > + *
> > >   * Node registration:
> > >   *
> > >   * - drm_ras_node_register(): Registers a new node and assigns
> > > @@ -61,6 +68,13 @@
> > >   *     + The error counters in the driver doesn't need to be contiguous, but the
> > >   *       driver must return -ENOENT to the query_error_counter as an indication
> > >   *       that the ID should be skipped and not listed in the netlink API.
> > > + *     + The driver can optionally implement query_error_threshold() and
> > > + *       set_error_threshold() callbacks to facilitate getting/setting error
> > > + *       threshold of the counter. Threshold in RAS context means the number of
> > > + *       errors the hardware is expected to accumulate before it raises them to
> > > + *       software. This is to have a fine grained control over error notifications
> > > + *       that are raised by the hardware.
> > > + *     + The driver is responsible for error threshold bounds checking.
> > >   *
> > >   * Netlink handlers:
> > >   *
> > > @@ -72,6 +86,10 @@
> > >   *   operation, fetching a counter value from a specific node.
> > >   * - drm_ras_nl_clear_error_counter_doit(): Implements the CLEAR_ERROR_COUNTER doit
> > >   *   operation, clearing a counter value from a specific node.
> > > + * - drm_ras_nl_get_error_threshold_doit(): Implements the GET_ERROR_THRESHOLD doit
> > > + *   operation, fetching the error threshold of a specific counter.
> > > + * - drm_ras_nl_set_error_threshold_doit(): Implements the SET_ERROR_THRESHOLD doit
> > > + *   operation, setting the error threshold of a specific counter.
> > >   */
> > >  
> > >  static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > > @@ -168,6 +186,40 @@ static int get_node_error_counter(u32 node_id, u32 error_id,
> > >  	return node->query_error_counter(node, error_id, name, value);
> > >  }
> > >  
> > > +static int get_node_error_threshold(u32 node_id, u32 error_id, const char **name, u32 *threshold)
> > > +{
> > > +	struct drm_ras_node *node;
> > > +
> > > +	node = xa_load(&drm_ras_xa, node_id);
> > > +	if (!node)
> > > +		return -ENOENT;
> > > +
> > > +	if (!node->query_error_threshold)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> > > +		return -EINVAL;
> > > +
> > > +	return node->query_error_threshold(node, error_id, name, threshold);
> > > +}
> > > +
> > > +static int set_node_error_threshold(u32 node_id, u32 error_id, u32 threshold)
> > > +{
> > > +	struct drm_ras_node *node;
> > > +
> > > +	node = xa_load(&drm_ras_xa, node_id);
> > > +	if (!node)
> > > +		return -ENOENT;
> > > +
> > > +	if (!node->set_error_threshold)
> > > +		return -EOPNOTSUPP;
> > > +
> > > +	if (error_id < node->error_counter_range.first || error_id > node->error_counter_range.last)
> > > +		return -EINVAL;
> > > +
> > > +	return node->set_error_threshold(node, error_id, threshold);
> > > +}
> > > +
> > >  static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> > >  			   const char *error_name, u32 value)
> > >  {
> > > @@ -186,6 +238,22 @@ static int msg_reply_value(struct sk_buff *msg, u32 error_id,
> > >  			   value);
> > >  }
> > >  
> > > +static int msg_reply_threshold(struct sk_buff *msg, u32 error_id, const char *error_name,
> > > +			       u32 threshold)
> > > +{
> > > +	int ret;
> > > +
> > > +	ret = nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID, error_id);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	ret = nla_put_string(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME, error_name);
> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	return nla_put_u32(msg, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD, threshold);
> > > +}
> > > +
> > >  static int doit_reply_value(struct genl_info *info, u32 node_id,
> > >  			    u32 error_id)
> > >  {
> > > @@ -225,6 +293,43 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> > >  	return ret;
> > >  }
> > >  
> > > +static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_id)
> > > +{
> > > +	const char *error_name;
> > > +	struct sk_buff *msg;
> > > +	struct nlattr *hdr;
> > > +	u32 threshold;
> > > +	int ret;
> > > +
> > > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > > +	if (!msg)
> > > +		return -ENOMEM;
> > > +
> > > +	hdr = genlmsg_iput(msg, info);
> > > +	if (!hdr) {
> > > +		ret = -EMSGSIZE;
> > > +		goto free_msg;
> > > +	}
> > > +
> > > +	ret = get_node_error_threshold(node_id, error_id, &error_name, &threshold);
> > > +	if (ret)
> > > +		goto cancel_msg;
> > > +
> > > +	ret = msg_reply_threshold(msg, error_id, error_name, threshold);
> > > +	if (ret)
> > > +		goto cancel_msg;
> > > +
> > > +	genlmsg_end(msg, hdr);
> > > +
> > > +	return genlmsg_reply(msg, info);
> > > +
> > > +cancel_msg:
> > > +	genlmsg_cancel(msg, hdr);
> > > +free_msg:
> > > +	nlmsg_free(msg);
> > > +	return ret;
> > > +}
> > > +
> > >  /**
> > >   * drm_ras_nl_get_error_counter_dumpit() - Dump all Error Counters
> > >   * @skb: Netlink message buffer
> > > @@ -358,6 +463,59 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > >  	return node->clear_error_counter(node, error_id);
> > >  }
> > >  
> > > +/**
> > > + * drm_ras_nl_get_error_threshold_doit() - Query error threshold of a counter
> > > + * @skb: Netlink message buffer
> > > + * @info: Generic Netlink info containing attributes of the request
> > > + *
> > > + * Extracts the Node ID and Error ID from the netlink attributes and retrieves
> > > + * the error threshold of the corresponding counter. Sends the result back to
> > > + * the requesting user via the standard Genl reply.
> > > + *
> > > + * Return: 0 on success, or negative errno on failure.
> > > + */
> > > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> > > +{
> > > +	u32 node_id, error_id;
> > > +
> > > +	if (!info->attrs ||
> > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID))
> > > +		return -EINVAL;
> > > +
> > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > > +
> > > +	return doit_reply_threshold(info, node_id, error_id);
> > > +}
> > > +
> > > +/**
> > > + * drm_ras_nl_set_error_threshold_doit() - Set error threshold of a counter
> > > + * @skb: Netlink message buffer
> > > + * @info: Generic Netlink info containing attributes of the request
> > > + *
> > > + * Extracts the Node ID, Error ID and threshold from the netlink attributes and
> > > + * sets the error threshold of the corresponding counter.
> > > + *
> > > + * Return: 0 on success, or negative errno on failure.
> > > + */
> > > +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *info)
> > > +{
> > > +	u32 node_id, error_id, threshold;
> > > +
> > > +	if (!info->attrs ||
> > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID) ||
> > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID) ||
> > > +	    GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD))
> > > +		return -EINVAL;
> > > +
> > > +	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > > +	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > > +	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> > > +
> > > +	return set_node_error_threshold(node_id, error_id, threshold);
> > > +}
> > > +
> > >  /**
> > >   * drm_ras_node_register() - Register a new RAS node
> > >   * @node: Node structure to register
> > > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > > index dea1c1b2494e..02e8e5054d05 100644
> > > --- a/drivers/gpu/drm/drm_ras_nl.c
> > > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > > @@ -28,6 +28,19 @@ static const struct nla_policy drm_ras_clear_error_counter_nl_policy[DRM_RAS_A_E
> > >  	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > >  };
> > >  
> > > +/* DRM_RAS_CMD_GET_ERROR_THRESHOLD - do */
> > > +static const struct nla_policy drm_ras_get_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID + 1] = {
> > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > > +};
> > > +
> > > +/* DRM_RAS_CMD_SET_ERROR_THRESHOLD - do */
> > > +static const struct nla_policy drm_ras_set_error_threshold_nl_policy[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD + 1] = {
> > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID] = { .type = NLA_U32, },
> > > +	[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD] = { .type = NLA_U32, },
> > > +};
> > > +
> > >  /* Ops table for drm_ras */
> > >  static const struct genl_split_ops drm_ras_nl_ops[] = {
> > >  	{
> > > @@ -56,6 +69,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> > >  		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > >  		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > >  	},
> > > +	{
> > > +		.cmd		= DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > > +		.doit		= drm_ras_nl_get_error_threshold_doit,
> > > +		.policy		= drm_ras_get_error_threshold_nl_policy,
> > > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > +	},
> > > +	{
> > > +		.cmd		= DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > > +		.doit		= drm_ras_nl_set_error_threshold_doit,
> > > +		.policy		= drm_ras_set_error_threshold_nl_policy,
> > > +		.maxattr	= DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > +	},
> > >  };
> > >  
> > >  struct genl_family drm_ras_nl_family __ro_after_init = {
> > > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > > index a398643572a5..57b1e647d833 100644
> > > --- a/drivers/gpu/drm/drm_ras_nl.h
> > > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > > @@ -20,6 +20,10 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> > >  					struct netlink_callback *cb);
> > >  int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > >  					struct genl_info *info);
> > > +int drm_ras_nl_get_error_threshold_doit(struct sk_buff *skb,
> > > +					struct genl_info *info);
> > > +int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb,
> > > +					struct genl_info *info);
> > >  
> > >  extern struct genl_family drm_ras_nl_family;
> > >  
> > > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > > index 0beede3ddc4e..b1fa87975cc5 100644
> > > --- a/include/drm/drm_ras.h
> > > +++ b/include/drm/drm_ras.h
> > > @@ -71,6 +71,35 @@ struct drm_ras_node {
> > >  	 */
> > >  	int (*clear_error_counter)(struct drm_ras_node *node, u32 error_id);
> > >  
> > > +	/**
> > > +	 * @query_error_threshold:
> > > +	 *
> > > +	 * This callback is used by drm-ras to query error threshold of a
> > > +	 * specific counter.
> > > +	 *
> > > +	 * Driver should expect query_error_threshold() to be called with
> > > +	 * error_id from `error_counter_range.first` to
> > > +	 * `error_counter_range.last`.
> > > +	 *
> > > +	 * Returns: 0 on success, negative error code on failure.
> > > +	 */
> > > +	int (*query_error_threshold)(struct drm_ras_node *node, u32 error_id, const char **name,
> > > +				     u32 *threshold);
> > > +
> > > +	/**
> > > +	 * @set_error_threshold:
> > > +	 *
> > > +	 * This callback is used by drm-ras to set error threshold of a specific
> > > +	 * counter.
> > > +	 *
> > > +	 * Driver should expect set_error_threshold() to be called with error_id
> > > +	 * from `error_counter_range.first` to `error_counter_range.last`.
> > > +	 * Driver is responsible for error threshold bounds checking.
> > > +	 *
> > > +	 * Returns: 0 on success, negative error code on failure.
> > > +	 */
> > > +	int (*set_error_threshold)(struct drm_ras_node *node, u32 error_id, u32 threshold);
> > > +
> > >  	/** @priv: Driver private data */
> > >  	void *priv;
> > >  };
> > > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > > index 218a3ee86805..27c68956495f 100644
> > > --- a/include/uapi/drm/drm_ras.h
> > > +++ b/include/uapi/drm/drm_ras.h
> > > @@ -33,6 +33,7 @@ enum {
> > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID,
> > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_NAME,
> > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_VALUE,
> > > +	DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD,
> > >  
> > >  	__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX,
> > >  	DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX = (__DRM_RAS_A_ERROR_COUNTER_ATTRS_MAX - 1)
> > > @@ -42,6 +43,8 @@ enum {
> > >  	DRM_RAS_CMD_LIST_NODES = 1,
> > >  	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > >  	DRM_RAS_CMD_CLEAR_ERROR_COUNTER,
> > > +	DRM_RAS_CMD_GET_ERROR_THRESHOLD,
> > > +	DRM_RAS_CMD_SET_ERROR_THRESHOLD,
> > >  
> > >  	__DRM_RAS_CMD_MAX,
> > >  	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
> > > -- 
> > > 2.43.0
> > > 
