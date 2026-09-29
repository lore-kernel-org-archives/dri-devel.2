Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA4CDCA5FA5
	for <dri-devel@archiver.kernel.org>; Tue, 29 Sep 2026 17:51:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 435E810EFD4;
	Tue, 29 Sep 2026 17:51:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="ll/8L4hL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9529010EFD4;
 Tue, 29 Sep 2026 17:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790704311; x=1822240311;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=w/4kSUHx8YO5o9YB6WAG9NwivUc814AVk6rzYIB/GNE=;
 b=ll/8L4hLGVTxvMBZ4lZN4SOnxFpNJ1HXL6+YggFxfPSblVlwOaSx56F6
 aROn822qfx4kXcnKlwl5qBPJc7B0UVnwgkOdfH97TAcf9Fmzu2ZTm+28b
 NqrIPyE9OQm03fM9TdL6NMw2CaRFgV6g/nVLn0rqRRBbUQnpFNrxl+w3l
 8zFu/Ga9pdUr0hYOvP7LULlrgPMOKeX9/kzoW29zIcDQwxzml4uO2waHr
 t++Bu+lI9BfiCOPD6nkfcTo7tjDNXtirLJlunHCUbmxQlx+Zr5okkBj6n
 p4PaJZaMI/cubwP2VoWGteWS/k3mxbbJb+wHXkUAyfW8SWkHoiIrInWde Q==;
