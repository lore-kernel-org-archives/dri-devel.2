Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EB6C5DF66
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 12:25:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1C21510F2F9;
	Thu, 13 Aug 2026 12:25:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="G7M2o6DI";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 97ACB10F2E8;
 Thu, 13 Aug 2026 12:25:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786623906; x=1818159906;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=4QHtIokCCu2TAqs3qD6HOFjA9de4PufBvU5jv5KKiJ4=;
 b=G7M2o6DIB6laZseT6XrhP1nYK01s/7E+6+V+6jdXUb5eVFFKfui0Fdku
 J9Av6V+1a2cPapqMq+SWrY1DxaPbbVTz024qO7lFkMmzfXjJYIHKvXYKn
 2ZsHrobFNwKnE2ozJ/NmIbvIA+wm3/Ij0tavOgeEBZCtZwaHlzLmXtCm/
 mo6Pu0/wU9b4/gtn7kC1HqgRzRhPEdgKCcZIF8LAaKGBE2g4jKtFFHZ8z
 XYwRxxfQ+hjQoY0zAE8ZqZNouLSVYdsK4dS6zmC+4cot33vrjDSgYeAft
 XTZ78qF1Qp3hx3R+m/llFnFKeZIrMMNuM8rLqxXEqtsJ2caIGvYq+nwG3 w==;
X-CSE-ConnectionGUID: YddkYvUOQOOTexw2dw/JOA==
X-CSE-MsgGUID: 7cnu48ZDQA22af3IabJA3Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11873"; a="86314118"
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="86314118"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 05:25:06 -0700
X-CSE-ConnectionGUID: 7MDbIKO7Si+p6v+3m0EgCQ==
X-CSE-MsgGUID: QGYc6JV3S56oL5ySO/uWrQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,221,1779174000"; d="scan'208";a="260652396"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 05:25:03 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 05:25:02 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 05:25:02 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.56) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 05:25:02 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vgY4+3nDPcCJ1dXqS07RdVuOoA/3gD4Aq8sYLt7qrJELZbzM4G5QMe6IhB2WJaJTL8xJB11QdriauuEYDl1mZQuMQI6ICXF1QFO4gDpX96t8bFDkw7LOmc+ZClR83loMyrZHsjSi0eEnVr6spX9IfvkEPvUg7Uh0ME8k/NHsYSllyHULFJF9aCKnnhe/nLSzLlGm8CKeMLP9LbwyBw3aD5qfJgG0/+D841pv4bE1HNNduyIkp3hmG6trVy1K9Y6lIKljGkU6CiEwiovTcGj5HILmG8KG/XoYHpq2N1xZ4yq+++TGdLwZKHWpmkyrdeAnG++l8AZOjTEdmcGtm/HjzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EkcZx/6Edb0M70QJSwmuLGoBctUGUJ5YvJYBSNf7HkQ=;
 b=u9W9p2vLPTX5d2SW444VcdCGnkbLiCtU1UMcNPdi6/aukm9apSGLfGGA0xcRwurePtGVGIw4UQr393VbZI04MmITXiOHNUc3FEjFIMA80lLVPmaDuJ1kQi369t28uB9VqUbJrI55F/3wxp3WKZImnuynaPtxHenXeaClfIlFHA5DfdkmUCDd0L4kdWY/WfnPL47Gjc8J4pR6Y7s8md/K/IsEtuZ/JiCc07zvuUB/JqczyElMrsAz/HPa74eYyX9NUlB11xy8T3gZvTB9Z3o5l6DsoVVLF/72o6nVZX7HcY2pVrfL7Se/vHToaspbISV/5PiMRqbHIw2Lcc2WgSwl/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5073.namprd11.prod.outlook.com (2603:10b6:303:92::23)
 by CH8PR11MB9483.namprd11.prod.outlook.com (2603:10b6:610:2b9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.15; Thu, 13 Aug
 2026 12:25:00 +0000
Received: from CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe]) by CO1PR11MB5073.namprd11.prod.outlook.com
 ([fe80::a153:939c:df8c:f4fe%7]) with mapi id 15.21.0315.014; Thu, 13 Aug 2026
 12:24:59 +0000
