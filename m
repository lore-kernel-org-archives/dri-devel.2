Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A2FCA5FE5
	for <dri-devel@archiver.kernel.org>; Fri,  2 Oct 2026 19:20:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 531E610F9FC;
	Fri,  2 Oct 2026 19:20:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QlszcReO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AA43410E5ED;
 Fri,  2 Oct 2026 19:20:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790968831; x=1822504831;
 h=date:from:to:cc:subject:message-id:
 content-transfer-encoding:mime-version;
 bh=n8YPUKoVE4o4oRI4CVrn75DK8ZWhvgasyPhhF9+oP/g=;
 b=QlszcReOWAvHqdX+/Hz4aRUtJarSCJxViPnOVo4johgC6zA4HuljJcDE
 UVoaHnpuLyCNjm6ssE31hc4bhoA+TJIxT/Pr2SFcO0syoKMMcbDpykz/k
 kD5TcpKntlcA764tE45a7PjpGTQlYXfXrGFwerXT2Ctr5Y2Cww8hwBwuQ
 WEyYzOWlo87bj2h6YZLO9AzTFx9KtKiEnPUUYpkQBsow0pJFx/B0HPqfD
 1PABAstJoA6kMnp5y9AgjqlU8WMmOltKWM5RmzmsTHebDDINbZkZP6AqW
 7iqpVUznvZtTOmE3lgtpgtwf/yIE2bjJ5OVrAHkp/qzNnhQFQzHbLJevK Q==;
