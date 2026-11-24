Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7286606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 01:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=XeO3w9Yw;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=YEokXV6K
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1EDFF10F2D9;
	Tue, 24 Nov 2026 01:51:06 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CF2F10F2C2;
 Tue, 24 Nov 2026 01:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795485050; x=1827021050;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=YM7kH4eKodEa+WimuASQ/v6LvdnLIsPSj2G/vEEsbxc=;
 b=XeO3w9YwCtOJj1ztzDcSWhyKmGQaWrCvl06QsndXbd4HL1NeW/tiPwUK
 VfpmYKh6E6Go1WEcPXDRi+pmOkAQ5yShGaySPDkUajl2chOevKsJExYnL
 /yn0PSzdfckwba3rrV1Gmq4+WPfl2T7zWt3aA19yBrhi/opcvXWES5gF2
 dqtrRwGWXyA6kyCDEHETgiGXJqHdWxl0K2tD/pA4PjLACnJlJl1kwbpEr
 xeoYXdp2o8IBzrhXaRcPS6ekGafcoQGYQJOU93udgwI2gOn07MGkMawdR
 Bl/rApzm/rzFxvJnHsa4D+ppwEBLVPJOYnfrB/MwwwFK0eP0BbIbmp4b6 g==;
X-CSE-ConnectionGUID: sPZQ7uU0QweNxEGzVbanKg==
X-CSE-MsgGUID: 0gUO/KqOQhCE36scmjHwJg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4360265"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4360265"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 17:50:48 -0800
X-CSE-ConnectionGUID: u9/X0UxARd+UnvmzPpdWvQ==
X-CSE-MsgGUID: qyKBE8KsQZic8W8BiEoltA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11775308"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 17:50:48 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 17:50:47 -0800
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 17:50:47 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.18)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 17:50:46 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q5GuHMk779MDK6f1waypPcdXWZA+6CngiENuhCFgJ02hh0dZ2tpdXEDL5hzqNTqoVXYU8PMbpRIfDMAmR0xF6GP6IJukhgyGj57k4O3fuGRvidar5q3d4CWv4IRBT2vu8LcFO6KaNXjWHKWR09FYJeWgh5u6M7/muIIPNzFsnkLD7UCxrXve4tsEHL3QXQd7uY50WEfK4Zxt/yLFCJXXH8j8svLG2oZdsl+osEBbxPbE1Upz+NFsu77MPzfzVLJMjV91mQ7A63xtUzk9DgE2DK03yLuM0UCxzY/Sj4yzX0CRAE5jo9WH3C2njv8O05OKmPFXQM5L0LOriUpHlUvw/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FhEYPXIe9d5r8wjfblprwjbjdfOUBM8f3f3ByZSzK9c=;
 b=OhZwxUHx7pXTxXh7Erv0nzU1NEAdM10yA04n4pZxPxy1ptjyQFwfe6YQv9iDuL0CbRjebvIvBIWj1UPi+6lvJwfpZdof/6NdDO7gdkaNXqOtBH1wPPiBkCRkhdjsKi9tRO+HaHe5CuOrd5Ce+unt/dtctmpSpXutQQPH6puDJhIRn1nxtFtILc14HDXRnJGHcYKz0Btqt7726F8pbhvTekPNWXiR4nswfJJQF0ppMXG1mqxiky5JBF1qDGQ2iBCk3hQ3GJIPdyBAdnTVyVSBF51NuK7poKfnQsHkZlK+mnx0lsAkkiceoPGrxtgyBPkCUv+NeuWivOaSzabBErk55g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FhEYPXIe9d5r8wjfblprwjbjdfOUBM8f3f3ByZSzK9c=;
 b=YEokXV6KZUo0FmwJPnFDNrP058X2sUa2u/ttfUVU9D0U49zMFd9WQbr1m6+PZfXN5iKNQpzvAfymE0pHZH/g4Wdz6YuWJNDKGlUyesYMZT1WV46KPmYU5kTRa2NAypBV1x6PkAIMBbP8dlMqFbQlvxOY4INXLggDiQDemop+0HU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 CO1PR11MB4804.namprd11.prod.outlook.com (2603:10b6:303:6f::20) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.14; Tue, 24 Nov 2026 01:50:39 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Tue, 24 Nov 2026
 01:50:39 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH v2 0/3] drm/ras: core fixes
