Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD9606A32D
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 11:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lwReLW6T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB4C310FB4F;
	Wed,  4 Nov 2026 11:11:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CEA5E10FB4F;
 Wed,  4 Nov 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793790693; x=1825326693;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=oEaM7QoSZ1GpJkX9kBz7mhveUPaEjbRoX2I2BzpcLgc=;
 b=lwReLW6TvZEOjuWdDP12oMtEtjkRupnFLXZN5Wtx8OnE6/KDXr0rEK8N
 8C/KQOH0g4aBO3s2xrv8AYVEaV8W1W3HGVXifDt6mF+iNCB8ufUXeX5nY
 0CXwO2YnpH/RAojlXdxBXU4lTCEHJ4RyejWXZKfnT9zedGbZYiZbzFMEq
 aU5lZlBtRfe8nJpkEQL5TPQibPQBHIdckyW0YakbWmAHmcWtKT2UGbwwz
 t81TbAWlfD33rr1EFGB4QpVvgJ0DfWSpk6dVK6GMHi3+7jWMfUZTD4/eG
 Jy4ZxJhgjBc1OO7FnZVmlVdbd0incjd9jEpZCI553mf9FybTMHy45mszf g==;
X-CSE-ConnectionGUID: um3fpkEzR/G/8NkEISGIbw==
X-CSE-MsgGUID: sJCGHuv2Rjqo76Ayp7AGcQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2553587"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2553587"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:32 -0800
X-CSE-ConnectionGUID: hQcDw0bZQk6B5I7Izati6A==
X-CSE-MsgGUID: yHWh1RLGRgeLAf4ylWStSg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6546268"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 03:11:29 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:25 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 03:11:25 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.68) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 03:11:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HplsyPvpdJqNSntreWZRejvmWzwhwCce6RqnrNBYFnJpW1JHcITc9FV1xlPqj6Zyly+IAQ9uW2Qd1iRKbVALec85y2Y18jchgF35uLr5ibEKWleBQMj4ebQx1m1kIbmJ9tIV0mTmCb87x+qhaQ90nFbi6cb3aNWoLsYHmYe/iM5TIaCM63QBYT3b9lYS9yv2unoQEeSVzOlHB0nafdSPB8yYiG3TUEF8q5/zvWcKl9giS8IF4yYfFmVYnLX3QB2mQipeO+RZtPsHshN0y9cNW8nvqDrJ5m8mQ4Pwg3xNpF671aFiXJQyqyJzkgwG2HUhUL6O3QwyCSGThRcRHXkFNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SVMGDg7kE73PS3qR1QX9sdxebW33ccTNgVMAKoiKeEQ=;
 b=liuZfu6NZiEGsJf47fu2um6lzdoSFoQ0T162hu4YZdpPlMmlVY41cz6o+U8n0OB3Wh3EGs3yalM6u74dMeTLeN5MBTcEahr5GWGDQ1HzW2O1x1/Jtp+diQOyQtpG0yTFliX5sHk/9x6pfC9dGn7+qyjpdta50c7jmVsspQcnREDpdN6H9RkKV+bybeX4FOKIS6Giz2t2AsZfDVtaXL20PkZwfapy4u6j7ygft2S5ZXW0gqGV9Y5vEvQxHJw1o8pKl99QvOttQLgqrXcCaTy3dE8Y4mSizuHxyabAZ32NNpdPuNOImRqFXpeaD4jy+Yo2BTrWQTpVLRlb4f0SA51SlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by CHXPR11MB9650.namprd11.prod.outlook.com
 (2603:10b6:610:2fb::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:11:18 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 11:11:17 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>
CC: <dri-devel@lists.freedesktop.org>, Jani Nikula
 <jani.nikula@linux.intel.com>, Andi Shyti <andi.shyti@linux.intel.com>,
 Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v6 0/6] drm/i915/selftests: Modernize printing in i915
 selftests
