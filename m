Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6FE0C982DD
	for <dri-devel@archiver.kernel.org>; Fri, 18 Sep 2026 22:31:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F00FC10E3C2;
	Fri, 18 Sep 2026 22:31:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="S9a0NSNH";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C57F410E1A1;
 Fri, 18 Sep 2026 22:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789770711; x=1821306711;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=5JrvKn4jRfz8xPDiAahRU4znvNdI/J+rAWg0XECdHAg=;
 b=S9a0NSNHY4iqDmTzC31dMGKt/iS9jAi5QgLF6+x8YSqEwe7uruDepf8t
 5VNH1dthWpkxHAGQASKGZAKEDX4NI3KVZ19csDAyFrS+2luGN4VH96xB5
 JC6TB4c5RlKDmolnUenEfb3T/hPsz57FLKh+1vfmnF7RLxeWoYgjvmwio
 PXpc53mv//uWXGmEzPajQ0K4Auvbr/eOPI1k9HEiX+iHejSyfA/Ie2K9G
 XInW58NHQajpEpXeE3Z1nxtExqR7P5jzYzy4n4flFUFLQqJWU8o4OV2xM
 ps4QZJOrTA5vt/6S/CtHjK6RzthUHc7/BDoAm1uvNKSXv80Xk9qvU6fsX A==;
