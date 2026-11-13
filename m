Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF40F606A337
	for <dri-devel@archiver.kernel.org>; Fri, 13 Nov 2026 19:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=CxfXGP9o;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=Am6sSzf8
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5296D10E6C5;
	Fri, 13 Nov 2026 19:15:28 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2D64810E6C5;
 Fri, 13 Nov 2026 19:15:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794597317; x=1826133317;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=wMPIjnDWruOGl/PgEXQNEDx7gGVD5guutGs8Rbh8NZE=;
 b=CxfXGP9oEOaRC9efZCsaUN3aZYWV9dZh7YHO624mseJkNka5ayKc7npA
 WKJrwkVqGPFb/y8Qrlp8uhmBxWlYnTtUpU+420WkhcSGdj7f5Ey2sG+DF
 5t1/Cb4HtHSTAQTeb9pvmKLtIVgqc/TBF+RqSAUmDyGnS73o6CiXaDXVl
 v89ZKlS5t0seNah12Zcrs5HN4Vlp/waPLhyUV6f4xxjNZbNkPcwSsOdRD
 IzJeYyafs5lgeF/KB/UfJ8A3dOIrZ3dcd8FilxCt6KT+Quh8d7t9TK/or
 XPn+X9s3iOyQhit+ijdwpqTxNA8Q2ZsSKoqFQpWmr6ctqtr4Kg5caYHYY A==;
X-CSE-ConnectionGUID: 1wmCNIiBRdG3NLOn66cE4A==
X-CSE-MsgGUID: hwGOvvpIQ5ihI7yQNfeMrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11965"; a="3304716"
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="3304716"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 11:15:15 -0800
X-CSE-ConnectionGUID: su0UGyveQNK5vsQbkQkHbg==
X-CSE-MsgGUID: kt5G4S5gQWyUUTC+uxrwVQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,212,1787036400"; 
   d="scan'208";a="9089059"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Nov 2026 11:15:15 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 11:15:15 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 13 Nov 2026 11:15:15 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.7) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 13 Nov 2026 11:15:14 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LraPb6gIcAiLXIMeNZS3TBH8Dbl8bITcF/TG0NXt2L6bVxSPmw9QYjEbMZ6fl4tTHUPDcRe6MnEGSCG5gJPPzIzI4LOiIMt6KPfCI9jDFQhVwaskXRvGd3cutSRBrtADTje0qFsBfVvt0e4k003p4G24aSaN+NI9FEVgTy9ahqD/C+vf3pwCM/8c3BuTnGP/OD/3tkivzi3F/pZfOqWEV9EtIX/EmmoJ56OsE9j+zex/0oJN36B7PC2WbqNSi/kzEVPZJIEGxedyHbNbZMkxnE3BlVzt7JNGfY6Oj7DBbM89/g/XuLBPCUZHOscecZlAJm7wbYmWWDvdRkzAbOqWLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vKeQrwBhco6sfIJU7pB0nHmVLf9n3EoHh3i3ywgXPfo=;
 b=AaLep8ONQ4CM80ZwyfzNk3WQf1wNCiSq1gTxPRKQA8Q11J9YZjA0lVU1yADJmHyxcr6FObteOetIUKU87SgUGJyoiaVLga7NEG2B3JV//ieXn5QrsdYIlVWywgcJhyLpMqMoMgm1zpv0frj3x4maWbZEYnTge01f5c2m8XRU1KySmI3Nw9WoShg9U106cPzIF/PuvFZDbUKk/rneu8NYHq/jWCcZpXKcQ74cdcu2nmaqsuTAajH34yYF717A7VHMJ5xXnVKTd1Fiod6Mz32VjvoSoELDNt/g8x+Qo1uNVziUS5VpUelwaUJhaIT12CCl/EFQ8v9I+2VNbQCKimPTIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vKeQrwBhco6sfIJU7pB0nHmVLf9n3EoHh3i3ywgXPfo=;
 b=Am6sSzf8Jr+SXmx2AB3W3/f/EdSiSdMEmvDB/UGg3l1clYh4ry5mtQcM4i/q7xg4S7vEY8MtdPNbZumxJF3hn+porJUC7qri6YBGJTC9GO6HV667/3vaAVVeQqEBVbuCtqUzppX1OEZzwLtgiYd5JUoj5IedQcwFMd0KTItIX0E=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB5524.namprd11.prod.outlook.com (2603:10b6:610:d7::6)
 by SA3PR11MB467332.namprd11.prod.outlook.com (2603:10b6:806:513::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Fri, 13 Nov
 2026 19:09:06 +0000
Received: from CH0PR11MB5524.namprd11.prod.outlook.com
 ([fe80::21eb:d2a4:d1af:5d46]) by CH0PR11MB5524.namprd11.prod.outlook.com
 ([fe80::21eb:d2a4:d1af:5d46%3]) with mapi id 15.21.0615.009; Fri, 13 Nov 2026
 19:09:05 +0000
Message-ID: <3a2a052d-19ab-445c-9073-e49dbe2dd737@intel.com>
Date: Fri, 13 Nov 2026 11:09:04 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/20] drm/ttm: Add ttm_bo_access_locked()
To: Mika Kuoppala <mika.kuoppala@linux.intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: <simona.vetter@ffwll.ch>, <matthew.brost@intel.com>,
 <christian.koenig@amd.com>, <thomas.hellstrom@linux.intel.com>,
 <joonas.lahtinen@linux.intel.com>, <gustavo.sousa@intel.com>,
 <jan.maslak@intel.com>, <dominik.karol.piatkowski@intel.com>,
 <rodrigo.vivi@intel.com>, <andrzej.hajda@intel.com>,
 <matthew.auld@intel.com>, <maciej.patelczyk@intel.com>,
 <michal.wajdeczko@intel.com>, <dri-devel@lists.freedesktop.org>, "Felix
 Kuehling" <Felix.Kuehling@amd.com>, =?UTF-8?Q?Michel_D=C3=A4nzer?=
 <michel.daenzer@amd.com>, Alex Deucher <alexander.deucher@amd.com>
