Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DC03C9830E
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 03:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C92B810F166;
	Wed, 30 Sep 2026 03:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WL6GgXYA";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3907A10F166;
 Wed, 30 Sep 2026 03:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790740314; x=1822276314;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GVLOIZQgCig2F3FAe4BvD5ipgcIye5Iu52e5KL1Qpn4=;
 b=WL6GgXYA+/+4P1pJoQk8qWnZsWhsK9qjQFI+NGmYTQgiCwo3rJjHk8CZ
 ttiTytU4CotbXGmxkSAXtz2TWiuXnpVVf0pcdqIJ/iLD7VwgzeaPVXJ9L
 PZYAGEorMDBKPB0oSfGNj6LiSa9sGHP1aEJaSVAlnJ7KwHBMUALxiIIJB
 5MSvLUPr3A9UtlXW07bkXTJpEgJoiiYFUXfRXHaB7wsSu4DS9UNcEuC9k
 D5+q3fNor/1UDYkgsTnA7sbJ/XYE4fTX4pWHVhBqACWeQgNeZeIXyQtoQ
 7WFWVPW5buFw2/cykR8L8CHVyo6n18I4vkiVS6ahvVz/rZpuMCffuGVjB g==;
X-CSE-ConnectionGUID: 1kMfFVnwQ1afJPAUU2dIOw==
X-CSE-MsgGUID: N9VCKt2RRgCI8/SR9oOe4Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11920"; a="91488691"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="91488691"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 20:51:44 -0700
X-CSE-ConnectionGUID: CSWKD+EfTXWeUGwexUYgyg==
X-CSE-MsgGUID: d5CBuaCnRLGVcbQYhYma2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; d="scan'208";a="273656942"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 Sep 2026 20:51:44 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 20:51:43 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 29 Sep 2026 20:51:43 -0700
Received: from BYAPR05CU005.outbound.protection.outlook.com (52.101.85.7) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 29 Sep 2026 20:51:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq70u2iVxw0NjBjGGIhoF+TQ+gvBVSn8WsP/596hkhOF3ySCyjfYw932AMA0M+iu8bVyp7yYTctTmnAlB2opK6Iv3ynw38mdklgp2U+Cq0C4k1X3OPFY0X3ESe+RDo+KxOlyaaAN941zS8abtNIGF+Z69GZ9Cb6N6a4DoMWBGjLiEXUqporQbysWJBSHzr+FZq6tERfiS8XiuHiGWS2j5G0KTXmBPFd0o5TYCaZtO7dKqeSXHASnR6FxPBIxn3xbcK29C3I30s3LrbvHCCS6j4X4Ym8xWFXZPhvuNZIKbcSRR48IsC6g5wvG2GfabtErwQhgLbtEFIcDVvJw8ObHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEIECEoYEIhegPSJ1Lp4pP4DzZhQi1ADM0Dsh1yp+rA=;
 b=pSg1mW0xL/VT65HbXZo+VwWKvPXFcPfGSlyK/JICTeBIPahU32wsHD3LNiQ0jqPNhawA5uAG7Jy6wJuvj5A4Yx5zUVSpiHnoT70zYmrzHKX5/1mwbZj4cOKNtHbhTVqqj6UlS4pY/F6g2t14D6hEu1FE5A0Mqs2FMOkyhhRgE6BDouEjCKFxms3b3tu8FZYfMdLvoLhwxjwI/93NgcuoFxLcySwtgqalkExaLAmhqH1cMXiI9B4G8kjwE5m8pfUGeBFP0FUgZBgSd1AEaVPKxawHmHokzao8vRIQcrJ6g9LOXuHpk3NcwwE+5gd+fVpnx0fifTF0529DaqPNS/TrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12)
 by LVUPR11MB9566.namprd11.prod.outlook.com (2603:10b6:408:39e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Wed, 30 Sep
 2026 03:51:41 +0000
Received: from IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565]) by IA0PR11MB7187.namprd11.prod.outlook.com
 ([fe80::be96:3f58:953d:6565%4]) with mapi id 15.21.0451.026; Wed, 30 Sep 2026
 03:51:34 +0000