X-CSE-ConnectionGUID: rOc7Z+lcReGUM7SG4j6sbg==
X-CSE-MsgGUID: Pb8Mmp7ZRHu3nXodDUW1Rw==
X-IronPort-AV: E=McAfee;i="6800,10657,11923"; a="90798859"
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; d="scan'208";a="90798859"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 12:20:31 -0700
X-CSE-ConnectionGUID: SZDe/ELJRAuTudstLPhJwQ==
X-CSE-MsgGUID: LGjynZhPRA2FQqQhPJhgdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,136,1787036400"; 
   d="scan'208";a="395094"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Oct 2026 12:20:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 12:20:29 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Fri, 2 Oct 2026 12:20:29 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.15) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Fri, 2 Oct 2026 12:20:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dOj66oFjHfx+ORDAPtoOo6qgufi+Ih6GJiTgon+0YWtOX/cKxQ6GMlPM23lwwORWw/ZhEGTikO6PtwyOgKeiJxxZ/ug1OwAUtvpvBRTCZunIlx1TjJ9YnO2AkBC7d7lkLhF/I55fhbElmp0HzdBep5icrvHqGWqYQTjXkDp/ARrMKyqZVFqlVfExW/Y/xxEPj+/ZunKRb9In3ePjKgbso94O0T+YhO/1aaicXJj7i5RKxEBezprSxbcJ02pxux9+h+eY7rMS7uIcQlL7+xKkLahGmctaHm2vh/sqqjpIgqxajd0GCDWitRtsvONxbNG2XcYm34HIm0knNup7k+0rVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ABR9bjA6QHwIThd2gx5SYBqH+oWF0kwte9bFQ00sg0U=;
 b=uhS4jcWVXkM75Gg/ZztCcLxFIOXJbJDa7ymkViemnPvpBy5E+beCrDyDvqIsHsysX1IqxyiBx4lFvVScIhCr2PB5uZHdAq1WyeRUXoCVHlLO3gB1jjaR1482BuDr8d6Ri4lbwvZ5PyLZZeMn+wdOgdASt652cLJ5ybaarruNyykejjrd4hVts6rZZxJBVKn1P2QZyFCZbgObv/p7eBDeg4jMiojXEPP5jaE8YxrQnEWdTIU8BY6MntMgKwZJw558jiU1tqgXe7XxKxlrMUYn8NIHuXqEuylw5YNpS2QflhrQuyaOGbaZrAusO6iUZqCw2vTPeSMNQ41emI+57BI3cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by SAWPR11MB9757.namprd11.prod.outlook.com (2603:10b6:806:4cb::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Fri, 2 Oct
 2026 19:20:28 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0472.015; Fri, 2 Oct 2026
 19:20:27 +0000
Date: Fri, 2 Oct 2026 15:20:09 -0400
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
Subject: [PULL] drm-intel-next
Message-ID: <asAD6RRGxlbIPdhz@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SI2P153CA0009.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:140::18) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|SAWPR11MB9757:EE_
X-MS-Office365-Filtering-Correlation-Id: 22df98d3-78f0-4069-0327-08df20ba3737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|23010399003|376014|366016|1800799024|10067099003|56012099006|3023799007|6133799003|5023799004|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: tgAYniAczSunrkl4i9QuwqmyUFl9BH3Cmrq61HDcmrLaeRZUy/rAY9wfp5CMeckTCK98Nzd9K/veDO3TbZhACOBUF/aBcMT4OcFIIBM6oYRzic716rC1OuzC0pqWQC7fkToftvx4JWCytd8UpAxM2J9m5TwOvS8N1YfAhgW37c4vSINleRPjg5OslftSjYgsZx5sodiA0m7mTzxWrarifoBqho3gxVJjQOxM5YO5pslzsuupI4CQJP+SEJ/zKNSmc7KuIrdu/iSugy7pXtc/PLuLm79KDGQHLXGBo+YO8qWPRQ5eP06cwVKA9+qH+MqF0cohw6qcjuGJK3B65pVkGp0jdGmH3CIXa+z/i75sIyQRN4zsFkQJ96xcSew0GOXfKhT7PBsnf4QqFGs6qAqFlJ42G7FQFC04a+6XWtRlBLaxL/gekHu7ewuTkU6aQydk+W14ZmPvZEDI5JE/oiEOpW5qMKZSoYY6D1da6YNQuL23oEbP2iGaWBZzvIE1V5p0gk6rglANKKe7HxXjVc3jsZkK7/ad2JiTUNC/70KhSkMEnkUWNxEGp4W3SoPImgzxt7D27j1enBeQYE2DCaHS2EVhoWhbEzblvs61VSYEoo0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(23010399003)(376014)(366016)(1800799024)(10067099003)(56012099006)(3023799007)(6133799003)(5023799004)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekFlZ1gyc1d4Y0U2aFJ4Q0wzNFlaeitESGJWaDRBaEJ4YldFZmVNNTIvQnZo?=
 =?utf-8?B?dmFqUGgrdFM5L0E2cmh4VFFkdnRMOEhsdFhzTHI2eUxNaUttWi94L3lib3Ex?=
 =?utf-8?B?ZG1MZWMycTRXVTRXVWVlK0ZJNFhoR21xS0ppT2hrL0o5S1hpYkJnQkdJeXBW?=
 =?utf-8?B?U0xFb1lPRVdYTHRuaVRjZ1RMV3BzS0hxMGdXRkFodlVmZkN5MVROSmJ6czBT?=
 =?utf-8?B?YkRodnJoSU8rOWJtWFMrY1VyUVR4a1h2YlRzMDAvdzl2YlBUUGpZSHNudU5l?=
 =?utf-8?B?cnQ1ZktZcDg2MzBNR1BoRWFGSmhUTE5TcXFia1FmUWNBNnpkeXRmbXpVaDdy?=
 =?utf-8?B?RWxJQzkvLys4SVJmZFByRUFUSFc4N0ZQYUNPNEdBNWliTnRMeHhNN3ZNMyt4?=
 =?utf-8?B?ZWpxL29Mbk0yMzBFN0FJdlpraDlKY1hZVlNqL0dOSllVb2dRYTVhSkJFMW5w?=
 =?utf-8?B?QUtiVXp2NWlQVXpTaThVbEdyNU5leFFVcXdmWmgvMTU5MXZQcHp5UTIzS3Bk?=
 =?utf-8?B?dmFFU2huWkV4ekkrbW1CZjV6N21JN3NzVVNxZzJxcDFEU2RGczJjeW5aR25v?=
 =?utf-8?B?M29oRDhucGlUR1VaM24vcnR1ai9keVVmbWJxYzF5Q1pURXZPNktpY0hSNlUx?=
 =?utf-8?B?OSthVmo4RUwvYmhNRDFUa1RhcnE1RC9jMkQvWFdZZVQyZUVGaVJXaEZuZWFi?=
 =?utf-8?B?dWhiV2NXa3oxeDNBNmRpTkFqUzk2QUFtbHR3ZjBHL3M5VmlWSC95bmZaOVhw?=
 =?utf-8?B?TDBwUnUzYzZpckgyb1ArMUNsK2VGOGs5UnNaVm1vN2JsVTZrc0ZOR3RmMm15?=
 =?utf-8?B?ajBpUEd1ZnBGeEF4T2VpdWxtYnZkeGdHQndNRU8xa0l6Q0EwdFFPM0JFU2h4?=
 =?utf-8?B?ampWRGFtZjF1b1kxOXNJMWdneUVCTXM0ZE13OE1xTXh6c1d0MWNEdVZEZ0Fp?=
 =?utf-8?B?bDdMSlg0a3pQNmF0dEl5QmY1a2c1clZsUWhDZWZBM0J1eE5laWxiUnhvM3Nm?=
 =?utf-8?B?N3Nla29mUFh1aEtUdUM5RUxDeE5OakcyaEg4amROYWNPSEVmRThaR0s5NHRj?=
 =?utf-8?B?Y3FtRFVHaE5JUHVLRXRNUVVuYkJxSWJPU01PejhEeS9SK2UwR0hTYmtRaDha?=
 =?utf-8?B?blhpYlBSU1J5S1BDVEdRTWF0RWYzOWp0eUZvRzdYQ0RiWW1DTWh0dFZoRmV4?=
 =?utf-8?B?Y1VhYlVWOC81Qnl4clRMYmRxRXA1V1pUNXlYVTRLWHFLSWw2S3lvUHZSa1ZW?=
 =?utf-8?B?Y3M5WTFZelF2SkJuckV6bnJHQ2JoRTNvM1E3ZzJxOE1YK1dWa0dlV2g4bzls?=
 =?utf-8?B?L1YvVm5GSUFsUTlqR1BYMVRyRUpUSVlyc0E5VjRSbHJPREtXU045UDZZUEkz?=
 =?utf-8?B?amdmRWRtaUFvZGlVNFJ3OXYwVnp6dUVkNTdxNWp0eWJGL2Y3RzdSM0NDbzk1?=
 =?utf-8?B?NHY2THM5a09lQXVKYWh6dEUrS1Y2SVgvaitjZGRwUXE5VHFHa2drWlFibi9R?=
 =?utf-8?B?ZUgvSTdFYXFTRjV3NmJUYWpjUmtleDRrN2VkbVRiaGJnN3MvVVFobFFrbkdT?=
 =?utf-8?B?QWZNdTlYRXF3d3RySGROWktyU3czZFlrZ2RwTTgwYlp0MnI5QldRc2NFdVdw?=
 =?utf-8?B?SVdsMWpSSTA0OEVUSzNNMEQ2RjJNQVNkOVkxdFVCUUFaY2wvUk80SHpjbCtq?=
 =?utf-8?B?WDFYUnROTG1zd1hzcHVDZVdCNGpYWnRSbXpwYktZUEdrbWM3MTMzVTVOQmRa?=
 =?utf-8?B?MkVxK09YbUxGanRGNHVBdTArKzBvVHBJTElpME5jdzdYS3MwNk5HaDZsOWNp?=
 =?utf-8?B?dnVrb1VvR29sTjV4WEdLbHU0TFNVU1lFdjJlVXZyRmpJdUJzMnpQZlZSYWh1?=
 =?utf-8?B?MlAzcWxMYk53eWk1S3huMWVnT0NoQ21qYzgwcFZYNk9hTGp6aHRvdjBEYWtV?=
 =?utf-8?B?b2c2WVFUMFIzWGlETHhkZjFIbC9UUjRUUXV1d1ArU0ZmL3k3U3A4ajB5bkI2?=
 =?utf-8?B?Y2JNTTlNMkJ6RU9MVUl4YWxGa2tJcllkc2E1cjdsQmRrWDBUMVM5L0ZJRGlT?=
 =?utf-8?B?N0c2STJOMHBtTXpkd2oyTzBwZWlZa3V4cVhQZDQ3NjY4VnVaSjYvbzRXTGR5?=
 =?utf-8?B?TzdTUGVQcU1CZCtNd1hEbGM1Rms1Y0JJUGdxak5HcnczWE1RYkhtaUxoTE0z?=
 =?utf-8?B?dW9BcjZpYmNPc3p6cDVnZGpNS2FIR0Z2MHYzSWRsV2QrNFAwZVhwUFNkR21y?=
 =?utf-8?B?MnYvSmtnSzRnWXk2V0gwamc0MU0rdlcrNUhRZWtlbnZuQzRNSHdEdXVzNjlu?=
 =?utf-8?B?cnNROHFadXZSVE5kOXVyczdkTUFHTHdmdHF1SE1TMDJWT0VYMHdUQT09?=
