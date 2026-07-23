Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00311C531CD
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 10:27:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4152210F089;
	Thu, 23 Jul 2026 10:27:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="MPgOsqeK";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4643310F078;
 Thu, 23 Jul 2026 10:27:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784802449; x=1816338449;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=OcVzp0o+pgdL42ZbTLH4uV2+hcCPw4bsNkWqStjXVlM=;
 b=MPgOsqeKIysVfXDQgBOU00fkDZykPOv+5qYou2foAHxvRXHnPiiMicaZ
 K2iu95QLyNf8oveQ8Tyx9CLoNnKwX3icTzg5CqdkUXLF53hJ+6OXoagen
 DqE9XswrZkw7k/RwJlY0FPXlSqu37aHo02aH0fHmRF5QLefpqAwuPWBzz
 ZrN9aeQX4CQQBe+FqNdOLXcRx79NlkP9D/EP0COTMERCTjyZxJKRdb963
 mV0v+f/+xt3hoT2KnB+5gbVdUzUi3fWZawON4D7/mdZ5Cx4w0EPwST/Qv
 hnnjExCgL4N7ugQDI/fKpCV/izcnqDjs8KmGzkh6JtvGPnHLylU37fZfi w==;
X-CSE-ConnectionGUID: Plp6g/WXSPuAGnjVbCPY3Q==
X-CSE-MsgGUID: MT6S0EzZRBi8VKtIKLy+xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="87995339"
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="87995339"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:09 -0700
X-CSE-ConnectionGUID: kZSPhi74QkinESUvK12mXA==
X-CSE-MsgGUID: qXimyc+iTKO6eAzCsUBE4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,180,1779174000"; d="scan'208";a="296588869"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Jul 2026 03:26:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:08 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Thu, 23 Jul 2026 03:26:08 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Thu, 23 Jul 2026 03:26:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wCckBSzB+aVpYmr2d2BtL2jOumOCd1X2ghdpnUuuKvPaBxkqNbonv3LHmRAE5di6OTyR8qaoRN2wQqvU20tWs2ol38Up2CEjazhNVakOsfVNRR9iNanKQEYqot1lBBy7+c9aaF8qv9j1/LkkGhTNO/zihGPaQXJnUiokplLDZiRVwwMB6TI27jO5KBFLtgOKueNmw2mt/LVsvtBd+h//eeuruqENDU9qnRKAfRFJl2x2mooaPPHVbqJ9EswTEOurFmdhYr+XokPl9sj0QAE9GHoJ3SolqBrMmLVQKyf45rW4iBUKkqBpAApkmyTsxzSvjSzaRVJagQKU62XdYQbIjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vn39aRCAQcaqXD//Cpu+kI0Bv1EuNE8Rkk6pCAhSb6Q=;
 b=FkQ3XO8nbqZe3D3sWgRmuglG2u62QZwqQa+r4uynT03YcI1ipfECTseFuGmwNhlOye+uFkUBNDyABtpKNcm3XEJehQi93Y/9erjxHyixGio82WmDXvnFtI8dw8hjiGhYgkvXiKXcCtGC7O7RbhtXwGqVOKbxsmTJxyh5zG9j5jcRw+AsRZdQBFskphu8+CatAPU4Vg+L+tq1u4WMyGkGmQGYfoTD2ZS4CqfmtxY14KRLtK+Sd5VsgL4iQRpgI1OfEUysXPLJQ5Qv0jaaSa7BW6cl3OcpOqUno4cz4ULK9gBcHwNX+2PReyzDdxjgvMs3HwXBpRAwsxaYBUcN1Sxhzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by EAYPR11MB9969.namprd11.prod.outlook.com (2603:10b6:303:2d7::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Thu, 23 Jul
 2026 10:26:06 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0245.009; Thu, 23 Jul 2026
 10:26:06 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v4 3/5] drm/i915/gem: Pull out size validation into a separate
 function
