Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D67C9606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 05:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ELhRmIfv;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QgX5BVZu
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB2EB10E544;
	Tue, 24 Nov 2026 05:12:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B84C510E198;
 Tue, 24 Nov 2026 05:12:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795497120; x=1827033120;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=MwmwiCYVusv3GePWrNv1Mb8w3CVw/DecvQ4Fyzh07MY=;
 b=ELhRmIfvSaZyLVOeY1fmz59EthjwIYJohrCgilVitKqMLXRZLBF5pZTx
 RZq7YUy1pnfajDqNVB+L4LSqwIkeHFvU6jsTGmYpp+vka3HyyZgQGUXoP
 ROD62TnZkvDG/BiMQauVNpvPU8jXuDIQUrG4uy8f4hmQKdJIUo40VACfH
 /+s7vcJqPRqxuhVWu63x8/9W6EZwSoy5+9hAZvd9DfWFdBtKr4u4WTpqQ
 aeAYC8EoT9BSvxvV8wdYDcwXOjKAp8sAVaYs40qjQFnEVoVMVyl1Hqnv7
 80a/5X2q1Q0FUhybZkFvtipbYwAN9/YkpzOQxR6hHwMixXxlFqXVQSfJ3 g==;
X-CSE-ConnectionGUID: l8npda8xToqTOygSvnGjCQ==
X-CSE-MsgGUID: nAHFL/SPRD2CZjXz9Jruqg==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4209540"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4209540"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 21:12:00 -0800
X-CSE-ConnectionGUID: AFgzKQtJQw+PRpJb1Gx3gA==
X-CSE-MsgGUID: yUcnJjbDQS2xm7Ltf3SGew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11809292"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Nov 2026 21:12:00 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Mon, 23 Nov 2026 21:11:59 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Mon, 23 Nov 2026 21:11:59 -0800
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.30)
 by edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 23 Nov 2026 21:11:58 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pkqYuKf9raN8NmifG/ZHB2Fi1OvfRwO1aRXwAUG6z3VVaWZ+ZYfe/CiuBZbYbdtsZRStoczHH8Hxi/dbUrUnMerDh2qnYm+nU/ndNP506MCa4kzPWCA+M8K13mVfgDF6r5wpaqMmipLDNvaiZtId/vSO4Z3+Cx6/fzslxs6521rW4LmSIIgOilg0aZ64AFLXlkoni5tZIOwQUVwc7fQc3EiENbtwsOpuGPKpYrsNGPHk6TWRSQwOIEGkeLvtaot2+xxplps4/pdj6rhobFTLt8OvbTM/DLkLcaboIYkVNUwSBuFSb0qpsSHiTVIrWk2SHOleN5WgxYsQzxTFyGe73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3nOoNcBBwC54/qvD7Bs9wKIwGTwjHvEW2NYmnCrPx8=;
 b=UtA1QZCoy0GuVNy+SYBvD0h+lEcXU3B7UUTYgGcHyx3+knTpPNSvR7yaq1KCoviuZdP8QU2E2n7fcR4EHyggX+xXGFXiK7f4PiSEnarddOIpKvO2bzZQ21C/1pth2r6soaX6lg99Vwj5HBVRwdLYy4XeGqJn+PQNcZYaq82rGpcHveid8rV3imKAqZSUhTNNIDTdD0B10dDkOhPzfBtSNXS8x1bEJ/66fYvVy49GccfIWBaqHuVTBpWPjKWTLZv+XyIeRagGgIYomhY4E60UevfKZH0HV9lxymO9NCR3Y4+3gHwqqj859J4WCrx7YXdmUiSf8vrNOaYDDFH4FiWIKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N3nOoNcBBwC54/qvD7Bs9wKIwGTwjHvEW2NYmnCrPx8=;
 b=QgX5BVZuCftuOHriGM4d1rV6FeHwbk5P4EXQEZeyRiPj3c0nYza348Y8G8Xvip5eIUuHKKOvPcnKETEMKpbf6uIICiwemyvwkJuksGIDgGPY0AgrGOfjOJOHuten/tYdEX/uGyLC47ZrkggRddsSDSeJSdJbvJGQoMFN9dWSXrY=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11) by DS4PPF691668CDD.namprd11.prod.outlook.com
 (2603:10b6:f:fc02::2a) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Tue, 24 Nov
 2026 05:11:56 +0000
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c]) by LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 05:11:56 +0000
Message-ID: <f7a33e0d-c2b6-4d12-a209-acf8bde7ca71@intel.com>
Date: Tue, 24 Nov 2026 10:41:48 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 13/13] drm/i915/dp: Enable the DP symbol TG, with a
 debugfs knob to disable it
