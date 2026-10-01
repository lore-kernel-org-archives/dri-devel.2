Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0233CA5FA5
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:56:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 370C610F5E2;
	Thu,  1 Oct 2026 09:56:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="RYgJIX4V";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 245C710F5DF;
 Thu,  1 Oct 2026 09:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790848574; x=1822384574;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=e1WhCCR0vJ19GgmPssSYuF0o4xvXPM36ZVtR/hg8AUM=;
 b=RYgJIX4VFdkvHL+rlz4+pDIj56gafzlvksn04oF6VWKYarpDeBiY/U2t
 lwmCDG3dvRkofD+JLVvxD83rUc4xhbPuTpb0ZOsTAPAhc6BGdP4WhzG7I
 H7nnJErHNZj7Z+M6QbP+Wr8k/1w7rqpsOythGMrCaYp930tH2Wr7G+n9A
 Z9z1Q0fcNSZE/Qqe6GHicpE3jGQaenw1InV3oJG/vDyZSoMG73gce8kjg
 UgFcFKOWt8iqR1Uy29c/UwAZNZIa0BvwnWkQxiswVQ9uoocIMv7fceBuZ
 cozawyv3RMyXUvunYAj4qgFZDEI5T6keEPUsFn3IUcq9eVCIByIPUFbCe Q==;
X-CSE-ConnectionGUID: 8+TLT0ioQUSr4x+hLX5xwA==
X-CSE-MsgGUID: jaxb5TnWSwSLISj5Z+fyaw==
X-IronPort-AV: E=McAfee;i="6800,10657,11921"; a="102272969"
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="102272969"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 02:56:13 -0700
X-CSE-ConnectionGUID: k/hs7n3AR1q30ohs0U7LJA==
X-CSE-MsgGUID: KOECo1JTTKmkqfK/ITg5vw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,134,1787036400"; d="scan'208";a="274036613"
Received: from orsmsx903.amr.corp.intel.com ([10.22.229.25])
 by orviesa010.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Oct 2026 02:56:13 -0700
