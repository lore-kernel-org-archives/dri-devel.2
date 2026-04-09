Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2CEEE98FAC
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 05:12:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E184F10E0B0;
	Thu,  9 Apr 2026 05:12:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="lUSN8sNx";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB56C10E065;
 Thu,  9 Apr 2026 05:12:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775711539; x=1807247539;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=vLZjMDJQ/OXK7xeKWWCKSRTw6a6kdlok3A7EV0gjwSc=;
 b=lUSN8sNxj1CeI4xkx+rADHD2zaD8uL7cKrqwluQrL+aihMusXIgQ3cWg
 +Gi/jn+rhbU+9mxxEjE4k6RsJpSEjMV5WQ3v+tLdM8vEJxrN+rtTDBvZq
 W4j6Nws0PIHg53/uILcKJP/6S9Z8gLtbqalwF2o/KKGsNDHbhEmhkhyxi
 bpBO7QCu8VI1IF3RzLIAByBh3Hi8hJRgJJBF0a7rp3CLttJsCw87bzrJu
 7ollcaJMIuZYvlrC3/QdSr/knxnQZXQKQN4d0V9E/rNNRauVgVrQeJe3y
 jVOi3OXRqyIdj81mhtRQZD51tTXkMiyOzrDt+dfxQW4h72xuMLVV1t5rr w==;
X-CSE-ConnectionGUID: HW/y7yTCTVS1pR1bj9xkDQ==
X-CSE-MsgGUID: oUtetawlSMi2NouKn6il0A==
X-IronPort-AV: E=McAfee;i="6800,10657,11753"; a="76725263"
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="76725263"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 22:12:19 -0700
X-CSE-ConnectionGUID: hZnTt7d7SU64RVotfgYv0g==
X-CSE-MsgGUID: SKNvvq4xQmyq78KevEfasw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,169,1770624000"; d="scan'208";a="223917375"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Apr 2026 22:12:18 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 22:12:17 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 8 Apr 2026 22:12:17 -0700
Received: from CH1PR05CU001.outbound.protection.outlook.com (52.101.193.50) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 8 Apr 2026 22:12:17 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=V0UZbWEaSVY7u9cLZBSsB0iIkuS9SGxKrFHLuBKWQx0lq8WCGQQlezG/56gBgsA481PearVivOLoqEEDfjj6ysfnzAmn0hFffyK0Bg5MDzehoox4Erlmg8E+cPRvsnZvrJ/D6RgmnOoOxC2oPRso58oc6cmIAChrark3VMO/NRmgkTvcaHyTLM/kAQFo1eetKzTt+19cHVIsZ2czemS8eGBtSnw9bQEvvuPScZ4wUUX/5wW1FJz4xq0CYHAKfxXCZAZ3UzVcBMbeHtjTk9kChTirtnAs7D37hitLLMDJZ6ftyTORlre8e2zX5u/WnpKqrZgjgGJdJLnjOqtMbXSSsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZuPULpWv/YqquIN655qzhNq05VrvBG0bjzunQ90jr6s=;
 b=V845MK4jpp215Ou9t/yBAaq/QdIs6Njau9larVzqvzAun1K2LxyiOJWP7dWM+zA/mo4bxcAmqMM5DKXflCd2bEyo82D8DW5uwfzVQW4RVWo5QkTmoKEMebygyLRkWuhRq1epJZynpTMhAE8ksZ8CjYbKcSW9g9ecIqRNqqtpmd0WYa0WeFguOwLxxv4UpkMFRXMCvBve1FIhqKzu9YGxV+GQFNC3UKpwqrso/MN71aN2kjan8QO6Kt61Ox1VjrOCDDfk/ovqxBSL+BXvuxlVGdbEKxKhuSLgiOcdgowsQUTsiGVSVmwpca0uk6I/ftK5TfFIMuOWTqCKrP7OMsTtDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by SA2PR11MB4796.namprd11.prod.outlook.com (2603:10b6:806:117::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 9 Apr
 2026 05:12:15 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Thu, 9 Apr 2026
 05:12:15 +0000
Date: Wed, 8 Apr 2026 22:12:10 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: Daniel Colascione <dancol@dancol.org>, <dri-devel@lists.freedesktop.org>, 
 <intel-xe@lists.freedesktop.org>, Huang Rui <ray.huang@amd.com>,
 Matthew Auld <matthew.auld@intel.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH] Limit reclaim to avoid TTM desktop stutter under mem
 pressure
