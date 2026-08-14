Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 580F0C5DF67
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 01:23:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6296610E0C3;
	Fri, 14 Aug 2026 01:23:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="kotOVbpL";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6635010E0C3;
 Fri, 14 Aug 2026 01:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1786670605; x=1818206605;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=nnyuzqTewUKCCzeQ5oynxcVYj5GhunyokQsvejux70E=;
 b=kotOVbpL/V59K+lMVHWuAY7uBs2HxZsGoe6xxAHxLPO/I906TeSfQPEs
 9LcQ5P6924ndpiBZXCjvPU3fbY4dF6JDklfJrU1eAZvPlIqdXi6ZQLGGE
 IQsMCYg1j+qL+JjTlqdZrwnxI0bo2e2Wv/wS5V/hHEutK9+3ASJTbHjSy
 Z9bm4jBl9U/kX/o9NZSKOtwh/7tWPyiJM7XO3lQ/a0xBeB6uxieLr9MCd
 TK+jj6buhztHQtg1bTzjE5JAG1NDmCUgCYcQ0yAgXsSrjJPuvzchYv7bF
 bBhGQemWZoozBwv9CgPcUY3oKOoPdUaubptOjTpod0aQmz9Bb83O8PGD7 g==;
X-CSE-ConnectionGUID: wurYSCRsR3KmKaWPp2Xc4Q==
X-CSE-MsgGUID: lvw7/419QjumApkJ26Uo2A==
X-IronPort-AV: E=McAfee;i="6800,10657,11874"; a="89772850"
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="89772850"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 18:23:24 -0700
X-CSE-ConnectionGUID: xmYGpn9QRjio5gIN+b3a4w==
X-CSE-MsgGUID: VGbDHOVxSluVjV0po2vVsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,222,1779174000"; d="scan'208";a="267953009"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Aug 2026 18:23:23 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 18:23:22 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45 via Frontend Transport; Thu, 13 Aug 2026 18:23:22 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.6) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Thu, 13 Aug 2026 18:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YYRDREvDY4ylaDINeKZR8zyJxkVJa2HToe8dDIR/h8QjoCWkJ8/wS8eWuejiWE/kHbBdfLCiMu/CdJODy5KWr//BNYTNreJZZ3IsC+AbkM9Y0a/ZAJTfUEtbAqI/qHMa4mSow6aDxnAUdzn99akP2Cf4E2+1vgFCPXtiJAfWbAOnP6aGu8r53U7VBN0Yr2UkRyTaHWxdFPB4QMNk3rq1HfGthocGqQ5rL1hiRm/ESYgtfYT8TExQmG5cONlkj784z7fVuJ6xa7EKoyYo0ofkYWJC20B1BZD/3hFe/Abtf3mliXlOQF4TfY3hnST4nhBmzUI5vTKsoo7eiLoVID1EHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dtPXbZkldHTQBWlVnxmQBvCL3N8XKTx1nitchiAav4A=;
 b=o3Y3NnQ4P5tA1yAJhibzcGWtMbRrVOdVABP1UlEvZZhtqzYhRrZfC/u8GBS1/E6TJfgw6y+bPekiKpFzbxbQ1vHVNFIirotTYoiO0dPMJOsJWss1oY/BPfHmUWVJHWCI9ttwbr+eLxdfwNVIKHvQQ1D5nW17j97tlEnFh5f9DMxNueYMbillBJ7jfWjs20tSeuJ/f2YEPEBtHOFPlw1YbPVacuZg3LnLq004ocRdVMOSa3OdJI0lWMSnVVa6yOTBWXlDUDxER7GvtPkYgNCAjTA5HHBS7V2kiCiOpw8u8xOodOAkRBHqe1pXN4pjUC8GrHKYXVztN6OBJDyiagbx8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by LV3PR11MB8556.namprd11.prod.outlook.com (2603:10b6:408:1b4::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.315.12; Fri, 14 Aug
 2026 01:23:19 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0315.011; Fri, 14 Aug 2026
 01:23:12 +0000
Date: Thu, 13 Aug 2026 18:23:09 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Neil Zhong <neil.zhong@ugreen.com>
CC: <intel-xe@lists.freedesktop.org>, <thomas.hellstrom@linux.intel.com>,
 <rodrigo.vivi@intel.com>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [RFC PATCH v2 1/1] drm/xe: keep VM-bound WC BOs resident during
 reclaim
Message-ID: <an5t/XpRTAIuR6j5@gsse-cloud1.jf.intel.com>
References: <20260728065512.59911-1-neil.zhong@ugreen.com>
 <FEC04D5B1E58A204+20260728065512.59911-2-neil.zhong@ugreen.com>
 <amv8Ll7+CJOcZ222@gsse-cloud1.jf.intel.com>
 <amwL8o5BcWmaC5Xs@gsse-cloud1.jf.intel.com>
 <2177DDCA3446E482+20260801053934.26608-1-neil.zhong@ugreen.com>
 <am2Lkcid3rLuqLFL@gsse-cloud1.jf.intel.com>
 <0AC9B69C6E8FB7B2+20260808093408.79701-1-neil.zhong@ugreen.com>
 <anvV3WiVbYMqjdbZ@gsse-cloud1.jf.intel.com>
 <B6F23642F2B2211D+20260812082850.60737-1-neil.zhong@ugreen.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6F23642F2B2211D+20260812082850.60737-1-neil.zhong@ugreen.com>
X-ClientProxiedBy: MW4PR03CA0308.namprd03.prod.outlook.com
 (2603:10b6:303:dd::13) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|LV3PR11MB8556:EE_
X-MS-Office365-Filtering-Correlation-Id: 31242c8f-e5fd-4e5f-1597-08def9a29b9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|22082099003|11146099003|18002099003|5023799004|11063799006|56012099006|3023799007|6133799003|18096099006|10067099003|4143699003|17096099006;
X-Microsoft-Antispam-Message-Info: NxVpS2OiqnUWDy/QXEsPW7rx4W01vnBpSgiGo7MKaiKBDVnmyo/X1BGAqDMq7VR7TBEwCKlzlkreSb4E75ZsfEgpvl3ia0GB8fTh2iiNKTf3ozARUq//DtxSx6PTA9Mdcc51zv9oB+4jQHgMUMsFTox/W92TggALZJy6dQPoTcgej19NxDl/nxwUSK7EqrPiSrWf29VhNzo+anSZSED2m9z6UKYG8BsHqdPpqGbXk/a83cAbgKXBT8z7MJX9v4inzP3vvdFfgMmRNsy9lVke8lX9VEly+RFx/9XMXUrsP8u2TXUYDqQ0fUAx8QF8mXi3iEcdz7+w97ktHG6C+cZtmBv3E5zY188y31/MklF8Q/76UD/uHkQBpXdnwJjjeyERmUTW8/0R9yhL23aA//3qNBCzkEOtjAtPie40wrYZkz6eamkd51M0OybyxtXIdi3hv1mtWEG/FoyYKscVVGZu/FfsMXWuzyFYmAXk3y7kE/2xAVTWX3bn1XbMBluzDqxpeIdkil6vObfVU7k8lhN+T/QTbNB45zta6+CIoDn9XUYQ0DteyAA8PsrVGoaYi1xMuB6bhqKHJSRlD3M4jYu8JAnzGC0yavYBwomyI0VeUXtHbOV4NsxrtZBxfrTVVKtzLUfofZRSkClljeR0i8bQbt7e+ckGKW/EdA8/N0pjSxU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(22082099003)(11146099003)(18002099003)(5023799004)(11063799006)(56012099006)(3023799007)(6133799003)(18096099006)(10067099003)(4143699003)(17096099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?nw2tX7uKdwtrTYKjjg2P64Nu4Fx6cnHdJ0e5d4283YUxvQCRq6MxXbIPvP?=
 =?iso-8859-1?Q?ffQbqYpGtHRmiONkFdmUghyfwcqIsq+jYDjQShdygNYzFG2MsFRdxPgIhc?=
 =?iso-8859-1?Q?90SClKN18ikZq7pXIpccGeCIlpy1lAKTibGL84GHVN6NPxnV4zQc9+lcUb?=
 =?iso-8859-1?Q?xG+0rbJDiljdUY/j0X4btoJU15eYuk/6bM7LqlNWM9/JWt5rKi47T5wujk?=
 =?iso-8859-1?Q?w1517e8nEucbv3uKx/FFCeswKEifMOAZNjFXCdhRdemnMR3JmO/d3j6p2p?=
 =?iso-8859-1?Q?fojZUGDlJwy7PVBktDv87E5bhK/q8pbUg1sFm+dyww4Cy78ibyeqYKOp/8?=
 =?iso-8859-1?Q?1ApfzEtCwZrG3lDRR+LJXfxtvA0hsx0wIpTs/G4jItIGrpJkqGcdvX90O7?=
 =?iso-8859-1?Q?HjUSrQdct2Y/ugK73Mu6pAqlJyqIu7yHi+EcB5dpg3YoiTtlSG9MU/GVJq?=
 =?iso-8859-1?Q?L1p/Q4KeNoVy1XSzIE/jIVpJkE/DqpG5N9BdEOdL042hTZvyMQxeNSMqa0?=
 =?iso-8859-1?Q?9P4vGQXgdeSM4ANteT4iIxksqEKbHN7FRkzt4pys9kXdaKlaeRvLIMnhaz?=
 =?iso-8859-1?Q?n5SikwGoyLB/zr4dT8XUzaYuQpH2GsZQk9LJghvpEftG3tp96ELgukHEiL?=
 =?iso-8859-1?Q?b5YHAEiRicuTEepwy5SHaY2URYi2jWZxhAiutS0DvvV2N32d7EZVuJfV6U?=
 =?iso-8859-1?Q?iNXZVGAx1eJtFlGk2fYxK9NbTQnvhuD+A2KYMuEw7O4V5oYoQvRU4EJ0GS?=
 =?iso-8859-1?Q?qY0OIwnXm7baSfesqn+Sp7DLeFBj362mg5VmsYTn7Mt/ZeDxvuo6eeELbU?=
 =?iso-8859-1?Q?ib3hNEM56nhotTssVCj28Aqzcogc3dKq7woifAx0v1/Vs8TGXHCjc+EROA?=
 =?iso-8859-1?Q?PfpiIvnYKeWj4yL0RKfLYDERTeJD6rtx/x9lo0n0RdsKTEL1Pf7IeqXErQ?=
 =?iso-8859-1?Q?KQSQKszdEGIIjG/XihuQlayYFc69N+XWifLYiaZeYnskxTWoJRyd2Nc8Ue?=
 =?iso-8859-1?Q?sVU40U0m+WncztgP/J4TjkcT2Zwg0F57ST+d/I3ryTKx1rV9FvEx/Kr+xi?=
 =?iso-8859-1?Q?P1ls2xlpypo0j1LG6ICNwNx+CJn2D2hckD623wx0hzZqaj4CXunoJhAw8d?=
 =?iso-8859-1?Q?43DydW4lPaOXDMgmrzI4Ixz3Wp5ieFJoR0mHGBBtAMXsT6UiWD7xWwmIaG?=
 =?iso-8859-1?Q?CpwfqtyGh2n2mgbLo3dpKkq9aSOk5xVi3DKI3m/ShPGVXoBg64WicrZby5?=
 =?iso-8859-1?Q?9sqkmaRisWzn6PLOdUotbFmgcVnXe6mpmZ43gRC4K7TThyq8Q9r95hamN+?=
 =?iso-8859-1?Q?c2YWCGPC//SzIJgSxJXhpiZtV8CuHF3S9lr0gu2QzDEHI2a/mQZwaXO+fh?=
 =?iso-8859-1?Q?POR2/mmbZ72PHoRCH8D916U9yVKhFjCVnlKRfrIsh88c9ijHvveFEU2dhN?=
 =?iso-8859-1?Q?zStNTS9fIijGE50EG92WNyS68ZWvkcHsZVLAfR3v11Ye/hvVkyLxML/vIE?=
 =?iso-8859-1?Q?LWuO3GGswt9vzpe6/xB2xMuFWjFfRdjlSDGDU1RkBJuh9khXsrnK6UMmOq?=
 =?iso-8859-1?Q?+qOdgo33yv7WuK9Sje3UfbsKtSkVcxtwh7SWUCKLqyhKAVJAF9iaoRGl05?=
 =?iso-8859-1?Q?C29fqj4BPRTak5jA6uyEkP+0OLUGictpMQf+tuL2aQ+qInCWzTfEibDaef?=
 =?iso-8859-1?Q?DJVGEQ/CawnYPWg2p4DIAWh9o3kJJaPejMMFByksao+kFT0+OZyfCtNAZp?=
 =?iso-8859-1?Q?sRrQ5Exfz+fmib5Oc2Tu3buC81eacPuwhNATdpqXrHH4C7SUGxKoPrLRYC?=
 =?iso-8859-1?Q?ZTtYmvTjzg=3D=3D?=
X-Exchange-RoutingPolicyChecked: kUh4f/p+GTgyH8nXC/PngdYdCjkE/gjgxJzCtvTAfBxbag4gKtbrh4O4x3dgGHVRJIyuw5d+txS6dvbSKZ3ksLiRjMBzicKVGa2zygJ1m0NXlT4XyP+PeLtJmWUxNJkHwpPbMJZsDyFFQlaTmrpq9RGnahpCjGDecmvuKEUQ3ECw5vT7P6ZTjbHvhbAu01yS9m2Ca0u5ShVxrTzgBZswlUDgyrwBIEPi8joCQrXRoIwKiCNgsfbcEplTUVhEGmUkwPuoP8TqfVCh+i77SGXOJa3AhRUbl2dgeNWVcUUbQOfWol3djJQKfVPs2MTcPN73srfNv7EdFwcQGI0tyI8yLg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 31242c8f-e5fd-4e5f-1597-08def9a29b9e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2026 01:23:12.5982 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pvC5oOh3+KcoYIvmu1kgsxnlbfcszo7qX4SBURkyjfS6bEWcAkcTt2yUbh+5MvSYENjOo3LHWDAi5gLxL+w9rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8556
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

On Wed, Aug 12, 2026 at 04:28:47PM +0800, Neil Zhong wrote:
> Hi Matt,
> 
> > Can you give me instructions on how to recreate this on our end and your
> > machine, memory details? I have a bunch of various reproducers which I
> > have been using for shrinker work and the more the better.
> 
> Yes. The test system and workload are as follows.
> 
>   - Panther Lake iGPU using shared system memory
>   - 8 GiB installed memory; /proc/meminfo reports 7,723,392 KiB
>   - 4 KiB base pages
>   - four zram swap devices, 3,858,416 KiB in total
>   - Linux 6.18.15, x86_64, PREEMPT_DYNAMIC
>   - X11 fullscreen output at 3840x2160 and 60 Hz
>   - a 3840x2160, 60 fps, HEVC HDR video played continuously in a loop
> 
> The player uses hardware decoding. Each decoded frame is imported through
> DMA-BUF and processed by libplacebo/OpenGL for HDR tone mapping before
> presentation. It calls glFlush() for every rendered frame. During steady
> playback, the player accounts for about 1.85 GiB of logical Xe BO
> allocation, including about 672 MiB reported as shared.
> 
> The player is not currently public. However, an equivalent pipeline should

This will become a problem if we introduce a uAPI, as we need an
open-source consumer of that uAPI. Fortunately, it looks like we are
already moving toward pinning uAPIs for several other reasons as well.

> reproduce the condition if it keeps the decoded surfaces, HDR intermediate
> render targets and presentation surfaces alive, rather than creating a
> small synthetic BO set. 
> 
> No additional memory-pressure tool was used for the first reproduction.
> I start the video, let its working set reach steady state, and then capture
> ten minutes while playback continues. On the 8 GiB system, the priority-only
> run had MemAvailable between 2.89 and 3.15 GiB, while 97.8% of kswapd wakeups
> were for order-10 allocations. Thus this reproduces without forcing an

We have upstream fixes for the order-10 allocations to avoid triggering
reclaim for anything other than order-0 or order-9 allocations. I shared
that patch in a previous reply, and it is probably worth pulling in as a
mitigation, plus the core MM series.

> order-0 shortage.
> 
> I collected the trace with:
> 
>   sudo ./capture_xe_memory_churn.sh \
>           -t 600 \
>           -s 0.2 \
>           -o ./xe-memory-churn
> 
> `-t 600` records ten minutes. `-t 0` can instead be used to record until
> Ctrl-C. The 0.2 second option is only the /proc and TTM-pool sampling
> interval; ftrace events are recorded continuously.
> 
> The player also logs one line after each frame submission in this form:
> 
>   gl_sw_submit_frame timing: ... Flush=123.456 ms
> 
> The log prefix contains the wall-clock timestamp. An equivalent reproducer
> can record the time immediately after glFlush() returns and the measured
> duration. The trace script inserts a wall-clock epoch marker into a
> mono_raw ftrace stream so that the two timelines can be aligned.
> 
> The figures in my previous email came from the 6.18.15 kernel with [9]-[13]
> backported, the fragmentation check applied to direct reclaim as well, and
> the high-plus-min watermark experiment described there. The default-device
> watermark capture used vm.min_free_kbytes=131072. The follow-up used 50000;
> the workload and trace procedure were otherwise unchanged.
> 
> > Also a quick write up how you extracted these numbers from reproducer so
> > I can recreate on my end.
> 
> The capture script creates temporary entry and return kprobes for:
> 
>   ttm_tt_backup()
>   ttm_tt_restore()
>   ttm_pool_alloc()
>   ttm_pool_free()
>   ttm_pool_shrink()
> 
> It also traces the Xe shrinker, TTM restore and cache-attribute functions,
> kswapd and direct-reclaim events, compaction, and allocation
> fragmentation.
> 
> At ttm_tt_backup() entry, the probe records the ttm_tt pointer and
> num_pages. At return, it records the positive return value, which is the
> number of pages actually backed up. I sum those successful return values,
> not the requested page count, when reporting backup volume. A later
> ttm_tt_restore() is matched to the most recent successful backup using the
> same ttm_tt pointer. That provides per-object backup-to-restore latency and
> repeated-cycle counts.
> 
> The byte-volume calculation is:
> 
>   backup bytes = sum(successful backup return pages) * PAGE_SIZE
>   restore bytes = sum(num_pages for matched restores) * PAGE_SIZE
> 
> The reported backup-plus-restore volume is the sum of those two values.
> It is cumulative migration/copy traffic, not resident memory and not net
> memory freed. A shmem backup remains resident system memory unless those
> shmem pages are subsequently swapped out.
> 
> > This customer, in particular, utilizes priority bands to express this
> > heuristic (e.g., the compositor is the highest priority, any
> > non-privileged UI-related content is normal priority, and everything
> > else is low priority).
> 
> I think priority bands are useful for relative reclaim ordering, but they
> do not by themselves express the guarantee needed here.
> 
> Consider a system with one large GPU workload. If nearly all reclaimable
> BOs belong to that client and are placed in the high-priority band, the low
> bands will contain few or no candidates. When enough memory is requested,
> the shrinker must eventually enter the high band. In that case, high
> priority delays reclaim but does not prevent it. The priority-only test
> showed exactly this limitation: over ten minutes there were 6,743
> successful backups and 6,693 restores, with 157 Flush calls over 16.667 ms
> and a maximum Flush of 494.434 ms.
> 
> I am not suggesting that every BO of a high-priority client should be
> unreclaimable. Whether reclaim is acceptable depends on the workload, and
> the kernel cannot infer that semantic from WC, VM-bound state, client count
> or BO size alone. For example, the driver-visible behavior of these two
> workloads can look very similar:
> 
>   1. Foreground 4K60 HDR playback. Its active decoded surfaces, HDR render
>      targets and presentation surfaces have a 16.667 ms deadline. Backing
>      them up and restoring them causes an immediate and clearly visible
>      product failure. These BOs should avoid eviction and shrinking while
>      they are part of the active visual pipeline.
> 
>   2. Background image recognition or classification. Its BOs have no
>      presentation deadline. Reclaiming them under system memory pressure
>      is reasonable, even if the job later has to reconstruct its working
>      set.

In this case, do you have two VMs sharing BOs? If the foreground and
background tasks share a single VM, it does not matter which BOs are
shrunk or restored because, when a VM is validated during an exec IOCTL,
all BOs mapped within that VM are restored.

I assume that in this case you are using two VMs that share buffers as
needed via dma-buf. Is that correct? If not, pinning is not going to
help unless the pinned set includes everything.

> 
> Priority bands cannot distinguish those cases if both clients assign their

Assuming there are two VMs here, set your foreground queue's priority to
NORMAL and your background task queue's priority to LOW. (Alternatively,
if the foreground task has CAP_SYS_ADMIN privileges, you could set it to
HIGH, etc.) This should cause the background BOs to be shrunk rather
than the foreground BOs.
 
