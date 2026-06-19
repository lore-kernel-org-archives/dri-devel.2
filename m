Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB8B4CD98E6
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 06:42:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE4F810E05B;
	Fri, 19 Jun 2026 06:42:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HXQiwA9K";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BD5110E05B;
 Fri, 19 Jun 2026 06:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781851364; x=1813387364;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qYaGOjo0uMsfOIQ8M8cs5d1+WDQ85wkkQiB6ocC5jUk=;
 b=HXQiwA9KbUJxhmTPsmZw1NeCtW2GryUH0qyih8dZvx0YbHOC6bbnO6eY
 hj8ovpMi22/cryoFdd1xFRO0CIzsRgp3JLRuvbyqPxS6DzCrPFK5TYQdg
 lc6zU5UxX3lxLRbnahWK0RYVvjp6Yo5xk4v/XMhGWbP1w5fiihSOsO+gd
 f0bY+20yT2LIsYDqbcaQRHmTHQXLDYeZgyugNGxA/y+uhw1z4PuTayqFZ
 l5+D4+uwbmKXrkCHc7bHwQuuI4IDMCKa5kNF0AxkA20ApZ3gk0lJFCv9K
 rZUq6YAQX+sOat7ihnj4Sle7cx8TkK28zaal3XjJWiioy4zYQP2lEIpSk Q==;
X-CSE-ConnectionGUID: LJPJq7ZdQ5qP5nX+y/GcAQ==
X-CSE-MsgGUID: vy9c7vDgTzKJitDF7R8tTg==
X-IronPort-AV: E=McAfee;i="6800,10657,11821"; a="86613310"
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="86613310"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 23:42:43 -0700
X-CSE-ConnectionGUID: 4hMqLBySSoSHqvxq5J51NA==
X-CSE-MsgGUID: lViZXDeWQECa4sEWJone1g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,213,1774335600"; d="scan'208";a="244214987"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Jun 2026 23:42:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 23:42:40 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Thu, 18 Jun 2026 23:42:40 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.12) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Thu, 18 Jun 2026 23:42:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fo1yBK6VZPKixRlz19C2lVj3+Xhth4hnne9gBh8X9zdGk4j14Ojl26KxdijIxL4UNJZELvKUEq+nBxXwdnEaWeAFqqWRNPOLDvSO14NnGj1BhvUeTIeItt4FLROPpaVMwgp/v5V/JbR8wL3YQlJKFnTxmgROjgU9MUT+aY7cSbClkNL7j4wQ7zk3Q3Vm2/CxX+E0jaadnjpS0zZ/uwliVZg4muHodT5R0gDlEfbXGR/NvCoootSlDV13AfVm2GnxeWbnL6IRf5ow33hovPeh77+QnZKxj8O3sCRzoOxljA1f5OMkqd6FhHF7/lQbSqhlEXDJkd9dLrHiw4iogOAYvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1ISiTwyDXBPNAyB2/amRrXENBhddcecZqRlIzAb93Vo=;
 b=EQZxOpsHHdxt8Mp8NtDvxjTev9IGPDXE3DyA5Pj2IX0SEy27iaeL/8IbPtFxDDT8CMZMjYOPApVYwSluouZoMnJTmoYy6lNjyiBxoNFYTjILPRmw/2du4I6r0t3Zirlxg99SUJQQV9wFUIntMNnAh/h3tq/Z+eUtB344DSvv8ocTAPmV2t4BSYQSwSBbT1OS9YmMb4qfQdtCd4qZ8dnWpF07rBfU5huFa6+UxCFRqCU2BBpAHeGnyPJ2WlzwNqswVp5Jf2SzjD+SiH+7TKbVqjs+r6Brx1c5EG3RbuX7QlQ7MzGjpUBR1oC8w9fwZETT0PdyzYD2z4CBHNKFiH3Yug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6207.namprd11.prod.outlook.com (2603:10b6:208:3c5::21)
 by SAVPR11MB9551.namprd11.prod.outlook.com (2603:10b6:806:4e9::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Fri, 19 Jun
 2026 06:42:38 +0000
Received: from MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d]) by MN0PR11MB6207.namprd11.prod.outlook.com
 ([fe80::52eb:929f:a8b2:139d%5]) with mapi id 15.21.0113.015; Fri, 19 Jun 2026
 06:42:38 +0000
