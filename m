Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EED57C561E6
	for <dri-devel@archiver.kernel.org>; Thu,  6 Aug 2026 07:21:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E7D5E10E2B1;
	Thu,  6 Aug 2026 07:21:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="g8wHm1IE";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 41CC910E2A5;
 Thu,  6 Aug 2026 07:21:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786000889; x=1817536889;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=LyHEOGG7qn0NCh1jJY1ADqXpoxbOTdQXPkP6iCFc0/k=;
 b=g8wHm1IEaa93yKzF+l5MioCKj7kEVz7vFmy7vSQkszyNmtsKXWSY8Ilf
 Zzm5NY74LT7v7ENqg3j2ndkCHG2buoxu7yCrEYQzN5FCed6PNv5sYlU1k
 esLUtMAx3Sc9sFaN8vC4bAxvEkDM47Hzq0LMqRV3OtJGj8pwwav/XVNSn
 DKF4cJ3zQt0PGHIkW75XyIcf7Gn3upLOLghT1k2LApfxUxhZj/6IpWe8P
 c4poHfhUOcLWmhgQX+AgCc/87ssYyXfgiKX0b9RtlxXEHr9TqqQoZHsS9
 ZDFu7zAkRF5vlWlf2L5hkHneDCH6gb/e/fgzxt8fx+x0Uznd/3afK/jDt A==;
