Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97125606A326
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=aRnYM9iQ;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QMrJAcIm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA29610F09C;
	Tue, 24 Nov 2026 20:40:59 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76D5910E8C1;
 Tue, 24 Nov 2026 20:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795552848; x=1827088848;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=TTB69KmFGTWg2JrYC4AeS7+QzadsYSL3Ipv4Gove8ZY=;
 b=aRnYM9iQZboC0ksOS05b8e0Hv7Hqun7jB6Fe3UIzLZCalRHNbO7vwVOq
 XtbNh5OUMkQjBXJCby4JEQ7HGEpsAEUsnJiTmoRlwcd5LvomX3rL77a83
 e8++O8EQnfcMA+OWw51EI6UN6K+NOXABiWqmA3kDJgPoBo5SAma2Hbu6+
 zknYI4MOXDrzUxr6ffLtQF5h/HTY4oTu5eCO4B7sndnCASLL9R5z3Cli6
 htYJO/ElHd0W39j8NNh8JnISDbGOQt93QPHLOd/9FA+FMg8kR4RhDuujM
 HJdyaUy8V4cLyvSARfrHdVWy/tKxqz0ujNz4fTPPUzjWvY1sb9iZ1sQBh Q==;
X-CSE-ConnectionGUID: 5eEfxCSIROWpQf8Uglai4Q==
X-CSE-MsgGUID: FOVLpmfTRHioBPdaW0kLeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4284401"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4284401"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:40:48 -0800
X-CSE-ConnectionGUID: 1Xp47ierRbSLBua0YZzrPQ==
X-CSE-MsgGUID: r8sDnBdSQBy/6kpq88yj7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11955802"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:40:48 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:40:47 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:40:47 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.5) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:40:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Qkb2BheIKVm8b4qpcfVhcWbJRcr/izdALK/WRxX/G0kOb04G2HlO7UmsFCq7O81yjo4TXsR3VTGcIso3XP20RT9tYgUmYT0IKg4Ijx5Sk+BjXWSwf2PnNCLnGhbJwPTwi97RgmG+h/MjsCW/yUhQmf3glxErjeNoVXgZlihi1AEMN2HYUvX5F3xeFYxODejUK1Q3l/KSY/eC7HBnPQtRpPQf9nMBNPuww8kvPkpS4KmSObztNXW8ZG7io3oITOCysZHe5dF5d/eEhsVSjC87q4aRrohjjjxNxsehrZv5BL5LfGYJBAg3LCfyl96+JZz8eFLSvCIeNmFQhlEps1DwTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LW+CT3BSSbG1ZVhTKZ1/W+2+NkfyXmMMA8yjjo2tefE=;
 b=ankB61iX98dJCm9shz9pxzrIOBudyZ542qxJSv0SKkBxbWyz5D4o0P9tAx+2SG8gQ3lJL0cPg/nuY2/hrWHdz+K340yySUBHOnW85Ee0DkcJua1bI2v1gBOqiHqO+B6oBmnz2yk9GFHAnIFZkYKpgVdzKd7nxjVx/9aHXSBttwY3FYpIUcfs5xJJbAtqhpK+XUB2Ah1Dl1mjb8o2I6V4cpMIpC86QdbKqc2qLT6mPcBMxBtTnx9cfPUlzeDsGtsbUXQ6F225TSH3pklAPwWUoEV/ZkFAxdkYBpvjtPGNk+gXX8LoQOQuAZNQgcaEDu7bG1Jc0Z6vVIc/2vf0QGra2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LW+CT3BSSbG1ZVhTKZ1/W+2+NkfyXmMMA8yjjo2tefE=;
 b=QMrJAcImGhj+BsiREqKoLCLJpMktLqsqYhXvtHu6gmmKyFYAmJLqKUUXdUZmdH2TyFVRRCS1oGmQsdS/cyliUEPNSAA4xBmWSVudr00ZY0yU+D2ZMyDBeSCtD40+L06Ug4LdUyAVsHZFw5R784RCamj9hfUre87rw62Ds9BSoe8=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 SJ1PR11MB6249.namprd11.prod.outlook.com (2603:10b6:a03:45a::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.5; Tue, 24 Nov
 2026 20:38:37 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 20:38:37 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v4 0/2] drm/xe: Expose retired VRAM pages via drm-ras
