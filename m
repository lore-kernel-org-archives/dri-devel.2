Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B4D606A321
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 13:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZQaXSuTj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=AeNm+2vK
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C118310E0A9;
	Thu, 26 Nov 2026 13:11:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 62E5C10E0A9;
 Thu, 26 Nov 2026 13:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795698664; x=1827234664;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=QTEavFG7ebDtIW3VVW2IsqJuwLDU8qjeCC0y9h7gYok=;
 b=ZQaXSuTjzP4jm1F8D7mHxZ000HDaebJ5JgWfq/Sao0q5MYpiUKOGiU4Q
 au3lCs/YG6RnAu3blB7OhgEE0O0f2UJuuMIS0JKHEckFvqk/2viMwppM9
 G2ISmZ8vaYKW07SDzPMHpxkicdgQNOvgtDc4Jr/DVOAiUNqJ+GgMsHSvt
 yPb0JcKBMmQ6yiJOmRKx3F7YY7pZGVjk0LJ0kZYDx+g1D0N6miNPCggLi
 5kdfKrDNn1TFsSS/cBR+/rh3UkUqtoKlNx8sOGJGJVtNEJPI9XX0raD3t
 4XKxThWMtd8F5FjtUx6wb5aBQI0o22u7nfnkWXO2SrwM8aj4pDXlCb4Xw A==;
X-CSE-ConnectionGUID: a2jY8BdsTOyWf+K30EmZ4w==
X-CSE-MsgGUID: z3AUEpm8TJ+kgUruLZ4KuQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11978"; a="4615244"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4615244"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:11:03 -0800
X-CSE-ConnectionGUID: 97Zq8yEsTkq/QsrPE2rKvA==
X-CSE-MsgGUID: /A+LDMBiRoC1MyjIeJ2qyQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12497908"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Nov 2026 05:11:02 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 05:11:02 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Thu, 26 Nov 2026 05:11:02 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.41) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Thu, 26 Nov 2026 05:11:01 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vrccGlzuJFzkjVivQHPlNSnCWQ7rIyBOqI+aF6ICCzMvgPPRfe/s2DIPaH1eL/owMj5gPLyoKTjdNnzyuscuZJY23ANFqijMEIju2bimff0NcC9/64nNoYIUx5LmoX8PWWpIChDnOp+TCGB/tCjlxX7yVMvKQmgw9WVtIAvSnHXFOTrHft5nS+LSJsdrBEQi7Brvi0bMpqCjUZyu1vKeTBHUsDW0JmCp1QJRyI0UddCiDvFBhYN6p/cnjazrMiG5EvXVZLG3nKgyJLBQkV1qda9ec5yCLWA75FWl4IckIhSh00KHBbC7lvNYP/Ae+uGO+UZ/c82bQRqRYLbZe9fx3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8ZWEl15R1ijEX+LUXfHjJwxPkApeERnUcNZupUyHLDg=;
 b=w7mHO2fAFTg3mF5BAeTRggSiPtTCpuot6VhuaXGJjghmclocJYbGAXmCw9Ll286OSll3iwpIJQxStvVBgMFdXDPUx9+a272tY2l5w1FgBjwUz/4Vzhbikq3cEZWPkXLL548Oy5PAkMi6rNqQFTn0A/yK3M6YR0/vu4Figr4PLFA6Er6And41vHV8gotSEA4IPX27zX/rfmq4oqNEq5OH4mAFYLUYJaLYh4DA8pfBxk30rhZpApA6WokROfw/WVthC8LpjT6RftvHq25IsntGLVvgFEKoNAV9EN11Ugz66ONZROWVomXzV6bfBSmWX5ScxNyQwXnkP92VJWM+fU842g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8ZWEl15R1ijEX+LUXfHjJwxPkApeERnUcNZupUyHLDg=;
 b=AeNm+2vK1vIjNjE2qqTFFF4OUFmcoHfKpshWYxk1dtJscytL1xeA2K0lZzjkFZCsFWEmKdts/HZy8qK0BbGFFsej0kh6gxh29M0kHlyQ5fDytC0xUzTvPunIAt9ZjCe+9HxZP0iAunx6zZfRt2uTwtJY+CrYJp4kuSSRC8Oczsw=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS7PR11MB5990.namprd11.prod.outlook.com (2603:10b6:8:71::5) by
 IA4PR11MB9345.namprd11.prod.outlook.com (2603:10b6:208:56c::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.7; Thu, 26 Nov
 2026 13:10:59 +0000
Received: from DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899]) by DS7PR11MB5990.namprd11.prod.outlook.com
 ([fe80::133c:5eed:3aec:b899%3]) with mapi id 15.21.0639.011; Thu, 26 Nov 2026
 13:10:59 +0000
Date: Thu, 26 Nov 2026 08:10:55 -0500
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Tauro, Riana" <riana.tauro@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>, Jakub Kicinski
 <kuba@kernel.org>, Raag Jadav <raag.jadav@intel.com>, Zack McKevitt
 <zachary.mckevitt@oss.qualcomm.com>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Subject: Re: [PATCH v4 1/2] drm/ras: Add retired-pages node type
Message-ID: <awgv3wH7RqsvSJz5@intel.com>
References: <20261124203833.3618507-4-rodrigo.vivi@intel.com>
 <20261124203833.3618507-5-rodrigo.vivi@intel.com>
 <90a912c9-2936-49c9-bdce-1267825f1678@intel.com>
 <awcwFHXV25lieJic@intel.com>
 <81dcc8ef-da18-4eeb-9732-641127aa6827@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81dcc8ef-da18-4eeb-9732-641127aa6827@intel.com>
X-ClientProxiedBy: SJ2PR07CA0006.namprd07.prod.outlook.com
 (2603:10b6:a03:505::18) To DS7PR11MB5990.namprd11.prod.outlook.com
 (2603:10b6:8:71::5)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR11MB5990:EE_|IA4PR11MB9345:EE_
