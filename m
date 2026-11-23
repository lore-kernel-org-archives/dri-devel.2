Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912E9606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YQ/nV66n;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=N6YpMA6q
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B275F10E358;
	Mon, 23 Nov 2026 23:34:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23F2010E1D6;
 Mon, 23 Nov 2026 23:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795476830; x=1827012830;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=3AUUO9NBY2HsELSUtbuV7wm5f1K4tskVRBfrDwWb+tM=;
 b=YQ/nV66nrL/7fpZMvwD9FGRLSsdBwiRPm1UbosTEaPwTfgHHIIf9eRkq
 qOGeh++myB7VGVOFQR1cPibMPQCNzZCV5WTyztAorlGJUCA+0OyGUiYde
 YjQkTtDkIvSI170SLzIcyAhw/8rXQxIkPB0Zr+DumgZjJO+QaKSuD8OcT
 0it0pUq5lHGnSnhU1PKEDZu9qKVD4eMKGuonk7p4raEsfYo5jyakMAW+w
 +SbVxQ4TwnZl4zhwgChqxgQn4iXwNkuy9vAf0TuyWrtvLMWgfcmKBDjLB
 bGhAaj4NcpGLlU29/WSnAtLdPNAMgjIqwsPjSXzivErewdZaMr5pessNr g==;
X-CSE-ConnectionGUID: lbcUde/mQ7G93s6Ycbr3Vg==
X-CSE-MsgGUID: Rju/i/IYQJSGYQgtgWK9rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4194426"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4194426"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:33:50 -0800
X-CSE-ConnectionGUID: EUmTOaDuTlO+OOi/4bZVkg==
X-CSE-MsgGUID: OktP1QM5Rf6Y0CaJXGPxqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11398714"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:33:50 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 15:33:49 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 15:33:49 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.30) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 15:33:49 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LPQojoANq+rCnSclZOnEWLSQKSn4vQiN71ZFcKTvGJzE2hw4CftCQIoHb5Zl7j+4t608tQmkzUAzOGpelCP9fCKocN+G+jnwyH8A0g0tdAq0Zhb9PEL5w51FOKmvfIQbMUXA7pZTi5HOET0kNoEtFva/b2iLRpVCSosS5CcRYUrQKxK9LNKklTITq7aaPlbmIHlJIHvrNVzzsWblraiXvmz+6Dk8dCtVHEU8m6idwkocQdcrE0Ld1srg1WqVLkGLur3hw8/i7iwVU8zqVC7Egf/ZyeAOIQLdJfFUFI4i21MYaLsCgmGddt3v7F0G+XELNSE2vCtos0g2OhwhSVGEpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jZluH68V1i0EWVwMn1gnYO00mC6FkvakOeVh16Y7iF8=;
 b=eR1PO7IP8naBiGwhwNycRceVjYDAofI8ORMke+pchpJG2g0tV7H+BPvu0R5at5GmX2Dt7W5wZzY2PIOvqp7vTNqkAs2kzGFDPXJdAj51O1CxyOKUySYHQNYUYGdYPcElmwGVIus6uTCbxWhEFK1qVZgRks9CWFTi+3w1a07NVxRb6DnpWkMnibU8xu7GQiVLyWxEXy1OPHa6FcnuKxHAbaXLByznQn64s35R2VZienjXpgyIG8p3Dd8wzTfOvSoCS0yEuU96cS6y2kQrygCWaGzZWr4KTbx6vQlOw9kWBI2+hlspTJeMnntdjCfFFSH40vjyqTG543yG23hIjOKqNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jZluH68V1i0EWVwMn1gnYO00mC6FkvakOeVh16Y7iF8=;
 b=N6YpMA6q+EZzDD/aNHM6ly7fZ+Qz2aPrqDEgOf7rsFxfyMpanzyZf+CtLgwdwdAY/B9qJpi3O9rvQG95Rj6ijXsiPwdsGectOqJ+GKb1iEsI/L65te73TuHop2joY0gEa7PdtjfdbjszL9kDG3PYi9KxP+AbzGOR/ETzXAPyCT4=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 23:33:44 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 23:33:41 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 1/3] drm/ras: Initialize ret in the list-nodes dump
