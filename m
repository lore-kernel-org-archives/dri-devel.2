Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01C1B606A31B
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=mNE8mhKv
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5750410F8CA;
	Tue,  3 Nov 2026 22:48:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC9B810F849;
 Tue,  3 Nov 2026 22:48:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793746099; x=1825282099;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=j+TOeAlAoklmD3InLSsMS/BVxrP1wSSaEBRiQq3nR50=;
 b=mNE8mhKvWSgyfFrv5lRMXcWGKnPb03lDdyDu4jouu+QXl9RsJGA97iWc
 nKRkr6QwZyH6KX1bwvKPvxecyVY5rgsZcY28Hv93Tbh3OCid+0AVi+06Q
 Z2xwNZdWGP+6NyVI9V/9ZOddWOI8WiiWNIbLPX726Uv3mwW7Sbk1EK/VZ
 njI5qbv8F5iv1GwdkwLqtWxV6Fpm0q3qUNWv5R71ye8EGtUTJKwJPT4cA
 PwoanPVfNUiq+907UStIyne7JMvfXIJOVVKWGmp+sNfyx6gv2BbWMAfUy
 uSgorp902VlTXs+ErtW04ejC0OpzFBP0mhM/RICgSXqsI2seKsRQx760r w==;
X-CSE-ConnectionGUID: +spV1czvQ+OL0WUESDuLCw==
X-CSE-MsgGUID: NcsqO2m+Sd6IVz7uJXvVKQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2387452"
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="2387452"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 14:48:18 -0800
X-CSE-ConnectionGUID: 4g4LKh7EQl+MoEPhZamEfA==
X-CSE-MsgGUID: OUdk+fUMTMOOU6FInhOk1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,194,1787036400"; 
   d="scan'208";a="6672730"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Nov 2026 14:48:19 -0800
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 14:48:17 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 3 Nov 2026 14:48:17 -0800
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.40) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 3 Nov 2026 14:48:17 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cni7uLjAYzNflBjw3DfnGDT3t5ltBfcoNmfrS5BBg+wUicqoOS8prQetLGcYwlP70UJCTlsJ3IQn1f8dEX2nbaekrDwVRm1OSqN+kMqDxykOF7YjNEz8pAj8V52kQ/q8E9hWealLX329WetRbnUhz5bZW9c6/vc1Z8ZMGgi4jMjMSF8sWmsLNiQ0u4PjpzPkFYWugoWaaKNVJSkGRjR+e1dxtg00AztlLzjmI5UnBxiQjLqVL/Nk3qfDRs7lYPt6rJZ3V0j4Y/owavtoe7E//4NUC/qgXsuZBhzH/LYLBsIt3L0F7OpK6FCgxNFkBmqz/IhzItaGdNWCOrwI77Dx2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OQLHocAmQnIaho+giYm7NtpDJwQvqhEn/h7s9GNFXic=;
 b=tAMFGhEerPa5rQdc0tvnDFxCXRv2aytGwUClZI4bVqGxp08JL/fz33sCukPkk2bWx3z46H4c5hKxQj2ZVAnOGK7egPEsS+as/R15NXCqA2yzO0rOXjE4GWCMFFDVEooABGTMBOgcG0fNzjiM+lC2YuYZPkTa0mxvSXIweEMDwZsKyzbLbYXrFzXRXd4P2To4tW0QgdIEsIU+wCAY65ut9Pr6KdmJuWHMp4VglmEaMiYgwUrsMbkrrgDF4Bg5kBebNdu6+TT0/Gi5ERTyxPxSOR3sAOyGRfMLW93JfzPfz0Ik+LFU8Up/RTavOh+vYeQfH87Xcm+FPqju6SjEw2TQGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4979.namprd11.prod.outlook.com (2603:10b6:303:99::16)
 by IA1PR11MB7319.namprd11.prod.outlook.com (2603:10b6:208:425::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Tue, 3 Nov
 2026 22:48:15 +0000
Received: from CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc]) by CO1PR11MB4979.namprd11.prod.outlook.com
 ([fe80::ed0a:e4ab:fde6:edcc%7]) with mapi id 15.21.0592.007; Tue, 3 Nov 2026
 22:48:15 +0000
Message-ID: <e366437d-1acf-4fb6-b10b-94d266c63572@intel.com>
Date: Tue, 3 Nov 2026 14:48:14 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] drm/xe: Add support for WA 14028250015
To: Gustavo Sousa <gustavo.sousa@intel.com>, "Teres Alexis, Alan Previn"
 <alan.previn.teres.alexis@intel.com>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>
