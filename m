Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D1EC624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:26:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8C3F410F07B;
	Wed,  2 Sep 2026 08:25:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="IS0Ngjpi";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59EB210F07D;
 Wed,  2 Sep 2026 08:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788337553; x=1819873553;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=y1DW6JK1k9JE6Xt3oc+JtPcr3XgEladdeW8QS39Duhg=;
 b=IS0NgjpiV7EEcLgK3G7tw95pcSdQSQ3Po2YPY5Uh2WqMkNlrvUMg7Ybx
 VUa40Vl0v7eaiEmYRzFYRSOqAgaIasEfeDPczZo1iqg33CTTGlpxqqXvJ
 st8IgsqoR/fHV411zV4eX89lw9dYUZu1H/s1wbNiOwgPHyorJqphjtfZX
 MexV/3k07lMul27pFK1gkiaWd39bC826LkQPYGTyYcBuZqPZ9WIKP3WIH
 8oS8Bd0tt9iu4+iRey82B6IskB6IG8sb8V6nB1JJLbUs1BnaSQIuxzGXz
 f1VOJkCoOOo4fsK+eExrJ4dISdS8jlhKkNw6UMkhfnGd/BuIxMEi6dEnH A==;
X-CSE-ConnectionGUID: GM8K80dhSzeB/pgjnhndmw==
X-CSE-MsgGUID: uLpwar0QTsuvynPmYinzGw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88994763"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88994763"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:25:53 -0700
X-CSE-ConnectionGUID: afA5igKTT9eP/t7V1799Jw==
X-CSE-MsgGUID: ZF8QooLrQvmOb/5SBaiCYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="294180880"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:25:52 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:25:52 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.31) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:25:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ny+jIEHmBscfIdhKV105bn9yhX9J8jjr/7Pe6jDCYxs6Ct1NQVvjsy0xUn6nsZxbhQB5Zf/o84kxrMx+72Uwv+rMO1jvwnNP3U1DJA+j/bA9N9/wnIfxffRfzEAfhuBbsaiJ/i+3TiT+g/hhC1uQe29ZsllasloYbCJf1P5NG4Vaj5fDdKkv1oMmXeVGR9G8lc1iG77ZKZTCAy+bFvjwmqfvieUBoLtOqfD/erWLEwdQAepH/I4j9V1Mw6+3rXfPZrq7oO75WLbZdHKbxnVfRnMMOHrxl7y3gV0Db9df6mHSj5GMTBMn9e0B+mUprcMd/kohOO9+LtBN0DM43kBGKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1q+iVEFf2/bEdBtX2snLbCDgk/+1y8Y+ohZfwFv4kuo=;
 b=dum9yTtA8OojCIAKBpoXa+zoRh+62HsXuz1jy4pzMsfTGm+qsyuDCyXTUVQSR9+bAkDj6HaDnD3heRv1ObZ0nEZtpvHUQVWf3Hg1Kl+qL90V3TJiFTDcFYDItIbOA7aH+Fl3JUKO/2DIusldclV+HPu8j2qKrxEXhBoe3VXYhvKBOXuAcJuHcnoyRb+Jc2lQrH9cHASbQML2eF4DxroMP/adDq4q4Wg/5zNeuBg6Gmbr41KOmuFWwlWqOJVpmaOdeTDHCifD+gXEqotEl9DWCtt5JSZjRmMwZw8M4NVrVIKmhWO8SeQT+CKwftcX7dkNzoezpiCjfCSTRSVIIjTS9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:25:50 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:25:50 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 1/7] drm/i915/shmem: Validate max_segment
