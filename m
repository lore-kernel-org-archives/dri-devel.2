Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB255CA5FC4
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 23:29:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2519510E2E4;
	Wed, 30 Sep 2026 23:29:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="WutToq6H";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92B5810E2E4;
 Wed, 30 Sep 2026 23:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790810983; x=1822346983;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=Hb4LNhSlm3lqznaUEpHIWkDBVgEA+C/s3nRPlq4k8dE=;
 b=WutToq6HX9txTmWe2MsBLzoGyADVgYpaTdBXCipeXKFR+S6unuzFrdB2
 o3A+xMCxcHNlc+gJj6W0YF3xRVT/s1tA54eB044b4MMCNbN0dkzJcUrxa
 FqENl3Jb4TPGHuqJEwpdyAi0iBS+DUd2tSCeXbGTBdPIhUArv+g8XxrCo
 WSo8sJJY0W03Fmb41idiZUpL0/Jlk5QoPGuRoXHGlvmb05kVWtqVZFDRS
 RwRCrmEEUxyORu/V+v33g5CbQgHAJT/gcN5or7sTr04oTsCkNeN7U8e94
 tou1kW0N0ywDeEcV7XagsE6V7sqkWSqoPk22Rb3Y0fvdWJexqzEuz2g69 w==;
X-CSE-ConnectionGUID: YXOGgfsDQq+hPsH9oLXoNw==
X-CSE-MsgGUID: au0yI5EaRICtkn0a84fgeQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="95369726"
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; d="scan'208";a="95369726"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 16:29:43 -0700
X-CSE-ConnectionGUID: 9ZCiAIsrS6ymJ6/nhNR/vg==
X-CSE-MsgGUID: 9AvTf9dmSA6O3KNt8UzcoQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,133,1787036400"; d="scan'208";a="302088675"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Sep 2026 16:29:43 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 30 Sep 2026 16:29:42 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Wed, 30 Sep 2026 16:29:42 -0700
Received: from PH7PR06CU001.outbound.protection.outlook.com (52.101.201.13) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Wed, 30 Sep 2026 16:29:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vHMT7nbbkzB4GZlbmoDyfXFDIhur3SadmN/ed3mP57FzhC2GRgEJILQ/Gp81pYtYZQu4tBvx+PtVr5WCWhITe9iSy1xNCM+XTX6fRuOT3ub8Rzs4M56TGSQe1pmzMHlNQmQ1ZIxzbO/+DZRyT/o99a8CyY6Hm/letPQQ2xZc/gvTdd4+DFhgxUNUXohXja0hRTSCp7tb1X5NB/0kUW9ldCNRsKXL5AdrZuzTrygkrwcxUyyWicxjN8Mo539Uf7wVwBBKm4c6uds7YDkuPuGDddNLb4n8aCmPaE7jc5t3s+xLdxsNzRgMOJEPaMCJ69LlW0Lc3h8CIpLOiiLSodYzOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKSJsRZp4ly/+891UEe0wNVQqC3eGmAHqTvQOKLF2kc=;
 b=vGJmNU5VrIeLhpqsAJa64DuU2xHye5Q2lsZMGoaxEb8vqzG1ElUUj+1E2ys9D3uT0dWRl50JdVfEM4ZwGdUkBfdnN9FeypheoZ5I5zpA2qH3ROTOFB4HaOYr6f1BTIlRyBJC3X5eoM0xIwsLSHmqMF1QT/DSjKMMWbzn77PzsfEFko9zdQj17plkNDyGeEcH9TBS9jZQZBoNFtD56TEKYX9MPHizo6sPZMbsNYgJ+UnrZftkn+pVgNm7bHhab0AeT2yvbaCGELOLvZtqx6yz66nymolMU7FaKl5bV8sdvEN6Kb8gAKj/iBa3vRf7tAHYX1pddzczsSagTtehDuy1qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DS0PR11MB8182.namprd11.prod.outlook.com (2603:10b6:8:163::17)
 by DM4PR11MB7397.namprd11.prod.outlook.com (2603:10b6:8:103::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.15; Wed, 30 Sep
 2026 23:29:40 +0000
Received: from DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e]) by DS0PR11MB8182.namprd11.prod.outlook.com
 ([fe80::7b65:81e6:c6c4:449e%6]) with mapi id 15.21.0472.015; Wed, 30 Sep 2026
 23:29:39 +0000
