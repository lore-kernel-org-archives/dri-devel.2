Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03879C4450A
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 15:15:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6C16510E050;
	Tue, 14 Jul 2026 15:15:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="QAvNoFVa";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A210E10E050;
 Tue, 14 Jul 2026 15:15:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784042151; x=1815578151;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=5gq2JqqwRWDGyfhW4eM3NXDxIpyiCNHAyvXrU2wNRoM=;
 b=QAvNoFVaHoXZpyp/CfFqOWWmu3WEKsp3kWC3s/Hk1/QybwhmqhaqoA6G
 ulZ01HosCQPehkqtl3+3Aac4WTGtIWUlgTZ1led1y0eqFkm3eToLkJnup
 1V9EpAhBkP1eudhRtR0aCT4dOy97lmvE456ZZJoneivv7MSE2PxU1LKp0
 nxHtjC2hTN9EzNpe45LqY9Hv/9EjL6JwhwmB3OAOQ07aXDYRaWMIlRcJD
 08Hq+f5G6udx7AI8U43CNcRcR1VmenaEHJZR4WXnbcLnnUKS90CFtU055
 P+C2L4ZSCMZH0dgiKmQcnyuCGOWnaV/+yNOMOW8fYteSOFyEnT77KC5LS A==;
X-CSE-ConnectionGUID: am2sPBZKTAu/ulxsX+t9eA==
X-CSE-MsgGUID: P49NaPf0Q+GRh0M7+b38bw==
X-IronPort-AV: E=McAfee;i="6800,10657,11846"; a="95311986"
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="95311986"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 08:15:50 -0700
X-CSE-ConnectionGUID: PQvDKDCxRUurRVLr50yYZA==
X-CSE-MsgGUID: YOg7w4C/QOKc3l/BUvTY+w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,164,1779174000"; d="scan'208";a="251927650"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by fmviesa010.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jul 2026 08:15:50 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:15:49 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Tue, 14 Jul 2026 08:15:49 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.18) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Tue, 14 Jul 2026 08:15:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dNkYz55pw/8Swv2Arpf7W1XrnWXGBwtkw/JQNByjxaTvGpHpmgBZPTotkmbkfBNYnBuz1UZrNUS2UQO0ZXwM5OkXIk6F9izUCEJqkBXBd4YkXFFnDvzMhlkP8eOEdxp9WczQyP6bTh4oUE4k9+1AVRrAre7blhgx08R+PWa/DJgNqBbjI68+FBpFoOQVPUJhvDbMNFag6NclNBXCXRs9fGOg7xncR1uwrsevY+G0Nq2ywhdS9IpWhhCSDNCb43ogt3oDR83y39NPLjb1kzJt5rI7o5l6odERWbtapr54evJ4DdiY0Dlt82cCJd16kiezwYVsPqsiefeDO1st7/TYsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LoBFwA+1kDqGojuBeVV27ZytGjFCzOArHAu7pnHoxwQ=;
 b=jXJ6tetam/B51icPbSiaXNN5ZxwveXhazC+vuSJEcJIx4rJSpZ6E7bpFvexG1GjpBAsU7moQmifFI6Ea9tnD2xCa3fpw08okx+31xS6S/6vfJYl2O7ITiAIHasPjQSEHyTPahSoAl066NuOTqoelSdKgfQRO8wtvMYvG2GBSHFGBt1xcGuApLaQ3D+L2JfuLlMAI9JbJpjLkflGHmdVrmhi69vZ+1Hiap+Ohd4544iVEoy9KMSynWrCW+eFD+JSYrGqzLxUDniGUGe95qtBuYAWisU2jMQMgaKubjoxeR42B98soCyOCplfnEib80UmDc+PHUY676iqXECan6VrfmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by MN2PR11MB4725.namprd11.prod.outlook.com (2603:10b6:208:263::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.19; Tue, 14 Jul
 2026 15:15:45 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0223.008; Tue, 14 Jul 2026
 15:15:45 +0000
Date: Tue, 14 Jul 2026 08:15:42 -0700
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
Message-ID: <alZSnjM53f9dfjSR@gsse-cloud1.jf.intel.com>
References: <20260711025619.2540575-1-matthew.brost@intel.com>
 <20260711025619.2540575-34-matthew.brost@intel.com>
 <13b16ffb-f9aa-4b83-a1cc-1b9ac8475c5f@amd.com>
 <alVJgfBepuNZhAmd@gsse-cloud1.jf.intel.com>
 <357a21c0-7181-474f-bb97-c795d9456238@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <357a21c0-7181-474f-bb97-c795d9456238@amd.com>
X-ClientProxiedBy: MW4PR04CA0281.namprd04.prod.outlook.com
 (2603:10b6:303:89::16) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|MN2PR11MB4725:EE_
X-MS-Office365-Filtering-Correlation-Id: 99663a49-d9ba-4cd5-66d2-08dee1bac71b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|1800799024|376014|7416014|56012099006|11063799006|4143699003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: wlj1pL7IwX4S7pUHefdwPiCt8IThXZDHu3AWHgF3/qE1hxGbJpEQnB1k4Lo/XlPZ84gopPyXj42quIYb7H1SBu3vX1/sdQteme9QjUPm9FoW5Hma7k+K1riFN7iegeyAAcu4hIzcPCjqB7QBFz3rFhBrpuj9rPV+dxS3kfi02qL18C7wIcw64U2dnIxQqJ6maW6UOkK9QYkebU9lt7n1+2xV//I2Zw1U8jJJ8KT1yys4naaLAn0uQFFgErB0sD7d5sJzTt9258PdQdbnhZbtPA1bj74nKPOMfJ5X9TgrMwN+lW8gyXK8KXSJOebL7Yok60khh6mxT4dsHAVaY7rqcYI9R49JhmKfp7qdNwKWiktglVLgTbGTEo27jiz42q6MBSdXioYzoUl0dWH2RfZ4/4O8BIGRdT1OqbH4E8u7iYAajk5bc8XbFzSyiNbKXvRElWWJujcceo2jlvSL1+JMYMYRsmX58W5WI419PvzWCQ8bMUvJwi1F8AyKnvOBN0MWxpdhZrabvp4CrkbcLTSmM8/qNBV7zK/A6KQG/60nD/emnF2x4QOvQOkOGG8uNSGpUzTeOfNc457Xx/bu6e2rHhwy2GH5jwbkFQnBJV4hBWWVPB7fCeNPYuSxq/86iwtCzZmgUHeVXblHaG/T+JILKm5xP+mZYlzD3ie4LA3LJq8=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(56012099006)(11063799006)(4143699003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?BiCZdveK+q9MAC0urc0te0+Ly3g+Zvts4PUAHA9/wtdf258cuJEZe0A1c2?=
 =?iso-8859-1?Q?m2KqDBthNXaxqSrJdWS6xKHFS9C5rcbjRFeOWgvLw+4bQmkorPUEyoHsa+?=
 =?iso-8859-1?Q?ATm3nAEpnzjDXxe54bBqwKcUh3A8kHzRAnrLAOluGylGGXlOw/DRkgENR1?=
 =?iso-8859-1?Q?9gA9abC+xbocCPUUW27lipY9CSLRFG9RbInasrWPcLJZJcvYXmSXRMEaTK?=
 =?iso-8859-1?Q?hRMTs0fRn3CCVsDzQM22bzNsMi57rhoAPW70LZizLHLNhvGJCMwzRr1zHk?=
 =?iso-8859-1?Q?a3ouHpfCXtZptSD/cL0PUpbpLRhRQzcfH1YVIosXmhBIBpsA94DprDEDld?=
 =?iso-8859-1?Q?9ugobWq+td/Xgh9FP2SQ3QppY7zpq78AF1jZUx+UiRfjWuase7Lq6m58ZZ?=
 =?iso-8859-1?Q?TJfA8WP1pq+01stydE2hr0an2uWQE/mnOOZsnHa9eM2JtUaiSbVuW+A2vB?=
 =?iso-8859-1?Q?Yv8wX7m6ANFl2ORGrEKawZFHcsRl1UBwBAHSHhrYrYHuTb2e9ejyxzz5zp?=
 =?iso-8859-1?Q?IbevsSYuixoajPRH80Qouvsh969xrgXFqya1JYWrQHX2EtI4D8xNNxLy3y?=
 =?iso-8859-1?Q?gpapvCXF0c5UzI/rl4S4bBgR9UpMuzthxX3oRetdt55UQa9zrlIb0ExGXK?=
 =?iso-8859-1?Q?289QPyMCH2v+Mojg/HXbAVI0TFedUCn2/R9VaVhO6FIcdbC8/hH/7qQN5w?=
 =?iso-8859-1?Q?qpw4B4ecovHRRSNYRduomHu5L1mY91Oyet09tYeZxJWMkpdQkhCNWvj0T3?=
 =?iso-8859-1?Q?DOe2nyW4gthmLwu7zY1aHfMIIAJqoVFS7EWKOX4ncTem7CfiklgiYSE5Gf?=
 =?iso-8859-1?Q?uaLpA2ytZGRQF774TEqktMW00vYLkIwSVLSPp5UcRgaLn9jjzLfT1JZvGH?=
 =?iso-8859-1?Q?vXG/T2Ygw3NkiTYpuwKnRzH3/KZBioh+1IT6ALtSJoxrrLQgPiilUD4yZw?=
 =?iso-8859-1?Q?JGedL34WjjbOYdaLs5cC9sq75G3JqqAoXBeThBJfa6GTW2hgShRCbvCquj?=
 =?iso-8859-1?Q?uPJ415K0blehqe/KeR4eX7XZaPdn5fL2KPMTUCmHUg3o8o84JmYMXZVnzI?=
 =?iso-8859-1?Q?YMn64eTS5ruEym/ti64TggyTRWsKAClakBLUGdAFFcp5azWa+52F9k4f78?=
 =?iso-8859-1?Q?FiUlct5cXBk++LBE/WFh36KidFmMY4+n6vt5f2Z5bewqgkl9qeFIdlMLbH?=
 =?iso-8859-1?Q?u5v+SJVtkrRFR8Kg+U6pXx0+sdQMXeC/vTtvebo4C3gxobgqksqsO7IsVC?=
 =?iso-8859-1?Q?bjsJ7QY1Rrx2yPMytsPm5m3BVXOl/oKwtMCJojMwhZafbqXqZovqRcwArl?=
 =?iso-8859-1?Q?YtHrgNdTdQDtos7AZn4Pyw93LMMpDaHqKatxi90j7k0dPyjuReUoa4++Rq?=
 =?iso-8859-1?Q?H7mN/AaHVO5hp3SXUdCVcv4Wx8fOYi3Zz+UNqX1oEZURpKvWs+LdBFh8N7?=
 =?iso-8859-1?Q?0A1ncehx/XYqu/trfwcMoCsBGtsYB+aEjNYRsX7fXcCxiNRVxh1RIgAPgz?=
 =?iso-8859-1?Q?NdFzph8ksFPhf/LnXECoUdAVGXP9Sn1YGDePh5t8pKCYP8oy/X4FrwStcg?=
 =?iso-8859-1?Q?fsKc7PEZy01+cHf7nQs4nCUgB4UlI3qpwcUX/r1IQ6Gys8DjTEUzxB8+gp?=
 =?iso-8859-1?Q?/r+TXlMlwIAfumZtOJg5yi/VqQwDnO/2jgMIeUygqFuhJtMy8rF+PXQpYZ?=
 =?iso-8859-1?Q?ykM1KWQIj865w7WJ3agfLDuBqeMqpWi0uWOJIxE1XQfRvhuZFKIAve1tlJ?=
 =?iso-8859-1?Q?plVrOIt4+Mj22q4mfv7poM2TzwuibSglG/vl3ny2SEesvb6ijBekQ1upUQ?=
 =?iso-8859-1?Q?U2088FQAX0oyNY0vJZYhavBewhIQ2HU=3D?=
X-Exchange-RoutingPolicyChecked: Jt2SpUpF4HYvFgt8iCKJSqA6x3bZ0hjOWtuFVD7s70N51AqKOtz8rFAtBmtLze4FfOyoI4pg4Y1O1QEfiav53+m3ZcfNCfc/HdW32Ld9A6f5FjNcLuyK/BMfV19T11L7o2RjCLZ9TZGMBeDjL/KlxTAUBHbHat+/zOPakKpZjsOZIlUWOi6m+OjVk8z5kGT3xnHZMXkBPxnCLKOAzvBIvckWHUQ4uQx18ZAR0DwMlwFmHZOe19wnDBP7AiEeHnvfyN3xBPBjg6sCqPmDnS6W3RiDslYX7nQ1fiZgm2f8SdEKaW/u+Qi8A9TYeT1548wrId4h1jee0Q4YHCgRXMGkYQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 99663a49-d9ba-4cd5-66d2-08dee1bac71b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2026 15:15:45.5713 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5ebKn79HSpBHlDO8icUvu2pbxWNFOzbbBKHEH3Fx/m5GON3EnkLN3RTYm9xHipXiGrVMa2nuD6+voVRlmRqgZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4725
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

On Tue, Jul 14, 2026 at 11:17:32AM +0200, Christian König wrote:
> On 7/13/26 22:24, Matthew Brost wrote:
> > On Sat, Jul 11, 2026 at 12:46:40PM +0200, Christian König wrote:
> >> On 7/11/26 04:56, Matthew Brost wrote:
> >>> Populating a GTT (system) buffer object under the reservation lock can
> >>> stall in reclaim and compaction while trying to satisfy beneficial-order
> >>> allocations, holding the lock for the duration.
> >>
> >> Yeah and that is perfectly intentional behavior.
> >>
> >> I really don't see any reason for any driver to change that.
> >>
> >> The purpose of the dma_resv lock is to stall other allocation for the same object it protects, making sure that we don't have multiple threads allocating memory for the same buffer object.
> >>
> >> Why in the world should that be a problem?
> >>
> > 
> > See my example in my reply to the cover letter: multiple threads
> > sharing a VM, with a memory allocation performed under the VM dma-resv
> > lock, which in turn blocks exec IOCTLs, CPU page faults or VM binds on
> > BOs sharing the same VM dma-resv lock. With that, this code could be
> > gating on whether the BO allocation shares a VM dma-resv lock.
> 
> Ah, ok I see the problem now.
> 
> > The most relevant example here, I believe, is that launching a new
> > Chrome tab could potentially stall the aforementioned operations in a
> > different Chrome tab. Likewise, if games allocate memory on demand
> > (they typically do not, because memory allocations are prone to
> > introducing stalls), they could also incur the aforementioned stalls.
> 
> Yeah, I was already wondering how such an use case is seen with gaming or HPC.
> 
> But Chrome is indeed the right stress test for memory allocation :)
> 
> > I think the opposite question is more appropriate here: does
> > preallocating memory outside of dma-resv before a device can DMA to it
> > break any invariants? The answer is no; it does not in the case of GEM
> > create IOCTLs or the defragmentation moves introduced in this series.
> 
> Of hand it looks like a valid approach to me, but it is still quite hacky.
> 
> I would rather suggest something like that:
> 
> 1. Allocate a BO #1 with a separate dma_resv lock.
> 2. Populate that BO with the backing store you want to have.
> 3. Allocate a BO #2 with the dma_resv lock of the VM, but no backing store whatsoever.
> 4. Lock both BO #1 and #2.
> 5. Use a new function ttm_bo_swap_backing_stores() to switch the backing store between the two.
> 6. Unlock everything and drop the reference on BO #1 to let it cleanup.
> 
> This way the memory/resources are always allocated to some resource and buffer object which makes it possible to track it.
> 
> Tracking the allocated memory is necessary for hot plug and eventually shrinking it.

