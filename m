Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06241FB5164
	for <dri-devel@archiver.kernel.org>; Mon,  6 Apr 2026 21:02:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6016010E2DC;
	Mon,  6 Apr 2026 21:02:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="B6Z5d64I";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45D5C10E2DC;
 Mon,  6 Apr 2026 21:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775509373; x=1807045373;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=6AyedZLyd3ORvxm65IQpl3WpLU9WUfQ4eeikPsDdZWA=;
 b=B6Z5d64IdChoCVc+21JbCP7XPw/EMJfvImXKmzTRpF0nXgh+X6uo5pRb
 4yZb6bLe53fsOtW7cdIlOxDYk8jEhEdfT/3LVnJsYf1AlXUi8MB4TjvIf
 F1yTXFJ/+wal2T0rBX1sWXkyK64whuijaDbLIQEdHj4lW+eHcDUeZHtf0
 cc28LNU8fjSG+l+gWY0ImVsfUc/ZogNIm3zFPQ2iqLoy5wf+rFcvnFPXH
 vTPNgu4XdaVVJdCgGUI8r2Zsfm+vZP9hyQ6W4HUK4XN4hkrvzpaUSN82n
 T4gpM2Lm/WM7A6GHonYXe/2nNBQQj0h4J/s+dW4gEKjSiC0SrffbTblGr Q==;
X-CSE-ConnectionGUID: 1039jg5wSziK0D+6GS4tBQ==
X-CSE-MsgGUID: fM87r8feRpWzseVlu0A1xQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76360949"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="76360949"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 14:02:53 -0700
X-CSE-ConnectionGUID: 9u1ildGTQXmsaXXdPeAZpw==
X-CSE-MsgGUID: sR1LbX+ST7ivP5ve/vIRXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; d="scan'208";a="227911462"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Apr 2026 14:02:52 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 14:02:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Mon, 6 Apr 2026 14:02:51 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.7) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 6 Apr 2026 14:02:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BeaeiRI8XjGGMSyiE0cLZlfKz8f8tdnsNwoy6xqnCgCAHTBpvCH5gNBXdNcDIElCSU32VUWmxoNDAGqSw4Bn/lCdi3cRuIuRwin88sp1oyDUFnk/1lg23wgRIm6q321up8VG0Jr0QgYrMQ4F3JkzfNqZ5BM9QsN39wxHugl0uG9URmoQroFwGHrl3jh/el9vfzn73uurpKMuE0P2NpDYR1MHXC6jyFTGse5P4fpINyCjrgMSSf46JWwvdFeQc+GyuizuK38skyWYYc7h4mot0L16/sQH5x33Kuvz4QIlZjR7RgkcVeix0N9N6B9Avwli2BZiuw5o2c5Ec4o0dcZQRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mTlma43JEGRwfdjC9cKmQOCFaD4gwytN2cQuLbgPXAk=;
 b=J9ZL/vNWQtz4iaL0cfc3mHRAikoDKnd4HFR143So7YbyLsVHJFIIbSWa+71qkDx8VYFOuIvup6niMzH8CkEWE78JK5VR7Vy4PfspWMn//x7VzhJ8X72H/4L0fYA/v5pN22Jq2T3F8nzie3dpmd3M/M/F5V3p5lJrMNA5qMeA9aHePbdsNWTU8xyVACc18zKmebCIia8fiieNqvqVn8WXbiKf/eAJanw8jgpI+cA6y77/gcaFQz5waJQYwJGZ2HsRY4/2jGm7+rgacKuEzfvFqf8gXA0YislUeGibzRYCpeN7MY0B+qMMW7UQmIdxHqLFoZJMibDbuXuKB+89a2iC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH0PR11MB5032.namprd11.prod.outlook.com (2603:10b6:510:3a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.18; Mon, 6 Apr
 2026 21:02:48 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Mon, 6 Apr 2026
 21:02:48 +0000
Date: Mon, 6 Apr 2026 14:02:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Daniel Colascione <dancol@dancol.org>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under mem
 pressure
