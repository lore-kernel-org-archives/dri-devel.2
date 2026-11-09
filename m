Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E51B606A330
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=YZnIuPAA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A5FA10F1D1;
	Mon,  9 Nov 2026 11:38:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6982510F1C0;
 Mon,  9 Nov 2026 11:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794224308; x=1825760308;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=6/IgudFGe1MMQ44RC9fzD9+FkH3Ct71uDg/9Juxqcq8=;
 b=YZnIuPAAG852pBmHjzF7BeLQvkdyTixNBle3G7rqv/HdTMrnR3SMR0Bt
 hVDxLWJRnGrcMzhYkE5N+4HMNtyZe6+ubMxDJfiNB7SZ5sLkLcM3i18xP
 /hAxvThsKc1PA71stydpydFKgji9dmgV1jLcoLOfRSV3RXpOw/c2yG4Qp
 12qrMM8ZiM4MaI1D4FPQUnjlV4TR/z9TvfyhCF3u2qP1yZ/w6Anh/QZ2Q
 2a0MI3Ejed39W7hG+hjfACZmLECzTEQsw8CbMMSEOWMzdU6i+0yJEJsds
 P8TxfBUGMDRbIu1l+xlQG0F6lVP0BJ9qYJPgS/HeZ9BT4UoWdbSnc8IpW g==;
X-CSE-ConnectionGUID: uk97lijmT2OryqfCkEMCxw==
X-CSE-MsgGUID: ngjoeza/Tv2PmRgVu+pOSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2835868"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2835868"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:28 -0800
X-CSE-ConnectionGUID: N8NhFfawRi6TsGTKSxbaPQ==
X-CSE-MsgGUID: KQ0UVf/MRMOp92TG2qMMVw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="7985127"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:28 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:27 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:38:27 -0800
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SouPcQQxCPlOQu0SXpCMfjFQAw3WkjWfRyAt4r1+Rta71NgwUHPo8ynFWVL/TPSJ/gvZEFjLcsN523gwFYyJP+4SO4RTgph07V4fvrwch1byCenwzJaoOJP1HJLoczMvXY5ca7421Jl4/+QzdGc6Su8ThXhwGlCTfGm4GURfsb9a7Z28ErWBiQZuE8hUiYL1lLmAkRHterCFBRyFuD7IiWJeKy0e+VZ2mJ/wLZXzKJbzlBAdyw+gprgIsJRXyyzBr0uSsvi5OtTaFXB3MMS/euvt8S3YIV/bWSfIpLQU+4xf+GUU6jP34bHgT3Beg2NZ9ETdEQ4GtQbUazVzR1QfBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9wifd38lG20idzM7dOxR1UjRQ/Tn7X5rHhhWZCCAWKs=;
 b=j+HmvFzFP61RxgdUkGBBpnPQIP07D0Z6LNnCd7Ch0bDk5gx6nRG9+Rt2dqTPRfSL3kmuua3ixhNB4aZ2++DqzIFLMXJcAMyXXfbAUdBJV6OZADnYs9UDihslRYHAZBkh5R6YuiIZ2OKVBLaqPwyBSfUnslBmNytfaFGR7WEzOh2YXmynOBxNGGuSAQTcR3sU5umdnNi+h0n8m7q8mqqnaSn8jlDX52aBPiY+J30RspxHr7VXw9XtfN4Ay2P+mEZjV7GI5PGPExWB+aeS3c3vDwjYfKGUMJruWgp2LeGWlevtsDZuLK0fIRmrVaQjoTd6lns4YnKwgx6DcnIHHlrIBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA1PR11MB7199.namprd11.prod.outlook.com
 (2603:10b6:208:418::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:38:25 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:38:25 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v8 6/6] drm/i915/gem: Remove iterator and use while loop