Message-ID: <d3f664ce-61ee-428b-8925-fd29fc5ecdd7@intel.com>
Date: Fri, 19 Jun 2026 12:12:28 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 5/6] drm/xe: Suppress Surprise Link Down on device
To: Raag Jadav <raag.jadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <andrealmeid@igalia.com>,
 <christian.koenig@amd.com>, <airlied@gmail.com>, <simona.vetter@ffwll.ch>,
 <mripard@kernel.org>, <maarten.lankhorst@linux.intel.com>,
 <tzimmermann@suse.de>, <anshuman.gupta@intel.com>, <badal.nilawar@intel.com>, 
 <riana.tauro@intel.com>, <karthik.poosa@intel.com>, <sk.anirban@intel.com>
References: <20260612080722.26726-8-mallesh.koujalagi@intel.com>
 <20260612080722.26726-13-mallesh.koujalagi@intel.com>
 <ajPxpevzpsUemOaL@black.igk.intel.com>
Content-Language: en-US
From: "Mallesh, Koujalagi" <mallesh.koujalagi@intel.com>
In-Reply-To: <ajPxpevzpsUemOaL@black.igk.intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0056.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:1b8::8) To MN0PR11MB6207.namprd11.prod.outlook.com
 (2603:10b6:208:3c5::21)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR11MB6207:EE_|SAVPR11MB9551:EE_
