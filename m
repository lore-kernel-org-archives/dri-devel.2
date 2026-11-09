Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E1B606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=hXBackdm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47EAB10F1CA;
	Mon,  9 Nov 2026 11:38:37 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B92C10E88E;
 Mon,  9 Nov 2026 11:38:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794224298; x=1825760298;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=ecSZz5IZhIuiUWf7If6RmbH3+RGM/I+RwG2NHVlLKRs=;
 b=hXBackdmqo4Wky7VEUj2cgv5iJVTnjP62mi87S0sNUCIAaySyCp9gjpk
 8em1kQMfNvsuvJE2metwPTo+OW7Z4N9hNWB5izsfrKloWZsGCjxpycA42
 KRgf7vFXdbFuU7GU/7ls3ophAVYpPp3IXRevoTKYNe5Tfe/6W/vqXPYCm
 2Mzy7jw26ST73m+tm4HWF9HOWj8tnNVX6D1dXSSfkq3xllK3UnUy3N5k0
 L95U5E/EX61fiW0T064005a2P0DvPjs9o/x2ie3cohcwhoPhSYeUylw7k
 r5xsKZP9b8pCwAnISOhkc3HlLjeO8xu8oFCLLQ8GsabePhVsypr1QHbqn A==;
X-CSE-ConnectionGUID: TdSrQ8cFS8WMPh3N70HtgA==
X-CSE-MsgGUID: L1526aEeQ+WQII/gcCOlDQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2835851"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2835851"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:18 -0800
X-CSE-ConnectionGUID: euGkxNCGQB22A4BQYqwLdA==
X-CSE-MsgGUID: Km6IdEk7S6OqWutSrf6ZQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7985106"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:18 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:38:17 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LUObWC+2ZohP9bP+C7/zRj3Z5qCQV1XOFctx0c9zUW5yy7Yi5fYRFHLJU1WnPIfyeYP8Z1eUrfM7TQFyrU8Lmn+EkZT9FqnQYsraqYdsA0RDDCq5r1eH0sIG/JG1lPQXRRW1L/xRgbzoLYNkw15PlXjNeDV/VcN+WUfdFbXBo+NjZwHph8Vj5xnDsUI+6yaq3GSz+SW8ujbqtGYbtlDwgpi41lj9ajEJ/6sfHqbCOo6J8YRQUb7DrONUlUHEK/1OYm4bZx847jLYKc+66H08UaW3Gaoy2R5Kpt5rdLQWQQWoX7EdZ9IPaxmxKqNiOTcFT1fmh+bBfeXpxeIzjuNkrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DbfsXXTEJQagumkc2tvvCq2JZZcAMVGeB1vG+WJij2w=;
 b=SaxPGlwQYzGGgFyK8xH3EpFaa0nWMVTBBbtjAJt1hhHL3VXaFawaAp0cTU5UocBiR/hgVumqWRMWKLi7uklzy7xEUi6K+syN6KW957Hq4dODkUdXnswoYKPX+Fn+ZXowopCQH8caIgk911irunsb+7B25KLdO1i1m6OFz/1NqNK3AcaCalbsfoZEznKtPIXeb8T8tkGuEp+xHbqmtN0Qmzj8ij1JtFj8+685XXdgL0TwdAO5F4aU+VrNIierNnEdaneRbDTjcHfWvVzFyco7lS33k8QbAbaooQ9lJLUlQdoj2et07MoLdej8olxan5rQ71+y2jM81vgFepBIr3sfkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA1PR11MB7199.namprd11.prod.outlook.com
 (2603:10b6:208:418::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:38:14 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:38:14 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Andi Shyti <andi.shyti@kernel.org>
Subject: [PATCH v8 1/6] drm/i915/shmem: Validate max_segment
Date: Mon, 9 Nov 2026 11:37:53 +0000
Message-ID: <20261109113758.1491891-2-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109113758.1491891-1-krzysztof.karas@intel.com>
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0215.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::10) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 896f19a5-da17-4f27-63e1-08df3e55f0bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|11063799006|5023799004|56012099006|261102123227099003|261021121427099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: b2Laa8HhK0HP6EkQqhO3dBBhlApnf7Ib4GAGYhwNfsSGxjgQ1e0+H92X0qB/k1WNkWMrEFng+ayiRRcLgdkaIGGGtFEdDIjU9XVIeVdBp3HpcRcDpoQhq/C1WWVEopVeO8F2klNk3JBtyVa/9y/deMoKmnd1MS77EBgqwaQT4pL8rhEZYeQ2YkfMrJMVEy1jUWDdLfwg7Lb1t0QsigZPH9ysmxnvM+UcvL9cGF9yOKBU6w0T6fR7Fi8N24i8vRgCMcH3jd5yKFB/Tr4nsk23izMf1joM/pHSKMNq0Nx5KWpLhiMyxlB0GTohMF4InQog6mvKV0990rWQbXbEeU/XUeOVlCjQBT9oN6AGCISan7NQogQ8V/o1c8FaqhFb2bQm0VlAiOxeJpCVWUzFtWgjQji+MZpEph1tE4F1jOBC0VEZw37zL0tlZjZbzo6PkSuq0mpu+mb5/ngyyvbI0XEJHPbrtA0KKDZMgiCheWhzASJ9tep9OrTU2rAvGln7gI7McrOaDLCnrJdniOwMog8HwinRsRgE/veyUcQ2FGaCBDOaKiBVMOIDcowC+T88kOK1iZ9jxfUVl/4/7cRBj8S4eiVXW8rEbDC/il7Auzi/F8N5klXQw3XgUIqdtvdn33AAq0TzW39mRyyY+RsaZd7ePryX7KKsEC6HPdDA13zOetY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(5023799004)(56012099006)(261102123227099003)(261021121427099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8s0rDyq19Iz8iB4QSwLXke3DUxDbZacrDODRvbYQL5cvEno1eIRyEbQh4YJg?=
 =?us-ascii?Q?6Hy3aGwxV6/+p328SKrSEc34Kg4qWWu+tBtbLLUlsNHF1CcenBEa0D1oNRjp?=
 =?us-ascii?Q?OE2MNF+2JfSjssoUm4RkrIgDWGwXv8OqU/yagwmI79k5+oP5ThQKNPRqgwtV?=
 =?us-ascii?Q?Y2M1CZySf461qBEn+GbLXiQaOjgE/Pd9tafH4hasgjh2dwsKsUWfZ23CAzmx?=
 =?us-ascii?Q?pLQZ9oyy1Z5Ehlx4JnJXQ+h+weTtIHGIz9W+604aYmOqewyKDnLEIHdMfk28?=
 =?us-ascii?Q?8IaA+PNKFJ5OOTxmtUvVRcKyxSlAdtH77ORK0kIFQeFRVh/p9H2kPTdfLUsR?=
 =?us-ascii?Q?oQRRLNOljSlLx1mGK7YNlRDDc7VlO+rlQ3OQAfh1uTH3opq9N+topv8twp+d?=
 =?us-ascii?Q?Qq/WWZBjrnutyQeDC4IVVLBRqjl1fPSt0Q9BmsSujhufZvlw7XC/ijEojd48?=
 =?us-ascii?Q?aqgxEdqJjM6oMlvtSh03JRYSPNHGQCVeB9FMPhDjPAJyX+SMfiVH1GVPZVZR?=
 =?us-ascii?Q?aNYfVIsQ0Ry52HcI8bTVrzTtKHY1MfSqmX584Nkc2dwPKtqVlcz1mf/1CaCT?=
 =?us-ascii?Q?gj5zZkq52j94mhqjioeEHmRkzrAq3fNT4MvuEIXhXWPQXz+fvWC2tHpqHxMz?=
 =?us-ascii?Q?xSNREOnMyWY52RacylRu2nzUS1g7SRMWZsYRItCX6AvcuaVARK8DVS/sQQNl?=
 =?us-ascii?Q?MBWaHTQkgsVs4C8wrLlgN57RvZ6vjR7NhTq2dhlW7oNQk5M+nwH1f/m/uZOZ?=
 =?us-ascii?Q?Nne4wgsphsCG+rbznJ0m2EUnTAT51Koz8EMf/OGVS1QfdP+NAuZnhnG+BRFw?=
 =?us-ascii?Q?kG/zm+jDWqw7G8tCnmN4XgY8ejTQ7qEHRVtzJMoqSwEsG1dtTdhLibIKrirK?=
 =?us-ascii?Q?E9CeMwknRYBq5S5LqK9igw4OiOzTbheVkSB6R6AqspE/L39Uh3tIDGNZqaoG?=
 =?us-ascii?Q?2G3UbCfB0Eh+SzybKaGiDgWjOIm0J+IrNhIt0hkZmfdY9GNDG/W8NqMi588M?=
 =?us-ascii?Q?B1KEaelyOL+tog4pAWvz0G4krF7/uD/+A1f+X4z1wUiycJypS2OQriUupkVF?=
 =?us-ascii?Q?nKZ+Nd7Lv+tMmNPb+IASU3NOIW1plRSdIfuSW2PAgGCQisHYA8Ot+9XRlVjk?=
 =?us-ascii?Q?0T3pIiXcs3Ut9yxai8RdViAgT/4C9EMvoBjtuk8iYq8Nk5KxUYoBy2tRgh3r?=
 =?us-ascii?Q?IpsuCi2ON3nbAxbOmcoy3jrOS8JbgrBua/Bg/8ffbwnvZsOk8oEn6+TMzy6t?=
 =?us-ascii?Q?JCJa5aSoDcn/C905Cae2+mgaM1mgJcCa7Zccy5JLHnKMZ+H/vzC0kwGl6ikZ?=
 =?us-ascii?Q?WMerf2LzjvZRwTmxv4kQ3kBvDleZUDVCMZzAeGKFnXwlrLLOC7uz6Q5RlvuJ?=
 =?us-ascii?Q?+jktKaaRX3iQdNQJbOXhYS2x0dxNbjCygvmkmhgMyKhBvm2iV6ePLNNHMRs7?=
 =?us-ascii?Q?ZSjRv/dMHu2AG2QH7qtToZ5EfsSglp6pefieQU6FhrLgTCXYc4Gh7R5oUgMd?=
 =?us-ascii?Q?KLi6kmgp7nHwwy1XQGCZ8k7tFXF/OWdJJfja5UA4aKLtTnItVrXgszx8UgC7?=
 =?us-ascii?Q?cLwL+CsUmf7OrE+io/4Rc48WUCSLuJLF/QVBmwlZMahBPg8bCzmrnff74trK?=
 =?us-ascii?Q?DdS+GEi9qt9LEUFp186H1lT44KG8n2MkUP82UNiRNSgJJB2gcWefI02DMvyh?=
 =?us-ascii?Q?xVZXdepZs5M1P8J5oMvwbIWns3VLV04gPT+/fbfU0GDsWtSkE7mapj4g4QeZ?=
 =?us-ascii?Q?L7X5hexZLM1yaNljUxYaO7FgCqvaoyo=3D?=
X-Exchange-RoutingPolicyChecked: GpgLTPMTpc9/uyGMlZmlB+zUrgeBI5H4s3A3OShXHAXeGr2ZAkrAQePgv8TvhNjVXOqBPpo5O65ilqPjHSoi6RTnCFZGafhYaS/6rYVendJ6H43UELaPhwQiSlKdXqYkmmawdCim9FORozR7d19nkgXRd5npoDRfqz4v7dDxTc3iigbg5xh2Xql62D5uIa7S3nKjmtC0NpPZjK8BqbBjeMYF29zRs2350ZvePIcGTb5Txo9dPQR5Vdc/XxHlPngoI8XgEim2Mwy1A8rsG/y+mE04EKCNLRBgN+7m+OaoaS+JuMDSzut9kljsCvl/pYBGvjiOl0NYzYogQiG27AyFmg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 896f19a5-da17-4f27-63e1-08df3e55f0bd
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:38:14.4163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uDumcEf1TQYl2DUWHmONAc5scwtIwDsuHIYVCylsVQjLnabRO4BJSL8SiT+L5pWqPBhIYd0IPfO0ig1PqSULFLTYw8nz+ncpq3j6yL50ocA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7199
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

There is nothing preventing user of shmem_sg_alloc_table() from
passing max_segment smaller than PAGE_SIZE, which would result
in nr_pages = max_segment / PAGE_SIZE == 0 and cause a
non-terminating loop.

Suggested-by: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
Suggested-by: Andi Shyti <andi.shyti@kernel.org>
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index bf9e7480f0f5..e35ee4bd456f 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -85,6 +85,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	if (size > resource_size(&mr->region))
 		return -ENOMEM;
 
+	if (max_segment < PAGE_SIZE || !PAGE_ALIGNED(max_segment))
+		return -EINVAL;
+
 	if (sg_alloc_table(st, page_count, GFP_KERNEL | __GFP_NOWARN))
 		return -ENOMEM;
 
-- 
2.34.1