Date: Mon, 9 Nov 2026 11:37:58 +0000
Message-ID: <20261109113758.1491891-7-krzysztof.karas@intel.com>
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
X-MS-Office365-Filtering-Correlation-Id: 78a4aeb6-74c4-488c-5c9b-08df3e55f724
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|22082099003|18002099003|10067099003|11063799006|56012099006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: uCaCPVggCPJEAk79Y1mcCsA+kAwnolfepoGrAHreVktYQNUpzZkTB/3a8LT4rxdPi/XA9o4xIcmMd1FWJNGcMVxQmTMNj35TvvOCztRzAjZlD2uoRoT/4W1lxdrXDnz0dWogt8hprzh9qol8CmnnZyerKTGJG+lz3JKju++06ekodIFZjp7Prl4cm2CuXeFYbQRAV1STj/5nnSpF6or6NJUw2bqIXMPmTJSdWcFZNcjEPGnZ24tHW/yfo3TaFJtHqqYo/B/ya3Ld6ZHheAyTAc0aUgSg8BmEJBZwuPXerQl75xVV04CpWTnsCP9/MIYSBRtOjIxrN8kjhWnDiac9pdPfVsfVJtMx5MmdC35jLya/Oz4MgxppTZ3tSfRSQFwK4JVIIq3af2xyarHqSLXhYjQPuCGFx2bqYUSTZGYpN1Hgub/9AdLy9BdU0KLxQD89QbeSv5YqsFxKv8ld/GS3pTAVkZjHjsj1JPbY3BlReoakczglrkzwGYKlUHuS0BSbhXTT02LIodKa4vDDJP3f6eICEWFFu0WgJMd3fHHo84CnBLoq6cY1UKnbeBj5UdYIxqCE54bMSmvqtXGKEEogePuoltYMhfEILJbUlbhyD/1q24e5CSB0wTZvm9NShDq1ETttmwMl5U0YiquS9HBfkwlm/qoExiMWP4o4j/gqhcE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Iie3f9Q/zBdY+vJJ3yTJysWNiH3hzfTeazsuxO2fc3rJEuuS0I80bI9YsXaW?=
 =?us-ascii?Q?OUIjebT0otR15+PUsIo81unRnVlAG5jFZvoloArVrOl8FPa3KV4TFDSBm+OU?=
 =?us-ascii?Q?I606vfQuaTn8MxdJFWeXksQyUX2Xj+dt+KItkQ7m6pPp2PcBXMD9c2qkdfIP?=
 =?us-ascii?Q?loKIZ32dmC4xxSn09j7ku3m63nm4mXgPWFKARxa+kVxZGBTayFeNIdLzTcGX?=
 =?us-ascii?Q?QaFuIIsGaPqh2O7NbXsZv7iZO9oStSTKeWIos0dURm9lqxzvMe1ntufeZNYm?=
 =?us-ascii?Q?kfmo0vRhpNNq77iKwZnSg5HvzonSPvLkvMOZyMEg4CS522ioUwgFLFbPz67h?=
 =?us-ascii?Q?JiPWyoaPAcnZ87nqjkrziQL5r8YusTSOvD/yVmnolfIqZXFOHWgrLmrpaUBx?=
 =?us-ascii?Q?q78NzulF1sAvSynoz+Qn4fImTdjtHjgWsYDSGUOb+Gq5JrNOh9hBlOY7Ocbe?=
 =?us-ascii?Q?XPDWabA0EM9kd3GLsV97xwlkBFe1d2a5/Xl+viGv3Qk1jTA/LbAbVW/5IH+J?=
 =?us-ascii?Q?Y4myrRDeTd73xVnMAnOgXKEDbcGi11Bpsu6hwzfeCC7x4a4ktF08aX0i4fm+?=
 =?us-ascii?Q?vUx0MVZ5of3t9xfaPUizJcWaHBS+Rnh1lj0g1p/DNsa4YnA2JWsnjIzyTz7e?=
 =?us-ascii?Q?7Tocpr2L5GuAkndMNOZ0u/vizVPi1Z3oaVEbbJuTByPAuzhObUSD2hhLjaBa?=
 =?us-ascii?Q?VdNCcuqoM2O+O7ln2YxVyuq+uJ317PLfL7NbOAtkK1scsBKgqPWWBbKTpBMb?=
 =?us-ascii?Q?+Yw2OZm54juAhssisL0Bmu8HX5Yy8nSlX61rUPqJV/mVksfZ4u21QUt3o3WB?=
 =?us-ascii?Q?HvvlhfGMDV8z3OSCEZHs7kxcmP7HD4UNCg7FfIJPCaMXB81JEQq7iaTdBl5z?=
 =?us-ascii?Q?B6XBKwRVD4RXOjd6jOyJk53kDtBsKgEfYhdKoKjdgDa36Nc/Z7lutPPD3DoV?=
 =?us-ascii?Q?nuBGdKYAhhEcKKsZvQGUd1DQ0d7NyIgo6p6LTNzQKvaWDSaHT0sVj0rgP6Oe?=
 =?us-ascii?Q?tp2oN1Ta6TauPn2vkYuH9DtbsxGAs5yKZyiwtFbwHLV8tXdZNYJU5RJq5oRy?=
 =?us-ascii?Q?3u+3eUG8RcIBw0zAHeyrBPfCIc1O+x9VHuacz/KKlYk5gOi1G1EtmHzC1+VU?=
 =?us-ascii?Q?gpvNI1DvTIa3PP63pp30+0nTAngMqumQw5sVFwtTKXRjebw1VhjR2dAeuDBR?=
 =?us-ascii?Q?XcrWBvM02ZQD3M1IIxA5PksWnfCO62KG+rafOslyZhIiqII6mH1dLCYtf86c?=
 =?us-ascii?Q?p2SCEOJ+bWg1dDm/nQSKBPNJrqHOzYHaWF9qaNL1KvBvJ7Y9qwA9H0XqdMnG?=
 =?us-ascii?Q?H2iPs/52pYI19+5dX3kjlz3i3Qyjs1f6Yj6Cwhho2lxJbaaVaxKM11oWV0yf?=
 =?us-ascii?Q?TSALrq4bKw4x258ua1NogppDbWGfizOIWuSrCb2FTqBYp7CguRPj14Ud7E8H?=
 =?us-ascii?Q?1veh7IisUdOnoBAaE2x1vAya/yzLDbXW/5AZWaCVoISzRTRtJQMp2dtbbrK9?=
 =?us-ascii?Q?6nZ5zxEaGQ3AwDcYGIX463HBKy1DPfITwwWZah1uLcf6+95TMW8aSCAJ5jej?=
 =?us-ascii?Q?ORqZQM7bDWpM+HcYiykT2m5DlSkd0C5hGzHQVNXwfeubYp61A1hbp8x+sI6b?=
 =?us-ascii?Q?ZCkgdFsAWKEAtJMgqo86Az7WYwjzLV0mtwLauLs4Lch5X6MhcnZo3vCxGU+e?=
 =?us-ascii?Q?a0Qn9WYsb4gYedCGPVIYpCRbUvwybks3S6Ls+3Nj6jGLHUT8gTVOZtZer+P3?=
 =?us-ascii?Q?lEwAo5GlqOfI3H9j9QzREuS0RPwYfn4=3D?=
