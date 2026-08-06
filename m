Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32BFAC561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 08:44:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F71410E2B4;
	Thu,  6 Aug 2026 08:44:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DZoGbIMs";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4D33B10E2A1;
 Thu,  6 Aug 2026 08:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786005878; x=1817541878;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:mime-version;
 bh=zLBQfHJWeerci4EuGCCgHWtPFbMwwuj1D85UIPo0FAI=;
 b=DZoGbIMsTMKfUQaytvYKJSvWqY+FwcV1/CZweYPCB5t9v8Z0IQAqGpcz
 uGx4f/uzt5n/JW4VnYSqGAfHT51WovzXxsLGZqi9SVVcvls239b2s3bFa
 swabBdTORLgpOqefEfGWGmaGQood1/531gBXhBbSDvyVax0CHW1CrV8ck
 xuVLS5YY64aeYtSObTXCQpMwD9qNvMuYfi+nHAjg085PUzLQyKVMiM9vh
 KmaVIOhGfIY4Mvwsj+R9XG+Gz5DADa2XU73aqXvRxTS7wL6KrhBWDiLgp
 LjtX+rmFs80fbJ1f5ES3kuRCrW9WsPRWKDBeI0x39V1qb8J95aP1J7Jp5 Q==;
X-CSE-ConnectionGUID: tm8as/bHRqyLOe/RU5r1Aw==
X-CSE-MsgGUID: 3+Q1DegVTvCTIK5GH20Qdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="89115459"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208,217";a="89115459"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 01:44:37 -0700
X-CSE-ConnectionGUID: UuCML6aAQPGdwKqIkHvctg==
X-CSE-MsgGUID: 0aQSkWP6RxC3egY8vvl65w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; 
 d="scan'208,217";a="300258197"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 01:44:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 01:44:37 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 01:44:37 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.13) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 01:44:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dLC4E/fH81HzGFa66C6S2EcGxXE1dAN4Cm5mOBMVDGg+jmLDjzeq2CgO96BvpgNtTHJIxRrQhB5Xj24+eb3qGOfShTlWyf2tBmTzn9xo/GRgOHU1MYhHmFSF1Yz/tD+d/S7GqcYm3s95jCsGEu8nr/DAknOwSpknNVYlQ93qatoKgS1W7YCnC9oJsmXCFn173vzoGVYxkFwHBTyLLcVDon8tLsYNWJ/IrQGLjECOX7XvzC+tDYFjqiBfTmK/KbreVA3MDg5P4V/h/ZRXR4pt/zai8aJw8f1deOLUOrUtzZK9X5Mk5WJSbkfXndYrqtkx3B38FmdMerRvg7LgWtdKKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x/VcdfYq6HkaQC7wsvPOPrg9OTprPL48i3F7S+18xEc=;
 b=y5sUus4T452eIwIIRSUEKbXLYDy+Guvd/wgVvNR/Hcgzwh7JXhKZEwQMyo0f56G/bfulbcfZFPoD0JdXxLMCb66pHNb7n1SNvHFevfrQcJYwhzjfuYPpjT8pQp8+cC6mknlezpBwTlgr0vOFgK0Zo6DIW8qvRUymMcvS6/R2c9310BOnFv8bNaSA7cPNVB/ADEsEJTw7GE++6v2iKIjreKy7y4WTzD0gWdraGN3PTkee3xs8CltkrcuIQzu+gc3A9qNMazsbI3uJxlOb8xkjFjXuc08V+BU64dscqzm3vjDfKHgehXVNZ2IyaPLcODKH8XT3UiwHJ5ejpcFFPs3MlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BN0PR11MB5709.namprd11.prod.outlook.com (2603:10b6:408:148::6)
 by PH3PPFD80FA6330.namprd11.prod.outlook.com (2603:10b6:518:1::d52)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.20; Thu, 6 Aug
 2026 08:44:29 +0000
