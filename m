Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2D20CA5FDD
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 21:05:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A39EE10E420;
	Thu,  1 Oct 2026 21:05:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="iubg9tbc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76C5C10E420;
 Thu,  1 Oct 2026 21:05:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790888751; x=1822424751;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=1lSodrvh8p1i0fwMdoDC9xOUXyHIbTxrDbOiwln0rVk=;
 b=iubg9tbcsy/cmMKk4yrjkwwRStktmIkQJD8cNaJ00EGCS1TQVAGvx291
 2SVQ+KuWG0stXjJGzM6HlW4k1MBfmjyOvVnsRDIIeExlE9XDyW+R9spLk
 y9QWyQNPz/qvc1SLR0yreM/ch9UUkucbJ3NVNdGPUjGBl0dLn5rSPbkT/
 xLDFrcTel2w/3aaFjOFyBb/et1Jhb8fWFZ6UdL2jAQ+PWgIeNE6ag3ZPV
 v9CojeSOAvvm0z+y7kx32d4u6UC1R69cBXsJ70EOHsBYT3E+mI/vDRsl6
 wy7kgmRyQyF8xYORPjAelaN4RU9evXwTQATnSlwtsgEf6Dr2ZhPsMasfj A==;
X-CSE-ConnectionGUID: C94eynYFSnmR3ehbS2/f7w==
X-CSE-MsgGUID: UgyqbtaTSTenpr2/EF7Pxg==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="95471080"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="95471080"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 14:05:50 -0700
X-CSE-ConnectionGUID: N6hd6bFJTnuWOxpmpZDA4w==
X-CSE-MsgGUID: iskmeSX3QDWdZdKL4G9ErA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; d="scan'208";a="279388542"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 14:05:49 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 14:05:48 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 14:05:48 -0700
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.21) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 14:05:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT3jlzyUMGfsKhJEXsVIBe1ukxJ0VVe2YI6fkbmisM+FxE+Dm3nm1HRyjR9dqcbVaJTGU74lLCAAv2/pqDyeus182Uqe7oYYlxjLDzYLXKpokc49xV+laPu8szPkYI0HZTB5xQBibB2xIZkBrvwqMwIhDQZF4OfM7fr3w/dKjTVnR+tmf2+DD/1X/7UNYNFUDP4hH8AL1dc4QJBQHz4TUnkJpbHw+fRtU45sa2+WI3neib1eSU0hQkW7kVfMZF5AyTKzZ7pmmVbG6IsqfUF0JyZ/P/6hwaEaXW/Ueu6TyC/Md7ewbBOrM9F1QNFLtCtssbPf3c1833sRLmqoDdQ3Ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5JxLhVCB9R0ufkCASo6osYBA2gqh0TLAGpDNZwoFVDY=;
 b=XM+30HtJuF5usFcZRkLKjYMvhwhA97olPaMnpgWv+LtoxVYY/viBmrOATIYDgDT0Yhcpx6HjlSA5MijeNRAUOJUMNyHwG77jFiUSlz39vxyCbPylNfsaqs85c/nIvUzwS+qrc9wjjQvY1oUtSfA4/ZMKjZHeCguXbRWoXGY1eUw90ENXSGteRcM0SazvxjsVWGfJkZSpTKLFWA7deBRH+XYDbXf80vZL5eVBY5n2IH2vaORvMRmPqjsAXtbSYtLgxCdWwVc9tj3SA9tKumv0f1P5Lreeu3NdO2Buc3SbfHnmfdzyXb9tc5i1ukKdY/zh5d4SkWnghUIYjY0FAIVtJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by PH3PPF5A636EDE4.namprd11.prod.outlook.com (2603:10b6:518:1::d21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.27; Thu, 1 Oct
 2026 21:05:46 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 21:05:46 +0000
Date: Thu, 1 Oct 2026 17:05:29 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <dim-tools@lists.freedesktop.org>
Subject: Re: [PULL] drm-xe-next
Message-ID: <ar7LGdBE9K3LJGP0@intel.com>
References: <ar5YsqAK3bS4Ta6Z@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ar5YsqAK3bS4Ta6Z@intel.com>
X-ClientProxiedBy: SI1PR02CA0051.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::6) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|PH3PPF5A636EDE4:EE_
X-MS-Office365-Filtering-Correlation-Id: 128f5a4f-b4fc-4750-b197-08df1fffc2c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|11063799006|6133799003|260925022911599003|10067099003|260925021311599003|260925021911599003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: XP60Z5wPq7fiwsWzZhEPBxGiRFzT/rbwK6KbupMeF6TESKQMNy0l7CWJItTnUPBaaGU8qKFtQhFd0Ocmd2duu98g7wNiZb2+ApNDAZ2tvz2s/PZqWqmQF36C8u8yo/8ZxU0uzDmBoT2GIBM5+m5T4vYu6zi/dTpXmvVhVF7GMy3wFlKP3CeUe58svf0GJg9RdBwKn01cYamEYwBi+MlL21v+JzCzMgoiOdSsDYlS4tcREp8mrPXwkfL9+HtiG07GzrUci6zkA99MxEEZOrKE4rO/0tAte2G2VcSl1vpeU/lby9mPD7cYGolynLs6nxRnNntQ+DIsibnOsadvjzgVi4Vpi+g/k9aeZCqM/CURnaiwfK+Zz7JsubMHlD5AGi21PNL2mmM4SIvCg4cR8IzRXOBPJrQ4v/Ry9xMq7tmA272TyfBDhSyzRth5d0siNgLsSxPyANkJ2PkM4Tlw8OHnHDTC/fVXMpWPbLMDLtbBYvj15Gg0StfzI9cX/Zfj1FEMJK1aw9qqfLAMnhygckn+6GVCNYmTQQuDDKBDFHwXlSJ6Rb9P8b27c0WoLqezjGBR3xYbmyNvHPFQvB882uNxoOzHMsvjgoZjN4wGBPUMVeg=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(11063799006)(6133799003)(260925022911599003)(10067099003)(260925021311599003)(260925021911599003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a2ZDVDB3bUlYSnhWWGJkNWJqekFMWC9IM21ROVgwRmpMU00yMGt6MlhwbTUx?=
 =?utf-8?B?YlM1YWFSV0dyRUU0K3dCZEFYYWxrcEs5SEMvUWFYQXl4OXRkamx5eWVUZWZN?=
 =?utf-8?B?YUdaYjZVWng1S0tsZzRKTmFiWmN6d2pGVmJaNEZXM3B2Y0J6YUIxaWRRRnFl?=
 =?utf-8?B?eDAzNEc4Y0xOMkUrWVNzODcyenljc2FUczgwa3NNWmRiV2h6cVRncHZxWkla?=
 =?utf-8?B?NjUwY051dzRDOWZ0MldmTTlsY29ISHlrM29rUVBCN2Y5aXFHSmxVU05CU3lm?=
 =?utf-8?B?Z1BLcW9YS2g3YmxZYmlESG1DSDVTM0ZEQmZpdE5LaCtqNTRobUo2WXFDbXAy?=
 =?utf-8?B?T0RyR1dXbDZKcWFhQlg4WHVmOVZyQitNWmhVc1pjRGFrRkIybzRSSGN0VEJK?=
 =?utf-8?B?cStKR1IwcDRZUUhOaXNrSkdTd3o5YVRrQmRrb1VhWThBUDJqMGhPY0FpdHhT?=
 =?utf-8?B?YWk5L0N5QkFXWnJDTzlYdk5URThRYjVEMThjK0N6Q2MwUkdUN1NVNFNIK2tj?=
 =?utf-8?B?ZGI5cnVHeUZzTytNVlNZckE5Z0RTejRmajhFY2tBR2J1blVFY000WEx1NGpo?=
 =?utf-8?B?VDJhUEdoM0EwYUZFL1V5bzM5NmZIakNuUWxzV3VWWmVXRitWMm5UNE1BZm0w?=
 =?utf-8?B?TjdBL1hEektBc0RSVkxZcENDQytRRzNuY3pEQXVjb2M0VmE5ZHJCSk0wL0NP?=
 =?utf-8?B?MTJVdnowc0hkdGxWTEExYzJsZWpHSTVwWE9uVmRjVFpNSjg5SDQwdGxRV0ZB?=
 =?utf-8?B?ZzdOVVJrWFk3YUN0dTdRSW9VdEhleXBBa2RPTXJzcDN3ZFZ2bHJFdk9ReGc4?=
 =?utf-8?B?WTFncGpGaFBBcnMzaXc5T3MrN0o4eEllSng1YWV6SURQaVV3OENLbDVlWjhs?=
 =?utf-8?B?UkRHR21DWGFLSGVndVROYzBuY01WREFmVlVUZjFLZGZzVkE0TTB0Q3BnSEFj?=
 =?utf-8?B?aHE3V1VKMXRRMU5qbGZqTWx2K2IyL0h6NlJKNEtzRHpWdDk3QlJlOVRHMFN4?=
 =?utf-8?B?NDF3aXYweWx1Y0MzN2hpQ0kyaEZaVWl0YzR2RHRXd1M4ZTRSaFFHcEYzT3g5?=
 =?utf-8?B?eDFPOS9lTGJtOGlFN3VPd0N6N0ZDTzN3cGV5TW0vVVA4VUp5TDZ6bFRMOHdE?=
 =?utf-8?B?azBTclJDNUYzNG5TWWMyUzZqcnIvS2ZKU3pzUjZjNW5qaHdFT2d6MTJWTlNs?=
 =?utf-8?B?OXZFSTFBN3JjUTRxMjFFTGFJMlg4ZWdxUkdwbFZlMnFiWFlHS0g2djV5VmlN?=
 =?utf-8?B?RzZyT1BQMHQzb01qSTRVamRJNWFoNGF4S2Jlc2VWZVVQYXA4N0FjTllSMjB3?=
 =?utf-8?B?TUNNRVBuZm1VYXV2QWVkV0xjOGJIam0rZUh3NmZEQ3oxNjFJMHlzQVpkZkt2?=
 =?utf-8?B?b1NlM2NmcVdBc3g0eUR4bEIvZ2FpQXVLNmVNeDdoYWl5VEszcEV0RmZnYm4y?=
 =?utf-8?B?d0NyL25nV24zLytGdmUvckNPN0NsN1pSQVVsSW5QdTJzZ1VoQS9tbFF4VGJy?=
 =?utf-8?B?V0JoaEFFbkFEWmJoTVBsZE9rZ0o4UjZrSENpTWRNQUZ4VU5wcUlUd3ZHOUFs?=
 =?utf-8?B?TkxIZDNENVFpTTdHcElCL0JJNUZib2MxOVpBVkEvckRxcHV6MlRMSTBiQi9B?=
 =?utf-8?B?cXZoSk03MnRQQkxhVzdsaTJJb3hwTzhBc01QU0hBSUdadmRwemU4cE93WDZ0?=
 =?utf-8?B?N2YyeVlNdjBGbXJQV01DeXJWQlB4RHdrR0taTE9vNXEwWnpKWFpXNytWd1JE?=
 =?utf-8?B?c05OSGUrZm5PcVhLeEF6RFFhVDdsaGJQWDJ4dElEdUdGTnlYdDNzREFIeFhx?=
 =?utf-8?B?Vnd6Skw2dWpGMyt6M1lHK3ZmekI3RWlrMEJPcnlPMmQrWVUxTGZGNHcwUzJz?=
 =?utf-8?B?WWVkR2RyZHdkYUQwMGpITEYxWUk2blVZUGZUdGZ6WEtTSTNmdjl5TmtJQkNF?=
 =?utf-8?B?RElQQThneDN1bjRsZy9pMndrcnk3NHJKa0xPN3g4b1EwM0kwK0sxYnVSL0sy?=
 =?utf-8?B?QnpyNjU2Nm8xY2ZZSUZvR1RwbG5zZUI3SVVzUDk1NnpuUVYwV2o2TG1UcDdO?=
 =?utf-8?B?Q1NzanN6MFlhQ3NiSWxzSVE1WTlzYVZGZThTYU9BdmNMaG9JUjljY0E3R2lJ?=
 =?utf-8?B?Kzh1dWVGK2s2c0UwRzNzY1hDMElqSFNMRWFPdmkrN011S0xCTHQ3ZUl3ci9C?=
 =?utf-8?B?dW5aRlNXRlg4YTNCMmxlaFdpZGgxVXc4MmU5NmNGdzVFY0VZaUovODZDNUlk?=
 =?utf-8?B?YXpCb3diRjVkMGJ2MDhCYUV2YmVUZFdSUnFvNVl2ZkY0WUxWcVMxSndzUDF4?=
 =?utf-8?B?aS94MUZMMjVZbDliWjU3K20zV2xuRXpqUGxrL2pRVGJuZ09oSHVtZC9tcmdp?=
 =?utf-8?Q?+BX1nEiQDZ7x9pDc=3D?=
X-Exchange-RoutingPolicyChecked: dX/X1/MGX880hyaeg5M9sc7xan3ui0U/Eo5HsacA1tmbNLGiFO5Gtm9BtDghTiRN0Bn9pvvqef9Pjxhx0KCRgglIPMkj08/B5Uq7tepM/sjUvWHzPwDI5o8hgOnITfaZshkWqnX/bKl5lHRpn0oxaMXyyEDv9UUh9wNh6jsOFZQ5ykiZwvlxJF9diyx7LloZD5uK0+VWgNvGkMT2GKMQhsRSbzIOqzUAArQKAP2+DxLSSqDdtI6wj3/+xf31Q46KWK5E9+ftktHS2unQZEPWQHd04DlS+lJXofKYUWji9YqGu2C8AlcqKf1Qns5rLjffmoy/J6t83MRzzuXQzzZY5Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 128f5a4f-b4fc-4750-b197-08df1fffc2c7
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 21:05:46.1232 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G8e7iPCK8oMVtfJYBYXf5odLN6BHrZ2+uBCtMWmHkPi+Dr2o16JEdtV9QNSPB2NUXFNv3mQS2lIznkyQvDn0QA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF5A636EDE4
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

On Thu, Oct 01, 2026 at 08:57:22AM -0400, Rodrigo Vivi wrote:
> Hi Dave and Sima,
> 
> Here goes our likely last PR towards 7.4 of xe changes.

Please disregard this one and use Matt's instead:
https://lore.kernel.org/dri-devel/ar7JQUI6b+PcQa4S@gsse-cloud1.jf.intel.com/

I was going to do the drm-intel-next and end up doing the xe-next...
I will ensure I have enough coffee before sending the PR next time :)

