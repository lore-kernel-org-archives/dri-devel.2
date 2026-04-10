Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018C4F45A0D
	for <dri-devel@archiver.kernel.org>; Fri, 10 Apr 2026 23:26:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 294B310E9DE;
	Fri, 10 Apr 2026 23:26:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kw5grZTO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B4F9B10E05E;
 Fri, 10 Apr 2026 23:26:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775863586; x=1807399586;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=HPebPFh30WAAB7vh4dUtQ80kJh+Qg8SpvmUcPHHMA5g=;
 b=kw5grZTOMXKHTlGzv6TR4ySNrnPhjC03O3J2up9+0JhBBqlOs5DjYEO6
 VaqdrNl2Y+BYMYmuRD6t8tdch0/xiP5UaOiKQKO8EAWh5ACickQCb2PaM
 TFGxKFRnDutVsa6FHSj8eOw0tejzF4UTHZP4/tdfZmq5Li413CWUs3aQL
 +F82mzPXhkCJI46gH4gePDjO17SThBnyY8gU27+SzEdQSKguxWBkJiqlz
 2SrHwwHtB8LtNpeq2aKO2AjpGD9U/P44A3C9iwfCwOtKa+7zeHN622l86
 A771H9eagHBucKbyGjBbZAuYbNRcG0I3JB46uv0Zlta29rPFJBQtNpJLV A==;
X-CSE-ConnectionGUID: U8s1kPYwQ2q3qYGJkP0gSQ==
X-CSE-MsgGUID: jHW+cAUoTcC3eNBqjrxSmQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11755"; a="76960842"
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="76960842"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 16:26:26 -0700
X-CSE-ConnectionGUID: BXZfgEo/Q3eoZc3nrIpnQA==
X-CSE-MsgGUID: XkoHWcf7S7mnc4wniTMTPA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,172,1770624000"; d="scan'208";a="233294896"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 16:26:26 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 16:26:25 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 10 Apr 2026 16:26:25 -0700
Received: from CY3PR05CU001.outbound.protection.outlook.com (40.93.201.10) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 10 Apr 2026 16:26:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tn2pa9an0e8UqCAohdgi0RC44xjVbHhaE0xNu7TpuRonOUHaR6AS6ePUu+fR5f8BcR9yIT0/CPXbdXMVxawefPXJkoUQDLZXXz4Mjyp7ip2Jy/2P+UDlN+B60sYYIWMB8FG8QuN7cvqdSNast/w4Ft2BrPmpXJ29t58C7JGXYx6uSyDiD9Yr872P+WNXDLUqZ1Yseo5WsKiKJirURz+ED8K6O4J9luLeuM1gbZy5IftK7R/80Vddba+2sevFgCLQO02hHDCLV35c01W5Bf/1IztwZMo+kpH0vqnRTA3J+JyRd66csvA/1uoAZ+sq0kLkCCh4OXjWcFLRA/9gpEGEIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mKJLnEGn75U4tTaJx6HzjJ+7mNAq7BQxIDiCkJNGIXA=;
 b=JWsp6MtBZiMAWjmkPo6MJpPWPdAzoGplbPR1yrZsju8DkqjCiLsr7PdGtGn/f/OMD3bt/VMafppfDzgL2zABdpcE5FxdIDmHomAUX31f6MayeUGZ6RGzunTOYif6K0YLkkTUCCiIJTkfIAlaKzQo42WIO/5EC5C6HZAM8IkSSqEtLWmve1mdv/4+foDWyGfpvT3pMKKe4a1B1lFNcz2g1wXydocQGXz0eGErucUsOpHu+8fVKXG1VSz8l+5sqFP9dNiJ/8uBCSnWW8dX26tdVGJCdCgUmXicZDPH9b8PXvVPJ0HccZUrkxJAaLn1n17ISgPL1cL3fXkPBBOFrB0qrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6508.namprd11.prod.outlook.com (2603:10b6:208:38f::5)
 by PH7PR11MB7002.namprd11.prod.outlook.com (2603:10b6:510:209::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Fri, 10 Apr
 2026 23:26:19 +0000
Received: from BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5]) by BL3PR11MB6508.namprd11.prod.outlook.com
 ([fe80::53c9:f6c2:ffa5:3cb5%7]) with mapi id 15.20.9769.016; Fri, 10 Apr 2026
 23:26:18 +0000