Date: Mon, 23 Nov 2026 20:50:36 -0500
Message-ID: <20261124015035.3100218-5-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0256.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::21) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|CO1PR11MB4804:EE_
X-MS-Office365-Filtering-Correlation-Id: f6280cf7-78b1-465f-ca22-08df49cd576a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|10067099003|11063799006|56012099006|261021121427099003|261009223027099003|261022105027099003|261021123027099003|261022075727099003|261026140227099003|261028144727099003|261026121527099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: FiigwjD71M42y6T0U5iUTroiD4qT7qVE+YHjAYkFoKB3GD9y6rXWszHzOMemkl+r7cLtjPiZBgJcQ54uL0mnSGSqhCxsXVbRkN/3GU2jnv8+MBCM6TIL2/nl1VHJfPyPjX1bCgRIvCEh232ElHmz9J9455EXk/TutJ7El6BE4s+TFLcleW2cZrIcCN+QYZ6Cqg0IiTYmoEk6fuSDf0V7EitG1R3Q43ihmsujKAHfE5iZrX79hU2DuraUaVXBUcLH8JlMMuMn8Z1ey6t/Vo1zX5kmuHcvBPvKM86H4bsbfGrFJ37vlMQlK1viMhrTRsPG0if7hEUl0G1A7eQRqQZpHp2FDnJlGeXQoFmXbQkJnUHtAQIptdF7iF5tbezI5GYOJoNgUZXzvxE2Lc/awCdSxg06Mw6hmTje0p026rbeTUSzM7auuwAv/B2o1EIE4CdKF44qppv5RK3XPkrqJbHfFS7gIj8cYvjgBzEobXnPgkST93FTwtqFdhEC1fAgeygSx8d53myw5UBoYj3cwFTuAGqwfrOm+STg5oLX8A/L4ymAeGThFL9SaI6kAi+HWYxBNU5DxqSuj9QToe8ZWE0D33EXXNy0KtHXi4JoTfS6MupaQT8CTAwZVQqFXoDFd2cxkAoVCqGLPeTIBmPdHgPuC9uUURQo1mXpHbm+gxn8ifI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261022105027099003)(261021123027099003)(261022075727099003)(261026140227099003)(261028144727099003)(261026121527099003)(261102123227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+jG89nZhcVz5/xmNJ3xkV5ZmdnkvqMJ0xGyLdDtbUuPH79Paqv5TR9gm4oi+?=
 =?us-ascii?Q?284gdZer4+grwBC1aMPsi35M/D1/dudhiDjMZAk7yqrvX0crg0Co7foxhzjw?=
 =?us-ascii?Q?HtdNoPbzqRm5YB01QPq/E6R2wIEOTwAaHWYcSkmZufUlHOr69fl97aEIWJSW?=
 =?us-ascii?Q?E2lgN3OkjHLJyvVwK7t9y3D839t6TfVVQ+vzEvNdaFyxxqZTfugLQsuGRAoL?=
 =?us-ascii?Q?qebrFeHbS7i2Li+TtguWTu0DLNfpagE3AGF+EbC662JGS5qlnlMTrT3h4Bb5?=
 =?us-ascii?Q?55dKvhnCz7mE6JR+ixedAepjbgRZFkHwTh9xf2nJaT1Ja3fg7G0HTd7gBhDm?=
 =?us-ascii?Q?vna+MzRHADuy0bDjusgnZFgxJR3Ob+0F9viHjL4YQXipDNFJCs1Q7bG+nFR5?=
 =?us-ascii?Q?Rwjtt6VrLVJ08Mff6yEqoXqYhZaCSymLRp2hNbcmGAz9qHBfkE3TWerWT6r7?=
 =?us-ascii?Q?qIhwtNTsqmSHEnuST59gFm+uv5HeqC+thN4QodZ5qfXAe3Cb7XJaNDf3kW03?=
 =?us-ascii?Q?6NbNb560lOkZj0BeWwgjVO45Llbacd15F945bhzfPCRi8KiHi+3H1/tNZleS?=
 =?us-ascii?Q?LA2A0kOmKA4doWXAeUJda2QgqJgRC4JVYgF8fXSjFf6dARCMxBCTpxVuF2ac?=
 =?us-ascii?Q?eZPXfHz8Kf94jB0tAo6RqAtXrG5kN6wDZDOW7x3BxHfA1kFj8TpBuGzg/hYY?=
 =?us-ascii?Q?JFzKK1IRWZnE2ZYFAXiYhytqzNPkSkge8FTaoN2WE/KDd5L11UK3bMxAlEnX?=
 =?us-ascii?Q?8ZX2+M2oaM9Z9jl7Sy/gtIeyekvE4byfE1xnnUhDfpbOHpjI4fu3zUjraZHM?=
 =?us-ascii?Q?ONwGUE3GRtXPsg6UDO2pPCCy9YdedEr1dotLrJu7MySy0oySfq4gY1+g+elr?=
 =?us-ascii?Q?FhYxugIvboIRISkPH8ehUHT+0Tkm6PqHyBoxB8DnOnMo11W9FfgZ/KjA3laA?=
 =?us-ascii?Q?LsY3g6htAvWyc5lVg/ULUQL7Cv/HOpqfkcHSADGGUPgjOQKA2stUah7I82nz?=
 =?us-ascii?Q?Wi23DzqXXIj6PSVnMHK75ewyyqtdQOJnjNxQGGPVvKxplppWuHhlE6i3uQW0?=
 =?us-ascii?Q?IzM9ipFeNMSm8vbvqcTzDPJudGlfpu7ZLsS32/cTOP6PVRQebEsILuD8hMzW?=
 =?us-ascii?Q?6i4RvBW3Q9vQ6w8LNmwNHEqMa0TLsEkejgQYWek6czP4ke+E0+MPZx4BIVvw?=
 =?us-ascii?Q?iOVuDPspbRfeghs6O2nyVBGj2mGZJ7PUtHBBH5RH84GSZOCyiO3gG9ugvxN2?=
 =?us-ascii?Q?Q1nntqklDI0o6uPdpU/rsxJKK1w6HOd8plegM5H8OzMIsVH1i/peRbBcfeqt?=
 =?us-ascii?Q?V63Sbd2E6hdGV7Ax48jIY1a2bJNWmYOA4HzfT8C9xgL2Gy27lplHJlERoFo4?=
 =?us-ascii?Q?EWqEuyV2PAfguJpsl9B78CyTgF5Rj5LdWreekKa9Ls3v2TxSLxf9ej+tVo8s?=
 =?us-ascii?Q?zomNlJ2+EIVIwjKPxovKXLZTOb6m4ctioLD9YHy48/hobGIgsXCuBf2WjhK/?=
 =?us-ascii?Q?+X+IvEO3q26jyW40wZnVa46ajGJzbeseC1YCCZXufV1WrH/qsiYKdgHsLDRg?=
 =?us-ascii?Q?QpUg84cehKvs6oLhcb3qNbbPCHDfaE+RODqr3CRunNURt3YEsGhFtuyHN7mh?=
 =?us-ascii?Q?2xdG+ycIsTsX1BdHK/PabOSW+bJROi8iCfsUsADytvocZdjZOC4jKt5i3q2i?=
 =?us-ascii?Q?5DutYXMLJ22UrKYz447N/yKVH49FyVosOpSooAwrLGDL/WcbbExbk0/4clF4?=
 =?us-ascii?Q?f6nbbDZRsg=3D=3D?=
X-Exchange-RoutingPolicyChecked: kIWXRe0F7IKjcHmodC7+KeJmhYUtCw3A19W0a0FSoRzg6mgsDGFwtmW0IL5dXIn9vxOazTu2ujPzeygxt9yYTNsS53pdeXL4fRiKH3hIGRnyyPOGcvAFRi/EvVCae7LnooswUCygl4YDmG8Uzae9NDd6EvJ2T+Mx52CTOy9RTTcFdiaaBa0ynhqqgsI1ga9NacG8k89+3pg2c3z5kKiEG0TFOhczBfkFW/I2MfMPnE01Cl2SthOpMYcx8FWC9Jz4ohzbSr9DNoLRHpf5jCa9q4cWHyK2itGmqg1mlf1frMc2EubhOsMMZIDNe+JbD2Eg0d6Pb85Kx3o/+hzuZREbvg==
X-MS-Exchange-CrossTenant-Network-Message-Id: f6280cf7-78b1-465f-ca22-08df49cd576a
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 01:50:39.5776 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oz70ImxIp8CX09vpsFO7iG0pK8oigMchUeTtZ0RArs1XYc0t3qReh9V0CqiwecGPnl4VNb5Z3sPzj/WZIkowEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4804
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

Found while reworking the retired pages series: an uninitialized return
in the list-nodes dump, a spurious -ENOENT in the error-counter dump, and
nodes that can be freed while a netlink operation still uses them.

The retired pages series v4 builds on top of these.

v2: Patch 3 takes the node reference once per handler (Sashiko).

Rodrigo Vivi (3):
  drm/ras: Initialize ret in the list-nodes dump
  drm/ras: Do not fail an error-counter dump on a skipped last ID
  drm/ras: Keep nodes alive while netlink operations use them

 drivers/gpu/drm/drm_ras.c | 141 +++++++++++++++++++++++++++-----------
 include/drm/drm_ras.h     |   8 +++
 2 files changed, 110 insertions(+), 39 deletions(-)

-- 
2.56.0

