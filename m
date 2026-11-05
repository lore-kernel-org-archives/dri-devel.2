Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0F6606A326
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RRI5JwQj
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B626F112108;
	Thu,  5 Nov 2026 07:14:46 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7A91511210B;
 Thu,  5 Nov 2026 07:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793862881; x=1825398881;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=faqLKCGT/dw196o9gD7uaE7Ju07VxGvVZIEtoKG0jM4=;
 b=RRI5JwQj3sTNAyuHOrMcR+zJhduWe5uftsHIq71xR1kyuOtRlssn5KAT
 Cr766jUcOmG569ZKi2gkNsjlAEVuDsbIaTvqYu51v+6oiv2nP3EnH1SaI
 jZ5vm3r/QDd1r39xlav09+6cH61ok/Yiegy/8ibeKxDJmW5DHl8guAQmq
 pFLR3m2vbH5sC51mSEPpoVKJfsSdyZ+IJNNBhoBG/RwJ6j/CEqRqwd8x6
 Ok679z/VSM5sF9+/ZoE+6RxLVYSF+hYD6WKu1d3J9K73gN3XJBRNNao4e
 fK7ACJX6LdwicE6mq24s8sEj8FLnqlJ1Z8Nrpir8YQzi0akHNNjKcXiTb w==;
X-CSE-ConnectionGUID: 68X4dn6GTVaQBKSsS5s2bg==
X-CSE-MsgGUID: Tzo5rqjOR5y/v77YZix15A==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2675180"
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="2675180"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 23:14:40 -0800
X-CSE-ConnectionGUID: aAkvFgyMTsmFBGTPYDSO6A==
X-CSE-MsgGUID: LDi2h0PPT7if/1HtDA/3iQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,196,1787036400"; 
   d="scan'208";a="7262051"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 23:14:40 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 23:14:39 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 23:14:39 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.49)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 23:14:39 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J8CAl7MPdax9dtjk5RqZ9QGSk1k0srT1s9kbhSUEQ7zoNCNxCP4ZWF0Hv+wGGX+xbyZkreDDh8wpOBYFj/+4sUvzZ6agupIkIazky/jnlnjxVdD05nMRux39in9pXMzjlxN1V8TaENGoS18QwolSeMjjygNMIhVsnzI3fRoeTMixQtoGe1a+yicRALvXvepnORvy/JGsAlfTih0Ufph2uT7JgJW18mOJhiktKOq97RUTEpLJ9avN/g5tcgiPwI7W0uvUzHixoESNls7Y/3ZEjRaUUszKTW04mjcU2xszoyjDG2mw0RspQogw6AtGX4edbsD5Szrmn4+jBlCHBORMeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dnJYB8Xo2BEXYkWtnO8XOTf44VZ79CBUbhYpWrwYPPQ=;
 b=YQPKtYkY5f/ohxZss9H9EXu8bhkfhxcw1s8SnC76HQJyofrSIjy0OAcuPZJp/ATvGuZt/8gYDZL5rim1P03mXQuck63ZL2phsKRpXHmDVTHKCnxGM0LxCN+k7wueDs1p7DHphkvnQOxukGpNUjVJ0vRdT6NRjk6MyuFU5tCM/uc9deQ7LW/LSxNmZOps9QBvNbOlQ7cAJohEUDPXOXqZIxnaxNPPYIDMwFl7H71S5LZlv0Gayx0zmLf6LTJdgrz1Ztj6y7LvcfGLORLHTo6odb4SMSUBj0qnRXUDxhxVK7SBWYGFC7RLd2X4QhwGvByoNFIVppozg9P/2g+VItiJvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by CO1PR11MB5028.namprd11.prod.outlook.com
 (2603:10b6:303:9a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 07:14:37 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.009; Thu, 5 Nov 2026
 07:14:37 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2] drm/i915/gt: Adjust usage of SFC_DONE registers on Gen 12
Date: Thu, 5 Nov 2026 07:14:26 +0000
Message-ID: <20261105071426.1159739-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: WA1PEPF00005B89.POLP291.PROD.OUTLOOK.COM
 (2603:10a6:1d8::637) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|CO1PR11MB5028:EE_
