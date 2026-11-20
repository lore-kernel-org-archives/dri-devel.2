Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BA606A33A
	for <dri-devel@archiver.kernel.org>; Fri, 20 Nov 2026 06:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eFMSTXp6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=GrlCCJi5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 149B5112540;
	Fri, 20 Nov 2026 06:11:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5366D112540;
 Fri, 20 Nov 2026 06:11:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795155078; x=1826691078;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=IYg/eb2SjPPE2r1Gtks5t7f0mZR3cNAUKdlIALeYqEU=;
 b=eFMSTXp6dmU3wA8myUY46QRSij1fm70VEbP4opyVWwhnEIyVIlkbg1HA
 U8d9T3nQCkpczdxwrvHUOJFqpKD2Me+2YUaR//5Xo52iv2nYRzj6lXIq1
 zpLayoQ+I9Oy+xa35y53TGqggIDipzg92NywGQRbkb4QcDNXmdqCtsga2
 /OVWjD9PHU2ROjP5DEwDH4epzV2pHw6FSD0pcNtwocoUxrdEiR1foJ83k
 pyqDAtiJE1VZn10B5ws0xE76/+mRnv7rvVkWLE3xb3HhrRrXCwbl1y4w2
 iXLcHvHtsjVGxt+nhqzB42mXztrL+KBujQPmqoZpRB8M42KZt1snCkePZ Q==;
X-CSE-ConnectionGUID: FWqRx6dhTdyfQHCylkmHfw==
X-CSE-MsgGUID: SE5VV16bTp6JmkT7LjO4Zg==
X-IronPort-AV: E=McAfee;i="6800,10657,11971"; a="4020109"
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; 
   d="scan'208";a="4020109"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 22:11:17 -0800
X-CSE-ConnectionGUID: fkFoQIpLQpOyE0x/cE05FQ==
X-CSE-MsgGUID: ttpNoOfSRxWoVbpD20Deng==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,222,1787036400"; d="scan'208";a="10620233"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Nov 2026 22:11:16 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 22:11:15 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 19 Nov 2026 22:11:15 -0800
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.30) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 19 Nov 2026 22:11:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+qPHXCQhJ//Ucb+scaCQKF+D68JCydAHL/KXyRQQozSgxUINDwTaz24ByXtEjg2a3udQfURFmz5NdVXn6Q7sSFxwg8IrhxRoCy2aqBWZ5Wqrq+T4vcIzKOFK/J1RD4h3b1vNVhPlEAATEYYSUfEIwpsghbElQxLvy9ka13abmSli1n3ZnGDszovtvtraqp1QmZKU+w+eOdc7wUb5wRiUBoD6kMFUhzlqcDbN40XmjsMPRi6oZi4gS+nMUqC9gxtSVA6lZ4hR6tfHeGRyxRr0iT9uJUueNSsVNZB/3bUGVHRjvshxEivoMCANYtZ6n5COdg9sN66UB6eYbNNb963nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3gcG5atf7JHN27k2xme79gaxrT4eeL6NvsEABik1xMs=;
 b=lWPFqzeHhm81TkARMYagG/tfSYO5egoNngx6Qq4HWXcJnypa4ZjXizgzKw16lbqJtAdr2rUEQjfsSr/Y8S4RsVH3NlDgNSIN/tqgGlmXwTxlx034mtEOhpUKngkwMCgZOQuBRv49tQJqTNkq0npUFaKSlwcPWiRQVOyiuUpYRpgWYtTJ5PDkLIYnAzTtdSIZmdeE7LUASI7QFE2D0qm/TcOPf6O30r6qbHOw9JCZVV6NUPTybWOOID+HcQ2M5nznIcMCtX2WhxIYuatmfsOuPIUVW6iOrJoj+yQ+Hnk8slUyuXzFi7Opl4F/fiGXjbCDe1AM0z1TFFrnlrTPLNoCQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3gcG5atf7JHN27k2xme79gaxrT4eeL6NvsEABik1xMs=;
 b=GrlCCJi5a4w26ZgcawZEXIz+Z76K9rdbMkpRy1O09htpFoF5VY7bi9r7jg39L4Zc621dP87G8dzp+caY+jO+V/PS9tMYOWIAC/MVNkZa6N/wHfu8KGfLSuO7t83Hms4Iv3Uo6hVnD1tnjzWEJY9vfTfAkUEdCVpra+YM8fbMR9E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by DM4PR11MB7182.namprd11.prod.outlook.com (2603:10b6:8:112::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Fri, 20 Nov
 2026 06:11:07 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0639.010; Fri, 20 Nov 2026
 06:11:07 +0000
Date: Thu, 19 Nov 2026 22:11:05 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 17/33] drm/xe: Add xe_migrate_copy_defrag() for on-GPU
 defrag copies