X-MS-Office365-Filtering-Correlation-Id: d100e8dd-0e29-4fd3-c7ff-08decdcdf412
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003|6133799003;
X-Microsoft-Antispam-Message-Info: gSEiUxMW5CQR6rs/9P1SVb5kkMMrmyJa9srMbylZuosqyk+oBVPIOhv+nkhke3UUmth+riytdi+ZuT2plKUseRJElMwjoFckXwni0oZ38KifoTD5CNjs0HZcU9iq+AXZyxHrPlAhU75GhDN1NbPFsG0kOAPvVZXrj3qf68HYcmH6Soa1dSKOSLDlCUoqCyM475gehiN9DZkYqqTydQkQEuA7ldLb2IWpev3kvDC9dV+kTyMkPBeNMwzNKQLsUUvMSmvdo2RauaeS0l5zs4lIWQGEe9A6ciMeBC/XAwpr7SOD4PVlm+CI8YKx+Hr30Y7O39BTYWGqW1UVdn//88VbV21QTQUlv9eIwankEMCH7BmzQmTZWwZ+lwhUz/86KWnLC+qS1eXp3JkuDomQ/kGs4Ueof+1+oPcnpdY3f7DEI+nQ14FVh7TXGlfi+DQO6sx1MGaSmF30BJCv+pcQrNatU/du5/KUhlKyRaFriq9hx2TpNf6GAW7ESyTg2CTUN+Jkc5R8D4Mzxs1pkCiYFeAmvblgljc3hu4Rb7jf6CJxqBc5Mx2WRZM66jpXDu+PDT39tm9Vy9W5KfYD95v1XRRWsrWjW+X3jL+2EPZSYwlh/4kcfByzWA3tcbk+qcH13KUOGZB2rJwNuk9rASi0d9mmhz6w7Nsv4yD6fBRPuW6D7uc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MN0PR11MB6207.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?alVmR21QQno1WGVWQlZxZkFhTE1CeVhVVHAyZVZlOUJJZ3NTUHF4TnpVVjIr?=
 =?utf-8?B?Mll1S3dyZEpSNGJBalNZRzBxZ1JtcGdFWldNc2VoSFJtZFFxdlVhK2FjbTBW?=
 =?utf-8?B?YkUvV1loSVRNMVRQcGttbWQvK3dHK1BDeWpqSm5rbHF1dis3UXhKcmppdTA3?=
 =?utf-8?B?bUM4QjhkeTY4aTRrYWtGUUVrZVltNS9GVDkwZnh2YVl5dGhJUFJTOXEzZSsr?=
 =?utf-8?B?REJFNUpJR2lpQWlRTVFEelE1dDJqWUlkVUhHc2kwQnpId0kxZDdDTVltZGhv?=
 =?utf-8?B?RWI0djZDVFY2VmFQamZrSkZ3V1l4bUlORGlZSXgxSzdpWVBkaEVSdW8xRHU2?=
 =?utf-8?B?d1l2Y1FTY2k1aGlTb1ViRlJ3a1F3Nm5zTTV5REVUeXRlMFlaVmd4UmNpQlFj?=
 =?utf-8?B?WlV0cy9Yd1FEVEh2VXhLYjlBbHdjT1Rua2VKZ2tCeHhUSjlNdlo5MFZyQVdx?=
 =?utf-8?B?c3FCOGVnbVI5b0NFWkV1eVlESFgxazhVRE43RWc0RmF4cjI1Rmx4dk96cXds?=
 =?utf-8?B?QXVDVGlaQXdRUzM0MUV6YmIzY0FjNWYrbzg0R0JGNHEzZHZTRFcwWit5V25p?=
 =?utf-8?B?WjM1cTNIdDJMK1Z1U2ZMMWxWMDE3Y3RUVzlOQVVEbXltV0JTZHBDd3BqNHN0?=
 =?utf-8?B?SllmeHd3WUh1UWQ3UWZ3U0U0L29ZN0NoaWppRVlCY0pVSlFndUp6aTFIcVdK?=
 =?utf-8?B?WmZXMTVYU1NhUWo1SjRDR05nWEFXRlNVS2VxRWU4MG5pTUZZSnMrSHlmTkow?=
 =?utf-8?B?TlNNQkdxSS9HWndCbmJiUnhaVkFod3JKMWNsNi9KQWVMT2ZrTUVWU290NWJV?=
 =?utf-8?B?d1c1eXRkSlk0MkdrYlVlUUEwTkRDUlJGUmkzZ2ErUkUrR2Y0VmFxcHg2ZlJU?=
 =?utf-8?B?WlM2QjVjeFAveVd6TE1kQlhjbVJZTFBuNmNleVpYREVjNElyQ2JuOTUrTUdB?=
 =?utf-8?B?N3NETVE5YXg0NWNhQnVPRUF3YXV4YkJPMUEzZjV6WkdBMStSSWdvTmZFN2tx?=
 =?utf-8?B?ZmlJT3hEWlEvUy9ocS9GMndDbWZJLzBOWHFOclRLc3M2eXpnbXVldUVmb1p4?=
 =?utf-8?B?Z1luZTc5VWQ5WlVzZjM1MjlWbFZpTHJvc1BNaGN6MFA0VlRyY0YrUVp6alVV?=
 =?utf-8?B?eVdPU081VWlERDZOb2JHb0JsTDBvbHlBcGZ5MHY1MFdoWngyZy9yU1BqbjNr?=
 =?utf-8?B?ME10dXdXYVBFM3d2TG9vK3pacUtYdlNtd3JRbHh1M3FzQTVNZ25ydEgrZ3hN?=
 =?utf-8?B?cE1DR21nNlhqQnNSYmhscXlBM2RlK0tuY1VBcHh2SGNodTdBNVgwcmxpYWdZ?=
 =?utf-8?B?WWc5TlhyNWRJaVJTODJyUW5XaUhnRytRTWFxUUdweC9idlpBaGhVdHkzMkpN?=
 =?utf-8?B?b0E1SVFGc21kMFYwdzY3bEx0a0VNb2l5TXduNllKTlpTVHd1aGhvRUZRbjhn?=
 =?utf-8?B?Qm8vWnNhYzNMeFl0ZW54b3V5TUFBQlY3LzFkcGZvKzQ1VFUvUFR0MC94QUVF?=
 =?utf-8?B?cCtBU0dEY3JKbUYwZFlyaDdyVll5YjBkSVBMclFZc01PdEpBUTVSM3dPVms4?=
 =?utf-8?B?T0NMY1ZHZmhyR05tTXU4MkVjNXNpeUlOa3ZPcGozZk5ST2ZRWjliOUJMSWVD?=
 =?utf-8?B?cFE5aGpRdExFTkJ4cGQ1RDlYWElQZzJuODdtT3hqa3dlcVBTYU1UWlpoWngw?=
 =?utf-8?B?Q0ljcEwzdFNrQTd4VVZ2d0krcmtHTUZLZTdRRmp3ZVZ5RFJYTWg2R0RmRnpE?=
 =?utf-8?B?YlVBTFByWjQrUHA0UUJEaFNjT1RhM0cyYXFoekJha3JvQlBiU2Z3SzlZcERi?=
 =?utf-8?B?dmk1dVFlQzJKZDBNUlhiVlh3TWVxek9yakRZaTZrMVA4aXNzRC8zR3I0bHhC?=
 =?utf-8?B?S1cxV2ZCS25wWHN2Ymk2bjd6dHNDdmc3WTY1YkRUejdTa1hBRFhsVS9uUFRI?=
 =?utf-8?B?VENOL3k1V0tNYTRqVW4yVFZmaFM4eGJNeE9yYWRDeklJaUFvWmg1ZjV0UFJ0?=
 =?utf-8?B?eGVybXpzV3JaekI0STZwT0pQSm40clZqYmhkTC94dDFBOEw0VlZ1cktlL2Fs?=
 =?utf-8?B?anFWazAvcHFYQ09XeWVlaWFjY2hIbnVRdDR2UTBhbFA2NXlYZUczL0ZBbDZG?=
 =?utf-8?B?SW9aVmtuaWpWdnk3MHp4cVVtT1g3QWFtOGFhVHB1TUg5UURzT2ZzRXBzUVh0?=
 =?utf-8?B?WitaenlkUWt3T3lvOWNDU21IY3hMNVd5YkMzNFRFQUpqSHovTExvNmpoMWFu?=
 =?utf-8?B?NVZueHdsQjRIV1d5enRxb21mL2Y3MTZGMEJyaXNRa01Xczdxa0E2Q3RPQ0lz?=
 =?utf-8?B?cVk5bVE1N29GcDg0c0oxaSsyVGpyU2NXREwyQjhPdXh6NmZmTWlYbjNZcmlR?=
 =?utf-8?Q?q4bHXfzTOPTnl7IQ=3D?=