Received: from BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c]) by BN0PR11MB5709.namprd11.prod.outlook.com
 ([fe80::ad31:3f30:20b8:26c%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 08:44:29 +0000
Content-Type: multipart/alternative;
 boundary="------------0rd3b4D9HvFrBNwARNHdkb1E"
Message-ID: <63b6dcde-e444-4d90-a7ce-a918f04cbac7@intel.com>
Date: Thu, 6 Aug 2026 14:14:20 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/pagemap: Prevent double migration of device pages
To: Matthew Brost <matthew.brost@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
References: <20260806061126.1499149-1-arvind.yadav@intel.com>
 <anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com>
Content-Language: en-US
From: "Yadav, Arvind" <arvind.yadav@intel.com>
In-Reply-To: <anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MA5PR01CA0267.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:21c::9) To BN0PR11MB5709.namprd11.prod.outlook.com
 (2603:10b6:408:148::6)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR11MB5709:EE_|PH3PPFD80FA6330:EE_
X-MS-Office365-Filtering-Correlation-Id: 31edfdcc-55f6-42d3-6b2b-08def396ed60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|56012099006|11063799006|10067099003|6133799003|18002099003|3023799007|22082099003|8096899003|4143699003|13003099007;
X-Microsoft-Antispam-Message-Info: aw8FQgPFwoFX06l/d1hCfTaU6EeBHHGLaGgixBhkbVvaBw66RKxYJKsoFa4mfoJ9WifXefOfp9OUOsoIhasZclO52TuDOG5x4aDDhSwxnFCDM9UEUGATcUqIl9mTj5Btt9ZfKgy2F/c+gkrdUsv2D1pRXLewkej4qZfa6fsdy3Bc3XdYVgh5aRTfbUEhtU+KWMOyQnTNSRF1CJb20JtLS41zqoiJx8mZFcIStCA11AOln5VdigEbhZDu2e9LBY4EJUFuf0c1k0TPwKKFoPpBB7SwLU1krTQd3pv0Nu7Sjsac0/kqC6Mz1Rl9ZUaA91wG7HOB+v3+9jmchagUIV6WBrunrDycs+Vba0cio6WI+pEmvJDSWCARGiv2uRowyKHlXlbfFbJtJheSwwvy1R7xlgzp2PVgoL7cCvhgRfjqvjXQur2t3Y+1rkUqZG91W6yb6uDkyP3+Fk8ItSuBN+OtTniawPaE9c9oBlpqkWDZ6or16Y5JhVQGe/I7QVQ5AugCSyKC/l51nwdpEalsy7ztP4WMTTrSNAtLhujWfs7f9DFnEtmeiuTdnFJCKMP8dVseaZ9nvh3J07WEzDF+RdHJUChRQKAMgmyfbN4s7OvcW0I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BN0PR11MB5709.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(56012099006)(11063799006)(10067099003)(6133799003)(18002099003)(3023799007)(22082099003)(8096899003)(4143699003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXJRZnp1ZUp0K3hvUkJzejJNSXFOaG1XVlV4K0RQMmJvOTUwa2lRd2VwTEY1?=
 =?utf-8?B?KzJKZzU1NDRWczNjenk2WVZaSFBrSVdsOXdpSDNDNnlMOHJ2VXNUd2RQZ2R0?=
 =?utf-8?B?ajVoL2t5MVpKZXliVzNocmRoTUd3WCs3enloTE1sSGd6SjJ0SEI4aSs0a0Rk?=
 =?utf-8?B?eEdPdVR5QUpianNVQXJMM0lqcExXMVl6Ni9HUC9SeTc3ZEtsSGhOVHJHZHJX?=
 =?utf-8?B?WGI3ZlB5ZmpQRHQyS2lFZkNSc3BiRytidWNWemJPTE10K1RlaHg0MFlRUEFF?=
 =?utf-8?B?ckFhZ2JjT3Y5ZXN5aGNyYnlOeEFDNE9LY1dwQkQ3aUM1ekU0dUdGYldyYjNa?=
 =?utf-8?B?Q1hPdUttMEpDZEEvSlVHRHJDeUIyTEZaYnE0OVdFbGhDano4L2FqNHRzZk9K?=
 =?utf-8?B?bmZFTzhBL2FhRmpaS290RUlwYlJ2aGNTdEdEL0hKMHpEYjh6cHBYa1ZuVVNy?=
 =?utf-8?B?RTlSWmhwNldoTGVuOWxjejNHZGEyZkEzWnl3K3puYjVsQzVTclcyekJtdndz?=
 =?utf-8?B?UktIMTVkTDI2dTkwY3l0eHlGMUs0a3RrT0J4TnhtY3lQbXpRTXlLcEI0VENW?=
 =?utf-8?B?bmpwdTN0cHZXTTdOc2x0eU94N1FKZk1KSHFLRTVuVTlWN0lDZ0JsV0cyb1Ny?=
 =?utf-8?B?SFQweWp4VlA5TGoxU2l2Tk8xUHplazVWYWVLbVZTTjR5Ri9XTTQ1UmNlenRV?=
 =?utf-8?B?UlhKME5HenFhakxqMHpwcjByTy9rekZRZHJ3YjdLczFvd2RzSHFiRXlnMUxK?=
 =?utf-8?B?V1kwb21GelBNUEgwenJMUlFpS2NSU0g1YTBtL09UTXZMMkJ5RWRNTkZXRW9z?=
 =?utf-8?B?N1B2bVZBTUNQamVkalRQcnh4c29PYTA3ZWxGdm5oVGxXUGFYQ0FETEpQaHNH?=
 =?utf-8?B?cm1CN3RLZzZZN1ZOakV6dHh3K2RHd2RialhIVU9pdzdYeExsbmtMZjI3RENv?=
 =?utf-8?B?WGVLWkVVNGl6L3czUlZ4UFNSbEZuOFFEMksvWmtIYUptVTBJN0EwVjNSQmo4?=
 =?utf-8?B?Ymp1T0UvYnpZdnFCQjI2bWNwdUhpcWVJTndydFVNWXNkTXlCMGI1dUVURG9r?=
 =?utf-8?B?Uk9rbFNWVlYxaEpiMXJYVlp1L2tRUk1qa0tuWDlwVXlnRzlIUXpZajZ2ZS9Z?=
 =?utf-8?B?Z3YzWEJjZVBqZ2VFeW1KN2Y2NHp6cmVZNFYyK0dTMVo0R1V3TlMwRUoxaVVT?=
 =?utf-8?B?aE9VVGJoM21rV0VadXNZVExuZ3hnQnBFQSsvUGNEYThnQzNZMGhqOXVxNWpF?=
 =?utf-8?B?THovaWdVYWZQS0hBTGxDZGNuMUJzc05zTjFZRkpLSU9sWkZaOWUvV2dSOHhl?=
 =?utf-8?B?VStwVmUyWEFDWU15TWJaNkw2ajRHa2MxenRDWjljcnpzUXFLbTJOZGVmTHBS?=
 =?utf-8?B?aVEyUWNYMXRrZGoyZEw5VUhVNURha1RzWm5haGk1TWVKK1lEaEgzSzJuSFl1?=
 =?utf-8?B?UDlUTUl6UnYvSjh5ZmFvS05YL2J4WjhvWkpEQkx6MEU2ZklQRXRsVWs5bmo3?=
 =?utf-8?B?MjlCRmQ4WEF5Y1VQSzM0ckRIK0xGU3gzWUo2WFliVmZ2V1hvUURmbnhhbWRq?=
 =?utf-8?B?NXZFWElBeWdkOVhFYnZVekFxZ290SlA1eE1aSFNieml4UVZKNEppMFBFUDdI?=
 =?utf-8?B?VC85U0xWVVkwaFlZRDg3S0g3MzZOMkZXcU16Z3puNmJ6emU4NVB5aDhSZFA5?=
 =?utf-8?B?VlVJeFF3VDZ3SmM1Uk1xVTBHbWZTaXlEaXN2OEk4dEd1RC93Mm9pNDB1bVE3?=
 =?utf-8?B?bWtKMTBGdFB1ZUxHQ1pxejlWdVlIQTVyM3NPYlpKQytTbE5BbFpSM0cvcXhs?=
 =?utf-8?B?RGhZaDRFaFBHNHpmRW9FQm5LSy9ZQ0pWd2FDUGtVZ0dyMWJEYW9TUVloRjl4?=
 =?utf-8?B?NlhPaVRSSlk2ckhXRHdaaWU1eXBGbTdaSEFScDM5akdXanRxS2FIakx3WHFH?=
 =?utf-8?B?VjlwalYvTXVBT1crNHpmenlmdG1wMWc2R1Q0YVpZNlg1YWpzVTF3bmo5cWNv?=
 =?utf-8?B?a0FiVmxxQVZVYWxmb2pTanNhNjZMcVp6amlvRElYeDk0eDhiUGpBQklwZlhp?=
 =?utf-8?B?VU1nYWp3cDJlamtkOFpMQUNkUUdsd3FKTi9oazkvZUxrR1JHQWI5aEhaSkZ0?=
 =?utf-8?B?bE92TmZldTVVcWV1MHRLdW9nTzVCOFhVeC93VDY0N0tRbDY3NWVxRE5qWmxN?=
 =?utf-8?B?azI1YmFwSE9LcENKNy9qQmRvTXdyVENra1JpWnQ2VXhkRDdobUw5d25YTk1P?=
 =?utf-8?B?anZrc0xYbHQxdi9UbHN1WEQ0bDgyYXVZajVvTE9uakdlTDhZengvVUtON24x?=
 =?utf-8?B?MEhaaTlzOGd6VXl5VFRCZy9zaHMwRUw1L1I4SjU3c01zOUlMUlRwZz09?=
X-Exchange-RoutingPolicyChecked: lJpZPb0TTM3YCRS2JB39sGDgpYsRsbdEZyeTFRpjc8Xq8jQlf0FUmxakjUjYrghox4CZCDS/HQGXy/aohDlGA2vOAQgk1Ce6pWAcmhmg284HQuGlvWn1c3Ld+zATNtt03t2M/bF3UsnBTKOjCGGlca7+MRTtZWYFhN+CKJ2sbRooEnybC3ivqlM9qiSxXTLCf3Imc8IgrW0SKylF0+3KS7IWHXiNOsxTa/7KC445NfZuhDyLJJ6ZKm3IvHg+Tv/sc5n6LxK2px3LXYzWSwauRDJJQlI8q++An26Cgm94efG6lqYIO9xugWrW/pH3/bLDJB0l83D0uz+jCyjml95sKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 31edfdcc-55f6-42d3-6b2b-08def396ed60
X-MS-Exchange-CrossTenant-AuthSource: BN0PR11MB5709.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 08:44:29.2338 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q7jAItiyEmt2+PjOSIpKZvSRHkO53trjQ5FDu1foXpDpU0eqd/5IJWqhZ1a6inUb3q20FGZeuplXkNjvpnSEyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFD80FA6330
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

--------------0rd3b4D9HvFrBNwARNHdkb1E
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit


On 06-08-2026 12:51, Matthew Brost wrote:
> On Thu, Aug 06, 2026 at 11:41:26AM +0530, Arvind Yadav wrote:
>> A device page migrated to system memory by a CPU fault can remain
>> referenced after migration completes. During this window, raw-PFN
>> eviction can collect the same device PFN and migrate it again.
>>
>> The first migration has already transferred the memcg charge from the
>> source folio. Migrating that source again can create an uncharged system
>> folio. Adding such a folio to the LRU can spin indefinitely in
>> folio_lruvec_lock_irqsave(), causing a soft lockup and an RCU stall.
>>
>> Track successful device-page migrations in an allocation-relative bitmap
>> stored in drm_pagemap_zdd. Record successful migrations before finalize
>> unlocks and drops the migration reference on the source.
>>
>> Make raw-PFN eviction skip retired folios. Record raw-PFN migrations as
>> well so an eviction retry cannot select a folio migrated by an earlier
>> pass.
>>
>> Mark every base-page bit covered by a migrated folio so the retirement
>> state remains valid if the source folio is later split.
>>
>> v2:
>> - Replace the retired-PFN XArray with an embedded bitmap.(Matthew Brost)
>> - Mark every base page covered by a migrated folio so retirement remains
>>    valid if the folio is later split.
>>
>> The lockup was observed as:
>> ==============================
>> [10109.860465] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [kworker/u65:5:6557]
>> [10109.860508] irq event stamp: 308085402
>> [10109.860508] hardirqs last  enabled at (308085401): [<ffffffff829571e1>] _raw_spin_unlock_irqrestore+0x51/0x80
>> [10109.860514] hardirqs last disabled at (308085402): [<ffffffff8293dd71>] sysvec_apic_timer_interrupt+0x11/0xc0
>> [10109.860516] softirqs last  enabled at (307538534): [<ffffffff813d111b>] __irq_exit_rcu+0xdb/0x1c0
>> [10109.860519] softirqs last disabled at (307538529): [<ffffffff813d111b>] __irq_exit_rcu+0xdb/0x1c0
>> [10109.860521] CPU: 9 UID: 0 PID: 6557 Comm: kworker/u65:5 Kdump: loaded Tainted: G S         O        7.2.0-rc3-lgci-xepurge-
>> [10109.860524] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
>> [10109.860524] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
>> [10109.860525] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
>> [10109.860644] RIP: 0010:_raw_spin_unlock_irqrestore+0x57/0x80
>> [10109.860647] Code: 00 75 1c 65 ff 0d 69 ee 84 01 74 20 5b 41 5c 5d 31 c0 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc e8 8f 2e c9
>> [10109.860648] RSP: 0018:ffffc9000c017030 EFLAGS: 00000246
>> [10109.860649] RAX: 0000000000000000 RBX: ffff8881012c00d0 RCX: 0000000000000000
>> [10109.860650] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
>> [10109.860650] RBP: ffffc9000c017040 R08: 0000000000000000 R09: 0000000000000000
>> [10109.860651] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
>> [10109.860651] R13: ffffc9000c0170a0 R14: ffff8881012c00d0 R15: ffff88810e9e6f00
>> [10109.860652] FS:  0000000000000000(0000) GS:ffff8888db2f2000(0000) knlGS:0000000000000000
>> [10109.860653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
>> [10109.860653] CR2: 00007a26c0e00048 CR3: 00000001f366d006 CR4: 0000000000f72ef0
>> [10109.860654] PKRU: 55555554
>> [10109.860655] Call Trace:
>> [10109.860655]  <TASK>
>> [10109.860657]  folio_lruvec_lock_irqsave+0x216/0x220
>> [10109.860661]  ? __pfx_lru_add+0x10/0x10
>> [10109.860665]  folio_batch_move_lru+0xc8/0x450
>> [10109.860670]  ? lock_acquire+0xc4/0x2d0
>> [10109.860674]  ? __folio_batch_add_and_move+0x60/0x2e0
>> [10109.860677]  ? folio_migrate_mapping+0xa6/0x110
>> [10109.860679]  ? folio_migrate_flags+0x13b/0x1b0
>> [10109.860681]  ? __pfx_lru_add+0x10/0x10
>> [10109.860683]  __folio_batch_add_and_move+0xe7/0x2e0
>> [10109.860685]  ? dma_iova_try_alloc+0xb0/0x140
>> [10109.860689]  folio_add_lru+0x64/0x80
>> [10109.860691]  __migrate_device_finalize+0x12c/0x270
>> [10109.860695]  migrate_device_finalize+0x10/0x20
>> [10109.860698]  drm_pagemap_evict_to_ram+0x185/0x370 [drm_gpusvm_helper]
>> [10109.860704]  ? drm_pagemap_evict_to_ram+0x96/0x370 [drm_gpusvm_helper]
>> [10109.860709]  xe_svm_bo_evict+0x15/0x20 [xe]
>> [10109.860819]  ? xe_svm_bo_evict+0x15/0x20 [xe]
>> [10109.860921]  xe_bo_move+0x107e/0x1570 [xe]
>> [10109.860992]  ? xe_ttm_tt_create+0x168/0x340 [xe]
>> [10109.861059]  ? __up_read+0x98/0x2b0
>> [10109.861061]  ? lock_is_held_type+0xa3/0x130
>> [10109.861067]  ttm_bo_handle_move_mem+0xe8/0x1e0 [ttm]
>> [10109.861075]  ttm_bo_evict+0x141/0x1c0 [ttm]
>> [10109.861081]  ttm_bo_evict_cb+0x9f/0x100 [ttm]
>> [10109.861086]  ttm_lru_walk_for_evict+0x84/0x190 [ttm]
>> [10109.861091]  ? xe_ttm_vram_mgr_new+0x258/0x3a0 [xe]
>> [10109.861198]  ttm_bo_alloc_resource+0x219/0x750 [ttm]
>> [10109.861203]  ? ttm_bo_alloc_resource+0xa9/0x750 [ttm]
>> [10109.861208]  ? lock_acquire+0xc4/0x2d0
>> [10109.861214]  ttm_bo_validate+0x94/0x1c0 [ttm]
>> [10109.861218]  ? ww_mutex_trylock+0x19d/0x3d0
>> [10109.861219]  ? _raw_write_unlock+0x22/0x50
>> [10109.861223]  ttm_bo_init_reserved+0x17d/0x1f0 [ttm]
>> [10109.861228]  xe_bo_init_locked+0x20a/0x620 [xe]
>> [10109.861294]  ? __pfx_xe_ttm_bo_destroy+0x10/0x10 [xe]
>> [10109.861359]  ? mark_held_locks+0x46/0x90
>> [10109.861361]  ? __create_object+0x68/0xc0
>> [10109.861366]  __xe_bo_create_locked+0x384/0xa20 [xe]
>> [10109.861432]  ? lock_acquire+0xc4/0x2d0
>> [10109.861434]  ? xe_drm_pagemap_populate_mm+0xd3/0x340 [xe]
>> [10109.861542]  xe_bo_create_locked+0x23/0x40 [xe]
>> [10109.861609]  xe_drm_pagemap_populate_mm+0x12e/0x340 [xe]
>> [10109.861707]  ? __lock_acquire+0x43e/0x2930
>> [10109.861716]  drm_pagemap_populate_mm+0x74/0xe0 [drm_gpusvm_helper]
>> [10109.861720]  xe_svm_alloc_vram+0xb5/0x2c0 [xe]
>> [10109.861817]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
>> [10109.861819]  ? ktime_get+0x23/0x130
>> [10109.861821]  ? trace_hardirqs_on+0x22/0xe0
>> [10109.861823]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
>> [10109.861826]  __xe_svm_handle_pagefault+0x77d/0xbf0 [xe]
>> [10109.861924]  ? rwsem_down_write_slowpath+0x43a/0x9a0
>> [10109.861926]  ? _raw_spin_unlock_irq+0x27/0x70
>> [10109.861928]  ? rwsem_down_write_slowpath+0x43a/0x9a0
>> [10109.861929]  ? trace_hardirqs_on+0x22/0xe0
>> [10109.861931]  ? _raw_spin_unlock_irq+0x27/0x70
>> [10109.861933]  ? rwsem_down_write_slowpath+0x459/0x9a0
>> [10109.861937]  xe_svm_handle_pagefault+0x3d/0xb0 [xe]
>> [10109.862030]  xe_pagefault_queue_work+0x1a9/0x520 [xe]
>> [10109.862122]  process_one_work+0x239/0x730
>> [10109.862127]  worker_thread+0x200/0x3f0
>> [10109.862130]  ? __pfx_worker_thread+0x10/0x10
>> [10109.862132]  kthread+0x10d/0x150
>> [10109.862133]  ? __pfx_kthread+0x10/0x10
>> [10109.862135]  ret_from_fork+0x3bd/0x470
>> [10109.862138]  ? __pfx_kthread+0x10/0x10
>> [10109.862140]  ret_from_fork_asm+0x1a/0x30
>> [10109.862146]  </TASK>
>>
>> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
>> Cc: Maarten Lankhorst<maarten.lankhorst@linux.intel.com>
>> Cc: Maxime Ripard<mripard@kernel.org>
>> Cc: Thomas Zimmermann<tzimmermann@suse.de>
>> Cc: David Airlie<airlied@gmail.com>
>> Cc: Simona Vetter<simona@ffwll.ch>
>> Cc: Matthew Brost<matthew.brost@intel.com>
>> Cc: Thomas Hellström<thomas.hellstrom@linux.intel.com>
>> Cc: Himal Prasad Ghimiray<himal.prasad.ghimiray@intel.com>
>> Assisted-by: Claude:claude-opus-4-8
>> Signed-off-by: Arvind Yadav<arvind.yadav@intel.com>
>> ---
>>   drivers/gpu/drm/drm_pagemap.c | 143 ++++++++++++++++++++++++++++++++--
>>   1 file changed, 136 insertions(+), 7 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
>> index 7a056592ac66..713095e27006 100644
>> --- a/drivers/gpu/drm/drm_pagemap.c
>> +++ b/drivers/gpu/drm/drm_pagemap.c
>> @@ -7,6 +7,7 @@
>>   #include <linux/dma-mapping.h>
>>   #include <linux/migrate.h>
>>   #include <linux/pagemap.h>
>> +#include <linux/bitmap.h>
>>   #include <drm/drm_drv.h>
>>   #include <drm/drm_pagemap.h>
>>   #include <drm/drm_pagemap_util.h>
>> @@ -66,6 +67,12 @@
>>    * @refcount: Reference count for the zdd
>>    * @devmem_allocation: device memory allocation
>>    * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
>> + * @range_start: Virtual start address of the device memory allocation. Used to
>> + * translate a clipped CPU-fault range into an allocation-relative page offset.
>> + * @range_npages: Number of pages covered by the allocation, i.e. the number of
>> + * valid bits in @retire_map.
>> + * @retire_map: Allocation-relative bitmap. Every base page covered by a
>> + * migrated folio remains marked until this mapping generation is destroyed.
>>    *
>>    * This structure serves as a generic wrapper installed in
>>    * page->zone_device_data. It provides infrastructure for looking up a device
>> @@ -78,29 +85,38 @@ struct drm_pagemap_zdd {
>>   	struct kref refcount;
>>   	struct drm_pagemap_devmem *devmem_allocation;
>>   	struct drm_pagemap *dpagemap;
>> +	unsigned long range_start;
> Sashiko pointed this out as well: you can't store anything virtual in a
> ZDD because it represents a physical object. The range_start may or may
> not be the same by the time a fault occurs.


Noted. The ZDD represents the physical object, so storing range_start 
there is not correct. I will remove it and use the per-folio state 
suggested below.

>> +	unsigned long range_npages;
> devmem_allocation->size can derive the number of pages.


Noted. I will derive the page count from |devmem_allocation->size|and 
remove |range_npages|.

>
>> +	unsigned long retire_map[];
> This won't be needed or any changes to the zdd actually, more below.


Noted. I will remove |retire_map|and keep |struct drm_pagemap_zdd|unchanged.

>
>>   };
>>   
>>   /**
>>    * drm_pagemap_zdd_alloc() - Allocate a zdd structure.
>>    * @dpagemap: Pointer to the underlying struct drm_pagemap.
>> + * @start: Virtual start address of the device memory allocation.
>> + * @npages: Number of pages in the device memory allocation.
>>    *
>>    * This function allocates and initializes a new zdd structure. It sets up the
>> - * reference count and initializes the destroy work.
>> + * reference count and a zeroed retirement bitmap sized for @npages.
>>    *
>> - * Return: Pointer to the allocated zdd on success, ERR_PTR() on failure.
>> + * Return: Pointer to the allocated zdd on success, NULL on failure.
>>    */
>>   static struct drm_pagemap_zdd *
>> -drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
>> +drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap, unsigned long start,
>> +		      unsigned long npages)
>>   {
>>   	struct drm_pagemap_zdd *zdd;
>>   
>> -	zdd = kmalloc_obj(*zdd);
>> +	zdd = kzalloc(struct_size(zdd, retire_map, BITS_TO_LONGS(npages)),
>> +		      GFP_KERNEL);
>>   	if (!zdd)
>>   		return NULL;
>>   
>>   	kref_init(&zdd->refcount);
>>   	zdd->devmem_allocation = NULL;
>>   	zdd->dpagemap = drm_pagemap_get(dpagemap);
>> +	zdd->range_start = start;
>> +	zdd->range_npages = npages;
>>   
>>   	return zdd;
>>   }
>> @@ -669,7 +685,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>>   	pagemap_addr = buf + (2 * sizeof(*migrate.src) * npages);
>>   	pages = buf + (2 * sizeof(*migrate.src) + sizeof(*pagemap_addr)) * npages;
>>   
>> -	zdd = drm_pagemap_zdd_alloc(dpagemap);
>> +	zdd = drm_pagemap_zdd_alloc(dpagemap, start, npages);
>>   	if (!zdd) {
>>   		err = -ENOMEM;
>>   		kvfree(buf);
>> @@ -1102,12 +1118,115 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
>>   }
>>   EXPORT_SYMBOL(drm_pagemap_put);
>>   
>> +/**
>> + * drm_pagemap_is_devmem_page() - Check whether a page is device memory
>> + * @page: page to check
>> + *
>> + * Return: true if @page is device-private or device-coherent
>> + */
>> +static bool drm_pagemap_is_devmem_page(const struct page *page)
>> +{
>> +	return is_device_private_page(page) || is_device_coherent_page(page);
>> +}
>> +
>> +/**
>> + * drm_pagemap_retire_migrated_pages() - Record migrated device folios
>> + * @src_pfns: source array after migrate_vma_pages() or migrate_device_pages()
>> + * @npages: number of entries in @src_pfns
>> + * @first: allocation-relative page offset of @src_pfns[0]
>> + *
>> + * Record successful migrations in the zdd retirement bitmap before finalize
>> + * unlocks the sources. The bit is set only after a confirmed migration, and
>> + * test_and_set_bit() is used because concurrent CPU faults on clipped ranges
>> + * can update different bits in the same word.
>> + */
>> +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
>> +					      unsigned long npages,
>> +					      unsigned long first)
>> +{
>> +	unsigned long i = 0;
>> +
>> +	while (i < npages) {
>> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>> +		struct drm_pagemap_zdd *zdd;
>> +		unsigned long bit, j, nr = 1;
>> +
>> +		if (!page) {
>> +			i++;
>> +			continue;
>> +		}
>> +
>> +		nr = folio_nr_pages(page_folio(page));
>> +
>> +		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
>> +		    !drm_pagemap_is_devmem_page(page))
>> +			goto next;
>> +
>> +		zdd = drm_pagemap_page_zone_device_data(page);
>> +		bit = first + i;
>> +
>> +		if (WARN_ON_ONCE(bit >= zdd->range_npages ||
>> +				 nr > zdd->range_npages - bit))
>> +			goto next;
>> +
>> +		/* Keep later folio splits covered. */
>> +		for (j = 0; j < nr; j++)
>> +			WARN_ON_ONCE(test_and_set_bit(bit + j, zdd->retire_map));
>> +next:
>> +		i += nr;
>> +	}
>> +}
>> +
>> +/**
>> + * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
>> + * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
>> + * @npages: number of entries in @src_pfns
>> + *
>> + * Skip source PFNs already migrated to RAM by either migration path. The
>> + * raw-PFN eviction array starts at allocation offset zero, so the array index
>> + * is also the retirement bitmap index.
>> + */
>> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
>> +					   unsigned long npages)
>> +{
>> +	unsigned long i = 0;
>> +
>> +	while (i < npages) {
>> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
>> +		struct drm_pagemap_zdd *zdd;
>> +		unsigned long nr = 1;
>> +
>> +		if (!page) {
>> +			i++;
>> +			continue;
>> +		}
>> +
>> +		nr = folio_nr_pages(page_folio(page));
>> +
>> +		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
>> +		    !drm_pagemap_is_devmem_page(page))
>> +			goto next;
>> +
>> +		zdd = drm_pagemap_page_zone_device_data(page);
>> +		if (WARN_ON_ONCE(i >= zdd->range_npages)) {
>> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>> +			goto next;
>> +		}
>> +
>> +		if (test_bit(i, zdd->retire_map))
>> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
>> +next:
>> +		i += nr;
>> +	}
>> +}
>> +
>>   /**
>>    * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
>>    * @devmem_allocation: Pointer to the device memory allocation
>>    *
>> - * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
>> - * migration done via migrate_device_* functions.
>> + * Similar to __drm_pagemap_migrate_to_ram(), but uses the
>> + * migrate_device_* helpers and does not require the mmap lock. Device
>> + * PFNs already migrated to RAM by either migration path are skipped.
>>    *
>>    * Return: 0 on success, negative error code on failure.
>>    */
>> @@ -1149,6 +1268,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>>   	if (err)
>>   		goto err_free;
>>   
>> +	drm_pagemap_skip_retired_pages(src, npages);
>> +
>>   	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
>>   						   src, dst, 0);
>>   	if (err || !mpages)
>> @@ -1179,6 +1300,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>>   	if (err)
>>   		drm_pagemap_migration_unlock_put_pages(npages, dst);
>>   	migrate_device_pages(src, dst, npages);
>> +	/* Raw-PFN eviction: array starts at allocation offset zero. */
>> +	drm_pagemap_retire_migrated_pages(src, npages, 0);
>>   	migrate_device_finalize(src, dst, npages);
>>   	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
>>   					DMA_FROM_DEVICE, &state);
>> @@ -1251,6 +1374,10 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>>   	if (end > vas->vm_end)
>>   		end = vas->vm_end;
>>   
>> +	/* Keep the range within the ZDD allocation so retirement offsets stay valid. */
>> +	start = max(start, zdd->range_start);
>> +	end = min(end, zdd->range_start + (zdd->range_npages << PAGE_SHIFT));
> Hmm, I guess this tricky if this partially unmapped or meremapped to a
> different address, so we need to keep this purely physical.
>
> New idea - store the migration state in folio itself in the private
> data in lowest bits of folio->page.zone_device_data (set in
> folio_set_zone_device_data) and mask if off in
> drm_pagemap_page_zone_device_data.
>
> e.g.,
>
> #define DRM_PAGEMAP_ZDD_FLAG_MIGRATED	BIT(0)
> #define DRM_PAGEMAP_ZDD_FLAG_MASK	0x1ull	/* we can expand this to 0x7 on 64 builds if we need more flags */
>
> static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
> {
>          struct folio *folio = page_folio(page);
>
> 	/* XXX: Plus whatever casting needed */
>          return folio_zone_device_data(folio) & ~DRM_PAGEMAP_ZDD_FLAG_MASK;
> }
>
> static void drm_pagemap_page_set_flags(struct page *page, unsigned long flags)
> {
>          struct folio *folio = page_folio(page);
> 	struct drm_pagemap_zdd *zdd = drm_pagemap_page_zone_device_data(page);
>
> 	WARN_ON_ONCE(flags & ~DRM_PAGEMAP_ZDD_FLAG_MASK);
> 	folio_set_zone_device_data(folio, zdd | flags);
> }
>
> static unsigned long drm_pagemap_page_get_flags(struct page *page)
> {
>          struct folio *folio = page_folio(page);
>
> 	/* XXX: Plus whatever casting needed */
>          return folio_zone_device_data(folio) & DRM_PAGEMAP_ZDD_FLAG_MASK;
> }
>
> drm_pagemap_retire_migrated_pages()
> 	for_each_page_migrated
> 		drm_pagemap_page_set_flags(page, DRM_PAGEMAP_ZDD_FLAG_MIGRATED);
>
> drm_pagemap_skip_retired_pages gets the flags, skips any folio with
> DRM_PAGEMAP_ZDD_FLAG_MIGRATED set.
>
> I think this will work and keep everything in the physical world.


