Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AFFC982EE
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 18:20:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF81A10E392;
	Mon, 21 Sep 2026 18:20:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="YDCSKIIc";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 621BE10E90A;
 Mon, 21 Sep 2026 18:19:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790014791; x=1821550791;
 h=date:from:to:cc:subject:message-id:references:
 content-transfer-encoding:in-reply-to:mime-version;
 bh=VF4C4e0f168QlITpB3rX0UetsQeYalQACJXak1GeCUg=;
 b=YDCSKIIcQh5XhkeBxUCLc5GtM90+bP1EL7izbjmpV9/nj9NnXcBDjCBY
 EA8NmJEBIIII4EWFwZotEjWNqRL/dJFv/uKYc0mEDQmYUwmHtO5onhWol
 hLL2oCnVtgsFuxQg1jKMQKj0a7ZCxog6RZkoCD06CooBnuzZ8I94+M4pb
 Itv3KxxxdU1KU0NURlWcGoJSgfEbeogX1Fnio1buLKzn5sj2CAaZYaQjI
 ymRsa2r2xH1ztn5OXBgsxOPLh0rm1qO6tnv1QUjnJ0ruPT7P4IPTE0Qgq
 IH5CzZD7W2+lnM0ypsrOWLG6rxEOnghjJsHQDwvziiwjGcKMtax+ZA75p Q==;
X-CSE-ConnectionGUID: ZqhLmgyLTfK+LRVgyzcgJw==
X-CSE-MsgGUID: JPRbFM87QT+3hKymaE6Xng==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="108055200"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="108055200"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 11:19:51 -0700
X-CSE-ConnectionGUID: jvizcNdpR9ihIik2XoRTEQ==
X-CSE-MsgGUID: yPfVmtLGRk2woupOqc+/pg==
X-ExtLoop1: 1
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
 by fmviesa003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 11:19:50 -0700
Received: from ORSMSX903.amr.corp.intel.com (10.22.229.25) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 11:19:50 -0700
Received: from ORSEDG901.ED.cps.intel.com (10.7.248.11) by
 ORSMSX903.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 21 Sep 2026 11:19:50 -0700
Received: from SA9PR02CU001.outbound.protection.outlook.com (40.93.196.3) by
 edgegateway.intel.com (134.134.137.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 21 Sep 2026 11:19:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r5QBbTAhpVf1AfUbgGga7zz2Y1xJ1NjFy2CXXTUTyNsQ9joKOl8GdjnSXXoiOD0AIGvipzIGVzVPTcmLQkmek8r6uxv2URmxSlfo0jvzCt5m2Vs67XVrBJC3s3XuL0tOAuroCEFdtviG6m+KWJg6W5ibx+46Q/xaqByfgV4oHGKjW1Q3dEmGtPJF0H/oIRg1tT1+9IqHb+f6kOkRbuNmwQShmokEx0iavWDDtoD3gzfhH2+gA8e6MrRJ6p0CEPVpHrWxxG76GAlNWk4/nkMXWGtPc/2sTElbjNWrT25ZECj36BbguHk1rPYo2CtEiXPZ6KGR567G8Pe7ivqGBTu6ag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B8Y+bv2GWmNXKW+Lt6UFL4snKN6lm+f4NcUKjC3QmVs=;
 b=oUILS+gmmmRbn2qD/zKElYAOJ8wVlrZSlvL9JCb9KpgdjSoXae7Re7/YvWMlYaDkmrwU4wnO2RW5ACms3rjZP0UlZC6vgkLDSZ4L3EXNozDOJ7nIiyAGhE3iHyVVFVjFwD2QytjLLZKtB+kl8BLXYOSHa9jzrzojJPOsoe/F9J2P6T9Nj7vOi12HNBittDS+Rk+36nEBe0G/0Sk4uAciRfqi0NFgFqAp3vFlAr6k0bYPH+92FgqGq+XlUmPp1/bCv/ZItePqlOwkC63Xht8jlJGMvA9k7XaR0DsIvGjdx34nShatMsqreGKaDkxCtSDmzopxBjer00qXI9lM6M9kMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4787.namprd11.prod.outlook.com (2603:10b6:303:95::23)
 by PH7PR11MB6796.namprd11.prod.outlook.com (2603:10b6:510:1ba::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 18:19:44 +0000
Received: from CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd]) by CO1PR11MB4787.namprd11.prod.outlook.com
 ([fe80::e7eb:a872:53d1:21fd%4]) with mapi id 15.21.0428.015; Mon, 21 Sep 2026
 18:19:44 +0000
