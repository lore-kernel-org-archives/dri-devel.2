Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 372A6CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 12:12:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8643A10EC65;
	Mon, 19 Oct 2026 12:12:44 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B483010EC65
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 12:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792411958; x=1823947958;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=kZySne3xXcY7ovJbzzyu6obOrnDFv2N9jT1b1farNlg=;
 b=JC/0CH+PXtxY4M4IB/xvn8PN7fAQ9IsAIwStD3sY+eNi0tif/hDt5wy3
 b/bKB2Xcj9dFclASlBDuOL/yriVA4QHoM/5r9azgY8jCqQsbBoOB44MVI
 11Dm4gxrLSxiO4dnGfc5oQpYGCsetC8PhknbtMgIHcc1VOpOUBZGOoI7k
 yWKCrl+4mpAr8UhAsj9Rk00SwuuYZHtcvquth4REcP8ZjwXlulXvbgdzB
 liHsyNJ/YaiX6SacgGDElsmym3GumKGDSrLQVrkKhMcbYjfIsWTUOooff
 L2p+KflbPmY9KF9tEfnCHLhYVpfctquJhV5MSHnz/hlYuzKVwhnDxCZcS w==;
X-CSE-ConnectionGUID: ed4yo3uNQ22ougegDixIvw==
X-CSE-MsgGUID: 9iWsa3AXS3ue9nprUS4HLw==
X-IronPort-AV: E=McAfee;i="6800,10657,11939"; a="972203"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="972203"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 05:12:38 -0700
X-CSE-ConnectionGUID: bV2/4uanSECHL1V0YO8wJA==
X-CSE-MsgGUID: 8w7crf60Qa28CNk9O09c7g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4279821"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa012.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 05:12:37 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 05:12:36 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Mon, 19 Oct 2026 05:12:36 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.69)
 by edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Mon, 19 Oct 2026 05:12:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mpR9jqMaR37nDDPanUFtajaurx+SgwJy60iboSj7dWaRSgwQiIGuqvVo2YuwlvMJTgfvEELy2PUs/N4lcams/3Ypd4RX2s2YvaZ8ktqtFmiW40izYQJhVefsFlqhCQxWlfB0Y+ViQqYyTi3z+cz17K+dnB5yOOJwOJdC7DcaAAwXyjq8hqxR5fA0H1waQm4cVbkRtttognnxsWrZGuUuh+v5jYJJIXzVyXrkjp7WJ/pG46pQIoYN91bLqBj+wSBt7rF37KFjOHaw9Mz03Kp0O+lDSdq9xwuY6xr1l/fOdatJQBxuU6G4/FIn6t66gqJObWHqBHT8qYnzukZyB7+Q3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BwBTAM24Nq9ORS/4w3SAuc4ivC9KoVJ2XYWxs5HVkYo=;
 b=P7if6P6599z8QlOp/R2RHo/tMNIAdN90GmVDhXSBM2mo12uTNpWdEaaVgXLOQVs4KZ6XFEZcqeILKXZQ9Ebvbv0vYDKnEADksLbdRvz+yb+FcnJyWWLGhtBMkLFnC/pN3RCDFvcPa+DVHe9OPH03ZVLhKZSOuVkp6AEL8OCVmbvzKWx2UA2n5jIeLQwHW4HXDLuj80rqQkeQqPL2OfvdJTBDlgYXj21W+giWLze9cZnq5IF8FIMOd+5ArBI26CXtOtIqwLmZPvRpXBxo7E99QnvSggePmNoRxM9ArxYIXb4wxgg3uPcFGPunCI2Hb2a+yIi7U812JrLfSlT+cAbs5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH3PR11MB7180.namprd11.prod.outlook.com (2603:10b6:610:148::5)
 by CO1PR11MB4961.namprd11.prod.outlook.com (2603:10b6:303:93::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Mon, 19 Oct
 2026 12:12:34 +0000
Received: from CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8]) by CH3PR11MB7180.namprd11.prod.outlook.com
 ([fe80::70dc:90b2:50b4:31a8%7]) with mapi id 15.21.0522.017; Mon, 19 Oct 2026
 12:12:34 +0000
Date: Mon, 19 Oct 2026 08:12:28 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Zack McKevitt <zachary.mckevitt@oss.qualcomm.com>,
 <dri-devel@lists.freedesktop.org>, <netdev@vger.kernel.org>,
 <riana.tauro@intel.com>, <aravind.iddamsetty@linux.intel.com>,
 <raag.jadav@intel.com>, <simona.vetter@ffwll.ch>, <airlied@gmail.com>,
 <ogabbay@kernel.org>, <lizhi.hou@amd.com>, <karol.wachowski@linux.intel.com>, 
 <jeff.hugo@oss.qualcomm.com>, <carl.vanderlip@oss.qualcomm.com>,
 <troy.hanson@oss.qualcomm.com>, <youssef.abdulrahman@oss.qualcomm.com>
