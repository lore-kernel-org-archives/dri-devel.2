Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46360606A31A
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:12:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=K70XmwQf;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Eo0Q2d45
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 87EAE10E766;
	Mon, 23 Nov 2026 15:12:08 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CD6A010E36D;
 Mon, 23 Nov 2026 15:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795446717; x=1826982717;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=4sIWBd7vhGr1wdqUYcF7zQPtoYIKsMBSjDxuE5oxosg=;
 b=K70XmwQfhFcqgfgKZp1sqgj58a89TMgu+5tGWek8RMaIoA+bAleOP5Ry
 LGDbTTNkbwyai+PTiP0kE9R8peJB+hYplZ03q/x3ILOmtUAZ4jFXaZTQk
 EGSCQA41vePVamuEL8oIEj/THZRMfXIowMWgOyR+ZZZw5ptEoi3lXtAxi
 x/i3xlpeLvDXp4TOc6nMZ8IHPcOHwaYw7Mzbn77+x4IK6TbjMmK6ZklAW
 hutc4MkbTkWhxW6IqSvm+s13KMdSV6bzJ5Ee4BGRZyXU4YJRlA6dzDqh+
 JZ7op65LYeQm5rCPbcCCkbGT5tMccm5EDi1f33KrQ5fmZcJGAhahJOcQt A==;
X-CSE-ConnectionGUID: icIn5KkoTXSQsdc0Dbl92Q==
X-CSE-MsgGUID: DFIVdGuHTSmPwJnHCKt5/A==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4094953"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4094953"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 07:11:31 -0800
X-CSE-ConnectionGUID: 7Ks5BsoBRe6kesdBxLCZ7Q==
X-CSE-MsgGUID: LfnGe0siRcy0vHdZVX3Xzw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="13306286"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 07:08:19 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 07:08:18 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 07:08:18 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.60) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 07:08:18 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A+hfOllJqikgeoNOFtOmoKGoxAby5eVW5hRaXZ0xXem+FY8K8DRZH/RbRbXub7UEu5/qd0UchJAimyGfDUT2vLro2v3p5AIzva3kH37GNNdzQx6+HwJU1Tqz5MeXvxKizjqwInW5y7C3EUCViwjYmWa/xbR2gIeZKaewC0MOXeaWETUeXu9FJ4GjydJwGtz42kGZImsGmFgGmFDKZ+CfektWM/Uyk7KE+VS1Y3Z/9DQiPrpQrchih+n0FKeZlY3dXwe+gaFZ9SgB9FCRNZhBKnYbBQ36ieTsVkg6so9/kp+XDjkSsxrJf3451Sx4WDDaAfeqOzjXCQuG8Bx3eOkDdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8JaWt03CRTkFq5UmjQZbwzxAvDkib90XGUSP+J5GEmo=;
 b=uu3n88eX9i8qyJId5cx+Ean9ijgnSk8vnx1V4C5NeTFlKNMHUoaUvo0QlYE8Dr9yTjOmv6RicFNK1mwzUgtkf9/q7mERZGK5zK4nedAqty18T/INxPpqOg0uPa1+FQGme7lzYHESeNFlE8xyjiFYJJ1fdtuv7hOpUesy6PrPMjdrVqS5iHK2o3xwQMdq7MAUAf4lOYX0O2cZ2M9Y1a6JwRooYB7phEzbZMNmyPerGs9I3GoT95P8W6x6ioa60LLqO2TqgmTJMcMoyWaoBd3/fpxzN34w4U6NbjTKtdlRqcy78Q4hCYvBMUAx3/bbd6WQ7MrGKtRHcsJ9hwTEKonOlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8JaWt03CRTkFq5UmjQZbwzxAvDkib90XGUSP+J5GEmo=;
 b=Eo0Q2d45mUeh6emBVW3tIdFYuoAWDzT/NxgR6hi1Ta2+aKvTgMQ6/gfHoYA7ITqFNSYF1XAA7HhH1GNPKlj9uyP8VtsAuAN2cqARkgByNnZ07hdtYCR4XtKUChZkWl4IsU/IB1cM2FNdtfDsXxFK1saAk/nnStGJY77SRpUnPMo=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SN7PR11MB7419.namprd11.prod.outlook.com (2603:10b6:806:34d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 15:08:11 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 15:08:11 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v3 0/2] drm/xe: Expose retired VRAM pages via drm-ras