Date: Mon, 21 Sep 2026 11:19:39 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: Tales =?iso-8859-1?Q?A=2E_Mendon=E7a?= <talesam@gmail.com>
CC: <intel-xe@lists.freedesktop.org>, <daniele.ceraolospurio@intel.com>,
 <stuart.summers@intel.com>, <julia.filipchuk@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <rodrigo.vivi@intel.com>,
 <jani.nikula@intel.com>, <navonjohnlukose@gmail.com>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [PATCH v4 2/3] drm/xe: Log when a timed out TLB invalidation ack
 finally arrives
Message-ID: <arF1O5KSYdtWe3qx@gsse-cloud1.jf.intel.com>
References: <20260917163553.1742580-1-talesam@gmail.com>
 <20260917163553.1742580-3-talesam@gmail.com>
 <aq214e+ia3nHVrKB@gsse-cloud1.jf.intel.com>
 <arDA2pUYH7uoUpE2@gsse-cloud1.jf.intel.com>
 <CAHBRX4E4jhtua0kbL43pAg0berdc6bL2Loki9r0c6eP=7s_XpQ@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHBRX4E4jhtua0kbL43pAg0berdc6bL2Loki9r0c6eP=7s_XpQ@mail.gmail.com>
X-ClientProxiedBy: BN9P220CA0018.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:408:13e::23) To CO1PR11MB4787.namprd11.prod.outlook.com
 (2603:10b6:303:95::23)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4787:EE_|PH7PR11MB6796:EE_
