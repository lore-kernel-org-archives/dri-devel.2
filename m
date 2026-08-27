Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3B2EC61DCB
	for <dri-devel@archiver.kernel.org>; Thu, 27 Aug 2026 16:52:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A752010F11D;
	Thu, 27 Aug 2026 16:52:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XVxPSipq";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82C3910E40C;
 Thu, 27 Aug 2026 16:52:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787849573; x=1819385573;
 h=date:from:to:cc:subject:message-id:mime-version;
 bh=t+jYWTtYmvOFlz679NL65VjfuBdbXQ5Hg+Mwh/WaFD8=;
 b=XVxPSipqYtGKX/GjmClN4EBiQxm369QULrhHPB9gGKYyd/1oWvYQmAux
 7DMjCo2VXXqjrxaWv/2u8F5a5kqiIorXzf4IzTiC63nbofkQFL2+7cyhA
 bA4VXMGZVzjG4cesgO+2up7toxcwnuDfHz6O+BaXfCD3cgoW+evx6j5vu
 UwWbaCVtG7Uj4ecf8gwcnP0XyeUO15oMgG0Uo4L28h8a10xG1A3xZhaPP
 +O3l3Y4CuqMkNg/MCTQ/cOjwmh62+R0aqHFdOIs1mq6FLS72zz26FD6MJ
 HXYZoJGuf35lMKR2XXCQ3mAp3dkNqxi3yVnA6lQtkgB3+LbQ/KbK/qT+s Q==;