Date: Mon, 23 Nov 2026 18:33:27 -0500
Message-ID: <20261123233326.2882114-6-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
References: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0055.prod.exchangelabs.com (2603:10b6:a03:94::28)
 To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|IA1PR11MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 24c8143e-933b-4d66-7a68-08df49ba351b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261009223027099003|261102123227099003|18002099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: bJDyk0v8+POyZMHP1ssvC/mygYyRMAi/dc0GBUNoxDsX/Ppr7Xb2YersZrXQNLNEFWbZ2nn6JoQpw8b8MD4zkdG475KRwu1RgI64Cp1W0LYrMMPEzgCrby3MszHzrg9A8Duo0gYtbCqjYzJNHob41EtnI1FPWZwkhwPrK7+Uv+omzvwfZJL4nuiOKoVxSAnCj1CixuapQ//hg8LK/pRejXAa+dWCPXoYesAr90MJSRnL7o9iR5dulu99E7KZArrtjhLX3mwo87X+/mq6TDxnuK50ZWZv8DzZFnJXeDMHT6a7oT0oi3DECLDMehlkvDsB7HSnj/BxoqI4o8HTksIIozQiZxKma98bYqfArQjvUqV1NLsE4wKXPugY8DQLcPqOc0Qu/G/b51P9WQTB3FDZ3Azoh2zOrT6nYKUoysn02JqqzzHz/GauT1WSG5BN9PCIQnFtrtRWAGnRQElvz/rVrBlmPTxChNyRVpCaxyjy7zRbKkg17m2OY36G/FbDXvd0HT91kDzEBaFCUsjs+gQN3PkCw9tKX0/TZvJk+IxEAJXjViDkApUrYK77Eivhugzq+/Aayt8FX1UQ6QqB3nP1RAAz5bD+npFD3eMJUXa12Vsk8i0RvsU4m0oumaZOZWChBDnLViKF4JEnWhexuxHQKZe/F/PU7ogVnUhzV8obIj8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261009223027099003)(261102123227099003)(18002099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VxZWm0R/AXyEAQ82mseLvmevJXJyWyzofnCOvNhPFfJ56Yui/OZ62Cl2tBK5?=
 =?us-ascii?Q?uWTUAPdi4pyNoCeMEwQd4SV4FAjuURc1EJO8nXwHQdXJlIB3O744XN7h9pTW?=
 =?us-ascii?Q?rjKVmsHQGmcxJGQq1LpNwoPO70MQ5RUojcmu2835tv57k6RWmncQFKCornxt?=
 =?us-ascii?Q?jp28UbQR8VznNTiL6EEJK0FV1DoricC2MK3HVlUK7BigZQ/KASh3xsrWx5XG?=
 =?us-ascii?Q?oxnifSOJo7zieFOQ7Iuv7zHHpXfnTfAR8Jy2cVxSsBZ9h8WQflVnmnQ8f9wU?=
 =?us-ascii?Q?NXlwaNAreTRPsPZT6F58akJXXwjxGRniKFjSwZ4Q2Yeua3ykk/3ZTDVrOmjA?=
 =?us-ascii?Q?gBnX+OV/wYcEv2JYyoWaMn7SytiV7jS86u0xgfPKhRUBmPk/Rn1OIuP7d1eN?=
 =?us-ascii?Q?85oO0e/3mTXs+r6NYQPhm1IoDzvCEGlqHe9PgoMVGTKuFCNQ/LSNurY9Zz1+?=
 =?us-ascii?Q?DmKGFRFbR2hTdp0SqFIYJy2vHTUNeuV4+8Qch1gbCtIv94vBAacbtpFPQ/gJ?=
 =?us-ascii?Q?tzl3pz87OITaZ9999ict32Vhog6Oqhgw7c11GEeXzXNGlgZJCnjgmeUuT9ib?=
 =?us-ascii?Q?8sz3TyTGVWKksAMaTFVWa12YV3iugZ8nIupOzrCw6RJ0AclkK7IDbsyRr6oN?=
 =?us-ascii?Q?wwnquHctobOD2X5D58QMyCuqZiXsBY6lmfbVN9L/JTeoZFCFMxAxYQsi0SGW?=
 =?us-ascii?Q?cHGfPiXwsaLqByENeal2lKjw6yVaQzYvxkPLy63AprdvxqbbwDeHGa25rnXm?=
 =?us-ascii?Q?Bb9lONKfVoXfejq/kxvWkA4zEncfwluaUVYGBlR4xjGTmiiUdDsbPl4YjkiA?=
 =?us-ascii?Q?Mdl4kLomDVrhphjNc6ydFeUeiVLIP+qhel7e6Ew2FWdzCX+fgJ+7kmqeqJzU?=
 =?us-ascii?Q?2ipR7i97wauNmC862cQjVmFTxLDEWUUibgpVCTWFOOMjxsEB6sDY3aaCiems?=
 =?us-ascii?Q?qAx7wVuvi0eBUsBoxcV2RiOu1IiBNXQY2OgNTXW0uIv5ZZN8qz2OXRwFRssK?=
 =?us-ascii?Q?TFG2mbbxxT8yEnrFqjE6JEKuCCiuIYRQcIU8YvEo/tQvwdM/+8+iHy3795sP?=
 =?us-ascii?Q?RZcrmlSJs6DYXk5ioBMGv92KfKk/Nyslt0IxrHxy5BNnuIZFWjYAymx7eio0?=
 =?us-ascii?Q?5uFZs6YdodFz5+11v8DkRUCwaTCs6CsNJr7MxDjmTel7Jo0xC6Ij1Td1uTjn?=
 =?us-ascii?Q?GqK4JPwTgptgldndQh6StDXC0vE1MRfY7KKaHGeKm0zjir6Q3BQzuPmitntk?=
 =?us-ascii?Q?EY8vLGBPAHQFAdBmf7hDiQLAojqmI7QL8k/3z0QO2RbWZyUjSLBe1k7Ui4nR?=
 =?us-ascii?Q?FjWNvMQJpqB04Wm6cvxc238WmWdoOIMs8iq9bIKKFGqW65pNZTNAKvS55y9e?=
 =?us-ascii?Q?QyiTKueWh879hnH+dljUZKJpq4520T6bhlxYGpRlvn2iFIBznJnOzpl5Enef?=
 =?us-ascii?Q?FBCb3ZeGHo5xLUvGvGvZOLrMuxbHrbpkqSlc8KLzS3Wl5L5SEmSKOfHsFbBn?=
 =?us-ascii?Q?bVY4ROZZLPTynVx+qY+gClwNi4irRf3Oln77NY+KuW9Vsifyk4mFGFfihQO2?=
 =?us-ascii?Q?Dy+unjwWka8lq/bSG8udITVjdmAJXCZeHFFMnL5tR9yfEtnLCQxayqFaH8dm?=
 =?us-ascii?Q?FIge5bEVGMfWJ3VQlJdN+8wIrLezQOGZnALlRHiqoKRFtcTW/2t78Y6bN/5v?=
 =?us-ascii?Q?Zvpms5pNhiOVug3cAqoq3Huw5CbQwkHPFgmRNJzxfsjZVrW2gCj8ABCFQtWf?=
 =?us-ascii?Q?Y/hEhwTGxw=3D=3D?=