Thanks, this looks cleaner. I will use a low bit of zone_device_data to 
mark the folio as migrated, mask the bit when retrieving the ZDD, and 
preserve it when the folio is split. This also removes the bitmap and 
virtual-range tracking.

>
> Also btw, some of Sashiko pre-existing which have been flagged are fixed
> in this series:https://patchwork.freedesktop.org/series/171651/


Thanks for pointing this out. I will mentioned this.


Thanks,
Arvind

>
> Matt
>
>> +
>>   	migrate.start = start;
>>   	migrate.end = end;
>>   	npages = npages_in_range(start, end);
>> @@ -1309,6 +1436,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>>   	if (err)
>>   		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>>   	migrate_vma_pages(&migrate);
>> +	drm_pagemap_retire_migrated_pages(migrate.src, npages,
>> +					  (start - zdd->range_start) >> PAGE_SHIFT);
>>   	migrate_vma_finalize(&migrate);
>>   	if (dev)
>>   		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
>> -- 
>> 2.43.0
>>
--------------0rd3b4D9HvFrBNwARNHdkb1E
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: 8bit

<!DOCTYPE html><html><head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 06-08-2026 12:51, Matthew Brost
      wrote:<br>
    </div>
    <blockquote type="cite" cite="mid:anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">On Thu, Aug 06, 2026 at 11:41:26AM +0530, Arvind Yadav wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">A device page migrated to system memory by a CPU fault can remain
