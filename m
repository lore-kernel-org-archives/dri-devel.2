Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27DE4606A31C
	for <dri-devel@archiver.kernel.org>; Fri, 27 Nov 2026 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=U7FiTZ93
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0FAF3112CB6;
	Fri, 27 Nov 2026 17:59:41 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4EE2410E8F2;
 Fri, 27 Nov 2026 17:59:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795802371; x=1827338371;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=aeKRghG8oinlOH0XayZZovSoPQC9u0u/HP1uafHpSKw=;
 b=U7FiTZ931tLSQqjMdSYGKdjjVQLAMkIKVO+TsWaM/aSFVdFQuKYtqAS8
 mq1aWV6+ETOMmLUEh7htRtWFeDogiPcY8rkEgsPWl+QFq3BhulfL/f1+T
 DNz7ykazeBGD2+OUinbM6Mbhjm5GKBxk4B66APtseEY8dOejVhFydrNDU
 +dpaAYFBy4bVczQC5AFSlSiigsKhw2zJj8vRhYQCsKZg2HJzK/3WusjHB
 uXFY+oUkIJPrYijpkvVkbjetirM3H2GLQtwWekefp8OJHYdUuw5FWEhzX
 vFA4tIPnP9eowj1oPjSGldVP7Slvkn66z54+R87T0/C9jiUUOXSswKuCJ w==;
X-CSE-ConnectionGUID: qoo4Sph5QtaBJgj53YfFxw==
X-CSE-MsgGUID: dAc2HuKmQoapYCfV+vHBRA==
X-IronPort-AV: E=McAfee;i="6800,10657,11979"; a="4783681"
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; 
   d="scan'208";a="4783681"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:31 -0800
X-CSE-ConnectionGUID: WZERRkxISRixu2K1lJuzLA==
X-CSE-MsgGUID: 4ez1fEcaRm6ZUJCN+Hmthw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,237,1787036400"; d="scan'208";a="12734239"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Nov 2026 09:59:31 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:30 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Fri, 27 Nov 2026 09:59:30 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.66) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Fri, 27 Nov 2026 09:59:30 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UF2FxlAXNiCMRzuz7A6f8ibEzpFeVnxOO7nZeEFwhsbpd99JnGJxC2w4KZCMNHkykkPUgQ8aTTwAWU7Yix5mhEOojlSdEwNaU5v3usAmvjZXCAY0ya3YSFqy+GJHQJxvxefFd3PNLYmV5nVfZGmKnr+qwRvE2gm6XkG4P7DC2tPSu7WfjwWT/NmlGqUhPm8aMMEuFu98ZvCTTZXMUged0bJFHdlZVhqumpKz72P93We333H6bfDBr63GK+OrdGEh0kuKNeM4R4Vg3Ylea4pdtZEmvwJzOJx7INf5t+1fhoSFOZd81PGLuRgudrd17joIy000FeEcZFATcgNiUSA5wQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcEHB5DWcYjdaeAOVYp1NxOJkEtZ6p82HKXuifL3NOI=;
 b=CEbGgjo2CCEAl1P1bRLFkhw4B0fOD7wXHaPH78bQyq59Rn6ybgK7Mi40QpXMDif1B0W+nlZdSrs35nsAevfAW8twxrvUsA71t75OeoTmHn6RfSGRabKgUb3rQkXjG3PUH5ySaSArBVdQcefRiDV997NviPDwkpULiDcVRZbS/ZOaz3VQ7mnSbGreFEU/D+hZ2A2XRwZ+D4vk7A02/aCX63eT8mb5x6b2HGOrPwCLDob2rxrSDbOy+0kJLpcwRyQZ3X4Kv4b4EBOxJcWqYEZF3c5fkaIWDH6RzgrHUA+q9s6T9LowoqNzQTHRDE1wA4phEgZCvRQPy/yn8WOdhE03Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CY8PR11MB6865.namprd11.prod.outlook.com (2603:10b6:930:5f::15) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.9; Fri, 27 Nov 2026 17:59:28 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Fri, 27 Nov 2026
 17:59:27 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <intel-xe@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo
 <jeff.hugo@oss.qualcomm.com>
Subject: [PATCH i-g-t 4/9] lib/igt_drm_ras_nl: Add telemetry helpers
Date: Fri, 27 Nov 2026 12:59:15 -0500
Message-ID: <20261127175914.784751-13-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261127175914.784751-10-rodrigo.vivi@intel.com>
References: <20261127175914.784751-10-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR13CA0203.namprd13.prod.outlook.com
 (2603:10b6:a03:2c3::28) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CY8PR11MB6865:EE_
