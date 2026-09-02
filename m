Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B1FEC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:26:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CDA8310F07E;
	Wed,  2 Sep 2026 08:26:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="FNEqmprF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72F2410F06E;
 Wed,  2 Sep 2026 08:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788337559; x=1819873559;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=QaehgHdYHQZAQduS/cPNqj66VAOH2TTkDG7A/91qeOY=;
 b=FNEqmprFLBBw3D5Q+P2UX9rdPlbXk0AKbbfiuDlH761gE5h2hgJCk1Mc
 1NDh1/RLcDrZG1px+/LacFns+USm6Ull2zl4oWogzl9Mp5jmTzkgviky+
 U+2Dh4oQi69F+PV3FKWTHJ6aNOzFoT/NQna9adxrS20Zi0aUbIOBcpnnJ
 SENU/7rNFr1kmIP/3KvXfNbBHzaSfC7sxQ7zjmWcOuCzeEoK1c4VmjTH9
 /OU+s3ShIdF9P7s9pJwHfbmoqvmF+fyE7TWuB50R9HUjMP30T1yPC2PnO
 a1wfmx3IxfpdcSLFsxR9tQPBoIiSpbQSGlEg9+Qg6ulh+IUPtojxelGU2 Q==;
X-CSE-ConnectionGUID: Fz2QDkY2SEK3WFutqRKclQ==
X-CSE-MsgGUID: vKcrU9j6Q4aMSr8Jf+0CvA==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88994775"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88994775"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:25:59 -0700
X-CSE-ConnectionGUID: JizaVf0vTZeuxfXFXe8NnQ==
X-CSE-MsgGUID: +cJty8JQTSiLpoDRiMHM8A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="294180884"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:25:58 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:58 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:25:58 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.45) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/rFWglCoQwe4vNSG8dQ7OF5Tkv/M6H6dOr9aXw6hyAc6N3c6LA//ZtnjaxfK37WwpJGD9lp3jfqk8iEu4sRqi1WzxeFdgw38gsHLE4TV1tlu0Z4l91y7Ha8R/0V6aJxIendZA+WGCTPgZccdsgo5AwFE3QPDGpIq20MBRardaM8BCfTmUQ5kQaQzFtcpXrGbDbopT1blS3iliOSL5czU67iyIfFn+LSdLisNLWaRoHp9zKGkhH87aJQRqm4JTS8psfgxQl0UtTC7bpVIF24HZXHW0iXLCNn3SSrga0uLU6MliwT1w6PrAydadb1kVobRzJpP8bxUyZljAlvC1njww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=T1jJOd8LIrsHZ9q35eYe8k4rJt5Eixwro/HNUayf5/g=;
 b=Jb6p9GE/B34VGpCQy3W8xD8Ogdd0AKJ8zmq+eWh7eC73t6TRHOnfrzkwzIoG1muqIvA8Xr2V+DZ02ZbWqXMe/1MVMxHLL5BhyREBEB1+BkZBUYjEGs2cQZa/2u/cofs1TWyi9/odh9YdBMoi87ZTMD/nxQ2r2a2mvRxvKNqMzt6Qx7MnvGU1PUos/CG7ni8VAXUmAWrYD6LKN5MBVwSy407Spz+njGWemNijTLok/xHUtADKFhaJVYMUlRzzFbRYPw7t2J7b83dLjj+1i7A7eBXk9mUTcry/Dt+K6N0Jx3OsJrf5JF4wF6d+HH6tzvUNQ4mWgeHU73X8QIYtv4y/hg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:25:55 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:25:55 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 3/7] drm/i915/gem: Free sg table on failure to acquire
 second folio
Date: Wed, 2 Sep 2026 08:25:21 +0000
Message-ID: <20260902082525.1149367-4-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260902082525.1149367-1-krzysztof.karas@intel.com>
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0200.eurprd04.prod.outlook.com
 (2603:10a6:10:28d::25) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|SABPR11MB9937:EE_
