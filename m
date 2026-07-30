Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A6B4C5516D
	for <dri-devel@archiver.kernel.org>; Thu, 30 Jul 2026 21:57:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87AAB10F0BD;
	Thu, 30 Jul 2026 21:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="UiQYDawE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0624810E10F;
 Thu, 30 Jul 2026 21:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785448648; x=1816984648;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=VdzvYSC2ZqpAfDRpe6WCcHbKSLNpgJwJmJ0j9DI7BaE=;
 b=UiQYDawE7i4VzwxB1ySRQH+GzafVZCsGABTLIBLJ9qml3h1jhI8ZbbKM
 cLtVJ/4EGjyWGJikwW/tgnB59fO4b+APgMobjbIgobP48x0aQXzGHlqUl
 rjLN38Dbo833vv2+o1Nw/OX0x7oSeMcxKNfMKUU9B7C8hUAFJiM+y0+Jx
 AiL1WZSo61x4yvFCa2ZtGyIIa9kAix4FoJ3zpxuY8EX0kCx6bvN++/8l1
 yMRxK4lpRHN5G/i1Qnxy03fZRQ0QjO1WSwZcqIz0B0y4wVgXvfLRwGjYp
 nc97w2lYhNH9cB+rvjshcRY4xlUXCe2Kf/wKKJCLREj12h3vixOVPO2nW Q==;
X-CSE-ConnectionGUID: uZMe75J1Qg6HUXBgMWB3FA==
X-CSE-MsgGUID: iLLl15N0R+CMIB9sfwXfCA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="85843874"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="85843874"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 14:57:27 -0700
X-CSE-ConnectionGUID: V328D2ScSd2pXUa44T0OEw==
X-CSE-MsgGUID: cEaMbUCXSzSWMCAY0ap+Fw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="285009845"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 14:57:26 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 14:57:25 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 14:57:25 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.38) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 14:57:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PSPLCy8MLaCiu/a7B4oXoWsSPs/MPQ5j6hzGU9jFbxzu0Xrm/oCr/sx7vLYyTjh3phsVggQ9vAeGnKJhn2R62bAi25PmLy1K/A7HN/875O7njjweRE2uQeEhqRTzzP/R9RDaEcihqXt5fF+GnQOhGQlVoWTdOhaHf8Yk2KUG/foETqvL11VFk23knzijq9ep3Ad1+ja3KjBBwsoEog5UcQE2PtcBZks6Z3kjRDM7fHnB6EBRiW/+zTbNHwWUt6SosyOEGMFeTFJKs2CfkrdwyNoE6PS0QQ+NhqMeaAzk1vhcAagzGh8eypOCNv6zFRDdvoBPo+4uxicGVMuUlrFzUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U87QAi6sSoEqQzQvX4gShYYxYHozAskwkVzM0Lf8HJM=;
 b=nZVInDe07IZcQx7aKF2tURP9VIcZMxhH0eH277aIBzTjIPT9zpN2zSjaMoA6vCqMy+2lQhuboRmkdB9HPbugVTJRWIBz5/bjuRvrRMrMcv4SWYgfWFFLUAINe7btJVsaoI/+jD8YGj4jMB93gm4OTt0l8F61FdoVcAh7rqy7Y8xKCXsLOqMGnI14UK6Sb9a/jnf61REcPcg0NbxiQCN9KwbVPEygGWMtDUe1ia7vY7A3yiQG9Pd6olmkUyGn9Qx6933kof+VoQI/iRMSdcSWg0lAcOV8gfRZrA3HsnkByymZ5pNLlB3blF7djFKObw2YXXsyM8FacTAx9mbH76InrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CY8PR11MB7036.namprd11.prod.outlook.com (2603:10b6:930:50::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 21:57:23 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%4]) with mapi id 15.21.0270.012; Thu, 30 Jul 2026
 21:57:22 +0000
Date: Thu, 30 Jul 2026 17:57:18 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-intel-fixes
Message-ID: <amvIvqJehP7uaUgx@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0198.namprd03.prod.outlook.com
 (2603:10b6:a03:2ef::23) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CY8PR11MB7036:EE_
