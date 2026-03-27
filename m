Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DF710ED675
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 13:26:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1336A10EE78;
	Fri, 27 Mar 2026 13:26:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="BFpzi7Me";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E825210EE78;
 Fri, 27 Mar 2026 13:26:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774617993; x=1806153993;
 h=date:from:to:cc:subject:message-id:references:
 in-reply-to:mime-version;
 bh=GnCVIJkZS7QyfoPghiPc/V12nV02G688FanyOG5ik7w=;
 b=BFpzi7MeKzoO6ljTqGyY9GoT2HDWLqs4luabzLhQLhwvHcme3MKb42VA
 D4g5AScRzn9WPC08ahZK9JQq/UOBbPk5LlhUuGTMqIGNyeKeMRZEpiEg0
 76JyYpoAi9VG7el74dCFmNP8hnwjh0hgBcEOYaGkKs2lF8JnbwshPPsm1
 Sq832gIP9/M1K+M0KmOk5iTK40uvgGd1c1Dvmzy7Lgwi8sk/sr4fzCt+L
 UpEhXYH5+/5uqnD9tvlDGdqIsifLFZ2rR2hU04zL+ze0yVtOWWdHQV+6R
 WHFlWrf8rjlefLDlR1r1RPBgc623dUQ1g4d20qpnO3aM3ivXkfzRVGJNa A==;
X-CSE-ConnectionGUID: iKCK8S/iT6mJYm8S/fJ8XA==
X-CSE-MsgGUID: DGqRwB0LTAK+imLS2TwRdg==
X-IronPort-AV: E=McAfee;i="6800,10657,11741"; a="63244933"
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="63244933"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:26:32 -0700
X-CSE-ConnectionGUID: VptALvPvSfWR3eJFnYmOyQ==
X-CSE-MsgGUID: DlEV7MMMRyy756UfIyzfAw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,144,1770624000"; d="scan'208";a="229391517"
Received: from fmsmsx902.amr.corp.intel.com ([10.18.126.91])
 by orviesa003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Mar 2026 06:26:32 -0700
Received: from FMSMSX902.amr.corp.intel.com (10.18.126.91) by
 fmsmsx902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:26:31 -0700
Received: from fmsedg903.ED.cps.intel.com (10.1.192.145) by
 FMSMSX902.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37 via Frontend Transport; Fri, 27 Mar 2026 06:26:31 -0700
Received: from DM1PR04CU001.outbound.protection.outlook.com (52.101.61.18) by
 edgegateway.intel.com (192.55.55.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Fri, 27 Mar 2026 06:26:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CCrPGpkuGCghhIpmp6Vx+oJNE2FFeohuLzs0WNH8m/gQEMrS9FjQWkNrMC+gdvTXnv5JvtSkoNcLlNsKtxQ/8z+A9wp3N+lAdLZ8QW58M0vYGhv1W/vg3ezs2jszXJmY5s7CCIlfHumjJFM37P3zkTPb2ErqxMc7znO+jSdehnoUV8oyZYLG/M9LRN5CyFczFWySXEceHl2rfeqFN3Ajs6VoJYTcxqa/aEKDVdz/nAiUNwep/lIJUZe4k1VzWx8O1GXJe4mVDO2UaSkQY9hM6/TYcU0osekVCukZN2T4nwCLUY1dHKRscRbgjb6RYz2W5BbtDDW4/SeSGH+w1w6QUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nn2b2zGio5BJVnGZWYwEWhP1M7fohSsSFsKLGeZreQg=;
 b=RitruE4U0euLVA2DNX2JRkoMfUdJ1oOBFZAXrQycaJKFzxX4+gtrw4pTV9bo9Q7gKM9DDpgSnLZSsfcZGx7TD4uq7b87TzZih/vnlIYXkz02dtMQGfuA/6CrLfV23pjvVyst6w97yU5Db9WUqs0o6Ul/MWfBzrzMaASR1AzC7K4JPqmyplp9IflYpRJtlpVA26AtD/k+I7Q1jxe/7ciXbm/8UGromg3drSodmYh34lmcgSMWh00+vC0dSLhcHz7O5kbYHYld2OnXfE23WstXYoyazepcAZg2gjDWZQCECeXvZt/tZ6r1faouvGCcKcBG+xF2ZvRr1R6gXWMdmSXh3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CYYPR11MB8430.namprd11.prod.outlook.com (2603:10b6:930:c6::19)
 by PH8PR11MB9807.namprd11.prod.outlook.com (2603:10b6:510:3c2::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 13:26:24 +0000
Received: from CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d]) by CYYPR11MB8430.namprd11.prod.outlook.com
 ([fe80::1d86:a34:519a:3b0d%5]) with mapi id 15.20.9769.011; Fri, 27 Mar 2026
 13:26:24 +0000
