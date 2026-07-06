Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40B1AC43458
	for <dri-devel@archiver.kernel.org>; Mon,  6 Jul 2026 22:54:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71F2710E413;
	Mon,  6 Jul 2026 22:54:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="NwKgTdAZ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 89B5C10E413
 for <dri-devel@lists.freedesktop.org>; Mon,  6 Jul 2026 22:54:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783378492; x=1814914492;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=h1+CqMM+BHBHPxLEgooFcrVo+BvqEvF8tdS71jRUFgY=;
 b=NwKgTdAZUbKa5VYLm/FabzI0Sl//wphq3in+Znm40tnTx/cgEK+K5Hrn
 9MW0G4eW9Ls9mYqHle1hl/6fT6CfKlUjVkRv+0ZwL5t/V4U2UiyX+V9pR
 agbYoNbYtuQR3oMt5SXkN2YkkJ7b6Zkyyur6bgZjzkhxpBsEDIQjXal6o
 3K9wz8hW8/4UR7O5quuruBha6VAm3mRwyxc8/NeCRgq6ZWu1xVxiFL4kz
 5/k6zG3EUhDakfCym9Jv7VxhD+niQuZfSqQaBtIvdrXNwp3XD+MN38sbl
 HjSIK0T9seWl1K+b06L14GcISumla85y4gEkdLB7nYtCWyUZsAasr6UQv Q==;