X-Exchange-RoutingPolicyChecked: VmQxrvtZI45mkN1nNcBAjHevVNAbM5YN6RCCXD2daxfZTCxXKZl5byFSWOBUA3FammeVUNpuyJNefnWgvd8eUe+nOHuaFKd/GMmCwU1nG8douIuAWNS1F70ZNViRAEqMlOOPHaWDcR29ebs/k0TV4rLaD9RV4F4bvn2OJ/LlTYWAqQqgkDvVikBvaeSljTekCqO6yV14bfi7j6l4cbn4g8agw2Kua7RqdEgakxD4BJPAziEI9q+6jQW+T00aRklgvmHDX3o0TzJ14AO5+aITY7hEBhsBYGo6luCiJCavUk8V4+TGKZZistyqDlpH9OPAYJCUtiALJzSavACAbRLVsg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 22df98d3-78f0-4069-0327-08df20ba3737
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Oct 2026 19:20:27.8688 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TZMYkL1D1HwF0ktQxlCagCNu2AX0oVTVzk/nQ4FRTCFPONyz1fk4HcLmD77YvPNh74kCV504LV8yI21meKi0hQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR11MB9757
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

Here goes our last drm-intel-next PR towards 7.4

Thanks,
Rodrigo.

drm-intel-next-2026-10-02:
- Vswing / Pre-emphasis Override (Michal)
- Enable AS SDP Skip Frames (Uma)
- Handle negative configuration index on DP link caps for robustness (Luca)
- Perform full wedge on display reset (Ville)
- PSR related revert and fix (Nemesa)
- Preparation for enabling SDR plane color pipeline (Chaitanya, Pranay)
- An eDP quirk for HP Pavilion Plus (Ankit)
- DP MST fixes (Imre)
- General display fixes and small improvements (Jani, Lalit, Vinod, Sebastian)
- Introduce PME (Power Management Event) support on display hotplug (Vinod)
- Force eDP sink awake on dpcd init (Arun)
- Stop using the configurable fence timeout and other cleanups (Jani)
- Add support for Common SDP Transmission Line (Ankit, Arun)
- Map AUX power domains to DC_off (Suraj)
- Handle VSC SDP revision 7 in unpack (Juasheem)
- Disable VRR DC balance by default (Mitul)
- Switch to modern drm_dp_dpcd* accessors (Jani)
- Lg DPCD access errors (Suraj)
- Fixes to make i915 work well with PREEMPT_RT (Maarten, Sebastian)
- Update the CMN_SDP_TL in fastset path (Ankit)
- Use a shared gtt_view_types.h header (Jani)
The following changes since commit 14d6074f52d3af2b27565e6957b92dceeb8b00da:

  Merge tag 'drm-misc-next-2026-09-10' of https://gitlab.freedesktop.org/drm/misc/kernel into drm-next (2026-09-11 18:45:19 +1000)

