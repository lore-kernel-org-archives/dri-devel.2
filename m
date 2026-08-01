Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91C42C5516F
	for <dri-devel@archiver.kernel.org>; Sat,  1 Aug 2026 06:01:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 777CB10E28F;
	Sat,  1 Aug 2026 06:01:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PqWX66tO";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 08D3D10E28F;
 Sat,  1 Aug 2026 06:01:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785564062; x=1817100062;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=fMSLAIAc4E5K/tlPVj2dNgiiZIhrC138HvYVuiBmF0I=;
 b=PqWX66tO64pSjk2VGWlxESuiX6JhK8JCLMr8K3beWdE0ty+34RlI1uEN
 lL31Z67E8X703zHQa5SaNA7G3CUnQvhpu81YMd0hEgttcQMxYx0S32eL4
 7eABr9gMux3bu/3lIQtO39+Bn30F5zLD+NLq1YOJtPN61mffMTg3Jtwlx
 8EjZmYJKZp1Gc0/AcijK7mm1+0g5IkJnHbv/6xMoHKhn2aXHJoByPBWoi
 jbTSZqfCVF3/IQsuaS2aDq2pjXDJdKLAT5itek7vj97lgEYUOkK8j/GdM
 QHXHHakFZ1aZxLkFzvi+uWw+3Wgqg02PsVwMDqf21U+OyXE+Z6i8jADvL g==;