To: "Murthy, Arun R" <arun.r.murthy@intel.com>, Jani Nikula
 <jani.nikula@linux.intel.com>, "intel-gfx@lists.freedesktop.org"
 <intel-gfx@lists.freedesktop.org>, "intel-xe@lists.freedesktop.org"
 <intel-xe@lists.freedesktop.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: "Shankar, Uma" <uma.shankar@intel.com>, "Kandpal, Suraj"
 <suraj.kandpal@intel.com>
References: <20261120-vlk-64036-dp-symbol-tg-v5-0-bf8f78b32709@intel.com>
 <20261120-vlk-64036-dp-symbol-tg-v5-13-bf8f78b32709@intel.com>
 <1c9687d3bb57dd6e68891251c2cb546c9c71aa66@intel.com>
 <SJ0PR11MB503982248EF9BF31173D6D73BA442@SJ0PR11MB5039.namprd11.prod.outlook.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <SJ0PR11MB503982248EF9BF31173D6D73BA442@SJ0PR11MB5039.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0019.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:177::16) To LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR11MB357627:EE_|DS4PPF691668CDD:EE_
X-MS-Office365-Filtering-Correlation-Id: ff75db77-106f-4f1e-2a0b-08df49e97570
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|261022075727099003|10067099003|261009223027099003|4143699003|56012099006|261022105027099003|261021121427099003|261021123027099003|261102123227099003|261026140227099003|261028144727099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: JNLyQNdQNKqJZTcDMoUTdF3jRvWyYMMQBb1nT1SFLW+mjxIfENcYQWhiQHrAPOdmaga3fO0ccotqiSJynEFTPEH7EmU3WT7AewKbFtTCum+BwC/qKb+FTKvwYeswKfS1I+bkHweKdPAGY5NjyGGcLuBGdnc+JjqcPlWTDJrInTByLzcUQaOCpUe86F8yrm/pRrVEmmPTpw/fWHhvBIxySJfFOb9yKK8Uz8Za2IjJkJkjrtGgl59LAZzLu1gQBrh/7lTQdEbJHgPXCNxkqQLVpYT/16Z5IxoHVT9U/alzZAfe52PmhxpWtj6ZAStxeHUbxPbj66rR2pi0aHsfo+yDnfbECYYalguhkrsyaAPV+Q5G+QZwX9UQGja+XbmkGjIAlr/rqIUXNZtAw7NuDXqA3puxoX1LB4eNj0PUrnpvaQVf+tpXUAn1UXHCKELGS2Cp5KiJoHuZ/j4qz0zk/er7sxq4z92SewjzTD1mBfEnBg6xofKp8xoe18Ltt9jF98BF4wa8JbNFAXP8VXQKehfRtGWOXxO6qDqG1CAqDV7bxiSLBu2xcqSm5h1Lf7SGjZQf9huweoDk4+kWpmphZ6IETqjS8jn4onavsqNCSgtXEPz91t1v23dkoRgUaSM9yeJBFvAP2j27zT8+qb+A0k1ytZ2/d/Ud+HpHjcEWWoHoDgY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LY0PR11MB357627.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(261022075727099003)(10067099003)(261009223027099003)(4143699003)(56012099006)(261022105027099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z3Q3S2NRVUJjQU1sdFA5eUtZVUxoeURFWmpEL1FOZFcyd3dpWldZRnJiSUpn?=
 =?utf-8?B?L3dUOUVvU2lXVmRSN2VNMmZFTEFaSVJUL1U2amNQYWoxWGMzbm9TMUJQcTRz?=
 =?utf-8?B?VEc5V3h0UFNzc1VmbnFGc2hzM1FJOHV1cEptOXZvYTZEOFF6TWd3UU9MQURh?=
 =?utf-8?B?dWQvcnJVMVI0NkV5SFVld0QvR25vckhQWWZDTGZrN2Rzd0lWNGtHQW55NFFz?=
 =?utf-8?B?SXZZRE1iL0ZiSEkvVEYzZ05yekFxYytwZXRRSXJscmZLekxKd1JKYVlMZkVk?=
 =?utf-8?B?K1NWNlI3M0t3SExZT0c2dTRQMm9PcTU4TnF3MzVNMWZUN1M3Vk1mNVp2WmN6?=
 =?utf-8?B?WHBiaE00TW1zM1BMMWU1THZySHRhSHpXZFhQbjJMS1kwZjU1WDhBYUNIeTlQ?=
 =?utf-8?B?Y0RHY3lGWFpTanZZcEx4dEgrZWppQXBPdG5HWmNXMkRodTBEeTJxTy9DSkti?=
 =?utf-8?B?UDZCNFVtTGN6bjFyU2x1S2pSV1I0UURXdkJNQ3ljMnJySERwV3hpdCs5ODdI?=
 =?utf-8?B?ZW5aM2JrZTl6VnVpVVdYT092dlV1WlE5a1JpTEVzS0h3SUJJbGJNNWs0UEpD?=
 =?utf-8?B?cDBSdG5ZQktCZHBNT3crYzVRRVpNdFNlOXZhd24wUTNlR3B6cjdrNm5PRk5E?=
 =?utf-8?B?eEF2em9pY20rUU41ZE1NZVRSUFdVUVlXdDV0Mkx0SHp5cWpsSmIyNzNTTlAy?=
 =?utf-8?B?UFlHQzRXelpGMkFtMnJrYWc2bXdNWVg0OUYya0FXSzJhWkVKTlRzVFU0K0N3?=
 =?utf-8?B?OXF0RTlDRWxyVUU2a2JBN21ZTDNwVEJENk81dGZtc2hVY09hbVNTejluc0h4?=
 =?utf-8?B?OHI2UUhwcFNkcGFhR3N3OVlRc0hzL25mTDFZait4VHdmdVgvS1B2aXI3ejh1?=
 =?utf-8?B?MGtYZUN2cGo3K1kwM01CbUN6YUZMcEV2bTk2UnFJcnppQTFFTktwQ2NnUWh1?=
 =?utf-8?B?cy9kcWE1TGtEU0YxcUJtUzBTZU5qWnBHTWE4bWVEclN3U0N2WHd2VGNIWWF6?=
 =?utf-8?B?bndGSm5ET015Z0JCYlMzbm9MLzFCcHBiVzZEcFVvWkppYm9iSVFOUVdGcFFO?=
 =?utf-8?B?VmZsNTJ4WG91ME9UV2YwbU53VjdqdVVRZy9HZjRaS3VzMWdIU1VTb1djV2xS?=
 =?utf-8?B?QmVIeGZqbFJEaUxrVVZrNlh1V3l2VnlWYUlmRmNUMGk1amhtNHpaaEQzTU83?=
 =?utf-8?B?WXdHYXJKdzc4M2xLZE9UWC9YOHFNRnZpbXdzRytYMTR6bWVYSUF5UlhQTEJq?=
 =?utf-8?B?bFZ0ZXRkS3JDRUQ3WEtEemZNWDJYMkh6WDNnVzdKcTEzSW1qQmZKQ2V6czNS?=
 =?utf-8?B?eTFtRS9pNm05ekR5MlpxOFNRZkI4MENQZG9aU1JuMHNwZ0NNMVd5UUZ3d21w?=
 =?utf-8?B?SVZKcDB4VXVCckFkTXNFdnNmY25zMmxCYW9WVk9UcGNNeEZRTlFrc0xNYTRn?=
 =?utf-8?B?MkVQRENRWVlldURpYUMyNVBpOVM4cFVzYzBDU1BmbStjcGovTTRuZTNyTXNn?=
 =?utf-8?B?SHhwQU03VDBFc0tRZENiZWxNNndMTUJldjRxQzVPdzRrT0lsZVB0SzNFVUNV?=
 =?utf-8?B?N3JiallkdmZNMTYzSGpEZ3ZxUzFiL2lCb2M1R2FuVWNPbGxZcVhhdkw5UnZk?=
 =?utf-8?B?aldUMTZ4RjVsVWdOSkZ6TDZjdWZsSUFXRjdISE1taWlFb0RWVWc3YTc2T2R3?=
 =?utf-8?B?ZytaWDh4ZEJraWVEUHlpTE8wN3ZpTE5pTHo2NDRQWk11OEV4Rk1iRjFiT3cr?=
 =?utf-8?B?MDMwdDVCNnhtQ25vWE9lemszN0pSUFJWU0QzQkVyRll0SWIzZDZxZEt3NkZn?=
 =?utf-8?B?ZWd2T09aaFJWZlNIVm91YmkrZE4wRTR4d2pSS213MktLRlc1eXV6ejBFNm9t?=
 =?utf-8?B?TVFkdU94WGtoUlM0dVVRNlBZcnRKZm9ybXpNTUxmczErTnhzMU11TXNFMTdm?=
 =?utf-8?B?TkxSQWdaVldHWlMzcEUzNXlJN2RGcm1MZEVQVGk4U1VLYkNoUkZRK1BjTEhG?=
 =?utf-8?B?aFFWRkpMMGtQSG00ZU5VVi9IWnJJSFEvWHlySmo0S0ZHaUJIOGhHZXMySDQv?=
 =?utf-8?B?OG4vMmJUZGlpa3JQQ2FkRDlrN213bjE5YW9CTHRyQXViNUlwTnZZVmVjRzVB?=
 =?utf-8?B?ejIzK1NDTnQzOFVxcm5HVUdGcHdCNVdjeUMzS1lkOS82alJqOEJ0bGFla09k?=
 =?utf-8?B?dE5VaGdjYWEwUU42elJudTd0aUV3dE9WK2tDMVB2UHY4RlJqeTB0R2RzQnVO?=
 =?utf-8?B?aDlENEpMUGw0U0pyZVU5bEMvckJBWnBIYmRSaUZrbFQzN2NicC9mVW8rblJ1?=
 =?utf-8?B?Z2lhSzI5Mm55c2poNW11RVZDTUxNVnBPSGJ4dk90SG1TR2xBTFY4ZzM2L1kx?=
 =?utf-8?Q?glp8qy1EIg/qVxrE=3D?=
X-Exchange-RoutingPolicyChecked: AVw9dhbeCr0bsW58uDGTOBNUhhAuy3TFactpPM1Gsc+dfADMrQo8x3tdRMJ6JJmhT5Aj5AAE2eBs43Di3WN59x/urLCRFNniM4R6WCE46WsdLQ0adHlzgB/ZtMoy8cjdQtUYpeEQyVYpmL6+eJ1S97Is4NiWPWwTKki8nk4zZ1rpaJv/N17vxshOcYGpXvZrI8A13lFxLCL2eE8kmDulJn8ObPLxOoCm30+ygC2HQPqSd62rmlk7jew4s1FczrZBr7FJbxbWzgitmRRfw/TfzFP/B8cm8bYcN/V+kWrS8B2pN6iRgPKMITadH4LEltWdG6bLqt9VTQ28TM3S1fz/HA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ff75db77-106f-4f1e-2a0b-08df49e97570
X-MS-Exchange-CrossTenant-AuthSource: LY0PR11MB357627.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 05:11:55.9239 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QGcRbbugQzsrZNhBugQlSfH8MZ8Mbh5Jkuppf0XI6lsA1FH4hHbKiIkDksm0ArHn/Y7MwPA4aGqYZJRLKNSYyHpOH4Z7wbEZcvEKcEa5Paw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF691668CDD
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



On 11/24/2026 10:28 AM, Murthy, Arun R wrote:
> 
>> -----Original Message-----
>> From: Jani Nikula <jani.nikula@linux.intel.com>
>> Sent: Friday, November 20, 2026 7:48 PM
>> To: Murthy, Arun R <arun.r.murthy@intel.com>; intel-gfx@lists.freedesktop.org;
>> intel-xe@lists.freedesktop.org; dri-devel@lists.freedesktop.org
>> Cc: Borah, Chaitanya Kumar <chaitanya.kumar.borah@intel.com>; Shankar,
>> Uma <uma.shankar@intel.com>; Kandpal, Suraj <suraj.kandpal@intel.com>;
>> Murthy, Arun R <arun.r.murthy@intel.com>
>> Subject: Re: [PATCH v5 13/13] drm/i915/dp: Enable the DP symbol TG, with a
>> debugfs knob to disable it
>>
>> On Fri, 20 Nov 2026, Arun R Murthy <arun.r.murthy@intel.com> wrote:
>>> Enable symbol TG for 8b/10b MST and 128b/132b SST/MST on the platforms
>>> supporting it.
>>>
>>> Keep a debugfs knob, enable_dp_symbol_tg, to still select the pixel
>>> based timing generator, for the case of a sink having issues with the
>>> symbol based one, or for debugging purpose.
>>>
>>> Signed-off-by: Arun R Murthy <arun.r.murthy@intel.com>
>>> ---
>>>   .../gpu/drm/i915/display/intel_display_params.h    |  6 ++++
>>>   drivers/gpu/drm/i915/display/intel_dp.c            | 32 ++++++++++------------
>>>   2 files changed, 21 insertions(+), 17 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h
>>> b/drivers/gpu/drm/i915/display/intel_display_params.h
>>> index
>>>
>> 5c5a1a1358c32a08a460bdb81da76c3682827ab9..503eef8cf744fbf802bcf86d2
>> 5f5
>>> 81871fcc3f8c 100644
>>> --- a/drivers/gpu/drm/i915/display/intel_display_params.h
>>> +++ b/drivers/gpu/drm/i915/display/intel_display_params.h
>>> @@ -56,6 +56,12 @@ struct drm_printer;
>>>   	 * in intel_display_params.c on purpose. Runtime-toggle via debugfs.
>>>   	 */ \
>>>   	param(bool, enable_periodic_assdp, false, 0600) \
>>> +	/*
>>> +	 * Debugfs-only knob (per-device), to fall back to the pixel based DP
>> timing
>>> +	 * generator, if a sink has issues with the symbol based one. Applies to
>> the
>>> +	 * next modeset or mode validation.
>>> +	 */ \
>>
>> I'm not really convinced about this at all, including the previous one added in
>> commit 9ed39b7d74b4 ("drm/i915/display: Gate periodic AS SDP skip frames
>> behind a debugfs knob").
>>
>> The idea here is that these match 1:1 with module parameters. Everything else
>> probably should get added through the usual debugfs mechanisms.
>>
> Based on the review comment on v4 added the debugfs knob. Based on this 1:1 mapping with module param I feel its better to drop the debugfs knob.
> 

intel_display_params is not the only way to create a debugfs knob. When 
I said a "debugfs knob", I meant a per-device/per-connector debugfs 
file(I haven’t yet looked into which scope would be more appropriate).

Jani, would it make sense to force the 1:1 mapping in code instead of it 
being a convention that people keep breaking?

==
Chaitanya

> Thanks and Regards,
> Arun R Murthy
> --------------------

