Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61543C61DFD
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D7DA110F097;
	Wed,  2 Sep 2026 08:26:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lq/EoOr2";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A2110F08B;
 Wed,  2 Sep 2026 08:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788337566; x=1819873566;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=uVltQ08j5fnCgg1uPXd+X0hRqY8XQB2y9Ix3AohUSGs=;
 b=lq/EoOr2f5caKU15q8egHHoZK8lcymgpOlWtzv6y/i+KG7fdlH23xkgs
 1G8Tr41JILW2lZQLawdH1wo0YtGDyhB9gCEehTOC7Rqm/+seULmLaV1/z
 BrlVVhMoR42/HPQhvx9j3PSjzsSn7y+nsicgS5fRLNLizagjMwRTr1qED
 redsh1K8a2AL3d/H/tru2I7GlUtbltcDRg1c+pX5xlODEuuxOyMtndQsz
 NoaNgT3i53jXmickC9hIXT0KN4C4SzJsDaTkqxLiLqIWhihrsLt2wEUW3
 Nr/a0KF/FkDC6I5osn9XiIKR1zv9IVvEqm6rnev+5ZzE/lMBns9tTrfNl g==;
X-CSE-ConnectionGUID: Ecqa8n0TTgC3VwzUjxHFiQ==
X-CSE-MsgGUID: 1eUaioJaSRO5UHA4TgbDlw==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="106156740"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="106156740"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:26:06 -0700
X-CSE-ConnectionGUID: +PJ6KkAuRcySapKhYfN7xg==
X-CSE-MsgGUID: 39dZsJN3Sz62N4QkiG6geg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="269364501"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Sep 2026 01:26:07 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:26:05 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Wed, 2 Sep 2026 01:26:05 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.70) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 2 Sep 2026 01:26:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VtlWl//VyB4Xb2Ia/1uFdpKlXoP1lQOjmpXVW6/FjaS6SXXhMt0MIDEru0nhgvHkZrjfh1uc+cjhelpWUwW6fa4LOqkEcS+mCkLw0RRPCDtzHdXbj7Vl9cz/PG/Ry2h/rjbpkni0OSGaTFZaFysj7POCYv1wDuIsskrjWDEkM52o13D2+n9n8b8UHgm+1T0Zljg0PGi/3fQPCYog7jqALzmBV9e/NlY8LgeHKKePVBLB5ueSUaEUv5g14/A0JLIYA3xVikDpk2q20KIBbat1d/lNECEFDapTStRkzaXct2KqZ5phBhVvx2UczNrYkB+xhqQ7+xBdG+giea59eDFawg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zOU7gxe3RyFZtsG46B+yHUxy9V/d2w45msoR656ZXhc=;
 b=fXPXS5kCoYDe4yrtPrNA56Urk0IM9/zgVAFxfoiGDusVu81ykHvdmsm0MdqQ9gmHGYqh9DLgqUYk4oX0XFqDTfNQg2o6u7+ZAFdkYiZIWF9axGcZCFHk2GuXn7XL6OWwra+hMeUA62pIWvcaEPn7AG3x+iCOwxIPm2qnVpor3+1irESwR/+v6bHITuSm39xLkB31r2N2WFg+aVHha8LpuLpirDG1uvcHQXVEAJ1SLu8Mp00jmuUJG35l4FVyGl1pJJ8M/ZBoOSIaiT5UMrYjx0+196C359c7sRTeWULLIADaJubANdrUZqZPf1+JyQHXEvDJD7f+9EfNhI9Ayl5FNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by SABPR11MB9937.namprd11.prod.outlook.com (2603:10b6:806:4f0::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 08:26:03 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 08:26:02 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 6/7] drm/i915/gem: Read and shrink memory in a separate
 function
