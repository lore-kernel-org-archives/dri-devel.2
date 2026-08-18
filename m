Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0251C5DF70
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 09:57:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0CD0810EA8E;
	Tue, 18 Aug 2026 09:57:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kO2XN4al";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2C0310EAA8;
 Tue, 18 Aug 2026 09:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787047010; x=1818583010;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=4g5Rc2w0rKl6UPvq3w3oy8t14yrWioG7P82eFjfR1qM=;
 b=kO2XN4allPEV1DQwy+NRHEdSeuBml/Nb7eybd/ZB369Fg7y5Yu+Cb4tu
 WtgH+ceIew4WYln31V/e4Ff71SOHVCkOcQyemWpMNWFnnesOjbZaxBvn/
 e7SKtxhjoNLrEHRzQyks8BfUoOLp7Vqrajp7SHWw3X9cT2Kqu/d/m4tPn
 gsv70EF5+oez1kU1uyQp6nYHH2KrQO2yWkX3QWh94vT5ErlADmusvykUd
 B87v76vexVEJNxvI6tISc4A/iACjleTc1zcEScFmJY9QPozqWdOeIGoBD
 Oz+4imBR7nACD5Nw51ykntVDHNCvYO+oXJNvcnCKETWhhDObItWIpCH6R w==;
X-CSE-ConnectionGUID: xc03BA2yRqCtGMyqamGqUw==
X-CSE-MsgGUID: uqBMRCQAScCbxtQpy+L14g==
X-IronPort-AV: E=McAfee;i="6800,10657,11878"; a="87655739"
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="87655739"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:49 -0700
X-CSE-ConnectionGUID: UBWrDnEpQNKswZ/Ulq/x4g==
X-CSE-MsgGUID: M3md7qa/QSaJ1w4PeusLXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,230,1779174000"; d="scan'208";a="264736801"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Aug 2026 02:56:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:48 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 18 Aug 2026 02:56:48 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.5) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 18 Aug 2026 02:56:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wJW16M0XpBQ1vSJDtSQG11za2lp2bW0r38Fj0Z60ncgi/gRxMPcfNT6vzvXqIRTUpcSqXo41YP16gMktPbpD+6ijmfT8C9ZwZtkhIGLtlB/eSJdaTBoYAx95LpUgsZ22QWvott9kQyPx+5x+uducGSpHasAlWUAvfUPJVSc30mDm/CL+LDy5RbMPEjEQm90EnGBKqWuDNbs4M5Q0CmPwP05WPOW+z3rwhL+gvHDEaBacXVMowYWx3sLym8pDPrl6P2TIdj9lP5J53U8HtZZju3Ht+7cgLKFm6yiJ2fBjTj7XwMqkP2aO6Bs4t972rBk9NFe5Q4QfjT5exYJfxRQPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I793covvXvnn6Ox4ra7+H1Hws5Ts9Kn+4Z0n1qqd6xk=;
 b=hgZlVqt9gIydhHo/YGkzPCSKhC4LrsLMCiEJEqnO+3vNy06xdaLr0FR2MZWcWYardnglr7hrj9nNEzilpEkW100Am6go+9vk/M6yA7tmFk61rGr5itK2s3tcM8d5KriUBxk0fNoeH+wmpYQlMJpBZmNIUxomTFXoZeyvSOZgwACBHxOSdhCwce818lXr0JxHWm5fT3LJm6qNEppPZKh0hwS7GLYkEeOH7jqCRgpukSum/v7GSiOelh8npW62DjGZ456j3+i3wkUhFfJR815gb/h/Af+AnzbqKotCNfwdl24cHTUmahYyDGXR1CuSlZyQzaYGvM2YBshb39eMWgZ/Gg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH7PR11MB6500.namprd11.prod.outlook.com (2603:10b6:510:213::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.8; Tue, 18 Aug
 2026 09:56:46 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.016; Tue, 18 Aug 2026
 09:56:46 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v2 6/8] drm/i915/gt/selftests: Use drm_* prints in gt
 standalone tests