X-CSE-ConnectionGUID: 50R3mDASTt6tP+rxlnynlw==
X-CSE-MsgGUID: oRwcrzmrQEi9oc/dseyCWg==
X-IronPort-AV: E=McAfee;i="6800,10657,11866"; a="97183169"
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="97183169"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 00:21:28 -0700
X-CSE-ConnectionGUID: oIcILpRFSPa4QL0MQyKrFQ==
X-CSE-MsgGUID: gixYJ+62R4u/OTzDVNZ2CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,208,1779174000"; d="scan'208";a="259402606"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Aug 2026 00:21:29 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 00:21:28 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 6 Aug 2026 00:21:28 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.64) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 6 Aug 2026 00:21:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FF8WNLrEMP5u/rW5etYAhT3eBLlHYPfVKgDH4Qp1pYPn+JasGIR+J/IJ8ieVu0C11qs/rbcoTyZrBklnn+zd76OEowXeFuckTC1OoegyTEy0lIdsg2PyoQp09AltlLPP+lgbTCx4c5AoxKYH4vs8Y2qtp6gr31sqoOgJvoDTaJYnflji6KqKeyAe7oCWH6Ni7H34wOT/O2aSEfeFwEgZLqKhdsuiJUjOj+K6vdlmME1HOytr3ZakordhihiUJBZaguxccQ6LNiBt8EvO1q+V9Rlh0EFOum3lP2bBt/R9pXXS1E0UZJ8yJGh1oKd/w0E4vVsVhKgInyVED5TRuCuBgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z1f2c+JiA7iRuMrXO0xZPUw48Fjc7TXSWYAlY5kzw2A=;
 b=F7ktUfQuXWCQm2wmWQcsIlj921GFkISuDnVEXOPw3tHxY5qvaLjGaMzifcslB5WYBHwqIbF1KfpoGwa6BuTuvNPzVqB9Ymq+GW1fDjEJK4Eo8nxRRjWcUtHe/MQY4uD0lVP+kRPOV+iiveZr1o0y8dyDCt2DtT14c9wTz94HInXUUgkHtmCqYetk14Vxv4Wakg17QAm+DcViCzsusR0vxSskfM2k95Qjri5VGILBwyKj2j0uafaiXp4Bj6M0QuMu0kyGBJJkuVRFqCpg6ykjngR4ydv+kMCwNONXziFvwDr9s1RRxgLpJzB8rClFzr6aWYJLzS9Lhv/rwZRTPFOqOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by CY8PR11MB7778.namprd11.prod.outlook.com (2603:10b6:930:76::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Thu, 6 Aug
 2026 07:21:25 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0292.018; Thu, 6 Aug 2026
 07:21:24 +0000
Date: Thu, 6 Aug 2026 00:21:21 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v2] drm/pagemap: Prevent double migration of device pages
Message-ID: <anQ18Qf81SAc0PVY@gsse-cloud1.jf.intel.com>
References: <20260806061126.1499149-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806061126.1499149-1-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4PR03CA0156.namprd03.prod.outlook.com
 (2603:10b6:303:8d::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|CY8PR11MB7778:EE_
X-MS-Office365-Filtering-Correlation-Id: cd9a1630-bea2-4335-9eec-08def38b52ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|10067099003|11063799006|56012099006|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info: 8+e1kiFeifcpllVjH/jXAxYWDRvEiqR5yJHk+jKPMcs2JEIFo7YzoAavvj1Rd3cq/AGcXI+rImemIK7Eo+EqUmWYztOY0lXFnI8WoM7fqBUMJ3YSUsNcaDfeLqrzHCAx50xFk/2VqGv4cGbJWdlgWaG7gfKJPmwfDny8d7Xlbs3wi7XGnIPeLPldK9cnK6rE6gLs7lUIQemCnMiA/VY5yOXqQPtvVixrzQEt5MN/bZzUJcUAxiuxfXBO/1usNoOPCHX13FoOTc3HsDfBFQ/tFVa/j2bOquEetmuez01IVkbw1CJhteBsVsxEWroDgH9ZsYycG9X8JN4Xz+33gCOS1gTYnbGeq6nCrCqNho8fKpR/EguDotR/5L4DyBFXi0LHnN3AgVGnf3kUSZx4c2H69qfoaLt7kjvKFa5whdJGhWcKBYlcGuCdQCnNx1cnA/UpYiNPyr0YPZLuEo+P+XVnrNfTYoLjpN3MHJ1zHwmg/46GYq6nlsAT4i1FL/sDAXU91fSgs2ZErksNBnMxyGrma7mjcqNDNfZup+/LgWxjT3J0EEtIbBLcsbBAjLgkxFsMWEjIvN+hrdUYsIALjLo6ZblJDnIc+0xi1uAR0id7tbc=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?jhiMFE5e4fcXTJ+r/ZUsiBIabRvCr4WF9t9qJMGDvR5/em/WnDs5nCcQyJ?=
 =?iso-8859-1?Q?zxoVWy4qdjd0HKohD5OM2ejI9MLkQdeye9UGD7WcLesc5FNKEj2HeTQRvz?=
 =?iso-8859-1?Q?67ITkhrErmBJCQBJMBqJMf2ev61K9QU0ITBjy9i+UILEi79IPX8GGHIb4A?=
 =?iso-8859-1?Q?gF2awhQ9K/NMqZlhw9Ucz2OK1jBCn32plB7oWJTSNBYJ7ndrN/zXsWQMKH?=
 =?iso-8859-1?Q?BGr6F9tabZgVKYuZ5mxYjmo9IYhtkIBJYIoUkJHPpyXu7LktGqovIRaOwL?=
 =?iso-8859-1?Q?aC7vSZAFv1JjSRrJu822GeUVC/eH+lE/K1/u0yp0GnQZbc2AX1XY3qs7j6?=
 =?iso-8859-1?Q?KHa3vd9/bq35NprZVVBtorOtcAcjQxhRWjPHhVykFU902FIA+9rdhmWFL2?=
 =?iso-8859-1?Q?C0uKzmi/YR53XkTiD8HoH5MMHAEWi41s3kvsOkSJqNRR7MWBysJj7n5Itu?=
 =?iso-8859-1?Q?pwY/7rApNDPdzC6ahTpRePR2GYhMFetsIhymS4xatt63VYoyRxgsGE8T3M?=
 =?iso-8859-1?Q?vaWRmYq86xMErf58yi7jsGfjyiWhBqSBCTV99FfN4xvjOKRxdr7jii8nKW?=
 =?iso-8859-1?Q?NtJVhtoN8tsQWPt0Ei+oltIy/+aAgePxojQPFrcU89Ez6pAYBNaTLM26Ii?=
 =?iso-8859-1?Q?1PVGQBAhFrCPH4D0BL6hFexInyFtBrDyByYZWuVgbovqmjP06slnLd3Gfo?=
 =?iso-8859-1?Q?qZupJBHhncVS5WiwLDVYBudr79w1n9mOnRslpSaM8HycsvhpBRNxQbMkG7?=
 =?iso-8859-1?Q?4Fn3+Og6cJngouki9p3lYYL0ODERrJHOe97dxzbKVzBWZYaItLElTxNU+4?=
 =?iso-8859-1?Q?rSlGjMaQX2epQhGLPAfXM9YIFzzq+Xm+hazdlm7gAjqxR7P1QdqEuPBcix?=
 =?iso-8859-1?Q?jpQ7ves9r9axN6WZtoiVlDv+Ji86bhz8Sjpvm2v4er37Tyyx60/S1xJwFq?=
 =?iso-8859-1?Q?V11IUJfpjc+GCyyLgIecuXr/DNX3Nv3WcZ4TqtRrMWfYObVuB4ygwzss5N?=
 =?iso-8859-1?Q?qadhtlGgeabhxERdlHKC/pl8TYgUY9IssGtkLMBnBUsL0vr5m87HiXslU4?=
 =?iso-8859-1?Q?cHOMY8kIWpDekRpJkqvBL4LOk+rLEDqC4f2oJ3rzXo2g5dZkutQ9ObhUdj?=
 =?iso-8859-1?Q?uYHx2eJW84zwvYwb5jXxlywS3CvYQgsvFqQ7iCq6E25wKRNfJ91guMqXfy?=
 =?iso-8859-1?Q?cLlSSu7G0Wc4Q2Nj2JV4Yl4L+QLo51Q+9THRfupYpPef45U4LTy9Sm1bEl?=
 =?iso-8859-1?Q?FZBUgyFvHzlLKJRlAwEUO1JPyov+Q1iU+g6TieJCipe6AtgrkIV23kXDFY?=
 =?iso-8859-1?Q?4rOeOVEZKeUpHWWYyp7bvzsnIr0VBulU7ncQlYBHt11VdU6jHMfS50RSrC?=
 =?iso-8859-1?Q?mi2d9QLIWlV+NdjU47FwuLQjuQ9vXe5DJr/ysoobsv7ishKx/gm2eJFRPx?=
 =?iso-8859-1?Q?D52pbz0R+g2LSZiwya3csRktP2LfrV4ckDCnve/lcAAtsMP1FvBFvfXvaC?=
 =?iso-8859-1?Q?pnmNqNqsH5NRxJbHSSFcNK1AI+Goc5bjcxEnFw+3AxQ7RMqlZrzKSHCYgo?=
 =?iso-8859-1?Q?UJFI8c6scL0AeVNprajm+vqsJgy8Ah8P7hkmmN4LRlfDkfhAuEsNBzvwx1?=
 =?iso-8859-1?Q?HU2UsubI/zt9BxGBH72/NP8J2MIvXrl85uB39vHQep2puRIwRNb3cASlhp?=
 =?iso-8859-1?Q?uGX+komkKxyYJID2Tbj1913G+Yd5F+YyzOaJgwZco8spmYfn6zToUGAgAb?=
 =?iso-8859-1?Q?z5vhqvkiIBl5O0kq49nmhp6rLL6GeQ3hLjwU0vzfWNRvPRpfBPv6LXOwbT?=
 =?iso-8859-1?Q?KSCc4iWtGw=3D=3D?=
X-Exchange-RoutingPolicyChecked: rL99kqDquzXNtH3Fxru/Q6FKWht8vOxN4vofCzgOhNa8ZrKqotVrVlMwITjd6uclXmYnB82CbaEQXziTdwqbdEfyK5567M1n895lwdNe4cGkaq0kIFFlLSUoaqLa05eBoPmbAyEmduxpAFk5Di9aVvZz7Szgc9GAc/rvZHvXfmUXZUSrdQ6mA1pln3xYTU16L7vGATTHSJrVHV4T7XYlRyGPIFaljNTWXdPSrvLn2xzOKG+e0js9wDOCXFaz8jwcgyjMF/VeDY5ooen/xJB7lorhUnk0ILzLtiUwg3O2DKi315K9QRlVcrk/icySGZd95DUK2RC+HSExukYkB9R7ag==
X-MS-Exchange-CrossTenant-Network-Message-Id: cd9a1630-bea2-4335-9eec-08def38b52ae
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2026 07:21:24.8408 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aVwkFp7wKbFDJom28HP0OMDRdQNU5Wxdn440syXDC+ZuaLa9ZoavimPyEjm5heL7PsUG9PUzgTEJ1F4ePSQMsg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7778
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

On Thu, Aug 06, 2026 at 11:41:26AM +0530, Arvind Yadav wrote:
> A device page migrated to system memory by a CPU fault can remain
> referenced after migration completes. During this window, raw-PFN
> eviction can collect the same device PFN and migrate it again.
> 
> The first migration has already transferred the memcg charge from the
> source folio. Migrating that source again can create an uncharged system
> folio. Adding such a folio to the LRU can spin indefinitely in
> folio_lruvec_lock_irqsave(), causing a soft lockup and an RCU stall.
> 
> Track successful device-page migrations in an allocation-relative bitmap
> stored in drm_pagemap_zdd. Record successful migrations before finalize
> unlocks and drops the migration reference on the source.
> 
> Make raw-PFN eviction skip retired folios. Record raw-PFN migrations as
> well so an eviction retry cannot select a folio migrated by an earlier
> pass.
> 
> Mark every base-page bit covered by a migrated folio so the retirement
> state remains valid if the source folio is later split.
> 
> v2:
> - Replace the retired-PFN XArray with an embedded bitmap.(Matthew Brost)
> - Mark every base page covered by a migrated folio so retirement remains
>   valid if the folio is later split.
> 
> The lockup was observed as:
> ==============================
> [10109.860465] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [kworker/u65:5:6557]
> [10109.860508] irq event stamp: 308085402
> [10109.860508] hardirqs last  enabled at (308085401): [<ffffffff829571e1>] _raw_spin_unlock_irqrestore+0x51/0x80
> [10109.860514] hardirqs last disabled at (308085402): [<ffffffff8293dd71>] sysvec_apic_timer_interrupt+0x11/0xc0
> [10109.860516] softirqs last  enabled at (307538534): [<ffffffff813d111b>] __irq_exit_rcu+0xdb/0x1c0
> [10109.860519] softirqs last disabled at (307538529): [<ffffffff813d111b>] __irq_exit_rcu+0xdb/0x1c0
> [10109.860521] CPU: 9 UID: 0 PID: 6557 Comm: kworker/u65:5 Kdump: loaded Tainted: G S         O        7.2.0-rc3-lgci-xepurge-
> [10109.860524] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
> [10109.860524] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
> [10109.860525] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
> [10109.860644] RIP: 0010:_raw_spin_unlock_irqrestore+0x57/0x80
> [10109.860647] Code: 00 75 1c 65 ff 0d 69 ee 84 01 74 20 5b 41 5c 5d 31 c0 31 d2 31 c9 31 f6 31 ff c3 cc cc cc cc e8 8f 2e c9
> [10109.860648] RSP: 0018:ffffc9000c017030 EFLAGS: 00000246
> [10109.860649] RAX: 0000000000000000 RBX: ffff8881012c00d0 RCX: 0000000000000000
> [10109.860650] RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
> [10109.860650] RBP: ffffc9000c017040 R08: 0000000000000000 R09: 0000000000000000
> [10109.860651] R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000246
> [10109.860651] R13: ffffc9000c0170a0 R14: ffff8881012c00d0 R15: ffff88810e9e6f00
> [10109.860652] FS:  0000000000000000(0000) GS:ffff8888db2f2000(0000) knlGS:0000000000000000
> [10109.860653] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [10109.860653] CR2: 00007a26c0e00048 CR3: 00000001f366d006 CR4: 0000000000f72ef0
> [10109.860654] PKRU: 55555554
> [10109.860655] Call Trace:
> [10109.860655]  <TASK>
> [10109.860657]  folio_lruvec_lock_irqsave+0x216/0x220
> [10109.860661]  ? __pfx_lru_add+0x10/0x10
> [10109.860665]  folio_batch_move_lru+0xc8/0x450
> [10109.860670]  ? lock_acquire+0xc4/0x2d0
> [10109.860674]  ? __folio_batch_add_and_move+0x60/0x2e0
> [10109.860677]  ? folio_migrate_mapping+0xa6/0x110
> [10109.860679]  ? folio_migrate_flags+0x13b/0x1b0
> [10109.860681]  ? __pfx_lru_add+0x10/0x10
> [10109.860683]  __folio_batch_add_and_move+0xe7/0x2e0
> [10109.860685]  ? dma_iova_try_alloc+0xb0/0x140
> [10109.860689]  folio_add_lru+0x64/0x80
> [10109.860691]  __migrate_device_finalize+0x12c/0x270
> [10109.860695]  migrate_device_finalize+0x10/0x20
> [10109.860698]  drm_pagemap_evict_to_ram+0x185/0x370 [drm_gpusvm_helper]
> [10109.860704]  ? drm_pagemap_evict_to_ram+0x96/0x370 [drm_gpusvm_helper]
> [10109.860709]  xe_svm_bo_evict+0x15/0x20 [xe]
> [10109.860819]  ? xe_svm_bo_evict+0x15/0x20 [xe]
> [10109.860921]  xe_bo_move+0x107e/0x1570 [xe]
> [10109.860992]  ? xe_ttm_tt_create+0x168/0x340 [xe]
> [10109.861059]  ? __up_read+0x98/0x2b0
> [10109.861061]  ? lock_is_held_type+0xa3/0x130
> [10109.861067]  ttm_bo_handle_move_mem+0xe8/0x1e0 [ttm]
> [10109.861075]  ttm_bo_evict+0x141/0x1c0 [ttm]
> [10109.861081]  ttm_bo_evict_cb+0x9f/0x100 [ttm]
> [10109.861086]  ttm_lru_walk_for_evict+0x84/0x190 [ttm]
> [10109.861091]  ? xe_ttm_vram_mgr_new+0x258/0x3a0 [xe]
> [10109.861198]  ttm_bo_alloc_resource+0x219/0x750 [ttm]
> [10109.861203]  ? ttm_bo_alloc_resource+0xa9/0x750 [ttm]
> [10109.861208]  ? lock_acquire+0xc4/0x2d0
> [10109.861214]  ttm_bo_validate+0x94/0x1c0 [ttm]
> [10109.861218]  ? ww_mutex_trylock+0x19d/0x3d0
> [10109.861219]  ? _raw_write_unlock+0x22/0x50
> [10109.861223]  ttm_bo_init_reserved+0x17d/0x1f0 [ttm]
> [10109.861228]  xe_bo_init_locked+0x20a/0x620 [xe]
> [10109.861294]  ? __pfx_xe_ttm_bo_destroy+0x10/0x10 [xe]
> [10109.861359]  ? mark_held_locks+0x46/0x90
> [10109.861361]  ? __create_object+0x68/0xc0
> [10109.861366]  __xe_bo_create_locked+0x384/0xa20 [xe]
> [10109.861432]  ? lock_acquire+0xc4/0x2d0
> [10109.861434]  ? xe_drm_pagemap_populate_mm+0xd3/0x340 [xe]
> [10109.861542]  xe_bo_create_locked+0x23/0x40 [xe]
> [10109.861609]  xe_drm_pagemap_populate_mm+0x12e/0x340 [xe]
> [10109.861707]  ? __lock_acquire+0x43e/0x2930
> [10109.861716]  drm_pagemap_populate_mm+0x74/0xe0 [drm_gpusvm_helper]
> [10109.861720]  xe_svm_alloc_vram+0xb5/0x2c0 [xe]
> [10109.861817]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
> [10109.861819]  ? ktime_get+0x23/0x130
> [10109.861821]  ? trace_hardirqs_on+0x22/0xe0
> [10109.861823]  ? seqcount_lockdep_reader_access.constprop.0+0x9f/0xc0
> [10109.861826]  __xe_svm_handle_pagefault+0x77d/0xbf0 [xe]
> [10109.861924]  ? rwsem_down_write_slowpath+0x43a/0x9a0
> [10109.861926]  ? _raw_spin_unlock_irq+0x27/0x70
> [10109.861928]  ? rwsem_down_write_slowpath+0x43a/0x9a0
> [10109.861929]  ? trace_hardirqs_on+0x22/0xe0
> [10109.861931]  ? _raw_spin_unlock_irq+0x27/0x70
> [10109.861933]  ? rwsem_down_write_slowpath+0x459/0x9a0
> [10109.861937]  xe_svm_handle_pagefault+0x3d/0xb0 [xe]
> [10109.862030]  xe_pagefault_queue_work+0x1a9/0x520 [xe]
> [10109.862122]  process_one_work+0x239/0x730
> [10109.862127]  worker_thread+0x200/0x3f0
> [10109.862130]  ? __pfx_worker_thread+0x10/0x10
> [10109.862132]  kthread+0x10d/0x150
> [10109.862133]  ? __pfx_kthread+0x10/0x10
> [10109.862135]  ret_from_fork+0x3bd/0x470
> [10109.862138]  ? __pfx_kthread+0x10/0x10
> [10109.862140]  ret_from_fork_asm+0x1a/0x30
> [10109.862146]  </TASK>
> 
> Fixes: 99624bdff867 ("drm/gpusvm: Add support for GPU Shared Virtual Memory")
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/drm_pagemap.c | 143 ++++++++++++++++++++++++++++++++--
>  1 file changed, 136 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 7a056592ac66..713095e27006 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -7,6 +7,7 @@
>  #include <linux/dma-mapping.h>
>  #include <linux/migrate.h>
>  #include <linux/pagemap.h>
> +#include <linux/bitmap.h>
>  #include <drm/drm_drv.h>
>  #include <drm/drm_pagemap.h>
>  #include <drm/drm_pagemap_util.h>
> @@ -66,6 +67,12 @@
>   * @refcount: Reference count for the zdd
>   * @devmem_allocation: device memory allocation
>   * @dpagemap: Refcounted pointer to the underlying struct drm_pagemap.
> + * @range_start: Virtual start address of the device memory allocation. Used to
> + * translate a clipped CPU-fault range into an allocation-relative page offset.
> + * @range_npages: Number of pages covered by the allocation, i.e. the number of
> + * valid bits in @retire_map.
> + * @retire_map: Allocation-relative bitmap. Every base page covered by a
> + * migrated folio remains marked until this mapping generation is destroyed.
>   *
>   * This structure serves as a generic wrapper installed in
>   * page->zone_device_data. It provides infrastructure for looking up a device
> @@ -78,29 +85,38 @@ struct drm_pagemap_zdd {
>  	struct kref refcount;
>  	struct drm_pagemap_devmem *devmem_allocation;
>  	struct drm_pagemap *dpagemap;
> +	unsigned long range_start;

Sashiko pointed this out as well: you can't store anything virtual in a
ZDD because it represents a physical object. The range_start may or may
not be the same by the time a fault occurs.

> +	unsigned long range_npages;

devmem_allocation->size can derive the number of pages.

> +	unsigned long retire_map[];

This won't be needed or any changes to the zdd actually, more below.

>  };
>  
>  /**
>   * drm_pagemap_zdd_alloc() - Allocate a zdd structure.
>   * @dpagemap: Pointer to the underlying struct drm_pagemap.
> + * @start: Virtual start address of the device memory allocation.
> + * @npages: Number of pages in the device memory allocation.
>   *
>   * This function allocates and initializes a new zdd structure. It sets up the
> - * reference count and initializes the destroy work.
> + * reference count and a zeroed retirement bitmap sized for @npages.
>   *
> - * Return: Pointer to the allocated zdd on success, ERR_PTR() on failure.
> + * Return: Pointer to the allocated zdd on success, NULL on failure.
>   */
>  static struct drm_pagemap_zdd *
> -drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap)
> +drm_pagemap_zdd_alloc(struct drm_pagemap *dpagemap, unsigned long start,
> +		      unsigned long npages)
>  {
>  	struct drm_pagemap_zdd *zdd;
>  
> -	zdd = kmalloc_obj(*zdd);
> +	zdd = kzalloc(struct_size(zdd, retire_map, BITS_TO_LONGS(npages)),
> +		      GFP_KERNEL);
>  	if (!zdd)
>  		return NULL;
>  
>  	kref_init(&zdd->refcount);
>  	zdd->devmem_allocation = NULL;
>  	zdd->dpagemap = drm_pagemap_get(dpagemap);
> +	zdd->range_start = start;
> +	zdd->range_npages = npages;
>  
>  	return zdd;
>  }
> @@ -669,7 +685,7 @@ int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  	pagemap_addr = buf + (2 * sizeof(*migrate.src) * npages);
>  	pages = buf + (2 * sizeof(*migrate.src) + sizeof(*pagemap_addr)) * npages;
>  
> -	zdd = drm_pagemap_zdd_alloc(dpagemap);
> +	zdd = drm_pagemap_zdd_alloc(dpagemap, start, npages);
>  	if (!zdd) {
>  		err = -ENOMEM;
>  		kvfree(buf);
> @@ -1102,12 +1118,115 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
>  }
>  EXPORT_SYMBOL(drm_pagemap_put);
>  
> +/**
> + * drm_pagemap_is_devmem_page() - Check whether a page is device memory
> + * @page: page to check
> + *
> + * Return: true if @page is device-private or device-coherent
> + */
> +static bool drm_pagemap_is_devmem_page(const struct page *page)
> +{
> +	return is_device_private_page(page) || is_device_coherent_page(page);
> +}
> +
> +/**
> + * drm_pagemap_retire_migrated_pages() - Record migrated device folios
> + * @src_pfns: source array after migrate_vma_pages() or migrate_device_pages()
> + * @npages: number of entries in @src_pfns
> + * @first: allocation-relative page offset of @src_pfns[0]
> + *
> + * Record successful migrations in the zdd retirement bitmap before finalize
> + * unlocks the sources. The bit is set only after a confirmed migration, and
> + * test_and_set_bit() is used because concurrent CPU faults on clipped ranges
> + * can update different bits in the same word.
> + */
> +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
> +					      unsigned long npages,
> +					      unsigned long first)
> +{
> +	unsigned long i = 0;
> +
> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		struct drm_pagemap_zdd *zdd;
> +		unsigned long bit, j, nr = 1;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		nr = folio_nr_pages(page_folio(page));
> +
> +		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> +		    !drm_pagemap_is_devmem_page(page))
> +			goto next;
> +
> +		zdd = drm_pagemap_page_zone_device_data(page);
> +		bit = first + i;
> +
> +		if (WARN_ON_ONCE(bit >= zdd->range_npages ||
> +				 nr > zdd->range_npages - bit))
> +			goto next;
> +
> +		/* Keep later folio splits covered. */
> +		for (j = 0; j < nr; j++)
> +			WARN_ON_ONCE(test_and_set_bit(bit + j, zdd->retire_map));
> +next:
> +		i += nr;
> +	}
> +}
> +
> +/**
> + * drm_pagemap_skip_retired_pages() - Drop retired PFNs from a raw-PFN eviction
> + * @src_pfns: source array after migrate_device_pfns() (MIGRATE_PFN encoded)
> + * @npages: number of entries in @src_pfns
> + *
> + * Skip source PFNs already migrated to RAM by either migration path. The
> + * raw-PFN eviction array starts at allocation offset zero, so the array index
> + * is also the retirement bitmap index.
> + */
> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
> +					   unsigned long npages)
> +{
> +	unsigned long i = 0;
> +
> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		struct drm_pagemap_zdd *zdd;
> +		unsigned long nr = 1;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		nr = folio_nr_pages(page_folio(page));
> +
> +		if (!(src_pfns[i] & MIGRATE_PFN_MIGRATE) ||
> +		    !drm_pagemap_is_devmem_page(page))
> +			goto next;
> +
> +		zdd = drm_pagemap_page_zone_device_data(page);
> +		if (WARN_ON_ONCE(i >= zdd->range_npages)) {
> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +			goto next;
> +		}
> +
> +		if (test_bit(i, zdd->retire_map))
> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +next:
> +		i += nr;
> +	}
> +}
> +
>  /**
>   * drm_pagemap_evict_to_ram() - Evict GPU SVM range to RAM
>   * @devmem_allocation: Pointer to the device memory allocation
>   *
> - * Similar to __drm_pagemap_migrate_to_ram but does not require mmap lock and
> - * migration done via migrate_device_* functions.
> + * Similar to __drm_pagemap_migrate_to_ram(), but uses the
> + * migrate_device_* helpers and does not require the mmap lock. Device
> + * PFNs already migrated to RAM by either migration path are skipped.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> @@ -1149,6 +1268,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err)
>  		goto err_free;
>  
> +	drm_pagemap_skip_retired_pages(src, npages);
> +
>  	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
>  						   src, dst, 0);
>  	if (err || !mpages)
> @@ -1179,6 +1300,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, dst);
>  	migrate_device_pages(src, dst, npages);
> +	/* Raw-PFN eviction: array starts at allocation offset zero. */
> +	drm_pagemap_retire_migrated_pages(src, npages, 0);
>  	migrate_device_finalize(src, dst, npages);
>  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
>  					DMA_FROM_DEVICE, &state);
> @@ -1251,6 +1374,10 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	if (end > vas->vm_end)
>  		end = vas->vm_end;
>  
> +	/* Keep the range within the ZDD allocation so retirement offsets stay valid. */
> +	start = max(start, zdd->range_start);
> +	end = min(end, zdd->range_start + (zdd->range_npages << PAGE_SHIFT));