Date: Wed, 4 Nov 2026 11:10:58 +0000
Message-ID: <20261104111104.946617-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DUZPR01CA0189.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b6::7) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|CHXPR11MB9650:EE_
X-MS-Office365-Filtering-Correlation-Id: 6570f687-4583-404a-f788-08df3a6458db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|6133799003|10067099003|18002099003|20046099003|56012099006|11063799006|261021123027099003|261022113327099003|261102123227099003|261026121527099003|261021121427099003|261022075727099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: oylmAaLlJOg+9BcHHXAvFIhaQkr/WsMokNH+oNtB5xulFYGlqgNXG3XRkIg5TWJG+hDcM555f0HzqJd7Ldm9PaCuyfwR98+b0HUTfsh60wEIlXWx/Cak1KKG/A9Wuahul+OCZGLe0oP6KvEhhPv3HF7xo2qzqELardNAxJV2B0J5HVJJY63glwB93b/Krtg7F47BEXhduCD9qbHvBQPaGV/Mu2lm4564F2YnJEcjDSVSToGKe9FiXTlQOkZx/KSrR2ErHuzw8vxe77H5a7XrPkN5sReyQZpxLe9WiW5//IiXM21M9hm5oxpWagIReAkTopk2ZTaCjddg8nSnBRln4s94fHv5z0nTVh0YpnEqVsotpUzQTPMv0292nOCNWYJKiKtd7qDheC1xB81xlrufJ047RjAMZqtdqiIztcLM2VpE8k/mHBqHVrUUAW/cUiClWyWU2fFB/zLdrAogfGASSMTiGY5YIRNLshn+Lpo5M5JOS5DcKOiy9I4PHbQ9dnecTFdChmM14XLTbx1Ubqa6LyI7nZ4crp84i8E0u2f3P2PICS+Zfk3rGSkOc/mR9+oszVj4QH4zhRYdzegzHKurUHGHn8c58LbGi8qtl2M2D3HDtEISdryVB4BDsSW3bjMycgkuAqE+eYxh53OgAeTm5QenUlHBRK0FrtuvrXGnQeI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(6133799003)(10067099003)(18002099003)(20046099003)(56012099006)(11063799006)(261021123027099003)(261022113327099003)(261102123227099003)(261026121527099003)(261021121427099003)(261022075727099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xlXGGpzXns7TF1mVcO9dZXL3IH3hYWeqZ/QibUuupVuXUTGW4hmzifRSJEG2?=
 =?us-ascii?Q?O+hw/4ZbzJki0FMUg80hIJZuyebUGbJvzGF1jCf0TnN1lv+YNR4U3KM22iOs?=
 =?us-ascii?Q?GJqaWPq27FaCUJ3sLWEVdSYIky1ffzKf8d7HXsQRypMnKePXep3Hzv9PZk9q?=
 =?us-ascii?Q?FFp9++5dL3o8gVSMmWvowIt8EMD3HXsHAV/wETggwOkZmS5T/+RvpXK+FEqj?=
 =?us-ascii?Q?caEnSwZNfCKZTXZJ/aqQ0RObqz2j/FbcJDJuS6R0S0+8+OE2oTb1vL3e6/pc?=
 =?us-ascii?Q?MW/AQIdEkQK3UJTGHAB5th3siNjRDHDJTcsRrruLGilSlpuT4hyjEPx7c/ab?=
 =?us-ascii?Q?gQI+dFJ4H8xX4a6JeLafq3n0Tp3mbPiGBy3R9C1lzjQWx2l3ksUpAgiCJeBx?=
 =?us-ascii?Q?FO71TDZZSl1o5HuStA6gM6EKG9elLXzgCMMzBgdGHcIUceHkzZnqdgpccNw3?=
 =?us-ascii?Q?86NUUln1CXdbybGzVsmN1hqEcET1v788sErLCPIfwoA8j6C0TR2rjTtY5X8w?=
 =?us-ascii?Q?uPVGQzHz4GRzt0kaaNnqE6l5aLdhjpfxNROS9Q22EOgGCdcpoPyesCp0YkA8?=
 =?us-ascii?Q?B98Q3JpYRn1TQ4SQSvw/QAxaiVuDS8Sh87kwp7W4arWguKJrtU6lgw6WUsv0?=
 =?us-ascii?Q?q3hGowxN0e0S1UVT7e0qQy8PFogkYnAV16UTq26wYSpnZCI2MAjB9axMclY4?=
 =?us-ascii?Q?wtUezdJF1pwqrGTjATV6lRAYhrfUnL7U764RmY4Gc3eBsPvUb0JwECILHqQj?=
 =?us-ascii?Q?TtYNiH3vUQcjJa5t2qu1EX/ix3z4eT25lHZFcqWQfPaRgpK7YlkuJZFdBlHj?=
 =?us-ascii?Q?oZVjJaSPl6KMuwMLX/hRJCbTHahw3e13DeqzuIsiucV0wlNdV2PsB7aWxdoA?=
 =?us-ascii?Q?x8NwDMNQCeyJBtbz1W3A2vyKxadtQXh1ca8qfnnChE3wUIq0Vxt9QiJ8e+BS?=
 =?us-ascii?Q?MjeMLhaSLaZZgLFe7pnBAa6f6qQ/mt2NbRfDX4oDE0grJ8je68+6LP9fJEjn?=
 =?us-ascii?Q?O362e4ZmwEMIHSgXUrG8n/jT6ypMrhwQiZPVn0wL3+TMT5/bAoeqvybjZN8i?=
 =?us-ascii?Q?fY/WwvT6nCV99oEZbuT1Ot4noKRccZDUHEZVBUBXHHnqQ1dbUP3Dj7ptER0T?=
 =?us-ascii?Q?b9woREWukLLuvn457NZU2c04BHfPjKbrsb0Ld49xCx5p4MFxyvX99zLS5wTx?=
 =?us-ascii?Q?fLhUN8HIwbotZKkJSzd9WzU7Ljp6RE36RFOWp9HWMy4qkrhP632J/JSywLPo?=
 =?us-ascii?Q?F3W4qCTmjOIUKUTCFYIxsIrB7OYcQaMJ51xUFTHHTP+M64X8YC/9D/eMl65B?=
 =?us-ascii?Q?d9JZXJ3DaPCrdp70reY120DOplw5zpIF6UtPuERUjQUbzAeZc8TkA0ZxAnRt?=
 =?us-ascii?Q?qo91E9IpMoCSBXt+QsxeCt31hQVvTeUza9wo2XwFz+Nmf/Tac0e2oUDdW1Sn?=
 =?us-ascii?Q?P99hJYKiMbdwdM2MQ+pM318cEvmZYeDge3AEcweuuaHnTygKeWwLnbJ8SR/X?=
 =?us-ascii?Q?oSFUWHHfIyO9mRDa8N5djn+B0cIkKb9DIkmnrlHs9usZ/XQJ2fT7nSAh26f+?=
 =?us-ascii?Q?uXYXCzEfThjyubYnyjUDqfWTJRvA/aFH5iRr4je+ugzfVQ9bZFjrNiSJLDpe?=
 =?us-ascii?Q?KtNb08nowz5fl/MMZ78Mh0Dcr6R6O6yoqYqFIqgBOwRjbwQrZ4oeEZQXKRm5?=
 =?us-ascii?Q?Glhe/NfA4rGHMveNlpGwpyQGyJXVFXplRLLos2JKsG2xjvX6qTsXp/F3ryLT?=
 =?us-ascii?Q?5yXd+U10HuGzEv1xGCj6imAjp9oKOt4=3D?=