Date: Mon, 23 Nov 2026 10:08:07 -0500
Message-ID: <20261123150806.2266196-4-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2P220CA0014.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:5da::14) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SN7PR11MB7419:EE_
X-MS-Office365-Filtering-Correlation-Id: feaecb14-b2d2-4e4b-a0eb-08df497396e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261009221227099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 8fCRkVAmaVbtcEvMBiOTyFjKOCBGo9Hib+cOlcXh4bDLMCseNrb2jaswSF/3SLNxmazXiW/LWr5s+IvgShdFBmVme6IibjfnjPcP9dTgg/5jUmvbG758EEDJaY+89IKz/pgZ8WhzBu1vgmuWz/904xJV5TNK175nQukH+Ib8R3xIezIKI8JWJ0yqMDhoHJCc222IN/MzDoj07b7QLgGWW0WtRP3DPEWmvgCSmctauZFMVAsiqFNsUYqAYNBX+cRtxB8wQlQP//Uk08MXh5ngwy++tmSNYLdPoK+7v3BqEuf7wdullFcdvARVgpK5NwfNdFkCtwfZh2Rq2QtfLp592sX+Yrlmo4WT9Pajdy2S3qBdorT1t4AMksrL7cI456vyh9NqsutZQ034MXegd2s2f0iIP3rIcOTdpcNHVQwyvhnWDNZdANs3A7fvKlA4Q8klo15FMPU/B5FDjn8pRp14WoyL5VmU18qbNEaX1XzpF1RCk7EuZN0V9yw8QT5N1ifeNA9x2okYnXWSsST3HX7qnAInnJzeXswdjA/nsbangFqp8qOkGh9kwqRgJXyQKBziL2I95J6pAU6KkgahCjpsjqNuFLAEFOtkOKGBcPaRBkVi673q9ob54ohRmV+e2uVs
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261009221227099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dcCM9+BChXktdWRseNzvEM9C4xtZDcEk1GEIoEjDdr6J56MTzCDa8G1Qdy28?=
 =?us-ascii?Q?K10SRKn0Llz1xqVZxh8lgyemKGpwYlmt4LzUWUCC5lSOKSwVXFDgGKLEAE+0?=
 =?us-ascii?Q?kjBdnK0mqjYFdUQ5ufM4c2io3ObqaSKLy17S1dQ8oyafjS2Q01a95JnLFQI5?=
 =?us-ascii?Q?A0hDRVat+MrMCN6CMpos5dp3BDiNA2IR8JCDITFbfZhFnh2gByS9A2zd2kYF?=
 =?us-ascii?Q?/f5pDCzUfqS8Vs/bqMXr0QVnyLdnKpc3HZtwvUUX99nGyuOOTXT7dSRSLpQa?=
 =?us-ascii?Q?7EKXGH8SX8A+vV7zpWbJ+pkyEDibXlVAZhvdAHDkwPu4KRZTn8niHabRgFM3?=
 =?us-ascii?Q?Mf1u1MLyFqin8lprftp5MwzKD++zM/ksG1OHfTJKF7JfNjHKnFcBPkdtOHtp?=
 =?us-ascii?Q?FZ7hsm7zwd/GPTxOqZuNK3seUuEeFE1Nt3F9xybze4x4/0wOQY1dIaprdDN+?=
 =?us-ascii?Q?S6mmnyP3rFQBzQ3fw0tBAsJnX/Sf4XL0MVLoPIsLFcxQaWG9VOHSaeUa5SqD?=
 =?us-ascii?Q?0f4xtU5yGoVGIfro0+bSBY9dJREXTQihKSyjSoqw4K4bXQSzjI49QviLVAwg?=
 =?us-ascii?Q?JlIp3f2JxxcbGE8QQkDPLcS6FhUxMfzWDaLnqRgaW7I6S2miyPDqt6poYfLw?=
 =?us-ascii?Q?AigiuQznIpm/49e7POdftMVAuNuyWQgz9PON9ggz7VIdmiCCgD89BVhXu8H/?=
 =?us-ascii?Q?Xus2iCp6xfeoAgfqIcUyks6C9EwE377gSbXSOaWN3D6RDRQo/s47ySa0y+pU?=
 =?us-ascii?Q?SHa1F0PGQHwxAeZEjQqoRWlrOpoSIa6hBWeuRRRUr0Gr7EAJx5KaLkkkq/Zo?=
 =?us-ascii?Q?jWaoGfQaJ9uSC02xPHru0VgLRVu44Fzq3fJSpIy3c21tyBt1amBQlzuE8gPH?=
 =?us-ascii?Q?xfTZBF60aazyOY74oQn0OLrPAUbim1I9AIskdrPaZsVIEDSYYrnlqrOmOjT4?=
 =?us-ascii?Q?k+LCRfhYjxFjaRkciFXTjBXY5mPBCx3rai8Btf7keHfSmar/PoNz5Gs1phCs?=
 =?us-ascii?Q?ofP7XNMXWcgZYuAYvo0zd0hQOvwGXQtUpbQH3T8jOjIj5PkP4wE6TqK1IjmY?=
 =?us-ascii?Q?KPTGItVDRT0hERXSMqEBcIXCi2uhXJ1ZifNqJ2qeXp3iX5xf6/swqeJytisC?=
 =?us-ascii?Q?8ZUBqgbtn9e0AsIX5OQecLyDutBhNGO+cKpsdkkVr4KQ/8RjGO40vofh8slJ?=
 =?us-ascii?Q?5mtKDK0YHFZl+XcMMbCS9j4g8dIGL8LZL3Bnsb6HUoTYKAniP3YA2bLnoqba?=
 =?us-ascii?Q?4hQQwRNwNfvYGJh5g5rnSOYKY8bvsAugaPTMFFlZxxWdd23ZtNghukAdj1Z7?=
 =?us-ascii?Q?UwPUS0fr727v7A3tq2Y1b9luVj0GfKGKcSM2zgQpd3S6Dvjw/J5tDTJzOzI+?=
 =?us-ascii?Q?GJI5fY6cfsQmiGp1slJrzs6k4xV/K2zXIRo8vyiGkcNdpDpCYZCjAuYJ7WMX?=
 =?us-ascii?Q?LYa85ja7XgQs0qeLNhKaI2I6DvnpV8SBXcXbj5jiOHgYGX9Bq7b1orubqgMN?=
 =?us-ascii?Q?gppcZpE5z+4SVTu9IarqUL/4o+070QumocAa+Nf8Y5NYInl7yl3OMBVRS84J?=
 =?us-ascii?Q?uLyRu8v48jCz/knTBFc0wwst8nEvB2CmDd+Y25ZenWI9U5t8WSP6c55lZwj8?=
 =?us-ascii?Q?PKzo4fbkCSsYbZpYxH5fO+32eybHufotbimyo9uSuFMps4jzZIaesDurRZM1?=
 =?us-ascii?Q?FCtTuhzu0+C/86hDTsWYMTBy8uS2r2dTTeQYVDIMs5AEYZwa5stMf8+5lQUZ?=
 =?us-ascii?Q?zP87oi3V9w=3D=3D?=