X-MS-Office365-Filtering-Correlation-Id: 2d611189-1e45-4e57-fa2a-08df3b0c733f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|10067099003|18002099003|56012099006|11063799006|261028144727099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|261102123227099003|261009223027099003|261022075727099003|261026121527099003;
X-Microsoft-Antispam-Message-Info: ICCgmdp+Loua23wkjfSYtFChm6gxIv3jxD1dylOuwst367nDhetpA4LWhVWGGmINH7m0rNaoG33gAfBGur8GrviIklo0hLr23JH0Rct/4PLqgpCDDGJtQXptkmeMqs+E2l9GlpEYyv/83fPEmGjCxtkJWa7N0vyYWK6S3NGYTqCep1dAvuUlYgipcYW+YkYo6uiyJ1/hAZnEIOlHHZln8cNKrHFuyh4MztNDCuhU/hkJ9xxgPGaMHYG3Y+XmEy4pfVPWtx/CQPldZBTl6fcaUtP/oPgyX8Y7AJRgY3AAWx9Jncs1uRSUSka/h8A3HGNydW3Lgy1JDDnIsDu3CzmT5Nixk6DOHDOnvmSXdhPILleWnYFed+bHp0cMm8Y814dJyR0UULyxwhyWCh+eBVhEji7YH8hMZJ3GrAVMCMj2khCzg2N7+yj2HOpN3aUneiLe0kiu55Gk53Idv5Z8AgaqzwOiGfiuaOm1AAA9jg8FKXsssLuEtQaNJKU7MsYAm2yMGRm5UGtsfhu5k1DG5PhDc05SdBOf4neDMxAN9vU87rZHPX7/O4fH0Pg6gGfMUJyJGy3T58cR3NxKl1ffbve8aa12EEuEShlOVRWTjJtMBbNjbleKATK+EUKidH4HSgns
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(10067099003)(18002099003)(56012099006)(11063799006)(261028144727099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261009223027099003)(261022075727099003)(261026121527099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ghher+8Ftq4QTDR0ZvbqXQikDQlVORp1Xv6SvHfwp/57dOr7TwsDCI7VhILx?=
 =?us-ascii?Q?7WFRJrO42vft8JpHfi1S+It+1xXrM5zONT09XrRgtg6JhsRwthwqNxrEU2ui?=
 =?us-ascii?Q?tM3qhgPReMeE1FLEpP1IKE4o80h8DtXmhUQuJ674euQNRMWwWfafDfqdUEAk?=
 =?us-ascii?Q?MZ4AVz/glivbjhF3bjiHaxglGWk6AxXY30nLEVmW3mPm7q94ccHGbC6DRLEy?=
 =?us-ascii?Q?b9+bKCu1zetlg4xOUV2sL7H76Z+QpmVZDt/7kxyA52mcom3XUfpsKLvRATtd?=
 =?us-ascii?Q?Tu2IKk/wlr9vVh1NCD0wYNTy0Q/VqYd7g1crfCdqbnTI1BT5VSLKP03CeO2H?=
 =?us-ascii?Q?NBFPMd5hVPdCv+Cic1Rl+1H3mBecxV8Unmua/mKiobSsF3OGZ3Y/MUjyw/ze?=
 =?us-ascii?Q?T5HFOC/CNq0VTVue4W01DBK+1I8RDB3KiKtoIrFmkf0XKpfzeIwKFMJDjFow?=
 =?us-ascii?Q?DCTdw2m/wjI8v0t42F6MCPXAnJFY8iW7g/yBDYfB1ZQ4xPeiJN79VJg4EoUZ?=
 =?us-ascii?Q?X+m9lAbq8po1bZPcVQKDELE/dd+BJB7bO3W7sXF8gtEwr+FJDqLVPt8JE3hc?=
 =?us-ascii?Q?udnZIL5iiczkRsVxucHmD+t2Pk8OXA9FLxYgKeoukt7Pjm9CAZ2cIszsgxSb?=
 =?us-ascii?Q?dhgU7f/21EQp5HfpFi6vLUJOYTZgMIMftwoVmH/9laJ7X6RXgs9sU9c1a50k?=
 =?us-ascii?Q?UAKr9akgYB9mJsvOR0rDu5abXKkIIaCK4jb7/una2/2xBHWg5zWanvVwhiTo?=
 =?us-ascii?Q?jKIoqJfkyZ41QoSBKga9uHSdfnbidIl2MPFAi15BUqBQrma/x1SlVNfEIsM2?=
 =?us-ascii?Q?kCKHNJqpPt/z1LkZruJm7ZOPj5ie5s530xrYGxbCJY6I/GCXqIwzSHwNqcfw?=
 =?us-ascii?Q?3aZyTLK+8ZWhUuFEz752ZQXp54e14FR7u0nFe9DWbwbsS3PsIRohL4BuKiyp?=
 =?us-ascii?Q?0hmG+UYfmTFoK0izOWdoDzcMPvjX/E6WsNllix4wsg/hXmARsCyOti6gmzeu?=
 =?us-ascii?Q?S3c6j1RdHI8qXV8NSs3DfDC2SiZ5hMPNg+fqZ49tTIYnsaZVrRfGMR4cCEe3?=
 =?us-ascii?Q?/HHQ5HiaWocYhhTQxYQnmFOi9NhGU/zhVGiBDPvqoGPUS8onYZli0YBAVwSx?=
 =?us-ascii?Q?49RaJiXCD46ATCPEsbFIodm8E/iAElqncvyDWh/GizVGBBKmQpY87SdkVc5r?=
 =?us-ascii?Q?b61hZl/sdMdUKPcqWBpdTGwTRTqp6N7CrCJsH/5K9UooSqrYOKV+iZEx8sFY?=
 =?us-ascii?Q?wu+W7GayyTCzzDlSe92xjbSX4sx016gxwbLeF8qOM9Q4LE+3yoxm4BRP+ZxA?=
 =?us-ascii?Q?7ZGVbZL9X2Dky2/fMuVnSG/BmQ5ZNX+GK/KUOX/vWHC8Ya/3Mzcopc2qhffg?=
 =?us-ascii?Q?pQj5hYj0ProxwPRiTbWP8ZIuEskq3bs0l6hh/gy91Y3nsU9ekFoO6Oc0B9Ss?=
 =?us-ascii?Q?pwVaPQo97bd0AQXgqKcGHtSry1seuhIXWz/nzbKnYc5bXqi1rwGzmgyjjxEf?=
 =?us-ascii?Q?VM7BA7xBeb8AP12pbp2GIA2Z37i5SjpN8uKZU1ROxcJW4GynMef/vZeX+WU5?=
 =?us-ascii?Q?pj8hh/8K5pRULIA1uf/LWu81Aw950wnvhQ7lDm5rjf9nEK3Nbs9Ue7qwdD3W?=
 =?us-ascii?Q?wWZzKBbE/HEa9O9usBIeKGf/wI05fP0Li2lG5F3bXGMPtv20dgtQEr19yssZ?=
 =?us-ascii?Q?PLHne47rxs4QywzrokU+NwQQ0DncTHZbPZOENCftOLTMjALHjNIDKah+er5T?=
 =?us-ascii?Q?RB/PaGJ+RJYPF8AH5PR5aarYtXlfCZQ=3D?=
X-Exchange-RoutingPolicyChecked: KYa1HnapzBKyuO1IiT03kEfdGlgA4S7+aIyTOVFiGRcoLZfZ8/DbdZANchkTdFdbjHZb0ZTeVfIGMfOfZO4e/d+6W3I3rGoKAhUOll2j5oL9FZbKovE1yoHj/pCTcS42KtNM2pTrWtmhsYlq7wYZa+KAofnZoL9f6A7WQPCgRTehqmkEm6GzeB8D/JBLDX9OO80qeIRscp0eiNzWIlKikqCiJ1ttap9qb0wu5tlo/cELYu1FQgZr/pRW+ON4J84TyhcYjb+1ufJ3VBHTpn+s2Wj4HH+ZEubgc9yQHQeRNso86xbo6YkzU/so/30USiCwpsSTHBt/7+Rgkz54/VOe6A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2d611189-1e45-4e57-fa2a-08df3b0c733f
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 07:14:36.9986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dD1K9MkmZmXfNNd1gCiIQRYOeJKP726t3AgrupAZizv1Fbdkh6VqcXZR8E1YpEFG+OdG9/UCTBiA5o5FL7MIeYjnPJ9efLXAIecNfKkJb0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5028
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Initial, empty XE_LPD register list for Video-Enhance class was
introduced in [1] until [2] filled it out with debug SFC_DONE
entries, but it was never explained in any of those commits why
using those registers for VECS class specifically was chosen.
Furthermore, currently, it is seen as a regression [3].

Currently, gem_exec_capture@capture@vecs0-smem runs report
partial captures on DG1, DG2 and MTL [4].
SFC_DONE resides in the VD forcewake domain and is available
only when the corresponding VCS engine is present (explanation
from [5]), but XE_LP capture table currently associates these
registers with VIDEOENHANCE.

Furthermore, GuC firmware supports SFC_DONE registers in error
capture only for MTL platforms, DG1/DG2 are not included, which
was confirmed with experimentation and offline discussion with
GuC side.

Make a new list of register lists for MTL and use SFC_DONE
entries only when that platform is detected. For DG1/DG2 pass
an empty list for VECS class.

[1] commit 24492514ccbd
    ("drm/i915/guc: Update GuC ADS size for error capture lists")
[2] commit 8b72c21618de
    ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
[3] https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16904
[4] https://intel-gfx-ci.01.org/tree/drm-tip/index.html?testfilter=igt@gem_exec_capture@capture@vecs0-smem
[5] commit 24d032e2359e
    ("drm/i915: Only access SFC_DONE when media domain is not fused off")

Fixes: 8b72c21618de ("drm/i915/guc: Add XE_LP static registers for GuC error capture.")
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v2:
 * Changed commit title (was "drm/i915/gt: Use VCS instead of
   VECS for GuC error capture on Gen 12") and commit
   description;
 * Enabled SFC_DONE on MTL's VCS engines and disabled these
   registers on DG1/DG2;
 * Added a new list for MTL;
 * Renamed relevant objects vec -> vc.

I could not verify when exactly the issue started happening,
because:
A) all recent reports are red on DG1, DG2 and MTL,
B) checking for "partial-capture" in IGT [6] was introduced way
   later than the driver code asking for SFC_DONE registers.