Date: Wed, 2 Sep 2026 08:25:19 +0000
Message-ID: <20260902082525.1149367-2-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 2fc0ea80-2645-456e-edb2-08df08cbcbaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|5023799004|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: scDCD1ijRWGps19wcJ9T+dYoKcpaJP7+Jq10B1k4cmf7CBiWic6op/EB4VIzxW17OKr1dP0cWLd7BhTDNBUOq2YChzyEb/fgDDZwnLE0ISC4nBabFCcele6L6+ecFwrpcJesY8sGophdHBr+H+s731VvJAw9a7kKyHhgNuooSXvsVpotfudUFENhLPAvl0sY2SK9op/iV2vL8pQz5GwEAzhKh0KhpF1VneMe/YvOb9u8U+hngnNfIq1MqF7OiRr+0JbvClG16kUsuRkgJAaHDtkm1W2uIgpwCXUCJJAjhYi72at4A412353MLEuuu2nDr4h8guY5iGoosErFwK3Lj2wXYYCiGenCipHHU3xyshnbvvtlPr66pHiQ7yMSvUux/jUzWoFBRwZzecwMjw6y+PvT+Oz/fdPJmA3TSQS9CY8Jt66ZAujEwooSFldP3j64ggmUsnUq3VttgcMfDzdOjj8ec1pyudIFphMagTi6bvcpkjrxjv9LDU6eg9GdSEqDyFHIcYn73SbM7QnjyOiPFtxH0JMYkKeWblmSPG5canbSgnvBi/13oLMhxIo03si6e6ZhuaHNgzlqrj7bTMSYGZL/DGQ2HVFMCaSIqV3qroXZ85NFpsiD4s9nqXrdG8rmm9YtphlYVO9a/CWisZGC5yyxWvLkGohyS8hPsc41+tY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(5023799004)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?e42PFxfdE5gjvUw2e2IUZsJjJtndha6ZRmyM2JAi/19Ia0sS2v8vM8pjdz+S?=
 =?us-ascii?Q?4h/DbQ0khgIfeS397aIj2GrEe8q3pkKTNnSVOr8/UQFYb+nrsk46JuM3QXiF?=
 =?us-ascii?Q?6m1MEw0Pywty9TRecMM3elPwavJazb70TwxRJSKXKulkZXvemO7hQXCssKky?=
 =?us-ascii?Q?/RBP34lNc6ZDpoIbrJdJYGkYaQkpzgSjUH/ZlToPUR567dzM54eGNWo86euf?=
 =?us-ascii?Q?OAvDYfSH41NuCH7RFRsMn94iVCOa9MQoWS+7fv2vZHfbB3Djxpzgls1Ji5l+?=
 =?us-ascii?Q?kWKx9RnkxVTUASZehcpGBm2R7DCnW701JSBD9eYbJiZ+Q8VI07sFXKznWIVZ?=
 =?us-ascii?Q?1xuicvL8WNZvsO76GEL2D/WacwgkC8wgKZUuCj3TuBBl86DOkQCni3FCVpZc?=
 =?us-ascii?Q?6Oc498FGENFJzYKHRzNwUOqiBgHQTSaAf+dldVfQ9x6dsaeEcWQde3kaeXVj?=
 =?us-ascii?Q?6YH6tp7hfqcdvVHPgL1jkyqMc+DQkvs9XTZEzEZaQkWvYWwoExFzORIng1Si?=
 =?us-ascii?Q?omHGArTnSXnsvw82GoG2W4RzFs0TPsgOERGDI0hJX55qRLPFe/gDBrRBLQuf?=
 =?us-ascii?Q?iw2Es15QbIf7fkskx1hnV2khxZk6IQTRLDEEshYG2c/KnI8oGCOfaGS8UttV?=
 =?us-ascii?Q?y76QHP7sUgOKRWjWuSk9LzaCjumBpuAFoEqVwbGGpPsfZY/GVHqJ67NaEoDR?=
 =?us-ascii?Q?CES13AJoP0I4c2JpB/cYtrb3qw+YNGW4Nklb32avQGqPFChTS+aSyAoWijVl?=
 =?us-ascii?Q?j4pyxbiNU4HDu7nhbziKNtDcQkOnOq1PlLT9nlvrDSxPppFCo/am5Nf2tjd/?=
 =?us-ascii?Q?m9Ms6Bz5BhsLQdisP3LambWbmI5Z039Y3F25XODLWg7ItfKBtBN/B6pdyiY1?=
 =?us-ascii?Q?dAsW2TnOhbr8WFh6VpCLl8ZeLGIBGt16Uy0uMBSrHjbOrvS6I878fEBWgf79?=
 =?us-ascii?Q?Jv5T1BWo3ezYvmQNZ/bVxzcFHUH316OALH9NbpPrGPt3JwKbH9uOJX6xd2V7?=
 =?us-ascii?Q?0SOYvt3l02uxFrtLhpMF7xVCP3VXAO4Ij+WCgU0SOoVq2ynRbkJ43L0TIfi/?=
 =?us-ascii?Q?DZjPU34DUvVUvBg6OJS+2mVfPfsY2jR6AgyJkPVtPt1uY4xwYvGI0blfwghV?=
 =?us-ascii?Q?8YbBCR3iftQChMjtLqCH6/eeu4XBIWNDV1w9s+/fyEIhJXaSUzR587O1xMH1?=
 =?us-ascii?Q?n2dZ1dts6OEpj8bCduXKHShWvjz01e+Gkfnlc8Cge4qRKiFL5Dss6gZOvOLe?=
 =?us-ascii?Q?KQoKxSETQqORv2nJJxtsGAOG+mavCYFMph8UML7bydtwYQr8Y03EglrWao/W?=
 =?us-ascii?Q?IZf4IwrBtzQqtBEfCZevNTPEU7tELIatIP8IK/AsmoyY9gquzfKOz3wXwkEC?=
 =?us-ascii?Q?aI4afG3BXxvAU9pTAAHo171fKsuhMf6pZgrg/lxC8c5FOzbiTK2ZbuCOh3ar?=
 =?us-ascii?Q?NZjzPdwc3fEO0r5kc/lZiNpMmM5s2B6Tm3zA6RncLxgH0dqEb2nSvVr7/sQX?=
 =?us-ascii?Q?MTEDAOzfoRbHNIkgNgQdJ0NNjBq4vZMwyzyZQ9Di8U3ejuhkoaisSaCOrhAZ?=
 =?us-ascii?Q?POxSR6do21Hqdr+8MX6l5Uff+O6iktV6v7/Z7vWpy7h+ylmEcOCqxf06B8x7?=
 =?us-ascii?Q?wde0zI5WtrVFfmlmlPZ9A0B+EXdPRlmjRlq4D16oEChfuwyDW5LSGunZdqWH?=
 =?us-ascii?Q?zdiuVEKZwBNRLKyw2XIACxbgMXBOtKHN+05XZrCyVX24+8ua8y/WvzitTut9?=
 =?us-ascii?Q?Q8nJjqfbpwRdIOn51OFJW56MAUptxc4=3D?=