referenced after migration completes. During this window, raw-PFN
eviction can collect the same device PFN and migrate it again.

The first migration has already transferred the memcg charge from the
source folio. Migrating that source again can create an uncharged system
folio. Adding such a folio to the LRU can spin indefinitely in
folio_lruvec_lock_irqsave(), causing a soft lockup and an RCU stall.

Track successful device-page migrations in an allocation-relative bitmap
stored in drm_pagemap_zdd. Record successful migrations before finalize
unlocks and drops the migration reference on the source.

Make raw-PFN eviction skip retired folios. Record raw-PFN migrations as
well so an eviction retry cannot select a folio migrated by an earlier
pass.

Mark every base-page bit covered by a migrated folio so the retirement
state remains valid if the source folio is later split.

v2:
- Replace the retired-PFN XArray with an embedded bitmap.(Matthew Brost)
- Mark every base page covered by a migrated folio so retirement remains
  valid if the folio is later split.

The lockup was observed as:
==============================
[10109.860465] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [kworker/u65:5:6557]
[10109.860508] irq event stamp: 308085402
[10109.860508] hardirqs last  enabled at (308085401): [&lt;ffffffff829571e1&gt;] _raw_spin_unlock_irqrestore+0x51/0x80
[10109.860514] hardirqs last disabled at (308085402): [&lt;ffffffff8293dd71&gt;] sysvec_apic_timer_interrupt+0x11/0xc0
[10109.860516] softirqs last  enabled at (307538534): [&lt;ffffffff813d111b&gt;] __irq_exit_rcu+0xdb/0x1c0
[10109.860519] softirqs last disabled at (307538529): [&lt;ffffffff813d111b&gt;] __irq_exit_rcu+0xdb/0x1c0
[10109.860521] CPU: 9 UID: 0 PID: 6557 Comm: kworker/u65:5 Kdump: loaded Tainted: G S         O        7.2.0-rc3-lgci-xepurge-
[10109.860524] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
[10109.860524] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
[10109.860525] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
[10109.860644] RIP: 0010:_raw_spin_unlock_irqrestore+0x57/0x80
[10109.860647] Code: 00 75 1c 65 ff 0d 69 ee 84 01 74 20 5b 41 5c 5d 31 c0 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc e8 8f 2e c9
[10109.860648] RSP: 0018:ffffc9000c017030 EFLAGS: 00000246
[10109.860649] RAX: 0000000000000000 RBX: ffff8881012c00d0 RCX: 0000000000000000
[10109.860650] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
[10109.860650] RBP: ffffc9000c017040 R08: 0000000000000000 R09: 0000000000000000
[10109.860651] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
[10109.860651] R13: ffffc9000c0170a0 R14: ffff8881012c00d0 R15: ffff88810e9e6f00
[10109.860652] FS:  0000000000000000(0000) GS:ffff8888db2f2000(0000) knlGS:0000000000000000
[10109.860653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[10109.860653] CR2: 00007a26c0e00048 CR3: 00000001f366d006 CR4: 0000000000f72ef0
[10109.860654] PKRU: 55555554
[10109.860655] Call Trace:
[10109.860655]  &lt;TASK&gt;
[10109.860657]  folio_lruvec_lock_irqsave+0x216/0x220
[10109.860661]  ? __pfx_lru_add+0x10/0x10
[10109.860665]  folio_batch_move_lru+0xc8/0x450
[10109.860670]  ? lock_acquire+0xc4/0x2d0
[10109.860674]  ? __folio_batch_add_and_move+0x60/0x2e0
[10109.860677]  ? folio_migrate_mapping+0xa6/0x110
[10109.860679]  ? folio_migrate_flags+0x13b/0x1b0
[10109.860681]  ? __pfx_lru_add+0x10/0x10
[10109.860683]  __folio_batch_add_and_move+0xe7/0x2e0
[10109.860685]  ? dma_iova_try_alloc+0xb0/0x140
[10109.860689]  folio_add_lru+0x64/0x80
[10109.860691]  __migrate_device_finalize+0x12c/0x270
[10109.860695]  migrate_device_finalize+0x10/0x20
[10109.860698]  drm_pagemap_evict_to_ram+0x185/0x370 [drm_gpusvm_helper]
[10109.860704]  ? drm_pagemap_evict_to_ram+0x96/0x370 [drm_gpusvm_helper]
[10109.860709]  xe_svm_bo_evict+0x15/0x20 [xe]
[10109.860819]  ? xe_svm_bo_evict+0x15/0x20 [xe]
[10109.860921]  xe_bo_move+0x107e/0x1570 [xe]
[10109.860992]  ? xe_ttm_tt_create+0x168/0x340 [xe]
[10109.861059]  ? __up_read+0x98/0x2b0
[10109.861061]  ? lock_is_held_type+0xa3/0x130
[10109.861067]  ttm_bo_handle_move_mem+0xe8/0x1e0 [ttm]
[10109.861075]  ttm_bo_evict+0x141/0x1c0 [ttm]
[10109.861081]  ttm_bo_evict_cb+0x9f/0x100 [ttm]
[10109.861086]  ttm_lru_walk_for_evict+0x84/0x190 [ttm]
[10109.861091]  ? xe_ttm_vram_mgr_new+0x258/0x3a0 [xe]
[10109.861198]  ttm_bo_alloc_resource+0x219/0x750 [ttm]
[10109.861203]  ? ttm_bo_alloc_resource+0xa9/0x750 [ttm]
[10109.861208]  ? lock_acquire+0xc4/0x2d0
[10109.861214]  ttm_bo_validate+0x94/0x1c0 [ttm]
[10109.861218]  ? ww_mutex_trylock+0x19d/0x3d0
[10109.861219]  ? _raw_write_unlock+0x22/0x50
[10109.861223]  ttm_bo_init_reserved+0x17d/0x1f0 [ttm]
[10109.861228]  xe_bo_init_locked+0x20a/0x620 [xe]
[10109.861294]  ? __pfx_xe_ttm_bo_destroy+0x10/0x10 [xe]
[10109.861359]  ? mark_held_locks+0x46/0x90
[10109.861361]  ? __create_object+0x68/0xc0
[10109.861366]  __xe_bo_create_locked+0x384/0xa20 [xe]
[10109.861432]  ? lock_acquire+0xc4/0x2d0
[10109.861434]  ? xe_drm_pagemap_populate_mm+0xd3/0x340 [xe]
[10109.861542]  xe_bo_create_locked+0x23/0x40 [xe]
[10109.861609]  xe_drm_pagemap_populate_mm+0x12e/0x340 [xe]
[10109.861707]  ? __lock_acquire+0x43e/0x2930
[10109.861716]  drm_pagemap_populate_mm+0x74/0xe0 [drm_gpusvm_helper]
[10109.861720]  xe_svm_alloc_vram+0xb5/0x2c0 [xe]
[10109.861817]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
[10109.861819]  ? ktime_get+0x23/0x130
[10109.861821]  ? trace_hardirqs_on+0x22/0xe0
[10109.861823]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
[10109.861826]  __xe_svm_handle_pagefault+0x77d/0xbf0 [xe]
[10109.861924]  ? rwsem_down_write_slowpath+0x43a/0x9a0
[10109.861926]  ? _raw_spin_unlock_irq+0x27/0x70
[10109.861928]  ? rwsem_down_write_slowpath+0x43a/0x9a0
[10109.861929]  ? trace_hardirqs_on+0x22/0xe0
[10109.861931]  ? _raw_spin_unlock_irq+0x27/0x70
[10109.861933]  ? rwsem_down_write_slowpath+0x459/0x9a0
[10109.861937]  xe_svm_handle_pagefault+0x3d/0xb0 [xe]
[10109.862030]  xe_pagefault_queue_work+0x1a9/0x520 [xe]
[10109.862122]  process_one_work+0x239/0x730
[10109.862127]  worker_thread+0x200/0x3f0
[10109.862130]  ? __pfx_worker_thread+0x10/0x10
[10109.862132]  kthread+0x10d/0x150
[10109.862133]  ? __pfx_kthread+0x10/0x10
[10109.862135]  ret_from_fork+0x3bd/0x470
[10109.862138]  ? __pfx_kthread+0x10/0x10
[10109.862140]  ret_from_fork_asm+0x1a/0x30
[10109.862146]  &lt;/TASK&gt;

Fixes: 99624bdff867 (&quot;drm/gpusvm: Add support for GPU Shared Virtual Memory&quot;)
Cc: Maarten Lankhorst <a class="moz-txt-link-rfc2396E" href="mailto:maarten.lankhorst@linux.intel.com">&lt;maarten.lankhorst@linux.intel.com&gt;</a>
Cc: Maxime Ripard <a class="moz-txt-link-rfc2396E" href="mailto:mripard@kernel.org">&lt;mripard@kernel.org&gt;</a>
Cc: Thomas Zimmermann <a class="moz-txt-link-rfc2396E" href="mailto:tzimmermann@suse.de">&lt;tzimmermann@suse.de&gt;</a>
Cc: David Airlie <a class="moz-txt-link-rfc2396E" href="mailto:airlied@gmail.com">&lt;airlied@gmail.com&gt;</a>
Cc: Simona Vetter <a class="moz-txt-link-rfc2396E" href="mailto:simona@ffwll.ch">&lt;simona@ffwll.ch&gt;</a>
Cc: Matthew Brost <a class="moz-txt-link-rfc2396E" href="mailto:matthew.brost@intel.com">&lt;matthew.brost@intel.com&gt;</a>
Cc: Thomas Hellström <a class="moz-txt-link-rfc2396E" href="mailto:thomas.hellstrom@linux.intel.com">&lt;thomas.hellstrom@linux.intel.com&gt;</a>
Cc: Himal Prasad Ghimiray <a class="moz-txt-link-rfc2396E" href="mailto:himal.prasad.ghimiray@intel.com">&lt;himal.prasad.ghimiray@intel.com&gt;</a>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Arvind Yadav <a class="moz-txt-link-rfc2396E" href="mailto:arvind.yadav@intel.com">&lt;arvind.yadav@intel.com&gt;</a>
---
 drivers/gpu/drm/drm_pagemap.c | 143 ++++++++++++++++++++++++++++++++--
 1 file changed, 136 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
index 7a056592ac66..713095e27006 100644
--- a/drivers/gpu/drm/drm_pagemap.c
+++ b/drivers/gpu/drm/drm_pagemap.c
@@ -7,6 +7,7 @@
 #include &lt;linux/dma-mapping.h&gt;
 #include &lt;linux/migrate.h&gt;
 #include &lt;linux/pagemap.h&gt;
+#include &lt;linux/bitmap.h&gt;
 #include &lt;drm/drm_drv.h&gt;
 #include &lt;drm/drm_pagemap.h&gt;
 #include &lt;drm/drm_pagemap_util.h&gt;
@@ -66,6 +67,12 @@
  * @refcount: Reference count for the zdd
  * @devmem_allocation: device memory allocation
  * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
+ * @range_start: Virtual start address of the device memory allocation. Used to
+ * translate a clipped CPU-fault range into an allocation-relative page offset.
+ * @range_npages: Number of pages covered by the allocation, i.e. the number of
+ * valid bits in @retire_map.
+ * @retire_map: Allocation-relative bitmap. Every base page covered by a
+ * migrated folio remains marked until this mapping generation is destroyed.
  *
  * This structure serves as a generic wrapper installed in
  * page-&gt;zone_device_data. It provides infrastructure for looking up a device
@@ -78,29 +85,38 @@ struct drm_pagemap_zdd {
 	struct kref refcount;
 	struct drm_pagemap_devmem *devmem_allocation;
 	struct drm_pagemap *dpagemap;
+	unsigned long range_start;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Sashiko pointed this out as well: you can't store anything virtual in a
ZDD because it represents a physical object. The range_start may or may
not be the same by the time a fault occurs.
</pre>
    </blockquote>
    <p><br>
    </p>
    <p><span>Noted</span>. The ZDD represents the physical object, so
      storing range_start there is not correct. I will remove it and use
      the per-folio state suggested below.</p>
    <blockquote type="cite" cite="mid:anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	unsigned long range_npages;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
devmem_allocation-&gt;size can derive the number of pages.</pre>
    </blockquote>
    <p><br>
    </p>
    <p><span>Noted</span><span>. I will derive the page count from </span><code dir="ltr"><span>devmem_allocation-&gt;size</span></code><span>
        and remove </span><code dir="ltr"><span>range_npages</span></code><span>.</span></p>
    <blockquote type="cite" cite="mid:anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+	unsigned long retire_map[];
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
This won't be needed or any changes to the zdd actually, more below.</pre>
    </blockquote>
    <p><br>
    </p>
    <p><span>Noted. I will remove </span><code dir="ltr"><span>retire_map</span></code><span>
        and keep </span><code dir="ltr"><span>struct drm_pagemap_zdd</span></code><span>
        unchanged.</span></p>
    <blockquote type="cite" cite="mid:anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre"> };
 
 /**
  * drm_pagemap_zdd_alloc() - Allocate a zdd structure.
  * @dpagemap: Pointer to the underlying struct drm_pagemap.
+ * @start: Virtual start address of the device memory allocation.
+ * @npages: Number of pages in the device memory allocation.
  *
  * This function allocates and initializes a new zdd structure. It sets up the
- * reference count and initializes the destroy work.
+ * reference count and a zeroed retirement bitmap sized for @npages.
  *
- * Return: Pointer to the allocated zdd on success, ERR_PTR() on failure.
+ * Return: Pointer to the allocated zdd on success, NULL on failure.
  */
 static struct drm_pagemap_zdd *
-drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
+drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap, unsigned long start,
+		      unsigned long npages)
 {
 	struct drm_pagemap_zdd *zdd;
 
-	zdd = kmalloc_obj(*zdd);
+	zdd = kzalloc(struct_size(zdd, retire_map, BITS_TO_LONGS(npages)),
+		      GFP_KERNEL);
 	if (!zdd)
 		return NULL;
 
 	kref_init(&amp;zdd-&gt;refcount);
 	zdd-&gt;devmem_allocation = NULL;
 	zdd-&gt;dpagemap = drm_pagemap_get(dpagemap);
+	zdd-&gt;range_start = start;
+	zdd-&gt;range_npages = npages;
 
 	return zdd;
 }
