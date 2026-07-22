Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E962C44536
	for <dri-devel@archiver.kernel.org>; Wed, 22 Jul 2026 21:11:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 515FA10E4D0;
	Wed, 22 Jul 2026 21:11:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="hpEiokl4";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB4EB10E4D0;
 Wed, 22 Jul 2026 21:11:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784754684; x=1816290684;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=2QjwQ1Hy3StMDm6Tp+Owsr0H3qDyzDS/s3t68BU1iOw=;
 b=hpEiokl4xvnvJhzjCgJ9hUCMi2Drr+nYX6kB1BYtf7c/ERq4tMg0Jyal
 8yGA4ufGFGtuDMQHLZIYpRIuzc6Vjgkr362e+NFnxenC0Qqw0I+mIM2FW
 uSsSe4ZiA8xzsCA0ltld6l3HRC5wx8tnCHXWuCStMAA6FRQiACdTkBLrD
 VPK5Pwk5/Y7O5WqQbkMDwYF/pZPZm6GlU3eLvoPOmJJf/7V8/MVI50ucu
 f69oqNLBORG2TKAIaLBf3mEKPYqbLxKgV6Ay08MY3TGy0axFimO0Z7LoI
 oIOVwa3Vr+zzPYa6jvZRVgSpZxVIms3bDdhKJ8HoZkIHooxtB7MEWZJw3 g==;
