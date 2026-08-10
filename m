Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98989C5AD7B
	for <dri-devel@archiver.kernel.org>; Mon, 10 Aug 2026 19:16:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026FD10E983;
	Mon, 10 Aug 2026 19:16:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="mgWp64DU";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 69BCA10E983;
 Mon, 10 Aug 2026 19:16:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786389396; x=1817925396;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2F5/lxxZlAygvDTSdlkT2Jds4fO9XTdvddSBXyZUaE4=;
 b=mgWp64DUu0EeI+QD04dc5tcSRPQqEJGhj0c6kkCNkZhQHXfYL4afjXUY
 oDCFSmd/LTDx9iDxI8sUp7nyFOu6PKG58jLRXonmixYRL2s7KdA81ld2r
 iem0HRyueONp7miRnNxG/pz8ritJL4UtuSYatTLJHT8J2aVxeDu5gXWO/
 3iH7eEPaBynq5jghutdbDx5PS3KIRBHE+IPIxBroc89z1CjvOJJeH1RHh
 ZnhWaE6FXaj3dhq2O/xd4LiUN6KvoLvV2qYV8NUjI9raPRAIO240fytz0
 2vnfZdm4Qe45xNsBFg8DCO/tMTXtmkeenyCdofDaCk3+9OIlOXyKdbZV/ g==;
