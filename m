Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11C18CD5BD1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 16:55:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A89210E4C3;
	Tue, 26 May 2026 16:55:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="XdV5TZ3r";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D7BE910E49C;
 Tue, 26 May 2026 16:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779814530; x=1811350530;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=86q0wjwMnGRcZh+WJTcR47o6HY1IAjVxAHrA3Ejb0BA=;
 b=XdV5TZ3rIU7dPAWGDOPMDgOc7Q5PvPHyLxN+KyqzNSW/7lIeholg1v4U
 AYHzri5SEOcJiTgAU4I3/ytx8KAZW5RbcnEJrFfUUUC9PZ4gq2gt8sLK6
 +/A4Lg1FyQbAOzS/GF5jvJ38Mhzv7WCQt8LnfqGmieU9h+H02V3UJeRKO
 yg1x/gfg8Tl1JTwfVmA5pwj2H6U2OhvMNe2zI3uNf9gz/rjkYNiVPdUiW
 vfLw5rLiylGhMqyaAQWWGfVCOXQ/eVIbO38W0KFdxNz5v9UkqnzymkP2P
 hgv0MRNFmE4vM4XeBVIOk028XsxAXiwrM7BFb/QvtIGNUxRPzyMxV4cTO w==;
X-CSE-ConnectionGUID: r433fm7mQnu26q8GsYQkqQ==
X-CSE-MsgGUID: zqfuXUQvSJyQFWh+uFlWqw==
X-IronPort-AV: E=McAfee;i="6800,10657,11798"; a="90936736"
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="90936736"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:55:29 -0700
X-CSE-ConnectionGUID: 2HWtuiG2TY6eHpr2HkopfA==
X-CSE-MsgGUID: U1PeYSE6TJaIPbZhNykk4A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,170,1774335600"; d="scan'208";a="246945408"
Received: from fmsmsx903.amr.corp.intel.com ([10.18.126.92])
 by orviesa005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 May 2026 09:55:30 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:55:28 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Tue, 26 May 2026 09:55:28 -0700
Received: from SN4PR0501CU005.outbound.protection.outlook.com (40.93.194.17)
 by edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Tue, 26 May 2026 09:55:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DLVe/Q/T34tK1GBfeCRJeexH2sC3bO0vCCwXE+eI0ftoH8aXVuOAsInovmmkJxOEUMwuFV5+Ttna3p80q9r2x3KyUdMM96XyMz8E/lWu1IfyWmDrU67KGo02+fjrX7I344NxTjC7jxOaa3kL+Ze7aFncplcsyk+e64uIkMvnMq+vX332VUK/afmrEHrrgJFlqTI4Vn5lezIr255QCJ44WUPHjUGYa9tZVx4v41dM70bycoVufIN1yXiiF4gXyUvirTQWXnagia9yHE+Vz4OXshS3MNz8VHI6ZvD97lC0db58VJAiLacnMDr0XZmqHuSUkYlyvA/GLl2bt2+OraQz6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=May0Sz1+XwQ6WsdVU+yfd+MWb/AoteFU662doU4t3Hw=;
 b=WzKrKNuvb56rqSBss3NeF1noa11c77sAKK30P++C+LmCCIyWdsbfhjtG8ZmN1ElZ2fWneHjwlHTNEopHHnjVn+/yZUQhglSj//23aQ2G4bD7/o0qjgYHf0W8ie8QYpnEGaQ0oe8MXhYKDe1W/udnVSMjN/PAvNnvk5yWAPlxwNq0lDnGsj6Z0gr6UKx8g+KRRua+HIJsbUlcjIfPdMmJrI2EFC72L/XLOXi7P9EvTJaNzllA+CGSAwXbNeIzsxMrD3bnCi1l3WuvF+LLrcXJ2kHFW8oiWyHX+RnXAuGkyQOp6UTTlwG15fbfALkBvkjMvXI7L8+UUwMIegkIRDTNRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by SA0PR11MB4654.namprd11.prod.outlook.com (2603:10b6:806:98::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.12; Tue, 26 May
 2026 16:55:26 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%4]) with mapi id 15.21.0048.016; Tue, 26 May 2026
 16:55:26 +0000
Date: Tue, 26 May 2026 18:55:19 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Arunpravin Paneer Selvam <arunpravin.paneerselvam@amd.com>
CC: Matthew Auld <matthew.auld@intel.com>, <intel-xe@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 5/5] gpu/buddy: Track per-order used blocks with a
 scoreboard