Message-ID: <adc1KlAcPgUeyhU5@gsse-cloud1.jf.intel.com>
References: <87341fsa85.fsf@dancol.org>
 <adQfdL0zV7SOo+al@gsse-cloud1.jf.intel.com>
 <d8e8f290-c2bd-483f-ba0f-735c503e269a@amd.com>
 <adVAHkA4gERWOszt@gsse-cloud1.jf.intel.com>
 <6ffebd9a-d873-461b-a407-a84707a45229@amd.com>
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6ffebd9a-d873-461b-a407-a84707a45229@amd.com>
X-ClientProxiedBy: SJ0P220CA0016.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::23) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|SA2PR11MB4796:EE_
X-MS-Office365-Filtering-Correlation-Id: 44b39d4b-1f2c-4ebc-dd9d-08de95f68fed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|1800799024|376014|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: xFsO8nAnl5Empyjafurwv/cEYluz2Uh8s7weemYHaxJhxbIX3nZspx+RLwReEHwvIbD3mdsMT7Hmg71I8AdJBswo4Mhfv7oV1kWhTrNoKoWNEkszYO8v8yYDXD5WkRFgDLrjvb0fv2MYeVBqZaGhRt7pwAFgSWfzswQhleA5uAJnBkKom7MrZaj0ZYIaAw6OIwe4JOjz3UPmbX+3asrNaW0Og8bV22gdC+eeQHAMq3Ld0BiDAOCH/3c4c1HxOYiQsSP3Xp6k3/WXpymTJQaq+FQVLBXNSNxPSf2TAYvnn6l1fy9YFqWZyPi3UzvMPnaW/ZuBC5yDmbbb413cEWv010z37zCmIYCZBt77an2uYM3y799NP1V1b2/R+g58c0DrLSxI7tLISxLy7JUvudiorfDhoFAJT3BI8M35olbYSW+Pz0+lApH//p+zMqFzLvpkU5lhbE/MSff4BWMhH4DzNOiyXEBrLS1Tnin0VXfwFfh9OMh2nHdVNkT5lwV3lkqyGaSKG8fcUMSJ0JKsU5UsMhQlTmoniY6eBE/GYYLouZKVKGF51BVIYp2eu3wsbAUZK34/o59sZoBObicexOWEjjoFyitObL1OMLgpYlwXqrW99XFCk3YVDPFt29Lq3WS+zC+r+TCVENP5cdvSHUi3CiEL54eyySVhxWzaLkUajpcLb8bPyTfK/Llp05wuJVusKa7gUH6kuADrAeWB+IfxjOJLzoYJW9XfyUfARGycFg0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(1800799024)(376014)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1FDSmxwUmhpVlZ2cDBmVlR2VUw3cGlJS3YwU1RYOWlDaXZpWERvY2FGS1NO?=
 =?utf-8?B?elNmcUhXenFtR2NXcG0rM3gzeE9XSG1hY29jYkxFUFlVNnplL0VmNnAybzht?=
 =?utf-8?B?RlZ2MHlKSjdKN0k4a0dwdFJIdHdYT0VoN3NmV0JZMzlVL29vVktZSEt2OTQ2?=
 =?utf-8?B?cWVGYTZpZEVwYlpOSG8rUXlEcEpJZnFKeUpXZUFiRE9ISC9lcjhtd3FwNmFh?=
 =?utf-8?B?MDZ0dENhd1FhcVpLSHZuTzVTM0M3L09seEt1bzNsZ0hDdTF5cHlKT3FpRnVa?=
 =?utf-8?B?RlpNbDI4ekpsUC9sOS9ZeTZWOWRCNjV0YzkzcnhiTndXZGRuM3JnVG55NXFi?=
 =?utf-8?B?Z1lHcFNrbmhyZmx4U0dCQXF2TXpBajl2QkNQTXRhVzFTTElzYkRoeGJwT0dV?=
 =?utf-8?B?SEw0L2VrWVhNOHdnTHVlRnRFdHI4bXVha1E0TVllNituVEEzbE1qQXF1WFZK?=
 =?utf-8?B?NUI2dllmWnhlNzQrSW13Umd0bDc1RFdHczFZNzBPNitZSmlvRVFKZ1l2TElj?=
 =?utf-8?B?M2hITDgrQUt6V1M1RVRkUmhQV1Badm91K0J5R3Fkd0ozRGJqeVJRdXltUEJl?=
 =?utf-8?B?ZURGTnZOeEJiQjFwaThMKzNPUjc4aDdnTGYwbExtRVArbVJ5MVBobnF5OFVi?=
 =?utf-8?B?VkdkQ2NoVEFFcnp6NkNRK0IvVVgvSUs1Q0tFeEZrVkp2QkEyK2l1NlNDT250?=
 =?utf-8?B?LzU5ODd3OG1Sd0ZUWDU3VGdYbkpmYlNHYzRkSkkrTkhEakhwcjB0allGZWNI?=
 =?utf-8?B?dlMxNUZwRmlETEV5ckpiWVRRRGlLbXhtNWozS2g4NVp1blVFNTluODRtZi9V?=
 =?utf-8?B?YytJc1B3bXdrMzUrb3NXNi85OUQzRVZXc09lQ0M0aVREVW9QSDJMYWJmaHM0?=
 =?utf-8?B?emZ4N0hBbC9aT1JBMCtnbDBEQThKeEU1UWNnci9rUVhkTVF4SHM5ZnBxR1Fw?=
 =?utf-8?B?YldVTHlTUFBjVzV0UWRSWmphbDI5ZVptVmdwQU1YaUt0ek9mZmFRQWVIV1d4?=
 =?utf-8?B?ZUVWc0lEVjJPY0FWS2tNcjBweHNWTUh0MUt1SXlsYkh2ZkVHWDk4eDEvWDN6?=
 =?utf-8?B?WHlUK09xZlNoeWF4aEtGWXdiRmFPcDRXc0d0aDJUSVdoa0ovRGNXQnV6RDJW?=
 =?utf-8?B?ZU42K2UyOFNiUDA1M2hNTlhtZ2FaU2dQc0NxUm9uclZBdHBtVDN4dGtiKzZQ?=
 =?utf-8?B?ZFM0cVBFK3AvR2NxUjBCWjNvVHBSbU5MTHZqU2dIdG8wYlMrWnJNSUx3RENM?=
 =?utf-8?B?UEtiN1dDWG9RMWQyWDR4TnNIRDZWdGhzREd3Yms3TjVvQXc4MW1OTFYvUDNu?=
 =?utf-8?B?VUFCV3hycmZSR3hPaWZJNzlTZk44VXplSzMrL01qMDZBRGF3R1BGTldsTlJN?=
 =?utf-8?B?R2dBMmRpcEM1N1NxKzNOWGx4eXB5L28zaGEvVE1JTmZaYXo2V2xJT2doWDgr?=
 =?utf-8?B?WkR1WldwRFQzeEt3aUdpcW1NM0ZzOFQwSXFINU9tdUl0Q0ZpTVQ3S3pQRHZL?=
 =?utf-8?B?cEJWZUxWaHhObjJHem1pNzRUVTcvWmhGbGRXT1l6RW5hdDhoYXczN0dsUThq?=
 =?utf-8?B?Zkg4MzY4ZXhwTkF5dWcvUUhvNEs5Y2R4VDJTRC9GaUxVV2tGdWNHLzBmNDV2?=
 =?utf-8?B?YmdyQlAvRUN3YmRFajBrSm9oUmtCUHI0NWVhc0R3NDNmRndMT211dmtLWDcv?=
 =?utf-8?B?N3JTNXZseTMxSWo1N0NFaHdhWHJLVU1qelZsQmVQcjgrWGVMWTNOT3BTVlQv?=
 =?utf-8?B?b2tmYXNOYUxYVE8xWkU5azZBL0hjRVdRVFlmRnN5Q0pHanlDZ3lPNWwxSTd4?=
 =?utf-8?B?OVA3WEJDSmxIL3JuaVJyRlJRaXcyeXpGSlFCeGtXNW5BRk9Kd2dCNGtRaXFn?=
 =?utf-8?B?N2JFN0xaRHN5SUVWMjNXOW1qVFNUbERKcXJQN1NESmEwQWNZZ0JjVWw0M1hY?=
 =?utf-8?B?UEZVSkF4clM1SE1GeWZTMnJsMGhoM3RsNmNXZ3Z5dFNKTTVHZFByU2M4QzAr?=
 =?utf-8?B?ZG9hL09OQityOHdHbTIvTS9LNWJBNEFaZnFBb2xFeHhmYmRYOWRLb3FyQTVk?=
 =?utf-8?B?WWNNK3dZREh6SG9Cc3hSZXFDbDRZWjVLWkpVQ2hYbENCRFJSS05aS1NCWWJr?=
 =?utf-8?B?cmVqeGE0eDBGN3FWQkx4VmcwUm1PcGprUXBYVlE4eHltRk8vUmU4Z0dzRi9y?=
 =?utf-8?B?L3FRTVN4TU13dlhZU2tVLzFoa3pSOWVUNHY1TVNRWGtMWmFOcUlpbExtRmdS?=
 =?utf-8?B?ajdabjlOVlhLOUVLdUd1SlNXYnRsVFFkSk1xSTVvMVg5RUlTOUU5aThKeEIr?=
 =?utf-8?B?WVF1TjJocnREZFJ2TUg5U2hEZzl2bWJmRFhrN3VRdVoyMEZaSlBrdz09?=