Date: Wed, 2 Sep 2026 08:25:24 +0000
Message-ID: <20260902082525.1149367-7-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: aff294b7-04ef-48b7-1720-08df08cbd2fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|6133799003|56012099006|10067099003|11063799006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: Wgyn0aWE3MsiknA44TcVyLsZ6unq55nRw58MPPamNKltgvvGibpVFaMO1n3j+WpC3XeyAM5NOAK9dClnSSAlQx7DtH3973FCs0BfwwxnD91LwtymnpO+wGcyviHTwBZtBwdGbHBx9P6rNAc01pNJKuVuW03QHm941rE9fb8evdMrRhl3crKGxJwDLIRBinVW3IK8FKUckrKpkaqQ7CddIxQXpkqcoA1yGDZ59GM9ZULpppHicBTkYtVxvUq1yXmU8zM+JZk+0g8HcpNZnoXZSIQFCSG4/LNKY+ifeHv+myH5I1bH7+EsB5KzhZZuBe/H8Z2aVZSKnmseAdoREjPWK8GvKVO708qlBhph2eaxN8n8GHfC7tRl7o1LER9rAFzDyyivoxHJmI3Ck3bHns63zuNbrMNBptFo3Pif68wbcZ6hf1R4PwhpzyFXc8X2wuIamhu24RaNUNJ27XE4bTetqb/fw3fPhjkFakkARgUocU/EQyFHKya3ob+Uyg7UQfo2B3LYZw9NMyJYrVhGgMfKZ+Uwh23AqFs5zo537kbNWoLnmsH0R+aAbgsSWbBdIG6JOuUyx3SlztPa5jGpy8K7cns6VRFBThzaspmoAucfuH+m7c7eGJBf0cj5V/vFJLX+R4OuyTNkUYzhjlgLDSuGw+882zqVX0BtTg3/btuVIQ0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(6133799003)(56012099006)(10067099003)(11063799006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BAERHe5zvuyC5+xyXpWwvAFUpLV2ao9Nj+CYz/bl0L8y2wiO/ULskFOXsHgX?=
 =?us-ascii?Q?2bHX73GJl5xllN0ynoSspHNMRsEANZk91y2RLhgCP5CAtfsI5wnx2aKuzc2l?=
 =?us-ascii?Q?6exNEGz7M9Hs/XBaxgFKxE8eGjI8JRxAcMd9FYo6gfu+dSriEg6vjuP3v6ZW?=
 =?us-ascii?Q?MNKeRULTvieDJrlm50CKSbFcwJVk4AZTxgxr+lLdmEuN9ZGmeqtv5clp0Ft+?=
 =?us-ascii?Q?2qHa9b1qhvbeNZwVTAeNEe2UjZg7uBbPK0j7SPscVAd1ErSgg0XxvNxyPgYf?=
 =?us-ascii?Q?/HDF6vnbwYyXSO5jguPxNxjz1yPTFGGkJdE2zt9LhZJuAmCwxsdwinv2dIwG?=
 =?us-ascii?Q?1MemBSdOTTNDmOtA3hWM87N+LzCD1EZgLW/q4fpBF8zpPKB2f2JlMsSv0Oqs?=
 =?us-ascii?Q?oVljPDBlHCiaFuhDVIkeEhzHnrthMnIm5+nYc+7SYeEerrxkP8V3v7tl3lPr?=
 =?us-ascii?Q?wZ275F+xmLQvY+GlpYNeSVKWEM88AOORORvb4UBoJ27t3l58aJ78Ln/jTB2B?=
 =?us-ascii?Q?Ztu6LsPZixrtZ3uczm3B1N6KpsHDIqScwpY9RGAAjaeR42QHnt778U0zD/9l?=
 =?us-ascii?Q?kCujliNs/lR9YwhbRe00GjynoWl/Enk4JaQU6otnAwebQZcMeZad/HwPODOF?=
 =?us-ascii?Q?7D7vSaec6vepk1g6FWxxQ5Mfcq3Who0bLe9u4rL4+pMnSLoWBdvw0vgVRVqG?=
 =?us-ascii?Q?N5jcB1ObtnEo8z/OhvYS/C0vaNAA/ZuOHKDqgDWXU5FCLqji5vRkQqZYsgg4?=
 =?us-ascii?Q?3/Va8ayRD/Yd7DmKEQeoxlDhU3AZikhJggX302fi5C4nbIHuocpbzaqENnkf?=
 =?us-ascii?Q?wbeZaEhkTXXFYUmysDrXOvDTfpcmJmqfC5465+0eLZB0887ySIehj4aR7zMN?=
 =?us-ascii?Q?0i7vAN1jbSqdxew04MCXIx/qJQs+Cq3kPKep5D36fqjvzB6fARx5Ogu5ajfN?=
 =?us-ascii?Q?aqRm61rTYQbbjv1NGMmXpDp2LFUEYPgH28mw8vNKy7AgssLE1635KBY4ow19?=
 =?us-ascii?Q?4OfSMN/iglZ7dzHaS7Xku+4e19RVdyz/yfT8b8X8ATos6mj+1exSJEU8Y2Zg?=
 =?us-ascii?Q?v7/jTsVkMDOYKyuAbUp1dmQPgN1aUfTWmrgtpqcyh7cNcqDAGacVv4fyFkR/?=
 =?us-ascii?Q?OHWIjPZ+vS9YEeZrjnMtm8hP6WDmjqv3IebxvW018BkxEPN8Toxgw1yDXIF1?=
 =?us-ascii?Q?w9Bz5a/d33biXuwdV/axuwEa+2AHgJfzrPYAKGrnRePaLhoMdCbHOGUmG4ha?=
 =?us-ascii?Q?mUKDsN4D9tH2Ljmpac0SDnrT6ffbYJNFgKfEYAautnvI893VKQsS5kC8q5np?=
 =?us-ascii?Q?7oMmcEwD0ASlQFb4G201PznCyyI+kUJzz3KsN0D+COU1yZ8bMyuEK3QF4ofb?=
 =?us-ascii?Q?mPiu0R6/UavJSvxd7Jxt2BPEbcNbL0VQ0OKXZ94z7Jnr5m6ugOpkj02XD4Fo?=
 =?us-ascii?Q?4VQQDi3coqQwCRpYDvHw3P9MkwaIpECefMmThsIlJQ6Hlj8F5QYlsOAcNCJk?=
 =?us-ascii?Q?v0wJ685E3J7joIo+RpDtlWS/Rb0RqpKybG+w1OBes8re3TU4AvcUEtY70LmL?=
 =?us-ascii?Q?LQCJ/Hyl/Ybdb9QLi3kWNWyzu58lUKV5CURxoyN7bz3atbX6t5QkukFObPEg?=
 =?us-ascii?Q?u4WhZHaky/JljRgsKZqnJDO8iFs7lFvX3Sgtn/xcB8/gpfKH6g0xIHCM3ttE?=
 =?us-ascii?Q?U7RNef+zP2jTN+UkCVhmWhnH/NtHjdELtDhjTCUsY/4XGOYZJ0HQx9+0zuni?=
 =?us-ascii?Q?hqPAnsDHowiILsUN2WI7pc2+eKKLVS4=3D?=
X-Exchange-RoutingPolicyChecked: 1egvvhe8uWIod8I5BQ6dYZaB31HUJISS3cQhwi6ge4076dTR7Mcsdj84PNP4qnRiVRIiHd+U/LNlRW04EPuGw9yovNdUby3rwyJry1K6vPQvwqfc5R+uiXxJ4/74Lfv7apMxr9ouZ280CNlLlDQgwLqxG9dATfkHL3I5vrzuwLHH53Jo424hlre5AkrPqd/4e4FYOb0Uc6GWumEkpMDGw2XhHl71HWFODkH5rDTTjPLmHW8E4rOKNjXv2eFFft2cHCr8bMahqK4ykZ9N70LhuU8LW2BQM7RhkbvDVtJajnoqeOT5x91ZQHR3uQl0wYh+iFHiTEwpOYeRcgoRWo1m4g==
X-MS-Exchange-CrossTenant-Network-Message-Id: aff294b7-04ef-48b7-1720-08df08cbd2fe
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 08:26:02.2741 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O5o54RlNKNL9miB+dRt5g68tnF9nxQYsPZVban1iENbw2DEx8yHWg0o+ox9DERzaBq58SeMZCengrquIWQsUq7sbAO6ktplv2WcGB9PvnOc=
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

Continue unloading shmem_sg_alloc_table by placing reading
folios and shrink call into a new helper.
Make the code a bit more reader-friendly by removing moving
over structure elements and replacing it with a sequence of
instructions.

Assisted-by: GitHub Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v6:
 * switched to passing gfp by pointer, because in v5 the mask
   was local to the helper, so
   GEM_BUG_ON(gfp & __GFP_DMA32 && ...) checked a mask that was
   never used for the allocation;
 * dropped useless folio = NULL initialiser;
 * ran final checks with Claude Opus and added a tag.

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 103 ++++++++++++----------
 1 file changed, 56 insertions(+), 47 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 3915633e52fd..0fa34a4ae466 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -79,6 +79,56 @@ static int validate_set_page_count(size_t size, unsigned int *page_count,
 	return 0;
 }
 
+static struct folio *shmem_shrink_get_folio(struct address_space *mapping,
+					    unsigned long folio_index,
+					    gfp_t *gfp, unsigned int page_count,
+					    struct drm_i915_private *i915)
+{
+	struct folio *folio;
+
+	cond_resched();
+	folio = shmem_read_folio_gfp(mapping, folio_index, *gfp);
+	if (IS_ERR(folio)) {
+		i915_gem_shrink(NULL, i915, 2 * page_count, NULL,
+				I915_SHRINK_BOUND | I915_SHRINK_UNBOUND);
+
+		/*
+		 * We've tried hard to allocate the memory by reaping
+		 * our own buffer, now let the real VM do its job and
+		 * go down in flames if truly OOM.
+		 *
+		 * However, since graphics tend to be disposable,
+		 * defer the oom here by reporting the ENOMEM back
+		 * to userspace.
+		 *
+		 * Reclaim and warn, but no oom.
+		 */
+		*gfp = mapping_gfp_mask(mapping);
+
+		/*
+		 * Our bo are always dirty and so we require
+		 * kswapd to reclaim our pages (direct reclaim
+		 * does not effectively begin pageout of our
+		 * buffers on its own). However, direct reclaim
+		 * only waits for kswapd when under allocation
+		 * congestion. So as a result __GFP_RECLAIM is
+		 * unreliable and fails to actually reclaim our
+		 * dirty pages -- unless you try over and over
+		 * again with !__GFP_NORETRY. However, we still
+		 * want to fail this allocation rather than
+		 * trigger the out-of-memory killer and for
+		 * this we want __GFP_RETRY_MAYFAIL.
+		 */
+		*gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
+
+		/* Retry once after shrinking and gfp modification. */
+		cond_resched();
+		folio = shmem_read_folio_gfp(mapping, folio_index, *gfp);
+	}
+
+	return folio;
+}
+
 int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 size_t size, struct intel_memory_region *mr,
 			 struct address_space *mapping,
@@ -120,57 +170,16 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 	for (i = 0; i < page_count; i++) {
 		unsigned long folio_page_index;
 		unsigned long nr_pages;
-		const unsigned int shrink[] = {
-			I915_SHRINK_BOUND | I915_SHRINK_UNBOUND,
-			0,
-		}, *s = shrink;
 		gfp_t gfp = noreclaim;
 
 		/* Grab the next folio if we exhausted the current one. */
 		if (!i || i > folio_end) {
-			do {
-				cond_resched();
-				folio = shmem_read_folio_gfp(mapping, i, gfp);
-				if (!IS_ERR(folio))
-					break;
-
-				if (!*s) {
-					ret = PTR_ERR(folio);
-					goto err_sg;
-				}
-
-				i915_gem_shrink(NULL, i915, 2 * page_count, NULL, *s++);
-
-				/*
-				* We've tried hard to allocate the memory by reaping
-				* our own buffer, now let the real VM do its job and
-				* go down in flames if truly OOM.
-				*
-				* However, since graphics tend to be disposable,
-				* defer the oom here by reporting the ENOMEM back
-				* to userspace.
-				*/
-				if (!*s) {
-					/* reclaim and warn, but no oom */
-					gfp = mapping_gfp_mask(mapping);
-
-					/*
-					 * Our bo are always dirty and so we require
-					 * kswapd to reclaim our pages (direct reclaim
-					 * does not effectively begin pageout of our
-					 * buffers on its own). However, direct reclaim
-					 * only waits for kswapd when under allocation
-					 * congestion. So as a result __GFP_RECLAIM is
-					 * unreliable and fails to actually reclaim our
-					 * dirty pages -- unless you try over and over
-					 * again with !__GFP_NORETRY. However, we still
-					 * want to fail this allocation rather than
-					 * trigger the out-of-memory killer and for
-					 * this we want __GFP_RETRY_MAYFAIL.
-					 */
-					gfp |= __GFP_RETRY_MAYFAIL | __GFP_NOWARN;
-				}
-			} while (1);
+			folio = shmem_shrink_get_folio(mapping, i, &gfp,
+						       page_count, i915);
+			if (IS_ERR(folio)) {
+				ret = PTR_ERR(folio);
+				goto err_sg;
+			}
 
 			folio_start = folio_pgoff(folio);
 			folio_end = folio_start + folio_nr_pages(folio) - 1;
-- 
2.34.1

