Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E6FC606AE17
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=T26A6xZm
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 00B2C10FF0D;
	Wed,  4 Nov 2026 21:17:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 169E710E3AA;
 Wed,  4 Nov 2026 21:17:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793827073; x=1825363073;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=Gp5DxVSgeTIr3aDsb1erSjnZJU8L4BppgtbnxfQkm+I=;
 b=T26A6xZm8T8yO/wWkNRmciVHozn0vG4e3CxytNc6JAnVDyyBuXkiabU0
 8gazZHvMsROXn65gPgCNQNFLDlhOMyP7Zk2rMfuJ+U+SMOiPA6c5aat4/
 KfGTTFazNcmOFG/VyLq0ZM7aceuRRe+1HjtSNHbXkGGw7T6eHzVmGyB0p
 Vn3gLiJ2LhwzvVbT0R2eCQdE3sn9kU468NVeU6FaB+lVhKZTf/mptOT/0
 JRvGNeiEWljrBj+RqUA250rabGMXnswmZGnbQLuTtFeFXd7sHKHoJkh7G
 VAyHSVMiIs0SzPFLOfI6xS7FeiRAD7jM3UipKQdRS+s5sNbStMN0OWF/o w==;
X-CSE-ConnectionGUID: v6TMuF0QQ8ya58jz47o9Xg==
X-CSE-MsgGUID: Q++Rq/V4SdyxeHHD3d5TaA==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2483259"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2483259"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:17:52 -0800
X-CSE-ConnectionGUID: v4c8YMjzSuSMFGO6xuQ5ew==
X-CSE-MsgGUID: rLQX43+dSourTNR85neFpw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6938601"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:17:51 -0800
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:17:51 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 13:17:51 -0800
Received: from SJ2PR03CU001.outbound.protection.outlook.com (52.101.43.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:17:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Mw0UGJkcbYJSpjJxijOjzm3kohSzu3mpFE0Hg9wT/6+RJfUJ0hv4PZtJBHkhQSPOqMwcIfqLNQN5yuplXD0SedmQQqErWmi6iJwU+26/X2uAkParoj4s2jvNaV6yk5u+NKDqMPBDuq1tWC8hQ8G9/Fso0ZIBekXi2eqvvoppLmOkG8D/X/HpMfiy8a+kDn4nSgtLp6QMEps9mPbxqTIJsYAREye7HhqUN1Tm29PcBMMTtEfUU2dLbVVZ0RUGySnlaWvUMw5p/lyd3ggBqmYrrfIpG2UsWmaqO1Hut0cxS6iLyJvP+ChhRsLD1JrCYxPMDefXvbJkLpdAam2pvD1q+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HmX/Ja/tkaKt9wC0ebyR1S8v/gqbtDwEjkw8dZgeEH8=;
 b=GGtSSgjIDtXReUiua5H0qrZ1CWJM7WQDhgB11zy8l9f1fdGst6zde+Ne7KN9G6eykKr4cDxUvfHLhWqhyQ431uGfIDjmjZ4n9P1bSZjMit1vs7fyCu9r8jpjr1b0BS6jHQ9rgss3ysu1h63AODdYMHN3G2ENkRzZm4BDv29mZTJ3wXUj+Pgv4WvclFOnyjIDySOK4Uqd6jcblEr2xWDrk5JwMyLGbTWE0ZgtpP/jEN56Dq9vJVR5Oj6AVq+zd2UEdSRwV/CLQOyqQYEdn0t7n2Y2BxCieWeAb1iuwRa2w3ZBRWJaYwzNLqqfgIyF4EWCYnhVqdQtmZObQgSWFlcBIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by LV0PR11MB797244.namprd11.prod.outlook.com (2603:10b6:408:3f0::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 21:17:49 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%6]) with mapi id 15.21.0569.011; Wed, 4 Nov 2026
 21:17:49 +0000
Date: Wed, 4 Nov 2026 22:17:42 +0100
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Krzysztof Karas <krzysztof.karas@intel.com>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Jani Nikula" <jani.nikula@linux.intel.com>, Andi Shyti
 <andi.shyti@linux.intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH v6 5/6] drm/i915/gt/selftests: Use gt_* prints in gt
 selftest helpers
Message-ID: <auueW7AuAsq2mx6x@kniemiec-mobl1>
References: <20261104111104.946617-1-krzysztof.karas@intel.com>
 <20261104111104.946617-6-krzysztof.karas@intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261104111104.946617-6-krzysztof.karas@intel.com>
X-ClientProxiedBy: DU2PR04CA0226.eurprd04.prod.outlook.com
 (2603:10a6:10:2b1::21) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|LV0PR11MB797244:EE_
