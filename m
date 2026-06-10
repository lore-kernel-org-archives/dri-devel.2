Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3832CD8C90
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 04:14:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47F2A10E6F4;
	Wed, 10 Jun 2026 04:14:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PF+1GtUR";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39B710E6ED;
 Wed, 10 Jun 2026 04:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1781064894; x=1812600894;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ibB/i7Pv9v0PwWfiEljmAxvqkAq0AJzikrtO3WSRKhU=;
 b=PF+1GtURaML/kbvM3rdjFqfEOn2VULowPz2c+pbofMBTgC2+Wgln4T7C
 InZOqJCXJK/QHM4u+kVkc+VU9xcjWV90BE5vbwgKziNZe5yV/srnmzeKR
 DJDeJGy3Mij2qEYBM1mqPwHoYgVUNDT5cDhKhePi3+AaQgtBUK07EqDGk
 RZ5fCIkQzB0EZ7H1JjU1AuJjK2eufW0j1DRP8IMJHFS7HPlwNpvAarmDY
 TBaDdYfsXpzD5UsRgL1vfuDEt8Qb2Z903XqiGt1/MUBrdMUowpQ4XTQ4U
 BkTS/PhUWLH3ANSDSewMWOYeN3Y4iiVIAdB/Fpe0SFjT+u3nvjJxSFezw A==;
