Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DFC1606A31D
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 06:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VzeOJgpV
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 42FC110E837;
	Fri, 30 Oct 2026 06:16:31 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C8B810E827;
 Fri, 30 Oct 2026 06:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793340985; x=1824876985;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=fjwAZubC/b9ZKqqR5ZoQmgRODzw8buFjOpyQIFrFYfg=;
 b=VzeOJgpVVdq6vuIY7UjlIz4Hr79Q3ecwNvCXvPjFOh+AlJt+I06woa7R
 35/ROqmINPAGiW+fKz5bgdkYBr6xgV+3uZZHkVGrlVTrLnPqwJg5cqIrI
 qNAotJFU7AdtVl4RITSoCS8rp8HVUZXq9mYi58IXsOmRdWWgh84couZRb
 P/QLyPLX3QPerfVHPQlio8uOX7MZbLIY9rnQvWWyGU1Gad5NsBdQnO3GC
 gtNt0e8zjxh0u7t79Y7YrOsu0YldKxCV2h/p6sS1WUgeI6LLxLG9Zipdf
 EPaJKGclA4Mr1o+CFBwJCfRLshZhO/Fjaz+5iVIA03Kgq8JwwO8/9/Njg Q==;
X-CSE-ConnectionGUID: T8SN22LfTE2EnXvYnUisgg==
X-CSE-MsgGUID: hl7CNcl0TriVIBVmCpYi7g==
X-IronPort-AV: E=McAfee;i="6800,10657,11950"; a="2191107"
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="2191107"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 23:16:24 -0700
X-CSE-ConnectionGUID: HmuR9ArQQGikYY1aU3JwwA==
X-CSE-MsgGUID: LZwpCPWiR1S+mGwGgFnsMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,185,1787036400"; 
   d="scan'208";a="5434449"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Oct 2026 23:16:24 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 23:16:23 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Thu, 29 Oct 2026 23:16:23 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.13) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Thu, 29 Oct 2026 23:16:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SXTcLZvWZkT32vH0AiRFKOBOby1Lz7qEkyA5iptGDqzSYcVT3qZkNhua/3IDOuqiJFki01ZqOOtx+LbOB8uYxgsBHPVNU/5Gl3jYEaHl3neobSSIhieocIq2jgqRrYnXEi7v9LJRNSrUmz2cFi+BN5vqBfI2VkCdQ9MSPyhNd6xPvXEHtkOqe1NrcUYiRi2oOJMLQRH+J7gfam3+uFYaAu1v2yEfdWtz6580cg4cVJs1Zajv/AVo4yVFvn7x+11VgxtX9KxOtz7TjbmURQf08RY49qUYAjpZ2FA6fGwOXz+hDa+3JTH+AjhvdTvogJq95CQrtoyjduoF14ETJPa/jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NWAHlAbQb2WHwHgbXZU+HmQyis8VxQJEqcdAq7R4PvQ=;
 b=sIvhdWv3xOP/cHGJjUCBz7ekQFiytdmD2SquPS3Z9FQ6rTpEyh0n6N9E3VNhOwxW4SRxyaiZwzVNv3NnVeQxL2ES8usb3k4GQQvfY2v6ZVQCiEQR9s6YHT3tlijWUVMbg9fuipdjCqoht1oRF9WzRtd3XdO7QtPaDMxPhhuEdS0h+EZgjYfgofpS9aphX8RUV9IW5OSf1Qtwi7FA6ThaIG8eIOdLZuXBazq5lXFTX7fdMG7P7Y+UkYVztMgI8SiRxtB4qwxPNLn5Ffo188TZRVw+I0YSNJnJzD8d6WfiOG2Wp/F7qdoBAS3UIgnOSK8YxIj/we28ADaE5ad9Nes6+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB7958.namprd11.prod.outlook.com (2603:10b6:8:f9::19) by
 MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.8; Fri, 30 Oct
 2026 06:16:19 +0000
Received: from DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99]) by DS0PR11MB7958.namprd11.prod.outlook.com
 ([fe80::8cb2:cffc:b684:9a99%4]) with mapi id 15.21.0569.008; Fri, 30 Oct 2026
 06:16:18 +0000
