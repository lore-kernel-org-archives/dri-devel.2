Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BE77CC6B38
	for <dri-devel@archiver.kernel.org>; Thu, 15 Oct 2026 19:28:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54BFB10E34F;
	Thu, 15 Oct 2026 19:28:14 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 23B2110E291;
 Thu, 15 Oct 2026 19:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792092489; x=1823628489;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=qnyVtauojz/b/z13pTKECP2Qr1DBOJVUskoc9PX1k8Y=;
 b=h9tkzqh7Vyy2UIQifCXDzPh13wvbvxbHJ48FaTk+XfuqIkPRH2CgEBQv
 pyT1mwMbslZT2l4H5CCPPFP2vsWxNMIjAT0J4TIG2bXFclXbYPEvLjExA
 MjaW+Z9ApRP2798HsfRi3elQwJp48PW/pfkCRTebiKco2LsXa22NW/Gg2
 AS+g4RrUexCU+SxjFyeO7BLypmcG5q+DK/PWHjHqoZDYZqJzTfw+/HE+q
 OeSgWqb5a2PQ45LwqnA2sKzcN2ZpS1RQFRmSmfspmy5fAQpFlik/JJviN
 0lkjBA77yQxBW//Cfs9hlRio0zL/0a5o1S5Gx/t6lWvoFD2nwpLogZCpy A==;
X-CSE-ConnectionGUID: 7GEyk1dvStO4QuQa7u7Q4g==
X-CSE-MsgGUID: NQCK7UBmS72Pe6r1Y5XXXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11936"; a="878794"
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="878794"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 12:28:08 -0700
X-CSE-ConnectionGUID: CfAD/iiISRe2ypqj7sf+hw==
X-CSE-MsgGUID: 1gDxgUKgSt2HKI6qhfi6vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,160,1787036400"; 
   d="scan'208";a="1680303"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Oct 2026 12:28:08 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 12:28:07 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 15 Oct 2026 12:28:07 -0700
