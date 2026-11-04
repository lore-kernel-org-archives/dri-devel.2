Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D1606D80A
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 12:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lMVZtswq
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9B6D710FB78;
	Wed,  4 Nov 2026 12:13:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 670CA10FB78;
 Wed,  4 Nov 2026 12:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793794387; x=1825330387;
 h=message-id:date:subject:from:to:cc:references:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5jWe4pTg7wTP6UPXOHTmn7eZiB5j0xNRm9aWc/CK1fQ=;
 b=lMVZtswqvLQcGUkC5+eKyY/+k0hDmpoToTAi4Qq2Kz3tu4kuCM9vDpuA
 +g3UYLArc4Gc69gnOMvjEuW4cmGk5SVAV3giv30SY2MTb+mgmjSfyKUhl
 AMBX9o9PqvvW05Pgm6SQuCFYa6YBOQYfVvPzpFNYJiPo6MpR//b2kxbFh
 qODY+zJ1A6K0H+F6F9bj2lEeEnmLsMDMjvo681D87fSC+LEfMqWqxALiU
 oVVIVwkMh8UTfX5380v4gRcXtWoK5PugrS7fxnX27TcBDRyyvdYmVu4e4
 NLjxt4JXI9MvYIxo4mvkTVgSqmd55g+G75eIz9FPuVxsKHgvFBuG1WLXX g==;
