Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3565606A31E
	for <dri-devel@archiver.kernel.org>; Wed, 25 Nov 2026 19:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bqOTZ9E4;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=LhP1rLlU
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1B2D510E2D9;
	Wed, 25 Nov 2026 19:16:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0C7A910E2D9;
 Wed, 25 Nov 2026 19:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795634203; x=1827170203;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=AL5DcgywenydNrxX1lojesyttzGE+1FfkKZhhvAvG9A=;
 b=bqOTZ9E4+gHiLRI0jW/uyIXdxZrakYaddSXtS9jgVxkSLtheKRvMdzux
 qmJkIzeCRMrlAjgQdQDXSllgYJQuqV3zR+zbyDNdeLmtsQX7VH4pUsgiL
 aR6pDdYk7N7rBEWkZ8hTcOREi10NZhgMINIgDt5psHYoh0naGsnd06EXr
 3gn1cu7jv6+zbDEb4o4SpaiGkKnBlTl8OYJo5+HOfGmnQGigdOguCmQUR
 OuUvxB/nnkEU4ve6KyYnL55I717GzQrtl80retWUwlkEtd42yD1OFWbP2
 mQRnvSFi9c4klchpboulFrdxVfSO79yWktEzqTdN7k1PhKaPrvBy65UVF A==;
X-CSE-ConnectionGUID: yT9Za2WISjO9SZC4pZWmHA==
X-CSE-MsgGUID: t6tz5Ru7R3Samp0gFP7WSg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4431457"
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; 
   d="scan'208";a="4431457"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 11:02:59 -0800
X-CSE-ConnectionGUID: ZcwAT4S8TJqiMIGoShbcZw==
X-CSE-MsgGUID: pc23fsdFT7SVvxpQhf+DKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,233,1787036400"; d="scan'208";a="12059906"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 11:02:58 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 11:02:58 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 11:02:58 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.53) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 11:02:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nO+wQbl6rPdeJqdXBX882xnA/FEMYPH3RRPgkGUgmmfZt1NBWrl52Bxa9A9C6kyktQs1uTpBoOQlvLaMfJ3U60GpeBgnZTbsb8zSuSTDw3+IFTMpSM3EOLElyHaDSiwmovzMShYqgjto3sDzmhkVDfAovmGmbbrI06QN7xWPPAvrEfeBTeJX3MLTuQzA46aWwh/VvGgTdx4xnKDv5MQw4Gb+IBUxqWhm1pxTCKVw0AUBzh2KnMAoxtiMcw6ZPbM7aV3yGdLp808WAY3MngCqklPWEcsx20ZQYBs5X+EH81PSDI6unUy14mxfxBWpl2tmP3Ifh/A5LYGGsoSnOkrkhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ldKFerCrB/VGkTXmQsCimptCp9ul/OUm7jmHOGZpvwk=;
 b=egtGSurP1J1kyTEkfGb9A4NMNJulBgvbCAZUKZEaoaIG/qnBc/r0NI+ejDHMeDq5RfE7RS8Ru0OTRTWdSlC8hh2MEC2RM2y1GMVoPrHZrpasH+t/NgkeKcle1L9M/I0Dyvi3VIbt4dhfriRUFiQ8j9o3VxTZ2v71mWzeD+Jcb0RzrKlyZDqCNgE46VuQrLt23JBTeGX1SVFsfz0eicZPWPH5qoA+6H1QjuD/Jmn+lb7MFXtZCBD5cAMvSvQRMTUqjkL53uOo79icqXzi89MEI8aNOAbSon+07Q0hhJHpkIu+N/Md/jvmjF0P2IKrJrJhzSgQ3JDb+MZmjXsMZHOKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ldKFerCrB/VGkTXmQsCimptCp9ul/OUm7jmHOGZpvwk=;
 b=LhP1rLlUI3+xj8QPqlTY12qoyWxoLncwor7/e+hFh8AvyELBHMI7mBijminCJ3jYTsMjWs+GWyInfmuo98DFwEFZSdNrzV3mHPKd2N+Eo8Z/qce90SShoeIBkMiMngCbthMZnYVdB9Me+RKIq/O3CUvnqriqAgUkOVPc5xsfIIk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SN7PR11MB8109.namprd11.prod.outlook.com (2603:10b6:806:2e0::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Wed, 25 Nov
 2026 19:02:55 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Wed, 25 Nov 2026
 19:02:55 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v5 0/2] drm/xe: Expose retired VRAM pages via drm-ras