X-Exchange-RoutingPolicyChecked: Kfic/kH3HJCg4OYjz+faTwwMHeoJQemQJYZg3OgM55vpbFAOvG3o707sNK9v1gJFdpZyhsaeaBOMIFBb7zfPzgP/VOuqgf/lHdNWmax/Zucr77/hSKXemEIwWaPUtA9B1k/fvCvBq82gX2Cbn9NW7gzCe0n+QrIEhJSltzcjlB0Wt6ZFsAYqn5hmdTxxZeXoOakRVdFwno+XeNpPEmvNN3uSHMX+5Y9csbPOuiUcuptFhUfnVgoW/Wg2Bj8+e9VfsRqktOPGuDlR4VsOPlLFRdtYPQ1CELabkt+jFFUYZaHihAXgT35PGS2J5a+nKCKYoojJbkWqCHgPUTcrQi1rtA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6570f687-4583-404a-f788-08df3a6458db
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:11:17.2756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OGTZMxVfJ+p5JMJX5fQPJkJRX+DJtgyaH8TK6JQcbNmZYOxhJ3ImgCZlkD9rTqDHbbg01Qsv5rkNpi3c1oBtmWD8/0IovXGNyrwTPrW6Iak=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR11MB9650
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Currently, in many instances, i915 functions call pr_* macros
to write a message to the system log. This way of printing
lacks device context, which could be a valuable source of
information. Many files in DRM already use drm_* prints to
include that context, so it would be beneficial to do the same
for i915 as well. Start small and convert i915 selftests first.

