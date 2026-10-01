Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A270BCA5FCE
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 07:41:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B993B10F5B2;
	Thu,  1 Oct 2026 07:41:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="EAT6YoQL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 59C1510F5AE;
 Thu,  1 Oct 2026 07:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790840491; x=1822376491;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:content-transfer-encoding:mime-version;
 bh=SH8wrH8c76tnQaZdcVuoby0mlT992wzzTix6LHot7qk=;
 b=EAT6YoQLqkSelco1yvsq3sHRwn+QSF2a1SDGE1hD8u9Mgz72Yw35GWe4
 M+ccisTryASbQ0H75qGPcGMSjjknlRvGGY8Qs7sS6KWBcr8hlrZD87HrQ
 BWe9IqAOR32H6aXmTIOR0oKzbf9UV4qm6B9BklZvU5jJxX7Ge0IJzc0xn
 1+xVq2SJUtpMpLlh8HrZYakJaa6Iexs1dli4ryTKj5pKo0q1p6rIKrmuo
 7EcW1LQTeg/x9W+s4FsBQAy8eePzDaB0Besh4tzItFtMyn3QdpB+okWdH
 fa7I+W5Y94CC+oN0NBgZbVeOeq+CXwYpV334xLMISIVm5FTDdDkc3eN5n A==;
X-CSE-ConnectionGUID: bQIUGDEfTkaiOBLcPNbmHA==
X-CSE-MsgGUID: KejFxzf3SE6ZTkejJGK7UQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="79151476"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="79151476"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:31 -0700
X-CSE-ConnectionGUID: yME5z0TkQ5ict828EOoA3A==
X-CSE-MsgGUID: UUUkIXvfSJS30Bmll3ZTKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="279216750"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 00:41:31 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:30 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 00:41:30 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.10) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 00:41:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wm+nfwcoy8yCMfIJ4DdQjQkc+HktNoWJ6CeAKIXnGU+CrDfkizrlC/qR98QWet2xiSS69jDCBkIfMqkMKflQzp2BSJhEBBSawWR4t2dmVPb1w7cXgSMj9Qwm/vhT0QblUw09IWVpyVx+r+r/1dcKPnlj6t3Q0w9lJKuTueNZ+BWTe2rb1oTOTXEkbUB+hDBFCwGZc3i014KsXoST8fZ7SPRY2t1yV6CYcEXWrH5lrexHjW6Wql16hcRC1rmUVZfYOKpqrTcLoIxDcg4K+WwGyLkHCsQnkh9C7fvm+syicaQ67eQxZhsEgwhgyUAdsoBgXxo/oGjBVxC020Q/y/u/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnMDlGihlVqNBrNdiRknji0ufy1yVz8ggtcVfeYj9mg=;
 b=bDfwNiepC4GKsquE9hHvB/ovfrmR96MVVP4vd4t6UuONndmd4Spxoz94AIfCi2REvmBAbOsjZCSvuWr6/1Rwe38r9APBS7Z6Nic5QqIeVfRjj/PDOpcRNeyL2ZVJE4Lq+qkV6cVXfC+5P84eHMS88i7n7IOQOO+bVPX1e/GY2gXBt2gvYOyoHv4zTmV++OYTdfvYXpIKxPQCSnMJz3rj6H4nbBnYCLp1X7ZjyblkjY7PWKabwaQUaN0UORW5I5YJBzUaeeVT1kKgQgH1fjuzFd4SuN7Od++X7/WgHs5gaio0XSXHz+93xJZRVLf8rC9TnpgDDng0dWOeaOUarWWDrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by DM4PR11MB6285.namprd11.prod.outlook.com (2603:10b6:8:a8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.16; Thu, 1 Oct
 2026 07:41:27 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 07:41:27 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v5 2/6] drm/i915/selftests: Use gt_*/drm_* prints in selftest
 helpers
