Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45336EF4ED4
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 12:49:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DD9C10E14E;
	Mon,  6 Apr 2026 12:49:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S3eL572b";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D7E110E14E;
 Mon,  6 Apr 2026 12:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775479795; x=1807015795;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=QSokSTe9XTPFmepwm7bapKPxy0+lz1H3OfSvU65jTko=;
 b=S3eL572b2kv5TN/TKnGR09H66Hs8/Emy3FBM/LwW+t9kiurqNZZBfOr5
 5WOBqGCFwj4kY10zeYPwmxNu+FhH1W1awzTUN8m8qf0n97M7Ps0k2fhMs
 HP2ag7P93Aiunvp8lGeiXJKJoftpXXgF+T/ltG1ECid0zx6Ya3gFzbCOt
 jGBI8vIofao+DWClKOfnWy25Hxhj9KzoZaER0FGDWfbsr5JZdXl/yX77l
 yYv8RKezG6/HVzqzSW32Kmqa/6rdjdDG5dWK/oz2x2YYJDtv3AcIFERka
 YBgojUL8fn6lX3sXRzF/aua38UEf8ewrKOR3g8i6u5Kp6ALApLAs+tuQj A==;
X-CSE-ConnectionGUID: pT4MG4kUSgqZ3dZFXWH12g==
X-CSE-MsgGUID: +F06QQAhQBuFsjQVWE2omw==
X-IronPort-AV: E=McAfee;i="6800,10657,11750"; a="75466648"
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="75466648"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 05:49:55 -0700
X-CSE-ConnectionGUID: 2OjhXymqRJyGgQaCCi802g==
X-CSE-MsgGUID: Q7KWbdTzQHOSZXELbadIbQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,163,1770624000"; d="scan'208";a="251153205"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 05:49:55 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 05:49:53 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 05:49:53 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.48) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 05:49:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IxpWEtfH20N4FpZJPpP0TqK0SR4FkfpELvtMD0822+bULmIQqgUVd/6OV384r1mpJ03lyptE2qxiv4XOEbH2HDN+1PbXB/0S8PeuqfxbGMgGxv/1h5JBtyYJ160h/3Jr03pvI4z73eRbJ2eCY3Kmt5i9qc90Kpv0MWvL3hgMuNfTdUDiqnUd7wKTAdEfA6kRHvyrDsBKQWKe64EeywGMBkn2a9cvSEAlk3z7SPK5bKcNbMHo3Kq/q/YVLkvyJfg1qh1xWgMXPaz+6tS63E8lrZRwbj3bkY5+QOzUPhrIcOCsAQHRRyO7+N50f9Nl1sBZiF2YH0K2BbW/IXpicO40Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L6JfSHwXdSmY/nF45o/uwUaX7Wu9575uk+elbMFyFnw=;
 b=i/EsOvtGW2B7P8HFFOsREXh74HZEn+5Y3n74hpJPEnG0DnqbJp0FsijtC0eoMBmDqZ3C2ttVLaNL5gF3UcsiENFKWU8sgg1/AiWVQBWAGKl8E8irjfMHnWhOjPb4p5OraZsctCP6+TlOusgDzHH0mWZ27rXkcbEXG+cGtFQXht4IqmgXwRmbmUpObKEy+z4Q7ojFFoxJKh7+Bw1jTxltunqzNHphvWpHMVoPvkOg0ohDQioDaD3zHqUwKPPl3LDAyc/hRX6r5xPFwU+tPZ1GPWmV1pOEbbUFCXKYHne0x05QsLwcA7LSmg/XpebdbKo50EAXLHoRB4U8ZnhEwHHTmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by SJ5PPF6806D69E4.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::831) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Mon, 6 Apr
 2026 12:49:50 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.20.9769.018; Mon, 6 Apr 2026
 12:49:50 +0000
Message-ID: <0816c0c7-454e-4ba8-8197-2ac9601d157b@intel.com>
Date: Mon, 6 Apr 2026 18:19:41 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/5] drm/xe/debugfs: Add interface to trigger power
 management unit error handler
