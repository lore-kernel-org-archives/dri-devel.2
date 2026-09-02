Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E803C624D4
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:26:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9EEE110F087;
	Wed,  2 Sep 2026 08:26:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kCC63Hm8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5856C10F089;
 Wed,  2 Sep 2026 08:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788337562; x=1819873562;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=9lNzGuI2564X8t0P5KyPfAf5zBO305XZd7AVswATMXM=;
 b=kCC63Hm8brFuw1fpYTaOLjDlyGfoFzGECbUxM68vQ4fTGLggXS39W8h4
 Dx+4uYGk7lokCRJTUR3McqKiO7Nv35jYyfJ7EHe02Voae3/SwvZPrjSFW
 uDYE9k+KS9R4FKubjokLjMOGW3s2ELyYK4XK8pLmp0Ah41HiUI8n3PnF7
 DO0TzddbrLvFT5c4H7SRqf+pieQHAE+YGlWk2OPaVsLl/Tdy9/U4hvO7o
 B5i6MnFOqMjUVIm207xHifqgFvTxi17jaDU7SyEZdy9DvW13svrF/gfQ6
 7kra0gkLfM6Qvpd21kp/hZQuLwRQKp4ylmDMY4Z56GXL+buFNAjdA92oy A==;
X-CSE-ConnectionGUID: SPFqCNAeR2Ox+YGciClC4w==
X-CSE-MsgGUID: rE9Rc0iSQ2m5D/RNq/9T8w==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="88994784"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="88994784"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:26:02 -0700
X-CSE-ConnectionGUID: SQ3XbEmGSCOG+lLciC7H7w==
X-CSE-MsgGUID: acl+01E3SPKI/2S/FZHqNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="294180952"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:26:02 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:26:01 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:26:01 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:26:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oFTihllFPlpo1ISuIBRBG4DVPy/bCfK9HuEKYMs2Y/XhTGudrcBx7oG8XWk84y9Pches3jW6B8Ix6xjmwHfF6I+hBq+ySLn9jzj7A5MGxbg6QBzCF2jqQsAq48JcJhA3cEmI31LuyHGTfD3cAqMiLoQkIrH4j+n+9GA1XApUNWcGizycHJnl5o8UfrW0onzzRJYVzQ+8M5ph1XmABGDMmBf9FRZT7ePioGOPxzcqPNsGz+nJQNWnP/HPFYPL1uJO5aehYPhEsJUbiaI4cRx0Nynolw6wMJRhe5DhcKPhHHS7NJczovnfUPHyuljNUF9hps/gF9XZaWnPr//cp2KXag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UpF+M/wAW8vMVzmbLZjfSbF7X1glvMBEkQafrC1P/zU=;
 b=G+eroQa98Ph+gcC3e0xVV83hE3891A/f90Q02wbrRsqxBF3svLhhGmr2GB3O+v0Ko7/iRdDEUFPvNosdSaDAtptKWlzk9/wZ9vUQDlA44bYQx1XdHHCrpijPT90aH97LUyRLVAz1B3qbgzxryaCs0HpKaEMP9alMYu748v2xwJaVATCriwNIxnVO0MlUPHLC2A2iSxC41h4lkD/Y/iqMrVxPnxWRW2+S0KwzVnkAn24+GJA2orQONHQHKKvOfK5jLMZTeHyqK7oudGBjuqmbc/HoccpGCjhdS9JaVnL/nSoBp/9A3ZR9us7eqErQvLClvRKJps+SQZwEYTJKb0jbiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:26:00 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:26:00 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 5/7] drm/i915/gem: Pull out size validation into a separate
 function