@@ -669,7 +685,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
 	pagemap_addr = buf + (2 * sizeof(*migrate.src) * npages);
 	pages = buf + (2 * sizeof(*migrate.src) + sizeof(*pagemap_addr)) * npages;
 
-	zdd = drm_pagemap_zdd_alloc(dpagemap);
+	zdd = drm_pagemap_zdd_alloc(dpagemap, start, npages);
 	if (!zdd) {
 		err = -ENOMEM;
 		kvfree(buf);
@@ -1102,12 +1118,115 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
 }
 EXPORT_SYMBOL(drm_pagemap_put);
 
+/**
+ * drm_pagemap_is_devmem_page() - Check whether a page is device memory
+ * @page: page to check
+ *
+ * Return: true if @page is device-private or device-coherent
+ */
+static bool drm_pagemap_is_devmem_page(const struct page *page)
+{
+	return is_device_private_page(page) || is_device_coherent_page(page);
+}
+
+/**
+ * drm_pagemap_retire_migrated_pages() - Record migrated device folios
+ * @src_pfns: source array after migrate_vma_pages() or migrate_device_pages()
+ * @npages: number of entries in @src_pfns
+ * @first: allocation-relative page offset of @src_pfns[0]
+ *
+ * Record successful migrations in the zdd retirement bitmap before finalize
+ * unlocks the sources. The bit is set only after a confirmed migration, and
+ * test_and_set_bit() is used because concurrent CPU faults on clipped ranges
+ * can update different bits in the same word.
+ */
+static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
+					      unsigned long npages,
+					      unsigned long first)
+{
+	unsigned long i = 0;
+
+	while (i &lt; npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct drm_pagemap_zdd *zdd;
+		unsigned long bit, j, nr = 1;
+
+		if (!page) {
+			i++;
+			continue;
+		}
+
+		nr = folio_nr_pages(page_folio(page));
+
+		if (!(src_pfns[i] &amp; MIGRATE_PFN_MIGRATE) ||
+		    !drm_pagemap_is_devmem_page(page))
+			goto next;
+
+		zdd = drm_pagemap_page_zone_device_data(page);
+		bit = first + i;
+
+		if (WARN_ON_ONCE(bit &gt;= zdd-&gt;range_npages ||
+				 nr &gt; zdd-&gt;range_npages - bit))
+			goto next;
+
+		/* Keep later folio splits covered. */
+		for (j = 0; j &lt; nr; j++)
+			WARN_ON_ONCE(test_and_set_bit(bit + j, zdd-&gt;retire_map));
+next:
+		i += nr;
+	}
+}
+
+/**
+ * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
+ * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
+ * @npages: number of entries in @src_pfns
+ *
+ * Skip source PFNs already migrated to RAM by either migration path. The
+ * raw-PFN eviction array starts at allocation offset zero, so the array index
+ * is also the retirement bitmap index.
+ */
+static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
+					   unsigned long npages)
+{
+	unsigned long i = 0;
+
+	while (i &lt; npages) {
+		struct page *page = migrate_pfn_to_page(src_pfns[i]);
+		struct drm_pagemap_zdd *zdd;
+		unsigned long nr = 1;
+
+		if (!page) {
+			i++;
+			continue;
+		}
+
+		nr = folio_nr_pages(page_folio(page));
+
+		if (!(src_pfns[i] &amp; MIGRATE_PFN_MIGRATE) ||
+		    !drm_pagemap_is_devmem_page(page))
+			goto next;
+
+		zdd = drm_pagemap_page_zone_device_data(page);
+		if (WARN_ON_ONCE(i &gt;= zdd-&gt;range_npages)) {
+			src_pfns[i] &amp;= ~MIGRATE_PFN_MIGRATE;
+			goto next;
+		}
+
+		if (test_bit(i, zdd-&gt;retire_map))
+			src_pfns[i] &amp;= ~MIGRATE_PFN_MIGRATE;
+next:
+		i += nr;
+	}
+}
+
 /**
  * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
  * @devmem_allocation: Pointer to the device memory allocation
  *
- * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
- * migration done via migrate_device_* functions.
+ * Similar to __drm_pagemap_migrate_to_ram(), but uses the
+ * migrate_device_* helpers and does not require the mmap lock. Device
+ * PFNs already migrated to RAM by either migration path are skipped.
  *
  * Return: 0 on success, negative error code on failure.
  */