X-CSE-ConnectionGUID: A6EPJS+CSFKDZeP4EOqaNA==
X-CSE-MsgGUID: 1HNqndteQauqm533sUfgrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="86384380"
X-IronPort-AV: E=Sophos;i="6.25,198,1779174000"; d="scan'208";a="86384380"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 23:01:01 -0700
X-CSE-ConnectionGUID: 1Pbm0N8sRw6YmOzZqolSRg==
X-CSE-MsgGUID: prsdaKVBRmmDyavd/J8Xnw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,198,1779174000"; d="scan'208";a="260801966"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Jul 2026 23:01:02 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 23:01:00 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Fri, 31 Jul 2026 23:01:00 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.37) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 31 Jul 2026 23:01:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=saDtJkyu4wuCoM9bmklnCXZiEVUgxUGmt67j5OXnuNu/Mp2/d01VWRHD/3K/vEL7FSRjm2YdEfBa0RZ4cIfirIU3FIlwFC9ObYS9Nmxfx2uzeyJiu6CHdnO/E5FNNXfcl8HdlfT9lmFjKk/nmMGzHEk+5vsAp4IGrCr0i3JmDsW9z34cGZ81lDNcZYvH+3K+uckB5hw7CDKmJtJJ40uuHcEL0jDfDXyW/JD2K/zAG2ObEMwDi+CQYSUAwn19xcyprnuBv3HFdWBTImTbTF3DB02r3bNrPVBOJRc4gjITAaMPboB2Fx2El/NUgcomEocXHHCpzcZJOV3MzTTIWgsX5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=txPv4ZPxXGSMIprnxtxozZDF6WDZ0cbJ1PYSf5ET8Z4=;
 b=wlCMhJVAQj65YF8OS6qNdAwwb0MXyJ3vxEVSxDzcXKajdAkj+LdpduuuNpi/FbINmXPdwVRuzBCDaJ+k9IeLs+HwSkzgZdn/CbFwViXKmM1EG9L3wJ5z6B2cxIoAfIfBmuCC4PbKgP0f6z3qGcA6h1KOclL88Zd11sK7ARk7inRBEkuhY41lnXFLurCYeVARZTp+ZBB5Z52W8SlVfguRhn1PvKIf9tYa1bS8xfXw9NtWtPgo+5PlNbgPCR9bJ/DpUlqAov86msGMohMWTRtqT3/bmCPEBbk1NjzyM2sdb6GsPjCyeRjPj16QzVqMyHNQo5i+nq1yS9Xhe21FOKdUxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB8541.namprd11.prod.outlook.com (2603:10b6:806:3a9::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.17; Sat, 1 Aug
 2026 06:00:52 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.015; Sat, 1 Aug 2026
 06:00:52 +0000
Date: Fri, 31 Jul 2026 23:00:49 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Neil Zhong <neil.zhong@ugreen.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Message-ID: <am2Lkcid3rLuqLFL@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
 <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
 <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
X-ClientProxiedBy: MW4PR04CA0374.namprd04.prod.outlook.com
 (2603:10b6:303:81::19) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB8541:EE_
X-MS-Office365-Filtering-Correlation-Id: 2627b503-bbf8-4eef-bd33-08deef923e04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|23010399003|1800799024|6133799003|18002099003|22082099003|11063799006|4143699003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info: rS9TFbekvV31qXUqWLxxjJTdZ5Z0X59UtTyAQCeV0iersdlmpxS70ZnrDWf58dQ+Ml28EOa5SRErM1GEKA0NjK7OnPt5bYkS4adzypOODKXNynerSRtk93X9+juaUi0UldJg7kpObB2MNtE45wFbYQAg2JjiHNqcTXC1N9QL1Z6cIY6W/PfQovLvW52l0VQmIwQC9d2bADsvXVOgpEbt+GjVfzhHugQggAel4wcRjTURHPCnyFyXAT1+96lIID0HBrptfoTxcpX7C0rETKHaWeuqJ7vwfBXo4tjlV0uLHNf6IYKIbeFbQrqMqap8NPdkNliG6Pu256x2BWyU8JESDUgRSNtwDe3vt/0SjnmFjsv+I2gC6Q2BjcDYjAc5TaDlK6uvQDy4W2jlKBwM2/bGrys2gV9Sqb4NrUlfJWYlaw8dqM+XuSqodSU6SOzr8s+eDVGcaM7YVjuvjOaq+7rePxVoolcBBTpHj1iBf1n5O5+gbxhVM/4GCpGAGTj5lAxNhgU5NHxu7S0v+cLKC3AkiFMFGQp7tOTZ1jMkXcEMXSpBQPgeuHAljTC6Q1J1PBPg0ZsAy7ky7m7zHf03/bOZlMsdiecmxRFSGVp/tdH/nLwn48nrcZ48VvT1A2Ua6SuV
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(23010399003)(1800799024)(6133799003)(18002099003)(22082099003)(11063799006)(4143699003)(56012099006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?grtdSvkIX6+hpJV615Hk4ae4AVtACi9JdMGLrQi1fTnWQN5YL4wlNI9TY4ve?=
 =?us-ascii?Q?qfq7Ck8Id58TMkH5pcWIMzAOvjI3ahPpKLdv0UFCVpGZKgpUP5obppwuQygc?=
 =?us-ascii?Q?klQJjqsX38FztRQq+Xbvpx1OyKrQEnQ76ZfsGChnRvNxPnjyujtIS73kW0Pa?=
 =?us-ascii?Q?0vPjuIlb5+Ih5hViSX4RxPZyC5KyEbpdyoZJwYvkAK9pfz5WiPFVqAftmuMf?=
 =?us-ascii?Q?Jt/aGhzIjIR6jTN2xSG1S3NPYiM6+BmT7hKCUKrAxa4rWGAoYdMbu7rZuCin?=
 =?us-ascii?Q?SGSrOafAFFIxN8M+GqOe39jO/xic4UVXMPLqCK+8frzcA2knWzUsG70ePa/h?=
 =?us-ascii?Q?sY4nYr5iDp69W89A7cNixQDXiah+VYAE2OFAj8PmV5WD9QD9J1svexIPvMcm?=
 =?us-ascii?Q?GpZTopDmXMByDV/6FDRCBrju/agx54vVqh0yyAA9s7D2BWkhYhD+/1cjIBrj?=
 =?us-ascii?Q?Ja02a2PSbodXsgie7nW5KeMLBLs2sjb6FBlzN6FtyhxCUQBSOMhwIWAC5+MI?=
 =?us-ascii?Q?2uJ8nJdoCGdXCYy/JxADCvgl3Ys+foxV4+tNVqplDmHa2vgdw+SafXXqAFV6?=
 =?us-ascii?Q?idPdYbKLPTFO3f9hsSm6dDBRjBPZyZJ++IsVyvhvzkWRytXwgkfhJgG5Dwg8?=
 =?us-ascii?Q?YAplEa1hTt9uMgfrQV3GEpC8hKw0lMsWF7bJ1Z05NJVjm96CvdoGhkQmFn38?=
 =?us-ascii?Q?GIIdicFpObo6WBsddCl84+QFsAjJ5a94I5u3LkCnVCpfEAnuyixviIkYFcHX?=
 =?us-ascii?Q?ov4+zKqZllArTW0IoKdxcbzLIEgg0P+LtudvzXdZTSRDWFwX308yfUY0hr3r?=
 =?us-ascii?Q?rurW7RB2OLRyxxM+j8oswIJySZcnhEmMXRoZeIosDDnnvctQUC3zK/zkMfEh?=
 =?us-ascii?Q?NbOWqxrqGdPd4cTBnDi1/4WQQe3Oh6v5BWTtsn5dRjJslM00ADaB69tcN0no?=
 =?us-ascii?Q?uBOfLGd77V/9OxFdJMvp4mubAFEt+3eVjxirw2+lIH9VhdQsNz2ICytPmwrY?=
 =?us-ascii?Q?HhVmuY9W6VrVnw1haW8cMB2WLkis04aUZm3mTGLrEfpnIYf4Qq2jVcnXqY6d?=
 =?us-ascii?Q?KYNVrV/FztG2NaSyLyyDIozSn8apn79lDq2SdnrQLgK70tNj8mLlSHxCxylG?=
 =?us-ascii?Q?3bIAhiVig1YKhTtk7v/PRexAvtsqWEEGOWpaovyzH6/cps2z8KpGFQI9S+Xi?=
 =?us-ascii?Q?NcbogbsI9RsSK4LLGPo+5Utcgou8Ea7QMuPXIIJMp7cwnFAdDibOipMwAXKD?=
 =?us-ascii?Q?9ve9FFL453Zc0V38JzyTFFkkhdzYvLEOKZZ8USQRVztZtRzKWFDkIhRx6m1K?=
 =?us-ascii?Q?S6FSiImDk+PAmWIuHdwbx+0HH5R/3PPaTKABgJQZjHxkFnqE33TctLJXxJMI?=
 =?us-ascii?Q?uaWyPgIDoKraTmeAoPXHbXlk7pGduEAztYvqTWjSoOyllH6fTpK2pg5J2znZ?=
 =?us-ascii?Q?IcAlawmDaKQjzgBePfvdHnAhsU0T3OqEkYkSImZreo9F9ykq8u3vnIbv26ay?=
 =?us-ascii?Q?vhKfVc1l4TanKemZOwODuL0LAQpjlSnTNNm5veUuuwGosBxucRnMdebnVbHU?=
 =?us-ascii?Q?Zb6WMST+ITcOWqnesxQHn3aIZufNRtD/RUG5g8ln2lPh2peLd9l763mbzpgy?=
 =?us-ascii?Q?vcfBohzm4Q8sz1R+VKcDpo29yhPg/IZCSuG2KtfYiBx4TEHlK7vEuSbgImaY?=
 =?us-ascii?Q?xYhsD4A0U/GOcX11gnSoe19fnvSX2prS1Jcj+3ehXmtaU0A80K81mAjPHzHg?=
 =?us-ascii?Q?dy+J1JPv3A=3D=3D?=
X-Exchange-RoutingPolicyChecked: VvQLoGNQh0Te1YY07hcvCDFsLdAUSx0DD5nVUSSu/WhLNFNpFU1LBDqGXPZJqbyvYWq7TzQ3Jw97W4YPQYUFYaeEaFxct8oBOXgMyWSHPLiYtu7Y8il0+ny6LmXVUN4xnBf76HQ8HvGpGqVGpX1uSdqNHRH5G8L0hRJ56rVwA0+PV2y207sWwnWXQW2ZwixtndshYK8HzyKKHMjnyAYMmKhve1yB7Wrp6sqtQpwaXfNVj/EMU4iUTAfDwmj6faw3MnTADIE2egvZtNBTmISYov4cytEeFr/P39QxMVKdu1glOPOGDUHAFB+IOuEK3WM1EbDbl4Cvvzi/RISCajkLiw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 2627b503-bbf8-4eef-bd33-08deef923e04
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2026 06:00:51.9399 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9zO3l+XqVOKkVL6KfQT7v3sz7xs/3R7CPTqmrZls6jL4VuJ8kVxx1IRLhGCo+kYRcpmrZDXffBzSLGJocZ+hgw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB8541
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

On Sat, Aug 01, 2026 at 01:39:13PM +0800, Neil Zhong wrote:
> On Thu, Jul 30, 2026 at 07:44:02PM -0700, Matthew Brost wrote:
> > So I posted another rev priority changes to account WB vs WB/UC:
> >
> > [7] https://patchwork.freedesktop.org/series/170454/
> > gitlab branch: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/priority_fixes.v4
> >
> > But after reading this a bit more carefully, I suspect the real issue is
> > that fragmentation is driving shrinker activity. Your changes more or
> > less prevent Xe from shrinking its working set, since nearly every
> > buffer is WC. In my opinion, that behavior is reasonable for
> > fragmentation-driven reclaim, but it is much less appropriate in genuine
> > low-memory situations.
> >
> > This is also a known issue for us. We most recently attempted to address
> > it here [8], but the fix was blocked by the shrinker maintainer - the
> > same has happened to other proposed solutions as well. We have several
> > downstream customers carrying non-upstream fixes to work around this
> > problem too...
> >
> > [8] https://patchwork.freedesktop.org/series/168651/
> >
> > I guess if it isn't too much trouble could you test:
> >
> > 1. Priority changes [7]
> > 2. Avoid shrinking working sets on fragmentation [8]
> > 3. Both [7], [8]
> >
> > Matt
> 
> Hi Matt,
> 
> Thanks again for the priority series. I have now done a longer test of
> [7], including a system-wide Xe/TTM trace that records the exact BO
> backup and restore traffic.
> 
> Test setup
> ----------
> 
> The test machine has a Panther Lake iGPU and 8 GiB of system memory. It
> is running Linux 6.18.15 with the applicable parts of the current v6
> priority series backported.
> 
> Since 6.18 does not have the newer Xe purgeable madvise state machine, I
> backported patches 1-4 and 7-8. Patches 5-6 depend on the newer
> xe_bo_set_purgeable_state() infrastructure. The active VM-bound WC path
> in this reproducer does not use those purgeable states.
> 
> The workload is continuous 4K60 HDR playback. Decoded video frames are
> passed through a libplacebo/OpenGL rendering path, with every HDR frame
> going through GPU HDR rendering/tone mapping before display. glFlush()
> submits the rendering work for each frame. The working set is mostly
> DMA-BUF-backed video/render surfaces and other VM-bound WC BOs.
> 
> Results with [7]
> ----------------
> 
> The priority changes alone did not fix the stalls. They appear to delay
> the first visible failure after playback starts, but once reclaim and
> fragmentation activity builds up, the same failure mechanism and
> hundreds-of-milliseconds Flush stalls return.
> 
> In a 599.545-second trace, the player recorded:
> 
>   Flush samples:                 16,462
>   Flush > 16.667 ms:               157
>   Flush > 100 ms:                   67
>   Maximum Flush:               494.434 ms
> 
> Every one of the 157 Flush calls over the frame interval contained both
> ttm_tt_restore() and set_pages_array_wc(). The maximum Flush contained
> 73 BO restores and 65 WC conversions.
> 
> For the memory trace I used temporary entry/return probes to record the
> ttm_tt pointer, num_pages, and the actual page count returned by
> ttm_tt_backup(). This allowed a later restore to be matched to the exact
> same ttm_tt rather than only comparing aggregate counters.
> 
> The ten-minute working-set traffic was:
> 
>   successful ttm_tt_backup:          6,743  (11.247 objects/s)
>   pages actually backed up:      6,717,364  (26,239.703 MiB total)
>   ttm_tt_restore:                    6,693  (11.163 objects/s)
>   restore matched to same ttm_tt:    6,673 / 6,693
>   matched restore volume:       25,993.043 MiB
> 
> This is at least 52,232.746 MiB of backup-plus-restore copy traffic in
> ten minutes, or 87.121 MiB/s on average. It is cumulative migration
> traffic, not resident memory growth.
> 
> Of 639 unique ttm_tt objects that were backed up, 491 were backed up at
> least twice. One object went through 125 backup cycles during the
> capture. The delay from completion of a backup to restoration of the
> same ttm_tt was:
> 
>   median:       47.932 ms
>   p95:         189.083 ms
>   p99:         360.138 ms
>   within 100 ms: 5,190 / 6,673 (77.8%)
>   within 1 s:    6,653 / 6,673 (99.7%)
> 
> This looks like working-set thrashing rather than reclaim of cold BOs.
> The caller distribution makes the cycle particularly clear: kswapd0
> performed 6,460 of the 6,743 backups (95.8%), while the restores were
> mostly performed by the player's rendering and decode threads.
> 
> The activity was bursty. Backup occurred in only 42 of the 600 trace
> seconds, grouped into 14 reclaim/restore storms, with up to 397 BO
> restores in one second. Backup and restore page volume had a same-second
> correlation of 0.997. Per-second maximum Flush had correlations of 0.904
> with backup pages and 0.917 with restore-request pages.
> 
> The trigger also looks fragmentation driven:
> 
>   kswapd wake order-10:             577 / 590 (97.8%)
>   wakeup_kswapd order-10:           560 / 576 (97.2%)
>   direct reclaim order-10:          512 / 518 (98.8%)
>   MemAvailable during the trace:    2.89 - 3.15 GiB
>   compact_stall/success/fail:       1,073 / 132 / 941
> 
> Thus the system still had about 3 GiB available while nearly all of the
> reclaim wakeups were for order-10 allocations. This is consistent with
> high-order fragmentation repeatedly invoking shrinkers, rather than
> sustained order-0 memory shortage.
> 
> There is also normal small-object allocation activity, but it is not the
> main problem. ttm_pool_alloc/free ran at about 41.6/41.5 calls per second,
> but 97.6% of allocations were only one or two pages and are normally
> reused through the TTM pool. In contrast, the same active working set was
> copied back and forth for more than 52 GiB during the test.
> 
> For comparison, with my earlier workaround that skipped non-purge
> shrinking of VM-bound WC BOs, set_pages_array_wc() ran at 0.179/s,
> versus 9.859/s in this test. The current trace restored backed-up content
> at about 11,099 pages/s, while the earlier capture recorded
> ttm_backup_copy_page() at 26.74/s. The earlier 21-minute capture also had
> no Flush, XE_EXEC, VM_BIND, or DMA-BUF ioctl over 16.7 ms.
> 
> The current trace is system-wide whereas that older function graph was
> player-TID filtered, so these are not fully identical A/B collection
> scopes. However, the difference in WC restore activity and the
> user-visible result is large and consistent.
> 
> Interpretation of [7]
> ---------------------
> 
> The priority changes seem to be doing what they are intended to do: they
> change which object is considered first. However, most of the active
> working set in this workload is VM-bound WC. Once the lower-priority and
> WB candidates are absent or insufficient, the shrinker still reaches the
> WC half of the bands and then the higher-priority WC BOs.
> 
> Therefore [7] has no clear steady-state benefit for this reproducer. It
> mostly postpones the point at which the active WC working set becomes the
> remaining reclaim target. Once that point is reached, the backup/restore
> and CPA cost is essentially the original problem.
> 
> Possible Xe-local alternative to [8]
> ------------------------------------
> 
> I agree that [8] may help this workload, and the order-10 trace data is
> consistent with the condition that [8] is trying to identify. I have not
> yet completed the [8]-only and [7]+[8] tests.
> 
> I also understand the MM feedback that this is a wider compaction versus
> shrinker-working-set problem, not something unique to Xe. Nevertheless,
> for Xe there may be a narrower implementation that does not require a new
> hint to be propagated through MM.
> 
> My idea is to make the Xe shrinker distinguish base-page shortage from
> fragmentation before entering its destructive, non-purge backup pass:
> 
>   1. Always keep the purgeable-object pass available.
> 
>   2. Check order-0 free pages against the relevant node/zone watermarks,
>      using sc->nid and the zones allowed by sc->gfp_mask. This should be a
>      watermark check, not a global MemAvailable threshold.
> 
>   3. If the relevant order-0 supply is healthy, for example above the
>      high watermark, treat the shrink request as fragmentation-only for
>      Xe and skip backing up the active VM-bound working set. Reclaiming
>      arbitrary BO-sized objects is unlikely to produce the contiguous
>      order-10 extent and is very likely to destroy the GPU working set.
> 
>   4. If the order-0 watermark is below low, treat it as genuine memory
>      pressure and retain the normal Xe shrinker behavior, including WC
>      reclaim if cheaper candidates are insufficient. Between low and high
>      the existing priority policy could remain the conservative fallback.
> 
> In pseudocode, the special case would be placed between the purgeable pass
> and the non-purge backup pass in xe_shrinker_scan():
> 
>   run_purgeable_pass();
> 
>   if (order0_watermarks_healthy(sc))
>           skip_non_purge_working_set_backup;

This actually roughly what downstream customers are carrying :).

It is basically these 3 patches [9] [10] [11] implemented directly in
the Xe shrinker code to avoid touching the MM or TTM...

[9] https://patchwork.freedesktop.org/patch/720030/?series=165329&rev=1
[10] https://patchwork.freedesktop.org/patch/720036/?series=165329&rev=1
[11] https://patchwork.freedesktop.org/patch/720031/?series=165329&rev=1

Alas I got nack'd by someone outside my subsystem on this approach.

> 
>   run_normal_priority_based_backup_pass();
> 
> This differs from my original workaround because it would not make
> VM-bound WC BOs unconditionally unreclaimable. They remain reclaimable
> under real base-page pressure, so the system can still recover memory in
> a genuine low-memory situation. It only avoids the expensive backup and
> immediate restore cycle while base-page watermarks say that the problem is
> fragmentation rather than capacity.
> 
> This Xe-local policy would not solve the broader problem for inode, dentry,
> or other shrinker-managed working sets, so I do not see it as a replacement
> for a general MM solution. It may, however, be a small and testable Xe-side
> safeguard while the general compaction/shrinker policy is being worked out.
> 
> Would this be a reasonable Xe-specific experiment, or do you think Xe
> should rely exclusively on an MM-provided indication such as [8]?
>

I think if you use the reference patches above to implement a heuristic
in Xe, or come up with a similar one, it will likely solve this issue.

Since you're on 6.18, you may also be missing some Xe/TTM changes
related to this problem that have already been merged into drm-tip.
There are a couple of one-line fixes that should help somewhat, but the
heuristic is what I think will actually address the root cause.

As heads up, I've started looking at this again and pushing to get
something upstream as this at least 5th time someone or org has flagged
this as a problem. Any data you can provide will help us push towards a
solution.

Matt

[12] https://patchwork.freedesktop.org/patch/732698/?series=168466&rev=1
[13] https://patchwork.freedesktop.org/patch/732420/?series=168389&rev=1
 
> I have retained the raw trace, the per-second timeline, and the probe
> script and can provide them if useful.
> 
> Thanks,
> Neil