Date: Tue, 29 Sep 2026 23:51:22 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Alan Previn <alan.previn.teres.alexis@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>, "Matt
 Roper" <matthew.d.roper@intel.com>, Jani Nikula <jani.nikula@intel.com>
Subject: Re: [PATCH] drm/xe/mmio: Fix xe_mmio_wait32() to honor delay/sleep
 maximums
Message-ID: <aryHOoaUA-GrZA9Q@intel.com>
References: <20260929192037.2233429-2-alan.previn.teres.alexis@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260929192037.2233429-2-alan.previn.teres.alexis@intel.com>
X-ClientProxiedBy: SG2PR02CA0122.apcprd02.prod.outlook.com
 (2603:1096:4:188::10) To IA0PR11MB7187.namprd11.prod.outlook.com
 (2603:10b6:208:441::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PR11MB7187:EE_|LVUPR11MB9566:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e77e14d-58f0-4580-b00e-08df1ea61eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|366016|10067099003|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: rHD3FQw9fntLQM09ipuegy84jIqfPKP09kqSKglGi9Z4MthCaB14dTjP0M+lrv6L5WyOnEO3hw+Mw8gQrLtx1NM/WifOFs6JbAF/U0Dz9mg1xmlCPyTjuAEYI6O2xHGpd8lViSq1bRscbn+QYqL+b2ISLYDDihmSDZJIhQvtIePzxhZPhtpUsaAXc1SdeIHuQ7h4K4eGQZcwzw8eAQMGZaEnBgZ26feM+YpHN/jwyK1F6I5KgYJ0wpmQhhNLGzBm+VhlA1Q3SjEZbphxQ9xArKb2qvD+CFB7Gxgd61ZH1CW7nwyP2LEpmyd/RAQ6YH2VViUS2NrLi4cZI1hoPrqKsBJjJzyQ1+iizXCClMLzLOy7M2Y7kGufWKvnTdizER6HTYleyMZCVtEiZ+91n+p7L7QgozeQsQMcf0neYTlQaZYudrs9Kq8fzx3cxrSldr/NY/uoo/lCEBwulIAWoKhO+9TYVr1FGRysfGcq746GTo+QA9UqN6C4icjLvE+vx4ZlVzccM15T5q2Mcqm4Fv4+ZhOGcc7uNrgPpNwx1Dn2xFnnI53/4fXYetcyVac+l9dwly1mhWglYIHrDHqznVt/WrrsjeRk8FVqs9tHva6IIB0srzCr76x8V5gpffICE+QUpv7xvUncnfU7LIH0SJGF79DTtpHGpmpB6PV98ogfglU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:IA0PR11MB7187.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(366016)(10067099003)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cajXJZaNO3EKOK4CABM7IGGU44pR6HISmphy1Vxqor7aj8Gc7IeIjX0AhdWa?=
 =?us-ascii?Q?RUTv/TdSljrLuNCoJG0kR9gewkDbnL/4zu+85cEhCXob/6Y+AElQYS+Dx/P8?=
 =?us-ascii?Q?3x/+9+IQhjeu3eLU+Nr0Rd0SEofQ267IO3hhrl+Z7rLcvYx07a38ihj/3TlB?=
 =?us-ascii?Q?poHGxva3NMIfKnyq7kYL7JLwf/f/IGPVqT3XKjlpNKrVNUCRbdHZkw/l7rN/?=
 =?us-ascii?Q?dQvhVTSL0cy35VIzcXBC0A9W+7EyHzN8mQ3BDrbahK3MJG1xcs49RP+1v+vX?=
 =?us-ascii?Q?91OAg7aXnXEbBziUI9BvwvRebHVbJw58KpOfNgubabaf0c55DD5XVENaQcgJ?=
 =?us-ascii?Q?7sJsw/kDNcX6uK83GTnqbaynW11d3TKhlpwKGoRPKjUdTfX7/rXVp5LST0LN?=
 =?us-ascii?Q?cQKAE4m4KC7XPPu5nlzPfH4z1oZiDIbLm9kP66FqFOIurO6hXeJWb6rravb+?=
 =?us-ascii?Q?9L4kBA0/hZyEMQKezxhk/Q49o/Gu62LQWqGHoTDrgT+6UoYO92v2mmJsSlAf?=
 =?us-ascii?Q?yoPk/KstmVGpVZ8PYR+IO3BncAKWbsFeg/R+vLu/2Exa5YSd+W+8TCyMPKS/?=
 =?us-ascii?Q?a2Gq/50wXN/HFT3z9UAx6AJJdf7kt5izDsf8iU5DdNWj67M8RA3JzlCB1d6+?=
 =?us-ascii?Q?OfgLOpJUUqSwEqyhJUt7tREjHHE6qIikRq5H/wBSAB8bdnJ4MdsTPmgZk+3h?=
 =?us-ascii?Q?iqk7GJWHZ60vCpCVN5gYcZku6UjEA6hJfxtWuyFQVQ3zD3url71ExiGl+PXl?=
 =?us-ascii?Q?ErJiTz/X+7KyrNpy/q5+lSrmxWo0lCo5duZdBGj1Ar7Ir8rtDZlakOfEwcV/?=
 =?us-ascii?Q?ddC3GCCptw8sqp6byL5l0iUNWsUYgaG+dJcF66kQwmmtR1ciUtrltxTqw3i1?=
 =?us-ascii?Q?jFhnVha/d13Yv7u1BalD1Lqtd7PVYhipAxuyYgXaJPNMG0jVpKRyeyB+g+XQ?=
 =?us-ascii?Q?bhWOSggsTY8koHuz9auFyflmlcuOuRrNc+bo34s3mihF9C8/xOr1hhHdInt5?=
 =?us-ascii?Q?T0jEHzjOOVTGfYyixYwYFbeBvHI8IXSoal9NOhoVRBdxMLqFvN88P7R7lRry?=
 =?us-ascii?Q?x0320cZtp0ctiV/O6WdLxIwr3xzZ2sWUjHBD0YWDXKDE/WG4x9veXqmm2OVo?=
 =?us-ascii?Q?6Q+ywrh7OMABEZzPKCwz6VBuqIp8KzQO2w6+x/cVpdURoiwHh/RvEl7an45M?=
 =?us-ascii?Q?+s0/dIIiT2uyb3t7TzRhDQYUHAfd5ysVl5iTyU3T2cIQ+qzCme4khtIad34s?=
 =?us-ascii?Q?DFXzvhoTeGihM3LldMXJieGjvA0Qq3jWWihi9qT7PVD/ExBG3sEkJjzpBDtF?=
 =?us-ascii?Q?5pmZV7LTsZJ28h2CAOMa4WD5Z+xV4mmkXWjr7ocorX6osDhJ4q9fVuSChFRy?=
 =?us-ascii?Q?zxepFIi8b9nc7+BwA0GxvP393bTLoD2WfNvNVN2LVKSMzg4rh3urGWiSWHRk?=
 =?us-ascii?Q?L6JPBTd90h3RsNVHYrH2uQ8S2z6kHHU0RdygJRvgG1OSErzcIkmuXNmPXXno?=
 =?us-ascii?Q?+qdrciES+7VWaGTp4m9NpPt0j1sMOK0SpeoEX9qpJqny35nDqCdeM4o5qlBl?=
 =?us-ascii?Q?JxZiflaj9/1IEOcnFOzKwfpaxvF4JIQBDTlWhf80iCud5UJdQr9oW3YcsVGN?=
 =?us-ascii?Q?5/R93KD/NI/iUh8x9CH/ZeWSwnYTSCu9b9Ya4cIIHuRnas36mTeyDE2dkNCL?=
 =?us-ascii?Q?gR/VZTJkZhxUJJRmiCnW9XJfAnbqugRbKDcj8Um3ZMC9K0Y+bI9w/VpUb0oz?=
 =?us-ascii?Q?FSiZzZ9ohS5GV7FYU6qFTEAkJ6mH8k0=3D?=
X-Exchange-RoutingPolicyChecked: IeQ2ODc8zDoLRlDGEdMevIe5qe8B2X7RmE8968WmeUqd3rFSe2+7f0eJRHyZGCwrXPNnTkkhDuZEQ75xV7INpEY4FXUWfpFeg8BxR3HsPo1Nlf2l/HS9ybr5rUG1/qi9G7R34jKpU2FaI+V8Zc4IyPOlyoz+6M21zy/lY2H9dZREr/jcVC86P7TF0fmp81MkRtBsuKZMx2lgQJgaVYIOIm+jiNOu7D3DmrFAXE+rfwDTnTtt37W4/dEV8vI84ZdDbodlFavWp3YqvwFcON85+wzeFGDnY2eu6GpMLReSX0tnaEySE07LoD+I0vWgw+9V4BWXw+YrfhGNAM2EbtIy+Q==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e77e14d-58f0-4580-b00e-08df1ea61eb8
X-MS-Exchange-CrossTenant-AuthSource: IA0PR11MB7187.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 03:51:34.2756 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FpQQezDd4bCofVJOwNmdidFEoY+3YlA8ZsHW2z8/VWUdMOY7NMooeH9+TwPw4JVHY+C1B9pDCJojTMMD3oIFOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9566
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

On Tue, Sep 29, 2026 at 12:20:37PM -0700, Alan Previn wrote:
> Check for overflow in udelay use in __xe_mmio_wait32 and
> avoid growing delays becoming intollerably large by capping the
> in-loop wait time.
> 
> v7: - Change assisted-by to "LLM" (Rodrigo).
>     - Move the max-wait macro to outside the function (Rodrigo).
> v6: - Fix commit message to remove items dropped in v5. Fix the
>       use of MAX_UDELAY_MS for microsecond unit. (Shasiko review).
> v5: - Simplify: don't introduce additional redesign and
>       use min_t with a backoff to cap wait. (Rodrigo).
> v4: - Simplify using poll_timeout_us and poll_timeout_us_atomic and
>       update all callers to never use a param for atomic (Jani)
> v3: - Use div64_s64 kernel API for 32-bit vs 64-bit division.
> v2: - Fixed checkpatch failure.
>     - Added helper for 64-bit DIV_ROUND_UP on 32-bit CPU (Shasiko
>       review). Fixed bug max range in usleep_range(Shasiko review)
> 
> Fixes: 5c09bd6ccd41 ("drm/xe/mmio: Move xe_mmio_wait32() to xe_mmio.c")
> Signed-off-by: Alan Previn <alan.previn.teres.alexis@intel.com>
> Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Assisted-by: LLM
> ---

pushed to drm-xe-next.

Thanks a lot for the fix and the patience ;)

