Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B0C260A381C
	for <dri-devel@archiver.kernel.org>; Tue, 17 Nov 2026 13:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ReEYtczC;
	dkim=pass (1024-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=selector1 header.b=ecsvwCCg
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7958110F6F3;
	Tue, 17 Nov 2026 13:06:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82DCC10F6F2;
 Tue, 17 Nov 2026 13:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794920804; x=1826456804;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=qh4hg0IyUw1LEpIiruZgZywSW9/wpD29jfcZgkzfPiE=;
 b=ReEYtczCwJiScD8AToLzhIKbuZPul70UOAPlooS0fIAf4wFkMDx+8vBY
 Fo7v9o8pZQH5ZNmLakKmd4b1ShDaxYfBffQIMLZG0QgUieWrCeY46I5VO
 XDUvCWWx1ZsvNaQ2xkUnZzraILBkNefGIa96kKNRiVaVApiHfIz/INL5X
 wFQGJi7fs8b86JjJXjugJCQ2N72gLdL7knPQQCgsaq142GFoGOc2sfa36
 iAymfU2EsbDiRnqKbOJhvgfTgTldHLlyAQba6TDohFLJaExb6b7a2zzRG
 tiexbBBjc2RTl5QKM+tiGO2WvdvshCcqVo1SzoymHG0lzYs6ea9+BEJIL A==;
X-CSE-ConnectionGUID: JBLPWU4RQKO2rfAwNWyvFA==
X-CSE-MsgGUID: Vm2P94U4TrKXpDvW5sPoVA==
X-IronPort-AV: E=McAfee;i="6800,10657,11969"; a="3584016"
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="3584016"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 05:06:43 -0800
X-CSE-ConnectionGUID: kzB2A5Y6STGWlWRHlDYlig==
X-CSE-MsgGUID: 1UU3KNKPR/WObPUMxgjzAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,218,1787036400"; 
   d="scan'208";a="9769994"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 17 Nov 2026 05:06:42 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 05:06:41 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Tue, 17 Nov 2026 05:06:41 -0800
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.62) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Tue, 17 Nov 2026 05:06:41 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teMz3b/Of8p7Ns8jpRu0000U0445OWKooN2PYwW50GTthLSIHTCwIQKXEHkrSMK5CuP+BPH2WMB4OgejWa8cG59pNy0/7Huj+oV/4dnMdwgSVU/R5JGLx8ODuAqPojErXtNW4XzcBxyVByQNKw76cDE6+BqAt/fsi2QjbqKuIE8frrp634l7+ZuwFQpyc3znDReQ/o/UulmPOkypZKha+mDj3Qx2oH75g33P6FvUXrscIiaY7XS4eqqHiKIos3Rir2cGTFbaxAayYjukPXnEVFQ7wAvx91aaAGRPCXu8fQPcB+bWxzwVWXW9S0BmoplsKQFbqJe+7bFWE/vUOgQubQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+rTwCCLuOGdYGHj95e3BSri47duhkGV088Y4QMChIPM=;
 b=CsSTzqnsAgKSgFa024F+4WuFeEpNKdy7XpbUfHPrpfVuLg0kW9TWl1IgMbCjFpweUTzuavq41gFCBZ92C9rxnwZJuIbS2tegGqODgxL3WEj1q0PdDyg7aR3w65JZR+ShC00DbD2yBuPdHNX3Zd20aNFnJCMStS8zYLje/qMQWpXoBT4Gxv8BHgrIafiT/Bg0Qokj1wkt18u+EMt0lKVoj+nTX6jgUab0tvs4Vk8VYpLfTH6SY2ocz/sBINtZIeaOSzFNVvj1Wq2w4hY7dhOUbYoQ7W8dqAQ73jm77FDURgM/ii6aS47xR2sAfe5CXB6XHijKuzn3C1hIHTOG5MOfcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=intel.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+rTwCCLuOGdYGHj95e3BSri47duhkGV088Y4QMChIPM=;
 b=ecsvwCCghHAhrdNcfkPxex5CzTEIjYlbaKolqdBK5sDjENAC0fAGuiiwqA3nm0s1n66u+b7oe+vOIskMfieFx3xuEG5k2DBLBKRNATLsRm0nFKtbKa4Zhk2HXKDzs3+LcKIOeTK/y+bOoFT5IAy7Yv0/BuMcnHStFM6WYNiTTvM=
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by DM3PPFE9989E69E.namprd11.prod.outlook.com (2603:10b6:f:fc00::f5a) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.13; Tue, 17 Nov
 2026 13:06:37 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0615.012; Tue, 17 Nov 2026
 13:06:37 +0000