I assume it has been present for at least a few months, if not
from the very beginning.

[6] commit 93d3b0e28d7d
    ("tests/intel/gem_exec_capture: Check for partial register captures")
---
 .../gpu/drm/i915/gt/uc/intel_guc_capture.c    | 33 +++++++++++++++----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
index 865b61057566..88e6d706210c 100644
--- a/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
+++ b/drivers/gpu/drm/i915/gt/uc/intel_guc_capture.c
@@ -88,7 +88,7 @@
 	{ GEN12_SC_INSTDONE_EXTRA,  0,      0, "GEN12_SC_INSTDONE_EXTRA" }, \
 	{ GEN12_SC_INSTDONE_EXTRA2, 0,      0, "GEN12_SC_INSTDONE_EXTRA2" }
 
-#define COMMON_GEN12BASE_VEC \
+#define COMMON_GEN12BASE_VC \
 	{ GEN12_SFC_DONE(0),        0,      0, "SFC_DONE[0]" }, \
 	{ GEN12_SFC_DONE(1),        0,      0, "SFC_DONE[1]" }, \
 	{ GEN12_SFC_DONE(2),        0,      0, "SFC_DONE[2]" }, \
@@ -117,9 +117,9 @@ static const struct __guc_mmio_reg_descr gen8_vd_inst_regs[] = {
 	COMMON_BASE_ENGINE_INSTANCE,
 };
 