X-MS-Office365-Filtering-Correlation-Id: d8947587-01df-47dd-eb30-08df3ab91402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|4143699003|11063799006|56012099006|261021121427099003|261021135927099003|261021123027099003|261022113327099003|261009223027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: kjFVCd+E51rFA5mH5gImZO4SmpxNrw9lUlagth3K9Kc6vQZOUPWIFWNzclunau52enduGzH46E6zyGjZ1yzWH5nR9tMim5cfSfTpGIphB9Sqlf2Cv+tydqSHp4hp/Xt721pJ7oJVdMl7eFRPgm8fz+hpXyIzJumadKif3qp+fol+r5KgyMdJExEfDj+sBdD1f9arjnlNKJdVE0N+ENIsjsVjg4Zm2EeQGBHzAs2TU85g8S9zRNYxRxY/8vPpP+3zEbfuTM6qtOarD8SrltGkC7JWtJZXvgoo3Wmp4LWCHgxm3tJ/yEnst/JbXm+oBhrNovtKbaxv/559JeRCFVaiiXq1cBg2TE8aFPC23LO+ysN/5cRSSX+2iT4C3YprkvMbjfjL8LtI57apZrqg8t4/qe16Ul4aVwQ6TuK2wXpPEY9Lr0QrBpn9sqld7XTYxRGRVslt2tZ7bXFqzvs6iQPKTLaLQC2qVCixWs+a0182cG5FDZOMCDwAsvsCX/4bkacIYLxN6QsCyJ+Mb7MIse44qeCb5ro0+mibE9kxbYRYQwkHvZJq36H9NlEwkHeka4aaWakLp9L3aZrphzUoWKw5duzpxSCtg2shVW6fwV0Y3TcMBvM9MQNibomeJiGjVOedR7W+W8qgIEacVpsP1WopuVhcrX1lfKv/NhDeKCClWpY=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(4143699003)(11063799006)(56012099006)(261021121427099003)(261021135927099003)(261021123027099003)(261022113327099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?azA2dVJUeE85SW5OR0ZIcjN3eE5kQTJCTjE1elJPanpkV0trcE5pb3hBN2Jt?=
 =?utf-8?B?WFlJaU84aXJWYytnbi9ydlNQS2N0K2FCYVYzTHpjYmNXV3RNTGdiUDZYRUtP?=
 =?utf-8?B?WVhyT2VMUmJHVEFLM0lrMHNkK0V5MFZITE9xbThrR0t1TzhWVkJIOFQvMWFV?=
 =?utf-8?B?VjhZWFBuWDR2S1N0cmZrQjN3elBZUnVEVkZjYWxZODlCVDRqRHhERTJhY1lC?=
 =?utf-8?B?WDY4UHlFSlNNbjkwTXJvSFo4S0tpUmpBQ1VHcWwyL3Bqck1kUnFHVlA0T3FT?=
 =?utf-8?B?eHI5V3l1MGFBSCt3NHY2NXdNS2lEUTAxOHM3cnBnY0d4RVhQU0d0UjFCMXFN?=
 =?utf-8?B?cE1CdS80MjJuczRZQ3oveXRiQzFSd2ttbEc5REpQTXdDQ1NpTCtONmh2K29N?=
 =?utf-8?B?c2dCQWJTbUF3bWJzcVRoMlBmSFdmKzh5Mmg5bzBOQzkxMWFNMEJtdDBnbzNC?=
 =?utf-8?B?K0tJbGhHbXI3ejd2S0ZPeWpiTkhPeWYxb0pyRWNNNUQrOUg4N1BEMTB0eHRY?=
 =?utf-8?B?V1haTVl3WEhGQXJQdnpvR3lMczBxQXBXWlRSWjdsQUp5Qy9BNmdWSTJlMjZa?=
 =?utf-8?B?S0dXMmF0alhESWtqWjFGbWVDYVZ1K0ovOGE0d2lGcXdGM2EwRmV5OHBLMEp0?=
 =?utf-8?B?KzVqd28yY3lqV0tHUVVLWjJJNXRpY3Qxa1RvYWdqS1dXc2VrcUEycEVBVUFh?=
 =?utf-8?B?RzA5YysrUmp6em13YklXQitqSWVNWmdiQlR3K01vcTA5aURjeSt5dERjVFlB?=
 =?utf-8?B?Q0VISnlqb0p6ekRvc0dCR1lPK2xLWTNZRnN2UEZCeS9UQXl2eHpWS1VUM0FS?=
 =?utf-8?B?VjJpb0tXbUorV1UyNnZkUzIwcW5RZythWkU2aG5GcjNFd1g5cTJRQUFzOXlT?=
 =?utf-8?B?WFROVU14cDhZUy9RaDF3QUZMSUwxUEN1d0FtdVdqVmF5MkJSbVVlZkt3YXNE?=
 =?utf-8?B?NXdOdzFoQW80YVIwZWlJOVc5bk5ySm5PRi9hb2F4OVBuODBjK2diQW5lZlpK?=
 =?utf-8?B?d3c4bThrTUdVVC9IOEtIa0xZdzcyQ3ZtaEJwaXNZRFVIdUZGUVBNQzdZZGl1?=
 =?utf-8?B?UGxjWlpGQUFmL2QxVmFHS0ZsWGVSa1ZFUllVK0pOWGdjaElVV1JiNHhRMFNW?=
 =?utf-8?B?YmF3aUNlSmVmWWxuTUJvVUJ4elRkVTRRMFkyTmJ5VWo2RTd0OFFSbFpXSFFp?=
 =?utf-8?B?bmRPR1BXVWlBTDlPWlRiV2Y4UzJpcFhJa2xaWGNBbld1cWZGYzZBaUdrQ2cx?=
 =?utf-8?B?S2psZVo0azFpZWtxMFpPUzJoeTNpcW1lblIwRk5BcHM5d2NuSWVxZ1BSNTV3?=
 =?utf-8?B?YzVOT2RIVDduVWtmTjZYTDNnMkM3VFIzaEN2NG9FTVNnZDZYZTVpMktqSWpy?=
 =?utf-8?B?TEwveVJHVElpelFMN3QyT25GSlRLNDVYaWhteldRR2pDQU41STlWbkNxcHRj?=
 =?utf-8?B?YmxNVzV2c2kwa2s1NHEvM09FQmFGNCtRbmV6YmQ2L084VTdXUG4vakkxZm01?=
 =?utf-8?B?TWd6YTZRcGVVU2l2SHN4YWg0NXk5R3JXNW5TcjZ1SngyWWNXK3Bxc1I4amxW?=
 =?utf-8?B?V3o4ZWpHdXcvb2Q1dlNJZkdvSTk0VnpqbkZ5SXVJYUwydGtkOCtYeGZuUDhs?=
 =?utf-8?B?TXFVMTY3M3hUZ1pkV0RCTWhFR2FtN09uSDJqd1lvWFJoL2tuN0NzSElNdnpQ?=
 =?utf-8?B?UjcxanB4Y3BoN09TYVNldlpRckhycXZRYndDMDhVUmFYU0tXMjBUUWtacllp?=
 =?utf-8?B?Zno1ZHBESHNUTlZ6V0RHTlNrSzZkSmRpTjR2anNzY0FOVDh2Yi9SbVA3d3Q5?=
 =?utf-8?B?blhxam1sWTFlblIrV1FNWXVNTmkyYkNrM2lFWlFJWldScDZCOHhSOUFxMGlK?=
 =?utf-8?B?SVdNWlhZVVBJbStjVkpXVmFTZTVGYTNEU3BzZld6cHYyUTZiS1pvS0pxSjJI?=
 =?utf-8?B?aHN3WEFoNUh5L2ppUkRrTUxWenVUZkVtZGsxTEg1SGhhanNLY21XWUZiTEd4?=
 =?utf-8?B?ckg2NitSeGUxUnR1MGlYUFVtak1WT2dURDZzdWh5SDFBSk1pd3FmS0RGa2JC?=
 =?utf-8?B?ck50Z1pYQVIwVnVLZ1RBMmxvVUt5SWczZzd2VEJSYkVBSnVZRGljSXJid0Jl?=
 =?utf-8?B?WWF2WVdheTVqZ2JPaFVGY3lrQ2xFMmlxSU5wM0drWWhqQW1GNHNYUVpZb3VG?=
 =?utf-8?B?RnBpSThMWTRBM0kwSEdCT0NDTVZwYi8yKzc0RC9IdHhvWWoyeTNaOUN5TG5h?=
 =?utf-8?B?QkQ3ZEtJYTd2SFRqWTJ2MThoM1QwSkRJVGd6V0FiOWZXRHBoMEtseXYyMmp5?=
 =?utf-8?B?SVhrRjdPbVdYTjVRSUFiY1Z4eWZEUENwVUpDNXVQNlRwd0xMcGZhOXBEaHVi?=
 =?utf-8?Q?YZ9ViNQ4D9jzeq/o=3D?=
X-Exchange-RoutingPolicyChecked: fhBIfeAOkWcQKbREgk5s4iriLIcE3iZG5NqcUpIHP6U8DvboNnzeRtO5m9kEuWw30LdtW/Wmx8HuUh/Dhkg6uQbdq3sue/qC46bKmrUqefGZ1RQ9sqrwWs95/eCDlOyO49cBd4Nj7J+OKZSAhveR/hFNd2DiJbYCIxg5PyGrpy6VQdE8QxHIlPRM1eAClNHMHl/imiTtnL1FMMwzwrz4GAvFF86fvMEtjwtZvtUeMnCboMfE9+T5HhAK93PIox8Fo9hlja2GvGmnTZfl6ef6Ujmoxjo8q5o0RH5WRuhhORMBo+2udrL9/MWOyK3/AsRe09sW+ezOSSAevqB8GNFLRg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d8947587-01df-47dd-eb30-08df3ab91402
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:17:49.1388 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cDa4Rd7G3clVK1rgNwyO7tU2EhiqoyXbu247UPMQ0eXkdXfkSztjC5co24IwcxAECm4XkSu92qWLWAB03MR+7MeLTQHWH5aAvYL2/iBG1Ks=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV0PR11MB797244
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Krzysztof,

On 2026-11-04 at 11:11:03 +0000, Krzysztof Karas wrote:
> Move away from generic pr prints to GT aware gt_* versions,
> which tag each message with device and the tile it came from.
> 
> Signed-off-by: Krzysztof Karas <krzysztof.karas@intel.com>
> Acked-by: Jani Nikula <jani.nikula@intel.com>
> ---
>  .../drm/i915/gt/selftest_engine_heartbeat.c   |  7 +++---
>  drivers/gpu/drm/i915/gt/selftest_llc.c        | 25 ++++++++++++-------
>  2 files changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> index b893a8fde895..1164dd4aea11 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_engine_heartbeat.c
> @@ -7,6 +7,7 @@
>  
>  #include "i915_drv.h"
>  
> +#include "intel_gt_print.h"
>  #include "intel_gt_requests.h"
>  #include "i915_selftest.h"
>  #include "selftest_engine_heartbeat.h"
> @@ -202,7 +203,7 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
>  	engine->serial++;
>  	flush_delayed_work(&engine->heartbeat.work);
>  	if (!delayed_work_pending(&engine->heartbeat.work)) {
> -		pr_err("%s: heartbeat not running\n",
> +		gt_err(engine->gt, "%s: heartbeat not running\n",
>  		       engine->name);
>  		err = -EINVAL;
>  		goto err_pm;
> @@ -215,14 +216,14 @@ static int __live_heartbeat_off(struct intel_engine_cs *engine)
>  	engine->serial++;
>  	flush_delayed_work(&engine->heartbeat.work);
>  	if (delayed_work_pending(&engine->heartbeat.work)) {
> -		pr_err("%s: heartbeat still running\n",
> +		gt_err(engine->gt, "%s: heartbeat still running\n",
>  		       engine->name);
>  		err = -EINVAL;
>  		goto err_beat;
>  	}
>  
>  	if (READ_ONCE(engine->heartbeat.systole)) {
> -		pr_err("%s: heartbeat still allocated\n",
> +		gt_err(engine->gt, "%s: heartbeat still allocated\n",
>  		       engine->name);
>  		err = -EINVAL;
>  		goto err_beat;
> diff --git a/drivers/gpu/drm/i915/gt/selftest_llc.c b/drivers/gpu/drm/i915/gt/selftest_llc.c
> index 779fadcec7c4..71ea688be154 100644
> --- a/drivers/gpu/drm/i915/gt/selftest_llc.c
> +++ b/drivers/gpu/drm/i915/gt/selftest_llc.c
> @@ -3,6 +3,7 @@
>   * Copyright © 2019 Intel Corporation
>   */
>  
> +#include "intel_gt_print.h"
>  #include "selftest_llc.h"
>  #include "intel_rps.h"
>  
> @@ -22,8 +23,8 @@ static int gen6_verify_ring_freq(struct intel_llc *llc)
>  	for (gpu_freq = consts.min_gpu_freq;
>  	     gpu_freq <= consts.max_gpu_freq;
>  	     gpu_freq++) {
> +		u32 scaler = GRAPHICS_VER(i915) >= 9 ? GEN9_FREQ_SCALER : 1;

Giga nit: gpu_freq is "unsigned int", not explicltly u32, and when the
ternary expression was inline I'm pretty sure the (implicit) cast is into
unsigned int, and not to u32. Personally I'd follow the type of gpu_freq
but I am aware that this is complete pedantry since currently unsigned int
is (basically) guaranteed to be 32bit anyway (and GEN9_FREQ_SCALER is
currently equal to the huge value of 3 so it probably doesn't matter much
anyway)

Disregarding my rambling:

Reviewed-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>

Thanks
Krzysztof
