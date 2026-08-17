Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2D32C5DF70
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 09:57:13 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DCD110E715;
	Mon, 17 Aug 2026 09:57:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Fr8UmVVc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 70B6510E715;
 Mon, 17 Aug 2026 09:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786960632; x=1818496632;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=5SBhIUAcaorefmOMkiAIWOMeiUdaOvqy18bSBQaIUqU=;
 b=Fr8UmVVcp9nD4tmT07wLU8XNZlFWbyveqTdu9vqxNhBtK+F4+tqrjXwH
 N5KIS+qoRXSRIPOJhSooeFONFdnc6haoLfAdfxyUb+GLu1MTqxqsWVn9t
 4VVEaPhPfZD+eg/y1M+Al+HMSwtxN/dSC77vEaoL5zKTjYApm/ujHdqS/
 k/TOGVLjrL1H0j3fpQAaK0PrnS3nfB0/x2xBqhMEkHqMint7QPm1gQIPT
 iUYVeKDFY4blSx3Xgn20TsXCBraVS1nEAW6zt1iNivfSvn08LBshboCb7
 OZFteF+NGX/i1uhrojUaLKoRyqemv2KexFCH1aZtpWK3lsnDA6AkneViB g==;
X-CSE-ConnectionGUID: X2hcXlKnRzuxenUh2lPCJw==
X-CSE-MsgGUID: dOJ+sGGlTOqdbP7TFF7NNQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11877"; a="86551609"
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="86551609"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:11 -0700
X-CSE-ConnectionGUID: DN5168oxQge8Lf8zwMe5Sw==
X-CSE-MsgGUID: jfwYDAvlTn2h/HODPiyLmw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,228,1779174000"; d="scan'208";a="269148261"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Aug 2026 02:57:11 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:10 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 17 Aug 2026 02:57:10 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.65) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 17 Aug 2026 02:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X/alKHOTqkofi+GVmQiWuI58vgkI9EUXCFPZaxeH2/ccVcYhHfstqdej2eg0ttp1TnIhWN3jybV1j14kRI41WZasp7vDmIlGvxFI/rPaCsht3suZZJEFqnyA+RwemzSldlCppR7RdvVHFNp3CZ1y+G/GaQnjqVKEexX7gUU9/1oFaUKAuLYc0R+sGUaa8OCdKkk0/BQ+9MsvaVDEFA2TAWXPS0T7gQopQB54XUITOOexJatyg88CHSSwI13pT9NnPZ97N0YPg99eG9Aa47VpQpHfrmKpg69WbZa1mKvR/ZMFsjo+lGbg96iMPaBfgWjYqHXVuK9ZKvFP1SmXooRuNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GsOEIRcAFnYOcUtTmW6NnvDFJTztuzIf7t3ly9FZ+fE=;
 b=WOyu8oRwmsJ5mtEn0jMkeD1tXPYz4yRiblDquMpHaD/caEENuys0NTqten4pmNsp96hkJWXUwZgOLuJaVKMMkC5cJ6Llfqs3MZ+kYANx2vaQgR4DqJ/Pe3LiHXcuIhsFm52XF39I6pSjTtotkjKV0ob4DH/+Oft+UteCBkRfLIDr6Pi85p86VgXluZUodzx4XOOFlKS9E0P3eRclZ6kQdY6IxJnbhI+QmoEW+A5XT7T07aZHYAqlM16352RqLKnfzztwzA7Q4AvodUzEQKQ64V2+vd/hHk4/LUy5v37LTrsCfKqlwWlUddJyIUIPbmWx0fboQ3VqvOblN9ynLF/B1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by CH3PR11MB7772.namprd11.prod.outlook.com (2603:10b6:610:120::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.17; Mon, 17 Aug
 2026 09:57:02 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Mon, 17 Aug 2026
 09:57:02 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Robin Murphy
 <robin.murphy@arm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>, "Janusz
 Krzysztofik" <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH 2/6] drm/i915/gem: Free sg table on failure to acquire second
 folio
Date: Mon, 17 Aug 2026 09:56:44 +0000
Message-ID: <20260817095648.2438192-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817095648.2438192-1-krzysztof.karas@intel.com>
References: <20260817095648.2438192-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0227.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::15) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|CH3PR11MB7772:EE_
X-MS-Office365-Filtering-Correlation-Id: b5ff6868-8395-40bc-ddc0-08defc45e2ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 8NKgkxXDU09KlGz+efPOKkePWCbgydquQsyTLkkHml3WY8SfQSKByjuLre/aqTABGEya91NJDkONuI2/Dzu7mDQ2xm/hS21kIiHce/OEbdh35vuLYiUm/6j+GK3XRliq+ovJDu3VGblfL9foRpu4nmBzfiKUqwi1DLafE3a01aZ7vqsnzysxlmum8wUTpqed6/Z0f/VBiIoDqS51CWJUk6mxMtMcEhvXdxYIpetya4tAgVfSFwglUWzW5U3FegirHneIPvaqm03NnudzQXdqKiMnf8hg+ZLn46tWEHF4mVdXbE/FsQZ4Z6/j88aS3MKMTZfzKWmSt0wP+yKWkPTGGHkQUFg16JDbpRus4D3xVISeTNChROQKg8+rTcHCPw6M5UzXMENG7oPQs3vEcH/17wgcYLSw3rXmZR2fKRGMUxhoGzkf+RTN7CZxKQ6yTa/hbjE8mcM0AwwKJt25V1CTDC11bWUmgg5CfGoEWz8RicIC7jfNtKroT3eaIgfhSzfi0Kac2f2P9p95C/Q4Of1ppoWOk8F5xj0shS60NutAhvjIAfAD/Kz6rivIBQA3Og016a0zFHvUvHO+b9wSB5NMZYblBuGNfxdsYzQxg1kn72Y2y/ln9DBWoJApS1ZHl140OpZPas2F1K7zqD/o1YjfxdskSlddyR+0lN66XABB+6A=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RXhWgJe4hrT5AsPzuWZNrvm3H2kn6Ziue04DtKeW30V/9WZZNecKx6Eu5haL?=
 =?us-ascii?Q?Pufh0tEyaxlT3EHGjDREQCRn8K3ktnw0pwzMMwKNwrof+OFS7D1ftbUndkj6?=
 =?us-ascii?Q?XDS+kX5n9QmKcA4P9/yxqo+gZRMMMYYQDLonU7PPQOK+abFP1E8Fybe4Xaec?=
 =?us-ascii?Q?m3zxqkdWvS8u5Q4f0jD01uHIRQMSfayvi5HeXhJ2EKnZXYjSDguo4D2p36ED?=
 =?us-ascii?Q?tHOqOlrXUDWQx93+pzKJNktRjK9qSPfJR/5+dfecTNOHAC/R5KJMdX5ikVYU?=
 =?us-ascii?Q?/04AdACIcnWaCo6ephwelAqolEJasDYZVNp//Ck+t3ZzL3b5slzJYvYkTj+H?=
 =?us-ascii?Q?4lv/Lzmm5Bf6YGsN3oBa45eGUitC2qIIx903KKBD2jDNq7xJ+8rADXW8kn8H?=
 =?us-ascii?Q?n+6q2rpwybaV4M1dVh94VI7DB0QBYkVN5DRuruErpy4fqzQEGF2htTSaSRWp?=
 =?us-ascii?Q?L2OoUIdYKqAelQ0dvJfTrcxhYnvmwvTaVmfAo9UVztFdXstDrbysZT/27lNU?=
 =?us-ascii?Q?+qgBVL5ntdxkfBjjac1dEC9qZ+bK/aof6XqHOex/wglWZcxeA2saAOCYBZLS?=
 =?us-ascii?Q?cGYKt8zcAV7irHxdDT4PXyyepItD6ytwVDAUZL8nwlPuGGQ+C2+Oq18vSaQb?=
 =?us-ascii?Q?GNw9YsYkLka+ttVmHv5gY7JlGgomyI1PTSd/my49WJUNejJLgOX+56gs/AKJ?=
 =?us-ascii?Q?5k4iUmYJ8XC6Jd4BBQwxnobR/oozqbu5TOKOTTHw3vwNpgfGntY9aQKEhsRR?=
 =?us-ascii?Q?oUT+nGTCYlCgpzhWdNuNMnJaOHSgF1xD0a+6wq+42sU54yThgooKfx4BvCP2?=
 =?us-ascii?Q?5AMW17TRUenYIFUpxGBwdDPrtD2fHbCRYL+Nl8Bmw7bb5ibA7VRIN/zEljdr?=
 =?us-ascii?Q?br3a/gOqaKPqrjm2TZ5WRioJs5hEZuSmtZq1TbGfBbANWFtef+nPnoAU8YLg?=
 =?us-ascii?Q?/9bQ+Xpn1rH4XyoPLDHaKsczSiP5iQofMNfiYVe4TgM3qAcp3LOPMdZLuymH?=
 =?us-ascii?Q?OXJt+RXq8/CibiedLCg/sEVpOv6hAxVuCjzR87nXJ4j3iTl7+J2dxouvyrGO?=
 =?us-ascii?Q?gl448mNc9t7ENdrpzkmb6HEPEASnT1xkW5VueohQMoqkeYyOekcRruzO+pPI?=
 =?us-ascii?Q?y0R1fyQBU2nYyP337pnHapq4aKopAJ3S8lLZnEWqqw02eobAzscLcsap03zU?=
 =?us-ascii?Q?A6li1xTIBnMlSSSyXYB7k2lvecCina3EY+y77aNAPJ9M4kuHYXHBfGWDXYpl?=
 =?us-ascii?Q?AeQMBHrD7mnj5ivJerpdp00vZ9TjLYUypi0e6UZ5K5snHrCn41etztUjdSlS?=
 =?us-ascii?Q?hlH2npWzlPtMvVbVpdBd80eK7QGMwKRDXz1rRMI7jq3a9p612eUyxorRCyFd?=
 =?us-ascii?Q?VbERUFaV4Ok80PIyk0zcbcp8xwdEEtCqXm/d8ZZhgGpE2ySvBaTQIz7mCFlB?=
 =?us-ascii?Q?F/hChiRxwtDX0jLUqjXbHiv7dWIVO9JcTHxzsgcxiXjkjIjRWQ0V8YVvAm93?=
 =?us-ascii?Q?ZLCGYV4WcR/SD5cq9i7ia03+8lhBBH5SVet0RoLaqGYUdL2hwJj/lVLfyEoS?=
 =?us-ascii?Q?zGpUN4EdEYP9mkEjjAYjGq4DXSUPOU4tP2UHHPr8d+UeXLIHXxQI5zS8S01e?=
 =?us-ascii?Q?xV2sUOhqADaBM2f7KKdIkyeoLraJS+BajTrI2SgwjdDD9wBT20cAMcYpN3RV?=
 =?us-ascii?Q?j1Yl6AdDGPXzhyEpI1hWFxhoEavmgFWgmWUpmUmzVGwvG2P9VJMB8GZ8Hlw/?=
 =?us-ascii?Q?L1sQP8PhFcpiwV55R1igUrDqGytgUuM=3D?=
