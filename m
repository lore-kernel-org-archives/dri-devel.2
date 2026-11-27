Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF4CE606A31E
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 18:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZLpx1oTa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C4CD112CE2;
	Fri, 27 Nov 2026 18:18:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBF4D10EADA;
 Fri, 27 Nov 2026 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795803485; x=1827339485;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=rzSJPXqLon95MDa+afbfpKfQyAIGmjZ7wr34XEjSK3M=;
 b=ZLpx1oTal71XnNJPvYPtFWJ9XrMHMU9nFcYtrQMVLNex8MrL9HMP4t/p
 DDq2/GmlE8URKdOFDWkgtv00ecnA/1F/9fOO0Vjw7q433dyMWHJCdixug
 MzRGFGPMW3a19Awd0R7W7DFprd/uw2gikMHCdunwVurhLYm5V7VvNVImT
 WPm6snU5mwHZ3FGIS9LaAgU+GmjH5DW0E3BYSvJTt6WV5g/qQTxOk0onF
 Ex3XBhTUvdtPAAbuE9USJhd9MT8o9wHVsRAaAQD81vKED6k5yGGh+s8zL
 d7DEjHkXTvm0uB1/Q6dqjgWfvRlmwSaSY5ZdV2vHm4aV5t7nfO23xy+dK g==;
X-CSE-ConnectionGUID: pLK3iYn/SxeVD9NjSAzCWQ==
X-CSE-MsgGUID: kX6Cy4ZIRXi3Ey9xvHLahg==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4628738"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4628738"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:18:04 -0800
X-CSE-ConnectionGUID: FJcyBDi1Toi5QYJ75LNwwg==
X-CSE-MsgGUID: bdSwW6/3RP6ZCCsvEnb1cA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12700046"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 10:18:04 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:18:03 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 10:18:03 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.19) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 10:18:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mzSRyEHGqOh1ii2cRgst3Ha4NE+dMwBQFuYPqCB10IoU4VQyUxvTKkdC9tggOjqxm1XjgBSOg0cnyAteRznUTCSKxXqldH5MdUmJA8J3iP9jAUp+jic3TrCBNfBt4x2k+74yTq0yyVQw4Yz12mi+06o17rRNud9xoB6SJTBGhob76/QtmeQWWyOA94a7WCgeUO0Rsywjrp6oiafX/ZuP23DIRntmBIeuJ9qBJNvh5vpaH6J+sh1YzdJVhCio47GGygES9VCgPtt06Re7yjMB0puospfFARJJzwtqg2pdLTb8o+aMgKuNaCOKRZE0CsvvZpxBL3kWCda9LbAjNthtKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/APGmzVrBAe8pUOu/23K2cOw1/jo2xZ8T26ftWAC2pc=;
 b=OrLsUXmD2PWKcx81AX+/HRrKomC59drXCDtY70XvX7GXgiZPef7x6zBrnUchWGvJuv21Mc5LSmsvbZynGBGpX1kJvLzNyRMEurQP/fszxYC97pr+DL10Hu/B6j+j2OR4DbCzrMQD9nioUEEvU4Hi3Ufaug/dirfTmuqxND9VE3fTHcdC+j23QcnUd45OUdltdeee40m17CfoY+0zTTANUHkrfWcTAkKS9OM7Obw3sxUWTIYPorlcaG/rc+gGS7PmeeDahASXI/xZJaMSLGr/fF3MPnwAvUruedzCgkTAiOUCD+hhWcSNDnOpLNbu7CgZLQ8SLzV87J4cg2/PYUcpWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 DS0PR11MB8717.namprd11.prod.outlook.com (2603:10b6:8:1ab::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 18:17:56 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 18:17:56 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v6 0/3] drm/xe: Expose retired VRAM pages via drm-ras
Date: Fri, 27 Nov 2026 13:17:51 -0500
Message-ID: <20261127181750.806528-5-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR05CA0041.namprd05.prod.outlook.com
 (2603:10b6:a03:33f::16) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|DS0PR11MB8717:EE_
