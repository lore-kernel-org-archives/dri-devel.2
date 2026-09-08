Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01C5AC79FAA
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:49:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6E1610E97E;
	Tue,  8 Sep 2026 03:49:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="F9V/E8Bu";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0071710E084;
 Tue,  8 Sep 2026 03:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788839349; x=1820375349;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=rEvEfuo0xvMJwvezMEyYAyto9Ho7CUCvMGbAjwq5i4I=;
 b=F9V/E8Bu4b4zKGUM4JY+49ojGFrsTB0H5EkZRDYmal/3brnXY//SCPsQ
 KLABlGudvFF+IBEqk19YhtnrPziDwZ9TPRGEUoWGDYtFBJGXUZ4pepQNY
 66jk+OBXORBb4E6Dq8ymUOezWvhDrM6mPvvKHtzP6SbwydOoSgGK6H66J
 2ZYe8czAPqXExJOC8/n4a60EvaA/h5VykOdlQWTMnFbtJa6yhMZ6DhwP0
 YwpbUz4rPjjdfLMRPz6lYBIxP4lgMDeZPIHw7u8Dvo0epFeF5TsARghgx
 8oDSrr90+Gp20ekeGl26zok/TIHheZffzvtcilLmiBIOxdq/YXxSWkaIE Q==;
X-CSE-ConnectionGUID: gMfsVkOdRRGt2luuSf93JA==
X-CSE-MsgGUID: tf53S54FTe2VSmqiG76dfg==
X-IronPort-AV: E=McAfee;i="6800,10657,11899"; a="100391622"
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="100391622"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 20:49:09 -0700
X-CSE-ConnectionGUID: J474b57jSvi6ktlq6mlD8w==
X-CSE-MsgGUID: TLJaBuGtR+KMbdpuaOfWyg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,268,1779174000"; d="scan'208";a="272801882"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 07 Sep 2026 20:49:08 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 20:49:07 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 7 Sep 2026 20:49:07 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 7 Sep 2026 20:49:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ELWDEV2nhWDKIwWKP4I1dgo600Lk14e/WvL8JBv73uwf0zXmaXq4FyeJROI/yIRrZ41D4ERKC4155esBq7o2P7AC2RwgcaJI7T7qFzoEEfGSQjdEyamWF3pIDRzxb1lBXM9sFSXPIQ4fSNyVE6Rje00dHPVQM4kywNEc41hAEz74q0iilB4q2emzK6Yky2c5NbIrUsmTpnHUg47RKFjyXzW3VVDIsAFjyctkFty1dXE0Sqp4Nhx5Xcx6CVQX8rHZvGjL/qMTw3hnec0q5fnwDby68SBtvvlheqAb902Jz/aE13OuVmwgKMX0gOyuc5K6wtAqlFpq/g2zHGq1KWpYiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3eG4TZK5xSDV2L7WMxZ7cMz/C2sb5+kA6wxo143bxPY=;
 b=yMcK0xIddUIRlXjAWr7XJtibwVTJND4n2B25pOpXXS2jf1bfJoH6dpq+6LqlxxB5EljZfn45vymiBFgfrnHT35vn5zwHN9QqpsdazTddmuoNxDKaLqTalDoAzDtjlu9dKSLyZjmj2lLJARElATppEHVY9b09kjz4stFdwJDll6W/u2UezHZB/bL9MyPPaWNo23zHQy6eQOu/A5p/Sjqbv8r+80rN64tH5FgE2OBQ23rKU0r9tAJREnWX9EcPAJsQeGdukGMsoYKDdPad4IwYayyIBIQzEi+ZK9n11CWeR60fqAnlV70Taj6avul7lrLwRDGSErfQ+UNqRBRICwXJZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB7661.namprd11.prod.outlook.com (2603:10b6:510:27b::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.13; Tue, 8 Sep
 2026 03:49:02 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%3]) with mapi id 15.21.0382.014; Tue, 8 Sep 2026
 03:49:02 +0000