X-CSE-ConnectionGUID: qOghjDVsSWKt+pTSx14AuQ==
X-CSE-MsgGUID: MkIqUMA/SUucMlmi1byGKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11871"; a="90593066"
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; d="scan'208";a="90593066"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 12:16:36 -0700
X-CSE-ConnectionGUID: Wh9yJHgMTxKsPHJlujFDjw==
X-CSE-MsgGUID: 4UF7dEoAQo6nL3Bu1gwDiQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,216,1779174000"; d="scan'208";a="266615035"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Aug 2026 12:16:36 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 12:16:35 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Mon, 10 Aug 2026 12:16:35 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.51) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Mon, 10 Aug 2026 12:16:34 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOZXrJkRWg0qbAoBktQr6TlTPpKYJv+OfEfY482bbHeoyMurF6VXVEf48L+0fQNOCWNkLmy+QozGwKnckbOTW9s8YyjwszEyq8soypunWLuqWp90B5fIULFbSY9ncwEIfO0IroYesB7sjTb7ZxGKC3S5/lKbltkDpyfEqU//vr929urOUeUZctDgiMm9tvfPDbsibo9DXtc72WZoctM78D3HiTlRiT4NFwMA92w0P+OuRM/1qE8gLxFuHTKFl3tGPcJ6S2UZzQ11lgh7Pxbu0NBdnGZKByuOmgcB5Qy60ZGNprhJC3erB6nCLcLCkm2GFtIbD+MAj0HMMXGMk0/fog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Raafac+kHWPJXY59vJrPGjnowGUmkHclXnaqxQ1eru8=;
 b=U+DfCpHrh3vp2GvREIOwEKcjugQASX8sXzQCRVwrYfkze7A11BGLp3HLPrC9YO0/T3G2PfU3mzhFCQycWa5LsrlhkO3Ee78btlTKgeH10CnuuOXzfThG3C73yLaTgbcKUmUQc6tywjPBuO20O49RjSuL5bouN6c+gpqqqrd0XZqPiYLKBvtMl+CcvyVFVoHD/Srx/QzqW9bmK2/rWkvAzNVrtBfXtYFne4fYhAkZpWv8trP7ykfJTSwus2eIY1V9VMaCmfvERPriXk+f5ATne393ggZ3G1/U/Ohwls6C5lc2eJ5CTAifo+xbi5H4xAg03Qbw6+HXDp3KNzUNpL7jNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM3PR11MB8760.namprd11.prod.outlook.com (2603:10b6:0:4b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 19:16:30 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 19:16:30 +0000
Date: Mon, 10 Aug 2026 12:16:27 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <dri-devel@lists.freedesktop.org>, <intel-xe@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <thomas.hellstrom@linux.intel.com>,
 <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <himal.prasad.ghimiray@intel.com>
Subject: Re: [PATCH v6] drm/pagemap: Prevent double migration of device pages
Message-ID: <anoji9hN/ifeoMwl@gsse-cloud1.jf.intel.com>
References: <20260810092845.2776097-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260810092845.2776097-1-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4P221CA0005.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:303:8b::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM3PR11MB8760:EE_
X-MS-Office365-Filtering-Correlation-Id: 42aa2396-2504-47e7-d5b4-08def713e231
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|6133799003|3023799007|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: neDG2eYIWoZ53Q0AgFGkaUCo+ne1JSHN26xAMYIEx5Sp2mH2yhP6PhkbsP3YwtjVgg4aqRAGJH992M1Si/wv9nTjtDSWpXayK1+nBFOX4Kn3O9Q/JsVBe26ZuCIEXSJa4ogz2f3IK5HC37BMvFzuSlKKqVbAaG4tnQEqxNj/ecRCx6Jxyhiu/GJxxXtqEY6I3+v/lKKG9/1Ay0imK/MRDBIGoGhEeGdCFxmWbU451fVM9079AR/6fY7ENPnl6WcbybmRoyw5NNysYdHCsGtdXRFPgp5GnAzQTa0xBdL3OVKVtW65II5wa52yRNGQWOiNxvt4eHa7M3niM5M8aH5GD/IUcEp/MIxu16H1rDg7H4wacQIxH5jJ4MXL4Ypgb1kkrGZIqL1RmHgwmm1MOocqij7phCciYVojQ5vUIQ1EntH86arnodZrJdrLEA+7hjKiuMaCFKXBokDi2p8HGc8Z9FiMrmgUxKqfPdn2MkwndkARMeWrah6pSsYVInZnuRl2eK0fi4v9KwRvowg0yLOyFnVCnn+a0wq/LcYGB/dZ2PyUQ4QrG85x1zKqGSWLwCelCeFTH6Vk0YCUvgMrwySBFPqplHU7BnCMBY2wMBZolY26/OQmQDxASeXhkpQt1EjS
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(6133799003)(3023799007)(13003099007)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?+PRTyqIXcYe+cEXW4Kh/CW2EwcWQgxirtgayspYTNYWdFz/27mwQc8gBO/?=
 =?iso-8859-1?Q?HfJxTdgOs6MjAIF6p/FSPjKYqAlAqPntonHmFyVEQtl+H19Xw+b5bv9ObY?=
 =?iso-8859-1?Q?PGooOgbYi4Rzwccr2OvWbTlR+bv5pogD1JniUYT5FBgKdmKDWqbfnfG2+w?=
 =?iso-8859-1?Q?Fx6DkQK/2MYiEGWQ091owVZyLZqB4laz9L5d0x4/7sJrPiLRShe7yhyd2K?=
 =?iso-8859-1?Q?mWXnDARPmqUu0A/Xt3y8MUb/1k4KXGuy4l2WJGr6OamIKnV3LsBkJqbbW8?=
 =?iso-8859-1?Q?mwAhBkVzWUiXUNG+OdjVUJsQWG0s1mNJ9mv76toryzGVtHu7K+HgTK9E3w?=
 =?iso-8859-1?Q?eogJWwsc7YzFXsgAo0YH59U3urGwcdKXdKYmgMsSskn69pi5GvlDGj4Oy1?=
 =?iso-8859-1?Q?AMMuvvLm1RxER7Btw/0YtyW34NqxC97DFpFqx69vNnaXt38lOD0jmr5bLq?=
 =?iso-8859-1?Q?xV9kzlYhbIFlyDVQKOnFTNIq3WhykWN0DY5AQhGkLLUJ4ldxx3Rl1iDiG0?=
 =?iso-8859-1?Q?sE8QZ4qDEeJ4Azm+q4pXEzii0aFodfqnn7Ji7ZGhkGhAPCTuhe7c9ymSqm?=
 =?iso-8859-1?Q?+03aIqW9r3YvdP8lTQHOHn8aqwQQGxJApToAn1rgfij5k+2HAmMQnpfuFq?=
 =?iso-8859-1?Q?Iek0AQqKphL2AvQBMoyc9ZKVlP0feuPhfz75Ayb0EJ5jBI8xd3DX+glBBJ?=
 =?iso-8859-1?Q?NM2uBnyzM3HkSBUh83kbzSIBYkvtVaWDpq9PlDyTxT5cFzOweLstgiCUTw?=
 =?iso-8859-1?Q?lE8m47PojONgOrQ2JUkeQbs+JYIFLpaCNbt3LzT8iuY6QkAFv5A0lmm8hK?=
 =?iso-8859-1?Q?0fPB7/7Ez5NDkcdRhxnmeojBqA0eVGeH5jCHhuhegFbUpczowKS92qit8s?=
 =?iso-8859-1?Q?qZpIVhzlN0GdWT4AQ67L499EtyOid6fRT1Ezb8qq8i92Z8jitJoFu5CQ+6?=
 =?iso-8859-1?Q?vatPsjd76ZkIe0B27KjXcsgJ9seba2R/YPkK8v36Wfm8MJGxji6UoqxWck?=
 =?iso-8859-1?Q?f/K0pJwp73AiLQsQTexbPOX6eKZxXAy8FwQfN+wX15MmICFP2xTvr6BSvF?=
 =?iso-8859-1?Q?q7lx0rcXX5vBhnv0tlQXwbUxk4JUuOT/qj5QnQ4B2uwAV2GhCsosiYtDQ1?=
 =?iso-8859-1?Q?ORAdEEg88f+raXtcq+Rn6Gaq4/KGjpzBlT8defj9zp88+9htj2yov5YQ3j?=
 =?iso-8859-1?Q?rZd8iHz3Qmj5ZXn4tFj5DBHuM5KN8pxo8c/LstzffegsmqZo3Clf5EibtA?=
 =?iso-8859-1?Q?LonxkOVp5Zag6AHlr0ly2KNydHI4KcnACuE9Jq8aklrbtT4kXEXg5jmSbu?=
 =?iso-8859-1?Q?fAXVdnAoNPPVA2JuoezKARMRDCyjgSUODsR94+PuTR+N2M0w/cTGJAu2UA?=
 =?iso-8859-1?Q?JCo/bsg7JVi4MT3CIJaG9qQkR7/ALZCdt/AZ9nhLpY+S6gp34UgznzIUr1?=
 =?iso-8859-1?Q?TQjp6xTE1YY3zUi20X2x24D1IZQfoyAW88709R9pSrfp3h8lSGkNTKo5L3?=
 =?iso-8859-1?Q?tiXLU+iNHyBKhvxR47+p1kqv90mf83/Jj/W2e+YHCywChNKAHKFZyWvPve?=
 =?iso-8859-1?Q?UHIkroG0BogeTL+WtQT+KTWEI9vv/L/Fu3RG7mEQG0P1ThtKyNAHtG2Zml?=
 =?iso-8859-1?Q?tfpW9e6AXicfDUgGNxW2Ju8ncFiKESMxIBLj/3IOzlHikBN9X16JxpP5BG?=
 =?iso-8859-1?Q?fjQ6vY/wZojfW4naOkUkMGPWah5DONKAFOt5Qf+jytOg4LLRjNr2oBwkpn?=
 =?iso-8859-1?Q?ccxfsEREpGU1OL2ct/6VvqxflvEtnpU5AvdypHX+kT20nsG/mBjl4ajiM+?=
 =?iso-8859-1?Q?f4l/GuD8Vw=3D=3D?=
X-Exchange-RoutingPolicyChecked: jWmFT9OqHh2GELHioB8uyrczWxULQxXaUAOpXuzDlZkMQ60rcEcR5G794ffKSBsG/v8S9v4BsyHYKoWVxstBGtX8pigvbqPZfAB3SG/irQYUFSTFMwm5hDxJnEkM5vr2f1PAd3NVUKMgtjhy0e16Ter8x1C2xa8OUiF8A/j8wP9ML+0YGjZHLil+JisRBS3WHK5umXu6pKMICiDI8Ry2r57i0fUX9ui6b2jCFeTrqx/Q2ETU/5QvZVuOnOVKDUCge7bSfLvUbd+qHu1hJ56mIinbdc2xpA2hlsA+AdlzkUZjy/fD3mve00CWXtYRJfUDciU8SdWbXBWVFOtmD16q4Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 42aa2396-2504-47e7-d5b4-08def713e231
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 19:16:30.6577 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9dqWXidTvp7+UTNDMfyRSMEALmHO7u7q3w8U5rwB/5nrfKq8ZA9MWjWTkfup60yxm0ICYN3BI1ZwxAA/vl1LYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8760
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

On Mon, Aug 10, 2026 at 02:58:45PM +0530, Arvind Yadav wrote:
> A device-private folio migrated to system memory by a CPU fault can
> remain reachable through the raw-PFN eviction path until migration
> finalization drops the source reference.
> 
> If eviction selects the same device-private folio during this window,
> it can attempt to migrate the folio again. The second migration can leave
> an uncharged folio on an LRU list, causing folio_lruvec_lock_irqsave() to
> retry indefinitely and resulting in a soft lockup and RCU stall.
> 
> Mark successfully migrated device-private folios using a low bit of
> their zone_device_data before migration finalization. Make both CPU-fault
> and raw-PFN migration paths skip device-private folios carrying this
> flag.
> 
> Mask the flag when retrieving the drm_pagemap_zdd pointer and preserve
> it when a device-private folio is split. Keeping the state on the physical
> folio also avoids depending on a virtual address that may change before a
> fault occurs.
> 
> v2:
> - Replace the retired-PFN XArray with an embedded bitmap. (Matthew Brost)
> - Mark every base page covered by a migrated folio so retirement remains
>   valid if the folio is later split.
> 
> v3:
> - Store the migrated state in a low bit of zone_device_data instead of
>   adding virtual-range and bitmap tracking to the ZDD. (Matthew Brost)
> - Mask the flag when retrieving the ZDD and preserve it when splitting
>   a folio.
> - Drop the pre-existing fixes already covered by Matthew Brost's series:
>   https://patchwork.freedesktop.org/series/171651/
> 
> v4:
> - Advance by the folio size only for migration entries marked with
>   MIGRATE_PFN_COMPOUND. (Sashiko)
> 
> v5:
> - Simplify ZDD flag updates and folio iteration. (Matthew Brost)
> - Skip retired device-private folios in the CPU-fault path. (Matthew Brost)
> - Preserve flag bits while taking a new ZDD reference for split folios.
> 
> v6:
> - Restore MIGRATE_PFN_COMPOUND-aware stepping so non-compound migration
>   entries are processed one at a time. (Sashiko)
> - Drop the pre-existing fixes already covered by Matthew Brost's series:
>   https://patchwork.freedesktop.org/series/171651/
> 
> The lockup was observed as:
> [10109.860465] watchdog: BUG: soft lockup - CPU#9 stuck for 26s! [kworker/u65:5:6557]
> [10109.860524] Tainted: [S]=CPU_OUT_OF_SPEC, [O]=OOT_MODULE
> [10109.860524] Hardware name: ASUS System Product Name/PRIME Z790-P WIFI, BIOS 0812 02/24/2023
> [10109.860525] Workqueue: xe_page_fault_work_queue xe_pagefault_queue_work [xe]
> [10109.860644] RIP: 0010:_raw_spin_unlock_irqrestore+0x57/0x80
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
> Cc: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Matthew Brost <matthew.brost@intel.com>

> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> Assisted-by: Claude:claude-opus-4-8
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> ---
>  drivers/gpu/drm/drm_pagemap.c | 127 ++++++++++++++++++++++++++++++++--
>  include/drm/drm_pagemap.h     |   8 ++-
>  2 files changed, 129 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_pagemap.c b/drivers/gpu/drm/drm_pagemap.c
> index 7a056592ac66..097a900cf55d 100644
> --- a/drivers/gpu/drm/drm_pagemap.c
> +++ b/drivers/gpu/drm/drm_pagemap.c
> @@ -1102,12 +1102,117 @@ void drm_pagemap_put(struct drm_pagemap *dpagemap)
>  }
>  EXPORT_SYMBOL(drm_pagemap_put);
>  
> +/**
> + * drm_pagemap_page_get_flags() - Read flags from a device-private folio
> + * @page: Pointer to a page of the device-private folio
> + *
> + * Return: The DRM_PAGEMAP_ZDD_FLAG_* bits encoded in zone_device_data.
> + */
> +static unsigned long drm_pagemap_page_get_flags(struct page *page)
> +{
> +	struct folio *folio = page_folio(page);
> +
> +	return (unsigned long)folio_zone_device_data(folio) &
> +		DRM_PAGEMAP_ZDD_FLAG_MASK;
> +}
> +
> +/**
> + * drm_pagemap_page_set_flags() - Set flags on a device-private folio
> + * @page: Pointer to a page of the device-private folio
> + * @flags: DRM_PAGEMAP_ZDD_FLAG_* bits to set
> + *
> + * Preserve any flags already encoded alongside the ZDD pointer.
> + */
> +static void drm_pagemap_page_set_flags(struct page *page,
> +				       unsigned long flags)
> +{
> +	struct folio *folio = page_folio(page);
> +	unsigned long old;
> +
> +	if (WARN_ON_ONCE(flags & ~DRM_PAGEMAP_ZDD_FLAG_MASK))
> +		return;
> +
> +	old = (unsigned long)folio_zone_device_data(folio);
> +	folio_set_zone_device_data(folio, (void *)(old | flags));
> +}
> +
> +/**
> + * drm_pagemap_retire_migrated_pages() - Record migrated device-private folios
> + * @src_pfns: source array after migrate_vma_pages() or migrate_device_pages()
> + * @npages: number of entries in @src_pfns
> + *
> + * Flag device-private folios successfully migrated to RAM before finalize
> + * unlocks the sources. The migrated state is stored in the physical folio, so
> + * it survives later folio splits and subsequent migrations can skip it.
> + */
> +static void drm_pagemap_retire_migrated_pages(unsigned long *src_pfns,
> +					      unsigned long npages)
> +{
> +	unsigned long i = 0;
> +
> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		unsigned long nr = 1;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		if (src_pfns[i] & MIGRATE_PFN_COMPOUND)
> +			nr = folio_nr_pages(page_folio(page));
> +
> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +		    is_device_private_page(page))
> +			drm_pagemap_page_set_flags(page,
> +						   DRM_PAGEMAP_ZDD_FLAG_MIGRATED);
> +
> +		i += nr;
> +	}
> +}
> +
> +/**
> + * drm_pagemap_skip_retired_pages() - Skip retired device-private folios
> + * @src_pfns: MIGRATE_PFN-encoded source array
> + * @npages: number of entries in @src_pfns
> + *
> + * Skip source folios already migrated to RAM, identified by the migrated flag
> + * stored in the physical folio's zone_device_data.
> + */
> +static void drm_pagemap_skip_retired_pages(unsigned long *src_pfns,
> +					   unsigned long npages)
> +{
> +	unsigned long i = 0;
> +
> +	while (i < npages) {
> +		struct page *page = migrate_pfn_to_page(src_pfns[i]);
> +		unsigned long nr = 1;
> +
> +		if (!page) {
> +			i++;
> +			continue;
> +		}
> +
> +		if (src_pfns[i] & MIGRATE_PFN_COMPOUND)
> +			nr = folio_nr_pages(page_folio(page));
> +
> +		if ((src_pfns[i] & MIGRATE_PFN_MIGRATE) &&
> +		    is_device_private_page(page) &&
> +		    (drm_pagemap_page_get_flags(page) &
> +		     DRM_PAGEMAP_ZDD_FLAG_MIGRATED))
> +			src_pfns[i] &= ~MIGRATE_PFN_MIGRATE;
> +
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
> + * migrate_device_* helpers and does not require the mmap lock.
> + * Device-private PFNs already migrated to RAM by either path are skipped.
>   *
>   * Return: 0 on success, negative error code on failure.
>   */
> @@ -1149,6 +1254,8 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err)
>  		goto err_free;
>  
> +	drm_pagemap_skip_retired_pages(src, npages);
> +
>  	err = drm_pagemap_migrate_populate_ram_pfn(NULL, NULL, npages, &mpages,
>  						   src, dst, 0);
>  	if (err || !mpages)
> @@ -1179,6 +1286,7 @@ int drm_pagemap_evict_to_ram(struct drm_pagemap_devmem *devmem_allocation)
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, dst);
>  	migrate_device_pages(src, dst, npages);
> +	drm_pagemap_retire_migrated_pages(src, npages);
>  	migrate_device_finalize(src, dst, npages);
>  	drm_pagemap_migrate_unmap_pages(devmem_allocation->dev, pagemap_addr, dst, npages,
>  					DMA_FROM_DEVICE, &state);
> @@ -1276,13 +1384,15 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	if (!migrate.cpages)
>  		goto err_free;
>  
> +	drm_pagemap_skip_retired_pages(migrate.src, npages);
> +
>  	ops = zdd->devmem_allocation->ops;
>  	dev = zdd->devmem_allocation->dev;
>  
>  	err = drm_pagemap_migrate_populate_ram_pfn(vas, page, npages, &mpages,
>  						   migrate.src, migrate.dst,
>  						   start);
> -	if (err)
> +	if (err || !mpages)
>  		goto err_finalize;
>  
>  	err = drm_pagemap_migrate_map_system_pages(dev, pagemap_addr,
> @@ -1309,6 +1419,7 @@ static int __drm_pagemap_migrate_to_ram(struct vm_area_struct *vas,
>  	if (err)
>  		drm_pagemap_migration_unlock_put_pages(npages, migrate.dst);
>  	migrate_vma_pages(&migrate);
> +	drm_pagemap_retire_migrated_pages(migrate.src, npages);
>  	migrate_vma_finalize(&migrate);
>  	if (dev)
>  		drm_pagemap_migrate_unmap_pages(dev, pagemap_addr, migrate.dst,
> @@ -1361,13 +1472,19 @@ static vm_fault_t drm_pagemap_migrate_to_ram(struct vm_fault *vmf)
>  static void drm_pagemap_folio_split(struct folio *orig_folio, struct folio *new_folio)
>  {
>  	struct drm_pagemap_zdd *zdd;
> +	unsigned long orig_data, new_data;
>  
>  	if (!new_folio)
>  		return;
>  
>  	new_folio->pgmap = orig_folio->pgmap;
> -	zdd = folio_zone_device_data(orig_folio);
> -	folio_set_zone_device_data(new_folio, drm_pagemap_zdd_get(zdd));
> +
> +	orig_data = (unsigned long)folio_zone_device_data(orig_folio);
> +	zdd = (struct drm_pagemap_zdd *)(orig_data & ~DRM_PAGEMAP_ZDD_FLAG_MASK);
> +
> +	new_data = (unsigned long)drm_pagemap_zdd_get(zdd);
> +	new_data |= orig_data & DRM_PAGEMAP_ZDD_FLAG_MASK;
> +	folio_set_zone_device_data(new_folio, (void *)new_data);
>  }
>  
>  static const struct dev_pagemap_ops drm_pagemap_pagemap_ops = {
> diff --git a/include/drm/drm_pagemap.h b/include/drm/drm_pagemap.h
> index 95eb4b66b057..ebbd3b0ddf36 100644
> --- a/include/drm/drm_pagemap.h
> +++ b/include/drm/drm_pagemap.h
> @@ -2,6 +2,7 @@
>  #ifndef _DRM_PAGEMAP_H_
>  #define _DRM_PAGEMAP_H_
>  
> +#include <linux/bits.h>
>  #include <linux/dma-direction.h>
>  #include <linux/hmm.h>
>  #include <linux/memremap.h>
> @@ -339,6 +340,9 @@ struct drm_pagemap_migrate_details {
>  
>  #if IS_ENABLED(CONFIG_ZONE_DEVICE)
>  
> +#define DRM_PAGEMAP_ZDD_FLAG_MIGRATED	BIT(0)
> +#define DRM_PAGEMAP_ZDD_FLAG_MASK	DRM_PAGEMAP_ZDD_FLAG_MIGRATED
> +
>  int drm_pagemap_migrate_to_devmem(struct drm_pagemap_devmem *devmem_allocation,
>  				  struct mm_struct *mm,
>  				  unsigned long start, unsigned long end,
> @@ -373,7 +377,9 @@ static inline struct drm_pagemap_zdd *drm_pagemap_page_zone_device_data(struct p
>  {
>  	struct folio *folio = page_folio(page);
>  
> -	return folio_zone_device_data(folio);
> +	return (struct drm_pagemap_zdd *)
> +		((unsigned long)folio_zone_device_data(folio) &
> +		 ~DRM_PAGEMAP_ZDD_FLAG_MASK);
>  }
>  
>  #else
> -- 
> 2.43.0
> 