Received: from ORSMSX902.amr.corp.intel.com (10.22.229.24) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 02:56:13 -0700
Received: from ORSEDG902.ED.cps.intel.com (10.7.248.12) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 02:56:13 -0700
Received: from BL2PR02CU003.outbound.protection.outlook.com (52.101.52.15) by
 edgegateway.intel.com (134.134.137.112) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 02:56:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eCy0mXf7HMEDmmhLjp4NyqyLqi2DYXy0sMVtKllNsmKDGI9GpWuvQs97A4J9iZM8I9qyf63U15ClWVWIJ3rfCjRKWj/zQzedPEIrQAVfKdgV33hJNHjJfKQ68U/ERJODPPvNIWg2ICJThKi++BZ5gDvoY7TcCNOhuJ6HUEElGerX2oWo/WzQJgVN5+cdU1pGIucxXUcXcBlt7v/Oj9UJp/kMrKSEZU5t5aBEK/l0DgR3xi4G/ytQoxkxnJVL4fcoM1cLrnsGL8p3U640SkR4MaHlMd+i5q/c3IENvTneYe4XLSfSrNIGbv9wMcbnJviV65NAJwlgoXbXq3zpIV0uag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dpaQ/LxkMQMWrjW+hr6+VSExg4O16d28LTOfo4CcBVk=;
 b=MHn+BTlXXXL/pVcqiHNbzH5oR4ZpDoM6CIJvPr0RTGUXkFyQLVAH4BxxUaLoo8a5XKWmg17XHjOlP3yJMqWxVmSqTAImrqKsnVt9WmC3fJSST0YjIF8hsdEOChTzDuFarAv5rNz06h+/sCiIoCuzPfEhcSr48k22uzwNEya5BN40uDhEHOr4iHJnsjreVhzMSI2d6nXIJdKOePzN/RitEwvx2vOjARzRZFcnCIgVXXfZaRDdNIgkj1/9u9dPuTcBgYGIoXVFqDiXAe2pccOi63RnhAUxDsGwVVi2221cpDhuAXXtMKV0T9Yr9x/xIp/Lvm7ycXjFqCl8nQ+V9m9x9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB9534.namprd11.prod.outlook.com (2603:10b6:510:39f::22)
 by CH3PR11MB8315.namprd11.prod.outlook.com (2603:10b6:610:17e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 09:56:07 +0000
Received: from PH8PR11MB9534.namprd11.prod.outlook.com
 ([fe80::16ca:6958:c9e9:a266]) by PH8PR11MB9534.namprd11.prod.outlook.com
 ([fe80::16ca:6958:c9e9:a266%5]) with mapi id 15.21.0472.015; Thu, 1 Oct 2026
 09:56:07 +0000
Date: Thu, 1 Oct 2026 11:55:58 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Brost <matthew.brost@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 "Alice Ryhl" <aliceryhl@google.com>, Boris Brezillon
 <boris.brezillon@collabora.com>, Danilo Krummrich <dakr@kernel.org>, David
 Airlie <airlied@gmail.com>, Jonathan Corbet <corbet@lwn.net>, Liviu Dudau
 <liviu.dudau@arm.com>, "Maarten Lankhorst"
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>, Shuah Khan
 <skhan@linuxfoundation.org>, Simona Vetter <simona@ffwll.ch>, Steven Price
 <steven.price@arm.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, Thomas Zimmermann <tzimmermann@suse.de>
Subject: Re: [PATCH 2/3] drm/xe: lock the resident BOs of an exec last
Message-ID: <ar4uLiFuUucrQXCg@fdugast-desk>
References: <20260814073258.893007-1-matthew.brost@intel.com>
 <20260814073258.893007-3-matthew.brost@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260814073258.893007-3-matthew.brost@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DU2PR04CA0020.eurprd04.prod.outlook.com
 (2603:10a6:10:3b::25) To PH8PR11MB9534.namprd11.prod.outlook.com
 (2603:10b6:510:39f::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB9534:EE_|CH3PR11MB8315:EE_
X-MS-Office365-Filtering-Correlation-Id: 54099b05-7d1b-496a-001e-08df1fa236b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|23010399003|366016|7416014|376014|6133799003|18002099003|22082099003|10067099003|4143699003|5023799004|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: BGESajny0g6Fv2pvQ/COwOMUobPPe/yl1OH/qPlb1Vt/j5rGrka3KgR1pZBK8p84eQF++n4rsG8JftRWfJqcySkAC7mlbSmXP94YNiYhnOo4nKuNIlNjWVvkrgmUsqy1Xlc6DY+s5nL7IRQDpZ7icVH4gZRmjWaDXm+GceHbxvjTSJbtyTJYq+LjgXOdhtb2G/9MuaqS2lp2YEKYiOeUCSYlM7I3YmUgs/tGtgMeSdaihGrK9dZdkSkzAZYRx7nXQQCcYmK5PNm0+bNwuicJ7aIY7h1L8PgbhJ03g6MOEzAPeI3jvhJ9CTudMaymC9dV46AM82t4rWB7eyByN1tLYmxkf0M0quQcr9RiGH6r5SVcGLUkKa0hvXTXJmb07mQc0uVSM3EXtJll9ru50ZGEPwBqJ+fSGhRUls7qXesyyhIochQCRS1K44cG5yBIoEPmDKPZmxD+Rli4D+0sEQp/SJFg0s30I6QF3QF7ZUtulMwjVTqvRiugbMvbH8GHH3yCqX1MAvcvyTcFmLLvzf8svcky6zw87LJ2GQ9fFSGfeFwwS2kRBtwY4ZRLbqOXZs9QVDifnzZdcaUR6wwhPbULJXfFAQzOySdC0kYeN1uuwBsKpb5DNKJNXbJH+GVSG6WlvFs4bu2D9gmm9bmWF8wyyQGil06WHLu2BNt/06dwZmA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH8PR11MB9534.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(23010399003)(366016)(7416014)(376014)(6133799003)(18002099003)(22082099003)(10067099003)(4143699003)(5023799004)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?7NHA/3NCSjZ8/M99QZoSjAtib/ttm2aSmvP+8YhdhGq2OPFZUsuaHaRaLQ?=
 =?iso-8859-1?Q?ouVfAyRp81Gs0wiaGmYsVvCRKg+pgoeBscaRd7C4iuxgoyMscGWsXbviIg?=
 =?iso-8859-1?Q?O+ZyglaPvLK6dTXkn2EvKF9u3+PrL1W0niIetyCN8V32571gp9wHVkKxo+?=
 =?iso-8859-1?Q?LzVKYGeMpHw6ruYEaK1dzZgATepYbCtBZoJEp3LKzX86RFc4MnEbU+M2Sr?=
 =?iso-8859-1?Q?I3VBrEPXjKCTagsQcOa4Mv+LVT7m+ncD78g/r454upixf7xnKZfPfb4Qun?=
 =?iso-8859-1?Q?kchwHpRCfybI5FcCmYExR+wgO7Q/HlOfTwjOhTwsI82sG/WyGh48WXPrGd?=
 =?iso-8859-1?Q?oqtiZGw55aWIXJdRDG8bZv/5EJSHCjrZZSQ+b7nMLbCfQ846AIr952KR0X?=
 =?iso-8859-1?Q?8G/toXTmYd/Lh9zE+hL5MJa/6I9O8Wo4D3p4YbO+ltNHlkQDc8DBc7tKZj?=
 =?iso-8859-1?Q?wHtWHViXM3tyUVfQgLyzJQU/IjObpNdXSk2QDBsSAJDkqLkhqflGo2SAYa?=
 =?iso-8859-1?Q?yqirMfbW/iRdPRrsutsqgHXxDbOj2xY23H7A1bbUB8hJinALkyAK7PmVDO?=
 =?iso-8859-1?Q?ZWkOQg/cmCjivlbcgcC7Czl6qbIkuAb82AATOCnDcpriCo43iwVSvuuJXm?=
 =?iso-8859-1?Q?6GPLJ0h1n75NPBajvd4nKPChMfZPjA1C8kE3umgocNoZpCLVq5iGitoRGM?=
 =?iso-8859-1?Q?icowdg4FFGb65X4kjy7LQ50jCOPPImoDfzf/gQlSdp2LHnijFXYU+EMLhu?=
 =?iso-8859-1?Q?/HzYDprRkJAxSqN4Feuwe161F2XFUTKvGodvow+iDZyg81WTttw/Xd5Fz2?=
 =?iso-8859-1?Q?+gwRX0X/f/5uDG5u+5f3EZWCZx1eeyKVr9appf4xbabZ/O004jSbIPye/f?=
 =?iso-8859-1?Q?TKkXTWkmzAQ6NOAuj2ussi2CPH3yLd9vcFkkK1ZyRVz1fq2IJwCHoNrun1?=
 =?iso-8859-1?Q?Mnj6u7FN5idRBZmA8g1vM2tH5cbm3gLGQFx3dylFuCnY1MOJ8CJXJyIN3g?=
 =?iso-8859-1?Q?+E41cPbBy3icn1dgKfMUbUuUnBbsWKFnZkSNbz23ioULYmjyfTIo6q+9iT?=
 =?iso-8859-1?Q?mMHgZgcPuKcuwsfNGeUXFtAjmd0MrEpt/PM9u2t4m5xSerolyAhQoN4Sfr?=
 =?iso-8859-1?Q?I0+F+h+UWfILdJPhom/C/tP/n5u+QsTgSOzovSb8tNMFaYmyeLrxL6knQG?=
 =?iso-8859-1?Q?yKU0169BUGp6Fbkh+MW+9pzlGinKVQmjsSBvt84XQC8f9keRK7AFt5nF/+?=
 =?iso-8859-1?Q?Xs8CU7crYwwCm18TkimiIA5e5v/tMNRekzHJmbhVDuq8ITAIywAumq28vz?=
 =?iso-8859-1?Q?tNa1PnCvRlKzbDLhy8AmZpNeiV3vCmnnXpQLiEiAbAW7hFabyyFS/7ayvJ?=
 =?iso-8859-1?Q?8ZPahv3xyEDKtbkI/7pPdTFaJMvyuMd2bEWXS9EviDb6tpkayLsPzZ2rS2?=
 =?iso-8859-1?Q?NYsEXsUF48IKKB/ZoVGuHScM/VfTTM/GNpva7RtwtlHlQQfj/u7FYr7KOV?=
 =?iso-8859-1?Q?cidi5jJY8eUcK/eBynW2RHK8KVKm8z1bR7rd9yRDa7INdSX9vhluTZuBxS?=
 =?iso-8859-1?Q?kcQHvuGwNQA3lzAioI1fAxZg1n2XUxirX2FZOp8XEg53M9syeTmMBKlmae?=
 =?iso-8859-1?Q?bLrkQnaAzHZoK+/Zb82E7+0PeZU9WZvuvA2pXnzFUHTQjA5X0aSjz3OU5x?=
 =?iso-8859-1?Q?YLueDCLOVoB/gQI6VQdTu8ifgXaWxHqf/fTpSrECP8mkRNLdwmcPT75nbN?=
 =?iso-8859-1?Q?SBQpBWe41UnViW2MVmdUwtRBHR6ecyUyorv1DJ6yR3mCwANcii1LWIfPwX?=
 =?iso-8859-1?Q?eSV/vIkkj7NcjKkqyR+m5GZzynpGrBc=3D?=
X-Exchange-RoutingPolicyChecked: 5MR/hdM/D5XEnhPvbvU62jM47Jw6IiLv5f28hS7tNtk9b1rkvSIUuxr/1wUOiCGxHODsAz/UYYUVqg3BABjNerdZLS3b/G+a1ZEz9ySf3onzumL0i6ttksg9qh01jkXuADaz8SurrRp2PImkDun8a9d9dKUmynDK3X9k8bh2rjlbv7jHYPnv6nK+L9PJmtSB21fy7RJ0VDx2zL7xqqFj7O/3x+ozOdvLTZpzTaWya8n/6z4mZjECAUy+RP+nGGQ1Vrw1cPH98zTe8KrL/37ME8igY9Ao7h7AoGPNYmFFnP+BGDOaUTdwcBjHRGzYYSgNPmoM1lpQdvx0TaVEU9Pb2A==
X-MS-Exchange-CrossTenant-Network-Message-Id: 54099b05-7d1b-496a-001e-08df1fa236b2
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB9534.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 09:56:07.3757 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: t3csATqwLs90PdzBJuQkWDnoZvF20JcOR2i7tYfUjZM2HDridXdav2H+PHy/vSCp5+ihU48mCMlER//MbESJ9odHZkilTuW0VOuJKm5HKmA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8315
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

On Fri, Aug 14, 2026 at 12:32:57AM -0700, Matthew Brost wrote:
> xe_exec_ioctl() locks the dma-resv of every BO mapped in the VM in one
> drm_exec transaction, then validates, rebinds and submits. Any migration
> or fault-in a client needs therefore happens while it holds the dma-resv
> of every object it has mapped, including the ones shared with other
> processes. A client faulting in a large buffer of its own stalls whoever
> else has those shared objects mapped, so the compositor it is presenting
> to can miss a deadline over a set of BOs it has nothing to do with.
> 
> Most of those objects are not ones the exec has to validate. Make the
> exec transaction two pass, so that it locks the evicted BOs first,
> validates them, and only then locks the resident ones. It ends up
> holding exactly the locks it holds today, it just takes the ones it does
> not have to validate last, once the expensive work is already done.
> 
> Only the external BOs are actually split between the passes. The VM's
> dma-resv is held from the start, as before, so the evicted private BOs
> are validated in the early pass too, without anything extra being
> locked for them.
> 
> Nothing is unlocked in between the passes, so this needs no recheck and
> no fallback. The late pass can still find something to validate, since a
> BO it had not locked yet may have been evicted meanwhile; that is handled
> the way it is today, with every lock held.
> 
> Two details are worth pointing out. xe_vm_rebind() rebinds the whole
> rebind list in one go and attaches a fence to the dma-resv of every BO
> on it, so it needs all of them locked; the early pass deliberately does
> not hold the resident ones, so it leaves the rebind to the late pass
> entirely. That is also the better order, since rebinding allocates page
> tables and can therefore evict the very BOs the early pass is trying to
> leave alone. And the sched job's fence slot is reserved in the late pass
> only, that being the one which holds every lock the transaction is going
> to hold, so it is still reserved exactly once per object.
> 
> A concern with splitting the passes is that validating in the early pass
> could evict the very BOs the late pass is about to lock, moving the work
> back under the full set of locks. Xe is immune to this by construction:
> __xe_bo_validate() brackets its ttm_bo_validate() call with
> xe_vm_set_validating(), and xe_bo_eviction_valuable() walks the
> drm_gpuvm_bos of any eviction candidate and refuses the ones bound to a VM
> the current task is validating. The early pass therefore cannot evict a BO
> mapped in the VM it is validating, whether or not the late pass was going
> to lock it. That guard predates this patch; self-eviction is pointless
> work in a single pass too.
> 
> While at it, xe_gpuvm_validate() is changed to clear the evicted state
> with drm_gpuvm_bo_evict() rather than by assigning drm_gpuvm_bo::evicted
> behind GPUVM's back, so that the bookkeeping GPUVM now does there is not
> bypassed.
> 
> Cc: Alice Ryhl <aliceryhl@google.com>
> Cc: Boris Brezillon <boris.brezillon@collabora.com>
> Cc: Danilo Krummrich <dakr@kernel.org>
> Cc: David Airlie <airlied@gmail.com>
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Cc: Maxime Ripard <mripard@kernel.org>
> Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> Cc: Shuah Khan <skhan@linuxfoundation.org>
> Cc: Simona Vetter <simona@ffwll.ch>
> Cc: Steven Price <steven.price@arm.com>
> Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> Cc: Thomas Zimmermann <tzimmermann@suse.de>
> Signed-off-by: Matthew Brost <matthew.brost@intel.com>

Reviewed-by: Francois Dugast <francois.dugast@intel.com>

> Assisted-by: GitHub_Copilot:claude-opus-5
> ---
>  drivers/gpu/drm/xe/xe_exec.c | 23 ++++++++++++++++---
>  drivers/gpu/drm/xe/xe_vm.c   | 43 ++++++++++++++++++++++++++++++------
>  drivers/gpu/drm/xe/xe_vm.h   |  3 ++-
>  3 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_exec.c b/drivers/gpu/drm/xe/xe_exec.c
> index d5293bc33a67..abe522c19ec9 100644
> --- a/drivers/gpu/drm/xe/xe_exec.c
> +++ b/drivers/gpu/drm/xe/xe_exec.c
> @@ -79,8 +79,10 @@
>   *	<----------------------------------------------------------------------|
>   *	Lock global VM lock in read mode                                       |
>   *	Pin userptrs (also finds userptr invalidated since last exec)          |
> - *	Lock exec (VM dma-resv lock, external BOs dma-resv locks)              |
> + *	Lock exec early pass (VM and evicted external BOs dma-resv locks)      |
>   *	Validate BOs that have been evicted                                    |
> + *	Lock exec late pass (the external BOs left out above)                  |
> + *	Validate any BO evicted since the early pass looked at it              |
>   *	Create job                                                             |
>   *	Rebind invalidated userptrs + evicted BOs (non-compute-mode)           |
>   *	Add rebind fence dependency to job                                     |
> @@ -95,15 +97,22 @@
>  /*
>   * Add validation and rebinding to the drm_exec locking loop, since both can
>   * trigger eviction which may require sleeping dma_resv locks.
> + *
> + * Called once per pass, see xe_exec_ioctl(). The fence slot is intended for
> + * the exec sched job and is only reserved in the pass which holds every lock
> + * the transaction is going to hold, so that it is reserved exactly once.
>   */
>  static int xe_exec_fn(struct drm_gpuvm_exec *vm_exec)
>  {
>  	struct xe_vm *vm = container_of(vm_exec->vm, struct xe_vm, gpuvm);
> +	unsigned int num_fences;
>  	int ret;
>  
> -	/* The fence slot added here is intended for the exec sched job. */
> +	num_fences = vm_exec->pass == DRM_GPUVM_EXEC_PASS_EARLY ? 0 : 1;
> +
>  	xe_vm_set_validation_exec(vm, &vm_exec->exec);
> -	ret = xe_vm_validate_rebind(vm, &vm_exec->exec, 1);
> +	ret = xe_vm_validate_rebind(vm, &vm_exec->exec, num_fences,
> +				    vm_exec->pass);
>  	xe_vm_set_validation_exec(vm, NULL);
>  	return ret;
>  }
> @@ -268,6 +277,14 @@ int xe_exec_ioctl(struct drm_device *dev, void *data, struct drm_file *file)
>  	if (!xe_vm_in_lr_mode(vm)) {
>  		vm_exec.vm = &vm->gpuvm;
>  		vm_exec.flags = DRM_EXEC_INTERRUPTIBLE_WAIT;
> +		/*
> +		 * Only the evicted BOs need validating, so lock those first,
> +		 * validate them, and only then lock the resident ones. A
> +		 * client faulting in a huge buffer of its own then no longer
> +		 * holds, for the duration of that, the dma-resv of a BO it
> +		 * shares with the compositor it presents to.
> +		 */
> +		vm_exec.two_pass = true;
>  		err = xe_validation_exec_lock(&ctx, &vm_exec, &xe->val);
>  		if (err)
>  			goto err_unlock_list;
> diff --git a/drivers/gpu/drm/xe/xe_vm.c b/drivers/gpu/drm/xe/xe_vm.c
> index b37ade64f4eb..3b3b01764e11 100644
> --- a/drivers/gpu/drm/xe/xe_vm.c
> +++ b/drivers/gpu/drm/xe/xe_vm.c
> @@ -355,7 +355,7 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
>  
>  	/* Skip re-populating purged BOs, rebind maps scratch pages. */
>  	if (xe_bo_is_purged(bo)) {
> -		vm_bo->evicted = false;
> +		drm_gpuvm_bo_evict(vm_bo, false);
>  		return 0;
>  	}
>  
> @@ -366,7 +366,7 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
>  	if (ret)
>  		return ret;
>  
> -	vm_bo->evicted = false;
> +	drm_gpuvm_bo_evict(vm_bo, false);
>  	return 0;
>  }
>  
> @@ -375,31 +375,59 @@ static int xe_gpuvm_validate(struct drm_gpuvm_bo *vm_bo, struct drm_exec *exec)
>   * @vm: The vm for which we are rebinding.
>   * @exec: The struct drm_exec with the locked GEM objects.
>   * @num_fences: The number of fences to reserve for the operation, not
> - * including rebinds and validations.
> + * including rebinds and validations. Zero reserves none, which is what the
> + * %DRM_GPUVM_EXEC_PASS_EARLY pass wants.
> + * @pass: The &enum drm_gpuvm_exec_pass @exec was locked for.
>   *
>   * Validates all evicted gem objects and rebinds their vmas. Note that
>   * rebindings may cause evictions and hence the validation-rebind
>   * sequence is rerun until there are no more objects to validate.
>   *
> + * In the %DRM_GPUVM_EXEC_PASS_EARLY pass only the validation is done, and
> + * only for the objects whose dma-resv @exec holds. The rest, along with the
> + * rebind and the fence reservation, is left to the
> + * %DRM_GPUVM_EXEC_PASS_LATE pass of the same transaction, which locks
> + * everything.
> + *
>   * Return: 0 on success, negative error code on error. In particular,
>   * may return -EINTR or -ERESTARTSYS if interrupted, and -EDEADLK if
>   * the drm_exec transaction needs to be restarted.
>   */
>  int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
> -			  unsigned int num_fences)
> +			  unsigned int num_fences,
> +			  enum drm_gpuvm_exec_pass pass)
>  {
>  	struct drm_gem_object *obj;
>  	int ret;
>  
>  	do {
> -		ret = drm_gpuvm_validate(&vm->gpuvm, exec);
> +		ret = drm_gpuvm_validate_pass(&vm->gpuvm, exec, pass);
>  		if (ret)
>  			return ret;
>  
> +		/*
> +		 * xe_vm_rebind() rebinds the whole rebind list in one go and
> +		 * attaches a fence to the dma-resv of every BO on it, so it
> +		 * needs all of them locked. The early pass deliberately does
> +		 * not lock the resident ones, so leave the rebind to the late
> +		 * pass, which holds everything.
> +		 */
> +		if (pass == DRM_GPUVM_EXEC_PASS_EARLY)
> +			continue;
> +
>  		ret = xe_vm_rebind(vm, false);
>  		if (ret)
>  			return ret;
> -	} while (!list_empty(&vm->gpuvm.evict.list));
> +	} while (drm_gpuvm_has_evicted(&vm->gpuvm, pass));
> +
> +	/*
> +	 * The early pass reserves nothing. It attaches no fence itself, and
> +	 * the objects it locks are still locked in the late pass, whose own
> +	 * reservation below walks every object the transaction has
> +	 * accumulated and so covers them too.
> +	 */
> +	if (!num_fences)
> +		return 0;
>  
>  	drm_exec_for_each_locked_object(exec, obj) {
>  		ret = dma_resv_reserve_fences(obj->resv, num_fences);
> @@ -444,7 +472,8 @@ static int xe_preempt_work_begin(struct drm_exec *exec, struct xe_vm *vm,
>  	 * The fence reservation here is intended for the new preempt fences
>  	 * we attach at the end of the rebind work.
>  	 */
> -	return xe_vm_validate_rebind(vm, exec, vm->preempt.num_exec_queues);
> +	return xe_vm_validate_rebind(vm, exec, vm->preempt.num_exec_queues,
> +				     DRM_GPUVM_EXEC_PASS_ALL);
>  }
>  
>  static bool vm_suspend_rebind_worker(struct xe_vm *vm)
> diff --git a/drivers/gpu/drm/xe/xe_vm.h b/drivers/gpu/drm/xe/xe_vm.h
> index c5b900f38ded..3fa2c1d721c4 100644
> --- a/drivers/gpu/drm/xe/xe_vm.h
> +++ b/drivers/gpu/drm/xe/xe_vm.h
> @@ -282,7 +282,8 @@ static inline void xe_vm_reactivate_rebind(struct xe_vm *vm)
>  int xe_vm_lock_vma(struct drm_exec *exec, struct xe_vma *vma);
>  
>  int xe_vm_validate_rebind(struct xe_vm *vm, struct drm_exec *exec,
> -			  unsigned int num_fences);
> +			  unsigned int num_fences,
> +			  enum drm_gpuvm_exec_pass pass);
>  
>  struct dma_fence *xe_vm_bind_kernel_bo(struct xe_vm *vm, struct xe_bo *bo,
>  				       struct xe_exec_queue *q, u64 addr,
> -- 
> 2.34.1
> 