Date: Mon, 7 Sep 2026 20:49:00 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <himal.prasad.ghimiray@intel.com>,
 <dakr@kernel.org>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Junhua.Shen@amd.com>,
 <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v4 6/6] drm/gpusvm: keep an IOVA mapped range dma address
 inline
Message-ID: <ap+FrI7yVa/mSbgP@gsse-cloud1.jf.intel.com>
References: <20260905133142.3628027-1-honghuan@amd.com>
 <20260905133142.3628027-7-honghuan@amd.com>
 <ap9+cKNSFqX94F5k@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <ap9+cKNSFqX94F5k@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0095.namprd03.prod.outlook.com
 (2603:10b6:303:b7::10) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: ac486ff5-4fcd-443e-ca68-08df0d5c1f65
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|23010399003|7416014|10067099003|4143699003|11063799006|56012099006|5023799004|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: advOFFNotmpuBopA7gqB/dYT/tG6KFHBfjLNMWj/sLBQeAG8dLNVAAtfl4n4NNZfZijwUJCAJUU/aTUsfkSj8pyeTNB5R9Vp5K5sJE0F6slFOf5ZEY1QNeEbZD0ichoa7uh6zI3pZQkdib+b/siPHkay1RG8hbYZcxHNpSGoZh685Be2apzuykHfoyhtvI4W/MVlmISlGaOgU0lwJXmadUssr5KHff/PZ6jn/uYYjinDkn19QvRtmD6N/AtEMCbfxrbkPN9HYn6vx4NzzSfembx7PhT/D4EvqynDthoy+mjGy94BXQEYExzsBXG9UDABcycJRwdH3RS0M6STpkJnNGeD6EnWlLBXfRQBtxJ/eonl2iyCO7ghUGwYda5Qq+X1Ok0PY4uTukl7CfchmrofrTDVkoejQavX6QAcstaifNg/k8QF+bWMxgIGmpGNoiGTPZONBqrlybwPB0TPgvUsh+SkM0OX5OAcpFK33JfaPZOr7sL1M/zAZ5f5cEECQi88p8bWMpWAyE9h0CE8kywrfvdTCUwcQS5VDH7zEQ1DMdvOOwpFc9wkdjOOJHBZghIpOdkiZFgmUCnGfHMH3cyELzIid0dUS6zVFg9RKl6H+XKyVjpLFkmOKvd0t9fR9gR60esrRRuZNuwizyj1gOHX+0Zk0ei4l8+s3n8OCGrfteo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(7416014)(10067099003)(4143699003)(11063799006)(56012099006)(5023799004)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?J5RhKqAqbI6Pdd+lcPYLxASdDm7Wu7j+V9Z9d1pSN3qpdYpLq+OhLKQXwoHd?=
 =?us-ascii?Q?AIU/mgp1OGscUSY1bocZWtL0QqFLc8vXpC2FGiU4Fmz8/UBrl9Y5RVulcO8D?=
 =?us-ascii?Q?IRdM3P2X9Fvpq4X79bAjqrvr7cbI63YbpMySeEJLN1ViP8tkduv0MintGA6r?=
 =?us-ascii?Q?+4rphD1PVzM3kUjr2QuDaZKaKvbNVz1z3hpycFZXsDctD/WrFIrWF/+6dxfw?=
 =?us-ascii?Q?lcyCTYJnFplMP4f5N5yaOfua/V2Y3Et49toaTY1bnVONhjbfLMSgieXM1aix?=
 =?us-ascii?Q?iUue4hCfDa6DQIy6cu5VwluiQoPHmC9l44GHjiWdKOH3L5t+9MtGAitN7YkF?=
 =?us-ascii?Q?5kqis+FZa8Au36r79Uq33n1UClmvgpmhzbqN+fi2HcfrDv0ph6WIQmNehQbV?=
 =?us-ascii?Q?zSrfTaivUzkCS1yPlj6MTFk/1bcaSvab4Ue4neztURg1cCiYJcnL1C1gArph?=
 =?us-ascii?Q?iKA4EDn4os1ca4ZHJAQsJ0VvMzRrB+NnbfZLfoiPfF1kW8KBdlbq/pttWoxG?=
 =?us-ascii?Q?PGU7gdn4H9UEh6cqfec5UtWVDiWytJecJn0FYdg70C1gnSB7uS8QLmK5CkAe?=
 =?us-ascii?Q?oqni5XoY+vsC9rhg5sV4MXF/HH0ZuvKuq4/PEsL/6Uu+5bcDWCd9xgMXliJ+?=
 =?us-ascii?Q?jmLoIRnzQOJtaqcK/zN8tpjKJRXm+9xIx2SW0h4/1qvnVfB7MztuIXWPXduW?=
 =?us-ascii?Q?bFmiK8VTGIQkZx0GlH2eWBr1a9DM5NoyKdg6s5TSzzH1pHD9V5q1mkTrh+8L?=
 =?us-ascii?Q?7sRenRN6a0N5dikSgMzf0SC+7/yQuSF71JqiQZwCVRpenfTMiyIelaw8007N?=
 =?us-ascii?Q?wa371w/jg6MobxgPbRjImtQlRvoV5GNvEHfk/WgReBC49amInGsBAGWllL0/?=
 =?us-ascii?Q?pNy4D+l43V1hZAGyktrG8rj4RDcTvBxODwbzWRKf4c7LuJTfHi+KulkvcU9F?=
 =?us-ascii?Q?t9ic/Vj4YmcDDCvTprCIMrP8vOJY8HQEegfKU90e4YvXfXFYadMzaqTtlF4Q?=
 =?us-ascii?Q?/n7QYtZNuwuH1GMI+BE8p9HPlh2PGskdwSMbhaky2uRU4q3cxMOYyyBnkM7Q?=
 =?us-ascii?Q?VxOz5D31cPo46P8ZRr2eTf26pq6pE2e15ULrjtXQw/8K9LKnqA4+O/wy/MeK?=
 =?us-ascii?Q?0o8pgaG2zudGnPlNJg0yIUgZL+Bw58d657Apk65wWQU5QF33Y2H0crNp/vFt?=
 =?us-ascii?Q?1+fV8xNIjLLZVM/frjkxPKnLPTy2XIciR/h6P0YFIp3DXVmWvMpNV4NOiqBR?=
 =?us-ascii?Q?TDJgRJ9kLSF/Wca4bly/2sY1Xa0YDKGVmZ8iEksDtzhAj3eHsuKQa055KSFz?=
 =?us-ascii?Q?HVpfyhGyjNv/muVIlhQccNZb2AA3z6TnTD0D2NBMClmilJJf3d1ya3xDWWWa?=
 =?us-ascii?Q?Ubv61wlbTKoOZd5s2UQ90NuAA80vc6Qaezm/QP6mWAeHQXJxzjDd+3WbH/OR?=
 =?us-ascii?Q?3ViGWyIgnXOJ3eGSYQVPBZ5XZuqfxThoK3VCb0RJJzsD8CXvtwECAfQKSH7H?=
 =?us-ascii?Q?UXrl1esgtec0DiNkabG1RRVESSo03l7dKUGB8qitEpsDjHflcR26x8qsVfOr?=
 =?us-ascii?Q?yanjd2S9Rc2RZW22MAE2FaMTStUKc6gZcu3oSlp3iorxTTiVcT4FXuT3pcas?=
 =?us-ascii?Q?c9H58JPOffbnwUZqbGNrA+PHsnyYj/cIhBF0+4xypTR76gpeZ9ywvQSAx8z0?=
 =?us-ascii?Q?A33lcNuPW9lfBrMtg3VPwj1uOjjwCNDKNwRTE9IH2SBzrxiCWT/90cYl679e?=
 =?us-ascii?Q?TdcCYbEOBr59ga+asdhVhpAmlJPyMMY=3D?=
