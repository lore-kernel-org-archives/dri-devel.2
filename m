Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6A3606EEBF
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 21:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=eGBS6xO1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA81210FF17;
	Wed,  4 Nov 2026 21:46:07 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD37110E412;
 Wed,  4 Nov 2026 21:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793828762; x=1825364762;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=cNI3IpYCmJIakBaSZHkGlQZD4UU/iBmNtKrfxiseAnU=;
 b=eGBS6xO1ue28s7irbC+23T0boC5ZswBcF1RIarO23OFETdy+7NAeZ5sC
 RIFjl/2SeQCmC+9w1VtHXg08unQ0WpjQ8giMnp18bg4kXDXwTf27LPO62
 tb37TMiWtJByMSewCDjxSD5GcmHGETUFYZfe++8nYru/iDCSikeO4M2lw
 l1xzhYYw0mvq+5LwRR065Rxdsh/sVSQaFXZ+KAhm5/MCXyEPMucLsvaiR
 O2rw4HouUUGCajZPyw8jl4cYN49oA+PhxjM3S5NAkTBRhMiw4ugZjCPSV
 4jgcaJFTi7kzGEj2F3hPi4GcWhpBtMAG85mwgrW8rXo497qIzD5RDPr8Z g==;
X-CSE-ConnectionGUID: lPrw6WppSbe59OUu+JRl/Q==
X-CSE-MsgGUID: YlyBRaAhSHCw2ibruLFDnw==
X-IronPort-AV: E=McAfee;i="6800,10657,11956"; a="2639790"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2639790"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:46:01 -0800
X-CSE-ConnectionGUID: ZBg1YG4gRXqgqaT0ArAgpg==
X-CSE-MsgGUID: OIFedOjsT92ZdZsfgP5q9w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="6943528"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 13:46:00 -0800
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:45:59 -0800
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56 via Frontend Transport; Wed, 4 Nov 2026 13:45:59 -0800
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.35) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Wed, 4 Nov 2026 13:46:02 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rw0O5D6IKHc2fw8C2zQuLrxZEwIM1H3ADmEMObZP1rVB+dFFPOu+dkxRaQvOv21NZT5TBudLQkh2x81AgwFobfTd0mnbAJAqF2PG5/RNyn7V5Qnp62sWnQO3EOwv4HpgrdIUTQoHCxuymBWUctSTsOLiPA18JDQ51grW5s6ISbIAXrYfk1o3NRHgIRVDsoLjpydIf3nknI+b0zcIyuN7bxdT4iaV0fabz28m5PxdTISKOkF8I76BD34ovM+koXfcKwDyZHCf/hq9h77fzaoCpzT2Txf0mmyG71Sne3hZDFw70JI4MLL+SwDx9wl5GkL1a+bQPllSf5GM11Iylz4REQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZFqk2ROI10Aoic2COmfOZBKvsD0FzcZwLTPx7OCZmDM=;
 b=iu2DgTV1WfWxoVHMT8iAImLDnWFZNO7QLkvVY6PHy+TFDItu+e2NdK7Zaa6+/CIjDm+522iUSFyTx8znIldhXOy7vEZl3snYzE4t/1NH6RukLibWepQfTsvxzckKL3NYaa/84UMiMWr9FUGlj8AUKwkEq7xzXvpUeCtIzlCzN4RyFYaYlxngn6BR66Ii1TWB0HWaSGd9qR5cI3cgmzYPQ4WdHnhzCeNo67fi7MriH1QqmcnX/34CEHeO8xjcptvZ2OqJRZB56IM/+2b32X3XaqzXzaqoFyS+VM41I6ir9j4ABByQFqSCEHJHbF25T1/BCQ50QbP9LIjP7mUVttiAvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by CH3PR11MB7940.namprd11.prod.outlook.com (2603:10b6:610:130::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 21:45:57 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0592.009; Wed, 4 Nov 2026
 21:45:56 +0000
Date: Wed, 4 Nov 2026 13:45:54 -0800
From: Matthew Brost <matthew.brost@intel.com>
To: Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Thomas =?iso-8859-1?Q?Hellstr=F6m?= <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 12/33] drm/xe: Add debugfs stats for DMA-mapped pages
 per order
Message-ID: <auunkna+jypEchHw@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-13-matthew.brost@intel.com>
 <auqvRK1BVU_ec2JX@nvishwa1-desk>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <auqvRK1BVU_ec2JX@nvishwa1-desk>