X-CSE-ConnectionGUID: bHkv0095T4eJUZfiyccuOQ==
X-CSE-MsgGUID: jVnG/4vJRRqrMZX0KuhUFg==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="116961501"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="116961501"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 10:51:51 -0700
X-CSE-ConnectionGUID: 21kwqveSSaS5AAi9nbL48w==
X-CSE-MsgGUID: HFRB2079TH6edscRlGFvWg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="304939832"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 10:51:51 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 10:51:50 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 10:51:50 -0700
Received: from DM5PR21CU001.outbound.protection.outlook.com (52.101.62.5) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 10:51:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDHeFnpplMUC/MSf0tevAT9dxkvrX8N3B/+uhu3G8IUNcaVod33Kwad/LJJR2wFSJeSlOJdEDKo5Jl06HSycD29d3Q8PGxmMJ3dYnVWVNA6XPS4nq9GEWjufsmqGsUuOJ6HrtzP2Vz/L3iTD4BdY4k9DdX5tWEh7yUEwhV3wdfmp3rUpwmiJCQN/BYuwQJzRptusXUpXdfE5bNFTYor+IkBrFOgA8Ox5oEFBLsZ5KiDg79vkhWwrxaOjLNgQLnHT3xnU21+0fSKOVadXeWlrWBsmgy4+AKiIVhx0XRrU4DnXSrZN7NR3Sov9xwsEsxCNM5orcFSj618SPJFiSpCNsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIV0AYmjEd+dPMzCjq9Il6183wbQOvSeWZHRi9ZApJM=;
 b=qF+63vCNaRGcd81GK0jzFAO2WYVrq893fUdrPGSTeZtbcT/2T1E+oHVJ+kwgLN58zkUwIspaxNPz+3KRcJDJrOWzP+N7BJGLJCxxJvhp23O6xnCpO2OWzORoYWv/0AESfFV0kJxXmxt79PaauNizSIE4BNNW8DTfONqidcbmrgE8PFdNl4BENML6b16NIyvEA2acuWn2eth9qgT6h60kz/2N0pBYFnK3aKTOf1ftZJITAoshqS7nvO8t+YH/WDHv9boci/dUcxozwX4RrDbI6SR+exh7r6jnvV+4oYtaeuR/bKWHgF5Ouol4QF5LyBPdl4W1/mosT+IVvZeWOZU5TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by DS7PR11MB7859.namprd11.prod.outlook.com (2603:10b6:8:da::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Tue, 29 Sep
 2026 17:51:35 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0451.026; Tue, 29 Sep 2026
 17:51:35 +0000
Date: Tue, 29 Sep 2026 13:51:15 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alan Previn <alan.previn.teres.alexis@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Matt
 Roper" <matthew.d.roper@intel.com>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Message-ID: <arv6k7r5lnt95mDK@intel.com>
References: <20260929054444.1933871-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929054444.1933871-2-alan.previn.teres.alexis@intel.com>
X-ClientProxiedBy: SI2PR01CA0011.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::6) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|DS7PR11MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: dcd93b86-9cff-473c-e516-08df1e524d87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|366016|1800799024|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: xk2kv3mngQ1YokRjEWVCQfJ+kpomZtQ+VrSd3yl4qAh/klwdUc+zoUXuDfHUrW6uFbcb3kifnbvKOf0aN9tcxxz6MGBnq350K2t/rV/jDQ2v2D0grUnaqVppcbk7UlDMrMR4LTw5xtONpaaOHbv/Nxst/lwDakvKIcMQ7q912IpUzg8CrAvky/n8mLYYHZNlvp10mNAkKpbPtfGMtUzrTWLHJmB4sf1gH83NZXi4DM81SrxQ6uXUS4Oj9/nVih/+Yj4BMbbwQmlslaj9ZpBcZQKpn/soV2DC9oMGckAl2ar4Bg/iYPrB0kc68Tx4oJrTzYqNCMCRcGRHECmch3repcETg0sMWDu2P7wfbmNpKWwbIJBtygtKevLoilCHa14/GwY6L2+yn6mLKG6El8UkVZGZdWzYoZ5PnMJ1yyNMa2h+v8jIjPPp5eAD0vv65pMJd6pjFiuoOAbDx9oJFh64N1cHkuL0512pibOLsR5FcmFFswezdK3KJVmwTDlyFv4zx5iTEGuaNtK/QF9ZGAEXSfXOJ2qdfubuF31zysx7xYoBDejYAZCDGTqvQX5H0ycKSbofnQoSfLWT5ZjTWpkC/wnoj1Ft8CcQ/Zs4iR7RxwDeejVRHxFr46fMYTdZ3hA8732NdsArVSTf824uggV1iI1zsqk/hSdpQpYLYYSKhY8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+EuulCum7FqPol976OEjp4zPXj1yvecqvf4hYsvoIoZvcDNsbyKNWYBzivV8?=
 =?us-ascii?Q?HNOrAMUyrTSGPcqBtkBvux+w/Q3/eSH3tVDmzEXqBHrkWmDFmOhYP+Nc8dor?=
 =?us-ascii?Q?X/cBhz1d1ZgJKycrVxUXhIfufBh82dy22R50BdsM57vPoCyADrXrp/P5tAbp?=
 =?us-ascii?Q?BatnW0iKzcg3U7cGe4KgvEVZL4XNIuWKaF1JYEL+DQR+8FhqpMPuO/qBXJJ2?=
 =?us-ascii?Q?Pl5Wi9ZnWAAeHU+uzYTd6VBSLW4nIsaLVq5MHV58SrDjH/HEnzwt7jV9mj7S?=
 =?us-ascii?Q?ZU2+1Xx8tAQQYzZSjxi/Wsun7ekEqTwlsmfL7mkspmrs2EuWxsfR3tXmCTGv?=
 =?us-ascii?Q?iFxoFfsTQ8MjcTQL4RK3Z6iKV0+6UUkjtAp0hoT4az/SpddfE0bmhMIpDP4B?=
 =?us-ascii?Q?B41KbQHliUu8BLfWw5/Ia4BRl5eacB1St8P5Bsp8+3sJcctXB6FdLDcpomKn?=
 =?us-ascii?Q?WWVcIEoy7ddplXt1NiBGjgZHDjt20sj3NPfPZKdBXY83yG4yQCSAdXH1c3aG?=
 =?us-ascii?Q?DryIVdbUctTw6JpdRg/2IMg7GfXIeeM6iX+OqqOWmU8vU5T6s/0sItwXbVyZ?=
 =?us-ascii?Q?ptp03eY1NOtwmM95e+lrC191qgu4TLiUwLlkuOjIW8GF9K6zw8qtCHzjQA5V?=
 =?us-ascii?Q?E9g4wrRe4CO/8dao6XW3E45dsg4deTsWvwZqSz2T8gv/uih9N4phiBDgWlD/?=
 =?us-ascii?Q?pZvMaZy883D2fWuae51gnd+U2F3THKyB7Up2npKx+jLKf2Juh8cEPm5Y9vGK?=
 =?us-ascii?Q?JqLoGIIgxosXwKTlmZ/B65ApeXMK5IuDwKBbAIZq/E8u9F/c0k3xn/bp5pGL?=
 =?us-ascii?Q?RsyUTQhj0iqtc2fgU1CjNKg0Vob8v1840k3I9ecqymwpjGLMuHRtEca8qmC4?=
 =?us-ascii?Q?AimyNoAYkASrgvYpH1ZpvC7ipC0nWYisQ0Q3Pr7DrxDLcG6R+hrAMnxkH8jI?=
 =?us-ascii?Q?YfheU4fy/m+pfyPhqUVfmD8dIZoEdLlreOAnDcRzqOkAGbYaBra3eWcDX/Fv?=
 =?us-ascii?Q?18ow86/+oNUwWsJm4RtUILFychwYic3ygPF4BvrxorTo/QnL7D/YfAzH+pH9?=
 =?us-ascii?Q?cDVt3/MaisqzBdOxy3YFij64jp6SHZbsnSWnCxUVKGY40YjpH918fE3lfr/t?=
 =?us-ascii?Q?Qa4TlzqXr5Nvh+y54edjW8BbTEusvWTU0TOFG6tjtefJWmhUy9GBA3W3/zif?=
 =?us-ascii?Q?kdzaHUgZZTZ1V7VyDEoTA9FGqcOGWVvF4MQVwaJ6ux5ebGQb5zfZSR3nkBn/?=
 =?us-ascii?Q?Y7s/h5vTwN/pgxKimQM5rPPf085teVCRXHY9fMSepXcPMgYUHdyPg8ztRABP?=
 =?us-ascii?Q?f8l6NLWmFdEkZUMkZbVgKsY/m5TCA0Ztu08waUoSP3RCKTyMD5Iri/JtNGRQ?=
 =?us-ascii?Q?sRFeHiIywuASUe+25C9uDj/cWO4GZzp3KNr3Njj+wAWP/Al9HvxzhzlzXLJ4?=
 =?us-ascii?Q?uq6TlLGMw2YjNVfd+zthUQFaCGood/fV15sc++lMcKwVYgQzyZ86E3UoRQJB?=
 =?us-ascii?Q?Va61uDhBCrirDp6ScHewbYfoK/ThBqe1VzMx871FJ5Te2TMtH7s5nBNiwcYj?=
 =?us-ascii?Q?moZvBdOxPKBPeSgNKGdnFu9Udwv5HXq0acxrpEk+2/D4Hkr6FWH/G6I/Bb4h?=
 =?us-ascii?Q?O/qU2bGft2lOCs0ETZxmE93bkZyfQDdZ9H2SbrypV2D66COKzEGwvCx4Rp+G?=
 =?us-ascii?Q?mxpXOG1d5JG5s0IF5c7UiN0qnNxuAZ5ya5kqq9ZbgBhCvHLdS9EVSWOIrHlB?=
 =?us-ascii?Q?+9HcgmZ03ni/pK3ep+JOnTvQiZQNpTo=3D?=
