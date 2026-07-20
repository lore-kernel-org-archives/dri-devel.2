Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 944C0C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 18:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C558110E10C;
	Mon, 20 Jul 2026 18:54:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Wxwfu2Oj";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 80F7710E107;
 Mon, 20 Jul 2026 18:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784573697; x=1816109697;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5sMF36oDZ2Q3Yo0w4KBtP0CW1PxV8wAEJQ7AHZWgtog=;
 b=Wxwfu2OjqSSEM3JRDZYgDNdREewGkhxXEllCs+ScmTb62PxUZeHuPiwA
 h/JXBvXQyTAh/zb68D8I1y05TVluqe3QYgQejIWhh+vLvNqCS+FLzAOYm
 +o4/rjEaWnybCjzCC1Bd2OX9FzWslmkS8PUr0HXAXs1SDbFhyw9SgHH6c
 dAFzqiDjB93jHQalYxkSVE+GAVC6QXPnnNGke+HdZS89bCy62moNWc3YU
 ROPvRtFhntlaHaAk71V+pXqXQfVnQAOPoK7rC2va/GoGzae7slZt3CzCn
 MRTuN23We7vAg/GO32X6qhiVcCnrI2QP49AvkA0KKKe2Fa5YITbUrLxY7 Q==;
X-CSE-ConnectionGUID: X0c9cnEgQyy4xp63rFWJAw==
X-CSE-MsgGUID: Z9eqPxezQvKyfMNgt0zvwg==
X-IronPort-AV: E=McAfee;i="6800,10657,11852"; a="88986963"
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="88986963"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 11:54:56 -0700
X-CSE-ConnectionGUID: yAzVkCz/Sh25Xigf8IivJA==
X-CSE-MsgGUID: Uit35J+3TP2PIkjyTT0xag==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,175,1779174000"; d="scan'208";a="280812467"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Jul 2026 11:54:55 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 11:54:55 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 20 Jul 2026 11:54:55 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.9) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 20 Jul 2026 11:54:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qR7LN1+y4OnYCiRx7ZhVdfr+DoYEafxXEDcDFmAhvqFbjqr8dTNFP1dZj1PgHs9koGvOT7+L1Ems6YPLtn+j4c7xwRvkmrbyySvfbxboRZPgkYGiLlIMh8AYHPQqF1fq21xQ53/dBXdVUWiLXiiUyav3SYmiwGPeTjwT0vfyUku/UPkxqM/7ggL7Jqv0T5kITYJskj1KD0YOzt4ghJ3C+6UhA8Uy80CdnloWCP4LWKGVqO0K93fMSbVvwiGQRqoFZ6YVLKIP7CFeUIRc6ICwUwo1q4c7FzSatZGlpaNMMg6ciNZXPVQsdtMqlH93b8T0nKUu+Pf5u6S9QZwCTemHyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EXFOo4+GzVM4e8njE+zpXRleRnNb7xz4loThgjB/elM=;
 b=hVCop+iXqCZCyck8LlszKQOMG9zVbDkendPiXuATyLQRu7NrvbDv8+sPAl19/8WLG+v1eLq1FlxNOWidREi0v1mWu4XLhEKAaFZ8xHZUtnut5rCCDzrR0ZjYUHVufjVRkFWCokuKjWFOz3TwvrqA30kTkYak/ReWQwFPAV68ji1aA9lXwk3AgoAskmBduW1qanYIChffsGkKAcqnltJNQ59w4IKZU0/0OyzjRS0c3iPB9jFKKKOaXI5OPij4hQeQhIYsT0p/1HnVY9jH3OV2z56KWUAtS9xhsHTCZCc8SnaN6SsxwHxCxScZXx/g/q+yQoXoM4dQhJ0oTyWBVABiEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SJ5PPF44E8B88DF.namprd11.prod.outlook.com
 (2603:10b6:a0f:fc02::825) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 18:54:53 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0223.017; Mon, 20 Jul 2026
 18:54:53 +0000