are available in the Git repository at:

  https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-next-2026-10-02

for you to fetch changes up to 2c1bb96681bea17c2ffbd134816961615292a159:

  drm/intel: rename I915_GTT_VIEW_* enumerations to INTEL_GTT_VIEW_* (2026-10-01 12:26:54 +0300)

----------------------------------------------------------------
- Vswing / Pre-emphasis Override (Michal)
- Enable AS SDP Skip Frames (Uma)
- Handle negative configuration index on DP link caps for robustness (Luca)
- Perform full wedge on display reset (Ville)
- PSR related revert and fix (Nemesa)
- Preparation for enabling SDR plane color pipeline (Chaitanya, Pranay)
- An eDP quirk for HP Pavilion Plus (Ankit)
- DP MST fixes (Imre)
- General display fixes and small improvements (Jani, Lalit, Vinod, Sebastian)
- Introduce PME (Power Management Event) support on display hotplug (Vinod)
- Force eDP sink awake on dpcd init (Arun)
- Stop using the configurable fence timeout and other cleanups (Jani)
- Add support for Common SDP Transmission Line (Ankit, Arun)
- Map AUX power domains to DC_off (Suraj)
- Handle VSC SDP revision 7 in unpack (Juasheem)
- Disable VRR DC balance by default (Mitul)
- Switch to modern drm_dp_dpcd* accessors (Jani)
- Lg DPCD access errors (Suraj)
- Fixes to make i915 work well with PREEMPT_RT (Maarten, Sebastian)
- Update the CMN_SDP_TL in fastset path (Ankit)
- Use a shared gtt_view_types.h header (Jani)