X-Exchange-RoutingPolicyChecked: tqk3P6vXoVHs1MND+iZnsgrYQrYTLcfslMB+M8B/VxX8hdoKx5wZH+A4a3wO+bvZvEb0LcbYXbQ2AEqfz8AOWi+iXNIXm94W8P6TOW5nBYwlZjN+LEb/yV3JFO7J3acPfxdbXYaxHo3aIzbHHq6YdvR8hYkpU6ev5sr/I7+qlJ4QdPRWOn/cwysx7wfm8jJOrmGU3VOuoQJCUyhueEtNTOhkRCQTHYzgGjrV+GrTdjtyKyJaLGxB9i7c2cs9SOsHAttoIbhCd1sPhgOqcBZLhmAg3rnle7aovdlSamC+nk+hu60fEBrjQtQS2uUBn8oXr0Z866TXojG08PK6kUvn/g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44b39d4b-1f2c-4ebc-dd9d-08de95f68fed
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2026 05:12:14.5354 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h8qNJj7c4rbgw8/giSDB7JFSSXWX1pGXiXAP2JZL8xoxaOe+N3Foj7msVIhUFty2GqqZ3sqc+xThIx48HTU0zw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4796
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

On Wed, Apr 08, 2026 at 10:00:26AM +0200, Christian König wrote:
> On 4/7/26 19:34, Matthew Brost wrote:
> > On Tue, Apr 07, 2026 at 09:43:30AM +0200, Christian König wrote:
> >> On 4/6/26 23:02, Matthew Brost wrote:
> >>> On Tue, Mar 31, 2026 at 10:08:58PM -0400, Daniel Colascione wrote:
> >> ...
> >>>> -
> >>>> -       /*
> >>>> -        * Do not add latency to the allocation path for allocations orders
> >>>> -        * device tolds us do not bring them additional performance gains.
> >>>> -        */
> >>>> -       if (beneficial_order && order > beneficial_order)
> >>>> -               gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> >>>> +               if (beneficial_order && order > beneficial_order)
> >>>> +                       gfp_flags &= ~__GFP_DIRECT_RECLAIM;
> >>>> +               if (order > max_reclaim_order)
> >>>> +                       gfp_flags &= ~__GFP_RECLAIM;
> >>>
> >>> I’m not very familiar with this code, but at first glance it doesn’t
> >>> seem quite right.
> >>>
> >>> Would setting Xe’s beneficial to 9, similar to AMD’s, along with this
> >>> diff, help?
> >>
> >> No, not really. The problem is that giving 9 as beneficial order only saves us avoiding direct reclaim for 10 (>=11 is usually not used in a x86 linux kernel anyway).
> >>
> > 
> > Yes, the first snippet was a bit incomplete. I adjusted it in a
> > self-reply, but that likely still isn’t exactly right either. I’ll also
> > take a look at how reclaim works at higher orders and how kswapd behaves
> > there—I’m shooting from the hip a bit at the moment.
> > 
> >>>
> >>> If I’m understanding this correctly, we would try a single allocation
> >>> attempt with __GFP_DIRECT_RECLAIM cleared for the size we care about,
> >>> still attempt allocations from the pools, and then finally fall back to
> >>> allocating single pages one at a time.
> >>
> >> Well the code is a bit broken, but the general idea is not so bad.
> >>
> >> What we could do is to use beneficial_order as sweet spot and set __GFP_DIRECT_RECLAIM only for the allocations with that order.
> >>
> > 
> > That’s roughly what my follow-up snippet did, but with
> > __GFP_DIRECT_RECLAIM replaced by __GFP_KSWAPD_RECLAIM. I’m really not
> > sure what the correct policy should be here. But in general I agree
> > beneficial_order should be the sweet spot where we trigger some sort of
> > reclaim.
> > 
> >> This would skip setting it for order 1..8, which are nice to have as well but not so necessary that we always need to trigger reclaim for them.
> >>
> > 
> > This has made me think a bit further. I’m not really sure the current
> > approach of TTM setting policy is actually the right choice—it might be
> > better to give drivers more control so they can tune this themselves.
> > 
> > Rough idea...
> > 
> > struct ttm_pool_order_policy {
> > 	bool enable;		/* Should I call ttm_pool_alloc_page for an order */
> > 	gfp_t reclaim_mask;	/* Used in ttm_pool_alloc_page &= ~reclaim_mask; */
> > };
> > 
> > Then, in ttm_pool_init, we could optionally pass in a table (0 →
> > MAX_PAGE_ORDER) that controls the allocation pipeline in
> > __ttm_pool_alloc.
> > 
> > This may be overkill, and it still wouldn’t provide per-BO control,
> > which might be desirable for cases like compositors versus compute
> > workloads, etc.
> > 
> > What do you think?
> 
> That you need to completely disable allocation of a specific order is rather unlikely from my experience.
> 

