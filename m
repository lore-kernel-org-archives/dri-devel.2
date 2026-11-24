Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27E8D606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 20:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RpwfNLXt;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=kgOe7A0C
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8499A10F0C1;
	Tue, 24 Nov 2026 20:42:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AAF7910E8C0;
 Tue, 24 Nov 2026 20:42:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795552966; x=1827088966;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Is0Kuc+3S7shP1SASnTAr67vzHH/P6j99l+wsVaKA54=;
 b=RpwfNLXt8aadIpVvQgui/UA3oGYDnsurwRl/Sao8O4icXE7xqPo1H5OK
 pl3tplTf8aUQgyiCZiaW3SlcSMQBzttpvhF4hnlyhMA08vcjz2U2z/eSG
 CoHNhY8tQP0TyJ5p6tor9KOb+S4vnJJgEQ69RSw/D/5GDp+nIQvcxEsQn
 GWJfGVEWYoOY7A8lxSyx8nJtOfXTFg257pdsyP3N3cYrSGZ5a4SOsoUik
 3n+ZoulnR6iQA0mfilpsWZGUvyJJxyYlM66o+YkJsvrU/5YPZikrquzSV
 J718d5BrBSQd4KdBCW3nCJ6WyPwDzspKaeFnzXidbn5vy5BxbyWBzW39h Q==;
X-CSE-ConnectionGUID: TgiYYU/6S9KXs1FaQHy96A==
X-CSE-MsgGUID: YonUX+BoQXWEA/B9R8wbJQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11976"; a="4339074"
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; 
   d="scan'208";a="4339074"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:42:45 -0800
X-CSE-ConnectionGUID: Tk4soICtQR2/ehDGxpi6Nw==
X-CSE-MsgGUID: k/Tv3FJAScyKigg0NeQtRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,231,1787036400"; d="scan'208";a="11795793"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 12:42:45 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:42:44 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 12:42:44 -0800
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.62) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 12:42:43 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dMqlSkWWXtTbOBmB96L4m1nMOF6gpJC1XGy/hlZ4f+LdnmyTBdJ0cRZcEOIHxpndXSSu9H4d2PQmhyWMoGFmAIuViSqdGB+cdLch2QvDvwf8o+68F6hOaTobOaFL8DVJ+AMVoCi56SVSDg1C4scxjbK/ocz7dir8t4tBUe431x0hTxhwSfblE7FhXH+DKbgKdu+gLjTMQb7lnUAOQwghUwo8dkZG9v/0A2Dlnr6uwBIbpHl6Tr2gRMUll+S6e88vb+kQlpeiAk8KnYtpTy/cxS/ZBCgbkMi6caS1060svjG3UI/fHNBE/t+cANSCfWfpT3qyITDYY6LVlcD3MKp90Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ym3XjmhfgPs6Q8Q9adhNZup9WsF3HyZpr4KFej+rvD8=;
 b=q/3AAUQEts+xLworsjWSBqUbVkJxo5PyhiK9DhBqM2JUkrF5+0uDN4RaPxHhmoJWSbRvHwVyKdyxanKqMb6UkbBCp/3R+Qrifp6jg7qymmrsqpp+m1cX2gp5MmD3fKW0YJ24yVWeqE4eAm2Q4EcjgTM4Xk3S5LjUz4zxBghZVLGqYZLOKaby2j+hmTF4k+q7atNOCIt5NrolhkLoKlGxyhDs/n0LdELzTPsb2/yL2GojPFt+18fBlNPzcZcMertN7xnc0MSmA3dJfLYlKLrHgQ+Btm5jSgDCt1OYg4LrTjMKaUeADKOEL0zDww01iTCwSh7CPPjIpW+9QEB4D5K+sw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ym3XjmhfgPs6Q8Q9adhNZup9WsF3HyZpr4KFej+rvD8=;
 b=kgOe7A0C8AqBmt+hvd5wE/yIf1f22vL2Efj0sADFxzjFXfX3DIXJM64pOzmWEtA4GaeRWfEGw/35mumxyfEbF1XFfJ+JmtRz9aufgT8GMXM23mx4Mm4Lr3WTf0fnqdAwUwFK5X5aM5eAYl0Z3m9+rtkOAnseDVJ+TjnwZ1Qinsc=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA0PR11MB7696.namprd11.prod.outlook.com (2603:10b6:208:403::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Tue, 24 Nov
 2026 20:42:33 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 20:42:33 +0000
Date: Tue, 24 Nov 2026 12:42:30 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 24/33] drm/xe: Add defrag profiling tracepoints
Message-ID: <awX2tkRFjgK8gUJC@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-25-matthew.brost@intel.com>
 <avFNSl7oIffZTPi8@nvishwa1-desk>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <avFNSl7oIffZTPi8@nvishwa1-desk>