Date: Fri, 10 Apr 2026 16:26:14 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>
CC: David Hildenbrand <david@kernel.org>, Oscar Salvador <osalvador@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>,
 Balbir Singh <balbirs@nvidia.com>, 
 <linux-mm@kvack.org>, <linux-cxl@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm/zone_device: Do not touch device folio after calling
 ->folio_free()
Message-ID: <admHFtANBj9nTtKw@gsse-cloud1.jf.intel.com>
References: <20260410230346.4009855-1-matthew.brost@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260410230346.4009855-1-matthew.brost@intel.com>
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To BL3PR11MB6508.namprd11.prod.outlook.com
 (2603:10b6:208:38f::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6508:EE_|PH7PR11MB7002:EE_
X-MS-Office365-Filtering-Correlation-Id: 14733355-a2d3-4b17-63e6-08de97589135
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: 5jbgmVvs+MFqptK0H4LcTGzeNNx0/ORZWB0K4B+ornrf8al8ZlrfHF9LQvWKoYKvO23HkJ1cxZTP96vj8w1KjfCh+w8BjWL+V1aZl6WCq3oHqY26qa/qDKsPdfduKQnkQYr/jDQBx59A613PBwKUQI2Jc2CYto96L+VIQdlgxEUiEOWlnWdR+vNbev8o1nCQ9GvBeEpNEvc7rQOX7bGGZs9bUvxxjCY7J9xwLB7edHcI5PZLCKBDH2HyAuxfcU7KzxsKMfRMobiuaxbGsgeqT+Nc2e9ecisyOvfQcaXFggVasodsL7rv06R1/G1vtvhFRMUCFeUjB4UAsldYdJHqwIx5KM/zOsePJnDvgnhW5PRrbWtQuCnJkSqfwefwW8lFZhINyDpn2OKIAmwLS2EzH/uyGTTkm6X+WFhL0nS5dIrVLC4OJEj+hLbSS3xAfVkuo68gy8sWCk4V5x817616c2RjwX0tww9UZy6atd6erUXtmqnHloVN9lS1VijXNy/SK2yN2bahVtySOK8Xo6G/58ygTaMp2+DshinBOozTsXQYXjUzdhv6GzV3+ZQ5+Ipqs2fB4psdpaWqQs1AHc+PC7YLSCv2j6LcYK/UB8Maq4mQU6pnmuNndrJsb6T8MI/6LLYaxc9zXlLo+oK9KcZDtgzCPDzGoOuGDGnU02bZ9FfspgiFlMvlg9t0POEcbmAHaFBb8CKp2WEqEYHTGdxAMxBr1onlWqR7TS9w3T7LA00=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:BL3PR11MB6508.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SNVY/FHjEf4h1b6R+xiDIy8W1Vw+zAZ0zFWsHIESdvYN22J2TpnSCBOKW6hX?=
 =?us-ascii?Q?fXycy0MzWwyuNDvXUdpXiMZlFOokqp/Cs50NZU/MvHqoVdsiUg8e3RwCtev5?=
 =?us-ascii?Q?EZLqLNX5tEnHnd5XM2PEtwPmNk7ws3dy24BbLramMByH960Ks+74oMS9Acj2?=
 =?us-ascii?Q?qb5Exd8dtIXBHcHveWxNSElEZmqpDBfYvpwFervmwq8prQyVhfVmGRWxl+e9?=
 =?us-ascii?Q?q62tqZHZe94DOxgVY5N7YkW+R9TAuUUaijTAF89EhxD6qETQ65BU/MuyBSxp?=
 =?us-ascii?Q?BAH5/zHCOwdLAYQlxOLpZgR1jP94HT3IIU/XqlKlDjVCh8AiQZlRx6tDmSXT?=
 =?us-ascii?Q?mkFpSTdQK07Xf7WgOmMKoNYnnYUHuGmfEgwrw1erH6wZjYdarCfq2F3NVc7S?=
 =?us-ascii?Q?sKZhh0t2XxGDZJa+wXocO+Xm2JtNPhUqAawWi81CESVK1A4hfroQTwu4W8FC?=
 =?us-ascii?Q?RjDTbHm3zH9WWIltvWD/4blW2vwp8iQRig0+O1wERHO/vrrMLT50VP/T0SeH?=
 =?us-ascii?Q?wIUJiT6bqqzCk0ClzY0PsO6LU2mo9AUnTBmVmQDjOINa8EuT3K7qisd/pTNG?=
 =?us-ascii?Q?4s1Zbrv37CBuy7ddn1u5HRlwclvMvHJxxHi14xHTDNCs8NPZJdtD1zuQ9XFz?=
 =?us-ascii?Q?WXIgY4k1Fte/QGe54e5r3/p/eQ85bmIJC6QR4je8E6SKhdB6cltUsEadHAW7?=
 =?us-ascii?Q?/B60qdN+014nRfHIXShnBAVk5PTKy0bAk8ezWCtAyzAbfzOyMQnAsA++39Lo?=
 =?us-ascii?Q?ECAxELEE7G3brBra/kCbEOpPsbEY5DpPIeFhstUMPQ259eeo8GD8N++YWUXg?=
 =?us-ascii?Q?x+aBpiVgHlZmJu29kE3M1E0lCDQYbHU9yxilbta4N7AsuPdmNHun2jU1UexS?=
 =?us-ascii?Q?KFTbvkKsKfZOWNIgaD038GM7fPUIWhCmOSWHazMzPqbrVW4QQGv8AnZb/2tx?=
 =?us-ascii?Q?RGt0z+MJUthPhKrEK55oYMltuk40H4LTtpukYVBqtGPfifBK2rdrtstAyETi?=
 =?us-ascii?Q?mEV0v4xfwODu1tBYLgOvZN0byxXSH3gkmIEs9pOdY4/vq+yUEQwd2MbWZJUV?=
 =?us-ascii?Q?mDlPJXNddMvBY5mi3kEFc4sc9iX25ddQIB01BLfOMvY0/nMerT+9cSlzY2kr?=
 =?us-ascii?Q?zuN34KLL5CNUw7BqN6wN/+0UeqbTIr16Xlz6ApdkGK7nPh1S79OU6w76/1Rm?=
 =?us-ascii?Q?XFH3PKJufNMpnQpT2HhUZcmxqw3x4RY/nSAbH/zjd3fQb5rsbzbYx5cgTD6m?=
 =?us-ascii?Q?3ZX467uvyv8fruQ7eiaTp26ucNJ0yqke+B3gWn6s0mWYBOH80oPNJwIcyFiF?=
 =?us-ascii?Q?xTBsBEkTbPO5Vt6TUHP2w7I3qgq6WGPlTK6y3jdn4n5nIUr+0BlTJuBQAXic?=
 =?us-ascii?Q?Ig97pvBSCM0t+hxyL46jLKfFS3oMm356sF3VOLVTbXoBXX+dpj29QKw9c1fC?=
 =?us-ascii?Q?7E+HgfuwyYudFq4JqKRnaUlzcqx16r4jf7r8CkjHVQTt6he3fLs0sYKW/Xa2?=
 =?us-ascii?Q?zPdd9tuJKBTG+QQ0JH9mqPZa6ozHmFWeJkjVkTkfdR3O+YlffRYYaAgU3LNt?=
 =?us-ascii?Q?dMsMIsb7urq1dJ3tvhDXYJncNnwh+a38ULhDM3wTiNxa9xpaYqYGCczFXMq0?=
 =?us-ascii?Q?5f/kwNIxrG5QAq9Rn26FJpua/5iWJOJEBXc2NznX/BfYcQboj6Admnbw+0ds?=
 =?us-ascii?Q?Z8WDiZHX21zclSM2+Fr36jzclhWD1EJNWyVzaSdOiSzI5gvo3biN7+WCv3tg?=
 =?us-ascii?Q?PVL0raIH3mfXZKLK9d5+ec1S1TvXUPY=3D?=
X-Exchange-RoutingPolicyChecked: N/jcxJcTThFXMbPlewnIRll0suWVfdTA4dx4lsxmDNC0SZTzjpxxW0fsF7YJTtO+3jCZV8Z8TmR/coEg7n3vvc9ItRZisXC/XnpfSQrLl031qWArCZAtaFxYnFKN8kKlm7Z2vlsArOWSntNddyxg+zID2kJFDfgDgkvd9AO0ohhy8t52o6a0IN8E/aynIctawkhmxF+vmjQEcVfOk6YKMyTDbydOtCfklDia3JO401gy4Djf98LXWitGGarKos0B3HF5iHoO65EUTFVVQxiXsFuiNXCj/zR3Hd0SnqjMtV5PQbDEnzYpBCJUfWnZq9Q6yqB6X0nOZn6CoVHHje3Wug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 14733355-a2d3-4b17-63e6-08de97589135
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6508.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2026 23:26:18.7992 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tvx1gmtvgEwEFVBz6RR7wRrL+qbRLwUklzN0YPU3VVhlhXSuGlIKxmlHjrpGNNfC+7D5Xxro1xB2POUxNfxXYw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7002
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

On Fri, Apr 10, 2026 at 04:03:46PM -0700, Matthew Brost wrote:
> The contents of a device folio can immediately change after calling
> ->folio_free(), as the folio may be reallocated by a driver with a
> different order. Instead of touching the folio again to extract the
> pgmap, use the local stack variable when calling percpu_ref_put_many().
> 
> Cc: David Hildenbrand <david@kernel.org>
> Cc: Oscar Salvador <osalvador@suse.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Balbir Singh <balbirs@nvidia.com>
> Cc: linux-mm@kvack.org
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org

Cc: <stable@vger.kernel.org>

> Fixes: d245f9b4ab80 ("mm/zone_device: support large zone device private folios")
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> 
> ---
> Stack trace:
> 
> [  631.875165] [IGT] xe_exec_system_allocator: starting subtest threads-many-new-prefetch
> [  632.282992] Oops: general protection fault, probably for non-canonical address 0x900000000000000: 0000 [#1] SMP NOPTI
> [  632.293469] CPU: 8 UID: 0 PID: 59267 Comm: xe_exec_system_ Not tainted 7.0.0-rc7-xe+ #281 PREEMPT(full)
> [  632.316023] RIP: 0010:free_zone_device_folio+0x149/0x240
> [  632.339782] RSP: 0000:ffffc90023d1fd00 EFLAGS: 00010206
> [  632.344947] RAX: 0900000000000000 RBX: 0000000000000001 RCX: 0000000094472d4d
> [  632.351991] RDX: ffffffff8155c76f RSI: 000000006f2213bf RDI: 000000008e84943a
> [  632.359042] RBP: ffffea0ff4030001 R08: 0000000000000000 R09: 0000000000000001
> [  632.366094] R10: 0000000000000028 R11: 0000000000000000 R12: ffff88811828e400
> [  632.373145] R13: 0000000000000000 R14: 000fffffc0000000 R15: 0000000000100073
> [  632.380194] FS:  00007f2f0fdfe6c0(0000) GS:ffff88890a7e7000(0000) knlGS:0000000000000000
> [  632.388186] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  632.393870] CR2: 00007f2f002e90f8 CR3: 0000000106708002 CR4: 0000000000f70ef0
> [  632.400919] PKRU: 55555554
> [  632.403605] Call Trace:
> [  632.406039]  <TASK>
> [  632.408131]  do_swap_page+0x146d/0x18c0
> [  632.411938]  ? __pte_offset_map+0x3e/0x190
> [  632.415994]  __handle_mm_fault+0x6e8/0x8d0
> [  632.420053]  handle_mm_fault+0xbf/0x250
> [  632.423855]  ? lock_mm_and_find_vma+0x41/0x6f0
> [  632.428256]  do_user_addr_fault+0x168/0x690
> [  632.432399]  exc_page_fault+0x74/0x200
> [  632.436117]  asm_exc_page_fault+0x26/0x30
> [  632.440092] RIP: 0033:0x5587554ff70d
> [  632.462142] RSP: 002b:00007f2f0fdfc970 EFLAGS: 00010246
> [  632.467308] RAX: 0000000000003fc0 RBX: 00007f2f082e1fc0 RCX: 00007f2f12b3287d
> [  632.474355] RDX: 0000000000000000 RSI: 00000000c048644a RDI: 0000000000000003
> [  632.481404] RBP: 00007f2f082e1fc0 R08: 00007f2f0fdfc958 R09: 0000000000000066
> [  632.488450] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
> [  632.495495] R13: 00007f2f082de000 R14: 0000000000c00002 R15: 00007f2f1319e000
> [  632.502547]  </TASK>
> ---
>  mm/memremap.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/mm/memremap.c b/mm/memremap.c
> index ac7be07e3361..053842d45cb1 100644
> --- a/mm/memremap.c
> +++ b/mm/memremap.c
> @@ -454,7 +454,7 @@ void free_zone_device_folio(struct folio *folio)
>  		if (WARN_ON_ONCE(!pgmap->ops || !pgmap->ops->folio_free))
>  			break;
>  		pgmap->ops->folio_free(folio);
> -		percpu_ref_put_many(&folio->pgmap->ref, nr);
> +		percpu_ref_put_many(&pgmap->ref, nr);
>  		break;
>  
>  	case MEMORY_DEVICE_GENERIC:
> -- 
> 2.34.1
> 
