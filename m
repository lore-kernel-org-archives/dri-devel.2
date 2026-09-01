Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A47AC624D0
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 01:23:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DD85010E2F4;
	Tue,  1 Sep 2026 01:23:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JSGGkiLf";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F40B110E030;
 Tue,  1 Sep 2026 01:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1788225822; x=1819761822;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=0Wc8Wc67zKTp3a0r5jSkocrwqfRpF9xB0j6gGuqTMpQ=;
 b=JSGGkiLfWlJk+QFYNSxRAuvNlsS1wU8BYg3AsqfCLD9+PbFHqAYqhyJ1
 5efnjq3q5l1ugrH3jAfeWAp1udJ/Bg3YN0TpZUaCAIToqzECbaCjNSc+V
 6qTygO2MT/q/+Xq31eDHGqtWq/FeG2ronTObE7Jb0lDYCtrPFq4GGeZ+m
 NpJv2f6zB3QvThOTVuDU1OX/qWFEBqMK40vTtYy+X2on3XLvL6JVkKovX
 tHGcKPa3pvNj93yv+nFEAG/4Qm5TX2DsDoWqInQsKcAm7Nuu7GLE0fhyh
 gvQgU9LFIR2QpSD6JMK6Kiy2h8YzWwIBo/X6ReeMtHYst+M1R1jtMTsM2 g==;
X-CSE-ConnectionGUID: CfBxN5T2Qb2K+pmWG5cHDg==
X-CSE-MsgGUID: QAAfLo7iSnqr9HZYIu3thA==
X-IronPort-AV: E=McAfee;i="6800,10657,11892"; a="88652560"
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="88652560"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 18:23:41 -0700
X-CSE-ConnectionGUID: IJq4rAK+Q4m3EdrUbKiDVw==
X-CSE-MsgGUID: 26feUmhPReia42ELmjomHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,255,1779174000"; d="scan'208";a="264659336"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by fmviesa006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 31 Aug 2026 18:23:41 -0700
Received: from FMSMSX903.amr.corp.intel.com (10.18.126.92) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 18:23:41 -0700
Received: from fmsedg902.ED.cps.intel.com (10.1.192.144) by
 FMSMSX903.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46 via Frontend Transport; Mon, 31 Aug 2026 18:23:41 -0700
Received: from MW6PR02CU001.outbound.protection.outlook.com (52.101.48.33) by
 edgegateway.intel.com (192.55.55.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 31 Aug 2026 18:23:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSFFjWT9qMbWKxazvnTCKmBi0emi+kTBXjJj7BLwkTEtKbaPwm+ZwbbPHp/s4ANZy22VsI474f7PPBmW9+Nq+uc8ozF40spF2WPBvMsxH+lgc43Iatz+uEC+b1NrzSImXJvPHxU0Rg8XGIZWjbLTxh7ZjUIbqlN8YvC1ngq76EIPSdV+MbSOqkBs/JNzkdA4T53zYp1yWE7p7mGDljDsYd7bE5UFgIHbPCTJygVnWDv58rqaujQl74EsOxI7eLz0RMSi8E1+GrvoX6ZX935F+39i8BhJHQ6Zl7YANNn/B3h5wVXosqtFbsUiJxJbBpYkDiF6x/FZSgo6umFfgbSdkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SY9CQs+ps3CGqZTcVFnDI6hIahn84X22jZEmED+5Jpo=;
 b=tLZOqCmUyLLtOaBTyM2mvj/ux1DoRxTI711hhldTQd0RZGN/ESv3Wr8juSEWxWsP7NaZQsxKl+pT4Wi5sDZlAbwvlDlIaDMXCDpWKS5ZvNbnYoK6tsOKTM2FIbGwZ3csYtWUGFsuL3KhNBdOKjf1KxQYp6NBZKMG+ckMlBi0LTgP3DdW6Up9c52dn9AQnLK4a6QhlLP7NZvA7iCxrOoXV0BJ0A6R0tDI6juK0ZAy0EKH/cuZlKFS8zpELV7fp35V26aaW1n1Tld+QDKg2J+eSGpx48odA4+RSgexZY1x8FiL3lvLcFN357g13RnLwTwwBdgR8LTnxdB+CkMR1wGfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB6522.namprd11.prod.outlook.com (2603:10b6:510:212::12)
 by DS0PR11MB8081.namprd11.prod.outlook.com (2603:10b6:8:15c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Tue, 1 Sep
 2026 01:23:36 +0000
Received: from PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c]) by PH7PR11MB6522.namprd11.prod.outlook.com
 ([fe80::e0c5:6cd8:6e67:dc0c%4]) with mapi id 15.21.0360.008; Tue, 1 Sep 2026
 01:23:30 +0000