X-Exchange-RoutingPolicyChecked: SABtRmHizvNbl0lnqlPNa1Bi9sUGGDkJ6nbjsG9phSLaJNJKuwH8wa0Tzye3Xkc99qxh9zB0sZeEkX/D+eilKUhRmLF1X4GAlv5590r+dPF9RBvbOPydVuZj/XCWPjAfQOOm4RJfRekFEnYt/RRsf8EHpni/kTG6qlkdS6hMgaMCissfPOE1txDDS+N6IT8Ch6SPnAJG4XPQ8SpcJZiMGU+YM28cgHz7t/DnTW1hZZ6y1RauSbY1kmWwzBe3k7tZhXvY/zsMbp9BmgOfc/74bkEKWHaXnkLVNh0AZqpfSMw6HjirFkr8Cycye5l9FikufzlPApqlZPp0vca68VbqKA==
X-MS-Exchange-CrossTenant-Network-Message-Id: ac486ff5-4fcd-443e-ca68-08df0d5c1f65
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2026 03:49:02.6516 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5urM836foxGvE4JE342QyCJnZYCRMZLlqsowV5VGZj0pqBAfxRRbLpDUam53lnD9h2CSmkRFlE9YnzNmyxMC9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7661
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

On Mon, Sep 07, 2026 at 08:18:08PM -0700, Matthew Brost wrote:
> On Sat, Sep 05, 2026 at 09:31:42PM +0800, Honglei Huang wrote:
> > dma_iova_try_alloc() reserves one contiguous IOVA for the whole range and
> > links each page at the next offset, so the device addresses run
> > contiguously from entry 0 and one entry describes them all. A 2 MiB range
> > of 4 KiB pages then drops the same 8 KiB array as a THP backed one.
> > 
> > Fold only when state_offset covers the full range, which proves no device
> > page was mapped in between, and only single page entries, so the order
> > kept is 0 and stays true. Widening it instead would tell a consumer to use
> > a huge page for npages separate CPU pages, which hangs Vega20 on amdgpu.
> > 
> > The kept entry no longer bounds the segment, so skip the unmap walk when
> > it has nothing to do, keyed off dpagemap rather than the flags, which are
> > not published yet on the error unwind. Consumers need the same
> > distinction, so drm_gpusvm_pages_first_dma() returns it alongside the
> > array from one read of the flags; xe passes it to xe_res_first_dma().
> > 
> 
> Nice trick for IOVA allocs and variabled sized mappings like userptr.
> Looks good.
> 
> Going to megre entire series to drm-misc-next shortly. Thanks!
> 

