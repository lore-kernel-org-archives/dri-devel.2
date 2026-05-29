Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E195CD6E50
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 15:27:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ACAE51120EA;
	Fri, 29 May 2026 15:27:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Ky/a09DZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8D0941120EA
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 15:27:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780068466; x=1811604466;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=YIeLLgpZR3nLWyRFoQmLeRpaKjVmWw6HmlYzJU6HgII=;
 b=Ky/a09DZn98l7fF4z4wv3kggHblGtV4mPkt9XVqq3p1Wwq88Z3O20OZl
 GnLyKd9a+PXtkm5/t25J6OhtIHz/FDZTtOesCctYjJsEX8N0QgVenOXWk
 QbrKClgEry+FQLZkr4jkr+VPJ+BApYS4aPN1b2W+y1pQ3PraVEs6/3MO1
 KfAWqzPO6Zlqa9bgbaqkHsC4M6kO+19jKj9uos8b6ZC8ePV4BdBxyXjfy
 BFFcYzK6CfPCJua8AvIf3eAOlMsHJbTJ7+YjtlcmS+6scpzJm7vkJFCrL
 1//6Y+qjbVAroJYaSBRXZSoT0R3xMQkdYuGPT6Qh18pk2m6LgerstZ+DU Q==;
X-CSE-ConnectionGUID: sl3mdtdQRc6js1nuhj96tg==
X-CSE-MsgGUID: 4DdmNQn/Re6FHRU5nu/YVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="80915865"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="80915865"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:27:43 -0700
X-CSE-ConnectionGUID: iqiCuJzuT8avmM21DKd5XQ==
X-CSE-MsgGUID: ltE3pFVtSrOt0aXILS8piw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="239876190"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa007.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:27:43 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:27:42 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 29 May 2026 08:27:42 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.31) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 29 May 2026 08:27:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=B4wQCTHUF7vCZVS5qyWjFt23AdOS33HtdqOszyDE3iju4FfuLdZ743jZ5xxxkO3t/xk0xzQ1q9NYvWE3TWiWbUYmxxjftO9pTnwXQWs+986oT+ZItoG8do5jCYRpm35mj70UlVW9iIh+1/dPmFFn56kMimRCvYf/aMdu2ug2pbKzv37PcfVt7skOIpavNRuTOaBH19xnJtUhHtt6Sey+Vt33xV+rSJ6IZIiTI8Gp7CQGI6geQxLW3L7l6vhKxAZpa0wSDX8D7EZKss8OjrzNkCQ6rvH/TiSRU//w4dhPyWWZrVco4jyOHComLiUrwTK0YRgH/Lr9iaIJ65dZGJM+fg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HOIjpgLjHCP8wc6v3CfCxzUJWg+IhkpXBAjT17y+49Y=;
 b=iCwoBJp3Hf7L7QEz6mog+dauDtPxmO5LV2VX1L6lE3/G3swv4j/g8w9fhONf1lThqwOmL0TMqRf/9ra9WYziYaKamwl+qhCymZTPZOhV2YDup+hIfW2s2lTulb15muGe3jtZJo/iAOvntz69rzo1xgFIQgEvMD9hLF981b9uWNSclx5b6j+gYcaxakDqQiqp8ta7g+joMw5pIFwMRCT1gfC5juKWfLEXWuQzJJfOgkgGDULX9lh6e7DYfjnmwp4ml2ow9WL/yPWSYXdjlbrXhq67SxzXg+TzHIP4M2/Ym4RUvc13EjUoD1TsGIjuC5scvcPc/5T6F8xJTKceTIUf1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8019.namprd11.prod.outlook.com (2603:10b6:8:12e::18)
 by DM4PR11MB6360.namprd11.prod.outlook.com (2603:10b6:8:bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.11; Fri, 29 May
 2026 15:27:39 +0000
Received: from DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801]) by DS0PR11MB8019.namprd11.prod.outlook.com
 ([fe80::fce1:3bde:b383:e801%3]) with mapi id 15.21.0071.014; Fri, 29 May 2026
 15:27:38 +0000
Date: Fri, 29 May 2026 17:27:12 +0200
From: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
To: Janusz Krzysztofik <janusz.krzysztofik@linux.intel.com>
CC: <dri-devel@lists.freedesktop.org>, Andi Shyti
 <andi.shyti@linux.intel.com>, Krzysztof Karas <krzysztof.karas@intel.com>,
 Sebastian Brzezinka <sebastian.brzezinka@intel.com>
