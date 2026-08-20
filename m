Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 720CEC5DF89
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:41:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B8E6610F07A;
	Thu, 20 Aug 2026 14:41:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="nUaIBOP/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A59CD10F06F;
 Thu, 20 Aug 2026 14:41:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787236891; x=1818772891;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=aJySJG9ntkf1S5z2TNh1rW9503EYst93xfRSu97uXOo=;
 b=nUaIBOP/6rhAyKPVjVL435g6BVzbZfED4mmOTOy+mtQAEa36ueKniMOM
 X9NnCvrZ814k8lvXv5fmI4C7WHvhutnQ9opTvtRBbUziyyPFK1+Kgy8i/
 H10Z1bnD7cFh6VvS5DPvTxbjlkj+GmKrfJVvjwDcIotKMrMH9rZ+AZNVK
 6Vqo5QHO6IxuQLjFwGWUU+zqfy7zMwfWYC+WOo0+8g4zt99GjlGN8tx23
 +goehECKcqo9iSvHdU3/T6JnhXl26aWS3XbSYeyJ4KtTsMmh7kY9gxIp2
 yX2NCqoKkpANGoR97gjNgZPZ4WLAwt03bwHbiQPkzeoOvWaJjvm4XZXWH Q==;
X-CSE-ConnectionGUID: ojDsTLD6SXizvBKwNlD46A==
X-CSE-MsgGUID: TEdimkTvTSu25YD2/GvxTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="86889569"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="86889569"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:41:30 -0700
X-CSE-ConnectionGUID: bJshRB0rQRm8ZNUugGC/DQ==
X-CSE-MsgGUID: JepQuQnFSQWoWh31GXKxDA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="266674802"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:41:30 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 07:41:29 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 07:41:29 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 07:41:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P4wBJoVNtM7+caOdsXUpW+B5Fdyd5EeeUB5vECEWjolTzHnpIM7Z8xqSpkpms2VeXiYb2/ZlgOpkhC4IkTMpq2suoH17itWB1jEbYwa4yAY66WgeorpMMjxJVUbBQF6epKD4+zSax5sRAv21pwTuaMe1nQ8ZNqTXVDWaw3ZI7mWU6r5LurMp3DHZi0Q85IRCFxNSVVPAAN8wT279kwolGLoSqriszM4qm22dW+LaROiiwbgw42hkOPtT/ksRmlZ1bFhpvUFMfY+On9fzsV82g7yhnCd380dSbanS8QQhZHl7YzWJkpJYwI1EstMdW7hgqcr+LHAjTtG9HoIAP02LbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jrlD9oDgVEcKODRoSa03E91xuoro7pRIjCIdekK/4UE=;
 b=vYYR4DrVi2vrcYvc+IIHFR30jf8AWq81oAtu269QXo7F68bJ3rD3Qjc2NKNCXC/PMHNvfFFvPMxfwYEuKTlP6Lgr0r8UNMVMuXQnXT1Gi7LWlzSPjuJy6CFdXbYchGfQbHXWCybsICaX1skyJL8fCxp0nWoX42elxvQb1JLBnT1yeht4ekLyo0NqLJ90nytfqxfWHAGFQAMrHSeji5sMuauRcXFVLMDwG+pJT+l2RGEGDQ++FR+0wcUlAscvDXKmnysd9xHD/caqnmz7COFfcRTMpNJWGG+bt1nX7/RGn/ZHIV0AnJ4vnHRNbs8cEayPrBcYiDJaitdemPC9fJcr1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by BL1PR11MB5272.namprd11.prod.outlook.com (2603:10b6:208:30a::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 14:41:21 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:41:21 +0000
Date: Thu, 20 Aug 2026 10:41:15 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Matthew Brost <matthew.brost@intel.com>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>, "Oded
 Gabbay" <ogabbay@kernel.org>, <dri-devel@lists.freedesktop.org>,
 <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <dim-tools@lists.freedesktop.org>
Subject: [PULL] drm-xe-next-fixes
Message-ID: <aocSC19By5UIIbTZ@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0180.namprd03.prod.outlook.com
 (2603:10b6:a03:338::35) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|BL1PR11MB5272:EE_
X-MS-Office365-Filtering-Correlation-Id: b0218c73-7e9a-4410-5752-08defec919e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: F90xdwI0rKuJkHcVmjIo5RTdCS9/oo2oT8I/9t2etxjH8Ozl7rG4/qV7Orp4QYGb29/QKxF470HUnsGZxpdSl9/ZyFG3qbN5pnGo2LsNWcfma5kjGOABOOC/csiNKCnBFDHoTpjl0b8xdnMi1v6zPDKfFR+F7w+FFNDoc1snfXJaa56QK7GZTIdjUaVeOixvIiX6TbcPbo+Ys0tDHKYYPF4tMAAVeBLtEgc7HkIiFkqeNmxaAiYHJSkxDD4bRLmVa1O5JFQ/4KIRgAKwwSfUGyzkjMf3ODs2wsv0XVAwVMips/9Zun/xHSWYk8Qhk0n/rTXHPMP5cZ9eGmzQkvE5voaMPUCr5TSrwpPdsv9DKAFAOmA3pLA3ZUZ+CWiifzHjC4WI1BCdDVaK4+4vkdnaZCQgdpidcjjvSdr/4/jU2KVLhjzZpO2V9+HHhA0yWVpjhSKdMOx+gaeTdVOZJcKBGgDN3hCN9pb/qv/w9YSbp5MZyRHbRtBksIWk2HwDSk3ILhyNwEe2scc7UAO4zhmpTBbsDGJsWXJtEsRLSPxepKgPJz81tNVjPwc+LgUp5ieyHyc8x57JfFZHp+/K+229/dwY9vG3FCkqwBNcyNTLWWc/cWuPcWiDXjdtK5/N4o+t
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7752.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LP9Qn4dIlZ5UBNYYAGt0BSp4rloTIf4RoCNGI1lG/M8j8P9SFmCDvHv+3GY3?=
 =?us-ascii?Q?Sea48IrpI0N8uGNtG3cVYuCPuJ+2CxUHABWZhCC0Og50qb6rYuN50Lrwarh+?=
 =?us-ascii?Q?SymZ82ee5jVkWUnFKP/DCehT+jFWxoqWkHFmaKm1sfKWF8Zq7s4H/EZF/YiU?=
 =?us-ascii?Q?HKAWcsbtbV7O8zFUE2kP2HbSuufu4D0IyUogiXTSgXuXCQysEkmbb6rl6dsW?=
 =?us-ascii?Q?0dozMjxCKX7TsU1jiFFjuRhzJfCk4LohbGXVWrmvyYoPgoL2aVJiEAWiTr2E?=
 =?us-ascii?Q?UQMkiHn/qXJWBFTjBzzxC+Xrm3Auy3s/6+TdDaaQFoQRuyy/AcLlTsIXrUXd?=
 =?us-ascii?Q?nY5Nbkl5uao7Epd5k2MCS47Ho12JC6Yhcgk4jvacpluJEfnOsPdXwoJHZUN1?=
 =?us-ascii?Q?dEj3nP/Q06OzhRjaHEQjp9L0Yc3Zwcnkcpi/LUQXQqSp54SPV9VxqxFRWw/I?=
 =?us-ascii?Q?gQgQjJlqbN1iBY2d16CJShewMsnlPF2xtYbpVeA4Et4EdKNSnlp6/62xofgu?=
 =?us-ascii?Q?tcE1z6kyBJDYR91K5IWppmPxT/YXzvHZnrJD85qXopqxSL4MAKK6XCWLVtBq?=
 =?us-ascii?Q?y4isBu2yFAlvsW09saZ8KZYAt2BsROR/viPcj8wfT73rCagDqhcPrXAev+XA?=
 =?us-ascii?Q?AbzlQ8hkFMR8FGX3R+nYhdLUs6HRVXKVdYaIw2ND2MFX0w+TZ1RI132l6L8T?=
 =?us-ascii?Q?nsFE5eTz6IXgWnxPU5x3Wq6ZZ/7jFErzIDhSW2KEI9fVlpcgNvw0htrnIiZc?=
 =?us-ascii?Q?HcHFiqj8BT9quHzHR+0qBmXZx1it85rGNX9PzcJGxj2O0HjNvPW5+4RdzAS2?=
 =?us-ascii?Q?oAWhfzZdvQtLkkgyeXmp8yyhB+LtanYbsI5Z/qDsPqW3qjukqtCJPNCt0b18?=
 =?us-ascii?Q?A9Gfr/m8PGndeT2G03zIwO3SWKVWx+ba8GI2snISF0CxH29C0V3jtYoIiT03?=
 =?us-ascii?Q?pKdyflV+tKe2I6MrfB2zUHMhlTAFWx0CH5r5Hm5CJl+N3QwR+v+qOo6nI39z?=
 =?us-ascii?Q?sG+zhAeuenGz9xKtBn2RdQTT6N+2Rl4/cQclzcM9AMBG6Cl3JFfFKG5nvu7k?=
 =?us-ascii?Q?J2oHkkznxNLU0sIHMJrbi6iZzEIePPx/JCSG/bePzQEIoD+9zqVxuSxjDnnu?=
 =?us-ascii?Q?MWFemi44LzcYyiRMxTdmOlSBC1/KN4nI16gTJ6G1SUrn23V9K7//afCQ9QI7?=
 =?us-ascii?Q?BgJPf9y8EML/bctLQFbLMS6DS2Y5Rl2fhxSrxNjSl5gmYmmUgfpJptSbD7aL?=
 =?us-ascii?Q?1zUYxn9c/ucCiKhf3l6FfEk2pcrOJAY4zNPwzm8sz045wFMg4BS1/AMYBZYl?=
 =?us-ascii?Q?fdrgUyCOkf9tQAiw1EGRFGoeMdb0rSBtPnXbvjOGb3TInRDaEpgb9wNNi/VJ?=
 =?us-ascii?Q?C9/BzFRzDD4mZlF8r7Rigo8UaTnFc312dji3u9DWYG9GYv9JQliS5pmub1JS?=
 =?us-ascii?Q?34T6P4uX2QmjHEEksvh03e0KQzc1ndO2GozuKfQ+yZJocuy9mtyXft+wECeI?=
 =?us-ascii?Q?WW+ovIDA8i3EM92j18Lc7OMo14uTNooQYidrbMj3uUByeCTK8yJKMG1BffIs?=
 =?us-ascii?Q?5H8GEb1L41XeHmkEei0GJV/ERFoB5kfXh7xFN0ZCOyxipoy6hKTWf0lW6oCA?=
 =?us-ascii?Q?N9ThFMpnoquieldpXbgb+YpBd3gE1Y58NtAuuxogMw3E4TyZJpX+M0JpkGMM?=
 =?us-ascii?Q?df0iIL8VlPihyFYC1y6Bd/0VTVtjbWeaFVM8WNhDcoJnVX7SnYv8m5wh42Wu?=
 =?us-ascii?Q?yszIgp+26w=3D=3D?=
X-Exchange-RoutingPolicyChecked: GdfO4oF/j2ItJGd7gfb/OedNBnsW1hGl9daFs0FPBdPGvyrWvuXR3uNyFI74XvV3tetDfoSyv+iOc/rPcKWbxturb2mqyk49U6sxHdxsOKL1rNcmvAR27Voxx56n2yus1oiHEUXtMUSiZrkl+ly860N/kQlwaW6Zwzn8I5ZmpoQ55j72DCHa0TYHw7mD8OGFzET2Sbns3rc8GbP7rrriNgimVyTJ4eI4Am1jqyqYEf0fV4NEwDYmIma+QRIliyvDuXslbUyozF3mUE3TVnZR9+JL4HPfxArsRO6TTKna0OCAztEL2pwwgBD8ZVdRBDJ6sHyCd30lJ1sO1LKevb9vVQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: b0218c73-7e9a-4410-5752-08defec919e9
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:41:21.2499 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gk5FCDvOPYlNcz0T7XlFyaIggApB6YRrGnWbUsMAEVwSnvdwoadDKIj+d0mvihz077e35pzv2heMwb9kMZGSGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5272
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

Hi Dave and Sima,

Here goes our drm-xe-next-fixes for this week.

Thanks,
Rodrigo.

drm-xe-next-fixes-2026-08-20:
Couple commits cleaning up error messages.
The following changes since commit 65b92bc671db7c222f8de1146c88e40fe8764d95:

  Merge tag 'drm-xe-next-fixes-2026-08-13' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2026-08-14 18:30:33 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-fixes-2026-08-20

for you to fetch changes up to 13087ad7817e6e5f210064518bfc4d6d58a9c2f3:

  drm/xe: don't WARN on kernel job timeout when device already wedged (2026-08-20 09:30:03 -0400)

----------------------------------------------------------------
Couple commits cleaning up error messages.

----------------------------------------------------------------
Dan Carpenter (1):
      drm/xe: tests: fix error message in xe_migrate_sanity_test()

Nitin Gote (1):
      drm/xe: don't WARN on kernel job timeout when device already wedged

 drivers/gpu/drm/xe/tests/xe_migrate.c | 3 +--
 drivers/gpu/drm/xe/xe_guc_submit.c    | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)
