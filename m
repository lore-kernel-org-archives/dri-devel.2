Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE27DC982D5
	for <dri-devel@archiver.kernel.org>; Thu, 17 Sep 2026 13:16:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF76810E703;
	Thu, 17 Sep 2026 13:16:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="fpJA/fLZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2475910E437;
 Thu, 17 Sep 2026 13:16:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789651009; x=1821187009;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=MTjskH7VvqvN4ZIj/Neepk0Ppzv1064anYqIy4NnkmU=;
 b=fpJA/fLZqwlmE3wwy/1OdjI3ysbDWWaXOPwK4k/V+zhbb38/GLDehEjt
 gPkHiKMVNLHC6RU5O4QZ03mZjG+yy1rVVY6CJUgoWMwtju8uVKlFILQdQ
 fk8YgZ2LonRY+37nqrMT1WC0TILx27SlnSxFXMBW8vx7xTGjsdKlbHumo
 WErOGzOb4OP/fSPnfzFwbIwGfziC4ZyZxVd+HnsaAqUhNFZmgw+fRHWTg
 tEOBKS2Cruy3Atw67X5PMIJ/6bDYGQdHsNef/uB/cq6PhWzOro13CymB+
 OLHIZhetOlNQJ890wlby1NzME2OnARD0bMLj9w2yTzTSrrW5YrJPNQTPF Q==;
X-CSE-ConnectionGUID: fW2GzjgxQMeQNwZ2lY6KEQ==
X-CSE-MsgGUID: QQv/QANST4SGZY0w1upFtw==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="89934528"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="89934528"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 06:16:49 -0700
X-CSE-ConnectionGUID: HqqFt2dxRT+6zeuquhRXJg==
X-CSE-MsgGUID: iCXJmnB/Q5SvMQFBDC5RVg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="1957855"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Sep 2026 06:16:49 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 06:16:47 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 17 Sep 2026 06:16:47 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.0) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 17 Sep 2026 06:16:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WydMwfNAPSwUAMQE7ps+7i5jV6d4x3g1x4UzamwHLgrjMRLcRePPbOkqB0Fnd7Lzf4YKO+s+Tv+G9CDLepRa0lGewArOvUgdlr0Bkuc1GX/YbM82i7o8G9oqyCbAx19JB5tMH05Xm/AAFZmPVqUaQCXYxS1ek9IvBOjfjNhz6OrX3zV/Tl07tyX6DAHI11C9i3z0PUX6rKK74abd/6dCIgZGFxTLGERg3JNCVY2zi93jMpKghMUCkgYnRN+W3hQc9rDXh7xuF8wM8rftWPeJwAylAddgzF4gxFc7M9/Xauzes4nL5K366m66kpocSIZwe23CEb6vYjOD5CQ4Ta0Mng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P20bpUVyCvXJMxaA1T1rEurPT1OMpaXUSK6Dqd1WUM4=;
 b=add1uPSJnJzWvZBvVcsY+A6oq9QDNW3JT5cAQAoUcRPkrZZ19Py6QIfarCoe+MbEbZjOOa7H42AowmwWvZiIwv7n0e/5W+jqhYpLYZG2XZ7U5mszX5DwAdck8DS8BIl4U67DJcI3fNa8nUFHRSQ06dIHPCGkhAKz6WIbmZD6YdP8H4Vr9Emr+TGDxxSpMDM6oC2KuQLSi2gf9jB3EzLUuuzlxQzbRZHvGx/+0FSJjSeOkVjqWHXepuE3kzk207Bjf5qqAAHjV/UCdj38hKg0EXYip+LPHYAojtE883ez1QWHp0x3l1VLyJBsiJrmBOtfPd6AxqQnL8/PWwlY9ZhxGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by PH3PPFD6B8A798D.namprd11.prod.outlook.com (2603:10b6:518:1::d51)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Thu, 17 Sep
 2026 13:16:42 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0406.007; Thu, 17 Sep 2026
 13:16:42 +0000
