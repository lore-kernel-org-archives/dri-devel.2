Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 005E3C79FB9
	for <dri-devel@archiver.kernel.org>; Thu, 10 Sep 2026 14:51:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C6FA10E00D;
	Thu, 10 Sep 2026 14:51:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="jYlH5LQ3";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0EA6410E00D;
 Thu, 10 Sep 2026 14:51:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789051888; x=1820587888;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=sIDipupRfQWdDzW4XE1wXjU79jKzJN4bNhsaaNUnucM=;
 b=jYlH5LQ35UiZASwYuScGbpDEGTgPfwShxJemzsEa+V3k/iXVFAglVmlT
 b6ihvb7v6rYUVkIT0lrIX3AuZbjNbfoxN+eomBzVVmFPJrkT9ArGYCf6Y
 F5yonwqmNaU/S/Llifse/+dB+oFl8KKdfJ+iiJysmGIydSPf7njNnj9W8
 qvHEwGbk39ZgoOLyMNRDXfm5KTQNxdGMVlk483VPQ/NqFLPw0UHvE7S7C
 E/TZ8pxZ34+8Ri0k3lhZjEf9uJuihMQ2DF75NRhIGjPOYwBJCwsQ5hc++
 m0HkGXHPUO/dsWo8CpumgEuYcqD+fIMAzLPwDww57ONHOceh7oXBVWiOL w==;
X-CSE-ConnectionGUID: 7jQR2OC/QN+r+yddD7HkFQ==
X-CSE-MsgGUID: eMFVCcoUSeeqp3GS0hH4lQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11901"; a="89715170"
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; 
   d="scan'208";a="89715170"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 07:51:28 -0700