X-Exchange-RoutingPolicyChecked: NIx2iZOakoUABJBCzvvrqkhIaMqu6UsUFVdCjt3tz+29DdlBakt8hV5WyJQ5KJd50GlTRfSy1Hbzi9JOVrLzNmXtPH2yY3W/ADIIA2qFpxjyquXZU75oxnM5o7h80b3jLLQ4BjaYOIal9Vt3/lzccwwB1c9LsRS4QsFup6ke4414jL/HYVHj/b/dx5/G8TCh/AR4JcQGSG2Rsa3oSO9IY8eBzznxkSPQqmpc8daTHCoy2Kdxh3eQzAx2mCSi13DsUMz9GhUA4hUODWddeoOogODRd7tGOuKyfDpKO+ulUlsqAVAmcW9LaaAUcy8faIinm2x8oFuUhF3G0TIycTesNA==
X-MS-Exchange-CrossTenant-Network-Message-Id: feaecb14-b2d2-4e4b-a0eb-08df497396e0
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 15:08:11.2657 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c5rE1hH3Huxw4Eqx5Po5MCLbK1FumNQIugpDRwa483pfY/RplGnxBIbeUxzKLcfq3hItWV+AJQjnAQ37K/RidQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7419
X-OriginatorOrg: intel.com
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is v3 of:

https://lore.kernel.org/dri-devel/20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com/

It addresses all the netlink review-prompts and reduces the unused layer to solve
Jacob's anti-pattern concern.

The IGT test and tools are also done:
https://lore.kernel.org/igt-dev/20261123145414.2243338-7-rodrigo.vivi@intel.com/T/#t

Thanks,
Rodrigo.

Aravind Iddamsetty (2):
  drm/ras: Add retired-pages node type
  drm/xe: Expose retired VRAM pages via drm-ras

 Documentation/netlink/specs/drm_ras.yaml   |  75 ++++++++-
 drivers/gpu/drm/drm_ras.c                  | 179 ++++++++++++++++++++-
 drivers/gpu/drm/drm_ras_nl.c               |  24 +++
 drivers/gpu/drm/drm_ras_nl.h               |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c            |  56 +++++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       |  72 ++++++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h       |   3 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |   5 +
 include/drm/drm_ras.h                      |  48 ++++++
 include/uapi/drm/drm_ras.h                 |  31 +++-
 10 files changed, 482 insertions(+), 15 deletions(-)

-- 
2.56.0