And I will send the drm-intel-next tomorrow.

Sorry for the mistake,
Rodrigo.

> 
> Thanks,
> Rodrigo.
> 
> drm-xe-next-2026-10-01:
> UAPI Changes:
>  - New sysfs to expose device UID (Badal)
> 
> Driver Changes:
>  - Nuke PTs only after unlinking contested VMAs (Auld)
>  - Limit sg segment size to PAGE_SIZE on Xen PV (Szymon)
>  - Move locking to xe_sriov_pf_reprovision_default (Michal)
>  - New workarounds (Tilak, Tales, Daniel)
>  - Keep VF LMEM BAR size low if no VFs enabled (Marcin)
>  - Drop ratelimiting from dev_unhold_work debug trace (Varun)
>  - System Controller's Maibox response improvement (Anoop)
>  - General clean-ups (Roper, Lin)
>  - Revert "drm/xe: Set mask bits for CCS_MODE register" (Roper)
>  - CPU binds and ULLS on migration queue (Brost)
>  - Re-apply an i2c patch silently removed by a merge (Bartosz)
>  - New PTL PCI ID (Atwood)
>  - Enable PXP for NVL-S (Alan)
>  - Let xe_guc_ct_send_locked() callers reserve G2H credit (Sujaritha)
>  - Implement print vfunc for page fault info logging (Brian)
>  - Do not dma_fence_put zero fences in err_out path (Jonathan)
>  - Add focused VM teardown and page fault tracing (Daniel)
>  - Fix ULLS chained job loss and GT reset replay (Varun)
>  - Refresh TTM LRU on SVM prefetch (Himal)
>  - Fix xe_mmio_wait32() to honor delay/sleep maximums (Alan)
> The following changes since commit 320662381ca243a3364663e917a7447afaf618fa:
> 
>   drm/xe: Poll GT for C6 before D3 (2026-09-18 11:52:56 -0400)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/drm/xe/kernel.git tags/drm-xe-next-2026-10-01
> 
> for you to fetch changes up to 70dab9ee7d620e6018a64798aed065d14e9baed1:
> 
>   drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums (2026-10-01 08:46:23 -0400)
> 
> ----------------------------------------------------------------
> UAPI Changes:
>  - New sysfs to expose device UID (Badal)
> 
> Driver Changes:
>  - Nuke PTs only after unlinking contested VMAs (Auld)
>  - Limit sg segment size to PAGE_SIZE on Xen PV (Szymon)
>  - Move locking to xe_sriov_pf_reprovision_default (Michal)
>  - New workarounds (Tilak, Tales, Daniel)
>  - Keep VF LMEM BAR size low if no VFs enabled (Marcin)
>  - Drop ratelimiting from dev_unhold_work debug trace (Varun)
>  - System Controller's Maibox response improvement (Anoop)
>  - General clean-ups (Roper, Lin)
>  - Revert "drm/xe: Set mask bits for CCS_MODE register" (Roper)
>  - CPU binds and ULLS on migration queue (Brost)
>  - Re-apply an i2c patch silently removed by a merge (Bartosz)
>  - New PTL PCI ID (Atwood)
>  - Enable PXP for NVL-S (Alan)
>  - Let xe_guc_ct_send_locked() callers reserve G2H credit (Sujaritha)
>  - Implement print vfunc for page fault info logging (Brian)
>  - Do not dma_fence_put zero fences in err_out path (Jonathan)
>  - Add focused VM teardown and page fault tracing (Daniel)
>  - Fix ULLS chained job loss and GT reset replay (Varun)
>  - Refresh TTM LRU on SVM prefetch (Himal)
>  - Fix xe_mmio_wait32() to honor delay/sleep maximums (Alan)
> 
> ----------------------------------------------------------------
> Alan Previn (3):
>       drm/xe/gsc: Define GSC for NVL-S
>       drm/xe/nvl-s: Enable PXP for NVL-S
>       drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep maximums
> 
> Anoop Vijay (1):
>       drm/xe/sysctrl: Allow per-command mailbox response timeout
> 
> Badal Nilawar (1):
>       drm/xe/cri: Expose device UID through sysfs
> 
> Bartosz Golaszewski (1):
>       drm/xe/i2c: Re-apply use device_create_managed_software_node()
> 
> Brian Nguyen (1):
>       drm/xe: Implement print vfunc for page fault info logging
> 
> Daniel Charles (2):
>       drm/xe/xe3p: Force non-compressible memory reads to 256B overfetches
>       drm/xe: Add focused VM teardown and page fault tracing
> 
> Himal Prasad Ghimiray (4):
>       drm/pagemap: Add helper to access backing devmem allocation
>       drm/gpusvm: Add devmem callback to get_pages
>       drm/xe: Bump prefetch BO LRU via GPUSVM devmem callback
>       drm/xe: Bump prefetch BO LRU for already-valid ranges
> 
> Jonathan Cavitt (1):
>       drm/xe/vm: Do not dma_fence_put zero fences in err_out path
> 
> Marcin Bernatowicz (1):
>       drm/xe/pf: Keep VF LMEM BAR size low if no VFs enabled
> 
> Matt Atwood (1):
>       drm/xe/ptl: Add a new PTL PCI ID
> 
> Matt Roper (2):
>       drm/xe: Drop old Xe GT ID macros
>       Revert "drm/xe: Set mask bits for CCS_MODE register"
> 
> Matthew Auld (1):
>       drm/xe/vm: nuke PTs only after unlinking contested VMAs
> 
> Matthew Brost (24):
>       drm/xe: reference VM from PT BOs
>       drm/xe: Drop struct xe_migrate_pt_update argument from populate/clear vfuns
>       drm/xe: Add xe_migrate_update_pgtables_cpu_execute helper
>       drm/xe: Decouple exec queue idle check from LRC
>       drm/xe: Add job count to GuC exec queue snapshot
>       drm/xe: Update xe_bo_put_deferred arguments to include writeback flag
>       drm/xe: Update scheduler job layer to support PT jobs
>       drm/xe: Add helpers to access PT ops
>       drm/xe: Add struct xe_pt_job_ops
>       drm/xe: Update GuC submission backend to run PT jobs
>       drm/xe: Store level in struct xe_vm_pgtable_update
>       drm/xe: Don't use migrate exec queue for page fault binds
>       drm/xe: Enable CPU binds for jobs
>       drm/xe: Remove unused arguments from xe_migrate_pt_update_ops
>       drm/xe: Make bind queues operate cross-tile
>       drm/xe: Add CPU bind layer
>       drm/xe: Add device flag to enable PT mirroring across tiles
>       drm/xe: Add ULLS support to LRC
>       drm/xe: Add ULLS migration job support to migration layer
>       drm/xe: Add ULLS migration job support to ring ops
>       drm/xe: Add ULLS migration job support to GuC submission
>       drm/xe: Enter ULLS for migration jobs upon page fault or SVM prefetch
>       drm/xe: add migrate ULLS period configfs attribute
>       drm/xe: Document ULLS for migration jobs
> 
> Michal Wajdeczko (1):
>       drm/xe/pf: Move locking to xe_sriov_pf_reprovision_default
> 
> Shuicheng Lin (2):
>       drm/xe/madvise: Remove unreachable madvise_funcs NULL check
>       drm/xe: Remove no-op ternary in emit_flush_invalidate()
> 
> Sujaritha Sundaresan (1):
>       drm/xe/guc: Let xe_guc_ct_send_locked() callers reserve G2H credit
> 
> Szymon Acedański (1):
>       drm/xe: Limit sg segment size to PAGE_SIZE on Xen PV
> 
> Tales A. Mendonça (3):
>       drm/xe: Capture devcoredump on TLB invalidation timeout
>       drm/xe: Log when a timed out TLB invalidation ack finally arrives
>       drm/xe: Implement Wa_22016122933
> 
> Tangudu Tilak Tirumalesh (3):
>       drm/xe: harden adjust_idledly() against divide-by-zero and overflow
>       drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms
>       drm/xe/xe3p_lpg: Add support for Wa_16030224309
> 
> Varun Gupta (4):
>       drm/pagemap: Drop ratelimiting from dev_unhold_work debug trace
>       drm/xe: Park on the ULLS semaphore before publishing the next job's tail
>       drm/xe/guc: Publish the ring tail when replaying a chained ULLS job
>       drm/xe/guc: Rewind the LRC ring head when replaying a ULLS job
> 
>  .../ABI/testing/sysfs-driver-intel-xe-gpu          |  10 +
>  Documentation/gpu/xe/xe_migrate.rst                |   3 +
>  drivers/gpu/drm/drm_gpusvm.c                       | 105 ++-
>  drivers/gpu/drm/drm_pagemap.c                      |  17 +-
>  drivers/gpu/drm/xe/Makefile                        |   1 +
>  drivers/gpu/drm/xe/abi/guc_klvs_abi.h              |   1 +
>  drivers/gpu/drm/xe/regs/xe_gt_regs.h               |   3 +-
>  drivers/gpu/drm/xe/regs/xe_regs.h                  |   2 +
>  drivers/gpu/drm/xe/xe_bo.c                         |   4 +-
>  drivers/gpu/drm/xe/xe_bo.h                         |  29 +-
>  drivers/gpu/drm/xe/xe_bo_types.h                   |   2 -
>  drivers/gpu/drm/xe/xe_configfs.c                   |  67 ++
>  drivers/gpu/drm/xe/xe_configfs.h                   |   2 +
>  drivers/gpu/drm/xe/xe_cpu_bind.c                   | 296 ++++++++
>  drivers/gpu/drm/xe/xe_cpu_bind.h                   | 111 +++
>  drivers/gpu/drm/xe/xe_devcoredump.c                |  46 +-
>  drivers/gpu/drm/xe/xe_devcoredump.h                |  15 +-
>  drivers/gpu/drm/xe/xe_device.c                     |  14 +
>  drivers/gpu/drm/xe/xe_device_sysfs.c               |  36 +
>  drivers/gpu/drm/xe/xe_device_types.h               |  15 +-
>  drivers/gpu/drm/xe/xe_drm_client.c                 |   2 +-
>  drivers/gpu/drm/xe/xe_exec_queue.c                 | 161 ++---
>  drivers/gpu/drm/xe/xe_exec_queue.h                 |  16 +-
>  drivers/gpu/drm/xe/xe_exec_queue_types.h           |  20 +-
>  drivers/gpu/drm/xe/xe_gt_ccs_mode.c                |   6 -
>  drivers/gpu/drm/xe/xe_guc.c                        |  16 +
>  drivers/gpu/drm/xe/xe_guc.h                        |   2 +
>  drivers/gpu/drm/xe/xe_guc_ads.c                    |  11 +-
>  drivers/gpu/drm/xe/xe_guc_ct.c                     |  23 +-
>  drivers/gpu/drm/xe/xe_guc_ct.h                     |   2 +-
>  drivers/gpu/drm/xe/xe_guc_engine_activity.c        |   6 +-
>  drivers/gpu/drm/xe/xe_guc_hwconfig.c               |   2 +-
>  drivers/gpu/drm/xe/xe_guc_log.c                    |   7 +-
>  drivers/gpu/drm/xe/xe_guc_pagefault.c              |  35 +-
>  drivers/gpu/drm/xe/xe_guc_pc.c                     |   3 +-
>  drivers/gpu/drm/xe/xe_guc_submit.c                 |  90 ++-
>  drivers/gpu/drm/xe/xe_guc_submit_types.h           |   2 +
>  drivers/gpu/drm/xe/xe_hw_engine.c                  |  96 ++-
>  drivers/gpu/drm/xe/xe_i2c.c                        |  22 +-
>  drivers/gpu/drm/xe/xe_i2c.h                        |   1 -
>  drivers/gpu/drm/xe/xe_lrc.c                        |  73 ++
>  drivers/gpu/drm/xe/xe_lrc.h                        |   4 +
>  drivers/gpu/drm/xe/xe_lrc_types.h                  |   4 +
>  drivers/gpu/drm/xe/xe_migrate.c                    | 771 +++++++++-----------
>  drivers/gpu/drm/xe/xe_migrate.h                    |  95 +--
>  drivers/gpu/drm/xe/xe_mmio.c                       |   5 +-
>  drivers/gpu/drm/xe/xe_pagefault.c                  |  53 +-
>  drivers/gpu/drm/xe/xe_pagefault_types.h            |  10 +
>  drivers/gpu/drm/xe/xe_pci.c                        |   5 +
>  drivers/gpu/drm/xe/xe_pci_sriov.c                  |   3 +
>  drivers/gpu/drm/xe/xe_pci_types.h                  |   4 +-
>  drivers/gpu/drm/xe/xe_pt.c                         | 779 ++++++++++++---------
>  drivers/gpu/drm/xe/xe_pt.h                         |  12 +-
>  drivers/gpu/drm/xe/xe_pt_types.h                   |  49 +-
>  drivers/gpu/drm/xe/xe_ring_ops.c                   |  86 ++-
>  drivers/gpu/drm/xe/xe_ring_ops_types.h             |  24 +
>  drivers/gpu/drm/xe/xe_sched_job.c                  | 101 ++-
>  drivers/gpu/drm/xe/xe_sched_job.h                  |  56 ++
>  drivers/gpu/drm/xe/xe_sched_job_types.h            |  49 +-
>  drivers/gpu/drm/xe/xe_sriov_pf_provision.c         |   4 +-
>  drivers/gpu/drm/xe/xe_svm.c                        |  68 ++
>  drivers/gpu/drm/xe/xe_svm.h                        |  18 +
>  drivers/gpu/drm/xe/xe_sync.c                       |  20 +-
>  drivers/gpu/drm/xe/xe_sysctrl_mailbox.c            |   7 +-
>  drivers/gpu/drm/xe/xe_sysctrl_mailbox_types.h      |   3 +
>  drivers/gpu/drm/xe/xe_tlb_inval.c                  |  54 ++
>  drivers/gpu/drm/xe/xe_tlb_inval_job.c              |  28 +-
>  drivers/gpu/drm/xe/xe_tlb_inval_job.h              |   4 +-
>  drivers/gpu/drm/xe/xe_tlb_inval_types.h            |  17 +
>  drivers/gpu/drm/xe/xe_trace.h                      |   2 +-
>  drivers/gpu/drm/xe/xe_trace_bo.h                   |  58 +-
>  drivers/gpu/drm/xe/xe_tuning.c                     |   4 +
>  drivers/gpu/drm/xe/xe_uc_fw.c                      |   1 +
>  drivers/gpu/drm/xe/xe_vm.c                         | 275 ++++----
>  drivers/gpu/drm/xe/xe_vm.h                         |   3 +
>  drivers/gpu/drm/xe/xe_vm_madvise.c                 |   6 -
>  drivers/gpu/drm/xe/xe_vm_types.h                   |  12 +-
>  drivers/gpu/drm/xe/xe_wa_oob.rules                 |   4 +
>  include/drm/drm_gpusvm.h                           |   6 +
>  include/drm/drm_pagemap.h                          |   7 +
>  include/drm/intel/pciids.h                         |   1 +
>  81 files changed, 2717 insertions(+), 1370 deletions(-)
>  create mode 100644 Documentation/ABI/testing/sysfs-driver-intel-xe-gpu
>  create mode 100644 drivers/gpu/drm/xe/xe_cpu_bind.c
>  create mode 100644 drivers/gpu/drm/xe/xe_cpu_bind.h