Date: Tue, 18 Aug 2026 09:56:22 +0000
Message-ID: <20260818095624.3254368-7-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260818095624.3254368-1-krzysztof.karas@intel.com>
References: <20260818095624.3254368-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB9PR02CA0001.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::6) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH7PR11MB6500:EE_
X-MS-Office365-Filtering-Correlation-Id: 2bbec5fd-f18d-45ad-5568-08defd0f03e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|56012099006|10067099003|22082099003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: +9vUmz6WoqHd5KqUcWmvkB09HKn1DsMXIICB1WI3Gv7Q5NLdeQCyaW0D7Avj+Tx/LDb/aLvOt3rIuCrNziDEIytH826L/s5mCoTUDhxyFMK0M9rNVnF2xhfLZn89SYQdeGN3fWDsd053s7r0z28qC/Zj8ffZ/CVxNFX61gIxU6hKF8Ak0AstpcVGKazKOZ1McmEOAgfmKjB3S+8W+TbaK3RMn5m/rN4ZjMTl115U8g1aF364fbtvwWH5w7xv/+Zk09SuSGWZiTZP+bHEoTzOfn7sj7F49aDcmytrUGldjHz7s+P9UTSIa36ufUQyxaw4WjgbZiOuSF5tcFTd7R7VI41PqkySHSI895ld6hbZAvE6pRYAAI5I4d4DbkSU6rAKrbGWVdY3UE/nEKg3YeDxuwcLnlgj/4+39FKQsp9DbSCXl7uBNwul0QoNkQTviFFafiu+mXoTL9pCFqKyNN6NbC5tnRPbWVRKKrr+5pthquneFkKqJJHBnNlYN6x59eFRNL2zN+YxNhtFZV49HL/IRr5TyCIQzUzIeGel3CCe0Y1RADU0oHP6rv9xDZWObmUItOfzcaGmnsJSgTGgYumEL3DnFBM96yPuNwRGLCzrLJI5b0CkT8HYPVQbdF7f5ahu5TcZZ/B/kx862c2Qg01NnXALd7JPX8gPyagtiUGx66I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(56012099006)(10067099003)(22082099003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?v1DYF1V+kZNreKSJVwqo7cbRsqpjlxXNBaSVarMYMQDV+qVJ7F8zl8n9AjHU?=
 =?us-ascii?Q?1OHFXE4B99LCQOu12Jo6pgEHCdcK5xCs4yBvn1r0QXljEGDUeLwth7iYIJoc?=
 =?us-ascii?Q?zLRkhYkquglqYrwxRsNFnYHb+yIpblDDMZwNg6RYrzX/x4ajwluUzKUE5Urw?=
 =?us-ascii?Q?hgfAModZRYpEfQa2w6ENlZgYzQ+bquzDJ0jsUld/twf+TfaYSf1jLPj4JI/5?=
 =?us-ascii?Q?4UFx5eKLMX4Zdl7auVyezEYN+RpcqDnTbQAUjaLq9bjDXUj1WA74GxI87wvu?=
 =?us-ascii?Q?SQkPIqt8hnMI/9m5RZq7ITRqlh8J5HAuvkEqq4IvXfwSTQaYeo7Yjalxdy2K?=
 =?us-ascii?Q?VQbzGIn4D4gZKiGEBIZfFdMeA66fvzy819/LRK9bib3+xdCb1zv+xUuOS/Af?=
 =?us-ascii?Q?1AtPA7cS/AJNhPyvLyIn/h+/ypK0G5tQjybsRv2f+Xho2ffcVBaKRf/1oM2Q?=
 =?us-ascii?Q?MMPgQ/rfR8W1wUJKsg21C9e8tQjTiom24ga/1rYNtrutSR10lZGKE0EQ1Ufv?=
 =?us-ascii?Q?3NHB5u2BQtwYQPKw4EOs71x9A74KVebwdNWXJHWKGYZTMNbJD/6mDfNhUk1l?=
 =?us-ascii?Q?I40jV/87Ok3fM52hAt5k9IvunI5eh1qe5KEQtpCZpvqCe3FKbYQj25p3mRfA?=
 =?us-ascii?Q?XFVoX5SLJtALaxnsGHYQqL9EBLn8d4BEPDRSxsjlyoKuNKxedU/caxbkI98v?=
 =?us-ascii?Q?tIJpBSb44EbBSyR3F3Sma0hIpCNQXl/aWPsQbySThuzhkflM76S19eUxwMt0?=
 =?us-ascii?Q?sNozaLyusITzeztMoFK3Vo6DIMdqZ9pB2eg6BWQjQ0xpBnBYmahMfyWwOALP?=
 =?us-ascii?Q?imvxKmQwXQYx+2AWXkvccEyAnZP+5hrTunnVZPjzt3qZMQPP638tv3IIIsjO?=
 =?us-ascii?Q?5xc+hv4IOunebG4Y5M9ofmQFj0AkU7Gis3p80WftE4h8mmVujbGQc+uICCi1?=
 =?us-ascii?Q?uI8hfkZ1soFjI41SmqYPhQ7ku4kuJ0O/Wkv1wZkQWXDqkJLBGL5rkWyXJu/s?=
 =?us-ascii?Q?WrIYNT11M+6tlBMBwt9dNNsStPGtFGDuCirQhs5ZRiVprWhTEisR2g3ykuzx?=
 =?us-ascii?Q?21GnJmSsEeRjdkKy/3lzX4RpOulDTA+DgfqKiMtfCdy91DpthNki796oFoq+?=
 =?us-ascii?Q?XmfbXMN01YfiZhqfqXsG2ujOT3pkKemQXYnt+/d50VMd+mgUq67rfjdVAPm/?=
 =?us-ascii?Q?m7xF6GaSAwFaVLzNxEwjGGjbySQxsm3RmdFuM1wI4eu/KZbT0uUmZX9wxSG/?=
 =?us-ascii?Q?zUub/fd0TOJxVgW4URjJzTAQeMO63TKsrj0I0zlacEfttyQXJX45RdGxOXaU?=
 =?us-ascii?Q?8OMpqjK0+nlOuyhp0loUZk9dlHKhp30SStICFCSXYOYxs/m5ZMCSsCh5wVhk?=
 =?us-ascii?Q?6WfuQcXdeADECxqkuKi3gHKJo9YaaZM/gfj4RO4+aUZY1RmbY2SrWj1GIaWF?=
 =?us-ascii?Q?xxGhEPTpj8b4fHLOWEJb9pQI44MXFi4xw03i76Ta5q3VuBCR5UItz8dzYQ+f?=
 =?us-ascii?Q?UtmGrhEGSsTsgMcx7bFLLM2WAKdCuEeQWDiozRTNvYq5iZJLyW7AIecuIusF?=
 =?us-ascii?Q?z1Jj9tKw4nWBEoDkxqOKA01OrbGQZKQiOymbNwRXHq1X5a36grWLS4vCIQMs?=
 =?us-ascii?Q?BKSnQ/dgLeZiMnutXawrukn4cjUxclpaK9UJWoTMIY7PfGrxy3KwZdjBgz5e?=
 =?us-ascii?Q?uAKulzONtCvi9wIEPgRLbA3zZ6k6wX+u751ffziFcbvHGtVrM1a907lXP4g7?=
 =?us-ascii?Q?bC/0U/+f8FlR94PoyVQF32vzR/oszMo=3D?=
X-Exchange-RoutingPolicyChecked: fwoadxzHgcIE0nxY8wAA1GkRnUuW6rM1DDdDFALSj4rMp+vv/DIuvroJ7VBWOVDsjsfuTVRJ2ExxehicdgNr/6I54yDqlr1Qpw9LrJTTtJVgNyTse8T1pt805gb6G8gYfQZUlynWxoGNCEZwNXhyeGZAnwOOtEkkklpFpWUrhklpaZ18CirW4oOd/H53P7HVocP5xd3ZrB7/0I8wtuLaDwFfWfuC2Qp0uQnDbWW/STkMXriQzyLRCUT7SSXDxFeUTz1lKfDELiJ9UzJc8+/lsTKgF+9UCqgd2LlK8NbsQe/v7XNTY6wMxa3FspRjQKfsR3yUAwZMySo5ql69F7jCrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bbec5fd-f18d-45ad-5568-08defd0f03e3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2026 09:56:46.7036 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J0YwZxPZFe2zwT+PUuLN2BoCqeYMH0jCjlNEkIadPp1s9jXCJzgrjeymNaEmCTbHQ6TVQVjYSSfAobApogQLJZXfHOYXt/V5OKrjcgboh+8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6500
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

Move away from generic pr prints to device context aware drm
versions.

Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gt/selftest_rc6.c |  55 +++---
 drivers/gpu/drm/i915/gt/selftest_rps.c | 252 +++++++++++++------------
 2 files changed, 164 insertions(+), 143 deletions(-)

diff --git a/drivers/gpu/drm/i915/gt/selftest_rc6.c b/drivers/gpu/drm/i915/gt/selftest_rc6.c
index 90f30b988d68..c46a95fa4ed9 100644
--- a/drivers/gpu/drm/i915/gt/selftest_rc6.c
+++ b/drivers/gpu/drm/i915/gt/selftest_rc6.c
@@ -14,6 +14,8 @@
 #include "selftests/i915_random.h"
 #include "selftests/librapl.h"
 
+#include <drm/drm_print.h>
+
 static u64 rc6_residency(struct intel_rc6 *rc6)
 {
 	u64 result;
@@ -80,8 +82,9 @@ int live_rc6_manual(void *arg)
 	res[1] = rc6_residency(rc6);
 	rc0_freq = intel_rps_read_actual_frequency_fw(rps);
 	if ((res[1] - res[0]) >> 10) {
-		pr_err("RC6 residency increased by %lldus while disabled for 1000ms!\n",
-		       (res[1] - res[0]) >> 10);
+		drm_err(&gt->i915->drm,
+			"RC6 residency increased by %lldus while disabled for 1000ms!\n",
+			(res[1] - res[0]) >> 10);
 		err = -EINVAL;
 		goto out_unlock;
 	}
@@ -92,10 +95,12 @@ int live_rc6_manual(void *arg)
 
 		if (!rc0_power) {
 			if (rc0_freq)
-				pr_debug("No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
-					 rc0_freq);
+				drm_dbg(&gt->i915->drm,
+					"No power measured while in RC0! GPU Freq: %uMHz in RC0\n",
+					rc0_freq);
 			else
-				pr_err("No power and freq measured while in RC0\n");
+				drm_err(&gt->i915->drm,
+					"No power and freq measured while in RC0\n");
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -114,32 +119,36 @@ int live_rc6_manual(void *arg)
 	dt = ktime_sub(ktime_get(), dt);
 	res[1] = rc6_residency(rc6);
 	if (res[1] == res[0]) {
-		pr_err("Did not enter RC6! RC6_STATE=%08x, RC6_CONTROL=%08x, residency=%lld\n",
-		       intel_uncore_read_fw(gt->uncore, GEN6_RC_STATE),
-		       intel_uncore_read_fw(gt->uncore, GEN6_RC_CONTROL),
-		       res[0]);
+		drm_err(&gt->i915->drm,
+			"Did not enter RC6! RC6_STATE=%08x, RC6_CONTROL=%08x, residency=%lld\n",
+			intel_uncore_read_fw(gt->uncore, GEN6_RC_STATE),
+			intel_uncore_read_fw(gt->uncore, GEN6_RC_CONTROL),
+			res[0]);
 		err = -EINVAL;
 	}
 
 	if (has_power) {
 		rc6_power = div64_u64(NSEC_PER_SEC * rc6_sample_energy[1],
 				      ktime_to_ns(dt));
-		pr_info("GPU consumed %lluuW in RC0 and %lluuW in RC6\n",
-			rc0_power, rc6_power);
+		drm_info(&gt->i915->drm,
+			 "GPU consumed %lluuW in RC0 and %lluuW in RC6\n",
+			 rc0_power, rc6_power);
 
 		if (2 * rc6_power > rc0_power) {
-			pr_err("GPU leaked energy while in RC6!\n"
-			       "GPU Freq: %uMHz in RC6 and %uMHz in RC0\n"
-			       "RC0 energy before & after sleep respectively: %lluuJ %lluuJ\n"
-			       "RC6 energy before & after sleep respectively: %lluuJ %lluuJ\n",
-			       rc6_freq, rc0_freq, rc0_sample_energy[0], rc0_sample_energy[1],
-			       rc6_sample_energy[0], rc6_sample_energy[1]);
+			drm_err(&gt->i915->drm,
+				"GPU leaked energy while in RC6!\n"
+				"GPU Freq: %uMHz in RC6 and %uMHz in RC0\n"
+				"RC0 energy before & after sleep respectively: %lluuJ %lluuJ\n"
+				"RC6 energy before & after sleep respectively: %lluuJ %lluuJ\n",
+				rc6_freq, rc0_freq, rc0_sample_energy[0], rc0_sample_energy[1],
+				rc6_sample_energy[0], rc6_sample_energy[1]);
 
 			diff = res[1] - res[0];
 			threshold = (9 * NSEC_PER_MSEC * sleep_time) / 10;
 			if (diff < threshold)
-				pr_err("Did not enter RC6 properly, RC6 start residency=%lluns, RC6 end residency=%lluns\n",
-				       res[0], res[1]);
+				drm_err(&gt->i915->drm,
+					"Did not enter RC6 properly, RC6 start residency=%lluns, RC6 end residency=%lluns\n",
+					res[0], res[1]);
 			err = -EINVAL;
 			goto out_unlock;
 		}
@@ -265,13 +274,13 @@ int live_rc6_ctx_wa(void *arg)
 			}
 
 			intel_gt_pm_wait_for_idle(gt);
-			pr_debug("%s: CTX_INFO=%0x\n",
-				 engine->name, READ_ONCE(*res));
+			drm_dbg(&engine->i915->drm, "%s: CTX_INFO=%0x\n",
+				engine->name, READ_ONCE(*res));
 
 			if (resets !=
 			    i915_reset_engine_count(error, engine)) {
-				pr_err("%s: GPU reset required\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: GPU reset required\n", engine->name);
 				add_taint_for_CI(gt->i915, TAINT_WARN);
 				err = -EIO;
 				goto out;
diff --git a/drivers/gpu/drm/i915/gt/selftest_rps.c b/drivers/gpu/drm/i915/gt/selftest_rps.c
index be77fba2ec49..27435560c64b 100644
--- a/drivers/gpu/drm/i915/gt/selftest_rps.c
+++ b/drivers/gpu/drm/i915/gt/selftest_rps.c
@@ -6,6 +6,8 @@
 #include <linux/pm_qos.h>
 #include <linux/sort.h>
 
+#include <drm/drm_print.h>
+
 #include "gem/i915_gem_internal.h"
 
 #include "i915_reg.h"
@@ -204,15 +206,15 @@ static void show_pstate_limits(struct intel_rps *rps)
 	struct drm_i915_private *i915 = rps_to_i915(rps);
 
 	if (IS_BROXTON(i915)) {
-		pr_info("P_STATE_CAP[%x]: 0x%08x\n",
-			i915_mmio_reg_offset(BXT_RP_STATE_CAP),
-			intel_uncore_read(rps_to_uncore(rps),
-					  BXT_RP_STATE_CAP));
+		drm_info(&i915->drm, "P_STATE_CAP[%x]: 0x%08x\n",
+			 i915_mmio_reg_offset(BXT_RP_STATE_CAP),
+			 intel_uncore_read(rps_to_uncore(rps),
+					   BXT_RP_STATE_CAP));
 	} else if (GRAPHICS_VER(i915) == 9) {
-		pr_info("P_STATE_LIMITS[%x]: 0x%08x\n",
-			i915_mmio_reg_offset(GEN9_RP_STATE_LIMITS),
-			intel_uncore_read(rps_to_uncore(rps),
-					  GEN9_RP_STATE_LIMITS));
+		drm_info(&i915->drm, "P_STATE_LIMITS[%x]: 0x%08x\n",
+			 i915_mmio_reg_offset(GEN9_RP_STATE_LIMITS),
+			 intel_uncore_read(rps_to_uncore(rps),
+					   GEN9_RP_STATE_LIMITS));
 	}
 }
 
@@ -264,8 +266,8 @@ int live_rps_clock_interval(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: RPS spinner did not start\n", engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -290,8 +292,9 @@ int live_rps_clock_interval(void *arg)
 						  GEN6_RP_CUR_UP_EI),
 			     10)) {
 			/* Just skip the test; assume lack of HW support */
-			pr_notice("%s: rps evaluation interval not ticking\n",
-				  engine->name);
+			drm_notice(&engine->i915->drm,
+				   "%s: rps evaluation interval not ticking\n",
+				   engine->name);
 			err = -ENODEV;
 		} else {
 			ktime_t dt_[5];
@@ -330,21 +333,24 @@ int live_rps_clock_interval(void *arg)
 			u32 expected =
 				intel_gt_ns_to_pm_interval(gt, dt);
 
-			pr_info("%s: rps counted %d C0 cycles [%lldns] in %lldns [%d cycles], using GT clock frequency of %uKHz\n",
-				engine->name, cycles, time, dt, expected,
-				gt->clock_frequency / 1000);
+			drm_info(&engine->i915->drm,
+				 "%s: rps counted %d C0 cycles [%lldns] in %lldns [%d cycles], using GT clock frequency of %uKHz\n",
+				 engine->name, cycles, time, dt, expected,
+				 gt->clock_frequency / 1000);
 
 			if (10 * time < 8 * dt ||
 			    8 * time > 10 * dt) {
-				pr_err("%s: rps clock time does not match walltime!\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: rps clock time does not match walltime!\n",
+					engine->name);
 				err = -EINVAL;
 			}
 
 			if (10 * expected < 8 * cycles ||
 			    8 * expected > 10 * cycles) {
-				pr_err("%s: walltime does not match rps clock ticks!\n",
-				       engine->name);
+				drm_err(&engine->i915->drm,
+					"%s: walltime does not match rps clock ticks!\n",
+					engine->name);
 				err = -EINVAL;
 			}
 		}
@@ -424,8 +430,8 @@ int live_rps_control(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: RPS spinner did not start\n", engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -434,8 +440,9 @@ int live_rps_control(void *arg)
 		}
 
 		if (rps_set_check(rps, rps->min_freq) != rps->min_freq) {
-			pr_err("%s: could not set minimum frequency [%x], only %x!\n",
-			       engine->name, rps->min_freq, read_cagf(rps));
+			drm_err(&engine->i915->drm,
+				"%s: could not set minimum frequency [%x], only %x!\n",
+				engine->name, rps->min_freq, read_cagf(rps));
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			show_pstate_limits(rps);
@@ -451,8 +458,9 @@ int live_rps_control(void *arg)
 		limit = rps_set_check(rps, f);
 
 		if (rps_set_check(rps, rps->min_freq) != rps->min_freq) {
-			pr_err("%s: could not restore minimum frequency [%x], only %x!\n",
-			       engine->name, rps->min_freq, read_cagf(rps));
+			drm_err(&engine->i915->drm,
+				"%s: could not restore minimum frequency [%x], only %x!\n",
+				engine->name, rps->min_freq, read_cagf(rps));
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			show_pstate_limits(rps);
@@ -474,7 +482,8 @@ int live_rps_control(void *arg)
 		igt_spinner_end(&spin);
 		st_engine_heartbeat_enable(engine);
 
-		pr_info("%s: range:[%x:%uMHz, %x:%uMHz] limit:[%x:%uMHz], %x:%x response %lluns:%lluns\n",
+		drm_info(&engine->i915->drm,
+			 "%s: range:[%x:%uMHz, %x:%uMHz] limit:[%x:%uMHz], %x:%x response %lluns:%lluns\n",
 			engine->name,
 			rps->min_freq, intel_gpu_freq(rps, rps->min_freq),
 			rps->max_freq, intel_gpu_freq(rps, rps->max_freq),
@@ -483,8 +492,9 @@ int live_rps_control(void *arg)
 
 		if (limit != rps->max_freq) {
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&engine->i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 			show_pstate_limits(rps);
 		}
 
@@ -523,17 +533,16 @@ static void show_pcu_config(struct intel_rps *rps)
 
 	wakeref = intel_runtime_pm_get(rps_to_uncore(rps)->rpm);
 
-	pr_info("%5s  %5s  %5s\n", "GPU", "eCPU", "eRing");
+	drm_info(&i915->drm, "%5s  %5s  %5s\n", "GPU", "eCPU", "eRing");
 	for (gpu_freq = min_gpu_freq; gpu_freq <= max_gpu_freq; gpu_freq++) {
 		int ia_freq = gpu_freq;
 
 		snb_pcode_read(rps_to_gt(rps)->uncore, GEN6_PCODE_READ_MIN_FREQ_TABLE,
 			       &ia_freq, NULL);
 
-		pr_info("%5d  %5d  %5d\n",
-			gpu_freq * 50,
-			((ia_freq >> 0) & 0xff) * 100,
-			((ia_freq >> 8) & 0xff) * 100);
+		drm_info(&i915->drm, "%5d  %5d  %5d\n", gpu_freq * 50,
+			 ((ia_freq >> 0) & 0xff) * 100,
+			 ((ia_freq >> 8) & 0xff) * 100);
 	}
 
 	intel_runtime_pm_put(rps_to_uncore(rps)->rpm, wakeref);
@@ -669,8 +678,8 @@ int live_rps_frequency_cs(void *arg)
 
 		if (wait_for(intel_uncore_read(engine->uncore, CS_GPR(0)),
 			     10)) {
-			pr_err("%s: timed loop did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: timed loop did not start\n", engine->name);
 			goto err_vma;
 		}
 
@@ -680,22 +689,21 @@ int live_rps_frequency_cs(void *arg)
 		max.freq = rps->max_freq;
 		max.count = measure_cs_frequency_at(rps, engine, &max.freq);
 
-		pr_info("%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
-			engine->name,
-			min.count, intel_gpu_freq(rps, min.freq),
-			max.count, intel_gpu_freq(rps, max.freq),
-			(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * max.count,
-						     max.freq * min.count));
+		drm_info(&engine->i915->drm,
+			 "%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n", engine->name,
+			 min.count, intel_gpu_freq(rps, min.freq),
+			 max.count, intel_gpu_freq(rps, max.freq),
+			 (int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * max.count,
+						      max.freq * min.count));
 
 		if (!scaled_within(max.freq * min.count,
 				   min.freq * max.count,
 				   2, 3)) {
 			int f;
 
-			pr_err("%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
-			       engine->name,
-			       max.freq * min.count,
-			       min.freq * max.count);
+			drm_err(&engine->i915->drm,
+				"%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
+				engine->name, max.freq * min.count, min.freq * max.count);
 			show_pcu_config(rps);
 
 			for (f = min.freq + 1; f <= rps->max_freq; f++) {
@@ -706,11 +714,10 @@ int live_rps_frequency_cs(void *arg)
 				if (act < f)
 					break;
 
-				pr_info("%s: %x:%uMHz: %lluKHz [%d%%]\n",
-					engine->name,
-					act, intel_gpu_freq(rps, act), count,
-					(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
-								     act * min.count));
+				drm_info(&engine->i915->drm,  "%s: %x:%uMHz: %lluKHz [%d%%]\n",
+					 engine->name, act, intel_gpu_freq(rps, act), count,
+					 (int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
+								      act * min.count));
 
 				f = act; /* may skip ahead [pcu granularity] */
 			}
@@ -807,8 +814,8 @@ int live_rps_frequency_srm(void *arg)
 			goto err_vma;
 
 		if (wait_for(READ_ONCE(*cntr), 10)) {
-			pr_err("%s: timed loop did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: timed loop did not start\n", engine->name);
 			goto err_vma;
 		}
 
@@ -818,7 +825,8 @@ int live_rps_frequency_srm(void *arg)
 		max.freq = rps->max_freq;
 		max.count = measure_frequency_at(rps, cntr, &max.freq);
 
-		pr_info("%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
+		drm_info(&engine->i915->drm,
+			 "%s: min:%lluKHz @ %uMHz, max:%lluKHz @ %uMHz [%d%%]\n",
 			engine->name,
 			min.count, intel_gpu_freq(rps, min.freq),
 			max.count, intel_gpu_freq(rps, max.freq),
@@ -830,10 +838,9 @@ int live_rps_frequency_srm(void *arg)
 				   1, 2)) {
 			int f;
 
-			pr_err("%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
-			       engine->name,
-			       max.freq * min.count,
-			       min.freq * max.count);
+			drm_err(&engine->i915->drm,
+				"%s: CS did not scale with frequency! scaled min:%llu, max:%llu\n",
+				engine->name, max.freq * min.count, min.freq * max.count);
 			show_pcu_config(rps);
 
 			for (f = min.freq + 1; f <= rps->max_freq; f++) {
@@ -844,11 +851,10 @@ int live_rps_frequency_srm(void *arg)
 				if (act < f)
 					break;
 
-				pr_info("%s: %x:%uMHz: %lluKHz [%d%%]\n",
-					engine->name,
-					act, intel_gpu_freq(rps, act), count,
-					(int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
-								     act * min.count));
+				drm_info(&engine->i915->drm, "%s: %x:%uMHz: %lluKHz [%d%%]\n",
+					 engine->name, act, intel_gpu_freq(rps, act), count,
+					 (int)DIV64_U64_ROUND_CLOSEST(100 * min.freq * count,
+								      act * min.count));
 
 				f = act; /* may skip ahead [pcu granularity] */
 			}
@@ -915,31 +921,31 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	i915_request_add(rq);
 
 	if (!igt_wait_for_spinner(spin, rq)) {
-		pr_err("%s: RPS spinner did not start\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS spinner did not start\n", engine->name);
 		i915_request_put(rq);
 		intel_gt_set_wedged(engine->gt);
 		return -EIO;
 	}
 
 	if (!intel_rps_is_active(rps)) {
-		pr_err("%s: RPS not enabled on starting spinner\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS not enabled on starting spinner\n", engine->name);
 		igt_spinner_end(spin);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_events & GEN6_PM_RP_UP_THRESHOLD)) {
-		pr_err("%s: RPS did not register UP interrupt\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS did not register UP interrupt\n", engine->name);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
 
 	if (rps->last_freq != rps->min_freq) {
-		pr_err("%s: RPS did not program min frequency\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS did not program min frequency\n", engine->name);
 		i915_request_put(rq);
 		return -EINVAL;
 	}
@@ -955,17 +961,19 @@ static int __rps_up_interrupt(struct intel_rps *rps,
 	i915_request_put(rq);
 
 	if (rps->cur_freq != rps->min_freq) {
-		pr_err("%s: Frequency unexpectedly changed [up], now %d!\n",
-		       engine->name, intel_rps_read_actual_frequency(rps));
+		drm_err(&engine->i915->drm,
+			"%s: Frequency unexpectedly changed [up], now %d!\n",
+			engine->name, intel_rps_read_actual_frequency(rps));
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_iir & GEN6_PM_RP_UP_THRESHOLD)) {
-		pr_err("%s: UP interrupt not recorded for spinner, pm_iir:%x, prev_up:%x, up_threshold:%x, up_ei:%x\n",
-		       engine->name, rps->pm_iir,
-		       intel_uncore_read(uncore, GEN6_RP_PREV_UP),
-		       intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
-		       intel_uncore_read(uncore, GEN6_RP_UP_EI));
+		drm_err(&engine->i915->drm,
+			"%s: UP interrupt not recorded for spinner, pm_iir:%x, prev_up:%x, up_threshold:%x, up_ei:%x\n",
+			engine->name, rps->pm_iir,
+			intel_uncore_read(uncore, GEN6_RP_PREV_UP),
+			intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
+			intel_uncore_read(uncore, GEN6_RP_UP_EI));
 		return -EINVAL;
 	}
 
@@ -981,14 +989,14 @@ static int __rps_down_interrupt(struct intel_rps *rps,
 	rps_set_check(rps, rps->max_freq);
 
 	if (!(rps->pm_events & GEN6_PM_RP_DOWN_THRESHOLD)) {
-		pr_err("%s: RPS did not register DOWN interrupt\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS did not register DOWN interrupt\n", engine->name);
 		return -EINVAL;
 	}
 
 	if (rps->last_freq != rps->max_freq) {
-		pr_err("%s: RPS did not program max frequency\n",
-		       engine->name);
+		drm_err(&engine->i915->drm,
+			"%s: RPS did not program max frequency\n", engine->name);
 		return -EINVAL;
 	}
 
@@ -999,21 +1007,22 @@ static int __rps_down_interrupt(struct intel_rps *rps,
 	sleep_for_ei(rps, timeout);
 
 	if (rps->cur_freq != rps->max_freq) {
-		pr_err("%s: Frequency unexpectedly changed [down], now %d!\n",
-		       engine->name,
-		       intel_rps_read_actual_frequency(rps));
+		drm_err(&engine->i915->drm,
+			"%s: Frequency unexpectedly changed [down], now %d!\n",
+			engine->name, intel_rps_read_actual_frequency(rps));
 		return -EINVAL;
 	}
 
 	if (!(rps->pm_iir & (GEN6_PM_RP_DOWN_THRESHOLD | GEN6_PM_RP_DOWN_TIMEOUT))) {
-		pr_err("%s: DOWN interrupt not recorded for idle, pm_iir:%x, prev_down:%x, down_threshold:%x, down_ei:%x [prev_up:%x, up_threshold:%x, up_ei:%x]\n",
-		       engine->name, rps->pm_iir,
-		       intel_uncore_read(uncore, GEN6_RP_PREV_DOWN),
-		       intel_uncore_read(uncore, GEN6_RP_DOWN_THRESHOLD),
-		       intel_uncore_read(uncore, GEN6_RP_DOWN_EI),
-		       intel_uncore_read(uncore, GEN6_RP_PREV_UP),
-		       intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
-		       intel_uncore_read(uncore, GEN6_RP_UP_EI));
+		drm_err(&engine->i915->drm,
+			"%s: DOWN interrupt not recorded for idle, pm_iir:%x, prev_down:%x, down_threshold:%x, down_ei:%x [prev_up:%x, up_threshold:%x, up_ei:%x]\n",
+			engine->name, rps->pm_iir,
+			intel_uncore_read(uncore, GEN6_RP_PREV_DOWN),
+			intel_uncore_read(uncore, GEN6_RP_DOWN_THRESHOLD),
+			intel_uncore_read(uncore, GEN6_RP_DOWN_EI),
+			intel_uncore_read(uncore, GEN6_RP_PREV_UP),
+			intel_uncore_read(uncore, GEN6_RP_UP_THRESHOLD),
+			intel_uncore_read(uncore, GEN6_RP_UP_EI));
 		return -EINVAL;
 	}
 
@@ -1043,7 +1052,8 @@ int live_rps_interrupt(void *arg)
 	with_intel_gt_pm(gt, wakeref)
 		pm_events = rps->pm_events;
 	if (!pm_events) {
-		pr_err("No RPS PM events registered, but RPS is enabled?\n");
+		drm_err(&gt->i915->drm,
+			"No RPS PM events registered, but RPS is enabled?\n");
 		return -ENODEV;
 	}
 
@@ -1186,8 +1196,8 @@ int live_rps_power(void *arg)
 		i915_request_add(rq);
 
 		if (!igt_wait_for_spinner(&spin, rq)) {
-			pr_err("%s: RPS spinner did not start\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: RPS spinner did not start\n", engine->name);
 			igt_spinner_end(&spin);
 			st_engine_heartbeat_enable(engine);
 			intel_gt_set_wedged(engine->gt);
@@ -1207,29 +1217,32 @@ int live_rps_power(void *arg)
 		igt_spinner_end(&spin);
 		st_engine_heartbeat_enable(engine);
 
-		pr_info("%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
-			engine->name,
-			min.power, intel_gpu_freq(rps, min.freq),
-			max.power, intel_gpu_freq(rps, max.freq));
+		drm_info(&engine->i915->drm, "%s: min:%llumW @ %uMHz, max:%llumW @ %uMHz\n",
+			 engine->name, min.power, intel_gpu_freq(rps, min.freq),
+			 max.power, intel_gpu_freq(rps, max.freq));
 
 		if (10 * min.freq >= 9 * max.freq) {
-			pr_notice("Could not control frequency, ran at [%d:%uMHz, %d:%uMhz]\n",
-				  min.freq, intel_gpu_freq(rps, min.freq),
-				  max.freq, intel_gpu_freq(rps, max.freq));
+			drm_notice(&engine->i915->drm,
+				   "Could not control frequency, ran at [%d:%uMHz, %d:%uMhz]\n",
+				   min.freq, intel_gpu_freq(rps, min.freq),
+				   max.freq, intel_gpu_freq(rps, max.freq));
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&engine->i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 			continue;
 		}
 
 		if (11 * min.power > 10 * max.power) {
-			pr_err("%s: did not conserve power when setting lower frequency!\n",
-			       engine->name);
+			drm_err(&engine->i915->drm,
+				"%s: did not conserve power when setting lower frequency!\n",
+				engine->name);
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&engine->i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 
 			err = -EINVAL;
 			break;
@@ -1273,9 +1286,9 @@ int live_rps_dynamic(void *arg)
 		return -ENOMEM;
 
 	if (intel_rps_has_interrupts(rps))
-		pr_info("RPS has interrupt support\n");
+		drm_info(&gt->i915->drm, "RPS has interrupt support\n");
 	if (intel_rps_uses_timer(rps))
-		pr_info("RPS has timer support\n");
+		drm_info(&gt->i915->drm, "RPS has timer support\n");
 
 	for_each_engine(engine, gt, id) {
 		struct i915_request *rq;
@@ -1318,19 +1331,18 @@ int live_rps_dynamic(void *arg)
 		min.freq = wait_for_freq(rps, rps->min_freq, 2000);
 		min.dt = ktime_sub(ktime_get(), min.dt);
 
-		pr_info("%s: dynamically reclocked to %u:%uMHz while busy in %lluns, and %u:%uMHz while idle in %lluns\n",
-			engine->name,
-			max.freq, intel_gpu_freq(rps, max.freq),
-			ktime_to_ns(max.dt),
-			min.freq, intel_gpu_freq(rps, min.freq),
-			ktime_to_ns(min.dt));
+		drm_info(&engine->i915->drm,
+			 "%s: dynamically reclocked to %u:%uMHz while busy in %lluns, and %u:%uMHz while idle in %lluns\n",
+			 engine->name, max.freq, intel_gpu_freq(rps, max.freq), ktime_to_ns(max.dt),
+			 min.freq, intel_gpu_freq(rps, min.freq), ktime_to_ns(min.dt));
 		if (min.freq >= max.freq) {
-			pr_err("%s: dynamic reclocking of spinner failed\n!",
-			       engine->name);
+			drm_err(&engine->i915->drm, "%s: dynamic reclocking of spinner failed\n!",
+				engine->name);
 
 			if (throttle)
-				pr_warn("%s: GPU throttled with reasons 0x%08x\n",
-					engine->name, throttle);
+				drm_warn(&engine->i915->drm,
+					 "%s: GPU throttled with reasons 0x%08x\n",
+					 engine->name, throttle);
 
 			err = -EINVAL;
 		}
-- 
2.34.1