-/* XE_LP Video Enhancement Per-Class */
-static const struct __guc_mmio_reg_descr xe_lp_vec_class_regs[] = {
-	COMMON_GEN12BASE_VEC,
+/* XE_LP Video Per-Class */
+static const struct __guc_mmio_reg_descr xe_lp_vc_class_regs[] = {
+	COMMON_GEN12BASE_VC,
 };
 
 /* GEN8+ Video Enhancement Per-Engine-Instance */
@@ -189,7 +189,22 @@ static const struct __guc_mmio_reg_descr_group xe_lp_lists[] = {
 	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE),
 	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEO),
 	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEO),
-	MAKE_REGLIST(xe_lp_vec_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
+	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
+	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
+	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_BLITTER),
+	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_BLITTER),
+	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_GSC_OTHER),
+	MAKE_REGLIST(xe_lp_gsc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_GSC_OTHER),
+	{}
+};
+
+static const struct __guc_mmio_reg_descr_group mtl_lists[] = {
+	MAKE_REGLIST(xe_lp_global_regs, PF, GLOBAL, 0),
+	MAKE_REGLIST(xe_lp_rc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE),
+	MAKE_REGLIST(gen8_rc_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_RENDER_COMPUTE),
+	MAKE_REGLIST(xe_lp_vc_class_regs, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEO),
+	MAKE_REGLIST(gen8_vd_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEO),
+	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
 	MAKE_REGLIST(gen8_vec_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_VIDEOENHANCE),
 	MAKE_REGLIST(empty_regs_list, PF, ENGINE_CLASS, GUC_CAPTURE_LIST_CLASS_BLITTER),
 	MAKE_REGLIST(gen8_blt_inst_regs, PF, ENGINE_INSTANCE, GUC_CAPTURE_LIST_CLASS_BLITTER),
@@ -354,7 +369,13 @@ guc_capture_get_device_reglist(struct intel_guc *guc)
 	struct drm_i915_private *i915 = guc_to_i915(guc);
 	const struct __guc_mmio_reg_descr_group *lists;
 
-	if (GRAPHICS_VER(i915) >= 12)
+	if (IS_METEORLAKE(i915))
+		/**
+		 * MTL is the only member of Gen 12 with SFC_DONE registers supported by
+		 * error capture in GuC firmware, so use a separate list of registers there.
+		 */
+		lists = mtl_lists;
+	else if (GRAPHICS_VER(i915) >= 12)
 		lists = xe_lp_lists;
 	else
 		lists = gen8_lists;
-- 
2.34.1

