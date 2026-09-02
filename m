Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7D18C61DD6
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 05:30:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 09FF210EFEF;
	Wed,  2 Sep 2026 05:30:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="PsvRFMza";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A2E6910EFEB;
 Wed,  2 Sep 2026 05:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788327048; x=1819863048;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=fxWGcE7hDznCB1jOkhbYC6XCYDmEDpvHJPdmhYnS+Xc=;
 b=PsvRFMzaFNAJaASNOr7ovdEvx7u4jVP7ra5xI9DTXysxm3ThAWZ0zFxE
 bianwqLX8yUNIlSZU4PBTDHRJc+0DgTS08wMQCOgQ/7be4DgVdPhVhpMQ
 Sy3v6BMeR/qyolgK0PbZ/jAl8VbX6vQJ6P8BvmqeKwMUqPwE0Hh3BHckB
 LNOQ1xT25CXNNORAg1ihptMwPVML0yRcF7nxKBdXhKNylbwzRu7fIjPFk
 W3aMM1OgIIprgzRdpXx45XiL711uX94+mMy2WZIbEVFqb/hFWv8CPV02/
 bElCUdwv1GrkVHjZG/psBTg82ZgpNFPdEnrTnUehaTrjUwqBNJlW34fm1 A==;
X-CSE-ConnectionGUID: 0h81Jz2SRYmcPP6cnJuGbg==
X-CSE-MsgGUID: oSs3PhjvQ2awpxM9tZamVQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11893"; a="100126735"
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="100126735"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:30:47 -0700
X-CSE-ConnectionGUID: nskHIGLcRlqLR2IN+oGocA==
X-CSE-MsgGUID: vJj13SDpTHe2e7CzHUNPAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,257,1779174000"; d="scan'208";a="269324137"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 01 Sep 2026 22:30:47 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:30:46 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Tue, 1 Sep 2026 22:30:46 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.13) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Tue, 1 Sep 2026 22:30:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kcyE4lu0dAAEojrWj0wven8rdtl79LQM+CZL4gndxJ6hTtOuS1Fvk2BW+Q2hUdKVyjO2cjSbrT1hyk8jDsxi4Hf78aQnI0heIquxx+CeFC96OUZ2vu3hvemq3KB/44OAUnQbbE0+QrcHnlbPqOrgORe9uNeDvmVu7FavbGmxQPzMey16RWo8HI9tVjg/9wreKiS0BWXNB2RU/f49UGVqrmLM2Nk0btRI9y2aiBGZg1B2cQz0GtWXZYQBwOIHLIE4d6Mpc65zf0KpzpugOm3QAHuGE8issK7QapsGyb6YVELkDDe05Gcm0gg5KxtsO6aULasRbANuBECZBkkaFUS7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQfeHUqvq4FnnCl7Z2YmYIdIOxzlcP0dv7TBNRnlRSQ=;
 b=unaqoF2FTiI+mdq0pvDQmMQikOZwACB2mbxWKfVKAVn6cy9ZY7ARWNMJLCB4jAfw/T9e4bfDPO7353jVJZaLFeSZmkYnV+KchEAteJsEWMTg5W7ygr6Hazg/X0Z+lAC/oKnwFMrKuFBk5KN3m2Tbj6BAsN23jLhp2Q0NkyRjvr4DTPAAx48XmW6NdMoLugq+F2RPpGYPcJYuvB5dsjA7X/wv01GR12p+4amnp+gLDvWzoVHOW9m5fNdfppJ2JCvPGQzCBlu3S4kedlUVZq7SgF+DXznmalx335k81ICR9+e9XtcFBoX2QBapSy8KA7i8ooWXpGxbeETw+EsKKNU/cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by BN9PR11MB5259.namprd11.prod.outlook.com (2603:10b6:408:134::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Wed, 2 Sep
 2026 05:30:43 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Wed, 2 Sep 2026
 05:30:43 +0000
Date: Tue, 1 Sep 2026 22:30:41 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Yadav, Arvind" <arvind.yadav@intel.com>
CC: Rodrigo Vivi <rodrigo.vivi@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>, <himal.prasad.ghimiray@intel.com>,
 <thomas.hellstrom@linux.intel.com>
Subject: Re: [PATCH 03/13] drm/xe: Drop queued page faults when device I/O is
 blocked
Message-ID: <ape0gZng5JWbd+Sa@gsse-cloud1.jf.intel.com>
References: <20260827101801.1247654-1-arvind.yadav@intel.com>
 <20260827101801.1247654-4-arvind.yadav@intel.com>
 <apXnb3_WmpYhPeUo@intel.com>
 <ec7667c6-edc8-497c-97f5-872ba5d63bc3@intel.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ec7667c6-edc8-497c-97f5-872ba5d63bc3@intel.com>
X-ClientProxiedBy: BY1P220CA0047.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:59e::9) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|BN9PR11MB5259:EE_
X-MS-Office365-Filtering-Correlation-Id: 8bc78179-5892-4ef1-db20-08df08b35539
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|23010399003|376014|22082099003|18002099003|56012099006|10067099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: qd/k1iWiSPld+DN8dOByZ4o0ZXGHF/x+x+Tx7WLhxj++CtT46cXusmjyQDZ2badd87u0jTUa+P03wAqHhB+P4siRsgnmuEcUGLO0sQwng4Oxb/BOqmrBXgCFpmXW3d+A+1AQIaJJmwRXLpW09OSTHnKErlpLsyPjiaoAirwPn0Rd9sx+7cmEhiz3VGk7l128nMIlz2Sq2A5OISh60OOHOeXUnZgy1O2Kphdq+jTbM5e+Wr1mseV/ASCxeIr+qCJ2+nTx/ihF3YhDoYrsn3DkeSt6LD1LquLcLIURDCS9qw2HBpKvVQhptndwDU+akC20wjPc4gPpgnt/jO0yQVt7FHAj2CWo8Yj1ExQMj5cOZLC7Y7tx5qsvglK+MFci1uJcnaHdQvUfYEeO4PMeIE2xpxJN+8qu2r9SAJ6BOQBX37+Jo2d8qWXmjewTuMR/pTynF7d1qwCfkuRlrBwrIcK7KqsFrs2WxVUwRpzKjPYoJbM+BPcfby6HQJcbk/CCTrb6AdCHEl1gKoLMcsu0t+sGQxo/3I2Gj/NOGJTrrkJDgipIBoUpfgK10r0aQ7jLLtCBMCr60vvcJV+3NDiNP+hV4qr2VmRVVOnxJxxfw9sn8oWxeFugeAD3g424BD2H+/z7VzVETQTMAUDVyiwg4zToE5nkOE+WnzG6b3buF+FPx3I=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?oeTRt7E0Mhe+YpsxnNrFl706b8vygRE3gvVRs9JUfcFYv2Y3ihWzyGz4ZS?=
 =?iso-8859-1?Q?WePLlKRYcGENAPKu8jziFkxTZoiQIvyXOWZyst8uiXvs4bq64c23zJkJW/?=
 =?iso-8859-1?Q?OYfQSje7+Crpy9zERWZjN7yxxp4PEmykFa23uhlt9fcDWiNyFfTWxo9pvf?=
 =?iso-8859-1?Q?EGAjzwzCn+Or9ZC3sC7R4jj7qOSg/NexVZKJqD8nL0XMBSk0/xbayZjvj4?=
 =?iso-8859-1?Q?5ncbQ9n488NajNMRRfKU8m4+/lSaeDqenFhKWoXhkTbcC8b29c28/OMfJc?=
 =?iso-8859-1?Q?i7NHgeKqFMAhx5jfhVhzPt52JCq1UrebJXgRs2Bi+DMzf/e8ZsePoP7SV2?=
 =?iso-8859-1?Q?Ye0mS0HI6QhuwF8xMz8n2LrzGS0A95gUhXqLoEmzTbKmsCrqZYkeCYDLPp?=
 =?iso-8859-1?Q?l7HfRWRL2LAyWZ5Q5e//tbFWpuXjs7NkcyVJVyjBAeO8JoBMerYESj+INj?=
 =?iso-8859-1?Q?ss1aEfN4S+tvJbH0D5SVLGGB+LFxJPNvytu1eN1TyLhSyb2bA1jPgBMgqv?=
 =?iso-8859-1?Q?Q419Rgm9N8buTcY0QVlb8kMy9/+1jv9P54Pbb9fnS6ABLL6MDGlPD6FxJJ?=
 =?iso-8859-1?Q?vn7JLKYuwXM/VaC88z/LYvoRSMzl4RyR24dRMW5PdzAEthULT/xkwN2TK/?=
 =?iso-8859-1?Q?VQU9JZb/BHDVGGW6W6x+WvQ4zDMXCnxPaEM61abep+1sVH/oOvjquHK6Cr?=
 =?iso-8859-1?Q?jXXV9OCuMfo8PxM0qmcXas0YyeMIAFNbYNucodM53CCl+wJrI45vZC5L3K?=
 =?iso-8859-1?Q?UpNtgKzJGqMAr7eDigpLt3ZV64tYn56Ln+rRSF2JyzOPYnvI3P5dRei7F6?=
 =?iso-8859-1?Q?YBPvD01GrmKMzwhVcUTTtz/Ya7XpggL1/zYrj8IcJXH/LJDFRFbd+k4DbK?=
 =?iso-8859-1?Q?GWAB/2+bnWX3KZV5PqBHyGr+tXlF3uhtCJRNWzzXASVNyHuMK8yX3dkwnZ?=
 =?iso-8859-1?Q?WY+USdPY+99Rqgd2AIGZPEvPT1HlHqcV8PMFJO1r36DYJxRcO/8CQw8dsl?=
 =?iso-8859-1?Q?PX8ndUKCDsrjAJK8OgLBNE/dG7ZozHFXTdIlChvTYvrpvTEZbLloeZxewY?=
 =?iso-8859-1?Q?wmVFrhHo61ffOCw0cDWKwwYxaFXqtrt8JwRnZ4zlbWxEK575rllot6bEJh?=
 =?iso-8859-1?Q?YP2lGbyuity2lFUEYsyh8BZyedcdfxwUzBh5Sfy+39D9lmrju3n43ABRXo?=
 =?iso-8859-1?Q?at61il9dFZMG/pEjWPhT4GdomzmKqIkvPzPhNbgT7sdYQBZIuDlSd4b5m9?=
 =?iso-8859-1?Q?174WrMZZiRnoiC0Aw3orD8ogQAmdgdso1nFH9iV7MdbRn+gzvy/g0sO5OV?=
 =?iso-8859-1?Q?HPhntnu8caOSSCD9h36lJ7tqG8/vhPGAAYxTqJxXAQ1FzbwUnLML5tM0OC?=
 =?iso-8859-1?Q?iUBTDhXmTI5EawAkP1Fx9nLl4pvz9PPrMZxlf+QP59wUqngtqvCtJGYg2p?=
 =?iso-8859-1?Q?9+5RmEpSPUcL6eS0+lQVscTHdGRvCLu230fRHZ0mCcdJftWqVrnVCSHixf?=
 =?iso-8859-1?Q?bs8vj4+wLNHudin88IeVlngYe5rLmTb2HoPfFM5Wbr1TCcTcnF7TWwEieG?=
 =?iso-8859-1?Q?9TQ0s2/VDWLivaUsi87w27/to4NUjknUzF0x1Nn/S3y1xF7ERhVbTE2qDL?=
 =?iso-8859-1?Q?fOB6n8BH2RXgPlPt96PLbLg/MdYTvk5Rap808Y/H6zat7vvnCqLhjLj68J?=
 =?iso-8859-1?Q?c2vXSsrrZCW1iJcx0hsfrMEN4dK8/5kyaaEx6ko37jPO65SXajezzcRhr6?=
 =?iso-8859-1?Q?GU9dC/daUdiirPIojJ0v5wjv+IHWDKksDEH4NtMdpi/InPDhOt9IKNKdws?=
 =?iso-8859-1?Q?PGMhiOyU7BW7rERSmwR62mvNsbY72l0=3D?=
