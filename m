Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 776DB606A326
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 05:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=UGDfu8CG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BAB3810E4F9;
	Mon,  2 Nov 2026 05:20:30 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2610910E4F9;
 Mon,  2 Nov 2026 05:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793596824; x=1825132824;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=iAt3tMyF55oh8YxYSSDC+46CbW4op0wEmk5FZfwf87E=;
 b=UGDfu8CGIR9S4bx6KPIuYIDgETzVu8lSZpmwpT+RBmQmKkd+exWQhctp
 B59IuNEPY7aJla3YpJYpWlUn+xmoOWI1Op2dOWTLuC4WaWZo3c1dMOT6Y
 6DZuo8dXQkOUGtl34WTCcx8DrId4S767aPVeWoLPKVgP39xFs0Tp6kzaq
 j6T6Yu6BDUoaL0K3V0Gq4aacUk/sqQjSpKIwzAq2OQQMOeUjedpp1xLUY
 K/Yc57HupeNXPoZoZJvQL6HgAl/rsohIuXJlUtc8iM8QIbXD+3s6tdF6u
 0MkNkzuNGzgU9y4Sr3uvH8UT2WM/WlcWp9FIeWCnhLXhrbkWOuJrKejCJ Q==;
X-CSE-ConnectionGUID: CfcINnDZQfy/yOcntMFeSA==
X-CSE-MsgGUID: 3Kilwme6ToGiclwiOKlfAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11953"; a="2171123"
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="2171123"
Received: from fmviesa013.fm.intel.com ([10.60.135.153])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 21:20:24 -0800
X-CSE-ConnectionGUID: 8QZkwICEQD65z4g8+BhDyw==
X-CSE-MsgGUID: cT2dHfilS3+K+n9f5A+a+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,191,1787036400"; 
   d="scan'208";a="7840132"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa013.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Nov 2026 21:20:21 -0800
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 21:20:20 -0800
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Sun, 1 Nov 2026 21:20:20 -0800
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.5) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 1 Nov 2026 21:20:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X2vuAPfgTCzJxuOF2KEbKnEY2OqM9633LhjNyiW3m1BQhkmr5kTNJ6LAhOl6fxmmzGbjJ3ED9sXi87rbldN3c4PwEs/YXgVGiaJqlFw1+K81zXXODnfpkiDh9g36o8EdvFTF2cbgKNh3HX9HYrX0GlXvtC2nk3OmWcZnom3n8qeKFEEJrXGwZqctoxRWA5C1xnUvLc8qQgx0atFxiNsOH+OcmIJm6UMIvQyT24ICRJoRvMyyh9oGjpmbtpmuPaf23xQx0iM39TRoJe2ccts1q97r80egtrwEinDC1sYYdYpI4IFytsDAE+t9LjlMCh8AUEbhdqhrPx0O4A2GK82oLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H4Dfw50J/dsQnxIsYBgL/gnCLt8noEKbSTjcqAhNF3U=;
 b=dJKueswmK4AK0VlCOmvydQ5GJ1i4ntrACKg/rvPfeVvWTeqJ8aLV1gMvaPDPEOV0w6I1lsbtwmUxoaYL/n/8DX2pedZY5aQfDajLMKaxr4zQ5yjmYbFyO+Fz0GM7sEWDjuNivu4k2kOvJqhLQUtyZrIO8vc+MJPAXLAryi43Xcqb0PU8amAB+y/2Se0o4F09aIkDpJJ5nwmplf59yEER3vmA2aNyOp6OQZ6rU4awsx7tEbKuaBb2cHTLSsEGklpM6KlR8LixWSnCgVJbfCNkWLq2+fMcldgj8D9qXMQ9XS562YwcJrXeK8xr6NhX85y+wOC7HdNUe3TNLgnmT3GxcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by CH3PR11MB7895.namprd11.prod.outlook.com (2603:10b6:610:12f::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Mon, 2 Nov
 2026 05:20:13 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0569.011; Mon, 2 Nov 2026
 05:20:13 +0000
Message-ID: <d9f66444-5194-4a83-beed-5b355d5e3687@intel.com>
Date: Mon, 2 Nov 2026 10:50:00 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: Matthew Auld <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>
CC: <intel-xe@lists.freedesktop.org>, Arun Pravin
 <arunpravin.paneerselvam@amd.com>, Joel Fernandes <joelagnelf@nvidia.com>
References: <20261022051518.486064-4-sanjay.kumar.yadav@intel.com>
 <20261022051518.486064-5-sanjay.kumar.yadav@intel.com>
 <37602ca7-91eb-40ec-bf6f-3c2f568fde20@intel.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <37602ca7-91eb-40ec-bf6f-3c2f568fde20@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0283.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:221::16) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|CH3PR11MB7895:EE_
