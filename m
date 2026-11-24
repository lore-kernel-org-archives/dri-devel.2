Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F99606A31E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=azKlO9w2;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=QQ34qEH5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D721710F510;
	Tue, 24 Nov 2026 11:55:01 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E07610E266;
 Tue, 24 Nov 2026 11:54:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795521284; x=1827057284;
 h=content-transfer-encoding:date:message-id:from:to:cc:
 subject:references:in-reply-to:mime-version;
 bh=IElL4LubJkCEkBqCeBuZ7uJG8ge/LFTNj/V1/szf76k=;
 b=azKlO9w2+KWGNgBUiXP3XDSm4jUr0bMhSu2pgGoVWWTXbbqt1mbkEZbR
 jT/con+hQYQuJ48XE8/8oxC0UI/jXulBttO44X17pZ7hMUshkIy68R3ei
 GhBOnE24uAPYcWI9FZM/nEKUvc9vhpWbxzUvVkesGU2+664JQ2ydqtH4J
 6xQiOIrghJmdno+8XDtDHGyfb7J9lU+OWARn5np56QIGyGEeCaUxYOmJF
 fO1UVLL5FkVisnWOrXRFk4cHCQf5ecS/oTXhkQLNi1rVnIUtlv2iKFpkn
 rAHqWdKSufla5NfFGKDymcH11NNBlz7YHiryGN7+iYrcviGwKLkT4oc6i w==;
X-CSE-ConnectionGUID: 8dSVob2BRpaT1Y0m2XhNgg==
X-CSE-MsgGUID: fvvVHsyTSMG4zxeGRVcfmA==
X-IronPort-AV: E=McAfee;i="6800,10657,11975"; a="4249959"
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; 
   d="scan'208";a="4249959"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:54:43 -0800
X-CSE-ConnectionGUID: Tb/yZ+WMTK2WEw0vb0fYoA==
X-CSE-MsgGUID: b1zJW3VtR+iNeKZuG4vomg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,230,1787036400"; d="scan'208";a="11458224"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 24 Nov 2026 03:54:43 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:54:42 -0800
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57 via Frontend Transport; Tue, 24 Nov 2026 03:54:42 -0800
Received: from CH4PR04CU002.outbound.protection.outlook.com (40.107.201.7) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.57; Tue, 24 Nov 2026 03:54:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rnWGMZh58JHev7V1vesRtkxJkAxFhLRIVLbBaDbnKxT/FvJwUPrfzO9G+polKLMm2jc1IGSf6ME6Q4eP7nzG39utINNJWxcrnJlz4s/UGgQcwQpK0JgOKTJ9B6lpStY61+7106/5IvyC8SMD2DQc0KBkh66mAWZSZUdKf3JdVkl5mF5Fmw+H6dZYaLRTBs1xUau6sok/aF3SkMXvmTDDbBkYCtoYQMkCHAWbetU7CmyIvbvGxlP/tdxsqwIGIg3jxtkwHRsRD5dMIhghpNg/B0AaNd4Snm7lIRiNQneCs+Vcen6JviOXfYvNRVml2M9tXMLBtx2ZSikmzd2/T1IwKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IElL4LubJkCEkBqCeBuZ7uJG8ge/LFTNj/V1/szf76k=;
 b=n98XkioB46wub49aaIVfENClolX/yIAnrTr4PWD1wpHmPp/kNY14MeRQDziQdH91jNSNnqeeETkxBrFI2QmUBJEhJHK2ka6ZX5HJrZPiLgU8hzM7EX8Fcwa3j+L7/xapNf4oQpF2CNR9y6kBygTS1h1j98AbdbkM3c/Q7Cbe6Z6Goqu96RmXvbAkrXHoZVQCN9XGfrNppYRGxIsZ0Afn71wDxVoKckb6jRnfjIVaXzJkbLJRud+6TjDG4xqA+XznXT62TzStBwTuA2gF9kOffFZ8cSrf9OnTpt2T1xCYTPm7gwd5RkXenBqtxI2foQ0/+AsMHyBRHnHqim62QIlrVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IElL4LubJkCEkBqCeBuZ7uJG8ge/LFTNj/V1/szf76k=;
 b=QQ34qEH5+8LEU6VMBWK0GTr6npILvKZA5jL6W8STAPq/VYsj/okqvFmHF020vXd7zVw2Li1/4Mc0JEXQS1ApB+yMefALVSDO7My3R+MRnjPkOVKWh+adEWO4VkgcArhotDIElw/FTJqcKQs1oQf/5jmv2n/vXB53yVDgvNVXjWU=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS4PR11MB134916.namprd11.prod.outlook.com (2603:10b6:8:4f0::21)
 by DM4PR11MB5972.namprd11.prod.outlook.com (2603:10b6:8:5f::6) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.12; Tue, 24 Nov 2026 11:54:39 +0000