Date: Mon, 20 Jul 2026 11:54:50 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Stanislav Kinsburskii <skinsburskii@gmail.com>
CC: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <thomas.hellstrom@linux.intel.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <intel-xe@lists.freedesktop.org>
Subject: Re: [PATCH] drm/gpusvm: Zero HMM PFNs before scanning ranges
Message-ID: <al5u+iJi1h6FhKsu@gsse-cloud1.jf.intel.com>
References: <178406967042.1113483.2116704310277917086.stgit@skinsburskii>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <178406967042.1113483.2116704310277917086.stgit@skinsburskii>
X-ClientProxiedBy: MW3PR05CA0027.namprd05.prod.outlook.com
 (2603:10b6:303:2b::32) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SJ5PPF44E8B88DF:EE_
X-MS-Office365-Filtering-Correlation-Id: 24d0569b-34dc-4a66-3136-08dee690624a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|7416014|376014|18002099003|22082099003|3023799007|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: JhHc5+bVlqdTMiRyGmTLAfPQ96YvCsuDYFgtpt7GuOwRwU3pvWIUlXpCdUaT0AQVCvyItGSv7kNjiFG8wWu6klkVP35qTfq5mcbnR20mmgnslb0QpRte79UV+jnpSYwPlj7KBNSFDmCG37ibnyHB5hv1ScncvdaM0Qg4edg4iub8Qa/xjuQh6SpKauvrxNLMut5FUGEnioJLd3ruMJP2Xu0zVMkdLJ6ffsDGCTIQc/bIWJUjIIzjbBiyprtmcza/LOkzbwcentSxfVcpNh8QU7SKY5BWBlvj+c1iaX6EIBc/045eb/yl7XO9RNb4VASlCkklSkWFVKom9OxfSVTpiu297jVmmbV26/vwQV7Clg6FU4hlaIk5IJ8S9acuTC8T7LOYsLfTAwliDiLsAGG1j2K1zFS6fXS6gT8Yos+c/katxP5mCljPJ6YtdBZddmeFy3OSYne41IbsYvnetOg9b6H4m0ZkxjmwRF6oP5m+HPnxBGlHy/IFbKYnJHwrR7Ssg4y1ZO4Z2L/E0h2Hv9ruhtpsinqnj9sJBpaSxeORfdSnrzo4+H7F2BfR5yduT+7XprilZyjeOHt2GeDydSM1punSby/CbvDKLEnfd87tV+Z71lq7jzxGwBz60N2Y7zP8GdUYbis7mNiLGJgKcMLrG7a2JSBA48N4hpZpU3lCh/s=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(7416014)(376014)(18002099003)(22082099003)(3023799007)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0cC1hGCPr6zhdzW76Y0GFIHHBfkqZMhKNxYXdUfG06wwLt3thpokD4yNrZrZ?=
 =?us-ascii?Q?AhVesADzrla8kocXYqOqEVIDl1qCDx+SQ4rbKaJ30MoLWnPzAp5Rn9Kbw1E6?=
 =?us-ascii?Q?V/fZoLhhF2yW8dtN7YABUWLTEnoqPvJqtll1nC5s7LENsXQWjIvC+kpWoiIn?=
 =?us-ascii?Q?YQflYuRZyNJPubLJgT7H8Ui/E2BlycO/3+byChvuSkAaTaAOW0Nui97laBOB?=
 =?us-ascii?Q?wqPygDW6MhuI7W7bVPFa3px2V4mk/qa2aVuCG6u6K7RLhke1jarzrcnHSy5I?=
 =?us-ascii?Q?Fr4tCtZ6rMNZMhJlEjznJLEkVSs1qQf/Nay8MR+1N8kgDeLeiYAFJEPFJR1/?=
 =?us-ascii?Q?c8yQKZeYbWxlaeh68AN3YV2bI8GLdv8WxLIUjNVJT95h3IK3Sl/vehH5PcGw?=
 =?us-ascii?Q?k7xHckusU+HHvhtDxCexTRJOwEibHFP4o+6H+om6J/B5vcGEjkkXOyg85hLQ?=
 =?us-ascii?Q?//FP1SZ0bgfb0A9EHyTpVewXikpeEU2O1THnzbBO+8iSxz8+LD0ds6yqMzrv?=
 =?us-ascii?Q?UdV0xoYXOzZg++B2gyeikDLNFELyuz4cG95ZUauj8MrfzlT/XSqD6G+wk3C2?=
 =?us-ascii?Q?KTF4BIQ/+IyL9y0Ne+jfiuKb5dQVtXMUyKpzMe5WpjYeX41UCVSYY4/Lut8A?=
 =?us-ascii?Q?hyt2M3wARufnPq016Rv/pXVqQgxFtNeJNCwj4PCIPhd4QYULnar1v2plES08?=
 =?us-ascii?Q?vd1XL56WZ22wKOCGUUHENm9SLUCsc7hLF9dhWt/lWOfImaLV+afU1y0xic72?=
 =?us-ascii?Q?PaAeL8JFMnmSAlSwlgvwfAnV4YXQSJhh9mz8dSkTR9JswgnwX70VyEBw2K4g?=
 =?us-ascii?Q?0vDkywLaNAx78gJL034in5FQb/MgQSDN8IrzyOkXVfUf4szCaqRUrKwH8UTq?=
 =?us-ascii?Q?+nFAZ5tLmfOT76lVtTJYlxC/pQsyxJOKHrl/+Wc0uz8k7Qqz4PyGH3ogOP5b?=
 =?us-ascii?Q?f7Q5SsWrgQPjm4jcUezJzK1szZiylC8v90NN/v5gaMl70hB+AMJOkPTkC7/h?=
 =?us-ascii?Q?ivPWEQiO0R95KNNgFLR4uXmF4RjeUoklQmMx/ilwEk9wvnQHruqahpF7RfgB?=
 =?us-ascii?Q?1OEUi5xcgQQu4IxFEHJBS/dfoHMfPCZZ9Tf0EO0N7FoB1aM8EU1zFeLKngBt?=
 =?us-ascii?Q?IjHaZ3SxhtXR1y5oKaHulZY3eHGCo8FV4P2PQOYLfUuFwf9tzD/iwvf6u773?=
 =?us-ascii?Q?RBlsoyeDYBZNiePWCMJlSnkrcMYceVgi3F3+TrIU2p78DeVdbfTsLAMbYHxB?=
 =?us-ascii?Q?2wt7R3oZCWEb927bQD+Nnkk92itHVMHawYaGYubA70kPwaRqUDvSFeM3mU8H?=
 =?us-ascii?Q?Ckmj5ujeKqLYQNdBC8wMf8BlM8m+602CEXTp13acthwlMfVFtZ+WIJIY8ZtI?=
 =?us-ascii?Q?iuNq4L53aI72HJl18MMTiiXlhP1ke9Xph1WlXRAClQOqnxpWy2gA3C4XSVEJ?=
 =?us-ascii?Q?U0yCaxDfUH966BPVYSDJ6Dr8Z/r8+PvyVrmdOIFb4qQUnP/RXMKIcgV8j1rH?=
 =?us-ascii?Q?JiruWJ0CxnH+mdLSk3rxkP+qqovO/zYynZJud5r+59I6oXnMjolJ7vVrWzAu?=
 =?us-ascii?Q?MlNsMNmp2/A8CpjXFjS/Xy6s1e1EgyDTkzJ1I8duXbPQAdIUZ8i44tMCDbmU?=
 =?us-ascii?Q?/Yr+jMRTlRCTGDfmqAw1fiTZoVNW/P+Hz49TfmNcKKX37HULnsuIV8OIYgvZ?=
 =?us-ascii?Q?fW1ZuM3SUp25YIX213IL0ntH9fjFVsTNLchK54TBXUBebfqdUED1w3rggplw?=
 =?us-ascii?Q?+o5jt96WbA=3D=3D?=