X-MS-Office365-Filtering-Correlation-Id: a25806f0-7100-4f1a-6802-08df38a0f895
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|10067099003|56012099006|261009223027099003|261022105027099003|261021121427099003|261022075727099003|11063799006|5023799004|4143699003|261028144727099003|261026121527099003|261026140227099003;
X-Microsoft-Antispam-Message-Info: 1mUgsXMLxq6QaXwGWnCxaEbUVZbf0n+9r0nNHv3sI9ebRxC6khT+lHjO3UxUxSJpYGW1RIbAafUa6r4i0LiLaGX8rx/An9sLnUJJGVHjtm8qCrB5E5TxixSsj7GxdhXR5KQ5O7QH6QxYAYuJZ1yXaYXJai73oJV5hXRN1IHRySZCYZRDwx75M96bRZAdPrLZrwgqrdAcJYXPcS8uauCa660kyQzbDTc4+KfD46YDNxiDXeZqyhzbkB74n4IZBtk2u8F6SCJ0Hcd3HOuQuA9OVnfE85+RkmeLOoV8X7y2YdFCJVjGJAWck1mxEFFezV3Yzybmc42s4oIGW0dh/bDPCsIhK1X1JLocEsCbGslgew7MEpbT3gnnR2Il/bjQk2gwxGe8k+RDmjcQvzTBWovZpddEcKBWs+Qp17ZzCUaviNPDKepMvv3O1fZWZ7EZQjuY8SStUUO/9rJa5lTWG+Sy7Tl2iH9P2utYlBH0FVI4+lkdsDpGdSX3g85z9HlOkKVqTwFUF1oHOK+sjM4/44cpqW11pDVrgE5xYXe7zVZnA/gvrooxsF+BJOFwsoZCWOImlevsJxxqrnulwEWhTXsLWJzZomh+6Vf3tZnH64fFjOyWVtYVZwOdBsu3ruVWoRM9ijpZg9Cg5bkwB9vs0DFt+7c67Z/13gdc+qsuitmMYiA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(10067099003)(56012099006)(261009223027099003)(261022105027099003)(261021121427099003)(261022075727099003)(11063799006)(5023799004)(4143699003)(261028144727099003)(261026121527099003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SUt1MmJEMEZ1Vjdvd2xWd05YZnlKUmxmalFLVkpnL3Q1dzJzMGFzSXcwZkk1?=
 =?utf-8?B?RG5abUVwT1JsUXFCOHFhS21GM2tMRUEvSVcwYkg4aFh4K0d0cTdZMmZwaTVK?=
 =?utf-8?B?Z1RaZm0yUVNoUEFYVjc4YllCYlRReS9GWG53V0E5eXVpZERsOXllYUc0d1Jy?=
 =?utf-8?B?R3kzS1c4UUhiNEVIa2RvWThNdkZWaTI3b1ZLNVlpcVFOMDhyY2lBdXNRMjc2?=
 =?utf-8?B?QVBlVXFqMTVudHQxSzB4dE5uVHhqWFA5Y2FqckFLL2toUGFyN2poaUNRVWJN?=
 =?utf-8?B?ZEtoNmFhQmtiUFJSMzRaa2d2NDRyMWFqZEVtdjZ0dEZwVFAwcE9jaUZNTU9L?=
 =?utf-8?B?L1pVZ0xIWm0zeW1tZVM5SEhrTmllRkxQbENPLzRuRmZUKzlBRXFwSUdDbmhF?=
 =?utf-8?B?clYweTRYS3hqdFJFUWQ4NzBpUE4xdCs1eklyUEl1OXlEWlhlVnpVWGxiOUd6?=
 =?utf-8?B?cmdXU3VUbmY4NktoY3MzSEtkZXB2dFg4cDkrTGNGbjhQM1JzcFJwQnhySTVn?=
 =?utf-8?B?VU9iUDJwbWwrd3paUjU5M0M0cytOeXJtd3dzN05LSTlOZ1lvYTlYelZmenRH?=
 =?utf-8?B?NTBPVmdxRW44U0I0ZDl2S3Q2RkQxMU0yUC9OaFFnbmpYU3pFbVZiaitHNjY2?=
 =?utf-8?B?bVZ0Wlh2NkZqcHlDMnhDRXpoelFxeWxsaW56K2wvUy9ZU3FjMWFJallsUFhU?=
 =?utf-8?B?MkxwOGVKVUxZRC9TVGhIek1xQlFvV3Mrd1pyVzY4Mk51NlhMTmZCdHdybjFC?=
 =?utf-8?B?aXRtNWticklFYmhqRTNrUWJmU2doSm9KNWx5OWlLWWM4Q1lDanBhQ1N2UUNC?=
 =?utf-8?B?SFFPMmJLWUxmaUFRYVlJNHAxTlBETmgrMkloc0VXbDVJNERySmpMayt0Zkc3?=
 =?utf-8?B?Mmx0N1FacWlUTmpDTE1oSFZNZnJYYU9aRUhVY3Y3Wmg1ekxNSWRpUkRTdHZI?=
 =?utf-8?B?V3I1cHNMT1BDdytkYnExOXAyeWxoUXVCamdLRmx1SDVmT3h2SW5MVlRlY21r?=
 =?utf-8?B?REViVzdlbC90YTZrOUMvNDdXejhxalVwNXNrWlRpQjZaY09GTzFLcm5qd1Zq?=
 =?utf-8?B?QjNPOWNaL2sxZkdGZkQ5WEg2K09tU2daSjcvOWJ0WVIvVVdTbXczY0dnRUU4?=
 =?utf-8?B?ODFTeUZKcGJmdlM1OEN3ZzRKWkpCUXNPYmVYeHZzOFJ2Wkc5U1FyUHNDWDdq?=
 =?utf-8?B?OVNxVDB5c0k1Y3dvTGQ5NjdGRGJWOFRlVTVqRXNrRGY2cDZueHhNVDZ1Z2FH?=
 =?utf-8?B?dnEyMGNGYUV2bzdlM2dFZHhBYU9VczVGVE9UUVozY0dEcm01ZGdtYm42WVR4?=
 =?utf-8?B?c2JaV3QvdHp1THJ0VDlXbDQreURSaXRGaFN6YnJiaWlULzR3alZjU0RacGlr?=
 =?utf-8?B?WmRuQ3lGSzJURDVLUW1TTmNXd1FPU1BWU0ZLRHpYUnhtN3VMQ3RVUlgwMXdm?=
 =?utf-8?B?RXJKRUJDeTFtL0MvZEJRTDRYeURlYjU3M0laT0lTQlZyRG9jaENWemFLZmNp?=
 =?utf-8?B?dVBsT3l5dGgwUmI0RkMwZjFVVDFIN2wyZzVuSHVpMWVqWjFqSUp6czh5dSsz?=
 =?utf-8?B?YVpMZWI5MHFQcW1NSUlwMXRkc0RTRGtML0pKWEFNL3E4Z2pRbWcvR1MyLzNR?=
 =?utf-8?B?OHlwSXNNQ2hwQk43ZjlUT3h2ZmZkV3BhSXk0YmZab3JVWjFDa1pDLzBRK201?=
 =?utf-8?B?bThzek5uUk1Ddk1kZWpad0NqQXpGSzRzaFhYYlFwaktPYW8xSlFqQ1Rrekg3?=
 =?utf-8?B?OHJ4Z091dVhGK2xsM0xWTVJhTFRlamFmYlV0L1ZkTFRiM1d2TGVCU3I4U3V6?=
 =?utf-8?B?QzRVM1l3bUJ2NTIvS1dsUVhGNEpRZjU3U093ZDZadW9jWFN2QXFnRXpwS3Np?=
 =?utf-8?B?d243bE1Vek9OL0tWbTJhQTRRMkJGTStwbUpDRTBtQUsrVHo0SVpyUlFiRlJz?=
 =?utf-8?B?UUJRd2cxU1Q1c2VoOXRHeHE5ZEVteHBQTlhIeDBxY3FmbVlIM2ZweXoyZWlt?=
 =?utf-8?B?azBldEl6Mko1U0VRSjVQTk5pUThjdk5tQ0ZjYWo3UE5Oc3JjaStxM0JJeVpI?=
 =?utf-8?B?Q3l2cnZoampiN1ZJdDdabWpyRlB4SWJocFV6UEtxOGRDeS9ZMUZxUGRId1Bl?=
 =?utf-8?B?bkZpWGxTK3pGQWhSZDcrWGczZEdWY3huUm5NU2NZRzhQVVBXS2wxNTlVeEdL?=
 =?utf-8?B?WDVPNFkvR1Raa0hFZlM0MWlaTExhZ3NZKzJxWjliVVB4aUl3Sy93RUlUM2k5?=
 =?utf-8?B?N0M3NVIvajZQeUcwcVRWeXNKb0dteU53TlZZSGJ4RVdwczFqbFBxakRvSXdy?=
 =?utf-8?B?YXdiSTNVcGxlRWY1aXZWODc4QXgwVjd2cTZYVUVIdzdhV2IxdldRakc0VzR4?=
 =?utf-8?Q?NNQZY8UaTLk00TrA=3D?=
X-Exchange-RoutingPolicyChecked: Vzhh0Tt5gfcjs+iXspYVGDOAZ+qdizqc2bMPVouvT6//VkwnI+Ili4v52SpgvmraSppTT5TkiiM+TTSlhsXwrLlAkzmPJYAg0vL82wluqXRSZL/WcGUH79nmlnBK9GjLOEo+2s1F04LAs8pixEQ4qYNYrX0taqO3wr/exg7GIdVFA2HrwsxZL/Wxf8vKyUQP3OsF26HTvgABDRLVv08KQB8DuDFOVx6T8+rePREMops2WEv8V37D8S4HFbETJnudPf9/lGkEzoXfPkmmgE8S+k7HatV8nHOn1/yByFOfS+bqSH02hpFG8BcKfxZRPd4wHKiLCqnxkVsf3td9A9AX/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: a25806f0-7100-4f1a-6802-08df38a0f895
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Nov 2026 05:20:12.8075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f26GuAm6qCw8o4QSoongXbXa3E5CJ7tJz9htEk7d0K1DqqmXHmlecF7Rr7pf+jXHH24lfy/9Y5/XDyCRcklmQJQgeOpyEqY/c81FUzjaBx8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7895
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


On 30-10-2026 19:59, Matthew Auld wrote:
> On 22/10/2026 06:15, Sanjay Yadav wrote:
>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>> first, and descends every SPLIT block even when nothing below it is
>> free. Range allocations are placed top-down, so they pack below the
>> range end and each new one walks every block already allocated there:
>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>> lock.
>>
>> Track in each block the largest order of any FREE block in its subtree
>> (GPU_BUDDY_NO_FREE_ORDER if none), update it whenever a block changes
>> state, and skip subtrees that cannot satisfy the requested order.
>> gpu_buddy_block_trim() detaches the block while re-allocating inside
>> it, so recompute from the parent once it is reattached.
>>
>> Skipped subtrees contain no FREE block of the requested order or
>> larger, so the old walk could neither split nor return anything there.
>> The remaining blocks are visited in the same order, so the selected
>> block and placement are unchanged.
>>
>> Cc: Matthew Auld <matthew.auld@intel.com>
>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>> Assisted-by: LLM
>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>> ---
>>   drivers/gpu/buddy.c       | 31 +++++++++++++++++++++++++++++++
>>   include/linux/gpu_buddy.h |  7 +++++++
>>   2 files changed, 38 insertions(+)
>>
>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>> index 28cff97d57dc..b77d7f621290 100644
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
>> @@ -772,6 +796,7 @@ static void mark_split(struct gpu_buddy *mm,
>>       mm->free_scoreboard[gpu_buddy_block_order(block)]--;
>>         rbtree_remove(mm, block);
>> +    update_subtree_max_free_order(block);
>
> I think this one is not needed?
right, split_block() is the only caller and marks both children free 
right after, which recomputes the parent
>
>>   }
>>     static inline bool overlaps(u64 s1, u64 e1, u64 s2, u64 e2)
>> @@ -869,6 +894,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>> size, u64 chunk_size)
>>         size = round_down(size, chunk_size);
>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>> +
>>       mm->size = size;
>>       mm->avail = size;
>>       mm->chunk_size = chunk_size;
>> @@ -1280,6 +1307,9 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>           if (gpu_buddy_block_order(block) < order)
>>               continue;
>>   +        if (block->subtree_max_free_order < (int)order)
>> +            continue;
>> +
>>           block_start = gpu_buddy_block_offset(block);
>>           block_end = block_start + gpu_buddy_block_size(mm, block) - 1;
>>   @@ -1881,6 +1911,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>       }
>>         block->parent = parent;
>> +    update_subtree_max_free_order(parent);
>
> Since mark_free() now sends it up the flag pole, maybe move the 
> block->parent = NULL before mark_free() to prevent that? The update at 
> the end here should be enough?
Yes, done in v4. With the block detached, the updates stop at it during
the trim, and the final update from the parent fixes up the ancestors.
>
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
>