Subject: Re: [PATCH] drm: Set dev->registered back to false in case of
 register failure
Message-ID: <ffhsttic5k5les6get26rzteyg5hknaeydkdzlvfcejdcejz5e@wszixwzpttea>
References: <20260522154037.46892-3-krzysztof.niemiec@intel.com>
 <c55da1fa43e00d755191520e8c03a7659c6e892f.camel@linux.intel.com>
 <ednzkzzbdyabfyvgwkpwqttueqh5taaovhuidfkyc3e2tupnia@7a56amg3bmto>
 <38ac02bee3cc6aff18af80324ae794ab72745724.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <38ac02bee3cc6aff18af80324ae794ab72745724.camel@linux.intel.com>
X-ClientProxiedBy: DU2P250CA0024.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:10:231::29) To DS0PR11MB8019.namprd11.prod.outlook.com
 (2603:10b6:8:12e::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8019:EE_|DM4PR11MB6360:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b17a2e6-1ca8-4d7e-0cc2-08debd96d102
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|18002099003|22082099003|11063799006|6133799003|5023799004|4143699003|56012099006|27256017;
X-Microsoft-Antispam-Message-Info: qoNkG/NLHiSp1A1TpN2MjGFHHzwT/0+1L/r5ATury7ZPaaYBNYsdLYVxLmvEp7r3AEWoZyq7qZsaTomHZyL4iWfAradrOvMDhoWFLm9dGxsyc3A6bPJNFboIT6Dxf1RFO8R+TSrl2FxlYHbfwG7oqfSLZfkxxjWlTy22LY0W87bVozVWNQeLlGK2q3LbtKXes+hvnsuFkOt3z/EUH9VYbvc4+/f5YHsnORncSCH8HD9fcDx+c3pdooKEWTKH9SCQ1ploxrBCJ7/A4K7jGAA02ClIvJOc4PczWaLqrB/wijfqJROMy1JUwOMSy2DCG1sHWBZWW4/zs/VhSqYHpU/f+teSwpMbKmLxDoXSepIK+YMOG8WkzPbGRJ3pc8hAi6+7Acd1GWStwNiW+vsAVVJduSJIzHVkUw7o6sQazCcgM25vze4GjaIAfrLfKvCtYLD8S8bOI/fiX134cmT7H7d2w18POiH+t4VI14EnBRmaep35raaE2dCsZ82pHLUvN/r+aeh2AGT+Dfn4MFkhLcsDTjoMjpCvZ1qHFgl7YCLmBb+NK+Rja3FTBaXp/GtHeWJLvnWn2K82odNH3kHQnkdeSoqtl94EXQaSmLe07e6VAR988FeZcl39hQNCXaBSLBUAmqeL1wS7NlcsLsZ0r00QrA8bi6q27ZQ7t243STdDgUKu2227KhYf5HBJdMGGigQ8kdrAZrRfGPW+VIVy6AyHjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8019.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(11063799006)(6133799003)(5023799004)(4143699003)(56012099006)(27256017);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NVl1SzFPUmJGR3dRbjA2Q3lOeEFvN3Z3ZE5JQXZVTzNpYkc3cUtYTnAzSmtL?=
 =?utf-8?B?cVJmaGhhYUVFTnc5eWdkZUtlTHJHb3RrdjVvT1pKZVlxbFIxN0dGdmlHNUtw?=
 =?utf-8?B?K1RzNkt4bkdHRGJ0akpta0tmcHJ0enZPMEcrK0hsV0JEaVpsNWFWVEFsREc1?=
 =?utf-8?B?SnlYUUZWZXA5QVVmSEtHUTdkUkJMRHllZ2RGSXpNS2VmeTdQcVdheDh5MVdE?=
 =?utf-8?B?OXFZNG56Q3A0Z2ZGUURQWnprWkpTL2xIK3FqNjZkbFUrSEIzWmpjN0tlWW8r?=
 =?utf-8?B?bkZzTjFYWEc1SkZKZlNPK2xHRS9vWHlJZWFaNlhxbFFYaXlYODI4azBPempE?=
 =?utf-8?B?OThwRm42MlBFQU5SZ3kzZWF6bXVDWmN5Q05qYVp6dkQrS1NqR2lkaWFPazhS?=
 =?utf-8?B?Zk9jMDBNUmdXS2VCeis3MmFwR0RRSFNGRHl1a1YwMll5Y0MrdnIxMWJMQktZ?=
 =?utf-8?B?ZlZvYVNRaTdWVURaTkxJYjhERk9oNlkzMTVGWnNyNjRhV0ZIMVMveVNEcEYw?=
 =?utf-8?B?T3RLSllPekFYeTY5eFVpK0xqanl3N0Y4VERnVnJpcDBNTEh3TmxtSXIvY1Bo?=
 =?utf-8?B?clBvN0tXSWh0dlNqSlBLNkNMU0RNYXdkSjJETDhTdDloYk1QVjJ2OVNBeFh4?=
 =?utf-8?B?SFBCZDNyK2N5OWZHRG0zN0hyTktrelVNMG9OT2xpd0lCOFd2UG1qbU1iSC80?=
 =?utf-8?B?U2JoRmEyVCtOdHJBc21zM1dGRmJvQmRWWnc3QXhrRmhJVEZoMGRwOUErQlEw?=
 =?utf-8?B?U3NaRm9QWk15RUR6SUhRaTFBVFlOZGtiWnZuRmtlSFYybnZUZWcrSFRTUEt3?=
 =?utf-8?B?V09zbHRPZUFCUU5iZFJvUTZ0UFc2aGJLQXoxM1lUMHdkTFpwaWQyMGl6QmJH?=
 =?utf-8?B?TUNhc0grZ2hIcThZeWtMMWFBK0VUY2hDNCtIYnJhc3JRS2xhN1hUM2thQ0FC?=
 =?utf-8?B?dVZCSW02KzgwbDhWWW1abUw4N0g0M1lrekRodHVNcWE1Z0d2Y0JwL2cvdUgr?=
 =?utf-8?B?a2crWHg5S05PdDZuTlR2RWxCRmhkaTE3SVllM2pQYUpXMk14eTFHUkFyS1p4?=
 =?utf-8?B?dzZMb2NQYnRDTnhOei9YQjNuaVd0YUJzV3ZnKzYzVVl6QjJVNWRxcGhUWWJh?=
 =?utf-8?B?bXQ3bVZTTVllc0FJWEE2VlIzZHYxWW1xUFQ0RDB3eTJTc2NubWJwb3UreXov?=
 =?utf-8?B?NnF1VlJaUUVvdHUvZ3ZnMUJjV05HR1dPdkJMU3gzWmxnVjU2TW1ZekFmY3R2?=
 =?utf-8?B?SVJOd0JEbXFZUWdsK2FKUkJFVE0rL3lyYUNMaW1FejBlejltTzVZRmtodzB6?=
 =?utf-8?B?UUFpdXAwWm4ycTZ2a3JqenZ6NEZWWnU0L2R0bW1lLzRndDh1SlZKbTdYYlZP?=
 =?utf-8?B?Q0cvK3dxYVdnYjFDQkNsU09IbmRpcmZrTEFtUjYzclZ3dk9Qa2xYbUljTzdq?=
 =?utf-8?B?emJYTVN3V2NlVDFTNDFURkx2WTZuNUpOZFhEb3lMeDJTeVhQK3gxcnQ0QUty?=
 =?utf-8?B?dEgzSVZPUExzb0p4WUpaSVNnOVhxNG0rdG9xaVdKeXZqUWpsUjg5SXNqOXN0?=
 =?utf-8?B?VFI1NUJCNmFJVy9mWlNXTXNnVWJJNVNUZnh2R0FSN0JYUTlNV2FrS2lPcWdQ?=
 =?utf-8?B?bHFtYmZ1ai9yc1hIMWtGTGt3RTZRaTdJKzNuWjkvdzByMTg0SStQakRJNnZR?=
 =?utf-8?B?RTJPRTNNRTFVSG5DcC9rV3JubGZ5WXJyNHk0d2dzczFpQUdnV1BQeGtXL21E?=
 =?utf-8?B?eXNKTk1FYytkRzZMeE1FNFZUSjlxa1B3RFdaR2ozZnlkWVczYlc0d3k5THVE?=
 =?utf-8?B?QnZPdXpMTm93dk1qOG84Tll5OGE4aWdxYUxiMzgzOUtweXkrQ0NwQm4yUHVD?=
 =?utf-8?B?SnJRYVlQU2c1aENHTzBIaTI0dEtDbXRNRDg4c0xKSUtENENHQXF4TVMyM2Vv?=
 =?utf-8?B?Tm5hMGtFbURNMXJhY1V5SkNmRHRxTWZ6V1lhcnF3WTBFakEwbFhIOFp3dEdv?=
 =?utf-8?B?Vithc1dsMlJDbFFBYnFDUkM0ODRrQ2tScFladFFBV3ZQYnBFT2dwZzlhNjZv?=
 =?utf-8?B?Zk1WVXcxa2dEaWtxV0UrVG5Fd1hYMklxb2xJMWNaUEZHeXkvWHUxU0JRbFhh?=
 =?utf-8?B?UFltVk9rQU5pL0FLcGg3WldZTVVhUm5hU0RrM3lCekF3UHpPaUhaNjZVb1VB?=
 =?utf-8?B?d25FdXQ0Q1NQNERETXNBSEpGazJ1RWtUcnhZZDJ6ODVTbVlkeXR4WmE3eVRF?=
 =?utf-8?B?bEJRdFozQWhzcnVZSzg3QlJQd2tOelkyc2lHcG51VW5UYlZIRUdOWms1UHJP?=
 =?utf-8?B?RTBoU2VJMXJZRG82MjNuK1N6WG85ZHhEOUpSWEZ2dGVIU1N0K0JDK2VUeGUy?=
 =?utf-8?Q?/T8+2igqxPYWPLyY=3D?=
X-Exchange-RoutingPolicyChecked: jQeqv6f8O57cKfWPu8JwPK48BANfIPpdbBM9A+XEYgf3/N8+Ghr7xC/QIVqsD8Xw7F4gDXfnz72mMvVeJTKzUGZKqLEdlaHNAolQOQe3aa3hcinmCyi/Mdkkvq3weKLXKG4E2J7Xo9OSKXOsF2pYmh/um9bMsNFko7GM6nzl/JSqyerNO254/jBxBClMNWYyVhBSC8oFNSnxNaR49jLCKHBwT5fgR6T6/FQ0CQ2ELZX0SkYDQpJDMYVCEajnNvhqBmOXvfl8wg/qoylBG8c2mt+1Pz2Y16AzY7jSEAAewL+wgoo2cDFusaFLrs+9SuM1ntECioTKZYIB40RcnuYslA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b17a2e6-1ca8-4d7e-0cc2-08debd96d102
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8019.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 15:27:38.7366 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GiNg7cIYM4T0rmIacgshjcodIAt6m9mqnf24QvK/ndbqyVoV3N4c0DrV+ZA7zI6xvq56ta7Lx0fk4uHQa0ap1U42h4/XrKJ6x0bQnXgMpKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6360
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

On 2026-05-29 at 14:49:29 GMT, Janusz Krzysztofik wrote:
> On Thu, 2026-05-28 at 17:24 +0200, Krzysztof Niemiec wrote:
> > On 2026-05-25 at 10:16:32 GMT, Janusz Krzysztofik wrote:
> > > Hi Krzysztof,
> > > 
> > > On Fri, 2026-05-22 at 17:40 +0200, Krzysztof Niemiec wrote:
> > > > The dev->registered variable was initially added in such a way that it
> > > > is only set after all functions that could have failed have been called
> > > > and haven't returned an error. However, since then, the function
> > > > drm_modeset_register_all() is being checked for its return value, which
> > > > opens a possibility of failing the register after setting the registered
> > > > variable anyway. drm_dev_register() cleans up after itself in case of
> > > > failure, mimicking the functions called in drm_dev_unregister(), with
> > > > the exception of drm_client_sysrq_unregister() and
> > > > drm_panic_unregister() (_register() counterparts of which are not
> > > > checked for their return values), and the dev->registered flag.
> > > > 
> > > > This creates a situation in which after calling drm_dev_register()
> > > > nothing is registered (as the function entered an error path and cleaned
> > > > up), but the device is reported as being registered according to the
> > > > dev->registered variable.
> > > > 
> > > > This, for example, confuses the WARN_ON() in drm_mode_object_register(), which
> > > > is raised if a non-dynamic mode object is attempted to be unregistered
> > > > in between the drm_dev_register() and drm_dev_unregister() calls. If
> > > > drm_dev_register() fails - meaning the device *isn't* registered -
> > > > currently it still reports dev->registered = true, which triggers the
> > > > WARN_ON(), even though the usage is correct in that instance.
> > > > 
> > > > Set dev->registered back to false in the error path to prevent this.
> > > 
> > > While you've also submitted a patch ("drm/i915: Remove drm_dev_unregister()
> > > from the error path during i915_driver_register()") that adjusts i915
> > > handling of register / unregister steps after this fix, have you checked if
> > > other drivers are prepared for that and won't be affected?
> > 
> > I just did; there'd be a problem if in the error path triggered by
> > failing drm_dev_register, some driver relies on the dev->registered
> > variable to be true to do its work.
> 
> OK, maybe my doubts about other drivers were groundless.  The flag is
> described as DRM internal after all, and cleaning it in the error unwind
> path seems fully justified.  However, please review your commit
> description.  Trying to understand why drm_mode_object_register() might
> call WARN_ON() when dev->registered is true, I found it doesn't, and that's
> probably its _unregister() counterpart that may do that.  With no stack
> trace attached, that's confusing for a reviewer.  Such WARN_ON()s may be
> hit not only due to inconsistencies internal to DRM, but also as a result
> of drivers incorrectly / unexpectedly calling some DRM functions.

Yes, I've made a mistake in the commit log, I meant _unregister() - see
[1]. Do you think going through how i915, specifically, hits this
WARN_ON() would be a sufficient example?

Thanks,
Krzysztof

[1] https://elixir.bootlin.com/linux/v7.0.10/source/drivers/gpu/drm/drm_mode_object.c#L106-L117

> 
> Thanks,
> Janusz
> 
> 
> > 
> > There are two main patterns of doing the error path in the DRM drivers
> > I've seen - one is just directly returning from the overarching function
> > with drm_dev_register()'s error return value. The other is invoking the
> > .unbind handler of the driver via component_unbind_all(), and most of
> > the time those call drm_dev_unregister() right away, which sets the
> > dev->registered value to false anyway. In these two cases (if
> > drm_dev_unregister() is called in the second one), the problem doesn't
> > affect the driver at all.
> > 
> > In the case of i915 not setting the variable to false on failure
> > triggered a WARN_ON() in drm_mode_object_unregister() because that is
> > invoked indirectly in the error path due to the complexity of our
> > init code (even xe just returns directly instead). If another driver
> > calls that function in its error path, it will just silence (correctly)
> > the WARN_ONs there.
> > 
> > The only driver that explicitly checks for dev->registerd in its error
> > path is msm, which does that to see if it needs to invoke
> > drm_dev_unregister() during unload. This patch actually fixes a bug there
> > because otherwise _unregister() would be called even if _register() fails,
> > which is not correct.
> > 
> > All other uses of the variable are outside the error path of their
> > respective drivers, so they should function as intended even after the
> > change.
> > 
> > Thanks
> > Krzysztof
> > 
> > > 
> > > Thanks,
> > > Janusz
> > > 
> > > 
> > > > 
> > > > Signed-off-by: Krzysztof Niemiec <krzysztof.niemiec@intel.com>
> > > > ---
> > > >  drivers/gpu/drm/drm_drv.c | 1 +
> > > >  1 file changed, 1 insertion(+)
> > > > 
> > > > diff --git a/drivers/gpu/drm/drm_drv.c b/drivers/gpu/drm/drm_drv.c
> > > > index 985c283cf59f..92403d79bb64 100644
> > > > --- a/drivers/gpu/drm/drm_drv.c
> > > > +++ b/drivers/gpu/drm/drm_drv.c
> > > > @@ -1116,6 +1116,7 @@ int drm_dev_register(struct drm_device *dev, unsigned long flags)
> > > >  	if (dev->driver->unload)
> > > >  		dev->driver->unload(dev);
> > > >  err_minors:
> > > > +	dev->registered = false;
> > > >  	remove_compat_control_link(dev);
> > > >  	drm_minor_unregister(dev, DRM_MINOR_ACCEL);
> > > >  	drm_minor_unregister(dev, DRM_MINOR_PRIMARY);