Message-ID: <da65f083-ab85-4f14-8be6-a720b9f6efc6@intel.com>
Date: Tue, 17 Nov 2026 18:36:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/1] gpu/buddy: Prune exhausted subtrees in
 range-biased allocation
To: Matthew Auld <matthew.auld@intel.com>, Arunpravin Paneer Selvam
 <arunpravin.paneerselvam@amd.com>, <dri-devel@lists.freedesktop.org>,
 "William Palacek" <William.Palacek@amd.com>
CC: <intel-xe@lists.freedesktop.org>, Joel Fernandes <joelagnelf@nvidia.com>
References: <20261102051633.2035348-3-sanjay.kumar.yadav@intel.com>
 <20261102051633.2035348-4-sanjay.kumar.yadav@intel.com>
 <b07e279a-67f2-4d38-ba24-9ff2ca9a90fb@amd.com>
 <91f03c24-2bee-4872-bf09-ca54f81ccf50@intel.com>
 <3d156a96-ca2d-479b-b6af-d31b862b9467@amd.com>
 <8b622510-5dff-4adc-abe9-db7b782692e2@intel.com>
Content-Language: en-US
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
In-Reply-To: <8b622510-5dff-4adc-abe9-db7b782692e2@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA5P287CA0106.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a01:1b5::17) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|DM3PPFE9989E69E:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dad8819-ce80-4b0f-1dfe-08df44ab9cb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|366016|18002099003|11062099010|22082099003|261009223027099003|7136999003|56012099006|11063799006|4143699003|5023799004|261102130727099003|261026140227099003|261026121527099003|261028144727099003|261021121427099003|261022105027099003|261102123227099003|261021123027099003|261022075727099003|10067099003;
X-Microsoft-Antispam-Message-Info: ZYhH3yRUfKJhUNC8fpLGR9arfovloQ7pyGhCIXcuvGpwap7G8UmDM6P0qGCOY6UfqyGX9vXoMw86mF9FjOQGxrk9aih1H3V4jilVCJivDFCDNw5D0c6daGF5sbJmkCy24RVTg7aetugawwkJWT9IlzpoIEtqd4PgkVqsUHcm6eOGcg+eAWDQdTkC607jEVf4WVjKG6bhi0Oi1e2wj3k3is8klNAciXOT7omHJD7pcnOO0XWqymwjs6dB4q/MSQBdHszSJZHvU6o+1UVBJG4GY+kBIGzgew8AyQgYLS5xbdJmNO+ARva8q2rHSfVu5Ir1Y6LpQughr6/qtr+QedUzj+6ItI9xsULi57x9ivu/MqywClDAwoyowz3yEspEftkXwbixu2K2huHfw2IIh6Hdc4YL3oVIAWspZynyaC7JOyGTycaYoJVT2d9TPzXH9OG1ed4zhnAnGRX1w2i+2ImJcxlellf9MkbBCSbjekNxlT+QkKKI0+d5KT2fDYBushrot/KaSmEz7ZUnUtL/GMHoHSu0crZivXSYqxnbLx4qMmY0UiS33/g+VYTiXZx9QDUg+q2365mE0yUnAwouryNdEEhUHEfyFmtminsI1LEYhOqOEb/Zw9QefDFtbYOiJc/p
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(366016)(18002099003)(11062099010)(22082099003)(261009223027099003)(7136999003)(56012099006)(11063799006)(4143699003)(5023799004)(261102130727099003)(261026140227099003)(261026121527099003)(261028144727099003)(261021121427099003)(261022105027099003)(261102123227099003)(261021123027099003)(261022075727099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlAzWkJ5NXJiWFJqKzZXMzlGaC9QTTZQTlByNkoxTElPcXcrU29qMERIeFAv?=
 =?utf-8?B?NzBqdmpqcmF1ZmJBU1daZXVqZHhpSGg2Zkpxd2NJSDFsNXdubHZIV1l2YWZq?=
 =?utf-8?B?NHdTOUFIWDkvVlBXQW93WVlZZkFYNlNUM043VzJGMFVaT05FNTZWditvM1pq?=
 =?utf-8?B?dlM4QWFFUEszUjRJOGg0R284VzdqNC9WQ251WVJPNXNYRHhwUlpSZ3Rrb1h4?=
 =?utf-8?B?bDFCYjJjL1pQRmc0TDlXY25iZnNHb2FRcnpsa051cnhpeW9qRFVwVFBJZzBw?=
 =?utf-8?B?OS8yUXF5enNrRlpsMlora3JkRCtjZlFGZW8vQ1RYTTZYUCtRNS83VWpVU01S?=
 =?utf-8?B?MVpzQ21NazVBMWcwZUtNT1lHcWNkUWlOYk5MTjRkeVg5UTYrU01hYTVEWHhh?=
 =?utf-8?B?d0U5ejBhTXJqQ0s5UVpQeVJyMTkwTmZCNjA2YmZjV01CaXdxS1NaMmZzRWRn?=
 =?utf-8?B?WW5pMlQ3dkdFVm04a0JJMkZCVUV5ZGRLN3p4M29oT1JIZlpyRDc3bDNFRGxa?=
 =?utf-8?B?eWFHQ2dvcm5HQlIzWWdDSmdITVh4Q2FYWHBrYTNiSUJoTUJXazFJTDA0Nkk0?=
 =?utf-8?B?YWRERDErWll3ZkpxWk9YVUUrdFhJMGRra0o2NUJxM2M3SDJxUStJRllhT2dL?=
 =?utf-8?B?aFF0N3FCWTFTUm0zTldSdHFQSU5JclJPRjZmWERsWGZlNEJsTTZ5MFJSSk1a?=
 =?utf-8?B?VENvM1Z0V0Foc0UybFlVT3RhYjBHQ1htd0J3YXRFS0NZTXMzL0lrempGQnF3?=
 =?utf-8?B?TXJmM24vVkxnODRqS3h2dUdMNUtUVEZnSHBrSWhOdkVjVTJBUVNMdmNJZnFY?=
 =?utf-8?B?MmpnQkN6Uncway9Fam1wODhURjVFL2xuQ28ySUtuZ3FEVUNJZ3l5SUpEN3Jt?=
 =?utf-8?B?UFJMaTlna3RLWmdRVVdGOG9KNlpaVEprb0laZ2lxQVkzU3RQbjhNeGQ5Y3NN?=
 =?utf-8?B?U3p3VzhlTFJLOGFHTndxZ2JBV3BrT0JJV3N4d0ZCS3JxM1VoVXlxV0JMbkVx?=
 =?utf-8?B?SDFnM2xKQ2VLQ2xtOGFsdHhXOWdhVVpyc0pxOWJ6Mk0xYTQ5S25JcGt6eGI0?=
 =?utf-8?B?Y3R1WlltREt4ODdyY2hxNzdEMmxVd1NRTXRlQm1BQmJUTDk4OXVyUEJ1T1p3?=
 =?utf-8?B?Qld3TGhhZVloNTRQL2FIeE50ajRBVmZVZDlRcUNQRVdRNzkwcmI2cVl6UHRw?=
 =?utf-8?B?cnJOMHdlOXVsbElhUGRCa20wZjBnT1JROEx1M3N6b3FpL05lV2wxNGNWRUkr?=
 =?utf-8?B?ZDZhaFV0THR6SEFDcDNJWWdJOFl2U3ZLZXJsTm1heFVFMlBDd253WUhwaFox?=
 =?utf-8?B?T3BybzYwMitsK3JzU080WmpEeE9wMWdaNWV2dXMzeE5MYkVpTnI3NWVqbjl6?=
 =?utf-8?B?R0lxTHE0aEhyaUNBNXl5dzVkRndEYkNGTkZMSVluZ0g3Y0RIaHRrbC9CM2Ir?=
 =?utf-8?B?bFNtQWZNdGxIaUNjTkFtMUxkd1JReTNWMVhSemdheCt2enJhYTV4cC9uSFpJ?=
 =?utf-8?B?UU8rZHhSNUZsTnI3U3Z5T2FPOXBLaW8zTThJdThlb3NIWi9Na21ZSWRTVFF2?=
 =?utf-8?B?dTkybnlBaWJHVXg3TE1Ga0tsQnVzRjBBSWJPZmxkMDRWSWdLRGxsZHNoVy9L?=
 =?utf-8?B?Rzlnb3ozUU9rYmIxU3NvN3R0SnozRGhOa05pZDVQN1FlQ05aQVJqb2xHSjBY?=
 =?utf-8?B?Q2hXZ0VRVDJxV0JheTMzZ3ZUWklROEN4cW5qdnEzdExTQ05PTVdxNGRqQzF0?=
 =?utf-8?B?L0F3dmhvaytBTy9ONUV2U3QyU3BaZkRIaDRtNzZxckV5UUExRmo5ekdEckl3?=
 =?utf-8?B?S2I5cXZoWjBLS2VmZWwzcTJFemFXNU55b2FEUmhxNU9LVy9QaU5RazM2NDN4?=
 =?utf-8?B?RW4zcU5yVGY2U3R2V0xFTm1oRmhMaFVVY04zSytvWlhvZWtzOEtPWS9qYVNK?=
 =?utf-8?B?QlFEbklrWDJneGRyeGpCa1JUYTQ2KzkvdHRMT0RKUWtqUVFLUmQ1Q0dDcjRK?=
 =?utf-8?B?TnduT0FKNDRmUTFiUFJmYmxnTzREVVcwZzZGVXJTOWdvSUs2dFM1bGZFZWxF?=
 =?utf-8?B?bk5KSVdJRldxWjI5b09nR1R5ZW9TVjZLdCtjTm9mOTNaVlArMi9xcjlvMnZI?=
 =?utf-8?B?SFpCaGVVYXhCc05uMlFUTXAwR09iREI3UTZIRThsVzZtZHdtRlJwR3FzRmV6?=
 =?utf-8?B?ZklLTVRxZ3FvWWFUTGdWcTlNZm9rb1pjakJkS0tGL1RpN1hNSnh2Sk9vanZi?=
 =?utf-8?B?Nmk0V28xZ2EvcjZ2cFBQSnVNVVptYW9xVXNEMm0xWTlFVmVpOGI0NGVGSmlm?=
 =?utf-8?B?MTdVeG5TMmtzOWhYNEpuMG84NGZGQlJRU29GS3U0VjlxZ2NFK0o1RFhjbXhS?=
 =?utf-8?Q?+p5YXE0SVD7yCCpE=3D?=
X-Exchange-RoutingPolicyChecked: G3aZSO9A6djZhwGFJpGy2BzEp/NRAX+m4xs+/xZfE1XhWvNBNgIk38j+A/gH4++q182pE/2IbKhp97vYkgwUh1pJVZB04r8nRkTBJ1RmJXThToxL41Yr9wq+Z4cQM8QNyengo8A5tN2fe356OZAs3Lu5KZUVvzQI4R+LmfyZPNw7bXKnb3fyRukuan6Z2ZOfS3Ze9t4PScNgT2yQ4hDaKi43+RqZKBohIT2o1vWx0E82725i6jZb5JZHestX4cafOLtD985PVzWIqYULU5EQh/HwYRIDXyBydA5GKkgwkErVT8OcTfsPI8JSWDMQAu9r5nX5iJtn8wJ4+9gSWBnHeA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dad8819-ce80-4b0f-1dfe-08df44ab9cb5
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 13:06:37.0359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o9JTfp3AVfTO07zJa69vm4cJo4L19xjV1dLOdJmcvu06wM4uUk6PNaqhT1mP8XVVr5Y1NLYg7W7uyWdKplAolQ2dLcBzBPQOp8V5SPQjUC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFE9989E69E
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


On 17-11-2026 15:27, Matthew Auld wrote:
> On 17/11/2026 04:57, Arunpravin Paneer Selvam wrote:
>>
>>
>> On 11/15/2026 9:23 PM, Yadav, Sanjay Kumar wrote:
>>>
>>> On 09-11-2026 12:10, Arunpravin Paneer Selvam wrote:
>>>> Hi Sanjay,
>>>>
>>>> On 11/2/2026 10:46 AM, Sanjay Yadav wrote:
>>>>> __alloc_range_bias() walks the buddy tree depth-first, higher address
>>>>> first, and descends every SPLIT block even when nothing below it is
>>>>> free. Range allocations are placed top-down, so they pack below the
>>>>> range end and each new one walks every block already allocated there:
>>>>> O(N) per allocation and O(N^2) for N allocations, under the allocator
>>>>> lock.
>>>>>
>>>>> Track in each block the largest order of any FREE block in its 
>>>>> subtree
>>>>> (GPU_BUDDY_NO_FREE_ORDER if none), update it when a block is 
>>>>> allocated
>>>>> or freed, and skip subtrees that cannot satisfy the requested order.
>>>>> Splitting needs no update of its own, as both children are marked 
>>>>> free
>>>>> right after and that propagates the new value up.
>>>>> gpu_buddy_block_trim() detaches the block before freeing it, so 
>>>>> updates
>>>>> stop there while re-allocating inside it; recompute from the parent
>>>>> once it is reattached.
>>>>>
>>>>> Skipped subtrees contain no FREE block of the requested order or
>>>>> larger, so the old walk could neither split nor return anything 
>>>>> there.
>>>>> The remaining blocks are visited in the same order, so the selected
>>>>> block and placement are unchanged.
>>>> I am not receiving some of the emails you are. sending me. I think 
>>>> there may be an issue with my mailbox, so I need to check that on 
>>>> my side.
>>>> William has also been working on improving the range-allocation 
>>>> performance in drm_buddy. His patch is here:
>>>>
>>>> https://patchwork.freedesktop.org/patch/763478/
>>>>
>>>> Since both patches are trying to improve the same range-allocation 
>>>> path, I would like to converge on a single upstream approach rather 
>>>> than carry separate optimizations.
>>>> I have put together a version based on William’s offset-sorted 
>>>> free- tree approach, extending the search to be class-aware:
>>>>
>>>> https://gitlab.freedesktop.org/arunpravin24/drm-buddy-range-wip/-/ 
>>>> commit/72414977d38f4bcf7a364c64f24aa7f25cf699d9
>>>>
>>>> With this approach, we can remove the buddy-tree DFS walk entirely. 
>>>> Cleared blocks are located using the existing subtree_block_state 
>>>> augmentation, and top-down placement comes directly from the 
>>>> offset- sorted free trees, reducing the lookup to an O(log n) 
>>>> free-tree search followed by a small bounded scan.
>>>>
>>>> @Sanjay, could you take a look at the version above? I think it 
>>>> would be better to follow this approach upstream and create a patch 
>>>> with the test cases around it.
>>> I tested your WIP on our side (applied on current drm-tip, on top of
>>> the merged two-pass guard).
>>>
>>> BMG, CPU-visible BAR resized to 4GB, xe_pat@pt-caching-random-offsets:
>>>
>>>   drm-tip                 ~48-51s
>>>   drm-tip + my v4         ~0.7s
>>>   drm-tip + your WIP      ~0.75s
>>>  (drm-tip, full BAR       ~0.7s, range path not used)
>>> So your version fixes the xe small-BAR case as well as v4 and looks 
>>> good to me.
>>> v4(already R-b/T-b by Joel) could go in first as the small fix and your
>>> series replace the walk on top. Whichever you and Matt prefer.
>> Okay, please confirm with Matthew. If this is the final version, I 
>> will merge it upstream.
>
> Yeah, ack from my side.
Thanks Matt for Ack.
FYI Arun: I need to send one more version just for CI because CI was not 
run on v4.
>
>>
>> Regards,
>> Arun.
>>>>
>>>> @William, could you also take a look at the version above? 
>>>> Hopefully we can follow the same approach when porting this 
>>>> optimization to the older dual-free-tree branch
>>>> used by the ROCm versions you are targeting.
>>>>
>>>> Thanks,
>>>>  Arun
>>>>>
>>>>> v4: (Matt A)
>>>>> - Drop the update in mark_split(), the children being marked free
>>>>>    updates the parent
>>>>> - Detach the block before __mark_free() in gpu_buddy_block_trim(), so
>>>>>    only the final update from the parent propagates up
>>>>> - Drop the order, is_allocated() and is_free() checks in
>>>>>    __alloc_range_bias() that the pruning check now covers
>>>>>
>>>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>>>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>>>>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>>>>> Assisted-by: LLM
>>>>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>>>>> ---
>>>>>   drivers/gpu/buddy.c       | 56 ++++++++++++++++++++++++++ 
>>>>> +------------
>>>>>   include/linux/gpu_buddy.h |  7 +++++
>>>>>   2 files changed, 46 insertions(+), 17 deletions(-)
>>>>>
>>>>> diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
>>>>> index 28cff97d57dc..93f70c98b235 100644
>>>>> --- a/drivers/gpu/buddy.c
>>>>> +++ b/drivers/gpu/buddy.c
>>>>> @@ -602,6 +602,7 @@ static struct gpu_buddy_block 
>>>>> *gpu_block_alloc(struct gpu_buddy *mm,
>>>>>       block->header = offset;
>>>>>       block->header |= order;
>>>>>       block->parent = parent;
>>>>> +    block->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>>>>         RB_CLEAR_NODE(&block->rb);
>>>>>   @@ -717,6 +718,27 @@ static void rbtree_remove(struct gpu_buddy 
>>>>> *mm,
>>>>>       RB_CLEAR_NODE(&block->rb);
>>>>>   }
>>>>>   +static void update_subtree_max_free_order(struct 
>>>>> gpu_buddy_block *block)
>>>>> +{
>>>>> +    while (block) {
>>>>> +        s8 max_free;
>>>>> +
>>>>> +        if (gpu_buddy_block_is_free(block))
>>>>> +            max_free = gpu_buddy_block_order(block);
>>>>> +        else if (gpu_buddy_block_is_split(block))
>>>>> +            max_free = max(block->left->subtree_max_free_order,
>>>>> + block->right->subtree_max_free_order);
>>>>> +        else
>>>>> +            max_free = GPU_BUDDY_NO_FREE_ORDER;
>>>>> +
>>>>> +        if (block->subtree_max_free_order == max_free)
>>>>> +            break;
>>>>> +
>>>>> +        block->subtree_max_free_order = max_free;
>>>>> +        block = block->parent;
>>>>> +    }
>>>>> +}
>>>>> +
>>>>>   static void mark_allocated(struct gpu_buddy *mm,
>>>>>                  struct gpu_buddy_block *block)
>>>>>   {
>>>>> @@ -729,6 +751,7 @@ static void mark_allocated(struct gpu_buddy *mm,
>>>>> mm->used_scoreboard[gpu_buddy_block_order(block)]++;
>>>>>         rbtree_remove(mm, block);
>>>>> +    update_subtree_max_free_order(block);
>>>>>   }
>>>>>     static void __mark_free(struct gpu_buddy *mm,
>>>>> @@ -750,6 +773,7 @@ static void __mark_free(struct gpu_buddy *mm,
>>>>> mm->free_scoreboard[gpu_buddy_block_order(block)]++;
>>>>>         rbtree_insert(mm, block);
>>>>> +    update_subtree_max_free_order(block);
>>>>>   }
>>>>>     static void mark_free(struct gpu_buddy *mm,
>>>>> @@ -869,6 +893,8 @@ int gpu_buddy_init(struct gpu_buddy *mm, u64 
>>>>> size, u64 chunk_size)
>>>>>         size = round_down(size, chunk_size);
>>>>>   +    BUILD_BUG_ON(GPU_BUDDY_MAX_ORDER > S8_MAX);
>>>>> +
>>>>>       mm->size = size;
>>>>>       mm->avail = size;
>>>>>       mm->chunk_size = chunk_size;
>>>>> @@ -1277,7 +1303,7 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>>             list_del(&block->tmp_link);
>>>>>   -        if (gpu_buddy_block_order(block) < order)
>>>>> +        if (block->subtree_max_free_order < (int)order)
>>>>>               continue;
>>>>>             block_start = gpu_buddy_block_offset(block);
>>>>> @@ -1286,9 +1312,6 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>>           if (!overlaps(start, end, block_start, block_end))
>>>>>               continue;
>>>>>   -        if (gpu_buddy_block_is_allocated(block))
>>>>> -            continue;
>>>>> -
>>>>>           if (block_start < start || block_end > end) {
>>>>>               u64 adjusted_start = max(block_start, start);
>>>>>               u64 adjusted_end = min(block_end, end);
>>>>> @@ -1298,16 +1321,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
>>>>>                   continue;
>>>>>           }
>>>>>   +        /* Not pruned at @order, so this block itself is FREE */
>>>>>           if (contains(start, end, block_start, block_end) &&
>>>>> -            order == gpu_buddy_block_order(block)) {
>>>>> -            /*
>>>>> -             * Find the free block within the range.
>>>>> -             */
>>>>> -            if (gpu_buddy_block_is_free(block))
>>>>> -                return block;
>>>>> -
>>>>> -            continue;
>>>>> -        }
>>>>> +            order == gpu_buddy_block_order(block))
>>>>> +            return block;
>>>>>             if (!gpu_buddy_block_is_split(block)) {
>>>>>               err = split_block(mm, block);
>>>>> @@ -1856,13 +1873,17 @@ int gpu_buddy_block_trim(struct gpu_buddy 
>>>>> *mm,
>>>>>                            gpu_buddy_block_offset(block),
>>>>>                            gpu_buddy_block_size(mm, block));
>>>>>   -    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>>>>> GPU_BLOCK_DIRTY);
>>>>> -    mm->avail += gpu_buddy_block_size(mm, block);
>>>>> -
>>>>> -    /* Prevent recursively freeing this node */
>>>>> +    /*
>>>>> +     * Detach the block to prevent recursively freeing this node, 
>>>>> and to
>>>>> +     * keep free-order updates from propagating above it until 
>>>>> the trim
>>>>> +     * is done.
>>>>> +     */
>>>>>       parent = block->parent;
>>>>>       block->parent = NULL;
>>>>>   +    __mark_free(mm, block, was_clear ? GPU_BLOCK_CLEAR : 
>>>>> GPU_BLOCK_DIRTY);
>>>>> +    mm->avail += gpu_buddy_block_size(mm, block);
>>>>> +
>>>>>       list_add(&block->tmp_link, &dfs);
>>>>>       err =  __alloc_range(mm, &dfs, new_start, new_size,
>>>>>                    was_clear ? GPU_BUDDY_CLEAR_ALLOCATION : 0,
>>>>> @@ -1881,6 +1902,7 @@ int gpu_buddy_block_trim(struct gpu_buddy *mm,
>>>>>       }
>>>>>         block->parent = parent;
>>>>> +    update_subtree_max_free_order(parent);
>>>>>       return err;
>>>>>   }
>>>>>   EXPORT_SYMBOL(gpu_buddy_block_trim);
>>>>> diff --git a/include/linux/gpu_buddy.h b/include/linux/gpu_buddy.h
>>>>> index ddc4eca84175..8037f5a0feb1 100644
>>>>> --- a/include/linux/gpu_buddy.h
>>>>> +++ b/include/linux/gpu_buddy.h
>>>>> @@ -141,8 +141,15 @@ struct gpu_buddy_block {
>>>>>       unsigned int subtree_max_alignment;
>>>>>       struct list_head tmp_link;
>>>>>       bool has_clear;
>>>>> +    /*
>>>>> +     * Largest order of any FREE block in this block's buddy 
>>>>> subtree, or
>>>>> +     * GPU_BUDDY_NO_FREE_ORDER if none. Protected by the driver 
>>>>> lock.
>>>>> +     */
>>>>> +    s8 subtree_max_free_order;
>>>>>   };
>>>>>   +#define GPU_BUDDY_NO_FREE_ORDER (-1)
>>>>> +
>>>>>   /* Order-zero must be at least SZ_4K */
>>>>>   #define GPU_BUDDY_MAX_ORDER (63 - 12)
>>>>
>>
>