Date: Mon, 31 Aug 2026 18:23:27 -0700
From: Matthew Brost <matthew.brost@intel.com>
To: "Huang, Honglei" <honghuan@amd.com>
CC: <sima@ffwll.ch>, <rodrigo.vivi@intel.com>,
 <thomas.hellstrom@linux.intel.com>, <dakr@kernel.org>,
 <intel-xe@lists.freedesktop.org>, <aliceryhl@google.com>,
 <Alexander.Deucher@amd.com>, <Felix.Kuehling@amd.com>,
 <Christian.Koenig@amd.com>, <Ray.Huang@amd.com>, <Lingshan.Zhu@amd.com>,
 <Junhua.Shen@amd.com>, <Yiru.Ma@amd.com>, <amd-gfx@lists.freedesktop.org>,
 <dri-devel@lists.freedesktop.org>
Subject: Re: [RFC PATCH v1 1/5] drm/gpusvm: extract drm_gpusvm_hmm_fault()
 helper
Message-ID: <apYpDwBsczVHXGik@gsse-cloud1.jf.intel.com>
References: <20260827071449.520398-1-honghuan@amd.com>
 <20260827071449.520398-2-honghuan@amd.com>
 <ao/nrkOMOllUKqyG@gsse-cloud1.jf.intel.com>
 <bcdc465f-2f83-4fc0-93e6-ed94b076989c@amd.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <bcdc465f-2f83-4fc0-93e6-ed94b076989c@amd.com>