Date: Tue, 24 Nov 2026 15:38:34 -0500
Message-ID: <20261124203833.3618507-4-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0250.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::15) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|SJ1PR11MB6249:EE_
X-MS-Office365-Filtering-Correlation-Id: f4594e3c-9cca-43bf-240c-08df4a6aea80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|366016|6133799003|261009221227099003|261009223027099003|18002099003|56012099006|11063799006|261028144727099003|261102123227099003|261026140227099003|261026121527099003|261021123027099003|261021121427099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info: jyCcfiFpKLO+apSl1gmHyjEswe/xvRpjYs7lHxMc32m1mP0sjz6mzr5Nx9vn5mas8ejgU33WMUPE2I76t10O0qTDBR2eVfEM5sdep+cQSI+l2nyWoHmxmcfyO7gFMtyOJw3ntLmE134ZbG7hkIZvQcloXW60pow7fHENOERKTemCX2mvoSoULRVfNsdbuqCQaz/WVg5Vv1kFrcuVSttnCXCBbl+posQs3YOjG9fesY9G1Y4EyF4TpBfNe1e7Si5WH/O38slfDcGViRYtgTzVDKrON3+mi8S4mMhHKM56RxtxkjPr/5babBSSfoPYS6LNCvuC900GvKYxxZRIIy9kHsk8lWjIhj/eH741gmo5a6gTubHDI6RE+w/c9xDFet9nV2f4o7d7H9d/+KZ7WPesF6em57OjP70uC5LCeL49VawRJR0i8b90ij3IA0t9jIV9HrBlJRA4qSRFTyKCuuyCoZnwpI01UoJKEa5EaOgb33yot9+k9QgMDBW/2VYuMWNI36UyISVCPRO7RrHmkvbX1ZThVXdoE0EwIJfZSIz4T8ebIEmu6hdpsA3BPDrpv6nNXccPTbXt0TAu0sKZtu455bcBL5I0ZVz+6t1XJ0T9gl+BgMhkAv7Ae/Lx2ZhQYLIM
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(6133799003)(261009221227099003)(261009223027099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261102123227099003)(261026140227099003)(261026121527099003)(261021123027099003)(261021121427099003)(261022105027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?D8RjdefM+EGR08VQ8bPISpLzyScC0wGSmQ86bWrEfo5qmxsPiWWk/yflxAUV?=
 =?us-ascii?Q?hnF2Ahl59aW+KxIlmQcdURQCsRtkDVxNntyAF9IAaMxd0efQTX3EVBBEy1rg?=
 =?us-ascii?Q?HdVBrghTzLk3w/SHPnujb7dJpSmshpowSyyfoWJV8kCbE3IwAyVMaqX1twA5?=
 =?us-ascii?Q?kHqRF6fe0kkasdqwrAeCle3T000aH5dUMKfXHr2nb2u09QpyI2aO1JugcYwp?=
 =?us-ascii?Q?ySxYJCXYUNlmuazwh8MNDNCPZc2AWgBjtTN6yTAF8S7OSBDFcnVeph8zrPC7?=
 =?us-ascii?Q?vi6unT6PXGx7K2FoeBvFRg1cwW4UHSQ39NzbNwUC6kICriml3Hme0oziHF3S?=
 =?us-ascii?Q?Bdj/2YH04JFqXECzK3MEYgm+vnAQC6Zd6+h0bA8AQnWo7ueSig5xBXnWIBGm?=
 =?us-ascii?Q?de/WbB9Py+O4OAtzzdfyP75oZHczhe63hILOrKuIU3fmaFyfbCrqgLru+Acn?=
 =?us-ascii?Q?Rx25INaOAe+Zpwzo8jxgvsbDo8rQRtuimj097daeA7NsZDP5L0tIOfJfbjD3?=
 =?us-ascii?Q?taJheCaZGPumd6mfDFiRcNr9ap6ddLQX9RtJj/o5zJFKKvgUmzymcL3hOZFf?=
 =?us-ascii?Q?IhaEj/clwO80+I8xG8yTdsXbnCe25Abhy8KDqI2zypbZENgK8NrHAq4JYLn6?=
 =?us-ascii?Q?ZC4udz3dCLcKKeeuQ1xn+HjoXURXzvz+B1hN3IafE0GrUM2h4ICNBumFbBp1?=
 =?us-ascii?Q?eza8BTbN+nqv5By7aE+ATEhiCpxqEimwp3K4049pEav/xkSdBV0vaIVFzJu2?=
 =?us-ascii?Q?k56w8zmWzuKvwBu9k9a8jtzjT1xq8ZmLzRx7iY8OlvRnZNYBjxyFI+HlA0o6?=
 =?us-ascii?Q?ZGxthoYo7fgEmfWrt0gvpdK4Ng5zifUsq/VK9+HiN+maZ2//pcwxxpHWGPXT?=
 =?us-ascii?Q?i87kiEuFQC26tH/CCYS6wxyPBa09SmCUf4GNsAetwcpw+xYNCq5vnljtBymB?=
 =?us-ascii?Q?vy9L5HcmMbkSrbILLhfOJbCswIwKLp0FZJ06Bq7oM0qwtgUY7+wlzEzOlHUm?=
 =?us-ascii?Q?9GMx9yqoNY7u2QejfhYfftbWHuaGl7h1lhFSwcqDK1uNxzG5dn8oO2n1++Ou?=
 =?us-ascii?Q?kcoS20QYGVLVf+WdWDBK6mOq2oSZvqKKwH6fSWYw+ocOoFxnAfHMIr+i0Q20?=
 =?us-ascii?Q?RRHd7Zg4cih/ddlsJQDWpUirQA7EGAR9Y97hqkS5G+vH5hLXt9HQT3638B2h?=
 =?us-ascii?Q?dnqTY9Ke550mPFolGw4vMITSeyJrcYHtX2lgcxuYbSGmL8fXslUp/9t38xEI?=
 =?us-ascii?Q?lX9ofwCT3qdC/tMb0MivijcJoh9/NmO8S029pvaFLqqRjyDYBiWeEhAfxcs3?=
 =?us-ascii?Q?sVW73jMcLIRwm/+P2iobVfup0+8JM2vT/AymiDGpkjPtcMS85w2SGlczpOs9?=
 =?us-ascii?Q?v9cnLLO3mnBLewHs2RuAJhAmtNisQmCLECA1/wLMCthAVBu+iCIvBb6dSGIG?=
 =?us-ascii?Q?UE1mhVzZHj4Qt31/Jj842fXea+/BqKTPZO9wGHj5Elv87dfROsT3HEXhhRi0?=
 =?us-ascii?Q?jt6HrmuKhssnPUdQywG6qQbqJobk33ZcbCsQkG2h9p4+TfGXjmPoZSvTPdea?=
 =?us-ascii?Q?je6enPTHpITT381nUDlV/JMQLOdfVjkkTyccfa5iRJr6mpyp78xeiCtPzVm+?=
 =?us-ascii?Q?HDiKCLKSTImfN2sXsFVOziOs8glZ8aQAbWseLA2VB11F4e7yudopUdb2sz7t?=
 =?us-ascii?Q?xTwozfvjzD0DVzdNrcsxG2GMKIrqogYMbxihW6VBXsflaA0LjqMdD+wl4j8y?=
 =?us-ascii?Q?CBV67ABgIg=3D=3D?=
X-Exchange-RoutingPolicyChecked: IZUrLYkw9DZHSWtUdu/6HbJQPIlHQSbbImg6gwc3WJentcEUumo0AnqBGHqn8NIA38ce58Skqg0bYWsAU3b72+IUGnmMI2KAsAWtbZaHgXZGk1UQYvcbQ975lglfpGZbcDPmBO2tbRfG6keZnfXfCtb4/CiksA6QwGm1VmWn9wv4wUos5QrgtkIkNt0KcoXwqwBLZZkTie1ZQQG/e0FkjCeo/qLCGvuewC7wyVkoMNOZGgr15PNjn68HeH+Uv+w9sq320zlCpAQrxGY2cX2R2pUlI5Th5mjt8DNMeASLQhQan8hC+blTCaH0yNvwkWuUC/8tBooxsRfYAh2VghorIQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f4594e3c-9cca-43bf-240c-08df4a6aea80
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:38:37.3132 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SrIF5D8jUqmnMAMR/7knjdNaF5JMGoduxqJ7TskmHIl9NWRqu3TSiQEuoVxCRSPmAppKJpiWWOtfi1rpmm0/vQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6249
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

This is v4 of:

https://lore.kernel.org/dri-devel/20261123150806.2266196-4-rodrigo.vivi@intel.com/

It addresses the Sashiko feedback and is now on top of the drm-ras node
reference counting and telemetry series from Zack, already in
drm-misc-next.

The IGT test and tools:
https://lore.kernel.org/igt-dev/20261123145414.2243338-7-rodrigo.vivi@intel.com/T/#t

Thanks,
Rodrigo.

Aravind Iddamsetty (2):
  drm/ras: Add retired-pages node type
  drm/xe: Expose retired VRAM pages via drm-ras

 Documentation/netlink/specs/drm_ras.yaml   |  74 ++++++-
 drivers/gpu/drm/drm_ras.c                  | 226 +++++++++++++++++++--
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
 12 files changed, 528 insertions(+), 21 deletions(-)

-- 
2.56.0

