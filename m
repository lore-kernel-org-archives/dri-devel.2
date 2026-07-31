Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B690AC55162
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 01:36:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF3A010E1A0;
	Fri, 31 Jul 2026 01:36:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="dGwVpq6q";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5D4210E16B;
 Fri, 31 Jul 2026 01:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785461815; x=1816997815;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=m1CoETRg9h6Dta+GJIGoxwB1elTPwE2AtcpwCRPjafU=;
 b=dGwVpq6qYHTufXUcY1jfKpw3b2XZCYv9fyuACJ1v6Fy8jwwEB/ct8FPz
 OxMnjoImZOCHareE6k/aZnkK9Sqr0GoMJcsbXZsZE7K6X91lmKzN2pxKD
 wCcXjtNEVaFTV6owoTU3BorF/qEh6GutxhxAEjXklKCo8yKRO+XeDFUOL
 QXccx2kPbvCtqqz5+L0XXAxegfldQmRCKzEhBK5YH2/TyyI13rFcrdKml
 DA6ArP3x+C2QU/6DezArqnrX4j/nLOzYtUCQLUAAlRrXwBzJz5YoZNTdv
 1N1niv/KJKWZ6CP4+pWmMQQ5rcCneTDqDc1QRZ15nMdibOT+4s3anTDTy w==;
