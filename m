Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E699C43458
	for <dri-devel@archiver.kernel.org>; Fri,  3 Jul 2026 09:23:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CE76D10E5A4;
	Fri,  3 Jul 2026 09:23:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="btY9YWVF";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2FBEB10E5A4
 for <dri-devel@lists.freedesktop.org>; Fri,  3 Jul 2026 09:23:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1783070583; x=1814606583;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=LbaNFVWTdAoi2GmL6QBdwgS1psU/Dj2gYq7zS41X1hA=;
 b=btY9YWVFlPUmR/cMsz87p+jVgEMhnycPSQey/FYwQhLDx2XTox3jFWmR
 IJ4eYKaqRTKVK8X97PXoWI8ri2JckraqCMYgtu7xZfj/4lnTWaLFEY9DJ
 jezyZVCZUCKoznZpXvy+rynNDDr3pHfBnkMSEMIrnB2NtvAiHt/4BWWxE
 urFeF1OQCir7AnFMVAvmyuT20w7sqfn4THDwl1/e2cjKQ7Uv3fvUSLAOx
 QTgg3fFyACB/avbe6d1SFxUkCV4DEBg9FuGuB7nHEsoXOsuBaBs4O0uyo
 tsU5CwnftYUX/bbZZwWT3SEP6U94+X8FHwRiM2AMTkaT0YUv1B1hLV+3j A==;