@@ -1149,6 +1268,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		goto err_free;
 
+	drm_pagemap_skip_retired_pages(src, npages);
+
 	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &amp;mpages,
 						   src, dst, 0);
 	if (err || !mpages)
@@ -1179,6 +1300,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, dst);
 	migrate_device_pages(src, dst, npages);
+	/* Raw-PFN eviction: array starts at allocation offset zero. */
+	drm_pagemap_retire_migrated_pages(src, npages, 0);
 	migrate_device_finalize(src, dst, npages);
 	drm_pagemap_migrate_unmap_pages(devmem_allocation-&gt;dev, pagemap_addr, dst, npages,
 					DMA_FROM_DEVICE, &amp;state);
@@ -1251,6 +1374,10 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (end &gt; vas-&gt;vm_end)
 		end = vas-&gt;vm_end;
 
+	/* Keep the range within the ZDD allocation so retirement offsets stay valid. */
+	start = max(start, zdd-&gt;range_start);
+	end = min(end, zdd-&gt;range_start + (zdd-&gt;range_npages &lt;&lt; PAGE_SHIFT));
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
Hmm, I guess this tricky if this partially unmapped or meremapped to a
different address, so we need to keep this purely physical.

New idea - store the migration state in folio itself in the private
data in lowest bits of folio-&gt;page.zone_device_data (set in
folio_set_zone_device_data) and mask if off in
drm_pagemap_page_zone_device_data.

