Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B9BC606A32C
	for <dri-devel@archiver.kernel.org>; Sat,  7 Nov 2026 05:28:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZBrUa7t7
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E68F10E515;
	Sat,  7 Nov 2026 05:28:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 385A210E4F8;
 Sat,  7 Nov 2026 05:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794029277; x=1825565277;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=MY7vwtlihRlZNmSN0J1NztFZ8Ya6nNcZUalEbyfj83A=;
 b=ZBrUa7t734vfTadPv00mh7QAUTym590zYpCnJsy+LU0rjQCL3L2dgKUl
 tlRiXEjWNERq0wH5aS5DCd4D+7AtvWbMn5Q5uY4ovIgILZuyuti4Ely83
 engmj0ZDGu4MH1m3yjYgmAjMQ0sp0MD5+Q7pTa4ktpUVlDqsPRtzIJtWS
 gFBMoSBRYteY17qdp6SAoIn+kQg4Mgj33Mw3wvpJBAT/w/qmf6GQOPAl/
 XDhC1yWeGpnuqMUQhnRrsZpoxM3NjSnHgfhRIanFvoZbdzaOqbDLy+q3+
 VUFWH3UqRoCe1KneUS/2ayouq9gFBuBQLk56wq7k9gZfam3/EhRkPjFbq g==;
X-CSE-ConnectionGUID: dlTFDB4gT0ScWtH6sEWqiw==
X-CSE-MsgGUID: n0ZFN8cDT7+u7BApKvu3KQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11958"; a="2733808"
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="2733808"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 21:27:56 -0800
X-CSE-ConnectionGUID: D4oHA8gFTDid9PlXktIqAQ==
X-CSE-MsgGUID: 8aCZwm/DSU2Xafq5aWt8wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,199,1787036400"; 
   d="scan'208";a="7781281"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2026 21:27:55 -0800
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 21:27:54 -0800
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Fri, 6 Nov 2026 21:27:54 -0800
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.9) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Fri, 6 Nov 2026 21:27:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I89DdjnGVMxKfTtaLYCR91gjvMsoSkHxZhVIpAspBP7UdXAGvlVQYVg74VXHj1hS2+rOo3Bx/qw5/AYwHljFv1TB7zs3xipTJrCnO862QpSCzshFBXLTdFkOe92Ssot504Vfhmnrvkp+9d602NvFuZilwJrvP6GxrVoq+UQUJo5gJ2FzGmCw9GmJ8iJOBpb10r5PTPEgPIxIxGhiMrbL7flNGR7JPJJk6fecixFDy6vxWU/V0vtwDdRWxxHVD0zR7AoxH+KKtk+DYmgHS6bvDtjdFyHxdPKvpmxcFGiIz8YvUKuke7ho5a2quzQ+erW/nm4GHnTsxxZq8y82jaND/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ICGIZl0yGe001kHFVgX7MAY41f5i5HDJiJ3WZIZxb2c=;
 b=P+bdLoVbcRixLA2KtMbRQUEroYoXVLpZnwnFvbRHQSGwybtuCoJ9+FWDujll/plIrtwR+y4FAAXghfFF64MZSC3QRyVX3nkR1yxeC8bGGfmEp+muGdcsiPLMg0iWrLxYvLU58GVyQ+V8lcKxs6djfiMG0rUacD08Zf6iloAe6v8h2feWisJSXKk/wDWQt53D+U08SlJnY7ktA69hLXDYrk7/FPXfocjbhAvbNksfo/YJJv5ep39NK/Yi6zE12vmmJYdlrCVvXh+83VrSEFFp5v9jS5rzfcvinHHN/c5jMLvQ7yscf9/SubRuO0Dl8w9rRrDHnXJJEZv+nQs7zAVNoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW3PR11MB4684.namprd11.prod.outlook.com (2603:10b6:303:5d::14)
 by DS2PR11MB154527.namprd11.prod.outlook.com (2603:10b6:8:3bf::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Sat, 7 Nov
 2026 05:27:52 +0000
Received: from MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315]) by MW3PR11MB4684.namprd11.prod.outlook.com
 ([fe80::2f5a:96ce:f7e4:c315%7]) with mapi id 15.21.0569.011; Sat, 7 Nov 2026
 05:27:51 +0000
Date: Fri, 6 Nov 2026 21:27:48 -0800
From: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 Christian Koenig <christian.koenig@amd.com>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, <linux-kernel@vger.kernel.org>, Thomas
 =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 20/33] drm/xe: Add a page defragmentation worker
