Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1B96D3942D
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 14:10:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 478BF10E410;
	Thu,  2 Apr 2026 14:10:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="biFoUWKs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ADCA610E410;
 Thu,  2 Apr 2026 14:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775139004; x=1806675004;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=p2L6l0UwRjniQTBRJPih88nOHmheJpk86rXSjqFXuQM=;
 b=biFoUWKs0374l9DO5bikLGs/cnlwd/u/IP6GptBImtC5bhCVno4op43c
 vzf0cx72XKxeF932F4x0C/QkXcmoUHkxVMUFM+2CwlSkXItGexzOcj6b8
 3iLCw+azByfEzFTTqzcAz+k1DFVmvFbCnTQSrJIBMtuxetswTg+zHQKO8
 X23zQLjyWM/JscnvNyYLTp2kI3tcdXRxfkqkD2/ggJ/7qO6Hxv0Lagyod
 XyADo85atvCf7fD7LJ2zYVgKqnVSh83dfhQdLkEh9ZdPrJiRCvLU52cDq
 jvpGZo4P1N26x3vGNsU5+BYbMAg88fJTYrMHPmLqK/RgVjgNs+64SNyiw g==;
X-CSE-ConnectionGUID: kQYkq2CyQZKrAz4TjoUg1A==
X-CSE-MsgGUID: Rq1VoVymS4G3I4plDgDxxA==
X-IronPort-AV: E=McAfee;i="6800,10657,11746"; a="76213930"
X-IronPort-AV: E=Sophos;i="6.23,155,1770624000"; d="scan'208";a="76213930"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:09:59 -0700
X-CSE-ConnectionGUID: AdOAz3R8SluL6Gt0wb5OFw==
X-CSE-MsgGUID: MF0Cyy4aQYGQXpSc22p6CA==
X-ExtLoop1: 1
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 02 Apr 2026 07:09:58 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 07:09:58 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 2 Apr 2026 07:09:58 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.67) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 2 Apr 2026 07:09:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W9n4tDhLIaLC2ehLc245i27crR5ATckbqP6KobbPVizzcgC1LymhpruMx5Ku007NS4XAr9sxr/PU57r6SufY+pqnwWh7ydPptkKSm5rGsnM8eipYczMrPGrDhNj+Qpu6T3z60D/dLKHF4uT5pO5CAOYAt8mZ5KKQWuOx9PRwJc0h5NbHJwXo3M8y18kRDdgyczc6lVBEADS58b6bUKjfT6QnC2osAfSiKydqpA6GtmIbsEHj+B5Q3d4vI++VbiPxv71HcPP5mxkP7I0pdHuO1yr+ESwiIQhliYg9Mq6fbk8qaC2zapVEtL4dHcbZK3qzaBfokvPzj53JQSHGVl2njA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9QPhtfDqCqVEgL+ylx0G/FBYQhj4vJGFv+HspOqt3zc=;
 b=ED+vEAertH0o1LozUXcxMvO/Uqrutz6U9p+S9cti64hle8vyc2ATbqP5wwsjmb5PZP7+OVtqcXBQwLwZAGn+CSXEXubVXtUA+fjPySyZ5DwMsyJZnxrA3Wq5nVM5D8ir51hRInp3s+0HXEDZr9CR3cSFpnl28b9m53iyAdbqapcdCDc8zIaMFo/zZu0RQtLhBdRFSCg8ZcU/CNC1hpaFqNYrWDSAhfhKnyxP8qTScPCLYuo1MTSAb60Py0XZjiRC2vfnfRyMxZ3OpYuOm1LIZ/Iw7VvBb7mVT7jdAzvVaBy/eD7y0WTz/m2x1/uGvyTVf1YpepV1G1NVmnTpbP+uxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6011.namprd11.prod.outlook.com (2603:10b6:208:372::6)
 by PH0PR11MB5807.namprd11.prod.outlook.com (2603:10b6:510:140::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Thu, 2 Apr
 2026 14:09:50 +0000
Received: from MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811]) by MN0PR11MB6011.namprd11.prod.outlook.com
 ([fe80::3a69:3aa4:9748:6811%3]) with mapi id 15.20.9769.018; Thu, 2 Apr 2026
 14:09:49 +0000
