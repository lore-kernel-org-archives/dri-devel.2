Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A989B606A326
	for <dri-devel@archiver.kernel.org>; Fri,  6 Nov 2026 12:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=g/5aOJV2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00A3210E3E7;
	Fri,  6 Nov 2026 12:20:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B21F10E3E7;
 Fri,  6 Nov 2026 12:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793967639; x=1825503639;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=WeGrKPiX+XqwbGEL6LK99tnLqWQy1AVzzp7ydmLLTw4=;
 b=g/5aOJV2Rxb4tVZluISeZ7eOl+Yh+g/1IEmaCr394dCwWZNZKr5dFS3A
 NWwjEPkpYIhucAdXhtghCHA3HOiOQFANGIIUxFY5IYV5MS3YZSUtbyNXX
 LG8/ko1z6XSmFqCRWlnns5OJXdSbo5YgB42w45vqE6NGtrQ2H9PanS5Yx
 /f8dUdVNZAoWVvqm+Xbuq4YdptjjYyeJteaNuGlzCVBYdFuN/93L2xeKl
 PH28SGL+FY9N3ACOr8iOmR+6rS0FXxBO98kNxA8tvjf2OwpzKYmKBSPP8
 JZVAu4a+E8+migDSf2U5ARZ5FL20uMq8KazNVWnQyD087i1Lg5uIm8LDh A==;