So small snafu merging - this series won't cleanly apply drm-misc-next
and won't until 7.4 because of patches in Xe targeted for 7.4. The
series will cleanly apply to drm-xe-next, so if AMD is ok with this, I
can merge there. Or I can work through the (minor) conflicts and merge
this into drm-misc-next (ofc I'll need confirm with the drm-misc
maintainers that this ok too).

Matt

> > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> 
> Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> 
> > Signed-off-by: Honglei Huang <honghuan@amd.com>
> > ---
> >  drivers/gpu/drm/drm_gpusvm.c       | 41 +++++++++++++++++++++++-------
> >  drivers/gpu/drm/xe/xe_pt.c         | 23 +++++++++++------
> >  drivers/gpu/drm/xe/xe_res_cursor.h |  5 ++--
> >  drivers/gpu/drm/xe/xe_svm.h        |  8 +++---
> >  include/drm/drm_gpusvm.h           | 13 +++++++++-
> >  5 files changed, 67 insertions(+), 23 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > index 2c7c4c89dc4..b6c9d3a07dc 100644
> > --- a/drivers/gpu/drm/drm_gpusvm.c
> > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > @@ -1242,7 +1242,7 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> >  			.__flags = svm_pages->flags.__flags,
> >  		};
> >  		const struct drm_pagemap_addr *addrs =
> > -			drm_gpusvm_pages_first_dma(svm_pages);
> > +			drm_gpusvm_pages_first_dma(svm_pages, NULL);
> >  		bool use_iova = dma_use_iova(&svm_pages->state);
> >  
> >  		/*
> > @@ -1259,7 +1259,15 @@ static void __drm_gpusvm_unmap_pages(struct drm_gpusvm *gpusvm,
> >  			dma_iova_free(dev, &svm_pages->state);
> >  		}
> >  
> > -		for (i = 0, j = 0; i < npages; j++) {
> > +		/*
> > +		 * With IOVA and no device page the unlink above tore every
> > +		 * entry down, and that is also when the range may be folded
> > +		 * to one entry, which must not be walked per entry. dpagemap
> > +		 * is set before the first device_map(), so it is also right
> > +		 * on the error path, where the flags are not published yet.
> > +		 */
> > +		for (i = 0, j = 0;
> > +		     (!use_iova || dpagemap) && i < npages; j++) {
> >  			const struct drm_pagemap_addr *addr = &addrs[j];
> >  
> >  			if (addr->proto == DRM_INTERCONNECT_SYSTEM) {
> > @@ -1491,17 +1499,32 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
> >  
> >  /**
> >   * drm_gpusvm_pages_inlinable() - Whether the dma address can be inlined
> > + * @svm_pages: The SVM pages instance that was just mapped
> >   * @nentries: Number of entries the mapping loop produced
> > + * @npages: Number of pages in the CPU range
> >   *
> > - * A THP maps as one huge page, so the whole range needs a single device
> > - * address: the dma_addr array can be freed and the address kept inline,
> > - * which is where the memory saving comes from.
> > + * A THP maps as one huge page, and an IOVA reservation links every page of
> > + * the range at the next offset, so the device addresses run contiguously from
> > + * entry 0. Either way one entry describes the whole range, so the dma_addr
> > + * array can be freed and the address kept inline.
> > + *
> > + * state_offset advances only on the IOVA branch, so reaching the full range
> > + * length proves no device page was mapped in between. Only single page
> > + * entries fold, so the order kept is 0 and describes the range truthfully.
> > + * Larger chunks, several huge pages among them, stay an array that is
> > + * already short and that a consumer places with one PTE each.
> >   *
> >   * Return: True if the mapping fits in a single drm_pagemap_addr.
> >   */
> > -static bool drm_gpusvm_pages_inlinable(unsigned long nentries)
> > +static bool drm_gpusvm_pages_inlinable(struct drm_gpusvm_pages *svm_pages,
> > +				       unsigned long nentries,
> > +				       unsigned long npages)
> >  {
> > -	return nentries == 1;
> > +	if (nentries == 1)
> > +		return true;
> > +
> > +	return nentries == npages && dma_use_iova(&svm_pages->state) &&
> > +	       svm_pages->state_offset == npages * PAGE_SIZE;
> >  }
> >  
> >  /**
> > @@ -1656,7 +1679,7 @@ static int drm_gpusvm_dma_map_pages(struct drm_gpusvm *gpusvm,
> >  	if (pagemap)
> >  		flags.has_devmem_pages = true;
> >  
> > -	if (drm_gpusvm_pages_inlinable(j)) {
> > +	if (drm_gpusvm_pages_inlinable(svm_pages, j, npages)) {
> >  		struct drm_pagemap_addr addr = svm_pages->dma_addr[0];
> >  
> >  		kvfree(svm_pages->dma_addr);
> > @@ -1772,7 +1795,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> >  
> >  	if (map_dma) {
> >  		for (p = 0; p < num_pages; ++p) {
> > -			if (drm_gpusvm_pages_first_dma(&svm_pages[p]))
> > +			if (drm_gpusvm_pages_first_dma(&svm_pages[p], NULL))
> >  				continue;
> >  			svm_pages[p].dma_addr =
> >  				kvzalloc_objs(*svm_pages[p].dma_addr, npages);
> > diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> > index fa4b29da0b6..7fb2fe1f826 100644
> > --- a/drivers/gpu/drm/xe/xe_pt.c
> > +++ b/drivers/gpu/drm/xe/xe_pt.c
> > @@ -831,9 +831,12 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
> >  			return -EAGAIN;
> >  		}
> >  		if (xe_svm_range_has_dma_mapping(range)) {
> > -			xe_res_first_dma(xe_svm_range_first_dma(range), 0,
> > -					 xe_svm_range_size(range),
> > -					 &curs);
> > +			const struct drm_pagemap_addr *addr;
> > +			bool contiguous;
> > +
> > +			addr = xe_svm_range_first_dma(range, &contiguous);
> > +			xe_res_first_dma(addr, 0, xe_svm_range_size(range),
> > +					 contiguous, &curs);
> >  			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
> >  		} else {
> >  			xe_assert(xe, false);
> > @@ -865,11 +868,15 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
> >  		xe_bo_assert_held(bo);
> >  
> >  	if (!xe_vma_is_null(vma) && !range && !is_purged) {
> > -		if (xe_vma_is_userptr(vma))
> > -			xe_res_first_dma(drm_gpusvm_pages_first_dma
> > -					 (&to_userptr_vma(vma)->userptr.pages),
> > -					 0, xe_vma_size(vma), &curs);
> > -		else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
> > +		if (xe_vma_is_userptr(vma)) {
> > +			const struct drm_pagemap_addr *addr;
> > +			bool contiguous;
> > +
> > +			addr = drm_gpusvm_pages_first_dma(&to_userptr_vma(vma)->userptr.pages,
> > +							  &contiguous);
> > +			xe_res_first_dma(addr, 0, xe_vma_size(vma), contiguous,
> > +					 &curs);
> > +		} else if (xe_bo_is_vram(bo) || xe_bo_is_stolen(bo))
> >  			xe_res_first(bo->ttm.resource, xe_vma_bo_offset(vma),
> >  				     xe_vma_size(vma), &curs);
> >  		else
> > diff --git a/drivers/gpu/drm/xe/xe_res_cursor.h b/drivers/gpu/drm/xe/xe_res_cursor.h
> > index 0522caafd89..c3a037e5f34 100644
> > --- a/drivers/gpu/drm/xe/xe_res_cursor.h
> > +++ b/drivers/gpu/drm/xe/xe_res_cursor.h
> > @@ -233,12 +233,13 @@ static inline void xe_res_first_sg(const struct sg_table *sg,
> >   * @dma_addr: struct drm_pagemap_addr array to walk
> >   * @start: Start of the range
> >   * @size: Size of the range
> > + * @contiguous: Whether one entry describes the whole range
> >   * @cur: cursor object to initialize
> >   *
> >   * Start walking over the range of allocations between @start and @size.
> >   */
> >  static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
> > -				    u64 start, u64 size,
> > +				    u64 start, u64 size, bool contiguous,
> >  				    struct xe_res_cursor *cur)
> >  {
> >  	XE_WARN_ON(!dma_addr);
> > @@ -248,7 +249,7 @@ static inline void xe_res_first_dma(const struct drm_pagemap_addr *dma_addr,
> >  	cur->node = NULL;
> >  	cur->start = start;
> >  	cur->remaining = size;
> > -	cur->dma_seg_size = PAGE_SIZE << dma_addr->order;
> > +	cur->dma_seg_size = contiguous ? start + size : PAGE_SIZE << dma_addr->order;
> >  	cur->dma_start = 0;
> >  	cur->size = 0;
> >  	cur->dma_addr = dma_addr;
> > diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> > index 7eb80d4d6db..2ef4ef026cc 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.h
> > +++ b/drivers/gpu/drm/xe/xe_svm.h
> > @@ -223,13 +223,14 @@ static inline unsigned long xe_svm_range_size(struct xe_svm_range *range)
> >  /**
> >   * xe_svm_range_first_dma() - Resolve the device address array of a SVM range
> >   * @range: SVM range
> > + * @contiguous: Where to store whether one entry spans the whole range
> >   *
> >   * Return: Pointer to the first device address, NULL if none is populated.
> >   */
> >  static inline const struct drm_pagemap_addr *
> > -xe_svm_range_first_dma(struct xe_svm_range *range)
> > +xe_svm_range_first_dma(struct xe_svm_range *range, bool *contiguous)
> >  {
> > -	return drm_gpusvm_pages_first_dma(&range->pages);
> > +	return drm_gpusvm_pages_first_dma(&range->pages, contiguous);
> >  }
> >  
> >  void xe_svm_flush(struct xe_vm *vm);
> > @@ -449,8 +450,9 @@ static inline bool xe_svm_range_is_removed(struct xe_svm_range *range)
> >  }
> >  
> >  static inline const struct drm_pagemap_addr *
> > -xe_svm_range_first_dma(struct xe_svm_range *range)
> > +xe_svm_range_first_dma(struct xe_svm_range *range, bool *contiguous)
> >  {
> > +	*contiguous = false;
> >  	return NULL;
> >  }
> >  
> > diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> > index aaad5c9b510..9e35584812f 100644
> > --- a/include/drm/drm_gpusvm.h
> > +++ b/include/drm/drm_gpusvm.h
> > @@ -380,12 +380,19 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
> >  /**
> >   * drm_gpusvm_pages_first_dma() - Resolve the device address array
> >   * @svm_pages: Pointer to the drm_gpusvm_pages.
> > + * @contiguous: Where to store whether one entry spans the whole range, or NULL
> >   *
> >   * drm_gpusvm_pages use unions to optimize the storage of DMA addresses,
> >   * this function abstracts the access to the first device address. The driver
> >   * should use this helper instead of reading dma_addr directly to prevent
> >   * array out of bounds access.
> >   *
> > + * @contiguous comes from the same read of the flags as the array itself, so a
> > + * caller cannot see the two disagree and walk past that single entry into the
> > + * fields behind it. When it is set the length comes from the range rather than
> > + * from the order. The order still states what one PTE may cover: the range
> > + * length for a huge page, PAGE_SIZE for an IOVA mapped range of single pages.
> > + *
> >   * Only get_pages() and the free path switch between the two union members.
> >   * Both hold the notifier lock for read, so taking that lock does not stop
> >   * them; callers need the driver lock that does, which every reader of the
> > @@ -396,13 +403,17 @@ static inline void drm_gpusvm_init_pages(struct drm_gpusvm_pages *svm_pages,
> >   * Return: Pointer to the first device address, NULL if none is populated.
> >   */
> >  static inline const struct drm_pagemap_addr *
> > -drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages)
> > +drm_gpusvm_pages_first_dma(const struct drm_gpusvm_pages *svm_pages,
> > +			   bool *contiguous)
> >  {
> >  	struct drm_gpusvm_pages_flags flags = {
> >  		/* READ_ONCE pairs with the WRITE_ONCE of the flag writers */
> >  		.__flags = READ_ONCE(svm_pages->flags.__flags),
> >  	};
> >  
> > +	if (contiguous)
> > +		*contiguous = flags.inline_dma_mapping;
> > +
> >  	if (flags.inline_dma_mapping)
> >  		return &svm_pages->inline_addr;
> >  
> > -- 
> > 2.34.1
> > 
