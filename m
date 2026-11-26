Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FE3606A32E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 06:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RZ6xQ4XA;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=gsORzs/j
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 31B8010E1C8;
	Thu, 26 Nov 2026 06:19:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD00810E05C;
 Thu, 26 Nov 2026 06:19:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795673967; x=1827209967;
 h=from:to:cc:subject:date:message-id:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=OxGsC7fYO0DON3jzlMxpLhem3ua+iZVlAAqqnubct6Y=;
 b=RZ6xQ4XAMbcZItOX/P6LwKEl4Qt9BbPv0eygFtet7XMJ2M+Hj7DuAGHS
 ySBmfcsmzq1bqdPfyae3tGk/ijrlSW64ukpD6fVblZIAv0QUJMYFyLRS5
 BwqvkQUzzQefP6S8sP6Z7Lct/5PWF6j3RFBdPUlJ66baX6WBmMtIxVkL+
 9smKvvQyVQ0cp5nD2jieMoX3c5h7QWuarhoSF1v6RfFWaKQ0la+f8wdZf
 F+diboEH/SFkWOVlxqJCu5Otmh16/xQRDp4gW+n+Ec8KKRvHYtrA2v+hs
 QxIkl6f1mKprRLESZTt1QK5Gsl2MMHj0BELc8apeiFTyUZ/CPkcD0qZWZ A==;
X-CSE-ConnectionGUID: 7GRky1t8Q32OqV/bhGSd+A==
X-CSE-MsgGUID: NejHetj9S+CIPS68YKi+/g==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4475818"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4475818"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 22:19:26 -0800
X-CSE-ConnectionGUID: +wGoQiTSSRq20oHI3FT4kg==
X-CSE-MsgGUID: NEhYEm/xRjyYPyVM2cKodQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="11871375"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 22:19:26 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 22:19:25 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Wed, 25 Nov 2026 22:19:25 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.42) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Wed, 25 Nov 2026 22:19:25 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CAQk6dgMfWn6bsIZvzlbPDCpzUgprROSBNA+j1tEb2GE661oRP/PPwEcG/NTvVw3tnbexr9TAyEYdPvU0w1gUavypcMyQAY50l9mInSTamxx1dGv8sgt2xFOrMBqrF8yoWF8ka4AhsO24vfN9oebJvlxC4sYsemWnoPKrYrv9aawnLp0TNPKlq+ophKPZkmMEj/3VtQfJE0UxxlxHI81tIjhIh80HLY+i2K6hRi4O2HlD+LgpZn+zTBbfCYdgT31ggecR2BZ8u0oBiSVy40/2Y6I4m+cZAkyicmnkCu3SRaFLKIJq9xfMHAbYbLvl9Rp8EvyuJSqXFybd+uQpDsGcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GfNzKPg4BxvnuCThHfNWRNVTu0RJnnTa4V6T4aEuwvk=;
 b=UqRhtX9FU/BWIG9PtewZUPUroYEoJQHIStrK3wdUUHX5hj7+7xA7Ta8fuqoJMM94txzoLupK1+cbkzXiSIMRoIeEe5uxIQSoalLiWkY6qOm9659RluzOEkxTN/Uri3Kk7XQPHYgOYQbFvsrqzEvUU+rhXGJMhGBFdI10UCnNUhO806SCj8JCH0cIATtReK906ixSs1ICRtF9Q3B4FkEqYfXm+ihoFWFaVyRarCpPsi5vU8Tr+tCjyrt/AoNPYIBc7Um1uyrAIkCGiAnJRlxFjplAHwbP8hX24ISN2mU7UvwFz3SWVY1eijYMH70GxFsl0MMDcLMu66nwKhkM+RIeKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GfNzKPg4BxvnuCThHfNWRNVTu0RJnnTa4V6T4aEuwvk=;
 b=gsORzs/jPiGT7U1hzQscJPZRw5qgUGo/KuUKf51+kiCIILz6bNCpnWZZktg7o0aZj4OvtDQUWHzU8LTono/5nr5z7GH0LtdMxv132/72FcdO3uTHp2ceXOULrGfl1sNdjSflY/VO9piYdMPE+Wr6NkaDBsXGTAqULuhwb1jg87Q=
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::5b) by CH3PR11MB7913.namprd11.prod.outlook.com
 (2603:10b6:610:12e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.6; Thu, 26 Nov
 2026 06:19:17 +0000
Received: from DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff]) by DS4PPFE901A304F.namprd11.prod.outlook.com
 ([fe80::19f5:13eb:df52:68ff%8]) with mapi id 15.21.0662.004; Thu, 26 Nov 2026
 06:19:16 +0000