v6:
 * Remove obsolete Assisted-by tags (Jani).
 * Sanitize a number of prints (Andi).

Krzysztof Karas (6):
  drm/i915/selftests: Use gt_*/drm_* prints in core selftests
  drm/i915/selftests: Use gt_*/drm_* prints in selftest helpers
  drm/i915/gt/selftests: Use gt_* prints in aggregated gt selftests
  drm/i915/gt/selftests: Use gt_* prints in gt standalone tests
  drm/i915/gt/selftests: Use gt_* prints in gt selftest helpers
  drm/i915/selftests: Use drm_* prints in i915_selftest.c

 drivers/gpu/drm/i915/gt/selftest_context.c    |  20 +-
 drivers/gpu/drm/i915/gt/selftest_engine_cs.c  |   5 +-
 .../drm/i915/gt/selftest_engine_heartbeat.c   |   7 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c  |  31 ++-
 drivers/gpu/drm/i915/gt/selftest_execlists.c  | 243 +++++++++++-------
 drivers/gpu/drm/i915/gt/selftest_gt_pm.c      |  21 +-
 drivers/gpu/drm/i915/gt/selftest_llc.c        |  25 +-
 drivers/gpu/drm/i915/gt/selftest_migrate.c    |  47 ++--
 drivers/gpu/drm/i915/gt/selftest_mocs.c       |   7 +-
 drivers/gpu/drm/i915/gt/selftest_rc6.c        |  32 ++-
 drivers/gpu/drm/i915/gt/selftest_reset.c      |  20 +-
 drivers/gpu/drm/i915/gt/selftest_rps.c        | 126 +++++----
 drivers/gpu/drm/i915/gt/selftest_slpc.c       |  79 ++++--
 drivers/gpu/drm/i915/gt/selftest_tlb.c        |  24 +-
 .../gpu/drm/i915/gt/selftest_workarounds.c    |  70 +++--
 drivers/gpu/drm/i915/selftests/i915_active.c  |  12 +-
 .../gpu/drm/i915/selftests/i915_gem_evict.c   |  52 ++--
 drivers/gpu/drm/i915/selftests/i915_gem_gtt.c | 164 ++++++++----
 drivers/gpu/drm/i915/selftests/i915_perf.c    |  30 ++-
 drivers/gpu/drm/i915/selftests/i915_request.c | 208 +++++++++------
 .../gpu/drm/i915/selftests/i915_selftest.c    |  10 +-
 drivers/gpu/drm/i915/selftests/i915_vma.c     | 184 ++++++++-----
 .../gpu/drm/i915/selftests/igt_flush_test.c   |   4 +-
 .../gpu/drm/i915/selftests/igt_live_test.c    |   6 +-
 drivers/gpu/drm/i915/selftests/igt_reset.c    |   4 +-
 .../i915/selftests/intel_scheduler_helpers.c  |   7 +-
 drivers/gpu/drm/i915/selftests/intel_uncore.c |  24 +-
 .../gpu/drm/i915/selftests/mock_gem_device.c  |   4 +-
 28 files changed, 957 insertions(+), 509 deletions(-)

-- 
2.34.1