X-CSE-ConnectionGUID: JjvFgyJcQ42RsArKgHpm1A==
X-CSE-MsgGUID: cjQg3CtdQEa59zcNTvg+9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,95,1787036400"; d="scan'208";a="275186314"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 07:51:27 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 07:51:26 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Thu, 10 Sep 2026 07:51:26 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.36) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Thu, 10 Sep 2026 07:51:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FaEW1Z0gdGGKFw6fjyyJ0lKQRhdzFCRf3E0X/mmtDADuZGzaeG/vjnoL4mdlj91RvzhDxP2gyeJCCnIE6lgv5H7UwykHkyTExtoEi5xR6VuifUJg4GcUuuqva28U95+qob/OKZ5HTOjmo/SZ5xr34T4EGARfccAWsABd+rvmPbj2USHVNKDNc+fIwGrsHxECHqbi/QWqCdayomW0I35k27iQlYb+Z09Y4Fwbb3PYGhdIoZXWL2NrLrpaiRaW2UjzHIZQVPCqyz7Lz1BDqQMjPctUOWs3AUNaJmoQDDvmmlucJkJZasLUyCXMe3GXpXjgkMP+bHEQ+hyJQU6dY0n3kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MRl75Z4jYEAjrpKb1fYonkPiy+KEpHK00DBfltpEGO0=;
 b=HfdYOYgoGi8kAAvODM1xwDMaKh8iNilOt1yU44RFqcC4Jc3rPzS+fwWbh2cikqMeGNwdg/zJhbv3ALpRBbGaT9ncCZ/3WJcXk1JtHbLQEIwECAIf9ZQRTkZnlqb1n7Sm7ElUdXtUa3oOwy6bBD/PlhEScQFvqMVkuHqArGSqQE+8Migliu2qx1y9FNJpHfG/fj+5tKRUtnHarUxg0QFAh+pX2bG6h03Angf5IWf9nCObxmxzAyq5FL/ruOCirxUVRvIxpniRyzc/CuzRkPSriP1OtHQjl96fTdmXMEKWlErzikmUA/WL6yEv+1iqWDitR+/lonWTOSpo11fRDAyJzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SJ1PR11MB6201.namprd11.prod.outlook.com (2603:10b6:a03:45c::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Thu, 10 Sep
 2026 14:51:22 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0406.005; Thu, 10 Sep 2026
 14:51:21 +0000
Date: Thu, 10 Sep 2026 10:51:15 -0400
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
Message-ID: <aqLD4xjzFF6ROxBu@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SJ0PR03CA0249.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0::14) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SJ1PR11MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f8ec974-c230-4edb-6e37-08df0f4afa80
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|7416014|1800799024|23010399003|366016|3023799007|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: q3J5QLq9MnfzgJbWzySWgQVfriCZhPHUw7Y19AY0XMQVYIR1PHD9Ynq+4Gb+PG31H3hwGWBKM+8ouRjGGG0yuL0z+8NZFnkkXG17WPPXZZKfw2q/zXBnLXLXhcdgVoV9kMUwfN5RsHhPNI/nutb9+YhL3zrXGhz8xjaM2CvRIwnwGAHpwAvB8A2ivmkwVUSTNZMsMqgH+fn3WQQv9UeRhtI1zl4vaeJ+Ezh4y8da27xG9nBIHbWA7r21wQACRe2Z1ZFcq2PP1ZrMLtd1q4F3sI7S5vjTNr4u/gSOzhCqi0Hivr3sXjkGbZga4/P3/VKVNqnX+jS7ob6YLz+YozmO0YxInTCAG8Y2l0kk1aNu9o0EmJBbIK7RlNc+ADgsmuZpknolcrRXChBR8R+zGFb736DM0lJcwdUXZnRAtiHyRTEziL/EXlv7IppMAgUYeJFotanpkHEUzVowhsM/MlJX56G1/PzKLVzLtgfwqOiyY6GcdJsYPSC330BzeV73vPBsfPFiQF9QpeixaIYDkc0j1HMcC5UYMs2YNoCOctx4/iMK7qKR4eOfsL0dHlqC5FKguwzUDxapCK3ZZtUk5XDvICffKP62cbw9eLUjwWzmHPg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(7416014)(1800799024)(23010399003)(366016)(3023799007)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?hLM/2qK5JliOa6mTRpva0BtciJTWb0cu78LOTSDiMdHHsjrSbKEJrrDmyV?=
 =?iso-8859-1?Q?XwY3tfa6d/qIjTb77jDRfqZTpSEjuEa5iboWKN0D5IcE9+FbFibPJU/etj?=
 =?iso-8859-1?Q?LIBTu8MEtrP60zmt6tQO9i2MEequWnc8AyBsNHxxlfqsLe+GsHsKsTbCyd?=
 =?iso-8859-1?Q?redch+1Xr5CjnUDcLpIcoEh6Bhnf3a2qqCJw+LwMrHh9D0dMIsbzPX2wRY?=
 =?iso-8859-1?Q?elJOybYXFBYKdCcIEFrukvisnGDbgJblQCbembXNpf3PXQr1dkiiYIQqYQ?=
 =?iso-8859-1?Q?oxT/vbNccr9W5wqgYfcfJpc0WNT2PrqMjIoddlNJ+kXPH6xonrwwSK+R8B?=
 =?iso-8859-1?Q?agXQdK3tuDphxr0XWFBuaHLuIO4irc4b0T28/swu0p4GFPtEhaqqPA0iGM?=
 =?iso-8859-1?Q?USaVu82wlbhQcvDcM8QtR98WM4EO9RJjs6yo0l/BggA0cTohsdCq/Ov1yi?=
 =?iso-8859-1?Q?O/Uu2QicX3Svwi7zRRRAGqv6wFfX0dARbrdeA5raOn/oNoEE9nu0mYd5Tt?=
 =?iso-8859-1?Q?Md2hoD5IxX3gL7vh4P7dD4tTiTm12Ua5pg6pfSpkBMm5xca9T6x27biNyS?=
 =?iso-8859-1?Q?eMuaIMB0Y2ohDUhzlRBk9NfrwO2m/MuYd/xmyoS979H9+jcoVvCO2k8vFs?=
 =?iso-8859-1?Q?wYt+u1+N4voLzTYMu0DnwlYv9ckp5JWiQFK4jRaV5EoshRkdR2djrJ23Kw?=
 =?iso-8859-1?Q?x8gnwWDKqmubpwk/9veJLRorDhndDoi2AuPcuB/zSR/yPu2Gomod8lN370?=
 =?iso-8859-1?Q?gxX1Fo06rh4qEWCeOA/fvjGCuuckm2iYL4UNzJaR4zqnevJtvCfjmfWXJQ?=
 =?iso-8859-1?Q?/kTKpyPZJDQ4q7Dd9JGe1a95vOJMwWbViaFPZTt27C5isf2Ap42MiC6u/b?=
 =?iso-8859-1?Q?czLg9xCkxlQQKPB2zRnPqMXXUfPOH5Kctyih7gkPgph8Gl/36vaq/RImX1?=
 =?iso-8859-1?Q?0gZumnH1kq3/yk/XcH6UGbAlS+3hzruiq40TwMnBvVReawch63F9YaBGrX?=
 =?iso-8859-1?Q?7PBSA9zajIiUyhQFlHZhhL+BEfuJLE8Y1gxneua0rsnFqFqFGbHwguV86w?=
 =?iso-8859-1?Q?RKI6PDz8Nw08hYC+65BRaQnv8+2o991HjJN6vSR+VyFR+x7ixmWjYCbAnK?=
 =?iso-8859-1?Q?t9Syz2zVsKTCd+77Cj93+8s3nHM9qSCwt1CFgdGvqpoSOkS4sOFu7Ahqso?=
 =?iso-8859-1?Q?LNjYo+ALNbFnaID6HhnnBsw7y0D7po2EDCsrWBKpjnh6/mib1coZZOn+o5?=
 =?iso-8859-1?Q?Czi3hYFTuywF90n9ALI6lxAPCELE2Crivdykb187d4X65gYchgj7zhEc66?=
 =?iso-8859-1?Q?/2S4ZF7UF0n1gcQvH6No2jgH3OFps7cwxP+KX2xviUH9TZiKd0XVgZgZWn?=
 =?iso-8859-1?Q?72sZq9NYK/zNc6TompqWvH+5c7qgNoTTVQPZsm+5z520WzaEIJ/t873tMz?=
 =?iso-8859-1?Q?AH3n/jnlBJ/RcZ3Ip/qCgsdF6SSgOkEcwA4MWTIkUOxICbp44F07n8mqm2?=
 =?iso-8859-1?Q?2yGBB0CYlknXwb+MpCHd/blH2JN7ns3bA6wY/hxM1eIUCxDuXKNSMw12dN?=
 =?iso-8859-1?Q?BmqsQ2YXDBxL+YHjr7Tohio2Mg53Ps2Ckes7jEiYOwq+Vv4HHvS8oPBc+v?=
 =?iso-8859-1?Q?MnyiYTNcIfBO1/wLpNh1Ab3kGYsKo1JUipk07wGuUnUQ1WNj72DE25YSqt?=
 =?iso-8859-1?Q?nRqrN7XPKmeHJVvMiU3OnRRTqnWcinfbeVyBG7SnbaOw/rbHG3l6bV74aZ?=
 =?iso-8859-1?Q?uFA9SQnX1cnxXQf9oigA5E8kLFQEj2icj+A5W5byH/NIkmxjiETedeWJjG?=
 =?iso-8859-1?Q?OPQ+l2kIzA=3D=3D?=