X-MS-Office365-Filtering-Correlation-Id: 644cec3c-075b-4f9b-734b-08deee8588d6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|23010399003|376014|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: pIiJKkUQx9bEBPj4v3QLfzVk34AJeOqlsAy+9ruzQe6r1GSE8Zl68MI1rkuSuVL42ynFrIdswrzNSRCE9pyrxdD7UEqnDqVjsKYPxR17CoP7rJ8DYsJNytxly3vx8rHnji7O321rs2n4SCnLiFK1MsSZuaX3O43siF9C7OZIadSUWRZMvVEPcH+nPSR7hCUSDYNY+2ji9Jrb72aaXYGz2WAOhvFbDZNCgq+gE1ifmLliQi+IkNsDL7du5+ZP0K8hFp/pwZhuMFMlMUyrEZ9JZgRSu55hLs53GXxX2aP/ePZIqMXh5F4LQLZgV14omuohxZUvuROYOttp9h97/JX38pP4cJQxGGy3AzDFqOdlrZOYUe2zRiZk7ITtW5pMQ/jpFLVm4uJp55ISvoBvhQT+CIeAQwhF4aGFST3mNRhcPUT0RsXkDXigTBNLlm8Xf/lWGLgHN/F0jilHDm9ktI3Daw7+bbN2qZzp9kEU7/VJhlnHSr/KXxuQgmhrRKleo0w9vdO+slIPGU5OF4CO2tCRk/K1MCKnQC8e2qaV6x9fNslG+MUtkSEmWPywRUgdr0+ER8wEyhVGTC1hDnWG7ZfsoU6fiOpEJpeLMcxxCxqzG2dR+FCGS1lnfD1GMnsyfM9S
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bPEDF6hBuCAgQPcUkU3vm99lqAlmfOla/o333Duh0dvEfqN+lOkrP0tL5/A2?=
 =?us-ascii?Q?VlKvSOSp7rF2XalIm9yPbOwRVktmYsBbScsz8JB2//76Y1tvLKP9BL5uSgR4?=
 =?us-ascii?Q?n6xvc5ieS7y6eEEV8BeTIyqJ06oSdl83V78CNR64CDvqzzPR+fJKNTedJtNE?=
 =?us-ascii?Q?7Rg2LOMvhbKTZhfTfuKpvmk/yfDZMM7Rc0SiN9WoiOqtGwayMZYBP+yxy/Dc?=
 =?us-ascii?Q?qZEqHZWhleqA79voRTkicPZwo5l6NFYXQqHxRRMOzGhU19EDzQV8czIavXTA?=
 =?us-ascii?Q?yHdxNKm1ZnDJzYXCVHhMnlWyXdQwZJVez+YER/kBMcvdAG0u22pz51IYgz5M?=
 =?us-ascii?Q?g1RInSAqzjtRGOS3yIMpOSP2WwFUeyD+FXFDwrtAAZ9qgjI1xcAlNp/weDX0?=
 =?us-ascii?Q?/qD4N8H4DAE8xJgxD7hXQTopubY5EoOmFM1V11M1Az6AuyBMn0qnw3PbnIAu?=
 =?us-ascii?Q?jObSedOTbgHueioGAJQqzYNsR0b0tPQS9UnpzHSn0qZCGjRCDjcF6T9gaG6x?=
 =?us-ascii?Q?rnRVBQFbrMFRQeIwfeJf6lpfJNJqXeTVlMk513LXqp33dGJJEcnkCoH13YvH?=
 =?us-ascii?Q?8c9L88E/2L+xHsmeX4lqT2pWjoyyp16yjdd/ubHSd9JqApwOAOooHdOsIJNl?=
 =?us-ascii?Q?k4kt7kUAGom7hlaqZy2RxkmD/dXb0706+U7wGVCGTAl18u0/qqp50KT2l1/T?=
 =?us-ascii?Q?KGpj/DSH1H6An56Z4r+J6TZgF0LOhjP5zvBV7sBKdlBY645k0pfm4KOAXLFk?=
 =?us-ascii?Q?tmqXi5BJ1DclhAbUEFkCvhnMi1x2IUCG0FELqMYjSoIETtYc1cqHRUTrpE+x?=
 =?us-ascii?Q?jpVjeJcl9G7sDr4isJpRP2/lVeCtX3xPPtRvfBdSDgxvfxJmDVOtt0fY0Sda?=
 =?us-ascii?Q?h6xqQimoAZJCgc+PaUC/EZYvw+erjTMyCqGtbAqICzoK0TAryfIKpjcT8/l1?=
 =?us-ascii?Q?Ac/BJAXag5UD8IsMY30LYzqYx1sVYZjT/71L+iXzdOyYXlgojg3ZllXEf4w0?=
 =?us-ascii?Q?SYIS6/rlUmJYibUz1L9VW0tA2k7FmVF+HoQszJoqG0XyOtbiKbS23DRnwP1N?=
 =?us-ascii?Q?A3ByhfHX5ckZfF7yvFlv7Gv9vfPAZTvM+YcbqjXfzITgAQHVSlXRVF7CuKmZ?=
 =?us-ascii?Q?jiFaOXhsA1wdKMcUP5byGmOpzSkV+fIu9iyZ8IU0AGNyTmbEVlfQQ9MZaSv8?=
 =?us-ascii?Q?yr8kcCgBOeKPcXNS/m0Hb6/5Tvu2y4Z5RX0nqnsuXm2PJ032c7mex4DHwT7W?=
 =?us-ascii?Q?7tSN1bRZpX3hml3IYdqc8r1LrQWK88EusgR1lgfjkqKZT0hqbZF+bTuCchrN?=
 =?us-ascii?Q?h3HFznfeAds8lZ5OrMD6In2SWy9FlpJ9f5eKHfD4HsSqsRRkAVT6cZZPe6Y6?=
 =?us-ascii?Q?C3QxcQN9HWXvznaVEHODISsuGrew/KYFZG6v+emSabJumw3+EchGyaSmj3ZV?=
 =?us-ascii?Q?VWQrR9B2ISOxtNhKFC1LH88unqhnrHnU+sP6da6aS+81L2tDxoNI7QCkrpKC?=
 =?us-ascii?Q?uM/Uqdy1mDAL85R6cqQ2nT6T+J5osR89BGMwD+yFonLlVgRlf1G3L1Ngp6hl?=
 =?us-ascii?Q?eLkYKdTJLmtlPtvyF8TWg8U1k+7ie6Ff5JS7FxN+6hnthuRrV2SaOg1PR5Wr?=
 =?us-ascii?Q?v1uqrRiVP5cxb6g+1yzV4HZ16jJS/XrT2J6427r5JhO9vHpYk/PEVG3Pfd7B?=
 =?us-ascii?Q?NvcEtcnHoL1LyMdoOv9CtIFDRSaKgELy4+F0ZCa6V92Aw4Wh0xhbS1okgQnL?=
 =?us-ascii?Q?muEmJP4pcQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: FTZh47unz0RJx3nHbk3lMiiKYF+jjNkZtrOuHyYG/thyjKMKA+2XKYlSzGvpX8YB0mdsTCQUSCBBWHi8+bL3oTfNdymC5RhXLgG+NO5boYNmf69ZhGRif68+19ikNSx17updjE0QmxQHtHGFbDWuJ8/ZVhxV1YXVJwCdSAT+IpbwwXZkQ4SALft/OT0oJ3TUthdF9NrjFOk1rpYz6zSIWlwj8Dk8zvSURy8yQ1PxC2WfvcPNFZys/a72lDuVZrIjiUeq+rRBULWe76sohgpIYQrP1Bc5BsDGRv0OrWKY11XzAniO1FJlDi7FOz2ADLx4V6dgDV0Szt0GWy7l0cQN+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 644cec3c-075b-4f9b-734b-08deee8588d6
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 21:57:22.9189 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0mJrLaMkg7XoBaGEPv1m89Md9V5hBoFBs7g7Bz5P8r+wqjHLOhe6h1uQ9jWIqWiCyZnZoJ6F8ehJ9H8AjIdu0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7036
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