X-CSE-ConnectionGUID: zRCeK1zzQ+eiOWCUxo3A6Q==
X-CSE-MsgGUID: Xzq7WWHnQaGZGu9WEVvjaQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2648900"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2648900"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 04:13:06 -0800
X-CSE-ConnectionGUID: liM18EZ/QouvERRKbpyzTg==
X-CSE-MsgGUID: XspxwqwDSfmsppT6dJQiWA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6555035"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 04:13:06 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 04:13:05 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 04:13:05 -0800
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 04:13:05 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aa3pekCsv8FRNLH54M1rD6J5iBtk9qo8pRU+HHE3P2J38TSVfEaPMTPfbI/ilF1UuM3G5XPNmTny0MNciQQp46SbMktG24XCXpClks66lF2yT4QRvsiCxXIfeghKot2sP4HfICdsTpPvFvO7pgSOD9OCI92PtXJKLrg4u8VM/Jkgzqx7jiJv+tZ9axPQ32zGMGLiMSMlqRfvMRFuIOvpf5QF/VCcQj/b+3iQXDmhRWlX1jTp6BBwABL2+n0CrUCyCl+C/alaazDWUl5ZAxNRvQhVqZCJv9vB3s8+NrDck0jSmHjlr81SnJEdEECvijPX2zjkn54vhnAvhTR2AGjSfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LEJBhKjpIvvl1tPuhvKRUwcsySvs3slmmVmndfwNhSA=;
 b=f8WpD/k826F2LK+uFXHsxjmmeZWymErc7kA5S54ps+UcTlqUJb8ENPQpDfLynjM9ZdXDoJKl5Hxu6HpafpZDeznqxx3OiQgScYkcMz6ekRk4xMfu83boCKbQsv60XDHrP2kZW5albKAvX15ar7waBFFG74hX6qLYm8D08KP50wNkmj9i0+sWYN6okWhnekoZJEMLREAJKkA0dB713Ex4bhSP0PLvORI9HafRE9LrrLgIA3xC6XdJIScgfM36o5xygVPY+F7XemFHDSCS0K5WFvt/3KhjdVFEYKCgtOaAg9II8RrN19iDPbIm80TefIy4BGxhbB9IUNBeD2U2aCE06Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by PH8PR11MB6880.namprd11.prod.outlook.com (2603:10b6:510:228::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 12:13:00 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0592.007; Wed, 4 Nov 2026
 12:13:00 +0000
Message-ID: <e87c786b-ceb5-4907-b215-ef276910392a@intel.com>
Date: Wed, 4 Nov 2026 17:42:52 +0530
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
Content-Language: en-US
In-Reply-To: <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA5PR01CA0268.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::17) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|PH8PR11MB6880:EE_
X-MS-Office365-Filtering-Correlation-Id: 338d97c1-690f-471b-51a7-08df3a6cf7d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|5023799004|11063799006|4143699003|56012099006|261021121427099003|261021123027099003|261009223027099003|261102123227099003|261102130727099003|261022105027099003|261026140227099003|261026121527099003|261028144727099003|10067099003|18002099003|22082099003|11062099010|7136999003;
X-Microsoft-Antispam-Message-Info: guJhUpzuohwnjbYZJXIaBnMS9RLONyJ5U6rAvMhQo+4+05RkK8rXG1k/7rC5g6pe/KnemjR6LNHhwNnUbmy6fSwnN6N2cah4VLBAzFV2krtkJjWbpgLp5wbWc7odyNxHlCuZDKd/cWs+hfpW54UR3oZ6nf0W1VaWo/hNBRZbsMY7Ig/iDN11c1EKfMMupdUKT/e1jsiWQzXIh+o1AyilgCk2sExrFzyx8L8pPi6QoFovO9X7zT5g/gg9DjSVw156RTZJEdIt+gw7OukiOST5R2yJDPErc4L4k1JD3HUOdra8olAFiH6mEHdGcx34WgWn4Ho9RrG4I8Nmc4QTT7LJPq/nneosIuXRFcLJyJgzo8P7nY/1l0xXkYf3fSnq6oU9dAWnp0AYfLcYxsgVVBV+5QkefpoMu6+PaWaB3OXgR3vxKbJCzX8pzDIYyrapw39H/xc7mqz9IXUZHzxbGP8375CO+4FP/YpyyIIibQFTDTVFC/HA3afkbPcoyZuZI37VRlaaaFa7U6iTcHmjG4W0Mni+Oxu1kbRtR4S+i1FqKzj3Rr7Ezfo/oLrjfa9AJORAJQsLACXMkcrcBXvkOUQ7oXnRqrIXJeRfOpdTx3MWVyubUv+K9lFkUkZLhW8R+uLrUm8NsABeY3S4HcNvtwPFiRWjUsmxjVDvSqeeaRtWg2Y=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(5023799004)(11063799006)(4143699003)(56012099006)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003)(261102130727099003)(261022105027099003)(261026140227099003)(261026121527099003)(261028144727099003)(10067099003)(18002099003)(22082099003)(11062099010)(7136999003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bnJqT296emZ3NTBQT0ZHV0lxdEJuRFl2SkgrMkhOS3kwVnNrVDAvSEtaakYx?=
 =?utf-8?B?VmJHamlhWk9sa3hqeDhZWVF5MHVaMVdjaUdrNXh1bXFIUE1ocktPMEoxTWRx?=
 =?utf-8?B?azBJbnU3ZmtycElUZTdiNGxrejhOQ1UrODcxUFlIV1VaM0R3NC9zQS9UVkc2?=
 =?utf-8?B?Z2h1cWMzczg1clQ0bklVeVFvZzJkc1FMUFNJaUlsZWdGbUpuVkV1SkgzLzV2?=
 =?utf-8?B?bGJ1QkxvTE1BUy8wa3o2TlhFclFKM2JFbjJUZmpZbHdSS1lGbytrcGh6VnpG?=
 =?utf-8?B?cUxnSGs5ZjJHZS9HSFkwSHhkU3RmcDEyTUhqc1IrUXRreUNHNy84a0EvT0N2?=
 =?utf-8?B?UnlScFA4cGtackVKb2FYbnhtNlkvRXVOV0trd1hvSkRtdXhuUThuNzE4NG5m?=
 =?utf-8?B?NTQwcmhMSFQzMnFuWTN0dHFycjRyQVV4TjE5ekVYdzFhWHJPSUVMRDA4RDlI?=
 =?utf-8?B?NU9lbTdKRWg5S0FOM2x3dXlpSEZOS0c0OU5oY0x3MGphSmo5ZHZndVphQnlC?=
 =?utf-8?B?RUppZGJtNjFROVZ3QzA1NSs2bmhsaFBGOXp4VHJndlg0d2V6ZEhpenI5K1Jy?=
 =?utf-8?B?NEY4NTNyUVpxc2tpSjN1RHl3TEd5UzJaNVZZYlJSV1VUeUFEeVdQY0J4RlEr?=
 =?utf-8?B?bHFpMkpreFY3RlpJVDFreWRpeHovaEJSNit0UGVGejFhTVF3NnFLQ0xFb3Vp?=
 =?utf-8?B?ZndrN203UFEzNk5YVkVVVzBtWnkwbFI3TmpHN0VUKzlTcHpSRVA1R3d3Qmtx?=
 =?utf-8?B?dlRpSXRuY241M3psckNqOXArZjhkQUpNcmdPOWliUEZWRVhHcy8xaU9sVnlF?=
 =?utf-8?B?OHpabHBKeHBLM3MyUVQyNTNITWk3WU42emhMclpUNE5Sc01KYVNHeU5ieUFL?=
 =?utf-8?B?alhDUjhRM2c4VHMwZjhzcFZNaERsK1B4cUQ2UC9TaFZxbVBWeE1uZExBdTR4?=
 =?utf-8?B?ai9jRk9hZi9MOTkvT000WnNnMzBIZlVkcTZoWFE1OWJkc2cxd0Z4Vk1zN25a?=
 =?utf-8?B?VE9jS2R3UG9Vb0NhUHpFcjNGSTNyMldBMEczbnRIaFhrOEswM1BsdExxbEUx?=
 =?utf-8?B?WUpnSGsyeGN6aGdscmhGWDBtczVjZ2ZYSkF5U0xhY0N3U1J1UHRuajNZQkxu?=
 =?utf-8?B?QnprKzBQV3lveVMyaUlIaW5GemJMdThXZE5ZYXc5bnZjQjZPSlJLNWY5NHhn?=
 =?utf-8?B?STFGS3BNakl5QXlGVldtdTdwT29uM1dDYnRxSmVoVlBGTjA5TjFTR25PVm00?=
 =?utf-8?B?WnJBWGl3R1VDZTVxT3UvOEJKY0RTZ0Y5ZWl2NHdTWjd5dmI2bnNSNFBmc1hP?=
 =?utf-8?B?VUdCL1JjWDBDalQrb1BINS80MkI1WkpwVTJBaWFFU1oxalJiTHBVUW95OGZG?=
 =?utf-8?B?VmhYMCs5K0lqU0FiQkptWFByU0g0Nk5QeTlVVWE1dmR5ZHhpQk04VUVaWTRZ?=
 =?utf-8?B?dmlLQUhJWC9CL0tIU29hUHM4YlRTUlh6b2NlU3M2UjlRMWdQcDV3VlhLcVdT?=
 =?utf-8?B?S3ZoMHdlMHhibC8wTEpESHF6Mll6UzkrTldyZGdsYzB3RUtQNmpaejRxRGph?=
 =?utf-8?B?S2xwLzJ5Nmo5blNNV2JpV0E5b2JCOTQ2ZUFvSXhrUVRVTjhZQnd0K1BLMkw3?=
 =?utf-8?B?T2dqOTVWd3NGYVBSQTF5MENtTk5jRDl0aTVuMjY0NVU4T0ZlZGs5cnJhWGJJ?=
 =?utf-8?B?SUlyQStrVzZkU29CVElNTFRlYW14Y1JTaUJvQVBmbWNMNmJQMUx6eXhmaHdQ?=
 =?utf-8?B?TjVEdGdsSGhtbFU0djdYQk5hK1E1YVZTcDlqemJmdCt4TnV3cEM5UXFZbzR2?=
 =?utf-8?B?K1BVMTkvcWFlUGM2dFY5V3RRZnVFbUJGNU1GMjlOb1BRRU0wNkNhMnNkL3Jp?=
 =?utf-8?B?V3UzQSs5Q0h6VWROUnkrWVhabkxQbG9tUTRqUEtnS1lYOFNRMkVBcnAzaWMr?=
 =?utf-8?B?RkZ5ejJkcFczbFdUdndzbnV0YmhFd3VGQmhTRjZpVmdBaUxNQTVZU0syOFhS?=
 =?utf-8?B?dDVsOUxBcHE3dzJ2cXBBemsydU9Pbi8rSVVGWUs3YUxtM0NFOThZaEw1Rlhj?=
 =?utf-8?B?SDhlclRtSC94dHlqUmg2d0NNNTBFd3lKNHlrSWY2S0JpMncwK3UrYklQa1Vl?=
 =?utf-8?B?UGVrRVUzRkNjckl3eUlCZTlqRVIwdmVlSXNJWjA5b3JkaHErVWFTVG9JN2lH?=
 =?utf-8?B?VVdXVnVDWXh0dVR1em8wMXZUTGhQVDdqcS9nME45eU1HUEFsQXJYR2lhR0J1?=
 =?utf-8?B?OFdEdlhnVk5MbzlweDNPT3prOTlqY0JuVkNGUVRxU091ZzRCTTNYWk9DL21o?=
 =?utf-8?B?R3JJeUo2QjJiZUl2eWl4RzMvNVBJSEpUSCt1Rm1vUndqV0tJRGJkbzZBZGxn?=
 =?utf-8?Q?QmCx+0mFx124wCDk=3D?=
X-Exchange-RoutingPolicyChecked: KRjLNN7mCRARYETwK1PmNEDh2Xh0Alq6j7P9ILAYHryZPgjPxdLoB9VXaBsS1fpnS8ITHxqWe+fJSn6VcpUKsbKfWmSdIb/p0Rt+lr0A5VmjHB9Od24YsV0Z5Gs+PI+KOOYh09JQFVOlwBsrTjj18E6yYqgwkuGt1iNvddoUu3KS6tNdE0CNf6qTydm7GdU83pjBjiwn/md68UlOWSc84p+XEJq/5EFiTi2v6ewBQC04o3rajb1wF4uTSaQ/Yt9JQPO7i4t0scKnq9yRhUni3wDpdQ5lNyL51Vs7bCeCjVwFAZ7XZSbPihlN5gbrav6LYxghVRW4vYEwknG23/1wOQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 338d97c1-690f-471b-51a7-08df3a6cf7d0
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 12:13:00.2750 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SLrewq6Mr8urTYY9Xz29I/zdVQbu0PoPMrY5WG6a2DtFAIx04x+NEXvtlkqnJ3NQxb8WSrssGf3BVQK+nwrO/V9MjPo+O0b12DGczmbfVt8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB6880
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


On 02-11-2026 10:46, Sanjay Yadav wrote:
> __alloc_range_bias() walks the buddy tree depth-first, higher address
> first, and descends every SPLIT block even when nothing below it is
> free. Range allocations are placed top-down, so they pack below the
> range end and each new one walks every block already allocated there:
> O(N) per allocation and O(N^2) for N allocations, under the allocator
> lock.
>
> Track in each block the largest order of any FREE block in its subtree
> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is allocated
> or freed, and skip subtrees that cannot satisfy the requested order.
> Splitting needs no update of its own, as both children are marked free
> right after and that propagates the new value up.
> gpu_buddy_block_trim() detaches the block before freeing it, so updates
> stop there while re-allocating inside it; recompute from the parent
> once it is reattached.
>
> Skipped subtrees contain no FREE block of the requested order or
> larger, so the old walk could neither split nor return anything there.
> The remaining blocks are visited in the same order, so the selected
> block and placement are unchanged.
>
> v4: (Matt A)
> - Drop the update in mark_split(), the children being marked free
>    updates the parent
> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>    only the final update from the parent propagates up
> - Drop the order, is_allocated() and is_free() checks in
>    __alloc_range_bias() that the pruning check now covers
>
> Cc: Matthew Auld <matthew.auld@intel.com>
> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
> Cc: Joel Fernandes <joelagnelf@nvidia.com>
> Assisted-by: LLM
> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
Gentle ping
> ---
>   drivers/gpu/buddy.c       | 56 +++++++++++++++++++++++++++------------
>   include/linux/gpu_buddy.h |  7 +++++
>   2 files changed, 46 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> index 28cff97d57dc..93f70c98b235 100644
> --- a/drivers/gpu/buddy.c
> +++ b/drivers/gpu/buddy.c
> @@ -602,6 +602,7 @@ static struct gpu_buddy_block *gpu_block_alloc(struct gpu_buddy *mm,
>   	block->header = offset;
>   	block->header |= order;
>   	block->parent = parent;
> +	block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>   
>   	RB_CLEAR_NODE(&block->rb);
>   
> @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy *mm,
>   	RB_CLEAR_NODE(&block->rb);
>   }
>   
> +static void update_subtree_max_free_order(struct gpu_buddy_block *block)
> +{
> +	while (block) {
> +		s8 max_free;
> +
> +		if (gpu_buddy_block_is_free(block))
> +			max_free = gpu_buddy_block_order(block);
> +		else if (gpu_buddy_block_is_split(block))
> +			max_free = max(block->left->subtree_max_free_order,
> +				       block->right->subtree_max_free_order);
> +		else
> +			max_free = GPU_BUDDY_NO_FREE_ORDER;
> +
> +		if (block->subtree_max_free_order == max_free)
> +			break;
> +
> +		block->subtree_max_free_order = max_free;
> +		block = block->parent;
> +	}
> +}
> +
>   static void mark_allocated(struct gpu_buddy *mm,
>   			   struct gpu_buddy_block *block)
>   {
> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>   	mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_remove(mm, block);
> +	update_subtree_max_free_order(block);
>   }
>   
>   static void __mark_free(struct gpu_buddy *mm,
> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>   	mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>   
>   	rbtree_insert(mm, block);
> +	update_subtree_max_free_order(block);
>   }
>   
>   static void mark_free(struct gpu_buddy *mm,
> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 size, u64 chunk_size)
>   
>   	size = round_down(size, chunk_size);
>   
> +	BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
> +
>   	mm->size = size;
>   	mm->avail = size;
>   	mm->chunk_size = chunk_size;
> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   
>   		list_del(&block->tmp_link);
>   
> -		if (gpu_buddy_block_order(block) < order)
> +		if (block->subtree_max_free_order < (int)order)
>   			continue;
>   
>   		block_start = gpu_buddy_block_offset(block);
> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   		if (!overlaps(start, end, block_start, block_end))
>   			continue;
>   
> -		if (gpu_buddy_block_is_allocated(block))
> -			continue;
> -
>   		if (block_start < start || block_end > end) {
>   			u64 adjusted_start = max(block_start, start);
>   			u64 adjusted_end = min(block_end, end);
> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>   				continue;
>   		}
>   
> +		/* Not pruned at @order, so this block itself is FREE */
>   		if (contains(start, end, block_start, block_end) &&
> -		    order == gpu_buddy_block_order(block)) {
> -			/*
> -			 * Find the free block within the range.
> -			 */
> -			if (gpu_buddy_block_is_free(block))
> -				return block;
> -
> -			continue;
> -		}
> +		    order == gpu_buddy_block_order(block))
> +			return block;
>   
>   		if (!gpu_buddy_block_is_split(block)) {
>   			err = split_block(mm, block);
> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>   					     gpu_buddy_block_offset(block),
>   					     gpu_buddy_block_size(mm, block));
>   
> -	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
> -	mm->avail += gpu_buddy_block_size(mm, block);
> -
> -	/* Prevent recursively freeing this node */
> +	/*
> +	 * Detach the block to prevent recursively freeing this node, and to
> +	 * keep free-order updates from propagating above it until the trim
> +	 * is done.
> +	 */
>   	parent = block->parent;
>   	block->parent = NULL;
>   
> +	__mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : GPU_BLOCK_DIRTY);
> +	mm->avail += gpu_buddy_block_size(mm, block);
> +
>   	list_add(&block->tmp_link, &dfs);
>   	err =  __alloc_range(mm, &dfs, new_start, new_size,
>   			     was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>   	}
>   
>   	block->parent = parent;
> +	update_subtree_max_free_order(parent);
>   	return err;
>   }
>   EXPORT_SYMBOL(gpu_buddy_block_trim);
> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
> index ddc4eca84175..8037f5a0feb1 100644
> --- a/include/linux/gpu_buddy.h
> +++ b/include/linux/gpu_buddy.h
> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>   	unsigned int subtree_max_alignment;
>   	struct list_head tmp_link;
>   	bool has_clear;
> +	/*
> +	 * Largest order of any FREE block in this block's buddy subtree, or
> +	 * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver lock.
> +	 */
> +	s8 subtree_max_free_order;
>   };
>   
> +#define GPU_BUDDY_NO_FREE_ORDER (-1)
> +
>   /* Order-zero must be at least SZ_4K */
>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>   
