Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA183CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 10:59:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C94210E540;
	Wed, 20 May 2026 10:59:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="HyP2L+SX";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9C86510E4F8;
 Wed, 20 May 2026 10:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779274746; x=1810810746;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=ETMIxnVhHYQT+myQorI+cc2qu91YtdXdgVKGq6HBOVQ=;
 b=HyP2L+SXa8kkrr8oEirmZV4S6vvt/o9OqmcAYjN39qj4Xp0Nf7FiBcn/
 omYVu3k5mcuOXBieCSu7g9mWcTqEfPqTrFAnPI2fbg5/ekAgApRoBXclk
 SGIEZpPKfwN3yCg5vrXiz27kuOTEkpSrWx+oBpiM8dMcb1xecHz6ESOm0
 Jgp14QSBXTLIdQfspt9pITeGaHBIPa7h445V2AGDIYaTe923DqKaMMpyJ
 ZGr8e01xQaD8eQsJDZtaw8Bru+SWrSCJ0kBW9fNO83CLXX7/QmLH8kAu+
 9rIDLMCE1cj6zg5lCKWbV/BVi5xUxg925Gkd45TY2k/14XkWxyqe/04rJ w==;
X-CSE-ConnectionGUID: 4oMkv5XwQQKzYWtJXA50EQ==
X-CSE-MsgGUID: b2Sv5+DsRE6hXAxmJuSAAw==
X-IronPort-AV: E=McAfee;i="6800,10657,11791"; a="80150056"
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="80150056"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:59:06 -0700
X-CSE-ConnectionGUID: zpwJYcqkRIC8e5IqXHkhhA==
X-CSE-MsgGUID: NqoTNMatQfuxZIqsWn4ObQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,244,1770624000"; d="scan'208";a="240390737"
Received: from fmsmsx901.amr.corp.intel.com ([10.18.126.90])
 by orviesa007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 03:59:05 -0700
Received: from FMSMSX901.amr.corp.intel.com (10.18.126.90) by
 fmsmsx901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:59:04 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX901.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Wed, 20 May 2026 03:59:04 -0700
Received: from PH0PR06CU001.outbound.protection.outlook.com (40.107.208.69) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Wed, 20 May 2026 03:59:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AmfoCXK8bRPqGTV5Dm1FhqaPCEyHhu8CZOxA2AtiwYayjvSr0pVJguigODQn5dgWiyId27F/z5+q1vY16jN9c6HyDTYmpOWM+h3MOoaNANLjUOS27k9Jn8f7wRIhtfU3KJYtFcIMbkIH4bVswRkICrxm9ShXNTAltgZKx/474d6y1oTyEVIkIEvPZB1ENQZ23sBu2ol/VRJ8WTS7ZnbwMKTgy1rhV6rm9tBKMkqU7NcCgmOqOeB7KVz1/CI6MyP4KGbG3KhhgzPmcw3HcU6PwFgqE2RYeSCukiRP8AEnOrCJ1BV3blT9CXcNk6T/RQZsHYz6SXGx7F/52rKbbXbNqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BeWxSrrbjqzeaUYEdmGg4H9Q5AcokyqLxV11BozFwFE=;
 b=PpYitACgOUolmBPDhvZZRNO2vYI+N4aOhXxCNvR6rwv1PWMyQ1ZQg7CrkSpv9rKOPIIlrESRKWFN6akBkTmbsv/xAoT9hlIdcOy6+SvXq8Hi6R+UOeMiloG70mgvg9k8mEswR0LWs8G02S7xCBr1cZ+z3PVRpbGySOLzIfhNQyBufCsnSVOTDT7ayadseb3LNFWvPdB605SJsrW33qPmRPJfzBkLYxxHbAxTs6eoIYEBc/6roT0M+XMgVxCtaW2onnayoRGciabBgpjs45TdEHqAa5tsQjK9+Tk1x5589s2LrNMjRPgBJBCZYhySnQRpdcili9IbGK37xUU5mr26tA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY8PR11MB7828.namprd11.prod.outlook.com (2603:10b6:930:78::8)
 by SA2PR11MB4873.namprd11.prod.outlook.com (2603:10b6:806:113::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9818.20; Wed, 20 May
 2026 10:59:03 +0000
Received: from CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277]) by CY8PR11MB7828.namprd11.prod.outlook.com
 ([fe80::1171:db4d:d6ad:3277%4]) with mapi id 15.21.0048.013; Wed, 20 May 2026
 10:59:03 +0000
Date: Wed, 20 May 2026 12:58:55 +0200
From: Francois Dugast <francois.dugast@intel.com>
To: Matthew Auld <matthew.auld@intel.com>
CC: <intel-xe@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH v3 1/5] gpu/buddy: Fix use-after-free in split_block()
 call sites