e.g.,

#define DRM_PAGEMAP_ZDD_FLAG_MIGRATED	BIT(0)
#define DRM_PAGEMAP_ZDD_FLAG_MASK	0x1ull	/* we can expand this to 0x7 on 64 builds if we need more flags */

static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
{
        struct folio *folio = page_folio(page);

	/* XXX: Plus whatever casting needed */
        return folio_zone_device_data(folio) &amp; ~DRM_PAGEMAP_ZDD_FLAG_MASK;
}

static void drm_pagemap_page_set_flags(struct page *page, unsigned long flags)
{
        struct folio *folio = page_folio(page);
	struct drm_pagemap_zdd *zdd = drm_pagemap_page_zone_device_data(page);

	WARN_ON_ONCE(flags &amp; ~DRM_PAGEMAP_ZDD_FLAG_MASK);
	folio_set_zone_device_data(folio, zdd | flags);
}

static unsigned long drm_pagemap_page_get_flags(struct page *page)
{
        struct folio *folio = page_folio(page);

	/* XXX: Plus whatever casting needed */
        return folio_zone_device_data(folio) &amp; DRM_PAGEMAP_ZDD_FLAG_MASK;
}

drm_pagemap_retire_migrated_pages()
	for_each_page_migrated
		drm_pagemap_page_set_flags(page, DRM_PAGEMAP_ZDD_FLAG_MIGRATED);