Date: Wed, 25 Nov 2026 14:02:50 -0500
Message-ID: <20261125190249.156217-4-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0122.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::7) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SN7PR11MB8109:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f656186-7bd7-46f7-2847-08df4b26b687
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|261021121427099003|10067099003|261102123227099003|11063799006|56012099006|261022075727099003|261022105027099003|261026121527099003|261021123027099003|261026140227099003|261028144727099003|261009221227099003|261009223027099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: wziPZQfhQdIr6unJJEG0CfT7pmZ8mSwwlRbINjTEf0ZjddChDuxOlxLysWTaoexRJoZXphSSA+gnYQUzygLeEYaW8hdEx4xf3fIl/6q1Jzp6oMLvuA+I9TpqUYzY1+q2TtD6Wt1YDzfHixEk52R08P2cR7eh5VhPp7OwmPUwrLjIM0KEqLjPu3tZO2PA4WMY/F8JHNsa5QSv8jRU2SRbVQSkHugupwAIahlytDUMbSyGoWGLibrMGpFOY5VSS2iVKTKMlsAjwmADqrgOQHTidMzua2eT99ligLJ8e/GR9jCHHAmwWlZ/inw1G5KMjLY+Zi2LErSV9QrnSTMl+oMm++DcNyqEKMV0WLN9qjfyOZTQqkdccZnAjv4a0k9h7TvHFqWjzrDmBrujkwH/UZJtjM/XIHjYrerWyjiL91DQS9cqn71Qjcxorymwaj0j4klcdrLUs9Fd6Jyi4aN2igycFx8H55r9DkKR9kDQWg4u53dYsPeNi7vBypaU31DegCnZLpDHp1aW6q4IIPFuzfe6DfakV9ZZ2+ZDC9Bovg+glW6rVoai3XHT0NfUgqTDu6J1l3KdkyIyFi1NQFK4DfVquyDBQL8AZoNBUjrkgu5kKMbk1ZB2ocPgNFWpXGNeYhWl
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(56012099006)(261022075727099003)(261022105027099003)(261026121527099003)(261021123027099003)(261026140227099003)(261028144727099003)(261009221227099003)(261009223027099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L2oBIW/OKd2WXyv036Re7maJ+4CxAzSSFsZa+AZHMaejPHbmSENI227xRnHJ?=
 =?us-ascii?Q?ap9UgYOWnMn1DYsiU+rfTpowSlvYSHKv278CJdhtAbrV0qbJGhPkfPY80Eqa?=
 =?us-ascii?Q?Hlzx6tG4qmZnpvJ+JxhcPjx6Me6Mf21z6uUdzhUaP5OKfu+HUUM+iM9x8vKA?=
 =?us-ascii?Q?qgVvNlL58UGQFuxRqow3ma1iUVZfJOkWmp+/H8kfYJLtE2ZrmhqVl5Fa3gEx?=
 =?us-ascii?Q?8M5kngsTrBiT0nFxYv1UF+/6cHvxyTZaXwYHY9HxZ38o7yxOu2e5VWmJhdLt?=
 =?us-ascii?Q?ByzwQS5REyAjfBhHrtM8M9SyGWtEzvvFZX6O511bWtRw01dxhiojUyeCQFKE?=
 =?us-ascii?Q?6fXZVePy4L9Kz5krq0UXU1GgihChvzaq0YI8CDmTVtAV+DEZ0jmwmmzpeA5T?=
 =?us-ascii?Q?Uvq84tOFrzmLtGSpKiCqHVmnawxQMkBQfVTUEfC8QuB12uMs9FSFjyzwkxL3?=
 =?us-ascii?Q?4tuMSESzHQYxL+SiFmjJncEoax3l1CgYbynzBXuS5ziU27YKdti0L0KTB62B?=
 =?us-ascii?Q?RHzDZXf8gf/qns/l2RRsqJKbDWJH2uNq6gsz+YxEzuLUiur5HVCf4G3m8KhE?=
 =?us-ascii?Q?AgKBHnPapHujZESdHU5FMAvOxWDiWvlpGcJm71iSf9/CqIyPG0t50qIpWvKU?=
 =?us-ascii?Q?KIb2DP+7zCQBa6c9rV+W8HHxk0XOApuIkBIGA3LmWAElGa4ujJIhhPlO6UeA?=
 =?us-ascii?Q?HLSAJKWAHH7EGPKWxF44khkSuPs32k9q6BtrhV/NLloSsyQOqq0Fms/PLCPf?=
 =?us-ascii?Q?0jShediEdkr5maDp68BlGm8TTf2yePYUwjMzJ0Di8GRryIhX9bHRNafVrNIa?=
 =?us-ascii?Q?tALgIhI748FIgmDM3X7WqzhRaO9w6sXJvoOcfEWRrM+c/XN3gx7jAkzbWfKs?=
 =?us-ascii?Q?gkERHYnagoAUQFPEEmaOcD+3FEm4Q4h05k0bp1Y5wFjGG6QayJexBw/OH43U?=
 =?us-ascii?Q?WZ2P7GSMSl07Skgb7eMBpiSw3GkSp6zuzDucIXFmXovOxnIFqY67ClEJZEHY?=
 =?us-ascii?Q?JgDlyGkNVaU+qwdbfyNXNKMNC0E+VEa/ZB3Xr6j/oas2gMskv7hGOE86bhJd?=
 =?us-ascii?Q?svnlcqGg4jUbqOuw6HsWwGyl0jCo7gdPmtnvDiBo+mqNF6SAUbSpKODFrgQK?=
 =?us-ascii?Q?BIZGMK4kgFqiGlbD1jVluuTNYr/QHfLf3XwaGO8B9bTOBOyHZxUF74rY52+C?=
 =?us-ascii?Q?jyCdhgZcdANYEVU+ydyqQCKb4VVUWRW4QOzJlbqvVmiwpEGjb1gJMAAssXOA?=
 =?us-ascii?Q?vKEYeb/J+XIrYC15L7eq4T64S9VckGbXMK5Bwp3MaLmtpz4R0YgzPIRy7Q3R?=
 =?us-ascii?Q?lHbHTVFOXUqQrdvJn1oL6NSNqiNWg084ookdMoovAnDgznWh3tEcrImtysZZ?=
 =?us-ascii?Q?xsSdBnjaI5gJmuHOY2GAULlXpH4jzGXb/PiBt5n1fV0G/nHTf2pqFFyOgb8x?=
 =?us-ascii?Q?edFmtPGYB4jy1wKZHXxQj782Noix+qxBdJwsXm6wJlcYeJApywzTEI25ETXS?=
 =?us-ascii?Q?V9100FnC4HbPEcfjFNds/UtHBedeVUKw31YQzZQ+F/dImsHSn+9mb9ga8q0s?=
 =?us-ascii?Q?Qojsf+EjfSVPBDrUR3czR778D/FOG1kYJmGLfC7B8KVSDROemg03qFsO+S/j?=
 =?us-ascii?Q?yh0NKhsg++EAICFe44l0xQCQDlQK6rOgHPJPUkQr6TZd2ihagKqBlNeiQUtd?=
 =?us-ascii?Q?RXMXTW3QRaNXB2n9xLGoTfLfl9UAh6F3qt7mBcJb+s/NRTMMl1XCt+C4pQ0D?=
 =?us-ascii?Q?dpEdj56Law=3D=3D?=
X-Exchange-RoutingPolicyChecked: bvKDcUsx5xsecMpucbRj16RoLN8hJjaAPCNrlQz2/uCfuWO0YY9RtYfrtYdXuuaJqeF71lI5+QCVWCDNCjG7lHJN114QmVCzpV0nt5Few1O1JM9UHdTouLbUz3zMdszjWD5+IU1mLvxzNCcjxWxdWf1xe/Z0WwsYjZlDMvaKxKmacZ6Z/Ed6vgoE5pqS/IGDxnIoHfwZ1Tr8NDr0xHkeWVMvPZqEZjxAXp3Qq33PZqW8JM6CI6IMTXTCh/DPhZLfQ3IkjLxIJdFdsGwSLivAjX6Q0IGadLB/gUrO2Gs9qEwqg4v3r6TdS00X/S0AE3QZ9TmOQua4VNjclhlfxmFYug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f656186-7bd7-46f7-2847-08df4b26b687
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 19:02:55.4820 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO7GPXa52p/DupUBZnow/kcOSO3db2E1anIYarxSLPvt12L0tL8OkGrx6SGI2KVx74XiPEk1Ww4HAZmDIOvYPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB8109
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
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This is v5 of:

https://lore.kernel.org/dri-devel/20261124203833.3618507-4-rodrigo.vivi@intel.com/

It addresses Riana's review: node-id is dropped from the dump entries,
and the clear-error-counter doit and the new handlers follow the same
style.

The IGT test and tools:
https://lore.kernel.org/igt-dev/20261124213532.3674338-10-rodrigo.vivi@intel.com/T/#t

Thanks,
Rodrigo.

Aravind Iddamsetty (2):
  drm/ras: Add retired-pages node type
  drm/xe: Expose retired VRAM pages via drm-ras

 Documentation/netlink/specs/drm_ras.yaml   |  73 ++++++-
 drivers/gpu/drm/drm_ras.c                  | 228 +++++++++++++++++++--
 drivers/gpu/drm/drm_ras_nl.c               |  24 +++
 drivers/gpu/drm/drm_ras_nl.h               |   4 +
 drivers/gpu/drm/xe/xe_drm_ras.c            |  56 +++++
 drivers/gpu/drm/xe/xe_drm_ras.h            |   1 +
 drivers/gpu/drm/xe/xe_ras.c                |   4 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.c       |  72 ++++++-
 drivers/gpu/drm/xe/xe_ttm_vram_mgr.h       |   3 +
 drivers/gpu/drm/xe/xe_ttm_vram_mgr_types.h |   5 +
 include/drm/drm_ras.h                      |  49 +++++
 include/uapi/drm/drm_ras.h                 |  31 ++-
 12 files changed, 525 insertions(+), 25 deletions(-)

-- 
2.56.0