There is another problem in Xe when VMs share BOs. The way a VM is
locked and validated during exec IOCTLs can cause cross-VM lock
contention get stuck behing shrinking. This issue exists regardless of
whether a priority-based solution or pinning is used.
 
For example, assume there are two VMs, one for the foreground workload
and one for the background workload. We correctly evict the background
BOs when needed, and some set of dma-buf buffers is shared between the
two VMs. Below a flow that shows a contention problem:

1. a private BO from background is shrunk
2. background exec IOCTL
	2.1. grab all dma-resv locks (including some shared with
	     foreground)
	2.2. restore shunk BO
	2.3. submit GPU job
3. foreground exec IOCTL (in parallel with 2)
	3.1 grab all dma-resv locks (including some shared with
	    background)
	3.2. submit GPU job

In this example 3.1 can get stuck behind 2.2 (an unrelated restore),
thus 3 can miss a presentation deadline.

We likely need our Xe IOCTL and GPUVM code to be smart enough to perform
multiple lock-and-validate passes. For example, we could initially lock
only the eviction set, validate everything, and then repeat the process
until the eviction set is empty. Only after that would we lock and
validate everything else.

This is an existing problem that really needs to be fixed. I'll probably
take a look at addressing it.

> current working set a high relative priority. This is why I think the
> business semantic has to come from userspace. Priority bands can remain the
> general ordering mechanism, while a separate, explicit and bounded
> NO_SHRINK or latency-critical mark protects only the BOs in an active visual
> pipeline. The mark should be removed as soon as a surface leaves that
> working set.
> 
> > To be clear - this would be an addition to fixes discussed above, right?
> 
> Yes. I see explicit workload-semantic protection as an addition to the
> core MM fragmentation/shrinker fixes and the Xe/TTM priority bands, not a
> replacement for either. I agree that testing series 168651 together with
> the priority bands is still useful for general working-set preservation.
> It can reduce accidental reclaim, while an accounted NO_SHRINK contract
> handles the smaller set for which a missed presentation deadline is not an
> acceptable reclaim tradeoff.

I don't think anyone is opposed to pinning if we can get the right
permission control in place (most likely cgroups).

Matt

> 
> Thanks,
> Neil