To: Raag Jadav <raag.jadav@intel.com>
CC: "Tauro, Riana" <riana.tauro@intel.com>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>,
 <karthik.poosa@intel.com>, <sk.anirban@intel.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>
References: <20260318064016.374656-7-mallesh.koujalagi@intel.com>
 <20260318064016.374656-12-mallesh.koujalagi@intel.com>
 <ab3e5dcf-d259-4a29-a70b-071bcdd24ec2@intel.com>
 <227a4bce-b3dd-4633-a2ae-8dceb82a6653@intel.com>
 <ac4pTtjVZ7nxEsag@black.igk.intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <ac4pTtjVZ7nxEsag@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5PR01CA0103.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1d1::7) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|SJ5PPF6806D69E4:EE_
X-MS-Office365-Filtering-Correlation-Id: 46a41f75-a4eb-4442-561d-08de93dafddd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|56012099003|22082099003|18002099003; 
X-Microsoft-Antispam-Message-Info: uPmCwaGvaJptBCzEIdiZTU5LHWfrbIwkE9+gW8ygPqW1pg2tuskJH0l/3JrRbUmQvX5BL06g62t6mhFh74N3LRQFm47j0fpdiRh2B2u3WoL0kZp1uDLcNANHPxRSIvb9UNBx7SMNb51f/O9ULXUrEMr1R6fzpv7XvRlRAXmL5lAGL5IeQSg22c/Ghno2jwATxNpFSgiyJcWpFy7h9YrsdZ4dS5XzATFKXWLhpyGfCtwdc5OkYMG1LpOVNwem/TQly6RBfGWmE5HOm4Fgj/90/Mya/XwHwlMcPJ1GGTFnHaUhofye58sU/qCcQdxK2yKJWhufWcN6y4PFsPA6XUE/Dwl/T36vQvPyNX90Xno3J8l96Qa3B/pY53hC31yyMuMMoNNp3D6VsXuapdYt9d9YG9lfr2L9iCYR4r+aS57d5PsUxnDpLhSiP9yEHzTelo1IwTYFOk8jgaWkzPv0rW8pWLNJ9X4qfonbZG+Xmdcwub66fmzHzC+aumRB+MOxQvSZKB6sengdZkjdOXUIGQDT3Os7udGbdePnz1wraxP1a5coczwQThYgDEHcdQbmOuSW2BiP6muAMaPjFB8mn/QvkqZGV/4hkEGG04k/0a7Yio677YolgzHGwy6NuOb4dBuTUzDVqH223CzGGfuKAx9UB878nPuW88pOzeIVVwA4a3hDvJ6CxFok+XrW4vCwPNjkGXCufZ9fuAvDtUxmhPC5jLTN5Km5vfawP5JnpTAT1Q0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eS83SlVMREJuWHNmejJrV1E2MklTQlYrY0FkU1ByMTZhdEwrS0NRR29jTGdj?=
 =?utf-8?B?ZUZZSW1GcUNHVVgxdkdlN3NuUzlzQnBsdWIyVGFyQTJlUlpZK0RJbTBEYWNM?=
 =?utf-8?B?Uzl1UVoyYk5yM0xBUER0YnJZd1VYaG9YaXYxaTg2a0ZEV3JleWY4ODdrVWdo?=
 =?utf-8?B?dkJ6RzFveXAySHZDZHBraWhPTjY3YVBLZjR2OGY0QVhKVEtjRzdCUTV4QnB1?=
 =?utf-8?B?M0ZXU3d0NFhnOCtzYk93TTRyektXcnYrR1c4Y1ZKazdOcktpQWF2SWNvQXZR?=
 =?utf-8?B?Y0d4SWQxUksvWHRSdDlxQXI3WXZpNmt0RnR1TEZ1cXY4dDFVTk40UGZVVmhs?=
 =?utf-8?B?UEsxZlQ3OGZlVFoyRVorZzdQTE9mUk1LazZOVmwyVExNeThXcmdXZ2JEL2FC?=
 =?utf-8?B?aU9zKzlyT0s1K0xySzBIZExrVndPdHRmSy9TR09QSmFCOFdCMXVFcHhFM3BT?=
 =?utf-8?B?TFhiZ2dzNHpnejYzeUQvbFIwd2k2QlFSM2o4dy9NaVhmdXNWQTh6SmV3NElU?=
 =?utf-8?B?R0M2RzM1UWFYOHRDV00wTzJLdzZ0YUhJdm5Kcy9Lc1IyTkR4bFZsSlF2dmxm?=
 =?utf-8?B?Y2txMWswL0xqdXVLYVJ1ZDV2Snozc3lnNzNLRTVxcEdkaDhhSXYySUMvVFZr?=
 =?utf-8?B?MmFjQUZLVWZQUStaYjMwS0IrZngwM0J0SXRCWXl4RWluYXFZUFAzTHY1a3Bs?=
 =?utf-8?B?SzlCVE5PZGV2TDdNQWF2QWdaMVlGQWw3ZGc1VzlyQjlrbFQ2dThOZ1dHVy9v?=
 =?utf-8?B?QXNTVEdNcm9VVzI1bEUrOWxGb3pTNDNISFQ4K0Q3S24rdC82dWMycU84dEow?=
 =?utf-8?B?dUlOMit6WVlLemVaVlEvdGdqWlBKcTdiYVNodUpud1pyU3VwNWp0am9YZktZ?=
 =?utf-8?B?L1M0Rmd1NWk0MEtCMGs3VlZ0bGtRZUwxTjV3My84SWFDN1EwZ3o5SnEvdFpI?=
 =?utf-8?B?anVoV25UeVg1R3F5eWluckpJd24rTVprdlVtekd6SzRBVURkdGlmN3ZIM1Z1?=
 =?utf-8?B?bTR2ZmlHV1dkRCtCckNoYTNEL2NhVlVxRzloZXVVNkJXay9TNnRLaHR6ODBU?=
 =?utf-8?B?T1Zndit1K0J5MHB6RnR3bDlBT1FVOWNDRGEvbE0rWXVzMDlHR2tYMElGWjRM?=
 =?utf-8?B?bDVVYjFlOFc0S2RqK2hDUEpsamw1WEVldW1UdFVYOWRYOFVSbFg4UTRRUUU5?=
 =?utf-8?B?WVQ5OVJmTjAzdUpKM2c0Z1M2T2toN3lxL3VFejREKzMva2kyVnpUOEFVRjg1?=
 =?utf-8?B?MjJSWjBVZWtienMrUTdIMlhjUHlBRWpsQ2V3QkFyM1E5T2xOVnN2L0lHN2dl?=
 =?utf-8?B?ZDlzYmFkUk9MMlhSODI5dG9xa0NwUCtNM0hUQnJjM3hFNFFYYzZhNkdxcDhD?=
 =?utf-8?B?M1pyOHFCN2llNmxYVkJwY3JkYVBKQ2g5aGc1QUZYTkZDcGdkaVNxVEZLeUdV?=
 =?utf-8?B?ZDJ1N09DUGJCNUprd1I2RmlPc3V0RmlQMWRSd2wwNURQdlJCbStwR3kveWl3?=
 =?utf-8?B?UUY4U0RheXFPNzUxRHZiZDdDYlpnM3VhRW1tdzRmcm5Sd2tVc2JYd0hMWFJp?=
 =?utf-8?B?RlAwbFkrZ3JmRE9OU0owdGlyaEZ3RXNEaXhKUjZldjJLeEE5cDc1cTk0UUcv?=
 =?utf-8?B?dUJGL05DdE04S2lTUU11NTRlWW1pSG1jMXU1Q0NWZEs2ZHJVZzBmWkZWd2hX?=
 =?utf-8?B?TlgvdU1nZjNJZTdaOGxrUTFRTWxiOWN3c2hmWVhFQzNROWl0MjNDc05ybUxs?=
 =?utf-8?B?SncvSFcxVlVxc3NLbWU2RithdTNHYURuekxkdGVpeGd1L1h3V0lvWDhnSVBi?=
 =?utf-8?B?dWpPNDBHV1NOQ1RWTzZwcm1ReEg0Skc0SGlPaXRFbitVY2xtVGFEZUxNek9N?=
 =?utf-8?B?aVYwUktLQVQ2cUpCblhGY3JDeU9NQ3kxVENkVHRDd3dVU2dSS1d0TGgzeVNh?=
 =?utf-8?B?MFE1NzhFbElEeHZsUHhxeUJ4dFRGQ2NaNkM3dFdVSkR2VHZsZHREN2lkd0pt?=
 =?utf-8?B?b05XNFNKdHZTNlVZQ2c3ajNJcDl2OGFleDduMHZGQ0sza2hVR28xaG5POHV6?=
 =?utf-8?B?MVEzYmtKa3pzR1B5dVg2VWVEcnVXdU55amNCeHlEKzVVdFhpNVZZT2NrVzZR?=
 =?utf-8?B?NThmNS9qV0VlYXFhdGJIOTQxa3pNbFBGdHNnaTFuMXdGVVJpYWdFM3k3WC9Q?=
 =?utf-8?B?TTNXeHQ3SHBwSWdlZlR2WFRHV2djMUlmbHBZdG9maC9JQ3FPNnI1aXQwcXZt?=
 =?utf-8?B?a0I5Ry9WTlhTVzkrR05yNktVeFNaN28rZXA0KzdyZVc4amNxVEhlc1B5QmZT?=
 =?utf-8?B?TU5Rc0x1SDRPTHdmUVZtTnU4MHo2SHF3WFYyS2lDNGc5SHgxOFZkWlh0ZDRF?=
 =?utf-8?Q?7zm9oHr2+9Fjxw6s=3D?=