X-Exchange-RoutingPolicyChecked: Ww9PDMDpO456YjlvyM1ShD6LNE/TKMtoi/lm1BFHVz+5+OEKhBH0aJL2g/Nn+CZ7P/PlI4OdXH3Yw4LJdd1m9FqYKs3DcSlO/srbNuUzISc8MVV5a2RZMtLplXQG3OuQLnNNmHCyt6q5o9CxgOLwCYlPiR8RPOYt0m4wccWW3iZtGQwXoXUe9J/38kOE1me33yqS5Vs6P8nfPrBwYqzLQb5xaqQBIoTOcWAA5fpc621bAQHWNmcalmWh6opZA/YbhNWQmWtvpKPkXko4GyhQRFQhqK5GDTuTwNxUAQJAgjQVxhVNzH0A2xhmQgLCAQ/zZ0O8oKVJ30Y5Koip5EiB+g==
X-MS-Exchange-CrossTenant-Network-Message-Id: 24d0569b-34dc-4a66-3136-08dee690624a
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 18:54:53.3460 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4Oj9tF9o0rT2EUJ/MHbEjl5xTUphrb0WqdCtF18fytO7Wvy7Aw595+tjLaZd3nKqSbXBPgnhmo7Z0Mlz26rEFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF44E8B88DF
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

