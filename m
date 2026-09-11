Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4870BC79FA1
	for <dri-devel@archiver.kernel.org>; Fri, 11 Sep 2026 06:12:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F382110E2E5;
	Fri, 11 Sep 2026 06:11:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="CafUyXw4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C2AB910E149;
 Fri, 11 Sep 2026 06:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789107117; x=1820643117;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=3ysZyg68IfwHpHen9vvAnvDvJuS0pHBjLE5YXNQoL8Y=;
 b=CafUyXw4w2X0zmUVxIiyR3dpZhibDR3ipfeaRPEkLRNG038hGmtP0cWi
 GMvbFzS9N84Nw9S95xykH+BNACGvwPzvUqAGlakZNXlV0JHrPbUB0ZHII
 vI49X4SXcuBXyjsK+6VMatAFkuPhgSH6oUtoQb6o6BJnQG/tK7josKnP8
 /1lPFOOKwaDLPs/X5z07Mvv4Y4+gy73A3V4e1YmhmErNQdxdjQClhk+U+
 FAQ23TOe8E3cPWC2+ZNVADH0giMhsjZ2RdFcNoJ9Oti37/HiWvGPuqkxQ
 Zi1+eAWIh4DlOVieq1JEZ4eOyQup4sYiliU/SpUzwQ2EOKxrarw4qvMx0 Q==;
X-CSE-ConnectionGUID: 4D5G+4n8ShOls5v+BMc0/w==
X-CSE-MsgGUID: x4wwzR5JR/ur8GsrCK6KaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="100730977"
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="100730977"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 23:11:57 -0700
X-CSE-ConnectionGUID: nEP7qSFWQHO/4Trz9BuyoA==
X-CSE-MsgGUID: 2vKTlG0+TKCqmxQcuFPkag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,96,1787036400"; d="scan'208";a="275353820"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 23:11:58 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 23:11:57 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 23:11:57 -0700
Received: from CH5PR02CU005.outbound.protection.outlook.com (40.107.200.40) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 23:11:56 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CF3J9ihDaihzfez1taJU+PeyYIbuymEEMGEWp9DNWh0pdIOgmd8E0cQlRcqne/DkKl29n9ZvBin+4xsmflsSX6kWjEX0TiByI+SB3+Pn7gk1TR3+TBlZ2MRkgXKo9Xq2765s3F+LsxPm0I+e0K2u6Y5nTcjPA6/c8UnEkUIq9zBo8KIBMilmWpMU09sFUDmlX9KXUT26og4wW9MTUArKNupV7NZPq7Ubm+88p6JcqPwaWxeo836evmr6pctaysK04K6Smv2T1SB0BB00XmNvjfxIC/D0XKc3IMweQTKCiI8ThnZYnkG/6+FSSfn12AEDnVRh1eyJcKBb75pnFldvOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TPapuWbs48o62LDrV6LkHgZSWVzSFkk94M85S/P5HTc=;
 b=g9I11ukWqaR6BkXDHwIWHhNjiz5Fk5lvK6xyyzu4pbmUbC906Dgmu/X1jmQRS8dFftIiZ+9DbC3VFBq+FFVbpPKEESG2MuHlxbfBYz+EQ1vk33jkvNpbHwaYu6aEDD0oNS+QRejPRIIRLCJzfA8RroPfk1mu9QudB5AHmT0LLjPl78PlVMP/w5etlcQr7euKoGXvwFUGzaL+F0GhbCDweOfDXsZ7seqn2GvdKzrcf6MKpplbkbqzufemh+Lm9mq6HjY4Djnq3tJcLuATuqubHGf18OQW9Y9R/F84hXxGK6zqgtkRcNdpJ67DBqEk11FPng7S5enDMRt063+nsFYQFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by IA1PR11MB6097.namprd11.prod.outlook.com (2603:10b6:208:3d7::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 06:11:53 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0406.007; Fri, 11 Sep 2026
 06:11:53 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH] drm/i915/gem: Prevent overstepping exec array boundary
