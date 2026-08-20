Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9B51C5DF85
	for <dri-devel@archiver.kernel.org>; Thu, 20 Aug 2026 14:52:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 050E210F082;
	Thu, 20 Aug 2026 14:52:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ElLIyQE8";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A515810F074;
 Thu, 20 Aug 2026 14:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787237564; x=1818773564;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=9SUWsvvbdhMLwXeTvnI4B1Oa4pd6e6Z4Pz0fwhzdF5Y=;
 b=ElLIyQE8/LP9P8SFo4Vp7h/Kc4SVfMTlthtcAH+1LnsbYKo8cuJDyixD
 yTSo7J8c8d7FC+/7+dVGo7yOM6eSTMo+f7ne4isZXGWeFkUkccEVo5s5Z
 WznWj0N3VPGgKf122WQr08ENREBUtwe98XD3ZFaceKQ8AQBMaSdz5N+5g
 QMdpWTk5icOPHvgXgth4toTaukAPf5FB1bamV159hKSkZDnu1LheuDTK+
 3tAZaBOWRRD+ufRHyaMGxOum1ks7ZIR2vDnBkvl959bpOskiekIwTM9GA
 p6XQFuD4Lw3zHFmXeLiedKYBCiN9gI0bCKkEcQhlG8jBT/Jah30aoqogJ A==;
X-CSE-ConnectionGUID: AtDzsXSCQouCeziYSRrKtA==
X-CSE-MsgGUID: Zp7vXFtqQriwpABaqiTyOw==
X-IronPort-AV: E=McAfee;i="6800,10657,11881"; a="91583673"
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="91583673"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:52:43 -0700
X-CSE-ConnectionGUID: PnXkChhKQUy0k2IZtvOCLA==
X-CSE-MsgGUID: mS7L6/mdSfe0A6QVhG/4Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,233,1779174000"; d="scan'208";a="295986267"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Aug 2026 07:52:42 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 07:52:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 20 Aug 2026 07:52:42 -0700
Received: from BL0PR03CU003.outbound.protection.outlook.com (52.101.53.39) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 20 Aug 2026 07:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edqHeFHxUGuqmcDjzamnqtAjaPPDCAQekdKuFEA5oyVO4na1dN/YjVmXJgnGCMaDQ8gJyEjjpXf2eUzO8ANxxiyxNMaduLPcG/gam2QRU+TC9ahvmLpGrmlHlaBL6Ii8xOBHqPXIOf8mGX+Wh36EuSzeEs1m/CHteG57AG7VP/yPF4eKtvAts+KUCKVZZZg17N//TO9UO2jCo/rrg0GLGA6qCVXNbZjSlOxkgX/oepbslQuHTAE8Z60kW/AdPOHQkTXD5bL4q4sF/H1bfUbR3hSWGgPqYcLvjwC0+SX4fOclKLdJmOQYpR78LL8uXPKhEyVNLCTwGy1elUbvNLWw4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DKUL/IERmyo3cJdjdENwQJ+61IwcrvHBalxMol5Hnyg=;
 b=LVa2WswBETLsTk4VlEHvWIUvKXQfBDeB6jdI3Cw7D8hqcaaWrU/RzoXcl9bTST3KJgY1l+hyKj2IgyiKJbWX4KkLKMVq4ev0J2ngWiovjFVCQwYFWeLoQrCI69RsFPbMcV+Ex0VDjtItJNrwVFCekxXrVshduJddHQxAj9e5MTCvTGrRdzFZ7M5kP/dr7rNjMG4FuQ5RLq8SjVvjfEGgAbMUqqgY5qE4KNZDFz+ki9uqDtPP9SSah9AX1QfV+IKUZ2K/GRRnk0X4QtYbdjSNtwEe8m5p0pwv6KvkNohpK07YEX84QdRAZRREZcZhrYHKtcVFy7pjRM8tB25EQqlh8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7752.namprd11.prod.outlook.com (2603:10b6:208:442::20)
 by MN2PR11MB4551.namprd11.prod.outlook.com (2603:10b6:208:269::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Thu, 20 Aug
 2026 14:52:39 +0000
Received: from IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce]) by IA0PR11MB7752.namprd11.prod.outlook.com
 ([fe80::848a:3e54:c19b:11ce%7]) with mapi id 15.21.0339.007; Thu, 20 Aug 2026
 14:52:39 +0000