Message-ID: <86fb7702-9b70-412c-a8a0-a2d78cb5fae2@intel.com>
Date: Fri, 30 Oct 2026 11:46:05 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] drm/xe: Expose retired VRAM pages via drm-ras
To: Rodrigo Vivi <rodrigo.vivi@intel.com>, Jakub Kicinski <kuba@kernel.org>,
 Aravind Iddamsetty <aravind.iddamsetty@linux.intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <netdev@vger.kernel.org>, <amd-gfx@lists.freedesktop.org>,
 <simona.vetter@ffwll.ch>, <airlied@gmail.com>, <tejas.upadhyay@intel.com>,
 <himal.prasad.ghimiray@intel.com>, <raag.jadav@intel.com>,
 <joshua.santosh.ranjan@intel.com>, <ashwin.kumar.kulkarni@intel.com>,
 <pratik.bari@intel.com>, <Hawking.Zhang@amd.com>, <tao.zhou1@amd.com>,
 <YiPeng.Chai@amd.com>, <jinzhou.su@amd.com>, <cesun102@amd.com>,
 <lijo.lazar@amd.com>, <alexander.deucher@amd.com>, <christian.koenig@amd.com>
References: <20261007080354.3072751-1-aravind.iddamsetty@linux.intel.com>
 <20261007080354.3072751-2-aravind.iddamsetty@linux.intel.com>
 <20261016154913.1af64e88@kernel.org> <atYFYbLXfSIPLTzA@intel.com>
Content-Language: en-US
From: "Tauro, Riana" <riana.tauro@intel.com>
In-Reply-To: <atYFYbLXfSIPLTzA@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5P287CA0056.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1d3::11) To DS0PR11MB7958.namprd11.prod.outlook.com
 (2603:10b6:8:f9::19)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB7958:EE_|MW4PR11MB5872:EE_
