Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E9D606A321
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 23:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=k37PdxAb;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=NCYvbSJl
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E856710E1D6;
	Mon, 23 Nov 2026 23:34:00 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E7D4010E1C6;
 Mon, 23 Nov 2026 23:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795476831; x=1827012831;
 h=from:to:cc:subject:date:message-id:
 content-transfer-encoding:mime-version;
 bh=swah9we7B0wfa4ovW2U03LvDJE+7s4vkvrnJjqeCfnQ=;
 b=k37PdxAbAvtYnCYMCcR4OPjoNHUSgDrm14dAd7KBo8UYPm9MkZN93xzq
 iLLTHxNEaC7gfGgAZlkLQhNTDbwX3tKIoAEf0/KPibZguxOZMTjjdcI9s
 hpZfwSF8QFOrf0kESx5Atcj8Xy7Zj8FjTdPnU2r/lSZZSb3vV7r/9Vt8b
 Ok/peKofEPK+QT2R4OK8+M02YWZXWE6yPd2keqYg+iv5oQjC6bguJlGoP
 saIyD35ikoljQRh50EvSFFrkjUIyy8qXq7aIwRORxdZFdn/1MTEgo7y7/
 151w67VZgCEWmhVJhwmcKaeaW+Wjuk1lDWzjQsg82yJm9juOmrBe+NOYg Q==;
X-CSE-ConnectionGUID: grt6ZqGwTUW7ZOjqPjutqg==
X-CSE-MsgGUID: Zhrf2+b+QPyEzbSe+Ns7wg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4328574"
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; 
   d="scan'208";a="4328574"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:33:49 -0800