X-CSE-ConnectionGUID: 9bB5EoNuQ4qcy+Xp2JbJAQ==
X-CSE-MsgGUID: SONotvosQrS1I2Yv5WWMTQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="107284775"
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="107284775"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 21:14:54 -0700
X-CSE-ConnectionGUID: W5qyFF1HQ7mwdBLdnYGovA==
X-CSE-MsgGUID: DKkVZ8SsQACiXZFMxY2xHA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,197,1774335600"; d="scan'208";a="251129803"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Jun 2026 21:14:53 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 21:14:52 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 9 Jun 2026 21:14:52 -0700
Received: from BN1PR04CU002.outbound.protection.outlook.com (52.101.56.68) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 9 Jun 2026 21:14:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hBpaD3WDbr9nU2DZfnfpQzCuUtV+bwRmDEjNZgfvIVnpvhWlLTlhWrcKKPClevvzZc0ENyii5L7OX7nYwxCifj3rvKX8DEdMow68xcEfkvomqDE7/DOaYoMCXWK36zCFma3qld0Pzhe0i3CDpQ4NDpClGMaC7ojQ5Mm8K3Hn3wOW9lDZ3hakK20L2VvN1ppshMtEfffR9nXGdJIeNli6EDD90y3NBi7NkhEaDspBmOKAYf+Cc6AZO0EVmz+NEQqCaqrjRdZmNVb4/tOwouGcPZH79wO3W1ydn4LbO+pEA8qG+AFGEa7ZoPXTITkvfWR4x40CIF+4xzqyxOvYpy5E5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qN4gBZFnhVlvhY7UQD8HniJ7/FZlPH7HLR/25B0h1Pw=;
 b=wQrPc3aN7o8vkUTdK8HhtsdYKUIG5MSneOrNAGVEBT1hjSmT/h9F8mt5U1H1fRmqR2qgXQQZaYPeYyFcxp0vp9hYKvGVOnHdAnTqAQAyc/2tlVquVJ5gjG3jl/hMXVSM1celz86R7C6IyK+5jfGJIi4Bg91A9dHIY4Vgh5zrFgEgBH9+4aOTHetoF9BHUK0KDDq002TLSPtTxJq/JpO9F7sIINnoc5NQDle1rZsvR58g5C0cj8DsjzmIQfQ5GrikJ+KU0Eyl4yrEQ0eLj2suACa+2QW57Kh+Sgf5TUHWpOU5I+ZgkF2u/zyXyr9EXis57y5scpYei42AD3DONqZdSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SAVPR11MB9576.namprd11.prod.outlook.com (2603:10b6:806:4e6::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.12; Wed, 10 Jun
 2026 04:14:43 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0092.011; Wed, 10 Jun 2026
 04:14:42 +0000
Date: Tue, 9 Jun 2026 21:14:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Honglei Huang <honglei1.huang@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <aliceryhl@google.com>, <Alexander.Deucher@amd.com>,
 <Felix.Kuehling@amd.com>, <Christian.Koenig@amd.com>, <Oak.Zeng@amd.com>,
 <Jenny-Jing.Liu@amd.com>, <Philip.Yang@amd.com>, <Xiaogang.Chen@amd.com>,
 <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>, <Junhua.Shen@amd.com>,
 <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <honghuan@amd.com>
Subject: Re: [RFC 3/5] drm/xe: have xe_svm_range embed one drm_gpusvm_pages
Message-ID: <aijkr+XH8FabaeiD@gsse-cloud1.jf.intel.com>
References: <20260603065620.2555316-1-honglei1.huang@amd.com>
 <20260603065620.2555316-4-honglei1.huang@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603065620.2555316-4-honglei1.huang@amd.com>
X-ClientProxiedBy: MW4PR04CA0195.namprd04.prod.outlook.com
 (2603:10b6:303:86::20) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SAVPR11MB9576:EE_
X-MS-Office365-Filtering-Correlation-Id: 92643903-5ef1-478d-33ab-08dec6a6cc50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|7416014|376014|23010399003|366016|1800799024|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 0+ObnNQB0b6FZ4d1NL8AJCO2jG/sn6uGd4ryypLFr4PSDU+ckZQXm5c/ITN15Zb+GHOPApdlPzIS/XStN3tbI99Nb3EeSfB/Es6PeucsTn9mTt2M+AMOhzPdf/IpV5N237YbDSao1qK+AfikUW8dXZb6Nuk4F6wdyuQqL5/tX+H01Zrsx+0CmiHcL/QIru/N3UBfXq6LEfKVYHWuhcT6rqUZZ6DyNsVk4X+PcxCDjI0rw1IaAfgndqIE66ISVcppwdCzEJHu4me4T7VGNo1ToPSQkn/eMsyT6l4j4EQtxL6/CrnDwDCHRJ833Oxdmm8D6SQ5PH6IkhBt1FA5uGzlnAPd9TbPpDLzJXEBYTkWK4nybmgdxREZsm51Hp6iXGL6rrdptWBsQb0rohOPmz5grNBlW+7HgUGB3t14IlhcbdTjJX6KX2V6jzT7L7hoTA5i+aSsb9jIzYybdvIFndQc7TBMU3lk2ptAYEWKFcBE3wk7F5pFc+mfq+nLmWwmnGkzLEZUh049urmyPz/u+MoKRLWJyr1vlMGXuXyf0T5/XHJvK0c4S4wezzufSKDEcKresA4+hv2+HA2hb1lgEvfZUJr+H67o/FPY5EdExKLpSASiYNicbV5BfuXKSRmNc1BhpMQ8cU96iwwq08nOj9ldwujnWxle5j65SbX9SFnc+/vke2KlWeJCYvgspvjoifSc
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(7416014)(376014)(23010399003)(366016)(1800799024)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?SyDd/Ar7BYMJXxX5zl/b5U/H2YmrmpmIaMo9gRaRRcfJWTod+r2p2rsc5Lwq?=
 =?us-ascii?Q?XAjmH1hBoe3BnTzQf5kqZwvXZhR0OiNnDGDaWobm3cxZfIv6Tce5iDuV33Ei?=
 =?us-ascii?Q?RShmYx0pr3glN922tVBt27OQcB0WvEM0YpkM2gu9FFHW3oChiCn9CaUYHjSi?=
 =?us-ascii?Q?kK3MIkiBv0x9Cvv1iX6dzfFqJWeQoFc9k0vAt4tfSYO4IR67syv3iykfe1xo?=
 =?us-ascii?Q?QhdDRYtnZQs/UwRL7RrdcmPp07MC7OniTucMFeJAeTmvLzC83kM+wVjTa3PC?=
 =?us-ascii?Q?eE+zpoAr0ndwJMNLJzrVaSv8qRQ2GdkZior/pjQTZ75lQEfVDgw3YVxa1DD5?=
 =?us-ascii?Q?Cfex0hs11QVmVM9cwDE2HNRNOHsZhPjzaYmdguT66bJCITqL+QyER9EhVz0T?=
 =?us-ascii?Q?0/Bc6ObXVV7mBJAOrtrHlRZRzvfcIDNvlGIu3gA1qVckXIxKewLs9qubhW4/?=
 =?us-ascii?Q?AYYEPSJAfxQVSIo6R39R2FFjSCfj37S6PfbDMghgAJQgjZ/RWqsZzjNJGuad?=
 =?us-ascii?Q?dD6lZiTQhinteOM3ULgbFNDrb9ZkFkCbrofcPXEPXHTbohZ8PN1SXlCyQNfi?=
 =?us-ascii?Q?RHUk+wuUBvBhh9KzpS+tIPq/95uQYYzZPetUQ/pvmUzs5oCx4jx3yUk27Tc/?=
 =?us-ascii?Q?LMo++g0atRJlUIgPpoOkZNDmiK1+6PAO1jCRy7oTwII7vweZWwELld2OOTZd?=
 =?us-ascii?Q?HUNd+N3o/SWxiFPggcrz8eCEsYoMfJ4UX5znKtdpSgATJlqru1iJB7talPa/?=
 =?us-ascii?Q?RAUImOY0wtDUR7VyZFAL7yQju5V4SVQ17rZdlVwM4Py1fQTKPN7J+YSNHTVl?=
 =?us-ascii?Q?jnAZ3A+DB0UUEEAPk67YzqU6GtGmb9UW7qG3/bJ+wd/YQQroyYpl5qZHq+4P?=
 =?us-ascii?Q?YOFVWdndKTp15c9Nr/4gJ5eG99xN7F08zhVUVHpVFwyExHeNsqb59jLGlgec?=
 =?us-ascii?Q?7TgAY3xZidybeAGJHfRVvMpwH2D53RsAXAU+gP82+D88DbO7iCFIgBnWIAIQ?=
 =?us-ascii?Q?3P8MyLYaefuYtLzDL6XMhZsCBzrLz3P59u7+0MR6u+U/p+LGenxQXoocuAL9?=
 =?us-ascii?Q?zC3Obp14h2b2MpdZwE6jKkyGYhLyYL/IS7O5uZ8sSUzdhvTDok3bOgGif/CK?=
 =?us-ascii?Q?+jl3vOFaZeBgs4hct5xt7uuroPtc1mZuHSClR35NmSmPyBFGVg+341FFD1m8?=
 =?us-ascii?Q?HurKFOJBgWj7u6se8Oh+ClJG9nBoRO/dSSeC4YW3dqGL/paqOm+PkbQWkntH?=
 =?us-ascii?Q?liq7RbdnbbHxVwr4toUdNDTeDreJQ8AlqMVRkFC7zyx1yR2/u3eiorxgQacC?=
 =?us-ascii?Q?D3nGpLotl3LsP6uaO0IqCAmKVAdwD23TFzOPJdiZqgFoKjfoc33tRvzph7HA?=
 =?us-ascii?Q?mv41KF4EL86vSk+mUJuDiIKOCJoybqCo6ooKrKY6MGf3bHn0KXi7y73jvGjG?=
 =?us-ascii?Q?JNEJ+3tFcarR5/Z73LlEmSpdkg8i+LF1Buhv3x+0p4XFoDNxK5WOa5H07Hqd?=
 =?us-ascii?Q?EzwCt9y01RAAgzk1qCHZVgxXrQhtvzKOvKtodzDVneQgecxHQur+SLURJC9M?=
 =?us-ascii?Q?C+CCV/DpZffD8iAtsKEZchqmJk0gqf77Abz42JaNdcXSkS4sBwKD9ue5b6YY?=
 =?us-ascii?Q?tvZ7OM2V7PGP/BvjjecLavlEmR1WA2Z7wRAoxRgXS+YF9ilf5g58c9F6Orin?=
 =?us-ascii?Q?6VcWp5QyrAsLfcI74UOsvvD3KO+tbPT51pC0JxJx1Fj8ToAs4z6mgNRPOdNl?=
 =?us-ascii?Q?DmclWP5UN5aPztEY+1zM8xrZlB2XoWU=3D?=
X-Exchange-RoutingPolicyChecked: UfJZNQqRqZF5WlPuxkPwrlLI66flUcPugaBpriAUbJt8hpdViYY+Hk0fdKKDvnaDj4ECLYc4OTt1bRNXoijnWljtv47m07eYwBCMXA3hNoFuQw2Y7Kjl/G37u10jPrEeoxDsGxCkY805KZjQWB86colRIrM77K6cm7nafu3cEJ5dhz3ATmCIQRxYsKi6yqvPENwNov4tOcb/jqxoxyCIKIsgi08PaV6C/UmBMvroJ8Aix0wCBJTcRwlT21f/xO/hNSUwEs2VOPD/XieDekBV2wy3Vjnl+lOLbG+7bLjpPuW5SWnKClidRsnFTHppGJp1ibdymD8WKYs86GAALdWSyQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 92643903-5ef1-478d-33ab-08dec6a6cc50
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2026 04:14:42.9113 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fYxtjsWKqOrfdFAdWc1xQEVnNU4CXutLjDvubf4DtTrtq5whNYGrLxMZyKj1wxpE4rCqDFkk7dNQclCptda3Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR11MB9576
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

On Wed, Jun 03, 2026 at 02:56:18PM +0800, Honglei Huang wrote:
> From: Honglei Huang <honghuan@amd.com>
> 
> With drm_gpusvm_pages now self contained, make xe stop relying
> on the drm_gpusvm_range pages and take responsibility for the page
> lifecycle on the driver side.
> 
> Driver side (xe):
> 
>   - Embed struct drm_gpusvm_pages in xe_svm_range and route all
>     xe accesses through it instead of range->base.pages.
>   - Take over the page lifecycle: xe_svm_range_get_pages() calls
>     drm_gpusvm_get_pages() directly with &xe->drm; the notifier
>     event_end and xe_svm_range_free() paths drive unmap/free on
>     the embedded pages object.
>   - Switch xe_svm_range_pages_valid() to drm_gpusvm_pages_valid().
> 
> Framework side (drm_gpusvm):
> 
>   - Export drm_gpusvm_pages_valid() to let driver owned pages
>     can query mapping state without going through a range.
>   - Contract change: drm_gpusvm_range_remove() no longer unmaps or
>     frees pages; drivers that own a drm_gpusvm_pages instance must
>     do that themselves.
> 
> Side effect / contract: drivers that own a drm_gpusvm_pages
> are now responsible for its lifecycle, in particular for calling
> drm_gpusvm_unmap_pages() and drm_gpusvm_free_pages() at the
> appropriate points.
> 
> Suggested-by: Matthew Brost <matthew.brost@intel.com>
> Signed-off-by: Honglei Huang <honghuan@amd.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c |  9 +++------
>  drivers/gpu/drm/xe/xe_pt.c   |  2 +-
>  drivers/gpu/drm/xe/xe_svm.c  | 22 +++++++++++++++-------
>  drivers/gpu/drm/xe/xe_svm.h  |  9 +++++++--
>  include/drm/drm_gpusvm.h     |  3 +++
>  5 files changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 3f076178b2a..a4b56cefeb2 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -1231,8 +1231,6 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_free_pages);
>  void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
>  			     struct drm_gpusvm_range *range)
>  {
> -	unsigned long npages = npages_in_range(drm_gpusvm_range_start(range),
> -					       drm_gpusvm_range_end(range));
>  	struct drm_gpusvm_notifier *notifier;
>  
>  	drm_gpusvm_driver_lock_held(gpusvm);
> @@ -1244,8 +1242,6 @@ void drm_gpusvm_range_remove(struct drm_gpusvm *gpusvm,
>  		return;
>  
>  	drm_gpusvm_notifier_lock(gpusvm);
> -	__drm_gpusvm_unmap_pages(gpusvm, &range->pages, npages);
> -	__drm_gpusvm_free_pages(gpusvm, &range->pages);
>  	__drm_gpusvm_range_remove(notifier, range);
>  	drm_gpusvm_notifier_unlock(gpusvm);
>  
> @@ -1324,13 +1320,14 @@ EXPORT_SYMBOL_GPL(drm_gpusvm_range_put);
>   *
>   * Return: True if GPU SVM range has valid pages, False otherwise
>   */
> -static bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
> -				   struct drm_gpusvm_pages *svm_pages)
> +bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
> +			    struct drm_gpusvm_pages *svm_pages)
>  {
>  	lockdep_assert_held(&gpusvm->notifier_lock);
>  
>  	return svm_pages->flags.has_devmem_pages || svm_pages->flags.has_dma_mapping;
>  }
> +EXPORT_SYMBOL_GPL(drm_gpusvm_pages_valid);
>  
>  /**
>   * drm_gpusvm_range_pages_valid() - GPU SVM range pages valid
> diff --git a/drivers/gpu/drm/xe/xe_pt.c b/drivers/gpu/drm/xe/xe_pt.c
> index 2669ff5ee74..e82b0d8fab1 100644
> --- a/drivers/gpu/drm/xe/xe_pt.c
> +++ b/drivers/gpu/drm/xe/xe_pt.c
> @@ -758,7 +758,7 @@ xe_pt_stage_bind(struct xe_tile *tile, struct xe_vma *vma,
>  			return -EAGAIN;
>  		}
>  		if (xe_svm_range_has_dma_mapping(range)) {
> -			xe_res_first_dma(range->base.pages.dma_addr, 0,
> +			xe_res_first_dma(range->pages.dma_addr, 0,
>  					 xe_svm_range_size(range),
>  					 &curs);
>  			xe_svm_range_debug(range, "BIND PREPARE - MIXED");
> diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> index 3acfddb7c5b..33c26df5111 100644
> --- a/drivers/gpu/drm/xe/xe_svm.c
> +++ b/drivers/gpu/drm/xe/xe_svm.c
> @@ -66,7 +66,7 @@ static bool xe_svm_range_in_vram(struct xe_svm_range *range)
>  
>  	struct drm_gpusvm_pages_flags flags = {
>  		/* Pairs with WRITE_ONCE in drm_gpusvm.c */
> -		.__flags = READ_ONCE(range->base.pages.flags.__flags),
> +		.__flags = READ_ONCE(range->pages.flags.__flags),
>  	};
>  
>  	return flags.has_devmem_pages;
> @@ -96,7 +96,7 @@ static struct xe_vm *range_to_vm(struct drm_gpusvm_range *r)
>  	       (r__)->base.gpusvm,					\
>  	       xe_svm_range_in_vram((r__)) ? 1 : 0,			\
>  	       xe_svm_range_has_vram_binding((r__)) ? 1 : 0,		\
> -	       (r__)->base.pages.notifier_seq,				\
> +	       (r__)->pages.notifier_seq,				\
>  	       xe_svm_range_start((r__)), xe_svm_range_end((r__)),	\
>  	       xe_svm_range_size((r__)))
>  
> @@ -115,6 +115,7 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
>  		return NULL;
>  
>  	INIT_LIST_HEAD(&range->garbage_collector_link);
> +	range->pages.notifier_seq = LONG_MAX;