X-MS-Office365-Filtering-Correlation-Id: cdc9b860-a731-4040-010e-08df4bbeb664
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|22082099003|18002099003|56012099006|260925021311599003|11063799006|4143699003|260925022911599003|260925021911599003|261028144727099003|261102123227099003|261022105027099003|261026121527099003|261022075727099003|261022113327099003|261021121427099003|261021123027099003|261009223327099003|261009221727099003|261009221227099003|261009220027099003|261026140227099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info: 6vxc53i8EiVYifObHb7324rtAzHusp11uOPj8grSGBAhlXJeCJfVF1iPuH0GaZwmUJ1B91/e4gQixOe3woaC/RgtlnS2DLr6l4Wa0LLkwPku4jhTIsTLnbYQYOE678j8s9ZajzRnAnDy0BzrdMXQM6J7Rysxqqq1DhQAy3RxNXWi1dBCFtjnx5nadGnY6U1lDp/OW99vaUBM3Wq9gQaigTSSUtNs2tZhWm6pRfZjvW/mOmbhGKs/UweJkuTpDBkLMh7UPF7rhFXtlWkDvtdP+FLQW1hLj76G1X73Fe7PI5Bg6+pBUMwWbdcATC4W18L2ydJBYALbm3tVgGer/AZSqMRvokDZ1rSF3TYSK0pZ5gN3ywx/nHppD3QPMZmsPkRgvdLboRs/DTqtlQ1OpSZgJduHms8gwmHIJbaK/MDqGpLcCNNaIXEKaoD0d0jsegfaT3dN58rburw5wn4nMbsxDRYBywTiNXxmuY8XpVvihmLA1fguYKKjoMkGCjwj+KeFx425+UsC3daqD/jPHvNIIWmgml7ReeeC0Mirh0PohRfv9WFwa+m5BBC5bT9pApBLfm8GprZjy6NVs08MqEGXoW4i71pn7imO1pLbl0UfbW0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS7PR11MB5990.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(22082099003)(18002099003)(56012099006)(260925021311599003)(11063799006)(4143699003)(260925022911599003)(260925021911599003)(261028144727099003)(261102123227099003)(261022105027099003)(261026121527099003)(261022075727099003)(261022113327099003)(261021121427099003)(261021123027099003)(261009223327099003)(261009221727099003)(261009221227099003)(261009220027099003)(261026140227099003)(261009223027099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?CSGYz6GyNuIbpNhptkNLBXwClrDULxgTQlnNpJJokfMqdnHsl1bcFSbHEF?=
 =?iso-8859-1?Q?wcb0pVusEE13sTGIOBx+j20uMb70M3r7crjmfQcMUSdXrP3+ZjVINFsnhq?=
 =?iso-8859-1?Q?M3ITamhodJcDuVGwC52Ni6wSwqGhhTKVW87rBxCgd4vo83jcQORpTWpLFH?=
 =?iso-8859-1?Q?nEwjNgcc2tSgZ0XjXCZCxyfjgH5XmDyefpLkwrj4zRdIAWzHfWTdKk3eJ3?=
 =?iso-8859-1?Q?PqRrs3T437BoYvq+EDD2nYko6PsxKfgZ1Ybd/mnkQVFb9jy9P0Ol84GUHC?=
 =?iso-8859-1?Q?DYrA59nu/d7JnK8GdnN+bvBm4bl1EQ9iFgk1Av6K9QSHYKlVQNRse4eism?=
 =?iso-8859-1?Q?ZvDd+Kkcy2IOThXIUnztcL2UeiB+1k5Iu194zPoc68I1RyhNLNHOnhrIOk?=
 =?iso-8859-1?Q?6pVz3O9bkk+1cz8smdwhE1EJvzJDuJAB6cCIrPXGbRDzv/iXAYLzhSDMt7?=
 =?iso-8859-1?Q?L6Mc33Bjr5CVYWDrXsaFruv7Ukk8otaX4EbnUd63lJmFJFbvivLYaeEwyy?=
 =?iso-8859-1?Q?obSunvT5c6mT2wNdXIz51dzAA/gbGCwpRlJJgEm7WN25dKBjN+03qKFers?=
 =?iso-8859-1?Q?oG32SiFbztVFJJvV70UAWlpmBmaM0xw/dzmmBzXj1MDPXE+xm6nvgxEI4G?=
 =?iso-8859-1?Q?erweYS8g0tf5JUwly/sW6AQpJLcwWQkFLIOfCxdFzc8gBUA7SX0Nnd2L4u?=
 =?iso-8859-1?Q?jB4sZz5NxTYofdn3p0H0JctBuY5OllQzM1i2x8TThxH3QN1m6xpN2dyMgG?=
 =?iso-8859-1?Q?Kp1BTGP5/E7x2MhsB9ByR8htrFRL0AeJenisTfdcKyoOVs3VsjoPc8JSXs?=
 =?iso-8859-1?Q?p/v7DB3ucITQ4S5xD0ekkbdkpDBg7RjGMkZ2VDo5ziB4XMZ13nrQ2k7zRa?=
 =?iso-8859-1?Q?QsuRaulD/OsXG9akXTHDJc7/YNk9ar6AftwfFIVTjUOaS4MtPPDPynsZoL?=
 =?iso-8859-1?Q?1/E++01E7vRugrV4XRs55epPXAjcERQoVufDbiAXwrhRtWBbsLfFKKZA/U?=
 =?iso-8859-1?Q?XFVfYZARENFHeIyhbSwEqIO7PPyyBeHwgbkPv9eNhTqEWZl1+rny9v/bGj?=
 =?iso-8859-1?Q?Z85AfBFUXsa4M926pIWmVbO2RA08XSPiov8Jm0w72uYKEvPhLESdqrAEpl?=
 =?iso-8859-1?Q?NJLa5Rjw8ME0dJYV5oCKCbz+6tC9cI2bssNu0tp2nYcomvldcWX7Byc3tx?=
 =?iso-8859-1?Q?1m2iJPwaLJO/yxNx9hnep2onWnYLiPrGikwFoOysYSoFg/El3j5YszeDXe?=
 =?iso-8859-1?Q?mqdLz7tp7zsxxkeAZ5wbbhNwa9PqE9jUK9BTLRSXNmnFsrz8uQdpr3Mztj?=
 =?iso-8859-1?Q?/m3FYtbCh5xXSKZSQdvjs6BYV9BtHK9MPRUNpGons2SJCbLj1PCkqfrSR5?=
 =?iso-8859-1?Q?t5eYY0wfVptaZNpNgFC2hEPhBeaGkhE5Fw8qJ2UyWI7buO20OUsbBfwvjm?=
 =?iso-8859-1?Q?5YXKBoXg5RpkiBxrHU8oIP+sOS1u8xq3tcjmGlFijK82yNxlz5NTsoPR/c?=
 =?iso-8859-1?Q?cbk1H9EVOqjJuqlgYF5X8RxKQP2uG13DvTh7Uj9hF8twJC+UcQ7bKBiOW+?=
 =?iso-8859-1?Q?FsjNoZcYNsDoggvR7M1o4YNbXXy0Wpmc2PtgJqFXlFMVq5LlIQLMR/oVF1?=
 =?iso-8859-1?Q?ECYey8hkvKvPmZLYLUvknstH0yLXi5r/3j20I0ZwDS5MyWDYAC4XVaK1JD?=
 =?iso-8859-1?Q?vPRcSfpPJJ4z2ORjjs6vDBY7YOPJHlS62Wgb2dzifKbusXnCNsfrf229+8?=
 =?iso-8859-1?Q?cozfVeiv6TKJECoq+scFeinTzxrxHx+xBUB3fi/mImvfiExDGBZy8gjfgh?=
 =?iso-8859-1?Q?ni5hBTtYoQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: Cu+RqEwqzUIKT9oOeyMrFEprvhglkeGEytoFpstxyDtdaKUq36arQhjvznZ5BeriDyFnYwAMcJthY2W3Vj8mqxMmUoje2DYRUpNh9M5NoL7epv7MXXSyHTk78Y9yQmQjSGkf8W1oyALGA18vNaGIGm/mNUxTJB3WxsHt1gnvfxwUvLzeSXCdJiR7PflPg7oTfVDPP7UzJfKj7iJpzM7fqC+zijFgh12avOO5JTbsabhAqpgDxzyyzxfTXiTIv6O5rJvwvbOJfXOt4i2JVaGP08axm1fs8iCLoeNWlwIh7pBc140C1iYrynIRjobCD+sEVU44mn64CG0Zt7pWY1hgvQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: cdc9b860-a731-4040-010e-08df4bbeb664
X-MS-Exchange-CrossTenant-AuthSource: DS7PR11MB5990.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Nov 2026 13:10:58.9681 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bPSzOJ5rg1VFlbYESgrW8i7b3R4KUzoJFxCmbqQrVVU0j/bQkaxL7bF+CCt6bf1NMVOVkrPQSyVWlcrNQvP7kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9345
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 26, 2026 at 10:39:10AM +0530, Tauro, Riana wrote:
> 
> On 26-11-2026 00:29, Rodrigo Vivi wrote:
> > On Wed, Nov 25, 2026 at 04:45:38PM +0530, Tauro, Riana wrote:
> > > Hi Rodrigo
> > > 
> > > On 25-11-2026 02:08, Rodrigo Vivi wrote:
> > > > From: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > > > 
> > > > Add a retired-pages node type to drm-ras so drivers can report the
> > > > memory pages they have taken out of service, with two operations:
> > > > 
> > > >    - get-retired-pages: dump one entry per page with its address, size
> > > >      and status (retired, pending or failed). The dump is flagged with
> > > >      NLM_F_DUMP_INTR if the list changes while it is read.
> > > >    - get-retired-pages-info: return the maximum number of pages that can
> > > >      be retired.
> > > > 
> > > > v3 (Rodrigo+LLM):
> > > >    - Split the drm-ras core from the xe user.
> > > >    - Flatten the page attributes and name the node type retired-pages
> > > >      instead of retired-resources, avoiding the over-wrapping
> > > >      anti-pattern pointed out by Jakub: the type-specific nest and the
> > > >      resource-type enum are gone.
> > > >    - Use uint for address, size and max-pages, no pad (Jakub).
> > > >    - Start the status enum at 1.
> > > >    - Move max-pages to its own do operation instead of a leading dump
> > > >      entry.
> > > >    - Set NLM_F_DUMP_INTR from a driver generation counter.
> > > >    - Report unknown node IDs with NL_SET_BAD_ATTR.
> > > >    - Removed deprecated Assisted-by tag.
> > > > 
> > > > v4 (Rodrigo+LLM):
> > > >    - Check the dump consistency once a page message is filled (Sashiko),
> > > >      and on the final NLMSG_DONE (local Sashiko), so NLM_F_DUMP_INTR is
> > > >      not lost.
> > > >    - Make the error-counter operations reject other node types (Sashiko).
> > > >    - Hold a node reference in the new handlers (local Sashiko).
> > > >    - Rebase on the telemetry node type, moving the type check of its
> > > >      handlers into drm_ras_node_get().
> > > > 
> > > > Cc: Jakub Kicinski <kuba@kernel.org>
> > > > Cc: Riana Tauro <riana.tauro@intel.com>
> > > > Cc: Raag Jadav <raag.jadav@intel.com>
> > > > Cc: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>
> > > > Cc: Jeff Hugo <jeff.hugo@oss.qualcomm.com>
> > > > Signed-off-by: Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
> > > > Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > > ---
> > > >    Documentation/netlink/specs/drm_ras.yaml |  74 +++++++-
> > > >    drivers/gpu/drm/drm_ras.c                | 226 +++++++++++++++++++++--
> > > >    drivers/gpu/drm/drm_ras_nl.c             |  24 +++
> > > >    drivers/gpu/drm/drm_ras_nl.h             |   4 +
> > > >    include/drm/drm_ras.h                    |  49 +++++
> > > >    include/uapi/drm/drm_ras.h               |  31 +++-
> > > >    6 files changed, 388 insertions(+), 20 deletions(-)
> > > > 
> > > > diff --git a/Documentation/netlink/specs/drm_ras.yaml b/Documentation/netlink/specs/drm_ras.yaml
> > > > index 0f1ceb705d3d..bc17d22e2156 100644
> > > > --- a/Documentation/netlink/specs/drm_ras.yaml
> > > > +++ b/Documentation/netlink/specs/drm_ras.yaml
> > > > @@ -16,16 +16,28 @@ definitions:
> > > >        type: enum
> > > >        name: node-type
> > > >        value-start: 1
> > > > -    entries: [error-counter, telemetry]
> > > > +    entries: [error-counter, telemetry, retired-pages]
> > > >        doc: >-
> > > >             Type of the node. The error-counter nodes expose reliability counters
> > > > -         for a hardware/software component, and telemetry nodes expose an
> > > > -         interface for reading and writing telemetry values to a device.
> > > > +         for a hardware/software component, telemetry nodes expose an
> > > > +         interface for reading and writing telemetry values to a device, and
> > > > +         retired-pages nodes list the memory pages that have been taken out
> > > > +         of service.
> > > 
> > > I noticed the node type was changed.
> > > Earlier reviews mentioned reusing the node for other resources, such as
> > > fabric
> > > https://patchwork.freedesktop.org/patch/749454/?series=173066&rev=1
> > > Could you please help understand why this was changed? Are we not re-using
> > > it?
> > avoiding the anti-pattern issue raised by Jakub.
> > 
> > Reusing it needed a resource specific nest and a resource type enum,
> > which is the over-wrapping Jakub pointed out. Fabric would not have
> > addresses and sizes anyway, so it fits better as its own node type,
> > and the node type enum can grow without breaking anything.
> 
> The current drm-ras design lets drivers register nodes for different kinds
> of data: for example, error-counter nodes can represent different error
> types,
> and telemetry nodes can be created for different telemetry types like soc ,
> component specific .
> With a retired-pages node type, would drivers be limited to registering only
> page-related resources?
> We might need to add a new node type uapi for each resource.

I really don't see this happening for us right now, but that is already
supported. Same style as the others hold here.

For instance, with current v5 code you already can do this:

        /* Existing node, as today */
        vram->node_name = "vram-retired-pages";
        vram->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
        vram->query_retired_page = query_retired_page;
        vram->priv = xe;
        drm_ras_node_register(vram);

        /* New node, same type, another name and memory */
        lpddr->node_name = "lpddr-retired-pages";
        lpddr->type = DRM_RAS_NODE_TYPE_RETIRED_PAGES;
        lpddr->query_retired_page = query_lpddr_retired_page;
        lpddr->priv = xe;
        drm_ras_node_register(lpddr);

$ sudo $CLI --dump list-nodes
[{'device-name': '0000:03:00.0', 'node-id': 0, 'node-name': 'correctable-errors', 'node-type': 'error-counter'},
 {'device-name': '0000:03:00.0', 'node-id': 1, 'node-name': 'uncorrectable-errors', 'node-type': 'error-counter'},
 {'device-name': '0000:03:00.0', 'node-id': 2, 'node-name': 'vram-retired-pages', 'node-type': 'retired-pages'},
 {'device-name': '0000:03:00.0', 'node-id': 3, 'node-name': 'lpddr-retired-pages', 'node-type': 'retired-pages'}]

$ sudo $CLI --dump get-retired-pages --json '{"node-id": 2}'
[{'address': 12807041024, 'size': 4096, 'status': 'retired'}]

$ sudo $CLI --dump get-retired-pages --json '{"node-id": 3}'
[{'address': 4294971392, 'size': 4096, 'status': 'retired'},
 {'address': 4295000064, 'size': 4096, 'status': 'pending'}]

So, the only thing you might question is the 'vram-' name our driver is
choosing for CRI. But I'm not planing to change that because that was
what it was designed and agreed upon for CRI.
But this component here is flexible enough to accommodate the case
you are bringing up.

> 
> Would it make sense to keep a single node type and support multiple
> operations, or keep attributes optional depending on the resource?

No please. That brings us back to the anti-patter that Jakub pushed back.
It would complicate any possible parse.
If we have this case we introduce a new type. Our infra is already
flexible for that.

> 
> > 
> > > >      -
> > > >        type: flags
> > > >        name: telemetry-field-mode
> > > >        entries: [read, write]
> > > >        doc: Bitmask of access modes supported by a telemetry field.
> > > > +  -
> > > > +    type: enum
> > > > +    name: retired-page-status
> > > > +    value-start: 1
> > > > +    entries: [retired, pending, failed]
> > > > +    doc: >-
> > > > +         Status of a retired page. retired means the page is reserved and out
> > > > +         of service; pending means the retirement is queued but the
> > > > +         reservation is not complete yet; failed means the reservation failed
> > > > +         and the page may still be in use.
> > > >    attribute-sets:
> > > >      -
> > > > @@ -140,6 +152,30 @@ attribute-sets:
> > > >            doc: >-
> > > >                 Bitmask of access modes (read/write) supported by the
> > > >                 telemetry field.
> > > > +  -
> > > > +    name: retired-page-attrs
> > > > +    attributes:
> > > > +      -
> > > > +        name: node-id
> > > > +        type: u32
> > > > +        doc: Node ID targeted by this retired pages operation.
> > > > +      -
> > > > +        name: address
> > > > +        type: uint
> > > > +        doc: Device address of the retired page.
> > > > +      -
> > > > +        name: size
> > > > +        type: uint
> > > > +        doc: Size of the retired page in bytes.
> > > > +      -
> > > > +        name: status
> > > > +        type: u32
> > > > +        doc: Retirement status of the page.
> > > > +        enum: retired-page-status
> > > > +      -
> > > > +        name: max-pages
> > > > +        type: uint
> > > > +        doc: Maximum number of pages that can be retired on this node.
> > > >    operations:
> > > >      list:
> > > > @@ -287,6 +323,38 @@ operations:
> > > >                - field
> > > >                - field-name
> > > >                - mode
> > > > +    -
> > > > +      name: get-retired-pages
> > > > +      doc: >-
> > > > +           Retrieve the pages retired on a retired-pages node, one entry per
> > > > +           page. The dump is flagged as interrupted if the list changes while
> > > > +           it is being read.
> > > > +      attribute-set: retired-page-attrs
> > > > +      flags: [admin-perm]
> > > > +      dump:
> > > > +        request:
> > > > +          attributes:
> > > > +            - node-id
> > > > +        reply:
> > > > +          attributes:
> > > Nit:For large number of pages, size and node-id would be repetitive
> > v5 drops node-id from the dump entries, like the error-counter dump.
> > The size stays per page, so a node can report pages of different
> > sizes, if a device ever retires memory at more than one granularity.
> > 
> > > > +            - node-id
> > > > +            - address
> > > > +            - size
> > > > +            - status
> > > > +    -
> > > > +      name: get-retired-pages-info
> > > max-pages since it's not generic ? Or maybe we can add size as part of info
> > > since it will remain same per node.
> > With the size per page, the info is only max-pages for now, and the
> > operation can grow if more node limits come up.
> > 
> > > > +      doc: >-
> > > > +           Retrieve the retired page limits of a retired-pages node.
> > > > +      attribute-set: retired-page-attrs
> > > > +      flags: [admin-perm]
> > > > +      do:
> > > > +        request:
> > > > +          attributes:
> > > > +            - node-id
> > > > +        reply:
> > > > +          attributes:
> > > > +            - node-id
> > > > +            - max-pages
> > > >    mcast-groups:
> > > >      list:
> > > > diff --git a/drivers/gpu/drm/drm_ras.c b/drivers/gpu/drm/drm_ras.c
> > > > index 82fcc766b84b..b6e203448d22 100644
> > > > --- a/drivers/gpu/drm/drm_ras.c
> > > > +++ b/drivers/gpu/drm/drm_ras.c
> > > > @@ -69,6 +69,14 @@
> > > >     *     Each field contains the uAPI defined enum string, its numerical value,
> > > >     *     and its mode bitmask, which encodes read/write capabilities.
> > > >     *
> > > > + * 11. GET_RETIRED_PAGES: Dump the retired pages of a given node.
> > > > + *     Userspace must provide Node ID.
> > > > + *     Returns one entry per page with its address, size and status.
> > > > + *
> > > > + * 12. GET_RETIRED_PAGES_INFO: Get the retired page limits of a given node.
> > > > + *     Userspace must provide Node ID.
> > > > + *     Returns the maximum number of pages that can be retired.
> > > > + *
> > > >     * Node registration:
> > > >     *
> > > >     * - drm_ras_node_register(): Registers a new node and assigns
> > > > @@ -121,6 +129,13 @@
> > > >     *     + The driver can optionally provide a pre_doit callback, telemetry_pre(),
> > > >     *       to enforce permissions checks on telemetry operations.
> > > >     *
> > > > + * - RETIRED_PAGES:
> > > > + *     + The driver must implement the query_retired_page() callback, returning
> > > > + *       the retired page with the lowest address at or above a cursor, and
> > > > + *       -ENOENT when there is none.
> > > With many retired pages (say 10,000 or more), the dump calls into the driver
> > > once per page.
> > >   From a quick look, the driver walks over the list to find lowest address
> > > and for such large number
> > > of pages would cause a noticeable delay
> > > Wouldn't it be better to take a snapshot?
> > I'd like to get the basic support in first.
> > 
> > Anyway, the list is limited by max-pages the firmware can track,
> > so it is not an issue in practice.
> 
> The maximum page count reported by the firmware is currently in the tens of
> thousands for our
> usecase. So this would be an issue in practice
> 
> > Also, if we ever have that many bad pages we have bigger problems
> > than the dump time.
> > 
> > So, the v5 that I'm about to send won't include that, but anyway the
> > patch with the snapshot is ready and tested, for a follow-up:
> > https://github.com/rodrigovivi/linux/commits/xe-ras-retired-pages-snapshot
> > 
> 
> Sure will take a look at this.

Please take a look there, but I will only send that after you give
a confirmation that you are good with the patches 1 and 2 on v5.

So v6 would address any remaining concern from you + add this patch
on top. I don't plan to squash on Aravind patch to avoid changing
his patch a lot.

Thanks,
Rodrigo.

> 
> Thanks
> Riana
> 
> > 
> > Thanks,
> > Rodrigo.
> > 
> > > Thanks
> > > Riana
> > > 
> > > > + *     + The driver can implement query_retired_pages_info() to report the
> > > > + *       maximum number of pages that can be retired.
> > > > + *
> > > >     * Netlink handlers:
> > > >     *
> > > >     * - drm_ras_nl_list_nodes_dumpit(): Implements the LIST_NODES
> > > > @@ -147,6 +162,10 @@
> > > >     * - drm_ras_nl_telemetry_list_fields_dumpit(): Implements the TELEMETRY_LIST_FIELDS
> > > >     *   dumpit operation, enumerating all telemetry fields and their supported
> > > >     *   access modes for a telemetry node.
> > > > + * - drm_ras_nl_get_retired_pages_dumpit(): Implements the GET_RETIRED_PAGES dumpit
> > > > + *   operation, listing the retired pages of a specific node.
> > > > + * - drm_ras_nl_get_retired_pages_info_doit(): Implements the GET_RETIRED_PAGES_INFO
> > > > + *   doit operation, fetching the retired page limits of a specific node.
> > > >     */
> > > >    static DEFINE_XARRAY_ALLOC(drm_ras_xa);
> > > > @@ -162,6 +181,8 @@ struct drm_ras_ctx {
> > > >    	unsigned long restart;
> > > >    	/* Node targeted by a telemetry get/set doit */
> > > >    	struct drm_ras_node *node;
> > > > +	/* Which retired page address to restart the dump from */
> > > > +	u64 cursor;
> > > >    };
> > > >    static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> > > > @@ -169,6 +190,7 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> > > >    /**
> > > >     * drm_ras_node_get() - Look up a RAS node by ID and take a reference
> > > >     * @node_id: ID of the node to look up
> > > > + * @type: Expected type of the node
> > > >     *
> > > >     * Looks the node up in the global xarray and, if found, takes a reference to
> > > >     * it so that it cannot be freed while the caller is using it. The lookup and
> > > > @@ -179,16 +201,19 @@ static_assert(sizeof(struct drm_ras_ctx) <= NETLINK_CTX_SIZE);
> > > >     *
> > > >     * The caller must drop the returned reference with drm_ras_node_put().
> > > >     *
> > > > - * Return: the referenced node, or NULL if no node with @node_id is registered.
> > > > + * Return: the referenced node, or NULL if no node of @type with @node_id is
> > > > + * registered.
> > > >     */
> > > > -static struct drm_ras_node *drm_ras_node_get(u32 node_id)
> > > > +static struct drm_ras_node *drm_ras_node_get(u32 node_id, enum drm_ras_node_type type)
> > > >    {
> > > >    	struct drm_ras_node *node;
> > > >    	xa_lock(&drm_ras_xa);
> > > >    	node = xa_load(&drm_ras_xa, node_id);
> > > > -	if (node)
> > > > +	if (node && node->type == type)
> > > >    		refcount_inc(&node->ref);
> > > > +	else
> > > > +		node = NULL;
> > > >    	xa_unlock(&drm_ras_xa);
> > > >    	return node;
> > > > @@ -412,7 +437,7 @@ static int doit_reply_value(struct genl_info *info, u32 node_id,
> > > >    	u32 value;
> > > >    	int ret;
> > > > -	node = drm_ras_node_get(node_id);
> > > > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> > > >    	if (!node)
> > > >    		return -ENOENT;
> > > > @@ -461,7 +486,7 @@ static int doit_reply_threshold(struct genl_info *info, u32 node_id, u32 error_i
> > > >    	u32 threshold;
> > > >    	int ret;
> > > > -	node = drm_ras_node_get(node_id);
> > > > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> > > >    	if (!node)
> > > >    		return -ENOENT;
> > > > @@ -603,7 +628,7 @@ int drm_ras_nl_get_error_counter_dumpit(struct sk_buff *skb,
> > > >    	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > > > -	node = drm_ras_node_get(node_id);
> > > > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> > > >    	if (!node)
> > > >    		return -ENOENT;
> > > > @@ -699,7 +724,7 @@ int drm_ras_nl_clear_error_counter_doit(struct sk_buff *skb,
> > > >    	node_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_NODE_ID]);
> > > >    	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > > > -	node = drm_ras_node_get(node_id);
> > > > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> > > >    	if (!node || !node->clear_error_counter) {
> > > >    		drm_ras_node_put(node);
> > > >    		return -ENOENT;
> > > > @@ -770,7 +795,7 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> > > >    	error_id = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_ID]);
> > > >    	threshold = nla_get_u32(info->attrs[DRM_RAS_A_ERROR_COUNTER_ATTRS_ERROR_THRESHOLD]);
> > > > -	node = drm_ras_node_get(node_id);
> > > > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_ERROR_COUNTER);
> > > >    	if (!node)
> > > >    		return -ENOENT;
> > > > @@ -781,6 +806,176 @@ int drm_ras_nl_set_error_threshold_doit(struct sk_buff *skb, struct genl_info *i
> > > >    	return ret;
> > > >    }
> > > > +static struct drm_ras_node *get_retired_pages_node(const struct genl_info *info)
> > > > +{
> > > > +	struct nlattr *attr = info->attrs[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID];
> > > > +	struct drm_ras_node *node;
> > > > +
> > > > +	node = drm_ras_node_get(nla_get_u32(attr), DRM_RAS_NODE_TYPE_RETIRED_PAGES);
> > > > +	if (!node)
> > > > +		NL_SET_BAD_ATTR(info->extack, attr);
> > > > +
> > > > +	return node;
> > > > +}
> > > > +
> > > > +static int msg_put_retired_page(struct sk_buff *msg, u32 node_id,
> > > > +				const struct drm_ras_retired_page *page)
> > > > +{
> > > > +	int ret;
> > > > +
> > > > +	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node_id);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS, page->address);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE, page->size);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	return nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS, page->status);
> > > > +}
> > > > +
> > > > +static int dump_retired_pages(struct sk_buff *skb, struct netlink_callback *cb,
> > > > +			      struct drm_ras_node *node)
> > > > +{
> > > > +	const struct genl_info *info = genl_info_dump(cb);
> > > > +	struct drm_ras_ctx *ctx = (void *)cb->ctx;
> > > > +	struct drm_ras_retired_page page;
> > > > +	void *hdr;
> > > > +	int ret;
> > > > +
> > > > +	for (;;) {
> > > > +		ret = node->query_retired_page(node, ctx->cursor, &page);
> > > > +		if (ret && ret != -ENOENT)
> > > > +			return ret;
> > > > +
> > > > +		/* Never zero, so the first message is checked as well */
> > > > +		cb->seq = page.generation + 1;
> > > > +		if (ret == -ENOENT)
> > > > +			return 0;
> > > > +
> > > > +		hdr = genlmsg_iput(skb, info);
> > > > +		if (!hdr)
> > > > +			return -EMSGSIZE;
> > > > +
> > > > +		ret = msg_put_retired_page(skb, node->id, &page);
> > > > +		if (ret) {
> > > > +			genlmsg_cancel(skb, hdr);
> > > > +			return ret;
> > > > +		}
> > > > +
> > > > +		genl_dump_check_consistent(cb, hdr);
> > > > +
> > > > +		genlmsg_end(skb, hdr);
> > > > +		ctx->cursor = page.address + 1;
> > > > +	}
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_ras_nl_get_retired_pages_dumpit() - Dump the retired pages of a node
> > > > + * @skb: Netlink message buffer
> > > > + * @cb: Callback context for multi-part dumps
> > > > + *
> > > > + * Appends one message per retired page, in increasing address order. The
> > > > + * dump resumes from the next address after a buffer overflow, and is flagged
> > > > + * with %NLM_F_DUMP_INTR if the list changed between messages.
> > > > + *
> > > > + * Return: 0 if all pages fit in @skb, -EMSGSIZE if the buffer filled up
> > > > + *         (requires multi-part continuation), or a negative error code on
> > > > + *         failure.
> > > > + */
> > > > +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> > > > +					struct netlink_callback *cb)
> > > > +{
> > > > +	const struct genl_info *info = genl_info_dump(cb);
> > > > +	struct drm_ras_node *node;
> > > > +	int ret;
> > > > +
> > > > +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> > > > +		return -EINVAL;
> > > > +
> > > > +	node = get_retired_pages_node(info);
> > > > +	if (!node)
> > > > +		return -ENOENT;
> > > > +
> > > > +	ret = dump_retired_pages(skb, cb, node);
> > > > +	drm_ras_node_put(node);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +static int doit_reply_retired_pages_info(struct genl_info *info, struct drm_ras_node *node)
> > > > +{
> > > > +	struct sk_buff *msg;
> > > > +	u64 max_pages;
> > > > +	void *hdr;
> > > > +	int ret;
> > > > +
> > > > +	if (!node->query_retired_pages_info)
> > > > +		return -EOPNOTSUPP;
> > > > +
> > > > +	ret = node->query_retired_pages_info(node, &max_pages);
> > > > +	if (ret)
> > > > +		return ret;
> > > > +
> > > > +	msg = genlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
> > > > +	if (!msg)
> > > > +		return -ENOMEM;
> > > > +
> > > > +	hdr = genlmsg_iput(msg, info);
> > > > +	if (!hdr) {
> > > > +		ret = -EMSGSIZE;
> > > > +		goto free_msg;
> > > > +	}
> > > > +
> > > > +	ret = nla_put_u32(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID, node->id);
> > > > +	if (ret)
> > > > +		goto cancel_msg;
> > > > +
> > > > +	ret = nla_put_uint(msg, DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES, max_pages);
> > > > +	if (ret)
> > > > +		goto cancel_msg;
> > > > +
> > > > +	genlmsg_end(msg, hdr);
> > > > +
> > > > +	return genlmsg_reply(msg, info);
> > > > +
> > > > +cancel_msg:
> > > > +	genlmsg_cancel(msg, hdr);
> > > > +free_msg:
> > > > +	nlmsg_free(msg);
> > > > +	return ret;
> > > > +}
> > > > +
> > > > +/**
> > > > + * drm_ras_nl_get_retired_pages_info_doit() - Query the retired page limits of a node
> > > > + * @skb: Netlink message buffer
> > > > + * @info: Generic Netlink info containing attributes of the request
> > > > + *
> > > > + * Return: 0 on success, or negative errno on failure.
> > > > + */
> > > > +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
> > > > +					   struct genl_info *info)
> > > > +{
> > > > +	struct drm_ras_node *node;
> > > > +	int ret;
> > > > +
> > > > +	if (!info->attrs || GENL_REQ_ATTR_CHECK(info, DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID))
> > > > +		return -EINVAL;
> > > > +
> > > > +	node = get_retired_pages_node(info);
> > > > +	if (!node)
> > > > +		return -ENOENT;
> > > > +
> > > > +	ret = doit_reply_retired_pages_info(info, node);
> > > > +	drm_ras_node_put(node);
> > > > +
> > > > +	return ret;
> > > > +}
> > > > +
> > > >    /**
> > > >     * drm_ras_nl_pre_telemetry - Look up the telemetry node and enforce permissions
> > > >     * @ops: Generic netlink operations
> > > > @@ -808,10 +1003,9 @@ int drm_ras_nl_pre_telemetry(const struct genl_split_ops *ops, struct sk_buff *s
> > > >    		return -EINVAL;
> > > >    	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > > > -	node = drm_ras_node_get(node_id);
> > > > -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
> > > > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
> > > > +	if (!node) {
> > > >    		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > > > -		drm_ras_node_put(node);
> > > >    		return -ENOENT;
> > > >    	}
> > > > @@ -892,10 +1086,9 @@ int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb, struct netlink_
> > > >    	node_id = nla_get_u32(info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > > > -	node = drm_ras_node_get(node_id);
> > > > -	if (!node || node->type != DRM_RAS_NODE_TYPE_TELEMETRY) {
> > > > +	node = drm_ras_node_get(node_id, DRM_RAS_NODE_TYPE_TELEMETRY);
> > > > +	if (!node) {
> > > >    		NL_SET_BAD_ATTR(info->extack, info->attrs[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID]);
> > > > -		drm_ras_node_put(node);
> > > >    		return -ENOENT;
> > > >    	}
> > > > @@ -1100,7 +1293,6 @@ int drm_ras_node_register(struct drm_ras_node *node)
> > > >    	if (!node->device_name || !node->node_name)
> > > >    		return -EINVAL;
> > > > -	/* Currently, only Error Counter and Telemetry endpoints are supported */
> > > >    	switch (node->type) {
> > > >    	case DRM_RAS_NODE_TYPE_ERROR_COUNTER:
> > > >    		/* Mandatory entries for Error Counter Node */
> > > > @@ -1112,6 +1304,10 @@ int drm_ras_node_register(struct drm_ras_node *node)
> > > >    		if (!node->telemetry_get || !node->telemetry_fields)
> > > >    			return -EINVAL;
> > > >    		break;
> > > > +	case DRM_RAS_NODE_TYPE_RETIRED_PAGES:
> > > > +		if (!node->query_retired_page)
> > > > +			return -EINVAL;
> > > > +		break;
> > > >    	default:
> > > >    		return -EINVAL;
> > > >    	}
> > > > diff --git a/drivers/gpu/drm/drm_ras_nl.c b/drivers/gpu/drm/drm_ras_nl.c
> > > > index 589c6445eff7..c56220205876 100644
> > > > --- a/drivers/gpu/drm/drm_ras_nl.c
> > > > +++ b/drivers/gpu/drm/drm_ras_nl.c
> > > > @@ -59,6 +59,16 @@ static const struct nla_policy drm_ras_telemetry_list_fields_nl_policy[DRM_RAS_A
> > > >    	[DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > >    };
> > > > +/* DRM_RAS_CMD_GET_RETIRED_PAGES - dump */
> > > > +static const struct nla_policy drm_ras_get_retired_pages_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
> > > > +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > > +};
> > > > +
> > > > +/* DRM_RAS_CMD_GET_RETIRED_PAGES_INFO - do */
> > > > +static const struct nla_policy drm_ras_get_retired_pages_info_nl_policy[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID + 1] = {
> > > > +	[DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID] = { .type = NLA_U32, },
> > > > +};
> > > > +
> > > >    /* Ops table for drm_ras */
> > > >    static const struct genl_split_ops drm_ras_nl_ops[] = {
> > > >    	{
> > > > @@ -126,6 +136,20 @@ static const struct genl_split_ops drm_ras_nl_ops[] = {
> > > >    		.maxattr	= DRM_RAS_A_TELEMETRY_ATTRS_NODE_ID,
> > > >    		.flags		= GENL_CMD_CAP_DUMP,
> > > >    	},
> > > > +	{
> > > > +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES,
> > > > +		.dumpit		= drm_ras_nl_get_retired_pages_dumpit,
> > > > +		.policy		= drm_ras_get_retired_pages_nl_policy,
> > > > +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
> > > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DUMP,
> > > > +	},
> > > > +	{
> > > > +		.cmd		= DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
> > > > +		.doit		= drm_ras_nl_get_retired_pages_info_doit,
> > > > +		.policy		= drm_ras_get_retired_pages_info_nl_policy,
> > > > +		.maxattr	= DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID,
> > > > +		.flags		= GENL_ADMIN_PERM | GENL_CMD_CAP_DO,
> > > > +	},
> > > >    };
> > > >    static const struct genl_multicast_group drm_ras_nl_mcgrps[] = {
> > > > diff --git a/drivers/gpu/drm/drm_ras_nl.h b/drivers/gpu/drm/drm_ras_nl.h
> > > > index 7a1cba70fd50..880b0c2befe3 100644
> > > > --- a/drivers/gpu/drm/drm_ras_nl.h
> > > > +++ b/drivers/gpu/drm/drm_ras_nl.h
> > > > @@ -34,6 +34,10 @@ int drm_ras_nl_telemetry_get_doit(struct sk_buff *skb, struct genl_info *info);
> > > >    int drm_ras_nl_telemetry_set_doit(struct sk_buff *skb, struct genl_info *info);
> > > >    int drm_ras_nl_telemetry_list_fields_dumpit(struct sk_buff *skb,
> > > >    					    struct netlink_callback *cb);
> > > > +int drm_ras_nl_get_retired_pages_dumpit(struct sk_buff *skb,
> > > > +					struct netlink_callback *cb);
> > > > +int drm_ras_nl_get_retired_pages_info_doit(struct sk_buff *skb,
> > > > +					   struct genl_info *info);
> > > >    enum {
> > > >    	DRM_RAS_NLGRP_ERROR_REPORT,
> > > > diff --git a/include/drm/drm_ras.h b/include/drm/drm_ras.h
> > > > index 76bdcc6f96a5..5c3900a53278 100644
> > > > --- a/include/drm/drm_ras.h
> > > > +++ b/include/drm/drm_ras.h
> > > > @@ -28,6 +28,23 @@ struct drm_ras_telemetry_field {
> > > >    	u32 mode;
> > > >    };
> > > > +/**
> > > > + * struct drm_ras_retired_page - A retired page reported by a driver
> > > > + */
> > > > +struct drm_ras_retired_page {
> > > > +	/** @address: Device address of the page. */
> > > > +	u64 address;
> > > > +	/** @size: Size of the page in bytes. */
> > > > +	u64 size;
> > > > +	/** @status: Retirement status (enum drm_ras_retired_page_status). */
> > > > +	enum drm_ras_retired_page_status status;
> > > > +	/**
> > > > +	 * @generation: Generation of the retired page list, changed by the
> > > > +	 * driver whenever a page is added, removed or changes status.
> > > > +	 */
> > > > +	u32 generation;
> > > > +};
> > > > +
> > > >    /**
> > > >     * struct drm_ras_node - A DRM RAS Node
> > > >     */
> > > > @@ -184,6 +201,38 @@ struct drm_ras_node {
> > > >    	int (*telemetry_set)(struct drm_ras_node *ep, u64 *field, s64 *value,
> > > >    			     s64 *status);
> > > > +	/* Retired-Pages Related Callbacks */
> > > > +
> > > > +	/**
> > > > +	 * @query_retired_page:
> > > > +	 *
> > > > +	 * This callback is used by drm-ras to list the retired pages of a node.
> > > > +	 * It must fill @page with the retired page that has the lowest address
> > > > +	 * greater than or equal to @cursor. @page->generation must be set even
> > > > +	 * when no page is found.
> > > > +	 *
> > > > +	 * The @query_retired_page is a mandatory callback for
> > > > +	 * retired_pages_node.
> > > > +	 *
> > > > +	 * Returns: 0 on success,
> > > > +	 *          -ENOENT when no page is at or above @cursor, which ends the
> > > > +	 *                  list.
> > > > +	 *          Other negative values on errors that should terminate the
> > > > +	 *          netlink query.
> > > > +	 */
> > > > +	int (*query_retired_page)(struct drm_ras_node *node, u64 cursor,
> > > > +				  struct drm_ras_retired_page *page);
> > > > +
> > > > +	/**
> > > > +	 * @query_retired_pages_info:
> > > > +	 *
> > > > +	 * This callback is used by drm-ras to query the maximum number of pages
> > > > +	 * that can be retired on a node.
> > > > +	 *
> > > > +	 * Returns: 0 on success, negative error code on failure.
> > > > +	 */
> > > > +	int (*query_retired_pages_info)(struct drm_ras_node *node, u64 *max_pages);
> > > > +
> > > >    	/** @priv: Driver private data */
> > > >    	void *priv;
> > > > diff --git a/include/uapi/drm/drm_ras.h b/include/uapi/drm/drm_ras.h
> > > > index 56e0588af5d5..e7f2da18cc4c 100644
> > > > --- a/include/uapi/drm/drm_ras.h
> > > > +++ b/include/uapi/drm/drm_ras.h
> > > > @@ -12,12 +12,14 @@
> > > >    /*
> > > >     * Type of the node. The error-counter nodes expose reliability counters for a
> > > > - * hardware/software component, and telemetry nodes expose an interface for
> > > > - * reading and writing telemetry values to a device.
> > > > + * hardware/software component, telemetry nodes expose an interface for reading
> > > > + * and writing telemetry values to a device, and retired-pages nodes list the
> > > > + * memory pages that have been taken out of service.
> > > >     */
> > > >    enum drm_ras_node_type {
> > > >    	DRM_RAS_NODE_TYPE_ERROR_COUNTER = 1,
> > > >    	DRM_RAS_NODE_TYPE_TELEMETRY,
> > > > +	DRM_RAS_NODE_TYPE_RETIRED_PAGES,
> > > >    };
> > > >    /*
> > > > @@ -28,6 +30,18 @@ enum drm_ras_telemetry_field_mode {
> > > >    	DRM_RAS_TELEMETRY_FIELD_MODE_WRITE = 2,
> > > >    };
> > > > +/*
> > > > + * Status of a retired page. retired means the page is reserved and out of
> > > > + * service; pending means the retirement is queued but the reservation is not
> > > > + * complete yet; failed means the reservation failed and the page may still be
> > > > + * in use.
> > > > + */
> > > > +enum drm_ras_retired_page_status {
> > > > +	DRM_RAS_RETIRED_PAGE_STATUS_RETIRED = 1,
> > > > +	DRM_RAS_RETIRED_PAGE_STATUS_PENDING,
> > > > +	DRM_RAS_RETIRED_PAGE_STATUS_FAILED,
> > > > +};
> > > > +
> > > >    enum {
> > > >    	DRM_RAS_A_NODE_ATTRS_NODE_ID = 1,
> > > >    	DRM_RAS_A_NODE_ATTRS_DEVICE_NAME,
> > > > @@ -73,6 +87,17 @@ enum {
> > > >    	DRM_RAS_A_TELEMETRY_ATTRS_MAX = (__DRM_RAS_A_TELEMETRY_ATTRS_MAX - 1)
> > > >    };
> > > > +enum {
> > > > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_NODE_ID = 1,
> > > > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_ADDRESS,
> > > > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_SIZE,
> > > > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_STATUS,
> > > > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX_PAGES,
> > > > +
> > > > +	__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX,
> > > > +	DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX = (__DRM_RAS_A_RETIRED_PAGE_ATTRS_MAX - 1)
> > > > +};
> > > > +
> > > >    enum {
> > > >    	DRM_RAS_CMD_LIST_NODES = 1,
> > > >    	DRM_RAS_CMD_GET_ERROR_COUNTER,
> > > > @@ -83,6 +108,8 @@ enum {
> > > >    	DRM_RAS_CMD_TELEMETRY_GET,
> > > >    	DRM_RAS_CMD_TELEMETRY_SET,
> > > >    	DRM_RAS_CMD_TELEMETRY_LIST_FIELDS,
> > > > +	DRM_RAS_CMD_GET_RETIRED_PAGES,
> > > > +	DRM_RAS_CMD_GET_RETIRED_PAGES_INFO,
> > > >    	__DRM_RAS_CMD_MAX,
> > > >    	DRM_RAS_CMD_MAX = (__DRM_RAS_CMD_MAX - 1)