X-CSE-ConnectionGUID: ot9Mfq2FR3WevqWaJ3+H4g==
X-CSE-MsgGUID: DSlMVfH/Qwicp3cCig2YNw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,229,1787036400"; d="scan'208";a="11762456"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 15:33:49 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 15:33:48 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 15:33:48 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.27) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 15:33:47 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AseFwpqkVYJdLI6D5/UL2H32CeQlwBTMgoymcqCeY9HBU9GzAy9cXPyK7gksDz4acwI+pT4b2jtcsxyUA6oroTW/pupA4nhu33J8zWQqQizpCGGnsHzDXeuQRXR/BWHUPJUGM0i5GTJN5qjxORC3Vyxmq84UI1wjCYBdc+/fP43yb0GEAu8lwrQhrCj0yOuY3In9Le966yGYUolp4CahTjFzf0ABesMvmO4mtTXGzeIoJYkg0sMAXCmGnx7pn2ZOlCOTwNpHHnqBO2JEcCUhdGhLwWJFyUlkZOY5w/z/nLxJK7Ve5nOxqBPod26Frkb2yOya+aNaPrhSaT3bqDhbyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=35Zp0IxkzlAXmG32b3YBxFMQytZ6WoB+GOqAefIDeUA=;
 b=gA5tgvYN5USpCQU1yiAQOi+YqMipdSpymqOMtKUhyYisSZvnEt+/FCr0ySZdGw6KCBSf1sjMVwjQgtSHZ7rVKPbkTrHSFvZfp1OASK3Y8TTlogtnqNj3hvIxe5VGBCfrbY6cz1rXhDRADpA+BVZ9nygkHxnf39J2QZV2f0YoHLLh5dMBt7xy17cLN2DPhL5+/0EKkZdirouVGOsMLJrI3k0KgXIQHYXLZqn6fE5yBBpTKqsZbaJr+6tnrd1gmbj+zY//VjIfsc9SavbJ6dajsm5to0KezXG9p8edxfqMaLPbTThszLsE8EOr2UCesTmmKIQPWNzHwcjbO69ovo6q4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=35Zp0IxkzlAXmG32b3YBxFMQytZ6WoB+GOqAefIDeUA=;
 b=NCYvbSJl1dzhq99JzGgKxe2PkNaQ8/Arq13V0Rc2hMv50D0giheUMqRaIHsda/vOpjaqFluJ7V1gdg5YZzFBPv5aw61SheUVyy8EGTk+IfwMm1KTVSWvHxJrls3s/kcWEfDsVb/fSiYRFvh2ubAieKHZ5bSjH3V1Hn/5FSBPHew=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 IA1PR11MB6516.namprd11.prod.outlook.com (2603:10b6:208:3a0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 23:33:39 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Mon, 23 Nov 2026
 23:33:39 +0000
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: [PATCH 0/3] drm/ras: core fixes
Date: Mon, 23 Nov 2026 18:33:26 -0500
Message-ID: <20261123233326.2882114-5-rodrigo.vivi@intel.com>
X-Mailer: git-send-email 2.56.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:39a::26) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|IA1PR11MB6516:EE_
X-MS-Office365-Filtering-Correlation-Id: 7ef65639-7df5-4ad4-ccd2-08df49ba3394
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|11063799006|56012099006|261022075727099003|261021121427099003|261021123027099003|261026121527099003|261026140227099003|261009223027099003|261022105027099003|261102123227099003|261028144727099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: ovq/hlLBN50azmrplfrECR9fMMcvTUu49IXttbVpLvQcJqqZvtHuikCbgLWkjOf4091VGLUu0KNfQbsrijwRl8kla1mAbsF7JAj2VjuKJKUI+epIt9FM+tq83z44YOLke6vtMPaGLDDskzonuOjd4KSyBiS06BJDe1TpD8qPwXEkvwBYGMpIIrG6pmcGnpgMOcvWq+Ul/ZE28zv8bynBg+jfksXowx8lpT6TyqoBZn+XsiLa8JvGmx3YposDzRI2HS/c2HBukn6ZAqLG6oDGArL81UPG02FPBKvLoJTgeSY/WsncgeehfNXI1k4/tpK9YbnQOKdtjIFTdgNg2QNVxDJ1yg468dZRabGsY9XGZXgXDlxhT6qTiJjCQTW/AY1hZPQuLn16j2jcv453BnZNp94rK+pEoYiLFSmJVRIRAs6aj92g3sQCwldHxZLprx7cwzCEe1zsaQFJWAG0MX5uP6NiDDUGOlfRppDVy0kgIFAEO6jWrY+FEuPuLT1Ruy1vgi5BlnD7cgTuD/Qzbn0DK/6Q6gJLYyQcIbBHm5tkShBx4T6QKbonCUQD6Hz18YN4PkTVGEyEynvOPUsf69clga38Jxkuh+dhfvyLqQZNNqTENsZE6bAL/4LZn3ZfLZ2laOYaAy4vpyJ2TRvUCM4pGVEPgoXfLOl65k3Dowg3FvU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(261022075727099003)(261021121427099003)(261021123027099003)(261026121527099003)(261026140227099003)(261009223027099003)(261022105027099003)(261102123227099003)(261028144727099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?jCMLuztyorP3pFyS1DQyxFwMu9hiqReYEVlrz6lPVyG8arS5GOF11XElpm8/?=
 =?us-ascii?Q?HR/1BlRamQwq9aoh6k6k/xCKtrSFaf94hWpJmuuoL04QivPAlnqx7r9hR5Ob?=
 =?us-ascii?Q?CbCND8WDs0T1EgAJk+bBiyO/tc1eQH8MycC9BEDoUchvz40KvMqHiDOl0WWc?=
 =?us-ascii?Q?TnQIcMx9XEm4huTy4A8IfroSQn971wiZ1H1wIqNgjnaPGsHkJNQ1gk9CZ7Pr?=
 =?us-ascii?Q?f+utqoo5+Fj8hThfe/l6MMXA9n/NAJ2+2smLPeEAIXfk04MFu+oiTjnd7FnD?=
 =?us-ascii?Q?QEHjOjjgzZyvyzZoMzQ3kZPozVFPT9IWSDPP1xuvVgpH7gJlJHcGkB3C9979?=
 =?us-ascii?Q?nuoUKkIGRTqQnj1DH0VOs1P7HwKGruRz1RNRDtv0ppb9I7Cr6nXSBkHWVn/c?=
 =?us-ascii?Q?MiBolPrItVvi4BJWq8EL7htyUiDQHFw2G59iXZdEVJ8h3xxEx97JqfzNUFrP?=
 =?us-ascii?Q?EQllX8P8whow5xca8OjXNYvFORynWqDbr1fKdYwqjiLO2qRSddXab+Ell28A?=
 =?us-ascii?Q?PB0rX6qQK4dNviG4NjUiAJxsuwUe6j3WcCNifLZV00tV6wKRVuQhWfQLGJCT?=
 =?us-ascii?Q?3DBj1wSQ0fRs/HmyPqf1emeJhP8rPj6cM/X70O8l2FjXj4I1QI1vBO4Z38mG?=
 =?us-ascii?Q?qVbbSvRwlDaWFa52ahl01p5DJvWacCVxsgITL3CKYPhht6RIGHMvG7Sfd8Jj?=
 =?us-ascii?Q?qiq9acSnMlO6t7ksi8AYsDN8wgorfPVluoz9kqRnnKlZruqto7q4hG2MEFpB?=
 =?us-ascii?Q?iNu9mMT5TCy1bSIrd1kr3yuRu6hGitKjM6L/DQd4ibWS/CsbQ8QIFd8nxeVt?=
 =?us-ascii?Q?LHqz5TtEaQ273gSMbSMqW9B/vvG6+L6ZMPywFTXrItqmIFpLtkqymJwYyou0?=
 =?us-ascii?Q?fq2PHs/DrNGe6L7G7CCBykYPz+19JheunvvdHXWyiyrzRaSy0jBo4WdzWbI8?=
 =?us-ascii?Q?3uMlrc+p4o216POS3LmWO7WOgSWY27Sy7jKx6rS50FxaVO1gxZtlSfziiCUT?=
 =?us-ascii?Q?PNpcKsFhJg4WCLuzMEWN7g7J5elO8MFzOHFcBFdzjoZk+FKZ4fBIZCxroAJs?=
 =?us-ascii?Q?vPuUp5ldEmvVZ/1fjdptSqed7MndStiPAn2y8Y/S57B5StE0t4P4WoA+dFzm?=
 =?us-ascii?Q?J2zdklAUgdXW1oyVJG8/lmCsRlkwa7yuRwMSrTS+U9fsr6Fqv9kgkmbScrfY?=
 =?us-ascii?Q?VreqLd0VaHqoowvC3Kceou9cMLjHCHK+2fhFG8/8qT6+nBAcEp168BlNpCGP?=
 =?us-ascii?Q?FHL/dGH7XpjfkvMThtmyMg2Rh0QSSY8u5H7iDe1+aK2Xwv12xohs77dlmVQW?=
 =?us-ascii?Q?KpWi5/ZijJ0b394pmgqE6vlMaF4Ls+b6ugSJHrMpECLNyy1g2fzXnNrA09To?=
 =?us-ascii?Q?IM7j3M2/GHiVTCfJth0BU7nGZENvE7Vpd/01BYfmb/f91T2cWq//D2huurL/?=
 =?us-ascii?Q?npIr8g/dTEwZ8Sie+/K9MusPkSo8P2opHje4PQ7mzSJ/tFeQsF9RoxZy+4Zm?=
 =?us-ascii?Q?keI+3+JC3QEpJcD2BwXapXj4Q7AtMQNjqvj6UjpY7BispztzvryaMTXnnSsW?=
 =?us-ascii?Q?GBd0tK2qv55vM5BgxiSRxu2hxRHn1JdxZKOAOe7ASYTHZ6IgiYN2R7qkRMM8?=
 =?us-ascii?Q?JKaQI6RlwqFtJCm6F4ngu7vqp+dUJtapqQos15iYwAmBLyH6Cwrt5aijsuGf?=
 =?us-ascii?Q?bdIbwn+i2bZs4LNUmmSBCQAHsrYQ8pFzOb/Dr10rYQk1ShFcC20bTHewUp96?=
 =?us-ascii?Q?VB8FHeG8xg=3D=3D?=
X-Exchange-RoutingPolicyChecked: nvuJCjbAyL9n9dXLJse4ipwN2b9UJJiyYgqgc1grUHoP/D5yQ0LEB19xxevgsruiAI8h/Q4IlsO6psSAz+oiexmnjjwAgCF2+rxO+0vjmhVfELhOj9teD3xPYe+pcbeE76ZfpjO8wVGaE9C2ArOIuVKZdBXv/fFDvi9nj+u3+O1oYI3KWccrVdprNe2P96vHH1pkc15xzcvq1dcPzN1nvHfYagIQbTm+JBR3rs9L9OhPSjNcrMwmf2UKBgN6o29NQZFGYnzaa/VkoSwo6ieCh769NSUJj3rHQNwwsF/Oz1ZN7z2V/e71KWWHN3uSyXGwUGl+sQsGKbfRNOZ8dujs9A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ef65639-7df5-4ad4-ccd2-08df49ba3394
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 23:33:38.9635 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8weZAT/z7DPCqQ3TySUFbcVxOWjkXw+kce0wyqq/nrAHOFKzn6G6ZUdcWMXNU3x/RqGlevLgJXGa9r5+iP0xRA==
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

Rodrigo Vivi (3):
  drm/ras: Initialize ret in the list-nodes dump
  drm/ras: Do not fail an error-counter dump on a skipped last ID
  drm/ras: Keep nodes alive while netlink operations use them

 drivers/gpu/drm/drm_ras.c | 68 +++++++++++++++++++++++++++++++--------
 include/drm/drm_ras.h     |  8 +++++
 2 files changed, 62 insertions(+), 14 deletions(-)

-- 
2.56.0