X-ClientProxiedBy: MW4P220CA0005.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::10) To PH7PR11MB6522.namprd11.prod.outlook.com
 (2603:10b6:510:212::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB6522:EE_|DS0PR11MB8081:EE_
X-MS-Office365-Filtering-Correlation-Id: 45a947ed-2241-4356-54f4-08df07c7a1ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|7416014|23010399003|366016|13003099007|10067099003|11063799006|4143699003|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: btJnx5YCYsZSDLzh+KkUUq6znO7f7yIgahSB4H7EeK2BWTj/mqCoAs8ML/svM5z8NBwfDpy5kI4o1L3ON5nvKVxR6Ey7UdfuRxjzm1fmiThvEGMqiCw9PGeahvPAhSEU4RbxA68t4Bu8qmKqjcrUHQyMw0nFr4Oeypyk9qI3CqIDW3Bv/UWLGCluO4fb2FhFX6yJruVOC2gyexZDwt9RBSApQmD9uukEOik75HCEd9FHqcDVl/kkmPNPT6uVI9DbITodzXhs3TLl8vvbXlNL2wRGaHVacRRApkCPQWdDCjlTFlhPGPM56DW9TMWf9cSWGrSjDq+n9tbceDiNpqzANOleae61WV/V037zaft1RxcZNhTsgG6aY+HYajj3/+OARpR1gGKPVnUyeQ7rX2JmuC5Doskym6byxszBzO17xd4nTvvEHwU+UcGgjhoMI3Qiuk/pJS3AqCP1jrBFVTqdzFJlicwEI9yHtuzg341joeyFQOYK9Rp5MlaYPwlCkzsCzLQTexsroSycSpAhTmBW1CbL5Tb6zezWIBBrNndxBPHvE4NkNROS2Nr4smt/VQZfxo8C3mA2mGiq/jeyMVmH54QT9EoS4r5vo6kC+++ZdJU=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PH7PR11MB6522.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(366016)(13003099007)(10067099003)(11063799006)(4143699003)(56012099006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?kOTO2b5X8wsWSqnzGI6oP8U6o42ezt5xSgb4txnMYtXl9TeMjpfl2HeqAg9r?=
 =?us-ascii?Q?PmANGSg5PRUw05w8cMt/zZZ7HGXiYLBlzwu1ghcV2JozztBrAoa6ssfzLpr2?=
 =?us-ascii?Q?TY58M+14HQ0zbbRWzQIyi7Wg3Xdw6CVwuhWSctzLFCNbQLBUJEJ4P2jAVhAE?=
 =?us-ascii?Q?Do6ypZzAk4BWMshbBcRUuImNsDhmCVqwhZjbJZMH2QCJDTe5Kj0DLPhTcd1a?=
 =?us-ascii?Q?nB4xVlpJQqWWPk2K/cxvAS/3Be41cTEFcShdOWUAKKgB6T9NUDSn7jAI7tws?=
 =?us-ascii?Q?TzQuZSLIIwGerZXKxaHBC/nmLzpuaXaPV4XZva7nDtj0bmTvaanXKRWPYhI2?=
 =?us-ascii?Q?rtTTveEDIZf6n7wB6ew2hKkJocN2UhvinPJ+6Ad3u+3SzxvQV0PUiX3F+B4F?=
 =?us-ascii?Q?70wDnDUGtS80Zy74W7JZNms5c7TZVYAAgeEiSM0a8IhkELzSTMe2VMVk1iLr?=
 =?us-ascii?Q?2Ko07wi9KSS1PoP0fbEDqRiGlaBkyi7E2fPlRbKxso1Sn8v/7aSpX59zRIfB?=
 =?us-ascii?Q?8v404UE4RkdSzwi5nN135rebI4b41Gam+EeMu5IjIvZ5Lmsd5DEFFnMHBlZ4?=
 =?us-ascii?Q?OjUqXSXr4W05elhhdmi3DX19aPiQ8uPemvTiYvcyMd/FJmB3JWjYeYIYdiCD?=
 =?us-ascii?Q?Wr2H97mwxLD+wMMoNuaTKqYpaLJwRHkIzKtKoX3umzj/Fch9V3R46dcbvP5D?=
 =?us-ascii?Q?QI79sE36SyRYJOsKrtBMoXqJom4g7wOER9O2cX+pB37oV7I7M3V26nSBhP9H?=
 =?us-ascii?Q?XTeQFeGtRJu4NDIpkDxNgfc+bi2NlUll4e5dqzQu0RN3objg5bSvMbAY3bpH?=
 =?us-ascii?Q?GV9CdenEKXvk0tkHlwUQACXmkRT86IVXX2AhSZlD96uGQXhduRD8lh7b+KN7?=
 =?us-ascii?Q?DvI7HnqohRSbGviOZwYAUSuR41EesdImQsMS3p/9JozfvG4FUV2kbxlDycfo?=
 =?us-ascii?Q?tHewfhB6V690at9Kq1taNEiZfqYaTSKvsy8yOFBlMePXZXMmaIZy+ckW8Bir?=
 =?us-ascii?Q?UipEE+U/inoGzjDKkd+Ezf7euHtFDKJrRUlybgIcS+8HwFaUL85Zhcu4RX14?=
 =?us-ascii?Q?KReknJ0Y16aJou1hKONQAVE9y2uqe99o11a09lydppJUmazdvgltb5LC357q?=
 =?us-ascii?Q?cFR5q25DajSij+hsoI6oCU+pi3VyiKGOanEhDO0I1O7OahplsZBVLiWdl/di?=
 =?us-ascii?Q?pDHga95StQafBRohhgwD+pisymr50MrjHeQpweq8vyVKR8OnCJnweTKH+T/W?=
 =?us-ascii?Q?yNpkuXv+9OzfBj1HO79px0Jf/6dE4C929nEvM/7dpLFJzfzTOg4lS7NL4LtX?=
 =?us-ascii?Q?4zTZ3oUWRCiqN65spHrIAsKVE6iu3E68Aka78SA0VhhcYi+y4WsSJUw3d2sQ?=
 =?us-ascii?Q?GgjfV2yvsG6/G5BLGoXO4k7wM9EnrMEwc1nph/E9qMFMV9ancFPgO2ZbkXrd?=
 =?us-ascii?Q?YxnwSuZWhHcQXmYLF8tfTbDZKowQzsVU5GbVm5qcgeNQSIis68CKAGGXY3nM?=
 =?us-ascii?Q?pGLoIn93dATSRRabX8SsQhEQ/D4j6or6Mlzs3noeQlaoz5ctPs4RWhlgj2aZ?=
 =?us-ascii?Q?QXMFB43qm1xUSjxTmeByNqnABPCJY3Rc/ePkRoWNQFYSN24JFx1GH8qjniW2?=
 =?us-ascii?Q?ISllZYXG2Tbsh81acwK2iFLMGr7JaXuGZ2W6Xi9Y4BHyV0YiMrw4RDwMkQsZ?=
 =?us-ascii?Q?foqicP/p+P0LDbYKawewNW5A9eFCxP7Zvk7OowMeCE8aYSY51wmQeqeHV7f3?=
 =?us-ascii?Q?XDX1c4BL7zqmZY54T51su+JcMFD72YM=3D?=
X-Exchange-RoutingPolicyChecked: t/DMwIkGLyntVVNtcRSaQfEzLRDbZFfV8PLeBVDVG26T6li3gJ2azMT0AEP2vEFRyUybBzKq2r+YEfjbHN6jTKaf1k8mG1YjWvMhPIxViNsiheMJrI8VIIztDbA9Aqe/m87e/IkK32Y0k9c8eTWBTeLrMheBQIl1M2HJWwvAAItCDyEiRdwQz6tIjWHwx08zA/3PAHVZ9eKlOqvhyNgzHIx9bNWxDv9J1VlPUDoKgv0cJjVqgbHQuzHDUcjivI824SlmET+is8JZmJdR8oSYx6XP2vUTjoYxwGtZXzThP75IjNVcFGDswsfZ0sUNWIMVdvW4M+vg7WCLwel+ch91kw==
X-MS-Exchange-CrossTenant-Network-Message-Id: 45a947ed-2241-4356-54f4-08df07c7a1ab
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB6522.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2026 01:23:30.4540 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UOZYJna+O9RUBxmLGGQM7t+G0MGDPoxITAIeXg0V+KXO4I5GjtBOf3RB4IFEos0ia6Ab63dMyt/GIQghdtaA7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8081
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

On Thu, Aug 27, 2026 at 05:02:43PM +0800, Huang, Honglei wrote:
> 
> 
> On 8/27/2026 3:30 PM, Matthew Brost wrote:
> > On Thu, Aug 27, 2026 at 03:14:45PM +0800, Honglei Huang wrote:
> > > Make the HMM fault step of drm_gpusvm_get_pages(), including its -EBUSY
> > > retry loop, into a helper drm_gpusvm_hmm_fault(). The existing logic of
> > > the public drm_gpusvm_get_pages() is not changed, only relocated, so
> > > there is no functional change. Keeping the retry loop in common code
> > > also means drivers never have to open-code their own fault/retry loop.
> > > 
> > > A single fault can later be shared by several drm_gpusvm_pages instances
> > > that mirror the same CPU range. This prepares get_pages() to split the
> > > shared MM-level fault from the per-device DMA mapping. No functional
> > > change intended.
> > > 
> > 
> > I think you might want to just wait on this until Sunday for this
> > series. I think this patch [1] is in the core MM tree so when drm-tip
> > moves to 7.3.rc1, Sunday, we will have a version of this helper to core
> > MM used in gpusvm.
> 
> Got it, will wait until Sunday. Thanks for the information.
> 

It looks like the core MM helpers have landed in drm-tip [2] but not
gpusvm bits.

If it isn't too much trouble can you pull in version of [3] at the base
of this series, credit Stanislav as the author, and then rebase this
series on top?

We can then merge all of this together into drm-tip.

Matt

[2] 121170831228 mm/hmm: add hmm_range_fault_unlocked_timeout() for mmap lock-drop support
[3] https://lore.freedesktop.org/nouveau/20260722-hmm-v10-v1-6-606464dd601a@gmail.com/T/#m68f663ce3e802d7692363c70e6364569134cd6c7

> Regards,
> Honglei
> 
> > 
> > Matt
> > 
> > [1] https://lore.freedesktop.org/nouveau/20260722-hmm-v10-v1-6-606464dd601a@gmail.com/T/#m68f663ce3e802d7692363c70e6364569134cd6c7
> > 
> > > Suggested-by: Matthew Brost <matthew.brost@intel.com>
> > > Signed-off-by: Honglei Huang <honghuan@amd.com>
> > > ---
> > >   drivers/gpu/drm/drm_gpusvm.c | 67 ++++++++++++++++++++++++------------
> > >   1 file changed, 45 insertions(+), 22 deletions(-)
> > > 
> > > diff --git a/drivers/gpu/drm/drm_gpusvm.c b/drivers/gpu/drm/drm_gpusvm.c
> > > index fcfe635bc195..507ef6f0a60e 100644
> > > --- a/drivers/gpu/drm/drm_gpusvm.c
> > > +++ b/drivers/gpu/drm/drm_gpusvm.c
> > > @@ -1442,6 +1442,50 @@ static bool drm_gpusvm_pages_valid_unlocked(struct drm_gpusvm *gpusvm,
> > >   	return pages_valid;
> > >   }
> > > +/**
> > > + * drm_gpusvm_hmm_fault() - Run the shared HMM fault for a CPU range
> > > + * @gpusvm: Pointer to the GPU SVM structure
> > > + * @mm: The mm corresponding to the CPU range
> > > + * @hmm_range: The hmm_range to fault.
> > > + * @pfns: The pfn array to populate (size @npages)
> > > + * @timeout: jiffies deadline for the -EBUSY retry loop
> > > + *
> > > + * Fault the CPU pages of the range into @pfns. This is the MM level step.
> > > + *
> > > + * Return: 0 on success, negative error code on failure.
> > > + */
> > > +static int drm_gpusvm_hmm_fault(struct drm_gpusvm *gpusvm,
> > > +				struct mm_struct *mm,
> > > +				struct hmm_range *hmm_range,
> > > +				unsigned long *pfns,
> > > +				unsigned long timeout)
> > > +{
> > > +	int err;
> > > +
> > > +	if (!mmget_not_zero(mm))
> > > +		return -EFAULT;
> > > +
> > > +	hmm_range->hmm_pfns = pfns;
> > > +	while (true) {
> > > +		mmap_read_lock(mm);
> > > +		err = hmm_range_fault(hmm_range);
> > > +		mmap_read_unlock(mm);
> > > +
> > > +		if (err == -EBUSY) {
> > > +			if (time_after(jiffies, timeout))
> > > +				break;
> > > +
> > > +			hmm_range->notifier_seq =
> > > +				mmu_interval_read_begin(hmm_range->notifier);
> > > +			continue;
> > > +		}
> > > +		break;
> > > +	}
> > > +	mmput(mm);
> > > +
> > > +	return err;
> > > +}
> > > +
> > >   /**
> > >    * drm_gpusvm_get_pages() - Get pages and populate GPU SVM pages struct
> > >    * @gpusvm: Pointer to the GPU SVM structure
> > > @@ -1503,28 +1547,7 @@ int drm_gpusvm_get_pages(struct drm_gpusvm *gpusvm,
> > >   	if (!pfns)
> > >   		return -ENOMEM;
> > > -	if (!mmget_not_zero(mm)) {
> > > -		err = -EFAULT;
> > > -		goto err_free;
> > > -	}
> > > -
> > > -	hmm_range.hmm_pfns = pfns;
> > > -	while (true) {
> > > -		mmap_read_lock(mm);
> > > -		err = hmm_range_fault(&hmm_range);
> > > -		mmap_read_unlock(mm);
> > > -
> > > -		if (err == -EBUSY) {
> > > -			if (time_after(jiffies, timeout))
> > > -				break;
> > > -
> > > -			hmm_range.notifier_seq =
> > > -				mmu_interval_read_begin(notifier);
> > > -			continue;
> > > -		}
> > > -		break;
> > > -	}
> > > -	mmput(mm);
> > > +	err = drm_gpusvm_hmm_fault(gpusvm, mm, &hmm_range, pfns, timeout);
> > >   	if (err)
> > >   		goto err_free;
> > > -- 
> > > 2.34.1
> > > 
> 