X-Exchange-RoutingPolicyChecked: 12rCAPQK6MTgCkiVTiLhedQy5xO6AkSEIwVuNV/7R/RpIQgsWmZnvLrN2+2dzbFhoS8Zdj3tDYXmpHn7fSD7IZIoYI+c5SbbOU02k9IQVP3hpFo7MzBnQASfnxHH/J1S68aevUnB1YUrtXynp12affFFKp+WdAgMoHP01QbkP4i8feWzBMjSwN4gBCDljECi5HU6jXcG70fGTizXMMNOGmogwvL+zwFv+nCAom75w3hP+nUrMm49mk8n+ZYNBycg1QnWujv3MTwaTEAZx2f5DcmyEicBXfeV8E+omkcFrcoppDUGBwd/1wRRdGcunq4tEZW3DkH6Lne8yAwFWOOGvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f8ec974-c230-4edb-6e37-08df0f4afa80
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Sep 2026 14:51:21.7114 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /y1tALvr3ybg3poUjtFlEAu+ziWVXQgbMOoLCUZWbv2QBxSt1WUDvGB03ZZP7EtjSU4uGimUwoyDxGB30CuyDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR11MB6201
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

Here goes our drm-xe-fixes for this round.

Thanks,
Rodrigo.

drm-xe-fixes-2026-09-10:
A runtime_pm guard for page-fault worker and a cache flush fix.
The following changes since commit df2908090cda368b01ff43709f51890076c56157:

  Linux 7.3-rc2 (2026-09-06 15:07:20 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-09-10

for you to fetch changes up to f5fcf7e638b904397ec0f66d3ea6766ef0cfe25b:

  drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches (2026-09-09 11:20:39 -0400)

----------------------------------------------------------------
A runtime_pm guard for page-fault worker and a cache flush fix.

----------------------------------------------------------------
Thomas Hellström (1):
      drm/xe: Flush LSC untyped L1 dataport cache after rcs/ccs batches

Varun Gupta (1):
      drm/xe: Guard page-fault worker with runtime PM check

 drivers/gpu/drm/xe/instructions/xe_gpu_commands.h |  1 +
 drivers/gpu/drm/xe/xe_pagefault.c                 | 10 ++++++++++
 drivers/gpu/drm/xe/xe_pagefault_types.h           |  3 +++
 drivers/gpu/drm/xe/xe_ring_ops.c                  | 11 +++++++++++
 4 files changed, 25 insertions(+)
