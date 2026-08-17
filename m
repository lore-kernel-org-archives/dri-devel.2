Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D76A3C5DF7A
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:57:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 167BE10E71C;
	Mon, 17 Aug 2026 09:57:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="k7xaLS9i";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5099B10E719;
 Mon, 17 Aug 2026 09:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786960621; x=1818496621;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=jTpg/H5mYBMO8YRGeBkeYxx+T7u8bEcr49QPT4KBYK0=;
 b=k7xaLS9iwvphJWl3+7ifq0rM9biRbKVBBGKvCJFWqwSkksNg7ZSR/TIL
 atj8//TijldaEoeXHrIUkSis4x12dGskdUUjhtGxk0vfay8pfErsnd34g
 ShMBiMR8PiVLLuQbMizgJcyZTh0Gaiwbee/BGjdqPHQcc1su9EChCSXp/
 Dt3QAy1xdWIalFH0Xq0o0OcUl7gDXAB4GMKuG+qwo1DYvPtYiwTko7EDh
 BSsz+qs6GBqyd8NWpdB4fUGskAbvuHvPN9tpmMxuDQbqNUtrPkk4At2lc
 svdu6dY33F44jhu0QOSGpCjrcSo53DeubvlRkM6J5Hce/BSWHQ8WwKIwm Q==;
X-CSE-ConnectionGUID: wDqz3wkkTNWs+wtep79ybA==
X-CSE-MsgGUID: crO15Uc9TQKxvigT1D7V3g==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86551593"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="86551593"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:01 -0700
X-CSE-ConnectionGUID: eTpb6gV6SzKRO5jksYS5OA==
X-CSE-MsgGUID: TqOOyOlhT2SDD5/YNLNdcw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="269148250"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:01 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:00 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:57:00 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.43) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:56:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mLVc4SzzLvC0dAX0q+8SshNQ7I/nKk1cyoTd++hY80FtjV/gBfc0RCUl5fyRmIrLPTHMjQL9sHsWz+dfiYcjEbVT6pw3hvhehzo56uiAJgA1P4dr2C1+S+wvnsIrf6ELxB5tFT5G1Grr/twKLQbSPXdFIgafuRRpI8dQM+zWo5aaReiV9a4WaZghFE051SxGkFXz+kt9g2ix43KLnvZrwinpMMHCxAzEX5ji9/YJSHntqbpQJZLBVA3iiozui7lSUOL49Ima2HHpKQPx6x3dApKcSmaPIzUWcPsRtD1l66LVPQKwyMFxxLwoeBgeSR9m7nps2NRdW9ci9v+XvrYUew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IJ4jXJVHy5josbRXQfo1inZkgYX5icuVV2atT9sImXk=;
 b=H1Fn11j3zu4X/SdLPXioawR6UZ98SaKrO4k0rfApsUj3aUMboJJqF9BrM+K5aIyZZrWQYjGt1B6DRyGSzZMzofFSE3M7IcLal3rjNUifC8AmZOg8CUJodG9hZqFNZkflZpLOFJVNKC6+kwl65kSHj5P2fNBh+pxU+Z/BNc6QuPC9a+M1xHQed726KWnIyEjqPlmXErLsBln0lF8WlnnjBUz559XzueW0L8EduIJsIwwrt2Xq9adU3qxfHvpKP2712oR0JLB8tCOEsvtDRe+GRczi7/2g3M5ZpmkisvRvN6AMQA0zLIAX3vVsVDatvblxGTWmEJZwcTSuGEKuYJ45dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:56:57 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:56:57 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 0/6] drivers: Improve memory management for large object
 allocations when i915/shmem is used with iommu