References: <20261109135549.4128280-1-mika.kuoppala@linux.intel.com>
 <20261109135549.4128280-2-mika.kuoppala@linux.intel.com>
Content-Language: en-US
From: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
In-Reply-To: <20261109135549.4128280-2-mika.kuoppala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR04CA0126.namprd04.prod.outlook.com
 (2603:10b6:303:84::11) To CH0PR11MB5524.namprd11.prod.outlook.com
 (2603:10b6:610:d7::6)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB5524:EE_|SA3PR11MB467332:EE_
X-MS-Office365-Filtering-Correlation-Id: 6850ea8a-4704-4c9e-5d29-08df41b99633
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|7416014|376014|366016|1800799024|261009223027099003|11063799006|56012099006|261026121527099003|261021121427099003|4143699003|261021123027099003|261026140227099003|261022105027099003|261028144727099003|261009221227099003|261102130727099003|22082099003|18002099003|261102123227099003|6133799003|10067099003|3023799007;
X-Microsoft-Antispam-Message-Info: pL9rJX2sjA27ZKTLPjLWjef3N/pJlFcpfAml0k/YftqeGmYRaomJCxcXEo1GwXy8qpK/4zA3r8JkoAmOb3A0n9CrsdxGUhERPkjnJEMM6FJdhxNKRhRRHO9VttH1X2BXGSCADMguozJH9BXlbiKZdq/Pxhw11UNFlcNg/K5ZDAWoIvJsGdWZr8l5mZoSt8J4FcXyGMpFrD87A4EDvhk9IHCipcrzzTzJsTBo1Sn1as3HcOLLGxJ1vA/uyEXywRqDyYAaa8shNsWYtf8vN9ysChS2g8h8G4ygXeWcSApdco/WwQjTy/52NkeGBPZZ9EyPcLfad0tLLMmmqRHJS08Wo7zQEINuSrhkPncl9ykNizzp8BKNLNnGTd+DnRkMnKYCoVnM73FsbZIfxmi3bEw25iA3wnAGqg3TEw5ysKls+5Xu3At7j+hUzVNfv7Rn6y/EDg490qkqvRHCkx+8qU7lbDg0Kx2Mp30ZH77F3bfmB0ige6pm74Smd77FQmEzyEQeavXUKOtkyChTAcst7AHtgk7DxIQOqj1E8VLlbY+NJ0Fp82pCXCXFWNKjvo1cf+fNNDW7EYfmckE4UHyJabNfPLd6OYzBUI6+Zd+XnRDmJXH9SyObKsxdidTwvsqSrg/49RGd9X8A7MZ4uRP+4spE/mD82W79s2C1TWZyaTWhaYA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH0PR11MB5524.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(7416014)(376014)(366016)(1800799024)(261009223027099003)(11063799006)(56012099006)(261026121527099003)(261021121427099003)(4143699003)(261021123027099003)(261026140227099003)(261022105027099003)(261028144727099003)(261009221227099003)(261102130727099003)(22082099003)(18002099003)(261102123227099003)(6133799003)(10067099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cktraGpDclJVNWV3M0N1dXYyNVFkU2I1eWRabnVnSzFTQmlTL0dHQXVTMWNt?=
 =?utf-8?B?TnpjbGxJejhNcXRjbmwzUzVYZ1R5RDA2NDA5RlVHK0Q1L1NUWVBiN3ozOUtq?=
 =?utf-8?B?V0xjRmlnMzdYOWR1UkMrVFhyN21yTzZ6RFQ4bEdOYTdyWXl2MDZ0anhBb2c5?=
 =?utf-8?B?UGNGNUtkQ3dlZUVMK0N4cWV5WjhuUStTMVUzU202eVFkakJVbG0rZ1JzUEYw?=
 =?utf-8?B?WU9valpucGdqa0NocC9zR3V0ZEpjWVZtMmEzc2VkOUZMMzdyUmcwVDIrS1Rx?=
 =?utf-8?B?UEN3cU9obFRPY3J6Q0laVGd2ei9jRTQvdmZvcWRrM214NGV5Q1dETllwcVo3?=
 =?utf-8?B?aFNCSEl6anp6NlUyYjhINERHaTgrMWVDbExPWUpiM2FPWEtjR3JkWWw4UXVn?=
 =?utf-8?B?bnV1S3JicGtGV0cwb215c2wyQ0E5VVZlMDNCWTJsZUhHWVkydEI4eFhzZDBi?=
 =?utf-8?B?TElLV2NBRG1mbldyUUVSeGZQdUlDdzlKZ1lPb21wY2pYaks5YzM3d0VWY3pH?=
 =?utf-8?B?aEF5djFGQzlBRzAza0RpVFN1MWZkWHFNa0lsbTJpSUZWOHBKOGFVUC9xSUha?=
 =?utf-8?B?cDdnOGQ3cnZRZGtidExoK3Njb2JkeGkzNkEzaXRCUXFRQ2pqaXMvdzhmeWZk?=
 =?utf-8?B?dzVwUEVFQU1xRzdTenM3cjF4WFhIUFdWMTZ0U1E4VzREenVRZ1Q2L3RKd2o5?=
 =?utf-8?B?RDJaa0xPeTFXRk1Zcmd4ZkJxMVB3QmNXa2k4UDRvTnRhWDNjTkorM01YVlZm?=
 =?utf-8?B?TXora2hMZWxaTlpzK3o5OU1zZGNqa1I5dkZMTDg5WFdxUHVYNlIybFRoTmpv?=
 =?utf-8?B?TXBONWhzSVduR2o2VmorUEVVVFpGNGpteWc5YzZtT1VKNUVYUGhTakRPU1R1?=
 =?utf-8?B?WG42OWRZdXJLbnQrNThuY1ZQdXJUT05kU1RWdnJrSFhwckU4OThSQVhjUmpF?=
 =?utf-8?B?KzY4RWRzVDdZNW9IRCtMVzcyWU8za1JuOEc3U1dYOFpBZlF1dDNDUVB3YS9z?=
 =?utf-8?B?T3lCcEowNmNNS3Y0VVRnZnc1MkY1Y2xnOXZVRXRMUlRYVU9BU1RlNmhQQ2xv?=
 =?utf-8?B?dlNqcHk4SjhSODRLL3FMTVNyZ3g4QnFGQ2xhb2xWMVhBRzNXSDVxODZPeGtT?=
 =?utf-8?B?RXdobVpjVXZqRmFJYzVJNDA5RG0vTVNCUHJBYmt1dldPOW1uWkY0Q1lFMzU2?=
 =?utf-8?B?TFJlV1psbXlvRmVGME5TL3NYQ0lZNmFhZTVpejdPQmVkQWxBQm1nTVg4ZUZi?=
 =?utf-8?B?eFVMYXF6QktJY1lvVDkxZXVVQy9wTGRYNytiMWhwdGErZEdtSHlJR3RiKy80?=
 =?utf-8?B?NUF3NkIzUHpESzNZR3ZmTkxoTTlGQ0NBL0FuUjd0MGV2UzdkNmRnbmRLbEkx?=
 =?utf-8?B?ajRVODJyRHUwWEp5VmJXQUp6ZmJnNzJQWDFGcW9HaktadDJ2M0hGdWJ6N2Jw?=
 =?utf-8?B?QlNZMUYzL1hxdVhwbmg3amdicStISFJNTzNBR1JnSi9JbXR2OTJiaWhoZ0tz?=
 =?utf-8?B?SlVtV1l2MzZFMjNsaCtPbTBpMmE2WllaMG9oUXZ4bnMyUzUzL2J1bm52UWUr?=
 =?utf-8?B?SGFpSjkweTJlU1FmM3ZYYW0wcFlSVnZvZ3d0QlFNMWFJNFZPS2xMVVJaeGZV?=
 =?utf-8?B?NlJhTDVLcFQ1ZmtNQWUvcHAvM0djY1hlelhCd0NTdHFnMU5nTkdZZStmVFBu?=
 =?utf-8?B?TTNpU0lJbEU0V0FuZ0l6NmN1Y0c3TVVqdVpnaFRLZ0t6RUsxWXRmRGVteldn?=
 =?utf-8?B?UXdmNC9PdGZQWm9WaWdodlMyRWV1OW8zYXR6UjM0Q0Q4R2t5U0VJMWNGOExs?=
 =?utf-8?B?QWtOeGpPUWdkZWc4Sk52Y2xtd1daWXA1S1J5Um9aVVJaTHVaNzNvemJnVFAz?=
 =?utf-8?B?SytCRjIwMWdsaG9TQVNEWXlyQTUySEM4SzV1azNuNDhDUzgzd3gzYVI1Q3No?=
 =?utf-8?B?K1VlRC9rRnZmUEQvUXdRWFVXMjFYUTlXMEpZVGVaQVpVczM1MEdiMXpVUWlx?=
 =?utf-8?B?N1A3ekVzajFYaXpPSVVOajBuNmJyR0tqVWxla3AwaytDQ1RaRk9DRHNCWlBy?=
 =?utf-8?B?T0pUQkpyTU12c1BwRjNnTXNkaFpSVjUrMjZLQ1M0ZU9JRDlYYjB6cFlVRDZC?=
 =?utf-8?B?Wjdnb3M5VkpVR1ZBQVRpbC8zRVZrT0JkWktwakxBdjhSWlNjdmJlQ1VJYTBs?=
 =?utf-8?B?djBTNDA0TnBSbVphS0liRGhBZ1JualpCTUJiWWkrUndKSjZiU3JqRENWRE5U?=
 =?utf-8?B?aXBYSEYwSU1Qckx2SmIvRllDTExnTmkzZDNuQ3l3Smp6TFU1L0dkbWdJa2Rm?=
 =?utf-8?B?ejVnejc4SlcwcFZOMyt1U1VBWmpCUExaOWF3TWVyWk9sam9wajQ5OFFOMmJC?=
 =?utf-8?Q?ALClQOMG7rt1ugjU=3D?=
X-Exchange-RoutingPolicyChecked: cHBtWYhZBL0wKcXiCJvZEJ1sR1tuh2D+cx2yWgA+rulqaRJZ65jEC9L3NuS6v7v6kZiIglWxquvyGtPSWE3yjcNp1+SjuVvVxXyJkHNA70w6kfOZfiqLbSgoTsztiSiooP2HQOuY+dVNtVgCm3n0cAIOlGLfSZeTeAmIHsDpIov6zllQvQAdWteaLSEu3noC+HUdViyDnVZH8nOltKDVV7LXCxFCqSLscj7T1YL8nb/mNPiSg2XgWdiuVRlXPCxUTU5Rqsoa+8giYQLWh5ADDGuWxwJi0yDB2NHeEANlytwYCGSn3TgLSIg9kgNiiSvwj/ZkpbDLpDE4pA0mTnhDdw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6850ea8a-4704-4c9e-5d29-08df41b99633
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB5524.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 19:09:05.6460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iZKFm8tWU3WEdmRup52QRA4GBAEP/C+Z+7BWPUJ66o8M56vpunuDVZda+ofM90ms/vLl2z2IEh/cqxNo3cE8IhtCN9vjY3aqROLS5TvDN6M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB467332
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Mika,
the description of the "ttm_bo_access()" API states, "Should not be 
directly exported to user space via a peak/poke interface."

When the newly added "ttm_bo_access_locked()" is used in "eudebug", it 
is ultimately exposed to user space via functions such as "pread" and 
"pwrite". @Mattew Brost,I would like to inquire whether this violates 
the considerations made when the "ttm_bo_access()" API was initially 
designed.


Aside from the above point, the added "ttm_bo_access_locked()" API 
appears to be a simple refactoring, so this patch itself does not seem 
to pose any issues.

Br,
G.G.

On 11/9/26 5:55 AM, Mika Kuoppala wrote:
> ttm_bo_access() reserves the buffer object itself, so a caller that
> already holds the reservation cannot use it. Split the body out as
> ttm_bo_access_locked(), which asserts the reservation is held, and leave
> ttm_bo_access() as reserve, access, unreserve.
> 
> The first user, eudebug vm access, has to wait for the move fences and
> access the object under one reservation.
> 
> Cc: Felix Kuehling <Felix.Kuehling@amd.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Michel Dänzer <michel.daenzer@amd.com>
> Cc: Alex Deucher <alexander.deucher@amd.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Mika Kuoppala <mika.kuoppala@linux.intel.com>
> ---
>   drivers/gpu/drm/ttm/ttm_bo_vm.c | 61 +++++++++++++++++++++++----------
>   include/drm/ttm/ttm_bo.h        |  2 ++
>   2 files changed, 44 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> index 872bf444b1f0..9a252bce9091 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c
> @@ -405,6 +405,47 @@ static int ttm_bo_vm_access_kmap(struct ttm_buffer_object *bo,
>   	return len;
>   }
>   
> +/**
> + * ttm_bo_access_locked - Helper to access a reserved buffer object
> + *
> + * @bo: ttm buffer object, reserved by the caller
> + * @offset: access offset into buffer object
> + * @buf: pointer to caller memory to read into or write from
> + * @len: length of access
> + * @write: write access
> + *
> + * Same as ttm_bo_access(), for a caller that already holds the reservation,
> + * for instance to wait for fences before the access without the placement
> + * changing in between.
> + *
> + * Returns:
> + * @len if successful, negative error code on failure.
> + */
> +int ttm_bo_access_locked(struct ttm_buffer_object *bo, unsigned long offset,
> +			 void *buf, int len, int write)
> +{
> +	dma_resv_assert_held(bo->base.resv);
> +
> +	if (len < 1 || (offset + len) > bo->base.size)
> +		return -EIO;
> +
> +	if (!bo->resource)
> +		return -ENODATA;
> +
> +	switch (bo->resource->mem_type) {
> +	case TTM_PL_SYSTEM:
> +		fallthrough;
> +	case TTM_PL_TT:
> +		return ttm_bo_vm_access_kmap(bo, offset, buf, len, write);
> +	default:
> +		if (bo->bdev->funcs->access_memory)
> +			return bo->bdev->funcs->access_memory
> +				(bo, offset, buf, len, write);
> +		return -EIO;
> +	}
> +}
> +EXPORT_SYMBOL(ttm_bo_access_locked);
> +
>   /**
>    * ttm_bo_access - Helper to access a buffer object
>    *
> @@ -433,26 +474,8 @@ int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
>   	if (ret)
>   		return ret;
>   
> -	if (!bo->resource) {
> -		ret = -ENODATA;
> -		goto unlock;
> -	}
> -
> -	switch (bo->resource->mem_type) {
> -	case TTM_PL_SYSTEM:
> -		fallthrough;
> -	case TTM_PL_TT:
> -		ret = ttm_bo_vm_access_kmap(bo, offset, buf, len, write);
> -		break;
> -	default:
> -		if (bo->bdev->funcs->access_memory)
> -			ret = bo->bdev->funcs->access_memory
> -				(bo, offset, buf, len, write);
> -		else
> -			ret = -EIO;
> -	}
> +	ret = ttm_bo_access_locked(bo, offset, buf, len, write);
>   
> -unlock:
>   	ttm_bo_unreserve(bo);
>   
>   	return ret;
> diff --git a/include/drm/ttm/ttm_bo.h b/include/drm/ttm/ttm_bo.h
> index 32791c4db2a9..3b08baa33ffd 100644
> --- a/include/drm/ttm/ttm_bo.h
> +++ b/include/drm/ttm/ttm_bo.h
> @@ -441,6 +441,8 @@ s64 ttm_bo_evict_cgroup(struct ttm_device *bdev,
>   			struct dmem_cgroup_pool_state *limit_pool,
>   			s64 target_bytes,
>   			struct ttm_operation_ctx *ctx);
> +int ttm_bo_access_locked(struct ttm_buffer_object *bo, unsigned long offset,
> +			 void *buf, int len, int write);
>   int ttm_bo_access(struct ttm_buffer_object *bo, unsigned long offset,
>   		  void *buf, int len, int write);
>   vm_fault_t ttm_bo_vm_reserve(struct ttm_buffer_object *bo,