From: "Kandpal, Suraj" <suraj.kandpal@intel.com>
To: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "freedreno@lists.freedesktop.org" <freedreno@lists.freedesktop.org>,
 "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
 "linux-renesas-soc@vger.kernel.org" <linux-renesas-soc@vger.kernel.org>,
 "intel-gfx@lists.freedesktop.org" <intel-gfx@lists.freedesktop.org>,
 "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC: "dmitry.baryshkov@oss.qualcomm.com" <dmitry.baryshkov@oss.qualcomm.com>,
 "John.Harrison@Igalia.com" <John.Harrison@Igalia.com>,
 "kernel-dev@igalia.com" <kernel-dev@igalia.com>, "alex.hung@amd.com"
 <alex.hung@amd.com>, "liviu.dudau@arm.com" <liviu.dudau@arm.com>,
 "louis.chauvet@bootlin.com" <louis.chauvet@bootlin.com>,
 "maarten.lankhorst@linux.intel.com" <maarten.lankhorst@linux.intel.com>,
 "mripard@kernel.org" <mripard@kernel.org>, "tzimmermann@suse.de"
 <tzimmermann@suse.de>, "airlied@gmail.com" <airlied@gmail.com>,
 "simona@ffwll.ch" <simona@ffwll.ch>,
 "laurent.pinchart+renesas@ideasonboard.com"
 <laurent.pinchart+renesas@ideasonboard.com>,
 "tomi.valkeinen+renesas@ideasonboard.com"
 <tomi.valkeinen+renesas@ideasonboard.com>,
 "kieran.bingham+renesas@ideasonboard.com"
 <kieran.bingham+renesas@ideasonboard.com>, "dave.stevenson@raspberrypi.com"
 <dave.stevenson@raspberrypi.com>, "mcanal@igalia.com" <mcanal@igalia.com>,
 "kernel-list@raspberrypi.com" <kernel-list@raspberrypi.com>, "Shankar, Uma"
 <uma.shankar@intel.com>, "Murthy, Arun R" <arun.r.murthy@intel.com>