Date: Mon, 17 Aug 2026 09:56:42 +0000
Message-ID: <20260817095648.2438192-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0227.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: efb4689a-5e49-49b6-6711-08defc45dfcb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|6133799003|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: W0zRxoSQThIIpUFetScuEHpabzrUDW45jynEFtkOvt0InS2trTpubwh5uIkWS8gKQs4492X0s5V/SKsYHZfkAeSBVjBtNz8e8TWwmc4LX3FeI7VVKDrMZJt6xd0SGWRyhw4EGA8XeQ9vFr0WQvFR0fbSVLarnqwUeiDylok9J81rwDNtqJtA6LwhTwa2mwW+TR66imHGvpnlxd7/R0nefN4B/rmEU10JJ7PRVSHdbtAIAeFmc0kgCT6ZYhMqsq751cz/mVEVT9XRkn6x91q3Fwr9BHWBU0G6Dg0MrQJW7PodsE1Z37HLzcJ9zEB9552sTBdUFgwgEJk9DqnWfw9Whm0oN1hIsNnW6suL8DXHyp43u+ggY1v502BjcYhaIsPEOAl3/PbtoTLeaMD8Ciq4Hz1zDjy2x0Tm1wQhwOW0379x1/u+V+lG8cdkooNBi2k7C2aWn1YneZhsnU+d8M/hRwAh5NggV3AdDfAnCETTwL3PZcoot0KljwyYCRqwPf3zkbKsi7KhFOoClAXVR6/6FPqN/szk4m8034SHTqF5g/B1UMHeJWQNofPQOi1GfgG0h7/2I76C7j33ommkyMLEt9JWSDfqz6k7mLElASemsgqeqcIXd7mlXkronSuNlqvo01gDdkmcwS9J4DoH/F73k8/hkExi/ZTzlnI3JoeQjBg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gWSeXKPkhwds9jseDOvgfMcDhaf6rXR8ljF3f1y5XCdcADwzawB1MIRAmw5c?=
 =?us-ascii?Q?f1+43yNUfsWch0vfiHbdIfVkM5flNx3vYvpHqZDnmgh3BsTa/GkgMxrn3J25?=
 =?us-ascii?Q?IeLam4YZsI9l4cHTXUE6tOnvtzRf1G/MPciGzsQh+H/Dy99dkRR5BHaoS+Y9?=
 =?us-ascii?Q?tcEUBUqoRCoG+rrrPGZQy2l9JB7+wTwrt+6GFXSqLWdDkW3zAYSzcYr7dVU4?=
 =?us-ascii?Q?n4A1PbibhqCd/IHXk1zkZTGnqd77aKAmedm5pdfBl+/4KL1FtjbJ+MSZBS9h?=
 =?us-ascii?Q?AoY5RMqW/DuA/EE/iXNOcXrNEmosYa3fn5rJi/rA8itb91x0kKCgacHQJZhh?=
 =?us-ascii?Q?SDAtNfoLwFrVogvaXcxBwN8M/fhz8XUXsz/x8KEiOe652N/F0F6xTOycW9OJ?=
 =?us-ascii?Q?Bd1Ld3GqtZUVuv2GlgBFYf6TUe3UvMdvN0GIatGC5nydF64W42QEDSkq9z3l?=
 =?us-ascii?Q?emvTRcNvjg0glHEYt613qfG6Wt7D9oS9TWBHbSKwm2VcMP1tFf2NVjL0YWRz?=
 =?us-ascii?Q?YAGP8D7TA+gKIjMz3pEkntOkYU8VDBebaNemE2BsIJUMcKKirenn8WPmMjJv?=
 =?us-ascii?Q?E94qvUF5vzylyOhw3S4fIB2z6iCVxi7R1P3JzxvVEHvogwjWuwrGjz4QiC7s?=
 =?us-ascii?Q?SJkf/zl/c+OP2QVRcYE+F5rfxJb4EzHn/KJ0krAS5Lko+/zxgv1jxFsvKodD?=
 =?us-ascii?Q?lkj4QPTxM2uSGLp5/KalFy++w5art6I1IxjmlUvWnGrZ1ilZ81Jpf1ORoJJJ?=
 =?us-ascii?Q?T11BtWjJUtKbzCzEX9eUTn5ZbGiqmAhh1jH4+R7AjqIeIQZHNAj04tOAyjrK?=
 =?us-ascii?Q?+dhTc4TZq1+ZE8F3OW1H7YlfvEuQkf/OyrIvOaJAFWV81lDdg3RF7jk7sC9J?=
 =?us-ascii?Q?9avnmOzAirtWD368v7VZtOtpQvNR8vFKYLWL6WpZSNcwjEWfU6HEQN7AL8EP?=
 =?us-ascii?Q?pOjhZ7Ki8eF4NQX1wAsxM7zrDQ3O41E5y1l2rqLlknIxNjtXE5vqUiwy8C8u?=
 =?us-ascii?Q?Jm+bQeAcJ6asY5oGSU8GZKZkDvX6WVG4ixZwzR+ZGyaK+PGTmD3TqHK1/Asr?=
 =?us-ascii?Q?gV24HbfClQ7Nqv/yXEZdul0YOMZCns41F02EdZdXCTgJrXAD2DbiEfdIGFm0?=
 =?us-ascii?Q?CBWspm6tM3jkmO1vT7IOI5abPWLGQ+WSaB13XBcl1oLq8xzx5KYTVkDeyLRW?=
 =?us-ascii?Q?Sii3oaoWU0cLj1dPLBS7z66k1n1PW0lsYhgpNSR7h0vUySw35/C0Skpkl/NE?=
 =?us-ascii?Q?6UuOBtfcaOfDOvWJSK4GJPo+lXuVVMayC47C/zYQwa3OEjykXqHxPQQnGmY9?=
 =?us-ascii?Q?m4W7sLz4hwfGKFvKJ4GwNZD4PCloFZxTj34u68tB+t9zPj/33ngAcHT+hFul?=
 =?us-ascii?Q?5rtdkF4plOozoYkxFjkq4tctWKgtx/RgxISxwXn9OiDX7+B8v39G+I9wEHmJ?=
 =?us-ascii?Q?rX8ExI9pcRqDw6qRfkzQyrz20IbMNPMH9sST/0ZH8pojPF1AmyIE8xqKxcGs?=
 =?us-ascii?Q?PLKM4ppDXceuLU0vipaATGzFjvJgIBRKqCpIzmUD9gf+64XQUd51ZGIh9L+X?=
 =?us-ascii?Q?UXyPlHHOEedPb7LqFy8NfVKB9G/A7mtTqqo5rOM8UanJLGdc571R0b/38Zxv?=
 =?us-ascii?Q?2NRqT6yohlA6Dkg/bIvN1DLmjqTQncNtpwm/lvYN7kc6j+Gn4zFAdvP99XrF?=
 =?us-ascii?Q?v7lwsKcBXYZ8ktMLPCoWeo0X2rK2YOBhxbGZPgdI/ZDdQI7sbctvIUPQNpZD?=
 =?us-ascii?Q?6AiPODyqcmcurMfF8sqqLzFkQUIAP8I=3D?=