X-CSE-ConnectionGUID: K/mxWsUBST2W5zqBWnYfnQ==
X-CSE-MsgGUID: 1vhL4PSeTqWejR6sznBBcw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="108881576"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="108881576"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 18:36:55 -0700
X-CSE-ConnectionGUID: qxAyydTUSG2iqyMKlOzOAQ==
X-CSE-MsgGUID: HFSdfoUATl66B6UITKLemA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="259208487"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 18:36:54 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 18:36:52 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 18:36:52 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.21)
 by edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 18:36:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=km39I3qQO13JqCl1nd8kpNvK5+Ojn2U3lbFe4Syk+apYRofYKCmMbAyIB+PTJYhoEd5HBhK/4BM7AchiN4m12vypx2fZPNoCyXucYwsce445PxMPuyPwWxUUVuSmQJKgY+0ibl9VSoaRxBodXPkxzvquBaIjS5ckS8qOZF0Ok/EKby5D4ilQhZ5o4trNUXRAo/XnmhfjSioNL886kxZ/hrWUQIiGqh15Q3uLf1VNwR+YLtvHYInw19LlaS9YfdF/DmIbG2dWXTmw3fEIch9eHbpmqSexXDGsci2lM60cxzjiOLD9bbGv9vN5NOFYN/61+n0jxk1QMWzJKKEP8XXYRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C+RAnuEaxeDu+m6MumFESjbFM9JIjCweIGatxmx8Q1s=;
 b=VifHuRPW1zlV1897PM19G7b2ki9YNc1X4pLFJrYw9f4S+zP/brtr/U5976PC+TK5HB/0auXvlcopt7to5jsjvaYRXjQGmeo7X1DDBBvBLOkXQd4v8cfN7UmkpFCTnK4s8chqOr2Hqp2eOYAG8w253etoHDEscnhVBksrtV38GubWmqVp3P7ADTDf61AVXJPjUh00FJLXLA8+U9MVraBUJgntxwUSfAEgrny/pzJ6RUT+fb6oi7AIRietIQ+P3XY3q6ZcnT/VTwzKaJnjPfAEHcBotiBqat+fNNerA+gMsiHk6izw1pB8voveI3UWczFVJBeYckqm0fOLuNdS94p4cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH0PR11MB4967.namprd11.prod.outlook.com (2603:10b6:510:41::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 01:36:49 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 01:36:49 +0000
Date: Thu, 30 Jul 2026 18:36:46 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Neil Zhong <neil.zhong@ugreen.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Message-ID: <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
X-ClientProxiedBy: MW4PR04CA0155.namprd04.prod.outlook.com
 (2603:10b6:303:85::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH0PR11MB4967:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c15635b-16e6-40d1-9a7b-08deeea430c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|11063799006|56012099006|10067099003|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 1xL3ZLT15N7PornhCuBPBIP9oLKM0AU+XuM9vibZ1LW8MczSbdcR/d2xHpQ/suwAU9NDosGnQuXGwU1QeZ5FpDE3P3v1pzA60HrgL1/VQpjfNDKYvFrRCsBeF+cxC+jNXqq13G4e4pBTE1k0i4xbn4vejGPyh2t/bIW3OG3Ru58RiyU9kVXNhxbIoJIS+LoJKpdJp/N0LhHOLHizQJt7b8WZ1mBJ5Lg/W5F59KrVWbAe7aEoN/84JqIb0tJ10QomoiTvlix0EJH3qaZM4YV5QKlfphz+Zn5BJPyWb1KgoDD/cKW1c283O7CjwTqLA9TVt9AqvO8UA4ZuHWycVV8eTgC93niIVeSA1FBfpor7rN/powot/3Ds5GPn8/oROnS2ayoCa9ZH92V7ii4SHj5yuXuzPH8q63xVTAQwnu8HlChMwkW8HwyptarASzcjYqhci1UvHrleyT2C3pM5zLMcUyczKOi/pjLXJL8EOsMqbfKiImu8Uh6E9LLppwVu6nezsMz2xdQ4YO5nRAdvi+4TWjMv7ElRkEXE07037bKGAgByjrwlsTyWmdbLPDma6dx5C2L8M75vC7Em0UPH6AD0Tu4ZxWks/ZYrL6mqrEF2kXqpZ2W8v5Z60GFwNFhmF5aK
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(11063799006)(56012099006)(10067099003)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TRMDJj8LCOBps3eWPwU86Rur21DiBGGVrGV/yufYkxcUDi0cnoZbfCOvnXfy?=
 =?us-ascii?Q?coev+nEbovloLTWlRcmvGQLlI1Jud0bkyvcul9MKDL0ZwT9fq6aIxfgQb+Cs?=
 =?us-ascii?Q?9b/x7dZiNl/xkQhV47/iis321yfi+brMl2nOkSMSSYGNXEoSOznUocs0TCdF?=
 =?us-ascii?Q?IWrY68Xiy1lhdf38aKKEtr2nyjLrOYn/GB0oUlMVqPt2zABIwP8EwIm6F2zO?=
 =?us-ascii?Q?XF/JySGTe2GRjWHjgyN+z872u23Sl3bpCDu3pZRQ6Jx65ny52+yJ3PDKloqQ?=
 =?us-ascii?Q?0ZivVnBtwzGN09Ysehz83pC1QRIZEV0xIdA+nVGMTyLZe3eDUgsobGORLl/C?=
 =?us-ascii?Q?l6JP6ZNgWf504AeimA860bLPI/sMBtAze1kg59mWckrrgDzVlA+r6jjThFjD?=
 =?us-ascii?Q?dVMZfwtohjDskqgdeJAOVvrlWFx9/xK+4Tz9HGem+UX/7l7kRJQnfwiFDNkB?=
 =?us-ascii?Q?j7pe/X4pEM22tQ+C00CeBgmBL5IwYXVXGZfhiosQWG/5NuXBkS8Wr79iVGzY?=
 =?us-ascii?Q?e12CWOCSTa0YB8Uasdm5/RFAjy88qbc82TiJ2RZ70eeAdmsLAvSRUjd2IiE4?=
 =?us-ascii?Q?T6nIIhcZtxLaUX5hbWAmaZQIDon9U29Bv4bYfYyg82/QUvnz+wS8jc4fdy48?=
 =?us-ascii?Q?+tDlWttppfSyheNEetXMsl1VZqCTiIegCZjxNRawiAY+CBf29lv9DJP66zRS?=
 =?us-ascii?Q?JFo3U8Zor5beMI8nI7/YiuvXCrwmiS8oOaug4VtRVmdMgpfMSwE/ICHPTMAU?=
 =?us-ascii?Q?3K7OLFKqm3mnD3O7bNQcJKKBYerHUR/+Jtncv2dlCRvJ8E980w0jBIG1MXbg?=
 =?us-ascii?Q?VzluOIhBCgnF/ngTw8D0RJr+oeD0ijzhCMTosvr5yB9vTjI4mwuV8PK9y72r?=
 =?us-ascii?Q?7N+bmz4Zq7Qj7rjSlXSoIeZ5jjCDt15oo+vQy37LWmIreFMfz6S0UCGCjHx7?=
 =?us-ascii?Q?JQhM14NJngkVV+NeOTg7g7XSd3LY69XnLIpeVvkuDG1Luv0pY5o7rw4x9Qxa?=
 =?us-ascii?Q?eLTktmjEuWZ0wVLVgadiHsKI7aL3ky606jwI3gLX+0jmRVdpY/nEhXdFULug?=
 =?us-ascii?Q?sqnQXdEVFnakBxCzM5BPAXPGkca6z3bvFIYq2afZMr3xVVZYanbV1iJwdMzZ?=
 =?us-ascii?Q?STocuOtTRE8k2x4jo+4JWwWB/zaxnjRwCgklYcfa3EsLKHqOLtgaaByFW9Qv?=
 =?us-ascii?Q?U1oW3tzeokODnElScwMOhn8Rae16bzkhdB1xOttQTMCYQJIDQtT3u8tTHsIp?=
 =?us-ascii?Q?wiSOVG71Q/oRbo6ve2EOFhMQ3ZgFiGYAmgb6bmpPajeWnLhIV7B3jOVk97fE?=
 =?us-ascii?Q?ms6BrfCh+qpmQr3EsVhUKbOCHCSzCdF6noPYTNeGh9z3t9eD2GSWp1b1Hyd+?=
 =?us-ascii?Q?/FtUlwiEViLr0vqfxPeH8daIj6wvGJVroiPZZRW+J5p3Bmhz4yrpJGENCe7p?=
 =?us-ascii?Q?kDE3UNTWiX6UGUj6EQh2i1/oELZfB335rNoDqHpl7ZzzzFQLiBKn4//+mD3e?=
 =?us-ascii?Q?BRqbybS3uPbQWlRSEtCrMVrlXGpXQ1BaIGCX0mtGNB9FbXa1nclsdGmghALw?=
 =?us-ascii?Q?pc5wvXLJTY+LD5tiemk3RO6JMeTea3nsuKpB7ZhsY3ufYFLoixUDNSeEv4Hw?=
 =?us-ascii?Q?+arBpYxMf2hS+uVK2nhW4SS4mS/WQyvyT9JXfxhpeJtKqvpWmPSHUh2yfaA9?=
 =?us-ascii?Q?zffeI4Z5PiVbbc3z5qTyUDqIFJyQA6S6OTx8jBiKBcry/T6ow4S5Er/6eO1n?=
 =?us-ascii?Q?iz3jt0ylxI4s/9QCBdMBKTKyptmv+II=3D?=
X-Exchange-RoutingPolicyChecked: gK2Tb79UXrSok9AWRzp/iY05ukJw5zdYKJgMY9vW8ceyc3EG4l9iRBSqF9YDPZR0dbAjE3OxO3Di0SIvT7pJBVLVlVZBOIxXxmMHleBhECR8dyZ/+OGYx3h1QRwQOS0GgcSlVbASZ23xyYcoPD3dEE8lPtKDH0t9rpjyqIh5Rpuk/kbgo5ZE/yjNKfbYT9im9VBHQnO0EgHgU5qGSQjyPenHIOPqEJxhKnkHEYH57DVgdWRki3gCylTZ9/t2OUCaSirJZ69amkccMwqMwcjiNbyzgHcNmAlKduCepZRYzwPKOMdNJBf+jb0zOYfLaq9aERf2EsNEb4HixdmQpK++IQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c15635b-16e6-40d1-9a7b-08deeea430c6
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 01:36:49.5698 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajeWWJJ04olJlw9UlvdXRQQAfF0lU5XmVqmM2EaVCnsQ0gZofyzc0woEyAcLsx1uWOxOVI1nzGss3nNj5wLuPQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4967
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

On Tue, Jul 28, 2026 at 02:55:12PM +0800, Neil Zhong wrote:
> On x86, restoring a backed-up write-combined (WC) buffer object can be
> expensive. The restore path allocates WB pages and converts them with
> set_pages_array_wc(), which performs synchronous cache and TLB flushes.
> 
> Xe currently allows its shrinker to back up the pages of a WC BO while
> the BO still has GPUVA mappings created by VM_BIND. A later validation
> restores the pages while holding the BO's dma-resv. The cache-attribute
> conversion then serializes EXEC, VM_BIND and dma-buf users on that
> reservation object.
> 
> This was observed as intermittent HDR 4K60 playback stalls on two
> Panther Lake systems with 8 GiB of memory. In a pre-change reproducer,
> the maximum ioctl latencies were 549 ms for XE_EXEC, 291 ms for
> XE_VM_BIND and 343 ms for DMA-BUF IMPORT. ttm_tt_restore reached 80.6 ms.
> 
> Keep a non-purgeable WC BO resident while it has at least one GPUVA
> mapping. Purgeable BOs are still discarded, and after the last
> VM_UNBIND the BO becomes reclaimable again. Add an A/B module parameter
> which can restore the old behavior.
> 
> With the change, a 21-minute capture had no XE_EXEC, XE_VM_BIND or
> DMA-BUF ioctl over the 16.7 ms frame interval. Their respective maxima
> were 348 us, 136 us and 20 us. The ttm_tt_restore maximum was 8.33 ms,
> and the set_pages_array_wc call rate fell from 14.64/s to 0.179/s.
> 
> The change intentionally trades reclaimable memory for latency while a
> WC BO remains mapped. It does not take an additional BO reference or
> change teardown: VM destruction and process exit remove the GPUVA
> mappings and drop their existing references. During testing,
> MemAvailable remained near 3 GiB and the dma-buf working set released
> five 24 MiB surfaces while playback continued.
> 

I think integrating WC into the TTM priority scheme for LRU-based
eviction is probably the right approach rather than blocking WC from
shrinking. I have a series on the list that implements TTM priorities
for Xe [1], but WC isn't currently taken into account. It probably
should be, although I think we'd need more than four TTM priority levels
to do it properly.

If I respin that series with some WC awareness, would you be willing to
give it a try?

Also btw, we are aware of bunch shrinker / memory pressure /
fragmentation issues with Xe on iGPU devices and are actively working on
this, here are a couple more examples of in flight work [2] [3], here
some which have been merged [4] [5] [6].

Matt

[1] https://patchwork.freedesktop.org/series/170454/
[2] https://patchwork.freedesktop.org/series/170216/
[3] https://patchwork.freedesktop.org/series/168651/
[4] https://patchwork.freedesktop.org/series/165878/
[5] https://patchwork.freedesktop.org/series/168649/
[6] https://patchwork.freedesktop.org/series/168466/

> Signed-off-by: Neil Zhong <neil.zhong@ugreen.com>
> ---
> Changes in v2:
> - Call ttm_bo_shrink_suitable() before the Xe-specific WC predicate, so
>   ttm_bo->ttm is known to be non-NULL before checking its cache mode.
> 
>  drivers/gpu/drm/xe/xe_defaults.h |  1 +
>  drivers/gpu/drm/xe/xe_module.c   |  6 ++++++
>  drivers/gpu/drm/xe/xe_module.h   |  2 +-
>  drivers/gpu/drm/xe/xe_shrinker.c | 28 ++++++++++++++++++++++++++++
>  4 files changed, 36 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_defaults.h b/drivers/gpu/drm/xe/xe_defaults.h
> index c8ae1d5f..645e289f 100644
> --- a/drivers/gpu/drm/xe/xe_defaults.h
> +++ b/drivers/gpu/drm/xe/xe_defaults.h
> @@ -22,5 +22,6 @@
>  #define XE_DEFAULT_WEDGED_MODE			XE_WEDGED_MODE_UPON_CRITICAL_ERROR
>  #define XE_DEFAULT_WEDGED_MODE_STR		"upon-critical-error"
>  #define XE_DEFAULT_SVM_NOTIFIER_SIZE		512
> +#define XE_DEFAULT_ALLOW_BOUND_WC_SHRINK	false
>  
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
> index 848d6526..67bcaf54 100644
> --- a/drivers/gpu/drm/xe/xe_module.c
> +++ b/drivers/gpu/drm/xe/xe_module.c
> @@ -22,6 +22,7 @@
>  #include "xe_sched_job.h"
>  
>  struct xe_modparam xe_modparam = {
> +	.allow_bound_wc_shrink = XE_DEFAULT_ALLOW_BOUND_WC_SHRINK,
>  	.probe_display =	XE_DEFAULT_PROBE_DISPLAY,
>  	.guc_log_level =	XE_DEFAULT_GUC_LOG_LEVEL,
>  	.force_probe =		XE_DEFAULT_FORCE_PROBE,
> @@ -33,6 +34,11 @@ struct xe_modparam xe_modparam = {
>  	/* the rest are 0 by default */
>  };
>  
> +module_param_named(allow_bound_wc_shrink, xe_modparam.allow_bound_wc_shrink,
> +		   bool, 0600);
> +MODULE_PARM_DESC(allow_bound_wc_shrink,
> +		 "Permit reclaim of VM-bound write-combined BOs");
> +
>  module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size, uint, 0600);
>  MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size in MiB, must be power of 2 "
>  		 "[default=" __stringify(XE_DEFAULT_SVM_NOTIFIER_SIZE) "]");
> diff --git a/drivers/gpu/drm/xe/xe_module.h b/drivers/gpu/drm/xe/xe_module.h
> index a0eb7db0..bf2c49ce 100644
> --- a/drivers/gpu/drm/xe/xe_module.h
> +++ b/drivers/gpu/drm/xe/xe_module.h
> @@ -12,6 +12,7 @@ struct work_struct;
>  
>  /* Module modprobe variables */
>  struct xe_modparam {
> +	bool allow_bound_wc_shrink;
>  	bool probe_display;
>  	int force_vram_bar_size;
>  	int guc_log_level;
> @@ -32,4 +33,3 @@ bool xe_destroy_wq_queue(struct work_struct *work);
>  void xe_destroy_wq_flush(void);
>  
>  #endif
> -
> diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
> index 83374cd5..edbc22b2 100644
> --- a/drivers/gpu/drm/xe/xe_shrinker.c
> +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> @@ -11,6 +11,7 @@
>  #include <drm/ttm/ttm_tt.h>
>  
>  #include "xe_bo.h"
> +#include "xe_module.h"
>  #include "xe_pm.h"
>  #include "xe_shrinker.h"
>  
> @@ -54,6 +55,30 @@ xe_shrinker_mod_pages(struct xe_shrinker *shrinker, long shrinkable, long purgea
>  	write_unlock(&shrinker->lock);
>  }
>  
> +static bool xe_shrinker_skip_bound_wc(struct ttm_buffer_object *ttm_bo,
> +				      const struct xe_bo_shrink_flags flags)
> +{
> +	struct xe_bo *bo;
> +
> +	if (flags.purge || xe_modparam.allow_bound_wc_shrink ||
> +	    !xe_bo_is_xe_bo(ttm_bo))
> +		return false;
> +
> +	bo = ttm_to_xe_bo(ttm_bo);
> +
> +	/*
> +	 * Restoring a backed-up WC BO changes freshly allocated WB pages to WC.
> +	 * On x86 that runs CPA cache/TLB flushes synchronously while validation
> +	 * holds this BO's dma-resv. A VM-bound BO is also likely to be reused by
> +	 * a following EXEC, so reclaiming it can turn moderate memory pressure
> +	 * into a multi-client reservation-lock stall. Keep that working set
> +	 * resident; purgeable objects and objects after VM_UNBIND remain
> +	 * reclaimable.
> +	 */
> +	return ttm_bo->ttm->caching == ttm_write_combined &&
> +		xe_bo_is_vm_bound(bo);
> +}
> +
>  static s64 __xe_shrinker_walk(struct xe_device *xe,
>  			      struct ttm_operation_ctx *ctx,
>  			      const struct xe_bo_shrink_flags flags,
> @@ -78,6 +103,9 @@ static s64 __xe_shrinker_walk(struct xe_device *xe,
>  			if (!ttm_bo_shrink_suitable(ttm_bo, ctx))
>  				continue;
>  
> +			if (xe_shrinker_skip_bound_wc(ttm_bo, flags))
> +				continue;
> +
>  			lret = xe_bo_shrink(ctx, ttm_bo, flags, scanned);
>  			if (lret < 0)
>  				return lret;
> -- 
> 2.50.1 (Apple Git-155)