X-Exchange-RoutingPolicyChecked: TZ8MpsetKpDfn2Shn74WL8fZMZMCsmvdoGjSBbthcIQMOfDBMuPLDEPH+n43Swx6rZpXCY9ZoYpo9XC5+NQCdCsICrI85sGHEayRN8il9rxipKSp6/Awy6YmibpPAob2mjVLLJq5rsLbpKLhKOtMmyqZ8+VbGHYFJkNrnp43N7IK5rYMNrGX1Ic3Q5D+Ao4kz4t4/HqaM5QDc7OU6socgTEinqAZ+rnM1PsZINg8Ct02BHtYOW+C/8MqLOd8TS01A2y+fUhhRqAvxKZjxwxa/GPRmkRFDudjEdUfEDopTm+2tyC9xm9ui3WEQdTXmmjt3WMhZUYWF6ONx2neJKrluA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24c8143e-933b-4d66-7a68-08df49ba351b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 23:33:41.4848 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rpRo8Gp1kwO536RgmOlwNw3AyPX4N8Dx9f9H5f2dVeRL5vziUyp7t1Q1+INzDPSbOm6mrlcz3sEfpUfDbLEDlQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6516
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
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The drm-ras family is registered by the DRM core, so list-nodes can be
requested while no node is registered. The loop then does not run and
drm_ras_nl_list_nodes_dumpit() returns an uninitialized value.

Fixes: c36218dc49f5 ("drm/ras: Introduce the DRM RAS infrastructure over generic netlink")
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
---
 drivers/gpu/drm/drm_ras.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
index b099eb67836e..4f4777060a4e 100644
--- a/drivers/gpu/drm/drm_ras.c
+++ b/drivers/gpu/drm/drm_ras.c
@@ -130,7 +130,7 @@ int drm_ras_nl_list_nodes_dumpit(struct sk_buff *skb,
 	struct drm_ras_node *node;
 	struct nlattr *hdr;
 	unsigned long id;
-	int ret;
+	int ret = 0;
 
 	xa_for_each_start(&drm_ras_xa, id, node, ctx->restart) {
 		hdr = genlmsg_iput(skb, info);
-- 
2.56.0