X-CSE-ConnectionGUID: uK3k3I/qQu2YTb7qAXTEWw==
X-CSE-MsgGUID: JdgzO3bKReOxTD+wKETT5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11854"; a="84528872"
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="84528872"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 14:11:23 -0700
X-CSE-ConnectionGUID: i1FejpSrRs+4Fq8z105F5w==
X-CSE-MsgGUID: jlKtAwfKQ1S/HVfVlWdXdA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,179,1779174000"; d="scan'208";a="263158673"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by fmviesa005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 Jul 2026 14:11:22 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:10:30 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43 via Frontend Transport; Wed, 22 Jul 2026 14:10:30 -0700
Received: from SN4PR2101CU001.outbound.protection.outlook.com (40.93.195.4) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 22 Jul 2026 14:10:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Rqa5CQGXMieSq4qGbQMPTM2aMkem/lg9iUSLTXLa4x07hrC+yFP+qEitLRevhPFc97RnifVAl/UCTKCR/G08a/DGwWeYyZiLAY3/uZoQXwJeFxa8b889+lojLphgnY/TVeGxrS75vd6ECRufl0uccxRY49AA80WN7GNubmxr97i7LhbBWI9/Lbmzt9Tim+7P9fhd+6S20mh9bEl6trT9bfJ86kNREDrr996fNv7UuNzSPBbQg6/cXLzHQm0z4ua4BeQPrTNSrl6JEUKmHWSFpe/4YGxwRS3Mq9TVcW7pX7eO6qa8tVcUaHtsvMMw6BlvLitl/g4Wun4rmicepIoYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrv3EwH/Y1yRxMeVY+yDqmmvpkvMsq+zlYh7pI/rn9U=;
 b=y5PB6rsGXydQKLgHxj8yurST/cPtvUtFxf58y8V5um/RBK8QY6xzbGx/+kKi6ve+253XaH52whwGWkGRGPE4k8XjfJsMRRSxO40+zROF+WGtFpXMK6tnDrQLMAWSms7KI9hypWrtxQnymVarzeL+dMzGhLnqxvV8qO99Rok+VF/9TNQAUb5XlTYoxKlxrHz4251Bgwjwv/tPYpcRO2szE4ccCMfnNuMHLoeDgWliFxtyFFyUCw6fqgj3oG6RJVOKfL9OWUpGlule5DgHjyfmsjeDt3wIkql/xpC2ZMMpAlNELdVYIcfHSvMTbffVw6AhgaLllRkyNfbc38TB0Ko8Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by PH7PR11MB7124.namprd11.prod.outlook.com (2603:10b6:510:20f::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 21:10:21 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 21:10:21 +0000
Date: Wed, 22 Jul 2026 14:10:18 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>
Subject: Re: [PATCH v1 3/4] drm/xe/guc/ct: Queue G2H worker before flushing
 it in timeout paths
Message-ID: <amExusdY0Qhs3LIx@gsse-cloud1.jf.intel.com>
References: <20260722004654.744249-1-talesam@gmail.com>
 <20260722004654.744249-4-talesam@gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260722004654.744249-4-talesam@gmail.com>
X-ClientProxiedBy: MW4PR04CA0081.namprd04.prod.outlook.com
 (2603:10b6:303:6b::26) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|PH7PR11MB7124:EE_
X-MS-Office365-Filtering-Correlation-Id: 26df125f-40a6-4237-fd05-08dee835a3bc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|23010399003|1800799024|22082099003|18002099003|56012099006|4143699003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: P9qaIGahUU+NfxbGHZnObdQt3gOFIR6a8+bVRTo6dvFyZTeqzaFYbc7LGDIC8BPdA1fMKvvIREzqo4Xf5aRowdXKDB/gIBa2rYOEReacwaHB7TtGjKi2kx+ZRWZQZZcfIsTDNPnReUNF7M0Z06ZUS5acdK/xIiRSF8VZY1E1l7vrg3lN2rTZ2XDnlYGbF0jMhlmVS6sIkCw0B48qfCd04PdpD7oNm20IQjkrVzRfFbF2ShTZcvnPuKL4NoyDVK6ONTyfIfNA/yEgqUNuBLXuqjkfBcf8ktT2S8SyKEDP8Zhd3omx3iMbLl94Q4OfSURPo8VhF4tqVUmSsMOmX3rq9yh0JaZJeLa1/d+y6Q7eGXhelPxSQ6vsvc2HXFot0ckK6nBTcJlyd9Mabpk9HZWL4OHK+wvNdHi9Tv3JYatrxTUZZENHvTDHCr2tXgayiS9x55+ERExqlW5yLC9ElPyoEzRzVSf2KXwJZGjlqhxDpPCz/bmnAdSAjFFZkJJEfVe54RT+jgV4A6B19qxtjLH8MKX76UN5vqK8gwrJ0j52N+dS3PB0cSYTMZWK7YKeIHOo2K6sFWgwEQnsMo6xFoynDjNnieqMEuKJ3+rSy6MQNQ5NB7ooUS9GFA8e4A1DiR+4aYdi6oJJuyvKePI/cDoPlKj6LsF+Tr6RcFzJbhh3VSA=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(23010399003)(1800799024)(22082099003)(18002099003)(56012099006)(4143699003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?QJpvwMgyryOBCJLWvATI9fgcQUwnKS1cOYalVkWDSh6FQCADCg7xkmiEZX?=
 =?iso-8859-1?Q?uk6anSx//YCJnjWXtJTuFIHGh5xLOXHddUlMT1pAC/8DnE9KsNW9DrpAkm?=
 =?iso-8859-1?Q?I2p/Kh/eztfI+OQUWN1+FAEgAU8dPgiABvxKMdqKg9t/1LGj1bc1Mz/vf0?=
 =?iso-8859-1?Q?QzdeuOjmmKzx2ZrCnzvNpzYMlxNPX06PXXp9N1vuwIgOm+u/nqhQLHtMML?=
 =?iso-8859-1?Q?jegtcYmBxIz/70kicvhaFf2ic7U+aVQUszQgrqYxKteu9RC52l3Y3vM0ir?=
 =?iso-8859-1?Q?es0ACfiKeIwXJPbP61ODkX1aHZF9u05I2AYt5lxZVtZd4Fn2Hs0bJ7ml+P?=
 =?iso-8859-1?Q?VHKA0US+g0PJtRppfXA1xif9wgXS2BOeJmcRpLdMSjM4P0/eWPVARcT8h1?=
 =?iso-8859-1?Q?7XnlrMlvCog465WML0Yoh1QUljduCj6F1BEqfdbJF9dEZJcnnAE0eyUdW9?=
 =?iso-8859-1?Q?RJmxF3nCBkTE8tPJGygtgUmODOUH1QqYBni5STi1hzK9S7pBz9ZEc105Zj?=
 =?iso-8859-1?Q?s8zA0yoAzdxngddgOMy6dc99BaYSDrvqRl5Ex0JFwOzNvHjr8A7y20oMCM?=
 =?iso-8859-1?Q?BSoVP7kKLm0ExHctFcxlhL4dqhDPRHhd593PvNvhMus4kaYmH817Yoy7lm?=
 =?iso-8859-1?Q?qbM2Zg6eWNYlkLj5mSmqdxwIDr1FII9M/cK3P8rn/8sGklng9l0WioxACO?=
 =?iso-8859-1?Q?0s2d/Hqzu7Tmhszi1+mQFWU5fwUEM0nrRwH1nSmZxU1ikrxRNgU4hrONxR?=
 =?iso-8859-1?Q?cIotxEbvT/pCcIIyZm0X3h+/pUYVr1bfmqqnJoisuB7yxrgFcm8fe2yMBl?=
 =?iso-8859-1?Q?E4MIe5JJ6PzwzOlO6f34vpr2M4HeolypQAK2rrzffLsuYRLjsARzNjpAYa?=
 =?iso-8859-1?Q?An+ttO9zKD/Xuz0MoNwQqK3XWBviVAocyPVitFrsDLrlw9CnmwZKSjKbQu?=
 =?iso-8859-1?Q?WBPsg//YKCa2qxU1gzGZrHqi9BJKZpagf3nSLKaie8jIYkNyN5eHZ8a0j3?=
 =?iso-8859-1?Q?/+5sbhr+q1XiN529jSCJrBpbI1mIxumf3H814SGew2WiWehuUE/ybAPpUZ?=
 =?iso-8859-1?Q?WtKNFj8EHJjiQ/EUxIeV13KYVlwf32lR+8hjOht6foZVU2x+wCAZLHyZ/+?=
 =?iso-8859-1?Q?McehEq5cCYYFvJ4S5lMPFKPrh35CtxNN1xW3FHllRisX3SDTGQvRNGzIkb?=
 =?iso-8859-1?Q?mDDwGH4DBc1ccbYTahF2sCp8tckThCIIG20MRZShEN9jsJOUNCbJ9gQlBE?=
 =?iso-8859-1?Q?zDzWB5QjrMRO3kzi25g5+NbrNnsd8sEOgCWMoaJOzPAnVcz3BLKvUAKIq0?=
 =?iso-8859-1?Q?Z08LxMoSfWR2k7QffWZboQoaPSib3Zs8BgxwRFTjUsZ5vr3y+CJZ91TTif?=
 =?iso-8859-1?Q?PzazmZX+aBtMXiSKzjRvL3wBrfKEFXqfWAE3PDWRRV/g/59oIgaElwnm4J?=
 =?iso-8859-1?Q?7/3E/4g+KX+jWswGLAEbrVt5ZOHAQtWlwVNZOwzi4y/QiGl+jHa0Q9mHIh?=
 =?iso-8859-1?Q?nBTXJFTmwDIXQfScgsLa+uVTj4Vyr/1tDMuP1x0KcH/VwY9a4y8QNUAB8L?=
 =?iso-8859-1?Q?NG0V1naxzovIiB3uYWFhTWXis5t7cCQh2FTlyNDq/hlpVndUwcspAtyATO?=
 =?iso-8859-1?Q?FzV4lrRDkPOpY4fyj7FBU9RLjFIeAVVF1JgTAVIh7V68VwGgT9tz6GMM2i?=
 =?iso-8859-1?Q?zIMTljM8M61wjuGyyU7tQ58fdyMy7tlj9aSA8B5BkzbvlpjcA6HYmK3eMu?=
 =?iso-8859-1?Q?fQSGYuA1NUer+/Wq3mPIPIqCnoq6qNBMJhhPdIHrfcsPlb5vBAkB4WKRtD?=
 =?iso-8859-1?Q?LKswWyLYDw=3D=3D?=
X-Exchange-RoutingPolicyChecked: hFK3+hU8EkrRVrmfHFVkRAwQzKJT0mfI9UjUkbv3Y+zuJfdooBoLzeSQmbEqNKz25r4Z0IIfr4xEc+mC6NYA6urriAcP/xPFhNVUQOq8205wwVGsC2UddoAKU2Bw7UZxqGHVm9Yov5N9VcmhQ0A1n4IUfwE8eaiCEWGQb+LdtrfweftfkRXohtvSaA7KC5MaEvknUETXhSacpdkkmNNqPDyXfhCrMunXRh7WbRLbnNjyd3n8IIhlWHxeryjRzE81BU9SiETeCUQoiv8k5hHpr9FgKfBKAGax8ZxegRR1u06wi0/NnoxFvtWwuvPJ+hCnjLv6I/UofMCqgQWv5HqVKQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: 26df125f-40a6-4237-fd05-08dee835a3bc
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 21:10:21.3823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wBnyI1lorS/yGllLvnrJzJKpJnwUABnAjBCzNJx3HjWxP3ME6m8e5MKEPoGRMZ+fEBL2oedIcw7un3h5RjV1/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7124
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

On Tue, Jul 21, 2026 at 09:46:53PM -0300, Tales A. Mendonça wrote:
> Timeout-recovery paths flush the G2H worker to pick up a response that
> may have been posted by the GuC but not yet processed:
> 
>  - guc_ct_send_recv() after the 1s wait for a G2H response fails
>  - the TLB invalidation backend's .flush() hook, called by
>    xe_tlb_inval_fence_timeout() before declaring a fence timed out
> 
> However flush_work() on a work item that is neither queued nor running
> is a no-op. If the GUC2HOST interrupt for the response was lost or

GUC2HOST messages getting lost are a different issue and would be
catastrophic for a variety of reasons. I'd like to dig into that if it
occurs on a POR platform (i.e., LNL+).

> coalesced, the G2H worker was never queued: the flush does not read the
> G2H CTB and the response sits there unprocessed until an unrelated G2H
> interrupt arrives. For TLB invalidations this results in
> 
>   TLB invalidation fence timeout, seqno=N recv=N-1
> 
> with the fence force-signalled with -ETIME even though the ack may
> already be present in the CTB. Observed sporadically on ARL-H under CPU
> load, always with recv == seqno - 1 and self-recovering on the next G2H
> interrupt, which is consistent with a lost wakeup rather than a
> GuC-side failure.
> 
> Add xe_guc_ct_flush_g2h(), which queues the worker before flushing it,
> guaranteeing the flush always drains the CTB, and use it in both
> timeout paths. A spurious worker run is safe: g2h_read() returns no
> data under fast_lock, and receive_g2h() copes with runtime-PM state and
> disabled CT communication.
> 
> After this change the fence-timeout error only fires when the ack is
> genuinely absent from the CTB, making the message a reliable indicator
> of a GuC-side stall.
> 
> Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> ---
>  drivers/gpu/drm/xe/xe_guc_ct.c        | 23 ++++++++++++++++++++++-
>  drivers/gpu/drm/xe/xe_guc_ct.h        |  1 +
>  drivers/gpu/drm/xe/xe_guc_tlb_inval.c |  2 +-
>  3 files changed, 24 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.c b/drivers/gpu/drm/xe/xe_guc_ct.c
> index fe70c0fd85c..11a05c2b8c7 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.c
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.c
> @@ -1377,7 +1377,7 @@ static int guc_ct_send_recv(struct xe_guc_ct *ct, const u32 *action, u32 len,
>  wait_again:
>  	ret = wait_event_timeout(ct->g2h_fence_wq, READ_ONCE(g2h_fence.done), HZ);
>  	if (!ret) {
> -		LNL_FLUSH_WORK(&ct->g2h_worker);
> +		xe_guc_ct_flush_g2h(ct);
>  		if (READ_ONCE(g2h_fence.done)) {
>  			xe_gt_warn(gt, "G2H fence %u, action %04x, done\n",
>  				   g2h_fence.seqno, action[0]);
> @@ -2046,6 +2046,27 @@ static void g2h_worker_func(struct work_struct *w)
>  	receive_g2h(ct);
>  }
>  
> +/**
> + * xe_guc_ct_flush_g2h() - Force processing of pending G2H messages
> + * @ct: GuC CT object
> + *
> + * The GUC2HOST interrupt for a G2H message may be lost or coalesced. When
> + * that happens the G2H worker is never queued and flushing it is a no-op
> + * that does not read the G2H CTB, leaving messages the GuC has already
> + * posted unprocessed until the next interrupt arrives. Queue the worker
> + * before flushing it so the flush always drains the G2H CTB. A spurious
> + * worker run is safe: it returns without side effects if the CTB is empty
> + * or CT communication is disabled.
> + */
> +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct)
> +{
> +	if (!xe_guc_ct_enabled(ct))
> +		return;
> +
> +	queue_work(ct->g2h_wq, &ct->g2h_worker);

If the original queued work gets lost or is never submitted, then there
is a bug somewhere else in the kernel, as mentioned above.

As for the flush part, yes, it's possible that this could take a while
if the scheduler goes out to lunch, but it shouldn't happen with a
sufficiently large timeout. Have you tried making the GuC CT worker high
priority? We could also consider making the G2H handlers RT once those
land upstream.

In general, I'm quite unhappy with the existing LNL_FLUSH_WORK, and we
never determined the root cause of the original issue. In retrospect, we
probably should never have merged that code. Looking at it now, the LNL
flush code isn't even scoped to LNL, which makes this even worse than I
initially thought, as it can paper over bugs. I'm going to post a patch
to scope the existing workaround to LNL and earlier platforms (or maybe
just removing it completely) and see what happens in our CI over the
next several months before it makes its way into a kernel release.

With that said, the patch as proposed is a no from me. If you want to
pursue my suggestion of scoping this change to LNL and earlier
platforms, we can discuss that separately.

Matt

> +	flush_work(&ct->g2h_worker);
> +}
> +
>  static struct xe_guc_ct_snapshot *guc_ct_snapshot_alloc(struct xe_guc_ct *ct, bool atomic,
>  							bool want_ctb)
>  {
> diff --git a/drivers/gpu/drm/xe/xe_guc_ct.h b/drivers/gpu/drm/xe/xe_guc_ct.h
> index 767365a33de..4e0338953f1 100644
> --- a/drivers/gpu/drm/xe/xe_guc_ct.h
> +++ b/drivers/gpu/drm/xe/xe_guc_ct.h
> @@ -22,6 +22,7 @@ void xe_guc_ct_runtime_suspend(struct xe_guc_ct *ct);
>  void xe_guc_ct_stop(struct xe_guc_ct *ct);
>  void xe_guc_ct_flush_and_stop(struct xe_guc_ct *ct);
>  void xe_guc_ct_fast_path(struct xe_guc_ct *ct);
> +void xe_guc_ct_flush_g2h(struct xe_guc_ct *ct);
>  
>  struct xe_guc_ct_snapshot *xe_guc_ct_snapshot_capture(struct xe_guc_ct *ct);
>  void xe_guc_ct_snapshot_print(struct xe_guc_ct_snapshot *snapshot, struct drm_printer *p);
> diff --git a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> index 046d0655122..91960dc4ba9 100644
> --- a/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> +++ b/drivers/gpu/drm/xe/xe_guc_tlb_inval.c
> @@ -327,7 +327,7 @@ static void tlb_inval_flush(struct xe_tlb_inval *tlb_inval)
>  {
>  	struct xe_guc *guc = tlb_inval->private;
>  
> -	LNL_FLUSH_WORK(&guc->ct.g2h_worker);
> +	xe_guc_ct_flush_g2h(&guc->ct);
>  }
>  
>  static long tlb_inval_timeout_delay(struct xe_tlb_inval *tlb_inval)
> -- 
> 2.55.0
> 