X-Exchange-RoutingPolicyChecked: ghFiZ+tvLdjtnTHU7QEAYth8Tua6xXzusDIn1WzySWP/HAGayFbAVUq+ltUgo6NWg4qiaDEDFZviI9Ts/vd2/Q1aqNemZ2wRq34xewDdVny5ZhmfZU2GU6+2GBfCHghXcVEzD5nBPjiKVQ4qdFWn4H24/w+A+3pmy8tCf2ovKyMq/nXrCiSffnA0KYq6zcD64IxwWjoEDKUkKE0ICOFf2hW3KxqfZurMDkI8+pKz/oJ1UAuSoT3lviFWUs3z3uIqZ4aqQ4zg9rzbVFKA7o8tLTzOwX4aQGLC6DNpb7kq37x19SpLIgC2Sxpo8JVjKCeuwq1J9TW1PHVQvu+8BODgDQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78a4aeb6-74c4-488c-5c9b-08df3e55f724
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:38:25.0330 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LwNE/yqZn7STpI9EkefBjx+nRI7YJSFkksGxJSPOIyBteL2cJTwm8XcMbgYVaUZrpUOnvO7BrgVquGk3EfGwj/R5qLehhKk7Gy1CMs8dXAY=
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

Change the main "for" loop into "while" to get rid of obscure
iterator "i" and use more descriptive name to indicate how many
pages were already covered. Detect first loop with st->nents.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
index 59dae47fcfc8..792996b1e075 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_shmem.c
@@ -135,7 +135,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 			 unsigned int max_segment)
 {
 	unsigned int page_count; /* restricted by sg_alloc_table */
-	unsigned long i;
+	unsigned long pages_done = 0;
 	struct scatterlist *sg;
 	unsigned long next_pfn = 0;	/* suppress gcc warning */
 	struct folio *folio = NULL;
@@ -164,15 +164,15 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 
 	sg = st->sgl;
 	st->nents = 0;
-	for (i = 0; i < page_count; i++) {
+	while (pages_done < page_count) {
 		unsigned long folio_page_index;
 		unsigned long nr_pages;
 		gfp_t gfp = noreclaim;
 
-		if (!i || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
+		if (!pages_done || (next_pfn >= folio_pfn(folio) + folio_nr_pages(folio))) {
 			/* Grab the next folio if we exhausted the current one. */
-			folio = shmem_shrink_get_folio(mapping, i, &gfp,
-						       page_count, i915);
+			folio = shmem_shrink_get_folio(mapping, pages_done,
+						       &gfp, page_count, i915);
 			folio_page_index = 0;
 			if (IS_ERR(folio)) {
 				ret = PTR_ERR(folio);
@@ -187,12 +187,12 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		}
 
 		nr_pages = min3(folio_nr_pages(folio) - folio_page_index,
-				page_count - i, max_segment / PAGE_SIZE);
+				page_count - pages_done, max_segment / PAGE_SIZE);
 
-		if (!i ||
+		if (!st->nents ||
 		    sg->length >= max_segment ||
 		    folio_pfn(folio) != next_pfn) {
-			if (i)
+			if (st->nents)
 				sg = sg_next(sg);
 
 			st->nents++;
@@ -209,7 +209,7 @@ int shmem_sg_alloc_table(struct drm_i915_private *i915, struct sg_table *st,
 		 * can be merged into the same SG entry.
 		 */
 		next_pfn = folio_pfn(folio) + folio_page_index + nr_pages;
-		i += nr_pages - 1;
+		pages_done += nr_pages;
 
 		/* Check that the i965g/gm workaround works. */
 		GEM_BUG_ON(gfp & __GFP_DMA32 && next_pfn >= 0x00100000UL);
-- 
2.34.1