Date: Wed, 2 Sep 2026 08:25:23 +0000
Message-ID: <20260902082525.1149367-6-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 266fc084-f411-4f33-2dad-08df08cbd196
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|56012099006|10067099003|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Hj9dsEAoztcq2eDTzejZpN8FE/UkPhi7OsJpwbnZ4szHJF6ckR3+eMsJ+VXOlQpD4TCtRlGu1YhBI1m2jZGT/oN4W06wEwQ9hHDUoq+SWwQmSPu5Zws+JgE5yfAYbeT80svoZfA+Vfr1PXUjcEqlWQiLHwtGauNrTfk8ZyP2xHCbcH4ZNlnpXSlsVol16/dL5CzZi6Gras5bSjcqTjJmemId00PLx7JDh9ObX8FLiT7WP2Kf4ffY3zRs01Rd0NDuQ48w0utiJjdB+RxBAAGEkVczEon+AXtBWYROEp8gkFcDrkQfx3RHQyUu0Vg2A6aE45+y2BCYfl6AQ1dDD7Yv+dzo1fEQDhR2pd+HyS38dWsjWZgSiRpJ7M8+lKW5Josh5pRjvweYCyPG7G+Mx0a2Ee/XT5sxNm0A6+tNkfsf5sYaAuj1jaL5nE/0x72kl99vEPdYmilu/Epf1MxCAqtLvLMM7Bs0ZKTVP+3p0mgek4zpAw5VNveZ34L+y5l6QyYiNhWhrc2vo8P+qK9jj1RxWSrSZiy8pB7ZVEJhOIplzZqwqpIK22hskC1MCnIzaecloFb79cFadoJuciRp2I1I2oYFcY/F0M14sMvo+mheLmQc2rg0JkDITEeekvQ3s2ZcHcGOIRTa+gVd48V8Bwva5WYUhukn2fJHa4AffVrm8+0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?daYgtuSO99FKcZ8MRfuKx1Me0X0wfi3BnZbBu3OdfAdSprcChQu5s8MuB8fb?=
 =?us-ascii?Q?95Ww/eN4NTLHj6z5wFFKWAFTSXh/Z+BMsazG0kzYpljPVglfEJj3Jjvz//U1?=
 =?us-ascii?Q?q6WB9l11Ke1gC7URXTFQDszWshmwRHPskTWAK7nM7CFslRjOi8nczZsj6asA?=
 =?us-ascii?Q?XtoTpVWDeT2v9QGBSxKSRO+zlJsmdjypDPf4Yapoxd5VphmR+Qq4wSMbZb+A?=
 =?us-ascii?Q?t5pXDtovUgFeeQqBP5/+pCBzInsWXHSsdDQFhRubKiDKOhvQFmM3KpBVWRK8?=
 =?us-ascii?Q?xIefF1kKQS40/3f9w1ZFU0U7yQoy/QJUEjZ3Fs7HFeMvJeCUw+I5I0sAVSV2?=
 =?us-ascii?Q?yxhi5bLkuamK4aXL+uv6lXUrNOG/BFhwZoYjjih+6XkazeFZquI+ei9Cl96L?=
 =?us-ascii?Q?4lk69D6vPzlrbVYxKEjXDPGoAplbU7vreaFdxzSNAFLedS9SUJsTT+iu03c9?=
 =?us-ascii?Q?KSY1/ArAFLirW5g9Z5Ag2Z52Agg4D6rQlX/72RjPsz4G+yM8mh3Eo0CwoaKv?=
 =?us-ascii?Q?fwD/wmfGWJJU077HNtpAdZuSrB8geUmmXxc3Kc7hT0F1LY+CW1VMaEs3/yGo?=
 =?us-ascii?Q?+RtpmXQ1PIwifqcsurZOiPtS1bjkHgxgpUbR0dWc2Wgstkjh8atS+sUcAZJl?=
 =?us-ascii?Q?Fk/7IKYwYsnoGGB74lJVMvPAI/YLhzo+xjnBwfOOH1WolclnZGjt26fe0ILt?=
 =?us-ascii?Q?OpehTtnsqv/QrNKCuMVi6v7a9PwGMrwUpB5AqVjR85rAfaIaG0RgESUT5HFb?=
 =?us-ascii?Q?mmEf0ojXvkAMvfFOGyZFUlH09DNWxHX6M5EYmr8Wv+zYZn1yv6AKBwNoMqDA?=
 =?us-ascii?Q?p4D6cxVIzv+605u9rzx4M1GYf2iCoJew+b9SaetnCVO7EJ5w09aDBbGv7ene?=
 =?us-ascii?Q?IQh0m6AeKaleCLOSNiSKXJFnmqhLqpjtHtem9XyYxt7AWnfgwXLW+aeQFAds?=
 =?us-ascii?Q?mts6Em+sLHJc9DJ6zBiEUyBnFwx/JqgsnfzC5Lhx1ssINIWpR0W8p/Sx6nZM?=
 =?us-ascii?Q?yqzfREHer8dhyAO3Zd7p3zfroc6a4eSy5KTKlIIHAXn6YfqX6FTrRwK068HU?=
 =?us-ascii?Q?aRY/r9OGtTKoqhgLeW1IJGWiYti9xP6ED6E5vRrN1gbKh1c8khJ6oPTHP65v?=
 =?us-ascii?Q?rraoZ4tC0KT8b81wVnY+cyT7A+MVEWrekH0Exa8bMeMPzzyNBgUN1enoPfNC?=
 =?us-ascii?Q?VUd7xEB7ANWDpgMJt+Vr665Fm0zIX16YdrBF7VngzDwkUHlxh4XBUnIeNoT2?=
 =?us-ascii?Q?Hfjtkd1pdDMMZ282DZ9xcKe4Z6TDVoY5B68twueUB73Y4w8DeMw85TRwH0KG?=
 =?us-ascii?Q?nt6wIDgdKHfqN8fXqwmHv0ZC75a+VzAHXxfVZqnRRD707QTSgAJChoE1uiEE?=
 =?us-ascii?Q?9rPn2GpYoRds5tpCvBN00c8hwvovEXzNeE0+vIJc20he44tnLLgJcds/lb5o?=
 =?us-ascii?Q?j4F8Z8bV017CDHlQjFDOmrRmGG3oWK7Jme/8he6rQlIP4y8ezyspJbRcGSXD?=
 =?us-ascii?Q?RlAVlwilr6riQOKFSVkXSSentMU8OqPS7268u//OaaQMNqra30lu9bjuroQU?=
 =?us-ascii?Q?MunmzTIi6ih+paSag11W13AEFv4c7xqyNECYADEV1ZBnb7LkJkjJeisoa8LK?=
 =?us-ascii?Q?AIW3HNSVcT/0qN5WUG8CcDwo4GZOzuDGYTv/gIHSoimpdUFQ61LtiZe5m4xQ?=
 =?us-ascii?Q?L01TN8KFrLFsuBzgwJvKlohAg6uED+RlU9zfekoeYg1T39kC89hSRVjyXl+c?=
 =?us-ascii?Q?dgHDa1TTEoWagb7IPzp04Ala4JIIEJQ=3D?=
