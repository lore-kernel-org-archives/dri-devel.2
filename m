Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF654CA600C
	for <dri-devel@archiver.kernel.org>; Thu,  8 Oct 2026 16:28:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5014310E4F1;
	Thu,  8 Oct 2026 16:28:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="C7q0MCc/";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 57DFC10E133;
 Thu,  8 Oct 2026 16:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791476891; x=1823012891;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=EWHJrOa2CEK/wsumANeZHOd80Ogt62Od04e3SOSavfY=;
 b=C7q0MCc/vOZzeGiBzKgAHalWcelC0MrjR6/3QydsYR1UA0qjDDMv+LhU
 86e4GZaVo1zanFnj8gX8iMZAAIY3AEWvyO1LuFxpzHYb3hnexPHIKlL/+
 Glt8tktUw6eju669wBOYcIta7rFWIRF+cjSwyL2rRN9IoeKBoFPoMHSJv
 UEPgiH1iFSntP6+gHn/xt5txSym00rtq3XJ2jDqiHbBvKhBr2r9CiO2Vx
 Yb3Sq2Et2YIBZ1UoN2NEgb91HfNwcAwJYR3bNhkh2eFJ2rf9HKAQ+GpXD
 f4yalK6DXb0LaZJYcDMbzLHtwMlHIyPZj+refqifUuvWW6PNhfCLRrAqJ w==;
