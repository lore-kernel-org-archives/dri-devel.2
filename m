Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3164CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 10:21:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2E5310F5F9;
	Thu,  1 Oct 2026 10:21:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="gxGwP4r+";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E80D710E14A;
 Thu,  1 Oct 2026 10:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790850107; x=1822386107;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HVJclnFbLGdkCL4c68Af7aq/z7WFbfwKzpxIWnJ8pH0=;
 b=gxGwP4r+9XVlz1pyn28jTRhtcYKteLQ0Fbt64r1qAQ7n5bSbbHdc+Tgk
 T3UYOKIgrhTaRyOqnsu/xQLX1lin0tmTZaqz2bK1UeHfOrMHg6jWAkalN
 gC1/LQ6X2APDftdUbaZGKVlOZFKT56kGnJIa+4S+TmltMsIpbPWEvswA3
 PcTm6o5hqHMQ/Tfu3iGOT+ZohJhIJiqiGHdmzfkz+ziFsNCn1xPRCwcPB
 9EP0EbIpu/+rB0DNzKjzz7qpWdkGwN7wMvgcPySCAgtu2daZef6I9HS4k
 u72bxUPqAk3r02kEVAZ2LH5CCd44P0icvEkI8d9krqfrMid16WakBAQ6z w==;
X-CSE-ConnectionGUID: HY9fg2dYSjytII24SmFnRQ==
X-CSE-MsgGUID: uEO/g665TICWEo2eXAYSlQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="79162744"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="79162744"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 03:21:46 -0700
X-CSE-ConnectionGUID: +6nCuMFjQ4qY5D/j3R00yA==
X-CSE-MsgGUID: W0bQG3ZbRSCjtG+VeI7EoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="272386776"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa009.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 03:21:46 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 03:21:45 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 03:21:45 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.44) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 03:21:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t1GfNaJ25R68KkKrZNGrXwdW5DHFp2bf8yzShmfUsh0mq4yV+tRL1B2Kc7Yzt+x8L5pec0RQLeQf4V6KNuK2IS070EeQGCtQMVarDvA15+5IOIY5z7m30/irduDu9ZLNTM8ZDdxaT6moWIhE0/u9Cdn4XyhQ/dCep+bR1JB4zm9G9x5xhEV4X90XdFbjwQMFQQCDogbKrcouC0wEsIqgstEfdItZci1GqfJm8uuOfqKNW6M21LX6FzbrUVWzgQLoAhn6jn5CaZfnX2ZU/8nXkjWBweNgwarn3Q/Et1uuqRCbB4hh7T2EzC6u7mzCnV0Lh0DyS89EF1/0qbaEH2K8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XSOeASaclkiaBYg4LcaVh3nuUXxNXCmhW0mrUVdl9E4=;
 b=hYdpXRRCIaoFJEHEL8P/vbbOfY7AgN7ec/8AuxlwRkNcNd7Ks86qzzrg1cPQNIPFl7lTPEuvXtTnc3sRCcZnO9LJsdZcfApVv/Of4iXif+RVWg+Hv5I/HgpORFSRP8sSE3QFU4V0ljLZRjEojmwvnU4Y18d7+kilgXn4dycWLwpx7WKpNbS2kshbA8sFnwbS68SL7A7DWKKBPHR5e8/UaBA8fba8+/lET0a+kkZ9En5qvcX3j+OS89qBH4rR3GJBQb3XD0UzZBmxczxFCvVyox/VMU1zElcTwV2oVUvMW8FkRyeQRizrtbXqWKbQdVjauxxjDV8CgWjMggBhgPWndQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB7424.namprd11.prod.outlook.com (2603:10b6:510:287::7)
 by LV2PR11MB528201.namprd11.prod.outlook.com (2603:10b6:408:40f::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Thu, 1 Oct
 2026 10:21:44 +0000
Received: from PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2]) by PH0PR11MB7424.namprd11.prod.outlook.com
 ([fe80::c448:1138:6981:52e2%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 10:21:43 +0000
Date: Thu, 1 Oct 2026 10:21:29 +0000
From: Krzysztof Karas <krzysztof.karas@intel.com>
To: Andi Shyti <andi.shyti@kernel.org>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <iommu@lists.linux.dev>, Andi Shyti <andi.shyti@linux.intel.com>, "Robin
 Murphy" <robin.murphy@arm.com>, =?utf-8?Q?Micha=C5=82?= Grzelak
 <michal.grzelak@intel.com>, Janusz Krzysztofik
 <janusz.krzysztofik@linux.intel.com>, Sebastian Brzezinka
 <sebastian.brzezinka@intel.com>, Krzysztof Niemiec
 <krzysztof.niemiec@intel.com>
Subject: Re: [PATCH v6 4/7] iommu/dma: Catch scatterlist length overflows
Message-ID: <jhhax2joj7vgernd4vh5oidwm4onzwncb54eyjlisw6ub2oyq4@wkjijoachhh4>
"Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173,
 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316"
References: <20260902082525.1149367-1-krzysztof.karas@intel.com>
 <20260902082525.1149367-5-krzysztof.karas@intel.com>
 <aqMrxRny29Kbtkdq@zenone.zhora.eu>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <aqMrxRny29Kbtkdq@zenone.zhora.eu>
X-ClientProxiedBy: TLZP290CA0002.ISRP290.PROD.OUTLOOK.COM (2603:1096:950:9::8)
 To PH0PR11MB7424.namprd11.prod.outlook.com
 (2603:10b6:510:287::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB7424:EE_|LV2PR11MB528201:EE_
X-MS-Office365-Filtering-Correlation-Id: 417ff8d4-371e-406b-c9ec-08df1fa5ca5c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|4143699003|10067099003|56012099006|11063799006|22082099003|18002099003|7136999003;
X-Microsoft-Antispam-Message-Info: ySk3vTO10VgP6bbVDf7TptOZA063h+uUXRGCYQwJLiNEGEQMX8o/pSqoqMljBy43FagBksVJm6PQmZJ7iCp42XP5KJmMZpJNsK+wTshUTzIsmORWbRWJjwJx1Sxl6LVgTtsINSZ8uCd7hHEW56s+XuyukxysInBBu1FJB2UyJX2Uj9YZWHGbjpUZF++FclFZgSmKm13W4ARW2EqYMaMr6qG5Qh9i2Ln+7+474H7w3zOuEehw0gFScGzX+02n/IMfM/V7B0V3qWIk7dyvGIM2s6rvDsDOl3gK7cpY5SIRaF+hBbdhYn/DOpXqWME/1YR99pVeEtF9KSLsUfK2Te5una142vr2V0IeN9yYuVUeaSmASDx3VI65Q5LzoFMBdT6vTd/3q/NyAj542Aq0BXsW12Gd5U2sDziToTOOxwb2/+4meUu72FB3RLwuDkcRri9cuyWyJLfuic7uS/lOPGrar20Bmho0NfNQtFmvbhtwsEfcsQVrpGWu/25Z6si5evm6Fp6uJOCOewRAFFAbtchHuY5OmZxyugTSqC6KaG7BsTraNs09ZKpAnz7ISTXMfRzmaMaPdzwMOr9E+xSo6jloda8EbiBYpVhBYeKkbRrD90Ew6ZglyJsXLv7dA82qn947+u1WKVU4+zwBkQDsmU68n0MV+8sl0zKk5J/lxoaNzKc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH0PR11MB7424.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(4143699003)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003)(7136999003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFhiNFF5a1hOOGo5czRYNWN5aTN6SEpzKzJUYzVpL0NmNCt5NlpoRFlRUm9M?=
 =?utf-8?B?eUp1Sjc0VFFjWjNjZW55QUY0T0xCaTUwcW0yVENHRysrMndvQ3MxZll2RVhr?=
 =?utf-8?B?RS91SWxqd3p0QjMvMGV3VFdudEJmZVZCQklMcHBkSzhvUjY5TVVsZ2hMSXR4?=
 =?utf-8?B?eVYrZ0d1aiszNWFYVkhGR09JRmxDcFRVaGFnM05sUWQvSnBDWHAzNDU3dlAz?=
 =?utf-8?B?RU9JeXNUazN0c2U2YnZ5Ky9tZzRyUU1JQVdqanZnYm5NMU1nU2ZzSVVGRk9W?=
 =?utf-8?B?VVFESVNzV0xVMjdmMlUzemlNZUJ5Vm42OWR6N1ZPSHJOSS8yOHpQK3RTRkVL?=
 =?utf-8?B?ek1vZ1JIWUl4YnhkMnpVYkFOcm9jRTE4c3hvMzNlQkNtbnpQQk8xeDdUaGZx?=
 =?utf-8?B?MWIzUUptcVFQVXZxNUxPWU44SE5kKzFCNnM2WXdSeFZzT3NUb0lwd3E4ZzNP?=
 =?utf-8?B?YVUrVW5VVDV6aVF3c3NYSFV0bmlDVjRrdjVsUmQ5WFljbEtwT2tIcG5lUnFH?=
 =?utf-8?B?djVUSHMrb29TdkxBVzByOVkraDJ5MXZ3UElzZFZFZ2gzeHR2MTVCai9qVHFL?=
 =?utf-8?B?bFA5Q2h0RmFCbmZ3c1NDdEtMMlA4WTZUN1hXSTFmeXhZMmgzRWtSbzRKVUJH?=
 =?utf-8?B?ZmVlYldZUTFxbFRpS3ZOTFpMQm1yUmpVdzFLRWNUSEs2NE0zVER3NzZZQ0Nv?=
 =?utf-8?B?QUxvOUFRNng4aEVNSUZrYnFCZTMwakZXd2ZabE95Y2J6YmZLQWhvWWJ1cUQ5?=
 =?utf-8?B?SmdUdVZsbi9qN3VSVFN3YkZ3R0dUQ2k3Uk5hdGsyQnBDSkQxZW1ieDRTZ1p1?=
 =?utf-8?B?eXdhNlVQOWRzeFFWVWRoSm5HZDV6NGtXL084VHJQWUxTd2ZKSU5Rc3IxS2Vt?=
 =?utf-8?B?RFJFQll1SURzKzNyVFNhdUl1YWxwNXpqZVd4NElwWE1mQ0VSM0VBZ2RDOWdN?=
 =?utf-8?B?SlFVeWtqZzV2cEpTbEk5YmIyYWdmN2xpNjlCS2xzUG5qVVRmTFFYb1NvVXpP?=
 =?utf-8?B?YXdFYzdGbEhvejA5MkZmUGoxQTB6djR6NkNwK0JYRDBUTjVyMitHUDZIL3RV?=
 =?utf-8?B?d0Z3Y0hPZ2JldWUrdHNGS0thOHBOUlZYcFVMWFFKaHpJNTcyZzAwNVZRQnVs?=
 =?utf-8?B?U2hLbmtObGtFK3JxZmM0aTFFczBKT25VcWJzczZ2bkVEdnQ0WjZoVXNJT0lT?=
 =?utf-8?B?VWNVZSszL0xnc0pDQkRSaUoyRklQVUV1R3AzRFJrdndGMW9xUVBkazJZcFVu?=
 =?utf-8?B?NkhFN3B4UVVNbWhSRno1SllDYWViSjVWSTkzV1hTRFdMTXh0UnphNHBOZWsz?=
 =?utf-8?B?Y1VBWHRFVkJKOHdTMXJTWGhtWnVKOUpmdXNEaFdhQkVPUUQ0RDN1bDRqVWph?=
 =?utf-8?B?enFXY3M0MCtyMVNnbWJWdWZucmpYTlVoT3BUemUzbll2NHBidmRGV2RGSDkv?=
 =?utf-8?B?K0lrMWZmeksrcXR0TzJoWk5QdGhxS3UzSWswQ28xdi9YTEZxdDRNUmpGRitv?=
 =?utf-8?B?QUVsOWN6OHVxZlBEMjVSWUVQRzF4eWlnWkdYd3I0Nnd1VlFKenNNNUo1ME5a?=
 =?utf-8?B?VFdveW5RalR3T25BaTRBbmlXUXAwRG42UXZiNWxRWVo4VzJNeDdoTkhTNExK?=
 =?utf-8?B?dERPbkRhdy9WNlFmUVlldCtRNWlrMHhFcFg3aXM5bzZqUGM1MlBnYkRZRkNK?=
 =?utf-8?B?Smd5OTA5VzFOMGZ4VkREMWdFMWVqQzBINnlxN3EwLzRscFE2L0FLa2pMZm9T?=
 =?utf-8?B?WWN6V3ljUktvZitqVm5XUWhhbHJnVkNrQm5XS3NIWk1hRjljSHJlWGtsU1lj?=
 =?utf-8?B?MnU4K0UvMUEydk1WNCtKU1FZOGJkWW5lejBhMkE2WkVoTGNWdDFna1kxNEJQ?=
 =?utf-8?B?bjU1OC9JZ012Z3A0WjhoNzIzc0xKcml1aE1lWlZNWEN4OGRoOFc4akd0V3Jz?=
 =?utf-8?B?VnVIRXo5S3ZQL1hPR2dyODZYdkdXQjFCUnlKYjhZTHY2Wis5aG9NeFIrbWRn?=
 =?utf-8?B?NkljbXpuOWhNSFFtM2JLQVZYTVljMDNYNGpLb3QrK2FWOXhkVFlsSDNSWlBo?=
 =?utf-8?B?c3cxOFlUNlVIR2FkMllnZllhUDhrZEM0cWhOaCthdi8xMHpwWTRkc1RPZmVm?=
 =?utf-8?B?NDBiYTdLdEM3Y3BQbTFhdm9QcHlxcVJyUmpWWnVNR2lxL1BWSjdoelFaYTVJ?=
 =?utf-8?B?aWRWSlozdXd5MzBvTjNmN2dUUU9OM2liMmtjLzRjY1haRXRxSTEwL3ZkeTdL?=
 =?utf-8?B?a1hRTXlEZmNuQTlLUGhTRE52YkgzUTlCK2xQYlVhQm5QV09DeURBWHhWS3Jn?=
 =?utf-8?B?ZjNxcmUraTVDN21MNHJwalBnd0dtM0wzSkNtd2tFV1NZU3RnbHIxZGhBbExs?=
 =?utf-8?Q?/PgSbMOZmqiWj5jw=3D?=
X-Exchange-RoutingPolicyChecked: yoDPg5vj/vK7lZMvKc20O33VKo+yNeSPGOT4/XnJAFmq1vfWxu4ud6+8Khx3+pBkC/7Lpm9xVWS+Yasj/370dFtUKDZQ7MTdvhJyI+AOSTYweERIpCTbwpK5fzfFjXlXJXKzgGbPZedf0Od5GzZQ03W8GHItYdWDjzX/8bgdHLeMPHTpgNDHfJWlS0X7vRwIGps6YHJLKX4waYFaV/uLqA/gi4FW2Xoa1oaa3mcYPT7V+uWBuoUXXKtVfju3taWt/x5olbVEjQ3/7nPq/u4gLXTBsFFDZ5bK+GkeHn/NnH3M8ApL3XH1ms0VcYUzdqOYkF6iZrlqXBcTy3VECSD3Cg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 417ff8d4-371e-406b-c9ec-08df1fa5ca5c
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB7424.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 10:21:43.6819 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: plvNtXPnhWJjVa4zOz5wClXSJwJdnM57yZeA4KOgydkYdJKlyO52wdgLslplDF0vI0I8hX6ovz7xwGgnS20S6q3AJrZVYrZTiXna7PWczEU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB528201
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

Hi Andi,

On 2026-09-11 at 00:21:15 +0200, Andi Shyti wrote:
> Hi Krzysztof,
> 
> ...
> 
> > @@ -1477,6 +1477,10 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> >  		sg_dma_len(s) = s_length;
> >  		s->offset -= s_iova_off;
> >  		s_length = iova_align(iovad, s_length + s_iova_off);
> > +		if (overflows_type(s_length, s->length)) {
> > +			ret = -EOVERFLOW;
> 
> the value of ret here doesn't really matter because it returns
> anyway an -EINVAL. We can completely remove this assignment.
Assigning an error to ret here lets us return that EINVAL.
Without the assignment, we'd be checking against an
uninitialized variable. I'd rather have this temporary error set
than use garbage value.

> 
> > +			goto out_restore_sg;
> > +		}
> >  		s->length = s_length;
> >  
> >  		/*
> > @@ -1493,7 +1497,18 @@ int iommu_dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
> >  		 *   time through here (i.e. before it has a meaningful value).
> >  		 */
> >  		if (pad_len && pad_len < s_length - 1) {
> > -			prev->length += pad_len;
> > +			unsigned int new_prev_len;
> 
> Please add a blank line here.
> 
> > +			/*
> > +			 * For large mappings spanning multiple GBs we
> > +			 * may not be able to fit all needed padding into
> > +			 * sg->length.
> > +			 */
> > +			if (check_add_overflow(prev->length, pad_len, &new_prev_len)) {
> > +				ret = -EOVERFLOW;
> 
> same goes here.
> 
> Thanks,
> Andi
> 
> > +				goto out_restore_sg;
> > +			}

-- 
Best Regards,
Krzysztof