drm_pagemap_skip_retired_pages gets the flags, skips any folio with
DRM_PAGEMAP_ZDD_FLAG_MIGRATED set.

I think this will work and keep everything in the physical world.</pre>
    </blockquote>
    <p><br>
    </p>
    <p>Thanks, this looks cleaner. I will use a low bit of
      zone_device_data to mark the folio as migrated, mask the bit when
      retrieving the ZDD, and preserve it when the folio is split. This
      also removes the bitmap and virtual-range tracking.</p>
    <blockquote type="cite" cite="mid:anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

Also btw, some of Sashiko pre-existing which have been flagged are fixed
in this series: <a class="moz-txt-link-freetext" href="https://patchwork.freedesktop.org/series/171651/">https://patchwork.freedesktop.org/series/171651/</a></pre>
    </blockquote>
    <p><br>
    </p>
    <p>Thanks for pointing this out. I will mentioned this.</p>
    <p><br>
    </p>
    <p>Thanks,<br>
      Arvind</p>
    <blockquote type="cite" cite="mid:anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com">
      <pre wrap="" class="moz-quote-pre">

Matt

</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">+
 	migrate.start = start;
 	migrate.end = end;
 	npages = npages_in_range(start, end);
@@ -1309,6 +1436,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
 	if (err)
 		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
 	migrate_vma_pages(&amp;migrate);
+	drm_pagemap_retire_migrated_pages(migrate.src, npages,
+					  (start - zdd-&gt;range_start) &gt;&gt; PAGE_SHIFT);
 	migrate_vma_finalize(&amp;migrate);
 	if (dev)
 		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
-- 
2.43.0

</pre>
      </blockquote>
    </blockquote>
  </body>
</html>

--------------0rd3b4D9HvFrBNwARNHdkb1E--