X-ClientProxiedBy: SJ0PR13CA0003.namprd13.prod.outlook.com
 (2603:10b6:a03:2c0::8) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA0PR11MB7696:EE_
X-MS-Office365-Filtering-Correlation-Id: d9ceb7ef-6395-42d6-2e96-08df4a6b777c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|6133799003|22082099003|18002099003|56012099006|11063799006|261009223027099003|261021123027099003|4143699003|261102123227099003|261026140227099003|261026121527099003|261028144727099003|261022075727099003|261022105027099003|261021121427099003|10067099003;
X-Microsoft-Antispam-Message-Info: NwpZGSIfVZm8Wgb8P87lOyvNyhWZL1Cyu5Hsa1S8OwVAFvKcIWZ3Hv41IbPTeAiC58VymCtqMkZXXU17C5haY1nyU5FetstcxjWr2fn47T0MemxEoBkEJSoHevpL+kjMfXh87frLzLguBTG1kTQvBuyhQVzA3/vJXocmVecHSZW6WtJZ1Ciy3S0TF+CG1kuBOw8Sa/Z7Kj2KUqXtB5DsbFoEKsdxRaJAx2STAOMP8dTOz/CqbYFtgcVousuZuCOOjoL0DAG9NF3fFvxm9wHSE6bf5eBJqZfZhEKdDTz0wj8R5Mw1dxDh1xzH9fo6N5gZOahAJf1KZqKQmAABsDkxVyePBIo+9YvUNioXKhzyBsyUc5KIaXolgCfffAWD4Sn1Fgmo8TrWbo487imrGgEKr+otKwz0Nmr07pElKVnghuDi46hZSQndA+MIENuNdS3mA49yuuA1a225P1/Uk9YHYQHfZgaWkXP/TWkv/l2auPMGFWHYX38MNSmfKmgVh65TJareOtvsRr5JzoasdNo7VebhRdGRGR9/17twqo4QtAyvjBqkrg5qWDv/0dOHH6axx6SoqMLCDk1lnygloZW5/+msNJX0fwpa6YAowQI10yeex750vhxoToCf6+kJ7Z7rcUF0At17ZluSqyY80BY+EV/QSIZegLfmWa3s8f0Bm3w=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(4143699003)(261102123227099003)(261026140227099003)(261026121527099003)(261028144727099003)(261022075727099003)(261022105027099003)(261021121427099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?M+C+brYZX2oB1LaN0pu9f/nllg3/uzmAw5zeDDtMrzuLw9LcgjGTpC7Gyc?=
 =?iso-8859-1?Q?EBOXhZmvx9QJoenjHzGwpCaQoczv8Hok/mbOcjFNYVYbUynhzGZrWVJN2k?=
 =?iso-8859-1?Q?eA9132pw2A3zay/K9kaiDMOho/1Fh5OVJDVjaMoEd0Bw+AcuCMdcdNPmYS?=
 =?iso-8859-1?Q?zNZpl7NrygG31nYT3ynopebw/TLhHILymz7vhgodC+tGvevWGBnO8uyDdl?=
 =?iso-8859-1?Q?LsUg3A9LN+nYIVzJAXy5a4UdVTyswvnTThHhJlhm0DpWBd77LrNmzWt9dL?=
 =?iso-8859-1?Q?1Sj7de8CyLnDJe6c+HGtQJyJpZLLZTpyliSL3nWTn+5G87aqMTI+St0/I1?=
 =?iso-8859-1?Q?T4JFbwYZLe2yhq4/lkSLKF0nmw4rRUuLHhtYNNmg4sWiWYqWBWUKsB7vs5?=
 =?iso-8859-1?Q?w7HXcdcOd2FYJ6it8uhFwWnB1qxyO0zLiTuxQVqdb9+9Xqucd+ipIC0cBq?=
 =?iso-8859-1?Q?Dg7Wdp0OfLHnVxvECgSr7hI3zqEepnPEQ9dLHYuEPoAkxGuzWZND6ThyLP?=
 =?iso-8859-1?Q?mswsJI6adfJCA7OtoY1koYCQCQxSkf7Ygga6upSsI2yzi/CRf4GDruR6Fu?=
 =?iso-8859-1?Q?lTJUuAufIIiWAr1mx0bIwYoTntImLdPjeTL3ioDz+BswlcAJT4Fo7FO/tw?=
 =?iso-8859-1?Q?/XeFGOZx7cUAxqKn4SBTRz5R2guafG8qd8s16zjZbt6yXu502Hk/e4WjHj?=
 =?iso-8859-1?Q?zw8p6DdjBvZPpQjGKllTVDtK9oh1IQRfOcLnMlf0WWuGvhyEbnG5UG8Lff?=
 =?iso-8859-1?Q?UPLQxhGvQqY+U7Xm78RF5mxKx3S4oCTatwbhCXixgF4/fx7mHN4IcYcs1r?=
 =?iso-8859-1?Q?1rgnS+sb/AslZ7IzD+GzLFGyQgUjR7vRzIXVe/L/UNhveUQRGR7MUhUFPa?=
 =?iso-8859-1?Q?mmCqzPTXuM43h0cMQ7gGBK6Ax14aHgaAtJJOUzeSc3PGwxmO7H5hfTI9Eo?=
 =?iso-8859-1?Q?sPDyiyCwtZv4c0QR3fG82tPmqCbiqsAjJLxev5yoacAJsQniqlEbZQVy6O?=
 =?iso-8859-1?Q?S6yr8eikBEzNaax30MHWduRY++lyHNsFu3x5x47sb2zFXBV82PZcqp9Cgc?=
 =?iso-8859-1?Q?CRTU+3x94E1fVx3dG0RTlunPHp3TcUUWvMFYg+K9fpChKAbS85T1tzDi2k?=
 =?iso-8859-1?Q?+zx8TsQrKsBsrHK5Jo053xztFFioRuPzL8rIRIOnMUhjXKXyz9ubJvKh2W?=
 =?iso-8859-1?Q?jx4pU+f321+jqD01gdScanl7kP6nZS6ZP/SvwOkJ2uJNpWC5tBnsxaU4gF?=
 =?iso-8859-1?Q?r4fU8n0kZT2omOoHrOfxwJ8px5rMLLUtTYJZtHqRLUX+c8T6Xp4+OLV9PA?=
 =?iso-8859-1?Q?AW7eNEqTvPRFOB3WdZB1DL5bbyobRdBwlOUakaMxLXOHD97d0Ee0rl9hgj?=
 =?iso-8859-1?Q?1nsLpjtU5eESYoA3tY3wLoiCmHhhE8CesM6F4fHiLLZFPUoW2Nf3qoQFlg?=
 =?iso-8859-1?Q?UbEqekZsWLh23hRpzLtw8nyJ3Q3Oo5wPeC0FfBPuuxEeW60DhmrOwW/3nn?=
 =?iso-8859-1?Q?Rgb8azpjdq2OtyH1NZTUbxP+pe5cel02gqFC2NWw0clQWFDRBbi1CVlrFf?=
 =?iso-8859-1?Q?rHdXY++Fe3vppPQDMmwoopTKkjnyNMjQD3INDD6q95KXpt/m8axuJ9/Gxt?=
 =?iso-8859-1?Q?LA6UkXqZafDiw10IlkNGZo1Xzcy4pD8MzfDwMNTp3fo/tlQwJkDxaxfaun?=
 =?iso-8859-1?Q?YGv87HlVS0HZsCxbu1sgZspmgidy7Wqt3R3mD/s+YLmuxJ4gZUeJ3cGBqk?=
 =?iso-8859-1?Q?aDJB2cQyvd1UrSca/5fSe8H3AqTVmWKHSDH1Vb0dUrxGu2noIM+3lktYzK?=
 =?iso-8859-1?Q?o5PiJ6AWVrUoIIsdBEmr5JvaNxMxTOo=3D?=
X-Exchange-RoutingPolicyChecked: NNoqc/k1AESmYvPz4WIqwjuSjd1IMDNTovSAwEZ4aWA56b0otQlbmFCDu1QW8vx1EhiBQofVSIXgOyC+CEUPpW6TaVQIf4ml8zCm9ndAI/CnpirkSCoNnhqUqFEZoNkcr0RFXe4viezYmzSQYyKWY5Zcdv6fFC06Bt+efSTlFxMDh4sckw4atR7jf7U1GHV72L1GttnbdbJVBgaSCuOijAWWoWqKyvDdWX4MbLqt+4Tch10WEY6AGVIUkPBbwm4Y0T3KHRGwS+O02Yo6G1MjSIQyhFq3+4wax4XXV81ty1UAQZCY70k1AfcP0UF4ZI8gEccA43K7A5kk4oWUcgGfKg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d9ceb7ef-6395-42d6-2e96-08df4a6b777c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 20:42:33.7740 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IEEIk2szNQJ588x38aIBxQj3kjtCWrkMy1BP95xE+Czj0zsnUhDf+MqnCqFvF6S7oE8NRc7Qe+Oo9MrHPygIog==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7696
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

On Sun, Nov 08, 2026 at 08:34:18PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:56:10PM -0700, Matthew Brost wrote:
> > Add two tracepoints to profile the page defragmentation worker:
> > 
> > - xe_bo_defrag_worker: emitted on worker entry and exit with the
> >   current defrag list count and the bytes processed in the run.
> > - xe_bo_defrag_one: emitted per BO with the run budget, the prealloc
> >   fill ratio (got/want) and the lock-held, lock-wait and prealloc
> >   durations, plus the bytes consumed and the result.
> > 
> > These break down the cost of a defrag attempt into its locked vs
> > unlocked phases, making it possible to confirm that the expensive
> > beneficial-order allocation and cpu cache mode change happen outside
> > the BO dma-resv lock and that the residual lock-held time is copy-bound
> > (with the tail dominated by lock-wait behind active rendering).
> > 
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > v3:
> > - Move the ns-to-us division into TP_fast_assign() to avoid a 64-bit
> >   divide in TP_printk() (Sashiko)
> > ---
> > drivers/gpu/drm/xe/xe_bo.c       | 18 +++++++++-
> > drivers/gpu/drm/xe/xe_trace_bo.h | 59 ++++++++++++++++++++++++++++++++
> > 2 files changed, 76 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 8b89d34f37d4..25e5b72f870c 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -1263,7 +1263,9 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> > 	struct ttm_placement placement;
> > 	struct ttm_place place;
> > 	enum ttm_caching tt_caching;
> > -	unsigned int order, want = 0;
> > +	unsigned int order, want = 0, got = 0;
> > +	u64 lock_ns = 0, prealloc_ns = 0, lockwait_ns = 0;
> > +	ktime_t t0;
> > 	int ret = 0;
> > 
> > 	*consumed = 0;
> > @@ -1294,6 +1296,7 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> > 
> > 	/* Phase 2: preallocate outside the lock; */
> > 	if (want) {
> > +		t0 = ktime_get();
> > 		ret = ttm_pool_prealloc_fill(pool, tt_caching, &pp, want);
> > 		if (ret || !pp.count) {
> > 			ret = ret ?: -ENOMEM;
> > @@ -1301,12 +1304,16 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> > 					 XE_GT_STATS_ID_DEFRAG_FAILED_COUNT, 1);
> > 			goto out_err;
> > 		}
> > +		prealloc_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
> > 	}
> > 
> > 	/*
> > 	 * Phase 3: re-take the lock, re-check, and validate using the prealloc.
> > 	 */
> > +	t0 = ktime_get();
> > 	xe_bo_lock(bo, false);
> > +	lockwait_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
> > +	t0 = ktime_get();
> 
> Here only phase 3 locking is profiled. What about phase 1 locking?
> 