Message-ID: <adQfdL0zV7SOo+al@gsse-cloud1.jf.intel.com>
References: <87341fsa85.fsf@dancol.org>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87341fsa85.fsf@dancol.org>
X-ClientProxiedBy: SJ0PR05CA0064.namprd05.prod.outlook.com
 (2603:10b6:a03:332::9) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH0PR11MB5032:EE_
X-MS-Office365-Filtering-Correlation-Id: c95b91b2-711f-4c72-fb26-08de941fdb74
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: pPe5oRSsY3vLEY8JRuSlO0ewRQSHnftMlf5bdKa+mzVDLr3iSUQkCuwHXJNFJ849JnBQsKS2Ud/j9vfBrkN9QZQ/pBrYdmZUJX0CAKYDlDMlBhbUjZV0T3jR86PJOC7xQchqYSPFE8h7jKcV4BEl6Ij/DYCXgJCpVIO0GFj876CtqnxFrReQyWglt45dsM+MlVbKkTViPn6wjf8X+DCIG4Vw3yshJA7VzMHj9h2DAzOmSkiAY/529gGk1C+svLL/nvYjh8flPWM4U8+lWuY4jQob5BaTmSc3Mk9MbQAAzJwJpbSCnx0bWSNhYcQMkApCJMi294cqdbNnsioFSIPU2AaCAS2TdHfGFaGVlopkQzJBgqm3I+1iDTzc4JAJrrylPyGEKJwplyhgoo8z62/oU8EucptXQvhisU+J3uWTAPd958LPdZ+QvATSis4+et0JMZog+tk32sPYhHGEN3h90GQI80W+C1UJgr+0t0aifiT/jfdIG7XG+f73uEWcjlxI3SW3R0kWTY8Oq2ax8vGJsLwz/Mw/U9psvIJ+dvcLPs7HL1Buav9QDBcLskIvjbwU5ZgNfLm0KJplFz4nJBOXLJqYDZhRH84wq3dMkpXbHGcJ4CB1egHCPi6yUIK9GzST/q/4EwZBYk+4diZI40vF7dLJQpwo1/rPBrXLvl17voG9oOw/ak5Ru+upyKHfAbZN
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(366016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d0hBOWdabGpVY0VoT0N1KzNpMmdWYm11T0VGYW9DWFl1UngweHBhaEZrVXRi?=
 =?utf-8?B?Tm9tQ1FDNHRSaUZsMXYzNGZUYWZSMkI2dExuZ0p5c1BFRmgrdzVLNUw3cWZH?=
 =?utf-8?B?U0pSM1dlMU1wUkVrZHVJU01MOFJXV1RObHMrWWR3Y3VHb0Y3N3FzVU41dnhQ?=
 =?utf-8?B?Wm9oL0VSVVNVZFdoMU5kbHErTEhzK3V5RWxsV2NOWEJ6aXZ1RExKVExsQkxw?=
 =?utf-8?B?bzJUS1lQMU8vZGp6VjRYZm01QzhvakJsMFdTN09XNkh0QkVpbHh0OVJ0a3FR?=
 =?utf-8?B?VlZwdG5nVHJLU2VqWUt1bm50cHBKOUJ6N1lqMDVxSy8rUHhCYngwRlM0TFd5?=
 =?utf-8?B?bXJNN25kQUIzSHZQTzV6YWRRUmlTcVNZZEhTdFZiOUMvbVZYemlZR09UaWw0?=
 =?utf-8?B?WkN4eTZ6RWlQM3drOXlrS1o3YTM3RXU4N2FVUjd1ZE1jZlNpWFdKeXBjeXdo?=
 =?utf-8?B?TGdzOFdqZDdyNXBUK0syRTBDa1lVSnZhdWpJeWNFN0t4N2pwVGpLM1R6RjFm?=
 =?utf-8?B?bVdmNVkrU1dEN04yRWlmc2U5Rmt1QUJBRTBueHNqT3dISUs4UzBUZ2ROTFVS?=
 =?utf-8?B?bTIvVmwrU0FMcW11MXNMb1hKOG4xWVdCcTA3RENNRkExNVIzb1duZ3JvRHFJ?=
 =?utf-8?B?Rk00MkxrWEVWVmtVdm1JWGxLMGVCUHBERi80OE5TMUpMQW5qN3RiUHE4eUNJ?=
 =?utf-8?B?ODJLRU01NkZ4aXZpV0xHT00rcnpqU3hlVTRLdnhDcU5JTEptUWhGMmQzY2Q1?=
 =?utf-8?B?M0FiVUcyVnduOVpkeHhqZHJWb2JmVUdYU3ZEQzYxbFBTMjVOTVJDMU1QSVY4?=
 =?utf-8?B?WUtFRFZBYkxFaVBkWHJzRlozOFg2T2I2azBFOThZd0pZVDJ1ZWdtZy9wcEhS?=
 =?utf-8?B?WnRsMUNCMFgvdU5YSXcveGY2WVZrN1dTeGhSbVBEV2N1c05qbG5NUGJTZUtt?=
 =?utf-8?B?NC9KMzdjQzdwbWZHTFFkN0NBRFMwcXhCcVYzY1FyL3NmRHBvS3Z4V0h6bkdy?=
 =?utf-8?B?cEpPbWUyZVNWKzhjY3owVDRtQms5R1FEV0F4Qy95S2tBV3dDMVE3MVIvMmxJ?=
 =?utf-8?B?MFFsU2x1TXFKaVRVV3dVMmYxYzlyNFdZeDRuWkJFL2hLQWE0ZGx1WWNhRm0z?=
 =?utf-8?B?K2FmWkpnQ3N1WXkxczlmYjBxdDU0ekN2MmFDVVNKNFJKdlVmWlV1WWQyN3M0?=
 =?utf-8?B?WDdRaVhiVjF6WS9jNE9BY3ByaTJaVmJvMUNmblljUVI5NzIxNzByNTNJQVQ3?=
 =?utf-8?B?Sk5xMWlmcWl2eC85YW5GUk4yWVdQOW9KOE5zSnZDVmFnQVpXVlMxZnpHc3JU?=
 =?utf-8?B?dWpnRlhnall3bmRoOFVsWGs1R0trdzVVWUNxOEIrbHhDL3drMk5UN3VMcGVE?=
 =?utf-8?B?cGtUTmRPbFdNNGowZllub2RIK3hYbVZvR2UxSmRGZVZvNEwyQ2dNOW96S0Qy?=
 =?utf-8?B?aVZBelhGK3hHVGVpWnFXN29EV05IR01GTFRNRUtXSG5OVjZyTFlnVmtrblpW?=
 =?utf-8?B?RnVicGNuVUNHeUZUZXZBNU5OeHRNR2tqSHZkZkE1eVdZZ3l2dmhGeGVFTmZ6?=
 =?utf-8?B?UTYyeWVRRGpmY0M4MEV1Y2dxaFJ0R2ZBZ2pOYU5rUTJhNzRrenNVU3Evaloz?=
 =?utf-8?B?MzUrR080cURUK1JSakVJM29udTVlcCtMSUhpb2VNaVA1eHpnYlZwSnpEcGVN?=
 =?utf-8?B?VlcvenduZTFWZ3RwL2JRTlY4SDZ4dEhKVERVWUtJU2UrNE5ybkxFTzVNN0R1?=
 =?utf-8?B?U1MxTDhoKzJLY0pqRytEVnBPSlo4OHc5Z25Mc05rNk1veTBWNUVpMndERUZV?=
 =?utf-8?B?QzRTdW5Bd3VpLzZ3eTB4Q0lmVWRpak90WjlqTVJxSnpCVjBjeWs5RWJtU0NY?=
 =?utf-8?B?ZVJxYTJJS2g2T0ZaazJ4SHd5MnZsMXZIVSsrVzNoL3ZMeVdpeDVzb1RwVFdI?=
 =?utf-8?B?eUZHMnRTU0NhY0RjV0xVQlpmR0diOXBvN0ZUYy9uSVBJdC9VWDg3UXZ6Z3JY?=
 =?utf-8?B?bE9TMnZyVEZITTVJNGVzdG8veEdSM09oU1FnU1hkN1F0cWdaN2U3bTZpbXNW?=
 =?utf-8?B?alVoamRGMFBnZ0Focml1eG9LZkRQRGNaNVhBeXRFMmdXd0YxNTYzNk5Way9K?=
 =?utf-8?B?Q0twVHJDaEx6dXVtMkhNeUIyUDFUSFBlU002TkQ3bUxSbmxMQk5QT0dObWNv?=
 =?utf-8?B?cXJ6MVRKN0ozS01uZDZ6SGpNWXF3Q01kRTd3OUtONjEvQUg5SW1mWE5yWDd6?=
 =?utf-8?B?bENCc1dUanNmdjBlRFdWOGY1SlM2OGNzeGRvN0RVeWNYNTVHSW1WaWNwQ2F0?=
 =?utf-8?B?V1A1aFNOZVdqdTBwNjlrWjBOZXhWZGhZTGlBY1d2c0pTcFF0dDdaSnFnbnRN?=
 =?utf-8?Q?xzHsGhP3fhB643gI=3D?=
X-Exchange-RoutingPolicyChecked: W9jH9cLRX5sU4KNTZ3BAIgq5Curj9q8PyEKuAItBFDN6UiJQ72ZKw8yLrkqCtkyI0GT3TGBgytqYG18wMQJ2E6Y33ViyRq6OZMUw31F6TAYuRwM7yMAxJeX9pYshDLgDEOupfQwN10n4oUivk+G1DbyeH6B5jhpGQpj8y3Qj4hGuL2hQoEuAPex5XOA14V5bm8YchvDQD4pmGEtgr39QJ/q3Vb1VIXdGdY5/pxxRNDlK6j/XRqu3rmj7eXlS7gEqToJFYwPXZHaQ5XDcGLBWd9e+o4bnRslrHoiWpj90/WepN7N7wxeQcX4emexcHG+az+XGXtQmr5YtuUuzj9TcNg==
X-MS-Exchange-CrossTenant-Network-Message-Id: c95b91b2-711f-4c72-fb26-08de941fdb74
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 21:02:48.1947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9xPk39fkCtuddAxpSiknXlEPallMTUey3l2ofbLQx/dbQZWDdiXtyDvmvK+zdusg4gC72VyFnaq7VQ0obRDJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5032
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

On Tue, Mar 31, 2026 at 10:08:58PM -0400, Daniel Colascione wrote:
> TTM seems to be too eager to kick off reclaim while kwin is drawing
> 
> I've noticed that in 7.0-rc6, and since at least 6.17, kwin_wayland
> stalls in DRM ioctls to xe when the system is under memory pressure,
> causing missed frames, cursor-movement stutter, and general
> sluggishness. The root cause seems to be synchronous and asynchronous
> reclaim in ttm_pool_alloc_page as TTM tries, and fails, to allocate
> progressively lower-order pages in response to pool-cache misses when
> allocating graphics buffers.
> 
> Memory is fragmented enough that the compaction fails (as I can see in
> compact_fail and compact_stall in /proc/vmstat; extfrag says the normal
> pool is unusable for large allocations too). Additionally, compaction
> seems to be emptying the ttm pool, since page_pool in TTM debugfs
> reports all the buckets are empty while I'm seeing the
> kwin_wayland sluggishness.
> 
> In profiles, I see time dominated by copy_pages and clear_pages in the
> TTM paging code. kswapd runs constantly despite the system as a whole
> having plenty of free memory.
> 
> I can reproduce the problem on my 32GB-RAM X1C Gen 13 by booting with
> kernelcore=8G (not needed, but makes the repro happen sooner), running a
> find / >/dev/null (to fragment memory), and doing general web
> browsing. The stalls seem self-perpetuating once it gets started; it
> persists even after killing the find. I've noticed this stall in
> ordinary use too, even without the kernelcore= zone tweak, but without
> kernelcore, it usually takes a while (hours?) after boot for memory to
> become fragmented enough that higher-order allocations fail.
> 
> The patch below fixes the issue for me. TBC, I'm not sure it's the
> _right_ fix, but it works for me. I'm guessing that even if the approach
> is right, a new module parameter isn't warranted.
> 
> With the patch below, when I set my new max_reclaim_order ttm module
> parameter to zero, the kwin_wayland stalls under memory pressure
> stop. (TBC, this setting inhibits sync or async reclaim except for
> order-zero pages.)  TTM allocation occurs in latency-critical paths
> (e.g. Wayland frame commit): do you think we _should_ reclaim here?
> 
> BTW, I also tried having xe pass a beneficial order of 9, but it didn't
> help: we end up doing a lot of compaction work below this order anyway.

I was going to suggest changing Xe to align with what AMDGPU is doing [1].

Unfortunate this didn’t help.

[1] https://elixir.bootlin.com/linux/v6.19.11/source/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c#L1795

> 
> Signed-off-by: Daniel Colascione <dancol@dancol.org>
> 
> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> index c0d95559197c..fd255914c0d3 100644
> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> @@ -115,9 +115,13 @@ struct ttm_pool_tt_restore {
>  };
>  
>  static unsigned long page_pool_size;
> +static unsigned int max_reclaim_order;
>  
>  MODULE_PARM_DESC(page_pool_size, "Number of pages in the WC/UC/DMA pool");
>  module_param(page_pool_size, ulong, 0644);
> +MODULE_PARM_DESC(max_reclaim_order,
> +                "Maximum order that keeps upstream reclaim behavior");
> +module_param(max_reclaim_order, uint, 0644);
>  
>  static atomic_long_t allocated_pages;
>  
> @@ -146,16 +150,14 @@ static struct page *ttm_pool_alloc_page(struct ttm_pool *pool, gfp_t gfp_flags,
>          * Mapping pages directly into an userspace process and calling
>          * put_page() on a TTM allocated page is illegal.
>          */
> -       if (order)
> +       if (order) {
>                 gfp_flags |= __GFP_NOMEMALLOC | __GFP_NORETRY | __GFP_NOWARN |
>                         __GFP_THISNODE;
> -
> -       /*
> -        * Do not add latency to the allocation path for allocations orders
> -        * device tolds us do not bring them additional performance gains.
> -        */
> -       if (beneficial_order && order > beneficial_order)
> -               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +               if (beneficial_order && order > beneficial_order)
> +                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> +               if (order > max_reclaim_order)
> +                       gfp_flags &= ~__GFP_RECLAIM;

I’m not very familiar with this code, but at first glance it doesn’t
seem quite right.

Would setting Xe’s beneficial to 9, similar to AMD’s, along with this
diff, help?

If I’m understanding this correctly, we would try a single allocation
attempt with __GFP_DIRECT_RECLAIM cleared for the size we care about,
still attempt allocations from the pools, and then finally fall back to
allocating single pages one at a time.

Matt

diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
index aa41099c5ecf..f1f430aba0c1 100644
--- a/drivers/gpu/drm/ttm/ttm_pool.c
+++ b/drivers/gpu/drm/ttm/ttm_pool.c
@@ -714,6 +714,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
                            struct ttm_pool_alloc_state *alloc,
                            struct ttm_pool_tt_restore *restore)
 {
+       const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
        enum ttm_caching page_caching;
        gfp_t gfp_flags = GFP_USER;
        pgoff_t caching_divide;
@@ -757,7 +758,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
                if (!p) {
                        page_caching = ttm_cached;
                        allow_pools = false;
-                       p = ttm_pool_alloc_page(pool, gfp_flags, order);
+                       if (!order || order >= beneficial_order)
+                               p = ttm_pool_alloc_page(pool, gfp_flags, order);
                }
                /* If that fails, lower the order if possible and retry. */
                if (!p) {


> +       }
>  
>         if (!ttm_pool_uses_dma_alloc(pool)) {
>                 p = alloc_pages_node(pool->nid, gfp_flags, order);