X-Exchange-RoutingPolicyChecked: VQZ4iW9RouPwf6++VW1E09OiT60+2q39UGF/nwBb/q/+ebL68GyBkKeZESfJV24q3HwcE5RNysHmvWixbDW0E1MDziD6j6yG9zHTkZj3bKZ5RrxnThqLLoO0/SykwIY14i2+5WJVBZgJwO0si2vRXlp8YxxkobzT8hELzP0qxTfLMn2uKnHiihEYycxnEj1DstQh6vnepmWLi2CNIkteQXLVS/uplxOptZGsVP/o7TGQfLm1Wlig0IMjBXNtHthyLBIDu8C7JUA0RK9M6ih5xXKkLZeeGiKP3M6EsJlQ3SZAuP0z0Jllk4RJp7NkeixxDQkQy0IPJxtcfa4wk2kwUg==
X-MS-Exchange-CrossTenant-Network-Message-Id: dcd93b86-9cff-473c-e516-08df1e524d87
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 17:51:35.3294 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PcTGGDa5YTCp/Tjz6AqQ2/9eqqNZnnvgtBmVtIOGNS1XqXVNzwyAosWlGMbl/SUwFUOE2OOByk8kjMJ3G2hMDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB7859
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

On Mon, Sep 28, 2026 at 10:44:45PM -0700, Alan Previn wrote:
> Check for overflow in udelay/usleep_range use in __xe_mmio_wait32
> and pick the correct helper according to the wait time and atomic.
> Implement a similar helper to replace DIV_ROUND_UP for 32-bit CPUs.
> Avoid growing delays becoming intollerably large by capping the
> in-loop wait time.
> 
> v5: - Simplify: don't introduce additional redesign and
>       use min_t with a backoff to cap wait. (Rodrigo).
> v4: - Simplify using poll_timeout_us and poll_timeout_us_atopmic and
>       update all callstack to never use a param for atomic (Jani)
> v3: - Use div64_s64 kernel API for 32-bit vs 64-bit division.
> v2: - Fixed checkpatch failure.
>     - Added helper for 64-bit DIV_ROUND_UP on 32-bit CPU (Shasiko
>       review). Fixed bug max range in usleep_range(Shasiko review)
> 
> Fixes: 5c09bd6ccd41 ("drm/xe/mmio: Move xe_mmio_wait32() to xe_mmio.c")
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
> Assisted-by: Github-Copilot:Claude-Sonnet-5-0

Assisted-by: LLM

is enough nowadays...

> ---
>  drivers/gpu/drm/xe/xe_mmio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
> index 7fa18dfcb5a2..c7c37e59dab0 100644
> --- a/drivers/gpu/drm/xe/xe_mmio.c
> +++ b/drivers/gpu/drm/xe/xe_mmio.c
> @@ -350,10 +350,11 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
>  			wait = ktime_us_delta(end, cur);
>  
>  		if (atomic)
> -			udelay(wait);
> +			udelay(min_t(s64, wait, MAX_UDELAY_MS));
>  		else
>  			usleep_range(wait, wait << 1);
> -		wait <<= 1;
> +#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)

please move this outside of the function...

then Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>

> +		wait = min_t(s64, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
>  	}
>  
>  	if (ret != 0) {
> -- 
> 2.43.0
> 