----------------------------------------------------------------
Ankit Nautiyal (15):
      drm/i915/quirks: Limit eDP rate to HBR2 on HP Pavilion Plus 14-ew1
      drm/i915/dip: Add new file to handle Data Island Packet hardware
      drm/i915/vrr: Use the helper to write EMP_AS_SDP_TL register
      drm/i915/intel_dip: Add check for DP encoder
      drm/i915/dip: Add helper to get AS SDP Transmission Line
      drm/i915/display: Add crtc state for DIP transmission lines
      drm/i915/dip: Store and use AS SDP transmission line from crtc state
      drm/i915/dip: Add HAS_COMMON_SDP_TL macro
      drm/i915/dip: Store SDP transmission lines in crtc_state
      drm/i915/dp: Introduce helpers to enable/disable CMN SDP Transmission line
      drm/i915/dip: Enable Common SDP Transmission line
      drm/i915/dp: Account VSC SDP in min guardband
      drm/i915/dp: Adjust SDP guardband requirement for CMN_SDP_TL
      drm/i915/display: Dump DIP Transmission lines
      drm/i915/display: Update the CMN_SDP_TL in fastset path

Arun R Murthy (2):
      drm/i915/dp: On DPCD init wake the DPRx for eDP
      drm/i915/dip_regs: Add register definitions for common SDP Transmission Line

Chaitanya Kumar Borah (7):
      drm/i915/color: Add CSC on SDR plane color pipeline
      drm/i915/display: extract glk_plane_color_ctl_input_csc helper
      drm/i915/display: simplify glk_plane_color_ctl_input_csc
      drm/i915/display: Program CSC on SDR planes based on Fixed Matrix Colorop
      drm/i915/color: Add support for 1D LUT in SDR planes
      drm/i915/color: Add color pipeline support for SDR planes
      drm/i915/color: Add YUV buffer support on HDR planes

Imre Deak (2):
      drm/i915/dp_mst: Fix configuring FEC for a disconnected stream
      drm/i915/dp_mst: Fix configuring TUs for a disconnected stream