Thanks. Let me see what the rework looks like and whether I run into any
issues.

I did have a concern about the pre-allocation not being attached to any
reservation, and therefore not being available for shrinking during the
pre-allocation <-> reservation attachment window as well. Of course, the
defrag step gets trickier here since it is not a 1:1 transfer (it's a
subset plus a copy), but it is likely workable too.

Also, there's the corner case where BO #1 is immediately shrunk, though
perhaps that doesn't matter and the next execution fixes it up at that
point.

I'll reply here once I have a better understanding of the corner cases
and whether this approach fits both goals: defragmentation and
minimizing shared VM dma-resv lock hold time.

Matt

> 
> Regards,
> Christian.
> 
> > 
> > Matt
> > 
> >> Regards,
> >> Christian.
> >>
> >>>
> >>> Mirror the Xe out-of-lock preallocation for pure system BOs: when a
> >>> gem_create request targets AMDGPU_GEM_DOMAIN_GTT only, fill the full page
> >>> backing up front via ttm_pool_prealloc_fill_full() before taking the
> >>> reservation lock. The populate under the lock then simply installs these
> >>> pages instead of reclaiming and compacting in the critical section. The
> >>> fill is best-effort - a short fill falls back to the normal in-lock
> >>> allocation for the remaining pages, and any leftover pages are released
> >>> by ttm_pool_prealloc_fini() on all exit paths.
> >>>
> >>> Unlike Xe, amdgpu has no background defragmenter, so the higher-order
> >>> reclaim backoff is left disabled (normal reclaim). If the pool uses
> >>> dma-alloc (swiotlb), the fill bails and the feature is a silent no-op.
> >>>
> >>> Factor the tt pool selection into amdgpu_ttm_tt_pool_id() and
> >>> amdgpu_ttm_pool() so the preallocation targets the exact pool the
> >>> populate will consume, and thread an optional prealloc bag through
> >>> amdgpu_gem_object_create() and amdgpu_bo_param into the populate ctx.
> >>>
> >>> Cc: amd-gfx@lists.freedesktop.org
> >>> Cc: Alex Deucher <alexander.deucher@amd.com>
> >>> Cc: Carlos Santa <carlos.santa@intel.com>
> >>> Cc: Ryan Neph <ryanneph@google.com>
> >>> Cc: Christian Koenig <christian.koenig@amd.com>
> >>> Cc: Huang Rui <ray.huang@amd.com>
> >>> Cc: Matthew Auld <matthew.auld@intel.com>
> >>> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> >>> Cc: Maxime Ripard <mripard@kernel.org>
> >>> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> >>> Cc: David Airlie <airlied@gmail.com>
> >>> Cc: Simona Vetter <simona@ffwll.ch>
> >>> Cc: dri-devel@lists.freedesktop.org
> >>> Cc: linux-kernel@vger.kernel.org
> >>> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> >>> Assisted-by: GitHub_Copilot:claude-opus-4.8
> >>> Signed-off-by: Matthew Brost <matthew.brost@intel.com>
> >>>
> >>> ---
> >>>
> >>> v3:
> >>>  - Keep WC caching only when USWC is supported and bound the
> >>>    preallocation to available GTT space (Sashiko)
> >>> ---
> >>>  .../gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c  |  4 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c   |  2 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c       | 73 +++++++++++++++++--
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h       |  5 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.c    |  3 +-
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_object.h    |  4 +
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c       | 39 +++++++---
> >>>  drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h       |  3 +
> >>>  8 files changed, 108 insertions(+), 25 deletions(-)
> >>>
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>> index 20831dbebc31..940f58848a97 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
> >>> @@ -345,7 +345,7 @@ create_dmamap_sg_bo(struct amdgpu_device *adev,
> >>>  
> >>>  	ret = amdgpu_gem_object_create(adev, mem->bo->tbo.base.size, 1,
> >>>  			AMDGPU_GEM_DOMAIN_CPU, AMDGPU_GEM_CREATE_PREEMPTIBLE | flags,
> >>> -			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0);
> >>> +			ttm_bo_type_sg, mem->bo->tbo.base.resv, &gem_obj, 0, NULL);
> >>>  
> >>>  	amdgpu_bo_unreserve(mem->bo);
> >>>  
> >>> @@ -1811,7 +1811,7 @@ int amdgpu_amdkfd_gpuvm_alloc_memory_of_gpu(
> >>>  		 domain_string(alloc_domain), xcp_id);
> >>>  
> >>>  	ret = amdgpu_gem_object_create(adev, aligned_size, 1, alloc_domain, alloc_flags,
> >>> -				       bo_type, NULL, &gobj, xcp_id + 1);
> >>> +				       bo_type, NULL, &gobj, xcp_id + 1, NULL);
> >>>  	if (ret) {
> >>>  		pr_debug("Failed to create BO on domain %s. ret %d\n",
> >>>  			 domain_string(alloc_domain), ret);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >>> index b33c300e26e2..51510e831129 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dma_buf.c
> >>> @@ -435,7 +435,7 @@ amdgpu_dma_buf_create_obj(struct drm_device *dev, struct dma_buf *dma_buf)
> >>>  
> >>>  	ret = amdgpu_gem_object_create(adev, dma_buf->size, PAGE_SIZE,
> >>>  				       AMDGPU_GEM_DOMAIN_CPU, flags,
> >>> -				       ttm_bo_type_sg, resv, &gobj, 0);
> >>> +				       ttm_bo_type_sg, resv, &gobj, 0, NULL);
> >>>  	if (ret)
> >>>  		goto error;
> >>>  
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> index 6a0699746fbc..e8b732218e7d 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.c
> >>> @@ -39,6 +39,7 @@
> >>>  #include <drm/drm_exec.h>
> >>>  #include <drm/drm_gem_ttm_helper.h>
> >>>  #include <drm/ttm/ttm_tt.h>
> >>> +#include <drm/ttm/ttm_pool.h>
> >>>  #include <drm/drm_syncobj.h>
> >>>  
> >>>  #include "amdgpu.h"
> >>> @@ -168,7 +169,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
> >>>  			     int alignment, u32 initial_domain,
> >>>  			     u64 flags, enum ttm_bo_type type,
> >>>  			     struct dma_resv *resv,
> >>> -			     struct drm_gem_object **obj, int8_t xcp_id_plus1)
> >>> +			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
> >>> +			     struct ttm_pool_prealloc *prealloc)
> >>>  {
> >>>  	struct amdgpu_bo *bo;
> >>>  	struct amdgpu_bo_user *ubo;
> >>> @@ -188,6 +190,7 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
> >>>  	bp.domain = initial_domain;
> >>>  	bp.bo_ptr_size = sizeof(struct amdgpu_bo);
> >>>  	bp.xcp_id_plus1 = xcp_id_plus1;
> >>> +	bp.prealloc = prealloc;
> >>>  
> >>>  	r = amdgpu_bo_create_user(adev, &bp, &ubo);
> >>>  	if (r)
> >>> @@ -412,6 +415,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >>>  	struct dma_resv *resv = NULL;
> >>>  	struct drm_gem_object *gobj;
> >>>  	uint32_t handle, initial_domain;
> >>> +	struct ttm_pool_prealloc prealloc = {};
> >>> +	struct ttm_pool *prealloc_pool = NULL;
> >>>  	int r;
> >>>  
> >>>  	/* reject invalid gem flags */
> >>> @@ -443,10 +448,57 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >>>  		flags |= AMDGPU_GEM_CREATE_NO_CPU_ACCESS;
> >>>  	}
> >>>  
> >>> +	/*
> >>> +	 * For system-only (pure GTT) BOs, preallocate the whole page backing
> >>> +	 * up front, outside the reservation lock. Populate under the lock then
> >>> +	 * just installs these pages instead of reclaiming/compacting in the
> >>> +	 * critical section. Best-effort: a short fill falls back to the normal
> >>> +	 * in-lock allocation for the missing pages.
> >>> +	 */
> >>> +	if (args->in.domains == AMDGPU_GEM_DOMAIN_GTT) {
> >>> +		struct ttm_resource_manager *gtt_man =
> >>> +			ttm_manager_type(&adev->mman.bdev, TTM_PL_TT);
> >>> +		int32_t xcp_id = adev->gmc.mem_partitions ? fpriv->xcp_id : 0;
> >>> +		int32_t pool_id = amdgpu_ttm_tt_pool_id(adev, xcp_id);
> >>> +		/*
> >>> +		 * Mirror the USWC handling in amdgpu_bo_create(): the flag is
> >>> +		 * stripped when the platform can't do write-combining, in which
> >>> +		 * case the tt is created ttm_cached. The prealloc caching must
> >>> +		 * match the final tt caching exactly, otherwise ttm_pool_free()
> >>> +		 * would restore the wrong PAT state on these pages (PAT aliasing
> >>> +		 * / leak of WC pages into the cached allocator).
> >>> +		 */
> >>> +		bool uswc = (flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC) &&
> >>> +			amdgpu_bo_support_uswc(flags);
> >>> +		enum ttm_caching caching =
> >>> +			uswc ? ttm_write_combined : ttm_cached;
> >>> +
> >>> +		/*
> >>> +		 * Only prealloc when the request fits the currently-available
> >>> +		 * GTT (total manager size minus current usage). This mirrors the
> >>> +		 * amdgpu_bo_validate_size() bound applied later in
> >>> +		 * amdgpu_bo_create() while also skipping the up-front reclaim /
> >>> +		 * compaction when GTT is already near full or the user-controlled
> >>> +		 * size is over-large (the creation path handles those anyway).
> >>> +		 */
> >>> +		if (gtt_man) {
> >>> +			u64 used = ttm_resource_manager_usage(gtt_man);
> >>> +			u64 avail = gtt_man->size > used ?
> >>> +				gtt_man->size - used : 0;
> >>> +
> >>> +			if (size <= avail) {
> >>> +				prealloc_pool = amdgpu_ttm_pool(adev, pool_id);
> >>> +				ttm_pool_prealloc_fill_full(prealloc_pool,
> >>> +							    caching, &prealloc,
> >>> +							    PFN_UP(size), false);
> >>> +			}
> >>> +		}
> >>> +	}
> >>> +
> >>>  	if (flags & AMDGPU_GEM_CREATE_VM_ALWAYS_VALID) {
> >>>  		r = amdgpu_bo_reserve(vm->root.bo, false);
> >>>  		if (r)
> >>> -			return r;
> >>> +			goto out_prealloc;
> >>>  
> >>>  		resv = vm->root.bo->tbo.base.resv;
> >>>  	}
> >>> @@ -455,7 +507,8 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >>>  retry:
> >>>  	r = amdgpu_gem_object_create(adev, size, args->in.alignment,
> >>>  				     initial_domain,
> >>> -				     flags, ttm_bo_type_device, resv, &gobj, fpriv->xcp_id + 1);
> >>> +				     flags, ttm_bo_type_device, resv, &gobj,
> >>> +				     fpriv->xcp_id + 1, prealloc_pool ? &prealloc : NULL);
> >>>  	if (r && r != -ERESTARTSYS) {
> >>>  		if (flags & AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED) {
> >>>  			flags &= ~AMDGPU_GEM_CREATE_CPU_ACCESS_REQUIRED;
> >>> @@ -479,17 +532,21 @@ int amdgpu_gem_create_ioctl(struct drm_device *dev, void *data,
> >>>  		amdgpu_bo_unreserve(vm->root.bo);
> >>>  	}
> >>>  	if (r)
> >>> -		return r;
> >>> +		goto out_prealloc;
> >>>  
> >>>  	r = drm_gem_handle_create(filp, gobj, &handle);
> >>>  	/* drop reference from allocate - handle holds it now */
> >>>  	drm_gem_object_put(gobj);
> >>>  	if (r)
> >>> -		return r;
> >>> +		goto out_prealloc;
> >>>  
> >>>  	memset(args, 0, sizeof(*args));
> >>>  	args->out.handle = handle;
> >>> -	return 0;
> >>> +
> >>> +out_prealloc:
> >>> +	if (prealloc_pool)
> >>> +		ttm_pool_prealloc_fini(prealloc_pool, &prealloc);
> >>> +	return r;
> >>>  }
> >>>  
> >>>  int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
> >>> @@ -528,7 +585,7 @@ int amdgpu_gem_userptr_ioctl(struct drm_device *dev, void *data,
> >>>  
> >>>  	/* create a gem object to contain this object in */
> >>>  	r = amdgpu_gem_object_create(adev, args->size, 0, AMDGPU_GEM_DOMAIN_CPU,
> >>> -				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
> >>> +				     0, ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
> >>>  	if (r)
> >>>  		return r;
> >>>  
> >>> @@ -1298,7 +1355,7 @@ int amdgpu_mode_dumb_create(struct drm_file *file_priv,
> >>>  	domain = amdgpu_bo_get_preferred_domain(adev,
> >>>  				amdgpu_display_supported_domains(adev, flags));
> >>>  	r = amdgpu_gem_object_create(adev, args->size, 0, domain, flags,
> >>> -				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1);
> >>> +				     ttm_bo_type_device, NULL, &gobj, fpriv->xcp_id + 1, NULL);
> >>>  	if (r)
> >>>  		return -ENOMEM;
> >>>  
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> >>> index b558336bc4c6..706aeca011f1 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gem.h
> >>> @@ -35,6 +35,8 @@
> >>>  
> >>>  extern const struct drm_gem_object_funcs amdgpu_gem_object_funcs;
> >>>  
> >>> +struct ttm_pool_prealloc;
> >>> +
> >>>  unsigned long amdgpu_gem_timeout(uint64_t timeout_ns);
> >>>  
> >>>  /*
> >>> @@ -45,7 +47,8 @@ int amdgpu_gem_object_create(struct amdgpu_device *adev, unsigned long size,
> >>>  			     int alignment, u32 initial_domain,
> >>>  			     u64 flags, enum ttm_bo_type type,
> >>>  			     struct dma_resv *resv,
> >>> -			     struct drm_gem_object **obj, int8_t xcp_id_plus1);
> >>> +			     struct drm_gem_object **obj, int8_t xcp_id_plus1,
> >>> +			     struct ttm_pool_prealloc *prealloc);
> >>>  int amdgpu_mode_dumb_create(struct drm_file *file_priv,
> >>>  			    struct drm_device *dev,
> >>>  			    struct drm_mode_create_dumb *args);
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>> index f98bfba59a2c..18c4cf3f35a5 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.c
> >>> @@ -632,7 +632,8 @@ int amdgpu_bo_create(struct amdgpu_device *adev,
> >>>  		/* We opt to avoid OOM on system pages allocations */
> >>>  		.gfp_retry_mayfail = true,
> >>>  		.allow_res_evict = bp->type != ttm_bo_type_kernel,
> >>> -		.resv = bp->resv
> >>> +		.resv = bp->resv,
> >>> +		.prealloc = bp->prealloc,
> >>>  	};
> >>>  	struct amdgpu_bo *bo;
> >>>  	unsigned long page_align, size = bp->size;
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >>> index ff11a0903499..11f1d403f152 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_object.h
> >>> @@ -45,6 +45,8 @@
> >>>  #define to_amdgpu_bo_user(abo) container_of((abo), struct amdgpu_bo_user, bo)
> >>>  #define to_amdgpu_bo_vm(abo) container_of((abo), struct amdgpu_bo_vm, bo)
> >>>  
> >>> +struct ttm_pool_prealloc;
> >>> +
> >>>  struct amdgpu_bo_param {
> >>>  	unsigned long			size;
> >>>  	int				byte_align;
> >>> @@ -58,6 +60,8 @@ struct amdgpu_bo_param {
> >>>  	void				(*destroy)(struct ttm_buffer_object *bo);
> >>>  	/* xcp partition number plus 1, 0 means any partition */
> >>>  	int8_t				xcp_id_plus1;
> >>> +	/* optional out-of-lock preallocated backing (system/GTT only) */
> >>> +	struct ttm_pool_prealloc	*prealloc;
> >>>  };
> >>>  
> >>>  /* bo virtual addresses in a vm */
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> index b10b0878df37..c9cd4714f515 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
> >>> @@ -1173,6 +1173,30 @@ void amdgpu_ttm_mmio_remap_free_sgt(struct device *dev,
> >>>  	kfree(sgt);
> >>>  }
> >>>  
> >>> +/*
> >>> + * amdgpu_ttm_tt_pool_id - compute the ttm pool id backing a given xcp
> >>> + *
> >>> + * Mirrors the mapping used when creating the gtt ttm_tt, so callers that only
> >>> + * have an xcp id (e.g. an out-of-lock preallocation before the bo exists) pick
> >>> + * the same pool the populate will use.
> >>> + */
> >>> +int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id)
> >>> +{
> >>> +	if (adev->gmc.mem_partitions && xcp_id >= 0)
> >>> +		return KFD_XCP_MEM_ID(adev, xcp_id);
> >>> +
> >>> +	return xcp_id;
> >>> +}
> >>> +
> >>> +/* amdgpu_ttm_pool - select the ttm pool for a given pool id */
> >>> +struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id)
> >>> +{
> >>> +	if (adev->mman.ttm_pools && pool_id >= 0)
> >>> +		return &adev->mman.ttm_pools[pool_id];
> >>> +
> >>> +	return &adev->mman.bdev.pool;
> >>> +}
> >>> +
> >>>  /**
> >>>   * amdgpu_ttm_tt_create - Create a ttm_tt object for a given BO
> >>>   *
> >>> @@ -1194,10 +1218,7 @@ static struct ttm_tt *amdgpu_ttm_tt_create(struct ttm_buffer_object *bo,
> >>>  		return NULL;
> >>>  
> >>>  	gtt->gobj = &bo->base;
> >>> -	if (adev->gmc.mem_partitions && abo->xcp_id >= 0)
> >>> -		gtt->pool_id = KFD_XCP_MEM_ID(adev, abo->xcp_id);
> >>> -	else
> >>> -		gtt->pool_id = abo->xcp_id;
> >>> +	gtt->pool_id = amdgpu_ttm_tt_pool_id(adev, abo->xcp_id);
> >>>  
> >>>  	if (abo->flags & AMDGPU_GEM_CREATE_CPU_GTT_USWC)
> >>>  		caching = ttm_write_combined;
> >>> @@ -1239,10 +1260,7 @@ static int amdgpu_ttm_tt_populate(struct ttm_device *bdev,
> >>>  	if (ttm->page_flags & TTM_TT_FLAG_EXTERNAL)
> >>>  		return 0;
> >>>  
> >>> -	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
> >>> -		pool = &adev->mman.ttm_pools[gtt->pool_id];
> >>> -	else
> >>> -		pool = &adev->mman.bdev.pool;
> >>> +	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
> >>>  	ret = ttm_pool_alloc(pool, ttm, ctx);
> >>>  	if (ret)
> >>>  		return ret;
> >>> @@ -1284,10 +1302,7 @@ static void amdgpu_ttm_tt_unpopulate(struct ttm_device *bdev,
> >>>  
> >>>  	adev = amdgpu_ttm_adev(bdev);
> >>>  
> >>> -	if (adev->mman.ttm_pools && gtt->pool_id >= 0)
> >>> -		pool = &adev->mman.ttm_pools[gtt->pool_id];
> >>> -	else
> >>> -		pool = &adev->mman.bdev.pool;
> >>> +	pool = amdgpu_ttm_pool(adev, gtt->pool_id);
> >>>  
> >>>  	return ttm_pool_free(pool, ttm);
> >>>  }
> >>> diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> >>> index ff9e2e346609..f90844937b73 100644
> >>> --- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> >>> +++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.h
> >>> @@ -207,6 +207,9 @@ int amdgpu_ttm_alloc_gart(struct ttm_buffer_object *bo);
> >>>  void amdgpu_ttm_recover_gart(struct ttm_buffer_object *tbo);
> >>>  uint64_t amdgpu_ttm_domain_start(struct amdgpu_device *adev, uint32_t type);
> >>>  
> >>> +int32_t amdgpu_ttm_tt_pool_id(struct amdgpu_device *adev, int32_t xcp_id);
> >>> +struct ttm_pool *amdgpu_ttm_pool(struct amdgpu_device *adev, int32_t pool_id);
> >>> +
> >>>  #if IS_ENABLED(CONFIG_DRM_AMDGPU_USERPTR)
> >>>  int amdgpu_ttm_tt_get_user_pages(struct amdgpu_bo *bo,
> >>>  				 struct amdgpu_hmm_range *range);
> >>
> 