Message-ID: <ahXQbk22mSPUOXk6@fdugast-desk>
References: <20260522092600.32818-1-francois.dugast@intel.com>
 <20260522092600.32818-6-francois.dugast@intel.com>
 <e3022ae8-d08d-4114-b6c0-c8f0890a2dae@amd.com>
 <38cc3449-b51a-4b54-bed8-8802e7b37299@intel.com>
 <394c16c1-2c3c-4a70-9d08-1e5ead02b424@amd.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <394c16c1-2c3c-4a70-9d08-1e5ead02b424@amd.com>
Organization: Intel Corporation
X-ClientProxiedBy: DUZPR01CA0098.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bb::29) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|SA0PR11MB4654:EE_
X-MS-Office365-Filtering-Correlation-Id: d35a3bac-059c-46b8-0688-08debb4795cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|1800799024|56012099006|6133799003|22082099003|18002099003|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info: mm/WjG5XAmot1j0r1dQeLtR9wEYtgWvqwpTgGSThSAGyc3hUNurm+O/sBvkNa0KMb/DkzPrZ0G0Gln+wKfYWf9/0wmqo274eNxViKekaUo0VqTrLP6LgqWK5Iv49Xmo/IU3696RqN9p9M/R2CGIjqv+erJK3gYxhQskursSP0ccKBlcPY29SGhLXswxde1JGMPdKehuRk6qblsuy3P0DJeF/zKubymCfffbOYrZUKPHOVOfOdMkp+fA9hbGIswkYcAAKuDfUv8Pm15zqvFkjPBdJ2UAzYfr4qiVWNMeLdSU8Nv0HCi84+B7dF4vl+6LfIf1yJ8yF9xQfpGxCYrUiRLwOWd15LgcPd9HK7XuFtWvtWGwNAMNq2BQHgjpyI6sSr49XwZNPA3F9y+LQepEWV8DV2yJT0O0V8CbcjTpqxnTt0irVdof1rrPJM8qBwaDajFRDrg200iw69z8wlcWLgt8BanPP8BwcrCkGyUdHqx0A8CB6DJuLbq/xs8CwwgNLTy+RR3Cg9CeNhNR+9L9J1wPPMcRnMsEROZTFfUTQFC/HapKeQ2+3iGTwAAtLN2vhuTk6xVHPjAXR5iqWsL8UrtwTxMXoIw2o6R9vAyoE1db0+UgXUA90K1yN1sug1P6s6ufsJXSfiNlh31WoXoyUh7jydnZ2DaMWB1pIIOU/vvu0W7G653RgBFJPx4aphFmQ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(1800799024)(56012099006)(6133799003)(22082099003)(18002099003)(4143699003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?XUT+u35rWjQyJQfXoF0A+HPEFStync4BaK54uRVTCa1+keYazLYNZvuMcl?=
 =?iso-8859-1?Q?1pnQmWdRiTWjqIdFR3KFrT7kEM47w1slZoYNTnVcUkpGxKeGim3m/97ttD?=
 =?iso-8859-1?Q?57G5YlbXkVDzTMcIPAsz0xoLq3nQbUDYybZp4jfuMZV+9sWor6UqJLz0nL?=
 =?iso-8859-1?Q?L0s6t9VN7Un/crV+ETdSlQ3Wg8gH5DEhR+zSOdkXiLa9xfqIXqlvH4MQyR?=
 =?iso-8859-1?Q?19rB5wbqH/nVaSdj8kSThndwTefYJaep1CA7ND+CLA2nKnQvoYouU9pVo9?=
 =?iso-8859-1?Q?G/Xjzd59ruN0nRAcpWOTrLGcjXZgS2JccuXTV/c6Xpb+VzQl47pITDzrMM?=
 =?iso-8859-1?Q?oq9ZT2bTv2Z4yl5Pd3kwu7Jb9SnmTQ4v5rUINMUk0QZo58eSTcKckjX06R?=
 =?iso-8859-1?Q?sBeUsxb2tSBlCwj/lOz/YHH6APwQxT/Cro++I9sX4JMQKGj1fPtQRF5xvx?=
 =?iso-8859-1?Q?yZu/DkYgUxjnOXBdE+pTTEmz1LPq5SIWXQXAFzl+72n/8x3foEA7qWMAkO?=
 =?iso-8859-1?Q?QZF64Z6mQs+BWOaZCRFIiCEOsHNzT1EMvqRgY/CZzzKZyM3E6hfdH3xL/Z?=
 =?iso-8859-1?Q?Lzij7qZMgb9wh67DeBE0mfSoid2t3Qoq9qMDrTSPNJl+5i/Z16wXhsOFF6?=
 =?iso-8859-1?Q?rO/eHjIehAmMbuEX3vzTS2F98fpF7smOI2GKeJEwRFUzhJw1yEg7EjAwbD?=
 =?iso-8859-1?Q?Xw0KLatfSUjc+labZPq+Wq306eBLRi2bbZHJ9PRQEgcWS87oSib+VthsqN?=
 =?iso-8859-1?Q?nNaLoGxHgY51SZ0W+kIYAweUHHMrNwh9KtG/UfoaHhRySCVreQGWXcd7cm?=
 =?iso-8859-1?Q?6SVaoe/fIfrpZIzNcn99rwJmjEkFXSYpd5zKEw1iGMYZt3oPQG6XuQzTK5?=
 =?iso-8859-1?Q?0TuQqZNRiGh2oo4Zg4GA+QllaFkTIz+j20gKY+iwJt8H0+ncKxo8HwpWDw?=
 =?iso-8859-1?Q?aV496NtUba6CWFsI11Y2EQy44axHWq66xMmzMglWFEAkqespEfKYQYuTql?=
 =?iso-8859-1?Q?9KGJBg4lmFH5ek8QontsRVxYwUaCzAQwu6RGDwrfVccyJTF3Fq1oZrk3fi?=
 =?iso-8859-1?Q?G7/kyGRsLd6ydYJLrEvfso74LU1o6rKRzsNlZHhS8TrcoUpqP6Me30OOxD?=
 =?iso-8859-1?Q?xQdX44EDvOfyvVT+eRcy093grUdi11B32DF4y0JAqIY6Zx6Yt83KygGdg8?=
 =?iso-8859-1?Q?m86mO423oyegL4xrGDrhylTzCnmrHy2MkxnW5F89++QCEalGbf5+IsU6Rz?=
 =?iso-8859-1?Q?VjV1+Pja9Ybm317bDLPkcUl45MaiJ85q++Y1mKw8KV9bCXBGr7YgvHvSSJ?=
 =?iso-8859-1?Q?ci7yQ92/fVwV4AZyQ1ej91biD9sBOkmWej6wqQodhLXM6dALYp+18Fwq0j?=
 =?iso-8859-1?Q?8XJFwrWZWTo9T+zo/WFSVq+w/qRxVf98+SqmfG2eNPtsGxNjKVavOFkMDn?=
 =?iso-8859-1?Q?mS/O0s/+e225+yRHf2B3+1QKi8jAuTdCQGvQ4dEimJpaHuKzyUtjul52Ab?=
 =?iso-8859-1?Q?IS/luBajm+eSmseyLkOGTzlv+4YzEkl77ngNz7kbcW+7EVGuPJCZ/kScsw?=
 =?iso-8859-1?Q?uvc9Pc4LK2cbejLX72cZcOdjip/9bwreBY2JyehjZOS4e/veTzldVOO+mN?=
 =?iso-8859-1?Q?LpBrlqhpDruic4cQTypWY48AbbPlFSt0wh8Rwv0emkjDdSVnSagaCRUjAD?=
 =?iso-8859-1?Q?rKEKLCBDdlFJscYegp9X5Q1NFX7Oz52oDPp54SQRZd6yUQvUjOCPgR5zDM?=
 =?iso-8859-1?Q?8C3QvZ3Cs4LKyeIGbDBY46fb09bQDx9GCd9VjpaUwII+XsA145ytlV2ahc?=
 =?iso-8859-1?Q?epCKYyGwcFpEBOa13WNxxHLTkZo8KZ8=3D?=
X-Exchange-RoutingPolicyChecked: jjCaoOw2dawWOyDM8Xbc2EJoEdF6c2iI2q00quT6nVAeTHylfss5jZ90uNUzEpGtcRfbTmqVfHWKy27s3nTrU0G/nYnlklnipNl3MoQdwyaag3pbgYKgfUUECjMLUReixrFlCCKGCV2dAA9kBtifsDKgSOhUlGzJv55aBg5g2lMhwtSAxsngwj6J0z2qVMPe3IGUesxvEiEUmhze/Ojh/i7QY069JSnNKnjoQsYJ6h4f1JIoDhZB1ZKp8alxsnh4YXq2CRMDfun4yI8wmz9iNfpoDC63bwQ0+SKMPUVLbtOEYh49TGh5cFNQH+beVk1oy/tA7dOBg/S+zB7L28d7VQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: d35a3bac-059c-46b8-0688-08debb4795cc
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 May 2026 16:55:26.5510 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sYh6upcW/ZVRMSm8FROlpQoOUtp+cgDMaDN5PEIVYW1Gt+eqNMjAV9yKQHDJyNzOYw8EATbLfbhU8o9UTGQMJXdSFYJX7DEcdBCUfiRnlIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4654
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

On Mon, May 25, 2026 at 02:40:59PM +0530, Arunpravin Paneer Selvam wrote:
> 
> 
> On 5/22/2026 4:26 PM, Matthew Auld wrote:
> > On 22/05/2026 11:25, Arunpravin Paneer Selvam wrote:
> > > 
> > > 
> > > On 5/22/2026 2:55 PM, Francois Dugast wrote:
> > > > Extend the scoreboard approach from the previous commit to used blocks,
> > > > so drm_buddy_print() can report per-order allocation pressure in O(1).
> > > > 
> > > > Unlike free blocks, an allocated block can leave the allocated state
> > > > through mark_free() (normal free and gpu_buddy_block_trim()) or be
> > > > consumed directly by gpu_block_free() during coalescing. Both sites are
> > > > guarded by gpu_buddy_block_is_allocated() and paired with the increment
> > > > in mark_allocated().
> > > > 
> > > > v3:
> > > > - Assert scoreboard is empty at fini(), as sanity check (Matthew Auld)
> > > > 
> > > > v2:
> > > > - Update after fix for use-after-free in split_block() call sites
> > > > - Change goto label to out_free_used_scoreboard for clarity
> > > > - Make drm_buddy_print() and gpu_buddy_print() symmetric for used and
> > > >    free
> > > > 
> > > > Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> > > > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> > > > Reviewed-by: Matthew Auld <matthew.auld@intel.com>
> > > > ---
> > > >   drivers/gpu/buddy.c         | 42
> > > > ++++++++++++++++++++++++++++---------
> > > >   drivers/gpu/drm/drm_buddy.c | 18 ++++++++++------
> > > >   include/linux/gpu_buddy.h   |  8 +++++++
> > > >   3 files changed, 52 insertions(+), 16 deletions(-)
> > > > 
> > > > diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> > > > index de18b63fef0a..dc81fe0301ce 100644
> > > > --- a/drivers/gpu/buddy.c
> > > > +++ b/drivers/gpu/buddy.c
> > > > @@ -194,6 +194,7 @@ static void mark_allocated(struct gpu_buddy *mm,
> > > >       block->header |= GPU_BUDDY_ALLOCATED;
> > > >       mm->free_scoreboard[gpu_buddy_block_order(block)]--;
> > > > +    mm->used_scoreboard[gpu_buddy_block_order(block)]++;
> > > The main consumer of free_scoreboard and used_scoreboard is
> > > gpu_buddy_print(), which is a debug/diagnostic path - it only gets
> > > called during debugfs reads or error state dumps, not during regular
> > > operation.
> > > However, the cost of maintaining these scoreboards is paid on every
> > > alloc and free, which is the hot path of the allocator. Even though
> > > each individual update is small, do we really need to add extra work
> > > to the
> > > hot path for something that only benefits a rarely-called debug
> > > function?
> > > Am I missing a use case that justifies the hot-path overhead?
> > 
> > The usecase I originally saw involved sampling this frequently during a
> > running workload to help collect some running stats. For example to
> > generate a graph of the "page usage" over time. So is there lots of
> > smaller order usage (bad), or do we get mostly larger page orders
> > (good), do we see spikes we all of sudden we start getting smaller and
> > smaller orders, perhaps due to fragmentation? In general we just wanted
> > some more visibility to get a better sense of the "page usage" at
> > runtime. At the moment we don't have much visibility into what page
> > sizes we are actually getting from the allocator, over time.
> > 
> > We originally had this at this at the driver level, but it's not quite
> > as nice implementation wise, plus having it in the allocator could then
> > be beneficial to other drivers? Also the added cost did not seem too
> > bad, it's just incrementing/decrementing a counter. What do you think
> > here?
> Yes, that should be fine and useful for capturing runtime workload
> statistics.
> 
> Regards,
> Arun.

Thank you for the review!

Arun, any objection to merge this? If so, should it go throug drm-misc?

Thanks,
Francois