Date: Thu, 13 Aug 2026 08:24:54 -0400
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
Subject: [PULL] drm-intel-fixes
Message-ID: <an23lmV9ktpiHnTN@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR05CA0142.namprd05.prod.outlook.com
 (2603:10b6:a03:33d::27) To CO1PR11MB5073.namprd11.prod.outlook.com
 (2603:10b6:303:92::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5073:EE_|CH8PR11MB9483:EE_
X-MS-Office365-Filtering-Correlation-Id: b3611fad-e88a-4208-892f-08def935e499
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|1800799024|366016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: iBhP7uEQKNusR6Y8ojMpGU8e5SKlkqVCuRwYpLEzVuItOietnfx3cudsMtnuXpmbYCoeJlLaO2WMLktaEsW/r+5Dxmjk79XfEQjpHq6sC+vE6jwDUthfkTBBGIkotxFsAnvwybEnchDE8vVgEX9A27XQlJUScW7Yz8vLgvEVFh/JorUXucpHLcoSihskwZ9MQKc+u1R3tbE3ebeVxYGL7D8aEpWAwjGcX5Y55Xja0ysoD8H48ntiX5282VMQxyQ3chxxi30+AH0Xi9kyUIykm6NuVOC3NuL5kWPfBowuZQMxAWg10TwK/TgVnXQtEdGToXpp7vmP7bzbTsO36L0UUlTBVF6hI1KSUI66d0cI5acJizOE6BNUGczjRVKJNU89Pgj1ATuzvLXvV4+bsFduNDzAafAOkY4Bmca9WSsb6PE+KeNFU8MFDmuMS8E9jWySJC+Cfm8kHAalhrDjMS+190clvbdgZnUbk8QG+a/NwbCTq5iCnd8JnH8nJUq0aStOlNbMQzHCuTBYqRAgx7KxCKhAIaktqpMI33tOto8HMhLRsfhyOzWGKq+telrkxK4nnUlNTfz734mghed8V/eWtNsiNNkAHUMXYYqLLHZgvE4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB5073.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(1800799024)(366016)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rPXrjLLdlZUG/gT/4unWe9sNCPqcmCmR7pa2qzEJop4lXbmrqhVTFrs6sSQy?=
 =?us-ascii?Q?4RY0ZonE2gMIKLhxPQKnV1vw4wM0puFU+hMPH2BCRbWCztO0tzjfaHMKeZye?=
 =?us-ascii?Q?qD4nHRtqwPdV4jGImH+ISlXt+2g90xaEzj5hE3sWcQhxg0JVgr4X+Ubuefgo?=
 =?us-ascii?Q?be+Vrq3iv5IiJlZw57cPsj2jWSk9Sfpxneo+u4fpqom2uxY3RGLrA+abov6q?=
 =?us-ascii?Q?eDugT31hTkLCUwGQdV7cid6YoU1ujN745jSwR2c92ynSRuiASclm9M7ZaXz3?=
 =?us-ascii?Q?oY+2/hnkzbcDSSq6M4nqeCEgQxAGWJtVPkaNGL6GGSGu/3ohEWQsRj8IR1JP?=
 =?us-ascii?Q?ZOU8ksxP1GMqZz8ASDZTZZJag8kafwCQcR9NAXdlp7oIUUyn+IDbP9Vq+IEh?=
 =?us-ascii?Q?/9/f5zM7BlVCRNaU5mw4OmEJobb5l6H0X/rg+KlulOT+r3wjb7mzadis9MOG?=
 =?us-ascii?Q?TXRaKNs5rflYkCB6YhZJf7WfU8mQTaneyNf9WVz0a8U2JC0SsMZOvoxbRF4T?=
 =?us-ascii?Q?RivC9dL+jt9ZzyEU7UsbryvkxU3xnnN1WMMFnR2oy/niXqIOV2Gihw9Rl7LY?=
 =?us-ascii?Q?7GkxU0AK0kXkO4ki8xoeNgMMNpL+ZIBx6pK1Xzvjh0uyJm39IJBqdyVrV5GO?=
 =?us-ascii?Q?+LbJbfy0q7KVd0hJRdieR7jZtjZNbQNMHEUBZt+3NAz7F6CQDXRCKH0pWVx3?=
 =?us-ascii?Q?d4cc81ALx/SXZYJSstH5v1TmoluHiDUplb5NpY/FWyny7dYSvfPfVgQ4abAY?=
 =?us-ascii?Q?IbD9Um5V2rjzcAb7CELTb9ATxQZ66kzO+zv95mJ7aF1cSXrw5g7dtyj8ELby?=
 =?us-ascii?Q?jHof5+S+CZDmDZq3fb5SDX8tRxyLyvQq2OKo7XAAzeq5pGpmjyVHMDqD4d2G?=
 =?us-ascii?Q?PGE780Px9oeL4n2A55XLg++CCyv+Jbw9EoaklVwyAP1kYczcxHHjrV+lss+g?=
 =?us-ascii?Q?VPycS/wB6atdjl1QG6lnRHdUD1YGyc9sYg+OL9K/TXNMjdO9LcFETRvFXlLv?=
 =?us-ascii?Q?N0RLqZpIx6TPtjJLUn975Q2OoW+fM1SRsWk1PlfTrW8/fft+ATT/Hin/z8vU?=
 =?us-ascii?Q?l9e5EmeuFfQZiSmD3MMVS3wSXbCC48O3lZuqmFzKio2CQPdvk7YRNzo58JVk?=
 =?us-ascii?Q?MbHnZqRZr6LJeOU6JOrlJRIvuTfVJXi2oOtHadTx/4x/50fRvJk9pEVioTGA?=
 =?us-ascii?Q?90B3Nx/W9sCWVVIPUuiqp5x0o+u8/EgrTp76Ysbp6C4fVqGyyfY4BnDzf+6y?=
 =?us-ascii?Q?YVLE21xALaTs3t6kau4hroCKoaM5LmJuKiXR7j4TGvZXTyr+xpDLI19mHHOl?=
 =?us-ascii?Q?VtoXPpQYWvRILz8oCO0tRD6yNTWkSe3L5BM8YBy+HLZT2Bu3+lhbwPSAmrVX?=
 =?us-ascii?Q?Vi1lbSCS94nj+yb3J4rOoyFHV/rqan4I1NqKI/w7ym1Gf0MgY6IuFe8QEbBZ?=
 =?us-ascii?Q?/HUOMQipASbt9Ba1lXKgFPM8Cw9A/wETGFlv15ElZJtqJAN1kP3tGlw6ZFFR?=
 =?us-ascii?Q?EAHy6nGzLmTEEpNtKz5MqYMa9ABnzbAIGXIasPpjyIcusc3kFBSrQaO3l5la?=
 =?us-ascii?Q?Cv5eJtaoGX4R+AqthhBQzZ8Jva/m1eqfWNu4/rFf1qJt27I1bBc1P5qxmKmK?=
 =?us-ascii?Q?CQBPQyyYv9xGqbkeMzt0K23M+1TdpNiO3w/i2TCu0xYXC/Fp0FtyM0BmO6YX?=
 =?us-ascii?Q?Araz+hNatBg6nWS+cfhDPg6Zy7p1iFjOSP/NK4CmOF8l8Ura/kuRA46LBsiF?=
 =?us-ascii?Q?xIVVCRPP+w=3D=3D?=
X-Exchange-RoutingPolicyChecked: AC+7PLwYdOpkAQ6986g/Ct59sBpN/4hUY7+I6vnO3WtpV/AlZxGuHCwXa0P2cCm+4gEbOslXWPKOFO2aF0CESPhLBQ3ld20fiKxXrCi2AsQnJr04kzrD9A0bl4DbG+AcyHEmgWVHxQ5xRiPdE8jhcldObe2cElBITp3fPYNSAtHPmdPc1yftQCsQK5DTeMzJO8RD8Nd3N1aX3ZDeHwFBobAZlUX8O7Mlz5VH+szHmcBqK74DD7jAvSnCRqmbYtnflRsDhqPEINfFpo4n4ftg2XXV0od73+H6+1jPIiVzXVDa9ahlAcJTrwVEQVi6MCcY4S2/33Vm1xD88JF26wumPw==
X-MS-Exchange-CrossTenant-Network-Message-Id: b3611fad-e88a-4208-892f-08def935e499
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5073.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2026 12:24:59.9170 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8NlJoFc1XZtjTWsxGgk3amLoDxTCj9Tf3XSkUe7DXK2wUk4gzr+geuNR15VfpELfqtSYghPC2H9xX+/tkQJDcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR11MB9483
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

Here goes our drm-intel-fixes for this week.

Only a couple of dii clock frequency fixes with a dependency patch
adding a helper function.
And dropping a duplicated DP MST call. The duplication was
caused by a bad cherry-pick on fixes that I didn't noticed :( Sorry!

Thanks,
Rodrigo.

drm-intel-fixes-2026-08-13:
A couple of DII clock frequency fixes and dropping a
duplicated DP MST call.
The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:

  Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-08-13

for you to fetch changes up to 266ebacffc5809478a2e80d61ddc58c921dbe2b4:

  drm/i915/lt_phy: program DDI_CLK_VALFREQ with DDI clock frequency (2026-08-12 13:27:23 -0400)

----------------------------------------------------------------
A couple of DII clock frequency fixes and dropping a
duplicated DP MST call.

----------------------------------------------------------------
Chaitanya Kumar Borah (1):
      drm/i915/dp_mst: Remove duplicate intel_pfit_compute_config() call

Suraj Kandpal (3):
      drm/i915/ddi: add helper to compute DDI clock frequency
      drm/i915/cx0: program DDI_CLK_VALFREQ with DDI clock frequency
      drm/i915/lt_phy: program DDI_CLK_VALFREQ with DDI clock frequency

 drivers/gpu/drm/i915/display/intel_cx0_phy.c |  5 +++--
 drivers/gpu/drm/i915/display/intel_ddi.c     | 11 +++++++++++
 drivers/gpu/drm/i915/display/intel_ddi.h     |  1 +
 drivers/gpu/drm/i915/display/intel_dp_mst.c  |  4 ----
 drivers/gpu/drm/i915/display/intel_lt_phy.c  |  6 ++++--
 5 files changed, 19 insertions(+), 8 deletions(-)