X-CSE-ConnectionGUID: IaixR+FeQkOtPyGgwMI3oQ==
X-CSE-MsgGUID: /HB7Gkr7TS6gXbSaHVo+jA==
X-IronPort-AV: E=McAfee;i="6800,10657,11835"; a="83688173"
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="83688173"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 02:23:01 -0700
X-CSE-ConnectionGUID: RpJ5t8L7Ss+SOHSCPFNSvg==
X-CSE-MsgGUID: 54hgZFYnSnSYHMgQaHALMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,145,1779174000"; d="scan'208";a="253729087"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa009.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jul 2026 02:23:01 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 02:23:00 -0700
Received: from fmsedg901.ED.cps.intel.com (10.1.192.143) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Fri, 3 Jul 2026 02:23:00 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.45) by
 edgegateway.intel.com (192.55.55.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Fri, 3 Jul 2026 02:22:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SagYeKaQG1TggqZyQe/UOC2wBmLP2EDiSCDmukijoRhb0T2ysAiffgFWYCuvRCc1yQqoc59qSlNzeCqoagTpM3urX/zcQYFE1b+e10Py3L5HKTi7EEpjxeoBOHzz9jRSU7KYlKMisBz8o6sUYdXcgR1uRZHXx2evAGkDtxgXqjDc+cIceC/l4aOrnKHPvNCaUycHyAWFrFWX7XfFtV2KwjsI0sDOr8LRfmW+gzXEo+yVHa52TKKRT312RRosVKkpHpPmQrSRXCErgVHDqc/xMtMAG71acTJg40GIFCLrBRZOYJkf4GxT62xPjm3FJJVv/YTMJgVHN3mEIWYwuy01yA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uUygfxzv6kWvxsUVTEsCF2f/BC3gYxwOelJB7WlsQPs=;
 b=jVdaTjvev33LfjI8CLrNcX+diUAFb/VlAkgkp92wMq9rmaRsvCjMvq5RK0k3MEHu2xzP0rOIEsmADICvYn6FH1lE5g1A/fEyX2UGOlTZslSIfXrSl5H0A83twvPyFUyfy2NX29MI6kLjO5Q0Hy/ARM0qLAx3HwlN2PIeHDE6QFjuzjHO7duN8oISXRvlLEueiWSX43mcRtWVN/OfkI6h8bgSMAJCiMK6EDXFaHaAPMBlpHTLe+fHRhJTNoqx0PlDYytSApumPuW+XMQV2iZLPTNxnLjo4g11eMWJUQmvcIik8DgeXHn0ING1KtDRrhhmwS5PIaT4Y9b23lNk6olx0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DM3PPFCBDC4B878.namprd11.prod.outlook.com (2603:10b6:f:fc00::f4f)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.11; Fri, 3 Jul
 2026 09:22:52 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0181.008; Fri, 3 Jul 2026
 09:22:52 +0000
Date: Fri, 3 Jul 2026 02:22:49 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
CC: <dri-devel@lists.freedesktop.org>, Boris Brezillon
 <boris.brezillon@collabora.com>, Steven Price <steven.price@arm.com>, "Liviu
 Dudau" <liviu.dudau@arm.com>, Chia-I Wu <olvaffe@gmail.com>, Danilo Krummrich
 <dakr@kernel.org>, Philipp Stanner <phasta@kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [RFC 0/8] DRM scheduler kthread_worker for submission latency
 improvements
Message-ID: <akd/ae5VGQrsWqsf@gsse-cloud1.jf.intel.com>
References: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260702143745.79293-1-tvrtko.ursulin@igalia.com>
X-ClientProxiedBy: MW4PR03CA0336.namprd03.prod.outlook.com
 (2603:10b6:303:dc::11) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DM3PPFCBDC4B878:EE_
X-MS-Office365-Filtering-Correlation-Id: 544a46f6-f39a-459a-9958-08ded8e4a86b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|23010399003|18002099003|22082099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: Y94lWbORl0u02X0Y7pYSDVXlcyVENt1HdC5TJWhv+VIbqNYfUIMtIpAmNylHnlc3G/+4RZa0Y7PyxjlsxuidumC5geIZZTyt87V4I2V1OoJoxkvo0u8bvwm0zXvpeaW6bjP0EfzBuD5H0lU1jUHC6aNKPdhliRpgbDqgKbd2gFvhjkQl56/tUpQ1MTx8tRHqhrev2PQTNyyLDmdEGNs8uVgB4JHaVivIMD6mHhDtpDNsbbO2Av0ZvLuqGIMqNeSlUepm9CuIZgMYgqOkB7MTrZ5uHc/CNKA/33efWihWyYDopAVigCfOJ1RWuLmKlR8ZOvFQqq035ysBuAzJn50lO6PuaPHOMSEQnDyWNWAYfkk+X0hKDLBaTn+LLarB1eSryBjgMdoT+hDnTRoWQxqDP3Lu8wcGWuApre3GwOvGi71Zjze9fUocGeG6XO+/CgXQ2UWRkGRi+ymONz90RRoc3RfVcPXIpnaWczj67Ji5/AV61UZTYO3PK5HPv514J7ddevsQdftZr61bDxW0XSQPcnM/g2NV76IDLLq+3ipo6dAfGH5umwhBSfijUf/jOeOUqzsLYPB09cIVzcrKvfD4BD2rBnjW2hKYi5WWypRW8Zx3rSER7Piery33WKDTZHQxvi3oRCUIiKaXq3TcfQLKQNZCbZRgiL66AFvkEUV6Pgw=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(23010399003)(18002099003)(22082099003)(6133799003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?41FHb1Hh5avqoSNZVSb+e90ggFNQTqj4nz7mPWsZzaiXRXt1h9wfLm9u1avM?=
 =?us-ascii?Q?QkRwh4Spi7ULDBRUZWUleCmJMH3W76KM7L/92z2j8fhSKfUXXkKeLI+DS/tz?=
 =?us-ascii?Q?flV+wFv9CEpu5WprjFHaPdspu9F7FIwZJD4RPc/NMXgkiVqrMr7Z+5aE31Uc?=
 =?us-ascii?Q?Iw33DI2c13rdTTvI/RwHg5BUkEzkyZGLgk0qvs30KFiP8P5HWa0w4u4TeMIW?=
 =?us-ascii?Q?bbmdz2I9l/maoNbhyh6ObV/mADyYEH68KCu7qKp1GgljAmfcrYmO+Dk7XuSV?=
 =?us-ascii?Q?y5An18V51ngfwvor16OlcGTXnWMa63HQr8myhzh3Q+a0bkfzhIXVZZCDQfol?=
 =?us-ascii?Q?vza45BWZ+VYvdCrzST+5jJvaCX7CcchH+T1QEn369GL20G15YqZ9rleZvwZT?=
 =?us-ascii?Q?YCD5xKP3MIdKAZaObIrZjyL3IUOe0bZidJGQlXROK7612X4VwX7eXpfylVGw?=
 =?us-ascii?Q?dG/kXR4DSbBaJZ/B7C3/C8brSU7w3YBUmxQNhM4DEmbp+NlNSnw1fBQc9BeD?=
 =?us-ascii?Q?YkxoKegVp4+GvboAJkS1bw46TVucbIXhP0mJvxUfaQYRmhyC3UVqSCD4Zm67?=
 =?us-ascii?Q?FYdimQbKDnZsVxvxixrnO89wU+5mvjTGHEc/cOcaWohhRpYjrnSFxeDoasXU?=
 =?us-ascii?Q?jYVvRbmCu9+O4GmbAsm+9BY5XxPPV7y5mp6q7sG/7gdxt8pb76GEzPNyvSRu?=
 =?us-ascii?Q?wxOcy2Qeun1XCdWFCuE329HH6JlwG77yG/GaJWt/N1u6QfRHcNzcqjvBD4Ki?=
 =?us-ascii?Q?1DxgxHCGMfef0Ne0A4XRnw0fJkLTENugit/k4eHqgs+yzq7Y+3sEY2QLYQmU?=
 =?us-ascii?Q?P67Lxz4u+TVTKcEToNzNdeBX8f95RObIPYPveYIGv/qCtMhcDEdL5Sh53SC4?=
 =?us-ascii?Q?UN0uacC8pADapyo7qbb60LDDbaUrZjpW30nq3ETNnT9hgtVEG4tKU+H5vz+q?=
 =?us-ascii?Q?2730triHoPyFR3Fla/3wiweWkoKLNAaSmv5mfOjqPSVYogo7GaDqYzd0rtPD?=
 =?us-ascii?Q?MWevbYWwdE4ySCmxQw9dOuyk4QfMf/WBJmFpFk2x0/YLOv0DHVyOcju2OKiP?=
 =?us-ascii?Q?nPFpYUBSZDWE9KpCHGVhHmFejVMAM3dASkNBey67gv3H0vOBiTHoshSMBZNc?=
 =?us-ascii?Q?l7VcvkAu62qYWARomHDW2ksofRxP4Quc503LzKSKgp74UUl5Cx6Z4mVHLwxj?=
 =?us-ascii?Q?ImQQDgjtEHauxJ4tVakm0QS2huc8bVOmu1d1Dt1ksDDsCJAidjaHTx8WxMmr?=
 =?us-ascii?Q?QlQOEnIjdIbtbEefwveXrxP4iHt05NPcPE3xR97T7QTZd2hJSiemZQj5ZRKQ?=
 =?us-ascii?Q?tlRaO83yk+HCs4dNv18o7Xy3XBWTBs6E8aTqePb1COIt/uAZaX1NmbYGneAd?=
 =?us-ascii?Q?dFK2HNEyZZFeJ6KQu0yngkGvZgodZLxxpXdQIoS54twEkuK2wZjrbdvbI2oU?=
 =?us-ascii?Q?ECZVtWtN/UdNftoHDa32/JXJvj5Sti+QGxt74fiFIFNavVjXCTb+npI/WNtZ?=
 =?us-ascii?Q?fZCbII6kd2oM088luMGIzYW4gnijxUfSfLQ2CKA0X+fDu38XvxXD/k9lMWTu?=
 =?us-ascii?Q?3LjvfBVheqWNHCb6/Po2heGABKNQs3VdE+flDppqZ50yDKCDWxHIocrT3czr?=
 =?us-ascii?Q?WPWMrXkJHu7KU5w2ltRiUS1/ILRBD/NdAaA5ilMjRHnGgBRHRDqMb4VQjZou?=
 =?us-ascii?Q?Jk3Kdgjhev9CUES+OI/Vuc5thcXk5EpcjSrEtMlJRLhRjEIN16F+z+SObOVN?=
 =?us-ascii?Q?XOfVkEIdhg=3D=3D?=
X-Exchange-RoutingPolicyChecked: WwBrIF6jAKHTAW8vwyY/9Bt46vXPN2kWVov8/AwyP/ZL0BS2ou8CmZU6qSKfLVzvV6DPZe8a6ewLAbaPgEplfRUyzhDHp0gHmVzq5xe7KAhTHgmWak522KAiMdDZsDQX01EG6QnZeVkTFTb2/Unnsds9U/fepO5qZzuPHXvmeRzpfkGljlBA6wx1v8+5r/IFpCGsyFL9x9QRAShf15h1YIKDRAl5lh5kwsXc++8fGZk5oX8WS7nmHGlGh+Iv+vdLYiq74gLueF3+5FB2OWtTVfp7Yur7XFjXqIvggDC0L7zXfYno6wpSZEjg9YawtyLkcsEvoij5u441Pzk0Nmubrg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 544a46f6-f39a-459a-9958-08ded8e4a86b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2026 09:22:52.4143 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zTJhnpsZOy4LQSvRD94YFrUiB2s8m1DevIXs127OqmKHfAzQJt68kslNEl1gtPlqu0tA2D/kRgUUkItql6e9bQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPFCBDC4B878
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

On Thu, Jul 02, 2026 at 03:37:37PM +0100, Tvrtko Ursulin wrote:
> The problem statement is explained quite well and succinctly at:
> https://gitlab.freedesktop.org/panfrost/linux/-/work_items/49
> 
> Essentially, on a system (over)loaded with a lot of runnable CPU processes, a
> high-priority DRM client gets latency injected into the GPU submission path due
> to the DRM scheduler use of workqueues.
> 
> This patch series proposes to replace the workqueues with kthread_work and
> priority inheritance to solve this problem.
> 
> In the above linked issue Chia-I benchmarked the submit latencies which
> show a striking improvement:
> 
> 		median	95%	99%
>   before	41us	1.5ms	2.6ms
>    after	15us	19us	24us

Can you give more information on these numbers? e.g., What you ran / how
you measured these. It is hard to argue with numbers.

> 
> This is obviously really good for preventing compositors from missing frames and

Modern compositors do not pass render-job fences to draw jobs as input
dependencies. On Wayland, this functionality is provided by
linux-drm-syncobj-v1 and is enabled by default on Ubuntu 24.10 and
later. SurfaceFlinger has also operated this way for quite some time.

The obvious solution for compositors is to submit work directly through
the ioctl (i.e., bypass path in sched) when there are no input
dependencies, which should be the common case. The main exception is
when one of the BOs mapped into the compositor is migrating or otherwise
busy (i.e., a BO has a fence in a kernel dma-resv slot).

> similar. Another good quote for the above issue, explaining the consequence of
> CPU starvation of the submit path, is this:
> 
> """
> As a result, vkQueueWaitIdle blocks for 9.5ms for a gpu job that takes 4.5ms
> gpu time.
> """

More details here?

> 
> DRM scheduler was originally using kthreads but was converted workqueues due
> desire by xe to create thousands of schedulers. This series also questions
> whether that was needed, given how the submission is serialized by a device
> global lock (per GT, so almost device global). Panthor has a similar situation;
> hence the series contains two patches to move those two to a setup which matches
> the design of those drivers.
> 
> Other drivers, like for example amdgpu, v3d, etnaviv etc, which use the
> scheduler as a hardware scheduler, where number of instances follow the number
> of hardware blocks instead the number of userspace contexts, are completely
> fine.
> 
> There are use cases however which do currently track the number of userspace
> contexts and which do allow for more parallelism. For those a straight
> kthread_work conversion would be a problem due an explosion in number of
> threads.
> 
> The most direct example is panthor VM bind queue which creates a scheduler per
> userspace context and relies on work queue concurrency management to keep the
> number of threads in check.
> 
> This creates a challenge for the kthread_work conversion. To solve which I for
> now opted to create a trivial round-robin thread pool. For the RFC this is
> limited to four CPU threads and is something which will need to be discussed.

4 CPU threads per device, per drm sched module?

I have more questions but let's get some clarification first.

Matt

> Ie. how much parallelsim those really need. The true answer is somewhere between
> "at most the number of active userspace contexts and the number of CPU cores".
> Or it could be less than that, since after all, VM BIND parallelism is
> eventually going to choke on a narrower gate of actual GPU execution. We could
> also allow drivers to pick their number.
> 
> In terms of how I implemented priority inheritance, the most important
> characteristic is that it is temporary. As many userspace clients may be
> submitting to a single DRM scheduler instance, a generic solution is to only
> elevate the submission worker priority while there are active high priority
> submitters. The mechanism is light weight and has a hysteresis built in to avoid
> frequent scheduler operations.
> 
> That's pretty much it for now apart for an important detail that this RFC will
> not build for all drivers! Out of those which directly use the DRM scheduler
> APIs changed, I converted only panthor and xe. Amdgpu will also work by the way.
> Others I have not tried to build.
> 
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Chia-I Wu <olvaffe@gmail.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: Matthew Brost <matthew.brost@intel.com>
> Cc: Philipp Stanner <phasta@kernel.org>
> 
> Tvrtko Ursulin (8):
>   drm/panthor: Remove redundant drm_sched_job_cleanup() from the
>     .free_job callback
>   drm/panthor: Use separate workqueue for DRM scheduler
>   drm/sched: Use generic naming for workqueue helpers
>   drm/xe: Convert to per gt scheduler workers
>   drm: Wrap DRM scheduler worker in own abstraction
>   drm/sched: Convert the scheduler job submission to kthread_worker
>   drm/sched: Add ability to change drm_sched_worker priority
>   drm/sched: Notify worker of the entity submission priority
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_device.c  |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_job.c     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c    |   2 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_sdma.c    |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c     |   8 +-
>  drivers/gpu/drm/amd/amdgpu/amdgpu_xcp.c     |   2 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v4_0_3.c     |   4 +-
>  drivers/gpu/drm/amd/amdgpu/vcn_v5_0_1.c     |   4 +-
>  drivers/gpu/drm/msm/adreno/adreno_device.c  |   4 +-
>  drivers/gpu/drm/panthor/panthor_mmu.c       |  20 +-
>  drivers/gpu/drm/panthor/panthor_sched.c     |  23 ++-
>  drivers/gpu/drm/scheduler/sched_entity.c    |   3 +
>  drivers/gpu/drm/scheduler/sched_main.c      | 168 +++++++++++-----
>  drivers/gpu/drm/scheduler/sched_rq.c        | 202 ++++++++++++++++++++
>  drivers/gpu/drm/xe/xe_dep_scheduler.c       |   6 +-
>  drivers/gpu/drm/xe/xe_dep_scheduler.h       |   6 +-
>  drivers/gpu/drm/xe/xe_exec_queue.c          |   6 +-
>  drivers/gpu/drm/xe/xe_gpu_scheduler.c       |  21 +-
>  drivers/gpu/drm/xe/xe_gpu_scheduler.h       |   2 +-
>  drivers/gpu/drm/xe/xe_gpu_scheduler_types.h |   2 +-
>  drivers/gpu/drm/xe/xe_gt.c                  |   7 +
>  drivers/gpu/drm/xe/xe_gt_types.h            |   3 +
>  drivers/gpu/drm/xe/xe_guc_submit.c          |  18 +-
>  drivers/gpu/drm/xe/xe_tlb_inval.c           |  14 +-
>  drivers/gpu/drm/xe/xe_tlb_inval_types.h     |   5 +-
>  include/drm/gpu_scheduler.h                 | 131 ++++++++++++-
>  27 files changed, 551 insertions(+), 134 deletions(-)
> 
> -- 
> 2.54.0