Date: Fri, 11 Sep 2026 06:11:45 +0000
Message-ID: <20260911061145.3535489-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0045.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::20) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|IA1PR11MB6097:EE_
X-MS-Office365-Filtering-Correlation-Id: c69f870a-fadf-4dd8-3a15-08df0fcb9338
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|10067099003|18002099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: jhwzBVjCL90rYHQuQ7gcSwSG3HZjEbABcYLJm/siVR5z0fVrqgFSgGiWuUXsj8GPEU9QcxetSA3jflVqNWbRujB/2J44T3V4nPflovbBiLF56SmyrAF/xdR7nNENPaXWL2/zagwAVE6E4XY3BND2a8WWm1A0G8OQPo3QD/jqk5E1hapsbwD0GGNShCsJHf0JkvfCodENtSm/h5UNLQlyIIs8jkYW+IIlLWEyFLpOMnk0yZ/PIFQl8lZWXUAhK6qOrt2zmKXfOS6eokotlw9WQec9qtiGBTFSGG6MTBX+I+aXQfhLg+T/yWUQjfCPbKio2+Ta0LMomSXXAJngbJia2684GKCuYD2F9yP9y3Wo6/L/gsKbCB3cs6AtGF+egk//wQosDsXpP9okk/63NBewaWBR15uCJADjJarVsR38fi3NNYYNxbU94bqcpIOdNetxWJ4bJEOyYIIhtqJCHfkF3/3gy0bYiMfFhkEABYwPK1MP81eV1f1bk4rjOYNCoRWi+1Z+GQ7rXdiJk5KfcKAqnksNv3jucAEygdixITfRmdOJBD96MDomE+P1F6r3KZSpAGVll7sPKWd8Lwd5+NFWePFoSdUfK6lAuQMGBz26WIpTY5eHQSYqLtgbA+B7iC3ivTQ0fqHyaVjqyBMzVoFYiC6chQIq7dsUmgiOX76KLik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(10067099003)(18002099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?961PTjj2yux+Rw2+WBxbilczKG8blxmKrgCDNPtiil7BzITsMobzBBlKPCU6?=
 =?us-ascii?Q?Vk7WT35zn15K6bBOd0QgKpjfEp3EhNxEbuVFzAhlpw7Ch4bbv/upkUqurIg2?=
 =?us-ascii?Q?IBssk2zn4rUlt+HKcZ4U4DwY2eOOJHf6r5h5WOkpFF85/nm8HarowbQpRGNk?=
 =?us-ascii?Q?8gVlYeQYWu52BBdlQ62fC39IFvGInMK3rt/L2mvwkuM+7Z5oYSBeT5NTPqx0?=
 =?us-ascii?Q?jBFHQMjdkNTEbAc3F1vJtPDTAJpbvvJfZYSjgRtCgefr3xhGZxNv93L17ZS5?=
 =?us-ascii?Q?AF8NWAUGc55ElxJ+/6Yb+g/QQrUB063AIzG5zlB6OWs9DIJ2xA2t4WN1K83z?=
 =?us-ascii?Q?Ljwe9ZsG2V1jtXH2OslEG6CmfjmCpMZGl+lmOXUmu8mzDnZc3+GdyC+nl/RD?=
 =?us-ascii?Q?yQawfyFI0rpdfaQKNUwsLcUt2ZFchSXtrV4Wg6JCVrR2mZgsManqaQSWRbmd?=
 =?us-ascii?Q?26YxIkqbsjC+oDFafVHuQlMtZhMQzaYP1Y0eWxP7SAul3GyECKsGGPwUIgNZ?=
 =?us-ascii?Q?kH1D37O3wsYu4nmI6cFlXu2DvhBDN8gqvXgHzMO1kg+q9IaBnlQ254GoWHsT?=
 =?us-ascii?Q?xzpEpKu8hKwq91a1XCcvQevXDm/sbEe0wXETskkUfWd4ssbrqPEyUBB5ILik?=
 =?us-ascii?Q?LOT/UB+15YSeWCZJ10Woq+0DNhi9Cy6g/+OOPVZPnDAPUSo3YQ+5vfJzCkx7?=
 =?us-ascii?Q?2GYkwY5uXYZUf38Wj67LB89NGT42tdidgjV8wgWivpl3GSWgyqkAve4/d1yO?=
 =?us-ascii?Q?uwwXe/9aKdPdLBwJdbdYpS8IEMEFpiIaB2vA2KkQXoh4lghnGX0coz7WRQXT?=
 =?us-ascii?Q?SFI3BXp4ZZxOV8v1vA4SuNTLbBpMKm2tW49mgrjT8fR19JqjTiihjRx8JrYC?=
 =?us-ascii?Q?aqyPBRhaOFCM+LI5CuFyr5sNRzzr5Lphbpna8UWNYzFnG3r9bY6VGRzP+P2h?=
 =?us-ascii?Q?MIZjEiPQhr8m1V6bChFnRTQGQGhn2Zq4uX8o2kcN0dWsW3tZ3TMKzSX0VFqw?=
 =?us-ascii?Q?xH1f6QrrnY1II9TUibPd5PDSh54OSW7hl35je83V0fOAKpYHY5OO9nkmeACw?=
 =?us-ascii?Q?wixFpzlxtszop0oAI34Tzzlqq0H3SRHFL4IzrTFhPIv5YP6jBbjikRtQsoH8?=
 =?us-ascii?Q?QMeHQqUr+pKkk8FS3iAKhWHbIkwpp6fdHbof8lU3Mc0oAvYOOFoatL/e0gYR?=
 =?us-ascii?Q?YBjVZLhflnKvJ0AsgGlAskn0p9sdw0Dm7ZR8cOrKSmAD0YrWwMCl+eBWGYvU?=
 =?us-ascii?Q?xbJFUXYWB0YvO7VtYIB+P/4RcAAy498CdKJ4UAf7FYamY4XFGN/yxMwqjfZj?=
 =?us-ascii?Q?W+WTPqyWiUW7oim5z0/apYdtYbd6uhlE81UnfGoDKGCKNVKj7CrmReny31Bn?=
 =?us-ascii?Q?pFCpBzJFFZO7YWOyLLfKbB36cdT6hWiGz1T5iSX9PErCVegV61LB4ny5jG2X?=
 =?us-ascii?Q?8JvAhyjkB1RiYXiOSE5AJ2iibYRtFPPwTokgd9gvrM4F7q5l8D/bXlAjJTiU?=
 =?us-ascii?Q?zGqUQZyn/+BrMVZI7afVzAhU02y0yCfj2WoTA1v8N7JqJXMpNiDkvff+Pwd6?=
 =?us-ascii?Q?9JJUON8paUej2rlU18jD9aT34AXa7bCaIm/uE1aflktsKQmW3xO6w0B96kvh?=
 =?us-ascii?Q?GOwGB1FhlVchF38Q6wGoLW1phDUD9sL1f+rfW2H2uePbkabZ1MhYPKQLRhxL?=
 =?us-ascii?Q?DleVhzdQ3wSXlX0fkfwYYSY7qcEheWaAvp6lcnk7x54UJpTOeGZFSZ1m9wdf?=
 =?us-ascii?Q?w56LnRCn+9uDy44WUmt6m/hfl6UT/gE=3D?=