Date: Wed, 30 Sep 2026 16:29:37 -0700
From: Matt Roper <matthew.d.roper@intel.com>
To: Helen Koike <koike@igalia.com>
CC: <rodrigo.vivi@intel.com>, <demarchi@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <tvrtko.ursulin@igalia.com>, <linux-kernel@vger.kernel.org>,
 <kernel-dev@igalia.com>
Subject: Re: [PATCH v2] drm/xe/lrc: Restore CTX_CS_INDIRECT_CTX_OFFSET
 programming for ADL
Message-ID: <20260930232937.GQ730887@mdroper-desk1.amr.corp.intel.com>
References: <20260930170434.317671-1-koike@igalia.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260930170434.317671-1-koike@igalia.com>
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To DS0PR11MB8182.namprd11.prod.outlook.com
 (2603:10b6:8:163::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8182:EE_|DM4PR11MB7397:EE_
X-MS-Office365-Filtering-Correlation-Id: 9637ee1b-5f84-4540-f058-08df1f4ab280
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|23010399003|1800799024|376014|18002099003|22082099003|6133799003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: OHrKSN5qWZJQkQbziBD5KjIP9WR+9nuKaD+pHG2YstmQVOHc+2uBRUrA6UXAIi738hl98EFTeuMPdddCJTn4/yaV10CxV+wcuKx3ZN2oQBDiocIRVF2jhaEQ8vS06CJyxNGmgTBF/Vjx+2SKketiX0DfbvnDNf372K+8AnMuTW5ElJNkRs+nLL/EMagrvzgLwgxiwB6dytrbvrKbyr+VxNUMp0oGt9ZL3vkvsohxPIiHxx2xbMtTtKLUEO+6EldbQFnVmWq2r2T7SqvrxYeoG6CHC6ni5jm2jZDmKGgc1PJCXQpFsektltEkC1L2fJzY62nObO08aDoXcPQLeELYkOsE3knRiGm9qagG8KXERcJDl1OJCh1jN+ktdFP3BansfRzjDEDkgKgmlj5Y4p9Hp/octATsfi7DpySom1l14NgCmG7xebirrSBIFrtfFQ/3FLxrgYDaCfZNdxd1brmyV/UWGyVb7H2GevbH/nvtpXXGo6hxKerEul7S7fMR+0GkWaHm+hMKzeEXcq9nAAmHidIqFinV9jfqT0yoiWzjLbvtjWUk9z5Yy5uGJLMu+Oyp2mFYQxO0j3bNjUPvwqWZ/M+h35PVYtXAmeoToHfJIk6oUfQZo6VCe/Ylb201Jmhml/VxPmYu0gPYcy+RKC8ek9xdVdkgKY6PN3JqkhzSUh4=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:DS0PR11MB8182.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(23010399003)(1800799024)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bANjTF4F+8JOQIhQA4y0ft0y73IXv9EzdjLQGSrH0ibPBfz8G3Cx5pv5LnPu?=
 =?us-ascii?Q?RUntJ1puvlLoTR1EA0D8fuv45tKFoH59ceXSJSfZOh+6S/fbRxrudhYEqgzz?=
 =?us-ascii?Q?ezsLPfJsqyzYQVSjWDfmJps0zzuw/CYqNxx5Psl9NHeFRmQr3iRE51Lmgkt/?=
 =?us-ascii?Q?vEodcNLXMT9/zjMJftgEnvC0NPf3R6sH3MRROgvfCMo5EAIHHmHW8bv8t//7?=
 =?us-ascii?Q?O93AOvYzvb2eSxNSLTQNWwplygi2KHJlyni9lLTpeudS2zjliDrkkSJCgqZ8?=
 =?us-ascii?Q?Ifn5f4c5CpxgWijjkZh90Jgdb0aHhVphgl024f70XyLFlQ/SO/u/AYTAlKFZ?=
 =?us-ascii?Q?Rg9pW1pjdg8hUGx1H1/Av3vi3SLyYIAtLsdS3tchHmCUuCD5IW15p0luGunR?=
 =?us-ascii?Q?t70PHENntgSoERfxG9OS8IJdT2HPac4MyWF8q71YCn3hvYTOvSD10OAriN2e?=
 =?us-ascii?Q?wSp1iwWBeddwAupYu3Foro8iiouOBR9x4CyjARGX8Hgih1J+0TKS9geHW0TU?=
 =?us-ascii?Q?x9mP4TFZ/aOiUCpzJauIswOAH6OnDAFbai7z6JuokcYSIrjmv8Ci046Lt2yv?=
 =?us-ascii?Q?m59YRwXspd6oad3U5cZXTungFqx+fpNP6MSzF8s7/7nb0/TbQngGqi25ltnj?=
 =?us-ascii?Q?FBrAVy4uA36Wny6U9p2Nh+Q7x0pLR145tcUXIkdqgHUm80fSZ9ayUb821BdE?=
 =?us-ascii?Q?uEc9oN5jjgZe81dKfvyOU+PqZks5YRIdVxj8gYHYcJH3Kr7thB4zAaRjNHzw?=
 =?us-ascii?Q?rqpmmTBKngbsKRfFkG430u8jDwcVvpshE024sTm1sh6xbQjA7lCkwjDcmk8j?=
 =?us-ascii?Q?jsjTKW5d2l208CyIrdSfp+RJ5ugGItxVNvHf67lyUGhAvSDwlm4hJ1cMOAaC?=
 =?us-ascii?Q?XQS2DiLU0OZrmeJWKUeRAiXVcsAldNVZ/CWECEipSJYVFUEneo2W6W/w9KwC?=
 =?us-ascii?Q?vWc2A/OO1hKdWaTrf++eXMWt6F/eBZOmm2TSIXlOhayoG+PEJQlV+j7xjNDL?=
 =?us-ascii?Q?XxUhfLu1hZ1lvR/dN34fcAOVjdIEI5fGn4ltUM0qdL0O8KVInXBi8uLwOTmR?=
 =?us-ascii?Q?kHtnXBMoMXfin2jQHEe89MvuVbSMgaZBcW0FoWCrd8ni0A3o2YegNIM6h8O5?=
 =?us-ascii?Q?iwf+Wc5MgRYVvFIPlIiCbX3pnUUdxqpUo7CL4ECZiEV64+Wp7xcOji6jawtH?=
 =?us-ascii?Q?Sq+mBSa8fgglDH43QzJzjhLoH+llG2Xq+Ih08E914/dDl8tsBxcJl2LkJWpA?=
 =?us-ascii?Q?ufY6fNiz1zrRAHmf/ipjb2ILctlEQIjzCAGcv19XikLVeJyqwx9mLubl+vuA?=
 =?us-ascii?Q?g+AaQ9uDK7BnW5oEhFE6NROiCVvDPcnmBCskh/kyYpz6Nltnrk7voQeul8WZ?=
 =?us-ascii?Q?Jl/V83pdDEOdB27kUfjoFcrCetanLXkkOGDvxHXUKoLMXNsBr+5rba6ZWMiy?=
 =?us-ascii?Q?qJWWgI1gPfzOFRiSOD0ybwmcqm3XjxbHMzk1SizVcz9vEyBBsg2me0BUXPxY?=
 =?us-ascii?Q?86KVuMtX8X1U80rfDbnaraVVdB01hgoCCcDtpT6YHGj6/szNorSGBVJcp35f?=
 =?us-ascii?Q?K8uPqLraeqaE7LfHF7wW/UseHebRxuV4RC1yGFdwkg8P9L++D//AeRAbaLXG?=
 =?us-ascii?Q?pntyWlYInOYn8ukGNJcl5ChnRMFN/m/iGa5SKDqXR2UZZYwaCJcgGcpNOSUZ?=
 =?us-ascii?Q?AV4YVmo9rHUj+kwbbsxAw2U/426qmHzHO+z1dmqhcfDxVRc4FC5jGKlm2Vhe?=
 =?us-ascii?Q?Yl6Y1CEUmQuPLvXtlRW06s+lhu8Ko9Y=3D?=
X-Exchange-RoutingPolicyChecked: J1YHG645cAU5mfcyBFqez8M954kMA+9LXHt+3kAeKvW12hCe3MHQbP8XY1AZ26DisdqB5YYMhLwZhRAdStsyLaYsLo5dAS6UY8wb918W22q85As/XfTW/wvRyS/4AShmkDNf0OV+nkTozv0c0UPHaAJ2eqj6Qr7myQWcFhDK4TKFE9BBEMO+1dvLTTcIrW6GFaREOjGO2QcvtOA4x+42L+ZoLHABSE06dh9A1d6ibfUKvaqjjF20/esUuv00tRImYxe/qxaifKFy1xQOFtwPFcdMjBPuPbgsuJ/rqEAIn5VytEzl1fQ0iH2ojqc0kl0CvieNWvFxfrFpCQMyXaVbpg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 9637ee1b-5f84-4540-f058-08df1f4ab280
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8182.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2026 23:29:39.6661 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xq/3U8qkRU2/RDni0QDIzZ7M7o7s8TFfAfEuM6rWG2BM336xNLeERC2Y1PtW9IBO7u4UdtK2B1i57RPiSpjm5rKusDrw9ddNNRbVg8QSTpA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB7397
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

On Wed, Sep 30, 2026 at 02:04:30PM -0300, Helen Koike wrote:
> CTX_CS_INDIRECT_CTX_OFFSET default value is not retrieved from the GPU
> by inhibit+context save mechanism since it is not part of the Engine
> Context. Thus, at restore, 0x0 is programed back to the GPU, which is
> an invalid value according to the PRM.

I don't follow this explanation, but I don't think this is quite right.
For example, CS_INDIRECT_CTX_OFFSET definitely is part of the in-memory
context image (the CTX_CS_INDIRECT_CTX_OFFSET is the offet into that
context image where it's found). Let me try to explain the relevant
flows here.

When hardware first comes up, it contains "hardware default" values for
various registers.  For CS_INDIRECT_CTX_OFFSET, the hardware's default
value is 0xD, so that's the value the register will have when the
hardware first wakes up or powers on.

For registers that are part of an engine's LRC, whenever a regular
context switch happens, the current copy of the register gets written
out to memory in the outgoing context's LRC image, and a new value is
loaded from memory into the register from the incoming context's LRC
image.

"Restore inhibit" is a special case that gets used at one place during
initial driver startup where we tell the hardware "switch to this
context but do *not* load any register values from memory for the
context that we're switching into."  When restore inhibit is used, the
currently-present register values remain unchanged by the context
switch and the only thing that changes is the hardware's idea of which
context is currently "active."

So the overall flow for initialization is:

 * Hardware powers up / comes out of reset; INDIRECT_CTX_OFFSET should
   be 0xD.

 * Driver allocates memory to serve as the storage space for the
   "default LRC" (aka "golden context"); once initialization is
   complete, this will be the template that is copied to create new
   LRCs.  The registers/state in the default_lrc should be a copy of the
   hardware default values, with various adjustments the driver makes
   for things that we want modified for every context by default (e.g.,
   register changes requested by various hardware workarounds).

 * Driver writes (with CPU) a basic LRI with the early register offsets
   (but not their values) into the LRC storage space.  This is just so
   that the hardware says "yep, this looks like an LRC" when we hand it
   over for a context switch.  Although we're only filling in register
   offsets and not values, this doesn't actually mean that registers are
   being set to 0 or anything like that.  Honestly I'm not sure if the
   hardware even truly needs us to do this anymore on modern hardware.

 * Driver submits the default LRC to the hardware with the "restore
   inhibit" flag.  This means that the hardware does *not* load any
   register values from memory like it usually would (i.e., live
   INDIRECT_CTX_OFFSET remains at 0xD).  The batch buffer submitted on
   the context adjusts various registers away from their hardware
   defaults if there are non-default settings we want present on every
   context in the future (e.g., settings requested by various hardware
   workarounds).

 * The batch buffer finishes executing, so the live register values are
   now the hardware default values, with a handful of modifications.
   Since we don't have any workarounds that adjust INDIRECT_CTX_OFFSET
   today, it's still sitting at its default value of 0xD.

 * The driver submits a second context to the hardware with a noop
   batch buffer.  This context switch causes the live register values
   (including 0xD in INDIRECT_CTX_OFFSET) to get written out to the
   the first context (default_lrc)'s memory storage.

 * ...driver finishes initialization and user starts running real
   programs...

 * When a userspace process creates a new context, the "default_lrc"
   snapshot is copied as the starting point for the new context.  After
   that, various registers in the LRC are updated with unique
   context-specific values as necessary.  So every context created on
   the system should have INDIRECT_CTX_OFFSET set to 0xD.


So I don't see any way that CTX_CS_INDIRECT_CTX_OFFSET could become 0.
Unless there's a hardware bug, the hardware should come up with a value
of 0xD, that value winds up getting recorded in the default_lrc
snapshot, and then every context we make later on down the road inherits
that value.  While we could change it to another value if we wanted the
indirect context batchbuffer to run at a different point during the
context save/restore process, we don't have a need to do that.

If you're seeing problems related to this register, I'd have a few
questions to try to narrow down what's going on:

 * Are you seeing problems on all engines or just a specific one?

 * Can you provide the contents of
   /sys/kernel/debug/dri/0/gt0/default_lrc_* ; the value of this
   register should be at dword offset (0x16 + 1), so we can see if it is
   getting stored in memory correctly or not.


Do note that Xe1 platforms like ADL aren't officially supported by the
Xe driver, so it's quite possible that there might be some hardware
workarounds for ADL that we just never implemented on Xe that could be
causing a problem.  Xe's force_probe support is just for usage by KMD
driver developers, so it was never expected to be fully stable or usable
for general end-user use cases.


Matt


> 
> This causes sporadic hangs on Alder Lake when executing test
> IntelAngleEnd2EndTestCases (error VK_DEVICE_LOST).
> 
> Fix it by partially reverting commit c9dfd66cb91e ("drm/xe/lrc: Allow
> INDIRECT_CTX for more engine classes"). Re-add the programming of
> CTX_CS_INDIRECT_CTX_OFFSET for Alder Lake.
> 
> Fixes: c9dfd66cb91e ("drm/xe/lrc: Allow INDIRECT_CTX for more engine classes")
> Suggested-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
> Signed-off-by: Helen Koike <koike@igalia.com>
> 
> ---
> v2:
>   - according to intel CI results, it seems that this default is not valid for
>     LNL and BMG platforms, so limit the change only to ADL.
>   - program the default only on ADL.
>   - restore the comment, but add note with exception for ADL.
>   - update the commit title/message with "for ADL".
> ---
>  drivers/gpu/drm/xe/regs/xe_lrc_layout.h | 3 +++
>  drivers/gpu/drm/xe/xe_lrc.c             | 7 ++++++-
>  2 files changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> index 4ab86fc369fd..e4c7c3549735 100644
> --- a/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> +++ b/drivers/gpu/drm/xe/regs/xe_lrc_layout.h
> @@ -43,4 +43,7 @@
>  #define INDIRECT_CTX_RING_START_UDW	(0x08 + 1)
>  #define INDIRECT_CTX_RING_CTL		(0x0a + 1)
>  
> +#define CTX_INDIRECT_CTX_OFFSET_MASK	REG_GENMASK(15, 6)
> +#define CTX_INDIRECT_CTX_OFFSET_DEFAULT	REG_FIELD_PREP(CTX_INDIRECT_CTX_OFFSET_MASK, 0xd)
> +
>  #endif
> diff --git a/drivers/gpu/drm/xe/xe_lrc.c b/drivers/gpu/drm/xe/xe_lrc.c
> index 35b4e8289b5f..923bc1ddc851 100644
> --- a/drivers/gpu/drm/xe/xe_lrc.c
> +++ b/drivers/gpu/drm/xe/xe_lrc.c
> @@ -1451,13 +1451,18 @@ setup_indirect_ctx(struct xe_lrc *lrc, struct xe_hw_engine *hwe)
>  
>  	/*
>  	 * Enable INDIRECT_CTX leaving INDIRECT_CTX_OFFSET at its default: it
> -	 * varies per engine class, but the default is good enough
> +	 * varies per engine class, but the default is good enough, except on
> +	 * Alder Lake.
>  	 */
>  	xe_lrc_write_ctx_reg(lrc,
>  			     CTX_CS_INDIRECT_CTX,
>  			     (xe_bo_ggtt_addr(lrc->bo) + state.offset) |
>  			     /* Size in CLs. */
>  			     (state.written * sizeof(u32) / 64));
> +	if (GRAPHICS_VER(lrc_to_xe(lrc)) < 20)
> +		xe_lrc_write_ctx_reg(lrc,
> +				     CTX_CS_INDIRECT_CTX_OFFSET,
> +				     CTX_INDIRECT_CTX_OFFSET_DEFAULT);
>  
>  	return 0;
>  }
> -- 
> 2.54.0
> 

-- 
Matt Roper
Graphics Software Engineer
Linux GPU Platform Enablement
Intel Corporation