Subject: RE: [PATCH v8 0/7] Refactor drm_writeback_connector structure
Thread-Topic: [PATCH v8 0/7] Refactor drm_writeback_connector structure
Thread-Index: AQHdfV6qojB2p2NT4U+CKNAPLcmEt7c/4TPw
Date: Thu, 26 Nov 2026 06:19:16 +0000
Message-ID: <DS4PPFE901A304FF744429AF1A2453FDAB5E3422@DS4PPFE901A304F.namprd11.prod.outlook.com>
References: <20261126042835.436307-1-suraj.kandpal@intel.com>
In-Reply-To: <20261126042835.436307-1-suraj.kandpal@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS4PPFE901A304F:EE_|CH3PR11MB7913:EE_
x-ms-office365-filtering-correlation-id: 077c3829-6e94-4e09-2f43-08df4b8532ed
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|7416014|1800799024|38070700021|10067099003|11063799006|56012099006|261021121427099003|261021123027099003|261009223027099003|261009221727099003|261009221227099003|261009223327099003|261009220027099003|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261102123227099003|261028144727099003|22082099003|18002099003;
x-microsoft-antispam-message-info: XBa/PKvjbgVdSgPIRiY2yC2twS1xco7XPLhO9Kj34Kh7gW2cnP+opEfRfc/P425Rm6NlPDIwazN3Yb2+cIFelMdd9SG5UL+kCkpGFKVSQrjY+unYawySM3p/UaG+Q/FefBiVPjVkE055Lc5kLBD3kgtY0zWpr6pQ1C4oNodDJYEiKfKT29pvDWusPh2fRXiJ0EowKh3i5lKntRqou0552uvuA8Blc3NuxqnZSx9mcqaZrxsppBhbikYe2A4Md1tvECFEByCWY5BwdnpA5KIUaHDxZdaeQF21wuG3OEPAWX8pTytZd/Bm1D7N3Z5vwEJqH5I5P2t44B1ghrwWJYfrnSxCzB55UWMHNTKjRzDvox1VcHW/iD1uiZtS0OPAjfy8URF0xPfiQkTwZoqgIrkVWAglfxFpaV83r5K3orK+NzC89ZTS0Yd+JKvAeY5EtH9vxkVVJzJMIMdCa6fvi1teDk4ZouJTmw+N+7HJnEzUU9OIm2UbLEGuyrSMY7oL3IT1phMJ1L+ln3GNPAkkQbU+ztcFPwWVXNKc77lhXXQCVawWQyuhQ6Xmy93vHtxPKfNlA5aAMFY2xxPftUg3FK3wGnIdx0VxkNPgQnSIxncDAxe6u/JCgQk3bdTfiAquEWtLOXidCwp9s9IUNdWGGiGuZX6GOzUXgETauNZbSNeDuvM=
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PPFE901A304F.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(7416014)(1800799024)(38070700021)(10067099003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261009221727099003)(261009221227099003)(261009223327099003)(261009220027099003)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261102123227099003)(261028144727099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?0ADrDY1C+oYmOi+7AHFVzqJ6di9vzEjmLoJaqT3LrS2RlyfmFK9MQL25BGy1?=
 =?us-ascii?Q?waByO5JxuD5Ui7bu0oCUjuXHFU05vnTJdbLl2bM/U1kiS0SPfkjZ2SGP+E7O?=
 =?us-ascii?Q?jM1VHGi3yPGbZS2kLpjDMQg/zdQwuGru6nbnWmbssgAxo/5q6FuFbIwPTdYX?=
 =?us-ascii?Q?n4ZGFvM/kH33wAXwjIiaI5//hJox5BRXlFWjNDv9yrkug4t2piPbvU8qxcjT?=
 =?us-ascii?Q?fmAPF5s/0We4hicBVTtBsd9h8ZNoCU4tdRVpi+nuhQ9xdEolKU2bpg7jqWlQ?=
 =?us-ascii?Q?I82nWPk+pXZHuA+ObFROh50NkAKPx3NFpj5Wknuo30LllCzdkasECNbJovdK?=
 =?us-ascii?Q?Qw6mFt3rtCEmY3dWfvCm6o00xR30wzsG/AflkSR7lMDneye15Qy0OavC/aBQ?=
 =?us-ascii?Q?3SyCEa8+etOIsT9F1XHQtpkIEIaUUz1/U/CCycElNanyp6HfWTYvkWxZ0W+0?=
 =?us-ascii?Q?irJJ5/WYUsQNVNv7yqWsaPcy8v6wcvTXNZTdp8Ms26qRuSkMUqWzjRgNs+UT?=
 =?us-ascii?Q?LQPaYgEOln4pMq55shdQ+6qIXFpIgR5bhiyCgRJptjXoaowEA+eFn40vs9ES?=
 =?us-ascii?Q?baNeR6bnJHUZgoI5VTe1VBfQcCLi8bBSZMYNjbqXkmL9VNi1R5s4f45CPioV?=
 =?us-ascii?Q?lmRu5t/fI3keS0PR4TwV/UzNTsRueAG5BA5f6X6hZ1larlokKflx413cmiKH?=
 =?us-ascii?Q?ZVCGKOgJbr0mADEeXU5G+l7RyTckza9VvmR9LX3l/+JSCWzwkO6CX2P/o6Jb?=
 =?us-ascii?Q?6rTUpUWLFfCz9uzRXLQjQm+An9DsNZdqJlf/4WN4eAS6uBDLGPB3cLAmFDi6?=
 =?us-ascii?Q?1cVwsom4Msyf6rLL7Y68hZjVcZ7B9hvx/PeDG09kPD1e5jck7vhfChej7JyX?=
 =?us-ascii?Q?MhwJ16guE0O21tKHodiNJgG3mQgm0kWSadrSHT6A+ortvoq24YI/tvLwW8+K?=
 =?us-ascii?Q?KqRsbGgcovya74vInQnjGKtOFtm9t3Qi8yS0opADiz6KbAhRyAeXvSdWZr+K?=
 =?us-ascii?Q?seDO35l5rRJYSbVv8ycXsK79M5WV72LL0+oQ1jrNx9vgjJiRN7JuMozdX9pO?=
 =?us-ascii?Q?sNO/Y+fKjqmifejiWcGodZJmuugs4g1bqke0lG4IuZc0taT+bMC1PWMbQIpO?=
 =?us-ascii?Q?gKOyzECdPMFd5Z6VU9Ahdwgtvcg2nbMyFjQvw7WOKg5u1JaDmc3b0mjuHfIE?=
 =?us-ascii?Q?lX0oA9eHROUDKFujJHCjJkfneuQ/zRAkm2nbD1Ez2WbchE7s3r2WvF/o1QJF?=
 =?us-ascii?Q?HQ0kPzZhusqxubTKMqWAKwgJxHmsaDRELeOa4kr4/VHpl/pXjo+qPhy0LkmP?=
 =?us-ascii?Q?w3v1UynJgrN7DZkRA4bUk8s8t7qxVZ7bIIb4XbORiLhu9FPsJyN5oWjKMmFQ?=
 =?us-ascii?Q?uH2zn3eP5I2Vw//oa4CSE6HCTmzNd5dZoqLbdYcBwmZQPyjEvUPl2cF1Xhfq?=
 =?us-ascii?Q?eQsdWVq4c2I1I/7l56XDQtG/KkH3UGOESgHJhqe4nx7Td5zJFGX4Je8Fmkd6?=
 =?us-ascii?Q?LqMGT3nc51oCOgySr1Tv3thnl85qe7Y9AEWgFEjV3Z74ij7mVW+weUWVmwuK?=
 =?us-ascii?Q?xrYvrFOKJDgFB0YM+P3dOWINc045xYWCXVIokC5BS9lm5AuBVgsCGHeOrD66?=
 =?us-ascii?Q?TLmbQeXQekrHbuGTTUeJU6Et1+WD8gn+hg5xeYYNTNjOitpwgQHu5vLLEoBI?=
 =?us-ascii?Q?BJ4PjLs7PRBT+U2lz5ww/MvmILNx4T9QRsJ+VKW3Sgwv4/6sNIU50Klv+rXa?=
 =?us-ascii?Q?f464cMeftQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked: UBvbLvYgZWzBKxQVCrBp6nhMlU6azEk7wndHPHHH1DCZ0ODdNdr+bTWzUAFGXKc0HO8kPKrHQpTh6Ph0XnznpaInCsms8OHJkod8ZK+gYDPUt7+0b+PLXagUc9t9nwWckbpAs0r0aIKJ03ETvQNLpds0Px1TnflojlerXZxqJkAbmVUs2nkkM/rcPuEeXBLbGQtIJmDazSQll/9w1nMVwXPt0mlxzqwh4nCn5piLQgxOvJrXzUTJ4czBlBbJaQlisQIBngiCdsdBaTcjKeP0oZCCQgoTqcdxqBFUXv6aAAB98SbKU8ARFNON2+NFx8l4VtiL2Vcl2ho+wHDrJs8H1Q==
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFE901A304F.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 077c3829-6e94-4e09-2f43-08df4b8532ed
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Nov 2026 06:19:16.6736 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ipS1EvMQmIxJtbvICXI131RLEmSClTuGpjvQP4nzBOk09aLLlBHRQEyR1JT1RL707DMm2UyuVgwitYPOqsQVQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7913
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

>=20
> Some drivers cannot work with the current design where the connector is
> embedded within the drm_writeback_connector such as intel and some
> drivers that can get it working end up adding a lot of checks all around =
the
> code to check if it's a writeback conenctor or not.
> This is due to the inheritance limitation in C.
> This series intends to solve it by moving the drm_writeback_connector wit=
hin
> the drm_connector and remove the drm_connector base which was in
> drm_writeback_connector. This is done in union with hdmi connector within
> drm_connector to save memory and since drm_connector cannot be both
> hdmi and writeback it serves is well.
> A RFC version was floated and discussion had taken place at [1] which kic=
ked
> of this more cleaner series.
> We do all other required modifications that come with these changes along
> with addition of new function which returns the drm_connector when
> drm_writeback_connector is present.
> This series also contains some writeback API cleanups as a consequence of
> writeback connector moving into drm_connector All drivers will be expecte=
d
> to allocate the drm_connector.
> This discussion was tiggered from [2]
>=20
> [1] https://patchwork.freedesktop.org/series/152758/
> [2] https://patchwork.freedesktop.org/series/152106/
>=20
> Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>

Thanks everyone for the changes merged to drm-misc-next

Regards,
Suraj Kandpal=20

>=20
> Suraj Kandpal (7):
>   drm: writeback: Refactor drm_writeback_connector structure
>   drm: writeback: Modify writeback init helpers
>   drm: writeback: Modify drm_writeback_queue_job helper
>   drm: writeback: Modify drm_writeback_signal_completion helper
>   drm: writeback: Modify drm_writeback_get_out_fence helper
>   drm: writeback: Modify prepare_writeback_job helper
>   drm: writeback: Modify cleanup_writeback_job helper
>=20
>  .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  8 +-
> .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
>  .../display/amdgpu_dm/amdgpu_dm_connector.c   |  4 +-
>  .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 10 +--
> .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |  4 +-
>  .../tests/amdgpu_dm_connector_test.c          |  6 +-
>  .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |  2 +-
>  .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  6 +-
>  .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +-
>  .../gpu/drm/arm/display/komeda/komeda_kms.h   |  6 +-
>  .../arm/display/komeda/komeda_wb_connector.c  | 13 ++--
>  drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
>  drivers/gpu/drm/arm/malidp_drv.h              |  2 +-
>  drivers/gpu/drm/arm/malidp_mw.c               |  7 +-
>  drivers/gpu/drm/drm_atomic_uapi.c             |  4 +-
>  drivers/gpu/drm/drm_writeback.c               | 50 +++++++-----
>  .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  9 ++-
>  drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 10 +--
> drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h |  4 +-
>  .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  6 +-
>  .../drm/renesas/rcar-du/rcar_du_writeback.c   | 17 ++---
>  drivers/gpu/drm/vc4/vc4_txp.c                 |  8 +-
>  drivers/gpu/drm/vkms/vkms_drv.h               |  2 +-
>  drivers/gpu/drm/vkms/vkms_writeback.c         | 15 ++--
>  include/drm/drm_connector.h                   | 72 ++++++++++++++++--
>  include/drm/drm_modeset_helper_vtables.h      |  4 +-
>  include/drm/drm_writeback.h                   | 76 ++-----------------
>  27 files changed, 174 insertions(+), 177 deletions(-)
>=20
> --
> 2.34.1