X-ClientProxiedBy: MW4PR03CA0269.namprd03.prod.outlook.com
 (2603:10b6:303:b4::34) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|CH3PR11MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e54c1aa-fe70-4c84-8c53-08df3abd0201
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|366016|1800799024|6133799003|22082099003|18002099003|10067099003|11063799006|4143699003|261026121527099003|261022105027099003|261102130727099003|261102123227099003|261026140227099003|261028144727099003|261009223027099003|261021123027099003|261021121427099003|261009221227099003|56012099006|261022075727099003;
X-Microsoft-Antispam-Message-Info: ABfnPQucwrYOkpP681ARjCejOqT/mhPPJlrDS9rY3EGowvZFwspLqONdA56PZQDDr/pe+Ex6Y7L5P5rAj9LjkY1hpXSpknCv6po5ElQDiCsRHm9R6RJoUGsZgCceZElk25uOEHNUq7ZSJbJp08gtF3HAZcYJrEBjr2WMdPncKFesn3eNFLzqcvvkOXOlVGljVM9dMmQiWDSjkhsvjyVx0NlOLwk36Q+OUjuwBFn0zLlEGH7KqeFPiGENa/JbIm9vCraBWSeRxSUXWQnDbtBMmulWP5inln81lTourRlb1ZJjteLr7qMNLuUjFD5chGjzAdOINjpqs+MkcJIahvUXoOxT87yfm3M2kVYjqyNVHP4a3KhvGbJxLELvUHsUM6Wolaq/G5v35Q1byO16/QFw89Tt6KSkfErdE1JLxW+OFWEZ+WPsMcln0DTbBG0YKrd86g1Kxp75qitPdBrELM+qpBx64HDpwkFxN3cUco6FDmkKvFwu9i+jhtU2GRkpoStwEjG860r/6nd3Q/TcxXSJVtT2xpLgHoAqYB2tcMQdg2Pdu2FhgOz0LXMW0+96j05OQl5AOZlYdoo+zji/bWvJcqnAwxhc3i4A/ydIEfombDNBFe7rOXJw5WgThwgonpaFwEmt8A8t7WoUQm5UTRlv0mrlXfeWjbsrbGRPq/in6uo=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(6133799003)(22082099003)(18002099003)(10067099003)(11063799006)(4143699003)(261026121527099003)(261022105027099003)(261102130727099003)(261102123227099003)(261026140227099003)(261028144727099003)(261009223027099003)(261021123027099003)(261021121427099003)(261009221227099003)(56012099006)(261022075727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?NvGjOkAleUbh5eQtknnGZMkBRGixFae4lnCfz94MzBU+AfNL7AHrqsd/gr?=
 =?iso-8859-1?Q?jNmmayie5nsmJ72TQrqyRxZZZo8soMpLEViciWnfAGRPM/Z0Z2FtSCjPrQ?=
 =?iso-8859-1?Q?+QsRRY99MmmRpMsKenrJORBpT2CaSERsfA4CJFeIgajFndfJtJeIt5Fw9J?=
 =?iso-8859-1?Q?ehY+PstWnl7nLWE40Z5SOE7VEQd4a3DQ1Wa7jwZhjVFRjG1FkyJAI44WnB?=
 =?iso-8859-1?Q?9RcpdJJFAwLh3womVbaAGzFcAb3td+0JZKPHClSt8sWuNEh09sHsAWJcHc?=
 =?iso-8859-1?Q?V2542H7rShwZskC3Q4NPnNJRqAgGRMpupdrCGS1a8BDNBmkox4huEipvVG?=
 =?iso-8859-1?Q?LFHT1h34LOMK4PPl0R+aAYRV1f3FdtEeOuSSSeCEiujoqLbhlQskJyuRMm?=
 =?iso-8859-1?Q?KH4DIa3GbtAow04ZbF2DzeGCgELErzKxqr92m43xlUqIVgNivktStz8L3n?=
 =?iso-8859-1?Q?6av2/EioiqZJQlxkyN2gj8d+r5cO5n3t5ZnomsVFXLDriQCOcsERz+MW6e?=
 =?iso-8859-1?Q?fBFPNwdaAJ8YNQOUvr7aKz/hv11BtG0Ee3b0u0Z+45wPQlzAqc6WsA29O/?=
 =?iso-8859-1?Q?QQGqSWHN6KmIeWWDgq177cGb+rQKxp0AUf8uIbA9Y6vIsiB4BnY/u2Vpx1?=
 =?iso-8859-1?Q?0ZlDVU1MNZDD6G1SgBFKSaU8Q4dy/KTZGtelDLjx+13A5Vwqu0+IKDu2tD?=
 =?iso-8859-1?Q?gxD5D31u6OV7r5W9uWGmpBVpAIJ682K6tED9VEge4YA314CYtZbvoGQ4Vx?=
 =?iso-8859-1?Q?+5DgyPjX+hyNZHkmo0qnPQ+VVEGkk8NqCkvvLLdC391Ox1SUaSX7D4D3mu?=
 =?iso-8859-1?Q?JAEK+KcoNC81XP26+VlxVRp8mPMfwgEjrnVYqChgXKs//oQSPe1cx9pfiq?=
 =?iso-8859-1?Q?mh+r9ygFL/tyVD2jAKYHt38t+X9A0c+e+xEK6R9+tXK9cv2/9rCcdP6E9d?=
 =?iso-8859-1?Q?VKNa5C38bMZ11CnZZ0Y1FKdTpyMOFFapEu47P6uB4wy57DvHnsRfVuIeCB?=
 =?iso-8859-1?Q?eNzWlQ5EMIwDXKAIpQEDqCA3S5CdRV+bn3VGvRiIC5KoSQpQTkW6ahUWUj?=
 =?iso-8859-1?Q?FF5rf/ejx6UWId2gc2tlOtec7ibzYgYSvm8nhph0nEAfLSrFJ4K0wSXnVr?=
 =?iso-8859-1?Q?xIpspEiEnWcvfKLB4VASgekuSItkdNIt9F4aqEyrOcMWk3dC2+8esPiX2J?=
 =?iso-8859-1?Q?OZxv4IeDGhfCzRl2W1ilFd4arSxgehvan+eZ3XwMHgrbL164YlPDenvAXV?=
 =?iso-8859-1?Q?4gah7Jt0gUJUT23YHOA4TTsckeJjXUTxwz4XE+L7GM/e/rk3KX78zhYsnj?=
 =?iso-8859-1?Q?d63sAGrtiTmIXs8E3UhsyHTcNF1hPOzFPBFu8MUsM6DfEg+kze8GHnglNd?=
 =?iso-8859-1?Q?iEduU0mAzREX8vfSK/oZtRVdu12ZxnpdpV5DzaXZ8PCOTa8TNv/gTJbd/i?=
 =?iso-8859-1?Q?MmEOfQlTa0VJJmkFJKOJLibYpz+cg23GINL6ZIFOeqqTX4uLsi+/IVeZXr?=
 =?iso-8859-1?Q?DkEoVZ7qfI4EFIbl2XntejN4ma//rL5xkblAfOM7RDYaafTi5Lb6M/3J8o?=
 =?iso-8859-1?Q?g/isNlqK5dG/zOnf2I1WgM7Z+gCYokq5O14qQDRts9FEsMf6bq+AuK1o4h?=
 =?iso-8859-1?Q?TO03hrHKu949tQ6d2sl+Sj7nGOtagCxTfUTmg8q22Ah7MfgYLx1rhA1ODl?=
 =?iso-8859-1?Q?UOref7WFa05Diwg1dvxDTnO45r/oIwiO6UpZ/q8zhyPZVmlM4DzAAjR2kG?=
 =?iso-8859-1?Q?4FVRvtbqlTafUiCLbtG9FD1HtGFyrqPhE49YsnzkZyH0a2TYdSa04Xg3bm?=
 =?iso-8859-1?Q?WoUCHK/NDQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: A61KBsYBmjDodkrCJEmdWYmfFnnRJ9taIiMQUaTRSCYNs489Zf4lpuPp5/5aRfpBm83gjbns3pA7eVWkEsfna8czWc6/EDLA0YaJ//7YoMSyROI59IrZuujhJci0sFu/ynrMjY4JJP16Peuzq40ae3/6oUyvblx3kjCX4MRs8+75h4LpA0WBSuHLcw9fet13Izpxg+U2XSzPsPIZReh3uc+n3JctsqjNknyytWf2do7PrGHZKDeTtNqo5g7DzGS4b1yU4Vv/Yz/nQyB84DGYlzvUGcBzhO4jneZvACXHWw0uzNZ7gO3wgIWzA48JA7vXFCX46lHKccISuDgXIrD0hQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e54c1aa-fe70-4c84-8c53-08df3abd0201
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 21:45:56.8659 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5b2ffWKiC1m36mKZ4xIDajxi4Al/oz8A1uNLy1JSNQn2FPhU357t0AJ8At3sPpCJntffScj1pqLaOqYEWSp0fg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7940
X-OriginatorOrg: intel.com
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 03, 2026 at 08:06:28PM -0800, Niranjana Vishwanathapura wrote:
> On Fri, Jul 10, 2026 at 07:55:58PM -0700, Matthew Brost wrote:
> > From: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > 
> > Expose per-page-order DMA mapping counts for the system memory that the
> > xe driver maps for GPU access, split into two categories: TTM buffer
> > objects, and the GPU SVM / userptr ranges (which share a single
> > drm_gpusvm instance per VM).
> > 
> > The stats are visible at:
> > 
> >  <debugfs>/dri/<N>/dma_mapped_pages
> > 
> > and are broken out into two rows (bo, svm/userptr), one column per page
> > order, mirroring the layout of the TTM pool page_pool stat.
> > 
> > For TTM BOs the per-order counts are derived from the DMA scatter-gather
> > table: each mapped segment is physically contiguous, so its page count is
> > split into the largest power-of-two runs (a segment of N pages contributes
> > a 2^k chunk for the largest k with 2^k <= N, repeated for the remainder).
> > Driving the accounting off the sg table rather than the pages[] array keeps
> > it correct even when pages[] entries are cleared while still DMA-mapped,
> > as happens on the defrag page-borrowing path.
> > 
> > For the SVM and userptr ranges the accounting is driven by the
> > drm_gpusvm @dma_map_account callback, which fires once per dma_addr[]
> > entry at the exact point the entry is DMA-mapped and unmapped. This
> > makes the accounting symmetric by construction and avoids driver-side
> > walks that could drift across migration, partial unmaps and the iova vs
> > non-iova paths. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps
> > and counted; device interconnect (VRAM, P2P) entries are skipped, so the
> > counter reflects only system pages actually mapped through the DMA layer.
> > 
> > The callback is shared between the full SVM instance (fault mode) and the
> > core drm_gpusvm_pages-only instance used for userptr, so userptr
> > mappings are accounted in both the CONFIG_DRM_XE_GPUSVM=y and =n (but
> > CONFIG_DRM_GPUSVM=y) configurations, into the same svm/userptr counter.
> > 
> > Since the counts are only ever consumed through debugfs, gate the counter
> > storage and all accounting on CONFIG_DEBUG_FS so that builds without
> > debugfs carry no extra atomic traffic or device state; the drm_gpusvm
> > callback is simply left unregistered in that case.
> > 
> > On device teardown assert that every counter has returned to zero, to
> > catch any unbalanced accounting (a leaked DMA mapping) during testing.
> > 
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > 
> 
> Patches 11 and 12 can be spinned out as a separate patch series
> (for fast tracking).
> 

Yep, spliting these out now.

> Also, dma map/unmap of dmabuf imported BOs are skipped here (rightly so).
> But perhaps add a comments in commit message that either self-import
> returns the same BO and BOs of other device gets counted on exporter
> side when it gets first migrated to TT first.
>

Sure.

> > ---
> > 
> > v3:
> > - Fix drm_gpusvm_init() argument order, clamp DMA-page order to
> >   NR_PAGE_ORDERS - 1, and drain DMA-page accounting after
> >   xe_bo_dev_fini() (Sashiko)
> > ---
> > drivers/gpu/drm/xe/xe_bo.c           | 46 ++++++++++++++++++++
> > drivers/gpu/drm/xe/xe_debugfs.c      | 26 ++++++++++++
> > drivers/gpu/drm/xe/xe_device.c       | 30 +++++++++++++
> > drivers/gpu/drm/xe/xe_device_types.h | 17 ++++++++
> > drivers/gpu/drm/xe/xe_svm.c          | 44 ++++++++++++++++++-
> > drivers/gpu/drm/xe/xe_svm.h          |  4 +-
> > drivers/gpu/drm/xe/xe_userptr.c      | 63 ++++++++++++++++++++++++++++
> > drivers/gpu/drm/xe/xe_userptr.h      |  1 +
> > 8 files changed, 228 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
> > index 85e6d9a0f575..60e0e568aa31 100644
> > --- a/drivers/gpu/drm/xe/xe_bo.c
> > +++ b/drivers/gpu/drm/xe/xe_bo.c
> > @@ -367,6 +367,50 @@ struct xe_ttm_tt {
> > 	bool purgeable;
> > };
> > 
> > +/*
> > + * xe_tt_account_dma_pages - account DMA-mapped tt pages per order
> > + * @xe: the xe device
> > + * @xe_tt: the xe_ttm_tt whose sg table to walk
> > + * @sign: +1 to add, -1 to subtract
> > + *
> > + * Walk the tt's DMA scatter-gather table and split each (physically
> > + * contiguous) segment into the largest power-of-two page runs: a segment of N
> > + * pages contributes a 2^k chunk for the largest k with 2^k <= N, repeated for
> > + * the remainder. Accumulate the count of 2^k pages into
> > + * xe->mem.dma_mapped_pages[k]. Driving this off the sg table rather than
> > + * tt->pages keeps the accounting correct even when pages[] entries are cleared
> > + * while still DMA-mapped (e.g. the defrag page-borrowing path).
> > + */
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +static void xe_tt_account_dma_pages(struct xe_device *xe,
> > +				    struct xe_ttm_tt *xe_tt, int sign)
> > +{
> > +	struct scatterlist *sg;
> > +	unsigned int i;
> > +
> > +	for_each_sgtable_sg(xe_tt->sg, sg, i) {
> > +		unsigned long nr_pages = sg->length >> PAGE_SHIFT;
> > +
> > +		while (nr_pages) {
> > +			unsigned int order = min_t(unsigned int,
> > +						   __fls(nr_pages),
> > +						   MAX_PAGE_ORDER);
> > +			unsigned long chunk = 1UL << order;
> > +
> > +			atomic_long_add((long)chunk * sign,
> > +					&xe->mem.dma_mapped_pages[order]);
> > +
> 
> NIT: As there is an atomic operation involved, instead of doing it under
> CONFIG_DEBUG_FS, should we be doing it under a separate xe specific
> debug config?
> 

I think GT stats are just gated by CONFIG_DEBUG_FS, I say this is
roughly idea. If someone complains about perf we could change this
per-cpu counter like GT stats or I guess add different Kconfig gate?

> > +			nr_pages -= chunk;
> > +		}
> > +	}
> > +}
> > +#else
> > +static void xe_tt_account_dma_pages(struct xe_device *xe,
> > +				    struct xe_ttm_tt *xe_tt, int sign)
> > +{
> > +}
> > +#endif
> > +
> > static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> > {
> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > @@ -396,6 +440,7 @@ static int xe_tt_map_sg(struct xe_device *xe, struct ttm_tt *tt)
> > 		return ret;
> > 	}
> > 
> > +	xe_tt_account_dma_pages(xe, xe_tt, 1);
> > 	return 0;
> > }
> > 
> > @@ -404,6 +449,7 @@ static void xe_tt_unmap_sg(struct xe_device *xe, struct ttm_tt *tt)
> > 	struct xe_ttm_tt *xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
> > 
> > 	if (xe_tt->sg) {
> > +		xe_tt_account_dma_pages(xe, xe_tt, -1);
> > 		dma_unmap_sgtable(xe->drm.dev, xe_tt->sg,
> > 				  DMA_BIDIRECTIONAL, 0);
> > 		sg_free_table(xe_tt->sg);
> 
> There is another dma_unamp_sgtable() in xe_bo_dma_unmap_pinned().
> I guess we should account for that unmap path also.
> I am seeing sashiko reported this as well.

I see dma_buf_unmap_attachment and call to xe_tt_unmap_sg but I'm on
drm-tip now, so at in what I'll post shortly this I don't think this is
an issue.

> 
> > diff --git a/drivers/gpu/drm/xe/xe_debugfs.c b/drivers/gpu/drm/xe/xe_debugfs.c
> > index 8c391c7b017a..97b47c5c4213 100644
> > --- a/drivers/gpu/drm/xe/xe_debugfs.c
> > +++ b/drivers/gpu/drm/xe/xe_debugfs.c
> > @@ -6,6 +6,7 @@
> > #include "xe_debugfs.h"
> > 
> > #include <linux/debugfs.h>
> > +#include <linux/mmzone.h>
> > #include <linux/fault-inject.h>
> > #include <linux/string_helpers.h>
> > 
> > @@ -231,6 +232,28 @@ static int dgfx_pcie_link_residencies_show(struct seq_file *m, void *data)
> > 	return 0;
> > }
> > 
> > +static int dma_mapped_pages_show(struct seq_file *m, void *data)
> > +{
> > +	struct xe_device *xe = m->private;
> > +	unsigned int i;
> > +
> > +	seq_printf(m, "%-11s ", "");
> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
> > +		seq_printf(m, " ---%2u---", i);
> > +	seq_printf(m, "\n%-11s:", "bo");
> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
> > +		seq_printf(m, " %8lu",
> > +			   atomic_long_read(&xe->mem.dma_mapped_pages[i]));
> > +	seq_printf(m, "\n%-11s:", "svm/userptr");
> > +	for (i = 0; i < NR_PAGE_ORDERS; i++)
> > +		seq_printf(m, " %8lu",
> > +			   atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
> > +	seq_puts(m, "\n");
> > +
> 
> NIT: As order-10 also prints higher order (1GB) pages, may be print it as '>=10'?
> 
> NIT: This is a rough snapshot as array elements could be changing as we print.
> I guess that is fine.
> 
> > +	return 0;
> > +}
> > +DEFINE_SHOW_ATTRIBUTE(dma_mapped_pages);
> > +
> > static const struct drm_info_list debugfs_list[] = {
> > 	{"info", info, 0},
> > 	{ .name = "sriov_info", .show = sriov_info, },
> > @@ -632,6 +655,9 @@ void xe_debugfs_register(struct xe_device *xe)
> > 	if (man)
> > 		ttm_resource_manager_create_debugfs(man, root, "stolen_mm");
> > 
> > +	debugfs_create_file("dma_mapped_pages", 0444, root, xe,
> > +			    &dma_mapped_pages_fops);
> > +
> > 	for_each_tile(tile, xe, tile_id)
> > 		xe_tile_debugfs_register(tile);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_device.c b/drivers/gpu/drm/xe/xe_device.c
> > index ad7f3e61d457..97cc2d185e45 100644
> > --- a/drivers/gpu/drm/xe/xe_device.c
> > +++ b/drivers/gpu/drm/xe/xe_device.c
> > @@ -455,12 +455,42 @@ bool xe_device_is_admin_only(const struct xe_device *xe)
> > }
> > #endif
> > 
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
> > +{
> > +	unsigned int i;
> > +
> > +	/*
> > +	 * All BOs, userptr VMAs and SVM ranges must have been torn down by the
> > +	 * time the device is destroyed, so every DMA-mapped-pages counter must
> > +	 * have returned to zero. A non-zero value indicates unbalanced
> > +	 * accounting, i.e. a missing unmap-side decrement.
> > +	 */
> > +	for (i = 0; i < NR_PAGE_ORDERS; i++) {
> > +		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages[i]));
> > +		xe_assert(xe, !atomic_long_read(&xe->mem.dma_mapped_pages_svm[i]));
> 
> This also probably good to do it under a separate xe DEBUG config instead of
> CONFIG_DEBUG_FS.
> 

I can make this change but IMO this is needed. I would think we'd want
these stats on all production systems for debug, i.e., CONFIG_DEBUG_FS
is likely the right Kconfig.

Matt

> Niranjana
> 
> > +	}
> > +}
> > +#else
> > +static void xe_device_assert_dma_pages_zero(struct xe_device *xe)
> > +{
> > +}
> > +#endif
> > +
> > static void xe_device_destroy(struct drm_device *dev, void *dummy)
> > {
> > 	struct xe_device *xe = to_xe_device(dev);
> > 
> > 	xe_bo_dev_fini(&xe->bo_device);
> > 
> > +	/*
> > +	 * Assert the DMA-mapped-pages accounting only after xe_bo_dev_fini()
> > +	 * has flushed the async BO-free worker: BOs pending async free still
> > +	 * hold their DMA mappings (and counts) until the worker runs, so
> > +	 * asserting before the flush could trip a false positive.
> > +	 */
> > +	xe_device_assert_dma_pages_zero(xe);
> > +
> > 	if (xe->preempt_fence_wq)
> > 		destroy_workqueue(xe->preempt_fence_wq);
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_device_types.h b/drivers/gpu/drm/xe/xe_device_types.h
> > index 022e08205897..95e7cea91cbf 100644
> > --- a/drivers/gpu/drm/xe/xe_device_types.h
> > +++ b/drivers/gpu/drm/xe/xe_device_types.h
> > @@ -6,6 +6,7 @@
> > #ifndef _XE_DEVICE_TYPES_H_
> > #define _XE_DEVICE_TYPES_H_
> > 
> > +#include <linux/mmzone.h>
> > #include <linux/pci.h>
> > 
> > #include <drm/drm_device.h>
> > @@ -279,6 +280,22 @@ struct xe_device {
> > 		struct xe_shrinker *shrinker;
> > 		/** @mem.stolen_mgr: stolen memory manager. */
> > 		struct xe_ttm_stolen_mgr *stolen_mgr;
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +		/**
> > +		 * @mem.dma_mapped_pages: number of DMA-mapped pages per page
> > +		 * order currently live for this device, for TTM BOs. Only
> > +		 * accounted when CONFIG_DEBUG_FS is enabled, since it is solely
> > +		 * exposed through debugfs.
> > +		 */
> > +		atomic_long_t dma_mapped_pages[NR_PAGE_ORDERS];
> > +		/**
> > +		 * @mem.dma_mapped_pages_svm: number of DMA-mapped pages per
> > +		 * page order currently live for this device, for SVM ranges
> > +		 * and userptr VMAs (both share a single drm_gpusvm instance).
> > +		 * Only accounted when CONFIG_DEBUG_FS is enabled.
> > +		 */
> > +		atomic_long_t dma_mapped_pages_svm[NR_PAGE_ORDERS];
> > +#endif
> > 	} mem;
> > 
> > 	/** @sriov: device level virtualization data */
> > diff --git a/drivers/gpu/drm/xe/xe_svm.c b/drivers/gpu/drm/xe/xe_svm.c
> > index b228a737cfd6..ebe48cb76ad9 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.c
> > +++ b/drivers/gpu/drm/xe/xe_svm.c
> > @@ -827,10 +827,50 @@ static int xe_svm_get_pagemaps(struct xe_vm *vm)
> > }
> > #endif
> > 
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +/*
> > + * xe_svm_dma_map_account - drm_gpusvm DMA-mapping accounting callback
> > + * @gpusvm: The GPU SVM the mapping belongs to
> > + * @addr: The address descriptor of the chunk being (un)mapped
> > + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
> > + *
> > + * Maintain per-order counts of the system-memory pages that the full SVM
> > + * instance (SVM ranges, and userptr VMAs in fault mode) has DMA-mapped for GPU
> > + * access. Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
> > + * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
> > + * exposed through debugfs, so the callback is only registered when
> > + * CONFIG_DEBUG_FS is enabled.
> > + */
> > +static void xe_svm_dma_map_account(struct drm_gpusvm *gpusvm,
> > +				   const struct drm_pagemap_addr *addr,
> > +				   int sign)
> > +{
> > +	struct xe_device *xe = gpusvm_to_vm(gpusvm)->xe;
> > +	unsigned int order = addr->order;
> > +
> > +	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
> > +		return;
> > +
> > +	/*
> > +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
> > +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
> > +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
> > +	 * so the per-order counters stay balanced.
> > +	 */
> > +	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
> > +
> > +	atomic_long_add((long)(1UL << addr->order) * sign,
> > +			&xe->mem.dma_mapped_pages_svm[order]);
> > +}
> > +#endif
> > +
> > static const struct drm_gpusvm_ops gpusvm_ops = {
> > 	.range_alloc = xe_svm_range_alloc,
> > 	.range_free = xe_svm_range_free,
> > 	.invalidate = xe_svm_invalidate,
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +	.dma_map_account = xe_svm_dma_map_account,
> > +#endif
> > };
> > 
> > static const unsigned long fault_chunk_sizes[] = {
> > @@ -925,8 +965,8 @@ int xe_svm_init(struct xe_vm *vm)
> > 		}
> > 	} else {
> > 		err = drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
> > -				      NULL, 0, 0, 0, NULL,
> > -				      NULL, 0);
> > +				      NULL, 0, 0, 0,
> > +				      xe_userptr_gpusvm_ops_get(), NULL, 0);
> > 	}
> > 
> > 	return err;
> > diff --git a/drivers/gpu/drm/xe/xe_svm.h b/drivers/gpu/drm/xe/xe_svm.h
> > index a921556d3466..8e347137a7a6 100644
> > --- a/drivers/gpu/drm/xe/xe_svm.h
> > +++ b/drivers/gpu/drm/xe/xe_svm.h
> > @@ -194,6 +194,7 @@ struct drm_pagemap *xe_drm_pagemap_from_fd(int fd, u32 region_instance);
> > 
> > #else
> > #include <linux/interval_tree.h>
> > +#include "xe_userptr.h"
> > #include "xe_vm.h"
> > 
> > struct drm_pagemap_addr;
> > @@ -236,7 +237,8 @@ int xe_svm_init(struct xe_vm *vm)
> > {
> > #if IS_ENABLED(CONFIG_DRM_GPUSVM)
> > 	return drm_gpusvm_init(&vm->svm.gpusvm, "Xe SVM (simple)",
> > -			       NULL, 0, 0, 0, NULL, NULL, 0);
> > +			       NULL, 0, 0, 0,
> > +			       xe_userptr_gpusvm_ops_get(), NULL, 0);
> > #else
> > 	return 0;
> > #endif
> > diff --git a/drivers/gpu/drm/xe/xe_userptr.c b/drivers/gpu/drm/xe/xe_userptr.c
> > index 8b2d461ea0b2..6b9e1530ead4 100644
> > --- a/drivers/gpu/drm/xe/xe_userptr.c
> > +++ b/drivers/gpu/drm/xe/xe_userptr.c
> > @@ -8,9 +8,72 @@
> > 
> > #include <linux/mm.h>
> > 
> > +#include <drm/drm_pagemap.h>
> > +
> > #include "xe_tlb_inval.h"
> > #include "xe_trace_bo.h"
> > 
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +/*
> > + * xe_userptr_dma_map_account - drm_gpusvm DMA-mapping accounting callback
> > + * @gpusvm: The GPU SVM the mapping belongs to
> > + * @addr: The address descriptor of the chunk being (un)mapped
> > + * @sign: +1 when @addr was DMA-mapped, -1 when it is being unmapped
> > + *
> > + * Account, per page order, the system-memory pages DMA-mapped for GPU access
> > + * through the drm_gpusvm_pages instance shared by userptr (and, in fault mode,
> > + * SVM). Only DRM_INTERCONNECT_SYSTEM entries are real DMA maps and counted;
> > + * device interconnect (VRAM, P2P) entries are skipped. The counts are solely
> > + * exposed through debugfs, so the callback is only registered when
> > + * CONFIG_DEBUG_FS is enabled.
> > + */
> > +static void xe_userptr_dma_map_account(struct drm_gpusvm *gpusvm,
> > +				       const struct drm_pagemap_addr *addr,
> > +				       int sign)
> > +{
> > +	struct xe_vm *vm = container_of(gpusvm, struct xe_vm, svm.gpusvm);
> > +	unsigned int order = addr->order;
> > +
> > +	if (addr->proto != DRM_INTERCONNECT_SYSTEM)
> > +		return;
> > +
> > +	/*
> > +	 * The CPU-PTE map order reported by hmm can exceed MAX_PAGE_ORDER
> > +	 * (e.g. an order-18 1GB mapping), so clamp the array index to avoid an
> > +	 * out-of-bounds access. Clamping is symmetric across the +1/-1 calls,
> > +	 * so the per-order counters stay balanced.
> > +	 */
> > +	order = min(order, (unsigned int)NR_PAGE_ORDERS - 1);
> > +
> > +	atomic_long_add((long)(1UL << addr->order) * sign,
> > +			&vm->xe->mem.dma_mapped_pages_svm[order]);
> > +}
> > +
> > +static const struct drm_gpusvm_ops xe_userptr_gpusvm_ops = {
> > +	.dma_map_account = xe_userptr_dma_map_account,
> > +};
> > +#endif
> > +
> > +/**
> > + * xe_userptr_gpusvm_ops_get() - Accounting ops for the simple gpusvm instance
> > + *
> > + * The core drm_gpusvm_pages-only instance used for userptr (and, in fault
> > + * mode, shared with SVM) is initialised with these ops so that DMA-mapped
> > + * system pages are accounted and exposed through debugfs. Returns NULL when
> > + * CONFIG_DEBUG_FS is disabled, in which case no accounting is kept and the
> > + * instance is initialised without ops.
> > + *
> > + * Return: Pointer to the restricted &drm_gpusvm_ops, or NULL.
> > + */
> > +const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void)
> > +{
> > +#if IS_ENABLED(CONFIG_DEBUG_FS)
> > +	return &xe_userptr_gpusvm_ops;
> > +#else
> > +	return NULL;
> > +#endif
> > +}
> > +
> > static void xe_userptr_assert_in_notifier(struct xe_vm *vm)
> > {
> > 	lockdep_assert(lockdep_is_held_type(&vm->svm.gpusvm.notifier_lock, 0) ||
> > diff --git a/drivers/gpu/drm/xe/xe_userptr.h b/drivers/gpu/drm/xe/xe_userptr.h
> > index 2a3cd1b5efbb..1e9601be5713 100644
> > --- a/drivers/gpu/drm/xe/xe_userptr.h
> > +++ b/drivers/gpu/drm/xe/xe_userptr.h
> > @@ -108,6 +108,7 @@ int __xe_vm_userptr_needs_repin(struct xe_vm *vm);
> > int xe_vm_userptr_check_repin(struct xe_vm *vm);
> > int xe_vma_userptr_pin_pages(struct xe_userptr_vma *uvma);
> > int xe_vma_userptr_check_repin(struct xe_userptr_vma *uvma);
> > +const struct drm_gpusvm_ops *xe_userptr_gpusvm_ops_get(void);
> > #else
> > static inline void xe_userptr_remove(struct xe_userptr_vma *uvma) {}
> > 
> > -- 
> > 2.34.1
> > 