X-CSE-ConnectionGUID: uOTOlIt0TACVbryIn2m1yA==
X-CSE-MsgGUID: /+NkFLgsQcea4hfM65UiTA==
X-IronPort-AV: E=McAfee;i="6800,10657,11909"; a="92811721"
X-IronPort-AV: E=Sophos;i="6.27,109,1787036400"; d="scan'208";a="92811721"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:31:50 -0700
X-CSE-ConnectionGUID: dGBAMEB5RLGqGy5RuzCa7g==
X-CSE-MsgGUID: yfaN4gA1QiyDJS1zGxWYiw==
X-ExtLoop1: 1
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 18 Sep 2026 15:31:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:31:49 -0700
Received: from ORSEDG903.ED.cps.intel.com (10.7.248.13) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Fri, 18 Sep 2026 15:31:49 -0700
Received: from CO1PR03CU002.outbound.protection.outlook.com (52.101.46.29) by
 edgegateway.intel.com (134.134.137.113) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 18 Sep 2026 15:31:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ieRa4nRoUtb0hwjw0w3K5jcNADSMaAqxDj8DvPt3+MPwyfPcVYMhFjUIG7aXhj1Oty8L8ltP2/oYQP3Z6y4PQRz2xcqAsUvt2sI95JhznJpl+/wKa6mRgX8r7y08vrjRVmPy4jZ9cd6b1e6DUgC41qJ696zLDfBX/9yLP37GnmNisH5DnqMU5UMF2BXTyid1GiE6DNhlKSLL6Hh5tsCBMiWVNSK7Te4hNwMj+MnHEBf9CofNsRP8zPyFk4GN5TY2ERCtpn5cN04R+4t1X/Tt+Indj5+YmYnfpLB9SdFVwPAg9vPUcS9xEXbZSYFcZpGs3lkw1hPGW47wP4mMPk9Y4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VWeeBbNqbTXZN4I0i/jiGg0qbjwGesnuHE0S72derhw=;
 b=Wrp9F4cpcGxcBUPYqmcRTlimv6kysvcHE8XFfLEkk/0VPvToHLPXyS9Ee6iPPJMF7n/FUkXHRTV6oSRmt4XFzZRbS6Sw5CIDESt/2bT15JqiVhycNvDCVoEAelhSCHIJn6xrodASWt4UJSjyb4bj/XeqCDsZZW0+/YO8y4mA+JuA3IrBVTONHqxkEeZWMPEabvIxraPZ3nA8XffYadivLJr8BBxQvfOO5Mq54FysDSz/VuOrYuCEx1WlKSZxSf21X/qeNdNf3NKQYSRKqLUCgbtxPXSb09OvW1xQb/+X1k31bUPT50Q7LbGlbRFC42QzfIHYuH+zrbjekB/Lo/keXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by IA1PR11MB7917.namprd11.prod.outlook.com (2603:10b6:208:3fe::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.13; Fri, 18 Sep
 2026 22:31:47 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.011; Fri, 18 Sep 2026
 22:31:46 +0000
Date: Fri, 18 Sep 2026 15:31:44 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Arvind Yadav <arvind.yadav@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <rodrigo.vivi@intel.com>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 0/5] drm/xe: Fix VM teardown and migration queue recovery
Message-ID: <aq270L/+biIRJHkX@gsse-cloud1.jf.intel.com>
References: <20260916095337.3104891-1-arvind.yadav@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260916095337.3104891-1-arvind.yadav@intel.com>
X-ClientProxiedBy: MW4PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:303:6a::33) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|IA1PR11MB7917:EE_
X-MS-Office365-Filtering-Correlation-Id: c6a61a59-8503-48e0-e74a-08df15d49fcc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|366016|376014|1800799024|56012099006|10067099003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: HbYH2gHPZMuzLBQxO+VldhkGUmKz5httJW6S7LQ8E0FaQasJUQdo9WuBPGe9hnFmQ/5+pDynAMA+KT9Fbn0o2sKawc+2kh1KjSRMoDvRHodEIosdZGtlhxWaYOFHQI9o8/dHFx8EOWs+vTFYhqcww2PHe56xnv4iAQ+tMGBH9FcUBG9jhsieeYy7g6kmPtfuURPgrCYlvcaY0//jABACO1hZjqok8/NaDSis4zlbG3QhSdg8QUQFSn9AEsMQE5TVU4WkamdspEUvs/56EJ8Y/hqnDuGmKkFAm2MhZdLRdRFDWnHJQOX/iSBSedUigg6787/gzFwXHHslIyNvw1ugSTsgBUJLOJn1XD/SlExM7v9lqn/lhAP0UQCltUxVoERoIckDym7annQe64KnmCPtiTc1nPdgKbiyVEQw87+JzDvigcLgITpYJDv9eKWInkTDusqHBQI6cpQ3xGnRJTP9lQwLpiNSRwa/FK0ORSO1bpac8e69DYuKCpEl9huEqIZa1CZLmP+aJ8XH0A5iPfuSji6z+xvmV6x7gTHBKe4wbqjvRSz8AYBSTYPYK1Ya90L40xPEygu8dTMYgjQoPrGxCY8mWB2d7Ur5RuamJs46PX4W3UhSFMhtvk/mwYsxyZIF
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(23010399003)(366016)(376014)(1800799024)(56012099006)(10067099003)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+Rta+OpZ+60One5dOoenh5tGKCTgHbCyZ/RskLvUzEoAheLaXZH0Vl7IIuNk?=
 =?us-ascii?Q?L6R/+6sgIpXp5lzuVkvhZrUwV4lzZJGuIFpauLHS4z/mDmaVxkdomvpMZw3O?=
 =?us-ascii?Q?l9rb5Omr/ofbiNKmMD5IjB8IUWCZuwFcvwhW180xfGUN7S5BE37JbGD4peYq?=
 =?us-ascii?Q?Xw0x1LH8V32tbcTHAtagnLZxkUo6vxYjsV5JFlDdlYhm7AHPFfrLrqFd/xJc?=
 =?us-ascii?Q?q1Zb2c3BdYJ1i/Azvj+vCQfdqItWs8mt+lXn5YkGeVQygWSc9q+38gZEDCYl?=
 =?us-ascii?Q?9tfpmgEZOp5Dt5PbcBldyzXFtbF6dRW7j745R2daTjRdVSOXk7FGL1ZEd35w?=
 =?us-ascii?Q?NQiyAt8RBrwW2MPxQQFEyt/dl+krvnrG60THhU0MmiITUC1XFz375eyV67dd?=
 =?us-ascii?Q?4FBgu2an25CdjMDl3xnup3+6ToiIyBre5LF+uoJj3qJVToN4uKy6MRallQG4?=
 =?us-ascii?Q?ZrMnLvK6FbvB8KTGz0+mcll5T7q5a0gJPHE+ITnHoho5XIWYvkRgAT47cYTu?=
 =?us-ascii?Q?OLcuH6yXRMLuoiSA+6iB6EvHjy8Zf5VrADCeD758v6tEgNZzpFYuCSlefzws?=
 =?us-ascii?Q?VSj//VIM+wSDIirWma/PBCGDaue9oThNvlech8NtV//2yFkQ9IIoW463ng6i?=
 =?us-ascii?Q?/mcz7A4gcoWVQvl0ReLaq8CbEEQ+D42z60aeeXRxnDD925N5XiEPJ8b01THa?=
 =?us-ascii?Q?xxG7CZJls/s/Y2YvWTyTAvdWOXueENFhLnN62szPc042vFc2mSq+ZyATyB2T?=
 =?us-ascii?Q?kfbzxOBx81Y+M/2zlKqs+XkbU61tprzC43360g6GkKBnLmIy1XRqUIXqEA9i?=
 =?us-ascii?Q?EzlGKW8obSC8giK4aZQPGIOg14fTroD+aHg/D9dxAsNHMEN8dT3pHQBLtI/k?=
 =?us-ascii?Q?F6m2itzn0+rbv0pFkTVaiZ/Y8Av1OrmFmUNka199h5p642PRsQRuWS71QWco?=
 =?us-ascii?Q?YjOf6OsRpTNPckW62Z0KiCFamLw1x3gE+6U5NkWfZZ5CTnWrljxRkHOuYtnE?=
 =?us-ascii?Q?u9iOOHnWu3JNDFWzzWLCxhjdDufy3O8Cm9hpcxyaWx8K13jONVJktRwSKovB?=
 =?us-ascii?Q?ufq5msMOfJi6+UegUTkTJYhbFNwU+ZuwrjRqYIdWn0xTW2VvqhosyjByzzXv?=
 =?us-ascii?Q?T99B/NR36/qkUGQG1CM0YmcPEMfUltqRa4hy4EWUCh46uyUEx0aWOCHY3oJb?=
 =?us-ascii?Q?taWrZQNKoxmcnQFYZ5x5mJQaJ6vP41cMNFVdSeGWMlkW+eNoexQAwoVLXrPC?=
 =?us-ascii?Q?FVdpr3fwKzzjBON0B6AKZwb8EwsfiMC7jHDUbIO+oLfawtF8PytzlxraakOQ?=
 =?us-ascii?Q?fSKaXbJuDbkykVQ60oe5biY3P3ZxjzA8tFk7HPLCu6c1dO/ttFjgGHn/R2t2?=
 =?us-ascii?Q?TJ1xPA0BmziLusJA5/TBOK9xOn5G/lYHT/+3izHmxgfPZFLz6MLcUdaJJehR?=
 =?us-ascii?Q?HVT6E1R04g59qeIN76MbLpf+8VA0WdK5oHWqxrKHgRL0fNQV8VZo6W5QCISK?=
 =?us-ascii?Q?sai2u3vYL+Sw8EJRWYbcsdluzYrZwkMjfBGsqvbASkJHvkaAfgysqI391xRF?=
 =?us-ascii?Q?bg2BY9bceHDaJoG7DtiKoU/cH1eXbjpsL04W30VAHwsmPIyydfSGlA5KzXtz?=
 =?us-ascii?Q?KC9pi0NEZbJZPkAZn6mC0h/MbX2H5FnbAmL0bnrFq3rxIABPyiFD8QmcvWoh?=
 =?us-ascii?Q?cuAxTaChVjiXoK53ApiNiUYlAxJbeB6a319wkO6szIJZJpKFUME7HZ7DJ0/g?=
 =?us-ascii?Q?rxyC/JKouDrmUQLx3NoLsfuB8S6eTjY=3D?=
