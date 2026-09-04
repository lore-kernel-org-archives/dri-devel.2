Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC0B0C624DE
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 17:13:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC26910E58A;
	Fri,  4 Sep 2026 17:13:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HYF9lota";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 801E110E58A;
 Fri,  4 Sep 2026 17:13:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788542023; x=1820078023;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=02lIpV4HtMJGx2gOaH0NXDExqkxVt0Ane7nPC+lzvTE=;
 b=HYF9lotanjA2nEExZaeSLkjf42vQRKlpACVdVJ6KbSuscbswt0s85AqH
 WYajEay0h7TPmBldEG7dBg7CLNrzxKGBw2eO4a6NRvD+id6JA5GwezEIN
 d33EwIFHc9rcnargTpVCc65FCMUNXZYjn3BNCdyu0t4T3yck3HPk0DppA
 4MBrMhMVHq9LHRaDmN4zmMcMBeEFRFFVSgoq6ivljsHLnkUbxvCVsgaTb
 sxRxQdJDKE0cBLIDfw9OYbCY3W6u81MLFqRV1ZIGIX4cekgx8eL2ABkEy
 iwYrnA5WxAW4DrTjnbebY9VvEkEUMuXCHW6AakT9PWr1qUNZnATp/ZKpD A==;
X-CSE-ConnectionGUID: +PXYpknlR6+HnO1DxQGhbw==
X-CSE-MsgGUID: IBRDoIjyRKOATd2jwEQPdQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11896"; a="92919538"
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="92919538"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 10:13:43 -0700
X-CSE-ConnectionGUID: WAO6DiI0SsWvhO+MdLjwQg==
X-CSE-MsgGUID: waqd4Y8gRqKNMITB1xiRKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,262,1779174000"; d="scan'208";a="274245933"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Sep 2026 10:13:42 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 10:13:41 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 4 Sep 2026 10:13:41 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.56) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 4 Sep 2026 10:13:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=do+uoUF+w01YMuf692KVg8DnTmFf5eFskqn7Ux635wG7sHwJt9rJWszunfCAqczYHxbDWCDvZEYWWy24K+5NC8aY5JyOivSqesPqKdfWhZOdReJlAfa2waeAJ3ypOkDKja5qkBrYBWCaqQ0AonjL7pRjtcRSctlZmmKrXXMPFMAnaj9VJjGteo3hBjOnyjcJ9w0BmJ7XzjkGbBTVZejXvNYz8MP2l5/mRDiMjmWYQMpDPSO/M7vCJ1w4V4tzmtxjWXnlEeKhKDxQi84tCzeW0TMxjpVlYZ42q8B2Uv1dgASYhnji7evUNkSYDRRB2edJxKsoK8O3eZGbgKje8r70Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SxiJ6ov2eH/qC7FH5m/V8brlYxgDdNMFMMJeBE4fzo=;
 b=ie+oeqIa9M+qwot5xeRYDyBApG0GqifA0qWDXL/LckVvpYFgN1NqqppmKZPw4ytb0pNKhdyOQLlubvDGfvUtRLKWB4i+IaC6/INTPUfff4TX5jUPYWLTXVcTyuBTMBkUKcT54hZc9BRF3xGKA0ttCNU1tDYdTWJfqOptHlB59aiwOpk2Ven5KnjuShptV+TljcXSoz0rK8h87/3G7iem53pkKybwU7olBuRj6gqju3nhJKCd3zAYEPjQFmG9KDYbQ6O55odv5yp80gwWrNJdV/lj/V1nC02tAOuqdOSIEMSL2J8NriHmNSGb7GYjunPJK8xQZnfyWOniWO+F6f/SWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Fri, 4 Sep
 2026 17:13:33 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 17:13:32 +0000
Date: Fri, 4 Sep 2026 10:13:30 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: <sashiko-reviews@lists.linux.dev>
CC: Honglei Huang <honghuan@amd.com>, <dri-devel@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH v3 5/6] drm/gpusvm: keep a single DMA mapping inline for
 THP