X-MS-Office365-Filtering-Correlation-Id: 724c24c5-b39d-4bb4-e303-08df364d4f31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|7416014|376014|4143699003|56012099006|11063799006|261009223027099003|261022075727099003|261021121427099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: SUuKaRRvfimzbFqeslrz4ENN9JKKbz3P0vLhBFX6cFD291eZsQxUnsMvLS4onuavq0+oGs4saTWvNbAz7cjfYcGnaU6KbSRmOYs2gvMx7Avv5+ZnTwx8JMX/dVXR7i2L1tZMCuBBWz2FDKtzuRW+OPMfALUJG07Qx/LeeA62nibBW72PwTKwCJajUVPnXMr77bs7kP4/nap0yuCn/EYFaZMULEmrKhy6NYHlVrriW+XXK9XP+ggKT7zWtDuvjd+BRXJZajQT50V7lDlyq9oV34YMN+edtZEWAoMR3XL1sd6cks1SFas3HsrdM0/bzfuSexpyf2dx4/iy+O5y8pAVTDg5qQOsHk5AoeDPrxz+WORPDz1AWwZYD/M527+azRFaHiX34aAvs3ltWmfpt4nZdacB/ARA88gRcJdMAnfnGTNctqTTzfiI7+wVAjo0nqfeDJEFmk188oHuGQ+qDMOebLf8TIpHAqa+60VSjYgCxB+SxODJlxCb2xW6vnPt5cxuk4sLBavxUdnUh+GQVcnSa9RdQPF9Xp2AdNUdXa/RvrnRB/smQkxtG0E8JpjrhcOR05Mkuhp+YoN6zUE1Ib2Yxoq4NXiBEWFg1EKr8HTKCSaLg+V29fFEWOmQ/RsbIWi9
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB7958.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(7416014)(376014)(4143699003)(56012099006)(11063799006)(261009223027099003)(261022075727099003)(261021121427099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDg3SjdoOFNvMFRCRzR1ZzNtVHRFZ2QzWjY4MmdseFd4NDJrZFhyTmNicEtt?=
 =?utf-8?B?V2ZVRVRPcnVDMUFONzhQSEVxcU5uV3hIZU5qS1pjQ0pVTFFFTmpxKytzR0dB?=
 =?utf-8?B?RXRpMG44NjR1a2FzdTMwRWJ4cklGUFBzUlVzU3hlOE11Uk5WTGJveXNQQlhr?=
 =?utf-8?B?TjBJbVd6RXdUU1c3MkF1Rzdqd1FvMHV3M29uTFhWdUovR2p6WnZlQ0dqaWlV?=
 =?utf-8?B?dFU3Rk1vTHNMUEcxdFZTb3VNTGZZOEFsblZvNFJKem9XNUYxN20xeUgzTlRJ?=
 =?utf-8?B?ejJqT0NKTjZ0MCtONlB5eVlqY1gyeUg0bThLV0I3aHd0eVRxYlBxdWxzdElY?=
 =?utf-8?B?K2JYekxwM2Y3UUxOaHVNY09nU1hRMGNnVnk3a201TlRYQTd2VGtTcURoeE9M?=
 =?utf-8?B?RnZNSzZUZlFEeENoMEcxQis0cEkvc0krbWlFMGhYclpuQWhtV25HNjFxaXN2?=
 =?utf-8?B?ZGNYaDZXRCtRVkJ3NTdLMGFJMnF0cXh3NVFGa0RINnc3ZDhFWXBCbEVkVysx?=
 =?utf-8?B?NFZhUDdORmIwR3F0dzNkakF5K2h3UnVsT2lSbTlyN0hPNGJjMnRtQ21INW9q?=
 =?utf-8?B?VG1LV1JydEpoQ3NJcXhRU01PU2JkU3k2blFpWWUycWdTNzEyVktleVVCMkZC?=
 =?utf-8?B?Mk1JRFVjd05ML1RJUnRudDFVcmljZUFCWXQreHhwejZSWXp6azJ0dG9DK0Zn?=
 =?utf-8?B?QkZPZk1OWE5ac3NBU2ZtdXhhODJlaUFLc2JNVHFCSFJwV3kzSGNUMDZRbFhU?=
 =?utf-8?B?ZnBQdzkxZGJxM2paRVc4NG9kbVlwR3BFdmRxYzljSjVGL3UzTTFzZDRWUjNJ?=
 =?utf-8?B?RURjanBTRm5iRXM3THRlcXBRUlVWczVwbmcxTFRuL1huTUpacUpLZUwvUG40?=
 =?utf-8?B?cDVTV3R4WkpyQWxuS1ZWRnFtRm5vcTg0Y0VpY2lLV2J5U3hka09FeGtqazJM?=
 =?utf-8?B?Q08vM3dxSlM0MXpMNkl2WHRRUUlZOE5TRldQNG9La0p0dytpMDZ2bjJ5OVhM?=
 =?utf-8?B?azdZMEtaYmVOQTRQWDBQV3o2VEg4bE80eFNtMEJtN1dVWHJRNXBUZVViNVhB?=
 =?utf-8?B?Wk95UHl4MmdHUkc3QUc0L3JOaldCVkNrQSsxSUtFTWVZb1RNckp0MmxadDJT?=
 =?utf-8?B?SUNhWUpZUWpkKzg0YzFmQlppbFE5L3ZIZ1hMbUV6SGYrdDcwQk5JQ3VlM1RE?=
 =?utf-8?B?bVhFUXBFZTkvU3Fzd1RmNUk5MWhycW9VbWxNNktOUlIrT0FCRDZMc1BhZWQ5?=
 =?utf-8?B?ZWFjWHVwZlhRenVTZGJuKzgySm5ZSU13RWw5Q2ZoSWZKVlpoaUVNVW56Q0Vv?=
 =?utf-8?B?RTk3K0k0TDdrTzFsODI4R3FNa29IZ25GYnQ3N28xeXdkd3JCelgxVkMwYjhs?=
 =?utf-8?B?R0tReVR2ZU4xd0Z5ZTJhRTNhd0xYWmNYa1ZxS3lpQURmbGJscHVNY0Ewb3pR?=
 =?utf-8?B?cVBFaXpOWGZDcU9Zekw2aEVQRjUrd0RXOGE3dzlCdnZjMHB6QUJpL0pTYnYv?=
 =?utf-8?B?UlFBa2pCWEFMMTBhVGkvUVpCZFkzOThTb2p3c2JlUU5OTlNZTGcxVllqQ2tQ?=
 =?utf-8?B?RTNGZkFybDYwd0pSaytOR2tXZjIxbmpBMkNSVGdWVlk1R3p4R0dhU3VVdnN2?=
 =?utf-8?B?YnBiLzhNWFY1OC9BeGhpNzE5anVXYmlQZ1ZoNFFDbFBna2RIQmQyOXBvVldr?=
 =?utf-8?B?Z1Z2SE01TWVwenJhMHUxd1ZsOWFoODdZT0FGVXZ6Q05iczNvSWI5dlNrRE9J?=
 =?utf-8?B?RHhkSzZML1VNc25EYno3OVh3Mmx6UUxHMTlSVlJyUCtBYi9MU254WlFIazhY?=
 =?utf-8?B?OGpZVXYxMTVTUzhzNWVFWktxbm52YVVGU2g0YVM5L0VXTjNDS0l4TlY3a2dT?=
 =?utf-8?B?T1pINVhva1FoS2sva1ZpQ2Joa25Rcm93aGFLbHlXeHNHWVlwellyMldqU0pz?=
 =?utf-8?B?OFNOVEw0NDA0VktwTThGaUtVMFBGMG5GS0h6QXgwdUVUaHUrM09LMDY5VnFy?=
 =?utf-8?B?MG1qSzlKZ3lxb0FGVHhLZFQ5OE1FWFJpN1pqejE2R1JIRlQ5RkxnS3kzNS9u?=
 =?utf-8?B?M2hOeExRVEEvUWZ6czZiVjBadWFXbnFSNTB2aFJSUWVHY1ZCaENQemp5Lzkx?=
 =?utf-8?B?VDZHbGNzay9YS1NzeXFMNEduQ05SNmtKeVA3SFRLYkNXanlkN0t6K0lQdXZN?=
 =?utf-8?B?TXVPZUs4T1dkbjUxMU1ZWVgrSVkxVndmSjM0ZXVoenNBY2RwalpZc3llQy9r?=
 =?utf-8?B?R1FJZjdmOVlwQngydVE4YkZ4MWVWNDhKR0wrQWdqdHhQV2VESHRZTkZJbWVL?=
 =?utf-8?B?eUowRjNjeTY1cjF1d3NST2FtWndnQWRZeG0vNG5leWpIZlJZTUplZz09?=
X-Exchange-RoutingPolicyChecked: BTnaL7KUgtdIfmpzlDF4kW7iZWM2Rc3NywBO/NfY/Rju16lIwXvmB1aFR+FavlPwCwkwpG4aqWpl7ru834UxcQSolabElvASR5qFL5smgeZA+Ooide6phhuPJbQRH1QQaS77b38khiO0BZZvzsOaa66LnfoMixpnYTpT2qUT0B6RqW7lTjzqQktadAynuGexJOTCc/KUdcJBfjGGkkbIKsdnl5JDPtOPewhOEF7agqEqlaqO0nqTco8ndN137dBJLe6qNFFObOLOiri6mn1ovZO7pjruzdVb3ghPqBbUo99AXvU3FfsIYJqYmfp9yGLnCWK54Jlz91jG1h7xr3qdfw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 724c24c5-b39d-4bb4-e303-08df364d4f31
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB7958.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2026 06:16:18.3121 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gvJq/Cjt9EiU+QodsatbwYX/0e1GcpdeyyPS7rW1CVxLe8Os4IkkO35fGDI9E12/5LEYKOtl1kNoqQPxqLg9SQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Aravind/Rodrigo

How about using a generic telemetry node for this series from 
https://lore.kernel.org/dri-devel/20261029203000.1763447-1-zachary.mckevitt@oss.qualcomm.com/T/#t 
instead of a dedicated node for vram-retired-pages?

Thanks
Riana

On 19-10-2026 17:26, Rodrigo Vivi wrote:
> On Fri, Oct 16, 2026 at 03:49:13PM -0700, Jakub Kicinski wrote:
>> On Wed,  7 Oct 2026 13:33:53 +0530 Aravind Iddamsetty wrote:
>>> +  -
>>> +    name: retired-resource-attrs
>>> +    attributes:
>>> +      -
>>> +        name: node-id
>>> +        type: u32
>>> +        doc: Node ID targeted by this retired resource operation.
>>> +      -
>>> +        name: vram-page
>>> +        type: nest
>>> +        nested-attributes: vram-page-attrs
>> why wrap attrs in a nest? Are you planning to add other resource types
>> (than a page)? It's a common anti-pattern in Netlink to over-wrap stuff.
> we should indeed remove the wrap and have only the page info.
>
>>> +        doc: >-
>>> +             Type-specific payload. The resource type is identified by the
>>> +             node (its node-name); each node reports a single resource type.
>>> +  -
>>> +    name: vram-page-attrs
>>> +    attributes:
>>> +      -
>>> +        name: address
>>> +        type: u64
>>> +        doc: Device address of the retired VRAM page (e.g. DPA).
>>> +      -
>>> +        name: size
>>> +        type: u64
>> prefer uint
>>
>>> +        doc: Size of the retired VRAM page in bytes.
>>> +      -
>>> +        name: max-pages
>>> +        type: u32
>>> +        doc: >-
>>> +             Maximum VRAM pages that can be retired. Present only in the
>>> +             leading summary entry of the dump (no address/size/status).
>>> +      -
>>> +        name: status
>>> +        type: u32
>>> +        doc: Retirement status of the retired VRAM page.
>>> +        enum: retired-resource-status
>>> +      -
>>> +        name: pad
>>> +        type: pad
>> And then you won't need pad
> I noticed this in the review prompts, but I have some reservations here.
> We know for sure our value is always u64 because it is our hw definition.
> I don't see a good reason why not use the exact size that matches our hw.