X-Exchange-RoutingPolicyChecked: MBU33CGZzJFI3qJhmOQuxp1Z4Shk2cdAwW1oPUk5MaYStvlfMF4QNf2bY8ARdPj8kVmiSQ2osTsnh6ZnryqNKzETY/nIjqw1hZ+n0f7d5uHfEGbtHqjDOntd0elVeuAIoDz+dllKyBhzp4seDteLfvU0zViGuLrwm/ojO/lAb90v1Qv/bwK39Urf2AX2e/tCf0lButY4d8eLF/kVqG1dONs0mUy6h7vWndPKbedMaPynilhup2srpi/jAmXGbOLtMPJcFafX59lBieOIRF2jQ9CHJOy092wLeSH6E2TAZeiWZ3whPjswdHjeOc2/Yb0/dfE2CXh4qgV3SM5tKvq7xg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 46a41f75-a4eb-4442-561d-08de93dafddd
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 12:49:50.7577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBtZPzPQNBoEMSE+aegZqQtBUMNcs1fiApqg5Qg+wQEeUQYCNCVu1IjBdKdZiDMAeAm8l24uW5sGvgpqoKdFOaXOcmBdwFwCHasr+zN+SMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF6806D69E4
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


On 02-04-2026 02:01 pm, Raag Jadav wrote:
> On Mon, Mar 30, 2026 at 07:10:33PM +0530, Mallesh, Koujalagi wrote:
>> On 30-03-2026 10:25 am, Tauro, Riana wrote:
>>> On 3/18/2026 12:10 PM, Mallesh Koujalagi wrote:
>>>> Add a debugfs interface to manually trigger power management unit error
>>>> handler for testing cold reset recovery paths. This is useful for
>>>> validating the error recovery mechanism.
>>>>
>>>> The new debugfs entry 'trigger_punit_error' is located at:
>>>>     /sys/kernel/debug/dri/N/trigger_punit_error
>>>>
>>>> Reading the file displays usage instructions. Writing '1' invokes
>>>> xe_punit_error_handler(), which marks the device as wedged with
>>>> DRM_WEDGE_RECOVERY_COLD_RESET method and sends a uevent to userspace
>>>> indicating that a complete device power cycle is required for recovery.
>>>>
>>>> Writing '0' or any other false value has no effect.
>>>>
>>>> This interface is intended for development, testing, and validation
>>>> of power management unit error recovery code.
>>> Would fault injection be more appropriate here?
>> Here we need a deterministic way to invoke the punit error handler to test
>> the cold-reset
>>
>> recovery flow end-to-end. Using debugfs interface, we directly triggers
>> wedge/reset status via a debugfs write
>>
>> rather than using fault injection.
> I think the question from Riana was, since fault injection can provide
> wider coverage of all different kind of error flows, would it make more
> sense to reuse it for punit as well?

