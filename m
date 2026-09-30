Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED2B6CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 18:32:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4316610E1F6;
	Wed, 30 Sep 2026 18:32:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="DB4bxOyw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FD4910E1F6;
 Wed, 30 Sep 2026 18:32:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790793160; x=1822329160;
 h=message-id:date:subject:to:cc:references:from:
 in-reply-to:content-transfer-encoding:mime-version;
 bh=X5n0y6oK7FYnuWVoR23SkG3XpD51/e6e5HDzXJ6hkKo=;
 b=DB4bxOywF7+MhipdF1K4zSeZ9RYzQxz9oPWLMXj6UlKJJEFbnkTLMlNt
 cobXJZxJrXocSGThvu8DgZw7Nwj/KhL3KBQNHbpeQNzSJcbTx+Q5d00Zh
 hs0qsUjLKeyluRS3EzbYhAXrjMCBfBOgO7PSi6wseHcj/dsLKSksa/8Mt
 bYJdKGWXa87ECDNHmRs5TU7Y4q7A/pnialSSR1U1RHDFg/jT0dhe8/uZM
 aY4GH5LB7xF4K+lJk3ZSboeItdtnkokG3fiURsTV3DuaFtsni3ETKHZz+
 7xSOBxlD/TH71mbPls8gnUDQLFCpyY8LPx8XNkBRDu7yYnyzQPsmKsyyJ g==;
X-CSE-ConnectionGUID: ebO3RGhIRuG9D7y/18b44A==
X-CSE-MsgGUID: qz7MVe08SIiER2OGlRJleA==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="101703098"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; d="scan'208";a="101703098"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 11:32:39 -0700
X-CSE-ConnectionGUID: fP4b9OerQtqe6Z2b3mgUhA==
X-CSE-MsgGUID: DhfEgA+RSdSyfpsSxWxGRA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; d="scan'208";a="275891958"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 11:32:39 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 11:32:38 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 11:32:38 -0700
Received: from PH8PR06CU001.outbound.protection.outlook.com (40.107.209.70) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 11:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ypbH/mc3wJue91U705tpfi4jVHOD9dvQI5cvCAkdsUE5ZGVfqfowq/EH0LtMvQ4DMSpWqRt6YVxx3xJ7ykPN++b0qUDmZ+ztysrDgh5WreSBVYdHmpI2VcWZ9eQDrKbSqOsC6rsc0hRzU8GHkVbGdoAEXsDXbc1HIry3gACpvpbY2n3Ew9vKlMNEMw9PQAWSz8RtfT1bnBl5Ne0uNO/+8qvZtCScyatDyaajhTKIAtZCyibXVKc+aJSax5RPGvjSCAS5RSblbMujEElmujnkWT9Qjut+8tZKCGm2IRpXdWqAVkiFuUwjDRY/m975o3GcLfr57s9aLTeOoShABL5E3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0RQGTu6c2OtXdw6kqU64NQVjRsewibSTU02G76gLyUs=;
 b=GWQZzXsHtW9XQ0jxQquUYv/Su3q3o86m9+6vOhZ+jo5/QsJm1/U5/7NV547R8C+5/M74EhMBE1MMhKv1fviu2R6laSEoRgCLfBcwukKlyhakTyDzNXc9NZs4efosK6cCnw4egWTQ7KmycO9COQ40SceA64WWzNcdQMIn0Fj2U6Qgc9SELFFSigCngwlAcLCxzgsKfgB+HLQNgq069K41I9TcXg9ZonFS/GFI9mYmmZCIwAHqgxskZjlYfng1pqwyio67pSNzzBVjtq0jkNhbGikc9laA7nZQRxjpGz7+HIWKe6lK6f3a96x0LMRE26C76Bz1Rq8PRExGjC2ti/fLvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8040.namprd11.prod.outlook.com (2603:10b6:510:238::11)
 by IA4PR11MB9204.namprd11.prod.outlook.com (2603:10b6:208:56d::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 30 Sep
 2026 18:32:34 +0000
Received: from PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5]) by PH8PR11MB8040.namprd11.prod.outlook.com
 ([fe80::89bf:2274:1371:50c5%5]) with mapi id 15.21.0451.022; Wed, 30 Sep 2026
 18:32:32 +0000