That might be true as I haven't really dug in here.

> Different HW has different sweat spots they want for allocation, e.g. 64k, 256k, 2M etc... but in general it has proven to be always beneficial to try to allocate large pages first just to speed up allocation (calling GFP once for a 2M page compared to 512 times for 4k pages makes a huge difference).

Yes, I agree '2M page compared to 512 times for 4k pages makes a huge
difference', likewise dma-mapping pages 2M pages helps a ton vs 4k.

> 
> I also don't want to overload the driver->TTM interface with to much information, so just giving the sweat spot or maybe a mask for the most desired orders should potentially do it.
> 

I think this is a good place to start, I suspect direct reclaim on
beneficial order plus direct reclaim order 0 is enough. 

The description of this issue is a bit confusing look as really point to
many smaller pages being held onto somewhere, which completely throws
kswap into a loop.

Matt

> Christian.
> 
> > 
> > Matt
> > 
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Matt
> >>>
> >>> diff --git a/drivers/gpu/drm/ttm/ttm_pool.c b/drivers/gpu/drm/ttm/ttm_pool.c
> >>> index aa41099c5ecf..f1f430aba0c1 100644
> >>> --- a/drivers/gpu/drm/ttm/ttm_pool.c
> >>> +++ b/drivers/gpu/drm/ttm/ttm_pool.c
> >>> @@ -714,6 +714,7 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> >>>                             struct ttm_pool_alloc_state *alloc,
> >>>                             struct ttm_pool_tt_restore *restore)
> >>>  {
> >>> +       const unsigned int beneficial_order = ttm_pool_beneficial_order(pool);
> >>>         enum ttm_caching page_caching;
> >>>         gfp_t gfp_flags = GFP_USER;
> >>>         pgoff_t caching_divide;
> >>> @@ -757,7 +758,8 @@ static int __ttm_pool_alloc(struct ttm_pool *pool, struct ttm_tt *tt,
> >>>                 if (!p) {
> >>>                         page_caching = ttm_cached;
> >>>                         allow_pools = false;
> >>> -                       p = ttm_pool_alloc_page(pool, gfp_flags, order);
> >>> +                       if (!order || order >= beneficial_order)
> >>> +                               p = ttm_pool_alloc_page(pool, gfp_flags, order);
> >>>                 }
> >>>                 /* If that fails, lower the order if possible and retry. */
> >>>                 if (!p) {
> >>>
> >>>
> >>>> +       }
> >>>>  
> >>>>         if (!ttm_pool_uses_dma_alloc(pool)) {
> >>>>                 p = alloc_pages_node(pool->nid, gfp_flags, order);
> >>
> 
