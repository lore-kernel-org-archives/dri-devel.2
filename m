Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F7F606A322
	for <dri-devel@archiver.kernel.org>; Mon,  9 Nov 2026 11:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nztIIGP6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EE4B010E5AC;
	Mon,  9 Nov 2026 11:38:23 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B2DBA10E5AC;
 Mon,  9 Nov 2026 11:38:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794224298; x=1825760298;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=yvNqnEtL1DrLHXAZmMvGuniZyPfPGwdqWzaQcBqBBVI=;
 b=nztIIGP6wyLwdzvUtbDQyWqPabY+/iY5+Ru8zwI/ZoWXCYN0gaeq/HBJ
 u98Nhqyx9TG9I4RZK5HAgY9k97hs3LIhZLnXvxe1vnifgFA8dK2tX1zue
 VV6xlU6l1bfbLPCJVZXImIHR2D+3HQrYoboLKKx7AngtYyNH46D+kk1OD
 6Yz/u1uc+z8Fsu8T+oXW0chuDu/Flv1Zp2xSfkNZB7kZQT7qqcaWFaFbI
 INlwoRmvX6EH86TnPq4gJz7soxbo+UI06Nc/C8jPZMRPv0irAgifSZZN/
 kXKTOKQ5vIVkI7zGwinrhp2faZrpx+JTnuIBM/3xIE/lf88mWzwMBhLic w==;
X-CSE-ConnectionGUID: g/SRH7XnS/SOlLL0A76VIA==
X-CSE-MsgGUID: jTnqSb3HQoWAwWVB5KIKZg==
X-IronPort-AV: E=McAfee;i="6800,10657,11960"; a="2938486"
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="2938486"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:18 -0800
X-CSE-ConnectionGUID: y78UL7fKQ6qovUuBtQn3fw==
X-CSE-MsgGUID: 7AspkSNIRxm3wK+aKmxWqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,203,1787036400"; 
   d="scan'208";a="8282612"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 03:38:18 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:16 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Mon, 9 Nov 2026 03:38:16 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.34) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 9 Nov 2026 03:38:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=temCOaGAZBzHRPjdcPfjE+DpLDYPEK/kqOE9ep1+6gO5lUB5+UYRdF+UVryBjHzro//Y73BIa3foB0Dkul+ndChhImgJ4mCn2ZUgRs9Vsr7Iv7cRh3w+AfIvQJdViqUZ16cKq4bQmk9swCUOmSv4CLG4Z03MuofjpC9/x7V4j7iyjoYQfGIRTZ/QhDspR+dsc0tbXG9rLzEwvjrzR8iOwzXqIhUKyjii+jek0z43aYNCKWorHlZxrfD9h7/Did8TkkOXKYmNP0cba8++Up10Js7ONPH+sqsnjONNDUlfkKrMXJBfLCb1yEbW0k9c6c9B4hPb9TxfkAUlkqtPtr86sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fVm2RLZFSTKNEyPDbtWmjC++fH3u2Vrj/JdyXHpCu8I=;
 b=Q7T8mz443GYuqsuNJa3gWNkpp9OALIUHfc0kkWn2+JRJMbF8srx0S5F8LeICIgBhBGSFVL3Yn0AB3k0xxgUSliiNWW6AgVrXwkC7poN2QqfS0kQERs/jT5InhGE2N9XgFiDxbjS40qF+9jb4Ag63AxHtSJkDbxNZnLy/Yy5Ko2/rZjI+afMFuIivzT+PpilhV8ky5FuMgz2y8RNDDBft3C/rsWbwSmgRo5z3rgqRtsByC7WVJ66/43ghXz4wiYWNZg0snLVfK6qRnc9R1zkAx2YnymRr4B4GDPSrsA/4ElN/dO6Baw3jWqN8UVcs2qslIVEnCVUDl9GziXRi0keH3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10) by IA1PR11MB7199.namprd11.prod.outlook.com
 (2603:10b6:208:418::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 11:38:13 +0000
Received: from EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769]) by EAYPR11MB115281.namprd11.prod.outlook.com
 ([fe80::5eae:5253:53f8:c769%6]) with mapi id 15.21.0592.012; Mon, 9 Nov 2026
 11:38:12 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?UTF-8?q?Micha=C5=82=20Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>
Subject: [PATCH v8 0/6] drivers: Improve memory management for large object
 allocations when i915/shmem is used with iommu
Date: Mon, 9 Nov 2026 11:37:52 +0000
Message-ID: <20261109113758.1491891-1-krzysztof.karas@intel.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: DU2PR04CA0215.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::10) To EAYPR11MB115281.namprd11.prod.outlook.com
 (2603:10b6:303:2fa::10)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: EAYPR11MB115281:EE_|IA1PR11MB7199:EE_