Message-ID: <au621A_K50hsPxnv@nvishwa1-desk>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-21-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260711025619.2540575-21-matthew.brost@intel.com>
X-ClientProxiedBy: BY3PR10CA0030.namprd10.prod.outlook.com
 (2603:10b6:a03:255::35) To MW3PR11MB4684.namprd11.prod.outlook.com
 (2603:10b6:303:5d::14)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR11MB4684:EE_|DS2PR11MB154527:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c21eb5e-5b50-4184-83d3-08df3c8fdde8
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|23010399003|376014|366016|6133799003|18002099003|22082099003|10067099003|11063799006|56012099006|4143699003|5023799004|261102123227099003|261028144727099003|261026121527099003|261026140227099003|261022105027099003|261021123027099003|261021121427099003|261009223027099003|261022075727099003|261009221227099003;
X-Microsoft-Antispam-Message-Info: Wxr7cRDpukdfGIDwI1MIbw1Ni4y/lptMkuqcKrU8bh8JXjCAkTSyK2fo0nPxARBT+2dFDzDUdv24fPtBmgYf5aFtD4K8H4vO2xmvIoIzA3babCD9IZpsxgCeCScZDD+0KzByqx+1gRUgMFm60jx2fkUg7IEhM6n0tG5Qaj/U7ORi4jxWRyq0FruV5f3ZAU7viaZxxSS4KbgGfdRCqe/xdCkd0PxRh2JlpwH45Xm4ejEAyVY0lBMc4jiW+7Xp7s1tcQPVSVoczrrDB4AGqIaD8WKlSzjqEcclFS4DDYZfDJtZKUK2C7jw7lY/b5uwrHKZ23o+sv10Y5OyiyGPpNhzl8UJkVm2IUy4iYYqbXTI1gOlvxTTqqvSoh4BXeorSXoF3DPbsoqTaH89Qr+lDgdF+niagcTk+Brpx4XVoY7ibn7HN9k7xB4BKnhOhJNDW8C3kNIjF0UlAmS6K2F472Mt0Ar8ykgo/VVqrWHPEzjymGmrbmhb7eFhe7EriDI+zSknBFJERDF7WvyT5EFpcU67NLtWzudoSe+ajOD4YG8rgumZ5jGvs3PJu8EOGbYRhjuxUOv//3iQCCFSbvUEgZIUJQcy7pvKWB0CV3k7Su546XAvYNaxxCjgqeQZXjhJKWXgxovMSJqgi2NpjbAQhCDOwB7CKo9zYW9njSXINaafmWw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW3PR11MB4684.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(23010399003)(376014)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(11063799006)(56012099006)(4143699003)(5023799004)(261102123227099003)(261028144727099003)(261026121527099003)(261026140227099003)(261022105027099003)(261021123027099003)(261021121427099003)(261009223027099003)(261022075727099003)(261009221227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?fjpgxPzJlJCwkEFptKRmJzc/xmN8cWrUCRtKt42m4V0+wWufM2SIC+CNjZ?=
 =?iso-8859-1?Q?lMKBn5Ar1Tvi5blFUfhg0QopzsaIn38c5Qlly4Gnfzs5TrDav6Z7Gx9hhx?=
 =?iso-8859-1?Q?EnhNPOucxubky4w1cbF8jngGKfYxzXfwJPrDiOhQpHMhk9hbErwFi7BlOB?=
 =?iso-8859-1?Q?ro8vSUnEuxsRK3xshGXPip4q2AZyRAujKDLnHMkEDbloPLsGmJVB0u9gcj?=
 =?iso-8859-1?Q?NNr9NfY0loJLtvlhTyHCmF2B1qE8KM9UXM+0iafbES4+7PxaY8AAQ7mY8K?=
 =?iso-8859-1?Q?+FPfi2YckPZAsCBGKKUhyK8YIjAJeVFdPfbhILHjamhhGfGareq+ok2+PS?=
 =?iso-8859-1?Q?d/YTm9bdRlVw2wt3E94WhLqUTGcd1ERZSK5lntGGuxOAOqyHwItPnZBHus?=
 =?iso-8859-1?Q?TZtuIw8jfJRJYggugUN8a1IDns1YgyxYlKnMHJzRO6ofnzGC1bilYn7CmT?=
 =?iso-8859-1?Q?Fq5vN1+j13OU0NZMAesNmhsMMiKBFglfu906HwONU0btYg01AekfHqrAjU?=
 =?iso-8859-1?Q?ON0eUXc6IFmmqVPGYbHPmGZnmOpZpdFtg12pEX/NDCvBFG7BNHZGnM9gsO?=
 =?iso-8859-1?Q?0glJsH81JkjLq0aObkDlLAR5dwRTxrjeztjUzEXpb4BbyBMDND0FaojHvy?=
 =?iso-8859-1?Q?5cQQzlgdhnBahBgeDypguciXsKE0HqOi/LKL11McxlXdLqEgwvk89iwbcx?=
 =?iso-8859-1?Q?JaqFcw31fUQVXxgZk2k+2elfHdsiOGIi8lZYWqrMBdO4S+5zCi78HNxvX5?=
 =?iso-8859-1?Q?iV2P7UAFQGE+FS0h+hvPoYKjbayHBAlIPeuCYiZyR2DdUzV6YghJ3mDxwB?=
 =?iso-8859-1?Q?uWzaik9UHcAEUeHPKJWH2hQVqFjwwiflWxFcjYUnd+kq+O6BtHq/7GeoEN?=
 =?iso-8859-1?Q?ewGwlJeQPrE6h4yVKW0rBTYHJevr399YG7+bEgR/rj45TNdUEoWM/+8PfG?=
 =?iso-8859-1?Q?y5tfAv5MvcP65qmBxLSSy/c2DIjb9q0f2R4/TFqneQRBlGUDr6WHSLqbkm?=
 =?iso-8859-1?Q?i512nD5qxZNNrJmAhAgFdrj7yHvsSb6MT2YE85nJdVIu8YpBPntypFGEWz?=
 =?iso-8859-1?Q?wqwj9cBeE8fNwyDOqUo+SlYqxnpyOVm6bv9FA1+93h3oOWTNk+kGLsxSI0?=
 =?iso-8859-1?Q?02XkLcPU7ljtt5iVVzOouBdSpIxF0iNLCMuRiIdR4WoCym/uQTZjIDFmOY?=
 =?iso-8859-1?Q?Y1b+fcEOzGS4nTX5VH+OR50Oo/M3FErSJqy9c5JaPmDR6gL4svO4uaseQ/?=
 =?iso-8859-1?Q?DoxFHc7s8fXMURhpZYWg+FohngiKkBGvDxqM8JS1192Ok0nWDH4xQ9Hfgb?=
 =?iso-8859-1?Q?hV8egVlHnQzoSkDpUnWXDnof3g6H3yCkk3XMGcfMuHq4l6sWqOWXXGE4s/?=
 =?iso-8859-1?Q?pYcihwwU8IxsM/dk0gVwb5WCZ7TV6NJoSKYM8Vg1i9EAp8XlboveNmVz+u?=
 =?iso-8859-1?Q?nRT4KyQ6oNSNSxxzJooQrioI3mj08ibJyQ8RjQU5nKyCAFX5nj2+fUb213?=
 =?iso-8859-1?Q?LO5h00Eg6cXU4ZcbZNQhOCy2u59mxQi0/j0Wz8n0WUZ57/9wYRzVgI5GQo?=
 =?iso-8859-1?Q?do7zsObGzhiN4qc1rwgN2eg5pXa11neUOudVmsGLFupbs7vi0iBU9nSeAI?=
 =?iso-8859-1?Q?0PAcEFyZg9hHT5Mj3G96OMwzTBBp9FgM5qFpNRzMc6N8qhmXtM7RcXkv8t?=
 =?iso-8859-1?Q?jiKVMqJICd52xOcHdcUIkDgVXVoSevkuH+e1RcgOtjviXF40WAZ0A8vKQ9?=
 =?iso-8859-1?Q?Khrija+mqUbFJQi4twXiWhmciYdfbNZGIapvt7MxlnbVAp0Cvy/1g2X336?=
 =?iso-8859-1?Q?OCs/4hEH8IzA33Gq1QG5jL/7Yll7rrw9Rqz4vWYcBuXHYo/8ti7O?=