On Tue, Jul 14, 2026 at 03:54:32PM -0700, Stanislav Kinsburskii wrote:
> drm_gpusvm_scan_mm() asks HMM to report the current CPU page-table
> state without faulting missing entries by leaving default_flags set to
> zero. The HMM PFN array is still caller-owned input/output state, and
> the framework may preserve input bits while filling entries. It is not
> safe for the caller to hand HMM an uninitialized array and then treat
> entries without HMM_PFN_VALID as an authoritative unpopulated result.
> 
> Use kvcalloc() for the temporary PFN array so entries that are not
> reported as valid start from the documented zero state. This prevents
> random stack or heap contents from being interpreted as HMM PFN flags or
> PFN values during the scan.
> 
> Fixes: f1d08a586482 ("drm/gpusvm: Introduce a function to scan the current migration state")
> Cc: stable@vger.kernel.org
> Signed-off-by: Stanislav Kinsburskii <skinsburskii@gmail.com>
> ---
>  drivers/gpu/drm/drm_gpusvm.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> index 1a8bb83bd28d..c8f489d7ff7e 100644
> --- a/drivers/gpu/drm/drm_gpusvm.c
> +++ b/drivers/gpu/drm/drm_gpusvm.c
> @@ -859,7 +859,7 @@ enum drm_gpusvm_scan_result drm_gpusvm_scan_mm(struct drm_gpusvm_range *range,

Two other cases in gpusvm would need to be fixed as well:

- drm_gpusvm_get_pages
- drm_gpusvm_range_evict

The offending patch is likely the one that added sticky bits to HMM:
`git format-patch -1 285e871884ff3` for above two cases.

While I think zeroing here would be the safest approach, it does not appear
to be a problem in practice because the sticky bits are only used by
`hmm_dma_map_pfn()` and `hmm_dma_unmap_pfn()`.

Also, there are several non-gpusvm cases in the kernel that do not zero
the PFN array either. So I'd say we should either fix the entire kernel
in one pass, document that pfns must initialized to a known state, or
leave this code alone.

Matt

>  	const struct dev_pagemap *other = NULL;
>  	int err, i;
>  
> -	pfns = kvmalloc_array(npages, sizeof(*pfns), GFP_KERNEL);
> +	pfns = kvcalloc(npages, sizeof(*pfns), GFP_KERNEL);
>  	if (!pfns)
>  		return DRM_GPUSVM_SCAN_UNPOPULATED;
>  
> 
> 