X-MS-Office365-Filtering-Correlation-Id: 865aae45-46e1-4f54-06dd-08df4cb2c274
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|56012099006|10067099003|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|261009223027099003|261009221227099003|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: k9bwmgI5P3PToXNg6amr846Okp0igN+A5L1IuGKguk7nu+sdRgqUDKo9h2P6SL3jltRYroqScoYYA76NP7dvroQlaVZ0DOtGX8t0WiKXOuYH602m1FOnswSvcEWp6iqcFY0vOvJvlb7snBgml3D6mgKN0OVUntVcfaz8dnUeFa9VWhHo7v6NaZCQkNyPqdVlzW3JDivMxdt3vjKR6aoHQbK0GA5xyu8EiLMyxmZRqcG4dF234RDgcAcjkKOuU6/pnUxG3L1IcrPgwYQasrk7jpHaeKDi6hFWELre7C4Mn1h45Tr98m1Q6mQ02ysbJZEbvmJyV5XcUV9a2CiwCqx301q3ZM53scjA4P87lJXGTkjOuIz1sN5/3cRkxakaQiga/2+UBBrilnI+YSD0uxYEAVnxJupG3M1mM92Qh2An1BSl5eVealrTJek3Zlfi38D77X5WhwJwgfkVAap0HkDk7ACY2uwGseLmB/ZhbfOV90saZjLFtyPTbhEM6lih/9SbeM974F1sb5vfXRSYkWfBstFU19oJuHEYENjtqioUdJpIxyMDOm1rOup+EllBHJMGV9CAWa1ilu8AjulRtYdBKLssjMGR/W1MDfPzpSHIOGd94NM83YnhGTDdiE32drIr
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(56012099006)(10067099003)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(261009223027099003)(261009221227099003)(18002099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?x8/xnAswyYyIpvVi3Qdi89dKGGNjUydez3R6zOW67ReiGd6/2LAMlrz0Vkde?=
 =?us-ascii?Q?hlfYQKm69Lp+mQT+dgOlCpYr6fdQuq5VmtvSHaL8tmCeFVK29mRsbbmYBktz?=
 =?us-ascii?Q?ld++3G0fRhjSQJ3qMgvhuNwajQb5Jcg7gRhgNRPoQpWSNzAMje+S6iTXV3/n?=
 =?us-ascii?Q?DzrZCLwcoX+tSccQRBejlzwjJMNZOk9hygXvpf5/cOOn9zCvUYM+YcZM6RwA?=
 =?us-ascii?Q?Wfb1gPc7kDnwUntrsHBwqND8JlAzg44t73mu91/UrsbNXyiE3cOt2lH08dSm?=
 =?us-ascii?Q?dB9EK+0hGbBiiXDe1297aNeNkK7qo4xTN6H/SiZRh/AjFYkfaw63Vf+/xr4g?=
 =?us-ascii?Q?SI8H9NEPsrFLTYyh+/WJzp04O8IFqHElMFI+x7CnysE5iI7kQmpUoYm7C+Sm?=
 =?us-ascii?Q?WtffuP7rf/tD/+JvnOFMKIXFsVMY5ZRykVT+apX4sBVOUXPTrJJde1Mjx+Uq?=
 =?us-ascii?Q?j3Gj9ToVNt0ejKofbLfWK60kFbwgRJJ2v+uu6DtQZjpcj68h0oti/KhIDlnl?=
 =?us-ascii?Q?bSRUSh2cr+vkw3HIPNYpxiR4oA27soWlgqsD7ZCECZq40lXQcU29uBSbrG5y?=
 =?us-ascii?Q?tcvWS3CY8VLE8WV7f4/RU9qkKLeYVdcAC8A7QNQpXVhrDWjJgswX9nBIEssb?=
 =?us-ascii?Q?+8LYVfkSOqzn+N6Ki7aRlursQ69H3ocyGzr3leQpSIYlinq9br1dd5xVt1Nw?=
 =?us-ascii?Q?737Qs/WPXnhv95GDmYANM9TVAJSvkcS/W9gaeOw71SR+3deQ3HACuazD6ZuG?=
 =?us-ascii?Q?hXmOCIt2G7JPFMbDuFJfHEctZqbX0fbsYUsypgS3JfxVRypDQeTm9Y3KHDwL?=
 =?us-ascii?Q?5f/LP6GtaliBzqoiF9j6GGMaE6bz8QtzO62IBWXpnucV7Gp7bD/GZRjkVRYZ?=
 =?us-ascii?Q?N5kvWMSk17BbiaRVOM2SeCuaU/y/AbA/yeWBbTEoRiABmgiylFwMmXDJA7CU?=
 =?us-ascii?Q?gyrBSEaBpgz0GPCC4Kp9W1tXtK9OCrRSWV4cwYWWDcYKNvtorDiLgnyukinR?=
 =?us-ascii?Q?wdlCEw/FU00hgkHfZajfF6ovxn50DUzRz2zmDWRCKWBVAT1narccCabmr4F3?=
 =?us-ascii?Q?yX4mIoGrjURwaWO+nb7f6c9FgtU/85oFnSByvySL9r0PW5oRISU68vxbsxxx?=
 =?us-ascii?Q?ReWg5eWvI+r0H0fOtCRmQKUEnmsfpO0zSoukYP1Nebm1wmJnHkrCK3oNM4Hv?=
 =?us-ascii?Q?9VtDwG4Kppgjj+nRxuCi5N8S0WMXlYnJ0JXBAZZZVib5b3vVyKdWfQaGQEO8?=
 =?us-ascii?Q?3bMmdbM0tBgYAipbPyYFgBMbTc4ZIlpW+1x7+kzh5C/AO0DR1aODyg1wMqVo?=
 =?us-ascii?Q?EsFyhRAnJlBN/2QAB4uA7qAYE02zIiO3iQZGQJmPz2P4hUz1ZLrVkjWlFXvq?=
 =?us-ascii?Q?lmNc50ydhXimCeAbIKcnYDI30n8uS/mU6ZjVTa/+9WcjEXf2o3sph1UygeaX?=
 =?us-ascii?Q?wJhl5gpZZYAr+SKcMDjQGMAOWdEioMuzhf2Gd4T86QFJGtKCod+qOvXrDHEX?=
 =?us-ascii?Q?BG450R9sd0hX+1/wIdDHrVBen4jpdyMG81p0FoAEsk3YE+ftAMzeYDa1K190?=
 =?us-ascii?Q?pAVvFEEaIWtJeiFYsXGIvJsCYv7P2vrnKoHEyMkffuSXgDCYeYp5dYYKVSQb?=
 =?us-ascii?Q?Vid3AtTjVErOzGNv7qfkPnPs11HQIcOR609xC/LLbfDwj9PxGUkx3tOoJRzF?=
 =?us-ascii?Q?OJog/fJ/IOqNfY6V8Qpkj3glVGpfcRU2cZhhqaQ53EB+I8PDKdesOHvenDaD?=
 =?us-ascii?Q?11vUc7P5Bg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ha4t0XAWkBB6L1aCbKoGeP5dGaMB7qF/8OZzvnYIZJ+b0h4rlMlxLU5eflIygr/AnSMQYsPEu7QBenK4XKOChfXfewlwwlPecq0ZiXa6MeRkhELZYasdJ1v+2t8FqOaGGzSqKeoszNRCkwDy6boLHL8CwciXtWjPxFdMLObvwVqfaBHjZG4i9/XaMcLoQZ6QH4WMiN3FKLtWU3VVuTaFFkPJ4vpIVB+glvY3NhYsmsLcylSm34F/KqsMjPB6L1CjQin+cYCaRoI59l5tHgQXqPOIy2LLZi5lgriB8P1eZ5+eZDd85zOI2N8njcqCnwN8YTorvil+AWIy/LqLal6xRQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 865aae45-46e1-4f54-06dd-08df4cb2c274
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 18:17:56.1852 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCjc6bkQlTanucfHj/Oxg31YggWeNVXITVX5LQvjDUKjxwVvwX8pULTu70o06c63rJuKfjRlIRMwbaGtAqHLUQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8717
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

This is v6 of:

https://lore.kernel.org/dri-devel/20261125190249.156217-4-rodrigo.vivi@intel.com/

It addresses Riana's review: the type check of drm_ras_node_get() is
now its own patch, and the snapshot for the dump is folded into
Aravind's patches.

The IGT test and tools:
https://lore.kernel.org/igt-dev/20261127181133.801215-10-rodrigo.vivi@intel.com/T/#t

Thanks,
Rodrigo.

Aravind Iddamsetty (2):
  drm/ras: Add retired-pages node type
  drm/xe: Expose retired VRAM pages via drm-ras

Rodrigo Vivi (1):
  drm/ras: Check the node type in node lookups

 Documentation/netlink/specs/drm_ras.yaml |  78 ++++++-
 drivers/gpu/drm/drm_ras.c                | 282 +++++++++++++++++++++--
 drivers/gpu/drm/drm_ras_nl.c             |  26 +++
 drivers/gpu/drm/drm_ras_nl.h             |   6 +
 drivers/gpu/drm/xe/xe_drm_ras.c          |  78 +++++++
 drivers/gpu/drm/xe/xe_drm_ras.h          |   1 +
 drivers/gpu/drm/xe/xe_ras.c              |   2 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c     |  58 +++++
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h     |   2 +
 include/drm/drm_ras.h                    |  68 ++++++
 include/uapi/drm/drm_ras.h               |  34 ++-
 11 files changed, 611 insertions(+), 24 deletions(-)

-- 
2.56.0