X-Exchange-RoutingPolicyChecked: WKsQ3V2pCUrxvTU1XYlqiT5h1a4NwHHAYiGq2we6x+oBhiN9pYwCJbrOKgM/2QDifdqbwalnr+h7MFjwj/2kh/CusMc0y6UeFF/8+vO0iCZvNIgYypzDbJyuR6rGMwYtZlM431GOly035GXPE7oJVlcT/IgXzFk2iqxTfJ8RBGz2ZoutFZAslLUIv/lY1UPqgfp/TBVbWRQNRWanIoadoOK/qSMJPRXY8XR75bG2gKP1GGkm3+ktB9W2Mxzj1gBvEfUskV1Z9PN2KT/tdM0uoD+MQU7PuFzcYrYOIn4XTmWf+5D6MSSLdf7A1noM04aon88+apZarltAIWTYh16pBQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c21eb5e-5b50-4184-83d3-08df3c8fdde8
X-MS-Exchange-CrossTenant-AuthSource: MW3PR11MB4684.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2026 05:27:51.4896 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ST4e/tT5sjgc3WfRXfo4CrfL0gg6WsTmjHNGWW+0BdVW2L6ucMBU8Hz+erUi2JMhdZP6bC+ov0cwGjck+hMGSL5tPaGENbIai+1PMnjmRBg+9STYGgXEwqeN20AV0/AG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR11MB154527
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