Received: from CY7PR03CU001.outbound.protection.outlook.com (40.93.198.8) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 15 Oct 2026 12:28:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nLidGegXJxV+zv2Zj7PA16EQAQlZLnBEdbrsbppmHrlqBYS/J7sQ8y4jkwHbC1REAAMSpwPWrYFyi5MPhh7TmtJ1kThNyqJo9/ExMx60eA+aCulK7AWzR5evqXf9x8Pm1pLU3gaVNQslVkgRBhUHuxfniZvn6Rcio0t3nVCBMSb91lroXfvx02swofWq82VgzplEyqbNskr1WJZx6uv2FcYMFLSaBd7sh8NtjrvySO7LN0+0LYPKkR7JW8K5PVyjvJTIOmaUFYNC1QmNjWcDuyF8RqtHsPbsJqy7v39JJnpLxAIGdi7ZhbgErEQD9ZVhtfxySvF3dghq/ysXijL0qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yvp1v3B81jQ+iYWBhZaN4b2bz8AlgrWiQudcnn/p6Ow=;
 b=J76q/e8G3xNLemLyalxKVW2tGNXwtSahjDAWVJHaXcKTRGMBtDSZG8l2kw5lqLiXEVdMjIMUZOqdvdBTOyb9/ziR9E/Fj0s9rUTNV5UW2+1oI27LBG29xQsDfT3xT5KMNHdyHCwlJFcsqc2IucSK9GzWzGaJe6nFTuziB5JVbse1eu8APUmJ31bb7GvKkUCRjsS0DOBL937e/b+uczp6quESMnOYdxUDT3sReIvOoUo4j2GyFCJJuqOOp4YXEAlodpP3FiNKzwi51H6Kf/xIaT5ebstskXYvfnXst4fhfGmqXncBNQkncgQOxb5htJLxT9nYOs8LU/9mdAjBdMBBhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB8185.namprd11.prod.outlook.com (2603:10b6:610:159::12)
 by SJ2PR11MB8587.namprd11.prod.outlook.com (2603:10b6:a03:568::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.14; Thu, 15 Oct
 2026 19:28:04 +0000
Received: from CH3PR11MB8185.namprd11.prod.outlook.com
 ([fe80::443e:8ff8:c5ac:1ac4]) by CH3PR11MB8185.namprd11.prod.outlook.com
 ([fe80::443e:8ff8:c5ac:1ac4%4]) with mapi id 15.21.0522.013; Thu, 15 Oct 2026
 19:28:04 +0000
Date: Thu, 15 Oct 2026 12:28:01 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Helen Koike <koike@igalia.com>
CC: <rodrigo.vivi@intel.com>, <demarchi@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <tvrtko.ursulin@igalia.com>, <linux-kernel@vger.kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [PATCH v2] drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET
 programming for ADL
Message-ID: <20261015192801.GC578251@mdroper-desk1>
References: <20260930170434.317671-1-koike@igalia.com>
 <20260930232937.GQ730887@mdroper-desk1.amr.corp.intel.com>
 <be2b367a-870b-4b93-84dc-eb36542fee82@igalia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <be2b367a-870b-4b93-84dc-eb36542fee82@igalia.com>
X-ClientProxiedBy: SJ0PR13CA0098.namprd13.prod.outlook.com
 (2603:10b6:a03:2c5::13) To CH3PR11MB8185.namprd11.prod.outlook.com
 (2603:10b6:610:159::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB8185:EE_|SJ2PR11MB8587:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e028d4-fe8f-4490-cb38-08df2af26ed7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|366016|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|5023799004|4143699003|261009221227099003|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info: xqulcGUQuWTcdr1TvE2mBtDb+H1S50Lu+UulM1p0bzthyGdPcNuC2OW2TwLcCf5yY9+lIL4VgWjVNqhtI++STQb3po+GTIXkulJ5okOEnGDJcwCZQ6mrL32KBhAKM9YdyxsI/JbFES2bjn3cWaYn8FtStnMSl5Eu3ov2jucZasCROeh67pR1GhzTmlqJXKkuAj1a5GTJFXuAWnUTttzduJg1j6J5BipxWMFKDDj2yOKH2r94cZB5HgjXZxqxEx1G6JFUbr7cneMu1R+wi+hCyMrGgqDOKFyjKt6DVXb/rzw6AvbS/DPUVEUc9MTaKNNJH0gc/oK69bNqIwe4qL44XwnPOxoja6ix+7wonRvkZEmpESgudbqsuNwEi44cxzb7GkZLI+Tr7ZEAF/lKvAU7YHKeLgBmsS+lOitsNaZwYRGs3TNjcB7YG+oGJfGSpdKDAeNOHlYXrZBPXD4FkkhaAP7EN3xR5XTVwy9IRKCj35AorsPo/j6A4dxeqKMr93863DS/xu4I/SiOWH0+7RiqBYGEjHp34iWq4jXckt0NGazRl1m2JGzazPlhjp4jETGAaBQ0vWmwcNXM+3j4qoDKRflYbGzWbr/ZkDrjHbgiwcTa1561OVQtKz8md3uP8OfYibhuG83nTAajAOyqqiBoEjLNoX6PRK/1KPcxUgYGlME=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB8185.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(366016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(5023799004)(4143699003)(261009221227099003)(261009223027099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4y8FUFF2UgeqyC8IRMYJuvanN/7SltGHKFK3aogL0t+lMcI0yJYOhwLXZjgF?=
 =?us-ascii?Q?hnRC8bsSUcGSTTIWDWy5bnum2yPmQrhzhheuA8cImXnMmyVk05+oxiUHPPwZ?=
 =?us-ascii?Q?c47g2vdTIrMD7EdsoYdAiTpPxGPLIUjHzGTFhT6rWup9V7xUdk18ubJi6Bmb?=
 =?us-ascii?Q?aFVs1y5XqmysCNEHGmWmcbAPUk4xGpMKWCPV6XCT5DGpteZKizpyXCVuRshK?=
 =?us-ascii?Q?knT1MCPgK/vrCI5MazURMLftcpdiAyj+K3fvR7XKGa6MRIcveJdNPeD0zIfz?=
 =?us-ascii?Q?9yUHqB4TOWHUjUlFynN1uV5IgcVpuclmjsJgtuNuu5VDV+tk+7HkKBhnlmPt?=
 =?us-ascii?Q?sMlLupWN6YROFWr6eiYnEjuMdPo+b+cdr8uLwQ/QDph2SEWjfzyrCyQHeGuN?=
 =?us-ascii?Q?qavZHf7WG8jprTAgxhIlLwnJH+vjjSDYZdtuKmjbjyd+poUFF7bmGVRC2oxG?=
 =?us-ascii?Q?MCsWIHmTeMHkaQdy5cNHZCEqLOhNVJH3kjA3YGwtp2U7xow/DzJe0GtwvI7B?=
 =?us-ascii?Q?UJckt+UGoFrhc1c+Ff2plox1Zh1VTHnCwNc3H2TIEnfsaezI3mBTCern6DAb?=
 =?us-ascii?Q?UrVo34zY/HUW9w3/BGDqZFtDyszAAXD8sjo9ytF3I4LCf2hd2k6dlh0jYSVP?=
 =?us-ascii?Q?O/Mz29fIcFDD2hBFZmFahB85vPTUukd3/t6gqvTJ5sZDjwqZ9vSBk9zfqssm?=
 =?us-ascii?Q?1mnGKOoPUzhUoMHunB0Leuutp9aJc39ylBy6/mIkz4n7Q0VOD4HpGRN5cXQH?=
 =?us-ascii?Q?492A8srmVNEgtXMAobiYjINS4khgQArwbguZIh7iiPfPTgvWBdlSGpc16GAZ?=
 =?us-ascii?Q?xhcZqBWCDg484qLssIDuCQ3D2vUSdT/Z7jphde5tWYVkTOSPRlNoObhShew8?=
 =?us-ascii?Q?/EKsq4HhZO6xYnjpPPBpdM4XbA4UI6TQQsJF79bZwFVUXHvIUXaMaAfb4DUu?=
 =?us-ascii?Q?JFd2znBcBiNqjF742NOWzmpp3UKz4BAuXMbvzxfkOqgRBcaRd5c6t8fcDL9c?=
 =?us-ascii?Q?2nySuxCXmIX8512omhOag1vA2eXlqv/2BUa2IfURu362Sl6saW/SOik0uDb4?=
 =?us-ascii?Q?kCGjnqpZKz1p/0jogYrpRFeJO6rFMnCNTvoTJ9+n3rJ+pTZ0ew0cnMmHraF9?=
 =?us-ascii?Q?wnBYaTCY/U9vXagjPWNTb7SUArFa4yPynhq4uVRYPSarGMec9KPgErgvGmf8?=
 =?us-ascii?Q?buGWcfWxT/VnwVXNeWHUo7URo+pJZp5ZOZ8q9Yg2RniSK/CW1SS31dNC+PzQ?=
 =?us-ascii?Q?ze1IaB+Tmi90cJMQc5NKE9p2IycgbnRQhwlxfRMJ5gMkuXjas2CQqDMIWbXQ?=
 =?us-ascii?Q?c/vQ9hOr8QSZNEyg2WO0cRX4Sf9/OLXvmY9s+69HT2wuKbWJd5CzOof/yk7T?=
 =?us-ascii?Q?ATQAhG3lVF/Bja7X+KXZeeAH96Liq2nSmv2kf+we7zerx3cRaziSLdYmF0m4?=
 =?us-ascii?Q?4Cg9dL4Bzx73tY5jicClOW6fOBpv9hd5353ha1H2KGTge+rgqDEVVOOalA+W?=
 =?us-ascii?Q?SY0IvFZ0bOZPyv4Qjs1MMCFM/uqLMzWhwInLDMxN5YtjCs5ivtyjskX5rBNl?=
 =?us-ascii?Q?KqBSueTV7t/eUZlaQVrtALRrNqXRw9wMb+9OjaMgc4usMuokYGkaxFiWfX3E?=
 =?us-ascii?Q?Zb5+Ip1oNnftYiRXZhSPfKhn9+jkpMyB9qKijApatOIxhe0RKhGbCCXqol3G?=
 =?us-ascii?Q?y0d++AgZtAHMARtynz5fLDhuKzXY0zjUwkinPbm+z+MWxvm19H1MlwLFFDt2?=
 =?us-ascii?Q?r+f2mQxM1B+0HImN4ODBtQIuCK/OmLs=3D?=
X-Exchange-RoutingPolicyChecked: qJrMm1fBDkotpu5xEex/msvTbJWaeiXdC7cFcb717EWOmsAk7K7hRdIjQq6J8DSx9+77T3upP5GnoqAZLJfWE1tNQn9I/kz4op8zntqG0sjDNOpdYKDZ+ld+QQpD71uy4TCKbuvYTqJQKvw460cWvTXmZDjsAnUHdmJU7efhwtQwzFT6Yt1nPaw0jB9klQP71GYrSnemttC0D/gUfSwH4p6QXN6gTnMOOZjb1kVgaC27dZ7gvb+GpdgnXnxacMVxyMkCIQICtsVA9VzH9sWXx0uE6xSWCSpCBQEKVTCvHo5GgVcZMVpfyzjdpPASNm55fvBErF3p8VcUTrddnvUlqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e028d4-fe8f-4490-cb38-08df2af26ed7
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB8185.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Oct 2026 19:28:04.2119 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: O9g10qIfHpWr61XqQxtC03I7yX4WinnjpXJrxd/WuKgUmJAnppjBamSzKFC9kplUzBQDJSpKuv9FvdEAEU7aS1CZ2PuC+tqGrm2+E/76paY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8587
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

On Thu, Oct 01, 2026 at 11:17:17AM -0300, Helen Koike wrote:
> Hi Matt,
> 
> Thank you for your reply, please see my comments below.
> 
> On 9/30/26 8:29 PM, Matt Roper wrote:
> > On Wed, Sep 30, 2026 at 02:04:30PM -0300, Helen Koike wrote:
> > > CTX_CS_INDIRECT_CTX_OFFSET default value is not retrieved from the GPU
> > > by inhibit+context save mechanism since it is not part of the Engine
> > > Context. Thus, at restore, 0x0 is programed back to the GPU, which is
> > > an invalid value according to the PRM.
> > 
> > I don't follow this explanation, but I don't think this is quite right.
> > For example, CS_INDIRECT_CTX_OFFSET definitely is part of the in-memory
> > context image (the CTX_CS_INDIRECT_CTX_OFFSET is the offet into that
> > context image where it's found). Let me try to explain the relevant
> > flows here.
> > 
> > When hardware first comes up, it contains "hardware default" values for
> > various registers.  For CS_INDIRECT_CTX_OFFSET, the hardware's default
> > value is 0xD, so that's the value the register will have when the
> > hardware first wakes up or powers on.
> > 
> > For registers that are part of an engine's LRC, whenever a regular
> > context switch happens, the current copy of the register gets written
> > out to memory in the outgoing context's LRC image, and a new value is
> > loaded from memory into the register from the incoming context's LRC
> > image.
> >> "Restore inhibit" is a special case that gets used at one place during
> > initial driver startup where we tell the hardware "switch to this
> > context but do *not* load any register values from memory for the
> > context that we're switching into."  When restore inhibit is used, the
> > currently-present register values remain unchanged by the context
> > switch and the only thing that changes is the hardware's idea of which
> > context is currently "active."
> 
> 
> The problem is that CTX_CS_INDIRECT_CTX_OFFSET is not inhibit by Restore
> inhibit.

Sorry for the delay getting back to you here.  After re-reviewing the
internal bspec, you're right CS_INDIRECT_CTX_OFFSET is indeed part of
"execlist context" section of the LRC instead of the "engine context"
section, so it doesn't get affected by the "engine context restore
inhibit" bit.

You can ignore my earlier feedback since it was mostly wrong.  :-)

It seems like programming CS_INDIRECT_CTX_OFFSET is something we should
be doing on all platforms, not just the pre-Xe2 platforms.  And contrary
to the comment that exists in the code today, 0xD is documented as the
hardware default for INDIRECT_CTX_OFFSET[15:6] on all engine types and
all Xe1/Xe2/Xe3/Xe3p platforms.

The failures you got from CI on the Xe2 platforms seem surprising to me,
but I can reproduce them on a local LNL machine, so they don't seem to
be a fluke.  If I can find some free time, I'd like to update that
configfs test to update registers that are actually part of the LRC
before/after the point we indicate via INDIRECT_CTX_OFFSET and see what
their behavior is.  A test update like that is slightly more involved
than just changing the string passed to configfs since we'd also need to
adjust the register readback strategy to actually use the command
streamer to read the correct context's copy of the register (today the
test just uses a CPU iomap to read the register after the LRC is no
longer running, so it only works to verify registers that aren't part of
the LRC's save/restore list and won't revert to hardware defaults).


I haven't looked at the old public PRMs too carefully, but for reference
here are the restrictions that are currently documented in our internal
bspec for INDIRECT_CTX_OFFSET:

 * "Indirect context pointer itself is restored during context restore
   and hence Indirect Context Offset must not be programmed with value
   less than 0x5."

   This restriction would imply that the current (before your patch)
   value of 0x0 is invalid.  Yet the IGT test that exercises
   INDIRECT_CTX via configfs somehow seem happy if we leave it at 0.

 * "It is not valid to program this to a value that is greater or equal
   to the starting offset for RS context."

   I believe "RS context" refers to the resource streamer, which is
   something that was removed from hardware all the way back in gen11
   and isn't relevant to either Xe1 or Xe2+ hardware.  It seems this
   bspec note is outdated, but I'm not sure if there's some different
   upper bound that needs to be honored today or not.

 * "Offset of Indirect CS context must be always programmed to a command
   boundary and cacheline boundary inside the context image."

   This one shouldn't be a problem; it looks like cacheline 0xD should
   fall on an instruction boundary for all engine types and all current
   platforms.

 * "BCS/VCS/VECS: This register functionality is not supported and must
   not be programmed"

   This restriction seems a bit ambiguous to me.  I'm not sure if it
   means the hardware ignores the value and it doesn't truly matter what
   we program for non-RCS engines, or whether programming something
   incorrectly can cause problems.  Doing nothing in the driver (as is
   the case before your patch) would leave the register at 0 and violate
   the other requirement about not being < 0x5.  Getting the hardware
   default of cache line 0xD into the register does require some
   explicit programming (as in your patch).


Anyway, I think we can mostly go with your existing patch here for now
with just a couple minor changes:

 * Replace "for Alder Lake" in the commit message with "for pre-Xe2
   platforms."  Also add an extra sentence or so explaining that even
   though this looks like it should be correct for all platforms, we're
   restricting it to Xe1 for now while we investigate the unexpected
   behavior we're seeing there.

 * Remove the entire "Enable INDIRECT_CTX leaving INDIRECT_CTX_OFFSET at
   its default" code comment since it was already wrong (i.e., the
   default offset does not vary by engine, and not programming the
   register doesn't actually leave the register at its default).


Matt

> 
> If you check the documentation on https://www.intel.com/content/www/us/en/docs/graphics-for-linux/developer-reference/1-0/tiger-lake.html
> , you can find:
> 
> PRM Vol 8:
> 
> "When a context is submitted for the first time for execution, SW can
> inhibit engine from restoring engine context by setting the "Engine Context
> Restore Inhibit" bit in CTXT_SR_CTL register of the
> logical ring context. This will avoid software from populating the Engine
> Context. Software must program all the state required to initialize the
> engine in the ring buffer which would initialize the
> hardware state. On a subsequent context save engine will populate the engine
> context with appropriate values."
> 
> And also:
> 
> ""INDIRECT_CTX" and "INDIRECT_CTX_OFFSET" registers are part of the context
> image and gets restored as part of the given
> context's context restore flow, these registers are part of the ring context
> image which are prior to
> engine context restore and hence the requirement of the offset being in
> engine context restore."
> 
> In other words: "INDIRECT_CTX_OFFSET" is not part of the Engine Context (see
> table on page 49 of the pdf from Vol 8, Engine Context is marked in dark
> blue), it is part of the Ring Context, so Restore Inhibit doesn't afect this
> register, which means it programs 0x0 back to the GPU, which is invalid.
> 
> 
> Without this patch I get the following:
> 
> :/ # cat /sys/kernel/debug/dri/0000:00:02.0/tile0/gt0/default_lrc_rcs
> [0x00000000] MI_NOOP (1 dwords)
> [0x11081019] MI_LOAD_REGISTER_IMM: 13 regs
>  - 0x2244 = 0xffff0008
>  - 0x2034 = 0x000000a8
>  - 0x2030 = 0x000000a8
>  - 0x2038 = 0x00530000
>  - 0x203c = 0x00003001
>  - 0x2168 = 0x00000000
>  - 0x2140 = 0x00200094
>  - 0x2110 = 0x00000000
>  - 0x21c0 = 0x00543001
>  - 0x21c4 = 0x00542001
>  - 0x21c8 = 0x00000000 ---> Zeroed
>  - 0x2180 = 0x00000080
>  - 0x22b4 = 0x00000000
> 
> 
> > 
> > So the overall flow for initialization is:
> > 
> >   * Hardware powers up / comes out of reset; INDIRECT_CTX_OFFSET should
> >     be 0xD.
> > 
> >   * Driver allocates memory to serve as the storage space for the
> >     "default LRC" (aka "golden context"); once initialization is
> >     complete, this will be the template that is copied to create new
> >     LRCs.  The registers/state in the default_lrc should be a copy of the
> >     hardware default values, with various adjustments the driver makes
> >     for things that we want modified for every context by default (e.g.,
> >     register changes requested by various hardware workarounds).
> > >   * Driver writes (with CPU) a basic LRI with the early register offsets
> >     (but not their values) into the LRC storage space.  This is just so
> >     that the hardware says "yep, this looks like an LRC" when we hand it
> >     over for a context switch.  Although we're only filling in register
> >     offsets and not values, this doesn't actually mean that registers are
> >     being set to 0 or anything like that.  Honestly I'm not sure if the
> >     hardware even truly needs us to do this anymore on modern hardware.
> > 
> >   * Driver submits the default LRC to the hardware with the "restore
> >     inhibit" flag.  This means that the hardware does *not* load any
> >     register values from memory like it usually would (i.e., live
> >     INDIRECT_CTX_OFFSET remains at 0xD)....
> This is not true for INDIRECT_CTX_OFFSET as stated above (unless I missed
> something).
> 
> >     ...The batch buffer submitted on
> >     the context adjusts various registers away from their hardware
> >     defaults if there are non-default settings we want present on every
> >     context in the future (e.g., settings requested by various hardware
> >     workarounds).
> > 
> >   * The batch buffer finishes executing, so the live register values are
> >     now the hardware default values, with a handful of modifications.
> >     Since we don't have any workarounds that adjust INDIRECT_CTX_OFFSET
> >     today, it's still sitting at its default value of 0xD.
> 
> This is not true for INDIRECT_CTX_OFFSET as stated above (unless I missed
> something).
> 
> > 
> >   * The driver submits a second context to the hardware with a noop
> >     batch buffer.  This context switch causes the live register values
> >     (including 0xD in INDIRECT_CTX_OFFSET) to get written out to the
> >     the first context (default_lrc)'s memory storage.
> > 
> >   * ...driver finishes initialization and user starts running real
> >     programs...
> > 
> >   * When a userspace process creates a new context, the "default_lrc"
> >     snapshot is copied as the starting point for the new context.  After
> >     that, various registers in the LRC are updated with unique
> >     context-specific values as necessary.  So every context created on
> >     the system should have INDIRECT_CTX_OFFSET set to 0xD.
> > 
> 
> This is not true for INDIRECT_CTX_OFFSET as stated above (unless I missed
> something).
> 
> > 
> > So I don't see any way that CTX_CS_INDIRECT_CTX_OFFSET could become 0.
> > Unless there's a hardware bug, the hardware should come up with a value
> > of 0xD, that value winds up getting recorded in the default_lrc
> > snapshot, and then every context we make later on down the road inherits
> > that value.  While we could change it to another value if we wanted the
> > indirect context batchbuffer to run at a different point during the
> > context save/restore process, we don't have a need to do that.
> > 
> > If you're seeing problems related to this register, I'd have a few
> > questions to try to narrow down what's going on:
> > 
> >   * Are you seeing problems on all engines or just a specific one?
> 
> I understand gt_engine_needs_indirect_ctx() returns true for Alder Lake only
> on XE_ENGINE_CLASS_RENDER, so this is the only one I tested.
> 
> > 
> >   * Can you provide the contents of
> >     /sys/kernel/debug/dri/0/gt0/default_lrc_* ; the value of this
> >     register should be at dword offset (0x16 + 1), so we can see if it is
> >     getting stored in memory correctly or not.
> > 
> 
> pasted above.
> 
> > 
> > Do note that Xe1 platforms like ADL aren't officially supported by the
> > Xe driver, so it's quite possible that there might be some hardware
> > workarounds for ADL that we just never implemented on Xe that could be
> > causing a problem.  Xe's force_probe support is just for usage by KMD
> > driver developers, so it was never expected to be fully stable or usable
> > for general end-user use cases.
> 
> I see, thanks for the note.
> 
> Even so, I believe that writting a default value in the beggining to make
> ADL happy should't be a problem.
> 
> Please let me know if you think I'm missinterpreting things, and thank you
> again for your review/reply.
> 
> Helen
> 
> > 
> > 
> > Matt
> > 
> > 
> > > 
> > > This causes sporadic hangs on Alder Lake when executing test
> > > IntelAngleEnd2EndTestCases (error VK_DEVICE_LOST).
> > > 
> > > Fix it by partially reverting commit c9dfd66cb91e ("drm/xe/lrc: Allow
> > > INDIRECT_CTX for more engine classes"). Re-add the programming of
> > > CTX_CS_INDIRECT_CTX_OFFSET for Alder Lake.
> > > 
> > > Fixes: c9dfd66cb91e ("drm/xe/lrc: Allow INDIRECT_CTX for more engine classes")
> > > Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> > > Signed-off-by: Helen Koike <koike@igalia.com>
> > > 
> > > ---
> > > v2:
> > >    - according to intel CI results, it seems that this default is not valid for
> > >      LNL and BMG platforms, so limit the change only to ADL.
> > >    - program the default only on ADL.
> > >    - restore the comment, but add note with exception for ADL.
> > >    - update the commit title/message with "for ADL".
> > > ---
> > >   drivers/gpu/drm/xe/regs/xe_lrc_layout.h | 3 +++
> > >   drivers/gpu/drm/xe/xe_lrc.c             | 7 ++++++-
> > >   2 files changed, 9 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> > > index 4ab86fc369fd..e4c7c3549735 100644
> > > --- a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> > > +++ b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> > > @@ -43,4 +43,7 @@
> > >   #define INDIRECT_CTX_RING_START_UDW	(0x08 + 1)
> > >   #define INDIRECT_CTX_RING_CTL		(0x0a + 1)
> > > +#define CTX_INDIRECT_CTX_OFFSET_MASK	REG_GENMASK(15, 6)
> > > +#define CTX_INDIRECT_CTX_OFFSET_DEFAULT	REG_FIELD_PREP(CTX_INDIRECT_CTX_OFFSET_MASK, 0xd)
> > > +
> > >   #endif
> > > diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> > > index 35b4e8289b5f..923bc1ddc851 100644
> > > --- a/drivers/gpu/drm/xe/xe_lrc.c
> > > +++ b/drivers/gpu/drm/xe/xe_lrc.c
> > > @@ -1451,13 +1451,18 @@ setup_indirect_ctx(struct xe_lrc *lrc, struct xe_hw_engine *hwe)
> > >   	/*
> > >   	 * Enable INDIRECT_CTX leaving INDIRECT_CTX_OFFSET at its default: it
> > > -	 * varies per engine class, but the default is good enough
> > > +	 * varies per engine class, but the default is good enough, except on
> > > +	 * Alder Lake.
> > >   	 */
> > >   	xe_lrc_write_ctx_reg(lrc,
> > >   			     CTX_CS_INDIRECT_CTX,
> > >   			     (xe_bo_ggtt_addr(lrc->bo) + state.offset) |
> > >   			     /* Size in CLs. */
> > >   			     (state.written * sizeof(u32) / 64));
> > > +	if (GRAPHICS_VER(lrc_to_xe(lrc)) < 20)
> > > +		xe_lrc_write_ctx_reg(lrc,
> > > +				     CTX_CS_INDIRECT_CTX_OFFSET,
> > > +				     CTX_INDIRECT_CTX_OFFSET_DEFAULT);
> > >   	return 0;
> > >   }
> > > -- 
> > > 2.54.0
> > > 
> > 
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