X-Exchange-RoutingPolicyChecked: SkbGT7Zbnp5x23d6DbJBNrZ95i1M9pSMX0l7iPPe+16Q0ivWzSuPkp2EqyFkXHWzqXem45ex1TjJTYfaBnq+b3gDbe6DMI6CKz5YcWNfaCuaWQdlQ2TkDC9fVu9bXS/VCYYZfZZkkyTcKlmBdn8RmpHDUCc+KE0NnK8Glb3HJaSRBtzP7FLBkvq9yKJ6yFooJCaBhyYM8pHxajS/ZR0LZK2KavzrpynKdrP9ZvhjyoBmerA8hbYXrkNSwFeSV6zcCSyWhJrGLIgI5gXMIVMu4ojShN6OwS+17s2xcU+UdPyojsmS3JiKYvUQB3cGuGw4ndaCguJvkXk81gBgeqdmVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: efb4689a-5e49-49b6-6711-08defc45dfcb
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 09:56:57.3648 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RpuRU6pfdcfcY/o4ZiX2jTZ1cq1yudOuo8mfk5cEoJUBo6l1ZCbtc5DoLzERZkcsJF+PM1UhvUiv/3Mp4wa5MFTEW/LBcQuLyJhKeMP8lNc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7772
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

It was observed that allocating large objects via i915 driver
(igt-gpu-tools/tests/gem_exec_big/single) the folios and their
pages were not handled properly leading to buffer corruptions
during relocations.
Furthermore, using iommu driver in this context would leave
residual mappings in memory that could not be released, hogging
available RAM even after the process ended.

Krzysztof Karas (6):
  drm/i915/gem: Count mapped pages in a folio
  drm/i915/gem: Free sg table on failure to acquire second folio
  iommu/dma: Catch scatterlist length overflows
  drm/i915/gem: Pull out size validation into a separate function
  drm/i915/gem: Read and shrink memory in a separate function
  drm/i915/gem: Remove iterator and use while loop

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 178 ++++++++++++++--------
 drivers/iommu/dma-iommu.c                 |  32 +++-
 2 files changed, 144 insertions(+), 66 deletions(-)

-- 
2.34.1