X-Exchange-RoutingPolicyChecked: eBrE9ynt868UYMVkDg7xdNfJcIwpSs0S06+zaVNJLE5InvzICvHAtFyTKoziyyE96volsezRDc+Y8Izq/oDtdzr4idv8z7xeRJ5mWI5mrQBTlucsRIBs+Gj4xXhalOdYIak+VfvDutY3RGp6UK/aEGbXUwgc4gApCBtosAkQ7vQuOoWuCMGQjB9tLJts3Mz+8NuwXPIEuX7DxA11tFOuf7/SdItwtZb9QA+jkbWsOVWDgvVOn5xu6mgawswgf/Cylfq6n9Vg/UKKXOGz5qYvi14TtzoJBuJ8omFoaPJlPjY5V7+/pR6idT6udXPIEAhty2VEM0irjjABH/ds1lb7ow==
X-MS-Exchange-CrossTenant-Network-Message-Id: c69f870a-fadf-4dd8-3a15-08df0fcb9338
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 06:11:53.4694 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7B7+zw7wEpkr8xIIdvHiXtf6cOncdSUE8VshhCr5wrQtHqRPMTk+ree+0zpL1ZMRJEyJSyHMiJes3Qz29hWj75tKCtV6+DHB6EoZEdrXc3g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6097
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

It is possible for eb_relocate_parse_slow() to call kvfree() on
entries outside the original exec array during following
scenario inside eb_relocate_parse_slow():

1) eb_copy_relocations() allocates as many as eb->buffer_count
   copies for exec entries;
2) eb_parse() appends up to two VMAs, right after incrementing
   eb->buffer_count;
3) cleanup under "out" label uses this incremented buffer_count
   to release relocation pointers from exec array via kvfree(),
   not from VMA array.

To amend this problem, ensure that relocation cleanup uses the
original exec object count, excluding the VMAs appended by the
command parser.

Fixes: 8e4ba491b0ba ("drm/i915: Parse command buffer earlier in eb_relocate(slow)")
Cc: stable@vger.kernel.org # 5.10+
Assisted-by: GitHub-Copilot:gpt-6-astra
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
 drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
index 1f303d4eaa4d4..d5aadced7da0c 100644
--- a/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
+++ b/drivers/gpu/drm/i915/gem/i915_gem_execbuffer.c
@@ -1766,6 +1766,7 @@ static int eb_reinit_userptr(struct i915_execbuffer *eb)
 
 static noinline int eb_relocate_parse_slow(struct i915_execbuffer *eb)
 {
+	const unsigned int count = eb->buffer_count;
 	bool have_copy = false;
 	struct eb_vma *ev;
 	int err = 0;
@@ -1868,7 +1869,6 @@ static noinline int eb_relocate_parse_slow(struct i915_execbuffer *eb)
 
 out:
 	if (have_copy) {
-		const unsigned int count = eb->buffer_count;
 		unsigned int i;
 
 		for (i = 0; i < count; i++) {
-- 
2.34.1