X-Exchange-RoutingPolicyChecked: IXoZc5nGYs/viYVdxwSBmHXot2i72Nz9Us9Kixl4xEOFEEsxgsY+uhJqj3aNh44mnhXpKVM821wBPM+nyFWvr/OKt6EfmyARF1CRBjvGs6ivF9UVQOo0aIzMYPYVAWqmN1b4Xgakyb18bckzAPg5qyNDm03oCng3kcyNYQK2dtW/qgIESBhvlTc1DgD5e29+PusHQDrV1kkOk4tzQzDTAxO/3hz/6IzfVdcQFJQ1jl4UT3aVCsBI21m/xn7b38J//eZS9PBwezGf8so9HU+CArib8hSacUtGHscV5+SJ9DHAPft/y2omZ0SqB7HIHkWcWgc1I8CiMz5qRhYtYVDT2Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: d100e8dd-0e29-4fd3-c7ff-08decdcdf412
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6207.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2026 06:42:38.4463 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uSo1eUgX2idSpLXm87+cvHxGL021YnK3M1++3ji3IDwBG4/MZvHW2c3ED8EgtwpRv92+arhWxDE5ChAmrr5oIwsiJ4LDxaHXzaxNaMCVp2k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9551
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


On 18-06-2026 06:54 pm, Raag Jadav wrote:
> On Fri, Jun 12, 2026 at 01:37:28PM +0530, Mallesh Koujalagi wrote:
>> PUNIT errors can only be recovered using a power-cycle. Xe KMD
>> sends a uevent to notify userspace to trigger a power cycle.
>> On platforms where link drop caused by powering the device off and
>> back on is reported by hardware as a Surprise Link Down (SLD), which
>> AER then escalates as an Uncorrectable Fatal Error. That error fires
>> before the device finishes coming back up and defeats the
>> very recovery we are attempting.
>>
>> To keep the expected, recovery-induced link drop from being raised as
>> a fatal AER event, mask the Surprise Link Down bit
>> (PCI_ERR_UNC_SURPDN) in the upstream port's AER Uncorrectable Error
>> Mask register before punit_error_handler() requests the cold reset.
>>
>> Signed-off-by: Mallesh Koujalagi <mallesh.koujalagi@intel.com>
>> ---
>> v6:
>> - Expand commit message to explain why SUR_DN is masked. (Raag/Riana)
>> - Check Slot Implemented bit before reading Slot Capabilities, per
>>    PCIe spec. (Riana)
>> - Add debug log.
>>
>> v7:
>> - Handle surprise link down event properly. (Aravind/Riana)
>> - Update commit message. (Riana)
>> - Correct log message.
>>
>> v8:
>> - Use find_usp_dev() in punit_error_handler() function.
>> ---
>>   drivers/gpu/drm/xe/xe_ras.c | 65 ++++++++++++++++++++++++++++---------
>>   1 file changed, 49 insertions(+), 16 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/xe/xe_ras.c b/drivers/gpu/drm/xe/xe_ras.c
>> index 93a56a0269f1..15c2fa0d323a 100644
>> --- a/drivers/gpu/drm/xe/xe_ras.c
>> +++ b/drivers/gpu/drm/xe/xe_ras.c
>> @@ -209,8 +209,57 @@ static enum xe_ras_recovery_action handle_core_compute_errors(struct xe_ras_erro
>>   	return XE_RAS_RECOVERY_ACTION_RECOVERED;
>>   }
>>   
>> +static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
>> +{
>> +	struct pci_dev *vsp;
>> +
>> +	/*
>> +	 * Device Hierarchy:
>> +	 *
>> +	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit (GPU endpoint)
>> +	 */
>> +	vsp = pci_upstream_bridge(pdev);
>> +	if (!vsp)
>> +		return NULL;
>> +
>> +	return pci_upstream_bridge(vsp);
>> +}
> Unneeded churn, please make sure the function is already at the top in
> the original series.
Sure!, will take care.
>
>> +#ifdef CONFIG_PCIEAER
>> +static void pcie_suppress_surprise_link_down(struct pci_dev *usp)
>> +{
>> +	u32 aer_uncorr_mask;
>> +	u16 aer_cap;
>> +
>> +	aer_cap = usp->aer_cap;
>> +	if (!aer_cap) {
>> +		dev_dbg(&usp->dev,
>> +			"AER capability not present\n");
>> +		return;
>> +	}
>> +
>> +	pci_read_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, &aer_uncorr_mask);
>> +	aer_uncorr_mask |= PCI_ERR_UNC_SURPDN;
>> +	pci_write_config_dword(usp, aer_cap + PCI_ERR_UNCOR_MASK, aer_uncorr_mask);
>> +	dev_dbg(&usp->dev, "Surprise Link Down masked for cold reset\n");
> What about when we come back on after successful recovery? Do we need to
> unmask it?