>  drivers/gpu/drm/xe/xe_mmio.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_mmio.c b/drivers/gpu/drm/xe/xe_mmio.c
> index 7fa18dfcb5a2..455a07d79cd9 100644
> --- a/drivers/gpu/drm/xe/xe_mmio.c
> +++ b/drivers/gpu/drm/xe/xe_mmio.c
> @@ -320,6 +320,7 @@ u64 xe_mmio_read64_2x32(struct xe_mmio *mmio, struct xe_reg reg)
>  	return (u64)udw << 32 | ldw;
>  }
>  
> +#define __XE_MMIO_WAIT_MAX_BACKOFF_100MS (100 * USEC_PER_MSEC)
>  static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u32 val,
>  			    u32 timeout_us, u32 *out_val, bool atomic, bool expect_match)
>  {
> @@ -350,10 +351,10 @@ static int __xe_mmio_wait32(struct xe_mmio *mmio, struct xe_reg reg, u32 mask, u
>  			wait = ktime_us_delta(end, cur);
>  
>  		if (atomic)
> -			udelay(wait);
> +			udelay(min_t(s64, wait, (MAX_UDELAY_MS * 1000)));
>  		else
>  			usleep_range(wait, wait << 1);
> -		wait <<= 1;
> +		wait = min_t(s64, wait << 1, __XE_MMIO_WAIT_MAX_BACKOFF_100MS);
>  	}
>  
>  	if (ret != 0) {
> -- 
> 2.43.0
> 