Message-ID: <91673528-75c0-4e2d-bec8-d6eaf58c5d2c@intel.com>
Date: Wed, 30 Sep 2026 11:32:31 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12] drm/i915/dg2: Add per-client control for
 Wa_22013059131
To: <sashiko-reviews@lists.linux.dev>
CC: <intel-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
References: <20260630223946.2107382-1-jia.yao@intel.com>
 <20260930171334.3636-1-jia.yao@intel.com>
 <20260930172544.3A1E71F000FF@smtp.kernel.org>
Content-Language: en-US
From: "Yao, Jia" <jia.yao@intel.com>
In-Reply-To: <20260930172544.3A1E71F000FF@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0171.namprd13.prod.outlook.com
 (2603:10b6:a03:2c7::26) To PH8PR11MB8040.namprd11.prod.outlook.com
 (2603:10b6:510:238::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8040:EE_|IA4PR11MB9204:EE_
X-MS-Office365-Filtering-Correlation-Id: 29346d60-69dc-4c53-2988-08df1f2130c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|42112799006|11063799006|56012099006|10067099003|4143699003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Ru8ei67hSmorhc4uvdVNTMBeLMuBhYn9SpgW7T/shfEcAae+B0ntjHeLXA8N7hSsublqMKR1hYyxnznUhDQRGHpFLg3WKgoq9v1DokAIKpbzKIU9XxtRZ3lcXSzFV576yk+c+OdnD7E+GNdp/C5ncD/kfr8XRbLgWQHcAopUq1LYwQzCdEBDtSZywErGqOnUdPARWnwdEjZvu96iyNWwr8lJsIhLvEuriSs6SQlPNIicaGKw/udRrVn3cqN86P9ZlbXt+SBpY2LyM+nW+23rm06tybwO5Q580y5am76BV8RYZTgnC4FB5VD3mGuPsg9dWsbyoVI5jkMmuOSbBTRf5GDwW3epB/OR1RQpdokSJlK0NxFUIRvuB6FMtkNxlfVJFDQESOpXGE+o9kOmxa+1iX+ZGbFgxIT65anq7cqqQ01ZpFi1kHUOhK7Gte0aoJFr27WT+OGKoZuNOaKMMW/50NPHZzSmqElFue6aiE9tU/b8ZkH34Px3DqhUwkT4QZXfdfqzXNQ646cEw2yqSGjGc9qAY2TqP/T8hGuayKchd5JpXbtEAzmoehtbLl0iiLm6s6ixk/s8xTmb6abO0rmrSHGqGHXg+fr3NPWnaFKnv0VAc3mgR64tMnAUh+xpf7hHRS26IOyz4kGnMeTFNoU6Jx7lova9E8Bnhb7b7AfdJxk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB8040.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(42112799006)(11063799006)(56012099006)(10067099003)(4143699003)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UjQ2Kzc3SmdLcklSaWVGN3k3ZmJJdU0xSUhRemN5YVJra1psbnBVVkxwL0Ni?=
 =?utf-8?B?Mmw0WW5hZktLUW4xKzNsaUw2QWt0c2hTT2ZBWUhtWFBBNDhRRGlEc2I4Vzh3?=
 =?utf-8?B?NGQxZ2ZwbEh4WW4zV2g2OE9vSHBKSEp5M2pxRUlYbnFORXdSSTVmL0E1blN2?=
 =?utf-8?B?eXVxTkNEL254KzRneGl4Wm5kcTdLUEJ1c2NLQ0svNGRMelNZQ2dIZjgwbFpx?=
 =?utf-8?B?ckh2UWdQSWtPaTZ5U1RGZ21XdDRGdkphcjNyRS9wVXBBUDdlWEQ3c0NNYzlr?=
 =?utf-8?B?QTF0R1h6S3pFa3pKaXN3c1VZR01jNTNNWUJvTm5PdWlyWC9uNkV1UW9pRXpr?=
 =?utf-8?B?cEZSWXBNQlRoTnM5M1NxYnZDYXloVkxpOEFCUkUxcWIxaWpWVTMrT1FpT3F1?=
 =?utf-8?B?aHZWbDBDY2twdWt6aDZYa3o3R0lOUUhSWGhZdTVCc1JWZ2hBNlp1Q0pDeGZM?=
 =?utf-8?B?c3VtWWJpSkptc1JqbHl2QmhLYldtdlQ4U2YrOGdSeFhsVExtNTY3YkYxZXMw?=
 =?utf-8?B?MlRXSDNWc3YxeGE2dEdkZ2c0Y1Vkb3lXZ3h2azM5ZzlYZCszVVk2UllVQ0Nq?=
 =?utf-8?B?cDAzcStMakFWOUtUR1JtTzRKVTlmL0RhWnZnWFhHelVROTNkZlk4OCt1NDZu?=
 =?utf-8?B?VjFGYXQyNnpTckxQUXNzckJDQTN3aHEwRW9CVSt3ci9EK3Bza1lxWUNZem83?=
 =?utf-8?B?N0pjTHJ5TFJFMSs3bW5HNG4vNzZQNDNObFdWQ0JJN2xONGlMVXhmRHp3YjdO?=
 =?utf-8?B?TDNOU256cmV2QjRkN0wvVFpzc0VreUlQRFhnbHZHVkxtdFBDV0tINHdRYmIy?=
 =?utf-8?B?U1N4ajExcXNJcTR0K1ZPVkxpM1AyWGNXRm9BM3N0ZGsvU3VtQU9sL1VvZ0lY?=
 =?utf-8?B?eTU2UURoemNhOHlaZWNIVzFMelo2ZTBlTjhFendoUHZmQjFRK2pZdXZRYmVi?=
 =?utf-8?B?M1dhcDVxcXllT3pENmtCUlY5T3gvaHNWVzFrdlh4dFdTL0g2VmxINnFEYk9G?=
 =?utf-8?B?Nks1YkZQYWdDRFQ5K3orRGdFcTZvRHJMT3AwcFZLdjZ2R0JxVjFMTG9ORito?=
 =?utf-8?B?dnZzMk1yc04wcWNDVm1JUGoxOXZWeHVRYkMxUUZTVHNOSEgzcDdtbTFUaGsv?=
 =?utf-8?B?a2h5UjM0RGt0Sko1dURwQlVXanpBbFVGQlJDbjBNb2lMWElpWXYrMzdIWmNj?=
 =?utf-8?B?MDZNMzJFeWdmb1FsZ1NPc3RSK0Npd0NVS3dWdDVjNXlEaEJYSjEra3prNUhQ?=
 =?utf-8?B?UFZnUGg4amg3aXBmQkdXK0Fua3NnVUkxOUM5UEpnTXFsazQ3c0JVcWhqd0Jy?=
 =?utf-8?B?SndSMkg0WkRQZUJ2V0k2d0Z4Y1YvQlFuYXZlSE1LKzR4ZXNOaENFd1hvOGZK?=
 =?utf-8?B?SFdCY1ZpclcwajlPM2g1bGZORGh0NWtBL3lycmJkc3dtVmJMTUpsN2dWZTM3?=
 =?utf-8?B?eFVDaldwMDc5NU1IUExVejlFQ0JXYVQ1RVZCYjdPVklDdER4bW9JUWl3V0sx?=
 =?utf-8?B?RHVrVFQ4SC94cHlJWDRZb2dKdlBOcnVBT1R4bjQxWHdSdWxCOUhyTkNHUVZ6?=
 =?utf-8?B?RWRwb0J3VmxFNlRLZDVNSS9iRzNtVTlFcUZzS3JKcXpOMW1kK1p3M1JVNmo0?=
 =?utf-8?B?NG53R1M5bll0SXo1RkpZL21RdXdYN0xFOTRGcVJVRVg0U1VFa0tvYVZNZW5U?=
 =?utf-8?B?UEVNc3BsTS9FcThodWhzTlJMNHkwSnlsZWhkbytMVUVRelJQTGJrYjI5Mi9O?=
 =?utf-8?B?dzQ5SkE5dWVZcHIxK25ieEY3SUMwdHJJeVdjTTRqcWlQYmZzcFNrVTI5dHlv?=
 =?utf-8?B?STRJbEVKQmhGVlh1UnpTRTZFdEU1NzZ2RHdpZ0pEVXFYTjdnNHdjNmdXekJz?=
 =?utf-8?B?VHJobFJva2hHT3k5emxneDJzdm1QcWp2NXZPTVF2amlWTzY5dC9TM2JXbXRy?=
 =?utf-8?B?OSs5UjlMY1hIQVFPdXlteGpLTWJVNEhmcHh6aU91MUozeW5SUFFhZVBBY09r?=
 =?utf-8?B?MVVGV1dDbldTS0NVdlYrcDA2QjZOelpWelN3UWoyM0JLSzg5amM4SlZrVWVr?=
 =?utf-8?B?Y3RmT09mZnNBSnJZTE1kcjFWTUpScmxjdVFpR0FhTTZZYXliM2tNWlpia2pT?=
 =?utf-8?B?SjRhakxPMFZISWYwMFE1Y0daTnpZNjNaRnE3bktmWmdSVzhmdnZ0d2s2cFl1?=
 =?utf-8?B?MWVwZGdXVFNaSXBxQktwMWlza2NLYW5mVGpnOExGWWlQL05nV0ZxMUlpMDBL?=
 =?utf-8?B?bExkWmxLMXBtZENzMHNsSjMwbmRBck1tMDljcHRxamR6RG05Sk1IaTA4d0x6?=
 =?utf-8?B?MGl2VG1CQmdEbVZwamoyME5SeHVmeHBJOEZTSFFVbHpFRzlOVXdGQT09?=
X-Exchange-RoutingPolicyChecked: ECrQpBjc4IzrBy+81ZjmqKSolSrZNkq+XM28wxfpdE/a+H4qGMhgRt9Dst0tOnhZdNh24BrPI1HtX6LPPplkEKkmbkGvuwdAdXRe7nXth/ml61IkoTOB1H1FpmAZe8TF+dpb/BqzOH9toE7y0gSf7e+zzJcwguonzi1OdBhL8eQ2HSZZtoHLct3bb3jqyb02M+ZRNBe18L6WsSRFSveH/KkXQ7QD3eHbJmlzUxiju01dA78mVNiCtWcxLKG/19UKLzcBhiCXj2wgP8LGSdh6qoULT1Ex3HEis0e5xDRYb92hMktcCI3nYQsex1WnpnRT/P3AXC+4XdBtFZvgqv4xmQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 29346d60-69dc-4c53-2988-08df1f2130c6
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8040.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 18:32:32.4685 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sDyKVHOlEmEk8YCWsdDo7tFRTq9mOp1gmQ2EiAYQZzZNd4Wr0y5DaCGMUlpIPjXq6bHQP5y/hbxAlkL785kJsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR11MB9204
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


On 9/30/2026 10:25 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Medium] drm/i915/dg2: kernel contexts clear Wa_22013059131 in LSC_CHICKEN_BIT_0
> --
>
> commit 4fe69a30e73450cf67244b9e1360470b774fd0a5
> Author: Jia Yao <jia.yao@intel.com>
>
> drm/i915/dg2: Add per-client control for Wa_22013059131
>
> Wa_22013059131 sets FORCE_1_SUB_MESSAGE_PER_FRAGMENT in LSC_CHICKEN_BIT_0
> at engine init, but this is known to cause GPU hangs in certain workloads.
> Add I915_CONTEXT_PARAM_WA_22013059131 so userspace that handles the
> workaround itself (e.g. by limiting SLM size) can set it to 1 to let the
> kernel know bit 15 programming is not needed.
>
> Link: https://github.com/intel/compute-runtime/pull/919
>
>> diff --git a/drivers/gpu/drm/i915/gt/intel_context.c b/drivers/gpu/drm/i915/gt/intel_context.c
>> --- a/drivers/gpu/drm/i915/gt/intel_context.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_context.c
>> @@ -80,6 +81,7 @@ int intel_context_alloc_state(struct intel_context *ce)
>>   			if (ctx->client)
>>   				i915_drm_client_add_context_objects(ctx->client,
>>   								    ce);
>> +			lrc_latch_wa_22013059131(ce, ctx);
> [Severity: Medium]
> Since lrc_latch_wa_22013059131() in intel_context_alloc_state() is only called
> when ctx is not NULL, what happens for kernel-internal contexts where
> ce->gem_context is NULL?
>
> If the latch function is skipped, CONTEXT_WA_22013059131_APPLY remains unset
> (0). Does this mean the kernel context will execute with the
> FORCE_1_SUB_MESSAGE_PER_FRAGMENT workaround disabled?
Yes, we intended to do that, kernel context don't need the register.
>
>>   			i915_gem_context_put(ctx);
>>   		}
>>   	}
>> diff --git a/drivers/gpu/drm/i915/gt/intel_lrc.c b/drivers/gpu/drm/i915/gt/intel_lrc.c
>> --- a/drivers/gpu/drm/i915/gt/intel_lrc.c
>> +++ b/drivers/gpu/drm/i915/gt/intel_lrc.c
> [ ... ]
>
>> +static u32 *
>> +dg2_g11_emit_wa_22013059131(const struct intel_context *ce, u32 *cs)
>> +{
>> +	/*
>> +	 * While re-writing LSC_CHICKEN_BIT_0 for Wa_22013059131, the
>> +	 * other bits of the register will also get overwritten.  The
>> +	 * hardware default for all other bits is 0, but any workarounds
>> +	 * that adjust the other bits in the lower dword of the register
>> +	 * also need to be re-applied here.  At the moment that's just
>> +	 * Wa_22014226127, which is always set for DG2-G11 platforms.
>> +	 */
>> +	u32 val = DISABLE_D8_D16_COASLESCE;
>> +
>> +	if (test_bit(CONTEXT_WA_22013059131_APPLY, &ce->flags))
>> +		val |= FORCE_1_SUB_MESSAGE_PER_FRAGMENT;
>> +
>> +	*cs++ = MI_LOAD_REGISTER_IMM(1);
>> +	*cs++ = i915_mmio_reg_offset(LSC_CHICKEN_BIT_0);
>> +	*cs++ = val;
> [Severity: Medium]
> If CONTEXT_WA_22013059131_APPLY is unset for kernel contexts, this will
> unconditionally emit a write that clears FORCE_1_SUB_MESSAGE_PER_FRAGMENT
> in the hardware register.
>
> The commit message indicates that "Kernel-internal context will not change
> workaround settings", but it appears this code clears the workaround during
> kernel context execution. Could this expose the kernel context to the GPU
> hangs the workaround is meant to prevent?
No. GuC prevents this scenario from occurring, so kernel contexts are 
not exposed to the hangs that this workaround is designed to avoid.
>
>> +
>> +	return cs;
>> +}
