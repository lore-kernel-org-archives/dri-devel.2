Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A276C5AC67
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:33:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E811510E5B8;
	Tue, 11 Aug 2026 13:33:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jz1Y1K/L";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 943F710E40D;
 Tue, 11 Aug 2026 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786455195; x=1817991195;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=FY/aiOu8qgJzClGHkVvl6lVuPvKjtjAkAN1CIVdM2E8=;
 b=jz1Y1K/LJYUc1RhePJyaw7WOL5nLGFzJ+NWYaZOJFURXifa0Cf/ZldDy
 hF7EQWQgtNQEN1QgL71rNsKRI08LPGSM9xGdB9aErpZTMUdpnM1qCrmmJ
 T3BUPNQpiKm6/K59VRPy0bFLYSnXBV6KD+MvWr4leE3fUh0TeoaF+E5XL
 Mc9CssHD0Eyi9nvgZ041K4euH7eLq3ed5vrSmrr6R0vLD/y2G89ROC5do
 8nYKVXZHx2jT8oLupXXciXY5JFuvP8eEKUUZxo0Pdc5tB+tIyhxhMMLO9
 KP4NqG0McbWI+CwuvdydwOC2Fdf+X+JnUav6tABeIGatHWnNuveuTg6wS Q==;
X-CSE-ConnectionGUID: 5xGs36UhSXaq1crgIELVfQ==
X-CSE-MsgGUID: p0/8HkIDTOSiTUvPKmOsgg==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="85947163"
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="85947163"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:15 -0700
X-CSE-ConnectionGUID: 9wMqa8JjShOxQ9wGMNS0oA==
X-CSE-MsgGUID: aMz/MRXNSVWW4vYVjHT19w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,217,1779174000"; d="scan'208";a="263933155"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Aug 2026 06:33:15 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:14 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Tue, 11 Aug 2026 06:33:14 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.52) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Tue, 11 Aug 2026 06:33:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LKse3nOFdf2m8NhfVLdH69Qfby19/s5yhbyfi3QcP4wtyPDOZZnOI0A+c9yc0clLRv+LkUuB8lGALruREF/1dMUZU44iKFDGJxiDckeUKNJrENvu4Pjz0zkR/m4sn6Td+StCbmyCqZYK+szzz4MtZW6vNP25zJ6j6k7sbfwHyZSTI2KJ9PscTlt+mdoJXgs4DWQNkg+4HU7LLK1PHABwmFaQehLu3xsvQW5LaemexXOIfYmHLeRa77PmRYHGZXBjoXMYVPKoJGUsmk6KdqF4y6fwclUZwoQqL5K2iPP6jX2bZcdSyQ0UyUrY2LpTrcYhD7Z2e5WzGI/2f67dq5BdnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f466L4o03020VZEQqgYtVK/q6oT/NVLt19zflz3wrw=;
 b=RD36eeIqa0TFicWUfZ7GGQcB6m/msnAUfdTFv/mXHIp92HOr6EgmNBgOOCLuRhF15hIlNUT5bgGt1MHLRN+lHp08WBgAEA9lOWbDSzWF+0+qpP/vaQoR0TVoTLALKRJQokoytO6JexVAJi2L7bOEyYEjkmdj/ifqkadtPEX5n4CDhN/3eUEszyv4InulD+uz0rBlK58XNJ48WG/bFW1Eq4YN7fYZRhfJFKO7ltyikBfTqv6ls7OsXMpFKRYtm3NxnFlW4W8VjFBmKOABmFOpqeGiN/hAsXj2yumzD8IeiOwEdl/Zv0AAAQACmMJVAHfNZIp5HyR1YowO/QqJyShlTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by PH0PR11MB7447.namprd11.prod.outlook.com (2603:10b6:510:28b::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Tue, 11 Aug
 2026 13:33:10 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0315.011; Tue, 11 Aug 2026
 13:33:10 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [RFC PATCH 1/7] drm/i915/selftests: Use drm_* prints in mock selftests
Date: Tue, 11 Aug 2026 13:32:51 +0000
Message-ID: <20260811133257.1133097-2-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260811133257.1133097-1-krzysztof.karas@intel.com>
References: <20260811133257.1133097-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DB9PR05CA0015.eurprd05.prod.outlook.com
 (2603:10a6:10:1da::20) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|PH0PR11MB7447:EE_
X-MS-Office365-Filtering-Correlation-Id: 7268a6d0-6068-45a6-02d3-08def7ad157c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|23010399003|22082099003|18002099003|11063799006|56012099006|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: a1ApJV78AhTQ/wmrlXlfgjATowukujjEXBULN54VOssopw3ufkVz3UXz1LGhsOkgIUXKvACBj6UiHat+4u7QsG1yHgJgKjBnxUYqf+bxdnNstIi+q2zy4GbtySMqRUauECd1RGYi04JnNvP6xEGcjLqcdJhMYFmivNfqnCv2SRATrfNk/m/QUZnoehQXbNY7JNWUwiXQVd+mQ9ljiFFP97VeE2xyABpI1vHlDqeNTnabHJEWD8y5IA3pn2RtNyUy4oJ6NW6fVPkAqyhEZQqjCUyWIHAMQfDcZsvUrvWEOSKW+icCFvwJ+Iz2RNy6uzEQTcl34G1WztDvEpR99VOHJmT2wSGgHic7GoJcAJ7nTZ03LmDohewuy/dZq5QY9YUeToSom0VCvF5B8eV3cil0NmMBKk9Ordb8/H0+4RddVC8B650VJiGbsO4lPm/40dDsovJM1H3p9Lpp6J9slve8Rb/GS7fY+yFJcduYQVVT7VcEpqNa3bqQfgpylukChSXAA/yVY7DSXUrwfu6fho7jz+iroxd5fDSWl/tJ428m6fuZCuSjH/g3r48tpj1wqHB7Lfj07umg4NZ3vURNG1Tz3AlXTNMZ2uNep5utiNNDcNfDy7gEiEKmLL2RUsMZFsbjntP/eVvFFrYZXjtWg2QOIl4xUxIJsHIp2inxc+8F1HQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Fmumr7QbxFdQJx12qE8SgGm01jLxleQudSfc+1PMd2wHbVlQOND1tf0RCbBa?=
 =?us-ascii?Q?2oGQ6mDPAMuCZhAN3JsIo9QOEGDbqsM6OBlJaKNXmhOl0Bx4Elai+sRRoerm?=
 =?us-ascii?Q?34wmv5NpWuGZR5vBn4hOoHtloIUdmFDAPZGe3f6B3nZrPc2iTK5H5tCXvUOu?=
 =?us-ascii?Q?yzjJ+BoGQ8bA8XHI+k+qFQEMlj1+74WQ78B0k/pbRC3eKHqGcnzSmCc0Wnbd?=
 =?us-ascii?Q?rDfUU0VQCjWPUfLxXjr0+e1Ya+dOVzIgoEZTHRI3Z4Mtm8A57apcCpzTfcFX?=
 =?us-ascii?Q?m871dmYsMpsaMh/5YgF83uJxHHuWDwYEZ05BJt9L01H9p/aty/4uLadOMhfD?=
 =?us-ascii?Q?9PszoIKk5e/3VPt6ELYLiPrkD+op4izyGg6x8byqrAEkowzoiuDK+J1amrIE?=
 =?us-ascii?Q?lvVyDGxpFhGaNPxngtRZOt522lRA1fUU7BpdEEumNhGaNLltGkJdXFCEbMU2?=
 =?us-ascii?Q?S5GGjWOde7Tn1ePfdvGgMoRu0tiuyQ87+NLipAaYqT97bIbh1N9Flm/Mve9E?=
 =?us-ascii?Q?cCO/hVxScP+B+4teEHkXuAlIH9Rme4cr0q9tbDrvdBk31PYt0RcoEitYOLl2?=
 =?us-ascii?Q?4nZmJzuKpeZ5/3qXGWLmwUJVzReWZZi36K9ZZHAPDa5lZPu4wmHT470i+5Xr?=
 =?us-ascii?Q?5Jv+leoUex1K4eTDhKE+/5q6kILVWgFt4xsywyBDqCONNIfDT5g7eg8+AGhS?=
 =?us-ascii?Q?f5rQxnFsS+2eb4pPi66ncHE4eIHQJhKann2MDPIXQDM8vLiGZ+ZhEBuBUf15?=
 =?us-ascii?Q?OgpdLvzvB3tmn1aXOTtZTuks72ohfqM87nHrkAPqjWLL4aJxAxiCh2WS0Ku1?=
 =?us-ascii?Q?ddg4t5Nsx+k7W1CH/zyUp3wJaTKk7XOBGJmGaBmVs6Ym54x5e3K3kRyqm03b?=
 =?us-ascii?Q?zDZclFsvdVtMFdmk/IPkyEfmToiqM5YS+cm7IkAaaKxZAGHbz/yrAHiwzFb/?=
 =?us-ascii?Q?30VFmfnDpQD+aN/OYf/5B7amqnj3ihbuHFNqv8OOc1bujLSWApVYPyU+R18W?=
 =?us-ascii?Q?GW9ZKiph5sNLhk7sy0V5UcUdyua5nitDpxbXSDBM+10lox/R46/ieGDOUaQ9?=
 =?us-ascii?Q?tOi0ZGUyrxK7IzWXMxJlwtaan2e6E03UBBm2x8MZigKSzN49mR/NZzi3mGfu?=
 =?us-ascii?Q?bCFP+lAWfCTwUQEhs7+p5fGaq5jI12vEcIF1fGxSJnbBma8XQ2pi8/RwyIvo?=
 =?us-ascii?Q?ut9qioBd4yczZ4SX9ojGDyD4LUD/ad67l+w6PXrn8psapJbk/O0B7jUAIzL2?=
 =?us-ascii?Q?YstR2F20wpg2C3oiX6ir1PeDaNUvDsH2tVBrK34tyc5itUJA3k0kPk80GjfS?=
 =?us-ascii?Q?V/OaPZ+Mz6+6s915P3VEn9q/Mo5KanqBWXBlXAketcoTle9c/T28dMMnwLQ/?=
 =?us-ascii?Q?xt1d7kDxdzl83G1rDvE9XOGvM9FHeG918WrYDBEtW6MRPwlQkB9T9ldzPymD?=
 =?us-ascii?Q?0B/893NhcYNZhTHxOZvNvm5fSQzN6rJEsYdOpRBGF+/bQ4bak7Q8n9JxGOqa?=
 =?us-ascii?Q?euy5b24BerAZWjeAjFAmcyjd7f9iyKPrECMUcjL9rGU3ZatR4/T3aQ2ZNS4C?=
 =?us-ascii?Q?IrFRoJ3S0brJtZ+6ZOJRw6Cm1xomCPFzm+F8H3YcBzqLSkbAHL+9f6LwKsSU?=
 =?us-ascii?Q?8eaVCvfJJu5xQNRYAS7x95+U5GiZnYz9w6BBf5PyghqE0gMr4Dvh35/faGsR?=
 =?us-ascii?Q?Q/+yuQfSbqqgMjOzbsFrvIrQkAxYb2ugg1fGaei25QUF+Bpysg43M5usrUxv?=
 =?us-ascii?Q?ssR9NvVnGZrgLJuwO5eIarM3WdZjf+A=3D?=
X-Exchange-RoutingPolicyChecked: SjDH4iv53pRpHzpXUJv10MCxCfNMGmZJI11sZ3+c8UF+YBWBUF/m+wXjhj2yuPhM4u1JiNn9iJOAmT3J6dIdm9WLfl1O4rYgiYw5s6iscmWL1rLFIv/wFQfrNTDw8MWsyEheuNATsFpIs8J62RD7FSmnlMoFAjLo3cV+EgnLSMpuJK4Ej6Y6gPf2TQhcaABXo8vdQa94HK6qM2XwCjaUz4sC9GAcw2UxV1kq/JI1wJCyNRbNmIRrz+lr/kejWl/pMUHSDsrt2uwetWz9zQMOyCPYIC2PsRHvELyUEyLQ6jjM3F/c2tH+KIKKzCHf0w0WKCVi+Ge6F4gTo04JFMBYHA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7268a6d0-6068-45a6-02d3-08def7ad157c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2026 13:33:10.0695 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2nqaPZSUYnsvIS4oQTUmorGD4Yvxa8RxLZIP9834ucVRY+DXTekkXr/2vtdDb05jNC0y4PB8+BQ6Jk4e4pGhUyAOS1xczwB2pjv+luaUyJo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7447
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
 .../gpu/drm/i915/selftests/i915_sw_fence.c    | 124 +++++++----
 drivers/gpu/drm/i915/selftests/i915_syncmap.c | 205 +++++++++++-------
 drivers/gpu/drm/i915/selftests/scatterlist.c  |  75 +++++--
 3 files changed, 256 insertions(+), 148 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
index 6a305322e30d..ab753d4d3fd8 100644
--- a/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
+++ b/drivers/gpu/drm/i915/selftests/i915_sw_fence.c
@@ -26,7 +26,11 @@
 #include <linux/delay.h>
 #include <linux/prime_numbers.h>
 
+#include <drm/drm_print.h>
+
+#include "../i915_drv.h"
 #include "../i915_selftest.h"
+#include "mock_gem_device.h"
 
 static int
 fence_notify(struct i915_sw_fence *fence, enum i915_sw_fence_notify state)
@@ -95,6 +99,7 @@ static int test_self(void *arg)
 
 static int test_dag(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_sw_fence *A, *B, *C;
 	int ret = -EINVAL;
 
@@ -107,7 +112,7 @@ static int test_dag(void *arg)
 		return -ENOMEM;
 
 	if (i915_sw_fence_await_sw_fence_gfp(A, A, GFP_KERNEL) != -EINVAL) {
-		pr_err("recursive cycle not detected (AA)\n");
+		drm_err(&i915->drm, "recursive cycle not detected (AA)\n");
 		goto err_A;
 	}
 
@@ -119,7 +124,7 @@ static int test_dag(void *arg)
 
 	i915_sw_fence_await_sw_fence_gfp(A, B, GFP_KERNEL);
 	if (i915_sw_fence_await_sw_fence_gfp(B, A, GFP_KERNEL) != -EINVAL) {
-		pr_err("single depth cycle not detected (BAB)\n");
+		drm_err(&i915->drm, "single depth cycle not detected (BAB)\n");
 		goto err_B;
 	}
 
@@ -130,19 +135,19 @@ static int test_dag(void *arg)
 	}
 
 	if (i915_sw_fence_await_sw_fence_gfp(B, C, GFP_KERNEL) == -EINVAL) {
-		pr_err("invalid cycle detected\n");
+		drm_err(&i915->drm, "invalid cycle detected\n");
 		goto err_C;
 	}
 	if (i915_sw_fence_await_sw_fence_gfp(C, B, GFP_KERNEL) != -EINVAL) {
-		pr_err("single depth cycle not detected (CBC)\n");
+		drm_err(&i915->drm, "single depth cycle not detected (CBC)\n");
 		goto err_C;
 	}
 	if (i915_sw_fence_await_sw_fence_gfp(C, A, GFP_KERNEL) != -EINVAL) {
-		pr_err("cycle not detected (BA, CB, AC)\n");
+		drm_err(&i915->drm, "cycle not detected (BA, CB, AC)\n");
 		goto err_C;
 	}
 	if (i915_sw_fence_await_sw_fence_gfp(A, C, GFP_KERNEL) == -EINVAL) {
-		pr_err("invalid cycle detected\n");
+		drm_err(&i915->drm, "invalid cycle detected\n");
 		goto err_C;
 	}
 
@@ -152,15 +157,15 @@ static int test_dag(void *arg)
 
 	ret = 0;
 	if (!i915_sw_fence_done(C)) {
-		pr_err("fence C not done\n");
+		drm_err(&i915->drm, "fence C not done\n");
 		ret = -EINVAL;
 	}
 	if (!i915_sw_fence_done(B)) {
-		pr_err("fence B not done\n");
+		drm_err(&i915->drm, "fence B not done\n");
 		ret = -EINVAL;
 	}
 	if (!i915_sw_fence_done(A)) {
-		pr_err("fence A not done\n");
+		drm_err(&i915->drm, "fence A not done\n");
 		ret = -EINVAL;
 	}
 err_C:
@@ -174,6 +179,7 @@ static int test_dag(void *arg)
 
 static int test_AB(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_sw_fence *A, *B;
 	int ret;
 
@@ -191,7 +197,8 @@ static int test_AB(void *arg)
 	if (ret < 0)
 		goto err_B;
 	if (ret == 0) {
-		pr_err("Incorrectly reported fence A was complete before await\n");
+		drm_err(&i915->drm,
+			"Incorrectly reported fence A was complete before await\n");
 		ret = -EINVAL;
 		goto err_B;
 	}
@@ -203,12 +210,12 @@ static int test_AB(void *arg)
 
 	i915_sw_fence_commit(B);
 	if (!i915_sw_fence_done(B)) {
-		pr_err("Fence B is not done\n");
+		drm_err(&i915->drm, "Fence B is not done\n");
 		goto err_B;
 	}
 
 	if (!i915_sw_fence_done(A)) {
-		pr_err("Fence A is not done\n");
+		drm_err(&i915->drm, "Fence A is not done\n");
 		goto err_B;
 	}
 
@@ -222,6 +229,7 @@ static int test_AB(void *arg)
 
 static int test_ABC(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_sw_fence *A, *B, *C;
 	int ret;
 
@@ -246,7 +254,8 @@ static int test_ABC(void *arg)
 	if (ret < 0)
 		goto err_C;
 	if (ret == 0) {
-		pr_err("Incorrectly reported fence B was complete before await\n");
+		drm_err(&i915->drm,
+			"Incorrectly reported fence B was complete before await\n");
 		goto err_C;
 	}
 
@@ -254,25 +263,27 @@ static int test_ABC(void *arg)
 	if (ret < 0)
 		goto err_C;
 	if (ret == 0) {
-		pr_err("Incorrectly reported fence C was complete before await\n");
+		drm_err(&i915->drm,
+			"Incorrectly reported fence C was complete before await\n");
 		goto err_C;
 	}
 
 	ret = -EINVAL;
 	i915_sw_fence_commit(A);
 	if (i915_sw_fence_done(A)) {
-		pr_err("Fence A completed early\n");
+		drm_err(&i915->drm, "Fence A completed early\n");
 		goto err_C;
 	}
 
 	i915_sw_fence_commit(B);
 	if (i915_sw_fence_done(B)) {
-		pr_err("Fence B completed early\n");
+		drm_err(&i915->drm, "Fence B completed early\n");
 		goto err_C;
 	}
 
 	if (i915_sw_fence_done(A)) {
-		pr_err("Fence A completed early (after signaling B)\n");
+		drm_err(&i915->drm,
+			"Fence A completed early (after signaling B)\n");
 		goto err_C;
 	}
 
@@ -280,15 +291,15 @@ static int test_ABC(void *arg)
 
 	ret = 0;
 	if (!i915_sw_fence_done(C)) {
-		pr_err("Fence C not done\n");
+		drm_err(&i915->drm, "Fence C not done\n");
 		ret = -EINVAL;
 	}
 	if (!i915_sw_fence_done(B)) {
-		pr_err("Fence B not done\n");
+		drm_err(&i915->drm, "Fence B not done\n");
 		ret = -EINVAL;
 	}
 	if (!i915_sw_fence_done(A)) {
-		pr_err("Fence A not done\n");
+		drm_err(&i915->drm, "Fence A not done\n");
 		ret = -EINVAL;
 	}
 err_C:
@@ -302,6 +313,7 @@ static int test_ABC(void *arg)
 
 static int test_AB_C(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_sw_fence *A, *B, *C;
 	int ret = -EINVAL;
 
@@ -343,28 +355,28 @@ static int test_AB_C(void *arg)
 
 	ret = 0;
 	if (i915_sw_fence_done(A)) {
-		pr_err("Fence A completed early\n");
+		drm_err(&i915->drm, "Fence A completed early\n");
 		ret = -EINVAL;
 	}
 
 	if (i915_sw_fence_done(B)) {
-		pr_err("Fence B completed early\n");
+		drm_err(&i915->drm, "Fence B completed early\n");
 		ret = -EINVAL;
 	}
 
 	i915_sw_fence_commit(C);
 	if (!i915_sw_fence_done(C)) {
-		pr_err("Fence C not done\n");
+		drm_err(&i915->drm, "Fence C not done\n");
 		ret = -EINVAL;
 	}
 
 	if (!i915_sw_fence_done(B)) {
-		pr_err("Fence B not done\n");
+		drm_err(&i915->drm, "Fence B not done\n");
 		ret = -EINVAL;
 	}
 
 	if (!i915_sw_fence_done(A)) {
-		pr_err("Fence A not done\n");
+		drm_err(&i915->drm, "Fence A not done\n");
 		ret = -EINVAL;
 	}
 
@@ -379,6 +391,7 @@ static int test_AB_C(void *arg)
 
 static int test_C_AB(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_sw_fence *A, *B, *C;
 	int ret;
 
@@ -424,17 +437,17 @@ static int test_C_AB(void *arg)
 	i915_sw_fence_commit(B);
 
 	if (!i915_sw_fence_done(A)) {
-		pr_err("Fence A not done\n");
+		drm_err(&i915->drm, "Fence A not done\n");
 		ret = -EINVAL;
 	}
 
 	if (!i915_sw_fence_done(B)) {
-		pr_err("Fence B not done\n");
+		drm_err(&i915->drm, "Fence B not done\n");
 		ret = -EINVAL;
 	}
 
 	if (!i915_sw_fence_done(C)) {
-		pr_err("Fence C not done\n");
+		drm_err(&i915->drm, "Fence C not done\n");
 		ret = -EINVAL;
 	}
 
@@ -449,6 +462,7 @@ static int test_C_AB(void *arg)
 
 static int test_chain(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	int nfences = 4096;
 	struct i915_sw_fence **fences;
 	int ret, i;
@@ -483,14 +497,14 @@ static int test_chain(void *arg)
 	for (i = nfences; --i; ) {
 		if (i915_sw_fence_done(fences[i])) {
 			if (ret == 0)
-				pr_err("Fence[%d] completed early\n", i);
+				drm_err(&i915->drm, "Fence[%d] completed early\n", i);
 			ret = -EINVAL;
 		}
 	}
 	i915_sw_fence_commit(fences[0]);
 	for (i = 0; ret == 0 && i < nfences; i++) {
 		if (!i915_sw_fence_done(fences[i])) {
-			pr_err("Fence[%d] is not done\n", i);
+			drm_err(&i915->drm, "Fence[%d] is not done\n", i);
 			ret = -EINVAL;
 		}
 	}
@@ -522,6 +536,7 @@ static void task_ipc(struct work_struct *work)
 
 static int test_ipc(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct task_ipc ipc;
 	struct workqueue_struct *wq;
 	int ret = 0;
@@ -553,7 +568,8 @@ static int test_ipc(void *arg)
 
 	usleep_range(1000, 2000);
 	if (READ_ONCE(ipc.value)) {
-		pr_err("worker updated value before i915_sw_fence was signaled\n");
+		drm_err(&i915->drm,
+			"worker updated value before i915_sw_fence was signaled\n");
 		ret = -EINVAL;
 	}
 
@@ -561,7 +577,8 @@ static int test_ipc(void *arg)
 	i915_sw_fence_wait(ipc.out);
 
 	if (!READ_ONCE(ipc.value)) {
-		pr_err("worker signaled i915_sw_fence before value was posted\n");
+		drm_err(&i915->drm,
+			"worker signaled i915_sw_fence before value was posted\n");
 		ret = -EINVAL;
 	}
 
@@ -578,13 +595,15 @@ static int test_ipc(void *arg)
 
 static int test_timer(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	unsigned long target, delay;
 	struct timed_fence tf;
 
 	preempt_disable();
 	timed_fence_init(&tf, target = jiffies);
 	if (!i915_sw_fence_done(&tf.fence)) {
-		pr_err("Fence with immediate expiration not signaled\n");
+		drm_err(&i915->drm,
+			"Fence with immediate expiration not signaled\n");
 		goto err;
 	}
 	preempt_enable();
@@ -594,7 +613,9 @@ static int test_timer(void *arg)
 		preempt_disable();
 		timed_fence_init(&tf, target = jiffies + delay);
 		if (i915_sw_fence_done(&tf.fence)) {
-			pr_err("Fence with future expiration (%lu jiffies) already signaled\n", delay);
+			drm_err(&i915->drm,
+				"Fence with future expiration (%lu jiffies) already signaled\n",
+				delay);
 			goto err;
 		}
 		preempt_enable();
@@ -603,12 +624,13 @@ static int test_timer(void *arg)
 
 		preempt_disable();
 		if (!i915_sw_fence_done(&tf.fence)) {
-			pr_err("Fence not signaled after wait\n");
+			drm_err(&i915->drm, "Fence not signaled after wait\n");
 			goto err;
 		}
 		if (time_before(jiffies, target)) {
-			pr_err("Fence signaled too early, target=%lu, now=%lu\n",
-			       target, jiffies);
+			drm_err(&i915->drm,
+				"Fence signaled too early, target=%lu, now=%lu\n",
+				target, jiffies);
 			goto err;
 		}
 		preempt_enable();
@@ -668,6 +690,7 @@ wrap_dma_fence(struct dma_fence *dma, unsigned long delay)
 
 static int test_dma_fence(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_sw_fence *timeout = NULL, *not = NULL;
 	unsigned long delay = i915_selftest.timeout_jiffies;
 	unsigned long end, sleep;
@@ -692,7 +715,7 @@ static int test_dma_fence(void *arg)
 
 	err = -EINVAL;
 	if (i915_sw_fence_done(timeout) || i915_sw_fence_done(not)) {
-		pr_err("Fences immediately signaled\n");
+		drm_err(&i915->drm, "Fences immediately signaled\n");
 		goto err;
 	}
 
@@ -702,25 +725,26 @@ static int test_dma_fence(void *arg)
 	sleep = jiffies_to_usecs(delay) / 3;
 	usleep_range(sleep, 2 * sleep);
 	if (time_after(jiffies, end)) {
-		pr_debug("Slept too long, delay=%lu, (target=%lu, now=%lu) skipping\n",
-			 delay, end, jiffies);
+		drm_dbg(&i915->drm,
+			"Slept too long, delay=%lu, (target=%lu, now=%lu) skipping\n",
+			delay, end, jiffies);
 		goto skip;
 	}
 
 	if (i915_sw_fence_done(timeout) || i915_sw_fence_done(not)) {
-		pr_err("Fences signaled too early\n");
+		drm_err(&i915->drm, "Fences signaled too early\n");
 		goto err;
 	}
 
 	if (!wait_event_timeout(timeout->wait,
 				i915_sw_fence_done(timeout),
 				2 * (end - jiffies) + 1)) {
-		pr_err("Timeout fence unsignaled!\n");
+		drm_err(&i915->drm, "Timeout fence unsignaled!\n");
 		goto err;
 	}
 
 	if (i915_sw_fence_done(not)) {
-		pr_err("No timeout fence signaled!\n");
+		drm_err(&i915->drm, "No timeout fence signaled!\n");
 		goto err;
 	}
 
@@ -728,7 +752,7 @@ static int test_dma_fence(void *arg)
 	dma_fence_signal(dma);
 
 	if (!i915_sw_fence_done(timeout) || !i915_sw_fence_done(not)) {
-		pr_err("Fences unsignaled\n");
+		drm_err(&i915->drm, "Fences unsignaled\n");
 		goto err;
 	}
 
@@ -750,6 +774,9 @@ static int test_dma_fence(void *arg)
 
 int i915_sw_fence_mock_selftests(void)
 {
+	struct drm_i915_private *i915;
+	int err;
+
 	static const struct i915_subtest tests[] = {
 		SUBTEST(test_self),
 		SUBTEST(test_dag),
@@ -763,5 +790,12 @@ int i915_sw_fence_mock_selftests(void)
 		SUBTEST(test_dma_fence),
 	};
 
-	return i915_subtests(tests, NULL);
+	i915 = mock_gem_device();
+	if (IS_ERR(i915))
+		return PTR_ERR(i915);
+
+	err = i915_subtests(tests, i915);
+	mock_destroy_device(i915);
+
+	return err;
 }
diff --git a/drivers/gpu/drm/i915/selftests/i915_syncmap.c b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
index 88fa845e9f4a..30637c32c319 100644
--- a/drivers/gpu/drm/i915/selftests/i915_syncmap.c
+++ b/drivers/gpu/drm/i915/selftests/i915_syncmap.c
@@ -23,7 +23,11 @@
  */
 
 #include "../i915_selftest.h"
+#include "../i915_drv.h"
 #include "i915_random.h"
+#include "mock_gem_device.h"
+
+#include <drm/drm_print.h>
 
 static char *
 __sync_print(struct i915_syncmap *p,
@@ -98,30 +102,32 @@ i915_syncmap_print_to_buf(struct i915_syncmap *p, char *buf, unsigned long sz)
 	return true;
 }
 
-static int check_syncmap_free(struct i915_syncmap **sync)
+static int check_syncmap_free(struct i915_syncmap **sync,
+			      struct drm_i915_private *i915)
 {
 	i915_syncmap_free(sync);
 	if (*sync) {
-		pr_err("sync not cleared after free\n");
+		drm_err(&i915->drm, "sync not cleared after free\n");
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int dump_syncmap(struct i915_syncmap *sync, int err)
+static int dump_syncmap(struct i915_syncmap *sync, int err,
+			struct drm_i915_private *i915)
 {
 	char *buf;
 
 	if (!err)
-		return check_syncmap_free(&sync);
+		return check_syncmap_free(&sync, i915);
 
 	buf = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!buf)
 		goto skip;
 
 	if (i915_syncmap_print_to_buf(sync, buf, PAGE_SIZE))
-		pr_err("%s", buf);
+		drm_err(&i915->drm, "%s", buf);
 
 	kfree(buf);
 
@@ -132,6 +138,7 @@ static int dump_syncmap(struct i915_syncmap *sync, int err)
 
 static int igt_syncmap_init(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_syncmap *sync = (void *)~0ul;
 
 	/*
@@ -140,27 +147,29 @@ static int igt_syncmap_init(void *arg)
 	 */
 
 	i915_syncmap_init(&sync);
-	return check_syncmap_free(&sync);
+	return check_syncmap_free(&sync, i915);
 }
 
-static int check_seqno(struct i915_syncmap *leaf, unsigned int idx, u32 seqno)
+static int check_seqno(struct i915_syncmap *leaf, unsigned int idx, u32 seqno,
+		       struct drm_i915_private *i915)
 {
 	if (leaf->height) {
-		pr_err("%s: not a leaf, height is %d\n",
-		       __func__, leaf->height);
+		drm_err(&i915->drm, "%s: not a leaf, height is %d\n",
+			__func__, leaf->height);
 		return -EINVAL;
 	}
 
 	if (__sync_seqno(leaf)[idx] != seqno) {
-		pr_err("%s: seqno[%d], found %x, expected %x\n",
-		       __func__, idx, __sync_seqno(leaf)[idx], seqno);
+		drm_err(&i915->drm, "%s: seqno[%d], found %x, expected %x\n",
+			__func__, idx, __sync_seqno(leaf)[idx], seqno);
 		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static int check_one(struct i915_syncmap **sync, u64 context, u32 seqno)
+static int check_one(struct i915_syncmap **sync, u64 context, u32 seqno,
+		     struct drm_i915_private *i915)
 {
 	int err;
 
@@ -169,30 +178,33 @@ static int check_one(struct i915_syncmap **sync, u64 context, u32 seqno)
 		return err;
 
 	if ((*sync)->height) {
-		pr_err("Inserting first context=%llx did not return leaf (height=%d, prefix=%llx\n",
-		       context, (*sync)->height, (*sync)->prefix);
+		drm_err(&i915->drm,
+			"Inserting first context=%llx did not return leaf (height=%d, prefix=%llx\n",
+			context, (*sync)->height, (*sync)->prefix);
 		return -EINVAL;
 	}
 
 	if ((*sync)->parent) {
-		pr_err("Inserting first context=%llx created branches!\n",
-		       context);
+		drm_err(&i915->drm,
+			"Inserting first context=%llx created branches!\n", context);
 		return -EINVAL;
 	}
 
 	if (hweight32((*sync)->bitmap) != 1) {
-		pr_err("First bitmap does not contain a single entry, found %x (count=%d)!\n",
-		       (*sync)->bitmap, hweight32((*sync)->bitmap));
+		drm_err(&i915->drm,
+			"First bitmap does not contain a single entry, found %x (count=%d)!\n",
+			(*sync)->bitmap, hweight32((*sync)->bitmap));
 		return -EINVAL;
 	}
 
-	err = check_seqno((*sync), ilog2((*sync)->bitmap), seqno);
+	err = check_seqno((*sync), ilog2((*sync)->bitmap), seqno, i915);
 	if (err)
 		return err;
 
 	if (!i915_syncmap_is_later(sync, context, seqno)) {
-		pr_err("Lookup of first context=%llx/seqno=%x failed!\n",
-		       context, seqno);
+		drm_err(&i915->drm,
+			"Lookup of first context=%llx/seqno=%x failed!\n",
+			context, seqno);
 		return -EINVAL;
 	}
 
@@ -201,6 +213,7 @@ static int check_one(struct i915_syncmap **sync, u64 context, u32 seqno)
 
 static int igt_syncmap_one(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	I915_RND_STATE(prng);
 	IGT_TIMEOUT(end_time);
 	struct i915_syncmap *sync;
@@ -217,25 +230,26 @@ static int igt_syncmap_one(void *arg)
 		u64 context = i915_prandom_u64_state(&prng);
 		unsigned long loop;
 
-		err = check_syncmap_free(&sync);
+		err = check_syncmap_free(&sync, i915);
 		if (err)
 			goto out;
 
 		for (loop = 0; loop <= max; loop++) {
 			err = check_one(&sync, context,
-					prandom_u32_state(&prng));
+					prandom_u32_state(&prng), i915);
 			if (err)
 				goto out;
 		}
 		max++;
 	} while (!__igt_timeout(end_time, NULL));
-	pr_debug("%s: Completed %lu single insertions\n",
-		 __func__, max * (max - 1) / 2);
+	drm_dbg(&i915->drm, "%s: Completed %lu single insertions\n",
+		__func__, max * (max - 1) / 2);
 out:
-	return dump_syncmap(sync, err);
+	return dump_syncmap(sync, err, i915);
 }
 
-static int check_leaf(struct i915_syncmap **sync, u64 context, u32 seqno)
+static int check_leaf(struct i915_syncmap **sync, u64 context, u32 seqno,
+		      struct drm_i915_private *i915)
 {
 	int err;
 
@@ -244,24 +258,27 @@ static int check_leaf(struct i915_syncmap **sync, u64 context, u32 seqno)
 		return err;
 
 	if ((*sync)->height) {
-		pr_err("Inserting context=%llx did not return leaf (height=%d, prefix=%llx\n",
-		       context, (*sync)->height, (*sync)->prefix);
+		drm_err(&i915->drm,
+			"Inserting context=%llx did not return leaf (height=%d, prefix=%llx\n",
+			context, (*sync)->height, (*sync)->prefix);
 		return -EINVAL;
 	}
 
 	if (hweight32((*sync)->bitmap) != 1) {
-		pr_err("First entry into leaf (context=%llx) does not contain a single entry, found %x (count=%d)!\n",
-		       context, (*sync)->bitmap, hweight32((*sync)->bitmap));
+		drm_err(&i915->drm,
+			"First entry into leaf (context=%llx) does not contain a single entry, found %x (count=%d)!\n",
+			context, (*sync)->bitmap, hweight32((*sync)->bitmap));
 		return -EINVAL;
 	}
 
-	err = check_seqno((*sync), ilog2((*sync)->bitmap), seqno);
+	err = check_seqno((*sync), ilog2((*sync)->bitmap), seqno, i915);
 	if (err)
 		return err;
 
 	if (!i915_syncmap_is_later(sync, context, seqno)) {
-		pr_err("Lookup of first entry context=%llx/seqno=%x failed!\n",
-		       context, seqno);
+		drm_err(&i915->drm,
+			"Lookup of first entry context=%llx/seqno=%x failed!\n",
+			context, seqno);
 		return -EINVAL;
 	}
 
@@ -270,6 +287,7 @@ static int check_leaf(struct i915_syncmap **sync, u64 context, u32 seqno)
 
 static int igt_syncmap_join_above(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_syncmap *sync;
 	unsigned int pass, order;
 	int err;
@@ -297,7 +315,7 @@ static int igt_syncmap_join_above(void *arg)
 			u64 context = BIT_ULL(order);
 			struct i915_syncmap *join;
 
-			err = check_leaf(&sync, context, 0);
+			err = check_leaf(&sync, context, 0, i915);
 			if (err)
 				goto out;
 
@@ -306,31 +324,33 @@ static int igt_syncmap_join_above(void *arg)
 				continue;
 
 			if (!join->height) {
-				pr_err("Parent with no height!\n");
+				drm_err(&i915->drm, "Parent with no height!\n");
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (hweight32(join->bitmap) != 2) {
-				pr_err("Join does not have 2 children: %x (%d)\n",
-				       join->bitmap, hweight32(join->bitmap));
+				drm_err(&i915->drm,
+					"Join does not have 2 children: %x (%d)\n",
+					join->bitmap, hweight32(join->bitmap));
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (__sync_child(join)[__sync_branch_idx(join, context)] != sync) {
-				pr_err("Leaf misplaced in parent!\n");
+				drm_err(&i915->drm, "Leaf misplaced in parent!\n");
 				err = -EINVAL;
 				goto out;
 			}
 		}
 	}
 out:
-	return dump_syncmap(sync, err);
+	return dump_syncmap(sync, err, i915);
 }
 
 static int igt_syncmap_join_below(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_syncmap *sync;
 	unsigned int step, order, idx;
 	int err = -ENODEV;
@@ -350,8 +370,9 @@ static int igt_syncmap_join_below(void *arg)
 				goto out;
 
 			if (sync->height) {
-				pr_err("Inserting context=%llx (order=%d, step=%d) did not return leaf (height=%d, prefix=%llx\n",
-				       context, order, step, sync->height, sync->prefix);
+				drm_err(&i915->drm,
+					"Inserting context=%llx (order=%d, step=%d) did not return leaf (height=%d, prefix=%llx\n",
+					context, order, step, sync->height, sync->prefix);
 				err = -EINVAL;
 				goto out;
 			}
@@ -363,16 +384,18 @@ static int igt_syncmap_join_below(void *arg)
 			u64 context = step * BIT_ULL(order);
 
 			if (!i915_syncmap_is_later(&sync, context, 0)) {
-				pr_err("1: context %llx (order=%d, step=%d) not found\n",
-				       context, order, step);
+				drm_err(&i915->drm,
+					"1: context %llx (order=%d, step=%d) not found\n",
+					context, order, step);
 				err = -EINVAL;
 				goto out;
 			}
 
 			for (idx = 1; idx < KSYNCMAP; idx++) {
 				if (i915_syncmap_is_later(&sync, context + idx, 0)) {
-					pr_err("1: context %llx (order=%d, step=%d) should not exist\n",
-					       context + idx, order, step);
+					drm_err(&i915->drm,
+						"1: context %llx (order=%d, step=%d) should not exist\n",
+						context + idx, order, step);
 					err = -EINVAL;
 					goto out;
 				}
@@ -385,8 +408,9 @@ static int igt_syncmap_join_below(void *arg)
 			u64 context = step * BIT_ULL(order);
 
 			if (!i915_syncmap_is_later(&sync, context, 0)) {
-				pr_err("2: context %llx (order=%d, step=%d) not found\n",
-				       context, order, step);
+				drm_err(&i915->drm,
+					"2: context %llx (order=%d, step=%d) not found\n",
+					context, order, step);
 				err = -EINVAL;
 				goto out;
 			}
@@ -394,11 +418,12 @@ static int igt_syncmap_join_below(void *arg)
 	}
 
 out:
-	return dump_syncmap(sync, err);
+	return dump_syncmap(sync, err, i915);
 }
 
 static int igt_syncmap_neighbours(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	I915_RND_STATE(prng);
 	IGT_TIMEOUT(end_time);
 	struct i915_syncmap *sync;
@@ -423,28 +448,31 @@ static int igt_syncmap_neighbours(void *arg)
 				goto out;
 
 			if (sync->height) {
-				pr_err("Inserting context=%llx did not return leaf (height=%d, prefix=%llx\n",
-				       context, sync->height, sync->prefix);
+				drm_err(&i915->drm,
+					"Inserting context=%llx did not return leaf (height=%d, prefix=%llx\n",
+					context, sync->height, sync->prefix);
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (sync->bitmap != BIT(idx + 1) - 1) {
-				pr_err("Inserting neighbouring context=0x%llx+%d, did not fit into the same leaf bitmap=%x (%d), expected %lx (%d)\n",
-				       context, idx,
-				       sync->bitmap, hweight32(sync->bitmap),
-				       BIT(idx + 1) - 1, idx + 1);
+				drm_err(&i915->drm,
+					"Inserting neighbouring context=0x%llx+%d, did not fit into the same leaf bitmap=%x (%d), expected %lx (%d)\n",
+					context, idx,
+					sync->bitmap, hweight32(sync->bitmap),
+					BIT(idx + 1) - 1, idx + 1);
 				err = -EINVAL;
 				goto out;
 			}
 		}
 	} while (!__igt_timeout(end_time, NULL));
 out:
-	return dump_syncmap(sync, err);
+	return dump_syncmap(sync, err, i915);
 }
 
 static int igt_syncmap_compact(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	struct i915_syncmap *sync;
 	unsigned int idx, order;
 	int err = -ENODEV;
@@ -460,7 +488,7 @@ static int igt_syncmap_compact(void *arg)
 	 * leaf holding the single id.
 	 */
 	for (order = SHIFT; order < 64; order += SHIFT) {
-		err = check_syncmap_free(&sync);
+		err = check_syncmap_free(&sync, i915);
 		if (err)
 			goto out;
 
@@ -473,9 +501,10 @@ static int igt_syncmap_compact(void *arg)
 				goto out;
 
 			if (sync->height) {
-				pr_err("Inserting context=%llx (order=%d, idx=%d) did not return leaf (height=%d, prefix=%llx\n",
-				       context, order, idx,
-				       sync->height, sync->prefix);
+				drm_err(&i915->drm,
+					"Inserting context=%llx (order=%d, idx=%d) did not return leaf (height=%d, prefix=%llx\n",
+					context, order, idx,
+					sync->height, sync->prefix);
 				err = -EINVAL;
 				goto out;
 			}
@@ -483,22 +512,25 @@ static int igt_syncmap_compact(void *arg)
 
 		sync = sync->parent;
 		if (sync->parent) {
-			pr_err("Parent (join) of last leaf was not the sync!\n");
+			drm_err(&i915->drm,
+				"Parent (join) of last leaf was not the sync!\n");
 			err = -EINVAL;
 			goto out;
 		}
 
 		if (sync->height != order) {
-			pr_err("Join does not have the expected height, found %d, expected %d\n",
-			       sync->height, order);
+			drm_err(&i915->drm,
+				"Join does not have the expected height, found %d, expected %d\n",
+				sync->height, order);
 			err = -EINVAL;
 			goto out;
 		}
 
 		if (sync->bitmap != BIT(KSYNCMAP) - 1) {
-			pr_err("Join is not full!, found %x (%d) expected %lx (%d)\n",
-			       sync->bitmap, hweight32(sync->bitmap),
-			       BIT(KSYNCMAP) - 1, KSYNCMAP);
+			drm_err(&i915->drm,
+				"Join is not full!, found %x (%d) expected %lx (%d)\n",
+				sync->bitmap, hweight32(sync->bitmap),
+				BIT(KSYNCMAP) - 1, KSYNCMAP);
 			err = -EINVAL;
 			goto out;
 		}
@@ -508,39 +540,42 @@ static int igt_syncmap_compact(void *arg)
 			struct i915_syncmap *leaf = __sync_child(sync)[idx];
 
 			if (leaf->height) {
-				pr_err("Child %d is a not leaf!\n", idx);
+				drm_err(&i915->drm, "Child %d is a not leaf!\n", idx);
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (leaf->parent != sync) {
-				pr_err("Child %d is not attached to us!\n",
-				       idx);
+				drm_err(&i915->drm,
+					"Child %d is not attached to us!\n", idx);
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (!is_power_of_2(leaf->bitmap)) {
-				pr_err("Child %d holds more than one id, found %x (%d)\n",
-				       idx, leaf->bitmap, hweight32(leaf->bitmap));
+				drm_err(&i915->drm,
+					"Child %d holds more than one id, found %x (%d)\n",
+					idx, leaf->bitmap, hweight32(leaf->bitmap));
 				err = -EINVAL;
 				goto out;
 			}
 
 			if (leaf->bitmap != BIT(idx)) {
-				pr_err("Child %d has wrong seqno idx, found %d, expected %d\n",
-				       idx, ilog2(leaf->bitmap), idx);
+				drm_err(&i915->drm,
+					"Child %d has wrong seqno idx, found %d, expected %d\n",
+					idx, ilog2(leaf->bitmap), idx);
 				err = -EINVAL;
 				goto out;
 			}
 		}
 	}
 out:
-	return dump_syncmap(sync, err);
+	return dump_syncmap(sync, err, i915);
 }
 
 static int igt_syncmap_random(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	I915_RND_STATE(prng);
 	IGT_TIMEOUT(end_time);
 	struct i915_syncmap *sync;
@@ -582,8 +617,9 @@ static int igt_syncmap_random(void *arg)
 			u64 context = i915_prandom_u64_state(&ctx);
 
 			if (i915_syncmap_is_later(&sync, context, seqno) != expect) {
-				pr_err("context=%llu, last=%u this=%u did not match expectation (%d)\n",
-				       context, last_seqno, seqno, expect);
+				drm_err(&i915->drm,
+					"context=%llu, last=%u this=%u did not match expectation (%d)\n",
+					context, last_seqno, seqno, expect);
 				err = -EINVAL;
 				goto out;
 			}
@@ -595,13 +631,17 @@ static int igt_syncmap_random(void *arg)
 
 		phase++;
 	} while (!__igt_timeout(end_time, NULL));
-	pr_debug("Completed %lu passes, each of %lu contexts\n", phase, count);
+	drm_dbg(&i915->drm, "Completed %lu passes, each of %lu contexts\n",
+		phase, count);
 out:
-	return dump_syncmap(sync, err);
+	return dump_syncmap(sync, err, i915);
 }
 
 int i915_syncmap_mock_selftests(void)
 {
+	struct drm_i915_private *i915;
+	int err;
+
 	static const struct i915_subtest tests[] = {
 		SUBTEST(igt_syncmap_init),
 		SUBTEST(igt_syncmap_one),
@@ -612,5 +652,12 @@ int i915_syncmap_mock_selftests(void)
 		SUBTEST(igt_syncmap_random),
 	};
 
-	return i915_subtests(tests, NULL);
+	i915 = mock_gem_device();
+	if (IS_ERR(i915))
+		return PTR_ERR(i915);
+
+	err = i915_subtests(tests, i915);
+	mock_destroy_device(i915);
+
+	return err;
 }
diff --git a/drivers/gpu/drm/i915/selftests/scatterlist.c b/drivers/gpu/drm/i915/selftests/scatterlist.c
index 7e59591bbed6..3228bdcea1f2 100644
--- a/drivers/gpu/drm/i915/selftests/scatterlist.c
+++ b/drivers/gpu/drm/i915/selftests/scatterlist.c
@@ -24,8 +24,12 @@
 #include <linux/prime_numbers.h>
 #include <linux/prandom.h>
 
+#include <drm/drm_print.h>
+
+#include "i915_drv.h"
 #include "i915_selftest.h"
 #include "i915_utils.h"
+#include "mock_gem_device.h"
 
 #define PFN_BIAS (1 << 10)
 
@@ -39,6 +43,7 @@ typedef unsigned int (*npages_fn_t)(unsigned long n,
 				    struct rnd_state *rnd);
 
 static noinline int expect_pfn_sg(struct pfn_table *pt,
+				  struct drm_i915_private *i915,
 				  npages_fn_t npages_fn,
 				  struct rnd_state *rnd,
 				  const char *who,
@@ -53,14 +58,16 @@ static noinline int expect_pfn_sg(struct pfn_table *pt,
 		unsigned int npages = npages_fn(n, pt->st.nents, rnd);
 
 		if (page_to_pfn(page) != pfn) {
-			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg)\n",
-			       __func__, who, pfn, page_to_pfn(page));
+			drm_err(&i915->drm,
+				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg)\n",
+				__func__, who, pfn, page_to_pfn(page));
 			return -EINVAL;
 		}
 
 		if (sg->length != npages * PAGE_SIZE) {
-			pr_err("%s: %s copied wrong sg length, expected size %lu, found %u (using for_each_sg)\n",
-			       __func__, who, npages * PAGE_SIZE, sg->length);
+			drm_err(&i915->drm,
+				"%s: %s copied wrong sg length, expected size %lu, found %u (using for_each_sg)\n",
+				__func__, who, npages * PAGE_SIZE, sg->length);
 			return -EINVAL;
 		}
 
@@ -70,8 +77,9 @@ static noinline int expect_pfn_sg(struct pfn_table *pt,
 		pfn += npages;
 	}
 	if (pfn != pt->end) {
-		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
-		       __func__, who, pt->end, pfn);
+		drm_err(&i915->drm,
+			"%s: %s finished on wrong pfn, expected %lu, found %lu\n",
+			__func__, who, pt->end, pfn);
 		return -EINVAL;
 	}
 
@@ -79,6 +87,7 @@ static noinline int expect_pfn_sg(struct pfn_table *pt,
 }
 
 static noinline int expect_pfn_sg_page_iter(struct pfn_table *pt,
+					    struct drm_i915_private *i915,
 					    const char *who,
 					    unsigned long timeout)
 {
@@ -90,8 +99,9 @@ static noinline int expect_pfn_sg_page_iter(struct pfn_table *pt,
 		struct page *page = sg_page_iter_page(&sgiter);
 
 		if (page != pfn_to_page(pfn)) {
-			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg_page)\n",
-			       __func__, who, pfn, page_to_pfn(page));
+			drm_err(&i915->drm,
+				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sg_page)\n",
+				__func__, who, pfn, page_to_pfn(page));
 			return -EINVAL;
 		}
 
@@ -101,8 +111,9 @@ static noinline int expect_pfn_sg_page_iter(struct pfn_table *pt,
 		pfn++;
 	}
 	if (pfn != pt->end) {
-		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
-		       __func__, who, pt->end, pfn);
+		drm_err(&i915->drm,
+			"%s: %s finished on wrong pfn, expected %lu, found %lu\n",
+			__func__, who, pt->end, pfn);
 		return -EINVAL;
 	}
 
@@ -110,6 +121,7 @@ static noinline int expect_pfn_sg_page_iter(struct pfn_table *pt,
 }
 
 static noinline int expect_pfn_sgtiter(struct pfn_table *pt,
+				       struct drm_i915_private *i915,
 				       const char *who,
 				       unsigned long timeout)
 {
@@ -120,8 +132,9 @@ static noinline int expect_pfn_sgtiter(struct pfn_table *pt,
 	pfn = pt->start;
 	for_each_sgt_page(page, sgt, &pt->st) {
 		if (page != pfn_to_page(pfn)) {
-			pr_err("%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sgt_page)\n",
-			       __func__, who, pfn, page_to_pfn(page));
+			drm_err(&i915->drm,
+				"%s: %s left pages out of order, expected pfn %lu, found pfn %lu (using for_each_sgt_page)\n",
+				__func__, who, pfn, page_to_pfn(page));
 			return -EINVAL;
 		}
 
@@ -131,8 +144,9 @@ static noinline int expect_pfn_sgtiter(struct pfn_table *pt,
 		pfn++;
 	}
 	if (pfn != pt->end) {
-		pr_err("%s: %s finished on wrong pfn, expected %lu, found %lu\n",
-		       __func__, who, pt->end, pfn);
+		drm_err(&i915->drm,
+			"%s: %s finished on wrong pfn, expected %lu, found %lu\n",
+			__func__, who, pt->end, pfn);
 		return -EINVAL;
 	}
 
@@ -140,6 +154,7 @@ static noinline int expect_pfn_sgtiter(struct pfn_table *pt,
 }
 
 static int expect_pfn_sgtable(struct pfn_table *pt,
+			      struct drm_i915_private *i915,
 			      npages_fn_t npages_fn,
 			      struct rnd_state *rnd,
 			      const char *who,
@@ -147,15 +162,15 @@ static int expect_pfn_sgtable(struct pfn_table *pt,
 {
 	int err;
 
-	err = expect_pfn_sg(pt, npages_fn, rnd, who, timeout);
+	err = expect_pfn_sg(pt, i915, npages_fn, rnd, who, timeout);
 	if (err)
 		return err;
 
-	err = expect_pfn_sg_page_iter(pt, who, timeout);
+	err = expect_pfn_sg_page_iter(pt, i915, who, timeout);
 	if (err)
 		return err;
 
-	err = expect_pfn_sgtiter(pt, who, timeout);
+	err = expect_pfn_sgtiter(pt, i915, who, timeout);
 	if (err)
 		return err;
 
@@ -275,8 +290,9 @@ static const npages_fn_t npages_funcs[] = {
 	NULL,
 };
 
-static int igt_sg_alloc(void *ignored)
+static int igt_sg_alloc(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	IGT_TIMEOUT(end_time);
 	const unsigned long max_order = 20; /* approximating a 4GiB object */
 	struct rnd_state prng;
@@ -305,7 +321,7 @@ static int igt_sg_alloc(void *ignored)
 
 				prandom_seed_state(&prng,
 						   i915_selftest.random_seed);
-				err = expect_pfn_sgtable(&pt, *npages, &prng,
+				err = expect_pfn_sgtable(&pt, i915, *npages, &prng,
 							 "sg_alloc_table",
 							 end_time);
 				sg_free_table(&pt.st);
@@ -322,8 +338,9 @@ static int igt_sg_alloc(void *ignored)
 	return 0;
 }
 
-static int igt_sg_trim(void *ignored)
+static int igt_sg_trim(void *arg)
 {
+	struct drm_i915_private *i915 = arg;
 	IGT_TIMEOUT(end_time);
 	const unsigned long max = PAGE_SIZE; /* not prime! */
 	struct pfn_table pt;
@@ -348,13 +365,14 @@ static int igt_sg_trim(void *ignored)
 			if (i915_sg_trim(&pt.st)) {
 				if (pt.st.orig_nents != prime ||
 				    pt.st.nents != prime) {
-					pr_err("i915_sg_trim failed (nents %u, orig_nents %u), expected %lu\n",
-					       pt.st.nents, pt.st.orig_nents, prime);
+					drm_err(&i915->drm,
+						"i915_sg_trim failed (nents %u, orig_nents %u), expected %lu\n",
+						pt.st.nents, pt.st.orig_nents, prime);
 					err = -EINVAL;
 				} else {
 					prandom_seed_state(&prng,
 							   i915_selftest.random_seed);
-					err = expect_pfn_sgtable(&pt,
+					err = expect_pfn_sgtable(&pt, i915,
 								 *npages, &prng,
 								 "i915_sg_trim",
 								 end_time);
@@ -379,6 +397,15 @@ int scatterlist_mock_selftests(void)
 		SUBTEST(igt_sg_alloc),
 		SUBTEST(igt_sg_trim),
 	};
+	struct drm_i915_private *i915;
+	int err;
+
+	i915 = mock_gem_device();
+	if (!i915)
+		return -ENOMEM;
+
+	err = i915_subtests(tests, i915);
+	mock_destroy_device(i915);
 
-	return i915_subtests(tests, NULL);
+	return err;
 }
-- 
2.34.1