X-MS-Office365-Filtering-Correlation-Id: 27423250-afcd-4f3c-80e0-08df08cbcec4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: NzV3O9jAMDRP4A8ncD8RIxXRhq3wNbtP0BIBC3c2KB/uUSQm4jGrJdjSuxJBnnD6xom6NLk1/Zl88lA1VSBMBWhXXJWvKYL1uluvx9UNzk1jLcdN6qUw0pHuuEH4xZNuYQSSFPePfvtDyP2zSMvWb2ZvVKTPKzU+Ebu0Ey06HGPaqe8vbekyFRh6UmWSAo5Az86iGEr5uydmW2Keon+yUTZL2LU7DBsyAD2G3ZYgo51B4xeM+zspSONxPjg+EReo9RqSR+iMrPNxzjKc0XT9x9WqXgsO6cT7XEjhw2fwR8MogVm/3bbAu0wDPzCGVjIbgeeK0yF747+sRPDbRjzxUxNzZb6SKurPejNdUWcvDH5Y0jBhgAnY5Dee2PWinVwUMxDjRQFPvY4rS3qrOvZHFzQi3aG0uoWzhf0ffLD6LWhiuAyx5wXO8FAQJhWnwj+7V4VHtonqLVqapaIL9ZFN3p7QqQ6xr4B+88Z2QY2BayOu5NxFpfga8qi7/Dc3mq4voOmkjEeONkutq2JPbRd4C6lzTW4/5S1izvjI4Vdu6htZoOIcC97LIrh/A3olNKiFwDbP/bXb/+HqCHHV13rhVuDA8qmlQJOPVJ9QcUrZ9H7PRv8Cn8S2FnwuNYRMgdl3SDn56SdE8YAWsJPqbCNjY7/hsdrNJVAiBQ427JWIahk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IOH8JKz+vqPb3rEPgaEoRnnfGdwxzyLznUCeZ/7DCmc8NIBEKLgoJ0zGd9Ot?=
 =?us-ascii?Q?BPALTlVTTT8PXmnPW8/8aYwlGvCEXLe7V68XWFdieXyU+Y99uvxfawTDYU4Q?=
 =?us-ascii?Q?Q8bh5o56DRMz0HofGkZsjJAKelzv4s7pmQsE9kKynkR9QgGnE/dXwmIeZX/T?=
 =?us-ascii?Q?7YJHq1I7NbmgXQLin87LMHASXZHXCHEiavJQicQVLKRez3NFvt2VCOYr/N0V?=
 =?us-ascii?Q?DPXQUt70Q95sHHW9Za3tCZ76avcS24fA17yTw0v/GbV0Argi/QSpL9U4DqJH?=
 =?us-ascii?Q?EjyuV5xOmdfX9iSuPATSc6X7JaAnXAhUXWhBbrseQnS9Wmhss39ML2GLJrQM?=
 =?us-ascii?Q?hJ//aSrTE0hJ/exyGaZ+OgX++KniVavi8NgEUfJrvkg6z5zQkl+g4HMmKwqy?=
 =?us-ascii?Q?SMCcw0CkdYGGODPZSX5+tXSVHxwzSBomwAPN6nLntfAynOuAz7sB3/IMXTc1?=
 =?us-ascii?Q?u1tCyppvfve3lRvSKG7FzzSYRtwWO6KwhGZG7+cIvvUVj5e1eOXXRynhUWPV?=
 =?us-ascii?Q?/7HoPzJJb1CByFhpDPGbbbDQznVw9QuVYsKhvqakZj5AfYBwIf06oJS4lmdb?=
 =?us-ascii?Q?CN5p5V+33ldv3kZGj1BYsVq4s7W9nUzc0fv1im4gw7R/CQSlWLdRyFbwzKGO?=
 =?us-ascii?Q?5X1UpvuRrBOVWRB3wvDMP51DpokwT+SbDNuLZ3FpVmna831rayOu4ZSwzjvl?=
 =?us-ascii?Q?FpiahcFZZpWeYM7iBNadEajiZQjH3nUhPcuPeV6P3k2l6N9tBcvi0u5Fy+jO?=
 =?us-ascii?Q?DhjlEwYqPPnJa0zO861i+uqp1cR5B6D2Sh6ILSZVhlhAsx8jXAnSlaw8CvkM?=
 =?us-ascii?Q?2aG2fgPz+eOXS8VfxcCCNHE1tHZTR+Itl9Ire62eX/4jF1J51tzf6Weikxyw?=
 =?us-ascii?Q?Yl831qaDiy8DzXkw9YU0mfFSSCWGU7cijNQQm/djsgpIRAPWqOtYS9IJ945t?=
 =?us-ascii?Q?bIeSNlyLFvHcKdaRQYkkmZoqkmIBInC05CpbKxbiWxSmUVp4LSsXYOXO79nL?=
 =?us-ascii?Q?Le0d02ZzjVeEgHf4Vm5r6qsEb2U2jYFPnfJUBy1tfA6l2zgI4hNIS71GEh/1?=
 =?us-ascii?Q?+2e6oHq3AdcUZR5O3i8o6cOwHnV47jcC3fgNr/rj/OKWpE6j2Gxa7NTZcGcQ?=
 =?us-ascii?Q?pPhXnq94EiKXFPUjkkRy2LFNDUtOE11SDY//zu0cl6WS/6VREQEfAKcA09f/?=
 =?us-ascii?Q?SuAHBG1A0QPHTD30ZQmYKn85surXALdjfCXNIJg3fgbpSSXYXzlOUIr90TmA?=
 =?us-ascii?Q?CbIMz6XE0UzNNKnJ9KZmA4g3OXh9SyzwATspZC4ciwCkv6qpk2MyBq12dInY?=
 =?us-ascii?Q?3JV4rPLmUDUZirHz5SoWDKSTfRcmzjqjfdTgKvjfp9w20EkpEESd+Q2ZMC8S?=
 =?us-ascii?Q?F0ARA4IJKYj8Q4qpKU+9EtMWCLSDnaHpbciss7rCo/h3fAKMatuFtMvkhT5i?=
 =?us-ascii?Q?ompW9LxTZaZnolHsjmv93YLFxL6QW8jGGclgkFSRhl/9ebI7CBFqn2xKEK/r?=
 =?us-ascii?Q?pRHGeYZL8HUdEP9I6coWI6l4OGdenN/JQ8YroO0QPd80doWzApt/vCwNAUhv?=
 =?us-ascii?Q?K+1qBNg81EFF5ZtR2I69o5BAk0QsVFBR6tPibgsbk2yxsy6MqUzzMYn7TdEl?=
 =?us-ascii?Q?YRAuNAzKNnZIoODRO94L1BwGZmrWQqt7u7GYmuI1YANF8oqfW8BDAJtaBJcU?=
 =?us-ascii?Q?viE28Dl6tZoZcF2ADXKknXQ67yoJFKasnbUzb9DI84ieXFa0lnaIIxoaHuRe?=
 =?us-ascii?Q?RUTbzXJ3IsKEusgvwv040KKUSTsJ1VA=3D?=