Jani Nikula (27):
      drm/i915/dp: use EXPORT_SYMBOL_IF_KUNIT() for kunit helpers
      drm/i915/display: stop using the configurable fence timeout
      drm/i915/display: use struct intel_atomic_state *state variable naming
      drm/i915/display: reduce indent in intel_atomic_commit_fence_wait()
      drm/i915/display: debug log about fence wait errors
      drm/i915/lspcon: use u8 variable to hold 1-byte DPCD reads
      drm/i915/lspcon: switch to drm_dp_dpcd_{read_byte, write_byte, write_data}
      drm/i915/alpm: switch to drm_dp_dpcd_{read_byte, write_byte}
      drm/i915/ddi: switch to drm_dp_dpcd_write_byte()
      drm/i915/lspcon: switch to drm_dp_dpcd_{read_byte, read_data, write_byte, write_data}()
      drm/i915/dp: switch to drm_dp_dpcd_{read_byte, read_data, write_byte, write_data}
      drm/i915/hdcp: switch to drm_dp_dpcd_{read_byte, read_data, write_data}()
      drm/i915/dp: switch link training to drm_dp_dpcd_{read_byte, read_data, write_byte, write_data}()
      drm/i915/dp-mst: switch to drm_dp_dpcd_read_byte()
      drm/i915/dp-test: switch to drm_dp_dpcd_{read_byte, read_data, write_byte, write_data}()
      drm/i915/psr: switch to drm_dp_dpcd_{read_byte, read_data, write_byte, write_data}()
      drm/xe/display: reduce includes in xe_display.c
      drm/intel: move i915_gtt_view_types.h to include/drm/intel
      drm/intel: rename i915_gtt_view_is_*() helpers to intel_gtt_view_is_*()
      drm/intel: rename i915_gtt_view* struct/enum to intel_gtt_view*
      drm/intel: add intel_gtt_view_is_partial() for completeness
      drm/xe/display: use intel_gtt_view_is_*() helpers more
      drm/i915/gem: use intel_gtt_view_is_*() helpers more
      drm/i915/vma: use intel_gtt_view_is_*() helpers more
      drm/i915/selftests: use intel_gtt_view_is_*() helpers more
      drm/i915/debugfs: use the intel_gtt_view_is_*() helpers more
      drm/intel: rename I915_GTT_VIEW_* enumerations to INTEL_GTT_VIEW_*

Juasheem Sultan (1):
      drm/i915/dp: Handle VSC SDP revision 7 in unpack

Lalit Shankar Chowdhury (2):
      drm/i915/fb: replace kmalloc_array with kmalloc_objs
      drm/i915: use string choice helpers

Luca Coelho (1):
      drm/i915/display: check configuration index before shifting

Maarten Lankhorst (3):
      drm/i915/gt: Fix selftests on PREEMPT_RT
      drm/i915/gt: Set stop_timeout() correctly on PREEMPT-RT
      drm/i915: Use sleeping selftests for igt_atomic on PREEMPT_RT

Michał Grzelak (8):
      drm/i915/bios: search for VBT #57 by default
      drm/i915/bios: store VBT #57's metadata in intel_vbt_data
      drm/i915/bios: print VS/PE-O port info
      drm/i915/bios: de/allocate VS/PE-O buffers for each port
      drm/i915/buf_trans: add vfunc for VS/PE-O
      drm/i915: override Snps's VS/PE when requested
      drm/i915: override Combo's VS/PE when requested
      drm/i915/bios: remove VS/PE-O warning

Mitul Golani (1):
      drm/i915/vrr: Disable DC balance by default

Nemesa Garg (2):
      Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable"
      drm/i915/psr: Clear stale sel fetch enable bits on sel fetch disable

Pranay Samala (2):
      drm/i915/color: Extract HDR post-CSC LUT programming to helper function
      drm/i915/color: Program Plane Post CSC registers for SDR planes

Rodrigo Vivi (1):
      Merge drm/drm-next into drm-intel-next

Sebastian Andrzej Siewior (4):
      drm/i915/gt: Use spin_lock_irq() instead of local_irq_disable() + spin_lock()
      drm/i915: Drop the irqs_disabled() check
      drm/i915/guc: Consider also RCU depth in busy loop.
      drm/i915: Use %p for pointer formatting

Suraj Kandpal (9):
      drm/i915/xe3plpd: Map AUX power domains to DC_off
      drm/i915/lspcon: log DPCD access errors
      drm/i915/alpm: log DPCD access errors
      drm/i915/ddi: log DPCD access errors
      drm/i915/backlight: log DPCD access errors
      drm/i915/dp: log DPCD access errors
      drm/i915/linktraining: log link training DPCD access errors
      drm/i915/dptest: log DPCD access errors
      drm/i915/psr: log DPCD access errors

Thorsten Blum (1):
      drm/i915: Fix memory leak in query_perf_config_list()

Uma Shankar (4):
      drm/i915/display: Enable periodic AS SDP skip frames
      drm/i915/display: Force disable DC3co when AS SDP skip frames is enabled
      drm/i915/display: Reprogram AS SDP skip frames on seamless VRR transitions
      drm/i915/display: Gate periodic AS SDP skip frames behind a debugfs knob