Received: from DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4]) by DS4PR11MB134916.namprd11.prod.outlook.com
 ([fe80::87f6:b354:5770:3ad4%5]) with mapi id 15.21.0639.012; Tue, 24 Nov 2026
 11:54:39 +0000
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Nov 2026 12:54:41 +0100
Message-Id: <DN3F69N1KFTU.1IZA3FZ9AAS7S@intel.com>
From: "Sebastian Brzezinka" <sebastian.brzezinka@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>,
 <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: Andi Shyti <andi.shyti@linux.intel.com>, =?utf-8?q?Micha=C5=82_Grzelak?=
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v8 6/6] drm/i915/gem: Remove iterator and use while loop
X-Mailer: aerc 0.22.0
References: <20261109113758.1491891-1-krzysztof.karas@intel.com>
 <20261109113758.1491891-7-krzysztof.karas@intel.com>
In-Reply-To: <20261109113758.1491891-7-krzysztof.karas@intel.com>
X-ClientProxiedBy: AS9PR06CA0379.eurprd06.prod.outlook.com
 (2603:10a6:20b:460::12) To DS4PR11MB134916.namprd11.prod.outlook.com
 (2603:10b6:8:4f0::21)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PR11MB134916:EE_|DM4PR11MB5972:EE_
X-MS-Office365-Filtering-Correlation-Id: 92977d2a-cb50-4517-4c2d-08df4a21b854
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|11063799006|10067099003|4143699003|56012099006|261022105027099003|261026140227099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: dTYOJM7rCXbtfLx0uSXUSTuFnnk4kzn+9aSzGnHxuqwgLn19TlgCUEIQtt4qZMeZ+9+WGh7ctiDFVgqwmLLAsN8RQ7kta70RKfV5psn9HDik7e35kn74WtdLkdzcv5hcrAZVyqC1stAtQcc5A8Vx0sCh1uL0l2fmFRtscVvhpzZHFFhZTL4lbIIzoQOsNzL5oJVmF8nAsF72DdH3n97vSlow4guS0SYkj4ySpc/TWQPE+FrJyJsVS57F3vv7ISDqe9R0bIFFSnnyLhOxJY11DS6yxZJlOmJUkSDCM41GBtsAtFAPmtVzeY3fx5ymNn0SZLyH9HxUOmlJeFvxgTVUJFpYktSf5LywU40cmP+LOdzvJEs6XpvCEn3zd3f492pK162BmI5vphyhq9NoXxZr2CUzA31NPjLjy8TNZG3G0TgvrjVX9IaxixdMM5lBCnyLpZca7r3u8lHAhzJmOjMjjBxyZjjN9k3yGCw4ho7gAdTdPHqj9MozX4tVKJaLObICs0twjHN0bRdJ1XeAedLJvDTVd6ZDR3jNExzf4xU/uekC31DKl0kgf7pHDyFn3/eps/9MUhXx04lNp5wfs37dZqgvNaPzHYF2oeNLvJNWMyhNW6tpYu84t/qpZGHu4sJfXxK5URM/p7hIJ5Iy6g5tCyb/vA3pn9rJpFu8vTncu9g=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS4PR11MB134916.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(11063799006)(10067099003)(4143699003)(56012099006)(261022105027099003)(261026140227099003)(261028144727099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZzdUSS9qSnpyUVk1bkIwMGw5R2czM01oNmZrOHEzZ1pxWUwyamIzOHJQSXdu?=
 =?utf-8?B?S2xhWE8ybm02dUdFaUhId2ZpTDVSc3ppSVVlMkkvWXBHZkZlRmxubFZ5Q3FE?=
 =?utf-8?B?Q0xXcWN0LytsaVlxK0pwMnpXSkFyL2VIOWs5VjBDZGtDUlJMdzVDK0Q2TTN0?=
 =?utf-8?B?V3p4dXhIYS9uTFc5TmdDWms2dlpoQkhyMkh0M0dqUXlIbXpGa0VJRTBQUTVn?=
 =?utf-8?B?eEFnOS9pdEpRa3dTTDNRQnNQUWFhVnExTzhKV3ZreXF5V29VWi9KQjZQVlkv?=
 =?utf-8?B?aDk5NW8rL3B3eWcrWUIvcnpCQzlwL1p2SGFjTjMvUUZuK0pnN3hEa1o0Yks2?=
 =?utf-8?B?d0M2NTJhUUtRMDlBeXFTN1ZKQThoR2FjemMzd3VDa0RMaVhUZ3ZtR1JhYVBy?=
 =?utf-8?B?Q1BGTFRQVUM2U0NFTzBvTk9hU3NOajdHdWZqK05BU1FNQzkrRlM5MVdtWG0r?=
 =?utf-8?B?VVkzcUU4RmV2YXFFdW5FVTZ3VkRYNmVudTk4bldzOFhWemMySFQwdVB4bG9a?=
 =?utf-8?B?VzNVY0lEVFhrdG9pNy85MzFpd1FXQUgvamNlZk5mNm1jR0RNVzV0WFYwN0py?=
 =?utf-8?B?OVJGNlFlOUR2QktteVR1dFJINTFhL3VrNHNQRG5VYTlCQ3ZhZ3h5ZWVtN2VH?=
 =?utf-8?B?WU81QXdtM1dCemJnQUZtZk1zZGNpVVNab3VKOEw1V1dzZXEvWE1vNzlUTjRs?=
 =?utf-8?B?TnpGaUZ0YlM4T1N6eU85Wk5Ud3ZIdDFMRVRmMGpsMFJzdGduYlRpZ2ZITGZk?=
 =?utf-8?B?V2MyQmVxOTVidWhkbGkzQU44TE1oYnJxTTJLclU1UzU3TmZoRlhPMjh3NEFX?=
 =?utf-8?B?NVBnOTVjeXlTVjR4OW5ndUxwQ2tCY29LKzZIN2FVMGVhcnUxc1NhUXNiZnhK?=
 =?utf-8?B?cVRJeE5ER3JKQ24ya2syY3hiS1A3QWE1ZlVNRlJnSHR1K1pxQi90OUx5N21M?=
 =?utf-8?B?aGVLeWVJbXhJNEQrTm94S2t4T2ZYWU0vZzBtdUJGUmhVaTdDcm45elhSNkNs?=
 =?utf-8?B?UUozOFlHVVJJRThFMG5uaE1QQUd3YmJPNjc1dWtDWFJINWl3RVJjN3NOMGsv?=
 =?utf-8?B?Y2JRSmRmOFk2Z2YxNVQ1OU56Rk1DNGRYRGJuSFh4eDNaMUgzZERTYVNkdVBO?=
 =?utf-8?B?VUFqSlhRa3NjTCthbElrWEZzRlh2bnFha1dWdGV2ZDFSWHVmck9Tb0swN3J1?=
 =?utf-8?B?Vlk5ZkxzMkJEZ0JDU0N6UENPNmIrSzBNdUV1THFDbWRRR3BMQU9WUnNJTHE1?=
 =?utf-8?B?V0ZiVWxiYXFjZjdBclAzSUNXKzBzMjdIdDhqVmp1L0ZqR0lUb3ZKWUZJWnRZ?=
 =?utf-8?B?ZzhMZDc3TC9OTThIanp2bGpHeFdydkNNcy9sWTZFQ0hYZjE1NHNCVndPQnRh?=
 =?utf-8?B?WXNCbjAvODVGSG82TVk3ZUttcU5OUnl3bEZtdkdRVTFkUTkwQ3R4RFhROGJQ?=
 =?utf-8?B?OExXRkcrcHIxQmovNkFtcllxZUJ0VG01cERMMnI4M0Z3RXpQeFBOd1JJM2xw?=
 =?utf-8?B?M29MTnIrWWRaQ1RHd3dsdndrdGdEK0VHRkFhajkvdmpiSDRoeUVIYlZ0RUYy?=
 =?utf-8?B?SE5tRWZVMHlpTHNCRjFEMFJZTkdHMHpVOG90a1E3ZEdHRXloS3RRZUxlYk14?=
 =?utf-8?B?d3hnWWRmdWZyY3hMUU94dWs0N2RBdEIzcWpNNGJobngvK0pwdGxWM3hNNU1X?=
 =?utf-8?B?WEtOUU8reHlGd05DdUFvUEJnZHBRRkpqR0x6MXltWDhGV3VzbUFxZ2tCbitr?=
 =?utf-8?B?WmlWb3Bjck94OFVjQXRqdlBpWExzeTRuNUxNeVNyTWtHZU43enZSNjJDK2xr?=
 =?utf-8?B?aVI2Yzd1NEgwellHUnYrTG1LU1hKc1g3YmcrVVhuN1RPQ05DR1B2bDN2dlNW?=
 =?utf-8?B?LzFFdzErTlMwRVNkYWZEdytXK1oxQi9aVU8xQm1PVjNMa211MnNQVVFKbFAx?=
 =?utf-8?B?ZW9xNEIzZlhxT0N0Qk14aDFRejZhd0d0MUZlOVBLWFZhSTdQTDEwbWtvMzdH?=
 =?utf-8?B?YVFSb05PK2pNWGdEQnhsZzZXRnRHSm9hemwzWG10Uk16UkpyYTd5aFVVL0RM?=
 =?utf-8?B?K0FMRGErUUlWTFJLVDN4eHJBQi9PUnFtdnE1ZG1zVjJMRmMvL1dIckh4V2Rk?=
 =?utf-8?B?RzYrcURaSFpneFBHeWNoZDRqd3l1ZmpOMFYvMXI4Zi8zY3ZtSnB3Zk9lMkE1?=
 =?utf-8?B?RzQzc0N6cHdoZWg5dHora3llc2lNY3BNQUE4RXNZQTM5empnRDd4MXEzakFi?=
 =?utf-8?B?TG1vZFB3RlAvUXp1V2w3OXJDa2k4OWNMdWhNajNIZ1FORjVFUVVTR3hCZGlq?=
 =?utf-8?B?WC8xM2lUTmY1UVZPRjlzOE55cDUyTE4yUmIwLytoazB6U2ZPR2xZa1B1N3Fq?=
 =?utf-8?Q?BwzOaxHq1GgA60hs=3D?=
X-Exchange-RoutingPolicyChecked: VIDbLLKAs94z3XxcjEa+vQ6uzj7DQN9DPLVOfLoKQRpRiBBkQx7DwvErp7XyvnM4i9HIns2GIQcktdQDNSsLtR0hueOjVqyTntfHiyrRmqrKI0/Hyu93g/U4oreIUpOR+BjnB4bS94a4ED1e4CoOWi0aqFhCaopplfdHwVkzJBDfbrjiim7S9IqxYDwBRMOW2lsY7Fz/Mi4nARHCfzANEBp3/BMJp9jW2sh7l2xLDagmk/nFqQCVxP5vCLaPXa/MaWJCGhARifj+YtPJYkLvOtdt1+jqaY0W5BJJjfDHDxzN9n6P1awQh+yU7jsZUioUW/wH4e2aC1sKu7LR5ncBZQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92977d2a-cb50-4517-4c2d-08df4a21b854
X-MS-Exchange-CrossTenant-AuthSource: DS4PR11MB134916.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2026 11:54:39.7651 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dL47P1BY/7sm+IxOhrQhjWms/gvj9A4vY4V9plokBcPj1OKdIJ7MZpXwvnwTWRTbpxApmbbQkZb17ELbYRtWHmJLK7dFgH6chyG12U/QCNo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5972
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon Nov 9, 2026 at 12:37 PM CET, Krzysztof Karas wrote:
> Change the main "for" loop into "while" to get rid of obscure
> iterator "i" and use more descriptive name to indicate how many
> pages were already covered. Detect first loop with st->nents.
>
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Reviewed-by: Andi Shyti <andi.shyti@linux.intel.com>
> ---
Reviewed-by: Sebastian Brzezinka <sebastian.brzezinka@intel.com>

--=20
Best regards,
Sebastian