X-MS-Office365-Filtering-Correlation-Id: 954e03bb-8704-4fe1-004d-08df3e55ef63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|18002099003|6133799003|10067099003|11063799006|56012099006|261028144727099003|261102123227099003|261022075727099003|261022105027099003|261021123027099003|261021121427099003|261026140227099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: jGMtOqJkSD4kkRmhmT+yhOQdY8c48iiQ1uLPj65xRAv+TeOpcVcT9G9zY7tnIkQqx6ANhEoHcdp3RedwPtDwd4java1vUHKfMQPj4q4IS4gFlG+M4NOzrKST/j+rmfE57rnJsYy6S/W/XoXubkhw8LGy9GDErLidC9DA7IJOxjhTZQyXFVF0psXwhdIwlaS6sx93N/4M/S/bCnvq1AZ5fIsRsqj3QeIVZSrs6IlGCBFx4nhviLCsuwrZflAPjjRPkFUk8Rr2bIpm4R/Hm62bMpeiMMAwQMOOOmdFY352nCRnEUJVl7kADMf+RTWnx4wFChRp6ov0al8kMJny4H4hKiLvcMXWFI+ZPpX4RxCPk38Ii2B3dv61ye+3mN2FKU5Hc2FKkbi3hm1wIOLdRDuZ/TJjJaL+Jngep1WI7wadia5FHPzhbRXvzCHTN8OIAFY9xUny8eHu0EcViEulO4wTtagqdc+5BgJKM1IiYgbQcmm856S5egeSyoE6YLpQIzC9Ff3PJs8JDMgLQ8A6isIeoqFbitIcCc7dXb3xjip3Tfp7kPA67FGKiLD/Kz/LfgwhT9d3oQm5PvmK0NuHfb4nM0mY59fDsHUiRJNMIy6PMPGOqaBFfXup13bKS+1imxsKbwik93qb+gLuX8XitllR5yy4HfdL/ZCEKV4Y+Qa9t3s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:EAYPR11MB115281.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(18002099003)(6133799003)(10067099003)(11063799006)(56012099006)(261028144727099003)(261102123227099003)(261022075727099003)(261022105027099003)(261021123027099003)(261021121427099003)(261026140227099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1Q5eNWK9J2wxqGBoB1oP8K2idTlpNtGO41IIdPlopQEXsJu9RWH9Sv669lVn?=
 =?us-ascii?Q?YLbmjR/fQTCw57SCO6DRg6H4zN2HlRSIksUMy1qC9QyKrOyWuaIa/JX6qTfL?=
 =?us-ascii?Q?st4mVXAalauCAGsVGuS4iJjLkWuhMhz4/RCFSnbU+iQ28wwjKi8ZXTk4Y+uT?=
 =?us-ascii?Q?OSjfXsR1WrRqNaHm08HZ5wwiTWAsOMyy5od2czT95bXR7f5X34pQrnJzIGHl?=
 =?us-ascii?Q?93NuyphA6XrY+F0UmuWnRCHFOuudpb/x9PbGzLVJMJ+vBejczD3qvfwvPvvq?=
 =?us-ascii?Q?GvRasYH5qHZGiPO5FwYOCrSA0x72bZQCg+BMPF7CUVIaH27dJfu3P8wHmk10?=
 =?us-ascii?Q?3I93mC5nlAhlT4m8V7zSzm6CUsjYlcg7tSD7Q0Ff0Q7C51RpAR2/RpYPnoOK?=
 =?us-ascii?Q?KxpPNLtKP0zDhw9ejbiD8OsyQ7e3HpwxzAqS8VPBwj1KbzZihWkLo8Ay/QxO?=
 =?us-ascii?Q?HnjxpxbXQUIlOrUH4JbR856kDe7yeimfk1hXv00carzYYb58G/+/gqnDtqSy?=
 =?us-ascii?Q?zBRpdmF3C1TM8tubBYFGLCdME6mnvqos5aRTxZRNbKtE+/2D23uK6pjIjctG?=
 =?us-ascii?Q?kAL7nSL0uYyfan1/6BpnaAmjm+O+pXUuDXRCegFNQhkPRqAFh/L9TXZ9Qg5/?=
 =?us-ascii?Q?c9dvUaHZcjkQsNYewUUi9dGJKvwDP52g0NfhSEUjRYsDJvrGQwtRKot2l5M/?=
 =?us-ascii?Q?af/iBBajlYLkd96HyfbUGyWOGZxZu6HQvizFD5xPbS247lpu4IL7XE4auq1W?=
 =?us-ascii?Q?9nztYj4cM8aWi40VocAmz/x4FPRRo5vuu3NPw2DQsNnCBJUHEPyhOHXEUbTU?=
 =?us-ascii?Q?Wx7G/Rsw6IpUN5zpRXngPM3WrY90pHqo/a+F9C7kANicRoN5l5d1tKeYjGmn?=
 =?us-ascii?Q?0nIFJsKX+OF8ORZ1D+2sy5hXkX3jUgI2qJqB4cK0wrcQr7E/4PrOGRcvUpf4?=
 =?us-ascii?Q?J6tZ56BC52QoF95F8vLNKoEP2FS/Vyp96rsstzZTz9/+UFQo/4VY1z4Sf8Sv?=
 =?us-ascii?Q?Wc6CcohskWrE7TsR8M2uvYBMQRWlQZk8Mhf1s7dBZofbCcAIg3Q0o8GTpdUx?=
 =?us-ascii?Q?8ua55ytu0d0fdrWd9wmAefGlwRsymW/wgGcmy/djq6XfOXSaZu+p2SdbrwRz?=
 =?us-ascii?Q?3opn5m3FKNkQ857ccihzIS1NTJLIiUS3a2lUEQwkogr+Xbt8pxe6wzy0Z1t1?=
 =?us-ascii?Q?ETsTnFyJe4mRtTYq+lx7YCbafo4z4myyFKdqf4yZlbjSBjSYlYu2X8wizhze?=
 =?us-ascii?Q?fwFhf4xq/VDbmJfal1s+zwtUG3+bGQXv1YxMLLUs8PoicTeSOx097D+ynBH9?=
 =?us-ascii?Q?8mw5zgK4Jhpuzd4arF5dDyVLRZZpCcblouRAm9fnzvypwSG/jJF87CVZBbqX?=
 =?us-ascii?Q?O5AbPKZIBURtNnsPUVIjK+kwR2E6OTKmxm4mb9fLSEosUzB1Y1bgsLlSgYyt?=
 =?us-ascii?Q?+ECMP0MJ87HTwe15iDRL+gstQGDUBKLSLv3GqaZt5KnVfo/fM38FY+eZXLs/?=
 =?us-ascii?Q?mTvfVUe/fAlYykNuuyACn7/fgs0DRMguu8uB7+kdb8rlfqAXaXmJGgQAtNWc?=
 =?us-ascii?Q?4aDLNkLIEhDtUApxBYuRlvxL6CA5MCDugM7vpmixJwVOBXtH8awapq5s2XsM?=
 =?us-ascii?Q?zCo/yA86dTtbQR2Jl0zNpkkGxzJHHc+QiSymY1kP8BVlmH8F6kvdC96OVohM?=
 =?us-ascii?Q?2cJA5Wsxz65t/SGn1QQwY/XrpcyRUPwBz8XYOvjaYclgr6jHqLL+4/J0s5x+?=
 =?us-ascii?Q?vory9j1F0Kf7ncRvAOkDlGFwLfIaNN4=3D?=
X-Exchange-RoutingPolicyChecked: DzjV2HJ7XlaHTwXcOvz/SWFSqtNvvx2sSeapUQhT6AK922I0JFQQKkWkFETYm0cgv2PVW5rKKCTr4sPpjfBfL9itmjV1YVz+0fLGPsjUGHbq4kW3Fg9XRWudh/No1JchIeKml7bf30/E7VfV6HsQyqvTycJlnUbpHIdcDO8qF5Kl5bcANYyC2GH7A4owHNPvRPnqw9ANjfJ+uSdS0UDZ5MQeM0+vUBuuph+JUcy59zteuhAi81DVbc4sx/7R3p8lFCT5/zuQX6MOCVhXrXp2oQThfcOV4/NWWxJIop9XU+boccI53IozvXSpQ8sy4d6Nq8QJcryafSCKnHZ3NfFtgQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 954e03bb-8704-4fe1-004d-08df3e55ef63
X-MS-Exchange-CrossTenant-AuthSource: EAYPR11MB115281.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 11:38:12.1565 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3VLol/7LPwhLoIFyubhxlQFypDiwA/uTDa1x5nRqdi6wx+LZ7D0q7uCIrDxAlPkHSvRiwpFXBEY89jVFYjxMeQnwzlqQ4Dwd/cm20lU5+CM=
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

It was observed that allocating large objects via i915 driver
(igt-gpu-tools/tests/gem_exec_big/single) the folios and their
pages were not handled properly leading to buffer corruptions
during relocations.
Furthermore, using iommu driver in this context would leave
residual mappings in memory that could not be released, hogging
available RAM even after the process ended.

v8:
 * Removed Assisted-by: LLM tags.

Krzysztof Karas (6):
  drm/i915/shmem: Validate max_segment
  drm/i915/gem: Count mapped pages in a folio
  drm/i915/gem: Free sg table on failure to acquire second folio
  drm/i915/gem: Pull out size validation into a separate function
  drm/i915/gem: Read and shrink memory in a separate function
  drm/i915/gem: Remove iterator and use while loop

 drivers/gpu/drm/i915/gem/i915_gem_shmem.c | 163 ++++++++++++++--------
 1 file changed, 101 insertions(+), 62 deletions(-)

-- 
2.34.1