X-Exchange-RoutingPolicyChecked: GL+IAfXxbOVL5mSz14NzHiBQd2FE9eR2sojLRP7rHy3z70+Z2oBPneyyTTlOHyhPzg4Y7d3iaLMDM49aWY3kPdm1RCl4Yo2L8fKQUnKXufL5K9jAslqT5oerx31SLzMp8byXkjhbkWzA72zCgrO/kbnwlQ4WAS2tOxHMSflMpUmNDRoWYXHPz3vGmPgyXmveFxH2mKPLIFiurQM4n13yn5qXr+966Bf8xxbfeUjRzSv0q8WOMlhb1TjWw/MfAJfPrlsejSbnFuN7+KrLIMSBnZzQd39Fk4/Un3ZVJtXI9tBWTCMxNL1Di2CIBhiqBdHpjmhy3k8nCYAH5ephDQhTQA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc0ea80-2645-456e-edb2-08df08cbcbaf
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:25:50.1128 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: x2ZEKVIfH9WPh8ZHn6NdE7JNWWqjIxAlYVPAwgM/zZlXe3Q0uYAD7/dHJpT9a16ZMc8p2UDV/zLZFIbsD15ISWoguN3XdlTPyzlDj2NVGg0=
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

There is nothing preventing user of shmem_sg_alloc_table() from
passing max_segment smaller than PAGE_SIZE, which would result
in nr_pages = max_segment / PAGE_SIZE == 0 and cause a
non-terminating loop.

Suggested-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v6:
 * split max_segment validation out into a new patch;
 * ran final checks with Claude Opus and added a tag.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index bf9e7480f0f5..4b5ce9a2f74f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -85,6 +85,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	if (size > resource_size(&mr->region))
 		return -ENOMEM;
 
+	if (max_segment < PAGE_SIZE)
+		return -EINVAL;
+
 	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
 		return -ENOMEM;
 
-- 
2.34.1

