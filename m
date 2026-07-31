Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79C75C55167
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 02:44:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF32C10E14C;
	Fri, 31 Jul 2026 02:44:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S6lPO7Fw";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8F34610E14C;
 Fri, 31 Jul 2026 02:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1785465849; x=1817001849;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Y00fXXpuyxo60x3j03tueSWh2n5NBD0LRnBZdo7wi+M=;
 b=S6lPO7FwQpnrVrx3N630Sr4wjEo4TnofbZ36gAfKpPzkoJJ05mCD7f64
 uC4ilz0X5tMPy1mkJJWvEEIuWAi1QgbHMqvq2PYRdntUDY/KyDL1i/ueW
 2IoULDcgZYqw8FDqEKfGpCQnPjxfqQw4FGeAyWKSP0zhppXGcKIWWL9Pw
 HmS4VfbpHZlTYjG2O38Xu70iMVv6J08FiXfUY3tuPHdU3SxkWi8QsGPu5
 h/jLybvZocK5fujFfNVqgUMD423rJroo/Lgl+kWpaHxP7/8CyWV9YsZ1e
 dHQvVDuet7w8E8+4pzQCKni6lbvOftm72zcpd9DOav96H77Xv5p8mcefO g==;
X-CSE-ConnectionGUID: ipoQNs/cRzyOTNCdFsqG+Q==
X-CSE-MsgGUID: dC0P9tSSQd6Cu3qECVE3kw==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="111637913"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="111637913"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 19:44:09 -0700
X-CSE-ConnectionGUID: quIMAkV4Q9+X1/HcJ3BBXg==
X-CSE-MsgGUID: NCoCMD33SL6xZN1SHd6qbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; d="scan'208";a="262410705"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Jul 2026 19:44:09 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 19:44:08 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 30 Jul 2026 19:44:08 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.35)
 by edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 30 Jul 2026 19:44:08 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pUM6RN6gpdc9lM09emgBszuGv1mpQ22ws2p3jvPB/nmEt8f3Z609+pMbGN/zda+KxUbU5LMpwj/TCj/FqUvizL2RRhpJtRQ/IeDiq+sUH6vNr5WArAPfx3Zk3NGkOMI8tpl60UjUeL/WKxnAp7IHunvwOCdbjdMuGoSy9A6KOHyiXop8KRXyxuupZ4H3gacV2tjBflq/0u9rjWq+f10VJ1jufX81ayr0fxPRPM7xjhXEEML4wSXsclfnwtLj3XjZUgL3XJ+Cd+/ZsNOW9XX86ObUH8bo9mxp3x3ySG/aj8jbJcHLAoC3PVby6C3KbvYKpnJnf4KJXH8hvQ98JXtf0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1NI2schHfADt2E+HUUkeeICM4jDi38bIRU+mvRMnF/4=;
 b=OLXgeK89mXztFSnBvvKm8kAOqot8g4AtS04/hATOz0ATPZtUl+82ShBwdCCOh/Ya2lL91yvC23DfVftN522fyEMvAW2KvfZUk3R8sKp9WOmJkgkSZYpj1NMc8pKW7fVnnL+MFSi4EtnUtsyZHj4MXvCPflq/5EzkWHUoyR42GIO7mEuy2QVqLveItjVJ2CHm7iUmaShtdUC3fWXESVK2uBa/ji/rnpRIInBV8m6FkqVQJ3Ss2pvqs9P5YofuuVBRWYFv3c0iDVLI1uSg0YxF/oadxwDXmd44CwcekemZ/fMQ7ywEIlDZSAqE3eS4tjsRw17v9/6F0qMPxruYGLAcSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by LVUPR11MB9787.namprd11.prod.outlook.com (2603:10b6:408:39b::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Fri, 31 Jul
 2026 02:44:05 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0270.012; Fri, 31 Jul 2026
 02:44:05 +0000
Date: Thu, 30 Jul 2026 19:44:02 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Neil Zhong <neil.zhong@ugreen.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Message-ID: <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
X-ClientProxiedBy: MW4PR03CA0016.namprd03.prod.outlook.com
 (2603:10b6:303:8f::21) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|LVUPR11MB9787:EE_
X-MS-Office365-Filtering-Correlation-Id: d5d82d3f-a79d-4137-51d9-08deeead9667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|4143699003|10067099003|11063799006|56012099006|13003099007|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: OCEfba66wuBk02ZZUdFAkQjGkKRjPjDV5aV6ZaMiXixIAJj2UfuNBgeu5Bzs8tYXoo9xnwkDiJPDa4A8w/TkwqDsZiKTkaRPVoY6G90Ux5svtJFCDGhBkV7Be8ANLslCh5p3+PEDxGBKCsF0wPX1zlov+LdiOWNuS1qvcIHJSTJ9ka13vLIZn8H5xdFspqKN6ILZ42J5mRy3ls8fqtlnbVfM6HzpvCL4+Pwd/H2e1dnag407tvT0StXaxx0CsbZcOobCX/zXISnAbphJ0SNmnGPAiEd9ueJqTPZQW45aBIyHjAZ/hZ1+MFvCbkguvTDeF5VB0LFojk3krQIhGII+Llru8ZnlQYWfUKvGWHid+Q0DOM1VVBV2DS6ylC8BufmeVQHPacPym6N1KSwNin3Ppw+JQypGMWpYE4DVijFLXcMCAAMInbWPxgOQtsxVZwUAonMom+nuQ2Al9zlYqAQV3Dvg4xBA4/v/h3KQvQ7F+ile/AY9zLd2YzWF3YiXsCgWR4xuXNmjJJShlKUBS14JVXf9yp2uHrOODZCUI9f9hrShH514SjJXK6+B+RrZg2/4t53GRgw9pmh/yk39d2IwD2kFX3cJsHMT2aMomGXAUYuYWyE8YFvwLfHLfRSEfGO5
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(4143699003)(10067099003)(11063799006)(56012099006)(13003099007)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HE2Q9OOusbCMi7LvX8KRY1jJICFWvPgAJI/Sz+cgeTll1ETsMEmEsNntMBmB?=
 =?us-ascii?Q?ujARApGfotfxK78aZ4g+ZXqXneFfmQ/hpcBjiTBiQS4CeRJ3Ogt6FuSqm//p?=
 =?us-ascii?Q?T1AtX78v5mzNCra/481heqpAUeMCi3BezoTNuhQirGmkhqkVLUkh4GYE040m?=
 =?us-ascii?Q?tk7HgrAee+mxTYwleiR8XC9cREy0V25jWebHra6WZ960xGunfhWgmP3KRQWW?=
 =?us-ascii?Q?7Tv5rs4BNaysrWNxMx8ru+jMv9OQxcDsoqAHxuPSKsMXE3oh35iIsEU5p6y2?=
 =?us-ascii?Q?9Op4FE4aZ43KJSgmnXjV+d1JR0LQfeHICpUFeiCkDId/oPDMDMZAeMtlQ7bj?=
 =?us-ascii?Q?l9tvZH16+AwMmHN2CYzn21tvidkQ3rgLsCR16o4TFddFfMI9eOm0aa3Hn8yk?=
 =?us-ascii?Q?Rwf08TLvFeySESyIZYD4Sdeq2WhDK1Wh+n0DzlWCDd8KyMksOo6pz+qMtO+v?=
 =?us-ascii?Q?OGlC3sUE2W/of51QssZUb4l1tUQASjMh9rCt9oZbm+ZtbboZl0sUBbX3qMja?=
 =?us-ascii?Q?+8rFAGXtyG1frDxDAIUqzxohtQwL1eMsizZr4RMDwAUXf5CKZgQHqgvK41eE?=
 =?us-ascii?Q?arntpiZqi7leHoQ5ahjHO9pRTOyQbSKWIZ8FipE3E0C4Ax8+XDF6BwBnouO8?=
 =?us-ascii?Q?AYJwODX4xnjaJs+12zznAXYkZRaIi+qWE/66+Ir2XFvBGdErsJQW5JIvlIyF?=
 =?us-ascii?Q?HFU7LV310jKMWxmS5sYfuC4fY6Bs+90KlZeSHd6gwc0UEKEs/l0nnFkZRv9q?=
 =?us-ascii?Q?R2BGfoGPUw+FdqeWsJ8SuJDtkiKgtnkGwsYNPALfoe8XN2RvE6u0s3+h1+Kh?=
 =?us-ascii?Q?0BVl7HNB/ybf8eeipXHMD98IbS9vD/7y8Hp5kFupP1Aq45CBuDZ5J+y54aTR?=
 =?us-ascii?Q?6dHOW0UGxCO2poKsle/xIJgx2pOPKdr/6IQgUUkUs2Xc9QufkiXnyINMovJc?=
 =?us-ascii?Q?kYdfs5RhahHTwpK5A4bprRNazhTSsR8VeQOJjcBfr4NdMjN7I855XF6K31qx?=
 =?us-ascii?Q?0t6dly78C4R1CAhV3Zlxy47GhST73LsI8AV9vr5QnUlUNzmDtcaSy9bcXJCu?=
 =?us-ascii?Q?v9v4qxqIU7pv0CPHy3RMiPXC73QNEg7vHlvuc7TFu3lDyFzaIdba4O6lEhKu?=
 =?us-ascii?Q?MD9VYlZwJzIDFaiIGAs+HoMlQjSp7L1iRLEl54ruPQY2F2ZvBnHoEP5y8ZHA?=
 =?us-ascii?Q?TE5VPbRV1t5c4e/DxJslwOCZb8kGt47oXpxdrGHEWAFIcOPfnbXm9ifC1fA7?=
 =?us-ascii?Q?bnWhUuKapRdpeQm6v5gMm02szhHb0G+dwuhWB3dfSlAQGveT/4Edepgzt8yX?=
 =?us-ascii?Q?jZP8RCYZNUGf5XzD2gmptrfIIk4eLtRnyX4KdrSt2gau2B2QFwXq4B9BjMA2?=
 =?us-ascii?Q?/+CxK0I14vvwDgH/XieR5TM+G+IUqY83kU9LxhEewoWJKqpRJdgW2MEtHD6D?=
 =?us-ascii?Q?+bKBO7jMIEfAq0cEze3Ylw7L/HX4AB1vwIrFKNkcj6sG71EVBEW+N7BWjrfr?=
 =?us-ascii?Q?I7ET8njyqdz3+1Liy5ZzFhzMHhTbikhBjFcK5bvT9mzc06O0+lHcztrSPM8g?=
 =?us-ascii?Q?qYktHLXa3W9TpHSOlZYRdHn/TOLCi3TF6ASu5lARpPwNDuUbk7Dt9XKv7aMN?=
 =?us-ascii?Q?tw5AUOrt/zL0lxQPGVCPXKr3Kx/OtMjgt0WJL500brXRVUiRPdKjmPxcYs9m?=
 =?us-ascii?Q?LV6UQszvNU+7EqnGm9qi4AewRBGx4P4g2F7venU5ih4v9dCO+J9mwGdgmcTM?=
 =?us-ascii?Q?8a7XCpRiWRXqI434ffnLJXLB0V4mek8=3D?=
X-Exchange-RoutingPolicyChecked: jaUNWsQ55FgmFfJFF2ekBaEBu4nSjrLDSYxIW34IyG2YcIaVk0h+swKId3HPBR35qSDspWCsk0ydf6ZHI/yIS6BYHaXKI+7XcM6D8BOG2gNscB/6cuzmZx/8mr41IUOHPOV1xDq4uLbd4tEeRNNKNv+EgSXbSVQyWCVjfOBISSF7ICFqotaeNtEZTTv43mMBk6WY/Sp+8Nl2qFsLDWv7UtFpTBLPEtWkNzyZJk07eSF7ocqx2Y9hKmDxcs9ez6BqIwdpJt0bssgC2lEZL7yhevYEeAg4ZGHWBv/Fys29KigUxyfOF5W3mGGRkTBUPNJq1+eozOpae1c57UerA2eZuA==
X-MS-Exchange-CrossTenant-Network-Message-Id: d5d82d3f-a79d-4137-51d9-08deeead9667
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2026 02:44:05.4517 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U4FG4SuzvxKia3ObUKT8kDeiipscMXpvEPNvQksulmaZdS7A/YjRW11WtgmS1+6Pkk1/n5BkF7KM0+VGbbdLJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LVUPR11MB9787
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

On Thu, Jul 30, 2026 at 06:36:46PM -0700, Matthew Brost wrote:
> On Tue, Jul 28, 2026 at 02:55:12PM +0800, Neil Zhong wrote:
> > On x86, restoring a backed-up write-combined (WC) buffer object can be
> > expensive. The restore path allocates WB pages and converts them with
> > set_pages_array_wc(), which performs synchronous cache and TLB flushes.
> > 
> > Xe currently allows its shrinker to back up the pages of a WC BO while
> > the BO still has GPUVA mappings created by VM_BIND. A later validation
> > restores the pages while holding the BO's dma-resv. The cache-attribute
> > conversion then serializes EXEC, VM_BIND and dma-buf users on that
> > reservation object.
> > 
> > This was observed as intermittent HDR 4K60 playback stalls on two
> > Panther Lake systems with 8 GiB of memory. In a pre-change reproducer,
> > the maximum ioctl latencies were 549 ms for XE_EXEC, 291 ms for
> > XE_VM_BIND and 343 ms for DMA-BUF IMPORT. ttm_tt_restore reached 80.6 ms.
> > 
> > Keep a non-purgeable WC BO resident while it has at least one GPUVA
> > mapping. Purgeable BOs are still discarded, and after the last
> > VM_UNBIND the BO becomes reclaimable again. Add an A/B module parameter
> > which can restore the old behavior.
> > 
> > With the change, a 21-minute capture had no XE_EXEC, XE_VM_BIND or
> > DMA-BUF ioctl over the 16.7 ms frame interval. Their respective maxima
> > were 348 us, 136 us and 20 us. The ttm_tt_restore maximum was 8.33 ms,
> > and the set_pages_array_wc call rate fell from 14.64/s to 0.179/s.
> > 
> > The change intentionally trades reclaimable memory for latency while a
> > WC BO remains mapped. It does not take an additional BO reference or
> > change teardown: VM destruction and process exit remove the GPUVA
> > mappings and drop their existing references. During testing,
> > MemAvailable remained near 3 GiB and the dma-buf working set released
> > five 24 MiB surfaces while playback continued.
> > 
> 
> I think integrating WC into the TTM priority scheme for LRU-based
> eviction is probably the right approach rather than blocking WC from
> shrinking. I have a series on the list that implements TTM priorities
> for Xe [1], but WC isn't currently taken into account. It probably
> should be, although I think we'd need more than four TTM priority levels
> to do it properly.
> 
> If I respin that series with some WC awareness, would you be willing to
> give it a try?
> 

So I posted another rev priority changes to account WB vs WB/UC:

[7] https://patchwork.freedesktop.org/series/170454/
gitlab branch: https://gitlab.freedesktop.org/mbrost/xe-kernel-driver-svn-perf-6-15-2025/-/commits/priority_fixes.v4

But after reading this a bit more carefully, I suspect the real issue is
that fragmentation is driving shrinker activity. Your changes more or
less prevent Xe from shrinking its working set, since nearly every
buffer is WC. In my opinion, that behavior is reasonable for
fragmentation-driven reclaim, but it is much less appropriate in genuine
low-memory situations.

This is also a known issue for us. We most recently attempted to address
it here [8], but the fix was blocked by the shrinker maintainer - the
same has happened to other proposed solutions as well. We have several
downstream customers carrying non-upstream fixes to work around this
problem too...

[8] https://patchwork.freedesktop.org/series/168651/

I guess if it isn't too much trouble could you test:

1. Priority changes [7]
2. Avoid shrinking working sets on fragmentation [8]
3. Both [7], [8]

Matt

> Also btw, we are aware of bunch shrinker / memory pressure /
> fragmentation issues with Xe on iGPU devices and are actively working on
> this, here are a couple more examples of in flight work [2] [3], here
> some which have been merged [4] [5] [6].
> 
> Matt
> 
> [1] https://patchwork.freedesktop.org/series/170454/
> [2] https://patchwork.freedesktop.org/series/170216/
> [3] https://patchwork.freedesktop.org/series/168651/
> [4] https://patchwork.freedesktop.org/series/165878/
> [5] https://patchwork.freedesktop.org/series/168649/
> [6] https://patchwork.freedesktop.org/series/168466/
> 
> > Signed-off-by: Neil Zhong <neil.zhong@ugreen.com>
> > ---
> > Changes in v2:
> > - Call ttm_bo_shrink_suitable() before the Xe-specific WC predicate, so
> >   ttm_bo->ttm is known to be non-NULL before checking its cache mode.
> > 
> >  drivers/gpu/drm/xe/xe_defaults.h |  1 +
> >  drivers/gpu/drm/xe/xe_module.c   |  6 ++++++
> >  drivers/gpu/drm/xe/xe_module.h   |  2 +-
> >  drivers/gpu/drm/xe/xe_shrinker.c | 28 ++++++++++++++++++++++++++++
> >  4 files changed, 36 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/gpu/drm/xe/xe_defaults.h b/drivers/gpu/drm/xe/xe_defaults.h
> > index c8ae1d5f..645e289f 100644
> > --- a/drivers/gpu/drm/xe/xe_defaults.h
> > +++ b/drivers/gpu/drm/xe/xe_defaults.h
> > @@ -22,5 +22,6 @@
> >  #define XE_DEFAULT_WEDGED_MODE			XE_WEDGED_MODE_UPON_CRITICAL_ERROR
> >  #define XE_DEFAULT_WEDGED_MODE_STR		"upon-critical-error"
> >  #define XE_DEFAULT_SVM_NOTIFIER_SIZE		512
> > +#define XE_DEFAULT_ALLOW_BOUND_WC_SHRINK	false
> >  
> >  #endif
> > diff --git a/drivers/gpu/drm/xe/xe_module.c b/drivers/gpu/drm/xe/xe_module.c
> > index 848d6526..67bcaf54 100644
> > --- a/drivers/gpu/drm/xe/xe_module.c
> > +++ b/drivers/gpu/drm/xe/xe_module.c
> > @@ -22,6 +22,7 @@
> >  #include "xe_sched_job.h"
> >  
> >  struct xe_modparam xe_modparam = {
> > +	.allow_bound_wc_shrink = XE_DEFAULT_ALLOW_BOUND_WC_SHRINK,
> >  	.probe_display =	XE_DEFAULT_PROBE_DISPLAY,
> >  	.guc_log_level =	XE_DEFAULT_GUC_LOG_LEVEL,
> >  	.force_probe =		XE_DEFAULT_FORCE_PROBE,
> > @@ -33,6 +34,11 @@ struct xe_modparam xe_modparam = {
> >  	/* the rest are 0 by default */
> >  };
> >  
> > +module_param_named(allow_bound_wc_shrink, xe_modparam.allow_bound_wc_shrink,
> > +		   bool, 0600);
> > +MODULE_PARM_DESC(allow_bound_wc_shrink,
> > +		 "Permit reclaim of VM-bound write-combined BOs");
> > +
> >  module_param_named(svm_notifier_size, xe_modparam.svm_notifier_size, uint, 0600);
> >  MODULE_PARM_DESC(svm_notifier_size, "Set the svm notifier size in MiB, must be power of 2 "
> >  		 "[default=" __stringify(XE_DEFAULT_SVM_NOTIFIER_SIZE) "]");
> > diff --git a/drivers/gpu/drm/xe/xe_module.h b/drivers/gpu/drm/xe/xe_module.h
> > index a0eb7db0..bf2c49ce 100644
> > --- a/drivers/gpu/drm/xe/xe_module.h
> > +++ b/drivers/gpu/drm/xe/xe_module.h
> > @@ -12,6 +12,7 @@ struct work_struct;
> >  
> >  /* Module modprobe variables */
> >  struct xe_modparam {
> > +	bool allow_bound_wc_shrink;
> >  	bool probe_display;
> >  	int force_vram_bar_size;
> >  	int guc_log_level;
> > @@ -32,4 +33,3 @@ bool xe_destroy_wq_queue(struct work_struct *work);
> >  void xe_destroy_wq_flush(void);
> >  
> >  #endif
> > -
> > diff --git a/drivers/gpu/drm/xe/xe_shrinker.c b/drivers/gpu/drm/xe/xe_shrinker.c
> > index 83374cd5..edbc22b2 100644
> > --- a/drivers/gpu/drm/xe/xe_shrinker.c
> > +++ b/drivers/gpu/drm/xe/xe_shrinker.c
> > @@ -11,6 +11,7 @@
> >  #include <drm/ttm/ttm_tt.h>
> >  
> >  #include "xe_bo.h"
> > +#include "xe_module.h"
> >  #include "xe_pm.h"
> >  #include "xe_shrinker.h"
> >  
> > @@ -54,6 +55,30 @@ xe_shrinker_mod_pages(struct xe_shrinker *shrinker, long shrinkable, long purgea
> >  	write_unlock(&shrinker->lock);
> >  }
> >  
> > +static bool xe_shrinker_skip_bound_wc(struct ttm_buffer_object *ttm_bo,
> > +				      const struct xe_bo_shrink_flags flags)
> > +{
> > +	struct xe_bo *bo;
> > +
> > +	if (flags.purge || xe_modparam.allow_bound_wc_shrink ||
> > +	    !xe_bo_is_xe_bo(ttm_bo))
> > +		return false;
> > +
> > +	bo = ttm_to_xe_bo(ttm_bo);
> > +
> > +	/*
> > +	 * Restoring a backed-up WC BO changes freshly allocated WB pages to WC.
> > +	 * On x86 that runs CPA cache/TLB flushes synchronously while validation
> > +	 * holds this BO's dma-resv. A VM-bound BO is also likely to be reused by
> > +	 * a following EXEC, so reclaiming it can turn moderate memory pressure
> > +	 * into a multi-client reservation-lock stall. Keep that working set
> > +	 * resident; purgeable objects and objects after VM_UNBIND remain
> > +	 * reclaimable.
> > +	 */
> > +	return ttm_bo->ttm->caching == ttm_write_combined &&
> > +		xe_bo_is_vm_bound(bo);
> > +}
> > +
> >  static s64 __xe_shrinker_walk(struct xe_device *xe,
> >  			      struct ttm_operation_ctx *ctx,
> >  			      const struct xe_bo_shrink_flags flags,
> > @@ -78,6 +103,9 @@ static s64 __xe_shrinker_walk(struct xe_device *xe,
> >  			if (!ttm_bo_shrink_suitable(ttm_bo, ctx))
> >  				continue;
> >  
> > +			if (xe_shrinker_skip_bound_wc(ttm_bo, flags))
> > +				continue;
> > +
> >  			lret = xe_bo_shrink(ctx, ttm_bo, flags, scanned);
> >  			if (lret < 0)
> >  				return lret;
> > -- 
> > 2.50.1 (Apple Git-155)