Ville Syrjälä (1):
      drm/i915: Perform full wedge on display reset

Vinod Govindapillai (6):
      drm/xe/pm: introduce PM PME support
      drm/i915: add pme_enabled() to the parent interface
      drm/i915/xe: plug the pme_enabed implementation for xe
      drm/i915/irq: conditional HPD IRQ resets based on PME capability
      drm/i915/hotplug: avoid HPD polling if the device is PME capable
      drm/i915/fbc: remove uint16 from supported fbc formats in xe3plpd

 drivers/gpu/drm/i915/Makefile                      |   1 +
 drivers/gpu/drm/i915/display/intel_alpm.c          | 166 ++++++++++--
 drivers/gpu/drm/i915/display/intel_alpm.h          |   3 +
 drivers/gpu/drm/i915/display/intel_bios.c          | 262 ++++++++++++++++++-
 drivers/gpu/drm/i915/display/intel_bios.h          |  14 ++
 drivers/gpu/drm/i915/display/intel_color.c         |  76 ++++--
 .../gpu/drm/i915/display/intel_color_pipeline.c    |  34 ++-
 .../gpu/drm/i915/display/intel_crtc_state_dump.c   |   9 +
 drivers/gpu/drm/i915/display/intel_cursor.c        |  20 +-
 drivers/gpu/drm/i915/display/intel_cx0_phy.c       |   5 +-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  37 ++-
 drivers/gpu/drm/i915/display/intel_ddi_buf_trans.c |  90 ++++++-
 drivers/gpu/drm/i915/display/intel_dip.c           | 215 ++++++++++++++++
 drivers/gpu/drm/i915/display/intel_dip.h           |  53 ++++
 drivers/gpu/drm/i915/display/intel_dip_regs.h      |  38 +++
 drivers/gpu/drm/i915/display/intel_display.c       |  60 ++++-
 drivers/gpu/drm/i915/display/intel_display_core.h  |   7 +
 drivers/gpu/drm/i915/display/intel_display_irq.c   |  18 +-
 .../gpu/drm/i915/display/intel_display_limits.h    |   1 +
 .../gpu/drm/i915/display/intel_display_params.c    |   4 +
 .../gpu/drm/i915/display/intel_display_params.h    |   6 +
 drivers/gpu/drm/i915/display/intel_display_power.c |   9 +
 .../gpu/drm/i915/display/intel_display_power_map.c |  42 +++-
 drivers/gpu/drm/i915/display/intel_display_rpm.c   |   7 +
 drivers/gpu/drm/i915/display/intel_display_rpm.h   |   1 +
 drivers/gpu/drm/i915/display/intel_display_types.h |  26 +-
 drivers/gpu/drm/i915/display/intel_dp.c            | 279 +++++++++++++++------
 .../gpu/drm/i915/display/intel_dp_aux_backlight.c  |  78 +++---
 drivers/gpu/drm/i915/display/intel_dp_hdcp.c       | 176 ++++++-------
 drivers/gpu/drm/i915/display/intel_dp_link_caps.c  |  15 +-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  58 +++--
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  26 +-
 drivers/gpu/drm/i915/display/intel_dp_mst.h        |   2 +
 drivers/gpu/drm/i915/display/intel_dp_test.c       |  77 +++---
 drivers/gpu/drm/i915/display/intel_fb.c            |  20 +-
 drivers/gpu/drm/i915/display/intel_fbc.c           |  12 +-
 drivers/gpu/drm/i915/display/intel_hotplug.c       |   5 +
 drivers/gpu/drm/i915/display/intel_link_bw.c       |   3 +-
 drivers/gpu/drm/i915/display/intel_lspcon.c        |  82 +++---
 drivers/gpu/drm/i915/display/intel_parent.c        |   4 +-
 drivers/gpu/drm/i915/display/intel_parent.h        |   6 +-
 drivers/gpu/drm/i915/display/intel_plane.c         |  53 +++-
 drivers/gpu/drm/i915/display/intel_psr.c           |  91 ++++---
 drivers/gpu/drm/i915/display/intel_psr_regs.h      |   2 +
 drivers/gpu/drm/i915/display/intel_quirks.c        |   3 +
 drivers/gpu/drm/i915/display/intel_vrr.c           |  18 +-
 drivers/gpu/drm/i915/display/intel_vrr_regs.h      |   6 -
 drivers/gpu/drm/i915/display/skl_universal_plane.c |  79 +++---
 drivers/gpu/drm/i915/gem/i915_gem_domain.c         |   4 +-
 drivers/gpu/drm/i915/gem/i915_gem_mman.c           |  14 +-
 drivers/gpu/drm/i915/gem/i915_gem_object.h         |   2 +-
 drivers/gpu/drm/i915/gem/selftests/i915_gem_mman.c |   4 +-
 drivers/gpu/drm/i915/gt/intel_engine_cs.c          |   2 +-
 .../gpu/drm/i915/gt/intel_execlists_submission.c   |  17 +-
 drivers/gpu/drm/i915/gt/intel_reset.c              |   8 +-
 drivers/gpu/drm/i915/gt/selftest_engine_pm.c       |   8 +-
 drivers/gpu/drm/i915/gt/uc/intel_guc.h             |   2 +-
 drivers/gpu/drm/i915/gvt/aperture_gm.c             |   4 +-
 drivers/gpu/drm/i915/i915_debugfs.c                |  22 +-
 drivers/gpu/drm/i915/i915_dpt.c                    |   2 -
 drivers/gpu/drm/i915/i915_drv.h                    |   2 -
 drivers/gpu/drm/i915/i915_fb_pin.c                 |   6 -
 drivers/gpu/drm/i915/i915_gem.c                    |   6 +-
 drivers/gpu/drm/i915/i915_gem.h                    |   6 +-
 drivers/gpu/drm/i915/i915_gtt_view_types.h         |  74 ------
 drivers/gpu/drm/i915/i915_overlay.c                |   5 -
 drivers/gpu/drm/i915/i915_query.c                  |   4 +-
 drivers/gpu/drm/i915/i915_request.c                |   2 -
 drivers/gpu/drm/i915/i915_vma.c                    |  44 ++--
 drivers/gpu/drm/i915/i915_vma.h                    |  12 +-
 drivers/gpu/drm/i915/i915_vma_types.h              |  29 ++-
 drivers/gpu/drm/i915/selftests/i915_vma.c          |  60 ++---
 drivers/gpu/drm/i915/selftests/igt_atomic.c        |   7 +
 drivers/gpu/drm/i915/vlv_iosf_sb.c                 |   6 +-
 drivers/gpu/drm/xe/Makefile                        |   1 +
 .../gpu/drm/xe/compat-i915-headers/i915_config.h   |  16 --
 .../xe/compat-i915-headers/i915_gtt_view_types.h   |   7 -
 drivers/gpu/drm/xe/display/xe_display.c            |  10 +-
 drivers/gpu/drm/xe/display/xe_display_rpm.c        |   6 +
 drivers/gpu/drm/xe/display/xe_fb_pin.c             |  28 +--
 drivers/gpu/drm/xe/xe_device_types.h               |  13 +
 drivers/gpu/drm/xe/xe_pci.c                        |  22 +-
 drivers/gpu/drm/xe/xe_pm.c                         |  45 ++++
 drivers/gpu/drm/xe/xe_pm.h                         |   2 +
 include/drm/intel/display_parent_interface.h       |   9 +-
 include/drm/intel/gtt_view_types.h                 |  79 ++++++
 86 files changed, 2076 insertions(+), 813 deletions(-)
 create mode 100644 drivers/gpu/drm/i915/display/intel_dip.c
 create mode 100644 drivers/gpu/drm/i915/display/intel_dip.h
 create mode 100644 drivers/gpu/drm/i915/display/intel_dip_regs.h
 delete mode 100644 drivers/gpu/drm/i915/i915_gtt_view_types.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/i915_config.h
 delete mode 100644 drivers/gpu/drm/xe/compat-i915-headers/i915_gtt_view_types.h
 create mode 100644 include/drm/intel/gtt_view_types.h
