Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA9B9C5DF87
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 23:57:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C650910F1D1;
	Thu, 20 Aug 2026 23:57:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PVf3Dt5C";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 221EB10E1A1;
 Thu, 20 Aug 2026 23:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787270271; x=1818806271;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=GGNxlXI0wfXFy2AMJiPa9fvvJOVeifmzXUeUAOJZB6k=;
 b=PVf3Dt5CrLeERdORZzen1rLru32OTKJONLjSjBO5gvN6q/0gAIPPaknd
 +QW8inMz9X8WNhDGjEcCVhR50lNrSXWJnQ2DWN7cWR7f8MAqdfMzvPOhT
 edZOgZfdn1h7BHlKGhpbSic0qW/j3/iWkqucUmcx3o8uEi4jLlD7Yx8mb
 yIBiVJmfyT1La/CBB1s+VkW9jXpgfmeEv+7HkkUrwamM74OVN+Bsi2bp9
 fqhWuPbYAd7Vbt0qjaOZt8uwduvQ5YNRD2x5z5AQNA7K6hcmk1zY3TpoN
 hJg05ATqHwtOOiyy9TKCsyqlPx4zifFPxIZ4JQd/ZcC55NztS8v900hYI g==;
X-CSE-ConnectionGUID: zObmt6FZQQyTgAayVrktgA==
X-CSE-MsgGUID: rU1MpneIQr6WmpVxJNwkdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="105198743"
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="105198743"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 16:57:50 -0700
X-CSE-ConnectionGUID: hCkuFZwNQLKCfqCadPCycw==
X-CSE-MsgGUID: 1JtBY32LQJup+xcKo//9tQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,234,1779174000"; d="scan'208";a="304374815"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 16:57:49 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 16:57:48 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 16:57:48 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.64) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 16:57:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YwbeTviv2M/suRY2ssYxL/30eOFhBbfk/ARrquYIsW2JjdyKk0w7A2NVQ/SMKN04xySXowBV2vjzp3GoUaontuOPoMirMZx5M1rWBKdmHFw8fSjwIQHCr+6hkmSC++eMyjRTUEwyETpec1VkjyIbtlRfgp0HGWHQegeTGHuZFO3nAdo4zc+oZQiikh+Gwa0rSUvDZt5qhX7z8iGKVrp/90ZcTs/c9iL6Cz8/MoT910j3Srsafr8vuCkAsu4nAcpY6cWwER+RXN+5ABWQC+5NccxFAXfGz1ZG5RvjGVFr+F+jMQc0L8Bh26cQRaRp2jdEFe4wMeIFA2aOsuzsG+R88Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9EM8BFk9k6or/jex2XjL/CKdYtqyStHBwoC7EDt1t2M=;
 b=BPWYI+J62Dqr7bD4jCupy3qeYNaqDNu5poLTMReTyTaT3MIbAV2fzYR/ZpnKuj2ydmMxd+I2GTuR9ChsNEbUXTxLA8Qg86Df7EDUSilKKuTSWbBuaNdGthInesB5Mu9qO03y57YdoOgP3/ceMmRbx7rT/7VQhrz2CBQzbEECejWmMb7nEM5SNC5pqmbXeento2l5IjoUXDuSIqyHRH4hCIbadpcc+rbSCQ2qg7Plsd6biTsMcdsusYLygS0XJ8ZRcUAKjyK9jogP1oM7Qh0qjIyGpdP/4Ayn8vOHy9sCjeDFsPpeifC2Op2GcmR8cxQBfmtKvsNhv0n6p2RKplXk0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BL1PR11MB5954.namprd11.prod.outlook.com (2603:10b6:208:385::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.9; Thu, 20 Aug
 2026 23:57:45 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0339.008; Thu, 20 Aug 2026
 23:57:44 +0000
Date: Thu, 20 Aug 2026 16:57:41 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
CC: Nathan Bourgeois <iridescentrosesfall@gmail.com>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>, Matthew Auld
 <matthew.auld@intel.com>, David Airlie <airlied@gmail.com>, Simona Vetter
 <simona@ffwll.ch>
Subject: Re: [PATCH] drm/xe: Fix unnecessary host-side population of ttm_tt
 on non-TT resources
Message-ID: <aoeUdfrPX+0ZnZMr@gsse-cloud1.jf.intel.com>
References: <20260820031901.1018324-1-iridescentrosesfall@gmail.com>
 <aoczaCuoaZfUkfm5@gsse-cloud1.jf.intel.com>
 <CAMpTW2cxRrG4oJ0HrRoKhHrVHxWO01-L+QDoWMLCAUaSfw75sA@mail.gmail.com>
 <CAMpTW2fxFRrpn1b5WGYBrtLLMfUo_fmx9s2D0b552GJp-sF5qg@mail.gmail.com>
 <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8b7001c68c94491095f41d2a3dff45090c0a95cf.camel@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0080.namprd03.prod.outlook.com
 (2603:10b6:303:b6::25) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BL1PR11MB5954:EE_
X-MS-Office365-Filtering-Correlation-Id: d4afe7e1-ac82-4c33-bcb9-08deff16d3c9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|1800799024|366016|376014|6133799003|10067099003|4143699003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: +V9K8hH/UAygezHwhUqDs9o8npVKVJLAD6+XO8ikem4cuf7ewITAAynTpmr1kqO5CUzdjcHpTSPM365Pu2exiIa8WhrWW+xNMV69ZNerAp+hA7MPoR4d2M26SIMM8Mgi2vjRKroLP6VK1YYUkC2FO3VTMKl5Q6OC/oNf0nVXR4E2aJ6jAXJNhk3Aw8ztC2ZOzmAtfNdmB0ySTsLYVrItKpu0kaZkiL9HGCbI7EP2tvzMRdmBY83f7WOe9yoaiJwrszVB3b7RO9O015g5ARNZzuIHqZoP0dWBUZL/cUtnwTuLrK7H6AC4YInBWzHy0TIQLA0Z1x2YZrbwp6nW+QzSirkckVRCOn4vSvtRG86MkJSEeWkkHgaUSM6zJrryC8W05bjRGlfiKgizr7gSOPEeJg2p5EjdKg5Ens+rrkYsCPj3L4Zb1NC/D7xYdoUXcUQuVdm9KWETCLWJXUcIjWpsA3tkHiHf9xcpgJoeZjjo1EyGWhj1hVjmxwGyaN7ZJB1WF9HL02t06jQ/Y6yp6yPtOxZ+F/i1tWCC+tNMjefRzhVpRkBVK2Xf7hdBOCBRTQWUWacOxIoUmjVyVZt1lxHOP6KC/VWMv3xrIldYqBYFoew1ZMbTqQ/jrzk4dMg4hiN4qk5Pvlxlo5DgoqqQn1LygIYUgC6WCVHf0ftYpBtpsxw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(6133799003)(10067099003)(4143699003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YnRWeDN1Nk0yZFJ6V2sxNUxSd0EwWkgrQ1lSajE4cE43cTk4NXhPUG5IYXJk?=
 =?utf-8?B?QkJZTm5XeGxiVnM0L1hoQnd6TDFvK2s0M2llVnhLOE1TOE5ybnRRaHVpTUc3?=
 =?utf-8?B?QmFXN3Evams5aDkySjZOSXFNRUZ2WnVENzI5aGttRFFJN2xaQVVNNFRTNjNU?=
 =?utf-8?B?VHhNNjhXUVowTGtWQlBkQXNIT3I5WWFjUkF3OXFhcmZ1by9GVHFhcTNnTGhm?=
 =?utf-8?B?V1U3aER5djdNN3ptMm00WVdwVVFrdXJiNHd2aURqTU1NV29QWm9wTW5OY3pH?=
 =?utf-8?B?MjlZYVI3S09vWkQ3ejA4MGhYV0hDbEdiTVo1ZGFRQnlocm41Rkk1WUtBYno0?=
 =?utf-8?B?ZWpGaVhsTnQvUGVDMlBTSGxmbkRNZUtQSi9pUTZZUW1nSWF1bXpyNmVpcTRR?=
 =?utf-8?B?N0lEaUUxOUtNK2t4WS9SY09yTlN4azFiTXdlclMydkxvaHdKMWUvaDBUb1V4?=
 =?utf-8?B?cjZNTS9XdXovL1lVYkFjSlZYTXdmbEFORGFPdzhITDZNOWZySVEzck5BY253?=
 =?utf-8?B?TXZQNjNRS1FTVXFwM1VGV1grOW41WEdrWHE1REIyc1VIM1hVNC96dWZ3WXJ4?=
 =?utf-8?B?c2hYZUJvL0orcGxsUU1ZS09rNlNoU2lUOFV4QkVpbCtrZVRuby9FRUtwNVZs?=
 =?utf-8?B?b3pBOEIxUWxBamVXaGdNL0hUZDN1K1FyZG05ZW1HUGNkbHdXWkVtcndDUnNj?=
 =?utf-8?B?MUkvMlJkMFBaek9WU2NaZFI0RkFSdklGZGZrTDhDYmVGOGtjaXgzVjdBZURO?=
 =?utf-8?B?eThrSjhmU3RZVHpyRkt1eVZlY2JDaTFPQzFBbnhZenhNZ1kvMm56WTJWc0th?=
 =?utf-8?B?eUdOVitwS2VaVy9vVElKOEgwY2Qwb3N4WWJBSHplUEVqNWg3NERvYm15dGlR?=
 =?utf-8?B?c3pmT2VXMk15alBnSzhXbXNyTmRrSTRXdGpHRmNSRzR5SVlMZWJ6RlV1NUhT?=
 =?utf-8?B?ZCtqUEs2WFBRWEpJWG92NXZsMXNZdkJwSlZkRmxXZGZ2MGxjYWpSdmtYUnpw?=
 =?utf-8?B?NVNTWEdHOTZHbGtTU0tmcDJoZHZNS1JkSTBCQ1FiM3JKRDJuWUZXeW5pbS8r?=
 =?utf-8?B?ekRFbzJyc2g2aWYxUUp4UTlicS96c0hqVHZYeDVvdnZ6TUdjd3hCNkVIUnhh?=
 =?utf-8?B?MkNudFMvMkFOdTc0V2JjZEVoc3pDUURFdFBTTnhQcTZVWWhvQmFpRWVXTjRa?=
 =?utf-8?B?MmdoeGdCSW1pVkQzWEI3T0lZbjRMV1dPcTBBdlVKT0xMZUNrSWw3ME9Kejdm?=
 =?utf-8?B?bThlYWJ5MkV2eStBWXFoSXRQTUx0Y3FFMGtKMGk1V2l1YWQvYlllWWNVSTdC?=
 =?utf-8?B?MG1JbUd2Z0NlMXlLcGJ5L2xnYXU5K0UvSVZiSDNTeXJyTjJ5aGlweGdBVE9w?=
 =?utf-8?B?Sm1JTW9JYUxrOVBZNmpzTFUxRXdPSVR3TXFiMVlBa3FFTElkVGdVazRkSFJJ?=
 =?utf-8?B?T3dtQ0RvM0pFd2xXOFgxSmVjeHpoK2NGWmFjRmQ2cXZZRHBwWjJVa1lJV2du?=
 =?utf-8?B?NHVQQ29FYmdJVUpSWlRHUzBINEFmY01tcTRvUlJ2UXZiek1ZN25ibXY3UnZ4?=
 =?utf-8?B?bjZHeThha1cxcktMOUdpVWhhcGZ2NCs2aFJQS0QybU16bG9zSGh5QlZVNEVS?=
 =?utf-8?B?d2plakFDa3lHVzN0MmdFaUZib3FhditPNjhFUXpxZ0FCVnFITWhoV0tYSTNl?=
 =?utf-8?B?UzJTMFBFajZDdjhjdXIwNXE1VVVuSWlUTmU3K1dabXJ0M09GNW9BYVlLR1R2?=
 =?utf-8?B?dFVlMmo0Q3lGc3Fyayt3NWRCcTdocldQdnQxS2dKOEhhYzQ0QkgzV2x4SEd1?=
 =?utf-8?B?SVpSRVFQSkFUeGQvS3RJUmZ3NVYyZWdHa0UrN3hUVWpIQXBJWm05SGY1WURN?=
 =?utf-8?B?RVh2RUp5d2pkdjZEaUE3V0FnRkRVN1RSSnV1bkdZYkx1aUVIU25sK0NldDFy?=
 =?utf-8?B?RllJZFNpN1RzZWZLR2Z3UmhZWC95a1dnWHpibE9QYWpRWktmRGU4M1VJZUdn?=
 =?utf-8?B?ZEI3cW5nMGd4Y2s3SkRIc3JlUXJ0L0pKOVFQdGhFcXRSeEpNODlBeElqUnUy?=
 =?utf-8?B?NG9pcUFxVXZjKzM3OGlDMUJIeDdJbTgwZVc3M0NCTldVbGd6cU0wdEtFNlJs?=
 =?utf-8?B?bGpHQk1ycU5GbVR6UVQweG1HOEg1TDU0VlZ0Snd1U2UzWHk2SHhlWGl1M01a?=
 =?utf-8?B?YVBwaDMvcG1nZkhxdmJ2TXRQaXBZVFRHUUtsRFRxUEJjSXlCYXFPRjRkdVhN?=
 =?utf-8?B?TzZJNGtubFg1ZWJSM0F4WFl6ajBKYTFtM2hKOXcrOTkwN244RHlqa1B0L1RD?=
 =?utf-8?B?cnpWSElOc1FDYU1jREI1Z2xPbnU0ZGxHbkRUTVQ4VzhpWE0yQW9Ga0gycVNW?=
 =?utf-8?Q?UJ44Zt/FQ/KjaW/k=3D?=
X-Exchange-RoutingPolicyChecked: hJjLWGuHX//y9nZXWKJBHt5aDU6qDHtDPt0CtEA6r+cTWKgT7tLOnnd3esQOCjuFTevEF0m8uumNLbPrJpLxQxrYmn2DUorZDgTcQ7lI1xkCqqWgwmiIVvKpaXR8JpiaQMxTAWQfrVPaMmRRccCQLNt2pK2Akw1usR0jLbZS4Z2VdMATNGPxhslcIeg15J8YyQNRy0Z7qbeg4vn7SQvJj/SYozjbifESWYgRfOyEXjRvVu8vZ3pQ+HR7wzUK9y+p7beMhaCy0qp9KOc0wXmdIUCMD9joonZ95V91hhclBjFHrG5szJZgfp40XNsriyJI7PuarTw/PHiWPpBlOCgByg==
X-MS-Exchange-CrossTenant-Network-Message-Id: d4afe7e1-ac82-4c33-bcb9-08deff16d3c9
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 23:57:44.4001 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FDZhQZOWLjM53JP7Q7dsFPVZnD4niqcX3VMHd3fLeAo1+PVz213PUyZJhRidTjpTiMSEUIgO4mqqwck0YBoXEA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR11MB5954
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

On Thu, Aug 20, 2026 at 10:03:30PM +0200, Thomas Hellström wrote:
> On Thu, 2026-08-20 at 14:56 -0400, Nathan Bourgeois wrote:
> > Hi,
> > Sorry, I replied only to Matt by mistake earlier and didn't realize
> > it
> > was text-only. Here's the same reply for the list:
> > 
> > Hi Matt,
> > 
> > Thank you so much for reviewing this!
> > 
> > > Reading the commit which added ttm_bo_setup_export, to me this
> > > looks
> > > like a bug in ttm_bo_setup_export() or in general TTM.
> > 
> > > 'This only applies currently to TTM_PL_SYSTEM objects, because
> > > GTT objects get populated on first validate, and VRAM doesn't
> > > use TT.'
> > 
> > > I'd probably move this fix into ttm_bo_setup_export() and post it
> > > for
> > > discussion.
> > 
> > I agree that this is a much cleaner and smaller fix, I initially
> > wanted to keep
> > the change scoped only to xe where it was causing an observable
> > issue,
> > but I will move it into ttm_bo_setup_export() given your
> > recommendation.
> > 
> > > It may also be the case that the ttm_tt preallocated with
> > > XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to
> > > VRAM, as
> > > that dangling ttm_tt could cause other issues. I'll need to take a
> > > closer look at that angle.
> > 
> > Yes, considering that this is essentially the source of this
> > particular behavior
> > it stands to reason that there may be other latent correctness issues
> > caused
> > by the dangling ttm_tt.
> > 
> > > This part looks good as different patch from what I'm assuming will
> > > be a
> > > TTM fix.
> > 
> > Yes, I'll submit a patch with RFC for discussing the
> > ttm_bo_setup_export()
> > changes and a second patch for the unit test.
> > 
> > Best Regards,
> > Nathan Bourgeois
> > 
> > 
> > On Thu, Aug 20, 2026 at 2:01 PM Nathan Bourgeois
> > <iridescentrosesfall@gmail.com> wrote:
> > > 
> > > Hi,
> > > 
> > > Sorry, I replied only to Matt by mistake earlier. Here's the same
> > > reply for the list:
> > > 
> > > Hi Matt, Thank you so much for reviewing this! > Reading the commit
> > > which added ttm_bo_setup_export, to me this looks
> > > > like a bug in ttm_bo_setup_export() or in general TTM.
> > > 
> > > > 'This only applies currently to TTM_PL_SYSTEM objects, because
> > > > GTT objects get populated on first validate, and VRAM doesn't
> > > > use TT.'
> > > 
> > > > I'd probably move this fix into ttm_bo_setup_export() and post it
> > > > for
> > > > discussion.
> > > 
> > > I agree that this is a much cleaner and smaller fix, I initially
> > > wanted to keep
> > > the change scoped only to xe where it was causing an observable
> > > issue,
> > > but I will move it into ttm_bo_setup_export() given your
> > > recommendation.
> > > 
> > > > It may also be the case that the ttm_tt preallocated with
> > > > XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to
> > > > VRAM, as
> > > > that dangling ttm_tt could cause other issues. I'll need to take
> > > > a
> > > > closer look at that angle.
> > > 
> > > Yes, considering that this is essentially the source of this
> > > particular behavior
> > > it stands to reason that there may be other latent correctness
> > > issues caused
> > > by the dangling ttm_tt.
> > > 
> > > > This part looks good as different patch from what I'm assuming
> > > > will be a
> > > > TTM fix.
> > > 
> > > Yes, I'll submit a patch with RFC for discussing the
> > > ttm_bo_setup_export()
> > > changes and a second patch for the unit test.
> > > 
> > > Best Regards,
> > > Nathan Bourgeois
> 
> When I read the purpose of the original commit, I wonder if this is the
> correct solution.
> 
> Regardless of whether the bo will eventually be attached as a VRAM
> (p2p) dma-buf or a system dma-buf, we essentially want to charge
> upfront.
> 
> Shouldn't we just be calling xe_bo_validate() here instead of
> ttm_tt_populate? (With the correct xe_validation_guard() wrapping).

Yes, this might be a better solution, making ttm_bo_setup_export()
completely unnecessary.

It's also a bit odd that, in flows where we don't have backing storage
on export, we populate with pages and charge the system memory cgroup,
only to move the data to VRAM when the import attach is triggered,
resulting in a copy and a change in cgroup charging.

I guess the question is why was ttm_bo_setup_export() introduced over
just a validation at export?

Matt

> 
>  If it's a system bo, ttm_tt_populate would eventually be called. If
> it's a VRAM bo, we'd correctly charge dmemcg, and if the bo gets
> migrated to system as part of attach, whatever cgroup controller will
> be used for system memory will most likely charge the same cgroup that
> got charged for the VRAM.
> 
> /Thomas
> 
> > > 
> > > On Thu, Aug 20, 2026 at 1:03 PM Matthew Brost
> > > <matthew.brost@intel.com> wrote:
> > > > 
> > > > On Wed, Aug 19, 2026 at 11:19:01PM -0400, Nathan Bourgeois wrote:
> > > > 
> > > > Thanks the patch.
> > > > 
> > > > > When a buffer object (BO) has a created but unpopulated ttm_tt
> > > > > and is
> > > > > exported, the default behavior populates the ttm_tt, even if
> > > > > the manager
> > > > > does not require a TT. This unnecessary host-side population
> > > > > reduces
> > > > > host memory available to the user.
> > > > > 
> > > > > This occurs when a BO is created with XE_BO_FLAG_DEFER_BACKING
> > > > > and
> > > > > migration places the BO into a resource whose manager does not
> > > > > use the
> > > > > TT backing. The retained ttm_tt is not authoritative for
> > > > > storage, yet
> > > > > the default ttm_bo_setup_export() treats the existence of the
> > > > > ttm_tt as
> > > > > requiring population.
> > > > > 
> > > > 
> > > > Thanks for explaining this, I see the problem.
> > > > 
> > > > > The issue was reproduced with vLLM 0.27.1 loading
> > > > > 0xSer0/DeepSeek-V4-Flash-180B (d3c704b) on a system with 128 GB
> > > > > of RAM
> > > > > and six Intel Arc Pro B70 GPUs providing 192 GB of VRAM.
> > > > > Loading the
> > > > > weights (100.61 GB) triggered host-memory exhaustion and OOM
> > > > > events on
> > > > > the baseline kernel.
> > > > > 
> > > > > On Ubuntu 24.04 with 7.0-12-generic, the vLLM service cgroup
> > > > > grew by
> > > > > 115.84 GB on the instrumented baseline and by 15.34 GB with
> > > > > this change,
> > > > > a reduction of 100.50 GB. Diagnostic instrumentation counting
> > > > > cumulative
> > > > > TT pages across all six GPUs recorded 109.22 GB on baseline and
> > > > > 8.72 GB
> > > > > with this change. The reduction is 0.11 GB less than the model
> > > > > weight
> > > > > size.
> > > > > 
> > > > > The change creates an Xe-local export setup helper which skips
> > > > > ttm_bo_populate() when the BO has a current resource manager
> > > > > and if that
> > > > > manager has use_tt == false. If the manager does not use TT,
> > > > > then
> > > > > population is skipped, while an absent manager conservatively
> > > > > calls
> > > > > ttm_bo_populate(). Behavior for a manager which requires a TT
> > > > > backing
> > > > > remains unchanged. Keep this policy local to Xe so other TTM
> > > > > drivers
> > > > > retain their existing export behavior.
> > > > > 
> > > > 
> > > > Reading the commit which added ttm_bo_setup_export, to me this
> > > > looks
> > > > like a bug in ttm_bo_setup_export() or in general TTM.
> > > > 
> > > > git format-patch -1 50243079865ae
> > > > 
> > > > 'This only applies currently to TTM_PL_SYSTEM objects, because
> > > > GTT objects get populated on first validate, and VRAM doesn't
> > > > use TT.'
> > > > 
> > > > I'd probably move this fix into ttm_bo_setup_export() and post it
> > > > for
> > > > discussion.
> > > > 
> > > > It may also be the case that the ttm_tt preallocated with
> > > > XE_BO_FLAG_DEFER_BACKING should be dropped once the BO moves to
> > > > VRAM, as
> > > > that dangling ttm_tt could cause other issues. I'll need to take
> > > > a
> > > > closer look at that angle.
> > > > 
> > > > > The regression test creates both the control case and the VRAM
> > > > > migration
> > > > > case. The control case creates the deferred BO in system RAM
> > > > > and leaves
> > > > > it there, which requires a TT and population when
> > > > > xe_gem_prime_export() is
> > > > > called. The VRAM migration case creates the deferred BO in
> > > > > system RAM
> > > > > and then migrates it to VRAM, which does not require a TT and
> > > > > thus, when
> > > > > xe_gem_prime_export() is called, no population occurs.
> > > > > 
> > > > 
> > > > This part looks good as different patch from what I'm assuming
> > > > will be a
> > > > TTM fix.
> > > > 
> > > > Matt
> > > > 
> > > > > Fixes: 91494dee1091 ("xe: populate buffers before exporting
> > > > > them.")
> > > > > Cc: stable@vger.kernel.org
> > > > > Assisted-by: Codex:gpt-5.6-sol
> > > > > Signed-off-by: Nathan Bourgeois <iridescentrosesfall@gmail.com>
> > > > > ---
> > > > > Newer Testing:
> > > > > - Built and booted b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
> > > > > plus this patch on EPYC 7352 with six Intel Arc Pro B70.
> > > > > - KUnit xe_live_test: xe_dma_buf_kunit: pass:6 fail:0 skip:0
> > > > > total:6 PASS
> > > > > - vLLM 0.27.1 loading DeepSeek-V4-Flash-0731 (full model
> > > > > compared to REAP) on six Intel Arc Pro B70 GPUs: No OOM error,
> > > > > 17.82 GB delta.
> > > > >  drivers/gpu/drm/xe/tests/xe_dma_buf.c | 105
> > > > > ++++++++++++++++++++++++++
> > > > >  drivers/gpu/drm/xe/xe_dma_buf.c       |  28 ++++++-
> > > > >  2 files changed, 132 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > > > > b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > > > > index 0be8440b3976..bff803ab7a57 100644
> > > > > --- a/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > > > > +++ b/drivers/gpu/drm/xe/tests/xe_dma_buf.c
> > > > > @@ -260,12 +260,117 @@ static const struct dma_buf_test_params
> > > > > test_params[] = {
> > > > >       {}
> > > > >  };
> > > > > 
> > > > > +static void xe_test_dmabuf_export_deferred(struct xe_device
> > > > > *xe, u32 bo_flags,
> > > > > +                                        u32 mem_type, bool
> > > > > expect_populated)
> > > > > +{
> > > > > +     struct drm_exec *exec = XE_VALIDATION_OPT_OUT;
> > > > > +     struct kunit *test = kunit_get_current_test();
> > > > > +     struct ttm_resource_manager *man;
> > > > > +     struct dma_buf *dmabuf;
> > > > > +     struct xe_bo *bo;
> > > > > +     size_t size = PAGE_SIZE;
> > > > > +     int err;
> > > > > +
> > > > > +     /* No VRAM on device? */
> > > > > +     if (!ttm_manager_type(&xe->ttm, mem_type))
> > > > > +             return;
> > > > > +
> > > > > +     if (mem_type == XE_PL_VRAM0 &&
> > > > > +         xe->info.vram_flags & XE_VRAM_FLAGS_NEED64K)
> > > > > +             size = SZ_64K;
> > > > > +
> > > > > +     /*
> > > > > +      * DEFER_BACKING places the BO in SYSTEM and creates a
> > > > > ttm_tt which
> > > > > +      * is unpopulated. In the case of VRAM, migrating leaves
> > > > > the ttm_tt
> > > > > +      * retained and unpopulated while VRAM becomes the real
> > > > > backing.
> > > > > +      */
> > > > > +     bo = xe_bo_create_user(xe, NULL, size,
> > > > > DRM_XE_GEM_CPU_CACHING_WC,
> > > > > +                            bo_flags |
> > > > > XE_BO_FLAG_DEFER_BACKING, NULL);
> > > > > +     if (IS_ERR(bo)) {
> > > > > +             KUNIT_FAIL(test, "BO creation failed: %pe\n",
> > > > > bo);
> > > > > +             return;
> > > > > +     }
> > > > > +
> > > > > +     err = xe_bo_lock(bo, false);
> > > > > +     if (err) {
> > > > > +             KUNIT_FAIL(test, "BO lock failed: %d\n", err);
> > > > > +             goto out_put_bo;
> > > > > +     }
> > > > > +
> > > > > +     if (bo->ttm.resource->mem_type != mem_type)
> > > > > +             err = xe_bo_migrate(bo, mem_type, NULL, exec);
> > > > > +     if (err) {
> > > > > +             KUNIT_FAIL(test, "BO migration to %u failed:
> > > > > %d\n", mem_type,
> > > > > +                        err);
> > > > > +             goto out_unlock;
> > > > > +     }
> > > > > +
> > > > > +     man = ttm_manager_type(bo->ttm.bdev, bo->ttm.resource-
> > > > > >mem_type);
> > > > > +     if (!man || !bo->ttm.ttm) {
> > > > > +             KUNIT_FAIL(test, "Expected a retained unpopulated
> > > > > TT\n");
> > > > > +             goto out_unlock;
> > > > > +     }
> > > > > +
> > > > > +     /* Precondition: ttm_tt starts unpopulated after
> > > > > migration */
> > > > > +     KUNIT_EXPECT_EQ(test, man->use_tt, expect_populated);
> > > > > +     KUNIT_EXPECT_FALSE(test, ttm_tt_is_populated(bo-
> > > > > >ttm.ttm));
> > > > > +
> > > > > +     xe_bo_unlock(bo);
> > > > > +
> > > > > +     dmabuf = xe_gem_prime_export(&bo->ttm.base, 0);
> > > > > +     if (IS_ERR(dmabuf)) {
> > > > > +             KUNIT_FAIL(test, "dma-buf export failed: %pe\n",
> > > > > dmabuf);
> > > > > +             goto out_put_bo;
> > > > > +     }
> > > > > +
> > > > > +     err = xe_bo_lock(bo, false);
> > > > > +     if (err) {
> > > > > +             KUNIT_FAIL(test, "post-export BO lock failed:
> > > > > %d\n", err);
> > > > > +             goto out_put_dmabuf;
> > > > > +     }
> > > > > +
> > > > > +     /* Postcondition: if VRAM, ttm_tt remains unpopulated, if
> > > > > SYSTEM ttm_tt is populated */
> > > > > +     KUNIT_EXPECT_EQ(test, bo->ttm.resource->mem_type,
> > > > > mem_type);
> > > > > +     KUNIT_EXPECT_NOT_NULL(test, bo->ttm.ttm);
> > > > > +     if (bo->ttm.ttm)
> > > > > +             KUNIT_EXPECT_EQ(test, ttm_tt_is_populated(bo-
> > > > > >ttm.ttm),
> > > > > +                             expect_populated);
> > > > > +
> > > > > +     xe_bo_unlock(bo);
> > > > > +     dma_buf_put(dmabuf);
> > > > > +     drm_gem_object_put(&bo->ttm.base);
> > > > > +     return;
> > > > > +
> > > > > +out_unlock:
> > > > > +     xe_bo_unlock(bo);
> > > > > +     goto out_put_bo;
> > > > > +out_put_dmabuf:
> > > > > +     dma_buf_put(dmabuf);
> > > > > +out_put_bo:
> > > > > +     drm_gem_object_put(&bo->ttm.base);
> > > > > +}
> > > > > +
> > > > >  static int dma_buf_run_device(struct xe_device *xe)
> > > > >  {
> > > > >       const struct dma_buf_test_params *params;
> > > > >       struct kunit *test = kunit_get_current_test();
> > > > > 
> > > > >       guard(xe_pm_runtime)(xe);
> > > > > +
> > > > > +     /*
> > > > > +      * A retained TT must not be populated when VRAM is the
> > > > > backing
> > > > > +      * resource.
> > > > > +      */
> > > > > +     xe_test_dmabuf_export_deferred(xe, XE_BO_FLAG_VRAM0,
> > > > > XE_PL_VRAM0,
> > > > > +                                    false);
> > > > > +
> > > > > +     /*
> > > > > +      * Control case: deferred SYSTEM backing must still be
> > > > > populated
> > > > > +      * before export.
> > > > > +      */
> > > > > +     xe_test_dmabuf_export_deferred(xe, XE_BO_FLAG_SYSTEM,
> > > > > XE_PL_SYSTEM,
> > > > > +                                    true);
> > > > > +
> > > > >       for (params = test_params; params->mem_mask; ++params) {
> > > > >               struct dma_buf_test_params p = *params;
> > > > > 
> > > > > diff --git a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > index bf0728838ead..0c4e4e2e1a81 100644
> > > > > --- a/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > +++ b/drivers/gpu/drm/xe/xe_dma_buf.c
> > > > > @@ -219,6 +219,32 @@ static const struct dma_buf_ops
> > > > > xe_dmabuf_ops = {
> > > > >       .vunmap = drm_gem_dmabuf_vunmap,
> > > > >  };
> > > > > 
> > > > > +static int xe_dma_bo_setup_export(struct ttm_buffer_object
> > > > > *tbo,
> > > > > +                               struct ttm_operation_ctx *ctx)
> > > > > +{
> > > > > +     struct ttm_resource_manager *man = NULL;
> > > > > +     int ret;
> > > > > +
> > > > > +     ret = ttm_bo_reserve(tbo, false, false, NULL);
> > > > > +     if (ret)
> > > > > +             return ret;
> > > > > +
> > > > > +     if (tbo->resource)
> > > > > +             man = ttm_manager_type(tbo->bdev, tbo->resource-
> > > > > >mem_type);
> > > > > +
> > > > > +     /*
> > > > > +      * Do not populate BO-sized system pages when backed by a
> > > > > non-TT resource.
> > > > > +      * This is Xe-specific; the generic ttm_bo_setup_export()
> > > > > always populates.
> > > > > +      */
> > > > > +     if (man && !man->use_tt)
> > > > > +             ret = 0;
> > > > > +     else
> > > > > +             ret = ttm_bo_populate(tbo, ctx);
> > > > > +
> > > > > +     ttm_bo_unreserve(tbo);
> > > > > +     return ret;
> > > > > +}
> > > > > +
> > > > >  struct dma_buf *xe_gem_prime_export(struct drm_gem_object
> > > > > *obj, int flags)
> > > > >  {
> > > > >       struct xe_bo *bo = gem_to_xe_bo(obj);
> > > > > @@ -257,7 +283,7 @@ struct dma_buf *xe_gem_prime_export(struct
> > > > > drm_gem_object *obj, int flags)
> > > > >       xe_bo_willneed_get_locked(bo);
> > > > >       xe_bo_unlock(bo);
> > > > > 
> > > > > -     ret = ttm_bo_setup_export(&bo->ttm, &ctx);
> > > > > +     ret = xe_dma_bo_setup_export(&bo->ttm, &ctx);
> > > > >       if (ret)
> > > > >               goto out_put;
> > > > > 
> > > > > 
> > > > > base-commit: b4f95affc66ef76342c1f6bf3849f6c8ade6b9d6
> > > > > --
> > > > > 2.55.0
> > > > > 