X-Exchange-RoutingPolicyChecked: l8CX1jjHs20tt1T4G15eNgeEfYFIcQ9MfthJxTV5+WR/PNEI7wJtdCyyVUUU27xmXkXrRbw+0msFnvfgzKdsycseHv/Dj049UUkWlYtcQSamIgGlzUMl64ezuo2S6rFmBk2VybKcxs8Pbsx8wZ9Kt0lDDqldPCKWJKKD1NszJm0Y159MinDx2G5WyBOeh9aPMiTA4hMadapeYqSuPpbT+BknDrDlsel7f/UsrznG23ffW6jhMyvjDIpWnj+rymqCygnWKc25k8ZV7W+KjDaYJu//OxXAU7N9ynsamwFnvK7rAYhJ0/E17pvl1sOAstfWEH6T8cSxw3z0+nE7kp9PBw==
X-MS-Exchange-CrossTenant-Network-Message-Id: c6a61a59-8503-48e0-e74a-08df15d49fcc
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2026 22:31:46.9308 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v4vc+VAVr8A/lUcq3hvwb8yIVPb+s5uZ9J01NK5i8yPfoQoCKvuQuuVoQj9Yaw4CBa1p+NcDJhmfiTlDupKTLQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7917
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

On Wed, Sep 16, 2026 at 03:23:32PM +0530, Arvind Yadav wrote:
> On BMG, terminating a process with Ctrl+C while GPU work is running under
> VRAM pressure can cause an RCS page fault followed by a migration queue
> timeout on BCS8 (guc_id 0). The driver resets the GT, but the pending
> migration job can time out again and eventually wedge the device.
> 