Date: Fri, 27 Mar 2026 09:26:19 -0400
From: Rodrigo Vivi <rodrigo.vivi@intel.com>
To: "Dixit, Ashutosh" <ashutosh.dixit@intel.com>
CC: Michal Wajdeczko <michal.wajdeczko@intel.com>, Satyanarayana K V P
 <satyanarayana.k.v.p@intel.com>, <intel-xe@lists.freedesktop.org>, Piotr
 =?iso-8859-1?Q?Pi=F3rkowski?= <piotr.piorkowski@intel.com>, Matthew Brost
 <matthew.brost@intel.com>, Thomas =?iso-8859-1?Q?Hellstr=F6m?=
 <thomas.hellstrom@linux.intel.com>, =?utf-8?Q?Micha=C5=82?= Winiarski
 <michal.winiarski@intel.com>, Dunajski Bartosz <bartosz.dunajski@intel.com>,
 <dri-devel@lists.freedesktop.org>, Robert Krzemien
 <robert.krzemien@intel.com>
Subject: Re: [RFC v6 1/1] drm/xe/pf: Restrict device query responses in
 admin-only PF mode
Message-ID: <acaFe55XHfo39z-y@intel.com>
References: <20260316064100.2542412-3-satyanarayana.k.v.p@intel.com>
 <20260316064100.2542412-4-satyanarayana.k.v.p@intel.com>
 <875x6lq64y.wl-ashutosh.dixit@intel.com>
 <8d140cfb-ad38-4548-aec0-89581c79d8e5@intel.com>
 <87341lzvhf.wl-ashutosh.dixit@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87341lzvhf.wl-ashutosh.dixit@intel.com>