Date: Thu, 17 Sep 2026 09:16:25 -0400
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
Subject: [PULL] drm-xe-fixes
Message-ID: <aqvoKaPuLLPBGayA@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SI1PR02CA0054.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::13) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|PH3PPFD6B8A798D:EE_
X-MS-Office365-Filtering-Correlation-Id: f186d457-3625-4d20-ed36-08df14bdea08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|1800799024|366016|376014|23010399003|56012099006|11063799006|18002099003|10067099003;
X-Microsoft-Antispam-Message-Info: Av54fuiSGYfmhGamyzpshlM3UB6nxIoIkaOz2MlMhyDBL+Jq2JNFtm5H3jG1DSx6HJtfXXEdlMeswASEuNTmdvRlDQI7HVv4SMO/popWwaMJjoBZtoRqHojjde+FqiRig2Zlupxa6hxCvEVFm9RAV9azOjJeY47F1AA1jnb1L0ng854GKyG4nt0D9AKGnaSnRU4DRp/7R4/C0v0jJ0uXWP8J+bNwUdQb99aIHT6gw1oYK5Ps7x0blwEzCN6JnZjRZKFBMN732d5HojmpB1UuI3WSpIJL60V3jyCe+41O2aHD/eVnJb4F0GaGl/Yc/wmstGOwbhrHrnsYZCo9VNoqA0TZCR4LShWo5JGtJZaWHHC/jGnYxiKO3ipmKfz4PdIVMZI9VDbdUhQ9LK9htyH82+IQFbRL/H3UfO4NinDWhr3j6zrF/HPDOpqYa464BynrRnvZ6yw9XrOUKHeD0286fSOnmyv1nlbwU0iEMqJjKOJDdZBCNcqbgbCkUQ3yZVf1sQLPJw63DIZ/jSKAGcIPKSDM11L4gXtP5Qln14IAAKSKH53r4r1cNuyr/MjcSR8tml+Q/hAKCooVHbhkn9y2+HHHeagSvyCaHNBGxALYxzGqHJtdOzLanc9NcXOVoSNb
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(1800799024)(366016)(376014)(23010399003)(56012099006)(11063799006)(18002099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tcm7tRCRPdTmuWreTYtIFm4Y5IGVTci6yqhDCwjGKRXfcJFDqSAPjq/t4agz?=
 =?us-ascii?Q?ShFTi0qTgycptGw+tObIu5AapWyiGxse0Wd7Y1edGM9STChH3uXtHZ28bT+k?=
 =?us-ascii?Q?hfA7YH4/G6tF4vACiigDr9nqC0FZCLZz9fPRF8+kzV+6aPNfGayQ6BFYZIgM?=
 =?us-ascii?Q?AcZJVHWT1vQLJcA245CFM37b11nd5mXFx/lV9VeC104MiEqDfmy3G60NfW8q?=
 =?us-ascii?Q?DomEkOgD9Hjx6GutIutD3t+Ce4gtfxgZ8db7m3nZzNf1oAxiEN80NTK03V/3?=
 =?us-ascii?Q?FG4oaUtC2W5ogOF7jQTmUTdWSwWGG3h9Rf+K+G9YuSOErQmIDFvL8LoL3/6S?=
 =?us-ascii?Q?Yzz1iSmalZgDnUtDdRB5WckP19qhaZJJI2fcOiRxvVzYjh7DWaWrPyY3RCiU?=
 =?us-ascii?Q?+BY6XKYqaiURJVHmNA7mSJNS8r+5DwPOoCHQn0u/rwmvrtVX6TPqnCmIIupr?=
 =?us-ascii?Q?wa7ucPr0os9jCZI7x6P4eYvrNkEOnnpvm9k70T+mHfb70HRP4dkOtewT9ujd?=
 =?us-ascii?Q?kAuldvBJpsnOkYhKTNOSG4f64CQqPd8C7PbHp1oidgHvmdQTO7zFMsLlTSAh?=
 =?us-ascii?Q?CEcoquzocl5PQPXbqBnamJuwK1o2i6DAN1O+Y6gd0cmkaPU82PozpUw4AhfX?=
 =?us-ascii?Q?Jqhq0H9F0S6rOIq64R2oLZDT6hAFRehPiF0Pt49+PF/sLowtMmHSKqgeI8N0?=
 =?us-ascii?Q?ZwWwR7FossHoOw7wa/y/aE3/KEvQ8EE5WRnsh9fnDhixELWK9dCqtHdzXfR5?=
 =?us-ascii?Q?XLoY33aSpKOPWDr0DJRq3mip9EbbTV0RG0MIeQ+yoaFXYFjMthoR0mlhA8v2?=
 =?us-ascii?Q?AcUWTuUJoTcNISdp0q6Bj9k8r3/QJtTQQ77aykOu6UB2oFwN0Ss5htkBk8Wi?=
 =?us-ascii?Q?51AIHd9i9dI51uWIunkdhvfgrkE6AXteIXBwrJUPl2hisYZVI/m1ECHoHqHj?=
 =?us-ascii?Q?8Nn5yJoV3cShyCHEn9Bz6Q9qedneeCOE0SybBlv/cw9dXrdUMAzwg5X1LGoG?=
 =?us-ascii?Q?9FqeLRdyVAyE0xdcnz9qQ7A7Gj/pagwkalkqMpGqXHzisGXtKNHv91B6UzqE?=
 =?us-ascii?Q?o2k+1JLLfySJLqqQgay/YHyEulgGzGBaIlIn1AI28u/q9Lsnznrs3PDFLHGv?=
 =?us-ascii?Q?7P0sGFnMEBmwAiu9AN2z0XFk2pdF+BctbmECBexojS32Z8Zht8oFtxE1prl6?=
 =?us-ascii?Q?eOg3OtZ29VUrgF23NXiY4uSgKBlsHOS46XMQ8N4fVAQfhW2hSC1T823jqDxT?=
 =?us-ascii?Q?lK71o8XhHm9S3dZXEkt3No1398NI1PbPrE1vEWHK6hrF6bcHPMbApusFCqsR?=
 =?us-ascii?Q?LMEpsy26TVUpk4fhV9cJMjFl6QrYC6pLJjaMM/sU55Z2HcFpVQyVe4cqgws/?=
 =?us-ascii?Q?bqh/tA8YAkxma8v1HOT4nAMlNvOqSCi34jathmsMrm1Wrbm4D184xnkuXqGo?=
 =?us-ascii?Q?fAVh4jMNz5aT6mrvPpdv73WKFB0KT5XB7a1CERYFH2gjTM4cus6og7UsIXXc?=
 =?us-ascii?Q?T9/5Az6j8qUl0qk3QJpZKWrVsN28c2JNWaYXaN0gS2bAylbVlP81ARt1E1U1?=
 =?us-ascii?Q?6LJdPHCaP8jB//BQf+MNUcAZqcCxzcvzuuUO2VhMo8+8fSi33yvB2OHNDjhL?=
 =?us-ascii?Q?n/tj8+BPfMuGZ/KNiYKFXcTVQDCvuk04jAsqAqJTVl7CJakARQisI1Ce6AgB?=
 =?us-ascii?Q?O0mfUmgWMvbemWZOvUznW+KNXDOb6erfgW7kEatE9e80YfphmS6oqIuaIozl?=
 =?us-ascii?Q?P5KoycJv+EWy9DhbEZNcmkZGCt4czxI=3D?=
X-Exchange-RoutingPolicyChecked: XlmweV0esoNY5aiayIupL624k4SQzrHgqINIO+eoUfl9uHg21ExxB7lNt7k8qHumBsZyWYJ/Kr3qCEH8loNwaEfJSLl4uZKqKM4Nwhx9ynYyKyaBRu69couRurQTFcMdgshz5Y3TWI2UeVtSvvj4vwqt7MC7gWL2NTSXtVUtCQ3BKidHt8m/H/liZHc1D/iiWk5rwzfmR6vx/2CHahPjyTLa1bg1R+F61wZRk0TluP8wEUuAZWmphjZzK4EOIz5Unab3KJboKvDcn7fQtP+EV+mJZSutuds7sC2p8wf/lwYd39JIVyUQBGUUsuJCDS/SFtTrG98lYr5752jaZmkrXA==
X-MS-Exchange-CrossTenant-Network-Message-Id: f186d457-3625-4d20-ed36-08df14bdea08
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Sep 2026 13:16:42.4497 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vr49hk0GLMy7MB8uY6oAugyPvk0E6fzYfv6bVjny2tg9SzNYSB31kgT3OgI7AAPWHos+CN6cB5h+tgR8Z4t1LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD6B8A798D
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

Here goes this round of our drm-xe-fixes.
In the mmio series, 4 are fixes and 2 are dependencies.

Thanks,
Rodrigo.

drm-xe-fixes-2026-09-17:
Couple shrinker related fixes plus a series of patches fixing several
xe_mmio_gem issues around fault handler and destroy path.
The following changes since commit fd73f4a6659897191fa0d40695fe370925dd3780:

  Linux 7.3-rc3 (2026-09-13 14:38:02 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-09-17

for you to fetch changes up to f0e9f963a3d209d7dc7ddd61116118ab5da2797d:

  drm/xe/i2c: Disable IRQ on unbind (2026-09-16 08:46:16 -0400)

----------------------------------------------------------------
Couple shrinker related fixes plus a series of patches fixing several
xe_mmio_gem issues around fault handler and destroy path.

----------------------------------------------------------------
Ilia Levi (5):
      drm/xe/mmio_gem: forbid VMA split
      drm/xe/mmio_gem: use write-back mapping for dummy page
      drm/xe/mmio_gem: simplify fault handler loop
      drm/xe/mmio_gem: cache the dummy page per object
      drm/xe/mmio_gem: fix destroy flow

Raag Jadav (1):
      drm/xe/i2c: Disable IRQ on unbind

Shuicheng Lin (3):
      drm/xe/mmio_gem: Revoke drm_vma_node on xe_mmio_gem destroy
      drm/xe/shrinker: Return the freed page count through a parameter
      drm/xe/shrinker: Take a runtime PM ref before shrinking non-system memory

 drivers/gpu/drm/xe/xe_i2c.c      |   3 +
 drivers/gpu/drm/xe/xe_mmio_gem.c | 108 ++++++++++++++++++++++------------
 drivers/gpu/drm/xe/xe_mmio_gem.h |   2 +-
 drivers/gpu/drm/xe/xe_shrinker.c | 124 ++++++++++++++++++++++-----------------
 4 files changed, 145 insertions(+), 92 deletions(-)