Date: Thu, 23 Jul 2026 10:25:40 +0000
Message-ID: <20260723102542.3245495-4-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260723102542.3245495-1-krzysztof.karas@intel.com>
References: <20260723102542.3245495-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|EAYPR11MB9969:EE_
X-MS-Office365-Filtering-Correlation-Id: 337aafdb-39e6-4f2e-7e83-08dee8a4cde4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|376014|1800799024|56012099006|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: z17gBtHLPZmmb0x+w7OE4tEQ0Q61M7NrWP40glFqGJE9l9hU6VlGLtRPkbKBWOKequYphS2+i2TA9HiDJiC5YYFBgLplunQv/6PsMkHDzSYNcLEwHd+/1frtfNn1KhWEKrTwr9HHvLgk2SomUkXVhnG792UvjDEGjt3klW9+Vnq+/2Sv15udoT7xBwdItfj3fZc9W3fLeXCl2nVxWDYQzarzlRrktY6cANZt351YQVLirGEMzpaPPpkvhvoGRM+WNLtNNWi2GZOMX6FBj9BvGwTYgjbbBxOmpbNnvwhUNbSNMqEiHgknH2ARUa6CSHUmbbpPQdEEslDtxxeWhLN07KdW2Zs12H2lEm+ll5YfXyI0Fip3btck0xLW6L45OGLs8naP19YwoRbmTJkBcgRGFYr0ISM/Ge/tgkGJM7XBw39QqWP5P+I84WNvBxxfiqbIUBvtcqIntZdnvCEThTLY5Dv/KKzcf4+osbqWytTo0aC5S+ys+ZJgQ/fk/Te58Dres2vdgNAmt6PsuyXEdsJ2TefhSjgzBwSl+RQKZaNPX7NtxwCJX+J0NIQVpmp4aMNBSHqHRe0ovUoDnhB9j6SxFIpS44k8Zkl8oFhC8REr1IgPIHZDMdrgPONVTz5RnkQgLlHzu60nckIjIlMKoV9+0bzfetocVBrsLttmB0VPqPI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(376014)(1800799024)(56012099006)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Lliqp7QNIxkPvMxrwTTqluMAfD3N7AZ1I1Gk4jAOvhlsRfqfVQjewHwTwxGP?=
 =?us-ascii?Q?Sl3BENp/fWFmU+G2ezUpkH1oizB3vSpUq/AckR6308Zk0nWOmh3ZIBa2Hr2W?=
 =?us-ascii?Q?OQNKUbVmChDn+vNDcWF5FKmAzxlfKAiHey2E7d4ZU1YCvZakh5DMbqWTZo5F?=
 =?us-ascii?Q?gCVBkvJq528fHe8iIomIa1xiXAK1oaGXy/jWWEACIlgVXJOFH6PMbSlEEdEo?=
 =?us-ascii?Q?Cw1LL/RkaZ34kKjjmCGgbOZtRZk0i7YK8lbVtyah3F1gqxOViJloPesk+pKR?=
 =?us-ascii?Q?Yhi2Pb1uWCZ/AOfHTSOG1orReTLb9gN5FREj5st+04XnK4DLpvFBPAOvR5BZ?=
 =?us-ascii?Q?0ki+vkB+f8A2cDNoqLU9d38k5HrjK2npnyVhImg83v5FyMkHv9CFCR+YI/1E?=
 =?us-ascii?Q?uKVrPnWpbvA9kQSRG/k5Uus3IhRKkLbREAl1UspXAc+fEXDnGgOA+WekIGJI?=
 =?us-ascii?Q?rV5+yCIDPOB0hdE/MYvh4KJciRcHOPmWIuuuFBJ2N/ZjYobOJvEDTMcnS7Tw?=
 =?us-ascii?Q?1B6K0QIbpuKk8DldLqaCWqNWlkPhZZK3Lp0vYV76C7E2otN1tYoOOHytirGT?=
 =?us-ascii?Q?BDzyoYGg8jZW9kuiVxmaxaBM9Fx7awOAP0hiTNINYKfpGQegH5uDbBNs6lYY?=
 =?us-ascii?Q?Q+pNgUO2yJfYfH/lsCxe4w6ijTNfd3JWTNnYOVLgMvDw0izFVr6JX0T/5YIQ?=
 =?us-ascii?Q?3sQSEd4Z/CwcR6ASM4D9KRMNX2IUpPrjd5KJzGR87Be+WT7Ks5vy27WtQcFc?=
 =?us-ascii?Q?EL7olzkpS3OqROIVtBe2z0E89/B9/iFRYTKrqlqrw4q4nh4q4dLBl3cs5zTe?=
 =?us-ascii?Q?2Sa4RRkvesNgOzGaHMLDi9xWi9k6ThMjn7MZk4B+1W31q4KpW5xqWongtAOd?=
 =?us-ascii?Q?22HZIOLckmMTktPYC+gGHLxkMlL8+P/49A0gv9dUWly3SNhvBTyi56uRj6tK?=
 =?us-ascii?Q?2skAj8oDhMig6PqJjFmAhUAQtwK3VYEF3HkYnFKVhim0Ra2DUoA84TfH6pS/?=
 =?us-ascii?Q?F1maTNeEUJOFAmXk+YIK55GsJZodA0rmSEfCJjmjn2ubH8QaZHzpOWm6kHUY?=
 =?us-ascii?Q?er6tl9M5HnG/hqPz/fggM2/xpNYLZQaW4wYn+YswsOoF8ChTwRA/PASJrr6g?=
 =?us-ascii?Q?myE+DE84OINqShmCF+ku9Ov8vW90510AJDKE50zt6mnueqWVw1ARXsm+tKbI?=
 =?us-ascii?Q?adDiDvCiFb7YSjuXSDUUJRwudrWgOfm/pGukF7+S0odE2fSPOy1I46xqKh4w?=
 =?us-ascii?Q?gzksfpsor5KR8cIMhkRxGyiXgFqZlSM7dWisdkNyWzZbF4rZlAv4c0dgJhoa?=
 =?us-ascii?Q?AuAGDx77m5V9oLz04g355QfVd0aEDYll3T+wyY6a8/RTAUdXusmelhwBXbO3?=
 =?us-ascii?Q?edMr4XsGvl3KV1qa8QabmNWi4wuexsMI64Hxgar+W+XjntLdOSmvsAheU6h9?=
 =?us-ascii?Q?JQPMtlLzlQrYp3YvV5WuBqWd8VSZ3GwPZOoh53ldvz6tu655BPo1FeztUCVd?=
 =?us-ascii?Q?Wn7WdBWn486bRMsCwWoMsM77Su4p5d/YXXll+75KtvixV3OubnK7lBL1+B02?=
 =?us-ascii?Q?hy7sbI8Z060hFxnFlCJMX6G7xMvPj+ed9z7xSGZA/R9qkfionnCtzhpK6GLy?=
 =?us-ascii?Q?olSt+fX9/u49e74DXtXslqPEdpUDjF4hXSABg3Hr1aEF7GJqOKnyUUI/QnDk?=
 =?us-ascii?Q?V9ghScgaW3kgbUc0IV9jbEp82wMTDKeaISfOhNA9QaxJ0erbaVStQX6P9DQT?=
 =?us-ascii?Q?k/4NN1oRYVlX+L6enzCSDQbprvRAa+o=3D?=