X-Exchange-RoutingPolicyChecked: HOeSZF9yaJG6iYWNvGuzAB4Pq23oKEAoB/SUWxIMxydRu4dNJLsAg+c4ASFxFwxTQkbRvAcum6iurT6uz5FBTlzIpm+b/FmSOGEkavOHZbV1nauaLl9CFLaTU6TyoUy8yeRMDI5aoRSYqi9ud1cGP0MiyAl1/JGVyEeO9Leu1TPapqCZYG/z6y6ojYvhbJn3Wh5Mh12BkRpreeXsyuOPF4tdUCtWT3L0ywjGfO0KiSJxW2vKSCAHIFoQyALo06r3LryqJ0JT+6nPv/Y1nnfPqf/sLaIki08I/D0SLTGSzWMDcEevJWF36hVMLrFkFQQ3D6pU8xBCpnN3/140DNm8mQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 27423250-afcd-4f3c-80e0-08df08cbcec4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:25:55.2735 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9ZoX+jJlI3ZUm4RXWHQMWi3nIxdZoBi5hZkrq3bXYD3FKu2UTJ1DTaRqtGByBWYXqb8Hm47f9MiHKzS7q65HC5PI+iuO+VuI39pawsQq4U=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SABPR11MB9937
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

We should release folios if the first entry was populated, but
loop failed before sg advanced (st->nents == 1 && sg == st->sgl).

Fixes: 957ad9a02be6 ("drm/i915/gem: Avoid iterating an empty list")
Cc: stable@vger.kernel.org
Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v6:
 * added missing subject version prefix;
 * added fixes tag and CC to stable kernel;
 * extended commit message to contain exact failing condition;
 * ran final checks with Claude Opus and added a tag.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 8e5f2a7d5f6b..a84c804726d8 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -209,7 +209,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	return 0;
 err_sg:
 	sg_mark_end(sg);
-	if (sg != st->sgl) {
+	if (st->nents) {
 		shmem_sg_free_table(st, mapping, false, false);
 	} else {
 		mapping_clear_unevictable(mapping);
-- 
2.34.1

