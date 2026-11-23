Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC2B606A31E
	for <dri-devel@archiver.kernel.org>; Mon, 23 Nov 2026 07:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dKrq7Bzh;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=nDZHp1Ia
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0C2C10E604;
	Mon, 23 Nov 2026 07:50:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3CDC010E519;
 Mon, 23 Nov 2026 07:50:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795420222; x=1826956222;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=i2qpvMv5TMUdY212GqWO/iV/ki00bnbjrdOYyR/Cy+Q=;
 b=dKrq7Bzhxjifk7rJ09Msv9pCDTrWNZr+sc50SKW8oUKI8lvSul5j0vMC
 Nk3IZ0LloE2iozu49cZI2ORxrhehBerJxXCCezKnSYpJj8H+JgjFoJMPC
 /mEuq45NA38MFjoRFgN61XEZIo359LjR04bIO0fCVLxbU5S3zCsJdLFQJ
 FluSzcmoqfqbIzOyhO44cbOkqhYtVBtjfFeUxF2+FwefWY42ZbRXPyEbn
 gXp6hYh/JPjPUXwNf4nzhngvlaVGMF+25gLCzpPig+cbQizOrpEpAxI/A
 t9HBFGu/QD5U6cQGFLQW4Ms3Dbp4x4Rgj4i2Y0Ar934rzXbjihwgCwUId w==;
X-CSE-ConnectionGUID: 5vymglGLS9OyT3G+nTWFdA==
X-CSE-MsgGUID: c4dJp26lRQO+q1zk4fYoTw==
X-IronPort-AV: E=McAfee;i="6800,10657,11974"; a="4218161"
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; 
   d="scan'208";a="4218161"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:50:21 -0800
X-CSE-ConnectionGUID: 5+xFwpmCSvSb6vUBvrDCBQ==
X-CSE-MsgGUID: P/W7bpUhSAyDf7qNOjgv6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,227,1787036400"; d="scan'208";a="11183003"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Nov 2026 23:50:21 -0800
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Sun, 22 Nov 2026 23:50:20 -0800
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Sun, 22 Nov 2026 23:50:20 -0800
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.9) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Sun, 22 Nov 2026 23:50:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uwaIxNgYBhjlQIJ53H+NdZvsMvX7cfI1wYUFvr42ODzDmAsbALsU5YB6QaXDAPCPW9j01U47eFpjkb8eYtQLqgNH8fnn0/5TZTN5EOlwtfluDONQwbPKvQWZxX+KpwRgJ6Ar66PPLmkVsEghobUYic1tBxPro6Y6/3yQfxduWMEwhxwkzk32gDF8DmsW74BQLEH36m7PWkAekFT+3I/UrEPsTg5IukMuiTIW+DTE8SdFn2gDqatXvjHojLkcuc5M8BfIuABK7nw+FU3tZhpJG1iCMA5rn6xIhCKRZSC79ao2bHson+6M6YbFTF9f8W/TQotctgJR9Spy0YLBGOrHBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EHLX7o32M9B5YnvfejIy4Mwq9c34C98QvOioqtXhwAI=;
 b=rD4erwYKvinsWK1UBmBEd/1mTVni3cjnRZtRmhdA4nJjZvTL+WrWVoadyzkEGac5qbuhfqP/LqStn2JK1HT9dl13bwNhhtUv5k5EPCpvYQS4NNe3CkhnuS6EL51rG0c77n8p/0OovS4W9Y0cpXB/TKGfLjx3QI3RT2GT2WL2+i+9lTIrjxTvz4DkmoSswt11Po1nmaaI1g1Cn6Kk4vsMKckIz3cp0IaHJTzlXZW6k9tBJ+kCIDWDovJ7MX3ldB37meh5ej0nrNtro6ItwhZL3JPgX3PnjheEwkyiIRUKvnuTb2RwonRhCnP/HNfuqw/cuFBiWtCzJrF7Jpf+YtIwBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EHLX7o32M9B5YnvfejIy4Mwq9c34C98QvOioqtXhwAI=;
 b=nDZHp1IaSsM8rZtUDD72xP2syKUVCT4as08nxc1ll513ZYO6Ufh4TgdLsvyooB/jnQS/JgxdSO5CEMR9cKOUzZAK3hLx/gIvF2XjO+Phh8fM1yfrW9WjFF5xMcIpzPWSIo8469DDj8mo+J3WJYKy+EmyPNW3OJqSsRNnEo2dnyk=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11) by DS7PR11MB7737.namprd11.prod.outlook.com
 (2603:10b6:8:e1::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.13; Mon, 23 Nov
 2026 07:50:11 +0000
Received: from LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c]) by LY0PR11MB357627.namprd11.prod.outlook.com
 ([fe80::71fd:d139:945b:a71c%5]) with mapi id 15.21.0639.012; Mon, 23 Nov 2026
 07:50:11 +0000