X-ClientProxiedBy: SJ0PR05CA0185.namprd05.prod.outlook.com
 (2603:10b6:a03:330::10) To CYYPR11MB8430.namprd11.prod.outlook.com
 (2603:10b6:930:c6::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CYYPR11MB8430:EE_|PH8PR11MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f807e35-9592-4af1-439f-08de8c047113
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|366016|1800799024|56012099003|18002099003|22082099003; 
X-Microsoft-Antispam-Message-Info: +G/KybuvFCJRO3Ec6phCdg6wRkWwXV86q6YGR/HlRRKXpjOJfh0EGkyvr+lU/ol+iteRglPOD1SbWoS/4WKIY5gVFXuroBHDY5refgxwyHfzYs/awUBRnui5Ni1x5t8yIf2QjvJDeHjVOwvToTI7aCwsZNiekpV7Y0MEYTiVVhzl5Pj8XP1bYdLnxyKVuuKQDPj2hHbf6un6yraRkzxeIZZ/ZtIJDvyeBKSsMyspZGQVHiueBgR17GSHzazJF0YNDmrQNc0nU1PqxW0WZBvM2jCmllMMXWmgjgL4Qba/5yt6WJE/6nGGGhLykgyCukmZ/hdZArOE2yO5bHs2mkYRnYdug5uM8I3MOYfpbR3WQVKCFLeTDdDT5e03qpGbmdAvaNkXazXHKDmAjLoH0rvC3+HjpNdxe/a8oKkF0wMFZY+o67AqEgxxT1d2IrdT6kzDg64oAkscR+SZiP33mVTnwS7YSLmVICK6GspF89pKQT35v9KrV/hC/PWdzRxMvve7Q2ZQmULjmi25co/AzacuntkCwsU7IClfBto/6q76AV3Bj7FB36Jh3pHiK8OBqyiRcrscqmsKPqruVb7vmWzfNB/lidIk1IVMqzyjK8aDLBz5PrtfowMzThmLqK2fz3YjJ/C8lY0s7MzUyMZzhCZ6w2ghADCFc+bOL1i/14WScHmz9UQnsXrRacVRZSPWPUZZ
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:CYYPR11MB8430.namprd11.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(366016)(1800799024)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XzFpGLMkOFpCJmlsxk5Mhlh5PFl1h85thFqXUCzHZnAhoQ5XcXS1GTlj/4QE?=
 =?us-ascii?Q?ZotVeSmC1FPF6LrRRkdS4qOwP06fZrMUiJR8GWR2ef2F/GUZRGb4ujplSNtv?=
 =?us-ascii?Q?8G8k7tQz15qxwgpPHQ8wfDRoBWJnOnWnomblNa4oZFpGKj3NeEz4vl8FOfw7?=
 =?us-ascii?Q?PGq2wStMTHdudjTfv2ww4Dgh1GHDKY1MzA82G3z1NREj9RyTz9k8phc5lHtA?=
 =?us-ascii?Q?cNHWjkG9dkR9YFJmH0XGdhwuKVPJGCwLCkRC4Oeyb+Zk/BhklhzoNMEKpIDJ?=
 =?us-ascii?Q?S3Rii2GmRxBPOY6WmCH9khdOx/vEb8WvTHyGKovztYsiGzzsItwIpNSolgZL?=
 =?us-ascii?Q?lZYjBHB43Ffic8ElU1vgL4Q8vqICouPbC7RECpKE5fCzbC0UHeaB+W+0qmIn?=
 =?us-ascii?Q?mrT9hJEmeigsnHfKwqTd06uYPrE1gQyD+oEkqd3IL4r3aHnmcBSCabBDQKuU?=
 =?us-ascii?Q?L9pDL86LMe+t4JRaAUtnvh2QV6o6r6PTBNYPBd/XMmzgzDOx3jBi9EAljpZh?=
 =?us-ascii?Q?V/U1ElRMAVwS0SyWiPFqeNpwhjavSHp0diqrXQ7zuOHfr0rADErhUb+aA7Tw?=
 =?us-ascii?Q?Lm6TOaSvog25kXB+TI0cdykeLS2NjfrgSmJbOWmaPcZGcR2nQr7v/B1OxYAF?=
 =?us-ascii?Q?S63m0+RS3cihkyY/5U6zIAP2WihVW95OuGlsWfkngwjOaFoHRn5ai+tHIEkC?=
 =?us-ascii?Q?ymlYzj/2lUHPJwCeBvjUsN6OF/5TGxS7jGaXBVv1sQ9405IkkVRN7Hnyo/s4?=
 =?us-ascii?Q?FEDhSn0tG8V2K8N5Yj41eHlayO4MzRf367Di++0wAiQgQguyxZs+D0NnWSzJ?=
 =?us-ascii?Q?jPL0ZDRlwLm8ranNuJrqlbSF6q6FrvuS/b5EjOBnaVmF79bO+t832z1OuCHT?=
 =?us-ascii?Q?J2D7I3pBhml5ojM4Y+8jIbC8yx9QxbSLTgt/X4nFienj6J+9qXovSJENCpRu?=
 =?us-ascii?Q?3HuU9njYmUMJG8qVxkm5GzVegNGrRtWixAr51kT1ib/Qv9xksuq5s/tMrRb+?=
 =?us-ascii?Q?V1/cl/FMHYNYqR03mTcZ4RZggpwd0Ac5m9iJe1TAv6EFhzElVZfCG96thEbW?=
 =?us-ascii?Q?Sw/HwP6HVf+kbicsrKHQL4Dqj2mjPyLNE+KFSI2+wzw445QXpkcsWoVz9cRv?=
 =?us-ascii?Q?99BpaUPUF80oO8Q8NJlubxrPJ8o13/Ll46q4j/UriEr9ges+VUVVcmX8bRzL?=
 =?us-ascii?Q?caHTqLEhZCViwfTcMF9XpTOkDBiE48vzs83W7dnS36/bT/+/cY0L4ZPge2dg?=
 =?us-ascii?Q?fklfTLSZz2evx6ub8B//lVgoSpfI1yyNV+X3w5XeXXmE4Qyrg8uhKyxszZ2o?=
 =?us-ascii?Q?QG5uHqjGM/Lt6uAA7v3Pz90OBovJTJS6VLg9INIvrMl8nrxtY4RXW3MuVGE3?=
 =?us-ascii?Q?0oXctbVs5tPdHgNlBKGlO7bBjfiHULY75jcc2lSBsU5C5re4nJxW9ifAYYw4?=
 =?us-ascii?Q?0wiEk74hEMWgsGnWwy0rfZu3YCGxFb+BbUAbgX3CtG8lSDKtZyeHHtuh/UA1?=
 =?us-ascii?Q?yWZLUZUaIwj8Jfzd3xRlYFaofHj6g0QLBvlD8zmPjO1e3a6HAZmAnn98gJlw?=
 =?us-ascii?Q?ct5G25+XblsSW74uqDf0G3NeIiAVb4w52Pki3zJ/fyt2IIjIh4beF8itfS01?=
 =?us-ascii?Q?3HaRUSs8tCK5NMqVsN8jQt2C1urjnPzq/RtwppQ4MH4Y3Sq2rWMXeA99LFuA?=
 =?us-ascii?Q?yfYjvBzvqsZHOdm0PBucJ9c0qwfYpYzZr7kxqb0YtGg4PLjxmCKasjarli6x?=
 =?us-ascii?Q?uf8t/6PC8g=3D=3D?=
X-Exchange-RoutingPolicyChecked: fNb5IiC422fhkuCEuP00W/dQpj9dsheAyaxhRzQvoqIUjqc5/8mzHAt7a6Y4XTYOUg4VtZxr/Kn5xf3wdGbvxJryPFcE7WINh9CvHc1hy/bkT9hgMZ4cJx1ISUGKvGzdcob8hHnY8vmh0UtFDh0LFAWqu8Z50g3ldh0vvHUNR18LrdNdkeOie+p8OAm2lXbJ+objyAqBpUfl6psS8kpUYfi5cehZckRm8expQ+wRGAMwchKLFEFZwfOb5gasIJ1nvBGGSbAkEhbBSt05M1EvxXvxCnIS9uV/y9rytOZd4U6NWQkIu9QD0yjMxzL/OxuawsGjom6k5zUYoOXrKd6LYg==
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f807e35-9592-4af1-439f-08de8c047113
X-MS-Exchange-CrossTenant-AuthSource: CYYPR11MB8430.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 13:26:24.0712 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YBc1Rx+ZEdChJI4J7YRnpmxsudSXNAJX/Hfc9EaERbcC5Z9jCWzZLFSqzkUkNy1R+ultlrnRLRv5CUYcPh7MSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB9807
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

On Thu, Mar 26, 2026 at 10:34:20PM -0700, Dixit, Ashutosh wrote:
> On Wed, 25 Mar 2026 01:38:51 -0700, Michal Wajdeczko wrote:
> >
> 
> Hi Michal,
> 
> > On 3/24/2026 10:17 PM, Dixit, Ashutosh wrote:
> > > On Sun, 15 Mar 2026 23:41:02 -0700, Satyanarayana K V P wrote:
> > >>
> > >> ---
> > >> V5 -> V6:
> > >> - Updated commit message.
> > >> - Return number of engines and memory regions as zero instead of returning
> > >> query size as zero (Michal Wajdeczko).
> > >> - Allow all other query IOCTLs excepts query_engines and query_mem_regions
> > >> (Michal Wajdeczko).
> > >
> > > Can someone explain the reason to move away from the approach in v5? Afais
> > > v6 has issues of this sort:
> > >
> > > * query_engines will return 0 engines but query_hwconfig will return > 0
> > >   engines
> >
> > but those are separate queries on purpose, right?
> > and I guess that even today there could be a mismatch between these numbers:
> >
> > * query_engines = engines available for use by the user software
> > * query_hwconfig.engines = report engines present on the hardware
> 
> OK, agreed.
> 
> >
> > > * query_engines will return 0 engines but query_oa_units will list out the
> > >   engines
> >
> > and that IMO should be considered as a desired outcome, as I guess (again)
> > that this will allow us to do some OA reporting, even if PF alone is not
> > submitting any workloads and we want to monitor how VFs are doing
> >
> > > * query_oa_units will return valid oa support but observation ioctl will
> > >   fail
> >
> > my initial idea [1] was to expose observation ioctl as well, maybe we need
> > to add it back?
> >
> > [1]
> > https://patchwork.freedesktop.org/patch/706445/?series=160349&rev=2#comment_1299475
> 
> OK, maybe I am thinking, we can expose the observation ioctl, though there
> are both pros and cons to doing this.
> 
> Pros: get some OA reporting out of the box. Though the tools etc. will
>       likely not work out of the box because of other missing
>       queries/ioctl's.
> 
> Cons: Not sure if it is ok to "snoop" on VF information out of the
>       box. Customers might insist this is not ok and insist on the
>       observation ioctl be removed. Also, on platforms on which OA is
>       supported in VF, there might be a conflict between OA in PF vs VF.
> 
> Also, even if we add the observation ioctl, only the base OA feature will
> work. But there are other OA features which require other ioctl's (say
> exec) which will not work in the admin-only-pf mode.
> 
> The other option is not add the OA ioctl. And insist that to get regular OA
> reporting/tools to work, the device must be unbound and rebound in the
> normal (non-admin-only) mode.
> 
> So we could go with either of these approaches. I am ok either way. Maybe
> just add the observation ioctl for now and revisit after feedback from
> customers/UMD's?

yes, that's probably the way to go since we still only have the oa in the PF.

In the future we might add a knob to steer where the oa is-or-not available.

> 
> Thanks.
> --
> Ashutosh
> 
> 
> 
> >
> > >
> > > v5 seems to have avoided contradictions of this sort. Or this doesn't
> > > matter? Thanks.
> >
> > but since I'm not using any of those ioctls on daily basis, I might be wrong
> >
