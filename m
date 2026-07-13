Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB3C9C44501
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 20:24:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 23CEB10EAEC;
	Mon, 13 Jul 2026 20:24:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WoLUAjB4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BC47210E663;
 Mon, 13 Jul 2026 20:24:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783974282; x=1815510282;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=AyLKfgfAgCGpMuQ60gDsrHgBMc9lmZ5Mh/5NI7bJ2Z8=;
 b=WoLUAjB4DuKrJJZrrIkivh8CBmQk6cUiBI0y5y2uZ5gXdkDSdHdXGM83
 xe/xwpDTMENKOAh49iTBDUhIBVq1u3bssf5CRKpTUhq2nzCLNzhglRmBD
 dyd1GuSEI+NKrkFmqjNFm4IWLHm2AX6Gpejx95B1BUkf2ger0sw2SK//l
 SPFYltHIxRCEpgntZTD/gugHxdzzyRH9hGl7asceVOt3K7JieyIFsRhxB
 39DoPhqlMkt8shTz9/Ln5LWWn9ukQA2PGCq+08DrvW4+y6RBEfXHrtCeG
 nBz/qa6oKzda03zRy5UGX/9XHh3NnxYei34Mk2dpgDZTnzaVOjve6OOXV A==;
X-CSE-ConnectionGUID: WK1mQSJ/QdygAHOxtUZMxg==
X-CSE-MsgGUID: mfjNWJcPTd+bQipz2nkE5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="95193553"
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="95193553"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 13:24:41 -0700
X-CSE-ConnectionGUID: b+YbFxeWRYK7c9DLF4XJCw==
X-CSE-MsgGUID: JlePrX7CTc6b3ScSvdAjBg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,154,1779174000"; d="scan'208";a="253026730"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 13:24:41 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 13:24:40 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Mon, 13 Jul 2026 13:24:40 -0700
Received: from BN8PR05CU002.outbound.protection.outlook.com (52.101.57.4) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Mon, 13 Jul 2026 13:24:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n+deaCmcQ7/gfzRi1mh5TGBGdq6eq1O0pOgLgXYQFWODEpm679tZvExGW/p7WQd5oZPj30xqlrpT0jaFKOOX3Ky+gn9PkK/Uw5ZAFdlVVdeT1apTJ+vktMZNKGVgOibzWDZ4tIEMPy6jeIVheSoUGIy1NK2thvMi0p147xBLJXtprwUdDw7K1a+x5YmX2L8IeiC2odDrGWzaMCaYkSTr36ZGDME3wggjuPQdN5nHIKaimfhTGpzkLz6XZ2otGeF0TDIo04C/B2MPZ2qKJ+WAZq1QmDVc05fS1Mk8AWemV0mjVHQ08eCcbXFoE9HeUkmg9IGOFiNFu2IA9zsKwqZK0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zn2sxoxNRTU98UPRGhLY3qXC8i+sOcQrSnwi7QqnGVM=;
 b=LfLev7z0o2qJyMgbc6KGudJzftpD4rcX5NErVisi8v6X96SWnFMxMuVoyZCiCcX/67TRxbB9pTlnP1Uc0tI1iAJJ52Rs0qGN3PbV1+nYT75nVe7TIiqLAkIiP8Rejr8lIp+UUHMxBLbySjNa1LNLHZIBb+UOo55ADGgVaV+FQtECbZ3hm9z9IKbBt3G4E+E/TQu9XbrKPBNG3rzs0SvUqRrslCJGfL0NIARy+PlWcvVBbJe6K17SDWck7piFYou+bBhExOCcHPGLO2P9+LA7IU7TVKZzDrmhH3kWbRUkcsnYOiiC98PQeXRb3sRrx9T8k2+zjMQ/UIyOOxeT2BuXwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by SA1PR11MB9875.namprd11.prod.outlook.com (2603:10b6:806:4da::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 20:24:37 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0202.014; Mon, 13 Jul 2026
 20:24:37 +0000
Date: Mon, 13 Jul 2026 13:24:33 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <amd-gfx@lists.freedesktop.org>, Alex Deucher <alexander.deucher@amd.com>,
 Carlos Santa <carlos.santa@intel.com>, Ryan Neph <ryanneph@google.com>,
 "Huang Rui" <ray.huang@amd.com>, Matthew Auld <matthew.auld@intel.com>,
 "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 <linux-kernel@vger.kernel.org>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH v3 33/33] drm/amdgpu: Preallocate system BO pages outside
 the reservation lock
Message-ID: <alVJgfBepuNZhAmd@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-34-matthew.brost@intel.com>
 <13b16ffb-f9aa-4b83-a1cc-1b9ac8475c5f@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <13b16ffb-f9aa-4b83-a1cc-1b9ac8475c5f@amd.com>
X-ClientProxiedBy: MW4PR04CA0282.namprd04.prod.outlook.com
 (2603:10b6:303:89::17) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|SA1PR11MB9875:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f2f9281-0a54-4c79-c9c2-08dee11cc20b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|376014|7416014|366016|22082099003|4143699003|56012099006|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: BoWEk9Nye5EXpaYSqJ0VqdMJOGe60NlKw/p+c/hIdtWei2ZLc+s0Cctg3LeJ2cCDisMbxlrrAEXuTOzWGmR+T920ZhqJk8jeKkYOScjd1mmvj0SOoDpLC+POsqfILCL7vY2N0CPsryjcoY0SdqZNiTS4oo9PIpRfPugcvFNY617iXFqnjyauRC0yQnXRjN0kdp58OToK3VYokXK92I4C4Rj8Nfj7VrSttE8dmjbrgBc5NpsudNoc3IUV6Gr7QhbooWXBivfznjBabnrtfF2HS0Z7TFbAsioxf0sQwDtGgtonqCcuudekqs6fwd1RAjKSmnhpinLVI61S5280tYP9u+ZLWjE5+g+OpxbzxQYmJh967vxiwngS9kfeHvt6m46lPA+N4pA9emoSQa8qVLK1s0RZH7XCqefMRFND8gQbjdDIMVX8zRLAJfGVahm3CFUyUJLZkBrMCIKcP36TZfIm5dYsVElB2lHf3ej0fIvKYShBeSwl3VpGXVjbKWEdpvoL3tqJLMQAPCtIZO1UizOKQv/8+TJ3ucFKqY5s5hPSlH1fDpdbHOPdEq3/X3090wGWPBSMum7h4Bo68GILoWlOCdwPmHzL9Hn4zjW7at5HvwKad+Ro2UHPLHiTVAOZm6iUNQe1xOkp7UQ7d0ok/XSrQLNNuCKU787QWY5uIstjxhk=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(376014)(7416014)(366016)(22082099003)(4143699003)(56012099006)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?rqArtYnNky3LbjTCFz9RGS1CWRaarIlGmapLRutPlAzb9e7gBKugAcjPr1?=
 =?iso-8859-1?Q?BpbrP33a9AVo4gGBjTPjrS18lQp+UvOJ+nW0m74ldWmL6FOgbrzVg/faLI?=
 =?iso-8859-1?Q?i33eoM3PhP22Sxsth3PTZEMGYXTSzCFBYkIGGUBwwnVDlx1ErpZXdTvOwt?=
 =?iso-8859-1?Q?p7QftDa7Icjf8D8B3Hj3PNUaQr6VMj0Dvrc+lvyyN9pUZ9HpXAPn45vcSS?=
 =?iso-8859-1?Q?8Ja7JUeEr9uvjr2iR+9k4+HEFxYO3Sl7eu7Pb1RBMCQYIybjWLnamQcQJ5?=
 =?iso-8859-1?Q?vIjpliFEiWbPxZvM8s41+MitgWd0K5ltNMdxZwljviw8rzRhbOQ2YIg6+p?=
 =?iso-8859-1?Q?t7nRFDmyV0RVYGLi9YiuJtyrWpGm+Lbc4kTPqxU22HU87CNQkd3mzlwZIv?=
 =?iso-8859-1?Q?cpz426ERWNZckZZfcULY7Z82TssktPMyYl9u4VjjjMDdpUt39rCfXszyGU?=
 =?iso-8859-1?Q?7/GiS4oGpP8c+9UOiYcpdMC1twi/USQtvlSKuwRi3zTVCGV1xoHj5Jxadb?=
 =?iso-8859-1?Q?86WZfpBLSSKS56GYFsLZ3jX+ypsxTGIguJoXudMpqCnx64EXxAjkN7ZIDY?=
 =?iso-8859-1?Q?6/La+aOKi9xdhmmp+9wtnLd6NFNvh/DS4F/6WdccE5ZNZz8XhqEk3i2ZHm?=
 =?iso-8859-1?Q?mZYgfbvIdooZstEcKSydjbRUhufM4H3QFq0HGvxPRkw855vxP4ur1H8h2H?=
 =?iso-8859-1?Q?0FjjH+90rR/X5/bqh0DHcNmMm7tDxU+5rJ2PVMtqIwHX8KDHJfSN/mi9Y9?=
 =?iso-8859-1?Q?qOV8tfBssITKc5xjAwcRYk1UR8CIC4vciSA02NhtFEig7Ni0VnN6uYAeWS?=
 =?iso-8859-1?Q?Fbb7f0HsBmrTHZ1KiaDkhbSprHDcEGIT9NVsR3KE52wwopvp/DSgE5bH2l?=
 =?iso-8859-1?Q?FAe06bUnknodBXQIQesZlF6qvrKV5eKCzEcRzKE6gJSnZr17l0FmA+Uu9i?=
 =?iso-8859-1?Q?E206jtOC08vf64Xt54kMrkVSorqk56N729amIuRGKmQUrXJKBznWnjdPTM?=
 =?iso-8859-1?Q?qMBQTOUAqp+iyQP6o9fmZpnzlCQRnqTFcH8YioNfAz+4nPJaD2Pb9ge5tq?=
 =?iso-8859-1?Q?HUAv1/PvqjjevIEHzSu1AbCu3z/KjQc+90OSx3tHu7hrxMhMHpbD8r5XpV?=
 =?iso-8859-1?Q?mtbM4SKIIP8Jn75MyxQqBBotqlwMwbmPifUB2P48VAdOzvVqBhHu/3vZYq?=
 =?iso-8859-1?Q?S+Hrge5bZAI4lhNzB3YK0HYgyubEWHvp8/Z6EhGYEDPviJARcB0LiQbpU3?=
 =?iso-8859-1?Q?fJe/pi8PHvgWWrLq/xkut+wDPqdut/qjiXmC5ejz5h7mYFEsjP2VZD4Z+z?=
 =?iso-8859-1?Q?WnRMUKNM6FaDOOwgQNEKaiW7yNh6Fwsv2V5UUhkMcu/S54CUGSAev8bvQB?=
 =?iso-8859-1?Q?4LiT+xMYj1j70oWvqr1ABXul8IKA1TLwKZiP8hHHZN66vKpv98SVrk+7Eh?=
 =?iso-8859-1?Q?3E3FvI4GlYNsNCPHaIpNAX2108Y1AaayswqCt3o0oigCPAimix4NIHKXpN?=
 =?iso-8859-1?Q?oDDTTHZ71r9t+4BnqihCtpa46xW53aXgooLSfqHpktO+JOxWZ1Fky6i3D7?=
 =?iso-8859-1?Q?2hKb45Kmt0vwWEZ/zW3rJTubmdEnwezKd06+XQ5x80+47wZJcvvxd0qWf8?=
 =?iso-8859-1?Q?oCyVSWTbBqUHY8eAtJFErlBvPDZ07UXGMxjO2CnJ5ns+d63mv8yX1h/yAE?=
 =?iso-8859-1?Q?AV8E1kaYQST9QRQ1Lj+KSB0/SNw4trknOhzHxNPJ9Ui+Fy3aN48Dcp9wbR?=
 =?iso-8859-1?Q?1zUAKJHS4iZpfoGCdm3LAG7lPO12z6Sf6AaCOqz3rHReEZWU0GUm3JFzHK?=
 =?iso-8859-1?Q?iF3gMHz+gZFWnRFFuDZD197FTRLKsDk=3D?=
X-Exchange-RoutingPolicyChecked: It07kpZeDQpF4HYPDHt1FdZ0FZzzK/mUWKHJuxza534n2RuNY4/0S50L3izoU8uAXeGd6UiM8yfBOyAzwKxdSHyQ/qbz78c4t+uzpeIqTkwBpSi8HBmMtzRfDH21iqTlIaTDtyzjMEnCkRw5dDx1l6VLnsJkBMIzxJ856iyaIupXfWgrEahHYEm9JodRMQIBj+c7kxNlBLCiWQM9mZrtNVDmddeU9AUdSs4PAoG3yBpXphHt4N2CeP/Yh4cTOK7bmi4oTjtUQkXajBLa9q4A+vA/EKtFn9x7vklenQTXzDGuTTNPl8+u8Pux0kIPGb5HXV/GzufP6Bhm3YJysQGAWA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2f9281-0a54-4c79-c9c2-08dee11cc20b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 20:24:36.9228 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wOtMfjMxE02NLksACsyjeDrdzlFsBj3u9QHqORm92FI0l5pHndqKr8AryuhqW4YAnDtEJaQQpHqLKGVXD8UOHQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB9875
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

On Sat, Jul 11, 2026 at 12:46:40PM +0200, Christian König wrote:
> On 7/11/26 04:56, Matthew Brost wrote:
> > Populating a GTT (system) buffer object under the reservation lock can
> > stall in reclaim and compaction while trying to satisfy beneficial-order
> > allocations, holding the lock for the duration.
> 
> Yeah and that is perfectly intentional behavior.
> 
> I really don't see any reason for any driver to change that.
> 
> The purpose of the dma_resv lock is to stall other allocation for the same object it protects, making sure that we don't have multiple threads allocating memory for the same buffer object.
> 
> Why in the world should that be a problem?
> 

See my example in my reply to the cover letter: multiple threads
sharing a VM, with a memory allocation performed under the VM dma-resv
lock, which in turn blocks exec IOCTLs, CPU page faults or VM binds on
BOs sharing the same VM dma-resv lock. With that, this code could be
gating on whether the BO allocation shares a VM dma-resv lock.

The most relevant example here, I believe, is that launching a new
Chrome tab could potentially stall the aforementioned operations in a
different Chrome tab. Likewise, if games allocate memory on demand
(they typically do not, because memory allocations are prone to
introducing stalls), they could also incur the aforementioned stalls.

I think the opposite question is more appropriate here: does
preallocating memory outside of dma-resv before a device can DMA to it
break any invariants? The answer is no; it does not in the case of GEM
create IOCTLs or the defragmentation moves introduced in this series.

Matt

> Regards,
> Christian.
> 
> > 
> > Mirror the Xe out-of-lock preallocation for pure system BOs: when a
> > gem_create request targets AMDGPU_GEM_DOMAIN_GTT only, fill the full page
> > backing up front via ttm_pool_prealloc_fill_full() before taking the
> > reservation lock. The populate under the lock then simply installs these
> > pages instead of reclaiming and compacting in the critical section. The
> > fill is best-effort - a short fill falls back to the normal in-lock
> > allocation for the remaining pages, and any leftover pages are released
> > by ttm_pool_prealloc_fini() on all exit paths.
> > 
> > Unlike Xe, amdgpu has no background defragmenter, so the higher-order
> > reclaim backoff is left disabled (normal reclaim). If the pool uses
> > dma-alloc (swiotlb), the fill bails and the feature is a silent no-op.
> > 
> > Factor the tt pool selection into amdgpu_ttm_tt_pool_id() and
> > amdgpu_ttm_pool() so the preallocation targets the exact pool the
> > populate will consume, and thread an optional prealloc bag through
> > amdgpu_gem_object_create() and amdgpu_bo_param into the populate ctx.
> > 
> > Cc: amd-gfx@lists.freedesktop.org
> > Cc: Alex Deucher <alexander.deucher@amd.com>
> > Cc: Carlos Santa <carlos.santa@intel.com>
> > Cc: Ryan Neph <ryanneph@google.com>
> > Cc: Christian Koenig <christian.koenig@amd.com>
> > Cc: Huang Rui <ray.huang@amd.com>
> > Cc: Matthew Auld <matthew.auld@intel.com>
> > Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> > Cc: Maxime Ripard <mripard@kernel.org>
> > Cc: Thomas Zimmermann <tzimmermann@suse.de>
> > Cc: David Airlie <airlied@gmail.com>
> > Cc: Simona Vetter <simona@ffwll.ch>
> > Cc: dri-devel@lists.freedesktop.org
> > Cc: linux-kernel@vger.kernel.org
> > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > Assisted-by: GitHub_Copilot:claude-opus-4.8
> > Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> > 
> > ---
> > 
> > v3:
> >  - Keep WC caching only when USWC is supported and bound the
> >    preallocation to available GTT space (Sashiko)
> > ---
> >  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 73 +++++++++++++++++--
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |  5 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +-
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  4 +
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 39 +++++++---
> >  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +
> >  8 files changed, 108 insertions(+), 25 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > index 20831dbebc31..940f58848a97 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> > @@ -345,7 +345,7 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
> >  
> >  	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, 1,
> >  			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
> > -			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0);
> > +			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0, NULL);
> >  
> >  	amdgpu_bo_unreserve(mem->bo);
> >  
> > @@ -1811,7 +1811,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
> >  		 domain_string(alloc_domain), xcp_id);
> >  
> >  	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
> > -				       bo_type, NULL, &gobj, xcp_id + 1);
> > +				       bo_type, NULL, &gobj, xcp_id + 1, NULL);
> >  	if (ret) {
> >  		pr_debug("Failed to create BO on domain %s. ret %d\n",
> >  			 domain_string(alloc_domain), ret);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > index b33c300e26e2..51510e831129 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> > @@ -435,7 +435,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
> >  
> >  	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
> >  				       AMDGPU_GEM_DOMAIN_CPU, flags,
> > -				       ttm_bo_type_sg, resv, &gobj, 0);
> > +				       ttm_bo_type_sg, resv, &gobj, 0, NULL);
> >  	if (ret)
> >  		goto error;
> >  
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > index 6a0699746fbc..e8b732218e7d 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> > @@ -39,6 +39,7 @@
> >  #include <drm/drm_exec.h>
> >  #include <drm/drm_gem_ttm_helper.h>
> >  #include <drm/ttm/ttm_tt.h>
> > +#include <drm/ttm/ttm_pool.h>
> >  #include <drm/drm_syncobj.h>
> >  
> >  #include "amdgpu.h"
> > @@ -168,7 +169,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
> >  			     int alignment, u32 initial_domain,
> >  			     u64 flags, enum ttm_bo_type type,
> >  			     struct dma_resv *resv,
> > -			     struct drm_gem_object **obj, int8_t xcp_id_plus1)
> > +			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
> > +			     struct ttm_pool_prealloc *prealloc)
> >  {
> >  	struct amdgpu_bo *bo;
> >  	struct amdgpu_bo_user *ubo;
> > @@ -188,6 +190,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
> >  	bp.domain = initial_domain;
> >  	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> >  	bp.xcp_id_plus1 = xcp_id_plus1;
> > +	bp.prealloc = prealloc;
> >  
> >  	r = amdgpu_bo_create_user(adev, &bp, &ubo);
> >  	if (r)
> > @@ -412,6 +415,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >  	struct dma_resv *resv = NULL;
> >  	struct drm_gem_object *gobj;
> >  	uint32_t handle, initial_domain;
> > +	struct ttm_pool_prealloc prealloc = {};
> > +	struct ttm_pool *prealloc_pool = NULL;
> >  	int r;
> >  
> >  	/* reject invalid gem flags */
> > @@ -443,10 +448,57 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >  		flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> >  	}
> >  
> > +	/*
> > +	 * For system-only (pure GTT) BOs, preallocate the whole page backing
> > +	 * up front, outside the reservation lock. Populate under the lock then
> > +	 * just installs these pages instead of reclaiming/compacting in the
> > +	 * critical section. Best-effort: a short fill falls back to the normal
> > +	 * in-lock allocation for the missing pages.
> > +	 */
> > +	if (args->in.domains == AMDGPU_GEM_DOMAIN_GTT) {
> > +		struct ttm_resource_manager *gtt_man =
> > +			ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> > +		int32_t xcp_id = adev->gmc.mem_partitions ? fpriv->xcp_id : 0;
> > +		int32_t pool_id = amdgpu_ttm_tt_pool_id(adev, xcp_id);
> > +		/*
> > +		 * Mirror the USWC handling in amdgpu_bo_create(): the flag is
> > +		 * stripped when the platform can't do write-combining, in which
> > +		 * case the tt is created ttm_cached. The prealloc caching must
> > +		 * match the final tt caching exactly, otherwise ttm_pool_free()
> > +		 * would restore the wrong PAT state on these pages (PAT aliasing
> > +		 * / leak of WC pages into the cached allocator).
> > +		 */
> > +		bool uswc = (flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
> > +			amdgpu_bo_support_uswc(flags);
> > +		enum ttm_caching caching =
> > +			uswc ? ttm_write_combined : ttm_cached;
> > +
> > +		/*
> > +		 * Only prealloc when the request fits the currently-available
> > +		 * GTT (total manager size minus current usage). This mirrors the
> > +		 * amdgpu_bo_validate_size() bound applied later in
> > +		 * amdgpu_bo_create() while also skipping the up-front reclaim /
> > +		 * compaction when GTT is already near full or the user-controlled
> > +		 * size is over-large (the creation path handles those anyway).
> > +		 */
> > +		if (gtt_man) {
> > +			u64 used = ttm_resource_manager_usage(gtt_man);
> > +			u64 avail = gtt_man->size > used ?
> > +				gtt_man->size - used : 0;
> > +
> > +			if (size <= avail) {
> > +				prealloc_pool = amdgpu_ttm_pool(adev, pool_id);
> > +				ttm_pool_prealloc_fill_full(prealloc_pool,
> > +							    caching, &prealloc,
> > +							    PFN_UP(size), false);
> > +			}
> > +		}
> > +	}
> > +
> >  	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
> >  		r = amdgpu_bo_reserve(vm->root.bo, false);
> >  		if (r)
> > -			return r;
> > +			goto out_prealloc;
> >  
> >  		resv = vm->root.bo->tbo.base.resv;
> >  	}
> > @@ -455,7 +507,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >  retry:
> >  	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
> >  				     initial_domain,
> > -				     flags, ttm_bo_type_device, resv, &gobj, fpriv->xcp_id + 1);
> > +				     flags, ttm_bo_type_device, resv, &gobj,
> > +				     fpriv->xcp_id + 1, prealloc_pool ? &prealloc : NULL);
> >  	if (r && r != -ERESTARTSYS) {
> >  		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
> >  			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> > @@ -479,17 +532,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >  		amdgpu_bo_unreserve(vm->root.bo);
> >  	}
> >  	if (r)
> > -		return r;
> > +		goto out_prealloc;
> >  
> >  	r = drm_gem_handle_create(filp, gobj, &handle);
> >  	/* drop reference from allocate - handle holds it now */
> >  	drm_gem_object_put(gobj);
> >  	if (r)
> > -		return r;
> > +		goto out_prealloc;
> >  
> >  	memset(args, 0, sizeof(*args));
> >  	args->out.handle = handle;
> > -	return 0;
> > +
> > +out_prealloc:
> > +	if (prealloc_pool)
> > +		ttm_pool_prealloc_fini(prealloc_pool, &prealloc);
> > +	return r;
> >  }
> >  
> >  int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
> > @@ -528,7 +585,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
> >  
> >  	/* create a gem object to contain this object in */
> >  	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
> > -				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
> > +				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
> >  	if (r)
> >  		return r;
> >  
> > @@ -1298,7 +1355,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
> >  	domain = amdgpu_bo_get_preferred_domain(adev,
> >  				amdgpu_display_supported_domains(adev, flags));
> >  	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
> > -				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
> > +				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
> >  	if (r)
> >  		return -ENOMEM;
> >  
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> > index b558336bc4c6..706aeca011f1 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> > @@ -35,6 +35,8 @@
> >  
> >  extern const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
> >  
> > +struct ttm_pool_prealloc;
> > +
> >  unsigned long amdgpu_gem_timeout(uint64_t timeout_ns);
> >  
> >  /*
> > @@ -45,7 +47,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
> >  			     int alignment, u32 initial_domain,
> >  			     u64 flags, enum ttm_bo_type type,
> >  			     struct dma_resv *resv,
> > -			     struct drm_gem_object **obj, int8_t xcp_id_plus1);
> > +			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
> > +			     struct ttm_pool_prealloc *prealloc);
> >  int amdgpu_mode_dumb_create(struct drm_file *file_priv,
> >  			    struct drm_device *dev,
> >  			    struct drm_mode_create_dumb *args);
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > index f98bfba59a2c..18c4cf3f35a5 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> > @@ -632,7 +632,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
> >  		/* We opt to avoid OOM on system pages allocations */
> >  		.gfp_retry_mayfail = true,
> >  		.allow_res_evict = bp->type != ttm_bo_type_kernel,
> > -		.resv = bp->resv
> > +		.resv = bp->resv,
> > +		.prealloc = bp->prealloc,
> >  	};
> >  	struct amdgpu_bo *bo;
> >  	unsigned long page_align, size = bp->size;
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > index ff11a0903499..11f1d403f152 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> > @@ -45,6 +45,8 @@
> >  #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
> >  #define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
> >  
> > +struct ttm_pool_prealloc;
> > +
> >  struct amdgpu_bo_param {
> >  	unsigned long			size;
> >  	int				byte_align;
> > @@ -58,6 +60,8 @@ struct amdgpu_bo_param {
> >  	void				(*destroy)(struct ttm_buffer_object *bo);
> >  	/* xcp partition number plus 1, 0 means any partition */
> >  	int8_t				xcp_id_plus1;
> > +	/* optional out-of-lock preallocated backing (system/GTT only) */
> > +	struct ttm_pool_prealloc	*prealloc;
> >  };
> >  
> >  /* bo virtual addresses in a vm */
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > index b10b0878df37..c9cd4714f515 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> > @@ -1173,6 +1173,30 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
> >  	kfree(sgt);
> >  }
> >  
> > +/*
> > + * amdgpu_ttm_tt_pool_id - compute the ttm pool id backing a given xcp
> > + *
> > + * Mirrors the mapping used when creating the gtt ttm_tt, so callers that only
> > + * have an xcp id (e.g. an out-of-lock preallocation before the bo exists) pick
> > + * the same pool the populate will use.
> > + */
> > +int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id)
> > +{
> > +	if (adev->gmc.mem_partitions && xcp_id >= 0)
> > +		return KFD_XCP_MEM_ID(adev, xcp_id);
> > +
> > +	return xcp_id;
> > +}
> > +
> > +/* amdgpu_ttm_pool - select the ttm pool for a given pool id */
> > +struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id)
> > +{
> > +	if (adev->mman.ttm_pools && pool_id >= 0)
> > +		return &adev->mman.ttm_pools[pool_id];
> > +
> > +	return &adev->mman.bdev.pool;
> > +}
> > +
> >  /**
> >   * amdgpu_ttm_tt_create - Create a ttm_tt object for a given BO
> >   *
> > @@ -1194,10 +1218,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
> >  		return NULL;
> >  
> >  	gtt->gobj = &bo->base;
> > -	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
> > -		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
> > -	else
> > -		gtt->pool_id = abo->xcp_id;
> > +	gtt->pool_id = amdgpu_ttm_tt_pool_id(adev, abo->xcp_id);
> >  
> >  	if (abo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
> >  		caching = ttm_write_combined;
> > @@ -1239,10 +1260,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
> >  	if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL)
> >  		return 0;
> >  
> > -	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
> > -		pool = &adev->mman.ttm_pools[gtt->pool_id];
> > -	else
> > -		pool = &adev->mman.bdev.pool;
> > +	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
> >  	ret = ttm_pool_alloc(pool, ttm, ctx);
> >  	if (ret)
> >  		return ret;
> > @@ -1284,10 +1302,7 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
> >  
> >  	adev = amdgpu_ttm_adev(bdev);
> >  
> > -	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
> > -		pool = &adev->mman.ttm_pools[gtt->pool_id];
> > -	else
> > -		pool = &adev->mman.bdev.pool;
> > +	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
> >  
> >  	return ttm_pool_free(pool, ttm);
> >  }
> > diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > index ff9e2e346609..f90844937b73 100644
> > --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> > @@ -207,6 +207,9 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> >  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
> >  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
> >  
> > +int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id);
> > +struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id);
> > +
> >  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> >  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> >  				 struct amdgpu_hmm_range *range);
> 