X-Exchange-RoutingPolicyChecked: rawkml3EgciQ8wacKsENDEHq+wCevkJU614d1qgyoYqCwbhmSh0nDCQSPQYSRz9rg900DY1gltvxRpY5PH8OylSLmDK+XnFKMmiPoyaJGzjNejUvDnXc/5kuSpWlx11NvBfjAG+mHMPA2/AbrQc+7jX3ivw7zY+n8ttM1IpSYbKmblMFi/ZaBuHFPw7plKjzIQKad27f3RXt4o7BWuq66WKnbesP9TtvnnLHwIJio6nF1pI6OWOmatfQ2cHyJkfJ8ecSpG/2qh/kdTPVq3maXPHWRphklbTMg7P/tw+7WN62fdGvcT7lTT4CwCb79mLK6d37XDFCqGnR8fPl6Ya9ug==
X-MS-Exchange-CrossTenant-Network-Message-Id: 8bc78179-5892-4ef1-db20-08df08b35539
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2026 05:30:43.4138 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: M+BTVPnPvPb/Ubz5LYIf4MiKYB9td1TDH5naAfn0itFrXvHEuBRdJ1dGda8ZZBITr8PqsflyQ7sjjOlgg/0tMQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5259
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

On Wed, Sep 02, 2026 at 10:19:22AM +0530, Yadav, Arvind wrote:
> 
> On 01-09-2026 02:13, Rodrigo Vivi wrote:
> > On Thu, Aug 27, 2026 at 03:47:51PM +0530, Arvind Yadav wrote:
> > > Page-fault work may still be queued when PCI error recovery starts or
> > > the device becomes permanently wedged. Servicing these faults can migrate
> > > memory or update page tables after device I/O has been blocked.
> > > 
> > > Check the device state before and after fault servicing to cover a reset
> > > racing with the worker. Drop the active fault and its chained faults
> > > without sending a hardware response, and invalidate the cached fault
> > > state.
> > > 
> > > Cc: Matthew Brost <matthew.brost@intel.com>
> > > Cc: Thomas Hellström <thomas.hellstrom@linux.intel.com>
> > > Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
> > > Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
> > > Assisted-by: Claude:claude-opus-4-8
> > > Signed-off-by: Arvind Yadav <arvind.yadav@intel.com>
> > > ---
> > >   drivers/gpu/drm/xe/xe_pagefault.c | 40 +++++++++++++++++++++++++++++++
> > >   1 file changed, 40 insertions(+)
> > > 
> > > diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
> > > index 2e415995f067..f486165f2323 100644
> > > --- a/drivers/gpu/drm/xe/xe_pagefault.c
> > > +++ b/drivers/gpu/drm/xe/xe_pagefault.c
> > > @@ -592,6 +592,38 @@ static void xe_pagefault_save_to_vm(struct xe_device *xe, struct xe_pagefault *p
> > >   	xe_vm_put(vm);
> > >   }
> > > +static bool
> > > +xe_pagefault_drop_if_blocked(struct xe_pagefault_queue *pf_queue,
> > > +			     struct xe_pagefault_work *pf_work,
> > > +			     struct xe_pagefault *pf,
> > > +			     u64 *cache_start)
> > > +{
> > > +	struct xe_pagefault *next;
> > > +
> > > +	if (!xe_device_io_blocked(pf_work->xe))
> > > +		return false;
> > > +
> > > +	/*
> > > +	 * cache_start is private to this worker invocation. pf_work->cache is
> > > +	 * shared with fault producers and must be invalidated under the queue
> > > +	 * lock.
> > > +	 */
> > > +	xe_pagefault_cache_start_invalidate(*cache_start);
> > > +
> > > +	guard(spinlock_irq)(&pf_queue->lock);
> > > +
> > > +	xe_pagefault_cache_invalidate(pf_queue, pf_work);
> > > +
> > > +	while (pf) {
> > > +		next = pf->consumer.next;
> > > +		pf->consumer.next = NULL;
> > > +		pf->consumer.alloc_state = XE_PAGEFAULT_ALLOC_STATE_FREE;
> > > +		pf = next;
> > is there some helper we could re-use? I know we cannot use the pop directly,
> > because it would deadlock, but perhaps we can unify some code here...

Why would it deadlock... xe_device_io_blocked is just an couple of
atomics, right?

So why wouldn't this work to squash all faults.

diff --git a/drivers/gpu/drm/xe/xe_pagefault.c b/drivers/gpu/drm/xe/xe_pagefault.c
index 2e415995f067..1c9e5539b90d 100644
--- a/drivers/gpu/drm/xe/xe_pagefault.c
+++ b/drivers/gpu/drm/xe/xe_pagefault.c
@@ -477,6 +477,12 @@ static bool xe_pagefault_queue_pop(struct xe_pagefault_queue *pf_queue,
                lpf = xe_pagefault_queue_tail_fault(pf_queue);
                xe_pagefault_queue_advance(pf_queue);

+               if (xe_device_io_blocked(xe)) {
+                       lpf->consumer.alloc_state =
+                               XE_PAGEFAULT_ALLOC_STATE_FREE;
+                       continue;
+               }
+
                if (lpf->consumer.alloc_state !=
                    XE_PAGEFAULT_ALLOC_STATE_QUEUED)
                        continue;


> 
> 
> Noted,
> 
> > 
> > > +	}
> > > +
> > > +	return true;
> > > +}
> > > +
> > >   static void xe_pagefault_queue_work(struct work_struct *w)
> > >   {
> > >   	struct xe_pagefault_work *pf_work =
> > > @@ -615,6 +647,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
> > >   		int err = 0;
> > >   		bool invalidated = false;
> > > +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
> > > +						 &cache_start))
> > > +			continue;
> > do we really need to loop inside the loop or only check and let this main loop goes?
> 
> 
> Yes, The inner walk is needed. Chained faults have already been removed from
> the queue and linked through consumer.next. The outer pop loop will not see
> them.
> 
> > 
> > > +
> > >   		/* Last fault same address, ack immediately */
> > >   		if (xe_pagefault_match(pf, cache_start, cache_end, cache_asid)) {
> > >   			xe_gt_stats_incr(gt, XE_GT_STATS_ID_LAST_PAGEFAULT_COUNT, 1);
> > > @@ -623,6 +659,10 @@ static void xe_pagefault_queue_work(struct work_struct *w)
> > >   		err = xe_pagefault_service(pf);
> > > +		if (xe_pagefault_drop_if_blocked(pf_queue, pf_work, pf,
> > > +						 &cache_start))
> > do we really need to check after?
> 
> 
> Yes. The device can enter reset or become wedged while
> xe_pagefault_service() is running. The first check alone does not cover that
> race.
> 

But this is still toctou - really everything in patch is as immediately
after either check the state can change. I can't say I'm a fan of any
weak checks in this code...

But just for thought: after this point all we do is CT which should be
down and we'd drop it there before touching the hardware.

Matt

> > 
> > > +			continue;
> > > +
> > >   		if (err) {
> > now this err far from where it is collected is pretty bad...
> 
> 
> Agreed. i will keeps err next to its use.
> 
> Thanks,
> Arvind
> 
> > 
> > >   			if (!(pf->consumer.access_type & XE_PAGEFAULT_ACCESS_PREFETCH)) {
> > >   				xe_pagefault_save_to_vm(gt_to_xe(gt), pf);
> > > -- 
> > > 2.43.0
> > > 