Thanks Riana/Raag!! will follow up.

Thanks

-/Mallesh

>
> Raag
>
>>>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>>>> ---
>>>>    drivers/gpu/drm/xe/xe_debugfs.c | 38 +++++++++++++++++++++++++++++++++
>>>>    1 file changed, 38 insertions(+)
>>>>
>>>> diff --git a/drivers/gpu/drm/xe/xe_debugfs.c
>>>> b/drivers/gpu/drm/xe/xe_debugfs.c
>>>> index 844cfafe1ec7..390bbed9c1af 100644
>>>> --- a/drivers/gpu/drm/xe/xe_debugfs.c
>>>> +++ b/drivers/gpu/drm/xe/xe_debugfs.c
>>>> @@ -18,6 +18,7 @@
>>>>    #include "xe_gt_debugfs.h"
>>>>    #include "xe_gt_printk.h"
>>>>    #include "xe_guc_ads.h"
>>>> +#include "xe_hw_error.h"
>>>>    #include "xe_mmio.h"
>>>>    #include "xe_pm.h"
>>>>    #include "xe_psmi.h"
>>>> @@ -509,6 +510,40 @@ static const struct file_operations
>>>> disable_late_binding_fops = {
>>>>        .write = disable_late_binding_set,
>>>>    };
>>>>    +static ssize_t trigger_punit_error_show(struct file *f, char
>>>> __user *ubuf,
>>>> +                    size_t size, loff_t *pos)
>>>> +{
>>>> +    const char *msg = "Write 1 to trigger power management unit
>>>> error handler\n";
>>>> +
>>>> +    return simple_read_from_buffer(ubuf, size, pos, msg, strlen(msg));
>>>> +}
>>>> +
>>>> +static ssize_t trigger_punit_error_set(struct file *f,
>>>> +                       const char __user *ubuf,
>>>> +                       size_t size, loff_t *pos)
>>>> +{
>>>> +    struct xe_device *xe = file_inode(f)->i_private;
>>>> +    bool trigger;
>>>> +    ssize_t ret;
>>>> +
>>>> +    ret = kstrtobool_from_user(ubuf, size, &trigger);
>>>> +    if (ret)
>>>> +        return ret;
>>>> +
>>>> +    if (trigger) {
>>>> +        xe_punit_error_handler(xe);
>>>> +        drm_info(&xe->drm, "PMU error handler triggered via
>>>> debugfs\n");
>>>> +    }
>>>> +
>>>> +    return size;
>>>> +}
>>>> +
>>>> +static const struct file_operations trigger_punit_error_fops = {
>>>> +    .owner = THIS_MODULE,
>>>> +    .read = trigger_punit_error_show,
>>>> +    .write = trigger_punit_error_set,
>>>> +};
>>>> +
>>>>    void xe_debugfs_register(struct xe_device *xe)
>>>>    {
>>>>        struct ttm_device *bdev = &xe->ttm;
>>>> @@ -550,6 +585,9 @@ void xe_debugfs_register(struct xe_device *xe)
>>>>        debugfs_create_file("disable_late_binding", 0600, root, xe,
>>>>                    &disable_late_binding_fops);
>>>>    +    debugfs_create_file("trigger_punit_error", 0600, root, xe,
>>>> +                &trigger_punit_error_fops);
>>>> +
>>>>        /*
>>>>         * Don't expose page reclaim configuration file if not
>>>> supported by the
>>>>         * hardware initially.