CC: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>
References: <20261029181039.598756-2-alan.previn.teres.alexis@intel.com>
 <874ie2u6jc.fsf@intel.com>
 <10a999d06de867a938a67fbc345e4acda9ddafff.camel@intel.com>
 <87zevqougv.fsf@intel.com>
Content-Language: en-US
From: "Ceraolo Spurio, Daniele" <daniele.ceraolospurio@intel.com>
In-Reply-To: <87zevqougv.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0221.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::16) To CO1PR11MB4979.namprd11.prod.outlook.com
 (2603:10b6:303:99::16)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4979:EE_|IA1PR11MB7319:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c801d6b-8888-46db-7995-08df39fc8c09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|376014|261026140227099003|260925021311599003|260925021911599003|260925022911599003|4143699003|11063799006|261026121527099003|56012099006|261009223027099003|261028144727099003|261022105027099003|261022113327099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: OaeA12Z3z3qQl9hIIPhAmRw3n+dr9RQmcLDoC2xmwNNDjVPHChv51YBxAly0s3kgxMNGVRZxreJDpmdVjNbBtQqqli9DrhcjD/HjaA56QjmuOtHOaiK5sw7D+UaXXWMz0krA57ErQuKk2gK4huseuVs6aAYboMrqk+e2zCxJ+gEDRq927/pAQl3qAWukY18Kc4VvsMdeT43FYEgKFD3pQR0xKg6aM4ggf3AO0c/UJLZfzyg9aEIcIZG0NWnaIx+YIpjeiJbC66v+x+6UDeZjedCInl1uW4SyKix57/nrszIxRV/uoMjSwPclnB815JGe95fvyHqkkkVWxnd7a6GQLqL7XYLArMxAFmy8mb0dDGfmfAUocbRWoAP4DLMzpN+fvx/kj9W1U4pgDs2E4O+CELAGt6BonYaOJ1JpcAcHWHbNxIii3THZ1Uk3745hQAnOi/HDuSyvj+9SPMgbi/SpjHC4dvbs7xbZL5OI1f3DEYJlZOlL43/2NLVjB+VDcE4OlUFS1Pvs/VsO3f+ov1oVDTlkTomNHHf/MyWIDwWDXJOUEHKglA0GlubMAB0+MLGfcKX0vZzi0XXFcmJ5ijTTnzmpzcKgijVUQS5J0AwAN7JPZqYbhnxLYy9rowrGnJUyBuq+IDi7YfFxelPbZ5UhN2YKAiYixrOkSEzuB3EXwOI=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4979.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(376014)(261026140227099003)(260925021311599003)(260925021911599003)(260925022911599003)(4143699003)(11063799006)(261026121527099003)(56012099006)(261009223027099003)(261028144727099003)(261022105027099003)(261022113327099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBrSmJ2SXBKUmh1TXpRNHRjVjVGeUUwWWFZUkUxS2IzaFJCQ1Y0VFhRZkpF?=
 =?utf-8?B?VGZIZjVtWWZYYm4xeko1TWVHb0V4R052RnZOb1RkUU85RHNjZjFrYTVybFBU?=
 =?utf-8?B?VFVKREZhc2JYZ1JrUFZSTU9URWdIaWk5eU96OVEyZHhiQ0FmUUk3RWdjeVRU?=
 =?utf-8?B?QVU1ZFE1bzNWWWoyZDdwVW9Zb3NaNlFocTFPMWJ0WDB5dUFIYnJMenp3ZU1t?=
 =?utf-8?B?R0RTc2xyUXIvcEdtZk51aFluVFN6NDJEQ0ZxdkxyRzg5V0N5bmZBLzh4eEk0?=
 =?utf-8?B?ZTBIeXE0eUx4TDNjbERqS3JrWWJvNEg0cXhqUkpFaTlqbHB0eWl6ME5pYTJ1?=
 =?utf-8?B?a0xUV3MwVmVEMmZvZVJGL2tkTEhJUGxSVXhIWisyVjVmdGRiWnVNcElLU3hK?=
 =?utf-8?B?TCtxU0RTa1FLMEZ6YXVITnE2dmhRMWhXRDlPaEgvVmpiZHhzdXNwNjNKL2Iz?=
 =?utf-8?B?cnZvODZzbGpBZUNWbkZHaTdLRGtnMmhEREgzL1hjb3ZXRTNGSk1zeGVJY2Vu?=
 =?utf-8?B?S245SDRvQnVQb3RlL3BOODd0czhGU1hiY0VzdmpMdVl5R3U1VDNCc3c2cXIz?=
 =?utf-8?B?OWxDckdPT2pqYVduZytmbkQ4U0hmY09oUmllY0ZtTG5SMG1jczBvUXVwR0ZM?=
 =?utf-8?B?TW9jc3JZUE84MXR0YU96bTNJd0Y0NjBrODRDam9Mbk0yZkpFVEJPWmpIRTk0?=
 =?utf-8?B?TWdVUmFhcjZhU3czalpFRjZEdWV6TDdhWnFRRStiNlBBMUFPdEs0SWpUclVQ?=
 =?utf-8?B?d0p6UHk3S3RodnRnSFlFd0pzaHRKaHBvdkwvZVl3ZFZ3THFVaXVJR21JdFYr?=
 =?utf-8?B?NGtiYVZaVGNzbHYzOHY1SnlIMnZtdWhFRFpnTlc5RGpqRFdPcHNaNHBuZmRG?=
 =?utf-8?B?cFl3ZHVmU05nS2RmUWJpd2VjRUJ0RjVxRGVpZjVNTEZLRVUrWEhMTDJkOGFQ?=
 =?utf-8?B?TVA4VkNIemRzUnF2KzR1UWJqYXljYkRhZjFxZWNWWnNDZVpHM1Y3VEEzNXc2?=
 =?utf-8?B?cldUQWgxd2xTTldQT25VNXdvUHJQd0ZoTDdUejF0UE1NUGViZWcwV2RndG51?=
 =?utf-8?B?TEhzdml1b0ZIU1R1VXJwdVZ0VjRJZ1JWYWkzS1VVV1lFSVRpSDhXc3g4aHI1?=
 =?utf-8?B?Z20raUhoWUNBcDlaUHZZT1p5K3BJT2locHJLZSt4dVBFcGZWaDBTQ1doeUcx?=
 =?utf-8?B?QjRXM1l6LzUxb3gyTmNqelM3OGtGTzhlSUdFZGRvMC9YT1ZpNjl4MUNQZ3E1?=
 =?utf-8?B?WWt2WlhreEV6d2xoRnVONTFYSTM0UThVa1RNdktEcjE2eGpuWUlzSDB4UjhT?=
 =?utf-8?B?MEtaYXoxTTF1cE0rNjkzV1RFQjR3RDhhQXNINGRTa21pZXFBSWYydHdENURr?=
 =?utf-8?B?RHlEbGpVbGVRUFdGYXJhQy9PVkRNeG5FM3puK3NhcFlMVW5wTWNTVHVwbmlU?=
 =?utf-8?B?ZStTZEltVlh4L2NUcVAzT0lOWHd5bmVjSnhJVElFaDI4RnFKZ2pYQlp6Z1NQ?=
 =?utf-8?B?MjZoWUF2SE1xbXNncXg3b3dKaWlhejRvaTU2RG5XZDAvSDNRRmFhVGlWS2M2?=
 =?utf-8?B?MkRnZkkySkhZSzZPUlMvdnRudmN1L1l4YUg4Tmt0ZHVkUUJLVVVxa3BLN1JN?=
 =?utf-8?B?eGNyRkNVWkVMKzBrZWFBcXVYazMrdWJZVURYNnEzTWFER1JXcWg5ci95eHdX?=
 =?utf-8?B?ajdwejJhOG5BdjFqK3ZGdEVqRGhwMG1ERUNIdFJ5M2Job0dYVWliWmhtQkhF?=
 =?utf-8?B?WUJBL3hmNzgrQk83bk9tR0xMS3VMUG9wQkpLTzBBMVgvQ2I4Zmh5dnZMMCts?=
 =?utf-8?B?SGNFbkY0ZlN3bC9TY01WMzM1Sm1UMDU0eHFHdVZoVlYyV28vL09xOW55LzY3?=
 =?utf-8?B?ZGJQd2J2VTJ2OVFPNWFBMHJwcFdyZW9qOWJBeFd5OUQxaGorSUJVdHRNUjNM?=
 =?utf-8?B?OTFTVFZ3M0dzeUpQcVZ1S1lMMkRwL1Nrb05oVjhzWVFXbWk3bzQwZlA0Szc5?=
 =?utf-8?B?YzQ4SVRYRlFJS0g4L2JTWlVzN3h4dHJramJZa3ZVU0Y2RTBYbHRUaGhuQTVN?=
 =?utf-8?B?RWx2OGhPNFFJWHJBb211VFpkUW41ZjhuWm14WWswMVFYTDJoUXB1UlAzZldN?=
 =?utf-8?B?WlJyV3daUlp6TkQ2TldlU2gvMFJqZUVrZjZTak5yZ1FiOGxsSWFXUUpURWdl?=
 =?utf-8?B?ZXJjaCsyTTUvTGVJNWFFZHd0eDBnQndyMHJXRnUrRkR2OTNpS0duc0FrZjd2?=
 =?utf-8?B?NExlYmF6cENTVXZXai9LTmVPUUpWUlV3ME5KczNzSVU5ZkkvblhJN0pnSkxo?=
 =?utf-8?B?cnA2ckNiWVo1dDg2QS9jc0xMamRqNi9EQVhvcFdPQ0RlYjJZR1pIcm1HWGNU?=
 =?utf-8?Q?2NbqYDnzC+lOXXpQ=3D?=
X-Exchange-RoutingPolicyChecked: wkCM3vMdYOjAmVTHD46E7UBTnCwFp7McIeAux97L1Wva8uP5HWD63pa6JU25/4vBczCtNXiu8W8ODa+VaZUdDraY9VQP60Iy5n4ofDCWgAoP7vFqv5fx1S8MIwhzcR0rr6DxZxpfoTtxmhJTXmoPIS7oA75+4P6r75pGrt7Nkvi1i2yv3WBTIZ8dCOfgEtQowopMr7Yd5e4untVjiZvjhPc3Uu6fYm4IqcqrqIcfFFfGkazmNjndDIeuxcFxwr8RJoCnzB6BYnO06kbFe8lnOr0qa+K1RQZ0U+BmnOlVl/Z5fyvYMEBIHNeL3XUlzP8uGT2bDZqxeEvMrS2hVbun+w==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c801d6b-8888-46db-7995-08df39fc8c09
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4979.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Nov 2026 22:48:15.5185 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ja0ZX6wPTsoF+tSTJqnt4kSdB8KzWwaWvkVfkkfy01EThLMmIn1Gi7Kod6JFnEn9/DM8w0rtlzb5VOCyXI+inOa111q+7irJi/kTS1HK/GM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7319
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



On 11/3/2026 6:33 AM, Gustavo Sousa wrote:
> "Teres Alexis, Alan Previn" <alan.previn.teres.alexis@intel.com> writes:
>
>> [snip]
>>
>>> Also, on the subject, I would prefer that we stick to the notation
>>> Wa_14028250015.
>> will fix
>> [snip]
>>
>>>>   	GUC_WA_KLV_REMAP_RANGED_TLB_INV							= 0x900f,
>>>>   	GUC_WA_KLV_IGNORE_MMIO_READ_SEM_TOKEN_64					= 0x9010,
>>>>   	GUC_WA_KLV_IGNORE_MULTIQ_CTX_COMPLETE_WITH_PREEMPT_IN_CSB			= 0x9011,
>>>> +	GUC_WA_KLV_ENABLE_PAGE_RECLAIM_ERROR_COMPLETION					= 0x9012,
>>> Probably better to use the same name as defined by GuC here?
>> if u mean the internal spec - sure i can do that but i didnt realize that is the convention here.
> I'm not sure if this is the convention though. :-)
>
> I just thought it would make sense to keep the names in sync.  Maybe
> Daniele can provide his input here.

We do try to match what's in the GuC specs when we can, but we allow 
divergence if it makes sense. In this case I think using 
GUC_WA_KLV_PAGE_RECLAMATION_COMPLETION_TIMEOUT to match the GuC specs is 
the better option.

Daniele

>
> --
> Gustavo Sousa
>
>> [snip]
>>
>>>> +	/* On GuC 70.78 onwards, we enable GuC PRL-completion-IRQ workaround on applicable GMIDs */
>>>> +	if (XE_GT_WA(gt, 14028250015) && GUC_FIRMWARE_VER_AT_LEAST(&gt->uc.guc, 70, 78) &&
>>>> +	    gt_to_xe(gt)->info.has_page_reclaim_hw_assist)
>>> Should we really gate this by the has_page_reclaim_hw_assist feature
>>> flag?  This flag can be changed at runtime via debugfs.  I would assume
>>> that GuC would do the right thing if PRL is not supported on the IP it
>>> is running.
>> yeah - like your idea better - will just always do it.
>>
>> [snip]