On Fri, Jul 10, 2026 at 07:56:06PM -0700, Matthew Brost wrote:
>BOs whose backing TT pages were allocated below the device's beneficial
>order (tracked via the TTM_TT_FLAG_BENEFICIAL_ORDER_FAILED tt page flag)
>are added to a per-device defrag list. Add a delayed worker that
>periodically walks this list and attempts to re-back each BO with
>beneficial-order pages, improving TLB efficiency for long-lived objects
>that were initially allocated under memory pressure.
>
>The worker is kicked when the list first transitions to non-empty and
>reschedules itself while work remains. On a failed pass it backs off
>exponentially (XE_BO_DEFRAG_INTERVAL_MS up to
>XE_BO_DEFRAG_INTERVAL_MAX_MS) and retries the whole list later; the
>interval is reset to the default on the next fresh enqueue. The worker
>stops scheduling once the list drains.
>
>A defrag move synchronously reallocates and re-copies a BO's backing
>store, which is not free. To avoid stalling concurrent active work when
>many BOs (or one very large BO) become eligible at once (e.g. after a
>burst of memory pressure, which would otherwise manifest as a large FPS
>drop while the worker churns through the whole list), cap the number of
>newly (re)allocated bytes processed per run to XE_BO_DEFRAG_SIZE_LIMIT
>and reschedule. Only the pages a move actually reallocates are charged -
>pages harvested (borrowed) from the old backing are free and do not count
>- so the budget tracks real defrag work and an object larger than the
>budget is upgraded in budget-sized slices across runs. This spreads the
>defrag effort over time, keeping it in the background and yielding to
>userspace progress.
>
>Defragmenting a BO forces a TTM move (ctx.defrag) that reallocates the
>backing at the beneficial order and relocates the contents on the GPU
>(see xe_bo_move()). The per-BO move is bounded by the run's remaining
>byte budget via ctx.defrag_bytes_remaining; the pool allocator reports
>how much it spent so the worker can charge it accurately. When
>beneficial-order pages cannot be obtained the new allocation is
>discharged during populate and the BO keeps its original backing, staying
>on the list for a later retry.
>
>Cc: Carlos Santa <carlos.santa@intel.com>
>Cc: Ryan Neph <ryanneph@google.com>
>Cc: Christian Koenig <christian.koenig@amd.com>
>Cc: Huang Rui <ray.huang@amd.com>
>Cc: Matthew Auld <matthew.auld@intel.com>
>Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
>Cc: Maxime Ripard <mripard@kernel.org>
>Cc: Thomas Zimmermann <tzimmermann@suse.de>
>Cc: David Airlie <airlied@gmail.com>
>Cc: Simona Vetter <simona@ffwll.ch>
>Cc: dri-devel@lists.freedesktop.org
>Cc: linux-kernel@vger.kernel.org
>Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
>Assisted-by: GitHub_Copilot:claude-opus-4.8
>Signed-off-by: Matthew Brost <matthew.brost@intel.com>
>
>---
>
>v3:
> - Compute the needs-more state under the BO lock via an out-param
>   instead of re-reading bo->ttm.ttm after unlock (Sashiko)
>---
> drivers/gpu/drm/xe/xe_bo.c           | 296 ++++++++++++++++++++++++++-
> drivers/gpu/drm/xe/xe_bo.h           |   1 +
> drivers/gpu/drm/xe/xe_device.c       |   9 +
> drivers/gpu/drm/xe/xe_device_types.h |  11 +
> 4 files changed, 313 insertions(+), 4 deletions(-)
>
>diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
>index 7f6ee9b8d12e..907cfa57481f 100644
>--- a/drivers/gpu/drm/xe/xe_bo.c
>+++ b/drivers/gpu/drm/xe/xe_bo.c
>@@ -31,6 +31,7 @@
> #include "xe_pat.h"
> #include "xe_pm.h"
> #include "xe_preempt_fence.h"
>+#include "xe_printk.h"
> #include "xe_pxp.h"
> #include "xe_res_cursor.h"
> #include "xe_shrinker.h"
>@@ -49,6 +50,35 @@
>  */
> #define XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD	2
>
>+/*
>+ * Maximum number of bytes of newly (re)allocated backing the defrag worker will
>+ * produce in a single run before yielding and rescheduling itself.
>+ *
>+ * A defrag move synchronously reallocates and re-copies a BO's backing store,
>+ * which is not free. If a large number of BOs (or one very large BO) become
>+ * eligible at once (e.g. after a burst of memory pressure), processing them all
>+ * in one worker run would hold things up for a long, unbounded stretch and can
>+ * visibly starve concurrent active work (e.g. a large FPS drop). Instead, cap
>+ * the bytes actually upgraded per run and requeue, spreading the defrag effort
>+ * out over time so it stays in the background and yields to userspace progress.
>+ * Only pages a move truly reallocates are charged; pages harvested from the old
>+ * backing are free, so an object larger than the budget is upgraded in
>+ * budget-sized slices across runs.
>+ */
>+#define XE_BO_DEFRAG_SIZE_LIMIT			SZ_32M
>+
>+/* Default delay before (re)running the defrag worker, in milliseconds. */
>+#define XE_BO_DEFRAG_INTERVAL_MS		25
>+
>+/*
>+ * Upper bound for the (exponentially backed off) defrag worker interval, in
>+ * milliseconds, so repeated failures don't push the retry arbitrarily far out.
>+ */
>+#define XE_BO_DEFRAG_INTERVAL_MAX_MS		15000	/* 15 seconds */
>+
>+static void xe_bo_defrag_worker(struct work_struct *w);
>+static void xe_place_from_ttm_type(u32 mem_type, struct ttm_place *place);
>+
> const char *const xe_mem_type_to_name[TTM_NUM_MEM_TYPES]  = {
> 	[XE_PL_SYSTEM] = "system",
> 	[XE_PL_TT] = "gtt",
>@@ -624,8 +654,10 @@ static int xe_ttm_tt_populate(struct ttm_device *ttm_dev, struct ttm_tt *tt,
> 	} else {
> 		struct xe_device *xe = ttm_to_xe_device(ttm_dev);
>
>-		if (atomic_read(&xe->mem.defrag.count) >=
>-		    XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
>+		if (ctx->defrag)
>+			ctx->beneficial_reclaim_backoff = false;
>+		else if (atomic_read(&xe->mem.defrag.count) >=
>+			 XE_BO_DEFRAG_RECLAIM_BACKOFF_THRESHOLD)
> 			ctx->beneficial_reclaim_backoff = true;
>
> 		ttm_tt_clear_backed_up(tt);
>@@ -1047,18 +1079,54 @@ static int xe_ttm_bo_purge(struct ttm_buffer_object *ttm_bo, struct ttm_operatio
> 	return 0;
> }
>
>+static void xe_bo_defrag_fini(void *arg)
>+{
>+	struct xe_device *xe = arg;
>+
>+	disable_delayed_work_sync(&xe->mem.defrag.worker);
>+}
>+
> /**
>  * xe_bo_defrag_init_early() - Initialize the device defrag BO tracking
>  * @xe: The xe device
>  *
>- * Initialize the list, lock and count used to track BOs whose backing TT
>- * pages were allocated at a sub-optimal order.
>+ * Initialize the list, lock, count and delayed worker used to track and
>+ * defragment BOs whose backing TT pages were allocated at a sub-optimal order.
>+ *
>+ * The devm action that cancels the worker on teardown is registered separately
>+ * by xe_bo_defrag_init(), which must run after the migrate contexts the
>+ * worker depends on have been initialized.
>  */
> void xe_bo_defrag_init_early(struct xe_device *xe)
> {
> 	spin_lock_init(&xe->mem.defrag.lock);
> 	INIT_LIST_HEAD(&xe->mem.defrag.list);
> 	atomic_set(&xe->mem.defrag.count, 0);
>+	xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
>+	INIT_DELAYED_WORK(&xe->mem.defrag.worker, xe_bo_defrag_worker);
>+}
>+
>+/**
>+ * xe_bo_defrag_init() - Register defrag worker teardown
>+ * @xe: The xe device
>+ *
>+ * Register the devm action that disables and drains the defrag worker on
>+ * device teardown. This must be called after xe_migrate_init() so that, with
>+ * devm's reverse-order cleanup, the worker is stopped before the migrate
>+ * contexts it relies on (via xe_bo_defrag_one() -> ttm_bo_validate() ->
>+ * xe_bo_move() -> xe_migrate_copy_defrag()) are torn down.
>+ *
>+ * Return: 0 on success, negative error code on failure.
>+ */
>+int xe_bo_defrag_init(struct xe_device *xe)
>+{
>+	return devm_add_action_or_reset(xe->drm.dev, xe_bo_defrag_fini, xe);
>+}
>+
>+static void xe_bo_defrag_schedule(struct xe_device *xe)
>+{
>+	schedule_delayed_work(&xe->mem.defrag.worker,
>+			      msecs_to_jiffies(xe->mem.defrag.interval_ms));
> }
>
> static bool xe_bo_needs_defrag(struct xe_bo *bo)
>@@ -1079,16 +1147,24 @@ static bool xe_bo_needs_defrag(struct xe_bo *bo)
> static void xe_bo_defrag_add(struct xe_bo *bo)
> {
> 	struct xe_device *xe = xe_bo_device(bo);
>+	bool kick = false;
>
> 	xe_bo_assert_held(bo);
> 	xe_assert(xe, xe_bo_needs_defrag(bo));
>
> 	scoped_guard(spinlock, &xe->mem.defrag.lock) {
> 		if (list_empty(&bo->defrag_link)) {
>+			/* Kick the worker when the list transitions to non-empty. */
>+			kick = list_empty(&xe->mem.defrag.list);
>+			if (kick)
>+				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
> 			list_add_tail(&bo->defrag_link, &xe->mem.defrag.list);
> 			atomic_inc(&xe->mem.defrag.count);
> 		}
> 	}
>+
>+	if (kick)
>+		xe_bo_defrag_schedule(xe);
> }
>
> static void __xe_bo_defrag_remove(struct xe_bo *bo)
>@@ -1131,6 +1207,218 @@ static void xe_bo_defrag_update(struct xe_bo *bo)
> 		xe_bo_defrag_remove(bo);
> }
>
>+/*
>+ * Attempt to defragment a single BO by forcing a move that reallocates its
>+ * backing at the device's beneficial order. @budget bounds how many bytes of
>+ * new pages the move may (re)allocate; the remainder of the object is completed
>+ * by harvesting the old backing, and the BO stays flagged for a later pass. On
>+ * return *@consumed holds the bytes actually (re)allocated (0 on failure or
>+ * when nothing needed reallocating). *@needs_more is set to true when the move
>+ * succeeded but the BO still has sub-beneficial backing (partial upgrade) and
>+ * should be revisited; it is computed under the BO lock so the caller does not
>+ * need to re-inspect bo->ttm.ttm after the lock is dropped. Returns 0 if the BO
>+ * no longer needs to be tracked (either defragmented or no longer eligible), or
>+ * a negative error code if the attempt should be retried later.
>+ */
>+static int xe_bo_defrag_one(struct xe_device *xe, struct xe_bo *bo,
>+			    u64 budget, u64 *consumed, bool *needs_more)
>+{
>+	struct ttm_operation_ctx ctx = {
>+		.gfp_retry_mayfail = true,
>+		.defrag = true,
>+		.defrag_bytes_remaining = budget,
>+	};
>+	struct ttm_buffer_object *ttm_bo = &bo->ttm;
>+	struct ttm_placement placement;
>+	struct ttm_place place;
>+	int ret = 0;
>+
>+	*consumed = 0;
>+	*needs_more = false;
>+
>+	xe_bo_lock(bo, false);

Assisted-by: LLM

Instead of waiting for the lock here, would it be worth trylocking it
and upon failure move to next bo?

>+
>+	/* Re-check eligibility under the BO lock. */
>+	if (!xe_bo_needs_defrag(bo)) {
>+		xe_bo_defrag_remove(bo);
>+		goto unlock;
>+	}
>+
>+	xe_place_from_ttm_type(ttm_bo->resource->mem_type, &place);
>+	place.flags |= TTM_PL_FLAG_TEMPORARY;
>+	placement.num_placement = 1;
>+	placement.placement = &place;
>+
>+	/*
>+	 * On success the move reallocates the backing at beneficial order and
>+	 * drops the BO from the defrag list. On failure the BO keeps its
>+	 * original backing and stays on the list for a later retry.
>+	 */
>+	ret = ttm_bo_validate(ttm_bo, &placement, &ctx);
>+
>+	/*
>+	 * The pool allocator decremented defrag_bytes_remaining as it
>+	 * (re)allocated pages, so the unused budget tells us how much was spent.
>+	 * Only meaningful when the move succeeded. A successful move may spend
>+	 * nothing - e.g. when the object was already fully upgraded and every
>+	 * chunk is harvested (borrowed) from the old backing for free - so a
>+	 * zero spend is legitimate and must be charged as zero, not the whole
>+	 * budget.
>+	 */
>+	if (!ret) {
>+		s64 spent = (s64)budget - ctx.defrag_bytes_remaining;
>+
>+		*consumed = spent > 0 ? spent : 0;
>+	}
>+
>+	xe_dbg(xe, "Defrag attempt on BO size=%zu: ret=%pe consumed=%llu\n",
>+	       xe_bo_size(bo), ERR_PTR(ret), *consumed);
>+
>+	if (!ret && ttm_tt_is_beneficial_order_failed(bo->ttm.ttm))
>+		*needs_more = true;
>+
>+unlock:
>+	xe_bo_unlock(bo);
>+	return ret;
>+}
>+
>+static void xe_bo_defrag_worker(struct work_struct *w)
>+{
>+	struct delayed_work *dwork = to_delayed_work(w);
>+	struct xe_device *xe =
>+		container_of(dwork, struct xe_device, mem.defrag.worker);
>+	u64 defrag_bytes = 0;
>+	bool requeue = false;
>+	int idx;
>+
>+	if (!drm_dev_enter(&xe->drm, &idx))
>+		return;
>+
>+	if (!xe_pm_runtime_get_if_in_use(xe)) {
>+		/*
>+		 * The device is (runtime) suspending/suspended. Reschedule so
>+		 * the pass retries once it is active again: the enqueue-time
>+		 * kick in xe_bo_defrag_add() only fires on an empty->non-empty
>+		 * transition, so it will not re-arm the worker while the list
>+		 * is still non-empty. Requeue here to avoid stranding tracked
>+		 * BOs. The get attempt does not resume the device, so this is
>+		 * just a lightweight CPU-side timer while suspended.
>+		 */
>+		if (atomic_read(&xe->mem.defrag.count))
>+			xe_bo_defrag_schedule(xe);

Instead of keep retrying with backoff during suspend, would be good to launch
this worker from the resume handler?

>+		drm_dev_exit(idx);
>+		return;
>+	}
>+
>+	/*
>+	 * Process at most XE_BO_DEFRAG_SIZE_LIMIT bytes of newly (re)allocated
>+	 * backing per run rather than draining the whole list in one go. Only
>+	 * the pages a move actually reallocates are charged - pages harvested
>+	 * (borrowed) from the old backing are free and do not count - so the
>+	 * budget tracks real defrag work. A single object larger than the
>+	 * budget is upgraded in slices across successive runs. Each defrag is
>+	 * synchronous and relatively expensive, so bounding the work per run
>+	 * keeps the worker from monopolising resources and lets concurrent
>+	 * active work make progress; any remaining work is handled by a
>+	 * follow-up run scheduled below.
>+	 */
>+	while (defrag_bytes < XE_BO_DEFRAG_SIZE_LIMIT) {
>+		struct xe_bo *first, *bo;
>+		u64 consumed = 0;
>+		bool needs_more = false;
>+		int ret;
>+
>+		scoped_guard(spinlock, &xe->mem.defrag.lock) {
>+			bool again;
>+
>+			/* Progress, reset interval */
>+			if (defrag_bytes)
>+				xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
>+
>+			do {
>+				first = list_first_entry_or_null(&xe->mem.defrag.list,
>+								 struct xe_bo,
>+								 defrag_link);
>+				bo = first ? xe_bo_get_unless_zero(first) : NULL;
>+				again = first && !bo;
>+				if (again) {
>+					list_del_init(&first->defrag_link);
>+					atomic_dec(&xe->mem.defrag.count);
>+				}
>+			} while (again);
>+		}
>+
>+		if (!bo)
>+			break;
>+
>+		/*
>+		 * Bound the per-BO move to the run's remaining byte budget. A
>+		 * large object is upgraded in budget-sized slices across runs;
>+		 * the slices already upgraded come back as free already-
>+		 * beneficial harvests, so each run only spends budget on new
>+		 * forward progress.
>+		 */
>+		ret = xe_bo_defrag_one(xe, bo, XE_BO_DEFRAG_SIZE_LIMIT - defrag_bytes,
>+				       &consumed, &needs_more);
>+		defrag_bytes += consumed;
>+
>+		if (ret || needs_more) {
>+			scoped_guard(spinlock, &xe->mem.defrag.lock) {
>+				if (ret)
>+					/*
>+					 * Abort the pass and retry the whole
>+					 * list later, backing off exponentially
>+					 * on every failure.
>+					 */
>+					xe->mem.defrag.interval_ms =
>+						min(xe->mem.defrag.interval_ms * 2,
>+						    (unsigned int)XE_BO_DEFRAG_INTERVAL_MAX_MS);
>+				else
>+					/* Progress, reset interval */
>+					xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
>+			}
>+

If xe_bo_defrag_one() returns error, code does backoff and retry but with the same BO
at the head of the list which can fail again (more so if that BO is a large BO).
Not sure if that is fine or we should move the failing bo in the list.

Also, if the BO is large and returns needs_more, code backsoff and retries until that
large BO is gets beneficial order. Would it be better instead to move on to other BOs
without the backoff?

>+			xe_bo_put(bo);
>+			requeue = true;
>+			break;
>+		}
>+
>+		xe_bo_put(bo);
>+	}
>+
>+	/*
>+	 * Decide whether to reschedule:
>+	 *
>+	 *  - The loop hit its per-run limit (defrag_bytes >=
>+	 *    XE_BO_DEFRAG_SIZE_LIMIT): we stopped early to spread the work out,
>+	 *    so requeue at the default interval (reset here since this run made
>+	 *    progress) whenever the list still has entries.
>+	 *
>+	 *  - The loop aborted on a failed defrag (requeue): retry later at the
>+	 *    backed-off interval computed above.
>+	 *
>+	 *  - The loop drained the list (broke on the empty list): nothing left to
>+	 *    do, so stop scheduling. A fresh enqueue will kick the worker again.
>+	 */
>+	if (defrag_bytes >= XE_BO_DEFRAG_SIZE_LIMIT) {
>+		struct xe_bo *bo;
>+
>+		scoped_guard(spinlock, &xe->mem.defrag.lock) {
>+			bo = list_first_entry_or_null(&xe->mem.defrag.list,
>+						      struct xe_bo, defrag_link);
>+			xe->mem.defrag.interval_ms = XE_BO_DEFRAG_INTERVAL_MS;
>+		}
>+
>+		if (bo)
>+			xe_bo_defrag_schedule(xe);
>+	} else if (requeue) {
>+		xe_bo_defrag_schedule(xe);
>+	}
>+
>+	xe_pm_runtime_put(xe);
>+	drm_dev_exit(idx);
>+}
>+
> static int xe_bo_move(struct ttm_buffer_object *ttm_bo, bool evict,
> 		      struct ttm_operation_ctx *ctx,
> 		      struct ttm_resource *new_mem,
>diff --git a/drivers/gpu/drm/xe/xe_bo.h b/drivers/gpu/drm/xe/xe_bo.h
>index 32211016a722..38d50f8122cb 100644
>--- a/drivers/gpu/drm/xe/xe_bo.h
>+++ b/drivers/gpu/drm/xe/xe_bo.h
>@@ -226,6 +226,7 @@ int xe_bo_pin(struct xe_bo *bo, struct drm_exec *exec);
> void xe_bo_unpin_external(struct xe_bo *bo);
> void xe_bo_unpin(struct xe_bo *bo);
> void xe_bo_defrag_init_early(struct xe_device *xe);
>+int xe_bo_defrag_init(struct xe_device *xe);
> int xe_bo_validate(struct xe_bo *bo, struct xe_vm *vm, bool allow_res_evict,
> 		   struct drm_exec *exec);
>
>diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
>index bb93425a5c70..19d38e14c910 100644
>--- a/drivers/gpu/drm/xe/xe_device.c
>+++ b/drivers/gpu/drm/xe/xe_device.c
>@@ -1069,6 +1069,15 @@ int xe_device_probe(struct xe_device *xe)
> 			return err;
> 	}
>
>+	/*
>+	 * Register the defrag worker teardown now that the migrate contexts it
>+	 * depends on are initialized, so devm's reverse-order cleanup stops the
>+	 * worker before those contexts are torn down.
>+	 */
>+	err = xe_bo_defrag_init(xe);
>+	if (err)
>+		return err;
>+

There is a sashiko reported bug here regarding probe failing earlier than this
teardown registration causing teardown not waiting for worker to finish. Not
sure if there will be any defrag list at that time, but probably work a fix
for completeness?

Niranjana

> 	err = xe_pagefault_init(xe);
> 	if (err)
> 		return err;
>diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
>index 9e6244d8f41b..6e68add4d652 100644
>--- a/drivers/gpu/drm/xe/xe_device_types.h
>+++ b/drivers/gpu/drm/xe/xe_device_types.h
>@@ -314,6 +314,17 @@ struct xe_device {
> 			 * @mem.defrag.list.
> 			 */
> 			atomic_t count;
>+			/**
>+			 * @mem.defrag.worker: Delayed worker that walks
>+			 * @mem.defrag.list trying to reallocate BO backing
>+			 * store at the device's beneficial order.
>+			 */
>+			struct delayed_work worker;
>+			/**
>+			 * @mem.defrag.interval_ms: Reschedule interval for
>+			 * @mem.defrag.worker, in milliseconds.
>+			 */
>+			unsigned int interval_ms;
> 		} defrag;
> 	} mem;
>
>-- 
>2.34.1
>