Message-ID: <ag2T6DbnGQTUPRDn@fdugast-desk>
References: <20260518141446.124508-1-francois.dugast@intel.com>
 <20260518141446.124508-2-francois.dugast@intel.com>
 <f4b91f4c-6715-49db-8b8b-15711072dfac@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <f4b91f4c-6715-49db-8b8b-15711072dfac@intel.com>
Organization: Intel Corporation
X-ClientProxiedBy: DB9PR02CA0030.eurprd02.prod.outlook.com
 (2603:10a6:10:1d9::35) To CY8PR11MB7828.namprd11.prod.outlook.com
 (2603:10b6:930:78::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PR11MB7828:EE_|SA2PR11MB4873:EE_
X-MS-Office365-Filtering-Correlation-Id: dd138a46-f9fd-4a20-726e-08deb65ecdc9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|22082099003|56012099003|11063799006|5023799004|18002099003|4143699003;
X-Microsoft-Antispam-Message-Info: LyYHmWgblDoHvkbslyffTrgOEpvubce7h5q2jIo1exH0pPp0IGG06WhsGq2x+DnGaITIzf/I50sjRiWy0urBHdn66C6Lc1q6xRa0qRml9jO6J27HgYQvPmj2aZYuHn/7YGe5wJmAJvr4ctGeX4os/bC13wlA9D0ZetJC96tKqCxJeWPy6RySZWw5DH9hl1Ns6ywpQP86rl98uyhj2gEGqC09pHfOG8ygtNCXGJkfbX6hZEm51ghxsoZkvFXvdVaUtoAIsb3p/XTYxjIfLo7/BC63rZ7ZuRWlb9CF6W1OtQzlmhUaVVOoxEsIeyfCuB+HpqzMCmWWRxcFBXrtOGuWt3Qcn/6X2azY6axq92jN2tusTHX5kZSppGKTI5zvG3Hdxkbh1jqRtrELBeUBVA/KWgI+aY5V45iHdNvQvoL40lnZGYM+rrdrvq2l2hl+CeFlkodMUaY1KZBu8wPGO4UtSfuhiXBhNbR+3XuKwLsg/HvIKyUbft3G1+blt+pgmZn5xIv4h8qc6M+sVvBhCJrL237QuGAWSxOExXvaa2KyvIv6MslLBkYKaufDJfY4dzLIpCg7raYmCXalyXjVSHYKIG1bDSSr4fbeFOJpcUcd+BH4WIEugEVKiFIma+3T1pqKJ5Unkne+yDebnnWKNeorq1aNTqFmhoqs+g8l7g/Ale1PWHH2+k5IA7RahsnLuG0C
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CY8PR11MB7828.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(22082099003)(56012099003)(11063799006)(5023799004)(18002099003)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?mnpj3ZqxqL3Z4kRybiM3h0DY2Va6WLh7cei5tibOQwMFMIp2GlkEK0Gcmrq/?=
 =?us-ascii?Q?PK9xDYUYXTXP1TwdWAgudRyBHEYA9js/kneniYB5FbNOlzAfELCPDz0maWHA?=
 =?us-ascii?Q?5XKZYNeT4wP0B4DBkrS/Lj06O7ghwflJdurVfuzR9BvCJ1C6nJggpQsqiauC?=
 =?us-ascii?Q?zyiAM9JJ4crwaG+Y2HF+PLFgMgR4S/m8BG5op/P0459pn+vxzfJu+y59Y1sA?=
 =?us-ascii?Q?CiKOUbybcoeLAQSYkWYXNcAmdoRr638cDwr3zjlVntLvtVd3CwYu71bgarBa?=
 =?us-ascii?Q?bUw633xwSYwHNHPOciARFqTewIPQLgndSprbTZ+jd81cqWqtM28zS9NQYi5h?=
 =?us-ascii?Q?wqp1pNAfAlrFHOrenzuAFDOQe4ZvQOdnRGt3BFrG6IOC5YG8aDzNUb3Hl0Fw?=
 =?us-ascii?Q?cOOViM+X4R1yLm8+m5jSKzO80artq5uxmI+TBo8leIaN6ORCCH0eWvJjGrET?=
 =?us-ascii?Q?cOWN+s+4KBHnFIIaqhGXGzUTs7nNfttTxHLdS9in0Dfu3kgeRmeP+ntbbgYI?=
 =?us-ascii?Q?vDyQF/OlNLBv/du6R8It2Gtls7xjgKH+XXNl8P5EkbgbSg/LSN38fyeXtZac?=
 =?us-ascii?Q?PvAO/iGqBsRrgXanhlsCdUS9SJ1coQez1+cd5KbnLY129o/qq1rZEEeF30/7?=
 =?us-ascii?Q?UeGXaaMB/Vqo5IgxUKswp5NSEaqQPbqI+9lr9TSBcwHZSsBghnXaYz/JZDMA?=
 =?us-ascii?Q?eG3HDh9DeIa/yOllTU6GrcjZaKIjYbhh0JK78ksKJPIY5UUopTLZtOTxB8VL?=
 =?us-ascii?Q?YOm0TkY8XYVdYTbPt9+bgtDoCb5h7ZnaaRk2Ykyq/uYX7Xo4/vuHSMMRRv9q?=
 =?us-ascii?Q?eczUvXm0kv5BDCrZ+zmhGGuCbcqMtHH4+I+0T5HzmayWbRD0NPZ5rInwRP39?=
 =?us-ascii?Q?APwCn0YMBN1ZNOE/rtTEQ1SCrFx4SgywIl+IA9maUGn26O4G+JJ/+bA3geOi?=
 =?us-ascii?Q?82QPqdfDi8aSVhU0pCVJNv0qf36zGW7a1y5QRXAyyPxT1FSFB+6uDfYg9HoA?=
 =?us-ascii?Q?4niN2UfS1ME7ILPZrPmIUafDm1vIj+wg3fH7EaMCxW7pdJfqpCY98OYXEZIl?=
 =?us-ascii?Q?TzhtKYaRbEcR+a1v5a8+YWdgikKyQG1ykQ0voI1Bd/AEk1OucBVcJJ2UNYk3?=
 =?us-ascii?Q?oMH3wg4L9NdalW+9SA0hCZTLuQOOSwOtQY6IVWA/Rvik9zvVoizPNj2OOFC2?=
 =?us-ascii?Q?Q8VVloiCeSlVPNRcsRPxBOoh4IcDVMGRo575ZYp1d0KRAjBkvMCZjTkZnQ/5?=
 =?us-ascii?Q?cpAJ45rrdjuXeoQ+N4IU39sG5Iw/8j0gAVG29/jH0Ca3Tqqx8QkuVIbXAuDO?=
 =?us-ascii?Q?PXktUaWi0Uc2XMOyIU25Xgv/gb8Bwj0u4Qs+tyEkzyGIDpDglYO+vAOrebgP?=
 =?us-ascii?Q?MWwEewFIjJKbjFe0FQUIxJju/0tKmM0ytExf7G5ldT9Vip/zHq752nEBi9hF?=
 =?us-ascii?Q?YrFlewegHJdQHoZsnDa7YFOUO0ljsFLvThW4fy0pF3mRqdlHfnTCdRjbrqoU?=
 =?us-ascii?Q?yTQXg11X+YXOzxLGQtF3XOvXYHsXYikdWAbGEVyPbLQ65Re8HkbrMdOgk9/S?=
 =?us-ascii?Q?ytzxdVmjqGfxrlju5vxb5w8iudqRYP959Q14ohSk2tWZiZqol2QQQmfDBm/e?=
 =?us-ascii?Q?FvLoPRbQjteXspWJs8Oa+B8CZO1PSNGtbwHF/AlMiCdqJXAJnGFs5CIsb4wk?=
 =?us-ascii?Q?kB7CYUWpEZNIhGk5lnYPxqKtXuR7Ri6rdYTG7M69wm3RjfY9zZZytLiyXRcp?=
 =?us-ascii?Q?HPwjOfvPPY5DKJq4tEbGRUO3HKPC6eU=3D?=
X-Exchange-RoutingPolicyChecked: g/4mudv0gsyRwJ+xSN0SppClaKD6pwSpk5Wfv/NmPTZBZWT5nmRp/MTI99Mw/iCYvvqOyz0A/dJP+fPYs/9ui8GAuPFIsL9yY7WlSFUorA7FfJ/MmVZwco47YAiQwS8KMJSbMbpG6PlnKD1vTNA+IdV8LyW0Iobapv7ylcD8fFqbVnaZX6taelVKysSF7L/octGjzlLT/zgvbaqVz2IRnHuNowSSyrR2Du7gLhnNbJAfW0HLru+mXywY0JeFRZ3oucFdMgH6lRGpevst2jDNmha25E5g8T1NaNWOTvGWkRlTe9w4aJVTlv6mzhXiBeAYahiwGFenCFoEZFAcZfS1/w==
X-MS-Exchange-CrossTenant-Network-Message-Id: dd138a46-f9fd-4a20-726e-08deb65ecdc9
X-MS-Exchange-CrossTenant-AuthSource: CY8PR11MB7828.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 10:59:02.9989 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6Lp9Ia2sc0MZ/90/kPihMh/1Oj4CVCpxMo6/D+TylxeQEkBdZIsAzvG0Vx52ztoOfh/SMnx7c128Q+uybd0k6PR/6IsG0Km4PYLuqygFJgg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4873
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

On Mon, May 18, 2026 at 04:55:12PM +0100, Matthew Auld wrote:
> On 18/05/2026 15:14, Francois Dugast wrote:
> > When split_block() fails it returns before calling mark_split(), leaving
> > the block in the FREE state and still linked in the rbtree.  The four
> > err_undo paths then call __gpu_buddy_free() without first removing the
> > block from the tree, which leads to two distinct bugs:
> > 
> >   - If the buddy is also free, __gpu_buddy_free() merges the two siblings
> >     by calling gpu_block_free(mm, block) while block->rb is still linked
> >     in the tree.  Any subsequent rbtree traversal will follow the now-
> >     dangling pointer, causing a use-after-free.
> > 
> >   - In alloc_from_freetree(), where there is no buddy guard,
> >     __gpu_buddy_free() always reaches mark_free() -> rbtree_insert() with
> >     block still in the tree, corrupting the rbtree.
> > 
> > The same pattern is already used correctly in __force_merge(): call
> > rbtree_remove() to unlink the block before handing it to
> > __gpu_buddy_free().  Apply the same fix to all four err_undo sites.
> > 
> > Reported-by: Sashiko <sashiko-bot@kernel.org>
> > Signed-off-by: Francois Dugast <francois.dugast@intel.com>
> > Assisted-by: GitHub Copilot:claude-sonnet-4.6
> > ---
> >   drivers/gpu/buddy.c | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> > 
> > diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
> > index eb1457376307..dac2027bb64a 100644
> > --- a/drivers/gpu/buddy.c
> > +++ b/drivers/gpu/buddy.c
> > @@ -737,8 +737,10 @@ __alloc_range_bias(struct gpu_buddy *mm,
> >   	buddy = __get_buddy(block);
> >   	if (buddy &&
> >   	    (gpu_buddy_block_is_free(block) &&
> > -	     gpu_buddy_block_is_free(buddy)))
> > +	     gpu_buddy_block_is_free(buddy))) {
> > +		rbtree_remove(mm, block);
> >   		__gpu_buddy_free(mm, block, false);
> > +	}
> >   	return ERR_PTR(err);
> >   }
> > @@ -847,8 +849,10 @@ alloc_from_freetree(struct gpu_buddy *mm,
> >   	return block;
> >   err_undo:
> > -	if (tmp != order)
> > +	if (tmp != order) {
> > +		rbtree_remove(mm, block);
> 
> Actually, I think this needs the same checking like elsewhere? Say we fail
> on the first split? Nothing was actually split, right?

I think this is unnecessary: for block this is tested above with
BUG_ON(!gpu_buddy_block_is_free(block)). If split_block() fails then it
happens before mark_split() so block remains free. If buddy is not free
then the merge loop is skipped in __gpu_buddy_free() but mark_free() is
called so we do remove + re-insert.

Also, the checks are added with patch #3 and the introduction of
__gpu_buddy_undo_splits().

Francois

> 
> >   		__gpu_buddy_free(mm, block, false);
> > +	}
> >   	return ERR_PTR(err);
> >   }
> > @@ -968,8 +972,10 @@ gpu_buddy_offset_aligned_allocation(struct gpu_buddy *mm,
> >   	buddy = __get_buddy(block);
> >   	if (buddy &&
> >   	    (gpu_buddy_block_is_free(block) &&
> > -	     gpu_buddy_block_is_free(buddy)))
> > +	     gpu_buddy_block_is_free(buddy))) {
> > +		rbtree_remove(mm, block);
> >   		__gpu_buddy_free(mm, block, false);
> > +	}
> >   	return ERR_PTR(err);
> >   }
> > @@ -1054,8 +1060,10 @@ static int __alloc_range(struct gpu_buddy *mm,
> >   	buddy = __get_buddy(block);
> >   	if (buddy &&
> >   	    (gpu_buddy_block_is_free(block) &&
> > -	     gpu_buddy_block_is_free(buddy)))
> > +	     gpu_buddy_block_is_free(buddy))) {
> > +		rbtree_remove(mm, block);
> >   		__gpu_buddy_free(mm, block, false);
> > +	}
> >   err_free:
> >   	if (err == -ENOSPC && total_allocated_on_err) {
> 