Message-ID: <apr8Ok1NeYrUCcbC@gsse-cloud1.jf.intel.com>
References: <20260904163956.3433293-1-honghuan@amd.com>
 <20260904163956.3433293-6-honghuan@amd.com>
 <20260904165805.13BF21F00A3D@smtp.kernel.org>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260904165805.13BF21F00A3D@smtp.kernel.org>
X-ClientProxiedBy: MW4PR03CA0102.namprd03.prod.outlook.com
 (2603:10b6:303:b7::17) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB5095:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c4e41c7-126d-47dc-83f8-08df0aa7d905
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|23010399003|376014|18002099003|22082099003|3023799007|56012099006|5023799004|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: vNcCj2ApkIfTRP/m1XfHt9HDXv2ULUJQaCrKEIJjGgUq1eFKU5STqmKrDSVwd4co4RgeLh4ERlkXTqkLs5+N/6t3jY5bKFROwDEtZFdPsGhnQiJdzVYVplu5RcQkPqdxEibqqtiAXMY1moS39+/qR5O7RDXZPakbF2Cxy3MX4tcrgpCAWPAAIBWFTMLNZsQGJkzOnU4yWLHD59a41USRsJyno5xWXeyAOt4xTJMsxBAKvMOl+NovX3273ZGjP0lo1E5eD/8N2nd9wDUVW7h43gpap4cWPZK+/Ct0j8hgHUsbptxzftzHqbjk3v1Rj5yd0H6kZHbN5XHbFmDZ1z+++vYff2rN0Ag94i4dr/7/jPSYNxRveT7od3rAg1y5mjzBSA/at5gM7wiwLENYp2Y8ACuNGsm85Xc1mmEWk90ty2bIreOIC7qoD0K8IzaMuzHPQh6I1+iGjFSLE6r1p8RLIaneudJ1sdnmXrSV/mrwLsVH8W8ghnKmc3VHnzcFs8hZz/kFLMyVJTYgUIGAzOh8fUIBVqoWd+rIOV3zEp7z8YevlpOHNu4WHCaQJg9s+NjI/hSAw0SVeD8tmuyMbVlBQLdPxyevLz6B7vXJiD6A2NE=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(23010399003)(376014)(18002099003)(22082099003)(3023799007)(56012099006)(5023799004)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?mGSFAczT+Kk4MgZSvsM59cZPdI8bIOCk/wmtONskATe23QeMLjf8gdmj2e?=
 =?iso-8859-1?Q?1eJH/GlVOPbJPaJJ56zBkQsFblL/uGQ5A1YtfO2DhNljIyNKD8mWnDDL/Z?=
 =?iso-8859-1?Q?oESHIkcbNi9bDuvWj170WISWK+d9IznfK/UL9CZgHxnXtij2S9f/lzrv8L?=
 =?iso-8859-1?Q?xTjFYH11ACvGWSuCgcMQs5hdNIA5tZHkzJDBVi/GIXOUfS0wNtuhMSeqd/?=
 =?iso-8859-1?Q?swI7D8Ot42HlF+qwCmiTzBIFxSQMoK7+FkwEonD3mmlNiFvtCmdWriuPN5?=
 =?iso-8859-1?Q?whA8YiRx5k0aefRtCqqu+WN978wbQHwlQgixnnuPsK9du7nOTMv7Lpj4ue?=
 =?iso-8859-1?Q?ceZ+kgkySR76lzOOynnp6OnmGsNyau/i2OLPBsFACX89aYbDtAwEvhNfrU?=
 =?iso-8859-1?Q?F74l4bge979il2MYu/GiX0NUnAyAdFuU+F92GTMRzLlWWJhZKTdkgMrWAi?=
 =?iso-8859-1?Q?q1B3TeCZ9lyFrZCLRY3a94MthazcSqnO3iMss8NQkqC4k3+HoO0XKVoJ8q?=
 =?iso-8859-1?Q?8dNMXPnNp2B4wPgeiM0fzszMHjrxGkZT440DECAkiKP06vMR2RDGpaboVJ?=
 =?iso-8859-1?Q?BmNPZ68p8l2Rq6XhzBfoOkxUEjgZWUkWRMYi0wKRN7dIXUWN2RT2LE42OU?=
 =?iso-8859-1?Q?KanHp58RBN3NRX+ynvftyxuxEisAmd3ACRL0h87GLSHihgQZcKxo1Wda8B?=
 =?iso-8859-1?Q?QPG0ZtYTUz/xPt142dONKjU2acW7inKMPUxJFfoWOGjqIed0UVEq/yCHVT?=
 =?iso-8859-1?Q?v8FvKfZu/cIHWlDOmSd76VgCHLyA/PFvjy+dWuUjQBdpKykdwLsUXcw5/5?=
 =?iso-8859-1?Q?bkex8BilMpnOzukmavgUGyyA/SHW41ifFG1gmwycDY/yy4wbKERhg/aPiA?=
 =?iso-8859-1?Q?j4Ev8pPR9yX7sNaVNYhPGJJeyCskAQM9V79L+I5dcgqjhk+y/3ulvh9ZLb?=
 =?iso-8859-1?Q?jBXM+tMP5T3+gwdbb1RgCUUzy+oCspzSheDYV4UgiZVF1OJTUspLcqEy9w?=
 =?iso-8859-1?Q?G9EqDP2RMmgrb2lHwyEekAEV6zuRedPmcDg9Y/wL/G5DsPX16qPS98YJDq?=
 =?iso-8859-1?Q?EwQ2vgcvlwXfBwmG2mlz0qt+FL75OUVQCeqsoZAgnzVp5HxPhXSjs1InUQ?=
 =?iso-8859-1?Q?aIKj6ODCXzgLkyffWO8aRiC5Kv+Xn++ONiBLUS5ts/caVw7grUi3FGmR3Z?=
 =?iso-8859-1?Q?Lq7RYOBCu7e3FkVQLkNZCpIHK6wphdCg22o8/OnP+cVo1/Hq11LRM0G2xo?=
 =?iso-8859-1?Q?+y2IrQWv06dbwKX/mG4vmWYQlxTU9o5RpL1hqDzlK+PXsOt3FlHYlUf2e6?=
 =?iso-8859-1?Q?5mQFB3kZvyBE4OnlQufbyQYfHecWMiyQHcEU3qOljarAKnjLcCmlv4dMJd?=
 =?iso-8859-1?Q?V97YYFGsSTaX22ZcOp4nP+mMMFxcWZGkq8S5SOIxIafdSkDdqn/OomtVwH?=
 =?iso-8859-1?Q?BKe9sVDQnD4avvvMQVh3ncXf6k4oqzcIW7tNHhHrJMoHsHr5B3CDum6Pdd?=
 =?iso-8859-1?Q?bFtQk2mGMEjZ6kRYcNi3EG8wE6GNTmnCayD0UdFZTiGVNgwlXdSiYtbmdB?=
 =?iso-8859-1?Q?8c21+KJwGeVu6+kYoVtZDNP6858w6QCrUA26QyUfpxzua91cbZp/5YWgai?=
 =?iso-8859-1?Q?adSS/GZPiVMsVbWLMNS/T8Zr6BRfkVZlPnmSSJppYkelc9GUvGhARLq0oX?=
 =?iso-8859-1?Q?VLxyy0jsKFTVoKwrYxPTgCrvknYMxHZzJYO7zjUR3Db3GEtbZBzhcHOCmn?=
 =?iso-8859-1?Q?IWhzpXSF9sUhlQdf8OsVFlmyQiDB7MtH/yxwEeCDioJL/BcknohtwvlCp9?=
 =?iso-8859-1?Q?x9RlIPtfKiDYHR39PQzuWqlz1jV1B/U=3D?=