X-CSE-ConnectionGUID: 6THLX+VsSJer5s46oQxMDw==
X-CSE-MsgGUID: jU0xFRQqTVi0rhqG3RbEkQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="105730217"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="105730217"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 09:52:52 -0700
X-CSE-ConnectionGUID: QqFQOlLOTkqv82355SFl1g==
X-CSE-MsgGUID: 9pVkDd43TrOkcDUhCyPT9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="268491644"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 09:52:52 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 09:52:51 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 27 Aug 2026 09:52:51 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.56) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 27 Aug 2026 09:52:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iQD1lPfcYHYPDgNnti/sKF9rs+dcptvbTBoXprJ74zTMmEVr1HPr1g/6ylpxsYOutjFFyjGtcCz/WFNNYr1Y5izSUcdm5x70sm5xjrZBczyVohxSkQKhxAZkj+EWnWsLC97xxsNtPXp0zUbXK8jI4RS4Pk5ZNImLInmnbqHHjIyAOO/khvQWNplM398buvs4gjgKFSCXmRGaNZgXygJloS/vWsSJeGZU3Gzenv3WL9RVak9o0HW/A/LmdvqNhxrcaeVGfMSGG7dJnHiDJJ5BcfhJF8IRRBEYm7nG9unnc6ucWlY8SuRG6L7cgVbZWvH6zuiop4ciWg3EaAtcjWZ18A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qd1cMtEvG61VKoc49ASx77Lo2kr3MOIINgkF7/+W9vs=;
 b=sb5trqZBDOGEzqIzrZb6TY8ddBmv0PY90w2dx393gtPBkC0q9DWhUMR7qaY/bRQrvPARCjgpXqzQzgg5jd/1743WO0tKtBC3J0d3hP+PI/cjoE/kPc8k96T/gLOpBeI+rIw56aYt9CfG5ZOBhiEuRIJ+b7DHGZAJkkSWQAOPYguz7sIJUe/JQqUwEIQchGjOzV6ja9NOIvKxbHHjxvDI2alG+FchRyaTMZehnecoeRC/n4Z99p1F/Viebpph7ErL9FaKyJd2rVWWD5szj0IuRlPJO43FjRqZVD7yHn3h0HTkf2xLgVuT4SjiVaUfSdQjJAwEwbJpgSy/c20vbT7uKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by LV8PR11MB8509.namprd11.prod.outlook.com (2603:10b6:408:1e6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.10; Thu, 27 Aug
 2026 16:52:43 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0360.008; Thu, 27 Aug 2026
 16:52:43 +0000
Date: Thu, 27 Aug 2026 12:52:38 -0400
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
Message-ID: <apBrVgvZwIRIfuhR@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR03CA0149.namprd03.prod.outlook.com
 (2603:10b6:a03:33c::34) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|LV8PR11MB8509:EE_
X-MS-Office365-Filtering-Correlation-Id: 92621336-f7ac-4f9d-38f6-08df045b9cef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|10067099003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: uScimvF8GULmgXNrfSfXYj0H0Xu/2SjYvloSRDLsMRVylHq/P5LHVa751kdCTryNjnfxFysFzgGw4moUcPcxhnPxl7J9Y7m2HN72qE4+QKSOM9g5PpuKEKoygphPpm1HDe2RXGH4tGkaAvob111nuw2qNC5r70zU5QovxYY7iXgkrlmdYfywRq43fKLhWS6Utb1gjkRESW1NQrLGJ6hJkFKPvOiJuNkoQtFq3R033SY+N9rbD2Y3+L9A9BiqL3mjkF9cr0INEiPw+4AGKg8aaFYqQpasekBTP1q5g501Ke/dwg4gmcSue8GGCPg2lrY9oyzrXm6u14zfDsD48tf4RzBBzoYYTY6rd17+cXUY58lzLc3XmUggqFrYsql12DmO9A5DCecpblhhAMiTj9mPQ61nffN1q10GbsqB+W6c+7b0ax2yJEzwKD7c3COe10CzD1GSTj5yAB4FqtNt1euAxiHDM+pKuyBSTD2bc7YLnZ0YxuqznbGWto/OibLfMnadU8wcg/ikkHkQ2q6rlRxLOssdCtItFwRGjLhJzNGR6PelcOIc08O/pF+4Gx7Nryft157i4K8AHC5vbWXKeKPyA6XoKY2X5bsQ4/Zllodq6EbBzZZnbZ16qIGryIEKOF1g
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7752.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(10067099003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5Q7yvBPW1DQW67XUuTPYlAgK3GZbS/DD1IzjGakbL/nY1AyXE4hcwm8a3OpV?=
 =?us-ascii?Q?EjEBvIe8PP2WKnrFut9guBZfF2Igk25NfiXPyi6Ii5FJVZo1ZbGWRfoTdcmG?=
 =?us-ascii?Q?pcc6fabmwdFdAfM9JEUAkHOdJMC26xl214xGKI6W6CG7DBAIGUhD3MWCkeNR?=
 =?us-ascii?Q?zYOQ7ZBa8F9hAGJoYntkxIMWl2zY2NGxxDsKdONkrekmIdKZRA0s8TVtMhPx?=
 =?us-ascii?Q?k0+nyb2u2qAA3SB7DkpnmV7Q75Q6sVRshb5GJbH5UEGQtj6By0pIPen6WHVW?=
 =?us-ascii?Q?vfA6999E46LtJ378zaG8+OMA+WJ9yFmygKJ6IJ0ovyyxISYjqG+dRvQKO4gG?=
 =?us-ascii?Q?ZaMB+QO2exxhBNCaV75FNl0RjZFV6qVJhkt6gJN0Ba7tSJHKaBXSHmrTq9xx?=
 =?us-ascii?Q?H9dJxBz/oLE1Zyg29Grn4eE0HEE6aX1o89lt6wvWqX8v9dYgziWWewgN6H8C?=
 =?us-ascii?Q?EM7r0hThZ7bdu+d4IjDNJlTtfnh4TpzPC/RSVlGY7Rfj/aRsZOBu2PFqvPlY?=
 =?us-ascii?Q?ug0BzW1l85w+e8AFJE2usexQOPya5+F7aFvFkWlwSj272Ra2HAOzVUKefxDL?=
 =?us-ascii?Q?Ymo6XD6BD+r9f0NCPFMoSFEp/fK9VfaWshAGj4RUGKV49aC7xRLknE3xE7t2?=
 =?us-ascii?Q?eYP4oFd8hSHocuHcKuyu0BBgPNU4cyHKdLbsIs5isxkodXeLBJrD29/m7S7V?=
 =?us-ascii?Q?JH0k9zxFHETI/594iidTWDI/1xPge12UvFkbWTytpvDHXwUw85A1XFBv9bn3?=
 =?us-ascii?Q?sdp8oU+wM+X8kY0eZabnK4ieodVnIOrdKAnG387SzJ0NkLg7FLbo0ovBvT8/?=
 =?us-ascii?Q?0hH37fqllrrEhnhQ5u5/IwSUQOjxPOga9Pyn4Fi74wrwmlE7YTzZQAn7T4fj?=
 =?us-ascii?Q?KG32BJVs4Z65nKNuWzCMkltfA5ZAG9NiaEBaTwkLpWg+9EH65WiBGTfNL2aA?=
 =?us-ascii?Q?NnDhUNknHy9OEfwfGyrp4Iam0ND+I3I93QtsnS/I9jAt+8GRj1HUGT4g6Evi?=
 =?us-ascii?Q?x+K7uHQftDfhuJVxlTwwKqSFfnN2LPXNdXFVB5FmOhTPvMl4qQ/wXQriIbwY?=
 =?us-ascii?Q?I7rZOSGHWty/Ni1Jw1NRZvsCuLHfF3i1D0OAjWLnw5Q49aLIc3CXkGP/99X6?=
 =?us-ascii?Q?2WfdKCyFnWSzjOLi1MCg52l79193vyiKnHBfYgHHnV6c18AkbPSfKFnWiw2T?=
 =?us-ascii?Q?nthALM8aF60q/fC6+x4QYwc82YdZDYZRChvQKyTnXYL4FKh6tj7Curoi7HYN?=
 =?us-ascii?Q?BhXAWuubtb0JjAhFAIulCSy+WDenwUGYHTUkbDrkprXFz7OiXjlt9Pzj7WIQ?=
 =?us-ascii?Q?pdpgfsYoj31cr7K7xZhyiD5GEd02sn6kS2DeeDqwjWJzk6LAIglxGzCUOZ7D?=
 =?us-ascii?Q?KBagIrvnPtX7d3au2BdPlnTh6Z3tJxMKuX4vayeHyTx/xq19X157OVWvdSK5?=
 =?us-ascii?Q?UoVrC9GLxXhDYNYx1NPDLIsMJNwvN3y8iQ1XSUdFOROvcxhkbSQ0sfYisRJD?=
 =?us-ascii?Q?dF2YC0fZwYCwm4cFs4hJStFZUv/xyxYYl0Spwxjm8ydrrA8cbyXQGcy70Fou?=
 =?us-ascii?Q?5uEE61GOo6T65JX6/NLLjv7Tqcdu2XChIace1gi2h73+a1paRJvDhSI+dHaO?=
 =?us-ascii?Q?cmRRvLrfVB+8ejWQLmxjDT18lL7jQP5Td35c1NpI6WjwhVleS2dQQ18idLtm?=
 =?us-ascii?Q?oESN1HEXGpQ579+N8V+25ufyWtpBMmuMC/SHOjlZBgasyW3548+dJaNkfqNW?=
 =?us-ascii?Q?y8KvBFggZg=3D=3D?=
X-Exchange-RoutingPolicyChecked: Fi56VS8vy8cDSuBWiBXSNa1WTa5z+SFWXlrbJtwzw/ohQPf4piAR/mhuUpYFkP004ztg54vX8T8JwuHMOnu01g+I5VZ5xu6+5Zv8SGoSWkVDg6CRcLu2Lbw7NiWOGLmHBDVZXqa/V07UPmz3NvyoZ+iLPai2WII9v30iojRWbSRw616Qv78UQSGUunvh/lC7ISm+bOu1JDcgWiNK1kbAd3KjW4kBvyUo6E0u/5oOt8E+9Oxx226TUJ7YFiDlxEGl2dc9wSOwdyF25fl6TON93k4iu3LhjdcXYSfb27Ksw1ozu3nQIj+V6slXQojwyaAEsw/36ud4ObDXc15DxWflqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92621336-f7ac-4f9d-38f6-08df045b9cef
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2026 16:52:43.3876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: okFvpP9uGOYr8vLPsWNjZ+0A4KLcKnrQ7KaRkVGazYQMFNnibCPHem3uJQyJGUF/XwDcTwBHzwrXG/mXJBFITQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8509
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

Here goes our last round of -next-fixes.

Please notice the i2c global register definitions patch
that is dependency for the other 2 xe/i2c fixes targeting stable.

Thanks,
Rodrigo.

drm-xe-next-fixes-2026-08-27:
Cross-subsystem Changes:
- i2c global register definitions as dependency for xe/i2c fixes. (Heikki)

Driver Changes:
- Media workardound (Daniele)
- Add CCS to gt_idle debugfs print (Bala)
- Page fault related fix (Arvind)
- i2c related fixes (Heikki)
- System Controller mailbox bit fix (Anoop)
The following changes since commit 1ff8d3e3165fd077faa4259fd232bdddcd30249f:

  Merge tag 'drm-xe-next-fixes-2026-08-20' of https://gitlab.freedesktop.org/drm/xe/kernel into drm-next (2026-08-24 11:40:23 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-fixes-2026-08-27

for you to fetch changes up to a62212b35a214c2ff3bd1c785a440d7ad8205ec9:

  drm/xe/sysctrl: Read mailbox phase bit from hardware (2026-08-27 12:00:17 -0400)

----------------------------------------------------------------
Cross-subsystem Changes:
- i2c global register definitions as dependency for xe/i2c fixes. (Heikki)

Driver Changes:
- Media workardound (Daniele)
- Add CCS to gt_idle debugfs print (Bala)
- Page fault related fix (Arvind)
- i2c related fixes (Heikki)
- System Controller mailbox bit fix (Anoop)

----------------------------------------------------------------
Anoop Vijay (1):
      drm/xe/sysctrl: Read mailbox phase bit from hardware

Arvind Yadav (1):
      drm/xe: Reject page faults from non-fault-mode scratch VMs

Balasubramani Vivekanandan (1):
      drm/xe/xe_gt_idle: Add CCS to the powergating info print

Daniele Ceraolo Spurio (1):
      drm/xe: Do not apply WA 14025883347 to media 3503

Heikki Krogerus (3):
      i2c: designware: Global register definitions
      drm/xe/i2c: Fix the interrupt handling
      drm/xe/i2c: Keep the i2c controller always enabled

 MAINTAINERS                                |   1 +
 drivers/gpu/drm/xe/Makefile                |   4 +-
 drivers/gpu/drm/xe/regs/xe_i2c_regs.h      |   2 +
 drivers/gpu/drm/xe/xe_amc.c                | 197 +++++++++++++++++++++++++++++
 drivers/gpu/drm/xe/xe_amc.h                |  25 ++++
 drivers/gpu/drm/xe/xe_gt_idle.c            |   3 +-
 drivers/gpu/drm/xe/xe_i2c.c                | 165 +++++++++++++-----------
 drivers/gpu/drm/xe/xe_i2c.h                |  14 +-
 drivers/gpu/drm/xe/xe_pagefault.c          |   2 +-
 drivers/gpu/drm/xe/xe_sysctrl.c            |   7 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c    |  22 +---
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.h    |   1 -
 drivers/gpu/drm/xe/xe_sysctrl_types.h      |   3 -
 drivers/gpu/drm/xe/xe_wa_oob.rules         |   2 +-
 drivers/i2c/busses/i2c-designware-common.c |   2 +
 drivers/i2c/busses/i2c-designware-core.h   |  85 +------------
 drivers/i2c/busses/i2c-designware-master.c |   2 +
 drivers/i2c/busses/i2c-designware-slave.c  |   2 +
 include/linux/designware_i2c.h             | 107 ++++++++++++++++
 19 files changed, 450 insertions(+), 196 deletions(-)
 create mode 100644 drivers/gpu/drm/xe/xe_amc.c
 create mode 100644 drivers/gpu/drm/xe/xe_amc.h
 create mode 100644 include/linux/designware_i2c.h