Message-ID: <av/keS1AJc1xGSzj@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-18-matthew.brost@intel.com>
 <3bc563bf-9692-4611-a85a-9e21d43373c9@intel.com>
 <auo/Lc103kibONZC@gsse-cloud1.jf.intel.com>
 <5934a422-03bb-45a7-8cd9-7007c02531e4@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5934a422-03bb-45a7-8cd9-7007c02531e4@intel.com>
X-ClientProxiedBy: MW4P223CA0013.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::18) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|DM4PR11MB7182:EE_
X-MS-Office365-Filtering-Correlation-Id: 02ac6711-b275-4380-d01d-08df46cd10df
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|7416014|376014|23010399003|10067099003|4143699003|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261028144727099003|261026140227099003|261026121527099003|261022075727099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: cRARv0+1FpkZDPpDc6wU2D2RApRdFy3ZSaYMgFFTy/ua5N/keTDJ0ecTVk2rlPl2ajDWd7KR16FKudeKpMe/Qs8Z2gnnW24LpVO2tp6QVJ1bdeybc1wHOzU/qJUXkCspPnFdEBrUv6ecsipmx8xm5eirXEydnD2vpXX3JzAqfr5pf06EDBVpS2L6VMMx5RTVXMILU1ZDSKaFxv23Tk/0WPFKGl4WBWixdgq9YWDnOxuGyvfVAKtdbbZPf365blA8v1tZyidCpwjOg0d1OemKmTm8OpkVnXezO4Npdmt7m30kCNRq8Qr2gJsSaBf62QPo0R9lGiJOuoAG25ECtYP0J9PQQE4Jlptm+ygwxmSf+Q+8cFDaGNHT4d9iQU2YqD2n0U+AeEy/pLbQKo4ZVj/10U5ER0/W8+F7oHUU/FFLtScFXfJbK2EqX+muj+HEvj8inWJB7YK3AEi7sLpQcgmHlKTQBMJg/CuEhZTesNPJLEvLu9cUXO044Ug6ewvcroPri/7k4FoxnROVfoqPip9YEhQCVXbcoqQGH2o9kiVIcasPmyA/sCnLKhZu6Pv0lUFeZGqGQjZ14QgfyVb2slW5NBm8/OC1ISleWDuvyS9It6dJbar4AanQmq+CLSAor/Pj
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(7416014)(376014)(23010399003)(10067099003)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261028144727099003)(261026140227099003)(261026121527099003)(261022075727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?SO+naUBjzHb47+ahFdM7dWYEH8JT81+BMLn3/qN7A0QSXNdF/uZG+j7eKp?=
 =?iso-8859-1?Q?yWbBWLQK5dbc4QtmshXLt042UATHHcUj3aCWS6/VItuNpAE57A/Lq7x/Y9?=
 =?iso-8859-1?Q?NAF/xGML+xp+bVRzxfFaXsSsAiKcLAvlo0D7/DLXXhhm8jwO88k5ByFozf?=
 =?iso-8859-1?Q?oSrYFrY3O1u/DzjyJAEHtFKnb6YNymRTGXx47B2c7muNADnLfExrW4psUQ?=
 =?iso-8859-1?Q?A4OYTZ0dUfwVe3vXD8mZhhQb2CirlXI7txNLQhNwq+9VyKwCZu+JkSi7fd?=
 =?iso-8859-1?Q?1ZpRgww8QHFCKvPHaY6Nb45U79k3tFBUBX1bUpTF3u/AvaTcQld5Rb5C8N?=
 =?iso-8859-1?Q?Qew4KwmYuRd/1EN9EZbB7SSPCsnlWQ108AUL4L0NCiLtDOKyL9fSK1GcVl?=
 =?iso-8859-1?Q?6OWEAsr563YhSf6yi2Kw8FaUFWU9Nqyhu74k31JjEJtXHL85yAF2a1NTHa?=
 =?iso-8859-1?Q?sRwZitXo/wfsksVdtX7zjaoezIR6b1tkARy4w5SbEWk02Hj8/lkd6Qa5LP?=
 =?iso-8859-1?Q?A9JXsAoqAWTrzr5IEjXdV0HmlDDxVTdkpn5icU04qNgvWojGSDM2jtJocr?=
 =?iso-8859-1?Q?Zo7nA2SbA45Iw+7TkdyhHwY16/GnlKNMum/2g4rLiwaScAhWu+SF62AQ+G?=
 =?iso-8859-1?Q?ERpWa2ZnVYFUdLbYb8xtaYkX2t2aOonux518osusAiQJDwsgRf1+2w4dPH?=
 =?iso-8859-1?Q?FrHwgI2tLaC+yFu1PRqL88msCf7yXaf2HQRt8K+z+4gZGgis774NdmWxQp?=
 =?iso-8859-1?Q?cPCjAHZoYgi9usA9mSxYOb03z0nCGpjYw0eFr5/u/GYfgDNLVMFePsD0/R?=
 =?iso-8859-1?Q?j+41uL7KL33IQMhgqXF5opZTUWFKPfD2HjtMBlKKuoVltvwDODLSGfXj4y?=
 =?iso-8859-1?Q?aMppT6xIfBaKKf4SXUAOg7SKNF+/IqtbwhPV0rPbc/01lFPswtdxANXllq?=
 =?iso-8859-1?Q?fumlkUJ08Zi9RdthzPHi1C6jledM9suCnmOU09atTgQE0BCxq7Xf31WGA7?=
 =?iso-8859-1?Q?7tBGHcwDMEpkW3tkTZpr0qcmZhCdMAUHPmolFe1poN9mBtNQL0peqHEN2P?=
 =?iso-8859-1?Q?G/3Eu2VaTNr1jwXjVJGrxiQzzw/q5RUHZuJcI6Mv8ylepK8TvLpLFpno84?=
 =?iso-8859-1?Q?04Z0tUsYgZzK51yGxXd46GqhtgnYcVP2TD2zDcGO/jt5NJYFfQDaPSGsLn?=
 =?iso-8859-1?Q?psPn3eivv6Nc6qBorEA9mTSO0ME71JXMd2oW4v2eRSxVSw4TBZI4EvrRfS?=
 =?iso-8859-1?Q?LVlyicO/49phxLuYm3AWVGNVZcDY4F4kaPIqDC4Uhvwj5PK+huXyBc53Jt?=
 =?iso-8859-1?Q?Nh0nLsBT8ztw6QrkZCwyUHf650DeJxcyYcwE3NXS0uT1Ek10HQGk2ebjWg?=
 =?iso-8859-1?Q?w6aOGQ9GipkG9NJVl6OfUNgbMhG86V0ZQ6dLTyuRNXMJjANdJbD4+2HciW?=
 =?iso-8859-1?Q?r1Lq/BHW6a7/NCy1LBELekcLWR3QzvOku3/RVlVmJo5vLkE+5FmRUm+68r?=
 =?iso-8859-1?Q?/+dG0lYAoDt8ZiatjeN8gd3Nvou2Eziv7nBHD8vsT4fcdoTeM8U4Ncmggm?=
 =?iso-8859-1?Q?LQL2TKZwL0o2d+fC8iDnd6clCf1Npl/G72JJh2eJHETjPJ+YqBIWNxm34C?=
 =?iso-8859-1?Q?Ug0PRPMPgnL2hZnr7OzPmNgkPzO6+uzcq7QFfiwK5NJF2uHO3hejn4+1G4?=
 =?iso-8859-1?Q?yll8nRSy4/TJcfLo5Isy/aVVCZ29iE/yWXGCR2GBn548ZlwfnRskchNje2?=
 =?iso-8859-1?Q?G+WMKG/E+VxyuhouuJV3RnjlEXoyvMft/yrBxXSoMmP2omFvBeCyZFs1Yn?=
 =?iso-8859-1?Q?gSCxAn+h1PtgXMs42jGE5wGuIiKspXU=3D?=
X-Exchange-RoutingPolicyChecked: LbiXuG/3m+024pZfJQWB/z/ELa15l7Fg+Sa40QMcPurJk15WGbkBCAO8j1F2g/wUAOerXyQBW6YDJ3/BdlwPd0+7GkJq7ZQJpt2EFBTtt8lxMPUHGjxcULg1DEzqloGmFsFK/nY88WLY0aRlhgwsBZYudi4U8Al+swVYjyacLDpNJ+yjmKynSEzusAjfKFz/NoN8l7mNAGGvT6AhKybmYozEgl+t3KPnLdHUH0alBj1V8lMdLLKJqgCbbjFqeh3/jFp0Zo/bdQo+cEwh52e+GQUUZv0Dm+5O+xeSUq/4NrgyGpFHtxSX9knPNTtUeI5JDpOzzrQgEJlVGYmkZLdDhg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 02ac6711-b275-4380-d01d-08df46cd10df
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 06:11:07.6960 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3EDxHu4SNuOK3TKlIOD8wmiRNGFMgM4ARop7QO342fGfy8OGBYKu5whwpSMJGXhGEGhjUUk/wUYHjBk2gS+1hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7182
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

On Wed, Nov 04, 2026 at 12:37:53PM +0000, Matthew Auld wrote:
> On 03/11/2026 20:08, Matthew Brost wrote:
> > On Tue, Nov 03, 2026 at 12:58:39PM +0000, Matthew Auld wrote:
> > > On 11/07/2026 03:56, Matthew Brost wrote:
> > > > Add xe_migrate_copy_defrag(), a copy helper for the upcoming page
> > > > defragmentation path where a single BO has its backing reallocated at a
> > > > more beneficial page order and its contents must be relocated from the
> > > > old pages to the new ones entirely on the GPU.
> > > > 
> > > > The contents are relocated in up to two passes:
> > > > 
> > > >    - Data pass (always): copy the data pages verbatim. The pages are
> > > >      mapped without the compression PAT, so the (possibly compressed)
> > > >      bytes are copied as-is rather than being decompressed and
> > > >      recompressed, and no CCS aux copy is appended.
> > > > 
> > > >    - CCS pass (need_ccs): copy the CCS aux (compression) state. Both the
> > > >      old and new data pages are mapped with the compression PAT so the
> > > >      copy engine accesses the aux state indirectly, issuing one
> > > >      indirect -> indirect XY_CTRL_SURF_COPY_BLT; the data blit is skipped.
> > > 
> > > 
> > > Just to double check, there were no issues with this flow for a compressed
> > > surface? Not 100% sure if reading from the src with uncompressed PAT will
> > > zero out the CCS state (update to uncompressed status), such that when you
> > > do the CCS pass it is already gone. Quite sure it does that for a write, but
> > > I guess not for a read, so we are fine here?
> > > 
> > 
> > This isn't my area of expertise, but IIRC I spun on this patch several
> > times before I finally got it right. In my first few attempts, when I
> > ran something like 3DMark Wildlife Extreme or WebGL applications that
> > would trigger the defragmenter, I could see visual corruption on the
> > screen (i.e., the buffers were clearly being corrupted). I eventually
> > landed on the approach detailed here and have not seen any visual issues
> > since. So I think the reads without the compressed PAT are fine, at
> > least on PTL.
> 
> Ok, also went and dug up the xe2+ memory compression SAS and under "verbatim
> copies" it matches up with how you do it here.
> 

+1. Thanks for checking.

Matt

> > 
> > I also have a local update to [1] where I use the compressed PAT, and
> > the tests seem to pass. I can post an update to this test shortly.
> > 
> > Matt
> > 
> > [1] https://patchwork.freedesktop.org/patch/739244/?series=169723&rev=2
> > 
> > > > 
> > > > The two passes are issued separately because they require opposite
> > > > compression PAT settings on the data page mappings (cleared for the
> > > > verbatim data copy, set for the indirect CCS access), which a single
> > > > mapping cannot satisfy. Both passes run in order on the same migrate
> > > > queue and are captured by the returned fence.
> > > > 
> > > > The source pages are passed explicitly via an sg_table argument (the
> > > > old, still populated backing) since they no longer match the BO's
> > > > current backing. The boolean arguments to __xe_migrate_copy() are folded
> > > > into struct xe_migrate_copy_flags to keep the growing set of copy
> > > > variants readable.
> > > > 
> > > > Cc: Carlos Santa <carlos.santa@intel.com>
> > > > Cc: Ryan Neph <ryanneph@google.com>
> > > > Cc: Christian Koenig <christian.koenig@amd.com>
> > > > Cc: Huang Rui <ray.huang@amd.com>
> > > > Cc: Matthew Auld <matthew.auld@intel.com>
> > > > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > > > Cc: Maxime Ripard <mripard@kernel.org>
> > > > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > > > Cc: David Airlie <airlied@gmail.com>
> > > > Cc: Simona Vetter <simona@ffwll.ch>
> > > > Cc: dri-devel@lists.freedesktop.org
> > > > Cc: linux-kernel@vger.kernel.org
> > > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > > > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > > > ---
> > > >    drivers/gpu/drm/xe/xe_migrate.c | 136 ++++++++++++++++++++++++++++----
> > > >    drivers/gpu/drm/xe/xe_migrate.h |   8 ++
> > > >    2 files changed, 128 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/drm/xe/xe_migrate.c b/drivers/gpu/drm/xe/xe_migrate.c
> > > > index 92d5e81ceac2..305c6e1942fb 100644
> > > > --- a/drivers/gpu/drm/xe/xe_migrate.c
> > > > +++ b/drivers/gpu/drm/xe/xe_migrate.c
> > > > @@ -858,13 +858,39 @@ static u32 xe_migrate_ccs_copy(struct xe_migrate *m,
> > > >    	return flush_flags;
> > > >    }
> > > > +/**
> > > > + * struct xe_migrate_copy_flags - Flags for __xe_migrate_copy()
> > > > + * @copy_only_ccs: Only copy the CCS aux state, aliasing the destination data
> > > > + * mapping to the source (used when the data pages are shared between src/dst).
> > > > + * @is_vram_resolve: Decompression (VRAM -> system) resolve; always uses the
> > > > + * compression PAT index for the data copy.
> > > > + * @defrag_ccs: Defrag move pass that migrates only the CCS aux state between
> > > > + * two distinct page sets (old @src_sg pages -> new pages). The data blit is
> > > > + * skipped (the data was copied by the @defrag_copy pass) and both the source
> > > > + * and destination data pages are mapped with the compression PAT so the aux
> > > > + * state is copied indirect -> indirect.
> > > > + * @defrag_copy: Defrag move pass that copies the data pages between two
> > > > + * distinct page sets (old @src_sg pages -> new pages) without touching the CCS
> > > > + * aux state. The data pages are mapped without the compression PAT so the
> > > > + * (possibly compressed) bytes are copied verbatim rather than being
> > > > + * decompressed and recompressed, and no CCS aux copy is appended; the aux
> > > > + * state is migrated separately by the @defrag_ccs pass. The two passes need
> > > > + * opposite compression PAT settings, which is why they cannot be combined.
> > > > + */
> > > > +struct xe_migrate_copy_flags {
> > > > +	u32 copy_only_ccs : 1;
> > > > +	u32 is_vram_resolve : 1;
> > > > +	u32 defrag_ccs : 1;
> > > > +	u32 defrag_copy : 1;
> > > > +};
> > > > +
> > > >    static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > >    					   struct xe_bo *src_bo,
> > > >    					   struct xe_bo *dst_bo,
> > > >    					   struct ttm_resource *src,
> > > >    					   struct ttm_resource *dst,
> > > > -					   bool copy_only_ccs,
> > > > -					   bool is_vram_resolve)
> > > > +					   struct sg_table *src_sg,
> > > > +					   struct xe_migrate_copy_flags flags)
> > > >    {
> > > >    	struct xe_gt *gt = m->tile->primary_gt;
> > > >    	struct xe_device *xe = gt_to_xe(gt);
> > > > @@ -881,20 +907,29 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > >    	bool src_is_vram = mem_type_is_vram(src->mem_type);
> > > >    	bool dst_is_vram = mem_type_is_vram(dst->mem_type);
> > > >    	bool type_device = src_bo->ttm.type == ttm_bo_type_device;
> > > > -	bool needs_ccs_emit = type_device && xe_migrate_needs_ccs_emit(xe);
> > > > +	bool needs_ccs_emit = type_device && xe_migrate_needs_ccs_emit(xe) &&
> > > > +		!flags.defrag_copy;
> > > >    	bool copy_ccs = xe_device_has_flat_ccs(xe) &&
> > > > -		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo);
> > > > -	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram);
> > > > +		xe_bo_needs_ccs_pages(src_bo) && xe_bo_needs_ccs_pages(dst_bo) &&
> > > > +		!flags.defrag_copy;
> > > > +	bool copy_system_ccs = copy_ccs && (!src_is_vram || !dst_is_vram) &&
> > > > +		!flags.defrag_ccs && !flags.defrag_copy;
> > > >    	/*
> > > >    	 * For decompression operation, always use the compression PAT index.
> > > >    	 * Otherwise, only use the compression PAT index for device memory
> > > >    	 * when copying from VRAM to system memory.
> > > >    	 */
> > > > -	bool use_comp_pat = is_vram_resolve || (type_device &&
> > > > +	bool use_comp_pat = flags.is_vram_resolve || (type_device &&
> > > >    			    xe_device_has_flat_ccs(xe) &&
> > > >    			    GRAPHICS_VER(xe) >= 20 && src_is_vram && !dst_is_vram);
> > > > +	/*
> > > > +	 * The defrag CCS pass migrates the aux state from the old pages
> > > > +	 * (@src_sg) to the new pages with both sides accessed indirectly, so
> > > > +	 * keep both src_is_pltt and dst_is_pltt set (no direct staging side).
> > > > +	 */
> > > > +
> > > >    	/* Copying CCS between two different BOs is not supported yet. */
> > > >    	if (XE_WARN_ON(copy_ccs && src_bo != dst_bo))
> > > >    		return ERR_PTR(-EINVAL);
> > > > @@ -903,7 +938,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > >    		return ERR_PTR(-EINVAL);
> > > >    	if (!src_is_vram)
> > > > -		xe_res_first_sg(xe_bo_sg(src_bo), 0, size, &src_it);
> > > > +		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo), 0, size, &src_it);
> > > >    	else
> > > >    		xe_res_first(src, 0, size, &src_it);
> > > >    	if (!dst_is_vram)
> > > > @@ -912,7 +947,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > >    		xe_res_first(dst, 0, size, &dst_it);
> > > >    	if (copy_system_ccs)
> > > > -		xe_res_first_sg(xe_bo_sg(src_bo), xe_bo_ccs_pages_start(src_bo),
> > > > +		xe_res_first_sg(src_sg ? src_sg : xe_bo_sg(src_bo),
> > > > +				xe_bo_ccs_pages_start(src_bo),
> > > >    				PAGE_ALIGN(xe_device_ccs_bytes(xe, size)),
> > > >    				&ccs_it);
> > > > @@ -942,7 +978,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > >    		batch_size += pte_update_size(m, pte_flags, src, &src_it, &src_L0,
> > > >    					      &src_L0_ofs, &src_L0_pt, 0, 0,
> > > >    					      avail_pts);
> > > > -		if (copy_only_ccs) {
> > > > +		if (flags.copy_only_ccs) {
> > > >    			dst_L0_ofs = src_L0_ofs;
> > > >    		} else {
> > > >    			pte_flags = dst_is_vram ? PTE_UPDATE_FLAG_IS_VRAM : 0;
> > > > @@ -963,7 +999,8 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > >    		}
> > > >    		/* Add copy commands size here */
> > > > -		batch_size += ((copy_only_ccs) ? 0 : emit_copy_cmd_len(xe)) +
> > > > +		batch_size += ((flags.copy_only_ccs || flags.defrag_ccs) ? 0 :
> > > > +			       emit_copy_cmd_len(xe)) +
> > > >    			((needs_ccs_emit ? EMIT_COPY_CCS_DW : 0));
> > > >    		bb = xe_bb_new(gt, batch_size, usm);
> > > > @@ -975,13 +1012,15 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > >    		if (src_is_vram && xe_migrate_allow_identity(src_L0, &src_it))
> > > >    			xe_res_next(&src_it, src_L0);
> > > >    		else
> > > > -			emit_pte(m, bb, src_L0_pt, src_is_vram, copy_system_ccs || use_comp_pat,
> > > > +			emit_pte(m, bb, src_L0_pt, src_is_vram,
> > > > +				 copy_system_ccs || use_comp_pat || flags.defrag_ccs,
> > > >    				 &src_it, src_L0, src);
> > > >    		if (dst_is_vram && xe_migrate_allow_identity(src_L0, &dst_it))
> > > >    			xe_res_next(&dst_it, src_L0);
> > > > -		else if (!copy_only_ccs)
> > > > -			emit_pte(m, bb, dst_L0_pt, dst_is_vram, copy_system_ccs,
> > > > +		else if (!flags.copy_only_ccs)
> > > > +			emit_pte(m, bb, dst_L0_pt, dst_is_vram,
> > > > +				 copy_system_ccs || flags.defrag_ccs,
> > > >    				 &dst_it, src_L0, dst);
> > > >    		if (copy_system_ccs)
> > > > @@ -990,7 +1029,7 @@ static struct dma_fence *__xe_migrate_copy(struct xe_migrate *m,
> > > >    		bb->cs[bb->len++] = MI_BATCH_BUFFER_END;
> > > >    		update_idx = bb->len;
> > > > -		if (!copy_only_ccs)
> > > > +		if (!flags.copy_only_ccs && !flags.defrag_ccs)
> > > >    			emit_copy(gt, bb, src_L0_ofs, dst_L0_ofs, src_L0, XE_PAGE_SIZE);
> > > >    		if (needs_ccs_emit)
> > > > @@ -1078,7 +1117,69 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> > > >    				  struct ttm_resource *dst,
> > > >    				  bool copy_only_ccs)
> > > >    {
> > > > -	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, copy_only_ccs, false);
> > > > +	return __xe_migrate_copy(m, src_bo, dst_bo, src, dst, NULL,
> > > > +				 (struct xe_migrate_copy_flags) {
> > > > +					 .copy_only_ccs = copy_only_ccs,
> > > > +				 });
> > > > +}
> > > > +
> > > > +/**
> > > > + * xe_migrate_copy_defrag() - Migrate a BO's backing to a reallocated page set.
> > > > + * @m: The migration context.
> > > > + * @bo: The buffer object being defragmented. Both @src and @dst belong to @bo.
> > > > + * @src: The source TTM resource (the old backing).
> > > > + * @dst: The dst TTM resource (the freshly reallocated backing).
> > > > + * @src_sg: Scatter-gather table of the source (old) backing pages.
> > > > + * @need_ccs: Whether the BO has CCS aux state that must be migrated too.
> > > > + *
> > > > + * Used by the defrag path where a single BO has its backing reallocated at a
> > > > + * more beneficial page order. The contents are relocated from the old pages
> > > > + * (@src_sg) to the new pages (the BO's current backing) entirely on the GPU,
> > > > + * in up to two passes:
> > > > + *
> > > > + *  - Data pass (always): copy the data pages verbatim. The pages are mapped
> > > > + *    without the compression PAT, so the (possibly compressed) bytes are copied
> > > > + *    as-is rather than being decompressed and recompressed, and no CCS aux copy
> > > > + *    is appended.
> > > > + *
> > > > + *  - CCS pass (@need_ccs): copy the CCS aux (compression) state. Both the old
> > > > + *    and new data pages are mapped with the compression PAT so the copy engine
> > > > + *    accesses the aux state indirectly, issuing one indirect -> indirect
> > > > + *    XY_CTRL_SURF_COPY_BLT; the data blit is skipped.
> > > > + *
> > > > + * The two passes are issued separately because they require opposite
> > > > + * compression PAT settings on the data page mappings (cleared for the verbatim
> > > > + * data copy, set for the indirect CCS access), which a single mapping cannot
> > > > + * satisfy. Both passes run in order on the same migrate queue.
> > > > + *
> > > > + * Return: Pointer to a dma_fence representing the last copy batch, or an error
> > > > + * pointer on failure.
> > > > + */
> > > > +struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> > > > +					 struct xe_bo *bo,
> > > > +					 struct ttm_resource *src,
> > > > +					 struct ttm_resource *dst,
> > > > +					 struct sg_table *src_sg,
> > > > +					 bool need_ccs)
> > > > +{
> > > > +	struct dma_fence *fence2, *fence =
> > > > +		__xe_migrate_copy(m, bo, bo, src, dst, src_sg,
> > > > +				  (struct xe_migrate_copy_flags) {
> > > > +					 .defrag_copy = true,
> > > > +					 });
> > > > +
> > > > +	if (IS_ERR(fence) || !need_ccs)
> > > > +		return fence;
> > > > +
> > > > +	fence2 = __xe_migrate_copy(m, bo, bo, src, dst, src_sg,
> > > > +				   (struct xe_migrate_copy_flags) {
> > > > +				   .defrag_ccs = true,
> > > > +				   });
> > > > +	if (IS_ERR(fence2))
> > > > +		dma_fence_wait(fence, false);
> > > > +	dma_fence_put(fence);
> > > > +
> > > > +	return fence2;
> > > >    }
> > > >    /**
> > > > @@ -1096,7 +1197,10 @@ struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> > > >    				     struct xe_bo *bo,
> > > >    				     struct ttm_resource *res)
> > > >    {
> > > > -	return __xe_migrate_copy(m, bo, bo, res, res, false, true);
> > > > +	return __xe_migrate_copy(m, bo, bo, res, res, NULL,
> > > > +				 (struct xe_migrate_copy_flags) {
> > > > +					 .is_vram_resolve = true,
> > > > +				 });
> > > >    }
> > > >    /**
> > > > diff --git a/drivers/gpu/drm/xe/xe_migrate.h b/drivers/gpu/drm/xe/xe_migrate.h
> > > > index 965c45889c72..e4f996942a6d 100644
> > > > --- a/drivers/gpu/drm/xe/xe_migrate.h
> > > > +++ b/drivers/gpu/drm/xe/xe_migrate.h
> > > > @@ -11,6 +11,7 @@
> > > >    struct dma_fence;
> > > >    struct drm_pagemap_addr;
> > > >    struct iosys_map;
> > > > +struct sg_table;
> > > >    struct ttm_resource;
> > > >    struct xe_bo;
> > > > @@ -132,6 +133,13 @@ struct dma_fence *xe_migrate_copy(struct xe_migrate *m,
> > > >    				  struct ttm_resource *dst,
> > > >    				  bool copy_only_ccs);
> > > > +struct dma_fence *xe_migrate_copy_defrag(struct xe_migrate *m,
> > > > +					 struct xe_bo *bo,
> > > > +					 struct ttm_resource *src,
> > > > +					 struct ttm_resource *dst,
> > > > +					 struct sg_table *src_sg,
> > > > +					 bool need_ccs);
> > > > +
> > > >    struct dma_fence *xe_migrate_resolve(struct xe_migrate *m,
> > > >    				     struct xe_bo *bo,
> > > >    				     struct ttm_resource *res);
> > > 
> 