X-Exchange-RoutingPolicyChecked: jIYUMS+Sa2yygaMtLe495JlGsQnrhTMpaTBjcVqmU0DJvl1v61LWXVlmuFpy+Sx1LM0H4MhGBbCVBVK/xLdz14EeJgnkxq87uFoGaWWylJwIVlUfUypHpQ81X/IhXAOJUHj0HiNjaggWSzFkh1JgFXG+7uRckT+Cdoozg8QDEXJ+7vD2Ev78qjIv/yCI0xgq6BhR2OvOUEjVhhnbX1bEvjPvjUywALvzyI7d9T8hQR/3JktcqE8PYk0ytclRO1NUbevgqkoFczNRRhy+4zzNUImergg+QLLSNobrY/zv0etAcrVkZZhmjQXnlVGD06X3k4rJ0EDT1ARSACRzNaeRhQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c4e41c7-126d-47dc-83f8-08df0aa7d905
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 17:13:32.8524 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: R69hLseBKtaEWJu+ACno+ZiC5vg2dfdJiPyVLg+8YBjAYCuTYFhnuayDgGJByNMHxIJfTCRiqsS2P94jhOgCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5095
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

On Fri, Sep 04, 2026 at 04:58:04PM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [Low] Incompatible pointer type in `xe_pt_stage_bind` when `CONFIG_DRM_XE_GPUSVM` is disabled, leading to a build failure.
> --
> 
> commit ba41c31a99e11c5fd960b8101a85807f5290cd76
> Author: Honglei Huang <honghuan@amd.com>
> 
> drm/gpusvm: keep a single DMA mapping inline for THP
> 
> This commit optimizes drm_gpusvm_get_pages() by inlining a single DMA
> mapping entry for Transparent Huge Pages (THP), reducing memory overhead.
> It updates the accessors, including xe_pt_stage_bind() paths, to safely
> handle the new union containing the inline address.
> 
> > diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> > index 5d990c1c3740a..96ea9735f34ce 100644
> > --- a/drivers/gpu/drm/xe/xe_pt.c
> > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > @@ -831,7 +831,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
> >  			return -EAGAIN;
> >  		}
> >  		if (xe_svm_range_has_dma_mapping(range)) {
> > -			xe_res_first_dma(range->pages.dma_addr, 0,
> > +			xe_res_first_dma(drm_gpusvm_pages_first_dma(&range->pages), 0,
> 
> [Severity: Low]
> Will this cause a build failure when compiling the driver with
> CONFIG_DRM_XE_GPUSVM disabled?
> 
> When CONFIG_DRM_XE_GPUSVM is disabled, struct xe_svm_range uses an anonymous
> struct for its pages field instead of struct drm_gpusvm_pages. Since
> drm_gpusvm_pages_first_dma() expects a const struct drm_gpusvm_pages *,
> passing &range->pages here appears to result in a compiler type mismatch
> error.
> 

Yep. This is related to failure in Intel's CI - kunit builds without
CONFIG_DRM_XE_GPUSVM [1].

I believe Xe side we'd some more inline wrapper:

xe_svm_range_first_dma(struct xe_svm *range)

Then use ifdef around CONFIG_DRM_XE_GPUSVM to either call
drm_gpusvm_pages_first_dma or return NULL. xe_svm.h is structured with
this ifdef in mind. 

If you ask AI how build and run Xe's kunit, it should give you
instructions and should work without any Intel hardware.

Matt

[1] https://patchwork.freedesktop.org/series/173405/

> >  					 xe_svm_range_size(range),
> >  					 &curs);
> >  			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
> 
> [ ... ]
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260904163956.3433293-1-honghuan@amd.com?part=5