X-MS-Office365-Filtering-Correlation-Id: 4dd22c14-45b6-4230-859f-08df180ce939
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|23010399003|18002099003|22082099003|4143699003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: Rkm6Ja58cBGrLDOfvV/Yh8AmXAqA5bIaVcIjxhijJoi2qWoXmNEGWzisoPhDrmk6T5LH4VPeVLLPKtAnqFgolIN7z/bVgqHPWe4o8ZtTRPBqoc6QPSxL9q1MHfU/iqBJW2L3w+SisfSA98bivU73FjKsqz0FEZ6oqKe5mrRVF2G34iatNi/StIQ9Tm3j4O2kJNwyeezhObhghCHzVJZYw/KyD4jVZhnTVFy4EmMSaihBbAVkJrhL91uPxSwRnH6bHiyBbg6+Wnx0k9XJhiKe7zmvQ5hD8AoZCFIUsyZVob0GX0xI3KtriWxG4d2GS2hbJtI65dUzV749gF8Bc2VWS2xomanSO7bLz9AMxMx8AXFe1fmEiB+7JDnh2/DP7j/4SdR32Fyuus/zM/oAvF6noYSiatq8fk0Rlstwx59VTfwz7wpNaEGHXO3BmmxbEofZIa+XBf4y9wwG6oaeWRkZxKRXClokEMMFiLoXC2aqRSCi/zX5hD320VHRM5sfJ9wDBQZt9UJpsT+0HAtF+ycWhp7YDuRk6e9cAVmMDeLzYaDVK4taDPZB9ldEYsoAg/qd8v4TRq4iSCmr7Vz2pgEkJM1h8pLm/Qi+9+wHqikxHn0rvMXzy2Yo1YSCuc9omLk0
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CO1PR11MB4787.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(18002099003)(22082099003)(4143699003)(10067099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?kPc6Oj9Vegf52w2c/HUUobzTvzLvOVTPoxq9DwjO4gBnWC4QyPOou6JdgH?=
 =?iso-8859-1?Q?oN6L+6jrsdf72aySDjkxQuEVDvC76Nrwtei95HZ8IMM246ybdrDx5S3u0A?=
 =?iso-8859-1?Q?h+Ip5VqF2FsGY64pdt0iZIt1vSnze4HX6Qq7lzzIYEYc3Hd7os36nzZBXN?=
 =?iso-8859-1?Q?CeQGHOeOclv+aakitWbsem49079KmyhsURhfLn3ZrpB/dDo7Xi0fd5xD5r?=
 =?iso-8859-1?Q?SOsTSrOX8nRBgKQSC6RskPAgzEJU/OrUxLRwl1ySrooj9WISD7RGc9m16C?=
 =?iso-8859-1?Q?OJPHVkPsZKpcGzfzbo87xLf6rdUN1JM5QZPPidHY2eXYq2XIcbByh2JQwY?=
 =?iso-8859-1?Q?T4KaabfjnLvQr5fyU1xJqKEaOhDZcqaS6B3SMGF3ObNj7pnc1MFgYsF/up?=
 =?iso-8859-1?Q?12SYoW7FMKn0VLqwCFpOBCeHSjndBNwUe+nA9yqYszicnA9Mh3cIvmCvJj?=
 =?iso-8859-1?Q?dl/ozjgQzrgfNrwCIFDyhT3cnsGs/WNIIEj9Qaxe9FOIej+Ozlnrff9dQz?=
 =?iso-8859-1?Q?xtSvPbNzQx/ROTdIQH85ePM5Pxfv5OXvLZdLKSIBckPF2Qe7CMfwGGJxBG?=
 =?iso-8859-1?Q?WFMKRb9APQYHKQSBXswZDyh5L6yVy6MTM+mtnUdYIGRNBk/fjRkP20BtoQ?=
 =?iso-8859-1?Q?9O1mrFILtn+CNj5GB6CNQ5kNd5sHtH9ywUDZyrkftpNJMuYUVuiDOweUNG?=
 =?iso-8859-1?Q?gVvpxs4NhOh7ovm+ipK1KHAiyFWIa+9TdHlzJyvgNeC6pgmZoKUZBIRbSk?=
 =?iso-8859-1?Q?iQLY++V8rB+ZlrgugrYE5Pb0bmZHrc6U8DQl6EsUCfyJeEZFpwGZ48C71d?=
 =?iso-8859-1?Q?HOS4pqTD/cGqXsOes2J6wDjcmEzWx9WBluRmk9f2qLe4CMcnuAPNVdRI+b?=
 =?iso-8859-1?Q?khz8O2hzSUqeVJDwQoZWvzGB4t9m11kW3G2t1NICBcvVZlDu3onrF6iHYh?=
 =?iso-8859-1?Q?PndO5Okml/5xZEDA9biTwSE8yqBr8A09KF/fgyoJAIFa8jp7SwapKNxleO?=
 =?iso-8859-1?Q?PWMVz+2jQf+yi6soSMSRZFoVstQ4Lrf8sTHYZFD7JSglRe/kkTGGg+uko0?=
 =?iso-8859-1?Q?Y4zhyafsUG2N0CAI3Q+JC4oj2hltKbao0Cs//+mkjaS5PTNqeasHk/0SVC?=
 =?iso-8859-1?Q?zZ39gYo4tP4MYRyczQ/fGThgIOq8SKxH574NPc9em9eNZI06mGS8ErDp3L?=
 =?iso-8859-1?Q?ZLlraRI8ed7p8+OIl+cZL2ujL5rMTha95oggl8yrMGbClcc/3vj9YGAtdo?=
 =?iso-8859-1?Q?6aNkyB49lgQSg5hdU3/gSqWAjhR+0ETzEJWUjrh1rmFKGX3db0SEQ82dhV?=
 =?iso-8859-1?Q?Cgh5+fTZhS3dml6+x5dFIqrn8VGwwpCDrgIlAZ1sbuSLtTJTm0ex1rRh+I?=
 =?iso-8859-1?Q?9G3PhcvTNvj8X3RHLgr2/ZQyXoBnuoLIBWX2A7oMIfUI5/ccVtPwYrBrEA?=
 =?iso-8859-1?Q?nL0L5So+t3ah5aY3z/X4WKFvGY3kZ8qPFX6HYmtNsmb36MSp2gLzJwVv6N?=
 =?iso-8859-1?Q?uYN48tOsj1brNBeWdOsQF2foe5rf/Bo2HXbf7WyAO0Y7zwzwZu58fCihy1?=
 =?iso-8859-1?Q?8+tuT+a+pT18U701t44qsoVAHB/Oaggewj5XzXWpEQsulCPrOM9YRcDqsN?=
 =?iso-8859-1?Q?whKAPOU52E/Qi5WIdZZDNEDb7XyWTScVsBYuAholVyuWTIzevSoGTjWxK5?=
 =?iso-8859-1?Q?Vrw4s7OoczVt+vZm8QpipqP1qSKMe7cciwOI9ayXVuMdp6jlHOGYoyCe7p?=
 =?iso-8859-1?Q?vRPxt/BBZpvvYh/85AfXEuZlRHcQUHGI5OopOta/iU28lJ6Sxok81YleS0?=
 =?iso-8859-1?Q?JF7VsYgbb/MvUUuSLaIYWYk1Jkqwrzk=3D?=
X-Exchange-RoutingPolicyChecked: sFAf5qcyxN/p4lycKY6hGm28TrEN8WTl+kpKa3PdDGY7nKJZwBPGiSXeS4VXbHk3K0Pi5Fx9B3o3L2P7mWxYwR2brOr/HDx91iIzM2CoFTU1zhZ2WAaRhrOMNFmHSB3/ag6KJtrWVlQusHt/LT18uKglPaSXtNaQls5oce5NldwoQm5ed1OqxvLy0BurQqDqHYMoBNZ4X7MOQWxcld3Tz7bw4YZbbRJMTH+Fb8cxB+bEo+x2PG7BblboBpzdIIII/IgCLRvvMHm7BhYKQkv7doXYgvI0yLL5EpwxaspaUW1m3aqNaOXmQ+ZUr+gjkr5Zf7NkIclMoKYgGubHyoWQrA==
X-MS-Exchange-CrossTenant-Network-Message-Id: 4dd22c14-45b6-4230-859f-08df180ce939
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4787.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 18:19:44.3465 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: slGFN8YdoWdWuzik0hiei01yOQ11C/tf/mVSC0ERAjlczMqkQ2zGHixQbtjPEdLKETYnqwx51ICHHg8LOFAP8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6796
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

On Mon, Sep 21, 2026 at 03:10:06PM -0300, Tales A. Mendonça wrote:
> On Sun, Sep 20, 2026 at 10:30:00PM -0700, Matthew Brost wrote:
> > I discussed with my colleagues - the we agree the TLB component should
> > hook into SIGID for logging but we will do this as a follow up on top of
> > this change.
> >
> > So this is:
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> 
> Thanks Matt, and thanks for taking the question to the people who own
> SIGID rather than letting it sit.
> 
> I will carry your tag on this patch in v5. Agreed on leaving the SIGID
> conversion as a follow-up: there is no TLB component in
> DEFINE_XE_LOG_COMPONENTS() yet, so adding one touches the log ABI and
> belongs with the people doing that work rather than bolted onto a bug
> fix. Happy to rebase on top of it once it lands.
> 

I think we can stage the SIGID behind this, a colleagues volunteered to
pick this up after.

> v5 is otherwise ready and goes out this week. The only code delta is in
> patch 1, from the data race Sashiko spotted after v4.
> 
> While you are here - patch 3 is the one that actually stops the stalls,
> and it is still the only one without review. It applies
> XE_BO_FLAG_NEEDS_UC to the GuC-shared allocations (CTBs, log, ADS, SLPC,
> engine activity) on the standalone media GT, scoped by a new OOB rule
> (22016122933 MEDIA_VERSION(1300)). The approach was Daniele's
> suggestion. It has been running on two ARL machines for about six weeks
> across several kernel versions, with over 10 million invalidations and
> zero stalls; before it, both machines hit the ~2.3s ack delay 20-60
> times a day.
> 
> Daniele, Stuart, would either of you be able to take a look at that one?
> 

Daniele is out on sabatical, I'll look now but this is typically not my
department but should be able give feedback if I cross code all the
code.

Matt

> Tales
> 
> Em seg., 21 de set. de 2026 às 02:30, Matthew Brost
> <matthew.brost@intel.com> escreveu:
> >
> > On Fri, Sep 18, 2026 at 03:06:25PM -0700, Matthew Brost wrote:
> > > On Thu, Sep 17, 2026 at 01:35:52PM -0300, Tales A. Mendonça wrote:
> > > > When a TLB invalidation fence times out we log the timeout, but if the
> > > > ack for that seqno later shows up there is no record of it, making it
> > > > impossible to tell from logs whether the ack was lost forever or merely
> > > > (very) late.
> > > >
> > > > Track the most recent timed out seqno and log how late its ack arrives,
> > > > relative to both the original request and the moment the fence was
> > > > signaled with -ETIME.
> > > >
> > > > On ARL with GuC 70.53.0 this shows the acks are never lost: they
> > > > consistently arrive ~2.3s after the request, tens of milliseconds after
> > > > the TDR has already signaled the fence:
> > > >
> > > >   TLB invalidation fence timeout, seqno=10992 recv=10991
> > > >   TLB invalidation late ack: seqno=10992 recv=10992,
> > > >     request-to-ack=2314ms, timeout-to-ack=45ms
> > > >
> > > > Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/8678
> > > > Signed-off-by: Tales A. Mendonça <talesam@gmail.com>
> > >
> > > I would give this an RB but my colleagues have done a bunch of work on
> > > SIGID and I haven't been involved at all, so I need some help here.
> > >
> >
> > I discussed with my colleagues - the we agree the TLB component should
> > hook into SIGID for logging but we will do this as a follow up on top of
> > this change.
> >
> > So this is:
> > Reviewed-by: Matthew Brost <matthew.brost@intel.com>
> >
> > > > ---
> > > >  drivers/gpu/drm/xe/xe_tlb_inval.c       | 19 +++++++++++++++++++
> > > >  drivers/gpu/drm/xe/xe_tlb_inval_types.h | 17 +++++++++++++++++
> > > >  2 files changed, 36 insertions(+)
> > > >
> > > > diff --git a/drivers/gpu/drm/xe/xe_tlb_inval.c b/drivers/gpu/drm/xe/xe_tlb_inval.c
> > > > index 7a0c04fac60..7047a347551 100644
> > > > --- a/drivers/gpu/drm/xe/xe_tlb_inval.c
> > > > +++ b/drivers/gpu/drm/xe/xe_tlb_inval.c
> > > > @@ -14,6 +14,7 @@
> > > >  #include "xe_guc_tlb_inval.h"
> > > >  #include "xe_mmio.h"
> > > >  #include "xe_pm.h"
> > > > +#include "xe_printk.h"
> > > >  #include "xe_tlb_inval.h"
> > > >  #include "xe_trace.h"
> > > >
> > > > @@ -99,6 +100,11 @@ static void xe_tlb_inval_fence_timeout(struct work_struct *work)
> > > >                     fence->seqno, tlb_inval->seqno_recv);
> > > >
> > > >             timedout_seqno = fence->seqno;
> > > > +           if (!tlb_inval->timedout_seqno) {
> > > > +                   tlb_inval->timedout_seqno = fence->seqno;
> > > > +                   tlb_inval->timedout_inval_time = fence->inval_time;
> > > > +                   tlb_inval->timedout_time = ktime_get();
> > > > +           }
> > > >
> > > >             fence->base.error = -ETIME;
> > > >             xe_tlb_inval_fence_signal(fence);
> > > > @@ -227,6 +233,7 @@ void xe_tlb_inval_reset(struct xe_tlb_inval *tlb_inval)
> > > >     else
> > > >             pending_seqno = tlb_inval->seqno - 1;
> > > >     WRITE_ONCE(tlb_inval->seqno_recv, pending_seqno);
> > > > +   tlb_inval->timedout_seqno = 0;
> > > >
> > > >     list_for_each_entry_safe(fence, next,
> > > >                              &tlb_inval->pending_fences, link)
> > > > @@ -454,6 +461,18 @@ void xe_tlb_inval_done_handler(struct xe_tlb_inval *tlb_inval, int seqno)
> > > >
> > > >     WRITE_ONCE(tlb_inval->seqno_recv, seqno);
> > > >
> > > > +   if (tlb_inval->timedout_seqno &&
> > > > +       xe_tlb_inval_seqno_past(tlb_inval, tlb_inval->timedout_seqno)) {
> > > > +           ktime_t now = ktime_get();
> > > > +
> > > > +           xe_warn(xe,
> > > > +                   "TLB invalidation late ack: seqno=%d recv=%d, request-to-ack=%lldms, timeout-to-ack=%lldms",
> > > > +                   tlb_inval->timedout_seqno, seqno,
> > > > +                   ktime_ms_delta(now, tlb_inval->timedout_inval_time),
> > > > +                   ktime_ms_delta(now, tlb_inval->timedout_time));
> > >
> > > Should this be some type SIGID message?
> > >
> > > Matt
> > >
> > > > +           tlb_inval->timedout_seqno = 0;
> > > > +   }
> > > > +
> > > >     list_for_each_entry_safe(fence, next,
> > > >                              &tlb_inval->pending_fences, link) {
> > > >             trace_xe_tlb_inval_fence_recv(xe, fence);
> > > > diff --git a/drivers/gpu/drm/xe/xe_tlb_inval_types.h b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> > > > index d77be1aedc9..80d2019fa20 100644
> > > > --- a/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> > > > +++ b/drivers/gpu/drm/xe/xe_tlb_inval_types.h
> > > > @@ -112,6 +112,23 @@ struct xe_tlb_inval {
> > > >      * @pending_lock: protects @pending_fences and updating @seqno_recv.
> > > >      */
> > > >     spinlock_t pending_lock;
> > > > +   /**
> > > > +    * @timedout_seqno: seqno of the most recent timed out TLB
> > > > +    * invalidation, 0 if none. Used to measure how late the ack for a
> > > > +    * timed out invalidation actually arrives. Protected by
> > > > +    * @pending_lock.
> > > > +    */
> > > > +   int timedout_seqno;
> > > > +   /**
> > > > +    * @timedout_inval_time: request time of @timedout_seqno. Protected by
> > > > +    * @pending_lock.
> > > > +    */
> > > > +   ktime_t timedout_inval_time;
> > > > +   /**
> > > > +    * @timedout_time: time @timedout_seqno was signaled with -ETIME.
> > > > +    * Protected by @pending_lock.
> > > > +    */
> > > > +   ktime_t timedout_time;
> > > >     /**
> > > >      * @fence_tdr: schedules a delayed call to xe_tlb_fence_timeout after
> > > >      * the timeout interval is over.
> > > > --
> > > > 2.55.0
> > > >
> 
> 
> 
> -- 
> Com os cumprimentos,
> 
> Tales A. Mendonça
> talesam.org
> communitybig.org