X-Exchange-RoutingPolicyChecked: M4bAoxwDqdU+Kuq5FGdWyt6m9BJTua5geoeHUVVHEmq8ZX5BiyvJAAkQrz4APikCKyFrfLFY1nxVUlAGt6SQY+UrSuQdKtpA8tyYDUs5zAaXCI72y8e1PO9wMztjQtx0+OfaL635cyCWNsCkCzzpCIpZRyKqrInsmJOaFOO2A1d2U15Id5LxUfzAEx/72/lPjZcKW7UyQF7Z2k153qMw32jdPvIDpYIE9FiZZC14EB3wvlJJyvrp/yYM8imBYvuzMckOovnGPvx/Bn27DTnlET8xPouZtj2pqSzPgM2+fj7/r2pMl7sSSeD+5ZOidJAo6nepCoa8TuNquJ1cBG8OYw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 337aafdb-39e6-4f2e-7e83-08dee8a4cde4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 10:26:06.1441 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jV6FCtgxnSRmaCPGw1rm+tjtiuLmZ4OZ3K1FNlhhmBSG85mN4weyBwU1IzrcdYx/vivzMB4/KLz8MCm5IucOYjCrWEsijm+ClxCfemwn0Wc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: EAYPR11MB9969
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

shmem_sg_alloc_table is a very large and hard to read function,
so reduce the number of operations it is responsible for by
placing "size" validation ind "page_count" assignment n a new
helper.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v4:
 * Changed helper function to validate size and set page_count
  (Janusz);

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index af195db63038..f35b7efa1fc2 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -62,6 +62,23 @@ void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
 	sg_free_table(st);
 }
 
+static int set_page_count_from_size(size_t size, unsigned int *page_count,
+			 struct intel_memory_region *mr)
+{
+	if (overflows_type(size / PAGE_SIZE, *page_count))
+		return -E2BIG;
+
+	/*
+	 * If there's no chance of allocating enough pages for the whole
+	 * object, bail early.
+	 */
+	if (size > resource_size(&mr->region))
+		return -ENOMEM;
+
+	*page_count = size / PAGE_SIZE;
+	return 0;
+}
+
 int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 size_t size, struct intel_memory_region *mr,
 			 struct address_space *mapping,
@@ -77,16 +94,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	unsigned long i;
 	int ret;
 
-	if (overflows_type(size / PAGE_SIZE, page_count))
-		return -E2BIG;
-
-	page_count = size / PAGE_SIZE;
-	/*
-	 * If there's no chance of allocating enough pages for the whole
-	 * object, bail early.
-	 */
-	if (size > resource_size(&mr->region))
-		return -ENOMEM;
+	ret = set_page_count_from_size(size, &page_count, mr);
+	if (ret < 0)
+		return ret;
 
 	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
 		return -ENOMEM;
-- 
2.34.1