X-CSE-ConnectionGUID: YAcIKJAUQ3C4aEOOTfv/1w==
X-CSE-MsgGUID: RyJ3Dd2yQzWS6tEJ+t7tmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11957"; a="2648017"
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="2648017"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:20:38 -0800
X-CSE-ConnectionGUID: bVyDl2bdT56cPfUlGV4F3w==
X-CSE-MsgGUID: TKswu5N2TlS702v0XdyuEA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,197,1787036400"; 
   d="scan'208";a="9134037"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 04:20:37 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:20:37 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 04:20:37 -0800
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.11) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 04:20:36 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LBzSU6bOdqKfDobJIn+eSdbbSytDVIxRsPrcfhlVfIS2H+TqlsbY7YREeGSSTrmQZwnCtNMNJT4BrmQVlNh3Zfz+HGy0wqEfUwfqvZKNmWG95ONJppKIkImKvlZtK4vKxr3TZ+gK3v4A/PEXzwbHy1ZfkpmBV6BGQwRT5QsUaF229DNsZmqIJC5i5ZDSZPNEpMEvjlqu12h/1wJCJ/jqBkBLn9kb0BshenmCwd9/Sm4/PsYnIrIu6q9+WNancl97zl8zovIqCk70TBnlkZLbRQRL8KBLlRWIbuYcrI9EoSisdIAnj9U+ojKkV5kFLqFbr4dzdMlYGYuuActmDt2l8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rKHnNU7g9AnGOpKaAk4B3gMIpez8f9E+1JWlUCTcSm8=;
 b=jGMMUp7ritt6y46qYkjA5Mxx3lAtz89gfBPtMQKDLC6WNPruvsobiOfHkGdEANSJazxYT3OJ0ZhCy6hYL+vXHqUiQD+XZSqkR/cNAFXgZhvxlhkg9fftJOf+p7ZWJkx35ulGCQI2DQtzzisFJxxaXWogAeHc/0EUmzQOXP7/9zW61DCMKfC/JA8GRKEbKPJMBnc/UIyw7q7yYovxzQ9qw0pVTYOOrWgyWKkcdN89oNbjSBwjKE1eCKhdiK7TyYRgaZmQvGvyichCMX74xzTQUEA1UQf/yhsPnGqmxzMnDTl9SPVXO8YG2yuJXhyFPhUCrAxGYawjG3h5y6QMCHCi8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by PH7PR11MB6521.namprd11.prod.outlook.com (2603:10b6:510:213::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 12:20:34 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0592.010; Fri, 6 Nov 2026
 12:20:34 +0000
Message-ID: <2b70fda5-187f-4047-a742-533f11985593@intel.com>
Date: Fri, 6 Nov 2026 17:50:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
To: <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Matthew Auld <matthew.auld@intel.com>,
 Arun Pravin <arunpravin.paneerselvam@amd.com>, Joel Fernandes
 <joelagnelf@nvidia.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
 <e87c786b-ceb5-4907-b215-ef276910392a@intel.com>
Content-Language: en-US
In-Reply-To: <e87c786b-ceb5-4907-b215-ef276910392a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0023.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:179::16) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|PH7PR11MB6521:EE_
X-MS-Office365-Filtering-Correlation-Id: 78706068-1a28-45f0-273a-08df3c005b6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11062099010|7136999003|10067099003|22082099003|18002099003|4143699003|261026140227099003|5023799004|11063799006|261028144727099003|261026121527099003|261102123227099003|261022105027099003|261021123027099003|261009223027099003|261021121427099003|56012099006|261102130727099003;
X-Microsoft-Antispam-Message-Info: PdtkQpu7huUFq5uM/lp289hNoBUAoTfouldjn+y0McnbUYZb4PkWTlTvwxMU7tGDaLEHHRGQ7SVZygvAtLlahiKuVohx+GMKKjDXbVCemXHyN5nEZ+8vze/0BSN9HUAkpokFfaJ+r7l26+kR8RGNJG4dTK6xD+QHaskCvYO1ERdtaFTXsvgO+Srt7tM+7DJLSgJTqWBd91Qz656SwsxWx+bovAV5TNNwViEKV7FmYsCUJAcLUdh8X3o+iLkjYGv8O31qEdH6ccMmhZCILnT1S0VWzMujNmeT1WPD+xRLwaTWGV2LcFnhEo0eI6JdFSAwkFGsMMPe1i2d/T8mBnaV7vct3cx3mOC+InAuPeeyqHwyNZ84VkSkG/Bx95q/ce/haP1AVzFmIfBp6rvz/lDVJK0aXJSyz+AM0H46Is0Xce0nSzMdb0nfd7fP41JKawiDh9f1dXY1C2qNON2zn6HWzMOczPI86uW9OA9Y17d8a8w4OUB/94BakUCuRg96ivfrszm1TkMeGZZ009PUiYIC6NpZxd2nRoRU366IF2oCyt3fWdAthgKNMRCxa+OEMy/Eyoy+8lhCHBnrDOXdyOQ11YVIXasqaOTx+zmLHyTDpLJEpXp3XbmyXtWCBgtdrj2LnzjVFI63WDP18VuyXtUCYUcJhixKoRFx6aaK0hE5T5I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11062099010)(7136999003)(10067099003)(22082099003)(18002099003)(4143699003)(261026140227099003)(5023799004)(11063799006)(261028144727099003)(261026121527099003)(261102123227099003)(261022105027099003)(261021123027099003)(261009223027099003)(261021121427099003)(56012099006)(261102130727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1Y3RE9kR05Sam9MWjhpVkttYWwzRTFhdk02bXkrMWVna3kxVCtBSWc3ek5h?=
 =?utf-8?B?MW5kejNJbUM5cmhQUzErbEd2NDU4TXZWMVo4ZlVjcDluL2N1VGIxY3ZEMWJH?=
 =?utf-8?B?cG9IRGNiblhGUDR4UGd1RXFsQkE0aGhlcDBLcURzZnphL0lmVWlvZUxKNHdk?=
 =?utf-8?B?RFVwZTA4SlpqdHg4anRZR1pQWVp5MHNkYk43cVRmdVRJbnlQQkhlVERRS1V6?=
 =?utf-8?B?c0MwdkxQRDBCRm5lbjYxNjA3ZTRtK2c5bTZyZ2xOSmMrMmgvMGduYUhBbE81?=
 =?utf-8?B?MnFGK2JVaDJSdU9jS3lTdTVJdytoczZpQXJDMWJrZW1GL0QvcmV2QzBueDU5?=
 =?utf-8?B?a0hwUnZPUExYSHh5WldTN3Awbm54ZEp6dnA0SDFLMHlYOTBSQ0dXMXlaYVlY?=
 =?utf-8?B?RWsxa0J6WDBjdW1oYlZNbG9IZUlJZ1UwUC9iUE1OUURuT1lLOVNVWmgzanQ3?=
 =?utf-8?B?YitiTXhLTUd2eEd0UHdrN3VpeWhuV3gyK0FlSEYvRmZ5UmR1YWMrL1JjMzJz?=
 =?utf-8?B?Y3Iyb3RhQkp5V2FseG91RmR6M2RaVjF6NnRuMzFGbmJoTm9wSjBFOXhyT2tD?=
 =?utf-8?B?ZWUvSkZaeVh1aWllRjdHSVpNZW9nc3ZQeVhlRy9NbEt4bHo1S0pWNk1hbG43?=
 =?utf-8?B?a3RHTWM4UmxRWjFJeVVibll0TXZwVDkxT08zZkd0TDY5c1BUR0twT1h3bEs2?=
 =?utf-8?B?S1Y1SWJmZnhxRjhkTUhBWHFsZkFkdVBOQjcxemN6SjdFZnBkd1VRT2VwVmdI?=
 =?utf-8?B?bzdhTW5aTm5nSlZkYXRxM0FpZDJNT2RZdllaUTloVFVIMjNpeW5SWjlnN2cw?=
 =?utf-8?B?UGNQRWw4V2pDTXkrc3UwcjJJeGNrOHpGVFZqWTcyQnRxTFA4V1VZRGwyaUkr?=
 =?utf-8?B?aG8yRDA4L0doUkw0OTBRWnRzc0RLMXlDT2toSTFndVI1czNobVlSWEtDaC8w?=
 =?utf-8?B?NGpXcVpvMTlYSGlXWG05VlRTNlRhL2h5UkVKLzIvVkdldVZQNE16ZWFFU0Fm?=
 =?utf-8?B?R29EOVhUNHlPbGhqUVBxT2huMytGZE45MU5ITXpvbUNWOVMvUGtUdXhmcDZR?=
 =?utf-8?B?eElEQWpaRURKSFFjN2dVbGhxbGEyUVNyMXpOeFdtSmJpNFNkSUpZaTU4ZUZI?=
 =?utf-8?B?ZlY4K0h1eGJwaXlaaVZCUElOeXF6WnBTWnJITVJsM1lkTVE4cTgyaVJwNHJD?=
 =?utf-8?B?ZnMzRWZGL3RkazVSVzJHTmdZd3hoa1FaZThaTG9ZWDZVRmwwNWtRQTlJMDJI?=
 =?utf-8?B?cGdkcXNJa3hzTE1wbG9NSVE4ZEhCdklibW5TUFpzUFFvbFRLNGZYOTJxZGU1?=
 =?utf-8?B?OHhsbk9leW9GN015SThtRXZZS3dUcUp6SWw4UkMrMTZJaWZBNUtlWUR3Z1pk?=
 =?utf-8?B?a3VKNDQ3WitPVGRWSUI0S2I1N2hlUW8zcVlxQ3MwQnc3RlFBQmkwVkprRW9P?=
 =?utf-8?B?RjZUVFo3dnNzZXlFdHpRcVBuMU9kdk50bHJaU3QwTXkvTUpUS0UzYXJ6cU9o?=
 =?utf-8?B?MUl4amFnWmUrSGNJMTkyZndlM1R1Sm5wcE9IcHh2ZTU5Uk5LelMyVTZLNlFZ?=
 =?utf-8?B?bDkwVEtwQ3FONlU4V3VRWmhnOHBkWHpaQ2liYURSMnpXbUNSeG9aMTh3SC8v?=
 =?utf-8?B?MkJ2MllTV3FHWWpDWHFBd1V5Y2JjZDdrWktyWmk1UU8zS1hnKzJwVGxoOHov?=
 =?utf-8?B?Q1RMdWNidm4rYWIxRGErM0tWMDRnWjJ2VVB2RnRkVkVGNDBWTzl1bUJKNnVx?=
 =?utf-8?B?SXdTVjFEeG5IUlNQSnV3WjllWFVqQWEzZzZjQXZTNlFOTzFqZU0yR3hZdXVq?=
 =?utf-8?B?Q3VRNFlGaFlzQkp2dFBpdVByZTczYU5BMWJ2eTBEWlJkWkdFc3hVcWJVRlVr?=
 =?utf-8?B?bnFRWkNvRkxPUlhqTFhucWE3TmRoNENHOEh0M1BvZ0IxS0t3QTNuZnhQaCsw?=
 =?utf-8?B?NVVXS2pwZ08za3BQMFRSaDRNdGJnbWhJeVVtbEtxaVN0RXZ3MnNlclJMdWtx?=
 =?utf-8?B?S28xUUJYUlNpN2dzTGZmc1YzTWZvaUd3bVBYditUU1RLdzRyTkVEeEgxSnZM?=
 =?utf-8?B?SVozR3JnVjBKUytvWTJZdzdmUUc1RFJ6RE9jVC93TXRkSWdsMkMxNkxmb1lW?=
 =?utf-8?B?dlUrejZ2bUNvM2t2a29oeC9ORnRoSklrbWpJaGtOODZGRGR6YXlsNFgwMFND?=
 =?utf-8?B?Y2JnWktBcm0ra0E3MG0wK01ya09DTUxuQ3NaODdySTM0UzdoSWhWbE44LzlS?=
 =?utf-8?B?bnpIZVErQ244cHRnRktDSzQ3MmdmKzJSOHB4VWJGR1FzVHd4em9yT3JwQkhh?=
 =?utf-8?B?emJ3OHhiU2FzTUxyMXBTUnRiYVlVblpLMEtaWS9SRUsvZDlGQU44VzFMbDBO?=
 =?utf-8?Q?7lw6E10c+wrA/zK4=3D?=
X-Exchange-RoutingPolicyChecked: BUwrA6ZlXTfcjkCz18zJR6ydQ7FzPtd7gZCPwfPuMWjkbtQFvcMQlxiL+ee8xAaxS6EIh10nmHH6npB2IY7HQmcIwTx2W3CMNfWO7wirisOnZRiTSUKfCH9q0HC5FXGHKOhhRQVfJd1CuKBZ9jIMoN31oukNNvgpivNRpktbqOPxtbtVoYFKUK9IUSNb0LfTE5opDpVFhDzGwwptmb/WO8U+aPZKr6gs4rptzjeUk+fhFonnPblhApOx7ti68bKrooLxp1S5TVQX1PY4BwE5kH/q3ZToNq3tSLMKT2A/SYPT/Wuix8aNRtUkdXRBUq7E6tWNN501/l7O/QWnUepEzA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 78706068-1a28-45f0-273a-08df3c005b6f
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 12:20:34.2925 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sGCP3YUIzYSVHpwqImif//ob0UDl9v0h5fi1oiM/xKD8mfDopp7XHLZNxNrN3XlL/ML8NnC6EGbZB9NrVYSmAUT4pvvHT/87gnwaZWOiIew=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6521
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


On 04-11-2026 17:42, Yadav, Sanjay Kumar wrote:
>
> On 02-11-2026 10:46, Sanjay Yadav wrote:
>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>> first, and descends every SPLIT block even when nothing below it is
>> free. Range allocations are placed top-down, so they pack below the
>> range end and each new one walks every block already allocated there:
>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>> lock.
>>
>> Track in each block the largest order of any FREE block in its subtree
>> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
>> or freed, and skip subtrees that cannot satisfy the requested order.
>> Splitting needs no update of its own, as both children are marked free
>> right after and that propagates the new value up.
>> gpu_buddy_block_trim() detaches the block before freeing it, so updates
>> stop there while re-allocating inside it; recompute from the parent
>> once it is reattached.
>>
>> Skipped subtrees contain no FREE block of the requested order or
>> larger, so the old walk could neither split nor return anything there.
>> The remaining blocks are visited in the same order, so the selected
>> block and placement are unchanged.
>>
>> v4: (Matt A)
>> - Drop the update in mark_split(), the children being marked free
>>    updates the parent
>> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>>    only the final update from the parent propagates up
>> - Drop the order, is_allocated() and is_free() checks in
>>    __alloc_range_bias() that the pruning check now covers
>>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>> Assisted-by: LLM
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
> Gentle ping

Hi Arun

Could you please review?

>> ---
>>   drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
>>   include/linux/gpu_buddy.h |  7 +++++
>>   2 files changed, 46 insertions(+), 17 deletions(-)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 28cff97d57dc..93f70c98b235 100644
>> --- a/drivers/gpu/buddy.c
>> +++ b/drivers/gpu/buddy.c
>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block 
>> *gpu_block_alloc(struct gpu_buddy *mm,
>>       block->header = offset;
>>       block->header |= order;
>>       block->parent = parent;
>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>         RB_CLEAR_NODE(&block->rb);
>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>>       RB_CLEAR_NODE(&block->rb);
>>   }
>>   +static void update_subtree_max_free_order(struct gpu_buddy_block 
>> *block)
>> +{
>> +    while (block) {
>> +        s8 max_free;
>> +
>> +        if (gpu_buddy_block_is_free(block))
>> +            max_free = gpu_buddy_block_order(block);
>> +        else if (gpu_buddy_block_is_split(block))
>> +            max_free = max(block->left->subtree_max_free_order,
>> + block->right->subtree_max_free_order);
>> +        else
>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>> +
>> +        if (block->subtree_max_free_order == max_free)
>> +            break;
>> +
>> +        block->subtree_max_free_order = max_free;
>> +        block = block->parent;
>> +    }
>> +}
>> +
>>   static void mark_allocated(struct gpu_buddy *mm,
>>                  struct gpu_buddy_block *block)
>>   {
>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>       mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>         rbtree_remove(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static void __mark_free(struct gpu_buddy *mm,
>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>       mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>         rbtree_insert(mm, block);
>> +    update_subtree_max_free_order(block);
>>   }
>>     static void mark_free(struct gpu_buddy *mm,
>> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>> size, u64 chunk_size)
>>         size = round_down(size, chunk_size);
>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>> +
>>       mm->size = size;
>>       mm->avail = size;
>>       mm->chunk_size = chunk_size;
>> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>             list_del(&block->tmp_link);
>>   -        if (gpu_buddy_block_order(block) < order)
>> +        if (block->subtree_max_free_order < (int)order)
>>               continue;
>>             block_start = gpu_buddy_block_offset(block);
>> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>           if (!overlaps(start, end, block_start, block_end))
>>               continue;
>>   -        if (gpu_buddy_block_is_allocated(block))
>> -            continue;
>> -
>>           if (block_start < start || block_end > end) {
>>               u64 adjusted_start = max(block_start, start);
>>               u64 adjusted_end = min(block_end, end);
>> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>                   continue;
>>           }
>>   +        /* Not pruned at @order, so this block itself is FREE */
>>           if (contains(start, end, block_start, block_end) &&
>> -            order == gpu_buddy_block_order(block)) {
>> -            /*
>> -             * Find the free block within the range.
>> -             */
>> -            if (gpu_buddy_block_is_free(block))
>> -                return block;
>> -
>> -            continue;
>> -        }
>> +            order == gpu_buddy_block_order(block))
>> +            return block;
>>             if (!gpu_buddy_block_is_split(block)) {
>>               err = split_block(mm, block);
>> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>                            gpu_buddy_block_offset(block),
>>                            gpu_buddy_block_size(mm, block));
>>   -    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>> GPU_BLOCK_DIRTY);
>> -    mm->avail += gpu_buddy_block_size(mm, block);
>> -
>> -    /* Prevent recursively freeing this node */
>> +    /*
>> +     * Detach the block to prevent recursively freeing this node, 
>> and to
>> +     * keep free-order updates from propagating above it until the trim
>> +     * is done.
>> +     */
>>       parent = block->parent;
>>       block->parent = NULL;
>>   +    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>> GPU_BLOCK_DIRTY);
>> +    mm->avail += gpu_buddy_block_size(mm, block);
>> +
>>       list_add(&block->tmp_link, &dfs);
>>       err =  __alloc_range(mm, &dfs, new_start, new_size,
>>                    was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
>> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>       }
>>         block->parent = parent;
>> +    update_subtree_max_free_order(parent);
>>       return err;
>>   }
>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>> index ddc4eca84175..8037f5a0feb1 100644
>> --- a/include/linux/gpu_buddy.h
>> +++ b/include/linux/gpu_buddy.h
>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>       unsigned int subtree_max_alignment;
>>       struct list_head tmp_link;
>>       bool has_clear;
>> +    /*
>> +     * Largest order of any FREE block in this block's buddy 
>> subtree, or
>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
>> +     */
>> +    s8 subtree_max_free_order;
>>   };
>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>> +
>>   /* Order-zero must be at least SZ_4K */
>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