Date: Thu, 1 Oct 2026 07:40:56 +0000
Message-ID: <20261001074100.2694888-3-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261001074100.2694888-1-krzysztof.karas@intel.com>
References: <20261001074100.2694888-1-krzysztof.karas@intel.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: TLZP290CA0014.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::13) To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|DM4PR11MB6285:EE_
X-MS-Office365-Filtering-Correlation-Id: 1694e5b8-0469-4fc9-22cf-08df1f8f66b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|10067099003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 1lS7gsIO9GycAV1nFrWlGGqokBuLr+dAPgUgSCnfayuhnROKNtR1u5bBi1yDj/lMW55hzldvbCtgbzbJCuE7ypuQlNmt2Lkvt59hXtce9qPCopU6wS3sMRZ5jRgY9LXdaSK5Qj+l8xCpWrtlL/OGdg+3gsQV67+BkTlcQOACWGsMrQMqB7xPE9GXcY8YqMh7BSMrKRICHZy9/UC+erPG/eiOhjAXnmJS357cVkh+Db+90lAKpHlyW9KCfQwm6F0oUKStb9yKAUxNqDn38nL/J2VB6aVQ70ukuGSBSWcGcKD2NzTtneuRMyoL1LT6JonY+uRpAMNPxBiSSEj3eRHLlxgEJS3TbirVpoXKEJ26yAfNImzj8qOR7enartdJUW9Sc/zhXORSz9cdWTWWIhT6Jtfplt3Fyi2Ijt2ZBIAfcjwAEMgG40+xkEqTDNYyzgPPcr3YHLV+K2KGJAkN+2VmEbAVQKbMlo25mgzk9Iqrgck0Lj82LGEXkA5AJSN2QMoA0211Et2gYF6EoU9p4Jhw+pbOLEnaHFSWcU7IbX4/nMyIK6NywNMV97y5qVOvwvySw3o8AbtxZibzvnjk547NP4vc/b6G3BuJvkRCi0OzQn579nrOaiZJYkQtme/vvTKiog9CJ+BfaiILdG8fTOFByMBnHK+XzTwNTECTnaN06Vo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(10067099003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VZ1CbF4EfmxDQ/xCKW1HY4SpUWLYugbVhLnHaGhrrIj531ZAhvALlwAXOOu6?=
 =?us-ascii?Q?eABgQq0KwNW9nkcUogvSp8qENuI/eoJuSvbUG8omRPgpwrawp8gZQqG0cTTt?=
 =?us-ascii?Q?A5Z06lStEpgzftD0VGBIYZOzNpEZKHYsgcZrAPJOpa+lBz3pyg1hiXWsAp2l?=
 =?us-ascii?Q?Xf4yy1EVuuViWIHM3Iql447r0LXJD5PA1D8HFl3WCsrJbONw/gFSq9qGmNhc?=
 =?us-ascii?Q?jiGKPgwm+w60FvaxGJw4vITdeARBTEKhRTgVA81uY88znBjrhhWL3VDhkvbI?=
 =?us-ascii?Q?75430I1jL+abP/ZNs8BuPjGINzJoleEIxfU5/pOdE8LTZIgC5lFIj6t7ZnBx?=
 =?us-ascii?Q?jP8SC4mqCx76AEWwsi9je2Aoks/qXvzI1FI3x+OJAl1fFmg44VQT1/OsfBLp?=
 =?us-ascii?Q?NTaSfqBlvqgXf8c3UJxRqjlReKBh/mxPZEVAPqJnvZByUwjD6IW6RQzWY5co?=
 =?us-ascii?Q?jnCPwRmhXkll9x4D/wkAjnsmYB8t8ZPoYfvaU7OGKEigkJtD7niZtTo9U/sO?=
 =?us-ascii?Q?WVmEYFcYmjPFjoXFb6ys2saDMDcAHD4a2B5cM4p/+q8Fx6/PDG4zjIltQZ4T?=
 =?us-ascii?Q?jgUfZ3Ye42WUlcPghOdPx/GcgVzMsKrHXMcMqeQ/C+yjK2ZDmIxpwX3D2qoD?=
 =?us-ascii?Q?LnH3qEoZQtbbwWzvWlg1SMYCHh+8RquK4rKl/lPbyVwqVGeaXFNpwkhtQ42o?=
 =?us-ascii?Q?YyCUFDkujGZhXf8xxoka9MFASTpVIj0HbTlen8Js3Shm6k/X1YOPAjlzNAIP?=
 =?us-ascii?Q?qUods5LD9qi4PeTbDb3wFtEUF2voBywFeT4tes72DjhRkGYoUnHzX1LhvPas?=
 =?us-ascii?Q?bMAWlxUkK5IyoyTD0nRhNLSwcu3RRzcU+DnSiPB3nsmqjzND9BaKsydg9B9Z?=
 =?us-ascii?Q?x3G96+QvzTJH00UHLMizHcnQQL52+dDXGVbFl9mfKirjmmNJ9dGSj0s2n+bN?=
 =?us-ascii?Q?AhRKfJO1LygBJWQRTqJNKrMJQu8q8PNWJsE76kzg9lruGqX55cgyDYDTu5UA?=
 =?us-ascii?Q?vfTqu2N0Yp9Gf5Aoqjl1JxnNo39FNXBcwEU/DwEJRnLTCCqmoWs0iziQGPE4?=
 =?us-ascii?Q?LPNgvSz4xqMwdgjgEzVI13lCwrir1xSQry3z/Z6hdlUS0Haqbl81DgxR78k1?=
 =?us-ascii?Q?pWhCJw2/SZt7rIqEEbFiifkIbOe2p3irYDCTuwhxTao+uzMW5fCFvp95jcr8?=
 =?us-ascii?Q?5Eb+Qr8hy1VwZgQa2nr2Lg3XYw09ybpr1qT5h2LqeS0XpCWp55TvK8qWysIV?=
 =?us-ascii?Q?ZwxnBAz4bZs7rSkky/iv5Q4Ip4w2DHyNNHs+OFP4PwmsBTsPtMpSBbtNXxPo?=
 =?us-ascii?Q?4Nhs7uKlsyKi2HtKXWa3QUYVahXoRU0400mh/P34pItjtR17xBnXtEDTKthY?=
 =?us-ascii?Q?eQOb6ZxVG3FYTMw4QhynBMYN+4/uSg3oY98dGIZEe0baGt5kAAvtAH2TUsB1?=
 =?us-ascii?Q?tAC5NYLLfiI/mlDaVglL4zZOYjZIkj4AOgmiAiStgYKsTVTljDCUs1piI5n0?=
 =?us-ascii?Q?stuWhb8cQ9WgNuPjnh0zE9rmLv0bdGO39UlTfm8x4uSibwg17ZJu+PkT633L?=
 =?us-ascii?Q?Cky0X+y2/MwRYf36VUQz+GuM9hP6caRmBNz22e5Upc2Qf9vS05Yef7pC+rqf?=
 =?us-ascii?Q?Hp3gccS02/ddK6RqgkMogH/+41TU9BTyn/Z/xdkKpTPEhrV/9uuk1199SYts?=
 =?us-ascii?Q?VKdlK6dm9G4+MNOcOKrdrhhIhv1deUbyAXpBgySLcfbO6nUQvoB0jOL8Maqx?=
 =?us-ascii?Q?7Crug0UTtWkxYCg1ezBIP+Z6J3HfRy0=3D?=
X-Exchange-RoutingPolicyChecked: MhqIUkEHuXi2Fx1qJ+EaQjd1ENGbZybOlk5k9+ni02DEqFb+Ho8rVZV5qsx1XehhM7LUYACBvge+zPepd6WkDE4VBSaKcboWARSHG1NVXe2gGCAv0ht4nFf04RuQEdWkVahP7AK3ULj0AjYDg1PX8z3+P/oimw4+etyeyIFCONyGOmOii2zeAevb71tV+Vl7TjYdWHt/jm3u6Ic18O6CELqNDGPf17UggPvYL3mNEzLR36yIfW2N8gg8U9Vx0OpChNs/mb7IgFF4dyyCEnIS8YjCzKRbgJrGyujnQyRR868PpNuD+dU5DipLAysatzL0ACkXmytCpfu+5fGeFZdeOA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 1694e5b8-0469-4fc9-22cf-08df1f8f66b8
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 07:41:27.5703 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEcr2cIs8LnaptctndHPhlC66GavciGeDLhBgLXuCBkTVGGbAWktys8cNAUjlqWzHZN9Rr8p5/fNW99ivhzxgLq9J2O0Yj6weQGYzyrX5/w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6285
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

Move away from generic pr prints to GT aware gt_* versions,
which tag each message with both the device and the tile it
came from.

igt_live_test.c and i915_active.c now use drm_* prints: both are
driven by a bare struct drm_i915_private and have no unambiguous
GT to attribute the message to.

For mocked device in mock_gem_device.c use dev_err() instead.

Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
---
v5:
 * Drop i915_* macros' usage;
 * Remove prior r-bs due to change in igt_reset.c from drm_*
   to gt_* prints;

 drivers/gpu/drm/i915/selftests/i915_active.c         | 12 +++++++-----
 drivers/gpu/drm/i915/selftests/igt_flush_test.c      |  4 +++-
 drivers/gpu/drm/i915/selftests/igt_live_test.c       |  6 +++---
 drivers/gpu/drm/i915/selftests/igt_reset.c           |  4 +++-
 .../gpu/drm/i915/selftests/intel_scheduler_helpers.c |  7 +++++--
 drivers/gpu/drm/i915/selftests/mock_gem_device.c     |  4 +++-
 6 files changed, 24 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/selftests/i915_active.c b/drivers/gpu/drm/i915/selftests/i915_active.c
index 9fea2fabeac4..79b55df1e71a 100644
--- a/drivers/gpu/drm/i915/selftests/i915_active.c
+++ b/drivers/gpu/drm/i915/selftests/i915_active.c
@@ -115,7 +115,7 @@ __live_active_setup(struct drm_i915_private *i915)
 			err = i915_active_add_request(&active->base, rq);
 		i915_request_add(rq);
 		if (err) {
-			pr_err("Failed to track active ref!\n");
+			drm_err(&i915->drm, "Failed to track active ref!\n");
 			break;
 		}
 
@@ -124,12 +124,13 @@ __live_active_setup(struct drm_i915_private *i915)
 
 	i915_active_release(&active->base);
 	if (READ_ONCE(active->retired) && count) {
-		pr_err("i915_active retired before submission!\n");
+		drm_err(&i915->drm, "i915_active retired before submission!\n");
 		err = -EINVAL;
 	}
 	if (atomic_read(&active->base.count) != count) {
-		pr_err("i915_active not tracking all requests, found %d, expected %d\n",
-		       atomic_read(&active->base.count), count);
+		drm_err(&i915->drm,
+			"i915_active not tracking all requests, found %d, expected %d\n",
+			atomic_read(&active->base.count), count);
 		err = -EINVAL;
 	}
 
@@ -236,7 +237,8 @@ static int live_active_barrier(void *arg)
 
 	__i915_active_wait(&active->base, TASK_UNINTERRUPTIBLE);
 	if (!READ_ONCE(active->retired)) {
-		pr_err("i915_active not retired after flushing barriers!\n");
+		drm_err(&i915->drm,
+			"i915_active not retired after flushing barriers!\n");
 		err = -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_flush_test.c b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
index c383d31d46b0..c59425e7ccae 100644
--- a/drivers/gpu/drm/i915/selftests/igt_flush_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_flush_test.c
@@ -5,6 +5,7 @@
  */
 
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 #include "gt/intel_gt_requests.h"
 
 #include "i915_drv.h"
@@ -35,7 +36,8 @@ int igt_flush_test(struct drm_i915_private *i915)
 
 		/* 2x longest preempt timeout, experimentally determined */
 		if (intel_gt_wait_for_idle(gt, HZ * timeout_ms / 500) == -ETIME) {
-			pr_err("%pS timed out, cancelling all further testing.\n",
+			gt_err(gt,
+			       "%pS timed out, cancelling all further testing.\n",
 			       __builtin_return_address(0));
 
 			GEM_TRACE("%pS timed out.\n",
diff --git a/drivers/gpu/drm/i915/selftests/igt_live_test.c b/drivers/gpu/drm/i915/selftests/igt_live_test.c
index 7d41874a49c5..c1fbd98d3164 100644
--- a/drivers/gpu/drm/i915/selftests/igt_live_test.c
+++ b/drivers/gpu/drm/i915/selftests/igt_live_test.c
@@ -59,9 +59,9 @@ int igt_live_test_end(struct igt_live_test *t)
 		return -EIO;
 
 	if (t->reset_global != i915_reset_count(&i915->gpu_error)) {
-		pr_err("%s(%s): GPU was reset %d times!\n",
-		       t->func, t->name,
-		       i915_reset_count(&i915->gpu_error) - t->reset_global);
+		drm_err(&i915->drm, "%s(%s): GPU was reset %d times!\n",
+			t->func, t->name,
+			i915_reset_count(&i915->gpu_error) - t->reset_global);
 		return -EIO;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/igt_reset.c b/drivers/gpu/drm/i915/selftests/igt_reset.c
index a2838c65f8a5..6be63451317a 100644
--- a/drivers/gpu/drm/i915/selftests/igt_reset.c
+++ b/drivers/gpu/drm/i915/selftests/igt_reset.c
@@ -8,6 +8,7 @@
 
 #include "gt/intel_engine.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 
 #include "../i915_drv.h"
 
@@ -16,7 +17,8 @@ void igt_global_reset_lock(struct intel_gt *gt)
 	struct intel_engine_cs *engine;
 	enum intel_engine_id id;
 
-	pr_debug("%s: current gpu_error=%08lx\n", __func__, gt->reset.flags);
+	gt_dbg(gt, "%s: current gpu_error=%08lx\n", __func__,
+	       gt->reset.flags);
 
 	while (test_and_set_bit(I915_RESET_BACKOFF, &gt->reset.flags))
 		wait_event(gt->reset.queue,
diff --git a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
index e14ac0ab1314..2441887e3b28 100644
--- a/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
+++ b/drivers/gpu/drm/i915/selftests/intel_scheduler_helpers.c
@@ -7,6 +7,7 @@
 
 //#include "gt/intel_engine_user.h"
 #include "gt/intel_gt.h"
+#include "gt/intel_gt_print.h"
 #include "i915_drv.h"
 #include "i915_selftest.h"
 
@@ -24,7 +25,7 @@ struct intel_engine_cs *intel_selftest_find_any_engine(struct intel_gt *gt)
 	for_each_engine(engine, gt, id)
 		return engine;
 
-	pr_err("No valid engine found!\n");
+	gt_err(gt, "No valid engine found!\n");
 	return NULL;
 }
 
@@ -60,7 +61,9 @@ int intel_selftest_modify_policy(struct intel_engine_cs *engine,
 		break;
 
 	default:
-		pr_err("Invalid scheduler policy modification type: %d!\n", modify_type);
+		gt_err(engine->gt,
+		       "Invalid scheduler policy modification type: %d!\n",
+		       modify_type);
 		return -EINVAL;
 	}
 
diff --git a/drivers/gpu/drm/i915/selftests/mock_gem_device.c b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
index 796c9b070e41..c0dadcd961bb 100644
--- a/drivers/gpu/drm/i915/selftests/mock_gem_device.c
+++ b/drivers/gpu/drm/i915/selftests/mock_gem_device.c
@@ -169,7 +169,9 @@ struct drm_i915_private *mock_gem_device(void)
 	i915 = devm_drm_dev_alloc(&pdev->dev, &mock_driver,
 				  struct drm_i915_private, drm);
 	if (IS_ERR(i915)) {
-		pr_err("Failed to allocate mock GEM device: err=%ld\n", PTR_ERR(i915));
+		dev_err(&pdev->dev,
+			"Failed to allocate mock GEM device: err=%ld\n",
+			PTR_ERR(i915));
 		devres_release_group(&pdev->dev, NULL);
 		put_device(&pdev->dev);
 
-- 
2.34.1