Message-ID: <fb37a5cf-83a3-4d91-9086-804c0913755d@intel.com>
Date: Mon, 23 Nov 2026 13:20:03 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/atomic: Prefer drm_WARN_ON() over WARN_ON() in
 drm_atomic_get_*_state()
To: Ville Syrjala <ville.syrjala@linux.intel.com>,
 <dri-devel@lists.freedesktop.org>
CC: <intel-gfx@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>
References: <20261119234423.11666-1-ville.syrjala@linux.intel.com>
 <20261119234423.11666-2-ville.syrjala@linux.intel.com>
Content-Language: en-GB
From: "Borah, Chaitanya Kumar" <chaitanya.kumar.borah@intel.com>
In-Reply-To: <20261119234423.11666-2-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0052.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::13) To LY0PR11MB357627.namprd11.prod.outlook.com
 (2603:10b6:404:21a::11)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LY0PR11MB357627:EE_|DS7PR11MB7737:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f86fe47-8cab-4e14-3cef-08df493666f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|376014|366016|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261026140227099003|261022105027099003|11063799006|4143699003|56012099006|10067099003|22082099003|18002099003|261009220027099003|6133799003|261009221227099003|261009223027099003|261009221727099003|261009223327099003;
X-Microsoft-Antispam-Message-Info: zdOFLKjDLPwi6Iny5gdbWTDF2lz23Utn8IawODLyqEU6O4UC+LhuS9/1g2CZDusyHoqyNGZQJq1buKPPPq+t5aQENj1kxEgH6kgO166+/RpdzA3E66eM5ddAWSLl3tR7x9/OIUa0RR7wy+mWmDcJ00NyXxIefN4TGGyJoHctjuHCvyIyqTdCZ9qbYirRD199dt8Ot5aueC0T+oPbVsKdZUSy/Ay6G305ecTIkzgHmpSwVJQPvEQpcpW3vTCsiNBUX4E1UOgRRdQIs4lm449v+E7Ew4br5eZDNb8mMLamT8Xme8Bxmx6lCgBZLo1fd4pxLLvLo/eGF0sloRppr1ieWLBVUAZg2GWCHy86G/i0qbK0h5k60rqJ2plMQL8J1zZTkoPYOf35VK9ow3mpgZU75RhMaSog3fvjbAkwdjBOkYXeptNuwYpccyoTu/EsgQxKLza6j8SNjrencQHxOoKSd6+l4r+9VsVDxG4dq4d3k5aX1qdFQ/8ISnXQJT08hjnJ92l/yd8mVPHwG5iYoue0P+eBX2xmO/Mq+PXioeU4Zwer5M6WDTs6sT+JZ0nyOZsY3LHVc4qHTFV+vVRt1hwenUugkMG9W0DGS0MC9OnSDh7ptWu4PaiXmEd2Tq4Gh4G3aMG9G6z5OTLGZx7stZqrDRgMopLTwcnoLLcqH42F4ik=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:LY0PR11MB357627.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261026140227099003)(261022105027099003)(11063799006)(4143699003)(56012099006)(10067099003)(22082099003)(18002099003)(261009220027099003)(6133799003)(261009221227099003)(261009223027099003)(261009221727099003)(261009223327099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VzBJdk1GVHZ0UXlCZmtHNlhqdHdTa1ZMWnEzUGoySDEwbEVwMkdPQitKSzFU?=
 =?utf-8?B?dkpETUJ0MnlqSFlsMXlacW9SZklkNCtBbmRmUTJLLzRkNi8wL0VyMTdzMWFh?=
 =?utf-8?B?VzUwaCtBZWF4U1lkeFlRWVpGNksrVE56eEkzU1Irb0N5dWpnZ3FyRU92Z05K?=
 =?utf-8?B?UjdEVFpsK2Jsai9BUDhEUkk0OVBVNnZEWG9weTdISzRXVm16M0R5dFNkN0xC?=
 =?utf-8?B?a2oxNzgvY0d5YXFXeXpGeEJsbUNSUGczNXVva2Z0TUI0elFtZW0xSzd3RnJv?=
 =?utf-8?B?OGhYTGdFcUN5eXJKc2V0SG1nRUFaRks2SitqMVM0N2N2cEthdzZiNW5oblhy?=
 =?utf-8?B?TG9yM2ZzMUJPRFoxdmE5MTZIYkdRUGU0eEV4Ry9zSVg5VUQvQ1Uwa0p3MG82?=
 =?utf-8?B?NU9TSnFtY2xnVStDUEcyaEJVTURCeThLa3RZd3U2cG0rcXoxMkJSbmlXZDE2?=
 =?utf-8?B?UU4rWUhYOFQweTBjYXJRRHdBUkRXUXpiaS9CaWJicWJSanNzRFRCTE8wekVQ?=
 =?utf-8?B?eVF4OXRHRDlFb1BralhJMFd4RVl3NDVvZHorVmozNzJxY0xlTDBCYkd5Q3hR?=
 =?utf-8?B?Z3RnS1p6YS9GSkxlejhlNzhna2dkMzgya3lHN1BsSTBncVVDZzJPajdkWTB1?=
 =?utf-8?B?ZkpNMFFrQzUxSStvYlplSlluOFRNby9Ya2hGOWRwNjlqUkcxTGZBYkR4U3Vm?=
 =?utf-8?B?aUJwYUJ6RENCa2thQVZZS28wVkcvTklwbS82Y2ZGWlJnSDUwbEFEcXdKT3pK?=
 =?utf-8?B?SFZSa2ZSRTVXOWdIVFZoTkViYVdHT2ZZcWFNa3FRZyt3QzZIZThia1R1ZDM1?=
 =?utf-8?B?QzhISWRoaXZnZUE5d3ZFMmU2ZW9yK293YWNLR0V2ZGFpZmREMWEwa3dLUFU0?=
 =?utf-8?B?VUJwMEQ2WFRrYVpJdmpOZTB3czdNNHpSUDE1MHFnYUZjNkpOcHZlNHFoRzF5?=
 =?utf-8?B?ZEMydjg2eUdrY2J5NzhRSjRQWmNQazQwTlVYczBweWNsaEl0WFBXa04rUkti?=
 =?utf-8?B?NVdmSjBTZEEvbFZ1d2hkQlNNRDNsS0R6RUZDQkZSeWVtU3c2bzd1UzFqWXAw?=
 =?utf-8?B?T3BLcTlCTXZiOVBLYmp0WmZYSVdwWk1GSG5zeHZiK3VQMmQyakFPN2FoVFlv?=
 =?utf-8?B?NW5EZW1XWkk0WHBHZkdMaW9SQXQ5N1A4c2diNm40UnB0ZFhEWjhHUHJDbTI0?=
 =?utf-8?B?NkJjSmJCbE4wNjJVbk4vOXNQTFRCb3dFNU80RzVGNEtYM0VlQktrM0JkRlNT?=
 =?utf-8?B?R2VxSW0yYzF2RWthQkhOSC85STc4UGp2Zm5DVndwSTE3eUc3UXh4YmQwOElw?=
 =?utf-8?B?N2tnTFJ1a0trQmNpVkFiM3p5dDhvUUpwNlVudWh3KzkxQXladS85YXRwNTBE?=
 =?utf-8?B?a3JhUG1ocGg3STU1Uk5tSVdjQVNYM2VRN1p0RHgwUWRLc2pDd2JWWmJIUUtt?=
 =?utf-8?B?b0lxcUlOUkxXOHFxaWs1NkgvTXhJTnZnMjJhcUMzT1hPaVJjY05iQ3JrQ0NK?=
 =?utf-8?B?Nit4N2tKVmFZbGlkSURzN0paclkreWtFWlE2ekdaMmtXTWlyM2JyeHplOTVr?=
 =?utf-8?B?cjFoQm5UMG9mdlh3QzJQTndsZHlGZmZpcTJYTVlsdnVRc21WUU5WamY0UnV4?=
 =?utf-8?B?bGtRZXorNksxTHBDMDlZSG5GMEtUVk05NFovb3ZnUXdLTUZFTTFlKzJmV0h1?=
 =?utf-8?B?aVovQVQ5V2pPdHhRWXRWbGxNQzBTaWxPVndOK3pNS2NHUFdZR1dXbUg1UXNt?=
 =?utf-8?B?ZmIxVEU5ZmkyNDdjcTlySVB3OGVsQmJxazB4blZjVnNxOURLcDNWb0JHVE9z?=
 =?utf-8?B?b3RXL3B4RTFhNjYrSjk1bUlLT2t0ZFJCYWpzbmpSYitCMW90OVJXWUs3eXFD?=
 =?utf-8?B?ZTIrSEtyaUhLTVVYU1dRZVRQY2hzMlQvT1B2MlBQSWhlZjcrUm5YWjZmK3N3?=
 =?utf-8?B?RUlRRmxtc1ZNeDlESEU1aHBSUWt4NStxeTRDNE03N3hLcWpHTWl4UElMZXE4?=
 =?utf-8?B?SGhqMFhSWHNBNVBPTVpKS3djNGR5ZFhiQmVmU2dNaFEweXVkWDkwSWhaOVhE?=
 =?utf-8?B?dzhTR1BiY2dpZWh3SWJkZVlqOFdyY1k0bFFzSUd4NFF2VW5JMzcraFMyMTY2?=
 =?utf-8?B?Q0VHczRWUEJxenFEZ3lrd20rNU81QWpDMTZhWjh2NWtJSTBQL2NGTWhqRUdz?=
 =?utf-8?B?Uy9neGUwb3JGK2FEazMyYTJTYWxwYnRHaTFDTlFCQ0lrNzZhZkliU2lhYXBX?=
 =?utf-8?B?L2MyUEVDQTlqRnZrWXRZS29RZmJ4ZnVFeXhSTE82c05HTFk5aGJCT1RCTHN5?=
 =?utf-8?B?b3NDN3I1ek9vNFkzMi9URVJydVd2YlIvdE53ZHlLQ3VPR0E5Q1luN2x3cVp5?=
 =?utf-8?Q?QVNbdSkDiMmJTD4k=3D?=
X-Exchange-RoutingPolicyChecked: RTIgkQJiqf8eFiYknPQNb3CSoSMVfHhVxcsAbK/meVxyMCjMa5V+7j9yj2TgMwNDyUf+WOaLUGAaqWnRb1pCIcG3MV2AlLVC+UyggrLuDJbfu61vVA4ToGNZiL3p+aYQic33cna7H7QVmJQlxg/ntepNc8YuLJReyQiAMoe9rpjriTPsGTjZH0PC0w5PaSPSHfjWYywEc0poiww8EwoN5lHUoifb/9wud11KvIFNagC4u42uUI7sJffEcTavZD+slYCANpzaRZYun9LUcrMNHzw5XQkGhnfjmyJ6Ta5Xp4xTJ/MeEEbejo339no4Rn5nWnra1Dg743tqkaNv5iYFGQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f86fe47-8cab-4e14-3cef-08df493666f0
X-MS-Exchange-CrossTenant-AuthSource: LY0PR11MB357627.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 07:50:11.7004 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SHzPMOPjgXVAZlumyUbGUm/vdEYL7JFdrnyq2Z1ZUKuL+Fy3FH0NzB0BMcPBMXVCSGRDUHBUysjWhRhs4c+G+BBlBa3f+Tm0NC1/GQYxvXQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7737
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



On 11/20/2026 5:14 AM, Ville Syrjala wrote:
> From: Ville Syrjälä <ville.syrjala@linux.intel.com>
> 
> Change all the get_state() acquire_ctx WARNs to use drm_WARN_ON()
> instead of WARN_ON() so we get to know which device triggered it.
> 

LGTM
Reviewed-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>

> Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
> ---
>   drivers/gpu/drm/drm_atomic.c | 10 +++++-----
>   1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_atomic.c b/drivers/gpu/drm/drm_atomic.c
> index b0843e5a9e4d..324e79152e17 100644
> --- a/drivers/gpu/drm/drm_atomic.c
> +++ b/drivers/gpu/drm/drm_atomic.c
> @@ -473,7 +473,7 @@ drm_atomic_get_crtc_state(struct drm_atomic_commit *state,
>   	int ret;
>   	struct drm_crtc_state *crtc_state;
>   
> -	WARN_ON(!state->acquire_ctx);
> +	drm_WARN_ON(state->dev, !state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
>   	crtc_state = drm_atomic_get_new_crtc_state(state, crtc);
> @@ -666,7 +666,7 @@ drm_atomic_get_plane_state(struct drm_atomic_commit *state,
>   	int ret;
>   	struct drm_plane_state *plane_state;
>   
> -	WARN_ON(!state->acquire_ctx);
> +	drm_WARN_ON(state->dev, !state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
>   	/* the legacy pointers should never be set */
> @@ -741,7 +741,7 @@ drm_atomic_get_colorop_state(struct drm_atomic_commit *state,
>   	int ret;
>   	struct drm_colorop_state *colorop_state;
>   
> -	WARN_ON(!state->acquire_ctx);
> +	drm_WARN_ON(state->dev, !state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
>   	colorop_state = drm_atomic_get_new_colorop_state(state, colorop);
> @@ -1144,7 +1144,7 @@ drm_atomic_get_private_obj_state(struct drm_atomic_commit *state,
>   	int ret;
>   	struct drm_private_state *obj_state;
>   
> -	WARN_ON(!state->acquire_ctx);
> +	drm_WARN_ON(state->dev, !state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
>   	obj_state = drm_atomic_get_new_private_obj_state(state, obj);
> @@ -1459,7 +1459,7 @@ drm_atomic_get_connector_state(struct drm_atomic_commit *state,
>   	struct drm_mode_config *config = &connector->dev->mode_config;
>   	struct drm_connector_state *connector_state;
>   
> -	WARN_ON(!state->acquire_ctx);
> +	drm_WARN_ON(state->dev, !state->acquire_ctx);
>   	drm_WARN_ON(state->dev, state->checked);
>   
>   	ret = drm_modeset_lock(&config->connection_mutex, state->acquire_ctx);