Date: Thu, 20 Aug 2026 10:52:33 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Dave Airlie <airlied@gmail.com>, Simona Vetter <simona.vetter@ffwll.ch>
CC: Jani Nikula <jani.nikula@linux.intel.com>, Joonas Lahtinen
 <joonas.lahtinen@linux.intel.com>, Tvrtko Ursulin <tursulin@ursulin.net>,
 Thomas Zimmermann <tzimmermann@suse.de>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Matthew Brost <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Oded Gabbay <ogabbay@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
 <intel-xe@lists.freedesktop.org>, <dim-tools@lists.freedesktop.org>
Subject: Re: [PULL] drm-intel-fixes
Message-ID: <aocUsWya6c8_5yvq@intel.com>
References: <an23lmV9ktpiHnTN@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <an23lmV9ktpiHnTN@intel.com>
X-ClientProxiedBy: SJ0PR03CA0021.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::26) To IA0PR11MB7752.namprd11.prod.outlook.com
 (2603:10b6:208:442::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7752:EE_|MN2PR11MB4551:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b3b9d5a-1412-4714-d65f-08defecaae3f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|7416014|376014|23010399003|1800799024|56012099006|11063799006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: AYGzEP+j6EH6lxa640lXaHmW+SSZWUIAXLtG/jJrqBDfYGhROwwLnbXPcItTdtSRwl04NI+sCwoYjgb5K4mwexQw1FLiiXqU9WyfOPYtfXI+/XGsjW8oBKpnNtXGZr4Um16XKqJhoZzjBOSHRIp/itlyEKv2ReSGSZvT8bLQ7TjOZTIt2VMd348ka4sB70TOMGAKHO/mzcP8d/76tcv16HmhMcmCF4dFF7lgb1+zZJ/nLEeNquGRThLCRs/RLeLftx0kdxBofxRec0O/uU38wpwP48akFKKygpg9RjJDRPqeuXMFKlqWe4vxeSzx65VBhH9aj2w53uqDKRhfDLzX4jn1tJIltLFyCqJWW150z9DBbshc/NLTuGJIOXKA2kf7fSEEbwSKipCRjI+znFPn94mrxoE3HkbyeBV3PDBHkeg/Wo1SFuXMvETpNDx37FmZbMNhqxvKarsrMIAUXm/PF9yDhILJkL2IIpoYPBHj1lFQ0zfQ5YH1aaVjqz1iOlfYCmqkoyGvX/jWd1BuckSMqitBxBg9ZPL3lgsZNtzT9gWfTD3zLbgF/rbeV/Y229Z2EAnMtXDmtaWF2wkKyELNByW6eX2aatoiGYzlE3Az/jr3k6FsWyuTSiEn45pQeW/b
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7752.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(7416014)(376014)(23010399003)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B/fDw2+MNxhX4jHF7w4AkU14WkDFent4HHtf9Ld8l+Ass/IRvb8jnm2Xd0MR?=
 =?us-ascii?Q?Z3WYQmkdUEy16jJV6hmtpneV76Zgv+Hnqsq/1LNV7bDls5b9h/J3SHbgdnq2?=
 =?us-ascii?Q?b6UaSDrftjNvSye3qbUvoFpt1LDPIYLca53zkAL1FpQ7iF59COP9fSz5X4DB?=
 =?us-ascii?Q?d6DCZFhEjzay3u9wCaXMwEU81OD5sRSwQnOKC8R9ZUjOXJuVFii2xQveZHuM?=
 =?us-ascii?Q?uMHbibTRbkk+yaKOgK9wBQ75BrIWMM035oyu8oD9u4Y6b1uXV0/ruwhxMYDp?=
 =?us-ascii?Q?H6BUemHRkcoBpO1L6JbNdAAZHO+imIzqlsXl0BuUxSsI14qiiZFIiG1ElS1s?=
 =?us-ascii?Q?ef6f7OiRCl7INrbnePRZgQLQ1j+JialB0O2772cuNwNB1iU3Ou6Jnk6m24Xc?=
 =?us-ascii?Q?Z60V5cita6mfUqRP7MVZDqeZMKnQQDO54eAexRfcnWBxUBVqv6FHtmYLCvzR?=
 =?us-ascii?Q?djDrDaE90si9KoAW+09VB9nCqbmfkR/tSDeW8XJWLGOuMvglwmeJRxP7rOqT?=
 =?us-ascii?Q?2RKmUpGRJLIRpFwiOltT3WVDFdZUycK12rS//MIa9wKPt8fe0p9khmdDynPo?=
 =?us-ascii?Q?Kt6QJ2Fb93lmkdazTLZc+MiVmj1cJQKuaBQWiyfi/gx3e8lzYM1hiKl09NVS?=
 =?us-ascii?Q?+FpTRYrEDpzskvzF7znNce8yWgoga0uatTpDYjprVAkQuCBqy+bIETeYP+gl?=
 =?us-ascii?Q?5BqxaWuTFp0o9sbaREP8bZstAT9tpcb1MaU+Nei/tsAg6OhOV/rFzFdNZDI4?=
 =?us-ascii?Q?Yzp/LSEtA1EG53NDcJ0Trv+Gql0U/bzNZQOfi+W88/2/gyTF92agvmvUhtnq?=
 =?us-ascii?Q?bZrojhR2YQgaOFvQf9SaySXHsGIi4kLup8QZkv0tsivlN+QSCG50xRE2ix38?=
 =?us-ascii?Q?oqz+uVs7/KPI+fobkTxO+bA4mLpslB//nx5kp29EaSl5HU2ZkAiHr9jO9qo2?=
 =?us-ascii?Q?Es7FsRu6qgh5fGnu36d+d9EwhroSV4gUnLxrG3UdkC7WvWbo7F5v/pykDES5?=
 =?us-ascii?Q?BvFEYZqWGewaEc3gz46ho0k0zJ/mzBotkNffCgprN9D12NrSQVKU34zW320t?=
 =?us-ascii?Q?jud+0mv+MuaNi4ALGsDXvX/s/6YpTIXVuAayiNBWwteeY1rnWCzD6JZf37BK?=
 =?us-ascii?Q?UhiWEnbqowPN+YesTQl1IqQAF38xQFTP7WNfuMHpVmjhYhrfCGJT/DZHDyhy?=
 =?us-ascii?Q?38hCfMO0w9lICAhV1M11IxziXO4O3Jh2HTcIUlVYfB0sdSw+gbwOty6vtFUT?=
 =?us-ascii?Q?eU65FcE+qCUNoVyziURJd/csi5n97LmLnXXfrqXFPpuV2Aw8QiL3Iv1bPX7v?=
 =?us-ascii?Q?iD3klPAs/3PKJNB/a1xBLQz9rBKyJQtcMup0b1hOVmXn9BiADPrpZUG5DeXF?=
 =?us-ascii?Q?JGaWu549rVE1IpksAPChrfeVk149Ama1J/tYSBxTVCm9RC+03okLYVCUWzHH?=
 =?us-ascii?Q?U7LFI0dBGLroZOBkbGjIW5vKpktlT1jsJ8gFESUBJ7vrHtiPRCSA9hiKlrLD?=
 =?us-ascii?Q?zkIzhaTtjT9bHd4TXAQ7rwu5ICIuuqOXIzCdL2KTbaBj5A7hUXm+/SpfOhi6?=
 =?us-ascii?Q?+FW/ubAqpJMW+nM8osRhnPVlbv2LUmfPry8od0mA3SgB2tchLz4tq9gXVxUd?=
 =?us-ascii?Q?gKvZrDzcaTSdIr3ZichYluQjN6xej8qYyJ1IfwFGQw9cHpVm2WLwlU/3lN+b?=
 =?us-ascii?Q?kWDHG5uBkQs2GbIGuxzUgp3WoZhKHuWIEDkm2t/sbxhPWW5O3X16JORKw4aw?=
 =?us-ascii?Q?7d+V9jlpCw=3D=3D?=
X-Exchange-RoutingPolicyChecked: T5iIfci6G+FWzBMXoaAg30j94vCQ9xHeUpgjFZTk/otU/zDPN5UMBIg5W4Jg7lVvcwBg8V8ifx+z3MqzgkDaQPKoc7ppYmwPk0dc4exFgpBv6DT7V/pR9Wz4NnrnV5WzUsoJszoiMzJ7Z/9PhvGCMzCzFmfuQ3It7Z+dCyR6TLwf3KbjzDW5E4fX0H6JJfVWfxOXHeVUBeGOKHVogTiC+kIDKHRjFDROxbNMKRKgjfwtRwc6+wWP6VKWvnrcERBi6kPr+u5VPl6n81yED9WCi2wLwwOLpXGO4chE5GxnbDKIKkcPqeQK+WkLmRKK2/SwX3UgwEvrb2tFmV/Vh2P20A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b3b9d5a-1412-4714-d65f-08defecaae3f
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7752.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2026 14:52:39.7175 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lBp5Wf5Utfg4IXBGtG5jgf+Ua+3Ip2xuFadA68ey+7ycH0t4lmT+dWESmu1WLexEOGiofFQbOCer7lGZZtYLdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4551
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

On Thu, Aug 13, 2026 at 08:24:54AM -0400, Rodrigo Vivi wrote:
> Hi Dave and Sima,
> 
> Here goes our drm-intel-fixes for this week.
> 
> Only a couple of dii clock frequency fixes with a dependency patch
> adding a helper function.
> And dropping a duplicated DP MST call. The duplication was
> caused by a bad cherry-pick on fixes that I didn't noticed :( Sorry!

Dave, Sima,

was there anything wrong with this PR? or did I sent too late?

I'm sending these patches to stable mailing list now. But let me know
if there's any concern so I can adjust before that hits the stable.

> 
> Thanks,
> Rodrigo.
> 
> drm-intel-fixes-2026-08-13:
> A couple of DII clock frequency fixes and dropping a
> duplicated DP MST call.
> The following changes since commit db2ddb87143519e20a95aa36c60b36107b736a58:
> 
>   Linux 7.2-rc7 (2026-08-09 14:54:50 -0700)
> 
> are available in the Git repository at:
> 
>   https://gitlab.freedesktop.org/drm/i915/kernel.git tags/drm-intel-fixes-2026-08-13
> 
> for you to fetch changes up to 266ebacffc5809478a2e80d61ddc58c921dbe2b4:
> 
>   drm/i915/lt_phy: program DDI_CLK_VALFREQ with DDI clock frequency (2026-08-12 13:27:23 -0400)
> 
> ----------------------------------------------------------------
> A couple of DII clock frequency fixes and dropping a
> duplicated DP MST call.
> 
> ----------------------------------------------------------------
> Chaitanya Kumar Borah (1):
>       drm/i915/dp_mst: Remove duplicate intel_pfit_compute_config() call
> 
> Suraj Kandpal (3):
>       drm/i915/ddi: add helper to compute DDI clock frequency
>       drm/i915/cx0: program DDI_CLK_VALFREQ with DDI clock frequency
>       drm/i915/lt_phy: program DDI_CLK_VALFREQ with DDI clock frequency
> 
>  drivers/gpu/drm/i915/display/intel_cx0_phy.c |  5 +++--
>  drivers/gpu/drm/i915/display/intel_ddi.c     | 11 +++++++++++
>  drivers/gpu/drm/i915/display/intel_ddi.h     |  1 +
>  drivers/gpu/drm/i915/display/intel_dp_mst.c  |  4 ----
>  drivers/gpu/drm/i915/display/intel_lt_phy.c  |  6 ++++--
>  5 files changed, 19 insertions(+), 8 deletions(-)
