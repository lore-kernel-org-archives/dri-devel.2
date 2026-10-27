Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AEE7606A31A
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 09:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=igbqMxJZ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2B3D110F2E8;
	Tue, 27 Oct 2026 09:03:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F278F10F2D4;
 Tue, 27 Oct 2026 09:03:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793091787; x=1824627787;
 h=message-id:date:subject:from:to:references:cc:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=5sBvIOylEzFG3TJteCecNc6IdjWW9RfxvjCwQwR0rIY=;
 b=igbqMxJZ6Fa4YM/8Y2qyAXEtJnREDnH8tWHKHF3yDFFlaWINWxvO62Vg
 N3u6FrdulbiNdp3nWq2kLvH+xd+ZFMibcUef5wDmkBwVpFQxPeo7ZlNZK
 OlAAIzPliFQgHJIQCWio1sx9Ya+cLSkJEf8PxXSjqHqbXtAPwYJbkGi1d
 sZMobbNwPclOgMNBO9LZIH+6rjSj7DDA8cPAhCHmCqdopVjWDvt79Z4cC
 89mIdg5JAH1jOl/8DsL8KYWBAywh5ELJpyubPXl9+eXc6qUE0Ux+mBOPM
 muE8FguKfIN55T0ejuK377GrOyOh5TPnHjiXN/l/8ZMrMIeo5jeFdcoy/ Q==;
X-CSE-ConnectionGUID: gFyYT/NdQdSbg8In2bawNA==
X-CSE-MsgGUID: 73fA/X4yQ5O/8q352uCufw==
X-IronPort-AV: E=McAfee;i="6800,10657,11947"; a="1678950"
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="1678950"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:03:07 -0700
X-CSE-ConnectionGUID: dAHc0VULRe6TBe6D/ylNRQ==
X-CSE-MsgGUID: cuB7Is1ISZitOcirVQRgbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,180,1787036400"; 
   d="scan'208";a="6370110"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa011.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Oct 2026 02:03:07 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 02:03:06 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Tue, 27 Oct 2026 02:03:06 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.31) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Tue, 27 Oct 2026 02:03:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SWzvzLnETWd6TuiEL8Va77pR6vyGhbzxSfKz6BEBXItBufqJyaQDCaxlqJqu+jXks26dI1Ro+zQZXh/VndMChOt9ve+Sq34NXCH3bSPyOHhGlV6Ilwm3s2T+7XMzY2/Ab8xLToxbgQXYFnC57QwVKn5eedKixm6IunVBG+nSecgbiBdyS4JWP/b9WY7LeiAmlL7oKprpcFdlJnt3TSwIsVbokhcvwQTy7X93jAkNrx7/8FDdIbWsUVjzYA1K4X2oi1mn8/OCxlFJqUjjdH1qh5Ea2hf+z7ss4nIK/87ot8IcqKT2RhwQAoW4gMG54BKwcH4eo8JoDYCYTcz6HLrMoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iYbeh6qS/qRslCwtB6or4Cyl+t5gaqI27EGlJHG7Mxs=;
 b=er9KNAvfrM9kLpQB9fqG09bavwDz/bF3GG1ygvLXcFWpDpd5fPxP2eI4kh+rBpwkFkdX11k1Gf0vFpPexGrWkKM+YKDB+l6hlSGeNWEf0/x20X7TNFqbD3O2vVRAoMRhAPysWIseydjrup39Mw4YfG/KduXj1o6et6bhJcYa/3IKD5QAWgNIBzWGZ9lB1HeinjaSosvAg+hyuZOZNK7ffoVTjrLF5UJxAMZKCS/WpH4vlWflDAD8QLGi0wJRmASXYaC2c1nS9g1+cunC/Xu7OuiDg3frAk9MBpenrD7DKzY/xiXVvFU3YHd8+IUKaRRNq83Hn4yzSFq+r0DlkKcYkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8208.namprd11.prod.outlook.com (2603:10b6:8:165::18)
 by SN7PR11MB6656.namprd11.prod.outlook.com (2603:10b6:806:26e::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Tue, 27 Oct
 2026 09:02:58 +0000
Received: from DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c]) by DS0PR11MB8208.namprd11.prod.outlook.com
 ([fe80::ecb0:7475:84de:ca9c%6]) with mapi id 15.21.0546.021; Tue, 27 Oct 2026
 09:02:58 +0000
Message-ID: <3d9b13db-1530-4a6f-a18a-2c9f8d4d9359@intel.com>
Date: Tue, 27 Oct 2026 14:32:51 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] gpu/tests/buddy: Add range-bias pruning and
 free-order tracking tests