Hi Dave and Sima,

Here goes drm-intel-fixes with only couple fixes.

Thanks,
Rodrigo.

drm-intel-fixes-2026-07-30:
One DP DSC fix and one HDMI 2.0 fix.
The following changes since commit f5098b6bae761e346ebcd9da7f95622c04733cff:

  Linux 7.2-rc5 (2026-07-26 14:45:48 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-07-30

for you to fetch changes up to 1afb8eaeec44fd011f2b93ccd9fd426d753d963b:

  drm/i915/hdmi: Poll for 200 msec for TMDS_Scrambler_Status (2026-07-30 16:10:01 -0400)

----------------------------------------------------------------
One DP DSC fix and one HDMI 2.0 fix.

----------------------------------------------------------------
Alexander Kaplan (1):
      drm/i915/dp: Ignore the sink's DSC max FRL rate without a PCON DSC encoder

Jerome Tollet (1):
      drm/i915/hdmi: Poll for 200 msec for TMDS_Scrambler_Status

 drivers/gpu/drm/i915/display/intel_ddi.c  |  2 ++
 drivers/gpu/drm/i915/display/intel_dp.c   |  9 ++++++++-
 drivers/gpu/drm/i915/display/intel_hdmi.c | 26 ++++++++++++++++++++++++++
 drivers/gpu/drm/i915/display/intel_hdmi.h |  2 ++
 4 files changed, 38 insertions(+), 1 deletion(-)