X-CSE-ConnectionGUID: INVoIy9OSQecxJSKn0Jj+A==
X-CSE-MsgGUID: TBdh7YyGT7i0DnqnxsC15Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11928"; a="146516"
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="146516"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 09:28:10 -0700
X-CSE-ConnectionGUID: 5Wai8+xPSK2O7cDqHoe+OA==
X-CSE-MsgGUID: QrsU4AvCQmC8LBIGkFCjxQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,146,1787036400"; 
   d="scan'208";a="1908891"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Oct 2026 09:28:09 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:28:08 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 8 Oct 2026 09:28:08 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.57) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 8 Oct 2026 09:28:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGK04RsdRePM/suC+TTToneqc9OpnWg/oDw6kWuTCRN9xGTEhvOOzVA4vms8yzmvyGBGfX0tHg8mT7Q34EOLHbSRxsToYmBTHBTnApyAZhu3LreYvjX9LtrxK++752pMBWeMY+IZWvSQBfykquSknkeXfUDLSIL2sMg+Y+1ejPbHKOv/En2b1vdyRBdfXupIovv2ydjLBn++EYYRt5z2SACAT3rJYxl5dA1lhWmFlEfLwdnkveQ6pbOCfaOqd3QJjktEx05ZILC1T5JK6LjaKqIGjBz2CpfrNAe6goSbxt+wulIGK0mLMEVUIBBlpYMCtYQa3WDrqJXHg8fJluVWhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EZp3TrPyiY9rZyQOq9daLBIBLP6EEaIYIIs/3ky+LM8=;
 b=dgzjQYKUhlIDEc+NK4vAiveZ7Y4qv2NjYeYlZ+NEf3+vaVt3utHE6TXOBjOqrDoLE1VPXImPJlXaISoY2eVGdM69ffGIYkin7bIzCVCQkWz5x25S5SvytamDv9ayB/XjuyaY+j0HUhX2LCrnSb2+iGgWIxzqj7MUSNPQcJRHw46i3maMpsSsjgm8Dz+zD/K1AOjLMxtWiFNDUyzg9Agb9Umhm22n/rVf83rt8NOZaMvJ4ErBYhqyaQGRR3mHDrNpU985QOPvi/nexelA6Nxy7gpPkQYEkzP0m6MRTn0Uunq2p1HteFEDg+Tuk2Q2t+Iwppi9jKItXTINJ8PW8Wymew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7192.namprd11.prod.outlook.com (2603:10b6:8:13a::22)
 by PH7PR11MB8503.namprd11.prod.outlook.com (2603:10b6:510:30d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 16:28:04 +0000
Received: from DS0PR11MB7192.namprd11.prod.outlook.com
 ([fe80::c747:a502:4a7f:f5bb]) by DS0PR11MB7192.namprd11.prod.outlook.com
 ([fe80::c747:a502:4a7f:f5bb%4]) with mapi id 15.21.0472.016; Thu, 8 Oct 2026
 16:27:59 +0000
Date: Thu, 8 Oct 2026 12:27:42 -0400
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
Message-ID: <asfEfgbIjs0GJ-RF@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0028.APCP153.PROD.OUTLOOK.COM (2603:1096:4:190::9)
 To DS0PR11MB7192.namprd11.prod.outlook.com
 (2603:10b6:8:13a::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7192:EE_|PH7PR11MB8503:EE_
X-MS-Office365-Filtering-Correlation-Id: 2a126eb9-08e7-4187-49c9-08df25591da7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|7416014|366016|1800799024|56012099006|11063799006|260925021311599003|260925021911599003|260925022911599003|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YJJI+jSdiWdGYwApIeAdf0iMFXmmSX4+qIWtGwb+ec0o8ofIue/F9epX22G80HrY0FamvqpD4DXuDTabj9ymOy2x9gAG92C6sn0So1iikYFFYrV9A/PXeZURiK48wrwMHn/gl2YRUk2QvNk5gFbBV7a3/LxNDQaQKmGAAUUKRaF3xUVWuQqQYiuuwKbTSQSwGwDC/eg2DMUSrQbA30otWJ4gbssnXNKSDuYdqnbbYHNzNShdy6dtz8UfmlR+PVbDVkfgLVah0YACwlBEgitH6Wvn7zXSnRAfTQa2/MtIGh+FTLKrqrZTNOO30g6qgHJqdpYStP3CaAVWTaE+/QRhsC8vfDLBjotSJSvd0mOZEKJdik6VXhYk+2cXq5cYi5atqA+hw0pBQ4Oe9kGJzqym5CwEq4RWuLI/avkOIPPUP3mRnFSIKMLRIF9RzecXfnIY3tw0gKB1aI3LrY4Cfcvi3D5G3lprOQtO8FTNOK8LO5gRsPNKKK8Vh4dkhGxydEVLIV7AhxoylB9b5ieAXbLaCfDBEXlKfOPtcsRYA5o4ycHPMLp+2y5oamlu1MPJzb9/UAogKUMs2rQDyWCnwCxAO3MH25VGMmt1X8ZqhKyMUkw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7192.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(7416014)(366016)(1800799024)(56012099006)(11063799006)(260925021311599003)(260925021911599003)(260925022911599003)(10067099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?PjuDrgQUy210y0ghofZLq0Cl8sm7/NBJjae9YFdzGYkWarJl/il2exGij6?=
 =?iso-8859-1?Q?yjmg5MY9T0tZ31fe3n+4oMjGB2IujldDRStMQIwwxkyzfMyHFcagNlm2jk?=
 =?iso-8859-1?Q?h6j6rcwMKRxa/klRPcWEGxcVRXB6/8DZbWzywAigQe79Y+B2KJ3u8Y1RzN?=
 =?iso-8859-1?Q?j84+1/lf6yVRdWpsolgNtgs7267x6Yy++5adaXgY1YM8fQnD+W8QLYuauK?=
 =?iso-8859-1?Q?bWN+h1i/CTHXqTUCalF94RqixAaSwrprthw3WX4B0TxZ0J3RXMy8QitJlu?=
 =?iso-8859-1?Q?UaplaowJEyv6xHX5qbHChnM2qCD24I6YWM4UmPzXmIyXGdjL1utdp4AFf8?=
 =?iso-8859-1?Q?cGjj2ZKbIQAzhxStdkkzytuAttT9obcANuhqj6wz2+cUiu7UY2osz97Tex?=
 =?iso-8859-1?Q?oFCGYfs1Wt4s1aq0mPo0zzr1ujduM9TPo5NDwbOw5OkWuVavrx3i4V6kwl?=
 =?iso-8859-1?Q?1cIf6TyC45oZhuyCy16YkX0i41iREtcEBSgLUdXPp1ZStd8lZFAIm4CfJH?=
 =?iso-8859-1?Q?RgjhyYh7ZWA+piKbteS2dOnCjPtS/ryPNojAw9AFpipRq5XjXQaU+1vpnh?=
 =?iso-8859-1?Q?MfPjuCoP09ekqFpPsxg2VLiGyp/mJCkwUoObbZvZI/kZuZmWsKC7Y0pSnM?=
 =?iso-8859-1?Q?6sQkO68/3L526gmx5ACVWZeQ6iIU+ao4nV4kOdrZWgLU25MtSEfHg16Na2?=
 =?iso-8859-1?Q?gVBAB38tISpQwFBNJRmrHzJyjfzWHoQMJtIaZ2jRzR+wj7fBE+95jTC97d?=
 =?iso-8859-1?Q?9lhkSKOsrIrzwOldjhF8WIdD9l6gpWKky/L+3DXEQ1O1aM/GCyEJB0VLxd?=
 =?iso-8859-1?Q?FwMjskbJX3uXMMx4XUX9Yri05JnZBJ/HXOVPX4MOZOlSPrAAZfB3nOTu7q?=
 =?iso-8859-1?Q?NHab/NyMAMBX4roBVRPsldVXqQkbekDMHpArT84jmGa0NIfP0ZRK6g+hwR?=
 =?iso-8859-1?Q?6520qPczG/R2y2Qcxdbj/4o2wmJ4CKgNvWLHWix4CfrP/OBt6ifJVt9Bn8?=
 =?iso-8859-1?Q?OTv257N3Ui4d4dCtRISWSKjosISjGHcB+zlm+D9zWz2FbnRzN9A399Xy9F?=
 =?iso-8859-1?Q?Uy9ctsGmsxHfsVXSv2nJxHUv9sozeVJ+RX7/yuEHUV9RJK6X8puq3/kNjU?=
 =?iso-8859-1?Q?hOhxxN+ZSWoxpRgLziJDrOpHWEbTBCCHeJS3DcxknmyWRjXa6wf3YRyBiq?=
 =?iso-8859-1?Q?Cff1XMav/nmzCIalS4m5iWIvB+lUSrBQqYBOKX72e6Kt6iAyGmfeXWrAF2?=
 =?iso-8859-1?Q?Joeki66nQJzjPlDzJnXLo0CRY3kJFrP2zEbylYcT8TnkNjLJRaFLkvQMoY?=
 =?iso-8859-1?Q?hzL32qHk12JWMgHMtk87bv0Sdd5OF566GHr/2BCuBkW1ukugvTeWri753J?=
 =?iso-8859-1?Q?G1ywb1d7bJyCyBnWWpnvxj30MtCv9QaXTok0uZ15kmTQI6/IPc6J9Rcl7t?=
 =?iso-8859-1?Q?mP+ZQpdkq35MJvmoMfaFT3dX4Acx3AtMHgd2IYabkStKXPr193E6gm916/?=
 =?iso-8859-1?Q?0VfoSP+ixHF1OCVD9d4wCU2aCPuPlVFldVuh6iHSOmRCS42Ec8uGEuEeIm?=
 =?iso-8859-1?Q?Ji88pp8wrUgRTNKMrIkWmld7PIJ7UMXqeMhCauxhljExPK9MKbLPVAEmze?=
 =?iso-8859-1?Q?9C+QZl0TYJV9bmgKgaKVWYVvnse7JNWjFLruc0q1Z1csHdELrbd148CnEC?=
 =?iso-8859-1?Q?cmPlI7W70Dj5U9jFdo+7Jn/ubrEfql2H7E9DwW2ekciXTBJ5TwfAuUJZxT?=
 =?iso-8859-1?Q?eQ5T96gOabQo23dAPYfJyu4GkR5bECEssaaO5vQmsPsEAui+PRt8mrRAHW?=
 =?iso-8859-1?Q?pbomspeyj5kSPwT/BEiI/BYSvQl1Boo=3D?=
X-Exchange-RoutingPolicyChecked: AGqSvrVKtPfTtQNsm/Vwz+4myxnMQOritq5TIvG70bUTGWrysnqiFB8psgJUmkZh+RnBjcGa1aZuOnljznMP6sz5o+yqIfgeeKxgxgi5fKE/VlPEb4VCYr1qTJOkn5SuFzZRuOAGE6fjd4qGKRNuMGGC1Yy3Sw3FfLFC8r16Trk8KtsUoQ4OUCiea+GRZ8s2LXBhcZvYFsNXK2t20DgUrt15lW3Njt3CwL6HD081q5iq/Zxl49wGpKiy2YinqPNR6GbUQERvSgdX8Ee6B6NmLfkIhkNstJ6fYcQkRO9oYuycxtH6dk5qW8Bp7aoj7p7XftXS0bycXfgKztOYviaQFQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2a126eb9-08e7-4187-49c9-08df25591da7
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7192.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 16:27:59.6029 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TWUUppbZ3YPpzF2rkbLm1cJyx0aaZSKzc3VE272kOS48YaE6joF/1RMbD3PsSlL87v31yrtTVCkpZAGhgC24HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB8503
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

Here goes our xe fixes for this rc round.

Thanks,
Rodrigo.

drm-xe-fixes-2026-10-08:
Fixes on:
 - i2c removal (Fan)
 - system Controller Maibox header handling (Mallesh)
 - two bo pin/unpin accounting bugs (Thomas)
 - not emitting a w/a twice (Tvrtko)
 - xe_mmio_wait32() to honor delay/sleep maximums (Al\
 an)
The following changes since commit a90ee4305c4a5df72c11b31dacfdc76e00fcf78a:

  Linux 7.3-rc6 (2026-10-04 13:45:25 -0700)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-fixes-2026-10-08

for you to fetch changes up to 611857adc9e7b0ee1239a0baf38498922ca5a12e:

  drm/xe/i2c: cancel the client work on remove (2026-10-07 09:22:03 -0400)

----------------------------------------------------------------
Fixes on:
 - i2c removal (Fan)
 - system Controller Maibox header handling (Mallesh)
 - two bo pin/unpin accounting bugs (Thomas)
 - not emitting a w/a twice (Tvrtko)
 - xe_mmio_wait32() to honor delay/sleep maximums (Al\
 an)

----------------------------------------------------------------
Alan Previn (1):
      drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums

Fan Wu (1):
      drm/xe/i2c: cancel the client work on remove

Mallesh Koujalagi (1):
      drm/xe/sysctrl: Fix mailbox header handling

Thomas Hellström (2):
      drm/xe: Fix shrinker accounting double-subtraction on nested external pins
      drm/xe: Fix stale pinned_link entry when fb-pin performs the final unpin

Tvrtko Ursulin (1):
      drm/xe: Do not emit Wa_16010904313 twice

 drivers/gpu/drm/xe/display/xe_fb_pin.c  |   6 +-
 drivers/gpu/drm/xe/xe_bo.c              | 139 ++++++++++++++++++++++++--------
 drivers/gpu/drm/xe/xe_bo.h              |   2 +
 drivers/gpu/drm/xe/xe_i2c.c             |   5 +-
 drivers/gpu/drm/xe/xe_lrc.c             |  38 ++++++---
 drivers/gpu/drm/xe/xe_mmio.c            |   5 +-
 drivers/gpu/drm/xe/xe_sysctrl_mailbox.c |  16 ++--
 7 files changed, 150 insertions(+), 61 deletions(-)