As discussed in the cover-letter let's do a drm_gpusvm_init_pages()
function to set the notifier_seq.

If we want to include 'drm' in the init function as discussed in patch
#2, to fish this out in Xe you can do '&gpusvm_to_vm(gpusvm)->xe->drm'.

>  	xe_vm_get(gpusvm_to_vm(gpusvm));
>  
>  	return &range->base;
> @@ -122,8 +123,10 @@ xe_svm_range_alloc(struct drm_gpusvm *gpusvm)
>  
>  static void xe_svm_range_free(struct drm_gpusvm_range *range)
>  {
> +	drm_gpusvm_free_pages(range->gpusvm, &(to_xe_range(range)->pages),
> +			      drm_gpusvm_range_size(range) >> PAGE_SHIFT);
>  	xe_vm_put(range_to_vm(range));
> -	kfree(range);
> +	kfree(to_xe_range(range));
>  }
>  
>  static void
> @@ -208,7 +211,8 @@ xe_svm_range_notifier_event_end(struct xe_vm *vm, struct drm_gpusvm_range *r,
>  
>  	xe_svm_assert_in_notifier(vm);
>  
> -	drm_gpusvm_range_unmap_pages(&vm->svm.gpusvm, r, &ctx);
> +	drm_gpusvm_unmap_pages(&vm->svm.gpusvm, &(to_xe_range(r)->pages),
> +			       drm_gpusvm_range_size(r) >> PAGE_SHIFT, &ctx);
>  	if (!xe_vm_is_closed(vm) && mmu_range->event == MMU_NOTIFY_UNMAP)
>  		xe_svm_garbage_collector_add_range(vm, to_xe_range(r),
>  						   mmu_range);
> @@ -952,7 +956,7 @@ void xe_svm_fini(struct xe_vm *vm)
>  static bool xe_svm_range_has_pagemap_locked(const struct xe_svm_range *range,
>  					    const struct drm_pagemap *dpagemap)
>  {
> -	return range->base.pages.dpagemap == dpagemap;
> +	return range->pages.dpagemap == dpagemap;
>  }
>  
>  static bool xe_svm_range_has_pagemap(struct xe_svm_range *range,
> @@ -1017,7 +1021,7 @@ bool xe_svm_range_validate(struct xe_vm *vm,
>  	if (dpagemap)
>  		ret = ret && xe_svm_range_has_pagemap_locked(range, dpagemap);
>  	else
> -		ret = ret && !range->base.pages.dpagemap;
> +		ret = ret && !range->pages.dpagemap;
>  
>  	xe_svm_notifier_unlock(vm);
>  
> @@ -1510,7 +1514,11 @@ int xe_svm_range_get_pages(struct xe_vm *vm, struct xe_svm_range *range,
>  	if (READ_ONCE(range->base.flags.unmapped))
>  		return -EFAULT;
>  
> -	err = drm_gpusvm_range_get_pages(&vm->svm.gpusvm, &range->base, ctx);
> +	err = drm_gpusvm_get_pages(&vm->svm.gpusvm, &range->pages,
> +				   &vm->xe->drm, vm->svm.gpusvm.mm,
> +				   &range->base.notifier->notifier,
> +				   drm_gpusvm_range_start(&range->base),
> +				   drm_gpusvm_range_end(&range->base), ctx);
>  	if (err == -EOPNOTSUPP) {
>  		range_debug(range, "PAGE FAULT - EVICT PAGES");
>  		drm_gpusvm_range_evict(&vm->svm.gpusvm, &range->base);
> diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> index b7b8eeacf19..ea73241d3d9 100644
> --- a/drivers/gpu/drm/xe/xe_svm.h
> +++ b/drivers/gpu/drm/xe/xe_svm.h
> @@ -31,6 +31,11 @@ struct xe_vram_region;
>  struct xe_svm_range {
>  	/** @base: base drm_gpusvm_range */
>  	struct drm_gpusvm_range base;
> +	/**
> +	 * @pages: Per-device DMA mapping state; single instance since
> +	 * xe svm is 1 svm : 1 drm_device.

s/xe/Xe

Matt

> +	 */
> +	struct drm_gpusvm_pages pages;
>  	/**
>  	 * @garbage_collector_link: Link into VM's garbage collect SVM range
>  	 * list. Protected by VM's garbage collect lock.
> @@ -74,7 +79,7 @@ struct xe_pagemap {
>   */
>  static inline bool xe_svm_range_pages_valid(struct xe_svm_range *range)
>  {
> -	return drm_gpusvm_range_pages_valid(range->base.gpusvm, &range->base);
> +	return drm_gpusvm_pages_valid(range->base.gpusvm, &range->pages);
>  }
>  
>  int xe_devm_add(struct xe_tile *tile, struct xe_vram_region *vr);
> @@ -132,7 +137,7 @@ void *xe_svm_private_page_owner(struct xe_vm *vm, bool force_smem);
>  static inline bool xe_svm_range_has_dma_mapping(struct xe_svm_range *range)
>  {
>  	lockdep_assert_held(&range->base.gpusvm->notifier_lock);
> -	return range->base.pages.flags.has_dma_mapping;
> +	return range->pages.flags.has_dma_mapping;
>  }
>  
>  /**
> diff --git a/include/drm/drm_gpusvm.h b/include/drm/drm_gpusvm.h
> index ed228d9ff6b..21baf91ec7e 100644
> --- a/include/drm/drm_gpusvm.h
> +++ b/include/drm/drm_gpusvm.h
> @@ -306,6 +306,9 @@ void drm_gpusvm_range_put(struct drm_gpusvm_range *range);
>  bool drm_gpusvm_range_pages_valid(struct drm_gpusvm *gpusvm,
>  				  struct drm_gpusvm_range *range);
>  
> +bool drm_gpusvm_pages_valid(struct drm_gpusvm *gpusvm,
> +			    struct drm_gpusvm_pages *svm_pages);
> +
>  int drm_gpusvm_range_get_pages(struct drm_gpusvm *gpusvm,
>  			       struct drm_gpusvm_range *range,
>  			       const struct drm_gpusvm_ctx *ctx);
> -- 
> 2.34.1
> 