X-MS-Office365-Filtering-Correlation-Id: cb0429b1-c0b7-4ce3-c1d2-08df4cb02dcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|56012099006|261022105027099003|261028144727099003|261026140227099003|261102123227099003|261026121527099003|261021123027099003|261022075727099003|261021121427099003|10067099003|261009223027099003|18002099003|22082099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: YBOGh75dSB5C+aPqC52Z1vp1bD/QwLVJROaP0MYfk5j3Cjqpn4lU93H1lUKQysBvokSzpQxbAPVFqPDIfhhtmpMW7MYUlWk7yJS+TDMtQ4rEJk+57fU4wBxOGya8PCuDPxglbGuK08fN1Kx3/eW42wE10e74TD/IzM+ilr7lBB5sfsb6omibYa8e2Lye3zajANT/3ckA2hnZuqP+oe8C7Ku4X69RG/33e4CV67dn7KJjJ5OfEGqEiyuoO3wRFiB1JIATv0WhVBEdpJ4ahU4sWcjlI1nq1PfaokFNb6JUYppOpVYWSfElL89E8itTp4JTd1PJJCRfvxZSZC/FFX9stx6zxunMWz/dMtBdTtmJ5poOy/8qGR+nwVNV1/1jJ8nQid9tsuBevDzmEyRD3ZU0Ie9Z3xFrB4/T6OwsFZrxl3MtwMGCrCkWhoGiDRB5I1X2R5J3S9NCi/1PHKEuUACUiboL58r04F8n52stpVrliQs8/ohnYtPFM2ZSkz4lk9q3HymikIBcUhIwfTjiAQzz/cVaDdSQCZVvq1m+14N7oXTVxeoG2pA0TQLZiYJjQhIBOW3RkMkF5r+uMhx5mSUfStzqi1441YIWAnbsk8v9/t70VTgandtCKH5bQosxU788t8L1eHEn3wWOLNUcyU2G6wfzX1I64TDpaDeE3wFiNi0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(56012099006)(261022105027099003)(261028144727099003)(261026140227099003)(261102123227099003)(261026121527099003)(261021123027099003)(261022075727099003)(261021121427099003)(10067099003)(261009223027099003)(18002099003)(22082099003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?69nlhfHRz4XzutJIJY2wX+UKFi6D16A9A8s1eWe0sb/9r1SHIRiR7jxfbbmJ?=
 =?us-ascii?Q?Ac5fH3Ot+UJCnXqnzPlvx1Piy1aRkhGA+lFbl5gwW65jb/uOTHfqjvwi7uJI?=
 =?us-ascii?Q?wQVLwxXI9BNAemiEKXdqXHnMpnTfAZY+GlkEuZ5D0+geSLaaGsKYPJiq7R/i?=
 =?us-ascii?Q?Ecs4SOVJUnuyuqcjbCrgycL3no99ktH0FJ1m9ZryJs1dcpY77MRZcprPM4xq?=
 =?us-ascii?Q?YJVYdmoCsCV1FMX22EQp4/YhbWaHjm+TGCRNqjuknMTqhOAWB4RNKBSx0ggh?=
 =?us-ascii?Q?AcrNW8RF7mD6kk2O+HQ2O31e1BZ/GSfk76uPQmppKcZtU0XKyGMYNgvm8n+g?=
 =?us-ascii?Q?afGBDkv8kEy8eGU4injR8f3yMJ3UCDbJoK1drC8qkB06PEVvlmo1gen0vP0k?=
 =?us-ascii?Q?Pa4ROoz0UJGytetuNXa6Z2ZxMOp9BqbiYvo+rtrE0xtpQm8t3VLaAZ+Uxfcc?=
 =?us-ascii?Q?ELex/1Repyh4HggnsX9q1aUVNN9lLJjFofZZ9iYlxtVhx3iqRgqYpP5GJFKi?=
 =?us-ascii?Q?LVLQhF0KmV5OJKvTkEj6BziT0IWr7IuXxcUCo8xcnYw7PcKQyxn+/beHgeOO?=
 =?us-ascii?Q?pWR4UfLXrlrGEJnTVGoOwo1coO9LhoaQCDb3OkjG6tzDpoN863ja5wggdVZX?=
 =?us-ascii?Q?ElsRe3oWdssA2aBN6Lp/cvOrL7R4s1OlR6YDvH/KiJBnHIse5F0B0mXkOOZ6?=
 =?us-ascii?Q?PbasmnJ9+VWhzqk0tviaaqq2Nn9QekejNF9quUUR7Y9HZXoPCO/uI9XKEpmg?=
 =?us-ascii?Q?gJztdo9CmH1S56BPHOMHZRmM8ygub1pHyr/2CuK1qcyV3EHzXjK18go9+GxO?=
 =?us-ascii?Q?rOENDAXCMJFlLjdY2QuAHbtbJUnXig52U3xtxNC7jjOwXDrT871jdj9n0sdR?=
 =?us-ascii?Q?GqTACes6UtqIWxHUNbOwRT1MhTt3Dp36AAiBDnUprNyPBnNjC1MTOwPn2u6z?=
 =?us-ascii?Q?OgddoMgapcM6aD4wqlyvI4HdbUxdZflW3DaBBkSO9PL4G7uS6OkqmF+PyJhG?=
 =?us-ascii?Q?5tWdZ99x6KDlSMJmPemGaVB4qqeq3IZQoTtQwxdhW5HU7dY0xZXHaADI1/Tm?=
 =?us-ascii?Q?HmJ0xpCby9wIVc2SXcmzj0IgrnTS8Wffq5lRMYT8XWNXfyydCoA7aD/lmkn5?=
 =?us-ascii?Q?p6+G84OVig9NWU5GT69xr1y+DCQ4IiPYwm4werQ9rfCb13TQ5kOVL+UcTJXk?=
 =?us-ascii?Q?JaNnPE6GfOD5cYbwqTBW5wZxS/qz/C7R+sflNNyzjh0b3u13rHZYlLO0nlay?=
 =?us-ascii?Q?L+VgTHYV2ImwlxI2U21kY72iUwK3SO3TuDLfGmgQ6CtVhTHOc+RifFAfpzlM?=
 =?us-ascii?Q?BnDWH3m1AxqjZfQu8KGr8wRgNMladcKUa/4OPqPqCAoKNDvXc4iFFlbI5f9z?=
 =?us-ascii?Q?ol0QIydldimi2wUxm8wVIb0V4q6Bp3HgccptLMm0RYvChj47ghKimpnLwyAN?=
 =?us-ascii?Q?pBEv82QuL6+vj1PQRYqB7eQaOIrucgyxyHfLlarZM4bQSRlwZB6zh/JEMPfb?=
 =?us-ascii?Q?DvCcztO5iypa96HLFHIYIDHKPzUApihduo+yJsG87Q2yX2c6su7Mbt1o9NLE?=
 =?us-ascii?Q?rJ7NxHPxQ/5vmtistgvVNCbgn71OYMlB4u/Oa6ECrOyRcukc/ZZ5Dm6SIY9f?=
 =?us-ascii?Q?lC3wgNruJecONhodpTaWDoG1g2HJ+KfYbP3cnFoXEf9uNFvCI8/IUr0H6vwf?=
 =?us-ascii?Q?JysBPtM+2f2jYqZGi9oUfWBfejSBOQ1FTZDPcyCI4qppe53A1qJEIwAXcqt0?=
 =?us-ascii?Q?wyoU97NhZQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: EvMZyUJl/bGb5nWMTrn8k/8f/4Lew9wKog0qBAg6wwmDqLX3c3s9p88f8RuA//jr3oAreYTv5YwVq7PIlxm4PzRFUf667cH0zr/ZZgSQENryo/YkCV5MhG52Gp6D0YP6+rk9SoTn4f53H2hp0etCrFSxQttCYgwECNSUC7dIiX3kjVyGDkBCafVdVe9tTfpFFPklFmWsamU6qpnJI0fQHoY6a9Y+s/bASL2xdG+DR3Hz4VUp/uUym8EC+9HiDRozEJAGlMsT51kKuNtyLpmvzO+8O5LZLfB5LJh5JvoNh625y6hkB7OJOQqwirPLQcTmkhXx5oaVEKfPKL/tCC7foQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cb0429b1-c0b7-4ce3-c1d2-08df4cb02dcf
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2026 17:59:27.8099 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wxE7/6U/YfX89tK0IqItVjyygcakjUdF89pNqnk7uXIr+8G/4OD7bP5tCqVMBTDEPumR5LVIhE7yx1uBhtdzfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6865
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

Add igt_drm_ras_nl_list_telemetry_fields(), igt_drm_ras_nl_telemetry_get()
and igt_drm_ras_nl_telemetry_set() for telemetry nodes. The request
helper is split so that requests can carry more than the node ID.

v3:
 - Move nla_get_sint_any() next to nla_get_uint_any() (Zack).
 - Initialize the reply value and status before the request (Zack).

Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Reviewed-by: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 lib/igt_drm_ras_nl.c | 199 ++++++++++++++++++++++++++++++++++++++++---
 lib/igt_drm_ras_nl.h |  21 +++++
 2 files changed, 207 insertions(+), 13 deletions(-)

diff --git a/lib/igt_drm_ras_nl.c b/lib/igt_drm_ras_nl.c
index 282648f55..177d2bc88 100644
--- a/lib/igt_drm_ras_nl.c
+++ b/lib/igt_drm_ras_nl.c
@@ -661,6 +661,17 @@ int igt_drm_ras_nl_wait_for_error_report_event(struct igt_drm_ras_nl_context *ct
 	return 0;
 }
 
+static uint64_t nla_get_uint_any(const struct nlattr *attr)
+{
+	return nla_len(attr) == sizeof(uint32_t) ? nla_get_u32(attr) : nla_get_u64(attr);
+}
+
+static int64_t nla_get_sint_any(const struct nlattr *attr)
+{
+	return nla_len(attr) == sizeof(int32_t) ? (int32_t)nla_get_u32(attr) :
+						  (int64_t)nla_get_u64(attr);
+}
+
 struct request_state {
 	struct igt_drm_ras_nl_context *ctx;
 	bool done;
@@ -699,24 +710,35 @@ static int request_dump_intr_cb(struct nl_msg *msg, void *arg)
 	return NL_OK;
 }
 
-/* Send @cmd and feed each reply to @parse until the reply, dump or ACK completes */
-static int request(struct igt_drm_ras_nl_context *ctx, uint8_t cmd, int flags,
-		   int node_attr, uint32_t node_id, nl_recvmsg_msg_cb_t parse, void *arg)
+static int request_alloc(struct igt_drm_ras_nl_context *ctx, uint8_t cmd, int flags,
+			 struct nl_msg **msg)
+{
+	if (!ctx || !ctx->sock || ctx->family_id < 0)
+		return -EINVAL;
+
+	*msg = nlmsg_alloc();
+	if (!*msg)
+		return -ENOMEM;
+
+	if (!genlmsg_put(*msg, NL_AUTO_PORT, NL_AUTO_SEQ, ctx->family_id, 0,
+			 flags | NLM_F_ACK, cmd, DRM_RAS_FAMILY_VERSION)) {
+		nlmsg_free(*msg);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/* Send @msg and feed each reply to @parse until the reply, dump or ACK completes */
+static int request_send(struct igt_drm_ras_nl_context *ctx, struct nl_msg *msg,
+			nl_recvmsg_msg_cb_t parse, void *arg)
 {
 	struct request_state st = { .ctx = ctx };
-	struct nl_msg *msg;
 	struct nl_cb *cb;
 	int ret;
 
-	if (!ctx || !ctx->sock || ctx->family_id < 0)
-		return -EINVAL;
-
-	msg = nlmsg_alloc();
 	cb = nl_cb_alloc(NL_CB_DEFAULT);
-	if (!msg || !cb ||
-	    !genlmsg_put(msg, NL_AUTO_PORT, NL_AUTO_SEQ, ctx->family_id, 0,
-			 flags | NLM_F_ACK, cmd, DRM_RAS_FAMILY_VERSION) ||
-	    (node_attr && nla_put_u32(msg, node_attr, node_id))) {
+	if (!cb) {
 		ret = -ENOMEM;
 		goto out;
 	}
@@ -734,12 +756,30 @@ static int request(struct igt_drm_ras_nl_context *ctx, uint8_t cmd, int flags,
 		ret = nl_recvmsgs(ctx->sock, cb);
 
 	ret = st.error ?: (ret < 0 ? normalize_nl_error(ret) : 0);
+	nl_cb_put(cb);
 out:
 	nlmsg_free(msg);
-	nl_cb_put(cb);
 	return ret;
 }
 
+static int request(struct igt_drm_ras_nl_context *ctx, uint8_t cmd, int flags,
+		   int node_attr, uint32_t node_id, nl_recvmsg_msg_cb_t parse, void *arg)
+{
+	struct nl_msg *msg;
+	int ret;
+
+	ret = request_alloc(ctx, cmd, flags, &msg);
+	if (ret)
+		return ret;
+
+	if (node_attr && nla_put_u32(msg, node_attr, node_id)) {
+		nlmsg_free(msg);
+		return -ENOMEM;
+	}
+
+	return request_send(ctx, msg, parse, arg);
+}
+
 struct node_list {
 	igt_drm_ras_node_fn fn;
 	void *data;
@@ -829,3 +869,136 @@ int igt_drm_ras_nl_list_error_counters(struct igt_drm_ras_nl_context *ctx, uint3
 	return request(ctx, DRM_RAS_CMD_GET_ERROR_COUNTER, NLM_F_DUMP,
 		       DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID, node_id, error_counter_cb, &list);
 }
+
+struct telemetry_field_list {
+	igt_drm_ras_telemetry_field_fn fn;
+	void *data;
+};
+
+static int telemetry_field_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *tb[DRM_RAS_A_TELEMETRY_ATTRS_MAX + 1];
+	struct telemetry_field_list *list = arg;
+	struct igt_drm_ras_telemetry_field field = {};
+
+	if (genlmsg_parse(nlmsg_hdr(msg), 0, tb, DRM_RAS_A_TELEMETRY_ATTRS_MAX, NULL) ||
+	    !tb[DRM_RAS_A_TELEMETRY_ATTRS_FIELD])
+		return NL_SKIP;
+
+	field.field = nla_get_uint_any(tb[DRM_RAS_A_TELEMETRY_ATTRS_FIELD]);
+	if (tb[DRM_RAS_A_TELEMETRY_ATTRS_FIELD_NAME])
+		nla_strlcpy(field.name, tb[DRM_RAS_A_TELEMETRY_ATTRS_FIELD_NAME],
+			    sizeof(field.name));
+	if (tb[DRM_RAS_A_TELEMETRY_ATTRS_MODE])
+		field.mode = nla_get_uint_any(tb[DRM_RAS_A_TELEMETRY_ATTRS_MODE]);
+
+	list->fn(&field, list->data);
+
+	return NL_OK;
+}
+
+/**
+ * igt_drm_ras_nl_list_telemetry_fields - Call @fn for each telemetry field of a node
+ * @ctx: initialized DRM RAS netlink context
+ * @node_id: telemetry node ID
+ * @fn: called once per field
+ * @data: passed to @fn
+ *
+ * Returns: 0 on success, negative errno otherwise.
+ */
+int igt_drm_ras_nl_list_telemetry_fields(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+					 igt_drm_ras_telemetry_field_fn fn, void *data)
+{
+	struct telemetry_field_list list = { fn, data };
+
+	return request(ctx, DRM_RAS_CMD_TELEMETRY_LIST_FIELDS, NLM_F_DUMP,
+		       DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID, node_id, telemetry_field_cb, &list);
+}
+
+struct telemetry_reply {
+	int64_t *value;
+	int64_t *status;
+};
+
+static int telemetry_reply_cb(struct nl_msg *msg, void *arg)
+{
+	struct nlattr *tb[DRM_RAS_A_TELEMETRY_ATTRS_MAX + 1];
+	struct telemetry_reply *reply = arg;
+
+	if (genlmsg_parse(nlmsg_hdr(msg), 0, tb, DRM_RAS_A_TELEMETRY_ATTRS_MAX, NULL))
+		return NL_SKIP;
+
+	if (reply->value && tb[DRM_RAS_A_TELEMETRY_ATTRS_VALUE])
+		*reply->value = nla_get_sint_any(tb[DRM_RAS_A_TELEMETRY_ATTRS_VALUE]);
+	if (reply->status && tb[DRM_RAS_A_TELEMETRY_ATTRS_STATUS])
+		*reply->status = nla_get_sint_any(tb[DRM_RAS_A_TELEMETRY_ATTRS_STATUS]);
+
+	return NL_OK;
+}
+
+static int telemetry_request(struct igt_drm_ras_nl_context *ctx, uint8_t cmd, uint32_t node_id,
+			     uint64_t field, const int64_t *value, struct telemetry_reply *reply)
+{
+	struct nl_msg *msg;
+	int ret;
+
+	if (reply->value)
+		*reply->value = 0;
+	if (reply->status)
+		*reply->status = -1;
+
+	ret = request_alloc(ctx, cmd, 0, &msg);
+	if (ret)
+		return ret;
+
+	if (nla_put_u32(msg, DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID, node_id))
+		goto err;
+
+	if (nla_put_u64(msg, DRM_RAS_A_TELEMETRY_ATTRS_FIELD, field))
+		goto err;
+
+	if (value && nla_put_u64(msg, DRM_RAS_A_TELEMETRY_ATTRS_VALUE, *value))
+		goto err;
+
+	return request_send(ctx, msg, telemetry_reply_cb, reply);
+
+err:
+	nlmsg_free(msg);
+	return -ENOMEM;
+}
+
+/**
+ * igt_drm_ras_nl_telemetry_get - Read a telemetry field
+ * @ctx: initialized DRM RAS netlink context
+ * @node_id: telemetry node ID
+ * @field: telemetry field to read
+ * @value: set to the value read, only meaningful when @status is 0
+ * @status: set to the status reported by the device, -1 if not reported
+ *
+ * Returns: 0 if the read was performed, negative errno otherwise.
+ */
+int igt_drm_ras_nl_telemetry_get(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+				 uint64_t field, int64_t *value, int64_t *status)
+{
+	struct telemetry_reply reply = { value, status };
+
+	return telemetry_request(ctx, DRM_RAS_CMD_TELEMETRY_GET, node_id, field, NULL, &reply);
+}
+
+/**
+ * igt_drm_ras_nl_telemetry_set - Write a telemetry field
+ * @ctx: initialized DRM RAS netlink context
+ * @node_id: telemetry node ID
+ * @field: telemetry field to write
+ * @value: value to write
+ * @status: set to the status reported by the device, -1 if not reported
+ *
+ * Returns: 0 if the write was performed, negative errno otherwise.
+ */
+int igt_drm_ras_nl_telemetry_set(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+				 uint64_t field, int64_t value, int64_t *status)
+{
+	struct telemetry_reply reply = { NULL, status };
+
+	return telemetry_request(ctx, DRM_RAS_CMD_TELEMETRY_SET, node_id, field, &value, &reply);
+}
diff --git a/lib/igt_drm_ras_nl.h b/lib/igt_drm_ras_nl.h
index 4980904f8..1b2a8f164 100644
--- a/lib/igt_drm_ras_nl.h
+++ b/lib/igt_drm_ras_nl.h
@@ -95,9 +95,23 @@ struct igt_drm_ras_error_counter {
 	uint32_t value;
 };
 
+/**
+ * struct igt_drm_ras_telemetry_field - DRM RAS telemetry field
+ */
+struct igt_drm_ras_telemetry_field {
+	/** @field: Field ID, as defined by the device uAPI */
+	uint64_t field;
+	/** @name: Field name */
+	char name[IGT_DRM_RAS_NAME_LEN];
+	/** @mode: Supported access modes (enum drm_ras_telemetry_field_mode bits) */
+	uint64_t mode;
+};
+
 typedef void (*igt_drm_ras_node_fn)(const struct igt_drm_ras_node *node, void *data);
 typedef void (*igt_drm_ras_error_counter_fn)(const struct igt_drm_ras_error_counter *counter,
 					     void *data);
+typedef void (*igt_drm_ras_telemetry_field_fn)(const struct igt_drm_ras_telemetry_field *field,
+					       void *data);
 
 void igt_drm_ras_nl_cleanup(struct igt_drm_ras_nl_context *ctx);
 int igt_drm_ras_nl_init(struct igt_drm_ras_nl_context *ctx);
@@ -112,4 +126,11 @@ int igt_drm_ras_nl_list_nodes(struct igt_drm_ras_nl_context *ctx,
 int igt_drm_ras_nl_list_error_counters(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
 				       igt_drm_ras_error_counter_fn fn, void *data);
 
+int igt_drm_ras_nl_list_telemetry_fields(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+					 igt_drm_ras_telemetry_field_fn fn, void *data);
+int igt_drm_ras_nl_telemetry_get(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+				 uint64_t field, int64_t *value, int64_t *status);
+int igt_drm_ras_nl_telemetry_set(struct igt_drm_ras_nl_context *ctx, uint32_t node_id,
+				 uint64_t field, int64_t value, int64_t *status);
+
 #endif /* IGT_DRM_RAS_NL_H */
-- 
2.56.0