Not required, since the original settings are restored after the cold reset.

Thanks,

-/Mallesh

>
> Raag
>
>> +}
>> +#endif /* CONFIG_PCIEAER */
>> +
>>   static void punit_error_handler(struct xe_device *xe)
>>   {
>> +#ifdef CONFIG_PCIEAER
>> +	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>> +	struct pci_dev *usp;
>> +
>> +	/*
>> +	 * Cold reset power-cycles the slot, dropping the PCIe link. The
>> +	 * slot triggers a spurious Surprise Link Down AER event on the USP.
>> +	 */
>> +	usp = find_usp_dev(pdev);
>> +
>> +	if (usp)
>> +		pcie_suppress_surprise_link_down(usp);
>> +#endif
>>   	xe_device_set_wedged_method(xe, DRM_WEDGE_RECOVERY_COLD_RESET);
>>   	xe_device_declare_wedged(xe);
>>   }
>> @@ -503,22 +552,6 @@ enum xe_ras_recovery_action xe_ras_process_errors(struct xe_device *xe)
>>   	return XE_RAS_RECOVERY_ACTION_RESET;
>>   }
>>   
>> -static struct pci_dev *find_usp_dev(struct pci_dev *pdev)
>> -{
>> -	struct pci_dev *vsp;
>> -
>> -	/*
>> -	 * Device Hierarchy:
>> -	 *
>> -	 * Upstream Switch Port (USP) --> Virtual Switch Port (VSP) --> SGunit (GPU endpoint)
>> -	 */
>> -	vsp = pci_upstream_bridge(pdev);
>> -	if (!vsp)
>> -		return NULL;
>> -
>> -	return pci_upstream_bridge(vsp);
>> -}
>> -
>>   static void aer_unmask_and_downgrade_internal_error(struct xe_device *xe)
>>   {
>>   	struct pci_dev *pdev = to_pci_dev(xe->drm.dev);
>> -- 
>> 2.34.1
>>