Subject: Re: [PATCH 2/3] drm/drm_ras: Extend DRM RAS interface to include
 telemetry nodes
Message-ID: <atYJLGHqCelhzSee@intel.com>
References: <20261009173152.2436195-1-zachary.mckevitt@oss.qualcomm.com>
 <20261009173152.2436195-3-zachary.mckevitt@oss.qualcomm.com>
 <20261016180714.05fc93c5@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20261016180714.05fc93c5@kernel.org>
X-ClientProxiedBy: SJ0PR03CA0382.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1::27) To CH3PR11MB7180.namprd11.prod.outlook.com
 (2603:10b6:610:148::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR11MB7180:EE_|CO1PR11MB4961:EE_
X-MS-Office365-Filtering-Correlation-Id: f66e2c01-0673-4eeb-e7a7-08df2dda41ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|7416014|376014|366016|23010399003|56012099006|4143699003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: /SQ7AAa2jwjTkicQj1sQnbb/q42qN6P77QdnEcVKAHoXtu90k9miYRl0v/IwHKkG1gentDNL+dMfy2kbJUfcNpa2xkk3rqS41PsnTbaM0VW1CZhM5gR5U6xgoygAqdJNB7RXPYFc/p4JS/THF+QIlTY/C4Mnpd1hY6d4d5GCmElAqqn91TEwA5Uzdb/RnXzPk7GMNbrzlFqhU9cvPJaZ5lDIiD0t13uP2iQ2eSYSQ/pR+iQU5ForRibqA3yP7YOm2w4TbIWg3CC6TVZsCXQHUdt8wcYEgJHPmSQ2Mkgu3C8pmtOONZ+yh+N7GBu1ajNQOib1de2EzTtCMG0oiAmNcWForJ9ixxhEl+rJXDOoJM2/rZtbqDon0pSAsRQ9XxU5hVE2Lz+FcGj8hKwiBKT5gNZRtNJCpfTmbmWBLhnDJ+JJhNVgKev+vX9MGOz84iuFRsoKW0UvGzjdEnpVbH1MkikcIir+Omckengo5gSzGctxHKhlGDcynX6niWJtYxXj9YuSnfBUgaEShlORis/HNMsoGoaxa7yrbi6YP1kTR1PFXXx6pSj1b8iO5IhDBO/3sX4kzs1UPvjMPAtFrFB1mgFV1XMczVZ2+AzwWrjU+s0kvd9U3eQf6mhKHq9yaA3Dp2RY8+mI3ZBVdAAOcNBmTgv6RRGg+oZCpGGKT9L2Th0=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CH3PR11MB7180.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(7416014)(376014)(366016)(23010399003)(56012099006)(4143699003)(11063799006)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?m70zcmC2jkPLRFlurO27Qltz/I81/m9lHf+9WbC7D7kZklT1e1/82awi7Oj+?=
 =?us-ascii?Q?wAxNon/FIngiSw6YkWFIaxxC08M3PZoymW0+a+hSmA8MeEEj82ODQz7VdDSb?=
 =?us-ascii?Q?qdVzt6b0CI6cr0ViUrYhDNl7CIo7oFi8XRPZolXz1BkdRXwCNGeqLWPvRSBF?=
 =?us-ascii?Q?RJFML9lJ5o4hbj1MqSDnmH33u5yojBayFCHzuG4XppVTY6rOlIN0Rm0G5TrH?=
 =?us-ascii?Q?IpqPcpsWKkMPMrbAOtZpSZGVWvrjKrRJCPRhHBSOIV8sPCsyFLTVpYSEyglB?=
 =?us-ascii?Q?94vfEUAuSml9eZ9L4jwbGry2gYvx9yWZv439HybDsKNRrH/5DJVu8/Lb6Uu2?=
 =?us-ascii?Q?lcNX4q7u2aSuVB2RJGutB7rfr36nZf5oXivaAg//UdqiePn96j3x30y21qXL?=
 =?us-ascii?Q?CRTxKkznXFvjYu1Sj0BQLESAXjBDRglnIzoUukNpdV+6YxSnFCRedRU6NRzh?=
 =?us-ascii?Q?zGLh7peBg8mMCmrnFLKRJLDvF2sC8PWvJlOxr0dq8BD/gf2ZXWWbWUXiPDRq?=
 =?us-ascii?Q?FOhlpu+EeSVqbglU1IuCYtDuu7varGDjaIN9Ics3HtzkfaKbu4FGaUsvaoky?=
 =?us-ascii?Q?fIRuYlh+JiRevJcXm4pyTzN7DV3nBeyi0p4bdbUxBuYdfD3bAUOgekVTPd8U?=
 =?us-ascii?Q?HyLW0grjQARJc5kK/IEvTbLlYJJSFzeSVohurDiwhtt+qu1u5em070ufNoo3?=
 =?us-ascii?Q?0od6LzGDW7uBZOAVcR7gFTjAiNU3d5/tstZNbtHGdrPCrIrU2lcEALQP5F1I?=
 =?us-ascii?Q?6NoWsChjgZ2LMBpQaaWpNlZ0HEvNceMj3BdoUAQN1qmFQsfYdmLXq62NGNU+?=
 =?us-ascii?Q?RAALtjsiBc/3UfzE2Ex+t81HNcaFz6cIhXvAQWm6CB99R8MmxPeqb9KcN3Zi?=
 =?us-ascii?Q?jONjs92p7234GOGRQE1Mcy/0hKWwEXaXzSgiaqADbTpUV8XBKUfNNCP81uTm?=
 =?us-ascii?Q?Cnz8VHKrZh5cXwUE1UhfDAxHV+M5UtYmaalBMxzXUwuVGHElAZwALJGN+bFu?=
 =?us-ascii?Q?hJBjrZOqjeGUNHX27FCl4MCCiBGJAiwM2vrgPyTBbk7oUnXyanT8FuVeXouw?=
 =?us-ascii?Q?qs5m3tMkoCu02twnxmDWVyw9xz5ISnXU1nbKKikuRePqnpXOMG3zUvhzmHxt?=
 =?us-ascii?Q?avxgrWrXpqVirpKuXce3tvoRQB31A/w19jo61nayWKx/ATq8hihdlAdWq14a?=
 =?us-ascii?Q?rxd2bhafRlJ6tDzROMJ75VGWqnii8j0/s2LFcM0Vycg75pH/uVXBHy577/ye?=
 =?us-ascii?Q?XxyRFJevK2OMig1EHHfrMLfuiBim1pvLuRO2zKFw0n9A0+uO5hu/bpLEyeAt?=
 =?us-ascii?Q?UKqi0VZRVe9rqRGM1e6MtnjWIqCEqJ57unc+hUI4wYKZ0pEVY/puR9f0eADU?=
 =?us-ascii?Q?chRFv8THnpAN5NsycyMvjIZPitN0ED1mmuKaM0gmCRUtnmAoFEYzNbkwU2EB?=
 =?us-ascii?Q?nOoZN82kV8KyukRW9R+lWihkwRjqmx70yPHkUyfVvIcjFiW8rE5SaIRYVrGG?=
 =?us-ascii?Q?Sa2vNa1lxf4zSi7TV9ZtCwd4d2w32sKcBjlNDrWJdJ6HLRsLBEeUDPapZew9?=
 =?us-ascii?Q?tWLjIWM6KJgKFsI8kI27SUHNZp8zoqztgxoCaaduepHV50zkYx8/bn5lifp/?=
 =?us-ascii?Q?FzrUPXebb7PPt4AFMc7dhX/SE6TH/j+8/w6wLvNW42Ovn+H+++fvYERNWxXQ?=
 =?us-ascii?Q?MLNOoL6PTIn/qWIFHCDSwZZP8iDRLedFlftrVCSBDTK6FJkTfY5yngX+iAZ2?=
 =?us-ascii?Q?5po9+hr2mQ=3D=3D?=
X-Exchange-RoutingPolicyChecked: pAlCnh1hnaaOcKucPznKFAe7SGJd9TK6G3hoewawChSCSaozACcUIoTg+gL3G4ilNrFPbc9jbPz8uHJ+RPSLPvwFhyqYbyoANl9qvKPBiCR2JIX9f3d0r4gPgBdVaYR8III7Yo0ta6c+NpBYLKJMP7iE7dA4WARpDDmyiLqjbhUPxqR/I2Hn++PzFJ7gAhg7hgz8sJfqiR2FUyJaNaeKLEl7F5Gf9GGd7Tx34+yMxz4mpzpWVRGXXhAn7EUnu1AzwBFppCSQres/JUYjAPxpHl/5eeRKke5nZ7iiV5mKTOwwopUT0njJbbEbG6WkQ6KdJx5rkY4Do0w3bWq+TzECqw==
X-MS-Exchange-CrossTenant-Network-Message-Id: f66e2c01-0673-4eeb-e7a7-08df2dda41ba
X-MS-Exchange-CrossTenant-AuthSource: CH3PR11MB7180.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 12:12:34.0572 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nEvNeu+UF1c1v4+uZ7IfInSR0AWeu8HSSwogHyRfUtl12Qob322X64AyZf/YYP6i4lwzfa0ZnrpvZzxDQO67rQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB4961
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

On Fri, Oct 16, 2026 at 06:07:14PM -0700, Jakub Kicinski wrote:
> On Fri,  9 Oct 2026 10:31:51 -0700 Zack McKevitt wrote:
> > +        type: u64
> 
> prefer uint and then no pad

same here, u64 aligns with hardware definition why uint should be desired?
I noticed the review prompts, I fail to agree because we need predictability
and align with hardware definitions.