X-CSE-ConnectionGUID: U2LYdUgnR/qn2Zj64PNfFw==
X-CSE-MsgGUID: R/eq+1TxS062XuqlHlz8dw==
X-IronPort-AV: E=McAfee;i="6800,10657,11839"; a="109564698"
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="109564698"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 15:54:52 -0700
X-CSE-ConnectionGUID: 2qizOa12SkGqlY0FHE0DWA==
X-CSE-MsgGUID: bhaOG+IbRYWjAEP3Pe8gbg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,151,1779174000"; d="scan'208";a="249404463"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2026 15:54:52 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 15:54:51 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 6 Jul 2026 15:54:51 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.15) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 6 Jul 2026 15:54:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t5UhIqAmIWXBt0cCZQMjjpzePXVZDIpRl5uES8d9HtQ4Ae5p0/ySizjuj7xcTmP+BKBJ7IucNv8MKpPNAXVN2sVl1r+qUtpYK4aVCYw9rdVjl5soTZx+FapFr8KQIYJIQNbMmSAIikMipvEq6vGyg6GQkAUiDn6qSzgZOQZ4DvkO/5MBf3VJ6/AHbWqtoDoGHibVCt+TT3ZDCp7Qt9ZLvjWh88x925IyJ/dJT1VZFKJucJ07heHBQLVbiST4YulJSn3qLgSDtmNlt5LfPE31i1ovvXsQ2djYOnYhvrI3Xa6d4V1hxhAW0DmCvmkKX/JJzgHk1Df7srqBckle/OcrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A6yldyn1i26qdzzQcj8GMvR9GZNqrX5X67P1Bjbw6l4=;
 b=qz2E3gcKbu8oaTguGAuTuwDWCQFKyqazcsVkOzmcTF7pChr3xXj+1G2Pe9EPYd8eQIzK276kRgsABsyZAC9xzrL+16nmCaFfZeoFhTAvyiee/toPhTO8bkqSdRGKh4Qz9xlGOAfq+ExELActabOPyyeKq2HsbCcf/9sCX1RO8QftMXR7OuLE06L4J7ZtZeEMFZGKu77BC8vTHFndsP6v4S5NW8ncpblMK0c0pFGEpVxpzVP80x2ehy69uZKmVBsmEHb46llPqjvXM+DlGRLwbi0azArcmnlfP10DTR7d1usLtBslcYZ3fARvc+e62mpo6MpBHZCNWQpPEoQPgFEsCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA2PR11MB5019.namprd11.prod.outlook.com (2603:10b6:806:f8::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.13; Mon, 6 Jul
 2026 22:54:49 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Mon, 6 Jul 2026
 22:54:48 +0000
Date: Mon, 6 Jul 2026 15:54:45 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <akwyNSXO+QspyoBx@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
 <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
 <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5963b079-cb44-4cd4-be56-f47bf3f15e0e@igalia.com>
X-ClientProxiedBy: MW4PR02CA0002.namprd02.prod.outlook.com
 (2603:10b6:303:16d::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA2PR11MB5019:EE_
X-MS-Office365-Filtering-Correlation-Id: 3e22cbbd-610b-46d8-f381-08dedbb194e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|11063799006|5023799004|4143699003|56012099006|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: YRIcd8DO1YXoggmR8kzd4q2+71L4xBgkN4L/gR2LWGm4aqQg4MydB3OfaDlYysvYj/N5D1UTy/SL6Om7qdnKq7sMvbBBxSO20n3qkDdLSOHyiTjBJrUYZQGmf+uc8mJR7Gn5+d0Sj4exs4iguMUaF8g8stLIBZh4Jn39+jIaU8lUs4SH2r9SF/T3y9CabRk90xR/gboXhirol8BroH3855SMjJVt1UgO+RHy9OEqULebGTgNEp5Vb2XxV4mx/2npvOUemCh5yG9TAUMM7FBkLanxOJJl/VPM5PyVrvMwoXeJMDSLQkHMqGUzkNybOxK59u1R6cTLHIOrF/iW2H2mmWQZipWB+Ai0ywz+7ySpOolg/hDbEfaeYUgcnXjuvgz5FoPxVLyf1NXKWErVKdMGg+VLM9ICgQoi/b0VOZ5yQYwjKK/E8vRyjwsO4Vje/nIt6sX8wrJdaqCIoHAAvn40Od64nMhg0MnVt/jwBC3yZLDdFVTLTe4T7r5dQo7lUu3f20Ha+thXSOaC0SJxpqE2AaP1HFtisXN4viiBtm+aBtMQXkssLJ4OKNk8e8Aq97g2npG0VMcoRcaTelUiCxh9wYbEJwevvO3AmTdgzqnusvE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(11063799006)(5023799004)(4143699003)(56012099006)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTNLWUNGZTBrTkJSQ0pyb0JsUUZ3dUY3QWpzN1ptdTM5dGtBZ2V2R0ZWM2FY?=
 =?utf-8?B?bXNWVG8vU1BMaGRHMk9YcDIzSDdOZVZVOFVxazh1TER6a3hhZGhYUWg4b0l0?=
 =?utf-8?B?bmhRZlJiR3QvbkhpQXlLbURwYlA2aUcwY05vYk5aSEl3enlxb1JLMWRUeVg5?=
 =?utf-8?B?dHpkd1YrUEgzUUVRLzExenJEUmNMc0JEMjFaVENlb3JuQjRFZm9Id3RQMzh1?=
 =?utf-8?B?KzhyRUx0K1ZhK0tTa0Q3SXplbnFYeXZCYnBTV1ZoZFp1V3JqWXZUYnhyL05X?=
 =?utf-8?B?d2h6OWF5ekFjQzYrVnp1WFdZbXV4Qy8rYTBqbThGNVhHVVpQOFNjZXN0Q2tP?=
 =?utf-8?B?OEFIR25uc3crNGd0SHI1Z1RVMzlYUm5vejBsNi8zZWtmUTlHYWV2VE5xTmFr?=
 =?utf-8?B?UEtLM1ZHaFlYc1E3c25rS2VYOGRBbmhxQlRwbk9mOC9Yam1BTXF6Z1BJcU5N?=
 =?utf-8?B?TFVhVzhtMld2azNGbC9INlVkT0ZyR1p0MUhOQnAzRnhOR2N1UEFpai9LanF1?=
 =?utf-8?B?dnNzNVhXcW9yUFh0d1RYV2RaUEl5UVFUSnFYSm1ybWF2RWpFenBVbnlYWVJO?=
 =?utf-8?B?RUhMSnNSeFM2OXJmTGZwK3BxQUJidnVldGtqdnlKZWg1V3hQY2NZckFEOUFh?=
 =?utf-8?B?Y0hCbzBQWCtMMWJONUM3THZvNXNHVGZxblVkdGQxQ3RTRFdiQWhOczNnMXBs?=
 =?utf-8?B?NkVxcWRhZEVhcGV1QUNRVk5TWG9kcytZOE1jcHJLdnR3KytUZkNWb3FmNVpU?=
 =?utf-8?B?OWo1T2JNVlRpNkV1TjBWSFpVSW4zdTNpbU1kUTZrR1FPZ0k4eEpUdnpDbGpY?=
 =?utf-8?B?YXRlalNudGlVRFJTVE51THRtMGJwWVNwbmpTaUZiclgzaEtmdGRydjRQdEVJ?=
 =?utf-8?B?RHR3ZDU5VTRVOGxPVWlydEV0ejYzRGROd2Z3ck9hSHlxUkdjM0FWTEpNbWIw?=
 =?utf-8?B?L29Zc2VrZU83V3drQjdhOWFzU0VpUnhiSWswM2JMQ3RhQlpyRExZaEhYdGtE?=
 =?utf-8?B?V2JvSXR3V0Y5eDkvYmpDSm4wS25Vb1o2aEhqa3ltdmxhYlRDOGhjUWNUMnUy?=
 =?utf-8?B?cFJRaDNCVFhCeGJVdnBkdE00aGRyRmtKdVJxK0xaYm14THVXRC9lVGNGZCth?=
 =?utf-8?B?VmVpTjMxMnk4d2hCeG5WT2ppMlhjdFRGdFdGemhXc0hrZUZsSlM4eU0xeHRI?=
 =?utf-8?B?NC9FZ3lyRkNtSUEwa0pVNE9uK0dJdUt0RXMrUXZQR29saU0xY0JvcHN1VVNm?=
 =?utf-8?B?Z2Rlc2tRMkl0NWI1aGgzTWJqMmRSY2dRZ1JYbTFqQ0EvM09XU01RL3JFQVZs?=
 =?utf-8?B?KzNMK2VDRkgxa1AvbE5WTnZoMVY5SGJDQ29KZFhhT3o3TklSNDR1T09iblAx?=
 =?utf-8?B?RFltalFEb04xMm9IRDZrSWRNQWRiK0VQdDFtVE5ya3pOc0ZzbE5lNCtRd0U2?=
 =?utf-8?B?Qk5LTEpnZEJLRXJMSlVzQ0VnaWpSTzRDdnNEUTlPV2thSVhRS0dhSEx3ZHJa?=
 =?utf-8?B?VDRzcVZuOXo2NzVJMXkvMklva2xzRFg3YUZPRlhCZUF2SldaZk5odE00dDhw?=
 =?utf-8?B?Y3gzazV2SVFaTUYrQWNLRmIxNGFVM2NxSUU5a0lGTlBOaEgxNUpNaERtbHhX?=
 =?utf-8?B?T0RLK1krN3h0a3dCWnRQOU9ldTM3dVo0Z09mNmRXand4c2FSU3FaSzQ1OFls?=
 =?utf-8?B?MCtjMXJucmxNL3NVSlhhSjZhRnN3VkFQcEsvWU95L2I4RzJoT2NkT3Ftdmp1?=
 =?utf-8?B?UHR6Ui9jSU5rYVYwaTZhUk42eFhLL1ZkakIzNXNOM2JSSEp4WGJuUERSak9J?=
 =?utf-8?B?cktDVmdqcVpkVmtnbTZNT3FXcDdMM294ZWZ5OEFqUkd0dkswOHdyU1RaTTM5?=
 =?utf-8?B?NVVpektYOHh6TGNWOGdpdXQwSklQN1dtL0FNMDlNdjVMM0JjSW9KNnJDUU43?=
 =?utf-8?B?R1ZnMHJTbDFBY2JIVGcvMUl0RWhlR1hKUnBnRnZ5VEIxL3RBRW1FUHVzQk9K?=
 =?utf-8?B?WW4wZjZqY21naW5scjFHSDI1ZURrMVNHT3FNRzZLQ2pkc0FsdEw3dnBQOW5w?=
 =?utf-8?B?bjJuMjFsZVBqS2VFMlRXYUJXZVBpRFBMb0RVbCtOUFlQcloxVXVoYlY5and0?=
 =?utf-8?B?T20zcElDUm50U0dnTkM2bWpxYU15dnJ6QUNwZ0VlNGJOZFNkRnEwWGJjNEp6?=
 =?utf-8?B?VTQ4eEs1V0svWjRqZk5TbGhGVnpzbTBUUXY3ajE1Y0U3TkFnUzUvRXhtaTZ0?=
 =?utf-8?B?MzBHbzZ1M1JIODBSbU91ZmVnUmszckpxVFo4Q3ppQzRFWkVOUVFIY05TNW1s?=
 =?utf-8?B?cE5SWk5YaVc5akRFMlg0cmJiQ3pHL2M0VTZRMGJ4ZThZSW5mYno4Zz09?=
X-Exchange-RoutingPolicyChecked: JL8dtEoOba6+dVPMrsR/naLc6504481d7MmkltqB6VtmtRg4N97lLMs5GO68VUBqQaeErJdgZcPlJQrOMi+8aCydhHVPybMYrORuM9/bj/D5nP7mFSJAp1WOOFkb7LZG0DuRpOZmiyyNytRiZXilrIoG8U4nDXUWzIRZdfpKhRTFBVG2AtvYEGqZOaFnckYzSA4cY/LisTWRlYbFnOnhQ+O42vEFPeQvRILl9otKS/2vBlupvsKSgQG3vFZr/kGilRBSV22C4iLCPIH8WG9BI2/DCjSKrpdDK79zDQUBrKItJ2eTrmJmBV4+YM4Uboj3pVv6tWwFt5QNRLK1ZbXKYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3e22cbbd-610b-46d8-f381-08dedbb194e4
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 22:54:48.8389 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nXoZpGwwhLRmS+jHHuBCjRTQ+DeF81QLW9NCSvl4LebJRD3JqRI52YRV05i2la1qO7JQc9Z1hc49YkxOxW5V7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5019
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

On Mon, Jul 06, 2026 at 01:41:01PM +0100, Tvrtko Ursulin wrote:
> 
> On 03/07/2026 10:22, Matthew Brost wrote:
> > On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wrote:
> > > The problem statement is explained quite well and succinctly at:
> > > https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49
> > > 
> > > Essentially, on a system (over)loaded with a lot of runnable CPU processes, a
> > > high-priority DRM client gets latency injected into the GPU submission path due
> > > to the DRM scheduler use of workqueues.
> > > 
> > > This patch series proposes to replace the workqueues with kthread_work and
> > > priority inheritance to solve this problem.
> > > 
> > > In the above linked issue Chia-I benchmarked the submit latencies which
> > > show a striking improvement:
> > > 
> > > 		median	95%	99%
> > >    before	41us	1.5ms	2.6ms
> > >     after	15us	19us	24us
> > 
> > Can you give more information on these numbers? e.g., What you ran / how
> > you measured these. It is hard to argue with numbers.
> 
> I believe Chia-I observed latency on some production hw/sw and then wrote a
> synthetic benchmark to test it more easily. Details are in the above linked
> issue.
> 

Thanks, I see this now. Part of the problem, as far as I can tell, is
that fences are signaled from work items rather than directly from IRQ
context.

For example:

"There is another 2.5 ms of scheduling latency from
panthor_sched_report_fw_events() (running on irq/105-panthor, PID 257)
to process_fw_events_work() (running on kworker/u32:1, PID 62)."

I assume this is only addressing the scheduling portion of the latency,
but you also mentioned a 9.5 ms delay for vkQueueWaitIdle(), where part
of the latency appears to be on the signaling side due to the worker
thread.

> > > This is obviously really good for preventing compositors from missing frames and
> > 
> > Modern compositors do not pass render-job fences to draw jobs as input
> > dependencies. On Wayland, this functionality is provided by
> > linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24.10 and
> > later. SurfaceFlinger has also operated this way for quite some time.
> > 
> > The obvious solution for compositors is to submit work directly through
> > the ioctl (i.e., bypass path in sched) when there are no input
> > dependencies, which should be the common case. The main exception is
> > when one of the BOs mapped into the compositor is migrating or otherwise
> > busy (i.e., a BO has a fence in a kernel dma-resv slot).
> 
> You mean the direct submit RFC you floated some time ago? What was the
> verdict on that one, wasn't it rejected?
> 

I had some patches for DRM sched that I never posted. It turned out to
be a little tricky because of some other quirks in DRM sched, but it was
still roughly 100 LoC plus an additional lock.

DRM dep has this built in without any of that complexity. I'm hoping to
get around to rebasing it soon, but of course there's always something
else to work on. Sooner or later, it will get rebased, and Xe will move
over to it given the latency and power-saving benefits I observed. Given
power savings, I'd think drivers for ARM based phones would be pretty
keen on moving over too.

From an architecture point of view, bypass is the ultimate win because
the context switch is completely avoided. Again, this is primarily for
compositor use cases, since they do not wait on fences.

Also, in general, if Panthor selects PANTHOR_GROUP_PRIORITY_REALTIME, it
would be very odd to pass in fences. The RT priority then depends on
other work completing before the RT job can be scheduled, which
seemingly defeats the purpose of having RT priority in the first place.

> > > similar. Another good quote for the above issue, explaining the consequence of
> > > CPU starvation of the submit path, is this:
> > > 
> > > """
> > > As a result, vkQueueWaitIdle blocks for 9.5ms for a gpu job that takes 4.5ms
> > > gpu time.
> > > """
> > 
> > More details here?
> 
> This just illustrates how long can the workqueue wait for it's slice on the
> CPU if the cores are loaded with other tasks. In other words, how long since
> job is runnable to it actually being passed to the GPU.
> 

Yes. I do wonder if this is an Android quirk, though. While working on
some MM-related Android issues, I noticed it has quite a few quirks.

I've done a lot of profiling around workqueues in Xe (submission, page
faults, resuming after preempt fences, etc.), and I've seen latency
spikes of perhaps 10–20 µs, but never anything on the millisecond scale
on Linux.

I also recently fixed a workqueue bug [1] that showed up fairly often on
Android. In that case, workqueues could stop scheduling under the right
conditions. If I recall correctly, a flush_work() could get the work
item unstuck. It might be worth looking into whether that helps here.

[1] https://patchwork.freedesktop.org/series/164199/

> > > DRM scheduler was originally using kthreads but was converted workqueues due
> > > desire by xe to create thousands of schedulers. This series also questions
> > > whether that was needed, given how the submission is serialized by a device
> > > global lock (per GT, so almost device global). Panthor has a similar situation;
> > > hence the series contains two patches to move those two to a setup which matches
> > > the design of those drivers.
> > > 
> > > Other drivers, like for example amdgpu, v3d, etnaviv etc, which use the
> > > scheduler as a hardware scheduler, where number of instances follow the number
> > > of hardware blocks instead the number of userspace contexts, are completely
> > > fine.
> > > 
> > > There are use cases however which do currently track the number of userspace
> > > contexts and which do allow for more parallelism. For those a straight
> > > kthread_work conversion would be a problem due an explosion in number of
> > > threads.
> > > 
> > > The most direct example is panthor VM bind queue which creates a scheduler per
> > > userspace context and relies on work queue concurrency management to keep the
> > > number of threads in check.
> > > 
> > > This creates a challenge for the kthread_work conversion. To solve which I for
> > > now opted to create a trivial round-robin thread pool. For the RFC this is
> > > limited to four CPU threads and is something which will need to be discussed.
> > 
> > 4 CPU threads per device, per drm sched module?
> 
> 4 CPU threads per drm_sched_create_concurrent_worker(). So depends on the

Ugh, that is a pretty ugly API.

Matt

> driver how it wants to use it. For xe there are no usages of that, albeit
> you say single thread is not workable, we can discuss that in the other
> sub-thread. For panthor this RFC uses that flavour of the worker for the VM
> bind queues and in that case it is 4 CPU threads per device which handle VM
> bind requests from all userspace clients.
> 
> Regards,
> 
> Tvrtko
> 
> > 
> > I have more questions but let's get some clarification first.
> > 
> > Matt
> > 
> > > Ie. how much parallelsim those really need. The true answer is somewhere between
> > > "at most the number of active userspace contexts and the number of CPU cores".
> > > Or it could be less than that, since after all, VM BIND parallelism is
> > > eventually going to choke on a narrower gate of actual GPU execution. We could
> > > also allow drivers to pick their number.
> > > 
> > > In terms of how I implemented priority inheritance, the most important
> > > characteristic is that it is temporary. As many userspace clients may be
> > > submitting to a single DRM scheduler instance, a generic solution is to only
> > > elevate the submission worker priority while there are active high priority
> > > submitters. The mechanism is light weight and has a hysteresis built in to avoid
> > > frequent scheduler operations.
> > > 
> > > That's pretty much it for now apart for an important detail that this RFC will
> > > not build for all drivers! Out of those which directly use the DRM scheduler
> > > APIs changed, I converted only panthor and xe. Amdgpu will also work by the way.
> > > Others I have not tried to build.
> > > 
> > > Cc: Boris Brezillon <boris.brezillon@collabora.com>
> > > Cc: Steven Price <steven.price@arm.com>
> > > Cc: Liviu Dudau <liviu.dudau@arm.com>
> > > Cc: Chia-I Wu <olvaffe@gmail.com>
> > > Cc: Danilo Krummrich <dakr@kernel.org>
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Philipp Stanner <phasta@kernel.org>
> > > 
> > > Tvrtko Ursulin (8):
> > >    drm/panthor: Remove redundant drm_sched_job_cleanup() from the
> > >      .free_job callback
> > >    drm/panthor: Use separate workqueue for DRM scheduler
> > >    drm/sched: Use generic naming for workqueue helpers
> > >    drm/xe: Convert to per gt scheduler workers
> > >    drm: Wrap DRM scheduler worker in own abstraction
> > >    drm/sched: Convert the scheduler job submission to kthread_worker
> > >    drm/sched: Add ability to change drm_sched_worker priority
> > >    drm/sched: Notify worker of the entity submission priority
> > > 
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   8 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |   4 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |   2 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   8 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |   8 +-
> > >   drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |   2 +-
> > >   drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
> > >   drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
> > >   drivers/gpu/drm/msm/adreno/adreno_device.c  |   4 +-
> > >   drivers/gpu/drm/panthor/panthor_mmu.c       |  20 +-
> > >   drivers/gpu/drm/panthor/panthor_sched.c     |  23 ++-
> > >   drivers/gpu/drm/scheduler/sched_entity.c    |   3 +
> > >   drivers/gpu/drm/scheduler/sched_main.c      | 168 +++++++++++-----
> > >   drivers/gpu/drm/scheduler/sched_rq.c        | 202 ++++++++++++++++++++
> > >   drivers/gpu/drm/xe/xe_dep_scheduler.c       |   6 +-
> > >   drivers/gpu/drm/xe/xe_dep_scheduler.h       |   6 +-
> > >   drivers/gpu/drm/xe/xe_exec_queue.c          |   6 +-
> > >   drivers/gpu/drm/xe/xe_gpu_scheduler.c       |  21 +-
> > >   drivers/gpu/drm/xe/xe_gpu_scheduler.h       |   2 +-
> > >   drivers/gpu/drm/xe/xe_gpu_scheduler_types.h |   2 +-
> > >   drivers/gpu/drm/xe/xe_gt.c                  |   7 +
> > >   drivers/gpu/drm/xe/xe_gt_types.h            |   3 +
> > >   drivers/gpu/drm/xe/xe_guc_submit.c          |  18 +-
> > >   drivers/gpu/drm/xe/xe_tlb_inval.c           |  14 +-
> > >   drivers/gpu/drm/xe/xe_tlb_inval_types.h     |   5 +-
> > >   include/drm/gpu_scheduler.h                 | 131 ++++++++++++-
> > >   27 files changed, 551 insertions(+), 134 deletions(-)
> > > 
> > > -- 
> > > 2.54.0
> 