X-Exchange-RoutingPolicyChecked: g8uLyTaB3Uo1iAi2cMq3sguf/HmOQMeSSx+/CKLMVLWeNhTsVyLOlvur253qltn0ZNuuNpFtVbQcKiVS4el7FBZrjPEsbx4tedpfE8B5QWRDT4RCCxx3g3ia01HihqSh+U+tzR4WHlMMMRsZ2yaxhga147Cki/JrXxsxPlBlDOtCI1rnahPjOK9OdaQPFliQ96tzvGAHixMGj3ipiYMok4JmbiuKAfPAMQhAwYrUB8b7w4QFwKbI6xrc9PuJT+XztDqCWZGEnL4y+G8XTQ2SkiuPQpW33VlxSAgX+PO3huF8nTa7Zm5UgMamF84YIN366x4tJjrjZzE6I+8oxPUJgw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 266fc084-f411-4f33-2dad-08df08cbd196
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:25:59.8914 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cfRFN4X5IoJipA9TMICOxEfWpJnPXZGT3k9dWMKssCdDPE59fTc8v0s1EAr+URugaUtrv/f+EzRFnF5djf1U7h08kYJp7fDIvdahgB/PVl8=
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

shmem_sg_alloc_table is a very large and hard to read function,
so reduce the number of operations it is responsible for by
placing "size" validation and page_count assignment in a new
helper.

Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v6:
 * renamed helper from set_page_count_from_size() to
   validate_set_page_count();
 * fixed line alignment to satisfy checkpatch complaints;
 * ran final checks with Claude Opus and added a tag.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 30 +++++++++++++++--------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index a84c804726d8..3915633e52fd 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -62,6 +62,23 @@ void shmem_sg_free_table(struct sg_table *st, struct address_space *mapping,
 	sg_free_table(st);
 }
 
+static int validate_set_page_count(size_t size, unsigned int *page_count,
+				   struct intel_memory_region *mr)
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
@@ -78,16 +95,9 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	gfp_t noreclaim;
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
+	ret = validate_set_page_count(size, &page_count, mr);
+	if (ret < 0)
+		return ret;
 
 	if (max_segment < PAGE_SIZE)
 		return -EINVAL;
-- 
2.34.1