Phase 1 consists of a series of very small, time bounded checks
performed under lock for stability, which should be extremely fast. 

Phase 3 is interesting part as we perform dma mapping, formulate a copy
job, and internally update the TTM bookkeeping. If this part takes too
long (several ms) we could risk missing page flips as compositor could
be waiting on the same lock. Fortunately iirc for most BOs the lock is
held for less than 100us. So this is part we really need ftrace points
for profiling.

Matt

> Niranjana
> 
> > 
> > 	if (!xe_bo_needs_defrag(bo)) {
> > 		xe_bo_defrag_remove(bo);
> > @@ -1362,9 +1369,13 @@ static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
> > 
> > unlock:
> > 	xe_bo_unlock(bo);
> > +	lock_ns = ktime_to_ns(ktime_sub(ktime_get(), t0));
> > +	got = pp.used;
> > out_err:
> > 	ttm_pool_prealloc_fini(pool, &pp);
> > out:
> > +	trace_xe_bo_defrag_one(bo, budget, want, got, lock_ns, prealloc_ns,
> > +			       lockwait_ns, *consumed, ret);
> > 	return ret;
> > }
> > 
> > @@ -1396,6 +1407,9 @@ static void xe_bo_defrag_worker(struct work_struct *w)
> > 		return;
> > 	}
> > 
> > +	trace_xe_bo_defrag_worker(xe, 0, atomic_read(&xe->mem.defrag.count),
> > +				  true);
> > +
> > 	/*
> > 	 * Process at most XE_BO_DEFRAG_SIZE_LIMIT bytes of newly (re)allocated
> > 	 * backing per run rather than draining the whole list in one go. Only
> > @@ -1503,6 +1517,8 @@ static void xe_bo_defrag_worker(struct work_struct *w)
> > 
> > 	xe_pm_runtime_put(xe);
> > 	drm_dev_exit(idx);
> > +	trace_xe_bo_defrag_worker(xe, defrag_bytes,
> > +				  atomic_read(&xe->mem.defrag.count), false);
> > }
> > 
> > static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> > diff --git a/drivers/gpu/drm/xe/xe_trace_bo.h b/drivers/gpu/drm/xe/xe_trace_bo.h
> > index 86323cf3be2c..b159d37d39a1 100644
> > --- a/drivers/gpu/drm/xe/xe_trace_bo.h
> > +++ b/drivers/gpu/drm/xe/xe_trace_bo.h
> > @@ -85,6 +85,65 @@ TRACE_EVENT(xe_bo_move,
> > 		      __get_str(new_placement_name), __get_str(device_id))
> > );
> > 
> > +TRACE_EVENT(xe_bo_defrag_worker,
> > +	    TP_PROTO(struct xe_device *xe, u64 defrag_bytes, int count,
> > +		     bool enter),
> > +	    TP_ARGS(xe, defrag_bytes, count, enter),
> > +	    TP_STRUCT__entry(
> > +		     __string(dev, dev_name(xe->drm.dev))
> > +		     __field(u64, defrag_bytes)
> > +		     __field(int, count)
> > +		     __field(bool, enter)
> > +		     ),
> > +	    TP_fast_assign(
> > +		   __assign_str(dev);
> > +		   __entry->defrag_bytes = defrag_bytes;
> > +		   __entry->count = count;
> > +		   __entry->enter = enter;
> > +		   ),
> > +	    TP_printk("dev=%s %s defrag_bytes=%llu count=%d",
> > +		      __get_str(dev), __entry->enter ? "enter" : "exit",
> > +		      __entry->defrag_bytes, __entry->count)
> > +);
> > +
> > +TRACE_EVENT(xe_bo_defrag_one,
> > +	    TP_PROTO(struct xe_bo *bo, u64 budget, unsigned int prealloc_want,
> > +		     unsigned int prealloc_got, u64 lock_ns, u64 prealloc_ns,
> > +		     u64 lockwait_ns, u64 consumed, int ret),
> > +	    TP_ARGS(bo, budget, prealloc_want, prealloc_got, lock_ns,
> > +		    prealloc_ns, lockwait_ns, consumed, ret),
> > +	    TP_STRUCT__entry(
> > +		     __string(dev, __dev_name_bo(bo))
> > +		     __field(size_t, size)
> > +		     __field(u64, budget)
> > +		     __field(unsigned int, prealloc_want)
> > +		     __field(unsigned int, prealloc_got)
> > +		     __field(u64, lock_us)
> > +		     __field(u64, prealloc_us)
> > +		     __field(u64, lockwait_us)
> > +		     __field(u64, consumed)
> > +		     __field(int, ret)
> > +		     ),
> > +	    TP_fast_assign(
> > +		   __assign_str(dev);
> > +		   __entry->size = xe_bo_size(bo);
> > +		   __entry->budget = budget;
> > +		   __entry->prealloc_want = prealloc_want;
> > +		   __entry->prealloc_got = prealloc_got;
> > +		   __entry->lock_us = div_u64(lock_ns, 1000);
> > +		   __entry->prealloc_us = div_u64(prealloc_ns, 1000);
> > +		   __entry->lockwait_us = div_u64(lockwait_ns, 1000);
> > +		   __entry->consumed = consumed;
> > +		   __entry->ret = ret;
> > +		   ),
> > +	    TP_printk("dev=%s size=%zu budget=%llu prealloc=%u/%u lock_us=%llu lockwait_us=%llu prealloc_us=%llu consumed=%llu ret=%d",
> > +		      __get_str(dev), __entry->size, __entry->budget,
> > +		      __entry->prealloc_got, __entry->prealloc_want,
> > +		      __entry->lock_us, __entry->lockwait_us,
> > +		      __entry->prealloc_us, __entry->consumed,
> > +		      __entry->ret)
> > +);
> > +
> > DECLARE_EVENT_CLASS(xe_vma,
> > 		    TP_PROTO(struct xe_vma *vma),
> > 		    TP_ARGS(vma),
> > -- 
> > 2.34.1
> > 