From: "Yadav, Sanjay Kumar" <sanjay.kumar.yadav@intel.com>
To: Matthew Auld <matthew.auld@intel.com>, <dri-devel@lists.freedesktop.org>
References: <20261022051518.486064-4-sanjay.kumar.yadav@intel.com>
 <20261022051518.486064-6-sanjay.kumar.yadav@intel.com>
 <cff7c9a5-b723-4936-bae0-574d5c42e24c@intel.com>
 <af47e34d-95fa-47a1-967a-339b2ce9c71a@intel.com>
Content-Language: en-US
CC: "intel-xe@lists.freedesktop.org" <intel-xe@lists.freedesktop.org>
In-Reply-To: <af47e34d-95fa-47a1-967a-339b2ce9c71a@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MA0PR01CA0082.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ae::12) To DS0PR11MB8208.namprd11.prod.outlook.com
 (2603:10b6:8:165::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8208:EE_|SN7PR11MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: fde1ea8d-820f-4756-23e0-08df340918ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|261026121527099003|5023799004|11063799006|4143699003|56012099006|261009223027099003|261021121427099003|261021123027099003|261022105027099003|10067099003|18002099003|22082099003|6133799003|261026140227099003;
X-Microsoft-Antispam-Message-Info: oD/FF7CpL3SsrC8Lx8DoZLNdKzHVwwB1CXhxrJ9JNw26AoeDwELOlNpgVAPR0gDXa9r0Nl/8zQhZL5OtrI0Ag5QdOZrHUns5jiIx971pnnGbd4XOpTNceEbJwZGhOm5rAD1xaYOlT4oGU3lNdAN1yq1CixdJFOU1fwv5E4bvb/PDkkFuTH+97iqVWJvMLXt8F5E1jCJiAi1txlUMHZ9l8IQdaISSKI37589wlaZsZzp5cpZyFrYU7KW6M9H6R5aCWDd80oeRK6eTQ7aNlel71SF58+GKtCUY+oNdZlasqjh+4CGeWpnaWZKDf4wdKapjTXzumCzNmZbr8xLONjWDpTKvpnEKBauARq6AvH4HamPmOI3xAgSexMfZVhbx9IncKnMHZB2AO1hI+YXbr9nNmE5XDQmw09CZUnbGoGygScgInagTARCMxl6J12a0+hHTRpSI3q7kTBtI+OHANUyZqYTi0av8oPUp2uZ3cvIMphVKRK4a2XG3bRkYt+T3gX2iodOiPZgh7W4/Dd9doB/KxUsyUNmCh9+Zcfh5g1pth49OzPt4K0pjutAT9kyK/3vi8l2xNl/KBXvpFn84MB9esktEB6upCr5gIN59aO4iX3RVcAh7Ks4kW5znUOMCZTAmeMQqPFcYgGGn+l6+gAuHATPLQg0q8ZPI5KtrT1frMrE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8208.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(261026121527099003)(5023799004)(11063799006)(4143699003)(56012099006)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(18002099003)(22082099003)(6133799003)(261026140227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WlR2SXhMQlh0MEtURkRpMmlrdnZ5MnoyazhReFg5amU2UmlMMkRra1hRNFJ1?=
 =?utf-8?B?d0VOYUUwQlhoSlIzc0JkcEwxU0FLS0FueEFEeEc2bnZpWjEzQWV0a09tdzZ4?=
 =?utf-8?B?M0R3T2JNdkVVNWZvcTl4VGNrakx0Ty9YRmJDNDhsNTVhSzlHRVdxSWFINlRP?=
 =?utf-8?B?RTJtTTkvSno2cU8rU3I3MmhQZWRlekIzK2NxaVRoS1NNWWdDekUvQ1VwRWIv?=
 =?utf-8?B?VUNsdEdUWU9HMXg1SHNzNk9kZmxESHl5RlNWdjJML24wVGQ5L1lpUzZVaWNu?=
 =?utf-8?B?ZzdZUFYxdEdUOHdBa0RJTmo3OU56ZlZiR0tyR2hEYlZtK0hnU2YwNVFrR3ZY?=
 =?utf-8?B?eDZQb2xjWDRrNXJHL3Y5ZC9GL0syUVVlL01temdFZ1lzT1N6cVQ2bnR0K2ZW?=
 =?utf-8?B?RjRDWDQ3a0Mrc1R4amRBbzVzVG8rckRZNVVqZHJYSFpFalMvSFVlN1owTUI1?=
 =?utf-8?B?ZFVrSzk0bkxvdVZhMmEwVHBiVURFSFdreHVxNWl2Zkd4ZzY5L09xbjdmM2g4?=
 =?utf-8?B?bnEvbnlEK21vTjZBWGtMUkRFVEV6UkphU25WRXQrWGNmQ2FBbFZ1UE5Od3BI?=
 =?utf-8?B?ZTQzMU9SOXBIa3JjMVJzOWEzSlgydFdPaXFhQkx4SXYzS1hpbDBkZzdHYy96?=
 =?utf-8?B?ekJaYlhaL1h0M3daVnVXWEFneFRQNDNQNE85SExKWnN1SXFkSzBLWTRqNnZF?=
 =?utf-8?B?OGdnV2RGbGZCSVRQMkR3VFNraHJRRTc1RjNiaGlXWmVTem5LQk1RTDI5QUVH?=
 =?utf-8?B?clhld1BoM3JYY280ZnVRRlBmY0dobFIrZUlaa1Y3c0FtYmowU01sdWRjMlRj?=
 =?utf-8?B?cTJYd1hvdzdwYUlJM0tibHE0Rm8rbENJZVFaSW1WMVhHUkU5dS9XVVpqQThP?=
 =?utf-8?B?Y2RUeUJhL2xpMzdKRTkrMzZxTVNXLzZUSnZobFowczBWNDNLaXJ1MzlRMnlN?=
 =?utf-8?B?eTVGNzk3K0RFd3Z3MDl6N0Q3N3I3TW5FM0o4Vm42dXVGYWJjR3RDd1RaRUVV?=
 =?utf-8?B?Rzk4NEh5aW1mSGlFbG9xNk1pY0d2RFpMSTFsNUc3dFhZSEV1ejhZclBJZ2hj?=
 =?utf-8?B?TDVEYlREYU5JSC9ZdndPSG1IVTlUVDMwK0psZ1hFK2ZYbE45Q1BRb0Iza3hr?=
 =?utf-8?B?YzdWb25VczUrOFB6WmlHZkd1bGw2UityTUNua3RkT3R4c3hBZ09OVWk4eklj?=
 =?utf-8?B?a2EyZTdkWHF3Yy9EcktJN1FlRGpJb0Qvc1VqMkNrY05WeWFpSHN5OUtJamtE?=
 =?utf-8?B?Wnk1dzNaOURQM2t2bjEveXkyRG1Sb3V4V0R0cWcyT3lrclY4Yk5uSnpFNzFu?=
 =?utf-8?B?aTB4aVVpVllmNkxtM24rd0cxK0ZCd3RsenZCNGRRRUcwTUloWjZIVXZQMERL?=
 =?utf-8?B?UDRDUlZLZytsa1RkdUcvcXRjV0pQMzNLRUM0YnYyUjJGaC95eWVCY1BhelBi?=
 =?utf-8?B?ZGMvbldLajNQQ2lQcjFxSGJBVnVaRTg4a0RhclNRU3lFd3pGT0ovV0RYTk1L?=
 =?utf-8?B?Q2gxWXdaV3EwdXcxdnlVRnducUlRK1Y3ZXBlS1hTZUVWeXZtYjMrNnJoUTFk?=
 =?utf-8?B?VHFUNkNCSm9YL0RNNU5ObXd1YkRJSjBLNGkwMzdZUkZWbVYvSmMvc05GSWFX?=
 =?utf-8?B?TmlRU2xTRGhVOU9JQzF1bVF5dTNQaG56bUZwdTd1VC90azMxTStxdnI3RzlQ?=
 =?utf-8?B?ZXNjTEhaMlVyTEp1czQ3bXBqSUxXYVBlQ2ZLRWZ0bTVCQ21xeEpOaU1IdDFZ?=
 =?utf-8?B?SndzNFp1UXB6L25BVVVxK0ZkUGYrYnNxZ09aQ0tiV2FjN0VXU0VucThXQkw2?=
 =?utf-8?B?SW9aR3VzL2w2Nk1EVmJtTzB4Z05SUS9RQjVWSThkUmxkZ3U2VW5iNzlqbm8z?=
 =?utf-8?B?amUzVnZXN2JFUEZGb1gxWlNDSktrQ2tXVWw4UmRRV21sOUdDc1IwN1RreGpJ?=
 =?utf-8?B?Z0cwbHc3WXpZbVJJa1ZDZVQ3Y3hqbGl5ZmNnZWFzZFF0cURVVUhMSmtuYnJp?=
 =?utf-8?B?YTNNT0hsT2s1Y2VzZGNIVDN4cHdadVlOQzBQMmt1dkM1Yzd6cWlxZUlxWk84?=
 =?utf-8?B?Wk1pdVluK0NsUGlaWTJUdDZSZEdhTEpCWkJKYnNQTTd2K3RFeGlPZkhjSUdD?=
 =?utf-8?B?SVJYRWpDVUwvVlJrbG5mM1BVd0dac1ZSU0d4eExncWNJaEIvU2pvZTljT1Np?=
 =?utf-8?B?U2pDYzBQLy9qREhTSWxvdUxVQktHVjRjQzZ2eFd5aHRXV0ZHM2NXVm9VaG9s?=
 =?utf-8?B?N0UyNFhXNG9OYjJUTWZJZDhVcktGcnhWTnJwU3gvTlpndWc2YlBWdmRYbEtL?=
 =?utf-8?B?SStYS1RzdEt1UnMwMGV0M0RUUnZ6ZnA5ZFJ6eEx6YnZKc2lPTGwwbkY1K0pk?=
 =?utf-8?Q?OR0iRxWqsgfwMmUo=3D?=
X-Exchange-RoutingPolicyChecked: if3rZuMd3TkiGeKjNSVbJMM9FLB6qgkMWcSUnh5EWzkgjn3TjiR/bW6Dx9AqyzvpGQil3RdtghjIvfgq1aXJj+J+HdzmUwHUJFvTBlqpcIpLVH63h+aR/2cGZDMPk3dNBAf2j+NU3vJzFAEk9tbR4FNQA4tHiR8yorId1F4Oi5gQYL8MnHCScu+yA2y9p9YYQQBTv9ytxZtfobSEEAyduUIPSrYcnZR0lP0qqOCuHSpYWSSOnRlTkQDPHN7PBvQMyrv2AuEoEzsJdvJqeTrOMnGUo7evFkftw16ukWoVcg+9q7JpKH/QBeS2aVR51KH8Dh69ulSMrB8NcXQk4AAniA==
X-MS-Exchange-CrossTenant-Network-Message-Id: fde1ea8d-820f-4756-23e0-08df340918ba
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8208.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2026 09:02:58.6457 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cJFYALAcxYamrzo5aGP2DPxDLrQuI9ro0qLR8yFJsdHVNoi9bEmWCW7rTkf4Fot4VDeozExfA/KzVXFmDixCv3LZoZtx+3jT6ZF5iFVbKXs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6656
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
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 23-10-2026 11:09, Yadav, Sanjay Kumar wrote:
>
> On 22-10-2026 15:15, Matthew Auld wrote:
>> On 22/10/2026 06:15, Sanjay Yadav wrote:
>>> gpu_test_buddy_range_bias_pruning fills a 128 MiB range of a 512 MiB
>>> manager with 4K range allocations. It checks top-down placement, that
>>> the exhausted range advertises GPU_BUDDY_NO_FREE_ORDER, -ENOSPC inside
>>> the range while space outside stays usable, and that freed holes are
>>> found again. To check pruning itself, it hides the only free block
>>> behind an ancestor that advertises no free space and expects -ENOSPC;
>>> without pruning the search would return that block. Allocation time is
>>> reported but not asserted.
>>>
>>> gpu_test_buddy_free_order_tracking covers root creation, split,
>>> allocation, partial and full coalescing (4K vs 64K), rollback of a
>>> partially satisfied request, gpu_buddy_block_trim() with and without an
>>> explicit start, exact-range, clear and top-down allocations, and
>>> teardown.
>>>
>>> Both use a helper that checks every block's subtree_max_free_order
>>> against its state and its children.
>>>
>>> v3: (Sashiko)
>>> - Use div_u64() to avoid an __aeabi_uldivmod failure on 32-bit
>>>    architectures.
>>>
>>> Cc: Matthew Auld <matthew.auld@intel.com>
>>> Cc: Arun Pravin <arunpravin.paneerselvam@amd.com>
>>> Cc: Joel Fernandes <joelagnelf@nvidia.com>
>>> Assisted-by: LLM
>>> Signed-off-by: Sanjay Yadav <sanjay.kumar.yadav@intel.com>
>>> ---
>>>   drivers/gpu/tests/gpu_buddy_test.c | 308 
>>> +++++++++++++++++++++++++++++
>>>   1 file changed, 308 insertions(+)
>>
>> +308, do we need all of this? IIUC we are optimising the range_bias 
>> to short-circuit earlier, by now tracking the largest free order for 
>> a subtree. Is it not enough to rely on the existing range_bias tests 
>> for correctness? Could those not be extended, if we are missing 
>> something in terms of coverage?
> existing range_bias test already covers every case where the
> patch could hand out the wrong block or fail spuriously. The extra
> tests were mostly checking the bookkeeping itself.
>>
>> Also, ideally we don't want the kunit reaching too much into the gory 
>> internals here, except maybe in special cases. For the most part it 
>> should just use the exposed API.
> Makes sense. For v4 I will replace them with a single
> KUNIT_CASE_SLOW perf test in the style of the existing
> fragmentation/dirty_tracker ones, using only the public API
>
>  - fill a 128M window at the bottom of a 512M mm with 4K
>     GPU_BUDDY_RANGE_ALLOCATION allocs
>   - report the time via kunit_info() (not asserted)
>   - check top-down placement and -ENOSPC once the window is full
> at least shows the quadratic behaviour going away.
>
> If you'd rather not carry a perf test at all?
>
> Thanks,
> Sanjay
Gentle ping
>>
>>>
>>> diff --git a/drivers/gpu/tests/gpu_buddy_test.c 
>>> b/drivers/gpu/tests/gpu_buddy_test.c
>>> index 2c6f1da1a6d1..76392329e9e2 100644
>>> --- a/drivers/gpu/tests/gpu_buddy_test.c
>>> +++ b/drivers/gpu/tests/gpu_buddy_test.c
>>> @@ -1595,6 +1595,312 @@ static void 
>>> gpu_test_buddy_addr_to_block(struct kunit *test)
>>>       gpu_buddy_fini(&mm);
>>>   }
>>>   +static bool gpu_test_block_is_split(struct gpu_buddy_block *block)
>>> +{
>>> +    return (block->header & GPU_BUDDY_HEADER_STATE) == 
>>> GPU_BUDDY_SPLIT;
>>> +}
>>> +
>>> +static void gpu_test_check_free_order(struct kunit *test, struct 
>>> gpu_buddy *mm)
>>> +{
>>> +    struct gpu_buddy_block *block, *bad = NULL;
>>> +    unsigned int nr_bad = 0;
>>> +    s8 expected, bad_expected = 0;
>>> +    LIST_HEAD(dfs);
>>> +    unsigned int i;
>>> +
>>> +    for (i = 0; i < mm->n_roots; i++)
>>> +        list_add_tail(&mm->roots[i]->tmp_link, &dfs);
>>> +
>>> +    while ((block = list_first_entry_or_null(&dfs, struct 
>>> gpu_buddy_block,
>>> +                         tmp_link))) {
>>> +        list_del(&block->tmp_link);
>>> +
>>> +        if (gpu_buddy_block_is_free(block)) {
>>> +            expected = gpu_buddy_block_order(block);
>>> +        } else if (gpu_test_block_is_split(block)) {
>>> +            expected = max(block->left->subtree_max_free_order,
>>> + block->right->subtree_max_free_order);
>>> +            list_add(&block->right->tmp_link, &dfs);
>>> +            list_add(&block->left->tmp_link, &dfs);
>>> +        } else {
>>> +            expected = GPU_BUDDY_NO_FREE_ORDER;
>>> +        }
>>> +
>>> +        if (block->subtree_max_free_order != expected && !nr_bad++) {
>>> +            bad = block;
>>> +            bad_expected = expected;
>>> +        }
>>> +    }
>>> +
>>> +    KUNIT_EXPECT_EQ_MSG(test, nr_bad, 0U,
>>> +                "first stale block: offset=%#llx order=%u stored=%d 
>>> expected=%d",
>>> +                bad ? gpu_buddy_block_offset(bad) : 0,
>>> +                bad ? gpu_buddy_block_order(bad) : 0,
>>> +                bad ? bad->subtree_max_free_order : 0, bad_expected);
>>> +}
>>> +
>>> +static struct gpu_buddy_block *
>>> +gpu_test_find_block(struct gpu_buddy *mm, u64 offset, unsigned int 
>>> order)
>>> +{
>>> +    struct gpu_buddy_block *block;
>>> +    unsigned int i;
>>> +
>>> +    for (i = 0; i < mm->n_roots; i++) {
>>> +        u64 start;
>>> +
>>> +        block = mm->roots[i];
>>> +        start = gpu_buddy_block_offset(block);
>>> +        if (offset < start || offset >= start + 
>>> gpu_buddy_block_size(mm, block))
>>> +            continue;
>>> +
>>> +        while (gpu_buddy_block_order(block) > order) {
>>> +            if (!gpu_test_block_is_split(block))
>>> +                return NULL;
>>> +            block = offset < gpu_buddy_block_offset(block->right) ?
>>> +                block->left : block->right;
>>> +        }
>>> +        return block;
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +static struct gpu_buddy_block *
>>> +gpu_test_take_block(struct list_head *blocks, u64 offset)
>>> +{
>>> +    struct gpu_buddy_block *block;
>>> +
>>> +    list_for_each_entry(block, blocks, link) {
>>> +        if (gpu_buddy_block_offset(block) == offset) {
>>> +            list_del(&block->link);
>>> +            return block;
>>> +        }
>>> +    }
>>> +
>>> +    return NULL;
>>> +}
>>> +
>>> +static void gpu_test_buddy_range_bias_pruning(struct kunit *test)
>>> +{
>>> +    const u64 mm_size = SZ_512M, range_end = SZ_128M, chunk = SZ_4K;
>>> +    const unsigned int nr = range_end / chunk, window = 1024;
>>> +    const u64 holes[] = { 0, range_end / 2 + 3 * chunk };
>>> +    struct gpu_buddy_block *block, *hidden;
>>> +    u64 first_ns = 0, last_ns = 0;
>>> +    unsigned int i, misplaced = 0;
>>> +    LIST_HEAD(allocated);
>>> +    struct gpu_buddy mm;
>>> +    LIST_HEAD(tmp);
>>> +    int err;
>>> +
>>> +    KUNIT_ASSERT_FALSE_MSG(test, gpu_buddy_init(&mm, mm_size, chunk),
>>> +                   "buddy_init failed\n");
>>> +    KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
>>> +
>>> +    /*
>>> +     * Small-BAR pattern: order-0 allocations confined to a low 
>>> prefix of a
>>> +     * larger manager. Top-down placement packs them right below 
>>> range_end,
>>> +     * so without pruning every allocation walks all previously 
>>> allocated
>>> +     * blocks and the total cost is quadratic.
>>> +     */
>>> +    for (i = 0; i < nr; i++) {
>>> +        ktime_t start = ktime_get();
>>> +        u64 elapsed;
>>> +
>>> +        err = gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk,
>>> +                         &allocated, GPU_BUDDY_RANGE_ALLOCATION);
>>> +        elapsed = ktime_to_ns(ktime_sub(ktime_get(), start));
>>> +        KUNIT_ASSERT_EQ_MSG(test, err, 0, "range alloc %u 
>>> failed\n", i);
>>> +
>>> +        if (i < window)
>>> +            first_ns += elapsed;
>>> +        else if (i >= nr - window)
>>> +            last_ns += elapsed;
>>> +
>>> +        block = list_last_entry(&allocated, struct gpu_buddy_block, 
>>> link);
>>> +        if (gpu_buddy_block_offset(block) != range_end - (u64)(i + 
>>> 1) * chunk)
>>> +            misplaced++;
>>> +    }
>>> +
>>> +    kunit_info(test, "first %u range allocs: %llu us, last %u: %llu 
>>> us\n",
>>> +           window, div_u64(first_ns, NSEC_PER_USEC),
>>> +           window, div_u64(last_ns, NSEC_PER_USEC));
>>> +
>>> +    /* Top-down placement inside the range is unchanged */
>>> +    KUNIT_EXPECT_EQ(test, misplaced, 0U);
>>> +
>>> +    /* The exhausted range advertises no free space, so it is 
>>> pruned */
>>> +    block = gpu_test_find_block(&mm, 0, ilog2(range_end / chunk));
>>> +    KUNIT_ASSERT_NOT_NULL(test, block);
>>> +    KUNIT_EXPECT_EQ(test, block->subtree_max_free_order, 
>>> GPU_BUDDY_NO_FREE_ORDER);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, range_end, 
>>> chunk, chunk,
>>> +                             &tmp, GPU_BUDDY_RANGE_ALLOCATION),
>>> +            -ENOSPC);
>>> +
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, 
>>> mm_size, chunk, chunk,
>>> +                            &tmp, 0));
>>> +    block = list_first_entry(&tmp, struct gpu_buddy_block, link);
>>> +    KUNIT_EXPECT_GE(test, gpu_buddy_block_offset(block), range_end);
>>> +    gpu_buddy_free_list(&mm, &tmp, 0);
>>> +
>>> +    /* A single hole, including the very last one in walk order, is 
>>> found */
>>> +    for (i = 0; i < ARRAY_SIZE(holes); i++) {
>>> +        block = gpu_test_take_block(&allocated, holes[i]);
>>> +        KUNIT_ASSERT_NOT_NULL(test, block);
>>> +        gpu_buddy_free_block(&mm, block);
>>> +        gpu_test_check_free_order(test, &mm);
>>> +
>>> +        KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, 
>>> range_end,
>>> +                                chunk, chunk, &allocated,
>>> +                                GPU_BUDDY_RANGE_ALLOCATION));
>>> +        block = list_last_entry(&allocated, struct gpu_buddy_block, 
>>> link);
>>> +        KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), 
>>> holes[i]);
>>> +    }
>>> +
>>> +    /*
>>> +     * Deterministic pruning check: hide the only free block in the 
>>> range
>>> +     * behind an ancestor that advertises no free space. Without 
>>> pruning the
>>> +     * search would walk into that subtree and return the block.
>>> +     */
>>> +    block = gpu_test_take_block(&allocated, holes[1]);
>>> +    KUNIT_ASSERT_NOT_NULL(test, block);
>>> +    gpu_buddy_free_block(&mm, block);
>>> +    hidden = gpu_test_find_block(&mm, holes[1], 4);
>>> +    KUNIT_ASSERT_NOT_NULL(test, hidden);
>>> +    KUNIT_ASSERT_EQ(test, hidden->subtree_max_free_order, (s8)0);
>>> +
>>> +    hidden->subtree_max_free_order = GPU_BUDDY_NO_FREE_ORDER;
>>> +    err = gpu_buddy_alloc_blocks(&mm, 0, range_end, chunk, chunk, 
>>> &tmp,
>>> +                     GPU_BUDDY_RANGE_ALLOCATION);
>>> +    hidden->subtree_max_free_order = 0;
>>> +    KUNIT_EXPECT_EQ(test, err, -ENOSPC);
>>> +    gpu_buddy_free_list(&mm, &tmp, 0);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +    KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, 
>>> (s8)mm.max_order);
>>> +
>>> +    gpu_buddy_fini(&mm);
>>> +}
>>> +
>>> +static void gpu_test_buddy_free_order_tracking(struct kunit *test)
>>> +{
>>> +    const u64 chunk = SZ_4K;
>>> +    struct gpu_buddy_block *block;
>>> +    LIST_HEAD(allocated);
>>> +    struct gpu_buddy mm;
>>> +    u64 start, avail;
>>> +    LIST_HEAD(big);
>>> +    unsigned int i;
>>> +
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_8M + SZ_2M + 
>>> SZ_64K, chunk));
>>> +    KUNIT_EXPECT_EQ(test, mm.n_roots, 3U);
>>> +    for (i = 0; i < mm.n_roots; i++)
>>> +        KUNIT_EXPECT_EQ(test, mm.roots[i]->subtree_max_free_order,
>>> +                (s8)gpu_buddy_block_order(mm.roots[i]));
>>> +    gpu_test_check_free_order(test, &mm);
>>> +    gpu_buddy_fini(&mm);
>>> +
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_16M, chunk));
>>> +    KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
>>> +    for (i = 0; i < SZ_4M / chunk; i++)
>>> +        KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, 
>>> SZ_4M, chunk, chunk,
>>> +                                &allocated,
>>> +                                GPU_BUDDY_RANGE_ALLOCATION));
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    /* Partial coalescing up to order 3 must not satisfy a 64K 
>>> request */
>>> +    for (i = 0; i < SZ_64K / chunk - 1; i++) {
>>> +        block = gpu_test_take_block(&allocated, SZ_1M + i * chunk);
>>> +        KUNIT_ASSERT_NOT_NULL(test, block);
>>> +        gpu_buddy_free_block(&mm, block);
>>> +    }
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    /* A partially satisfied request is rolled back on -ENOSPC */
>>> +    avail = mm.avail;
>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, 
>>> SZ_128K, chunk, &big,
>>> +                             GPU_BUDDY_RANGE_ALLOCATION),
>>> +            -ENOSPC);
>>> +    KUNIT_EXPECT_EQ(test, mm.avail, avail);
>>> +    KUNIT_EXPECT_TRUE(test, list_empty(&big));
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, 
>>> SZ_64K, SZ_64K, &big,
>>> +                             GPU_BUDDY_RANGE_ALLOCATION),
>>> +            -ENOSPC);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    /* SPLIT -> FREE: the last buddy coalesces the window into a 
>>> 64K block */
>>> +    block = gpu_test_take_block(&allocated, SZ_1M + SZ_64K - chunk);
>>> +    KUNIT_ASSERT_NOT_NULL(test, block);
>>> +    gpu_buddy_free_block(&mm, block);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_4M, 
>>> SZ_64K, SZ_64K, &big,
>>> +                            GPU_BUDDY_RANGE_ALLOCATION));
>>> +    block = list_last_entry(&big, struct gpu_buddy_block, link);
>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), (u64)SZ_1M);
>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, block), 
>>> (u64)SZ_64K);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    /* Trim with an explicit start re-allocates inside the detached 
>>> block */
>>> +    start = SZ_1M + SZ_16K;
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_block_trim(&mm, &start, 
>>> SZ_16K, &big));
>>> +    KUNIT_ASSERT_TRUE(test, list_is_singular(&big));
>>> +    block = list_first_entry(&big, struct gpu_buddy_block, link);
>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_offset(block), start);
>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_block_size(&mm, block), 
>>> (u64)SZ_16K);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    /* Exact-range allocation */
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_8M, 
>>> SZ_8M + SZ_256K,
>>> +                            SZ_256K, chunk, &big, 0));
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    /* Cleared frees, clear range allocation and top-down 
>>> allocation */
>>> +    gpu_buddy_free_list(&mm, &big, GPU_BUDDY_CLEARED);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, SZ_4M, 
>>> SZ_16M, SZ_128K, chunk,
>>> +                            &big,
>>> +                            GPU_BUDDY_RANGE_ALLOCATION |
>>> +                            GPU_BUDDY_CLEAR_ALLOCATION));
>>> +    gpu_test_check_free_order(test, &mm);
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_16M, 
>>> SZ_1M, chunk, &big,
>>> +                            GPU_BUDDY_TOPDOWN_ALLOCATION));
>>> +    gpu_test_check_free_order(test, &mm);
>>> +
>>> +    gpu_buddy_free_list(&mm, &big, 0);
>>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +    KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, 
>>> (s8)mm.max_order);
>>> +    gpu_buddy_fini(&mm);
>>> +
>>> +    /*
>>> +     * Contiguous non-power-of-two allocations are trimmed, which 
>>> re-allocates
>>> +     * inside a temporarily detached block. Ancestors must still be 
>>> updated.
>>> +     */
>>> +    KUNIT_ASSERT_FALSE(test, gpu_buddy_init(&mm, SZ_32K, chunk));
>>> +    KUNIT_ASSERT_EQ(test, mm.n_roots, 1U);
>>> +    for (i = 0; i < 2; i++) {
>>> +        KUNIT_ASSERT_FALSE(test, gpu_buddy_alloc_blocks(&mm, 0, 
>>> SZ_32K,
>>> +                                SZ_8K + SZ_4K, chunk,
>>> +                                &allocated,
>>> + GPU_BUDDY_CONTIGUOUS_ALLOCATION));
>>> +        gpu_test_check_free_order(test, &mm);
>>> +    }
>>> +    KUNIT_EXPECT_EQ(test, mm.roots[0]->subtree_max_free_order, (s8)0);
>>> +    KUNIT_EXPECT_EQ(test, gpu_buddy_alloc_blocks(&mm, 0, SZ_32K, 
>>> SZ_8K, SZ_8K, &big,
>>> +                             GPU_BUDDY_RANGE_ALLOCATION),
>>> +            -ENOSPC);
>>> +
>>> +    gpu_buddy_free_list(&mm, &allocated, 0);
>>> +    gpu_test_check_free_order(test, &mm);
>>> +    gpu_buddy_fini(&mm);
>>> +}
>>> +
>>>   static int gpu_buddy_suite_init(struct kunit_suite *suite)
>>>   {
>>>       while (!random_seed)
>>> @@ -1621,6 +1927,8 @@ static struct kunit_case gpu_buddy_tests[] = {
>>>       KUNIT_CASE(gpu_test_buddy_offset_aligned_allocation),
>>> KUNIT_CASE(gpu_test_buddy_subtree_offset_alignment_stress),
>>>       KUNIT_CASE(gpu_test_buddy_addr_to_block),
>>> +    KUNIT_CASE(gpu_test_buddy_range_bias_pruning),
>>> +    KUNIT_CASE(gpu_test_buddy_free_order_tracking),
>>>       {}
>>>   };
>>