If we can just avoid faults on ctrl-c or segfault will this series be
needed (or at least only a subset of this series)?

I suggested a way to kill the exec queue first + sync wait on those here
[1] before clobbering the GPU page tables? I don't really care who works
on [1].

We still need root cause why a RCS fault affects the BCS engine - it
shouldn't and need investigation.

Matt

[1] https://patchwork.freedesktop.org/patch/752845/?series=173889&rev=1#comment_1391707 

> BCS8 is reserved for paging and runs migration and VM bind work.
> The exact hardware link between the RCS fault and the BCS8 stall
> is still under investigation. This series addresses the teardown
> and recovery problems found while debugging this failure.
> 
> During file close, exec queue cleanup starts asynchronously, but the VM
> mappings can be removed before that cleanup finishes. A missed wakeup in
> the GuC disable-completion handler can also turn a completed operation
> into a five-second timeout and an unnecessary GT reset.
> 
> The reset replay path rewinds the software ring tail to the oldest pending
> job, but leaves the LRC head at its saved position. This leaves different
> starting positions for replay.
> 
> The four patches address these paths:
> 1. Clear pending-disable state before waking waiters, so a completed disable
> does not appear to time out.
> 
> 2. Mark VMs as closing before queue cleanup. Reject new work and page faults
> on closing VMs, while allowing existing SVM invalidation to drain mappings.
> 
> 3. Keep VM mappings alive until queue cleanup completes. File close uses one
> five-second queue-wait budget across all VMs, then defers any remaining teardown.
> VM destroy defers without waiting. Device references protect deferred close and
> final VM destruction on the module-lifetime destroy workqueue.
> 
> 4. Set the software tail and LRC head and tail to the oldest pending job before
> resubmitting jobs after a GT reset.
> 
> The five-second budget applies only to the new queue-cleanup wait.
> Existing teardown waits are unchanged.
> 
> Arvind Yadav (5):
>   drm/xe: Hold a device reference across deferred VM destruction
>   drm/xe/guc: Wake disable waiters after clearing pending state
>   drm/xe: Mark VMs as closing before queue cleanup
>   drm/xe: Defer VM teardown until exec queue cleanup completes
>   drm/xe/guc: Reset LRC ring pointers before replay
> 
>  drivers/gpu/drm/xe/xe_device.c     |  25 +++-
>  drivers/gpu/drm/xe/xe_exec_queue.c |  22 +++-
>  drivers/gpu/drm/xe/xe_guc_submit.c |  60 +++++----
>  drivers/gpu/drm/xe/xe_module.c     |   6 +-
>  drivers/gpu/drm/xe/xe_pagefault.c  |   2 +-
>  drivers/gpu/drm/xe/xe_svm.c        |   3 +-
>  drivers/gpu/drm/xe/xe_vm.c         | 205 +++++++++++++++++++++++++----
>  drivers/gpu/drm/xe/xe_vm.h         |  14 +-
>  drivers/gpu/drm/xe/xe_vm_types.h   |  16 +++
>  9 files changed, 289 insertions(+), 64 deletions(-)
> 
> -- 
> 2.43.0
> 