X-Exchange-RoutingPolicyChecked: nQIbvhi7bREqgSDP1ZLHdp/3znJMYgy7SAnUrt6hl0ew2lbLAj/fgzYfj4Wbu4hLrDs4RSox+Y8tVW88ICp9TCXzNSPb8v8X445nj2S6tLHYjWPn+77JclJPVz/3gOGbL9RFuTqNmLyGjvgiyxrKbUYJ41dBXyGUDa1C8Mj+l/O5PayPr56VmO0gAd5dG6Z5cEleWGL96XsJkssj+evkjvbT7nF+v7sToU57rMLSkrmut/XdMT7lTczQXzRq4mQ3levhbcDPSf29ji9D/+15izy+kK1dqEczfgodxLQcIoSzmr8s/fSoKaPQr2+agPcWXAggJQoi27p44Kp24QbPZA==
X-MS-Exchange-CrossTenant-Network-Message-Id: b5ff6868-8395-40bc-ddc0-08defc45e2ea
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2026 09:57:02.6281 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t5OaIog96OgFuF4MpYkSNhGErC5YodSwX37A46O6V8c0IjQmHESsCrB5KpKQW63+/IfaKWkOtN1Op3ed1XoLrKVuruO9InhcBrIeVg6pyko=
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

We should release folios if the first entry was populated, but
loop failed before sg advanced.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index f338dc39fad1..d6243f4e51ab 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -219,7 +219,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 
 err_sg:
 	sg_mark_end(sg);
-	if (sg != st->sgl) {
+	if (st->nents) {
 		shmem_sg_free_table(st, mapping, false, false);
 	} else {
 		mapping_clear_unevictable(mapping);
-- 
2.34.1