Hmm, I guess this tricky if this partially unmapped or meremapped to a
different address, so we need to keep this purely physical.

New idea - store the migration state in folio itself in the private
data in lowest bits of folio->page.zone_device_data (set in
folio_set_zone_device_data) and mask if off in
drm_pagemap_page_zone_device_data.

e.g.,

#define DRM_PAGEMAP_ZDD_FLAG_MIGRATED	BIT(0)
#define DRM_PAGEMAP_ZDD_FLAG_MASK	0x1ull	/* we can expand this to 0x7 on 64 builds if we need more flags */

static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct page *page)
{
        struct folio *folio = page_folio(page);

	/* XXX: Plus whatever casting needed */
        return folio_zone_device_data(folio) & ~DRM_PAGEMAP_ZDD_FLAG_MASK;
}

static void drm_pagemap_page_set_flags(struct page *page, unsigned long flags)
{
        struct folio *folio = page_folio(page);
	struct drm_pagemap_zdd *zdd = drm_pagemap_page_zone_device_data(page);

	WARN_ON_ONCE(flags & ~DRM_PAGEMAP_ZDD_FLAG_MASK);
	folio_set_zone_device_data(folio, zdd | flags);
}

static unsigned long drm_pagemap_page_get_flags(struct page *page)
{
        struct folio *folio = page_folio(page);

	/* XXX: Plus whatever casting needed */
        return folio_zone_device_data(folio) & DRM_PAGEMAP_ZDD_FLAG_MASK;
}

drm_pagemap_retire_migrated_pages()
	for_each_page_migrated
		drm_pagemap_page_set_flags(page, DRM_PAGEMAP_ZDD_FLAG_MIGRATED);

drm_pagemap_skip_retired_pages gets the flags, skips any folio with
DRM_PAGEMAP_ZDD_FLAG_MIGRATED set.

I think this will work and keep everything in the physical world.

Also btw, some of Sashiko pre-existing which have been flagged are fixed
in this series: https://patchwork.freedesktop.org/series/171651/

Matt

> +
>  	migrate.start = start;
>  	migrate.end = end;
>  	npages = npages_in_range(start, end);
> @@ -1309,6 +1436,8 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>  	migrate_vma_pages(&migrate);
> +	drm_pagemap_retire_migrated_pages(migrate.src, npages,
> +					  (start - zdd->range_start) >> PAGE_SHIFT);
>  	migrate_vma_finalize(&migrate);
>  	if (dev)
>  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
> -- 
> 2.43.0
> 