Message-ID: <e0264142-aaf6-45fe-9155-19a8b3b76a6e@intel.com>
Date: Thu, 2 Apr 2026 16:09:42 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v8 1/1] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
To: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>,
 <intel-xe@lists.freedesktop.org>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, =?UTF-8?Q?Piotr_Pi=C3=B3rkowski?=
 <piotr.piorkowski@intel.com>, Matthew Brost <matthew.brost@intel.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
 =?UTF-8?Q?Micha=C5=82_Winiarski?= <michal.winiarski@intel.com>, "Dunajski
 Bartosz" <bartosz.dunajski@intel.com>, Ashutosh Dixit
 <ashutosh.dixit@intel.com>, <dri-devel@lists.freedesktop.org>
References: <20260402131912.634248-3-satyanarayana.k.v.p@intel.com>
 <20260402131912.634248-4-satyanarayana.k.v.p@intel.com>
Content-Language: en-US
From: Michal Wajdeczko <michal.wajdeczko@intel.com>
In-Reply-To: <20260402131912.634248-4-satyanarayana.k.v.p@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: VI1PR09CA0184.eurprd09.prod.outlook.com
 (2603:10a6:800:120::38) To MN0PR11MB6011.namprd11.prod.outlook.com
 (2603:10b6:208:372::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6011:EE_|PH0PR11MB5807:EE_
X-MS-Office365-Filtering-Correlation-Id: ddc8613b-c73d-4ab2-ab1f-08de90c180b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|22082099003|18002099003|56012099003; 
X-Microsoft-Antispam-Message-Info: oboHDAgYzt1KK7x/Ueo5HuzOW1VKGRQoL4VstCu3lDbSNwsSbOtwaW0kdZfI6L4v1CBXY3sjJ66pcOixOuGr2GiqhiBKObcFrpbFEEsG9qokChsgXMw7Af/huiL0oK+j5mv/E4Zn35Q9n3LWuuv0xE1fFH3nxs7GxLzbtBgkCV+QYvCJd3Bt59M8q6ri8Nuv9MGldDTfXCbz1851AHq4lPWOzGYTUTyYdYFP8uX8k49LYzihbJmD6SPXnXhF8xVgp19dLt5SctqJ0TJg4BvwEhrqUtzLHU2xF8tQVTPQ07vUt2qWUmzPF1E4jhzzm32tMAuGAMotDYiVgh+74z/JcQfNnaOLUikIGDqsGWThgqOzVMSHE6eZJ9DZEiay9T8kH6AzCtf+CG4N0uiiETRObPB/z0tcWbAux6W0BdZhJn8kWkGDL0fT1YbF5mbqonx6b5D0JxftTfR6bOdzL3Iej4Wj/mr1AvPKYNtfd3GOOhD0w5wRLp/BL5S/ao9/jd7fisN/6+vDwyl/T31IMV4VrqqvqdNR48B8CeoaLY7B3b2winhVD3FCrRgV3hLtWE0vuZTMiBXdu57PXPg4FJkZrXT0/ktfaJUXxFu948scW3E5lu//tDOA0ZT0Qkim81IS2ykh+oyCQQ30iC0Amkv6KPlazq6ZktrTk5RQsNQYVv421uBwuVJw2umbM3ZowPnPtO8IDJ8QF5GIc6GoCQTrCQtxHXaoY3f1KLtQDZ/cuWM=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6011.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmQ5TDF0OFRkSU5aQUU1OFcxQkJqVXZXSDZaa1hRZmxtVXRoNnQ0MGtRbGVV?=
 =?utf-8?B?MHNBM3hJTW40bTd2aEdNQXJxYVdqcTVDYjYvWjU0L00wNlpnakZmT2pTMlhw?=
 =?utf-8?B?ZUR5RGVNbVI3djlsbytjalI5ZktXNTNLMUFhWW0ra2k1Tlk4eUtsalZ4c29I?=
 =?utf-8?B?UUIrYnZTTldEVlVVaEYySnVHMU5tZEp1bzFmM1NyS2dkL2wzMEdreGdRTTdL?=
 =?utf-8?B?WURtN0tyaUJuZXRUby9UUGk3YURPSUJpQ0xuRVh3cVNybmhtc05qQWZ2c2lI?=
 =?utf-8?B?ZzVFNVhqZm42UFhIYUVNaHJjL3QrSjFweC9NOXM4ejhCVUViU0pUVTBrMmsr?=
 =?utf-8?B?TXBGS0tkTTI1N0FrQ3lhR253Y2gyK0MvM2tVaFNWSEE2REVvWm54QWtheW9m?=
 =?utf-8?B?cGpsMksxNU45ZnJmTExsNEsra2UvT1BMT1JYaDhQdHd6NDU3RUpDOVpJdTFR?=
 =?utf-8?B?VmpoRDBWWDRGZEthZXczRmRnVUpWem82a2JxZGloS2RuU0RqODUyaHQ4Wmw1?=
 =?utf-8?B?bFhOZjFyNE1mNE1KOTZXYVpxRWlKaVpQR3ZvZ083VzYwLy83QUVRdVBXdWJS?=
 =?utf-8?B?N3ZSZnF2Qjk3Wm9pTHBDdU5sUEpCOFFCTWh6TkF2TFhWNG91SkMrbjVRM1BK?=
 =?utf-8?B?OUxoMFJ3QXFqWGZFMStWLzFRcVVJUXNIVGN0M1gzZ09FaGt5bWRaOHFmYkY0?=
 =?utf-8?B?ZkxEcUJUSk8zOElxcTNIRnVhNjFOcVQ0eEVaWmFKVkw5ck00ZndpRTQvK3Rk?=
 =?utf-8?B?OVhjKytsUnpHTmV0NFZ4S1BvMk53b0orWUVRYjBFRTBhWDhROFVJUFFVZTRI?=
 =?utf-8?B?Rksyd1lIZlY5YWxxdTZpZXNmWWlmM2hBbFRRWGRGL0oxdUFMeVpPS2xxSHo3?=
 =?utf-8?B?TGhMS0FJOTJJZmxLdy9vVkhLYUdvR29XVVgxaHNuZThNWXNHNHl5RVkzN01a?=
 =?utf-8?B?UjNJaVBWczlYNW5BRzAwVDRYN2RsWFFkUkFneWJnemNJWjJtZzlnUzliZGpM?=
 =?utf-8?B?Ui9ycWI3Z2lNNVI1aWc0UGNDYXFmUENxYW5ncGQvd0VDTnZDb3J6WCs3Z05M?=
 =?utf-8?B?OGdDeW15eThVUjZsZFd5ekkwcjFxV1RhcHIvNEtJMythaURiaHp3UWpudFFu?=
 =?utf-8?B?MG40VFhNcEtwVktXQUZlQXFNMEIxWXRIRng5UkV0Y051U1krZUxNc2hmQ3pp?=
 =?utf-8?B?RTFoWE51WlA5RVE5OGJ1NEJYOFVzcjIreXZvcjFKUC9SWEJSSkdZUVpxVGlJ?=
 =?utf-8?B?TFZEV29UbVpnUUw2dTYvOVBUV0NTMGdoSEx1MlhBZS8yRVlRbzRZZE5qYk5R?=
 =?utf-8?B?NHlhQVl6MTNpMEUrcjFONGI3d3Q2a3NWWDhDUjNUMnFXeEZoVDcvaHBCdmhz?=
 =?utf-8?B?b2dxd1Z4NkpaM3FaTndtVXJBV1VoczRkYldGTlBCTHd0cFQ5dUxkMng4a1pl?=
 =?utf-8?B?aDdnYnJKS0VEckFWSXFRZ3QyTmF5S0Y3TmYxZ1JnV09OTlByb1g5bGczZVhQ?=
 =?utf-8?B?TVJCL3R0b3l6dVEvbWRhdFVOQUNSUFBycjM2NURkS2F1SUVONzh1ZEV6OU1X?=
 =?utf-8?B?RFF2L0YyZlA3MmRwR2VqL1pTeHFaZTJGbkZKKy9xQnMxaHZnV1loekhVdXYv?=
 =?utf-8?B?YTZGdFpITENqdmUrS00wWHZYbmsvR2hXeXg0QVR5NGNRMUFQOTRyNnRmbEZs?=
 =?utf-8?B?eTZ4RlV5QXlrWGJYVkVwaGF1dXlPbXRKNW5UeWhIRzJjK2QvTWtvUEQ4SVMz?=
 =?utf-8?B?Z3Z4VDl5R3F1a3pKc2dzTVluektKVloxOG9IdG5qYnRwZjZObk9vUkNma1NK?=
 =?utf-8?B?WmVkaUw3V0tKSXZpNWpSakZVdy9seEc5NjhvdHlCQVl4eTM0TzNWMWpyZzJE?=
 =?utf-8?B?TWVUUXErSEM4NUtYTzk2WXhoYis2ZElnY0E5TDZsVytxenNkcktmUGUxZHZy?=
 =?utf-8?B?ZVdFTzdOTTF1dDJSUFNjYWh3RHFxdUduQXJwNUdVOFlwSy9VZVFkWjA5SkVH?=
 =?utf-8?B?c3QvbkQyRGpIcDdmRS8wTEUwcWJkbWVXMm1jUG1tRXlnZ1FGTmJOSXFtdUNv?=
 =?utf-8?B?ekVCQTFGK0ozRVRkRktWMnlxTGVuckVVTUVPbEhEQmJVckxSalFkekhDT2tx?=
 =?utf-8?B?YTFFR1BUZWZ5ZElNVlB5N0dLTW1uTXY1aklaUXh0RmRlTE4vem41UTFESHhQ?=
 =?utf-8?B?OHlmaGNkUzJJN0dtSUZaYjYveU84ckFZS2tybHJiakRSOXdQemNoZm9WWGZ0?=
 =?utf-8?B?TDRibUNiM1orZVRHN3V4UnFiRGc4bVp2UWx3bU1rcytnd0NoQTJoRWNRQ3ph?=
 =?utf-8?B?MjdETk1JaHFSREpVcVFhUWZ5cThXWFk4aVpWMWJJMy93V0VqK1hTaUF4UUt3?=
 =?utf-8?Q?AWGkTVFjRH369oZA=3D?=
X-Exchange-RoutingPolicyChecked: davBmB1QDFE//clgLTATQ6iY3LG5ZOcSBspQy/+ov79xV01GiDz7w/ESX5kUELjTCLTLRMLAI2lfKGIhTK/SbHN75IsWU067zE+pKA2DvaunXoKuReRNdXmKJQvXRlf8R4C23QrHBXw5pV1QpfXwAZjkxxpYkon+ZP2klVY3ckvwVIPT6pG9QY3cV+sjKYjqIpGT4Tax24xHYFLtOSJ6tC+HcrIXEzYmz8Z4SQbicq6Qn5jZxtV2aPV7awP7y9AbFJuKFCGKU1XszbfZnHJXhGoWBgmEUcFRWC13Z7klifjpFBY5leotKwlP15Q6QqpnubrFl4cNfIeJTpDicT5kMA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc8613b-c73d-4ab2-ab1f-08de90c180b1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6011.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 14:09:49.7604 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mMV2xfb4fbt2ujssQn4yIfM2KydC4XpZ0vNM9gwAxinIf7JZEk42xwNqHNr/jEmM8UKW1gdqgKODjDjpDRSmeDyII+PfoAPy99Vn904fPt4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5807
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



On 4/2/2026 3:19 PM, Satyanarayana K V P wrote:
> When a PF is configured in admin-only mode, it is intended for management
> only and must not expose workload-facing capabilities to userspace.
> 
> Limit the exposed ioctl set in admin-only PF mode to XE_DEVICE_QUERY and
> XE_OBSERVATION, and suppress capability-bearing query payloads so that
> the userspace cannot discover execution-related device details in this
> mode.
> 
> Enable admin-only mode with:
> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/unbind
> sudo mkdir /sys/kernel/config/xe/<B:D:F>
> echo yes | sudo tee /sys/kernel/config/xe/<B:D:F>/sriov/admin_only_pf
> echo <B:D:F> | sudo tee /sys/bus/pci/drivers/xe/bind
> 
> Signed-off-by: Satyanarayana K V P <satyanarayana.k.v.p@intel.com>
> Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Piotr Piórkowski <piotr.piorkowski@intel.com>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Michał Winiarski <michal.winiarski@intel.com>
> Cc: Dunajski Bartosz <bartosz.dunajski@intel.com>
> Cc: Ashutosh Dixit <ashutosh.dixit@intel.com>
> Cc: dri-devel@lists.freedesktop.org
> Acked-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Acked-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
> 
> ---
> V7 -> V8:
> - Fixed issues reported by CI.Hooks
> - Updated commit message (Ashutosh)
> - Removed gem_prime_import from admin_only_driver structure (Michal)
> 
> V6 -> V7:
> - Allowed xe_observation_ioctl as well with admin-only PF (Ashutosh,
> Michal).
> - Updated commit message with steps to enable admin-only mode (Rodrigo).
> 
> V5 -> V6:
> - Updated commit message.
> - Return number of engines and memory regions as zero instead of
> returning query size as zero (Michal Wajdeczko).
> - Allow all other query IOCTLs excepts query_engines and
> query_mem_regions (Michal Wajdeczko).
> 
> V4 -> V5:
> - Updated commit message (Matt B).
> - Introduced new driver_admin_only_pf structure (Michal Wajdeczko).
> - Updated all query configs (Michal Wajdeczko).
> - Renamed xe_device_is_admin_only() to xe_device_is_admin_only_pf()
> - Fixed other review comments (Michal Wajdeczko).
> 
> V3 -> V4:
> - Suppressed device capabilities in admin-only PF mode. (Wajdeczko)
> 
> V2 -> V3:
> - Introduced new helper function xe_debugfs_create_files() to create
> debugfs entries based on admin_only_pf mode or normal mode.
> 
> V1 -> V2:
> - Rebased to latest drm-tip.
> - Update update_minor_dev() to debugfs_minor_dev().
> ---
>  drivers/gpu/drm/xe/xe_device.c    | 60 ++++++++++++++++++++++++++++---
>  drivers/gpu/drm/xe/xe_device.h    |  1 +
>  drivers/gpu/drm/xe/xe_hw_engine.c |  3 ++
>  drivers/gpu/drm/xe/xe_query.c     | 10 +++++-
>  4 files changed, 69 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> index cbce1d0ffe48..eba2fa6dc7d3 100644
> --- a/drivers/gpu/drm/xe/xe_device.c
> +++ b/drivers/gpu/drm/xe/xe_device.c
> @@ -25,6 +25,7 @@
>  #include "regs/xe_regs.h"
>  #include "xe_bo.h"
>  #include "xe_bo_evict.h"
> +#include "xe_configfs.h"
>  #include "xe_debugfs.h"
>  #include "xe_defaults.h"
>  #include "xe_devcoredump.h"
> @@ -216,6 +217,11 @@ static const struct drm_ioctl_desc xe_ioctls[] = {
>  			  DRM_RENDER_ALLOW),
>  };
>  
> +static const struct drm_ioctl_desc xe_ioctls_admin_only[] = {
> +	DRM_IOCTL_DEF_DRV(XE_DEVICE_QUERY, xe_query_ioctl, DRM_RENDER_ALLOW),
> +	DRM_IOCTL_DEF_DRV(XE_OBSERVATION, xe_observation_ioctl, DRM_RENDER_ALLOW),
> +};
> +
>  static long xe_drm_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
>  {
>  	struct drm_file *file_priv = file->private_data;
> @@ -390,7 +396,7 @@ bool xe_is_xe_file(const struct file *file)
>  	return file->f_op == &xe_driver_fops;
>  }
>  
> -static struct drm_driver driver = {
> +static struct drm_driver regular_driver = {
>  	.driver_features =
>  	    DRIVER_GEM |
>  	    DRIVER_RENDER | DRIVER_SYNCOBJ |
> @@ -415,6 +421,38 @@ static struct drm_driver driver = {
>  	.patchlevel = DRIVER_PATCHLEVEL,
>  };
>  
> +static struct drm_driver admin_only_driver = {
> +	.driver_features =
> +	    DRIVER_GEM | DRIVER_RENDER | DRIVER_GEM_GPUVA,
> +	.open = xe_file_open,
> +	.postclose = xe_file_close,
> +
> +	.dumb_create = xe_bo_dumb_create,
> +	.dumb_map_offset = drm_gem_ttm_dumb_map_offset,
> +#ifdef CONFIG_PROC_FS
> +	.show_fdinfo = xe_drm_client_fdinfo,

do we want to expose memory or engines details here?

> +#endif
> +	.ioctls = xe_ioctls_admin_only,
> +	.num_ioctls = ARRAY_SIZE(xe_ioctls_admin_only),
> +	.fops = &xe_driver_fops,
> +	.name = DRIVER_NAME,
> +	.desc = DRIVER_DESC,
> +	.major = DRIVER_MAJOR,
> +	.minor = DRIVER_MINOR,
> +	.patchlevel = DRIVER_PATCHLEVEL,
> +};
> +
> +/**
> + * xe_device_is_admin_only() - Check whether device is admin only or not.
> + * @xe: the &xe_device to check
> + *
> + * Return: true if the device is admin only, false otherwise.
> + */
> +bool xe_device_is_admin_only(const struct xe_device *xe)
> +{
> +	return xe->drm.driver == &admin_only_driver;
> +}

I'm still looking for patch #2 which would update xe_sriov_pf_admin_only()

> +
>  static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  {
>  	struct xe_device *xe = to_xe_device(dev);
> @@ -439,16 +477,25 @@ static void xe_device_destroy(struct drm_device *dev, void *dummy)
>  struct xe_device *xe_device_create(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent)
>  {
> +	struct drm_driver *driver = &regular_driver;
>  	struct xe_device *xe;
>  	int err;
>  
> -	xe_display_driver_set_hooks(&driver);
> +#ifdef CONFIG_PCI_IOV

maybe use if (IS_ENABLED()) to avoid complains about unused static in PCI_IOV=n ?

> +	/*
> +	 * Since XE device is not initialized yet, read from configfs
> +	 * directly to decide whether we are in admin-only PF mode or not.
> +	 */
> +	if (xe_configfs_admin_only_pf(pdev))
> +		driver = &admin_only_driver;
> +#endif

nit: add empty line here

> +	xe_display_driver_set_hooks(driver);
>  
> -	err = aperture_remove_conflicting_pci_devices(pdev, driver.name);
> +	err = aperture_remove_conflicting_pci_devices(pdev, driver->name);
>  	if (err)
>  		return ERR_PTR(err);
>  
> -	xe = devm_drm_dev_alloc(&pdev->dev, &driver, struct xe_device, drm);
> +	xe = devm_drm_dev_alloc(&pdev->dev, driver, struct xe_device, drm);
>  	if (IS_ERR(xe))
>  		return xe;
>  
> @@ -708,6 +755,11 @@ int xe_device_probe_early(struct xe_device *xe)
>  
>  	xe_sriov_probe_early(xe);
>  
> +	if (xe_device_is_admin_only(xe) && !IS_SRIOV_PF(xe)) {
> +		xe_err(xe, "Can't run Admin-only mode without SR-IOV PF mode!\n");
> +		return -ENODEV;
> +	}
> +
>  	if (IS_SRIOV_VF(xe))
>  		vf_update_device_info(xe);
>  
> diff --git a/drivers/gpu/drm/xe/xe_device.h b/drivers/gpu/drm/xe/xe_device.h
> index e4b9de8d8e95..c220f2f1352f 100644
> --- a/drivers/gpu/drm/xe/xe_device.h
> +++ b/drivers/gpu/drm/xe/xe_device.h
> @@ -43,6 +43,7 @@ static inline struct xe_device *ttm_to_xe_device(struct ttm_device *ttm)
>  	return container_of(ttm, struct xe_device, ttm);
>  }
>  
> +bool xe_device_is_admin_only(const struct xe_device *xe);
>  struct xe_device *xe_device_create(struct pci_dev *pdev,
>  				   const struct pci_device_id *ent);
>  int xe_device_probe_early(struct xe_device *xe);
> diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
> index 337baf0a6e87..2c324acb1dd0 100644
> --- a/drivers/gpu/drm/xe/xe_hw_engine.c
> +++ b/drivers/gpu/drm/xe/xe_hw_engine.c
> @@ -1027,6 +1027,9 @@ bool xe_hw_engine_is_reserved(struct xe_hw_engine *hwe)
>  	struct xe_gt *gt = hwe->gt;
>  	struct xe_device *xe = gt_to_xe(gt);
>  
> +	if (xe_device_is_admin_only(xe))
> +		return true;
> +
>  	if (hwe->class == XE_ENGINE_CLASS_OTHER)
>  		return true;
>  
> diff --git a/drivers/gpu/drm/xe/xe_query.c b/drivers/gpu/drm/xe/xe_query.c
> index d84d6a422c45..b10a281c6ae0 100644
> --- a/drivers/gpu/drm/xe/xe_query.c
> +++ b/drivers/gpu/drm/xe/xe_query.c
> @@ -231,10 +231,13 @@ static size_t calc_mem_regions_size(struct xe_device *xe)
>  	u32 num_managers = 1;
>  	int i;
>  
> +	if (xe_device_is_admin_only(xe))
> +		goto out;

or maybe just:
		return sizeof(drm_xe_query_mem_regions);

> +
>  	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i)
>  		if (ttm_manager_type(&xe->ttm, i))
>  			num_managers++;
> -
> +out:
>  	return offsetof(struct drm_xe_query_mem_regions, mem_regions[num_managers]);
>  }
>  
> @@ -273,6 +276,8 @@ static int query_mem_regions(struct xe_device *xe,
>  	mem_regions->num_mem_regions = 1;

IMO we shouldn't attempt to fill region0 here, and then memset it
but just jump to ...

>  
>  	for (i = XE_PL_VRAM0; i <= XE_PL_VRAM1; ++i) {
> +		if (xe_device_is_admin_only(xe))
> +			break;
>  		man = ttm_manager_type(&xe->ttm, i);
>  		if (man) {
>  			mem_regions->mem_regions[mem_regions->num_mem_regions].mem_class =
> @@ -297,6 +302,9 @@ static int query_mem_regions(struct xe_device *xe,
>  		}
>  	}
>  
> +	if (xe_device_is_admin_only(xe))
> +		memset(mem_regions, 0, size);
> +

... here

>  	if (!copy_to_user(query_ptr, mem_regions, size))
>  		ret = 0;
>  	else

